package com.android.server.display;

import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.PowerManager;
import android.os.SystemClock;
import android.util.MathUtils;
import android.util.Slog;
import android.util.Spline;
import android.util.TimeUtils;
import com.android.server.LocalServices;
import com.android.server.twilight.TwilightListener;
import com.android.server.twilight.TwilightManager;
import com.android.server.twilight.TwilightState;
import com.android.server.wm.WindowManagerService;
import java.io.PrintWriter;
import java.util.Arrays;

class AutomaticBrightnessController {
    private static final int AMBIENT_LIGHT_HORIZON = 10000;
    private static final long AMBIENT_LIGHT_PREDICTION_TIME_MILLIS = 100;
    private static final float BRIGHTENING_LIGHT_HYSTERESIS = 0.1f;
    private static final float DARKENING_LIGHT_HYSTERESIS = 0.2f;
    private static final boolean DEBUG = false;
    private static final boolean DEBUG_PRETEND_LIGHT_SENSOR_ABSENT = false;
    private static final int MSG_UPDATE_AMBIENT_LUX = 1;
    private static final float SCREEN_AUTO_BRIGHTNESS_ADJUSTMENT_MAX_GAMMA = 3.0f;
    private static final String TAG = "AutomaticBrightnessController";
    private static final float TWILIGHT_ADJUSTMENT_MAX_GAMMA = 1.5f;
    private static final long TWILIGHT_ADJUSTMENT_TIME = 7200000;
    private static final boolean USE_SCREEN_AUTO_BRIGHTNESS_ADJUSTMENT = true;
    private static final boolean USE_TWILIGHT_ADJUSTMENT;
    private static final int WEIGHTING_INTERCEPT = 10000;
    private AmbientLightRingBuffer mAmbientLightRingBuffer;
    private float mAmbientLux;
    private boolean mAmbientLuxValid;
    private final long mBrighteningLightDebounceConfig;
    private float mBrighteningLuxThreshold;
    private final Callbacks mCallbacks;
    private final long mDarkeningLightDebounceConfig;
    private float mDarkeningLuxThreshold;
    private final float mDozeScaleFactor;
    private boolean mDozing;
    private AutomaticBrightnessHandler mHandler;
    private float mLastObservedLux;
    private long mLastObservedLuxTime;
    private float mLastScreenAutoBrightnessGamma;
    private final Sensor mLightSensor;
    private long mLightSensorEnableTime;
    private boolean mLightSensorEnabled;
    private final SensorEventListener mLightSensorListener;
    private final int mLightSensorRate;
    private int mLightSensorWarmUpTimeConfig;
    private int mRecentLightSamples;
    private final boolean mResetAmbientLuxAfterWarmUpConfig;
    private int mScreenAutoBrightness;
    private float mScreenAutoBrightnessAdjustment;
    private final Spline mScreenAutoBrightnessSpline;
    private final int mScreenBrightnessRangeMaximum;
    private final int mScreenBrightnessRangeMinimum;
    private final SensorManager mSensorManager;
    private final TwilightManager mTwilight;
    private final TwilightListener mTwilightListener;

    /* renamed from: com.android.server.display.AutomaticBrightnessController.1 */
    class C01911 implements SensorEventListener {
        C01911() {
        }

        public void onSensorChanged(SensorEvent event) {
            if (AutomaticBrightnessController.this.mLightSensorEnabled) {
                AutomaticBrightnessController.this.handleLightSensorEvent(SystemClock.uptimeMillis(), event.values[0]);
            }
        }

        public void onAccuracyChanged(Sensor sensor, int accuracy) {
        }
    }

    /* renamed from: com.android.server.display.AutomaticBrightnessController.2 */
    class C01922 implements TwilightListener {
        C01922() {
        }

        public void onTwilightStateChanged() {
            AutomaticBrightnessController.this.updateAutoBrightness(AutomaticBrightnessController.USE_SCREEN_AUTO_BRIGHTNESS_ADJUSTMENT);
        }
    }

