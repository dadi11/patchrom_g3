package com.android.server.power;

import android.app.ActivityManagerInternal;
import android.app.ActivityManagerNative;
import android.app.AppOpsManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.hardware.input.InputManagerInternal;
import android.media.Ringtone;
import android.media.RingtoneManager;
import android.net.Uri;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.PowerManagerInternal;
import android.os.RemoteException;
import android.os.SystemClock;
import android.os.UserHandle;
import android.os.WorkSource;
import android.provider.Settings.Global;
import android.util.EventLog;
import android.view.WindowManagerPolicy;
import com.android.internal.app.IAppOpsService;
import com.android.internal.app.IBatteryStats;
import com.android.server.EventLogTags;
import com.android.server.LocalServices;
import com.android.server.wm.WindowManagerService.C0569H;

final class Notifier {
    private static final boolean DEBUG = false;
    private static final int INTERACTIVE_STATE_ASLEEP = 2;
    private static final int INTERACTIVE_STATE_AWAKE = 1;
    private static final int INTERACTIVE_STATE_UNKNOWN = 0;
    private static final int MSG_BROADCAST = 2;
    private static final int MSG_USER_ACTIVITY = 1;
    private static final int MSG_WIRELESS_CHARGING_STARTED = 3;
    private static final String TAG = "PowerManagerNotifier";
    private final ActivityManagerInternal mActivityManagerInternal;
    private int mActualInteractiveState;
    private final IAppOpsService mAppOps;
    private final IBatteryStats mBatteryStats;
    private boolean mBroadcastInProgress;
    private long mBroadcastStartTime;
    private int mBroadcastedInteractiveState;
    private final Context mContext;
    private final BroadcastReceiver mGoToSleepBroadcastDone;
    private final NotifierHandler mHandler;
    private final InputManagerInternal mInputManagerInternal;
    private int mLastReason;
    private final Object mLock;
    private boolean mPendingGoToSleepBroadcast;
    private boolean mPendingWakeUpBroadcast;
    private final WindowManagerPolicy mPolicy;
    private final Intent mScreenOffIntent;
    private final Intent mScreenOnIntent;
    private final SuspendBlocker mSuspendBlocker;
    private boolean mUserActivityPending;
    private final BroadcastReceiver mWakeUpBroadcastDone;

    /* renamed from: com.android.server.power.Notifier.1 */
    class C04631 implements Runnable {
        final /* synthetic */ int val$wakefulness;

        C04631(int i) {
            this.val$wakefulness = i;
        }

        public void run() {
            Notifier.this.mActivityManagerInternal.onWakefulnessChanged(this.val$wakefulness);
        }
    }

    /* renamed from: com.android.server.power.Notifier.2 */
    class C04642 implements Runnable {
        C04642() {
        }

        public void run() {
            EventLog.writeEvent(EventLogTags.POWER_SCREEN_STATE, new Object[]{Integer.valueOf(Notifier.MSG_USER_ACTIVITY), Integer.valueOf(Notifier.INTERACTIVE_STATE_UNKNOWN), Integer.valueOf(Notifier.INTERACTIVE_STATE_UNKNOWN), Integer.valueOf(Notifier.INTERACTIVE_STATE_UNKNOWN)});
            Notifier.this.mPolicy.wakingUp();
        }
    }

    /* renamed from: com.android.server.power.Notifier.3 */
    class C04653 implements Runnable {
        final /* synthetic */ int val$reason;

        C04653(int i) {
            this.val$reason = i;
        }

        public void run() {
            int why = Notifier.MSG_BROADCAST;
            switch (this.val$reason) {
                case Notifier.MSG_USER_ACTIVITY /*1*/:
                    why = Notifier.MSG_USER_ACTIVITY;
                    break;
                case Notifier.MSG_BROADCAST /*2*/:
                    why = Notifier.MSG_WIRELESS_CHARGING_STARTED;
                    break;
            }
            EventLog.writeEvent(EventLogTags.POWER_SCREEN_STATE, new Object[]{Integer.valueOf(Notifier.INTERACTIVE_STATE_UNKNOWN), Integer.valueOf(why), Integer.valueOf(Notifier.INTERACTIVE_STATE_UNKNOWN), Integer.valueOf(Notifier.INTERACTIVE_STATE_UNKNOWN)});
            Notifier.this.mPolicy.goingToSleep(why);
        }
    }

    /* renamed from: com.android.server.power.Notifier.4 */
    class C04664 extends BroadcastReceiver {
        C04664() {
        }

