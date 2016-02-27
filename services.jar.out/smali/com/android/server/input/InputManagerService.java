package com.android.server.input;

import android.app.Notification.Builder;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.bluetooth.BluetoothAdapter;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.ResolveInfo;
import android.content.res.Resources;
import android.content.res.Resources.NotFoundException;
import android.content.res.TypedArray;
import android.content.res.XmlResourceParser;
import android.database.ContentObserver;
import android.hardware.display.DisplayViewport;
import android.hardware.input.IInputDevicesChangedListener;
import android.hardware.input.IInputManager.Stub;
import android.hardware.input.InputDeviceIdentifier;
import android.hardware.input.InputManagerInternal;
import android.hardware.input.KeyboardLayout;
import android.hardware.input.TouchCalibration;
import android.os.Binder;
import android.os.Bundle;
import android.os.Environment;
import android.os.Handler;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.Looper;
import android.os.Message;
import android.os.MessageQueue;
import android.os.Process;
import android.os.RemoteException;
import android.os.UserHandle;
import android.provider.Settings.SettingNotFoundException;
import android.provider.Settings.System;
import android.util.Log;
import android.util.Slog;
import android.util.SparseArray;
import android.util.Xml;
import android.view.IInputFilter;
import android.view.IInputFilterHost;
import android.view.InputChannel;
import android.view.InputDevice;
import android.view.InputEvent;
import android.view.KeyEvent;
import android.view.PointerIcon;
import android.view.ViewConfiguration;
import android.widget.Toast;
import com.android.internal.R;
import com.android.internal.util.XmlUtils;
import com.android.server.DisplayThread;
import com.android.server.LocalServices;
import com.android.server.Watchdog;
import com.android.server.Watchdog.Monitor;
import java.io.File;
import java.io.FileDescriptor;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import libcore.io.Streams;
import libcore.util.Objects;
import org.xmlpull.v1.XmlPullParser;

public class InputManagerService extends Stub implements Monitor {
    public static final int BTN_MOUSE = 272;
    static final boolean DEBUG = false;
    private static final String EXCLUDED_DEVICES_PATH = "etc/excluded-input-devices.xml";
    private static final int INJECTION_TIMEOUT_MILLIS = 30000;
    private static final int INPUT_EVENT_INJECTION_FAILED = 2;
    private static final int INPUT_EVENT_INJECTION_PERMISSION_DENIED = 1;
    private static final int INPUT_EVENT_INJECTION_SUCCEEDED = 0;
    private static final int INPUT_EVENT_INJECTION_TIMED_OUT = 3;
    public static final int KEY_STATE_DOWN = 1;
    public static final int KEY_STATE_UNKNOWN = -1;
    public static final int KEY_STATE_UP = 0;
    public static final int KEY_STATE_VIRTUAL = 2;
    private static final int MSG_DELIVER_INPUT_DEVICES_CHANGED = 1;
    private static final int MSG_RELOAD_DEVICE_ALIASES = 5;
    private static final int MSG_RELOAD_KEYBOARD_LAYOUTS = 3;
    private static final int MSG_SWITCH_KEYBOARD_LAYOUT = 2;
    private static final int MSG_UPDATE_KEYBOARD_LAYOUTS = 4;
    public static final int SW_CAMERA_LENS_COVER = 9;
    public static final int SW_CAMERA_LENS_COVER_BIT = 512;
    public static final int SW_HEADPHONE_INSERT = 2;
    public static final int SW_HEADPHONE_INSERT_BIT = 4;
    public static final int SW_JACK_BITS = 212;
    public static final int SW_JACK_PHYSICAL_INSERT = 7;
    public static final int SW_JACK_PHYSICAL_INSERT_BIT = 128;
    public static final int SW_KEYPAD_SLIDE = 10;
    public static final int SW_KEYPAD_SLIDE_BIT = 1024;
    public static final int SW_LID = 0;
    public static final int SW_LID_BIT = 1;
    public static final int SW_LINEOUT_INSERT = 6;
    public static final int SW_LINEOUT_INSERT_BIT = 64;
    public static final int SW_MICROPHONE_INSERT = 4;
    public static final int SW_MICROPHONE_INSERT_BIT = 16;
    static final String TAG = "InputManager";
    private final Context mContext;
    private final PersistentDataStore mDataStore;
    private final InputManagerHandler mHandler;
    private InputDevice[] mInputDevices;
    private final SparseArray<InputDevicesChangedListenerRecord> mInputDevicesChangedListeners;
    private boolean mInputDevicesChangedPending;
    private Object mInputDevicesLock;
    IInputFilter mInputFilter;
    InputFilterHost mInputFilterHost;
    final Object mInputFilterLock;
    private PendingIntent mKeyboardLayoutIntent;
    private boolean mKeyboardLayoutNotificationShown;
    private int mNextVibratorTokenValue;
    private NotificationManager mNotificationManager;
    private final long mPtr;
    private Toast mSwitchedKeyboardLayoutToast;
    private boolean mSystemReady;
    private final ArrayList<InputDevice> mTempFullKeyboards;
    private final ArrayList<InputDevicesChangedListenerRecord> mTempInputDevicesChangedListenersToNotify;
    final boolean mUseDevInputEventForAudioJack;
    private Object mVibratorLock;
    private HashMap<IBinder, VibratorToken> mVibratorTokens;
    private WindowManagerCallbacks mWindowManagerCallbacks;
    private WiredAccessoryCallbacks mWiredAccessoryCallbacks;

    public interface WiredAccessoryCallbacks {
        void notifyWiredAccessoryChanged(long j, int i, int i2);

        void systemReady();
    }

    /* renamed from: com.android.server.input.InputManagerService.1 */
    class C03221 extends BroadcastReceiver {
        C03221() {
        }

        public void onReceive(Context context, Intent intent) {
            InputManagerService.this.updatePointerSpeedFromSettings();
            InputManagerService.this.updateShowTouchesFromSettings();
        }
    }

    /* renamed from: com.android.server.input.InputManagerService.2 */
    class C03232 extends BroadcastReceiver {
        C03232() {
        }

        public void onReceive(Context context, Intent intent) {
            InputManagerService.this.updateKeyboardLayouts();
        }
    }

    /* renamed from: com.android.server.input.InputManagerService.3 */
    class C03243 extends BroadcastReceiver {
        C03243() {
        }

        public void onReceive(Context context, Intent intent) {
            InputManagerService.this.reloadDeviceAliases();
        }
    }

    private interface KeyboardLayoutVisitor {
        void visitKeyboardLayout(Resources resources, String str, String str2, String str3, int i, int i2);
    }

    /* renamed from: com.android.server.input.InputManagerService.4 */
    class C03254 implements KeyboardLayoutVisitor {
        final /* synthetic */ HashSet val$availableKeyboardLayouts;

        C03254(HashSet hashSet) {
            this.val$availableKeyboardLayouts = hashSet;
        }

        public void visitKeyboardLayout(Resources resources, String descriptor, String label, String collection, int keyboardLayoutResId, int priority) {
            this.val$availableKeyboardLayouts.add(descriptor);
        }
    }

    /* renamed from: com.android.server.input.InputManagerService.5 */
    class C03265 implements KeyboardLayoutVisitor {
        final /* synthetic */ ArrayList val$list;

        C03265(ArrayList arrayList) {
            this.val$list = arrayList;
        }

        public void visitKeyboardLayout(Resources resources, String descriptor, String label, String collection, int keyboardLayoutResId, int priority) {
            this.val$list.add(new KeyboardLayout(descriptor, label, collection, priority));
        }
    }

    /* renamed from: com.android.server.input.InputManagerService.6 */
    class C03276 implements KeyboardLayoutVisitor {
        final /* synthetic */ KeyboardLayout[] val$result;

        C03276(KeyboardLayout[] keyboardLayoutArr) {
            this.val$result = keyboardLayoutArr;
        }

