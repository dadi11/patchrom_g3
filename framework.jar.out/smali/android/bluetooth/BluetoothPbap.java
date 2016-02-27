package android.bluetooth;

import android.bluetooth.BluetoothClass.Device;
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

public class BluetoothPbap {
    private static final boolean DBG = true;
    public static final String PBAP_PREVIOUS_STATE = "android.bluetooth.pbap.intent.PBAP_PREVIOUS_STATE";
    public static final String PBAP_STATE = "android.bluetooth.pbap.intent.PBAP_STATE";
    public static final String PBAP_STATE_CHANGED_ACTION = "android.bluetooth.pbap.intent.action.PBAP_STATE_CHANGED";
    public static final int RESULT_CANCELED = 2;
    public static final int RESULT_FAILURE = 0;
    public static final int RESULT_SUCCESS = 1;
    public static final int STATE_CONNECTED = 2;
    public static final int STATE_CONNECTING = 1;
    public static final int STATE_DISCONNECTED = 0;
    public static final int STATE_ERROR = -1;
    private static final String TAG = "BluetoothPbap";
    private static final boolean VDBG = false;
    private BluetoothAdapter mAdapter;
    private final IBluetoothStateChangeCallback mBluetoothStateChangeCallback;
    private final ServiceConnection mConnection;
    private final Context mContext;
    private IBluetoothPbap mService;
    private ServiceListener mServiceListener;

    /* renamed from: android.bluetooth.BluetoothPbap.1 */
    class C00691 extends Stub {
        C00691() {
        }

        public void onBluetoothStateChange(boolean up) {
            Log.d(BluetoothPbap.TAG, "onBluetoothStateChange: up=" + up);
            if (up) {
                synchronized (BluetoothPbap.this.mConnection) {
                    try {
                        if (BluetoothPbap.this.mService == null) {
                            BluetoothPbap.this.doBind();
                        }
                    } catch (Exception re) {
                        Log.e(BluetoothPbap.TAG, ProxyInfo.LOCAL_EXCL_LIST, re);
                    }
                }
                return;
            }
            synchronized (BluetoothPbap.this.mConnection) {
                try {
                    BluetoothPbap.this.mService = null;
                    BluetoothPbap.this.mContext.unbindService(BluetoothPbap.this.mConnection);
                } catch (Exception re2) {
                    Log.e(BluetoothPbap.TAG, ProxyInfo.LOCAL_EXCL_LIST, re2);
                }
            }
        }
    }

    /* renamed from: android.bluetooth.BluetoothPbap.2 */
    class C00702 implements ServiceConnection {
        C00702() {
        }

        public void onServiceConnected(ComponentName className, IBinder service) {
            BluetoothPbap.log("Proxy object connected");
            BluetoothPbap.this.mService = IBluetoothPbap.Stub.asInterface(service);
            if (BluetoothPbap.this.mServiceListener != null) {
                BluetoothPbap.this.mServiceListener.onServiceConnected(BluetoothPbap.this);
            }
        }

        public void onServiceDisconnected(ComponentName className) {
            BluetoothPbap.log("Proxy object disconnected");
            BluetoothPbap.this.mService = null;
            if (BluetoothPbap.this.mServiceListener != null) {
                BluetoothPbap.this.mServiceListener.onServiceDisconnected();
            }
        }
    }

    public interface ServiceListener {
        void onServiceConnected(BluetoothPbap bluetoothPbap);

        void onServiceDisconnected();
    }

    public BluetoothPbap(Context context, ServiceListener l) {
        this.mBluetoothStateChangeCallback = new C00691();
        this.mConnection = new C00702();
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
        Intent intent = new Intent(IBluetoothPbap.class.getName());
        ComponentName comp = intent.resolveSystemService(this.mContext.getPackageManager(), STATE_DISCONNECTED);
        intent.setComponent(comp);
        if (comp != null && this.mContext.bindServiceAsUser(intent, this.mConnection, STATE_DISCONNECTED, Process.myUserHandle())) {
            return DBG;
        }
        Log.e(TAG, "Could not bind to Bluetooth Pbap Service with " + intent);
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

    public boolean disconnect() {
        log("disconnect()");
        if (this.mService != null) {
            try {
                this.mService.disconnect();
                return DBG;
            } catch (RemoteException e) {
                Log.e(TAG, e.toString());
            }
        } else {
            Log.w(TAG, "Proxy not attached to service");
            log(Log.getStackTraceString(new Throwable()));
            return false;
        }
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

    private static void log(String msg) {
        Log.d(TAG, msg);
    }
}