        public void onReceive(Context context, Intent intent) {
            Object[] objArr = new Object[Notifier.MSG_WIRELESS_CHARGING_STARTED];
            objArr[Notifier.INTERACTIVE_STATE_UNKNOWN] = Integer.valueOf(Notifier.MSG_USER_ACTIVITY);
            objArr[Notifier.MSG_USER_ACTIVITY] = Long.valueOf(SystemClock.uptimeMillis() - Notifier.this.mBroadcastStartTime);
            objArr[Notifier.MSG_BROADCAST] = Integer.valueOf(Notifier.MSG_USER_ACTIVITY);
            EventLog.writeEvent(EventLogTags.POWER_SCREEN_BROADCAST_DONE, objArr);
            Notifier.this.sendNextBroadcast();
        }
    }

    /* renamed from: com.android.server.power.Notifier.5 */
    class C04675 extends BroadcastReceiver {
        C04675() {
        }

        public void onReceive(Context context, Intent intent) {
            Object[] objArr = new Object[Notifier.MSG_WIRELESS_CHARGING_STARTED];
            objArr[Notifier.INTERACTIVE_STATE_UNKNOWN] = Integer.valueOf(Notifier.INTERACTIVE_STATE_UNKNOWN);
            objArr[Notifier.MSG_USER_ACTIVITY] = Long.valueOf(SystemClock.uptimeMillis() - Notifier.this.mBroadcastStartTime);
            objArr[Notifier.MSG_BROADCAST] = Integer.valueOf(Notifier.MSG_USER_ACTIVITY);
            EventLog.writeEvent(EventLogTags.POWER_SCREEN_BROADCAST_DONE, objArr);
            Notifier.this.sendNextBroadcast();
        }
    }

