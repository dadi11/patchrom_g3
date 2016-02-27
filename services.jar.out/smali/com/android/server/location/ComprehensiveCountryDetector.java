package com.android.server.location;

import android.content.Context;
import android.location.Country;
import android.location.CountryListener;
import android.location.Geocoder;
import android.os.SystemClock;
import android.provider.Settings.Global;
import android.telephony.PhoneStateListener;
import android.telephony.ServiceState;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.util.Slog;
import java.util.Iterator;
import java.util.Locale;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.ConcurrentLinkedQueue;

public class ComprehensiveCountryDetector extends CountryDetectorBase {
    static final boolean DEBUG = false;
    private static final long LOCATION_REFRESH_INTERVAL = 86400000;
    private static final int MAX_LENGTH_DEBUG_LOGS = 20;
    private static final String TAG = "CountryDetector";
    private int mCountServiceStateChanges;
    private Country mCountry;
    private Country mCountryFromLocation;
    private final ConcurrentLinkedQueue<Country> mDebugLogs;
    private Country mLastCountryAddedToLogs;
    private CountryListener mLocationBasedCountryDetectionListener;
    protected CountryDetectorBase mLocationBasedCountryDetector;
    protected Timer mLocationRefreshTimer;
    private final Object mObject;
    private PhoneStateListener mPhoneStateListener;
    private long mStartTime;
    private long mStopTime;
    private boolean mStopped;
    private final TelephonyManager mTelephonyManager;
    private int mTotalCountServiceStateChanges;
    private long mTotalTime;

    /* renamed from: com.android.server.location.ComprehensiveCountryDetector.1 */
    class C03391 implements CountryListener {
        C03391() {
        }

        public void onCountryDetected(Country country) {
            ComprehensiveCountryDetector.this.mCountryFromLocation = country;
            ComprehensiveCountryDetector.this.detectCountry(true, ComprehensiveCountryDetector.DEBUG);
            ComprehensiveCountryDetector.this.stopLocationBasedDetector();
        }
    }

    /* renamed from: com.android.server.location.ComprehensiveCountryDetector.2 */
    class C03402 implements Runnable {
        final /* synthetic */ Country val$country;
        final /* synthetic */ Country val$detectedCountry;
        final /* synthetic */ boolean val$notifyChange;
        final /* synthetic */ boolean val$startLocationBasedDetection;

        C03402(Country country, Country country2, boolean z, boolean z2) {
            this.val$country = country;
            this.val$detectedCountry = country2;
            this.val$notifyChange = z;
            this.val$startLocationBasedDetection = z2;
        }

        public void run() {
            ComprehensiveCountryDetector.this.runAfterDetection(this.val$country, this.val$detectedCountry, this.val$notifyChange, this.val$startLocationBasedDetection);
        }
    }

    /* renamed from: com.android.server.location.ComprehensiveCountryDetector.3 */
    class C03413 extends TimerTask {
        C03413() {
        }

        public void run() {
            ComprehensiveCountryDetector.this.mLocationRefreshTimer = null;
            ComprehensiveCountryDetector.this.detectCountry(ComprehensiveCountryDetector.DEBUG, true);
        }
    }

    /* renamed from: com.android.server.location.ComprehensiveCountryDetector.4 */
    class C03424 extends PhoneStateListener {
        C03424() {
        }

        public void onServiceStateChanged(ServiceState serviceState) {
            ComprehensiveCountryDetector.this.mCountServiceStateChanges = ComprehensiveCountryDetector.this.mCountServiceStateChanges + 1;
            ComprehensiveCountryDetector.this.mTotalCountServiceStateChanges = ComprehensiveCountryDetector.this.mTotalCountServiceStateChanges + 1;
            if (ComprehensiveCountryDetector.this.isNetworkCountryCodeAvailable()) {
                ComprehensiveCountryDetector.this.detectCountry(true, true);
            }
        }
    }