        public void visitKeyboardLayout(Resources resources, String descriptor, String label, String collection, int keyboardLayoutResId, int priority) {
            this.val$result[InputManagerService.SW_LID] = new KeyboardLayout(descriptor, label, collection, priority);
        }
    }

    /* renamed from: com.android.server.input.InputManagerService.7 */
    class C03287 extends ContentObserver {
        C03287(Handler x0) {
            super(x0);
        }

        public void onChange(boolean selfChange) {
            InputManagerService.this.updatePointerSpeedFromSettings();
        }
    }

    /* renamed from: com.android.server.input.InputManagerService.8 */
    class C03298 extends ContentObserver {
        C03298(Handler x0) {
            super(x0);
        }

        public void onChange(boolean selfChange) {
            InputManagerService.this.updateShowTouchesFromSettings();
        }
    }

    /* renamed from: com.android.server.input.InputManagerService.9 */
    class C03309 implements KeyboardLayoutVisitor {
        final /* synthetic */ String[] val$result;

        C03309(String[] strArr) {
            this.val$result = strArr;
        }

        public void visitKeyboardLayout(Resources resources, String descriptor, String label, String collection, int keyboardLayoutResId, int priority) {
            try {
                this.val$result[InputManagerService.SW_LID] = descriptor;
                this.val$result[InputManagerService.SW_LID_BIT] = Streams.readFully(new InputStreamReader(resources.openRawResource(keyboardLayoutResId)));
            } catch (IOException e) {
            } catch (NotFoundException e2) {
            }
        }
    }

    private final class InputDevicesChangedListenerRecord implements DeathRecipient {
        private final IInputDevicesChangedListener mListener;
        private final int mPid;

        public InputDevicesChangedListenerRecord(int pid, IInputDevicesChangedListener listener) {
            this.mPid = pid;
            this.mListener = listener;
        }

        public void binderDied() {
            InputManagerService.this.onInputDevicesChangedListenerDied(this.mPid);
        }

        public void notifyInputDevicesChanged(int[] info) {
            try {
                this.mListener.onInputDevicesChanged(info);
            } catch (RemoteException ex) {
                Slog.w(InputManagerService.TAG, "Failed to notify process " + this.mPid + " that input devices changed, assuming it died.", ex);
                binderDied();
            }
        }
    }

    private final class InputFilterHost extends IInputFilterHost.Stub {
        private boolean mDisconnected;

        private InputFilterHost() {
        }

        public void disconnectLocked() {
            this.mDisconnected = true;
        }

        public void sendInputEvent(InputEvent event, int policyFlags) {
            if (event == null) {
                throw new IllegalArgumentException("event must not be null");
            }
            synchronized (InputManagerService.this.mInputFilterLock) {
                if (!this.mDisconnected) {
                    InputManagerService.nativeInjectInputEvent(InputManagerService.this.mPtr, event, InputManagerService.SW_LID, InputManagerService.SW_LID, InputManagerService.SW_LID, InputManagerService.SW_LID, InputManagerService.SW_LID, policyFlags | 67108864);
                }
            }
        }
    }

