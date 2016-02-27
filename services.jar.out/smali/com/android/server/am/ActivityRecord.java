package com.android.server.am;

import android.app.ActivityManager.TaskDescription;
import android.app.ActivityOptions;
import android.app.ResultInfo;
import android.content.ComponentName;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.content.pm.ApplicationInfo;
import android.content.res.CompatibilityInfo;
import android.content.res.Configuration;
import android.graphics.Bitmap;
import android.graphics.Rect;
import android.os.Bundle;
import android.os.IBinder;
import android.os.Message;
import android.os.PersistableBundle;
import android.os.Process;
import android.os.RemoteException;
import android.os.SystemClock;
import android.os.Trace;
import android.os.UserHandle;
import android.util.EventLog;
import android.util.Log;
import android.util.Slog;
import android.util.TimeUtils;
import android.view.IApplicationToken.Stub;
import com.android.internal.R;
import com.android.internal.app.ResolverActivity;
import com.android.internal.content.ReferrerIntent;
import com.android.server.AttributeCache;
import com.android.server.AttributeCache.Entry;
import com.android.server.wm.WindowManagerService.C0569H;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Objects;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

final class ActivityRecord {
    static final String ACTIVITY_ICON_SUFFIX = "_activity_icon_";
    static final int APPLICATION_ACTIVITY_TYPE = 0;
    private static final String ATTR_COMPONENTSPECIFIED = "component_specified";
    private static final String ATTR_ID = "id";
    static final String ATTR_LAUNCHEDFROMPACKAGE = "launched_from_package";
    private static final String ATTR_LAUNCHEDFROMUID = "launched_from_uid";
    private static final String ATTR_RESOLVEDTYPE = "resolved_type";
    private static final String ATTR_USERID = "user_id";
    static final boolean DEBUG_SAVED_STATE = false;
    static final int HOME_ACTIVITY_TYPE = 1;
    static final int RECENTS_ACTIVITY_TYPE = 2;
    public static final String RECENTS_PACKAGE_NAME = "com.android.systemui.recents";
    static final String TAG = "ActivityManager";
    private static final String TAG_ACTIVITY = "activity";
    private static final String TAG_INTENT = "intent";
    private static final String TAG_PERSISTABLEBUNDLE = "persistable_bundle";
    static final String TAG_TIMELINE = "Timeline";
    ProcessRecord app;
    final ApplicationInfo appInfo;
    final Stub appToken;
    CompatibilityInfo compat;
    final boolean componentSpecified;
    int configChangeFlags;
    boolean configDestroy;
    Configuration configuration;
    HashSet<ConnectionRecord> connections;
    long cpuTimeAtResume;
    long createTime;
    boolean delayedResume;
    long displayStartTime;
    boolean finishing;
    boolean forceNewConfig;
    boolean frontOfTask;
    boolean frozenBeforeDestroy;
    boolean fullscreen;
    long fullyDrawnStartTime;
    boolean hasBeenLaunched;
    boolean haveState;
    Bundle icicle;
    int icon;
    boolean idle;
    boolean immersive;
    private boolean inHistory;
    final ActivityInfo info;
    final Intent intent;
    boolean keysPaused;
    int labelRes;
    long lastLaunchTime;
    long lastVisibleTime;
    int launchCount;
    boolean launchFailed;
    int launchMode;
    long launchTickTime;
    final String launchedFromPackage;
    int launchedFromUid;
    int logo;
    int mActivityType;
    ArrayList<ActivityContainer> mChildContainers;
    ActivityContainer mInitialActivityContainer;
    boolean mLaunchTaskBehind;
    final ActivityStackSupervisor mStackSupervisor;
    boolean mStartingWindowShown;
    ArrayList<ReferrerIntent> newIntents;
    final boolean noDisplay;
    CharSequence nonLocalizedLabel;
    boolean nowVisible;
    final String packageName;
    long pauseTime;
    ActivityOptions pendingOptions;
    HashSet<WeakReference<PendingIntentRecord>> pendingResults;
    PersistableBundle persistentState;
    final String processName;
    final ComponentName realActivity;
    int realTheme;
    final int requestCode;
    final String resolvedType;
    ActivityRecord resultTo;
    final String resultWho;
    ArrayList<ResultInfo> results;
    ActivityOptions returningOptions;
    final ActivityManagerService service;
    final String shortComponentName;
    boolean sleeping;
    long startTime;
    ActivityState state;
    final boolean stateNotNeeded;
    boolean stopped;
    String stringName;
    TaskRecord task;
    final String taskAffinity;
    TaskDescription taskDescription;
    int theme;
    UriPermissionOwner uriPermissions;
    final int userId;
    boolean visible;
    boolean waitingVisible;
    int windowFlags;

    static class Token extends Stub {
        final WeakReference<ActivityRecord> weakActivity;

        Token(ActivityRecord activity) {
            this.weakActivity = new WeakReference(activity);
        }

        public void windowsDrawn() {
            ActivityRecord activity = (ActivityRecord) this.weakActivity.get();
            if (activity != null) {
                activity.windowsDrawn();
            }
        }

        public void windowsVisible() {
            ActivityRecord activity = (ActivityRecord) this.weakActivity.get();
            if (activity != null) {
                activity.windowsVisible();
            }
        }

        public void windowsGone() {
            ActivityRecord activity = (ActivityRecord) this.weakActivity.get();
            if (activity != null) {
                activity.windowsGone();
            }
        }

        public boolean keyDispatchingTimedOut(String reason) {
            ActivityRecord activity = (ActivityRecord) this.weakActivity.get();
            return (activity == null || !activity.keyDispatchingTimedOut(reason)) ? ActivityRecord.DEBUG_SAVED_STATE : true;
        }

        public long getKeyDispatchingTimeout() {
            ActivityRecord activity = (ActivityRecord) this.weakActivity.get();
            if (activity != null) {
                return activity.getKeyDispatchingTimeout();
            }
            return 0;
        }

        public String toString() {
            StringBuilder sb = new StringBuilder(DumpState.DUMP_PROVIDERS);
            sb.append("Token{");
            sb.append(Integer.toHexString(System.identityHashCode(this)));
            sb.append(' ');
            sb.append(this.weakActivity.get());
            sb.append('}');
            return sb.toString();
        }
    }

