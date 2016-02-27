package android.bluetooth;

import android.bluetooth.BluetoothProfile.ServiceListener;
import android.bluetooth.IBluetoothStateChangeCallback.Stub;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.IBinder;
import android.os.RemoteException;
import android.util.Log;
import java.util.Arrays;
import java.util.List;

public final class BluetoothHidDevice implements BluetoothProfile {
    public static final String ACTION_CONNECTION_STATE_CHANGED = "android.bluetooth.hid.profile.action.CONNECTION_STATE_CHANGED";
    public static final byte ERROR_RSP_INVALID_PARAM = (byte) 4;
    public static final byte ERROR_RSP_INVALID_RPT_ID = (byte) 2;
    public static final byte ERROR_RSP_NOT_READY = (byte) 1;
    public static final byte ERROR_RSP_SUCCESS = (byte) 0;
    public static final byte ERROR_RSP_UNKNOWN = (byte) 14;
    public static final byte ERROR_RSP_UNSUPPORTED_REQ = (byte) 3;
    public static final byte PROTOCOL_BOOT_MODE = (byte) 0;
    public static final byte PROTOCOL_REPORT_MODE = (byte) 1;
    public static final byte REPORT_TYPE_FEATURE = (byte) 3;
    public static final byte REPORT_TYPE_INPUT = (byte) 1;
    public static final byte REPORT_TYPE_OUTPUT = (byte) 2;
    public static final byte SUBCLASS1_COMBO = (byte) -64;
    public static final byte SUBCLASS1_KEYBOARD = (byte) 64;
    public static final byte SUBCLASS1_MOUSE = Byte.MIN_VALUE;
    public static final byte SUBCLASS1_NONE = (byte) 0;
    public static final byte SUBCLASS2_CARD_READER = (byte) 6;
    public static final byte SUBCLASS2_DIGITIZER_TABLED = (byte) 5;
    public static final byte SUBCLASS2_GAMEPAD = (byte) 2;
    public static final byte SUBCLASS2_JOYSTICK = (byte) 1;
    public static final byte SUBCLASS2_REMOTE_CONTROL = (byte) 3;
    public static final byte SUBCLASS2_SENSING_DEVICE = (byte) 4;
    public static final byte SUBCLASS2_UNCATEGORIZED = (byte) 0;
    private static final String TAG;
    private BluetoothAdapter mAdapter;
    private final IBluetoothStateChangeCallback mBluetoothStateChangeCallback;
    private ServiceConnection mConnection;
    private Context mContext;
    private IBluetoothHidDevice mService;
    private ServiceListener mServiceListener;

    /* renamed from: android.bluetooth.BluetoothHidDevice.1 */
    class C00571 extends Stub {
        C00571() {
        }

        public void onBluetoothStateChange(boolean up) {
            Log.d(BluetoothHidDevice.TAG, "onBluetoothStateChange: up=" + up);
            synchronized (BluetoothHidDevice.this.mConnection) {
                if (up) {
                    try {
                        if (BluetoothHidDevice.this.mService == null) {
                            Log.d(BluetoothHidDevice.TAG, "Binding HID Device service...");
                            BluetoothHidDevice.this.doBind();
                        }
                    } catch (IllegalStateException e) {
                        Log.e(BluetoothHidDevice.TAG, "onBluetoothStateChange: could not bind to HID Dev service: ", e);
                    } catch (SecurityException e2) {
                        Log.e(BluetoothHidDevice.TAG, "onBluetoothStateChange: could not bind to HID Dev service: ", e2);
                    }
                } else {
                    Log.d(BluetoothHidDevice.TAG, "Unbinding service...");
                    if (BluetoothHidDevice.this.mService != null) {
                        BluetoothHidDevice.this.mService = null;
                        try {
                            BluetoothHidDevice.this.mContext.unbindService(BluetoothHidDevice.this.mConnection);
                        } catch (IllegalArgumentException e3) {
                            Log.e(BluetoothHidDevice.TAG, "onBluetoothStateChange: could not unbind service:", e3);
                        }
                    }
                }
            }
        }
    }