    private final class NotifierHandler extends Handler {
        public NotifierHandler(Looper looper) {
            super(looper, null, true);
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case Notifier.MSG_USER_ACTIVITY /*1*/:
                    Notifier.this.sendUserActivity();
                case Notifier.MSG_BROADCAST /*2*/:
                    Notifier.this.sendNextBroadcast();
                case Notifier.MSG_WIRELESS_CHARGING_STARTED /*3*/:
                    Notifier.this.playWirelessChargingStartedSound();
                default:
            }
        }
    }

    public Notifier(Looper looper, Context context, IBatteryStats batteryStats, IAppOpsService appOps, SuspendBlocker suspendBlocker, WindowManagerPolicy policy) {
        this.mLock = new Object();
        this.mWakeUpBroadcastDone = new C04664();
        this.mGoToSleepBroadcastDone = new C04675();
        this.mContext = context;
        this.mBatteryStats = batteryStats;
        this.mAppOps = appOps;
        this.mSuspendBlocker = suspendBlocker;
        this.mPolicy = policy;
        this.mActivityManagerInternal = (ActivityManagerInternal) LocalServices.getService(ActivityManagerInternal.class);
        this.mInputManagerInternal = (InputManagerInternal) LocalServices.getService(InputManagerInternal.class);
        this.mHandler = new NotifierHandler(looper);
        this.mScreenOnIntent = new Intent("android.intent.action.SCREEN_ON");
        this.mScreenOnIntent.addFlags(1342177280);
        this.mScreenOffIntent = new Intent("android.intent.action.SCREEN_OFF");
        this.mScreenOffIntent.addFlags(1342177280);
        try {
            this.mBatteryStats.noteInteractive(true);
        } catch (RemoteException e) {
        }
    }

    public void onWakeLockAcquired(int flags, String tag, String packageName, int ownerUid, int ownerPid, WorkSource workSource, String historyTag) {
        try {
            int monitorType = getBatteryStatsWakeLockMonitorType(flags);
            boolean unimportantForLogging = ((1073741824 & flags) == 0 || ownerUid != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) ? DEBUG : true;
            if (workSource != null) {
                this.mBatteryStats.noteStartWakelockFromSource(workSource, ownerPid, tag, historyTag, monitorType, unimportantForLogging);
                return;
            }
            this.mBatteryStats.noteStartWakelock(ownerUid, ownerPid, tag, historyTag, monitorType, unimportantForLogging);
            this.mAppOps.startOperation(AppOpsManager.getToken(this.mAppOps), 40, ownerUid, packageName);
        } catch (RemoteException e) {
        }
    }

    public void onWakeLockChanging(int flags, String tag, String packageName, int ownerUid, int ownerPid, WorkSource workSource, String historyTag, int newFlags, String newTag, String newPackageName, int newOwnerUid, int newOwnerPid, WorkSource newWorkSource, String newHistoryTag) {
        if (workSource == null || newWorkSource == null) {
            onWakeLockReleased(flags, tag, packageName, ownerUid, ownerPid, workSource, historyTag);
            onWakeLockAcquired(newFlags, newTag, newPackageName, newOwnerUid, newOwnerPid, newWorkSource, newHistoryTag);
            return;
        }
        int monitorType = getBatteryStatsWakeLockMonitorType(flags);
        int newMonitorType = getBatteryStatsWakeLockMonitorType(newFlags);
        boolean unimportantForLogging = ((1073741824 & newFlags) == 0 || newOwnerUid != 1000) ? DEBUG : true;
        try {
            this.mBatteryStats.noteChangeWakelockFromSource(workSource, ownerPid, tag, historyTag, monitorType, newWorkSource, newOwnerPid, newTag, newHistoryTag, newMonitorType, unimportantForLogging);
        } catch (RemoteException e) {
        }
    }

    public void onWakeLockReleased(int flags, String tag, String packageName, int ownerUid, int ownerPid, WorkSource workSource, String historyTag) {
        try {
            int monitorType = getBatteryStatsWakeLockMonitorType(flags);
            if (workSource != null) {
                this.mBatteryStats.noteStopWakelockFromSource(workSource, ownerPid, tag, historyTag, monitorType);
                return;
            }
            this.mBatteryStats.noteStopWakelock(ownerUid, ownerPid, tag, historyTag, monitorType);
            this.mAppOps.finishOperation(AppOpsManager.getToken(this.mAppOps), 40, ownerUid, packageName);
        } catch (RemoteException e) {
        }
    }

    private static int getBatteryStatsWakeLockMonitorType(int flags) {
        switch (65535 & flags) {
            case MSG_USER_ACTIVITY /*1*/:
            case C0569H.NOTIFY_ACTIVITY_DRAWN /*32*/:
                return INTERACTIVE_STATE_UNKNOWN;
            default:
                return MSG_USER_ACTIVITY;
        }
    }

    public void onWakefulnessChangeStarted(int wakefulness, int reason) {
        boolean interactive = PowerManagerInternal.isInteractive(wakefulness);
        if (interactive) {
            handleWakefulnessChange(wakefulness, interactive, reason);
        } else {
            this.mLastReason = reason;
        }
        this.mInputManagerInternal.setInteractive(interactive);
    }

    public void onWakefulnessChangeFinished(int wakefulness) {
        boolean interactive = PowerManagerInternal.isInteractive(wakefulness);
        if (!interactive) {
            handleWakefulnessChange(wakefulness, interactive, this.mLastReason);
        }
    }

    private void handleWakefulnessChange(int wakefulness, boolean interactive, int reason) {
        this.mHandler.post(new C04631(wakefulness));
        synchronized (this.mLock) {
            boolean interactiveChanged;
            if (interactive) {
                interactiveChanged = this.mActualInteractiveState != MSG_USER_ACTIVITY ? true : DEBUG;
                if (interactiveChanged) {
                    this.mActualInteractiveState = MSG_USER_ACTIVITY;
                    this.mPendingWakeUpBroadcast = true;
                    this.mHandler.post(new C04642());
                    updatePendingBroadcastLocked();
                }
            } else {
                interactiveChanged = this.mActualInteractiveState != MSG_BROADCAST ? true : DEBUG;
                if (interactiveChanged) {
                    this.mActualInteractiveState = MSG_BROADCAST;
                    this.mPendingGoToSleepBroadcast = true;
                    if (this.mUserActivityPending) {
                        this.mUserActivityPending = DEBUG;
                        this.mHandler.removeMessages(MSG_USER_ACTIVITY);
                    }
                    this.mHandler.post(new C04653(reason));
                    updatePendingBroadcastLocked();
                }
            }
        }
        if (interactiveChanged) {
            try {
                this.mBatteryStats.noteInteractive(interactive);
            } catch (RemoteException e) {
            }
        }
    }

    public void onUserActivity(int event, int uid) {
        try {
            this.mBatteryStats.noteUserActivity(uid, event);
        } catch (RemoteException e) {
        }
        synchronized (this.mLock) {
            if (!this.mUserActivityPending) {
                this.mUserActivityPending = true;
                Message msg = this.mHandler.obtainMessage(MSG_USER_ACTIVITY);
                msg.setAsynchronous(true);
                this.mHandler.sendMessage(msg);
            }
        }
    }

    public void onWirelessChargingStarted() {
        this.mSuspendBlocker.acquire();
        Message msg = this.mHandler.obtainMessage(MSG_WIRELESS_CHARGING_STARTED);
        msg.setAsynchronous(true);
        this.mHandler.sendMessage(msg);
    }

    private void updatePendingBroadcastLocked() {
        if (!this.mBroadcastInProgress && this.mActualInteractiveState != 0) {
            if (this.mPendingWakeUpBroadcast || this.mPendingGoToSleepBroadcast || this.mActualInteractiveState != this.mBroadcastedInteractiveState) {
                this.mBroadcastInProgress = true;
                this.mSuspendBlocker.acquire();
                Message msg = this.mHandler.obtainMessage(MSG_BROADCAST);
                msg.setAsynchronous(true);
                this.mHandler.sendMessage(msg);
            }
        }
    }

    private void finishPendingBroadcastLocked() {
        this.mBroadcastInProgress = DEBUG;
        this.mSuspendBlocker.release();
    }

    private void sendUserActivity() {
        synchronized (this.mLock) {
            if (this.mUserActivityPending) {
                this.mUserActivityPending = DEBUG;
                this.mPolicy.userActivity();
                return;
            }
        }
    }

    private void sendNextBroadcast() {
        synchronized (this.mLock) {
            if (this.mBroadcastedInteractiveState == 0) {
                this.mPendingWakeUpBroadcast = DEBUG;
                this.mBroadcastedInteractiveState = MSG_USER_ACTIVITY;
            } else if (this.mBroadcastedInteractiveState == MSG_USER_ACTIVITY) {
                if (this.mPendingWakeUpBroadcast || this.mPendingGoToSleepBroadcast || this.mActualInteractiveState == MSG_BROADCAST) {
                    this.mPendingGoToSleepBroadcast = DEBUG;
                    this.mBroadcastedInteractiveState = MSG_BROADCAST;
                } else {
                    finishPendingBroadcastLocked();
                    return;
                }
            } else if (this.mPendingWakeUpBroadcast || this.mPendingGoToSleepBroadcast || this.mActualInteractiveState == MSG_USER_ACTIVITY) {
                this.mPendingWakeUpBroadcast = DEBUG;
                this.mBroadcastedInteractiveState = MSG_USER_ACTIVITY;
            } else {
                finishPendingBroadcastLocked();
                return;
            }
            this.mBroadcastStartTime = SystemClock.uptimeMillis();
            int powerState = this.mBroadcastedInteractiveState;
            EventLog.writeEvent(EventLogTags.POWER_SCREEN_BROADCAST_SEND, MSG_USER_ACTIVITY);
            if (powerState == MSG_USER_ACTIVITY) {
                sendWakeUpBroadcast();
            } else {
                sendGoToSleepBroadcast();
            }
        }
    }

    private void sendWakeUpBroadcast() {
        if (ActivityManagerNative.isSystemReady()) {
            this.mContext.sendOrderedBroadcastAsUser(this.mScreenOnIntent, UserHandle.ALL, null, this.mWakeUpBroadcastDone, this.mHandler, INTERACTIVE_STATE_UNKNOWN, null, null);
            return;
        }
        Object[] objArr = new Object[MSG_BROADCAST];
        objArr[INTERACTIVE_STATE_UNKNOWN] = Integer.valueOf(MSG_BROADCAST);
        objArr[MSG_USER_ACTIVITY] = Integer.valueOf(MSG_USER_ACTIVITY);
        EventLog.writeEvent(EventLogTags.POWER_SCREEN_BROADCAST_STOP, objArr);
        sendNextBroadcast();
    }

    private void sendGoToSleepBroadcast() {
        if (ActivityManagerNative.isSystemReady()) {
            this.mContext.sendOrderedBroadcastAsUser(this.mScreenOffIntent, UserHandle.ALL, null, this.mGoToSleepBroadcastDone, this.mHandler, INTERACTIVE_STATE_UNKNOWN, null, null);
            return;
        }
        Object[] objArr = new Object[MSG_BROADCAST];
        objArr[INTERACTIVE_STATE_UNKNOWN] = Integer.valueOf(MSG_WIRELESS_CHARGING_STARTED);
        objArr[MSG_USER_ACTIVITY] = Integer.valueOf(MSG_USER_ACTIVITY);
        EventLog.writeEvent(EventLogTags.POWER_SCREEN_BROADCAST_STOP, objArr);
        sendNextBroadcast();
    }

    private void playWirelessChargingStartedSound() {
        String soundPath = Global.getString(this.mContext.getContentResolver(), "wireless_charging_started_sound");
        if (soundPath != null) {
            Uri soundUri = Uri.parse("file://" + soundPath);
            if (soundUri != null) {
                Ringtone sfx = RingtoneManager.getRingtone(this.mContext, soundUri);
                if (sfx != null) {
                    sfx.setStreamType(MSG_USER_ACTIVITY);
                    sfx.play();
                }
            }
        }
        this.mSuspendBlocker.release();
    }
}