    void dump(PrintWriter pw, String prefix) {
        long now = SystemClock.uptimeMillis();
        pw.print(prefix);
        pw.print("packageName=");
        pw.print(this.packageName);
        pw.print(" processName=");
        pw.println(this.processName);
        pw.print(prefix);
        pw.print("launchedFromUid=");
        pw.print(this.launchedFromUid);
        pw.print(" launchedFromPackage=");
        pw.print(this.launchedFromPackage);
        pw.print(" userId=");
        pw.println(this.userId);
        pw.print(prefix);
        pw.print("app=");
        pw.println(this.app);
        pw.print(prefix);
        pw.println(this.intent.toInsecureStringWithClip());
        pw.print(prefix);
        pw.print("frontOfTask=");
        pw.print(this.frontOfTask);
        pw.print(" task=");
        pw.println(this.task);
        pw.print(prefix);
        pw.print("taskAffinity=");
        pw.println(this.taskAffinity);
        pw.print(prefix);
        pw.print("realActivity=");
        pw.println(this.realActivity.flattenToShortString());
        if (this.appInfo != null) {
            pw.print(prefix);
            pw.print("baseDir=");
            pw.println(this.appInfo.sourceDir);
            if (!Objects.equals(this.appInfo.sourceDir, this.appInfo.publicSourceDir)) {
                pw.print(prefix);
                pw.print("resDir=");
                pw.println(this.appInfo.publicSourceDir);
            }
            pw.print(prefix);
            pw.print("dataDir=");
            pw.println(this.appInfo.dataDir);
        }
        pw.print(prefix);
        pw.print("stateNotNeeded=");
        pw.print(this.stateNotNeeded);
        pw.print(" componentSpecified=");
        pw.print(this.componentSpecified);
        pw.print(" mActivityType=");
        pw.println(this.mActivityType);
        pw.print(prefix);
        pw.print("compat=");
        pw.print(this.compat);
        pw.print(" labelRes=0x");
        pw.print(Integer.toHexString(this.labelRes));
        pw.print(" icon=0x");
        pw.print(Integer.toHexString(this.icon));
        pw.print(" theme=0x");
        pw.println(Integer.toHexString(this.theme));
        pw.print(prefix);
        pw.print("config=");
        pw.println(this.configuration);
        if (!(this.resultTo == null && this.resultWho == null)) {
            pw.print(prefix);
            pw.print("resultTo=");
            pw.print(this.resultTo);
            pw.print(" resultWho=");
            pw.print(this.resultWho);
            pw.print(" resultCode=");
            pw.println(this.requestCode);
        }
        if (this.taskDescription != null) {
            String iconFilename = this.taskDescription.getIconFilename();
            if (!(iconFilename == null && this.taskDescription.getLabel() == null && this.taskDescription.getPrimaryColor() == 0)) {
                pw.print(prefix);
                pw.print("taskDescription:");
                pw.print(" iconFilename=");
                pw.print(this.taskDescription.getIconFilename());
                pw.print(" label=\"");
                pw.print(this.taskDescription.getLabel());
                pw.print("\"");
                pw.print(" color=");
                pw.println(Integer.toHexString(this.taskDescription.getPrimaryColor()));
            }
            if (iconFilename == null && this.taskDescription.getIcon() != null) {
                pw.print(prefix);
                pw.println("taskDescription contains Bitmap");
            }
        }
        if (this.results != null) {
            pw.print(prefix);
            pw.print("results=");
            pw.println(this.results);
        }
        if (this.pendingResults != null && this.pendingResults.size() > 0) {
            pw.print(prefix);
            pw.println("Pending Results:");
            Iterator i$ = this.pendingResults.iterator();
            while (i$.hasNext()) {
                WeakReference<PendingIntentRecord> wpir = (WeakReference) i$.next();
                PendingIntentRecord pir = wpir != null ? (PendingIntentRecord) wpir.get() : null;
                pw.print(prefix);
                pw.print("  - ");
                if (pir == null) {
                    pw.println("null");
                } else {
                    pw.println(pir);
                    pir.dump(pw, prefix + "    ");
                }
            }
        }
        if (this.newIntents != null && this.newIntents.size() > 0) {
            pw.print(prefix);
            pw.println("Pending New Intents:");
            for (int i = APPLICATION_ACTIVITY_TYPE; i < this.newIntents.size(); i += HOME_ACTIVITY_TYPE) {
                Intent intent = (Intent) this.newIntents.get(i);
                pw.print(prefix);
                pw.print("  - ");
                if (intent == null) {
                    pw.println("null");
                } else {
                    pw.println(intent.toShortString(DEBUG_SAVED_STATE, true, DEBUG_SAVED_STATE, true));
                }
            }
        }
        if (this.pendingOptions != null) {
            pw.print(prefix);
            pw.print("pendingOptions=");
            pw.println(this.pendingOptions);
        }
        if (this.uriPermissions != null) {
            this.uriPermissions.dump(pw, prefix);
        }
        pw.print(prefix);
        pw.print("launchFailed=");
        pw.print(this.launchFailed);
        pw.print(" launchCount=");
        pw.print(this.launchCount);
        pw.print(" lastLaunchTime=");
        if (this.lastLaunchTime == 0) {
            pw.print("0");
        } else {
            TimeUtils.formatDuration(this.lastLaunchTime, now, pw);
        }
        pw.println();
        pw.print(prefix);
        pw.print("haveState=");
        pw.print(this.haveState);
        pw.print(" icicle=");
        pw.println(this.icicle);
        pw.print(prefix);
        pw.print("state=");
        pw.print(this.state);
        pw.print(" stopped=");
        pw.print(this.stopped);
        pw.print(" delayedResume=");
        pw.print(this.delayedResume);
        pw.print(" finishing=");
        pw.println(this.finishing);
        pw.print(prefix);
        pw.print("keysPaused=");
        pw.print(this.keysPaused);
        pw.print(" inHistory=");
        pw.print(this.inHistory);
        pw.print(" visible=");
        pw.print(this.visible);
        pw.print(" sleeping=");
        pw.print(this.sleeping);
        pw.print(" idle=");
        pw.println(this.idle);
        pw.print(prefix);
        pw.print("fullscreen=");
        pw.print(this.fullscreen);
        pw.print(" noDisplay=");
        pw.print(this.noDisplay);
        pw.print(" immersive=");
        pw.print(this.immersive);
        pw.print(" launchMode=");
        pw.println(this.launchMode);
        pw.print(prefix);
        pw.print("frozenBeforeDestroy=");
        pw.print(this.frozenBeforeDestroy);
        pw.print(" forceNewConfig=");
        pw.println(this.forceNewConfig);
        pw.print(prefix);
        pw.print("mActivityType=");
        pw.println(activityTypeToString(this.mActivityType));
        if (!(this.displayStartTime == 0 && this.startTime == 0)) {
            pw.print(prefix);
            pw.print("displayStartTime=");
            if (this.displayStartTime == 0) {
                pw.print("0");
            } else {
                TimeUtils.formatDuration(this.displayStartTime, now, pw);
            }
            pw.print(" startTime=");
            if (this.startTime == 0) {
                pw.print("0");
            } else {
                TimeUtils.formatDuration(this.startTime, now, pw);
            }
            pw.println();
        }
        if (this.lastVisibleTime != 0 || this.waitingVisible || this.nowVisible) {
            pw.print(prefix);
            pw.print("waitingVisible=");
            pw.print(this.waitingVisible);
            pw.print(" nowVisible=");
            pw.print(this.nowVisible);
            pw.print(" lastVisibleTime=");
            if (this.lastVisibleTime == 0) {
                pw.print("0");
            } else {
                TimeUtils.formatDuration(this.lastVisibleTime, now, pw);
            }
            pw.println();
        }
        if (this.configDestroy || this.configChangeFlags != 0) {
            pw.print(prefix);
            pw.print("configDestroy=");
            pw.print(this.configDestroy);
            pw.print(" configChangeFlags=");
            pw.println(Integer.toHexString(this.configChangeFlags));
        }
        if (this.connections != null) {
            pw.print(prefix);
            pw.print("connections=");
            pw.println(this.connections);
        }
    }