    private final class InputManagerHandler extends Handler {
        public InputManagerHandler(Looper looper) {
            super(looper, null, true);
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case InputManagerService.SW_LID_BIT /*1*/:
                    InputManagerService.this.deliverInputDevicesChanged((InputDevice[]) msg.obj);
                case InputManagerService.SW_HEADPHONE_INSERT /*2*/:
                    InputManagerService.this.handleSwitchKeyboardLayout(msg.arg1, msg.arg2);
                case InputManagerService.MSG_RELOAD_KEYBOARD_LAYOUTS /*3*/:
                    InputManagerService.this.reloadKeyboardLayouts();
                case InputManagerService.SW_MICROPHONE_INSERT /*4*/:
                    InputManagerService.this.updateKeyboardLayouts();
                case InputManagerService.MSG_RELOAD_DEVICE_ALIASES /*5*/:
                    InputManagerService.this.reloadDeviceAliases();
                default:
            }
        }
    }

    private static final class KeyboardLayoutDescriptor {
        public String keyboardLayoutName;
        public String packageName;
        public String receiverName;

        private KeyboardLayoutDescriptor() {
        }

        public static String format(String packageName, String receiverName, String keyboardName) {
            return packageName + "/" + receiverName + "/" + keyboardName;
        }

        public static KeyboardLayoutDescriptor parse(String descriptor) {
            int pos = descriptor.indexOf(47);
            if (pos < 0 || pos + InputManagerService.SW_LID_BIT == descriptor.length()) {
                return null;
            }
            int pos2 = descriptor.indexOf(47, pos + InputManagerService.SW_LID_BIT);
            if (pos2 < pos + InputManagerService.SW_HEADPHONE_INSERT || pos2 + InputManagerService.SW_LID_BIT == descriptor.length()) {
                return null;
            }
            KeyboardLayoutDescriptor result = new KeyboardLayoutDescriptor();
            result.packageName = descriptor.substring(InputManagerService.SW_LID, pos);
            result.receiverName = descriptor.substring(pos + InputManagerService.SW_LID_BIT, pos2);
            result.keyboardLayoutName = descriptor.substring(pos2 + InputManagerService.SW_LID_BIT);
            return result;
        }
    }

    private final class LocalService extends InputManagerInternal {
        private LocalService() {
        }

        public void setDisplayViewports(DisplayViewport defaultViewport, DisplayViewport externalTouchViewport) {
            InputManagerService.this.setDisplayViewportsInternal(defaultViewport, externalTouchViewport);
        }

        public boolean injectInputEvent(InputEvent event, int displayId, int mode) {
            return InputManagerService.this.injectInputEventInternal(event, displayId, mode);
        }

        public void setInteractive(boolean interactive) {
            InputManagerService.nativeSetInteractive(InputManagerService.this.mPtr, interactive);
        }
    }

    private final class VibratorToken implements DeathRecipient {
        public final int mDeviceId;
        public final IBinder mToken;
        public final int mTokenValue;
        public boolean mVibrating;

        public VibratorToken(int deviceId, IBinder token, int tokenValue) {
            this.mDeviceId = deviceId;
            this.mToken = token;
            this.mTokenValue = tokenValue;
        }

        public void binderDied() {
            InputManagerService.this.onVibratorTokenDied(this);
        }
    }

    public interface WindowManagerCallbacks {
        KeyEvent dispatchUnhandledKey(InputWindowHandle inputWindowHandle, KeyEvent keyEvent, int i);

        int getPointerLayer();

        long interceptKeyBeforeDispatching(InputWindowHandle inputWindowHandle, KeyEvent keyEvent, int i);

        int interceptKeyBeforeQueueing(KeyEvent keyEvent, int i);

        int interceptMotionBeforeQueueingNonInteractive(long j, int i);

        long notifyANR(InputApplicationHandle inputApplicationHandle, InputWindowHandle inputWindowHandle, String str);

        void notifyCameraLensCoverSwitchChanged(long j, boolean z);

        void notifyConfigurationChanged();

        void notifyInputChannelBroken(InputWindowHandle inputWindowHandle);

        void notifyLidSwitchChanged(long j, boolean z);
    }

    private static native void nativeCancelVibrate(long j, int i, int i2);

    private static native String nativeDump(long j);

    private static native int nativeGetKeyCodeState(long j, int i, int i2, int i3);

    private static native int nativeGetScanCodeState(long j, int i, int i2, int i3);

    private static native int nativeGetSwitchState(long j, int i, int i2, int i3);

    private static native boolean nativeHasKeys(long j, int i, int i2, int[] iArr, boolean[] zArr);

    private static native long nativeInit(InputManagerService inputManagerService, Context context, MessageQueue messageQueue);

    private static native int nativeInjectInputEvent(long j, InputEvent inputEvent, int i, int i2, int i3, int i4, int i5, int i6);

    private static native void nativeMonitor(long j);

    private static native void nativeRegisterInputChannel(long j, InputChannel inputChannel, InputWindowHandle inputWindowHandle, boolean z);

    private static native void nativeReloadCalibration(long j);

    private static native void nativeReloadDeviceAliases(long j);

    private static native void nativeReloadKeyboardLayouts(long j);

    private static native void nativeSetDisplayViewport(long j, boolean z, int i, int i2, int i3, int i4, int i5, int i6, int i7, int i8, int i9, int i10, int i11, int i12);

    private static native void nativeSetFocusedApplication(long j, InputApplicationHandle inputApplicationHandle);

    private static native void nativeSetInputDispatchMode(long j, boolean z, boolean z2);

    private static native void nativeSetInputFilterEnabled(long j, boolean z);

    private static native void nativeSetInputWindows(long j, InputWindowHandle[] inputWindowHandleArr);

    private static native void nativeSetInteractive(long j, boolean z);

    private static native void nativeSetPointerSpeed(long j, int i);

    private static native void nativeSetShowTouches(long j, boolean z);

    private static native void nativeSetSystemUiVisibility(long j, int i);

    private static native void nativeStart(long j);

    private static native boolean nativeTransferTouchFocus(long j, InputChannel inputChannel, InputChannel inputChannel2);

    private static native void nativeUnregisterInputChannel(long j, InputChannel inputChannel);

    private static native void nativeVibrate(long j, int i, long[] jArr, int i2, int i3);

    public InputManagerService(Context context) {
        this.mDataStore = new PersistentDataStore();
        this.mInputDevicesLock = new Object();
        this.mInputDevices = new InputDevice[SW_LID];
        this.mInputDevicesChangedListeners = new SparseArray();
        this.mTempInputDevicesChangedListenersToNotify = new ArrayList();
        this.mTempFullKeyboards = new ArrayList();
        this.mVibratorLock = new Object();
        this.mVibratorTokens = new HashMap();
        this.mInputFilterLock = new Object();
        this.mContext = context;
        this.mHandler = new InputManagerHandler(DisplayThread.get().getLooper());
        this.mUseDevInputEventForAudioJack = context.getResources().getBoolean(17956977);
        Slog.i(TAG, "Initializing input manager, mUseDevInputEventForAudioJack=" + this.mUseDevInputEventForAudioJack);
        this.mPtr = nativeInit(this, this.mContext, this.mHandler.getLooper().getQueue());
        LocalServices.addService(InputManagerInternal.class, new LocalService());
    }

    public void setWindowManagerCallbacks(WindowManagerCallbacks callbacks) {
        this.mWindowManagerCallbacks = callbacks;
    }

    public void setWiredAccessoryCallbacks(WiredAccessoryCallbacks callbacks) {
        this.mWiredAccessoryCallbacks = callbacks;
    }

    public void start() {
        Slog.i(TAG, "Starting input manager");
        nativeStart(this.mPtr);
        Watchdog.getInstance().addMonitor(this);
        registerPointerSpeedSettingObserver();
        registerShowTouchesSettingObserver();
        this.mContext.registerReceiver(new C03221(), new IntentFilter("android.intent.action.USER_SWITCHED"), null, this.mHandler);
        updatePointerSpeedFromSettings();
        updateShowTouchesFromSettings();
    }

    public void systemRunning() {
        this.mNotificationManager = (NotificationManager) this.mContext.getSystemService("notification");
        this.mSystemReady = true;
        IntentFilter filter = new IntentFilter("android.intent.action.PACKAGE_ADDED");
        filter.addAction("android.intent.action.PACKAGE_REMOVED");
        filter.addAction("android.intent.action.PACKAGE_CHANGED");
        filter.addAction("android.intent.action.PACKAGE_REPLACED");
        filter.addDataScheme("package");
        this.mContext.registerReceiver(new C03232(), filter, null, this.mHandler);
        this.mContext.registerReceiver(new C03243(), new IntentFilter("android.bluetooth.device.action.ALIAS_CHANGED"), null, this.mHandler);
        this.mHandler.sendEmptyMessage(MSG_RELOAD_DEVICE_ALIASES);
        this.mHandler.sendEmptyMessage(SW_MICROPHONE_INSERT);
        if (this.mWiredAccessoryCallbacks != null) {
            this.mWiredAccessoryCallbacks.systemReady();
        }
    }

    private void reloadKeyboardLayouts() {
        nativeReloadKeyboardLayouts(this.mPtr);
    }

    private void reloadDeviceAliases() {
        nativeReloadDeviceAliases(this.mPtr);
    }

    private void setDisplayViewportsInternal(DisplayViewport defaultViewport, DisplayViewport externalTouchViewport) {
        if (defaultViewport.valid) {
            setDisplayViewport(DEBUG, defaultViewport);
        }
        if (externalTouchViewport.valid) {
            setDisplayViewport(true, externalTouchViewport);
        } else if (defaultViewport.valid) {
            setDisplayViewport(true, defaultViewport);
        }
    }

    private void setDisplayViewport(boolean external, DisplayViewport viewport) {
        boolean z = external;
        nativeSetDisplayViewport(this.mPtr, z, viewport.displayId, viewport.orientation, viewport.logicalFrame.left, viewport.logicalFrame.top, viewport.logicalFrame.right, viewport.logicalFrame.bottom, viewport.physicalFrame.left, viewport.physicalFrame.top, viewport.physicalFrame.right, viewport.physicalFrame.bottom, viewport.deviceWidth, viewport.deviceHeight);
    }

    public int getKeyCodeState(int deviceId, int sourceMask, int keyCode) {
        return nativeGetKeyCodeState(this.mPtr, deviceId, sourceMask, keyCode);
    }

    public int getScanCodeState(int deviceId, int sourceMask, int scanCode) {
        return nativeGetScanCodeState(this.mPtr, deviceId, sourceMask, scanCode);
    }

    public int getSwitchState(int deviceId, int sourceMask, int switchCode) {
        return nativeGetSwitchState(this.mPtr, deviceId, sourceMask, switchCode);
    }

    public boolean hasKeys(int deviceId, int sourceMask, int[] keyCodes, boolean[] keyExists) {
        if (keyCodes == null) {
            throw new IllegalArgumentException("keyCodes must not be null.");
        } else if (keyExists != null && keyExists.length >= keyCodes.length) {
            return nativeHasKeys(this.mPtr, deviceId, sourceMask, keyCodes, keyExists);
        } else {
            throw new IllegalArgumentException("keyExists must not be null and must be at least as large as keyCodes.");
        }
    }

    public InputChannel monitorInput(String inputChannelName) {
        if (inputChannelName == null) {
            throw new IllegalArgumentException("inputChannelName must not be null.");
        }
        InputChannel[] inputChannels = InputChannel.openInputChannelPair(inputChannelName);
        nativeRegisterInputChannel(this.mPtr, inputChannels[SW_LID], null, true);
        inputChannels[SW_LID].dispose();
        return inputChannels[SW_LID_BIT];
    }

    public void registerInputChannel(InputChannel inputChannel, InputWindowHandle inputWindowHandle) {
        if (inputChannel == null) {
            throw new IllegalArgumentException("inputChannel must not be null.");
        }
        nativeRegisterInputChannel(this.mPtr, inputChannel, inputWindowHandle, DEBUG);
    }

    public void unregisterInputChannel(InputChannel inputChannel) {
        if (inputChannel == null) {
            throw new IllegalArgumentException("inputChannel must not be null.");
        }
        nativeUnregisterInputChannel(this.mPtr, inputChannel);
    }

    public void setInputFilter(IInputFilter filter) {
        synchronized (this.mInputFilterLock) {
            IInputFilter oldFilter = this.mInputFilter;
            if (oldFilter == filter) {
                return;
            }
            if (oldFilter != null) {
                this.mInputFilter = null;
                this.mInputFilterHost.disconnectLocked();
                this.mInputFilterHost = null;
                try {
                    oldFilter.uninstall();
                } catch (RemoteException e) {
                }
            }
            if (filter != null) {
                this.mInputFilter = filter;
                this.mInputFilterHost = new InputFilterHost();
                try {
                    filter.install(this.mInputFilterHost);
                } catch (RemoteException e2) {
                }
            }
            nativeSetInputFilterEnabled(this.mPtr, filter != null ? true : DEBUG);
        }
    }

    public boolean injectInputEvent(InputEvent event, int mode) {
        return injectInputEventInternal(event, SW_LID, mode);
    }

    private boolean injectInputEventInternal(InputEvent event, int displayId, int mode) {
        if (event == null) {
            throw new IllegalArgumentException("event must not be null");
        } else if (mode == 0 || mode == SW_HEADPHONE_INSERT || mode == SW_LID_BIT) {
            int pid = Binder.getCallingPid();
            int uid = Binder.getCallingUid();
            long ident = Binder.clearCallingIdentity();
            try {
                int result = nativeInjectInputEvent(this.mPtr, event, displayId, pid, uid, mode, INJECTION_TIMEOUT_MILLIS, 134217728);
                switch (result) {
                    case SW_LID /*0*/:
                        return true;
                    case SW_LID_BIT /*1*/:
                        Slog.w(TAG, "Input event injection from pid " + pid + " permission denied.");
                        throw new SecurityException("Injecting to another application requires INJECT_EVENTS permission");
                    case MSG_RELOAD_KEYBOARD_LAYOUTS /*3*/:
                        Slog.w(TAG, "Input event injection from pid " + pid + " timed out.");
                        return DEBUG;
                    default:
                        Slog.w(TAG, "Input event injection from pid " + pid + " failed.");
                        return DEBUG;
                }
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        } else {
            throw new IllegalArgumentException("mode is invalid");
        }
    }

    public InputDevice getInputDevice(int deviceId) {
        synchronized (this.mInputDevicesLock) {
            int count = this.mInputDevices.length;
            for (int i = SW_LID; i < count; i += SW_LID_BIT) {
                InputDevice inputDevice = this.mInputDevices[i];
                if (inputDevice.getId() == deviceId) {
                    return inputDevice;
                }
            }
            return null;
        }
    }

    public int[] getInputDeviceIds() {
        int[] ids;
        synchronized (this.mInputDevicesLock) {
            int count = this.mInputDevices.length;
            ids = new int[count];
            for (int i = SW_LID; i < count; i += SW_LID_BIT) {
                ids[i] = this.mInputDevices[i].getId();
            }
        }
        return ids;
    }

    public InputDevice[] getInputDevices() {
        InputDevice[] inputDeviceArr;
        synchronized (this.mInputDevicesLock) {
            inputDeviceArr = this.mInputDevices;
        }
        return inputDeviceArr;
    }

    public void registerInputDevicesChangedListener(IInputDevicesChangedListener listener) {
        if (listener == null) {
            throw new IllegalArgumentException("listener must not be null");
        }
        synchronized (this.mInputDevicesLock) {
            int callingPid = Binder.getCallingPid();
            if (this.mInputDevicesChangedListeners.get(callingPid) != null) {
                throw new SecurityException("The calling process has already registered an InputDevicesChangedListener.");
            }
            InputDevicesChangedListenerRecord record = new InputDevicesChangedListenerRecord(callingPid, listener);
            try {
                listener.asBinder().linkToDeath(record, SW_LID);
                this.mInputDevicesChangedListeners.put(callingPid, record);
            } catch (RemoteException ex) {
                throw new RuntimeException(ex);
            }
        }
    }

    private void onInputDevicesChangedListenerDied(int pid) {
        synchronized (this.mInputDevicesLock) {
            this.mInputDevicesChangedListeners.remove(pid);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void deliverInputDevicesChanged(android.view.InputDevice[] r18) {
        /*
        r17 = this;
        r11 = 0;
        r0 = r17;
        r14 = r0.mTempInputDevicesChangedListenersToNotify;
        r14.clear();
        r0 = r17;
        r14 = r0.mTempFullKeyboards;
        r14.clear();
        r0 = r17;
        r15 = r0.mInputDevicesLock;
        monitor-enter(r15);
        r0 = r17;
        r14 = r0.mInputDevicesChangedPending;	 Catch:{ all -> 0x00ab }
        if (r14 != 0) goto L_0x001c;
    L_0x001a:
        monitor-exit(r15);	 Catch:{ all -> 0x00ab }
    L_0x001b:
        return;
    L_0x001c:
        r14 = 0;
        r0 = r17;
        r0.mInputDevicesChangedPending = r14;	 Catch:{ all -> 0x00ab }
        r0 = r17;
        r14 = r0.mInputDevicesChangedListeners;	 Catch:{ all -> 0x00ab }
        r13 = r14.size();	 Catch:{ all -> 0x00ab }
        r2 = 0;
    L_0x002a:
        if (r2 >= r13) goto L_0x0044;
    L_0x002c:
        r0 = r17;
        r14 = r0.mTempInputDevicesChangedListenersToNotify;	 Catch:{ all -> 0x00ab }
        r0 = r17;
        r0 = r0.mInputDevicesChangedListeners;	 Catch:{ all -> 0x00ab }
        r16 = r0;
        r0 = r16;
        r16 = r0.valueAt(r2);	 Catch:{ all -> 0x00ab }
        r0 = r16;
        r14.add(r0);	 Catch:{ all -> 0x00ab }
        r2 = r2 + 1;
        goto L_0x002a;
    L_0x0044:
        r0 = r17;
        r14 = r0.mInputDevices;	 Catch:{ all -> 0x00ab }
        r9 = r14.length;	 Catch:{ all -> 0x00ab }
        r14 = r9 * 2;
        r1 = new int[r14];	 Catch:{ all -> 0x00ab }
        r2 = 0;
        r12 = r11;
    L_0x004f:
        if (r2 >= r9) goto L_0x0097;
    L_0x0051:
        r0 = r17;
        r14 = r0.mInputDevices;	 Catch:{ all -> 0x011b }
        r3 = r14[r2];	 Catch:{ all -> 0x011b }
        r14 = r2 * 2;
        r16 = r3.getId();	 Catch:{ all -> 0x011b }
        r1[r14] = r16;	 Catch:{ all -> 0x011b }
        r14 = r2 * 2;
        r14 = r14 + 1;
        r16 = r3.getGeneration();	 Catch:{ all -> 0x011b }
        r1[r14] = r16;	 Catch:{ all -> 0x011b }
        r14 = r3.isVirtual();	 Catch:{ all -> 0x011b }
        if (r14 != 0) goto L_0x0095;
    L_0x006f:
        r14 = r3.isFullKeyboard();	 Catch:{ all -> 0x011b }
        if (r14 == 0) goto L_0x0095;
    L_0x0075:
        r14 = r3.getDescriptor();	 Catch:{ all -> 0x011b }
        r0 = r18;
        r14 = containsInputDeviceWithDescriptor(r0, r14);	 Catch:{ all -> 0x011b }
        if (r14 != 0) goto L_0x008e;
    L_0x0081:
        r0 = r17;
        r14 = r0.mTempFullKeyboards;	 Catch:{ all -> 0x011b }
        r11 = r12 + 1;
        r14.add(r12, r3);	 Catch:{ all -> 0x00ab }
    L_0x008a:
        r2 = r2 + 1;
        r12 = r11;
        goto L_0x004f;
    L_0x008e:
        r0 = r17;
        r14 = r0.mTempFullKeyboards;	 Catch:{ all -> 0x011b }
        r14.add(r3);	 Catch:{ all -> 0x011b }
    L_0x0095:
        r11 = r12;
        goto L_0x008a;
    L_0x0097:
        monitor-exit(r15);	 Catch:{ all -> 0x011b }
        r2 = 0;
    L_0x0099:
        if (r2 >= r13) goto L_0x00ae;
    L_0x009b:
        r0 = r17;
        r14 = r0.mTempInputDevicesChangedListenersToNotify;
        r14 = r14.get(r2);
        r14 = (com.android.server.input.InputManagerService.InputDevicesChangedListenerRecord) r14;
        r14.notifyInputDevicesChanged(r1);
        r2 = r2 + 1;
        goto L_0x0099;
    L_0x00ab:
        r14 = move-exception;
    L_0x00ac:
        monitor-exit(r15);	 Catch:{ all -> 0x00ab }
        throw r14;
    L_0x00ae:
        r0 = r17;
        r14 = r0.mTempInputDevicesChangedListenersToNotify;
        r14.clear();
        r0 = r17;
        r14 = r0.mNotificationManager;
        if (r14 == 0) goto L_0x00fe;
    L_0x00bb:
        r0 = r17;
        r14 = r0.mTempFullKeyboards;
        r10 = r14.size();
        r6 = 0;
        r7 = 0;
        r8 = 0;
        r4 = 0;
        r0 = r17;
        r15 = r0.mDataStore;
        monitor-enter(r15);
        r2 = 0;
    L_0x00cd:
        if (r2 >= r10) goto L_0x00f1;
    L_0x00cf:
        r0 = r17;
        r14 = r0.mTempFullKeyboards;	 Catch:{ all -> 0x0108 }
        r3 = r14.get(r2);	 Catch:{ all -> 0x0108 }
        r3 = (android.view.InputDevice) r3;	 Catch:{ all -> 0x0108 }
        r14 = r3.getIdentifier();	 Catch:{ all -> 0x0108 }
        r0 = r17;
        r5 = r0.getCurrentKeyboardLayoutForInputDevice(r14);	 Catch:{ all -> 0x0108 }
        if (r5 != 0) goto L_0x00ec;
    L_0x00e5:
        r6 = 1;
        if (r2 >= r12) goto L_0x00ec;
    L_0x00e8:
        r7 = 1;
        if (r4 != 0) goto L_0x00ef;
    L_0x00eb:
        r4 = r3;
    L_0x00ec:
        r2 = r2 + 1;
        goto L_0x00cd;
    L_0x00ef:
        r8 = 1;
        goto L_0x00ec;
    L_0x00f1:
        monitor-exit(r15);	 Catch:{ all -> 0x0108 }
        if (r6 == 0) goto L_0x0111;
    L_0x00f4:
        if (r7 == 0) goto L_0x00fe;
    L_0x00f6:
        if (r8 == 0) goto L_0x010b;
    L_0x00f8:
        r14 = 0;
        r0 = r17;
        r0.showMissingKeyboardLayoutNotification(r14);
    L_0x00fe:
        r0 = r17;
        r14 = r0.mTempFullKeyboards;
        r14.clear();
        r11 = r12;
        goto L_0x001b;
    L_0x0108:
        r14 = move-exception;
        monitor-exit(r15);	 Catch:{ all -> 0x0108 }
        throw r14;
    L_0x010b:
        r0 = r17;
        r0.showMissingKeyboardLayoutNotification(r4);
        goto L_0x00fe;
    L_0x0111:
        r0 = r17;
        r14 = r0.mKeyboardLayoutNotificationShown;
        if (r14 == 0) goto L_0x00fe;
    L_0x0117:
        r17.hideMissingKeyboardLayoutNotification();
        goto L_0x00fe;
    L_0x011b:
        r14 = move-exception;
        r11 = r12;
        goto L_0x00ac;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.input.InputManagerService.deliverInputDevicesChanged(android.view.InputDevice[]):void");
    }

    public TouchCalibration getTouchCalibrationForInputDevice(String inputDeviceDescriptor, int surfaceRotation) {
        if (inputDeviceDescriptor == null) {
            throw new IllegalArgumentException("inputDeviceDescriptor must not be null");
        }
        TouchCalibration touchCalibration;
        synchronized (this.mDataStore) {
            touchCalibration = this.mDataStore.getTouchCalibration(inputDeviceDescriptor, surfaceRotation);
        }
        return touchCalibration;
    }

    public void setTouchCalibrationForInputDevice(String inputDeviceDescriptor, int surfaceRotation, TouchCalibration calibration) {
        if (!checkCallingPermission("android.permission.SET_INPUT_CALIBRATION", "setTouchCalibrationForInputDevice()")) {
            throw new SecurityException("Requires SET_INPUT_CALIBRATION permission");
        } else if (inputDeviceDescriptor == null) {
            throw new IllegalArgumentException("inputDeviceDescriptor must not be null");
        } else if (calibration == null) {
            throw new IllegalArgumentException("calibration must not be null");
        } else if (surfaceRotation < 0 || surfaceRotation > MSG_RELOAD_KEYBOARD_LAYOUTS) {
            throw new IllegalArgumentException("surfaceRotation value out of bounds");
        } else {
            synchronized (this.mDataStore) {
                try {
                    if (this.mDataStore.setTouchCalibration(inputDeviceDescriptor, surfaceRotation, calibration)) {
                        nativeReloadCalibration(this.mPtr);
                    }
                    this.mDataStore.saveIfNeeded();
                } catch (Throwable th) {
                    this.mDataStore.saveIfNeeded();
                }
            }
        }
    }

    private void showMissingKeyboardLayoutNotification(InputDevice device) {
        if (!this.mKeyboardLayoutNotificationShown) {
            Intent intent = new Intent("android.settings.INPUT_METHOD_SETTINGS");
            if (device != null) {
                intent.putExtra("input_device_identifier", device.getIdentifier());
            }
            intent.setFlags(337641472);
            PendingIntent keyboardLayoutIntent = PendingIntent.getActivityAsUser(this.mContext, SW_LID, intent, SW_LID, null, UserHandle.CURRENT);
            Resources r = this.mContext.getResources();
            this.mNotificationManager.notifyAsUser(null, 17040661, new Builder(this.mContext).setContentTitle(r.getString(17040661)).setContentText(r.getString(17040662)).setContentIntent(keyboardLayoutIntent).setSmallIcon(17302580).setPriority(KEY_STATE_UNKNOWN).setColor(this.mContext.getResources().getColor(17170521)).build(), UserHandle.ALL);
            this.mKeyboardLayoutNotificationShown = true;
        }
    }

    private void hideMissingKeyboardLayoutNotification() {
        if (this.mKeyboardLayoutNotificationShown) {
            this.mKeyboardLayoutNotificationShown = DEBUG;
            this.mNotificationManager.cancelAsUser(null, 17040661, UserHandle.ALL);
        }
    }

    private void updateKeyboardLayouts() {
        HashSet<String> availableKeyboardLayouts = new HashSet();
        visitAllKeyboardLayouts(new C03254(availableKeyboardLayouts));
        synchronized (this.mDataStore) {
            try {
                this.mDataStore.removeUninstalledKeyboardLayouts(availableKeyboardLayouts);
                this.mDataStore.saveIfNeeded();
            } catch (Throwable th) {
                this.mDataStore.saveIfNeeded();
            }
        }
        reloadKeyboardLayouts();
    }

    private static boolean containsInputDeviceWithDescriptor(InputDevice[] inputDevices, String descriptor) {
        int numDevices = inputDevices.length;
        for (int i = SW_LID; i < numDevices; i += SW_LID_BIT) {
            if (inputDevices[i].getDescriptor().equals(descriptor)) {
                return true;
            }
        }
        return DEBUG;
    }

    public KeyboardLayout[] getKeyboardLayouts() {
        ArrayList<KeyboardLayout> list = new ArrayList();
        visitAllKeyboardLayouts(new C03265(list));
        return (KeyboardLayout[]) list.toArray(new KeyboardLayout[list.size()]);
    }

    public KeyboardLayout getKeyboardLayout(String keyboardLayoutDescriptor) {
        if (keyboardLayoutDescriptor == null) {
            throw new IllegalArgumentException("keyboardLayoutDescriptor must not be null");
        }
        KeyboardLayout[] result = new KeyboardLayout[SW_LID_BIT];
        visitKeyboardLayout(keyboardLayoutDescriptor, new C03276(result));
        if (result[SW_LID] == null) {
            Log.w(TAG, "Could not get keyboard layout with descriptor '" + keyboardLayoutDescriptor + "'.");
        }
        return result[SW_LID];
    }

    private void visitAllKeyboardLayouts(KeyboardLayoutVisitor visitor) {
        PackageManager pm = this.mContext.getPackageManager();
        for (ResolveInfo resolveInfo : pm.queryBroadcastReceivers(new Intent("android.hardware.input.action.QUERY_KEYBOARD_LAYOUTS"), SW_JACK_PHYSICAL_INSERT_BIT)) {
            visitKeyboardLayoutsInPackage(pm, resolveInfo.activityInfo, null, resolveInfo.priority, visitor);
        }
    }

    private void visitKeyboardLayout(String keyboardLayoutDescriptor, KeyboardLayoutVisitor visitor) {
        KeyboardLayoutDescriptor d = KeyboardLayoutDescriptor.parse(keyboardLayoutDescriptor);
        if (d != null) {
            PackageManager pm = this.mContext.getPackageManager();
            try {
                visitKeyboardLayoutsInPackage(pm, pm.getReceiverInfo(new ComponentName(d.packageName, d.receiverName), SW_JACK_PHYSICAL_INSERT_BIT), d.keyboardLayoutName, SW_LID, visitor);
            } catch (NameNotFoundException e) {
            }
        }
    }

    private void visitKeyboardLayoutsInPackage(PackageManager pm, ActivityInfo receiver, String keyboardName, int requestedPriority, KeyboardLayoutVisitor visitor) {
        Bundle metaData = receiver.metaData;
        if (metaData != null) {
            int configResId = metaData.getInt("android.hardware.input.metadata.KEYBOARD_LAYOUTS");
            if (configResId == 0) {
                Log.w(TAG, "Missing meta-data 'android.hardware.input.metadata.KEYBOARD_LAYOUTS' on receiver " + receiver.packageName + "/" + receiver.name);
                return;
            }
            int priority;
            CharSequence receiverLabel = receiver.loadLabel(pm);
            String collection = receiverLabel != null ? receiverLabel.toString() : "";
            if ((receiver.applicationInfo.flags & SW_LID_BIT) != 0) {
                priority = requestedPriority;
            } else {
                priority = SW_LID;
            }
            XmlResourceParser parser;
            TypedArray a;
            try {
                Resources resources = pm.getResourcesForApplication(receiver.applicationInfo);
                parser = resources.getXml(configResId);
                XmlUtils.beginDocument(parser, "keyboard-layouts");
                while (true) {
                    XmlUtils.nextElement(parser);
                    String element = parser.getName();
                    if (element == null) {
                        parser.close();
                        return;
                    } else if (element.equals("keyboard-layout")) {
                        a = resources.obtainAttributes(parser, R.styleable.KeyboardLayout);
                        String name = a.getString(SW_LID_BIT);
                        String label = a.getString(SW_LID);
                        int keyboardLayoutResId = a.getResourceId(SW_HEADPHONE_INSERT, SW_LID);
                        if (name == null || label == null || keyboardLayoutResId == 0) {
                            Log.w(TAG, "Missing required 'name', 'label' or 'keyboardLayout' attributes in keyboard layout resource from receiver " + receiver.packageName + "/" + receiver.name);
                        } else {
                            String descriptor = KeyboardLayoutDescriptor.format(receiver.packageName, receiver.name, name);
                            if (keyboardName == null || name.equals(keyboardName)) {
                                visitor.visitKeyboardLayout(resources, descriptor, label, collection, keyboardLayoutResId, priority);
                            }
                        }
                        a.recycle();
                    } else {
                        StringBuilder append = new StringBuilder().append("Skipping unrecognized element '");
                        Log.w(TAG, r17.append(element).append("' in keyboard layout resource from receiver ").append(receiver.packageName).append("/").append(receiver.name).toString());
                    }
                }
            } catch (Exception ex) {
                Log.w(TAG, "Could not parse keyboard layout resource from receiver " + receiver.packageName + "/" + receiver.name, ex);
            } catch (Throwable th) {
                parser.close();
            }
        }
    }

    private String getLayoutDescriptor(InputDeviceIdentifier identifier) {
        if (identifier == null || identifier.getDescriptor() == null) {
            throw new IllegalArgumentException("identifier and descriptor must not be null");
        } else if (identifier.getVendorId() == 0 && identifier.getProductId() == 0) {
            return identifier.getDescriptor();
        } else {
            StringBuilder bob = new StringBuilder();
            bob.append("vendor:").append(identifier.getVendorId());
            bob.append(",product:").append(identifier.getProductId());
            return bob.toString();
        }
    }

    public String getCurrentKeyboardLayoutForInputDevice(InputDeviceIdentifier identifier) {
        String layout;
        String key = getLayoutDescriptor(identifier);
        synchronized (this.mDataStore) {
            layout = this.mDataStore.getCurrentKeyboardLayout(key);
            if (layout == null && !key.equals(identifier.getDescriptor())) {
                layout = this.mDataStore.getCurrentKeyboardLayout(identifier.getDescriptor());
            }
        }
        return layout;
    }

    public void setCurrentKeyboardLayoutForInputDevice(InputDeviceIdentifier identifier, String keyboardLayoutDescriptor) {
        if (!checkCallingPermission("android.permission.SET_KEYBOARD_LAYOUT", "setCurrentKeyboardLayoutForInputDevice()")) {
            throw new SecurityException("Requires SET_KEYBOARD_LAYOUT permission");
        } else if (keyboardLayoutDescriptor == null) {
            throw new IllegalArgumentException("keyboardLayoutDescriptor must not be null");
        } else {
            String key = getLayoutDescriptor(identifier);
            synchronized (this.mDataStore) {
                try {
                    if (this.mDataStore.setCurrentKeyboardLayout(key, keyboardLayoutDescriptor)) {
                        this.mHandler.sendEmptyMessage(MSG_RELOAD_KEYBOARD_LAYOUTS);
                    }
                    this.mDataStore.saveIfNeeded();
                } catch (Throwable th) {
                    this.mDataStore.saveIfNeeded();
                }
            }
        }
    }

    public String[] getKeyboardLayoutsForInputDevice(InputDeviceIdentifier identifier) {
        String[] layouts;
        String key = getLayoutDescriptor(identifier);
        synchronized (this.mDataStore) {
            layouts = this.mDataStore.getKeyboardLayouts(key);
            if ((layouts == null || layouts.length == 0) && !key.equals(identifier.getDescriptor())) {
                layouts = this.mDataStore.getKeyboardLayouts(identifier.getDescriptor());
            }
        }
        return layouts;
    }

    public void addKeyboardLayoutForInputDevice(InputDeviceIdentifier identifier, String keyboardLayoutDescriptor) {
        if (!checkCallingPermission("android.permission.SET_KEYBOARD_LAYOUT", "addKeyboardLayoutForInputDevice()")) {
            throw new SecurityException("Requires SET_KEYBOARD_LAYOUT permission");
        } else if (keyboardLayoutDescriptor == null) {
            throw new IllegalArgumentException("keyboardLayoutDescriptor must not be null");
        } else {
            String key = getLayoutDescriptor(identifier);
            synchronized (this.mDataStore) {
                try {
                    String oldLayout = this.mDataStore.getCurrentKeyboardLayout(key);
                    if (oldLayout == null && !key.equals(identifier.getDescriptor())) {
                        oldLayout = this.mDataStore.getCurrentKeyboardLayout(identifier.getDescriptor());
                    }
                    if (this.mDataStore.addKeyboardLayout(key, keyboardLayoutDescriptor) && !Objects.equal(oldLayout, this.mDataStore.getCurrentKeyboardLayout(key))) {
                        this.mHandler.sendEmptyMessage(MSG_RELOAD_KEYBOARD_LAYOUTS);
                    }
                    this.mDataStore.saveIfNeeded();
                } catch (Throwable th) {
                    this.mDataStore.saveIfNeeded();
                }
            }
        }
    }

    public void removeKeyboardLayoutForInputDevice(InputDeviceIdentifier identifier, String keyboardLayoutDescriptor) {
        if (!checkCallingPermission("android.permission.SET_KEYBOARD_LAYOUT", "removeKeyboardLayoutForInputDevice()")) {
            throw new SecurityException("Requires SET_KEYBOARD_LAYOUT permission");
        } else if (keyboardLayoutDescriptor == null) {
            throw new IllegalArgumentException("keyboardLayoutDescriptor must not be null");
        } else {
            String key = getLayoutDescriptor(identifier);
            synchronized (this.mDataStore) {
                try {
                    String oldLayout = this.mDataStore.getCurrentKeyboardLayout(key);
                    if (oldLayout == null && !key.equals(identifier.getDescriptor())) {
                        oldLayout = this.mDataStore.getCurrentKeyboardLayout(identifier.getDescriptor());
                    }
                    boolean removed = this.mDataStore.removeKeyboardLayout(key, keyboardLayoutDescriptor);
                    if (!key.equals(identifier.getDescriptor())) {
                        removed |= this.mDataStore.removeKeyboardLayout(identifier.getDescriptor(), keyboardLayoutDescriptor);
                    }
                    if (removed && !Objects.equal(oldLayout, this.mDataStore.getCurrentKeyboardLayout(key))) {
                        this.mHandler.sendEmptyMessage(MSG_RELOAD_KEYBOARD_LAYOUTS);
                    }
                    this.mDataStore.saveIfNeeded();
                } catch (Throwable th) {
                    this.mDataStore.saveIfNeeded();
                }
            }
        }
    }

    public void switchKeyboardLayout(int deviceId, int direction) {
        this.mHandler.obtainMessage(SW_HEADPHONE_INSERT, deviceId, direction).sendToTarget();
    }

    private void handleSwitchKeyboardLayout(int deviceId, int direction) {
        InputDevice device = getInputDevice(deviceId);
        if (device != null) {
            boolean changed;
            String keyboardLayoutDescriptor;
            String key = getLayoutDescriptor(device.getIdentifier());
            synchronized (this.mDataStore) {
                try {
                    changed = this.mDataStore.switchKeyboardLayout(key, direction);
                    keyboardLayoutDescriptor = this.mDataStore.getCurrentKeyboardLayout(key);
                    this.mDataStore.saveIfNeeded();
                } catch (Throwable th) {
                    this.mDataStore.saveIfNeeded();
                }
            }
            if (changed) {
                if (this.mSwitchedKeyboardLayoutToast != null) {
                    this.mSwitchedKeyboardLayoutToast.cancel();
                    this.mSwitchedKeyboardLayoutToast = null;
                }
                if (keyboardLayoutDescriptor != null) {
                    KeyboardLayout keyboardLayout = getKeyboardLayout(keyboardLayoutDescriptor);
                    if (keyboardLayout != null) {
                        this.mSwitchedKeyboardLayoutToast = Toast.makeText(this.mContext, keyboardLayout.getLabel(), SW_LID);
                        this.mSwitchedKeyboardLayoutToast.show();
                    }
                }
                reloadKeyboardLayouts();
            }
        }
    }

    public void setInputWindows(InputWindowHandle[] windowHandles) {
        nativeSetInputWindows(this.mPtr, windowHandles);
    }

    public void setFocusedApplication(InputApplicationHandle application) {
        nativeSetFocusedApplication(this.mPtr, application);
    }

    public void setInputDispatchMode(boolean enabled, boolean frozen) {
        nativeSetInputDispatchMode(this.mPtr, enabled, frozen);
    }

    public void setSystemUiVisibility(int visibility) {
        nativeSetSystemUiVisibility(this.mPtr, visibility);
    }

    public boolean transferTouchFocus(InputChannel fromChannel, InputChannel toChannel) {
        if (fromChannel == null) {
            throw new IllegalArgumentException("fromChannel must not be null.");
        } else if (toChannel != null) {
            return nativeTransferTouchFocus(this.mPtr, fromChannel, toChannel);
        } else {
            throw new IllegalArgumentException("toChannel must not be null.");
        }
    }

    public void tryPointerSpeed(int speed) {
        if (!checkCallingPermission("android.permission.SET_POINTER_SPEED", "tryPointerSpeed()")) {
            throw new SecurityException("Requires SET_POINTER_SPEED permission");
        } else if (speed < -7 || speed > SW_JACK_PHYSICAL_INSERT) {
            throw new IllegalArgumentException("speed out of range");
        } else {
            setPointerSpeedUnchecked(speed);
        }
    }

    public void updatePointerSpeedFromSettings() {
        setPointerSpeedUnchecked(getPointerSpeedSetting());
    }

    private void setPointerSpeedUnchecked(int speed) {
        nativeSetPointerSpeed(this.mPtr, Math.min(Math.max(speed, -7), SW_JACK_PHYSICAL_INSERT));
    }

    private void registerPointerSpeedSettingObserver() {
        this.mContext.getContentResolver().registerContentObserver(System.getUriFor("pointer_speed"), true, new C03287(this.mHandler), KEY_STATE_UNKNOWN);
    }

    private int getPointerSpeedSetting() {
        int speed = SW_LID;
        try {
            speed = System.getIntForUser(this.mContext.getContentResolver(), "pointer_speed", -2);
        } catch (SettingNotFoundException e) {
        }
        return speed;
    }

    public void updateShowTouchesFromSettings() {
        boolean z = DEBUG;
        int setting = getShowTouchesSetting(SW_LID);
        long j = this.mPtr;
        if (setting != 0) {
            z = true;
        }
        nativeSetShowTouches(j, z);
    }

    private void registerShowTouchesSettingObserver() {
        this.mContext.getContentResolver().registerContentObserver(System.getUriFor("show_touches"), true, new C03298(this.mHandler), KEY_STATE_UNKNOWN);
    }

    private int getShowTouchesSetting(int defaultValue) {
        int result = defaultValue;
        try {
            result = System.getIntForUser(this.mContext.getContentResolver(), "show_touches", -2);
        } catch (SettingNotFoundException e) {
        }
        return result;
    }

    public void vibrate(int deviceId, long[] pattern, int repeat, IBinder token) {
        if (repeat >= pattern.length) {
            throw new ArrayIndexOutOfBoundsException();
        }
        synchronized (this.mVibratorLock) {
            VibratorToken v = (VibratorToken) this.mVibratorTokens.get(token);
            if (v == null) {
                int i = this.mNextVibratorTokenValue;
                this.mNextVibratorTokenValue = i + SW_LID_BIT;
                v = new VibratorToken(deviceId, token, i);
                try {
                    token.linkToDeath(v, SW_LID);
                    this.mVibratorTokens.put(token, v);
                } catch (RemoteException ex) {
                    throw new RuntimeException(ex);
                }
            }
        }
        synchronized (v) {
            v.mVibrating = true;
            nativeVibrate(this.mPtr, deviceId, pattern, repeat, v.mTokenValue);
        }
    }

    public void cancelVibrate(int deviceId, IBinder token) {
        synchronized (this.mVibratorLock) {
            VibratorToken v = (VibratorToken) this.mVibratorTokens.get(token);
            if (v == null || v.mDeviceId != deviceId) {
                return;
            }
            cancelVibrateIfNeeded(v);
        }
    }

    void onVibratorTokenDied(VibratorToken v) {
        synchronized (this.mVibratorLock) {
            this.mVibratorTokens.remove(v.mToken);
        }
        cancelVibrateIfNeeded(v);
    }

    private void cancelVibrateIfNeeded(VibratorToken v) {
        synchronized (v) {
            if (v.mVibrating) {
                nativeCancelVibrate(this.mPtr, v.mDeviceId, v.mTokenValue);
                v.mVibrating = DEBUG;
            }
        }
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        if (this.mContext.checkCallingOrSelfPermission("android.permission.DUMP") != 0) {
            pw.println("Permission Denial: can't dump InputManager from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid());
            return;
        }
        pw.println("INPUT MANAGER (dumpsys input)\n");
        String dumpStr = nativeDump(this.mPtr);
        if (dumpStr != null) {
            pw.println(dumpStr);
        }
    }

    private boolean checkCallingPermission(String permission, String func) {
        if (Binder.getCallingPid() == Process.myPid() || this.mContext.checkCallingPermission(permission) == 0) {
            return true;
        }
        Slog.w(TAG, "Permission Denial: " + func + " from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " requires " + permission);
        return DEBUG;
    }

    public void monitor() {
        synchronized (this.mInputFilterLock) {
        }
        nativeMonitor(this.mPtr);
    }

    private void notifyConfigurationChanged(long whenNanos) {
        this.mWindowManagerCallbacks.notifyConfigurationChanged();
    }

    private void notifyInputDevicesChanged(InputDevice[] inputDevices) {
        synchronized (this.mInputDevicesLock) {
            if (!this.mInputDevicesChangedPending) {
                this.mInputDevicesChangedPending = true;
                this.mHandler.obtainMessage(SW_LID_BIT, this.mInputDevices).sendToTarget();
            }
            this.mInputDevices = inputDevices;
        }
    }

    private void notifySwitch(long whenNanos, int switchValues, int switchMask) {
        if ((switchMask & SW_LID_BIT) != 0) {
            this.mWindowManagerCallbacks.notifyLidSwitchChanged(whenNanos, (switchValues & SW_LID_BIT) == 0 ? true : DEBUG);
        }
        if ((switchMask & SW_CAMERA_LENS_COVER_BIT) != 0) {
            boolean lensCovered;
            if ((switchValues & SW_CAMERA_LENS_COVER_BIT) != 0) {
                lensCovered = true;
            } else {
                lensCovered = DEBUG;
            }
            this.mWindowManagerCallbacks.notifyCameraLensCoverSwitchChanged(whenNanos, lensCovered);
        }
        if (this.mUseDevInputEventForAudioJack && (switchMask & SW_JACK_BITS) != 0) {
            this.mWiredAccessoryCallbacks.notifyWiredAccessoryChanged(whenNanos, switchValues, switchMask);
        }
    }

    private void notifyInputChannelBroken(InputWindowHandle inputWindowHandle) {
        this.mWindowManagerCallbacks.notifyInputChannelBroken(inputWindowHandle);
    }

    private long notifyANR(InputApplicationHandle inputApplicationHandle, InputWindowHandle inputWindowHandle, String reason) {
        return this.mWindowManagerCallbacks.notifyANR(inputApplicationHandle, inputWindowHandle, reason);
    }

    final boolean filterInputEvent(InputEvent event, int policyFlags) {
        synchronized (this.mInputFilterLock) {
            if (this.mInputFilter != null) {
                try {
                    this.mInputFilter.filterInputEvent(event, policyFlags);
                } catch (RemoteException e) {
                }
                return DEBUG;
            }
            event.recycle();
            return true;
        }
    }

    private int interceptKeyBeforeQueueing(KeyEvent event, int policyFlags) {
        return this.mWindowManagerCallbacks.interceptKeyBeforeQueueing(event, policyFlags);
    }

    private int interceptMotionBeforeQueueingNonInteractive(long whenNanos, int policyFlags) {
        return this.mWindowManagerCallbacks.interceptMotionBeforeQueueingNonInteractive(whenNanos, policyFlags);
    }

    private long interceptKeyBeforeDispatching(InputWindowHandle focus, KeyEvent event, int policyFlags) {
        return this.mWindowManagerCallbacks.interceptKeyBeforeDispatching(focus, event, policyFlags);
    }

    private KeyEvent dispatchUnhandledKey(InputWindowHandle focus, KeyEvent event, int policyFlags) {
        return this.mWindowManagerCallbacks.dispatchUnhandledKey(focus, event, policyFlags);
    }

    private boolean checkInjectEventsPermission(int injectorPid, int injectorUid) {
        return this.mContext.checkPermission("android.permission.INJECT_EVENTS", injectorPid, injectorUid) == 0 ? true : DEBUG;
    }

    private int getVirtualKeyQuietTimeMillis() {
        return this.mContext.getResources().getInteger(17694812);
    }

    private String[] getExcludedDeviceNames() {
        Exception e;
        Throwable th;
        ArrayList<String> names = new ArrayList();
        File confFile = new File(Environment.getRootDirectory(), EXCLUDED_DEVICES_PATH);
        FileReader confreader = null;
        try {
            FileReader confreader2 = new FileReader(confFile);
            try {
                XmlPullParser parser = Xml.newPullParser();
                parser.setInput(confreader2);
                XmlUtils.beginDocument(parser, "devices");
                while (true) {
                    XmlUtils.nextElement(parser);
                    if (!"device".equals(parser.getName())) {
                        break;
                    }
                    String name = parser.getAttributeValue(null, "name");
                    if (name != null) {
                        names.add(name);
                    }
                }
                if (confreader2 != null) {
                    try {
                        confreader2.close();
                    } catch (IOException e2) {
                        confreader = confreader2;
                    }
                }
                confreader = confreader2;
            } catch (FileNotFoundException e3) {
                confreader = confreader2;
            } catch (Exception e4) {
                e = e4;
                confreader = confreader2;
            } catch (Throwable th2) {
                th = th2;
                confreader = confreader2;
            }
        } catch (FileNotFoundException e5) {
            if (confreader != null) {
                try {
                    confreader.close();
                } catch (IOException e6) {
                }
            }
            return (String[]) names.toArray(new String[names.size()]);
        } catch (Exception e7) {
            e = e7;
            try {
                Slog.e(TAG, "Exception while parsing '" + confFile.getAbsolutePath() + "'", e);
                if (confreader != null) {
                    try {
                        confreader.close();
                    } catch (IOException e8) {
                    }
                }
                return (String[]) names.toArray(new String[names.size()]);
            } catch (Throwable th3) {
                th = th3;
                if (confreader != null) {
                    try {
                        confreader.close();
                    } catch (IOException e9) {
                    }
                }
                throw th;
            }
        }
        return (String[]) names.toArray(new String[names.size()]);
    }

    private int getKeyRepeatTimeout() {
        return ViewConfiguration.getKeyRepeatTimeout();
    }

    private int getKeyRepeatDelay() {
        return ViewConfiguration.getKeyRepeatDelay();
    }

    private int getHoverTapTimeout() {
        return ViewConfiguration.getHoverTapTimeout();
    }

    private int getHoverTapSlop() {
        return ViewConfiguration.getHoverTapSlop();
    }

    private int getDoubleTapTimeout() {
        return ViewConfiguration.getDoubleTapTimeout();
    }

    private int getLongPressTimeout() {
        return ViewConfiguration.getLongPressTimeout();
    }

    private int getPointerLayer() {
        return this.mWindowManagerCallbacks.getPointerLayer();
    }

    private PointerIcon getPointerIcon() {
        return PointerIcon.getDefaultIcon(this.mContext);
    }

    private String[] getKeyboardLayoutOverlay(InputDeviceIdentifier identifier) {
        if (!this.mSystemReady) {
            return null;
        }
        String keyboardLayoutDescriptor = getCurrentKeyboardLayoutForInputDevice(identifier);
        if (keyboardLayoutDescriptor == null) {
            return null;
        }
        String[] result = new String[SW_HEADPHONE_INSERT];
        visitKeyboardLayout(keyboardLayoutDescriptor, new C03309(result));
        if (result[SW_LID] != null) {
            return result;
        }
        Log.w(TAG, "Could not get keyboard layout with descriptor '" + keyboardLayoutDescriptor + "'.");
        return null;
    }

    private String getDeviceAlias(String uniqueId) {
        return BluetoothAdapter.checkBluetoothAddress(uniqueId) ? null : null;
    }
}