    private static final class AmbientLightRingBuffer {
        private static final float BUFFER_SLACK = 1.5f;
        private int mCapacity;
        private int mCount;
        private int mEnd;
        private float[] mRingLux;
        private long[] mRingTime;
        private int mStart;

        public AmbientLightRingBuffer(long lightSensorRate) {
            this((int) Math.ceil((double) (15000.0f / ((float) lightSensorRate))));
        }

        public AmbientLightRingBuffer(int initialCapacity) {
            this.mCapacity = initialCapacity;
            this.mRingLux = new float[this.mCapacity];
            this.mRingTime = new long[this.mCapacity];
        }

        public float getLux(int index) {
            return this.mRingLux[offsetOf(index)];
        }

        public long getTime(int index) {
            return this.mRingTime[offsetOf(index)];
        }

        public void push(long time, float lux) {
            int next = this.mEnd;
            if (this.mCount == this.mCapacity) {
                int newSize = this.mCapacity * 2;
                float[] newRingLux = new float[newSize];
                long[] newRingTime = new long[newSize];
                int length = this.mCapacity - this.mStart;
                System.arraycopy(this.mRingLux, this.mStart, newRingLux, 0, length);
                System.arraycopy(this.mRingTime, this.mStart, newRingTime, 0, length);
                if (this.mStart != 0) {
                    System.arraycopy(this.mRingLux, 0, newRingLux, length, this.mStart);
                    System.arraycopy(this.mRingTime, 0, newRingTime, length, this.mStart);
                }
                this.mRingLux = newRingLux;
                this.mRingTime = newRingTime;
                next = this.mCapacity;
                this.mCapacity = newSize;
                this.mStart = 0;
            }
            this.mRingTime[next] = time;
            this.mRingLux[next] = lux;
            this.mEnd = next + AutomaticBrightnessController.MSG_UPDATE_AMBIENT_LUX;
            if (this.mEnd == this.mCapacity) {
                this.mEnd = 0;
            }
            this.mCount += AutomaticBrightnessController.MSG_UPDATE_AMBIENT_LUX;
        }

        public void prune(long horizon) {
            if (this.mCount != 0) {
                while (this.mCount > AutomaticBrightnessController.MSG_UPDATE_AMBIENT_LUX) {
                    int next = this.mStart + AutomaticBrightnessController.MSG_UPDATE_AMBIENT_LUX;
                    if (next >= this.mCapacity) {
                        next -= this.mCapacity;
                    }
                    if (this.mRingTime[next] > horizon) {
                        break;
                    }
                    this.mStart = next;
                    this.mCount--;
                }
                if (this.mRingTime[this.mStart] < horizon) {
                    this.mRingTime[this.mStart] = horizon;
                }
            }
        }

        public int size() {
            return this.mCount;
        }

        public boolean isEmpty() {
            return this.mCount == 0 ? AutomaticBrightnessController.USE_SCREEN_AUTO_BRIGHTNESS_ADJUSTMENT : AutomaticBrightnessController.USE_TWILIGHT_ADJUSTMENT;
        }

        public void clear() {
            this.mStart = 0;
            this.mEnd = 0;
            this.mCount = 0;
        }

        public String toString() {
            int length = this.mCapacity - this.mStart;
            float[] lux = new float[this.mCount];
            long[] time = new long[this.mCount];
            if (this.mCount <= length) {
                System.arraycopy(this.mRingLux, this.mStart, lux, 0, this.mCount);
                System.arraycopy(this.mRingTime, this.mStart, time, 0, this.mCount);
            } else {
                System.arraycopy(this.mRingLux, this.mStart, lux, 0, length);
                System.arraycopy(this.mRingLux, 0, lux, length, this.mCount - length);
                System.arraycopy(this.mRingTime, this.mStart, time, 0, length);
                System.arraycopy(this.mRingTime, 0, time, length, this.mCount - length);
            }
            return "AmbientLightRingBuffer{mCapacity=" + this.mCapacity + ", mStart=" + this.mStart + ", mEnd=" + this.mEnd + ", mCount=" + this.mCount + ", mRingLux=" + Arrays.toString(lux) + ", mRingTime=" + Arrays.toString(time) + "}";
        }