    static ActivityRecord forToken(IBinder token) {
        ActivityRecord activityRecord;
        if (token != null) {
            try {
                activityRecord = (ActivityRecord) ((Token) token).weakActivity.get();
            } catch (ClassCastException e) {
                Slog.w(TAG, "Bad activity token: " + token, e);
                return null;
            }
        }
        activityRecord = null;
        return activityRecord;
    }

    boolean isNotResolverActivity() {
        return !ResolverActivity.class.getName().equals(this.realActivity.getClassName()) ? true : DEBUG_SAVED_STATE;
    }

    ActivityRecord(ActivityManagerService _service, ProcessRecord _caller, int _launchedFromUid, String _launchedFromPackage, Intent _intent, String _resolvedType, ActivityInfo aInfo, Configuration _configuration, ActivityRecord _resultTo, String _resultWho, int _reqCode, boolean _componentSpecified, ActivityStackSupervisor supervisor, ActivityContainer container, Bundle options) {
        this.createTime = System.currentTimeMillis();
        this.mChildContainers = new ArrayList();
        this.mStartingWindowShown = DEBUG_SAVED_STATE;
        this.service = _service;
        this.appToken = new Token(this);
        this.info = aInfo;
        this.launchedFromUid = _launchedFromUid;
        this.launchedFromPackage = _launchedFromPackage;
        this.userId = UserHandle.getUserId(aInfo.applicationInfo.uid);
        this.intent = _intent;
        this.shortComponentName = _intent.getComponent().flattenToShortString();
        this.resolvedType = _resolvedType;
        this.componentSpecified = _componentSpecified;
        this.configuration = _configuration;
        this.resultTo = _resultTo;
        this.resultWho = _resultWho;
        this.requestCode = _reqCode;
        this.state = ActivityState.INITIALIZING;
        this.frontOfTask = DEBUG_SAVED_STATE;
        this.launchFailed = DEBUG_SAVED_STATE;
        this.stopped = DEBUG_SAVED_STATE;
        this.delayedResume = DEBUG_SAVED_STATE;
        this.finishing = DEBUG_SAVED_STATE;
        this.configDestroy = DEBUG_SAVED_STATE;
        this.keysPaused = DEBUG_SAVED_STATE;
        this.inHistory = DEBUG_SAVED_STATE;
        this.visible = true;
        this.waitingVisible = DEBUG_SAVED_STATE;
        this.nowVisible = DEBUG_SAVED_STATE;
        this.idle = DEBUG_SAVED_STATE;
        this.hasBeenLaunched = DEBUG_SAVED_STATE;
        this.mStackSupervisor = supervisor;
        this.mInitialActivityContainer = container;
        if (options != null) {
            this.pendingOptions = new ActivityOptions(options);
            this.mLaunchTaskBehind = this.pendingOptions.getLaunchTaskBehind();
        }
        this.haveState = true;
        if (aInfo != null) {
            if (aInfo.targetActivity == null || aInfo.launchMode == 0 || aInfo.launchMode == HOME_ACTIVITY_TYPE) {
                this.realActivity = _intent.getComponent();
            } else {
                this.realActivity = new ComponentName(aInfo.packageName, aInfo.targetActivity);
            }
            this.taskAffinity = aInfo.taskAffinity;
            this.stateNotNeeded = (aInfo.flags & 16) != 0 ? true : DEBUG_SAVED_STATE;
            this.appInfo = aInfo.applicationInfo;
            this.nonLocalizedLabel = aInfo.nonLocalizedLabel;
            this.labelRes = aInfo.labelRes;
            if (this.nonLocalizedLabel == null && this.labelRes == 0) {
                ApplicationInfo app = aInfo.applicationInfo;
                this.nonLocalizedLabel = app.nonLocalizedLabel;
                this.labelRes = app.labelRes;
            }
            this.icon = aInfo.getIconResource();
            this.logo = aInfo.getLogoResource();
            this.theme = aInfo.getThemeResource();
            this.realTheme = this.theme;
            if (this.realTheme == 0) {
                this.realTheme = aInfo.applicationInfo.targetSdkVersion < 11 ? 16973829 : 16973931;
            }
            if ((aInfo.flags & DumpState.DUMP_PREFERRED) != 0) {
                this.windowFlags |= 16777216;
            }
            if ((aInfo.flags & HOME_ACTIVITY_TYPE) == 0 || _caller == null || !(aInfo.applicationInfo.uid == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE || aInfo.applicationInfo.uid == _caller.info.uid)) {
                this.processName = aInfo.processName;
            } else {
                this.processName = _caller.processName;
            }
            if (!(this.intent == null || (aInfo.flags & 32) == 0)) {
                this.intent.addFlags(8388608);
            }
            this.packageName = aInfo.applicationInfo.packageName;
            this.launchMode = aInfo.launchMode;
            Entry ent = AttributeCache.instance().get(this.packageName, this.realTheme, R.styleable.Window, this.userId);
            boolean z = (ent == null || ent.array.getBoolean(4, DEBUG_SAVED_STATE) || ent.array.getBoolean(5, DEBUG_SAVED_STATE)) ? DEBUG_SAVED_STATE : true;
            this.fullscreen = z;
            z = (ent == null || !ent.array.getBoolean(10, DEBUG_SAVED_STATE)) ? DEBUG_SAVED_STATE : true;
            this.noDisplay = z;
            if ((!_componentSpecified || _launchedFromUid == Process.myUid() || _launchedFromUid == 0) && "android.intent.action.MAIN".equals(_intent.getAction()) && _intent.hasCategory("android.intent.category.HOME") && _intent.getCategories().size() == HOME_ACTIVITY_TYPE && _intent.getData() == null && _intent.getType() == null && (this.intent.getFlags() & 268435456) != 0 && isNotResolverActivity()) {
                this.mActivityType = HOME_ACTIVITY_TYPE;
            } else if (this.realActivity.getClassName().contains(RECENTS_PACKAGE_NAME)) {
                this.mActivityType = RECENTS_ACTIVITY_TYPE;
            } else {
                this.mActivityType = APPLICATION_ACTIVITY_TYPE;
            }
            if ((aInfo.flags & DumpState.DUMP_KEYSETS) != 0) {
                z = true;
            } else {
                z = DEBUG_SAVED_STATE;
            }
            this.immersive = z;
            return;
        }
        this.realActivity = null;
        this.taskAffinity = null;
        this.stateNotNeeded = DEBUG_SAVED_STATE;
        this.appInfo = null;
        this.processName = null;
        this.packageName = null;
        this.fullscreen = true;
        this.noDisplay = DEBUG_SAVED_STATE;
        this.mActivityType = APPLICATION_ACTIVITY_TYPE;
        this.immersive = DEBUG_SAVED_STATE;
    }

