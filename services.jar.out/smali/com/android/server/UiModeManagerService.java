package com.android.server;

import android.app.ActivityManagerNative;
import android.app.IUiModeManager.Stub;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.StatusBarManager;
import android.app.UiModeManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.res.Configuration;
import android.os.Binder;
import android.os.Handler;
import android.os.IBinder;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.RemoteException;
import android.os.UserHandle;
import android.provider.Settings.Secure;
import android.service.dreams.Sandman;
import android.util.Slog;
import com.android.internal.app.DisableCarModeActivity;
import com.android.server.twilight.TwilightListener;
import com.android.server.twilight.TwilightManager;
import com.android.server.twilight.TwilightState;
import com.android.server.wm.AppTransition;
import com.android.server.wm.WindowManagerService.C0569H;
import java.io.FileDescriptor;
import java.io.PrintWriter;

final class UiModeManagerService extends SystemService {
    private static final boolean ENABLE_LAUNCH_CAR_DOCK_APP = true;
    private static final boolean ENABLE_LAUNCH_DESK_DOCK_APP = true;
    private static final boolean LOG = false;
    private static final String TAG;
    private final BroadcastReceiver mBatteryReceiver;
    private int mCarModeEnableFlags;
    private boolean mCarModeEnabled;
    private boolean mCarModeKeepsScreenOn;
    private boolean mCharging;
    private boolean mComputedNightMode;
    private Configuration mConfiguration;
    int mCurUiMode;
    private int mDefaultUiModeType;
    private boolean mDeskModeKeepsScreenOn;
    private final BroadcastReceiver mDockModeReceiver;
    private int mDockState;
    private final Handler mHandler;
    private boolean mHoldingConfiguration;
    private int mLastBroadcastState;
    final Object mLock;
    int mNightMode;
    private NotificationManager mNotificationManager;
    private final BroadcastReceiver mResultReceiver;
    private final IBinder mService;
    private int mSetUiMode;
    private StatusBarManager mStatusBarManager;
    boolean mSystemReady;
    private boolean mTelevision;
    private final TwilightListener mTwilightListener;
    private TwilightManager mTwilightManager;
    private WakeLock mWakeLock;
    private boolean mWatch;

    /* renamed from: com.android.server.UiModeManagerService.1 */
    class C00861 extends BroadcastReceiver {
        C00861() {
        }

        public void onReceive(Context context, Intent intent) {
            if (getResultCode() == -1) {
                int enableFlags = intent.getIntExtra("enableFlags", 0);
                int disableFlags = intent.getIntExtra("disableFlags", 0);
                synchronized (UiModeManagerService.this.mLock) {
                    UiModeManagerService.this.updateAfterBroadcastLocked(intent.getAction(), enableFlags, disableFlags);
                }
            }
        }
    }

    /* renamed from: com.android.server.UiModeManagerService.2 */
    class C00872 extends BroadcastReceiver {
        C00872() {
        }

        public void onReceive(Context context, Intent intent) {
            UiModeManagerService.this.updateDockState(intent.getIntExtra("android.intent.extra.DOCK_STATE", 0));
        }
    }

    /* renamed from: com.android.server.UiModeManagerService.3 */
    class C00883 extends BroadcastReceiver {
        C00883() {
        }

        public void onReceive(Context context, Intent intent) {
            boolean z = false;
            UiModeManagerService uiModeManagerService = UiModeManagerService.this;
            if (intent.getIntExtra("plugged", 0) != 0) {
                z = UiModeManagerService.ENABLE_LAUNCH_DESK_DOCK_APP;
            }
            uiModeManagerService.mCharging = z;
            synchronized (UiModeManagerService.this.mLock) {
                if (UiModeManagerService.this.mSystemReady) {
                    UiModeManagerService.this.updateLocked(0, 0);
                }
            }
        }
    }

    /* renamed from: com.android.server.UiModeManagerService.4 */
    class C00894 implements TwilightListener {
        C00894() {
        }

