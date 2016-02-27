package com.android.server.power;

import android.app.ActivityManager;
import android.app.ActivityManager.RunningAppProcessInfo;
import android.content.BroadcastReceiver;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.res.Resources;
import android.database.ContentObserver;
import android.hardware.SensorManager;
import android.hardware.SystemSensorManager;
import android.hardware.display.DisplayManagerInternal;
import android.hardware.display.DisplayManagerInternal.DisplayPowerCallbacks;
import android.hardware.display.DisplayManagerInternal.DisplayPowerRequest;
import android.net.Uri;
import android.os.BatteryManagerInternal;
import android.os.Binder;
import android.os.Handler;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.IPowerManager.Stub;
import android.os.Looper;
import android.os.Message;
import android.os.PowerManager;
import android.os.PowerManagerInternal;
import android.os.PowerManagerInternal.LowPowerModeListener;
import android.os.Process;
import android.os.RemoteException;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.os.Trace;
import android.os.WorkSource;
import android.provider.Settings.Global;
import android.provider.Settings.Secure;
import android.provider.Settings.System;
import android.service.dreams.DreamManagerInternal;
import android.util.EventLog;
import android.util.Slog;
import android.util.TimeUtils;
import android.view.Display;
import android.view.WindowManagerPolicy;
import com.android.internal.app.IAppOpsService;
import com.android.internal.app.IBatteryStats;
import com.android.internal.os.BackgroundThread;
import com.android.server.EventLogTags;
import com.android.server.ServiceThread;
import com.android.server.SystemService;
import com.android.server.Watchdog;
import com.android.server.Watchdog.Monitor;
import com.android.server.am.BatteryStatsService;
import com.android.server.lights.Light;
import com.android.server.lights.LightsManager;
import com.android.server.wm.AppTransition;
import com.android.server.wm.WindowManagerService.C0569H;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import libcore.util.Objects;

public final class PowerManagerService extends SystemService implements Monitor {
    private static final int BUTTON_ON_DURATION = 5000;
    private static final boolean DEBUG = false;
    private static final boolean DEBUG_SPEW = false;
    private static final int DEFAULT_SCREEN_OFF_TIMEOUT = 15000;
    private static final int DEFAULT_SLEEP_TIMEOUT = -1;
    private static final int DIRTY_ACTUAL_DISPLAY_POWER_STATE_UPDATED = 8;
    private static final int DIRTY_BATTERY_STATE = 256;
    private static final int DIRTY_BOOT_COMPLETED = 16;
    private static final int DIRTY_DOCK_STATE = 1024;
    private static final int DIRTY_IS_POWERED = 64;
    private static final int DIRTY_PROXIMITY_POSITIVE = 512;
    private static final int DIRTY_SCREEN_BRIGHTNESS_BOOST = 2048;
    private static final int DIRTY_SETTINGS = 32;
    private static final int DIRTY_STAY_ON = 128;
    private static final int DIRTY_USER_ACTIVITY = 4;
    private static final int DIRTY_WAKEFULNESS = 2;
    private static final int DIRTY_WAKE_LOCKS = 1;
    private static final int DPM_CONFIG_FEATURE_MASK_NSRM = 4;
    private static final int MAX_CPU_BOOST_TIME = 5000000;
    private static final int MSG_SANDMAN = 2;
    private static final int MSG_SCREEN_BRIGHTNESS_BOOST_TIMEOUT = 3;
    private static final int MSG_USER_ACTIVITY_TIMEOUT = 1;
    private static final int POWER_HINT_INTERACTION = 2;
    private static final int POWER_HINT_LOW_POWER = 5;
    private static final int SCREEN_BRIGHTNESS_BOOST_TIMEOUT = 5000;
    private static final String TAG = "PowerManagerService";
    private static final int USER_ACTIVITY_SCREEN_BRIGHT = 1;
    private static final int USER_ACTIVITY_SCREEN_DIM = 2;
    private static final int USER_ACTIVITY_SCREEN_DREAM = 4;
    private static final int WAKE_LOCK_BUTTON_BRIGHT = 8;
    private static final int WAKE_LOCK_CPU = 1;
    private static final int WAKE_LOCK_DOZE = 64;
    private static final int WAKE_LOCK_PROXIMITY_SCREEN_OFF = 16;
    private static final int WAKE_LOCK_SCREEN_BRIGHT = 2;
    private static final int WAKE_LOCK_SCREEN_DIM = 4;
    private static final int WAKE_LOCK_STAY_AWAKE = 32;
    private IAppOpsService mAppOps;
    private Light mAttentionLight;
    private boolean mAutoLowPowerModeConfigured;
    private boolean mAutoLowPowerModeSnoozing;
    private int mBatteryLevel;
    private boolean mBatteryLevelLow;
    private int mBatteryLevelWhenDreamStarted;
    private BatteryManagerInternal mBatteryManagerInternal;
    private IBatteryStats mBatteryStats;
    private final ArrayList<Integer> mBlockedUids;
    private boolean mBootCompleted;
    private Light mButtonsLight;
    private final Context mContext;
    private boolean mDecoupleHalAutoSuspendModeFromDisplayConfig;
    private boolean mDecoupleHalInteractiveModeFromDisplayConfig;
    private int mDirty;
    private DisplayManagerInternal mDisplayManagerInternal;
    private final DisplayPowerCallbacks mDisplayPowerCallbacks;
    private final DisplayPowerRequest mDisplayPowerRequest;
    private boolean mDisplayReady;
    private final SuspendBlocker mDisplaySuspendBlocker;
    private int mDockState;
    private boolean mDozeAfterScreenOffConfig;
    private int mDozeScreenBrightnessOverrideFromDreamManager;
    private int mDozeScreenStateOverrideFromDreamManager;
    private DreamManagerInternal mDreamManager;
    private boolean mDreamsActivateOnDockSetting;
    private boolean mDreamsActivateOnSleepSetting;
    private boolean mDreamsActivatedOnDockByDefaultConfig;
    private boolean mDreamsActivatedOnSleepByDefaultConfig;
    private int mDreamsBatteryLevelDrainCutoffConfig;
    private int mDreamsBatteryLevelMinimumWhenNotPoweredConfig;
    private int mDreamsBatteryLevelMinimumWhenPoweredConfig;
    private boolean mDreamsEnabledByDefaultConfig;
    private boolean mDreamsEnabledOnBatteryConfig;
    private boolean mDreamsEnabledSetting;
    private boolean mDreamsSupportedConfig;
    private boolean mHalAutoSuspendModeEnabled;
    private boolean mHalInteractiveModeEnabled;
    private final PowerManagerHandler mHandler;
    private final ServiceThread mHandlerThread;
    private boolean mHoldingDisplaySuspendBlocker;
    private boolean mHoldingWakeLockSuspendBlocker;
    private boolean mIsPowered;
    private long mLastInteractivePowerHintTime;
    private long mLastScreenBrightnessBoostTime;
    private long mLastSleepTime;
    private long mLastUserActivityTime;
    private long mLastUserActivityTimeNoChangeLights;
    private long mLastWakeTime;
    private long mLastWarningAboutUserActivityPermission;
    private LightsManager mLightsManager;
    private final Object mLock;
    private boolean mLowPowerModeEnabled;
    private final ArrayList<LowPowerModeListener> mLowPowerModeListeners;
    private boolean mLowPowerModeSetting;
    private int mMaximumScreenDimDurationConfig;
    private float mMaximumScreenDimRatioConfig;
    private int mMaximumScreenOffTimeoutFromDeviceAdmin;
    private int mMinimumScreenOffTimeoutConfig;
    private Notifier mNotifier;
    private int mPlugType;
    private WindowManagerPolicy mPolicy;
    private boolean mProximityPositive;
    private boolean mRequestWaitForNegativeProximity;
    private boolean mSandmanScheduled;
    private boolean mSandmanSummoned;
    private float mScreenAutoBrightnessAdjustmentSetting;
    private boolean mScreenBrightnessBoostInProgress;
    private int mScreenBrightnessModeSetting;
    private int mScreenBrightnessOverrideFromWindowManager;
    private int mScreenBrightnessSetting;
    private int mScreenBrightnessSettingDefault;
    private int mScreenBrightnessSettingMaximum;
    private int mScreenBrightnessSettingMinimum;
    private int mScreenOffTimeoutSetting;
    private SettingsObserver mSettingsObserver;
    private int mSleepTimeoutSetting;
    private boolean mStayOn;
    private int mStayOnWhilePluggedInSetting;
    private final ArrayList<SuspendBlocker> mSuspendBlockers;
    private boolean mSuspendWhenScreenOffDueToProximityConfig;
    private boolean mSystemReady;
    private float mTemporaryScreenAutoBrightnessAdjustmentSettingOverride;
    private int mTemporaryScreenBrightnessSettingOverride;
    private boolean mTheaterModeEnabled;
    private int mUserActivitySummary;
    private long mUserActivityTimeoutOverrideFromWindowManager;
    private int mWakeLockSummary;
    private final SuspendBlocker mWakeLockSuspendBlocker;
    private final ArrayList<WakeLock> mWakeLocks;
    private boolean mWakeUpWhenPluggedOrUnpluggedConfig;
    private boolean mWakeUpWhenPluggedOrUnpluggedInTheaterModeConfig;
    private int mWakefulness;
    private boolean mWakefulnessChanging;
    private WirelessChargerDetector mWirelessChargerDetector;

    /* renamed from: com.android.server.power.PowerManagerService.1 */
    class C04681 implements Runnable {
        final /* synthetic */ boolean val$lowPowerModeEnabled;

        C04681(boolean z) {
            this.val$lowPowerModeEnabled = z;
        }

        public void run() {
            PowerManagerService.this.mContext.sendBroadcast(new Intent("android.os.action.POWER_SAVE_MODE_CHANGING").putExtra("mode", PowerManagerService.this.mLowPowerModeEnabled).addFlags(1073741824));
            synchronized (PowerManagerService.this.mLock) {
                ArrayList<LowPowerModeListener> listeners = new ArrayList(PowerManagerService.this.mLowPowerModeListeners);
            }
            for (int i = 0; i < listeners.size(); i += PowerManagerService.WAKE_LOCK_CPU) {
                ((LowPowerModeListener) listeners.get(i)).onLowPowerModeChanged(this.val$lowPowerModeEnabled);
            }
            Intent intent = new Intent("android.os.action.POWER_SAVE_MODE_CHANGED");
            intent.addFlags(1073741824);
            PowerManagerService.this.mContext.sendBroadcast(intent);
        }
    }

    /* renamed from: com.android.server.power.PowerManagerService.2 */
    class C04692 implements DisplayPowerCallbacks {
        private int mDisplayState;

        C04692() {
            this.mDisplayState = 0;
        }

        public void onStateChanged() {
            synchronized (PowerManagerService.this.mLock) {
                PowerManagerService.access$1076(PowerManagerService.this, PowerManagerService.WAKE_LOCK_BUTTON_BRIGHT);
                PowerManagerService.this.updatePowerStateLocked();
            }
        }

        public void onProximityPositive() {
            synchronized (PowerManagerService.this.mLock) {
                PowerManagerService.this.mProximityPositive = true;
                PowerManagerService.access$1076(PowerManagerService.this, PowerManagerService.DIRTY_PROXIMITY_POSITIVE);
                PowerManagerService.this.updatePowerStateLocked();
            }
        }

        public void onProximityNegative() {
            synchronized (PowerManagerService.this.mLock) {
                PowerManagerService.this.mProximityPositive = PowerManagerService.DEBUG_SPEW;
                PowerManagerService.access$1076(PowerManagerService.this, PowerManagerService.DIRTY_PROXIMITY_POSITIVE);
                PowerManagerService.this.userActivityNoUpdateLocked(SystemClock.uptimeMillis(), 0, 0, ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE);
                PowerManagerService.this.updatePowerStateLocked();
            }
        }

        public void onDisplayStateChange(int state) {
            synchronized (PowerManagerService.this.mLock) {
                if (this.mDisplayState != state) {
                    this.mDisplayState = state;
                    if (state == PowerManagerService.WAKE_LOCK_CPU) {
                        if (!PowerManagerService.this.mDecoupleHalInteractiveModeFromDisplayConfig) {
                            PowerManagerService.this.setHalInteractiveModeLocked(PowerManagerService.DEBUG_SPEW);
                        }
                        if (!PowerManagerService.this.mDecoupleHalAutoSuspendModeFromDisplayConfig) {
                            PowerManagerService.this.setHalAutoSuspendModeLocked(true);
                        }
                    } else {
                        if (!PowerManagerService.this.mDecoupleHalAutoSuspendModeFromDisplayConfig) {
                            PowerManagerService.this.setHalAutoSuspendModeLocked(PowerManagerService.DEBUG_SPEW);
                        }
                        if (!PowerManagerService.this.mDecoupleHalInteractiveModeFromDisplayConfig) {
                            PowerManagerService.this.setHalInteractiveModeLocked(true);
                        }
                    }
                }
            }
        }

        public void acquireSuspendBlocker() {
            PowerManagerService.this.mDisplaySuspendBlocker.acquire();
        }

        public void releaseSuspendBlocker() {
            PowerManagerService.this.mDisplaySuspendBlocker.release();
        }

        public String toString() {
            String str;
            synchronized (this) {
                str = "state=" + Display.stateToString(this.mDisplayState);
            }
            return str;
        }
    }

    /* renamed from: com.android.server.power.PowerManagerService.3 */
    class C04703 implements Runnable {
        final /* synthetic */ boolean val$confirm;
        final /* synthetic */ String val$reason;
        final /* synthetic */ boolean val$shutdown;

        C04703(boolean z, boolean z2, String str) {
            this.val$shutdown = z;
            this.val$confirm = z2;
            this.val$reason = str;
        }

        public void run() {
            synchronized (this) {
                if (this.val$shutdown) {
                    ShutdownThread.shutdown(PowerManagerService.this.mContext, this.val$confirm);
                } else {
                    ShutdownThread.reboot(PowerManagerService.this.mContext, this.val$reason, this.val$confirm);
                }
            }
        }
    }

    /* renamed from: com.android.server.power.PowerManagerService.4 */
    class C04714 extends Thread {
        final /* synthetic */ String val$message;

        C04714(String x0, String str) {
            this.val$message = str;
            super(x0);
        }

        public void run() {
            throw new RuntimeException(this.val$message);
        }
    }