    void setTask(TaskRecord newTask, TaskRecord taskToAffiliateWith) {
        if (this.task != null && this.task.removeActivity(this)) {
            if (this.task != newTask) {
                this.task.stack.removeTask(this.task, "setTask");
            } else {
                Slog.d(TAG, "!!! REMOVE THIS LOG !!! setTask: nearly removed stack=" + (newTask == null ? null : newTask.stack));
            }
        }
        this.task = newTask;
        setTaskToAffiliateWith(taskToAffiliateWith);
    }

    void setTaskToAffiliateWith(TaskRecord taskToAffiliateWith) {
        if (taskToAffiliateWith != null && this.launchMode != 3 && this.launchMode != RECENTS_ACTIVITY_TYPE) {
            this.task.setTaskToAffiliateWith(taskToAffiliateWith);
        }
    }

    boolean changeWindowTranslucency(boolean toOpaque) {
        if (this.fullscreen == toOpaque) {
            return DEBUG_SAVED_STATE;
        }
        TaskRecord taskRecord = this.task;
        taskRecord.numFullscreen = (toOpaque ? HOME_ACTIVITY_TYPE : -1) + taskRecord.numFullscreen;
        this.fullscreen = toOpaque;
        return true;
    }

    void putInHistory() {
        if (!this.inHistory) {
            this.inHistory = true;
        }
    }

    void takeFromHistory() {
        if (this.inHistory) {
            this.inHistory = DEBUG_SAVED_STATE;
            if (!(this.task == null || this.finishing)) {
                this.task = null;
            }
            clearOptionsLocked();
        }
    }

    boolean isInHistory() {
        return this.inHistory;
    }

    boolean isHomeActivity() {
        return this.mActivityType == HOME_ACTIVITY_TYPE ? true : DEBUG_SAVED_STATE;
    }

    boolean isRecentsActivity() {
        return this.mActivityType == RECENTS_ACTIVITY_TYPE ? true : DEBUG_SAVED_STATE;
    }

    boolean isApplicationActivity() {
        return this.mActivityType == 0 ? true : DEBUG_SAVED_STATE;
    }

    boolean isPersistable() {
        return ((this.info.persistableMode == 0 || this.info.persistableMode == RECENTS_ACTIVITY_TYPE) && (this.intent == null || (this.intent.getFlags() & 8388608) == 0)) ? true : DEBUG_SAVED_STATE;
    }

    void makeFinishing() {
        if (!this.finishing) {
            if (this == this.task.stack.getVisibleBehindActivity()) {
                this.mStackSupervisor.requestVisibleBehindLocked(this, DEBUG_SAVED_STATE);
            }
            this.finishing = true;
            if (this.stopped) {
                clearOptionsLocked();
            }
        }
    }

    UriPermissionOwner getUriPermissionsLocked() {
        if (this.uriPermissions == null) {
            this.uriPermissions = new UriPermissionOwner(this.service, this);
        }
        return this.uriPermissions;
    }

    void addResultLocked(ActivityRecord from, String resultWho, int requestCode, int resultCode, Intent resultData) {
        ActivityResult r = new ActivityResult(from, resultWho, requestCode, resultCode, resultData);
        if (this.results == null) {
            this.results = new ArrayList();
        }
        this.results.add(r);
    }

    void removeResultsLocked(ActivityRecord from, String resultWho, int requestCode) {
        if (this.results != null) {
            for (int i = this.results.size() - 1; i >= 0; i--) {
                ActivityResult r = (ActivityResult) this.results.get(i);
                if (r.mFrom == from) {
                    if (r.mResultWho == null) {
                        if (resultWho != null) {
                        }
                    } else if (!r.mResultWho.equals(resultWho)) {
                    }
                    if (r.mRequestCode == requestCode) {
                        this.results.remove(i);
                    }
                }
            }
        }
    }

    void addNewIntentLocked(ReferrerIntent intent) {
        if (this.newIntents == null) {
            this.newIntents = new ArrayList();
        }
        this.newIntents.add(intent);
    }

