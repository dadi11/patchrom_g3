package android.hardware.input;

import android.content.Context;
import android.hardware.input.IInputDevicesChangedListener.Stub;
import android.media.AudioAttributes;
import android.media.tv.TvContract;
import android.os.Binder;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.Vibrator;
import android.provider.Settings.SettingNotFoundException;
import android.provider.Settings.System;
import android.util.Log;
import android.util.SparseArray;
import android.view.InputDevice;
import android.view.InputEvent;
import com.android.internal.util.ArrayUtils;
import java.util.ArrayList;

public final class InputManager {
    public static final String ACTION_QUERY_KEYBOARD_LAYOUTS = "android.hardware.input.action.QUERY_KEYBOARD_LAYOUTS";
    private static final boolean DEBUG = false;
    public static final int DEFAULT_POINTER_SPEED = 0;
    public static final int INJECT_INPUT_EVENT_MODE_ASYNC = 0;
    public static final int INJECT_INPUT_EVENT_MODE_WAIT_FOR_FINISH = 2;
    public static final int INJECT_INPUT_EVENT_MODE_WAIT_FOR_RESULT = 1;
    public static final int MAX_POINTER_SPEED = 7;
    public static final String META_DATA_KEYBOARD_LAYOUTS = "android.hardware.input.metadata.KEYBOARD_LAYOUTS";
    public static final int MIN_POINTER_SPEED = -7;
    private static final int MSG_DEVICE_ADDED = 1;
    private static final int MSG_DEVICE_CHANGED = 3;
    private static final int MSG_DEVICE_REMOVED = 2;
    private static final String TAG = "InputManager";
    private static InputManager sInstance;
    private final IInputManager mIm;
    private final ArrayList<InputDeviceListenerDelegate> mInputDeviceListeners;
    private SparseArray<InputDevice> mInputDevices;
    private InputDevicesChangedListener mInputDevicesChangedListener;
    private final Object mInputDevicesLock;

    public interface InputDeviceListener {
        void onInputDeviceAdded(int i);

        void onInputDeviceChanged(int i);

        void onInputDeviceRemoved(int i);
    }

    private static final class InputDeviceListenerDelegate extends Handler {
        public final InputDeviceListener mListener;

