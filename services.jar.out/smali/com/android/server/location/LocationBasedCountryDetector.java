package com.android.server.location;

import android.content.Context;
import android.location.Address;
import android.location.Country;
import android.location.Geocoder;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.util.Slog;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

public class LocationBasedCountryDetector extends CountryDetectorBase {
    private static final long QUERY_LOCATION_TIMEOUT = 300000;
    private static final String TAG = "LocationBasedCountryDetector";
    private List<String> mEnabledProviders;
    protected List<LocationListener> mLocationListeners;
    private LocationManager mLocationManager;
    protected Thread mQueryThread;
    protected Timer mTimer;

    /* renamed from: com.android.server.location.LocationBasedCountryDetector.1 */
    class C03681 implements LocationListener {
        C03681() {
        }

        public void onLocationChanged(Location location) {
            if (location != null) {
                LocationBasedCountryDetector.this.stop();
                LocationBasedCountryDetector.this.queryCountryCode(location);
            }
        }

        public void onProviderDisabled(String provider) {
        }

        public void onProviderEnabled(String provider) {
        }

        public void onStatusChanged(String provider, int status, Bundle extras) {
        }
    }

    /* renamed from: com.android.server.location.LocationBasedCountryDetector.2 */
    class C03692 extends TimerTask {
        C03692() {
        }

        public void run() {
            LocationBasedCountryDetector.this.mTimer = null;
            LocationBasedCountryDetector.this.stop();
            LocationBasedCountryDetector.this.queryCountryCode(LocationBasedCountryDetector.this.getLastKnownLocation());
        }
    }

    /* renamed from: com.android.server.location.LocationBasedCountryDetector.3 */
    class C03703 implements Runnable {
        final /* synthetic */ Location val$location;

        C03703(Location location) {
            this.val$location = location;
        }

        public void run() {
            String countryIso = null;
            if (this.val$location != null) {
                countryIso = LocationBasedCountryDetector.this.getCountryFromLocation(this.val$location);
            }
            if (countryIso != null) {
                LocationBasedCountryDetector.this.mDetectedCountry = new Country(countryIso, 1);
            } else {
                LocationBasedCountryDetector.this.mDetectedCountry = null;
            }
            LocationBasedCountryDetector.this.notifyListener(LocationBasedCountryDetector.this.mDetectedCountry);
            LocationBasedCountryDetector.this.mQueryThread = null;
        }
    }

    public LocationBasedCountryDetector(Context ctx) {
        super(ctx);
        this.mLocationManager = (LocationManager) ctx.getSystemService("location");
    }

    protected String getCountryFromLocation(Location location) {
        String country = null;
        try {
            List<Address> addresses = new Geocoder(this.mContext).getFromLocation(location.getLatitude(), location.getLongitude(), 1);
            if (addresses != null && addresses.size() > 0) {
                country = ((Address) addresses.get(0)).getCountryCode();
            }
        } catch (IOException e) {
            Slog.w(TAG, "Exception occurs when getting country from location");
        }
        return country;
    }

    protected boolean isAcceptableProvider(String provider) {
        return "passive".equals(provider);
    }

    protected void registerListener(String provider, LocationListener listener) {
        this.mLocationManager.requestLocationUpdates(provider, 0, 0.0f, listener);
    }

    protected void unregisterListener(LocationListener listener) {
        this.mLocationManager.removeUpdates(listener);
    }

    protected Location getLastKnownLocation() {
        Location bestLocation = null;
        for (String provider : this.mLocationManager.getAllProviders()) {
            Location lastKnownLocation = this.mLocationManager.getLastKnownLocation(provider);
            if (lastKnownLocation != null && (bestLocation == null || bestLocation.getElapsedRealtimeNanos() < lastKnownLocation.getElapsedRealtimeNanos())) {
                bestLocation = lastKnownLocation;
            }
        }
        return bestLocation;
    }

    protected long getQueryLocationTimeout() {
        return QUERY_LOCATION_TIMEOUT;
    }

    protected List<String> getEnabledProviders() {
        if (this.mEnabledProviders == null) {
            this.mEnabledProviders = this.mLocationManager.getProviders(true);
        }
        return this.mEnabledProviders;
    }

    public synchronized Country detectCountry() {
        if (this.mLocationListeners != null) {
            throw new IllegalStateException();
        }
        List<String> enabledProviders = getEnabledProviders();
        int totalProviders = enabledProviders.size();
        if (totalProviders > 0) {
            this.mLocationListeners = new ArrayList(totalProviders);
            for (int i = 0; i < totalProviders; i++) {
                String provider = (String) enabledProviders.get(i);
                if (isAcceptableProvider(provider)) {
                    LocationListener listener = new C03681();
                    this.mLocationListeners.add(listener);
                    registerListener(provider, listener);
                }
            }
            this.mTimer = new Timer();
            this.mTimer.schedule(new C03692(), getQueryLocationTimeout());
        } else {
            queryCountryCode(getLastKnownLocation());
        }
        return this.mDetectedCountry;
    }

    public synchronized void stop() {
        if (this.mLocationListeners != null) {
            for (LocationListener listener : this.mLocationListeners) {
                unregisterListener(listener);
            }
            this.mLocationListeners = null;
        }
        if (this.mTimer != null) {
            this.mTimer.cancel();
            this.mTimer = null;
        }
    }

    private synchronized void queryCountryCode(Location location) {
        if (location == null) {
            notifyListener(null);
        } else if (this.mQueryThread == null) {
            this.mQueryThread = new Thread(new C03703(location));
            this.mQueryThread.start();
        }
    }
}