    final void deliverNewIntentLocked(int callingUid, Intent intent, String referrer) {
        this.service.grantUriPermissionFromIntentLocked(callingUid, this.packageName, intent, getUriPermissionsLocked(), this.userId);
        ReferrerIntent rintent = new ReferrerIntent(intent, referrer);
        boolean unsent = true;
        if (!((this.state != ActivityState.RESUMED && (!this.service.isSleeping() || this.task.stack.topRunningActivityLocked(null) != this)) || this.app == null || this.app.thread == null)) {
            try {
                ArrayList<ReferrerIntent> ar = new ArrayList(HOME_ACTIVITY_TYPE);
                ar.add(rintent);
                this.app.thread.scheduleNewIntent(ar, this.appToken);
                unsent = DEBUG_SAVED_STATE;
            } catch (RemoteException e) {
                Slog.w(TAG, "Exception thrown sending new intent to " + this, e);
            } catch (NullPointerException e2) {
                Slog.w(TAG, "Exception thrown sending new intent to " + this, e2);
            }
        }
        if (unsent) {
            addNewIntentLocked(rintent);
        }
    }

    void updateOptionsLocked(Bundle options) {
        if (options != null) {
            if (this.pendingOptions != null) {
                this.pendingOptions.abort();
            }
            this.pendingOptions = new ActivityOptions(options);
        }
    }

    void updateOptionsLocked(ActivityOptions options) {
        if (options != null) {
            if (this.pendingOptions != null) {
                this.pendingOptions.abort();
            }
            this.pendingOptions = options;
        }
    }

    void applyOptionsLocked() {
        boolean scaleUp = true;
        if (this.pendingOptions != null && this.pendingOptions.getAnimationType() != 5) {
            int animationType = this.pendingOptions.getAnimationType();
            switch (animationType) {
                case HOME_ACTIVITY_TYPE /*1*/:
                    this.service.mWindowManager.overridePendingAppTransition(this.pendingOptions.getPackageName(), this.pendingOptions.getCustomEnterResId(), this.pendingOptions.getCustomExitResId(), this.pendingOptions.getOnAnimationStartListener());
                    break;
                case RECENTS_ACTIVITY_TYPE /*2*/:
                    this.service.mWindowManager.overridePendingAppTransitionScaleUp(this.pendingOptions.getStartX(), this.pendingOptions.getStartY(), this.pendingOptions.getWidth(), this.pendingOptions.getHeight());
                    if (this.intent.getSourceBounds() == null) {
                        this.intent.setSourceBounds(new Rect(this.pendingOptions.getStartX(), this.pendingOptions.getStartY(), this.pendingOptions.getStartX() + this.pendingOptions.getWidth(), this.pendingOptions.getStartY() + this.pendingOptions.getHeight()));
                        break;
                    }
                    break;
                case C0569H.REPORT_LOSING_FOCUS /*3*/:
                case C0569H.DO_TRAVERSAL /*4*/:
                    if (animationType != 3) {
                        scaleUp = DEBUG_SAVED_STATE;
                    }
                    this.service.mWindowManager.overridePendingAppTransitionThumb(this.pendingOptions.getThumbnail(), this.pendingOptions.getStartX(), this.pendingOptions.getStartY(), this.pendingOptions.getOnAnimationStartListener(), scaleUp);
                    if (this.intent.getSourceBounds() == null) {
                        this.intent.setSourceBounds(new Rect(this.pendingOptions.getStartX(), this.pendingOptions.getStartY(), this.pendingOptions.getStartX() + this.pendingOptions.getThumbnail().getWidth(), this.pendingOptions.getStartY() + this.pendingOptions.getThumbnail().getHeight()));
                        break;
                    }
                    break;
                case C0569H.REPORT_APPLICATION_TOKEN_WINDOWS /*8*/:
                case C0569H.REPORT_APPLICATION_TOKEN_DRAWN /*9*/:
                    this.service.mWindowManager.overridePendingAppTransitionAspectScaledThumb(this.pendingOptions.getThumbnail(), this.pendingOptions.getStartX(), this.pendingOptions.getStartY(), this.pendingOptions.getWidth(), this.pendingOptions.getHeight(), this.pendingOptions.getOnAnimationStartListener(), animationType == 8 ? true : DEBUG_SAVED_STATE);
                    if (this.intent.getSourceBounds() == null) {
                        this.intent.setSourceBounds(new Rect(this.pendingOptions.getStartX(), this.pendingOptions.getStartY(), this.pendingOptions.getStartX() + this.pendingOptions.getWidth(), this.pendingOptions.getStartY() + this.pendingOptions.getHeight()));
                        break;
                    }
                    break;
                default:
                    Slog.e(TAG, "applyOptionsLocked: Unknown animationType=" + animationType);
                    break;
            }
            this.pendingOptions = null;
        }
    }

    ActivityOptions getOptionsForTargetActivityLocked() {
        return this.pendingOptions != null ? this.pendingOptions.forTargetActivity() : null;
    }

    void clearOptionsLocked() {
        if (this.pendingOptions != null) {
            this.pendingOptions.abort();
            this.pendingOptions = null;
        }
    }

    ActivityOptions takeOptionsLocked() {
        ActivityOptions opts = this.pendingOptions;
        this.pendingOptions = null;
        return opts;
    }

    void removeUriPermissionsLocked() {
        if (this.uriPermissions != null) {
            this.uriPermissions.removeUriPermissionsLocked();
            this.uriPermissions = null;
        }
    }

    void pauseKeyDispatchingLocked() {
        if (!this.keysPaused) {
            this.keysPaused = true;
            this.service.mWindowManager.pauseKeyDispatching(this.appToken);
        }
    }

    void resumeKeyDispatchingLocked() {
        if (this.keysPaused) {
            this.keysPaused = DEBUG_SAVED_STATE;
            this.service.mWindowManager.resumeKeyDispatching(this.appToken);
        }
    }

    void updateThumbnailLocked(Bitmap newThumbnail, CharSequence description) {
        if (newThumbnail != null && this.task.setLastThumbnail(newThumbnail) && isPersistable()) {
            this.mStackSupervisor.mService.notifyTaskPersisterLocked(this.task, DEBUG_SAVED_STATE);
        }
        this.task.lastDescription = description;
    }

    void startLaunchTickingLocked() {
        if (!ActivityManagerService.IS_USER_BUILD && this.launchTickTime == 0) {
            this.launchTickTime = SystemClock.uptimeMillis();
            continueLaunchTickingLocked();
        }
    }

    boolean continueLaunchTickingLocked() {
        if (this.launchTickTime == 0) {
            return DEBUG_SAVED_STATE;
        }
        ActivityStack stack = this.task.stack;
        Message msg = stack.mHandler.obtainMessage(HdmiCecKeycode.CEC_KEYCODE_TUNE_FUNCTION, this);
        stack.mHandler.removeMessages(HdmiCecKeycode.CEC_KEYCODE_TUNE_FUNCTION);
        stack.mHandler.sendMessageDelayed(msg, 500);
        return true;
    }

