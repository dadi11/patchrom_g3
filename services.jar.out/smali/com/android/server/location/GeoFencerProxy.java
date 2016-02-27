package com.android.server.location;

import android.app.PendingIntent;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.location.GeoFenceParams;
import android.location.IGeoFenceListener.Stub;
import android.location.IGeoFencer;
import android.os.IBinder;
import android.os.RemoteException;
import android.util.Log;

public class GeoFencerProxy extends GeoFencerBase {
    private static final boolean LOGV_ENABLED = true;
    private static final String TAG = "GeoFencerProxy";
    private static GeoFencerProxy mGeoFencerProxy;
    private final Context mContext;
    private IGeoFencer mGeoFencer;
    private final Intent mIntent;
    private final Stub mListener;
    private final ServiceConnection mServiceConnection;

    /* renamed from: com.android.server.location.GeoFencerProxy.1 */
    class C03461 implements ServiceConnection {
        C03461() {
        }

        public void onServiceConnected(ComponentName className, IBinder service) {
            synchronized (this) {
                GeoFencerProxy.this.mGeoFencer = IGeoFencer.Stub.asInterface(service);
                notifyAll();
            }
            Log.v(GeoFencerProxy.TAG, "onServiceConnected: mGeoFencer - " + GeoFencerProxy.this.mGeoFencer);
        }

        public void onServiceDisconnected(ComponentName className) {
            synchronized (this) {
                GeoFencerProxy.this.mGeoFencer = null;
            }
            Log.v(GeoFencerProxy.TAG, "onServiceDisconnected");
        }
    }

    /* renamed from: com.android.server.location.GeoFencerProxy.2 */
    class C03472 extends Stub {
        C03472() {
        }

        public void geoFenceExpired(PendingIntent intent) throws RemoteException {
            GeoFencerProxy.this.logv("geoFenceExpired - " + intent);
            GeoFencerProxy.this.remove(intent, GeoFencerProxy.LOGV_ENABLED);
        }
    }

    public static GeoFencerProxy getGeoFencerProxy(Context context, String serviceName) {
        if (mGeoFencerProxy == null) {
            mGeoFencerProxy = new GeoFencerProxy(context, serviceName);
        }
        return mGeoFencerProxy;
    }

    private GeoFencerProxy(Context context, String serviceName) {
        this.mServiceConnection = new C03461();
        this.mListener = new C03472();
        this.mContext = context;
        this.mIntent = new Intent();
        this.mIntent.setPackage(serviceName);
        this.mContext.bindService(this.mIntent, this.mServiceConnection, 21);
    }

    public void removeCaller(int uid) {
        super.removeCaller(uid);
        if (this.mGeoFencer != null) {
            try {
                this.mGeoFencer.clearGeoFenceUser(uid);
                return;
            } catch (RemoteException e) {
                return;
            }
        }
        Log.e(TAG, "removeCaller - mGeoFencer is null");
    }

    private boolean ensureGeoFencer() {
        if (this.mGeoFencer == null) {
            try {
                synchronized (this.mServiceConnection) {
                    logv("waiting...");
                    this.mServiceConnection.wait(60000);
                    logv("woke up!!!");
                }
                if (this.mGeoFencer == null) {
                    Log.w(TAG, "Timed out. No GeoFencer connection");
                    return false;
                }
            } catch (InterruptedException e) {
                Log.w(TAG, "Interrupted while waiting for GeoFencer");
                return false;
            }
        }
        return LOGV_ENABLED;
    }

    protected boolean start(GeoFenceParams geofence) {
        if (ensureGeoFencer()) {
            try {
                return this.mGeoFencer.setGeoFence(this.mListener, geofence);
            } catch (RemoteException e) {
            }
        }
        return false;
    }

    protected boolean stop(PendingIntent intent) {
        if (ensureGeoFencer()) {
            try {
                this.mGeoFencer.clearGeoFence(this.mListener, intent);
                return LOGV_ENABLED;
            } catch (RemoteException e) {
            }
        }
        return false;
    }

    private void logv(String s) {
        Log.v(TAG, s);
    }
}
