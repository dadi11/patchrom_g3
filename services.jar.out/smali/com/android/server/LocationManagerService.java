package com.android.server;

import android.app.AppOpsManager;
import android.app.AppOpsManager.OnOpChangedInternalListener;
import android.app.PendingIntent;
import android.app.PendingIntent.CanceledException;
import android.app.PendingIntent.OnFinished;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.ResolveInfo;
import android.content.pm.Signature;
import android.content.pm.UserInfo;
import android.content.res.Resources;
import android.database.ContentObserver;
import android.hardware.location.ActivityRecognitionHardware;
import android.location.Address;
import android.location.Criteria;
import android.location.GeoFenceParams;
import android.location.GeocoderParams;
import android.location.Geofence;
import android.location.IGpsMeasurementsListener;
import android.location.IGpsNavigationMessageListener;
import android.location.IGpsStatusListener;
import android.location.IGpsStatusProvider;
import android.location.ILocationListener;
import android.location.ILocationManager.Stub;
import android.location.INetInitiatedListener;
import android.location.Location;
import android.location.LocationProvider;
import android.location.LocationRequest;
import android.os.Binder;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.Looper;
import android.os.Message;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.Process;
import android.os.RemoteException;
import android.os.SystemClock;
import android.os.UserHandle;
import android.os.UserManager;
import android.os.WorkSource;
import android.provider.Settings.Secure;
import android.util.Log;
import android.util.Slog;
import com.android.internal.content.PackageMonitor;
import com.android.internal.location.ProviderProperties;
import com.android.internal.location.ProviderRequest;
import com.android.internal.os.BackgroundThread;
import com.android.server.job.controllers.JobStatus;
import com.android.server.location.ActivityRecognitionProxy;
import com.android.server.location.FlpHardwareProvider;
import com.android.server.location.FusedProxy;
import com.android.server.location.GeoFencerBase;
import com.android.server.location.GeoFencerProxy;
import com.android.server.location.GeocoderProxy;
import com.android.server.location.GeofenceManager;
import com.android.server.location.GeofenceProxy;
import com.android.server.location.GpsLocationProvider;
import com.android.server.location.GpsMeasurementsProvider;
import com.android.server.location.GpsNavigationMessageProvider;
import com.android.server.location.LocationBlacklist;
import com.android.server.location.LocationFudger;
import com.android.server.location.LocationProviderInterface;
import com.android.server.location.LocationProviderProxy;
import com.android.server.location.LocationRequestStatistics;
import com.android.server.location.LocationRequestStatistics.PackageProviderKey;
import com.android.server.location.LocationRequestStatistics.PackageStatistics;
import com.android.server.location.MockProvider;
import com.android.server.location.PassiveProvider;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;
import java.util.Set;

public class LocationManagerService extends Stub {
    private static final String ACCESS_LOCATION_EXTRA_COMMANDS = "android.permission.ACCESS_LOCATION_EXTRA_COMMANDS";
    private static final String ACCESS_MOCK_LOCATION = "android.permission.ACCESS_MOCK_LOCATION";
    public static final boolean f0D;
    private static final LocationRequest DEFAULT_LOCATION_REQUEST;
    private static final String FUSED_LOCATION_SERVICE_ACTION = "com.android.location.service.FusedLocationProvider";
    private static final long HIGH_POWER_INTERVAL_MS = 300000;
    private static final String INSTALL_LOCATION_PROVIDER = "android.permission.INSTALL_LOCATION_PROVIDER";
    private static final int MAX_PROVIDER_SCHEDULING_JITTER_MS = 100;
    private static final int MSG_LOCATION_CHANGED = 1;
    private static final long NANOS_PER_MILLI = 1000000;
    private static final String NETWORK_LOCATION_SERVICE_ACTION = "com.android.location.service.v3.NetworkLocationProvider";
    private static final int RESOLUTION_LEVEL_COARSE = 1;
    private static final int RESOLUTION_LEVEL_FINE = 2;
    private static final int RESOLUTION_LEVEL_NONE = 0;
    private static final String TAG = "LocationManagerService";
    private static final String WAKELOCK_KEY = "LocationManagerService";
    private final AppOpsManager mAppOps;
    private LocationBlacklist mBlacklist;
    private String mComboNlpPackageName;
    private String mComboNlpReadyMarker;
    private String mComboNlpScreenMarker;
    private final Context mContext;
    private int mCurrentUserId;
    private int[] mCurrentUserProfiles;
    private final Set<String> mDisabledProviders;
    private final Set<String> mEnabledProviders;
    private GeoFencerBase mGeoFencer;
    private boolean mGeoFencerEnabled;
    private String mGeoFencerPackageName;
    private GeocoderProxy mGeocodeProvider;
    private GeofenceManager mGeofenceManager;
    private GpsMeasurementsProvider mGpsMeasurementsProvider;
    private GpsNavigationMessageProvider mGpsNavigationMessageProvider;
    private IGpsStatusProvider mGpsStatusProvider;
    private final HashMap<String, Location> mLastLocation;
    private final HashMap<String, Location> mLastLocationCoarseInterval;
    private LocationFudger mLocationFudger;
    private LocationWorkerHandler mLocationHandler;
    private final Object mLock;
    private final HashMap<String, MockProvider> mMockProviders;
    private INetInitiatedListener mNetInitiatedListener;
    private PackageManager mPackageManager;
    private final PackageMonitor mPackageMonitor;
    private PassiveProvider mPassiveProvider;
    private PowerManager mPowerManager;
    private final ArrayList<LocationProviderInterface> mProviders;
    private final HashMap<String, LocationProviderInterface> mProvidersByName;
    private final ArrayList<LocationProviderProxy> mProxyProviders;
    private final HashMap<String, LocationProviderInterface> mRealProviders;
    private final HashMap<Object, Receiver> mReceivers;
    private final HashMap<String, ArrayList<UpdateRecord>> mRecordsByProvider;
    private final LocationRequestStatistics mRequestStatistics;
    private UserManager mUserManager;

    /* renamed from: com.android.server.LocationManagerService.1 */
    class C00501 extends OnOpChangedInternalListener {
        C00501() {
        }

        public void onOpChanged(int op, String packageName) {
            synchronized (LocationManagerService.this.mLock) {
                for (Receiver receiver : LocationManagerService.this.mReceivers.values()) {
                    receiver.updateMonitoring(true);
                }
                LocationManagerService.this.applyAllProviderRequirementsLocked();
            }
        }
    }

    /* renamed from: com.android.server.LocationManagerService.2 */
    class C00512 extends ContentObserver {
        C00512(Handler x0) {
            super(x0);
        }

        public void onChange(boolean selfChange) {
            synchronized (LocationManagerService.this.mLock) {
                LocationManagerService.this.updateProvidersLocked();
            }
        }
    }