    /* renamed from: android.bluetooth.BluetoothHidDevice.2 */
    class C00582 implements ServiceConnection {
        C00582() {
        }

        public void onServiceConnected(ComponentName className, IBinder service) {
            Log.d(BluetoothHidDevice.TAG, "onServiceConnected()");
            BluetoothHidDevice.this.mService = IBluetoothHidDevice.Stub.asInterface(service);
            if (BluetoothHidDevice.this.mServiceListener != null) {
                BluetoothHidDevice.this.mServiceListener.onServiceConnected(17, BluetoothHidDevice.this);
            }
        }

        public void onServiceDisconnected(ComponentName className) {
            Log.d(BluetoothHidDevice.TAG, "onServiceDisconnected()");
            BluetoothHidDevice.this.mService = null;
            if (BluetoothHidDevice.this.mServiceListener != null) {
                BluetoothHidDevice.this.mServiceListener.onServiceDisconnected(17);
            }
        }
    }

    private static class BluetoothHidDeviceCallbackWrapper extends IBluetoothHidDeviceCallback.Stub {
        private BluetoothHidDeviceCallback mCallback;

        public BluetoothHidDeviceCallbackWrapper(BluetoothHidDeviceCallback callback) {
            this.mCallback = callback;
        }

        public void onAppStatusChanged(BluetoothDevice pluggedDevice, BluetoothHidDeviceAppConfiguration config, boolean registered) {
            this.mCallback.onAppStatusChanged(pluggedDevice, config, registered);
        }

        public void onConnectionStateChanged(BluetoothDevice device, int state) {
            this.mCallback.onConnectionStateChanged(device, state);
        }

        public void onGetReport(byte type, byte id, int bufferSize) {
            this.mCallback.onGetReport(type, id, bufferSize);
        }

        public void onSetReport(byte type, byte id, byte[] data) {
            this.mCallback.onSetReport(type, id, data);
        }

        public void onSetProtocol(byte protocol) {
            this.mCallback.onSetProtocol(protocol);
        }

        public void onIntrData(byte reportId, byte[] data) {
            this.mCallback.onIntrData(reportId, data);
        }

        public void onVirtualCableUnplug() {
            this.mCallback.onVirtualCableUnplug();
        }
    }

    static {
        TAG = BluetoothHidDevice.class.getSimpleName();
    }

    BluetoothHidDevice(Context context, ServiceListener listener) {
        this.mBluetoothStateChangeCallback = new C00571();
        this.mConnection = new C00582();
        Log.v(TAG, "BluetoothHidDevice");
        this.mContext = context;
        this.mServiceListener = listener;
        this.mAdapter = BluetoothAdapter.getDefaultAdapter();
        IBluetoothManager mgr = this.mAdapter.getBluetoothManager();
        if (mgr != null) {
            try {
                mgr.registerStateChangeCallback(this.mBluetoothStateChangeCallback);
            } catch (RemoteException e) {
                e.printStackTrace();
            }
        }
        doBind();
    }

    boolean doBind() {
        Intent intent = new Intent(IBluetoothHidDevice.class.getName());
        ComponentName comp = intent.resolveSystemService(this.mContext.getPackageManager(), 0);
        intent.setComponent(comp);
        if (comp == null || !this.mContext.bindService(intent, this.mConnection, 0)) {
            Log.e(TAG, "Could not bind to Bluetooth HID Device Service with " + intent);
            return false;
        }
        Log.d(TAG, "Bound to HID Device Service");
        return true;
    }

    void close() {
        Log.v(TAG, "close()");
        IBluetoothManager mgr = this.mAdapter.getBluetoothManager();
        if (mgr != null) {
            try {
                mgr.unregisterStateChangeCallback(this.mBluetoothStateChangeCallback);
            } catch (RemoteException e) {
                e.printStackTrace();
            }
        }
        synchronized (this.mConnection) {
            if (this.mService != null) {
                this.mService = null;
                try {
                    this.mContext.unbindService(this.mConnection);
                } catch (IllegalArgumentException e2) {
                    Log.e(TAG, "close: could not unbind HID Dev service: ", e2);
                }
            }
        }
        this.mServiceListener = null;
    }

