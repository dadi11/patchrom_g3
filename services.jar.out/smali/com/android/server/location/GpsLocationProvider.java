package com.android.server.location;

import android.app.AlarmManager;
import android.app.AppOpsManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.IntentFilter.MalformedMimeTypeException;
import android.database.ContentObserver;
import android.database.Cursor;
import android.hardware.location.GeofenceHardwareImpl;
import android.location.FusedBatchOptions.SourceTechnologies;
import android.location.GpsMeasurementsEvent;
import android.location.GpsNavigationMessageEvent;
import android.location.IGpsGeofenceHardware;
import android.location.IGpsStatusListener;
import android.location.IGpsStatusProvider;
import android.location.IGpsStatusProvider.Stub;
import android.location.ILocationManager;
import android.location.INetInitiatedListener;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.location.LocationRequest;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Binder;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.os.UserHandle;
import android.os.WorkSource;
import android.provider.Settings.Global;
import android.provider.Settings.Secure;
import android.provider.Telephony.Carriers;
import android.provider.Telephony.Sms.Intents;
import android.telephony.SmsMessage;
import android.telephony.SubscriptionManager;
import android.telephony.SubscriptionManager.OnSubscriptionsChangedListener;
import android.telephony.TelephonyManager;
import android.telephony.gsm.GsmCellLocation;
import android.text.TextUtils;
import android.util.Log;
import android.util.NtpTrustedTime;
import com.android.internal.app.IAppOpsService;
import com.android.internal.app.IBatteryStats;
import com.android.internal.location.GpsNetInitiatedHandler;
import com.android.internal.location.GpsNetInitiatedHandler.GpsNiNotification;
import com.android.internal.location.ProviderProperties;
import com.android.internal.location.ProviderRequest;
import com.android.server.voiceinteraction.DatabaseHelper.SoundModelContract;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileDescriptor;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringReader;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Date;
import java.util.Map.Entry;
import java.util.Properties;
import libcore.io.IoUtils;

public class GpsLocationProvider implements LocationProviderInterface {
    private static final int ADD_LISTENER = 8;
    private static final int AGPS_DATA_CONNECTION_CLOSED = 0;
    private static final int AGPS_DATA_CONNECTION_OPEN = 2;
    private static final int AGPS_DATA_CONNECTION_OPENING = 1;
    private static final int AGPS_REF_LOCATION_TYPE_GSM_CELLID = 1;
    private static final int AGPS_REF_LOCATION_TYPE_UMTS_CELLID = 2;
    private static final int AGPS_REG_LOCATION_TYPE_MAC = 3;
    private static final int AGPS_RIL_REQUEST_REFLOC_CELLID = 1;
    private static final int AGPS_RIL_REQUEST_REFLOC_MAC = 2;
    private static final int AGPS_RIL_REQUEST_SETID_IMSI = 1;
    private static final int AGPS_RIL_REQUEST_SETID_MSISDN = 2;
    private static final int AGPS_SETID_TYPE_IMSI = 1;
    private static final int AGPS_SETID_TYPE_MSISDN = 2;
    private static final int AGPS_SETID_TYPE_NONE = 0;
    private static final int AGPS_SUPL_MODE_MSA = 2;
    private static final int AGPS_SUPL_MODE_MSB = 1;
    private static final int AGPS_TYPE_C2K = 2;
    private static final int AGPS_TYPE_SUPL = 1;
    private static final String ALARM_TIMEOUT = "com.android.internal.location.ALARM_TIMEOUT";
    private static final String ALARM_WAKEUP = "com.android.internal.location.ALARM_WAKEUP";
    private static final int ALMANAC_MASK = 1;
    private static final int APN_INVALID = 0;
    private static final int APN_IPV4 = 1;
    private static final int APN_IPV4V6 = 3;
    private static final int APN_IPV6 = 2;
    private static final String BATTERY_SAVER_GPS_MODE = "batterySaverGpsMode";
    private static final int BATTERY_SAVER_MODE_DISABLED_WHEN_SCREEN_OFF = 1;
    private static final int BATTERY_SAVER_MODE_NO_CHANGE = 0;
    private static final int BDS_DELETE_ALMANAC = 67108864;
    private static final int BDS_DELETE_ALMANAC_CORR = 16777216;
    private static final int BDS_DELETE_EPHEMERIS = 33554432;
    private static final int BDS_DELETE_SVDIR = 2097152;
    private static final int BDS_DELETE_SVSTEER = 4194304;
    private static final int BDS_DELETE_TIME = 8388608;
    private static final int CHECK_LOCATION = 1;
    private static final boolean DEBUG;
    private static final String DEFAULT_PROPERTIES_FILE = "/etc/gps.conf";
    private static final int DOWNLOAD_XTRA_DATA = 6;
    private static final int DOWNLOAD_XTRA_DATA_FINISHED = 11;
    private static final int ENABLE = 2;
    private static final int EPHEMERIS_MASK = 0;
    private static final int GET_DEFAULT_APN = 13;
    private static final int GLO_DELETE_ALMANAC = 32768;
    private static final int GLO_DELETE_ALMANAC_CORR = 262144;
    private static final int GLO_DELETE_EPHEMERIS = 16384;
    private static final int GLO_DELETE_SVDIR = 65536;
    private static final int GLO_DELETE_SVSTEER = 131072;
    private static final int GLO_DELETE_TIME = 1048576;
    private static final int GPS_AGPS_DATA_CONNECTED = 3;
    private static final int GPS_AGPS_DATA_CONN_DONE = 4;
    private static final int GPS_AGPS_DATA_CONN_FAILED = 5;
    private static final int GPS_CAPABILITY_GEOFENCING = 32;
    private static final int GPS_CAPABILITY_MEASUREMENTS = 64;
    private static final int GPS_CAPABILITY_MSA = 4;
    private static final int GPS_CAPABILITY_MSB = 2;
    private static final int GPS_CAPABILITY_NAV_MESSAGES = 128;
    private static final int GPS_CAPABILITY_ON_DEMAND_TIME = 16;
    private static final int GPS_CAPABILITY_SCHEDULING = 1;
    private static final int GPS_CAPABILITY_SINGLE_SHOT = 8;
    private static final int GPS_DELETE_ALL = -1;
    private static final int GPS_DELETE_ALMANAC = 2;
    private static final int GPS_DELETE_ALMANAC_CORR = 4096;
    private static final int GPS_DELETE_CELLDB_INFO = 2048;
    private static final int GPS_DELETE_EPHEMERIS = 1;
    private static final int GPS_DELETE_FREQ_BIAS_EST = 8192;
    private static final int GPS_DELETE_HEALTH = 64;
    private static final int GPS_DELETE_IONO = 16;
    private static final int GPS_DELETE_POSITION = 4;
    private static final int GPS_DELETE_RTI = 1024;
    private static final int GPS_DELETE_SADATA = 512;
    private static final int GPS_DELETE_SVDIR = 128;
    private static final int GPS_DELETE_SVSTEER = 256;
    private static final int GPS_DELETE_TIME = 8;
    private static final int GPS_DELETE_TIME_GPS = 524288;
    private static final int GPS_DELETE_UTC = 32;
    private static final int GPS_GEOFENCE_AVAILABLE = 2;
    private static final int GPS_GEOFENCE_ERROR_GENERIC = -149;
    private static final int GPS_GEOFENCE_ERROR_ID_EXISTS = -101;
    private static final int GPS_GEOFENCE_ERROR_ID_UNKNOWN = -102;
    private static final int GPS_GEOFENCE_ERROR_INVALID_TRANSITION = -103;
    private static final int GPS_GEOFENCE_ERROR_TOO_MANY_GEOFENCES = 100;
    private static final int GPS_GEOFENCE_OPERATION_SUCCESS = 0;
    private static final int GPS_GEOFENCE_UNAVAILABLE = 1;
    private static final int GPS_POLLING_THRESHOLD_INTERVAL = 10000;
    private static final int GPS_POSITION_MODE_MS_ASSISTED = 2;
    private static final int GPS_POSITION_MODE_MS_BASED = 1;
    private static final int GPS_POSITION_MODE_STANDALONE = 0;
    private static final int GPS_POSITION_RECURRENCE_PERIODIC = 0;
    private static final int GPS_POSITION_RECURRENCE_SINGLE = 1;
    private static final int GPS_RELEASE_AGPS_DATA_CONN = 2;
    private static final int GPS_REQUEST_AGPS_DATA_CONN = 1;
    private static final int GPS_STATUS_ENGINE_OFF = 4;
    private static final int GPS_STATUS_ENGINE_ON = 3;
    private static final int GPS_STATUS_NONE = 0;
    private static final int GPS_STATUS_SESSION_BEGIN = 1;
    private static final int GPS_STATUS_SESSION_END = 2;
    private static final int INJECT_NTP_TIME = 5;
    private static final int INJECT_NTP_TIME_FINISHED = 10;
    private static final int LOCATION_HAS_ACCURACY = 16;
    private static final int LOCATION_HAS_ALTITUDE = 2;
    private static final int LOCATION_HAS_BEARING = 8;
    private static final int LOCATION_HAS_LAT_LONG = 1;
    private static final int LOCATION_HAS_SPEED = 4;
    private static final int LOCATION_INVALID = 0;
    private static final int MAX_SVS = 32;
    private static final int NO_FIX_TIMEOUT = 60000;
    private static final long NTP_INTERVAL = 86400000;
    private static final ProviderProperties PROPERTIES;
    private static final String PROPERTIES_FILE_PREFIX = "/etc/gps";
    private static final String PROPERTIES_FILE_SUFFIX = ".conf";
    private static final long RECENT_FIX_TIMEOUT = 10000;
    private static final int REMOVE_LISTENER = 9;
    private static final long RETRY_INTERVAL = 300000;
    private static final int SET_REQUEST = 3;
    private static final String SIM_STATE_CHANGED = "android.intent.action.SIM_STATE_CHANGED";
    private static final int STATE_DOWNLOADING = 1;
    private static final int STATE_IDLE = 2;
    private static final int STATE_PENDING_NETWORK = 0;
    private static final String TAG = "GpsLocationProvider";
    private static final int TCP_MAX_PORT = 65535;
    private static final int TCP_MIN_PORT = 0;
    private static final int UPDATE_LOCATION = 7;
    private static final int UPDATE_NETWORK_STATE = 4;
    private static final int USED_FOR_FIX_MASK = 2;
    private static final boolean VERBOSE;
    private static final String WAKELOCK_KEY = "GpsLocationProvider";
    private String mAGpsApn;
    private InetAddress mAGpsDataConnectionIpAddr;
    private int mAGpsDataConnectionState;
    private final AlarmManager mAlarmManager;
    private int mApnIpType;
    private final IAppOpsService mAppOpsService;
    private final IBatteryStats mBatteryStats;
    private final BroadcastReceiver mBroadcastReceiver;
    private String mC2KServerHost;
    private int mC2KServerPort;
    private WorkSource mClientSource;
    private final ConnectivityManager mConnMgr;
    private final Context mContext;
    private String mDefaultApn;
    ContentObserver mDefaultApnObserver;
    private boolean mDisableGps;
    private int mDownloadXtraDataPending;
    private boolean mEnabled;
    private int mEngineCapabilities;
    private boolean mEngineOn;
    private int mFixInterval;
    private long mFixRequestTime;
    private GeofenceHardwareImpl mGeofenceHardwareImpl;
    private IGpsGeofenceHardware mGpsGeofenceBinder;
    private final GpsMeasurementsProvider mGpsMeasurementsProvider;
    private final GpsNavigationMessageProvider mGpsNavigationMessageProvider;
    private final IGpsStatusProvider mGpsStatusProvider;
    private Handler mHandler;
    private final ILocationManager mILocationManager;
    private int mInjectNtpTimePending;
    private long mLastFixTime;
    private final GpsStatusListenerHelper mListenerHelper;
    private Location mLocation;
    private Bundle mLocationExtras;
    private int mLocationFlags;
    private Object mLock;
    private final GpsNetInitiatedHandler mNIHandler;
    private boolean mNavigating;
    private final INetInitiatedListener mNetInitiatedListener;
    private boolean mNetworkAvailable;
    private byte[] mNmeaBuffer;
    private final NtpTrustedTime mNtpTime;
    private final OnSubscriptionsChangedListener mOnSubscriptionsChangedListener;
    private boolean mPeriodicTimeInjection;
    private int mPositionMode;
    private final PowerManager mPowerManager;
    private Properties mProperties;
    private ProviderRequest mProviderRequest;
    private boolean mSingleShot;
    private float[] mSnrs;
    private boolean mStarted;
    private int mStatus;
    private long mStatusUpdateTime;
    private boolean mSuplEsEnabled;
    private String mSuplServerHost;
    private int mSuplServerPort;
    private boolean mSupportsXtra;
    private float[] mSvAzimuths;
    private int mSvCount;
    private float[] mSvElevations;
    private int[] mSvMasks;
    private int[] mSvs;
    private int mTimeToFirstFix;
    private final PendingIntent mTimeoutIntent;
    private final WakeLock mWakeLock;
    private final PendingIntent mWakeupIntent;
    private WorkSource mWorkSource;

