package com.android.server.am;

import android.app.ActivityManager.RunningTaskInfo;
import android.app.ActivityManager.StackInfo;
import android.app.ActivityOptions;
import android.app.AppGlobals;
import android.app.IActivityContainer;
import android.app.IActivityContainer.Stub;
import android.app.IActivityContainerCallback;
import android.app.IActivityManager.WaitResult;
import android.app.IApplicationThread;
import android.app.ProfilerInfo;
import android.app.ResultInfo;
import android.app.admin.IDevicePolicyManager;
import android.content.ComponentName;
import android.content.IIntentSender;
import android.content.Intent;
import android.content.IntentSender;
import android.content.pm.ActivityInfo;
import android.content.pm.ResolveInfo;
import android.content.res.Configuration;
import android.graphics.Point;
import android.hardware.display.DisplayManager;
import android.hardware.display.DisplayManager.DisplayListener;
import android.hardware.display.DisplayManagerGlobal;
import android.hardware.display.VirtualDisplay;
import android.hardware.input.InputManagerInternal;
import android.os.Binder;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.os.ParcelFileDescriptor;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.SystemClock;
import android.os.UserHandle;
import android.provider.Settings.Secure;
import android.provider.Settings.SettingNotFoundException;
import android.service.voice.IVoiceInteractionSession;
import android.util.ArraySet;
import android.util.EventLog;
import android.util.Slog;
import android.util.SparseArray;
import android.util.SparseIntArray;
import android.view.Display;
import android.view.DisplayInfo;
import android.view.InputEvent;
import android.view.Surface;
import com.android.internal.app.HeavyWeightSwitcherActivity;
import com.android.internal.app.IVoiceInteractor;
import com.android.internal.content.ReferrerIntent;
import com.android.internal.os.BinderInternal;
import com.android.internal.os.TransferPipe;
import com.android.internal.statusbar.IStatusBarService;
import com.android.internal.widget.LockPatternUtils;
import com.android.server.LocalServices;
import com.android.server.voiceinteraction.SoundTriggerHelper;
import com.android.server.wm.WindowManagerService;
import com.android.server.wm.WindowManagerService.C0569H;
import java.io.FileDescriptor;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public final class ActivityStackSupervisor implements DisplayListener {
    static final int CONTAINER_CALLBACK_TASK_LIST_EMPTY = 111;
    static final int CONTAINER_CALLBACK_VISIBILITY = 108;
    static final int CONTAINER_TASK_LIST_EMPTY_TIMEOUT = 112;
    static final boolean DEBUG = false;
    static final boolean DEBUG_ADD_REMOVE = false;
    static final boolean DEBUG_APP = false;
    static final boolean DEBUG_CONTAINERS = false;
    static final boolean DEBUG_IDLE = false;
    static final boolean DEBUG_RELEASE = false;
    static final boolean DEBUG_SAVED_STATE = false;
    static final boolean DEBUG_SCREENSHOTS = false;
    static final boolean DEBUG_STATES = false;
    static final boolean DEBUG_VISIBLE_BEHIND = false;
    static final int HANDLE_DISPLAY_ADDED = 105;
    static final int HANDLE_DISPLAY_CHANGED = 106;
    static final int HANDLE_DISPLAY_REMOVED = 107;
    public static final int HOME_STACK_ID = 0;
    static final int IDLE_NOW_MSG = 101;
    static final int IDLE_TIMEOUT = 10000;
    static final int IDLE_TIMEOUT_MSG = 100;
    static final int LAUNCH_TASK_BEHIND_COMPLETE = 113;
    static final int LAUNCH_TIMEOUT = 10000;
    static final int LAUNCH_TIMEOUT_MSG = 104;
    static final int LOCK_TASK_END_MSG = 110;
    static final int LOCK_TASK_START_MSG = 109;
    private static final String LOCK_TASK_TAG = "Lock-to-App";
    static final int RESUME_TOP_ACTIVITY_MSG = 102;
    static final int SLEEP_TIMEOUT = 5000;
    static final int SLEEP_TIMEOUT_MSG = 103;
    static final boolean VALIDATE_WAKE_LOCK_CALLER = false;
    private static final String VIRTUAL_DISPLAY_BASE_NAME = "ActivityViewVirtualDisplay";
    boolean inResumeTopActivity;
    private SparseArray<ActivityContainer> mActivityContainers;
    private final SparseArray<ActivityDisplay> mActivityDisplays;
    private int mCurTaskId;
    private int mCurrentUser;
    private IDevicePolicyManager mDevicePolicyManager;
    DisplayManager mDisplayManager;
    final ArrayList<ActivityRecord> mFinishingActivities;
    private ActivityStack mFocusedStack;
    WakeLock mGoingToSleep;
    final ArrayList<ActivityRecord> mGoingToSleepActivities;
    final ActivityStackSupervisorHandler mHandler;
    private ActivityStack mHomeStack;
    InputManagerInternal mInputManagerInternal;
    private ActivityStack mLastFocusedStack;
    private int mLastStackId;
    WakeLock mLaunchingActivity;
    private boolean mLeanbackOnlyDevice;
    private boolean mLockTaskIsLocked;
    TaskRecord mLockTaskModeTask;
    private LockTaskNotify mLockTaskNotify;
    final ArrayList<PendingActivityLaunch> mPendingActivityLaunches;
    private PowerManager mPm;
    final ActivityManagerService mService;
    boolean mSleepTimeout;
    final ArrayList<UserStartedState> mStartingBackgroundUsers;
    final ArrayList<UserStartedState> mStartingUsers;
    private IStatusBarService mStatusBarService;
    final ArrayList<ActivityRecord> mStoppingActivities;
    private IBinder mToken;
    boolean mUserLeaving;
    SparseIntArray mUserStackInFront;
    final ArrayList<WaitResult> mWaitingActivityLaunched;
    final ArrayList<WaitResult> mWaitingActivityVisible;
    final ArrayList<ActivityRecord> mWaitingVisibleActivities;
    WindowManagerService mWindowManager;

    class ActivityContainer extends Stub {
        static final int CONTAINER_STATE_FINISHING = 2;
        static final int CONTAINER_STATE_HAS_SURFACE = 0;
        static final int CONTAINER_STATE_NO_SURFACE = 1;
        static final int FORCE_NEW_TASK_FLAGS = 402718720;
        ActivityDisplay mActivityDisplay;
        IActivityContainerCallback mCallback;
        int mContainerState;
        String mIdString;
        ActivityRecord mParentActivity;
        final ActivityStack mStack;
        final int mStackId;
        boolean mVisible;

        ActivityContainer(int stackId) {
            this.mCallback = null;
            this.mParentActivity = null;
            this.mVisible = true;
            this.mContainerState = CONTAINER_STATE_HAS_SURFACE;
            synchronized (ActivityStackSupervisor.this.mService) {
                this.mStackId = stackId;
                this.mStack = new ActivityStack(this);
                this.mIdString = "ActivtyContainer{" + this.mStackId + "}";
            }
        }

        void attachToDisplayLocked(ActivityDisplay activityDisplay) {
            this.mActivityDisplay = activityDisplay;
            this.mStack.mDisplayId = activityDisplay.mDisplayId;
            this.mStack.mStacks = activityDisplay.mStacks;
            activityDisplay.attachActivities(this.mStack);
            ActivityStackSupervisor.this.mWindowManager.attachStack(this.mStackId, activityDisplay.mDisplayId);
        }

        public void attachToDisplay(int displayId) {
            synchronized (ActivityStackSupervisor.this.mService) {
                ActivityDisplay activityDisplay = (ActivityDisplay) ActivityStackSupervisor.this.mActivityDisplays.get(displayId);
                if (activityDisplay == null) {
                    return;
                }
                attachToDisplayLocked(activityDisplay);
            }
        }

        public int getDisplayId() {
            synchronized (ActivityStackSupervisor.this.mService) {
                if (this.mActivityDisplay != null) {
                    int i = this.mActivityDisplay.mDisplayId;
                    return i;
                }
                return -1;
            }
        }

        public boolean injectEvent(InputEvent event) {
            boolean z = ActivityStackSupervisor.VALIDATE_WAKE_LOCK_CALLER;
            long origId = Binder.clearCallingIdentity();
            try {
                synchronized (ActivityStackSupervisor.this.mService) {
                    if (this.mActivityDisplay != null) {
                        z = ActivityStackSupervisor.this.mInputManagerInternal.injectInputEvent(event, this.mActivityDisplay.mDisplayId, CONTAINER_STATE_HAS_SURFACE);
                    } else {
                        Binder.restoreCallingIdentity(origId);
                    }
                }
                return z;
            } finally {
                Binder.restoreCallingIdentity(origId);
            }
        }

        public void release() {
            synchronized (ActivityStackSupervisor.this.mService) {
                if (this.mContainerState == CONTAINER_STATE_FINISHING) {
                    return;
                }
                this.mContainerState = CONTAINER_STATE_FINISHING;
                ActivityStackSupervisor.this.mHandler.sendMessageDelayed(ActivityStackSupervisor.this.mHandler.obtainMessage(ActivityStackSupervisor.CONTAINER_TASK_LIST_EMPTY_TIMEOUT, this), 2000);
                long origId = Binder.clearCallingIdentity();
                try {
                    this.mStack.finishAllActivitiesLocked(ActivityStackSupervisor.VALIDATE_WAKE_LOCK_CALLER);
                    ActivityStackSupervisor.this.removePendingActivityLaunchesLocked(this.mStack);
                } finally {
                    Binder.restoreCallingIdentity(origId);
                }
            }
        }

        protected void detachLocked() {
            if (this.mActivityDisplay != null) {
                this.mActivityDisplay.detachActivitiesLocked(this.mStack);
                this.mActivityDisplay = null;
                this.mStack.mDisplayId = -1;
                this.mStack.mStacks = null;
                ActivityStackSupervisor.this.mWindowManager.detachStack(this.mStackId);
            }
        }

        public final int startActivity(Intent intent) {
            ActivityStackSupervisor.this.mService.enforceNotIsolatedCaller("ActivityContainer.startActivity");
            int userId = ActivityStackSupervisor.this.mService.handleIncomingUser(Binder.getCallingPid(), Binder.getCallingUid(), ActivityStackSupervisor.this.mCurrentUser, (boolean) ActivityStackSupervisor.VALIDATE_WAKE_LOCK_CALLER, (int) CONTAINER_STATE_FINISHING, "ActivityContainer", null);
            intent.addFlags(FORCE_NEW_TASK_FLAGS);
            String mimeType = intent.getType();
            if (mimeType == null && intent.getData() != null && "content".equals(intent.getData().getScheme())) {
                mimeType = ActivityStackSupervisor.this.mService.getProviderMimeType(intent.getData(), userId);
            }
            return ActivityStackSupervisor.this.startActivityMayWait(null, -1, null, intent, mimeType, null, null, null, null, CONTAINER_STATE_HAS_SURFACE, CONTAINER_STATE_HAS_SURFACE, null, null, null, null, userId, this, null);
        }

        public final int startActivityIntentSender(IIntentSender intentSender) {
            ActivityStackSupervisor.this.mService.enforceNotIsolatedCaller("ActivityContainer.startActivityIntentSender");
            if (intentSender instanceof PendingIntentRecord) {
                return ((PendingIntentRecord) intentSender).sendInner(CONTAINER_STATE_HAS_SURFACE, null, null, null, null, null, null, CONTAINER_STATE_HAS_SURFACE, FORCE_NEW_TASK_FLAGS, FORCE_NEW_TASK_FLAGS, null, this);
            }
            throw new IllegalArgumentException("Bad PendingIntent object");
        }

        private void checkEmbeddedAllowedInner(Intent intent, String resolvedType) {
            int userId = ActivityStackSupervisor.this.mService.handleIncomingUser(Binder.getCallingPid(), Binder.getCallingUid(), ActivityStackSupervisor.this.mCurrentUser, (boolean) ActivityStackSupervisor.VALIDATE_WAKE_LOCK_CALLER, (int) CONTAINER_STATE_FINISHING, "ActivityContainer", null);
            if (resolvedType == null) {
                resolvedType = intent.getType();
                if (resolvedType == null && intent.getData() != null && "content".equals(intent.getData().getScheme())) {
                    resolvedType = ActivityStackSupervisor.this.mService.getProviderMimeType(intent.getData(), userId);
                }
            }
            ActivityInfo aInfo = ActivityStackSupervisor.this.resolveActivity(intent, resolvedType, CONTAINER_STATE_HAS_SURFACE, null, userId);
            if (aInfo != null && (aInfo.flags & SoundTriggerHelper.STATUS_ERROR) == 0) {
                throw new SecurityException("Attempt to embed activity that has not set allowEmbedded=\"true\"");
            }
        }

        public final void checkEmbeddedAllowed(Intent intent) {
            checkEmbeddedAllowedInner(intent, null);
        }

        public final void checkEmbeddedAllowedIntentSender(IIntentSender intentSender) {
            if (intentSender instanceof PendingIntentRecord) {
                PendingIntentRecord pendingIntent = (PendingIntentRecord) intentSender;
                checkEmbeddedAllowedInner(pendingIntent.key.requestIntent, pendingIntent.key.requestResolvedType);
                return;
            }
            throw new IllegalArgumentException("Bad PendingIntent object");
        }

        public IBinder asBinder() {
            return this;
        }

        public void setSurface(Surface surface, int width, int height, int density) {
            ActivityStackSupervisor.this.mService.enforceNotIsolatedCaller("ActivityContainer.attachToSurface");
        }

        ActivityStackSupervisor getOuter() {
            return ActivityStackSupervisor.this;
        }

        boolean isAttachedLocked() {
            return this.mActivityDisplay != null ? true : ActivityStackSupervisor.VALIDATE_WAKE_LOCK_CALLER;
        }

        void getBounds(Point outBounds) {
            synchronized (ActivityStackSupervisor.this.mService) {
                if (this.mActivityDisplay != null) {
                    this.mActivityDisplay.getBounds(outBounds);
                } else {
                    outBounds.set(CONTAINER_STATE_HAS_SURFACE, CONTAINER_STATE_HAS_SURFACE);
                }
            }
        }

        void setVisible(boolean visible) {
            if (this.mVisible != visible) {
                this.mVisible = visible;
                if (this.mCallback != null) {
                    int i;
                    ActivityStackSupervisorHandler activityStackSupervisorHandler = ActivityStackSupervisor.this.mHandler;
                    if (visible) {
                        i = CONTAINER_STATE_NO_SURFACE;
                    } else {
                        i = CONTAINER_STATE_HAS_SURFACE;
                    }
                    activityStackSupervisorHandler.obtainMessage(ActivityStackSupervisor.CONTAINER_CALLBACK_VISIBILITY, i, CONTAINER_STATE_HAS_SURFACE, this).sendToTarget();
                }
            }
        }

        void setDrawn() {
        }

        boolean isEligibleForNewTasks() {
            return true;
        }

        void onTaskListEmptyLocked() {
        }

        public String toString() {
            return this.mIdString + (this.mActivityDisplay == null ? "N" : "A");
        }
    }

    class ActivityDisplay {
        Display mDisplay;
        int mDisplayId;
        DisplayInfo mDisplayInfo;
        final ArrayList<ActivityStack> mStacks;
        ActivityRecord mVisibleBehindActivity;

        ActivityDisplay() {
            this.mDisplayInfo = new DisplayInfo();
            this.mStacks = new ArrayList();
        }

        ActivityDisplay(int displayId) {
            this.mDisplayInfo = new DisplayInfo();
            this.mStacks = new ArrayList();
            Display display = ActivityStackSupervisor.this.mDisplayManager.getDisplay(displayId);
            if (display != null) {
                init(display);
            }
        }

        void init(Display display) {
            this.mDisplay = display;
            this.mDisplayId = display.getDisplayId();
            this.mDisplay.getDisplayInfo(this.mDisplayInfo);
        }

        void attachActivities(ActivityStack stack) {
            this.mStacks.add(stack);
        }

        void detachActivitiesLocked(ActivityStack stack) {
            this.mStacks.remove(stack);
        }

        void getBounds(Point bounds) {
            this.mDisplay.getDisplayInfo(this.mDisplayInfo);
            bounds.x = this.mDisplayInfo.appWidth;
            bounds.y = this.mDisplayInfo.appHeight;
        }

        void setVisibleBehindActivity(ActivityRecord r) {
            this.mVisibleBehindActivity = r;
        }

        boolean hasVisibleBehindActivity() {
            return this.mVisibleBehindActivity != null ? true : ActivityStackSupervisor.VALIDATE_WAKE_LOCK_CALLER;
        }

        public String toString() {
            return "ActivityDisplay={" + this.mDisplayId + " numStacks=" + this.mStacks.size() + "}";
        }
    }

    private final class ActivityStackSupervisorHandler extends Handler {
        public ActivityStackSupervisorHandler(Looper looper) {
            super(looper);
        }

        void activityIdleInternal(ActivityRecord r) {
            IBinder iBinder = null;
            synchronized (ActivityStackSupervisor.this.mService) {
                ActivityStackSupervisor activityStackSupervisor = ActivityStackSupervisor.this;
                if (r != null) {
                    iBinder = r.appToken;
                }
                activityStackSupervisor.activityIdleInternalLocked(iBinder, true, null);
            }
        }

        public void handleMessage(Message msg) {
            boolean shouldLockKeyguard = true;
            ActivityContainer container;
            IActivityContainerCallback callback;
            switch (msg.what) {
                case ActivityStackSupervisor.IDLE_TIMEOUT_MSG /*100*/:
                    if (ActivityStackSupervisor.this.mService.mDidDexOpt) {
                        ActivityStackSupervisor.this.mService.mDidDexOpt = ActivityStackSupervisor.VALIDATE_WAKE_LOCK_CALLER;
                        Message nmsg = ActivityStackSupervisor.this.mHandler.obtainMessage(ActivityStackSupervisor.IDLE_TIMEOUT_MSG);
                        nmsg.obj = msg.obj;
                        ActivityStackSupervisor.this.mHandler.sendMessageDelayed(nmsg, 10000);
                        return;
                    }
                    activityIdleInternal((ActivityRecord) msg.obj);
                case ActivityStackSupervisor.IDLE_NOW_MSG /*101*/:
                    activityIdleInternal((ActivityRecord) msg.obj);
                case ActivityStackSupervisor.RESUME_TOP_ACTIVITY_MSG /*102*/:
                    synchronized (ActivityStackSupervisor.this.mService) {
                        ActivityStackSupervisor.this.resumeTopActivitiesLocked();
                        break;
                    }
                case ActivityStackSupervisor.SLEEP_TIMEOUT_MSG /*103*/:
                    synchronized (ActivityStackSupervisor.this.mService) {
                        if (ActivityStackSupervisor.this.mService.isSleepingOrShuttingDown()) {
                            Slog.w("ActivityManager", "Sleep timeout!  Sleeping now.");
                            ActivityStackSupervisor.this.mSleepTimeout = true;
                            ActivityStackSupervisor.this.checkReadyForSleepLocked();
                        }
                        break;
                    }
                case ActivityStackSupervisor.LAUNCH_TIMEOUT_MSG /*104*/:
                    if (ActivityStackSupervisor.this.mService.mDidDexOpt) {
                        ActivityStackSupervisor.this.mService.mDidDexOpt = ActivityStackSupervisor.VALIDATE_WAKE_LOCK_CALLER;
                        ActivityStackSupervisor.this.mHandler.sendEmptyMessageDelayed(ActivityStackSupervisor.LAUNCH_TIMEOUT_MSG, 10000);
                        return;
                    }
                    synchronized (ActivityStackSupervisor.this.mService) {
                        if (ActivityStackSupervisor.this.mLaunchingActivity.isHeld()) {
                            Slog.w("ActivityManager", "Launch timeout has expired, giving up wake lock!");
                            ActivityStackSupervisor.this.mLaunchingActivity.release();
                        }
                        break;
                    }
                case ActivityStackSupervisor.HANDLE_DISPLAY_ADDED /*105*/:
                    ActivityStackSupervisor.this.handleDisplayAddedLocked(msg.arg1);
                case ActivityStackSupervisor.HANDLE_DISPLAY_CHANGED /*106*/:
                    ActivityStackSupervisor.this.handleDisplayChangedLocked(msg.arg1);
                case ActivityStackSupervisor.HANDLE_DISPLAY_REMOVED /*107*/:
                    ActivityStackSupervisor.this.handleDisplayRemovedLocked(msg.arg1);
                case ActivityStackSupervisor.CONTAINER_CALLBACK_VISIBILITY /*108*/:
                    container = msg.obj;
                    callback = container.mCallback;
                    if (callback != null) {
                        try {
                            IBinder asBinder = container.asBinder();
                            if (msg.arg1 != 1) {
                                shouldLockKeyguard = ActivityStackSupervisor.VALIDATE_WAKE_LOCK_CALLER;
                            }
                            callback.setVisible(asBinder, shouldLockKeyguard);
                        } catch (RemoteException e) {
                        }
                    }
                case ActivityStackSupervisor.LOCK_TASK_START_MSG /*109*/:
                    try {
                        if (ActivityStackSupervisor.this.mLockTaskNotify == null) {
                            ActivityStackSupervisor.this.mLockTaskNotify = new LockTaskNotify(ActivityStackSupervisor.this.mService.mContext);
                        }
                        ActivityStackSupervisor.this.mLockTaskNotify.show(true);
                        ActivityStackSupervisor activityStackSupervisor = ActivityStackSupervisor.this;
                        if (msg.arg2 != 0) {
                            shouldLockKeyguard = ActivityStackSupervisor.VALIDATE_WAKE_LOCK_CALLER;
                        }
                        activityStackSupervisor.mLockTaskIsLocked = shouldLockKeyguard;
                        if (ActivityStackSupervisor.this.getStatusBarService() != null) {
                            int flags = 62849024;
                            if (!ActivityStackSupervisor.this.mLockTaskIsLocked) {
                                flags = 62849024 ^ 18874368;
                            }
                            ActivityStackSupervisor.this.getStatusBarService().disable(flags, ActivityStackSupervisor.this.mToken, ActivityStackSupervisor.this.mService.mContext.getPackageName());
                        }
                        ActivityStackSupervisor.this.mWindowManager.disableKeyguard(ActivityStackSupervisor.this.mToken, ActivityStackSupervisor.LOCK_TASK_TAG);
                        if (ActivityStackSupervisor.this.getDevicePolicyManager() != null) {
                            ActivityStackSupervisor.this.getDevicePolicyManager().notifyLockTaskModeChanged(true, (String) msg.obj, msg.arg1);
                        }
                    } catch (RemoteException ex) {
                        throw new RuntimeException(ex);
                    }
                case ActivityStackSupervisor.LOCK_TASK_END_MSG /*110*/:
                    try {
                        if (ActivityStackSupervisor.this.getStatusBarService() != null) {
                            ActivityStackSupervisor.this.getStatusBarService().disable(ActivityStackSupervisor.HOME_STACK_ID, ActivityStackSupervisor.this.mToken, ActivityStackSupervisor.this.mService.mContext.getPackageName());
                        }
                        ActivityStackSupervisor.this.mWindowManager.reenableKeyguard(ActivityStackSupervisor.this.mToken);
                        if (ActivityStackSupervisor.this.getDevicePolicyManager() != null) {
                            ActivityStackSupervisor.this.getDevicePolicyManager().notifyLockTaskModeChanged(ActivityStackSupervisor.VALIDATE_WAKE_LOCK_CALLER, null, msg.arg1);
                        }
                        if (ActivityStackSupervisor.this.mLockTaskNotify == null) {
                            ActivityStackSupervisor.this.mLockTaskNotify = new LockTaskNotify(ActivityStackSupervisor.this.mService.mContext);
                        }
                        ActivityStackSupervisor.this.mLockTaskNotify.show(ActivityStackSupervisor.VALIDATE_WAKE_LOCK_CALLER);
                        try {
                            if (Secure.getInt(ActivityStackSupervisor.this.mService.mContext.getContentResolver(), "lock_to_app_exit_locked") == 0) {
                                shouldLockKeyguard = ActivityStackSupervisor.VALIDATE_WAKE_LOCK_CALLER;
                            }
                            if (!ActivityStackSupervisor.this.mLockTaskIsLocked && shouldLockKeyguard) {
                                ActivityStackSupervisor.this.mWindowManager.lockNow(null);
                                ActivityStackSupervisor.this.mWindowManager.dismissKeyguard();
                                new LockPatternUtils(ActivityStackSupervisor.this.mService.mContext).requireCredentialEntry(-1);
                            }
                        } catch (SettingNotFoundException e2) {
                        }
                    } catch (RemoteException ex2) {
                        throw new RuntimeException(ex2);
                    }
                case ActivityStackSupervisor.CONTAINER_CALLBACK_TASK_LIST_EMPTY /*111*/:
                    container = (ActivityContainer) msg.obj;
                    callback = container.mCallback;
                    if (callback != null) {
                        try {
                            callback.onAllActivitiesComplete(container.asBinder());
                        } catch (RemoteException e3) {
                        }
                    }
                case ActivityStackSupervisor.CONTAINER_TASK_LIST_EMPTY_TIMEOUT /*112*/:
                    synchronized (ActivityStackSupervisor.this.mService) {
                        Slog.w("ActivityManager", "Timeout waiting for all activities in task to finish. " + msg.obj);
                        container = (ActivityContainer) msg.obj;
                        container.mStack.finishAllActivitiesLocked(true);
                        container.onTaskListEmptyLocked();
                        break;
                    }
                case ActivityStackSupervisor.LAUNCH_TASK_BEHIND_COMPLETE /*113*/:
                    synchronized (ActivityStackSupervisor.this.mService) {
                        ActivityRecord r = ActivityRecord.forToken((IBinder) msg.obj);
                        if (r != null) {
                            ActivityStackSupervisor.this.handleLaunchTaskBehindCompleteLocked(r);
                        }
                        break;
                    }
                default:
            }
        }
    }

    static class PendingActivityLaunch {
        final ActivityRecord f2r;
        final ActivityRecord sourceRecord;
        final ActivityStack stack;
        final int startFlags;

        PendingActivityLaunch(ActivityRecord _r, ActivityRecord _sourceRecord, int _startFlags, ActivityStack _stack) {
            this.f2r = _r;
            this.sourceRecord = _sourceRecord;
            this.startFlags = _startFlags;
            this.stack = _stack;
        }
    }

    private class VirtualActivityContainer extends ActivityContainer {
        boolean mDrawn;
        Surface mSurface;

        VirtualActivityContainer(ActivityRecord parent, IActivityContainerCallback callback) {
            super(ActivityStackSupervisor.this.getNextStackId());
            this.mDrawn = ActivityStackSupervisor.VALIDATE_WAKE_LOCK_CALLER;
            this.mParentActivity = parent;
            this.mCallback = callback;
            this.mContainerState = 1;
            this.mIdString = "VirtualActivityContainer{" + this.mStackId + ", parent=" + this.mParentActivity + "}";
        }

        public void setSurface(Surface surface, int width, int height, int density) {
            super.setSurface(surface, width, height, density);
            synchronized (ActivityStackSupervisor.this.mService) {
                long origId = Binder.clearCallingIdentity();
                try {
                    setSurfaceLocked(surface, width, height, density);
                    Binder.restoreCallingIdentity(origId);
                } catch (Throwable th) {
                    Binder.restoreCallingIdentity(origId);
                }
            }
        }

        private void setSurfaceLocked(Surface surface, int width, int height, int density) {
            if (this.mContainerState != 2) {
                if (this.mActivityDisplay == null) {
                    VirtualActivityDisplay virtualActivityDisplay = new VirtualActivityDisplay(width, height, density);
                    this.mActivityDisplay = virtualActivityDisplay;
                    ActivityStackSupervisor.this.mActivityDisplays.put(virtualActivityDisplay.mDisplayId, virtualActivityDisplay);
                    attachToDisplayLocked(virtualActivityDisplay);
                }
                if (this.mSurface != null) {
                    this.mSurface.release();
                }
                this.mSurface = surface;
                if (surface != null) {
                    this.mStack.resumeTopActivityLocked(null);
                } else {
                    this.mContainerState = 1;
                    ((VirtualActivityDisplay) this.mActivityDisplay).setSurface(null);
                    if (this.mStack.mPausingActivity == null && this.mStack.mResumedActivity != null) {
                        this.mStack.startPausingLocked(ActivityStackSupervisor.VALIDATE_WAKE_LOCK_CALLER, true, ActivityStackSupervisor.VALIDATE_WAKE_LOCK_CALLER, ActivityStackSupervisor.VALIDATE_WAKE_LOCK_CALLER);
                    }
                }
                setSurfaceIfReadyLocked();
            }
        }

        boolean isAttachedLocked() {
            return (this.mSurface == null || !super.isAttachedLocked()) ? ActivityStackSupervisor.VALIDATE_WAKE_LOCK_CALLER : true;
        }

        void setDrawn() {
            synchronized (ActivityStackSupervisor.this.mService) {
                this.mDrawn = true;
                setSurfaceIfReadyLocked();
            }
        }

        boolean isEligibleForNewTasks() {
            return ActivityStackSupervisor.VALIDATE_WAKE_LOCK_CALLER;
        }

        void onTaskListEmptyLocked() {
            ActivityStackSupervisor.this.mHandler.removeMessages(ActivityStackSupervisor.CONTAINER_TASK_LIST_EMPTY_TIMEOUT, this);
            detachLocked();
            ActivityStackSupervisor.this.deleteActivityContainer(this);
            ActivityStackSupervisor.this.mHandler.obtainMessage(ActivityStackSupervisor.CONTAINER_CALLBACK_TASK_LIST_EMPTY, this).sendToTarget();
        }

        private void setSurfaceIfReadyLocked() {
            if (this.mDrawn && this.mSurface != null && this.mContainerState == 1) {
                ((VirtualActivityDisplay) this.mActivityDisplay).setSurface(this.mSurface);
                this.mContainerState = ActivityStackSupervisor.HOME_STACK_ID;
            }
        }
    }

    class VirtualActivityDisplay extends ActivityDisplay {
        VirtualDisplay mVirtualDisplay;

        VirtualActivityDisplay(int width, int height, int density) {
            super();
            this.mVirtualDisplay = DisplayManagerGlobal.getInstance().createVirtualDisplay(ActivityStackSupervisor.this.mService.mContext, null, ActivityStackSupervisor.VIRTUAL_DISPLAY_BASE_NAME, width, height, density, null, 9, null, null);
            init(this.mVirtualDisplay.getDisplay());
            ActivityStackSupervisor.this.mWindowManager.handleDisplayAdded(this.mDisplayId);
        }

        void setSurface(Surface surface) {
            if (this.mVirtualDisplay != null) {
                this.mVirtualDisplay.setSurface(surface);
            }
        }

        void detachActivitiesLocked(ActivityStack stack) {
            super.detachActivitiesLocked(stack);
            if (this.mVirtualDisplay != null) {
                this.mVirtualDisplay.release();
                this.mVirtualDisplay = null;
            }
        }

        public String toString() {
            return "VirtualActivityDisplay={" + this.mDisplayId + "}";
        }
    }

    public ActivityStackSupervisor(ActivityManagerService service) {
        this.mToken = new Binder();
        this.mLastStackId = HOME_STACK_ID;
        this.mCurTaskId = HOME_STACK_ID;
        this.mWaitingVisibleActivities = new ArrayList();
        this.mWaitingActivityVisible = new ArrayList();
        this.mWaitingActivityLaunched = new ArrayList();
        this.mStoppingActivities = new ArrayList();
        this.mFinishingActivities = new ArrayList();
        this.mGoingToSleepActivities = new ArrayList();
        this.mStartingUsers = new ArrayList();
        this.mStartingBackgroundUsers = new ArrayList();
        this.mUserLeaving = VALIDATE_WAKE_LOCK_CALLER;
        this.mSleepTimeout = VALIDATE_WAKE_LOCK_CALLER;
        this.mUserStackInFront = new SparseIntArray(2);
        this.mActivityContainers = new SparseArray();
        this.mActivityDisplays = new SparseArray();
        this.mPendingActivityLaunches = new ArrayList();
        this.mService = service;
        this.mHandler = new ActivityStackSupervisorHandler(this.mService.mHandler.getLooper());
    }

    void initPowerManagement() {
        this.mPm = (PowerManager) this.mService.mContext.getSystemService("power");
        this.mGoingToSleep = this.mPm.newWakeLock(1, "ActivityManager-Sleep");
        this.mLaunchingActivity = this.mPm.newWakeLock(1, "ActivityManager-Launch");
        this.mLaunchingActivity.setReferenceCounted(VALIDATE_WAKE_LOCK_CALLER);
    }

    private IStatusBarService getStatusBarService() {
        IStatusBarService iStatusBarService;
        synchronized (this.mService) {
            if (this.mStatusBarService == null) {
                this.mStatusBarService = IStatusBarService.Stub.asInterface(ServiceManager.checkService("statusbar"));
                if (this.mStatusBarService == null) {
                    Slog.w("StatusBarManager", "warning: no STATUS_BAR_SERVICE");
                }
            }
            iStatusBarService = this.mStatusBarService;
        }
        return iStatusBarService;
    }

    private IDevicePolicyManager getDevicePolicyManager() {
        IDevicePolicyManager iDevicePolicyManager;
        synchronized (this.mService) {
            if (this.mDevicePolicyManager == null) {
                this.mDevicePolicyManager = IDevicePolicyManager.Stub.asInterface(ServiceManager.checkService("device_policy"));
                if (this.mDevicePolicyManager == null) {
                    Slog.w("ActivityManager", "warning: no DEVICE_POLICY_SERVICE");
                }
            }
            iDevicePolicyManager = this.mDevicePolicyManager;
        }
        return iDevicePolicyManager;
    }

    void setWindowManager(WindowManagerService wm) {
        synchronized (this.mService) {
            this.mWindowManager = wm;
            this.mDisplayManager = (DisplayManager) this.mService.mContext.getSystemService("display");
            this.mDisplayManager.registerDisplayListener(this, null);
            Display[] displays = this.mDisplayManager.getDisplays();
            for (int displayNdx = displays.length - 1; displayNdx >= 0; displayNdx--) {
                int displayId = displays[displayNdx].getDisplayId();
                ActivityDisplay activityDisplay = new ActivityDisplay(displayId);
                if (activityDisplay.mDisplay == null) {
                    throw new IllegalStateException("Default Display does not exist");
                }
                this.mActivityDisplays.put(displayId, activityDisplay);
            }
            createStackOnDisplay(HOME_STACK_ID, HOME_STACK_ID);
            ActivityStack stack = getStack(HOME_STACK_ID);
            this.mLastFocusedStack = stack;
            this.mFocusedStack = stack;
            this.mHomeStack = stack;
            this.mInputManagerInternal = (InputManagerInternal) LocalServices.getService(InputManagerInternal.class);
            this.mLeanbackOnlyDevice = isLeanbackOnlyDevice();
        }
    }

    void notifyActivityDrawnForKeyguard() {
        this.mWindowManager.notifyActivityDrawnForKeyguard();
    }

    ActivityStack getFocusedStack() {
        return this.mFocusedStack;
    }

    ActivityStack getLastStack() {
        return this.mLastFocusedStack;
    }

    boolean isFrontStack(ActivityStack stack) {
        ActivityRecord parent = stack.mActivityContainer.mParentActivity;
        if (parent != null) {
            stack = parent.task.stack;
        }
        ArrayList<ActivityStack> stacks = stack.mStacks;
        if (stacks == null || stacks.isEmpty() || stack != stacks.get(stacks.size() - 1)) {
            return VALIDATE_WAKE_LOCK_CALLER;
        }
        return true;
    }

    void moveHomeStack(boolean toFront, String reason) {
        int i = HOME_STACK_ID;
        ArrayList<ActivityStack> stacks = this.mHomeStack.mStacks;
        int topNdx = stacks.size() - 1;
        if (topNdx > 0) {
            boolean homeInFront;
            ActivityStack topStack = (ActivityStack) stacks.get(topNdx);
            if (topStack == this.mHomeStack) {
                homeInFront = true;
            } else {
                homeInFront = VALIDATE_WAKE_LOCK_CALLER;
            }
            if (homeInFront != toFront) {
                int i2;
                this.mLastFocusedStack = topStack;
                stacks.remove(this.mHomeStack);
                if (toFront) {
                    i2 = topNdx;
                } else {
                    i2 = HOME_STACK_ID;
                }
                stacks.add(i2, this.mHomeStack);
                this.mFocusedStack = (ActivityStack) stacks.get(topNdx);
            }
            Object[] objArr = new Object[5];
            objArr[HOME_STACK_ID] = Integer.valueOf(this.mCurrentUser);
            if (toFront) {
                i = 1;
            }
            objArr[1] = Integer.valueOf(i);
            objArr[2] = Integer.valueOf(((ActivityStack) stacks.get(topNdx)).getStackId());
            objArr[3] = Integer.valueOf(this.mFocusedStack == null ? -1 : this.mFocusedStack.getStackId());
            objArr[4] = reason;
            EventLog.writeEvent(EventLogTags.AM_HOME_STACK_MOVED, objArr);
            if (this.mService.mBooting || !this.mService.mBooted) {
                ActivityRecord r = topRunningActivityLocked();
                if (r != null && r.idle) {
                    checkFinishBootingLocked();
                }
            }
        }
    }

    void moveHomeStackTaskToTop(int homeStackTaskType, String reason) {
        if (homeStackTaskType == 2) {
            this.mWindowManager.showRecentApps();
            return;
        }
        moveHomeStack(true, reason);
        this.mHomeStack.moveHomeStackTaskToTop(homeStackTaskType);
    }

    boolean resumeHomeStackTask(int homeStackTaskType, ActivityRecord prev, String reason) {
        if (!this.mService.mBooting && !this.mService.mBooted) {
            return VALIDATE_WAKE_LOCK_CALLER;
        }
        if (homeStackTaskType == 2) {
            this.mWindowManager.showRecentApps();
            return VALIDATE_WAKE_LOCK_CALLER;
        }
        moveHomeStackTaskToTop(homeStackTaskType, reason);
        if (prev != null) {
            prev.task.setTaskToReturnTo(HOME_STACK_ID);
        }
        ActivityRecord r = this.mHomeStack.topRunningActivityLocked(null);
        if (r == null || !r.isHomeActivity()) {
            return this.mService.startHomeActivityLocked(this.mCurrentUser, reason);
        }
        this.mService.setFocusedActivityLocked(r, reason);
        return resumeTopActivitiesLocked(this.mHomeStack, prev, null);
    }

    TaskRecord anyTaskForIdLocked(int id) {
        TaskRecord task;
        int numDisplays = this.mActivityDisplays.size();
        for (int displayNdx = HOME_STACK_ID; displayNdx < numDisplays; displayNdx++) {
            ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
            for (int stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
                task = ((ActivityStack) stacks.get(stackNdx)).taskForIdLocked(id);
                if (task != null) {
                    return task;
                }
            }
        }
        task = this.mService.recentTaskForIdLocked(id);
        if (task == null) {
            return null;
        }
        if (restoreRecentTaskLocked(task)) {
            return task;
        }
        return null;
    }

    ActivityRecord isInAnyStackLocked(IBinder token) {
        int numDisplays = this.mActivityDisplays.size();
        for (int displayNdx = HOME_STACK_ID; displayNdx < numDisplays; displayNdx++) {
            ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
            for (int stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
                ActivityRecord r = ((ActivityStack) stacks.get(stackNdx)).isInStackLocked(token);
                if (r != null) {
                    return r;
                }
            }
        }
        return null;
    }

    void setNextTaskId(int taskId) {
        if (taskId > this.mCurTaskId) {
            this.mCurTaskId = taskId;
        }
    }

    int getNextTaskId() {
        do {
            this.mCurTaskId++;
            if (this.mCurTaskId <= 0) {
                this.mCurTaskId = 1;
            }
        } while (anyTaskForIdLocked(this.mCurTaskId) != null);
        return this.mCurTaskId;
    }

    ActivityRecord resumedAppLocked() {
        ActivityStack stack = getFocusedStack();
        if (stack == null) {
            return null;
        }
        ActivityRecord resumedActivity = stack.mResumedActivity;
        if (resumedActivity != null && resumedActivity.app != null) {
            return resumedActivity;
        }
        resumedActivity = stack.mPausingActivity;
        if (resumedActivity == null || resumedActivity.app == null) {
            return stack.topRunningActivityLocked(null);
        }
        return resumedActivity;
    }

    boolean attachApplicationLocked(ProcessRecord app) throws RemoteException {
        String processName = app.processName;
        boolean didSomething = VALIDATE_WAKE_LOCK_CALLER;
        for (int displayNdx = this.mActivityDisplays.size() - 1; displayNdx >= 0; displayNdx--) {
            ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
            for (int stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
                ActivityStack stack = (ActivityStack) stacks.get(stackNdx);
                if (isFrontStack(stack)) {
                    ActivityRecord hr = stack.topRunningActivityLocked(null);
                    if (hr != null && hr.app == null && app.uid == hr.info.applicationInfo.uid && processName.equals(hr.processName)) {
                        try {
                            if (realStartActivityLocked(hr, app, true, true)) {
                                didSomething = true;
                            }
                        } catch (RemoteException e) {
                            Slog.w("ActivityManager", "Exception in new application when starting activity " + hr.intent.getComponent().flattenToShortString(), e);
                            throw e;
                        }
                    }
                }
            }
        }
        if (!didSomething) {
            ensureActivitiesVisibleLocked(null, HOME_STACK_ID);
        }
        return didSomething;
    }

    boolean allResumedActivitiesIdle() {
        for (int displayNdx = this.mActivityDisplays.size() - 1; displayNdx >= 0; displayNdx--) {
            ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
            for (int stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
                ActivityStack stack = (ActivityStack) stacks.get(stackNdx);
                if (isFrontStack(stack) && stack.numActivities() != 0) {
                    ActivityRecord resumedActivity = stack.mResumedActivity;
                    if (resumedActivity == null || !resumedActivity.idle) {
                        return VALIDATE_WAKE_LOCK_CALLER;
                    }
                }
            }
        }
        return true;
    }

    boolean allResumedActivitiesComplete() {
        for (int displayNdx = this.mActivityDisplays.size() - 1; displayNdx >= 0; displayNdx--) {
            ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
            for (int stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
                ActivityStack stack = (ActivityStack) stacks.get(stackNdx);
                if (isFrontStack(stack)) {
                    ActivityRecord r = stack.mResumedActivity;
                    if (!(r == null || r.state == ActivityState.RESUMED)) {
                        return VALIDATE_WAKE_LOCK_CALLER;
                    }
                }
            }
        }
        this.mLastFocusedStack = this.mFocusedStack;
        return true;
    }

    boolean allResumedActivitiesVisible() {
        for (int displayNdx = this.mActivityDisplays.size() - 1; displayNdx >= 0; displayNdx--) {
            ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
            for (int stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
                ActivityRecord r = ((ActivityStack) stacks.get(stackNdx)).mResumedActivity;
                if (r != null && (!r.nowVisible || r.waitingVisible)) {
                    return VALIDATE_WAKE_LOCK_CALLER;
                }
            }
        }
        return true;
    }

    boolean pauseBackStacks(boolean userLeaving, boolean resuming, boolean dontWait) {
        boolean someActivityPaused = VALIDATE_WAKE_LOCK_CALLER;
        for (int displayNdx = this.mActivityDisplays.size() - 1; displayNdx >= 0; displayNdx--) {
            ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
            for (int stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
                ActivityStack stack = (ActivityStack) stacks.get(stackNdx);
                if (!(isFrontStack(stack) || stack.mResumedActivity == null)) {
                    someActivityPaused |= stack.startPausingLocked(userLeaving, VALIDATE_WAKE_LOCK_CALLER, resuming, dontWait);
                }
            }
        }
        return someActivityPaused;
    }

    boolean allPausedActivitiesComplete() {
        for (int displayNdx = this.mActivityDisplays.size() - 1; displayNdx >= 0; displayNdx--) {
            ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
            for (int stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
                ActivityRecord r = ((ActivityStack) stacks.get(stackNdx)).mPausingActivity;
                if (r != null && r.state != ActivityState.PAUSED && r.state != ActivityState.STOPPED && r.state != ActivityState.STOPPING) {
                    return VALIDATE_WAKE_LOCK_CALLER;
                }
            }
        }
        return true;
    }

    void pauseChildStacks(ActivityRecord parent, boolean userLeaving, boolean uiSleeping, boolean resuming, boolean dontWait) {
        for (int displayNdx = this.mActivityDisplays.size() - 1; displayNdx >= 0; displayNdx--) {
            ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
            for (int stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
                ActivityStack stack = (ActivityStack) stacks.get(stackNdx);
                if (stack.mResumedActivity != null && stack.mActivityContainer.mParentActivity == parent) {
                    stack.startPausingLocked(userLeaving, uiSleeping, resuming, dontWait);
                }
            }
        }
    }

    void reportActivityVisibleLocked(ActivityRecord r) {
        sendWaitingVisibleReportLocked(r);
    }

    void sendWaitingVisibleReportLocked(ActivityRecord r) {
        boolean changed = VALIDATE_WAKE_LOCK_CALLER;
        for (int i = this.mWaitingActivityVisible.size() - 1; i >= 0; i--) {
            WaitResult w = (WaitResult) this.mWaitingActivityVisible.get(i);
            if (w.who == null) {
                changed = true;
                w.timeout = VALIDATE_WAKE_LOCK_CALLER;
                if (r != null) {
                    w.who = new ComponentName(r.info.packageName, r.info.name);
                }
                w.totalTime = SystemClock.uptimeMillis() - w.thisTime;
                w.thisTime = w.totalTime;
            }
        }
        if (changed) {
            this.mService.notifyAll();
        }
    }

    void reportActivityLaunchedLocked(boolean timeout, ActivityRecord r, long thisTime, long totalTime) {
        boolean changed = VALIDATE_WAKE_LOCK_CALLER;
        for (int i = this.mWaitingActivityLaunched.size() - 1; i >= 0; i--) {
            WaitResult w = (WaitResult) this.mWaitingActivityLaunched.remove(i);
            if (w.who == null) {
                changed = true;
                w.timeout = timeout;
                if (r != null) {
                    w.who = new ComponentName(r.info.packageName, r.info.name);
                }
                w.thisTime = thisTime;
                w.totalTime = totalTime;
            }
        }
        if (changed) {
            this.mService.notifyAll();
        }
    }

    ActivityRecord topRunningActivityLocked() {
        ActivityStack focusedStack = getFocusedStack();
        ActivityRecord r = focusedStack.topRunningActivityLocked(null);
        if (r != null) {
            return r;
        }
        ArrayList<ActivityStack> stacks = this.mHomeStack.mStacks;
        for (int stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
            ActivityStack stack = (ActivityStack) stacks.get(stackNdx);
            if (stack != focusedStack && isFrontStack(stack)) {
                r = stack.topRunningActivityLocked(null);
                if (r != null) {
                    return r;
                }
            }
        }
        return null;
    }

    void getTasksLocked(int maxNum, List<RunningTaskInfo> list, int callingUid, boolean allowed) {
        ArrayList<ArrayList<RunningTaskInfo>> runningTaskLists = new ArrayList();
        int numDisplays = this.mActivityDisplays.size();
        for (int displayNdx = HOME_STACK_ID; displayNdx < numDisplays; displayNdx++) {
            int stackNdx;
            ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
            for (stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
                ActivityStack stack = (ActivityStack) stacks.get(stackNdx);
                ArrayList<RunningTaskInfo> stackTaskList = new ArrayList();
                runningTaskLists.add(stackTaskList);
                stack.getTasksLocked(stackTaskList, callingUid, allowed);
            }
        }
        while (maxNum > 0) {
            long mostRecentActiveTime = Long.MIN_VALUE;
            ArrayList arrayList = null;
            int numTaskLists = runningTaskLists.size();
            for (stackNdx = HOME_STACK_ID; stackNdx < numTaskLists; stackNdx++) {
                stackTaskList = (ArrayList) runningTaskLists.get(stackNdx);
                if (!stackTaskList.isEmpty()) {
                    long lastActiveTime = ((RunningTaskInfo) stackTaskList.get(HOME_STACK_ID)).lastActiveTime;
                    if (lastActiveTime > mostRecentActiveTime) {
                        mostRecentActiveTime = lastActiveTime;
                        arrayList = stackTaskList;
                    }
                }
            }
            if (arrayList != null) {
                list.add(arrayList.remove(HOME_STACK_ID));
                maxNum--;
            } else {
                return;
            }
        }
    }

    ActivityInfo resolveActivity(Intent intent, String resolvedType, int startFlags, ProfilerInfo profilerInfo, int userId) {
        ActivityInfo aInfo;
        try {
            ResolveInfo rInfo = AppGlobals.getPackageManager().resolveIntent(intent, resolvedType, 66560, userId);
            aInfo = rInfo != null ? rInfo.activityInfo : null;
        } catch (RemoteException e) {
            aInfo = null;
        }
        if (aInfo != null) {
            intent.setComponent(new ComponentName(aInfo.applicationInfo.packageName, aInfo.name));
            if (!((startFlags & 2) == 0 || aInfo.processName.equals("system"))) {
                this.mService.setDebugApp(aInfo.processName, true, VALIDATE_WAKE_LOCK_CALLER);
            }
            if (!((startFlags & 4) == 0 || aInfo.processName.equals("system"))) {
                this.mService.setOpenGlTraceApp(aInfo.applicationInfo, aInfo.processName);
            }
            if (!(profilerInfo == null || aInfo.processName.equals("system"))) {
                this.mService.setProfileApp(aInfo.applicationInfo, aInfo.processName, profilerInfo);
            }
        }
        return aInfo;
    }

    void startHomeActivity(Intent intent, ActivityInfo aInfo, String reason) {
        moveHomeStackTaskToTop(1, reason);
        startActivityLocked(null, intent, null, aInfo, null, null, null, null, HOME_STACK_ID, HOME_STACK_ID, HOME_STACK_ID, null, HOME_STACK_ID, HOME_STACK_ID, HOME_STACK_ID, null, VALIDATE_WAKE_LOCK_CALLER, null, null, null);
    }

    final int startActivityMayWait(IApplicationThread caller, int callingUid, String callingPackage, Intent intent, String resolvedType, IVoiceInteractionSession voiceSession, IVoiceInteractor voiceInteractor, IBinder resultTo, String resultWho, int requestCode, int startFlags, ProfilerInfo profilerInfo, WaitResult outResult, Configuration config, Bundle options, int userId, IActivityContainer iContainer, TaskRecord inTask) {
        int callingPid;
        ActivityStack stack;
        ActivityInfo aInfo;
        int res;
        ActivityRecord r;
        Throwable th;
        if (intent == null || !intent.hasFileDescriptors()) {
            boolean componentSpecified = intent.getComponent() != null ? true : VALIDATE_WAKE_LOCK_CALLER;
            Intent intent2 = new Intent(intent);
            ActivityInfo aInfo2 = resolveActivity(intent2, resolvedType, startFlags, profilerInfo, userId);
            ActivityContainer container = (ActivityContainer) iContainer;
            synchronized (this.mService) {
                try {
                    int realCallingPid = Binder.getCallingPid();
                    int realCallingUid = Binder.getCallingUid();
                    if (callingUid >= 0) {
                        callingPid = -1;
                    } else if (caller == null) {
                        callingPid = realCallingPid;
                        callingUid = realCallingUid;
                    } else {
                        callingUid = -1;
                        callingPid = -1;
                    }
                    if (container == null || container.mStack.isOnHomeDisplay()) {
                        stack = getFocusedStack();
                    } else {
                        stack = container.mStack;
                    }
                    boolean z = (config == null || this.mService.mConfiguration.diff(config) == 0) ? VALIDATE_WAKE_LOCK_CALLER : true;
                    stack.mConfigWillChange = z;
                    long origId = Binder.clearCallingIdentity();
                    if (aInfo2 == null || (aInfo2.applicationInfo.flags & 268435456) == 0 || !aInfo2.processName.equals(aInfo2.applicationInfo.packageName) || this.mService.mHeavyWeightProcess == null || (this.mService.mHeavyWeightProcess.info.uid == aInfo2.applicationInfo.uid && this.mService.mHeavyWeightProcess.processName.equals(aInfo2.processName))) {
                        aInfo = aInfo2;
                        intent = intent2;
                    } else {
                        int appCallingUid = callingUid;
                        if (caller != null) {
                            ProcessRecord callerApp = this.mService.getRecordForAppLocked(caller);
                            if (callerApp != null) {
                                appCallingUid = callerApp.info.uid;
                            } else {
                                Slog.w("ActivityManager", "Unable to find app for caller " + caller + " (pid=" + callingPid + ") when starting: " + intent2.toString());
                                ActivityOptions.abort(options);
                                res = -4;
                                aInfo = aInfo2;
                                intent = intent2;
                                return res;
                            }
                        }
                        IIntentSender target = this.mService.getIntentSenderLocked(2, "android", appCallingUid, userId, null, null, HOME_STACK_ID, new Intent[]{intent2}, new String[]{resolvedType}, 1342177280, null);
                        Intent newIntent = new Intent();
                        if (requestCode >= 0) {
                            newIntent.putExtra("has_result", true);
                        }
                        newIntent.putExtra("intent", new IntentSender(target));
                        if (this.mService.mHeavyWeightProcess.activities.size() > 0) {
                            ActivityRecord hist = (ActivityRecord) this.mService.mHeavyWeightProcess.activities.get(HOME_STACK_ID);
                            newIntent.putExtra("cur_app", hist.packageName);
                            newIntent.putExtra("cur_task", hist.task.taskId);
                        }
                        newIntent.putExtra("new_app", aInfo2.packageName);
                        newIntent.setFlags(intent2.getFlags());
                        newIntent.setClassName("android", HeavyWeightSwitcherActivity.class.getName());
                        intent = newIntent;
                        resolvedType = null;
                        caller = null;
                        try {
                            callingUid = Binder.getCallingUid();
                            callingPid = Binder.getCallingPid();
                            componentSpecified = true;
                            try {
                                ResolveInfo rInfo = AppGlobals.getPackageManager().resolveIntent(intent, null, 66560, userId);
                                try {
                                    aInfo = this.mService.getActivityInfoForUser(rInfo != null ? rInfo.activityInfo : null, userId);
                                } catch (RemoteException e) {
                                    aInfo = null;
                                    res = startActivityLocked(caller, intent, resolvedType, aInfo, voiceSession, voiceInteractor, resultTo, resultWho, requestCode, callingPid, callingUid, callingPackage, realCallingPid, realCallingUid, startFlags, options, componentSpecified, null, container, inTask);
                                    Binder.restoreCallingIdentity(origId);
                                    if (stack.mConfigWillChange) {
                                        this.mService.enforceCallingPermission("android.permission.CHANGE_CONFIGURATION", "updateConfiguration()");
                                        stack.mConfigWillChange = VALIDATE_WAKE_LOCK_CALLER;
                                        this.mService.updateConfigurationLocked(config, null, VALIDATE_WAKE_LOCK_CALLER, VALIDATE_WAKE_LOCK_CALLER);
                                    }
                                    if (outResult != null) {
                                        outResult.result = res;
                                        if (res == 0) {
                                            if (res == 2) {
                                                r = stack.topRunningActivityLocked(null);
                                                if (r.nowVisible) {
                                                }
                                                outResult.thisTime = SystemClock.uptimeMillis();
                                                this.mWaitingActivityVisible.add(outResult);
                                                do {
                                                    try {
                                                        this.mService.wait();
                                                    } catch (InterruptedException e2) {
                                                    }
                                                    if (!outResult.timeout) {
                                                        break;
                                                    }
                                                } while (outResult.who == null);
                                            }
                                        } else {
                                            this.mWaitingActivityLaunched.add(outResult);
                                            do {
                                                try {
                                                    this.mService.wait();
                                                } catch (InterruptedException e3) {
                                                }
                                                if (!outResult.timeout) {
                                                    break;
                                                }
                                            } while (outResult.who == null);
                                        }
                                    }
                                    return res;
                                }
                            } catch (RemoteException e4) {
                                aInfo = aInfo2;
                                aInfo = null;
                                res = startActivityLocked(caller, intent, resolvedType, aInfo, voiceSession, voiceInteractor, resultTo, resultWho, requestCode, callingPid, callingUid, callingPackage, realCallingPid, realCallingUid, startFlags, options, componentSpecified, null, container, inTask);
                                Binder.restoreCallingIdentity(origId);
                                if (stack.mConfigWillChange) {
                                    this.mService.enforceCallingPermission("android.permission.CHANGE_CONFIGURATION", "updateConfiguration()");
                                    stack.mConfigWillChange = VALIDATE_WAKE_LOCK_CALLER;
                                    this.mService.updateConfigurationLocked(config, null, VALIDATE_WAKE_LOCK_CALLER, VALIDATE_WAKE_LOCK_CALLER);
                                }
                                if (outResult != null) {
                                    outResult.result = res;
                                    if (res == 0) {
                                        this.mWaitingActivityLaunched.add(outResult);
                                        do {
                                            this.mService.wait();
                                            if (!outResult.timeout) {
                                                break;
                                            }
                                        } while (outResult.who == null);
                                    } else if (res == 2) {
                                        r = stack.topRunningActivityLocked(null);
                                        if (r.nowVisible) {
                                        }
                                        outResult.thisTime = SystemClock.uptimeMillis();
                                        this.mWaitingActivityVisible.add(outResult);
                                        do {
                                            this.mService.wait();
                                            if (!outResult.timeout) {
                                                break;
                                            }
                                        } while (outResult.who == null);
                                    }
                                }
                                return res;
                            }
                        } catch (Throwable th2) {
                            th = th2;
                            aInfo = aInfo2;
                            throw th;
                        }
                    }
                    try {
                        res = startActivityLocked(caller, intent, resolvedType, aInfo, voiceSession, voiceInteractor, resultTo, resultWho, requestCode, callingPid, callingUid, callingPackage, realCallingPid, realCallingUid, startFlags, options, componentSpecified, null, container, inTask);
                        Binder.restoreCallingIdentity(origId);
                        if (stack.mConfigWillChange) {
                            this.mService.enforceCallingPermission("android.permission.CHANGE_CONFIGURATION", "updateConfiguration()");
                            stack.mConfigWillChange = VALIDATE_WAKE_LOCK_CALLER;
                            this.mService.updateConfigurationLocked(config, null, VALIDATE_WAKE_LOCK_CALLER, VALIDATE_WAKE_LOCK_CALLER);
                        }
                        if (outResult != null) {
                            outResult.result = res;
                            if (res == 0) {
                                this.mWaitingActivityLaunched.add(outResult);
                                do {
                                    this.mService.wait();
                                    if (!outResult.timeout) {
                                        break;
                                    }
                                } while (outResult.who == null);
                            } else if (res == 2) {
                                r = stack.topRunningActivityLocked(null);
                                if (r.nowVisible || r.state != ActivityState.RESUMED) {
                                    outResult.thisTime = SystemClock.uptimeMillis();
                                    this.mWaitingActivityVisible.add(outResult);
                                    do {
                                        this.mService.wait();
                                        if (!outResult.timeout) {
                                            break;
                                        }
                                    } while (outResult.who == null);
                                } else {
                                    outResult.timeout = VALIDATE_WAKE_LOCK_CALLER;
                                    outResult.who = new ComponentName(r.info.packageName, r.info.name);
                                    outResult.totalTime = 0;
                                    outResult.thisTime = 0;
                                }
                            }
                        }
                        return res;
                    } catch (Throwable th3) {
                        th = th3;
                    }
                } catch (Throwable th4) {
                    th = th4;
                    aInfo = aInfo2;
                    intent = intent2;
                    throw th;
                }
            }
        }
        throw new IllegalArgumentException("File descriptors passed in Intent");
    }

    final int startActivities(IApplicationThread caller, int callingUid, String callingPackage, Intent[] intents, String[] resolvedTypes, IBinder resultTo, Bundle options, int userId) {
        if (intents == null) {
            throw new NullPointerException("intents is null");
        } else if (resolvedTypes == null) {
            throw new NullPointerException("resolvedTypes is null");
        } else if (intents.length != resolvedTypes.length) {
            throw new IllegalArgumentException("intents are length different than resolvedTypes");
        } else {
            int callingPid;
            if (callingUid >= 0) {
                callingPid = -1;
            } else if (caller == null) {
                callingPid = Binder.getCallingPid();
                callingUid = Binder.getCallingUid();
            } else {
                callingUid = -1;
                callingPid = -1;
            }
            long origId = Binder.clearCallingIdentity();
            try {
                synchronized (this.mService) {
                    ActivityRecord[] outActivity = new ActivityRecord[1];
                    int i = HOME_STACK_ID;
                    while (i < intents.length) {
                        Intent intent = intents[i];
                        if (intent == null) {
                        } else {
                            if (intent != null) {
                                if (intent.hasFileDescriptors()) {
                                    throw new IllegalArgumentException("File descriptors passed in Intent");
                                }
                            }
                            boolean componentSpecified = intent.getComponent() != null ? true : VALIDATE_WAKE_LOCK_CALLER;
                            Intent intent2 = new Intent(intent);
                            ActivityInfo aInfo = this.mService.getActivityInfoForUser(resolveActivity(intent2, resolvedTypes[i], HOME_STACK_ID, null, userId), userId);
                            if (aInfo == null || (aInfo.applicationInfo.flags & 268435456) == 0) {
                                Bundle theseOptions;
                                if (options == null || i != intents.length - 1) {
                                    theseOptions = null;
                                } else {
                                    theseOptions = options;
                                }
                                int res = startActivityLocked(caller, intent2, resolvedTypes[i], aInfo, null, null, resultTo, null, -1, callingPid, callingUid, callingPackage, callingPid, callingUid, HOME_STACK_ID, theseOptions, componentSpecified, outActivity, null, null);
                                if (res < 0) {
                                    return res;
                                }
                                resultTo = outActivity[HOME_STACK_ID] != null ? outActivity[HOME_STACK_ID].appToken : null;
                            } else {
                                throw new IllegalArgumentException("FLAG_CANT_SAVE_STATE not supported here");
                            }
                        }
                        i++;
                    }
                    Binder.restoreCallingIdentity(origId);
                    return HOME_STACK_ID;
                }
            } finally {
                Binder.restoreCallingIdentity(origId);
            }
        }
    }

    final boolean realStartActivityLocked(ActivityRecord r, ProcessRecord app, boolean andResume, boolean checkConfig) throws RemoteException {
        r.startFreezingScreenLocked(app, HOME_STACK_ID);
        this.mWindowManager.setAppVisibility(r.appToken, true);
        r.startLaunchTickingLocked();
        if (checkConfig) {
            this.mService.updateConfigurationLocked(this.mWindowManager.updateOrientationFromAppTokens(this.mService.mConfiguration, r.mayFreezeScreenLocked(app) ? r.appToken : null), r, VALIDATE_WAKE_LOCK_CALLER, VALIDATE_WAKE_LOCK_CALLER);
        }
        r.app = app;
        app.waitingToKill = null;
        r.launchCount++;
        r.lastLaunchTime = SystemClock.uptimeMillis();
        if (app.activities.indexOf(r) < 0) {
            app.activities.add(r);
        }
        this.mService.updateLruProcessLocked(app, true, null);
        this.mService.updateOomAdjLocked();
        ActivityStack stack = r.task.stack;
        try {
            if (app.thread == null) {
                throw new RemoteException();
            }
            ProfilerInfo profilerInfo;
            List<ResultInfo> results = null;
            List<ReferrerIntent> newIntents = null;
            if (andResume) {
                results = r.results;
                newIntents = r.newIntents;
            }
            if (andResume) {
                EventLog.writeEvent(EventLogTags.AM_RESTART_ACTIVITY, new Object[]{Integer.valueOf(r.userId), Integer.valueOf(System.identityHashCode(r)), Integer.valueOf(r.task.taskId), r.shortComponentName});
            }
            if (r.isHomeActivity() && r.isNotResolverActivity()) {
                this.mService.mHomeProcess = ((ActivityRecord) r.task.mActivities.get(HOME_STACK_ID)).app;
            }
            this.mService.ensurePackageDexOpt(r.intent.getComponent().getPackageName());
            r.sleeping = VALIDATE_WAKE_LOCK_CALLER;
            r.forceNewConfig = VALIDATE_WAKE_LOCK_CALLER;
            this.mService.showAskCompatModeDialogLocked(r);
            r.compat = this.mService.compatibilityInfoForPackageLocked(r.info.applicationInfo);
            String profileFile = null;
            ParcelFileDescriptor profileFd = null;
            if (this.mService.mProfileApp != null && this.mService.mProfileApp.equals(app.processName) && (this.mService.mProfileProc == null || this.mService.mProfileProc == app)) {
                this.mService.mProfileProc = app;
                profileFile = this.mService.mProfileFile;
                profileFd = this.mService.mProfileFd;
            }
            app.hasShownUi = true;
            app.pendingUiClean = true;
            if (profileFd != null) {
                try {
                    profileFd = profileFd.dup();
                } catch (IOException e) {
                    if (profileFd != null) {
                        try {
                            profileFd.close();
                        } catch (IOException e2) {
                        }
                        profileFd = null;
                    }
                }
            }
            if (profileFile != null) {
                ProfilerInfo profilerInfo2 = new ProfilerInfo(profileFile, profileFd, this.mService.mSamplingInterval, this.mService.mAutoStopProfiler);
            } else {
                profilerInfo = null;
            }
            app.forceProcessStateUpTo(2);
            app.thread.scheduleLaunchActivity(new Intent(r.intent), r.appToken, System.identityHashCode(r), r.info, new Configuration(this.mService.mConfiguration), r.compat, r.launchedFromPackage, r.task.voiceInteractor, app.repProcState, r.icicle, r.persistentState, results, newIntents, !andResume ? true : VALIDATE_WAKE_LOCK_CALLER, this.mService.isNextTransitionForward(), profilerInfo);
            if ((app.info.flags & 268435456) != 0 && app.processName.equals(app.info.packageName)) {
                if (!(this.mService.mHeavyWeightProcess == null || this.mService.mHeavyWeightProcess == app)) {
                    Slog.w("ActivityManager", "Starting new heavy weight process " + app + " when already running " + this.mService.mHeavyWeightProcess);
                }
                this.mService.mHeavyWeightProcess = app;
                Message msg = this.mService.mHandler.obtainMessage(24);
                msg.obj = r;
                this.mService.mHandler.sendMessage(msg);
            }
            r.launchFailed = VALIDATE_WAKE_LOCK_CALLER;
            if (stack.updateLRUListLocked(r)) {
                Slog.w("ActivityManager", "Activity " + r + " being launched, but already in LRU list");
            }
            if (andResume) {
                stack.minimalResumeActivityLocked(r);
            } else {
                r.state = ActivityState.STOPPED;
                r.stopped = true;
            }
            if (isFrontStack(stack)) {
                this.mService.startSetupActivityLocked();
            }
            this.mService.mServices.updateServiceConnectionActivitiesLocked(r.app);
            return true;
        } catch (Throwable e3) {
            if (r.launchFailed) {
                Slog.e("ActivityManager", "Second failure launching " + r.intent.getComponent().flattenToShortString() + ", giving up", e3);
                this.mService.appDiedLocked(app);
                stack.requestFinishActivityLocked(r.appToken, HOME_STACK_ID, null, "2nd-crash", VALIDATE_WAKE_LOCK_CALLER);
                return VALIDATE_WAKE_LOCK_CALLER;
            }
            app.activities.remove(r);
            throw e3;
        }
    }

    void startSpecificActivityLocked(ActivityRecord r, boolean andResume, boolean checkConfig) {
        ProcessRecord app = this.mService.getProcessRecordLocked(r.processName, r.info.applicationInfo.uid, true);
        r.task.stack.setLaunchTime(r);
        if (!(app == null || app.thread == null)) {
            try {
                if ((r.info.flags & 1) == 0 || !"android".equals(r.info.packageName)) {
                    app.addPackage(r.info.packageName, r.info.applicationInfo.versionCode, this.mService.mProcessStats);
                }
                realStartActivityLocked(r, app, andResume, checkConfig);
                return;
            } catch (RemoteException e) {
                Slog.w("ActivityManager", "Exception when starting activity " + r.intent.getComponent().flattenToShortString(), e);
            }
        }
        this.mService.startProcessLocked(r.processName, r.info.applicationInfo, true, HOME_STACK_ID, "activity", r.intent.getComponent(), VALIDATE_WAKE_LOCK_CALLER, VALIDATE_WAKE_LOCK_CALLER, true);
    }

    final int startActivityLocked(IApplicationThread caller, Intent intent, String resolvedType, ActivityInfo aInfo, IVoiceInteractionSession voiceSession, IVoiceInteractor voiceInteractor, IBinder resultTo, String resultWho, int requestCode, int callingPid, int callingUid, String callingPackage, int realCallingPid, int realCallingUid, int startFlags, Bundle options, boolean componentSpecified, ActivityRecord[] outActivity, ActivityContainer container, TaskRecord inTask) {
        ActivityStack resultStack;
        int err = HOME_STACK_ID;
        ProcessRecord callerApp = null;
        if (caller != null) {
            callerApp = this.mService.getRecordForAppLocked(caller);
            if (callerApp != null) {
                callingPid = callerApp.pid;
                callingUid = callerApp.info.uid;
            } else {
                Slog.w("ActivityManager", "Unable to find app for caller " + caller + " (pid=" + callingPid + ") when starting: " + intent.toString());
                err = -4;
            }
        }
        if (err == 0) {
            String str = "ActivityManager";
            StringBuilder append = new StringBuilder().append("START u").append(aInfo != null ? UserHandle.getUserId(aInfo.applicationInfo.uid) : HOME_STACK_ID).append(" {").append(intent.toShortString(true, true, true, VALIDATE_WAKE_LOCK_CALLER)).append("} from uid ").append(callingUid).append(" on display ");
            int i = container == null ? this.mFocusedStack == null ? HOME_STACK_ID : this.mFocusedStack.mDisplayId : container.mActivityDisplay == null ? HOME_STACK_ID : container.mActivityDisplay.mDisplayId;
            Slog.i(str, append.append(i).toString());
        }
        ActivityRecord sourceRecord = null;
        ActivityRecord resultRecord = null;
        if (resultTo != null) {
            sourceRecord = isInAnyStackLocked(resultTo);
            if (!(sourceRecord == null || requestCode < 0 || sourceRecord.finishing)) {
                resultRecord = sourceRecord;
            }
        }
        int launchFlags = intent.getFlags();
        if (!((33554432 & launchFlags) == 0 || sourceRecord == null)) {
            if (requestCode >= 0) {
                ActivityOptions.abort(options);
                return -3;
            }
            resultRecord = sourceRecord.resultTo;
            resultWho = sourceRecord.resultWho;
            requestCode = sourceRecord.requestCode;
            sourceRecord.resultTo = null;
            if (resultRecord != null) {
                resultRecord.removeResultsLocked(sourceRecord, resultWho, requestCode);
            }
            if (sourceRecord.launchedFromUid == callingUid) {
                callingPackage = sourceRecord.launchedFromPackage;
            }
        }
        if (err == 0 && intent.getComponent() == null) {
            err = -1;
        }
        if (err == 0 && aInfo == null) {
            err = -2;
        }
        if (!(err != 0 || sourceRecord == null || sourceRecord.task.voiceSession == null || (268435456 & launchFlags) != 0 || sourceRecord.info.applicationInfo.uid == aInfo.applicationInfo.uid)) {
            try {
                if (!AppGlobals.getPackageManager().activitySupportsIntent(intent.getComponent(), intent, resolvedType)) {
                    err = -7;
                }
            } catch (RemoteException e) {
                err = -7;
            }
        }
        if (err == 0 && voiceSession != null) {
            try {
                if (!AppGlobals.getPackageManager().activitySupportsIntent(intent.getComponent(), intent, resolvedType)) {
                    err = -7;
                }
            } catch (RemoteException e2) {
                err = -7;
            }
        }
        if (resultRecord == null) {
            resultStack = null;
        } else {
            resultStack = resultRecord.task.stack;
        }
        if (err != 0) {
            if (resultRecord != null) {
                resultStack.sendActivityResultLocked(-1, resultRecord, resultWho, requestCode, HOME_STACK_ID, null);
            }
            ActivityOptions.abort(options);
            return err;
        }
        int startAnyPerm = this.mService.checkPermission("android.permission.START_ANY_ACTIVITY", callingPid, callingUid);
        int componentPerm = this.mService.checkComponentPermission(aInfo.permission, callingPid, callingUid, aInfo.applicationInfo.uid, aInfo.exported);
        if (startAnyPerm == 0 || componentPerm == 0) {
            boolean abort = !this.mService.mIntentFirewall.checkStartActivity(intent, callingUid, callingPid, resolvedType, aInfo.applicationInfo) ? true : VALIDATE_WAKE_LOCK_CALLER;
            if (this.mService.mController != null) {
                try {
                    abort |= !this.mService.mController.activityStarting(intent.cloneFilter(), aInfo.applicationInfo.packageName) ? 1 : HOME_STACK_ID;
                } catch (RemoteException e3) {
                    this.mService.mController = null;
                }
            }
            if (abort) {
                if (resultRecord != null) {
                    resultStack.sendActivityResultLocked(-1, resultRecord, resultWho, requestCode, HOME_STACK_ID, null);
                }
                ActivityOptions.abort(options);
                return HOME_STACK_ID;
            }
            ActivityRecord r = new ActivityRecord(this.mService, callerApp, callingUid, callingPackage, intent, resolvedType, aInfo, this.mService.mConfiguration, resultRecord, resultWho, requestCode, componentSpecified, this, container, options);
            if (outActivity != null) {
                outActivity[HOME_STACK_ID] = r;
            }
            ActivityStack stack = getFocusedStack();
            if (voiceSession == null && (stack.mResumedActivity == null || stack.mResumedActivity.info.applicationInfo.uid != callingUid)) {
                if (!this.mService.checkAppSwitchAllowedLocked(callingPid, callingUid, realCallingPid, realCallingUid, "Activity start")) {
                    this.mPendingActivityLaunches.add(new PendingActivityLaunch(r, sourceRecord, startFlags, stack));
                    ActivityOptions.abort(options);
                    return 4;
                }
            }
            if (this.mService.mDidAppSwitch) {
                this.mService.mAppSwitchesAllowedTime = 0;
            } else {
                this.mService.mDidAppSwitch = true;
            }
            doPendingActivityLaunchesLocked(VALIDATE_WAKE_LOCK_CALLER);
            err = startActivityUncheckedLocked(r, sourceRecord, voiceSession, voiceInteractor, startFlags, true, options, inTask);
            if (err < 0) {
                notifyActivityDrawnForKeyguard();
            }
            return err;
        }
        String msg;
        if (resultRecord != null) {
            resultStack.sendActivityResultLocked(-1, resultRecord, resultWho, requestCode, HOME_STACK_ID, null);
        }
        if (aInfo.exported) {
            msg = "Permission Denial: starting " + intent.toString() + " from " + callerApp + " (pid=" + callingPid + ", uid=" + callingUid + ")" + " requires " + aInfo.permission;
        } else {
            msg = "Permission Denial: starting " + intent.toString() + " from " + callerApp + " (pid=" + callingPid + ", uid=" + callingUid + ")" + " not exported from uid " + aInfo.applicationInfo.uid;
        }
        Slog.w("ActivityManager", msg);
        throw new SecurityException(msg);
    }

    ActivityStack adjustStackFocus(ActivityRecord r, boolean newTask) {
        TaskRecord task = r.task;
        if (this.mLeanbackOnlyDevice || (!r.isApplicationActivity() && (task == null || !task.isApplicationTask()))) {
            return this.mHomeStack;
        }
        if (task != null) {
            ActivityStack taskStack = task.stack;
            if (!taskStack.isOnHomeDisplay() || this.mFocusedStack == taskStack) {
                return taskStack;
            }
            this.mFocusedStack = taskStack;
            return taskStack;
        }
        ActivityContainer container = r.mInitialActivityContainer;
        if (container != null) {
            r.mInitialActivityContainer = null;
            return container.mStack;
        } else if (this.mFocusedStack != this.mHomeStack && (!newTask || this.mFocusedStack.mActivityContainer.isEligibleForNewTasks())) {
            return this.mFocusedStack;
        } else {
            ArrayList<ActivityStack> homeDisplayStacks = this.mHomeStack.mStacks;
            int stackNdx = homeDisplayStacks.size() - 1;
            while (stackNdx >= 0) {
                ActivityStack stack = (ActivityStack) homeDisplayStacks.get(stackNdx);
                if (stack.isHomeStack()) {
                    stackNdx--;
                } else {
                    this.mFocusedStack = stack;
                    return this.mFocusedStack;
                }
            }
            this.mFocusedStack = getStack(createStackOnDisplay(getNextStackId(), HOME_STACK_ID));
            return this.mFocusedStack;
        }
    }

    void setFocusedStack(ActivityRecord r, String reason) {
        if (r != null) {
            boolean isHomeActivity;
            TaskRecord task = r.task;
            if (r.isApplicationActivity()) {
                isHomeActivity = VALIDATE_WAKE_LOCK_CALLER;
            } else {
                isHomeActivity = true;
            }
            if (!(isHomeActivity || task == null)) {
                if (task.isApplicationTask()) {
                    isHomeActivity = VALIDATE_WAKE_LOCK_CALLER;
                } else {
                    isHomeActivity = true;
                }
            }
            if (!(isHomeActivity || task == null)) {
                ActivityRecord parent = task.stack.mActivityContainer.mParentActivity;
                if (parent == null || !parent.isHomeActivity()) {
                    isHomeActivity = VALIDATE_WAKE_LOCK_CALLER;
                } else {
                    isHomeActivity = true;
                }
            }
            moveHomeStack(isHomeActivity, reason);
        }
    }

    final int startActivityUncheckedLocked(ActivityRecord r, ActivityRecord sourceRecord, IVoiceInteractionSession voiceSession, IVoiceInteractor voiceInteractor, int startFlags, boolean doResume, Bundle options, TaskRecord inTask) {
        ActivityStack targetStack;
        ActivityRecord top;
        Intent intent = r.intent;
        int callingUid = r.launchedFromUid;
        if (!(inTask == null || inTask.inRecents)) {
            Slog.w("ActivityManager", "Starting activity in task not in recents: " + inTask);
            inTask = null;
        }
        boolean launchSingleTop = r.launchMode == 1 ? true : VALIDATE_WAKE_LOCK_CALLER;
        boolean launchSingleInstance = r.launchMode == 3 ? true : VALIDATE_WAKE_LOCK_CALLER;
        boolean launchSingleTask = r.launchMode == 2 ? true : VALIDATE_WAKE_LOCK_CALLER;
        int launchFlags = intent.getFlags();
        if ((524288 & launchFlags) == 0 || !(launchSingleInstance || launchSingleTask)) {
            switch (r.info.documentLaunchMode) {
                case HOME_STACK_ID /*0*/:
                    break;
                case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
                    launchFlags |= 524288;
                    break;
                case C0569H.REPORT_FOCUS_CHANGE /*2*/:
                    launchFlags |= 524288;
                    break;
                case C0569H.REPORT_LOSING_FOCUS /*3*/:
                    launchFlags &= -134217729;
                    break;
                default:
                    break;
            }
        }
        Slog.i("ActivityManager", "Ignoring FLAG_ACTIVITY_NEW_DOCUMENT, launchMode is \"singleInstance\" or \"singleTask\"");
        launchFlags &= -134742017;
        boolean launchTaskBehind = (!r.mLaunchTaskBehind || launchSingleTask || launchSingleInstance || (524288 & launchFlags) == 0) ? VALIDATE_WAKE_LOCK_CALLER : true;
        if (!(r.resultTo == null || (268435456 & launchFlags) == 0)) {
            Slog.w("ActivityManager", "Activity is launching as a new task, so cancelling activity result.");
            r.resultTo.task.stack.sendActivityResultLocked(-1, r.resultTo, r.resultWho, r.requestCode, HOME_STACK_ID, null);
            r.resultTo = null;
        }
        if ((524288 & launchFlags) != 0 && r.resultTo == null) {
            launchFlags |= 268435456;
        }
        if ((268435456 & launchFlags) != 0 && (launchTaskBehind || r.info.documentLaunchMode == 2)) {
            launchFlags |= 134217728;
        }
        this.mUserLeaving = (262144 & launchFlags) == 0 ? true : VALIDATE_WAKE_LOCK_CALLER;
        if (!doResume) {
            r.delayedResume = true;
        }
        ActivityRecord notTop = (16777216 & launchFlags) != 0 ? r : null;
        if ((startFlags & 1) != 0) {
            ActivityRecord checkedCaller = sourceRecord;
            if (checkedCaller == null) {
                checkedCaller = getFocusedStack().topRunningNonDelayedActivityLocked(notTop);
            }
            if (!checkedCaller.realActivity.equals(r.realActivity)) {
                startFlags &= -2;
            }
        }
        boolean z = VALIDATE_WAKE_LOCK_CALLER;
        TaskRecord taskRecord = null;
        if (sourceRecord != null || inTask == null || inTask.stack == null) {
            inTask = null;
        } else {
            Intent baseIntent = inTask.getBaseIntent();
            ActivityRecord root = inTask.getRootActivity();
            if (baseIntent == null) {
                ActivityOptions.abort(options);
                throw new IllegalArgumentException("Launching into task without base intent: " + inTask);
            }
            if (launchSingleInstance || launchSingleTask) {
                if (!baseIntent.getComponent().equals(r.intent.getComponent())) {
                    ActivityOptions.abort(options);
                    throw new IllegalArgumentException("Trying to launch singleInstance/Task " + r + " into different task " + inTask);
                } else if (root != null) {
                    ActivityOptions.abort(options);
                    throw new IllegalArgumentException("Caller with inTask " + inTask + " has root " + root + " but target is singleInstance/Task");
                }
            }
            if (root == null) {
                launchFlags = (-403185665 & launchFlags) | (baseIntent.getFlags() & 403185664);
                intent.setFlags(launchFlags);
                inTask.setIntent(r);
                z = true;
            } else if ((268435456 & launchFlags) != 0) {
                z = VALIDATE_WAKE_LOCK_CALLER;
            } else {
                z = true;
            }
            taskRecord = inTask;
        }
        if (inTask == null) {
            if (sourceRecord == null) {
                if ((268435456 & launchFlags) == 0 && inTask == null) {
                    Slog.w("ActivityManager", "startActivity called from non-Activity context; forcing Intent.FLAG_ACTIVITY_NEW_TASK for: " + intent);
                    launchFlags |= 268435456;
                }
            } else if (sourceRecord.launchMode == 3) {
                launchFlags |= 268435456;
            } else if (launchSingleInstance || launchSingleTask) {
                launchFlags |= 268435456;
            }
        }
        ActivityInfo newTaskInfo = null;
        Intent newTaskIntent = null;
        ActivityStack sourceStack;
        if (sourceRecord == null) {
            sourceStack = null;
        } else if (sourceRecord.finishing) {
            if ((268435456 & launchFlags) == 0) {
                Slog.w("ActivityManager", "startActivity called from finishing " + sourceRecord + "; forcing " + "Intent.FLAG_ACTIVITY_NEW_TASK for: " + intent);
                launchFlags |= 268435456;
                newTaskInfo = sourceRecord.info;
                newTaskIntent = sourceRecord.task.intent;
            }
            sourceRecord = null;
            sourceStack = null;
        } else {
            sourceStack = sourceRecord.task.stack;
        }
        boolean movedHome = VALIDATE_WAKE_LOCK_CALLER;
        intent.setFlags(launchFlags);
        if ((((268435456 & launchFlags) != 0 && (134217728 & launchFlags) == 0) || launchSingleInstance || launchSingleTask) && inTask == null && r.resultTo == null) {
            ActivityRecord intentActivity = !launchSingleInstance ? findTaskLocked(r) : findActivityLocked(intent, r.info);
            if (intentActivity != null) {
                if (isLockTaskModeViolation(intentActivity.task)) {
                    showLockTaskToast();
                    Slog.e("ActivityManager", "startActivityUnchecked: Attempt to violate Lock Task Mode");
                    return 5;
                }
                ActivityRecord curTop;
                if (r.task == null) {
                    r.task = intentActivity.task;
                }
                targetStack = intentActivity.task.stack;
                targetStack.mLastPausedActivity = null;
                targetStack.moveToFront("intentActivityFound");
                if (intentActivity.task.intent == null) {
                    intentActivity.task.setIntent(r);
                }
                ActivityStack lastStack = getLastStack();
                if (lastStack == null) {
                    curTop = null;
                } else {
                    curTop = lastStack.topRunningNonDelayedActivityLocked(notTop);
                }
                boolean movedToFront = VALIDATE_WAKE_LOCK_CALLER;
                if (!(curTop == null || (curTop.task == intentActivity.task && curTop.task == lastStack.topTask()))) {
                    r.intent.addFlags(4194304);
                    if (sourceRecord == null || (sourceStack.topActivity() != null && sourceStack.topActivity().task == sourceRecord.task)) {
                        if (launchTaskBehind && sourceRecord != null) {
                            intentActivity.setTaskToAffiliateWith(sourceRecord.task);
                        }
                        movedHome = true;
                        targetStack.moveTaskToFrontLocked(intentActivity.task, r, options, "bringingFoundTaskToFront");
                        if ((268451840 & launchFlags) == 268451840) {
                            intentActivity.task.setTaskToReturnTo(1);
                        }
                        options = null;
                        movedToFront = true;
                    }
                }
                if ((2097152 & launchFlags) != 0) {
                    intentActivity = targetStack.resetTaskIfNeededLocked(intentActivity, r);
                }
                if ((startFlags & 1) != 0) {
                    if (doResume) {
                        resumeTopActivitiesLocked(targetStack, null, options);
                        if (!movedToFront) {
                            notifyActivityDrawnForKeyguard();
                        }
                    } else {
                        ActivityOptions.abort(options);
                    }
                    return 1;
                }
                if ((268468224 & launchFlags) == 268468224) {
                    taskRecord = intentActivity.task;
                    taskRecord.performClearTaskLocked();
                    taskRecord.setIntent(r);
                } else if ((67108864 & launchFlags) != 0 || launchSingleInstance || launchSingleTask) {
                    top = intentActivity.task.performClearTaskLocked(r, launchFlags);
                    if (top != null) {
                        if (top.frontOfTask) {
                            top.task.setIntent(r);
                        }
                        ActivityStack.logStartActivity(EventLogTags.AM_NEW_INTENT, r, top.task);
                        top.deliverNewIntentLocked(callingUid, r.intent, r.launchedFromPackage);
                    } else {
                        z = true;
                        sourceRecord = intentActivity;
                    }
                } else if (r.realActivity.equals(intentActivity.task.realActivity)) {
                    if (((536870912 & launchFlags) != 0 || launchSingleTop) && intentActivity.realActivity.equals(r.realActivity)) {
                        ActivityStack.logStartActivity(EventLogTags.AM_NEW_INTENT, r, intentActivity.task);
                        if (intentActivity.frontOfTask) {
                            intentActivity.task.setIntent(r);
                        }
                        intentActivity.deliverNewIntentLocked(callingUid, r.intent, r.launchedFromPackage);
                    } else if (!r.intent.filterEquals(intentActivity.task.intent)) {
                        z = true;
                        sourceRecord = intentActivity;
                    }
                } else if ((2097152 & launchFlags) == 0) {
                    z = true;
                    sourceRecord = intentActivity;
                } else if (!intentActivity.task.rootWasReset) {
                    intentActivity.task.setIntent(r);
                }
                if (!z && reuseTask == null) {
                    if (doResume) {
                        targetStack.resumeTopActivityLocked(null, options);
                        if (!movedToFront) {
                            notifyActivityDrawnForKeyguard();
                        }
                    } else {
                        ActivityOptions.abort(options);
                    }
                    return 2;
                }
            }
        }
        if (r.packageName != null) {
            ActivityStack topStack = getFocusedStack();
            top = topStack.topRunningNonDelayedActivityLocked(notTop);
            if (top != null && r.resultTo == null && top.realActivity.equals(r.realActivity) && top.userId == r.userId && top.app != null && top.app.thread != null && ((536870912 & launchFlags) != 0 || launchSingleTop || launchSingleTask)) {
                ActivityStack.logStartActivity(EventLogTags.AM_NEW_INTENT, top, top.task);
                topStack.mLastPausedActivity = null;
                if (doResume) {
                    resumeTopActivitiesLocked();
                }
                ActivityOptions.abort(options);
                if ((startFlags & 1) != 0) {
                    return 1;
                }
                top.deliverNewIntentLocked(callingUid, r.intent, r.launchedFromPackage);
                return 3;
            }
            boolean newTask = VALIDATE_WAKE_LOCK_CALLER;
            boolean keepCurTransition = VALIDATE_WAKE_LOCK_CALLER;
            TaskRecord taskToAffiliate = (!launchTaskBehind || sourceRecord == null) ? null : sourceRecord.task;
            if (r.resultTo != null || inTask != null || z || (268435456 & launchFlags) == 0) {
                if (sourceRecord != null) {
                    TaskRecord sourceTask = sourceRecord.task;
                    if (isLockTaskModeViolation(sourceTask)) {
                        Slog.e("ActivityManager", "Attempted Lock Task Mode violation r=" + r);
                        return 5;
                    }
                    targetStack = sourceTask.stack;
                    targetStack.moveToFront("sourceStackToFront");
                    if (targetStack.topTask() != sourceTask) {
                        targetStack.moveTaskToFrontLocked(sourceTask, r, options, "sourceTaskToFront");
                    }
                    if (!z && (67108864 & launchFlags) != 0) {
                        top = sourceTask.performClearTaskLocked(r, launchFlags);
                        keepCurTransition = true;
                        if (top != null) {
                            ActivityStack.logStartActivity(EventLogTags.AM_NEW_INTENT, r, top.task);
                            top.deliverNewIntentLocked(callingUid, r.intent, r.launchedFromPackage);
                            targetStack.mLastPausedActivity = null;
                            if (doResume) {
                                targetStack.resumeTopActivityLocked(null);
                            }
                            ActivityOptions.abort(options);
                            return 3;
                        }
                    } else if (!(z || (131072 & launchFlags) == 0)) {
                        top = sourceTask.findActivityInHistoryLocked(r);
                        if (top != null) {
                            TaskRecord task = top.task;
                            task.moveActivityToFrontLocked(top);
                            ActivityStack.logStartActivity(EventLogTags.AM_NEW_INTENT, r, task);
                            top.updateOptionsLocked(options);
                            top.deliverNewIntentLocked(callingUid, r.intent, r.launchedFromPackage);
                            targetStack.mLastPausedActivity = null;
                            if (doResume) {
                                targetStack.resumeTopActivityLocked(null);
                            }
                            return 3;
                        }
                    }
                    r.setTask(sourceTask, null);
                } else if (inTask == null) {
                    TaskRecord taskRecord2;
                    targetStack = adjustStackFocus(r, VALIDATE_WAKE_LOCK_CALLER);
                    targetStack.moveToFront("addingToTopTask");
                    ActivityRecord prev = targetStack.topActivity();
                    if (prev != null) {
                        taskRecord2 = prev.task;
                    } else {
                        taskRecord2 = targetStack.createTaskRecord(getNextTaskId(), r.info, intent, null, null, true);
                    }
                    r.setTask(taskRecord2, null);
                    this.mWindowManager.moveTaskToTop(r.task.taskId);
                } else if (isLockTaskModeViolation(inTask)) {
                    Slog.e("ActivityManager", "Attempted Lock Task Mode violation r=" + r);
                    return 5;
                } else {
                    targetStack = inTask.stack;
                    targetStack.moveTaskToFrontLocked(inTask, r, options, "inTaskToFront");
                    top = inTask.getTopActivity();
                    if (top != null && top.realActivity.equals(r.realActivity) && top.userId == r.userId && ((536870912 & launchFlags) != 0 || launchSingleTop || launchSingleTask)) {
                        ActivityStack.logStartActivity(EventLogTags.AM_NEW_INTENT, top, top.task);
                        if ((startFlags & 1) != 0) {
                            return 1;
                        }
                        top.deliverNewIntentLocked(callingUid, r.intent, r.launchedFromPackage);
                        return 3;
                    } else if (z) {
                        r.setTask(inTask, null);
                    } else {
                        ActivityOptions.abort(options);
                        return 2;
                    }
                }
            } else if (isLockTaskModeViolation(taskRecord)) {
                Slog.e("ActivityManager", "Attempted Lock Task Mode violation r=" + r);
                return 5;
            } else {
                newTask = true;
                targetStack = adjustStackFocus(r, true);
                if (!launchTaskBehind) {
                    targetStack.moveToFront("startingNewTask");
                }
                if (taskRecord == null) {
                    r.setTask(targetStack.createTaskRecord(getNextTaskId(), newTaskInfo != null ? newTaskInfo : r.info, newTaskIntent != null ? newTaskIntent : intent, voiceSession, voiceInteractor, !launchTaskBehind ? true : VALIDATE_WAKE_LOCK_CALLER), taskToAffiliate);
                } else {
                    r.setTask(taskRecord, taskToAffiliate);
                }
                if (!movedHome && (268451840 & launchFlags) == 268451840) {
                    r.task.setTaskToReturnTo(1);
                }
            }
            this.mService.grantUriPermissionFromIntentLocked(callingUid, r.packageName, intent, r.getUriPermissionsLocked(), r.userId);
            if (sourceRecord != null && sourceRecord.isRecentsActivity()) {
                r.task.setTaskToReturnTo(2);
            }
            if (newTask) {
                EventLog.writeEvent(EventLogTags.AM_CREATE_TASK, new Object[]{Integer.valueOf(r.userId), Integer.valueOf(r.task.taskId)});
            }
            ActivityStack.logStartActivity(EventLogTags.AM_CREATE_ACTIVITY, r, r.task);
            targetStack.mLastPausedActivity = null;
            targetStack.startActivityLocked(r, newTask, doResume, keepCurTransition, options);
            if (!launchTaskBehind) {
                this.mService.setFocusedActivityLocked(r, "startedActivity");
            }
            return HOME_STACK_ID;
        }
        if (r.resultTo != null) {
            r.resultTo.task.stack.sendActivityResultLocked(-1, r.resultTo, r.resultWho, r.requestCode, HOME_STACK_ID, null);
        }
        ActivityOptions.abort(options);
        return -2;
    }

    final void doPendingActivityLaunchesLocked(boolean doResume) {
        while (!this.mPendingActivityLaunches.isEmpty()) {
            PendingActivityLaunch pal = (PendingActivityLaunch) this.mPendingActivityLaunches.remove(HOME_STACK_ID);
            ActivityRecord activityRecord = pal.f2r;
            ActivityRecord activityRecord2 = pal.sourceRecord;
            int i = pal.startFlags;
            boolean z = (doResume && this.mPendingActivityLaunches.isEmpty()) ? true : VALIDATE_WAKE_LOCK_CALLER;
            startActivityUncheckedLocked(activityRecord, activityRecord2, null, null, i, z, null, null);
        }
    }

    void removePendingActivityLaunchesLocked(ActivityStack stack) {
        for (int palNdx = this.mPendingActivityLaunches.size() - 1; palNdx >= 0; palNdx--) {
            if (((PendingActivityLaunch) this.mPendingActivityLaunches.get(palNdx)).stack == stack) {
                this.mPendingActivityLaunches.remove(palNdx);
            }
        }
    }

    void acquireLaunchWakelock() {
        this.mLaunchingActivity.acquire();
        if (!this.mHandler.hasMessages(LAUNCH_TIMEOUT_MSG)) {
            this.mHandler.sendEmptyMessageDelayed(LAUNCH_TIMEOUT_MSG, 10000);
        }
    }

    private boolean checkFinishBootingLocked() {
        boolean booting = this.mService.mBooting;
        boolean enableScreen = VALIDATE_WAKE_LOCK_CALLER;
        this.mService.mBooting = VALIDATE_WAKE_LOCK_CALLER;
        if (!this.mService.mBooted) {
            this.mService.mBooted = true;
            enableScreen = true;
        }
        if (booting || enableScreen) {
            this.mService.postFinishBooting(booting, enableScreen);
        }
        return booting;
    }

    final ActivityRecord activityIdleInternalLocked(IBinder token, boolean fromTimeout, Configuration config) {
        int i;
        ArrayList<ActivityRecord> finishes = null;
        ArrayList<UserStartedState> startingUsers = null;
        boolean booting = VALIDATE_WAKE_LOCK_CALLER;
        boolean activityRemoved = VALIDATE_WAKE_LOCK_CALLER;
        ActivityRecord r = ActivityRecord.forToken(token);
        if (r != null) {
            this.mHandler.removeMessages(IDLE_TIMEOUT_MSG, r);
            r.finishLaunchTickingLocked();
            if (fromTimeout) {
                reportActivityLaunchedLocked(fromTimeout, r, -1, -1);
            }
            if (config != null) {
                r.configuration = config;
            }
            r.idle = true;
            if (isFrontStack(r.task.stack) || fromTimeout) {
                booting = checkFinishBootingLocked();
            }
        }
        if (allResumedActivitiesIdle()) {
            if (r != null) {
                this.mService.scheduleAppGcsLocked();
            }
            if (this.mLaunchingActivity.isHeld()) {
                this.mHandler.removeMessages(LAUNCH_TIMEOUT_MSG);
                this.mLaunchingActivity.release();
            }
            ensureActivitiesVisibleLocked(null, HOME_STACK_ID);
        }
        ArrayList<ActivityRecord> stops = processStoppingActivitiesLocked(true);
        int NS = stops != null ? stops.size() : HOME_STACK_ID;
        int NF = this.mFinishingActivities.size();
        if (NF > 0) {
            finishes = new ArrayList(this.mFinishingActivities);
            this.mFinishingActivities.clear();
        }
        if (this.mStartingUsers.size() > 0) {
            ArrayList<UserStartedState> arrayList = new ArrayList(this.mStartingUsers);
            this.mStartingUsers.clear();
        }
        for (i = HOME_STACK_ID; i < NS; i++) {
            r = (ActivityRecord) stops.get(i);
            ActivityStack stack = r.task.stack;
            if (r.finishing) {
                stack.finishCurrentActivityLocked(r, HOME_STACK_ID, VALIDATE_WAKE_LOCK_CALLER);
            } else {
                stack.stopActivityLocked(r);
            }
        }
        for (i = HOME_STACK_ID; i < NF; i++) {
            r = (ActivityRecord) finishes.get(i);
            activityRemoved |= r.task.stack.destroyActivityLocked(r, true, "finish-idle");
        }
        if (!booting) {
            if (startingUsers != null) {
                for (i = HOME_STACK_ID; i < startingUsers.size(); i++) {
                    this.mService.finishUserSwitch((UserStartedState) startingUsers.get(i));
                }
            }
            if (this.mStartingBackgroundUsers.size() > 0) {
                arrayList = new ArrayList(this.mStartingBackgroundUsers);
                this.mStartingBackgroundUsers.clear();
                for (i = HOME_STACK_ID; i < arrayList.size(); i++) {
                    this.mService.finishUserBoot((UserStartedState) arrayList.get(i));
                }
            }
        }
        this.mService.trimApplications();
        if (activityRemoved) {
            resumeTopActivitiesLocked();
        }
        return r;
    }

    boolean handleAppDiedLocked(ProcessRecord app) {
        boolean hasVisibleActivities = VALIDATE_WAKE_LOCK_CALLER;
        for (int displayNdx = this.mActivityDisplays.size() - 1; displayNdx >= 0; displayNdx--) {
            ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
            for (int stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
                hasVisibleActivities |= ((ActivityStack) stacks.get(stackNdx)).handleAppDiedLocked(app);
            }
        }
        return hasVisibleActivities;
    }

    void closeSystemDialogsLocked() {
        for (int displayNdx = this.mActivityDisplays.size() - 1; displayNdx >= 0; displayNdx--) {
            ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
            for (int stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
                ((ActivityStack) stacks.get(stackNdx)).closeSystemDialogsLocked();
            }
        }
    }

    void removeUserLocked(int userId) {
        this.mUserStackInFront.delete(userId);
    }

    boolean forceStopPackageLocked(String name, boolean doit, boolean evenPersistent, int userId) {
        boolean didSomething = VALIDATE_WAKE_LOCK_CALLER;
        for (int displayNdx = this.mActivityDisplays.size() - 1; displayNdx >= 0; displayNdx--) {
            ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
            int numStacks = stacks.size();
            for (int stackNdx = HOME_STACK_ID; stackNdx < numStacks; stackNdx++) {
                if (((ActivityStack) stacks.get(stackNdx)).forceStopPackageLocked(name, doit, evenPersistent, userId)) {
                    didSomething = true;
                }
            }
        }
        return didSomething;
    }

    void updatePreviousProcessLocked(ActivityRecord r) {
        ProcessRecord fgApp = null;
        for (int displayNdx = this.mActivityDisplays.size() - 1; displayNdx >= 0; displayNdx--) {
            ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
            int stackNdx = stacks.size() - 1;
            while (stackNdx >= 0) {
                ActivityStack stack = (ActivityStack) stacks.get(stackNdx);
                if (isFrontStack(stack)) {
                    if (stack.mResumedActivity != null) {
                        fgApp = stack.mResumedActivity.app;
                    } else if (stack.mPausingActivity != null) {
                        fgApp = stack.mPausingActivity.app;
                    }
                } else {
                    stackNdx--;
                }
            }
        }
        if (r.app != null && fgApp != null && r.app != fgApp && r.lastVisibleTime > this.mService.mPreviousProcessVisibleTime && r.app != this.mService.mHomeProcess) {
            this.mService.mPreviousProcess = r.app;
            this.mService.mPreviousProcessVisibleTime = r.lastVisibleTime;
        }
    }

    boolean resumeTopActivitiesLocked() {
        return resumeTopActivitiesLocked(null, null, null);
    }

    boolean resumeTopActivitiesLocked(ActivityStack targetStack, ActivityRecord target, Bundle targetOptions) {
        if (targetStack == null) {
            targetStack = getFocusedStack();
        }
        boolean result = VALIDATE_WAKE_LOCK_CALLER;
        if (isFrontStack(targetStack)) {
            result = targetStack.resumeTopActivityLocked(target, targetOptions);
        }
        for (int displayNdx = this.mActivityDisplays.size() - 1; displayNdx >= 0; displayNdx--) {
            ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
            for (int stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
                ActivityStack stack = (ActivityStack) stacks.get(stackNdx);
                if (stack != targetStack && isFrontStack(stack)) {
                    stack.resumeTopActivityLocked(null);
                }
            }
        }
        return result;
    }

    void finishTopRunningActivityLocked(ProcessRecord app) {
        for (int displayNdx = this.mActivityDisplays.size() - 1; displayNdx >= 0; displayNdx--) {
            ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
            int numStacks = stacks.size();
            for (int stackNdx = HOME_STACK_ID; stackNdx < numStacks; stackNdx++) {
                ((ActivityStack) stacks.get(stackNdx)).finishTopRunningActivityLocked(app);
            }
        }
    }

    void finishVoiceTask(IVoiceInteractionSession session) {
        for (int displayNdx = this.mActivityDisplays.size() - 1; displayNdx >= 0; displayNdx--) {
            ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
            int numStacks = stacks.size();
            for (int stackNdx = HOME_STACK_ID; stackNdx < numStacks; stackNdx++) {
                ((ActivityStack) stacks.get(stackNdx)).finishVoiceTask(session);
            }
        }
    }

    void findTaskToMoveToFrontLocked(TaskRecord task, int flags, Bundle options, String reason) {
        if ((flags & 2) == 0) {
            this.mUserLeaving = true;
        }
        if ((flags & 1) != 0) {
            task.setTaskToReturnTo(1);
        }
        task.stack.moveTaskToFrontLocked(task, null, options, reason);
    }

    ActivityStack getStack(int stackId) {
        ActivityContainer activityContainer = (ActivityContainer) this.mActivityContainers.get(stackId);
        if (activityContainer != null) {
            return activityContainer.mStack;
        }
        return null;
    }

    ArrayList<ActivityStack> getStacks() {
        ArrayList<ActivityStack> allStacks = new ArrayList();
        for (int displayNdx = this.mActivityDisplays.size() - 1; displayNdx >= 0; displayNdx--) {
            allStacks.addAll(((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks);
        }
        return allStacks;
    }

    IBinder getHomeActivityToken() {
        ActivityRecord homeActivity = getHomeActivity();
        if (homeActivity != null) {
            return homeActivity.appToken;
        }
        return null;
    }

    ActivityRecord getHomeActivity() {
        ArrayList<TaskRecord> tasks = this.mHomeStack.getAllTasks();
        for (int taskNdx = tasks.size() - 1; taskNdx >= 0; taskNdx--) {
            TaskRecord task = (TaskRecord) tasks.get(taskNdx);
            if (task.isHomeTask()) {
                ArrayList<ActivityRecord> activities = task.mActivities;
                for (int activityNdx = activities.size() - 1; activityNdx >= 0; activityNdx--) {
                    ActivityRecord r = (ActivityRecord) activities.get(activityNdx);
                    if (r.isHomeActivity()) {
                        return r;
                    }
                }
                continue;
            }
        }
        return null;
    }

    ActivityContainer createActivityContainer(ActivityRecord parentActivity, IActivityContainerCallback callback) {
        ActivityContainer activityContainer = new VirtualActivityContainer(parentActivity, callback);
        this.mActivityContainers.put(activityContainer.mStackId, activityContainer);
        parentActivity.mChildContainers.add(activityContainer);
        return activityContainer;
    }

    void removeChildActivityContainers(ActivityRecord parentActivity) {
        ArrayList<ActivityContainer> childStacks = parentActivity.mChildContainers;
        for (int containerNdx = childStacks.size() - 1; containerNdx >= 0; containerNdx--) {
            ((ActivityContainer) childStacks.remove(containerNdx)).release();
        }
    }

    void deleteActivityContainer(IActivityContainer container) {
        ActivityContainer activityContainer = (ActivityContainer) container;
        if (activityContainer != null) {
            int stackId = activityContainer.mStackId;
            this.mActivityContainers.remove(stackId);
            this.mWindowManager.removeStack(stackId);
        }
    }

    private int createStackOnDisplay(int stackId, int displayId) {
        ActivityDisplay activityDisplay = (ActivityDisplay) this.mActivityDisplays.get(displayId);
        if (activityDisplay == null) {
            return -1;
        }
        ActivityContainer activityContainer = new ActivityContainer(stackId);
        this.mActivityContainers.put(stackId, activityContainer);
        activityContainer.attachToDisplayLocked(activityDisplay);
        return stackId;
    }

    int getNextStackId() {
        do {
            int i = this.mLastStackId + 1;
            this.mLastStackId = i;
            if (i <= 0) {
                this.mLastStackId = 1;
            }
        } while (getStack(this.mLastStackId) != null);
        return this.mLastStackId;
    }

    private boolean restoreRecentTaskLocked(TaskRecord task) {
        ActivityStack stack = null;
        if (this.mLeanbackOnlyDevice) {
            stack = this.mHomeStack;
        } else {
            ArrayList<ActivityStack> homeDisplayStacks = this.mHomeStack.mStacks;
            for (int stackNdx = homeDisplayStacks.size() - 1; stackNdx >= 0; stackNdx--) {
                ActivityStack tmpStack = (ActivityStack) homeDisplayStacks.get(stackNdx);
                if (!tmpStack.isHomeStack()) {
                    stack = tmpStack;
                    break;
                }
            }
        }
        if (stack == null) {
            stack = getStack(createStackOnDisplay(getNextStackId(), HOME_STACK_ID));
            moveHomeStack(true, "restoreRecentTask");
        }
        if (stack == null) {
            return VALIDATE_WAKE_LOCK_CALLER;
        }
        stack.addTask(task, VALIDATE_WAKE_LOCK_CALLER, VALIDATE_WAKE_LOCK_CALLER);
        ArrayList<ActivityRecord> activities = task.mActivities;
        for (int activityNdx = activities.size() - 1; activityNdx >= 0; activityNdx--) {
            ActivityRecord r = (ActivityRecord) activities.get(activityNdx);
            this.mWindowManager.addAppToken(HOME_STACK_ID, r.appToken, task.taskId, stack.mStackId, r.info.screenOrientation, r.fullscreen, (r.info.flags & DumpState.DUMP_PREFERRED_XML) != 0 ? true : VALIDATE_WAKE_LOCK_CALLER, r.userId, r.info.configChanges, task.voiceSession != null ? true : VALIDATE_WAKE_LOCK_CALLER, r.mLaunchTaskBehind);
        }
        return true;
    }

    void moveTaskToStackLocked(int taskId, int stackId, boolean toTop) {
        TaskRecord task = anyTaskForIdLocked(taskId);
        if (task != null) {
            ActivityStack stack = getStack(stackId);
            if (stack == null) {
                Slog.w("ActivityManager", "moveTaskToStack: no stack for id=" + stackId);
                return;
            }
            task.stack.removeTask(task, "moveTaskToStack");
            stack.addTask(task, toTop, true);
            this.mWindowManager.addTask(taskId, stackId, toTop);
            resumeTopActivitiesLocked();
        }
    }

    ActivityRecord findTaskLocked(ActivityRecord r) {
        for (int displayNdx = this.mActivityDisplays.size() - 1; displayNdx >= 0; displayNdx--) {
            ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
            for (int stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
                ActivityStack stack = (ActivityStack) stacks.get(stackNdx);
                if ((r.isApplicationActivity() || stack.isHomeStack()) && stack.mActivityContainer.isEligibleForNewTasks()) {
                    ActivityRecord ar = stack.findTaskLocked(r);
                    if (ar != null) {
                        return ar;
                    }
                }
            }
        }
        this.mPm.cpuBoost(2000000);
        BinderInternal.modifyDelayedGcParams();
        return null;
    }

    ActivityRecord findActivityLocked(Intent intent, ActivityInfo info) {
        for (int displayNdx = this.mActivityDisplays.size() - 1; displayNdx >= 0; displayNdx--) {
            ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
            for (int stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
                ActivityRecord ar = ((ActivityStack) stacks.get(stackNdx)).findActivityLocked(intent, info);
                if (ar != null) {
                    return ar;
                }
            }
        }
        return null;
    }

    void goingToSleepLocked() {
        scheduleSleepTimeout();
        if (!this.mGoingToSleep.isHeld()) {
            this.mGoingToSleep.acquire();
            if (this.mLaunchingActivity.isHeld()) {
                this.mLaunchingActivity.release();
                this.mService.mHandler.removeMessages(LAUNCH_TIMEOUT_MSG);
            }
        }
        checkReadyForSleepLocked();
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    boolean shutdownLocked(int r15) {
        /*
        r14 = this;
        r14.goingToSleepLocked();
        r8 = 0;
        r10 = java.lang.System.currentTimeMillis();
        r12 = (long) r15;
        r2 = r10 + r12;
    L_0x000b:
        r0 = 0;
        r9 = r14.mActivityDisplays;
        r9 = r9.size();
        r1 = r9 + -1;
    L_0x0014:
        if (r1 < 0) goto L_0x0039;
    L_0x0016:
        r9 = r14.mActivityDisplays;
        r9 = r9.valueAt(r1);
        r9 = (com.android.server.am.ActivityStackSupervisor.ActivityDisplay) r9;
        r5 = r9.mStacks;
        r9 = r5.size();
        r4 = r9 + -1;
    L_0x0026:
        if (r4 < 0) goto L_0x0036;
    L_0x0028:
        r9 = r5.get(r4);
        r9 = (com.android.server.am.ActivityStack) r9;
        r9 = r9.checkReadyForSleepLocked();
        r0 = r0 | r9;
        r4 = r4 + -1;
        goto L_0x0026;
    L_0x0036:
        r1 = r1 + -1;
        goto L_0x0014;
    L_0x0039:
        if (r0 == 0) goto L_0x0057;
    L_0x003b:
        r10 = java.lang.System.currentTimeMillis();
        r6 = r2 - r10;
        r10 = 0;
        r9 = (r6 > r10 ? 1 : (r6 == r10 ? 0 : -1));
        if (r9 <= 0) goto L_0x004f;
    L_0x0047:
        r9 = r14.mService;	 Catch:{ InterruptedException -> 0x004d }
        r9.wait(r6);	 Catch:{ InterruptedException -> 0x004d }
        goto L_0x000b;
    L_0x004d:
        r9 = move-exception;
        goto L_0x000b;
    L_0x004f:
        r9 = "ActivityManager";
        r10 = "Activity manager shutdown timed out";
        android.util.Slog.w(r9, r10);
        r8 = 1;
    L_0x0057:
        r9 = 1;
        r14.mSleepTimeout = r9;
        r14.checkReadyForSleepLocked();
        return r8;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.ActivityStackSupervisor.shutdownLocked(int):boolean");
    }

    void comeOutOfSleepIfNeededLocked() {
        removeSleepTimeouts();
        if (this.mGoingToSleep.isHeld()) {
            this.mGoingToSleep.release();
        }
        for (int displayNdx = this.mActivityDisplays.size() - 1; displayNdx >= 0; displayNdx--) {
            ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
            for (int stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
                ActivityStack stack = (ActivityStack) stacks.get(stackNdx);
                stack.awakeFromSleepingLocked();
                if (isFrontStack(stack)) {
                    resumeTopActivitiesLocked();
                }
            }
        }
        this.mGoingToSleepActivities.clear();
    }

    void activitySleptLocked(ActivityRecord r) {
        this.mGoingToSleepActivities.remove(r);
        checkReadyForSleepLocked();
    }

    void checkReadyForSleepLocked() {
        if (this.mService.isSleepingOrShuttingDown()) {
            int displayNdx;
            ArrayList<ActivityStack> stacks;
            int stackNdx;
            if (!this.mSleepTimeout) {
                boolean dontSleep = VALIDATE_WAKE_LOCK_CALLER;
                for (displayNdx = this.mActivityDisplays.size() - 1; displayNdx >= 0; displayNdx--) {
                    stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
                    for (stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
                        dontSleep |= ((ActivityStack) stacks.get(stackNdx)).checkReadyForSleepLocked();
                    }
                }
                if (this.mStoppingActivities.size() > 0) {
                    scheduleIdleLocked();
                    dontSleep = true;
                }
                if (this.mGoingToSleepActivities.size() > 0) {
                    dontSleep = true;
                }
                if (dontSleep) {
                    return;
                }
            }
            for (displayNdx = this.mActivityDisplays.size() - 1; displayNdx >= 0; displayNdx--) {
                stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
                for (stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
                    ((ActivityStack) stacks.get(stackNdx)).goToSleep();
                }
            }
            removeSleepTimeouts();
            if (this.mGoingToSleep.isHeld()) {
                this.mGoingToSleep.release();
            }
            if (this.mService.mShuttingDown) {
                this.mService.notifyAll();
            }
        }
    }

    boolean reportResumedActivityLocked(ActivityRecord r) {
        if (isFrontStack(r.task.stack)) {
            this.mService.updateUsageStats(r, true);
        }
        if (!allResumedActivitiesComplete()) {
            return VALIDATE_WAKE_LOCK_CALLER;
        }
        ensureActivitiesVisibleLocked(null, HOME_STACK_ID);
        this.mWindowManager.executeAppTransition();
        return true;
    }

    void handleAppCrashLocked(ProcessRecord app) {
        for (int displayNdx = this.mActivityDisplays.size() - 1; displayNdx >= 0; displayNdx--) {
            ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
            int numStacks = stacks.size();
            for (int stackNdx = HOME_STACK_ID; stackNdx < numStacks; stackNdx++) {
                ((ActivityStack) stacks.get(stackNdx)).handleAppCrashLocked(app);
            }
        }
    }

    boolean requestVisibleBehindLocked(ActivityRecord r, boolean visible) {
        ActivityRecord activityRecord = null;
        ActivityStack stack = r.task.stack;
        if (stack == null) {
            return VALIDATE_WAKE_LOCK_CALLER;
        }
        boolean isVisible = stack.hasVisibleBehindActivity();
        ActivityRecord top = topRunningActivityLocked();
        if (top == null || top == r || visible == isVisible) {
            if (!visible) {
                r = null;
            }
            stack.setVisibleBehindActivity(r);
            return true;
        } else if (visible && top.fullscreen) {
            return VALIDATE_WAKE_LOCK_CALLER;
        } else {
            if (!visible && stack.getVisibleBehindActivity() != r) {
                return VALIDATE_WAKE_LOCK_CALLER;
            }
            if (visible) {
                activityRecord = r;
            }
            stack.setVisibleBehindActivity(activityRecord);
            if (!visible) {
                ActivityRecord next = stack.findNextTranslucentActivity(r);
                if (next != null) {
                    this.mService.convertFromTranslucent(next.appToken);
                }
            }
            if (!(top.app == null || top.app.thread == null)) {
                try {
                    top.app.thread.scheduleBackgroundVisibleBehindChanged(top.appToken, visible);
                } catch (RemoteException e) {
                }
            }
            return true;
        }
    }

    void handleLaunchTaskBehindCompleteLocked(ActivityRecord r) {
        r.mLaunchTaskBehind = VALIDATE_WAKE_LOCK_CALLER;
        TaskRecord task = r.task;
        task.setLastThumbnail(task.stack.screenshotActivities(r));
        this.mService.addRecentTaskLocked(task);
        this.mService.notifyTaskStackChangedLocked();
        this.mWindowManager.setAppVisibility(r.appToken, VALIDATE_WAKE_LOCK_CALLER);
    }

    void scheduleLaunchTaskBehindComplete(IBinder token) {
        this.mHandler.obtainMessage(LAUNCH_TASK_BEHIND_COMPLETE, token).sendToTarget();
    }

    void ensureActivitiesVisibleLocked(ActivityRecord starting, int configChanges) {
        for (int displayNdx = this.mActivityDisplays.size() - 1; displayNdx >= 0; displayNdx--) {
            ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
            for (int stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
                ((ActivityStack) stacks.get(stackNdx)).ensureActivitiesVisibleLocked(starting, configChanges);
            }
        }
    }

    void scheduleDestroyAllActivities(ProcessRecord app, String reason) {
        for (int displayNdx = this.mActivityDisplays.size() - 1; displayNdx >= 0; displayNdx--) {
            ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
            int numStacks = stacks.size();
            for (int stackNdx = HOME_STACK_ID; stackNdx < numStacks; stackNdx++) {
                ((ActivityStack) stacks.get(stackNdx)).scheduleDestroyActivities(app, reason);
            }
        }
    }

    void releaseSomeActivitiesLocked(ProcessRecord app, String reason) {
        TaskRecord firstTask = null;
        ArraySet<TaskRecord> tasks = null;
        int i = HOME_STACK_ID;
        while (i < app.activities.size()) {
            ActivityRecord r = (ActivityRecord) app.activities.get(i);
            if (!r.finishing && r.state != ActivityState.DESTROYING && r.state != ActivityState.DESTROYED) {
                if (!(r.visible || !r.stopped || !r.haveState || r.state == ActivityState.RESUMED || r.state == ActivityState.PAUSING || r.state == ActivityState.PAUSED || r.state == ActivityState.STOPPING || r.task == null)) {
                    if (firstTask == null) {
                        firstTask = r.task;
                    } else if (firstTask != r.task) {
                        if (tasks == null) {
                            tasks = new ArraySet();
                            tasks.add(firstTask);
                        }
                        tasks.add(r.task);
                    }
                }
                i++;
            } else {
                return;
            }
        }
        if (tasks != null) {
            int numDisplays = this.mActivityDisplays.size();
            for (int displayNdx = HOME_STACK_ID; displayNdx < numDisplays; displayNdx++) {
                ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
                int stackNdx = HOME_STACK_ID;
                while (stackNdx < stacks.size()) {
                    if (((ActivityStack) stacks.get(stackNdx)).releaseSomeActivitiesLocked(app, tasks, reason) <= 0) {
                        stackNdx++;
                    } else {
                        return;
                    }
                }
            }
        }
    }

    boolean switchUserLocked(int userId, UserStartedState uss) {
        ActivityStack stack;
        this.mUserStackInFront.put(this.mCurrentUser, getFocusedStack().getStackId());
        int restoreStackId = this.mUserStackInFront.get(userId, HOME_STACK_ID);
        this.mCurrentUser = userId;
        this.mStartingUsers.add(uss);
        for (int displayNdx = this.mActivityDisplays.size() - 1; displayNdx >= 0; displayNdx--) {
            ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
            for (int stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
                stack = (ActivityStack) stacks.get(stackNdx);
                stack.switchUserLocked(userId);
                TaskRecord task = stack.topTask();
                if (task != null) {
                    this.mWindowManager.moveTaskToTop(task.taskId);
                }
            }
        }
        stack = getStack(restoreStackId);
        if (stack == null) {
            stack = this.mHomeStack;
        }
        boolean homeInFront = stack.isHomeStack();
        if (stack.isOnHomeDisplay()) {
            moveHomeStack(homeInFront, "switchUserOnHomeDisplay");
            task = stack.topTask();
            if (task != null) {
                this.mWindowManager.moveTaskToTop(task.taskId);
            }
        } else {
            resumeHomeStackTask(1, null, "switchUserOnOtherDisplay");
        }
        return homeInFront;
    }

    public void startBackgroundUserLocked(int userId, UserStartedState uss) {
        this.mStartingBackgroundUsers.add(uss);
    }

    final ArrayList<ActivityRecord> processStoppingActivitiesLocked(boolean remove) {
        int N = this.mStoppingActivities.size();
        if (N <= 0) {
            return null;
        }
        ArrayList<ActivityRecord> stops = null;
        boolean nowVisible = allResumedActivitiesVisible();
        int i = HOME_STACK_ID;
        while (i < N) {
            ActivityRecord s = (ActivityRecord) this.mStoppingActivities.get(i);
            if (s.waitingVisible && nowVisible) {
                this.mWaitingVisibleActivities.remove(s);
                s.waitingVisible = VALIDATE_WAKE_LOCK_CALLER;
                if (s.finishing) {
                    this.mWindowManager.setAppVisibility(s.appToken, VALIDATE_WAKE_LOCK_CALLER);
                }
            }
            if ((!s.waitingVisible || this.mService.isSleepingOrShuttingDown()) && remove) {
                if (stops == null) {
                    stops = new ArrayList();
                }
                stops.add(s);
                this.mStoppingActivities.remove(i);
                N--;
                i--;
            }
            i++;
        }
        return stops;
    }

    void validateTopActivitiesLocked() {
    }

    public void dump(PrintWriter pw, String prefix) {
        pw.print(prefix);
        pw.print("mFocusedStack=" + this.mFocusedStack);
        pw.print(" mLastFocusedStack=");
        pw.println(this.mLastFocusedStack);
        pw.print(prefix);
        pw.println("mSleepTimeout=" + this.mSleepTimeout);
        pw.print(prefix);
        pw.println("mCurTaskId=" + this.mCurTaskId);
        pw.print(prefix);
        pw.println("mUserStackInFront=" + this.mUserStackInFront);
        pw.print(prefix);
        pw.println("mActivityContainers=" + this.mActivityContainers);
    }

    ArrayList<ActivityRecord> getDumpActivitiesLocked(String name) {
        return getFocusedStack().getDumpActivitiesLocked(name);
    }

    static boolean printThisActivity(PrintWriter pw, ActivityRecord activity, String dumpPackage, boolean needSep, String prefix) {
        if (activity == null || (dumpPackage != null && !dumpPackage.equals(activity.packageName))) {
            return VALIDATE_WAKE_LOCK_CALLER;
        }
        if (needSep) {
            pw.println();
        }
        pw.print(prefix);
        pw.println(activity);
        return true;
    }

    boolean dumpActivitiesLocked(FileDescriptor fd, PrintWriter pw, boolean dumpAll, boolean dumpClient, String dumpPackage) {
        boolean printed = VALIDATE_WAKE_LOCK_CALLER;
        boolean needSep = VALIDATE_WAKE_LOCK_CALLER;
        for (int displayNdx = HOME_STACK_ID; displayNdx < this.mActivityDisplays.size(); displayNdx++) {
            ActivityDisplay activityDisplay = (ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx);
            pw.print("Display #");
            pw.print(activityDisplay.mDisplayId);
            pw.println(" (activities from top to bottom):");
            ArrayList<ActivityStack> stacks = activityDisplay.mStacks;
            for (int stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
                ActivityStack stack = (ActivityStack) stacks.get(stackNdx);
                StringBuilder stringBuilder = new StringBuilder(DumpState.DUMP_PROVIDERS);
                stringBuilder.append("  Stack #");
                stringBuilder.append(stack.mStackId);
                stringBuilder.append(":");
                printed = (printed | stack.dumpActivitiesLocked(fd, pw, dumpAll, dumpClient, dumpPackage, needSep, stringBuilder.toString())) | dumpHistoryList(fd, pw, stack.mLRUActivities, "    ", "Run", VALIDATE_WAKE_LOCK_CALLER, !dumpAll ? true : VALIDATE_WAKE_LOCK_CALLER, VALIDATE_WAKE_LOCK_CALLER, dumpPackage, true, "    Running activities (most recent first):", null);
                needSep = printed;
                if (printThisActivity(pw, stack.mPausingActivity, dumpPackage, needSep, "    mPausingActivity: ")) {
                    printed = true;
                    needSep = VALIDATE_WAKE_LOCK_CALLER;
                }
                if (printThisActivity(pw, stack.mResumedActivity, dumpPackage, needSep, "    mResumedActivity: ")) {
                    printed = true;
                    needSep = VALIDATE_WAKE_LOCK_CALLER;
                }
                if (dumpAll) {
                    if (printThisActivity(pw, stack.mLastPausedActivity, dumpPackage, needSep, "    mLastPausedActivity: ")) {
                        printed = true;
                        needSep = true;
                    }
                    printed |= printThisActivity(pw, stack.mLastNoHistoryActivity, dumpPackage, needSep, "    mLastNoHistoryActivity: ");
                }
                needSep = printed;
            }
        }
        return ((((printed | dumpHistoryList(fd, pw, this.mFinishingActivities, "  ", "Fin", VALIDATE_WAKE_LOCK_CALLER, !dumpAll ? true : VALIDATE_WAKE_LOCK_CALLER, VALIDATE_WAKE_LOCK_CALLER, dumpPackage, true, "  Activities waiting to finish:", null)) | dumpHistoryList(fd, pw, this.mStoppingActivities, "  ", "Stop", VALIDATE_WAKE_LOCK_CALLER, !dumpAll ? true : VALIDATE_WAKE_LOCK_CALLER, VALIDATE_WAKE_LOCK_CALLER, dumpPackage, true, "  Activities waiting to stop:", null)) | dumpHistoryList(fd, pw, this.mWaitingVisibleActivities, "  ", "Wait", VALIDATE_WAKE_LOCK_CALLER, !dumpAll ? true : VALIDATE_WAKE_LOCK_CALLER, VALIDATE_WAKE_LOCK_CALLER, dumpPackage, true, "  Activities waiting for another to become visible:", null)) | dumpHistoryList(fd, pw, this.mGoingToSleepActivities, "  ", "Sleep", VALIDATE_WAKE_LOCK_CALLER, !dumpAll ? true : VALIDATE_WAKE_LOCK_CALLER, VALIDATE_WAKE_LOCK_CALLER, dumpPackage, true, "  Activities waiting to sleep:", null)) | dumpHistoryList(fd, pw, this.mGoingToSleepActivities, "  ", "Sleep", VALIDATE_WAKE_LOCK_CALLER, !dumpAll ? true : VALIDATE_WAKE_LOCK_CALLER, VALIDATE_WAKE_LOCK_CALLER, dumpPackage, true, "  Activities waiting to sleep:", null);
    }

    static boolean dumpHistoryList(FileDescriptor fd, PrintWriter pw, List<ActivityRecord> list, String prefix, String label, boolean complete, boolean brief, boolean client, String dumpPackage, boolean needNL, String header1, String header2) {
        TaskRecord lastTask = null;
        String innerPrefix = null;
        String[] args = null;
        boolean printed = VALIDATE_WAKE_LOCK_CALLER;
        for (int i = list.size() - 1; i >= 0; i--) {
            ActivityRecord r = (ActivityRecord) list.get(i);
            if (dumpPackage != null) {
                if (!dumpPackage.equals(r.packageName)) {
                    continue;
                }
            }
            if (innerPrefix == null) {
                innerPrefix = prefix + "      ";
                args = new String[HOME_STACK_ID];
            }
            printed = true;
            boolean full = (brief || (!complete && r.isInHistory())) ? VALIDATE_WAKE_LOCK_CALLER : true;
            if (needNL) {
                pw.println("");
                needNL = VALIDATE_WAKE_LOCK_CALLER;
            }
            if (header1 != null) {
                pw.println(header1);
                header1 = null;
            }
            if (header2 != null) {
                pw.println(header2);
                header2 = null;
            }
            if (lastTask != r.task) {
                lastTask = r.task;
                pw.print(prefix);
                pw.print(full ? "* " : "  ");
                pw.println(lastTask);
                if (full) {
                    lastTask.dump(pw, prefix + "  ");
                } else if (complete && lastTask.intent != null) {
                    pw.print(prefix);
                    pw.print("  ");
                    pw.println(lastTask.intent.toInsecureStringWithClip());
                }
            }
            pw.print(prefix);
            pw.print(full ? "  * " : "    ");
            pw.print(label);
            pw.print(" #");
            pw.print(i);
            pw.print(": ");
            pw.println(r);
            if (full) {
                r.dump(pw, innerPrefix);
            } else if (complete) {
                pw.print(innerPrefix);
                pw.println(r.intent.toInsecureString());
                if (r.app != null) {
                    pw.print(innerPrefix);
                    pw.println(r.app);
                }
            }
            if (!(!client || r.app == null || r.app.thread == null)) {
                pw.flush();
                TransferPipe tp;
                try {
                    tp = new TransferPipe();
                    r.app.thread.dumpActivity(tp.getWriteFd().getFileDescriptor(), r.appToken, innerPrefix, args);
                    tp.go(fd, 2000);
                    tp.kill();
                } catch (IOException e) {
                    pw.println(innerPrefix + "Failure while dumping the activity: " + e);
                } catch (RemoteException e2) {
                    pw.println(innerPrefix + "Got a RemoteException while dumping the activity");
                } catch (Throwable th) {
                    tp.kill();
                }
                needNL = true;
            }
        }
        return printed;
    }

    void scheduleIdleTimeoutLocked(ActivityRecord next) {
        this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(IDLE_TIMEOUT_MSG, next), 10000);
    }

    final void scheduleIdleLocked() {
        this.mHandler.sendEmptyMessage(IDLE_NOW_MSG);
    }

    void removeTimeoutsForActivityLocked(ActivityRecord r) {
        this.mHandler.removeMessages(IDLE_TIMEOUT_MSG, r);
    }

    final void scheduleResumeTopActivities() {
        if (!this.mHandler.hasMessages(RESUME_TOP_ACTIVITY_MSG)) {
            this.mHandler.sendEmptyMessage(RESUME_TOP_ACTIVITY_MSG);
        }
    }

    void removeSleepTimeouts() {
        this.mSleepTimeout = VALIDATE_WAKE_LOCK_CALLER;
        this.mHandler.removeMessages(SLEEP_TIMEOUT_MSG);
    }

    final void scheduleSleepTimeout() {
        removeSleepTimeouts();
        this.mHandler.sendEmptyMessageDelayed(SLEEP_TIMEOUT_MSG, 5000);
    }

    public void onDisplayAdded(int displayId) {
        Slog.v("ActivityManager", "Display added displayId=" + displayId);
        this.mHandler.sendMessage(this.mHandler.obtainMessage(HANDLE_DISPLAY_ADDED, displayId, HOME_STACK_ID));
    }

    public void onDisplayRemoved(int displayId) {
        Slog.v("ActivityManager", "Display removed displayId=" + displayId);
        this.mHandler.sendMessage(this.mHandler.obtainMessage(HANDLE_DISPLAY_REMOVED, displayId, HOME_STACK_ID));
    }

    public void onDisplayChanged(int displayId) {
        Slog.v("ActivityManager", "Display changed displayId=" + displayId);
        this.mHandler.sendMessage(this.mHandler.obtainMessage(HANDLE_DISPLAY_CHANGED, displayId, HOME_STACK_ID));
    }

    public void handleDisplayAddedLocked(int displayId) {
        synchronized (this.mService) {
            boolean newDisplay = this.mActivityDisplays.get(displayId) == null ? true : VALIDATE_WAKE_LOCK_CALLER;
            if (newDisplay) {
                ActivityDisplay activityDisplay = new ActivityDisplay(displayId);
                if (activityDisplay.mDisplay == null) {
                    Slog.w("ActivityManager", "Display " + displayId + " gone before initialization complete");
                    return;
                }
                this.mActivityDisplays.put(displayId, activityDisplay);
            }
            if (newDisplay) {
                this.mWindowManager.onDisplayAdded(displayId);
            }
        }
    }

    public void handleDisplayRemovedLocked(int displayId) {
        synchronized (this.mService) {
            ActivityDisplay activityDisplay = (ActivityDisplay) this.mActivityDisplays.get(displayId);
            if (activityDisplay != null) {
                ArrayList<ActivityStack> stacks = activityDisplay.mStacks;
                for (int stackNdx = stacks.size() - 1; stackNdx >= 0; stackNdx--) {
                    ((ActivityStack) stacks.get(stackNdx)).mActivityContainer.detachLocked();
                }
                this.mActivityDisplays.remove(displayId);
            }
        }
        this.mWindowManager.onDisplayRemoved(displayId);
    }

    public void handleDisplayChangedLocked(int displayId) {
        synchronized (this.mService) {
            if (((ActivityDisplay) this.mActivityDisplays.get(displayId)) != null) {
            }
        }
        this.mWindowManager.onDisplayChanged(displayId);
    }

    StackInfo getStackInfo(ActivityStack stack) {
        StackInfo info = new StackInfo();
        this.mWindowManager.getStackBounds(stack.mStackId, info.bounds);
        info.displayId = HOME_STACK_ID;
        info.stackId = stack.mStackId;
        ArrayList<TaskRecord> tasks = stack.getAllTasks();
        int numTasks = tasks.size();
        int[] taskIds = new int[numTasks];
        String[] taskNames = new String[numTasks];
        for (int i = HOME_STACK_ID; i < numTasks; i++) {
            TaskRecord task = (TaskRecord) tasks.get(i);
            taskIds[i] = task.taskId;
            String flattenToString = task.origActivity != null ? task.origActivity.flattenToString() : task.realActivity != null ? task.realActivity.flattenToString() : task.getTopActivity() != null ? task.getTopActivity().packageName : "unknown";
            taskNames[i] = flattenToString;
        }
        info.taskIds = taskIds;
        info.taskNames = taskNames;
        return info;
    }

    StackInfo getStackInfoLocked(int stackId) {
        ActivityStack stack = getStack(stackId);
        if (stack != null) {
            return getStackInfo(stack);
        }
        return null;
    }

    ArrayList<StackInfo> getAllStackInfosLocked() {
        ArrayList<StackInfo> list = new ArrayList();
        for (int displayNdx = HOME_STACK_ID; displayNdx < this.mActivityDisplays.size(); displayNdx++) {
            ArrayList<ActivityStack> stacks = ((ActivityDisplay) this.mActivityDisplays.valueAt(displayNdx)).mStacks;
            for (int ndx = stacks.size() - 1; ndx >= 0; ndx--) {
                list.add(getStackInfo((ActivityStack) stacks.get(ndx)));
            }
        }
        return list;
    }

    void showLockTaskToast() {
        this.mLockTaskNotify.showToast(this.mLockTaskIsLocked);
    }

    void setLockTaskModeLocked(TaskRecord task, boolean isLocked, String reason) {
        int i = HOME_STACK_ID;
        Message lockTaskMsg;
        if (task == null) {
            if (this.mLockTaskModeTask != null) {
                lockTaskMsg = Message.obtain();
                lockTaskMsg.arg1 = this.mLockTaskModeTask.userId;
                lockTaskMsg.what = LOCK_TASK_END_MSG;
                this.mLockTaskModeTask = null;
                this.mHandler.sendMessage(lockTaskMsg);
            }
        } else if (isLockTaskModeViolation(task)) {
            Slog.e("ActivityManager", "setLockTaskMode: Attempt to start a second Lock Task Mode task.");
        } else {
            this.mLockTaskModeTask = task;
            findTaskToMoveToFrontLocked(task, HOME_STACK_ID, null, reason);
            resumeTopActivitiesLocked();
            lockTaskMsg = Message.obtain();
            lockTaskMsg.obj = this.mLockTaskModeTask.intent.getComponent().getPackageName();
            lockTaskMsg.arg1 = this.mLockTaskModeTask.userId;
            lockTaskMsg.what = LOCK_TASK_START_MSG;
            if (!isLocked) {
                i = 1;
            }
            lockTaskMsg.arg2 = i;
            this.mHandler.sendMessage(lockTaskMsg);
        }
    }

    boolean isLockTaskModeViolation(TaskRecord task) {
        return (this.mLockTaskModeTask == null || this.mLockTaskModeTask == task) ? VALIDATE_WAKE_LOCK_CALLER : true;
    }

    void endLockTaskModeIfTaskEnding(TaskRecord task) {
        if (this.mLockTaskModeTask != null && this.mLockTaskModeTask == task) {
            Message lockTaskMsg = Message.obtain();
            lockTaskMsg.arg1 = this.mLockTaskModeTask.userId;
            lockTaskMsg.what = LOCK_TASK_END_MSG;
            this.mLockTaskModeTask = null;
            this.mHandler.sendMessage(lockTaskMsg);
        }
    }

    boolean isInLockTaskMode() {
        return this.mLockTaskModeTask != null ? true : VALIDATE_WAKE_LOCK_CALLER;
    }

    private boolean isLeanbackOnlyDevice() {
        boolean onLeanbackOnly = VALIDATE_WAKE_LOCK_CALLER;
        try {
            onLeanbackOnly = AppGlobals.getPackageManager().hasSystemFeature("android.software.leanback_only");
        } catch (RemoteException e) {
        }
        return onLeanbackOnly;
    }
}
