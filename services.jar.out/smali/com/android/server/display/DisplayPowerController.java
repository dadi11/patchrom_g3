package com.android.server.display;

import android.animation.Animator;
import android.animation.Animator.AnimatorListener;
import android.animation.ObjectAnimator;
import android.content.Context;
import android.content.res.Resources;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.hardware.display.DisplayManagerInternal.DisplayPowerCallbacks;
import android.hardware.display.DisplayManagerInternal.DisplayPowerRequest;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.RemoteException;
import android.os.SystemClock;
import android.os.Trace;
import android.util.MathUtils;
import android.util.Slog;
import android.util.Spline;
import android.util.TimeUtils;
import android.view.WindowManagerPolicy;
import android.view.WindowManagerPolicy.ScreenOnListener;
import com.android.internal.app.IBatteryStats;
import com.android.server.LocalServices;
import com.android.server.am.BatteryStatsService;
import com.android.server.display.RampAnimator.Listener;
import com.android.server.lights.LightsManager;
import java.io.PrintWriter;

final class DisplayPowerController implements Callbacks {
    static final /* synthetic */ boolean $assertionsDisabled;
    private static final int BRIGHTNESS_RAMP_RATE_FAST = 200;
    private static final int BRIGHTNESS_RAMP_RATE_SLOW = 40;
    private static final int COLOR_FADE_OFF_ANIMATION_DURATION_MILLIS = 400;
    private static final int COLOR_FADE_ON_ANIMATION_DURATION_MILLIS = 250;
    private static boolean DEBUG = false;
    private static final boolean DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT = false;
    private static final int MSG_PROXIMITY_SENSOR_DEBOUNCED = 2;
    private static final int MSG_SCREEN_ON_UNBLOCKED = 3;
    private static final int MSG_UPDATE_POWER_STATE = 1;
    private static final int PROXIMITY_NEGATIVE = 0;
    private static final int PROXIMITY_POSITIVE = 1;
    private static final int PROXIMITY_SENSOR_NEGATIVE_DEBOUNCE_DELAY = 250;
    private static final int PROXIMITY_SENSOR_POSITIVE_DEBOUNCE_DELAY = 0;
    private static final int PROXIMITY_UNKNOWN = -1;
    private static final int SCREEN_DIM_MINIMUM_REDUCTION = 10;
    private static final String SCREEN_ON_BLOCKED_TRACE_NAME = "Screen on blocked";
    private static final String TAG = "DisplayPowerController";
    private static final float TYPICAL_PROXIMITY_THRESHOLD = 5.0f;
    private static final boolean USE_COLOR_FADE_ON_ANIMATION = false;
    private final boolean mAllowAutoBrightnessWhileDozingConfig;
    private final AnimatorListener mAnimatorListener;
    private boolean mAppliedAutoBrightness;
    private boolean mAppliedDimming;
    private boolean mAppliedLowPower;
    private AutomaticBrightnessController mAutomaticBrightnessController;
    private final IBatteryStats mBatteryStats;
    private final DisplayBlanker mBlanker;
    private final DisplayPowerCallbacks mCallbacks;
    private final Runnable mCleanListener;
    private boolean mColorFadeFadesConfig;
    private ObjectAnimator mColorFadeOffAnimator;
    private ObjectAnimator mColorFadeOnAnimator;
    private final Context mContext;
    private boolean mDisplayReadyLocked;
    private final DisplayControllerHandler mHandler;
    private final LightsManager mLights;
    private final Object mLock;
    private final Runnable mOnProximityNegativeRunnable;
    private final Runnable mOnProximityPositiveRunnable;
    private final Runnable mOnStateChangedRunnable;
    private int mPendingProximity;
    private long mPendingProximityDebounceTime;
    private boolean mPendingRequestChangedLocked;
    private DisplayPowerRequest mPendingRequestLocked;
    private boolean mPendingScreenOff;
    private ScreenOnUnblocker mPendingScreenOnUnblocker;
    private boolean mPendingUpdatePowerStateLocked;
    private boolean mPendingWaitForNegativeProximityLocked;
    private DisplayPowerRequest mPowerRequest;
    private DisplayPowerState mPowerState;
    private int mProximity;
    private Sensor mProximitySensor;
    private boolean mProximitySensorEnabled;
    private final SensorEventListener mProximitySensorListener;
    private float mProximityThreshold;
    private final Listener mRampAnimatorListener;
    private final int mScreenBrightnessDarkConfig;
    private final int mScreenBrightnessDimConfig;
    private final int mScreenBrightnessDozeConfig;
    private RampAnimator<DisplayPowerState> mScreenBrightnessRampAnimator;
    private final int mScreenBrightnessRangeMaximum;
    private final int mScreenBrightnessRangeMinimum;
    private boolean mScreenOffBecauseOfProximity;
    private long mScreenOnBlockStartRealTime;
    private final SensorManager mSensorManager;
    private boolean mUnfinishedBusiness;
    private boolean mUseSoftwareAutoBrightnessConfig;
    private boolean mWaitingForNegativeProximity;
    private final WindowManagerPolicy mWindowManagerPolicy;

    /* renamed from: com.android.server.display.DisplayPowerController.1 */
    class C01971 implements AnimatorListener {
        C01971() {
        }