        public void onTwilightStateChanged() {
            UiModeManagerService.this.updateTwilight();
        }
    }

    /* renamed from: com.android.server.UiModeManagerService.5 */
    class C00905 extends Stub {
        C00905() {
        }

        public void enableCarMode(int flags) {
            long ident = Binder.clearCallingIdentity();
            try {
                synchronized (UiModeManagerService.this.mLock) {
                    UiModeManagerService.this.setCarModeLocked(UiModeManagerService.ENABLE_LAUNCH_DESK_DOCK_APP, flags);
                    if (UiModeManagerService.this.mSystemReady) {
                        UiModeManagerService.this.updateLocked(flags, 0);
                    }
                }
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }

        public void disableCarMode(int flags) {
            long ident = Binder.clearCallingIdentity();
            try {
                synchronized (UiModeManagerService.this.mLock) {
                    UiModeManagerService.this.setCarModeLocked(false, 0);
                    if (UiModeManagerService.this.mSystemReady) {
                        UiModeManagerService.this.updateLocked(0, flags);
                    }
                }
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }

        public int getCurrentModeType() {
            long ident = Binder.clearCallingIdentity();
            try {
                int i;
                synchronized (UiModeManagerService.this.mLock) {
                    i = UiModeManagerService.this.mCurUiMode & 15;
                }
                return i;
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }

        public void setNightMode(int mode) {
            switch (mode) {
                case AppTransition.TRANSIT_NONE /*0*/:
                case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
                case C0569H.REPORT_FOCUS_CHANGE /*2*/:
                    long ident = Binder.clearCallingIdentity();
                    try {
                        synchronized (UiModeManagerService.this.mLock) {
                            if (UiModeManagerService.this.isDoingNightModeLocked() && UiModeManagerService.this.mNightMode != mode) {
                                Secure.putInt(UiModeManagerService.this.getContext().getContentResolver(), "ui_night_mode", mode);
                                UiModeManagerService.this.mNightMode = mode;
                                UiModeManagerService.this.updateLocked(0, 0);
                            }
                            break;
                        }
                    } finally {
                        Binder.restoreCallingIdentity(ident);
                    }
                default:
                    throw new IllegalArgumentException("Unknown mode: " + mode);
            }
        }

        public int getNightMode() {
            int i;
            synchronized (UiModeManagerService.this.mLock) {
                i = UiModeManagerService.this.mNightMode;
            }
            return i;
        }

        protected void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
            if (UiModeManagerService.this.getContext().checkCallingOrSelfPermission("android.permission.DUMP") != 0) {
                pw.println("Permission Denial: can't dump uimode service from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid());
            } else {
                UiModeManagerService.this.dumpImpl(pw);
            }
        }
    }

    static {
        TAG = UiModeManager.class.getSimpleName();
    }

    public UiModeManagerService(Context context) {
        super(context);
        this.mLock = new Object();
        this.mDockState = 0;
        this.mLastBroadcastState = 0;
        this.mNightMode = 1;
        this.mCarModeEnabled = false;
        this.mCharging = false;
        this.mCurUiMode = 0;
        this.mSetUiMode = 0;
        this.mHoldingConfiguration = false;
        this.mConfiguration = new Configuration();
        this.mHandler = new Handler();
        this.mResultReceiver = new C00861();
        this.mDockModeReceiver = new C00872();
        this.mBatteryReceiver = new C00883();
        this.mTwilightListener = new C00894();
        this.mService = new C00905();
    }

    private static Intent buildHomeIntent(String category) {
        Intent intent = new Intent("android.intent.action.MAIN");
        intent.addCategory(category);
        intent.setFlags(270532608);
        return intent;
    }

    public void onStart() {
        boolean z;
        boolean z2 = ENABLE_LAUNCH_DESK_DOCK_APP;
        Context context = getContext();
        this.mTwilightManager = (TwilightManager) getLocalService(TwilightManager.class);
        this.mWakeLock = ((PowerManager) context.getSystemService("power")).newWakeLock(26, TAG);
        context.registerReceiver(this.mDockModeReceiver, new IntentFilter("android.intent.action.DOCK_EVENT"));
        context.registerReceiver(this.mBatteryReceiver, new IntentFilter("android.intent.action.BATTERY_CHANGED"));
        this.mConfiguration.setToDefaults();
        this.mDefaultUiModeType = context.getResources().getInteger(17694783);
        this.mCarModeKeepsScreenOn = context.getResources().getInteger(17694781) == 1 ? ENABLE_LAUNCH_DESK_DOCK_APP : false;
        if (context.getResources().getInteger(17694779) == 1) {
            z = ENABLE_LAUNCH_DESK_DOCK_APP;
        } else {
            z = false;
        }
        this.mDeskModeKeepsScreenOn = z;
        if (!(context.getPackageManager().hasSystemFeature("android.hardware.type.television") || context.getPackageManager().hasSystemFeature("android.software.leanback"))) {
            z2 = false;
        }
        this.mTelevision = z2;
        this.mWatch = context.getPackageManager().hasSystemFeature("android.hardware.type.watch");
        this.mNightMode = Secure.getInt(context.getContentResolver(), "ui_night_mode", 0);
        this.mTwilightManager.registerListener(this.mTwilightListener, this.mHandler);
        publishBinderService("uimode", this.mService);
    }

    void dumpImpl(PrintWriter pw) {
        synchronized (this.mLock) {
            pw.println("Current UI Mode Service state:");
            pw.print("  mDockState=");
            pw.print(this.mDockState);
            pw.print(" mLastBroadcastState=");
            pw.println(this.mLastBroadcastState);
            pw.print("  mNightMode=");
            pw.print(this.mNightMode);
            pw.print(" mCarModeEnabled=");
            pw.print(this.mCarModeEnabled);
            pw.print(" mComputedNightMode=");
            pw.print(this.mComputedNightMode);
            pw.print(" mCarModeEnableFlags=");
            pw.println(this.mCarModeEnableFlags);
            pw.print("  mCurUiMode=0x");
            pw.print(Integer.toHexString(this.mCurUiMode));
            pw.print(" mSetUiMode=0x");
            pw.println(Integer.toHexString(this.mSetUiMode));
            pw.print("  mHoldingConfiguration=");
            pw.print(this.mHoldingConfiguration);
            pw.print(" mSystemReady=");
            pw.println(this.mSystemReady);
            pw.print("  mTwilightService.getCurrentState()=");
            pw.println(this.mTwilightManager.getCurrentState());
        }
    }

    public void onBootPhase(int phase) {
        boolean z = ENABLE_LAUNCH_DESK_DOCK_APP;
        if (phase == SystemService.PHASE_SYSTEM_SERVICES_READY) {
            synchronized (this.mLock) {
                this.mSystemReady = ENABLE_LAUNCH_DESK_DOCK_APP;
                if (this.mDockState != 2) {
                    z = false;
                }
                this.mCarModeEnabled = z;
                updateComputedNightModeLocked();
                updateLocked(0, 0);
            }
        }
    }

    boolean isDoingNightModeLocked() {
        return (this.mCarModeEnabled || this.mDockState != 0) ? ENABLE_LAUNCH_DESK_DOCK_APP : false;
    }

    void setCarModeLocked(boolean enabled, int flags) {
        if (this.mCarModeEnabled != enabled) {
            this.mCarModeEnabled = enabled;
        }
        this.mCarModeEnableFlags = flags;
    }

    private void updateDockState(int newState) {
        boolean z = ENABLE_LAUNCH_DESK_DOCK_APP;
        synchronized (this.mLock) {
            if (newState != this.mDockState) {
                this.mDockState = newState;
                if (this.mDockState != 2) {
                    z = false;
                }
                setCarModeLocked(z, 0);
                if (this.mSystemReady) {
                    updateLocked(1, 0);
                }
            }
        }
    }

    private static boolean isDeskDockState(int state) {
        switch (state) {
            case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
            case C0569H.REPORT_LOSING_FOCUS /*3*/:
            case C0569H.DO_TRAVERSAL /*4*/:
                return ENABLE_LAUNCH_DESK_DOCK_APP;
            default:
                return false;
        }
    }

    private void updateConfigurationLocked() {
        int uiMode = this.mDefaultUiModeType;
        if (this.mTelevision) {
            uiMode = 4;
        } else if (this.mWatch) {
            uiMode = 6;
        } else if (this.mCarModeEnabled) {
            uiMode = 3;
        } else if (isDeskDockState(this.mDockState)) {
            uiMode = 2;
        }
        if (!this.mCarModeEnabled) {
            uiMode = (uiMode & -49) | 16;
        } else if (this.mNightMode == 0) {
            int i;
            updateComputedNightModeLocked();
            if (this.mComputedNightMode) {
                i = 32;
            } else {
                i = 16;
            }
            uiMode |= i;
        } else {
            uiMode |= this.mNightMode << 4;
        }
        this.mCurUiMode = uiMode;
        if (!this.mHoldingConfiguration) {
            this.mConfiguration.uiMode = uiMode;
        }
    }

    private void sendConfigurationLocked() {
        if (this.mSetUiMode != this.mConfiguration.uiMode) {
            this.mSetUiMode = this.mConfiguration.uiMode;
            try {
                ActivityManagerNative.getDefault().updateConfiguration(this.mConfiguration);
            } catch (RemoteException e) {
                Slog.w(TAG, "Failure communicating with activity manager", e);
            }
        }
    }

    void updateLocked(int enableFlags, int disableFlags) {
        String action = null;
        String oldAction = null;
        if (this.mLastBroadcastState == 2) {
            adjustStatusBarCarModeLocked();
            oldAction = UiModeManager.ACTION_EXIT_CAR_MODE;
        } else if (isDeskDockState(this.mLastBroadcastState)) {
            oldAction = UiModeManager.ACTION_EXIT_DESK_MODE;
        }
        if (this.mCarModeEnabled) {
            if (this.mLastBroadcastState != 2) {
                adjustStatusBarCarModeLocked();
                if (oldAction != null) {
                    getContext().sendBroadcastAsUser(new Intent(oldAction), UserHandle.ALL);
                }
                this.mLastBroadcastState = 2;
                action = UiModeManager.ACTION_ENTER_CAR_MODE;
            }
        } else if (!isDeskDockState(this.mDockState)) {
            this.mLastBroadcastState = 0;
            action = oldAction;
        } else if (!isDeskDockState(this.mLastBroadcastState)) {
            if (oldAction != null) {
                getContext().sendBroadcastAsUser(new Intent(oldAction), UserHandle.ALL);
            }
            this.mLastBroadcastState = this.mDockState;
            action = UiModeManager.ACTION_ENTER_DESK_MODE;
        }
        if (action != null) {
            Intent intent = new Intent(action);
            intent.putExtra("enableFlags", enableFlags);
            intent.putExtra("disableFlags", disableFlags);
            getContext().sendOrderedBroadcastAsUser(intent, UserHandle.CURRENT, null, this.mResultReceiver, null, -1, null, null);
            this.mHoldingConfiguration = ENABLE_LAUNCH_DESK_DOCK_APP;
            updateConfigurationLocked();
        } else {
            String category = null;
            if (this.mCarModeEnabled) {
                if ((enableFlags & 1) != 0) {
                    category = "android.intent.category.CAR_DOCK";
                }
            } else if (isDeskDockState(this.mDockState)) {
                if ((enableFlags & 1) != 0) {
                    category = "android.intent.category.DESK_DOCK";
                }
            } else if ((disableFlags & 1) != 0) {
                category = "android.intent.category.HOME";
            }
            sendConfigurationAndStartDreamOrDockAppLocked(category);
        }
        boolean keepScreenOn = (this.mCharging && ((this.mCarModeEnabled && this.mCarModeKeepsScreenOn && (this.mCarModeEnableFlags & 2) == 0) || (this.mCurUiMode == 2 && this.mDeskModeKeepsScreenOn))) ? ENABLE_LAUNCH_DESK_DOCK_APP : false;
        if (keepScreenOn == this.mWakeLock.isHeld()) {
            return;
        }
        if (keepScreenOn) {
            this.mWakeLock.acquire();
        } else {
            this.mWakeLock.release();
        }
    }

    private void updateAfterBroadcastLocked(String action, int enableFlags, int disableFlags) {
        String category = null;
        if (UiModeManager.ACTION_ENTER_CAR_MODE.equals(action)) {
            if ((enableFlags & 1) != 0) {
                category = "android.intent.category.CAR_DOCK";
            }
        } else if (UiModeManager.ACTION_ENTER_DESK_MODE.equals(action)) {
            if ((enableFlags & 1) != 0) {
                category = "android.intent.category.DESK_DOCK";
            }
        } else if ((disableFlags & 1) != 0) {
            category = "android.intent.category.HOME";
        }
        sendConfigurationAndStartDreamOrDockAppLocked(category);
    }

    private void sendConfigurationAndStartDreamOrDockAppLocked(String category) {
        this.mHoldingConfiguration = false;
        updateConfigurationLocked();
        boolean dockAppStarted = false;
        if (category != null) {
            Intent homeIntent = buildHomeIntent(category);
            if (Sandman.shouldStartDockApp(getContext(), homeIntent)) {
                try {
                    int result = ActivityManagerNative.getDefault().startActivityWithConfig(null, null, homeIntent, null, null, null, 0, 0, this.mConfiguration, null, -2);
                    if (result >= 0) {
                        dockAppStarted = ENABLE_LAUNCH_DESK_DOCK_APP;
                    } else if (result != -1) {
                        Slog.e(TAG, "Could not start dock app: " + homeIntent + ", startActivityWithConfig result " + result);
                    }
                } catch (RemoteException ex) {
                    Slog.e(TAG, "Could not start dock app: " + homeIntent, ex);
                }
            }
        }
        sendConfigurationLocked();
        if (category != null && !dockAppStarted) {
            Sandman.startDreamWhenDockedIfAppropriate(getContext());
        }
    }

    private void adjustStatusBarCarModeLocked() {
        Context context = getContext();
        if (this.mStatusBarManager == null) {
            this.mStatusBarManager = (StatusBarManager) context.getSystemService("statusbar");
        }
        if (this.mStatusBarManager != null) {
            this.mStatusBarManager.disable(this.mCarModeEnabled ? 524288 : 0);
        }
        if (this.mNotificationManager == null) {
            this.mNotificationManager = (NotificationManager) context.getSystemService("notification");
        }
        if (this.mNotificationManager == null) {
            return;
        }
        if (this.mCarModeEnabled) {
            Intent carModeOffIntent = new Intent(context, DisableCarModeActivity.class);
            Notification n = new Notification();
            n.icon = 17303112;
            n.defaults = 4;
            n.flags = 2;
            n.when = 0;
            n.color = context.getResources().getColor(17170521);
            n.setLatestEventInfo(context, context.getString(17040743), context.getString(17040744), PendingIntent.getActivityAsUser(context, 0, carModeOffIntent, 0, null, UserHandle.CURRENT));
            this.mNotificationManager.notifyAsUser(null, 17040743, n, UserHandle.ALL);
            return;
        }
        this.mNotificationManager.cancelAsUser(null, 17040743, UserHandle.ALL);
    }

    void updateTwilight() {
        synchronized (this.mLock) {
            if (isDoingNightModeLocked() && this.mNightMode == 0) {
                updateComputedNightModeLocked();
                updateLocked(0, 0);
            }
        }
    }

    private void updateComputedNightModeLocked() {
        TwilightState state = this.mTwilightManager.getCurrentState();
        if (state != null) {
            this.mComputedNightMode = state.isNight();
        }
    }
}