        private int offsetOf(int index) {
            if (index >= this.mCount || index < 0) {
                throw new ArrayIndexOutOfBoundsException(index);
            }
            index += this.mStart;
            if (index >= this.mCapacity) {
                return index - this.mCapacity;
            }
            return index;
        }
    }

    private final class AutomaticBrightnessHandler extends Handler {
        public AutomaticBrightnessHandler(Looper looper) {
            super(looper, null, AutomaticBrightnessController.USE_SCREEN_AUTO_BRIGHTNESS_ADJUSTMENT);
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case AutomaticBrightnessController.MSG_UPDATE_AMBIENT_LUX /*1*/:
                    AutomaticBrightnessController.this.updateAmbientLux();
                default:
            }
        }
    }

    interface Callbacks {
        void updateBrightness();
    }

    static {
        USE_TWILIGHT_ADJUSTMENT = PowerManager.useTwilightAdjustmentFeature();
    }

    public AutomaticBrightnessController(Callbacks callbacks, Looper looper, SensorManager sensorManager, Spline autoBrightnessSpline, int lightSensorWarmUpTime, int brightnessMin, int brightnessMax, float dozeScaleFactor, int lightSensorRate, long brighteningLightDebounceConfig, long darkeningLightDebounceConfig, boolean resetAmbientLuxAfterWarmUpConfig) {
        this.mScreenAutoBrightness = -1;
        this.mScreenAutoBrightnessAdjustment = 0.0f;
        this.mLastScreenAutoBrightnessGamma = 1.0f;
        this.mLightSensorListener = new C01911();
        this.mTwilightListener = new C01922();
        this.mCallbacks = callbacks;
        this.mTwilight = (TwilightManager) LocalServices.getService(TwilightManager.class);
        this.mSensorManager = sensorManager;
        this.mScreenAutoBrightnessSpline = autoBrightnessSpline;
        this.mScreenBrightnessRangeMinimum = brightnessMin;
        this.mScreenBrightnessRangeMaximum = brightnessMax;
        this.mLightSensorWarmUpTimeConfig = lightSensorWarmUpTime;
        this.mDozeScaleFactor = dozeScaleFactor;
        this.mLightSensorRate = lightSensorRate;
        this.mBrighteningLightDebounceConfig = brighteningLightDebounceConfig;
        this.mDarkeningLightDebounceConfig = darkeningLightDebounceConfig;
        this.mResetAmbientLuxAfterWarmUpConfig = resetAmbientLuxAfterWarmUpConfig;
        this.mHandler = new AutomaticBrightnessHandler(looper);
        this.mAmbientLightRingBuffer = new AmbientLightRingBuffer(this.mLightSensorRate);
        this.mLightSensor = this.mSensorManager.getDefaultSensor(5);
        if (USE_TWILIGHT_ADJUSTMENT) {
            this.mTwilight.registerListener(this.mTwilightListener, this.mHandler);
        }
    }

    public int getAutomaticScreenBrightness() {
        if (this.mDozing) {
            return (int) (((float) this.mScreenAutoBrightness) * this.mDozeScaleFactor);
        }
        return this.mScreenAutoBrightness;
    }

    public void configure(boolean enable, float adjustment, boolean dozing) {
        boolean z;
        this.mDozing = dozing;
        if (!enable || dozing) {
            z = USE_TWILIGHT_ADJUSTMENT;
        } else {
            z = USE_SCREEN_AUTO_BRIGHTNESS_ADJUSTMENT;
        }
        if (setLightSensorEnabled(z) | setScreenAutoBrightnessAdjustment(adjustment)) {
            updateAutoBrightness(USE_TWILIGHT_ADJUSTMENT);
        }
    }

    public void dump(PrintWriter pw) {
        pw.println();
        pw.println("Automatic Brightness Controller Configuration:");
        pw.println("  mScreenAutoBrightnessSpline=" + this.mScreenAutoBrightnessSpline);
        pw.println("  mScreenBrightnessRangeMinimum=" + this.mScreenBrightnessRangeMinimum);
        pw.println("  mScreenBrightnessRangeMaximum=" + this.mScreenBrightnessRangeMaximum);
        pw.println("  mLightSensorWarmUpTimeConfig=" + this.mLightSensorWarmUpTimeConfig);
        pw.println("  mBrighteningLightDebounceConfig=" + this.mBrighteningLightDebounceConfig);
        pw.println("  mDarkeningLightDebounceConfig=" + this.mDarkeningLightDebounceConfig);
        pw.println("  mResetAmbientLuxAfterWarmUpConfig=" + this.mResetAmbientLuxAfterWarmUpConfig);
        pw.println();
        pw.println("Automatic Brightness Controller State:");
        pw.println("  mLightSensor=" + this.mLightSensor);
        pw.println("  mTwilight.getCurrentState()=" + this.mTwilight.getCurrentState());
        pw.println("  mLightSensorEnabled=" + this.mLightSensorEnabled);
        pw.println("  mLightSensorEnableTime=" + TimeUtils.formatUptime(this.mLightSensorEnableTime));
        pw.println("  mAmbientLux=" + this.mAmbientLux);
        pw.println("  mBrighteningLuxThreshold=" + this.mBrighteningLuxThreshold);
        pw.println("  mDarkeningLuxThreshold=" + this.mDarkeningLuxThreshold);
        pw.println("  mLastObservedLux=" + this.mLastObservedLux);
        pw.println("  mLastObservedLuxTime=" + TimeUtils.formatUptime(this.mLastObservedLuxTime));
        pw.println("  mRecentLightSamples=" + this.mRecentLightSamples);
        pw.println("  mAmbientLightRingBuffer=" + this.mAmbientLightRingBuffer);
        pw.println("  mScreenAutoBrightness=" + this.mScreenAutoBrightness);
        pw.println("  mScreenAutoBrightnessAdjustment=" + this.mScreenAutoBrightnessAdjustment);
        pw.println("  mLastScreenAutoBrightnessGamma=" + this.mLastScreenAutoBrightnessGamma);
        pw.println("  mDozing=" + this.mDozing);
    }

    private boolean setLightSensorEnabled(boolean enable) {
        if (enable) {
            if (!this.mLightSensorEnabled) {
                this.mLightSensorEnabled = USE_SCREEN_AUTO_BRIGHTNESS_ADJUSTMENT;
                this.mLightSensorEnableTime = SystemClock.uptimeMillis();
                this.mSensorManager.registerListener(this.mLightSensorListener, this.mLightSensor, this.mLightSensorRate * ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE, this.mHandler);
                return USE_SCREEN_AUTO_BRIGHTNESS_ADJUSTMENT;
            }
        } else if (this.mLightSensorEnabled) {
            this.mLightSensorEnabled = USE_TWILIGHT_ADJUSTMENT;
            this.mAmbientLuxValid = !this.mResetAmbientLuxAfterWarmUpConfig ? USE_SCREEN_AUTO_BRIGHTNESS_ADJUSTMENT : USE_TWILIGHT_ADJUSTMENT;
            this.mRecentLightSamples = 0;
            this.mAmbientLightRingBuffer.clear();
            this.mHandler.removeMessages(MSG_UPDATE_AMBIENT_LUX);
            this.mSensorManager.unregisterListener(this.mLightSensorListener);
        }
        return USE_TWILIGHT_ADJUSTMENT;
    }

    private void handleLightSensorEvent(long time, float lux) {
        this.mHandler.removeMessages(MSG_UPDATE_AMBIENT_LUX);
        applyLightSensorMeasurement(time, lux);
        updateAmbientLux(time);
    }

    private void applyLightSensorMeasurement(long time, float lux) {
        this.mRecentLightSamples += MSG_UPDATE_AMBIENT_LUX;
        this.mAmbientLightRingBuffer.prune(time - 10000);
        this.mAmbientLightRingBuffer.push(time, lux);
        this.mLastObservedLux = lux;
        this.mLastObservedLuxTime = time;
    }

    private boolean setScreenAutoBrightnessAdjustment(float adjustment) {
        if (adjustment == this.mScreenAutoBrightnessAdjustment) {
            return USE_TWILIGHT_ADJUSTMENT;
        }
        this.mScreenAutoBrightnessAdjustment = adjustment;
        return USE_SCREEN_AUTO_BRIGHTNESS_ADJUSTMENT;
    }

    private void setAmbientLux(float lux) {
        this.mAmbientLux = lux;
        this.mBrighteningLuxThreshold = this.mAmbientLux * 1.1f;
        this.mDarkeningLuxThreshold = this.mAmbientLux * WindowManagerService.STACK_WEIGHT_MAX;
    }

    private float calculateAmbientLux(long now) {
        int N = this.mAmbientLightRingBuffer.size();
        if (N == 0) {
            Slog.e(TAG, "calculateAmbientLux: No ambient light readings available");
            return -1.0f;
        }
        float sum = 0.0f;
        float totalWeight = 0.0f;
        long endTime = AMBIENT_LIGHT_PREDICTION_TIME_MILLIS;
        for (int i = N - 1; i >= 0; i--) {
            long startTime = this.mAmbientLightRingBuffer.getTime(i) - now;
            float weight = calculateWeight(startTime, endTime);
            float lux = this.mAmbientLightRingBuffer.getLux(i);
            totalWeight += weight;
            sum += this.mAmbientLightRingBuffer.getLux(i) * weight;
            endTime = startTime;
        }
        return sum / totalWeight;
    }

    private static float calculateWeight(long startDelta, long endDelta) {
        return weightIntegral(endDelta) - weightIntegral(startDelta);
    }

    private static float weightIntegral(long x) {
        return ((float) x) * ((((float) x) * 0.5f) + 10000.0f);
    }

    private long nextAmbientLightBrighteningTransition(long time) {
        long earliestValidTime = time;
        int i = this.mAmbientLightRingBuffer.size() - 1;
        while (i >= 0 && this.mAmbientLightRingBuffer.getLux(i) > this.mBrighteningLuxThreshold) {
            earliestValidTime = this.mAmbientLightRingBuffer.getTime(i);
            i--;
        }
        return this.mBrighteningLightDebounceConfig + earliestValidTime;
    }

    private long nextAmbientLightDarkeningTransition(long time) {
        long earliestValidTime = time;
        int i = this.mAmbientLightRingBuffer.size() - 1;
        while (i >= 0 && this.mAmbientLightRingBuffer.getLux(i) < this.mDarkeningLuxThreshold) {
            earliestValidTime = this.mAmbientLightRingBuffer.getTime(i);
            i--;
        }
        return this.mDarkeningLightDebounceConfig + earliestValidTime;
    }

    private void updateAmbientLux() {
        long time = SystemClock.uptimeMillis();
        this.mAmbientLightRingBuffer.prune(time - 10000);
        updateAmbientLux(time);
    }

    private void updateAmbientLux(long time) {
        if (!this.mAmbientLuxValid) {
            long timeWhenSensorWarmedUp = ((long) this.mLightSensorWarmUpTimeConfig) + this.mLightSensorEnableTime;
            if (time < timeWhenSensorWarmedUp) {
                this.mHandler.sendEmptyMessageAtTime(MSG_UPDATE_AMBIENT_LUX, timeWhenSensorWarmedUp);
                return;
            }
            setAmbientLux(calculateAmbientLux(time));
            this.mAmbientLuxValid = USE_SCREEN_AUTO_BRIGHTNESS_ADJUSTMENT;
            updateAutoBrightness(USE_SCREEN_AUTO_BRIGHTNESS_ADJUSTMENT);
        }
        long nextBrightenTransition = nextAmbientLightBrighteningTransition(time);
        long nextDarkenTransition = nextAmbientLightDarkeningTransition(time);
        float ambientLux = calculateAmbientLux(time);
        if ((ambientLux >= this.mBrighteningLuxThreshold && nextBrightenTransition <= time) || (ambientLux <= this.mDarkeningLuxThreshold && nextDarkenTransition <= time)) {
            setAmbientLux(ambientLux);
            updateAutoBrightness(USE_SCREEN_AUTO_BRIGHTNESS_ADJUSTMENT);
            nextBrightenTransition = nextAmbientLightBrighteningTransition(time);
            nextDarkenTransition = nextAmbientLightDarkeningTransition(time);
        }
        long nextTransitionTime = Math.min(nextDarkenTransition, nextBrightenTransition);
        if (nextTransitionTime <= time) {
            nextTransitionTime = time + ((long) this.mLightSensorRate);
        }
        this.mHandler.sendEmptyMessageAtTime(MSG_UPDATE_AMBIENT_LUX, nextTransitionTime);
    }

    private void updateAutoBrightness(boolean sendUpdate) {
        if (this.mAmbientLuxValid) {
            float value = this.mScreenAutoBrightnessSpline.interpolate(this.mAmbientLux);
            float gamma = 1.0f;
            if (this.mScreenAutoBrightnessAdjustment != 0.0f) {
                gamma = 1.0f * MathUtils.pow(SCREEN_AUTO_BRIGHTNESS_ADJUSTMENT_MAX_GAMMA, Math.min(1.0f, Math.max(-1.0f, -this.mScreenAutoBrightnessAdjustment)));
            }
            if (USE_TWILIGHT_ADJUSTMENT) {
                TwilightState state = this.mTwilight.getCurrentState();
                if (state != null && state.isNight()) {
                    long now = System.currentTimeMillis();
                    gamma *= getTwilightGamma(now, state.getYesterdaySunset(), state.getTodaySunrise()) * getTwilightGamma(now, state.getTodaySunset(), state.getTomorrowSunrise());
                }
            }
            if (gamma != 1.0f) {
                float in = value;
                value = MathUtils.pow(value, gamma);
            }
            int newScreenAutoBrightness = clampScreenBrightness(Math.round(255.0f * value));
            if (this.mScreenAutoBrightness != newScreenAutoBrightness) {
                this.mScreenAutoBrightness = newScreenAutoBrightness;
                this.mLastScreenAutoBrightnessGamma = gamma;
                if (sendUpdate) {
                    this.mCallbacks.updateBrightness();
                }
            }
        }
    }

    private int clampScreenBrightness(int value) {
        return MathUtils.constrain(value, this.mScreenBrightnessRangeMinimum, this.mScreenBrightnessRangeMaximum);
    }

    private static float getTwilightGamma(long now, long lastSunset, long nextSunrise) {
        if (lastSunset < 0 || nextSunrise < 0 || now < lastSunset || now > nextSunrise) {
            return 1.0f;
        }
        if (now < lastSunset + TWILIGHT_ADJUSTMENT_TIME) {
            return MathUtils.lerp(1.0f, TWILIGHT_ADJUSTMENT_MAX_GAMMA, ((float) (now - lastSunset)) / 7200000.0f);
        }
        if (now > nextSunrise - TWILIGHT_ADJUSTMENT_TIME) {
            return MathUtils.lerp(1.0f, TWILIGHT_ADJUSTMENT_MAX_GAMMA, ((float) (nextSunrise - now)) / 7200000.0f);
        }
        return TWILIGHT_ADJUSTMENT_MAX_GAMMA;
    }
}