        public void onAnimationStart(Animator animation) {
        }

        public void onAnimationEnd(Animator animation) {
            DisplayPowerController.this.sendUpdatePowerState();
        }

        public void onAnimationRepeat(Animator animation) {
        }

        public void onAnimationCancel(Animator animation) {
        }
    }

    /* renamed from: com.android.server.display.DisplayPowerController.2 */
    class C01982 implements Listener {
        C01982() {
        }

        public void onAnimationEnd() {
            DisplayPowerController.this.sendUpdatePowerState();
        }
    }

    /* renamed from: com.android.server.display.DisplayPowerController.3 */
    class C01993 implements Runnable {
        C01993() {
        }

        public void run() {
            DisplayPowerController.this.sendUpdatePowerState();
        }
    }

    /* renamed from: com.android.server.display.DisplayPowerController.4 */
    class C02004 implements Runnable {
        C02004() {
        }

        public void run() {
            DisplayPowerController.this.mCallbacks.onStateChanged();
            DisplayPowerController.this.mCallbacks.releaseSuspendBlocker();
        }
    }

    /* renamed from: com.android.server.display.DisplayPowerController.5 */
    class C02015 implements Runnable {
        C02015() {
        }

        public void run() {
            DisplayPowerController.this.mCallbacks.onProximityPositive();
            DisplayPowerController.this.mCallbacks.releaseSuspendBlocker();
        }
    }

    /* renamed from: com.android.server.display.DisplayPowerController.6 */
    class C02026 implements Runnable {
        C02026() {
        }

        public void run() {
            DisplayPowerController.this.mCallbacks.onProximityNegative();
            DisplayPowerController.this.mCallbacks.releaseSuspendBlocker();
        }
    }

    /* renamed from: com.android.server.display.DisplayPowerController.7 */
    class C02037 implements Runnable {
        final /* synthetic */ PrintWriter val$pw;

        C02037(PrintWriter printWriter) {
            this.val$pw = printWriter;
        }

        public void run() {
            DisplayPowerController.this.dumpLocal(this.val$pw);
        }
    }

    /* renamed from: com.android.server.display.DisplayPowerController.8 */
    class C02048 implements SensorEventListener {
        C02048() {
        }

        public void onSensorChanged(SensorEvent event) {
            boolean positive = DisplayPowerController.DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
            if (DisplayPowerController.this.mProximitySensorEnabled) {
                long time = SystemClock.uptimeMillis();
                float distance = event.values[DisplayPowerController.PROXIMITY_SENSOR_POSITIVE_DEBOUNCE_DELAY];
                if (distance >= 0.0f && distance < DisplayPowerController.this.mProximityThreshold) {
                    positive = true;
                }
                DisplayPowerController.this.handleProximitySensorEvent(time, positive);
            }
        }

        public void onAccuracyChanged(Sensor sensor, int accuracy) {
        }
    }

