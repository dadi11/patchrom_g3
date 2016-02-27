package com.android.server.location;

import android.content.Context;
import android.hardware.location.GeofenceHardwareImpl;
import android.hardware.location.GeofenceHardwareRequestParcelable;
import android.hardware.location.IFusedLocationHardware;
import android.hardware.location.IFusedLocationHardware.Stub;
import android.hardware.location.IFusedLocationHardwareSink;
import android.location.FusedBatchOptions;
import android.location.IFusedGeofenceHardware;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.location.LocationRequest;
import android.os.Bundle;
import android.os.Looper;
import android.os.RemoteException;
import android.os.SystemClock;
import android.util.Log;

public class FlpHardwareProvider {
    private static final int FLP_GEOFENCE_MONITOR_STATUS_AVAILABLE = 2;
    private static final int FLP_GEOFENCE_MONITOR_STATUS_UNAVAILABLE = 1;
    private static final int FLP_RESULT_ERROR = -1;
    private static final int FLP_RESULT_ID_EXISTS = -4;
    private static final int FLP_RESULT_ID_UNKNOWN = -5;
    private static final int FLP_RESULT_INSUFFICIENT_MEMORY = -2;
    private static final int FLP_RESULT_INVALID_GEOFENCE_TRANSITION = -6;
    private static final int FLP_RESULT_SUCCESS = 0;
    private static final int FLP_RESULT_TOO_MANY_GEOFENCES = -3;
    public static final String GEOFENCING = "Geofencing";
    public static final String LOCATION = "Location";
    private static final String TAG = "FlpHardwareProvider";
    private static FlpHardwareProvider sSingletonInstance;
    private final Context mContext;
    private final IFusedGeofenceHardware mGeofenceHardwareService;
    private GeofenceHardwareImpl mGeofenceHardwareSink;
    private final IFusedLocationHardware mLocationHardware;
    private IFusedLocationHardwareSink mLocationSink;
    private final Object mLocationSinkLock;

    /* renamed from: com.android.server.location.FlpHardwareProvider.1 */
    class C03431 extends Stub {
        C03431() {
        }

        public void registerSink(IFusedLocationHardwareSink eventSink) {
            synchronized (FlpHardwareProvider.this.mLocationSinkLock) {
                if (FlpHardwareProvider.this.mLocationSink != null) {
                    Log.e(FlpHardwareProvider.TAG, "Replacing an existing IFusedLocationHardware sink");
                }
                FlpHardwareProvider.this.mLocationSink = eventSink;
            }
        }

        public void unregisterSink(IFusedLocationHardwareSink eventSink) {
            synchronized (FlpHardwareProvider.this.mLocationSinkLock) {
                if (FlpHardwareProvider.this.mLocationSink == eventSink) {
                    FlpHardwareProvider.this.mLocationSink = null;
                }
            }
        }

        public int getSupportedBatchSize() {
            return FlpHardwareProvider.this.nativeGetBatchSize();
        }

        public void startBatching(int requestId, FusedBatchOptions options) {
            FlpHardwareProvider.this.nativeStartBatching(requestId, options);
        }

        public void stopBatching(int requestId) {
            FlpHardwareProvider.this.nativeStopBatching(requestId);
        }

        public void updateBatchingOptions(int requestId, FusedBatchOptions options) {
            FlpHardwareProvider.this.nativeUpdateBatchingOptions(requestId, options);
        }

        public void requestBatchOfLocations(int batchSizeRequested) {
            FlpHardwareProvider.this.nativeRequestBatchedLocation(batchSizeRequested);
        }

        public boolean supportsDiagnosticDataInjection() {
            return FlpHardwareProvider.this.nativeIsDiagnosticSupported();
        }

        public void injectDiagnosticData(String data) {
            FlpHardwareProvider.this.nativeInjectDiagnosticData(data);
        }

        public boolean supportsDeviceContextInjection() {
            return FlpHardwareProvider.this.nativeIsDeviceContextSupported();
        }

        public void injectDeviceContext(int deviceEnabledContext) {
            FlpHardwareProvider.this.nativeInjectDeviceContext(deviceEnabledContext);
        }
    }

    /* renamed from: com.android.server.location.FlpHardwareProvider.2 */
    class C03442 extends IFusedGeofenceHardware.Stub {
        C03442() {
        }

        public boolean isSupported() {
            return FlpHardwareProvider.this.nativeIsGeofencingSupported();
        }

        public void addGeofences(GeofenceHardwareRequestParcelable[] geofenceRequestsArray) {
            FlpHardwareProvider.this.nativeAddGeofences(geofenceRequestsArray);
        }

