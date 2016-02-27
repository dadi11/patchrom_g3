package com.android.server.am;

import android.app.ActivityManager;
import android.app.ActivityManager.RunningTaskInfo;
import android.app.ActivityOptions;
import android.app.AppGlobals;
import android.app.IActivityController;
import android.app.IApplicationThread;
import android.app.ResultInfo;
import android.content.ComponentName;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.content.res.Configuration;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Binder;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.os.PersistableBundle;
import android.os.RemoteException;
import android.os.SystemClock;
import android.os.Trace;
import android.os.UserHandle;
import android.service.voice.IVoiceInteractionSession;
import android.util.ArraySet;
import android.util.EventLog;
import android.util.Slog;
import android.view.IApplicationToken;
import com.android.internal.app.IVoiceInteractor;
import com.android.internal.content.ReferrerIntent;
import com.android.internal.os.BatteryStatsImpl;
import com.android.internal.os.BatteryStatsImpl.Uid.Proc;
import com.android.server.Watchdog;
import com.android.server.wm.TaskGroup;
import com.android.server.wm.WindowManagerService;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Objects;

final class ActivityStack {
    static final long ACTIVITY_INACTIVE_RESET_TIME = 0;
    static final int DESTROY_ACTIVITIES_MSG = 105;
    static final int DESTROY_TIMEOUT = 10000;
    static final int DESTROY_TIMEOUT_MSG = 102;
    static final int FINISH_AFTER_PAUSE = 1;
    static final int FINISH_AFTER_VISIBLE = 2;
    static final int FINISH_IMMEDIATELY = 0;
    static final int LAUNCH_TICK = 500;
    static final int LAUNCH_TICK_MSG = 103;
    static final int PAUSE_TIMEOUT = 500;
    static final int PAUSE_TIMEOUT_MSG = 101;
    static final int RELEASE_BACKGROUND_RESOURCES_TIMEOUT_MSG = 107;
    static final boolean SCREENSHOT_FORCE_565;
    static final boolean SHOW_APP_STARTING_PREVIEW = true;
    static final long START_WARN_TIME = 5000;
    static final int STOP_TIMEOUT = 10000;
    static final int STOP_TIMEOUT_MSG = 104;
    static final long TRANSLUCENT_CONVERSION_TIMEOUT = 2000;
    static final int TRANSLUCENT_TIMEOUT_MSG = 106;
    final ActivityContainer mActivityContainer;
    boolean mConfigWillChange;
    int mCurrentUser;
    int mDisplayId;
    long mFullyDrawnStartTime;
    final Handler mHandler;
    final ArrayList<ActivityRecord> mLRUActivities;
    ActivityRecord mLastNoHistoryActivity;
    ActivityRecord mLastPausedActivity;
    ActivityRecord mLastStartedActivity;
    long mLaunchStartTime;
    final ArrayList<ActivityRecord> mNoAnimActivities;
    ActivityRecord mPausingActivity;
    ActivityRecord mResumedActivity;
    final ActivityManagerService mService;
    final int mStackId;
    final ActivityStackSupervisor mStackSupervisor;
    ArrayList<ActivityStack> mStacks;
    private ArrayList<TaskRecord> mTaskHistory;
    ActivityRecord mTranslucentActivityWaiting;
    private ArrayList<ActivityRecord> mUndrawnActivitiesBelowTopTranslucent;
    final ArrayList<TaskGroup> mValidateAppTokens;
    final WindowManagerService mWindowManager;

    /* renamed from: com.android.server.am.ActivityStack.1 */
    static /* synthetic */ class C01331 {
        static final /* synthetic */ int[] $SwitchMap$com$android$server$am$ActivityStack$ActivityState;

        static {
            $SwitchMap$com$android$server$am$ActivityStack$ActivityState = new int[ActivityState.values().length];
            try {
                $SwitchMap$com$android$server$am$ActivityStack$ActivityState[ActivityState.STOPPING.ordinal()] = ActivityStack.FINISH_AFTER_PAUSE;
            } catch (NoSuchFieldError e) {
            }
            try {
                $SwitchMap$com$android$server$am$ActivityStack$ActivityState[ActivityState.STOPPED.ordinal()] = ActivityStack.FINISH_AFTER_VISIBLE;
            } catch (NoSuchFieldError e2) {
            }
            try {
                $SwitchMap$com$android$server$am$ActivityStack$ActivityState[ActivityState.INITIALIZING.ordinal()] = 3;
            } catch (NoSuchFieldError e3) {
            }
            try {
                $SwitchMap$com$android$server$am$ActivityStack$ActivityState[ActivityState.RESUMED.ordinal()] = 4;
            } catch (NoSuchFieldError e4) {
            }
            try {
                $SwitchMap$com$android$server$am$ActivityStack$ActivityState[ActivityState.PAUSING.ordinal()] = 5;
            } catch (NoSuchFieldError e5) {
            }
            try {
                $SwitchMap$com$android$server$am$ActivityStack$ActivityState[ActivityState.PAUSED.ordinal()] = 6;
            } catch (NoSuchFieldError e6) {
            }
        }
    }

    final class ActivityStackHandler extends Handler {
        ActivityStackHandler(Looper looper) {
            super(looper);
        }

        public void handleMessage(Message msg) {
            IBinder iBinder = null;
            ActivityRecord r;
            switch (msg.what) {
                case ActivityStack.PAUSE_TIMEOUT_MSG /*101*/:
                    r = msg.obj;
                    Slog.w("ActivityManager", "Activity pause timeout for " + r);
                    synchronized (ActivityStack.this.mService) {
                        if (r.app != null) {
                            ActivityStack.this.mService.logAppTooSlow(r.app, r.pauseTime, "pausing " + r);
                        }
                        ActivityStack.this.activityPausedLocked(r.appToken, ActivityStack.SHOW_APP_STARTING_PREVIEW);
                        break;
                    }
                case ActivityStack.DESTROY_TIMEOUT_MSG /*102*/:
                    r = (ActivityRecord) msg.obj;
                    Slog.w("ActivityManager", "Activity destroy timeout for " + r);
                    synchronized (ActivityStack.this.mService) {
                        ActivityStack activityStack = ActivityStack.this;
                        if (r != null) {
                            iBinder = r.appToken;
                        }
                        activityStack.activityDestroyedLocked(iBinder, "destroyTimeout");
                        break;
                    }
                case ActivityStack.LAUNCH_TICK_MSG /*103*/:
                    r = (ActivityRecord) msg.obj;
                    synchronized (ActivityStack.this.mService) {
                        if (r.continueLaunchTickingLocked()) {
                            ActivityStack.this.mService.logAppTooSlow(r.app, r.launchTickTime, "launching " + r);
                        }
                        break;
                    }
                case ActivityStack.STOP_TIMEOUT_MSG /*104*/:
                    r = (ActivityRecord) msg.obj;
                    Slog.w("ActivityManager", "Activity stop timeout for " + r);
                    synchronized (ActivityStack.this.mService) {
                        if (r.isInHistory()) {
                            ActivityStack.this.activityStoppedLocked(r, null, null, null);
                        }
                        break;
                    }
                case ActivityStack.DESTROY_ACTIVITIES_MSG /*105*/:
                    ScheduleDestroyArgs args = msg.obj;
                    synchronized (ActivityStack.this.mService) {
                        ActivityStack.this.destroyActivitiesLocked(args.mOwner, args.mReason);
                        break;
                    }
                case ActivityStack.TRANSLUCENT_TIMEOUT_MSG /*106*/:
                    synchronized (ActivityStack.this.mService) {
                        ActivityStack.this.notifyActivityDrawnLocked(null);
                        break;
                    }
                case ActivityStack.RELEASE_BACKGROUND_RESOURCES_TIMEOUT_MSG /*107*/:
                    synchronized (ActivityStack.this.mService) {
                        r = ActivityStack.this.getVisibleBehindActivity();
                        Slog.e("ActivityManager", "Timeout waiting for cancelVisibleBehind player=" + r);
                        if (r != null) {
                            ActivityStack.this.mService.killAppAtUsersRequest(r.app, null);
                        }
                        break;
                    }
                default:
            }
        }
    }

    enum ActivityState {
        INITIALIZING,
        RESUMED,
        PAUSING,
        PAUSED,
        STOPPING,
        STOPPED,
        FINISHING,
        DESTROYING,
        DESTROYED
    }

    static class ScheduleDestroyArgs {
        final ProcessRecord mOwner;
        final String mReason;

        ScheduleDestroyArgs(ProcessRecord owner, String reason) {
            this.mOwner = owner;
            this.mReason = reason;
        }
    }

    static {
        SCREENSHOT_FORCE_565 = ActivityManager.isLowRamDeviceStatic();
    }

    int numActivities() {
        int count = FINISH_IMMEDIATELY;
        for (int taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
            count += ((TaskRecord) this.mTaskHistory.get(taskNdx)).mActivities.size();
        }
        return count;
    }

    ActivityStack(ActivityContainer activityContainer) {
        this.mTaskHistory = new ArrayList();
        this.mValidateAppTokens = new ArrayList();
        this.mLRUActivities = new ArrayList();
        this.mNoAnimActivities = new ArrayList();
        this.mPausingActivity = null;
        this.mLastPausedActivity = null;
        this.mLastNoHistoryActivity = null;
        this.mResumedActivity = null;
        this.mLastStartedActivity = null;
        this.mTranslucentActivityWaiting = null;
        this.mUndrawnActivitiesBelowTopTranslucent = new ArrayList();
        this.mLaunchStartTime = ACTIVITY_INACTIVE_RESET_TIME;
        this.mFullyDrawnStartTime = ACTIVITY_INACTIVE_RESET_TIME;
        this.mActivityContainer = activityContainer;
        this.mStackSupervisor = activityContainer.getOuter();
        this.mService = this.mStackSupervisor.mService;
        this.mHandler = new ActivityStackHandler(this.mService.mHandler.getLooper());
        this.mWindowManager = this.mService.mWindowManager;
        this.mStackId = activityContainer.mStackId;
        this.mCurrentUser = this.mService.mCurrentUserId;
    }

    private boolean isCurrentProfileLocked(int userId) {
        if (userId == this.mCurrentUser) {
            return SHOW_APP_STARTING_PREVIEW;
        }
        for (int i = FINISH_IMMEDIATELY; i < this.mService.mCurrentProfileIds.length; i += FINISH_AFTER_PAUSE) {
            if (this.mService.mCurrentProfileIds[i] == userId) {
                return SHOW_APP_STARTING_PREVIEW;
            }
        }
        return SCREENSHOT_FORCE_565;
    }

    boolean okToShowLocked(ActivityRecord r) {
        return (isCurrentProfileLocked(r.userId) || (r.info.flags & DumpState.DUMP_PREFERRED_XML) != 0) ? SHOW_APP_STARTING_PREVIEW : SCREENSHOT_FORCE_565;
    }

    final ActivityRecord topRunningActivityLocked(ActivityRecord notTop) {
        for (int taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
            ActivityRecord r = ((TaskRecord) this.mTaskHistory.get(taskNdx)).topRunningActivityLocked(notTop);
            if (r != null) {
                return r;
            }
        }
        return null;
    }

    final ActivityRecord topRunningNonDelayedActivityLocked(ActivityRecord notTop) {
        for (int taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
            ArrayList<ActivityRecord> activities = ((TaskRecord) this.mTaskHistory.get(taskNdx)).mActivities;
            for (int activityNdx = activities.size() - 1; activityNdx >= 0; activityNdx--) {
                ActivityRecord r = (ActivityRecord) activities.get(activityNdx);
                if (!r.finishing && !r.delayedResume && r != notTop && okToShowLocked(r)) {
                    return r;
                }
            }
        }
        return null;
    }

    final ActivityRecord topRunningActivityLocked(IBinder token, int taskId) {
        for (int taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
            TaskRecord task = (TaskRecord) this.mTaskHistory.get(taskNdx);
            if (task.taskId != taskId) {
                ArrayList<ActivityRecord> activities = task.mActivities;
                for (int i = activities.size() - 1; i >= 0; i--) {
                    ActivityRecord r = (ActivityRecord) activities.get(i);
                    if (!r.finishing && token != r.appToken && okToShowLocked(r)) {
                        return r;
                    }
                }
                continue;
            }
        }
        return null;
    }

    final ActivityRecord topActivity() {
        for (int taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
            ArrayList<ActivityRecord> activities = ((TaskRecord) this.mTaskHistory.get(taskNdx)).mActivities;
            for (int activityNdx = activities.size() - 1; activityNdx >= 0; activityNdx--) {
                ActivityRecord r = (ActivityRecord) activities.get(activityNdx);
                if (!r.finishing) {
                    return r;
                }
            }
        }
        return null;
    }

    final TaskRecord topTask() {
        int size = this.mTaskHistory.size();
        if (size > 0) {
            return (TaskRecord) this.mTaskHistory.get(size - 1);
        }
        return null;
    }

    TaskRecord taskForIdLocked(int id) {
        for (int taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
            TaskRecord task = (TaskRecord) this.mTaskHistory.get(taskNdx);
            if (task.taskId == id) {
                return task;
            }
        }
        return null;
    }

    ActivityRecord isInStackLocked(IBinder token) {
        ActivityRecord r = ActivityRecord.forToken(token);
        if (r != null) {
            TaskRecord task = r.task;
            if (task != null && task.mActivities.contains(r) && this.mTaskHistory.contains(task)) {
                if (task.stack == this) {
                    return r;
                }
                Slog.w("ActivityManager", "Illegal state! task does not point to stack it is in.");
                return r;
            }
        }
        return null;
    }

    final boolean updateLRUListLocked(ActivityRecord r) {
        boolean hadit = this.mLRUActivities.remove(r);
        this.mLRUActivities.add(r);
        return hadit;
    }

    final boolean isHomeStack() {
        return this.mStackId == 0 ? SHOW_APP_STARTING_PREVIEW : SCREENSHOT_FORCE_565;
    }

    final boolean isOnHomeDisplay() {
        return (isAttached() && this.mActivityContainer.mActivityDisplay.mDisplayId == 0) ? SHOW_APP_STARTING_PREVIEW : SCREENSHOT_FORCE_565;
    }

    final void moveToFront(String reason) {
        if (isAttached()) {
            if (isOnHomeDisplay()) {
                this.mStackSupervisor.moveHomeStack(isHomeStack(), reason);
            }
            this.mStacks.remove(this);
            this.mStacks.add(this);
            TaskRecord task = topTask();
            if (task != null) {
                this.mWindowManager.moveTaskToTop(task.taskId);
            }
        }
    }

    final boolean isAttached() {
        return this.mStacks != null ? SHOW_APP_STARTING_PREVIEW : SCREENSHOT_FORCE_565;
    }

    ActivityRecord findTaskLocked(ActivityRecord target) {
        Intent intent = target.intent;
        ActivityInfo info = target.info;
        ComponentName cls = intent.getComponent();
        if (info.targetActivity != null) {
            cls = new ComponentName(info.packageName, info.targetActivity);
        }
        int userId = UserHandle.getUserId(info.applicationInfo.uid);
        boolean isDocument = (intent != null ? FINISH_AFTER_PAUSE : FINISH_IMMEDIATELY) & intent.isDocument();
        Uri documentData = isDocument ? intent.getData() : null;
        for (int taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
            TaskRecord task = (TaskRecord) this.mTaskHistory.get(taskNdx);
            if (task.voiceSession == null && task.userId == userId) {
                ActivityRecord r = task.getTopActivity();
                if (!(r == null || r.finishing || r.userId != userId || r.launchMode == 3)) {
                    Intent taskIntent = task.intent;
                    Intent affinityIntent = task.affinityIntent;
                    boolean taskIsDocument;
                    Uri taskDocumentData;
                    if (taskIntent != null && taskIntent.isDocument()) {
                        taskIsDocument = SHOW_APP_STARTING_PREVIEW;
                        taskDocumentData = taskIntent.getData();
                    } else if (affinityIntent == null || !affinityIntent.isDocument()) {
                        taskIsDocument = SCREENSHOT_FORCE_565;
                        taskDocumentData = null;
                    } else {
                        taskIsDocument = SHOW_APP_STARTING_PREVIEW;
                        taskDocumentData = affinityIntent.getData();
                    }
                    if (isDocument || taskIsDocument || task.rootAffinity == null) {
                        if (taskIntent != null && taskIntent.getComponent() != null && taskIntent.getComponent().compareTo(cls) == 0 && Objects.equals(documentData, taskDocumentData)) {
                            return r;
                        }
                        if (affinityIntent != null && affinityIntent.getComponent() != null && affinityIntent.getComponent().compareTo(cls) == 0 && Objects.equals(documentData, taskDocumentData)) {
                            return r;
                        }
                    } else if (task.rootAffinity.equals(target.taskAffinity)) {
                        return r;
                    }
                }
            }
        }
        return null;
    }

    ActivityRecord findActivityLocked(Intent intent, ActivityInfo info) {
        ComponentName cls = intent.getComponent();
        if (info.targetActivity != null) {
            cls = new ComponentName(info.packageName, info.targetActivity);
        }
        int userId = UserHandle.getUserId(info.applicationInfo.uid);
        for (int taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
            TaskRecord task = (TaskRecord) this.mTaskHistory.get(taskNdx);
            if (!isCurrentProfileLocked(task.userId)) {
                return null;
            }
            ArrayList<ActivityRecord> activities = task.mActivities;
            for (int activityNdx = activities.size() - 1; activityNdx >= 0; activityNdx--) {
                ActivityRecord r = (ActivityRecord) activities.get(activityNdx);
                if (!r.finishing && r.intent.getComponent().equals(cls) && r.userId == userId) {
                    return r;
                }
            }
        }
        return null;
    }

