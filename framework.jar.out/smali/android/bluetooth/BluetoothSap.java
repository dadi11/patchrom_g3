package android.bluetooth;

import android.bluetooth.BluetoothProfile.ServiceListener;
import android.bluetooth.IBluetoothStateChangeCallback.Stub;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.net.ProxyInfo;
import android.os.IBinder;
import android.os.Process;
import android.os.RemoteException;
import android.util.Log;
import java.util.ArrayList;
import java.util.List;

public final class BluetoothSap implements BluetoothProfile {
    public static final String ACTION_CONNECTION_STATE_CHANGED = "codeaurora.bluetooth.sap.profile.action.CONNECTION_STATE_CHANGED";
    private static final boolean DBG = false;
    private static final String TAG = "BluetoothSap";
    private static final boolean VDBG = false;
    private BluetoothAdapter mAdapter;
    private ServiceConnection mConnection;
    private Context mContext;
    private IBluetoothSap mSapService;
    private ServiceListener mServiceListener;
    private IBluetoothStateChangeCallback mStateChangeCallback;

    /* renamed from: android.bluetooth.BluetoothSap.1 */
    class C00721 extends Stub {
        C00721() {
        }

        public void onBluetoothStateChange(boolean on) {
            Log.d(BluetoothSap.TAG, "onBluetoothStateChange on: " + on);
            if (on) {
                try {
                    if (BluetoothSap.this.mSapService == null) {
                        Log.d(BluetoothSap.TAG, "onBluetoothStateChange call bindService");
                        BluetoothSap.this.doBind();
                    }
                } catch (IllegalStateException e) {
                    Log.e(BluetoothSap.TAG, "onBluetoothStateChange: could not bind to SAP service: ", e);
                } catch (SecurityException e2) {
                    Log.e(BluetoothSap.TAG, "onBluetoothStateChange: could not bind to SAP service: ", e2);
                }
                Log.d(BluetoothSap.TAG, "BluetoothSap(), bindService called");
                return;
            }
            synchronized (BluetoothSap.this.mConnection) {
                if (BluetoothSap.this.mSapService != null) {
                    try {
                        BluetoothSap.this.mSapService = null;
                        BluetoothSap.this.mContext.unbindService(BluetoothSap.this.mConnection);
                    } catch (Exception re) {
                        Log.e(BluetoothSap.TAG, ProxyInfo.LOCAL_EXCL_LIST, re);
                    }
                }
            }
        }
    }

    /* renamed from: android.bluetooth.BluetoothSap.2 */
    class C00732 implements ServiceConnection {
        C00732() {
        }

        public void onServiceConnected(ComponentName className, IBinder service) {
            BluetoothSap.this.mSapService = IBluetoothSap.Stub.asInterface(service);
            if (BluetoothSap.this.mServiceListener != null) {
                BluetoothSap.this.mServiceListener.onServiceConnected(20, BluetoothSap.this);
            }
        }

        public void onServiceDisconnected(ComponentName className) {
            BluetoothSap.this.mSapService = null;
            if (BluetoothSap.this.mServiceListener != null) {
                BluetoothSap.this.mServiceListener.onServiceDisconnected(20);
            }
        }
    }

    BluetoothSap(Context context, ServiceListener l) {
        this.mStateChangeCallback = new C00721();
        this.mConnection = new C00732();
        this.mContext = context;
        this.mServiceListener = l;
        this.mAdapter = BluetoothAdapter.getDefaultAdapter();
        try {
            this.mAdapter.getBluetoothManager().registerStateChangeCallback(this.mStateChangeCallback);
        } catch (RemoteException re) {
            Log.w(TAG, "Unable to register BluetoothStateChangeCallback", re);
        }
        Log.d(TAG, "BluetoothSap() call bindService");
        doBind();
    }

    boolean doBind() {
        Intent intent = new Intent(IBluetoothSap.class.getName());
        ComponentName comp = intent.resolveSystemService(this.mContext.getPackageManager(), 0);
        intent.setComponent(comp);
        if (comp != null && this.mContext.bindServiceAsUser(intent, this.mConnection, 0, Process.myUserHandle())) {
            return true;
        }
        Log.e(TAG, "Could not bind to Bluetooth SAP Service with " + intent);
        return DBG;
    }

    void close() {
        this.mServiceListener = null;
        IBluetoothManager mgr = this.mAdapter.getBluetoothManager();
        if (mgr != null) {
            try {
                mgr.unregisterStateChangeCallback(this.mStateChangeCallback);
            } catch (RemoteException re) {
                Log.w(TAG, "Unable to unregister BluetoothStateChangeCallback", re);
            }
        }
        synchronized (this.mConnection) {
            if (this.mSapService != null) {
                try {
                    this.mSapService = null;
                    this.mContext.unbindService(this.mConnection);
                } catch (Exception re2) {
                    Log.e(TAG, ProxyInfo.LOCAL_EXCL_LIST, re2);
                }
            }
        }
    }

    protected void finalize() {
        close();
    }

    public boolean disconnect(BluetoothDevice device) {
        boolean z = DBG;
        if (this.mSapService != null && isEnabled() && isValidDevice(device)) {
            try {
                z = this.mSapService.disconnect(device);
            } catch (RemoteException e) {
                Log.e(TAG, "Stack:" + Log.getStackTraceString(new Throwable()));
            }
        } else if (this.mSapService == null) {
            Log.w(TAG, "Proxy not attached to service");
        }
        return z;
    }

    public List<BluetoothDevice> getConnectedDevices() {
        if (this.mSapService == null || !isEnabled()) {
            if (this.mSapService == null) {
                Log.w(TAG, "Proxy not attached to service");
            }
            return new ArrayList();
        }
        try {
            return this.mSapService.getConnectedDevices();
        } catch (RemoteException e) {
            Log.e(TAG, "Stack:" + Log.getStackTraceString(new Throwable()));
            return new ArrayList();
        }
    }

    public List<BluetoothDevice> getDevicesMatchingConnectionStates(int[] states) {
        if (this.mSapService == null || !isEnabled()) {
            if (this.mSapService == null) {
                Log.w(TAG, "Proxy not attached to service");
            }
            return new ArrayList();
        }
        try {
            return this.mSapService.getDevicesMatchingConnectionStates(states);
        } catch (RemoteException e) {
            Log.e(TAG, "Stack:" + Log.getStackTraceString(new Throwable()));
            return new ArrayList();
        }
    }

    public int getConnectionState(BluetoothDevice device) {
        int i = 0;
        if (this.mSapService != null && isEnabled() && isValidDevice(device)) {
            try {
                i = this.mSapService.getConnectionState(device);
            } catch (RemoteException e) {
                Log.e(TAG, "Stack:" + Log.getStackTraceString(new Throwable()));
            }
        } else if (this.mSapService == null) {
            Log.w(TAG, "Proxy not attached to service");
        }
        return i;
    }

    private boolean isEnabled() {
        if (this.mAdapter.getState() == 12) {
            return true;
        }
        return DBG;
    }

    private boolean isValidDevice(BluetoothDevice device) {
        if (device != null && BluetoothAdapter.checkBluetoothAddress(device.getAddress())) {
            return true;
        }
        return DBG;
    }

    private static void log(String msg) {
        Log.d(TAG, msg);
    }
}