        public void removeGeofences(int[] geofenceIds) {
            FlpHardwareProvider.this.nativeRemoveGeofences(geofenceIds);
        }

        public void pauseMonitoringGeofence(int geofenceId) {
            FlpHardwareProvider.this.nativePauseGeofence(geofenceId);
        }

        public void resumeMonitoringGeofence(int geofenceId, int monitorTransitions) {
            FlpHardwareProvider.this.nativeResumeGeofence(geofenceId, monitorTransitions);
        }

        public void modifyGeofenceOptions(int geofenceId, int lastTransition, int monitorTransitions, int notificationResponsiveness, int unknownTimer, int sourcesToUse) {
            FlpHardwareProvider.this.nativeModifyGeofenceOption(geofenceId, lastTransition, monitorTransitions, notificationResponsiveness, unknownTimer, sourcesToUse);
        }
    }

    private final class NetworkLocationListener implements LocationListener {
        private NetworkLocationListener() {
        }

        public void onLocationChanged(Location location) {
            if ("network".equals(location.getProvider()) && location.hasAccuracy()) {
                FlpHardwareProvider.this.nativeInjectLocation(location);
            }
        }

        public void onStatusChanged(String provider, int status, Bundle extras) {
        }

        public void onProviderEnabled(String provider) {
        }

        public void onProviderDisabled(String provider) {
        }
    }

    private native void nativeAddGeofences(GeofenceHardwareRequestParcelable[] geofenceHardwareRequestParcelableArr);

    private static native void nativeClassInit();

    private native void nativeCleanup();

    private native int nativeGetBatchSize();

    private native void nativeInit();

    private native void nativeInjectDeviceContext(int i);

    private native void nativeInjectDiagnosticData(String str);

    private native void nativeInjectLocation(Location location);

    private native boolean nativeIsDeviceContextSupported();

    private native boolean nativeIsDiagnosticSupported();

    private native boolean nativeIsGeofencingSupported();

    private static native boolean nativeIsSupported();

    private native void nativeModifyGeofenceOption(int i, int i2, int i3, int i4, int i5, int i6);

    private native void nativePauseGeofence(int i);

    private native void nativeRemoveGeofences(int[] iArr);

    private native void nativeRequestBatchedLocation(int i);

    private native void nativeResumeGeofence(int i, int i2);

    private native void nativeStartBatching(int i, FusedBatchOptions fusedBatchOptions);

    private native void nativeStopBatching(int i);

    private native void nativeUpdateBatchingOptions(int i, FusedBatchOptions fusedBatchOptions);

    static {
        sSingletonInstance = null;
        nativeClassInit();
    }

    public static FlpHardwareProvider getInstance(Context context) {
        if (sSingletonInstance == null) {
            sSingletonInstance = new FlpHardwareProvider(context);
            sSingletonInstance.nativeInit();
        }
        return sSingletonInstance;
    }

    private FlpHardwareProvider(Context context) {
        this.mGeofenceHardwareSink = null;
        this.mLocationSink = null;
        this.mLocationSinkLock = new Object();
        this.mLocationHardware = new C03431();
        this.mGeofenceHardwareService = new C03442();
        this.mContext = context;
        LocationManager manager = (LocationManager) this.mContext.getSystemService("location");
        LocationRequest request = LocationRequest.createFromDeprecatedProvider("passive", 0, 0.0f, false);
        request.setHideFromAppOps(true);
        manager.requestLocationUpdates(request, new NetworkLocationListener(), Looper.myLooper());
    }

    public static boolean isSupported() {
        return nativeIsSupported();
    }

    private void onLocationReport(Location[] locations) {
        Location[] arr$ = locations;
        int len$ = arr$.length;
        for (int i$ = FLP_RESULT_SUCCESS; i$ < len$; i$ += FLP_GEOFENCE_MONITOR_STATUS_UNAVAILABLE) {
            Location location = arr$[i$];
            location.setProvider("fused");
            location.setElapsedRealtimeNanos(SystemClock.elapsedRealtimeNanos());
        }
        synchronized (this.mLocationSinkLock) {
            IFusedLocationHardwareSink sink = this.mLocationSink;
        }
        if (sink != null) {
            try {
                sink.onLocationAvailable(locations);
            } catch (RemoteException e) {
                Log.e(TAG, "RemoteException calling onLocationAvailable");
            }
        }
    }