    final void switchUserLocked(int userId) {
        if (this.mCurrentUser != userId) {
            this.mCurrentUser = userId;
            int index = this.mTaskHistory.size();
            int i = FINISH_IMMEDIATELY;
            while (i < index) {
                TaskRecord task = (TaskRecord) this.mTaskHistory.get(i);
                if (isCurrentProfileLocked(task.userId)) {
                    this.mTaskHistory.remove(i);
                    this.mTaskHistory.add(task);
                    index--;
                } else {
                    i += FINISH_AFTER_PAUSE;
                }
            }
        }
    }

    void minimalResumeActivityLocked(ActivityRecord r) {
        r.state = ActivityState.RESUMED;
        r.stopped = SCREENSHOT_FORCE_565;
        this.mResumedActivity = r;
        r.task.touchActiveTime();
        this.mService.addRecentTaskLocked(r.task);
        completeResumeLocked(r);
        this.mStackSupervisor.checkReadyForSleepLocked();
        setLaunchTime(r);
    }

    private void startLaunchTraces() {
        if (this.mFullyDrawnStartTime != ACTIVITY_INACTIVE_RESET_TIME) {
            Trace.asyncTraceEnd(64, "drawing", FINISH_IMMEDIATELY);
        }
        Trace.asyncTraceBegin(64, "launching", FINISH_IMMEDIATELY);
        Trace.asyncTraceBegin(64, "drawing", FINISH_IMMEDIATELY);
    }

    private void stopFullyDrawnTraceIfNeeded() {
        if (this.mFullyDrawnStartTime != ACTIVITY_INACTIVE_RESET_TIME && this.mLaunchStartTime == ACTIVITY_INACTIVE_RESET_TIME) {
            Trace.asyncTraceEnd(64, "drawing", FINISH_IMMEDIATELY);
            this.mFullyDrawnStartTime = ACTIVITY_INACTIVE_RESET_TIME;
        }
    }

    void setLaunchTime(ActivityRecord r) {
        long uptimeMillis;
        if (r.displayStartTime == ACTIVITY_INACTIVE_RESET_TIME) {
            uptimeMillis = SystemClock.uptimeMillis();
            r.displayStartTime = uptimeMillis;
            r.fullyDrawnStartTime = uptimeMillis;
            if (this.mLaunchStartTime == ACTIVITY_INACTIVE_RESET_TIME) {
                startLaunchTraces();
                uptimeMillis = r.displayStartTime;
                this.mFullyDrawnStartTime = uptimeMillis;
                this.mLaunchStartTime = uptimeMillis;
            }
        } else if (this.mLaunchStartTime == ACTIVITY_INACTIVE_RESET_TIME) {
            startLaunchTraces();
            uptimeMillis = SystemClock.uptimeMillis();
            this.mFullyDrawnStartTime = uptimeMillis;
            this.mLaunchStartTime = uptimeMillis;
        }
    }

    void clearLaunchTime(ActivityRecord r) {
        if (this.mStackSupervisor.mWaitingActivityLaunched.isEmpty()) {
            r.fullyDrawnStartTime = ACTIVITY_INACTIVE_RESET_TIME;
            r.displayStartTime = ACTIVITY_INACTIVE_RESET_TIME;
            return;
        }
        this.mStackSupervisor.removeTimeoutsForActivityLocked(r);
        this.mStackSupervisor.scheduleIdleTimeoutLocked(r);
    }

    void awakeFromSleepingLocked() {
        for (int taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
            ArrayList<ActivityRecord> activities = ((TaskRecord) this.mTaskHistory.get(taskNdx)).mActivities;
            for (int activityNdx = activities.size() - 1; activityNdx >= 0; activityNdx--) {
                ((ActivityRecord) activities.get(activityNdx)).setSleeping(SCREENSHOT_FORCE_565);
            }
        }
        if (this.mPausingActivity != null) {
            Slog.d("ActivityManager", "awakeFromSleepingLocked: previously pausing activity didn't pause");
            activityPausedLocked(this.mPausingActivity.appToken, SHOW_APP_STARTING_PREVIEW);
        }
    }

    boolean checkReadyForSleepLocked() {
        if (this.mResumedActivity != null) {
            startPausingLocked(SCREENSHOT_FORCE_565, SHOW_APP_STARTING_PREVIEW, SCREENSHOT_FORCE_565, SCREENSHOT_FORCE_565);
            return SHOW_APP_STARTING_PREVIEW;
        } else if (this.mPausingActivity == null) {
            return SCREENSHOT_FORCE_565;
        } else {
            return SHOW_APP_STARTING_PREVIEW;
        }
    }

    void goToSleep() {
        ensureActivitiesVisibleLocked(null, FINISH_IMMEDIATELY);
        for (int taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
            ArrayList<ActivityRecord> activities = ((TaskRecord) this.mTaskHistory.get(taskNdx)).mActivities;
            for (int activityNdx = activities.size() - 1; activityNdx >= 0; activityNdx--) {
                ActivityRecord r = (ActivityRecord) activities.get(activityNdx);
                if (r.state == ActivityState.STOPPING || r.state == ActivityState.STOPPED) {
                    r.setSleeping(SHOW_APP_STARTING_PREVIEW);
                }
            }
        }
    }

    public final Bitmap screenshotActivities(ActivityRecord who) {
        if (who.noDisplay || isHomeStack()) {
            return null;
        }
        int w = this.mService.mThumbnailWidth;
        int h = this.mService.mThumbnailHeight;
        if (w > 0) {
            return this.mWindowManager.screenshotApplications(who.appToken, FINISH_IMMEDIATELY, w, h, SCREENSHOT_FORCE_565);
        }
        Slog.e("ActivityManager", "Invalid thumbnail dimensions: " + w + "x" + h);
        return null;
    }

    final boolean startPausingLocked(boolean userLeaving, boolean uiSleeping, boolean resuming, boolean dontWait) {
        if (this.mPausingActivity != null) {
            Slog.wtf("ActivityManager", "Going to pause when pause is already pending for " + this.mPausingActivity);
            completePauseLocked(SCREENSHOT_FORCE_565);
        }
        ActivityRecord prev = this.mResumedActivity;
        if (prev == null) {
            if (!resuming) {
                Slog.wtf("ActivityManager", "Trying to pause when nothing is resumed");
                this.mStackSupervisor.resumeTopActivitiesLocked();
            }
            return SCREENSHOT_FORCE_565;
        }
        if (this.mActivityContainer.mParentActivity == null) {
            this.mStackSupervisor.pauseChildStacks(prev, userLeaving, uiSleeping, resuming, dontWait);
        }
        this.mResumedActivity = null;
        this.mPausingActivity = prev;
        this.mLastPausedActivity = prev;
        ActivityRecord activityRecord = ((prev.intent.getFlags() & 1073741824) == 0 && (prev.info.flags & DumpState.DUMP_PROVIDERS) == 0) ? null : prev;
        this.mLastNoHistoryActivity = activityRecord;
        prev.state = ActivityState.PAUSING;
        prev.task.touchActiveTime();
        clearLaunchTime(prev);
        ActivityRecord next = this.mStackSupervisor.topRunningActivityLocked();
        if (this.mService.mHasRecents && (next == null || next.noDisplay || next.task != prev.task || uiSleeping)) {
            prev.updateThumbnailLocked(screenshotActivities(prev), null);
        }
        stopFullyDrawnTraceIfNeeded();
        this.mService.updateCpuStats();
        if (prev.app == null || prev.app.thread == null) {
            this.mPausingActivity = null;
            this.mLastPausedActivity = null;
            this.mLastNoHistoryActivity = null;
        } else {
            try {
                EventLog.writeEvent(EventLogTags.AM_PAUSE_ACTIVITY, new Object[]{Integer.valueOf(prev.userId), Integer.valueOf(System.identityHashCode(prev)), prev.shortComponentName});
                this.mService.updateUsageStats(prev, SCREENSHOT_FORCE_565);
                prev.app.thread.schedulePauseActivity(prev.appToken, prev.finishing, userLeaving, prev.configChangeFlags, dontWait);
            } catch (Exception e) {
                Slog.w("ActivityManager", "Exception thrown during pause", e);
                this.mPausingActivity = null;
                this.mLastPausedActivity = null;
                this.mLastNoHistoryActivity = null;
            }
        }
        if (!this.mService.isSleepingOrShuttingDown()) {
            this.mStackSupervisor.acquireLaunchWakelock();
        }
        if (this.mPausingActivity != null) {
            if (!uiSleeping) {
                prev.pauseKeyDispatchingLocked();
            }
            if (dontWait) {
                completePauseLocked(SCREENSHOT_FORCE_565);
                return SCREENSHOT_FORCE_565;
            }
            Message msg = this.mHandler.obtainMessage(PAUSE_TIMEOUT_MSG);
            msg.obj = prev;
            prev.pauseTime = SystemClock.uptimeMillis();
            this.mHandler.sendMessageDelayed(msg, 500);
            return SHOW_APP_STARTING_PREVIEW;
        }
        if (!resuming) {
            this.mStackSupervisor.getFocusedStack().resumeTopActivityLocked(null);
        }
        return SCREENSHOT_FORCE_565;
    }

    final void activityPausedLocked(IBinder token, boolean timeout) {
        ActivityRecord r = isInStackLocked(token);
        if (r != null) {
            this.mHandler.removeMessages(PAUSE_TIMEOUT_MSG, r);
            if (this.mPausingActivity == r) {
                completePauseLocked(SHOW_APP_STARTING_PREVIEW);
                return;
            }
            Object[] objArr = new Object[4];
            objArr[FINISH_IMMEDIATELY] = Integer.valueOf(r.userId);
            objArr[FINISH_AFTER_PAUSE] = Integer.valueOf(System.identityHashCode(r));
            objArr[FINISH_AFTER_VISIBLE] = r.shortComponentName;
            objArr[3] = this.mPausingActivity != null ? this.mPausingActivity.shortComponentName : "(none)";
            EventLog.writeEvent(EventLogTags.AM_FAILED_TO_PAUSE, objArr);
            if (r.finishing && r.state == ActivityState.PAUSING) {
                finishCurrentActivityLocked(r, FINISH_AFTER_VISIBLE, SCREENSHOT_FORCE_565);
            }
        }
    }

    final void activityStoppedLocked(ActivityRecord r, Bundle icicle, PersistableBundle persistentState, CharSequence description) {
        if (r.state != ActivityState.STOPPING) {
            Slog.i("ActivityManager", "Activity reported stop, but no longer stopping: " + r);
            this.mHandler.removeMessages(STOP_TIMEOUT_MSG, r);
            return;
        }
        if (persistentState != null) {
            r.persistentState = persistentState;
            this.mService.notifyTaskPersisterLocked(r.task, SCREENSHOT_FORCE_565);
        }
        if (icicle != null) {
            r.icicle = icicle;
            r.haveState = SHOW_APP_STARTING_PREVIEW;
            r.launchCount = FINISH_IMMEDIATELY;
            r.updateThumbnailLocked(null, description);
        }
        if (!r.stopped) {
            this.mHandler.removeMessages(STOP_TIMEOUT_MSG, r);
            r.stopped = SHOW_APP_STARTING_PREVIEW;
            r.state = ActivityState.STOPPED;
            if (this.mActivityContainer.mActivityDisplay.mVisibleBehindActivity == r) {
                this.mStackSupervisor.requestVisibleBehindLocked(r, SCREENSHOT_FORCE_565);
            }
            if (r.finishing) {
                r.clearOptionsLocked();
            } else if (r.configDestroy) {
                destroyActivityLocked(r, SHOW_APP_STARTING_PREVIEW, "stop-config");
                this.mStackSupervisor.resumeTopActivitiesLocked();
            } else {
                this.mStackSupervisor.updatePreviousProcessLocked(r);
            }
        }
    }

    private void completePauseLocked(boolean resumeNext) {
        ActivityRecord prev = this.mPausingActivity;
        if (prev != null) {
            prev.state = ActivityState.PAUSED;
            if (prev.finishing) {
                prev = finishCurrentActivityLocked(prev, FINISH_AFTER_VISIBLE, SCREENSHOT_FORCE_565);
            } else if (prev.app != null) {
                if (prev.waitingVisible) {
                    prev.waitingVisible = SCREENSHOT_FORCE_565;
                    this.mStackSupervisor.mWaitingVisibleActivities.remove(prev);
                }
                if (prev.configDestroy) {
                    destroyActivityLocked(prev, SHOW_APP_STARTING_PREVIEW, "pause-config");
                } else if (!hasVisibleBehindActivity()) {
                    this.mStackSupervisor.mStoppingActivities.add(prev);
                    if (this.mStackSupervisor.mStoppingActivities.size() > 3 || (prev.frontOfTask && this.mTaskHistory.size() <= FINISH_AFTER_PAUSE)) {
                        this.mStackSupervisor.scheduleIdleLocked();
                    } else {
                        this.mStackSupervisor.checkReadyForSleepLocked();
                    }
                }
            } else {
                prev = null;
            }
            this.mPausingActivity = null;
        }
        if (resumeNext) {
            ActivityStack topStack = this.mStackSupervisor.getFocusedStack();
            if (this.mService.isSleepingOrShuttingDown()) {
                this.mStackSupervisor.checkReadyForSleepLocked();
                ActivityRecord top = topStack.topRunningActivityLocked(null);
                if (top == null || !(prev == null || top == prev)) {
                    this.mStackSupervisor.resumeTopActivitiesLocked(topStack, null, null);
                }
            } else {
                this.mStackSupervisor.resumeTopActivitiesLocked(topStack, prev, null);
            }
        }
        if (prev != null) {
            prev.resumeKeyDispatchingLocked();
            if (prev.app != null && prev.cpuTimeAtResume > ACTIVITY_INACTIVE_RESET_TIME && this.mService.mBatteryStatsService.isOnBattery()) {
                long diff = this.mService.mProcessCpuTracker.getCpuTimeForPid(prev.app.pid) - prev.cpuTimeAtResume;
                if (diff > ACTIVITY_INACTIVE_RESET_TIME) {
                    BatteryStatsImpl bsi = this.mService.mBatteryStatsService.getActiveStatistics();
                    synchronized (bsi) {
                        Proc ps = bsi.getProcessStatsLocked(prev.info.applicationInfo.uid, prev.info.packageName);
                        if (ps != null) {
                            ps.addForegroundTimeLocked(diff);
                        }
                    }
                }
            }
            prev.cpuTimeAtResume = ACTIVITY_INACTIVE_RESET_TIME;
        }
        this.mService.notifyTaskStackChangedLocked();
    }

    private void completeResumeLocked(ActivityRecord next) {
        next.idle = SCREENSHOT_FORCE_565;
        next.results = null;
        next.newIntents = null;
        if (next.isHomeActivity() && next.isNotResolverActivity()) {
            ProcessRecord app = ((ActivityRecord) next.task.mActivities.get(FINISH_IMMEDIATELY)).app;
            if (!(app == null || app == this.mService.mHomeProcess)) {
                this.mService.mHomeProcess = app;
            }
        }
        if (next.nowVisible) {
            this.mStackSupervisor.notifyActivityDrawnForKeyguard();
        }
        this.mStackSupervisor.scheduleIdleTimeoutLocked(next);
        this.mStackSupervisor.reportResumedActivityLocked(next);
        next.resumeKeyDispatchingLocked();
        this.mNoAnimActivities.clear();
        if (next.app != null) {
            next.cpuTimeAtResume = this.mService.mProcessCpuTracker.getCpuTimeForPid(next.app.pid);
        } else {
            next.cpuTimeAtResume = ACTIVITY_INACTIVE_RESET_TIME;
        }
        next.returningOptions = null;
        if (this.mActivityContainer.mActivityDisplay.mVisibleBehindActivity == next) {
            this.mActivityContainer.mActivityDisplay.setVisibleBehindActivity(null);
        }
    }

    private void setVisibile(ActivityRecord r, boolean visible) {
        r.visible = visible;
        this.mWindowManager.setAppVisibility(r.appToken, visible);
        ArrayList<ActivityContainer> containers = r.mChildContainers;
        for (int containerNdx = containers.size() - 1; containerNdx >= 0; containerNdx--) {
            ((ActivityContainer) containers.get(containerNdx)).setVisible(visible);
        }
    }