    private final class DisplayControllerHandler extends Handler {
        public DisplayControllerHandler(Looper looper) {
            super(looper, null, true);
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case DisplayPowerController.PROXIMITY_POSITIVE /*1*/:
                    DisplayPowerController.this.updatePowerState();
                case DisplayPowerController.MSG_PROXIMITY_SENSOR_DEBOUNCED /*2*/:
                    DisplayPowerController.this.debounceProximitySensor();
                case DisplayPowerController.MSG_SCREEN_ON_UNBLOCKED /*3*/:
                    if (DisplayPowerController.this.mPendingScreenOnUnblocker == msg.obj) {
                        DisplayPowerController.this.unblockScreenOn();
                        DisplayPowerController.this.updatePowerState();
                    }
                default:
            }
        }
    }

    private final class ScreenOnUnblocker implements ScreenOnListener {
        private ScreenOnUnblocker() {
        }

        public void onScreenOn() {
            Message msg = DisplayPowerController.this.mHandler.obtainMessage(DisplayPowerController.MSG_SCREEN_ON_UNBLOCKED, this);
            msg.setAsynchronous(true);
            DisplayPowerController.this.mHandler.sendMessage(msg);
        }
    }

    static {
        boolean z;
        if (DisplayPowerController.class.desiredAssertionStatus()) {
            z = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
        } else {
            z = true;
        }
        $assertionsDisabled = z;
        DEBUG = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
    }

    public DisplayPowerController(Context context, DisplayPowerCallbacks callbacks, Handler handler, SensorManager sensorManager, DisplayBlanker blanker) {
        this.mLock = new Object();
        this.mProximity = PROXIMITY_UNKNOWN;
        this.mPendingProximity = PROXIMITY_UNKNOWN;
        this.mPendingProximityDebounceTime = -1;
        this.mAnimatorListener = new C01971();
        this.mRampAnimatorListener = new C01982();
        this.mCleanListener = new C01993();
        this.mOnStateChangedRunnable = new C02004();
        this.mOnProximityPositiveRunnable = new C02015();
        this.mOnProximityNegativeRunnable = new C02026();
        this.mProximitySensorListener = new C02048();
        this.mHandler = new DisplayControllerHandler(handler.getLooper());
        this.mCallbacks = callbacks;
        this.mBatteryStats = BatteryStatsService.getService();
        this.mLights = (LightsManager) LocalServices.getService(LightsManager.class);
        this.mSensorManager = sensorManager;
        this.mWindowManagerPolicy = (WindowManagerPolicy) LocalServices.getService(WindowManagerPolicy.class);
        this.mBlanker = blanker;
        this.mContext = context;
        Resources resources = context.getResources();
        int screenBrightnessSettingMinimum = clampAbsoluteBrightness(resources.getInteger(17694802));
        this.mScreenBrightnessDozeConfig = clampAbsoluteBrightness(resources.getInteger(17694805));
        this.mScreenBrightnessDimConfig = clampAbsoluteBrightness(resources.getInteger(17694809));
        this.mScreenBrightnessDarkConfig = clampAbsoluteBrightness(resources.getInteger(17694810));
        if (this.mScreenBrightnessDarkConfig > this.mScreenBrightnessDimConfig) {
            Slog.w(TAG, "Expected config_screenBrightnessDark (" + this.mScreenBrightnessDarkConfig + ") to be less than or equal to " + "config_screenBrightnessDim (" + this.mScreenBrightnessDimConfig + ").");
        }
        if (this.mScreenBrightnessDarkConfig > this.mScreenBrightnessDimConfig) {
            Slog.w(TAG, "Expected config_screenBrightnessDark (" + this.mScreenBrightnessDarkConfig + ") to be less than or equal to " + "config_screenBrightnessSettingMinimum (" + screenBrightnessSettingMinimum + ").");
        }
        int screenBrightnessRangeMinimum = Math.min(Math.min(screenBrightnessSettingMinimum, this.mScreenBrightnessDimConfig), this.mScreenBrightnessDarkConfig);
        this.mScreenBrightnessRangeMaximum = 255;
        this.mUseSoftwareAutoBrightnessConfig = resources.getBoolean(17956897);
        this.mAllowAutoBrightnessWhileDozingConfig = resources.getBoolean(17956932);
        int lightSensorRate = resources.getInteger(17694808);
        long brighteningLightDebounce = (long) resources.getInteger(17694806);
        long darkeningLightDebounce = (long) resources.getInteger(17694807);
        boolean autoBrightnessResetAmbientLuxAfterWarmUp = resources.getBoolean(17956933);
        if (this.mUseSoftwareAutoBrightnessConfig) {
            int[] lux = resources.getIntArray(17236004);
            int[] screenBrightness = resources.getIntArray(17236005);
            int lightSensorWarmUpTimeConfig = resources.getInteger(17694811);
            float dozeScaleFactor = resources.getFraction(18022401, PROXIMITY_POSITIVE, PROXIMITY_POSITIVE);
            Spline screenAutoBrightnessSpline = createAutoBrightnessSpline(lux, screenBrightness);
            if (screenAutoBrightnessSpline == null) {
                Slog.e(TAG, "Error in config.xml.  config_autoBrightnessLcdBacklightValues (size " + screenBrightness.length + ") " + "must be monotic and have exactly one more entry than " + "config_autoBrightnessLevels (size " + lux.length + ") " + "which must be strictly increasing.  " + "Auto-brightness will be disabled.");
                this.mUseSoftwareAutoBrightnessConfig = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
            } else {
                int bottom = clampAbsoluteBrightness(screenBrightness[PROXIMITY_SENSOR_POSITIVE_DEBOUNCE_DELAY]);
                if (this.mScreenBrightnessDarkConfig > bottom) {
                    Slog.w(TAG, "config_screenBrightnessDark (" + this.mScreenBrightnessDarkConfig + ") should be less than or equal to the first value of " + "config_autoBrightnessLcdBacklightValues (" + bottom + ").");
                }
                if (bottom < screenBrightnessRangeMinimum) {
                    screenBrightnessRangeMinimum = bottom;
                }
                this.mAutomaticBrightnessController = new AutomaticBrightnessController(this, handler.getLooper(), sensorManager, screenAutoBrightnessSpline, lightSensorWarmUpTimeConfig, screenBrightnessRangeMinimum, this.mScreenBrightnessRangeMaximum, dozeScaleFactor, lightSensorRate, brighteningLightDebounce, darkeningLightDebounce, autoBrightnessResetAmbientLuxAfterWarmUp);
            }
        }
        this.mScreenBrightnessRangeMinimum = screenBrightnessRangeMinimum;
        this.mColorFadeFadesConfig = resources.getBoolean(17956901);
        this.mProximitySensor = this.mSensorManager.getDefaultSensor(8);
        if (this.mProximitySensor != null) {
            this.mProximityThreshold = Math.min(this.mProximitySensor.getMaximumRange(), TYPICAL_PROXIMITY_THRESHOLD);
        }
    }

    public boolean isProximitySensorAvailable() {
        return this.mProximitySensor != null ? true : DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
    }

    public boolean requestPowerState(DisplayPowerRequest request, boolean waitForNegativeProximity) {
        boolean z;
        if (DEBUG) {
            Slog.d(TAG, "requestPowerState: " + request + ", waitForNegativeProximity=" + waitForNegativeProximity);
        }
        synchronized (this.mLock) {
            boolean changed = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
            if (waitForNegativeProximity) {
                if (!this.mPendingWaitForNegativeProximityLocked) {
                    this.mPendingWaitForNegativeProximityLocked = true;
                    changed = true;
                }
            }
            if (this.mPendingRequestLocked == null) {
                this.mPendingRequestLocked = new DisplayPowerRequest(request);
                changed = true;
            } else if (!this.mPendingRequestLocked.equals(request)) {
                this.mPendingRequestLocked.copyFrom(request);
                changed = true;
            }
            if (changed) {
                this.mDisplayReadyLocked = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
            }
            if (changed && !this.mPendingRequestChangedLocked) {
                this.mPendingRequestChangedLocked = true;
                sendUpdatePowerStateLocked();
            }
            z = this.mDisplayReadyLocked;
        }
        return z;
    }

    private void sendUpdatePowerState() {
        synchronized (this.mLock) {
            sendUpdatePowerStateLocked();
        }
    }

    private void sendUpdatePowerStateLocked() {
        if (!this.mPendingUpdatePowerStateLocked) {
            this.mPendingUpdatePowerStateLocked = true;
            Message msg = this.mHandler.obtainMessage(PROXIMITY_POSITIVE);
            msg.setAsynchronous(true);
            this.mHandler.sendMessage(msg);
        }
    }

    private void initialize() {
        this.mPowerState = new DisplayPowerState(this.mBlanker, this.mLights.getLight(PROXIMITY_SENSOR_POSITIVE_DEBOUNCE_DELAY), new ColorFade(PROXIMITY_SENSOR_POSITIVE_DEBOUNCE_DELAY));
        this.mColorFadeOnAnimator = ObjectAnimator.ofFloat(this.mPowerState, DisplayPowerState.COLOR_FADE_LEVEL, new float[]{0.0f, 1.0f});
        this.mColorFadeOnAnimator.setDuration(250);
        this.mColorFadeOnAnimator.addListener(this.mAnimatorListener);
        this.mColorFadeOffAnimator = ObjectAnimator.ofFloat(this.mPowerState, DisplayPowerState.COLOR_FADE_LEVEL, new float[]{1.0f, 0.0f});
        this.mColorFadeOffAnimator.setDuration(400);
        this.mColorFadeOffAnimator.addListener(this.mAnimatorListener);
        this.mScreenBrightnessRampAnimator = new RampAnimator(this.mPowerState, DisplayPowerState.SCREEN_BRIGHTNESS);
        this.mScreenBrightnessRampAnimator.setListener(this.mRampAnimatorListener);
        try {
            this.mBatteryStats.noteScreenState(this.mPowerState.getScreenState());
            this.mBatteryStats.noteScreenBrightness(this.mPowerState.getScreenBrightness());
        } catch (RemoteException e) {
        }
    }

    private void updatePowerState() {
        boolean mustInitialize = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
        boolean autoBrightnessAdjustmentChanged = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
        synchronized (this.mLock) {
            this.mPendingUpdatePowerStateLocked = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
            if (this.mPendingRequestLocked == null) {
                return;
            }
            int state;
            if (this.mPowerRequest == null) {
                this.mPowerRequest = new DisplayPowerRequest(this.mPendingRequestLocked);
                this.mWaitingForNegativeProximity = this.mPendingWaitForNegativeProximityLocked;
                this.mPendingWaitForNegativeProximityLocked = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
                this.mPendingRequestChangedLocked = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
                mustInitialize = true;
            } else if (this.mPendingRequestChangedLocked) {
                autoBrightnessAdjustmentChanged = this.mPowerRequest.screenAutoBrightnessAdjustment != this.mPendingRequestLocked.screenAutoBrightnessAdjustment ? true : DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
                this.mPowerRequest.copyFrom(this.mPendingRequestLocked);
                this.mWaitingForNegativeProximity |= this.mPendingWaitForNegativeProximityLocked;
                this.mPendingWaitForNegativeProximityLocked = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
                this.mPendingRequestChangedLocked = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
                this.mDisplayReadyLocked = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
            }
            boolean mustNotify = !this.mDisplayReadyLocked ? true : DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
            if (mustInitialize) {
                initialize();
            }
            int brightness = PROXIMITY_UNKNOWN;
            boolean performScreenOffTransition = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
            switch (this.mPowerRequest.policy) {
                case PROXIMITY_SENSOR_POSITIVE_DEBOUNCE_DELAY /*0*/:
                    state = PROXIMITY_POSITIVE;
                    performScreenOffTransition = true;
                    break;
                case PROXIMITY_POSITIVE /*1*/:
                    if (this.mPowerRequest.dozeScreenState != 0) {
                        state = this.mPowerRequest.dozeScreenState;
                    } else {
                        state = MSG_SCREEN_ON_UNBLOCKED;
                    }
                    if (!this.mAllowAutoBrightnessWhileDozingConfig) {
                        brightness = this.mPowerRequest.dozeScreenBrightness;
                        break;
                    }
                    break;
                default:
                    state = MSG_PROXIMITY_SENSOR_DEBOUNCED;
                    break;
            }
            if ($assertionsDisabled || state != 0) {
                if (this.mProximitySensor != null) {
                    if (this.mPowerRequest.useProximitySensor && state != PROXIMITY_POSITIVE) {
                        setProximitySensorEnabled(true);
                        if (!this.mScreenOffBecauseOfProximity && this.mProximity == PROXIMITY_POSITIVE) {
                            this.mScreenOffBecauseOfProximity = true;
                            sendOnProximityPositiveWithWakelock();
                        }
                    } else if (this.mWaitingForNegativeProximity && this.mScreenOffBecauseOfProximity && this.mProximity == PROXIMITY_POSITIVE && state != PROXIMITY_POSITIVE) {
                        setProximitySensorEnabled(true);
                    } else {
                        setProximitySensorEnabled(DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT);
                        this.mWaitingForNegativeProximity = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
                    }
                    if (this.mScreenOffBecauseOfProximity && this.mProximity != PROXIMITY_POSITIVE) {
                        this.mScreenOffBecauseOfProximity = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
                        sendOnProximityNegativeWithWakelock();
                    }
                } else {
                    this.mWaitingForNegativeProximity = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
                }
                if (this.mScreenOffBecauseOfProximity) {
                    state = PROXIMITY_POSITIVE;
                }
                animateScreenStateChange(state, performScreenOffTransition);
                state = this.mPowerState.getScreenState();
                if (state == PROXIMITY_POSITIVE) {
                    brightness = PROXIMITY_SENSOR_POSITIVE_DEBOUNCE_DELAY;
                    this.mLights.getLight(MSG_PROXIMITY_SENSOR_DEBOUNCED).setBrightness(PROXIMITY_SENSOR_POSITIVE_DEBOUNCE_DELAY);
                }
                boolean autoBrightnessEnabled = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
                if (this.mAutomaticBrightnessController != null) {
                    boolean autoBrightnessEnabledInDoze = (this.mAllowAutoBrightnessWhileDozingConfig && (state == MSG_SCREEN_ON_UNBLOCKED || state == 4)) ? true : DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
                    autoBrightnessEnabled = (!this.mPowerRequest.useAutoBrightness || (!(state == MSG_PROXIMITY_SENSOR_DEBOUNCED || autoBrightnessEnabledInDoze) || brightness >= 0)) ? DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT : true;
                    this.mAutomaticBrightnessController.configure(autoBrightnessEnabled, this.mPowerRequest.screenAutoBrightnessAdjustment, state != MSG_PROXIMITY_SENSOR_DEBOUNCED ? true : DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT);
                }
                if (this.mPowerRequest.boostScreenBrightness && brightness != 0) {
                    brightness = 255;
                }
                boolean slowChange = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
                if (brightness < 0) {
                    if (autoBrightnessEnabled) {
                        brightness = this.mAutomaticBrightnessController.getAutomaticScreenBrightness();
                    }
                    if (brightness >= 0) {
                        brightness = clampScreenBrightness(brightness);
                        if (this.mAppliedAutoBrightness && !autoBrightnessAdjustmentChanged) {
                            slowChange = true;
                        }
                        this.mAppliedAutoBrightness = true;
                    } else {
                        this.mAppliedAutoBrightness = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
                    }
                } else {
                    this.mAppliedAutoBrightness = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
                }
                if (brightness < 0 && (state == MSG_SCREEN_ON_UNBLOCKED || state == 4)) {
                    brightness = this.mScreenBrightnessDozeConfig;
                }
                if (brightness < 0) {
                    brightness = clampScreenBrightness(this.mPowerRequest.screenBrightness);
                }
                if (this.mPowerRequest.policy == MSG_PROXIMITY_SENSOR_DEBOUNCED) {
                    if (brightness > this.mScreenBrightnessRangeMinimum) {
                        brightness = Math.max(Math.min(brightness - 10, this.mScreenBrightnessDimConfig), this.mScreenBrightnessRangeMinimum);
                    }
                    if (!this.mAppliedDimming) {
                        slowChange = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
                    }
                    this.mAppliedDimming = true;
                }
                if (this.mPowerRequest.lowPowerMode) {
                    if (brightness > this.mScreenBrightnessRangeMinimum) {
                        brightness = Math.max(brightness / MSG_PROXIMITY_SENSOR_DEBOUNCED, this.mScreenBrightnessRangeMinimum);
                    }
                    if (!this.mAppliedLowPower) {
                        slowChange = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
                    }
                    this.mAppliedLowPower = true;
                }
                if (!this.mPendingScreenOff) {
                    if (state == MSG_PROXIMITY_SENSOR_DEBOUNCED || state == MSG_SCREEN_ON_UNBLOCKED) {
                        int i;
                        if (slowChange) {
                            i = BRIGHTNESS_RAMP_RATE_SLOW;
                        } else {
                            i = BRIGHTNESS_RAMP_RATE_FAST;
                        }
                        animateScreenBrightness(brightness, i);
                    } else {
                        animateScreenBrightness(brightness, PROXIMITY_SENSOR_POSITIVE_DEBOUNCE_DELAY);
                    }
                }
                boolean ready = (this.mPendingScreenOnUnblocker != null || this.mColorFadeOnAnimator.isStarted() || this.mColorFadeOffAnimator.isStarted() || !this.mPowerState.waitUntilClean(this.mCleanListener)) ? DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT : true;
                boolean finished = (!ready || this.mScreenBrightnessRampAnimator.isAnimating()) ? DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT : true;
                if (!(finished || this.mUnfinishedBusiness)) {
                    if (DEBUG) {
                        Slog.d(TAG, "Unfinished business...");
                    }
                    this.mCallbacks.acquireSuspendBlocker();
                    this.mUnfinishedBusiness = true;
                }
                if (ready && mustNotify) {
                    synchronized (this.mLock) {
                        if (!this.mPendingRequestChangedLocked) {
                            this.mDisplayReadyLocked = true;
                            if (DEBUG) {
                                Slog.d(TAG, "Display ready!");
                            }
                        }
                    }
                    sendOnStateChangedWithWakelock();
                }
                if (finished && this.mUnfinishedBusiness) {
                    if (DEBUG) {
                        Slog.d(TAG, "Finished business...");
                    }
                    this.mUnfinishedBusiness = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
                    this.mCallbacks.releaseSuspendBlocker();
                    return;
                }
                return;
            }
            throw new AssertionError();
        }
    }

    public void updateBrightness() {
        sendUpdatePowerState();
    }

    private void blockScreenOn() {
        if (this.mPendingScreenOnUnblocker == null) {
            Trace.asyncTraceBegin(131072, SCREEN_ON_BLOCKED_TRACE_NAME, PROXIMITY_SENSOR_POSITIVE_DEBOUNCE_DELAY);
            this.mPendingScreenOnUnblocker = new ScreenOnUnblocker();
            this.mScreenOnBlockStartRealTime = SystemClock.elapsedRealtime();
            Slog.i(TAG, "Blocking screen on until initial contents have been drawn.");
        }
    }

    private void unblockScreenOn() {
        if (this.mPendingScreenOnUnblocker != null) {
            this.mPendingScreenOnUnblocker = null;
            Slog.i(TAG, "Unblocked screen on after " + (SystemClock.elapsedRealtime() - this.mScreenOnBlockStartRealTime) + " ms");
            Trace.asyncTraceEnd(131072, SCREEN_ON_BLOCKED_TRACE_NAME, PROXIMITY_SENSOR_POSITIVE_DEBOUNCE_DELAY);
        }
    }

    private boolean setScreenState(int state) {
        if (this.mPowerState.getScreenState() != state) {
            boolean wasOn = this.mPowerState.getScreenState() != PROXIMITY_POSITIVE ? true : DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
            this.mPowerState.setScreenState(state);
            try {
                this.mBatteryStats.noteScreenState(state);
            } catch (RemoteException e) {
            }
            boolean isOn;
            if (state != PROXIMITY_POSITIVE) {
                isOn = true;
            } else {
                isOn = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
            }
            if (wasOn && !isOn) {
                unblockScreenOn();
                this.mWindowManagerPolicy.screenTurnedOff();
            } else if (!wasOn && isOn) {
                if (this.mPowerState.getColorFadeLevel() == 0.0f) {
                    blockScreenOn();
                } else {
                    unblockScreenOn();
                }
                this.mWindowManagerPolicy.screenTurningOn(this.mPendingScreenOnUnblocker);
            }
        }
        if (this.mPendingScreenOnUnblocker == null) {
            return true;
        }
        return DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
    }

    private int clampScreenBrightness(int value) {
        return MathUtils.constrain(value, this.mScreenBrightnessRangeMinimum, this.mScreenBrightnessRangeMaximum);
    }

    private void animateScreenBrightness(int target, int rate) {
        if (DEBUG) {
            Slog.d(TAG, "Animating brightness: target=" + target + ", rate=" + rate);
        }
        if (this.mScreenBrightnessRampAnimator.animateTo(target, rate)) {
            try {
                this.mBatteryStats.noteScreenBrightness(target);
            } catch (RemoteException e) {
            }
        }
    }

    private void animateScreenStateChange(int target, boolean performScreenOffTransition) {
        int i = MSG_PROXIMITY_SENSOR_DEBOUNCED;
        if (!this.mColorFadeOnAnimator.isStarted() && !this.mColorFadeOffAnimator.isStarted()) {
            if (this.mPendingScreenOff && target != PROXIMITY_POSITIVE) {
                setScreenState(PROXIMITY_POSITIVE);
                this.mPendingScreenOff = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
            }
            if (target == MSG_PROXIMITY_SENSOR_DEBOUNCED) {
                if (setScreenState(MSG_PROXIMITY_SENSOR_DEBOUNCED)) {
                    this.mPowerState.setColorFadeLevel(1.0f);
                    this.mPowerState.dismissColorFade();
                }
            } else if (target == MSG_SCREEN_ON_UNBLOCKED) {
                if (!(this.mScreenBrightnessRampAnimator.isAnimating() && this.mPowerState.getScreenState() == MSG_PROXIMITY_SENSOR_DEBOUNCED) && setScreenState(MSG_SCREEN_ON_UNBLOCKED)) {
                    this.mPowerState.setColorFadeLevel(1.0f);
                    this.mPowerState.dismissColorFade();
                }
            } else if (target != 4) {
                this.mPendingScreenOff = true;
                if (this.mPowerState.getColorFadeLevel() == 0.0f) {
                    setScreenState(PROXIMITY_POSITIVE);
                    this.mPendingScreenOff = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
                    return;
                }
                if (performScreenOffTransition) {
                    DisplayPowerState displayPowerState = this.mPowerState;
                    Context context = this.mContext;
                    if (!this.mColorFadeFadesConfig) {
                        i = PROXIMITY_POSITIVE;
                    }
                    if (displayPowerState.prepareColorFade(context, i) && this.mPowerState.getScreenState() != PROXIMITY_POSITIVE) {
                        this.mColorFadeOffAnimator.start();
                        return;
                    }
                }
                this.mColorFadeOffAnimator.end();
            } else if (!this.mScreenBrightnessRampAnimator.isAnimating() || this.mPowerState.getScreenState() == 4) {
                if (this.mPowerState.getScreenState() != 4) {
                    if (setScreenState(MSG_SCREEN_ON_UNBLOCKED)) {
                        setScreenState(4);
                    } else {
                        return;
                    }
                }
                this.mPowerState.setColorFadeLevel(1.0f);
                this.mPowerState.dismissColorFade();
            }
        }
    }

    private void setProximitySensorEnabled(boolean enable) {
        if (enable) {
            if (!this.mProximitySensorEnabled) {
                this.mProximitySensorEnabled = true;
                this.mSensorManager.registerListener(this.mProximitySensorListener, this.mProximitySensor, MSG_SCREEN_ON_UNBLOCKED, this.mHandler);
            }
        } else if (this.mProximitySensorEnabled) {
            this.mProximitySensorEnabled = DEBUG_PRETEND_PROXIMITY_SENSOR_ABSENT;
            this.mProximity = PROXIMITY_UNKNOWN;
            this.mPendingProximity = PROXIMITY_UNKNOWN;
            this.mHandler.removeMessages(MSG_PROXIMITY_SENSOR_DEBOUNCED);
            this.mSensorManager.unregisterListener(this.mProximitySensorListener);
            clearPendingProximityDebounceTime();
        }
    }

    private void handleProximitySensorEvent(long time, boolean positive) {
        if (!this.mProximitySensorEnabled) {
            return;
        }
        if (this.mPendingProximity == 0 && !positive) {
            return;
        }
        if (this.mPendingProximity != PROXIMITY_POSITIVE || !positive) {
            this.mHandler.removeMessages(MSG_PROXIMITY_SENSOR_DEBOUNCED);
            if (positive) {
                this.mPendingProximity = PROXIMITY_POSITIVE;
                setPendingProximityDebounceTime(0 + time);
            } else {
                this.mPendingProximity = PROXIMITY_SENSOR_POSITIVE_DEBOUNCE_DELAY;
                setPendingProximityDebounceTime(250 + time);
            }
            debounceProximitySensor();
        }
    }

    private void debounceProximitySensor() {
        if (this.mProximitySensorEnabled && this.mPendingProximity != PROXIMITY_UNKNOWN && this.mPendingProximityDebounceTime >= 0) {
            if (this.mPendingProximityDebounceTime <= SystemClock.uptimeMillis()) {
                this.mProximity = this.mPendingProximity;
                updatePowerState();
                clearPendingProximityDebounceTime();
                return;
            }
            Message msg = this.mHandler.obtainMessage(MSG_PROXIMITY_SENSOR_DEBOUNCED);
            msg.setAsynchronous(true);
            this.mHandler.sendMessageAtTime(msg, this.mPendingProximityDebounceTime);
        }
    }

    private void clearPendingProximityDebounceTime() {
        if (this.mPendingProximityDebounceTime >= 0) {
            this.mPendingProximityDebounceTime = -1;
            this.mCallbacks.releaseSuspendBlocker();
        }
    }

    private void setPendingProximityDebounceTime(long debounceTime) {
        if (this.mPendingProximityDebounceTime < 0) {
            this.mCallbacks.acquireSuspendBlocker();
        }
        this.mPendingProximityDebounceTime = debounceTime;
    }

    private void sendOnStateChangedWithWakelock() {
        this.mCallbacks.acquireSuspendBlocker();
        this.mHandler.post(this.mOnStateChangedRunnable);
    }

    private void sendOnProximityPositiveWithWakelock() {
        this.mCallbacks.acquireSuspendBlocker();
        this.mHandler.post(this.mOnProximityPositiveRunnable);
    }

    private void sendOnProximityNegativeWithWakelock() {
        this.mCallbacks.acquireSuspendBlocker();
        this.mHandler.post(this.mOnProximityNegativeRunnable);
    }

    public void dump(PrintWriter pw) {
        synchronized (this.mLock) {
            pw.println();
            pw.println("Display Power Controller Locked State:");
            pw.println("  mDisplayReadyLocked=" + this.mDisplayReadyLocked);
            pw.println("  mPendingRequestLocked=" + this.mPendingRequestLocked);
            pw.println("  mPendingRequestChangedLocked=" + this.mPendingRequestChangedLocked);
            pw.println("  mPendingWaitForNegativeProximityLocked=" + this.mPendingWaitForNegativeProximityLocked);
            pw.println("  mPendingUpdatePowerStateLocked=" + this.mPendingUpdatePowerStateLocked);
        }
        pw.println();
        pw.println("Display Power Controller Configuration:");
        pw.println("  mScreenBrightnessDozeConfig=" + this.mScreenBrightnessDozeConfig);
        pw.println("  mScreenBrightnessDimConfig=" + this.mScreenBrightnessDimConfig);
        pw.println("  mScreenBrightnessDarkConfig=" + this.mScreenBrightnessDarkConfig);
        pw.println("  mScreenBrightnessRangeMinimum=" + this.mScreenBrightnessRangeMinimum);
        pw.println("  mScreenBrightnessRangeMaximum=" + this.mScreenBrightnessRangeMaximum);
        pw.println("  mUseSoftwareAutoBrightnessConfig=" + this.mUseSoftwareAutoBrightnessConfig);
        pw.println("  mAllowAutoBrightnessWhileDozingConfig=" + this.mAllowAutoBrightnessWhileDozingConfig);
        pw.println("  mColorFadeFadesConfig=" + this.mColorFadeFadesConfig);
        this.mHandler.runWithScissors(new C02037(pw), 1000);
    }

    private void dumpLocal(PrintWriter pw) {
        pw.println();
        pw.println("Display Power Controller Thread State:");
        pw.println("  mPowerRequest=" + this.mPowerRequest);
        pw.println("  mWaitingForNegativeProximity=" + this.mWaitingForNegativeProximity);
        pw.println("  mProximitySensor=" + this.mProximitySensor);
        pw.println("  mProximitySensorEnabled=" + this.mProximitySensorEnabled);
        pw.println("  mProximityThreshold=" + this.mProximityThreshold);
        pw.println("  mProximity=" + proximityToString(this.mProximity));
        pw.println("  mPendingProximity=" + proximityToString(this.mPendingProximity));
        pw.println("  mPendingProximityDebounceTime=" + TimeUtils.formatUptime(this.mPendingProximityDebounceTime));
        pw.println("  mScreenOffBecauseOfProximity=" + this.mScreenOffBecauseOfProximity);
        pw.println("  mAppliedAutoBrightness=" + this.mAppliedAutoBrightness);
        pw.println("  mAppliedDimming=" + this.mAppliedDimming);
        pw.println("  mAppliedLowPower=" + this.mAppliedLowPower);
        pw.println("  mPendingScreenOnUnblocker=" + this.mPendingScreenOnUnblocker);
        pw.println("  mPendingScreenOff=" + this.mPendingScreenOff);
        pw.println("  mScreenBrightnessRampAnimator.isAnimating()=" + this.mScreenBrightnessRampAnimator.isAnimating());
        if (this.mColorFadeOnAnimator != null) {
            pw.println("  mColorFadeOnAnimator.isStarted()=" + this.mColorFadeOnAnimator.isStarted());
        }
        if (this.mColorFadeOffAnimator != null) {
            pw.println("  mColorFadeOffAnimator.isStarted()=" + this.mColorFadeOffAnimator.isStarted());
        }
        if (this.mPowerState != null) {
            this.mPowerState.dump(pw);
        }
        if (this.mAutomaticBrightnessController != null) {
            this.mAutomaticBrightnessController.dump(pw);
        }
    }

    private static String proximityToString(int state) {
        switch (state) {
            case PROXIMITY_UNKNOWN /*-1*/:
                return "Unknown";
            case PROXIMITY_SENSOR_POSITIVE_DEBOUNCE_DELAY /*0*/:
                return "Negative";
            case PROXIMITY_POSITIVE /*1*/:
                return "Positive";
            default:
                return Integer.toString(state);
        }
    }

    private static Spline createAutoBrightnessSpline(int[] lux, int[] brightness) {
        try {
            int n = brightness.length;
            float[] x = new float[n];
            float[] y = new float[n];
            y[PROXIMITY_SENSOR_POSITIVE_DEBOUNCE_DELAY] = normalizeAbsoluteBrightness(brightness[PROXIMITY_SENSOR_POSITIVE_DEBOUNCE_DELAY]);
            for (int i = PROXIMITY_POSITIVE; i < n; i += PROXIMITY_POSITIVE) {
                x[i] = (float) lux[i + PROXIMITY_UNKNOWN];
                y[i] = normalizeAbsoluteBrightness(brightness[i]);
            }
            Spline createSpline = Spline.createSpline(x, y);
            if (!DEBUG) {
                return createSpline;
            }
            Slog.d(TAG, "Auto-brightness spline: " + createSpline);
            for (float v = 1.0f; v < ((float) lux[lux.length + PROXIMITY_UNKNOWN]) * 1.25f; v *= 1.25f) {
                String str = TAG;
                Object[] objArr = new Object[MSG_PROXIMITY_SENSOR_DEBOUNCED];
                objArr[PROXIMITY_SENSOR_POSITIVE_DEBOUNCE_DELAY] = Float.valueOf(v);
                objArr[PROXIMITY_POSITIVE] = Float.valueOf(createSpline.interpolate(v));
                Slog.d(str, String.format("  %7.1f: %7.1f", objArr));
            }
            return createSpline;
        } catch (IllegalArgumentException ex) {
            Slog.e(TAG, "Could not create auto-brightness spline.", ex);
            return null;
        }
    }

    private static float normalizeAbsoluteBrightness(int value) {
        return ((float) clampAbsoluteBrightness(value)) / 255.0f;
    }

    private static int clampAbsoluteBrightness(int value) {
        return MathUtils.constrain(value, PROXIMITY_SENSOR_POSITIVE_DEBOUNCE_DELAY, 255);
    }
}