    void finishLaunchTickingLocked() {
        this.launchTickTime = 0;
        this.task.stack.mHandler.removeMessages(HdmiCecKeycode.CEC_KEYCODE_TUNE_FUNCTION);
    }

    public boolean mayFreezeScreenLocked(ProcessRecord app) {
        return (app == null || app.crashing || app.notResponding) ? DEBUG_SAVED_STATE : true;
    }

    public void startFreezingScreenLocked(ProcessRecord app, int configChanges) {
        if (mayFreezeScreenLocked(app)) {
            this.service.mWindowManager.startAppFreezingScreen(this.appToken, configChanges);
        }
    }

    public void stopFreezingScreenLocked(boolean force) {
        if (force || this.frozenBeforeDestroy) {
            this.frozenBeforeDestroy = DEBUG_SAVED_STATE;
            this.service.mWindowManager.stopAppFreezingScreen(this.appToken, force);
        }
    }

    public void reportFullyDrawnLocked() {
        long curTime = SystemClock.uptimeMillis();
        if (this.displayStartTime != 0) {
            reportLaunchTimeLocked(curTime);
        }
        if (this.fullyDrawnStartTime != 0) {
            long totalTime;
            ActivityStack stack = this.task.stack;
            long thisTime = curTime - this.fullyDrawnStartTime;
            if (stack.mFullyDrawnStartTime != 0) {
                totalTime = curTime - stack.mFullyDrawnStartTime;
            } else {
                totalTime = thisTime;
            }
            Trace.asyncTraceEnd(64, "drawing", APPLICATION_ACTIVITY_TYPE);
            EventLog.writeEvent(EventLogTags.AM_ACTIVITY_FULLY_DRAWN_TIME, new Object[]{Integer.valueOf(this.userId), Integer.valueOf(System.identityHashCode(this)), this.shortComponentName, Long.valueOf(thisTime), Long.valueOf(totalTime)});
            StringBuilder sb = this.service.mStringBuilder;
            sb.setLength(APPLICATION_ACTIVITY_TYPE);
            sb.append("Fully drawn ");
            sb.append(this.shortComponentName);
            sb.append(": ");
            TimeUtils.formatDuration(thisTime, sb);
            if (thisTime != totalTime) {
                sb.append(" (total ");
                TimeUtils.formatDuration(totalTime, sb);
                sb.append(")");
            }
            Log.i(TAG, sb.toString());
            if (totalTime > 0) {
                this.fullyDrawnStartTime = 0;
                stack.mFullyDrawnStartTime = 0;
            } else {
                this.fullyDrawnStartTime = 0;
                stack.mFullyDrawnStartTime = 0;
            }
        }
    }

    private void reportLaunchTimeLocked(long curTime) {
        long totalTime;
        ActivityStack stack = this.task.stack;
        long thisTime = curTime - this.displayStartTime;
        if (stack.mLaunchStartTime != 0) {
            totalTime = curTime - stack.mLaunchStartTime;
        } else {
            totalTime = thisTime;
        }
        Trace.asyncTraceEnd(64, "launching", APPLICATION_ACTIVITY_TYPE);
        EventLog.writeEvent(EventLogTags.AM_ACTIVITY_LAUNCH_TIME, new Object[]{Integer.valueOf(this.userId), Integer.valueOf(System.identityHashCode(this)), this.shortComponentName, Long.valueOf(thisTime), Long.valueOf(totalTime)});
        StringBuilder sb = this.service.mStringBuilder;
        sb.setLength(APPLICATION_ACTIVITY_TYPE);
        sb.append("Displayed ");
        sb.append(this.shortComponentName);
        sb.append(": ");
        TimeUtils.formatDuration(thisTime, sb);
        if (thisTime != totalTime) {
            sb.append(" (total ");
            TimeUtils.formatDuration(totalTime, sb);
            sb.append(")");
        }
        Log.i(TAG, sb.toString());
        this.mStackSupervisor.reportActivityLaunchedLocked(DEBUG_SAVED_STATE, this, thisTime, totalTime);
        if (totalTime > 0) {
            this.displayStartTime = 0;
            stack.mLaunchStartTime = 0;
        } else {
            this.displayStartTime = 0;
            stack.mLaunchStartTime = 0;
        }
    }

    public void windowsDrawn() {
        synchronized (this.service) {
            if (this.displayStartTime != 0) {
                reportLaunchTimeLocked(SystemClock.uptimeMillis());
            }
            this.mStackSupervisor.sendWaitingVisibleReportLocked(this);
            this.startTime = 0;
            finishLaunchTickingLocked();
            if (this.task != null) {
                this.task.hasBeenVisible = true;
            }
        }
    }

    public void windowsVisible() {
        synchronized (this.service) {
            this.mStackSupervisor.reportActivityVisibleLocked(this);
            if (!this.nowVisible) {
                this.nowVisible = true;
                this.lastVisibleTime = SystemClock.uptimeMillis();
                if (this.idle) {
                    int N = this.mStackSupervisor.mWaitingVisibleActivities.size();
                    if (N > 0) {
                        for (int i = APPLICATION_ACTIVITY_TYPE; i < N; i += HOME_ACTIVITY_TYPE) {
                            ((ActivityRecord) this.mStackSupervisor.mWaitingVisibleActivities.get(i)).waitingVisible = DEBUG_SAVED_STATE;
                        }
                        this.mStackSupervisor.mWaitingVisibleActivities.clear();
                        this.mStackSupervisor.scheduleIdleLocked();
                    }
                } else {
                    this.mStackSupervisor.processStoppingActivitiesLocked(DEBUG_SAVED_STATE);
                }
                this.service.scheduleAppGcsLocked();
            }
        }
        Log.i(TAG_TIMELINE, "Timeline: Activity_windows_visible id: " + this + " time:" + SystemClock.uptimeMillis());
    }

    public void windowsGone() {
        this.nowVisible = DEBUG_SAVED_STATE;
    }

    private ActivityRecord getWaitingHistoryRecordLocked() {
        ActivityRecord r;
        if (!this.waitingVisible) {
            return r;
        }
        ActivityStack stack = this.mStackSupervisor.getFocusedStack();
        r = stack.mResumedActivity;
        if (r == null) {
            r = stack.mPausingActivity;
        }
        if (r == null) {
            return this;
        }
        return r;
    }

