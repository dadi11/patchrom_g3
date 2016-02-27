package android.bluetooth;

import android.bluetooth.BluetoothProfile.ServiceListener;
import android.bluetooth.IBluetoothStateChangeCallback.Stub;
import android.content.ComponentName;
import android.content.Context;
import android.net.ProxyInfo;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.os.RemoteException;
import android.util.Log;
import java.util.ArrayList;
import java.util.List;

public final class BluetoothHeadset implements BluetoothProfile {
    public static final String ACTION_AUDIO_STATE_CHANGED = "android.bluetooth.headset.profile.action.AUDIO_STATE_CHANGED";
    public static final String ACTION_CONNECTION_STATE_CHANGED = "android.bluetooth.headset.profile.action.CONNECTION_STATE_CHANGED";
    public static final String ACTION_VENDOR_SPECIFIC_HEADSET_EVENT = "android.bluetooth.headset.action.VENDOR_SPECIFIC_HEADSET_EVENT";
    public static final int AT_CMD_TYPE_ACTION = 4;
    public static final int AT_CMD_TYPE_BASIC = 3;
    public static final int AT_CMD_TYPE_READ = 0;
    public static final int AT_CMD_TYPE_SET = 2;
    public static final int AT_CMD_TYPE_TEST = 1;
    private static final boolean DBG = true;
    public static final String EXTRA_VENDOR_SPECIFIC_HEADSET_EVENT_ARGS = "android.bluetooth.headset.extra.VENDOR_SPECIFIC_HEADSET_EVENT_ARGS";
    public static final String EXTRA_VENDOR_SPECIFIC_HEADSET_EVENT_CMD = "android.bluetooth.headset.extra.VENDOR_SPECIFIC_HEADSET_EVENT_CMD";
    public static final String EXTRA_VENDOR_SPECIFIC_HEADSET_EVENT_CMD_TYPE = "android.bluetooth.headset.extra.VENDOR_SPECIFIC_HEADSET_EVENT_CMD_TYPE";
    private static final int MESSAGE_HEADSET_SERVICE_CONNECTED = 100;
    private static final int MESSAGE_HEADSET_SERVICE_DISCONNECTED = 101;
    public static final int STATE_AUDIO_CONNECTED = 12;
    public static final int STATE_AUDIO_CONNECTING = 11;
    public static final int STATE_AUDIO_DISCONNECTED = 10;
    private static final String TAG = "BluetoothHeadset";
    private static final boolean VDBG;
    public static final String VENDOR_RESULT_CODE_COMMAND_ANDROID = "+ANDROID";
    public static final String VENDOR_SPECIFIC_HEADSET_EVENT_COMPANY_ID_CATEGORY = "android.bluetooth.headset.intent.category.companyid";
    private BluetoothAdapter mAdapter;
    private final IBluetoothStateChangeCallback mBluetoothStateChangeCallback;
    private final IBluetoothProfileServiceConnection mConnection;
    private Context mContext;
    private final Handler mHandler;
    private IBluetoothHeadset mService;
    private ServiceListener mServiceListener;

    /* renamed from: android.bluetooth.BluetoothHeadset.1 */
    class C00481 extends Stub {
        C00481() {
        }

        public void onBluetoothStateChange(boolean up) {
            Log.d(BluetoothHeadset.TAG, "onBluetoothStateChange: up=" + up);
            if (up) {
                synchronized (BluetoothHeadset.this.mConnection) {
                    try {
                        if (BluetoothHeadset.this.mService == null) {
                            if (BluetoothHeadset.VDBG) {
                                Log.d(BluetoothHeadset.TAG, "Binding service...");
                            }
                            BluetoothHeadset.this.doBind();
                        }
                    } catch (Exception re) {
                        Log.e(BluetoothHeadset.TAG, ProxyInfo.LOCAL_EXCL_LIST, re);
                    }
                }
                return;
            }
            if (BluetoothHeadset.VDBG) {
                Log.d(BluetoothHeadset.TAG, "Unbinding service...");
            }
            BluetoothHeadset.this.doUnbind();
        }
    }