    private final class BatteryReceiver extends BroadcastReceiver {
        private BatteryReceiver() {
        }

        public void onReceive(Context context, Intent intent) {
            synchronized (PowerManagerService.this.mLock) {
                PowerManagerService.this.handleBatteryStateChangedLocked();
            }
        }
    }

    private final class BinderService extends Stub {
        private BinderService() {
        }

        public void acquireWakeLockWithUid(IBinder lock, int flags, String tag, String packageName, int uid) {
            if (uid < 0) {
                uid = Binder.getCallingUid();
            }
            acquireWakeLock(lock, flags, tag, packageName, new WorkSource(uid), null);
        }

        public void powerHint(int hintId, int data) {
            if (PowerManagerService.this.mSystemReady) {
                PowerManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.DEVICE_POWER", null);
                PowerManagerService.this.powerHintInternal(hintId, data);
            }
        }

        public void acquireWakeLock(IBinder lock, int flags, String tag, String packageName, WorkSource ws, String historyTag) {
            if (lock == null) {
                throw new IllegalArgumentException("lock must not be null");
            } else if (packageName == null) {
                throw new IllegalArgumentException("packageName must not be null");
            } else {
                PowerManager.validateWakeLockParameters(flags, tag);
                PowerManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.WAKE_LOCK", null);
                if ((flags & PowerManagerService.WAKE_LOCK_DOZE) != 0) {
                    PowerManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.DEVICE_POWER", null);
                }
                if (ws == null || ws.size() == 0) {
                    ws = null;
                } else {
                    PowerManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.UPDATE_DEVICE_STATS", null);
                }
                int uid = Binder.getCallingUid();
                int pid = Binder.getCallingPid();
                long ident = Binder.clearCallingIdentity();
                try {
                    PowerManagerService.this.acquireWakeLockInternal(lock, flags, tag, packageName, ws, historyTag, uid, pid);
                } finally {
                    Binder.restoreCallingIdentity(ident);
                }
            }
        }

