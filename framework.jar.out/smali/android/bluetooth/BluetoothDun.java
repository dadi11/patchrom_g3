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

public final class BluetoothDun implements BluetoothProfile {
    public static final String ACTION_CONNECTION_STATE_CHANGED = "codeaurora.bluetooth.dun.profile.action.CONNECTION_STATE_CHANGED";
    private static final boolean DBG = false;
    private static final String TAG = "BluetoothDun";
    private static final boolean VDBG = false;
    private BluetoothAdapter mAdapter;
    private ServiceConnection mConnection;
    private Context mContext;
    private IBluetoothDun mDunService;
    private ServiceListener mServiceListener;
    private IBluetoothStateChangeCallback mStateChangeCallback;

    /* renamed from: android.bluetooth.BluetoothDun.1 */
    class C00441 extends Stub {
        C00441() {
        }

        public void onBluetoothStateChange(boolean on) {
            Log.d(BluetoothDun.TAG, "onBluetoothStateChange on: " + on);
            if (on) {
                try {
                    if (BluetoothDun.this.mDunService == null) {
                        Log.d(BluetoothDun.TAG, "onBluetoothStateChange call bindService");
                        BluetoothDun.this.doBind();
                        return;
                    }
                    return;
                } catch (IllegalStateException e) {
                    Log.e(BluetoothDun.TAG, "onBluetoothStateChange: could not bind to DUN service: ", e);
                    return;
                } catch (SecurityException e2) {
                    Log.e(BluetoothDun.TAG, "onBluetoothStateChange: could not bind to DUN service: ", e2);
                    return;
                }
            }
            synchronized (BluetoothDun.this.mConnection) {
                if (BluetoothDun.this.mDunService != null) {
                    try {
                        BluetoothDun.this.mDunService = null;
                        BluetoothDun.this.mContext.unbindService(BluetoothDun.this.mConnection);
                    } catch (Exception re) {
                        Log.e(BluetoothDun.TAG, ProxyInfo.LOCAL_EXCL_LIST, re);
                    }
                }
            }
        }
    }

    /* renamed from: android.bluetooth.BluetoothDun.2 */
    class C00452 implements ServiceConnection {
        C00452() {
        }

        public void onServiceConnected(ComponentName className, IBinder service) {
            BluetoothDun.this.mDunService = IBluetoothDun.Stub.asInterface(service);
            if (BluetoothDun.this.mServiceListener != null) {
                BluetoothDun.this.mServiceListener.onServiceConnected(21, BluetoothDun.this);
            }
        }

        public void onServiceDisconnected(ComponentName className) {
            BluetoothDun.this.mDunService = null;
            if (BluetoothDun.this.mServiceListener != null) {
                BluetoothDun.this.mServiceListener.onServiceDisconnected(21);
            }
        }
    }

    BluetoothDun(Context context, ServiceListener l) {
        this.mStateChangeCallback = new C00441();
        this.mConnection = new C00452();
        this.mContext = context;
        this.mServiceListener = l;
        this.mAdapter = BluetoothAdapter.getDefaultAdapter();
        try {
            this.mAdapter.getBluetoothManager().registerStateChangeCallback(this.mStateChangeCallback);
        } catch (RemoteException re) {
            Log.w(TAG, "Unable to register BluetoothStateChangeCallback", re);
        }
        Log.d(TAG, "BluetoothDun() call bindService");
        doBind();
    }

    boolean doBind() {
        Intent intent = new Intent(IBluetoothDun.class.getName());
        ComponentName comp = intent.resolveSystemService(this.mContext.getPackageManager(), 0);
        intent.setComponent(comp);
        if (comp != null && this.mContext.bindServiceAsUser(intent, this.mConnection, 0, Process.myUserHandle())) {
            return true;
        }
        Log.e(TAG, "Could not bind to Bluetooth Dun Service with " + intent);
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
            if (this.mDunService != null) {
                try {
                    this.mDunService = null;
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
        if (this.mDunService != null && isEnabled() && isValidDevice(device)) {
            try {
                z = this.mDunService.disconnect(device);
            } catch (RemoteException e) {
                Log.e(TAG, "Stack:" + Log.getStackTraceString(new Throwable()));
            }
        } else if (this.mDunService == null) {
            Log.w(TAG, "Proxy not attached to service");
        }
        return z;
    }

    public List<BluetoothDevice> getConnectedDevices() {
        if (this.mDunService == null || !isEnabled()) {
            if (this.mDunService == null) {
                Log.w(TAG, "Proxy not attached to service");
            }
            return new ArrayList();
        }
        try {
            return this.mDunService.getConnectedDevices();
        } catch (RemoteException e) {
            Log.e(TAG, "Stack:" + Log.getStackTraceString(new Throwable()));
            return new ArrayList();
        }
    }

    public List<BluetoothDevice> getDevicesMatchingConnectionStates(int[] states) {
        if (this.mDunService == null || !isEnabled()) {
            if (this.mDunService == null) {
                Log.w(TAG, "Proxy not attached to service");
            }
            return new ArrayList();
        }
        try {
            return this.mDunService.getDevicesMatchingConnectionStates(states);
        } catch (RemoteException e) {
            Log.e(TAG, "Stack:" + Log.getStackTraceString(new Throwable()));
            return new ArrayList();
        }
    }

    public int getConnectionState(BluetoothDevice device) {
        int i = 0;
        if (this.mDunService != null && isEnabled() && isValidDevice(device)) {
            try {
                i = this.mDunService.getConnectionState(device);
            } catch (RemoteException e) {
                Log.e(TAG, "Stack:" + Log.getStackTraceString(new Throwable()));
            }
        } else if (this.mDunService == null) {
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
