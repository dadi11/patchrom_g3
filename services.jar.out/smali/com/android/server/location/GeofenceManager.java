package com.android.server.location;

import android.app.AppOpsManager;
import android.app.PendingIntent;
import android.app.PendingIntent.CanceledException;
import android.app.PendingIntent.OnFinished;
import android.content.Context;
import android.content.Intent;
import android.location.Geofence;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.location.LocationRequest;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.SystemClock;
import android.util.Slog;
import com.android.server.LocationManagerService;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

public class GeofenceManager implements LocationListener, OnFinished {
    private static final boolean f6D;
    private static final long MAX_AGE_NANOS = 300000000000L;
    private static final long MAX_INTERVAL_MS = 7200000;
    private static final int MAX_SPEED_M_S = 100;
    private static final long MIN_INTERVAL_MS = 60000;
    private static final int MSG_UPDATE_FENCES = 1;
    private static final String TAG = "GeofenceManager";
    private final AppOpsManager mAppOps;
    private final LocationBlacklist mBlacklist;
    private final Context mContext;
    private List<GeofenceState> mFences;
    private final GeofenceHandler mHandler;
    private Location mLastLocationUpdate;
    private final LocationManager mLocationManager;
    private long mLocationUpdateInterval;
    private Object mLock;
    private boolean mPendingUpdate;
    private boolean mReceivingLocationUpdates;
    private final WakeLock mWakeLock;

