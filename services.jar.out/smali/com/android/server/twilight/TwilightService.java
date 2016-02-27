package com.android.server.twilight;

import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.location.Criteria;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.SystemClock;
import android.text.format.Time;
import com.android.server.SystemService;
import com.android.server.TwilightCalculator;
import java.util.ArrayList;
import libcore.util.Objects;

public final class TwilightService extends SystemService {
    static final String ACTION_UPDATE_TWILIGHT_STATE = "com.android.server.action.UPDATE_TWILIGHT_STATE";
    static final boolean DEBUG = false;
    static final String TAG = "TwilightService";
    AlarmManager mAlarmManager;
    private final LocationListener mEmptyLocationListener;
    final ArrayList<TwilightListenerRecord> mListeners;
    LocationHandler mLocationHandler;
    private final LocationListener mLocationListener;
    LocationManager mLocationManager;
    final Object mLock;
    private final TwilightManager mService;
    TwilightState mTwilightState;
    private final BroadcastReceiver mUpdateLocationReceiver;

    /* renamed from: com.android.server.twilight.TwilightService.1 */
    class C05341 implements TwilightManager {
        C05341() {
        }

        public TwilightState getCurrentState() {
            TwilightState twilightState;
            synchronized (TwilightService.this.mLock) {
                twilightState = TwilightService.this.mTwilightState;
            }
            return twilightState;
        }

        public void registerListener(TwilightListener listener, Handler handler) {
            synchronized (TwilightService.this.mLock) {
                TwilightService.this.mListeners.add(new TwilightListenerRecord(listener, handler));
                if (TwilightService.this.mListeners.size() == 1) {
                    TwilightService.this.mLocationHandler.enableLocationUpdates();
                }
            }
        }
    }

    /* renamed from: com.android.server.twilight.TwilightService.2 */
    class C05352 extends BroadcastReceiver {
        C05352() {
        }

        public void onReceive(Context context, Intent intent) {
            if (!"android.intent.action.AIRPLANE_MODE".equals(intent.getAction()) || intent.getBooleanExtra("state", TwilightService.DEBUG)) {
                TwilightService.this.mLocationHandler.requestTwilightUpdate();
            } else {
                TwilightService.this.mLocationHandler.requestLocationUpdate();
            }
        }
    }

    /* renamed from: com.android.server.twilight.TwilightService.3 */
    class C05363 implements LocationListener {
        C05363() {
        }

        public void onLocationChanged(Location location) {
        }

        public void onProviderDisabled(String provider) {
        }

        public void onProviderEnabled(String provider) {
        }

        public void onStatusChanged(String provider, int status, Bundle extras) {
        }
    }

    /* renamed from: com.android.server.twilight.TwilightService.4 */
    class C05374 implements LocationListener {
        C05374() {
        }

        public void onLocationChanged(Location location) {
            TwilightService.this.mLocationHandler.processNewLocation(location);
        }

        public void onProviderDisabled(String provider) {
        }

        public void onProviderEnabled(String provider) {
        }

        public void onStatusChanged(String provider, int status, Bundle extras) {
        }
    }

    private final class LocationHandler extends Handler {
        private static final double FACTOR_GMT_OFFSET_LONGITUDE = 0.004166666666666667d;
        private static final float LOCATION_UPDATE_DISTANCE_METER = 20000.0f;
        private static final long LOCATION_UPDATE_ENABLE_INTERVAL_MAX = 900000;
        private static final long LOCATION_UPDATE_ENABLE_INTERVAL_MIN = 5000;
        private static final long LOCATION_UPDATE_MS = 86400000;
        private static final long MIN_LOCATION_UPDATE_MS = 1800000;
        private static final int MSG_DO_TWILIGHT_UPDATE = 4;
        private static final int MSG_ENABLE_LOCATION_UPDATES = 1;
        private static final int MSG_GET_NEW_LOCATION_UPDATE = 2;
        private static final int MSG_PROCESS_NEW_LOCATION = 3;
        private boolean mDidFirstInit;
        private long mLastNetworkRegisterTime;
        private long mLastUpdateInterval;
        private Location mLocation;
        private boolean mNetworkListenerEnabled;
        private boolean mPassiveListenerEnabled;
        private final TwilightCalculator mTwilightCalculator;

        private LocationHandler() {
            this.mLastNetworkRegisterTime = -1800000;
            this.mTwilightCalculator = new TwilightCalculator();
        }

        public void processNewLocation(Location location) {
            sendMessage(obtainMessage(MSG_PROCESS_NEW_LOCATION, location));
        }

        public void enableLocationUpdates() {
            sendEmptyMessage(MSG_ENABLE_LOCATION_UPDATES);
        }