    public ComprehensiveCountryDetector(Context context) {
        super(context);
        this.mStopped = DEBUG;
        this.mDebugLogs = new ConcurrentLinkedQueue();
        this.mObject = new Object();
        this.mLocationBasedCountryDetectionListener = new C03391();
        this.mTelephonyManager = (TelephonyManager) context.getSystemService("phone");
    }

    public Country detectCountry() {
        return detectCountry(DEBUG, !this.mStopped ? true : DEBUG);
    }

    public void stop() {
        Slog.i(TAG, "Stop the detector.");
        cancelLocationRefresh();
        removePhoneStateListener();
        stopLocationBasedDetector();
        this.mListener = null;
        this.mStopped = true;
    }

    private Country getCountry() {
        Country result = getNetworkBasedCountry();
        if (result == null) {
            result = getLastKnownLocationBasedCountry();
        }
        if (result == null) {
            result = getSimBasedCountry();
        }
        if (result == null) {
            result = getLocaleCountry();
        }
        addToLogs(result);
        return result;
    }

    private void addToLogs(Country country) {
        if (country != null) {
            synchronized (this.mObject) {
                if (this.mLastCountryAddedToLogs == null || !this.mLastCountryAddedToLogs.equals(country)) {
                    this.mLastCountryAddedToLogs = country;
                    if (this.mDebugLogs.size() >= MAX_LENGTH_DEBUG_LOGS) {
                        this.mDebugLogs.poll();
                    }
                    this.mDebugLogs.add(country);
                    return;
                }
            }
        }
    }

    private boolean isNetworkCountryCodeAvailable() {
        if (this.mTelephonyManager.getPhoneType() == 1) {
            return true;
        }
        return DEBUG;
    }

    protected Country getNetworkBasedCountry() {
        if (isNetworkCountryCodeAvailable()) {
            String countryIso = this.mTelephonyManager.getNetworkCountryIso();
            if (!TextUtils.isEmpty(countryIso)) {
                return new Country(countryIso, 0);
            }
        }
        return null;
    }

    protected Country getLastKnownLocationBasedCountry() {
        return this.mCountryFromLocation;
    }

    protected Country getSimBasedCountry() {
        String countryIso = this.mTelephonyManager.getSimCountryIso();
        if (TextUtils.isEmpty(countryIso)) {
            return null;
        }
        return new Country(countryIso, 2);
    }

    protected Country getLocaleCountry() {
        Locale defaultLocale = Locale.getDefault();
        if (defaultLocale != null) {
            return new Country(defaultLocale.getCountry(), 3);
        }
        return null;
    }

    private Country detectCountry(boolean notifyChange, boolean startLocationBasedDetection) {
        Country country = getCountry();
        runAfterDetectionAsync(this.mCountry != null ? new Country(this.mCountry) : this.mCountry, country, notifyChange, startLocationBasedDetection);
        this.mCountry = country;
        return this.mCountry;
    }

    protected void runAfterDetectionAsync(Country country, Country detectedCountry, boolean notifyChange, boolean startLocationBasedDetection) {
        this.mHandler.post(new C03402(country, detectedCountry, notifyChange, startLocationBasedDetection));
    }

    public void setCountryListener(CountryListener listener) {
        CountryListener prevListener = this.mListener;
        this.mListener = listener;
        if (this.mListener == null) {
            removePhoneStateListener();
            stopLocationBasedDetector();
            cancelLocationRefresh();
            this.mStopTime = SystemClock.elapsedRealtime();
            this.mTotalTime += this.mStopTime;
        } else if (prevListener == null) {
            addPhoneStateListener();
            detectCountry(DEBUG, true);
            this.mStartTime = SystemClock.elapsedRealtime();
            this.mStopTime = 0;
            this.mCountServiceStateChanges = 0;
        }
    }