    private void onDataReport(String data) {
        synchronized (this.mLocationSinkLock) {
            IFusedLocationHardwareSink sink = this.mLocationSink;
        }
        try {
            if (this.mLocationSink != null) {
                sink.onDiagnosticDataAvailable(data);
            }
        } catch (RemoteException e) {
            Log.e(TAG, "RemoteException calling onDiagnosticDataAvailable");
        }
    }

    private void onGeofenceTransition(int geofenceId, Location location, int transition, long timestamp, int sourcesUsed) {
        getGeofenceHardwareSink().reportGeofenceTransition(geofenceId, updateLocationInformation(location), transition, timestamp, FLP_GEOFENCE_MONITOR_STATUS_UNAVAILABLE, sourcesUsed);
    }

    private void onGeofenceMonitorStatus(int status, int source, Location location) {
        int monitorStatus;
        Location updatedLocation = null;
        if (location != null) {
            updatedLocation = updateLocationInformation(location);
        }
        switch (status) {
            case FLP_GEOFENCE_MONITOR_STATUS_UNAVAILABLE /*1*/:
                monitorStatus = FLP_GEOFENCE_MONITOR_STATUS_UNAVAILABLE;
                break;
            case FLP_GEOFENCE_MONITOR_STATUS_AVAILABLE /*2*/:
                monitorStatus = FLP_RESULT_SUCCESS;
                break;
            default:
                Log.e(TAG, "Invalid FlpHal Geofence monitor status: " + status);
                monitorStatus = FLP_GEOFENCE_MONITOR_STATUS_UNAVAILABLE;
                break;
        }
        getGeofenceHardwareSink().reportGeofenceMonitorStatus(FLP_GEOFENCE_MONITOR_STATUS_UNAVAILABLE, monitorStatus, updatedLocation, source);
    }

    private void onGeofenceAdd(int geofenceId, int result) {
        getGeofenceHardwareSink().reportGeofenceAddStatus(geofenceId, translateToGeofenceHardwareStatus(result));
    }

    private void onGeofenceRemove(int geofenceId, int result) {
        getGeofenceHardwareSink().reportGeofenceRemoveStatus(geofenceId, translateToGeofenceHardwareStatus(result));
    }

    private void onGeofencePause(int geofenceId, int result) {
        getGeofenceHardwareSink().reportGeofencePauseStatus(geofenceId, translateToGeofenceHardwareStatus(result));
    }

    private void onGeofenceResume(int geofenceId, int result) {
        getGeofenceHardwareSink().reportGeofenceResumeStatus(geofenceId, translateToGeofenceHardwareStatus(result));
    }

    public IFusedLocationHardware getLocationHardware() {
        return this.mLocationHardware;
    }

    public IFusedGeofenceHardware getGeofenceHardware() {
        return this.mGeofenceHardwareService;
    }

    private GeofenceHardwareImpl getGeofenceHardwareSink() {
        if (this.mGeofenceHardwareSink == null) {
            this.mGeofenceHardwareSink = GeofenceHardwareImpl.getInstance(this.mContext);
        }
        return this.mGeofenceHardwareSink;
    }

    private static int translateToGeofenceHardwareStatus(int flpHalResult) {
        switch (flpHalResult) {
            case FLP_RESULT_INVALID_GEOFENCE_TRANSITION /*-6*/:
                return 4;
            case FLP_RESULT_ID_UNKNOWN /*-5*/:
                return 3;
            case FLP_RESULT_ID_EXISTS /*-4*/:
                return FLP_GEOFENCE_MONITOR_STATUS_AVAILABLE;
            case FLP_RESULT_TOO_MANY_GEOFENCES /*-3*/:
                return FLP_GEOFENCE_MONITOR_STATUS_UNAVAILABLE;
            case FLP_RESULT_INSUFFICIENT_MEMORY /*-2*/:
                return 6;
            case FLP_RESULT_ERROR /*-1*/:
                return 5;
            case FLP_RESULT_SUCCESS /*0*/:
                return FLP_RESULT_SUCCESS;
            default:
                String str = TAG;
                Object[] objArr = new Object[FLP_GEOFENCE_MONITOR_STATUS_UNAVAILABLE];
                objArr[FLP_RESULT_SUCCESS] = Integer.valueOf(flpHalResult);
                Log.e(str, String.format("Invalid FlpHal result code: %d", objArr));
                return 5;
        }
    }

    private Location updateLocationInformation(Location location) {
        location.setProvider("fused");
        location.setElapsedRealtimeNanos(SystemClock.elapsedRealtimeNanos());
        return location;
    }
}