    private final class GeofenceHandler extends Handler {
        public GeofenceHandler() {
            super(true);
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case GeofenceManager.MSG_UPDATE_FENCES /*1*/:
                    GeofenceManager.this.updateFences();
                default:
            }
        }
    }

    static {
        f6D = LocationManagerService.f0D;
    }

    public GeofenceManager(Context context, LocationBlacklist blacklist) {
        this.mLock = new Object();
        this.mFences = new LinkedList();
        this.mContext = context;
        this.mLocationManager = (LocationManager) this.mContext.getSystemService("location");
        this.mAppOps = (AppOpsManager) this.mContext.getSystemService("appops");
        this.mWakeLock = ((PowerManager) this.mContext.getSystemService("power")).newWakeLock(MSG_UPDATE_FENCES, TAG);
        this.mHandler = new GeofenceHandler();
        this.mBlacklist = blacklist;
    }

    public void addFence(LocationRequest request, Geofence geofence, PendingIntent intent, int allowedResolutionLevel, int uid, String packageName) {
        if (f6D) {
            Slog.d(TAG, "addFence: request=" + request + ", geofence=" + geofence + ", intent=" + intent + ", uid=" + uid + ", packageName=" + packageName);
        }
        GeofenceState state = new GeofenceState(geofence, request.getExpireAt(), allowedResolutionLevel, uid, packageName, intent);
        synchronized (this.mLock) {
            for (int i = this.mFences.size() - 1; i >= 0; i--) {
                GeofenceState w = (GeofenceState) this.mFences.get(i);
                if (geofence.equals(w.mFence) && intent.equals(w.mIntent)) {
                    this.mFences.remove(i);
                    break;
                }
            }
            this.mFences.add(state);
            scheduleUpdateFencesLocked();
        }
    }

    public void removeFence(Geofence fence, PendingIntent intent) {
        if (f6D) {
            Slog.d(TAG, "removeFence: fence=" + fence + ", intent=" + intent);
        }
        synchronized (this.mLock) {
            Iterator<GeofenceState> iter = this.mFences.iterator();
            while (iter.hasNext()) {
                GeofenceState state = (GeofenceState) iter.next();
                if (state.mIntent.equals(intent)) {
                    if (fence == null) {
                        iter.remove();
                    } else if (fence.equals(state.mFence)) {
                        iter.remove();
                    }
                }
            }
            scheduleUpdateFencesLocked();
        }
    }

    public void removeFence(String packageName) {
        if (f6D) {
            Slog.d(TAG, "removeFence: packageName=" + packageName);
        }
        synchronized (this.mLock) {
            Iterator<GeofenceState> iter = this.mFences.iterator();
            while (iter.hasNext()) {
                if (((GeofenceState) iter.next()).mPackageName.equals(packageName)) {
                    iter.remove();
                }
            }
            scheduleUpdateFencesLocked();
        }
    }

    private void removeExpiredFencesLocked() {
        long time = SystemClock.elapsedRealtime();
        Iterator<GeofenceState> iter = this.mFences.iterator();
        while (iter.hasNext()) {
            if (((GeofenceState) iter.next()).mExpireAt < time) {
                iter.remove();
            }
        }
    }

    private void scheduleUpdateFencesLocked() {
        if (!this.mPendingUpdate) {
            this.mPendingUpdate = true;
            this.mHandler.sendEmptyMessage(MSG_UPDATE_FENCES);
        }
    }

    private Location getFreshLocationLocked() {
        Location location = this.mReceivingLocationUpdates ? this.mLastLocationUpdate : null;
        if (location == null && !this.mFences.isEmpty()) {
            location = this.mLocationManager.getLastLocation();
        }
        if (location == null) {
            return null;
        }
        if (SystemClock.elapsedRealtimeNanos() - location.getElapsedRealtimeNanos() > MAX_AGE_NANOS) {
            return null;
        }
        return location;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void updateFences() {
        /*
        r30 = this;
        r4 = new java.util.LinkedList;
        r4.<init>();
        r6 = new java.util.LinkedList;
        r6.<init>();
        r0 = r30;
        r0 = r0.mLock;
        r21 = r0;
        monitor-enter(r21);
        r20 = 0;
        r0 = r20;
        r1 = r30;
        r1.mPendingUpdate = r0;	 Catch:{ all -> 0x007a }
        r30.removeExpiredFencesLocked();	 Catch:{ all -> 0x007a }
        r11 = r30.getFreshLocationLocked();	 Catch:{ all -> 0x007a }
        r14 = 9218868437227405311; // 0x7fefffffffffffff float:NaN double:1.7976931348623157E308;
        r16 = 0;
        r0 = r30;
        r0 = r0.mFences;	 Catch:{ all -> 0x007a }
        r20 = r0;
        r7 = r20.iterator();	 Catch:{ all -> 0x007a }
    L_0x0031:
        r20 = r7.hasNext();	 Catch:{ all -> 0x007a }
        if (r20 == 0) goto L_0x0106;
    L_0x0037:
        r19 = r7.next();	 Catch:{ all -> 0x007a }
        r19 = (com.android.server.location.GeofenceState) r19;	 Catch:{ all -> 0x007a }
        r0 = r30;
        r0 = r0.mBlacklist;	 Catch:{ all -> 0x007a }
        r20 = r0;
        r0 = r19;
        r0 = r0.mPackageName;	 Catch:{ all -> 0x007a }
        r22 = r0;
        r0 = r20;
        r1 = r22;
        r20 = r0.isBlacklisted(r1);	 Catch:{ all -> 0x007a }
        if (r20 == 0) goto L_0x007d;
    L_0x0053:
        r20 = f6D;	 Catch:{ all -> 0x007a }
        if (r20 == 0) goto L_0x0031;
    L_0x0057:
        r20 = "GeofenceManager";
        r22 = new java.lang.StringBuilder;	 Catch:{ all -> 0x007a }
        r22.<init>();	 Catch:{ all -> 0x007a }
        r23 = "skipping geofence processing for blacklisted app: ";
        r22 = r22.append(r23);	 Catch:{ all -> 0x007a }
        r0 = r19;
        r0 = r0.mPackageName;	 Catch:{ all -> 0x007a }
        r23 = r0;
        r22 = r22.append(r23);	 Catch:{ all -> 0x007a }
        r22 = r22.toString();	 Catch:{ all -> 0x007a }
        r0 = r20;
        r1 = r22;
        android.util.Slog.d(r0, r1);	 Catch:{ all -> 0x007a }
        goto L_0x0031;
    L_0x007a:
        r20 = move-exception;
        monitor-exit(r21);	 Catch:{ all -> 0x007a }
        throw r20;
    L_0x007d:
        r0 = r19;
        r0 = r0.mAllowedResolutionLevel;	 Catch:{ all -> 0x007a }
        r20 = r0;
        r17 = com.android.server.LocationManagerService.resolutionLevelToOp(r20);	 Catch:{ all -> 0x007a }
        if (r17 < 0) goto L_0x00d3;
    L_0x0089:
        r0 = r30;
        r0 = r0.mAppOps;	 Catch:{ all -> 0x007a }
        r20 = r0;
        r22 = 1;
        r0 = r19;
        r0 = r0.mUid;	 Catch:{ all -> 0x007a }
        r23 = r0;
        r0 = r19;
        r0 = r0.mPackageName;	 Catch:{ all -> 0x007a }
        r24 = r0;
        r0 = r20;
        r1 = r22;
        r2 = r23;
        r3 = r24;
        r20 = r0.noteOpNoThrow(r1, r2, r3);	 Catch:{ all -> 0x007a }
        if (r20 == 0) goto L_0x00d3;
    L_0x00ab:
        r20 = f6D;	 Catch:{ all -> 0x007a }
        if (r20 == 0) goto L_0x0031;
    L_0x00af:
        r20 = "GeofenceManager";
        r22 = new java.lang.StringBuilder;	 Catch:{ all -> 0x007a }
        r22.<init>();	 Catch:{ all -> 0x007a }
        r23 = "skipping geofence processing for no op app: ";
        r22 = r22.append(r23);	 Catch:{ all -> 0x007a }
        r0 = r19;
        r0 = r0.mPackageName;	 Catch:{ all -> 0x007a }
        r23 = r0;
        r22 = r22.append(r23);	 Catch:{ all -> 0x007a }
        r22 = r22.toString();	 Catch:{ all -> 0x007a }
        r0 = r20;
        r1 = r22;
        android.util.Slog.d(r0, r1);	 Catch:{ all -> 0x007a }
        goto L_0x0031;
    L_0x00d3:
        r16 = 1;
        if (r11 == 0) goto L_0x0031;
    L_0x00d7:
        r0 = r19;
        r5 = r0.processLocation(r11);	 Catch:{ all -> 0x007a }
        r20 = r5 & 1;
        if (r20 == 0) goto L_0x00ec;
    L_0x00e1:
        r0 = r19;
        r0 = r0.mIntent;	 Catch:{ all -> 0x007a }
        r20 = r0;
        r0 = r20;
        r4.add(r0);	 Catch:{ all -> 0x007a }
    L_0x00ec:
        r20 = r5 & 2;
        if (r20 == 0) goto L_0x00fb;
    L_0x00f0:
        r0 = r19;
        r0 = r0.mIntent;	 Catch:{ all -> 0x007a }
        r20 = r0;
        r0 = r20;
        r6.add(r0);	 Catch:{ all -> 0x007a }
    L_0x00fb:
        r8 = r19.getDistanceToBoundary();	 Catch:{ all -> 0x007a }
        r20 = (r8 > r14 ? 1 : (r8 == r14 ? 0 : -1));
        if (r20 >= 0) goto L_0x0031;
    L_0x0103:
        r14 = r8;
        goto L_0x0031;
    L_0x0106:
        if (r16 == 0) goto L_0x020e;
    L_0x0108:
        if (r11 == 0) goto L_0x0209;
    L_0x010a:
        r22 = 9218868437227405311; // 0x7fefffffffffffff float:NaN double:1.7976931348623157E308;
        r0 = r22;
        r20 = java.lang.Double.compare(r14, r0);	 Catch:{ all -> 0x007a }
        if (r20 == 0) goto L_0x0209;
    L_0x0117:
        r22 = 4709488952107597824; // 0x415b774000000000 float:0.0 double:7200000.0;
        r24 = 4678479150791524352; // 0x40ed4c0000000000 float:0.0 double:60000.0;
        r26 = 4652007308841189376; // 0x408f400000000000 float:0.0 double:1000.0;
        r26 = r26 * r14;
        r28 = 4636737291354636288; // 0x4059000000000000 float:0.0 double:100.0;
        r26 = r26 / r28;
        r24 = java.lang.Math.max(r24, r26);	 Catch:{ all -> 0x007a }
        r22 = java.lang.Math.min(r22, r24);	 Catch:{ all -> 0x007a }
        r0 = r22;
        r12 = (long) r0;	 Catch:{ all -> 0x007a }
    L_0x0137:
        r0 = r30;
        r0 = r0.mReceivingLocationUpdates;	 Catch:{ all -> 0x007a }
        r20 = r0;
        if (r20 == 0) goto L_0x0149;
    L_0x013f:
        r0 = r30;
        r0 = r0.mLocationUpdateInterval;	 Catch:{ all -> 0x007a }
        r22 = r0;
        r20 = (r22 > r12 ? 1 : (r22 == r12 ? 0 : -1));
        if (r20 == 0) goto L_0x0188;
    L_0x0149:
        r20 = 1;
        r0 = r20;
        r1 = r30;
        r1.mReceivingLocationUpdates = r0;	 Catch:{ all -> 0x007a }
        r0 = r30;
        r0.mLocationUpdateInterval = r12;	 Catch:{ all -> 0x007a }
        r0 = r30;
        r0.mLastLocationUpdate = r11;	 Catch:{ all -> 0x007a }
        r18 = new android.location.LocationRequest;	 Catch:{ all -> 0x007a }
        r18.<init>();	 Catch:{ all -> 0x007a }
        r0 = r18;
        r20 = r0.setInterval(r12);	 Catch:{ all -> 0x007a }
        r22 = 0;
        r0 = r20;
        r1 = r22;
        r0.setFastestInterval(r1);	 Catch:{ all -> 0x007a }
        r0 = r30;
        r0 = r0.mLocationManager;	 Catch:{ all -> 0x007a }
        r20 = r0;
        r0 = r30;
        r0 = r0.mHandler;	 Catch:{ all -> 0x007a }
        r22 = r0;
        r22 = r22.getLooper();	 Catch:{ all -> 0x007a }
        r0 = r20;
        r1 = r18;
        r2 = r30;
        r3 = r22;
        r0.requestLocationUpdates(r1, r2, r3);	 Catch:{ all -> 0x007a }
    L_0x0188:
        r20 = f6D;	 Catch:{ all -> 0x007a }
        if (r20 == 0) goto L_0x01f2;
    L_0x018c:
        r20 = "GeofenceManager";
        r22 = new java.lang.StringBuilder;	 Catch:{ all -> 0x007a }
        r22.<init>();	 Catch:{ all -> 0x007a }
        r23 = "updateFences: location=";
        r22 = r22.append(r23);	 Catch:{ all -> 0x007a }
        r0 = r22;
        r22 = r0.append(r11);	 Catch:{ all -> 0x007a }
        r23 = ", mFences.size()=";
        r22 = r22.append(r23);	 Catch:{ all -> 0x007a }
        r0 = r30;
        r0 = r0.mFences;	 Catch:{ all -> 0x007a }
        r23 = r0;
        r23 = r23.size();	 Catch:{ all -> 0x007a }
        r22 = r22.append(r23);	 Catch:{ all -> 0x007a }
        r23 = ", mReceivingLocationUpdates=";
        r22 = r22.append(r23);	 Catch:{ all -> 0x007a }
        r0 = r30;
        r0 = r0.mReceivingLocationUpdates;	 Catch:{ all -> 0x007a }
        r23 = r0;
        r22 = r22.append(r23);	 Catch:{ all -> 0x007a }
        r23 = ", mLocationUpdateInterval=";
        r22 = r22.append(r23);	 Catch:{ all -> 0x007a }
        r0 = r30;
        r0 = r0.mLocationUpdateInterval;	 Catch:{ all -> 0x007a }
        r24 = r0;
        r0 = r22;
        r1 = r24;
        r22 = r0.append(r1);	 Catch:{ all -> 0x007a }
        r23 = ", mLastLocationUpdate=";
        r22 = r22.append(r23);	 Catch:{ all -> 0x007a }
        r0 = r30;
        r0 = r0.mLastLocationUpdate;	 Catch:{ all -> 0x007a }
        r23 = r0;
        r22 = r22.append(r23);	 Catch:{ all -> 0x007a }
        r22 = r22.toString();	 Catch:{ all -> 0x007a }
        r0 = r20;
        r1 = r22;
        android.util.Slog.d(r0, r1);	 Catch:{ all -> 0x007a }
    L_0x01f2:
        monitor-exit(r21);	 Catch:{ all -> 0x007a }
        r7 = r6.iterator();
    L_0x01f7:
        r20 = r7.hasNext();
        if (r20 == 0) goto L_0x023d;
    L_0x01fd:
        r10 = r7.next();
        r10 = (android.app.PendingIntent) r10;
        r0 = r30;
        r0.sendIntentExit(r10);
        goto L_0x01f7;
    L_0x0209:
        r12 = 60000; // 0xea60 float:8.4078E-41 double:2.9644E-319;
        goto L_0x0137;
    L_0x020e:
        r0 = r30;
        r0 = r0.mReceivingLocationUpdates;	 Catch:{ all -> 0x007a }
        r20 = r0;
        if (r20 == 0) goto L_0x0188;
    L_0x0216:
        r20 = 0;
        r0 = r20;
        r1 = r30;
        r1.mReceivingLocationUpdates = r0;	 Catch:{ all -> 0x007a }
        r22 = 0;
        r0 = r22;
        r2 = r30;
        r2.mLocationUpdateInterval = r0;	 Catch:{ all -> 0x007a }
        r20 = 0;
        r0 = r20;
        r1 = r30;
        r1.mLastLocationUpdate = r0;	 Catch:{ all -> 0x007a }
        r0 = r30;
        r0 = r0.mLocationManager;	 Catch:{ all -> 0x007a }
        r20 = r0;
        r0 = r20;
        r1 = r30;
        r0.removeUpdates(r1);	 Catch:{ all -> 0x007a }
        goto L_0x0188;
    L_0x023d:
        r7 = r4.iterator();
    L_0x0241:
        r20 = r7.hasNext();
        if (r20 == 0) goto L_0x0253;
    L_0x0247:
        r10 = r7.next();
        r10 = (android.app.PendingIntent) r10;
        r0 = r30;
        r0.sendIntentEnter(r10);
        goto L_0x0241;
    L_0x0253:
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.location.GeofenceManager.updateFences():void");
    }

    private void sendIntentEnter(PendingIntent pendingIntent) {
        if (f6D) {
            Slog.d(TAG, "sendIntentEnter: pendingIntent=" + pendingIntent);
        }
        Intent intent = new Intent();
        intent.putExtra("entering", true);
        sendIntent(pendingIntent, intent);
    }

    private void sendIntentExit(PendingIntent pendingIntent) {
        if (f6D) {
            Slog.d(TAG, "sendIntentExit: pendingIntent=" + pendingIntent);
        }
        Intent intent = new Intent();
        intent.putExtra("entering", f6D);
        sendIntent(pendingIntent, intent);
    }

    private void sendIntent(PendingIntent pendingIntent, Intent intent) {
        this.mWakeLock.acquire();
        try {
            pendingIntent.send(this.mContext, 0, intent, this, null, "android.permission.ACCESS_FINE_LOCATION");
        } catch (CanceledException e) {
            removeFence(null, pendingIntent);
            this.mWakeLock.release();
        }
    }

    public void onLocationChanged(Location location) {
        synchronized (this.mLock) {
            if (this.mReceivingLocationUpdates) {
                this.mLastLocationUpdate = location;
            }
            if (this.mPendingUpdate) {
                this.mHandler.removeMessages(MSG_UPDATE_FENCES);
            } else {
                this.mPendingUpdate = true;
            }
        }
        updateFences();
    }

    public void onStatusChanged(String provider, int status, Bundle extras) {
    }

    public void onProviderEnabled(String provider) {
    }

    public void onProviderDisabled(String provider) {
    }

    public void onSendFinished(PendingIntent pendingIntent, Intent intent, int resultCode, String resultData, Bundle resultExtras) {
        this.mWakeLock.release();
    }

    public void dump(PrintWriter pw) {
        pw.println("  Geofences:");
        for (GeofenceState state : this.mFences) {
            pw.append("    ");
            pw.append(state.mPackageName);
            pw.append(" ");
            pw.append(state.mFence.toString());
            pw.append("\n");
        }
    }
}