    /* renamed from: android.bluetooth.BluetoothHeadset.2 */
    class C00492 extends IBluetoothProfileServiceConnection.Stub {
        C00492() {
        }

        public void onServiceConnected(ComponentName className, IBinder service) {
            Log.d(BluetoothHeadset.TAG, "Proxy object connected");
            BluetoothHeadset.this.mService = IBluetoothHeadset.Stub.asInterface(service);
            BluetoothHeadset.this.mHandler.sendMessage(BluetoothHeadset.this.mHandler.obtainMessage(BluetoothHeadset.MESSAGE_HEADSET_SERVICE_CONNECTED));
        }

        public void onServiceDisconnected(ComponentName className) {
            Log.d(BluetoothHeadset.TAG, "Proxy object disconnected");
            BluetoothHeadset.this.mService = null;
            BluetoothHeadset.this.mHandler.sendMessage(BluetoothHeadset.this.mHandler.obtainMessage(BluetoothHeadset.MESSAGE_HEADSET_SERVICE_DISCONNECTED));
        }
    }

    /* renamed from: android.bluetooth.BluetoothHeadset.3 */
    class C00503 extends Handler {
        C00503(Looper x0) {
            super(x0);
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case BluetoothHeadset.MESSAGE_HEADSET_SERVICE_CONNECTED /*100*/:
                    if (BluetoothHeadset.this.mServiceListener != null) {
                        BluetoothHeadset.this.mServiceListener.onServiceConnected(BluetoothHeadset.AT_CMD_TYPE_TEST, BluetoothHeadset.this);
                    }
                case BluetoothHeadset.MESSAGE_HEADSET_SERVICE_DISCONNECTED /*101*/:
                    if (BluetoothHeadset.this.mServiceListener != null) {
                        BluetoothHeadset.this.mServiceListener.onServiceDisconnected(BluetoothHeadset.AT_CMD_TYPE_TEST);
                    }
                default:
            }
        }
    }

    static {
        VDBG = Log.isLoggable("Handsfree", AT_CMD_TYPE_SET);
    }

    BluetoothHeadset(Context context, ServiceListener l) {
        this.mBluetoothStateChangeCallback = new C00481();
        this.mConnection = new C00492();
        this.mHandler = new C00503(Looper.getMainLooper());
        this.mContext = context;
        this.mServiceListener = l;
        this.mAdapter = BluetoothAdapter.getDefaultAdapter();
        IBluetoothManager mgr = this.mAdapter.getBluetoothManager();
        if (mgr != null) {
            try {
                mgr.registerStateChangeCallback(this.mBluetoothStateChangeCallback);
            } catch (RemoteException e) {
                Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
            }
        }
        doBind();
    }

    boolean doBind() {
        try {
            return this.mAdapter.getBluetoothManager().bindBluetoothProfileService(AT_CMD_TYPE_TEST, this.mConnection);
        } catch (RemoteException e) {
            Log.e(TAG, "Unable to bind HeadsetService", e);
            return VDBG;
        }
    }

    void doUnbind() {
        synchronized (this.mConnection) {
            if (this.mService != null) {
                try {
                    this.mAdapter.getBluetoothManager().unbindBluetoothProfileService(AT_CMD_TYPE_TEST, this.mConnection);
                } catch (RemoteException e) {
                    Log.e(TAG, "Unable to unbind HeadsetService", e);
                }
            }
        }
    }

    void close() {
        if (VDBG) {
            log("close()");
        }
        IBluetoothManager mgr = this.mAdapter.getBluetoothManager();
        if (mgr != null) {
            try {
                mgr.unregisterStateChangeCallback(this.mBluetoothStateChangeCallback);
            } catch (Exception e) {
                Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
            }
        }
        this.mServiceListener = null;
        doUnbind();
    }

    public boolean connect(BluetoothDevice device) {
        boolean z = VDBG;
        log("connect(" + device + ")");
        if (this.mService != null && isEnabled() && isValidDevice(device)) {
            try {
                z = this.mService.connect(device);
            } catch (RemoteException e) {
                Log.e(TAG, Log.getStackTraceString(new Throwable()));
            }
        } else if (this.mService == null) {
            Log.w(TAG, "Proxy not attached to service");
        }
        return z;
    }

    public boolean disconnect(BluetoothDevice device) {
        boolean z = VDBG;
        log("disconnect(" + device + ")");
        if (this.mService != null && isEnabled() && isValidDevice(device)) {
            try {
                z = this.mService.disconnect(device);
            } catch (RemoteException e) {
                Log.e(TAG, Log.getStackTraceString(new Throwable()));
            }
        } else if (this.mService == null) {
            Log.w(TAG, "Proxy not attached to service");
        }
        return z;
    }

    public List<BluetoothDevice> getConnectedDevices() {
        if (VDBG) {
            log("getConnectedDevices()");
        }
        if (this.mService == null || !isEnabled()) {
            if (this.mService == null) {
                Log.w(TAG, "Proxy not attached to service");
            }
            return new ArrayList();
        }
        try {
            return this.mService.getConnectedDevices();
        } catch (RemoteException e) {
            Log.e(TAG, Log.getStackTraceString(new Throwable()));
            return new ArrayList();
        }
    }

    public List<BluetoothDevice> getDevicesMatchingConnectionStates(int[] states) {
        if (VDBG) {
            log("getDevicesMatchingStates()");
        }
        if (this.mService == null || !isEnabled()) {
            if (this.mService == null) {
                Log.w(TAG, "Proxy not attached to service");
            }
            return new ArrayList();
        }
        try {
            return this.mService.getDevicesMatchingConnectionStates(states);
        } catch (RemoteException e) {
            Log.e(TAG, Log.getStackTraceString(new Throwable()));
            return new ArrayList();
        }
    }

    public int getConnectionState(BluetoothDevice device) {
        int i = AT_CMD_TYPE_READ;
        if (VDBG) {
            log("getConnectionState(" + device + ")");
        }
        if (this.mService != null && isEnabled() && isValidDevice(device)) {
            try {
                i = this.mService.getConnectionState(device);
            } catch (RemoteException e) {
                Log.e(TAG, Log.getStackTraceString(new Throwable()));
            }
        } else if (this.mService == null) {
            Log.w(TAG, "Proxy not attached to service");
        }
        return i;
    }

    public boolean setPriority(BluetoothDevice device, int priority) {
        boolean z = VDBG;
        log("setPriority(" + device + ", " + priority + ")");
        if (this.mService != null && isEnabled() && isValidDevice(device)) {
            if (priority == 0 || priority == MESSAGE_HEADSET_SERVICE_CONNECTED) {
                try {
                    z = this.mService.setPriority(device, priority);
                } catch (RemoteException e) {
                    Log.e(TAG, Log.getStackTraceString(new Throwable()));
                }
            }
        } else if (this.mService == null) {
            Log.w(TAG, "Proxy not attached to service");
        }
        return z;
    }

    public int getPriority(BluetoothDevice device) {
        int i = AT_CMD_TYPE_READ;
        if (VDBG) {
            log("getPriority(" + device + ")");
        }
        if (this.mService != null && isEnabled() && isValidDevice(device)) {
            try {
                i = this.mService.getPriority(device);
            } catch (RemoteException e) {
                Log.e(TAG, Log.getStackTraceString(new Throwable()));
            }
        } else if (this.mService == null) {
            Log.w(TAG, "Proxy not attached to service");
        }
        return i;
    }

    public boolean startVoiceRecognition(BluetoothDevice device) {
        log("startVoiceRecognition()");
        if (this.mService != null && isEnabled() && isValidDevice(device)) {
            try {
                return this.mService.startVoiceRecognition(device);
            } catch (RemoteException e) {
                Log.e(TAG, Log.getStackTraceString(new Throwable()));
            }
        }
        if (this.mService == null) {
            Log.w(TAG, "Proxy not attached to service");
        }
        return VDBG;
    }

    public boolean stopVoiceRecognition(BluetoothDevice device) {
        log("stopVoiceRecognition()");
        if (this.mService != null && isEnabled() && isValidDevice(device)) {
            try {
                return this.mService.stopVoiceRecognition(device);
            } catch (RemoteException e) {
                Log.e(TAG, Log.getStackTraceString(new Throwable()));
            }
        }
        if (this.mService == null) {
            Log.w(TAG, "Proxy not attached to service");
        }
        return VDBG;
    }

    public boolean isAudioConnected(BluetoothDevice device) {
        if (VDBG) {
            log("isAudioConnected()");
        }
        if (this.mService != null && isEnabled() && isValidDevice(device)) {
            try {
                return this.mService.isAudioConnected(device);
            } catch (RemoteException e) {
                Log.e(TAG, Log.getStackTraceString(new Throwable()));
            }
        }
        if (this.mService == null) {
            Log.w(TAG, "Proxy not attached to service");
        }
        return VDBG;
    }

    public int getBatteryUsageHint(BluetoothDevice device) {
        if (VDBG) {
            log("getBatteryUsageHint()");
        }
        if (this.mService != null && isEnabled() && isValidDevice(device)) {
            try {
                return this.mService.getBatteryUsageHint(device);
            } catch (RemoteException e) {
                Log.e(TAG, Log.getStackTraceString(new Throwable()));
            }
        }
        if (this.mService == null) {
            Log.w(TAG, "Proxy not attached to service");
        }
        return -1;
    }

    public static boolean isBluetoothVoiceDialingEnabled(Context context) {
        return context.getResources().getBoolean(17956942);
    }

    public boolean acceptIncomingConnect(BluetoothDevice device) {
        log("acceptIncomingConnect");
        if (this.mService == null || !isEnabled()) {
            Log.w(TAG, "Proxy not attached to service");
            Log.d(TAG, Log.getStackTraceString(new Throwable()));
        } else {
            try {
                return this.mService.acceptIncomingConnect(device);
            } catch (RemoteException e) {
                Log.e(TAG, e.toString());
            }
        }
        return VDBG;
    }

    public boolean rejectIncomingConnect(BluetoothDevice device) {
        log("rejectIncomingConnect");
        if (this.mService != null) {
            try {
                return this.mService.rejectIncomingConnect(device);
            } catch (RemoteException e) {
                Log.e(TAG, e.toString());
            }
        } else {
            Log.w(TAG, "Proxy not attached to service");
            Log.d(TAG, Log.getStackTraceString(new Throwable()));
            return VDBG;
        }
    }

    public int getAudioState(BluetoothDevice device) {
        if (VDBG) {
            log("getAudioState");
        }
        if (this.mService == null || isDisabled()) {
            Log.w(TAG, "Proxy not attached to service");
            Log.d(TAG, Log.getStackTraceString(new Throwable()));
        } else {
            try {
                return this.mService.getAudioState(device);
            } catch (RemoteException e) {
                Log.e(TAG, e.toString());
            }
        }
        return STATE_AUDIO_DISCONNECTED;
    }

    public boolean isAudioOn() {
        if (VDBG) {
            log("isAudioOn()");
        }
        if (this.mService != null && isEnabled()) {
            try {
                return this.mService.isAudioOn();
            } catch (RemoteException e) {
                Log.e(TAG, Log.getStackTraceString(new Throwable()));
            }
        }
        if (this.mService == null) {
            Log.w(TAG, "Proxy not attached to service");
        }
        return VDBG;
    }

    public boolean connectAudio() {
        if (this.mService == null || !isEnabled()) {
            Log.w(TAG, "Proxy not attached to service");
            Log.d(TAG, Log.getStackTraceString(new Throwable()));
        } else {
            try {
                return this.mService.connectAudio();
            } catch (RemoteException e) {
                Log.e(TAG, e.toString());
            }
        }
        return VDBG;
    }

    public boolean disconnectAudio() {
        if (this.mService == null || !isEnabled()) {
            Log.w(TAG, "Proxy not attached to service");
            Log.d(TAG, Log.getStackTraceString(new Throwable()));
        } else {
            try {
                return this.mService.disconnectAudio();
            } catch (RemoteException e) {
                Log.e(TAG, e.toString());
            }
        }
        return VDBG;
    }

    public boolean startScoUsingVirtualVoiceCall(BluetoothDevice device) {
        log("startScoUsingVirtualVoiceCall()");
        if (this.mService != null && isEnabled() && isValidDevice(device)) {
            try {
                return this.mService.startScoUsingVirtualVoiceCall(device);
            } catch (RemoteException e) {
                Log.e(TAG, e.toString());
            }
        } else {
            Log.w(TAG, "Proxy not attached to service");
            Log.d(TAG, Log.getStackTraceString(new Throwable()));
        }
        return VDBG;
    }

    public boolean stopScoUsingVirtualVoiceCall(BluetoothDevice device) {
        log("stopScoUsingVirtualVoiceCall()");
        if (this.mService != null && isEnabled() && isValidDevice(device)) {
            try {
                return this.mService.stopScoUsingVirtualVoiceCall(device);
            } catch (RemoteException e) {
                Log.e(TAG, e.toString());
            }
        } else {
            Log.w(TAG, "Proxy not attached to service");
            Log.d(TAG, Log.getStackTraceString(new Throwable()));
        }
        return VDBG;
    }

    public void phoneStateChanged(int numActive, int numHeld, int callState, String number, int type) {
        if (this.mService == null || !isEnabled()) {
            Log.w(TAG, "Proxy not attached to service");
            Log.d(TAG, Log.getStackTraceString(new Throwable()));
            return;
        }
        try {
            this.mService.phoneStateChanged(numActive, numHeld, callState, number, type);
        } catch (RemoteException e) {
            Log.e(TAG, e.toString());
        }
    }

    public void clccResponse(int index, int direction, int status, int mode, boolean mpty, String number, int type) {
        if (this.mService == null || !isEnabled()) {
            Log.w(TAG, "Proxy not attached to service");
            Log.d(TAG, Log.getStackTraceString(new Throwable()));
            return;
        }
        try {
            this.mService.clccResponse(index, direction, status, mode, mpty, number, type);
        } catch (RemoteException e) {
            Log.e(TAG, e.toString());
        }
    }

    public boolean sendVendorSpecificResultCode(BluetoothDevice device, String command, String arg) {
        log("sendVendorSpecificResultCode()");
        if (command == null) {
            throw new IllegalArgumentException("command is null");
        }
        if (this.mService != null && isEnabled() && isValidDevice(device)) {
            try {
                return this.mService.sendVendorSpecificResultCode(device, command, arg);
            } catch (RemoteException e) {
                Log.e(TAG, Log.getStackTraceString(new Throwable()));
            }
        }
        if (this.mService == null) {
            Log.w(TAG, "Proxy not attached to service");
        }
        return VDBG;
    }

    public boolean enableWBS() {
        if (this.mService == null || !isEnabled()) {
            Log.w(TAG, "Proxy not attached to service");
            Log.d(TAG, Log.getStackTraceString(new Throwable()));
        } else {
            try {
                return this.mService.enableWBS();
            } catch (RemoteException e) {
                Log.e(TAG, e.toString());
            }
        }
        return VDBG;
    }

    public boolean disableWBS() {
        if (this.mService == null || !isEnabled()) {
            Log.w(TAG, "Proxy not attached to service");
            Log.d(TAG, Log.getStackTraceString(new Throwable()));
        } else {
            try {
                return this.mService.disableWBS();
            } catch (RemoteException e) {
                Log.e(TAG, e.toString());
            }
        }
        return VDBG;
    }

    private boolean isEnabled() {
        if (this.mAdapter.getState() == STATE_AUDIO_CONNECTED) {
            return DBG;
        }
        return VDBG;
    }

    private boolean isDisabled() {
        if (this.mAdapter.getState() == STATE_AUDIO_DISCONNECTED) {
            return DBG;
        }
        return VDBG;
    }

    private boolean isValidDevice(BluetoothDevice device) {
        if (device != null && BluetoothAdapter.checkBluetoothAddress(device.getAddress())) {
            return DBG;
        }
        return VDBG;
    }

    private static void log(String msg) {
        Log.d(TAG, msg);
    }
}
