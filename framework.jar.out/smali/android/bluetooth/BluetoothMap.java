package android.bluetooth;

import android.bluetooth.BluetoothClass.Device;
import android.bluetooth.BluetoothProfile.ServiceListener;
import android.bluetooth.IBluetoothStateChangeCallback.Stub;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.net.ProxyInfo;
import android.opengl.GLES10;
import android.os.IBinder;
import android.os.Process;
import android.os.RemoteException;
import android.util.Log;
import android.view.inputmethod.InputMethodManager;
import java.util.ArrayList;
import java.util.List;

public final class BluetoothMap implements BluetoothProfile {
    public static final String ACTION_CONNECTION_STATE_CHANGED = "android.bluetooth.map.profile.action.CONNECTION_STATE_CHANGED";
    private static final boolean DBG = true;
    public static final int RESULT_CANCELED = 2;
    public static final int RESULT_FAILURE = 0;
    public static final int RESULT_SUCCESS = 1;
    public static final int STATE_ERROR = -1;
    private static final String TAG = "BluetoothMap";
    private static final boolean VDBG = false;
    private BluetoothAdapter mAdapter;
    private final IBluetoothStateChangeCallback mBluetoothStateChangeCallback;
    private final ServiceConnection mConnection;
    private final Context mContext;
    private IBluetoothMap mService;
    private ServiceListener mServiceListener;

    /* renamed from: android.bluetooth.BluetoothMap.1 */
    class C00641 extends Stub {
        C00641() {
        }

        public void onBluetoothStateChange(boolean up) {
            Log.d(BluetoothMap.TAG, "onBluetoothStateChange: up=" + up);
            if (up) {
                synchronized (BluetoothMap.this.mConnection) {
                    try {
                        if (BluetoothMap.this.mService == null) {
                            BluetoothMap.this.doBind();
                        }
                    } catch (Exception re) {
                        Log.e(BluetoothMap.TAG, ProxyInfo.LOCAL_EXCL_LIST, re);
                    }
                }
                return;
            }
            synchronized (BluetoothMap.this.mConnection) {
                try {
                    BluetoothMap.this.mService = null;
                    BluetoothMap.this.mContext.unbindService(BluetoothMap.this.mConnection);
                } catch (Exception re2) {
                    Log.e(BluetoothMap.TAG, ProxyInfo.LOCAL_EXCL_LIST, re2);
                }
            }
        }
    }

    /* renamed from: android.bluetooth.BluetoothMap.2 */
    class C00652 implements ServiceConnection {
        C00652() {
        }

        public void onServiceConnected(ComponentName className, IBinder service) {
            BluetoothMap.log("Proxy object connected");
            BluetoothMap.this.mService = IBluetoothMap.Stub.asInterface(service);
            if (BluetoothMap.this.mServiceListener != null) {
                BluetoothMap.this.mServiceListener.onServiceConnected(9, BluetoothMap.this);
            }
        }

        public void onServiceDisconnected(ComponentName className) {
            BluetoothMap.log("Proxy object disconnected");
            BluetoothMap.this.mService = null;
            if (BluetoothMap.this.mServiceListener != null) {
                BluetoothMap.this.mServiceListener.onServiceDisconnected(9);
            }
        }
    }

    BluetoothMap(Context context, ServiceListener l) {
        this.mBluetoothStateChangeCallback = new C00641();
        this.mConnection = new C00652();
        Log.d(TAG, "Create BluetoothMap proxy object");
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
        Intent intent = new Intent(IBluetoothMap.class.getName());
        ComponentName comp = intent.resolveSystemService(this.mContext.getPackageManager(), RESULT_FAILURE);
        intent.setComponent(comp);
        if (comp != null && this.mContext.bindServiceAsUser(intent, this.mConnection, RESULT_FAILURE, Process.myUserHandle())) {
            return DBG;
        }
        Log.e(TAG, "Could not bind to Bluetooth MAP Service with " + intent);
        return false;
    }

    protected void finalize() throws Throwable {
        try {
            close();
        } finally {
            super.finalize();
        }
    }

    public synchronized void close() {
        IBluetoothManager mgr = this.mAdapter.getBluetoothManager();
        if (mgr != null) {
            try {
                mgr.unregisterStateChangeCallback(this.mBluetoothStateChangeCallback);
            } catch (Exception e) {
                Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, e);
            }
        }
        synchronized (this.mConnection) {
            if (this.mService != null) {
                try {
                    this.mService = null;
                    this.mContext.unbindService(this.mConnection);
                } catch (Exception re) {
                    Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, re);
                }
            }
        }
        this.mServiceListener = null;
    }

    public int getState() {
        if (this.mService != null) {
            try {
                return this.mService.getState();
            } catch (RemoteException e) {
                Log.e(TAG, e.toString());
            }
        } else {
            Log.w(TAG, "Proxy not attached to service");
            log(Log.getStackTraceString(new Throwable()));
            return STATE_ERROR;
        }
    }

    public BluetoothDevice getClient() {
        if (this.mService != null) {
            try {
                return this.mService.getClient();
            } catch (RemoteException e) {
                Log.e(TAG, e.toString());
            }
        } else {
            Log.w(TAG, "Proxy not attached to service");
            log(Log.getStackTraceString(new Throwable()));
            return null;
        }
    }

    public boolean isConnected(BluetoothDevice device) {
        if (this.mService != null) {
            try {
                return this.mService.isConnected(device);
            } catch (RemoteException e) {
                Log.e(TAG, e.toString());
            }
        } else {
            Log.w(TAG, "Proxy not attached to service");
            log(Log.getStackTraceString(new Throwable()));
            return false;
        }
    }

    public boolean connect(BluetoothDevice device) {
        log("connect(" + device + ")" + "not supported for MAPS");
        return false;
    }

    public boolean disconnect(BluetoothDevice device) {
        boolean z = false;
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

    public static boolean doesClassMatchSink(BluetoothClass btClass) {
        switch (btClass.getDeviceClass()) {
            case InputMethodManager.CONTROL_START_INITIAL /*256*/:
            case GLES10.GL_ADD /*260*/:
            case Device.COMPUTER_SERVER /*264*/:
            case Device.COMPUTER_LAPTOP /*268*/:
                return DBG;
            default:
                return false;
        }
    }

    public List<BluetoothDevice> getConnectedDevices() {
        log("getConnectedDevices()");
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
        log("getDevicesMatchingStates()");
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
        int i = RESULT_FAILURE;
        log("getConnectionState(" + device + ")");
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
        boolean z = false;
        log("setPriority(" + device + ", " + priority + ")");
        if (this.mService != null && isEnabled() && isValidDevice(device)) {
            if (priority == 0 || priority == 100) {
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
        int i = RESULT_FAILURE;
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

    private static void log(String msg) {
        Log.d(TAG, msg);
    }

    private boolean isEnabled() {
        BluetoothAdapter adapter = BluetoothAdapter.getDefaultAdapter();
        if (adapter != null && adapter.getState() == 12) {
            return DBG;
        }
        log("Bluetooth is Not enabled");
        return false;
    }

    private boolean isValidDevice(BluetoothDevice device) {
        if (device != null && BluetoothAdapter.checkBluetoothAddress(device.getAddress())) {
            return DBG;
        }
        return false;
    }
}