    /* renamed from: com.android.server.LocationManagerService.3 */
    class C00523 extends BroadcastReceiver {
        C00523() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if ("android.intent.action.USER_SWITCHED".equals(action)) {
                LocationManagerService.this.switchUser(intent.getIntExtra("android.intent.extra.user_handle", LocationManagerService.RESOLUTION_LEVEL_NONE));
            } else if ("android.intent.action.MANAGED_PROFILE_ADDED".equals(action) || "android.intent.action.MANAGED_PROFILE_REMOVED".equals(action)) {
                LocationManagerService.this.updateUserProfiles(LocationManagerService.this.mCurrentUserId);
            }
        }
    }

    /* renamed from: com.android.server.LocationManagerService.4 */
    class C00534 extends PackageMonitor {
        C00534() {
        }

        public void onPackageDisappeared(String packageName, int reason) {
            synchronized (LocationManagerService.this.mLock) {
                Iterator i$;
                ArrayList<Receiver> deadReceivers = null;
                for (Receiver receiver : LocationManagerService.this.mReceivers.values()) {
                    ArrayList<Receiver> deadReceivers2;
                    try {
                        if (receiver.mPackageName.equals(packageName)) {
                            if (deadReceivers == null) {
                                deadReceivers2 = new ArrayList();
                            } else {
                                deadReceivers2 = deadReceivers;
                            }
                            try {
                                deadReceivers2.add(receiver);
                            } catch (Throwable th) {
                                Throwable th2 = th;
                                throw th2;
                            }
                        }
                        deadReceivers2 = deadReceivers;
                        deadReceivers = deadReceivers2;
                    } catch (Throwable th3) {
                        th2 = th3;
                        deadReceivers2 = deadReceivers;
                    }
                }
                if (deadReceivers != null) {
                    i$ = deadReceivers.iterator();
                    while (i$.hasNext()) {
                        LocationManagerService.this.removeUpdatesLocked((Receiver) i$.next());
                    }
                }
            }
        }
    }

    private class LocationWorkerHandler extends Handler {
        public LocationWorkerHandler(Looper looper) {
            super(looper, null, true);
        }

        public void handleMessage(Message msg) {
            boolean z = true;
            switch (msg.what) {
                case LocationManagerService.RESOLUTION_LEVEL_COARSE /*1*/:
                    LocationManagerService locationManagerService = LocationManagerService.this;
                    Location location = (Location) msg.obj;
                    if (msg.arg1 != LocationManagerService.RESOLUTION_LEVEL_COARSE) {
                        z = LocationManagerService.f0D;
                    }
                    locationManagerService.handleLocationChanged(location, z);
                default:
            }
        }
    }

    private final class Receiver implements DeathRecipient, OnFinished {
        final int mAllowedResolutionLevel;
        final boolean mHideFromAppOps;
        final Object mKey;
        final ILocationListener mListener;
        boolean mOpHighPowerMonitoring;
        boolean mOpMonitoring;
        final String mPackageName;
        int mPendingBroadcasts;
        final PendingIntent mPendingIntent;
        final int mPid;
        final int mUid;
        final HashMap<String, UpdateRecord> mUpdateRecords;
        WakeLock mWakeLock;
        final WorkSource mWorkSource;

        Receiver(ILocationListener listener, PendingIntent intent, int pid, int uid, String packageName, WorkSource workSource, boolean hideFromAppOps) {
            this.mUpdateRecords = new HashMap();
            this.mListener = listener;
            this.mPendingIntent = intent;
            if (listener != null) {
                this.mKey = listener.asBinder();
            } else {
                this.mKey = intent;
            }
            this.mAllowedResolutionLevel = LocationManagerService.this.getAllowedResolutionLevel(pid, uid);
            this.mUid = uid;
            this.mPid = pid;
            this.mPackageName = packageName;
            if (workSource != null && workSource.size() <= 0) {
                workSource = null;
            }
            this.mWorkSource = workSource;
            this.mHideFromAppOps = hideFromAppOps;
            updateMonitoring(true);
            this.mWakeLock = LocationManagerService.this.mPowerManager.newWakeLock(LocationManagerService.RESOLUTION_LEVEL_COARSE, LocationManagerService.WAKELOCK_KEY);
            if (workSource == null) {
                workSource = new WorkSource(this.mUid, this.mPackageName);
            }
            this.mWakeLock.setWorkSource(workSource);
        }

        public boolean equals(Object otherObj) {
            if (otherObj instanceof Receiver) {
                return this.mKey.equals(((Receiver) otherObj).mKey);
            }
            return LocationManagerService.f0D;
        }

        public int hashCode() {
            return this.mKey.hashCode();
        }

        public String toString() {
            StringBuilder s = new StringBuilder();
            s.append("Reciever[");
            s.append(Integer.toHexString(System.identityHashCode(this)));
            if (this.mListener != null) {
                s.append(" listener");
            } else {
                s.append(" intent");
            }
            for (String p : this.mUpdateRecords.keySet()) {
                s.append(" ").append(((UpdateRecord) this.mUpdateRecords.get(p)).toString());
            }
            s.append("]");
            return s.toString();
        }

        public void updateMonitoring(boolean allow) {
            if (!this.mHideFromAppOps) {
                boolean requestingLocation = LocationManagerService.f0D;
                boolean requestingHighPowerLocation = LocationManagerService.f0D;
                if (allow) {
                    for (UpdateRecord updateRecord : this.mUpdateRecords.values()) {
                        if (LocationManagerService.this.isAllowedByCurrentUserSettingsLocked(updateRecord.mProvider)) {
                            requestingLocation = true;
                            LocationProviderInterface locationProvider = (LocationProviderInterface) LocationManagerService.this.mProvidersByName.get(updateRecord.mProvider);
                            ProviderProperties properties = locationProvider != null ? locationProvider.getProperties() : null;
                            if (properties != null && properties.mPowerRequirement == 3 && updateRecord.mRequest.getInterval() < LocationManagerService.HIGH_POWER_INTERVAL_MS) {
                                requestingHighPowerLocation = true;
                                break;
                            }
                        }
                    }
                }
                this.mOpMonitoring = updateMonitoring(requestingLocation, this.mOpMonitoring, 41);
                boolean wasHighPowerMonitoring = this.mOpHighPowerMonitoring;
                this.mOpHighPowerMonitoring = updateMonitoring(requestingHighPowerLocation, this.mOpHighPowerMonitoring, 42);
                if (this.mOpHighPowerMonitoring != wasHighPowerMonitoring) {
                    LocationManagerService.this.mContext.sendBroadcastAsUser(new Intent("android.location.HIGH_POWER_REQUEST_CHANGE"), UserHandle.ALL);
                }
            }
        }

        private boolean updateMonitoring(boolean allowMonitoring, boolean currentlyMonitoring, int op) {
            if (currentlyMonitoring) {
                int mode = LocationManagerService.this.mAppOps.checkOpNoThrow(op, this.mUid, this.mPackageName);
                if (allowMonitoring && mode == 4) {
                    return true;
                }
                if (!(allowMonitoring && mode == 0)) {
                    LocationManagerService.this.mAppOps.finishOp(op, this.mUid, this.mPackageName);
                    return LocationManagerService.f0D;
                }
            } else if (allowMonitoring) {
                if (LocationManagerService.this.mAppOps.startOpNoThrow(op, this.mUid, this.mPackageName) == 0) {
                    return true;
                }
                return LocationManagerService.f0D;
            }
            return currentlyMonitoring;
        }

        public boolean isListener() {
            return this.mListener != null ? true : LocationManagerService.f0D;
        }

        public boolean isPendingIntent() {
            return this.mPendingIntent != null ? true : LocationManagerService.f0D;
        }

        public ILocationListener getListener() {
            if (this.mListener != null) {
                return this.mListener;
            }
            throw new IllegalStateException("Request for non-existent listener");
        }

        public boolean callStatusChangedLocked(String provider, int status, Bundle extras) {
            if (this.mListener != null) {
                try {
                    synchronized (this) {
                        this.mListener.onStatusChanged(provider, status, extras);
                        incrementPendingBroadcastsLocked();
                    }
                } catch (RemoteException e) {
                    return LocationManagerService.f0D;
                }
            }
            Intent statusChanged = new Intent();
            statusChanged.putExtras(new Bundle(extras));
            statusChanged.putExtra("status", status);
            try {
                synchronized (this) {
                    this.mPendingIntent.send(LocationManagerService.this.mContext, LocationManagerService.RESOLUTION_LEVEL_NONE, statusChanged, this, LocationManagerService.this.mLocationHandler, LocationManagerService.this.getResolutionPermission(this.mAllowedResolutionLevel));
                    incrementPendingBroadcastsLocked();
                }
            } catch (CanceledException e2) {
                return LocationManagerService.f0D;
            }
            return true;
        }

        public boolean callLocationChangedLocked(Location location) {
            if (this.mListener != null) {
                try {
                    synchronized (this) {
                        this.mListener.onLocationChanged(new Location(location));
                        incrementPendingBroadcastsLocked();
                    }
                } catch (RemoteException e) {
                    return LocationManagerService.f0D;
                }
            }
            Intent locationChanged = new Intent();
            locationChanged.putExtra("location", new Location(location));
            try {
                synchronized (this) {
                    this.mPendingIntent.send(LocationManagerService.this.mContext, LocationManagerService.RESOLUTION_LEVEL_NONE, locationChanged, this, LocationManagerService.this.mLocationHandler, LocationManagerService.this.getResolutionPermission(this.mAllowedResolutionLevel));
                    incrementPendingBroadcastsLocked();
                }
            } catch (CanceledException e2) {
                return LocationManagerService.f0D;
            }
            return true;
        }

        public boolean callProviderEnabledLocked(String provider, boolean enabled) {
            updateMonitoring(true);
            if (this.mListener != null) {
                try {
                    synchronized (this) {
                        if (enabled) {
                            this.mListener.onProviderEnabled(provider);
                        } else {
                            this.mListener.onProviderDisabled(provider);
                        }
                        incrementPendingBroadcastsLocked();
                    }
                } catch (RemoteException e) {
                    return LocationManagerService.f0D;
                }
            }
            Intent providerIntent = new Intent();
            providerIntent.putExtra("providerEnabled", enabled);
            try {
                synchronized (this) {
                    this.mPendingIntent.send(LocationManagerService.this.mContext, LocationManagerService.RESOLUTION_LEVEL_NONE, providerIntent, this, LocationManagerService.this.mLocationHandler, LocationManagerService.this.getResolutionPermission(this.mAllowedResolutionLevel));
                    incrementPendingBroadcastsLocked();
                }
            } catch (CanceledException e2) {
                return LocationManagerService.f0D;
            }
            return true;
        }

        public void binderDied() {
            if (LocationManagerService.f0D) {
                Log.d(LocationManagerService.WAKELOCK_KEY, "Location listener died");
            }
            synchronized (LocationManagerService.this.mLock) {
                LocationManagerService.this.removeUpdatesLocked(this);
            }
            synchronized (this) {
                clearPendingBroadcastsLocked();
            }
        }

        public void onSendFinished(PendingIntent pendingIntent, Intent intent, int resultCode, String resultData, Bundle resultExtras) {
            synchronized (this) {
                decrementPendingBroadcastsLocked();
            }
        }

        private void incrementPendingBroadcastsLocked() {
            int i = this.mPendingBroadcasts;
            this.mPendingBroadcasts = i + LocationManagerService.RESOLUTION_LEVEL_COARSE;
            if (i == 0) {
                this.mWakeLock.acquire();
            }
        }

        private void decrementPendingBroadcastsLocked() {
            int i = this.mPendingBroadcasts - 1;
            this.mPendingBroadcasts = i;
            if (i == 0 && this.mWakeLock.isHeld()) {
                this.mWakeLock.release();
            }
        }

        public void clearPendingBroadcastsLocked() {
            if (this.mPendingBroadcasts > 0) {
                this.mPendingBroadcasts = LocationManagerService.RESOLUTION_LEVEL_NONE;
                if (this.mWakeLock.isHeld()) {
                    this.mWakeLock.release();
                }
            }
        }
    }

    private class UpdateRecord {
        Location mLastFixBroadcast;
        long mLastStatusBroadcast;
        final String mProvider;
        final Receiver mReceiver;
        final LocationRequest mRequest;

        UpdateRecord(String provider, LocationRequest request, Receiver receiver) {
            this.mProvider = provider;
            this.mRequest = request;
            this.mReceiver = receiver;
            ArrayList<UpdateRecord> records = (ArrayList) LocationManagerService.this.mRecordsByProvider.get(provider);
            if (records == null) {
                records = new ArrayList();
                LocationManagerService.this.mRecordsByProvider.put(provider, records);
            }
            if (!records.contains(this)) {
                records.add(this);
            }
            LocationManagerService.this.mRequestStatistics.startRequesting(this.mReceiver.mPackageName, provider, request.getInterval());
        }

        void disposeLocked(boolean removeReceiver) {
            LocationManagerService.this.mRequestStatistics.stopRequesting(this.mReceiver.mPackageName, this.mProvider);
            ArrayList<UpdateRecord> globalRecords = (ArrayList) LocationManagerService.this.mRecordsByProvider.get(this.mProvider);
            if (globalRecords != null) {
                globalRecords.remove(this);
            }
            if (removeReceiver) {
                HashMap<String, UpdateRecord> receiverRecords = this.mReceiver.mUpdateRecords;
                if (receiverRecords != null) {
                    receiverRecords.remove(this.mProvider);
                    if (removeReceiver && receiverRecords.size() == 0) {
                        LocationManagerService.this.removeUpdatesLocked(this.mReceiver);
                    }
                }
            }
        }

        public String toString() {
            StringBuilder s = new StringBuilder();
            s.append("UpdateRecord[");
            s.append(this.mProvider);
            s.append(' ').append(this.mReceiver.mPackageName).append('(');
            s.append(this.mReceiver.mUid).append(')');
            s.append(' ').append(this.mRequest);
            s.append(']');
            return s.toString();
        }
    }

    static {
        f0D = Log.isLoggable(WAKELOCK_KEY, 3);
        DEFAULT_LOCATION_REQUEST = new LocationRequest();
    }

    public LocationManagerService(Context context) {
        this.mLock = new Object();
        this.mEnabledProviders = new HashSet();
        this.mDisabledProviders = new HashSet();
        this.mMockProviders = new HashMap();
        this.mReceivers = new HashMap();
        this.mProviders = new ArrayList();
        this.mRealProviders = new HashMap();
        this.mProvidersByName = new HashMap();
        this.mRecordsByProvider = new HashMap();
        this.mRequestStatistics = new LocationRequestStatistics();
        this.mLastLocation = new HashMap();
        this.mLastLocationCoarseInterval = new HashMap();
        this.mProxyProviders = new ArrayList();
        this.mCurrentUserId = RESOLUTION_LEVEL_NONE;
        int[] iArr = new int[RESOLUTION_LEVEL_COARSE];
        iArr[RESOLUTION_LEVEL_NONE] = RESOLUTION_LEVEL_NONE;
        this.mCurrentUserProfiles = iArr;
        this.mPackageMonitor = new C00534();
        this.mContext = context;
        this.mAppOps = (AppOpsManager) context.getSystemService("appops");
        this.mGeoFencerEnabled = f0D;
        if (f0D) {
            Log.d(WAKELOCK_KEY, "Constructed");
        }
    }

    public void systemRunning() {
        synchronized (this.mLock) {
            if (f0D) {
                Log.d(WAKELOCK_KEY, "systemReady()");
            }
            this.mPackageManager = this.mContext.getPackageManager();
            this.mPowerManager = (PowerManager) this.mContext.getSystemService("power");
            this.mLocationHandler = new LocationWorkerHandler(BackgroundThread.get().getLooper());
            this.mLocationFudger = new LocationFudger(this.mContext, this.mLocationHandler);
            this.mBlacklist = new LocationBlacklist(this.mContext, this.mLocationHandler);
            this.mBlacklist.init();
            this.mGeofenceManager = new GeofenceManager(this.mContext, this.mBlacklist);
            this.mAppOps.startWatchingMode(RESOLUTION_LEVEL_NONE, null, new C00501());
            this.mUserManager = (UserManager) this.mContext.getSystemService("user");
            updateUserProfiles(this.mCurrentUserId);
            loadProvidersLocked();
            updateProvidersLocked();
        }
        this.mContext.getContentResolver().registerContentObserver(Secure.getUriFor("location_providers_allowed"), true, new C00512(this.mLocationHandler), -1);
        this.mPackageMonitor.register(this.mContext, this.mLocationHandler.getLooper(), true);
        IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction("android.intent.action.USER_SWITCHED");
        intentFilter.addAction("android.intent.action.MANAGED_PROFILE_ADDED");
        intentFilter.addAction("android.intent.action.MANAGED_PROFILE_REMOVED");
        this.mContext.registerReceiverAsUser(new C00523(), UserHandle.ALL, intentFilter, null, this.mLocationHandler);
    }

    void updateUserProfiles(int currentUserId) {
        List<UserInfo> profiles = this.mUserManager.getProfiles(currentUserId);
        synchronized (this.mLock) {
            this.mCurrentUserProfiles = new int[profiles.size()];
            for (int i = RESOLUTION_LEVEL_NONE; i < this.mCurrentUserProfiles.length; i += RESOLUTION_LEVEL_COARSE) {
                this.mCurrentUserProfiles[i] = ((UserInfo) profiles.get(i)).id;
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private boolean isCurrentProfile(int r4) {
        /*
        r3 = this;
        r2 = r3.mLock;
        monitor-enter(r2);
        r0 = 0;
    L_0x0004:
        r1 = r3.mCurrentUserProfiles;	 Catch:{ all -> 0x0018 }
        r1 = r1.length;	 Catch:{ all -> 0x0018 }
        if (r0 >= r1) goto L_0x0015;
    L_0x0009:
        r1 = r3.mCurrentUserProfiles;	 Catch:{ all -> 0x0018 }
        r1 = r1[r0];	 Catch:{ all -> 0x0018 }
        if (r1 != r4) goto L_0x0012;
    L_0x000f:
        r1 = 1;
        monitor-exit(r2);	 Catch:{ all -> 0x0018 }
    L_0x0011:
        return r1;
    L_0x0012:
        r0 = r0 + 1;
        goto L_0x0004;
    L_0x0015:
        r1 = 0;
        monitor-exit(r2);	 Catch:{ all -> 0x0018 }
        goto L_0x0011;
    L_0x0018:
        r1 = move-exception;
        monitor-exit(r2);	 Catch:{ all -> 0x0018 }
        throw r1;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.LocationManagerService.isCurrentProfile(int):boolean");
    }

    private void ensureFallbackFusedProviderPresentLocked(ArrayList<String> pkgs) {
        PackageManager pm = this.mContext.getPackageManager();
        String systemPackageName = this.mContext.getPackageName();
        ArrayList<HashSet<Signature>> sigSets = ServiceWatcher.getSignatureSets(this.mContext, pkgs);
        for (ResolveInfo rInfo : pm.queryIntentServicesAsUser(new Intent(FUSED_LOCATION_SERVICE_ACTION), DumpState.DUMP_PROVIDERS, this.mCurrentUserId)) {
            String packageName = rInfo.serviceInfo.packageName;
            try {
                if (!ServiceWatcher.isSignatureMatch(pm.getPackageInfo(packageName, 64).signatures, sigSets)) {
                    Log.w(WAKELOCK_KEY, packageName + " resolves service " + FUSED_LOCATION_SERVICE_ACTION + ", but has wrong signature, ignoring");
                } else if (rInfo.serviceInfo.metaData == null) {
                    Log.w(WAKELOCK_KEY, "Found fused provider without metadata: " + packageName);
                } else if (rInfo.serviceInfo.metaData.getInt(ServiceWatcher.EXTRA_SERVICE_VERSION, -1) == 0) {
                    if ((rInfo.serviceInfo.applicationInfo.flags & RESOLUTION_LEVEL_COARSE) == 0) {
                        if (f0D) {
                            Log.d(WAKELOCK_KEY, "Fallback candidate not in /system: " + packageName);
                        }
                    } else if (pm.checkSignatures(systemPackageName, packageName) != 0) {
                        if (f0D) {
                            Log.d(WAKELOCK_KEY, "Fallback candidate not signed the same as system: " + packageName);
                        }
                    } else if (f0D) {
                        Log.d(WAKELOCK_KEY, "Found fallback provider: " + packageName);
                        return;
                    } else {
                        return;
                    }
                } else if (f0D) {
                    Log.d(WAKELOCK_KEY, "Fallback candidate not version 0: " + packageName);
                }
            } catch (NameNotFoundException e) {
                Log.e(WAKELOCK_KEY, "missing package: " + packageName);
            }
        }
        throw new IllegalStateException("Unable to find a fused location provider that is in the system partition with version 0 and signed with the platform certificate. Such a package is needed to provide a default fused location provider in the event that no other fused location provider has been installed or is currently available. For example, coreOnly boot mode when decrypting the data partition. The fallback must also be marked coreApp=\"true\" in the manifest");
    }

    private void loadProvidersLocked() {
        FlpHardwareProvider flpHardwareProvider;
        PassiveProvider passiveProvider = new PassiveProvider(this);
        addProviderLocked(passiveProvider);
        this.mEnabledProviders.add(passiveProvider.getName());
        this.mPassiveProvider = passiveProvider;
        GpsLocationProvider gpsLocationProvider = new GpsLocationProvider(this.mContext, this, this.mLocationHandler.getLooper());
        if (GpsLocationProvider.isSupported()) {
            this.mGpsStatusProvider = gpsLocationProvider.getGpsStatusProvider();
            this.mNetInitiatedListener = gpsLocationProvider.getNetInitiatedListener();
            addProviderLocked(gpsLocationProvider);
            this.mRealProviders.put("gps", gpsLocationProvider);
        }
        this.mGpsMeasurementsProvider = gpsLocationProvider.getGpsMeasurementsProvider();
        this.mGpsNavigationMessageProvider = gpsLocationProvider.getGpsNavigationMessageProvider();
        Resources resources = this.mContext.getResources();
        ArrayList<String> providerPackageNames = new ArrayList();
        String[] pkgs = resources.getStringArray(17236008);
        if (f0D) {
            Log.d(WAKELOCK_KEY, "certificates for location providers pulled from: " + Arrays.toString(pkgs));
        }
        if (pkgs != null) {
            providerPackageNames.addAll(Arrays.asList(pkgs));
        }
        ensureFallbackFusedProviderPresentLocked(providerPackageNames);
        LocationProviderProxy networkProvider = LocationProviderProxy.createAndBind(this.mContext, "network", NETWORK_LOCATION_SERVICE_ACTION, 17956936, 17039394, 17236008, this.mLocationHandler);
        if (networkProvider != null) {
            this.mRealProviders.put("network", networkProvider);
            this.mProxyProviders.add(networkProvider);
            addProviderLocked(networkProvider);
        } else {
            Slog.w(WAKELOCK_KEY, "no network location provider found");
        }
        LocationProviderProxy fusedLocationProvider = LocationProviderProxy.createAndBind(this.mContext, "fused", FUSED_LOCATION_SERVICE_ACTION, 17956937, 17039395, 17236008, this.mLocationHandler);
        if (fusedLocationProvider != null) {
            addProviderLocked(fusedLocationProvider);
            this.mProxyProviders.add(fusedLocationProvider);
            this.mEnabledProviders.add(fusedLocationProvider.getName());
            this.mRealProviders.put("fused", fusedLocationProvider);
        } else {
            Slog.e(WAKELOCK_KEY, "no fused location provider found", new IllegalStateException("Location service needs a fused location provider"));
        }
        this.mGeocodeProvider = GeocoderProxy.createAndBind(this.mContext, 17956939, 17039397, 17236008, this.mLocationHandler);
        if (this.mGeocodeProvider == null) {
            Slog.e(WAKELOCK_KEY, "no geocoder provider found");
        }
        this.mGeoFencerPackageName = resources.getString(17039400);
        if (this.mGeoFencerPackageName == null || this.mPackageManager.resolveService(new Intent(this.mGeoFencerPackageName), RESOLUTION_LEVEL_NONE) == null) {
            this.mGeoFencer = null;
            this.mGeoFencerEnabled = f0D;
        } else {
            this.mGeoFencer = GeoFencerProxy.getGeoFencerProxy(this.mContext, this.mGeoFencerPackageName);
            this.mGeoFencerEnabled = true;
        }
        this.mComboNlpPackageName = resources.getString(17039401);
        if (this.mComboNlpPackageName != null) {
            this.mComboNlpReadyMarker = this.mComboNlpPackageName + ".nlp:ready";
            this.mComboNlpScreenMarker = this.mComboNlpPackageName + ".nlp:screen";
        }
        if (FlpHardwareProvider.isSupported()) {
            flpHardwareProvider = FlpHardwareProvider.getInstance(this.mContext);
            if (FusedProxy.createAndBind(this.mContext, this.mLocationHandler, flpHardwareProvider.getLocationHardware(), 17956938, 17039396, 17236008) == null) {
                Slog.e(WAKELOCK_KEY, "Unable to bind FusedProxy.");
            }
        } else {
            flpHardwareProvider = null;
            Slog.e(WAKELOCK_KEY, "FLP HAL not supported");
        }
        if (GeofenceProxy.createAndBind(this.mContext, 17956940, 17039398, 17236008, this.mLocationHandler, gpsLocationProvider.getGpsGeofenceProxy(), flpHardwareProvider != null ? flpHardwareProvider.getGeofenceHardware() : null) == null) {
            Slog.e(WAKELOCK_KEY, "Unable to bind FLP Geofence proxy.");
        }
        if (!ActivityRecognitionHardware.isSupported()) {
            Slog.e(WAKELOCK_KEY, "Hardware Activity-Recognition not supported.");
        } else if (ActivityRecognitionProxy.createAndBind(this.mContext, this.mLocationHandler, ActivityRecognitionHardware.getInstance(this.mContext), 17956941, 17039399, 17236008) == null) {
            Slog.e(WAKELOCK_KEY, "Unable to bind ActivityRecognitionProxy.");
        }
        String[] arr$ = resources.getStringArray(17236009);
        int len$ = arr$.length;
        for (int i$ = RESOLUTION_LEVEL_NONE; i$ < len$; i$ += RESOLUTION_LEVEL_COARSE) {
            String[] fragments = arr$[i$].split(",");
            String name = fragments[RESOLUTION_LEVEL_NONE].trim();
            if (this.mProvidersByName.get(name) != null) {
                throw new IllegalArgumentException("Provider \"" + name + "\" already exists");
            }
            addTestProviderLocked(name, new ProviderProperties(Boolean.parseBoolean(fragments[RESOLUTION_LEVEL_COARSE]), Boolean.parseBoolean(fragments[RESOLUTION_LEVEL_FINE]), Boolean.parseBoolean(fragments[3]), Boolean.parseBoolean(fragments[4]), Boolean.parseBoolean(fragments[5]), Boolean.parseBoolean(fragments[6]), Boolean.parseBoolean(fragments[7]), Integer.parseInt(fragments[8]), Integer.parseInt(fragments[9])));
        }
    }

    private void switchUser(int userId) {
        if (this.mCurrentUserId != userId) {
            this.mBlacklist.switchUser(userId);
            this.mLocationHandler.removeMessages(RESOLUTION_LEVEL_COARSE);
            synchronized (this.mLock) {
                this.mLastLocation.clear();
                this.mLastLocationCoarseInterval.clear();
                Iterator i$ = this.mProviders.iterator();
                while (i$.hasNext()) {
                    updateProviderListenersLocked(((LocationProviderInterface) i$.next()).getName(), f0D);
                }
                this.mCurrentUserId = userId;
                updateUserProfiles(userId);
                updateProvidersLocked();
            }
        }
    }

    public void locationCallbackFinished(ILocationListener listener) {
        synchronized (this.mLock) {
            Receiver receiver = (Receiver) this.mReceivers.get(listener.asBinder());
            if (receiver != null) {
                synchronized (receiver) {
                    long identity = Binder.clearCallingIdentity();
                    receiver.decrementPendingBroadcastsLocked();
                    Binder.restoreCallingIdentity(identity);
                }
            }
        }
    }

    private void addProviderLocked(LocationProviderInterface provider) {
        this.mProviders.add(provider);
        this.mProvidersByName.put(provider.getName(), provider);
    }

    private void removeProviderLocked(LocationProviderInterface provider) {
        provider.disable();
        this.mProviders.remove(provider);
        this.mProvidersByName.remove(provider.getName());
    }

    private boolean isAllowedByCurrentUserSettingsLocked(String provider) {
        if (this.mEnabledProviders.contains(provider)) {
            return true;
        }
        if (this.mDisabledProviders.contains(provider)) {
            return f0D;
        }
        return Secure.isLocationProviderEnabledForUser(this.mContext.getContentResolver(), provider, this.mCurrentUserId);
    }

    private boolean isAllowedByUserSettingsLocked(String provider, int uid) {
        if (isCurrentProfile(UserHandle.getUserId(uid)) || isUidALocationProvider(uid)) {
            return isAllowedByCurrentUserSettingsLocked(provider);
        }
        return f0D;
    }

    private String getResolutionPermission(int resolutionLevel) {
        switch (resolutionLevel) {
            case RESOLUTION_LEVEL_COARSE /*1*/:
                return "android.permission.ACCESS_COARSE_LOCATION";
            case RESOLUTION_LEVEL_FINE /*2*/:
                return "android.permission.ACCESS_FINE_LOCATION";
            default:
                return null;
        }
    }

    private int getAllowedResolutionLevel(int pid, int uid) {
        if (this.mContext.checkPermission("android.permission.ACCESS_FINE_LOCATION", pid, uid) == 0) {
            return RESOLUTION_LEVEL_FINE;
        }
        if (this.mContext.checkPermission("android.permission.ACCESS_COARSE_LOCATION", pid, uid) == 0) {
            return RESOLUTION_LEVEL_COARSE;
        }
        return RESOLUTION_LEVEL_NONE;
    }

    private int getCallerAllowedResolutionLevel() {
        return getAllowedResolutionLevel(Binder.getCallingPid(), Binder.getCallingUid());
    }

    private void checkResolutionLevelIsSufficientForGeofenceUse(int allowedResolutionLevel) {
        if (allowedResolutionLevel < RESOLUTION_LEVEL_FINE) {
            throw new SecurityException("Geofence usage requires ACCESS_FINE_LOCATION permission");
        }
    }

    private int getMinimumResolutionLevelForProviderUse(String provider) {
        if ("gps".equals(provider) || "passive".equals(provider)) {
            return RESOLUTION_LEVEL_FINE;
        }
        if ("network".equals(provider) || "fused".equals(provider)) {
            return RESOLUTION_LEVEL_COARSE;
        }
        LocationProviderInterface lp = (LocationProviderInterface) this.mMockProviders.get(provider);
        if (lp == null) {
            return RESOLUTION_LEVEL_FINE;
        }
        ProviderProperties properties = lp.getProperties();
        if (properties == null || properties.mRequiresSatellite) {
            return RESOLUTION_LEVEL_FINE;
        }
        if (properties.mRequiresNetwork || properties.mRequiresCell) {
            return RESOLUTION_LEVEL_COARSE;
        }
        return RESOLUTION_LEVEL_FINE;
    }

    private void checkResolutionLevelIsSufficientForProviderUse(int allowedResolutionLevel, String providerName) {
        int requiredResolutionLevel = getMinimumResolutionLevelForProviderUse(providerName);
        if (allowedResolutionLevel < requiredResolutionLevel) {
            switch (requiredResolutionLevel) {
                case RESOLUTION_LEVEL_COARSE /*1*/:
                    throw new SecurityException("\"" + providerName + "\" location provider " + "requires ACCESS_COARSE_LOCATION or ACCESS_FINE_LOCATION permission.");
                case RESOLUTION_LEVEL_FINE /*2*/:
                    throw new SecurityException("\"" + providerName + "\" location provider " + "requires ACCESS_FINE_LOCATION permission.");
                default:
                    throw new SecurityException("Insufficient permission for \"" + providerName + "\" location provider.");
            }
        }
    }

    private void checkDeviceStatsAllowed() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.UPDATE_DEVICE_STATS", null);
    }

    private void checkUpdateAppOpsAllowed() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.UPDATE_APP_OPS_STATS", null);
    }

    public static int resolutionLevelToOp(int allowedResolutionLevel) {
        if (allowedResolutionLevel == 0) {
            return -1;
        }
        if (allowedResolutionLevel == RESOLUTION_LEVEL_COARSE) {
            return RESOLUTION_LEVEL_NONE;
        }
        return RESOLUTION_LEVEL_COARSE;
    }

    boolean reportLocationAccessNoThrow(int uid, String packageName, int allowedResolutionLevel) {
        int op = resolutionLevelToOp(allowedResolutionLevel);
        if (op < 0 || this.mAppOps.noteOpNoThrow(op, uid, packageName) == 0) {
            return true;
        }
        return f0D;
    }

    boolean checkLocationAccess(int uid, String packageName, int allowedResolutionLevel) {
        int op = resolutionLevelToOp(allowedResolutionLevel);
        if (op >= 0) {
            int mode = this.mAppOps.checkOp(op, uid, packageName);
            if (!(mode == 0 || mode == 4)) {
                return f0D;
            }
        }
        return true;
    }

    public List<String> getAllProviders() {
        ArrayList<String> out;
        synchronized (this.mLock) {
            out = new ArrayList(this.mProviders.size());
            Iterator i$ = this.mProviders.iterator();
            while (i$.hasNext()) {
                String name = ((LocationProviderInterface) i$.next()).getName();
                if (!"fused".equals(name)) {
                    out.add(name);
                }
            }
        }
        if (f0D) {
            Log.d(WAKELOCK_KEY, "getAllProviders()=" + out);
        }
        return out;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public java.util.List<java.lang.String> getProviders(android.location.Criteria r12, boolean r13) {
        /*
        r11 = this;
        r0 = r11.getCallerAllowedResolutionLevel();
        r7 = android.os.Binder.getCallingUid();
        r2 = android.os.Binder.clearCallingIdentity();
        r9 = r11.mLock;	 Catch:{ all -> 0x0059 }
        monitor-enter(r9);	 Catch:{ all -> 0x0059 }
        r5 = new java.util.ArrayList;	 Catch:{ all -> 0x0056 }
        r8 = r11.mProviders;	 Catch:{ all -> 0x0056 }
        r8 = r8.size();	 Catch:{ all -> 0x0056 }
        r5.<init>(r8);	 Catch:{ all -> 0x0056 }
        r8 = r11.mProviders;	 Catch:{ all -> 0x0056 }
        r1 = r8.iterator();	 Catch:{ all -> 0x0056 }
    L_0x0020:
        r8 = r1.hasNext();	 Catch:{ all -> 0x0056 }
        if (r8 == 0) goto L_0x005e;
    L_0x0026:
        r6 = r1.next();	 Catch:{ all -> 0x0056 }
        r6 = (com.android.server.location.LocationProviderInterface) r6;	 Catch:{ all -> 0x0056 }
        r4 = r6.getName();	 Catch:{ all -> 0x0056 }
        r8 = "fused";
        r8 = r8.equals(r4);	 Catch:{ all -> 0x0056 }
        if (r8 != 0) goto L_0x0020;
    L_0x0038:
        r8 = r11.getMinimumResolutionLevelForProviderUse(r4);	 Catch:{ all -> 0x0056 }
        if (r0 < r8) goto L_0x0020;
    L_0x003e:
        if (r13 == 0) goto L_0x0046;
    L_0x0040:
        r8 = r11.isAllowedByUserSettingsLocked(r4, r7);	 Catch:{ all -> 0x0056 }
        if (r8 == 0) goto L_0x0020;
    L_0x0046:
        if (r12 == 0) goto L_0x0052;
    L_0x0048:
        r8 = r6.getProperties();	 Catch:{ all -> 0x0056 }
        r8 = android.location.LocationProvider.propertiesMeetCriteria(r4, r8, r12);	 Catch:{ all -> 0x0056 }
        if (r8 == 0) goto L_0x0020;
    L_0x0052:
        r5.add(r4);	 Catch:{ all -> 0x0056 }
        goto L_0x0020;
    L_0x0056:
        r8 = move-exception;
        monitor-exit(r9);	 Catch:{ all -> 0x0056 }
        throw r8;	 Catch:{ all -> 0x0059 }
    L_0x0059:
        r8 = move-exception;
        android.os.Binder.restoreCallingIdentity(r2);
        throw r8;
    L_0x005e:
        monitor-exit(r9);	 Catch:{ all -> 0x0056 }
        android.os.Binder.restoreCallingIdentity(r2);
        r8 = f0D;
        if (r8 == 0) goto L_0x007e;
    L_0x0066:
        r8 = "LocationManagerService";
        r9 = new java.lang.StringBuilder;
        r9.<init>();
        r10 = "getProviders()=";
        r9 = r9.append(r10);
        r9 = r9.append(r5);
        r9 = r9.toString();
        android.util.Log.d(r8, r9);
    L_0x007e:
        return r5;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.LocationManagerService.getProviders(android.location.Criteria, boolean):java.util.List<java.lang.String>");
    }

    public String getBestProvider(Criteria criteria, boolean enabledOnly) {
        List<String> providers = getProviders(criteria, enabledOnly);
        String result;
        if (providers.isEmpty()) {
            providers = getProviders(null, enabledOnly);
            if (!providers.isEmpty()) {
                result = pickBest(providers);
                if (f0D) {
                    Log.d(WAKELOCK_KEY, "getBestProvider(" + criteria + ", " + enabledOnly + ")=" + result);
                }
                return result;
            } else if (!f0D) {
                return null;
            } else {
                Log.d(WAKELOCK_KEY, "getBestProvider(" + criteria + ", " + enabledOnly + ")=" + null);
                return null;
            }
        }
        result = pickBest(providers);
        if (f0D) {
            Log.d(WAKELOCK_KEY, "getBestProvider(" + criteria + ", " + enabledOnly + ")=" + result);
        }
        return result;
    }

    private String pickBest(List<String> providers) {
        if (providers.contains("gps")) {
            return "gps";
        }
        if (providers.contains("network")) {
            return "network";
        }
        return (String) providers.get(RESOLUTION_LEVEL_NONE);
    }

    public boolean providerMeetsCriteria(String provider, Criteria criteria) {
        LocationProviderInterface p = (LocationProviderInterface) this.mProvidersByName.get(provider);
        if (p == null) {
            throw new IllegalArgumentException("provider=" + provider);
        }
        boolean result = LocationProvider.propertiesMeetCriteria(p.getName(), p.getProperties(), criteria);
        if (f0D) {
            Log.d(WAKELOCK_KEY, "providerMeetsCriteria(" + provider + ", " + criteria + ")=" + result);
        }
        return result;
    }

    private void updateProvidersLocked() {
        boolean changesMade = f0D;
        for (int i = this.mProviders.size() - 1; i >= 0; i--) {
            LocationProviderInterface p = (LocationProviderInterface) this.mProviders.get(i);
            boolean isEnabled = p.isEnabled();
            String name = p.getName();
            boolean shouldBeEnabled = isAllowedByCurrentUserSettingsLocked(name);
            if (isEnabled && !shouldBeEnabled) {
                updateProviderListenersLocked(name, f0D);
                this.mLastLocation.clear();
                this.mLastLocationCoarseInterval.clear();
                changesMade = true;
            } else if (!isEnabled && shouldBeEnabled) {
                updateProviderListenersLocked(name, true);
                changesMade = true;
            }
        }
        if (changesMade) {
            this.mContext.sendBroadcastAsUser(new Intent("android.location.PROVIDERS_CHANGED"), UserHandle.ALL);
            this.mContext.sendBroadcastAsUser(new Intent("android.location.MODE_CHANGED"), UserHandle.ALL);
        }
    }

    private void updateProviderListenersLocked(String provider, boolean enabled) {
        int listeners = RESOLUTION_LEVEL_NONE;
        LocationProviderInterface p = (LocationProviderInterface) this.mProvidersByName.get(provider);
        if (p != null) {
            int i;
            ArrayList<Receiver> deadReceivers = null;
            ArrayList<UpdateRecord> records = (ArrayList) this.mRecordsByProvider.get(provider);
            if (records != null) {
                int N = records.size();
                for (i = RESOLUTION_LEVEL_NONE; i < N; i += RESOLUTION_LEVEL_COARSE) {
                    UpdateRecord record = (UpdateRecord) records.get(i);
                    if (isCurrentProfile(UserHandle.getUserId(record.mReceiver.mUid))) {
                        if (!record.mReceiver.callProviderEnabledLocked(provider, enabled)) {
                            if (deadReceivers == null) {
                                deadReceivers = new ArrayList();
                            }
                            deadReceivers.add(record.mReceiver);
                        }
                        listeners += RESOLUTION_LEVEL_COARSE;
                    }
                }
            }
            if (deadReceivers != null) {
                for (i = deadReceivers.size() - 1; i >= 0; i--) {
                    removeUpdatesLocked((Receiver) deadReceivers.get(i));
                }
            }
            if (enabled) {
                p.enable();
                if (listeners > 0) {
                    applyRequirementsLocked(provider);
                    return;
                }
                return;
            }
            p.disable();
        }
    }

    private void applyRequirementsLocked(String provider) {
        LocationProviderInterface p = (LocationProviderInterface) this.mProvidersByName.get(provider);
        if (p != null) {
            ArrayList<UpdateRecord> records = (ArrayList) this.mRecordsByProvider.get(provider);
            WorkSource worksource = new WorkSource();
            ProviderRequest providerRequest = new ProviderRequest();
            if (records != null) {
                UpdateRecord record;
                Iterator i$ = records.iterator();
                while (i$.hasNext()) {
                    record = (UpdateRecord) i$.next();
                    if (isCurrentProfile(UserHandle.getUserId(record.mReceiver.mUid)) && checkLocationAccess(record.mReceiver.mUid, record.mReceiver.mPackageName, record.mReceiver.mAllowedResolutionLevel)) {
                        LocationRequest locationRequest = record.mRequest;
                        providerRequest.locationRequests.add(locationRequest);
                        if (locationRequest.getInterval() < providerRequest.interval) {
                            providerRequest.reportLocation = true;
                            providerRequest.interval = locationRequest.getInterval();
                        }
                    }
                }
                if (providerRequest.reportLocation) {
                    long thresholdInterval = ((providerRequest.interval + 1000) * 3) / 2;
                    i$ = records.iterator();
                    while (i$.hasNext()) {
                        record = (UpdateRecord) i$.next();
                        if (isCurrentProfile(UserHandle.getUserId(record.mReceiver.mUid)) && record.mRequest.getInterval() <= thresholdInterval) {
                            if (record.mReceiver.mWorkSource == null || record.mReceiver.mWorkSource.size() <= 0 || record.mReceiver.mWorkSource.getName(RESOLUTION_LEVEL_NONE) == null) {
                                worksource.add(record.mReceiver.mUid, record.mReceiver.mPackageName);
                            } else {
                                worksource.add(record.mReceiver.mWorkSource);
                            }
                        }
                    }
                }
            }
            if (f0D) {
                Log.d(WAKELOCK_KEY, "provider request: " + provider + " " + providerRequest);
            }
            p.setRequest(providerRequest, worksource);
        }
    }

    private Receiver getReceiverLocked(ILocationListener listener, int pid, int uid, String packageName, WorkSource workSource, boolean hideFromAppOps) {
        IBinder binder = listener.asBinder();
        Receiver receiver = (Receiver) this.mReceivers.get(binder);
        if (receiver == null) {
            receiver = new Receiver(listener, null, pid, uid, packageName, workSource, hideFromAppOps);
            this.mReceivers.put(binder, receiver);
            try {
                receiver.getListener().asBinder().linkToDeath(receiver, RESOLUTION_LEVEL_NONE);
            } catch (RemoteException e) {
                Slog.e(WAKELOCK_KEY, "linkToDeath failed:", e);
                return null;
            }
        }
        return receiver;
    }

    private Receiver getReceiverLocked(PendingIntent intent, int pid, int uid, String packageName, WorkSource workSource, boolean hideFromAppOps) {
        Receiver receiver = (Receiver) this.mReceivers.get(intent);
        if (receiver != null) {
            return receiver;
        }
        receiver = new Receiver(null, intent, pid, uid, packageName, workSource, hideFromAppOps);
        this.mReceivers.put(intent, receiver);
        return receiver;
    }

    private LocationRequest createSanitizedRequest(LocationRequest request, int resolutionLevel) {
        LocationRequest sanitizedRequest = new LocationRequest(request);
        if (resolutionLevel < RESOLUTION_LEVEL_FINE) {
            switch (sanitizedRequest.getQuality()) {
                case MAX_PROVIDER_SCHEDULING_JITTER_MS /*100*/:
                    sanitizedRequest.setQuality(HdmiCecKeycode.CEC_KEYCODE_RESTORE_VOLUME_FUNCTION);
                    break;
                case 203:
                    sanitizedRequest.setQuality(201);
                    break;
            }
            if (sanitizedRequest.getInterval() < LocationFudger.FASTEST_INTERVAL_MS) {
                sanitizedRequest.setInterval(LocationFudger.FASTEST_INTERVAL_MS);
            }
            if (sanitizedRequest.getFastestInterval() < LocationFudger.FASTEST_INTERVAL_MS) {
                sanitizedRequest.setFastestInterval(LocationFudger.FASTEST_INTERVAL_MS);
            }
        }
        if (sanitizedRequest.getFastestInterval() > sanitizedRequest.getInterval()) {
            request.setFastestInterval(request.getInterval());
        }
        return sanitizedRequest;
    }

    private void checkPackageName(String packageName) {
        if (packageName == null) {
            throw new SecurityException("invalid package name: " + packageName);
        }
        int uid = Binder.getCallingUid();
        String[] packages = this.mPackageManager.getPackagesForUid(uid);
        if (packages == null) {
            throw new SecurityException("invalid UID " + uid);
        }
        String[] arr$ = packages;
        int len$ = arr$.length;
        int i$ = RESOLUTION_LEVEL_NONE;
        while (i$ < len$) {
            if (!packageName.equals(arr$[i$])) {
                i$ += RESOLUTION_LEVEL_COARSE;
            } else {
                return;
            }
        }
        throw new SecurityException("invalid package name: " + packageName);
    }

    private void checkPendingIntent(PendingIntent intent) {
        if (intent == null) {
            throw new IllegalArgumentException("invalid pending intent: " + intent);
        }
    }

    private Receiver checkListenerOrIntentLocked(ILocationListener listener, PendingIntent intent, int pid, int uid, String packageName, WorkSource workSource, boolean hideFromAppOps) {
        if (intent == null && listener == null) {
            throw new IllegalArgumentException("need either listener or intent");
        } else if (intent != null && listener != null) {
            throw new IllegalArgumentException("cannot register both listener and intent");
        } else if (intent == null) {
            return getReceiverLocked(listener, pid, uid, packageName, workSource, hideFromAppOps);
        } else {
            checkPendingIntent(intent);
            return getReceiverLocked(intent, pid, uid, packageName, workSource, hideFromAppOps);
        }
    }

    public void requestLocationUpdates(LocationRequest request, ILocationListener listener, PendingIntent intent, String packageName) {
        if (request == null) {
            request = DEFAULT_LOCATION_REQUEST;
        }
        checkPackageName(packageName);
        int allowedResolutionLevel = getCallerAllowedResolutionLevel();
        checkResolutionLevelIsSufficientForProviderUse(allowedResolutionLevel, request.getProvider());
        WorkSource workSource = request.getWorkSource();
        if (workSource != null && workSource.size() > 0) {
            checkDeviceStatsAllowed();
        }
        boolean hideFromAppOps = request.getHideFromAppOps();
        if (hideFromAppOps) {
            checkUpdateAppOpsAllowed();
        }
        LocationRequest sanitizedRequest = createSanitizedRequest(request, allowedResolutionLevel);
        int pid = Binder.getCallingPid();
        int uid = Binder.getCallingUid();
        long identity = Binder.clearCallingIdentity();
        try {
            checkLocationAccess(uid, packageName, allowedResolutionLevel);
            synchronized (this.mLock) {
                Receiver receiver = checkListenerOrIntentLocked(listener, intent, pid, uid, packageName, workSource, hideFromAppOps);
                if (receiver != null) {
                    requestLocationUpdatesLocked(sanitizedRequest, receiver, pid, uid, packageName);
                }
            }
        } finally {
            Binder.restoreCallingIdentity(identity);
        }
    }

    private void requestLocationUpdatesLocked(LocationRequest request, Receiver receiver, int pid, int uid, String packageName) {
        if (request == null) {
            request = DEFAULT_LOCATION_REQUEST;
        }
        String name = request.getProvider();
        if (name == null) {
            throw new IllegalArgumentException("provider name must not be null");
        }
        if (f0D) {
            Log.d(WAKELOCK_KEY, "request " + Integer.toHexString(System.identityHashCode(receiver)) + " " + name + " " + request + " from " + packageName + "(" + uid + ")");
        }
        if (((LocationProviderInterface) this.mProvidersByName.get(name)) == null) {
            throw new IllegalArgumentException("provider doesn't exist: " + name);
        }
        UpdateRecord oldRecord = (UpdateRecord) receiver.mUpdateRecords.put(name, new UpdateRecord(name, request, receiver));
        if (oldRecord != null) {
            oldRecord.disposeLocked(f0D);
        }
        if (isAllowedByUserSettingsLocked(name, uid)) {
            applyRequirementsLocked(name);
        } else {
            receiver.callProviderEnabledLocked(name, f0D);
        }
        receiver.updateMonitoring(true);
    }

    public void removeUpdates(ILocationListener listener, PendingIntent intent, String packageName) {
        checkPackageName(packageName);
        int pid = Binder.getCallingPid();
        int uid = Binder.getCallingUid();
        synchronized (this.mLock) {
            Receiver receiver = checkListenerOrIntentLocked(listener, intent, pid, uid, packageName, null, f0D);
            long identity = Binder.clearCallingIdentity();
            if (receiver != null) {
                try {
                    removeUpdatesLocked(receiver);
                } catch (Throwable th) {
                    Binder.restoreCallingIdentity(identity);
                }
            }
            Binder.restoreCallingIdentity(identity);
        }
    }

    private void removeUpdatesLocked(Receiver receiver) {
        if (f0D) {
            Log.i(WAKELOCK_KEY, "remove " + Integer.toHexString(System.identityHashCode(receiver)));
        }
        if (this.mReceivers.remove(receiver.mKey) != null && receiver.isListener()) {
            receiver.getListener().asBinder().unlinkToDeath(receiver, RESOLUTION_LEVEL_NONE);
            synchronized (receiver) {
                receiver.clearPendingBroadcastsLocked();
            }
        }
        receiver.updateMonitoring(f0D);
        HashSet<String> providers = new HashSet();
        HashMap<String, UpdateRecord> oldRecords = receiver.mUpdateRecords;
        if (oldRecords != null) {
            for (UpdateRecord record : oldRecords.values()) {
                record.disposeLocked(f0D);
            }
            providers.addAll(oldRecords.keySet());
        }
        Iterator i$ = providers.iterator();
        while (i$.hasNext()) {
            String provider = (String) i$.next();
            if (isAllowedByCurrentUserSettingsLocked(provider)) {
                applyRequirementsLocked(provider);
            }
        }
    }

    private void applyAllProviderRequirementsLocked() {
        Iterator i$ = this.mProviders.iterator();
        while (i$.hasNext()) {
            LocationProviderInterface p = (LocationProviderInterface) i$.next();
            if (isAllowedByCurrentUserSettingsLocked(p.getName())) {
                applyRequirementsLocked(p.getName());
            }
        }
    }

    public Location getLastLocation(LocationRequest request, String packageName) {
        Location location = null;
        if (f0D) {
            Log.d(WAKELOCK_KEY, "getLastLocation: " + request);
        }
        if (request == null) {
            request = DEFAULT_LOCATION_REQUEST;
        }
        int allowedResolutionLevel = getCallerAllowedResolutionLevel();
        checkPackageName(packageName);
        checkResolutionLevelIsSufficientForProviderUse(allowedResolutionLevel, request.getProvider());
        int uid = Binder.getCallingUid();
        long identity = Binder.clearCallingIdentity();
        try {
            if (this.mBlacklist.isBlacklisted(packageName)) {
                if (f0D) {
                    Log.d(WAKELOCK_KEY, "not returning last loc for blacklisted app: " + packageName);
                }
                Binder.restoreCallingIdentity(identity);
            } else if (reportLocationAccessNoThrow(uid, packageName, allowedResolutionLevel)) {
                synchronized (this.mLock) {
                    String name = request.getProvider();
                    if (name == null) {
                        name = "fused";
                    }
                    if (((LocationProviderInterface) this.mProvidersByName.get(name)) == null) {
                        Binder.restoreCallingIdentity(identity);
                    } else if (isAllowedByUserSettingsLocked(name, uid)) {
                        Location location2;
                        if (allowedResolutionLevel < RESOLUTION_LEVEL_FINE) {
                            location2 = (Location) this.mLastLocationCoarseInterval.get(name);
                        } else {
                            location2 = (Location) this.mLastLocation.get(name);
                        }
                        if (location2 == null) {
                            Binder.restoreCallingIdentity(identity);
                        } else if (allowedResolutionLevel < RESOLUTION_LEVEL_FINE) {
                            Location noGPSLocation = location2.getExtraLocation("noGPSLocation");
                            if (noGPSLocation != null) {
                                location = new Location(this.mLocationFudger.getOrCreate(noGPSLocation));
                                Binder.restoreCallingIdentity(identity);
                            } else {
                                Binder.restoreCallingIdentity(identity);
                            }
                        } else {
                            location = new Location(location2);
                            Binder.restoreCallingIdentity(identity);
                        }
                    } else {
                        Binder.restoreCallingIdentity(identity);
                    }
                }
            } else {
                if (f0D) {
                    Log.d(WAKELOCK_KEY, "not returning last loc for no op app: " + packageName);
                }
                Binder.restoreCallingIdentity(identity);
            }
            return location;
        } catch (Throwable th) {
            Binder.restoreCallingIdentity(identity);
        }
    }

    public void requestGeofence(LocationRequest request, Geofence geofence, PendingIntent intent, String packageName) {
        if (request == null) {
            request = DEFAULT_LOCATION_REQUEST;
        }
        int allowedResolutionLevel = getCallerAllowedResolutionLevel();
        checkResolutionLevelIsSufficientForGeofenceUse(allowedResolutionLevel);
        checkPendingIntent(intent);
        checkPackageName(packageName);
        checkResolutionLevelIsSufficientForProviderUse(allowedResolutionLevel, request.getProvider());
        LocationRequest sanitizedRequest = createSanitizedRequest(request, allowedResolutionLevel);
        if (f0D) {
            Log.d(WAKELOCK_KEY, "requestGeofence: " + sanitizedRequest + " " + geofence + " " + intent);
        }
        int uid = Binder.getCallingUid();
        if (UserHandle.getUserId(uid) != 0) {
            Log.w(WAKELOCK_KEY, "proximity alerts are currently available only to the primary user");
            return;
        }
        long identity = Binder.clearCallingIdentity();
        try {
            if (this.mGeoFencer == null || !this.mGeoFencerEnabled) {
                this.mGeofenceManager.addFence(sanitizedRequest, geofence, intent, allowedResolutionLevel, uid, packageName);
            } else {
                long expiration;
                if (sanitizedRequest.getExpireAt() == JobStatus.NO_LATEST_RUNTIME) {
                    expiration = -1;
                } else {
                    expiration = sanitizedRequest.getExpireAt() - SystemClock.elapsedRealtime();
                }
                this.mGeoFencer.add(new GeoFenceParams(uid, geofence.getLatitude(), geofence.getLongitude(), geofence.getRadius(), expiration, intent, packageName));
            }
            Binder.restoreCallingIdentity(identity);
        } catch (Throwable th) {
            Binder.restoreCallingIdentity(identity);
        }
    }

    public void removeGeofence(Geofence geofence, PendingIntent intent, String packageName) {
        checkResolutionLevelIsSufficientForGeofenceUse(getCallerAllowedResolutionLevel());
        checkPendingIntent(intent);
        checkPackageName(packageName);
        if (f0D) {
            Log.d(WAKELOCK_KEY, "removeGeofence: " + geofence + " " + intent);
        }
        long identity = Binder.clearCallingIdentity();
        try {
            if (this.mGeoFencer == null || !this.mGeoFencerEnabled) {
                this.mGeofenceManager.removeFence(geofence, intent);
            } else {
                this.mGeoFencer.remove(intent);
            }
            Binder.restoreCallingIdentity(identity);
        } catch (Throwable th) {
            Binder.restoreCallingIdentity(identity);
        }
    }

    public boolean addGpsStatusListener(IGpsStatusListener listener, String packageName) {
        int allowedResolutionLevel = getCallerAllowedResolutionLevel();
        checkResolutionLevelIsSufficientForProviderUse(allowedResolutionLevel, "gps");
        int uid = Binder.getCallingUid();
        long ident = Binder.clearCallingIdentity();
        try {
            if (!checkLocationAccess(uid, packageName, allowedResolutionLevel)) {
                return f0D;
            }
            Binder.restoreCallingIdentity(ident);
            if (this.mGpsStatusProvider == null) {
                return f0D;
            }
            try {
                this.mGpsStatusProvider.addGpsStatusListener(listener);
                return true;
            } catch (RemoteException e) {
                Slog.e(WAKELOCK_KEY, "mGpsStatusProvider.addGpsStatusListener failed", e);
                return f0D;
            }
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    public void removeGpsStatusListener(IGpsStatusListener listener) {
        synchronized (this.mLock) {
            try {
                this.mGpsStatusProvider.removeGpsStatusListener(listener);
            } catch (Exception e) {
                Slog.e(WAKELOCK_KEY, "mGpsStatusProvider.removeGpsStatusListener failed", e);
            }
        }
    }

    public boolean addGpsMeasurementsListener(IGpsMeasurementsListener listener, String packageName) {
        int allowedResolutionLevel = getCallerAllowedResolutionLevel();
        checkResolutionLevelIsSufficientForProviderUse(allowedResolutionLevel, "gps");
        int uid = Binder.getCallingUid();
        long identity = Binder.clearCallingIdentity();
        try {
            boolean hasLocationAccess = checkLocationAccess(uid, packageName, allowedResolutionLevel);
            if (hasLocationAccess) {
                return this.mGpsMeasurementsProvider.addListener(listener);
            }
            return f0D;
        } finally {
            Binder.restoreCallingIdentity(identity);
        }
    }

    public void removeGpsMeasurementsListener(IGpsMeasurementsListener listener) {
        this.mGpsMeasurementsProvider.removeListener(listener);
    }

    public boolean addGpsNavigationMessageListener(IGpsNavigationMessageListener listener, String packageName) {
        int allowedResolutionLevel = getCallerAllowedResolutionLevel();
        checkResolutionLevelIsSufficientForProviderUse(allowedResolutionLevel, "gps");
        int uid = Binder.getCallingUid();
        long identity = Binder.clearCallingIdentity();
        try {
            boolean hasLocationAccess = checkLocationAccess(uid, packageName, allowedResolutionLevel);
            if (hasLocationAccess) {
                return this.mGpsNavigationMessageProvider.addListener(listener);
            }
            return f0D;
        } finally {
            Binder.restoreCallingIdentity(identity);
        }
    }

    public void removeGpsNavigationMessageListener(IGpsNavigationMessageListener listener) {
        this.mGpsNavigationMessageProvider.removeListener(listener);
    }

    public boolean sendExtraCommand(String provider, String command, Bundle extras) {
        if (provider == null) {
            throw new NullPointerException();
        }
        checkResolutionLevelIsSufficientForProviderUse(getCallerAllowedResolutionLevel(), provider);
        if (this.mContext.checkCallingOrSelfPermission(ACCESS_LOCATION_EXTRA_COMMANDS) != 0) {
            throw new SecurityException("Requires ACCESS_LOCATION_EXTRA_COMMANDS permission");
        }
        boolean z;
        synchronized (this.mLock) {
            LocationProviderInterface p = (LocationProviderInterface) this.mProvidersByName.get(provider);
            if (p == null) {
                z = f0D;
            } else {
                z = p.sendExtraCommand(command, extras);
            }
        }
        return z;
    }

    public boolean sendNiResponse(int notifId, int userResponse) {
        if (Binder.getCallingUid() != Process.myUid()) {
            throw new SecurityException("calling sendNiResponse from outside of the system is not allowed");
        }
        try {
            return this.mNetInitiatedListener.sendNiResponse(notifId, userResponse);
        } catch (RemoteException e) {
            Slog.e(WAKELOCK_KEY, "RemoteException in LocationManagerService.sendNiResponse");
            return f0D;
        }
    }

    public ProviderProperties getProviderProperties(String provider) {
        if (this.mProvidersByName.get(provider) == null) {
            return null;
        }
        checkResolutionLevelIsSufficientForProviderUse(getCallerAllowedResolutionLevel(), provider);
        synchronized (this.mLock) {
            LocationProviderInterface p = (LocationProviderInterface) this.mProvidersByName.get(provider);
        }
        if (p != null) {
            return p.getProperties();
        }
        return null;
    }

    public boolean isProviderEnabled(String provider) {
        boolean z = f0D;
        if (!"fused".equals(provider)) {
            int uid = Binder.getCallingUid();
            long identity = Binder.clearCallingIdentity();
            try {
                synchronized (this.mLock) {
                    if (((LocationProviderInterface) this.mProvidersByName.get(provider)) == null) {
                    } else {
                        z = isAllowedByUserSettingsLocked(provider, uid);
                        Binder.restoreCallingIdentity(identity);
                    }
                }
            } finally {
                Binder.restoreCallingIdentity(identity);
            }
        }
        return z;
    }

    private boolean isUidALocationProvider(int uid) {
        if (uid == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
            return true;
        }
        if (this.mGeocodeProvider != null && doesUidHavePackage(uid, this.mGeocodeProvider.getConnectedPackageName())) {
            return true;
        }
        Iterator i$ = this.mProxyProviders.iterator();
        while (i$.hasNext()) {
            if (doesUidHavePackage(uid, ((LocationProviderProxy) i$.next()).getConnectedPackageName())) {
                return true;
            }
        }
        return f0D;
    }

    private void checkCallerIsProvider() {
        if (this.mContext.checkCallingOrSelfPermission(INSTALL_LOCATION_PROVIDER) != 0 && !isUidALocationProvider(Binder.getCallingUid())) {
            throw new SecurityException("need INSTALL_LOCATION_PROVIDER permission, or UID of a currently bound location provider");
        }
    }

    private boolean doesUidHavePackage(int uid, String packageName) {
        if (packageName == null) {
            return f0D;
        }
        String[] packageNames = this.mPackageManager.getPackagesForUid(uid);
        if (packageNames == null) {
            return f0D;
        }
        String[] arr$ = packageNames;
        int len$ = arr$.length;
        for (int i$ = RESOLUTION_LEVEL_NONE; i$ < len$; i$ += RESOLUTION_LEVEL_COARSE) {
            if (packageName.equals(arr$[i$])) {
                return true;
            }
        }
        return f0D;
    }

    public void reportLocation(Location location, boolean passive) {
        int i = RESOLUTION_LEVEL_COARSE;
        checkCallerIsProvider();
        if (location.isComplete()) {
            this.mLocationHandler.removeMessages(RESOLUTION_LEVEL_COARSE, location);
            Message m = Message.obtain(this.mLocationHandler, RESOLUTION_LEVEL_COARSE, location);
            if (!passive) {
                i = RESOLUTION_LEVEL_NONE;
            }
            m.arg1 = i;
            this.mLocationHandler.sendMessageAtFrontOfQueue(m);
            return;
        }
        Log.w(WAKELOCK_KEY, "Dropping incomplete location: " + location);
    }

    private static boolean shouldBroadcastSafe(Location loc, Location lastLoc, UpdateRecord record, long now) {
        if (lastLoc == null) {
            return true;
        }
        if ((loc.getElapsedRealtimeNanos() - lastLoc.getElapsedRealtimeNanos()) / NANOS_PER_MILLI < record.mRequest.getFastestInterval() - 100) {
            return f0D;
        }
        double minDistance = (double) record.mRequest.getSmallestDisplacement();
        if (minDistance > 0.0d && ((double) loc.distanceTo(lastLoc)) <= minDistance) {
            return f0D;
        }
        if (record.mRequest.getNumUpdates() <= 0) {
            return f0D;
        }
        if (record.mRequest.getExpireAt() < now) {
            return f0D;
        }
        return true;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void handleLocationChangedLocked(android.location.Location r37, boolean r38) {
        /*
        r36 = this;
        r29 = f0D;
        if (r29 == 0) goto L_0x0024;
    L_0x0004:
        r29 = "LocationManagerService";
        r32 = new java.lang.StringBuilder;
        r32.<init>();
        r33 = "incoming location: ";
        r32 = r32.append(r33);
        r0 = r32;
        r1 = r37;
        r32 = r0.append(r1);
        r32 = r32.toString();
        r0 = r29;
        r1 = r32;
        android.util.Log.d(r0, r1);
    L_0x0024:
        r18 = android.os.SystemClock.elapsedRealtime();
        if (r38 == 0) goto L_0x003f;
    L_0x002a:
        r22 = "passive";
    L_0x002c:
        r0 = r36;
        r0 = r0.mProvidersByName;
        r29 = r0;
        r0 = r29;
        r1 = r22;
        r17 = r0.get(r1);
        r17 = (com.android.server.location.LocationProviderInterface) r17;
        if (r17 != 0) goto L_0x0044;
    L_0x003e:
        return;
    L_0x003f:
        r22 = r37.getProvider();
        goto L_0x002c;
    L_0x0044:
        r29 = "noGPSLocation";
        r0 = r37;
        r1 = r29;
        r13 = r0.getExtraLocation(r1);
        r12 = 0;
        r0 = r36;
        r0 = r0.mLastLocation;
        r29 = r0;
        r0 = r29;
        r1 = r22;
        r10 = r0.get(r1);
        r10 = (android.location.Location) r10;
        if (r10 != 0) goto L_0x0180;
    L_0x0061:
        r10 = new android.location.Location;
        r0 = r22;
        r10.<init>(r0);
        r0 = r36;
        r0 = r0.mLastLocation;
        r29 = r0;
        r0 = r29;
        r1 = r22;
        r0.put(r1, r10);
    L_0x0075:
        r0 = r37;
        r10.set(r0);
        r0 = r36;
        r0 = r0.mLastLocationCoarseInterval;
        r29 = r0;
        r0 = r29;
        r1 = r22;
        r11 = r0.get(r1);
        r11 = (android.location.Location) r11;
        if (r11 != 0) goto L_0x00a0;
    L_0x008c:
        r11 = new android.location.Location;
        r0 = r37;
        r11.<init>(r0);
        r0 = r36;
        r0 = r0.mLastLocationCoarseInterval;
        r29 = r0;
        r0 = r29;
        r1 = r22;
        r0.put(r1, r11);
    L_0x00a0:
        r32 = r37.getElapsedRealtimeNanos();
        r34 = r11.getElapsedRealtimeNanos();
        r30 = r32 - r34;
        r32 = 600000000000; // 0x8bb2c97000 float:-2.3450411E-8 double:2.964393875047E-312;
        r29 = (r30 > r32 ? 1 : (r30 == r32 ? 0 : -1));
        if (r29 <= 0) goto L_0x00b8;
    L_0x00b3:
        r0 = r37;
        r11.set(r0);
    L_0x00b8:
        r29 = "noGPSLocation";
        r0 = r29;
        r13 = r11.getExtraLocation(r0);
        r0 = r36;
        r0 = r0.mRecordsByProvider;
        r29 = r0;
        r0 = r29;
        r1 = r22;
        r27 = r0.get(r1);
        r27 = (java.util.ArrayList) r27;
        if (r27 == 0) goto L_0x003e;
    L_0x00d2:
        r29 = r27.size();
        if (r29 == 0) goto L_0x003e;
    L_0x00d8:
        r4 = 0;
        if (r13 == 0) goto L_0x00e7;
    L_0x00db:
        r0 = r36;
        r0 = r0.mLocationFudger;
        r29 = r0;
        r0 = r29;
        r4 = r0.getOrCreate(r13);
    L_0x00e7:
        r14 = r17.getStatusUpdateTime();
        r7 = new android.os.Bundle;
        r7.<init>();
        r0 = r17;
        r28 = r0.getStatus(r7);
        r5 = 0;
        r6 = 0;
        r8 = r27.iterator();
    L_0x00fc:
        r29 = r8.hasNext();
        if (r29 == 0) goto L_0x0318;
    L_0x0102:
        r23 = r8.next();
        r23 = (com.android.server.LocationManagerService.UpdateRecord) r23;
        r0 = r23;
        r0 = r0.mReceiver;
        r24 = r0;
        r25 = 0;
        r0 = r24;
        r0 = r0.mUid;
        r29 = r0;
        r26 = android.os.UserHandle.getUserId(r29);
        r0 = r36;
        r1 = r26;
        r29 = r0.isCurrentProfile(r1);
        if (r29 != 0) goto L_0x0197;
    L_0x0124:
        r0 = r24;
        r0 = r0.mUid;
        r29 = r0;
        r0 = r36;
        r1 = r29;
        r29 = r0.isUidALocationProvider(r1);
        if (r29 != 0) goto L_0x0197;
    L_0x0134:
        r29 = f0D;
        if (r29 == 0) goto L_0x00fc;
    L_0x0138:
        r29 = "LocationManagerService";
        r32 = new java.lang.StringBuilder;
        r32.<init>();
        r33 = "skipping loc update for background user ";
        r32 = r32.append(r33);
        r0 = r32;
        r1 = r26;
        r32 = r0.append(r1);
        r33 = " (current user: ";
        r32 = r32.append(r33);
        r0 = r36;
        r0 = r0.mCurrentUserId;
        r33 = r0;
        r32 = r32.append(r33);
        r33 = ", app: ";
        r32 = r32.append(r33);
        r0 = r24;
        r0 = r0.mPackageName;
        r33 = r0;
        r32 = r32.append(r33);
        r33 = ")";
        r32 = r32.append(r33);
        r32 = r32.toString();
        r0 = r29;
        r1 = r32;
        android.util.Log.d(r0, r1);
        goto L_0x00fc;
    L_0x0180:
        r29 = "noGPSLocation";
        r0 = r29;
        r12 = r10.getExtraLocation(r0);
        if (r13 != 0) goto L_0x0075;
    L_0x018a:
        if (r12 == 0) goto L_0x0075;
    L_0x018c:
        r29 = "noGPSLocation";
        r0 = r37;
        r1 = r29;
        r0.setExtraLocation(r1, r12);
        goto L_0x0075;
    L_0x0197:
        r0 = r36;
        r0 = r0.mBlacklist;
        r29 = r0;
        r0 = r24;
        r0 = r0.mPackageName;
        r32 = r0;
        r0 = r29;
        r1 = r32;
        r29 = r0.isBlacklisted(r1);
        if (r29 == 0) goto L_0x01d5;
    L_0x01ad:
        r29 = f0D;
        if (r29 == 0) goto L_0x00fc;
    L_0x01b1:
        r29 = "LocationManagerService";
        r32 = new java.lang.StringBuilder;
        r32.<init>();
        r33 = "skipping loc update for blacklisted app: ";
        r32 = r32.append(r33);
        r0 = r24;
        r0 = r0.mPackageName;
        r33 = r0;
        r32 = r32.append(r33);
        r32 = r32.toString();
        r0 = r29;
        r1 = r32;
        android.util.Log.d(r0, r1);
        goto L_0x00fc;
    L_0x01d5:
        r0 = r24;
        r0 = r0.mUid;
        r29 = r0;
        r0 = r24;
        r0 = r0.mPackageName;
        r32 = r0;
        r0 = r24;
        r0 = r0.mAllowedResolutionLevel;
        r33 = r0;
        r0 = r36;
        r1 = r29;
        r2 = r32;
        r3 = r33;
        r29 = r0.reportLocationAccessNoThrow(r1, r2, r3);
        if (r29 != 0) goto L_0x021d;
    L_0x01f5:
        r29 = f0D;
        if (r29 == 0) goto L_0x00fc;
    L_0x01f9:
        r29 = "LocationManagerService";
        r32 = new java.lang.StringBuilder;
        r32.<init>();
        r33 = "skipping loc update for no op app: ";
        r32 = r32.append(r33);
        r0 = r24;
        r0 = r0.mPackageName;
        r33 = r0;
        r32 = r32.append(r33);
        r32 = r32.toString();
        r0 = r29;
        r1 = r32;
        android.util.Log.d(r0, r1);
        goto L_0x00fc;
    L_0x021d:
        r16 = 0;
        r0 = r24;
        r0 = r0.mAllowedResolutionLevel;
        r29 = r0;
        r32 = 2;
        r0 = r29;
        r1 = r32;
        if (r0 >= r1) goto L_0x030d;
    L_0x022d:
        r16 = r4;
    L_0x022f:
        if (r16 == 0) goto L_0x0285;
    L_0x0231:
        r0 = r23;
        r9 = r0.mLastFixBroadcast;
        if (r9 == 0) goto L_0x0243;
    L_0x0237:
        r0 = r16;
        r1 = r23;
        r2 = r18;
        r29 = shouldBroadcastSafe(r0, r9, r1, r2);
        if (r29 == 0) goto L_0x0285;
    L_0x0243:
        if (r9 != 0) goto L_0x0311;
    L_0x0245:
        r9 = new android.location.Location;
        r0 = r16;
        r9.<init>(r0);
        r0 = r23;
        r0.mLastFixBroadcast = r9;
    L_0x0250:
        r0 = r24;
        r1 = r16;
        r29 = r0.callLocationChangedLocked(r1);
        if (r29 != 0) goto L_0x027c;
    L_0x025a:
        r29 = "LocationManagerService";
        r32 = new java.lang.StringBuilder;
        r32.<init>();
        r33 = "RemoteException calling onLocationChanged on ";
        r32 = r32.append(r33);
        r0 = r32;
        r1 = r24;
        r32 = r0.append(r1);
        r32 = r32.toString();
        r0 = r29;
        r1 = r32;
        android.util.Slog.w(r0, r1);
        r25 = 1;
    L_0x027c:
        r0 = r23;
        r0 = r0.mRequest;
        r29 = r0;
        r29.decrementNumUpdates();
    L_0x0285:
        r0 = r23;
        r0 = r0.mLastStatusBroadcast;
        r20 = r0;
        r29 = (r14 > r20 ? 1 : (r14 == r20 ? 0 : -1));
        if (r29 <= 0) goto L_0x02cf;
    L_0x028f:
        r32 = 0;
        r29 = (r20 > r32 ? 1 : (r20 == r32 ? 0 : -1));
        if (r29 != 0) goto L_0x029d;
    L_0x0295:
        r29 = 2;
        r0 = r28;
        r1 = r29;
        if (r0 == r1) goto L_0x02cf;
    L_0x029d:
        r0 = r23;
        r0.mLastStatusBroadcast = r14;
        r0 = r24;
        r1 = r22;
        r2 = r28;
        r29 = r0.callStatusChangedLocked(r1, r2, r7);
        if (r29 != 0) goto L_0x02cf;
    L_0x02ad:
        r25 = 1;
        r29 = "LocationManagerService";
        r32 = new java.lang.StringBuilder;
        r32.<init>();
        r33 = "RemoteException calling onStatusChanged on ";
        r32 = r32.append(r33);
        r0 = r32;
        r1 = r24;
        r32 = r0.append(r1);
        r32 = r32.toString();
        r0 = r29;
        r1 = r32;
        android.util.Slog.w(r0, r1);
    L_0x02cf:
        r0 = r23;
        r0 = r0.mRequest;
        r29 = r0;
        r29 = r29.getNumUpdates();
        if (r29 <= 0) goto L_0x02e9;
    L_0x02db:
        r0 = r23;
        r0 = r0.mRequest;
        r29 = r0;
        r32 = r29.getExpireAt();
        r29 = (r32 > r18 ? 1 : (r32 == r18 ? 0 : -1));
        if (r29 >= 0) goto L_0x02f5;
    L_0x02e9:
        if (r6 != 0) goto L_0x02f0;
    L_0x02eb:
        r6 = new java.util.ArrayList;
        r6.<init>();
    L_0x02f0:
        r0 = r23;
        r6.add(r0);
    L_0x02f5:
        if (r25 == 0) goto L_0x00fc;
    L_0x02f7:
        if (r5 != 0) goto L_0x02fe;
    L_0x02f9:
        r5 = new java.util.ArrayList;
        r5.<init>();
    L_0x02fe:
        r0 = r24;
        r29 = r5.contains(r0);
        if (r29 != 0) goto L_0x00fc;
    L_0x0306:
        r0 = r24;
        r5.add(r0);
        goto L_0x00fc;
    L_0x030d:
        r16 = r10;
        goto L_0x022f;
    L_0x0311:
        r0 = r16;
        r9.set(r0);
        goto L_0x0250;
    L_0x0318:
        if (r5 == 0) goto L_0x0332;
    L_0x031a:
        r8 = r5.iterator();
    L_0x031e:
        r29 = r8.hasNext();
        if (r29 == 0) goto L_0x0332;
    L_0x0324:
        r24 = r8.next();
        r24 = (com.android.server.LocationManagerService.Receiver) r24;
        r0 = r36;
        r1 = r24;
        r0.removeUpdatesLocked(r1);
        goto L_0x031e;
    L_0x0332:
        if (r6 == 0) goto L_0x003e;
    L_0x0334:
        r8 = r6.iterator();
    L_0x0338:
        r29 = r8.hasNext();
        if (r29 == 0) goto L_0x034e;
    L_0x033e:
        r23 = r8.next();
        r23 = (com.android.server.LocationManagerService.UpdateRecord) r23;
        r29 = 1;
        r0 = r23;
        r1 = r29;
        r0.disposeLocked(r1);
        goto L_0x0338;
    L_0x034e:
        r0 = r36;
        r1 = r22;
        r0.applyRequirementsLocked(r1);
        goto L_0x003e;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.LocationManagerService.handleLocationChangedLocked(android.location.Location, boolean):void");
    }

    private boolean isMockProvider(String provider) {
        boolean containsKey;
        synchronized (this.mLock) {
            containsKey = this.mMockProviders.containsKey(provider);
        }
        return containsKey;
    }

    private Location screenLocationLocked(Location location, String provider) {
        if (isMockProvider("network")) {
            return location;
        }
        LocationProviderProxy providerProxy = (LocationProviderProxy) this.mProvidersByName.get("network");
        if (this.mComboNlpPackageName == null || providerProxy == null || !provider.equals("network") || isMockProvider("network")) {
            return location;
        }
        String connectedNlpPackage = providerProxy.getConnectedPackageName();
        if (connectedNlpPackage == null || !connectedNlpPackage.equals(this.mComboNlpPackageName)) {
            return location;
        }
        Bundle extras = location.getExtras();
        boolean isBeingScreened = f0D;
        if (extras == null) {
            extras = new Bundle();
        }
        if (extras.containsKey(this.mComboNlpReadyMarker)) {
            if (f0D) {
                Log.d(WAKELOCK_KEY, "This location is marked as ready for broadcast");
            }
            extras.remove(this.mComboNlpReadyMarker);
            return location;
        }
        ArrayList<UpdateRecord> records = (ArrayList) this.mRecordsByProvider.get("passive");
        if (records != null) {
            Iterator i$ = records.iterator();
            while (i$.hasNext()) {
                UpdateRecord r = (UpdateRecord) i$.next();
                if (r.mReceiver.mPackageName.equals(this.mComboNlpPackageName)) {
                    if (!isBeingScreened) {
                        isBeingScreened = true;
                        extras.putBoolean(this.mComboNlpScreenMarker, true);
                    }
                    if (!r.mReceiver.callLocationChangedLocked(location)) {
                        Slog.w(WAKELOCK_KEY, "RemoteException calling onLocationChanged on " + r.mReceiver);
                    } else if (f0D) {
                        Log.d(WAKELOCK_KEY, "Sending location for screening");
                    }
                }
            }
        }
        if (isBeingScreened) {
            return null;
        }
        if (!f0D) {
            return location;
        }
        Log.d(WAKELOCK_KEY, "Not screening locations");
        return location;
    }

    private void handleLocationChanged(Location location, boolean passive) {
        Location myLocation = new Location(location);
        String provider = myLocation.getProvider();
        if (!myLocation.isFromMockProvider() && isMockProvider(provider)) {
            myLocation.setIsFromMockProvider(true);
        }
        synchronized (this.mLock) {
            if (isAllowedByCurrentUserSettingsLocked(provider)) {
                if (!passive) {
                    if (screenLocationLocked(location, provider) == null) {
                        return;
                    }
                    this.mPassiveProvider.updateLocation(myLocation);
                }
                handleLocationChangedLocked(myLocation, passive);
            }
        }
    }

    public boolean geocoderIsPresent() {
        return this.mGeocodeProvider != null ? true : f0D;
    }

    public String getFromLocation(double latitude, double longitude, int maxResults, GeocoderParams params, List<Address> addrs) {
        if (this.mGeocodeProvider != null) {
            return this.mGeocodeProvider.getFromLocation(latitude, longitude, maxResults, params, addrs);
        }
        return null;
    }

    public String getFromLocationName(String locationName, double lowerLeftLatitude, double lowerLeftLongitude, double upperRightLatitude, double upperRightLongitude, int maxResults, GeocoderParams params, List<Address> addrs) {
        if (this.mGeocodeProvider != null) {
            return this.mGeocodeProvider.getFromLocationName(locationName, lowerLeftLatitude, lowerLeftLongitude, upperRightLatitude, upperRightLongitude, maxResults, params, addrs);
        }
        return null;
    }

    private void checkMockPermissionsSafe() {
        boolean allowMocks = true;
        if (Secure.getInt(this.mContext.getContentResolver(), "mock_location", RESOLUTION_LEVEL_NONE) != RESOLUTION_LEVEL_COARSE) {
            allowMocks = f0D;
        }
        if (!allowMocks) {
            throw new SecurityException("Requires ACCESS_MOCK_LOCATION secure setting");
        } else if (this.mContext.checkCallingPermission(ACCESS_MOCK_LOCATION) != 0) {
            throw new SecurityException("Requires ACCESS_MOCK_LOCATION permission");
        }
    }

    public void addTestProvider(String name, ProviderProperties properties) {
        checkMockPermissionsSafe();
        if ("passive".equals(name)) {
            throw new IllegalArgumentException("Cannot mock the passive location provider");
        }
        long identity = Binder.clearCallingIdentity();
        synchronized (this.mLock) {
            if ("gps".equals(name) || "network".equals(name) || "fused".equals(name)) {
                LocationProviderInterface p = (LocationProviderInterface) this.mProvidersByName.get(name);
                if (p != null) {
                    removeProviderLocked(p);
                }
            }
            this.mGeoFencerEnabled = f0D;
            addTestProviderLocked(name, properties);
            updateProvidersLocked();
        }
        Binder.restoreCallingIdentity(identity);
    }

    private void addTestProviderLocked(String name, ProviderProperties properties) {
        if (this.mProvidersByName.get(name) != null) {
            throw new IllegalArgumentException("Provider \"" + name + "\" already exists");
        }
        MockProvider provider = new MockProvider(name, this, properties);
        addProviderLocked(provider);
        this.mMockProviders.put(name, provider);
        this.mLastLocation.put(name, null);
        this.mLastLocationCoarseInterval.put(name, null);
    }

    public void removeTestProvider(String provider) {
        checkMockPermissionsSafe();
        synchronized (this.mLock) {
            clearTestProviderEnabled(provider);
            clearTestProviderLocation(provider);
            clearTestProviderStatus(provider);
            if (((MockProvider) this.mMockProviders.remove(provider)) == null) {
                throw new IllegalArgumentException("Provider \"" + provider + "\" unknown");
            }
            long identity = Binder.clearCallingIdentity();
            removeProviderLocked((LocationProviderInterface) this.mProvidersByName.get(provider));
            if (this.mGeoFencer != null) {
                this.mGeoFencerEnabled = true;
            }
            LocationProviderInterface realProvider = (LocationProviderInterface) this.mRealProviders.get(provider);
            if (realProvider != null) {
                addProviderLocked(realProvider);
            }
            this.mLastLocation.put(provider, null);
            this.mLastLocationCoarseInterval.put(provider, null);
            updateProvidersLocked();
            Binder.restoreCallingIdentity(identity);
        }
    }

    public void setTestProviderLocation(String provider, Location loc) {
        checkMockPermissionsSafe();
        synchronized (this.mLock) {
            MockProvider mockProvider = (MockProvider) this.mMockProviders.get(provider);
            if (mockProvider == null) {
                throw new IllegalArgumentException("Provider \"" + provider + "\" unknown");
            }
            long identity = Binder.clearCallingIdentity();
            mockProvider.setLocation(loc);
            Binder.restoreCallingIdentity(identity);
        }
    }

    public void clearTestProviderLocation(String provider) {
        checkMockPermissionsSafe();
        synchronized (this.mLock) {
            MockProvider mockProvider = (MockProvider) this.mMockProviders.get(provider);
            if (mockProvider == null) {
                throw new IllegalArgumentException("Provider \"" + provider + "\" unknown");
            }
            mockProvider.clearLocation();
        }
    }

    public void setTestProviderEnabled(String provider, boolean enabled) {
        checkMockPermissionsSafe();
        synchronized (this.mLock) {
            MockProvider mockProvider = (MockProvider) this.mMockProviders.get(provider);
            if (mockProvider == null) {
                throw new IllegalArgumentException("Provider \"" + provider + "\" unknown");
            }
            long identity = Binder.clearCallingIdentity();
            if (enabled) {
                mockProvider.enable();
                this.mEnabledProviders.add(provider);
                this.mDisabledProviders.remove(provider);
            } else {
                mockProvider.disable();
                this.mEnabledProviders.remove(provider);
                this.mDisabledProviders.add(provider);
            }
            updateProvidersLocked();
            Binder.restoreCallingIdentity(identity);
        }
    }

    public void clearTestProviderEnabled(String provider) {
        checkMockPermissionsSafe();
        synchronized (this.mLock) {
            if (((MockProvider) this.mMockProviders.get(provider)) == null) {
                throw new IllegalArgumentException("Provider \"" + provider + "\" unknown");
            }
            long identity = Binder.clearCallingIdentity();
            this.mEnabledProviders.remove(provider);
            this.mDisabledProviders.remove(provider);
            updateProvidersLocked();
            Binder.restoreCallingIdentity(identity);
        }
    }

    public void setTestProviderStatus(String provider, int status, Bundle extras, long updateTime) {
        checkMockPermissionsSafe();
        synchronized (this.mLock) {
            MockProvider mockProvider = (MockProvider) this.mMockProviders.get(provider);
            if (mockProvider == null) {
                throw new IllegalArgumentException("Provider \"" + provider + "\" unknown");
            }
            mockProvider.setStatus(status, extras, updateTime);
        }
    }

    public void clearTestProviderStatus(String provider) {
        checkMockPermissionsSafe();
        synchronized (this.mLock) {
            MockProvider mockProvider = (MockProvider) this.mMockProviders.get(provider);
            if (mockProvider == null) {
                throw new IllegalArgumentException("Provider \"" + provider + "\" unknown");
            }
            mockProvider.clearStatus();
        }
    }

    private void log(String log) {
        if (Log.isLoggable(WAKELOCK_KEY, RESOLUTION_LEVEL_FINE)) {
            Slog.d(WAKELOCK_KEY, log);
        }
    }

    protected void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        if (this.mContext.checkCallingOrSelfPermission("android.permission.DUMP") != 0) {
            pw.println("Permission Denial: can't dump LocationManagerService from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid());
            return;
        }
        synchronized (this.mLock) {
            pw.println("Current Location Manager state:");
            pw.println("  Location Listeners:");
            for (Receiver receiver : this.mReceivers.values()) {
                pw.println("    " + receiver);
            }
            pw.println("  Active Records by Provider:");
            for (Entry<String, ArrayList<UpdateRecord>> entry : this.mRecordsByProvider.entrySet()) {
                pw.println("    " + ((String) entry.getKey()) + ":");
                Iterator i$ = ((ArrayList) entry.getValue()).iterator();
                while (i$.hasNext()) {
                    UpdateRecord record = (UpdateRecord) i$.next();
                    pw.println("      " + record);
                }
            }
            pw.println("  Historical Records by Provider:");
            for (Entry<PackageProviderKey, PackageStatistics> entry2 : this.mRequestStatistics.statistics.entrySet()) {
                PackageProviderKey key = (PackageProviderKey) entry2.getKey();
                PackageStatistics stats = (PackageStatistics) entry2.getValue();
                pw.println("    " + key.packageName + ": " + key.providerName + ": " + stats);
            }
            pw.println("  Last Known Locations:");
            for (Entry<String, Location> entry3 : this.mLastLocation.entrySet()) {
                String provider = (String) entry3.getKey();
                Location location = (Location) entry3.getValue();
                pw.println("    " + provider + ": " + location);
            }
            pw.println("  Last Known Locations Coarse Intervals:");
            for (Entry<String, Location> entry32 : this.mLastLocationCoarseInterval.entrySet()) {
                provider = (String) entry32.getKey();
                location = (Location) entry32.getValue();
                pw.println("    " + provider + ": " + location);
            }
            this.mGeofenceManager.dump(pw);
            if (this.mGeoFencer != null && this.mGeoFencerEnabled) {
                this.mGeoFencer.dump(pw, "");
            }
            if (this.mEnabledProviders.size() > 0) {
                pw.println("  Enabled Providers:");
                for (String i : this.mEnabledProviders) {
                    pw.println("    " + i);
                }
            }
            if (this.mDisabledProviders.size() > 0) {
                pw.println("  Disabled Providers:");
                for (String i2 : this.mDisabledProviders) {
                    pw.println("    " + i2);
                }
            }
            pw.append("  ");
            this.mBlacklist.dump(pw);
            if (this.mMockProviders.size() > 0) {
                pw.println("  Mock Providers:");
                for (Entry<String, MockProvider> i3 : this.mMockProviders.entrySet()) {
                    ((MockProvider) i3.getValue()).dump(pw, "      ");
                }
            }
            pw.append("  fudger: ");
            this.mLocationFudger.dump(fd, pw, args);
            if (args.length > 0) {
                if ("short".equals(args[RESOLUTION_LEVEL_NONE])) {
                    return;
                }
            }
            Iterator i$2 = this.mProviders.iterator();
            while (i$2.hasNext()) {
                LocationProviderInterface provider2 = (LocationProviderInterface) i$2.next();
                pw.print(provider2.getName() + " Internal State");
                if (provider2 instanceof LocationProviderProxy) {
                    LocationProviderProxy proxy = (LocationProviderProxy) provider2;
                    pw.print(" (" + proxy.getConnectedPackageName() + ")");
                }
                pw.println(":");
                provider2.dump(fd, pw, args);
            }
        }
    }
}
