package com.android.server;

import android.util.FloatMath;

public class TwilightCalculator {
    private static final float ALTIDUTE_CORRECTION_CIVIL_TWILIGHT = -0.10471976f;
    private static final float C1 = 0.0334196f;
    private static final float C2 = 3.49066E-4f;
    private static final float C3 = 5.236E-6f;
    public static final int DAY = 0;
    private static final float DEGREES_TO_RADIANS = 0.017453292f;
    private static final float J0 = 9.0E-4f;
    public static final int NIGHT = 1;
    private static final float OBLIQUITY = 0.4092797f;
    private static final long UTC_2000 = 946728000000L;
    public int mState;
    public long mSunrise;
    public long mSunset;

    public void calculateTwilight(long time, double latiude, double longitude) {
        float daysSince2000 = ((float) (time - UTC_2000)) / 8.64E7f;
        float meanAnomaly = 6.24006f + (0.01720197f * daysSince2000);
        float solarLng = (1.7965931f + ((((C1 * FloatMath.sin(meanAnomaly)) + meanAnomaly) + (C2 * FloatMath.sin(2.0f * meanAnomaly))) + (C3 * FloatMath.sin(3.0f * meanAnomaly)))) + 3.1415927f;
        double arcLongitude = (-longitude) / 360.0d;
        double sin = (double) (0.0053f * FloatMath.sin(meanAnomaly));
        sin = (double) (-0.0069f * FloatMath.sin(2.0f * solarLng));
        double solarTransitJ2000 = ((((double) (J0 + ((float) Math.round(((double) (daysSince2000 - J0)) - arcLongitude)))) + arcLongitude) + r0) + r0;
        double solarDec = Math.asin((double) (FloatMath.sin(solarLng) * FloatMath.sin(OBLIQUITY)));
        double latRad = latiude * 0.01745329238474369d;
        double cosHourAngle = (((double) FloatMath.sin(ALTIDUTE_CORRECTION_CIVIL_TWILIGHT)) - (Math.sin(latRad) * Math.sin(solarDec))) / (Math.cos(latRad) * Math.cos(solarDec));
        if (cosHourAngle >= 1.0d) {
            this.mState = NIGHT;
            this.mSunset = -1;
            this.mSunrise = -1;
        } else if (cosHourAngle <= -1.0d) {
            this.mState = DAY;
            this.mSunset = -1;
            this.mSunrise = -1;
        } else {
            float hourAngle = (float) (Math.acos(cosHourAngle) / 6.283185307179586d);
            this.mSunset = Math.round((((double) hourAngle) + solarTransitJ2000) * 8.64E7d) + UTC_2000;
            this.mSunrise = Math.round((solarTransitJ2000 - ((double) hourAngle)) * 8.64E7d) + UTC_2000;
            if (this.mSunrise < time) {
                if (this.mSunset > time) {
                    this.mState = DAY;
                    return;
                }
            }
            this.mState = NIGHT;
        }
    }
}