    public boolean keyDispatchingTimedOut(String reason) {
        ActivityRecord r;
        ProcessRecord anrApp;
        synchronized (this.service) {
            r = getWaitingHistoryRecordLocked();
            anrApp = r != null ? r.app : null;
        }
        return this.service.inputDispatchingTimedOut(anrApp, r, this, DEBUG_SAVED_STATE, reason);
    }

    public long getKeyDispatchingTimeout() {
        long inputDispatchingTimeoutLocked;
        synchronized (this.service) {
            inputDispatchingTimeoutLocked = ActivityManagerService.getInputDispatchingTimeoutLocked(getWaitingHistoryRecordLocked());
        }
        return inputDispatchingTimeoutLocked;
    }

    public boolean isInterestingToUserLocked() {
        return (this.visible || this.nowVisible || this.state == ActivityState.PAUSING || this.state == ActivityState.RESUMED) ? true : DEBUG_SAVED_STATE;
    }

    public void setSleeping(boolean _sleeping) {
        if (this.sleeping != _sleeping && this.app != null && this.app.thread != null) {
            try {
                this.app.thread.scheduleSleeping(this.appToken, _sleeping);
                if (_sleeping && !this.mStackSupervisor.mGoingToSleepActivities.contains(this)) {
                    this.mStackSupervisor.mGoingToSleepActivities.add(this);
                }
                this.sleeping = _sleeping;
            } catch (RemoteException e) {
                Slog.w(TAG, "Exception thrown when sleeping: " + this.intent.getComponent(), e);
            }
        }
    }

    static void activityResumedLocked(IBinder token) {
        ActivityRecord r = forToken(token);
        r.icicle = null;
        r.haveState = DEBUG_SAVED_STATE;
    }

    static int getTaskForActivityLocked(IBinder token, boolean onlyRoot) {
        ActivityRecord r = forToken(token);
        if (r == null) {
            return -1;
        }
        TaskRecord task = r.task;
        int activityNdx = task.mActivities.indexOf(r);
        if (activityNdx < 0) {
            return -1;
        }
        if (!onlyRoot || activityNdx <= task.findEffectiveRootIndex()) {
            return task.taskId;
        }
        return -1;
    }

    static ActivityRecord isInStackLocked(IBinder token) {
        ActivityRecord r = forToken(token);
        if (r != null) {
            return r.task.stack.isInStackLocked(token);
        }
        return null;
    }

    static ActivityStack getStackLocked(IBinder token) {
        ActivityRecord r = isInStackLocked(token);
        if (r != null) {
            return r.task.stack;
        }
        return null;
    }

    final boolean isDestroyable() {
        if (this.finishing || this.app == null || this.state == ActivityState.DESTROYING || this.state == ActivityState.DESTROYED || this.task == null || this.task.stack == null || this == this.task.stack.mResumedActivity || this == this.task.stack.mPausingActivity || !this.haveState || !this.stopped || this.visible) {
            return DEBUG_SAVED_STATE;
        }
        return true;
    }

    private static String createImageFilename(long createTime, int taskId) {
        return String.valueOf(taskId) + ACTIVITY_ICON_SUFFIX + createTime + ".png";
    }

    void setTaskDescription(TaskDescription _taskDescription) {
        if (_taskDescription.getIconFilename() == null) {
            Bitmap icon = _taskDescription.getIcon();
            if (icon != null) {
                String iconFilename = createImageFilename(this.createTime, this.task.taskId);
                this.mStackSupervisor.mService.mTaskPersister.saveImage(icon, iconFilename);
                _taskDescription.setIconFilename(iconFilename);
            }
        }
        this.taskDescription = _taskDescription;
    }