        public void releaseWakeLock(IBinder lock, int flags) {
            if (lock == null) {
                throw new IllegalArgumentException("lock must not be null");
            }
            PowerManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.WAKE_LOCK", null);
            long ident = Binder.clearCallingIdentity();
            try {
                PowerManagerService.this.releaseWakeLockInternal(lock, flags);
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }

        public void updateWakeLockUids(IBinder lock, int[] uids) {
            WorkSource ws = null;
            if (uids != null) {
                ws = new WorkSource();
                for (int i = 0; i < uids.length; i += PowerManagerService.WAKE_LOCK_CPU) {
                    ws.add(uids[i]);
                }
            }
            updateWakeLockWorkSource(lock, ws, null);
        }

        public void updateWakeLockWorkSource(IBinder lock, WorkSource ws, String historyTag) {
            if (lock == null) {
                throw new IllegalArgumentException("lock must not be null");
            }
            PowerManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.WAKE_LOCK", null);
            if (ws == null || ws.size() == 0) {
                ws = null;
            } else {
                PowerManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.UPDATE_DEVICE_STATS", null);
            }
            int callingUid = Binder.getCallingUid();
            long ident = Binder.clearCallingIdentity();
            try {
                PowerManagerService.this.updateWakeLockWorkSourceInternal(lock, ws, historyTag, callingUid);
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }

        public boolean isWakeLockLevelSupported(int level) {
            long ident = Binder.clearCallingIdentity();
            try {
                boolean access$3500 = PowerManagerService.this.isWakeLockLevelSupportedInternal(level);
                return access$3500;
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }

        public void userActivity(long eventTime, int event, int flags) {
            long now = SystemClock.uptimeMillis();
            if (PowerManagerService.this.mContext.checkCallingOrSelfPermission("android.permission.DEVICE_POWER") != 0 && PowerManagerService.this.mContext.checkCallingOrSelfPermission("android.permission.USER_ACTIVITY") != 0) {
                synchronized (PowerManagerService.this.mLock) {
                    if (now >= PowerManagerService.this.mLastWarningAboutUserActivityPermission + 300000) {
                        PowerManagerService.this.mLastWarningAboutUserActivityPermission = now;
                        Slog.w(PowerManagerService.TAG, "Ignoring call to PowerManager.userActivity() because the caller does not have DEVICE_POWER or USER_ACTIVITY permission.  Please fix your app!   pid=" + Binder.getCallingPid() + " uid=" + Binder.getCallingUid());
                    }
                }
            } else if (eventTime > SystemClock.uptimeMillis()) {
                throw new IllegalArgumentException("event time must not be in the future");
            } else {
                int uid = Binder.getCallingUid();
                long ident = Binder.clearCallingIdentity();
                try {
                    PowerManagerService.this.userActivityInternal(eventTime, event, flags, uid);
                } finally {
                    Binder.restoreCallingIdentity(ident);
                }
            }
        }

        public void wakeUp(long eventTime) {
            if (eventTime > SystemClock.uptimeMillis()) {
                throw new IllegalArgumentException("event time must not be in the future");
            } else if (SystemProperties.getInt("sys.quickboot.enable", 0) != PowerManagerService.WAKE_LOCK_CPU || PowerManagerService.this.isQuickBootCall()) {
                PowerManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.DEVICE_POWER", null);
                int uid = Binder.getCallingUid();
                long ident = Binder.clearCallingIdentity();
                try {
                    PowerManagerService.this.wakeUpInternal(eventTime, uid);
                } finally {
                    Binder.restoreCallingIdentity(ident);
                }
            } else {
                Slog.d(PowerManagerService.TAG, "ignore wakeup request under QuickBoot");
            }
        }

        public void goToSleep(long eventTime, int reason, int flags) {
            if (eventTime > SystemClock.uptimeMillis()) {
                throw new IllegalArgumentException("event time must not be in the future");
            }
            PowerManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.DEVICE_POWER", null);
            int uid = Binder.getCallingUid();
            long ident = Binder.clearCallingIdentity();
            try {
                PowerManagerService.this.goToSleepInternal(eventTime, reason, flags, uid);
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }

        public void nap(long eventTime) {
            if (eventTime > SystemClock.uptimeMillis()) {
                throw new IllegalArgumentException("event time must not be in the future");
            }
            PowerManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.DEVICE_POWER", null);
            int uid = Binder.getCallingUid();
            long ident = Binder.clearCallingIdentity();
            try {
                PowerManagerService.this.napInternal(eventTime, uid);
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }

        public boolean isInteractive() {
            long ident = Binder.clearCallingIdentity();
            try {
                boolean access$4200 = PowerManagerService.this.isInteractiveInternal();
                return access$4200;
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }

        public boolean isPowerSaveMode() {
            long ident = Binder.clearCallingIdentity();
            try {
                boolean access$4300 = PowerManagerService.this.isLowPowerModeInternal();
                return access$4300;
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }

        public boolean setPowerSaveMode(boolean mode) {
            PowerManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.DEVICE_POWER", null);
            long ident = Binder.clearCallingIdentity();
            try {
                boolean access$4400 = PowerManagerService.this.setLowPowerModeInternal(mode);
                return access$4400;
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }

        public void cpuBoost(int duration) {
            if (duration <= 0 || duration > PowerManagerService.MAX_CPU_BOOST_TIME) {
                Slog.e(PowerManagerService.TAG, "Invalid boost duration: " + duration);
            } else {
                PowerManagerService.nativeCpuBoost(duration);
            }
        }

        public void reboot(boolean confirm, String reason, boolean wait) {
            PowerManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.REBOOT", null);
            if ("recovery".equals(reason)) {
                PowerManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.RECOVERY", null);
            }
            long ident = Binder.clearCallingIdentity();
            try {
                PowerManagerService.this.shutdownOrRebootInternal(PowerManagerService.DEBUG_SPEW, confirm, reason, wait);
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }

        public void shutdown(boolean confirm, boolean wait) {
            PowerManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.REBOOT", null);
            long ident = Binder.clearCallingIdentity();
            try {
                PowerManagerService.this.shutdownOrRebootInternal(true, confirm, null, wait);
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }

        public void crash(String message) {
            PowerManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.REBOOT", null);
            long ident = Binder.clearCallingIdentity();
            try {
                PowerManagerService.this.crashInternal(message);
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }

        public void setStayOnSetting(int val) {
            PowerManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.WRITE_SETTINGS", null);
            long ident = Binder.clearCallingIdentity();
            try {
                PowerManagerService.this.setStayOnSettingInternal(val);
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }

        public void setTemporaryScreenBrightnessSettingOverride(int brightness) {
            PowerManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.DEVICE_POWER", null);
            long ident = Binder.clearCallingIdentity();
            try {
                PowerManagerService.this.setTemporaryScreenBrightnessSettingOverrideInternal(brightness);
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }

        public void setTemporaryScreenAutoBrightnessAdjustmentSettingOverride(float adj) {
            PowerManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.DEVICE_POWER", null);
            long ident = Binder.clearCallingIdentity();
            try {
                PowerManagerService.this.m0xca8cee91(adj);
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }

        public void setAttentionLight(boolean on, int color) {
            PowerManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.DEVICE_POWER", null);
            long ident = Binder.clearCallingIdentity();
            try {
                PowerManagerService.this.setAttentionLightInternal(on, color);
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }

        public void boostScreenBrightness(long eventTime) {
            if (eventTime > SystemClock.uptimeMillis()) {
                throw new IllegalArgumentException("event time must not be in the future");
            }
            PowerManagerService.this.mContext.enforceCallingOrSelfPermission("android.permission.DEVICE_POWER", null);
            int uid = Binder.getCallingUid();
            long ident = Binder.clearCallingIdentity();
            try {
                PowerManagerService.this.boostScreenBrightnessInternal(eventTime, uid);
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }

        protected void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
            if (PowerManagerService.this.mContext.checkCallingOrSelfPermission("android.permission.DUMP") != 0) {
                pw.println("Permission Denial: can't dump PowerManager from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid());
                return;
            }
            long ident = Binder.clearCallingIdentity();
            try {
                PowerManagerService.this.dumpInternal(pw);
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }

        public void updateBlockedUids(int uid, boolean isBlocked) {
            if (Binder.getCallingUid() == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
                synchronized (PowerManagerService.this.mLock) {
                    if (isBlocked) {
                        PowerManagerService.this.mBlockedUids.add(new Integer(uid));
                        int index = 0;
                        while (index < PowerManagerService.this.mWakeLocks.size()) {
                            WakeLock wl = (WakeLock) PowerManagerService.this.mWakeLocks.get(index);
                            if (wl != null) {
                                if (wl.mTag.startsWith("*sync*") && wl.mOwnerUid == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
                                    PowerManagerService.this.releaseWakeLockInternal(wl.mLock, wl.mFlags);
                                    index += PowerManagerService.DEFAULT_SLEEP_TIMEOUT;
                                } else if (wl.mOwnerUid == uid || PowerManagerService.this.checkWorkSourceObjectId(uid, wl)) {
                                    PowerManagerService.this.releaseWakeLockInternal(wl.mLock, wl.mFlags);
                                    index += PowerManagerService.DEFAULT_SLEEP_TIMEOUT;
                                }
                            }
                            index += PowerManagerService.WAKE_LOCK_CPU;
                        }
                    } else {
                        PowerManagerService.this.mBlockedUids.remove(new Integer(uid));
                    }
                }
            }
        }
    }

    private final class DockReceiver extends BroadcastReceiver {
        private DockReceiver() {
        }

        public void onReceive(Context context, Intent intent) {
            synchronized (PowerManagerService.this.mLock) {
                int dockState = intent.getIntExtra("android.intent.extra.DOCK_STATE", 0);
                if (PowerManagerService.this.mDockState != dockState) {
                    PowerManagerService.this.mDockState = dockState;
                    PowerManagerService.access$1076(PowerManagerService.this, PowerManagerService.DIRTY_DOCK_STATE);
                    PowerManagerService.this.updatePowerStateLocked();
                }
            }
        }
    }

    private final class DreamReceiver extends BroadcastReceiver {
        private DreamReceiver() {
        }

        public void onReceive(Context context, Intent intent) {
            synchronized (PowerManagerService.this.mLock) {
                PowerManagerService.this.scheduleSandmanLocked();
            }
        }
    }

    private final class LocalService extends PowerManagerInternal {
        private LocalService() {
        }

        public void setScreenBrightnessOverrideFromWindowManager(int screenBrightness) {
            if (screenBrightness < PowerManagerService.DEFAULT_SLEEP_TIMEOUT || screenBrightness > 255) {
                screenBrightness = PowerManagerService.DEFAULT_SLEEP_TIMEOUT;
            }
            PowerManagerService.this.setScreenBrightnessOverrideFromWindowManagerInternal(screenBrightness);
        }

        public void setButtonBrightnessOverrideFromWindowManager(int screenBrightness) {
        }

        public void setDozeOverrideFromDreamManager(int screenState, int screenBrightness) {
            switch (screenState) {
                case AppTransition.TRANSIT_NONE /*0*/:
                case PowerManagerService.WAKE_LOCK_CPU /*1*/:
                case PowerManagerService.WAKE_LOCK_SCREEN_BRIGHT /*2*/:
                case PowerManagerService.MSG_SCREEN_BRIGHTNESS_BOOST_TIMEOUT /*3*/:
                case PowerManagerService.WAKE_LOCK_SCREEN_DIM /*4*/:
                    break;
                default:
                    screenState = 0;
                    break;
            }
            if (screenBrightness < PowerManagerService.DEFAULT_SLEEP_TIMEOUT || screenBrightness > 255) {
                screenBrightness = PowerManagerService.DEFAULT_SLEEP_TIMEOUT;
            }
            PowerManagerService.this.setDozeOverrideFromDreamManagerInternal(screenState, screenBrightness);
        }

        public void setUserActivityTimeoutOverrideFromWindowManager(long timeoutMillis) {
            PowerManagerService.this.setUserActivityTimeoutOverrideFromWindowManagerInternal(timeoutMillis);
        }

        public void setMaximumScreenOffTimeoutFromDeviceAdmin(int timeMs) {
            PowerManagerService.this.setMaximumScreenOffTimeoutFromDeviceAdminInternal(timeMs);
        }

        public boolean getLowPowerModeEnabled() {
            boolean access$600;
            synchronized (PowerManagerService.this.mLock) {
                access$600 = PowerManagerService.this.mLowPowerModeEnabled;
            }
            return access$600;
        }

        public void registerLowPowerModeObserver(LowPowerModeListener listener) {
            synchronized (PowerManagerService.this.mLock) {
                PowerManagerService.this.mLowPowerModeListeners.add(listener);
            }
        }
    }

    private final class PowerManagerHandler extends Handler {
        public PowerManagerHandler(Looper looper) {
            super(looper, null, true);
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case PowerManagerService.WAKE_LOCK_CPU /*1*/:
                    PowerManagerService.this.handleUserActivityTimeout();
                case PowerManagerService.WAKE_LOCK_SCREEN_BRIGHT /*2*/:
                    PowerManagerService.this.handleSandman();
                case PowerManagerService.MSG_SCREEN_BRIGHTNESS_BOOST_TIMEOUT /*3*/:
                    PowerManagerService.this.handleScreenBrightnessBoostTimeout();
                default:
            }
        }
    }

    private final class SettingsObserver extends ContentObserver {
        public SettingsObserver(Handler handler) {
            super(handler);
        }

        public void onChange(boolean selfChange, Uri uri) {
            synchronized (PowerManagerService.this.mLock) {
                PowerManagerService.this.handleSettingsChangedLocked();
            }
        }
    }

    private final class SuspendBlockerImpl implements SuspendBlocker {
        private final String mName;
        private int mReferenceCount;
        private final String mTraceName;

        public SuspendBlockerImpl(String name) {
            this.mName = name;
            this.mTraceName = "SuspendBlocker (" + name + ")";
        }

        protected void finalize() throws Throwable {
            try {
                if (this.mReferenceCount != 0) {
                    Slog.wtf(PowerManagerService.TAG, "Suspend blocker \"" + this.mName + "\" was finalized without being released!");
                    this.mReferenceCount = 0;
                    PowerManagerService.nativeReleaseSuspendBlocker(this.mName);
                    Trace.asyncTraceEnd(131072, this.mTraceName, 0);
                }
                super.finalize();
            } catch (Throwable th) {
                super.finalize();
            }
        }

        public void acquire() {
            synchronized (this) {
                this.mReferenceCount += PowerManagerService.WAKE_LOCK_CPU;
                if (this.mReferenceCount == PowerManagerService.WAKE_LOCK_CPU) {
                    Trace.asyncTraceBegin(131072, this.mTraceName, 0);
                    PowerManagerService.nativeAcquireSuspendBlocker(this.mName);
                }
            }
        }

        public void release() {
            synchronized (this) {
                this.mReferenceCount += PowerManagerService.DEFAULT_SLEEP_TIMEOUT;
                if (this.mReferenceCount == 0) {
                    PowerManagerService.nativeReleaseSuspendBlocker(this.mName);
                    Trace.asyncTraceEnd(131072, this.mTraceName, 0);
                } else if (this.mReferenceCount < 0) {
                    Slog.wtf(PowerManagerService.TAG, "Suspend blocker \"" + this.mName + "\" was released without being acquired!", new Throwable());
                    this.mReferenceCount = 0;
                }
            }
        }

        public String toString() {
            String str;
            synchronized (this) {
                str = this.mName + ": ref count=" + this.mReferenceCount;
            }
            return str;
        }
    }

    private final class UserSwitchedReceiver extends BroadcastReceiver {
        private UserSwitchedReceiver() {
        }

        public void onReceive(Context context, Intent intent) {
            synchronized (PowerManagerService.this.mLock) {
                PowerManagerService.this.handleSettingsChangedLocked();
            }
        }
    }

    private final class WakeLock implements DeathRecipient {
        public int mFlags;
        public String mHistoryTag;
        public final IBinder mLock;
        public boolean mNotifiedAcquired;
        public final int mOwnerPid;
        public final int mOwnerUid;
        public final String mPackageName;
        public String mTag;
        public WorkSource mWorkSource;

        public WakeLock(IBinder lock, int flags, String tag, String packageName, WorkSource workSource, String historyTag, int ownerUid, int ownerPid) {
            this.mLock = lock;
            this.mFlags = flags;
            this.mTag = tag;
            this.mPackageName = packageName;
            this.mWorkSource = PowerManagerService.copyWorkSource(workSource);
            this.mHistoryTag = historyTag;
            this.mOwnerUid = ownerUid;
            this.mOwnerPid = ownerPid;
        }

        public void binderDied() {
            PowerManagerService.this.handleWakeLockDeath(this);
        }

        public boolean hasSameProperties(int flags, String tag, WorkSource workSource, int ownerUid, int ownerPid) {
            return (this.mFlags == flags && this.mTag.equals(tag) && hasSameWorkSource(workSource) && this.mOwnerUid == ownerUid && this.mOwnerPid == ownerPid) ? true : PowerManagerService.DEBUG_SPEW;
        }

        public void updateProperties(int flags, String tag, String packageName, WorkSource workSource, String historyTag, int ownerUid, int ownerPid) {
            if (!this.mPackageName.equals(packageName)) {
                throw new IllegalStateException("Existing wake lock package name changed: " + this.mPackageName + " to " + packageName);
            } else if (this.mOwnerUid != ownerUid) {
                throw new IllegalStateException("Existing wake lock uid changed: " + this.mOwnerUid + " to " + ownerUid);
            } else if (this.mOwnerPid != ownerPid) {
                throw new IllegalStateException("Existing wake lock pid changed: " + this.mOwnerPid + " to " + ownerPid);
            } else {
                this.mFlags = flags;
                this.mTag = tag;
                updateWorkSource(workSource);
                this.mHistoryTag = historyTag;
            }
        }

        public boolean hasSameWorkSource(WorkSource workSource) {
            return Objects.equal(this.mWorkSource, workSource);
        }

        public void updateWorkSource(WorkSource workSource) {
            this.mWorkSource = PowerManagerService.copyWorkSource(workSource);
        }

        public String toString() {
            return getLockLevelString() + " '" + this.mTag + "'" + getLockFlagsString() + " (uid=" + this.mOwnerUid + ", pid=" + this.mOwnerPid + ", ws=" + this.mWorkSource + ")";
        }

        private String getLockLevelString() {
            switch (this.mFlags & 65535) {
                case PowerManagerService.WAKE_LOCK_CPU /*1*/:
                    return "PARTIAL_WAKE_LOCK             ";
                case C0569H.REMOVE_STARTING /*6*/:
                    return "SCREEN_DIM_WAKE_LOCK          ";
                case AppTransition.TRANSIT_TASK_TO_FRONT /*10*/:
                    return "SCREEN_BRIGHT_WAKE_LOCK       ";
                case C0569H.DO_ANIMATION_CALLBACK /*26*/:
                    return "FULL_WAKE_LOCK                ";
                case PowerManagerService.WAKE_LOCK_STAY_AWAKE /*32*/:
                    return "PROXIMITY_SCREEN_OFF_WAKE_LOCK";
                case PowerManagerService.WAKE_LOCK_DOZE /*64*/:
                    return "DOZE_WAKE_LOCK                ";
                default:
                    return "???                           ";
            }
        }

        private String getLockFlagsString() {
            String result = "";
            if ((this.mFlags & 268435456) != 0) {
                result = result + " ACQUIRE_CAUSES_WAKEUP";
            }
            if ((this.mFlags & 536870912) != 0) {
                return result + " ON_AFTER_RELEASE";
            }
            return result;
        }
    }

    private static native void nativeAcquireSuspendBlocker(String str);

    private static native void nativeCpuBoost(int i);

    private native void nativeInit();

    private static native void nativeReleaseSuspendBlocker(String str);

    private static native void nativeSendPowerHint(int i, int i2);

    private static native void nativeSetAutoSuspend(boolean z);

    private static native void nativeSetInteractive(boolean z);

    private void shutdownOrRebootInternal(boolean r5, boolean r6, java.lang.String r7, boolean r8) {
        /* JADX: method processing error */
/*
        Error: java.lang.StackOverflowError
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.computeBlockDF(BlockProcessor.java:153)
*/
        /*
        r4 = this;
        r2 = r4.mHandler;
        if (r2 == 0) goto L_0x0008;
    L_0x0004:
        r2 = r4.mSystemReady;
        if (r2 != 0) goto L_0x0010;
    L_0x0008:
        r2 = new java.lang.IllegalStateException;
        r3 = "Too early to call shutdown() or reboot()";
        r2.<init>(r3);
        throw r2;
    L_0x0010:
        r1 = new com.android.server.power.PowerManagerService$3;
        r1.<init>(r5, r6, r7);
        r2 = r4.mHandler;
        r0 = android.os.Message.obtain(r2, r1);
        r2 = 1;
        r0.setAsynchronous(r2);
        r2 = r4.mHandler;
        r2.sendMessage(r0);
        if (r8 == 0) goto L_0x0030;
    L_0x0026:
        monitor-enter(r1);
    L_0x0027:
        r1.wait();	 Catch:{ InterruptedException -> 0x002b }
        goto L_0x0027;
    L_0x002b:
        r2 = move-exception;
        goto L_0x0027;
    L_0x002d:
        r2 = move-exception;
        monitor-exit(r1);	 Catch:{ all -> 0x002d }
        throw r2;
    L_0x0030:
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.power.PowerManagerService.shutdownOrRebootInternal(boolean, boolean, java.lang.String, boolean):void");
    }

    static /* synthetic */ int access$1076(PowerManagerService x0, int x1) {
        int i = x0.mDirty | x1;
        x0.mDirty = i;
        return i;
    }

    public PowerManagerService(Context context) {
        super(context);
        this.mLock = new Object();
        this.mSuspendBlockers = new ArrayList();
        this.mWakeLocks = new ArrayList();
        this.mDisplayPowerRequest = new DisplayPowerRequest();
        this.mDockState = 0;
        this.mMaximumScreenOffTimeoutFromDeviceAdmin = Integer.MAX_VALUE;
        this.mScreenBrightnessOverrideFromWindowManager = DEFAULT_SLEEP_TIMEOUT;
        this.mUserActivityTimeoutOverrideFromWindowManager = -1;
        this.mTemporaryScreenBrightnessSettingOverride = DEFAULT_SLEEP_TIMEOUT;
        this.mTemporaryScreenAutoBrightnessAdjustmentSettingOverride = Float.NaN;
        this.mDozeScreenStateOverrideFromDreamManager = 0;
        this.mDozeScreenBrightnessOverrideFromDreamManager = DEFAULT_SLEEP_TIMEOUT;
        this.mLastWarningAboutUserActivityPermission = Long.MIN_VALUE;
        this.mLowPowerModeListeners = new ArrayList();
        this.mBlockedUids = new ArrayList();
        this.mDisplayPowerCallbacks = new C04692();
        this.mContext = context;
        this.mHandlerThread = new ServiceThread(TAG, -4, DEBUG_SPEW);
        this.mHandlerThread.start();
        this.mHandler = new PowerManagerHandler(this.mHandlerThread.getLooper());
        synchronized (this.mLock) {
            this.mWakeLockSuspendBlocker = createSuspendBlockerLocked("PowerManagerService.WakeLocks");
            this.mDisplaySuspendBlocker = createSuspendBlockerLocked("PowerManagerService.Display");
            this.mDisplaySuspendBlocker.acquire();
            this.mHoldingDisplaySuspendBlocker = true;
            this.mHalAutoSuspendModeEnabled = DEBUG_SPEW;
            this.mHalInteractiveModeEnabled = true;
            this.mWakefulness = WAKE_LOCK_CPU;
            nativeInit();
            nativeSetAutoSuspend(DEBUG_SPEW);
            nativeSetInteractive(true);
        }
    }

    public void onStart() {
        publishBinderService("power", new BinderService());
        publishLocalService(PowerManagerInternal.class, new LocalService());
        Watchdog.getInstance().addMonitor(this);
        Watchdog.getInstance().addThread(this.mHandler);
    }

    public void onBootPhase(int phase) {
        synchronized (this.mLock) {
            if (phase == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
                long now = SystemClock.uptimeMillis();
                this.mBootCompleted = true;
                this.mDirty |= WAKE_LOCK_PROXIMITY_SCREEN_OFF;
                userActivityNoUpdateLocked(now, 0, 0, ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE);
                updatePowerStateLocked();
            }
        }
    }

    public void systemReady(IAppOpsService appOps) {
        synchronized (this.mLock) {
            this.mSystemReady = true;
            this.mAppOps = appOps;
            this.mDreamManager = (DreamManagerInternal) getLocalService(DreamManagerInternal.class);
            this.mDisplayManagerInternal = (DisplayManagerInternal) getLocalService(DisplayManagerInternal.class);
            this.mPolicy = (WindowManagerPolicy) getLocalService(WindowManagerPolicy.class);
            this.mBatteryManagerInternal = (BatteryManagerInternal) getLocalService(BatteryManagerInternal.class);
            PowerManager pm = (PowerManager) this.mContext.getSystemService("power");
            this.mScreenBrightnessSettingMinimum = pm.getMinimumScreenBrightnessSetting();
            this.mScreenBrightnessSettingMaximum = pm.getMaximumScreenBrightnessSetting();
            this.mScreenBrightnessSettingDefault = pm.getDefaultScreenBrightnessSetting();
            SensorManager sensorManager = new SystemSensorManager(this.mContext, this.mHandler.getLooper());
            this.mBatteryStats = BatteryStatsService.getService();
            this.mNotifier = new Notifier(Looper.getMainLooper(), this.mContext, this.mBatteryStats, this.mAppOps, createSuspendBlockerLocked("PowerManagerService.Broadcasts"), this.mPolicy);
            this.mWirelessChargerDetector = new WirelessChargerDetector(sensorManager, createSuspendBlockerLocked("PowerManagerService.WirelessChargerDetector"), this.mHandler);
            this.mSettingsObserver = new SettingsObserver(this.mHandler);
            this.mLightsManager = (LightsManager) getLocalService(LightsManager.class);
            this.mAttentionLight = this.mLightsManager.getLight(POWER_HINT_LOW_POWER);
            this.mButtonsLight = this.mLightsManager.getLight(WAKE_LOCK_SCREEN_BRIGHT);
            this.mDisplayManagerInternal.initPowerManagement(this.mDisplayPowerCallbacks, this.mHandler, sensorManager);
            IntentFilter filter = new IntentFilter();
            filter.addAction("android.intent.action.BATTERY_CHANGED");
            filter.setPriority(ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE);
            this.mContext.registerReceiver(new BatteryReceiver(), filter, null, this.mHandler);
            filter = new IntentFilter();
            filter.addAction("android.intent.action.DREAMING_STARTED");
            filter.addAction("android.intent.action.DREAMING_STOPPED");
            this.mContext.registerReceiver(new DreamReceiver(), filter, null, this.mHandler);
            filter = new IntentFilter();
            filter.addAction("android.intent.action.USER_SWITCHED");
            this.mContext.registerReceiver(new UserSwitchedReceiver(), filter, null, this.mHandler);
            filter = new IntentFilter();
            filter.addAction("android.intent.action.DOCK_EVENT");
            this.mContext.registerReceiver(new DockReceiver(), filter, null, this.mHandler);
            ContentResolver resolver = this.mContext.getContentResolver();
            resolver.registerContentObserver(Secure.getUriFor("screensaver_enabled"), DEBUG_SPEW, this.mSettingsObserver, DEFAULT_SLEEP_TIMEOUT);
            resolver.registerContentObserver(Secure.getUriFor("screensaver_activate_on_sleep"), DEBUG_SPEW, this.mSettingsObserver, DEFAULT_SLEEP_TIMEOUT);
            resolver.registerContentObserver(Secure.getUriFor("screensaver_activate_on_dock"), DEBUG_SPEW, this.mSettingsObserver, DEFAULT_SLEEP_TIMEOUT);
            resolver.registerContentObserver(System.getUriFor("screen_off_timeout"), DEBUG_SPEW, this.mSettingsObserver, DEFAULT_SLEEP_TIMEOUT);
            resolver.registerContentObserver(Secure.getUriFor("sleep_timeout"), DEBUG_SPEW, this.mSettingsObserver, DEFAULT_SLEEP_TIMEOUT);
            resolver.registerContentObserver(Global.getUriFor("stay_on_while_plugged_in"), DEBUG_SPEW, this.mSettingsObserver, DEFAULT_SLEEP_TIMEOUT);
            resolver.registerContentObserver(System.getUriFor("screen_brightness"), DEBUG_SPEW, this.mSettingsObserver, DEFAULT_SLEEP_TIMEOUT);
            resolver.registerContentObserver(System.getUriFor("screen_brightness_mode"), DEBUG_SPEW, this.mSettingsObserver, DEFAULT_SLEEP_TIMEOUT);
            resolver.registerContentObserver(System.getUriFor("screen_auto_brightness_adj"), DEBUG_SPEW, this.mSettingsObserver, DEFAULT_SLEEP_TIMEOUT);
            resolver.registerContentObserver(Global.getUriFor("low_power"), DEBUG_SPEW, this.mSettingsObserver, DEFAULT_SLEEP_TIMEOUT);
            resolver.registerContentObserver(Global.getUriFor("low_power_trigger_level"), DEBUG_SPEW, this.mSettingsObserver, DEFAULT_SLEEP_TIMEOUT);
            resolver.registerContentObserver(Global.getUriFor("theater_mode_on"), DEBUG_SPEW, this.mSettingsObserver, DEFAULT_SLEEP_TIMEOUT);
            readConfigurationLocked();
            updateSettingsLocked();
            this.mDirty |= DIRTY_BATTERY_STATE;
            updatePowerStateLocked();
        }
    }

    private void readConfigurationLocked() {
        Resources resources = this.mContext.getResources();
        this.mDecoupleHalAutoSuspendModeFromDisplayConfig = resources.getBoolean(17956969);
        this.mDecoupleHalInteractiveModeFromDisplayConfig = resources.getBoolean(17956970);
        this.mWakeUpWhenPluggedOrUnpluggedConfig = resources.getBoolean(17956899);
        this.mWakeUpWhenPluggedOrUnpluggedInTheaterModeConfig = resources.getBoolean(17956903);
        this.mSuspendWhenScreenOffDueToProximityConfig = resources.getBoolean(17956920);
        this.mDreamsSupportedConfig = resources.getBoolean(17956963);
        this.mDreamsEnabledByDefaultConfig = resources.getBoolean(17956964);
        this.mDreamsActivatedOnSleepByDefaultConfig = resources.getBoolean(17956966);
        this.mDreamsActivatedOnDockByDefaultConfig = resources.getBoolean(17956965);
        this.mDreamsEnabledOnBatteryConfig = resources.getBoolean(17956967);
        this.mDreamsBatteryLevelMinimumWhenPoweredConfig = resources.getInteger(17694833);
        this.mDreamsBatteryLevelMinimumWhenNotPoweredConfig = resources.getInteger(17694834);
        this.mDreamsBatteryLevelDrainCutoffConfig = resources.getInteger(17694835);
        this.mDozeAfterScreenOffConfig = resources.getBoolean(17956968);
        this.mMinimumScreenOffTimeoutConfig = resources.getInteger(17694836);
        this.mMaximumScreenDimDurationConfig = resources.getInteger(17694837);
        this.mMaximumScreenDimRatioConfig = resources.getFraction(18022402, WAKE_LOCK_CPU, WAKE_LOCK_CPU);
    }

    private void updateSettingsLocked() {
        int i;
        boolean z;
        boolean lowPowerModeEnabled;
        boolean autoLowPowerModeConfigured;
        ContentResolver resolver = this.mContext.getContentResolver();
        String str = "screensaver_enabled";
        if (this.mDreamsEnabledByDefaultConfig) {
            i = WAKE_LOCK_CPU;
        } else {
            i = 0;
        }
        this.mDreamsEnabledSetting = Secure.getIntForUser(resolver, str, i, -2) != 0 ? true : DEBUG_SPEW;
        str = "screensaver_activate_on_sleep";
        if (this.mDreamsActivatedOnSleepByDefaultConfig) {
            i = WAKE_LOCK_CPU;
        } else {
            i = 0;
        }
        this.mDreamsActivateOnSleepSetting = Secure.getIntForUser(resolver, str, i, -2) != 0 ? true : DEBUG_SPEW;
        str = "screensaver_activate_on_dock";
        if (this.mDreamsActivatedOnDockByDefaultConfig) {
            i = WAKE_LOCK_CPU;
        } else {
            i = 0;
        }
        if (Secure.getIntForUser(resolver, str, i, -2) != 0) {
            z = true;
        } else {
            z = DEBUG_SPEW;
        }
        this.mDreamsActivateOnDockSetting = z;
        this.mScreenOffTimeoutSetting = System.getIntForUser(resolver, "screen_off_timeout", DEFAULT_SCREEN_OFF_TIMEOUT, -2);
        this.mSleepTimeoutSetting = Secure.getIntForUser(resolver, "sleep_timeout", DEFAULT_SLEEP_TIMEOUT, -2);
        this.mStayOnWhilePluggedInSetting = Global.getInt(resolver, "stay_on_while_plugged_in", WAKE_LOCK_CPU);
        this.mTheaterModeEnabled = Global.getInt(this.mContext.getContentResolver(), "theater_mode_on", 0) == WAKE_LOCK_CPU ? true : DEBUG_SPEW;
        int oldScreenBrightnessSetting = this.mScreenBrightnessSetting;
        this.mScreenBrightnessSetting = System.getIntForUser(resolver, "screen_brightness", this.mScreenBrightnessSettingDefault, -2);
        if (oldScreenBrightnessSetting != this.mScreenBrightnessSetting) {
            this.mTemporaryScreenBrightnessSettingOverride = DEFAULT_SLEEP_TIMEOUT;
        }
        float oldScreenAutoBrightnessAdjustmentSetting = this.mScreenAutoBrightnessAdjustmentSetting;
        this.mScreenAutoBrightnessAdjustmentSetting = System.getFloatForUser(resolver, "screen_auto_brightness_adj", 0.0f, -2);
        if (oldScreenAutoBrightnessAdjustmentSetting != this.mScreenAutoBrightnessAdjustmentSetting) {
            this.mTemporaryScreenAutoBrightnessAdjustmentSettingOverride = Float.NaN;
        }
        this.mScreenBrightnessModeSetting = System.getIntForUser(resolver, "screen_brightness_mode", 0, -2);
        if (Global.getInt(resolver, "low_power", 0) != 0) {
            lowPowerModeEnabled = true;
        } else {
            lowPowerModeEnabled = DEBUG_SPEW;
        }
        if (Global.getInt(resolver, "low_power_trigger_level", 0) != 0) {
            autoLowPowerModeConfigured = true;
        } else {
            autoLowPowerModeConfigured = DEBUG_SPEW;
        }
        if (!(lowPowerModeEnabled == this.mLowPowerModeSetting && autoLowPowerModeConfigured == this.mAutoLowPowerModeConfigured)) {
            this.mLowPowerModeSetting = lowPowerModeEnabled;
            this.mAutoLowPowerModeConfigured = autoLowPowerModeConfigured;
            updateLowPowerModeLocked();
        }
        this.mDirty |= WAKE_LOCK_STAY_AWAKE;
    }

    void updateLowPowerModeLocked() {
        boolean lowPowerModeEnabled;
        int i = WAKE_LOCK_CPU;
        if (this.mIsPowered && this.mLowPowerModeSetting) {
            Global.putInt(this.mContext.getContentResolver(), "low_power", 0);
            this.mLowPowerModeSetting = DEBUG_SPEW;
        }
        boolean autoLowPowerModeEnabled;
        if (this.mIsPowered || !this.mAutoLowPowerModeConfigured || this.mAutoLowPowerModeSnoozing || !this.mBatteryLevelLow) {
            autoLowPowerModeEnabled = DEBUG_SPEW;
        } else {
            autoLowPowerModeEnabled = true;
        }
        if (this.mLowPowerModeSetting || autoLowPowerModeEnabled) {
            lowPowerModeEnabled = true;
        } else {
            lowPowerModeEnabled = DEBUG_SPEW;
        }
        if (this.mLowPowerModeEnabled != lowPowerModeEnabled) {
            this.mLowPowerModeEnabled = lowPowerModeEnabled;
            if (!lowPowerModeEnabled) {
                i = 0;
            }
            powerHintInternal(POWER_HINT_LOW_POWER, i);
            BackgroundThread.getHandler().post(new C04681(lowPowerModeEnabled));
        }
    }

    private void handleSettingsChangedLocked() {
        updateSettingsLocked();
        updatePowerStateLocked();
    }

    private void acquireWakeLockInternal(IBinder lock, int flags, String tag, String packageName, WorkSource ws, String historyTag, int uid, int pid) {
        synchronized (this.mLock) {
            if (!this.mBlockedUids.contains(new Integer(uid)) || uid == Process.myUid()) {
                WakeLock wakeLock;
                boolean notifyAcquire;
                int index = findWakeLockIndexLocked(lock);
                if (index >= 0) {
                    wakeLock = (WakeLock) this.mWakeLocks.get(index);
                    if (!wakeLock.hasSameProperties(flags, tag, ws, uid, pid)) {
                        notifyWakeLockChangingLocked(wakeLock, flags, tag, packageName, uid, pid, ws, historyTag);
                        wakeLock.updateProperties(flags, tag, packageName, ws, historyTag, uid, pid);
                    }
                    notifyAcquire = DEBUG_SPEW;
                } else {
                    wakeLock = new WakeLock(lock, flags, tag, packageName, ws, historyTag, uid, pid);
                    try {
                        lock.linkToDeath(wakeLock, 0);
                        this.mWakeLocks.add(wakeLock);
                        notifyAcquire = true;
                    } catch (RemoteException e) {
                        throw new IllegalArgumentException("Wake lock is already dead.");
                    }
                }
                applyWakeLockFlagsOnAcquireLocked(wakeLock, uid);
                this.mDirty |= WAKE_LOCK_CPU;
                updatePowerStateLocked();
                if (notifyAcquire) {
                    notifyWakeLockAcquiredLocked(wakeLock);
                }
                return;
            }
        }
    }

    private static boolean isScreenLock(WakeLock wakeLock) {
        switch (wakeLock.mFlags & 65535) {
            case C0569H.REMOVE_STARTING /*6*/:
            case AppTransition.TRANSIT_TASK_TO_FRONT /*10*/:
            case C0569H.DO_ANIMATION_CALLBACK /*26*/:
                return true;
            default:
                return DEBUG_SPEW;
        }
    }

    private void applyWakeLockFlagsOnAcquireLocked(WakeLock wakeLock, int uid) {
        if ((wakeLock.mFlags & 268435456) != 0 && isScreenLock(wakeLock)) {
            wakeUpNoUpdateLocked(SystemClock.uptimeMillis(), uid);
        }
    }

    private void releaseWakeLockInternal(IBinder lock, int flags) {
        synchronized (this.mLock) {
            int index = findWakeLockIndexLocked(lock);
            if (index < 0) {
                return;
            }
            WakeLock wakeLock = (WakeLock) this.mWakeLocks.get(index);
            if ((flags & WAKE_LOCK_CPU) != 0) {
                this.mRequestWaitForNegativeProximity = true;
            }
            wakeLock.mLock.unlinkToDeath(wakeLock, 0);
            removeWakeLockLocked(wakeLock, index);
        }
    }

    private void handleWakeLockDeath(WakeLock wakeLock) {
        synchronized (this.mLock) {
            int index = this.mWakeLocks.indexOf(wakeLock);
            if (index < 0) {
                return;
            }
            removeWakeLockLocked(wakeLock, index);
        }
    }

    private void removeWakeLockLocked(WakeLock wakeLock, int index) {
        this.mWakeLocks.remove(index);
        notifyWakeLockReleasedLocked(wakeLock);
        applyWakeLockFlagsOnReleaseLocked(wakeLock);
        this.mDirty |= WAKE_LOCK_CPU;
        updatePowerStateLocked();
    }

    private void applyWakeLockFlagsOnReleaseLocked(WakeLock wakeLock) {
        if ((wakeLock.mFlags & 536870912) != 0 && isScreenLock(wakeLock)) {
            userActivityNoUpdateLocked(SystemClock.uptimeMillis(), 0, WAKE_LOCK_CPU, wakeLock.mOwnerUid);
        }
    }

    private void updateWakeLockWorkSourceInternal(IBinder lock, WorkSource ws, String historyTag, int callingUid) {
        synchronized (this.mLock) {
            int index = findWakeLockIndexLocked(lock);
            int value = SystemProperties.getInt("persist.dpm.feature", 0);
            boolean isNsrmEnabled = DEBUG_SPEW;
            if ((value & WAKE_LOCK_SCREEN_DIM) == WAKE_LOCK_SCREEN_DIM) {
                isNsrmEnabled = true;
            }
            if (index >= 0) {
                WakeLock wakeLock = (WakeLock) this.mWakeLocks.get(index);
                if (!wakeLock.hasSameWorkSource(ws)) {
                    notifyWakeLockChangingLocked(wakeLock, wakeLock.mFlags, wakeLock.mTag, wakeLock.mPackageName, wakeLock.mOwnerUid, wakeLock.mOwnerPid, ws, historyTag);
                    wakeLock.mHistoryTag = historyTag;
                    wakeLock.updateWorkSource(ws);
                }
            } else if (isNsrmEnabled) {
            } else {
                throw new IllegalArgumentException("Wake lock not active: " + lock + " from uid " + callingUid);
            }
        }
    }

    private boolean checkWorkSourceObjectId(int uid, WakeLock wl) {
        int index = 0;
        while (index < wl.mWorkSource.size()) {
            try {
                if (uid == wl.mWorkSource.get(index)) {
                    return true;
                }
                index += WAKE_LOCK_CPU;
            } catch (Exception e) {
                return DEBUG_SPEW;
            }
        }
        return DEBUG_SPEW;
    }

    private int findWakeLockIndexLocked(IBinder lock) {
        int count = this.mWakeLocks.size();
        for (int i = 0; i < count; i += WAKE_LOCK_CPU) {
            if (((WakeLock) this.mWakeLocks.get(i)).mLock == lock) {
                return i;
            }
        }
        return DEFAULT_SLEEP_TIMEOUT;
    }

    private void notifyWakeLockAcquiredLocked(WakeLock wakeLock) {
        if (this.mSystemReady) {
            wakeLock.mNotifiedAcquired = true;
            this.mNotifier.onWakeLockAcquired(wakeLock.mFlags, wakeLock.mTag, wakeLock.mPackageName, wakeLock.mOwnerUid, wakeLock.mOwnerPid, wakeLock.mWorkSource, wakeLock.mHistoryTag);
        }
    }

    private void notifyWakeLockChangingLocked(WakeLock wakeLock, int flags, String tag, String packageName, int uid, int pid, WorkSource ws, String historyTag) {
        if (this.mSystemReady && wakeLock.mNotifiedAcquired) {
            this.mNotifier.onWakeLockChanging(wakeLock.mFlags, wakeLock.mTag, wakeLock.mPackageName, wakeLock.mOwnerUid, wakeLock.mOwnerPid, wakeLock.mWorkSource, wakeLock.mHistoryTag, flags, tag, packageName, uid, pid, ws, historyTag);
        }
    }

    private void notifyWakeLockReleasedLocked(WakeLock wakeLock) {
        if (this.mSystemReady && wakeLock.mNotifiedAcquired) {
            wakeLock.mNotifiedAcquired = DEBUG_SPEW;
            this.mNotifier.onWakeLockReleased(wakeLock.mFlags, wakeLock.mTag, wakeLock.mPackageName, wakeLock.mOwnerUid, wakeLock.mOwnerPid, wakeLock.mWorkSource, wakeLock.mHistoryTag);
        }
    }

    private boolean isWakeLockLevelSupportedInternal(int level) {
        boolean z = true;
        synchronized (this.mLock) {
            switch (level) {
                case WAKE_LOCK_CPU /*1*/:
                case C0569H.REMOVE_STARTING /*6*/:
                case AppTransition.TRANSIT_TASK_TO_FRONT /*10*/:
                case C0569H.DO_ANIMATION_CALLBACK /*26*/:
                case WAKE_LOCK_DOZE /*64*/:
                    return true;
                case WAKE_LOCK_STAY_AWAKE /*32*/:
                    if (!(this.mSystemReady && this.mDisplayManagerInternal.isProximitySensorAvailable())) {
                        z = DEBUG_SPEW;
                    }
                    return z;
                default:
                    return DEBUG_SPEW;
            }
        }
    }

    private boolean isQuickBootCall() {
        List<RunningAppProcessInfo> runningList = ((ActivityManager) this.mContext.getSystemService("activity")).getRunningAppProcesses();
        int callingPid = Binder.getCallingPid();
        for (RunningAppProcessInfo processInfo : runningList) {
            if (processInfo.pid == callingPid) {
                if ("com.qapp.quickboot".equals(processInfo.processName)) {
                    return true;
                }
            }
        }
        return DEBUG_SPEW;
    }

    private void userActivityFromNative(long eventTime, int event, int flags) {
        userActivityInternal(eventTime, event, flags, ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE);
    }

    private void userActivityInternal(long eventTime, int event, int flags, int uid) {
        synchronized (this.mLock) {
            if (userActivityNoUpdateLocked(eventTime, event, flags, uid)) {
                updatePowerStateLocked();
            }
        }
    }

    private boolean userActivityNoUpdateLocked(long eventTime, int event, int flags, int uid) {
        if (eventTime < this.mLastSleepTime || eventTime < this.mLastWakeTime || !this.mBootCompleted || !this.mSystemReady) {
            return DEBUG_SPEW;
        }
        Trace.traceBegin(131072, "userActivity");
        try {
            if (eventTime > this.mLastInteractivePowerHintTime) {
                powerHintInternal(WAKE_LOCK_SCREEN_BRIGHT, 0);
                this.mLastInteractivePowerHintTime = eventTime;
            }
            this.mNotifier.onUserActivity(event, uid);
            if (this.mWakefulness == 0 || this.mWakefulness == MSG_SCREEN_BRIGHTNESS_BOOST_TIMEOUT || (flags & WAKE_LOCK_SCREEN_BRIGHT) != 0) {
                Trace.traceEnd(131072);
                return DEBUG_SPEW;
            }
            if ((flags & WAKE_LOCK_CPU) != 0) {
                if (eventTime > this.mLastUserActivityTimeNoChangeLights && eventTime > this.mLastUserActivityTime) {
                    this.mLastUserActivityTimeNoChangeLights = eventTime;
                    this.mDirty |= WAKE_LOCK_SCREEN_DIM;
                    Trace.traceEnd(131072);
                    return true;
                }
            } else if (eventTime > this.mLastUserActivityTime) {
                this.mLastUserActivityTime = eventTime;
                this.mDirty |= WAKE_LOCK_SCREEN_DIM;
                Trace.traceEnd(131072);
                return true;
            }
            Trace.traceEnd(131072);
            return DEBUG_SPEW;
        } catch (Throwable th) {
            Trace.traceEnd(131072);
        }
    }

    private void wakeUpInternal(long eventTime, int uid) {
        synchronized (this.mLock) {
            if (wakeUpNoUpdateLocked(eventTime, uid)) {
                updatePowerStateLocked();
            }
        }
    }

    private boolean wakeUpNoUpdateLocked(long eventTime, int uid) {
        if (eventTime < this.mLastSleepTime || this.mWakefulness == WAKE_LOCK_CPU || !this.mBootCompleted || !this.mSystemReady) {
            return DEBUG_SPEW;
        }
        Trace.traceBegin(131072, "wakeUp");
        try {
            switch (this.mWakefulness) {
                case AppTransition.TRANSIT_NONE /*0*/:
                    Slog.i(TAG, "Waking up from sleep (uid " + uid + ")...");
                    break;
                case WAKE_LOCK_SCREEN_BRIGHT /*2*/:
                    Slog.i(TAG, "Waking up from dream (uid " + uid + ")...");
                    break;
                case MSG_SCREEN_BRIGHTNESS_BOOST_TIMEOUT /*3*/:
                    Slog.i(TAG, "Waking up from dozing (uid " + uid + ")...");
                    break;
            }
            this.mLastWakeTime = eventTime;
            setWakefulnessLocked(WAKE_LOCK_CPU, 0);
            userActivityNoUpdateLocked(eventTime, 0, 0, uid);
            return true;
        } finally {
            Trace.traceEnd(131072);
        }
    }

    private void enableQbCharger(boolean enable) {
        if (SystemProperties.getInt("sys.quickboot.enable", 0) == WAKE_LOCK_CPU && SystemProperties.getInt("sys.quickboot.poweroff", 0) != WAKE_LOCK_CPU && enable && this.mIsPowered && !isInteractiveInternal()) {
            SystemProperties.set("sys.qbcharger.enable", "true");
        }
    }

    private void goToSleepInternal(long eventTime, int reason, int flags, int uid) {
        synchronized (this.mLock) {
            if (goToSleepNoUpdateLocked(eventTime, reason, flags, uid)) {
                updatePowerStateLocked();
            }
        }
    }

    private boolean goToSleepNoUpdateLocked(long eventTime, int reason, int flags, int uid) {
        if (eventTime < this.mLastWakeTime || this.mWakefulness == 0 || this.mWakefulness == MSG_SCREEN_BRIGHTNESS_BOOST_TIMEOUT || !this.mBootCompleted || !this.mSystemReady) {
            return DEBUG_SPEW;
        }
        Trace.traceBegin(131072, "goToSleep");
        switch (reason) {
            case WAKE_LOCK_CPU /*1*/:
                Slog.i(TAG, "Going to sleep due to device administration policy (uid " + uid + ")...");
                break;
            case WAKE_LOCK_SCREEN_BRIGHT /*2*/:
                Slog.i(TAG, "Going to sleep due to screen timeout (uid " + uid + ")...");
                break;
            case MSG_SCREEN_BRIGHTNESS_BOOST_TIMEOUT /*3*/:
                Slog.i(TAG, "Going to sleep due to lid switch (uid " + uid + ")...");
                break;
            case WAKE_LOCK_SCREEN_DIM /*4*/:
                Slog.i(TAG, "Going to sleep due to power button (uid " + uid + ")...");
                break;
            case POWER_HINT_LOW_POWER /*5*/:
                Slog.i(TAG, "Going to sleep due to HDMI standby (uid " + uid + ")...");
                break;
            default:
                try {
                    Slog.i(TAG, "Going to sleep by application request (uid " + uid + ")...");
                    reason = 0;
                    break;
                } catch (Throwable th) {
                    Trace.traceEnd(131072);
                }
        }
        this.mLastSleepTime = eventTime;
        this.mSandmanSummoned = true;
        setWakefulnessLocked(MSG_SCREEN_BRIGHTNESS_BOOST_TIMEOUT, reason);
        int numWakeLocksCleared = 0;
        int numWakeLocks = this.mWakeLocks.size();
        for (int i = 0; i < numWakeLocks; i += WAKE_LOCK_CPU) {
            switch (((WakeLock) this.mWakeLocks.get(i)).mFlags & 65535) {
                case C0569H.REMOVE_STARTING /*6*/:
                case AppTransition.TRANSIT_TASK_TO_FRONT /*10*/:
                case C0569H.DO_ANIMATION_CALLBACK /*26*/:
                    numWakeLocksCleared += WAKE_LOCK_CPU;
                    break;
                default:
                    break;
            }
        }
        EventLog.writeEvent(EventLogTags.POWER_SLEEP_REQUESTED, numWakeLocksCleared);
        if ((flags & WAKE_LOCK_CPU) != 0) {
            reallyGoToSleepNoUpdateLocked(eventTime, uid);
        }
        Trace.traceEnd(131072);
        return true;
    }

    private void napInternal(long eventTime, int uid) {
        synchronized (this.mLock) {
            if (napNoUpdateLocked(eventTime, uid)) {
                updatePowerStateLocked();
            }
        }
    }

    private boolean napNoUpdateLocked(long eventTime, int uid) {
        if (eventTime < this.mLastWakeTime || this.mWakefulness != WAKE_LOCK_CPU || !this.mBootCompleted || !this.mSystemReady) {
            return DEBUG_SPEW;
        }
        Trace.traceBegin(131072, "nap");
        try {
            Slog.i(TAG, "Nap time (uid " + uid + ")...");
            this.mSandmanSummoned = true;
            setWakefulnessLocked(WAKE_LOCK_SCREEN_BRIGHT, 0);
            return true;
        } finally {
            Trace.traceEnd(131072);
        }
    }

    private boolean reallyGoToSleepNoUpdateLocked(long eventTime, int uid) {
        if (eventTime < this.mLastWakeTime || this.mWakefulness == 0 || !this.mBootCompleted || !this.mSystemReady) {
            return DEBUG_SPEW;
        }
        Trace.traceBegin(131072, "reallyGoToSleep");
        try {
            Slog.i(TAG, "Sleeping (uid " + uid + ")...");
            setWakefulnessLocked(0, WAKE_LOCK_SCREEN_BRIGHT);
            return true;
        } finally {
            Trace.traceEnd(131072);
        }
    }

    private void setWakefulnessLocked(int wakefulness, int reason) {
        if (this.mWakefulness != wakefulness) {
            finishWakefulnessChangeLocked();
            this.mWakefulness = wakefulness;
            this.mWakefulnessChanging = true;
            this.mDirty |= WAKE_LOCK_SCREEN_BRIGHT;
            this.mNotifier.onWakefulnessChangeStarted(wakefulness, reason);
        }
    }

    private void finishWakefulnessChangeLocked() {
        if (this.mWakefulnessChanging) {
            this.mNotifier.onWakefulnessChangeFinished(this.mWakefulness);
            this.mWakefulnessChanging = DEBUG_SPEW;
        }
    }

    private void updatePowerStateLocked() {
        if (this.mSystemReady && this.mDirty != 0) {
            if (!Thread.holdsLock(this.mLock)) {
                Slog.wtf(TAG, "Power manager lock was not held when calling updatePowerStateLocked");
            }
            Trace.traceBegin(131072, "updatePowerState");
            try {
                updateIsPoweredLocked(this.mDirty);
                updateStayOnLocked(this.mDirty);
                updateScreenBrightnessBoostLocked(this.mDirty);
                long now = SystemClock.uptimeMillis();
                int dirtyPhase2 = 0;
                while (true) {
                    int dirtyPhase1 = this.mDirty;
                    dirtyPhase2 |= dirtyPhase1;
                    this.mDirty = 0;
                    updateWakeLockSummaryLocked(dirtyPhase1);
                    updateUserActivitySummaryLocked(now, dirtyPhase1);
                    if (!updateWakefulnessLocked(dirtyPhase1)) {
                        break;
                    }
                }
                updateDreamLocked(dirtyPhase2, updateDisplayPowerStateLocked(dirtyPhase2));
                if (this.mDisplayReady) {
                    finishWakefulnessChangeLocked();
                }
                updateSuspendBlockerLocked();
            } finally {
                Trace.traceEnd(131072);
            }
        }
    }

    private void updateIsPoweredLocked(int dirty) {
        if ((dirty & DIRTY_BATTERY_STATE) != 0) {
            boolean wasPowered = this.mIsPowered;
            int oldPlugType = this.mPlugType;
            boolean oldLevelLow = this.mBatteryLevelLow;
            this.mIsPowered = this.mBatteryManagerInternal.isPowered(7);
            this.mPlugType = this.mBatteryManagerInternal.getPlugType();
            this.mBatteryLevel = this.mBatteryManagerInternal.getBatteryLevel();
            this.mBatteryLevelLow = this.mBatteryManagerInternal.getBatteryLevelLow();
            enableQbCharger(this.mIsPowered);
            if (!(wasPowered == this.mIsPowered && oldPlugType == this.mPlugType)) {
                this.mDirty |= WAKE_LOCK_DOZE;
                boolean dockedOnWirelessCharger = this.mWirelessChargerDetector.update(this.mIsPowered, this.mPlugType, this.mBatteryLevel);
                long now = SystemClock.uptimeMillis();
                if (shouldWakeUpWhenPluggedOrUnpluggedLocked(wasPowered, oldPlugType, dockedOnWirelessCharger)) {
                    wakeUpNoUpdateLocked(now, ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE);
                }
                userActivityNoUpdateLocked(now, 0, 0, ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE);
                if (dockedOnWirelessCharger) {
                    this.mNotifier.onWirelessChargingStarted();
                }
            }
            if (wasPowered != this.mIsPowered || oldLevelLow != this.mBatteryLevelLow) {
                if (!(oldLevelLow == this.mBatteryLevelLow || this.mBatteryLevelLow)) {
                    this.mAutoLowPowerModeSnoozing = DEBUG_SPEW;
                }
                updateLowPowerModeLocked();
            }
        }
    }

    private boolean shouldWakeUpWhenPluggedOrUnpluggedLocked(boolean wasPowered, int oldPlugType, boolean dockedOnWirelessCharger) {
        if (!this.mWakeUpWhenPluggedOrUnpluggedConfig || SystemProperties.getInt("sys.quickboot.enable", 0) == WAKE_LOCK_CPU) {
            return DEBUG_SPEW;
        }
        if (wasPowered && !this.mIsPowered && oldPlugType == WAKE_LOCK_SCREEN_DIM) {
            return DEBUG_SPEW;
        }
        if (!wasPowered && this.mIsPowered && this.mPlugType == WAKE_LOCK_SCREEN_DIM && !dockedOnWirelessCharger) {
            return DEBUG_SPEW;
        }
        if (this.mIsPowered && this.mWakefulness == WAKE_LOCK_SCREEN_BRIGHT) {
            return DEBUG_SPEW;
        }
        if (!this.mTheaterModeEnabled || this.mWakeUpWhenPluggedOrUnpluggedInTheaterModeConfig) {
            return true;
        }
        return DEBUG_SPEW;
    }

    private void updateStayOnLocked(int dirty) {
        if ((dirty & 288) != 0) {
            boolean wasStayOn = this.mStayOn;
            if (this.mStayOnWhilePluggedInSetting == 0 || isMaximumScreenOffTimeoutFromDeviceAdminEnforcedLocked()) {
                this.mStayOn = DEBUG_SPEW;
            } else {
                this.mStayOn = this.mBatteryManagerInternal.isPowered(this.mStayOnWhilePluggedInSetting);
            }
            if (this.mStayOn != wasStayOn) {
                this.mDirty |= DIRTY_STAY_ON;
            }
        }
    }

    private void updateWakeLockSummaryLocked(int dirty) {
        if ((dirty & MSG_SCREEN_BRIGHTNESS_BOOST_TIMEOUT) != 0) {
            this.mWakeLockSummary = 0;
            int numWakeLocks = this.mWakeLocks.size();
            for (int i = 0; i < numWakeLocks; i += WAKE_LOCK_CPU) {
                switch (((WakeLock) this.mWakeLocks.get(i)).mFlags & 65535) {
                    case WAKE_LOCK_CPU /*1*/:
                        this.mWakeLockSummary |= WAKE_LOCK_CPU;
                        break;
                    case C0569H.REMOVE_STARTING /*6*/:
                        this.mWakeLockSummary |= WAKE_LOCK_SCREEN_DIM;
                        break;
                    case AppTransition.TRANSIT_TASK_TO_FRONT /*10*/:
                        this.mWakeLockSummary |= WAKE_LOCK_SCREEN_BRIGHT;
                        break;
                    case C0569H.DO_ANIMATION_CALLBACK /*26*/:
                        this.mWakeLockSummary |= 10;
                        break;
                    case WAKE_LOCK_STAY_AWAKE /*32*/:
                        this.mWakeLockSummary |= WAKE_LOCK_PROXIMITY_SCREEN_OFF;
                        break;
                    case WAKE_LOCK_DOZE /*64*/:
                        this.mWakeLockSummary |= WAKE_LOCK_DOZE;
                        break;
                    default:
                        break;
                }
            }
            if (this.mWakefulness != MSG_SCREEN_BRIGHTNESS_BOOST_TIMEOUT) {
                this.mWakeLockSummary &= -65;
            }
            if (this.mWakefulness == 0 || (this.mWakeLockSummary & WAKE_LOCK_DOZE) != 0) {
                this.mWakeLockSummary &= -15;
                if (this.mWakefulness == 0) {
                    this.mWakeLockSummary &= -17;
                }
            }
            if ((this.mWakeLockSummary & 6) == 0) {
                return;
            }
            if (this.mWakefulness == WAKE_LOCK_CPU) {
                this.mWakeLockSummary |= 33;
            } else if (this.mWakefulness == WAKE_LOCK_SCREEN_BRIGHT) {
                this.mWakeLockSummary |= WAKE_LOCK_CPU;
            }
        }
    }

    private void updateUserActivitySummaryLocked(long now, int dirty) {
        if ((dirty & 39) != 0) {
            this.mHandler.removeMessages(WAKE_LOCK_CPU);
            long nextTimeout = 0;
            if (this.mWakefulness == WAKE_LOCK_CPU || this.mWakefulness == WAKE_LOCK_SCREEN_BRIGHT || this.mWakefulness == MSG_SCREEN_BRIGHTNESS_BOOST_TIMEOUT) {
                int sleepTimeout = getSleepTimeoutLocked();
                int screenOffTimeout = getScreenOffTimeoutLocked(sleepTimeout);
                int screenDimDuration = getScreenDimDurationLocked(screenOffTimeout);
                this.mUserActivitySummary = 0;
                if (this.mLastUserActivityTime >= this.mLastWakeTime) {
                    nextTimeout = (this.mLastUserActivityTime + ((long) screenOffTimeout)) - ((long) screenDimDuration);
                    if (now < nextTimeout) {
                        if (now > this.mLastUserActivityTime + 5000) {
                            this.mButtonsLight.setBrightness(0);
                        } else {
                            this.mButtonsLight.setBrightness(this.mDisplayPowerRequest.screenBrightness);
                            nextTimeout = now + 5000;
                        }
                        this.mUserActivitySummary = WAKE_LOCK_CPU;
                    } else {
                        nextTimeout = this.mLastUserActivityTime + ((long) screenOffTimeout);
                        if (now < nextTimeout) {
                            this.mUserActivitySummary = WAKE_LOCK_SCREEN_BRIGHT;
                        }
                    }
                }
                if (this.mUserActivitySummary == 0 && this.mLastUserActivityTimeNoChangeLights >= this.mLastWakeTime) {
                    nextTimeout = this.mLastUserActivityTimeNoChangeLights + ((long) screenOffTimeout);
                    if (now < nextTimeout) {
                        if (this.mDisplayPowerRequest.policy == MSG_SCREEN_BRIGHTNESS_BOOST_TIMEOUT) {
                            this.mUserActivitySummary = WAKE_LOCK_CPU;
                        } else if (this.mDisplayPowerRequest.policy == WAKE_LOCK_SCREEN_BRIGHT) {
                            this.mUserActivitySummary = WAKE_LOCK_SCREEN_BRIGHT;
                        }
                    }
                }
                if (this.mUserActivitySummary == 0) {
                    if (sleepTimeout >= 0) {
                        long anyUserActivity = Math.max(this.mLastUserActivityTime, this.mLastUserActivityTimeNoChangeLights);
                        if (anyUserActivity >= this.mLastWakeTime) {
                            nextTimeout = anyUserActivity + ((long) sleepTimeout);
                            if (now < nextTimeout) {
                                this.mUserActivitySummary = WAKE_LOCK_SCREEN_DIM;
                            }
                        }
                    } else {
                        this.mUserActivitySummary = WAKE_LOCK_SCREEN_DIM;
                        nextTimeout = -1;
                    }
                }
                if (this.mUserActivitySummary != 0 && nextTimeout >= 0) {
                    Message msg = this.mHandler.obtainMessage(WAKE_LOCK_CPU);
                    msg.setAsynchronous(true);
                    this.mHandler.sendMessageAtTime(msg, nextTimeout);
                    return;
                }
                return;
            }
            this.mUserActivitySummary = 0;
        }
    }

    private void handleUserActivityTimeout() {
        synchronized (this.mLock) {
            this.mDirty |= WAKE_LOCK_SCREEN_DIM;
            updatePowerStateLocked();
        }
    }

    private int getSleepTimeoutLocked() {
        int timeout = this.mSleepTimeoutSetting;
        if (timeout <= 0) {
            return DEFAULT_SLEEP_TIMEOUT;
        }
        return Math.max(timeout, this.mMinimumScreenOffTimeoutConfig);
    }

    private int getScreenOffTimeoutLocked(int sleepTimeout) {
        int timeout = this.mScreenOffTimeoutSetting;
        if (isMaximumScreenOffTimeoutFromDeviceAdminEnforcedLocked()) {
            timeout = Math.min(timeout, this.mMaximumScreenOffTimeoutFromDeviceAdmin);
        }
        if (this.mUserActivityTimeoutOverrideFromWindowManager >= 0) {
            timeout = (int) Math.min((long) timeout, this.mUserActivityTimeoutOverrideFromWindowManager);
        }
        if (sleepTimeout >= 0) {
            timeout = Math.min(timeout, sleepTimeout);
        }
        return Math.max(timeout, this.mMinimumScreenOffTimeoutConfig);
    }

    private int getScreenDimDurationLocked(int screenOffTimeout) {
        return Math.min(this.mMaximumScreenDimDurationConfig, (int) (((float) screenOffTimeout) * this.mMaximumScreenDimRatioConfig));
    }

    private boolean updateWakefulnessLocked(int dirty) {
        if ((dirty & 1687) == 0 || this.mWakefulness != WAKE_LOCK_CPU || !isItBedTimeYetLocked()) {
            return DEBUG_SPEW;
        }
        long time = SystemClock.uptimeMillis();
        if (shouldNapAtBedTimeLocked()) {
            return napNoUpdateLocked(time, ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE);
        }
        return goToSleepNoUpdateLocked(time, WAKE_LOCK_SCREEN_BRIGHT, 0, ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE);
    }

    private boolean shouldNapAtBedTimeLocked() {
        return (this.mDreamsActivateOnSleepSetting || (this.mDreamsActivateOnDockSetting && this.mDockState != 0)) ? true : DEBUG_SPEW;
    }

    private boolean isItBedTimeYetLocked() {
        return (!this.mBootCompleted || isBeingKeptAwakeLocked()) ? DEBUG_SPEW : true;
    }

    private boolean isBeingKeptAwakeLocked() {
        return (this.mStayOn || this.mProximityPositive || (this.mWakeLockSummary & WAKE_LOCK_STAY_AWAKE) != 0 || (this.mUserActivitySummary & MSG_SCREEN_BRIGHTNESS_BOOST_TIMEOUT) != 0 || this.mScreenBrightnessBoostInProgress) ? true : DEBUG_SPEW;
    }

    private void updateDreamLocked(int dirty, boolean displayBecameReady) {
        if (((dirty & 1015) != 0 || displayBecameReady) && this.mDisplayReady) {
            scheduleSandmanLocked();
        }
    }

    private void scheduleSandmanLocked() {
        if (!this.mSandmanScheduled) {
            this.mSandmanScheduled = true;
            Message msg = this.mHandler.obtainMessage(WAKE_LOCK_SCREEN_BRIGHT);
            msg.setAsynchronous(true);
            this.mHandler.sendMessage(msg);
        }
    }

    private void handleSandman() {
        boolean startDreaming;
        boolean isDreaming;
        boolean z = true;
        synchronized (this.mLock) {
            this.mSandmanScheduled = DEBUG_SPEW;
            int wakefulness = this.mWakefulness;
            if (this.mSandmanSummoned && this.mDisplayReady) {
                if (canDreamLocked() || canDozeLocked()) {
                    startDreaming = true;
                } else {
                    startDreaming = DEBUG_SPEW;
                }
                this.mSandmanSummoned = DEBUG_SPEW;
            } else {
                startDreaming = DEBUG_SPEW;
            }
        }
        if (this.mDreamManager != null) {
            if (startDreaming) {
                this.mDreamManager.stopDream(DEBUG_SPEW);
                DreamManagerInternal dreamManagerInternal = this.mDreamManager;
                if (wakefulness != MSG_SCREEN_BRIGHTNESS_BOOST_TIMEOUT) {
                    z = DEBUG_SPEW;
                }
                dreamManagerInternal.startDream(z);
            }
            isDreaming = this.mDreamManager.isDreaming();
        } else {
            isDreaming = DEBUG_SPEW;
        }
        synchronized (this.mLock) {
            if (startDreaming && isDreaming) {
                this.mBatteryLevelWhenDreamStarted = this.mBatteryLevel;
                if (wakefulness == MSG_SCREEN_BRIGHTNESS_BOOST_TIMEOUT) {
                    Slog.i(TAG, "Dozing...");
                } else {
                    Slog.i(TAG, "Dreaming...");
                }
            }
            if (this.mSandmanSummoned || this.mWakefulness != wakefulness) {
                return;
            }
            if (wakefulness == WAKE_LOCK_SCREEN_BRIGHT) {
                if (isDreaming) {
                    if (canDreamLocked()) {
                        if (this.mDreamsBatteryLevelDrainCutoffConfig < 0 || this.mBatteryLevel >= this.mBatteryLevelWhenDreamStarted - this.mDreamsBatteryLevelDrainCutoffConfig || isBeingKeptAwakeLocked()) {
                            return;
                        }
                        Slog.i(TAG, "Stopping dream because the battery appears to be draining faster than it is charging.  Battery level when dream started: " + this.mBatteryLevelWhenDreamStarted + "%.  " + "Battery level now: " + this.mBatteryLevel + "%.");
                    }
                }
                if (isItBedTimeYetLocked()) {
                    goToSleepNoUpdateLocked(SystemClock.uptimeMillis(), WAKE_LOCK_SCREEN_BRIGHT, 0, ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE);
                    updatePowerStateLocked();
                } else {
                    wakeUpNoUpdateLocked(SystemClock.uptimeMillis(), ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE);
                    updatePowerStateLocked();
                }
            } else if (wakefulness == MSG_SCREEN_BRIGHTNESS_BOOST_TIMEOUT) {
                if (isDreaming) {
                    return;
                } else {
                    reallyGoToSleepNoUpdateLocked(SystemClock.uptimeMillis(), ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE);
                    updatePowerStateLocked();
                }
            }
            if (isDreaming) {
                this.mDreamManager.stopDream(DEBUG_SPEW);
            }
        }
    }

    private boolean canDreamLocked() {
        if (this.mWakefulness != WAKE_LOCK_SCREEN_BRIGHT || !this.mDreamsSupportedConfig || !this.mDreamsEnabledSetting || !this.mDisplayPowerRequest.isBrightOrDim() || (this.mUserActivitySummary & 7) == 0 || !this.mBootCompleted) {
            return DEBUG_SPEW;
        }
        if (!isBeingKeptAwakeLocked()) {
            if (!this.mIsPowered && !this.mDreamsEnabledOnBatteryConfig) {
                return DEBUG_SPEW;
            }
            if (!this.mIsPowered && this.mDreamsBatteryLevelMinimumWhenNotPoweredConfig >= 0 && this.mBatteryLevel < this.mDreamsBatteryLevelMinimumWhenNotPoweredConfig) {
                return DEBUG_SPEW;
            }
            if (this.mIsPowered && this.mDreamsBatteryLevelMinimumWhenPoweredConfig >= 0 && this.mBatteryLevel < this.mDreamsBatteryLevelMinimumWhenPoweredConfig) {
                return DEBUG_SPEW;
            }
        }
        return true;
    }

    private boolean canDozeLocked() {
        return this.mWakefulness == MSG_SCREEN_BRIGHTNESS_BOOST_TIMEOUT ? true : DEBUG_SPEW;
    }

    private boolean updateDisplayPowerStateLocked(int dirty) {
        boolean oldDisplayReady = this.mDisplayReady;
        if ((dirty & 2111) != 0) {
            boolean autoBrightness;
            this.mDisplayPowerRequest.policy = getDesiredScreenPolicyLocked();
            int screenBrightness = this.mScreenBrightnessSettingDefault;
            float screenAutoBrightnessAdjustment = 0.0f;
            if (this.mScreenBrightnessModeSetting == WAKE_LOCK_CPU) {
                autoBrightness = true;
            } else {
                autoBrightness = DEBUG_SPEW;
            }
            if (isValidBrightness(this.mScreenBrightnessOverrideFromWindowManager)) {
                screenBrightness = this.mScreenBrightnessOverrideFromWindowManager;
                autoBrightness = DEBUG_SPEW;
            } else if (isValidBrightness(this.mTemporaryScreenBrightnessSettingOverride)) {
                screenBrightness = this.mTemporaryScreenBrightnessSettingOverride;
            } else if (isValidBrightness(this.mScreenBrightnessSetting)) {
                screenBrightness = this.mScreenBrightnessSetting;
            }
            if (autoBrightness) {
                screenBrightness = this.mScreenBrightnessSettingDefault;
                if (isValidAutoBrightnessAdjustment(this.mTemporaryScreenAutoBrightnessAdjustmentSettingOverride)) {
                    screenAutoBrightnessAdjustment = this.mTemporaryScreenAutoBrightnessAdjustmentSettingOverride;
                } else if (isValidAutoBrightnessAdjustment(this.mScreenAutoBrightnessAdjustmentSetting)) {
                    screenAutoBrightnessAdjustment = this.mScreenAutoBrightnessAdjustmentSetting;
                }
            }
            screenBrightness = Math.max(Math.min(screenBrightness, this.mScreenBrightnessSettingMaximum), this.mScreenBrightnessSettingMinimum);
            screenAutoBrightnessAdjustment = Math.max(Math.min(screenAutoBrightnessAdjustment, 1.0f), -1.0f);
            this.mDisplayPowerRequest.screenBrightness = screenBrightness;
            this.mDisplayPowerRequest.screenAutoBrightnessAdjustment = screenAutoBrightnessAdjustment;
            this.mDisplayPowerRequest.useAutoBrightness = autoBrightness;
            this.mDisplayPowerRequest.useProximitySensor = shouldUseProximitySensorLocked();
            this.mDisplayPowerRequest.lowPowerMode = this.mLowPowerModeEnabled;
            this.mDisplayPowerRequest.boostScreenBrightness = this.mScreenBrightnessBoostInProgress;
            if (this.mDisplayPowerRequest.policy == WAKE_LOCK_CPU) {
                this.mDisplayPowerRequest.dozeScreenState = this.mDozeScreenStateOverrideFromDreamManager;
                this.mDisplayPowerRequest.dozeScreenBrightness = this.mDozeScreenBrightnessOverrideFromDreamManager;
            } else {
                this.mDisplayPowerRequest.dozeScreenState = 0;
                this.mDisplayPowerRequest.dozeScreenBrightness = DEFAULT_SLEEP_TIMEOUT;
            }
            this.mDisplayReady = this.mDisplayManagerInternal.requestPowerState(this.mDisplayPowerRequest, this.mRequestWaitForNegativeProximity);
            this.mRequestWaitForNegativeProximity = DEBUG_SPEW;
        }
        if (!this.mDisplayReady || oldDisplayReady) {
            return DEBUG_SPEW;
        }
        return true;
    }

    private void updateScreenBrightnessBoostLocked(int dirty) {
        if ((dirty & DIRTY_SCREEN_BRIGHTNESS_BOOST) != 0 && this.mScreenBrightnessBoostInProgress) {
            long now = SystemClock.uptimeMillis();
            this.mHandler.removeMessages(MSG_SCREEN_BRIGHTNESS_BOOST_TIMEOUT);
            if (this.mLastScreenBrightnessBoostTime > this.mLastSleepTime) {
                long boostTimeout = this.mLastScreenBrightnessBoostTime + 5000;
                if (boostTimeout > now) {
                    Message msg = this.mHandler.obtainMessage(MSG_SCREEN_BRIGHTNESS_BOOST_TIMEOUT);
                    msg.setAsynchronous(true);
                    this.mHandler.sendMessageAtTime(msg, boostTimeout);
                    return;
                }
            }
            this.mScreenBrightnessBoostInProgress = DEBUG_SPEW;
            userActivityNoUpdateLocked(now, 0, 0, ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE);
        }
    }

    private static boolean isValidBrightness(int value) {
        return (value < 0 || value > 255) ? DEBUG_SPEW : true;
    }

    private static boolean isValidAutoBrightnessAdjustment(float value) {
        return (value < -1.0f || value > 1.0f) ? DEBUG_SPEW : true;
    }

    private int getDesiredScreenPolicyLocked() {
        if (this.mWakefulness == 0) {
            return 0;
        }
        if (this.mWakefulness == MSG_SCREEN_BRIGHTNESS_BOOST_TIMEOUT) {
            if ((this.mWakeLockSummary & WAKE_LOCK_DOZE) != 0) {
                return WAKE_LOCK_CPU;
            }
            if (this.mDozeAfterScreenOffConfig) {
                return 0;
            }
        }
        if ((this.mWakeLockSummary & WAKE_LOCK_SCREEN_BRIGHT) == 0 && (this.mUserActivitySummary & WAKE_LOCK_CPU) == 0 && this.mBootCompleted && !this.mScreenBrightnessBoostInProgress) {
            return WAKE_LOCK_SCREEN_BRIGHT;
        }
        return MSG_SCREEN_BRIGHTNESS_BOOST_TIMEOUT;
    }

    private boolean shouldUseProximitySensorLocked() {
        return (this.mWakeLockSummary & WAKE_LOCK_PROXIMITY_SCREEN_OFF) != 0 ? true : DEBUG_SPEW;
    }

    private void updateSuspendBlockerLocked() {
        boolean needWakeLockSuspendBlocker;
        boolean autoSuspend;
        if ((this.mWakeLockSummary & WAKE_LOCK_CPU) != 0) {
            needWakeLockSuspendBlocker = true;
        } else {
            needWakeLockSuspendBlocker = DEBUG_SPEW;
        }
        boolean needDisplaySuspendBlocker = needDisplaySuspendBlockerLocked();
        if (needDisplaySuspendBlocker) {
            autoSuspend = DEBUG_SPEW;
        } else {
            autoSuspend = true;
        }
        boolean interactive = this.mDisplayPowerRequest.isBrightOrDim();
        if (!autoSuspend && this.mDecoupleHalAutoSuspendModeFromDisplayConfig) {
            setHalAutoSuspendModeLocked(DEBUG_SPEW);
        }
        if (needWakeLockSuspendBlocker && !this.mHoldingWakeLockSuspendBlocker) {
            this.mWakeLockSuspendBlocker.acquire();
            this.mHoldingWakeLockSuspendBlocker = true;
        }
        if (needDisplaySuspendBlocker && !this.mHoldingDisplaySuspendBlocker) {
            this.mDisplaySuspendBlocker.acquire();
            this.mHoldingDisplaySuspendBlocker = true;
        }
        if (this.mDecoupleHalInteractiveModeFromDisplayConfig && (interactive || this.mDisplayReady)) {
            setHalInteractiveModeLocked(interactive);
        }
        if (!needWakeLockSuspendBlocker && this.mHoldingWakeLockSuspendBlocker) {
            this.mWakeLockSuspendBlocker.release();
            this.mHoldingWakeLockSuspendBlocker = DEBUG_SPEW;
        }
        if (!needDisplaySuspendBlocker && this.mHoldingDisplaySuspendBlocker) {
            this.mDisplaySuspendBlocker.release();
            this.mHoldingDisplaySuspendBlocker = DEBUG_SPEW;
        }
        if (autoSuspend && this.mDecoupleHalAutoSuspendModeFromDisplayConfig) {
            setHalAutoSuspendModeLocked(true);
        }
    }

    private boolean needDisplaySuspendBlockerLocked() {
        if (!this.mDisplayReady) {
            return true;
        }
        if ((!this.mDisplayPowerRequest.isBrightOrDim() || (this.mDisplayPowerRequest.useProximitySensor && this.mProximityPositive && this.mSuspendWhenScreenOffDueToProximityConfig)) && !this.mScreenBrightnessBoostInProgress) {
            return DEBUG_SPEW;
        }
        return true;
    }

    private void setHalAutoSuspendModeLocked(boolean enable) {
        if (enable != this.mHalAutoSuspendModeEnabled) {
            this.mHalAutoSuspendModeEnabled = enable;
            Trace.traceBegin(131072, "setHalAutoSuspend(" + enable + ")");
            try {
                nativeSetAutoSuspend(enable);
            } finally {
                Trace.traceEnd(131072);
            }
        }
    }

    private void setHalInteractiveModeLocked(boolean enable) {
        if (enable != this.mHalInteractiveModeEnabled) {
            this.mHalInteractiveModeEnabled = enable;
            Trace.traceBegin(131072, "setHalInteractive(" + enable + ")");
            try {
                nativeSetInteractive(enable);
            } finally {
                Trace.traceEnd(131072);
            }
        }
    }

    private boolean isInteractiveInternal() {
        boolean isInteractive;
        synchronized (this.mLock) {
            isInteractive = PowerManagerInternal.isInteractive(this.mWakefulness);
        }
        return isInteractive;
    }

    private boolean isLowPowerModeInternal() {
        boolean z;
        synchronized (this.mLock) {
            z = this.mLowPowerModeEnabled;
        }
        return z;
    }

    private boolean setLowPowerModeInternal(boolean mode) {
        int i = 0;
        synchronized (this.mLock) {
            if (this.mIsPowered) {
                return DEBUG_SPEW;
            }
            ContentResolver contentResolver = this.mContext.getContentResolver();
            String str = "low_power";
            if (mode) {
                i = WAKE_LOCK_CPU;
            }
            Global.putInt(contentResolver, str, i);
            this.mLowPowerModeSetting = mode;
            if (this.mAutoLowPowerModeConfigured && this.mBatteryLevelLow) {
                if (mode && this.mAutoLowPowerModeSnoozing) {
                    this.mAutoLowPowerModeSnoozing = DEBUG_SPEW;
                } else if (!(mode || this.mAutoLowPowerModeSnoozing)) {
                    this.mAutoLowPowerModeSnoozing = true;
                }
            }
            updateLowPowerModeLocked();
            return true;
        }
    }

    private void handleBatteryStateChangedLocked() {
        this.mDirty |= DIRTY_BATTERY_STATE;
        updatePowerStateLocked();
    }

    private void crashInternal(String message) {
        Thread t = new C04714("PowerManagerService.crash()", message);
        try {
            t.start();
            t.join();
        } catch (InterruptedException e) {
            Slog.wtf(TAG, e);
        }
    }

    private void setStayOnSettingInternal(int val) {
        Global.putInt(this.mContext.getContentResolver(), "stay_on_while_plugged_in", val);
    }

    private void setMaximumScreenOffTimeoutFromDeviceAdminInternal(int timeMs) {
        synchronized (this.mLock) {
            this.mMaximumScreenOffTimeoutFromDeviceAdmin = timeMs;
            this.mDirty |= WAKE_LOCK_STAY_AWAKE;
            updatePowerStateLocked();
        }
    }

    private boolean isMaximumScreenOffTimeoutFromDeviceAdminEnforcedLocked() {
        return (this.mMaximumScreenOffTimeoutFromDeviceAdmin < 0 || this.mMaximumScreenOffTimeoutFromDeviceAdmin >= Integer.MAX_VALUE) ? DEBUG_SPEW : true;
    }

    private void setAttentionLightInternal(boolean on, int color) {
        synchronized (this.mLock) {
            if (this.mSystemReady) {
                int i;
                Light light = this.mAttentionLight;
                if (on) {
                    i = MSG_SCREEN_BRIGHTNESS_BOOST_TIMEOUT;
                } else {
                    i = 0;
                }
                light.setFlashing(color, WAKE_LOCK_SCREEN_BRIGHT, i, 0);
                return;
            }
        }
    }

    private void boostScreenBrightnessInternal(long eventTime, int uid) {
        synchronized (this.mLock) {
            if (!this.mSystemReady || this.mWakefulness == 0 || eventTime < this.mLastScreenBrightnessBoostTime) {
                return;
            }
            Slog.i(TAG, "Brightness boost activated (uid " + uid + ")...");
            this.mLastScreenBrightnessBoostTime = eventTime;
            this.mScreenBrightnessBoostInProgress = true;
            this.mDirty |= DIRTY_SCREEN_BRIGHTNESS_BOOST;
            userActivityNoUpdateLocked(eventTime, 0, 0, uid);
            updatePowerStateLocked();
        }
    }

    private void handleScreenBrightnessBoostTimeout() {
        synchronized (this.mLock) {
            this.mDirty |= DIRTY_SCREEN_BRIGHTNESS_BOOST;
            updatePowerStateLocked();
        }
    }

    private void setScreenBrightnessOverrideFromWindowManagerInternal(int brightness) {
        synchronized (this.mLock) {
            if (this.mScreenBrightnessOverrideFromWindowManager != brightness) {
                this.mScreenBrightnessOverrideFromWindowManager = brightness;
                this.mDirty |= WAKE_LOCK_STAY_AWAKE;
                updatePowerStateLocked();
            }
        }
    }

    private void setUserActivityTimeoutOverrideFromWindowManagerInternal(long timeoutMillis) {
        synchronized (this.mLock) {
            if (this.mUserActivityTimeoutOverrideFromWindowManager != timeoutMillis) {
                this.mUserActivityTimeoutOverrideFromWindowManager = timeoutMillis;
                this.mDirty |= WAKE_LOCK_STAY_AWAKE;
                updatePowerStateLocked();
            }
        }
    }

    private void setTemporaryScreenBrightnessSettingOverrideInternal(int brightness) {
        synchronized (this.mLock) {
            if (this.mTemporaryScreenBrightnessSettingOverride != brightness) {
                this.mTemporaryScreenBrightnessSettingOverride = brightness;
                this.mDirty |= WAKE_LOCK_STAY_AWAKE;
                updatePowerStateLocked();
            }
        }
    }

    private void m0xca8cee91(float adj) {
        synchronized (this.mLock) {
            if (this.mTemporaryScreenAutoBrightnessAdjustmentSettingOverride != adj) {
                this.mTemporaryScreenAutoBrightnessAdjustmentSettingOverride = adj;
                this.mDirty |= WAKE_LOCK_STAY_AWAKE;
                updatePowerStateLocked();
            }
        }
    }

    private void setDozeOverrideFromDreamManagerInternal(int screenState, int screenBrightness) {
        synchronized (this.mLock) {
            if (!(this.mDozeScreenStateOverrideFromDreamManager == screenState && this.mDozeScreenBrightnessOverrideFromDreamManager == screenBrightness)) {
                this.mDozeScreenStateOverrideFromDreamManager = screenState;
                this.mDozeScreenBrightnessOverrideFromDreamManager = screenBrightness;
                this.mDirty |= WAKE_LOCK_STAY_AWAKE;
                updatePowerStateLocked();
            }
        }
    }

    private void powerHintInternal(int hintId, int data) {
        nativeSendPowerHint(hintId, data);
    }

    public static void lowLevelShutdown() {
        SystemProperties.set("sys.powerctl", "shutdown");
    }

    public static void lowLevelReboot(String reason) {
        long duration;
        if (reason == null) {
            reason = "";
        }
        if (reason.equals("recovery")) {
            SystemProperties.set("ctl.start", "pre-recovery");
            duration = 300000;
        } else {
            SystemProperties.set("sys.powerctl", "reboot," + reason);
            duration = 20000;
        }
        try {
            Thread.sleep(duration);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }

    public void monitor() {
        synchronized (this.mLock) {
        }
    }

    private void dumpInternal(PrintWriter pw) {
        pw.println("POWER MANAGER (dumpsys power)\n");
        synchronized (this.mLock) {
            pw.println("Power Manager State:");
            pw.println("  mDirty=0x" + Integer.toHexString(this.mDirty));
            pw.println("  mWakefulness=" + PowerManagerInternal.wakefulnessToString(this.mWakefulness));
            pw.println("  mWakefulnessChanging=" + this.mWakefulnessChanging);
            pw.println("  mIsPowered=" + this.mIsPowered);
            pw.println("  mPlugType=" + this.mPlugType);
            pw.println("  mBatteryLevel=" + this.mBatteryLevel);
            pw.println("  mBatteryLevelWhenDreamStarted=" + this.mBatteryLevelWhenDreamStarted);
            pw.println("  mDockState=" + this.mDockState);
            pw.println("  mStayOn=" + this.mStayOn);
            pw.println("  mProximityPositive=" + this.mProximityPositive);
            pw.println("  mBootCompleted=" + this.mBootCompleted);
            pw.println("  mSystemReady=" + this.mSystemReady);
            pw.println("  mHalAutoSuspendModeEnabled=" + this.mHalAutoSuspendModeEnabled);
            pw.println("  mHalInteractiveModeEnabled=" + this.mHalInteractiveModeEnabled);
            pw.println("  mWakeLockSummary=0x" + Integer.toHexString(this.mWakeLockSummary));
            pw.println("  mUserActivitySummary=0x" + Integer.toHexString(this.mUserActivitySummary));
            pw.println("  mRequestWaitForNegativeProximity=" + this.mRequestWaitForNegativeProximity);
            pw.println("  mSandmanScheduled=" + this.mSandmanScheduled);
            pw.println("  mSandmanSummoned=" + this.mSandmanSummoned);
            pw.println("  mLowPowerModeEnabled=" + this.mLowPowerModeEnabled);
            pw.println("  mBatteryLevelLow=" + this.mBatteryLevelLow);
            pw.println("  mLastWakeTime=" + TimeUtils.formatUptime(this.mLastWakeTime));
            pw.println("  mLastSleepTime=" + TimeUtils.formatUptime(this.mLastSleepTime));
            pw.println("  mLastUserActivityTime=" + TimeUtils.formatUptime(this.mLastUserActivityTime));
            pw.println("  mLastUserActivityTimeNoChangeLights=" + TimeUtils.formatUptime(this.mLastUserActivityTimeNoChangeLights));
            pw.println("  mLastInteractivePowerHintTime=" + TimeUtils.formatUptime(this.mLastInteractivePowerHintTime));
            pw.println("  mLastScreenBrightnessBoostTime=" + TimeUtils.formatUptime(this.mLastScreenBrightnessBoostTime));
            pw.println("  mScreenBrightnessBoostInProgress=" + this.mScreenBrightnessBoostInProgress);
            pw.println("  mDisplayReady=" + this.mDisplayReady);
            pw.println("  mHoldingWakeLockSuspendBlocker=" + this.mHoldingWakeLockSuspendBlocker);
            pw.println("  mHoldingDisplaySuspendBlocker=" + this.mHoldingDisplaySuspendBlocker);
            pw.println();
            pw.println("Settings and Configuration:");
            pw.println("  mDecoupleHalAutoSuspendModeFromDisplayConfig=" + this.mDecoupleHalAutoSuspendModeFromDisplayConfig);
            pw.println("  mDecoupleHalInteractiveModeFromDisplayConfig=" + this.mDecoupleHalInteractiveModeFromDisplayConfig);
            pw.println("  mWakeUpWhenPluggedOrUnpluggedConfig=" + this.mWakeUpWhenPluggedOrUnpluggedConfig);
            pw.println("  mWakeUpWhenPluggedOrUnpluggedInTheaterModeConfig=" + this.mWakeUpWhenPluggedOrUnpluggedInTheaterModeConfig);
            pw.println("  mTheaterModeEnabled=" + this.mTheaterModeEnabled);
            pw.println("  mSuspendWhenScreenOffDueToProximityConfig=" + this.mSuspendWhenScreenOffDueToProximityConfig);
            pw.println("  mDreamsSupportedConfig=" + this.mDreamsSupportedConfig);
            pw.println("  mDreamsEnabledByDefaultConfig=" + this.mDreamsEnabledByDefaultConfig);
            pw.println("  mDreamsActivatedOnSleepByDefaultConfig=" + this.mDreamsActivatedOnSleepByDefaultConfig);
            pw.println("  mDreamsActivatedOnDockByDefaultConfig=" + this.mDreamsActivatedOnDockByDefaultConfig);
            pw.println("  mDreamsEnabledOnBatteryConfig=" + this.mDreamsEnabledOnBatteryConfig);
            pw.println("  mDreamsBatteryLevelMinimumWhenPoweredConfig=" + this.mDreamsBatteryLevelMinimumWhenPoweredConfig);
            pw.println("  mDreamsBatteryLevelMinimumWhenNotPoweredConfig=" + this.mDreamsBatteryLevelMinimumWhenNotPoweredConfig);
            pw.println("  mDreamsBatteryLevelDrainCutoffConfig=" + this.mDreamsBatteryLevelDrainCutoffConfig);
            pw.println("  mDreamsEnabledSetting=" + this.mDreamsEnabledSetting);
            pw.println("  mDreamsActivateOnSleepSetting=" + this.mDreamsActivateOnSleepSetting);
            pw.println("  mDreamsActivateOnDockSetting=" + this.mDreamsActivateOnDockSetting);
            pw.println("  mDozeAfterScreenOffConfig=" + this.mDozeAfterScreenOffConfig);
            pw.println("  mLowPowerModeSetting=" + this.mLowPowerModeSetting);
            pw.println("  mAutoLowPowerModeConfigured=" + this.mAutoLowPowerModeConfigured);
            pw.println("  mAutoLowPowerModeSnoozing=" + this.mAutoLowPowerModeSnoozing);
            pw.println("  mMinimumScreenOffTimeoutConfig=" + this.mMinimumScreenOffTimeoutConfig);
            pw.println("  mMaximumScreenDimDurationConfig=" + this.mMaximumScreenDimDurationConfig);
            pw.println("  mMaximumScreenDimRatioConfig=" + this.mMaximumScreenDimRatioConfig);
            pw.println("  mScreenOffTimeoutSetting=" + this.mScreenOffTimeoutSetting);
            pw.println("  mSleepTimeoutSetting=" + this.mSleepTimeoutSetting);
            pw.println("  mMaximumScreenOffTimeoutFromDeviceAdmin=" + this.mMaximumScreenOffTimeoutFromDeviceAdmin + " (enforced=" + isMaximumScreenOffTimeoutFromDeviceAdminEnforcedLocked() + ")");
            pw.println("  mStayOnWhilePluggedInSetting=" + this.mStayOnWhilePluggedInSetting);
            pw.println("  mScreenBrightnessSetting=" + this.mScreenBrightnessSetting);
            pw.println("  mScreenAutoBrightnessAdjustmentSetting=" + this.mScreenAutoBrightnessAdjustmentSetting);
            pw.println("  mScreenBrightnessModeSetting=" + this.mScreenBrightnessModeSetting);
            pw.println("  mScreenBrightnessOverrideFromWindowManager=" + this.mScreenBrightnessOverrideFromWindowManager);
            pw.println("  mUserActivityTimeoutOverrideFromWindowManager=" + this.mUserActivityTimeoutOverrideFromWindowManager);
            pw.println("  mTemporaryScreenBrightnessSettingOverride=" + this.mTemporaryScreenBrightnessSettingOverride);
            pw.println("  mTemporaryScreenAutoBrightnessAdjustmentSettingOverride=" + this.mTemporaryScreenAutoBrightnessAdjustmentSettingOverride);
            pw.println("  mDozeScreenStateOverrideFromDreamManager=" + this.mDozeScreenStateOverrideFromDreamManager);
            pw.println("  mDozeScreenBrightnessOverrideFromDreamManager=" + this.mDozeScreenBrightnessOverrideFromDreamManager);
            pw.println("  mScreenBrightnessSettingMinimum=" + this.mScreenBrightnessSettingMinimum);
            pw.println("  mScreenBrightnessSettingMaximum=" + this.mScreenBrightnessSettingMaximum);
            pw.println("  mScreenBrightnessSettingDefault=" + this.mScreenBrightnessSettingDefault);
            int sleepTimeout = getSleepTimeoutLocked();
            int screenOffTimeout = getScreenOffTimeoutLocked(sleepTimeout);
            int screenDimDuration = getScreenDimDurationLocked(screenOffTimeout);
            pw.println();
            pw.println("Sleep timeout: " + sleepTimeout + " ms");
            pw.println("Screen off timeout: " + screenOffTimeout + " ms");
            pw.println("Screen dim duration: " + screenDimDuration + " ms");
            pw.println();
            pw.println("Wake Locks: size=" + this.mWakeLocks.size());
            Iterator i$ = this.mWakeLocks.iterator();
            while (i$.hasNext()) {
                pw.println("  " + ((WakeLock) i$.next()));
            }
            pw.println();
            pw.println("Suspend Blockers: size=" + this.mSuspendBlockers.size());
            i$ = this.mSuspendBlockers.iterator();
            while (i$.hasNext()) {
                pw.println("  " + ((SuspendBlocker) i$.next()));
            }
            pw.println();
            pw.println("Display Power: " + this.mDisplayPowerCallbacks);
            WirelessChargerDetector wcd = this.mWirelessChargerDetector;
        }
        if (wcd != null) {
            wcd.dump(pw);
        }
    }

    private SuspendBlocker createSuspendBlockerLocked(String name) {
        SuspendBlocker suspendBlocker = new SuspendBlockerImpl(name);
        this.mSuspendBlockers.add(suspendBlocker);
        return suspendBlocker;
    }

    private static WorkSource copyWorkSource(WorkSource workSource) {
        return workSource != null ? new WorkSource(workSource) : null;
    }
}