        public void requestLocationUpdate() {
            sendEmptyMessage(MSG_GET_NEW_LOCATION_UPDATE);
        }

        public void requestTwilightUpdate() {
            sendEmptyMessage(MSG_DO_TWILIGHT_UPDATE);
        }

        public void handleMessage(Message msg) {
            boolean networkLocationEnabled;
            boolean passiveLocationEnabled;
            switch (msg.what) {
                case MSG_ENABLE_LOCATION_UPDATES /*1*/:
                    break;
                case MSG_GET_NEW_LOCATION_UPDATE /*2*/:
                    if (this.mNetworkListenerEnabled && this.mLastNetworkRegisterTime + MIN_LOCATION_UPDATE_MS < SystemClock.elapsedRealtime()) {
                        this.mNetworkListenerEnabled = TwilightService.DEBUG;
                        TwilightService.this.mLocationManager.removeUpdates(TwilightService.this.mEmptyLocationListener);
                        break;
                    }
                    return;
                    break;
                case MSG_PROCESS_NEW_LOCATION /*3*/:
                    Location location = msg.obj;
                    boolean hasMoved = TwilightService.hasMoved(this.mLocation, location);
                    boolean hasBetterAccuracy = (this.mLocation == null || location.getAccuracy() < this.mLocation.getAccuracy()) ? true : TwilightService.DEBUG;
                    if (hasMoved || hasBetterAccuracy) {
                        setLocation(location);
                        return;
                    }
                    return;
                case MSG_DO_TWILIGHT_UPDATE /*4*/:
                    updateTwilightState();
                    return;
                default:
                    return;
            }
            try {
                networkLocationEnabled = TwilightService.this.mLocationManager.isProviderEnabled("network");
            } catch (Exception e) {
                networkLocationEnabled = TwilightService.DEBUG;
            }
            if (!this.mNetworkListenerEnabled && networkLocationEnabled) {
                this.mNetworkListenerEnabled = true;
                this.mLastNetworkRegisterTime = SystemClock.elapsedRealtime();
                TwilightService.this.mLocationManager.requestLocationUpdates("network", LOCATION_UPDATE_MS, 0.0f, TwilightService.this.mEmptyLocationListener);
                if (!this.mDidFirstInit) {
                    this.mDidFirstInit = true;
                    if (this.mLocation == null) {
                        retrieveLocation();
                    }
                }
            }
            try {
                passiveLocationEnabled = TwilightService.this.mLocationManager.isProviderEnabled("passive");
            } catch (Exception e2) {
                passiveLocationEnabled = TwilightService.DEBUG;
            }
            if (!this.mPassiveListenerEnabled && passiveLocationEnabled) {
                this.mPassiveListenerEnabled = true;
                TwilightService.this.mLocationManager.requestLocationUpdates("passive", 0, LOCATION_UPDATE_DISTANCE_METER, TwilightService.this.mLocationListener);
            }
            if (!this.mNetworkListenerEnabled || !this.mPassiveListenerEnabled) {
                this.mLastUpdateInterval = (long) (((double) this.mLastUpdateInterval) * 1.5d);
                if (this.mLastUpdateInterval == 0) {
                    this.mLastUpdateInterval = LOCATION_UPDATE_ENABLE_INTERVAL_MIN;
                } else if (this.mLastUpdateInterval > LOCATION_UPDATE_ENABLE_INTERVAL_MAX) {
                    this.mLastUpdateInterval = LOCATION_UPDATE_ENABLE_INTERVAL_MAX;
                }
                sendEmptyMessageDelayed(MSG_ENABLE_LOCATION_UPDATES, this.mLastUpdateInterval);
            }
        }

        private void retrieveLocation() {
            Location location = null;
            for (String lastKnownLocation : TwilightService.this.mLocationManager.getProviders(new Criteria(), true)) {
                Location lastKnownLocation2 = TwilightService.this.mLocationManager.getLastKnownLocation(lastKnownLocation);
                if (location == null || (lastKnownLocation2 != null && location.getElapsedRealtimeNanos() < lastKnownLocation2.getElapsedRealtimeNanos())) {
                    location = lastKnownLocation2;
                }
            }
            if (location == null) {
                Time currentTime = new Time();
                currentTime.set(System.currentTimeMillis());
                double lngOffset = FACTOR_GMT_OFFSET_LONGITUDE * ((double) (currentTime.gmtoff - ((long) (currentTime.isDst > 0 ? 3600 : 0))));
                location = new Location("fake");
                location.setLongitude(lngOffset);
                location.setLatitude(0.0d);
                location.setAccuracy(417000.0f);
                location.setTime(System.currentTimeMillis());
                location.setElapsedRealtimeNanos(SystemClock.elapsedRealtimeNanos());
            }
            setLocation(location);
        }