    void runAfterDetection(Country country, Country detectedCountry, boolean notifyChange, boolean startLocationBasedDetection) {
        if (notifyChange) {
            notifyIfCountryChanged(country, detectedCountry);
        }
        if (startLocationBasedDetection && ((detectedCountry == null || detectedCountry.getSource() > 1) && isAirplaneModeOff() && this.mListener != null && isGeoCoderImplemented())) {
            startLocationBasedDetector(this.mLocationBasedCountryDetectionListener);
        }
        if (detectedCountry == null || detectedCountry.getSource() >= 1) {
            scheduleLocationRefresh();
            return;
        }
        cancelLocationRefresh();
        stopLocationBasedDetector();
    }

    private synchronized void startLocationBasedDetector(CountryListener listener) {
        if (this.mLocationBasedCountryDetector == null) {
            this.mLocationBasedCountryDetector = createLocationBasedCountryDetector();
            this.mLocationBasedCountryDetector.setCountryListener(listener);
            this.mLocationBasedCountryDetector.detectCountry();
        }
    }

    private synchronized void stopLocationBasedDetector() {
        if (this.mLocationBasedCountryDetector != null) {
            this.mLocationBasedCountryDetector.stop();
            this.mLocationBasedCountryDetector = null;
        }
    }

    protected CountryDetectorBase createLocationBasedCountryDetector() {
        return new LocationBasedCountryDetector(this.mContext);
    }

    protected boolean isAirplaneModeOff() {
        return Global.getInt(this.mContext.getContentResolver(), "airplane_mode_on", 0) == 0 ? true : DEBUG;
    }

    private void notifyIfCountryChanged(Country country, Country detectedCountry) {
        if (detectedCountry != null && this.mListener != null) {
            if (country == null || !country.equals(detectedCountry)) {
                notifyListener(detectedCountry);
            }
        }
    }

    private synchronized void scheduleLocationRefresh() {
        if (this.mLocationRefreshTimer == null) {
            this.mLocationRefreshTimer = new Timer();
            this.mLocationRefreshTimer.schedule(new C03413(), LOCATION_REFRESH_INTERVAL);
        }
    }

    private synchronized void cancelLocationRefresh() {
        if (this.mLocationRefreshTimer != null) {
            this.mLocationRefreshTimer.cancel();
            this.mLocationRefreshTimer = null;
        }
    }

    protected synchronized void addPhoneStateListener() {
        if (this.mPhoneStateListener == null) {
            this.mPhoneStateListener = new C03424();
            this.mTelephonyManager.listen(this.mPhoneStateListener, 1);
        }
    }

    protected synchronized void removePhoneStateListener() {
        if (this.mPhoneStateListener != null) {
            this.mTelephonyManager.listen(this.mPhoneStateListener, 0);
            this.mPhoneStateListener = null;
        }
    }

    protected boolean isGeoCoderImplemented() {
        return Geocoder.isPresent();
    }

    public String toString() {
        long currentTime = SystemClock.elapsedRealtime();
        long currentSessionLength = 0;
        StringBuilder sb = new StringBuilder();
        sb.append("ComprehensiveCountryDetector{");
        if (this.mStopTime == 0) {
            currentSessionLength = currentTime - this.mStartTime;
            sb.append("timeRunning=" + currentSessionLength + ", ");
        } else {
            sb.append("lastRunTimeLength=" + (this.mStopTime - this.mStartTime) + ", ");
        }
        sb.append("totalCountServiceStateChanges=" + this.mTotalCountServiceStateChanges + ", ");
        sb.append("currentCountServiceStateChanges=" + this.mCountServiceStateChanges + ", ");
        sb.append("totalTime=" + (this.mTotalTime + currentSessionLength) + ", ");
        sb.append("currentTime=" + currentTime + ", ");
        sb.append("countries=");
        Iterator i$ = this.mDebugLogs.iterator();
        while (i$.hasNext()) {
            sb.append("\n   " + ((Country) i$.next()).toString());
        }
        sb.append("}");
        return sb.toString();
    }
}