    void saveToXml(XmlSerializer out) throws IOException, XmlPullParserException {
        out.attribute(null, ATTR_ID, String.valueOf(this.createTime));
        out.attribute(null, ATTR_LAUNCHEDFROMUID, String.valueOf(this.launchedFromUid));
        if (this.launchedFromPackage != null) {
            out.attribute(null, ATTR_LAUNCHEDFROMPACKAGE, this.launchedFromPackage);
        }
        if (this.resolvedType != null) {
            out.attribute(null, ATTR_RESOLVEDTYPE, this.resolvedType);
        }
        out.attribute(null, ATTR_COMPONENTSPECIFIED, String.valueOf(this.componentSpecified));
        out.attribute(null, ATTR_USERID, String.valueOf(this.userId));
        if (this.taskDescription != null) {
            this.taskDescription.saveToXml(out);
        }
        out.startTag(null, TAG_INTENT);
        this.intent.saveToXml(out);
        out.endTag(null, TAG_INTENT);
        if (isPersistable() && this.persistentState != null) {
            out.startTag(null, TAG_PERSISTABLEBUNDLE);
            this.persistentState.saveToXml(out);
            out.endTag(null, TAG_PERSISTABLEBUNDLE);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    static com.android.server.am.ActivityRecord restoreFromXml(org.xmlpull.v1.XmlPullParser r36, com.android.server.am.ActivityStackSupervisor r37) throws java.io.IOException, org.xmlpull.v1.XmlPullParserException {
        /*
        r5 = 0;
        r34 = 0;
        r13 = 0;
        r14 = 0;
        r6 = 0;
        r22 = 0;
        r9 = 0;
        r30 = -1;
        r33 = r36.getDepth();
        r35 = new android.app.ActivityManager$TaskDescription;
        r35.<init>();
        r4 = r36.getAttributeCount();
        r27 = r4 + -1;
    L_0x001a:
        if (r27 < 0) goto L_0x00c4;
    L_0x001c:
        r0 = r36;
        r1 = r27;
        r26 = r0.getAttributeName(r1);
        r0 = r36;
        r1 = r27;
        r28 = r0.getAttributeValue(r1);
        r4 = "id";
        r0 = r26;
        r4 = r4.equals(r0);
        if (r4 == 0) goto L_0x0041;
    L_0x0036:
        r4 = java.lang.Long.valueOf(r28);
        r30 = r4.longValue();
    L_0x003e:
        r27 = r27 + -1;
        goto L_0x001a;
    L_0x0041:
        r4 = "launched_from_uid";
        r0 = r26;
        r4 = r4.equals(r0);
        if (r4 == 0) goto L_0x0054;
    L_0x004b:
        r4 = java.lang.Integer.valueOf(r28);
        r13 = r4.intValue();
        goto L_0x003e;
    L_0x0054:
        r4 = "launched_from_package";
        r0 = r26;
        r4 = r4.equals(r0);
        if (r4 == 0) goto L_0x0061;
    L_0x005e:
        r14 = r28;
        goto L_0x003e;
    L_0x0061:
        r4 = "resolved_type";
        r0 = r26;
        r4 = r4.equals(r0);
        if (r4 == 0) goto L_0x006e;
    L_0x006b:
        r6 = r28;
        goto L_0x003e;
    L_0x006e:
        r4 = "component_specified";
        r0 = r26;
        r4 = r4.equals(r0);
        if (r4 == 0) goto L_0x0081;
    L_0x0078:
        r4 = java.lang.Boolean.valueOf(r28);
        r22 = r4.booleanValue();
        goto L_0x003e;
    L_0x0081:
        r4 = "user_id";
        r0 = r26;
        r4 = r4.equals(r0);
        if (r4 == 0) goto L_0x0094;
    L_0x008b:
        r4 = java.lang.Integer.valueOf(r28);
        r9 = r4.intValue();
        goto L_0x003e;
    L_0x0094:
        r4 = "task_description_";
        r0 = r26;
        r4 = r0.startsWith(r4);
        if (r4 == 0) goto L_0x00a8;
    L_0x009e:
        r0 = r35;
        r1 = r26;
        r2 = r28;
        r0.restoreFromXml(r1, r2);
        goto L_0x003e;
    L_0x00a8:
        r4 = "ActivityManager";
        r7 = new java.lang.StringBuilder;
        r7.<init>();
        r8 = "Unknown ActivityRecord attribute=";
        r7 = r7.append(r8);
        r0 = r26;
        r7 = r7.append(r0);
        r7 = r7.toString();
        android.util.Log.d(r4, r7);
        goto L_0x003e;
    L_0x00c4:
        r29 = r36.next();
        r4 = 1;
        r0 = r29;
        if (r0 == r4) goto L_0x011f;
    L_0x00cd:
        r4 = 3;
        r0 = r29;
        if (r0 != r4) goto L_0x00da;
    L_0x00d2:
        r4 = r36.getDepth();
        r0 = r33;
        if (r4 >= r0) goto L_0x011f;
    L_0x00da:
        r4 = 2;
        r0 = r29;
        if (r0 != r4) goto L_0x00c4;
    L_0x00df:
        r32 = r36.getName();
        r4 = "intent";
        r0 = r32;
        r4 = r4.equals(r0);
        if (r4 == 0) goto L_0x00f2;
    L_0x00ed:
        r5 = android.content.Intent.restoreFromXml(r36);
        goto L_0x00c4;
    L_0x00f2:
        r4 = "persistable_bundle";
        r0 = r32;
        r4 = r4.equals(r0);
        if (r4 == 0) goto L_0x0101;
    L_0x00fc:
        r34 = android.os.PersistableBundle.restoreFromXml(r36);
        goto L_0x00c4;
    L_0x0101:
        r4 = "ActivityManager";
        r7 = new java.lang.StringBuilder;
        r7.<init>();
        r8 = "restoreActivity: unexpected name=";
        r7 = r7.append(r8);
        r0 = r32;
        r7 = r7.append(r0);
        r7 = r7.toString();
        android.util.Slog.w(r4, r7);
        com.android.internal.util.XmlUtils.skipCurrentTag(r36);
        goto L_0x00c4;
    L_0x011f:
        if (r5 != 0) goto L_0x013a;
    L_0x0121:
        r4 = new org.xmlpull.v1.XmlPullParserException;
        r7 = new java.lang.StringBuilder;
        r7.<init>();
        r8 = "restoreActivity error intent=";
        r7 = r7.append(r8);
        r7 = r7.append(r5);
        r7 = r7.toString();
        r4.<init>(r7);
        throw r4;
    L_0x013a:
        r0 = r37;
        r11 = r0.mService;
        r7 = 0;
        r8 = 0;
        r4 = r37;
        r17 = r4.resolveActivity(r5, r6, r7, r8, r9);
        if (r17 != 0) goto L_0x016b;
    L_0x0148:
        r4 = new org.xmlpull.v1.XmlPullParserException;
        r7 = new java.lang.StringBuilder;
        r7.<init>();
        r8 = "restoreActivity resolver error. Intent=";
        r7 = r7.append(r8);
        r7 = r7.append(r5);
        r8 = " resolvedType=";
        r7 = r7.append(r8);
        r7 = r7.append(r6);
        r7 = r7.toString();
        r4.<init>(r7);
        throw r4;
    L_0x016b:
        r10 = new com.android.server.am.ActivityRecord;
        r12 = 0;
        r18 = r11.getConfiguration();
        r19 = 0;
        r20 = 0;
        r21 = 0;
        r24 = 0;
        r25 = 0;
        r15 = r5;
        r16 = r6;
        r23 = r37;
        r10.<init>(r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25);
        r0 = r34;
        r10.persistentState = r0;
        r0 = r35;
        r10.taskDescription = r0;
        r0 = r30;
        r10.createTime = r0;
        return r10;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.ActivityRecord.restoreFromXml(org.xmlpull.v1.XmlPullParser, com.android.server.am.ActivityStackSupervisor):com.android.server.am.ActivityRecord");
    }

    private static String activityTypeToString(int type) {
        switch (type) {
            case APPLICATION_ACTIVITY_TYPE /*0*/:
                return "APPLICATION_ACTIVITY_TYPE";
            case HOME_ACTIVITY_TYPE /*1*/:
                return "HOME_ACTIVITY_TYPE";
            case RECENTS_ACTIVITY_TYPE /*2*/:
                return "RECENTS_ACTIVITY_TYPE";
            default:
                return Integer.toString(type);
        }
    }

    public String toString() {
        if (this.stringName != null) {
            int i;
            String str;
            StringBuilder append = new StringBuilder().append(this.stringName).append(" t");
            if (this.task == null) {
                i = -1;
            } else {
                i = this.task.taskId;
            }
            append = append.append(i);
            if (this.finishing) {
                str = " f}";
            } else {
                str = "}";
            }
            return append.append(str).toString();
        }
        StringBuilder sb = new StringBuilder(DumpState.DUMP_PROVIDERS);
        sb.append("ActivityRecord{");
        sb.append(Integer.toHexString(System.identityHashCode(this)));
        sb.append(" u");
        sb.append(this.userId);
        sb.append(' ');
        sb.append(this.intent.getComponent().flattenToShortString());
        this.stringName = sb.toString();
        return toString();
    }
}
