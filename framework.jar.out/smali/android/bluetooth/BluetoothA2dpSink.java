package android.bluetooth;

import android.bluetooth.BluetoothProfile.ServiceListener;
import android.bluetooth.IBluetoothStateChangeCallback.Stub;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.net.ProxyInfo;
import android.net.wifi.WifiManager;
import android.os.IBinder;
import android.os.Process;
import android.os.RemoteException;
import android.util.Log;
import android.widget.Toast;
import java.util.ArrayList;
import java.util.List;

public final class BluetoothA2dpSink implements BluetoothProfile {
    public static final String ACTION_AUDIO_CONFIG_CHANGED = "android.bluetooth.a2dp-sink.profile.action.AUDIO_CONFIG_CHANGED";
    public static final String ACTION_CONNECTION_STATE_CHANGED = "android.bluetooth.a2dp-sink.profile.action.CONNECTION_STATE_CHANGED";
    public static final String ACTION_PLAYING_STATE_CHANGED = "android.bluetooth.a2dp-sink.profile.action.PLAYING_STATE_CHANGED";
    private static final boolean DBG = true;
    public static final String EXTRA_AUDIO_CONFIG = "android.bluetooth.a2dp-sink.profile.extra.AUDIO_CONFIG";
    public static final int STATE_NOT_PLAYING = 11;
    public static final int STATE_PLAYING = 10;
    private static final String TAG = "BluetoothA2dpSink";
    private static final boolean VDBG = false;
    private BluetoothAdapter mAdapter;
    private final IBluetoothStateChangeCallback mBluetoothStateChangeCallback;
    private final ServiceConnection mConnection;
    private Context mContext;
    private IBluetoothA2dpSink mService;
    private ServiceListener mServiceListener;

    /* renamed from: android.bluetooth.BluetoothA2dpSink.1 */
    class C00331 extends Stub {
        C00331() {
        }

        public void onBluetoothStateChange(boolean up) {
            Log.d(BluetoothA2dpSink.TAG, "onBluetoothStateChange: up=" + up);
            if (up) {
                synchronized (BluetoothA2dpSink.this.mConnection) {
                    try {
                        if (BluetoothA2dpSink.this.mService == null) {
                            BluetoothA2dpSink.this.doBind();
                        }
                    } catch (Exception re) {
                        Log.e(BluetoothA2dpSink.TAG, ProxyInfo.LOCAL_EXCL_LIST, re);
                    }
                }
                return;
            }
            synchronized (BluetoothA2dpSink.this.mConnection) {
                try {
                    BluetoothA2dpSink.this.mService = null;
                    BluetoothA2dpSink.this.mContext.unbindService(BluetoothA2dpSink.this.mConnection);
                } catch (Exception re2) {
                    Log.e(BluetoothA2dpSink.TAG, ProxyInfo.LOCAL_EXCL_LIST, re2);
                }
            }
        }
    }

    /* renamed from: android.bluetooth.BluetoothA2dpSink.2 */
    class C00342 implements ServiceConnection {
        C00342() {
        }

        public void onServiceConnected(ComponentName className, IBinder service) {
            Log.d(BluetoothA2dpSink.TAG, "Proxy object connected");
            BluetoothA2dpSink.this.mService = IBluetoothA2dpSink.Stub.asInterface(service);
            if (BluetoothA2dpSink.this.mServiceListener != null) {
                BluetoothA2dpSink.this.mServiceListener.onServiceConnected(BluetoothA2dpSink.STATE_PLAYING, BluetoothA2dpSink.this);
            }
        }

        public void onServiceDisconnected(ComponentName className) {
            Log.d(BluetoothA2dpSink.TAG, "Proxy object disconnected");
            BluetoothA2dpSink.this.mService = null;
            if (BluetoothA2dpSink.this.mServiceListener != null) {
                BluetoothA2dpSink.this.mServiceListener.onServiceDisconnected(BluetoothA2dpSink.STATE_PLAYING);
            }
        }
    }

    BluetoothA2dpSink(Context context, ServiceListener l) {
        this.mBluetoothStateChangeCallback = new C00331();
        this.mConnection = new C00342();
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
        Intent intent = new Intent(IBluetoothA2dpSink.class.getName());
        ComponentName comp = intent.resolveSystemService(this.mContext.getPackageManager(), 0);
        intent.setComponent(comp);
        if (comp != null && this.mContext.bindServiceAsUser(intent, this.mConnection, 0, Process.myUserHandle())) {
            return DBG;
        }
        Log.e(TAG, "Could not bind to Bluetooth A2DP Service with " + intent);
        return false;
    }

    void close() {
        this.mServiceListener = null;
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
    }

    public void finalize() {
        close();
    }

    public boolean connect(BluetoothDevice device) {
        boolean z = false;
        log("connect(" + device + ")");
        if (this.mService != null && isEnabled() && isValidDevice(device)) {
            try {
                z = this.mService.connect(device);
            } catch (RemoteException e) {
                Log.e(TAG, "Stack:" + Log.getStackTraceString(new Throwable()));
            }
        } else if (this.mService == null) {
            Log.w(TAG, "Proxy not attached to service");
        }
        return z;
    }