    /* renamed from: com.android.server.location.GpsLocationProvider.12 */
    class AnonymousClass12 extends ContentObserver {
        AnonymousClass12(Handler x0) {
            super(x0);
        }

        public void onChange(boolean selfChange) {
            GpsLocationProvider.this.sendMessage(GpsLocationProvider.GET_DEFAULT_APN, GpsLocationProvider.TCP_MIN_PORT, null);
        }
    }

    /* renamed from: com.android.server.location.GpsLocationProvider.1 */
    class C03511 extends Stub {
        C03511() {
        }

        public void addGpsStatusListener(IGpsStatusListener listener) throws RemoteException {
            GpsLocationProvider.this.mListenerHelper.addListener(listener);
        }

        public void removeGpsStatusListener(IGpsStatusListener listener) {
            GpsLocationProvider.this.mListenerHelper.removeListener(listener);
        }
    }

    /* renamed from: com.android.server.location.GpsLocationProvider.2 */
    class C03522 extends BroadcastReceiver {
        C03522() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if (GpsLocationProvider.DEBUG) {
                Log.d(GpsLocationProvider.WAKELOCK_KEY, "receive broadcast intent, action: " + action);
            }
            if (action.equals(GpsLocationProvider.ALARM_WAKEUP)) {
                GpsLocationProvider.this.startNavigating(GpsLocationProvider.VERBOSE);
            } else if (action.equals(GpsLocationProvider.ALARM_TIMEOUT)) {
                GpsLocationProvider.this.hibernate();
            } else if (action.equals("android.intent.action.DATA_SMS_RECEIVED")) {
                GpsLocationProvider.this.checkSmsSuplInit(intent);
            } else if (action.equals("android.provider.Telephony.WAP_PUSH_RECEIVED")) {
                GpsLocationProvider.this.checkWapSuplInit(intent);
            } else if (action.equals("android.net.conn.CONNECTIVITY_CHANGE_IMMEDIATE")) {
                int networkState;
                NetworkInfo info = ((ConnectivityManager) GpsLocationProvider.this.mContext.getSystemService("connectivity")).getNetworkInfo(((NetworkInfo) intent.getParcelableExtra("networkInfo")).getType());
                if (intent.getBooleanExtra("noConnectivity", GpsLocationProvider.VERBOSE) || !info.isConnected()) {
                    networkState = GpsLocationProvider.STATE_DOWNLOADING;
                } else {
                    networkState = GpsLocationProvider.USED_FOR_FIX_MASK;
                }
                GpsLocationProvider.this.updateNetworkState(networkState, info);
            } else if ("android.os.action.POWER_SAVE_MODE_CHANGED".equals(action) || "android.intent.action.SCREEN_OFF".equals(action) || "android.intent.action.SCREEN_ON".equals(action)) {
                GpsLocationProvider.this.updateLowPowerMode();
            } else if (action.equals(GpsLocationProvider.SIM_STATE_CHANGED)) {
                GpsLocationProvider.this.subscriptionOrSimChanged(context);
            }
        }
    }

    /* renamed from: com.android.server.location.GpsLocationProvider.3 */
    class C03533 extends OnSubscriptionsChangedListener {
        C03533() {
        }

        public void onSubscriptionsChanged() {
            GpsLocationProvider.this.subscriptionOrSimChanged(GpsLocationProvider.this.mContext);
        }
    }

    /* renamed from: com.android.server.location.GpsLocationProvider.4 */
    class C03544 implements Runnable {
        C03544() {
        }

        public void run() {
            LocationManager locManager = (LocationManager) GpsLocationProvider.this.mContext.getSystemService("location");
            LocationRequest request = LocationRequest.createFromDeprecatedProvider("passive", 0, 0.0f, GpsLocationProvider.VERBOSE);
            request.setHideFromAppOps(true);
            locManager.requestLocationUpdates(request, new NetworkLocationListener(null), GpsLocationProvider.this.mHandler.getLooper());
        }
    }

    /* renamed from: com.android.server.location.GpsLocationProvider.5 */
    class C03555 extends GpsStatusListenerHelper {
        C03555(Handler x0) {
            super(x0);
        }

        protected boolean isAvailableInPlatform() {
            return GpsLocationProvider.isSupported();
        }

        protected boolean isGpsEnabled() {
            return GpsLocationProvider.this.isEnabled();
        }
    }

    /* renamed from: com.android.server.location.GpsLocationProvider.6 */
    class C03566 extends GpsMeasurementsProvider {
        C03566(Handler x0) {
            super(x0);
        }

        public boolean isAvailableInPlatform() {
            return GpsLocationProvider.native_is_measurement_supported();
        }

        protected boolean registerWithService() {
            return GpsLocationProvider.this.native_start_measurement_collection();
        }

        protected void unregisterFromService() {
            GpsLocationProvider.this.native_stop_measurement_collection();
        }

        protected boolean isGpsEnabled() {
            return GpsLocationProvider.this.isEnabled();
        }
    }

    /* renamed from: com.android.server.location.GpsLocationProvider.7 */
    class C03577 extends GpsNavigationMessageProvider {
        C03577(Handler x0) {
            super(x0);
        }

        protected boolean isAvailableInPlatform() {
            return GpsLocationProvider.native_is_navigation_message_supported();
        }

        protected boolean registerWithService() {
            return GpsLocationProvider.this.native_start_navigation_message_collection();
        }

        protected void unregisterFromService() {
            GpsLocationProvider.this.native_stop_navigation_message_collection();
        }

        protected boolean isGpsEnabled() {
            return GpsLocationProvider.this.isEnabled();
        }
    }

    /* renamed from: com.android.server.location.GpsLocationProvider.8 */
    class C03588 implements Runnable {
        C03588() {
        }

        public void run() {
            long delay;
            if (GpsLocationProvider.this.mNtpTime.getCacheAge() >= GpsLocationProvider.NTP_INTERVAL) {
                GpsLocationProvider.this.mNtpTime.forceRefresh();
            }
            if (GpsLocationProvider.this.mNtpTime.getCacheAge() < GpsLocationProvider.NTP_INTERVAL) {
                long time = GpsLocationProvider.this.mNtpTime.getCachedNtpTime();
                long timeReference = GpsLocationProvider.this.mNtpTime.getCachedNtpTimeReference();
                long certainty = GpsLocationProvider.this.mNtpTime.getCacheCertainty();
                Log.d(GpsLocationProvider.WAKELOCK_KEY, "NTP server returned: " + time + " (" + new Date(time) + ") reference: " + timeReference + " certainty: " + certainty + " system time offset: " + (time - System.currentTimeMillis()));
                GpsLocationProvider.this.native_inject_time(time, timeReference, (int) certainty);
                delay = GpsLocationProvider.NTP_INTERVAL;
            } else {
                if (GpsLocationProvider.DEBUG) {
                    Log.d(GpsLocationProvider.WAKELOCK_KEY, "requestTime failed");
                }
                delay = GpsLocationProvider.RETRY_INTERVAL;
            }
            GpsLocationProvider.this.sendMessage(GpsLocationProvider.INJECT_NTP_TIME_FINISHED, GpsLocationProvider.TCP_MIN_PORT, null);
            if (GpsLocationProvider.this.mPeriodicTimeInjection) {
                GpsLocationProvider.this.mHandler.sendEmptyMessageDelayed(GpsLocationProvider.INJECT_NTP_TIME, delay);
            }
            GpsLocationProvider.this.mWakeLock.release();
        }
    }

    /* renamed from: com.android.server.location.GpsLocationProvider.9 */
    class C03599 implements Runnable {
        C03599() {
        }

        public void run() {
            byte[] data = new GpsXtraDownloader(GpsLocationProvider.this.mContext, GpsLocationProvider.this.mProperties).downloadXtraData();
            if (data != null) {
                if (GpsLocationProvider.DEBUG) {
                    Log.d(GpsLocationProvider.WAKELOCK_KEY, "calling native_inject_xtra_data");
                }
                GpsLocationProvider.this.native_inject_xtra_data(data, data.length);
            }
            GpsLocationProvider.this.sendMessage(GpsLocationProvider.DOWNLOAD_XTRA_DATA_FINISHED, GpsLocationProvider.TCP_MIN_PORT, null);
            if (data == null) {
                GpsLocationProvider.this.mHandler.sendEmptyMessageDelayed(GpsLocationProvider.DOWNLOAD_XTRA_DATA, GpsLocationProvider.RETRY_INTERVAL);
            }
            GpsLocationProvider.this.mWakeLock.release();
        }
    }

    private static class GpsRequest {
        public ProviderRequest request;
        public WorkSource source;

        public GpsRequest(ProviderRequest request, WorkSource source) {
            this.request = request;
            this.source = source;
        }
    }

    private final class NetworkLocationListener implements LocationListener {
        private NetworkLocationListener() {
        }

        public void onLocationChanged(Location location) {
            if ("network".equals(location.getProvider())) {
                GpsLocationProvider.this.handleUpdateLocation(location);
            }
        }

        public void onStatusChanged(String provider, int status, Bundle extras) {
        }

        public void onProviderEnabled(String provider) {
        }

        public void onProviderDisabled(String provider) {
        }
    }

    private final class ProviderHandler extends Handler {
        public ProviderHandler(Looper looper) {
            super(looper, null, true);
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case GpsLocationProvider.USED_FOR_FIX_MASK /*2*/:
                    if (msg.arg1 != GpsLocationProvider.STATE_DOWNLOADING) {
                        GpsLocationProvider.this.handleDisable();
                        break;
                    } else {
                        GpsLocationProvider.this.handleEnable();
                        break;
                    }
                case GpsLocationProvider.SET_REQUEST /*3*/:
                    GpsRequest gpsRequest = msg.obj;
                    GpsLocationProvider.this.handleSetRequest(gpsRequest.request, gpsRequest.source);
                    break;
                case GpsLocationProvider.UPDATE_NETWORK_STATE /*4*/:
                    GpsLocationProvider.this.handleUpdateNetworkState(msg.arg1, (NetworkInfo) msg.obj);
                    break;
                case GpsLocationProvider.INJECT_NTP_TIME /*5*/:
                    GpsLocationProvider.this.handleInjectNtpTime();
                    break;
                case GpsLocationProvider.DOWNLOAD_XTRA_DATA /*6*/:
                    if (GpsLocationProvider.this.mSupportsXtra) {
                        GpsLocationProvider.this.handleDownloadXtraData();
                        break;
                    }
                    break;
                case GpsLocationProvider.UPDATE_LOCATION /*7*/:
                    GpsLocationProvider.this.handleUpdateLocation((Location) msg.obj);
                    break;
                case GpsLocationProvider.INJECT_NTP_TIME_FINISHED /*10*/:
                    GpsLocationProvider.this.mInjectNtpTimePending = GpsLocationProvider.USED_FOR_FIX_MASK;
                    break;
                case GpsLocationProvider.DOWNLOAD_XTRA_DATA_FINISHED /*11*/:
                    GpsLocationProvider.this.mDownloadXtraDataPending = GpsLocationProvider.USED_FOR_FIX_MASK;
                    break;
                case GpsLocationProvider.GET_DEFAULT_APN /*13*/:
                    GpsLocationProvider.this.mDefaultApn = GpsLocationProvider.this.getDefaultApn();
                    if (GpsLocationProvider.DEBUG) {
                        Log.d(GpsLocationProvider.WAKELOCK_KEY, "Observer mDefaultApn=" + GpsLocationProvider.this.mDefaultApn);
                        break;
                    }
                    break;
            }
            if (msg.arg2 == GpsLocationProvider.STATE_DOWNLOADING) {
                GpsLocationProvider.this.mWakeLock.release();
            }
        }
    }

    private static native void class_init_native();

    private static native boolean native_add_geofence(int i, double d, double d2, double d3, int i2, int i3, int i4, int i5);

    private native void native_agps_data_conn_closed();

    private native void native_agps_data_conn_failed();

    private native void native_agps_data_conn_open(String str, int i);

    private native void native_agps_ni_message(byte[] bArr, int i);

    private native void native_agps_set_id(int i, String str);

    private native void native_agps_set_ref_location_cellid(int i, int i2, int i3, int i4, int i5);

    private native void native_cleanup();

    private static native void native_configuration_update(String str);

    private native void native_delete_aiding_data(int i);

    private native String native_get_internal_state();

    private native boolean native_init();

    private native void native_inject_location(double d, double d2, float f);

    private native void native_inject_time(long j, long j2, int i);

    private native void native_inject_xtra_data(byte[] bArr, int i);

    private static native boolean native_is_geofence_supported();

    private static native boolean native_is_measurement_supported();

    private static native boolean native_is_navigation_message_supported();

    private static native boolean native_is_supported();

    private static native boolean native_pause_geofence(int i);

    private native int native_read_nmea(byte[] bArr, int i);

    private native int native_read_sv_status(int[] iArr, float[] fArr, float[] fArr2, float[] fArr3, int[] iArr2);

    private static native boolean native_remove_geofence(int i);

    private static native boolean native_resume_geofence(int i, int i2);

    private native void native_send_ni_response(int i, int i2);

    private native void native_set_agps_server(int i, String str, int i2);

    private native boolean native_set_position_mode(int i, int i2, int i3, int i4, int i5);

    private native boolean native_start();

    private native boolean native_start_measurement_collection();

    private native boolean native_start_navigation_message_collection();

    private native boolean native_stop();

    private native boolean native_stop_measurement_collection();

    private native boolean native_stop_navigation_message_collection();

    private native boolean native_supports_xtra();

    private native void native_update_network_state(boolean z, int i, boolean z2, boolean z3, String str, String str2);

    static {
        DEBUG = Log.isLoggable(WAKELOCK_KEY, SET_REQUEST);
        VERBOSE = Log.isLoggable(WAKELOCK_KEY, USED_FOR_FIX_MASK);
        PROPERTIES = new ProviderProperties(true, true, VERBOSE, VERBOSE, true, true, true, SET_REQUEST, STATE_DOWNLOADING);
        class_init_native();
    }

    public IGpsStatusProvider getGpsStatusProvider() {
        return this.mGpsStatusProvider;
    }

    public IGpsGeofenceHardware getGpsGeofenceProxy() {
        return this.mGpsGeofenceBinder;
    }

    public GpsMeasurementsProvider getGpsMeasurementsProvider() {
        return this.mGpsMeasurementsProvider;
    }

    public GpsNavigationMessageProvider getGpsNavigationMessageProvider() {
        return this.mGpsNavigationMessageProvider;
    }

    private void subscriptionOrSimChanged(Context context) {
        Log.d(WAKELOCK_KEY, "received SIM realted action: ");
        String mccMnc = ((TelephonyManager) this.mContext.getSystemService("phone")).getSimOperator();
        if (TextUtils.isEmpty(mccMnc)) {
            Log.d(WAKELOCK_KEY, "SIM MCC/MNC is still not available");
            return;
        }
        Log.d(WAKELOCK_KEY, "SIM MCC/MNC is available: " + mccMnc);
        synchronized (this.mLock) {
            reloadGpsProperties(context, this.mProperties);
            this.mNIHandler.setSuplEsEnabled(this.mSuplEsEnabled);
        }
    }

    private void checkSmsSuplInit(Intent intent) {
        SmsMessage[] messages = Intents.getMessagesFromIntent(intent);
        for (int i = TCP_MIN_PORT; i < messages.length; i += STATE_DOWNLOADING) {
            byte[] supl_init = messages[i].getUserData();
            native_agps_ni_message(supl_init, supl_init.length);
        }
    }

    private void checkWapSuplInit(Intent intent) {
        byte[] supl_init = (byte[]) intent.getExtra(SoundModelContract.KEY_DATA);
        native_agps_ni_message(supl_init, supl_init.length);
    }

    private void updateLowPowerMode() {
        boolean disableGps = true;
        switch (Secure.getInt(this.mContext.getContentResolver(), BATTERY_SAVER_GPS_MODE, STATE_DOWNLOADING)) {
            case STATE_DOWNLOADING /*1*/:
                if (!this.mPowerManager.isPowerSaveMode() || this.mPowerManager.isInteractive()) {
                    disableGps = VERBOSE;
                }
                break;
            default:
                disableGps = VERBOSE;
                break;
        }
        if (disableGps != this.mDisableGps) {
            this.mDisableGps = disableGps;
            updateRequirements();
        }
    }

    public static boolean isSupported() {
        return native_is_supported();
    }

    private void reloadGpsProperties(Context context, Properties properties) {
        boolean z = true;
        Log.d(WAKELOCK_KEY, "Reset GPS properties, previous size = " + properties.size());
        loadPropertiesFromResource(context, properties);
        boolean isPropertiesLoadedFromFile = VERBOSE;
        String gpsHardware = SystemProperties.get("ro.hardware.gps");
        if (!TextUtils.isEmpty(gpsHardware)) {
            isPropertiesLoadedFromFile = loadPropertiesFromFile("/etc/gps." + gpsHardware + PROPERTIES_FILE_SUFFIX, properties);
        }
        if (!isPropertiesLoadedFromFile) {
            loadPropertiesFromFile(DEFAULT_PROPERTIES_FILE, properties);
        }
        Log.d(WAKELOCK_KEY, "GPS properties reloaded, size = " + properties.size());
        setSuplHostPort(properties.getProperty("SUPL_HOST"), properties.getProperty("SUPL_PORT"));
        this.mC2KServerHost = properties.getProperty("C2K_HOST");
        String portString = properties.getProperty("C2K_PORT");
        if (!(this.mC2KServerHost == null || portString == null)) {
            try {
                this.mC2KServerPort = Integer.parseInt(portString);
            } catch (NumberFormatException e) {
                Log.e(WAKELOCK_KEY, "unable to parse C2K_PORT: " + portString);
            }
        }
        try {
            ByteArrayOutputStream baos = new ByteArrayOutputStream(GPS_DELETE_ALMANAC_CORR);
            properties.store(baos, null);
            native_configuration_update(baos.toString());
            Log.d(WAKELOCK_KEY, "final config = " + baos.toString());
        } catch (IOException e2) {
            Log.w(WAKELOCK_KEY, "failed to dump properties contents");
        }
        String suplESProperty = this.mProperties.getProperty("SUPL_ES");
        if (suplESProperty != null) {
            try {
                if (Integer.parseInt(suplESProperty) != STATE_DOWNLOADING) {
                    z = VERBOSE;
                }
                this.mSuplEsEnabled = z;
            } catch (NumberFormatException e3) {
                Log.e(WAKELOCK_KEY, "unable to parse SUPL_ES: " + suplESProperty);
            }
        }
    }

    private void loadPropertiesFromResource(Context context, Properties properties) {
        String[] arr$ = context.getResources().getStringArray(17236027);
        int len$ = arr$.length;
        for (int i$ = TCP_MIN_PORT; i$ < len$; i$ += STATE_DOWNLOADING) {
            String item = arr$[i$];
            Log.d(WAKELOCK_KEY, "GpsParamsResource: " + item);
            String[] split = item.split("=");
            if (split.length == USED_FOR_FIX_MASK) {
                properties.setProperty(split[TCP_MIN_PORT].trim().toUpperCase(), split[STATE_DOWNLOADING]);
            } else {
                Log.w(WAKELOCK_KEY, "malformed contents: " + item);
            }
        }
    }

    private boolean loadPropertiesFromFile(String filename, Properties properties) {
        Throwable th;
        try {
            FileInputStream stream = null;
            try {
                FileInputStream stream2 = new FileInputStream(new File(filename));
                try {
                    properties.load(stream2);
                    IoUtils.closeQuietly(stream2);
                    return true;
                } catch (Throwable th2) {
                    th = th2;
                    stream = stream2;
                    IoUtils.closeQuietly(stream);
                    throw th;
                }
            } catch (Throwable th3) {
                th = th3;
                IoUtils.closeQuietly(stream);
                throw th;
            }
        } catch (IOException e) {
            Log.w(WAKELOCK_KEY, "Could not open GPS configuration file " + filename);
            return VERBOSE;
        }
    }

    public GpsLocationProvider(Context context, ILocationManager ilocationManager, Looper looper) {
        this.mLock = new Object();
        this.mLocationFlags = TCP_MIN_PORT;
        this.mStatus = STATE_DOWNLOADING;
        this.mStatusUpdateTime = SystemClock.elapsedRealtime();
        this.mInjectNtpTimePending = TCP_MIN_PORT;
        this.mDownloadXtraDataPending = TCP_MIN_PORT;
        this.mFixInterval = ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE;
        this.mFixRequestTime = 0;
        this.mTimeToFirstFix = TCP_MIN_PORT;
        this.mProviderRequest = null;
        this.mWorkSource = null;
        this.mDisableGps = VERBOSE;
        this.mSuplServerPort = TCP_MIN_PORT;
        this.mSuplEsEnabled = VERBOSE;
        this.mLocation = new Location("gps");
        this.mLocationExtras = new Bundle();
        this.mClientSource = new WorkSource();
        this.mGpsStatusProvider = new C03511();
        this.mBroadcastReceiver = new C03522();
        this.mOnSubscriptionsChangedListener = new C03533();
        this.mGpsGeofenceBinder = new IGpsGeofenceHardware.Stub() {
            public boolean isHardwareGeofenceSupported() {
                return GpsLocationProvider.native_is_geofence_supported();
            }

            public boolean addCircularHardwareGeofence(int geofenceId, double latitude, double longitude, double radius, int lastTransition, int monitorTransitions, int notificationResponsiveness, int unknownTimer) {
                return GpsLocationProvider.native_add_geofence(geofenceId, latitude, longitude, radius, lastTransition, monitorTransitions, notificationResponsiveness, unknownTimer);
            }

            public boolean removeHardwareGeofence(int geofenceId) {
                return GpsLocationProvider.native_remove_geofence(geofenceId);
            }

            public boolean pauseHardwareGeofence(int geofenceId) {
                return GpsLocationProvider.native_pause_geofence(geofenceId);
            }

            public boolean resumeHardwareGeofence(int geofenceId, int monitorTransition) {
                return GpsLocationProvider.native_resume_geofence(geofenceId, monitorTransition);
            }
        };
        this.mNetInitiatedListener = new INetInitiatedListener.Stub() {
            public boolean sendNiResponse(int notificationId, int userResponse) {
                if (GpsLocationProvider.DEBUG) {
                    Log.d(GpsLocationProvider.WAKELOCK_KEY, "sendNiResponse, notifId: " + notificationId + ", response: " + userResponse);
                }
                GpsLocationProvider.this.native_send_ni_response(notificationId, userResponse);
                return true;
            }
        };
        this.mDefaultApnObserver = new AnonymousClass12(this.mHandler);
        this.mSvs = new int[MAX_SVS];
        this.mSnrs = new float[MAX_SVS];
        this.mSvElevations = new float[MAX_SVS];
        this.mSvAzimuths = new float[MAX_SVS];
        this.mSvMasks = new int[SET_REQUEST];
        this.mNmeaBuffer = new byte[120];
        this.mContext = context;
        this.mNtpTime = NtpTrustedTime.getInstance(context);
        this.mILocationManager = ilocationManager;
        this.mLocation.setExtras(this.mLocationExtras);
        this.mPowerManager = (PowerManager) this.mContext.getSystemService("power");
        this.mWakeLock = this.mPowerManager.newWakeLock(STATE_DOWNLOADING, WAKELOCK_KEY);
        this.mWakeLock.setReferenceCounted(true);
        this.mAlarmManager = (AlarmManager) this.mContext.getSystemService("alarm");
        this.mWakeupIntent = PendingIntent.getBroadcast(this.mContext, TCP_MIN_PORT, new Intent(ALARM_WAKEUP), TCP_MIN_PORT);
        this.mTimeoutIntent = PendingIntent.getBroadcast(this.mContext, TCP_MIN_PORT, new Intent(ALARM_TIMEOUT), TCP_MIN_PORT);
        this.mConnMgr = (ConnectivityManager) context.getSystemService("connectivity");
        this.mAppOpsService = IAppOpsService.Stub.asInterface(ServiceManager.getService("appops"));
        this.mBatteryStats = IBatteryStats.Stub.asInterface(ServiceManager.getService("batterystats"));
        this.mProperties = new Properties();
        reloadGpsProperties(this.mContext, this.mProperties);
        this.mNIHandler = new GpsNetInitiatedHandler(context, this.mNetInitiatedListener, this.mSuplEsEnabled);
        SubscriptionManager.from(this.mContext).addOnSubscriptionsChangedListener(this.mOnSubscriptionsChangedListener);
        this.mHandler = new ProviderHandler(looper);
        listenForBroadcasts();
        this.mHandler.post(new C03544());
        this.mListenerHelper = new C03555(this.mHandler);
        this.mGpsMeasurementsProvider = new C03566(this.mHandler);
        this.mGpsNavigationMessageProvider = new C03577(this.mHandler);
    }

    private void listenForBroadcasts() {
        IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction("android.intent.action.DATA_SMS_RECEIVED");
        intentFilter.addDataScheme("sms");
        intentFilter.addDataAuthority("localhost", "7275");
        this.mContext.registerReceiver(this.mBroadcastReceiver, intentFilter, null, this.mHandler);
        intentFilter = new IntentFilter();
        intentFilter.addAction("android.provider.Telephony.WAP_PUSH_RECEIVED");
        try {
            intentFilter.addDataType("application/vnd.omaloc-supl-init");
        } catch (MalformedMimeTypeException e) {
            Log.w(WAKELOCK_KEY, "Malformed SUPL init mime type");
        }
        this.mContext.registerReceiver(this.mBroadcastReceiver, intentFilter, null, this.mHandler);
        intentFilter = new IntentFilter();
        intentFilter.addAction(ALARM_WAKEUP);
        intentFilter.addAction(ALARM_TIMEOUT);
        intentFilter.addAction("android.net.conn.CONNECTIVITY_CHANGE_IMMEDIATE");
        intentFilter.addAction("android.os.action.POWER_SAVE_MODE_CHANGED");
        intentFilter.addAction("android.intent.action.SCREEN_OFF");
        intentFilter.addAction("android.intent.action.SCREEN_ON");
        intentFilter.addAction(SIM_STATE_CHANGED);
        this.mContext.registerReceiver(this.mBroadcastReceiver, intentFilter, null, this.mHandler);
        this.mContext.getContentResolver().registerContentObserver(Uri.parse("content://telephony/carriers/preferapn"), VERBOSE, this.mDefaultApnObserver);
    }

    public String getName() {
        return "gps";
    }

    public ProviderProperties getProperties() {
        return PROPERTIES;
    }

    public void updateNetworkState(int state, NetworkInfo info) {
        sendMessage(UPDATE_NETWORK_STATE, state, info);
    }

    private void handleUpdateNetworkState(int state, NetworkInfo info) {
        this.mNetworkAvailable = state == USED_FOR_FIX_MASK ? true : VERBOSE;
        if (DEBUG) {
            Log.d(WAKELOCK_KEY, "updateNetworkState " + (this.mNetworkAvailable ? "available" : "unavailable") + " info: " + info);
        }
        if (info != null) {
            boolean networkAvailable = (info.isAvailable() && TelephonyManager.getDefault().getDataEnabled()) ? true : VERBOSE;
            if (this.mDefaultApn == null) {
                this.mDefaultApn = getDefaultApn();
            }
            native_update_network_state(info.isConnected(), info.getType(), info.isRoaming(), networkAvailable, info.getExtraInfo(), this.mDefaultApn);
        }
        if (info != null && info.getType() == SET_REQUEST && this.mAGpsDataConnectionState == STATE_DOWNLOADING) {
            if (this.mNetworkAvailable) {
                String apnName = info.getExtraInfo();
                if (apnName == null) {
                    apnName = "dummy-apn";
                }
                this.mAGpsApn = apnName;
                this.mApnIpType = getApnIpType(apnName);
                setRouting();
                if (DEBUG) {
                    Object[] objArr = new Object[USED_FOR_FIX_MASK];
                    objArr[TCP_MIN_PORT] = this.mAGpsApn;
                    objArr[STATE_DOWNLOADING] = Integer.valueOf(this.mApnIpType);
                    Log.d(WAKELOCK_KEY, String.format("native_agps_data_conn_open: mAgpsApn=%s, mApnIpType=%s", objArr));
                }
                native_agps_data_conn_open(this.mAGpsApn, this.mApnIpType);
                this.mAGpsDataConnectionState = USED_FOR_FIX_MASK;
            } else {
                Log.e(WAKELOCK_KEY, "call native_agps_data_conn_failed, info: " + info);
                this.mAGpsApn = null;
                this.mApnIpType = TCP_MIN_PORT;
                this.mAGpsDataConnectionState = TCP_MIN_PORT;
                native_agps_data_conn_failed();
            }
        }
        if (this.mNetworkAvailable) {
            if (this.mInjectNtpTimePending == 0) {
                sendMessage(INJECT_NTP_TIME, TCP_MIN_PORT, null);
            }
            if (this.mDownloadXtraDataPending == 0) {
                sendMessage(DOWNLOAD_XTRA_DATA, TCP_MIN_PORT, null);
            }
        }
    }

    private void handleInjectNtpTime() {
        if (this.mInjectNtpTimePending != STATE_DOWNLOADING) {
            if (this.mNetworkAvailable) {
                this.mInjectNtpTimePending = STATE_DOWNLOADING;
                this.mWakeLock.acquire();
                AsyncTask.THREAD_POOL_EXECUTOR.execute(new C03588());
                return;
            }
            this.mInjectNtpTimePending = TCP_MIN_PORT;
        }
    }

    private void handleDownloadXtraData() {
        if (this.mDownloadXtraDataPending != STATE_DOWNLOADING) {
            if (this.mNetworkAvailable) {
                this.mDownloadXtraDataPending = STATE_DOWNLOADING;
                this.mWakeLock.acquire();
                AsyncTask.THREAD_POOL_EXECUTOR.execute(new C03599());
                return;
            }
            this.mDownloadXtraDataPending = TCP_MIN_PORT;
        }
    }

    private void handleUpdateLocation(Location location) {
        if (location.hasAccuracy()) {
            native_inject_location(location.getLatitude(), location.getLongitude(), location.getAccuracy());
        }
    }

    public void enable() {
        synchronized (this.mLock) {
            if (this.mEnabled) {
                return;
            }
            this.mEnabled = true;
            sendMessage(USED_FOR_FIX_MASK, STATE_DOWNLOADING, null);
        }
    }

    private void setSuplHostPort(String hostString, String portString) {
        if (hostString != null) {
            this.mSuplServerHost = hostString;
        }
        if (portString != null) {
            try {
                this.mSuplServerPort = Integer.parseInt(portString);
            } catch (NumberFormatException e) {
                Log.e(WAKELOCK_KEY, "unable to parse SUPL_PORT: " + portString);
            }
        }
        if (this.mSuplServerHost != null && this.mSuplServerPort > 0 && this.mSuplServerPort <= TCP_MAX_PORT) {
            native_set_agps_server(STATE_DOWNLOADING, this.mSuplServerHost, this.mSuplServerPort);
        }
    }

    private int getSuplMode(Properties properties, boolean agpsEnabled, boolean singleShot) {
        if (!agpsEnabled) {
            return TCP_MIN_PORT;
        }
        String modeString = properties.getProperty("SUPL_MODE");
        int suplMode = TCP_MIN_PORT;
        if (!TextUtils.isEmpty(modeString)) {
            try {
                suplMode = Integer.parseInt(modeString);
            } catch (NumberFormatException e) {
                Log.e(WAKELOCK_KEY, "unable to parse SUPL_MODE: " + modeString);
                return TCP_MIN_PORT;
            }
        }
        if (singleShot && hasCapability(UPDATE_NETWORK_STATE) && (suplMode & USED_FOR_FIX_MASK) != 0) {
            return USED_FOR_FIX_MASK;
        }
        if (!hasCapability(USED_FOR_FIX_MASK) || (suplMode & STATE_DOWNLOADING) == 0) {
            return TCP_MIN_PORT;
        }
        return STATE_DOWNLOADING;
    }

    private void handleEnable() {
        if (DEBUG) {
            Log.d(WAKELOCK_KEY, "handleEnable");
        }
        if (native_init()) {
            this.mSupportsXtra = native_supports_xtra();
            if (this.mSuplServerHost != null) {
                native_set_agps_server(STATE_DOWNLOADING, this.mSuplServerHost, this.mSuplServerPort);
            }
            if (this.mC2KServerHost != null) {
                native_set_agps_server(USED_FOR_FIX_MASK, this.mC2KServerHost, this.mC2KServerPort);
                return;
            }
            return;
        }
        synchronized (this.mLock) {
            this.mEnabled = VERBOSE;
        }
        Log.w(WAKELOCK_KEY, "Failed to enable location provider");
    }

    public void disable() {
        synchronized (this.mLock) {
            if (this.mEnabled) {
                this.mEnabled = VERBOSE;
                sendMessage(USED_FOR_FIX_MASK, TCP_MIN_PORT, null);
                return;
            }
        }
    }

    private void handleDisable() {
        if (DEBUG) {
            Log.d(WAKELOCK_KEY, "handleDisable");
        }
        updateClientUids(new WorkSource());
        stopNavigating();
        this.mAlarmManager.cancel(this.mWakeupIntent);
        this.mAlarmManager.cancel(this.mTimeoutIntent);
        native_cleanup();
    }

    public boolean isEnabled() {
        boolean z;
        synchronized (this.mLock) {
            z = this.mEnabled;
        }
        return z;
    }

    public int getStatus(Bundle extras) {
        if (extras != null) {
            extras.putInt("satellites", this.mSvCount);
        }
        return this.mStatus;
    }

    private void updateStatus(int status, int svCount) {
        if (status != this.mStatus || svCount != this.mSvCount) {
            this.mStatus = status;
            this.mSvCount = svCount;
            this.mLocationExtras.putInt("satellites", svCount);
            this.mStatusUpdateTime = SystemClock.elapsedRealtime();
        }
    }

    public long getStatusUpdateTime() {
        return this.mStatusUpdateTime;
    }

    public void setRequest(ProviderRequest request, WorkSource source) {
        sendMessage(SET_REQUEST, TCP_MIN_PORT, new GpsRequest(request, source));
    }

    private void handleSetRequest(ProviderRequest request, WorkSource source) {
        this.mProviderRequest = request;
        this.mWorkSource = source;
        updateRequirements();
    }

    private void updateRequirements() {
        if (this.mProviderRequest != null && this.mWorkSource != null) {
            boolean singleShot = VERBOSE;
            if (this.mProviderRequest.locationRequests != null && this.mProviderRequest.locationRequests.size() > 0) {
                singleShot = true;
                for (LocationRequest lr : this.mProviderRequest.locationRequests) {
                    if (lr.getNumUpdates() != STATE_DOWNLOADING) {
                        singleShot = VERBOSE;
                    }
                }
            }
            if (DEBUG) {
                Log.d(WAKELOCK_KEY, "setRequest " + this.mProviderRequest);
            }
            if (!this.mProviderRequest.reportLocation || this.mDisableGps) {
                updateClientUids(new WorkSource());
                stopNavigating();
                this.mAlarmManager.cancel(this.mWakeupIntent);
                this.mAlarmManager.cancel(this.mTimeoutIntent);
                return;
            }
            updateClientUids(this.mWorkSource);
            this.mFixInterval = (int) this.mProviderRequest.interval;
            if (((long) this.mFixInterval) != this.mProviderRequest.interval) {
                Log.w(WAKELOCK_KEY, "interval overflow: " + this.mProviderRequest.interval);
                this.mFixInterval = Integer.MAX_VALUE;
            }
            if (this.mStarted && hasCapability(STATE_DOWNLOADING)) {
                if (!native_set_position_mode(this.mPositionMode, TCP_MIN_PORT, this.mFixInterval, TCP_MIN_PORT, TCP_MIN_PORT)) {
                    Log.e(WAKELOCK_KEY, "set_position_mode failed in setMinTime()");
                }
            } else if (!this.mStarted) {
                startNavigating(singleShot);
            }
        }
    }

    private void updateClientUids(WorkSource source) {
        WorkSource[] changes = this.mClientSource.setReturningDiffs(source);
        if (changes != null) {
            int lastuid;
            int i;
            int uid;
            WorkSource newWork = changes[TCP_MIN_PORT];
            WorkSource goneWork = changes[STATE_DOWNLOADING];
            if (newWork != null) {
                lastuid = GPS_DELETE_ALL;
                for (i = TCP_MIN_PORT; i < newWork.size(); i += STATE_DOWNLOADING) {
                    try {
                        uid = newWork.get(i);
                        this.mAppOpsService.startOperation(AppOpsManager.getToken(this.mAppOpsService), USED_FOR_FIX_MASK, uid, newWork.getName(i));
                        if (uid != lastuid) {
                            lastuid = uid;
                            this.mBatteryStats.noteStartGps(uid);
                        }
                    } catch (RemoteException e) {
                        Log.w(WAKELOCK_KEY, "RemoteException", e);
                    }
                }
            }
            if (goneWork != null) {
                lastuid = GPS_DELETE_ALL;
                for (i = TCP_MIN_PORT; i < goneWork.size(); i += STATE_DOWNLOADING) {
                    try {
                        uid = goneWork.get(i);
                        this.mAppOpsService.finishOperation(AppOpsManager.getToken(this.mAppOpsService), USED_FOR_FIX_MASK, uid, goneWork.getName(i));
                        if (uid != lastuid) {
                            lastuid = uid;
                            this.mBatteryStats.noteStopGps(uid);
                        }
                    } catch (RemoteException e2) {
                        Log.w(WAKELOCK_KEY, "RemoteException", e2);
                    }
                }
            }
        }
    }

    public boolean sendExtraCommand(String command, Bundle extras) {
        long identity = Binder.clearCallingIdentity();
        boolean result = VERBOSE;
        if ("delete_aiding_data".equals(command)) {
            result = deleteAidingData(extras);
        } else if ("force_time_injection".equals(command)) {
            sendMessage(INJECT_NTP_TIME, TCP_MIN_PORT, null);
            result = true;
        } else if (!"force_xtra_injection".equals(command)) {
            Log.w(WAKELOCK_KEY, "sendExtraCommand: unknown command " + command);
        } else if (this.mSupportsXtra) {
            xtraDownloadRequest();
            result = true;
        }
        Binder.restoreCallingIdentity(identity);
        return result;
    }

    private boolean deleteAidingData(Bundle extras) {
        int flags;
        if (extras == null) {
            flags = GPS_DELETE_ALL;
        } else {
            flags = TCP_MIN_PORT;
            if (extras.getBoolean("ephemeris")) {
                flags = TCP_MIN_PORT | STATE_DOWNLOADING;
            }
            if (extras.getBoolean("almanac")) {
                flags |= USED_FOR_FIX_MASK;
            }
            if (extras.getBoolean("position")) {
                flags |= UPDATE_NETWORK_STATE;
            }
            if (extras.getBoolean("time")) {
                flags |= LOCATION_HAS_BEARING;
            }
            if (extras.getBoolean("iono")) {
                flags |= LOCATION_HAS_ACCURACY;
            }
            if (extras.getBoolean("utc")) {
                flags |= MAX_SVS;
            }
            if (extras.getBoolean("health")) {
                flags |= GPS_DELETE_HEALTH;
            }
            if (extras.getBoolean("svdir")) {
                flags |= GPS_DELETE_SVDIR;
            }
            if (extras.getBoolean("svsteer")) {
                flags |= GPS_DELETE_SVSTEER;
            }
            if (extras.getBoolean("sadata")) {
                flags |= GPS_DELETE_SADATA;
            }
            if (extras.getBoolean("rti")) {
                flags |= GPS_DELETE_RTI;
            }
            if (extras.getBoolean("celldb-info")) {
                flags |= GPS_DELETE_CELLDB_INFO;
            }
            if (extras.getBoolean("almanac-corr")) {
                flags |= GPS_DELETE_ALMANAC_CORR;
            }
            if (extras.getBoolean("freq-bias-est")) {
                flags |= GPS_DELETE_FREQ_BIAS_EST;
            }
            if (extras.getBoolean("ephemeris-GLO")) {
                flags |= GLO_DELETE_EPHEMERIS;
            }
            if (extras.getBoolean("almanac-GLO")) {
                flags |= GLO_DELETE_ALMANAC;
            }
            if (extras.getBoolean("svdir-GLO")) {
                flags |= GLO_DELETE_SVDIR;
            }
            if (extras.getBoolean("svsteer-GLO")) {
                flags |= GLO_DELETE_SVSTEER;
            }
            if (extras.getBoolean("almanac-corr-GLO")) {
                flags |= GLO_DELETE_ALMANAC_CORR;
            }
            if (extras.getBoolean("time-gps")) {
                flags |= GPS_DELETE_TIME_GPS;
            }
            if (extras.getBoolean("time-GLO")) {
                flags |= GLO_DELETE_TIME;
            }
            if (extras.getBoolean("ephemeris-BDS")) {
                flags |= BDS_DELETE_EPHEMERIS;
            }
            if (extras.getBoolean("almanac-BDS")) {
                flags |= BDS_DELETE_ALMANAC;
            }
            if (extras.getBoolean("svdir-BDS")) {
                flags |= BDS_DELETE_SVDIR;
            }
            if (extras.getBoolean("svsteer-BDS")) {
                flags |= BDS_DELETE_SVSTEER;
            }
            if (extras.getBoolean("almanac-corr-BDS")) {
                flags |= BDS_DELETE_ALMANAC_CORR;
            }
            if (extras.getBoolean("time-BDS")) {
                flags |= BDS_DELETE_TIME;
            }
            if (extras.getBoolean("all")) {
                flags |= GPS_DELETE_ALL;
            }
        }
        if (flags == 0) {
            return VERBOSE;
        }
        native_delete_aiding_data(flags);
        return true;
    }

    private void startNavigating(boolean singleShot) {
        if (!this.mStarted) {
            if (DEBUG) {
                Log.d(WAKELOCK_KEY, "startNavigating, singleShot is " + singleShot);
            }
            this.mTimeToFirstFix = TCP_MIN_PORT;
            this.mLastFixTime = 0;
            this.mStarted = true;
            this.mSingleShot = singleShot;
            this.mPositionMode = TCP_MIN_PORT;
            this.mPositionMode = getSuplMode(this.mProperties, Global.getInt(this.mContext.getContentResolver(), "assisted_gps_enabled", STATE_DOWNLOADING) != 0 ? true : VERBOSE, singleShot);
            if (DEBUG) {
                String mode;
                switch (this.mPositionMode) {
                    case TCP_MIN_PORT /*0*/:
                        mode = "standalone";
                        break;
                    case STATE_DOWNLOADING /*1*/:
                        mode = "MS_BASED";
                        break;
                    case USED_FOR_FIX_MASK /*2*/:
                        mode = "MS_ASSISTED";
                        break;
                    default:
                        mode = "unknown";
                        break;
                }
                Log.d(WAKELOCK_KEY, "setting position_mode to " + mode);
            }
            if (!native_set_position_mode(this.mPositionMode, TCP_MIN_PORT, hasCapability(STATE_DOWNLOADING) ? this.mFixInterval : ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE, TCP_MIN_PORT, TCP_MIN_PORT)) {
                this.mStarted = VERBOSE;
                Log.e(WAKELOCK_KEY, "set_position_mode failed in startNavigating()");
            } else if (native_start()) {
                updateStatus(STATE_DOWNLOADING, TCP_MIN_PORT);
                this.mFixRequestTime = System.currentTimeMillis();
                if (!hasCapability(STATE_DOWNLOADING) && this.mFixInterval >= NO_FIX_TIMEOUT) {
                    this.mAlarmManager.set(USED_FOR_FIX_MASK, SystemClock.elapsedRealtime() + 60000, this.mTimeoutIntent);
                }
            } else {
                this.mStarted = VERBOSE;
                Log.e(WAKELOCK_KEY, "native_start failed in startNavigating()");
            }
        }
    }

    private void stopNavigating() {
        if (DEBUG) {
            Log.d(WAKELOCK_KEY, "stopNavigating");
        }
        if (this.mStarted) {
            this.mStarted = VERBOSE;
            this.mSingleShot = VERBOSE;
            native_stop();
            this.mTimeToFirstFix = TCP_MIN_PORT;
            this.mLastFixTime = 0;
            this.mLocationFlags = TCP_MIN_PORT;
            updateStatus(STATE_DOWNLOADING, TCP_MIN_PORT);
        }
    }

    private void hibernate() {
        stopNavigating();
        this.mAlarmManager.cancel(this.mTimeoutIntent);
        this.mAlarmManager.cancel(this.mWakeupIntent);
        this.mAlarmManager.set(USED_FOR_FIX_MASK, ((long) this.mFixInterval) + SystemClock.elapsedRealtime(), this.mWakeupIntent);
    }

    private boolean hasCapability(int capability) {
        return (this.mEngineCapabilities & capability) != 0 ? true : VERBOSE;
    }

    private void reportLocation(int flags, double latitude, double longitude, double altitude, float speed, float bearing, float accuracy, long timestamp) {
        if (VERBOSE) {
            Log.v(WAKELOCK_KEY, "reportLocation lat: " + latitude + " long: " + longitude + " timestamp: " + timestamp);
        }
        synchronized (this.mLocation) {
            this.mLocationFlags = flags;
            if ((flags & STATE_DOWNLOADING) == STATE_DOWNLOADING) {
                this.mLocation.setLatitude(latitude);
                this.mLocation.setLongitude(longitude);
                this.mLocation.setTime(timestamp);
                this.mLocation.setElapsedRealtimeNanos(SystemClock.elapsedRealtimeNanos());
            }
            if ((flags & USED_FOR_FIX_MASK) == USED_FOR_FIX_MASK) {
                this.mLocation.setAltitude(altitude);
            } else {
                this.mLocation.removeAltitude();
            }
            if ((flags & UPDATE_NETWORK_STATE) == UPDATE_NETWORK_STATE) {
                this.mLocation.setSpeed(speed);
            } else {
                this.mLocation.removeSpeed();
            }
            if ((flags & LOCATION_HAS_BEARING) == LOCATION_HAS_BEARING) {
                this.mLocation.setBearing(bearing);
            } else {
                this.mLocation.removeBearing();
            }
            if ((flags & LOCATION_HAS_ACCURACY) == LOCATION_HAS_ACCURACY) {
                this.mLocation.setAccuracy(accuracy);
            } else {
                this.mLocation.removeAccuracy();
            }
            this.mLocation.setExtras(this.mLocationExtras);
            try {
                this.mILocationManager.reportLocation(this.mLocation, VERBOSE);
            } catch (RemoteException e) {
                Log.e(WAKELOCK_KEY, "RemoteException calling reportLocation");
            }
        }
        this.mLastFixTime = System.currentTimeMillis();
        if (this.mTimeToFirstFix == 0 && (flags & STATE_DOWNLOADING) == STATE_DOWNLOADING) {
            this.mTimeToFirstFix = (int) (this.mLastFixTime - this.mFixRequestTime);
            if (DEBUG) {
                Log.d(WAKELOCK_KEY, "TTFF: " + this.mTimeToFirstFix);
            }
            this.mListenerHelper.onFirstFix(this.mTimeToFirstFix);
        }
        if (this.mSingleShot) {
            stopNavigating();
        }
        if (this.mStarted && this.mStatus != USED_FOR_FIX_MASK) {
            if (!hasCapability(STATE_DOWNLOADING) && this.mFixInterval < NO_FIX_TIMEOUT) {
                this.mAlarmManager.cancel(this.mTimeoutIntent);
            }
            Intent intent = new Intent("android.location.GPS_FIX_CHANGE");
            intent.putExtra("enabled", true);
            this.mContext.sendBroadcastAsUser(intent, UserHandle.ALL);
            updateStatus(USED_FOR_FIX_MASK, this.mSvCount);
        }
        if (!hasCapability(STATE_DOWNLOADING) && this.mStarted && this.mFixInterval > GPS_POLLING_THRESHOLD_INTERVAL) {
            if (DEBUG) {
                Log.d(WAKELOCK_KEY, "got fix, hibernating");
            }
            hibernate();
        }
    }

    private void reportStatus(int status) {
        if (DEBUG) {
            Log.v(WAKELOCK_KEY, "reportStatus status: " + status);
        }
        boolean wasNavigating = this.mNavigating;
        switch (status) {
            case STATE_DOWNLOADING /*1*/:
                this.mNavigating = true;
                this.mEngineOn = true;
                break;
            case USED_FOR_FIX_MASK /*2*/:
                this.mNavigating = VERBOSE;
                break;
            case SET_REQUEST /*3*/:
                this.mEngineOn = true;
                break;
            case UPDATE_NETWORK_STATE /*4*/:
                this.mEngineOn = VERBOSE;
                this.mNavigating = VERBOSE;
                break;
        }
        if (wasNavigating != this.mNavigating) {
            this.mListenerHelper.onGpsEnabledChanged(this.mNavigating);
            this.mGpsMeasurementsProvider.onGpsEnabledChanged(this.mNavigating);
            this.mGpsNavigationMessageProvider.onGpsEnabledChanged(this.mNavigating);
            Intent intent = new Intent("android.location.GPS_ENABLED_CHANGE");
            intent.putExtra("enabled", this.mNavigating);
            this.mContext.sendBroadcastAsUser(intent, UserHandle.ALL);
        }
    }

    private void reportSvStatus() {
        int svCount = native_read_sv_status(this.mSvs, this.mSnrs, this.mSvElevations, this.mSvAzimuths, this.mSvMasks);
        this.mListenerHelper.onSvStatusChanged(svCount, this.mSvs, this.mSnrs, this.mSvElevations, this.mSvAzimuths, this.mSvMasks[TCP_MIN_PORT], this.mSvMasks[STATE_DOWNLOADING], this.mSvMasks[USED_FOR_FIX_MASK]);
        if (VERBOSE) {
            Log.v(WAKELOCK_KEY, "SV count: " + svCount + " ephemerisMask: " + Integer.toHexString(this.mSvMasks[TCP_MIN_PORT]) + " almanacMask: " + Integer.toHexString(this.mSvMasks[STATE_DOWNLOADING]));
            for (int i = TCP_MIN_PORT; i < svCount; i += STATE_DOWNLOADING) {
                String str;
                String str2 = WAKELOCK_KEY;
                StringBuilder append = new StringBuilder().append("sv: ").append(this.mSvs[i]).append(" snr: ").append(this.mSnrs[i] / 10.0f).append(" elev: ").append(this.mSvElevations[i]).append(" azimuth: ").append(this.mSvAzimuths[i]).append((this.mSvMasks[TCP_MIN_PORT] & (STATE_DOWNLOADING << (this.mSvs[i] + GPS_DELETE_ALL))) == 0 ? "  " : " E");
                if ((this.mSvMasks[STATE_DOWNLOADING] & (STATE_DOWNLOADING << (this.mSvs[i] + GPS_DELETE_ALL))) == 0) {
                    str = "  ";
                } else {
                    str = " A";
                }
                append = append.append(str);
                if ((this.mSvMasks[USED_FOR_FIX_MASK] & (STATE_DOWNLOADING << (this.mSvs[i] + GPS_DELETE_ALL))) == 0) {
                    str = "";
                } else {
                    str = "U";
                }
                Log.v(str2, append.append(str).toString());
            }
        }
        updateStatus(this.mStatus, Integer.bitCount(this.mSvMasks[USED_FOR_FIX_MASK]));
        if (this.mNavigating && this.mStatus == USED_FOR_FIX_MASK && this.mLastFixTime > 0 && System.currentTimeMillis() - this.mLastFixTime > RECENT_FIX_TIMEOUT) {
            Intent intent = new Intent("android.location.GPS_FIX_CHANGE");
            intent.putExtra("enabled", VERBOSE);
            this.mContext.sendBroadcastAsUser(intent, UserHandle.ALL);
            updateStatus(STATE_DOWNLOADING, this.mSvCount);
        }
    }

    private void reportAGpsStatus(int type, int status, byte[] ipaddr) {
        switch (status) {
            case STATE_DOWNLOADING /*1*/:
                if (DEBUG) {
                    Log.d(WAKELOCK_KEY, "GPS_REQUEST_AGPS_DATA_CONN");
                }
                Log.v(WAKELOCK_KEY, "Received SUPL IP addr[]: " + ipaddr);
                this.mAGpsDataConnectionState = STATE_DOWNLOADING;
                int result = this.mConnMgr.startUsingNetworkFeature(TCP_MIN_PORT, "enableSUPL");
                if (ipaddr != null) {
                    try {
                        this.mAGpsDataConnectionIpAddr = InetAddress.getByAddress(ipaddr);
                        Log.v(WAKELOCK_KEY, "IP address converted to: " + this.mAGpsDataConnectionIpAddr);
                    } catch (UnknownHostException e) {
                        Log.e(WAKELOCK_KEY, "Bad IP Address: " + ipaddr, e);
                        this.mAGpsDataConnectionIpAddr = null;
                    }
                }
                if (result == 0) {
                    if (DEBUG) {
                        Log.d(WAKELOCK_KEY, "PhoneConstants.APN_ALREADY_ACTIVE");
                    }
                    if (this.mAGpsApn != null) {
                        setRouting();
                        native_agps_data_conn_open(this.mAGpsApn, this.mApnIpType);
                        this.mAGpsDataConnectionState = USED_FOR_FIX_MASK;
                        return;
                    }
                    Log.e(WAKELOCK_KEY, "mAGpsApn not set when receiving PhoneConstants.APN_ALREADY_ACTIVE");
                    this.mAGpsDataConnectionState = TCP_MIN_PORT;
                    native_agps_data_conn_failed();
                } else if (result != STATE_DOWNLOADING) {
                    if (DEBUG) {
                        Log.d(WAKELOCK_KEY, "startUsingNetworkFeature failed, value is " + result);
                    }
                    this.mAGpsDataConnectionState = TCP_MIN_PORT;
                    native_agps_data_conn_failed();
                } else if (DEBUG) {
                    Log.d(WAKELOCK_KEY, "PhoneConstants.APN_REQUEST_STARTED");
                }
            case USED_FOR_FIX_MASK /*2*/:
                if (DEBUG) {
                    Log.d(WAKELOCK_KEY, "GPS_RELEASE_AGPS_DATA_CONN");
                }
                if (this.mAGpsDataConnectionState != 0) {
                    this.mConnMgr.stopUsingNetworkFeature(TCP_MIN_PORT, "enableSUPL");
                    native_agps_data_conn_closed();
                    this.mAGpsDataConnectionState = TCP_MIN_PORT;
                    this.mAGpsDataConnectionIpAddr = null;
                }
            case SET_REQUEST /*3*/:
                if (DEBUG) {
                    Log.d(WAKELOCK_KEY, "GPS_AGPS_DATA_CONNECTED");
                }
            case UPDATE_NETWORK_STATE /*4*/:
                if (DEBUG) {
                    Log.d(WAKELOCK_KEY, "GPS_AGPS_DATA_CONN_DONE");
                }
            case INJECT_NTP_TIME /*5*/:
                if (DEBUG) {
                    Log.d(WAKELOCK_KEY, "GPS_AGPS_DATA_CONN_FAILED");
                }
            default:
                Log.d(WAKELOCK_KEY, "Received Unknown AGPS status: " + status);
        }
    }

    private void reportNmea(long timestamp) {
        this.mListenerHelper.onNmeaReceived(timestamp, new String(this.mNmeaBuffer, TCP_MIN_PORT, native_read_nmea(this.mNmeaBuffer, this.mNmeaBuffer.length)));
    }

    private void reportMeasurementData(GpsMeasurementsEvent event) {
        this.mGpsMeasurementsProvider.onMeasurementsAvailable(event);
    }

    private void reportNavigationMessage(GpsNavigationMessageEvent event) {
        this.mGpsNavigationMessageProvider.onNavigationMessageAvailable(event);
    }

    private void setEngineCapabilities(int capabilities) {
        boolean z;
        boolean z2 = true;
        this.mEngineCapabilities = capabilities;
        if (!(hasCapability(LOCATION_HAS_ACCURACY) || this.mPeriodicTimeInjection)) {
            this.mPeriodicTimeInjection = true;
            requestUtcTime();
        }
        GpsMeasurementsProvider gpsMeasurementsProvider = this.mGpsMeasurementsProvider;
        if ((capabilities & GPS_DELETE_HEALTH) == GPS_DELETE_HEALTH) {
            z = true;
        } else {
            z = VERBOSE;
        }
        gpsMeasurementsProvider.onCapabilitiesUpdated(z);
        GpsNavigationMessageProvider gpsNavigationMessageProvider = this.mGpsNavigationMessageProvider;
        if ((capabilities & GPS_DELETE_SVDIR) != GPS_DELETE_SVDIR) {
            z2 = VERBOSE;
        }
        gpsNavigationMessageProvider.onCapabilitiesUpdated(z2);
    }

    private void xtraDownloadRequest() {
        if (DEBUG) {
            Log.d(WAKELOCK_KEY, "xtraDownloadRequest");
        }
        sendMessage(DOWNLOAD_XTRA_DATA, TCP_MIN_PORT, null);
    }

    private Location buildLocation(int flags, double latitude, double longitude, double altitude, float speed, float bearing, float accuracy, long timestamp) {
        Location location = new Location("gps");
        if ((flags & STATE_DOWNLOADING) == STATE_DOWNLOADING) {
            location.setLatitude(latitude);
            location.setLongitude(longitude);
            location.setTime(timestamp);
            location.setElapsedRealtimeNanos(SystemClock.elapsedRealtimeNanos());
        }
        if ((flags & USED_FOR_FIX_MASK) == USED_FOR_FIX_MASK) {
            location.setAltitude(altitude);
        }
        if ((flags & UPDATE_NETWORK_STATE) == UPDATE_NETWORK_STATE) {
            location.setSpeed(speed);
        }
        if ((flags & LOCATION_HAS_BEARING) == LOCATION_HAS_BEARING) {
            location.setBearing(bearing);
        }
        if ((flags & LOCATION_HAS_ACCURACY) == LOCATION_HAS_ACCURACY) {
            location.setAccuracy(accuracy);
        }
        return location;
    }

    private int getGeofenceStatus(int status) {
        switch (status) {
            case GPS_GEOFENCE_ERROR_GENERIC /*-149*/:
                return INJECT_NTP_TIME;
            case GPS_GEOFENCE_ERROR_INVALID_TRANSITION /*-103*/:
                return UPDATE_NETWORK_STATE;
            case GPS_GEOFENCE_ERROR_ID_UNKNOWN /*-102*/:
                return SET_REQUEST;
            case GPS_GEOFENCE_ERROR_ID_EXISTS /*-101*/:
                return USED_FOR_FIX_MASK;
            case TCP_MIN_PORT /*0*/:
                return TCP_MIN_PORT;
            case GPS_GEOFENCE_ERROR_TOO_MANY_GEOFENCES /*100*/:
                return STATE_DOWNLOADING;
            default:
                return GPS_DELETE_ALL;
        }
    }

    private void reportGeofenceTransition(int geofenceId, int flags, double latitude, double longitude, double altitude, float speed, float bearing, float accuracy, long timestamp, int transition, long transitionTimestamp) {
        if (this.mGeofenceHardwareImpl == null) {
            this.mGeofenceHardwareImpl = GeofenceHardwareImpl.getInstance(this.mContext);
        }
        int i = geofenceId;
        this.mGeofenceHardwareImpl.reportGeofenceTransition(i, buildLocation(flags, latitude, longitude, altitude, speed, bearing, accuracy, timestamp), transition, transitionTimestamp, TCP_MIN_PORT, SourceTechnologies.GNSS);
    }

    private void reportGeofenceStatus(int status, int flags, double latitude, double longitude, double altitude, float speed, float bearing, float accuracy, long timestamp) {
        if (this.mGeofenceHardwareImpl == null) {
            this.mGeofenceHardwareImpl = GeofenceHardwareImpl.getInstance(this.mContext);
        }
        Location location = buildLocation(flags, latitude, longitude, altitude, speed, bearing, accuracy, timestamp);
        int monitorStatus = STATE_DOWNLOADING;
        if (status == USED_FOR_FIX_MASK) {
            monitorStatus = TCP_MIN_PORT;
        }
        this.mGeofenceHardwareImpl.reportGeofenceMonitorStatus(TCP_MIN_PORT, monitorStatus, location, SourceTechnologies.GNSS);
    }

    private void reportGeofenceAddStatus(int geofenceId, int status) {
        if (this.mGeofenceHardwareImpl == null) {
            this.mGeofenceHardwareImpl = GeofenceHardwareImpl.getInstance(this.mContext);
        }
        this.mGeofenceHardwareImpl.reportGeofenceAddStatus(geofenceId, getGeofenceStatus(status));
    }

    private void reportGeofenceRemoveStatus(int geofenceId, int status) {
        if (this.mGeofenceHardwareImpl == null) {
            this.mGeofenceHardwareImpl = GeofenceHardwareImpl.getInstance(this.mContext);
        }
        this.mGeofenceHardwareImpl.reportGeofenceRemoveStatus(geofenceId, getGeofenceStatus(status));
    }

    private void reportGeofencePauseStatus(int geofenceId, int status) {
        if (this.mGeofenceHardwareImpl == null) {
            this.mGeofenceHardwareImpl = GeofenceHardwareImpl.getInstance(this.mContext);
        }
        this.mGeofenceHardwareImpl.reportGeofencePauseStatus(geofenceId, getGeofenceStatus(status));
    }

    private void reportGeofenceResumeStatus(int geofenceId, int status) {
        if (this.mGeofenceHardwareImpl == null) {
            this.mGeofenceHardwareImpl = GeofenceHardwareImpl.getInstance(this.mContext);
        }
        this.mGeofenceHardwareImpl.reportGeofenceResumeStatus(geofenceId, getGeofenceStatus(status));
    }

    public INetInitiatedListener getNetInitiatedListener() {
        return this.mNetInitiatedListener;
    }

    public void reportNiNotification(int notificationId, int niType, int notifyFlags, int timeout, int defaultResponse, String requestorId, String text, int requestorIdEncoding, int textEncoding, String extras) {
        Log.i(WAKELOCK_KEY, "reportNiNotification: entered");
        Log.i(WAKELOCK_KEY, "notificationId: " + notificationId + ", niType: " + niType + ", notifyFlags: " + notifyFlags + ", timeout: " + timeout + ", defaultResponse: " + defaultResponse);
        Log.i(WAKELOCK_KEY, "requestorId: " + requestorId + ", text: " + text + ", requestorIdEncoding: " + requestorIdEncoding + ", textEncoding: " + textEncoding);
        GpsNiNotification notification = new GpsNiNotification();
        notification.notificationId = notificationId;
        notification.niType = niType;
        notification.needNotify = (notifyFlags & STATE_DOWNLOADING) != 0 ? true : VERBOSE;
        notification.needVerify = (notifyFlags & USED_FOR_FIX_MASK) != 0 ? true : VERBOSE;
        notification.privacyOverride = (notifyFlags & UPDATE_NETWORK_STATE) != 0 ? true : VERBOSE;
        notification.timeout = timeout;
        notification.defaultResponse = defaultResponse;
        notification.requestorId = requestorId;
        notification.text = text;
        notification.requestorIdEncoding = requestorIdEncoding;
        notification.textEncoding = textEncoding;
        Bundle bundle = new Bundle();
        if (extras == null) {
            extras = "";
        }
        Properties extraProp = new Properties();
        try {
            extraProp.load(new StringReader(extras));
        } catch (IOException e) {
            Log.e(WAKELOCK_KEY, "reportNiNotification cannot parse extras data: " + extras);
        }
        for (Entry<Object, Object> ent : extraProp.entrySet()) {
            bundle.putString((String) ent.getKey(), (String) ent.getValue());
        }
        notification.extras = bundle;
        this.mNIHandler.handleNiNotification(notification);
    }

    private void requestSetID(int flags) {
        TelephonyManager phone = (TelephonyManager) this.mContext.getSystemService("phone");
        int type = TCP_MIN_PORT;
        String data = "";
        String data_temp;
        if ((flags & STATE_DOWNLOADING) == STATE_DOWNLOADING) {
            data_temp = phone.getSubscriberId();
            if (data_temp != null) {
                data = data_temp;
                type = STATE_DOWNLOADING;
            }
        } else if ((flags & USED_FOR_FIX_MASK) == USED_FOR_FIX_MASK) {
            data_temp = phone.getLine1Number();
            if (data_temp != null) {
                data = data_temp;
                type = USED_FOR_FIX_MASK;
            }
        }
        native_agps_set_id(type, data);
    }

    private void requestUtcTime() {
        sendMessage(INJECT_NTP_TIME, TCP_MIN_PORT, null);
    }

    private void requestRefLocation(int flags) {
        TelephonyManager phone = (TelephonyManager) this.mContext.getSystemService("phone");
        int phoneType = phone.getPhoneType();
        if (phoneType == STATE_DOWNLOADING) {
            GsmCellLocation gsm_cell = (GsmCellLocation) phone.getCellLocation();
            if (gsm_cell == null || phone.getNetworkOperator() == null || phone.getNetworkOperator().length() <= SET_REQUEST) {
                Log.e(WAKELOCK_KEY, "Error getting cell location info.");
                return;
            }
            int type;
            int mcc = Integer.parseInt(phone.getNetworkOperator().substring(TCP_MIN_PORT, SET_REQUEST));
            int mnc = Integer.parseInt(phone.getNetworkOperator().substring(SET_REQUEST));
            int networkType = phone.getNetworkType();
            if (networkType == SET_REQUEST || networkType == LOCATION_HAS_BEARING || networkType == REMOVE_LISTENER || networkType == INJECT_NTP_TIME_FINISHED || networkType == 15) {
                type = USED_FOR_FIX_MASK;
            } else {
                type = STATE_DOWNLOADING;
            }
            native_agps_set_ref_location_cellid(type, mcc, mnc, gsm_cell.getLac(), gsm_cell.getCid());
        } else if (phoneType == USED_FOR_FIX_MASK) {
            Log.e(WAKELOCK_KEY, "CDMA not supported.");
        }
    }

    private void sendMessage(int message, int arg, Object obj) {
        this.mWakeLock.acquire();
        this.mHandler.obtainMessage(message, arg, STATE_DOWNLOADING, obj).sendToTarget();
    }

    private String getDefaultApn() {
        Uri uri = Uri.parse("content://telephony/carriers/preferapn");
        Cursor cursor = null;
        try {
            ContentResolver contentResolver = this.mContext.getContentResolver();
            String[] strArr = new String[STATE_DOWNLOADING];
            strArr[TCP_MIN_PORT] = "apn";
            cursor = contentResolver.query(uri, strArr, null, null, "name ASC");
            if (cursor == null || !cursor.moveToFirst()) {
                Log.e(WAKELOCK_KEY, "No APN found to select.");
                if (cursor != null) {
                    cursor.close();
                }
                return "dummy-apn";
            }
            String string = cursor.getString(TCP_MIN_PORT);
            if (cursor == null) {
                return string;
            }
            cursor.close();
            return string;
        } catch (Exception e) {
            Log.e(WAKELOCK_KEY, "Error encountered on selecting the APN.", e);
            if (cursor != null) {
                cursor.close();
            }
        } catch (Throwable th) {
            if (cursor != null) {
                cursor.close();
            }
        }
    }

    private int getApnIpType(String apn) {
        if (apn == null) {
            return TCP_MIN_PORT;
        }
        if (apn.equals(this.mAGpsApn) && this.mApnIpType != 0) {
            return this.mApnIpType;
        }
        Object[] objArr = new Object[STATE_DOWNLOADING];
        objArr[TCP_MIN_PORT] = apn;
        String selection = String.format("current = 1 and apn = '%s' and carrier_enabled = 1", objArr);
        Cursor cursor = null;
        try {
            ContentResolver contentResolver = this.mContext.getContentResolver();
            Uri uri = Carriers.CONTENT_URI;
            String[] strArr = new String[STATE_DOWNLOADING];
            strArr[TCP_MIN_PORT] = "protocol";
            cursor = contentResolver.query(uri, strArr, selection, null, "name ASC");
            if (cursor == null || !cursor.moveToFirst()) {
                Log.e(WAKELOCK_KEY, "No entry found in query for APN: " + apn);
                if (cursor != null) {
                    cursor.close();
                }
                return TCP_MIN_PORT;
            }
            int translateToApnIpType = translateToApnIpType(cursor.getString(TCP_MIN_PORT), apn);
            if (cursor == null) {
                return translateToApnIpType;
            }
            cursor.close();
            return translateToApnIpType;
        } catch (Exception e) {
            Log.e(WAKELOCK_KEY, "Error encountered on APN query for: " + apn, e);
            if (cursor != null) {
                cursor.close();
            }
        } catch (Throwable th) {
            if (cursor != null) {
                cursor.close();
            }
        }
    }

    private int translateToApnIpType(String ipProtocol, String apn) {
        if ("IP".equals(ipProtocol)) {
            return STATE_DOWNLOADING;
        }
        if ("IPV6".equals(ipProtocol)) {
            return USED_FOR_FIX_MASK;
        }
        if ("IPV4V6".equals(ipProtocol)) {
            return SET_REQUEST;
        }
        Object[] objArr = new Object[USED_FOR_FIX_MASK];
        objArr[TCP_MIN_PORT] = ipProtocol;
        objArr[STATE_DOWNLOADING] = apn;
        Log.e(WAKELOCK_KEY, String.format("Unknown IP Protocol: %s, for APN: %s", objArr));
        return TCP_MIN_PORT;
    }

    private void setRouting() {
        if (this.mAGpsDataConnectionIpAddr != null) {
            if (!this.mConnMgr.requestRouteToHostAddress(SET_REQUEST, this.mAGpsDataConnectionIpAddr)) {
                Log.e(WAKELOCK_KEY, "Error requesting route to host: " + this.mAGpsDataConnectionIpAddr);
            } else if (DEBUG) {
                Log.d(WAKELOCK_KEY, "Successfully requested route to host: " + this.mAGpsDataConnectionIpAddr);
            }
        }
    }

    public void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
        StringBuilder s = new StringBuilder();
        s.append("  mFixInterval=").append(this.mFixInterval).append("\n");
        s.append("  mDisableGps (battery saver mode)=").append(this.mDisableGps).append("\n");
        s.append("  mEngineCapabilities=0x").append(Integer.toHexString(this.mEngineCapabilities)).append(" (");
        if (hasCapability(STATE_DOWNLOADING)) {
            s.append("SCHED ");
        }
        if (hasCapability(USED_FOR_FIX_MASK)) {
            s.append("MSB ");
        }
        if (hasCapability(UPDATE_NETWORK_STATE)) {
            s.append("MSA ");
        }
        if (hasCapability(LOCATION_HAS_BEARING)) {
            s.append("SINGLE_SHOT ");
        }
        if (hasCapability(LOCATION_HAS_ACCURACY)) {
            s.append("ON_DEMAND_TIME ");
        }
        s.append(")\n");
        s.append(native_get_internal_state());
        pw.append(s);
    }
}