    ActivityRecord findNextTranslucentActivity(ActivityRecord r) {
        TaskRecord task = r.task;
        if (task == null) {
            return null;
        }
        ActivityStack stack = task.stack;
        if (stack == null) {
            return null;
        }
        int taskNdx = stack.mTaskHistory.indexOf(task);
        int activityNdx = task.mActivities.indexOf(r) + FINISH_AFTER_PAUSE;
        int numStacks = this.mStacks.size();
        for (int stackNdx = this.mStacks.indexOf(stack); stackNdx < numStacks; stackNdx += FINISH_AFTER_PAUSE) {
            ArrayList<TaskRecord> tasks = ((ActivityStack) this.mStacks.get(stackNdx)).mTaskHistory;
            int numTasks = tasks.size();
            for (taskNdx = 
            /* Method generation error in method: com.android.server.am.ActivityStack.findNextTranslucentActivity(com.android.server.am.ActivityRecord):com.android.server.am.ActivityRecord
jadx.core.utils.exceptions.CodegenException: Error generate insn: PHI: (r9_1 'taskNdx' int) = (r9_0 'taskNdx' int), (r9_4 'taskNdx' int) binds: {(r9_4 'taskNdx' int)=B:18:0x005c, (r9_0 'taskNdx' int)=B:4:0x000a} in method: com.android.server.am.ActivityStack.findNextTranslucentActivity(com.android.server.am.ActivityRecord):com.android.server.am.ActivityRecord
	at jadx.core.codegen.InsnGen.makeInsn(InsnGen.java:225)
	at jadx.core.codegen.RegionGen.makeLoop(RegionGen.java:184)
	at jadx.core.codegen.RegionGen.makeRegion(RegionGen.java:61)
	at jadx.core.codegen.RegionGen.makeSimpleRegion(RegionGen.java:87)
	at jadx.core.codegen.RegionGen.makeRegion(RegionGen.java:53)
	at jadx.core.codegen.RegionGen.makeRegionIndent(RegionGen.java:93)
	at jadx.core.codegen.RegionGen.makeLoop(RegionGen.java:190)
	at jadx.core.codegen.RegionGen.makeRegion(RegionGen.java:61)
	at jadx.core.codegen.RegionGen.makeSimpleRegion(RegionGen.java:87)
	at jadx.core.codegen.RegionGen.makeRegion(RegionGen.java:53)
	at jadx.core.codegen.RegionGen.makeSimpleRegion(RegionGen.java:87)
	at jadx.core.codegen.RegionGen.makeRegion(RegionGen.java:53)
	at jadx.core.codegen.RegionGen.makeSimpleRegion(RegionGen.java:87)
	at jadx.core.codegen.RegionGen.makeRegion(RegionGen.java:53)
	at jadx.core.codegen.RegionGen.makeSimpleRegion(RegionGen.java:87)
	at jadx.core.codegen.RegionGen.makeRegion(RegionGen.java:53)
	at jadx.core.codegen.RegionGen.makeSimpleRegion(RegionGen.java:87)
	at jadx.core.codegen.RegionGen.makeRegion(RegionGen.java:53)
	at jadx.core.codegen.MethodGen.addInstructions(MethodGen.java:177)
	at jadx.core.codegen.ClassGen.addMethod(ClassGen.java:324)
	at jadx.core.codegen.ClassGen.addMethods(ClassGen.java:263)
	at jadx.core.codegen.ClassGen.addClassBody(ClassGen.java:226)
	at jadx.core.codegen.ClassGen.addClassCode(ClassGen.java:116)
	at jadx.core.codegen.ClassGen.makeClass(ClassGen.java:81)
	at jadx.core.codegen.CodeGen.visit(CodeGen.java:19)
	at jadx.core.ProcessClass.process(ProcessClass.java:43)
	at jadx.api.JadxDecompiler.processClass(JadxDecompiler.java:281)
	at jadx.api.JavaClass.decompile(JavaClass.java:59)
	at jadx.api.JadxDecompiler$1.run(JadxDecompiler.java:161)
Caused by: jadx.core.utils.exceptions.CodegenException: Unknown instruction: PHI in method: com.android.server.am.ActivityStack.findNextTranslucentActivity(com.android.server.am.ActivityRecord):com.android.server.am.ActivityRecord
	at jadx.core.codegen.InsnGen.makeInsnBody(InsnGen.java:512)
	at jadx.core.codegen.InsnGen.makeInsn(InsnGen.java:219)
	... 28 more
 */

            private boolean isStackVisible() {
                if (!isAttached()) {
                    return SCREENSHOT_FORCE_565;
                }
                if (this.mStackSupervisor.isFrontStack(this)) {
                    return SHOW_APP_STARTING_PREVIEW;
                }
                for (int i = this.mStacks.indexOf(this) + FINISH_AFTER_PAUSE; i < this.mStacks.size(); i += FINISH_AFTER_PAUSE) {
                    ArrayList<TaskRecord> tasks = ((ActivityStack) this.mStacks.get(i)).getAllTasks();
                    for (int taskNdx = FINISH_IMMEDIATELY; taskNdx < tasks.size(); taskNdx += FINISH_AFTER_PAUSE) {
                        TaskRecord task = (TaskRecord) tasks.get(taskNdx);
                        ArrayList<ActivityRecord> activities = task.mActivities;
                        for (int activityNdx = FINISH_IMMEDIATELY; activityNdx < activities.size(); activityNdx += FINISH_AFTER_PAUSE) {
                            ActivityRecord r = (ActivityRecord) activities.get(activityNdx);
                            if (!r.finishing && r.visible && (r.fullscreen || (!isHomeStack() && r.frontOfTask && task.isOverHomeStack()))) {
                                return SCREENSHOT_FORCE_565;
                            }
                        }
                    }
                }
                return SHOW_APP_STARTING_PREVIEW;
            }

            /* JADX WARNING: inconsistent code. */
            /* Code decompiled incorrectly, please refer to instructions dump. */
            final void ensureActivitiesVisibleLocked(com.android.server.am.ActivityRecord r13, int r14) {
                /*
                r12 = this;
                r9 = 0;
                r8 = r12.topRunningActivityLocked(r9);
                if (r8 != 0) goto L_0x0008;
            L_0x0007:
                return;
            L_0x0008:
                r9 = r12.mTranslucentActivityWaiting;
                if (r9 == r8) goto L_0x0023;
            L_0x000c:
                r9 = r12.mUndrawnActivitiesBelowTopTranslucent;
                r9.clear();
                r9 = r12.mTranslucentActivityWaiting;
                if (r9 == 0) goto L_0x001c;
            L_0x0015:
                r9 = 0;
                r12.notifyActivityDrawnLocked(r9);
                r9 = 0;
                r12.mTranslucentActivityWaiting = r9;
            L_0x001c:
                r9 = r12.mHandler;
                r10 = 106; // 0x6a float:1.49E-43 double:5.24E-322;
                r9.removeMessages(r10);
            L_0x0023:
                r0 = 1;
                r9 = r12.isStackVisible();
                if (r9 != 0) goto L_0x0050;
            L_0x002a:
                r3 = 1;
            L_0x002b:
                r9 = r12.mTaskHistory;
                r9 = r9.size();
                r7 = r9 + -1;
            L_0x0033:
                if (r7 < 0) goto L_0x019e;
            L_0x0035:
                r9 = r12.mTaskHistory;
                r6 = r9.get(r7);
                r6 = (com.android.server.am.TaskRecord) r6;
                r1 = r6.mActivities;
                r9 = r1.size();
                r2 = r9 + -1;
            L_0x0045:
                if (r2 < 0) goto L_0x019a;
            L_0x0047:
                r9 = r1.size();
                if (r2 < r9) goto L_0x0052;
            L_0x004d:
                r2 = r2 + -1;
                goto L_0x0045;
            L_0x0050:
                r3 = 0;
                goto L_0x002b;
            L_0x0052:
                r5 = r1.get(r2);
                r5 = (com.android.server.am.ActivityRecord) r5;
                r9 = r5.finishing;
                if (r9 != 0) goto L_0x004d;
            L_0x005c:
                if (r0 == 0) goto L_0x0060;
            L_0x005e:
                if (r5 != r8) goto L_0x004d;
            L_0x0060:
                r0 = 0;
                if (r3 == 0) goto L_0x0067;
            L_0x0063:
                r9 = r5.mLaunchTaskBehind;
                if (r9 == 0) goto L_0x0129;
            L_0x0067:
                if (r5 == r13) goto L_0x006d;
            L_0x0069:
                r9 = 0;
                r12.ensureActivityConfigurationLocked(r5, r9);
            L_0x006d:
                r9 = r5.app;
                if (r9 == 0) goto L_0x0077;
            L_0x0071:
                r9 = r5.app;
                r9 = r9.thread;
                if (r9 != 0) goto L_0x00a8;
            L_0x0077:
                if (r5 == r13) goto L_0x007e;
            L_0x0079:
                r9 = r5.app;
                r5.startFreezingScreenLocked(r9, r14);
            L_0x007e:
                r9 = r5.visible;
                if (r9 == 0) goto L_0x0086;
            L_0x0082:
                r9 = r5.mLaunchTaskBehind;
                if (r9 == 0) goto L_0x008a;
            L_0x0086:
                r9 = 1;
                r12.setVisibile(r5, r9);
            L_0x008a:
                if (r5 == r13) goto L_0x009f;
            L_0x008c:
                r9 = r12.mStackSupervisor;
                r10 = 0;
                r11 = 0;
                r9.startSpecificActivityLocked(r5, r10, r11);
                r9 = r1.size();
                if (r2 < r9) goto L_0x009f;
            L_0x0099:
                r9 = r1.size();
                r2 = r9 + -1;
            L_0x009f:
                r9 = r5.configChangeFlags;
                r14 = r14 | r9;
                r9 = r5.fullscreen;
                if (r9 == 0) goto L_0x0116;
            L_0x00a6:
                r3 = 1;
                goto L_0x004d;
            L_0x00a8:
                r9 = r5.visible;
                if (r9 == 0) goto L_0x00c2;
            L_0x00ac:
                r9 = 0;
                r5.stopFreezingScreenLocked(r9);
                r9 = r5.returningOptions;	 Catch:{ RemoteException -> 0x00c0 }
                if (r9 == 0) goto L_0x009f;
            L_0x00b4:
                r9 = r5.app;	 Catch:{ RemoteException -> 0x00c0 }
                r9 = r9.thread;	 Catch:{ RemoteException -> 0x00c0 }
                r10 = r5.appToken;	 Catch:{ RemoteException -> 0x00c0 }
                r11 = r5.returningOptions;	 Catch:{ RemoteException -> 0x00c0 }
                r9.scheduleOnNewActivityOptions(r10, r11);	 Catch:{ RemoteException -> 0x00c0 }
                goto L_0x009f;
            L_0x00c0:
                r9 = move-exception;
                goto L_0x009f;
            L_0x00c2:
                r9 = 1;
                r5.visible = r9;
                r9 = r5.state;
                r10 = com.android.server.am.ActivityStack.ActivityState.RESUMED;
                if (r9 == r10) goto L_0x009f;
            L_0x00cb:
                if (r5 == r13) goto L_0x009f;
            L_0x00cd:
                r9 = r12.mTranslucentActivityWaiting;	 Catch:{ Exception -> 0x00f6 }
                if (r9 == 0) goto L_0x00db;
            L_0x00d1:
                r9 = r5.returningOptions;	 Catch:{ Exception -> 0x00f6 }
                r5.updateOptionsLocked(r9);	 Catch:{ Exception -> 0x00f6 }
                r9 = r12.mUndrawnActivitiesBelowTopTranslucent;	 Catch:{ Exception -> 0x00f6 }
                r9.add(r5);	 Catch:{ Exception -> 0x00f6 }
            L_0x00db:
                r9 = 1;
                r12.setVisibile(r5, r9);	 Catch:{ Exception -> 0x00f6 }
                r9 = 0;
                r5.sleeping = r9;	 Catch:{ Exception -> 0x00f6 }
                r9 = r5.app;	 Catch:{ Exception -> 0x00f6 }
                r10 = 1;
                r9.pendingUiClean = r10;	 Catch:{ Exception -> 0x00f6 }
                r9 = r5.app;	 Catch:{ Exception -> 0x00f6 }
                r9 = r9.thread;	 Catch:{ Exception -> 0x00f6 }
                r10 = r5.appToken;	 Catch:{ Exception -> 0x00f6 }
                r11 = 1;
                r9.scheduleWindowVisibility(r10, r11);	 Catch:{ Exception -> 0x00f6 }
                r9 = 0;
                r5.stopFreezingScreenLocked(r9);	 Catch:{ Exception -> 0x00f6 }
                goto L_0x009f;
            L_0x00f6:
                r4 = move-exception;
                r9 = "ActivityManager";
                r10 = new java.lang.StringBuilder;
                r10.<init>();
                r11 = "Exception thrown making visibile: ";
                r10 = r10.append(r11);
                r11 = r5.intent;
                r11 = r11.getComponent();
                r10 = r10.append(r11);
                r10 = r10.toString();
                android.util.Slog.w(r9, r10, r4);
                goto L_0x009f;
            L_0x0116:
                r9 = r12.isHomeStack();
                if (r9 != 0) goto L_0x004d;
            L_0x011c:
                r9 = r5.frontOfTask;
                if (r9 == 0) goto L_0x004d;
            L_0x0120:
                r9 = r6.isOverHomeStack();
                if (r9 == 0) goto L_0x004d;
            L_0x0126:
                r3 = 1;
                goto L_0x004d;
            L_0x0129:
                r9 = r5.visible;
                if (r9 == 0) goto L_0x004d;
            L_0x012d:
                r9 = 0;
                r12.setVisibile(r5, r9);	 Catch:{ Exception -> 0x0156 }
                r9 = com.android.server.am.ActivityStack.C01331.$SwitchMap$com$android$server$am$ActivityStack$ActivityState;	 Catch:{ Exception -> 0x0156 }
                r10 = r5.state;	 Catch:{ Exception -> 0x0156 }
                r10 = r10.ordinal();	 Catch:{ Exception -> 0x0156 }
                r9 = r9[r10];	 Catch:{ Exception -> 0x0156 }
                switch(r9) {
                    case 1: goto L_0x0140;
                    case 2: goto L_0x0140;
                    case 3: goto L_0x0177;
                    case 4: goto L_0x0177;
                    case 5: goto L_0x0177;
                    case 6: goto L_0x0177;
                    default: goto L_0x013e;
                };	 Catch:{ Exception -> 0x0156 }
            L_0x013e:
                goto L_0x004d;
            L_0x0140:
                r9 = r5.app;	 Catch:{ Exception -> 0x0156 }
                if (r9 == 0) goto L_0x004d;
            L_0x0144:
                r9 = r5.app;	 Catch:{ Exception -> 0x0156 }
                r9 = r9.thread;	 Catch:{ Exception -> 0x0156 }
                if (r9 == 0) goto L_0x004d;
            L_0x014a:
                r9 = r5.app;	 Catch:{ Exception -> 0x0156 }
                r9 = r9.thread;	 Catch:{ Exception -> 0x0156 }
                r10 = r5.appToken;	 Catch:{ Exception -> 0x0156 }
                r11 = 0;
                r9.scheduleWindowVisibility(r10, r11);	 Catch:{ Exception -> 0x0156 }
                goto L_0x004d;
            L_0x0156:
                r4 = move-exception;
                r9 = "ActivityManager";
                r10 = new java.lang.StringBuilder;
                r10.<init>();
                r11 = "Exception thrown making hidden: ";
                r10 = r10.append(r11);
                r11 = r5.intent;
                r11 = r11.getComponent();
                r10 = r10.append(r11);
                r10 = r10.toString();
                android.util.Slog.w(r9, r10, r4);
                goto L_0x004d;
            L_0x0177:
                r9 = r12.getVisibleBehindActivity();	 Catch:{ Exception -> 0x0156 }
                if (r9 != r5) goto L_0x0182;
            L_0x017d:
                r12.releaseBackgroundResources();	 Catch:{ Exception -> 0x0156 }
                goto L_0x004d;
            L_0x0182:
                r9 = r12.mStackSupervisor;	 Catch:{ Exception -> 0x0156 }
                r9 = r9.mStoppingActivities;	 Catch:{ Exception -> 0x0156 }
                r9 = r9.contains(r5);	 Catch:{ Exception -> 0x0156 }
                if (r9 != 0) goto L_0x0193;
            L_0x018c:
                r9 = r12.mStackSupervisor;	 Catch:{ Exception -> 0x0156 }
                r9 = r9.mStoppingActivities;	 Catch:{ Exception -> 0x0156 }
                r9.add(r5);	 Catch:{ Exception -> 0x0156 }
            L_0x0193:
                r9 = r12.mStackSupervisor;	 Catch:{ Exception -> 0x0156 }
                r9.scheduleIdleLocked();	 Catch:{ Exception -> 0x0156 }
                goto L_0x004d;
            L_0x019a:
                r7 = r7 + -1;
                goto L_0x0033;
            L_0x019e:
                r9 = r12.mTranslucentActivityWaiting;
                if (r9 == 0) goto L_0x0007;
            L_0x01a2:
                r9 = r12.mUndrawnActivitiesBelowTopTranslucent;
                r9 = r9.isEmpty();
                if (r9 == 0) goto L_0x0007;
            L_0x01aa:
                r9 = 0;
                r12.notifyActivityDrawnLocked(r9);
                goto L_0x0007;
                */
                throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.ActivityStack.ensureActivitiesVisibleLocked(com.android.server.am.ActivityRecord, int):void");
            }

            void convertToTranslucent(ActivityRecord r) {
                this.mTranslucentActivityWaiting = r;
                this.mUndrawnActivitiesBelowTopTranslucent.clear();
                this.mHandler.sendEmptyMessageDelayed(TRANSLUCENT_TIMEOUT_MSG, TRANSLUCENT_CONVERSION_TIMEOUT);
            }

            void notifyActivityDrawnLocked(ActivityRecord r) {
                boolean z = SCREENSHOT_FORCE_565;
                this.mActivityContainer.setDrawn();
                if (r == null || (this.mUndrawnActivitiesBelowTopTranslucent.remove(r) && this.mUndrawnActivitiesBelowTopTranslucent.isEmpty())) {
                    ActivityRecord waitingActivity = this.mTranslucentActivityWaiting;
                    this.mTranslucentActivityWaiting = null;
                    this.mUndrawnActivitiesBelowTopTranslucent.clear();
                    this.mHandler.removeMessages(TRANSLUCENT_TIMEOUT_MSG);
                    if (waitingActivity != null) {
                        this.mWindowManager.setWindowOpaque(waitingActivity.appToken, SCREENSHOT_FORCE_565);
                        if (waitingActivity.app != null && waitingActivity.app.thread != null) {
                            try {
                                IApplicationThread iApplicationThread = waitingActivity.app.thread;
                                IBinder iBinder = waitingActivity.appToken;
                                if (r != null) {
                                    z = SHOW_APP_STARTING_PREVIEW;
                                }
                                iApplicationThread.scheduleTranslucentConversionComplete(iBinder, z);
                            } catch (RemoteException e) {
                            }
                        }
                    }
                }
            }

            void cancelInitializingActivities() {
                ActivityRecord topActivity = topRunningActivityLocked(null);
                boolean aboveTop = SHOW_APP_STARTING_PREVIEW;
                for (int taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
                    ArrayList<ActivityRecord> activities = ((TaskRecord) this.mTaskHistory.get(taskNdx)).mActivities;
                    for (int activityNdx = activities.size() - 1; activityNdx >= 0; activityNdx--) {
                        ActivityRecord r = (ActivityRecord) activities.get(activityNdx);
                        if (aboveTop) {
                            if (r == topActivity) {
                                aboveTop = SCREENSHOT_FORCE_565;
                            }
                        } else if (r.state == ActivityState.INITIALIZING && r.mStartingWindowShown) {
                            r.mStartingWindowShown = SCREENSHOT_FORCE_565;
                            this.mWindowManager.removeAppStartingWindow(r.appToken);
                        }
                    }
                }
            }

            final boolean resumeTopActivityLocked(ActivityRecord prev) {
                return resumeTopActivityLocked(prev, null);
            }

            final boolean resumeTopActivityLocked(ActivityRecord prev, Bundle options) {
                if (this.mStackSupervisor.inResumeTopActivity) {
                    return SCREENSHOT_FORCE_565;
                }
                boolean result = SCREENSHOT_FORCE_565;
                try {
                    this.mStackSupervisor.inResumeTopActivity = SHOW_APP_STARTING_PREVIEW;
                    if (this.mService.mLockScreenShown == FINISH_AFTER_PAUSE) {
                        this.mService.mLockScreenShown = FINISH_IMMEDIATELY;
                        this.mService.updateSleepIfNeededLocked();
                    }
                    result = resumeTopActivityInnerLocked(prev, options);
                    return result;
                } finally {
                    this.mStackSupervisor.inResumeTopActivity = SCREENSHOT_FORCE_565;
                }
            }

            final boolean resumeTopActivityInnerLocked(ActivityRecord prev, Bundle options) {
                ActivityRecord lastResumedActivity;
                if (!this.mService.mBooting && !this.mService.mBooted) {
                    return SCREENSHOT_FORCE_565;
                }
                ActivityRecord parent = this.mActivityContainer.mParentActivity;
                if ((parent != null && parent.state != ActivityState.RESUMED) || !this.mActivityContainer.isAttachedLocked()) {
                    return SCREENSHOT_FORCE_565;
                }
                cancelInitializingActivities();
                ActivityRecord next = topRunningActivityLocked(null);
                boolean userLeaving = this.mStackSupervisor.mUserLeaving;
                this.mStackSupervisor.mUserLeaving = SCREENSHOT_FORCE_565;
                TaskRecord prevTask = prev != null ? prev.task : null;
                int returnTaskType;
                if (next == null) {
                    ActivityOptions.abort(options);
                    returnTaskType = (prevTask == null || !prevTask.isOverHomeStack()) ? FINISH_AFTER_PAUSE : prevTask.getTaskToReturnTo();
                    if (isOnHomeDisplay()) {
                        if (this.mStackSupervisor.resumeHomeStackTask(returnTaskType, prev, "noMoreActivities")) {
                            return SHOW_APP_STARTING_PREVIEW;
                        }
                    }
                    return SCREENSHOT_FORCE_565;
                }
                next.delayedResume = SCREENSHOT_FORCE_565;
                if (this.mResumedActivity == next && next.state == ActivityState.RESUMED && this.mStackSupervisor.allResumedActivitiesComplete()) {
                    this.mWindowManager.executeAppTransition();
                    this.mNoAnimActivities.clear();
                    ActivityOptions.abort(options);
                    return SCREENSHOT_FORCE_565;
                }
                TaskRecord nextTask = next.task;
                if (prevTask != null && prevTask.stack == this && prevTask.isOverHomeStack() && prev.finishing && prev.frontOfTask) {
                    if (prevTask == nextTask) {
                        prevTask.setFrontOfTask();
                    } else if (prevTask != topTask()) {
                        ((TaskRecord) this.mTaskHistory.get(this.mTaskHistory.indexOf(prevTask) + FINISH_AFTER_PAUSE)).setTaskToReturnTo(FINISH_AFTER_PAUSE);
                    } else if (!isOnHomeDisplay()) {
                        return SCREENSHOT_FORCE_565;
                    } else {
                        if (!isHomeStack()) {
                            returnTaskType = (prevTask == null || !prevTask.isOverHomeStack()) ? FINISH_AFTER_PAUSE : prevTask.getTaskToReturnTo();
                            return this.mStackSupervisor.resumeHomeStackTask(returnTaskType, prev, "prevFinished");
                        }
                    }
                }
                if (this.mService.isSleepingOrShuttingDown() && this.mLastPausedActivity == next && this.mStackSupervisor.allPausedActivitiesComplete()) {
                    this.mWindowManager.executeAppTransition();
                    this.mNoAnimActivities.clear();
                    ActivityOptions.abort(options);
                    return SCREENSHOT_FORCE_565;
                } else if (this.mService.mStartedUsers.get(next.userId) == null) {
                    Slog.w("ActivityManager", "Skipping resume of top activity " + next + ": user " + next.userId + " is stopped");
                    return SCREENSHOT_FORCE_565;
                } else {
                    this.mStackSupervisor.mStoppingActivities.remove(next);
                    this.mStackSupervisor.mGoingToSleepActivities.remove(next);
                    next.sleeping = SCREENSHOT_FORCE_565;
                    this.mStackSupervisor.mWaitingVisibleActivities.remove(next);
                    if (!this.mStackSupervisor.allPausedActivitiesComplete()) {
                        return SCREENSHOT_FORCE_565;
                    }
                    boolean dontWaitForPause = (next.info.flags & 16384) != 0 ? SHOW_APP_STARTING_PREVIEW : SCREENSHOT_FORCE_565;
                    boolean pausing = this.mStackSupervisor.pauseBackStacks(userLeaving, SHOW_APP_STARTING_PREVIEW, dontWaitForPause);
                    if (this.mResumedActivity != null) {
                        pausing |= startPausingLocked(userLeaving, SCREENSHOT_FORCE_565, SHOW_APP_STARTING_PREVIEW, dontWaitForPause);
                    }
                    if (pausing) {
                        if (!(next.app == null || next.app.thread == null)) {
                            this.mService.updateLruProcessLocked(next.app, SHOW_APP_STARTING_PREVIEW, null);
                        }
                        return SHOW_APP_STARTING_PREVIEW;
                    }
                    if (!(!this.mService.isSleeping() || this.mLastNoHistoryActivity == null || this.mLastNoHistoryActivity.finishing)) {
                        requestFinishActivityLocked(this.mLastNoHistoryActivity.appToken, FINISH_IMMEDIATELY, null, "no-history", SCREENSHOT_FORCE_565);
                        this.mLastNoHistoryActivity = null;
                    }
                    if (!(prev == null || prev == next)) {
                        if (!prev.waitingVisible && next != null && !next.nowVisible) {
                            prev.waitingVisible = SHOW_APP_STARTING_PREVIEW;
                            this.mStackSupervisor.mWaitingVisibleActivities.add(prev);
                        } else if (prev.finishing) {
                            this.mWindowManager.setAppVisibility(prev.appToken, SCREENSHOT_FORCE_565);
                        }
                    }
                    try {
                        AppGlobals.getPackageManager().setPackageStoppedState(next.packageName, SCREENSHOT_FORCE_565, next.userId);
                    } catch (RemoteException e) {
                    } catch (IllegalArgumentException e2) {
                        Slog.w("ActivityManager", "Failed trying to unstop package " + next.packageName + ": " + e2);
                    }
                    boolean anim = SHOW_APP_STARTING_PREVIEW;
                    if (prev != null) {
                        if (prev.finishing) {
                            if (this.mNoAnimActivities.contains(prev)) {
                                anim = SCREENSHOT_FORCE_565;
                                this.mWindowManager.prepareAppTransition(FINISH_IMMEDIATELY, SCREENSHOT_FORCE_565);
                            } else {
                                this.mWindowManager.prepareAppTransition(prev.task == next.task ? 7 : 9, SCREENSHOT_FORCE_565);
                            }
                            this.mWindowManager.setAppWillBeHidden(prev.appToken);
                            this.mWindowManager.setAppVisibility(prev.appToken, SCREENSHOT_FORCE_565);
                        } else if (this.mNoAnimActivities.contains(next)) {
                            anim = SCREENSHOT_FORCE_565;
                            this.mWindowManager.prepareAppTransition(FINISH_IMMEDIATELY, SCREENSHOT_FORCE_565);
                        } else {
                            WindowManagerService windowManagerService = this.mWindowManager;
                            int i = prev.task == next.task ? 6 : next.mLaunchTaskBehind ? 16 : 8;
                            windowManagerService.prepareAppTransition(i, SCREENSHOT_FORCE_565);
                        }
                    } else if (this.mNoAnimActivities.contains(next)) {
                        anim = SCREENSHOT_FORCE_565;
                        this.mWindowManager.prepareAppTransition(FINISH_IMMEDIATELY, SCREENSHOT_FORCE_565);
                    } else {
                        this.mWindowManager.prepareAppTransition(6, SCREENSHOT_FORCE_565);
                    }
                    Bundle resumeAnimOptions = null;
                    if (anim) {
                        ActivityOptions opts = next.getOptionsForTargetActivityLocked();
                        if (opts != null) {
                            resumeAnimOptions = opts.toBundle();
                        }
                        next.applyOptionsLocked();
                    } else {
                        next.clearOptionsLocked();
                    }
                    ActivityStack lastStack = this.mStackSupervisor.getLastStack();
                    if (next.app == null || next.app.thread == null) {
                        if (next.hasBeenLaunched) {
                            this.mWindowManager.setAppStartingWindow(next.appToken, next.packageName, next.theme, this.mService.compatibilityInfoForPackageLocked(next.info.applicationInfo), next.nonLocalizedLabel, next.labelRes, next.icon, next.logo, next.windowFlags, null, SHOW_APP_STARTING_PREVIEW);
                        } else {
                            next.hasBeenLaunched = SHOW_APP_STARTING_PREVIEW;
                        }
                        this.mStackSupervisor.startSpecificActivityLocked(next, SHOW_APP_STARTING_PREVIEW, SHOW_APP_STARTING_PREVIEW);
                    } else {
                        this.mWindowManager.setAppVisibility(next.appToken, SHOW_APP_STARTING_PREVIEW);
                        next.startLaunchTickingLocked();
                        if (lastStack == null) {
                            lastResumedActivity = null;
                        } else {
                            lastResumedActivity = lastStack.mResumedActivity;
                        }
                        ActivityState lastState = next.state;
                        this.mService.updateCpuStats();
                        next.state = ActivityState.RESUMED;
                        this.mResumedActivity = next;
                        next.task.touchActiveTime();
                        this.mService.addRecentTaskLocked(next.task);
                        this.mService.updateLruProcessLocked(next.app, SHOW_APP_STARTING_PREVIEW, null);
                        updateLRUListLocked(next);
                        this.mService.updateOomAdjLocked();
                        boolean notUpdated = SHOW_APP_STARTING_PREVIEW;
                        if (this.mStackSupervisor.isFrontStack(this)) {
                            Configuration config = this.mWindowManager.updateOrientationFromAppTokens(this.mService.mConfiguration, next.mayFreezeScreenLocked(next.app) ? next.appToken : null);
                            if (config != null) {
                                next.frozenBeforeDestroy = SHOW_APP_STARTING_PREVIEW;
                            }
                            notUpdated = !this.mService.updateConfigurationLocked(config, next, SCREENSHOT_FORCE_565, SCREENSHOT_FORCE_565) ? SHOW_APP_STARTING_PREVIEW : SCREENSHOT_FORCE_565;
                        }
                        if (notUpdated) {
                            if (topRunningActivityLocked(null) != next) {
                                this.mStackSupervisor.scheduleResumeTopActivities();
                            }
                            if (!this.mStackSupervisor.reportResumedActivityLocked(next)) {
                                return SCREENSHOT_FORCE_565;
                            }
                            this.mNoAnimActivities.clear();
                            return SHOW_APP_STARTING_PREVIEW;
                        }
                        try {
                            ArrayList<ResultInfo> a = next.results;
                            if (a != null) {
                                int N = a.size();
                                if (!next.finishing && N > 0) {
                                    next.app.thread.scheduleSendResult(next.appToken, a);
                                }
                            }
                            if (next.newIntents != null) {
                                next.app.thread.scheduleNewIntent(next.newIntents, next.appToken);
                            }
                            EventLog.writeEvent(EventLogTags.AM_RESUME_ACTIVITY, new Object[]{Integer.valueOf(next.userId), Integer.valueOf(System.identityHashCode(next)), Integer.valueOf(next.task.taskId), next.shortComponentName});
                            next.sleeping = SCREENSHOT_FORCE_565;
                            this.mService.showAskCompatModeDialogLocked(next);
                            next.app.pendingUiClean = SHOW_APP_STARTING_PREVIEW;
                            next.app.forceProcessStateUpTo(FINISH_AFTER_VISIBLE);
                            next.clearOptionsLocked();
                            next.app.thread.scheduleResumeActivity(next.appToken, next.app.repProcState, this.mService.isNextTransitionForward(), resumeAnimOptions);
                            this.mStackSupervisor.checkReadyForSleepLocked();
                            try {
                                next.visible = SHOW_APP_STARTING_PREVIEW;
                                completeResumeLocked(next);
                                next.stopped = SCREENSHOT_FORCE_565;
                            } catch (Throwable e3) {
                                Slog.w("ActivityManager", "Exception thrown during resume of " + next, e3);
                                requestFinishActivityLocked(next.appToken, FINISH_IMMEDIATELY, null, "resume-exception", SHOW_APP_STARTING_PREVIEW);
                                return SHOW_APP_STARTING_PREVIEW;
                            }
                        } catch (Exception e4) {
                            next.state = lastState;
                            if (lastStack != null) {
                                lastStack.mResumedActivity = lastResumedActivity;
                            }
                            Slog.i("ActivityManager", "Restarting because process died: " + next);
                            if (!next.hasBeenLaunched) {
                                next.hasBeenLaunched = SHOW_APP_STARTING_PREVIEW;
                            } else if (lastStack != null && this.mStackSupervisor.isFrontStack(lastStack)) {
                                this.mWindowManager.setAppStartingWindow(next.appToken, next.packageName, next.theme, this.mService.compatibilityInfoForPackageLocked(next.info.applicationInfo), next.nonLocalizedLabel, next.labelRes, next.icon, next.logo, next.windowFlags, null, SHOW_APP_STARTING_PREVIEW);
                            }
                            this.mStackSupervisor.startSpecificActivityLocked(next, SHOW_APP_STARTING_PREVIEW, SCREENSHOT_FORCE_565);
                            return SHOW_APP_STARTING_PREVIEW;
                        }
                    }
                    return SHOW_APP_STARTING_PREVIEW;
                }
            }

            private void insertTaskAtTop(TaskRecord task) {
                int taskNdx;
                if (isOnHomeDisplay()) {
                    ActivityStack lastStack = this.mStackSupervisor.getLastStack();
                    boolean fromHome = lastStack.isHomeStack();
                    if (!isHomeStack() && (fromHome || topTask() != task)) {
                        if (!fromHome && task.isOverHomeStack()) {
                            taskNdx = this.mTaskHistory.indexOf(task);
                            if (taskNdx + FINISH_AFTER_PAUSE < this.mTaskHistory.size()) {
                                ((TaskRecord) this.mTaskHistory.get(taskNdx + FINISH_AFTER_PAUSE)).setTaskToReturnTo(task.getTaskToReturnTo());
                            }
                        }
                        int i = fromHome ? lastStack.topTask() == null ? FINISH_AFTER_PAUSE : lastStack.topTask().taskType : FINISH_IMMEDIATELY;
                        task.setTaskToReturnTo(i);
                    }
                } else {
                    task.setTaskToReturnTo(FINISH_IMMEDIATELY);
                }
                this.mTaskHistory.remove(task);
                taskNdx = this.mTaskHistory.size();
                if (!isCurrentProfileLocked(task.userId)) {
                    do {
                        taskNdx--;
                        if (taskNdx < 0) {
                            break;
                        }
                    } while (isCurrentProfileLocked(((TaskRecord) this.mTaskHistory.get(taskNdx)).userId));
                    taskNdx += FINISH_AFTER_PAUSE;
                }
                this.mTaskHistory.add(taskNdx, task);
                updateTaskMovement(task, SHOW_APP_STARTING_PREVIEW);
            }

            final void startActivityLocked(ActivityRecord r, boolean newTask, boolean doResume, boolean keepCurTransition, Bundle options) {
                boolean z;
                TaskRecord rTask = r.task;
                int taskId = rTask.taskId;
                if (!r.mLaunchTaskBehind && (taskForIdLocked(taskId) == null || newTask)) {
                    insertTaskAtTop(rTask);
                    this.mWindowManager.moveTaskToTop(taskId);
                }
                TaskRecord task = null;
                if (!newTask) {
                    boolean startIt = SHOW_APP_STARTING_PREVIEW;
                    for (int taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
                        task = (TaskRecord) this.mTaskHistory.get(taskNdx);
                        if (task.getTopActivity() != null) {
                            if (task == r.task) {
                                if (!startIt) {
                                    task.addActivityToTop(r);
                                    r.putInHistory();
                                    WindowManagerService windowManagerService = this.mWindowManager;
                                    int indexOf = task.mActivities.indexOf(r);
                                    IApplicationToken iApplicationToken = r.appToken;
                                    int i = r.task.taskId;
                                    int i2 = this.mStackId;
                                    int i3 = r.info.screenOrientation;
                                    boolean z2 = r.fullscreen;
                                    boolean z3 = (r.info.flags & DumpState.DUMP_PREFERRED_XML) != 0 ? SHOW_APP_STARTING_PREVIEW : SCREENSHOT_FORCE_565;
                                    int i4 = r.userId;
                                    int i5 = r.info.configChanges;
                                    if (task.voiceSession != null) {
                                        z = SHOW_APP_STARTING_PREVIEW;
                                    } else {
                                        z = SCREENSHOT_FORCE_565;
                                    }
                                    windowManagerService.addAppToken(indexOf, iApplicationToken, i, i2, i3, z2, z3, i4, i5, z, r.mLaunchTaskBehind);
                                    ActivityOptions.abort(options);
                                    return;
                                }
                            } else if (task.numFullscreen > 0) {
                                startIt = SCREENSHOT_FORCE_565;
                            }
                        }
                    }
                }
                if (task == r.task && this.mTaskHistory.indexOf(task) != this.mTaskHistory.size() - 1) {
                    this.mStackSupervisor.mUserLeaving = SCREENSHOT_FORCE_565;
                }
                task = r.task;
                task.addActivityToTop(r);
                task.setFrontOfTask();
                r.putInHistory();
                if (!isHomeStack() || numActivities() > 0) {
                    boolean showStartingIcon = newTask;
                    ProcessRecord proc = r.app;
                    if (proc == null) {
                        proc = (ProcessRecord) this.mService.mProcessNames.get(r.processName, r.info.applicationInfo.uid);
                    }
                    if (proc == null || proc.thread == null) {
                        showStartingIcon = SHOW_APP_STARTING_PREVIEW;
                    }
                    if ((r.intent.getFlags() & 65536) != 0) {
                        this.mWindowManager.prepareAppTransition(FINISH_IMMEDIATELY, keepCurTransition);
                        this.mNoAnimActivities.add(r);
                    } else {
                        WindowManagerService windowManagerService2 = this.mWindowManager;
                        int i6 = newTask ? r.mLaunchTaskBehind ? 16 : 8 : 6;
                        windowManagerService2.prepareAppTransition(i6, keepCurTransition);
                        this.mNoAnimActivities.remove(r);
                    }
                    windowManagerService = this.mWindowManager;
                    indexOf = task.mActivities.indexOf(r);
                    iApplicationToken = r.appToken;
                    i = r.task.taskId;
                    i2 = this.mStackId;
                    i3 = r.info.screenOrientation;
                    z2 = r.fullscreen;
                    z3 = (r.info.flags & DumpState.DUMP_PREFERRED_XML) != 0 ? SHOW_APP_STARTING_PREVIEW : SCREENSHOT_FORCE_565;
                    i4 = r.userId;
                    i5 = r.info.configChanges;
                    if (task.voiceSession != null) {
                        z = SHOW_APP_STARTING_PREVIEW;
                    } else {
                        z = SCREENSHOT_FORCE_565;
                    }
                    windowManagerService.addAppToken(indexOf, iApplicationToken, i, i2, i3, z2, z3, i4, i5, z, r.mLaunchTaskBehind);
                    boolean doShow = SHOW_APP_STARTING_PREVIEW;
                    if (newTask) {
                        if ((r.intent.getFlags() & 2097152) != 0) {
                            resetTaskIfNeededLocked(r, r);
                            doShow = topRunningNonDelayedActivityLocked(null) == r ? SHOW_APP_STARTING_PREVIEW : SCREENSHOT_FORCE_565;
                        }
                    } else if (options != null && new ActivityOptions(options).getAnimationType() == 5) {
                        doShow = SCREENSHOT_FORCE_565;
                    }
                    if (r.mLaunchTaskBehind) {
                        this.mWindowManager.setAppVisibility(r.appToken, SHOW_APP_STARTING_PREVIEW);
                        ensureActivitiesVisibleLocked(null, FINISH_IMMEDIATELY);
                    } else if (doShow) {
                        ActivityRecord prev = this.mResumedActivity;
                        if (prev != null) {
                            if (prev.task != r.task) {
                                prev = null;
                            } else if (prev.nowVisible) {
                                prev = null;
                            }
                        }
                        this.mWindowManager.setAppStartingWindow(r.appToken, r.packageName, r.theme, this.mService.compatibilityInfoForPackageLocked(r.info.applicationInfo), r.nonLocalizedLabel, r.labelRes, r.icon, r.logo, r.windowFlags, prev != null ? prev.appToken : null, showStartingIcon);
                        r.mStartingWindowShown = SHOW_APP_STARTING_PREVIEW;
                    }
                } else {
                    this.mWindowManager.addAppToken(task.mActivities.indexOf(r), r.appToken, r.task.taskId, this.mStackId, r.info.screenOrientation, r.fullscreen, (r.info.flags & DumpState.DUMP_PREFERRED_XML) != 0 ? SHOW_APP_STARTING_PREVIEW : SCREENSHOT_FORCE_565, r.userId, r.info.configChanges, task.voiceSession != null ? SHOW_APP_STARTING_PREVIEW : SCREENSHOT_FORCE_565, r.mLaunchTaskBehind);
                    ActivityOptions.abort(options);
                    options = null;
                }
                if (doResume) {
                    this.mStackSupervisor.resumeTopActivitiesLocked(this, r, options);
                }
            }

            final void validateAppTokensLocked() {
                this.mValidateAppTokens.clear();
                this.mValidateAppTokens.ensureCapacity(numActivities());
                int numTasks = this.mTaskHistory.size();
                for (int taskNdx = FINISH_IMMEDIATELY; taskNdx < numTasks; taskNdx += FINISH_AFTER_PAUSE) {
                    TaskRecord task = (TaskRecord) this.mTaskHistory.get(taskNdx);
                    ArrayList<ActivityRecord> activities = task.mActivities;
                    if (!activities.isEmpty()) {
                        TaskGroup group = new TaskGroup();
                        group.taskId = task.taskId;
                        this.mValidateAppTokens.add(group);
                        int numActivities = activities.size();
                        for (int activityNdx = FINISH_IMMEDIATELY; activityNdx < numActivities; activityNdx += FINISH_AFTER_PAUSE) {
                            group.tokens.add(((ActivityRecord) activities.get(activityNdx)).appToken);
                        }
                    }
                }
                this.mWindowManager.validateAppTokens(this.mStackId, this.mValidateAppTokens);
            }

            final ActivityOptions resetTargetTaskIfNeededLocked(TaskRecord task, boolean forceReset) {
                ActivityOptions topOptions = null;
                int replyChainEnd = -1;
                boolean canMoveOptions = SHOW_APP_STARTING_PREVIEW;
                ArrayList<ActivityRecord> activities = task.mActivities;
                int numActivities = activities.size();
                int rootActivityNdx = task.findEffectiveRootIndex();
                for (int i = numActivities - 1; i > rootActivityNdx; i--) {
                    ActivityRecord target = (ActivityRecord) activities.get(i);
                    if (target.frontOfTask) {
                        break;
                    }
                    int flags = target.info.flags;
                    boolean finishOnTaskLaunch = (flags & FINISH_AFTER_VISIBLE) != 0 ? SHOW_APP_STARTING_PREVIEW : SCREENSHOT_FORCE_565;
                    boolean allowTaskReparenting = (flags & 64) != 0 ? SHOW_APP_STARTING_PREVIEW : SCREENSHOT_FORCE_565;
                    boolean clearWhenTaskReset = (target.intent.getFlags() & 524288) != 0 ? SHOW_APP_STARTING_PREVIEW : SCREENSHOT_FORCE_565;
                    if (finishOnTaskLaunch || clearWhenTaskReset || target.resultTo == null) {
                        boolean noOptions;
                        int srcPos;
                        ActivityRecord p;
                        if (!finishOnTaskLaunch && !clearWhenTaskReset && allowTaskReparenting && target.taskAffinity != null && !target.taskAffinity.equals(task.affinity)) {
                            TaskRecord targetTask;
                            int start;
                            ActivityRecord bottom = (this.mTaskHistory.isEmpty() || ((TaskRecord) this.mTaskHistory.get(FINISH_IMMEDIATELY)).mActivities.isEmpty()) ? null : (ActivityRecord) ((TaskRecord) this.mTaskHistory.get(FINISH_IMMEDIATELY)).mActivities.get(FINISH_IMMEDIATELY);
                            if (bottom == null || target.taskAffinity == null || !target.taskAffinity.equals(bottom.task.affinity)) {
                                targetTask = createTaskRecord(this.mStackSupervisor.getNextTaskId(), target.info, null, null, null, SCREENSHOT_FORCE_565);
                                targetTask.affinityIntent = target.intent;
                            } else {
                                targetTask = bottom.task;
                            }
                            int targetTaskId = targetTask.taskId;
                            this.mWindowManager.setAppGroupId(target.appToken, targetTaskId);
                            noOptions = canMoveOptions;
                            if (replyChainEnd < 0) {
                                start = i;
                            } else {
                                start = replyChainEnd;
                            }
                            for (srcPos = start; srcPos >= i; srcPos--) {
                                p = (ActivityRecord) activities.get(srcPos);
                                if (!p.finishing) {
                                    canMoveOptions = SCREENSHOT_FORCE_565;
                                    if (noOptions && topOptions == null) {
                                        topOptions = p.takeOptionsLocked();
                                        if (topOptions != null) {
                                            noOptions = SCREENSHOT_FORCE_565;
                                        }
                                    }
                                    p.setTask(targetTask, null);
                                    targetTask.addActivityAtBottom(p);
                                    this.mWindowManager.setAppGroupId(p.appToken, targetTaskId);
                                }
                            }
                            this.mWindowManager.moveTaskToBottom(targetTaskId);
                            replyChainEnd = -1;
                        } else if (forceReset || finishOnTaskLaunch || clearWhenTaskReset) {
                            int end;
                            if (clearWhenTaskReset) {
                                end = numActivities - 1;
                            } else if (replyChainEnd < 0) {
                                end = i;
                            } else {
                                end = replyChainEnd;
                            }
                            noOptions = canMoveOptions;
                            srcPos = i;
                            while (srcPos <= end) {
                                p = (ActivityRecord) activities.get(srcPos);
                                if (!p.finishing) {
                                    canMoveOptions = SCREENSHOT_FORCE_565;
                                    if (noOptions && topOptions == null) {
                                        topOptions = p.takeOptionsLocked();
                                        if (topOptions != null) {
                                            noOptions = SCREENSHOT_FORCE_565;
                                        }
                                    }
                                    if (finishActivityLocked(p, FINISH_IMMEDIATELY, null, "reset", SCREENSHOT_FORCE_565)) {
                                        end--;
                                        srcPos--;
                                    }
                                }
                                srcPos += FINISH_AFTER_PAUSE;
                            }
                            replyChainEnd = -1;
                        } else {
                            replyChainEnd = -1;
                        }
                    } else if (replyChainEnd < 0) {
                        replyChainEnd = i;
                    }
                }
                return topOptions;
            }

            private int resetAffinityTaskIfNeededLocked(TaskRecord affinityTask, TaskRecord task, boolean topTaskIsHigher, boolean forceReset, int taskInsertionPoint) {
                int replyChainEnd = -1;
                int taskId = task.taskId;
                String taskAffinity = task.affinity;
                ArrayList<ActivityRecord> activities = affinityTask.mActivities;
                int numActivities = activities.size();
                int rootActivityNdx = affinityTask.findEffectiveRootIndex();
                for (int i = numActivities - 1; i > rootActivityNdx; i--) {
                    ActivityRecord target = (ActivityRecord) activities.get(i);
                    if (target.frontOfTask) {
                        break;
                    }
                    int flags = target.info.flags;
                    boolean finishOnTaskLaunch = (flags & FINISH_AFTER_VISIBLE) != 0 ? SHOW_APP_STARTING_PREVIEW : SCREENSHOT_FORCE_565;
                    boolean allowTaskReparenting = (flags & 64) != 0 ? SHOW_APP_STARTING_PREVIEW : SCREENSHOT_FORCE_565;
                    if (target.resultTo != null) {
                        if (replyChainEnd < 0) {
                            replyChainEnd = i;
                        }
                    } else if (topTaskIsHigher && allowTaskReparenting && taskAffinity != null) {
                        if (taskAffinity.equals(target.taskAffinity)) {
                            int start;
                            int srcPos;
                            ActivityRecord p;
                            if (forceReset || finishOnTaskLaunch) {
                                if (replyChainEnd >= 0) {
                                    start = replyChainEnd;
                                } else {
                                    start = i;
                                }
                                for (srcPos = start; srcPos >= i; srcPos--) {
                                    p = (ActivityRecord) activities.get(srcPos);
                                    if (!p.finishing) {
                                        finishActivityLocked(p, FINISH_IMMEDIATELY, null, "reset", SCREENSHOT_FORCE_565);
                                    }
                                }
                            } else {
                                if (taskInsertionPoint < 0) {
                                    taskInsertionPoint = task.mActivities.size();
                                }
                                if (replyChainEnd >= 0) {
                                    start = replyChainEnd;
                                } else {
                                    start = i;
                                }
                                for (srcPos = start; srcPos >= i; srcPos--) {
                                    p = (ActivityRecord) activities.get(srcPos);
                                    p.setTask(task, null);
                                    task.addActivityAtIndex(taskInsertionPoint, p);
                                    this.mWindowManager.setAppGroupId(p.appToken, taskId);
                                }
                                this.mWindowManager.moveTaskToTop(taskId);
                                if (target.info.launchMode == FINISH_AFTER_PAUSE) {
                                    ArrayList<ActivityRecord> taskActivities = task.mActivities;
                                    int targetNdx = taskActivities.indexOf(target);
                                    if (targetNdx > 0) {
                                        p = (ActivityRecord) taskActivities.get(targetNdx - 1);
                                        if (p.intent.getComponent().equals(target.intent.getComponent())) {
                                            finishActivityLocked(p, FINISH_IMMEDIATELY, null, "replace", SCREENSHOT_FORCE_565);
                                        }
                                    }
                                }
                            }
                            replyChainEnd = -1;
                        }
                    }
                }
                return taskInsertionPoint;
            }

            /* JADX WARNING: inconsistent code. */
            /* Code decompiled incorrectly, please refer to instructions dump. */
            final com.android.server.am.ActivityRecord resetTaskIfNeededLocked(com.android.server.am.ActivityRecord r11, com.android.server.am.ActivityRecord r12) {
                /*
                r10 = this;
                r0 = r12.info;
                r0 = r0.flags;
                r0 = r0 & 4;
                if (r0 == 0) goto L_0x002a;
            L_0x0008:
                r4 = 1;
            L_0x0009:
                r2 = r11.task;
                r3 = 0;
                r9 = 0;
                r5 = -1;
                r0 = r10.mTaskHistory;
                r0 = r0.size();
                r6 = r0 + -1;
            L_0x0016:
                if (r6 < 0) goto L_0x0032;
            L_0x0018:
                r0 = r10.mTaskHistory;
                r1 = r0.get(r6);
                r1 = (com.android.server.am.TaskRecord) r1;
                if (r1 != r2) goto L_0x002c;
            L_0x0022:
                r9 = r10.resetTargetTaskIfNeededLocked(r2, r4);
                r3 = 1;
            L_0x0027:
                r6 = r6 + -1;
                goto L_0x0016;
            L_0x002a:
                r4 = 0;
                goto L_0x0009;
            L_0x002c:
                r0 = r10;
                r5 = r0.resetAffinityTaskIfNeededLocked(r1, r2, r3, r4, r5);
                goto L_0x0027;
            L_0x0032:
                r0 = r10.mTaskHistory;
                r7 = r0.indexOf(r2);
            L_0x0038:
                r0 = r10.mTaskHistory;
                r8 = r7 + -1;
                r0 = r0.get(r7);
                r0 = (com.android.server.am.TaskRecord) r0;
                r11 = r0.getTopActivity();
                if (r11 != 0) goto L_0x004a;
            L_0x0048:
                if (r8 >= 0) goto L_0x0056;
            L_0x004a:
                if (r9 == 0) goto L_0x0051;
            L_0x004c:
                if (r11 == 0) goto L_0x0052;
            L_0x004e:
                r11.updateOptionsLocked(r9);
            L_0x0051:
                return r11;
            L_0x0052:
                r9.abort();
                goto L_0x0051;
            L_0x0056:
                r7 = r8;
                goto L_0x0038;
                */
                throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.ActivityStack.resetTaskIfNeededLocked(com.android.server.am.ActivityRecord, com.android.server.am.ActivityRecord):com.android.server.am.ActivityRecord");
            }

            void sendActivityResultLocked(int callingUid, ActivityRecord r, String resultWho, int requestCode, int resultCode, Intent data) {
                if (callingUid > 0) {
                    this.mService.grantUriPermissionFromIntentLocked(callingUid, r.packageName, data, r.getUriPermissionsLocked(), r.userId);
                }
                if (!(this.mResumedActivity != r || r.app == null || r.app.thread == null)) {
                    try {
                        ArrayList<ResultInfo> list = new ArrayList();
                        list.add(new ResultInfo(resultWho, requestCode, resultCode, data));
                        r.app.thread.scheduleSendResult(r.appToken, list);
                        return;
                    } catch (Exception e) {
                        Slog.w("ActivityManager", "Exception thrown sending result to " + r, e);
                    }
                }
                r.addResultLocked(null, resultWho, requestCode, resultCode, data);
            }

            private void adjustFocusedActivityLocked(ActivityRecord r, String reason) {
                if (this.mStackSupervisor.isFrontStack(this) && this.mService.mFocusedActivity == r) {
                    if (topRunningActivityLocked(null) != r) {
                        TaskRecord task = r.task;
                        if (r.frontOfTask && task == topTask() && task.isOverHomeStack()) {
                            this.mStackSupervisor.moveHomeStackTaskToTop(task.getTaskToReturnTo(), reason + " adjustFocus");
                        }
                    }
                    ActivityRecord top = this.mStackSupervisor.topRunningActivityLocked();
                    if (top != null) {
                        this.mService.setFocusedActivityLocked(top, reason + " adjustTopFocus");
                    }
                }
            }

            final void stopActivityLocked(ActivityRecord r) {
                if (!(((r.intent.getFlags() & 1073741824) == 0 && (r.info.flags & DumpState.DUMP_PROVIDERS) == 0) || r.finishing || this.mService.isSleeping())) {
                    requestFinishActivityLocked(r.appToken, FINISH_IMMEDIATELY, null, "no-history", SCREENSHOT_FORCE_565);
                }
                if (r.app != null && r.app.thread != null) {
                    adjustFocusedActivityLocked(r, "stopActivity");
                    r.resumeKeyDispatchingLocked();
                    try {
                        r.stopped = SCREENSHOT_FORCE_565;
                        r.state = ActivityState.STOPPING;
                        if (!r.visible) {
                            this.mWindowManager.setAppVisibility(r.appToken, SCREENSHOT_FORCE_565);
                        }
                        r.app.thread.scheduleStopActivity(r.appToken, r.visible, r.configChangeFlags);
                        if (this.mService.isSleepingOrShuttingDown()) {
                            r.setSleeping(SHOW_APP_STARTING_PREVIEW);
                        }
                        this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(STOP_TIMEOUT_MSG, r), 10000);
                    } catch (Exception e) {
                        Slog.w("ActivityManager", "Exception thrown during pause", e);
                        r.stopped = SHOW_APP_STARTING_PREVIEW;
                        r.state = ActivityState.STOPPED;
                        if (r.configDestroy) {
                            destroyActivityLocked(r, SHOW_APP_STARTING_PREVIEW, "stop-except");
                        }
                    }
                }
            }

            final boolean requestFinishActivityLocked(IBinder token, int resultCode, Intent resultData, String reason, boolean oomAdj) {
                ActivityRecord r = isInStackLocked(token);
                if (r == null) {
                    return SCREENSHOT_FORCE_565;
                }
                finishActivityLocked(r, resultCode, resultData, reason, oomAdj);
                return SHOW_APP_STARTING_PREVIEW;
            }

            final void finishSubActivityLocked(ActivityRecord self, String resultWho, int requestCode) {
                for (int taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
                    ArrayList<ActivityRecord> activities = ((TaskRecord) this.mTaskHistory.get(taskNdx)).mActivities;
                    for (int activityNdx = activities.size() - 1; activityNdx >= 0; activityNdx--) {
                        ActivityRecord r = (ActivityRecord) activities.get(activityNdx);
                        if (r.resultTo == self && r.requestCode == requestCode && ((r.resultWho == null && resultWho == null) || (r.resultWho != null && r.resultWho.equals(resultWho)))) {
                            finishActivityLocked(r, FINISH_IMMEDIATELY, null, "request-sub", SCREENSHOT_FORCE_565);
                        }
                    }
                }
                this.mService.updateOomAdjLocked();
            }

            final void finishTopRunningActivityLocked(ProcessRecord app) {
                ActivityRecord r = topRunningActivityLocked(null);
                if (r != null && r.app == app) {
                    Slog.w("ActivityManager", "  Force finishing activity 1 " + r.intent.getComponent().flattenToShortString());
                    int taskNdx = this.mTaskHistory.indexOf(r.task);
                    int activityNdx = r.task.mActivities.indexOf(r);
                    finishActivityLocked(r, FINISH_IMMEDIATELY, null, "crashed", SCREENSHOT_FORCE_565);
                    activityNdx--;
                    if (activityNdx < 0) {
                        do {
                            taskNdx--;
                            if (taskNdx < 0) {
                                break;
                            }
                            activityNdx = ((TaskRecord) this.mTaskHistory.get(taskNdx)).mActivities.size() - 1;
                        } while (activityNdx < 0);
                    }
                    if (activityNdx >= 0) {
                        r = (ActivityRecord) ((TaskRecord) this.mTaskHistory.get(taskNdx)).mActivities.get(activityNdx);
                        if (r.state != ActivityState.RESUMED && r.state != ActivityState.PAUSING && r.state != ActivityState.PAUSED) {
                            return;
                        }
                        if (!r.isHomeActivity() || this.mService.mHomeProcess != r.app) {
                            Slog.w("ActivityManager", "  Force finishing activity 2 " + r.intent.getComponent().flattenToShortString());
                            finishActivityLocked(r, FINISH_IMMEDIATELY, null, "crashed", SCREENSHOT_FORCE_565);
                        }
                    }
                }
            }

            final void finishVoiceTask(IVoiceInteractionSession session) {
                IBinder sessionBinder = session.asBinder();
                boolean didOne = SCREENSHOT_FORCE_565;
                for (int taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
                    TaskRecord tr = (TaskRecord) this.mTaskHistory.get(taskNdx);
                    if (tr.voiceSession != null && tr.voiceSession.asBinder() == sessionBinder) {
                        for (int activityNdx = tr.mActivities.size() - 1; activityNdx >= 0; activityNdx--) {
                            ActivityRecord r = (ActivityRecord) tr.mActivities.get(activityNdx);
                            if (!r.finishing) {
                                finishActivityLocked(r, FINISH_IMMEDIATELY, null, "finish-voice", SCREENSHOT_FORCE_565);
                                didOne = SHOW_APP_STARTING_PREVIEW;
                            }
                        }
                    }
                }
                if (didOne) {
                    this.mService.updateOomAdjLocked();
                }
            }

            final boolean finishActivityAffinityLocked(ActivityRecord r) {
                ArrayList<ActivityRecord> activities = r.task.mActivities;
                for (int index = activities.indexOf(r); index >= 0; index--) {
                    ActivityRecord cur = (ActivityRecord) activities.get(index);
                    if (!Objects.equals(cur.taskAffinity, r.taskAffinity)) {
                        break;
                    }
                    finishActivityLocked(cur, FINISH_IMMEDIATELY, null, "request-affinity", SHOW_APP_STARTING_PREVIEW);
                }
                return SHOW_APP_STARTING_PREVIEW;
            }

            final void finishActivityResultsLocked(ActivityRecord r, int resultCode, Intent resultData) {
                ActivityRecord resultTo = r.resultTo;
                if (resultTo != null) {
                    if (!(resultTo.userId == r.userId || resultData == null)) {
                        resultData.setContentUserHint(r.userId);
                    }
                    if (r.info.applicationInfo.uid > 0) {
                        this.mService.grantUriPermissionFromIntentLocked(r.info.applicationInfo.uid, resultTo.packageName, resultData, resultTo.getUriPermissionsLocked(), resultTo.userId);
                    }
                    resultTo.addResultLocked(r, r.resultWho, r.requestCode, resultCode, resultData);
                    r.resultTo = null;
                }
                r.results = null;
                r.pendingResults = null;
                r.newIntents = null;
                r.icicle = null;
            }

            final boolean finishActivityLocked(ActivityRecord r, int resultCode, Intent resultData, String reason, boolean oomAdj) {
                if (r.finishing) {
                    Slog.w("ActivityManager", "Duplicate finish request for " + r);
                    return SCREENSHOT_FORCE_565;
                }
                r.makeFinishing();
                TaskRecord task = r.task;
                EventLog.writeEvent(EventLogTags.AM_FINISH_ACTIVITY, new Object[]{Integer.valueOf(r.userId), Integer.valueOf(System.identityHashCode(r)), Integer.valueOf(task.taskId), r.shortComponentName, reason});
                ArrayList<ActivityRecord> activities = task.mActivities;
                int index = activities.indexOf(r);
                if (index < activities.size() - 1) {
                    task.setFrontOfTask();
                    if ((r.intent.getFlags() & 524288) != 0) {
                        ((ActivityRecord) activities.get(index + FINISH_AFTER_PAUSE)).intent.addFlags(524288);
                    }
                }
                r.pauseKeyDispatchingLocked();
                adjustFocusedActivityLocked(r, "finishActivity");
                finishActivityResultsLocked(r, resultCode, resultData);
                if (this.mResumedActivity == r) {
                    boolean endTask = index <= 0 ? SHOW_APP_STARTING_PREVIEW : SCREENSHOT_FORCE_565;
                    this.mWindowManager.prepareAppTransition(endTask ? 9 : 7, SCREENSHOT_FORCE_565);
                    this.mWindowManager.setAppVisibility(r.appToken, SCREENSHOT_FORCE_565);
                    if (this.mPausingActivity == null) {
                        startPausingLocked(SCREENSHOT_FORCE_565, SCREENSHOT_FORCE_565, SCREENSHOT_FORCE_565, SCREENSHOT_FORCE_565);
                    }
                    if (endTask) {
                        this.mStackSupervisor.endLockTaskModeIfTaskEnding(task);
                    }
                } else if (r.state != ActivityState.PAUSING) {
                    return finishCurrentActivityLocked(r, FINISH_AFTER_PAUSE, oomAdj) == null ? SHOW_APP_STARTING_PREVIEW : SCREENSHOT_FORCE_565;
                }
                return SCREENSHOT_FORCE_565;
            }

            final ActivityRecord finishCurrentActivityLocked(ActivityRecord r, int mode, boolean oomAdj) {
                if (mode == FINISH_AFTER_VISIBLE && r.nowVisible) {
                    if (!this.mStackSupervisor.mStoppingActivities.contains(r)) {
                        this.mStackSupervisor.mStoppingActivities.add(r);
                        if (this.mStackSupervisor.mStoppingActivities.size() > 3 || (r.frontOfTask && this.mTaskHistory.size() <= FINISH_AFTER_PAUSE)) {
                            this.mStackSupervisor.scheduleIdleLocked();
                        } else {
                            this.mStackSupervisor.checkReadyForSleepLocked();
                        }
                    }
                    r.state = ActivityState.STOPPING;
                    if (!oomAdj) {
                        return r;
                    }
                    this.mService.updateOomAdjLocked();
                    return r;
                }
                this.mStackSupervisor.mStoppingActivities.remove(r);
                this.mStackSupervisor.mGoingToSleepActivities.remove(r);
                this.mStackSupervisor.mWaitingVisibleActivities.remove(r);
                if (this.mResumedActivity == r) {
                    this.mResumedActivity = null;
                }
                ActivityState prevState = r.state;
                r.state = ActivityState.FINISHING;
                if (mode == 0 || prevState == ActivityState.STOPPED || prevState == ActivityState.INITIALIZING) {
                    r.makeFinishing();
                    boolean activityRemoved = destroyActivityLocked(r, SHOW_APP_STARTING_PREVIEW, "finish-imm");
                    if (activityRemoved) {
                        this.mStackSupervisor.resumeTopActivitiesLocked();
                    }
                    if (activityRemoved) {
                        return null;
                    }
                    return r;
                }
                this.mStackSupervisor.mFinishingActivities.add(r);
                r.resumeKeyDispatchingLocked();
                this.mStackSupervisor.getFocusedStack().resumeTopActivityLocked(null);
                return r;
            }

            void finishAllActivitiesLocked(boolean immediately) {
                boolean noActivitiesInStack = SHOW_APP_STARTING_PREVIEW;
                for (int taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
                    ArrayList<ActivityRecord> activities = ((TaskRecord) this.mTaskHistory.get(taskNdx)).mActivities;
                    for (int activityNdx = activities.size() - 1; activityNdx >= 0; activityNdx--) {
                        ActivityRecord r = (ActivityRecord) activities.get(activityNdx);
                        noActivitiesInStack = SCREENSHOT_FORCE_565;
                        if (!r.finishing || immediately) {
                            Slog.d("ActivityManager", "finishAllActivitiesLocked: finishing " + r + " immediately");
                            finishCurrentActivityLocked(r, FINISH_IMMEDIATELY, SCREENSHOT_FORCE_565);
                        }
                    }
                }
                if (noActivitiesInStack) {
                    this.mActivityContainer.onTaskListEmptyLocked();
                }
            }

            final boolean shouldUpRecreateTaskLocked(ActivityRecord srec, String destAffinity) {
                if (srec == null || srec.task.affinity == null || !srec.task.affinity.equals(destAffinity)) {
                    return SHOW_APP_STARTING_PREVIEW;
                }
                if (srec.frontOfTask && srec.task != null && srec.task.getBaseIntent() != null && srec.task.getBaseIntent().isDocument()) {
                    if (srec.task.getTaskToReturnTo() != 0) {
                        return SHOW_APP_STARTING_PREVIEW;
                    }
                    int taskIdx = this.mTaskHistory.indexOf(srec.task);
                    if (taskIdx <= 0) {
                        Slog.w("ActivityManager", "shouldUpRecreateTask: task not in history for " + srec);
                        return SCREENSHOT_FORCE_565;
                    } else if (taskIdx == 0) {
                        return SHOW_APP_STARTING_PREVIEW;
                    } else {
                        if (!srec.task.affinity.equals(((TaskRecord) this.mTaskHistory.get(taskIdx)).affinity)) {
                            return SHOW_APP_STARTING_PREVIEW;
                        }
                    }
                }
                return SCREENSHOT_FORCE_565;
            }

            final boolean navigateUpToLocked(IBinder token, Intent destIntent, int resultCode, Intent resultData) {
                ActivityRecord srec = ActivityRecord.forToken(token);
                TaskRecord task = srec.task;
                ArrayList<ActivityRecord> activities = task.mActivities;
                int start = activities.indexOf(srec);
                if (!this.mTaskHistory.contains(task) || start < 0) {
                    return SCREENSHOT_FORCE_565;
                }
                int i;
                int finishTo = start - 1;
                ActivityRecord parent = finishTo < 0 ? null : (ActivityRecord) activities.get(finishTo);
                boolean foundParentInTask = SCREENSHOT_FORCE_565;
                ComponentName dest = destIntent.getComponent();
                if (start > 0 && dest != null) {
                    for (i = finishTo; i >= 0; i--) {
                        ActivityRecord r = (ActivityRecord) activities.get(i);
                        if (r.info.packageName.equals(dest.getPackageName()) && r.info.name.equals(dest.getClassName())) {
                            finishTo = i;
                            parent = r;
                            foundParentInTask = SHOW_APP_STARTING_PREVIEW;
                            break;
                        }
                    }
                }
                IActivityController controller = this.mService.mController;
                if (controller != null) {
                    ActivityRecord next = topRunningActivityLocked(srec.appToken, FINISH_IMMEDIATELY);
                    if (next != null) {
                        boolean resumeOK = SHOW_APP_STARTING_PREVIEW;
                        try {
                            resumeOK = controller.activityResuming(next.packageName);
                        } catch (RemoteException e) {
                            this.mService.mController = null;
                            Watchdog.getInstance().setActivityController(null);
                        }
                        if (!resumeOK) {
                            return SCREENSHOT_FORCE_565;
                        }
                    }
                }
                long origId = Binder.clearCallingIdentity();
                for (i = start; i > finishTo; i--) {
                    requestFinishActivityLocked(((ActivityRecord) activities.get(i)).appToken, resultCode, resultData, "navigate-up", SHOW_APP_STARTING_PREVIEW);
                    resultCode = FINISH_IMMEDIATELY;
                    resultData = null;
                }
                if (parent != null && foundParentInTask) {
                    int parentLaunchMode = parent.info.launchMode;
                    int destIntentFlags = destIntent.getFlags();
                    if (parentLaunchMode == 3 || parentLaunchMode == FINISH_AFTER_VISIBLE || parentLaunchMode == FINISH_AFTER_PAUSE || (67108864 & destIntentFlags) != 0) {
                        parent.deliverNewIntentLocked(srec.info.applicationInfo.uid, destIntent, srec.packageName);
                    } else {
                        try {
                            foundParentInTask = this.mStackSupervisor.startActivityLocked(srec.app.thread, destIntent, null, AppGlobals.getPackageManager().getActivityInfo(destIntent.getComponent(), FINISH_IMMEDIATELY, srec.userId), null, null, parent.appToken, null, FINISH_IMMEDIATELY, -1, parent.launchedFromUid, parent.launchedFromPackage, -1, parent.launchedFromUid, FINISH_IMMEDIATELY, null, SHOW_APP_STARTING_PREVIEW, null, null, null) == 0 ? SHOW_APP_STARTING_PREVIEW : SCREENSHOT_FORCE_565;
                        } catch (RemoteException e2) {
                            foundParentInTask = SCREENSHOT_FORCE_565;
                        }
                        requestFinishActivityLocked(parent.appToken, resultCode, resultData, "navigate-up", SHOW_APP_STARTING_PREVIEW);
                    }
                }
                Binder.restoreCallingIdentity(origId);
                return foundParentInTask;
            }

            final void cleanUpActivityLocked(ActivityRecord r, boolean cleanServices, boolean setState) {
                if (this.mResumedActivity == r) {
                    this.mResumedActivity = null;
                }
                if (this.mPausingActivity == r) {
                    this.mPausingActivity = null;
                }
                this.mService.clearFocusedActivity(r);
                r.configDestroy = SCREENSHOT_FORCE_565;
                r.frozenBeforeDestroy = SCREENSHOT_FORCE_565;
                if (setState) {
                    r.state = ActivityState.DESTROYED;
                    r.app = null;
                }
                this.mStackSupervisor.mFinishingActivities.remove(r);
                this.mStackSupervisor.mWaitingVisibleActivities.remove(r);
                if (r.finishing && r.pendingResults != null) {
                    Iterator i$ = r.pendingResults.iterator();
                    while (i$.hasNext()) {
                        PendingIntentRecord rec = (PendingIntentRecord) ((WeakReference) i$.next()).get();
                        if (rec != null) {
                            this.mService.cancelIntentSenderLocked(rec, SCREENSHOT_FORCE_565);
                        }
                    }
                    r.pendingResults = null;
                }
                if (cleanServices) {
                    cleanUpActivityServicesLocked(r);
                }
                removeTimeoutsForActivityLocked(r);
                if (getVisibleBehindActivity() == r) {
                    this.mStackSupervisor.requestVisibleBehindLocked(r, SCREENSHOT_FORCE_565);
                }
            }

            private void removeTimeoutsForActivityLocked(ActivityRecord r) {
                this.mStackSupervisor.removeTimeoutsForActivityLocked(r);
                this.mHandler.removeMessages(PAUSE_TIMEOUT_MSG, r);
                this.mHandler.removeMessages(STOP_TIMEOUT_MSG, r);
                this.mHandler.removeMessages(DESTROY_TIMEOUT_MSG, r);
                r.finishLaunchTickingLocked();
            }

            private void removeActivityFromHistoryLocked(ActivityRecord r, String reason) {
                this.mStackSupervisor.removeChildActivityContainers(r);
                finishActivityResultsLocked(r, FINISH_IMMEDIATELY, null);
                r.makeFinishing();
                r.takeFromHistory();
                removeTimeoutsForActivityLocked(r);
                r.state = ActivityState.DESTROYED;
                r.app = null;
                this.mWindowManager.removeAppToken(r.appToken);
                TaskRecord task = r.task;
                if (task != null && task.removeActivity(r)) {
                    if (this.mStackSupervisor.isFrontStack(this) && task == topTask() && task.isOverHomeStack()) {
                        this.mStackSupervisor.moveHomeStackTaskToTop(task.getTaskToReturnTo(), reason);
                    }
                    removeTask(task, reason);
                }
                cleanUpActivityServicesLocked(r);
                r.removeUriPermissionsLocked();
            }

            final void cleanUpActivityServicesLocked(ActivityRecord r) {
                if (r.connections != null) {
                    Iterator<ConnectionRecord> it = r.connections.iterator();
                    while (it.hasNext()) {
                        this.mService.mServices.removeConnectionLocked((ConnectionRecord) it.next(), null, r);
                    }
                    r.connections = null;
                }
            }

            final void scheduleDestroyActivities(ProcessRecord owner, String reason) {
                Message msg = this.mHandler.obtainMessage(DESTROY_ACTIVITIES_MSG);
                msg.obj = new ScheduleDestroyArgs(owner, reason);
                this.mHandler.sendMessage(msg);
            }

            final void destroyActivitiesLocked(ProcessRecord owner, String reason) {
                boolean lastIsOpaque = SCREENSHOT_FORCE_565;
                boolean activityRemoved = SCREENSHOT_FORCE_565;
                for (int taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
                    ArrayList<ActivityRecord> activities = ((TaskRecord) this.mTaskHistory.get(taskNdx)).mActivities;
                    for (int activityNdx = activities.size() - 1; activityNdx >= 0; activityNdx--) {
                        ActivityRecord r = (ActivityRecord) activities.get(activityNdx);
                        if (!r.finishing) {
                            if (r.fullscreen) {
                                lastIsOpaque = SHOW_APP_STARTING_PREVIEW;
                            }
                            if ((owner == null || r.app == owner) && lastIsOpaque && r.isDestroyable() && destroyActivityLocked(r, SHOW_APP_STARTING_PREVIEW, reason)) {
                                activityRemoved = SHOW_APP_STARTING_PREVIEW;
                            }
                        }
                    }
                }
                if (activityRemoved) {
                    this.mStackSupervisor.resumeTopActivitiesLocked();
                }
            }

            final boolean safelyDestroyActivityLocked(ActivityRecord r, String reason) {
                if (r.isDestroyable()) {
                    return destroyActivityLocked(r, SHOW_APP_STARTING_PREVIEW, reason);
                }
                return SCREENSHOT_FORCE_565;
            }

            final int releaseSomeActivitiesLocked(ProcessRecord app, ArraySet<TaskRecord> tasks, String reason) {
                int maxTasks = tasks.size() / 4;
                if (maxTasks < FINISH_AFTER_PAUSE) {
                    maxTasks = FINISH_AFTER_PAUSE;
                }
                int numReleased = FINISH_IMMEDIATELY;
                int taskNdx = FINISH_IMMEDIATELY;
                while (taskNdx < this.mTaskHistory.size() && maxTasks > 0) {
                    TaskRecord task = (TaskRecord) this.mTaskHistory.get(taskNdx);
                    if (tasks.contains(task)) {
                        int curNum = FINISH_IMMEDIATELY;
                        ArrayList<ActivityRecord> activities = task.mActivities;
                        int actNdx = FINISH_IMMEDIATELY;
                        while (actNdx < activities.size()) {
                            ActivityRecord activity = (ActivityRecord) activities.get(actNdx);
                            if (activity.app == app && activity.isDestroyable()) {
                                destroyActivityLocked(activity, SHOW_APP_STARTING_PREVIEW, reason);
                                if (activities.get(actNdx) != activity) {
                                    actNdx--;
                                }
                                curNum += FINISH_AFTER_PAUSE;
                            }
                            actNdx += FINISH_AFTER_PAUSE;
                        }
                        if (curNum > 0) {
                            numReleased += curNum;
                            maxTasks--;
                            if (this.mTaskHistory.get(taskNdx) != task) {
                                taskNdx--;
                            }
                        }
                    }
                    taskNdx += FINISH_AFTER_PAUSE;
                }
                return numReleased;
            }

            final boolean destroyActivityLocked(ActivityRecord r, boolean removeFromApp, String reason) {
                boolean hadApp = SHOW_APP_STARTING_PREVIEW;
                EventLog.writeEvent(EventLogTags.AM_DESTROY_ACTIVITY, new Object[]{Integer.valueOf(r.userId), Integer.valueOf(System.identityHashCode(r)), Integer.valueOf(r.task.taskId), r.shortComponentName, reason});
                boolean removedFromHistory = SCREENSHOT_FORCE_565;
                cleanUpActivityLocked(r, SCREENSHOT_FORCE_565, SCREENSHOT_FORCE_565);
                if (r.app == null) {
                    hadApp = SCREENSHOT_FORCE_565;
                }
                if (hadApp) {
                    if (removeFromApp) {
                        r.app.activities.remove(r);
                        if (this.mService.mHeavyWeightProcess == r.app && r.app.activities.size() <= 0) {
                            this.mService.mHeavyWeightProcess = null;
                            this.mService.mHandler.sendEmptyMessage(25);
                        }
                        if (r.app.activities.isEmpty()) {
                            this.mService.mServices.updateServiceConnectionActivitiesLocked(r.app);
                            this.mService.updateLruProcessLocked(r.app, SCREENSHOT_FORCE_565, null);
                            this.mService.updateOomAdjLocked();
                        }
                    }
                    boolean skipDestroy = SCREENSHOT_FORCE_565;
                    try {
                        r.app.thread.scheduleDestroyActivity(r.appToken, r.finishing, r.configChangeFlags);
                    } catch (Exception e) {
                        if (r.finishing) {
                            removeActivityFromHistoryLocked(r, reason + " exceptionInScheduleDestroy");
                            removedFromHistory = SHOW_APP_STARTING_PREVIEW;
                            skipDestroy = SHOW_APP_STARTING_PREVIEW;
                        }
                    }
                    r.nowVisible = SCREENSHOT_FORCE_565;
                    if (!r.finishing || skipDestroy) {
                        r.state = ActivityState.DESTROYED;
                        r.app = null;
                    } else {
                        r.state = ActivityState.DESTROYING;
                        this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(DESTROY_TIMEOUT_MSG, r), 10000);
                    }
                } else if (r.finishing) {
                    removeActivityFromHistoryLocked(r, reason + " hadNoApp");
                    removedFromHistory = SHOW_APP_STARTING_PREVIEW;
                } else {
                    r.state = ActivityState.DESTROYED;
                    r.app = null;
                }
                r.configChangeFlags = FINISH_IMMEDIATELY;
                if (!this.mLRUActivities.remove(r) && hadApp) {
                    Slog.w("ActivityManager", "Activity " + r + " being finished, but not in LRU list");
                }
                return removedFromHistory;
            }

            final void activityDestroyedLocked(IBinder token, String reason) {
                long origId = Binder.clearCallingIdentity();
                try {
                    ActivityRecord r = ActivityRecord.forToken(token);
                    if (r != null) {
                        this.mHandler.removeMessages(DESTROY_TIMEOUT_MSG, r);
                    }
                    if (isInStackLocked(token) != null && r.state == ActivityState.DESTROYING) {
                        cleanUpActivityLocked(r, SHOW_APP_STARTING_PREVIEW, SCREENSHOT_FORCE_565);
                        removeActivityFromHistoryLocked(r, reason);
                    }
                    this.mStackSupervisor.resumeTopActivitiesLocked();
                } finally {
                    Binder.restoreCallingIdentity(origId);
                }
            }

            void releaseBackgroundResources() {
                if (hasVisibleBehindActivity() && !this.mHandler.hasMessages(RELEASE_BACKGROUND_RESOURCES_TIMEOUT_MSG)) {
                    ActivityRecord r = getVisibleBehindActivity();
                    if (r != topRunningActivityLocked(null)) {
                        if (r == null || r.app == null || r.app.thread == null) {
                            Slog.e("ActivityManager", "releaseBackgroundResources: activity " + r + " no longer running");
                            backgroundResourcesReleased();
                            return;
                        }
                        try {
                            r.app.thread.scheduleCancelVisibleBehind(r.appToken);
                        } catch (RemoteException e) {
                        }
                        this.mHandler.sendEmptyMessageDelayed(RELEASE_BACKGROUND_RESOURCES_TIMEOUT_MSG, 500);
                    }
                }
            }

            final void backgroundResourcesReleased() {
                this.mHandler.removeMessages(RELEASE_BACKGROUND_RESOURCES_TIMEOUT_MSG);
                ActivityRecord r = getVisibleBehindActivity();
                if (r != null) {
                    this.mStackSupervisor.mStoppingActivities.add(r);
                    setVisibleBehindActivity(null);
                    this.mStackSupervisor.scheduleIdleTimeoutLocked(null);
                }
                this.mStackSupervisor.resumeTopActivitiesLocked();
            }

            boolean hasVisibleBehindActivity() {
                return (isAttached() && this.mActivityContainer.mActivityDisplay.hasVisibleBehindActivity()) ? SHOW_APP_STARTING_PREVIEW : SCREENSHOT_FORCE_565;
            }

            void setVisibleBehindActivity(ActivityRecord r) {
                if (isAttached()) {
                    this.mActivityContainer.mActivityDisplay.setVisibleBehindActivity(r);
                }
            }

            ActivityRecord getVisibleBehindActivity() {
                return isAttached() ? this.mActivityContainer.mActivityDisplay.mVisibleBehindActivity : null;
            }

            private void removeHistoryRecordsForAppLocked(ArrayList<ActivityRecord> list, ProcessRecord app, String listName) {
                int i = list.size();
                while (i > 0) {
                    i--;
                    ActivityRecord r = (ActivityRecord) list.get(i);
                    if (r.app == app) {
                        list.remove(i);
                        removeTimeoutsForActivityLocked(r);
                    }
                }
            }

            boolean removeHistoryRecordsForAppLocked(ProcessRecord app) {
                removeHistoryRecordsForAppLocked(this.mLRUActivities, app, "mLRUActivities");
                removeHistoryRecordsForAppLocked(this.mStackSupervisor.mStoppingActivities, app, "mStoppingActivities");
                removeHistoryRecordsForAppLocked(this.mStackSupervisor.mGoingToSleepActivities, app, "mGoingToSleepActivities");
                removeHistoryRecordsForAppLocked(this.mStackSupervisor.mWaitingVisibleActivities, app, "mWaitingVisibleActivities");
                removeHistoryRecordsForAppLocked(this.mStackSupervisor.mFinishingActivities, app, "mFinishingActivities");
                boolean hasVisibleActivities = SCREENSHOT_FORCE_565;
                int i = numActivities();
                for (int taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
                    ArrayList<ActivityRecord> activities = ((TaskRecord) this.mTaskHistory.get(taskNdx)).mActivities;
                    for (int activityNdx = activities.size() - 1; activityNdx >= 0; activityNdx--) {
                        ActivityRecord r = (ActivityRecord) activities.get(activityNdx);
                        i--;
                        if (r.app == app) {
                            boolean remove;
                            if ((!r.haveState && !r.stateNotNeeded) || r.finishing) {
                                remove = SHOW_APP_STARTING_PREVIEW;
                            } else if (r.launchCount <= FINISH_AFTER_VISIBLE || r.lastLaunchTime <= SystemClock.uptimeMillis() - 60000) {
                                remove = SCREENSHOT_FORCE_565;
                            } else {
                                remove = SHOW_APP_STARTING_PREVIEW;
                            }
                            if (remove) {
                                if (!r.finishing) {
                                    Slog.w("ActivityManager", "Force removing " + r + ": app died, no saved state");
                                    EventLog.writeEvent(EventLogTags.AM_FINISH_ACTIVITY, new Object[]{Integer.valueOf(r.userId), Integer.valueOf(System.identityHashCode(r)), Integer.valueOf(r.task.taskId), r.shortComponentName, "proc died without state saved"});
                                    if (r.state == ActivityState.RESUMED) {
                                        this.mService.updateUsageStats(r, SCREENSHOT_FORCE_565);
                                    }
                                }
                                removeActivityFromHistoryLocked(r, "appDied");
                            } else {
                                if (r.visible) {
                                    hasVisibleActivities = SHOW_APP_STARTING_PREVIEW;
                                }
                                r.app = null;
                                r.nowVisible = SCREENSHOT_FORCE_565;
                                if (!r.haveState) {
                                    r.icicle = null;
                                }
                            }
                            cleanUpActivityLocked(r, SHOW_APP_STARTING_PREVIEW, SHOW_APP_STARTING_PREVIEW);
                        }
                    }
                }
                return hasVisibleActivities;
            }

            final void updateTransitLocked(int transit, Bundle options) {
                if (options != null) {
                    ActivityRecord r = topRunningActivityLocked(null);
                    if (r == null || r.state == ActivityState.RESUMED) {
                        ActivityOptions.abort(options);
                    } else {
                        r.updateOptionsLocked(options);
                    }
                }
                this.mWindowManager.prepareAppTransition(transit, SCREENSHOT_FORCE_565);
            }

            void updateTaskMovement(TaskRecord task, boolean toFront) {
                if (task.isPersistable) {
                    task.mLastTimeMoved = System.currentTimeMillis();
                    if (!toFront) {
                        task.mLastTimeMoved *= -1;
                    }
                }
            }

            void moveHomeStackTaskToTop(int homeStackTaskType) {
                int top = this.mTaskHistory.size() - 1;
                for (int taskNdx = top; taskNdx >= 0; taskNdx--) {
                    TaskRecord task = (TaskRecord) this.mTaskHistory.get(taskNdx);
                    if (task.taskType == homeStackTaskType) {
                        this.mTaskHistory.remove(taskNdx);
                        this.mTaskHistory.add(top, task);
                        updateTaskMovement(task, SHOW_APP_STARTING_PREVIEW);
                        this.mWindowManager.moveTaskToTop(task.taskId);
                        return;
                    }
                }
            }

            final void moveTaskToFrontLocked(TaskRecord tr, ActivityRecord source, Bundle options, String reason) {
                int numTasks = this.mTaskHistory.size();
                int index = this.mTaskHistory.indexOf(tr);
                if (numTasks != 0 && index >= 0) {
                    insertTaskAtTop(tr);
                    moveToFront(reason);
                    if (source == null || (source.intent.getFlags() & 65536) == 0) {
                        updateTransitLocked(10, options);
                    } else {
                        this.mWindowManager.prepareAppTransition(FINISH_IMMEDIATELY, SCREENSHOT_FORCE_565);
                        ActivityRecord r = topRunningActivityLocked(null);
                        if (r != null) {
                            this.mNoAnimActivities.add(r);
                        }
                        ActivityOptions.abort(options);
                    }
                    this.mStackSupervisor.resumeTopActivitiesLocked();
                    Object[] objArr = new Object[FINISH_AFTER_VISIBLE];
                    objArr[FINISH_IMMEDIATELY] = Integer.valueOf(tr.userId);
                    objArr[FINISH_AFTER_PAUSE] = Integer.valueOf(tr.taskId);
                    EventLog.writeEvent(EventLogTags.AM_TASK_TO_FRONT, objArr);
                } else if (source == null || (source.intent.getFlags() & 65536) == 0) {
                    updateTransitLocked(10, options);
                } else {
                    ActivityOptions.abort(options);
                }
            }

            final boolean moveTaskToBackLocked(int taskId) {
                TaskRecord tr = taskForIdLocked(taskId);
                if (tr == null) {
                    Slog.i("ActivityManager", "moveTaskToBack: bad taskId=" + taskId);
                    return SCREENSHOT_FORCE_565;
                }
                Slog.i("ActivityManager", "moveTaskToBack: " + tr);
                this.mStackSupervisor.endLockTaskModeIfTaskEnding(tr);
                if (this.mStackSupervisor.isFrontStack(this) && this.mService.mController != null) {
                    ActivityRecord next = topRunningActivityLocked(null, taskId);
                    if (next == null) {
                        next = topRunningActivityLocked(null, FINISH_IMMEDIATELY);
                    }
                    if (next != null) {
                        boolean moveOK = SHOW_APP_STARTING_PREVIEW;
                        try {
                            moveOK = this.mService.mController.activityResuming(next.packageName);
                        } catch (RemoteException e) {
                            this.mService.mController = null;
                            Watchdog.getInstance().setActivityController(null);
                        }
                        if (!moveOK) {
                            return SCREENSHOT_FORCE_565;
                        }
                    }
                }
                this.mTaskHistory.remove(tr);
                this.mTaskHistory.add(FINISH_IMMEDIATELY, tr);
                updateTaskMovement(tr, SCREENSHOT_FORCE_565);
                int numTasks = this.mTaskHistory.size();
                for (int taskNdx = numTasks - 1; taskNdx >= FINISH_AFTER_PAUSE; taskNdx--) {
                    TaskRecord task = (TaskRecord) this.mTaskHistory.get(taskNdx);
                    if (task.isOverHomeStack()) {
                        break;
                    }
                    if (taskNdx == FINISH_AFTER_PAUSE) {
                        task.setTaskToReturnTo(FINISH_AFTER_PAUSE);
                    }
                }
                this.mWindowManager.prepareAppTransition(11, SCREENSHOT_FORCE_565);
                this.mWindowManager.moveTaskToBottom(taskId);
                if (this.mResumedActivity != null) {
                    task = this.mResumedActivity.task;
                } else {
                    task = null;
                }
                if (!(task == tr && tr.isOverHomeStack()) && (numTasks > FINISH_AFTER_PAUSE || !isOnHomeDisplay())) {
                    this.mStackSupervisor.resumeTopActivitiesLocked();
                    return SHOW_APP_STARTING_PREVIEW;
                } else if (!this.mService.mBooting && !this.mService.mBooted) {
                    return SCREENSHOT_FORCE_565;
                } else {
                    int taskToReturnTo = tr.getTaskToReturnTo();
                    tr.setTaskToReturnTo(FINISH_IMMEDIATELY);
                    return this.mStackSupervisor.resumeHomeStackTask(taskToReturnTo, null, "moveTaskToBack");
                }
            }

            static final void logStartActivity(int tag, ActivityRecord r, TaskRecord task) {
                Uri data = r.intent.getData();
                String strData = data != null ? data.toSafeString() : null;
                EventLog.writeEvent(tag, new Object[]{Integer.valueOf(r.userId), Integer.valueOf(System.identityHashCode(r)), Integer.valueOf(task.taskId), r.shortComponentName, r.intent.getAction(), r.intent.getType(), strData, Integer.valueOf(r.intent.getFlags())});
            }

            final boolean ensureActivityConfigurationLocked(ActivityRecord r, int globalChanges) {
                if (this.mConfigWillChange) {
                    return SHOW_APP_STARTING_PREVIEW;
                }
                Configuration newConfig = this.mService.mConfiguration;
                if (r.configuration == newConfig && !r.forceNewConfig) {
                    return SHOW_APP_STARTING_PREVIEW;
                }
                if (r.finishing) {
                    r.stopFreezingScreenLocked(SCREENSHOT_FORCE_565);
                    return SHOW_APP_STARTING_PREVIEW;
                }
                Configuration oldConfig = r.configuration;
                r.configuration = newConfig;
                int changes = oldConfig.diff(newConfig);
                if (changes == 0 && !r.forceNewConfig) {
                    return SHOW_APP_STARTING_PREVIEW;
                }
                if (r.app == null || r.app.thread == null) {
                    r.stopFreezingScreenLocked(SCREENSHOT_FORCE_565);
                    r.forceNewConfig = SCREENSHOT_FORCE_565;
                    return SHOW_APP_STARTING_PREVIEW;
                } else if (((r.info.getRealConfigChanged() ^ -1) & changes) != 0 || r.forceNewConfig) {
                    r.configChangeFlags |= changes;
                    r.startFreezingScreenLocked(r.app, globalChanges);
                    r.forceNewConfig = SCREENSHOT_FORCE_565;
                    if (r.app == null || r.app.thread == null) {
                        destroyActivityLocked(r, SHOW_APP_STARTING_PREVIEW, "config");
                    } else if (r.state == ActivityState.PAUSING) {
                        r.configDestroy = SHOW_APP_STARTING_PREVIEW;
                        return SHOW_APP_STARTING_PREVIEW;
                    } else if (r.state == ActivityState.RESUMED) {
                        relaunchActivityLocked(r, r.configChangeFlags, SHOW_APP_STARTING_PREVIEW);
                        r.configChangeFlags = FINISH_IMMEDIATELY;
                    } else {
                        relaunchActivityLocked(r, r.configChangeFlags, SCREENSHOT_FORCE_565);
                        r.configChangeFlags = FINISH_IMMEDIATELY;
                    }
                    return SCREENSHOT_FORCE_565;
                } else {
                    if (!(r.app == null || r.app.thread == null)) {
                        try {
                            r.app.thread.scheduleActivityConfigurationChanged(r.appToken);
                        } catch (RemoteException e) {
                        }
                    }
                    r.stopFreezingScreenLocked(SCREENSHOT_FORCE_565);
                    return SHOW_APP_STARTING_PREVIEW;
                }
            }

            private boolean relaunchActivityLocked(ActivityRecord r, int changes, boolean andResume) {
                boolean z = SCREENSHOT_FORCE_565;
                List<ResultInfo> results = null;
                List<ReferrerIntent> newIntents = null;
                if (andResume) {
                    results = r.results;
                    newIntents = r.newIntents;
                }
                EventLog.writeEvent(andResume ? EventLogTags.AM_RELAUNCH_RESUME_ACTIVITY : EventLogTags.AM_RELAUNCH_ACTIVITY, new Object[]{Integer.valueOf(r.userId), Integer.valueOf(System.identityHashCode(r)), Integer.valueOf(r.task.taskId), r.shortComponentName});
                r.startFreezingScreenLocked(r.app, FINISH_IMMEDIATELY);
                this.mStackSupervisor.removeChildActivityContainers(r);
                try {
                    r.forceNewConfig = SCREENSHOT_FORCE_565;
                    IApplicationThread iApplicationThread = r.app.thread;
                    IBinder iBinder = r.appToken;
                    if (!andResume) {
                        z = SHOW_APP_STARTING_PREVIEW;
                    }
                    iApplicationThread.scheduleRelaunchActivity(iBinder, results, newIntents, changes, z, new Configuration(this.mService.mConfiguration));
                } catch (RemoteException e) {
                }
                if (andResume) {
                    r.results = null;
                    r.newIntents = null;
                    r.state = ActivityState.RESUMED;
                } else {
                    this.mHandler.removeMessages(PAUSE_TIMEOUT_MSG, r);
                    r.state = ActivityState.PAUSED;
                }
                return SHOW_APP_STARTING_PREVIEW;
            }

            boolean willActivityBeVisibleLocked(IBinder token) {
                ActivityRecord r;
                for (int taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
                    ArrayList<ActivityRecord> activities = ((TaskRecord) this.mTaskHistory.get(taskNdx)).mActivities;
                    for (int activityNdx = activities.size() - 1; activityNdx >= 0; activityNdx--) {
                        r = (ActivityRecord) activities.get(activityNdx);
                        if (r.appToken == token) {
                            return SHOW_APP_STARTING_PREVIEW;
                        }
                        if (r.fullscreen && !r.finishing) {
                            return SCREENSHOT_FORCE_565;
                        }
                    }
                }
                r = ActivityRecord.forToken(token);
                if (r == null) {
                    return SCREENSHOT_FORCE_565;
                }
                if (r.finishing) {
                    Slog.e("ActivityManager", "willActivityBeVisibleLocked: Returning false, would have returned true for r=" + r);
                }
                return !r.finishing ? FINISH_AFTER_PAUSE : SCREENSHOT_FORCE_565;
            }

            void closeSystemDialogsLocked() {
                for (int taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
                    ArrayList<ActivityRecord> activities = ((TaskRecord) this.mTaskHistory.get(taskNdx)).mActivities;
                    for (int activityNdx = activities.size() - 1; activityNdx >= 0; activityNdx--) {
                        ActivityRecord r = (ActivityRecord) activities.get(activityNdx);
                        if ((r.info.flags & DumpState.DUMP_VERIFIERS) != 0) {
                            finishActivityLocked(r, FINISH_IMMEDIATELY, null, "close-sys", SHOW_APP_STARTING_PREVIEW);
                        }
                    }
                }
            }

            boolean forceStopPackageLocked(String name, boolean doit, boolean evenPersistent, int userId) {
                boolean didSomething = SCREENSHOT_FORCE_565;
                TaskRecord lastTask = null;
                ComponentName homeActivity = null;
                for (int taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
                    ArrayList<ActivityRecord> activities = ((TaskRecord) this.mTaskHistory.get(taskNdx)).mActivities;
                    int numActivities = activities.size();
                    int activityNdx = FINISH_IMMEDIATELY;
                    while (activityNdx < numActivities) {
                        ActivityRecord r = (ActivityRecord) activities.get(activityNdx);
                        boolean samePackage = (r.packageName.equals(name) || (name == null && r.userId == userId)) ? SHOW_APP_STARTING_PREVIEW : SCREENSHOT_FORCE_565;
                        if ((userId == -1 || r.userId == userId) && ((samePackage || r.task == lastTask) && (r.app == null || evenPersistent || !r.app.persistent))) {
                            if (doit) {
                                if (r.isHomeActivity()) {
                                    if (homeActivity == null || !homeActivity.equals(r.realActivity)) {
                                        homeActivity = r.realActivity;
                                    } else {
                                        Slog.i("ActivityManager", "Skip force-stop again " + r);
                                    }
                                }
                                didSomething = SHOW_APP_STARTING_PREVIEW;
                                Slog.i("ActivityManager", "  Force finishing activity 3 " + r);
                                if (samePackage) {
                                    if (r.app != null) {
                                        r.app.removed = SHOW_APP_STARTING_PREVIEW;
                                    }
                                    r.app = null;
                                }
                                lastTask = r.task;
                                if (finishActivityLocked(r, FINISH_IMMEDIATELY, null, "force-stop", SHOW_APP_STARTING_PREVIEW)) {
                                    numActivities--;
                                    activityNdx--;
                                }
                            } else if (!r.finishing) {
                                return SHOW_APP_STARTING_PREVIEW;
                            }
                        }
                        activityNdx += FINISH_AFTER_PAUSE;
                    }
                }
                return didSomething;
            }

            void getTasksLocked(List<RunningTaskInfo> list, int callingUid, boolean allowed) {
                for (int taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
                    TaskRecord task = (TaskRecord) this.mTaskHistory.get(taskNdx);
                    ActivityRecord r = null;
                    ActivityRecord top = null;
                    int numActivities = FINISH_IMMEDIATELY;
                    int numRunning = FINISH_IMMEDIATELY;
                    ArrayList<ActivityRecord> activities = task.mActivities;
                    if (!activities.isEmpty() && (allowed || task.isHomeTask() || task.effectiveUid == callingUid)) {
                        for (int activityNdx = activities.size() - 1; activityNdx >= 0; activityNdx--) {
                            r = (ActivityRecord) activities.get(activityNdx);
                            if (top == null || top.state == ActivityState.INITIALIZING) {
                                top = r;
                                numRunning = FINISH_IMMEDIATELY;
                                numActivities = FINISH_IMMEDIATELY;
                            }
                            numActivities += FINISH_AFTER_PAUSE;
                            if (!(r.app == null || r.app.thread == null)) {
                                numRunning += FINISH_AFTER_PAUSE;
                            }
                        }
                        RunningTaskInfo ci = new RunningTaskInfo();
                        ci.id = task.taskId;
                        ci.baseActivity = r.intent.getComponent();
                        ci.topActivity = top.intent.getComponent();
                        ci.lastActiveTime = task.lastActiveTime;
                        if (top.task != null) {
                            ci.description = top.task.lastDescription;
                        }
                        ci.numActivities = numActivities;
                        ci.numRunning = numRunning;
                        list.add(ci);
                    }
                }
            }

            public void unhandledBackLocked() {
                int top = this.mTaskHistory.size() - 1;
                if (top >= 0) {
                    ArrayList<ActivityRecord> activities = ((TaskRecord) this.mTaskHistory.get(top)).mActivities;
                    int activityTop = activities.size() - 1;
                    if (activityTop > 0) {
                        finishActivityLocked((ActivityRecord) activities.get(activityTop), FINISH_IMMEDIATELY, null, "unhandled-back", SHOW_APP_STARTING_PREVIEW);
                    }
                }
            }

            boolean handleAppDiedLocked(ProcessRecord app) {
                if (this.mPausingActivity != null && this.mPausingActivity.app == app) {
                    this.mPausingActivity = null;
                }
                if (this.mLastPausedActivity != null && this.mLastPausedActivity.app == app) {
                    this.mLastPausedActivity = null;
                    this.mLastNoHistoryActivity = null;
                }
                return removeHistoryRecordsForAppLocked(app);
            }

            void handleAppCrashLocked(ProcessRecord app) {
                for (int taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
                    ArrayList<ActivityRecord> activities = ((TaskRecord) this.mTaskHistory.get(taskNdx)).mActivities;
                    for (int activityNdx = activities.size() - 1; activityNdx >= 0; activityNdx--) {
                        ActivityRecord r = (ActivityRecord) activities.get(activityNdx);
                        if (r.app == app) {
                            Slog.w("ActivityManager", "  Force finishing activity 4 " + r.intent.getComponent().flattenToShortString());
                            r.app = null;
                            finishCurrentActivityLocked(r, FINISH_IMMEDIATELY, SCREENSHOT_FORCE_565);
                        }
                    }
                }
            }

            boolean dumpActivitiesLocked(FileDescriptor fd, PrintWriter pw, boolean dumpAll, boolean dumpClient, String dumpPackage, boolean needSep, String header) {
                boolean printed = SCREENSHOT_FORCE_565;
                for (int taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
                    TaskRecord task = (TaskRecord) this.mTaskHistory.get(taskNdx);
                    printed |= ActivityStackSupervisor.dumpHistoryList(fd, pw, ((TaskRecord) this.mTaskHistory.get(taskNdx)).mActivities, "    ", "Hist", SHOW_APP_STARTING_PREVIEW, !dumpAll ? SHOW_APP_STARTING_PREVIEW : SCREENSHOT_FORCE_565, dumpClient, dumpPackage, needSep, header, "    Task id #" + task.taskId);
                    if (printed) {
                        header = null;
                    }
                }
                return printed;
            }

            ArrayList<ActivityRecord> getDumpActivitiesLocked(String name) {
                ArrayList<ActivityRecord> activities = new ArrayList();
                int taskNdx;
                if ("all".equals(name)) {
                    for (taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
                        activities.addAll(((TaskRecord) this.mTaskHistory.get(taskNdx)).mActivities);
                    }
                } else if ("top".equals(name)) {
                    int top = this.mTaskHistory.size() - 1;
                    if (top >= 0) {
                        ArrayList<ActivityRecord> list = ((TaskRecord) this.mTaskHistory.get(top)).mActivities;
                        int listTop = list.size() - 1;
                        if (listTop >= 0) {
                            activities.add(list.get(listTop));
                        }
                    }
                } else {
                    ItemMatcher matcher = new ItemMatcher();
                    matcher.build(name);
                    for (taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
                        Iterator i$ = ((TaskRecord) this.mTaskHistory.get(taskNdx)).mActivities.iterator();
                        while (i$.hasNext()) {
                            ActivityRecord r1 = (ActivityRecord) i$.next();
                            if (matcher.match(r1, r1.intent.getComponent())) {
                                activities.add(r1);
                            }
                        }
                    }
                }
                return activities;
            }

            ActivityRecord restartPackage(String packageName) {
                ActivityRecord starting = topRunningActivityLocked(null);
                for (int taskNdx = this.mTaskHistory.size() - 1; taskNdx >= 0; taskNdx--) {
                    ArrayList<ActivityRecord> activities = ((TaskRecord) this.mTaskHistory.get(taskNdx)).mActivities;
                    for (int activityNdx = activities.size() - 1; activityNdx >= 0; activityNdx--) {
                        ActivityRecord a = (ActivityRecord) activities.get(activityNdx);
                        if (a.info.packageName.equals(packageName)) {
                            a.forceNewConfig = SHOW_APP_STARTING_PREVIEW;
                            if (starting != null && a == starting && a.visible) {
                                a.startFreezingScreenLocked(starting.app, DumpState.DUMP_VERIFIERS);
                            }
                        }
                    }
                }
                return starting;
            }

            void removeTask(TaskRecord task, String reason) {
                boolean z = SHOW_APP_STARTING_PREVIEW;
                this.mStackSupervisor.endLockTaskModeIfTaskEnding(task);
                this.mWindowManager.removeTask(task.taskId);
                ActivityRecord r = this.mResumedActivity;
                if (r != null && r.task == task) {
                    this.mResumedActivity = null;
                }
                int taskNdx = this.mTaskHistory.indexOf(task);
                int topTaskNdx = this.mTaskHistory.size() - 1;
                if (task.isOverHomeStack() && taskNdx < topTaskNdx) {
                    TaskRecord nextTask = (TaskRecord) this.mTaskHistory.get(taskNdx + FINISH_AFTER_PAUSE);
                    if (!nextTask.isOverHomeStack()) {
                        nextTask.setTaskToReturnTo(FINISH_AFTER_PAUSE);
                    }
                }
                this.mTaskHistory.remove(task);
                updateTaskMovement(task, SHOW_APP_STARTING_PREVIEW);
                if (task.mActivities.isEmpty()) {
                    boolean isVoiceSession = task.voiceSession != null ? SHOW_APP_STARTING_PREVIEW : SCREENSHOT_FORCE_565;
                    if (isVoiceSession) {
                        try {
                            task.voiceSession.taskFinished(task.intent, task.taskId);
                        } catch (RemoteException e) {
                        }
                    }
                    if (task.autoRemoveFromRecents() || isVoiceSession) {
                        this.mService.mRecentTasks.remove(task);
                        task.removedFromRecents();
                    }
                }
                if (this.mTaskHistory.isEmpty()) {
                    if (isOnHomeDisplay()) {
                        ActivityStackSupervisor activityStackSupervisor = this.mStackSupervisor;
                        if (isHomeStack()) {
                            z = SCREENSHOT_FORCE_565;
                        }
                        activityStackSupervisor.moveHomeStack(z, reason + " leftTaskHistoryEmpty");
                    }
                    if (this.mStacks != null) {
                        this.mStacks.remove(this);
                        this.mStacks.add(FINISH_IMMEDIATELY, this);
                    }
                    this.mActivityContainer.onTaskListEmptyLocked();
                }
            }

            TaskRecord createTaskRecord(int taskId, ActivityInfo info, Intent intent, IVoiceInteractionSession voiceSession, IVoiceInteractor voiceInteractor, boolean toTop) {
                TaskRecord task = new TaskRecord(this.mService, taskId, info, intent, voiceSession, voiceInteractor);
                addTask(task, toTop, SCREENSHOT_FORCE_565);
                return task;
            }

            ArrayList<TaskRecord> getAllTasks() {
                return new ArrayList(this.mTaskHistory);
            }

            void addTask(TaskRecord task, boolean toTop, boolean moving) {
                task.stack = this;
                if (toTop) {
                    insertTaskAtTop(task);
                } else {
                    this.mTaskHistory.add(FINISH_IMMEDIATELY, task);
                    updateTaskMovement(task, SCREENSHOT_FORCE_565);
                }
                if (!moving && task.voiceSession != null) {
                    try {
                        task.voiceSession.taskStarted(task.intent, task.taskId);
                    } catch (RemoteException e) {
                    }
                }
            }

            public int getStackId() {
                return this.mStackId;
            }

            public String toString() {
                return "ActivityStack{" + Integer.toHexString(System.identityHashCode(this)) + " stackId=" + this.mStackId + ", " + this.mTaskHistory.size() + " tasks}";
            }
        }