    public List<BluetoothDevice> getConnectedDevices() {
        Log.v(TAG, "getConnectedDevices()");
        return null;
    }

    public List<BluetoothDevice> getDevicesMatchingConnectionStates(int[] states) {
        Log.v(TAG, "getDevicesMatchingConnectionStates(): states=" + Arrays.toString(states));
        return null;
    }

    public int getConnectionState(BluetoothDevice device) {
        Log.v(TAG, "getConnectionState(): device=" + device.getAddress());
        return 0;
    }

    public boolean registerApp(BluetoothHidDeviceAppSdpSettings sdp, BluetoothHidDeviceAppQosSettings inQos, BluetoothHidDeviceAppQosSettings outQos, BluetoothHidDeviceCallback callback) {
        Log.v(TAG, "registerApp(): sdp=" + sdp + " inQos=" + inQos + " outQos=" + outQos + " callback=" + callback);
        boolean result = false;
        if (sdp == null || callback == null) {
            return false;
        }
        if (this.mService != null) {
            try {
                result = this.mService.registerApp(new BluetoothHidDeviceAppConfiguration(), sdp, inQos, outQos, new BluetoothHidDeviceCallbackWrapper(callback));
            } catch (RemoteException e) {
                Log.e(TAG, e.toString());
            }
        } else {
            Log.w(TAG, "Proxy not attached to service");
        }
        return result;
    }

    public boolean unregisterApp(BluetoothHidDeviceAppConfiguration config) {
        Log.v(TAG, "unregisterApp()");
        boolean result = false;
        if (this.mService != null) {
            try {
                result = this.mService.unregisterApp(config);
            } catch (RemoteException e) {
                Log.e(TAG, e.toString());
            }
        } else {
            Log.w(TAG, "Proxy not attached to service");
        }
        return result;
    }

    public boolean sendReport(int id, byte[] data) {
        Log.v(TAG, "sendReport(): id=" + id);
        boolean result = false;
        if (this.mService != null) {
            try {
                result = this.mService.sendReport(id, data);
            } catch (RemoteException e) {
                Log.e(TAG, e.toString());
            }
        } else {
            Log.w(TAG, "Proxy not attached to service");
        }
        return result;
    }

    public boolean replyReport(byte type, byte id, byte[] data) {
        Log.v(TAG, "replyReport(): type=" + type + " id=" + id);
        boolean result = false;
        if (this.mService != null) {
            try {
                result = this.mService.replyReport(type, id, data);
            } catch (RemoteException e) {
                Log.e(TAG, e.toString());
            }
        } else {
            Log.w(TAG, "Proxy not attached to service");
        }
        return result;
    }

    public boolean reportError(byte error) {
        Log.v(TAG, "reportError(): error = " + error);
        boolean result = false;
        if (this.mService != null) {
            try {
                result = this.mService.reportError(error);
            } catch (RemoteException e) {
                Log.e(TAG, e.toString());
            }
        } else {
            Log.w(TAG, "Proxy not attached to service");
        }
        return result;
    }

    public boolean unplug() {
        Log.v(TAG, "unplug()");
        boolean result = false;
        if (this.mService != null) {
            try {
                result = this.mService.unplug();
            } catch (RemoteException e) {
                Log.e(TAG, e.toString());
            }
        } else {
            Log.w(TAG, "Proxy not attached to service");
        }
        return result;
    }

    public boolean connect() {
        Log.v(TAG, "connect()");
        boolean result = false;
        if (this.mService != null) {
            try {
                result = this.mService.connect();
            } catch (RemoteException e) {
                Log.e(TAG, e.toString());
            }
        } else {
            Log.w(TAG, "Proxy not attached to service");
        }
        return result;
    }

    public boolean disconnect() {
        Log.v(TAG, "disconnect()");
        boolean result = false;
        if (this.mService != null) {
            try {
                result = this.mService.disconnect();
            } catch (RemoteException e) {
                Log.e(TAG, e.toString());
            }
        } else {
            Log.w(TAG, "Proxy not attached to service");
        }
        return result;
    }
}