        private void setLocation(Location location) {
            this.mLocation = location;
            updateTwilightState();
        }

        private void updateTwilightState() {
            if (this.mLocation == null) {
                TwilightService.this.setTwilightState(null);
                return;
            }
            long nextUpdate;
            long now = System.currentTimeMillis();
            this.mTwilightCalculator.calculateTwilight(now - LOCATION_UPDATE_MS, this.mLocation.getLatitude(), this.mLocation.getLongitude());
            long yesterdaySunset = this.mTwilightCalculator.mSunset;
            this.mTwilightCalculator.calculateTwilight(now, this.mLocation.getLatitude(), this.mLocation.getLongitude());
            boolean isNight = this.mTwilightCalculator.mState == MSG_ENABLE_LOCATION_UPDATES ? true : TwilightService.DEBUG;
            long todaySunrise = this.mTwilightCalculator.mSunrise;
            long todaySunset = this.mTwilightCalculator.mSunset;
            this.mTwilightCalculator.calculateTwilight(LOCATION_UPDATE_MS + now, this.mLocation.getLatitude(), this.mLocation.getLongitude());
            long tomorrowSunrise = this.mTwilightCalculator.mSunrise;
            TwilightService.this.setTwilightState(new TwilightState(isNight, yesterdaySunset, todaySunrise, todaySunset, tomorrowSunrise));
            if (todaySunrise == -1 || todaySunset == -1) {
                nextUpdate = now + 43200000;
            } else {
                nextUpdate = 0 + 60000;
                if (now > todaySunset) {
                    nextUpdate += tomorrowSunrise;
                } else if (now > todaySunrise) {
                    nextUpdate += todaySunset;
                } else {
                    nextUpdate += todaySunrise;
                }
            }
            PendingIntent pendingIntent = PendingIntent.getBroadcast(TwilightService.this.getContext(), 0, new Intent(TwilightService.ACTION_UPDATE_TWILIGHT_STATE), 0);
            TwilightService.this.mAlarmManager.cancel(pendingIntent);
            TwilightService.this.mAlarmManager.setExact(MSG_ENABLE_LOCATION_UPDATES, nextUpdate, pendingIntent);
        }
    }

    private static class TwilightListenerRecord implements Runnable {
        private final Handler mHandler;
        private final TwilightListener mListener;

        public TwilightListenerRecord(TwilightListener listener, Handler handler) {
            this.mListener = listener;
            this.mHandler = handler;
        }

        public void postUpdate() {
            this.mHandler.post(this);
        }

        public void run() {
            this.mListener.onTwilightStateChanged();
        }
    }

    public TwilightService(Context context) {
        super(context);
        this.mLock = new Object();
        this.mListeners = new ArrayList();
        this.mService = new C05341();
        this.mUpdateLocationReceiver = new C05352();
        this.mEmptyLocationListener = new C05363();
        this.mLocationListener = new C05374();
    }

    public void onStart() {
        this.mAlarmManager = (AlarmManager) getContext().getSystemService("alarm");
        this.mLocationManager = (LocationManager) getContext().getSystemService("location");
        this.mLocationHandler = new LocationHandler();
        IntentFilter filter = new IntentFilter("android.intent.action.AIRPLANE_MODE");
        filter.addAction("android.intent.action.TIME_SET");
        filter.addAction("android.intent.action.TIMEZONE_CHANGED");
        filter.addAction(ACTION_UPDATE_TWILIGHT_STATE);
        getContext().registerReceiver(this.mUpdateLocationReceiver, filter);
        publishLocalService(TwilightManager.class, this.mService);
    }

    private void setTwilightState(TwilightState state) {
        synchronized (this.mLock) {
            if (!Objects.equal(this.mTwilightState, state)) {
                this.mTwilightState = state;
                int listenerLen = this.mListeners.size();
                for (int i = 0; i < listenerLen; i++) {
                    ((TwilightListenerRecord) this.mListeners.get(i)).postUpdate();
                }
            }
        }
    }

    private static boolean hasMoved(Location from, Location to) {
        boolean z = true;
        if (to == null) {
            return DEBUG;
        }
        if (from == null) {
            return true;
        }
        if (to.getElapsedRealtimeNanos() < from.getElapsedRealtimeNanos()) {
            return DEBUG;
        }
        if (from.distanceTo(to) < from.getAccuracy() + to.getAccuracy()) {
            z = DEBUG;
        }
        return z;
    }
}