    public boolean disconnect(BluetoothDevice device) {
        boolean z = false;
        log("disconnect(" + device + ")");
        if (this.mService != null && isEnabled() && isValidDevice(device)) {
            try {
                z = this.mService.disconnect(device);
            } catch (RemoteException e) {
                Log.e(TAG, "Stack:" + Log.getStackTraceString(new Throwable()));
            }
        } else if (this.mService == null) {
            Log.w(TAG, "Proxy not attached to service");
        }
        return z;
    }

    public List<BluetoothDevice> getConnectedDevices() {
        if (this.mService == null || !isEnabled()) {
            if (this.mService == null) {
                Log.w(TAG, "Proxy not attached to service");
            }
            return new ArrayList();
        }
        try {
            return this.mService.getConnectedDevices();
        } catch (RemoteException e) {
            Log.e(TAG, "Stack:" + Log.getStackTraceString(new Throwable()));
            return new ArrayList();
        }
    }

    public List<BluetoothDevice> getDevicesMatchingConnectionStates(int[] states) {
        if (this.mService == null || !isEnabled()) {
            if (this.mService == null) {
                Log.w(TAG, "Proxy not attached to service");
            }
            return new ArrayList();
        }
        try {
            return this.mService.getDevicesMatchingConnectionStates(states);
        } catch (RemoteException e) {
            Log.e(TAG, "Stack:" + Log.getStackTraceString(new Throwable()));
            return new ArrayList();
        }
    }

    public int getConnectionState(BluetoothDevice device) {
        int i = 0;
        if (this.mService != null && isEnabled() && isValidDevice(device)) {
            try {
                i = this.mService.getConnectionState(device);
            } catch (RemoteException e) {
                Log.e(TAG, "Stack:" + Log.getStackTraceString(new Throwable()));
            }
        } else if (this.mService == null) {
            Log.w(TAG, "Proxy not attached to service");
        }
        return i;
    }

    public BluetoothAudioConfig getAudioConfig(BluetoothDevice device) {
        BluetoothAudioConfig bluetoothAudioConfig = null;
        if (this.mService != null && isEnabled() && isValidDevice(device)) {
            try {
                bluetoothAudioConfig = this.mService.getAudioConfig(device);
            } catch (RemoteException e) {
                Log.e(TAG, "Stack:" + Log.getStackTraceString(new Throwable()));
            }
        } else if (this.mService == null) {
            Log.w(TAG, "Proxy not attached to service");
        }
        return bluetoothAudioConfig;
    }

    public boolean setPriority(BluetoothDevice device, int priority) {
        boolean z = false;
        log("setPriority(" + device + ", " + priority + ")");
        if (this.mService != null && isEnabled() && isValidDevice(device)) {
            if (priority == 0 || priority == 100) {
                try {
                    z = this.mService.setPriority(device, priority);
                } catch (RemoteException e) {
                    Log.e(TAG, "Stack:" + Log.getStackTraceString(new Throwable()));
                }
            }
        } else if (this.mService == null) {
            Log.w(TAG, "Proxy not attached to service");
        }
        return z;
    }

    public int getPriority(BluetoothDevice device) {
        int i = 0;
        if (this.mService != null && isEnabled() && isValidDevice(device)) {
            try {
                i = this.mService.getPriority(device);
            } catch (RemoteException e) {
                Log.e(TAG, "Stack:" + Log.getStackTraceString(new Throwable()));
            }
        } else if (this.mService == null) {
            Log.w(TAG, "Proxy not attached to service");
        }
        return i;
    }

    public boolean isA2dpPlaying(BluetoothDevice device) {
        boolean z = false;
        if (this.mService != null && isEnabled() && isValidDevice(device)) {
            try {
                z = this.mService.isA2dpPlaying(device);
            } catch (RemoteException e) {
                Log.e(TAG, "Stack:" + Log.getStackTraceString(new Throwable()));
            }
        } else if (this.mService == null) {
            Log.w(TAG, "Proxy not attached to service");
        }
        return z;
    }

    public static String stateToString(int state) {
        switch (state) {
            case Toast.LENGTH_SHORT /*0*/:
                return "disconnected";
            case Toast.LENGTH_LONG /*1*/:
                return "connecting";
            case Action.MERGE_IGNORE /*2*/:
                return WifiManager.EXTRA_SUPPLICANT_CONNECTED;
            case SetDrawableParameters.TAG /*3*/:
                return "disconnecting";
            case STATE_PLAYING /*10*/:
                return "playing";
            case STATE_NOT_PLAYING /*11*/:
                return "not playing";
            default:
                return "<unknown state " + state + ">";
        }
    }

    private boolean isEnabled() {
        if (this.mAdapter.getState() == 12) {
            return DBG;
        }
        return false;
    }

    private boolean isValidDevice(BluetoothDevice device) {
        if (device != null && BluetoothAdapter.checkBluetoothAddress(device.getAddress())) {
            return DBG;
        }
        return false;
    }

    private static void log(String msg) {
        Log.d(TAG, msg);
    }
}
