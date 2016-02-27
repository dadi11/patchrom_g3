package com.android.server.location;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.hardware.location.GeofenceHardwareService;
import android.hardware.location.IGeofenceHardware;
import android.hardware.location.IGeofenceHardware.Stub;
import android.location.IFusedGeofenceHardware;
import android.location.IGeofenceProvider;
import android.location.IGpsGeofenceHardware;
import android.os.Handler;
import android.os.IBinder;
import android.os.Message;
import android.os.RemoteException;
import android.os.UserHandle;
import android.util.Log;
import com.android.server.ServiceWatcher;

public final class GeofenceProxy {
    private static final int GEOFENCE_GPS_HARDWARE_CONNECTED = 4;
    private static final int GEOFENCE_GPS_HARDWARE_DISCONNECTED = 5;
    private static final int GEOFENCE_HARDWARE_CONNECTED = 2;
    private static final int GEOFENCE_HARDWARE_DISCONNECTED = 3;
    private static final int GEOFENCE_PROVIDER_CONNECTED = 1;
    private static final String SERVICE_ACTION = "com.android.location.service.GeofenceProvider";
    private static final String TAG = "GeofenceProxy";
    private final Context mContext;
    private final IFusedGeofenceHardware mFusedGeofenceHardware;
    private IGeofenceHardware mGeofenceHardware;
    private final IGpsGeofenceHardware mGpsGeofenceHardware;
    private Handler mHandler;
    private final Object mLock;
    private Runnable mRunnable;
    private ServiceConnection mServiceConnection;
    private final ServiceWatcher mServiceWatcher;

    /* renamed from: com.android.server.location.GeofenceProxy.1 */
    class C03481 implements Runnable {
        C03481() {
        }

        public void run() {
            GeofenceProxy.this.mHandler.sendEmptyMessage(GeofenceProxy.GEOFENCE_PROVIDER_CONNECTED);
        }
    }

    /* renamed from: com.android.server.location.GeofenceProxy.2 */
    class C03492 implements ServiceConnection {
        C03492() {
        }

        public void onServiceConnected(ComponentName name, IBinder service) {
            synchronized (GeofenceProxy.this.mLock) {
                GeofenceProxy.this.mGeofenceHardware = Stub.asInterface(service);
                GeofenceProxy.this.mHandler.sendEmptyMessage(GeofenceProxy.GEOFENCE_HARDWARE_CONNECTED);
            }
        }

        public void onServiceDisconnected(ComponentName name) {
            synchronized (GeofenceProxy.this.mLock) {
                GeofenceProxy.this.mGeofenceHardware = null;
                GeofenceProxy.this.mHandler.sendEmptyMessage(GeofenceProxy.GEOFENCE_HARDWARE_DISCONNECTED);
            }
        }
    }

    /* renamed from: com.android.server.location.GeofenceProxy.3 */
    class C03503 extends Handler {
        C03503() {
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case GeofenceProxy.GEOFENCE_PROVIDER_CONNECTED /*1*/:
                    synchronized (GeofenceProxy.this.mLock) {
                        if (GeofenceProxy.this.mGeofenceHardware != null) {
                            GeofenceProxy.this.setGeofenceHardwareInProviderLocked();
                        }
                        break;
                    }
                case GeofenceProxy.GEOFENCE_HARDWARE_CONNECTED /*2*/:
                    synchronized (GeofenceProxy.this.mLock) {
                        if (GeofenceProxy.this.mGeofenceHardware != null) {
                            GeofenceProxy.this.setGpsGeofenceLocked();
                            GeofenceProxy.this.setFusedGeofenceLocked();
                            GeofenceProxy.this.setGeofenceHardwareInProviderLocked();
                        }
                        break;
                    }
                case GeofenceProxy.GEOFENCE_HARDWARE_DISCONNECTED /*3*/:
                    synchronized (GeofenceProxy.this.mLock) {
                        if (GeofenceProxy.this.mGeofenceHardware == null) {
                            GeofenceProxy.this.setGeofenceHardwareInProviderLocked();
                        }
                        break;
                    }
                default:
            }
        }
    }

    public static GeofenceProxy createAndBind(Context context, int overlaySwitchResId, int defaultServicePackageNameResId, int initialPackageNamesResId, Handler handler, IGpsGeofenceHardware gpsGeofence, IFusedGeofenceHardware fusedGeofenceHardware) {
        GeofenceProxy proxy = new GeofenceProxy(context, overlaySwitchResId, defaultServicePackageNameResId, initialPackageNamesResId, handler, gpsGeofence, fusedGeofenceHardware);
        return proxy.bindGeofenceProvider() ? proxy : null;
    }

    private GeofenceProxy(Context context, int overlaySwitchResId, int defaultServicePackageNameResId, int initialPackageNamesResId, Handler handler, IGpsGeofenceHardware gpsGeofence, IFusedGeofenceHardware fusedGeofenceHardware) {
        this.mLock = new Object();
        this.mRunnable = new C03481();
        this.mServiceConnection = new C03492();
        this.mHandler = new C03503();
        this.mContext = context;
        this.mServiceWatcher = new ServiceWatcher(context, TAG, SERVICE_ACTION, overlaySwitchResId, defaultServicePackageNameResId, initialPackageNamesResId, this.mRunnable, handler);
        this.mGpsGeofenceHardware = gpsGeofence;
        this.mFusedGeofenceHardware = fusedGeofenceHardware;
        bindHardwareGeofence();
    }

    private boolean bindGeofenceProvider() {
        return this.mServiceWatcher.start();
    }

    private void bindHardwareGeofence() {
        this.mContext.bindServiceAsUser(new Intent(this.mContext, GeofenceHardwareService.class), this.mServiceConnection, GEOFENCE_PROVIDER_CONNECTED, UserHandle.OWNER);
    }

    private void setGeofenceHardwareInProviderLocked() {
        try {
            IGeofenceProvider provider = IGeofenceProvider.Stub.asInterface(this.mServiceWatcher.getBinder());
            if (provider != null) {
                provider.setGeofenceHardware(this.mGeofenceHardware);
            }
        } catch (RemoteException e) {
            Log.e(TAG, "Remote Exception: setGeofenceHardwareInProviderLocked: " + e);
        }
    }

    private void setGpsGeofenceLocked() {
        try {
            this.mGeofenceHardware.setGpsGeofenceHardware(this.mGpsGeofenceHardware);
        } catch (RemoteException e) {
            Log.e(TAG, "Error while connecting to GeofenceHardwareService");
        }
    }

    private void setFusedGeofenceLocked() {
        try {
            this.mGeofenceHardware.setFusedGeofenceHardware(this.mFusedGeofenceHardware);
        } catch (RemoteException e) {
            Log.e(TAG, "Error while connecting to GeofenceHardwareService");
        }
    }
}