        public InputDeviceListenerDelegate(InputDeviceListener listener, Handler handler) {
            super(handler != null ? handler.getLooper() : Looper.myLooper());
            this.mListener = listener;
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case InputManager.MSG_DEVICE_ADDED /*1*/:
                    this.mListener.onInputDeviceAdded(msg.arg1);
                case InputManager.MSG_DEVICE_REMOVED /*2*/:
                    this.mListener.onInputDeviceRemoved(msg.arg1);
                case InputManager.MSG_DEVICE_CHANGED /*3*/:
                    this.mListener.onInputDeviceChanged(msg.arg1);
                default:
            }
        }
    }

    private final class InputDeviceVibrator extends Vibrator {
        private final int mDeviceId;
        private final Binder mToken;

        public InputDeviceVibrator(int deviceId) {
            this.mDeviceId = deviceId;
            this.mToken = new Binder();
        }

        public boolean hasVibrator() {
            return true;
        }

        public void vibrate(int uid, String opPkg, long milliseconds, AudioAttributes attributes) {
            long[] jArr = new long[InputManager.MSG_DEVICE_REMOVED];
            jArr[InputManager.INJECT_INPUT_EVENT_MODE_ASYNC] = 0;
            jArr[InputManager.MSG_DEVICE_ADDED] = milliseconds;
            vibrate(jArr, -1);
        }

        public void vibrate(int uid, String opPkg, long[] pattern, int repeat, AudioAttributes attributes) {
            if (repeat >= pattern.length) {
                throw new ArrayIndexOutOfBoundsException();
            }
            try {
                InputManager.this.mIm.vibrate(this.mDeviceId, pattern, repeat, this.mToken);
            } catch (RemoteException ex) {
                Log.w(InputManager.TAG, "Failed to vibrate.", ex);
            }
        }

        public void cancel() {
            try {
                InputManager.this.mIm.cancelVibrate(this.mDeviceId, this.mToken);
            } catch (RemoteException ex) {
                Log.w(InputManager.TAG, "Failed to cancel vibration.", ex);
            }
        }
    }

    private final class InputDevicesChangedListener extends Stub {
        private InputDevicesChangedListener() {
        }

        public void onInputDevicesChanged(int[] deviceIdAndGeneration) throws RemoteException {
            InputManager.this.onInputDevicesChanged(deviceIdAndGeneration);
        }
    }

    private InputManager(IInputManager im) {
        this.mInputDevicesLock = new Object();
        this.mInputDeviceListeners = new ArrayList();
        this.mIm = im;
    }

    public static InputManager getInstance() {
        InputManager inputManager;
        synchronized (InputManager.class) {
            if (sInstance == null) {
                sInstance = new InputManager(IInputManager.Stub.asInterface(ServiceManager.getService(TvContract.PARAM_INPUT)));
            }
            inputManager = sInstance;
        }
        return inputManager;
    }

    public InputDevice getInputDevice(int id) {
        InputDevice inputDevice;
        synchronized (this.mInputDevicesLock) {
            populateInputDevicesLocked();
            int index = this.mInputDevices.indexOfKey(id);
            if (index < 0) {
                inputDevice = null;
            } else {
                inputDevice = (InputDevice) this.mInputDevices.valueAt(index);
                if (inputDevice == null) {
                    try {
                        inputDevice = this.mIm.getInputDevice(id);
                        if (inputDevice != null) {
                            this.mInputDevices.setValueAt(index, inputDevice);
                        }
                    } catch (RemoteException ex) {
                        throw new RuntimeException("Could not get input device information.", ex);
                    }
                }
            }
        }
        return inputDevice;
    }

    public InputDevice getInputDeviceByDescriptor(String descriptor) {
        if (descriptor == null) {
            throw new IllegalArgumentException("descriptor must not be null.");
        }
        InputDevice inputDevice;
        synchronized (this.mInputDevicesLock) {
            populateInputDevicesLocked();
            int numDevices = this.mInputDevices.size();
            for (int i = INJECT_INPUT_EVENT_MODE_ASYNC; i < numDevices; i += MSG_DEVICE_ADDED) {
                inputDevice = (InputDevice) this.mInputDevices.valueAt(i);
                if (inputDevice == null) {
                    try {
                        inputDevice = this.mIm.getInputDevice(this.mInputDevices.keyAt(i));
                    } catch (RemoteException e) {
                    }
                    if (inputDevice == null) {
                        continue;
                    } else {
                        this.mInputDevices.setValueAt(i, inputDevice);
                    }
                }
                if (descriptor.equals(inputDevice.getDescriptor())) {
                    break;
                }
            }
            inputDevice = null;
        }
        return inputDevice;
    }

    public int[] getInputDeviceIds() {
        int[] ids;
        synchronized (this.mInputDevicesLock) {
            populateInputDevicesLocked();
            int count = this.mInputDevices.size();
            ids = new int[count];
            for (int i = INJECT_INPUT_EVENT_MODE_ASYNC; i < count; i += MSG_DEVICE_ADDED) {
                ids[i] = this.mInputDevices.keyAt(i);
            }
        }
        return ids;
    }

    public void registerInputDeviceListener(InputDeviceListener listener, Handler handler) {
        if (listener == null) {
            throw new IllegalArgumentException("listener must not be null");
        }
        synchronized (this.mInputDevicesLock) {
            if (findInputDeviceListenerLocked(listener) < 0) {
                this.mInputDeviceListeners.add(new InputDeviceListenerDelegate(listener, handler));
            }
        }
    }

    public void unregisterInputDeviceListener(InputDeviceListener listener) {
        if (listener == null) {
            throw new IllegalArgumentException("listener must not be null");
        }
        synchronized (this.mInputDevicesLock) {
            int index = findInputDeviceListenerLocked(listener);
            if (index >= 0) {
                ((InputDeviceListenerDelegate) this.mInputDeviceListeners.get(index)).removeCallbacksAndMessages(null);
                this.mInputDeviceListeners.remove(index);
            }
        }
    }

    private int findInputDeviceListenerLocked(InputDeviceListener listener) {
        int numListeners = this.mInputDeviceListeners.size();
        for (int i = INJECT_INPUT_EVENT_MODE_ASYNC; i < numListeners; i += MSG_DEVICE_ADDED) {
            if (((InputDeviceListenerDelegate) this.mInputDeviceListeners.get(i)).mListener == listener) {
                return i;
            }
        }
        return -1;
    }

    public KeyboardLayout[] getKeyboardLayouts() {
        try {
            return this.mIm.getKeyboardLayouts();
        } catch (RemoteException ex) {
            Log.w(TAG, "Could not get list of keyboard layout informations.", ex);
            return new KeyboardLayout[INJECT_INPUT_EVENT_MODE_ASYNC];
        }
    }

    public KeyboardLayout getKeyboardLayout(String keyboardLayoutDescriptor) {
        if (keyboardLayoutDescriptor == null) {
            throw new IllegalArgumentException("keyboardLayoutDescriptor must not be null");
        }
        try {
            return this.mIm.getKeyboardLayout(keyboardLayoutDescriptor);
        } catch (RemoteException ex) {
            Log.w(TAG, "Could not get keyboard layout information.", ex);
            return null;
        }
    }

    public String getCurrentKeyboardLayoutForInputDevice(InputDeviceIdentifier identifier) {
        try {
            return this.mIm.getCurrentKeyboardLayoutForInputDevice(identifier);
        } catch (RemoteException ex) {
            Log.w(TAG, "Could not get current keyboard layout for input device.", ex);
            return null;
        }
    }

    public void setCurrentKeyboardLayoutForInputDevice(InputDeviceIdentifier identifier, String keyboardLayoutDescriptor) {
        if (identifier == null) {
            throw new IllegalArgumentException("identifier must not be null");
        } else if (keyboardLayoutDescriptor == null) {
            throw new IllegalArgumentException("keyboardLayoutDescriptor must not be null");
        } else {
            try {
                this.mIm.setCurrentKeyboardLayoutForInputDevice(identifier, keyboardLayoutDescriptor);
            } catch (RemoteException ex) {
                Log.w(TAG, "Could not set current keyboard layout for input device.", ex);
            }
        }
    }

    public String[] getKeyboardLayoutsForInputDevice(InputDeviceIdentifier identifier) {
        if (identifier == null) {
            throw new IllegalArgumentException("inputDeviceDescriptor must not be null");
        }
        try {
            return this.mIm.getKeyboardLayoutsForInputDevice(identifier);
        } catch (RemoteException ex) {
            Log.w(TAG, "Could not get keyboard layouts for input device.", ex);
            return (String[]) ArrayUtils.emptyArray(String.class);
        }
    }

    public void addKeyboardLayoutForInputDevice(InputDeviceIdentifier identifier, String keyboardLayoutDescriptor) {
        if (identifier == null) {
            throw new IllegalArgumentException("inputDeviceDescriptor must not be null");
        } else if (keyboardLayoutDescriptor == null) {
            throw new IllegalArgumentException("keyboardLayoutDescriptor must not be null");
        } else {
            try {
                this.mIm.addKeyboardLayoutForInputDevice(identifier, keyboardLayoutDescriptor);
            } catch (RemoteException ex) {
                Log.w(TAG, "Could not add keyboard layout for input device.", ex);
            }
        }
    }

    public void removeKeyboardLayoutForInputDevice(InputDeviceIdentifier identifier, String keyboardLayoutDescriptor) {
        if (identifier == null) {
            throw new IllegalArgumentException("inputDeviceDescriptor must not be null");
        } else if (keyboardLayoutDescriptor == null) {
            throw new IllegalArgumentException("keyboardLayoutDescriptor must not be null");
        } else {
            try {
                this.mIm.removeKeyboardLayoutForInputDevice(identifier, keyboardLayoutDescriptor);
            } catch (RemoteException ex) {
                Log.w(TAG, "Could not remove keyboard layout for input device.", ex);
            }
        }
    }

    public TouchCalibration getTouchCalibration(String inputDeviceDescriptor, int surfaceRotation) {
        try {
            return this.mIm.getTouchCalibrationForInputDevice(inputDeviceDescriptor, surfaceRotation);
        } catch (RemoteException ex) {
            Log.w(TAG, "Could not get calibration matrix for input device.", ex);
            return TouchCalibration.IDENTITY;
        }
    }

    public void setTouchCalibration(String inputDeviceDescriptor, int surfaceRotation, TouchCalibration calibration) {
        try {
            this.mIm.setTouchCalibrationForInputDevice(inputDeviceDescriptor, surfaceRotation, calibration);
        } catch (RemoteException ex) {
            Log.w(TAG, "Could not set calibration matrix for input device.", ex);
        }
    }

    public int getPointerSpeed(Context context) {
        int speed = INJECT_INPUT_EVENT_MODE_ASYNC;
        try {
            speed = System.getInt(context.getContentResolver(), "pointer_speed");
        } catch (SettingNotFoundException e) {
        }
        return speed;
    }

    public void setPointerSpeed(Context context, int speed) {
        if (speed < MIN_POINTER_SPEED || speed > MAX_POINTER_SPEED) {
            throw new IllegalArgumentException("speed out of range");
        }
        System.putInt(context.getContentResolver(), "pointer_speed", speed);
    }

    public void tryPointerSpeed(int speed) {
        if (speed < MIN_POINTER_SPEED || speed > MAX_POINTER_SPEED) {
            throw new IllegalArgumentException("speed out of range");
        }
        try {
            this.mIm.tryPointerSpeed(speed);
        } catch (RemoteException ex) {
            Log.w(TAG, "Could not set temporary pointer speed.", ex);
        }
    }

    public boolean[] deviceHasKeys(int[] keyCodes) {
        return deviceHasKeys(-1, keyCodes);
    }

    public boolean[] deviceHasKeys(int id, int[] keyCodes) {
        boolean[] ret = new boolean[keyCodes.length];
        try {
            this.mIm.hasKeys(id, InputDevice.SOURCE_ANY, keyCodes, ret);
        } catch (RemoteException e) {
        }
        return ret;
    }

    public boolean injectInputEvent(InputEvent event, int mode) {
        if (event == null) {
            throw new IllegalArgumentException("event must not be null");
        } else if (mode == 0 || mode == MSG_DEVICE_REMOVED || mode == MSG_DEVICE_ADDED) {
            try {
                return this.mIm.injectInputEvent(event, mode);
            } catch (RemoteException e) {
                return DEBUG;
            }
        } else {
            throw new IllegalArgumentException("mode is invalid");
        }
    }

    private void populateInputDevicesLocked() {
        if (this.mInputDevicesChangedListener == null) {
            InputDevicesChangedListener listener = new InputDevicesChangedListener();
            try {
                this.mIm.registerInputDevicesChangedListener(listener);
                this.mInputDevicesChangedListener = listener;
            } catch (RemoteException ex) {
                throw new RuntimeException("Could not get register input device changed listener", ex);
            }
        }
        if (this.mInputDevices == null) {
            try {
                int[] ids = this.mIm.getInputDeviceIds();
                this.mInputDevices = new SparseArray();
                for (int i = INJECT_INPUT_EVENT_MODE_ASYNC; i < ids.length; i += MSG_DEVICE_ADDED) {
                    this.mInputDevices.put(ids[i], null);
                }
            } catch (RemoteException ex2) {
                throw new RuntimeException("Could not get input device ids.", ex2);
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void onInputDevicesChanged(int[] r9) {
        /*
        r8 = this;
        r6 = r8.mInputDevicesLock;
        monitor-enter(r6);
        r5 = r8.mInputDevices;	 Catch:{ all -> 0x0023 }
        r3 = r5.size();	 Catch:{ all -> 0x0023 }
    L_0x0009:
        r3 = r3 + -1;
        if (r3 <= 0) goto L_0x0026;
    L_0x000d:
        r5 = r8.mInputDevices;	 Catch:{ all -> 0x0023 }
        r1 = r5.keyAt(r3);	 Catch:{ all -> 0x0023 }
        r5 = containsDeviceId(r9, r1);	 Catch:{ all -> 0x0023 }
        if (r5 != 0) goto L_0x0009;
    L_0x0019:
        r5 = r8.mInputDevices;	 Catch:{ all -> 0x0023 }
        r5.removeAt(r3);	 Catch:{ all -> 0x0023 }
        r5 = 2;
        r8.sendMessageToInputDeviceListenersLocked(r5, r1);	 Catch:{ all -> 0x0023 }
        goto L_0x0009;
    L_0x0023:
        r5 = move-exception;
        monitor-exit(r6);	 Catch:{ all -> 0x0023 }
        throw r5;
    L_0x0026:
        r3 = 0;
    L_0x0027:
        r5 = r9.length;	 Catch:{ all -> 0x0023 }
        if (r3 >= r5) goto L_0x0060;
    L_0x002a:
        r1 = r9[r3];	 Catch:{ all -> 0x0023 }
        r5 = r8.mInputDevices;	 Catch:{ all -> 0x0023 }
        r4 = r5.indexOfKey(r1);	 Catch:{ all -> 0x0023 }
        if (r4 < 0) goto L_0x0055;
    L_0x0034:
        r5 = r8.mInputDevices;	 Catch:{ all -> 0x0023 }
        r0 = r5.valueAt(r4);	 Catch:{ all -> 0x0023 }
        r0 = (android.view.InputDevice) r0;	 Catch:{ all -> 0x0023 }
        if (r0 == 0) goto L_0x0052;
    L_0x003e:
        r5 = r3 + 1;
        r2 = r9[r5];	 Catch:{ all -> 0x0023 }
        r5 = r0.getGeneration();	 Catch:{ all -> 0x0023 }
        if (r5 == r2) goto L_0x0052;
    L_0x0048:
        r5 = r8.mInputDevices;	 Catch:{ all -> 0x0023 }
        r7 = 0;
        r5.setValueAt(r4, r7);	 Catch:{ all -> 0x0023 }
        r5 = 3;
        r8.sendMessageToInputDeviceListenersLocked(r5, r1);	 Catch:{ all -> 0x0023 }
    L_0x0052:
        r3 = r3 + 2;
        goto L_0x0027;
    L_0x0055:
        r5 = r8.mInputDevices;	 Catch:{ all -> 0x0023 }
        r7 = 0;
        r5.put(r1, r7);	 Catch:{ all -> 0x0023 }
        r5 = 1;
        r8.sendMessageToInputDeviceListenersLocked(r5, r1);	 Catch:{ all -> 0x0023 }
        goto L_0x0052;
    L_0x0060:
        monitor-exit(r6);	 Catch:{ all -> 0x0023 }
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.hardware.input.InputManager.onInputDevicesChanged(int[]):void");
    }

    private void sendMessageToInputDeviceListenersLocked(int what, int deviceId) {
        int numListeners = this.mInputDeviceListeners.size();
        for (int i = INJECT_INPUT_EVENT_MODE_ASYNC; i < numListeners; i += MSG_DEVICE_ADDED) {
            InputDeviceListenerDelegate listener = (InputDeviceListenerDelegate) this.mInputDeviceListeners.get(i);
            listener.sendMessage(listener.obtainMessage(what, deviceId, INJECT_INPUT_EVENT_MODE_ASYNC));
        }
    }

    private static boolean containsDeviceId(int[] deviceIdAndGeneration, int deviceId) {
        for (int i = INJECT_INPUT_EVENT_MODE_ASYNC; i < deviceIdAndGeneration.length; i += MSG_DEVICE_REMOVED) {
            if (deviceIdAndGeneration[i] == deviceId) {
                return true;
            }
        }
        return DEBUG;
    }

    public Vibrator getInputDeviceVibrator(int deviceId) {
        return new InputDeviceVibrator(deviceId);
    }
}
