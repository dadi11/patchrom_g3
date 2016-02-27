package com.android.server.am;

import android.app.ActivityManager;
import android.app.ActivityManager.ProcessErrorStateInfo;
import android.app.ActivityManager.RecentTaskInfo;
import android.app.ActivityManager.RunningAppProcessInfo;
import android.app.ActivityManager.RunningServiceInfo;
import android.app.ActivityManager.RunningTaskInfo;
import android.app.ActivityManager.StackInfo;
import android.app.ActivityManager.TaskDescription;
import android.app.ActivityManager.TaskThumbnail;
import android.app.ActivityManagerInternal;
import android.app.ActivityManagerNative;
import android.app.ActivityOptions;
import android.app.ActivityThread;
import android.app.AlertDialog;
import android.app.AppGlobals;
import android.app.ApplicationErrorReport;
import android.app.ApplicationErrorReport.AnrInfo;
import android.app.ApplicationErrorReport.CrashInfo;
import android.app.ApplicationThreadNative;
import android.app.Dialog;
import android.app.IActivityContainer;
import android.app.IActivityContainerCallback;
import android.app.IActivityController;
import android.app.IActivityManager.ContentProviderHolder;
import android.app.IActivityManager.WaitResult;
import android.app.IAppTask;
import android.app.IApplicationThread;
import android.app.IInstrumentationWatcher;
import android.app.INotificationManager;
import android.app.IProcessObserver;
import android.app.IServiceConnection;
import android.app.IStopUserCallback;
import android.app.ITaskStackListener;
import android.app.IUiAutomationConnection;
import android.app.IUserSwitchObserver;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.ProfilerInfo;
import android.app.admin.DevicePolicyManager;
import android.app.backup.IBackupManager;
import android.app.usage.UsageStatsManagerInternal;
import android.content.ActivityNotFoundException;
import android.content.BroadcastReceiver;
import android.content.ClipData;
import android.content.ComponentName;
import android.content.ContentProvider;
import android.content.ContentResolver;
import android.content.Context;
import android.content.IContentProvider;
import android.content.IIntentReceiver;
import android.content.IIntentReceiver.Stub;
import android.content.IIntentSender;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.IntentSender;
import android.content.UriPermission;
import android.content.pm.ActivityInfo;
import android.content.pm.ApplicationInfo;
import android.content.pm.ConfigurationInfo;
import android.content.pm.IPackageManager;
import android.content.pm.InstrumentationInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.ParceledListSlice;
import android.content.pm.PathPermission;
import android.content.pm.ProviderInfo;
import android.content.pm.ResolveInfo;
import android.content.pm.UserInfo;
import android.content.res.CompatibilityInfo;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.Point;
import android.graphics.Rect;
import android.net.ProxyInfo;
import android.net.Uri;
import android.os.Binder;
import android.os.Build;
import android.os.Build.VERSION;
import android.os.Bundle;
import android.os.Debug;
import android.os.Debug.MemoryInfo;
import android.os.DropBoxManager;
import android.os.Environment;
import android.os.FactoryTest;
import android.os.FileObserver;
import android.os.FileUtils;
import android.os.Handler;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.IPermissionController;
import android.os.IRemoteCallback;
import android.os.IUserManager;
import android.os.Looper;
import android.os.Message;
import android.os.Parcel;
import android.os.ParcelFileDescriptor;
import android.os.PersistableBundle;
import android.os.Process;
import android.os.Process.ProcessStartResult;
import android.os.RemoteCallbackList;
import android.os.RemoteException;
import android.os.SELinux;
import android.os.ServiceManager;
import android.os.StrictMode.ViolationInfo;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.os.UpdateLock;
import android.os.UserHandle;
import android.os.storage.IMountService;
import android.provider.Settings.Global;
import android.provider.Settings.Secure;
import android.provider.Settings.System;
import android.service.voice.IVoiceInteractionSession;
import android.util.ArrayMap;
import android.util.ArraySet;
import android.util.AtomicFile;
import android.util.EventLog;
import android.util.Log;
import android.util.Pair;
import android.util.PrintWriterPrinter;
import android.util.Slog;
import android.util.SparseArray;
import android.util.SparseIntArray;
import android.util.TimeUtils;
import android.util.Xml;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.view.WindowManager.LayoutParams;
import com.android.internal.annotations.GuardedBy;
import com.android.internal.app.IAppOpsService;
import com.android.internal.app.IVoiceInteractor;
import com.android.internal.app.ProcessMap;
import com.android.internal.os.BackgroundThread;
import com.android.internal.os.BatteryStatsImpl;
import com.android.internal.os.BatteryStatsImpl.BatteryCallback;
import com.android.internal.os.BatteryStatsImpl.Uid.Pkg.Serv;
import com.android.internal.os.BatteryStatsImpl.Uid.Proc;
import com.android.internal.os.ProcessCpuTracker;
import com.android.internal.os.ProcessCpuTracker.Stats;
import com.android.internal.os.TransferPipe;
import com.android.internal.util.FastXmlSerializer;
import com.android.internal.util.MemInfoReader;
import com.android.internal.util.Preconditions;
import com.android.internal.util.XmlUtils;
import com.android.server.AppOpsService;
import com.android.server.AttributeCache;
import com.android.server.IntentResolver;
import com.android.server.LocalServices;
import com.android.server.ServiceThread;
import com.android.server.SystemService;
import com.android.server.SystemServiceManager;
import com.android.server.Watchdog;
import com.android.server.Watchdog.Monitor;
import com.android.server.am.UriPermission.PersistedTimeComparator;
import com.android.server.am.UriPermission.Snapshot;
import com.android.server.firewall.IntentFirewall;
import com.android.server.firewall.IntentFirewall.AMSInterface;
import com.android.server.location.LocationFudger;
import com.android.server.pm.Installer;
import com.android.server.pm.UserManagerService;
import com.android.server.statusbar.StatusBarManagerInternal;
import com.android.server.wm.AppTransition;
import com.android.server.wm.WindowManagerService;
import com.android.server.wm.WindowManagerService.C0569H;
import com.google.android.collect.Lists;
import com.google.android.collect.Maps;
import dalvik.system.VMRuntime;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileDescriptor;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.lang.ref.WeakReference;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map.Entry;
import java.util.Set;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicLong;
import libcore.io.IoUtils;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

public final class ActivityManagerService extends ActivityManagerNative implements Monitor, BatteryCallback {
    static final int ALLOW_FULL_ONLY = 2;
    static final int ALLOW_NON_FULL = 0;
    static final int ALLOW_NON_FULL_IN_PROFILE = 1;
    static final long APP_SWITCH_DELAY_TIME = 5000;
    private static final String ATTR_CREATED_TIME = "createdTime";
    private static final String ATTR_MODE_FLAGS = "modeFlags";
    private static final String ATTR_PREFIX = "prefix";
    private static final String ATTR_SOURCE_PKG = "sourcePkg";
    private static final String ATTR_SOURCE_USER_ID = "sourceUserId";
    private static final String ATTR_TARGET_PKG = "targetPkg";
    private static final String ATTR_TARGET_USER_ID = "targetUserId";
    private static final String ATTR_URI = "uri";
    private static final String ATTR_USER_HANDLE = "userHandle";
    static final long BATTERY_STATS_TIME = 1800000;
    static final int BROADCAST_BG_TIMEOUT = 60000;
    static final int BROADCAST_FG_TIMEOUT = 10000;
    static final String CALLED_PRE_BOOTS_FILENAME = "called_pre_boots.dat";
    static final int CANCEL_HEAVY_NOTIFICATION_MSG = 25;
    static final int CHECK_EXCESSIVE_WAKE_LOCKS_MSG = 27;
    static final int CLEAR_DNS_CACHE_MSG = 28;
    static final int COLLECT_PSS_BG_MSG = 1;
    static final int CONTINUE_USER_SWITCH_MSG = 35;
    static final int CPU_MIN_CHECK_DURATION = 300000;
    static final boolean DEBUG = false;
    static final boolean DEBUG_BACKGROUND_BROADCAST = false;
    static final boolean DEBUG_BACKUP = false;
    static final boolean DEBUG_BROADCAST = false;
    static final boolean DEBUG_BROADCAST_LIGHT = false;
    static final boolean DEBUG_CLEANUP = false;
    static final boolean DEBUG_CONFIGURATION = false;
    static final boolean DEBUG_FOCUS = false;
    static final boolean DEBUG_IMMERSIVE = false;
    static final boolean DEBUG_LOCKSCREEN = false;
    static final boolean DEBUG_LRU = false;
    static final boolean DEBUG_MU = false;
    static final boolean DEBUG_OOM_ADJ = false;
    static final boolean DEBUG_PAUSE = false;
    static final boolean DEBUG_POWER = false;
    static final boolean DEBUG_POWER_QUICK = false;
    static final boolean DEBUG_PROCESSES = false;
    static final boolean DEBUG_PROCESS_OBSERVERS = false;
    static final boolean DEBUG_PROVIDER = false;
    static final boolean DEBUG_PSS = false;
    static final boolean DEBUG_RECENTS = false;
    static final boolean DEBUG_RESULTS = false;
    static final boolean DEBUG_SERVICE = false;
    static final boolean DEBUG_SERVICE_EXECUTING = false;
    static final boolean DEBUG_STACK = false;
    static final boolean DEBUG_SWITCH = false;
    static final boolean DEBUG_TASKS = false;
    static final boolean DEBUG_THUMBNAILS = false;
    static final boolean DEBUG_TRANSITION = false;
    static final boolean DEBUG_URI_PERMISSION = false;
    static final boolean DEBUG_USER_LEAVING = false;
    static final boolean DEBUG_VISBILITY = false;
    static final int DISMISS_DIALOG_MSG = 48;
    static final int DISPATCH_PROCESSES_CHANGED = 31;
    static final int DISPATCH_PROCESS_DIED = 32;
    static final int DO_PENDING_ACTIVITY_LAUNCHES_MSG = 21;
    static final int DROPBOX_MAX_SIZE = 262144;
    static final long[] DUMP_MEM_BUCKETS;
    static final int[] DUMP_MEM_OOM_ADJ;
    static final String[] DUMP_MEM_OOM_COMPACT_LABEL;
    static final String[] DUMP_MEM_OOM_LABEL;
    static final String[] EMPTY_STRING_ARRAY;
    static final int ENTER_ANIMATION_COMPLETE_MSG = 44;
    static final int FINALIZE_PENDING_INTENT_MSG = 23;
    static final int FINISH_BOOTING_MSG = 45;
    static final int FIRST_ACTIVITY_STACK_MSG = 100;
    static final int FIRST_BROADCAST_QUEUE_MSG = 200;
    static final int FIRST_COMPAT_MODE_MSG = 300;
    static final int FIRST_SUPERVISOR_STACK_MSG = 100;
    static final int FULL_PSS_LOWERED_INTERVAL = 120000;
    static final int FULL_PSS_MIN_INTERVAL = 600000;
    static final int GC_BACKGROUND_PROCESSES_MSG = 5;
    static final int GC_MIN_INTERVAL = 60000;
    static final int GC_TIMEOUT = 5000;
    static final int IMMERSIVE_MODE_LOCK_MSG = 37;
    static final int INSTRUMENTATION_KEY_DISPATCHING_TIMEOUT = 60000;
    static final boolean IS_USER_BUILD;
    static final int KEY_DISPATCHING_TIMEOUT = 5000;
    static final int KILL_APPLICATION_MSG = 22;
    private static final int KSM_SHARED = 0;
    private static final int KSM_SHARING = 1;
    private static final int KSM_UNSHARED = 2;
    private static final int KSM_VOLATILE = 3;
    static final int LAST_PREBOOT_DELIVERED_FILE_VERSION = 10000;
    static final int LOCK_SCREEN_HIDDEN = 0;
    static final int LOCK_SCREEN_LEAVING = 1;
    static final int LOCK_SCREEN_SHOWN = 2;
    private static final int MAX_DUP_SUPPRESSED_STACKS = 5000;
    static final int MAX_PERSISTED_URI_GRANTS = 128;
    static final int MAX_RECENT_BITMAPS = 3;
    static final int MAX_RUNNING_USERS = 3;
    static final long MONITOR_CPU_MAX_TIME = 268435455;
    static final long MONITOR_CPU_MIN_TIME = 5000;
    static final boolean MONITOR_CPU_USAGE = true;
    static final boolean MONITOR_THREAD_CPU_USAGE = false;
    static final int MY_PID;
    static final int NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY = 1000;
    static final int NOTIFY_TASK_STACK_CHANGE_LISTENERS_MSG = 49;
    static final int PENDING_ASSIST_EXTRAS_TIMEOUT = 500;
    static final int PERSIST_URI_GRANTS_MSG = 38;
    static final int POST_HEAVY_NOTIFICATION_MSG = 24;
    static final int POWER_CHECK_DELAY = 900000;
    static final int PROC_START_TIMEOUT = 10000;
    static final int PROC_START_TIMEOUT_MSG = 20;
    static final int PROC_START_TIMEOUT_WITH_WRAPPER = 1200000;
    static final int REPORT_MEM_USAGE_MSG = 33;
    static final int REPORT_USER_SWITCH_MSG = 34;
    static final int REQUEST_ALL_PSS_MSG = 39;
    static final int SEND_LOCALE_TO_MOUNT_DAEMON_MSG = 47;
    static final int SERVICE_TIMEOUT_MSG = 12;
    static final boolean SHOW_ACTIVITY_START_TIME = true;
    static final int SHOW_COMPAT_MODE_DIALOG_MSG = 30;
    static final int SHOW_ERROR_MSG = 1;
    static final int SHOW_FACTORY_ERROR_MSG = 3;
    static final int SHOW_FINGERPRINT_ERROR_MSG = 15;
    static final int SHOW_NOT_RESPONDING_MSG = 2;
    static final int SHOW_STRICT_MODE_VIOLATION_MSG = 26;
    static final int SHOW_UID_ERROR_MSG = 14;
    static final int START_PROFILES_MSG = 40;
    static final int START_USER_SWITCH_MSG = 46;
    static final int STOCK_PM_FLAGS = 1024;
    private static final String SYSTEM_DEBUGGABLE = "ro.debuggable";
    static final int SYSTEM_USER_CURRENT_MSG = 43;
    static final int SYSTEM_USER_START_MSG = 42;
    static final String TAG = "ActivityManager";
    static final String TAG_MU = "ActivityManagerServiceMU";
    private static final String TAG_URI_GRANT = "uri-grant";
    private static final String TAG_URI_GRANTS = "uri-grants";
    static final int UPDATE_CONFIGURATION_MSG = 4;
    static final int UPDATE_HTTP_PROXY_MSG = 29;
    static final int UPDATE_TIME = 41;
    static final int UPDATE_TIME_ZONE = 13;
    private static final String USER_DATA_DIR = "/data/user/";
    static final int USER_SWITCH_TIMEOUT = 2000;
    static final int USER_SWITCH_TIMEOUT_MSG = 36;
    static final boolean VALIDATE_TOKENS = false;
    static final int WAIT_FOR_DEBUGGER_MSG = 6;
    static final int WAKE_LOCK_MIN_CHECK_DURATION = 300000;
    static final boolean localLOGV = false;
    private static final ThreadLocal<Identity> sCallerIdentity;
    final int GL_ES_VERSION;
    ProcessChangeItem[] mActiveProcessChanges;
    int mAdjSeq;
    boolean mAllowLowerMemLevel;
    private final HashSet<Integer> mAlreadyLoggedViolatedStacks;
    boolean mAlwaysFinishActivities;
    HashMap<String, IBinder> mAppBindArgs;
    final AppOpsService mAppOpsService;
    long mAppSwitchesAllowedTime;
    final SparseArray<ArrayMap<ComponentName, SparseArray<ArrayMap<String, Association>>>> mAssociations;
    boolean mAutoStopProfiler;
    final ArrayList<ProcessChangeItem> mAvailProcessChanges;
    String mBackupAppName;
    BackupRecord mBackupTarget;
    final ProcessMap<BadProcessInfo> mBadProcesses;
    final BatteryStatsService mBatteryStatsService;
    BroadcastQueue mBgBroadcastQueue;
    final Handler mBgHandler;
    boolean mBootAnimationComplete;
    boolean mBooted;
    boolean mBooting;
    final BroadcastQueue[] mBroadcastQueues;
    boolean mCallFinishBooting;
    boolean mCheckedForSetup;
    CompatModeDialog mCompatModeDialog;
    final CompatModePackages mCompatModePackages;
    Configuration mConfiguration;
    int mConfigurationSeq;
    Context mContext;
    IActivityController mController;
    CoreSettingsObserver mCoreSettingsObserver;
    private String mCurResumedPackage;
    private int mCurResumedUid;
    Object mCurUserSwitchCallback;
    int[] mCurrentProfileIds;
    int mCurrentUserId;
    String mDebugApp;
    boolean mDebugTransient;
    boolean mDidAppSwitch;
    boolean mDidDexOpt;
    boolean mDidUpdate;
    int mFactoryTest;
    BroadcastQueue mFgBroadcastQueue;
    ActivityRecord mFocusedActivity;
    final ProcessMap<ArrayList<ProcessRecord>> mForegroundPackages;
    final SparseArray<ForegroundToken> mForegroundProcesses;
    boolean mFullPssPending;
    private final AtomicFile mGrantFile;
    @GuardedBy("this")
    private final SparseArray<ArrayMap<GrantUri, UriPermission>> mGrantedUriPermissions;
    final MainHandler mHandler;
    final ServiceThread mHandlerThread;
    boolean mHasRecents;
    ProcessRecord mHeavyWeightProcess;
    ProcessRecord mHomeProcess;
    private Installer mInstaller;
    public IntentFirewall mIntentFirewall;
    final HashMap<Key, WeakReference<PendingIntentRecord>> mIntentSenderRecords;
    final SparseArray<ProcessRecord> mIsolatedProcesses;
    ActivityInfo mLastAddedTaskActivity;
    ComponentName mLastAddedTaskComponent;
    int mLastAddedTaskUid;
    final AtomicLong mLastCpuTime;
    long mLastFullPssTime;
    long mLastIdleTime;
    long mLastMemUsageReportTime;
    int mLastMemoryLevel;
    int mLastNumProcesses;
    long mLastPowerCheckRealtime;
    long mLastPowerCheckUptime;
    long mLastWriteTime;
    boolean mLaunchWarningShown;
    final ArrayList<ContentProviderRecord> mLaunchingProviders;
    int mLockScreenShown;
    long mLowRamStartTime;
    long mLowRamTimeSinceLastIdle;
    int mLruProcessActivityStart;
    int mLruProcessServiceStart;
    final ArrayList<ProcessRecord> mLruProcesses;
    int mLruSeq;
    int mNewNumAServiceProcs;
    int mNewNumServiceProcs;
    int mNextIsolatedProcessUid;
    int mNumCachedHiddenProcs;
    int mNumNonCachedProcs;
    int mNumServiceProcs;
    boolean mOnBattery;
    String mOpenGlTraceApp;
    String mOrigDebugApp;
    boolean mOrigWaitForDebugger;
    final ArrayList<PendingAssistExtras> mPendingAssistExtras;
    final ArrayList<ProcessChangeItem> mPendingProcessChanges;
    final ArrayList<ProcessRecord> mPendingPssProcesses;
    final ArrayList<ProcessRecord> mPersistentStartingProcesses;
    final SparseArray<ProcessRecord> mPidsSelfLocked;
    ProcessRecord mPreviousProcess;
    long mPreviousProcessVisibleTime;
    final AtomicBoolean mProcessCpuMutexFree;
    final Thread mProcessCpuThread;
    final ProcessCpuTracker mProcessCpuTracker;
    final ProcessMap<Long> mProcessCrashTimes;
    int mProcessLimit;
    int mProcessLimitOverride;
    final ProcessList mProcessList;
    final ProcessMap<ProcessRecord> mProcessNames;
    final RemoteCallbackList<IProcessObserver> mProcessObservers;
    final ProcessStatsService mProcessStats;
    final ArrayList<ProcessRecord> mProcessesOnHold;
    boolean mProcessesReady;
    final ArrayList<ProcessRecord> mProcessesToGc;
    String mProfileApp;
    ParcelFileDescriptor mProfileFd;
    String mProfileFile;
    ProcessRecord mProfileProc;
    int mProfileType;
    final ProviderMap mProviderMap;
    final IntentResolver<BroadcastFilter, BroadcastFilter> mReceiverResolver;
    ArrayList<TaskRecord> mRecentTasks;
    final HashMap<IBinder, ReceiverList> mRegisteredReceivers;
    final ArrayList<ProcessRecord> mRemovedProcesses;
    private boolean mRunningVoice;
    boolean mSafeMode;
    int mSamplingInterval;
    final ActiveServices mServices;
    private boolean mShowDialogs;
    boolean mShuttingDown;
    private boolean mSleeping;
    ActivityStackSupervisor mStackSupervisor;
    int[] mStartedUserArray;
    final SparseArray<UserStartedState> mStartedUsers;
    final SparseArray<ArrayMap<String, ArrayList<Intent>>> mStickyBroadcasts;
    private final StringBuilder mStrictModeBuffer;
    final StringBuilder mStringBuilder;
    boolean mSystemReady;
    SystemServiceManager mSystemServiceManager;
    final ActivityThread mSystemThread;
    int mTargetUserId;
    final TaskPersister mTaskPersister;
    private Comparator<TaskRecord> mTaskRecordComparator;
    private RemoteCallbackList<ITaskStackListener> mTaskStackListeners;
    boolean mTestPssMode;
    int mThumbnailHeight;
    int mThumbnailWidth;
    final long[] mTmpLong;
    ArrayList<TaskRecord> mTmpRecents;
    String mTopAction;
    ComponentName mTopComponent;
    String mTopData;
    boolean mTrackingAssociations;
    final UpdateLock mUpdateLock;
    UsageStatsManagerInternal mUsageStatsService;
    private boolean mUserIsMonkey;
    final ArrayList<Integer> mUserLru;
    private UserManagerService mUserManager;
    SparseIntArray mUserProfileGroupIdsSelfLocked;
    final RemoteCallbackList<IUserSwitchObserver> mUserSwitchObservers;
    boolean mWaitForDebugger;
    boolean mWaitingUpdate;
    private int mWakefulness;
    WindowManagerService mWindowManager;

    /* renamed from: com.android.server.am.ActivityManagerService.10 */
    class AnonymousClass10 implements Runnable {
        final /* synthetic */ boolean val$aboveSystem;
        final /* synthetic */ ActivityRecord val$activity;
        final /* synthetic */ String val$annotation;
        final /* synthetic */ ActivityRecord val$parent;
        final /* synthetic */ ProcessRecord val$proc;

        AnonymousClass10(ProcessRecord processRecord, ActivityRecord activityRecord, ActivityRecord activityRecord2, boolean z, String str) {
            this.val$proc = processRecord;
            this.val$activity = activityRecord;
            this.val$parent = activityRecord2;
            this.val$aboveSystem = z;
            this.val$annotation = str;
        }

        public void run() {
            ActivityManagerService.this.appNotResponding(this.val$proc, this.val$activity, this.val$parent, this.val$aboveSystem, this.val$annotation);
        }
    }

    /* renamed from: com.android.server.am.ActivityManagerService.13 */
    class AnonymousClass13 extends Stub {
        final /* synthetic */ Runnable val$onFinishCallback;

        AnonymousClass13(Runnable runnable) {
            this.val$onFinishCallback = runnable;
        }

        public void performReceive(Intent intent, int resultCode, String data, Bundle extras, boolean ordered, boolean sticky, int sendingUser) {
            ActivityManagerService.this.mHandler.post(this.val$onFinishCallback);
        }
    }

    /* renamed from: com.android.server.am.ActivityManagerService.14 */
    class AnonymousClass14 implements Runnable {
        final /* synthetic */ ArrayList val$doneReceivers;
        final /* synthetic */ Runnable val$goingCallback;

        AnonymousClass14(ArrayList arrayList, Runnable runnable) {
            this.val$doneReceivers = arrayList;
            this.val$goingCallback = runnable;
        }

        public void run() {
            synchronized (ActivityManagerService.this) {
                ActivityManagerService.this.mDidUpdate = ActivityManagerService.SHOW_ACTIVITY_START_TIME;
            }
            ActivityManagerService.writeLastDonePreBootReceivers(this.val$doneReceivers);
            ActivityManagerService.this.showBootMessage(ActivityManagerService.this.mContext.getText(17040552), ActivityManagerService.VALIDATE_TOKENS);
            ActivityManagerService.this.systemReady(this.val$goingCallback);
        }
    }

    /* renamed from: com.android.server.am.ActivityManagerService.16 */
    class AnonymousClass16 extends Thread {
        final /* synthetic */ DropBoxManager val$dbox;
        final /* synthetic */ String val$dropboxTag;
        final /* synthetic */ StringBuilder val$sb;

        AnonymousClass16(String x0, StringBuilder stringBuilder, DropBoxManager dropBoxManager, String str) {
            this.val$sb = stringBuilder;
            this.val$dbox = dropBoxManager;
            this.val$dropboxTag = str;
            super(x0);
        }

        public void run() {
            synchronized (this.val$sb) {
                String report = this.val$sb.toString();
                this.val$sb.delete(ActivityManagerService.MY_PID, this.val$sb.length());
                this.val$sb.trimToSize();
            }
            if (report.length() != 0) {
                this.val$dbox.addText(this.val$dropboxTag, report);
            }
        }
    }

    /* renamed from: com.android.server.am.ActivityManagerService.17 */
    class AnonymousClass17 extends Thread {
        final /* synthetic */ DropBoxManager val$dbox;
        final /* synthetic */ String val$dropboxTag;

        AnonymousClass17(String x0, DropBoxManager dropBoxManager, String str) {
            this.val$dbox = dropBoxManager;
            this.val$dropboxTag = str;
            super(x0);
        }

        public void run() {
            try {
                Thread.sleep(ActivityManagerService.MONITOR_CPU_MIN_TIME);
            } catch (InterruptedException e) {
            }
            synchronized (ActivityManagerService.this.mStrictModeBuffer) {
                String errorReport = ActivityManagerService.this.mStrictModeBuffer.toString();
                if (errorReport.length() == 0) {
                    return;
                }
                ActivityManagerService.this.mStrictModeBuffer.delete(ActivityManagerService.MY_PID, ActivityManagerService.this.mStrictModeBuffer.length());
                ActivityManagerService.this.mStrictModeBuffer.trimToSize();
                this.val$dbox.addText(this.val$dropboxTag, errorReport);
            }
        }
    }

    /* renamed from: com.android.server.am.ActivityManagerService.18 */
    class AnonymousClass18 implements Runnable {
        final /* synthetic */ IBinder val$app;
        final /* synthetic */ int val$callingPid;
        final /* synthetic */ int val$callingUid;
        final /* synthetic */ CrashInfo val$crashInfo;
        final /* synthetic */ String val$tag;

        AnonymousClass18(int i, int i2, IBinder iBinder, String str, CrashInfo crashInfo) {
            this.val$callingUid = i;
            this.val$callingPid = i2;
            this.val$app = iBinder;
            this.val$tag = str;
            this.val$crashInfo = crashInfo;
        }

        public void run() {
            ActivityManagerService.this.handleApplicationWtfInner(this.val$callingUid, this.val$callingPid, this.val$app, this.val$tag, this.val$crashInfo);
        }
    }

    /* renamed from: com.android.server.am.ActivityManagerService.19 */
    class AnonymousClass19 extends Thread {
        final /* synthetic */ CrashInfo val$crashInfo;
        final /* synthetic */ DropBoxManager val$dbox;
        final /* synthetic */ String val$dropboxTag;
        final /* synthetic */ File val$logFile;
        final /* synthetic */ String val$report;
        final /* synthetic */ StringBuilder val$sb;

        AnonymousClass19(String x0, String str, StringBuilder stringBuilder, File file, CrashInfo crashInfo, String str2, DropBoxManager dropBoxManager) {
            this.val$report = str;
            this.val$sb = stringBuilder;
            this.val$logFile = file;
            this.val$crashInfo = crashInfo;
            this.val$dropboxTag = str2;
            this.val$dbox = dropBoxManager;
            super(x0);
        }

        public void run() {
            IOException e;
            Throwable th;
            if (this.val$report != null) {
                this.val$sb.append(this.val$report);
            }
            if (this.val$logFile != null) {
                try {
                    this.val$sb.append(FileUtils.readTextFile(this.val$logFile, ActivityManagerService.DROPBOX_MAX_SIZE, "\n\n[[TRUNCATED]]"));
                } catch (IOException e2) {
                    Slog.e(ActivityManagerService.TAG, "Error reading " + this.val$logFile, e2);
                }
            }
            if (!(this.val$crashInfo == null || this.val$crashInfo.stackTrace == null)) {
                this.val$sb.append(this.val$crashInfo.stackTrace);
            }
            int lines = Global.getInt(ActivityManagerService.this.mContext.getContentResolver(), "logcat_for_" + this.val$dropboxTag, ActivityManagerService.MY_PID);
            if (lines > 0) {
                this.val$sb.append("\n");
                InputStreamReader inputStreamReader = null;
                try {
                    String[] strArr = new String[ActivityManagerService.UPDATE_TIME_ZONE];
                    strArr[ActivityManagerService.MY_PID] = "/system/bin/logcat";
                    strArr[ActivityManagerService.SHOW_ERROR_MSG] = "-v";
                    strArr[ActivityManagerService.SHOW_NOT_RESPONDING_MSG] = "time";
                    strArr[ActivityManagerService.SHOW_FACTORY_ERROR_MSG] = "-b";
                    strArr[ActivityManagerService.UPDATE_CONFIGURATION_MSG] = "events";
                    strArr[ActivityManagerService.GC_BACKGROUND_PROCESSES_MSG] = "-b";
                    strArr[ActivityManagerService.WAIT_FOR_DEBUGGER_MSG] = "system";
                    strArr[7] = "-b";
                    strArr[8] = "main";
                    strArr[9] = "-b";
                    strArr[10] = "crash";
                    strArr[11] = "-t";
                    strArr[ActivityManagerService.SERVICE_TIMEOUT_MSG] = String.valueOf(lines);
                    Process logcat = new ProcessBuilder(strArr).redirectErrorStream(ActivityManagerService.SHOW_ACTIVITY_START_TIME).start();
                    try {
                        logcat.getOutputStream().close();
                    } catch (IOException e3) {
                    }
                    try {
                        logcat.getErrorStream().close();
                    } catch (IOException e4) {
                    }
                    InputStreamReader input = new InputStreamReader(logcat.getInputStream());
                    try {
                        char[] buf = new char[DumpState.DUMP_INSTALLS];
                        while (true) {
                            int num = input.read(buf);
                            if (num <= 0) {
                                break;
                            }
                            this.val$sb.append(buf, ActivityManagerService.MY_PID, num);
                        }
                        if (input != null) {
                            try {
                                input.close();
                            } catch (IOException e5) {
                            }
                        }
                    } catch (IOException e6) {
                        e2 = e6;
                        inputStreamReader = input;
                        try {
                            Slog.e(ActivityManagerService.TAG, "Error running logcat", e2);
                            if (inputStreamReader != null) {
                                try {
                                    inputStreamReader.close();
                                } catch (IOException e7) {
                                }
                            }
                            this.val$dbox.addText(this.val$dropboxTag, this.val$sb.toString());
                        } catch (Throwable th2) {
                            th = th2;
                            if (inputStreamReader != null) {
                                try {
                                    inputStreamReader.close();
                                } catch (IOException e8) {
                                }
                            }
                            throw th;
                        }
                    } catch (Throwable th3) {
                        th = th3;
                        inputStreamReader = input;
                        if (inputStreamReader != null) {
                            inputStreamReader.close();
                        }
                        throw th;
                    }
                } catch (IOException e9) {
                    e2 = e9;
                    Slog.e(ActivityManagerService.TAG, "Error running logcat", e2);
                    if (inputStreamReader != null) {
                        inputStreamReader.close();
                    }
                    this.val$dbox.addText(this.val$dropboxTag, this.val$sb.toString());
                }
            }
            this.val$dbox.addText(this.val$dropboxTag, this.val$sb.toString());
        }
    }

    /* renamed from: com.android.server.am.ActivityManagerService.1 */
    class C01221 extends IntentResolver<BroadcastFilter, BroadcastFilter> {
        C01221() {
        }

        protected boolean allowFilterResult(BroadcastFilter filter, List<BroadcastFilter> dest) {
            IBinder target = filter.receiverList.receiver.asBinder();
            for (int i = dest.size() - 1; i >= 0; i--) {
                if (((BroadcastFilter) dest.get(i)).receiverList.receiver.asBinder() == target) {
                    return ActivityManagerService.VALIDATE_TOKENS;
                }
            }
            return ActivityManagerService.SHOW_ACTIVITY_START_TIME;
        }

        protected BroadcastFilter newResult(BroadcastFilter filter, int match, int userId) {
            if (userId == -1 || filter.owningUserId == -1 || userId == filter.owningUserId) {
                return (BroadcastFilter) super.newResult(filter, match, userId);
            }
            return null;
        }

        protected BroadcastFilter[] newArray(int size) {
            return new BroadcastFilter[size];
        }

        protected boolean isPackageForFilter(String packageName, BroadcastFilter filter) {
            return packageName.equals(filter.packageName);
        }
    }

    /* renamed from: com.android.server.am.ActivityManagerService.24 */
    class AnonymousClass24 extends Stub {
        final /* synthetic */ boolean val$foreground;
        final /* synthetic */ int val$oldUserId;
        final /* synthetic */ int val$userId;
        final /* synthetic */ UserStartedState val$uss;

        AnonymousClass24(UserStartedState userStartedState, boolean z, int i, int i2) {
            this.val$uss = userStartedState;
            this.val$foreground = z;
            this.val$oldUserId = i;
            this.val$userId = i2;
        }

        public void performReceive(Intent intent, int resultCode, String data, Bundle extras, boolean ordered, boolean sticky, int sendingUser) {
            ActivityManagerService.this.onUserInitialized(this.val$uss, this.val$foreground, this.val$oldUserId, this.val$userId);
        }
    }

    /* renamed from: com.android.server.am.ActivityManagerService.26 */
    class AnonymousClass26 extends IRemoteCallback.Stub {
        int mCount;
        final /* synthetic */ int val$N;
        final /* synthetic */ int val$newUserId;
        final /* synthetic */ int val$oldUserId;
        final /* synthetic */ UserStartedState val$uss;

        AnonymousClass26(int i, UserStartedState userStartedState, int i2, int i3) {
            this.val$N = i;
            this.val$uss = userStartedState;
            this.val$oldUserId = i2;
            this.val$newUserId = i3;
            this.mCount = ActivityManagerService.MY_PID;
        }

        public void sendResult(Bundle data) throws RemoteException {
            synchronized (ActivityManagerService.this) {
                if (ActivityManagerService.this.mCurUserSwitchCallback == this) {
                    this.mCount += ActivityManagerService.SHOW_ERROR_MSG;
                    if (this.mCount == this.val$N) {
                        ActivityManagerService.this.sendContinueUserSwitchLocked(this.val$uss, this.val$oldUserId, this.val$newUserId);
                    }
                }
            }
        }
    }

    /* renamed from: com.android.server.am.ActivityManagerService.27 */
    class AnonymousClass27 implements Runnable {
        final /* synthetic */ IStopUserCallback val$callback;
        final /* synthetic */ int val$userId;

        AnonymousClass27(IStopUserCallback iStopUserCallback, int i) {
            this.val$callback = iStopUserCallback;
            this.val$userId = i;
        }

        public void run() {
            try {
                this.val$callback.userStopped(this.val$userId);
            } catch (RemoteException e) {
            }
        }
    }

    /* renamed from: com.android.server.am.ActivityManagerService.28 */
    class AnonymousClass28 extends Stub {
        final /* synthetic */ UserStartedState val$uss;

        AnonymousClass28(UserStartedState userStartedState) {
            this.val$uss = userStartedState;
        }

        public void performReceive(Intent intent, int resultCode, String data, Bundle extras, boolean ordered, boolean sticky, int sendingUser) {
            ActivityManagerService.this.finishUserStop(this.val$uss);
        }
    }

    /* renamed from: com.android.server.am.ActivityManagerService.29 */
    class AnonymousClass29 extends Stub {
        final /* synthetic */ Intent val$shutdownIntent;
        final /* synthetic */ IIntentReceiver val$shutdownReceiver;
        final /* synthetic */ int val$userId;
        final /* synthetic */ UserStartedState val$uss;

        AnonymousClass29(UserStartedState userStartedState, int i, Intent intent, IIntentReceiver iIntentReceiver) {
            this.val$uss = userStartedState;
            this.val$userId = i;
            this.val$shutdownIntent = intent;
            this.val$shutdownReceiver = iIntentReceiver;
        }

        public void performReceive(Intent intent, int resultCode, String data, Bundle extras, boolean ordered, boolean sticky, int sendingUser) {
            synchronized (ActivityManagerService.this) {
                if (this.val$uss.mState != ActivityManagerService.SHOW_NOT_RESPONDING_MSG) {
                    return;
                }
                this.val$uss.mState = ActivityManagerService.SHOW_FACTORY_ERROR_MSG;
                ActivityManagerService.this.mBatteryStatsService.noteEvent(16391, Integer.toString(this.val$userId), this.val$userId);
                ActivityManagerService.this.mSystemServiceManager.stopUser(this.val$userId);
                ActivityManagerService.this.broadcastIntentLocked(null, null, this.val$shutdownIntent, null, this.val$shutdownReceiver, ActivityManagerService.MY_PID, null, null, null, -1, ActivityManagerService.SHOW_ACTIVITY_START_TIME, ActivityManagerService.VALIDATE_TOKENS, ActivityManagerService.MY_PID, ActivityManagerService.NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY, this.val$userId);
            }
        }
    }

    /* renamed from: com.android.server.am.ActivityManagerService.2 */
    class C01232 extends Handler {
        C01232(Looper x0) {
            super(x0);
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case ActivityManagerService.SHOW_ERROR_MSG /*1*/:
                    long start = SystemClock.uptimeMillis();
                    MemInfoReader memInfo = null;
                    synchronized (ActivityManagerService.this) {
                        if (ActivityManagerService.this.mFullPssPending) {
                            ActivityManagerService.this.mFullPssPending = ActivityManagerService.VALIDATE_TOKENS;
                            memInfo = new MemInfoReader();
                        }
                        break;
                    }
                    if (memInfo != null) {
                        ActivityManagerService.this.updateCpuStatsNow();
                        long nativeTotalPss = 0;
                        synchronized (ActivityManagerService.this.mProcessCpuTracker) {
                            int N = ActivityManagerService.this.mProcessCpuTracker.countStats();
                            for (int j = ActivityManagerService.MY_PID; j < N; j += ActivityManagerService.SHOW_ERROR_MSG) {
                                Stats st = ActivityManagerService.this.mProcessCpuTracker.getStats(j);
                                if (st.vsize > 0 && st.uid < ActivityManagerService.PROC_START_TIMEOUT) {
                                    synchronized (ActivityManagerService.this.mPidsSelfLocked) {
                                        if (ActivityManagerService.this.mPidsSelfLocked.indexOfKey(st.pid) < 0) {
                                            nativeTotalPss += Debug.getPss(st.pid, null, null);
                                            break;
                                        }
                                        break;
                                    }
                                    break;
                                }
                            }
                            break;
                        }
                        memInfo.readMemInfo();
                        synchronized (ActivityManagerService.this) {
                            ActivityManagerService.this.mProcessStats.addSysMemUsageLocked(memInfo.getCachedSizeKb(), memInfo.getFreeSizeKb(), memInfo.getZramTotalSizeKb(), memInfo.getKernelUsedSizeKb(), nativeTotalPss);
                            break;
                        }
                    }
                    int num = ActivityManagerService.MY_PID;
                    long[] tmp = new long[ActivityManagerService.SHOW_ERROR_MSG];
                    while (true) {
                        synchronized (ActivityManagerService.this) {
                            if (ActivityManagerService.this.mPendingPssProcesses.size() <= 0) {
                                if (ActivityManagerService.this.mTestPssMode) {
                                    Slog.d(ActivityManagerService.TAG, "Collected PSS of " + num + " processes in " + (SystemClock.uptimeMillis() - start) + "ms");
                                    break;
                                }
                                ActivityManagerService.this.mPendingPssProcesses.clear();
                                return;
                            }
                            int pid;
                            ProcessRecord proc = (ProcessRecord) ActivityManagerService.this.mPendingPssProcesses.remove(ActivityManagerService.MY_PID);
                            int procState = proc.pssProcState;
                            long lastPssTime = proc.lastPssTime;
                            if (proc.thread == null || procState != proc.setProcState || 1000 + lastPssTime >= SystemClock.uptimeMillis()) {
                                proc = null;
                                pid = ActivityManagerService.MY_PID;
                            } else {
                                pid = proc.pid;
                            }
                            if (proc != null) {
                                long pss = Debug.getPss(pid, tmp, null);
                                synchronized (ActivityManagerService.this) {
                                    if (pss != 0) {
                                        if (proc.thread != null && proc.setProcState == procState && proc.pid == pid && proc.lastPssTime == lastPssTime) {
                                            num += ActivityManagerService.SHOW_ERROR_MSG;
                                            ActivityManagerService.this.recordPssSample(proc, procState, pss, tmp[ActivityManagerService.MY_PID], SystemClock.uptimeMillis());
                                        }
                                        break;
                                    }
                                }
                            }
                            break;
                        }
                    }
                    break;
                default:
            }
        }
    }

    /* renamed from: com.android.server.am.ActivityManagerService.3 */
    class C01243 extends Thread {
        C01243(String x0) {
            super(x0);
        }

        public void run() {
            while (true) {
                try {
                    synchronized (this) {
                        long now = SystemClock.uptimeMillis();
                        long nextCpuDelay = (ActivityManagerService.this.mLastCpuTime.get() + ActivityManagerService.MONITOR_CPU_MAX_TIME) - now;
                        long nextWriteDelay = (ActivityManagerService.this.mLastWriteTime + ActivityManagerService.BATTERY_STATS_TIME) - now;
                        if (nextWriteDelay < nextCpuDelay) {
                            nextCpuDelay = nextWriteDelay;
                        }
                        if (nextCpuDelay > 0) {
                            ActivityManagerService.this.mProcessCpuMutexFree.set(ActivityManagerService.SHOW_ACTIVITY_START_TIME);
                            wait(nextCpuDelay);
                        }
                    }
                } catch (InterruptedException e) {
                }
                try {
                    ActivityManagerService.this.updateCpuStatsNow();
                } catch (Exception e2) {
                    Slog.e(ActivityManagerService.TAG, "Unexpected exception collecting process stats", e2);
                }
            }
        }
    }

    /* renamed from: com.android.server.am.ActivityManagerService.4 */
    class C01254 implements Comparator<TaskRecord> {
        C01254() {
        }

        public int compare(TaskRecord lhs, TaskRecord rhs) {
            return rhs.taskId - lhs.taskId;
        }
    }

    /* renamed from: com.android.server.am.ActivityManagerService.5 */
    static class C01265 extends FileObserver {
        C01265(String x0, int x1) {
            super(x0, x1);
        }

        public synchronized void onEvent(int event, String path) {
            notify();
        }
    }

    /* renamed from: com.android.server.am.ActivityManagerService.6 */
    class C01286 implements Runnable {
        final /* synthetic */ ActivityRecord val$cur;
        final /* synthetic */ ActivityRecord val$next;

        /* renamed from: com.android.server.am.ActivityManagerService.6.1 */
        class C01271 implements Runnable {
            final /* synthetic */ Dialog val$d;

            C01271(Dialog dialog) {
                this.val$d = dialog;
            }

            public void run() {
                synchronized (ActivityManagerService.this) {
                    this.val$d.dismiss();
                    ActivityManagerService.this.mLaunchWarningShown = ActivityManagerService.VALIDATE_TOKENS;
                }
            }
        }

        C01286(ActivityRecord activityRecord, ActivityRecord activityRecord2) {
            this.val$cur = activityRecord;
            this.val$next = activityRecord2;
        }

        public void run() {
            synchronized (ActivityManagerService.this) {
                Dialog d = new LaunchWarningWindow(ActivityManagerService.this.mContext, this.val$cur, this.val$next);
                d.show();
                ActivityManagerService.this.mHandler.postDelayed(new C01271(d), 4000);
            }
        }
    }

    /* renamed from: com.android.server.am.ActivityManagerService.7 */
    class C01297 extends BroadcastReceiver {
        C01297() {
        }

        public void onReceive(Context context, Intent intent) {
            String[] pkgs = intent.getStringArrayExtra("android.intent.extra.PACKAGES");
            if (pkgs != null) {
                String[] arr$ = pkgs;
                int len$ = arr$.length;
                for (int i$ = ActivityManagerService.MY_PID; i$ < len$; i$ += ActivityManagerService.SHOW_ERROR_MSG) {
                    String pkg = arr$[i$];
                    synchronized (ActivityManagerService.this) {
                        if (ActivityManagerService.this.forceStopPackageLocked(pkg, -1, ActivityManagerService.VALIDATE_TOKENS, ActivityManagerService.VALIDATE_TOKENS, ActivityManagerService.VALIDATE_TOKENS, ActivityManagerService.VALIDATE_TOKENS, ActivityManagerService.VALIDATE_TOKENS, ActivityManagerService.MY_PID, "finished booting")) {
                            setResultCode(-1);
                            return;
                        }
                    }
                }
            }
        }
    }

    /* renamed from: com.android.server.am.ActivityManagerService.8 */
    class C01308 extends Stub {
        C01308() {
        }

        public void performReceive(Intent intent, int resultCode, String data, Bundle extras, boolean ordered, boolean sticky, int sendingUser) {
            synchronized (ActivityManagerService.this) {
                ActivityManagerService.this.requestPssAllProcsLocked(SystemClock.uptimeMillis(), ActivityManagerService.SHOW_ACTIVITY_START_TIME, ActivityManagerService.VALIDATE_TOKENS);
            }
        }
    }

    abstract class ForegroundToken implements DeathRecipient {
        int pid;
        IBinder token;

        ForegroundToken() {
        }
    }

    /* renamed from: com.android.server.am.ActivityManagerService.9 */
    class C01319 extends ForegroundToken {
        C01319() {
            super();
        }

        public void binderDied() {
            ActivityManagerService.this.foregroundTokenDied(this);
        }
    }

    private final class AppDeathRecipient implements DeathRecipient {
        final ProcessRecord mApp;
        final IApplicationThread mAppThread;
        final int mPid;

        AppDeathRecipient(ProcessRecord app, int pid, IApplicationThread thread) {
            this.mApp = app;
            this.mPid = pid;
            this.mAppThread = thread;
        }

        public void binderDied() {
            synchronized (ActivityManagerService.this) {
                ActivityManagerService.this.appDiedLocked(this.mApp, this.mPid, this.mAppThread, ActivityManagerService.SHOW_ACTIVITY_START_TIME);
            }
        }
    }

    class AppTaskImpl extends IAppTask.Stub {
        private int mCallingUid;
        private int mTaskId;

        public AppTaskImpl(int taskId, int callingUid) {
            this.mTaskId = taskId;
            this.mCallingUid = callingUid;
        }

        private void checkCaller() {
            if (this.mCallingUid != Binder.getCallingUid()) {
                throw new SecurityException("Caller " + this.mCallingUid + " does not match caller of getAppTasks(): " + Binder.getCallingUid());
            }
        }

        public void finishAndRemoveTask() {
            checkCaller();
            synchronized (ActivityManagerService.this) {
                long origId = Binder.clearCallingIdentity();
                try {
                    if (ActivityManagerService.this.removeTaskByIdLocked(this.mTaskId, ActivityManagerService.VALIDATE_TOKENS)) {
                        Binder.restoreCallingIdentity(origId);
                    } else {
                        throw new IllegalArgumentException("Unable to find task ID " + this.mTaskId);
                    }
                } catch (Throwable th) {
                    Binder.restoreCallingIdentity(origId);
                }
            }
        }

        public RecentTaskInfo getTaskInfo() {
            RecentTaskInfo access$1500;
            checkCaller();
            synchronized (ActivityManagerService.this) {
                long origId = Binder.clearCallingIdentity();
                try {
                    TaskRecord tr = ActivityManagerService.this.recentTaskForIdLocked(this.mTaskId);
                    if (tr == null) {
                        throw new IllegalArgumentException("Unable to find task ID " + this.mTaskId);
                    }
                    access$1500 = ActivityManagerService.this.createRecentTaskInfoFromTaskRecord(tr);
                    Binder.restoreCallingIdentity(origId);
                } catch (Throwable th) {
                    Binder.restoreCallingIdentity(origId);
                }
            }
            return access$1500;
        }

        public void moveToFront() {
            checkCaller();
            ActivityManagerService.this.startActivityFromRecentsInner(this.mTaskId, null);
        }

        public int startActivity(IBinder whoThread, String callingPackage, Intent intent, String resolvedType, Bundle options) {
            TaskRecord tr;
            IApplicationThread appThread;
            checkCaller();
            int callingUser = UserHandle.getCallingUserId();
            synchronized (ActivityManagerService.this) {
                tr = ActivityManagerService.this.recentTaskForIdLocked(this.mTaskId);
                if (tr == null) {
                    throw new IllegalArgumentException("Unable to find task ID " + this.mTaskId);
                }
                appThread = ApplicationThreadNative.asInterface(whoThread);
                if (appThread == null) {
                    throw new IllegalArgumentException("Bad app thread " + appThread);
                }
            }
            return ActivityManagerService.this.mStackSupervisor.startActivityMayWait(appThread, -1, callingPackage, intent, resolvedType, null, null, null, null, ActivityManagerService.MY_PID, ActivityManagerService.MY_PID, null, null, null, options, callingUser, null, tr);
        }

        public void setExcludeFromRecents(boolean exclude) {
            checkCaller();
            synchronized (ActivityManagerService.this) {
                long origId = Binder.clearCallingIdentity();
                try {
                    TaskRecord tr = ActivityManagerService.this.recentTaskForIdLocked(this.mTaskId);
                    if (tr == null) {
                        throw new IllegalArgumentException("Unable to find task ID " + this.mTaskId);
                    }
                    Intent intent = tr.getBaseIntent();
                    if (exclude) {
                        intent.addFlags(8388608);
                    } else {
                        intent.setFlags(intent.getFlags() & -8388609);
                    }
                    Binder.restoreCallingIdentity(origId);
                } catch (Throwable th) {
                    Binder.restoreCallingIdentity(origId);
                }
            }
        }
    }

    static final class Association {
        int mCount;
        int mNesting;
        final String mSourceProcess;
        final int mSourceUid;
        long mStartTime;
        final ComponentName mTargetComponent;
        final String mTargetProcess;
        final int mTargetUid;
        long mTime;

        Association(int sourceUid, String sourceProcess, int targetUid, ComponentName targetComponent, String targetProcess) {
            this.mSourceUid = sourceUid;
            this.mSourceProcess = sourceProcess;
            this.mTargetUid = targetUid;
            this.mTargetComponent = targetComponent;
            this.mTargetProcess = targetProcess;
        }
    }

    static final class BadProcessInfo {
        final String longMsg;
        final String shortMsg;
        final String stack;
        final long time;

        BadProcessInfo(long time, String shortMsg, String longMsg, String stack) {
            this.time = time;
            this.shortMsg = shortMsg;
            this.longMsg = longMsg;
            this.stack = stack;
        }
    }

    static class CpuBinder extends Binder {
        ActivityManagerService mActivityManagerService;

        CpuBinder(ActivityManagerService activityManagerService) {
            this.mActivityManagerService = activityManagerService;
        }

        protected void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
            if (this.mActivityManagerService.checkCallingPermission("android.permission.DUMP") != 0) {
                pw.println("Permission Denial: can't dump cpuinfo from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " without permission " + "android.permission.DUMP");
                return;
            }
            synchronized (this.mActivityManagerService.mProcessCpuTracker) {
                pw.print(this.mActivityManagerService.mProcessCpuTracker.printCurrentLoad());
                pw.print(this.mActivityManagerService.mProcessCpuTracker.printCurrentState(SystemClock.uptimeMillis()));
            }
        }
    }

    static class DbBinder extends Binder {
        ActivityManagerService mActivityManagerService;

        DbBinder(ActivityManagerService activityManagerService) {
            this.mActivityManagerService = activityManagerService;
        }

        protected void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
            if (this.mActivityManagerService.checkCallingPermission("android.permission.DUMP") != 0) {
                pw.println("Permission Denial: can't dump dbinfo from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " without permission " + "android.permission.DUMP");
            } else {
                this.mActivityManagerService.dumpDbInfo(fd, pw, args);
            }
        }
    }

    public static class GrantUri {
        public boolean prefix;
        public final int sourceUserId;
        public final Uri uri;

        public GrantUri(int sourceUserId, Uri uri, boolean prefix) {
            this.sourceUserId = sourceUserId;
            this.uri = uri;
            this.prefix = prefix;
        }

        public int hashCode() {
            return ((((this.sourceUserId + ActivityManagerService.DISPATCH_PROCESSES_CHANGED) * ActivityManagerService.DISPATCH_PROCESSES_CHANGED) + this.uri.hashCode()) * ActivityManagerService.DISPATCH_PROCESSES_CHANGED) + (this.prefix ? 1231 : 1237);
        }

        public boolean equals(Object o) {
            if (!(o instanceof GrantUri)) {
                return ActivityManagerService.VALIDATE_TOKENS;
            }
            GrantUri other = (GrantUri) o;
            if (this.uri.equals(other.uri) && this.sourceUserId == other.sourceUserId && this.prefix == other.prefix) {
                return ActivityManagerService.SHOW_ACTIVITY_START_TIME;
            }
            return ActivityManagerService.VALIDATE_TOKENS;
        }

        public String toString() {
            String result = Integer.toString(this.sourceUserId) + " @ " + this.uri.toString();
            if (this.prefix) {
                return result + " [prefix]";
            }
            return result;
        }

        public String toSafeString() {
            String result = Integer.toString(this.sourceUserId) + " @ " + this.uri.toSafeString();
            if (this.prefix) {
                return result + " [prefix]";
            }
            return result;
        }

        public static GrantUri resolve(int defaultSourceUserHandle, Uri uri) {
            return new GrantUri(ContentProvider.getUserIdFromUri(uri, defaultSourceUserHandle), ContentProvider.getUriWithoutUserId(uri), ActivityManagerService.VALIDATE_TOKENS);
        }
    }

    static class GraphicsBinder extends Binder {
        ActivityManagerService mActivityManagerService;

        GraphicsBinder(ActivityManagerService activityManagerService) {
            this.mActivityManagerService = activityManagerService;
        }

        protected void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
            if (this.mActivityManagerService.checkCallingPermission("android.permission.DUMP") != 0) {
                pw.println("Permission Denial: can't dump gfxinfo from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " without permission " + "android.permission.DUMP");
            } else {
                this.mActivityManagerService.dumpGraphicsHardwareUsage(fd, pw, args);
            }
        }
    }

    private class Identity {
        public final int pid;
        public final IBinder token;
        public final int uid;

        Identity(IBinder _token, int _pid, int _uid) {
            this.token = _token;
            this.pid = _pid;
            this.uid = _uid;
        }
    }

    class IntentFirewallInterface implements AMSInterface {
        IntentFirewallInterface() {
        }

        public int checkComponentPermission(String permission, int pid, int uid, int owningUid, boolean exported) {
            return ActivityManagerService.this.checkComponentPermission(permission, pid, uid, owningUid, exported);
        }

        public Object getAMSLock() {
            return ActivityManagerService.this;
        }
    }

    static class ItemMatcher {
        boolean all;
        ArrayList<ComponentName> components;
        ArrayList<Integer> objects;
        ArrayList<String> strings;

        ItemMatcher() {
            this.all = ActivityManagerService.SHOW_ACTIVITY_START_TIME;
        }

        void build(String name) {
            ComponentName componentName = ComponentName.unflattenFromString(name);
            if (componentName != null) {
                if (this.components == null) {
                    this.components = new ArrayList();
                }
                this.components.add(componentName);
                this.all = ActivityManagerService.VALIDATE_TOKENS;
                return;
            }
            try {
                int objectId = Integer.parseInt(name, 16);
                if (this.objects == null) {
                    this.objects = new ArrayList();
                }
                this.objects.add(Integer.valueOf(objectId));
                this.all = ActivityManagerService.VALIDATE_TOKENS;
            } catch (RuntimeException e) {
                if (this.strings == null) {
                    this.strings = new ArrayList();
                }
                this.strings.add(name);
                this.all = ActivityManagerService.VALIDATE_TOKENS;
            }
        }

        int build(String[] args, int opti) {
            while (opti < args.length) {
                String name = args[opti];
                if ("--".equals(name)) {
                    return opti + ActivityManagerService.SHOW_ERROR_MSG;
                }
                build(name);
                opti += ActivityManagerService.SHOW_ERROR_MSG;
            }
            return opti;
        }

        boolean match(Object object, ComponentName comp) {
            if (this.all) {
                return ActivityManagerService.SHOW_ACTIVITY_START_TIME;
            }
            int i;
            if (this.components != null) {
                for (i = ActivityManagerService.MY_PID; i < this.components.size(); i += ActivityManagerService.SHOW_ERROR_MSG) {
                    if (((ComponentName) this.components.get(i)).equals(comp)) {
                        return ActivityManagerService.SHOW_ACTIVITY_START_TIME;
                    }
                }
            }
            if (this.objects != null) {
                for (i = ActivityManagerService.MY_PID; i < this.objects.size(); i += ActivityManagerService.SHOW_ERROR_MSG) {
                    if (System.identityHashCode(object) == ((Integer) this.objects.get(i)).intValue()) {
                        return ActivityManagerService.SHOW_ACTIVITY_START_TIME;
                    }
                }
            }
            if (this.strings != null) {
                String flat = comp.flattenToString();
                for (i = ActivityManagerService.MY_PID; i < this.strings.size(); i += ActivityManagerService.SHOW_ERROR_MSG) {
                    if (flat.contains((CharSequence) this.strings.get(i))) {
                        return ActivityManagerService.SHOW_ACTIVITY_START_TIME;
                    }
                }
            }
            return ActivityManagerService.VALIDATE_TOKENS;
        }
    }

    public static final class Lifecycle extends SystemService {
        private final ActivityManagerService mService;

        public Lifecycle(Context context) {
            super(context);
            this.mService = new ActivityManagerService(context);
        }

        public void onStart() {
            this.mService.start();
        }

        public ActivityManagerService getService() {
            return this.mService;
        }
    }

    private final class LocalService extends ActivityManagerInternal {
        private LocalService() {
        }

        public void onWakefulnessChanged(int wakefulness) {
            ActivityManagerService.this.onWakefulnessChanged(wakefulness);
        }

        public int startIsolatedProcess(String entryPoint, String[] entryPointArgs, String processName, String abiOverride, int uid, Runnable crashHandler) {
            return ActivityManagerService.this.startIsolatedProcess(entryPoint, entryPointArgs, processName, abiOverride, uid, crashHandler);
        }
    }

    final class MainHandler extends Handler {

        /* renamed from: com.android.server.am.ActivityManagerService.MainHandler.1 */
        class C01321 extends Thread {
            final /* synthetic */ ArrayList val$memInfos;

            C01321(ArrayList arrayList) {
                this.val$memInfos = arrayList;
            }

            public void run() {
                ActivityManagerService.this.reportMemUsage(this.val$memInfos);
            }
        }

        public MainHandler(Looper looper) {
            super(looper, null, ActivityManagerService.SHOW_ACTIVITY_START_TIME);
        }

        public void handleMessage(Message msg) {
            HashMap<String, Object> data;
            ProcessRecord proc;
            AppErrorResult res;
            Dialog d;
            ProcessRecord app;
            Message nmsg;
            int i;
            ProcessRecord r;
            AlertDialog d2;
            INotificationManager inm;
            switch (msg.what) {
                case ActivityManagerService.SHOW_ERROR_MSG /*1*/:
                    data = msg.obj;
                    boolean showBackground = Secure.getInt(ActivityManagerService.this.mContext.getContentResolver(), "anr_show_background", ActivityManagerService.MY_PID) != 0 ? ActivityManagerService.SHOW_ACTIVITY_START_TIME : ActivityManagerService.VALIDATE_TOKENS;
                    synchronized (ActivityManagerService.this) {
                        proc = (ProcessRecord) data.get("app");
                        res = (AppErrorResult) data.get("result");
                        if (proc == null || proc.crashDialog == null) {
                            boolean isBackground = (UserHandle.getAppId(proc.uid) < ActivityManagerService.PROC_START_TIMEOUT || proc.pid == ActivityManagerService.MY_PID) ? ActivityManagerService.VALIDATE_TOKENS : ActivityManagerService.SHOW_ACTIVITY_START_TIME;
                            int[] arr$ = ActivityManagerService.this.mCurrentProfileIds;
                            int len$ = arr$.length;
                            for (int i$ = ActivityManagerService.MY_PID; i$ < len$; i$ += ActivityManagerService.SHOW_ERROR_MSG) {
                                isBackground &= proc.userId != arr$[i$] ? ActivityManagerService.SHOW_ERROR_MSG : ActivityManagerService.MY_PID;
                            }
                            if (!isBackground || showBackground) {
                                if (!ActivityManagerService.this.mShowDialogs || ActivityManagerService.this.mSleeping || ActivityManagerService.this.mShuttingDown) {
                                    if (res != null) {
                                        res.set(ActivityManagerService.MY_PID);
                                        break;
                                    }
                                }
                                d = new AppErrorDialog(ActivityManagerService.this.mContext, ActivityManagerService.this, res, proc);
                                d.show();
                                proc.crashDialog = d;
                                ActivityManagerService.this.ensureBootCompleted();
                                return;
                            }
                            Slog.w(ActivityManagerService.TAG, "Skipping crash dialog of " + proc + ": background");
                            if (res != null) {
                                res.set(ActivityManagerService.MY_PID);
                            }
                            return;
                        }
                        Slog.e(ActivityManagerService.TAG, "App already has crash dialog: " + proc);
                        if (res != null) {
                            res.set(ActivityManagerService.MY_PID);
                        }
                    }
                case ActivityManagerService.SHOW_NOT_RESPONDING_MSG /*2*/:
                    synchronized (ActivityManagerService.this) {
                        data = (HashMap) msg.obj;
                        proc = (ProcessRecord) data.get("app");
                        if (proc == null || proc.anrDialog == null) {
                            Intent intent = new Intent("android.intent.action.ANR");
                            if (!ActivityManagerService.this.mProcessesReady) {
                                intent.addFlags(1342177280);
                            }
                            ActivityManagerService.this.broadcastIntentLocked(null, null, intent, null, null, ActivityManagerService.MY_PID, null, null, null, -1, ActivityManagerService.VALIDATE_TOKENS, ActivityManagerService.VALIDATE_TOKENS, ActivityManagerService.MY_PID, ActivityManagerService.NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY, ActivityManagerService.MY_PID);
                            if (!ActivityManagerService.this.mShowDialogs) {
                                ActivityManagerService.this.killAppAtUsersRequest(proc, null);
                                break;
                            }
                            d = new AppNotRespondingDialog(ActivityManagerService.this, ActivityManagerService.this.mContext, proc, (ActivityRecord) data.get("activity"), msg.arg1 != 0 ? ActivityManagerService.SHOW_ACTIVITY_START_TIME : ActivityManagerService.VALIDATE_TOKENS);
                            d.show();
                            proc.anrDialog = d;
                            ActivityManagerService.this.ensureBootCompleted();
                            return;
                        }
                        Slog.e(ActivityManagerService.TAG, "App already has anr dialog: " + proc);
                    }
                case ActivityManagerService.SHOW_FACTORY_ERROR_MSG /*3*/:
                    new FactoryErrorDialog(ActivityManagerService.this.mContext, msg.getData().getCharSequence("msg")).show();
                    ActivityManagerService.this.ensureBootCompleted();
                case ActivityManagerService.UPDATE_CONFIGURATION_MSG /*4*/:
                    System.putConfiguration(ActivityManagerService.this.mContext.getContentResolver(), (Configuration) msg.obj);
                case ActivityManagerService.GC_BACKGROUND_PROCESSES_MSG /*5*/:
                    synchronized (ActivityManagerService.this) {
                        ActivityManagerService.this.performAppGcsIfAppropriateLocked();
                        break;
                    }
                case ActivityManagerService.WAIT_FOR_DEBUGGER_MSG /*6*/:
                    synchronized (ActivityManagerService.this) {
                        app = msg.obj;
                        if (msg.arg1 == 0) {
                            if (app.waitDialog != null) {
                                app.waitDialog.dismiss();
                                app.waitDialog = null;
                            }
                            break;
                        } else if (!app.waitedForDebugger) {
                            d = new AppWaitingForDebuggerDialog(ActivityManagerService.this, ActivityManagerService.this.mContext, app);
                            app.waitDialog = d;
                            app.waitedForDebugger = ActivityManagerService.SHOW_ACTIVITY_START_TIME;
                            d.show();
                        }
                        break;
                    }
                case ActivityManagerService.SERVICE_TIMEOUT_MSG /*12*/:
                    if (ActivityManagerService.this.mDidDexOpt) {
                        ActivityManagerService.this.mDidDexOpt = ActivityManagerService.VALIDATE_TOKENS;
                        nmsg = ActivityManagerService.this.mHandler.obtainMessage(ActivityManagerService.SERVICE_TIMEOUT_MSG);
                        nmsg.obj = msg.obj;
                        ActivityManagerService.this.mHandler.sendMessageDelayed(nmsg, 20000);
                        return;
                    }
                    ActivityManagerService.this.mServices.serviceTimeout((ProcessRecord) msg.obj);
                case ActivityManagerService.UPDATE_TIME_ZONE /*13*/:
                    synchronized (ActivityManagerService.this) {
                        for (i = ActivityManagerService.this.mLruProcesses.size() - 1; i >= 0; i--) {
                            r = (ProcessRecord) ActivityManagerService.this.mLruProcesses.get(i);
                            if (r.thread != null) {
                                try {
                                    r.thread.updateTimeZone();
                                } catch (RemoteException e) {
                                    Slog.w(ActivityManagerService.TAG, "Failed to update time zone for: " + r.info.processName);
                                    break;
                                }
                            }
                        }
                        break;
                    }
                case ActivityManagerService.SHOW_UID_ERROR_MSG /*14*/:
                    if (ActivityManagerService.this.mShowDialogs) {
                        d2 = new BaseErrorDialog(ActivityManagerService.this.mContext);
                        d2.getWindow().setType(2010);
                        d2.setCancelable(ActivityManagerService.VALIDATE_TOKENS);
                        d2.setTitle(ActivityManagerService.this.mContext.getText(17039642));
                        d2.setMessage(ActivityManagerService.this.mContext.getText(17041063));
                        d2.setButton(-1, ActivityManagerService.this.mContext.getText(17039370), ActivityManagerService.this.mHandler.obtainMessage(ActivityManagerService.DISMISS_DIALOG_MSG, d2));
                        d2.show();
                    }
                case ActivityManagerService.SHOW_FINGERPRINT_ERROR_MSG /*15*/:
                    if (ActivityManagerService.this.mShowDialogs) {
                        d2 = new BaseErrorDialog(ActivityManagerService.this.mContext);
                        d2.getWindow().setType(2010);
                        d2.setCancelable(ActivityManagerService.VALIDATE_TOKENS);
                        d2.setTitle(ActivityManagerService.this.mContext.getText(17039642));
                        d2.setMessage(ActivityManagerService.this.mContext.getText(17041064));
                        d2.setButton(-1, ActivityManagerService.this.mContext.getText(17039370), ActivityManagerService.this.mHandler.obtainMessage(ActivityManagerService.DISMISS_DIALOG_MSG, d2));
                        d2.show();
                    }
                case ActivityManagerService.PROC_START_TIMEOUT_MSG /*20*/:
                    if (ActivityManagerService.this.mDidDexOpt) {
                        ActivityManagerService.this.mDidDexOpt = ActivityManagerService.VALIDATE_TOKENS;
                        nmsg = ActivityManagerService.this.mHandler.obtainMessage(ActivityManagerService.PROC_START_TIMEOUT_MSG);
                        nmsg.obj = msg.obj;
                        ActivityManagerService.this.mHandler.sendMessageDelayed(nmsg, 10000);
                        return;
                    }
                    app = (ProcessRecord) msg.obj;
                    synchronized (ActivityManagerService.this) {
                        ActivityManagerService.this.processStartTimedOutLocked(app);
                        break;
                    }
                case ActivityManagerService.DO_PENDING_ACTIVITY_LAUNCHES_MSG /*21*/:
                    synchronized (ActivityManagerService.this) {
                        ActivityManagerService.this.mStackSupervisor.doPendingActivityLaunchesLocked(ActivityManagerService.SHOW_ACTIVITY_START_TIME);
                        break;
                    }
                case ActivityManagerService.KILL_APPLICATION_MSG /*22*/:
                    synchronized (ActivityManagerService.this) {
                        Bundle bundle = msg.obj;
                        ActivityManagerService.this.forceStopPackageLocked(bundle.getString("pkg"), msg.arg1, msg.arg2 == ActivityManagerService.SHOW_ERROR_MSG ? ActivityManagerService.SHOW_ACTIVITY_START_TIME : ActivityManagerService.VALIDATE_TOKENS, ActivityManagerService.VALIDATE_TOKENS, ActivityManagerService.SHOW_ACTIVITY_START_TIME, ActivityManagerService.VALIDATE_TOKENS, ActivityManagerService.VALIDATE_TOKENS, -1, bundle.getString("reason"));
                        break;
                    }
                case ActivityManagerService.FINALIZE_PENDING_INTENT_MSG /*23*/:
                    ((PendingIntentRecord) msg.obj).completeFinalize();
                case ActivityManagerService.POST_HEAVY_NOTIFICATION_MSG /*24*/:
                    inm = NotificationManager.getService();
                    if (inm != null) {
                        ActivityRecord root = msg.obj;
                        ProcessRecord process = root.app;
                        if (process != null) {
                            try {
                                Context context = ActivityManagerService.this.mContext.createPackageContext(process.info.packageName, ActivityManagerService.MY_PID);
                                Context context2 = ActivityManagerService.this.mContext;
                                Object[] objArr = new Object[ActivityManagerService.SHOW_ERROR_MSG];
                                objArr[ActivityManagerService.MY_PID] = context.getApplicationInfo().loadLabel(context.getPackageManager());
                                String text = context2.getString(17040553, objArr);
                                Notification notification = new Notification();
                                notification.icon = 17303122;
                                notification.when = 0;
                                notification.flags = ActivityManagerService.SHOW_NOT_RESPONDING_MSG;
                                notification.tickerText = text;
                                notification.defaults = ActivityManagerService.MY_PID;
                                notification.sound = null;
                                notification.vibrate = null;
                                notification.color = ActivityManagerService.this.mContext.getResources().getColor(17170521);
                                notification.setLatestEventInfo(context, text, ActivityManagerService.this.mContext.getText(17040554), PendingIntent.getActivityAsUser(ActivityManagerService.this.mContext, ActivityManagerService.MY_PID, root.intent, 268435456, null, new UserHandle(root.userId)));
                                try {
                                    inm.enqueueNotificationWithTag("android", "android", null, 17040553, notification, new int[ActivityManagerService.SHOW_ERROR_MSG], root.userId);
                                } catch (Throwable e2) {
                                    Slog.w(ActivityManagerService.TAG, "Error showing notification for heavy-weight app", e2);
                                } catch (RemoteException e3) {
                                }
                            } catch (Throwable e22) {
                                Slog.w(ActivityManagerService.TAG, "Unable to create context for heavy notification", e22);
                            }
                        }
                    }
                case ActivityManagerService.CANCEL_HEAVY_NOTIFICATION_MSG /*25*/:
                    inm = NotificationManager.getService();
                    if (inm != null) {
                        try {
                            inm.cancelNotificationWithTag("android", null, 17040553, msg.arg1);
                        } catch (Throwable e222) {
                            Slog.w(ActivityManagerService.TAG, "Error canceling notification for service", e222);
                        } catch (RemoteException e4) {
                        }
                    }
                case ActivityManagerService.SHOW_STRICT_MODE_VIOLATION_MSG /*26*/:
                    data = (HashMap) msg.obj;
                    synchronized (ActivityManagerService.this) {
                        proc = (ProcessRecord) data.get("app");
                        if (proc == null) {
                            Slog.e(ActivityManagerService.TAG, "App not found when showing strict mode dialog.");
                        } else if (proc.crashDialog != null) {
                            Slog.e(ActivityManagerService.TAG, "App already has strict mode dialog: " + proc);
                        } else {
                            res = (AppErrorResult) data.get("result");
                            if (!ActivityManagerService.this.mShowDialogs || ActivityManagerService.this.mSleeping || ActivityManagerService.this.mShuttingDown) {
                                res.set(ActivityManagerService.MY_PID);
                                break;
                            }
                            d = new StrictModeViolationDialog(ActivityManagerService.this.mContext, ActivityManagerService.this, res, proc);
                            d.show();
                            proc.crashDialog = d;
                            ActivityManagerService.this.ensureBootCompleted();
                        }
                    }
                case ActivityManagerService.CHECK_EXCESSIVE_WAKE_LOCKS_MSG /*27*/:
                    synchronized (ActivityManagerService.this) {
                        ActivityManagerService.this.checkExcessivePowerUsageLocked(ActivityManagerService.SHOW_ACTIVITY_START_TIME);
                        removeMessages(ActivityManagerService.CHECK_EXCESSIVE_WAKE_LOCKS_MSG);
                        sendMessageDelayed(obtainMessage(ActivityManagerService.CHECK_EXCESSIVE_WAKE_LOCKS_MSG), 900000);
                        break;
                    }
                case ActivityManagerService.CLEAR_DNS_CACHE_MSG /*28*/:
                    synchronized (ActivityManagerService.this) {
                        for (i = ActivityManagerService.this.mLruProcesses.size() - 1; i >= 0; i--) {
                            r = (ProcessRecord) ActivityManagerService.this.mLruProcesses.get(i);
                            if (r.thread != null) {
                                try {
                                    r.thread.clearDnsCache();
                                } catch (RemoteException e5) {
                                    Slog.w(ActivityManagerService.TAG, "Failed to clear dns cache for: " + r.info.processName);
                                    break;
                                }
                            }
                        }
                        break;
                    }
                case ActivityManagerService.UPDATE_HTTP_PROXY_MSG /*29*/:
                    ProxyInfo proxy = msg.obj;
                    String host = "";
                    String port = "";
                    String exclList = "";
                    Uri pacFileUrl = Uri.EMPTY;
                    if (proxy != null) {
                        host = proxy.getHost();
                        port = Integer.toString(proxy.getPort());
                        exclList = proxy.getExclusionListAsString();
                        pacFileUrl = proxy.getPacFileUrl();
                    }
                    synchronized (ActivityManagerService.this) {
                        for (i = ActivityManagerService.this.mLruProcesses.size() - 1; i >= 0; i--) {
                            r = (ProcessRecord) ActivityManagerService.this.mLruProcesses.get(i);
                            if (r.thread != null) {
                                try {
                                    r.thread.setHttpProxy(host, port, exclList, pacFileUrl);
                                } catch (RemoteException e6) {
                                    Slog.w(ActivityManagerService.TAG, "Failed to update http proxy for: " + r.info.processName);
                                    break;
                                }
                            }
                        }
                        break;
                    }
                case ActivityManagerService.SHOW_COMPAT_MODE_DIALOG_MSG /*30*/:
                    synchronized (ActivityManagerService.this) {
                        ActivityRecord ar = msg.obj;
                        if (ActivityManagerService.this.mCompatModeDialog != null) {
                            if (!ActivityManagerService.this.mCompatModeDialog.mAppInfo.packageName.equals(ar.info.applicationInfo.packageName)) {
                                ActivityManagerService.this.mCompatModeDialog.dismiss();
                                ActivityManagerService.this.mCompatModeDialog = null;
                                break;
                            }
                            return;
                        }
                        if (ar != null) {
                        }
                    }
                case ActivityManagerService.DISPATCH_PROCESSES_CHANGED /*31*/:
                    ActivityManagerService.this.dispatchProcessesChanged();
                case ActivityManagerService.DISPATCH_PROCESS_DIED /*32*/:
                    ActivityManagerService.this.dispatchProcessDied(msg.arg1, msg.arg2);
                case ActivityManagerService.REPORT_MEM_USAGE_MSG /*33*/:
                    new C01321(msg.obj).start();
                case ActivityManagerService.REPORT_USER_SWITCH_MSG /*34*/:
                    ActivityManagerService.this.dispatchUserSwitch((UserStartedState) msg.obj, msg.arg1, msg.arg2);
                case ActivityManagerService.CONTINUE_USER_SWITCH_MSG /*35*/:
                    ActivityManagerService.this.continueUserSwitch((UserStartedState) msg.obj, msg.arg1, msg.arg2);
                case ActivityManagerService.USER_SWITCH_TIMEOUT_MSG /*36*/:
                    ActivityManagerService.this.timeoutUserSwitch((UserStartedState) msg.obj, msg.arg1, msg.arg2);
                case ActivityManagerService.IMMERSIVE_MODE_LOCK_MSG /*37*/:
                    boolean nextState = msg.arg1 != 0 ? ActivityManagerService.SHOW_ACTIVITY_START_TIME : ActivityManagerService.VALIDATE_TOKENS;
                    if (ActivityManagerService.this.mUpdateLock.isHeld() == nextState) {
                        return;
                    }
                    if (nextState) {
                        ActivityManagerService.this.mUpdateLock.acquire();
                    } else {
                        ActivityManagerService.this.mUpdateLock.release();
                    }
                case ActivityManagerService.PERSIST_URI_GRANTS_MSG /*38*/:
                    ActivityManagerService.this.writeGrantedUriPermissions();
                case ActivityManagerService.REQUEST_ALL_PSS_MSG /*39*/:
                    synchronized (ActivityManagerService.this) {
                        ActivityManagerService.this.requestPssAllProcsLocked(SystemClock.uptimeMillis(), ActivityManagerService.SHOW_ACTIVITY_START_TIME, ActivityManagerService.VALIDATE_TOKENS);
                        break;
                    }
                case ActivityManagerService.START_PROFILES_MSG /*40*/:
                    synchronized (ActivityManagerService.this) {
                        ActivityManagerService.this.startProfilesLocked();
                        break;
                    }
                case ActivityManagerService.UPDATE_TIME /*41*/:
                    synchronized (ActivityManagerService.this) {
                        for (i = ActivityManagerService.this.mLruProcesses.size() - 1; i >= 0; i--) {
                            r = (ProcessRecord) ActivityManagerService.this.mLruProcesses.get(i);
                            if (r.thread != null) {
                                try {
                                    r.thread.updateTimePrefs(msg.arg1 == 0 ? ActivityManagerService.VALIDATE_TOKENS : ActivityManagerService.SHOW_ACTIVITY_START_TIME);
                                } catch (RemoteException e7) {
                                    Slog.w(ActivityManagerService.TAG, "Failed to update preferences for: " + r.info.processName);
                                    break;
                                }
                            }
                        }
                        break;
                    }
                case ActivityManagerService.SYSTEM_USER_START_MSG /*42*/:
                    ActivityManagerService.this.mBatteryStatsService.noteEvent(32775, Integer.toString(msg.arg1), msg.arg1);
                    ActivityManagerService.this.mSystemServiceManager.startUser(msg.arg1);
                case ActivityManagerService.SYSTEM_USER_CURRENT_MSG /*43*/:
                    ActivityManagerService.this.mBatteryStatsService.noteEvent(16392, Integer.toString(msg.arg2), msg.arg2);
                    ActivityManagerService.this.mBatteryStatsService.noteEvent(32776, Integer.toString(msg.arg1), msg.arg1);
                    ActivityManagerService.this.mSystemServiceManager.switchUser(msg.arg1);
                case ActivityManagerService.ENTER_ANIMATION_COMPLETE_MSG /*44*/:
                    synchronized (ActivityManagerService.this) {
                        ActivityRecord r2 = ActivityRecord.forToken((IBinder) msg.obj);
                        if (!(r2 == null || r2.app == null || r2.app.thread == null)) {
                            try {
                                r2.app.thread.scheduleEnterAnimationComplete(r2.appToken);
                            } catch (RemoteException e8) {
                            }
                        }
                        break;
                    }
                case ActivityManagerService.FINISH_BOOTING_MSG /*45*/:
                    if (msg.arg1 != 0) {
                        ActivityManagerService.this.finishBooting();
                    }
                    if (msg.arg2 != 0) {
                        ActivityManagerService.this.enableScreenAfterBoot();
                    }
                case ActivityManagerService.START_USER_SWITCH_MSG /*46*/:
                    ActivityManagerService.this.showUserSwitchDialog(msg.arg1, (String) msg.obj);
                case ActivityManagerService.SEND_LOCALE_TO_MOUNT_DAEMON_MSG /*47*/:
                    try {
                        Locale l = msg.obj;
                        IMountService mountService = IMountService.Stub.asInterface(ServiceManager.getService("mount"));
                        Log.d(ActivityManagerService.TAG, "Storing locale " + l.toLanguageTag() + " for decryption UI");
                        mountService.setField("SystemLocale", l.toLanguageTag());
                    } catch (Throwable e2222) {
                        Log.e(ActivityManagerService.TAG, "Error storing locale for decryption UI", e2222);
                    }
                case ActivityManagerService.DISMISS_DIALOG_MSG /*48*/:
                    msg.obj.dismiss();
                case ActivityManagerService.NOTIFY_TASK_STACK_CHANGE_LISTENERS_MSG /*49*/:
                    synchronized (ActivityManagerService.this) {
                        i = ActivityManagerService.this.mTaskStackListeners.beginBroadcast();
                        while (i > 0) {
                            i--;
                            try {
                                ((ITaskStackListener) ActivityManagerService.this.mTaskStackListeners.getBroadcastItem(i)).onTaskStackChanged();
                            } catch (RemoteException e9) {
                            }
                        }
                        ActivityManagerService.this.mTaskStackListeners.finishBroadcast();
                        break;
                    }
                default:
            }
        }
    }

    static class MemBinder extends Binder {
        ActivityManagerService mActivityManagerService;

        MemBinder(ActivityManagerService activityManagerService) {
            this.mActivityManagerService = activityManagerService;
        }

        protected void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
            if (this.mActivityManagerService.checkCallingPermission("android.permission.DUMP") != 0) {
                pw.println("Permission Denial: can't dump meminfo from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " without permission " + "android.permission.DUMP");
                return;
            }
            this.mActivityManagerService.dumpApplicationMemoryUsage(fd, pw, "  ", args, ActivityManagerService.VALIDATE_TOKENS, null);
        }
    }

    static final class MemItem {
        final boolean hasActivities;
        final int id;
        final boolean isProc;
        final String label;
        final long pss;
        final String shortLabel;
        ArrayList<MemItem> subitems;

        public MemItem(String _label, String _shortLabel, long _pss, int _id, boolean _hasActivities) {
            this.isProc = ActivityManagerService.SHOW_ACTIVITY_START_TIME;
            this.label = _label;
            this.shortLabel = _shortLabel;
            this.pss = _pss;
            this.id = _id;
            this.hasActivities = _hasActivities;
        }

        public MemItem(String _label, String _shortLabel, long _pss, int _id) {
            this.isProc = ActivityManagerService.VALIDATE_TOKENS;
            this.label = _label;
            this.shortLabel = _shortLabel;
            this.pss = _pss;
            this.id = _id;
            this.hasActivities = ActivityManagerService.VALIDATE_TOKENS;
        }
    }

    static class NeededUriGrants extends ArrayList<GrantUri> {
        final int flags;
        final String targetPkg;
        final int targetUid;

        NeededUriGrants(String targetPkg, int targetUid, int flags) {
            this.targetPkg = targetPkg;
            this.targetUid = targetUid;
            this.flags = flags;
        }
    }

    public class PendingAssistExtras extends Binder implements Runnable {
        public final ActivityRecord activity;
        public final Bundle extras;
        public boolean haveResult;
        public final String hint;
        public final Intent intent;
        public Bundle result;
        public final int userHandle;

        public PendingAssistExtras(ActivityRecord _activity, Bundle _extras, Intent _intent, String _hint, int _userHandle) {
            this.haveResult = ActivityManagerService.VALIDATE_TOKENS;
            this.result = null;
            this.activity = _activity;
            this.extras = _extras;
            this.intent = _intent;
            this.hint = _hint;
            this.userHandle = _userHandle;
        }

        public void run() {
            Slog.w(ActivityManagerService.TAG, "getAssistContextExtras failed: timeout retrieving from " + this.activity);
            synchronized (this) {
                this.haveResult = ActivityManagerService.SHOW_ACTIVITY_START_TIME;
                notifyAll();
            }
        }
    }

    static class PermissionController extends IPermissionController.Stub {
        ActivityManagerService mActivityManagerService;

        PermissionController(ActivityManagerService activityManagerService) {
            this.mActivityManagerService = activityManagerService;
        }

        public boolean checkPermission(String permission, int pid, int uid) {
            return this.mActivityManagerService.checkPermission(permission, pid, uid) == 0 ? ActivityManagerService.SHOW_ACTIVITY_START_TIME : ActivityManagerService.VALIDATE_TOKENS;
        }
    }

    static class ProcessChangeItem {
        static final int CHANGE_ACTIVITIES = 1;
        static final int CHANGE_PROCESS_STATE = 2;
        int changes;
        boolean foregroundActivities;
        int pid;
        int processState;
        int uid;

        ProcessChangeItem() {
        }
    }

    public void systemReady(java.lang.Runnable r37) {
        /* JADX: method processing error */
/*
        Error: jadx.core.utils.exceptions.JadxRuntimeException: Unreachable block: B:139:0x0221
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.modifyBlocksTree(BlockProcessor.java:248)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.processBlocksTree(BlockProcessor.java:52)
	at jadx.core.dex.visitors.blocksmaker.BlockProcessor.rerun(BlockProcessor.java:44)
	at jadx.core.dex.visitors.blocksmaker.BlockFinallyExtract.visit(BlockFinallyExtract.java:57)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:31)
	at jadx.core.dex.visitors.DepthTraversal.visit(DepthTraversal.java:17)
	at jadx.core.ProcessClass.process(ProcessClass.java:37)
	at jadx.core.ProcessClass.processDependencies(ProcessClass.java:59)
	at jadx.core.ProcessClass.process(ProcessClass.java:42)
	at jadx.api.JadxDecompiler.processClass(JadxDecompiler.java:281)
	at jadx.api.JavaClass.decompile(JavaClass.java:59)
	at jadx.api.JadxDecompiler$1.run(JadxDecompiler.java:161)
*/
        /*
        r36 = this;
        monitor-enter(r36);
        r0 = r36;
        r4 = r0.mSystemReady;
        if (r4 == 0) goto L_0x000e;
    L_0x0007:
        if (r37 == 0) goto L_0x000c;
    L_0x0009:
        r37.run();
    L_0x000c:
        monitor-exit(r36);
    L_0x000d:
        return;
    L_0x000e:
        r36.updateCurrentProfileIdsLocked();
        r0 = r36;
        r4 = r0.mRecentTasks;
        if (r4 != 0) goto L_0x0037;
    L_0x0017:
        r0 = r36;
        r4 = r0.mTaskPersister;
        r4 = r4.restoreTasksLocked();
        r0 = r36;
        r0.mRecentTasks = r4;
        r0 = r36;
        r4 = r0.mTaskPersister;
        r4.restoreTasksFromOtherDeviceLocked();
        r4 = -1;
        r0 = r36;
        r0.cleanupRecentTasksLocked(r4);
        r0 = r36;
        r4 = r0.mTaskPersister;
        r4.startPersisting();
    L_0x0037:
        r0 = r36;
        r4 = r0.mDidUpdate;
        if (r4 != 0) goto L_0x0072;
    L_0x003d:
        r0 = r36;
        r4 = r0.mWaitingUpdate;
        if (r4 == 0) goto L_0x0048;
    L_0x0043:
        monitor-exit(r36);
        goto L_0x000d;
    L_0x0045:
        r4 = move-exception;
        monitor-exit(r36);
        throw r4;
    L_0x0048:
        r24 = new java.util.ArrayList;
        r24.<init>();
        r4 = new com.android.server.am.ActivityManagerService$14;
        r0 = r36;
        r1 = r24;
        r2 = r37;
        r4.<init>(r1, r2);
        r5 = 0;
        r0 = r36;
        r1 = r24;
        r4 = r0.deliverPreBootCompleted(r4, r1, r5);
        r0 = r36;
        r0.mWaitingUpdate = r4;
        r0 = r36;
        r4 = r0.mWaitingUpdate;
        if (r4 == 0) goto L_0x006d;
    L_0x006b:
        monitor-exit(r36);
        goto L_0x000d;
    L_0x006d:
        r4 = 1;
        r0 = r36;
        r0.mDidUpdate = r4;
    L_0x0072:
        r0 = r36;
        r4 = r0.mAppOpsService;
        r4.systemReady();
        r4 = 1;
        r0 = r36;
        r0.mSystemReady = r4;
        monitor-exit(r36);
        r32 = 0;
        r0 = r36;
        r5 = r0.mPidsSelfLocked;
        monitor-enter(r5);
        r0 = r36;	 Catch:{ all -> 0x00fd }
        r4 = r0.mPidsSelfLocked;	 Catch:{ all -> 0x00fd }
        r4 = r4.size();	 Catch:{ all -> 0x00fd }
        r26 = r4 + -1;
        r33 = r32;
    L_0x0092:
        if (r26 < 0) goto L_0x00bf;
    L_0x0094:
        r0 = r36;	 Catch:{ all -> 0x032f }
        r4 = r0.mPidsSelfLocked;	 Catch:{ all -> 0x032f }
        r0 = r26;	 Catch:{ all -> 0x032f }
        r31 = r4.valueAt(r0);	 Catch:{ all -> 0x032f }
        r31 = (com.android.server.am.ProcessRecord) r31;	 Catch:{ all -> 0x032f }
        r0 = r31;	 Catch:{ all -> 0x032f }
        r4 = r0.info;	 Catch:{ all -> 0x032f }
        r0 = r36;	 Catch:{ all -> 0x032f }
        r4 = r0.isAllowedWhileBooting(r4);	 Catch:{ all -> 0x032f }
        if (r4 != 0) goto L_0x0338;	 Catch:{ all -> 0x032f }
    L_0x00ac:
        if (r33 != 0) goto L_0x0334;	 Catch:{ all -> 0x032f }
    L_0x00ae:
        r32 = new java.util.ArrayList;	 Catch:{ all -> 0x032f }
        r32.<init>();	 Catch:{ all -> 0x032f }
    L_0x00b3:
        r0 = r32;	 Catch:{ all -> 0x00fd }
        r1 = r31;	 Catch:{ all -> 0x00fd }
        r0.add(r1);	 Catch:{ all -> 0x00fd }
    L_0x00ba:
        r26 = r26 + -1;
        r33 = r32;
        goto L_0x0092;
    L_0x00bf:
        monitor-exit(r5);	 Catch:{ all -> 0x032f }
        monitor-enter(r36);
        if (r33 == 0) goto L_0x0100;
    L_0x00c3:
        r4 = r33.size();
        r26 = r4 + -1;
    L_0x00c9:
        if (r26 < 0) goto L_0x0100;
    L_0x00cb:
        r0 = r33;
        r1 = r26;
        r31 = r0.get(r1);
        r31 = (com.android.server.am.ProcessRecord) r31;
        r4 = "ActivityManager";
        r5 = new java.lang.StringBuilder;
        r5.<init>();
        r6 = "Removing system update proc: ";
        r5 = r5.append(r6);
        r0 = r31;
        r5 = r5.append(r0);
        r5 = r5.toString();
        android.util.Slog.i(r4, r5);
        r4 = 1;
        r5 = 0;
        r6 = "system update done";
        r0 = r36;
        r1 = r31;
        r0.removeProcessLocked(r1, r4, r5, r6);
        r26 = r26 + -1;
        goto L_0x00c9;
    L_0x00fd:
        r4 = move-exception;
    L_0x00fe:
        monitor-exit(r5);	 Catch:{ all -> 0x00fd }
        throw r4;
    L_0x0100:
        r4 = 1;
        r0 = r36;
        r0.mProcessesReady = r4;
        monitor-exit(r36);
        r4 = "ActivityManager";
        r5 = "System now ready";
        android.util.Slog.i(r4, r5);
        r4 = 3040; // 0xbe0 float:4.26E-42 double:1.502E-320;
        r8 = android.os.SystemClock.uptimeMillis();
        android.util.EventLog.writeEvent(r4, r8);
        monitor-enter(r36);
        r0 = r36;
        r4 = r0.mFactoryTest;
        r5 = 1;
        if (r4 != r5) goto L_0x0195;
    L_0x011e:
        r0 = r36;
        r4 = r0.mContext;
        r4 = r4.getPackageManager();
        r5 = new android.content.Intent;
        r6 = "android.intent.action.FACTORY_TEST";
        r5.<init>(r6);
        r6 = 1024; // 0x400 float:1.435E-42 double:5.06E-321;
        r34 = r4.resolveActivity(r5, r6);
        r25 = 0;
        if (r34 == 0) goto L_0x0235;
    L_0x0137:
        r0 = r34;
        r0 = r0.activityInfo;
        r21 = r0;
        r0 = r21;
        r0 = r0.applicationInfo;
        r22 = r0;
        r0 = r22;
        r4 = r0.flags;
        r4 = r4 & 1;
        if (r4 == 0) goto L_0x0224;
    L_0x014b:
        r4 = "android.intent.action.FACTORY_TEST";
        r0 = r36;
        r0.mTopAction = r4;
        r4 = 0;
        r0 = r36;
        r0.mTopData = r4;
        r4 = new android.content.ComponentName;
        r0 = r22;
        r5 = r0.packageName;
        r0 = r21;
        r6 = r0.name;
        r4.<init>(r5, r6);
        r0 = r36;
        r0.mTopComponent = r4;
    L_0x0167:
        if (r25 == 0) goto L_0x0195;
    L_0x0169:
        r4 = 0;
        r0 = r36;
        r0.mTopAction = r4;
        r4 = 0;
        r0 = r36;
        r0.mTopData = r4;
        r4 = 0;
        r0 = r36;
        r0.mTopComponent = r4;
        r30 = android.os.Message.obtain();
        r4 = 3;
        r0 = r30;
        r0.what = r4;
        r4 = r30.getData();
        r5 = "msg";
        r0 = r25;
        r4.putCharSequence(r5, r0);
        r0 = r36;
        r4 = r0.mHandler;
        r0 = r30;
        r4.sendMessage(r0);
    L_0x0195:
        monitor-exit(r36);
        r36.retrieveSettings();
        r36.loadResourcesOnSystemReady();
        monitor-enter(r36);
        r36.readGrantedUriPermissionsLocked();
        monitor-exit(r36);
        if (r37 == 0) goto L_0x01a6;
    L_0x01a3:
        r37.run();
    L_0x01a6:
        r0 = r36;
        r4 = r0.mBatteryStatsService;
        r5 = 32775; // 0x8007 float:4.5928E-41 double:1.6193E-319;
        r0 = r36;
        r6 = r0.mCurrentUserId;
        r6 = java.lang.Integer.toString(r6);
        r0 = r36;
        r8 = r0.mCurrentUserId;
        r4.noteEvent(r5, r6, r8);
        r0 = r36;
        r4 = r0.mBatteryStatsService;
        r5 = 32776; // 0x8008 float:4.5929E-41 double:1.61935E-319;
        r0 = r36;
        r6 = r0.mCurrentUserId;
        r6 = java.lang.Integer.toString(r6);
        r0 = r36;
        r8 = r0.mCurrentUserId;
        r4.noteEvent(r5, r6, r8);
        r0 = r36;
        r4 = r0.mSystemServiceManager;
        r0 = r36;
        r5 = r0.mCurrentUserId;
        r4.startUser(r5);
        monitor-enter(r36);
        r0 = r36;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r4 = r0.mFactoryTest;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r5 = 1;
        if (r4 == r5) goto L_0x024d;
    L_0x01e5:
        r4 = android.app.AppGlobals.getPackageManager();	 Catch:{ RemoteException -> 0x024c }
        r5 = 1024; // 0x400 float:1.435E-42 double:5.06E-321;	 Catch:{ RemoteException -> 0x024c }
        r23 = r4.getPersistentApplications(r5);	 Catch:{ RemoteException -> 0x024c }
        if (r23 == 0) goto L_0x024d;	 Catch:{ RemoteException -> 0x024c }
    L_0x01f1:
        r20 = r23.size();	 Catch:{ RemoteException -> 0x024c }
        r26 = 0;	 Catch:{ RemoteException -> 0x024c }
    L_0x01f7:
        r0 = r26;	 Catch:{ RemoteException -> 0x024c }
        r1 = r20;	 Catch:{ RemoteException -> 0x024c }
        if (r0 >= r1) goto L_0x024d;	 Catch:{ RemoteException -> 0x024c }
    L_0x01fd:
        r0 = r23;	 Catch:{ RemoteException -> 0x024c }
        r1 = r26;	 Catch:{ RemoteException -> 0x024c }
        r27 = r0.get(r1);	 Catch:{ RemoteException -> 0x024c }
        r27 = (android.content.pm.ApplicationInfo) r27;	 Catch:{ RemoteException -> 0x024c }
        if (r27 == 0) goto L_0x021e;	 Catch:{ RemoteException -> 0x024c }
    L_0x0209:
        r0 = r27;	 Catch:{ RemoteException -> 0x024c }
        r4 = r0.packageName;	 Catch:{ RemoteException -> 0x024c }
        r5 = "android";	 Catch:{ RemoteException -> 0x024c }
        r4 = r4.equals(r5);	 Catch:{ RemoteException -> 0x024c }
        if (r4 != 0) goto L_0x021e;	 Catch:{ RemoteException -> 0x024c }
    L_0x0215:
        r4 = 0;	 Catch:{ RemoteException -> 0x024c }
        r5 = 0;	 Catch:{ RemoteException -> 0x024c }
        r0 = r36;	 Catch:{ RemoteException -> 0x024c }
        r1 = r27;	 Catch:{ RemoteException -> 0x024c }
        r0.addAppLocked(r1, r4, r5);	 Catch:{ RemoteException -> 0x024c }
    L_0x021e:
        r26 = r26 + 1;
        goto L_0x01f7;
    L_0x0221:
        r4 = move-exception;
        monitor-exit(r36);
        throw r4;
    L_0x0224:
        r0 = r36;
        r4 = r0.mContext;
        r4 = r4.getResources();
        r5 = 17040355; // 0x10403e3 float:2.424736E-38 double:8.419054E-317;
        r25 = r4.getText(r5);
        goto L_0x0167;
    L_0x0235:
        r0 = r36;
        r4 = r0.mContext;
        r4 = r4.getResources();
        r5 = 17040356; // 0x10403e4 float:2.4247362E-38 double:8.4190545E-317;
        r25 = r4.getText(r5);
        goto L_0x0167;
    L_0x0246:
        r4 = move-exception;
        monitor-exit(r36);
        throw r4;
    L_0x0249:
        r4 = move-exception;
        monitor-exit(r36);
        throw r4;
    L_0x024c:
        r4 = move-exception;
    L_0x024d:
        r4 = 1;
        r0 = r36;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r0.mBooting = r4;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r0 = r36;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r4 = r0.mCurrentUserId;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r5 = "systemReady";	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r0 = r36;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r0.startHomeActivityLocked(r4, r5);	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r4 = android.app.AppGlobals.getPackageManager();	 Catch:{ RemoteException -> 0x032c }
        r4 = r4.hasSystemUidErrors();	 Catch:{ RemoteException -> 0x032c }
        if (r4 == 0) goto L_0x027b;	 Catch:{ RemoteException -> 0x032c }
    L_0x0267:
        r4 = "ActivityManager";	 Catch:{ RemoteException -> 0x032c }
        r5 = "UIDs on the system are inconsistent, you need to wipe your data partition or your device will be unstable.";	 Catch:{ RemoteException -> 0x032c }
        android.util.Slog.e(r4, r5);	 Catch:{ RemoteException -> 0x032c }
        r0 = r36;	 Catch:{ RemoteException -> 0x032c }
        r4 = r0.mHandler;	 Catch:{ RemoteException -> 0x032c }
        r5 = 14;	 Catch:{ RemoteException -> 0x032c }
        r4 = r4.obtainMessage(r5);	 Catch:{ RemoteException -> 0x032c }
        r4.sendToTarget();	 Catch:{ RemoteException -> 0x032c }
    L_0x027b:
        r4 = android.os.Build.isFingerprintConsistent();	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        if (r4 != 0) goto L_0x0295;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
    L_0x0281:
        r4 = "ActivityManager";	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r5 = "Build fingerprint is not consistent, warning user";	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        android.util.Slog.e(r4, r5);	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r0 = r36;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r4 = r0.mHandler;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r5 = 15;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r4 = r4.obtainMessage(r5);	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r4.sendToTarget();	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
    L_0x0295:
        r28 = android.os.Binder.clearCallingIdentity();	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r7 = new android.content.Intent;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r4 = "android.intent.action.USER_STARTED";	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r7.<init>(r4);	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r4 = 1342177280; // 0x50000000 float:8.5899346E9 double:6.631236847E-315;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r7.addFlags(r4);	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r4 = "android.intent.extra.user_handle";	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r0 = r36;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r5 = r0.mCurrentUserId;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r7.putExtra(r4, r5);	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r5 = 0;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r6 = 0;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r8 = 0;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r9 = 0;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r10 = 0;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r11 = 0;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r12 = 0;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r13 = 0;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r14 = -1;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r15 = 0;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r16 = 0;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r17 = MY_PID;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r18 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r0 = r36;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r0 = r0.mCurrentUserId;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r19 = r0;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r4 = r36;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r4.broadcastIntentLocked(r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19);	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r7 = new android.content.Intent;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r4 = "android.intent.action.USER_STARTING";	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r7.<init>(r4);	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r4 = 1073741824; // 0x40000000 float:2.0 double:5.304989477E-315;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r7.addFlags(r4);	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r4 = "android.intent.extra.user_handle";	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r0 = r36;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r5 = r0.mCurrentUserId;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r7.putExtra(r4, r5);	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r5 = 0;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r6 = 0;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r8 = 0;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r9 = new com.android.server.am.ActivityManagerService$15;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r0 = r36;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r9.<init>();	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r10 = 0;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r11 = 0;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r12 = 0;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r13 = "android.permission.INTERACT_ACROSS_USERS";	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r14 = -1;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r15 = 1;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r16 = 0;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r17 = MY_PID;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r18 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r19 = -1;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r4 = r36;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r4.broadcastIntentLocked(r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19);	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        android.os.Binder.restoreCallingIdentity(r28);
    L_0x02ff:
        r0 = r36;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r4 = r0.mStackSupervisor;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r4.resumeTopActivitiesLocked();	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r4 = -1;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r0 = r36;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r5 = r0.mCurrentUserId;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r0 = r36;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r0.sendUserSwitchBroadcastsLocked(r4, r5);	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r36.performGcsForAllLocked();	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        monitor-exit(r36);	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        goto L_0x000d;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
    L_0x0316:
        r4 = move-exception;
        monitor-exit(r36);	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        throw r4;
    L_0x0319:
        r35 = move-exception;
        r4 = "ActivityManager";	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r5 = "Failed sending first user broadcasts";	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        r0 = r35;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        android.util.Slog.wtf(r4, r5, r0);	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        android.os.Binder.restoreCallingIdentity(r28);
        goto L_0x02ff;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
    L_0x0327:
        r4 = move-exception;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        android.os.Binder.restoreCallingIdentity(r28);	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
        throw r4;	 Catch:{ Throwable -> 0x0319, all -> 0x0327 }
    L_0x032c:
        r4 = move-exception;
        goto L_0x027b;
    L_0x032f:
        r4 = move-exception;
        r32 = r33;
        goto L_0x00fe;
    L_0x0334:
        r32 = r33;
        goto L_0x00b3;
    L_0x0338:
        r32 = r33;
        goto L_0x00ba;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.ActivityManagerService.systemReady(java.lang.Runnable):void");
    }

    static {
        IS_USER_BUILD = "user".equals(Build.TYPE);
        MY_PID = Process.myPid();
        EMPTY_STRING_ARRAY = new String[MY_PID];
        sCallerIdentity = new ThreadLocal();
        DUMP_MEM_BUCKETS = new long[]{5120, 7168, 10240, 15360, 20480, 30720, 40960, 81920, 122880, 163840, 204800, 256000, 307200, 358400, 409600, 512000, 614400, 819200, 1048576, 2097152, 5242880, 10485760, 20971520};
        DUMP_MEM_OOM_ADJ = new int[]{-17, -16, -12, -11, MY_PID, SHOW_ERROR_MSG, SHOW_NOT_RESPONDING_MSG, SHOW_FACTORY_ERROR_MSG, UPDATE_CONFIGURATION_MSG, GC_BACKGROUND_PROCESSES_MSG, WAIT_FOR_DEBUGGER_MSG, 7, 8, SHOW_FINGERPRINT_ERROR_MSG};
        String[] strArr = new String[SHOW_UID_ERROR_MSG];
        strArr[MY_PID] = "Native";
        strArr[SHOW_ERROR_MSG] = "System";
        strArr[SHOW_NOT_RESPONDING_MSG] = "Persistent";
        strArr[SHOW_FACTORY_ERROR_MSG] = "Persistent Service";
        strArr[UPDATE_CONFIGURATION_MSG] = "Foreground";
        strArr[GC_BACKGROUND_PROCESSES_MSG] = "Visible";
        strArr[WAIT_FOR_DEBUGGER_MSG] = "Perceptible";
        strArr[7] = "Heavy Weight";
        strArr[8] = "Backup";
        strArr[9] = "A Services";
        strArr[10] = "Home";
        strArr[11] = "Previous";
        strArr[SERVICE_TIMEOUT_MSG] = "B Services";
        strArr[UPDATE_TIME_ZONE] = "Cached";
        DUMP_MEM_OOM_LABEL = strArr;
        strArr = new String[SHOW_UID_ERROR_MSG];
        strArr[MY_PID] = "native";
        strArr[SHOW_ERROR_MSG] = "sys";
        strArr[SHOW_NOT_RESPONDING_MSG] = "pers";
        strArr[SHOW_FACTORY_ERROR_MSG] = "persvc";
        strArr[UPDATE_CONFIGURATION_MSG] = "fore";
        strArr[GC_BACKGROUND_PROCESSES_MSG] = "vis";
        strArr[WAIT_FOR_DEBUGGER_MSG] = "percept";
        strArr[7] = "heavy";
        strArr[8] = "backup";
        strArr[9] = "servicea";
        strArr[10] = "home";
        strArr[11] = "prev";
        strArr[SERVICE_TIMEOUT_MSG] = "serviceb";
        strArr[UPDATE_TIME_ZONE] = "cached";
        DUMP_MEM_OOM_COMPACT_LABEL = strArr;
    }

    BroadcastQueue broadcastQueueForIntent(Intent intent) {
        if ((intent.getFlags() & 268435456) != 0 ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS) {
            return this.mFgBroadcastQueue;
        }
        return this.mBgBroadcastQueue;
    }

    BroadcastRecord broadcastRecordForReceiverLocked(IBinder receiver) {
        BroadcastQueue[] arr$ = this.mBroadcastQueues;
        int len$ = arr$.length;
        for (int i$ = MY_PID; i$ < len$; i$ += SHOW_ERROR_MSG) {
            BroadcastRecord r = arr$[i$].getMatchingOrderedReceiver(receiver);
            if (r != null) {
                return r;
            }
        }
        return null;
    }

    public void setSystemProcess() {
        try {
            ServiceManager.addService("activity", this, SHOW_ACTIVITY_START_TIME);
            ServiceManager.addService("procstats", this.mProcessStats);
            ServiceManager.addService("meminfo", new MemBinder(this));
            ServiceManager.addService("gfxinfo", new GraphicsBinder(this));
            ServiceManager.addService("dbinfo", new DbBinder(this));
            ServiceManager.addService("cpuinfo", new CpuBinder(this));
            ServiceManager.addService("permission", new PermissionController(this));
            ApplicationInfo info = this.mContext.getPackageManager().getApplicationInfo("android", STOCK_PM_FLAGS);
            this.mSystemThread.installSystemApplicationInfo(info, getClass().getClassLoader());
            synchronized (this) {
                ProcessRecord app = newProcessRecordLocked(info, info.processName, VALIDATE_TOKENS, MY_PID);
                app.persistent = SHOW_ACTIVITY_START_TIME;
                app.pid = MY_PID;
                app.maxAdj = -16;
                app.makeActive(this.mSystemThread.getApplicationThread(), this.mProcessStats);
                this.mProcessNames.put(app.processName, app.uid, app);
                synchronized (this.mPidsSelfLocked) {
                    this.mPidsSelfLocked.put(app.pid, app);
                }
                updateLruProcessLocked(app, VALIDATE_TOKENS, null);
                updateOomAdjLocked();
            }
        } catch (NameNotFoundException e) {
            throw new RuntimeException("Unable to find android system package", e);
        }
    }

    public void setWindowManager(WindowManagerService wm) {
        this.mWindowManager = wm;
        this.mStackSupervisor.setWindowManager(wm);
    }

    public void setUsageStatsManager(UsageStatsManagerInternal usageStatsManager) {
        this.mUsageStatsService = usageStatsManager;
    }

    public void startObservingNativeCrashes() {
        new NativeCrashListener(this).start();
    }

    public IAppOpsService getAppOpsService() {
        return this.mAppOpsService;
    }

    public ActivityManagerService(Context systemContext) {
        this.mTaskStackListeners = new RemoteCallbackList();
        this.mShowDialogs = SHOW_ACTIVITY_START_TIME;
        this.mBroadcastQueues = new BroadcastQueue[SHOW_NOT_RESPONDING_MSG];
        this.mFocusedActivity = null;
        this.mTmpRecents = new ArrayList();
        this.mPendingAssistExtras = new ArrayList();
        this.mProcessList = new ProcessList();
        this.mProcessNames = new ProcessMap();
        this.mIsolatedProcesses = new SparseArray();
        this.mNextIsolatedProcessUid = MY_PID;
        this.mHeavyWeightProcess = null;
        this.mProcessCrashTimes = new ProcessMap();
        this.mBadProcesses = new ProcessMap();
        this.mPidsSelfLocked = new SparseArray();
        this.mForegroundProcesses = new SparseArray();
        this.mProcessesOnHold = new ArrayList();
        this.mPersistentStartingProcesses = new ArrayList();
        this.mRemovedProcesses = new ArrayList();
        this.mLruProcesses = new ArrayList();
        this.mLruProcessActivityStart = MY_PID;
        this.mLruProcessServiceStart = MY_PID;
        this.mProcessesToGc = new ArrayList();
        this.mPendingPssProcesses = new ArrayList();
        this.mLastFullPssTime = SystemClock.uptimeMillis();
        this.mFullPssPending = VALIDATE_TOKENS;
        this.mStartedUsers = new SparseArray();
        this.mUserLru = new ArrayList();
        int[] iArr = new int[SHOW_ERROR_MSG];
        iArr[MY_PID] = MY_PID;
        this.mStartedUserArray = iArr;
        this.mUserSwitchObservers = new RemoteCallbackList();
        this.mIntentSenderRecords = new HashMap();
        this.mAlreadyLoggedViolatedStacks = new HashSet();
        this.mStrictModeBuffer = new StringBuilder();
        this.mRegisteredReceivers = new HashMap();
        this.mReceiverResolver = new C01221();
        this.mStickyBroadcasts = new SparseArray();
        this.mAssociations = new SparseArray();
        this.mBackupAppName = null;
        this.mBackupTarget = null;
        this.mLaunchingProviders = new ArrayList();
        this.mGrantedUriPermissions = new SparseArray();
        this.mConfiguration = new Configuration();
        this.mConfigurationSeq = MY_PID;
        this.mStringBuilder = new StringBuilder(DumpState.DUMP_VERIFIERS);
        this.mTopAction = "android.intent.action.MAIN";
        this.mProcessesReady = VALIDATE_TOKENS;
        this.mSystemReady = VALIDATE_TOKENS;
        this.mBooting = VALIDATE_TOKENS;
        this.mCallFinishBooting = VALIDATE_TOKENS;
        this.mBootAnimationComplete = VALIDATE_TOKENS;
        this.mWaitingUpdate = VALIDATE_TOKENS;
        this.mDidUpdate = VALIDATE_TOKENS;
        this.mOnBattery = VALIDATE_TOKENS;
        this.mLaunchWarningShown = VALIDATE_TOKENS;
        this.mSleeping = VALIDATE_TOKENS;
        this.mRunningVoice = VALIDATE_TOKENS;
        this.mWakefulness = SHOW_ERROR_MSG;
        this.mLockScreenShown = MY_PID;
        this.mShuttingDown = VALIDATE_TOKENS;
        this.mAdjSeq = MY_PID;
        this.mLruSeq = MY_PID;
        this.mNumNonCachedProcs = MY_PID;
        this.mNumCachedHiddenProcs = MY_PID;
        this.mNumServiceProcs = MY_PID;
        this.mNewNumAServiceProcs = MY_PID;
        this.mNewNumServiceProcs = MY_PID;
        this.mAllowLowerMemLevel = VALIDATE_TOKENS;
        this.mLastMemoryLevel = MY_PID;
        this.mLastIdleTime = SystemClock.uptimeMillis();
        this.mLowRamTimeSinceLastIdle = 0;
        this.mLowRamStartTime = 0;
        this.mCurResumedPackage = null;
        this.mCurResumedUid = -1;
        this.mForegroundPackages = new ProcessMap();
        this.mTestPssMode = VALIDATE_TOKENS;
        this.mDebugApp = null;
        this.mWaitForDebugger = VALIDATE_TOKENS;
        this.mDebugTransient = VALIDATE_TOKENS;
        this.mOrigDebugApp = null;
        this.mOrigWaitForDebugger = VALIDATE_TOKENS;
        this.mAlwaysFinishActivities = VALIDATE_TOKENS;
        this.mController = null;
        this.mProfileApp = null;
        this.mProfileProc = null;
        this.mSamplingInterval = MY_PID;
        this.mAutoStopProfiler = VALIDATE_TOKENS;
        this.mProfileType = MY_PID;
        this.mOpenGlTraceApp = null;
        this.mTmpLong = new long[SHOW_ERROR_MSG];
        this.mProcessObservers = new RemoteCallbackList();
        this.mActiveProcessChanges = new ProcessChangeItem[GC_BACKGROUND_PROCESSES_MSG];
        this.mPendingProcessChanges = new ArrayList();
        this.mAvailProcessChanges = new ArrayList();
        this.mProcessCpuTracker = new ProcessCpuTracker(VALIDATE_TOKENS);
        this.mLastCpuTime = new AtomicLong(0);
        this.mProcessCpuMutexFree = new AtomicBoolean(SHOW_ACTIVITY_START_TIME);
        this.mLastWriteTime = 0;
        this.mUpdateLock = new UpdateLock("immersive");
        this.mBooted = VALIDATE_TOKENS;
        this.mProcessLimit = ProcessList.MAX_CACHED_APPS;
        this.mProcessLimitOverride = -1;
        this.mCurrentUserId = MY_PID;
        this.mTargetUserId = -10000;
        iArr = new int[SHOW_ERROR_MSG];
        iArr[MY_PID] = MY_PID;
        this.mCurrentProfileIds = iArr;
        this.mUserProfileGroupIdsSelfLocked = new SparseIntArray();
        this.mLastMemUsageReportTime = 0;
        this.mBgHandler = new C01232(BackgroundThread.getHandler().getLooper());
        this.mTaskRecordComparator = new C01254();
        this.mContext = systemContext;
        this.mFactoryTest = FactoryTest.getMode();
        this.mSystemThread = ActivityThread.currentActivityThread();
        Slog.i(TAG, "Memory class: " + ActivityManager.staticGetMemoryClass());
        this.mHandlerThread = new ServiceThread(TAG, -2, VALIDATE_TOKENS);
        this.mHandlerThread.start();
        this.mHandler = new MainHandler(this.mHandlerThread.getLooper());
        this.mFgBroadcastQueue = new BroadcastQueue(this, this.mHandler, "foreground", 10000, VALIDATE_TOKENS);
        this.mBgBroadcastQueue = new BroadcastQueue(this, this.mHandler, "background", 60000, SHOW_ACTIVITY_START_TIME);
        this.mBroadcastQueues[MY_PID] = this.mFgBroadcastQueue;
        this.mBroadcastQueues[SHOW_ERROR_MSG] = this.mBgBroadcastQueue;
        this.mServices = new ActiveServices(this);
        this.mProviderMap = new ProviderMap(this);
        File systemDir = new File(Environment.getDataDirectory(), "system");
        systemDir.mkdirs();
        this.mBatteryStatsService = new BatteryStatsService(systemDir, this.mHandler);
        this.mBatteryStatsService.getActiveStatistics().readLocked();
        this.mBatteryStatsService.getActiveStatistics().writeAsyncLocked();
        this.mOnBattery = this.mBatteryStatsService.getActiveStatistics().getIsOnBattery();
        this.mBatteryStatsService.getActiveStatistics().setCallback(this);
        this.mProcessStats = new ProcessStatsService(this, new File(systemDir, "procstats"));
        this.mAppOpsService = new AppOpsService(new File(systemDir, "appops.xml"), this.mHandler);
        this.mGrantFile = new AtomicFile(new File(systemDir, "urigrants.xml"));
        this.mStartedUsers.put(MY_PID, new UserStartedState(new UserHandle(MY_PID), SHOW_ACTIVITY_START_TIME));
        this.mUserLru.add(Integer.valueOf(MY_PID));
        updateStartedUserArrayLocked();
        this.GL_ES_VERSION = SystemProperties.getInt("ro.opengles.version", MY_PID);
        this.mTrackingAssociations = "1".equals(SystemProperties.get("debug.track-associations"));
        this.mConfiguration.setToDefaults();
        this.mConfiguration.locale = Locale.getDefault();
        this.mConfiguration.seq = SHOW_ERROR_MSG;
        this.mConfigurationSeq = SHOW_ERROR_MSG;
        this.mProcessCpuTracker.init();
        this.mCompatModePackages = new CompatModePackages(this, systemDir, this.mHandler);
        this.mIntentFirewall = new IntentFirewall(new IntentFirewallInterface(), this.mHandler);
        this.mStackSupervisor = new ActivityStackSupervisor(this);
        this.mTaskPersister = new TaskPersister(systemDir, this.mStackSupervisor);
        this.mProcessCpuThread = new C01243("CpuTracker");
        Watchdog.getInstance().addMonitor(this);
        Watchdog.getInstance().addThread(this.mHandler);
    }

    public void setSystemServiceManager(SystemServiceManager mgr) {
        this.mSystemServiceManager = mgr;
    }

    public void setInstaller(Installer installer) {
        this.mInstaller = installer;
    }

    private void start() {
        Process.removeAllProcessGroups();
        this.mProcessCpuThread.start();
        this.mBatteryStatsService.publish(this.mContext);
        this.mAppOpsService.publish(this.mContext);
        Slog.d("AppOps", "AppOpsService published");
        LocalServices.addService(ActivityManagerInternal.class, new LocalService());
    }

    public void initPowerManagement() {
        this.mStackSupervisor.initPowerManagement();
        this.mBatteryStatsService.initPowerManagement();
    }

    public boolean onTransact(int code, Parcel data, Parcel reply, int flags) throws RemoteException {
        if (code == 1599295570) {
            ArrayList<IBinder> procs = new ArrayList();
            synchronized (this) {
                int NP = this.mProcessNames.getMap().size();
                for (int ip = MY_PID; ip < NP; ip += SHOW_ERROR_MSG) {
                    SparseArray<ProcessRecord> apps = (SparseArray) this.mProcessNames.getMap().valueAt(ip);
                    int NA = apps.size();
                    for (int ia = MY_PID; ia < NA; ia += SHOW_ERROR_MSG) {
                        ProcessRecord app = (ProcessRecord) apps.valueAt(ia);
                        if (app.thread != null) {
                            procs.add(app.thread.asBinder());
                        }
                    }
                }
            }
            int N = procs.size();
            for (int i = MY_PID; i < N; i += SHOW_ERROR_MSG) {
                Parcel data2 = Parcel.obtain();
                try {
                    ((IBinder) procs.get(i)).transact(1599295570, data2, null, MY_PID);
                } catch (RemoteException e) {
                }
                data2.recycle();
            }
        }
        try {
            return super.onTransact(code, data, reply, flags);
        } catch (RuntimeException e2) {
            if (!(e2 instanceof SecurityException)) {
                Slog.wtf(TAG, "Activity Manager Crash", e2);
            }
            throw e2;
        }
    }

    void updateCpuStats() {
        if (this.mLastCpuTime.get() < SystemClock.uptimeMillis() - MONITOR_CPU_MIN_TIME && this.mProcessCpuMutexFree.compareAndSet(SHOW_ACTIVITY_START_TIME, VALIDATE_TOKENS)) {
            synchronized (this.mProcessCpuThread) {
                this.mProcessCpuThread.notify();
            }
        }
    }

    void updateCpuStatsNow() {
        synchronized (this.mProcessCpuTracker) {
            this.mProcessCpuMutexFree.set(VALIDATE_TOKENS);
            long now = SystemClock.uptimeMillis();
            boolean haveNewCpuStats = VALIDATE_TOKENS;
            if (this.mLastCpuTime.get() < now - MONITOR_CPU_MIN_TIME) {
                this.mLastCpuTime.set(now);
                haveNewCpuStats = SHOW_ACTIVITY_START_TIME;
                this.mProcessCpuTracker.update();
                if ("true".equals(SystemProperties.get("events.cpu"))) {
                    int user = this.mProcessCpuTracker.getLastUserTime();
                    int system = this.mProcessCpuTracker.getLastSystemTime();
                    int iowait = this.mProcessCpuTracker.getLastIoWaitTime();
                    int irq = this.mProcessCpuTracker.getLastIrqTime();
                    int softIrq = this.mProcessCpuTracker.getLastSoftIrqTime();
                    int total = ((((user + system) + iowait) + irq) + softIrq) + this.mProcessCpuTracker.getLastIdleTime();
                    if (total == 0) {
                        total = SHOW_ERROR_MSG;
                    }
                    Integer[] numArr = new Object[WAIT_FOR_DEBUGGER_MSG];
                    numArr[MY_PID] = Integer.valueOf((((((user + system) + iowait) + irq) + softIrq) * FIRST_SUPERVISOR_STACK_MSG) / total);
                    numArr[SHOW_ERROR_MSG] = Integer.valueOf((user * FIRST_SUPERVISOR_STACK_MSG) / total);
                    numArr[SHOW_NOT_RESPONDING_MSG] = Integer.valueOf((system * FIRST_SUPERVISOR_STACK_MSG) / total);
                    numArr[SHOW_FACTORY_ERROR_MSG] = Integer.valueOf((iowait * FIRST_SUPERVISOR_STACK_MSG) / total);
                    numArr[UPDATE_CONFIGURATION_MSG] = Integer.valueOf((irq * FIRST_SUPERVISOR_STACK_MSG) / total);
                    numArr[GC_BACKGROUND_PROCESSES_MSG] = Integer.valueOf((softIrq * FIRST_SUPERVISOR_STACK_MSG) / total);
                    EventLog.writeEvent(EventLogTags.CPU, numArr);
                }
            }
            long[] cpuSpeedTimes = this.mProcessCpuTracker.getLastCpuSpeedTimes();
            BatteryStatsImpl bstats = this.mBatteryStatsService.getActiveStatistics();
            synchronized (bstats) {
                synchronized (this.mPidsSelfLocked) {
                    if (haveNewCpuStats) {
                        if (this.mOnBattery) {
                            int perc = bstats.startAddingCpuLocked();
                            int totalUTime = MY_PID;
                            int totalSTime = MY_PID;
                            int N = this.mProcessCpuTracker.countStats();
                            for (int i = MY_PID; i < N; i += SHOW_ERROR_MSG) {
                                Stats st = this.mProcessCpuTracker.getStats(i);
                                if (st.working) {
                                    ProcessRecord pr = (ProcessRecord) this.mPidsSelfLocked.get(st.pid);
                                    int otherUTime = (st.rel_utime * perc) / FIRST_SUPERVISOR_STACK_MSG;
                                    int otherSTime = (st.rel_stime * perc) / FIRST_SUPERVISOR_STACK_MSG;
                                    totalUTime += otherUTime;
                                    totalSTime += otherSTime;
                                    Proc ps;
                                    if (pr != null) {
                                        ps = pr.curProcBatteryStats;
                                        if (ps == null || !ps.isActive()) {
                                            ps = bstats.getProcessStatsLocked(pr.info.uid, pr.processName);
                                            pr.curProcBatteryStats = ps;
                                        }
                                        ps.addCpuTimeLocked(st.rel_utime - otherUTime, st.rel_stime - otherSTime);
                                        ps.addSpeedStepTimes(cpuSpeedTimes);
                                        pr.curCpuTime += (long) ((st.rel_utime + st.rel_stime) * 10);
                                    } else {
                                        ps = st.batteryStats;
                                        if (ps == null || !ps.isActive()) {
                                            ps = bstats.getProcessStatsLocked(bstats.mapUid(st.uid), st.name);
                                            st.batteryStats = ps;
                                        }
                                        ps.addCpuTimeLocked(st.rel_utime - otherUTime, st.rel_stime - otherSTime);
                                        ps.addSpeedStepTimes(cpuSpeedTimes);
                                    }
                                }
                            }
                            bstats.finishAddingCpuLocked(perc, totalUTime, totalSTime, cpuSpeedTimes);
                        }
                    }
                }
                if (this.mLastWriteTime < now - BATTERY_STATS_TIME) {
                    this.mLastWriteTime = now;
                    this.mBatteryStatsService.getActiveStatistics().writeAsyncLocked();
                }
            }
        }
    }

    public void batteryNeedsCpuUpdate() {
        updateCpuStatsNow();
    }

    public void batteryPowerChanged(boolean onBattery) {
        updateCpuStatsNow();
        synchronized (this) {
            synchronized (this.mPidsSelfLocked) {
                this.mOnBattery = onBattery;
            }
        }
    }

    private HashMap<String, IBinder> getCommonServicesLocked(boolean isolated) {
        if (this.mAppBindArgs == null) {
            this.mAppBindArgs = new HashMap();
            if (!isolated) {
                this.mAppBindArgs.put("package", ServiceManager.getService("package"));
                this.mAppBindArgs.put("window", ServiceManager.getService("window"));
                this.mAppBindArgs.put("alarm", ServiceManager.getService("alarm"));
            }
        }
        return this.mAppBindArgs;
    }

    final void setFocusedActivityLocked(ActivityRecord r, String reason) {
        if (this.mFocusedActivity != r) {
            this.mFocusedActivity = r;
            if (r.task == null || r.task.voiceInteractor == null) {
                finishRunningVoiceLocked();
            } else {
                startRunningVoiceLocked();
            }
            this.mStackSupervisor.setFocusedStack(r, reason + " setFocusedActivity");
            if (r != null) {
                this.mWindowManager.setFocusedApp(r.appToken, SHOW_ACTIVITY_START_TIME);
            }
            applyUpdateLockStateLocked(r);
        }
        Object[] objArr = new Object[SHOW_NOT_RESPONDING_MSG];
        objArr[MY_PID] = Integer.valueOf(this.mCurrentUserId);
        objArr[SHOW_ERROR_MSG] = this.mFocusedActivity == null ? "NULL" : this.mFocusedActivity.shortComponentName;
        EventLog.writeEvent(EventLogTags.AM_FOCUSED_ACTIVITY, objArr);
    }

    final void clearFocusedActivity(ActivityRecord r) {
        if (this.mFocusedActivity == r) {
            this.mFocusedActivity = null;
        }
    }

    public void setFocusedStack(int stackId) {
        synchronized (this) {
            ActivityStack stack = this.mStackSupervisor.getStack(stackId);
            if (stack != null) {
                ActivityRecord r = stack.topRunningActivityLocked(null);
                if (r != null) {
                    setFocusedActivityLocked(r, "setFocusedStack");
                }
            }
        }
    }

    public void registerTaskStackListener(ITaskStackListener listener) throws RemoteException {
        synchronized (this) {
            if (listener != null) {
                this.mTaskStackListeners.register(listener);
            }
        }
    }

    public void notifyActivityDrawn(IBinder token) {
        synchronized (this) {
            ActivityRecord r = this.mStackSupervisor.isInAnyStackLocked(token);
            if (r != null) {
                r.task.stack.notifyActivityDrawnLocked(r);
            }
        }
    }

    final void applyUpdateLockStateLocked(ActivityRecord r) {
        boolean nextState;
        int i = SHOW_ERROR_MSG;
        if (r == null || !r.immersive) {
            nextState = VALIDATE_TOKENS;
        } else {
            nextState = SHOW_ACTIVITY_START_TIME;
        }
        MainHandler mainHandler = this.mHandler;
        MainHandler mainHandler2 = this.mHandler;
        if (!nextState) {
            i = MY_PID;
        }
        mainHandler.sendMessage(mainHandler2.obtainMessage(IMMERSIVE_MODE_LOCK_MSG, i, MY_PID, r));
    }

    final void showAskCompatModeDialogLocked(ActivityRecord r) {
        Message msg = Message.obtain();
        msg.what = SHOW_COMPAT_MODE_DIALOG_MSG;
        if (r.task.askedCompatMode) {
            r = null;
        }
        msg.obj = r;
        this.mHandler.sendMessage(msg);
    }

    private int updateLruProcessInternalLocked(ProcessRecord app, long now, int index, String what, Object obj, ProcessRecord srcApp) {
        app.lastActivityTime = now;
        if (app.activities.size() > 0) {
            return index;
        }
        int lrui = this.mLruProcesses.lastIndexOf(app);
        if (lrui < 0) {
            Slog.wtf(TAG, "Adding dependent process " + app + " not on LRU list: " + what + " " + obj + " from " + srcApp);
            return index;
        } else if (lrui >= index) {
            return index;
        } else {
            if (lrui >= this.mLruProcessActivityStart) {
                return index;
            }
            this.mLruProcesses.remove(lrui);
            if (index > 0) {
                index--;
            }
            this.mLruProcesses.add(index, app);
            return index;
        }
    }

    final void removeLruProcessLocked(ProcessRecord app) {
        int lrui = this.mLruProcesses.lastIndexOf(app);
        if (lrui >= 0) {
            if (!app.killed) {
                Slog.wtfStack(TAG, "Removing process that hasn't been killed: " + app);
                Process.killProcessQuiet(app.pid);
                Process.killProcessGroup(app.info.uid, app.pid);
            }
            if (lrui <= this.mLruProcessActivityStart) {
                this.mLruProcessActivityStart--;
            }
            if (lrui <= this.mLruProcessServiceStart) {
                this.mLruProcessServiceStart--;
            }
            this.mLruProcesses.remove(lrui);
        }
    }

    final void updateLruProcessLocked(ProcessRecord app, boolean activityChange, ProcessRecord client) {
        boolean hasActivity = (app.activities.size() > 0 || app.hasClientActivities || app.treatLikeActivity) ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
        if (activityChange || !hasActivity || (app.persistent && !this.mLruProcesses.contains(app))) {
            int N;
            this.mLruSeq += SHOW_ERROR_MSG;
            long now = SystemClock.uptimeMillis();
            app.lastActivityTime = now;
            if (hasActivity) {
                N = this.mLruProcesses.size();
                if (N > 0 && this.mLruProcesses.get(N - 1) == app) {
                    return;
                }
            } else if (this.mLruProcessServiceStart > 0 && this.mLruProcesses.get(this.mLruProcessServiceStart - 1) == app) {
                return;
            }
            int lrui = this.mLruProcesses.lastIndexOf(app);
            if (!app.persistent || lrui < 0) {
                int nextIndex;
                int j;
                if (lrui >= 0) {
                    if (lrui < this.mLruProcessActivityStart) {
                        this.mLruProcessActivityStart--;
                    }
                    if (lrui < this.mLruProcessServiceStart) {
                        this.mLruProcessServiceStart--;
                    }
                    this.mLruProcesses.remove(lrui);
                }
                if (hasActivity) {
                    N = this.mLruProcesses.size();
                    if (app.activities.size() == 0 && this.mLruProcessActivityStart < N - 1) {
                        this.mLruProcesses.add(N - 1, app);
                        int uid = app.info.uid;
                        int i = N - 2;
                        while (i > this.mLruProcessActivityStart) {
                            if (((ProcessRecord) this.mLruProcesses.get(i)).info.uid != uid) {
                                break;
                            }
                            if (((ProcessRecord) this.mLruProcesses.get(i - 1)).info.uid != uid) {
                                ProcessRecord tmp = (ProcessRecord) this.mLruProcesses.get(i);
                                this.mLruProcesses.set(i, this.mLruProcesses.get(i - 1));
                                this.mLruProcesses.set(i - 1, tmp);
                                i--;
                            }
                            i--;
                        }
                    } else {
                        this.mLruProcesses.add(app);
                    }
                    nextIndex = this.mLruProcessServiceStart;
                } else {
                    int index = this.mLruProcessServiceStart;
                    if (client != null) {
                        int clientIndex = this.mLruProcesses.lastIndexOf(client);
                        if (clientIndex <= lrui) {
                            clientIndex = lrui;
                        }
                        if (clientIndex >= 0 && index > clientIndex) {
                            index = clientIndex;
                        }
                    }
                    this.mLruProcesses.add(index, app);
                    nextIndex = index - 1;
                    this.mLruProcessActivityStart += SHOW_ERROR_MSG;
                    this.mLruProcessServiceStart += SHOW_ERROR_MSG;
                }
                for (j = app.connections.size() - 1; j >= 0; j--) {
                    ConnectionRecord cr = (ConnectionRecord) app.connections.valueAt(j);
                    if (!(cr.binding == null || cr.serviceDead || cr.binding.service == null || cr.binding.service.app == null || cr.binding.service.app.lruSeq == this.mLruSeq || cr.binding.service.app.persistent)) {
                        nextIndex = updateLruProcessInternalLocked(cr.binding.service.app, now, nextIndex, "service connection", cr, app);
                    }
                }
                for (j = app.conProviders.size() - 1; j >= 0; j--) {
                    ContentProviderRecord cpr = ((ContentProviderConnection) app.conProviders.get(j)).provider;
                    if (!(cpr.proc == null || cpr.proc.lruSeq == this.mLruSeq || cpr.proc.persistent)) {
                        nextIndex = updateLruProcessInternalLocked(cpr.proc, now, nextIndex, "provider reference", cpr, app);
                    }
                }
            }
        }
    }

    final ProcessRecord getProcessRecordLocked(String processName, int uid, boolean keepIfLarge) {
        if (uid == NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY) {
            SparseArray<ProcessRecord> procs = (SparseArray) this.mProcessNames.getMap().get(processName);
            if (procs == null) {
                return null;
            }
            int procCount = procs.size();
            for (int i = MY_PID; i < procCount; i += SHOW_ERROR_MSG) {
                int procUid = procs.keyAt(i);
                if (!UserHandle.isApp(procUid) && UserHandle.isSameUser(procUid, uid)) {
                    return (ProcessRecord) procs.valueAt(i);
                }
            }
        }
        ProcessRecord proc = (ProcessRecord) this.mProcessNames.get(processName, uid);
        if (proc != null && !keepIfLarge && this.mLastMemoryLevel > 0 && proc.setProcState >= UPDATE_TIME_ZONE && proc.lastCachedPss >= this.mProcessList.getCachedRestoreThresholdKb()) {
            if (proc.baseProcessTracker != null) {
                proc.baseProcessTracker.reportCachedKill(proc.pkgList, proc.lastCachedPss);
            }
            proc.kill(Long.toString(proc.lastCachedPss) + "k from cached", SHOW_ACTIVITY_START_TIME);
        }
        return proc;
    }

    void ensurePackageDexOpt(String packageName) {
        try {
            if (AppGlobals.getPackageManager().performDexOptIfNeeded(packageName, null)) {
                this.mDidDexOpt = SHOW_ACTIVITY_START_TIME;
            }
        } catch (RemoteException e) {
        }
    }

    boolean isNextTransitionForward() {
        int transit = this.mWindowManager.getPendingAppTransition();
        return (transit == WAIT_FOR_DEBUGGER_MSG || transit == 8 || transit == 10) ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
    }

    int startIsolatedProcess(String entryPoint, String[] entryPointArgs, String processName, String abiOverride, int uid, Runnable crashHandler) {
        int i;
        synchronized (this) {
            ApplicationInfo info = new ApplicationInfo();
            info.uid = NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY;
            info.processName = processName;
            info.className = entryPoint;
            info.packageName = "android";
            ProcessRecord proc = startProcessLocked(processName, info, VALIDATE_TOKENS, MY_PID, "", null, SHOW_ACTIVITY_START_TIME, SHOW_ACTIVITY_START_TIME, uid, SHOW_ACTIVITY_START_TIME, abiOverride, entryPoint, entryPointArgs, crashHandler);
            i = proc != null ? proc.pid : MY_PID;
        }
        return i;
    }

    final ProcessRecord startProcessLocked(String processName, ApplicationInfo info, boolean knownToBeDead, int intentFlags, String hostingType, ComponentName hostingName, boolean allowWhileBooting, boolean isolated, boolean keepIfLarge) {
        return startProcessLocked(processName, info, knownToBeDead, intentFlags, hostingType, hostingName, allowWhileBooting, isolated, MY_PID, keepIfLarge, null, null, null, null);
    }

    final ProcessRecord startProcessLocked(String processName, ApplicationInfo info, boolean knownToBeDead, int intentFlags, String hostingType, ComponentName hostingName, boolean allowWhileBooting, boolean isolated, int isolatedUid, boolean keepIfLarge, String abiOverride, String entryPoint, String[] entryPointArgs, Runnable crashHandler) {
        ProcessRecord app;
        long startTime = SystemClock.elapsedRealtime();
        if (isolated) {
            app = null;
        } else {
            app = getProcessRecordLocked(processName, info.uid, keepIfLarge);
            checkTime(startTime, "startProcess: after getProcessRecord");
        }
        if (app != null && app.pid > 0) {
            if (!knownToBeDead || app.thread == null) {
                app.addPackage(info.packageName, info.versionCode, this.mProcessStats);
                checkTime(startTime, "startProcess: done, added package to proc");
                return app;
            }
            checkTime(startTime, "startProcess: bad proc running, killing");
            Process.killProcessGroup(app.info.uid, app.pid);
            handleAppDiedLocked(app, SHOW_ACTIVITY_START_TIME, SHOW_ACTIVITY_START_TIME);
            checkTime(startTime, "startProcess: done killing old proc");
        }
        String hostingNameStr = hostingName != null ? hostingName.flattenToShortString() : null;
        if (!isolated) {
            if ((intentFlags & UPDATE_CONFIGURATION_MSG) == 0) {
                this.mProcessCrashTimes.remove(info.processName, info.uid);
                if (this.mBadProcesses.get(info.processName, info.uid) != null) {
                    Object[] objArr = new Object[SHOW_FACTORY_ERROR_MSG];
                    objArr[MY_PID] = Integer.valueOf(UserHandle.getUserId(info.uid));
                    objArr[SHOW_ERROR_MSG] = Integer.valueOf(info.uid);
                    objArr[SHOW_NOT_RESPONDING_MSG] = info.processName;
                    EventLog.writeEvent(EventLogTags.AM_PROC_GOOD, objArr);
                    this.mBadProcesses.remove(info.processName, info.uid);
                    if (app != null) {
                        app.bad = VALIDATE_TOKENS;
                    }
                }
            } else if (this.mBadProcesses.get(info.processName, info.uid) != null) {
                return null;
            }
        }
        if (app == null) {
            checkTime(startTime, "startProcess: creating new process record");
            app = newProcessRecordLocked(info, processName, isolated, isolatedUid);
            if (app == null) {
                Slog.w(TAG, "Failed making new process record for " + processName + "/" + info.uid + " isolated=" + isolated);
                return null;
            }
            app.crashHandler = crashHandler;
            this.mProcessNames.put(processName, app.uid, app);
            if (isolated) {
                this.mIsolatedProcesses.put(app.uid, app);
            }
            checkTime(startTime, "startProcess: done creating new process record");
        } else {
            app.addPackage(info.packageName, info.versionCode, this.mProcessStats);
            checkTime(startTime, "startProcess: added package to existing proc");
        }
        if (this.mProcessesReady || isAllowedWhileBooting(info) || allowWhileBooting) {
            checkTime(startTime, "startProcess: stepping in to startProcess");
            startProcessLocked(app, hostingType, hostingNameStr, abiOverride, entryPoint, entryPointArgs);
            checkTime(startTime, "startProcess: done starting proc!");
            return app.pid != 0 ? app : null;
        } else {
            if (!this.mProcessesOnHold.contains(app)) {
                this.mProcessesOnHold.add(app);
            }
            checkTime(startTime, "startProcess: returning with proc on hold");
            return app;
        }
    }

    boolean isAllowedWhileBooting(ApplicationInfo ai) {
        return (ai.flags & 8) != 0 ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
    }

    private final void startProcessLocked(ProcessRecord app, String hostingType, String hostingNameStr) {
        startProcessLocked(app, hostingType, hostingNameStr, null, null, null);
    }

    private final void startProcessLocked(ProcessRecord app, String hostingType, String hostingNameStr, String abiOverride, String entryPoint, String[] entryPointArgs) {
        long startTime = SystemClock.elapsedRealtime();
        if (app.pid > 0 && app.pid != MY_PID) {
            checkTime(startTime, "startProcess: removing from pids map");
            synchronized (this.mPidsSelfLocked) {
                this.mPidsSelfLocked.remove(app.pid);
                this.mHandler.removeMessages(PROC_START_TIMEOUT_MSG, app);
            }
            checkTime(startTime, "startProcess: done removing from pids map");
            app.setPid(MY_PID);
        }
        this.mProcessesOnHold.remove(app);
        checkTime(startTime, "startProcess: starting to update cpu stats");
        updateCpuStats();
        checkTime(startTime, "startProcess: done updating cpu stats");
        try {
            String requiredAbi;
            int uid = app.uid;
            int[] gids = null;
            int mountExternal = MY_PID;
            if (!app.isolated) {
                int[] permGids = null;
                try {
                    checkTime(startTime, "startProcess: getting gids from package manager");
                    PackageManager pm = this.mContext.getPackageManager();
                    permGids = pm.getPackageGids(app.info.packageName);
                    if (Environment.isExternalStorageEmulated()) {
                        checkTime(startTime, "startProcess: checking external storage perm");
                        mountExternal = pm.checkPermission("android.permission.ACCESS_ALL_EXTERNAL_STORAGE", app.info.packageName) == 0 ? SHOW_FACTORY_ERROR_MSG : SHOW_NOT_RESPONDING_MSG;
                    }
                } catch (Throwable e) {
                    Slog.w(TAG, "Unable to retrieve gids", e);
                }
                if (permGids == null) {
                    gids = new int[SHOW_NOT_RESPONDING_MSG];
                } else {
                    gids = new int[(permGids.length + SHOW_NOT_RESPONDING_MSG)];
                    System.arraycopy(permGids, MY_PID, gids, SHOW_NOT_RESPONDING_MSG, permGids.length);
                }
                gids[MY_PID] = UserHandle.getSharedAppGid(UserHandle.getAppId(uid));
                gids[SHOW_ERROR_MSG] = UserHandle.getUserGid(UserHandle.getUserId(uid));
            }
            checkTime(startTime, "startProcess: building args");
            if (this.mFactoryTest != 0) {
                if (this.mFactoryTest == SHOW_ERROR_MSG && this.mTopComponent != null && app.processName.equals(this.mTopComponent.getPackageName())) {
                    uid = MY_PID;
                }
                if (this.mFactoryTest == SHOW_NOT_RESPONDING_MSG && (app.info.flags & 16) != 0) {
                    uid = MY_PID;
                }
            }
            int debugFlags = MY_PID;
            if ((app.info.flags & SHOW_NOT_RESPONDING_MSG) != 0) {
                debugFlags = (MY_PID | SHOW_ERROR_MSG) | SHOW_NOT_RESPONDING_MSG;
            }
            if ((app.info.flags & 16384) != 0 || this.mSafeMode == SHOW_ACTIVITY_START_TIME) {
                debugFlags |= 8;
            }
            if ("1".equals(SystemProperties.get("debug.checkjni"))) {
                debugFlags |= SHOW_NOT_RESPONDING_MSG;
            }
            if ("1".equals(SystemProperties.get("debug.jni.logging"))) {
                debugFlags |= 16;
            }
            if ("1".equals(SystemProperties.get("debug.assert"))) {
                debugFlags |= UPDATE_CONFIGURATION_MSG;
            }
            if (abiOverride != null) {
                requiredAbi = abiOverride;
            } else {
                requiredAbi = app.info.primaryCpuAbi;
            }
            if (requiredAbi == null) {
                requiredAbi = Build.SUPPORTED_ABIS[MY_PID];
            }
            String instructionSet = null;
            if (app.info.primaryCpuAbi != null) {
                instructionSet = VMRuntime.getInstructionSet(app.info.primaryCpuAbi);
            }
            app.gids = gids;
            app.requiredAbi = requiredAbi;
            app.instructionSet = instructionSet;
            boolean isActivityProcess = entryPoint == null ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
            if (entryPoint == null) {
                entryPoint = "android.app.ActivityThread";
            }
            checkTime(startTime, "startProcess: asking zygote to start proc");
            ProcessStartResult startResult = Process.start(entryPoint, app.processName, uid, uid, gids, debugFlags, mountExternal, app.info.targetSdkVersion, app.info.seinfo, requiredAbi, instructionSet, app.info.dataDir, entryPointArgs);
            checkTime(startTime, "startProcess: returned from zygote!");
            if (app.isolated) {
                this.mBatteryStatsService.addIsolatedUid(app.uid, app.info.uid);
            }
            this.mBatteryStatsService.noteProcessStart(app.processName, app.info.uid);
            checkTime(startTime, "startProcess: done updating battery stats");
            Object[] objArr = new Object[WAIT_FOR_DEBUGGER_MSG];
            objArr[MY_PID] = Integer.valueOf(UserHandle.getUserId(uid));
            objArr[SHOW_ERROR_MSG] = Integer.valueOf(startResult.pid);
            objArr[SHOW_NOT_RESPONDING_MSG] = Integer.valueOf(uid);
            objArr[SHOW_FACTORY_ERROR_MSG] = app.processName;
            objArr[UPDATE_CONFIGURATION_MSG] = hostingType;
            objArr[GC_BACKGROUND_PROCESSES_MSG] = hostingNameStr != null ? hostingNameStr : "";
            EventLog.writeEvent(EventLogTags.AM_PROC_START, objArr);
            if (app.persistent) {
                Watchdog.getInstance().processStarted(app.processName, startResult.pid);
            }
            checkTime(startTime, "startProcess: building log message");
            StringBuilder buf = this.mStringBuilder;
            buf.setLength(MY_PID);
            buf.append("Start proc ");
            buf.append(startResult.pid);
            buf.append(':');
            buf.append(app.processName);
            buf.append('/');
            UserHandle.formatUid(buf, uid);
            if (!isActivityProcess) {
                buf.append(" [");
                buf.append(entryPoint);
                buf.append("]");
            }
            buf.append(" for ");
            buf.append(hostingType);
            if (hostingNameStr != null) {
                buf.append(" ");
                buf.append(hostingNameStr);
            }
            Slog.i(TAG, buf.toString());
            app.setPid(startResult.pid);
            app.usingWrapper = startResult.usingWrapper;
            app.removed = VALIDATE_TOKENS;
            app.killed = VALIDATE_TOKENS;
            app.killedByAm = VALIDATE_TOKENS;
            checkTime(startTime, "startProcess: starting to update pids map");
            synchronized (this.mPidsSelfLocked) {
                this.mPidsSelfLocked.put(startResult.pid, app);
                if (isActivityProcess) {
                    Message msg = this.mHandler.obtainMessage(PROC_START_TIMEOUT_MSG);
                    msg.obj = app;
                    this.mHandler.sendMessageDelayed(msg, startResult.usingWrapper ? 1200000 : 10000);
                }
            }
            checkTime(startTime, "startProcess: done updating pids map");
        } catch (Throwable e2) {
            app.setPid(MY_PID);
            this.mBatteryStatsService.noteProcessFinish(app.processName, app.info.uid);
            if (app.isolated) {
                this.mBatteryStatsService.removeIsolatedUid(app.uid, app.info.uid);
            }
            Slog.e(TAG, "Failure starting process " + app.processName, e2);
        }
    }

    void updateUsageStats(ActivityRecord component, boolean resumed) {
        BatteryStatsImpl stats = this.mBatteryStatsService.getActiveStatistics();
        if (resumed) {
            if (this.mUsageStatsService != null) {
                this.mUsageStatsService.reportEvent(component.realActivity, component.userId, SHOW_ERROR_MSG);
            }
            synchronized (stats) {
                stats.noteActivityResumedLocked(component.app.uid);
            }
            return;
        }
        if (this.mUsageStatsService != null) {
            this.mUsageStatsService.reportEvent(component.realActivity, component.userId, SHOW_NOT_RESPONDING_MSG);
        }
        synchronized (stats) {
            stats.noteActivityPausedLocked(component.app.uid);
        }
    }

    Intent getHomeIntent() {
        Intent intent = new Intent(this.mTopAction, this.mTopData != null ? Uri.parse(this.mTopData) : null);
        intent.setComponent(this.mTopComponent);
        if (this.mFactoryTest != SHOW_ERROR_MSG) {
            intent.addCategory("android.intent.category.HOME");
        }
        return intent;
    }

    boolean startHomeActivityLocked(int userId, String reason) {
        if (this.mFactoryTest == SHOW_ERROR_MSG && this.mTopAction == null) {
            return VALIDATE_TOKENS;
        }
        Intent intent = getHomeIntent();
        ActivityInfo aInfo = resolveActivityInfo(intent, STOCK_PM_FLAGS, userId);
        if (aInfo == null) {
            return SHOW_ACTIVITY_START_TIME;
        }
        intent.setComponent(new ComponentName(aInfo.applicationInfo.packageName, aInfo.name));
        ActivityInfo aInfo2 = new ActivityInfo(aInfo);
        aInfo2.applicationInfo = getAppInfoForUser(aInfo2.applicationInfo, userId);
        ProcessRecord app = getProcessRecordLocked(aInfo2.processName, aInfo2.applicationInfo.uid, SHOW_ACTIVITY_START_TIME);
        if (app == null || app.instrumentationClass == null) {
            intent.setFlags(intent.getFlags() | 268435456);
            this.mStackSupervisor.startHomeActivity(intent, aInfo2, reason);
        }
        aInfo = aInfo2;
        return SHOW_ACTIVITY_START_TIME;
    }

    private ActivityInfo resolveActivityInfo(Intent intent, int flags, int userId) {
        ComponentName comp = intent.getComponent();
        if (comp != null) {
            try {
                return AppGlobals.getPackageManager().getActivityInfo(comp, flags, userId);
            } catch (RemoteException e) {
                return null;
            }
        }
        ResolveInfo info = AppGlobals.getPackageManager().resolveIntent(intent, intent.resolveTypeIfNeeded(this.mContext.getContentResolver()), flags, userId);
        if (info != null) {
            return info.activityInfo;
        }
        return null;
    }

    void startSetupActivityLocked() {
        if (!this.mCheckedForSetup) {
            ContentResolver resolver = this.mContext.getContentResolver();
            if (this.mFactoryTest != SHOW_ERROR_MSG) {
                if (Global.getInt(resolver, "device_provisioned", MY_PID) != 0) {
                    this.mCheckedForSetup = SHOW_ACTIVITY_START_TIME;
                    Intent intent = new Intent("android.intent.action.UPGRADE_SETUP");
                    List<ResolveInfo> ris = this.mContext.getPackageManager().queryIntentActivities(intent, MAX_PERSISTED_URI_GRANTS);
                    ResolveInfo ri = null;
                    int i = MY_PID;
                    while (ris != null && i < ris.size()) {
                        if ((((ResolveInfo) ris.get(i)).activityInfo.applicationInfo.flags & SHOW_ERROR_MSG) != 0) {
                            ri = (ResolveInfo) ris.get(i);
                            break;
                        }
                        i += SHOW_ERROR_MSG;
                    }
                    if (ri != null) {
                        String vers = ri.activityInfo.metaData != null ? ri.activityInfo.metaData.getString("android.SETUP_VERSION") : null;
                        if (vers == null && ri.activityInfo.applicationInfo.metaData != null) {
                            vers = ri.activityInfo.applicationInfo.metaData.getString("android.SETUP_VERSION");
                        }
                        String lastVers = Secure.getString(resolver, "last_setup_shown");
                        if (vers != null && !vers.equals(lastVers)) {
                            intent.setFlags(268435456);
                            intent.setComponent(new ComponentName(ri.activityInfo.packageName, ri.activityInfo.name));
                            this.mStackSupervisor.startActivityLocked(null, intent, null, ri.activityInfo, null, null, null, null, MY_PID, MY_PID, MY_PID, null, MY_PID, MY_PID, MY_PID, null, VALIDATE_TOKENS, null, null, null);
                        }
                    }
                }
            }
        }
    }

    CompatibilityInfo compatibilityInfoForPackageLocked(ApplicationInfo ai) {
        return this.mCompatModePackages.compatibilityInfoForPackageLocked(ai);
    }

    void enforceNotIsolatedCaller(String caller) {
        if (UserHandle.isIsolated(Binder.getCallingUid())) {
            throw new SecurityException("Isolated process not allowed to call " + caller);
        }
    }

    void enforceShellRestriction(String restriction, int userHandle) {
        if (Binder.getCallingUid() != USER_SWITCH_TIMEOUT) {
            return;
        }
        if (userHandle < 0 || this.mUserManager.hasUserRestriction(restriction, userHandle)) {
            throw new SecurityException("Shell does not have permission to access user " + userHandle);
        }
    }

    public int getFrontActivityScreenCompatMode() {
        int frontActivityScreenCompatModeLocked;
        enforceNotIsolatedCaller("getFrontActivityScreenCompatMode");
        synchronized (this) {
            frontActivityScreenCompatModeLocked = this.mCompatModePackages.getFrontActivityScreenCompatModeLocked();
        }
        return frontActivityScreenCompatModeLocked;
    }

    public void setFrontActivityScreenCompatMode(int mode) {
        enforceCallingPermission("android.permission.SET_SCREEN_COMPATIBILITY", "setFrontActivityScreenCompatMode");
        synchronized (this) {
            this.mCompatModePackages.setFrontActivityScreenCompatModeLocked(mode);
        }
    }

    public int getPackageScreenCompatMode(String packageName) {
        int packageScreenCompatModeLocked;
        enforceNotIsolatedCaller("getPackageScreenCompatMode");
        synchronized (this) {
            packageScreenCompatModeLocked = this.mCompatModePackages.getPackageScreenCompatModeLocked(packageName);
        }
        return packageScreenCompatModeLocked;
    }

    public void setPackageScreenCompatMode(String packageName, int mode) {
        enforceCallingPermission("android.permission.SET_SCREEN_COMPATIBILITY", "setPackageScreenCompatMode");
        synchronized (this) {
            this.mCompatModePackages.setPackageScreenCompatModeLocked(packageName, mode);
        }
    }

    public boolean getPackageAskScreenCompat(String packageName) {
        boolean packageAskCompatModeLocked;
        enforceNotIsolatedCaller("getPackageAskScreenCompat");
        synchronized (this) {
            packageAskCompatModeLocked = this.mCompatModePackages.getPackageAskCompatModeLocked(packageName);
        }
        return packageAskCompatModeLocked;
    }

    public void setPackageAskScreenCompat(String packageName, boolean ask) {
        enforceCallingPermission("android.permission.SET_SCREEN_COMPATIBILITY", "setPackageAskScreenCompat");
        synchronized (this) {
            this.mCompatModePackages.setPackageAskCompatModeLocked(packageName, ask);
        }
    }

    private void dispatchProcessesChanged() {
        synchronized (this) {
            int N = this.mPendingProcessChanges.size();
            if (this.mActiveProcessChanges.length < N) {
                this.mActiveProcessChanges = new ProcessChangeItem[N];
            }
            this.mPendingProcessChanges.toArray(this.mActiveProcessChanges);
            this.mAvailProcessChanges.addAll(this.mPendingProcessChanges);
            this.mPendingProcessChanges.clear();
        }
        int i = this.mProcessObservers.beginBroadcast();
        while (i > 0) {
            i--;
            IProcessObserver observer = (IProcessObserver) this.mProcessObservers.getBroadcastItem(i);
            if (observer != null) {
                int j = MY_PID;
                while (j < N) {
                    try {
                        ProcessChangeItem item = this.mActiveProcessChanges[j];
                        if ((item.changes & SHOW_ERROR_MSG) != 0) {
                            observer.onForegroundActivitiesChanged(item.pid, item.uid, item.foregroundActivities);
                        }
                        if ((item.changes & SHOW_NOT_RESPONDING_MSG) != 0) {
                            observer.onProcessStateChanged(item.pid, item.uid, item.processState);
                        }
                        j += SHOW_ERROR_MSG;
                    } catch (RemoteException e) {
                    }
                }
            }
        }
        this.mProcessObservers.finishBroadcast();
    }

    private void dispatchProcessDied(int pid, int uid) {
        int i = this.mProcessObservers.beginBroadcast();
        while (i > 0) {
            i--;
            IProcessObserver observer = (IProcessObserver) this.mProcessObservers.getBroadcastItem(i);
            if (observer != null) {
                try {
                    observer.onProcessDied(pid, uid);
                } catch (RemoteException e) {
                }
            }
        }
        this.mProcessObservers.finishBroadcast();
    }

    public final int startActivity(IApplicationThread caller, String callingPackage, Intent intent, String resolvedType, IBinder resultTo, String resultWho, int requestCode, int startFlags, ProfilerInfo profilerInfo, Bundle options) {
        return startActivityAsUser(caller, callingPackage, intent, resolvedType, resultTo, resultWho, requestCode, startFlags, profilerInfo, options, UserHandle.getCallingUserId());
    }

    public final int startActivityAsUser(IApplicationThread caller, String callingPackage, Intent intent, String resolvedType, IBinder resultTo, String resultWho, int requestCode, int startFlags, ProfilerInfo profilerInfo, Bundle options, int userId) {
        enforceNotIsolatedCaller("startActivity");
        return this.mStackSupervisor.startActivityMayWait(caller, -1, callingPackage, intent, resolvedType, null, null, resultTo, resultWho, requestCode, startFlags, profilerInfo, null, null, options, handleIncomingUser(Binder.getCallingPid(), Binder.getCallingUid(), userId, (boolean) VALIDATE_TOKENS, (int) SHOW_NOT_RESPONDING_MSG, "startActivity", null), null, null);
    }

    public final int startActivityAsCaller(IApplicationThread caller, String callingPackage, Intent intent, String resolvedType, IBinder resultTo, String resultWho, int requestCode, int startFlags, ProfilerInfo profilerInfo, Bundle options, int userId) {
        synchronized (this) {
            if (resultTo == null) {
                throw new SecurityException("Must be called from an activity");
            }
            ActivityRecord sourceRecord = this.mStackSupervisor.isInAnyStackLocked(resultTo);
            if (sourceRecord == null) {
                throw new SecurityException("Called with bad activity token: " + resultTo);
            } else if (!sourceRecord.info.packageName.equals("android")) {
                throw new SecurityException("Must be called from an activity that is declared in the android package");
            } else if (sourceRecord.app == null) {
                throw new SecurityException("Called without a process attached to activity");
            } else if (UserHandle.getAppId(sourceRecord.app.uid) == NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY || sourceRecord.app.uid == sourceRecord.launchedFromUid) {
                int targetUid = sourceRecord.launchedFromUid;
                String targetPackage = sourceRecord.launchedFromPackage;
            } else {
                throw new SecurityException("Calling activity in uid " + sourceRecord.app.uid + " must be system uid or original calling uid " + sourceRecord.launchedFromUid);
            }
        }
        if (userId == -10000) {
            userId = UserHandle.getUserId(sourceRecord.app.uid);
        }
        try {
            return this.mStackSupervisor.startActivityMayWait(null, targetUid, targetPackage, intent, resolvedType, null, null, resultTo, resultWho, requestCode, startFlags, null, null, null, options, userId, null, null);
        } catch (SecurityException e) {
            throw e;
        }
    }

    public final WaitResult startActivityAndWait(IApplicationThread caller, String callingPackage, Intent intent, String resolvedType, IBinder resultTo, String resultWho, int requestCode, int startFlags, ProfilerInfo profilerInfo, Bundle options, int userId) {
        enforceNotIsolatedCaller("startActivityAndWait");
        userId = handleIncomingUser(Binder.getCallingPid(), Binder.getCallingUid(), userId, (boolean) VALIDATE_TOKENS, (int) SHOW_NOT_RESPONDING_MSG, "startActivityAndWait", null);
        WaitResult res = new WaitResult();
        this.mStackSupervisor.startActivityMayWait(caller, -1, callingPackage, intent, resolvedType, null, null, resultTo, resultWho, requestCode, startFlags, profilerInfo, res, null, options, userId, null, null);
        return res;
    }

    public final int startActivityWithConfig(IApplicationThread caller, String callingPackage, Intent intent, String resolvedType, IBinder resultTo, String resultWho, int requestCode, int startFlags, Configuration config, Bundle options, int userId) {
        enforceNotIsolatedCaller("startActivityWithConfig");
        return this.mStackSupervisor.startActivityMayWait(caller, -1, callingPackage, intent, resolvedType, null, null, resultTo, resultWho, requestCode, startFlags, null, null, config, options, handleIncomingUser(Binder.getCallingPid(), Binder.getCallingUid(), userId, (boolean) VALIDATE_TOKENS, (int) SHOW_NOT_RESPONDING_MSG, "startActivityWithConfig", null), null, null);
    }

    public int startActivityIntentSender(IApplicationThread caller, IntentSender intent, Intent fillInIntent, String resolvedType, IBinder resultTo, String resultWho, int requestCode, int flagsMask, int flagsValues, Bundle options) {
        enforceNotIsolatedCaller("startActivityIntentSender");
        if (fillInIntent == null || !fillInIntent.hasFileDescriptors()) {
            IIntentSender sender = intent.getTarget();
            if (sender instanceof PendingIntentRecord) {
                PendingIntentRecord pir = (PendingIntentRecord) sender;
                synchronized (this) {
                    ActivityStack stack = getFocusedStack();
                    if (stack.mResumedActivity != null && stack.mResumedActivity.info.applicationInfo.uid == Binder.getCallingUid()) {
                        this.mAppSwitchesAllowedTime = 0;
                    }
                }
                return pir.sendInner(MY_PID, fillInIntent, resolvedType, null, null, resultTo, resultWho, requestCode, flagsMask, flagsValues, options, null);
            }
            throw new IllegalArgumentException("Bad PendingIntent object");
        }
        throw new IllegalArgumentException("File descriptors passed in Intent");
    }

    public int startVoiceActivity(String callingPackage, int callingPid, int callingUid, Intent intent, String resolvedType, IVoiceInteractionSession session, IVoiceInteractor interactor, int startFlags, ProfilerInfo profilerInfo, Bundle options, int userId) {
        if (checkCallingPermission("android.permission.BIND_VOICE_INTERACTION") != 0) {
            String msg = "Permission Denial: startVoiceActivity() from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " requires " + "android.permission.BIND_VOICE_INTERACTION";
            Slog.w(TAG, msg);
            throw new SecurityException(msg);
        } else if (session == null || interactor == null) {
            throw new NullPointerException("null session or interactor");
        } else {
            return this.mStackSupervisor.startActivityMayWait(null, callingUid, callingPackage, intent, resolvedType, session, interactor, null, null, MY_PID, startFlags, profilerInfo, null, null, options, handleIncomingUser(callingPid, callingUid, userId, (boolean) VALIDATE_TOKENS, (int) SHOW_NOT_RESPONDING_MSG, "startVoiceActivity", null), null, null);
        }
    }

    public boolean startNextMatchingActivity(IBinder callingActivity, Intent intent, Bundle options) {
        Throwable th;
        if (intent == null || intent.hasFileDescriptors() != SHOW_ACTIVITY_START_TIME) {
            synchronized (this) {
                try {
                    boolean z;
                    ActivityRecord r = ActivityRecord.isInStackLocked(callingActivity);
                    if (r == null) {
                        ActivityOptions.abort(options);
                        z = VALIDATE_TOKENS;
                    } else if (r.app == null || r.app.thread == null) {
                        ActivityOptions.abort(options);
                        z = VALIDATE_TOKENS;
                    } else {
                        Intent intent2 = new Intent(intent);
                        try {
                            boolean wasFinishing;
                            ActivityRecord resultTo;
                            String resultWho;
                            int requestCode;
                            long origId;
                            int res;
                            intent2.setDataAndType(r.intent.getData(), r.intent.getType());
                            intent2.setComponent(null);
                            boolean debug = (intent2.getFlags() & 8) != 0 ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
                            ActivityInfo aInfo = null;
                            try {
                                List<ResolveInfo> resolves = AppGlobals.getPackageManager().queryIntentActivities(intent2, r.resolvedType, 66560, UserHandle.getCallingUserId());
                                int N = resolves != null ? resolves.size() : MY_PID;
                                int i = MY_PID;
                                while (i < N) {
                                    ResolveInfo rInfo = (ResolveInfo) resolves.get(i);
                                    if (rInfo.activityInfo.packageName.equals(r.packageName) && rInfo.activityInfo.name.equals(r.info.name)) {
                                        i += SHOW_ERROR_MSG;
                                        if (i < N) {
                                            aInfo = ((ResolveInfo) resolves.get(i)).activityInfo;
                                        }
                                        if (debug) {
                                            Slog.v(TAG, "Next matching activity: found current " + r.packageName + "/" + r.info.name);
                                            Slog.v(TAG, "Next matching activity: next is " + aInfo.packageName + "/" + aInfo.name);
                                        }
                                        if (aInfo != null) {
                                            ActivityOptions.abort(options);
                                            if (debug) {
                                                Slog.d(TAG, "Next matching activity: nothing found");
                                            }
                                            z = VALIDATE_TOKENS;
                                            intent = intent2;
                                        } else {
                                            intent2.setComponent(new ComponentName(aInfo.applicationInfo.packageName, aInfo.name));
                                            intent2.setFlags(intent2.getFlags() & -503316481);
                                            wasFinishing = r.finishing;
                                            r.finishing = SHOW_ACTIVITY_START_TIME;
                                            resultTo = r.resultTo;
                                            resultWho = r.resultWho;
                                            requestCode = r.requestCode;
                                            r.resultTo = null;
                                            if (resultTo != null) {
                                                resultTo.removeResultsLocked(r, resultWho, requestCode);
                                            }
                                            origId = Binder.clearCallingIdentity();
                                            res = this.mStackSupervisor.startActivityLocked(r.app.thread, intent2, r.resolvedType, aInfo, null, null, resultTo == null ? resultTo.appToken : null, resultWho, requestCode, -1, r.launchedFromUid, r.launchedFromPackage, -1, r.launchedFromUid, MY_PID, options, VALIDATE_TOKENS, null, null, null);
                                            Binder.restoreCallingIdentity(origId);
                                            r.finishing = wasFinishing;
                                            if (res == 0) {
                                                z = VALIDATE_TOKENS;
                                                intent = intent2;
                                            } else {
                                                z = SHOW_ACTIVITY_START_TIME;
                                                intent = intent2;
                                            }
                                        }
                                    } else {
                                        i += SHOW_ERROR_MSG;
                                    }
                                }
                            } catch (RemoteException e) {
                            }
                            if (aInfo != null) {
                                intent2.setComponent(new ComponentName(aInfo.applicationInfo.packageName, aInfo.name));
                                intent2.setFlags(intent2.getFlags() & -503316481);
                                wasFinishing = r.finishing;
                                r.finishing = SHOW_ACTIVITY_START_TIME;
                                resultTo = r.resultTo;
                                resultWho = r.resultWho;
                                requestCode = r.requestCode;
                                r.resultTo = null;
                                if (resultTo != null) {
                                    resultTo.removeResultsLocked(r, resultWho, requestCode);
                                }
                                origId = Binder.clearCallingIdentity();
                                if (resultTo == null) {
                                }
                                res = this.mStackSupervisor.startActivityLocked(r.app.thread, intent2, r.resolvedType, aInfo, null, null, resultTo == null ? resultTo.appToken : null, resultWho, requestCode, -1, r.launchedFromUid, r.launchedFromPackage, -1, r.launchedFromUid, MY_PID, options, VALIDATE_TOKENS, null, null, null);
                                Binder.restoreCallingIdentity(origId);
                                r.finishing = wasFinishing;
                                if (res == 0) {
                                    z = SHOW_ACTIVITY_START_TIME;
                                    intent = intent2;
                                } else {
                                    z = VALIDATE_TOKENS;
                                    intent = intent2;
                                }
                            } else {
                                ActivityOptions.abort(options);
                                if (debug) {
                                    Slog.d(TAG, "Next matching activity: nothing found");
                                }
                                z = VALIDATE_TOKENS;
                                intent = intent2;
                            }
                        } catch (Throwable th2) {
                            th = th2;
                            intent = intent2;
                            throw th;
                        }
                    }
                    return z;
                } catch (Throwable th3) {
                    th = th3;
                    throw th;
                }
            }
        }
        throw new IllegalArgumentException("File descriptors passed in Intent");
    }

    public final int startActivityFromRecents(int taskId, Bundle options) {
        if (checkCallingPermission("android.permission.START_TASKS_FROM_RECENTS") == 0) {
            return startActivityFromRecentsInner(taskId, options);
        }
        String msg = "Permission Denial: startActivityFromRecents called without android.permission.START_TASKS_FROM_RECENTS";
        Slog.w(TAG, msg);
        throw new SecurityException(msg);
    }

    final int startActivityFromRecentsInner(int taskId, Bundle options) {
        synchronized (this) {
            TaskRecord task = recentTaskForIdLocked(taskId);
            if (task == null) {
                throw new IllegalArgumentException("Task " + taskId + " not found.");
            } else if (task.getRootActivity() != null) {
                moveTaskToFrontLocked(task.taskId, MY_PID, null);
                return SHOW_NOT_RESPONDING_MSG;
            } else {
                int callingUid = task.mCallingUid;
                String callingPackage = task.mCallingPackage;
                Intent intent = task.intent;
                intent.addFlags(1048576);
                int userId = task.userId;
                return startActivityInPackage(callingUid, callingPackage, intent, null, null, null, MY_PID, MY_PID, options, userId, null, task);
            }
        }
    }

    final int startActivityInPackage(int uid, String callingPackage, Intent intent, String resolvedType, IBinder resultTo, String resultWho, int requestCode, int startFlags, Bundle options, int userId, IActivityContainer container, TaskRecord inTask) {
        return this.mStackSupervisor.startActivityMayWait(null, uid, callingPackage, intent, resolvedType, null, null, resultTo, resultWho, requestCode, startFlags, null, null, null, options, handleIncomingUser(Binder.getCallingPid(), Binder.getCallingUid(), userId, (boolean) VALIDATE_TOKENS, (int) SHOW_NOT_RESPONDING_MSG, "startActivityInPackage", null), container, inTask);
    }

    public final int startActivities(IApplicationThread caller, String callingPackage, Intent[] intents, String[] resolvedTypes, IBinder resultTo, Bundle options, int userId) {
        enforceNotIsolatedCaller("startActivities");
        return this.mStackSupervisor.startActivities(caller, -1, callingPackage, intents, resolvedTypes, resultTo, options, handleIncomingUser(Binder.getCallingPid(), Binder.getCallingUid(), userId, (boolean) VALIDATE_TOKENS, (int) SHOW_NOT_RESPONDING_MSG, "startActivity", null));
    }

    final int startActivitiesInPackage(int uid, String callingPackage, Intent[] intents, String[] resolvedTypes, IBinder resultTo, Bundle options, int userId) {
        return this.mStackSupervisor.startActivities(null, uid, callingPackage, intents, resolvedTypes, resultTo, options, handleIncomingUser(Binder.getCallingPid(), Binder.getCallingUid(), userId, (boolean) VALIDATE_TOKENS, (int) SHOW_NOT_RESPONDING_MSG, "startActivityInPackage", null));
    }

    private void removeRecentTasksForUserLocked(int userId) {
        if (userId <= 0) {
            Slog.i(TAG, "Can't remove recent task on user " + userId);
            return;
        }
        for (int i = this.mRecentTasks.size() - 1; i >= 0; i--) {
            TaskRecord tr = (TaskRecord) this.mRecentTasks.get(i);
            if (tr.userId == userId) {
                this.mRecentTasks.remove(i);
                tr.removedFromRecents();
            }
        }
        notifyTaskPersisterLocked(null, SHOW_ACTIVITY_START_TIME);
    }

    private int processNextAffiliateChainLocked(int start) {
        TaskRecord startTask = (TaskRecord) this.mRecentTasks.get(start);
        int affiliateId = startTask.mAffiliatedTaskId;
        if (startTask.taskId == affiliateId && startTask.mPrevAffiliate == null && startTask.mNextAffiliate == null) {
            startTask.inRecents = SHOW_ACTIVITY_START_TIME;
            return start + SHOW_ERROR_MSG;
        }
        int i;
        this.mTmpRecents.clear();
        for (i = this.mRecentTasks.size() - 1; i >= start; i--) {
            TaskRecord task = (TaskRecord) this.mRecentTasks.get(i);
            if (task.mAffiliatedTaskId == affiliateId) {
                this.mRecentTasks.remove(i);
                this.mTmpRecents.add(task);
            }
        }
        Collections.sort(this.mTmpRecents, this.mTaskRecordComparator);
        TaskRecord first = (TaskRecord) this.mTmpRecents.get(MY_PID);
        first.inRecents = SHOW_ACTIVITY_START_TIME;
        if (first.mNextAffiliate != null) {
            Slog.w(TAG, "Link error 1 first.next=" + first.mNextAffiliate);
            first.setNextAffiliate(null);
            notifyTaskPersisterLocked(first, VALIDATE_TOKENS);
        }
        int tmpSize = this.mTmpRecents.size();
        for (i = MY_PID; i < tmpSize - 1; i += SHOW_ERROR_MSG) {
            TaskRecord next = (TaskRecord) this.mTmpRecents.get(i);
            TaskRecord prev = (TaskRecord) this.mTmpRecents.get(i + SHOW_ERROR_MSG);
            if (next.mPrevAffiliate != prev) {
                Slog.w(TAG, "Link error 2 next=" + next + " prev=" + next.mPrevAffiliate + " setting prev=" + prev);
                next.setPrevAffiliate(prev);
                notifyTaskPersisterLocked(next, VALIDATE_TOKENS);
            }
            if (prev.mNextAffiliate != next) {
                Slog.w(TAG, "Link error 3 prev=" + prev + " next=" + prev.mNextAffiliate + " setting next=" + next);
                prev.setNextAffiliate(next);
                notifyTaskPersisterLocked(prev, VALIDATE_TOKENS);
            }
            prev.inRecents = SHOW_ACTIVITY_START_TIME;
        }
        TaskRecord last = (TaskRecord) this.mTmpRecents.get(tmpSize - 1);
        if (last.mPrevAffiliate != null) {
            Slog.w(TAG, "Link error 4 last.prev=" + last.mPrevAffiliate);
            last.setPrevAffiliate(null);
            notifyTaskPersisterLocked(last, VALIDATE_TOKENS);
        }
        this.mRecentTasks.addAll(start, this.mTmpRecents);
        return start + tmpSize;
    }

    void cleanupRecentTasksLocked(int userId) {
        if (this.mRecentTasks != null) {
            int[] users;
            int i;
            HashMap<ComponentName, ActivityInfo> availActCache = new HashMap();
            HashMap<String, ApplicationInfo> availAppCache = new HashMap();
            IPackageManager pm = AppGlobals.getPackageManager();
            ActivityInfo dummyAct = new ActivityInfo();
            ApplicationInfo dummyApp = new ApplicationInfo();
            int N = this.mRecentTasks.size();
            if (userId == -1) {
                users = getUsersLocked();
            } else {
                users = new int[SHOW_ERROR_MSG];
                users[MY_PID] = userId;
            }
            int[] arr$ = users;
            int len$ = arr$.length;
            for (int i$ = MY_PID; i$ < len$; i$ += SHOW_ERROR_MSG) {
                int user = arr$[i$];
                i = MY_PID;
                while (i < N) {
                    TaskRecord task = (TaskRecord) this.mRecentTasks.get(i);
                    int i2 = task.userId;
                    if (r0 == user) {
                        if (task.autoRemoveRecents && task.getTopActivity() == null) {
                            this.mRecentTasks.remove(i);
                            task.removedFromRecents();
                            i--;
                            N--;
                            Slog.w(TAG, "Removing auto-remove without activity: " + task);
                        } else if (task.realActivity != null) {
                            ActivityInfo ai = (ActivityInfo) availActCache.get(task.realActivity);
                            if (ai == null) {
                                try {
                                    ai = pm.getActivityInfo(task.realActivity, 8704, user);
                                    if (ai == null) {
                                        ai = dummyAct;
                                    }
                                    availActCache.put(task.realActivity, ai);
                                } catch (RemoteException e) {
                                }
                            }
                            if (ai == dummyAct) {
                                ApplicationInfo app = (ApplicationInfo) availAppCache.get(task.realActivity.getPackageName());
                                if (app == null) {
                                    try {
                                        app = pm.getApplicationInfo(task.realActivity.getPackageName(), 8704, user);
                                        if (app == null) {
                                            app = dummyApp;
                                        }
                                        availAppCache.put(task.realActivity.getPackageName(), app);
                                    } catch (RemoteException e2) {
                                    }
                                }
                                if (app != dummyApp) {
                                    if ((app.flags & 8388608) != 0) {
                                        if (task.isAvailable) {
                                            task.isAvailable = VALIDATE_TOKENS;
                                        } else {
                                            task.isAvailable = VALIDATE_TOKENS;
                                        }
                                    }
                                }
                                this.mRecentTasks.remove(i);
                                task.removedFromRecents();
                                i--;
                                N--;
                                Slog.w(TAG, "Removing no longer valid recent: " + task);
                            } else {
                                if (ai.enabled) {
                                    if (ai.applicationInfo.enabled) {
                                        if ((ai.applicationInfo.flags & 8388608) != 0) {
                                            if (task.isAvailable) {
                                                task.isAvailable = SHOW_ACTIVITY_START_TIME;
                                            } else {
                                                task.isAvailable = SHOW_ACTIVITY_START_TIME;
                                            }
                                        }
                                    }
                                }
                                if (task.isAvailable) {
                                    task.isAvailable = VALIDATE_TOKENS;
                                } else {
                                    task.isAvailable = VALIDATE_TOKENS;
                                }
                            }
                        }
                    }
                    i += SHOW_ERROR_MSG;
                }
            }
            i = MY_PID;
            while (i < N) {
                i = processNextAffiliateChainLocked(i);
            }
            this.mTmpRecents.clear();
        }
    }

    private final boolean moveAffiliatedTasksToFront(TaskRecord task, int taskIndex) {
        boolean sane;
        int N = this.mRecentTasks.size();
        TaskRecord top = task;
        int topIndex = taskIndex;
        while (top.mNextAffiliate != null && topIndex > 0) {
            top = top.mNextAffiliate;
            topIndex--;
        }
        if (top.mAffiliatedTaskId == task.mAffiliatedTaskId) {
            sane = SHOW_ACTIVITY_START_TIME;
        } else {
            sane = VALIDATE_TOKENS;
        }
        int endIndex = topIndex;
        TaskRecord prev = top;
        while (endIndex < N) {
            TaskRecord cur = (TaskRecord) this.mRecentTasks.get(endIndex);
            if (cur != top) {
                if (!(cur.mNextAffiliate == prev && cur.mNextAffiliateTaskId == prev.taskId)) {
                    Slog.wtf(TAG, "Bad chain @" + endIndex + ": middle task " + cur + " @" + endIndex + " has bad next affiliate " + cur.mNextAffiliate + " id " + cur.mNextAffiliateTaskId + ", expected " + prev);
                    sane = VALIDATE_TOKENS;
                    break;
                }
            } else if (!(cur.mNextAffiliate == null && cur.mNextAffiliateTaskId == -1)) {
                Slog.wtf(TAG, "Bad chain @" + endIndex + ": first task has next affiliate: " + prev);
                sane = VALIDATE_TOKENS;
                break;
            }
            if (cur.mPrevAffiliateTaskId != -1) {
                if (cur.mPrevAffiliate != null) {
                    if (cur.mAffiliatedTaskId == task.mAffiliatedTaskId) {
                        prev = cur;
                        endIndex += SHOW_ERROR_MSG;
                        if (endIndex >= N) {
                            Slog.wtf(TAG, "Bad chain ran off index " + endIndex + ": last task " + prev);
                            sane = VALIDATE_TOKENS;
                            break;
                        }
                    }
                    Slog.wtf(TAG, "Bad chain @" + endIndex + ": task " + cur + " has affiliated id " + cur.mAffiliatedTaskId + " but should be " + task.mAffiliatedTaskId);
                    sane = VALIDATE_TOKENS;
                    break;
                }
                Slog.wtf(TAG, "Bad chain @" + endIndex + ": task " + cur + " has previous affiliate " + cur.mPrevAffiliate + " but should be id " + cur.mPrevAffiliate);
                sane = VALIDATE_TOKENS;
                break;
            } else if (cur.mPrevAffiliate != null) {
                Slog.wtf(TAG, "Bad chain @" + endIndex + ": last task " + cur + " has previous affiliate " + cur.mPrevAffiliate);
                sane = VALIDATE_TOKENS;
            }
        }
        if (sane && endIndex < taskIndex) {
            Slog.wtf(TAG, "Bad chain @" + endIndex + ": did not extend to task " + task + " @" + taskIndex);
            sane = VALIDATE_TOKENS;
        }
        if (!sane) {
            return VALIDATE_TOKENS;
        }
        for (int i = topIndex; i <= endIndex; i += SHOW_ERROR_MSG) {
            this.mRecentTasks.add(i - topIndex, (TaskRecord) this.mRecentTasks.remove(i));
        }
        return SHOW_ACTIVITY_START_TIME;
    }

    final void addRecentTaskLocked(TaskRecord task) {
        boolean isAffiliated;
        if (task.mAffiliatedTaskId == task.taskId && task.mNextAffiliateTaskId == -1 && task.mPrevAffiliateTaskId == -1) {
            isAffiliated = VALIDATE_TOKENS;
        } else {
            isAffiliated = SHOW_ACTIVITY_START_TIME;
        }
        int N = this.mRecentTasks.size();
        if (!isAffiliated && N > 0 && this.mRecentTasks.get(MY_PID) == task) {
            return;
        }
        if (!(isAffiliated && N > 0 && task.inRecents && task.mAffiliatedTaskId == ((TaskRecord) this.mRecentTasks.get(MY_PID)).mAffiliatedTaskId) && task.voiceSession == null) {
            int taskIndex;
            boolean needAffiliationFix = VALIDATE_TOKENS;
            if (task.inRecents) {
                taskIndex = this.mRecentTasks.indexOf(task);
                if (taskIndex >= 0) {
                    trimRecentBitmaps();
                    if (!isAffiliated) {
                        this.mRecentTasks.remove(taskIndex);
                        this.mRecentTasks.add(MY_PID, task);
                        notifyTaskPersisterLocked(task, VALIDATE_TOKENS);
                        return;
                    } else if (!moveAffiliatedTasksToFront(task, taskIndex)) {
                        needAffiliationFix = SHOW_ACTIVITY_START_TIME;
                    } else {
                        return;
                    }
                }
                Slog.wtf(TAG, "Task with inRecent not in recents: " + task);
                needAffiliationFix = SHOW_ACTIVITY_START_TIME;
            }
            trimRecentsForTaskLocked(task, SHOW_ACTIVITY_START_TIME);
            for (N = this.mRecentTasks.size(); N >= ActivityManager.getMaxRecentTasksStatic(); N--) {
                ((TaskRecord) this.mRecentTasks.remove(N - 1)).removedFromRecents();
            }
            task.inRecents = SHOW_ACTIVITY_START_TIME;
            if (!isAffiliated || needAffiliationFix) {
                this.mRecentTasks.add(MY_PID, task);
            } else if (isAffiliated) {
                TaskRecord other = task.mNextAffiliate;
                if (other == null) {
                    other = task.mPrevAffiliate;
                }
                if (other != null) {
                    int otherIndex = this.mRecentTasks.indexOf(other);
                    if (otherIndex >= 0) {
                        if (other == task.mNextAffiliate) {
                            taskIndex = otherIndex + SHOW_ERROR_MSG;
                        } else {
                            taskIndex = otherIndex;
                        }
                        this.mRecentTasks.add(taskIndex, task);
                        if (!moveAffiliatedTasksToFront(task, taskIndex)) {
                            needAffiliationFix = SHOW_ACTIVITY_START_TIME;
                        } else {
                            return;
                        }
                    }
                    needAffiliationFix = SHOW_ACTIVITY_START_TIME;
                } else {
                    needAffiliationFix = SHOW_ACTIVITY_START_TIME;
                }
            }
            if (needAffiliationFix) {
                cleanupRecentTasksLocked(task.userId);
            }
        }
    }

    void trimRecentBitmaps() {
        int N = this.mRecentTasks.size();
        for (int i = MY_PID; i < N; i += SHOW_ERROR_MSG) {
            TaskRecord tr = (TaskRecord) this.mRecentTasks.get(i);
            if (i > SHOW_FACTORY_ERROR_MSG) {
                tr.freeLastThumbnail();
            }
        }
    }

    int trimRecentsForTaskLocked(TaskRecord task, boolean doTrim) {
        boolean document;
        int N = this.mRecentTasks.size();
        Intent intent = task.intent;
        if (intent == null || !intent.isDocument()) {
            document = VALIDATE_TOKENS;
        } else {
            document = SHOW_ACTIVITY_START_TIME;
        }
        int maxRecents = task.maxRecents - 1;
        int i = MY_PID;
        while (i < N) {
            TaskRecord tr = (TaskRecord) this.mRecentTasks.get(i);
            if (task != tr) {
                if (task.userId == tr.userId) {
                    if (i > SHOW_FACTORY_ERROR_MSG) {
                        tr.freeLastThumbnail();
                    }
                    Intent trIntent = tr.intent;
                    if ((task.affinity != null && task.affinity.equals(tr.affinity)) || (intent != null && intent.filterEquals(trIntent))) {
                        boolean trIsDocument;
                        if (trIntent == null || !trIntent.isDocument()) {
                            trIsDocument = VALIDATE_TOKENS;
                        } else {
                            trIsDocument = SHOW_ACTIVITY_START_TIME;
                        }
                        if (document && trIsDocument) {
                            if (maxRecents > 0) {
                                maxRecents--;
                            }
                        } else if (document) {
                            continue;
                        } else if (trIsDocument) {
                            continue;
                        }
                    }
                } else {
                    continue;
                }
                i += SHOW_ERROR_MSG;
            }
            if (!doTrim) {
                return i;
            }
            tr.disposeThumbnail();
            this.mRecentTasks.remove(i);
            if (task != tr) {
                tr.removedFromRecents();
            }
            i--;
            N--;
            if (task.intent == null) {
                task = tr;
            }
            notifyTaskPersisterLocked(tr, VALIDATE_TOKENS);
            i += SHOW_ERROR_MSG;
        }
        return -1;
    }

    public void reportActivityFullyDrawn(IBinder token) {
        synchronized (this) {
            ActivityRecord r = ActivityRecord.isInStackLocked(token);
            if (r == null) {
                return;
            }
            r.reportFullyDrawnLocked();
        }
    }

    public void setRequestedOrientation(IBinder token, int requestedOrientation) {
        synchronized (this) {
            ActivityRecord r = ActivityRecord.isInStackLocked(token);
            if (r == null) {
                return;
            }
            long origId = Binder.clearCallingIdentity();
            this.mWindowManager.setAppOrientation(r.appToken, requestedOrientation);
            Configuration config = this.mWindowManager.updateOrientationFromAppTokens(this.mConfiguration, r.mayFreezeScreenLocked(r.app) ? r.appToken : null);
            if (config != null) {
                r.frozenBeforeDestroy = SHOW_ACTIVITY_START_TIME;
                if (!updateConfigurationLocked(config, r, VALIDATE_TOKENS, VALIDATE_TOKENS)) {
                    this.mStackSupervisor.resumeTopActivitiesLocked();
                }
            }
            Binder.restoreCallingIdentity(origId);
        }
    }

    public int getRequestedOrientation(IBinder token) {
        int i;
        synchronized (this) {
            ActivityRecord r = ActivityRecord.isInStackLocked(token);
            if (r == null) {
                i = -1;
            } else {
                i = this.mWindowManager.getAppOrientation(r.appToken);
            }
        }
        return i;
    }

    public final boolean finishActivity(IBinder token, int resultCode, Intent resultData, boolean finishTask) {
        if (resultData == null || resultData.hasFileDescriptors() != SHOW_ACTIVITY_START_TIME) {
            boolean z;
            synchronized (this) {
                ActivityRecord r = ActivityRecord.isInStackLocked(token);
                if (r == null) {
                    z = SHOW_ACTIVITY_START_TIME;
                } else {
                    TaskRecord tr = r.task;
                    ActivityRecord rootR = tr.getRootActivity();
                    if (rootR == null) {
                        Slog.w(TAG, "Finishing task with all activities already finished");
                    }
                    if (tr == this.mStackSupervisor.mLockTaskModeTask && rootR == r) {
                        Slog.i(TAG, "Not finishing task in lock task mode");
                        this.mStackSupervisor.showLockTaskToast();
                        z = VALIDATE_TOKENS;
                    } else {
                        if (this.mController != null) {
                            ActivityRecord next = r.task.stack.topRunningActivityLocked(token, MY_PID);
                            if (next != null) {
                                boolean resumeOK = SHOW_ACTIVITY_START_TIME;
                                try {
                                    resumeOK = this.mController.activityResuming(next.packageName);
                                } catch (RemoteException e) {
                                    this.mController = null;
                                    Watchdog.getInstance().setActivityController(null);
                                } catch (Throwable th) {
                                    Binder.restoreCallingIdentity(origId);
                                }
                                if (!resumeOK) {
                                    Slog.i(TAG, "Not finishing activity because controller resumed");
                                    z = VALIDATE_TOKENS;
                                }
                            }
                        }
                        long origId = Binder.clearCallingIdentity();
                        if (finishTask && r == rootR) {
                            z = removeTaskByIdLocked(tr.taskId, VALIDATE_TOKENS);
                            if (!z) {
                                Slog.i(TAG, "Removing task failed to finish activity");
                            }
                        } else {
                            z = tr.stack.requestFinishActivityLocked(token, resultCode, resultData, "app-request", SHOW_ACTIVITY_START_TIME);
                            if (!z) {
                                Slog.i(TAG, "Failed to finish by app-request");
                            }
                        }
                        Binder.restoreCallingIdentity(origId);
                    }
                }
            }
            return z;
        }
        throw new IllegalArgumentException("File descriptors passed in Intent");
    }

    public final void finishHeavyWeightApp() {
        if (checkCallingPermission("android.permission.FORCE_STOP_PACKAGES") != 0) {
            String msg = "Permission Denial: finishHeavyWeightApp() from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " requires " + "android.permission.FORCE_STOP_PACKAGES";
            Slog.w(TAG, msg);
            throw new SecurityException(msg);
        }
        synchronized (this) {
            if (this.mHeavyWeightProcess == null) {
                return;
            }
            ArrayList<ActivityRecord> activities = new ArrayList(this.mHeavyWeightProcess.activities);
            for (int i = MY_PID; i < activities.size(); i += SHOW_ERROR_MSG) {
                ActivityRecord r = (ActivityRecord) activities.get(i);
                if (!r.finishing) {
                    r.task.stack.finishActivityLocked(r, MY_PID, null, "finish-heavy", SHOW_ACTIVITY_START_TIME);
                }
            }
            this.mHandler.sendMessage(this.mHandler.obtainMessage(CANCEL_HEAVY_NOTIFICATION_MSG, this.mHeavyWeightProcess.userId, MY_PID));
            this.mHeavyWeightProcess = null;
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void crashApplication(int r10, int r11, java.lang.String r12, java.lang.String r13) {
        /*
        r9 = this;
        r6 = "android.permission.FORCE_STOP_PACKAGES";
        r6 = r9.checkCallingPermission(r6);
        if (r6 == 0) goto L_0x0044;
    L_0x0008:
        r6 = new java.lang.StringBuilder;
        r6.<init>();
        r7 = "Permission Denial: crashApplication() from pid=";
        r6 = r6.append(r7);
        r7 = android.os.Binder.getCallingPid();
        r6 = r6.append(r7);
        r7 = ", uid=";
        r6 = r6.append(r7);
        r7 = android.os.Binder.getCallingUid();
        r6 = r6.append(r7);
        r7 = " requires ";
        r6 = r6.append(r7);
        r7 = "android.permission.FORCE_STOP_PACKAGES";
        r6 = r6.append(r7);
        r1 = r6.toString();
        r6 = "ActivityManager";
        android.util.Slog.w(r6, r1);
        r6 = new java.lang.SecurityException;
        r6.<init>(r1);
        throw r6;
    L_0x0044:
        monitor-enter(r9);
        r5 = 0;
        r7 = r9.mPidsSelfLocked;	 Catch:{ all -> 0x00a4 }
        monitor-enter(r7);	 Catch:{ all -> 0x00a4 }
        r0 = 0;
    L_0x004a:
        r6 = r9.mPidsSelfLocked;	 Catch:{ all -> 0x00a1 }
        r6 = r6.size();	 Catch:{ all -> 0x00a1 }
        if (r0 >= r6) goto L_0x0066;
    L_0x0052:
        r6 = r9.mPidsSelfLocked;	 Catch:{ all -> 0x00a1 }
        r4 = r6.valueAt(r0);	 Catch:{ all -> 0x00a1 }
        r4 = (com.android.server.am.ProcessRecord) r4;	 Catch:{ all -> 0x00a1 }
        r6 = r4.uid;	 Catch:{ all -> 0x00a1 }
        if (r6 == r10) goto L_0x0061;
    L_0x005e:
        r0 = r0 + 1;
        goto L_0x004a;
    L_0x0061:
        r6 = r4.pid;	 Catch:{ all -> 0x00a1 }
        if (r6 != r11) goto L_0x0097;
    L_0x0065:
        r5 = r4;
    L_0x0066:
        monitor-exit(r7);	 Catch:{ all -> 0x00a1 }
        if (r5 != 0) goto L_0x00a7;
    L_0x0069:
        r6 = "ActivityManager";
        r7 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00a4 }
        r7.<init>();	 Catch:{ all -> 0x00a4 }
        r8 = "crashApplication: nothing for uid=";
        r7 = r7.append(r8);	 Catch:{ all -> 0x00a4 }
        r7 = r7.append(r10);	 Catch:{ all -> 0x00a4 }
        r8 = " initialPid=";
        r7 = r7.append(r8);	 Catch:{ all -> 0x00a4 }
        r7 = r7.append(r11);	 Catch:{ all -> 0x00a4 }
        r8 = " packageName=";
        r7 = r7.append(r8);	 Catch:{ all -> 0x00a4 }
        r7 = r7.append(r12);	 Catch:{ all -> 0x00a4 }
        r7 = r7.toString();	 Catch:{ all -> 0x00a4 }
        android.util.Slog.w(r6, r7);	 Catch:{ all -> 0x00a4 }
        monitor-exit(r9);	 Catch:{ all -> 0x00a4 }
    L_0x0096:
        return;
    L_0x0097:
        r6 = r4.pkgList;	 Catch:{ all -> 0x00a1 }
        r6 = r6.containsKey(r12);	 Catch:{ all -> 0x00a1 }
        if (r6 == 0) goto L_0x005e;
    L_0x009f:
        r5 = r4;
        goto L_0x005e;
    L_0x00a1:
        r6 = move-exception;
        monitor-exit(r7);	 Catch:{ all -> 0x00a1 }
        throw r6;	 Catch:{ all -> 0x00a4 }
    L_0x00a4:
        r6 = move-exception;
        monitor-exit(r9);	 Catch:{ all -> 0x00a4 }
        throw r6;
    L_0x00a7:
        r6 = r5.thread;	 Catch:{ all -> 0x00a4 }
        if (r6 == 0) goto L_0x00c8;
    L_0x00ab:
        r6 = r5.pid;	 Catch:{ all -> 0x00a4 }
        r7 = android.os.Process.myPid();	 Catch:{ all -> 0x00a4 }
        if (r6 != r7) goto L_0x00bc;
    L_0x00b3:
        r6 = "ActivityManager";
        r7 = "crashApplication: trying to crash self!";
        android.util.Log.w(r6, r7);	 Catch:{ all -> 0x00a4 }
        monitor-exit(r9);	 Catch:{ all -> 0x00a4 }
        goto L_0x0096;
    L_0x00bc:
        r2 = android.os.Binder.clearCallingIdentity();	 Catch:{ all -> 0x00a4 }
        r6 = r5.thread;	 Catch:{ RemoteException -> 0x00ca }
        r6.scheduleCrash(r13);	 Catch:{ RemoteException -> 0x00ca }
    L_0x00c5:
        android.os.Binder.restoreCallingIdentity(r2);	 Catch:{ all -> 0x00a4 }
    L_0x00c8:
        monitor-exit(r9);	 Catch:{ all -> 0x00a4 }
        goto L_0x0096;
    L_0x00ca:
        r6 = move-exception;
        goto L_0x00c5;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.ActivityManagerService.crashApplication(int, int, java.lang.String, java.lang.String):void");
    }

    public final void finishSubActivity(IBinder token, String resultWho, int requestCode) {
        synchronized (this) {
            long origId = Binder.clearCallingIdentity();
            ActivityRecord r = ActivityRecord.isInStackLocked(token);
            if (r != null) {
                r.task.stack.finishSubActivityLocked(r, resultWho, requestCode);
            }
            Binder.restoreCallingIdentity(origId);
        }
    }

    public boolean finishActivityAffinity(IBinder token) {
        boolean z;
        synchronized (this) {
            long origId = Binder.clearCallingIdentity();
            try {
                ActivityRecord r = ActivityRecord.isInStackLocked(token);
                ActivityRecord rootR = r.task.getRootActivity();
                if (r.task == this.mStackSupervisor.mLockTaskModeTask && rootR == r) {
                    this.mStackSupervisor.showLockTaskToast();
                    z = VALIDATE_TOKENS;
                } else {
                    z = VALIDATE_TOKENS;
                    if (r != null) {
                        z = r.task.stack.finishActivityAffinityLocked(r);
                    }
                    Binder.restoreCallingIdentity(origId);
                }
            } finally {
                Binder.restoreCallingIdentity(origId);
            }
        }
        return z;
    }

    public void finishVoiceTask(IVoiceInteractionSession session) {
        synchronized (this) {
            long origId = Binder.clearCallingIdentity();
            try {
                this.mStackSupervisor.finishVoiceTask(session);
                Binder.restoreCallingIdentity(origId);
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(origId);
            }
        }
    }

    public boolean releaseActivityInstance(IBinder token) {
        boolean z;
        synchronized (this) {
            long origId = Binder.clearCallingIdentity();
            try {
                ActivityRecord r = ActivityRecord.isInStackLocked(token);
                if (r.task == null || r.task.stack == null) {
                    z = VALIDATE_TOKENS;
                } else {
                    z = r.task.stack.safelyDestroyActivityLocked(r, "app-req");
                    Binder.restoreCallingIdentity(origId);
                }
            } finally {
                Binder.restoreCallingIdentity(origId);
            }
        }
        return z;
    }

    public void releaseSomeActivities(IApplicationThread appInt) {
        synchronized (this) {
            long origId = Binder.clearCallingIdentity();
            try {
                this.mStackSupervisor.releaseSomeActivitiesLocked(getRecordForAppLocked(appInt), "low-mem");
                Binder.restoreCallingIdentity(origId);
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(origId);
            }
        }
    }

    public boolean willActivityBeVisible(IBinder token) {
        boolean willActivityBeVisibleLocked;
        synchronized (this) {
            ActivityStack stack = ActivityRecord.getStackLocked(token);
            if (stack != null) {
                willActivityBeVisibleLocked = stack.willActivityBeVisibleLocked(token);
            } else {
                willActivityBeVisibleLocked = VALIDATE_TOKENS;
            }
        }
        return willActivityBeVisibleLocked;
    }

    public void overridePendingTransition(IBinder token, String packageName, int enterAnim, int exitAnim) {
        synchronized (this) {
            ActivityRecord self = ActivityRecord.isInStackLocked(token);
            if (self == null) {
                return;
            }
            long origId = Binder.clearCallingIdentity();
            if (self.state == ActivityState.RESUMED || self.state == ActivityState.PAUSING) {
                this.mWindowManager.overridePendingAppTransition(packageName, enterAnim, exitAnim, null);
            }
            Binder.restoreCallingIdentity(origId);
        }
    }

    private final void handleAppDiedLocked(ProcessRecord app, boolean restarting, boolean allowRestart) {
        int pid = app.pid;
        if (!(cleanUpApplicationRecordLocked(app, restarting, allowRestart, -1) || restarting)) {
            removeLruProcessLocked(app);
            if (pid > 0) {
                ProcessList.remove(pid);
            }
        }
        if (this.mProfileProc == app) {
            clearProfilerLocked();
        }
        boolean hasVisibleActivities = this.mStackSupervisor.handleAppDiedLocked(app);
        app.activities.clear();
        if (app.instrumentationClass != null) {
            Slog.w(TAG, "Crash of app " + app.processName + " running instrumentation " + app.instrumentationClass);
            Bundle info = new Bundle();
            info.putString("shortMsg", "Process crashed.");
            finishInstrumentationLocked(app, MY_PID, info);
        }
        if (!restarting && !this.mStackSupervisor.resumeTopActivitiesLocked() && hasVisibleActivities) {
            this.mStackSupervisor.ensureActivitiesVisibleLocked(null, MY_PID);
        }
    }

    private final int getLRURecordIndexForAppLocked(IApplicationThread thread) {
        IBinder threadBinder = thread.asBinder();
        for (int i = this.mLruProcesses.size() - 1; i >= 0; i--) {
            ProcessRecord rec = (ProcessRecord) this.mLruProcesses.get(i);
            if (rec.thread != null && rec.thread.asBinder() == threadBinder) {
                return i;
            }
        }
        return -1;
    }

    final ProcessRecord getRecordForAppLocked(IApplicationThread thread) {
        if (thread == null) {
            return null;
        }
        int appIndex = getLRURecordIndexForAppLocked(thread);
        if (appIndex >= 0) {
            return (ProcessRecord) this.mLruProcesses.get(appIndex);
        }
        return null;
    }

    final void doLowMemReportIfNeededLocked(ProcessRecord dyingProc) {
        int i;
        boolean haveBg = VALIDATE_TOKENS;
        for (i = this.mLruProcesses.size() - 1; i >= 0; i--) {
            ProcessRecord rec = (ProcessRecord) this.mLruProcesses.get(i);
            if (rec.thread != null && rec.setProcState >= 11) {
                haveBg = SHOW_ACTIVITY_START_TIME;
                break;
            }
        }
        if (!haveBg) {
            long now;
            boolean doReport = "1".equals(SystemProperties.get(SYSTEM_DEBUGGABLE, "0"));
            if (doReport) {
                now = SystemClock.uptimeMillis();
                if (now < this.mLastMemUsageReportTime + 300000) {
                    doReport = VALIDATE_TOKENS;
                } else {
                    this.mLastMemUsageReportTime = now;
                }
            }
            ArrayList<ProcessMemInfo> memInfos = doReport ? new ArrayList(this.mLruProcesses.size()) : null;
            EventLog.writeEvent(EventLogTags.AM_LOW_MEMORY, this.mLruProcesses.size());
            now = SystemClock.uptimeMillis();
            for (i = this.mLruProcesses.size() - 1; i >= 0; i--) {
                rec = (ProcessRecord) this.mLruProcesses.get(i);
                if (!(rec == dyingProc || rec.thread == null)) {
                    if (doReport) {
                        memInfos.add(new ProcessMemInfo(rec.processName, rec.pid, rec.setAdj, rec.setProcState, rec.adjType, rec.makeAdjReason()));
                    }
                    if (rec.lastLowMemory + 60000 <= now) {
                        if (rec.setAdj <= UPDATE_CONFIGURATION_MSG) {
                            rec.lastRequestedGc = 0;
                        } else {
                            rec.lastRequestedGc = rec.lastLowMemory;
                        }
                        rec.reportLowMemory = SHOW_ACTIVITY_START_TIME;
                        rec.lastLowMemory = now;
                        this.mProcessesToGc.remove(rec);
                        addProcessToGcListLocked(rec);
                    }
                }
            }
            if (doReport) {
                this.mHandler.sendMessage(this.mHandler.obtainMessage(REPORT_MEM_USAGE_MSG, memInfos));
            }
            scheduleAppGcsLocked();
        }
    }

    final void appDiedLocked(ProcessRecord app) {
        appDiedLocked(app, app.pid, app.thread, VALIDATE_TOKENS);
    }

    final void appDiedLocked(ProcessRecord app, int pid, IApplicationThread thread, boolean fromBinderDied) {
        synchronized (this.mPidsSelfLocked) {
            ProcessRecord curProc = (ProcessRecord) this.mPidsSelfLocked.get(pid);
            if (curProc != app) {
                Slog.w(TAG, "Spurious death for " + app + ", curProc for " + pid + ": " + curProc);
                return;
            }
            BatteryStatsImpl stats = this.mBatteryStatsService.getActiveStatistics();
            synchronized (stats) {
                stats.noteProcessDiedLocked(app.info.uid, pid);
            }
            if (!app.killed) {
                if (!fromBinderDied) {
                    Process.killProcessQuiet(pid);
                }
                Process.killProcessGroup(app.info.uid, pid);
                app.killed = SHOW_ACTIVITY_START_TIME;
            }
            Object[] objArr;
            if (app.pid == pid && app.thread != null && app.thread.asBinder() == thread.asBinder()) {
                boolean doLowMem = app.instrumentationClass == null ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
                boolean doOomAdj = doLowMem;
                if (app.killedByAm) {
                    this.mAllowLowerMemLevel = VALIDATE_TOKENS;
                    doLowMem = VALIDATE_TOKENS;
                } else {
                    Slog.i(TAG, "Process " + app.processName + " (pid " + pid + ") has died");
                    this.mAllowLowerMemLevel = SHOW_ACTIVITY_START_TIME;
                }
                objArr = new Object[SHOW_FACTORY_ERROR_MSG];
                objArr[MY_PID] = Integer.valueOf(app.userId);
                objArr[SHOW_ERROR_MSG] = Integer.valueOf(app.pid);
                objArr[SHOW_NOT_RESPONDING_MSG] = app.processName;
                EventLog.writeEvent(EventLogTags.AM_PROC_DIED, objArr);
                handleAppDiedLocked(app, VALIDATE_TOKENS, SHOW_ACTIVITY_START_TIME);
                if (doOomAdj) {
                    updateOomAdjLocked();
                }
                if (doLowMem) {
                    doLowMemReportIfNeededLocked(app);
                }
            } else if (app.pid != pid) {
                Slog.i(TAG, "Process " + app.processName + " (pid " + pid + ") has died and restarted (pid " + app.pid + ").");
                objArr = new Object[SHOW_FACTORY_ERROR_MSG];
                objArr[MY_PID] = Integer.valueOf(app.userId);
                objArr[SHOW_ERROR_MSG] = Integer.valueOf(app.pid);
                objArr[SHOW_NOT_RESPONDING_MSG] = app.processName;
                EventLog.writeEvent(EventLogTags.AM_PROC_DIED, objArr);
            }
        }
    }

    public static File dumpStackTraces(boolean clearTraces, ArrayList<Integer> firstPids, ProcessCpuTracker processCpuTracker, SparseArray<Boolean> lastPids, String[] nativeProcs) {
        String tracesPath = SystemProperties.get("dalvik.vm.stack-trace-file", null);
        if (tracesPath == null || tracesPath.length() == 0) {
            return null;
        }
        File tracesFile = new File(tracesPath);
        try {
            File tracesDir = tracesFile.getParentFile();
            if (!tracesDir.exists()) {
                tracesDir.mkdirs();
                if (!SELinux.restorecon(tracesDir)) {
                    return null;
                }
            }
            FileUtils.setPermissions(tracesDir.getPath(), 509, -1, -1);
            if (clearTraces && tracesFile.exists()) {
                tracesFile.delete();
            }
            tracesFile.createNewFile();
            FileUtils.setPermissions(tracesFile.getPath(), 438, -1, -1);
            dumpStackTraces(tracesPath, (ArrayList) firstPids, processCpuTracker, (SparseArray) lastPids, nativeProcs);
            return tracesFile;
        } catch (IOException e) {
            Slog.w(TAG, "Unable to prepare ANR traces file: " + tracesPath, e);
            return null;
        }
    }

    private static void dumpStackTraces(String tracesPath, ArrayList<Integer> firstPids, ProcessCpuTracker processCpuTracker, SparseArray<Boolean> lastPids, String[] nativeProcs) {
        int i;
        FileObserver observer = new C01265(tracesPath, 8);
        observer.startWatching();
        if (firstPids != null) {
            try {
                int num = firstPids.size();
                for (i = MY_PID; i < num; i += SHOW_ERROR_MSG) {
                    synchronized (observer) {
                        Process.sendSignal(((Integer) firstPids.get(i)).intValue(), SHOW_FACTORY_ERROR_MSG);
                        observer.wait(200);
                    }
                }
            } catch (InterruptedException e) {
                Slog.wtf(TAG, e);
            }
        }
        if (nativeProcs != null) {
            int[] pids = Process.getPidsForCommands(nativeProcs);
            if (pids != null) {
                int[] arr$ = pids;
                int len$ = arr$.length;
                for (int i$ = MY_PID; i$ < len$; i$ += SHOW_ERROR_MSG) {
                    Debug.dumpNativeBacktraceToFile(arr$[i$], tracesPath);
                }
            }
        }
        if (processCpuTracker != null) {
            processCpuTracker.init();
            System.gc();
            processCpuTracker.update();
            try {
                synchronized (processCpuTracker) {
                    processCpuTracker.wait(500);
                }
            } catch (InterruptedException e2) {
            }
            try {
                processCpuTracker.update();
                int N = processCpuTracker.countWorkingStats();
                int numProcs = MY_PID;
                for (i = MY_PID; i < N && numProcs < GC_BACKGROUND_PROCESSES_MSG; i += SHOW_ERROR_MSG) {
                    Stats stats = processCpuTracker.getWorkingStats(i);
                    if (lastPids.indexOfKey(stats.pid) >= 0) {
                        numProcs += SHOW_ERROR_MSG;
                        try {
                            synchronized (observer) {
                                Process.sendSignal(stats.pid, SHOW_FACTORY_ERROR_MSG);
                                observer.wait(200);
                            }
                        } catch (InterruptedException e3) {
                            Slog.wtf(TAG, e3);
                        }
                    }
                }
            } catch (Throwable th) {
                observer.stopWatching();
            }
        }
        observer.stopWatching();
    }

    final void logAppTooSlow(ProcessRecord app, long startTime, String msg) {
    }

    final void appNotResponding(ProcessRecord app, ActivityRecord activity, ActivityRecord parent, boolean aboveSystem, String annotation) {
        ArrayList firstPids = new ArrayList(GC_BACKGROUND_PROCESSES_MSG);
        SparseArray<Boolean> sparseArray = new SparseArray(PROC_START_TIMEOUT_MSG);
        if (this.mController != null) {
            try {
                if (this.mController.appEarlyNotResponding(app.processName, app.pid, annotation) < 0 && app.pid != MY_PID) {
                    app.kill("anr", SHOW_ACTIVITY_START_TIME);
                }
            } catch (RemoteException e) {
                this.mController = null;
                Watchdog.getInstance().setActivityController(null);
            }
        }
        long anrTime = SystemClock.uptimeMillis();
        updateCpuStatsNow();
        synchronized (this) {
            if (this.mShuttingDown) {
                Slog.i(TAG, "During shutdown skipping ANR: " + app + " " + annotation);
            } else if (app.notResponding) {
                Slog.i(TAG, "Skipping duplicate ANR: " + app + " " + annotation);
            } else if (app.crashing) {
                Slog.i(TAG, "Crashing app skipping ANR: " + app + " " + annotation);
            } else {
                String cpuInfo;
                app.notResponding = SHOW_ACTIVITY_START_TIME;
                Object[] objArr = new Object[GC_BACKGROUND_PROCESSES_MSG];
                objArr[MY_PID] = Integer.valueOf(app.userId);
                objArr[SHOW_ERROR_MSG] = Integer.valueOf(app.pid);
                objArr[SHOW_NOT_RESPONDING_MSG] = app.processName;
                objArr[SHOW_FACTORY_ERROR_MSG] = Integer.valueOf(app.info.flags);
                objArr[UPDATE_CONFIGURATION_MSG] = annotation;
                EventLog.writeEvent(EventLogTags.AM_ANR, objArr);
                firstPids.add(Integer.valueOf(app.pid));
                int parentPid = app.pid;
                if (!(parent == null || parent.app == null || parent.app.pid <= 0)) {
                    parentPid = parent.app.pid;
                }
                if (parentPid != app.pid) {
                    firstPids.add(Integer.valueOf(parentPid));
                }
                if (!(MY_PID == app.pid || MY_PID == parentPid)) {
                    firstPids.add(Integer.valueOf(MY_PID));
                }
                for (int i = this.mLruProcesses.size() - 1; i >= 0; i--) {
                    ProcessRecord r = (ProcessRecord) this.mLruProcesses.get(i);
                    if (!(r == null || r.thread == null)) {
                        int pid = r.pid;
                        if (!(pid <= 0 || pid == app.pid || pid == parentPid || pid == MY_PID)) {
                            if (r.persistent) {
                                firstPids.add(Integer.valueOf(pid));
                            } else {
                                sparseArray.put(pid, Boolean.TRUE);
                            }
                        }
                    }
                }
                StringBuilder info = new StringBuilder();
                info.setLength(MY_PID);
                info.append("ANR in ").append(app.processName);
                if (!(activity == null || activity.shortComponentName == null)) {
                    info.append(" (").append(activity.shortComponentName).append(")");
                }
                info.append("\n");
                info.append("PID: ").append(app.pid).append("\n");
                if (annotation != null) {
                    info.append("Reason: ").append(annotation).append("\n");
                }
                if (!(parent == null || parent == activity)) {
                    info.append("Parent: ").append(parent.shortComponentName).append("\n");
                }
                ProcessCpuTracker processCpuTracker = new ProcessCpuTracker(SHOW_ACTIVITY_START_TIME);
                File tracesFile = dumpStackTraces((boolean) SHOW_ACTIVITY_START_TIME, firstPids, processCpuTracker, (SparseArray) sparseArray, Watchdog.NATIVE_STACKS_OF_INTEREST);
                updateCpuStatsNow();
                synchronized (this.mProcessCpuTracker) {
                    cpuInfo = this.mProcessCpuTracker.printCurrentState(anrTime);
                }
                info.append(processCpuTracker.printCurrentLoad());
                info.append(cpuInfo);
                info.append(processCpuTracker.printCurrentState(anrTime));
                Slog.e(TAG, info.toString());
                if (tracesFile == null) {
                    Process.sendSignal(app.pid, SHOW_FACTORY_ERROR_MSG);
                }
                addErrorToDropBox("anr", app, app.processName, activity, parent, annotation, cpuInfo, tracesFile, null);
                if (this.mController != null) {
                    try {
                        int res = this.mController.appNotResponding(app.processName, app.pid, info.toString());
                        if (res != 0) {
                            if (res >= 0 || app.pid == MY_PID) {
                                synchronized (this) {
                                    this.mServices.scheduleServiceTimeoutLocked(app);
                                    return;
                                }
                            }
                            app.kill("anr", SHOW_ACTIVITY_START_TIME);
                            return;
                        }
                    } catch (RemoteException e2) {
                        this.mController = null;
                        Watchdog.getInstance().setActivityController(null);
                    }
                }
                boolean showBackground = Secure.getInt(this.mContext.getContentResolver(), "anr_show_background", MY_PID) != 0 ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
                synchronized (this) {
                    this.mBatteryStatsService.noteProcessAnr(app.processName, app.uid);
                    if (showBackground || app.isInterestingToUserLocked() || app.pid == MY_PID) {
                        String str;
                        String str2;
                        if (activity != null) {
                            str = activity.shortComponentName;
                        } else {
                            str = null;
                        }
                        if (annotation != null) {
                            str2 = "ANR " + annotation;
                        } else {
                            str2 = "ANR";
                        }
                        makeAppNotRespondingLocked(app, str, str2, info.toString());
                        String tracesPath = SystemProperties.get("dalvik.vm.stack-trace-file", null);
                        if (!(tracesPath == null || tracesPath.length() == 0)) {
                            String newTracesPath;
                            File traceRenameFile = new File(tracesPath);
                            int lpos = tracesPath.lastIndexOf(".");
                            if (-1 != lpos) {
                                newTracesPath = tracesPath.substring(MY_PID, lpos) + "_" + app.processName + tracesPath.substring(lpos);
                            } else {
                                newTracesPath = tracesPath + "_" + app.processName;
                            }
                            traceRenameFile.renameTo(new File(newTracesPath));
                            Process.sendSignal(app.pid, WAIT_FOR_DEBUGGER_MSG);
                            SystemClock.sleep(1000);
                            Process.sendSignal(app.pid, WAIT_FOR_DEBUGGER_MSG);
                            SystemClock.sleep(1000);
                        }
                        Message msg = Message.obtain();
                        HashMap<String, Object> map = new HashMap();
                        msg.what = SHOW_NOT_RESPONDING_MSG;
                        msg.obj = map;
                        msg.arg1 = aboveSystem ? SHOW_ERROR_MSG : MY_PID;
                        map.put("app", app);
                        if (activity != null) {
                            map.put("activity", activity);
                        }
                        this.mHandler.sendMessage(msg);
                        return;
                    }
                    app.kill("bg anr", SHOW_ACTIVITY_START_TIME);
                }
            }
        }
    }

    final void showLaunchWarningLocked(ActivityRecord cur, ActivityRecord next) {
        if (!this.mLaunchWarningShown) {
            this.mLaunchWarningShown = SHOW_ACTIVITY_START_TIME;
            this.mHandler.post(new C01286(cur, next));
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public boolean clearApplicationUserData(java.lang.String r29, android.content.pm.IPackageDataObserver r30, int r31) {
        /*
        r28 = this;
        r4 = "clearApplicationUserData";
        r0 = r28;
        r0.enforceNotIsolatedCaller(r4);
        r6 = android.os.Binder.getCallingUid();
        r5 = android.os.Binder.getCallingPid();
        r8 = 0;
        r9 = 2;
        r10 = "clearApplicationUserData";
        r11 = 0;
        r4 = r28;
        r7 = r31;
        r31 = r4.handleIncomingUser(r5, r6, r7, r8, r9, r10, r11);
        r20 = android.os.Binder.clearCallingIdentity();
        r25 = android.app.AppGlobals.getPackageManager();	 Catch:{ all -> 0x006c }
        r24 = -1;
        monitor-enter(r28);	 Catch:{ all -> 0x006c }
        r0 = r25;
        r1 = r29;
        r2 = r31;
        r24 = r0.getPackageUid(r1, r2);	 Catch:{ RemoteException -> 0x0159 }
    L_0x0031:
        r4 = -1;
        r0 = r24;
        if (r0 != r4) goto L_0x0071;
    L_0x0036:
        r4 = "ActivityManager";
        r7 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0069 }
        r7.<init>();	 Catch:{ all -> 0x0069 }
        r8 = "Invalid packageName: ";
        r7 = r7.append(r8);	 Catch:{ all -> 0x0069 }
        r0 = r29;
        r7 = r7.append(r0);	 Catch:{ all -> 0x0069 }
        r7 = r7.toString();	 Catch:{ all -> 0x0069 }
        android.util.Slog.w(r4, r7);	 Catch:{ all -> 0x0069 }
        if (r30 == 0) goto L_0x005a;
    L_0x0052:
        r4 = 0;
        r0 = r30;
        r1 = r29;
        r0.onRemoveCompleted(r1, r4);	 Catch:{ RemoteException -> 0x0060 }
    L_0x005a:
        r4 = 0;
        monitor-exit(r28);	 Catch:{ all -> 0x0069 }
        android.os.Binder.restoreCallingIdentity(r20);
    L_0x005f:
        return r4;
    L_0x0060:
        r22 = move-exception;
        r4 = "ActivityManager";
        r7 = "Observer no longer exists.";
        android.util.Slog.i(r4, r7);	 Catch:{ all -> 0x0069 }
        goto L_0x005a;
    L_0x0069:
        r4 = move-exception;
        monitor-exit(r28);	 Catch:{ all -> 0x0069 }
        throw r4;	 Catch:{ all -> 0x006c }
    L_0x006c:
        r4 = move-exception;
        android.os.Binder.restoreCallingIdentity(r20);
        throw r4;
    L_0x0071:
        r0 = r24;
        if (r6 == r0) goto L_0x0083;
    L_0x0075:
        r8 = "android.permission.CLEAR_APP_USER_DATA";
        r11 = -1;
        r12 = 1;
        r7 = r28;
        r9 = r5;
        r10 = r6;
        r4 = r7.checkComponentPermission(r8, r9, r10, r11, r12);	 Catch:{ all -> 0x0069 }
        if (r4 != 0) goto L_0x00bd;
    L_0x0083:
        r4 = "clear data";
        r0 = r28;
        r1 = r29;
        r2 = r24;
        r0.forceStopPackageLocked(r1, r2, r4);	 Catch:{ all -> 0x0069 }
        r0 = r28;
        r4 = r0.mRecentTasks;	 Catch:{ all -> 0x0069 }
        r4 = r4.size();	 Catch:{ all -> 0x0069 }
        r23 = r4 + -1;
    L_0x0098:
        if (r23 < 0) goto L_0x0109;
    L_0x009a:
        r0 = r28;
        r4 = r0.mRecentTasks;	 Catch:{ all -> 0x0069 }
        r0 = r23;
        r27 = r4.get(r0);	 Catch:{ all -> 0x0069 }
        r27 = (com.android.server.am.TaskRecord) r27;	 Catch:{ all -> 0x0069 }
        r4 = r27.getBaseIntent();	 Catch:{ all -> 0x0069 }
        r4 = r4.getComponent();	 Catch:{ all -> 0x0069 }
        r26 = r4.getPackageName();	 Catch:{ all -> 0x0069 }
        r0 = r27;
        r4 = r0.userId;	 Catch:{ all -> 0x0069 }
        r0 = r31;
        if (r4 == r0) goto L_0x00f4;
    L_0x00ba:
        r23 = r23 + -1;
        goto L_0x0098;
    L_0x00bd:
        r4 = new java.lang.SecurityException;	 Catch:{ all -> 0x0069 }
        r7 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0069 }
        r7.<init>();	 Catch:{ all -> 0x0069 }
        r8 = "PID ";
        r7 = r7.append(r8);	 Catch:{ all -> 0x0069 }
        r7 = r7.append(r5);	 Catch:{ all -> 0x0069 }
        r8 = " does not have permission ";
        r7 = r7.append(r8);	 Catch:{ all -> 0x0069 }
        r8 = "android.permission.CLEAR_APP_USER_DATA";
        r7 = r7.append(r8);	 Catch:{ all -> 0x0069 }
        r8 = " to clear data";
        r7 = r7.append(r8);	 Catch:{ all -> 0x0069 }
        r8 = " of package ";
        r7 = r7.append(r8);	 Catch:{ all -> 0x0069 }
        r0 = r29;
        r7 = r7.append(r0);	 Catch:{ all -> 0x0069 }
        r7 = r7.toString();	 Catch:{ all -> 0x0069 }
        r4.<init>(r7);	 Catch:{ all -> 0x0069 }
        throw r4;	 Catch:{ all -> 0x0069 }
    L_0x00f4:
        r0 = r26;
        r1 = r29;
        r4 = r0.equals(r1);	 Catch:{ all -> 0x0069 }
        if (r4 == 0) goto L_0x00ba;
    L_0x00fe:
        r0 = r27;
        r4 = r0.taskId;	 Catch:{ all -> 0x0069 }
        r7 = 0;
        r0 = r28;
        r0.removeTaskByIdLocked(r4, r7);	 Catch:{ all -> 0x0069 }
        goto L_0x00ba;
    L_0x0109:
        monitor-exit(r28);	 Catch:{ all -> 0x0069 }
        r0 = r25;
        r1 = r29;
        r2 = r30;
        r3 = r31;
        r0.clearApplicationUserData(r1, r2, r3);	 Catch:{ RemoteException -> 0x0157 }
        monitor-enter(r28);	 Catch:{ RemoteException -> 0x0157 }
        r4 = 1;
        r0 = r28;
        r1 = r29;
        r2 = r31;
        r0.removeUriPermissionsForPackageLocked(r1, r2, r4);	 Catch:{ all -> 0x0154 }
        monitor-exit(r28);	 Catch:{ all -> 0x0154 }
        r10 = new android.content.Intent;	 Catch:{ RemoteException -> 0x0157 }
        r4 = "android.intent.action.PACKAGE_DATA_CLEARED";
        r7 = "package";
        r8 = 0;
        r0 = r29;
        r7 = android.net.Uri.fromParts(r7, r0, r8);	 Catch:{ RemoteException -> 0x0157 }
        r10.<init>(r4, r7);	 Catch:{ RemoteException -> 0x0157 }
        r4 = "android.intent.extra.UID";
        r0 = r24;
        r10.putExtra(r4, r0);	 Catch:{ RemoteException -> 0x0157 }
        r8 = "android";
        r9 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;
        r11 = 0;
        r12 = 0;
        r13 = 0;
        r14 = 0;
        r15 = 0;
        r16 = 0;
        r17 = 0;
        r18 = 0;
        r7 = r28;
        r19 = r31;
        r7.broadcastIntentInPackage(r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19);	 Catch:{ RemoteException -> 0x0157 }
    L_0x014e:
        android.os.Binder.restoreCallingIdentity(r20);
        r4 = 1;
        goto L_0x005f;
    L_0x0154:
        r4 = move-exception;
        monitor-exit(r28);	 Catch:{ all -> 0x0154 }
        throw r4;	 Catch:{ RemoteException -> 0x0157 }
    L_0x0157:
        r4 = move-exception;
        goto L_0x014e;
    L_0x0159:
        r4 = move-exception;
        goto L_0x0031;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.ActivityManagerService.clearApplicationUserData(java.lang.String, android.content.pm.IPackageDataObserver, int):boolean");
    }

    public void killBackgroundProcesses(String packageName, int userId) {
        if (checkCallingPermission("android.permission.KILL_BACKGROUND_PROCESSES") == 0 || checkCallingPermission("android.permission.RESTART_PACKAGES") == 0) {
            userId = handleIncomingUser(Binder.getCallingPid(), Binder.getCallingUid(), userId, (boolean) SHOW_ACTIVITY_START_TIME, (int) SHOW_NOT_RESPONDING_MSG, "killBackgroundProcesses", null);
            long callingId = Binder.clearCallingIdentity();
            try {
                IPackageManager pm = AppGlobals.getPackageManager();
                synchronized (this) {
                    int appId = -1;
                    try {
                        appId = UserHandle.getAppId(pm.getPackageUid(packageName, MY_PID));
                    } catch (RemoteException e) {
                    }
                    if (appId == -1) {
                        Slog.w(TAG, "Invalid packageName: " + packageName);
                        return;
                    }
                    killPackageProcessesLocked(packageName, appId, userId, GC_BACKGROUND_PROCESSES_MSG, VALIDATE_TOKENS, SHOW_ACTIVITY_START_TIME, SHOW_ACTIVITY_START_TIME, VALIDATE_TOKENS, "kill background");
                    Binder.restoreCallingIdentity(callingId);
                    return;
                    while (true) {
                        break;
                    }
                }
            } finally {
                Binder.restoreCallingIdentity(callingId);
            }
        } else {
            String msg = "Permission Denial: killBackgroundProcesses() from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " requires " + "android.permission.KILL_BACKGROUND_PROCESSES";
            Slog.w(TAG, msg);
            throw new SecurityException(msg);
        }
    }

    public void killAllBackgroundProcesses() {
        if (checkCallingPermission("android.permission.KILL_BACKGROUND_PROCESSES") != 0) {
            String msg = "Permission Denial: killAllBackgroundProcesses() from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " requires " + "android.permission.KILL_BACKGROUND_PROCESSES";
            Slog.w(TAG, msg);
            throw new SecurityException(msg);
        }
        long callingId = Binder.clearCallingIdentity();
        try {
            synchronized (this) {
                ArrayList<ProcessRecord> procs = new ArrayList();
                int NP = this.mProcessNames.getMap().size();
                for (int ip = MY_PID; ip < NP; ip += SHOW_ERROR_MSG) {
                    SparseArray<ProcessRecord> apps = (SparseArray) this.mProcessNames.getMap().valueAt(ip);
                    int NA = apps.size();
                    for (int ia = MY_PID; ia < NA; ia += SHOW_ERROR_MSG) {
                        ProcessRecord app = (ProcessRecord) apps.valueAt(ia);
                        if (!app.persistent) {
                            if (app.removed) {
                                procs.add(app);
                            } else {
                                int i = app.setAdj;
                                if (r0 >= 9) {
                                    app.removed = SHOW_ACTIVITY_START_TIME;
                                    procs.add(app);
                                }
                            }
                        }
                    }
                }
                int N = procs.size();
                for (int i2 = MY_PID; i2 < N; i2 += SHOW_ERROR_MSG) {
                    removeProcessLocked((ProcessRecord) procs.get(i2), VALIDATE_TOKENS, SHOW_ACTIVITY_START_TIME, "kill all background");
                }
                this.mAllowLowerMemLevel = SHOW_ACTIVITY_START_TIME;
                updateOomAdjLocked();
                doLowMemReportIfNeededLocked(null);
            }
        } finally {
            Binder.restoreCallingIdentity(callingId);
        }
    }

    public void forceStopPackage(String packageName, int userId) {
        if (checkCallingPermission("android.permission.FORCE_STOP_PACKAGES") != 0) {
            String msg = "Permission Denial: forceStopPackage() from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " requires " + "android.permission.FORCE_STOP_PACKAGES";
            Slog.w(TAG, msg);
            throw new SecurityException(msg);
        }
        int callingPid = Binder.getCallingPid();
        userId = handleIncomingUser(callingPid, Binder.getCallingUid(), userId, (boolean) SHOW_ACTIVITY_START_TIME, (int) SHOW_NOT_RESPONDING_MSG, "forceStopPackage", null);
        long callingId = Binder.clearCallingIdentity();
        try {
            IPackageManager pm = AppGlobals.getPackageManager();
            synchronized (this) {
                int[] users;
                if (userId == -1) {
                    users = getUsersLocked();
                } else {
                    users = new int[SHOW_ERROR_MSG];
                    users[MY_PID] = userId;
                }
                int[] arr$ = users;
                int len$ = arr$.length;
                for (int i$ = MY_PID; i$ < len$; i$ += SHOW_ERROR_MSG) {
                    int user = arr$[i$];
                    int pkgUid = -1;
                    try {
                        pkgUid = pm.getPackageUid(packageName, user);
                    } catch (RemoteException e) {
                    }
                    if (pkgUid == -1) {
                        Slog.w(TAG, "Invalid packageName: " + packageName);
                    } else {
                        try {
                            pm.setPackageStoppedState(packageName, SHOW_ACTIVITY_START_TIME, user);
                        } catch (RemoteException e2) {
                        } catch (IllegalArgumentException e3) {
                            Slog.w(TAG, "Failed trying to unstop package " + packageName + ": " + e3);
                        }
                        if (isUserRunningLocked(user, VALIDATE_TOKENS)) {
                            forceStopPackageLocked(packageName, pkgUid, "from pid " + callingPid);
                        }
                    }
                }
            }
        } finally {
            Binder.restoreCallingIdentity(callingId);
        }
    }

    public void addPackageDependency(String packageName) {
        synchronized (this) {
            if (Binder.getCallingPid() == Process.myPid()) {
                return;
            }
            synchronized (this.mPidsSelfLocked) {
                ProcessRecord proc = (ProcessRecord) this.mPidsSelfLocked.get(Binder.getCallingPid());
            }
            if (proc != null) {
                if (proc.pkgDeps == null) {
                    proc.pkgDeps = new ArraySet(SHOW_ERROR_MSG);
                }
                proc.pkgDeps.add(packageName);
            }
        }
    }

    public void killApplicationWithAppId(String pkg, int appid, String reason) {
        if (pkg != null) {
            if (appid < 0) {
                Slog.w(TAG, "Invalid appid specified for pkg : " + pkg);
                return;
            }
            int callerUid = Binder.getCallingUid();
            if (callerUid == NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY) {
                Message msg = this.mHandler.obtainMessage(KILL_APPLICATION_MSG);
                msg.arg1 = appid;
                msg.arg2 = MY_PID;
                Bundle bundle = new Bundle();
                bundle.putString("pkg", pkg);
                bundle.putString("reason", reason);
                msg.obj = bundle;
                this.mHandler.sendMessage(msg);
                return;
            }
            throw new SecurityException(callerUid + " cannot kill pkg: " + pkg);
        }
    }

    public void closeSystemDialogs(String reason) {
        enforceNotIsolatedCaller("closeSystemDialogs");
        int pid = Binder.getCallingPid();
        int uid = Binder.getCallingUid();
        long origId = Binder.clearCallingIdentity();
        try {
            synchronized (this) {
                if (uid >= PROC_START_TIMEOUT) {
                    ProcessRecord proc;
                    synchronized (this.mPidsSelfLocked) {
                        proc = (ProcessRecord) this.mPidsSelfLocked.get(pid);
                    }
                    if (proc.curRawAdj > SHOW_NOT_RESPONDING_MSG) {
                        Slog.w(TAG, "Ignoring closeSystemDialogs " + reason + " from background process " + proc);
                        return;
                    }
                }
                closeSystemDialogsLocked(reason);
                Binder.restoreCallingIdentity(origId);
            }
        } finally {
            Binder.restoreCallingIdentity(origId);
        }
    }

    void closeSystemDialogsLocked(String reason) {
        Intent intent = new Intent("android.intent.action.CLOSE_SYSTEM_DIALOGS");
        intent.addFlags(1342177280);
        if (reason != null) {
            intent.putExtra("reason", reason);
        }
        this.mWindowManager.closeSystemDialogs(reason);
        this.mStackSupervisor.closeSystemDialogsLocked();
        broadcastIntentLocked(null, null, intent, null, null, MY_PID, null, null, null, -1, VALIDATE_TOKENS, VALIDATE_TOKENS, -1, NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY, -1);
    }

    public MemoryInfo[] getProcessMemoryInfo(int[] pids) {
        enforceNotIsolatedCaller("getProcessMemoryInfo");
        MemoryInfo[] infos = new MemoryInfo[pids.length];
        for (int i = pids.length - 1; i >= 0; i--) {
            synchronized (this) {
                synchronized (this.mPidsSelfLocked) {
                    ProcessRecord proc = (ProcessRecord) this.mPidsSelfLocked.get(pids[i]);
                    int oomAdj;
                    if (proc != null) {
                        oomAdj = proc.setAdj;
                    } else {
                        oomAdj = MY_PID;
                    }
                }
            }
            infos[i] = new MemoryInfo();
            Debug.getMemoryInfo(pids[i], infos[i]);
            if (proc != null) {
                synchronized (this) {
                    if (proc.thread != null && proc.setAdj == oomAdj) {
                        proc.baseProcessTracker.addPss((long) infos[i].getTotalPss(), (long) infos[i].getTotalUss(), VALIDATE_TOKENS, proc.pkgList);
                    }
                }
            }
        }
        return infos;
    }

    public long[] getProcessPss(int[] pids) {
        enforceNotIsolatedCaller("getProcessPss");
        long[] pss = new long[pids.length];
        for (int i = pids.length - 1; i >= 0; i--) {
            synchronized (this) {
                synchronized (this.mPidsSelfLocked) {
                    ProcessRecord proc = (ProcessRecord) this.mPidsSelfLocked.get(pids[i]);
                    int oomAdj;
                    if (proc != null) {
                        oomAdj = proc.setAdj;
                    } else {
                        oomAdj = MY_PID;
                    }
                }
            }
            long[] tmpUss = new long[SHOW_ERROR_MSG];
            pss[i] = Debug.getPss(pids[i], tmpUss, null);
            if (proc != null) {
                synchronized (this) {
                    if (proc.thread != null && proc.setAdj == oomAdj) {
                        proc.baseProcessTracker.addPss(pss[i], tmpUss[MY_PID], VALIDATE_TOKENS, proc.pkgList);
                    }
                }
            }
        }
        return pss;
    }

    public void killApplicationProcess(String processName, int uid) {
        if (processName != null) {
            int callerUid = Binder.getCallingUid();
            if (callerUid == NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY) {
                synchronized (this) {
                    ProcessRecord app = getProcessRecordLocked(processName, uid, SHOW_ACTIVITY_START_TIME);
                    if (app == null || app.thread == null) {
                        Slog.w(TAG, "Process/uid not found attempting kill of " + processName + " / " + uid);
                    } else {
                        try {
                            app.thread.scheduleSuicide();
                        } catch (RemoteException e) {
                        }
                    }
                }
                return;
            }
            throw new SecurityException(callerUid + " cannot kill app process: " + processName);
        }
    }

    private void forceStopPackageLocked(String packageName, int uid, String reason) {
        forceStopPackageLocked(packageName, UserHandle.getAppId(uid), VALIDATE_TOKENS, VALIDATE_TOKENS, SHOW_ACTIVITY_START_TIME, VALIDATE_TOKENS, VALIDATE_TOKENS, UserHandle.getUserId(uid), reason);
        Intent intent = new Intent("android.intent.action.PACKAGE_RESTARTED", Uri.fromParts("package", packageName, null));
        if (!this.mProcessesReady) {
            intent.addFlags(1342177280);
        }
        intent.putExtra("android.intent.extra.UID", uid);
        intent.putExtra("android.intent.extra.user_handle", UserHandle.getUserId(uid));
        broadcastIntentLocked(null, null, intent, null, null, MY_PID, null, null, null, -1, VALIDATE_TOKENS, VALIDATE_TOKENS, MY_PID, NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY, UserHandle.getUserId(uid));
    }

    private void forceStopUserLocked(int userId, String reason) {
        forceStopPackageLocked(null, -1, VALIDATE_TOKENS, VALIDATE_TOKENS, SHOW_ACTIVITY_START_TIME, VALIDATE_TOKENS, VALIDATE_TOKENS, userId, reason);
        Intent intent = new Intent("android.intent.action.USER_STOPPED");
        intent.addFlags(1342177280);
        intent.putExtra("android.intent.extra.user_handle", userId);
        broadcastIntentLocked(null, null, intent, null, null, MY_PID, null, null, null, -1, VALIDATE_TOKENS, VALIDATE_TOKENS, MY_PID, NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY, -1);
    }

    private final boolean killPackageProcessesLocked(String packageName, int appId, int userId, int minOomAdj, boolean callerWillRestart, boolean allowRestart, boolean doit, boolean evenPersistent, String reason) {
        ArrayList<ProcessRecord> procs = new ArrayList();
        int NP = this.mProcessNames.getMap().size();
        for (int ip = MY_PID; ip < NP; ip += SHOW_ERROR_MSG) {
            SparseArray<ProcessRecord> apps = (SparseArray) this.mProcessNames.getMap().valueAt(ip);
            int NA = apps.size();
            for (int ia = MY_PID; ia < NA; ia += SHOW_ERROR_MSG) {
                ProcessRecord app = (ProcessRecord) apps.valueAt(ia);
                if (!app.persistent || evenPersistent) {
                    if (app.removed) {
                        if (doit) {
                            procs.add(app);
                        }
                    } else if (app.setAdj < minOomAdj) {
                        continue;
                    } else {
                        if (packageName != null) {
                            boolean isDep = (app.pkgDeps == null || !app.pkgDeps.contains(packageName)) ? VALIDATE_TOKENS : SHOW_ACTIVITY_START_TIME;
                            if ((isDep || UserHandle.getAppId(app.uid) == appId) && (userId == -1 || app.userId == userId)) {
                                if (!(app.pkgList.containsKey(packageName) || isDep)) {
                                }
                            }
                        } else if (app.userId != userId) {
                            continue;
                        } else if (appId >= 0 && UserHandle.getAppId(app.uid) != appId) {
                        }
                        if (!doit) {
                            return SHOW_ACTIVITY_START_TIME;
                        }
                        app.removed = SHOW_ACTIVITY_START_TIME;
                        procs.add(app);
                    }
                }
            }
        }
        int N = procs.size();
        for (int i = MY_PID; i < N; i += SHOW_ERROR_MSG) {
            removeProcessLocked((ProcessRecord) procs.get(i), callerWillRestart, allowRestart, reason);
        }
        updateOomAdjLocked();
        return N > 0 ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
    }

    private final boolean forceStopPackageLocked(String name, int appId, boolean callerWillRestart, boolean purgeCache, boolean doit, boolean evenPersistent, boolean uninstalling, int userId, String reason) {
        int i;
        if (userId == -1 && name == null) {
            Slog.w(TAG, "Can't force stop all processes of all users, that is insane!");
        }
        if (appId < 0 && name != null) {
            try {
                appId = UserHandle.getAppId(AppGlobals.getPackageManager().getPackageUid(name, MY_PID));
            } catch (RemoteException e) {
            }
        }
        if (doit) {
            if (name != null) {
                Slog.i(TAG, "Force stopping " + name + " appid=" + appId + " user=" + userId + ": " + reason);
            } else {
                Slog.i(TAG, "Force stopping u" + userId + ": " + reason);
            }
            ArrayMap<String, SparseArray<Long>> pmap = this.mProcessCrashTimes.getMap();
            for (int ip = pmap.size() - 1; ip >= 0; ip--) {
                SparseArray<Long> ba = (SparseArray) pmap.valueAt(ip);
                for (i = ba.size() - 1; i >= 0; i--) {
                    boolean remove = VALIDATE_TOKENS;
                    int entUid = ba.keyAt(i);
                    if (name != null) {
                        if (userId == -1) {
                            if (UserHandle.getAppId(entUid) == appId) {
                                remove = SHOW_ACTIVITY_START_TIME;
                            }
                        } else if (entUid == UserHandle.getUid(userId, appId)) {
                            remove = SHOW_ACTIVITY_START_TIME;
                        }
                    } else if (UserHandle.getUserId(entUid) == userId) {
                        remove = SHOW_ACTIVITY_START_TIME;
                    }
                    if (remove) {
                        ba.removeAt(i);
                    }
                }
                if (ba.size() == 0) {
                    pmap.removeAt(ip);
                }
            }
        }
        boolean killPackageProcessesLocked = killPackageProcessesLocked(name, appId, userId, -100, callerWillRestart, SHOW_ACTIVITY_START_TIME, doit, evenPersistent, name == null ? "stop user " + userId : "stop " + name);
        if (this.mStackSupervisor.forceStopPackageLocked(name, doit, evenPersistent, userId)) {
            if (!doit) {
                return SHOW_ACTIVITY_START_TIME;
            }
            killPackageProcessesLocked = SHOW_ACTIVITY_START_TIME;
        }
        if (this.mServices.forceStopLocked(name, userId, evenPersistent, doit)) {
            if (!doit) {
                return SHOW_ACTIVITY_START_TIME;
            }
            killPackageProcessesLocked = SHOW_ACTIVITY_START_TIME;
        }
        if (name == null) {
            this.mStickyBroadcasts.remove(userId);
        }
        ArrayList<ContentProviderRecord> providers = new ArrayList();
        if (this.mProviderMap.collectForceStopProviders(name, appId, doit, evenPersistent, userId, providers)) {
            if (!doit) {
                return SHOW_ACTIVITY_START_TIME;
            }
            killPackageProcessesLocked = SHOW_ACTIVITY_START_TIME;
        }
        int N = providers.size();
        for (i = MY_PID; i < N; i += SHOW_ERROR_MSG) {
            removeDyingProviderLocked(null, (ContentProviderRecord) providers.get(i), SHOW_ACTIVITY_START_TIME);
        }
        removeUriPermissionsForPackageLocked(name, userId, VALIDATE_TOKENS);
        if ((name == null || uninstalling) && this.mIntentSenderRecords.size() > 0) {
            Iterator<WeakReference<PendingIntentRecord>> it = this.mIntentSenderRecords.values().iterator();
            while (it.hasNext()) {
                WeakReference<PendingIntentRecord> wpir = (WeakReference) it.next();
                if (wpir == null) {
                    it.remove();
                } else {
                    PendingIntentRecord pir = (PendingIntentRecord) wpir.get();
                    if (pir == null) {
                        it.remove();
                    } else {
                        if (name == null) {
                            if (pir.key.userId != userId) {
                                continue;
                            }
                        } else if (UserHandle.getAppId(pir.uid) == appId && (userId == -1 || pir.key.userId == userId)) {
                            if (!pir.key.packageName.equals(name)) {
                            }
                        }
                        if (!doit) {
                            return SHOW_ACTIVITY_START_TIME;
                        }
                        killPackageProcessesLocked = SHOW_ACTIVITY_START_TIME;
                        it.remove();
                        pir.canceled = SHOW_ACTIVITY_START_TIME;
                        if (!(pir.key.activity == null || pir.key.activity.pendingResults == null)) {
                            pir.key.activity.pendingResults.remove(pir.ref);
                        }
                    }
                }
            }
        }
        if (doit) {
            if (purgeCache && name != null) {
                AttributeCache ac = AttributeCache.instance();
                if (ac != null) {
                    ac.removePackage(name);
                }
            }
            if (this.mBooted) {
                this.mStackSupervisor.resumeTopActivitiesLocked();
                this.mStackSupervisor.scheduleIdleLocked();
            }
        }
        return killPackageProcessesLocked;
    }

    private final boolean removeProcessLocked(ProcessRecord app, boolean callerWillRestart, boolean allowRestart, String reason) {
        this.mProcessNames.remove(app.processName, app.uid);
        this.mIsolatedProcesses.remove(app.uid);
        if (this.mHeavyWeightProcess == app) {
            this.mHandler.sendMessage(this.mHandler.obtainMessage(CANCEL_HEAVY_NOTIFICATION_MSG, this.mHeavyWeightProcess.userId, MY_PID));
            this.mHeavyWeightProcess = null;
        }
        if (app.pid <= 0 || app.pid == MY_PID) {
            this.mRemovedProcesses.add(app);
            return VALIDATE_TOKENS;
        }
        int pid = app.pid;
        synchronized (this.mPidsSelfLocked) {
            this.mPidsSelfLocked.remove(pid);
            this.mHandler.removeMessages(PROC_START_TIMEOUT_MSG, app);
        }
        this.mBatteryStatsService.noteProcessFinish(app.processName, app.info.uid);
        if (app.isolated) {
            this.mBatteryStatsService.removeIsolatedUid(app.uid, app.info.uid);
        }
        app.kill(reason, SHOW_ACTIVITY_START_TIME);
        handleAppDiedLocked(app, SHOW_ACTIVITY_START_TIME, allowRestart);
        removeLruProcessLocked(app);
        if (!app.persistent || app.isolated) {
            return VALIDATE_TOKENS;
        }
        if (callerWillRestart) {
            return SHOW_ACTIVITY_START_TIME;
        }
        addAppLocked(app.info, VALIDATE_TOKENS, null);
        return VALIDATE_TOKENS;
    }

    private final void processStartTimedOutLocked(ProcessRecord app) {
        int pid = app.pid;
        boolean gone = VALIDATE_TOKENS;
        synchronized (this.mPidsSelfLocked) {
            ProcessRecord knownApp = (ProcessRecord) this.mPidsSelfLocked.get(pid);
            if (knownApp != null && knownApp.thread == null) {
                this.mPidsSelfLocked.remove(pid);
                gone = SHOW_ACTIVITY_START_TIME;
            }
        }
        if (gone) {
            Slog.w(TAG, "Process " + app + " failed to attach");
            Object[] objArr = new Object[UPDATE_CONFIGURATION_MSG];
            objArr[MY_PID] = Integer.valueOf(app.userId);
            objArr[SHOW_ERROR_MSG] = Integer.valueOf(pid);
            objArr[SHOW_NOT_RESPONDING_MSG] = Integer.valueOf(app.uid);
            objArr[SHOW_FACTORY_ERROR_MSG] = app.processName;
            EventLog.writeEvent(EventLogTags.AM_PROCESS_START_TIMEOUT, objArr);
            this.mProcessNames.remove(app.processName, app.uid);
            this.mIsolatedProcesses.remove(app.uid);
            if (this.mHeavyWeightProcess == app) {
                this.mHandler.sendMessage(this.mHandler.obtainMessage(CANCEL_HEAVY_NOTIFICATION_MSG, this.mHeavyWeightProcess.userId, MY_PID));
                this.mHeavyWeightProcess = null;
            }
            this.mBatteryStatsService.noteProcessFinish(app.processName, app.info.uid);
            if (app.isolated) {
                this.mBatteryStatsService.removeIsolatedUid(app.uid, app.info.uid);
            }
            checkAppInLaunchingProvidersLocked(app, SHOW_ACTIVITY_START_TIME);
            this.mServices.processStartTimedOutLocked(app);
            app.kill("start timeout", SHOW_ACTIVITY_START_TIME);
            if (this.mBackupTarget != null && this.mBackupTarget.app.pid == pid) {
                Slog.w(TAG, "Unattached app died before backup, skipping");
                try {
                    IBackupManager.Stub.asInterface(ServiceManager.getService("backup")).agentDisconnected(app.info.packageName);
                } catch (RemoteException e) {
                }
            }
            if (isPendingBroadcastProcessLocked(pid)) {
                Slog.w(TAG, "Unattached app died before broadcast acknowledged, skipping");
                skipPendingBroadcastLocked(pid);
                return;
            }
            return;
        }
        Slog.w(TAG, "Spurious process start timeout - pid not known for " + app);
    }

    private final boolean attachApplicationLocked(IApplicationThread thread, int pid) {
        ProcessRecord app;
        if (pid == MY_PID || pid < 0) {
            app = null;
        } else {
            synchronized (this.mPidsSelfLocked) {
                app = (ProcessRecord) this.mPidsSelfLocked.get(pid);
            }
        }
        if (app == null) {
            Slog.w(TAG, "No pending application record for pid " + pid + " (IApplicationThread " + thread + "); dropping process");
            EventLog.writeEvent(EventLogTags.AM_DROP_PROCESS, pid);
            if (pid <= 0 || pid == MY_PID) {
                try {
                    thread.scheduleExit();
                } catch (Exception e) {
                }
            } else {
                Process.killProcessQuiet(pid);
            }
            return VALIDATE_TOKENS;
        }
        if (app.thread != null) {
            handleAppDiedLocked(app, SHOW_ACTIVITY_START_TIME, SHOW_ACTIVITY_START_TIME);
        }
        String processName = app.processName;
        try {
            boolean normalMode;
            List<ProviderInfo> providers;
            int testMode;
            String profileFile;
            ParcelFileDescriptor profileFd;
            int samplingInterval;
            boolean profileAutoStop;
            boolean enableOpenGlTrace;
            boolean isRestrictedBackupMode;
            ApplicationInfo appInfo;
            ProfilerInfo profilerInfo;
            ComponentName componentName;
            Bundle bundle;
            IInstrumentationWatcher iInstrumentationWatcher;
            IUiAutomationConnection iUiAutomationConnection;
            boolean z;
            long uptimeMillis;
            boolean badApp;
            boolean didSomething;
            AppDeathRecipient appDeathRecipient = new AppDeathRecipient(app, pid, thread);
            thread.asBinder().linkToDeath(appDeathRecipient, MY_PID);
            app.deathRecipient = appDeathRecipient;
            Object[] objArr = new Object[SHOW_FACTORY_ERROR_MSG];
            objArr[MY_PID] = Integer.valueOf(app.userId);
            objArr[SHOW_ERROR_MSG] = Integer.valueOf(app.pid);
            objArr[SHOW_NOT_RESPONDING_MSG] = app.processName;
            EventLog.writeEvent(EventLogTags.AM_PROC_BOUND, objArr);
            app.makeActive(thread, this.mProcessStats);
            app.setAdj = -100;
            app.curAdj = -100;
            app.setSchedGroup = -1;
            app.curSchedGroup = -1;
            app.forcingToForeground = null;
            updateProcessForegroundLocked(app, VALIDATE_TOKENS, VALIDATE_TOKENS);
            app.hasShownUi = VALIDATE_TOKENS;
            app.debugging = VALIDATE_TOKENS;
            app.cached = VALIDATE_TOKENS;
            app.killedByAm = VALIDATE_TOKENS;
            this.mHandler.removeMessages(PROC_START_TIMEOUT_MSG, app);
            if (!this.mProcessesReady) {
                if (!isAllowedWhileBooting(app.info)) {
                    normalMode = VALIDATE_TOKENS;
                    providers = normalMode ? generateApplicationProvidersLocked(app) : null;
                    if (!normalMode) {
                        Slog.i(TAG, "Launching preboot mode app: " + app);
                    }
                    testMode = MY_PID;
                    if (this.mDebugApp != null && this.mDebugApp.equals(processName)) {
                        testMode = this.mWaitForDebugger ? SHOW_NOT_RESPONDING_MSG : SHOW_ERROR_MSG;
                        app.debugging = SHOW_ACTIVITY_START_TIME;
                        if (this.mDebugTransient) {
                            this.mDebugApp = this.mOrigDebugApp;
                            this.mWaitForDebugger = this.mOrigWaitForDebugger;
                        }
                    }
                    profileFile = app.instrumentationProfileFile;
                    profileFd = null;
                    samplingInterval = MY_PID;
                    profileAutoStop = VALIDATE_TOKENS;
                    if (this.mProfileApp != null && this.mProfileApp.equals(processName)) {
                        this.mProfileProc = app;
                        profileFile = this.mProfileFile;
                        profileFd = this.mProfileFd;
                        samplingInterval = this.mSamplingInterval;
                        profileAutoStop = this.mAutoStopProfiler;
                    }
                    enableOpenGlTrace = VALIDATE_TOKENS;
                    if (this.mOpenGlTraceApp != null && this.mOpenGlTraceApp.equals(processName)) {
                        enableOpenGlTrace = SHOW_ACTIVITY_START_TIME;
                        this.mOpenGlTraceApp = null;
                    }
                    isRestrictedBackupMode = VALIDATE_TOKENS;
                    if (this.mBackupTarget != null && this.mBackupAppName.equals(processName)) {
                        isRestrictedBackupMode = (this.mBackupTarget.backupMode != SHOW_NOT_RESPONDING_MSG || this.mBackupTarget.backupMode == SHOW_FACTORY_ERROR_MSG || this.mBackupTarget.backupMode == SHOW_ERROR_MSG) ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
                    }
                    ensurePackageDexOpt(app.instrumentationInfo == null ? app.instrumentationInfo.packageName : app.info.packageName);
                    if (app.instrumentationClass != null) {
                        ensurePackageDexOpt(app.instrumentationClass.getPackageName());
                    }
                    appInfo = app.instrumentationInfo == null ? app.instrumentationInfo : app.info;
                    app.compat = compatibilityInfoForPackageLocked(appInfo);
                    if (profileFd != null) {
                        profileFd = profileFd.dup();
                    }
                    if (profileFile != null) {
                        profilerInfo = null;
                    } else {
                        profilerInfo = new ProfilerInfo(profileFile, profileFd, samplingInterval, profileAutoStop);
                    }
                    componentName = app.instrumentationClass;
                    bundle = app.instrumentationArguments;
                    iInstrumentationWatcher = app.instrumentationWatcher;
                    iUiAutomationConnection = app.instrumentationUiAutomationConnection;
                    z = (isRestrictedBackupMode || !normalMode) ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
                    thread.bindApplication(processName, appInfo, providers, componentName, profilerInfo, bundle, iInstrumentationWatcher, iUiAutomationConnection, testMode, enableOpenGlTrace, z, app.persistent, new Configuration(this.mConfiguration), app.compat, getCommonServicesLocked(app.isolated), this.mCoreSettingsObserver.getCoreSettingsLocked());
                    updateLruProcessLocked(app, VALIDATE_TOKENS, null);
                    uptimeMillis = SystemClock.uptimeMillis();
                    app.lastLowMemory = uptimeMillis;
                    app.lastRequestedGc = uptimeMillis;
                    this.mPersistentStartingProcesses.remove(app);
                    this.mProcessesOnHold.remove(app);
                    badApp = VALIDATE_TOKENS;
                    didSomething = VALIDATE_TOKENS;
                    if (normalMode) {
                        try {
                            if (this.mStackSupervisor.attachApplicationLocked(app)) {
                                didSomething = SHOW_ACTIVITY_START_TIME;
                            }
                        } catch (Throwable e2) {
                            Slog.wtf(TAG, "Exception thrown launching activities in " + app, e2);
                            badApp = SHOW_ACTIVITY_START_TIME;
                        }
                    }
                    if (!badApp) {
                        try {
                            didSomething |= this.mServices.attachApplicationLocked(app, processName);
                        } catch (Throwable e22) {
                            Slog.wtf(TAG, "Exception thrown starting services in " + app, e22);
                            badApp = SHOW_ACTIVITY_START_TIME;
                        }
                    }
                    if (!badApp && isPendingBroadcastProcessLocked(pid)) {
                        didSomething |= sendPendingBroadcastsLocked(app);
                    }
                    if (!(badApp || this.mBackupTarget == null || this.mBackupTarget.appInfo.uid != app.uid)) {
                        ensurePackageDexOpt(this.mBackupTarget.appInfo.packageName);
                        thread.scheduleCreateBackupAgent(this.mBackupTarget.appInfo, compatibilityInfoForPackageLocked(this.mBackupTarget.appInfo), this.mBackupTarget.backupMode);
                    }
                    if (badApp) {
                        if (!didSomething) {
                            updateOomAdjLocked();
                        }
                        return SHOW_ACTIVITY_START_TIME;
                    }
                    app.kill("error during init", SHOW_ACTIVITY_START_TIME);
                    handleAppDiedLocked(app, VALIDATE_TOKENS, SHOW_ACTIVITY_START_TIME);
                    return VALIDATE_TOKENS;
                }
            }
            normalMode = SHOW_ACTIVITY_START_TIME;
            if (normalMode) {
            }
            if (normalMode) {
                Slog.i(TAG, "Launching preboot mode app: " + app);
            }
            testMode = MY_PID;
            try {
                if (this.mWaitForDebugger) {
                }
                app.debugging = SHOW_ACTIVITY_START_TIME;
                if (this.mDebugTransient) {
                    this.mDebugApp = this.mOrigDebugApp;
                    this.mWaitForDebugger = this.mOrigWaitForDebugger;
                }
                profileFile = app.instrumentationProfileFile;
                profileFd = null;
                samplingInterval = MY_PID;
                profileAutoStop = VALIDATE_TOKENS;
                this.mProfileProc = app;
                profileFile = this.mProfileFile;
                profileFd = this.mProfileFd;
                samplingInterval = this.mSamplingInterval;
                profileAutoStop = this.mAutoStopProfiler;
                enableOpenGlTrace = VALIDATE_TOKENS;
                enableOpenGlTrace = SHOW_ACTIVITY_START_TIME;
                this.mOpenGlTraceApp = null;
                isRestrictedBackupMode = VALIDATE_TOKENS;
                if (this.mBackupTarget.backupMode != SHOW_NOT_RESPONDING_MSG) {
                }
                if (app.instrumentationInfo == null) {
                }
                ensurePackageDexOpt(app.instrumentationInfo == null ? app.instrumentationInfo.packageName : app.info.packageName);
                if (app.instrumentationClass != null) {
                    ensurePackageDexOpt(app.instrumentationClass.getPackageName());
                }
                if (app.instrumentationInfo == null) {
                }
                app.compat = compatibilityInfoForPackageLocked(appInfo);
                if (profileFd != null) {
                    profileFd = profileFd.dup();
                }
                if (profileFile != null) {
                    profilerInfo = new ProfilerInfo(profileFile, profileFd, samplingInterval, profileAutoStop);
                } else {
                    profilerInfo = null;
                }
                componentName = app.instrumentationClass;
                bundle = app.instrumentationArguments;
                iInstrumentationWatcher = app.instrumentationWatcher;
                iUiAutomationConnection = app.instrumentationUiAutomationConnection;
                if (!isRestrictedBackupMode) {
                }
                thread.bindApplication(processName, appInfo, providers, componentName, profilerInfo, bundle, iInstrumentationWatcher, iUiAutomationConnection, testMode, enableOpenGlTrace, z, app.persistent, new Configuration(this.mConfiguration), app.compat, getCommonServicesLocked(app.isolated), this.mCoreSettingsObserver.getCoreSettingsLocked());
                updateLruProcessLocked(app, VALIDATE_TOKENS, null);
                uptimeMillis = SystemClock.uptimeMillis();
                app.lastLowMemory = uptimeMillis;
                app.lastRequestedGc = uptimeMillis;
                this.mPersistentStartingProcesses.remove(app);
                this.mProcessesOnHold.remove(app);
                badApp = VALIDATE_TOKENS;
                didSomething = VALIDATE_TOKENS;
                if (normalMode) {
                    if (this.mStackSupervisor.attachApplicationLocked(app)) {
                        didSomething = SHOW_ACTIVITY_START_TIME;
                    }
                }
                if (badApp) {
                    didSomething |= this.mServices.attachApplicationLocked(app, processName);
                }
                try {
                    didSomething |= sendPendingBroadcastsLocked(app);
                } catch (Throwable e222) {
                    Slog.wtf(TAG, "Exception thrown dispatching broadcasts in " + app, e222);
                    badApp = SHOW_ACTIVITY_START_TIME;
                }
                ensurePackageDexOpt(this.mBackupTarget.appInfo.packageName);
                try {
                    thread.scheduleCreateBackupAgent(this.mBackupTarget.appInfo, compatibilityInfoForPackageLocked(this.mBackupTarget.appInfo), this.mBackupTarget.backupMode);
                } catch (Throwable e2222) {
                    Slog.wtf(TAG, "Exception thrown creating backup agent in " + app, e2222);
                    badApp = SHOW_ACTIVITY_START_TIME;
                }
                if (badApp) {
                    if (didSomething) {
                        updateOomAdjLocked();
                    }
                    return SHOW_ACTIVITY_START_TIME;
                }
                app.kill("error during init", SHOW_ACTIVITY_START_TIME);
                handleAppDiedLocked(app, VALIDATE_TOKENS, SHOW_ACTIVITY_START_TIME);
                return VALIDATE_TOKENS;
            } catch (Throwable e22222) {
                Slog.wtf(TAG, "Exception thrown during bind of " + app, e22222);
                app.resetPackageList(this.mProcessStats);
                app.unlinkDeathRecipient();
                startProcessLocked(app, "bind fail", processName);
                return VALIDATE_TOKENS;
            }
        } catch (RemoteException e3) {
            app.resetPackageList(this.mProcessStats);
            startProcessLocked(app, "link fail", processName);
            return VALIDATE_TOKENS;
        }
    }

    public final void attachApplication(IApplicationThread thread) {
        synchronized (this) {
            int callingPid = Binder.getCallingPid();
            long origId = Binder.clearCallingIdentity();
            attachApplicationLocked(thread, callingPid);
            Binder.restoreCallingIdentity(origId);
        }
    }

    public final void activityIdle(IBinder token, Configuration config, boolean stopProfiling) {
        long origId = Binder.clearCallingIdentity();
        synchronized (this) {
            if (ActivityRecord.getStackLocked(token) != null) {
                ActivityRecord r = this.mStackSupervisor.activityIdleInternalLocked(token, VALIDATE_TOKENS, config);
                if (stopProfiling && this.mProfileProc == r.app && this.mProfileFd != null) {
                    try {
                        this.mProfileFd.close();
                    } catch (IOException e) {
                    }
                    clearProfilerLocked();
                }
            }
        }
        Binder.restoreCallingIdentity(origId);
    }

    void postFinishBooting(boolean finishBooting, boolean enableScreen) {
        int i;
        int i2 = SHOW_ERROR_MSG;
        MainHandler mainHandler = this.mHandler;
        MainHandler mainHandler2 = this.mHandler;
        if (finishBooting) {
            i = SHOW_ERROR_MSG;
        } else {
            i = MY_PID;
        }
        if (!enableScreen) {
            i2 = MY_PID;
        }
        mainHandler.sendMessage(mainHandler2.obtainMessage(FINISH_BOOTING_MSG, i, i2));
    }

    void enableScreenAfterBoot() {
        EventLog.writeEvent(EventLogTags.BOOT_PROGRESS_ENABLE_SCREEN, SystemClock.uptimeMillis());
        this.mWindowManager.enableScreenAfterBoot();
        synchronized (this) {
            updateEventDispatchingLocked();
        }
    }

    public void showBootMessage(CharSequence msg, boolean always) {
        enforceNotIsolatedCaller("showBootMessage");
        this.mWindowManager.showBootMessage(msg, always);
    }

    public void keyguardWaitingForActivityDrawn() {
        enforceNotIsolatedCaller("keyguardWaitingForActivityDrawn");
        long token = Binder.clearCallingIdentity();
        try {
            synchronized (this) {
                this.mWindowManager.keyguardWaitingForActivityDrawn();
                if (this.mLockScreenShown == SHOW_NOT_RESPONDING_MSG) {
                    this.mLockScreenShown = SHOW_ERROR_MSG;
                    updateSleepIfNeededLocked();
                }
            }
        } finally {
            Binder.restoreCallingIdentity(token);
        }
    }

    final void finishBooting() {
        synchronized (this) {
            if (this.mBootAnimationComplete) {
                this.mCallFinishBooting = VALIDATE_TOKENS;
                ArraySet<String> completedIsas = new ArraySet();
                String[] arr$ = Build.SUPPORTED_ABIS;
                int len$ = arr$.length;
                for (int i$ = MY_PID; i$ < len$; i$ += SHOW_ERROR_MSG) {
                    String abi = arr$[i$];
                    Process.establishZygoteConnectionForAbi(abi);
                    String instructionSet = VMRuntime.getInstructionSet(abi);
                    if (!completedIsas.contains(instructionSet)) {
                        if (this.mInstaller.markBootComplete(VMRuntime.getInstructionSet(abi)) != 0) {
                            Slog.e(TAG, "Unable to mark boot complete for abi: " + abi);
                        }
                        completedIsas.add(instructionSet);
                    }
                }
                IntentFilter pkgFilter = new IntentFilter();
                pkgFilter.addAction("android.intent.action.QUERY_PACKAGE_RESTART");
                pkgFilter.addDataScheme("package");
                this.mContext.registerReceiver(new C01297(), pkgFilter);
                this.mSystemServiceManager.startBootPhase(NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY);
                synchronized (this) {
                    int NP = this.mProcessesOnHold.size();
                    if (NP > 0) {
                        ArrayList<ProcessRecord> arrayList = new ArrayList(this.mProcessesOnHold);
                        for (int ip = MY_PID; ip < NP; ip += SHOW_ERROR_MSG) {
                            startProcessLocked((ProcessRecord) arrayList.get(ip), "on-hold", null);
                        }
                    }
                    if (this.mFactoryTest != SHOW_ERROR_MSG) {
                        this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(CHECK_EXCESSIVE_WAKE_LOCKS_MSG), 900000);
                        SystemProperties.set("sys.boot_completed", "1");
                        if (!"trigger_restart_min_framework".equals(SystemProperties.get("vold.decrypt")) || "".equals(SystemProperties.get("vold.encrypt_progress"))) {
                            SystemProperties.set("dev.bootcomplete", "1");
                        }
                        for (int i = MY_PID; i < this.mStartedUsers.size(); i += SHOW_ERROR_MSG) {
                            UserStartedState uss = (UserStartedState) this.mStartedUsers.valueAt(i);
                            if (uss.mState == 0) {
                                uss.mState = SHOW_ERROR_MSG;
                                int userId = this.mStartedUsers.keyAt(i);
                                Intent intent = new Intent("android.intent.action.BOOT_COMPLETED", null);
                                intent.putExtra("android.intent.extra.user_handle", userId);
                                intent.addFlags(134217728);
                                broadcastIntentLocked(null, null, intent, null, new C01308(), MY_PID, null, null, "android.permission.RECEIVE_BOOT_COMPLETED", 53, SHOW_ACTIVITY_START_TIME, VALIDATE_TOKENS, MY_PID, NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY, userId);
                            }
                        }
                        scheduleStartProfilesLocked();
                    }
                }
                return;
            }
            this.mCallFinishBooting = SHOW_ACTIVITY_START_TIME;
        }
    }

    public void bootAnimationComplete() {
        synchronized (this) {
            boolean callFinishBooting = this.mCallFinishBooting;
            this.mBootAnimationComplete = SHOW_ACTIVITY_START_TIME;
        }
        if (callFinishBooting) {
            finishBooting();
        }
    }

    public void systemBackupRestored() {
        synchronized (this) {
            if (this.mSystemReady) {
                this.mTaskPersister.restoreTasksFromOtherDeviceLocked();
            } else {
                Slog.w(TAG, "System backup restored before system is ready");
            }
        }
    }

    final void ensureBootCompleted() {
        boolean enableScreen = SHOW_ACTIVITY_START_TIME;
        synchronized (this) {
            boolean booting = this.mBooting;
            this.mBooting = VALIDATE_TOKENS;
            if (this.mBooted) {
                enableScreen = VALIDATE_TOKENS;
            }
            this.mBooted = SHOW_ACTIVITY_START_TIME;
        }
        if (booting) {
            finishBooting();
        }
        if (enableScreen) {
            enableScreenAfterBoot();
        }
    }

    public final void activityResumed(IBinder token) {
        long origId = Binder.clearCallingIdentity();
        synchronized (this) {
            if (ActivityRecord.getStackLocked(token) != null) {
                ActivityRecord.activityResumedLocked(token);
            }
        }
        Binder.restoreCallingIdentity(origId);
    }

    public final void activityPaused(IBinder token) {
        long origId = Binder.clearCallingIdentity();
        synchronized (this) {
            ActivityStack stack = ActivityRecord.getStackLocked(token);
            if (stack != null) {
                stack.activityPausedLocked(token, VALIDATE_TOKENS);
            }
        }
        Binder.restoreCallingIdentity(origId);
    }

    public final void activityStopped(IBinder token, Bundle icicle, PersistableBundle persistentState, CharSequence description) {
        if (icicle == null || !icicle.hasFileDescriptors()) {
            long origId = Binder.clearCallingIdentity();
            synchronized (this) {
                ActivityRecord r = ActivityRecord.isInStackLocked(token);
                if (r != null) {
                    r.task.stack.activityStoppedLocked(r, icicle, persistentState, description);
                }
            }
            trimApplications();
            Binder.restoreCallingIdentity(origId);
            return;
        }
        throw new IllegalArgumentException("File descriptors passed in Bundle");
    }

    public final void activityDestroyed(IBinder token) {
        synchronized (this) {
            ActivityStack stack = ActivityRecord.getStackLocked(token);
            if (stack != null) {
                stack.activityDestroyedLocked(token, "activityDestroyed");
            }
        }
    }

    public final void backgroundResourcesReleased(IBinder token) {
        long origId = Binder.clearCallingIdentity();
        try {
            synchronized (this) {
                ActivityStack stack = ActivityRecord.getStackLocked(token);
                if (stack != null) {
                    stack.backgroundResourcesReleased();
                }
            }
        } finally {
            Binder.restoreCallingIdentity(origId);
        }
    }

    public final void notifyLaunchTaskBehindComplete(IBinder token) {
        this.mStackSupervisor.scheduleLaunchTaskBehindComplete(token);
    }

    public final void notifyEnterAnimationComplete(IBinder token) {
        this.mHandler.sendMessage(this.mHandler.obtainMessage(ENTER_ANIMATION_COMPLETE_MSG, token));
    }

    public String getCallingPackage(IBinder token) {
        String str;
        synchronized (this) {
            ActivityRecord r = getCallingRecordLocked(token);
            str = r != null ? r.info.packageName : null;
        }
        return str;
    }

    public ComponentName getCallingActivity(IBinder token) {
        ComponentName component;
        synchronized (this) {
            ActivityRecord r = getCallingRecordLocked(token);
            component = r != null ? r.intent.getComponent() : null;
        }
        return component;
    }

    private ActivityRecord getCallingRecordLocked(IBinder token) {
        ActivityRecord r = ActivityRecord.isInStackLocked(token);
        if (r == null) {
            return null;
        }
        return r.resultTo;
    }

    public ComponentName getActivityClassForToken(IBinder token) {
        ComponentName componentName;
        synchronized (this) {
            ActivityRecord r = ActivityRecord.isInStackLocked(token);
            if (r == null) {
                componentName = null;
            } else {
                componentName = r.intent.getComponent();
            }
        }
        return componentName;
    }

    public String getPackageForToken(IBinder token) {
        String str;
        synchronized (this) {
            ActivityRecord r = ActivityRecord.isInStackLocked(token);
            if (r == null) {
                str = null;
            } else {
                str = r.packageName;
            }
        }
        return str;
    }

    public IIntentSender getIntentSender(int type, String packageName, IBinder token, String resultWho, int requestCode, Intent[] intents, String[] resolvedTypes, int flags, Bundle options, int userId) {
        enforceNotIsolatedCaller("getIntentSender");
        if (intents != null) {
            if (intents.length < SHOW_ERROR_MSG) {
                throw new IllegalArgumentException("Intents array length must be >= 1");
            }
            for (int i = MY_PID; i < intents.length; i += SHOW_ERROR_MSG) {
                Intent intent = intents[i];
                if (intent != null) {
                    if (intent.hasFileDescriptors()) {
                        throw new IllegalArgumentException("File descriptors passed in Intent");
                    } else if (type != SHOW_ERROR_MSG || (intent.getFlags() & 33554432) == 0) {
                        intents[i] = new Intent(intent);
                    } else {
                        throw new IllegalArgumentException("Can't use FLAG_RECEIVER_BOOT_UPGRADE here");
                    }
                }
            }
            if (!(resolvedTypes == null || resolvedTypes.length == intents.length)) {
                throw new IllegalArgumentException("Intent array length does not match resolvedTypes length");
            }
        }
        if (options == null || !options.hasFileDescriptors()) {
            IIntentSender intentSenderLocked;
            synchronized (this) {
                int callingUid = Binder.getCallingUid();
                int origUserId = userId;
                userId = handleIncomingUser(Binder.getCallingPid(), callingUid, userId, type == SHOW_ERROR_MSG ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS, (int) MY_PID, "getIntentSender", null);
                if (origUserId == -2) {
                    userId = -2;
                }
                if (!(callingUid == 0 || callingUid == NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY)) {
                    try {
                        int uid = AppGlobals.getPackageManager().getPackageUid(packageName, UserHandle.getUserId(callingUid));
                        if (!UserHandle.isSameApp(callingUid, uid)) {
                            String msg = "Permission Denial: getIntentSender() from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + ", (need uid=" + uid + ")" + " is not allowed to send as package " + packageName;
                            Slog.w(TAG, msg);
                            throw new SecurityException(msg);
                        }
                    } catch (Throwable e) {
                        throw new SecurityException(e);
                    }
                }
                intentSenderLocked = getIntentSenderLocked(type, packageName, callingUid, userId, token, resultWho, requestCode, intents, resolvedTypes, flags, options);
            }
            return intentSenderLocked;
        }
        throw new IllegalArgumentException("File descriptors passed in options");
    }

    IIntentSender getIntentSenderLocked(int type, String packageName, int callingUid, int userId, IBinder token, String resultWho, int requestCode, Intent[] intents, String[] resolvedTypes, int flags, Bundle options) {
        ActivityRecord activity = null;
        if (type == SHOW_FACTORY_ERROR_MSG) {
            activity = ActivityRecord.isInStackLocked(token);
            if (activity == null) {
                return null;
            }
            if (activity.finishing) {
                return null;
            }
        }
        boolean noCreate = (536870912 & flags) != 0 ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
        boolean cancelCurrent = (268435456 & flags) != 0 ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
        boolean updateCurrent = (134217728 & flags) != 0 ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
        Key key = new Key(type, packageName, activity, resultWho, requestCode, intents, resolvedTypes, flags & -939524097, options, userId);
        WeakReference<PendingIntentRecord> ref = (WeakReference) this.mIntentSenderRecords.get(key);
        IIntentSender rec = ref != null ? (PendingIntentRecord) ref.get() : null;
        if (rec != null) {
            if (cancelCurrent) {
                rec.canceled = SHOW_ACTIVITY_START_TIME;
                this.mIntentSenderRecords.remove(key);
            } else if (!updateCurrent) {
                return rec;
            } else {
                if (rec.key.requestIntent != null) {
                    rec.key.requestIntent.replaceExtras(intents != null ? intents[intents.length - 1] : null);
                }
                if (intents != null) {
                    intents[intents.length - 1] = rec.key.requestIntent;
                    rec.key.allIntents = intents;
                    rec.key.allResolvedTypes = resolvedTypes;
                    return rec;
                }
                rec.key.allIntents = null;
                rec.key.allResolvedTypes = null;
                return rec;
            }
        }
        if (noCreate) {
            return rec;
        }
        rec = new PendingIntentRecord(this, key, callingUid);
        this.mIntentSenderRecords.put(key, rec.ref);
        if (type != SHOW_FACTORY_ERROR_MSG) {
            return rec;
        }
        if (activity.pendingResults == null) {
            activity.pendingResults = new HashSet();
        }
        activity.pendingResults.add(rec.ref);
        return rec;
    }

    public void cancelIntentSender(IIntentSender sender) {
        if (sender instanceof PendingIntentRecord) {
            synchronized (this) {
                PendingIntentRecord rec = (PendingIntentRecord) sender;
                try {
                    if (UserHandle.isSameApp(AppGlobals.getPackageManager().getPackageUid(rec.key.packageName, UserHandle.getCallingUserId()), Binder.getCallingUid())) {
                        cancelIntentSenderLocked(rec, SHOW_ACTIVITY_START_TIME);
                    } else {
                        String msg = "Permission Denial: cancelIntentSender() from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " is not allowed to cancel packges " + rec.key.packageName;
                        Slog.w(TAG, msg);
                        throw new SecurityException(msg);
                    }
                } catch (RemoteException e) {
                    throw new SecurityException(e);
                }
            }
        }
    }

    void cancelIntentSenderLocked(PendingIntentRecord rec, boolean cleanActivity) {
        rec.canceled = SHOW_ACTIVITY_START_TIME;
        this.mIntentSenderRecords.remove(rec.key);
        if (cleanActivity && rec.key.activity != null) {
            rec.key.activity.pendingResults.remove(rec.ref);
        }
    }

    public String getPackageForIntentSender(IIntentSender pendingResult) {
        String str = null;
        if (pendingResult instanceof PendingIntentRecord) {
            try {
                str = ((PendingIntentRecord) pendingResult).key.packageName;
            } catch (ClassCastException e) {
            }
        }
        return str;
    }

    public int getUidForIntentSender(IIntentSender sender) {
        if (sender instanceof PendingIntentRecord) {
            try {
                return ((PendingIntentRecord) sender).uid;
            } catch (ClassCastException e) {
            }
        }
        return -1;
    }

    public boolean isIntentSenderTargetedToPackage(IIntentSender pendingResult) {
        if (!(pendingResult instanceof PendingIntentRecord)) {
            return VALIDATE_TOKENS;
        }
        try {
            PendingIntentRecord res = (PendingIntentRecord) pendingResult;
            if (res.key.allIntents == null) {
                return VALIDATE_TOKENS;
            }
            for (int i = MY_PID; i < res.key.allIntents.length; i += SHOW_ERROR_MSG) {
                Intent intent = res.key.allIntents[i];
                if (intent.getPackage() != null && intent.getComponent() != null) {
                    return VALIDATE_TOKENS;
                }
            }
            return SHOW_ACTIVITY_START_TIME;
        } catch (ClassCastException e) {
            return VALIDATE_TOKENS;
        }
    }

    public boolean isIntentSenderAnActivity(IIntentSender pendingResult) {
        if (!(pendingResult instanceof PendingIntentRecord)) {
            return VALIDATE_TOKENS;
        }
        try {
            if (((PendingIntentRecord) pendingResult).key.type == SHOW_NOT_RESPONDING_MSG) {
                return SHOW_ACTIVITY_START_TIME;
            }
            return VALIDATE_TOKENS;
        } catch (ClassCastException e) {
            return VALIDATE_TOKENS;
        }
    }

    public Intent getIntentForIntentSender(IIntentSender pendingResult) {
        if (!(pendingResult instanceof PendingIntentRecord)) {
            return null;
        }
        try {
            PendingIntentRecord res = (PendingIntentRecord) pendingResult;
            return res.key.requestIntent != null ? new Intent(res.key.requestIntent) : null;
        } catch (ClassCastException e) {
            return null;
        }
    }

    public String getTagForIntentSender(IIntentSender pendingResult, String prefix) {
        if (!(pendingResult instanceof PendingIntentRecord)) {
            return null;
        }
        try {
            PendingIntentRecord res = (PendingIntentRecord) pendingResult;
            Intent intent = res.key.requestIntent;
            if (intent == null) {
                return null;
            }
            if (res.lastTag != null && res.lastTagPrefix == prefix && (res.lastTagPrefix == null || res.lastTagPrefix.equals(prefix))) {
                return res.lastTag;
            }
            res.lastTagPrefix = prefix;
            StringBuilder sb = new StringBuilder(MAX_PERSISTED_URI_GRANTS);
            if (prefix != null) {
                sb.append(prefix);
            }
            if (intent.getAction() != null) {
                sb.append(intent.getAction());
            } else if (intent.getComponent() != null) {
                intent.getComponent().appendShortString(sb);
            } else {
                sb.append("?");
            }
            String stringBuilder = sb.toString();
            res.lastTag = stringBuilder;
            return stringBuilder;
        } catch (ClassCastException e) {
            return null;
        }
    }

    public void setProcessLimit(int max) {
        enforceCallingPermission("android.permission.SET_PROCESS_LIMIT", "setProcessLimit()");
        synchronized (this) {
            int i;
            if (max < 0) {
                i = ProcessList.MAX_CACHED_APPS;
            } else {
                i = max;
            }
            this.mProcessLimit = i;
            this.mProcessLimitOverride = max;
        }
        trimApplications();
    }

    public int getProcessLimit() {
        int i;
        synchronized (this) {
            i = this.mProcessLimitOverride;
        }
        return i;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    void foregroundTokenDied(com.android.server.am.ActivityManagerService.ForegroundToken r6) {
        /*
        r5 = this;
        monitor-enter(r5);
        r3 = r5.mPidsSelfLocked;	 Catch:{ all -> 0x0029 }
        monitor-enter(r3);	 Catch:{ all -> 0x0029 }
        r2 = r5.mForegroundProcesses;	 Catch:{ all -> 0x003a }
        r4 = r6.pid;	 Catch:{ all -> 0x003a }
        r0 = r2.get(r4);	 Catch:{ all -> 0x003a }
        r0 = (com.android.server.am.ActivityManagerService.ForegroundToken) r0;	 Catch:{ all -> 0x003a }
        if (r0 == r6) goto L_0x0013;
    L_0x0010:
        monitor-exit(r3);	 Catch:{ all -> 0x003a }
        monitor-exit(r5);	 Catch:{ all -> 0x0029 }
    L_0x0012:
        return;
    L_0x0013:
        r2 = r5.mForegroundProcesses;	 Catch:{ all -> 0x003a }
        r4 = r6.pid;	 Catch:{ all -> 0x003a }
        r2.remove(r4);	 Catch:{ all -> 0x003a }
        r2 = r5.mPidsSelfLocked;	 Catch:{ all -> 0x003a }
        r4 = r6.pid;	 Catch:{ all -> 0x003a }
        r1 = r2.get(r4);	 Catch:{ all -> 0x003a }
        r1 = (com.android.server.am.ProcessRecord) r1;	 Catch:{ all -> 0x003a }
        if (r1 != 0) goto L_0x002c;
    L_0x0026:
        monitor-exit(r3);	 Catch:{ all -> 0x003a }
        monitor-exit(r5);	 Catch:{ all -> 0x0029 }
        goto L_0x0012;
    L_0x0029:
        r2 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x0029 }
        throw r2;
    L_0x002c:
        r2 = 0;
        r1.forcingToForeground = r2;	 Catch:{ all -> 0x003a }
        r2 = 0;
        r4 = 0;
        r5.updateProcessForegroundLocked(r1, r2, r4);	 Catch:{ all -> 0x003a }
        monitor-exit(r3);	 Catch:{ all -> 0x003a }
        r5.updateOomAdjLocked();	 Catch:{ all -> 0x0029 }
        monitor-exit(r5);	 Catch:{ all -> 0x0029 }
        goto L_0x0012;
    L_0x003a:
        r2 = move-exception;
        monitor-exit(r3);	 Catch:{ all -> 0x003a }
        throw r2;	 Catch:{ all -> 0x0029 }
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.ActivityManagerService.foregroundTokenDied(com.android.server.am.ActivityManagerService$ForegroundToken):void");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void setProcessForeground(android.os.IBinder r9, int r10, boolean r11) {
        /*
        r8 = this;
        r4 = "android.permission.SET_PROCESS_LIMIT";
        r5 = "setProcessForeground()";
        r8.enforceCallingPermission(r4, r5);
        monitor-enter(r8);
        r0 = 0;
        r5 = r8.mPidsSelfLocked;	 Catch:{ all -> 0x006f }
        monitor-enter(r5);	 Catch:{ all -> 0x006f }
        r4 = r8.mPidsSelfLocked;	 Catch:{ all -> 0x0072 }
        r3 = r4.get(r10);	 Catch:{ all -> 0x0072 }
        r3 = (com.android.server.am.ProcessRecord) r3;	 Catch:{ all -> 0x0072 }
        if (r3 != 0) goto L_0x0033;
    L_0x0016:
        if (r11 == 0) goto L_0x0033;
    L_0x0018:
        r4 = "ActivityManager";
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0072 }
        r6.<init>();	 Catch:{ all -> 0x0072 }
        r7 = "setProcessForeground called on unknown pid: ";
        r6 = r6.append(r7);	 Catch:{ all -> 0x0072 }
        r6 = r6.append(r10);	 Catch:{ all -> 0x0072 }
        r6 = r6.toString();	 Catch:{ all -> 0x0072 }
        android.util.Slog.w(r4, r6);	 Catch:{ all -> 0x0072 }
        monitor-exit(r5);	 Catch:{ all -> 0x0072 }
        monitor-exit(r8);	 Catch:{ all -> 0x006f }
    L_0x0032:
        return;
    L_0x0033:
        r4 = r8.mForegroundProcesses;	 Catch:{ all -> 0x0072 }
        r2 = r4.get(r10);	 Catch:{ all -> 0x0072 }
        r2 = (com.android.server.am.ActivityManagerService.ForegroundToken) r2;	 Catch:{ all -> 0x0072 }
        if (r2 == 0) goto L_0x004e;
    L_0x003d:
        r4 = r2.token;	 Catch:{ all -> 0x0072 }
        r6 = 0;
        r4.unlinkToDeath(r2, r6);	 Catch:{ all -> 0x0072 }
        r4 = r8.mForegroundProcesses;	 Catch:{ all -> 0x0072 }
        r4.remove(r10);	 Catch:{ all -> 0x0072 }
        if (r3 == 0) goto L_0x004d;
    L_0x004a:
        r4 = 0;
        r3.forcingToForeground = r4;	 Catch:{ all -> 0x0072 }
    L_0x004d:
        r0 = 1;
    L_0x004e:
        if (r11 == 0) goto L_0x0067;
    L_0x0050:
        if (r9 == 0) goto L_0x0067;
    L_0x0052:
        r1 = new com.android.server.am.ActivityManagerService$9;	 Catch:{ all -> 0x0072 }
        r1.<init>();	 Catch:{ all -> 0x0072 }
        r1.pid = r10;	 Catch:{ all -> 0x0072 }
        r1.token = r9;	 Catch:{ all -> 0x0072 }
        r4 = 0;
        r9.linkToDeath(r1, r4);	 Catch:{ RemoteException -> 0x0075 }
        r4 = r8.mForegroundProcesses;	 Catch:{ RemoteException -> 0x0075 }
        r4.put(r10, r1);	 Catch:{ RemoteException -> 0x0075 }
        r3.forcingToForeground = r9;	 Catch:{ RemoteException -> 0x0075 }
        r0 = 1;
    L_0x0067:
        monitor-exit(r5);	 Catch:{ all -> 0x0072 }
        if (r0 == 0) goto L_0x006d;
    L_0x006a:
        r8.updateOomAdjLocked();	 Catch:{ all -> 0x006f }
    L_0x006d:
        monitor-exit(r8);	 Catch:{ all -> 0x006f }
        goto L_0x0032;
    L_0x006f:
        r4 = move-exception;
        monitor-exit(r8);	 Catch:{ all -> 0x006f }
        throw r4;
    L_0x0072:
        r4 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x0072 }
        throw r4;	 Catch:{ all -> 0x006f }
    L_0x0075:
        r4 = move-exception;
        goto L_0x0067;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.ActivityManagerService.setProcessForeground(android.os.IBinder, int, boolean):void");
    }

    int checkComponentPermission(String permission, int pid, int uid, int owningUid, boolean exported) {
        if (pid == MY_PID) {
            return MY_PID;
        }
        return ActivityManager.checkComponentPermission(permission, uid, owningUid, exported);
    }

    public int checkPermission(String permission, int pid, int uid) {
        if (permission == null) {
            return -1;
        }
        return checkComponentPermission(permission, pid, UserHandle.getAppId(uid), -1, SHOW_ACTIVITY_START_TIME);
    }

    public int checkPermissionWithToken(String permission, int pid, int uid, IBinder callerToken) {
        if (permission == null) {
            return -1;
        }
        Identity tlsIdentity = (Identity) sCallerIdentity.get();
        if (tlsIdentity != null && tlsIdentity.token == callerToken) {
            Slog.d(TAG, "checkComponentPermission() adjusting {pid,uid} to {" + tlsIdentity.pid + "," + tlsIdentity.uid + "}");
            uid = tlsIdentity.uid;
            pid = tlsIdentity.pid;
        }
        return checkComponentPermission(permission, pid, UserHandle.getAppId(uid), -1, SHOW_ACTIVITY_START_TIME);
    }

    int checkCallingPermission(String permission) {
        return checkPermission(permission, Binder.getCallingPid(), UserHandle.getAppId(Binder.getCallingUid()));
    }

    void enforceCallingPermission(String permission, String func) {
        if (checkCallingPermission(permission) != 0) {
            String msg = "Permission Denial: " + func + " from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " requires " + permission;
            Slog.w(TAG, msg);
            throw new SecurityException(msg);
        }
    }

    private final boolean checkHoldingPermissionsLocked(IPackageManager pm, ProviderInfo pi, GrantUri grantUri, int uid, int modeFlags) {
        if (UserHandle.getUserId(uid) == grantUri.sourceUserId || ActivityManager.checkComponentPermission("android.permission.INTERACT_ACROSS_USERS", uid, -1, SHOW_ACTIVITY_START_TIME) == 0) {
            return checkHoldingPermissionsInternalLocked(pm, pi, grantUri, uid, modeFlags, SHOW_ACTIVITY_START_TIME);
        }
        return VALIDATE_TOKENS;
    }

    private final boolean checkHoldingPermissionsInternalLocked(IPackageManager pm, ProviderInfo pi, GrantUri grantUri, int uid, int modeFlags, boolean considerUidPermissions) {
        if (pi.applicationInfo.uid == uid) {
            return SHOW_ACTIVITY_START_TIME;
        }
        if (!pi.exported) {
            return VALIDATE_TOKENS;
        }
        boolean readMet = (modeFlags & SHOW_ERROR_MSG) == 0 ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
        boolean writeMet = (modeFlags & SHOW_NOT_RESPONDING_MSG) == 0 ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
        if (!readMet) {
            try {
                if (pi.readPermission != null && considerUidPermissions && pm.checkUidPermission(pi.readPermission, uid) == 0) {
                    readMet = SHOW_ACTIVITY_START_TIME;
                }
            } catch (RemoteException e) {
                return VALIDATE_TOKENS;
            }
        }
        if (!writeMet && pi.writePermission != null && considerUidPermissions && pm.checkUidPermission(pi.writePermission, uid) == 0) {
            writeMet = SHOW_ACTIVITY_START_TIME;
        }
        boolean allowDefaultRead = pi.readPermission == null ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
        boolean allowDefaultWrite = pi.writePermission == null ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
        PathPermission[] pps = pi.pathPermissions;
        if (pps != null) {
            String path = grantUri.uri.getPath();
            int i = pps.length;
            while (i > 0 && (!readMet || !writeMet)) {
                i--;
                PathPermission pp = pps[i];
                if (pp.match(path)) {
                    if (!readMet) {
                        String pprperm = pp.getReadPermission();
                        if (pprperm != null) {
                            if (considerUidPermissions && pm.checkUidPermission(pprperm, uid) == 0) {
                                readMet = SHOW_ACTIVITY_START_TIME;
                            } else {
                                allowDefaultRead = VALIDATE_TOKENS;
                            }
                        }
                    }
                    if (!writeMet) {
                        String ppwperm = pp.getWritePermission();
                        if (ppwperm != null) {
                            if (considerUidPermissions && pm.checkUidPermission(ppwperm, uid) == 0) {
                                writeMet = SHOW_ACTIVITY_START_TIME;
                            } else {
                                allowDefaultWrite = VALIDATE_TOKENS;
                            }
                        }
                    }
                }
            }
        }
        if (allowDefaultRead) {
            readMet = SHOW_ACTIVITY_START_TIME;
        }
        if (allowDefaultWrite) {
            writeMet = SHOW_ACTIVITY_START_TIME;
        }
        return (readMet && writeMet) ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
    }

    private ProviderInfo getProviderInfoLocked(String authority, int userHandle) {
        ProviderInfo pi = null;
        ContentProviderRecord cpr = this.mProviderMap.getProviderByName(authority, userHandle);
        if (cpr != null) {
            return cpr.info;
        }
        try {
            return AppGlobals.getPackageManager().resolveContentProvider(authority, DumpState.DUMP_KEYSETS, userHandle);
        } catch (RemoteException e) {
            return pi;
        }
    }

    private UriPermission findUriPermissionLocked(int targetUid, GrantUri grantUri) {
        ArrayMap<GrantUri, UriPermission> targetUris = (ArrayMap) this.mGrantedUriPermissions.get(targetUid);
        if (targetUris != null) {
            return (UriPermission) targetUris.get(grantUri);
        }
        return null;
    }

    private UriPermission findOrCreateUriPermissionLocked(String sourcePkg, String targetPkg, int targetUid, GrantUri grantUri) {
        ArrayMap<GrantUri, UriPermission> targetUris = (ArrayMap) this.mGrantedUriPermissions.get(targetUid);
        if (targetUris == null) {
            targetUris = Maps.newArrayMap();
            this.mGrantedUriPermissions.put(targetUid, targetUris);
        }
        UriPermission perm = (UriPermission) targetUris.get(grantUri);
        if (perm != null) {
            return perm;
        }
        perm = new UriPermission(sourcePkg, targetPkg, targetUid, grantUri);
        targetUris.put(grantUri, perm);
        return perm;
    }

    private final boolean checkUriPermissionLocked(GrantUri grantUri, int uid, int modeFlags) {
        boolean persistable;
        if ((modeFlags & 64) != 0) {
            persistable = SHOW_ACTIVITY_START_TIME;
        } else {
            persistable = VALIDATE_TOKENS;
        }
        int minStrength;
        if (persistable) {
            minStrength = SHOW_FACTORY_ERROR_MSG;
        } else {
            minStrength = SHOW_ERROR_MSG;
        }
        if (uid == 0) {
            return SHOW_ACTIVITY_START_TIME;
        }
        ArrayMap<GrantUri, UriPermission> perms = (ArrayMap) this.mGrantedUriPermissions.get(uid);
        if (perms == null) {
            return VALIDATE_TOKENS;
        }
        UriPermission exactPerm = (UriPermission) perms.get(grantUri);
        if (exactPerm != null && exactPerm.getStrength(modeFlags) >= minStrength) {
            return SHOW_ACTIVITY_START_TIME;
        }
        int N = perms.size();
        for (int i = MY_PID; i < N; i += SHOW_ERROR_MSG) {
            UriPermission perm = (UriPermission) perms.valueAt(i);
            if (perm.uri.prefix && grantUri.uri.isPathPrefixMatch(perm.uri.uri) && perm.getStrength(modeFlags) >= minStrength) {
                return SHOW_ACTIVITY_START_TIME;
            }
        }
        return VALIDATE_TOKENS;
    }

    public int checkUriPermission(Uri uri, int pid, int uid, int modeFlags, int userId, IBinder callerToken) {
        int i = MY_PID;
        enforceNotIsolatedCaller("checkUriPermission");
        Identity tlsIdentity = (Identity) sCallerIdentity.get();
        if (tlsIdentity != null && tlsIdentity.token == callerToken) {
            uid = tlsIdentity.uid;
            pid = tlsIdentity.pid;
        }
        if (pid != MY_PID) {
            synchronized (this) {
                if (!checkUriPermissionLocked(new GrantUri(userId, uri, VALIDATE_TOKENS), uid, modeFlags)) {
                    i = -1;
                }
            }
        }
        return i;
    }

    int checkGrantUriPermissionLocked(int callingUid, String targetPkg, GrantUri grantUri, int modeFlags, int lastTargetUid) {
        if (!Intent.isAccessUriMode(modeFlags)) {
            return -1;
        }
        IPackageManager pm;
        if (targetPkg != null) {
            pm = AppGlobals.getPackageManager();
        } else {
            pm = AppGlobals.getPackageManager();
        }
        if (!"content".equals(grantUri.uri.getScheme())) {
            return -1;
        }
        ProviderInfo pi = getProviderInfoLocked(grantUri.uri.getAuthority(), grantUri.sourceUserId);
        if (pi == null) {
            Slog.w(TAG, "No content provider found for permission check: " + grantUri.uri.toSafeString());
            return -1;
        }
        boolean allowed;
        int targetUid = lastTargetUid;
        if (targetUid < 0 && targetPkg != null) {
            try {
                targetUid = pm.getPackageUid(targetPkg, UserHandle.getUserId(callingUid));
                if (targetUid < 0) {
                    return -1;
                }
            } catch (RemoteException e) {
                return -1;
            }
        }
        if (targetUid < 0) {
            allowed = pi.exported;
            if (!((modeFlags & SHOW_ERROR_MSG) == 0 || pi.readPermission == null)) {
                allowed = VALIDATE_TOKENS;
            }
            if (!((modeFlags & SHOW_NOT_RESPONDING_MSG) == 0 || pi.writePermission == null)) {
                allowed = VALIDATE_TOKENS;
            }
            if (allowed) {
                return -1;
            }
        } else if (checkHoldingPermissionsLocked(pm, pi, grantUri, targetUid, modeFlags)) {
            return -1;
        }
        boolean specialCrossUserGrant = (UserHandle.getUserId(targetUid) == grantUri.sourceUserId || !checkHoldingPermissionsInternalLocked(pm, pi, grantUri, callingUid, modeFlags, VALIDATE_TOKENS)) ? VALIDATE_TOKENS : SHOW_ACTIVITY_START_TIME;
        if (!specialCrossUserGrant) {
            if (!pi.grantUriPermissions) {
                throw new SecurityException("Provider " + pi.packageName + "/" + pi.name + " does not allow granting of Uri permissions (uri " + grantUri + ")");
            } else if (pi.uriPermissionPatterns != null) {
                int N = pi.uriPermissionPatterns.length;
                allowed = VALIDATE_TOKENS;
                int i = MY_PID;
                while (i < N) {
                    if (pi.uriPermissionPatterns[i] != null && pi.uriPermissionPatterns[i].match(grantUri.uri.getPath())) {
                        allowed = SHOW_ACTIVITY_START_TIME;
                        break;
                    }
                    i += SHOW_ERROR_MSG;
                }
                if (!allowed) {
                    throw new SecurityException("Provider " + pi.packageName + "/" + pi.name + " does not allow granting of permission to path of Uri " + grantUri);
                }
            }
        }
        if (UserHandle.getAppId(callingUid) == NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY || checkHoldingPermissionsLocked(pm, pi, grantUri, callingUid, modeFlags) || checkUriPermissionLocked(grantUri, callingUid, modeFlags)) {
            return targetUid;
        }
        throw new SecurityException("Uid " + callingUid + " does not have permission to uri " + grantUri);
    }

    public int checkGrantUriPermission(int callingUid, String targetPkg, Uri uri, int modeFlags, int userId) {
        int checkGrantUriPermissionLocked;
        enforceNotIsolatedCaller("checkGrantUriPermission");
        synchronized (this) {
            checkGrantUriPermissionLocked = checkGrantUriPermissionLocked(callingUid, targetPkg, new GrantUri(userId, uri, VALIDATE_TOKENS), modeFlags, -1);
        }
        return checkGrantUriPermissionLocked;
    }

    void grantUriPermissionUncheckedLocked(int targetUid, String targetPkg, GrantUri grantUri, int modeFlags, UriPermissionOwner owner) {
        if (Intent.isAccessUriMode(modeFlags)) {
            ProviderInfo pi = getProviderInfoLocked(grantUri.uri.getAuthority(), grantUri.sourceUserId);
            if (pi == null) {
                Slog.w(TAG, "No content provider found for grant: " + grantUri.toSafeString());
                return;
            }
            if ((modeFlags & MAX_PERSISTED_URI_GRANTS) != 0) {
                grantUri.prefix = SHOW_ACTIVITY_START_TIME;
            }
            findOrCreateUriPermissionLocked(pi.packageName, targetPkg, targetUid, grantUri).grantModes(modeFlags, owner);
        }
    }

    void grantUriPermissionLocked(int callingUid, String targetPkg, GrantUri grantUri, int modeFlags, UriPermissionOwner owner, int targetUserId) {
        if (targetPkg == null) {
            throw new NullPointerException(ATTR_TARGET_PKG);
        }
        try {
            int targetUid = checkGrantUriPermissionLocked(callingUid, targetPkg, grantUri, modeFlags, AppGlobals.getPackageManager().getPackageUid(targetPkg, targetUserId));
            if (targetUid >= 0) {
                grantUriPermissionUncheckedLocked(targetUid, targetPkg, grantUri, modeFlags, owner);
            }
        } catch (RemoteException e) {
        }
    }

    NeededUriGrants checkGrantUriPermissionFromIntentLocked(int callingUid, String targetPkg, Intent intent, int mode, NeededUriGrants needed, int targetUserId) {
        if (targetPkg == null) {
            throw new NullPointerException(ATTR_TARGET_PKG);
        } else if (intent == null) {
            return null;
        } else {
            Uri data = intent.getData();
            ClipData clip = intent.getClipData();
            if (data == null && clip == null) {
                return null;
            }
            int targetUid;
            GrantUri grantUri;
            NeededUriGrants neededUriGrants;
            int contentUserHint = intent.getContentUserHint();
            if (contentUserHint == -2) {
                contentUserHint = UserHandle.getUserId(callingUid);
            }
            IPackageManager pm = AppGlobals.getPackageManager();
            if (needed != null) {
                targetUid = needed.targetUid;
            } else {
                try {
                    targetUid = pm.getPackageUid(targetPkg, targetUserId);
                    if (targetUid < 0) {
                        return null;
                    }
                } catch (RemoteException e) {
                    return null;
                }
            }
            if (data != null) {
                grantUri = GrantUri.resolve(contentUserHint, data);
                targetUid = checkGrantUriPermissionLocked(callingUid, targetPkg, grantUri, mode, targetUid);
                if (targetUid > 0) {
                    if (needed == null) {
                        neededUriGrants = new NeededUriGrants(targetPkg, targetUid, mode);
                    }
                    needed.add(grantUri);
                }
            }
            if (clip != null) {
                for (int i = MY_PID; i < clip.getItemCount(); i += SHOW_ERROR_MSG) {
                    Uri uri = clip.getItemAt(i).getUri();
                    if (uri != null) {
                        grantUri = GrantUri.resolve(contentUserHint, uri);
                        targetUid = checkGrantUriPermissionLocked(callingUid, targetPkg, grantUri, mode, targetUid);
                        if (targetUid > 0) {
                            if (needed == null) {
                                neededUriGrants = new NeededUriGrants(targetPkg, targetUid, mode);
                            }
                            needed.add(grantUri);
                        }
                    } else {
                        Intent clipIntent = clip.getItemAt(i).getIntent();
                        if (clipIntent != null) {
                            NeededUriGrants newNeeded = checkGrantUriPermissionFromIntentLocked(callingUid, targetPkg, clipIntent, mode, needed, targetUserId);
                            if (newNeeded != null) {
                                needed = newNeeded;
                            }
                        }
                    }
                }
            }
            return needed;
        }
    }

    void grantUriPermissionUncheckedFromIntentLocked(NeededUriGrants needed, UriPermissionOwner owner) {
        if (needed != null) {
            for (int i = MY_PID; i < needed.size(); i += SHOW_ERROR_MSG) {
                grantUriPermissionUncheckedLocked(needed.targetUid, needed.targetPkg, (GrantUri) needed.get(i), needed.flags, owner);
            }
        }
    }

    void grantUriPermissionFromIntentLocked(int callingUid, String targetPkg, Intent intent, UriPermissionOwner owner, int targetUserId) {
        NeededUriGrants needed = checkGrantUriPermissionFromIntentLocked(callingUid, targetPkg, intent, intent != null ? intent.getFlags() : MY_PID, null, targetUserId);
        if (needed != null) {
            grantUriPermissionUncheckedFromIntentLocked(needed, owner);
        }
    }

    public void grantUriPermission(IApplicationThread caller, String targetPkg, Uri uri, int modeFlags, int userId) {
        enforceNotIsolatedCaller("grantUriPermission");
        GrantUri grantUri = new GrantUri(userId, uri, VALIDATE_TOKENS);
        synchronized (this) {
            ProcessRecord r = getRecordForAppLocked(caller);
            if (r == null) {
                throw new SecurityException("Unable to find app for caller " + caller + " when granting permission to uri " + grantUri);
            } else if (targetPkg == null) {
                throw new IllegalArgumentException("null target");
            } else if (grantUri == null) {
                throw new IllegalArgumentException("null uri");
            } else {
                Preconditions.checkFlagsArgument(modeFlags, HdmiCecKeycode.UI_SOUND_PRESENTATION_TREBLE_STEP_MINUS);
                grantUriPermissionLocked(r.uid, targetPkg, grantUri, modeFlags, null, UserHandle.getUserId(r.uid));
            }
        }
    }

    void removeUriPermissionIfNeededLocked(UriPermission perm) {
        if (perm.modeFlags == 0) {
            ArrayMap<GrantUri, UriPermission> perms = (ArrayMap) this.mGrantedUriPermissions.get(perm.targetUid);
            if (perms != null) {
                perms.remove(perm.uri);
                if (perms.isEmpty()) {
                    this.mGrantedUriPermissions.remove(perm.targetUid);
                }
            }
        }
    }

    private void revokeUriPermissionLocked(int callingUid, GrantUri grantUri, int modeFlags) {
        IPackageManager pm = AppGlobals.getPackageManager();
        ProviderInfo pi = getProviderInfoLocked(grantUri.uri.getAuthority(), grantUri.sourceUserId);
        if (pi == null) {
            Slog.w(TAG, "No content provider found for permission revoke: " + grantUri.toSafeString());
        } else if (checkHoldingPermissionsLocked(pm, pi, grantUri, callingUid, modeFlags)) {
            persistChanged = VALIDATE_TOKENS;
            int N = this.mGrantedUriPermissions.size();
            int i = MY_PID;
            while (i < N) {
                int targetUid = this.mGrantedUriPermissions.keyAt(i);
                perms = (ArrayMap) this.mGrantedUriPermissions.valueAt(i);
                it = perms.values().iterator();
                while (it.hasNext()) {
                    perm = (UriPermission) it.next();
                    if (perm.uri.sourceUserId == grantUri.sourceUserId && perm.uri.uri.isPathPrefixMatch(grantUri.uri)) {
                        persistChanged |= perm.revokeModes(modeFlags | 64, SHOW_ACTIVITY_START_TIME);
                        if (perm.modeFlags == 0) {
                            it.remove();
                        }
                    }
                }
                if (perms.isEmpty()) {
                    this.mGrantedUriPermissions.remove(targetUid);
                    N--;
                    i--;
                }
                i += SHOW_ERROR_MSG;
            }
            if (persistChanged) {
                schedulePersistUriGrants();
            }
        } else {
            perms = (ArrayMap) this.mGrantedUriPermissions.get(callingUid);
            if (perms != null) {
                persistChanged = VALIDATE_TOKENS;
                it = perms.values().iterator();
                while (it.hasNext()) {
                    perm = (UriPermission) it.next();
                    if (perm.uri.sourceUserId == grantUri.sourceUserId && perm.uri.uri.isPathPrefixMatch(grantUri.uri)) {
                        persistChanged |= perm.revokeModes(modeFlags | 64, VALIDATE_TOKENS);
                        if (perm.modeFlags == 0) {
                            it.remove();
                        }
                    }
                }
                if (perms.isEmpty()) {
                    this.mGrantedUriPermissions.remove(callingUid);
                }
                if (persistChanged) {
                    schedulePersistUriGrants();
                }
            }
        }
    }

    public void revokeUriPermission(IApplicationThread caller, Uri uri, int modeFlags, int userId) {
        enforceNotIsolatedCaller("revokeUriPermission");
        synchronized (this) {
            ProcessRecord r = getRecordForAppLocked(caller);
            if (r == null) {
                throw new SecurityException("Unable to find app for caller " + caller + " when revoking permission to uri " + uri);
            } else if (uri == null) {
                Slog.w(TAG, "revokeUriPermission: null uri");
            } else if (Intent.isAccessUriMode(modeFlags)) {
                IPackageManager pm = AppGlobals.getPackageManager();
                if (getProviderInfoLocked(uri.getAuthority(), userId) == null) {
                    Slog.w(TAG, "No content provider found for permission revoke: " + uri.toSafeString());
                    return;
                }
                revokeUriPermissionLocked(r.uid, new GrantUri(userId, uri, VALIDATE_TOKENS), modeFlags);
            }
        }
    }

    private void removeUriPermissionsForPackageLocked(String packageName, int userHandle, boolean persistable) {
        if (userHandle == -1 && packageName == null) {
            throw new IllegalArgumentException("Must narrow by either package or user");
        }
        boolean persistChanged = VALIDATE_TOKENS;
        int N = this.mGrantedUriPermissions.size();
        int i = MY_PID;
        while (i < N) {
            int targetUid = this.mGrantedUriPermissions.keyAt(i);
            ArrayMap<GrantUri, UriPermission> perms = (ArrayMap) this.mGrantedUriPermissions.valueAt(i);
            if (userHandle == -1 || userHandle == UserHandle.getUserId(targetUid)) {
                Iterator<UriPermission> it = perms.values().iterator();
                while (it.hasNext()) {
                    UriPermission perm = (UriPermission) it.next();
                    if (packageName == null || perm.sourcePkg.equals(packageName) || perm.targetPkg.equals(packageName)) {
                        persistChanged |= perm.revokeModes(persistable ? -1 : -65, SHOW_ACTIVITY_START_TIME);
                        if (perm.modeFlags == 0) {
                            it.remove();
                        }
                    }
                }
                if (perms.isEmpty()) {
                    this.mGrantedUriPermissions.remove(targetUid);
                    N--;
                    i--;
                }
            }
            i += SHOW_ERROR_MSG;
        }
        if (persistChanged) {
            schedulePersistUriGrants();
        }
    }

    public IBinder newUriPermissionOwner(String name) {
        IBinder externalTokenLocked;
        enforceNotIsolatedCaller("newUriPermissionOwner");
        synchronized (this) {
            externalTokenLocked = new UriPermissionOwner(this, name).getExternalTokenLocked();
        }
        return externalTokenLocked;
    }

    public void grantUriPermissionFromOwner(IBinder token, int fromUid, String targetPkg, Uri uri, int modeFlags, int sourceUserId, int targetUserId) {
        targetUserId = handleIncomingUser(Binder.getCallingPid(), Binder.getCallingUid(), targetUserId, (boolean) VALIDATE_TOKENS, (int) SHOW_NOT_RESPONDING_MSG, "grantUriPermissionFromOwner", null);
        synchronized (this) {
            UriPermissionOwner owner = UriPermissionOwner.fromExternalToken(token);
            if (owner == null) {
                throw new IllegalArgumentException("Unknown owner: " + token);
            } else if (fromUid != Binder.getCallingUid() && Binder.getCallingUid() != Process.myUid()) {
                throw new SecurityException("nice try");
            } else if (targetPkg == null) {
                throw new IllegalArgumentException("null target");
            } else if (uri == null) {
                throw new IllegalArgumentException("null uri");
            } else {
                grantUriPermissionLocked(fromUid, targetPkg, new GrantUri(sourceUserId, uri, VALIDATE_TOKENS), modeFlags, owner, targetUserId);
            }
        }
    }

    public void revokeUriPermissionFromOwner(IBinder token, Uri uri, int mode, int userId) {
        synchronized (this) {
            UriPermissionOwner owner = UriPermissionOwner.fromExternalToken(token);
            if (owner == null) {
                throw new IllegalArgumentException("Unknown owner: " + token);
            }
            if (uri == null) {
                owner.removeUriPermissionsLocked(mode);
            } else {
                owner.removeUriPermissionLocked(new GrantUri(userId, uri, VALIDATE_TOKENS), mode);
            }
        }
    }

    private void schedulePersistUriGrants() {
        if (!this.mHandler.hasMessages(PERSIST_URI_GRANTS_MSG)) {
            this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(PERSIST_URI_GRANTS_MSG), 10000);
        }
    }

    private void writeGrantedUriPermissions() {
        Iterator i$;
        ArrayList<Snapshot> persist = Lists.newArrayList();
        synchronized (this) {
            int size = this.mGrantedUriPermissions.size();
            for (int i = MY_PID; i < size; i += SHOW_ERROR_MSG) {
                for (UriPermission perm : ((ArrayMap) this.mGrantedUriPermissions.valueAt(i)).values()) {
                    if (perm.persistedModeFlags != 0) {
                        persist.add(perm.snapshot());
                    }
                }
            }
        }
        FileOutputStream fos = null;
        try {
            fos = this.mGrantFile.startWrite();
            XmlSerializer out = new FastXmlSerializer();
            out.setOutput(fos, StandardCharsets.UTF_8.name());
            out.startDocument(null, Boolean.valueOf(SHOW_ACTIVITY_START_TIME));
            out.startTag(null, TAG_URI_GRANTS);
            i$ = persist.iterator();
            while (i$.hasNext()) {
                Snapshot perm2 = (Snapshot) i$.next();
                out.startTag(null, TAG_URI_GRANT);
                XmlUtils.writeIntAttribute(out, ATTR_SOURCE_USER_ID, perm2.uri.sourceUserId);
                XmlUtils.writeIntAttribute(out, ATTR_TARGET_USER_ID, perm2.targetUserId);
                out.attribute(null, ATTR_SOURCE_PKG, perm2.sourcePkg);
                out.attribute(null, ATTR_TARGET_PKG, perm2.targetPkg);
                out.attribute(null, ATTR_URI, String.valueOf(perm2.uri.uri));
                XmlUtils.writeBooleanAttribute(out, ATTR_PREFIX, perm2.uri.prefix);
                XmlUtils.writeIntAttribute(out, ATTR_MODE_FLAGS, perm2.persistedModeFlags);
                XmlUtils.writeLongAttribute(out, ATTR_CREATED_TIME, perm2.persistedCreateTime);
                out.endTag(null, TAG_URI_GRANT);
            }
            out.endTag(null, TAG_URI_GRANTS);
            out.endDocument();
            this.mGrantFile.finishWrite(fos);
        } catch (IOException e) {
            if (fos != null) {
                this.mGrantFile.failWrite(fos);
            }
        }
    }

    private void readGrantedUriPermissionsLocked() {
        long now = System.currentTimeMillis();
        FileInputStream fis = null;
        try {
            fis = this.mGrantFile.openRead();
            XmlPullParser in = Xml.newPullParser();
            in.setInput(fis, StandardCharsets.UTF_8.name());
            while (true) {
                int type = in.next();
                if (type == SHOW_ERROR_MSG) {
                    break;
                }
                String tag = in.getName();
                if (type == SHOW_NOT_RESPONDING_MSG) {
                    if (TAG_URI_GRANT.equals(tag)) {
                        int sourceUserId;
                        int targetUserId;
                        int userHandle = XmlUtils.readIntAttribute(in, ATTR_USER_HANDLE, -10000);
                        if (userHandle != -10000) {
                            sourceUserId = userHandle;
                            targetUserId = userHandle;
                        } else {
                            sourceUserId = XmlUtils.readIntAttribute(in, ATTR_SOURCE_USER_ID);
                            targetUserId = XmlUtils.readIntAttribute(in, ATTR_TARGET_USER_ID);
                        }
                        String sourcePkg = in.getAttributeValue(null, ATTR_SOURCE_PKG);
                        String targetPkg = in.getAttributeValue(null, ATTR_TARGET_PKG);
                        Uri uri = Uri.parse(in.getAttributeValue(null, ATTR_URI));
                        boolean prefix = XmlUtils.readBooleanAttribute(in, ATTR_PREFIX);
                        int modeFlags = XmlUtils.readIntAttribute(in, ATTR_MODE_FLAGS);
                        long createdTime = XmlUtils.readLongAttribute(in, ATTR_CREATED_TIME, now);
                        ProviderInfo pi = getProviderInfoLocked(uri.getAuthority(), sourceUserId);
                        if (pi != null) {
                            if (sourcePkg.equals(pi.packageName)) {
                                int targetUid = -1;
                                try {
                                    targetUid = AppGlobals.getPackageManager().getPackageUid(targetPkg, targetUserId);
                                } catch (RemoteException e) {
                                }
                                if (targetUid != -1) {
                                    findOrCreateUriPermissionLocked(sourcePkg, targetPkg, targetUid, new GrantUri(sourceUserId, uri, prefix)).initPersistedModes(modeFlags, createdTime);
                                } else {
                                    continue;
                                }
                            }
                        }
                        Slog.w(TAG, "Persisted grant for " + uri + " had source " + sourcePkg + " but instead found " + pi);
                    } else {
                        continue;
                    }
                }
            }
        } catch (FileNotFoundException e2) {
        } catch (IOException e3) {
            Slog.wtf(TAG, "Failed reading Uri grants", e3);
        } catch (XmlPullParserException e4) {
            Slog.wtf(TAG, "Failed reading Uri grants", e4);
        } finally {
            IoUtils.closeQuietly(fis);
        }
    }

    public void takePersistableUriPermission(Uri uri, int modeFlags, int userId) {
        boolean prefixValid = SHOW_ACTIVITY_START_TIME;
        enforceNotIsolatedCaller("takePersistableUriPermission");
        Preconditions.checkFlagsArgument(modeFlags, SHOW_FACTORY_ERROR_MSG);
        synchronized (this) {
            boolean exactValid;
            int callingUid = Binder.getCallingUid();
            boolean persistChanged = VALIDATE_TOKENS;
            GrantUri grantUri = new GrantUri(userId, uri, VALIDATE_TOKENS);
            UriPermission exactPerm = findUriPermissionLocked(callingUid, new GrantUri(userId, uri, VALIDATE_TOKENS));
            UriPermission prefixPerm = findUriPermissionLocked(callingUid, new GrantUri(userId, uri, SHOW_ACTIVITY_START_TIME));
            if (exactPerm == null || (exactPerm.persistableModeFlags & modeFlags) != modeFlags) {
                exactValid = VALIDATE_TOKENS;
            } else {
                exactValid = SHOW_ACTIVITY_START_TIME;
            }
            if (prefixPerm == null || (prefixPerm.persistableModeFlags & modeFlags) != modeFlags) {
                prefixValid = VALIDATE_TOKENS;
            }
            if (exactValid || prefixValid) {
                if (exactValid) {
                    persistChanged = VALIDATE_TOKENS | exactPerm.takePersistableModes(modeFlags);
                }
                if (prefixValid) {
                    persistChanged |= prefixPerm.takePersistableModes(modeFlags);
                }
                if (persistChanged | maybePrunePersistedUriGrantsLocked(callingUid)) {
                    schedulePersistUriGrants();
                }
            } else {
                throw new SecurityException("No persistable permission grants found for UID " + callingUid + " and Uri " + grantUri.toSafeString());
            }
        }
    }

    public void releasePersistableUriPermission(Uri uri, int modeFlags, int userId) {
        enforceNotIsolatedCaller("releasePersistableUriPermission");
        Preconditions.checkFlagsArgument(modeFlags, SHOW_FACTORY_ERROR_MSG);
        synchronized (this) {
            int callingUid = Binder.getCallingUid();
            boolean persistChanged = VALIDATE_TOKENS;
            UriPermission exactPerm = findUriPermissionLocked(callingUid, new GrantUri(userId, uri, VALIDATE_TOKENS));
            UriPermission prefixPerm = findUriPermissionLocked(callingUid, new GrantUri(userId, uri, SHOW_ACTIVITY_START_TIME));
            if (exactPerm == null && prefixPerm == null) {
                throw new SecurityException("No permission grants found for UID " + callingUid + " and Uri " + uri.toSafeString());
            }
            if (exactPerm != null) {
                persistChanged = VALIDATE_TOKENS | exactPerm.releasePersistableModes(modeFlags);
                removeUriPermissionIfNeededLocked(exactPerm);
            }
            if (prefixPerm != null) {
                persistChanged |= prefixPerm.releasePersistableModes(modeFlags);
                removeUriPermissionIfNeededLocked(prefixPerm);
            }
            if (persistChanged) {
                schedulePersistUriGrants();
            }
        }
    }

    private boolean maybePrunePersistedUriGrantsLocked(int uid) {
        ArrayMap<GrantUri, UriPermission> perms = (ArrayMap) this.mGrantedUriPermissions.get(uid);
        if (perms == null || perms.size() < MAX_PERSISTED_URI_GRANTS) {
            return VALIDATE_TOKENS;
        }
        ArrayList<UriPermission> persisted = Lists.newArrayList();
        for (UriPermission perm : perms.values()) {
            UriPermission perm2;
            if (perm2.persistedModeFlags != 0) {
                persisted.add(perm2);
            }
        }
        int trimCount = persisted.size() - 128;
        if (trimCount <= 0) {
            return VALIDATE_TOKENS;
        }
        Collections.sort(persisted, new PersistedTimeComparator());
        for (int i = MY_PID; i < trimCount; i += SHOW_ERROR_MSG) {
            perm2 = (UriPermission) persisted.get(i);
            perm2.releasePersistableModes(-1);
            removeUriPermissionIfNeededLocked(perm2);
        }
        return SHOW_ACTIVITY_START_TIME;
    }

    public ParceledListSlice<UriPermission> getPersistedUriPermissions(String packageName, boolean incoming) {
        enforceNotIsolatedCaller("getPersistedUriPermissions");
        Preconditions.checkNotNull(packageName, "packageName");
        int callingUid = Binder.getCallingUid();
        try {
            if (AppGlobals.getPackageManager().getPackageUid(packageName, UserHandle.getUserId(callingUid)) != callingUid) {
                throw new SecurityException("Package " + packageName + " does not belong to calling UID " + callingUid);
            }
            ArrayList<UriPermission> result = Lists.newArrayList();
            synchronized (this) {
                if (incoming) {
                    ArrayMap<GrantUri, UriPermission> perms = (ArrayMap) this.mGrantedUriPermissions.get(callingUid);
                    if (perms == null) {
                        Slog.w(TAG, "No permission grants found for " + packageName);
                    } else {
                        for (UriPermission perm : perms.values()) {
                            if (packageName.equals(perm.targetPkg) && perm.persistedModeFlags != 0) {
                                result.add(perm.buildPersistedPublicApiObject());
                            }
                        }
                    }
                } else {
                    int size = this.mGrantedUriPermissions.size();
                    for (int i = MY_PID; i < size; i += SHOW_ERROR_MSG) {
                        for (UriPermission perm2 : ((ArrayMap) this.mGrantedUriPermissions.valueAt(i)).values()) {
                            if (packageName.equals(perm2.sourcePkg) && perm2.persistedModeFlags != 0) {
                                result.add(perm2.buildPersistedPublicApiObject());
                            }
                        }
                    }
                }
            }
            return new ParceledListSlice(result);
        } catch (RemoteException e) {
            throw new SecurityException("Failed to verify package name ownership");
        }
    }

    public void showWaitingForDebugger(IApplicationThread who, boolean waiting) {
        synchronized (this) {
            ProcessRecord app = who != null ? getRecordForAppLocked(who) : null;
            if (app == null) {
                return;
            }
            Message msg = Message.obtain();
            msg.what = WAIT_FOR_DEBUGGER_MSG;
            msg.obj = app;
            msg.arg1 = waiting ? SHOW_ERROR_MSG : MY_PID;
            this.mHandler.sendMessage(msg);
        }
    }

    public void getMemoryInfo(ActivityManager.MemoryInfo outInfo) {
        long homeAppMem = this.mProcessList.getMemLevel(WAIT_FOR_DEBUGGER_MSG);
        long cachedAppMem = this.mProcessList.getMemLevel(9);
        outInfo.availMem = Process.getFreeMemory();
        outInfo.totalMem = Process.getTotalMemory();
        outInfo.threshold = homeAppMem;
        outInfo.lowMemory = outInfo.availMem < ((cachedAppMem - homeAppMem) / 2) + homeAppMem ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
        outInfo.hiddenAppThreshold = cachedAppMem;
        outInfo.secondaryServerThreshold = this.mProcessList.getMemLevel(GC_BACKGROUND_PROCESSES_MSG);
        outInfo.visibleAppThreshold = this.mProcessList.getMemLevel(SHOW_ERROR_MSG);
        outInfo.foregroundAppThreshold = this.mProcessList.getMemLevel(MY_PID);
    }

    public List<IAppTask> getAppTasks(String callingPackage) {
        ArrayList<IAppTask> list;
        int callingUid = Binder.getCallingUid();
        long ident = Binder.clearCallingIdentity();
        synchronized (this) {
            list = new ArrayList();
            try {
                int N = this.mRecentTasks.size();
                for (int i = MY_PID; i < N; i += SHOW_ERROR_MSG) {
                    TaskRecord tr = (TaskRecord) this.mRecentTasks.get(i);
                    if (tr.effectiveUid == callingUid) {
                        Intent intent = tr.getBaseIntent();
                        if (intent != null && callingPackage.equals(intent.getComponent().getPackageName())) {
                            list.add(new AppTaskImpl(createRecentTaskInfoFromTaskRecord(tr).persistentId, callingUid));
                        }
                    }
                }
                Binder.restoreCallingIdentity(ident);
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(ident);
            }
        }
        return list;
    }

    public List<RunningTaskInfo> getTasks(int maxNum, int flags) {
        int callingUid = Binder.getCallingUid();
        ArrayList<RunningTaskInfo> list = new ArrayList();
        synchronized (this) {
            this.mStackSupervisor.getTasksLocked(maxNum, list, callingUid, isGetTasksAllowed("getTasks", Binder.getCallingPid(), callingUid));
        }
        return list;
    }

    private RecentTaskInfo createRecentTaskInfoFromTaskRecord(TaskRecord tr) {
        int i = -1;
        tr.updateTaskDescription();
        RecentTaskInfo rti = new RecentTaskInfo();
        rti.id = tr.getTopActivity() == null ? -1 : tr.taskId;
        rti.persistentId = tr.taskId;
        rti.baseIntent = new Intent(tr.getBaseIntent());
        rti.origActivity = tr.origActivity;
        rti.description = tr.lastDescription;
        if (tr.stack != null) {
            i = tr.stack.mStackId;
        }
        rti.stackId = i;
        rti.userId = tr.userId;
        rti.taskDescription = new TaskDescription(tr.lastTaskDescription);
        rti.firstActiveTime = tr.firstActiveTime;
        rti.lastActiveTime = tr.lastActiveTime;
        rti.affiliatedTaskId = tr.mAffiliatedTaskId;
        rti.affiliatedTaskColor = tr.mAffiliatedTaskColor;
        return rti;
    }

    private boolean isGetTasksAllowed(String caller, int callingPid, int callingUid) {
        boolean allowed = checkPermission("android.permission.REAL_GET_TASKS", callingPid, callingUid) == 0 ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
        if (!allowed && checkPermission("android.permission.GET_TASKS", callingPid, callingUid) == 0) {
            try {
                if (AppGlobals.getPackageManager().isUidPrivileged(callingUid)) {
                    allowed = SHOW_ACTIVITY_START_TIME;
                    Slog.w(TAG, caller + ": caller " + callingUid + " is using old GET_TASKS but privileged; allowing");
                }
            } catch (RemoteException e) {
            }
        }
        if (!allowed) {
            Slog.w(TAG, caller + ": caller " + callingUid + " does not hold REAL_GET_TASKS; limiting output");
        }
        return allowed;
    }

    public List<RecentTaskInfo> getRecentTasks(int maxNum, int flags, int userId) {
        ArrayList<RecentTaskInfo> arrayList;
        int callingUid = Binder.getCallingUid();
        userId = handleIncomingUser(Binder.getCallingPid(), callingUid, userId, (boolean) VALIDATE_TOKENS, (int) SHOW_NOT_RESPONDING_MSG, "getRecentTasks", null);
        boolean includeProfiles = (flags & UPDATE_CONFIGURATION_MSG) != 0 ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
        boolean withExcluded = (flags & SHOW_ERROR_MSG) != 0 ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
        synchronized (this) {
            int i;
            Set<Integer> includedUsers;
            boolean allowed = isGetTasksAllowed("getRecentTasks", Binder.getCallingPid(), callingUid);
            boolean detailed = checkCallingPermission("android.permission.GET_DETAILED_TASKS") == 0 ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
            int N = this.mRecentTasks.size();
            if (maxNum < N) {
                i = maxNum;
            } else {
                i = N;
            }
            arrayList = new ArrayList(i);
            if (includeProfiles) {
                includedUsers = getProfileIdsLocked(userId);
            } else {
                includedUsers = new HashSet();
            }
            includedUsers.add(Integer.valueOf(userId));
            int i2 = MY_PID;
            while (i2 < N && maxNum > 0) {
                TaskRecord tr = (TaskRecord) this.mRecentTasks.get(i2);
                if (includedUsers.contains(Integer.valueOf(tr.userId)) && ((i2 == 0 || withExcluded || tr.intent == null || (tr.intent.getFlags() & 8388608) == 0) && ((allowed || tr.isHomeTask() || tr.effectiveUid == callingUid) && (((flags & 8) == 0 || tr.stack == null || !tr.stack.isHomeStack()) && (!(tr.autoRemoveRecents && tr.getTopActivity() == null) && ((flags & SHOW_NOT_RESPONDING_MSG) == 0 || tr.isAvailable)))))) {
                    RecentTaskInfo rti = createRecentTaskInfoFromTaskRecord(tr);
                    if (!detailed) {
                        rti.baseIntent.replaceExtras((Bundle) null);
                    }
                    arrayList.add(rti);
                    maxNum--;
                }
                i2 += SHOW_ERROR_MSG;
            }
        }
        return arrayList;
    }

    TaskRecord recentTaskForIdLocked(int id) {
        int N = this.mRecentTasks.size();
        for (int i = MY_PID; i < N; i += SHOW_ERROR_MSG) {
            TaskRecord tr = (TaskRecord) this.mRecentTasks.get(i);
            if (tr.taskId == id) {
                return tr;
            }
        }
        return null;
    }

    public TaskThumbnail getTaskThumbnail(int id) {
        synchronized (this) {
            enforceCallingPermission("android.permission.READ_FRAME_BUFFER", "getTaskThumbnail()");
            TaskRecord tr = this.mStackSupervisor.anyTaskForIdLocked(id);
            if (tr != null) {
                TaskThumbnail taskThumbnailLocked = tr.getTaskThumbnailLocked();
                return taskThumbnailLocked;
            }
            return null;
        }
    }

    public int addAppTask(IBinder activityToken, Intent intent, TaskDescription description, Bitmap thumbnail) throws RemoteException {
        int callingUid = Binder.getCallingUid();
        long callingIdent = Binder.clearCallingIdentity();
        try {
            int i;
            synchronized (this) {
                ActivityRecord r = ActivityRecord.isInStackLocked(activityToken);
                if (r == null) {
                    throw new IllegalArgumentException("Activity does not exist; token=" + activityToken);
                }
                ComponentName comp = intent.getComponent();
                if (comp == null) {
                    throw new IllegalArgumentException("Intent " + intent + " must specify explicit component");
                } else if (thumbnail.getWidth() == this.mThumbnailWidth && thumbnail.getHeight() == this.mThumbnailHeight) {
                    if (intent.getSelector() != null) {
                        intent.setSelector(null);
                    }
                    if (intent.getSourceBounds() != null) {
                        intent.setSourceBounds(null);
                    }
                    if ((intent.getFlags() & 524288) != 0) {
                        if ((intent.getFlags() & DumpState.DUMP_INSTALLS) == 0) {
                            intent.addFlags(DumpState.DUMP_INSTALLS);
                        }
                    } else if ((intent.getFlags() & 268435456) != 0) {
                        intent.addFlags(268435456);
                    }
                    if (!(comp.equals(this.mLastAddedTaskComponent) && callingUid == this.mLastAddedTaskUid)) {
                        this.mLastAddedTaskActivity = null;
                    }
                    ActivityInfo ainfo = this.mLastAddedTaskActivity;
                    if (ainfo == null) {
                        ainfo = AppGlobals.getPackageManager().getActivityInfo(comp, MY_PID, UserHandle.getUserId(callingUid));
                        this.mLastAddedTaskActivity = ainfo;
                        if (ainfo.applicationInfo.uid != callingUid) {
                            throw new SecurityException("Can't add task for another application: target uid=" + ainfo.applicationInfo.uid + ", calling uid=" + callingUid);
                        }
                    }
                    TaskRecord task = new TaskRecord(this, this.mStackSupervisor.getNextTaskId(), ainfo, intent, description);
                    if (trimRecentsForTaskLocked(task, VALIDATE_TOKENS) >= 0) {
                        i = -1;
                    } else {
                        int N = this.mRecentTasks.size();
                        if (N >= ActivityManager.getMaxRecentTasksStatic() - 1) {
                            ((TaskRecord) this.mRecentTasks.remove(N - 1)).removedFromRecents();
                        }
                        task.inRecents = SHOW_ACTIVITY_START_TIME;
                        this.mRecentTasks.add(task);
                        r.task.stack.addTask(task, VALIDATE_TOKENS, VALIDATE_TOKENS);
                        task.setLastThumbnail(thumbnail);
                        task.freeLastThumbnail();
                        i = task.taskId;
                        Binder.restoreCallingIdentity(callingIdent);
                    }
                } else {
                    throw new IllegalArgumentException("Bad thumbnail size: got " + thumbnail.getWidth() + "x" + thumbnail.getHeight() + ", require " + this.mThumbnailWidth + "x" + this.mThumbnailHeight);
                }
            }
            return i;
        } finally {
            Binder.restoreCallingIdentity(callingIdent);
        }
    }

    public Point getAppTaskThumbnailSize() {
        Point point;
        synchronized (this) {
            point = new Point(this.mThumbnailWidth, this.mThumbnailHeight);
        }
        return point;
    }

    public void setTaskDescription(IBinder token, TaskDescription td) {
        synchronized (this) {
            ActivityRecord r = ActivityRecord.isInStackLocked(token);
            if (r != null) {
                r.setTaskDescription(td);
                r.task.updateTaskDescription();
            }
        }
    }

    public Bitmap getTaskDescriptionIcon(String filename) {
        if (FileUtils.isValidExtFilename(filename) && filename.contains("_activity_icon_")) {
            return this.mTaskPersister.getTaskDescriptionIcon(filename);
        }
        throw new IllegalArgumentException("Bad filename: " + filename);
    }

    public void startInPlaceAnimationOnFrontMostApplication(ActivityOptions opts) throws RemoteException {
        if (opts.getAnimationType() != 10 || opts.getCustomInPlaceResId() == 0) {
            throw new IllegalArgumentException("Expected in-place ActivityOption with valid animation");
        }
        this.mWindowManager.prepareAppTransition(17, VALIDATE_TOKENS);
        this.mWindowManager.overridePendingAppTransitionInPlace(opts.getPackageName(), opts.getCustomInPlaceResId());
        this.mWindowManager.executeAppTransition();
    }

    private void cleanUpRemovedTaskLocked(TaskRecord tr, boolean killProcess) {
        this.mRecentTasks.remove(tr);
        tr.removedFromRecents();
        ComponentName component = tr.getBaseIntent().getComponent();
        if (component == null) {
            Slog.w(TAG, "No component for base intent of task: " + tr);
        } else if (killProcess) {
            int i;
            String pkg = component.getPackageName();
            ArrayList<ProcessRecord> procsToKill = new ArrayList();
            ArrayMap<String, SparseArray<ProcessRecord>> pmap = this.mProcessNames.getMap();
            for (i = MY_PID; i < pmap.size(); i += SHOW_ERROR_MSG) {
                SparseArray<ProcessRecord> uids = (SparseArray) pmap.valueAt(i);
                for (int j = MY_PID; j < uids.size(); j += SHOW_ERROR_MSG) {
                    ProcessRecord proc = (ProcessRecord) uids.valueAt(j);
                    if (proc.userId == tr.userId && proc != this.mHomeProcess && proc.pkgList.containsKey(pkg)) {
                        int k = MY_PID;
                        while (k < proc.activities.size()) {
                            TaskRecord otherTask = ((ActivityRecord) proc.activities.get(k)).task;
                            if (tr.taskId == otherTask.taskId || !otherTask.inRecents) {
                                k += SHOW_ERROR_MSG;
                            } else {
                                return;
                            }
                        }
                        procsToKill.add(proc);
                    }
                }
            }
            this.mServices.cleanUpRemovedTaskLocked(tr, component, new Intent(tr.getBaseIntent()));
            for (i = MY_PID; i < procsToKill.size(); i += SHOW_ERROR_MSG) {
                ProcessRecord pr = (ProcessRecord) procsToKill.get(i);
                if (pr.setSchedGroup == 0) {
                    pr.kill("remove task", SHOW_ACTIVITY_START_TIME);
                } else {
                    pr.waitingToKill = "remove task";
                }
            }
        }
    }

    private void removeTasksByPackageNameLocked(String packageName, int userId) {
        for (int i = this.mRecentTasks.size() - 1; i >= 0; i--) {
            TaskRecord tr = (TaskRecord) this.mRecentTasks.get(i);
            if (tr.userId == userId) {
                ComponentName cn = tr.intent.getComponent();
                if (cn != null && cn.getPackageName().equals(packageName)) {
                    removeTaskByIdLocked(tr.taskId, SHOW_ACTIVITY_START_TIME);
                }
            }
        }
    }

    private void removeTasksByRemovedPackageComponentsLocked(String packageName, int userId) {
        IPackageManager pm = AppGlobals.getPackageManager();
        HashSet<ComponentName> componentsKnownToExist = new HashSet();
        for (int i = this.mRecentTasks.size() - 1; i >= 0; i--) {
            TaskRecord tr = (TaskRecord) this.mRecentTasks.get(i);
            if (tr.userId == userId) {
                ComponentName cn = tr.intent.getComponent();
                if (!(cn == null || !cn.getPackageName().equals(packageName) || componentsKnownToExist.contains(cn))) {
                    try {
                        if (pm.getActivityInfo(cn, MY_PID, userId) != null) {
                            componentsKnownToExist.add(cn);
                        } else {
                            removeTaskByIdLocked(tr.taskId, VALIDATE_TOKENS);
                        }
                    } catch (RemoteException e) {
                        Log.e(TAG, "Activity info query failed. component=" + cn, e);
                    }
                }
            }
        }
    }

    private boolean removeTaskByIdLocked(int taskId, boolean killProcess) {
        TaskRecord tr = this.mStackSupervisor.anyTaskForIdLocked(taskId);
        if (tr != null) {
            tr.removeTaskActivitiesLocked();
            cleanUpRemovedTaskLocked(tr, killProcess);
            if (!tr.isPersistable) {
                return SHOW_ACTIVITY_START_TIME;
            }
            notifyTaskPersisterLocked(null, SHOW_ACTIVITY_START_TIME);
            return SHOW_ACTIVITY_START_TIME;
        }
        Slog.w(TAG, "Request to remove task ignored for non-existent task " + taskId);
        return VALIDATE_TOKENS;
    }

    public boolean removeTask(int taskId) {
        boolean removeTaskByIdLocked;
        synchronized (this) {
            enforceCallingPermission("android.permission.REMOVE_TASKS", "removeTask()");
            long ident = Binder.clearCallingIdentity();
            try {
                removeTaskByIdLocked = removeTaskByIdLocked(taskId, SHOW_ACTIVITY_START_TIME);
                Binder.restoreCallingIdentity(ident);
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(ident);
            }
        }
        return removeTaskByIdLocked;
    }

    public void moveTaskToFront(int taskId, int flags, Bundle options) {
        enforceCallingPermission("android.permission.REORDER_TASKS", "moveTaskToFront()");
        synchronized (this) {
            moveTaskToFrontLocked(taskId, flags, options);
        }
    }

    void moveTaskToFrontLocked(int taskId, int flags, Bundle options) {
        if (checkAppSwitchAllowedLocked(Binder.getCallingPid(), Binder.getCallingUid(), -1, -1, "Task to front")) {
            long origId = Binder.clearCallingIdentity();
            try {
                TaskRecord task = this.mStackSupervisor.anyTaskForIdLocked(taskId);
                if (task == null) {
                    Slog.d(TAG, "Could not find task for id: " + taskId);
                } else if (this.mStackSupervisor.isLockTaskModeViolation(task)) {
                    this.mStackSupervisor.showLockTaskToast();
                    Slog.e(TAG, "moveTaskToFront: Attempt to violate Lock Task Mode");
                    Binder.restoreCallingIdentity(origId);
                } else {
                    ActivityRecord prev = this.mStackSupervisor.topRunningActivityLocked();
                    if (prev != null && prev.isRecentsActivity()) {
                        task.setTaskToReturnTo(SHOW_NOT_RESPONDING_MSG);
                    }
                    this.mStackSupervisor.findTaskToMoveToFrontLocked(task, flags, options, "moveTaskToFront");
                    Binder.restoreCallingIdentity(origId);
                    ActivityOptions.abort(options);
                }
            } finally {
                Binder.restoreCallingIdentity(origId);
            }
        } else {
            ActivityOptions.abort(options);
        }
    }

    public void moveTaskToBack(int taskId) {
        enforceCallingPermission("android.permission.REORDER_TASKS", "moveTaskToBack()");
        synchronized (this) {
            TaskRecord tr = this.mStackSupervisor.anyTaskForIdLocked(taskId);
            if (tr != null) {
                if (tr == this.mStackSupervisor.mLockTaskModeTask) {
                    this.mStackSupervisor.showLockTaskToast();
                    return;
                }
                ActivityStack stack = tr.stack;
                if (stack.mResumedActivity == null || stack.mResumedActivity.task != tr || checkAppSwitchAllowedLocked(Binder.getCallingPid(), Binder.getCallingUid(), -1, -1, "Task to back")) {
                    long origId = Binder.clearCallingIdentity();
                    try {
                        stack.moveTaskToBackLocked(taskId);
                    } finally {
                        Binder.restoreCallingIdentity(origId);
                    }
                } else {
                    return;
                }
            }
        }
    }

    public boolean moveActivityTaskToBack(IBinder token, boolean nonRoot) {
        boolean z = VALIDATE_TOKENS;
        enforceNotIsolatedCaller("moveActivityTaskToBack");
        synchronized (this) {
            boolean z2;
            long origId = Binder.clearCallingIdentity();
            if (nonRoot) {
                z2 = VALIDATE_TOKENS;
            } else {
                z2 = SHOW_ACTIVITY_START_TIME;
            }
            try {
                int taskId = ActivityRecord.getTaskForActivityLocked(token, z2);
                if (taskId < 0) {
                    Binder.restoreCallingIdentity(origId);
                } else if (this.mStackSupervisor.mLockTaskModeTask == null || this.mStackSupervisor.mLockTaskModeTask.taskId != taskId) {
                    z = ActivityRecord.getStackLocked(token).moveTaskToBackLocked(taskId);
                    Binder.restoreCallingIdentity(origId);
                } else {
                    this.mStackSupervisor.showLockTaskToast();
                }
            } finally {
                Binder.restoreCallingIdentity(origId);
            }
        }
        return z;
    }

    public void moveTaskBackwards(int task) {
        enforceCallingPermission("android.permission.REORDER_TASKS", "moveTaskBackwards()");
        synchronized (this) {
            if (checkAppSwitchAllowedLocked(Binder.getCallingPid(), Binder.getCallingUid(), -1, -1, "Task backwards")) {
                long origId = Binder.clearCallingIdentity();
                moveTaskBackwardsLocked(task);
                Binder.restoreCallingIdentity(origId);
                return;
            }
        }
    }

    private final void moveTaskBackwardsLocked(int task) {
        Slog.e(TAG, "moveTaskBackwards not yet implemented!");
    }

    public IBinder getHomeActivityToken() throws RemoteException {
        IBinder homeActivityToken;
        enforceCallingPermission("android.permission.MANAGE_ACTIVITY_STACKS", "getHomeActivityToken()");
        synchronized (this) {
            homeActivityToken = this.mStackSupervisor.getHomeActivityToken();
        }
        return homeActivityToken;
    }

    public IActivityContainer createActivityContainer(IBinder parentActivityToken, IActivityContainerCallback callback) throws RemoteException {
        IActivityContainer iActivityContainer;
        enforceCallingPermission("android.permission.MANAGE_ACTIVITY_STACKS", "createActivityContainer()");
        synchronized (this) {
            if (parentActivityToken == null) {
                throw new IllegalArgumentException("parent token must not be null");
            }
            ActivityRecord r = ActivityRecord.forToken(parentActivityToken);
            if (r == null) {
                iActivityContainer = null;
            } else if (callback == null) {
                throw new IllegalArgumentException("callback must not be null");
            } else {
                iActivityContainer = this.mStackSupervisor.createActivityContainer(r, callback);
            }
        }
        return iActivityContainer;
    }

    public void deleteActivityContainer(IActivityContainer container) throws RemoteException {
        enforceCallingPermission("android.permission.MANAGE_ACTIVITY_STACKS", "deleteActivityContainer()");
        synchronized (this) {
            this.mStackSupervisor.deleteActivityContainer(container);
        }
    }

    public int getActivityDisplayId(IBinder activityToken) throws RemoteException {
        int i;
        synchronized (this) {
            ActivityStack stack = ActivityRecord.getStackLocked(activityToken);
            if (stack == null || !stack.mActivityContainer.isAttachedLocked()) {
                i = MY_PID;
            } else {
                i = stack.mActivityContainer.getDisplayId();
            }
        }
        return i;
    }

    public void moveTaskToStack(int taskId, int stackId, boolean toTop) {
        enforceCallingPermission("android.permission.MANAGE_ACTIVITY_STACKS", "moveTaskToStack()");
        if (stackId == 0) {
            Slog.e(TAG, "moveTaskToStack: Attempt to move task " + taskId + " to home stack", new RuntimeException("here").fillInStackTrace());
        }
        synchronized (this) {
            long ident = Binder.clearCallingIdentity();
            try {
                this.mStackSupervisor.moveTaskToStackLocked(taskId, stackId, toTop);
                Binder.restoreCallingIdentity(ident);
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(ident);
            }
        }
    }

    public void resizeStack(int stackBoxId, Rect bounds) {
        enforceCallingPermission("android.permission.MANAGE_ACTIVITY_STACKS", "resizeStackBox()");
        long ident = Binder.clearCallingIdentity();
        try {
            this.mWindowManager.resizeStack(stackBoxId, bounds);
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    public List<StackInfo> getAllStackInfos() {
        enforceCallingPermission("android.permission.MANAGE_ACTIVITY_STACKS", "getAllStackInfos()");
        long ident = Binder.clearCallingIdentity();
        try {
            List<StackInfo> allStackInfosLocked;
            synchronized (this) {
                allStackInfosLocked = this.mStackSupervisor.getAllStackInfosLocked();
            }
            return allStackInfosLocked;
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    public StackInfo getStackInfo(int stackId) {
        enforceCallingPermission("android.permission.MANAGE_ACTIVITY_STACKS", "getStackInfo()");
        long ident = Binder.clearCallingIdentity();
        try {
            StackInfo stackInfoLocked;
            synchronized (this) {
                stackInfoLocked = this.mStackSupervisor.getStackInfoLocked(stackId);
            }
            return stackInfoLocked;
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    public boolean isInHomeStack(int taskId) {
        enforceCallingPermission("android.permission.MANAGE_ACTIVITY_STACKS", "getStackInfo()");
        long ident = Binder.clearCallingIdentity();
        try {
            boolean z;
            synchronized (this) {
                TaskRecord tr = this.mStackSupervisor.anyTaskForIdLocked(taskId);
                z = (tr == null || tr.stack == null || !tr.stack.isHomeStack()) ? VALIDATE_TOKENS : SHOW_ACTIVITY_START_TIME;
            }
            return z;
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    public int getTaskForActivity(IBinder token, boolean onlyRoot) {
        int taskForActivityLocked;
        synchronized (this) {
            taskForActivityLocked = ActivityRecord.getTaskForActivityLocked(token, onlyRoot);
        }
        return taskForActivityLocked;
    }

    private boolean isLockTaskAuthorized(String pkg) {
        DevicePolicyManager dpm = (DevicePolicyManager) this.mContext.getSystemService("device_policy");
        try {
            if (this.mContext.getPackageManager().getPackageUid(pkg, Binder.getCallingUserHandle().getIdentifier()) == Binder.getCallingUid() && dpm != null && dpm.isLockTaskPermitted(pkg)) {
                return SHOW_ACTIVITY_START_TIME;
            }
            return VALIDATE_TOKENS;
        } catch (NameNotFoundException e) {
            return VALIDATE_TOKENS;
        }
    }

    void startLockTaskMode(TaskRecord task) {
        boolean isSystemInitiated;
        boolean z = SHOW_ACTIVITY_START_TIME;
        synchronized (this) {
            String pkg = task.intent.getComponent().getPackageName();
        }
        if (Binder.getCallingUid() == NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY) {
            isSystemInitiated = SHOW_ACTIVITY_START_TIME;
        } else {
            isSystemInitiated = VALIDATE_TOKENS;
        }
        if (isSystemInitiated || isLockTaskAuthorized(pkg)) {
            long ident = Binder.clearCallingIdentity();
            try {
                synchronized (this) {
                    task = this.mStackSupervisor.anyTaskForIdLocked(task.taskId);
                    if (task != null) {
                        if (isSystemInitiated || (this.mStackSupervisor.getFocusedStack() != null && task == this.mStackSupervisor.getFocusedStack().topTask())) {
                            ActivityStackSupervisor activityStackSupervisor = this.mStackSupervisor;
                            if (isSystemInitiated) {
                                z = VALIDATE_TOKENS;
                            }
                            activityStackSupervisor.setLockTaskModeLocked(task, z, "startLockTask");
                        } else {
                            throw new IllegalArgumentException("Invalid task, not in foreground");
                        }
                    }
                }
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        } else {
            StatusBarManagerInternal statusBarManager = (StatusBarManagerInternal) LocalServices.getService(StatusBarManagerInternal.class);
            if (statusBarManager != null) {
                statusBarManager.showScreenPinningRequest();
            }
        }
    }

    public void startLockTaskMode(int taskId) {
        long ident = Binder.clearCallingIdentity();
        try {
            TaskRecord task;
            synchronized (this) {
                task = this.mStackSupervisor.anyTaskForIdLocked(taskId);
            }
            if (task != null) {
                startLockTaskMode(task);
            }
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    public void startLockTaskMode(IBinder token) {
        long ident = Binder.clearCallingIdentity();
        try {
            synchronized (this) {
                ActivityRecord r = ActivityRecord.forToken(token);
                if (r == null) {
                    return;
                }
                TaskRecord task = r.task;
                Binder.restoreCallingIdentity(ident);
                if (task != null) {
                    startLockTaskMode(task);
                }
            }
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    public void startLockTaskModeOnCurrent() throws RemoteException {
        enforceCallingPermission("android.permission.MANAGE_ACTIVITY_STACKS", "startLockTaskModeOnCurrent");
        long ident = Binder.clearCallingIdentity();
        try {
            ActivityRecord r;
            synchronized (this) {
                r = this.mStackSupervisor.topRunningActivityLocked();
            }
            startLockTaskMode(r.task);
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    public void stopLockTaskMode() {
        int callingUid = Binder.getCallingUid();
        if (callingUid != NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY) {
            try {
                int uid = this.mContext.getPackageManager().getPackageUid(this.mStackSupervisor.mLockTaskModeTask.intent.getComponent().getPackageName(), Binder.getCallingUserHandle().getIdentifier());
                if (uid != callingUid) {
                    throw new SecurityException("Invalid uid, expected " + uid);
                }
            } catch (NameNotFoundException e) {
                Log.d(TAG, "stopLockTaskMode " + e);
                return;
            }
        }
        long ident = Binder.clearCallingIdentity();
        try {
            Log.d(TAG, "stopLockTaskMode");
            synchronized (this) {
                this.mStackSupervisor.setLockTaskModeLocked(null, VALIDATE_TOKENS, "stopLockTask");
            }
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    public void stopLockTaskModeOnCurrent() throws RemoteException {
        enforceCallingPermission("android.permission.MANAGE_ACTIVITY_STACKS", "stopLockTaskModeOnCurrent");
        long ident = Binder.clearCallingIdentity();
        try {
            stopLockTaskMode();
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    public boolean isInLockTaskMode() {
        boolean isInLockTaskMode;
        synchronized (this) {
            isInLockTaskMode = this.mStackSupervisor.isInLockTaskMode();
        }
        return isInLockTaskMode;
    }

    private final List<ProviderInfo> generateApplicationProvidersLocked(ProcessRecord app) {
        List<ProviderInfo> providers = null;
        try {
            providers = AppGlobals.getPackageManager().queryContentProviders(app.processName, app.uid, 3072);
        } catch (RemoteException e) {
        }
        int userId = app.userId;
        if (providers != null) {
            int N = providers.size();
            app.pubProviders.ensureCapacity(app.pubProviders.size() + N);
            int i = MY_PID;
            while (i < N) {
                ProviderInfo cpi = (ProviderInfo) providers.get(i);
                boolean singleton = isSingleton(cpi.processName, cpi.applicationInfo, cpi.name, cpi.flags);
                if (!singleton || UserHandle.getUserId(app.uid) == 0) {
                    ComponentName comp = new ComponentName(cpi.packageName, cpi.name);
                    ContentProviderRecord cpr = this.mProviderMap.getProviderByClass(comp, userId);
                    if (cpr == null) {
                        cpr = new ContentProviderRecord(this, cpi, app.info, comp, singleton);
                        this.mProviderMap.putProviderByClass(comp, cpr);
                    }
                    app.pubProviders.put(cpi.name, cpr);
                    if (!(cpi.multiprocess && "android".equals(cpi.packageName))) {
                        app.addPackage(cpi.applicationInfo.packageName, cpi.applicationInfo.versionCode, this.mProcessStats);
                    }
                    ensurePackageDexOpt(cpi.applicationInfo.packageName);
                } else {
                    providers.remove(i);
                    N--;
                    i--;
                }
                i += SHOW_ERROR_MSG;
            }
        }
        return providers;
    }

    private final String checkContentProviderPermissionLocked(ProviderInfo cpi, ProcessRecord r, int userId, boolean checkUser) {
        int callingPid = r != null ? r.pid : Binder.getCallingPid();
        int callingUid = r != null ? r.uid : Binder.getCallingUid();
        boolean checkedGrants = VALIDATE_TOKENS;
        if (checkUser) {
            int tmpTargetUserId = unsafeConvertIncomingUser(userId);
            if (tmpTargetUserId != UserHandle.getUserId(callingUid)) {
                if (checkAuthorityGrants(callingUid, cpi, tmpTargetUserId, checkUser)) {
                    return null;
                }
                checkedGrants = SHOW_ACTIVITY_START_TIME;
            }
            userId = handleIncomingUser(callingPid, callingUid, userId, (boolean) VALIDATE_TOKENS, (int) MY_PID, "checkContentProviderPermissionLocked " + cpi.authority, null);
            if (userId != tmpTargetUserId) {
                checkedGrants = VALIDATE_TOKENS;
            }
        }
        if (checkComponentPermission(cpi.readPermission, callingPid, callingUid, cpi.applicationInfo.uid, cpi.exported) == 0) {
            return null;
        }
        if (checkComponentPermission(cpi.writePermission, callingPid, callingUid, cpi.applicationInfo.uid, cpi.exported) == 0) {
            return null;
        }
        PathPermission[] pps = cpi.pathPermissions;
        if (pps != null) {
            int i = pps.length;
            while (i > 0) {
                i--;
                PathPermission pp = pps[i];
                String pprperm = pp.getReadPermission();
                if (pprperm != null) {
                    if (checkComponentPermission(pprperm, callingPid, callingUid, cpi.applicationInfo.uid, cpi.exported) == 0) {
                        return null;
                    }
                }
                String ppwperm = pp.getWritePermission();
                if (ppwperm != null) {
                    if (checkComponentPermission(ppwperm, callingPid, callingUid, cpi.applicationInfo.uid, cpi.exported) == 0) {
                        return null;
                    }
                }
            }
        }
        if (!checkedGrants && checkAuthorityGrants(callingUid, cpi, userId, checkUser)) {
            return null;
        }
        String msg;
        StringBuilder append;
        if (cpi.exported) {
            append = new StringBuilder().append("Permission Denial: opening provider ").append(cpi.name).append(" from ");
            if (r == null) {
                r = "(null)";
            }
            msg = append.append(r).append(" (pid=").append(callingPid).append(", uid=").append(callingUid).append(") requires ").append(cpi.readPermission).append(" or ").append(cpi.writePermission).toString();
        } else {
            append = new StringBuilder().append("Permission Denial: opening provider ").append(cpi.name).append(" from ");
            if (r == null) {
                r = "(null)";
            }
            msg = append.append(r).append(" (pid=").append(callingPid).append(", uid=").append(callingUid).append(") that is not exported from uid ").append(cpi.applicationInfo.uid).toString();
        }
        Slog.w(TAG, msg);
        return msg;
    }

    boolean checkAuthorityGrants(int callingUid, ProviderInfo cpi, int userId, boolean checkUser) {
        ArrayMap<GrantUri, UriPermission> perms = (ArrayMap) this.mGrantedUriPermissions.get(callingUid);
        if (perms != null) {
            for (int i = perms.size() - 1; i >= 0; i--) {
                GrantUri grantUri = (GrantUri) perms.keyAt(i);
                if ((grantUri.sourceUserId == userId || !checkUser) && matchesProvider(grantUri.uri, cpi)) {
                    return SHOW_ACTIVITY_START_TIME;
                }
            }
        }
        return VALIDATE_TOKENS;
    }

    boolean matchesProvider(Uri uri, ProviderInfo cpi) {
        String uriAuth = uri.getAuthority();
        String cpiAuth = cpi.authority;
        if (cpiAuth.indexOf(59) == -1) {
            return cpiAuth.equals(uriAuth);
        }
        String[] cpiAuths = cpiAuth.split(";");
        int length = cpiAuths.length;
        for (int i = MY_PID; i < length; i += SHOW_ERROR_MSG) {
            if (cpiAuths[i].equals(uriAuth)) {
                return SHOW_ACTIVITY_START_TIME;
            }
        }
        return VALIDATE_TOKENS;
    }

    ContentProviderConnection incProviderCountLocked(ProcessRecord r, ContentProviderRecord cpr, IBinder externalProcessToken, boolean stable) {
        if (r != null) {
            ContentProviderConnection conn;
            int i = MY_PID;
            while (i < r.conProviders.size()) {
                conn = (ContentProviderConnection) r.conProviders.get(i);
                if (conn.provider != cpr) {
                    i += SHOW_ERROR_MSG;
                } else if (stable) {
                    conn.stableCount += SHOW_ERROR_MSG;
                    conn.numStableIncs += SHOW_ERROR_MSG;
                    return conn;
                } else {
                    conn.unstableCount += SHOW_ERROR_MSG;
                    conn.numUnstableIncs += SHOW_ERROR_MSG;
                    return conn;
                }
            }
            conn = new ContentProviderConnection(cpr, r);
            if (stable) {
                conn.stableCount = SHOW_ERROR_MSG;
                conn.numStableIncs = SHOW_ERROR_MSG;
            } else {
                conn.unstableCount = SHOW_ERROR_MSG;
                conn.numUnstableIncs = SHOW_ERROR_MSG;
            }
            cpr.connections.add(conn);
            r.conProviders.add(conn);
            startAssociationLocked(r.uid, r.processName, cpr.uid, cpr.name, cpr.info.processName);
            return conn;
        }
        cpr.addExternalProcessHandleLocked(externalProcessToken);
        return null;
    }

    boolean decProviderCountLocked(ContentProviderConnection conn, ContentProviderRecord cpr, IBinder externalProcessToken, boolean stable) {
        if (conn != null) {
            cpr = conn.provider;
            if (stable) {
                conn.stableCount--;
            } else {
                conn.unstableCount--;
            }
            if (conn.stableCount != 0 || conn.unstableCount != 0) {
                return VALIDATE_TOKENS;
            }
            cpr.connections.remove(conn);
            conn.client.conProviders.remove(conn);
            stopAssociationLocked(conn.client.uid, conn.client.processName, cpr.uid, cpr.name);
            return SHOW_ACTIVITY_START_TIME;
        }
        cpr.removeExternalProcessHandleLocked(externalProcessToken);
        return VALIDATE_TOKENS;
    }

    private void checkTime(long startTime, String where) {
        long now = SystemClock.elapsedRealtime();
        if (now - startTime > 1000) {
            Slog.w(TAG, "Slow operation: " + (now - startTime) + "ms so far, now at " + where);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private final android.app.IActivityManager.ContentProviderHolder getContentProviderImpl(android.app.IApplicationThread r41, java.lang.String r42, android.os.IBinder r43, boolean r44, int r45) {
        /*
        r40 = this;
        r22 = 0;
        r6 = 0;
        monitor-enter(r40);
        r38 = android.os.SystemClock.elapsedRealtime();	 Catch:{ all -> 0x0047 }
        r36 = 0;
        if (r41 == 0) goto L_0x004a;
    L_0x000c:
        r36 = r40.getRecordForAppLocked(r41);	 Catch:{ all -> 0x0047 }
        if (r36 != 0) goto L_0x004a;
    L_0x0012:
        r5 = new java.lang.SecurityException;	 Catch:{ all -> 0x0047 }
        r10 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0047 }
        r10.<init>();	 Catch:{ all -> 0x0047 }
        r11 = "Unable to find app for caller ";
        r10 = r10.append(r11);	 Catch:{ all -> 0x0047 }
        r0 = r41;
        r10 = r10.append(r0);	 Catch:{ all -> 0x0047 }
        r11 = " (pid=";
        r10 = r10.append(r11);	 Catch:{ all -> 0x0047 }
        r11 = android.os.Binder.getCallingPid();	 Catch:{ all -> 0x0047 }
        r10 = r10.append(r11);	 Catch:{ all -> 0x0047 }
        r11 = ") when getting content provider ";
        r10 = r10.append(r11);	 Catch:{ all -> 0x0047 }
        r0 = r42;
        r10 = r10.append(r0);	 Catch:{ all -> 0x0047 }
        r10 = r10.toString();	 Catch:{ all -> 0x0047 }
        r5.<init>(r10);	 Catch:{ all -> 0x0047 }
        throw r5;	 Catch:{ all -> 0x0047 }
    L_0x0047:
        r5 = move-exception;
        monitor-exit(r40);	 Catch:{ all -> 0x0047 }
        throw r5;
    L_0x004a:
        r21 = 1;
        r5 = "getContentProviderImpl: getProviderByName";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ all -> 0x0047 }
        r0 = r40;
        r5 = r0.mProviderMap;	 Catch:{ all -> 0x0047 }
        r0 = r42;
        r1 = r45;
        r4 = r5.getProviderByName(r0, r1);	 Catch:{ all -> 0x0047 }
        if (r4 != 0) goto L_0x0098;
    L_0x0063:
        if (r45 == 0) goto L_0x0098;
    L_0x0065:
        r0 = r40;
        r5 = r0.mProviderMap;	 Catch:{ all -> 0x0047 }
        r10 = 0;
        r0 = r42;
        r4 = r5.getProviderByName(r0, r10);	 Catch:{ all -> 0x0047 }
        if (r4 == 0) goto L_0x0098;
    L_0x0072:
        r6 = r4.info;	 Catch:{ all -> 0x0047 }
        r5 = r6.processName;	 Catch:{ all -> 0x0047 }
        r10 = r6.applicationInfo;	 Catch:{ all -> 0x0047 }
        r11 = r6.name;	 Catch:{ all -> 0x0047 }
        r12 = r6.flags;	 Catch:{ all -> 0x0047 }
        r0 = r40;
        r5 = r0.isSingleton(r5, r10, r11, r12);	 Catch:{ all -> 0x0047 }
        if (r5 == 0) goto L_0x00bf;
    L_0x0084:
        r0 = r36;
        r5 = r0.uid;	 Catch:{ all -> 0x0047 }
        r10 = r6.applicationInfo;	 Catch:{ all -> 0x0047 }
        r10 = r10.uid;	 Catch:{ all -> 0x0047 }
        r0 = r40;
        r5 = r0.isValidSingletonCall(r5, r10);	 Catch:{ all -> 0x0047 }
        if (r5 == 0) goto L_0x00bf;
    L_0x0094:
        r45 = 0;
        r21 = 0;
    L_0x0098:
        if (r4 == 0) goto L_0x00c2;
    L_0x009a:
        r35 = 1;
    L_0x009c:
        if (r35 == 0) goto L_0x01ae;
    L_0x009e:
        r6 = r4.info;	 Catch:{ all -> 0x0047 }
        r5 = "getContentProviderImpl: before checkContentProviderPermission";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ all -> 0x0047 }
        r0 = r40;
        r1 = r36;
        r2 = r45;
        r3 = r21;
        r31 = r0.checkContentProviderPermissionLocked(r6, r1, r2, r3);	 Catch:{ all -> 0x0047 }
        if (r31 == 0) goto L_0x00c5;
    L_0x00b7:
        r5 = new java.lang.SecurityException;	 Catch:{ all -> 0x0047 }
        r0 = r31;
        r5.<init>(r0);	 Catch:{ all -> 0x0047 }
        throw r5;	 Catch:{ all -> 0x0047 }
    L_0x00bf:
        r4 = 0;
        r6 = 0;
        goto L_0x0098;
    L_0x00c2:
        r35 = 0;
        goto L_0x009c;
    L_0x00c5:
        r5 = "getContentProviderImpl: after checkContentProviderPermission";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ all -> 0x0047 }
        if (r36 == 0) goto L_0x00e4;
    L_0x00d0:
        r0 = r36;
        r5 = r4.canRunHere(r0);	 Catch:{ all -> 0x0047 }
        if (r5 == 0) goto L_0x00e4;
    L_0x00d8:
        r5 = 0;
        r26 = r4.newHolder(r5);	 Catch:{ all -> 0x0047 }
        r5 = 0;
        r0 = r26;
        r0.provider = r5;	 Catch:{ all -> 0x0047 }
        monitor-exit(r40);	 Catch:{ all -> 0x0047 }
    L_0x00e3:
        return r26;
    L_0x00e4:
        r32 = android.os.Binder.clearCallingIdentity();	 Catch:{ all -> 0x0047 }
        r5 = "getContentProviderImpl: incProviderCountLocked";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ all -> 0x0047 }
        r0 = r40;
        r1 = r36;
        r2 = r43;
        r3 = r44;
        r22 = r0.incProviderCountLocked(r1, r4, r2, r3);	 Catch:{ all -> 0x0047 }
        if (r22 == 0) goto L_0x0131;
    L_0x00ff:
        r0 = r22;
        r5 = r0.stableCount;	 Catch:{ all -> 0x0047 }
        r0 = r22;
        r10 = r0.unstableCount;	 Catch:{ all -> 0x0047 }
        r5 = r5 + r10;
        r10 = 1;
        if (r5 != r10) goto L_0x0131;
    L_0x010b:
        r5 = r4.proc;	 Catch:{ all -> 0x0047 }
        if (r5 == 0) goto L_0x0131;
    L_0x010f:
        r0 = r36;
        r5 = r0.setAdj;	 Catch:{ all -> 0x0047 }
        r10 = 2;
        if (r5 > r10) goto L_0x0131;
    L_0x0116:
        r5 = "getContentProviderImpl: before updateLruProcess";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ all -> 0x0047 }
        r5 = r4.proc;	 Catch:{ all -> 0x0047 }
        r10 = 0;
        r11 = 0;
        r0 = r40;
        r0.updateLruProcessLocked(r5, r10, r11);	 Catch:{ all -> 0x0047 }
        r5 = "getContentProviderImpl: after updateLruProcess";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ all -> 0x0047 }
    L_0x0131:
        r5 = r4.proc;	 Catch:{ all -> 0x0047 }
        if (r5 == 0) goto L_0x01ab;
    L_0x0135:
        r5 = "getContentProviderImpl: before updateOomAdj";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ all -> 0x0047 }
        r5 = r4.proc;	 Catch:{ all -> 0x0047 }
        r0 = r40;
        r37 = r0.updateOomAdjLocked(r5);	 Catch:{ all -> 0x0047 }
        r5 = "getContentProviderImpl: after updateOomAdj";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ all -> 0x0047 }
        if (r37 != 0) goto L_0x01ab;
    L_0x0151:
        r5 = "ActivityManager";
        r10 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0047 }
        r10.<init>();	 Catch:{ all -> 0x0047 }
        r11 = "Existing provider ";
        r10 = r10.append(r11);	 Catch:{ all -> 0x0047 }
        r11 = r4.name;	 Catch:{ all -> 0x0047 }
        r11 = r11.flattenToShortString();	 Catch:{ all -> 0x0047 }
        r10 = r10.append(r11);	 Catch:{ all -> 0x0047 }
        r11 = " is crashing; detaching ";
        r10 = r10.append(r11);	 Catch:{ all -> 0x0047 }
        r0 = r36;
        r10 = r10.append(r0);	 Catch:{ all -> 0x0047 }
        r10 = r10.toString();	 Catch:{ all -> 0x0047 }
        android.util.Slog.i(r5, r10);	 Catch:{ all -> 0x0047 }
        r0 = r40;
        r1 = r22;
        r2 = r43;
        r3 = r44;
        r30 = r0.decProviderCountLocked(r1, r4, r2, r3);	 Catch:{ all -> 0x0047 }
        r5 = "getContentProviderImpl: before appDied";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ all -> 0x0047 }
        r5 = r4.proc;	 Catch:{ all -> 0x0047 }
        r0 = r40;
        r0.appDiedLocked(r5);	 Catch:{ all -> 0x0047 }
        r5 = "getContentProviderImpl: after appDied";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ all -> 0x0047 }
        if (r30 != 0) goto L_0x01a7;
    L_0x01a2:
        r26 = 0;
        monitor-exit(r40);	 Catch:{ all -> 0x0047 }
        goto L_0x00e3;
    L_0x01a7:
        r35 = 0;
        r22 = 0;
    L_0x01ab:
        android.os.Binder.restoreCallingIdentity(r32);	 Catch:{ all -> 0x0047 }
    L_0x01ae:
        if (r35 != 0) goto L_0x0426;
    L_0x01b0:
        r5 = "getContentProviderImpl: before resolveContentProvider";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ RemoteException -> 0x0591 }
        r5 = android.app.AppGlobals.getPackageManager();	 Catch:{ RemoteException -> 0x0591 }
        r10 = 3072; // 0xc00 float:4.305E-42 double:1.518E-320;
        r0 = r42;
        r1 = r45;
        r6 = r5.resolveContentProvider(r0, r10, r1);	 Catch:{ RemoteException -> 0x0591 }
        r5 = "getContentProviderImpl: after resolveContentProvider";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ RemoteException -> 0x0591 }
    L_0x01d0:
        if (r6 != 0) goto L_0x01d7;
    L_0x01d2:
        r26 = 0;
        monitor-exit(r40);	 Catch:{ all -> 0x0047 }
        goto L_0x00e3;
    L_0x01d7:
        r5 = r6.processName;	 Catch:{ all -> 0x0047 }
        r10 = r6.applicationInfo;	 Catch:{ all -> 0x0047 }
        r11 = r6.name;	 Catch:{ all -> 0x0047 }
        r12 = r6.flags;	 Catch:{ all -> 0x0047 }
        r0 = r40;
        r5 = r0.isSingleton(r5, r10, r11, r12);	 Catch:{ all -> 0x0047 }
        if (r5 == 0) goto L_0x0231;
    L_0x01e7:
        r0 = r36;
        r5 = r0.uid;	 Catch:{ all -> 0x0047 }
        r10 = r6.applicationInfo;	 Catch:{ all -> 0x0047 }
        r10 = r10.uid;	 Catch:{ all -> 0x0047 }
        r0 = r40;
        r5 = r0.isValidSingletonCall(r5, r10);	 Catch:{ all -> 0x0047 }
        if (r5 == 0) goto L_0x0231;
    L_0x01f7:
        r9 = 1;
    L_0x01f8:
        if (r9 == 0) goto L_0x01fc;
    L_0x01fa:
        r45 = 0;
    L_0x01fc:
        r5 = r6.applicationInfo;	 Catch:{ all -> 0x0047 }
        r0 = r40;
        r1 = r45;
        r5 = r0.getAppInfoForUser(r5, r1);	 Catch:{ all -> 0x0047 }
        r6.applicationInfo = r5;	 Catch:{ all -> 0x0047 }
        r5 = "getContentProviderImpl: got app info for user";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ all -> 0x0047 }
        r5 = "getContentProviderImpl: before checkContentProviderPermission";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ all -> 0x0047 }
        if (r9 != 0) goto L_0x0233;
    L_0x021c:
        r5 = 1;
    L_0x021d:
        r0 = r40;
        r1 = r36;
        r2 = r45;
        r31 = r0.checkContentProviderPermissionLocked(r6, r1, r2, r5);	 Catch:{ all -> 0x0047 }
        if (r31 == 0) goto L_0x0235;
    L_0x0229:
        r5 = new java.lang.SecurityException;	 Catch:{ all -> 0x0047 }
        r0 = r31;
        r5.<init>(r0);	 Catch:{ all -> 0x0047 }
        throw r5;	 Catch:{ all -> 0x0047 }
    L_0x0231:
        r9 = 0;
        goto L_0x01f8;
    L_0x0233:
        r5 = 0;
        goto L_0x021d;
    L_0x0235:
        r5 = "getContentProviderImpl: after checkContentProviderPermission";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ all -> 0x0047 }
        r0 = r40;
        r5 = r0.mProcessesReady;	 Catch:{ all -> 0x0047 }
        if (r5 != 0) goto L_0x0262;
    L_0x0244:
        r0 = r40;
        r5 = r0.mDidUpdate;	 Catch:{ all -> 0x0047 }
        if (r5 != 0) goto L_0x0262;
    L_0x024a:
        r0 = r40;
        r5 = r0.mWaitingUpdate;	 Catch:{ all -> 0x0047 }
        if (r5 != 0) goto L_0x0262;
    L_0x0250:
        r5 = r6.processName;	 Catch:{ all -> 0x0047 }
        r10 = "system";
        r5 = r5.equals(r10);	 Catch:{ all -> 0x0047 }
        if (r5 != 0) goto L_0x0262;
    L_0x025a:
        r5 = new java.lang.IllegalArgumentException;	 Catch:{ all -> 0x0047 }
        r10 = "Attempt to launch content provider before system ready";
        r5.<init>(r10);	 Catch:{ all -> 0x0047 }
        throw r5;	 Catch:{ all -> 0x0047 }
    L_0x0262:
        r5 = 0;
        r0 = r40;
        r1 = r45;
        r5 = r0.isUserRunningLocked(r1, r5);	 Catch:{ all -> 0x0047 }
        if (r5 != 0) goto L_0x02ba;
    L_0x026d:
        r5 = "ActivityManager";
        r10 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0047 }
        r10.<init>();	 Catch:{ all -> 0x0047 }
        r11 = "Unable to launch app ";
        r10 = r10.append(r11);	 Catch:{ all -> 0x0047 }
        r11 = r6.applicationInfo;	 Catch:{ all -> 0x0047 }
        r11 = r11.packageName;	 Catch:{ all -> 0x0047 }
        r10 = r10.append(r11);	 Catch:{ all -> 0x0047 }
        r11 = "/";
        r10 = r10.append(r11);	 Catch:{ all -> 0x0047 }
        r11 = r6.applicationInfo;	 Catch:{ all -> 0x0047 }
        r11 = r11.uid;	 Catch:{ all -> 0x0047 }
        r10 = r10.append(r11);	 Catch:{ all -> 0x0047 }
        r11 = " for provider ";
        r10 = r10.append(r11);	 Catch:{ all -> 0x0047 }
        r0 = r42;
        r10 = r10.append(r0);	 Catch:{ all -> 0x0047 }
        r11 = ": user ";
        r10 = r10.append(r11);	 Catch:{ all -> 0x0047 }
        r0 = r45;
        r10 = r10.append(r0);	 Catch:{ all -> 0x0047 }
        r11 = " is stopped";
        r10 = r10.append(r11);	 Catch:{ all -> 0x0047 }
        r10 = r10.toString();	 Catch:{ all -> 0x0047 }
        android.util.Slog.w(r5, r10);	 Catch:{ all -> 0x0047 }
        r26 = 0;
        monitor-exit(r40);	 Catch:{ all -> 0x0047 }
        goto L_0x00e3;
    L_0x02ba:
        r8 = new android.content.ComponentName;	 Catch:{ all -> 0x0047 }
        r5 = r6.packageName;	 Catch:{ all -> 0x0047 }
        r10 = r6.name;	 Catch:{ all -> 0x0047 }
        r8.<init>(r5, r10);	 Catch:{ all -> 0x0047 }
        r5 = "getContentProviderImpl: before getProviderByClass";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ all -> 0x0047 }
        r0 = r40;
        r5 = r0.mProviderMap;	 Catch:{ all -> 0x0047 }
        r0 = r45;
        r23 = r5.getProviderByClass(r8, r0);	 Catch:{ all -> 0x0047 }
        r5 = "getContentProviderImpl: after getProviderByClass";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ all -> 0x0047 }
        if (r23 != 0) goto L_0x0331;
    L_0x02e1:
        r25 = 1;
    L_0x02e3:
        if (r25 == 0) goto L_0x0594;
    L_0x02e5:
        r28 = android.os.Binder.clearCallingIdentity();	 Catch:{ all -> 0x0047 }
        r5 = "getContentProviderImpl: before getApplicationInfo";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ RemoteException -> 0x0361, all -> 0x0368 }
        r5 = android.app.AppGlobals.getPackageManager();	 Catch:{ RemoteException -> 0x0361, all -> 0x0368 }
        r10 = r6.applicationInfo;	 Catch:{ RemoteException -> 0x0361, all -> 0x0368 }
        r10 = r10.packageName;	 Catch:{ RemoteException -> 0x0361, all -> 0x0368 }
        r11 = 1024; // 0x400 float:1.435E-42 double:5.06E-321;
        r0 = r45;
        r7 = r5.getApplicationInfo(r10, r11, r0);	 Catch:{ RemoteException -> 0x0361, all -> 0x0368 }
        r5 = "getContentProviderImpl: after getApplicationInfo";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ RemoteException -> 0x0361, all -> 0x0368 }
        if (r7 != 0) goto L_0x0334;
    L_0x030d:
        r5 = "ActivityManager";
        r10 = new java.lang.StringBuilder;	 Catch:{ RemoteException -> 0x0361, all -> 0x0368 }
        r10.<init>();	 Catch:{ RemoteException -> 0x0361, all -> 0x0368 }
        r11 = "No package info for content provider ";
        r10 = r10.append(r11);	 Catch:{ RemoteException -> 0x0361, all -> 0x0368 }
        r11 = r6.name;	 Catch:{ RemoteException -> 0x0361, all -> 0x0368 }
        r10 = r10.append(r11);	 Catch:{ RemoteException -> 0x0361, all -> 0x0368 }
        r10 = r10.toString();	 Catch:{ RemoteException -> 0x0361, all -> 0x0368 }
        android.util.Slog.w(r5, r10);	 Catch:{ RemoteException -> 0x0361, all -> 0x0368 }
        r26 = 0;
        android.os.Binder.restoreCallingIdentity(r28);	 Catch:{ all -> 0x0047 }
        monitor-exit(r40);	 Catch:{ all -> 0x0047 }
        r4 = r23;
        goto L_0x00e3;
    L_0x0331:
        r25 = 0;
        goto L_0x02e3;
    L_0x0334:
        r0 = r40;
        r1 = r45;
        r7 = r0.getAppInfoForUser(r7, r1);	 Catch:{ RemoteException -> 0x0361, all -> 0x0368 }
        r4 = new com.android.server.am.ContentProviderRecord;	 Catch:{ RemoteException -> 0x0361, all -> 0x0368 }
        r5 = r40;
        r4.<init>(r5, r6, r7, r8, r9);	 Catch:{ RemoteException -> 0x0361, all -> 0x0368 }
        android.os.Binder.restoreCallingIdentity(r28);	 Catch:{ all -> 0x0047 }
    L_0x0346:
        r5 = "getContentProviderImpl: now have ContentProviderRecord";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ all -> 0x0047 }
        if (r36 == 0) goto L_0x036d;
    L_0x0351:
        r0 = r36;
        r5 = r4.canRunHere(r0);	 Catch:{ all -> 0x0047 }
        if (r5 == 0) goto L_0x036d;
    L_0x0359:
        r5 = 0;
        r26 = r4.newHolder(r5);	 Catch:{ all -> 0x0047 }
        monitor-exit(r40);	 Catch:{ all -> 0x0047 }
        goto L_0x00e3;
    L_0x0361:
        r5 = move-exception;
        android.os.Binder.restoreCallingIdentity(r28);	 Catch:{ all -> 0x0047 }
        r4 = r23;
        goto L_0x0346;
    L_0x0368:
        r5 = move-exception;
        android.os.Binder.restoreCallingIdentity(r28);	 Catch:{ all -> 0x0047 }
        throw r5;	 Catch:{ all -> 0x0047 }
    L_0x036d:
        r0 = r40;
        r5 = r0.mLaunchingProviders;	 Catch:{ all -> 0x0047 }
        r20 = r5.size();	 Catch:{ all -> 0x0047 }
        r27 = 0;
    L_0x0377:
        r0 = r27;
        r1 = r20;
        if (r0 >= r1) goto L_0x0389;
    L_0x037d:
        r0 = r40;
        r5 = r0.mLaunchingProviders;	 Catch:{ all -> 0x0047 }
        r0 = r27;
        r5 = r5.get(r0);	 Catch:{ all -> 0x0047 }
        if (r5 != r4) goto L_0x04a9;
    L_0x0389:
        r0 = r27;
        r1 = r20;
        if (r0 < r1) goto L_0x03f8;
    L_0x038f:
        r32 = android.os.Binder.clearCallingIdentity();	 Catch:{ all -> 0x0047 }
        r5 = "getContentProviderImpl: before set stopped state";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ RemoteException -> 0x058e, IllegalArgumentException -> 0x04ad }
        r5 = android.app.AppGlobals.getPackageManager();	 Catch:{ RemoteException -> 0x058e, IllegalArgumentException -> 0x04ad }
        r10 = r4.appInfo;	 Catch:{ RemoteException -> 0x058e, IllegalArgumentException -> 0x04ad }
        r10 = r10.packageName;	 Catch:{ RemoteException -> 0x058e, IllegalArgumentException -> 0x04ad }
        r11 = 0;
        r0 = r45;
        r5.setPackageStoppedState(r10, r11, r0);	 Catch:{ RemoteException -> 0x058e, IllegalArgumentException -> 0x04ad }
        r5 = "getContentProviderImpl: after set stopped state";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ RemoteException -> 0x058e, IllegalArgumentException -> 0x04ad }
    L_0x03b3:
        r5 = "getContentProviderImpl: looking for process record";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ all -> 0x04d8 }
        r5 = r6.processName;	 Catch:{ all -> 0x04d8 }
        r10 = r4.appInfo;	 Catch:{ all -> 0x04d8 }
        r10 = r10.uid;	 Catch:{ all -> 0x04d8 }
        r11 = 0;
        r0 = r40;
        r34 = r0.getProcessRecordLocked(r5, r10, r11);	 Catch:{ all -> 0x04d8 }
        if (r34 == 0) goto L_0x04dd;
    L_0x03cb:
        r0 = r34;
        r5 = r0.thread;	 Catch:{ all -> 0x04d8 }
        if (r5 == 0) goto L_0x04dd;
    L_0x03d1:
        r5 = "getContentProviderImpl: scheduling install";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ all -> 0x04d8 }
        r0 = r34;
        r5 = r0.pubProviders;	 Catch:{ all -> 0x04d8 }
        r10 = r6.name;	 Catch:{ all -> 0x04d8 }
        r5.put(r10, r4);	 Catch:{ all -> 0x04d8 }
        r0 = r34;
        r5 = r0.thread;	 Catch:{ RemoteException -> 0x058b }
        r5.scheduleInstallProvider(r6);	 Catch:{ RemoteException -> 0x058b }
    L_0x03ea:
        r0 = r34;
        r4.launchingApp = r0;	 Catch:{ all -> 0x04d8 }
        r0 = r40;
        r5 = r0.mLaunchingProviders;	 Catch:{ all -> 0x04d8 }
        r5.add(r4);	 Catch:{ all -> 0x04d8 }
        android.os.Binder.restoreCallingIdentity(r32);	 Catch:{ all -> 0x0047 }
    L_0x03f8:
        r5 = "getContentProviderImpl: updating data structures";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ all -> 0x0047 }
        if (r25 == 0) goto L_0x040a;
    L_0x0403:
        r0 = r40;
        r5 = r0.mProviderMap;	 Catch:{ all -> 0x0047 }
        r5.putProviderByClass(r8, r4);	 Catch:{ all -> 0x0047 }
    L_0x040a:
        r0 = r40;
        r5 = r0.mProviderMap;	 Catch:{ all -> 0x0047 }
        r0 = r42;
        r5.putProviderByName(r0, r4);	 Catch:{ all -> 0x0047 }
        r0 = r40;
        r1 = r36;
        r2 = r43;
        r3 = r44;
        r22 = r0.incProviderCountLocked(r1, r4, r2, r3);	 Catch:{ all -> 0x0047 }
        if (r22 == 0) goto L_0x0426;
    L_0x0421:
        r5 = 1;
        r0 = r22;
        r0.waiting = r5;	 Catch:{ all -> 0x0047 }
    L_0x0426:
        r5 = "getContentProviderImpl: done!";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ all -> 0x0047 }
        monitor-exit(r40);	 Catch:{ all -> 0x0047 }
        monitor-enter(r4);
    L_0x0431:
        r5 = r4.provider;	 Catch:{ all -> 0x04a6 }
        if (r5 != 0) goto L_0x057c;
    L_0x0435:
        r5 = r4.launchingApp;	 Catch:{ all -> 0x04a6 }
        if (r5 != 0) goto L_0x0556;
    L_0x0439:
        r5 = "ActivityManager";
        r10 = new java.lang.StringBuilder;	 Catch:{ all -> 0x04a6 }
        r10.<init>();	 Catch:{ all -> 0x04a6 }
        r11 = "Unable to launch app ";
        r10 = r10.append(r11);	 Catch:{ all -> 0x04a6 }
        r11 = r6.applicationInfo;	 Catch:{ all -> 0x04a6 }
        r11 = r11.packageName;	 Catch:{ all -> 0x04a6 }
        r10 = r10.append(r11);	 Catch:{ all -> 0x04a6 }
        r11 = "/";
        r10 = r10.append(r11);	 Catch:{ all -> 0x04a6 }
        r11 = r6.applicationInfo;	 Catch:{ all -> 0x04a6 }
        r11 = r11.uid;	 Catch:{ all -> 0x04a6 }
        r10 = r10.append(r11);	 Catch:{ all -> 0x04a6 }
        r11 = " for provider ";
        r10 = r10.append(r11);	 Catch:{ all -> 0x04a6 }
        r0 = r42;
        r10 = r10.append(r0);	 Catch:{ all -> 0x04a6 }
        r11 = ": launching app became null";
        r10 = r10.append(r11);	 Catch:{ all -> 0x04a6 }
        r10 = r10.toString();	 Catch:{ all -> 0x04a6 }
        android.util.Slog.w(r5, r10);	 Catch:{ all -> 0x04a6 }
        r5 = 30036; // 0x7554 float:4.209E-41 double:1.484E-319;
        r10 = 4;
        r10 = new java.lang.Object[r10];	 Catch:{ all -> 0x04a6 }
        r11 = 0;
        r12 = r6.applicationInfo;	 Catch:{ all -> 0x04a6 }
        r12 = r12.uid;	 Catch:{ all -> 0x04a6 }
        r12 = android.os.UserHandle.getUserId(r12);	 Catch:{ all -> 0x04a6 }
        r12 = java.lang.Integer.valueOf(r12);	 Catch:{ all -> 0x04a6 }
        r10[r11] = r12;	 Catch:{ all -> 0x04a6 }
        r11 = 1;
        r12 = r6.applicationInfo;	 Catch:{ all -> 0x04a6 }
        r12 = r12.packageName;	 Catch:{ all -> 0x04a6 }
        r10[r11] = r12;	 Catch:{ all -> 0x04a6 }
        r11 = 2;
        r12 = r6.applicationInfo;	 Catch:{ all -> 0x04a6 }
        r12 = r12.uid;	 Catch:{ all -> 0x04a6 }
        r12 = java.lang.Integer.valueOf(r12);	 Catch:{ all -> 0x04a6 }
        r10[r11] = r12;	 Catch:{ all -> 0x04a6 }
        r11 = 3;
        r10[r11] = r42;	 Catch:{ all -> 0x04a6 }
        android.util.EventLog.writeEvent(r5, r10);	 Catch:{ all -> 0x04a6 }
        r26 = 0;
        monitor-exit(r4);	 Catch:{ all -> 0x04a6 }
        goto L_0x00e3;
    L_0x04a6:
        r5 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x04a6 }
        throw r5;
    L_0x04a9:
        r27 = r27 + 1;
        goto L_0x0377;
    L_0x04ad:
        r24 = move-exception;
        r5 = "ActivityManager";
        r10 = new java.lang.StringBuilder;	 Catch:{ all -> 0x04d8 }
        r10.<init>();	 Catch:{ all -> 0x04d8 }
        r11 = "Failed trying to unstop package ";
        r10 = r10.append(r11);	 Catch:{ all -> 0x04d8 }
        r11 = r4.appInfo;	 Catch:{ all -> 0x04d8 }
        r11 = r11.packageName;	 Catch:{ all -> 0x04d8 }
        r10 = r10.append(r11);	 Catch:{ all -> 0x04d8 }
        r11 = ": ";
        r10 = r10.append(r11);	 Catch:{ all -> 0x04d8 }
        r0 = r24;
        r10 = r10.append(r0);	 Catch:{ all -> 0x04d8 }
        r10 = r10.toString();	 Catch:{ all -> 0x04d8 }
        android.util.Slog.w(r5, r10);	 Catch:{ all -> 0x04d8 }
        goto L_0x03b3;
    L_0x04d8:
        r5 = move-exception;
        android.os.Binder.restoreCallingIdentity(r32);	 Catch:{ all -> 0x0047 }
        throw r5;	 Catch:{ all -> 0x0047 }
    L_0x04dd:
        r5 = "getContentProviderImpl: before start process";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ all -> 0x04d8 }
        r11 = r6.processName;	 Catch:{ all -> 0x04d8 }
        r12 = r4.appInfo;	 Catch:{ all -> 0x04d8 }
        r13 = 0;
        r14 = 0;
        r15 = "content provider";
        r16 = new android.content.ComponentName;	 Catch:{ all -> 0x04d8 }
        r5 = r6.applicationInfo;	 Catch:{ all -> 0x04d8 }
        r5 = r5.packageName;	 Catch:{ all -> 0x04d8 }
        r10 = r6.name;	 Catch:{ all -> 0x04d8 }
        r0 = r16;
        r0.<init>(r5, r10);	 Catch:{ all -> 0x04d8 }
        r17 = 0;
        r18 = 0;
        r19 = 0;
        r10 = r40;
        r34 = r10.startProcessLocked(r11, r12, r13, r14, r15, r16, r17, r18, r19);	 Catch:{ all -> 0x04d8 }
        r5 = "getContentProviderImpl: after start process";
        r0 = r40;
        r1 = r38;
        r0.checkTime(r1, r5);	 Catch:{ all -> 0x04d8 }
        if (r34 != 0) goto L_0x03ea;
    L_0x0512:
        r5 = "ActivityManager";
        r10 = new java.lang.StringBuilder;	 Catch:{ all -> 0x04d8 }
        r10.<init>();	 Catch:{ all -> 0x04d8 }
        r11 = "Unable to launch app ";
        r10 = r10.append(r11);	 Catch:{ all -> 0x04d8 }
        r11 = r6.applicationInfo;	 Catch:{ all -> 0x04d8 }
        r11 = r11.packageName;	 Catch:{ all -> 0x04d8 }
        r10 = r10.append(r11);	 Catch:{ all -> 0x04d8 }
        r11 = "/";
        r10 = r10.append(r11);	 Catch:{ all -> 0x04d8 }
        r11 = r6.applicationInfo;	 Catch:{ all -> 0x04d8 }
        r11 = r11.uid;	 Catch:{ all -> 0x04d8 }
        r10 = r10.append(r11);	 Catch:{ all -> 0x04d8 }
        r11 = " for provider ";
        r10 = r10.append(r11);	 Catch:{ all -> 0x04d8 }
        r0 = r42;
        r10 = r10.append(r0);	 Catch:{ all -> 0x04d8 }
        r11 = ": process is bad";
        r10 = r10.append(r11);	 Catch:{ all -> 0x04d8 }
        r10 = r10.toString();	 Catch:{ all -> 0x04d8 }
        android.util.Slog.w(r5, r10);	 Catch:{ all -> 0x04d8 }
        r26 = 0;
        android.os.Binder.restoreCallingIdentity(r32);	 Catch:{ all -> 0x0047 }
        monitor-exit(r40);	 Catch:{ all -> 0x0047 }
        goto L_0x00e3;
    L_0x0556:
        if (r22 == 0) goto L_0x055d;
    L_0x0558:
        r5 = 1;
        r0 = r22;
        r0.waiting = r5;	 Catch:{ InterruptedException -> 0x0569, all -> 0x0573 }
    L_0x055d:
        r4.wait();	 Catch:{ InterruptedException -> 0x0569, all -> 0x0573 }
        if (r22 == 0) goto L_0x0431;
    L_0x0562:
        r5 = 0;
        r0 = r22;
        r0.waiting = r5;	 Catch:{ all -> 0x04a6 }
        goto L_0x0431;
    L_0x0569:
        r5 = move-exception;
        if (r22 == 0) goto L_0x0431;
    L_0x056c:
        r5 = 0;
        r0 = r22;
        r0.waiting = r5;	 Catch:{ all -> 0x04a6 }
        goto L_0x0431;
    L_0x0573:
        r5 = move-exception;
        if (r22 == 0) goto L_0x057b;
    L_0x0576:
        r10 = 0;
        r0 = r22;
        r0.waiting = r10;	 Catch:{ all -> 0x04a6 }
    L_0x057b:
        throw r5;	 Catch:{ all -> 0x04a6 }
    L_0x057c:
        monitor-exit(r4);	 Catch:{ all -> 0x04a6 }
        if (r4 == 0) goto L_0x0589;
    L_0x057f:
        r0 = r22;
        r5 = r4.newHolder(r0);
    L_0x0585:
        r26 = r5;
        goto L_0x00e3;
    L_0x0589:
        r5 = 0;
        goto L_0x0585;
    L_0x058b:
        r5 = move-exception;
        goto L_0x03ea;
    L_0x058e:
        r5 = move-exception;
        goto L_0x03b3;
    L_0x0591:
        r5 = move-exception;
        goto L_0x01d0;
    L_0x0594:
        r4 = r23;
        goto L_0x0346;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.ActivityManagerService.getContentProviderImpl(android.app.IApplicationThread, java.lang.String, android.os.IBinder, boolean, int):android.app.IActivityManager$ContentProviderHolder");
    }

    public final ContentProviderHolder getContentProvider(IApplicationThread caller, String name, int userId, boolean stable) {
        enforceNotIsolatedCaller("getContentProvider");
        if (caller != null) {
            return getContentProviderImpl(caller, name, null, stable, userId);
        }
        String msg = "null IApplicationThread when getting content provider " + name;
        Slog.w(TAG, msg);
        throw new SecurityException(msg);
    }

    public ContentProviderHolder getContentProviderExternal(String name, int userId, IBinder token) {
        enforceCallingPermission("android.permission.ACCESS_CONTENT_PROVIDERS_EXTERNALLY", "Do not have permission in call getContentProviderExternal()");
        return getContentProviderExternalUnchecked(name, token, handleIncomingUser(Binder.getCallingPid(), Binder.getCallingUid(), userId, (boolean) VALIDATE_TOKENS, (int) SHOW_NOT_RESPONDING_MSG, "getContentProvider", null));
    }

    private ContentProviderHolder getContentProviderExternalUnchecked(String name, IBinder token, int userId) {
        return getContentProviderImpl(null, name, token, SHOW_ACTIVITY_START_TIME, userId);
    }

    public void removeContentProvider(IBinder connection, boolean stable) {
        enforceNotIsolatedCaller("removeContentProvider");
        long ident = Binder.clearCallingIdentity();
        try {
            synchronized (this) {
                ContentProviderConnection conn = (ContentProviderConnection) connection;
                if (conn == null) {
                    throw new NullPointerException("connection is null");
                }
                if (decProviderCountLocked(conn, null, null, stable)) {
                    updateOomAdjLocked();
                }
            }
            Binder.restoreCallingIdentity(ident);
        } catch (ClassCastException e) {
            String msg = "removeContentProvider: " + connection + " not a ContentProviderConnection";
            Slog.w(TAG, msg);
            throw new IllegalArgumentException(msg);
        } catch (Throwable th) {
            Binder.restoreCallingIdentity(ident);
        }
    }

    public void removeContentProviderExternal(String name, IBinder token) {
        enforceCallingPermission("android.permission.ACCESS_CONTENT_PROVIDERS_EXTERNALLY", "Do not have permission in call removeContentProviderExternal()");
        int userId = UserHandle.getCallingUserId();
        long ident = Binder.clearCallingIdentity();
        try {
            removeContentProviderExternalUnchecked(name, token, userId);
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    private void removeContentProviderExternalUnchecked(String name, IBinder token, int userId) {
        synchronized (this) {
            ContentProviderRecord cpr = this.mProviderMap.getProviderByName(name, userId);
            if (cpr == null) {
                return;
            }
            ContentProviderRecord localCpr = this.mProviderMap.getProviderByClass(new ComponentName(cpr.info.packageName, cpr.info.name), userId);
            if (!localCpr.hasExternalProcessHandles()) {
                Slog.e(TAG, "Attmpt to remove content provider: " + localCpr + " with no external references.");
            } else if (localCpr.removeExternalProcessHandleLocked(token)) {
                updateOomAdjLocked();
            } else {
                Slog.e(TAG, "Attmpt to remove content provider " + localCpr + " with no external reference for token: " + token + ".");
            }
        }
    }

    public final void publishContentProviders(IApplicationThread caller, List<ContentProviderHolder> providers) {
        if (providers != null) {
            enforceNotIsolatedCaller("publishContentProviders");
            synchronized (this) {
                ProcessRecord r = getRecordForAppLocked(caller);
                if (r == null) {
                    throw new SecurityException("Unable to find app for caller " + caller + " (pid=" + Binder.getCallingPid() + ") when publishing content providers");
                }
                long origId = Binder.clearCallingIdentity();
                int N = providers.size();
                for (int i = MY_PID; i < N; i += SHOW_ERROR_MSG) {
                    ContentProviderHolder src = (ContentProviderHolder) providers.get(i);
                    if (!(src == null || src.info == null || src.provider == null)) {
                        ContentProviderRecord dst = (ContentProviderRecord) r.pubProviders.get(src.info.name);
                        if (dst != null) {
                            int j;
                            this.mProviderMap.putProviderByClass(new ComponentName(dst.info.packageName, dst.info.name), dst);
                            String[] names = dst.info.authority.split(";");
                            for (j = MY_PID; j < names.length; j += SHOW_ERROR_MSG) {
                                this.mProviderMap.putProviderByName(names[j], dst);
                            }
                            int NL = this.mLaunchingProviders.size();
                            j = MY_PID;
                            while (j < NL) {
                                if (this.mLaunchingProviders.get(j) == dst) {
                                    this.mLaunchingProviders.remove(j);
                                    j--;
                                    NL--;
                                }
                                j += SHOW_ERROR_MSG;
                            }
                            synchronized (dst) {
                                dst.provider = src.provider;
                                dst.proc = r;
                                dst.notifyAll();
                            }
                            updateOomAdjLocked(r);
                        } else {
                            continue;
                        }
                    }
                }
                Binder.restoreCallingIdentity(origId);
            }
        }
    }

    public boolean refContentProvider(IBinder connection, int stable, int unstable) {
        try {
            ContentProviderConnection conn = (ContentProviderConnection) connection;
            if (conn == null) {
                throw new NullPointerException("connection is null");
            }
            boolean z;
            synchronized (this) {
                if (stable > 0) {
                    conn.numStableIncs += stable;
                }
                stable += conn.stableCount;
                if (stable < 0) {
                    throw new IllegalStateException("stableCount < 0: " + stable);
                }
                if (unstable > 0) {
                    conn.numUnstableIncs += unstable;
                }
                unstable += conn.unstableCount;
                if (unstable < 0) {
                    throw new IllegalStateException("unstableCount < 0: " + unstable);
                } else if (stable + unstable <= 0) {
                    throw new IllegalStateException("ref counts can't go to zero here: stable=" + stable + " unstable=" + unstable);
                } else {
                    conn.stableCount = stable;
                    conn.unstableCount = unstable;
                    z = !conn.dead ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
                }
            }
            return z;
        } catch (ClassCastException e) {
            String msg = "refContentProvider: " + connection + " not a ContentProviderConnection";
            Slog.w(TAG, msg);
            throw new IllegalArgumentException(msg);
        }
    }

    public void unstableProviderDied(IBinder connection) {
        try {
            ContentProviderConnection conn = (ContentProviderConnection) connection;
            if (conn == null) {
                throw new NullPointerException("connection is null");
            }
            IContentProvider provider;
            synchronized (this) {
                provider = conn.provider.provider;
            }
            if (provider != null) {
                if (provider.asBinder().pingBinder()) {
                    synchronized (this) {
                        Slog.w(TAG, "unstableProviderDied: caller " + Binder.getCallingUid() + " says " + conn + " died, but we don't agree");
                    }
                    return;
                }
                synchronized (this) {
                    if (conn.provider.provider != provider) {
                        return;
                    }
                    ProcessRecord proc = conn.provider.proc;
                    if (proc == null || proc.thread == null) {
                        return;
                    }
                    Slog.i(TAG, "Process " + proc.processName + " (pid " + proc.pid + ") early provider death");
                    long ident = Binder.clearCallingIdentity();
                    try {
                        appDiedLocked(proc);
                    } finally {
                        Binder.restoreCallingIdentity(ident);
                    }
                }
            }
        } catch (ClassCastException e) {
            String msg = "refContentProvider: " + connection + " not a ContentProviderConnection";
            Slog.w(TAG, msg);
            throw new IllegalArgumentException(msg);
        }
    }

    public void appNotRespondingViaProvider(IBinder connection) {
        enforceCallingPermission("android.permission.REMOVE_TASKS", "appNotRespondingViaProvider()");
        ContentProviderConnection conn = (ContentProviderConnection) connection;
        if (conn == null) {
            Slog.w(TAG, "ContentProviderConnection is null");
            return;
        }
        ProcessRecord host = conn.provider.proc;
        if (host == null) {
            Slog.w(TAG, "Failed to find hosting ProcessRecord");
            return;
        }
        long token = Binder.clearCallingIdentity();
        try {
            appNotResponding(host, null, null, VALIDATE_TOKENS, "ContentProvider not responding");
        } finally {
            Binder.restoreCallingIdentity(token);
        }
    }

    public final void installSystemProviders() {
        synchronized (this) {
            List<ProviderInfo> providers = generateApplicationProvidersLocked((ProcessRecord) this.mProcessNames.get("system", NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY));
            if (providers != null) {
                for (int i = providers.size() - 1; i >= 0; i--) {
                    ProviderInfo pi = (ProviderInfo) providers.get(i);
                    if ((pi.applicationInfo.flags & SHOW_ERROR_MSG) == 0) {
                        Slog.w(TAG, "Not installing system proc provider " + pi.name + ": not system .apk");
                        providers.remove(i);
                    }
                }
            }
        }
        if (providers != null) {
            this.mSystemThread.installSystemProviders(providers);
        }
        this.mCoreSettingsObserver = new CoreSettingsObserver(this);
    }

    public String getProviderMimeType(Uri uri, int userId) {
        String str = null;
        enforceNotIsolatedCaller("getProviderMimeType");
        String name = uri.getAuthority();
        int callingUid = Binder.getCallingUid();
        int callingPid = Binder.getCallingPid();
        long ident = 0;
        boolean clearedIdentity = VALIDATE_TOKENS;
        userId = unsafeConvertIncomingUser(userId);
        if (canClearIdentity(callingPid, callingUid, userId)) {
            clearedIdentity = SHOW_ACTIVITY_START_TIME;
            ident = Binder.clearCallingIdentity();
        }
        try {
            ContentProviderHolder holder = getContentProviderExternalUnchecked(name, null, userId);
            if (holder != null) {
                str = holder.provider.getType(uri);
                if (!clearedIdentity) {
                    ident = Binder.clearCallingIdentity();
                }
                if (holder != null) {
                    try {
                        removeContentProviderExternalUnchecked(name, null, userId);
                    } catch (Throwable th) {
                        Binder.restoreCallingIdentity(ident);
                    }
                }
                Binder.restoreCallingIdentity(ident);
            } else {
                if (!clearedIdentity) {
                    ident = Binder.clearCallingIdentity();
                }
                if (holder != null) {
                    try {
                        removeContentProviderExternalUnchecked(name, null, userId);
                    } catch (Throwable th2) {
                        Binder.restoreCallingIdentity(ident);
                    }
                }
                Binder.restoreCallingIdentity(ident);
            }
        } catch (RemoteException e) {
            Log.w(TAG, "Content provider dead retrieving " + uri, e);
            if (!clearedIdentity) {
                ident = Binder.clearCallingIdentity();
            }
            if (MY_PID != null) {
                removeContentProviderExternalUnchecked(name, null, userId);
            }
            Binder.restoreCallingIdentity(ident);
        } catch (Throwable th3) {
            Binder.restoreCallingIdentity(ident);
        }
        return str;
    }

    private boolean canClearIdentity(int callingPid, int callingUid, int userId) {
        if (UserHandle.getUserId(callingUid) == userId || checkComponentPermission("android.permission.INTERACT_ACROSS_USERS", callingPid, callingUid, -1, SHOW_ACTIVITY_START_TIME) == 0 || checkComponentPermission("android.permission.INTERACT_ACROSS_USERS_FULL", callingPid, callingUid, -1, SHOW_ACTIVITY_START_TIME) == 0) {
            return SHOW_ACTIVITY_START_TIME;
        }
        return VALIDATE_TOKENS;
    }

    final ProcessRecord newProcessRecordLocked(ApplicationInfo info, String customProcess, boolean isolated, int isolatedUid) {
        String proc = customProcess != null ? customProcess : info.processName;
        BatteryStatsImpl stats = this.mBatteryStatsService.getActiveStatistics();
        int uid = info.uid;
        if (isolated) {
            if (isolatedUid == 0) {
                int userId = UserHandle.getUserId(uid);
                int stepsLeft = NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY;
                do {
                    if (this.mNextIsolatedProcessUid < 99000 || this.mNextIsolatedProcessUid > 99999) {
                        this.mNextIsolatedProcessUid = 99000;
                    }
                    uid = UserHandle.getUid(userId, this.mNextIsolatedProcessUid);
                    this.mNextIsolatedProcessUid += SHOW_ERROR_MSG;
                    if (this.mIsolatedProcesses.indexOfKey(uid) >= 0) {
                        stepsLeft--;
                    }
                } while (stepsLeft > 0);
                return null;
            }
            uid = isolatedUid;
        }
        return new ProcessRecord(stats, info, proc, uid);
    }

    final ProcessRecord addAppLocked(ApplicationInfo info, boolean isolated, String abiOverride) {
        ProcessRecord app;
        if (isolated) {
            app = null;
        } else {
            app = getProcessRecordLocked(info.processName, info.uid, SHOW_ACTIVITY_START_TIME);
        }
        if (app == null) {
            app = newProcessRecordLocked(info, null, isolated, MY_PID);
            this.mProcessNames.put(info.processName, app.uid, app);
            if (isolated) {
                this.mIsolatedProcesses.put(app.uid, app);
            }
            updateLruProcessLocked(app, VALIDATE_TOKENS, null);
            updateOomAdjLocked();
        }
        try {
            AppGlobals.getPackageManager().setPackageStoppedState(info.packageName, VALIDATE_TOKENS, UserHandle.getUserId(app.uid));
        } catch (RemoteException e) {
        } catch (IllegalArgumentException e2) {
            Slog.w(TAG, "Failed trying to unstop package " + info.packageName + ": " + e2);
        }
        if ((info.flags & 9) == 9) {
            app.persistent = SHOW_ACTIVITY_START_TIME;
            if (app.maxAdj >= -12) {
                app.maxAdj = -12;
            }
        }
        if (app.thread == null && this.mPersistentStartingProcesses.indexOf(app) < 0) {
            this.mPersistentStartingProcesses.add(app);
            startProcessLocked(app, "added application", app.processName, abiOverride, null, null);
        }
        return app;
    }

    public void unhandledBack() {
        enforceCallingPermission("android.permission.FORCE_BACK", "unhandledBack()");
        synchronized (this) {
            long origId = Binder.clearCallingIdentity();
            try {
                getFocusedStack().unhandledBackLocked();
                Binder.restoreCallingIdentity(origId);
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(origId);
            }
        }
    }

    public ParcelFileDescriptor openContentUri(Uri uri) throws RemoteException {
        enforceNotIsolatedCaller("openContentUri");
        int userId = UserHandle.getCallingUserId();
        String name = uri.getAuthority();
        ContentProviderHolder cph = getContentProviderExternalUnchecked(name, null, userId);
        ParcelFileDescriptor pfd = null;
        if (cph != null) {
            Binder token = new Binder();
            sCallerIdentity.set(new Identity(token, Binder.getCallingPid(), Binder.getCallingUid()));
            try {
                pfd = cph.provider.openFile(null, uri, "r", null, token);
            } catch (FileNotFoundException e) {
            } finally {
                sCallerIdentity.remove();
            }
            removeContentProviderExternalUnchecked(name, null, userId);
        } else {
            Slog.d(TAG, "Failed to get provider for authority '" + name + "'");
        }
        return pfd;
    }

    public boolean isSleepingOrShuttingDown() {
        return (isSleeping() || this.mShuttingDown) ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
    }

    public boolean isSleeping() {
        return this.mSleeping;
    }

    void onWakefulnessChanged(int wakefulness) {
        synchronized (this) {
            this.mWakefulness = wakefulness;
            updateSleepIfNeededLocked();
        }
    }

    void finishRunningVoiceLocked() {
        if (this.mRunningVoice) {
            this.mRunningVoice = VALIDATE_TOKENS;
            updateSleepIfNeededLocked();
        }
    }

    void updateSleepIfNeededLocked() {
        if (this.mSleeping && !shouldSleepLocked()) {
            this.mSleeping = VALIDATE_TOKENS;
            this.mStackSupervisor.comeOutOfSleepIfNeededLocked();
        } else if (!this.mSleeping && shouldSleepLocked()) {
            this.mSleeping = SHOW_ACTIVITY_START_TIME;
            this.mStackSupervisor.goingToSleepLocked();
            checkExcessivePowerUsageLocked(VALIDATE_TOKENS);
            this.mHandler.removeMessages(CHECK_EXCESSIVE_WAKE_LOCKS_MSG);
            this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(CHECK_EXCESSIVE_WAKE_LOCKS_MSG), 900000);
        }
    }

    private boolean shouldSleepLocked() {
        if (this.mRunningVoice) {
            return VALIDATE_TOKENS;
        }
        switch (this.mWakefulness) {
            case SHOW_ERROR_MSG /*1*/:
            case SHOW_NOT_RESPONDING_MSG /*2*/:
                if (!this.mSleeping || this.mLockScreenShown == 0) {
                    return VALIDATE_TOKENS;
                }
                return SHOW_ACTIVITY_START_TIME;
            case SHOW_FACTORY_ERROR_MSG /*3*/:
                if (this.mLockScreenShown == 0) {
                    return VALIDATE_TOKENS;
                }
                return SHOW_ACTIVITY_START_TIME;
            default:
                return SHOW_ACTIVITY_START_TIME;
        }
    }

    void notifyTaskPersisterLocked(TaskRecord task, boolean flush) {
        if (task == null || task.stack == null || !task.stack.isHomeStack()) {
            this.mTaskPersister.wakeup(task, flush);
        }
    }

    void notifyTaskStackChangedLocked() {
        this.mHandler.removeMessages(NOTIFY_TASK_STACK_CHANGE_LISTENERS_MSG);
        this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(NOTIFY_TASK_STACK_CHANGE_LISTENERS_MSG), 1000);
    }

    public boolean shutdown(int timeout) {
        if (checkCallingPermission("android.permission.SHUTDOWN") != 0) {
            throw new SecurityException("Requires permission android.permission.SHUTDOWN");
        }
        boolean timedout;
        synchronized (this) {
            this.mShuttingDown = SHOW_ACTIVITY_START_TIME;
            updateEventDispatchingLocked();
            timedout = this.mStackSupervisor.shutdownLocked(timeout);
        }
        this.mAppOpsService.shutdown();
        if (this.mUsageStatsService != null) {
            this.mUsageStatsService.prepareShutdown();
        }
        this.mBatteryStatsService.shutdown();
        synchronized (this) {
            this.mProcessStats.shutdownLocked();
            notifyTaskPersisterLocked(null, SHOW_ACTIVITY_START_TIME);
        }
        return timedout;
    }

    public final void activitySlept(IBinder token) {
        long origId = Binder.clearCallingIdentity();
        synchronized (this) {
            ActivityRecord r = ActivityRecord.isInStackLocked(token);
            if (r != null) {
                this.mStackSupervisor.activitySleptLocked(r);
            }
        }
        Binder.restoreCallingIdentity(origId);
    }

    private String lockScreenShownToString() {
        switch (this.mLockScreenShown) {
            case MY_PID:
                return "LOCK_SCREEN_HIDDEN";
            case SHOW_ERROR_MSG /*1*/:
                return "LOCK_SCREEN_LEAVING";
            case SHOW_NOT_RESPONDING_MSG /*2*/:
                return "LOCK_SCREEN_SHOWN";
            default:
                return "Unknown=" + this.mLockScreenShown;
        }
    }

    void logLockScreen(String msg) {
    }

    void startRunningVoiceLocked() {
        if (!this.mRunningVoice) {
            this.mRunningVoice = SHOW_ACTIVITY_START_TIME;
            updateSleepIfNeededLocked();
        }
    }

    private void updateEventDispatchingLocked() {
        WindowManagerService windowManagerService = this.mWindowManager;
        boolean z = (!this.mBooted || this.mShuttingDown) ? VALIDATE_TOKENS : SHOW_ACTIVITY_START_TIME;
        windowManagerService.setEventDispatching(z);
    }

    public void setLockScreenShown(boolean shown) {
        if (checkCallingPermission("android.permission.DEVICE_POWER") != 0) {
            throw new SecurityException("Requires permission android.permission.DEVICE_POWER");
        }
        synchronized (this) {
            long ident = Binder.clearCallingIdentity();
            try {
                this.mLockScreenShown = shown ? SHOW_NOT_RESPONDING_MSG : MY_PID;
                updateSleepIfNeededLocked();
                Binder.restoreCallingIdentity(ident);
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(ident);
            }
        }
    }

    public void stopAppSwitches() {
        if (checkCallingPermission("android.permission.STOP_APP_SWITCHES") != 0) {
            throw new SecurityException("Requires permission android.permission.STOP_APP_SWITCHES");
        }
        synchronized (this) {
            this.mAppSwitchesAllowedTime = SystemClock.uptimeMillis() + MONITOR_CPU_MIN_TIME;
            this.mDidAppSwitch = VALIDATE_TOKENS;
            this.mHandler.removeMessages(DO_PENDING_ACTIVITY_LAUNCHES_MSG);
            this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(DO_PENDING_ACTIVITY_LAUNCHES_MSG), MONITOR_CPU_MIN_TIME);
        }
    }

    public void resumeAppSwitches() {
        if (checkCallingPermission("android.permission.STOP_APP_SWITCHES") != 0) {
            throw new SecurityException("Requires permission android.permission.STOP_APP_SWITCHES");
        }
        synchronized (this) {
            this.mAppSwitchesAllowedTime = 0;
        }
    }

    boolean checkAppSwitchAllowedLocked(int sourcePid, int sourceUid, int callingPid, int callingUid, String name) {
        if (this.mAppSwitchesAllowedTime < SystemClock.uptimeMillis() || checkComponentPermission("android.permission.STOP_APP_SWITCHES", sourcePid, sourceUid, -1, SHOW_ACTIVITY_START_TIME) == 0) {
            return SHOW_ACTIVITY_START_TIME;
        }
        if (callingUid != -1 && callingUid != sourceUid && checkComponentPermission("android.permission.STOP_APP_SWITCHES", callingPid, callingUid, -1, SHOW_ACTIVITY_START_TIME) == 0) {
            return SHOW_ACTIVITY_START_TIME;
        }
        Slog.w(TAG, name + " request from " + sourceUid + " stopped");
        return VALIDATE_TOKENS;
    }

    public void setDebugApp(String packageName, boolean waitForDebugger, boolean persistent) {
        enforceCallingPermission("android.permission.SET_DEBUG_APP", "setDebugApp()");
        long ident = Binder.clearCallingIdentity();
        if (persistent) {
            try {
                ContentResolver resolver = this.mContext.getContentResolver();
                Global.putString(resolver, "debug_app", packageName);
                Global.putInt(resolver, "wait_for_debugger", waitForDebugger ? SHOW_ERROR_MSG : MY_PID);
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(ident);
            }
        }
        synchronized (this) {
            if (!persistent) {
                this.mOrigDebugApp = this.mDebugApp;
                this.mOrigWaitForDebugger = this.mWaitForDebugger;
            }
            this.mDebugApp = packageName;
            this.mWaitForDebugger = waitForDebugger;
            this.mDebugTransient = !persistent ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
            if (packageName != null) {
                forceStopPackageLocked(packageName, -1, VALIDATE_TOKENS, VALIDATE_TOKENS, SHOW_ACTIVITY_START_TIME, SHOW_ACTIVITY_START_TIME, VALIDATE_TOKENS, -1, "set debug app");
            }
        }
        Binder.restoreCallingIdentity(ident);
    }

    void setOpenGlTraceApp(ApplicationInfo app, String processName) {
        synchronized (this) {
            if ("1".equals(SystemProperties.get(SYSTEM_DEBUGGABLE, "0")) || (app.flags & SHOW_NOT_RESPONDING_MSG) != 0) {
                this.mOpenGlTraceApp = processName;
            } else {
                throw new SecurityException("Process not debuggable: " + app.packageName);
            }
        }
    }

    void setProfileApp(ApplicationInfo app, String processName, ProfilerInfo profilerInfo) {
        synchronized (this) {
            if ("1".equals(SystemProperties.get(SYSTEM_DEBUGGABLE, "0")) || (app.flags & SHOW_NOT_RESPONDING_MSG) != 0) {
                this.mProfileApp = processName;
                this.mProfileFile = profilerInfo.profileFile;
                if (this.mProfileFd != null) {
                    try {
                        this.mProfileFd.close();
                    } catch (IOException e) {
                    }
                    this.mProfileFd = null;
                }
                this.mProfileFd = profilerInfo.profileFd;
                this.mSamplingInterval = profilerInfo.samplingInterval;
                this.mAutoStopProfiler = profilerInfo.autoStopProfiler;
                this.mProfileType = MY_PID;
            } else {
                throw new SecurityException("Process not debuggable: " + app.packageName);
            }
        }
    }

    public void setAlwaysFinish(boolean enabled) {
        enforceCallingPermission("android.permission.SET_ALWAYS_FINISH", "setAlwaysFinish()");
        Global.putInt(this.mContext.getContentResolver(), "always_finish_activities", enabled ? SHOW_ERROR_MSG : MY_PID);
        synchronized (this) {
            this.mAlwaysFinishActivities = enabled;
        }
    }

    public void setActivityController(IActivityController controller) {
        enforceCallingPermission("android.permission.SET_ACTIVITY_WATCHER", "setActivityController()");
        synchronized (this) {
            this.mController = controller;
            Watchdog.getInstance().setActivityController(controller);
        }
    }

    public void setUserIsMonkey(boolean userIsMonkey) {
        synchronized (this) {
            synchronized (this.mPidsSelfLocked) {
                int callingPid = Binder.getCallingPid();
                ProcessRecord precessRecord = (ProcessRecord) this.mPidsSelfLocked.get(callingPid);
                if (precessRecord == null) {
                    throw new SecurityException("Unknown process: " + callingPid);
                } else if (precessRecord.instrumentationUiAutomationConnection == null) {
                    throw new SecurityException("Only an instrumentation process with a UiAutomation can call setUserIsMonkey");
                }
            }
            this.mUserIsMonkey = userIsMonkey;
        }
    }

    public boolean isUserAMonkey() {
        boolean z;
        synchronized (this) {
            z = (this.mUserIsMonkey || this.mController != null) ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
        }
        return z;
    }

    public void requestBugReport() {
        enforceCallingPermission("android.permission.DUMP", "requestBugReport");
        SystemProperties.set("ctl.start", "bugreport");
    }

    public static long getInputDispatchingTimeoutLocked(ActivityRecord r) {
        return r != null ? getInputDispatchingTimeoutLocked(r.app) : MONITOR_CPU_MIN_TIME;
    }

    public static long getInputDispatchingTimeoutLocked(ProcessRecord r) {
        if (r == null || (r.instrumentationClass == null && !r.usingWrapper)) {
            return MONITOR_CPU_MIN_TIME;
        }
        return 60000;
    }

    public long inputDispatchingTimedOut(int pid, boolean aboveSystem, String reason) {
        if (checkCallingPermission("android.permission.FILTER_EVENTS") != 0) {
            throw new SecurityException("Requires permission android.permission.FILTER_EVENTS");
        }
        synchronized (this) {
            ProcessRecord proc;
            synchronized (this.mPidsSelfLocked) {
                proc = (ProcessRecord) this.mPidsSelfLocked.get(pid);
            }
            long timeout = getInputDispatchingTimeoutLocked(proc);
        }
        if (inputDispatchingTimedOut(proc, null, null, aboveSystem, reason)) {
            return timeout;
        }
        return -1;
    }

    public boolean inputDispatchingTimedOut(ProcessRecord proc, ActivityRecord activity, ActivityRecord parent, boolean aboveSystem, String reason) {
        if (checkCallingPermission("android.permission.FILTER_EVENTS") != 0) {
            throw new SecurityException("Requires permission android.permission.FILTER_EVENTS");
        }
        String annotation;
        if (reason == null) {
            annotation = "Input dispatching timed out";
        } else {
            annotation = "Input dispatching timed out (" + reason + ")";
        }
        if (proc != null) {
            synchronized (this) {
                if (proc.debugging) {
                    return VALIDATE_TOKENS;
                } else if (this.mDidDexOpt) {
                    this.mDidDexOpt = VALIDATE_TOKENS;
                    return VALIDATE_TOKENS;
                } else if (proc.instrumentationClass != null) {
                    Bundle info = new Bundle();
                    info.putString("shortMsg", "keyDispatchingTimedOut");
                    info.putString("longMsg", annotation);
                    finishInstrumentationLocked(proc, MY_PID, info);
                    return SHOW_ACTIVITY_START_TIME;
                } else {
                    this.mHandler.post(new AnonymousClass10(proc, activity, parent, aboveSystem, annotation));
                }
            }
        }
        return SHOW_ACTIVITY_START_TIME;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public android.os.Bundle getAssistContextExtras(int r5) {
        /*
        r4 = this;
        r1 = 0;
        r2 = android.os.UserHandle.getCallingUserId();
        r0 = r4.enqueueAssistContext(r5, r1, r1, r2);
        if (r0 != 0) goto L_0x000c;
    L_0x000b:
        return r1;
    L_0x000c:
        monitor-enter(r0);
    L_0x000d:
        r1 = r0.haveResult;	 Catch:{ all -> 0x0034 }
        if (r1 != 0) goto L_0x0017;
    L_0x0011:
        r0.wait();	 Catch:{ InterruptedException -> 0x0015 }
        goto L_0x000d;
    L_0x0015:
        r1 = move-exception;
        goto L_0x000d;
    L_0x0017:
        r1 = r0.result;	 Catch:{ all -> 0x0034 }
        if (r1 == 0) goto L_0x0024;
    L_0x001b:
        r1 = r0.extras;	 Catch:{ all -> 0x0034 }
        r2 = "android.intent.extra.ASSIST_CONTEXT";
        r3 = r0.result;	 Catch:{ all -> 0x0034 }
        r1.putBundle(r2, r3);	 Catch:{ all -> 0x0034 }
    L_0x0024:
        monitor-exit(r0);	 Catch:{ all -> 0x0034 }
        monitor-enter(r4);
        r1 = r4.mPendingAssistExtras;	 Catch:{ all -> 0x0037 }
        r1.remove(r0);	 Catch:{ all -> 0x0037 }
        r1 = r4.mHandler;	 Catch:{ all -> 0x0037 }
        r1.removeCallbacks(r0);	 Catch:{ all -> 0x0037 }
        monitor-exit(r4);	 Catch:{ all -> 0x0037 }
        r1 = r0.extras;
        goto L_0x000b;
    L_0x0034:
        r1 = move-exception;
        monitor-exit(r0);	 Catch:{ all -> 0x0034 }
        throw r1;
    L_0x0037:
        r1 = move-exception;
        monitor-exit(r4);	 Catch:{ all -> 0x0037 }
        throw r1;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.ActivityManagerService.getAssistContextExtras(int):android.os.Bundle");
    }

    private PendingAssistExtras enqueueAssistContext(int requestType, Intent intent, String hint, int userHandle) {
        enforceCallingPermission("android.permission.GET_TOP_ACTIVITY_INFO", "getAssistContextExtras()");
        Bundle extras = new Bundle();
        synchronized (this) {
            ActivityRecord activity = getFocusedStack().mResumedActivity;
            if (activity == null) {
                Slog.w(TAG, "getAssistContextExtras failed: no resumed activity");
                return null;
            }
            extras.putString("android.intent.extra.ASSIST_PACKAGE", activity.packageName);
            if (activity.app == null || activity.app.thread == null) {
                Slog.w(TAG, "getAssistContextExtras failed: no process for " + activity);
                return null;
            } else if (activity.app.pid == Binder.getCallingPid()) {
                Slog.w(TAG, "getAssistContextExtras failed: request process same as " + activity);
                return null;
            } else {
                PendingAssistExtras pae = new PendingAssistExtras(activity, extras, intent, hint, userHandle);
                try {
                    activity.app.thread.requestAssistContextExtras(activity.appToken, pae, requestType);
                    this.mPendingAssistExtras.add(pae);
                    this.mHandler.postDelayed(pae, 500);
                    return pae;
                } catch (RemoteException e) {
                    Slog.w(TAG, "getAssistContextExtras failed: crash calling " + activity);
                    return null;
                }
            }
        }
    }

    public void reportAssistContextExtras(IBinder token, Bundle extras) {
        PendingAssistExtras pae = (PendingAssistExtras) token;
        synchronized (pae) {
            pae.result = extras;
            pae.haveResult = SHOW_ACTIVITY_START_TIME;
            pae.notifyAll();
            if (pae.intent == null) {
                return;
            }
            synchronized (this) {
                boolean exists = this.mPendingAssistExtras.remove(pae);
                this.mHandler.removeCallbacks(pae);
                if (exists) {
                    pae.intent.replaceExtras(extras);
                    if (pae.hint != null) {
                        pae.intent.putExtra(pae.hint, SHOW_ACTIVITY_START_TIME);
                    }
                    pae.intent.setFlags(872415232);
                    closeSystemDialogs("assist");
                    try {
                        this.mContext.startActivityAsUser(pae.intent, new UserHandle(pae.userHandle));
                        return;
                    } catch (ActivityNotFoundException e) {
                        Slog.w(TAG, "No activity to handle assist action.", e);
                        return;
                    }
                }
            }
        }
    }

    public boolean launchAssistIntent(Intent intent, int requestType, String hint, int userHandle) {
        return enqueueAssistContext(requestType, intent, hint, userHandle) != null ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
    }

    public void registerProcessObserver(IProcessObserver observer) {
        enforceCallingPermission("android.permission.SET_ACTIVITY_WATCHER", "registerProcessObserver()");
        synchronized (this) {
            this.mProcessObservers.register(observer);
        }
    }

    public void unregisterProcessObserver(IProcessObserver observer) {
        synchronized (this) {
            this.mProcessObservers.unregister(observer);
        }
    }

    public boolean convertFromTranslucent(IBinder token) {
        boolean z = VALIDATE_TOKENS;
        long origId = Binder.clearCallingIdentity();
        try {
            synchronized (this) {
                ActivityRecord r = ActivityRecord.isInStackLocked(token);
                if (r == null) {
                } else {
                    z = r.changeWindowTranslucency(SHOW_ACTIVITY_START_TIME);
                    if (z) {
                        r.task.stack.releaseBackgroundResources();
                        this.mStackSupervisor.ensureActivitiesVisibleLocked(null, MY_PID);
                    }
                    this.mWindowManager.setAppFullscreen(token, SHOW_ACTIVITY_START_TIME);
                    Binder.restoreCallingIdentity(origId);
                }
            }
            return z;
        } finally {
            Binder.restoreCallingIdentity(origId);
        }
    }

    public boolean convertToTranslucent(IBinder token, ActivityOptions options) {
        boolean z = VALIDATE_TOKENS;
        long origId = Binder.clearCallingIdentity();
        try {
            synchronized (this) {
                ActivityRecord r = ActivityRecord.isInStackLocked(token);
                if (r == null) {
                } else {
                    int index = r.task.mActivities.lastIndexOf(r);
                    if (index > 0) {
                        ((ActivityRecord) r.task.mActivities.get(index - 1)).returningOptions = options;
                    }
                    z = r.changeWindowTranslucency(VALIDATE_TOKENS);
                    if (z) {
                        r.task.stack.convertToTranslucent(r);
                    }
                    this.mStackSupervisor.ensureActivitiesVisibleLocked(null, MY_PID);
                    this.mWindowManager.setAppFullscreen(token, VALIDATE_TOKENS);
                    Binder.restoreCallingIdentity(origId);
                }
            }
            return z;
        } finally {
            Binder.restoreCallingIdentity(origId);
        }
    }

    public boolean requestVisibleBehind(IBinder token, boolean visible) {
        long origId = Binder.clearCallingIdentity();
        try {
            synchronized (this) {
                ActivityRecord r = ActivityRecord.isInStackLocked(token);
                if (r != null) {
                    boolean requestVisibleBehindLocked = this.mStackSupervisor.requestVisibleBehindLocked(r, visible);
                    return requestVisibleBehindLocked;
                }
                Binder.restoreCallingIdentity(origId);
                return VALIDATE_TOKENS;
            }
        } finally {
            Binder.restoreCallingIdentity(origId);
        }
    }

    public boolean isBackgroundVisibleBehind(IBinder token) {
        long origId = Binder.clearCallingIdentity();
        try {
            boolean visible;
            synchronized (this) {
                ActivityStack stack = ActivityRecord.getStackLocked(token);
                visible = stack == null ? VALIDATE_TOKENS : stack.hasVisibleBehindActivity();
            }
            return visible;
        } finally {
            Binder.restoreCallingIdentity(origId);
        }
    }

    public ActivityOptions getActivityOptions(IBinder token) {
        ActivityOptions activityOptions = null;
        long origId = Binder.clearCallingIdentity();
        try {
            synchronized (this) {
                ActivityRecord r = ActivityRecord.isInStackLocked(token);
                if (r != null) {
                    activityOptions = r.pendingOptions;
                    r.pendingOptions = null;
                } else {
                    Binder.restoreCallingIdentity(origId);
                }
            }
            return activityOptions;
        } finally {
            Binder.restoreCallingIdentity(origId);
        }
    }

    public void setImmersive(IBinder token, boolean immersive) {
        synchronized (this) {
            ActivityRecord r = ActivityRecord.isInStackLocked(token);
            if (r == null) {
                throw new IllegalArgumentException();
            }
            r.immersive = immersive;
            if (r == this.mFocusedActivity) {
                applyUpdateLockStateLocked(r);
            }
        }
    }

    public boolean isImmersive(IBinder token) {
        boolean z;
        synchronized (this) {
            ActivityRecord r = ActivityRecord.isInStackLocked(token);
            if (r == null) {
                throw new IllegalArgumentException();
            }
            z = r.immersive;
        }
        return z;
    }

    public boolean isTopActivityImmersive() {
        boolean z;
        enforceNotIsolatedCaller("startActivity");
        synchronized (this) {
            ActivityRecord r = getFocusedStack().topRunningActivityLocked(null);
            z = r != null ? r.immersive : VALIDATE_TOKENS;
        }
        return z;
    }

    public boolean isTopOfTask(IBinder token) {
        boolean z;
        synchronized (this) {
            ActivityRecord r = ActivityRecord.isInStackLocked(token);
            if (r == null) {
                throw new IllegalArgumentException();
            }
            z = r.task.getTopActivity() == r ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
        }
        return z;
    }

    public final void enterSafeMode() {
        synchronized (this) {
            if (!this.mSystemReady) {
                try {
                    AppGlobals.getPackageManager().enterSafeMode();
                } catch (RemoteException e) {
                }
            }
            this.mSafeMode = SHOW_ACTIVITY_START_TIME;
        }
    }

    public final void showSafeModeOverlay() {
        View v = LayoutInflater.from(this.mContext).inflate(17367219, null);
        LayoutParams lp = new LayoutParams();
        lp.type = 2015;
        lp.width = -2;
        lp.height = -2;
        lp.gravity = 8388691;
        lp.format = v.getBackground().getOpacity();
        lp.flags = POST_HEAVY_NOTIFICATION_MSG;
        lp.privateFlags |= 16;
        ((WindowManager) this.mContext.getSystemService("window")).addView(v, lp);
    }

    public void noteWakeupAlarm(IIntentSender sender, int sourceUid, String sourcePkg) {
        if (sender instanceof PendingIntentRecord) {
            BatteryStatsImpl stats = this.mBatteryStatsService.getActiveStatistics();
            synchronized (stats) {
                if (this.mBatteryStatsService.isOnBattery()) {
                    this.mBatteryStatsService.enforceCallingPermission();
                    PendingIntentRecord rec = (PendingIntentRecord) sender;
                    int uid = rec.uid == Binder.getCallingUid() ? NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY : rec.uid;
                    if (sourceUid < 0) {
                        sourceUid = uid;
                    }
                    if (sourcePkg == null) {
                        sourcePkg = rec.key.packageName;
                    }
                    stats.getPackageStatsLocked(sourceUid, sourcePkg).incWakeupsLocked();
                }
            }
        }
    }

    public boolean killPids(int[] pids, String pReason, boolean secure) {
        if (Binder.getCallingUid() != NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY) {
            throw new SecurityException("killPids only available to the system");
        }
        String reason;
        if (pReason == null) {
            reason = "Unknown";
        } else {
            reason = pReason;
        }
        boolean killed = VALIDATE_TOKENS;
        synchronized (this.mPidsSelfLocked) {
            int i;
            int[] types = new int[pids.length];
            int worstType = MY_PID;
            for (i = MY_PID; i < pids.length; i += SHOW_ERROR_MSG) {
                ProcessRecord proc = (ProcessRecord) this.mPidsSelfLocked.get(pids[i]);
                if (proc != null) {
                    int type = proc.setAdj;
                    types[i] = type;
                    if (type > worstType) {
                        worstType = type;
                    }
                }
            }
            if (worstType < SHOW_FINGERPRINT_ERROR_MSG && worstType > 9) {
                worstType = 9;
            }
            if (!secure && worstType < GC_BACKGROUND_PROCESSES_MSG) {
                worstType = GC_BACKGROUND_PROCESSES_MSG;
            }
            Slog.w(TAG, "Killing processes " + reason + " at adjustment " + worstType);
            for (i = MY_PID; i < pids.length; i += SHOW_ERROR_MSG) {
                proc = (ProcessRecord) this.mPidsSelfLocked.get(pids[i]);
                if (!(proc == null || proc.setAdj < worstType || proc.killedByAm)) {
                    proc.kill(reason, SHOW_ACTIVITY_START_TIME);
                    killed = SHOW_ACTIVITY_START_TIME;
                }
            }
        }
        return killed;
    }

    public void killUid(int uid, String reason) {
        if (Binder.getCallingUid() != NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY) {
            throw new SecurityException("killUid only available to the system");
        }
        synchronized (this) {
            killPackageProcessesLocked(null, UserHandle.getAppId(uid), UserHandle.getUserId(uid), -1, VALIDATE_TOKENS, SHOW_ACTIVITY_START_TIME, SHOW_ACTIVITY_START_TIME, VALIDATE_TOKENS, reason != null ? reason : "kill uid");
        }
    }

    public boolean killProcessesBelowForeground(String reason) {
        if (Binder.getCallingUid() == NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY) {
            return killProcessesBelowAdj(MY_PID, reason);
        }
        throw new SecurityException("killProcessesBelowForeground() only available to system");
    }

    private boolean killProcessesBelowAdj(int belowAdj, String reason) {
        if (Binder.getCallingUid() != NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY) {
            throw new SecurityException("killProcessesBelowAdj() only available to system");
        }
        boolean killed = VALIDATE_TOKENS;
        synchronized (this.mPidsSelfLocked) {
            int size = this.mPidsSelfLocked.size();
            for (int i = MY_PID; i < size; i += SHOW_ERROR_MSG) {
                int pid = this.mPidsSelfLocked.keyAt(i);
                ProcessRecord proc = (ProcessRecord) this.mPidsSelfLocked.valueAt(i);
                if (!(proc == null || proc.setAdj <= belowAdj || proc.killedByAm)) {
                    proc.kill(reason, SHOW_ACTIVITY_START_TIME);
                    killed = SHOW_ACTIVITY_START_TIME;
                }
            }
        }
        return killed;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void hang(android.os.IBinder r6, boolean r7) {
        /*
        r5 = this;
        r2 = "android.permission.SET_ACTIVITY_WATCHER";
        r2 = r5.checkCallingPermission(r2);
        if (r2 == 0) goto L_0x0010;
    L_0x0008:
        r2 = new java.lang.SecurityException;
        r3 = "Requires permission android.permission.SET_ACTIVITY_WATCHER";
        r2.<init>(r3);
        throw r2;
    L_0x0010:
        r0 = new com.android.server.am.ActivityManagerService$11;
        r0.<init>();
        r2 = 0;
        r6.linkToDeath(r0, r2);	 Catch:{ RemoteException -> 0x004a }
        monitor-enter(r5);
        r2 = com.android.server.Watchdog.getInstance();	 Catch:{ all -> 0x005e }
        r2.setAllowRestart(r7);	 Catch:{ all -> 0x005e }
        r2 = "ActivityManager";
        r3 = new java.lang.StringBuilder;	 Catch:{ all -> 0x005e }
        r3.<init>();	 Catch:{ all -> 0x005e }
        r4 = "Hanging system process at request of pid ";
        r3 = r3.append(r4);	 Catch:{ all -> 0x005e }
        r4 = android.os.Binder.getCallingPid();	 Catch:{ all -> 0x005e }
        r3 = r3.append(r4);	 Catch:{ all -> 0x005e }
        r3 = r3.toString();	 Catch:{ all -> 0x005e }
        android.util.Slog.i(r2, r3);	 Catch:{ all -> 0x005e }
        monitor-enter(r0);	 Catch:{ all -> 0x005e }
    L_0x003e:
        r2 = r6.isBinderAlive();	 Catch:{ all -> 0x0061 }
        if (r2 == 0) goto L_0x0053;
    L_0x0044:
        r0.wait();	 Catch:{ InterruptedException -> 0x0048 }
        goto L_0x003e;
    L_0x0048:
        r2 = move-exception;
        goto L_0x003e;
    L_0x004a:
        r1 = move-exception;
        r2 = "ActivityManager";
        r3 = "hang: given caller IBinder is already dead.";
        android.util.Slog.w(r2, r3);
    L_0x0052:
        return;
    L_0x0053:
        monitor-exit(r0);	 Catch:{ all -> 0x0061 }
        r2 = com.android.server.Watchdog.getInstance();	 Catch:{ all -> 0x005e }
        r3 = 1;
        r2.setAllowRestart(r3);	 Catch:{ all -> 0x005e }
        monitor-exit(r5);	 Catch:{ all -> 0x005e }
        goto L_0x0052;
    L_0x005e:
        r2 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x005e }
        throw r2;
    L_0x0061:
        r2 = move-exception;
        monitor-exit(r0);	 Catch:{ all -> 0x0061 }
        throw r2;	 Catch:{ all -> 0x005e }
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.ActivityManagerService.hang(android.os.IBinder, boolean):void");
    }

    public void restart() {
        if (checkCallingPermission("android.permission.SET_ACTIVITY_WATCHER") != 0) {
            throw new SecurityException("Requires permission android.permission.SET_ACTIVITY_WATCHER");
        }
        Log.i(TAG, "Sending shutdown broadcast...");
        BroadcastReceiver br = new BroadcastReceiver() {
            public void onReceive(Context context, Intent intent) {
                Log.i(ActivityManagerService.TAG, "Shutting down activity manager...");
                ActivityManagerService.this.shutdown(ActivityManagerService.PROC_START_TIMEOUT);
                Log.i(ActivityManagerService.TAG, "Shutdown complete, restarting!");
                Process.killProcess(Process.myPid());
                System.exit(10);
            }
        };
        Intent intent = new Intent("android.intent.action.ACTION_SHUTDOWN");
        intent.addFlags(268435456);
        intent.putExtra("android.intent.extra.SHUTDOWN_USERSPACE_ONLY", SHOW_ACTIVITY_START_TIME);
        br.onReceive(this.mContext, intent);
    }

    private long getLowRamTimeSinceIdle(long now) {
        long j = 0;
        long j2 = this.mLowRamTimeSinceLastIdle;
        if (this.mLowRamStartTime > 0) {
            j = now - this.mLowRamStartTime;
        }
        return j + j2;
    }

    public void performIdleMaintenance() {
        if (checkCallingPermission("android.permission.SET_ACTIVITY_WATCHER") != 0) {
            throw new SecurityException("Requires permission android.permission.SET_ACTIVITY_WATCHER");
        }
        synchronized (this) {
            long now = SystemClock.uptimeMillis();
            long timeSinceLastIdle = now - this.mLastIdleTime;
            long lowRamSinceLastIdle = getLowRamTimeSinceIdle(now);
            this.mLastIdleTime = now;
            this.mLowRamTimeSinceLastIdle = 0;
            if (this.mLowRamStartTime != 0) {
                this.mLowRamStartTime = now;
            }
            StringBuilder sb = new StringBuilder(MAX_PERSISTED_URI_GRANTS);
            sb.append("Idle maintenance over ");
            TimeUtils.formatDuration(timeSinceLastIdle, sb);
            sb.append(" low RAM for ");
            TimeUtils.formatDuration(lowRamSinceLastIdle, sb);
            Slog.i(TAG, sb.toString());
            boolean doKilling = lowRamSinceLastIdle > timeSinceLastIdle / 3 ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
            for (int i = this.mLruProcesses.size() - 1; i >= 0; i--) {
                ProcessRecord proc = (ProcessRecord) this.mLruProcesses.get(i);
                if (proc.notCachedSinceIdle) {
                    if (proc.setProcState > SHOW_NOT_RESPONDING_MSG && proc.setProcState <= 7 && doKilling && proc.initialIdlePss != 0 && proc.lastPss > (proc.initialIdlePss * 3) / 2) {
                        sb = new StringBuilder(MAX_PERSISTED_URI_GRANTS);
                        sb.append("Kill");
                        sb.append(proc.processName);
                        sb.append(" in idle maint: pss=");
                        sb.append(proc.lastPss);
                        sb.append(", initialPss=");
                        sb.append(proc.initialIdlePss);
                        sb.append(", period=");
                        TimeUtils.formatDuration(timeSinceLastIdle, sb);
                        sb.append(", lowRamPeriod=");
                        TimeUtils.formatDuration(lowRamSinceLastIdle, sb);
                        Slog.wtfQuiet(TAG, sb.toString());
                        proc.kill("idle maint (pss " + proc.lastPss + " from " + proc.initialIdlePss + ")", SHOW_ACTIVITY_START_TIME);
                    }
                } else if (proc.setProcState < 9) {
                    proc.notCachedSinceIdle = SHOW_ACTIVITY_START_TIME;
                    proc.initialIdlePss = 0;
                    proc.nextPssTime = ProcessList.computeNextPssTime(proc.curProcState, SHOW_ACTIVITY_START_TIME, this.mTestPssMode, isSleeping(), now);
                }
            }
            this.mHandler.removeMessages(REQUEST_ALL_PSS_MSG);
            this.mHandler.sendEmptyMessageDelayed(REQUEST_ALL_PSS_MSG, 120000);
        }
    }

    private void retrieveSettings() {
        boolean waitForDebugger;
        boolean alwaysFinishActivities;
        boolean forceRtl;
        ContentResolver resolver = this.mContext.getContentResolver();
        String debugApp = Global.getString(resolver, "debug_app");
        if (Global.getInt(resolver, "wait_for_debugger", MY_PID) != 0) {
            waitForDebugger = SHOW_ACTIVITY_START_TIME;
        } else {
            waitForDebugger = VALIDATE_TOKENS;
        }
        if (Global.getInt(resolver, "always_finish_activities", MY_PID) != 0) {
            alwaysFinishActivities = SHOW_ACTIVITY_START_TIME;
        } else {
            alwaysFinishActivities = VALIDATE_TOKENS;
        }
        if (Global.getInt(resolver, "debug.force_rtl", MY_PID) != 0) {
            forceRtl = SHOW_ACTIVITY_START_TIME;
        } else {
            forceRtl = VALIDATE_TOKENS;
        }
        SystemProperties.set("debug.force_rtl", forceRtl ? "1" : "0");
        Configuration configuration = new Configuration();
        System.getConfiguration(resolver, configuration);
        if (forceRtl) {
            configuration.setLayoutDirection(configuration.locale);
        }
        synchronized (this) {
            this.mOrigDebugApp = debugApp;
            this.mDebugApp = debugApp;
            this.mOrigWaitForDebugger = waitForDebugger;
            this.mWaitForDebugger = waitForDebugger;
            this.mAlwaysFinishActivities = alwaysFinishActivities;
            updateConfigurationLocked(configuration, null, VALIDATE_TOKENS, SHOW_ACTIVITY_START_TIME);
        }
    }

    private void loadResourcesOnSystemReady() {
        Resources res = this.mContext.getResources();
        this.mHasRecents = res.getBoolean(17956990);
        this.mThumbnailWidth = res.getDimensionPixelSize(17104898);
        this.mThumbnailHeight = res.getDimensionPixelSize(17104897);
    }

    public boolean testIsSystemReady() {
        return this.mSystemReady;
    }

    private static File getCalledPreBootReceiversFile() {
        return new File(new File(Environment.getDataDirectory(), "system"), CALLED_PRE_BOOTS_FILENAME);
    }

    private static ArrayList<ComponentName> readLastDonePreBootReceivers() {
        IOException e;
        Throwable th;
        ArrayList<ComponentName> lastDoneReceivers = new ArrayList();
        FileInputStream fis = null;
        try {
            FileInputStream fis2 = new FileInputStream(getCalledPreBootReceiversFile());
            try {
                DataInputStream dis = new DataInputStream(new BufferedInputStream(fis2, DumpState.DUMP_KEYSETS));
                if (dis.readInt() == PROC_START_TIMEOUT) {
                    String vers = dis.readUTF();
                    String codename = dis.readUTF();
                    String build = dis.readUTF();
                    if (VERSION.RELEASE.equals(vers) && VERSION.CODENAME.equals(codename) && VERSION.INCREMENTAL.equals(build)) {
                        int num = dis.readInt();
                        while (num > 0) {
                            num--;
                            lastDoneReceivers.add(new ComponentName(dis.readUTF(), dis.readUTF()));
                        }
                    }
                }
                if (fis2 != null) {
                    try {
                        fis2.close();
                        fis = fis2;
                    } catch (IOException e2) {
                        fis = fis2;
                    }
                }
            } catch (FileNotFoundException e3) {
                fis = fis2;
                if (fis != null) {
                    try {
                        fis.close();
                    } catch (IOException e4) {
                    }
                }
                return lastDoneReceivers;
            } catch (IOException e5) {
                e = e5;
                fis = fis2;
                try {
                    Slog.w(TAG, "Failure reading last done pre-boot receivers", e);
                    if (fis != null) {
                        try {
                            fis.close();
                        } catch (IOException e6) {
                        }
                    }
                    return lastDoneReceivers;
                } catch (Throwable th2) {
                    th = th2;
                    if (fis != null) {
                        try {
                            fis.close();
                        } catch (IOException e7) {
                        }
                    }
                    throw th;
                }
            } catch (Throwable th3) {
                th = th3;
                fis = fis2;
                if (fis != null) {
                    fis.close();
                }
                throw th;
            }
        } catch (FileNotFoundException e8) {
            if (fis != null) {
                fis.close();
            }
            return lastDoneReceivers;
        } catch (IOException e9) {
            e = e9;
            Slog.w(TAG, "Failure reading last done pre-boot receivers", e);
            if (fis != null) {
                fis.close();
            }
            return lastDoneReceivers;
        }
        return lastDoneReceivers;
    }

    private static void writeLastDonePreBootReceivers(ArrayList<ComponentName> list) {
        IOException e;
        Throwable th;
        File file = getCalledPreBootReceiversFile();
        FileOutputStream fos = null;
        DataOutputStream dos = null;
        try {
            DataOutputStream dos2;
            FileOutputStream fos2 = new FileOutputStream(file);
            try {
                dos2 = new DataOutputStream(new BufferedOutputStream(fos2, DumpState.DUMP_KEYSETS));
            } catch (IOException e2) {
                e = e2;
                fos = fos2;
                try {
                    Slog.w(TAG, "Failure writing last done pre-boot receivers", e);
                    file.delete();
                    FileUtils.sync(fos);
                    if (dos == null) {
                        try {
                            dos.close();
                        } catch (IOException e3) {
                            e3.printStackTrace();
                            return;
                        }
                    }
                } catch (Throwable th2) {
                    th = th2;
                    FileUtils.sync(fos);
                    if (dos != null) {
                        try {
                            dos.close();
                        } catch (IOException e32) {
                            e32.printStackTrace();
                        }
                    }
                    throw th;
                }
            } catch (Throwable th3) {
                th = th3;
                fos = fos2;
                FileUtils.sync(fos);
                if (dos != null) {
                    dos.close();
                }
                throw th;
            }
            try {
                dos2.writeInt(PROC_START_TIMEOUT);
                dos2.writeUTF(VERSION.RELEASE);
                dos2.writeUTF(VERSION.CODENAME);
                dos2.writeUTF(VERSION.INCREMENTAL);
                dos2.writeInt(list.size());
                for (int i = MY_PID; i < list.size(); i += SHOW_ERROR_MSG) {
                    dos2.writeUTF(((ComponentName) list.get(i)).getPackageName());
                    dos2.writeUTF(((ComponentName) list.get(i)).getClassName());
                }
                FileUtils.sync(fos2);
                if (dos2 != null) {
                    try {
                        dos2.close();
                        dos = dos2;
                        fos = fos2;
                        return;
                    } catch (IOException e322) {
                        e322.printStackTrace();
                        dos = dos2;
                        fos = fos2;
                        return;
                    }
                }
                fos = fos2;
            } catch (IOException e4) {
                e322 = e4;
                dos = dos2;
                fos = fos2;
                Slog.w(TAG, "Failure writing last done pre-boot receivers", e322);
                file.delete();
                FileUtils.sync(fos);
                if (dos == null) {
                    dos.close();
                }
            } catch (Throwable th4) {
                th = th4;
                dos = dos2;
                fos = fos2;
                FileUtils.sync(fos);
                if (dos != null) {
                    dos.close();
                }
                throw th;
            }
        } catch (IOException e5) {
            e322 = e5;
            Slog.w(TAG, "Failure writing last done pre-boot receivers", e322);
            file.delete();
            FileUtils.sync(fos);
            if (dos == null) {
                dos.close();
            }
        }
    }

    private boolean deliverPreBootCompleted(Runnable onFinishCallback, ArrayList<ComponentName> doneReceivers, int userId) {
        boolean waitingUpdate = VALIDATE_TOKENS;
        Intent intent = new Intent("android.intent.action.PRE_BOOT_COMPLETED");
        List<ResolveInfo> ris = null;
        try {
            ris = AppGlobals.getPackageManager().queryIntentReceivers(intent, null, MY_PID, userId);
        } catch (RemoteException e) {
        }
        if (ris != null) {
            int i;
            ActivityInfo ai;
            ComponentName componentName;
            int[] users;
            for (i = ris.size() - 1; i >= 0; i--) {
                if ((((ResolveInfo) ris.get(i)).activityInfo.applicationInfo.flags & SHOW_ERROR_MSG) == 0) {
                    ris.remove(i);
                }
            }
            intent.addFlags(33554432);
            if (userId == 0) {
                ArrayList<ComponentName> lastDoneReceivers = readLastDonePreBootReceivers();
                i = MY_PID;
                while (i < ris.size()) {
                    ai = ((ResolveInfo) ris.get(i)).activityInfo;
                    componentName = new ComponentName(ai.packageName, ai.name);
                    if (lastDoneReceivers.contains(componentName)) {
                        ris.remove(i);
                        i--;
                        doneReceivers.add(componentName);
                    }
                    i += SHOW_ERROR_MSG;
                }
            }
            if (userId == 0) {
                users = getUsersLocked();
            } else {
                users = new int[SHOW_ERROR_MSG];
                users[MY_PID] = userId;
            }
            for (i = MY_PID; i < ris.size(); i += SHOW_ERROR_MSG) {
                ai = ((ResolveInfo) ris.get(i)).activityInfo;
                componentName = new ComponentName(ai.packageName, ai.name);
                doneReceivers.add(componentName);
                intent.setComponent(componentName);
                int j = MY_PID;
                while (j < users.length) {
                    IIntentReceiver finisher = null;
                    if (i == ris.size() - 1 && j == users.length - 1 && onFinishCallback != null) {
                        finisher = new AnonymousClass13(onFinishCallback);
                    }
                    Slog.i(TAG, "Sending system update to " + intent.getComponent() + " for user " + users[j]);
                    broadcastIntentLocked(null, null, intent, null, finisher, MY_PID, null, null, null, -1, SHOW_ACTIVITY_START_TIME, VALIDATE_TOKENS, MY_PID, NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY, users[j]);
                    if (finisher != null) {
                        waitingUpdate = SHOW_ACTIVITY_START_TIME;
                    }
                    j += SHOW_ERROR_MSG;
                }
            }
        }
        return waitingUpdate;
    }

    private boolean makeAppCrashingLocked(ProcessRecord app, String shortMsg, String longMsg, String stackTrace) {
        app.crashing = SHOW_ACTIVITY_START_TIME;
        app.crashingReport = generateProcessError(app, SHOW_ERROR_MSG, null, shortMsg, longMsg, stackTrace);
        startAppProblemLocked(app);
        app.stopFreezingAllLocked();
        return handleAppCrashLocked(app, shortMsg, longMsg, stackTrace);
    }

    private void makeAppNotRespondingLocked(ProcessRecord app, String activity, String shortMsg, String longMsg) {
        app.notResponding = SHOW_ACTIVITY_START_TIME;
        app.notRespondingReport = generateProcessError(app, SHOW_NOT_RESPONDING_MSG, activity, shortMsg, longMsg, null);
        startAppProblemLocked(app);
        app.stopFreezingAllLocked();
    }

    private ProcessErrorStateInfo generateProcessError(ProcessRecord app, int condition, String activity, String shortMsg, String longMsg, String stackTrace) {
        ProcessErrorStateInfo report = new ProcessErrorStateInfo();
        report.condition = condition;
        report.processName = app.processName;
        report.pid = app.pid;
        report.uid = app.info.uid;
        report.tag = activity;
        report.shortMsg = shortMsg;
        report.longMsg = longMsg;
        report.stackTrace = stackTrace;
        return report;
    }

    void killAppAtUsersRequest(ProcessRecord app, Dialog fromDialog) {
        synchronized (this) {
            app.crashing = VALIDATE_TOKENS;
            app.crashingReport = null;
            app.notResponding = VALIDATE_TOKENS;
            app.notRespondingReport = null;
            if (app.anrDialog == fromDialog) {
                app.anrDialog = null;
            }
            if (app.waitDialog == fromDialog) {
                app.waitDialog = null;
            }
            if (app.pid > 0 && app.pid != MY_PID) {
                handleAppCrashLocked(app, null, null, null);
                app.kill("user request after error", SHOW_ACTIVITY_START_TIME);
            }
        }
    }

    private boolean handleAppCrashLocked(ProcessRecord app, String shortMsg, String longMsg, String stackTrace) {
        Long crashTime;
        long now = SystemClock.uptimeMillis();
        if (app.isolated) {
            crashTime = null;
        } else {
            crashTime = (Long) this.mProcessCrashTimes.get(app.info.processName, app.uid);
        }
        if (crashTime == null || now >= crashTime.longValue() + 60000) {
            this.mStackSupervisor.finishTopRunningActivityLocked(app);
        } else {
            Slog.w(TAG, "Process " + app.info.processName + " has crashed too many times: killing!");
            Object[] objArr = new Object[SHOW_FACTORY_ERROR_MSG];
            objArr[MY_PID] = Integer.valueOf(app.userId);
            objArr[SHOW_ERROR_MSG] = app.info.processName;
            objArr[SHOW_NOT_RESPONDING_MSG] = Integer.valueOf(app.uid);
            EventLog.writeEvent(EventLogTags.AM_PROCESS_CRASHED_TOO_MUCH, objArr);
            this.mStackSupervisor.handleAppCrashLocked(app);
            if (app.persistent) {
                this.mStackSupervisor.resumeTopActivitiesLocked();
            } else {
                objArr = new Object[SHOW_FACTORY_ERROR_MSG];
                objArr[MY_PID] = Integer.valueOf(app.userId);
                objArr[SHOW_ERROR_MSG] = Integer.valueOf(app.uid);
                objArr[SHOW_NOT_RESPONDING_MSG] = app.info.processName;
                EventLog.writeEvent(EventLogTags.AM_PROC_BAD, objArr);
                if (!app.isolated) {
                    int i = app.uid;
                    this.mBadProcesses.put(app.info.processName, r16, new BadProcessInfo(now, shortMsg, longMsg, stackTrace));
                    this.mProcessCrashTimes.remove(app.info.processName, app.uid);
                }
                app.bad = SHOW_ACTIVITY_START_TIME;
                app.removed = SHOW_ACTIVITY_START_TIME;
                removeProcessLocked(app, VALIDATE_TOKENS, VALIDATE_TOKENS, "crash");
                this.mStackSupervisor.resumeTopActivitiesLocked();
                return VALIDATE_TOKENS;
            }
        }
        for (int i2 = app.services.size() - 1; i2 >= 0; i2--) {
            ServiceRecord sr = (ServiceRecord) app.services.valueAt(i2);
            sr.crashCount += SHOW_ERROR_MSG;
        }
        ArrayList<ActivityRecord> activities = app.activities;
        if (app == this.mHomeProcess && activities.size() > 0 && (this.mHomeProcess.info.flags & SHOW_ERROR_MSG) == 0) {
            for (int activityNdx = activities.size() - 1; activityNdx >= 0; activityNdx--) {
                ActivityRecord r = (ActivityRecord) activities.get(activityNdx);
                if (r.isHomeActivity()) {
                    Log.i(TAG, "Clearing package preferred activities from " + r.packageName);
                    try {
                        ActivityThread.getPackageManager().clearPackagePreferredActivities(r.packageName);
                    } catch (RemoteException e) {
                    }
                }
            }
        }
        if (!app.isolated) {
            this.mProcessCrashTimes.put(app.info.processName, app.uid, Long.valueOf(now));
        }
        if (app.crashHandler != null) {
            this.mHandler.post(app.crashHandler);
        }
        return SHOW_ACTIVITY_START_TIME;
    }

    void startAppProblemLocked(ProcessRecord app) {
        app.errorReportReceiver = null;
        int[] arr$ = this.mCurrentProfileIds;
        int len$ = arr$.length;
        for (int i$ = MY_PID; i$ < len$; i$ += SHOW_ERROR_MSG) {
            if (app.userId == arr$[i$]) {
                app.errorReportReceiver = ApplicationErrorReport.getErrorReportReceiver(this.mContext, app.info.packageName, app.info.flags);
            }
        }
        skipCurrentReceiverLocked(app);
    }

    void skipCurrentReceiverLocked(ProcessRecord app) {
        BroadcastQueue[] arr$ = this.mBroadcastQueues;
        int len$ = arr$.length;
        for (int i$ = MY_PID; i$ < len$; i$ += SHOW_ERROR_MSG) {
            arr$[i$].skipCurrentReceiverLocked(app);
        }
    }

    public void handleApplicationCrash(IBinder app, CrashInfo crashInfo) {
        ProcessRecord r = findAppProcess(app, "Crash");
        String processName = app == null ? "system_server" : r == null ? "unknown" : r.processName;
        handleApplicationCrashInner("crash", r, processName, crashInfo);
    }

    void handleApplicationCrashInner(String eventType, ProcessRecord r, String processName, CrashInfo crashInfo) {
        Object[] objArr = new Object[8];
        objArr[MY_PID] = Integer.valueOf(Binder.getCallingPid());
        objArr[SHOW_ERROR_MSG] = Integer.valueOf(UserHandle.getUserId(Binder.getCallingUid()));
        objArr[SHOW_NOT_RESPONDING_MSG] = processName;
        objArr[SHOW_FACTORY_ERROR_MSG] = Integer.valueOf(r == null ? -1 : r.info.flags);
        objArr[UPDATE_CONFIGURATION_MSG] = crashInfo.exceptionClassName;
        objArr[GC_BACKGROUND_PROCESSES_MSG] = crashInfo.exceptionMessage;
        objArr[WAIT_FOR_DEBUGGER_MSG] = crashInfo.throwFileName;
        objArr[7] = Integer.valueOf(crashInfo.throwLineNumber);
        EventLog.writeEvent(EventLogTags.AM_CRASH, objArr);
        addErrorToDropBox(eventType, r, processName, null, null, null, null, null, crashInfo);
        crashApplication(r, crashInfo);
    }

    public void handleApplicationStrictModeViolation(IBinder app, int violationMask, ViolationInfo info) {
        ProcessRecord r = findAppProcess(app, "StrictMode");
        if (r != null) {
            if ((violationMask & MAX_PERSISTED_URI_GRANTS) != 0) {
                Integer stackFingerprint = Integer.valueOf(info.hashCode());
                boolean logIt = SHOW_ACTIVITY_START_TIME;
                synchronized (this.mAlreadyLoggedViolatedStacks) {
                    if (this.mAlreadyLoggedViolatedStacks.contains(stackFingerprint)) {
                        logIt = VALIDATE_TOKENS;
                    } else {
                        if (this.mAlreadyLoggedViolatedStacks.size() >= MAX_DUP_SUPPRESSED_STACKS) {
                            this.mAlreadyLoggedViolatedStacks.clear();
                        }
                        this.mAlreadyLoggedViolatedStacks.add(stackFingerprint);
                    }
                }
                if (logIt) {
                    logStrictModeViolationToDropBox(r, info);
                }
            }
            if ((violationMask & DISPATCH_PROCESS_DIED) != 0) {
                AppErrorResult result = new AppErrorResult();
                synchronized (this) {
                    long origId = Binder.clearCallingIdentity();
                    Message msg = Message.obtain();
                    msg.what = SHOW_STRICT_MODE_VIOLATION_MSG;
                    HashMap<String, Object> data = new HashMap();
                    data.put("result", result);
                    data.put("app", r);
                    data.put("violationMask", Integer.valueOf(violationMask));
                    data.put("info", info);
                    msg.obj = data;
                    this.mHandler.sendMessage(msg);
                    Binder.restoreCallingIdentity(origId);
                }
                Slog.w(TAG, "handleApplicationStrictModeViolation; res=" + result.get());
            }
        }
    }

    private void logStrictModeViolationToDropBox(ProcessRecord process, ViolationInfo info) {
        if (info != null) {
            boolean isSystemApp = (process == null || (process.info.flags & 129) != 0) ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
            String processName = process == null ? "unknown" : process.processName;
            String dropboxTag = isSystemApp ? "system_app_strictmode" : "data_app_strictmode";
            DropBoxManager dbox = (DropBoxManager) this.mContext.getSystemService("dropbox");
            if (dbox != null && dbox.isTagEnabled(dropboxTag)) {
                boolean bufferWasEmpty;
                StringBuilder sb = isSystemApp ? this.mStrictModeBuffer : new StringBuilder(STOCK_PM_FLAGS);
                synchronized (sb) {
                    bufferWasEmpty = sb.length() == 0 ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
                    appendDropBoxProcessHeaders(process, processName, sb);
                    sb.append("Build: ").append(Build.FINGERPRINT).append("\n");
                    sb.append("System-App: ").append(isSystemApp).append("\n");
                    sb.append("Uptime-Millis: ").append(info.violationUptimeMillis).append("\n");
                    if (info.violationNumThisLoop != 0) {
                        sb.append("Loop-Violation-Number: ").append(info.violationNumThisLoop).append("\n");
                    }
                    if (info.numAnimationsRunning != 0) {
                        sb.append("Animations-Running: ").append(info.numAnimationsRunning).append("\n");
                    }
                    if (info.broadcastIntentAction != null) {
                        sb.append("Broadcast-Intent-Action: ").append(info.broadcastIntentAction).append("\n");
                    }
                    if (info.durationMillis != -1) {
                        sb.append("Duration-Millis: ").append(info.durationMillis).append("\n");
                    }
                    if (info.numInstances != -1) {
                        sb.append("Instance-Count: ").append(info.numInstances).append("\n");
                    }
                    if (info.tags != null) {
                        String[] arr$ = info.tags;
                        int len$ = arr$.length;
                        for (int i$ = MY_PID; i$ < len$; i$ += SHOW_ERROR_MSG) {
                            sb.append("Span-Tag: ").append(arr$[i$]).append("\n");
                        }
                    }
                    sb.append("\n");
                    if (!(info.crashInfo == null || info.crashInfo.stackTrace == null)) {
                        sb.append(info.crashInfo.stackTrace);
                    }
                    sb.append("\n");
                    boolean needsFlush = sb.length() > 65536 ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
                }
                if (!isSystemApp || needsFlush) {
                    new AnonymousClass16("Error dump: " + dropboxTag, sb, dbox, dropboxTag).start();
                } else if (bufferWasEmpty) {
                    new AnonymousClass17("Error dump: " + dropboxTag, dbox, dropboxTag).start();
                }
            }
        }
    }

    public boolean handleApplicationWtf(IBinder app, String tag, boolean system, CrashInfo crashInfo) {
        int callingUid = Binder.getCallingUid();
        int callingPid = Binder.getCallingPid();
        if (system) {
            this.mHandler.post(new AnonymousClass18(callingUid, callingPid, app, tag, crashInfo));
            return VALIDATE_TOKENS;
        }
        ProcessRecord r = handleApplicationWtfInner(callingUid, callingPid, app, tag, crashInfo);
        if (r == null || r.pid == Process.myPid() || Global.getInt(this.mContext.getContentResolver(), "wtf_is_fatal", MY_PID) == 0) {
            return VALIDATE_TOKENS;
        }
        crashApplication(r, crashInfo);
        return SHOW_ACTIVITY_START_TIME;
    }

    ProcessRecord handleApplicationWtfInner(int callingUid, int callingPid, IBinder app, String tag, CrashInfo crashInfo) {
        ProcessRecord r = findAppProcess(app, "WTF");
        String processName = app == null ? "system_server" : r == null ? "unknown" : r.processName;
        Object[] objArr = new Object[WAIT_FOR_DEBUGGER_MSG];
        objArr[MY_PID] = Integer.valueOf(UserHandle.getUserId(callingUid));
        objArr[SHOW_ERROR_MSG] = Integer.valueOf(callingPid);
        objArr[SHOW_NOT_RESPONDING_MSG] = processName;
        objArr[SHOW_FACTORY_ERROR_MSG] = Integer.valueOf(r == null ? -1 : r.info.flags);
        objArr[UPDATE_CONFIGURATION_MSG] = tag;
        objArr[GC_BACKGROUND_PROCESSES_MSG] = crashInfo.exceptionMessage;
        EventLog.writeEvent(EventLogTags.AM_WTF, objArr);
        addErrorToDropBox("wtf", r, processName, null, null, tag, null, null, crashInfo);
        return r;
    }

    private ProcessRecord findAppProcess(IBinder app, String reason) {
        if (app == null) {
            return null;
        }
        synchronized (this) {
            int NP = this.mProcessNames.getMap().size();
            for (int ip = MY_PID; ip < NP; ip += SHOW_ERROR_MSG) {
                SparseArray<ProcessRecord> apps = (SparseArray) this.mProcessNames.getMap().valueAt(ip);
                int NA = apps.size();
                int ia = MY_PID;
                while (ia < NA) {
                    ProcessRecord p = (ProcessRecord) apps.valueAt(ia);
                    if (p.thread == null || p.thread.asBinder() != app) {
                        ia += SHOW_ERROR_MSG;
                    } else {
                        return p;
                    }
                }
            }
            Slog.w(TAG, "Can't find mystery application for " + reason + " from pid=" + Binder.getCallingPid() + " uid=" + Binder.getCallingUid() + ": " + app);
            return null;
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void appendDropBoxProcessHeaders(com.android.server.am.ProcessRecord r10, java.lang.String r11, java.lang.StringBuilder r12) {
        /*
        r9 = this;
        if (r10 != 0) goto L_0x0012;
    L_0x0002:
        r6 = "Process: ";
        r6 = r12.append(r6);
        r6 = r6.append(r11);
        r7 = "\n";
        r6.append(r7);
    L_0x0011:
        return;
    L_0x0012:
        monitor-enter(r9);
        r6 = "Process: ";
        r6 = r12.append(r6);	 Catch:{ all -> 0x00a6 }
        r6 = r6.append(r11);	 Catch:{ all -> 0x00a6 }
        r7 = "\n";
        r6.append(r7);	 Catch:{ all -> 0x00a6 }
        r6 = r10.info;	 Catch:{ all -> 0x00a6 }
        r1 = r6.flags;	 Catch:{ all -> 0x00a6 }
        r5 = android.app.AppGlobals.getPackageManager();	 Catch:{ all -> 0x00a6 }
        r6 = "Flags: 0x";
        r6 = r12.append(r6);	 Catch:{ all -> 0x00a6 }
        r7 = 16;
        r7 = java.lang.Integer.toString(r1, r7);	 Catch:{ all -> 0x00a6 }
        r6 = r6.append(r7);	 Catch:{ all -> 0x00a6 }
        r7 = "\n";
        r6.append(r7);	 Catch:{ all -> 0x00a6 }
        r2 = 0;
    L_0x0040:
        r6 = r10.pkgList;	 Catch:{ all -> 0x00a6 }
        r6 = r6.size();	 Catch:{ all -> 0x00a6 }
        if (r2 >= r6) goto L_0x00a9;
    L_0x0048:
        r6 = r10.pkgList;	 Catch:{ all -> 0x00a6 }
        r4 = r6.keyAt(r2);	 Catch:{ all -> 0x00a6 }
        r4 = (java.lang.String) r4;	 Catch:{ all -> 0x00a6 }
        r6 = "Package: ";
        r6 = r12.append(r6);	 Catch:{ all -> 0x00a6 }
        r6.append(r4);	 Catch:{ all -> 0x00a6 }
        r6 = 0;
        r7 = android.os.UserHandle.getCallingUserId();	 Catch:{ RemoteException -> 0x008c }
        r3 = r5.getPackageInfo(r4, r6, r7);	 Catch:{ RemoteException -> 0x008c }
        if (r3 == 0) goto L_0x0084;
    L_0x0064:
        r6 = " v";
        r6 = r12.append(r6);	 Catch:{ RemoteException -> 0x008c }
        r7 = r3.versionCode;	 Catch:{ RemoteException -> 0x008c }
        r6.append(r7);	 Catch:{ RemoteException -> 0x008c }
        r6 = r3.versionName;	 Catch:{ RemoteException -> 0x008c }
        if (r6 == 0) goto L_0x0084;
    L_0x0073:
        r6 = " (";
        r6 = r12.append(r6);	 Catch:{ RemoteException -> 0x008c }
        r7 = r3.versionName;	 Catch:{ RemoteException -> 0x008c }
        r6 = r6.append(r7);	 Catch:{ RemoteException -> 0x008c }
        r7 = ")";
        r6.append(r7);	 Catch:{ RemoteException -> 0x008c }
    L_0x0084:
        r6 = "\n";
        r12.append(r6);	 Catch:{ all -> 0x00a6 }
        r2 = r2 + 1;
        goto L_0x0040;
    L_0x008c:
        r0 = move-exception;
        r6 = "ActivityManager";
        r7 = new java.lang.StringBuilder;	 Catch:{ all -> 0x00a6 }
        r7.<init>();	 Catch:{ all -> 0x00a6 }
        r8 = "Error getting package info: ";
        r7 = r7.append(r8);	 Catch:{ all -> 0x00a6 }
        r7 = r7.append(r4);	 Catch:{ all -> 0x00a6 }
        r7 = r7.toString();	 Catch:{ all -> 0x00a6 }
        android.util.Slog.e(r6, r7, r0);	 Catch:{ all -> 0x00a6 }
        goto L_0x0084;
    L_0x00a6:
        r6 = move-exception;
        monitor-exit(r9);	 Catch:{ all -> 0x00a6 }
        throw r6;
    L_0x00a9:
        monitor-exit(r9);	 Catch:{ all -> 0x00a6 }
        goto L_0x0011;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.ActivityManagerService.appendDropBoxProcessHeaders(com.android.server.am.ProcessRecord, java.lang.String, java.lang.StringBuilder):void");
    }

    private static String processClass(ProcessRecord process) {
        if (process == null || process.pid == MY_PID) {
            return "system_server";
        }
        if ((process.info.flags & SHOW_ERROR_MSG) != 0) {
            return "system_app";
        }
        return "data_app";
    }

    public void addErrorToDropBox(String eventType, ProcessRecord process, String processName, ActivityRecord activity, ActivityRecord parent, String subject, String report, File logFile, CrashInfo crashInfo) {
        String dropboxTag = processClass(process) + "_" + eventType;
        DropBoxManager dbox = (DropBoxManager) this.mContext.getSystemService("dropbox");
        if (dbox != null && dbox.isTagEnabled(dropboxTag)) {
            StringBuilder sb = new StringBuilder(STOCK_PM_FLAGS);
            appendDropBoxProcessHeaders(process, processName, sb);
            if (activity != null) {
                sb.append("Activity: ").append(activity.shortComponentName).append("\n");
            }
            if (!(parent == null || parent.app == null || parent.app.pid == process.pid)) {
                sb.append("Parent-Process: ").append(parent.app.processName).append("\n");
            }
            if (!(parent == null || parent == activity)) {
                sb.append("Parent-Activity: ").append(parent.shortComponentName).append("\n");
            }
            if (subject != null) {
                sb.append("Subject: ").append(subject).append("\n");
            }
            sb.append("Build: ").append(Build.FINGERPRINT).append("\n");
            if (Debug.isDebuggerConnected()) {
                sb.append("Debugger: Connected\n");
            }
            sb.append("\n");
            Thread worker = new AnonymousClass19("Error dump: " + dropboxTag, report, sb, logFile, crashInfo, dropboxTag, dbox);
            if (process == null) {
                worker.run();
            } else {
                worker.start();
            }
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void crashApplication(com.android.server.am.ProcessRecord r27, android.app.ApplicationErrorReport.CrashInfo r28) {
        /*
        r26 = this;
        r10 = java.lang.System.currentTimeMillis();
        r0 = r28;
        r8 = r0.exceptionClassName;
        r0 = r28;
        r9 = r0.exceptionMessage;
        r0 = r28;
        r0 = r0.stackTrace;
        r21 = r0;
        if (r8 == 0) goto L_0x00ab;
    L_0x0014:
        if (r9 == 0) goto L_0x00ab;
    L_0x0016:
        r5 = new java.lang.StringBuilder;
        r5.<init>();
        r5 = r5.append(r8);
        r12 = ": ";
        r5 = r5.append(r12);
        r5 = r5.append(r9);
        r9 = r5.toString();
    L_0x002d:
        r20 = new com.android.server.am.AppErrorResult;
        r20.<init>();
        monitor-enter(r26);
        r0 = r26;
        r5 = r0.mController;	 Catch:{ all -> 0x0196 }
        if (r5 == 0) goto L_0x00f7;
    L_0x0039:
        if (r27 == 0) goto L_0x00b0;
    L_0x003b:
        r0 = r27;
        r6 = r0.processName;	 Catch:{ RemoteException -> 0x00e9 }
    L_0x003f:
        if (r27 == 0) goto L_0x00b2;
    L_0x0041:
        r0 = r27;
        r7 = r0.pid;	 Catch:{ RemoteException -> 0x00e9 }
    L_0x0045:
        if (r27 == 0) goto L_0x00b7;
    L_0x0047:
        r0 = r27;
        r5 = r0.info;	 Catch:{ RemoteException -> 0x00e9 }
        r0 = r5.uid;	 Catch:{ RemoteException -> 0x00e9 }
        r22 = r0;
    L_0x004f:
        r0 = r26;
        r5 = r0.mController;	 Catch:{ RemoteException -> 0x00e9 }
        r0 = r28;
        r12 = r0.stackTrace;	 Catch:{ RemoteException -> 0x00e9 }
        r5 = r5.appCrashed(r6, r7, r8, r9, r10, r12);	 Catch:{ RemoteException -> 0x00e9 }
        if (r5 != 0) goto L_0x00f7;
    L_0x005d:
        r5 = "1";
        r12 = "ro.debuggable";
        r23 = "0";
        r0 = r23;
        r12 = android.os.SystemProperties.get(r12, r0);	 Catch:{ RemoteException -> 0x00e9 }
        r5 = r5.equals(r12);	 Catch:{ RemoteException -> 0x00e9 }
        if (r5 == 0) goto L_0x00bc;
    L_0x006f:
        r5 = "Native crash";
        r0 = r28;
        r12 = r0.exceptionClassName;	 Catch:{ RemoteException -> 0x00e9 }
        r5 = r5.equals(r12);	 Catch:{ RemoteException -> 0x00e9 }
        if (r5 == 0) goto L_0x00bc;
    L_0x007b:
        r5 = "ActivityManager";
        r12 = new java.lang.StringBuilder;	 Catch:{ RemoteException -> 0x00e9 }
        r12.<init>();	 Catch:{ RemoteException -> 0x00e9 }
        r23 = "Skip killing native crashed app ";
        r0 = r23;
        r12 = r12.append(r0);	 Catch:{ RemoteException -> 0x00e9 }
        r12 = r12.append(r6);	 Catch:{ RemoteException -> 0x00e9 }
        r23 = "(";
        r0 = r23;
        r12 = r12.append(r0);	 Catch:{ RemoteException -> 0x00e9 }
        r12 = r12.append(r7);	 Catch:{ RemoteException -> 0x00e9 }
        r23 = ") during testing";
        r0 = r23;
        r12 = r12.append(r0);	 Catch:{ RemoteException -> 0x00e9 }
        r12 = r12.toString();	 Catch:{ RemoteException -> 0x00e9 }
        android.util.Slog.w(r5, r12);	 Catch:{ RemoteException -> 0x00e9 }
    L_0x00a9:
        monitor-exit(r26);	 Catch:{ all -> 0x0196 }
    L_0x00aa:
        return;
    L_0x00ab:
        if (r8 == 0) goto L_0x002d;
    L_0x00ad:
        r9 = r8;
        goto L_0x002d;
    L_0x00b0:
        r6 = 0;
        goto L_0x003f;
    L_0x00b2:
        r7 = android.os.Binder.getCallingPid();	 Catch:{ RemoteException -> 0x00e9 }
        goto L_0x0045;
    L_0x00b7:
        r22 = android.os.Binder.getCallingUid();	 Catch:{ RemoteException -> 0x00e9 }
        goto L_0x004f;
    L_0x00bc:
        r5 = "ActivityManager";
        r12 = new java.lang.StringBuilder;	 Catch:{ RemoteException -> 0x00e9 }
        r12.<init>();	 Catch:{ RemoteException -> 0x00e9 }
        r23 = "Force-killing crashed app ";
        r0 = r23;
        r12 = r12.append(r0);	 Catch:{ RemoteException -> 0x00e9 }
        r12 = r12.append(r6);	 Catch:{ RemoteException -> 0x00e9 }
        r23 = " at watcher's request";
        r0 = r23;
        r12 = r12.append(r0);	 Catch:{ RemoteException -> 0x00e9 }
        r12 = r12.toString();	 Catch:{ RemoteException -> 0x00e9 }
        android.util.Slog.w(r5, r12);	 Catch:{ RemoteException -> 0x00e9 }
        if (r27 == 0) goto L_0x0199;
    L_0x00e0:
        r5 = "crash";
        r12 = 1;
        r0 = r27;
        r0.kill(r5, r12);	 Catch:{ RemoteException -> 0x00e9 }
        goto L_0x00a9;
    L_0x00e9:
        r14 = move-exception;
        r5 = 0;
        r0 = r26;
        r0.mController = r5;	 Catch:{ all -> 0x0196 }
        r5 = com.android.server.Watchdog.getInstance();	 Catch:{ all -> 0x0196 }
        r12 = 0;
        r5.setActivityController(r12);	 Catch:{ all -> 0x0196 }
    L_0x00f7:
        r18 = android.os.Binder.clearCallingIdentity();	 Catch:{ all -> 0x0196 }
        if (r27 == 0) goto L_0x01a3;
    L_0x00fd:
        r0 = r27;
        r5 = r0.instrumentationClass;	 Catch:{ all -> 0x0196 }
        if (r5 == 0) goto L_0x01a3;
    L_0x0103:
        r5 = "ActivityManager";
        r12 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0196 }
        r12.<init>();	 Catch:{ all -> 0x0196 }
        r23 = "Error in app ";
        r0 = r23;
        r12 = r12.append(r0);	 Catch:{ all -> 0x0196 }
        r0 = r27;
        r0 = r0.processName;	 Catch:{ all -> 0x0196 }
        r23 = r0;
        r0 = r23;
        r12 = r12.append(r0);	 Catch:{ all -> 0x0196 }
        r23 = " running instrumentation ";
        r0 = r23;
        r12 = r12.append(r0);	 Catch:{ all -> 0x0196 }
        r0 = r27;
        r0 = r0.instrumentationClass;	 Catch:{ all -> 0x0196 }
        r23 = r0;
        r0 = r23;
        r12 = r12.append(r0);	 Catch:{ all -> 0x0196 }
        r23 = ":";
        r0 = r23;
        r12 = r12.append(r0);	 Catch:{ all -> 0x0196 }
        r12 = r12.toString();	 Catch:{ all -> 0x0196 }
        android.util.Slog.w(r5, r12);	 Catch:{ all -> 0x0196 }
        if (r8 == 0) goto L_0x015d;
    L_0x0143:
        r5 = "ActivityManager";
        r12 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0196 }
        r12.<init>();	 Catch:{ all -> 0x0196 }
        r23 = "  ";
        r0 = r23;
        r12 = r12.append(r0);	 Catch:{ all -> 0x0196 }
        r12 = r12.append(r8);	 Catch:{ all -> 0x0196 }
        r12 = r12.toString();	 Catch:{ all -> 0x0196 }
        android.util.Slog.w(r5, r12);	 Catch:{ all -> 0x0196 }
    L_0x015d:
        if (r9 == 0) goto L_0x0179;
    L_0x015f:
        r5 = "ActivityManager";
        r12 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0196 }
        r12.<init>();	 Catch:{ all -> 0x0196 }
        r23 = "  ";
        r0 = r23;
        r12 = r12.append(r0);	 Catch:{ all -> 0x0196 }
        r12 = r12.append(r9);	 Catch:{ all -> 0x0196 }
        r12 = r12.toString();	 Catch:{ all -> 0x0196 }
        android.util.Slog.w(r5, r12);	 Catch:{ all -> 0x0196 }
    L_0x0179:
        r15 = new android.os.Bundle;	 Catch:{ all -> 0x0196 }
        r15.<init>();	 Catch:{ all -> 0x0196 }
        r5 = "shortMsg";
        r15.putString(r5, r8);	 Catch:{ all -> 0x0196 }
        r5 = "longMsg";
        r15.putString(r5, r9);	 Catch:{ all -> 0x0196 }
        r5 = 0;
        r0 = r26;
        r1 = r27;
        r0.finishInstrumentationLocked(r1, r5, r15);	 Catch:{ all -> 0x0196 }
        android.os.Binder.restoreCallingIdentity(r18);	 Catch:{ all -> 0x0196 }
        monitor-exit(r26);	 Catch:{ all -> 0x0196 }
        goto L_0x00aa;
    L_0x0196:
        r5 = move-exception;
        monitor-exit(r26);	 Catch:{ all -> 0x0196 }
        throw r5;
    L_0x0199:
        android.os.Process.killProcess(r7);	 Catch:{ RemoteException -> 0x00e9 }
        r0 = r22;
        android.os.Process.killProcessGroup(r0, r7);	 Catch:{ RemoteException -> 0x00e9 }
        goto L_0x00a9;
    L_0x01a3:
        if (r27 == 0) goto L_0x01b8;
    L_0x01a5:
        r0 = r26;
        r5 = r0.mBatteryStatsService;	 Catch:{ all -> 0x0196 }
        r0 = r27;
        r12 = r0.processName;	 Catch:{ all -> 0x0196 }
        r0 = r27;
        r0 = r0.uid;	 Catch:{ all -> 0x0196 }
        r23 = r0;
        r0 = r23;
        r5.noteProcessCrash(r12, r0);	 Catch:{ all -> 0x0196 }
    L_0x01b8:
        if (r27 == 0) goto L_0x01c6;
    L_0x01ba:
        r0 = r26;
        r1 = r27;
        r2 = r21;
        r5 = r0.makeAppCrashingLocked(r1, r8, r9, r2);	 Catch:{ all -> 0x0196 }
        if (r5 != 0) goto L_0x01cc;
    L_0x01c6:
        android.os.Binder.restoreCallingIdentity(r18);	 Catch:{ all -> 0x0196 }
        monitor-exit(r26);	 Catch:{ all -> 0x0196 }
        goto L_0x00aa;
    L_0x01cc:
        r16 = android.os.Message.obtain();	 Catch:{ all -> 0x0196 }
        r5 = 1;
        r0 = r16;
        r0.what = r5;	 Catch:{ all -> 0x0196 }
        r13 = new java.util.HashMap;	 Catch:{ all -> 0x0196 }
        r13.<init>();	 Catch:{ all -> 0x0196 }
        r5 = "result";
        r0 = r20;
        r13.put(r5, r0);	 Catch:{ all -> 0x0196 }
        r5 = "app";
        r0 = r27;
        r13.put(r5, r0);	 Catch:{ all -> 0x0196 }
        r0 = r16;
        r0.obj = r13;	 Catch:{ all -> 0x0196 }
        r0 = r26;
        r5 = r0.mHandler;	 Catch:{ all -> 0x0196 }
        r0 = r16;
        r5.sendMessage(r0);	 Catch:{ all -> 0x0196 }
        android.os.Binder.restoreCallingIdentity(r18);	 Catch:{ all -> 0x0196 }
        monitor-exit(r26);	 Catch:{ all -> 0x0196 }
        r17 = r20.get();
        r4 = 0;
        monitor-enter(r26);
        if (r27 == 0) goto L_0x0226;
    L_0x0201:
        r0 = r27;
        r5 = r0.isolated;	 Catch:{ all -> 0x0258 }
        if (r5 != 0) goto L_0x0226;
    L_0x0207:
        r0 = r26;
        r5 = r0.mProcessCrashTimes;	 Catch:{ all -> 0x0258 }
        r0 = r27;
        r12 = r0.info;	 Catch:{ all -> 0x0258 }
        r12 = r12.processName;	 Catch:{ all -> 0x0258 }
        r0 = r27;
        r0 = r0.uid;	 Catch:{ all -> 0x0258 }
        r23 = r0;
        r24 = android.os.SystemClock.uptimeMillis();	 Catch:{ all -> 0x0258 }
        r24 = java.lang.Long.valueOf(r24);	 Catch:{ all -> 0x0258 }
        r0 = r23;
        r1 = r24;
        r5.put(r12, r0, r1);	 Catch:{ all -> 0x0258 }
    L_0x0226:
        r5 = 1;
        r0 = r17;
        if (r0 != r5) goto L_0x0235;
    L_0x022b:
        r0 = r26;
        r1 = r27;
        r2 = r28;
        r4 = r0.createAppErrorIntentLocked(r1, r10, r2);	 Catch:{ all -> 0x0258 }
    L_0x0235:
        monitor-exit(r26);	 Catch:{ all -> 0x0258 }
        if (r4 == 0) goto L_0x00aa;
    L_0x0238:
        r0 = r26;
        r5 = r0.mContext;	 Catch:{ ActivityNotFoundException -> 0x024e }
        r12 = new android.os.UserHandle;	 Catch:{ ActivityNotFoundException -> 0x024e }
        r0 = r27;
        r0 = r0.userId;	 Catch:{ ActivityNotFoundException -> 0x024e }
        r23 = r0;
        r0 = r23;
        r12.<init>(r0);	 Catch:{ ActivityNotFoundException -> 0x024e }
        r5.startActivityAsUser(r4, r12);	 Catch:{ ActivityNotFoundException -> 0x024e }
        goto L_0x00aa;
    L_0x024e:
        r14 = move-exception;
        r5 = "ActivityManager";
        r12 = "bug report receiver dissappeared";
        android.util.Slog.w(r5, r12, r14);
        goto L_0x00aa;
    L_0x0258:
        r5 = move-exception;
        monitor-exit(r26);	 Catch:{ all -> 0x0258 }
        throw r5;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.ActivityManagerService.crashApplication(com.android.server.am.ProcessRecord, android.app.ApplicationErrorReport$CrashInfo):void");
    }

    Intent createAppErrorIntentLocked(ProcessRecord r, long timeMillis, CrashInfo crashInfo) {
        ApplicationErrorReport report = createAppErrorReportLocked(r, timeMillis, crashInfo);
        if (report == null) {
            return null;
        }
        Intent result = new Intent("android.intent.action.APP_ERROR");
        result.setComponent(r.errorReportReceiver);
        result.putExtra("android.intent.extra.BUG_REPORT", report);
        result.addFlags(268435456);
        return result;
    }

    private ApplicationErrorReport createAppErrorReportLocked(ProcessRecord r, long timeMillis, CrashInfo crashInfo) {
        ApplicationErrorReport applicationErrorReport = null;
        if (r.errorReportReceiver != null && (r.crashing || r.notResponding || r.forceCrashReport)) {
            applicationErrorReport = new ApplicationErrorReport();
            applicationErrorReport.packageName = r.info.packageName;
            applicationErrorReport.installerPackageName = r.errorReportReceiver.getPackageName();
            applicationErrorReport.processName = r.processName;
            applicationErrorReport.time = timeMillis;
            applicationErrorReport.systemApp = (r.info.flags & SHOW_ERROR_MSG) != 0 ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
            if (r.crashing || r.forceCrashReport) {
                applicationErrorReport.type = SHOW_ERROR_MSG;
                applicationErrorReport.crashInfo = crashInfo;
            } else if (r.notResponding) {
                applicationErrorReport.type = SHOW_NOT_RESPONDING_MSG;
                applicationErrorReport.anrInfo = new AnrInfo();
                applicationErrorReport.anrInfo.activity = r.notRespondingReport.tag;
                applicationErrorReport.anrInfo.cause = r.notRespondingReport.shortMsg;
                applicationErrorReport.anrInfo.info = r.notRespondingReport.longMsg;
            }
        }
        return applicationErrorReport;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public java.util.List<android.app.ActivityManager.ProcessErrorStateInfo> getProcessesInErrorState() {
        /*
        r10 = this;
        r0 = 1;
        r7 = "getProcessesInErrorState";
        r10.enforceNotIsolatedCaller(r7);
        r2 = 0;
        r7 = "android.permission.INTERACT_ACROSS_USERS_FULL";
        r8 = android.os.Binder.getCallingUid();
        r7 = android.app.ActivityManager.checkUidPermission(r7, r8);
        if (r7 != 0) goto L_0x003a;
    L_0x0013:
        r7 = android.os.Binder.getCallingUid();
        r6 = android.os.UserHandle.getUserId(r7);
        monitor-enter(r10);
        r7 = r10.mLruProcesses;	 Catch:{ all -> 0x005d }
        r7 = r7.size();	 Catch:{ all -> 0x005d }
        r4 = r7 + -1;
        r3 = r2;
    L_0x0025:
        if (r4 < 0) goto L_0x009b;
    L_0x0027:
        r7 = r10.mLruProcesses;	 Catch:{ all -> 0x009d }
        r1 = r7.get(r4);	 Catch:{ all -> 0x009d }
        r1 = (com.android.server.am.ProcessRecord) r1;	 Catch:{ all -> 0x009d }
        if (r0 != 0) goto L_0x003c;
    L_0x0031:
        r7 = r1.userId;	 Catch:{ all -> 0x009d }
        if (r7 == r6) goto L_0x003c;
    L_0x0035:
        r2 = r3;
    L_0x0036:
        r4 = r4 + -1;
        r3 = r2;
        goto L_0x0025;
    L_0x003a:
        r0 = 0;
        goto L_0x0013;
    L_0x003c:
        r7 = r1.thread;	 Catch:{ all -> 0x009d }
        if (r7 == 0) goto L_0x0099;
    L_0x0040:
        r7 = r1.crashing;	 Catch:{ all -> 0x009d }
        if (r7 != 0) goto L_0x0048;
    L_0x0044:
        r7 = r1.notResponding;	 Catch:{ all -> 0x009d }
        if (r7 == 0) goto L_0x0099;
    L_0x0048:
        r5 = 0;
        r7 = r1.crashing;	 Catch:{ all -> 0x009d }
        if (r7 == 0) goto L_0x0060;
    L_0x004d:
        r5 = r1.crashingReport;	 Catch:{ all -> 0x009d }
    L_0x004f:
        if (r5 == 0) goto L_0x0067;
    L_0x0051:
        if (r3 != 0) goto L_0x00a0;
    L_0x0053:
        r2 = new java.util.ArrayList;	 Catch:{ all -> 0x009d }
        r7 = 1;
        r2.<init>(r7);	 Catch:{ all -> 0x009d }
    L_0x0059:
        r2.add(r5);	 Catch:{ all -> 0x005d }
        goto L_0x0036;
    L_0x005d:
        r7 = move-exception;
    L_0x005e:
        monitor-exit(r10);	 Catch:{ all -> 0x005d }
        throw r7;
    L_0x0060:
        r7 = r1.notResponding;	 Catch:{ all -> 0x009d }
        if (r7 == 0) goto L_0x004f;
    L_0x0064:
        r5 = r1.notRespondingReport;	 Catch:{ all -> 0x009d }
        goto L_0x004f;
    L_0x0067:
        r7 = "ActivityManager";
        r8 = new java.lang.StringBuilder;	 Catch:{ all -> 0x009d }
        r8.<init>();	 Catch:{ all -> 0x009d }
        r9 = "Missing app error report, app = ";
        r8 = r8.append(r9);	 Catch:{ all -> 0x009d }
        r9 = r1.processName;	 Catch:{ all -> 0x009d }
        r8 = r8.append(r9);	 Catch:{ all -> 0x009d }
        r9 = " crashing = ";
        r8 = r8.append(r9);	 Catch:{ all -> 0x009d }
        r9 = r1.crashing;	 Catch:{ all -> 0x009d }
        r8 = r8.append(r9);	 Catch:{ all -> 0x009d }
        r9 = " notResponding = ";
        r8 = r8.append(r9);	 Catch:{ all -> 0x009d }
        r9 = r1.notResponding;	 Catch:{ all -> 0x009d }
        r8 = r8.append(r9);	 Catch:{ all -> 0x009d }
        r8 = r8.toString();	 Catch:{ all -> 0x009d }
        android.util.Slog.w(r7, r8);	 Catch:{ all -> 0x009d }
    L_0x0099:
        r2 = r3;
        goto L_0x0036;
    L_0x009b:
        monitor-exit(r10);	 Catch:{ all -> 0x009d }
        return r3;
    L_0x009d:
        r7 = move-exception;
        r2 = r3;
        goto L_0x005e;
    L_0x00a0:
        r2 = r3;
        goto L_0x0059;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.ActivityManagerService.getProcessesInErrorState():java.util.List<android.app.ActivityManager$ProcessErrorStateInfo>");
    }

    static int procStateToImportance(int procState, int memAdj, RunningAppProcessInfo currApp) {
        int imp = RunningAppProcessInfo.procStateToImportance(procState);
        if (imp == 400) {
            currApp.lru = memAdj;
        } else {
            currApp.lru = MY_PID;
        }
        return imp;
    }

    private void fillInProcMemInfo(ProcessRecord app, RunningAppProcessInfo outInfo) {
        outInfo.pid = app.pid;
        outInfo.uid = app.info.uid;
        if (this.mHeavyWeightProcess == app) {
            outInfo.flags |= SHOW_ERROR_MSG;
        }
        if (app.persistent) {
            outInfo.flags |= SHOW_NOT_RESPONDING_MSG;
        }
        if (app.activities.size() > 0) {
            outInfo.flags |= UPDATE_CONFIGURATION_MSG;
        }
        outInfo.lastTrimLevel = app.trimMemoryLevel;
        outInfo.importance = procStateToImportance(app.curProcState, app.curAdj, outInfo);
        outInfo.importanceReasonCode = app.adjTypeCode;
        outInfo.processState = app.curProcState;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public java.util.List<android.app.ActivityManager.RunningAppProcessInfo> getRunningAppProcesses() {
        /*
        r13 = this;
        r10 = "getRunningAppProcesses";
        r13.enforceNotIsolatedCaller(r10);
        r3 = android.os.Binder.getCallingUid();
        r7 = 0;
        r10 = "android.permission.INTERACT_ACROSS_USERS_FULL";
        r10 = android.app.ActivityManager.checkUidPermission(r10, r3);
        if (r10 != 0) goto L_0x0046;
    L_0x0012:
        r1 = 1;
    L_0x0013:
        r9 = android.os.UserHandle.getUserId(r3);
        r10 = "getRunningAppProcesses";
        r11 = android.os.Binder.getCallingPid();
        r0 = r13.isGetTasksAllowed(r10, r11, r3);
        monitor-enter(r13);
        r10 = r13.mLruProcesses;	 Catch:{ all -> 0x0091 }
        r10 = r10.size();	 Catch:{ all -> 0x0091 }
        r5 = r10 + -1;
        r8 = r7;
    L_0x002b:
        if (r5 < 0) goto L_0x00ac;
    L_0x002d:
        r10 = r13.mLruProcesses;	 Catch:{ all -> 0x00a9 }
        r2 = r10.get(r5);	 Catch:{ all -> 0x00a9 }
        r2 = (com.android.server.am.ProcessRecord) r2;	 Catch:{ all -> 0x00a9 }
        if (r1 != 0) goto L_0x003b;
    L_0x0037:
        r10 = r2.userId;	 Catch:{ all -> 0x00a9 }
        if (r10 != r9) goto L_0x00b0;
    L_0x003b:
        if (r0 != 0) goto L_0x0048;
    L_0x003d:
        r10 = r2.uid;	 Catch:{ all -> 0x00a9 }
        if (r10 == r3) goto L_0x0048;
    L_0x0041:
        r7 = r8;
    L_0x0042:
        r5 = r5 + -1;
        r8 = r7;
        goto L_0x002b;
    L_0x0046:
        r1 = 0;
        goto L_0x0013;
    L_0x0048:
        r10 = r2.thread;	 Catch:{ all -> 0x00a9 }
        if (r10 == 0) goto L_0x00b0;
    L_0x004c:
        r10 = r2.crashing;	 Catch:{ all -> 0x00a9 }
        if (r10 != 0) goto L_0x00b0;
    L_0x0050:
        r10 = r2.notResponding;	 Catch:{ all -> 0x00a9 }
        if (r10 != 0) goto L_0x00b0;
    L_0x0054:
        r4 = new android.app.ActivityManager$RunningAppProcessInfo;	 Catch:{ all -> 0x00a9 }
        r10 = r2.processName;	 Catch:{ all -> 0x00a9 }
        r11 = r2.pid;	 Catch:{ all -> 0x00a9 }
        r12 = r2.getPackageList();	 Catch:{ all -> 0x00a9 }
        r4.<init>(r10, r11, r12);	 Catch:{ all -> 0x00a9 }
        r13.fillInProcMemInfo(r2, r4);	 Catch:{ all -> 0x00a9 }
        r10 = r2.adjSource;	 Catch:{ all -> 0x00a9 }
        r10 = r10 instanceof com.android.server.am.ProcessRecord;	 Catch:{ all -> 0x00a9 }
        if (r10 == 0) goto L_0x0094;
    L_0x006a:
        r10 = r2.adjSource;	 Catch:{ all -> 0x00a9 }
        r10 = (com.android.server.am.ProcessRecord) r10;	 Catch:{ all -> 0x00a9 }
        r10 = r10.pid;	 Catch:{ all -> 0x00a9 }
        r4.importanceReasonPid = r10;	 Catch:{ all -> 0x00a9 }
        r10 = r2.adjSourceProcState;	 Catch:{ all -> 0x00a9 }
        r10 = android.app.ActivityManager.RunningAppProcessInfo.procStateToImportance(r10);	 Catch:{ all -> 0x00a9 }
        r4.importanceReasonImportance = r10;	 Catch:{ all -> 0x00a9 }
    L_0x007a:
        r10 = r2.adjTarget;	 Catch:{ all -> 0x00a9 }
        r10 = r10 instanceof android.content.ComponentName;	 Catch:{ all -> 0x00a9 }
        if (r10 == 0) goto L_0x0086;
    L_0x0080:
        r10 = r2.adjTarget;	 Catch:{ all -> 0x00a9 }
        r10 = (android.content.ComponentName) r10;	 Catch:{ all -> 0x00a9 }
        r4.importanceReasonComponent = r10;	 Catch:{ all -> 0x00a9 }
    L_0x0086:
        if (r8 != 0) goto L_0x00ae;
    L_0x0088:
        r7 = new java.util.ArrayList;	 Catch:{ all -> 0x00a9 }
        r7.<init>();	 Catch:{ all -> 0x00a9 }
    L_0x008d:
        r7.add(r4);	 Catch:{ all -> 0x0091 }
        goto L_0x0042;
    L_0x0091:
        r10 = move-exception;
    L_0x0092:
        monitor-exit(r13);	 Catch:{ all -> 0x0091 }
        throw r10;
    L_0x0094:
        r10 = r2.adjSource;	 Catch:{ all -> 0x00a9 }
        r10 = r10 instanceof com.android.server.am.ActivityRecord;	 Catch:{ all -> 0x00a9 }
        if (r10 == 0) goto L_0x007a;
    L_0x009a:
        r6 = r2.adjSource;	 Catch:{ all -> 0x00a9 }
        r6 = (com.android.server.am.ActivityRecord) r6;	 Catch:{ all -> 0x00a9 }
        r10 = r6.app;	 Catch:{ all -> 0x00a9 }
        if (r10 == 0) goto L_0x007a;
    L_0x00a2:
        r10 = r6.app;	 Catch:{ all -> 0x00a9 }
        r10 = r10.pid;	 Catch:{ all -> 0x00a9 }
        r4.importanceReasonPid = r10;	 Catch:{ all -> 0x00a9 }
        goto L_0x007a;
    L_0x00a9:
        r10 = move-exception;
        r7 = r8;
        goto L_0x0092;
    L_0x00ac:
        monitor-exit(r13);	 Catch:{ all -> 0x00a9 }
        return r8;
    L_0x00ae:
        r7 = r8;
        goto L_0x008d;
    L_0x00b0:
        r7 = r8;
        goto L_0x0042;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.ActivityManagerService.getRunningAppProcesses():java.util.List<android.app.ActivityManager$RunningAppProcessInfo>");
    }

    public List<ApplicationInfo> getRunningExternalApplications() {
        enforceNotIsolatedCaller("getRunningExternalApplications");
        List<RunningAppProcessInfo> runningApps = getRunningAppProcesses();
        List<ApplicationInfo> retList = new ArrayList();
        if (runningApps != null && runningApps.size() > 0) {
            Set<String> extList = new HashSet();
            for (RunningAppProcessInfo app : runningApps) {
                if (app.pkgList != null) {
                    String[] arr$ = app.pkgList;
                    int len$ = arr$.length;
                    for (int i$ = MY_PID; i$ < len$; i$ += SHOW_ERROR_MSG) {
                        extList.add(arr$[i$]);
                    }
                }
            }
            IPackageManager pm = AppGlobals.getPackageManager();
            for (String pkg : extList) {
                try {
                    ApplicationInfo info = pm.getApplicationInfo(pkg, MY_PID, UserHandle.getCallingUserId());
                    if ((info.flags & DROPBOX_MAX_SIZE) != 0) {
                        retList.add(info);
                    }
                } catch (RemoteException e) {
                }
            }
        }
        return retList;
    }

    public void getMyMemoryState(RunningAppProcessInfo outInfo) {
        enforceNotIsolatedCaller("getMyMemoryState");
        synchronized (this) {
            ProcessRecord proc;
            synchronized (this.mPidsSelfLocked) {
                proc = (ProcessRecord) this.mPidsSelfLocked.get(Binder.getCallingPid());
            }
            fillInProcMemInfo(proc, outInfo);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    protected void dump(java.io.FileDescriptor r31, java.io.PrintWriter r32, java.lang.String[] r33) {
        /*
        r30 = this;
        r2 = "android.permission.DUMP";
        r0 = r30;
        r2 = r0.checkCallingPermission(r2);
        if (r2 == 0) goto L_0x0041;
    L_0x000a:
        r2 = new java.lang.StringBuilder;
        r2.<init>();
        r3 = "Permission Denial: can't dump ActivityManager from from pid=";
        r2 = r2.append(r3);
        r3 = android.os.Binder.getCallingPid();
        r2 = r2.append(r3);
        r3 = ", uid=";
        r2 = r2.append(r3);
        r3 = android.os.Binder.getCallingUid();
        r2 = r2.append(r3);
        r3 = " without permission ";
        r2 = r2.append(r3);
        r3 = "android.permission.DUMP";
        r2 = r2.append(r3);
        r2 = r2.toString();
        r0 = r32;
        r0.println(r2);
    L_0x0040:
        return;
    L_0x0041:
        r24 = 0;
        r8 = 0;
        r9 = 0;
        r6 = 0;
    L_0x0046:
        r0 = r33;
        r2 = r0.length;
        if (r6 >= r2) goto L_0x0060;
    L_0x004b:
        r27 = r33[r6];
        if (r27 == 0) goto L_0x0060;
    L_0x004f:
        r2 = r27.length();
        if (r2 <= 0) goto L_0x0060;
    L_0x0055:
        r2 = 0;
        r0 = r27;
        r2 = r0.charAt(r2);
        r3 = 45;
        if (r2 == r3) goto L_0x0097;
    L_0x0060:
        r28 = android.os.Binder.clearCallingIdentity();
        r26 = 0;
        r0 = r33;
        r2 = r0.length;
        if (r6 >= r2) goto L_0x051a;
    L_0x006b:
        r18 = r33[r6];
        r6 = r6 + 1;
        r2 = "activities";
        r0 = r18;
        r2 = r2.equals(r0);
        if (r2 != 0) goto L_0x0083;
    L_0x0079:
        r2 = "a";
        r0 = r18;
        r2 = r2.equals(r0);
        if (r2 == 0) goto L_0x01be;
    L_0x0083:
        monitor-enter(r30);
        r7 = 1;
        r2 = r30;
        r3 = r31;
        r4 = r32;
        r5 = r33;
        r2.dumpActivitiesLocked(r3, r4, r5, r6, r7, r8, r9);	 Catch:{ all -> 0x01bb }
        monitor-exit(r30);	 Catch:{ all -> 0x01bb }
    L_0x0091:
        if (r26 != 0) goto L_0x051a;
    L_0x0093:
        android.os.Binder.restoreCallingIdentity(r28);
        goto L_0x0040;
    L_0x0097:
        r6 = r6 + 1;
        r2 = "-a";
        r0 = r27;
        r2 = r2.equals(r0);
        if (r2 == 0) goto L_0x00a6;
    L_0x00a3:
        r24 = 1;
        goto L_0x0046;
    L_0x00a6:
        r2 = "-c";
        r0 = r27;
        r2 = r2.equals(r0);
        if (r2 == 0) goto L_0x00b2;
    L_0x00b0:
        r8 = 1;
        goto L_0x0046;
    L_0x00b2:
        r2 = "-p";
        r0 = r27;
        r2 = r2.equals(r0);
        if (r2 == 0) goto L_0x00d0;
    L_0x00bc:
        r0 = r33;
        r2 = r0.length;
        if (r6 >= r2) goto L_0x00c7;
    L_0x00c1:
        r9 = r33[r6];
        r6 = r6 + 1;
        r8 = 1;
        goto L_0x0046;
    L_0x00c7:
        r2 = "Error: -p option requires package argument";
        r0 = r32;
        r0.println(r2);
        goto L_0x0040;
    L_0x00d0:
        r2 = "-h";
        r0 = r27;
        r2 = r2.equals(r0);
        if (r2 == 0) goto L_0x0199;
    L_0x00da:
        r2 = "Activity manager dump options:";
        r0 = r32;
        r0.println(r2);
        r2 = "  [-a] [-c] [-p package] [-h] [cmd] ...";
        r0 = r32;
        r0.println(r2);
        r2 = "  cmd may be one of:";
        r0 = r32;
        r0.println(r2);
        r2 = "    a[ctivities]: activity stack state";
        r0 = r32;
        r0.println(r2);
        r2 = "    r[recents]: recent activities state";
        r0 = r32;
        r0.println(r2);
        r2 = "    b[roadcasts] [PACKAGE_NAME] [history [-s]]: broadcast state";
        r0 = r32;
        r0.println(r2);
        r2 = "    i[ntents] [PACKAGE_NAME]: pending intent state";
        r0 = r32;
        r0.println(r2);
        r2 = "    p[rocesses] [PACKAGE_NAME]: process state";
        r0 = r32;
        r0.println(r2);
        r2 = "    o[om]: out of memory management";
        r0 = r32;
        r0.println(r2);
        r2 = "    prov[iders] [COMP_SPEC ...]: content provider state";
        r0 = r32;
        r0.println(r2);
        r2 = "    provider [COMP_SPEC]: provider client-side state";
        r0 = r32;
        r0.println(r2);
        r2 = "    s[ervices] [COMP_SPEC ...]: service state";
        r0 = r32;
        r0.println(r2);
        r2 = "    as[sociations]: tracked app associations";
        r0 = r32;
        r0.println(r2);
        r2 = "    service [COMP_SPEC]: service client-side state";
        r0 = r32;
        r0.println(r2);
        r2 = "    package [PACKAGE_NAME]: all state related to given package";
        r0 = r32;
        r0.println(r2);
        r2 = "    all: dump all activities";
        r0 = r32;
        r0.println(r2);
        r2 = "    top: dump the top activity";
        r0 = r32;
        r0.println(r2);
        r2 = "    write: write all pending state to storage";
        r0 = r32;
        r0.println(r2);
        r2 = "    track-associations: enable association tracking";
        r0 = r32;
        r0.println(r2);
        r2 = "    untrack-associations: disable and clear association tracking";
        r0 = r32;
        r0.println(r2);
        r2 = "  cmd may also be a COMP_SPEC to dump activities.";
        r0 = r32;
        r0.println(r2);
        r2 = "  COMP_SPEC may be a component name (com.foo/.myApp),";
        r0 = r32;
        r0.println(r2);
        r2 = "    a partial substring in a component name, a";
        r0 = r32;
        r0.println(r2);
        r2 = "    hex object identifier.";
        r0 = r32;
        r0.println(r2);
        r2 = "  -a: include all available server state.";
        r0 = r32;
        r0.println(r2);
        r2 = "  -c: include client state.";
        r0 = r32;
        r0.println(r2);
        r2 = "  -p: limit output to given package.";
        r0 = r32;
        r0.println(r2);
        goto L_0x0040;
    L_0x0199:
        r2 = new java.lang.StringBuilder;
        r2.<init>();
        r3 = "Unknown argument: ";
        r2 = r2.append(r3);
        r0 = r27;
        r2 = r2.append(r0);
        r3 = "; use -h for help";
        r2 = r2.append(r3);
        r2 = r2.toString();
        r0 = r32;
        r0.println(r2);
        goto L_0x0046;
    L_0x01bb:
        r2 = move-exception;
        monitor-exit(r30);	 Catch:{ all -> 0x01bb }
        throw r2;
    L_0x01be:
        r2 = "recents";
        r0 = r18;
        r2 = r2.equals(r0);
        if (r2 != 0) goto L_0x01d2;
    L_0x01c8:
        r2 = "r";
        r0 = r18;
        r2 = r2.equals(r0);
        if (r2 == 0) goto L_0x01e8;
    L_0x01d2:
        monitor-enter(r30);
        r15 = 1;
        r10 = r30;
        r11 = r31;
        r12 = r32;
        r13 = r33;
        r14 = r6;
        r16 = r9;
        r10.dumpRecentsLocked(r11, r12, r13, r14, r15, r16);	 Catch:{ all -> 0x01e5 }
        monitor-exit(r30);	 Catch:{ all -> 0x01e5 }
        goto L_0x0091;
    L_0x01e5:
        r2 = move-exception;
        monitor-exit(r30);	 Catch:{ all -> 0x01e5 }
        throw r2;
    L_0x01e8:
        r2 = "broadcasts";
        r0 = r18;
        r2 = r2.equals(r0);
        if (r2 != 0) goto L_0x01fc;
    L_0x01f2:
        r2 = "b";
        r0 = r18;
        r2 = r2.equals(r0);
        if (r2 == 0) goto L_0x0235;
    L_0x01fc:
        r0 = r33;
        r2 = r0.length;
        if (r6 < r2) goto L_0x021a;
    L_0x0201:
        r13 = 0;
        r14 = EMPTY_STRING_ARRAY;
    L_0x0204:
        monitor-enter(r30);
        r15 = 1;
        r10 = r30;
        r11 = r31;
        r12 = r32;
        r13 = r33;
        r14 = r6;
        r16 = r9;
        r10.dumpBroadcastsLocked(r11, r12, r13, r14, r15, r16);	 Catch:{ all -> 0x0217 }
        monitor-exit(r30);	 Catch:{ all -> 0x0217 }
        goto L_0x0091;
    L_0x0217:
        r2 = move-exception;
        monitor-exit(r30);	 Catch:{ all -> 0x0217 }
        throw r2;
    L_0x021a:
        r9 = r33[r6];
        r6 = r6 + 1;
        r0 = r33;
        r2 = r0.length;
        r2 = r2 - r6;
        r14 = new java.lang.String[r2];
        r0 = r33;
        r2 = r0.length;
        r3 = 2;
        if (r2 <= r3) goto L_0x0204;
    L_0x022a:
        r2 = 0;
        r0 = r33;
        r3 = r0.length;
        r3 = r3 - r6;
        r0 = r33;
        java.lang.System.arraycopy(r0, r6, r14, r2, r3);
        goto L_0x0204;
    L_0x0235:
        r2 = "intents";
        r0 = r18;
        r2 = r2.equals(r0);
        if (r2 != 0) goto L_0x0249;
    L_0x023f:
        r2 = "i";
        r0 = r18;
        r2 = r2.equals(r0);
        if (r2 == 0) goto L_0x0282;
    L_0x0249:
        r0 = r33;
        r2 = r0.length;
        if (r6 < r2) goto L_0x0267;
    L_0x024e:
        r13 = 0;
        r14 = EMPTY_STRING_ARRAY;
    L_0x0251:
        monitor-enter(r30);
        r15 = 1;
        r10 = r30;
        r11 = r31;
        r12 = r32;
        r13 = r33;
        r14 = r6;
        r16 = r9;
        r10.dumpPendingIntentsLocked(r11, r12, r13, r14, r15, r16);	 Catch:{ all -> 0x0264 }
        monitor-exit(r30);	 Catch:{ all -> 0x0264 }
        goto L_0x0091;
    L_0x0264:
        r2 = move-exception;
        monitor-exit(r30);	 Catch:{ all -> 0x0264 }
        throw r2;
    L_0x0267:
        r9 = r33[r6];
        r6 = r6 + 1;
        r0 = r33;
        r2 = r0.length;
        r2 = r2 - r6;
        r14 = new java.lang.String[r2];
        r0 = r33;
        r2 = r0.length;
        r3 = 2;
        if (r2 <= r3) goto L_0x0251;
    L_0x0277:
        r2 = 0;
        r0 = r33;
        r3 = r0.length;
        r3 = r3 - r6;
        r0 = r33;
        java.lang.System.arraycopy(r0, r6, r14, r2, r3);
        goto L_0x0251;
    L_0x0282:
        r2 = "processes";
        r0 = r18;
        r2 = r2.equals(r0);
        if (r2 != 0) goto L_0x0296;
    L_0x028c:
        r2 = "p";
        r0 = r18;
        r2 = r2.equals(r0);
        if (r2 == 0) goto L_0x02cf;
    L_0x0296:
        r0 = r33;
        r2 = r0.length;
        if (r6 < r2) goto L_0x02b4;
    L_0x029b:
        r13 = 0;
        r14 = EMPTY_STRING_ARRAY;
    L_0x029e:
        monitor-enter(r30);
        r15 = 1;
        r10 = r30;
        r11 = r31;
        r12 = r32;
        r13 = r33;
        r14 = r6;
        r16 = r9;
        r10.dumpProcessesLocked(r11, r12, r13, r14, r15, r16);	 Catch:{ all -> 0x02b1 }
        monitor-exit(r30);	 Catch:{ all -> 0x02b1 }
        goto L_0x0091;
    L_0x02b1:
        r2 = move-exception;
        monitor-exit(r30);	 Catch:{ all -> 0x02b1 }
        throw r2;
    L_0x02b4:
        r9 = r33[r6];
        r6 = r6 + 1;
        r0 = r33;
        r2 = r0.length;
        r2 = r2 - r6;
        r14 = new java.lang.String[r2];
        r0 = r33;
        r2 = r0.length;
        r3 = 2;
        if (r2 <= r3) goto L_0x029e;
    L_0x02c4:
        r2 = 0;
        r0 = r33;
        r3 = r0.length;
        r3 = r3 - r6;
        r0 = r33;
        java.lang.System.arraycopy(r0, r6, r14, r2, r3);
        goto L_0x029e;
    L_0x02cf:
        r2 = "oom";
        r0 = r18;
        r2 = r2.equals(r0);
        if (r2 != 0) goto L_0x02e3;
    L_0x02d9:
        r2 = "o";
        r0 = r18;
        r2 = r2.equals(r0);
        if (r2 == 0) goto L_0x02f6;
    L_0x02e3:
        monitor-enter(r30);
        r7 = 1;
        r2 = r30;
        r3 = r31;
        r4 = r32;
        r5 = r33;
        r2.dumpOomLocked(r3, r4, r5, r6, r7);	 Catch:{ all -> 0x02f3 }
        monitor-exit(r30);	 Catch:{ all -> 0x02f3 }
        goto L_0x0091;
    L_0x02f3:
        r2 = move-exception;
        monitor-exit(r30);	 Catch:{ all -> 0x02f3 }
        throw r2;
    L_0x02f6:
        r2 = "provider";
        r0 = r18;
        r2 = r2.equals(r0);
        if (r2 == 0) goto L_0x0353;
    L_0x0300:
        r0 = r33;
        r2 = r0.length;
        if (r6 < r2) goto L_0x0338;
    L_0x0305:
        r13 = 0;
        r14 = EMPTY_STRING_ARRAY;
    L_0x0308:
        r15 = 0;
        r10 = r30;
        r11 = r31;
        r12 = r32;
        r16 = r24;
        r2 = r10.dumpProvider(r11, r12, r13, r14, r15, r16);
        if (r2 != 0) goto L_0x0091;
    L_0x0317:
        r2 = new java.lang.StringBuilder;
        r2.<init>();
        r3 = "No providers match: ";
        r2 = r2.append(r3);
        r2 = r2.append(r13);
        r2 = r2.toString();
        r0 = r32;
        r0.println(r2);
        r2 = "Use -h for help.";
        r0 = r32;
        r0.println(r2);
        goto L_0x0091;
    L_0x0338:
        r13 = r33[r6];
        r6 = r6 + 1;
        r0 = r33;
        r2 = r0.length;
        r2 = r2 - r6;
        r14 = new java.lang.String[r2];
        r0 = r33;
        r2 = r0.length;
        r3 = 2;
        if (r2 <= r3) goto L_0x0308;
    L_0x0348:
        r2 = 0;
        r0 = r33;
        r3 = r0.length;
        r3 = r3 - r6;
        r0 = r33;
        java.lang.System.arraycopy(r0, r6, r14, r2, r3);
        goto L_0x0308;
    L_0x0353:
        r2 = "providers";
        r0 = r18;
        r2 = r2.equals(r0);
        if (r2 != 0) goto L_0x0367;
    L_0x035d:
        r2 = "prov";
        r0 = r18;
        r2 = r2.equals(r0);
        if (r2 == 0) goto L_0x037f;
    L_0x0367:
        monitor-enter(r30);
        r20 = 1;
        r21 = 0;
        r15 = r30;
        r16 = r31;
        r17 = r32;
        r18 = r33;
        r19 = r6;
        r15.dumpProvidersLocked(r16, r17, r18, r19, r20, r21);	 Catch:{ all -> 0x037c }
        monitor-exit(r30);	 Catch:{ all -> 0x037c }
        goto L_0x0091;
    L_0x037c:
        r2 = move-exception;
        monitor-exit(r30);	 Catch:{ all -> 0x037c }
        throw r2;
    L_0x037f:
        r2 = "service";
        r0 = r18;
        r2 = r2.equals(r0);
        if (r2 == 0) goto L_0x03de;
    L_0x0389:
        r0 = r33;
        r2 = r0.length;
        if (r6 < r2) goto L_0x03c3;
    L_0x038e:
        r13 = 0;
        r14 = EMPTY_STRING_ARRAY;
    L_0x0391:
        r0 = r30;
        r10 = r0.mServices;
        r15 = 0;
        r11 = r31;
        r12 = r32;
        r16 = r24;
        r2 = r10.dumpService(r11, r12, r13, r14, r15, r16);
        if (r2 != 0) goto L_0x0091;
    L_0x03a2:
        r2 = new java.lang.StringBuilder;
        r2.<init>();
        r3 = "No services match: ";
        r2 = r2.append(r3);
        r2 = r2.append(r13);
        r2 = r2.toString();
        r0 = r32;
        r0.println(r2);
        r2 = "Use -h for help.";
        r0 = r32;
        r0.println(r2);
        goto L_0x0091;
    L_0x03c3:
        r13 = r33[r6];
        r6 = r6 + 1;
        r0 = r33;
        r2 = r0.length;
        r2 = r2 - r6;
        r14 = new java.lang.String[r2];
        r0 = r33;
        r2 = r0.length;
        r3 = 2;
        if (r2 <= r3) goto L_0x0391;
    L_0x03d3:
        r2 = 0;
        r0 = r33;
        r3 = r0.length;
        r3 = r3 - r6;
        r0 = r33;
        java.lang.System.arraycopy(r0, r6, r14, r2, r3);
        goto L_0x0391;
    L_0x03de:
        r2 = "package";
        r0 = r18;
        r2 = r2.equals(r0);
        if (r2 == 0) goto L_0x041e;
    L_0x03e8:
        r0 = r33;
        r2 = r0.length;
        if (r6 < r2) goto L_0x03fd;
    L_0x03ed:
        r2 = "package: no package name specified";
        r0 = r32;
        r0.println(r2);
        r2 = "Use -h for help.";
        r0 = r32;
        r0.println(r2);
        goto L_0x0091;
    L_0x03fd:
        r9 = r33[r6];
        r6 = r6 + 1;
        r0 = r33;
        r2 = r0.length;
        r2 = r2 - r6;
        r14 = new java.lang.String[r2];
        r0 = r33;
        r2 = r0.length;
        r3 = 2;
        if (r2 <= r3) goto L_0x0417;
    L_0x040d:
        r2 = 0;
        r0 = r33;
        r3 = r0.length;
        r3 = r3 - r6;
        r0 = r33;
        java.lang.System.arraycopy(r0, r6, r14, r2, r3);
    L_0x0417:
        r33 = r14;
        r6 = 0;
        r26 = 1;
        goto L_0x0091;
    L_0x041e:
        r2 = "associations";
        r0 = r18;
        r2 = r2.equals(r0);
        if (r2 != 0) goto L_0x0432;
    L_0x0428:
        r2 = "as";
        r0 = r18;
        r2 = r2.equals(r0);
        if (r2 == 0) goto L_0x0445;
    L_0x0432:
        monitor-enter(r30);
        r7 = 1;
        r2 = r30;
        r3 = r31;
        r4 = r32;
        r5 = r33;
        r2.dumpAssociationsLocked(r3, r4, r5, r6, r7, r8, r9);	 Catch:{ all -> 0x0442 }
        monitor-exit(r30);	 Catch:{ all -> 0x0442 }
        goto L_0x0091;
    L_0x0442:
        r2 = move-exception;
        monitor-exit(r30);	 Catch:{ all -> 0x0442 }
        throw r2;
    L_0x0445:
        r2 = "services";
        r0 = r18;
        r2 = r2.equals(r0);
        if (r2 != 0) goto L_0x0459;
    L_0x044f:
        r2 = "s";
        r0 = r18;
        r2 = r2.equals(r0);
        if (r2 == 0) goto L_0x046e;
    L_0x0459:
        monitor-enter(r30);
        r0 = r30;
        r2 = r0.mServices;	 Catch:{ all -> 0x046b }
        r7 = 1;
        r3 = r31;
        r4 = r32;
        r5 = r33;
        r2.dumpServicesLocked(r3, r4, r5, r6, r7, r8, r9);	 Catch:{ all -> 0x046b }
        monitor-exit(r30);	 Catch:{ all -> 0x046b }
        goto L_0x0091;
    L_0x046b:
        r2 = move-exception;
        monitor-exit(r30);	 Catch:{ all -> 0x046b }
        throw r2;
    L_0x046e:
        r2 = "write";
        r0 = r18;
        r2 = r2.equals(r0);
        if (r2 == 0) goto L_0x0488;
    L_0x0478:
        r0 = r30;
        r2 = r0.mTaskPersister;
        r2.flush();
        r2 = "All tasks persisted.";
        r0 = r32;
        r0.println(r2);
        goto L_0x0040;
    L_0x0488:
        r2 = "track-associations";
        r0 = r18;
        r2 = r2.equals(r0);
        if (r2 == 0) goto L_0x04b3;
    L_0x0492:
        monitor-enter(r30);
        r0 = r30;
        r2 = r0.mTrackingAssociations;	 Catch:{ all -> 0x04a8 }
        if (r2 != 0) goto L_0x04ab;
    L_0x0499:
        r2 = 1;
        r0 = r30;
        r0.mTrackingAssociations = r2;	 Catch:{ all -> 0x04a8 }
        r2 = "Association tracking started.";
        r0 = r32;
        r0.println(r2);	 Catch:{ all -> 0x04a8 }
    L_0x04a5:
        monitor-exit(r30);	 Catch:{ all -> 0x04a8 }
        goto L_0x0040;
    L_0x04a8:
        r2 = move-exception;
        monitor-exit(r30);	 Catch:{ all -> 0x04a8 }
        throw r2;
    L_0x04ab:
        r2 = "Association tracking already enabled.";
        r0 = r32;
        r0.println(r2);	 Catch:{ all -> 0x04a8 }
        goto L_0x04a5;
    L_0x04b3:
        r2 = "untrack-associations";
        r0 = r18;
        r2 = r2.equals(r0);
        if (r2 == 0) goto L_0x04e5;
    L_0x04bd:
        monitor-enter(r30);
        r0 = r30;
        r2 = r0.mTrackingAssociations;	 Catch:{ all -> 0x04da }
        if (r2 == 0) goto L_0x04dd;
    L_0x04c4:
        r2 = 0;
        r0 = r30;
        r0.mTrackingAssociations = r2;	 Catch:{ all -> 0x04da }
        r0 = r30;
        r2 = r0.mAssociations;	 Catch:{ all -> 0x04da }
        r2.clear();	 Catch:{ all -> 0x04da }
        r2 = "Association tracking stopped.";
        r0 = r32;
        r0.println(r2);	 Catch:{ all -> 0x04da }
    L_0x04d7:
        monitor-exit(r30);	 Catch:{ all -> 0x04da }
        goto L_0x0040;
    L_0x04da:
        r2 = move-exception;
        monitor-exit(r30);	 Catch:{ all -> 0x04da }
        throw r2;
    L_0x04dd:
        r2 = "Association tracking not running.";
        r0 = r32;
        r0.println(r2);	 Catch:{ all -> 0x04da }
        goto L_0x04d7;
    L_0x04e5:
        r15 = r30;
        r16 = r31;
        r17 = r32;
        r19 = r33;
        r20 = r6;
        r21 = r24;
        r2 = r15.dumpActivity(r16, r17, r18, r19, r20, r21);
        if (r2 != 0) goto L_0x0091;
    L_0x04f7:
        r2 = new java.lang.StringBuilder;
        r2.<init>();
        r3 = "Bad activity command, or no activities match: ";
        r2 = r2.append(r3);
        r0 = r18;
        r2 = r2.append(r0);
        r2 = r2.toString();
        r0 = r32;
        r0.println(r2);
        r2 = "Use -h for help.";
        r0 = r32;
        r0.println(r2);
        goto L_0x0091;
    L_0x051a:
        monitor-enter(r30);
        r19 = r30;
        r20 = r31;
        r21 = r32;
        r22 = r33;
        r23 = r6;
        r25 = r9;
        r19.dumpPendingIntentsLocked(r20, r21, r22, r23, r24, r25);	 Catch:{ all -> 0x05f3 }
        r32.println();	 Catch:{ all -> 0x05f3 }
        if (r24 == 0) goto L_0x0536;
    L_0x052f:
        r2 = "-------------------------------------------------------------------------------";
        r0 = r32;
        r0.println(r2);	 Catch:{ all -> 0x05f3 }
    L_0x0536:
        r19 = r30;
        r20 = r31;
        r21 = r32;
        r22 = r33;
        r23 = r6;
        r25 = r9;
        r19.dumpBroadcastsLocked(r20, r21, r22, r23, r24, r25);	 Catch:{ all -> 0x05f3 }
        r32.println();	 Catch:{ all -> 0x05f3 }
        if (r24 == 0) goto L_0x0551;
    L_0x054a:
        r2 = "-------------------------------------------------------------------------------";
        r0 = r32;
        r0.println(r2);	 Catch:{ all -> 0x05f3 }
    L_0x0551:
        r19 = r30;
        r20 = r31;
        r21 = r32;
        r22 = r33;
        r23 = r6;
        r25 = r9;
        r19.dumpProvidersLocked(r20, r21, r22, r23, r24, r25);	 Catch:{ all -> 0x05f3 }
        r32.println();	 Catch:{ all -> 0x05f3 }
        if (r24 == 0) goto L_0x056c;
    L_0x0565:
        r2 = "-------------------------------------------------------------------------------";
        r0 = r32;
        r0.println(r2);	 Catch:{ all -> 0x05f3 }
    L_0x056c:
        r0 = r30;
        r2 = r0.mServices;	 Catch:{ all -> 0x05f3 }
        r3 = r31;
        r4 = r32;
        r5 = r33;
        r7 = r24;
        r2.dumpServicesLocked(r3, r4, r5, r6, r7, r8, r9);	 Catch:{ all -> 0x05f3 }
        r32.println();	 Catch:{ all -> 0x05f3 }
        if (r24 == 0) goto L_0x0587;
    L_0x0580:
        r2 = "-------------------------------------------------------------------------------";
        r0 = r32;
        r0.println(r2);	 Catch:{ all -> 0x05f3 }
    L_0x0587:
        r19 = r30;
        r20 = r31;
        r21 = r32;
        r22 = r33;
        r23 = r6;
        r25 = r9;
        r19.dumpRecentsLocked(r20, r21, r22, r23, r24, r25);	 Catch:{ all -> 0x05f3 }
        r32.println();	 Catch:{ all -> 0x05f3 }
        if (r24 == 0) goto L_0x05a2;
    L_0x059b:
        r2 = "-------------------------------------------------------------------------------";
        r0 = r32;
        r0.println(r2);	 Catch:{ all -> 0x05f3 }
    L_0x05a2:
        r2 = r30;
        r3 = r31;
        r4 = r32;
        r5 = r33;
        r7 = r24;
        r2.dumpActivitiesLocked(r3, r4, r5, r6, r7, r8, r9);	 Catch:{ all -> 0x05f3 }
        r0 = r30;
        r2 = r0.mAssociations;	 Catch:{ all -> 0x05f3 }
        r2 = r2.size();	 Catch:{ all -> 0x05f3 }
        if (r2 <= 0) goto L_0x05d2;
    L_0x05b9:
        r32.println();	 Catch:{ all -> 0x05f3 }
        if (r24 == 0) goto L_0x05c5;
    L_0x05be:
        r2 = "-------------------------------------------------------------------------------";
        r0 = r32;
        r0.println(r2);	 Catch:{ all -> 0x05f3 }
    L_0x05c5:
        r2 = r30;
        r3 = r31;
        r4 = r32;
        r5 = r33;
        r7 = r24;
        r2.dumpAssociationsLocked(r3, r4, r5, r6, r7, r8, r9);	 Catch:{ all -> 0x05f3 }
    L_0x05d2:
        r32.println();	 Catch:{ all -> 0x05f3 }
        if (r24 == 0) goto L_0x05de;
    L_0x05d7:
        r2 = "-------------------------------------------------------------------------------";
        r0 = r32;
        r0.println(r2);	 Catch:{ all -> 0x05f3 }
    L_0x05de:
        r19 = r30;
        r20 = r31;
        r21 = r32;
        r22 = r33;
        r23 = r6;
        r25 = r9;
        r19.dumpProcessesLocked(r20, r21, r22, r23, r24, r25);	 Catch:{ all -> 0x05f3 }
        monitor-exit(r30);	 Catch:{ all -> 0x05f3 }
        android.os.Binder.restoreCallingIdentity(r28);
        goto L_0x0040;
    L_0x05f3:
        r2 = move-exception;
        monitor-exit(r30);	 Catch:{ all -> 0x05f3 }
        throw r2;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.ActivityManagerService.dump(java.io.FileDescriptor, java.io.PrintWriter, java.lang.String[]):void");
    }

    void dumpActivitiesLocked(FileDescriptor fd, PrintWriter pw, String[] args, int opti, boolean dumpAll, boolean dumpClient, String dumpPackage) {
        pw.println("ACTIVITY MANAGER ACTIVITIES (dumpsys activity activities)");
        boolean printedAnything = this.mStackSupervisor.dumpActivitiesLocked(fd, pw, dumpAll, dumpClient, dumpPackage);
        boolean needSep = printedAnything;
        if (ActivityStackSupervisor.printThisActivity(pw, this.mFocusedActivity, dumpPackage, needSep, "  mFocusedActivity: ")) {
            printedAnything = SHOW_ACTIVITY_START_TIME;
            needSep = VALIDATE_TOKENS;
        }
        if (dumpPackage == null) {
            if (needSep) {
                pw.println();
            }
            printedAnything = SHOW_ACTIVITY_START_TIME;
            this.mStackSupervisor.dump(pw, "  ");
        }
        if (!printedAnything) {
            pw.println("  (nothing)");
        }
    }

    void dumpRecentsLocked(FileDescriptor fd, PrintWriter pw, String[] args, int opti, boolean dumpAll, String dumpPackage) {
        pw.println("ACTIVITY MANAGER RECENT TASKS (dumpsys activity recents)");
        boolean printedAnything = VALIDATE_TOKENS;
        if (this.mRecentTasks != null && this.mRecentTasks.size() > 0) {
            boolean printedHeader = VALIDATE_TOKENS;
            int N = this.mRecentTasks.size();
            for (int i = MY_PID; i < N; i += SHOW_ERROR_MSG) {
                TaskRecord tr = (TaskRecord) this.mRecentTasks.get(i);
                if (dumpPackage == null || (tr.realActivity != null && dumpPackage.equals(tr.realActivity))) {
                    if (!printedHeader) {
                        pw.println("  Recent tasks:");
                        printedHeader = SHOW_ACTIVITY_START_TIME;
                        printedAnything = SHOW_ACTIVITY_START_TIME;
                    }
                    pw.print("  * Recent #");
                    pw.print(i);
                    pw.print(": ");
                    pw.println(tr);
                    if (dumpAll) {
                        ((TaskRecord) this.mRecentTasks.get(i)).dump(pw, "    ");
                    }
                }
            }
        }
        if (!printedAnything) {
            pw.println("  (nothing)");
        }
    }

    void dumpAssociationsLocked(FileDescriptor fd, PrintWriter pw, String[] args, int opti, boolean dumpAll, boolean dumpClient, String dumpPackage) {
        pw.println("ACTIVITY MANAGER ASSOCIATIONS (dumpsys activity associations)");
        int dumpUid = MY_PID;
        if (dumpPackage != null) {
            try {
                dumpUid = AppGlobals.getPackageManager().getPackageUid(dumpPackage, MY_PID);
            } catch (RemoteException e) {
            }
        }
        boolean printedAnything = VALIDATE_TOKENS;
        long now = SystemClock.uptimeMillis();
        int N1 = this.mAssociations.size();
        for (int i1 = MY_PID; i1 < N1; i1 += SHOW_ERROR_MSG) {
            ArrayMap<ComponentName, SparseArray<ArrayMap<String, Association>>> targetComponents = (ArrayMap) this.mAssociations.valueAt(i1);
            int N2 = targetComponents.size();
            for (int i2 = MY_PID; i2 < N2; i2 += SHOW_ERROR_MSG) {
                SparseArray<ArrayMap<String, Association>> sourceUids = (SparseArray) targetComponents.valueAt(i2);
                int N3 = sourceUids.size();
                for (int i3 = MY_PID; i3 < N3; i3 += SHOW_ERROR_MSG) {
                    ArrayMap<String, Association> sourceProcesses = (ArrayMap) sourceUids.valueAt(i3);
                    int N4 = sourceProcesses.size();
                    for (int i4 = MY_PID; i4 < N4; i4 += SHOW_ERROR_MSG) {
                        Association ass = (Association) sourceProcesses.valueAt(i4);
                        if (dumpPackage != null) {
                            if (!ass.mTargetComponent.getPackageName().equals(dumpPackage)) {
                                if (UserHandle.getAppId(ass.mSourceUid) != dumpUid) {
                                }
                            }
                        }
                        printedAnything = SHOW_ACTIVITY_START_TIME;
                        pw.print("  ");
                        pw.print(ass.mTargetProcess);
                        pw.print("/");
                        UserHandle.formatUid(pw, ass.mTargetUid);
                        pw.print(" <- ");
                        pw.print(ass.mSourceProcess);
                        pw.print("/");
                        UserHandle.formatUid(pw, ass.mSourceUid);
                        pw.println();
                        pw.print("    via ");
                        pw.print(ass.mTargetComponent.flattenToShortString());
                        pw.println();
                        pw.print("    ");
                        long dur = ass.mTime;
                        if (ass.mNesting > 0) {
                            dur += now - ass.mStartTime;
                        }
                        TimeUtils.formatDuration(dur, pw);
                        pw.print(" (");
                        pw.print(ass.mCount);
                        pw.println(" times)");
                        if (ass.mNesting > 0) {
                            pw.print("    ");
                            pw.print(" Currently active: ");
                            TimeUtils.formatDuration(now - ass.mStartTime, pw);
                            pw.println();
                        }
                    }
                }
            }
        }
        if (!printedAnything) {
            pw.println("  (nothing)");
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    void dumpProcessesLocked(java.io.FileDescriptor r42, java.io.PrintWriter r43, java.lang.String[] r44, int r45, boolean r46, java.lang.String r47) {
        /*
        r41 = this;
        r9 = 0;
        r33 = 0;
        r26 = 0;
        r4 = "ACTIVITY MANAGER RUNNING PROCESSES (dumpsys activity processes)";
        r0 = r43;
        r0.println(r4);
        if (r46 == 0) goto L_0x00a9;
    L_0x000e:
        r0 = r41;
        r4 = r0.mProcessNames;
        r4 = r4.getMap();
        r14 = r4.size();
        r20 = 0;
    L_0x001c:
        r0 = r20;
        if (r0 >= r14) goto L_0x00a9;
    L_0x0020:
        r0 = r41;
        r4 = r0.mProcessNames;
        r4 = r4.getMap();
        r0 = r20;
        r34 = r4.valueAt(r0);
        r34 = (android.util.SparseArray) r34;
        r13 = r34.size();
        r18 = 0;
    L_0x0036:
        r0 = r18;
        if (r0 >= r13) goto L_0x00a5;
    L_0x003a:
        r0 = r34;
        r1 = r18;
        r36 = r0.valueAt(r1);
        r36 = (com.android.server.am.ProcessRecord) r36;
        if (r47 == 0) goto L_0x0055;
    L_0x0046:
        r0 = r36;
        r4 = r0.pkgList;
        r0 = r47;
        r4 = r4.containsKey(r0);
        if (r4 != 0) goto L_0x0055;
    L_0x0052:
        r18 = r18 + 1;
        goto L_0x0036;
    L_0x0055:
        if (r9 != 0) goto L_0x0061;
    L_0x0057:
        r4 = "  All known processes:";
        r0 = r43;
        r0.println(r4);
        r9 = 1;
        r33 = 1;
    L_0x0061:
        r0 = r36;
        r4 = r0.persistent;
        if (r4 == 0) goto L_0x00a2;
    L_0x0067:
        r4 = "  *PERS*";
    L_0x0069:
        r0 = r43;
        r0.print(r4);
        r4 = " UID ";
        r0 = r43;
        r0.print(r4);
        r0 = r34;
        r1 = r18;
        r4 = r0.keyAt(r1);
        r0 = r43;
        r0.print(r4);
        r4 = " ";
        r0 = r43;
        r0.print(r4);
        r0 = r43;
        r1 = r36;
        r0.println(r1);
        r4 = "    ";
        r0 = r36;
        r1 = r43;
        r0.dump(r1, r4);
        r0 = r36;
        r4 = r0.persistent;
        if (r4 == 0) goto L_0x0052;
    L_0x009f:
        r26 = r26 + 1;
        goto L_0x0052;
    L_0x00a2:
        r4 = "  *APP*";
        goto L_0x0069;
    L_0x00a5:
        r20 = r20 + 1;
        goto L_0x001c;
    L_0x00a9:
        r0 = r41;
        r4 = r0.mIsolatedProcesses;
        r4 = r4.size();
        if (r4 <= 0) goto L_0x0115;
    L_0x00b3:
        r32 = 0;
        r16 = 0;
    L_0x00b7:
        r0 = r41;
        r4 = r0.mIsolatedProcesses;
        r4 = r4.size();
        r0 = r16;
        if (r0 >= r4) goto L_0x0115;
    L_0x00c3:
        r0 = r41;
        r4 = r0.mIsolatedProcesses;
        r0 = r16;
        r36 = r4.valueAt(r0);
        r36 = (com.android.server.am.ProcessRecord) r36;
        if (r47 == 0) goto L_0x00e0;
    L_0x00d1:
        r0 = r36;
        r4 = r0.pkgList;
        r0 = r47;
        r4 = r4.containsKey(r0);
        if (r4 != 0) goto L_0x00e0;
    L_0x00dd:
        r16 = r16 + 1;
        goto L_0x00b7;
    L_0x00e0:
        if (r32 != 0) goto L_0x00f3;
    L_0x00e2:
        if (r9 == 0) goto L_0x00e7;
    L_0x00e4:
        r43.println();
    L_0x00e7:
        r4 = "  Isolated process list (sorted by uid):";
        r0 = r43;
        r0.println(r4);
        r33 = 1;
        r32 = 1;
        r9 = 1;
    L_0x00f3:
        r4 = "%sIsolated #%2d: %s";
        r5 = 3;
        r5 = new java.lang.Object[r5];
        r6 = 0;
        r7 = "    ";
        r5[r6] = r7;
        r6 = 1;
        r7 = java.lang.Integer.valueOf(r16);
        r5[r6] = r7;
        r6 = 2;
        r7 = r36.toString();
        r5[r6] = r7;
        r4 = java.lang.String.format(r4, r5);
        r0 = r43;
        r0.println(r4);
        goto L_0x00dd;
    L_0x0115:
        r0 = r41;
        r4 = r0.mLruProcesses;
        r4 = r4.size();
        if (r4 <= 0) goto L_0x0188;
    L_0x011f:
        if (r9 == 0) goto L_0x0124;
    L_0x0121:
        r43.println();
    L_0x0124:
        r4 = "  Process LRU list (sorted by oom_adj, ";
        r0 = r43;
        r0.print(r4);
        r0 = r41;
        r4 = r0.mLruProcesses;
        r4 = r4.size();
        r0 = r43;
        r0.print(r4);
        r4 = " total, non-act at ";
        r0 = r43;
        r0.print(r4);
        r0 = r41;
        r4 = r0.mLruProcesses;
        r4 = r4.size();
        r0 = r41;
        r5 = r0.mLruProcessActivityStart;
        r4 = r4 - r5;
        r0 = r43;
        r0.print(r4);
        r4 = ", non-svc at ";
        r0 = r43;
        r0.print(r4);
        r0 = r41;
        r4 = r0.mLruProcesses;
        r4 = r4.size();
        r0 = r41;
        r5 = r0.mLruProcessServiceStart;
        r4 = r4 - r5;
        r0 = r43;
        r0.print(r4);
        r4 = "):";
        r0 = r43;
        r0.println(r4);
        r0 = r41;
        r6 = r0.mLruProcesses;
        r7 = "    ";
        r8 = "Proc";
        r9 = "PERS";
        r10 = 0;
        r4 = r43;
        r5 = r41;
        r11 = r47;
        dumpProcessOomList(r4, r5, r6, r7, r8, r9, r10, r11);
        r9 = 1;
        r33 = 1;
    L_0x0188:
        if (r46 != 0) goto L_0x018c;
    L_0x018a:
        if (r47 == 0) goto L_0x0202;
    L_0x018c:
        r0 = r41;
        r5 = r0.mPidsSelfLocked;
        monitor-enter(r5);
        r32 = 0;
        r16 = 0;
    L_0x0195:
        r0 = r41;
        r4 = r0.mPidsSelfLocked;	 Catch:{ all -> 0x01fe }
        r4 = r4.size();	 Catch:{ all -> 0x01fe }
        r0 = r16;
        if (r0 >= r4) goto L_0x0201;
    L_0x01a1:
        r0 = r41;
        r4 = r0.mPidsSelfLocked;	 Catch:{ all -> 0x01fe }
        r0 = r16;
        r36 = r4.valueAt(r0);	 Catch:{ all -> 0x01fe }
        r36 = (com.android.server.am.ProcessRecord) r36;	 Catch:{ all -> 0x01fe }
        if (r47 == 0) goto L_0x01be;
    L_0x01af:
        r0 = r36;
        r4 = r0.pkgList;	 Catch:{ all -> 0x01fe }
        r0 = r47;
        r4 = r4.containsKey(r0);	 Catch:{ all -> 0x01fe }
        if (r4 != 0) goto L_0x01be;
    L_0x01bb:
        r16 = r16 + 1;
        goto L_0x0195;
    L_0x01be:
        if (r32 != 0) goto L_0x01d1;
    L_0x01c0:
        if (r9 == 0) goto L_0x01c5;
    L_0x01c2:
        r43.println();	 Catch:{ all -> 0x01fe }
    L_0x01c5:
        r9 = 1;
        r4 = "  PID mappings:";
        r0 = r43;
        r0.println(r4);	 Catch:{ all -> 0x01fe }
        r32 = 1;
        r33 = 1;
    L_0x01d1:
        r4 = "    PID #";
        r0 = r43;
        r0.print(r4);	 Catch:{ all -> 0x01fe }
        r0 = r41;
        r4 = r0.mPidsSelfLocked;	 Catch:{ all -> 0x01fe }
        r0 = r16;
        r4 = r4.keyAt(r0);	 Catch:{ all -> 0x01fe }
        r0 = r43;
        r0.print(r4);	 Catch:{ all -> 0x01fe }
        r4 = ": ";
        r0 = r43;
        r0.print(r4);	 Catch:{ all -> 0x01fe }
        r0 = r41;
        r4 = r0.mPidsSelfLocked;	 Catch:{ all -> 0x01fe }
        r0 = r16;
        r4 = r4.valueAt(r0);	 Catch:{ all -> 0x01fe }
        r0 = r43;
        r0.println(r4);	 Catch:{ all -> 0x01fe }
        goto L_0x01bb;
    L_0x01fe:
        r4 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x01fe }
        throw r4;
    L_0x0201:
        monitor-exit(r5);	 Catch:{ all -> 0x01fe }
    L_0x0202:
        r0 = r41;
        r4 = r0.mForegroundProcesses;
        r4 = r4.size();
        if (r4 <= 0) goto L_0x0290;
    L_0x020c:
        r0 = r41;
        r5 = r0.mPidsSelfLocked;
        monitor-enter(r5);
        r32 = 0;
        r16 = 0;
    L_0x0215:
        r0 = r41;
        r4 = r0.mForegroundProcesses;	 Catch:{ all -> 0x028c }
        r4 = r4.size();	 Catch:{ all -> 0x028c }
        r0 = r16;
        if (r0 >= r4) goto L_0x028f;
    L_0x0221:
        r0 = r41;
        r6 = r0.mPidsSelfLocked;	 Catch:{ all -> 0x028c }
        r0 = r41;
        r4 = r0.mForegroundProcesses;	 Catch:{ all -> 0x028c }
        r0 = r16;
        r4 = r4.valueAt(r0);	 Catch:{ all -> 0x028c }
        r4 = (com.android.server.am.ActivityManagerService.ForegroundToken) r4;	 Catch:{ all -> 0x028c }
        r4 = r4.pid;	 Catch:{ all -> 0x028c }
        r36 = r6.get(r4);	 Catch:{ all -> 0x028c }
        r36 = (com.android.server.am.ProcessRecord) r36;	 Catch:{ all -> 0x028c }
        if (r47 == 0) goto L_0x024c;
    L_0x023b:
        if (r36 == 0) goto L_0x0249;
    L_0x023d:
        r0 = r36;
        r4 = r0.pkgList;	 Catch:{ all -> 0x028c }
        r0 = r47;
        r4 = r4.containsKey(r0);	 Catch:{ all -> 0x028c }
        if (r4 != 0) goto L_0x024c;
    L_0x0249:
        r16 = r16 + 1;
        goto L_0x0215;
    L_0x024c:
        if (r32 != 0) goto L_0x025f;
    L_0x024e:
        if (r9 == 0) goto L_0x0253;
    L_0x0250:
        r43.println();	 Catch:{ all -> 0x028c }
    L_0x0253:
        r9 = 1;
        r4 = "  Foreground Processes:";
        r0 = r43;
        r0.println(r4);	 Catch:{ all -> 0x028c }
        r32 = 1;
        r33 = 1;
    L_0x025f:
        r4 = "    PID #";
        r0 = r43;
        r0.print(r4);	 Catch:{ all -> 0x028c }
        r0 = r41;
        r4 = r0.mForegroundProcesses;	 Catch:{ all -> 0x028c }
        r0 = r16;
        r4 = r4.keyAt(r0);	 Catch:{ all -> 0x028c }
        r0 = r43;
        r0.print(r4);	 Catch:{ all -> 0x028c }
        r4 = ": ";
        r0 = r43;
        r0.print(r4);	 Catch:{ all -> 0x028c }
        r0 = r41;
        r4 = r0.mForegroundProcesses;	 Catch:{ all -> 0x028c }
        r0 = r16;
        r4 = r4.valueAt(r0);	 Catch:{ all -> 0x028c }
        r0 = r43;
        r0.println(r4);	 Catch:{ all -> 0x028c }
        goto L_0x0249;
    L_0x028c:
        r4 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x028c }
        throw r4;
    L_0x028f:
        monitor-exit(r5);	 Catch:{ all -> 0x028c }
    L_0x0290:
        r0 = r41;
        r4 = r0.mPersistentStartingProcesses;
        r4 = r4.size();
        if (r4 <= 0) goto L_0x02bf;
    L_0x029a:
        if (r9 == 0) goto L_0x029f;
    L_0x029c:
        r43.println();
    L_0x029f:
        r23 = 1;
        r33 = 1;
        r4 = "  Persisent processes that are starting:";
        r0 = r43;
        r0.println(r4);
        r0 = r41;
        r6 = r0.mPersistentStartingProcesses;
        r7 = "    ";
        r8 = "Starting Norm";
        r9 = "Restarting PERS";
        r4 = r43;
        r5 = r41;
        r10 = r47;
        dumpProcessList(r4, r5, r6, r7, r8, r9, r10);
        r9 = r23;
    L_0x02bf:
        r0 = r41;
        r4 = r0.mRemovedProcesses;
        r4 = r4.size();
        if (r4 <= 0) goto L_0x02ee;
    L_0x02c9:
        if (r9 == 0) goto L_0x02ce;
    L_0x02cb:
        r43.println();
    L_0x02ce:
        r23 = 1;
        r33 = 1;
        r4 = "  Processes that are being removed:";
        r0 = r43;
        r0.println(r4);
        r0 = r41;
        r6 = r0.mRemovedProcesses;
        r7 = "    ";
        r8 = "Removed Norm";
        r9 = "Removed PERS";
        r4 = r43;
        r5 = r41;
        r10 = r47;
        dumpProcessList(r4, r5, r6, r7, r8, r9, r10);
        r9 = r23;
    L_0x02ee:
        r0 = r41;
        r4 = r0.mProcessesOnHold;
        r4 = r4.size();
        if (r4 <= 0) goto L_0x031d;
    L_0x02f8:
        if (r9 == 0) goto L_0x02fd;
    L_0x02fa:
        r43.println();
    L_0x02fd:
        r23 = 1;
        r33 = 1;
        r4 = "  Processes that are on old until the system is ready:";
        r0 = r43;
        r0.println(r4);
        r0 = r41;
        r6 = r0.mProcessesOnHold;
        r7 = "    ";
        r8 = "OnHold Norm";
        r9 = "OnHold PERS";
        r4 = r43;
        r5 = r41;
        r10 = r47;
        dumpProcessList(r4, r5, r6, r7, r8, r9, r10);
        r9 = r23;
    L_0x031d:
        r4 = r41;
        r5 = r42;
        r6 = r43;
        r7 = r44;
        r8 = r45;
        r10 = r46;
        r11 = r47;
        r9 = r4.dumpProcessesToGc(r5, r6, r7, r8, r9, r10, r11);
        r0 = r41;
        r4 = r0.mProcessCrashTimes;
        r4 = r4.getMap();
        r4 = r4.size();
        if (r4 <= 0) goto L_0x03f3;
    L_0x033d:
        r32 = 0;
        r24 = android.os.SystemClock.uptimeMillis();
        r0 = r41;
        r4 = r0.mProcessCrashTimes;
        r29 = r4.getMap();
        r14 = r29.size();
        r20 = 0;
    L_0x0351:
        r0 = r20;
        if (r0 >= r14) goto L_0x03f3;
    L_0x0355:
        r0 = r29;
        r1 = r20;
        r30 = r0.keyAt(r1);
        r30 = (java.lang.String) r30;
        r0 = r29;
        r1 = r20;
        r39 = r0.valueAt(r1);
        r39 = (android.util.SparseArray) r39;
        r12 = r39.size();
        r16 = 0;
    L_0x036f:
        r0 = r16;
        if (r0 >= r12) goto L_0x03ef;
    L_0x0373:
        r0 = r39;
        r1 = r16;
        r35 = r0.keyAt(r1);
        r0 = r41;
        r4 = r0.mProcessNames;
        r0 = r30;
        r1 = r35;
        r36 = r4.get(r0, r1);
        r36 = (com.android.server.am.ProcessRecord) r36;
        if (r47 == 0) goto L_0x039c;
    L_0x038b:
        if (r36 == 0) goto L_0x0399;
    L_0x038d:
        r0 = r36;
        r4 = r0.pkgList;
        r0 = r47;
        r4 = r4.containsKey(r0);
        if (r4 != 0) goto L_0x039c;
    L_0x0399:
        r16 = r16 + 1;
        goto L_0x036f;
    L_0x039c:
        if (r32 != 0) goto L_0x03af;
    L_0x039e:
        if (r9 == 0) goto L_0x03a3;
    L_0x03a0:
        r43.println();
    L_0x03a3:
        r9 = 1;
        r4 = "  Time since processes crashed:";
        r0 = r43;
        r0.println(r4);
        r32 = 1;
        r33 = 1;
    L_0x03af:
        r4 = "    Process ";
        r0 = r43;
        r0.print(r4);
        r0 = r43;
        r1 = r30;
        r0.print(r1);
        r4 = " uid ";
        r0 = r43;
        r0.print(r4);
        r0 = r43;
        r1 = r35;
        r0.print(r1);
        r4 = ": last crashed ";
        r0 = r43;
        r0.print(r4);
        r0 = r39;
        r1 = r16;
        r4 = r0.valueAt(r1);
        r4 = (java.lang.Long) r4;
        r4 = r4.longValue();
        r4 = r24 - r4;
        r0 = r43;
        android.util.TimeUtils.formatDuration(r4, r0);
        r4 = " ago";
        r0 = r43;
        r0.println(r4);
        goto L_0x0399;
    L_0x03ef:
        r20 = r20 + 1;
        goto L_0x0351;
    L_0x03f3:
        r0 = r41;
        r4 = r0.mBadProcesses;
        r4 = r4.getMap();
        r4 = r4.size();
        if (r4 <= 0) goto L_0x0547;
    L_0x0401:
        r32 = 0;
        r0 = r41;
        r4 = r0.mBadProcesses;
        r28 = r4.getMap();
        r14 = r28.size();
        r20 = 0;
    L_0x0411:
        r0 = r20;
        if (r0 >= r14) goto L_0x0547;
    L_0x0415:
        r0 = r28;
        r1 = r20;
        r30 = r0.keyAt(r1);
        r30 = (java.lang.String) r30;
        r0 = r28;
        r1 = r20;
        r38 = r0.valueAt(r1);
        r38 = (android.util.SparseArray) r38;
        r12 = r38.size();
        r16 = 0;
    L_0x042f:
        r0 = r16;
        if (r0 >= r12) goto L_0x0543;
    L_0x0433:
        r0 = r38;
        r1 = r16;
        r35 = r0.keyAt(r1);
        r0 = r41;
        r4 = r0.mProcessNames;
        r0 = r30;
        r1 = r35;
        r36 = r4.get(r0, r1);
        r36 = (com.android.server.am.ProcessRecord) r36;
        if (r47 == 0) goto L_0x045c;
    L_0x044b:
        if (r36 == 0) goto L_0x0459;
    L_0x044d:
        r0 = r36;
        r4 = r0.pkgList;
        r0 = r47;
        r4 = r4.containsKey(r0);
        if (r4 != 0) goto L_0x045c;
    L_0x0459:
        r16 = r16 + 1;
        goto L_0x042f;
    L_0x045c:
        if (r32 != 0) goto L_0x046d;
    L_0x045e:
        if (r9 == 0) goto L_0x0463;
    L_0x0460:
        r43.println();
    L_0x0463:
        r9 = 1;
        r4 = "  Bad processes:";
        r0 = r43;
        r0.println(r4);
        r33 = 1;
    L_0x046d:
        r0 = r38;
        r1 = r16;
        r19 = r0.valueAt(r1);
        r19 = (com.android.server.am.ActivityManagerService.BadProcessInfo) r19;
        r4 = "    Bad process ";
        r0 = r43;
        r0.print(r4);
        r0 = r43;
        r1 = r30;
        r0.print(r1);
        r4 = " uid ";
        r0 = r43;
        r0.print(r4);
        r0 = r43;
        r1 = r35;
        r0.print(r1);
        r4 = ": crashed at time ";
        r0 = r43;
        r0.print(r4);
        r0 = r19;
        r4 = r0.time;
        r0 = r43;
        r0.println(r4);
        r0 = r19;
        r4 = r0.shortMsg;
        if (r4 == 0) goto L_0x04b9;
    L_0x04a9:
        r4 = "      Short msg: ";
        r0 = r43;
        r0.print(r4);
        r0 = r19;
        r4 = r0.shortMsg;
        r0 = r43;
        r0.println(r4);
    L_0x04b9:
        r0 = r19;
        r4 = r0.longMsg;
        if (r4 == 0) goto L_0x04cf;
    L_0x04bf:
        r4 = "      Long msg: ";
        r0 = r43;
        r0.print(r4);
        r0 = r19;
        r4 = r0.longMsg;
        r0 = r43;
        r0.println(r4);
    L_0x04cf:
        r0 = r19;
        r4 = r0.stack;
        if (r4 == 0) goto L_0x0459;
    L_0x04d5:
        r4 = "      Stack:";
        r0 = r43;
        r0.println(r4);
        r21 = 0;
        r31 = 0;
    L_0x04e0:
        r0 = r19;
        r4 = r0.stack;
        r4 = r4.length();
        r0 = r31;
        if (r0 >= r4) goto L_0x0516;
    L_0x04ec:
        r0 = r19;
        r4 = r0.stack;
        r0 = r31;
        r4 = r4.charAt(r0);
        r5 = 10;
        if (r4 != r5) goto L_0x0513;
    L_0x04fa:
        r4 = "        ";
        r0 = r43;
        r0.print(r4);
        r0 = r19;
        r4 = r0.stack;
        r5 = r31 - r21;
        r0 = r43;
        r1 = r21;
        r0.write(r4, r1, r5);
        r43.println();
        r21 = r31 + 1;
    L_0x0513:
        r31 = r31 + 1;
        goto L_0x04e0;
    L_0x0516:
        r0 = r19;
        r4 = r0.stack;
        r4 = r4.length();
        r0 = r21;
        if (r0 >= r4) goto L_0x0459;
    L_0x0522:
        r4 = "        ";
        r0 = r43;
        r0.print(r4);
        r0 = r19;
        r4 = r0.stack;
        r0 = r19;
        r5 = r0.stack;
        r5 = r5.length();
        r5 = r5 - r21;
        r0 = r43;
        r1 = r21;
        r0.write(r4, r1, r5);
        r43.println();
        goto L_0x0459;
    L_0x0543:
        r20 = r20 + 1;
        goto L_0x0411;
    L_0x0547:
        if (r47 != 0) goto L_0x0666;
    L_0x0549:
        r43.println();
        r9 = 0;
        r4 = "  mStartedUsers:";
        r0 = r43;
        r0.println(r4);
        r16 = 0;
    L_0x0556:
        r0 = r41;
        r4 = r0.mStartedUsers;
        r4 = r4.size();
        r0 = r16;
        if (r0 >= r4) goto L_0x0595;
    L_0x0562:
        r0 = r41;
        r4 = r0.mStartedUsers;
        r0 = r16;
        r40 = r4.valueAt(r0);
        r40 = (com.android.server.am.UserStartedState) r40;
        r4 = "    User #";
        r0 = r43;
        r0.print(r4);
        r0 = r40;
        r4 = r0.mHandle;
        r4 = r4.getIdentifier();
        r0 = r43;
        r0.print(r4);
        r4 = ": ";
        r0 = r43;
        r0.print(r4);
        r4 = "";
        r0 = r40;
        r1 = r43;
        r0.dump(r4, r1);
        r16 = r16 + 1;
        goto L_0x0556;
    L_0x0595:
        r4 = "  mStartedUserArray: [";
        r0 = r43;
        r0.print(r4);
        r16 = 0;
    L_0x059e:
        r0 = r41;
        r4 = r0.mStartedUserArray;
        r4 = r4.length;
        r0 = r16;
        if (r0 >= r4) goto L_0x05be;
    L_0x05a7:
        if (r16 <= 0) goto L_0x05b0;
    L_0x05a9:
        r4 = ", ";
        r0 = r43;
        r0.print(r4);
    L_0x05b0:
        r0 = r41;
        r4 = r0.mStartedUserArray;
        r4 = r4[r16];
        r0 = r43;
        r0.print(r4);
        r16 = r16 + 1;
        goto L_0x059e;
    L_0x05be:
        r4 = "]";
        r0 = r43;
        r0.println(r4);
        r4 = "  mUserLru: [";
        r0 = r43;
        r0.print(r4);
        r16 = 0;
    L_0x05ce:
        r0 = r41;
        r4 = r0.mUserLru;
        r4 = r4.size();
        r0 = r16;
        if (r0 >= r4) goto L_0x05f5;
    L_0x05da:
        if (r16 <= 0) goto L_0x05e3;
    L_0x05dc:
        r4 = ", ";
        r0 = r43;
        r0.print(r4);
    L_0x05e3:
        r0 = r41;
        r4 = r0.mUserLru;
        r0 = r16;
        r4 = r4.get(r0);
        r0 = r43;
        r0.print(r4);
        r16 = r16 + 1;
        goto L_0x05ce;
    L_0x05f5:
        r4 = "]";
        r0 = r43;
        r0.println(r4);
        if (r46 == 0) goto L_0x0612;
    L_0x05fe:
        r4 = "  mStartedUserArray: ";
        r0 = r43;
        r0.print(r4);
        r0 = r41;
        r4 = r0.mStartedUserArray;
        r4 = java.util.Arrays.toString(r4);
        r0 = r43;
        r0.println(r4);
    L_0x0612:
        r0 = r41;
        r5 = r0.mUserProfileGroupIdsSelfLocked;
        monitor-enter(r5);
        r0 = r41;
        r4 = r0.mUserProfileGroupIdsSelfLocked;	 Catch:{ all -> 0x07e1 }
        r4 = r4.size();	 Catch:{ all -> 0x07e1 }
        if (r4 <= 0) goto L_0x0665;
    L_0x0621:
        r4 = "  mUserProfileGroupIds:";
        r0 = r43;
        r0.println(r4);	 Catch:{ all -> 0x07e1 }
        r16 = 0;
    L_0x062a:
        r0 = r41;
        r4 = r0.mUserProfileGroupIdsSelfLocked;	 Catch:{ all -> 0x07e1 }
        r4 = r4.size();	 Catch:{ all -> 0x07e1 }
        r0 = r16;
        if (r0 >= r4) goto L_0x0665;
    L_0x0636:
        r4 = "    User #";
        r0 = r43;
        r0.print(r4);	 Catch:{ all -> 0x07e1 }
        r0 = r41;
        r4 = r0.mUserProfileGroupIdsSelfLocked;	 Catch:{ all -> 0x07e1 }
        r0 = r16;
        r4 = r4.keyAt(r0);	 Catch:{ all -> 0x07e1 }
        r0 = r43;
        r0.print(r4);	 Catch:{ all -> 0x07e1 }
        r4 = " -> profile #";
        r0 = r43;
        r0.print(r4);	 Catch:{ all -> 0x07e1 }
        r0 = r41;
        r4 = r0.mUserProfileGroupIdsSelfLocked;	 Catch:{ all -> 0x07e1 }
        r0 = r16;
        r4 = r4.valueAt(r0);	 Catch:{ all -> 0x07e1 }
        r0 = r43;
        r0.println(r4);	 Catch:{ all -> 0x07e1 }
        r16 = r16 + 1;
        goto L_0x062a;
    L_0x0665:
        monitor-exit(r5);	 Catch:{ all -> 0x07e1 }
    L_0x0666:
        r0 = r41;
        r4 = r0.mHomeProcess;
        if (r4 == 0) goto L_0x069e;
    L_0x066c:
        if (r47 == 0) goto L_0x067c;
    L_0x066e:
        r0 = r41;
        r4 = r0.mHomeProcess;
        r4 = r4.pkgList;
        r0 = r47;
        r4 = r4.containsKey(r0);
        if (r4 == 0) goto L_0x069e;
    L_0x067c:
        if (r9 == 0) goto L_0x0682;
    L_0x067e:
        r43.println();
        r9 = 0;
    L_0x0682:
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "  mHomeProcess: ";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mHomeProcess;
        r4 = r4.append(r5);
        r4 = r4.toString();
        r0 = r43;
        r0.println(r4);
    L_0x069e:
        r0 = r41;
        r4 = r0.mPreviousProcess;
        if (r4 == 0) goto L_0x06d6;
    L_0x06a4:
        if (r47 == 0) goto L_0x06b4;
    L_0x06a6:
        r0 = r41;
        r4 = r0.mPreviousProcess;
        r4 = r4.pkgList;
        r0 = r47;
        r4 = r4.containsKey(r0);
        if (r4 == 0) goto L_0x06d6;
    L_0x06b4:
        if (r9 == 0) goto L_0x06ba;
    L_0x06b6:
        r43.println();
        r9 = 0;
    L_0x06ba:
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "  mPreviousProcess: ";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mPreviousProcess;
        r4 = r4.append(r5);
        r4 = r4.toString();
        r0 = r43;
        r0.println(r4);
    L_0x06d6:
        if (r46 == 0) goto L_0x06f8;
    L_0x06d8:
        r37 = new java.lang.StringBuilder;
        r4 = 128; // 0x80 float:1.794E-43 double:6.32E-322;
        r0 = r37;
        r0.<init>(r4);
        r4 = "  mPreviousProcessVisibleTime: ";
        r0 = r37;
        r0.append(r4);
        r0 = r41;
        r4 = r0.mPreviousProcessVisibleTime;
        r0 = r37;
        android.util.TimeUtils.formatDuration(r4, r0);
        r0 = r43;
        r1 = r37;
        r0.println(r1);
    L_0x06f8:
        r0 = r41;
        r4 = r0.mHeavyWeightProcess;
        if (r4 == 0) goto L_0x0730;
    L_0x06fe:
        if (r47 == 0) goto L_0x070e;
    L_0x0700:
        r0 = r41;
        r4 = r0.mHeavyWeightProcess;
        r4 = r4.pkgList;
        r0 = r47;
        r4 = r4.containsKey(r0);
        if (r4 == 0) goto L_0x0730;
    L_0x070e:
        if (r9 == 0) goto L_0x0714;
    L_0x0710:
        r43.println();
        r9 = 0;
    L_0x0714:
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "  mHeavyWeightProcess: ";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mHeavyWeightProcess;
        r4 = r4.append(r5);
        r4 = r4.toString();
        r0 = r43;
        r0.println(r4);
    L_0x0730:
        if (r47 != 0) goto L_0x074e;
    L_0x0732:
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "  mConfiguration: ";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mConfiguration;
        r4 = r4.append(r5);
        r4 = r4.toString();
        r0 = r43;
        r0.println(r4);
    L_0x074e:
        if (r46 == 0) goto L_0x07e4;
    L_0x0750:
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "  mConfigWillChange: ";
        r4 = r4.append(r5);
        r5 = r41.getFocusedStack();
        r5 = r5.mConfigWillChange;
        r4 = r4.append(r5);
        r4 = r4.toString();
        r0 = r43;
        r0.println(r4);
        r0 = r41;
        r4 = r0.mCompatModePackages;
        r4 = r4.getPackages();
        r4 = r4.size();
        if (r4 <= 0) goto L_0x07e4;
    L_0x077c:
        r32 = 0;
        r0 = r41;
        r4 = r0.mCompatModePackages;
        r4 = r4.getPackages();
        r4 = r4.entrySet();
        r17 = r4.iterator();
    L_0x078e:
        r4 = r17.hasNext();
        if (r4 == 0) goto L_0x07e4;
    L_0x0794:
        r15 = r17.next();
        r15 = (java.util.Map.Entry) r15;
        r27 = r15.getKey();
        r27 = (java.lang.String) r27;
        r4 = r15.getValue();
        r4 = (java.lang.Integer) r4;
        r22 = r4.intValue();
        if (r47 == 0) goto L_0x07b6;
    L_0x07ac:
        r0 = r47;
        r1 = r27;
        r4 = r0.equals(r1);
        if (r4 == 0) goto L_0x078e;
    L_0x07b6:
        if (r32 != 0) goto L_0x07c1;
    L_0x07b8:
        r4 = "  mScreenCompatPackages:";
        r0 = r43;
        r0.println(r4);
        r32 = 1;
    L_0x07c1:
        r4 = "    ";
        r0 = r43;
        r0.print(r4);
        r0 = r43;
        r1 = r27;
        r0.print(r1);
        r4 = ": ";
        r0 = r43;
        r0.print(r4);
        r0 = r43;
        r1 = r22;
        r0.print(r1);
        r43.println();
        goto L_0x078e;
    L_0x07e1:
        r4 = move-exception;
        monitor-exit(r5);	 Catch:{ all -> 0x07e1 }
        throw r4;
    L_0x07e4:
        if (r47 != 0) goto L_0x0868;
    L_0x07e6:
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "  mWakefulness=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mWakefulness;
        r5 = android.os.PowerManagerInternal.wakefulnessToString(r5);
        r4 = r4.append(r5);
        r4 = r4.toString();
        r0 = r43;
        r0.println(r4);
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "  mSleeping=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mSleeping;
        r4 = r4.append(r5);
        r5 = " mLockScreenShown=";
        r4 = r4.append(r5);
        r5 = r41.lockScreenShownToString();
        r4 = r4.append(r5);
        r4 = r4.toString();
        r0 = r43;
        r0.println(r4);
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "  mShuttingDown=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mShuttingDown;
        r4 = r4.append(r5);
        r5 = " mRunningVoice=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mRunningVoice;
        r4 = r4.append(r5);
        r5 = " mTestPssMode=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mTestPssMode;
        r4 = r4.append(r5);
        r4 = r4.toString();
        r0 = r43;
        r0.println(r4);
    L_0x0868:
        r0 = r41;
        r4 = r0.mDebugApp;
        if (r4 != 0) goto L_0x0880;
    L_0x086e:
        r0 = r41;
        r4 = r0.mOrigDebugApp;
        if (r4 != 0) goto L_0x0880;
    L_0x0874:
        r0 = r41;
        r4 = r0.mDebugTransient;
        if (r4 != 0) goto L_0x0880;
    L_0x087a:
        r0 = r41;
        r4 = r0.mOrigWaitForDebugger;
        if (r4 == 0) goto L_0x08e6;
    L_0x0880:
        if (r47 == 0) goto L_0x089a;
    L_0x0882:
        r0 = r41;
        r4 = r0.mDebugApp;
        r0 = r47;
        r4 = r0.equals(r4);
        if (r4 != 0) goto L_0x089a;
    L_0x088e:
        r0 = r41;
        r4 = r0.mOrigDebugApp;
        r0 = r47;
        r4 = r0.equals(r4);
        if (r4 == 0) goto L_0x08e6;
    L_0x089a:
        if (r9 == 0) goto L_0x08a0;
    L_0x089c:
        r43.println();
        r9 = 0;
    L_0x08a0:
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "  mDebugApp=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mDebugApp;
        r4 = r4.append(r5);
        r5 = "/orig=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mOrigDebugApp;
        r4 = r4.append(r5);
        r5 = " mDebugTransient=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mDebugTransient;
        r4 = r4.append(r5);
        r5 = " mOrigWaitForDebugger=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mOrigWaitForDebugger;
        r4 = r4.append(r5);
        r4 = r4.toString();
        r0 = r43;
        r0.println(r4);
    L_0x08e6:
        r0 = r41;
        r4 = r0.mOpenGlTraceApp;
        if (r4 == 0) goto L_0x091c;
    L_0x08ec:
        if (r47 == 0) goto L_0x08fa;
    L_0x08ee:
        r0 = r41;
        r4 = r0.mOpenGlTraceApp;
        r0 = r47;
        r4 = r0.equals(r4);
        if (r4 == 0) goto L_0x091c;
    L_0x08fa:
        if (r9 == 0) goto L_0x0900;
    L_0x08fc:
        r43.println();
        r9 = 0;
    L_0x0900:
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "  mOpenGlTraceApp=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mOpenGlTraceApp;
        r4 = r4.append(r5);
        r4 = r4.toString();
        r0 = r43;
        r0.println(r4);
    L_0x091c:
        r0 = r41;
        r4 = r0.mProfileApp;
        if (r4 != 0) goto L_0x0934;
    L_0x0922:
        r0 = r41;
        r4 = r0.mProfileProc;
        if (r4 != 0) goto L_0x0934;
    L_0x0928:
        r0 = r41;
        r4 = r0.mProfileFile;
        if (r4 != 0) goto L_0x0934;
    L_0x092e:
        r0 = r41;
        r4 = r0.mProfileFd;
        if (r4 == 0) goto L_0x09e2;
    L_0x0934:
        if (r47 == 0) goto L_0x0942;
    L_0x0936:
        r0 = r41;
        r4 = r0.mProfileApp;
        r0 = r47;
        r4 = r0.equals(r4);
        if (r4 == 0) goto L_0x09e2;
    L_0x0942:
        if (r9 == 0) goto L_0x0948;
    L_0x0944:
        r43.println();
        r9 = 0;
    L_0x0948:
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "  mProfileApp=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mProfileApp;
        r4 = r4.append(r5);
        r5 = " mProfileProc=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mProfileProc;
        r4 = r4.append(r5);
        r4 = r4.toString();
        r0 = r43;
        r0.println(r4);
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "  mProfileFile=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mProfileFile;
        r4 = r4.append(r5);
        r5 = " mProfileFd=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mProfileFd;
        r4 = r4.append(r5);
        r4 = r4.toString();
        r0 = r43;
        r0.println(r4);
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "  mSamplingInterval=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mSamplingInterval;
        r4 = r4.append(r5);
        r5 = " mAutoStopProfiler=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mAutoStopProfiler;
        r4 = r4.append(r5);
        r4 = r4.toString();
        r0 = r43;
        r0.println(r4);
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "  mProfileType=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mProfileType;
        r4 = r4.append(r5);
        r4 = r4.toString();
        r0 = r43;
        r0.println(r4);
    L_0x09e2:
        if (r47 != 0) goto L_0x0c0b;
    L_0x09e4:
        r0 = r41;
        r4 = r0.mAlwaysFinishActivities;
        if (r4 != 0) goto L_0x09f0;
    L_0x09ea:
        r0 = r41;
        r4 = r0.mController;
        if (r4 == 0) goto L_0x0a1a;
    L_0x09f0:
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "  mAlwaysFinishActivities=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mAlwaysFinishActivities;
        r4 = r4.append(r5);
        r5 = " mController=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mController;
        r4 = r4.append(r5);
        r4 = r4.toString();
        r0 = r43;
        r0.println(r4);
    L_0x0a1a:
        if (r46 == 0) goto L_0x0c0b;
    L_0x0a1c:
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "  Total persistent processes: ";
        r4 = r4.append(r5);
        r0 = r26;
        r4 = r4.append(r0);
        r4 = r4.toString();
        r0 = r43;
        r0.println(r4);
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "  mProcessesReady=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mProcessesReady;
        r4 = r4.append(r5);
        r5 = " mSystemReady=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mSystemReady;
        r4 = r4.append(r5);
        r5 = " mBooted=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mBooted;
        r4 = r4.append(r5);
        r5 = " mFactoryTest=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mFactoryTest;
        r4 = r4.append(r5);
        r4 = r4.toString();
        r0 = r43;
        r0.println(r4);
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "  mBooting=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mBooting;
        r4 = r4.append(r5);
        r5 = " mCallFinishBooting=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mCallFinishBooting;
        r4 = r4.append(r5);
        r5 = " mBootAnimationComplete=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mBootAnimationComplete;
        r4 = r4.append(r5);
        r4 = r4.toString();
        r0 = r43;
        r0.println(r4);
        r4 = "  mLastPowerCheckRealtime=";
        r0 = r43;
        r0.print(r4);
        r0 = r41;
        r4 = r0.mLastPowerCheckRealtime;
        r0 = r43;
        android.util.TimeUtils.formatDuration(r4, r0);
        r4 = "";
        r0 = r43;
        r0.println(r4);
        r4 = "  mLastPowerCheckUptime=";
        r0 = r43;
        r0.print(r4);
        r0 = r41;
        r4 = r0.mLastPowerCheckUptime;
        r0 = r43;
        android.util.TimeUtils.formatDuration(r4, r0);
        r4 = "";
        r0 = r43;
        r0.println(r4);
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "  mGoingToSleep=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mStackSupervisor;
        r5 = r5.mGoingToSleep;
        r4 = r4.append(r5);
        r4 = r4.toString();
        r0 = r43;
        r0.println(r4);
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "  mLaunchingActivity=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mStackSupervisor;
        r5 = r5.mLaunchingActivity;
        r4 = r4.append(r5);
        r4 = r4.toString();
        r0 = r43;
        r0.println(r4);
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "  mAdjSeq=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mAdjSeq;
        r4 = r4.append(r5);
        r5 = " mLruSeq=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mLruSeq;
        r4 = r4.append(r5);
        r4 = r4.toString();
        r0 = r43;
        r0.println(r4);
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "  mNumNonCachedProcs=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mNumNonCachedProcs;
        r4 = r4.append(r5);
        r5 = " (";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mLruProcesses;
        r5 = r5.size();
        r4 = r4.append(r5);
        r5 = " total)";
        r4 = r4.append(r5);
        r5 = " mNumCachedHiddenProcs=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mNumCachedHiddenProcs;
        r4 = r4.append(r5);
        r5 = " mNumServiceProcs=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mNumServiceProcs;
        r4 = r4.append(r5);
        r5 = " mNewNumServiceProcs=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mNewNumServiceProcs;
        r4 = r4.append(r5);
        r4 = r4.toString();
        r0 = r43;
        r0.println(r4);
        r4 = new java.lang.StringBuilder;
        r4.<init>();
        r5 = "  mAllowLowerMemLevel=";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mAllowLowerMemLevel;
        r4 = r4.append(r5);
        r5 = " mLastMemoryLevel";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mLastMemoryLevel;
        r4 = r4.append(r5);
        r5 = " mLastNumProcesses";
        r4 = r4.append(r5);
        r0 = r41;
        r5 = r0.mLastNumProcesses;
        r4 = r4.append(r5);
        r4 = r4.toString();
        r0 = r43;
        r0.println(r4);
        r24 = android.os.SystemClock.uptimeMillis();
        r4 = "  mLastIdleTime=";
        r0 = r43;
        r0.print(r4);
        r0 = r41;
        r4 = r0.mLastIdleTime;
        r0 = r24;
        r2 = r43;
        android.util.TimeUtils.formatDuration(r0, r4, r2);
        r4 = " mLowRamSinceLastIdle=";
        r0 = r43;
        r0.print(r4);
        r0 = r41;
        r1 = r24;
        r4 = r0.getLowRamTimeSinceIdle(r1);
        r0 = r43;
        android.util.TimeUtils.formatDuration(r4, r0);
        r43.println();
    L_0x0c0b:
        if (r33 != 0) goto L_0x0c14;
    L_0x0c0d:
        r4 = "  (nothing)";
        r0 = r43;
        r0.println(r4);
    L_0x0c14:
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.ActivityManagerService.dumpProcessesLocked(java.io.FileDescriptor, java.io.PrintWriter, java.lang.String[], int, boolean, java.lang.String):void");
    }

    boolean dumpProcessesToGc(FileDescriptor fd, PrintWriter pw, String[] args, int opti, boolean needSep, boolean dumpAll, String dumpPackage) {
        if (this.mProcessesToGc.size() > 0) {
            boolean printed = VALIDATE_TOKENS;
            long now = SystemClock.uptimeMillis();
            for (int i = MY_PID; i < this.mProcessesToGc.size(); i += SHOW_ERROR_MSG) {
                ProcessRecord proc = (ProcessRecord) this.mProcessesToGc.get(i);
                if (dumpPackage == null || dumpPackage.equals(proc.info.packageName)) {
                    if (!printed) {
                        if (needSep) {
                            pw.println();
                        }
                        needSep = SHOW_ACTIVITY_START_TIME;
                        pw.println("  Processes that are waiting to GC:");
                        printed = SHOW_ACTIVITY_START_TIME;
                    }
                    pw.print("    Process ");
                    pw.println(proc);
                    pw.print("      lowMem=");
                    pw.print(proc.reportLowMemory);
                    pw.print(", last gced=");
                    pw.print(now - proc.lastRequestedGc);
                    pw.print(" ms ago, last lowMem=");
                    pw.print(now - proc.lastLowMemory);
                    pw.println(" ms ago");
                }
            }
        }
        return needSep;
    }

    void printOomLevel(PrintWriter pw, String name, int adj) {
        pw.print("    ");
        if (adj >= 0) {
            pw.print(' ');
            if (adj < 10) {
                pw.print(' ');
            }
        } else if (adj > -10) {
            pw.print(' ');
        }
        pw.print(adj);
        pw.print(": ");
        pw.print(name);
        pw.print(" (");
        pw.print(this.mProcessList.getMemLevel(adj) / 1024);
        pw.println(" kB)");
    }

    boolean dumpOomLocked(FileDescriptor fd, PrintWriter pw, String[] args, int opti, boolean dumpAll) {
        boolean needSep = VALIDATE_TOKENS;
        if (this.mLruProcesses.size() > 0) {
            if (MY_PID != null) {
                pw.println();
            }
            pw.println("  OOM levels:");
            printOomLevel(pw, "SYSTEM_ADJ", -16);
            printOomLevel(pw, "PERSISTENT_PROC_ADJ", -12);
            printOomLevel(pw, "PERSISTENT_SERVICE_ADJ", -11);
            printOomLevel(pw, "FOREGROUND_APP_ADJ", MY_PID);
            printOomLevel(pw, "VISIBLE_APP_ADJ", SHOW_ERROR_MSG);
            printOomLevel(pw, "PERCEPTIBLE_APP_ADJ", SHOW_NOT_RESPONDING_MSG);
            printOomLevel(pw, "BACKUP_APP_ADJ", SHOW_FACTORY_ERROR_MSG);
            printOomLevel(pw, "HEAVY_WEIGHT_APP_ADJ", UPDATE_CONFIGURATION_MSG);
            printOomLevel(pw, "SERVICE_ADJ", GC_BACKGROUND_PROCESSES_MSG);
            printOomLevel(pw, "HOME_APP_ADJ", WAIT_FOR_DEBUGGER_MSG);
            printOomLevel(pw, "PREVIOUS_APP_ADJ", 7);
            printOomLevel(pw, "SERVICE_B_ADJ", 8);
            printOomLevel(pw, "CACHED_APP_MIN_ADJ", 9);
            printOomLevel(pw, "CACHED_APP_MAX_ADJ", SHOW_FINGERPRINT_ERROR_MSG);
            if (SHOW_ACTIVITY_START_TIME) {
                pw.println();
            }
            pw.print("  Process OOM control (");
            pw.print(this.mLruProcesses.size());
            pw.print(" total, non-act at ");
            pw.print(this.mLruProcesses.size() - this.mLruProcessActivityStart);
            pw.print(", non-svc at ");
            pw.print(this.mLruProcesses.size() - this.mLruProcessServiceStart);
            pw.println("):");
            dumpProcessOomList(pw, this, this.mLruProcesses, "    ", "Proc", "PERS", SHOW_ACTIVITY_START_TIME, null);
            needSep = SHOW_ACTIVITY_START_TIME;
        }
        dumpProcessesToGc(fd, pw, args, opti, needSep, dumpAll, null);
        pw.println();
        pw.println("  mHomeProcess: " + this.mHomeProcess);
        pw.println("  mPreviousProcess: " + this.mPreviousProcess);
        if (this.mHeavyWeightProcess != null) {
            pw.println("  mHeavyWeightProcess: " + this.mHeavyWeightProcess);
        }
        return SHOW_ACTIVITY_START_TIME;
    }

    protected boolean dumpProvider(FileDescriptor fd, PrintWriter pw, String name, String[] args, int opti, boolean dumpAll) {
        return this.mProviderMap.dumpProvider(fd, pw, name, args, opti, dumpAll);
    }

    protected boolean dumpActivity(FileDescriptor fd, PrintWriter pw, String name, String[] args, int opti, boolean dumpAll) {
        synchronized (this) {
            ArrayList<ActivityRecord> activities = this.mStackSupervisor.getDumpActivitiesLocked(name);
        }
        if (activities.size() <= 0) {
            return VALIDATE_TOKENS;
        }
        String[] newArgs = new String[(args.length - opti)];
        System.arraycopy(args, opti, newArgs, MY_PID, args.length - opti);
        TaskRecord lastTask = null;
        boolean needSep = VALIDATE_TOKENS;
        for (int i = activities.size() - 1; i >= 0; i--) {
            ActivityRecord r = (ActivityRecord) activities.get(i);
            if (needSep) {
                pw.println();
            }
            needSep = SHOW_ACTIVITY_START_TIME;
            synchronized (this) {
                if (lastTask != r.task) {
                    lastTask = r.task;
                    pw.print("TASK ");
                    pw.print(lastTask.affinity);
                    pw.print(" id=");
                    pw.println(lastTask.taskId);
                    if (dumpAll) {
                        lastTask.dump(pw, "  ");
                    }
                }
            }
            dumpActivity("  ", fd, pw, (ActivityRecord) activities.get(i), newArgs, dumpAll);
        }
        return SHOW_ACTIVITY_START_TIME;
    }

    private void dumpActivity(String prefix, FileDescriptor fd, PrintWriter pw, ActivityRecord r, String[] args, boolean dumpAll) {
        String innerPrefix = prefix + "  ";
        synchronized (this) {
            pw.print(prefix);
            pw.print("ACTIVITY ");
            pw.print(r.shortComponentName);
            pw.print(" ");
            pw.print(Integer.toHexString(System.identityHashCode(r)));
            pw.print(" pid=");
            if (r.app != null) {
                pw.println(r.app.pid);
            } else {
                pw.println("(not running)");
            }
            if (dumpAll) {
                r.dump(pw, innerPrefix);
            }
        }
        if (r.app != null && r.app.thread != null) {
            pw.flush();
            TransferPipe tp;
            try {
                tp = new TransferPipe();
                r.app.thread.dumpActivity(tp.getWriteFd().getFileDescriptor(), r.appToken, innerPrefix, args);
                tp.go(fd);
                tp.kill();
            } catch (IOException e) {
                pw.println(innerPrefix + "Failure while dumping the activity: " + e);
            } catch (RemoteException e2) {
                pw.println(innerPrefix + "Got a RemoteException while dumping the activity");
            } catch (Throwable th) {
                tp.kill();
            }
        }
    }

    void dumpBroadcastsLocked(FileDescriptor fd, PrintWriter pw, String[] args, int opti, boolean dumpAll, String dumpPackage) {
        int i$;
        boolean needSep = VALIDATE_TOKENS;
        boolean onlyHistory = VALIDATE_TOKENS;
        boolean printedAnything = VALIDATE_TOKENS;
        if ("history".equals(dumpPackage)) {
            if (opti < args.length && "-s".equals(args[opti])) {
                dumpAll = VALIDATE_TOKENS;
            }
            onlyHistory = SHOW_ACTIVITY_START_TIME;
            dumpPackage = null;
        }
        pw.println("ACTIVITY MANAGER BROADCAST STATE (dumpsys activity broadcasts)");
        if (!onlyHistory && dumpAll) {
            if (this.mRegisteredReceivers.size() > 0) {
                boolean printed = VALIDATE_TOKENS;
                for (ReceiverList r : this.mRegisteredReceivers.values()) {
                    if (dumpPackage != null) {
                        if (r.app != null) {
                            if (!dumpPackage.equals(r.app.info.packageName)) {
                            }
                        }
                    }
                    if (!printed) {
                        pw.println("  Registered Receivers:");
                        needSep = SHOW_ACTIVITY_START_TIME;
                        printed = SHOW_ACTIVITY_START_TIME;
                        printedAnything = SHOW_ACTIVITY_START_TIME;
                    }
                    pw.print("  * ");
                    pw.println(r);
                    r.dump(pw, "    ");
                }
            }
            if (this.mReceiverResolver.dump(pw, needSep ? "\n  Receiver Resolver Table:" : "  Receiver Resolver Table:", "    ", dumpPackage, VALIDATE_TOKENS, VALIDATE_TOKENS)) {
                needSep = SHOW_ACTIVITY_START_TIME;
                printedAnything = SHOW_ACTIVITY_START_TIME;
            }
        }
        BroadcastQueue[] arr$ = this.mBroadcastQueues;
        int len$ = arr$.length;
        for (i$ = MY_PID; i$ < len$; i$ += SHOW_ERROR_MSG) {
            needSep = arr$[i$].dumpLocked(fd, pw, args, opti, dumpAll, dumpPackage, needSep);
            printedAnything |= needSep;
        }
        needSep = SHOW_ACTIVITY_START_TIME;
        if (!(onlyHistory || this.mStickyBroadcasts == null || dumpPackage != null)) {
            for (int user = MY_PID; user < this.mStickyBroadcasts.size(); user += SHOW_ERROR_MSG) {
                if (needSep) {
                    pw.println();
                }
                needSep = SHOW_ACTIVITY_START_TIME;
                printedAnything = SHOW_ACTIVITY_START_TIME;
                pw.print("  Sticky broadcasts for user ");
                pw.print(this.mStickyBroadcasts.keyAt(user));
                pw.println(":");
                StringBuilder sb = new StringBuilder(MAX_PERSISTED_URI_GRANTS);
                for (Entry<String, ArrayList<Intent>> ent : ((ArrayMap) this.mStickyBroadcasts.valueAt(user)).entrySet()) {
                    pw.print("  * Sticky action ");
                    pw.print((String) ent.getKey());
                    if (dumpAll) {
                        pw.println(":");
                        ArrayList<Intent> intents = (ArrayList) ent.getValue();
                        int N = intents.size();
                        for (int i = MY_PID; i < N; i += SHOW_ERROR_MSG) {
                            sb.setLength(MY_PID);
                            sb.append("    Intent: ");
                            ((Intent) intents.get(i)).toShortString(sb, VALIDATE_TOKENS, SHOW_ACTIVITY_START_TIME, VALIDATE_TOKENS, VALIDATE_TOKENS);
                            pw.println(sb.toString());
                            Bundle bundle = ((Intent) intents.get(i)).getExtras();
                            if (bundle != null) {
                                pw.print("      ");
                                pw.println(bundle.toString());
                            }
                        }
                    } else {
                        pw.println("");
                    }
                }
            }
        }
        if (!onlyHistory && dumpAll) {
            pw.println();
            arr$ = this.mBroadcastQueues;
            len$ = arr$.length;
            for (i$ = MY_PID; i$ < len$; i$ += SHOW_ERROR_MSG) {
                BroadcastQueue queue = arr$[i$];
                pw.println("  mBroadcastsScheduled [" + queue.mQueueName + "]=" + queue.mBroadcastsScheduled);
            }
            pw.println("  mHandler:");
            this.mHandler.dump(new PrintWriterPrinter(pw), "    ");
            printedAnything = SHOW_ACTIVITY_START_TIME;
        }
        if (!printedAnything) {
            pw.println("  (nothing)");
        }
    }

    void dumpProvidersLocked(FileDescriptor fd, PrintWriter pw, String[] args, int opti, boolean dumpAll, String dumpPackage) {
        boolean printed;
        int i;
        new ItemMatcher().build(args, opti);
        pw.println("ACTIVITY MANAGER CONTENT PROVIDERS (dumpsys activity providers)");
        boolean needSep = this.mProviderMap.dumpProvidersLocked(pw, dumpAll, dumpPackage);
        boolean printedAnything = VALIDATE_TOKENS | needSep;
        if (this.mLaunchingProviders.size() > 0) {
            printed = VALIDATE_TOKENS;
            for (i = this.mLaunchingProviders.size() - 1; i >= 0; i--) {
                ContentProviderRecord r = (ContentProviderRecord) this.mLaunchingProviders.get(i);
                if (dumpPackage != null) {
                    if (!dumpPackage.equals(r.name.getPackageName())) {
                    }
                }
                if (!printed) {
                    if (needSep) {
                        pw.println();
                    }
                    needSep = SHOW_ACTIVITY_START_TIME;
                    pw.println("  Launching content providers:");
                    printed = SHOW_ACTIVITY_START_TIME;
                    printedAnything = SHOW_ACTIVITY_START_TIME;
                }
                pw.print("  Launching #");
                pw.print(i);
                pw.print(": ");
                pw.println(r);
            }
        }
        if (this.mGrantedUriPermissions.size() > 0) {
            printed = VALIDATE_TOKENS;
            int dumpUid = -2;
            if (dumpPackage != null) {
                try {
                    dumpUid = this.mContext.getPackageManager().getPackageUid(dumpPackage, MY_PID);
                } catch (NameNotFoundException e) {
                    dumpUid = -1;
                }
            }
            for (i = MY_PID; i < this.mGrantedUriPermissions.size(); i += SHOW_ERROR_MSG) {
                int uid = this.mGrantedUriPermissions.keyAt(i);
                if (dumpUid < -1 || UserHandle.getAppId(uid) == dumpUid) {
                    ArrayMap<GrantUri, UriPermission> perms = (ArrayMap) this.mGrantedUriPermissions.valueAt(i);
                    if (!printed) {
                        if (needSep) {
                            pw.println();
                        }
                        needSep = SHOW_ACTIVITY_START_TIME;
                        pw.println("  Granted Uri Permissions:");
                        printed = SHOW_ACTIVITY_START_TIME;
                        printedAnything = SHOW_ACTIVITY_START_TIME;
                    }
                    pw.print("  * UID ");
                    pw.print(uid);
                    pw.println(" holds:");
                    for (UriPermission perm : perms.values()) {
                        pw.print("    ");
                        pw.println(perm);
                        if (dumpAll) {
                            perm.dump(pw, "      ");
                        }
                    }
                }
            }
        }
        if (!printedAnything) {
            pw.println("  (nothing)");
        }
    }

    void dumpPendingIntentsLocked(FileDescriptor fd, PrintWriter pw, String[] args, int opti, boolean dumpAll, String dumpPackage) {
        boolean printed = VALIDATE_TOKENS;
        pw.println("ACTIVITY MANAGER PENDING INTENTS (dumpsys activity intents)");
        if (this.mIntentSenderRecords.size() > 0) {
            for (WeakReference<PendingIntentRecord> ref : this.mIntentSenderRecords.values()) {
                PendingIntentRecord rec = ref != null ? (PendingIntentRecord) ref.get() : null;
                if (dumpPackage == null || (rec != null && dumpPackage.equals(rec.key.packageName))) {
                    printed = SHOW_ACTIVITY_START_TIME;
                    if (rec != null) {
                        pw.print("  * ");
                        pw.println(rec);
                        if (dumpAll) {
                            rec.dump(pw, "    ");
                        }
                    } else {
                        pw.print("  * ");
                        pw.println(ref);
                    }
                }
            }
        }
        if (!printed) {
            pw.println("  (nothing)");
        }
    }

    private static final int dumpProcessList(PrintWriter pw, ActivityManagerService service, List list, String prefix, String normalLabel, String persistentLabel, String dumpPackage) {
        int numPers = MY_PID;
        for (int i = list.size() - 1; i >= 0; i--) {
            ProcessRecord r = (ProcessRecord) list.get(i);
            if (dumpPackage == null || dumpPackage.equals(r.info.packageName)) {
                Object obj;
                String str = "%s%s #%2d: %s";
                Object[] objArr = new Object[UPDATE_CONFIGURATION_MSG];
                objArr[MY_PID] = prefix;
                if (r.persistent) {
                    obj = persistentLabel;
                } else {
                    String str2 = normalLabel;
                }
                objArr[SHOW_ERROR_MSG] = obj;
                objArr[SHOW_NOT_RESPONDING_MSG] = Integer.valueOf(i);
                objArr[SHOW_FACTORY_ERROR_MSG] = r.toString();
                pw.println(String.format(str, objArr));
                if (r.persistent) {
                    numPers += SHOW_ERROR_MSG;
                }
            }
        }
        return numPers;
    }

    private static final boolean dumpProcessOomList(PrintWriter pw, ActivityManagerService service, List<ProcessRecord> origList, String prefix, String normalLabel, String persistentLabel, boolean inclDetails, String dumpPackage) {
        int i;
        ArrayList<Pair<ProcessRecord, Integer>> list = new ArrayList(origList.size());
        for (i = MY_PID; i < origList.size(); i += SHOW_ERROR_MSG) {
            ProcessRecord r = (ProcessRecord) origList.get(i);
            if (dumpPackage != null) {
                if (!r.pkgList.containsKey(dumpPackage)) {
                }
            }
            list.add(new Pair(origList.get(i), Integer.valueOf(i)));
        }
        if (list.size() <= 0) {
            return VALIDATE_TOKENS;
        }
        Collections.sort(list, new Comparator<Pair<ProcessRecord, Integer>>() {
            public int compare(Pair<ProcessRecord, Integer> object1, Pair<ProcessRecord, Integer> object2) {
                int i = -1;
                if (((ProcessRecord) object1.first).setAdj != ((ProcessRecord) object2.first).setAdj) {
                    return ((ProcessRecord) object1.first).setAdj > ((ProcessRecord) object2.first).setAdj ? -1 : ActivityManagerService.SHOW_ERROR_MSG;
                } else {
                    if (((Integer) object1.second).intValue() == ((Integer) object2.second).intValue()) {
                        return ActivityManagerService.MY_PID;
                    }
                    if (((Integer) object1.second).intValue() <= ((Integer) object2.second).intValue()) {
                        i = ActivityManagerService.SHOW_ERROR_MSG;
                    }
                    return i;
                }
            }
        });
        long curRealtime = SystemClock.elapsedRealtime();
        long realtimeSince = curRealtime - service.mLastPowerCheckRealtime;
        long uptimeSince = SystemClock.uptimeMillis() - service.mLastPowerCheckUptime;
        for (i = list.size() - 1; i >= 0; i--) {
            char schedGroup;
            char foreground;
            String str;
            r = (ProcessRecord) ((Pair) list.get(i)).first;
            String oomAdj = ProcessList.makeOomAdjString(r.setAdj);
            switch (r.setSchedGroup) {
                case AppTransition.TRANSIT_UNSET /*-1*/:
                    schedGroup = 'F';
                    break;
                case MY_PID:
                    schedGroup = 'B';
                    break;
                default:
                    schedGroup = '?';
                    break;
            }
            if (r.foregroundActivities) {
                foreground = 'A';
            } else if (r.foregroundServices) {
                foreground = 'S';
            } else {
                foreground = ' ';
            }
            String procState = ProcessList.makeProcStateString(r.curProcState);
            pw.print(prefix);
            if (r.persistent) {
                str = persistentLabel;
            } else {
                str = normalLabel;
            }
            pw.print(str);
            pw.print(" #");
            int num = (origList.size() - 1) - ((Integer) ((Pair) list.get(i)).second).intValue();
            if (num < 10) {
                pw.print(' ');
            }
            pw.print(num);
            pw.print(": ");
            pw.print(oomAdj);
            pw.print(' ');
            pw.print(schedGroup);
            pw.print('/');
            pw.print(foreground);
            pw.print('/');
            pw.print(procState);
            pw.print(" trm:");
            int i2 = r.trimMemoryLevel;
            if (r0 < 10) {
                pw.print(' ');
            }
            pw.print(r.trimMemoryLevel);
            pw.print(' ');
            pw.print(r.toShortString());
            pw.print(" (");
            pw.print(r.adjType);
            pw.println(')');
            if (!(r.adjSource == null && r.adjTarget == null)) {
                pw.print(prefix);
                pw.print("    ");
                if (r.adjTarget instanceof ComponentName) {
                    pw.print(((ComponentName) r.adjTarget).flattenToShortString());
                } else if (r.adjTarget != null) {
                    pw.print(r.adjTarget.toString());
                } else {
                    pw.print("{null}");
                }
                pw.print("<=");
                if (r.adjSource instanceof ProcessRecord) {
                    pw.print("Proc{");
                    pw.print(((ProcessRecord) r.adjSource).toShortString());
                    pw.println("}");
                } else if (r.adjSource != null) {
                    pw.println(r.adjSource.toString());
                } else {
                    pw.println("{null}");
                }
            }
            if (inclDetails) {
                pw.print(prefix);
                pw.print("    ");
                pw.print("oom: max=");
                pw.print(r.maxAdj);
                pw.print(" curRaw=");
                pw.print(r.curRawAdj);
                pw.print(" setRaw=");
                pw.print(r.setRawAdj);
                pw.print(" cur=");
                pw.print(r.curAdj);
                pw.print(" set=");
                pw.println(r.setAdj);
                pw.print(prefix);
                pw.print("    ");
                pw.print("state: cur=");
                pw.print(ProcessList.makeProcStateString(r.curProcState));
                pw.print(" set=");
                pw.print(ProcessList.makeProcStateString(r.setProcState));
                pw.print(" lastPss=");
                pw.print(r.lastPss);
                pw.print(" lastCachedPss=");
                pw.println(r.lastCachedPss);
                pw.print(prefix);
                pw.print("    ");
                pw.print("cached=");
                pw.print(r.cached);
                pw.print(" empty=");
                pw.print(r.empty);
                pw.print(" hasAboveClient=");
                pw.println(r.hasAboveClient);
                i2 = r.setProcState;
                if (r0 >= 7) {
                    long timeUsed;
                    if (r.lastWakeTime != 0) {
                        long wtime;
                        BatteryStatsImpl stats = service.mBatteryStatsService.getActiveStatistics();
                        synchronized (stats) {
                            wtime = stats.getProcessWakeTime(r.info.uid, r.pid, curRealtime);
                        }
                        timeUsed = wtime - r.lastWakeTime;
                        pw.print(prefix);
                        pw.print("    ");
                        pw.print("keep awake over ");
                        TimeUtils.formatDuration(realtimeSince, pw);
                        pw.print(" used ");
                        TimeUtils.formatDuration(timeUsed, pw);
                        pw.print(" (");
                        pw.print((100 * timeUsed) / realtimeSince);
                        pw.println("%)");
                    }
                    if (r.lastCpuTime != 0) {
                        timeUsed = r.curCpuTime - r.lastCpuTime;
                        pw.print(prefix);
                        pw.print("    ");
                        pw.print("run cpu over ");
                        TimeUtils.formatDuration(uptimeSince, pw);
                        pw.print(" used ");
                        TimeUtils.formatDuration(timeUsed, pw);
                        pw.print(" (");
                        pw.print((100 * timeUsed) / uptimeSince);
                        pw.println("%)");
                    }
                } else {
                    continue;
                }
            }
        }
        return SHOW_ACTIVITY_START_TIME;
    }

    ArrayList<ProcessRecord> collectProcesses(PrintWriter pw, int start, boolean allPkgs, String[] args) {
        synchronized (this) {
            ArrayList<ProcessRecord> procs;
            if (args != null) {
                if (args.length > start && args[start].charAt(MY_PID) != '-') {
                    procs = new ArrayList();
                    int pid = -1;
                    try {
                        pid = Integer.parseInt(args[start]);
                    } catch (NumberFormatException e) {
                    }
                    for (int i = this.mLruProcesses.size() - 1; i >= 0; i--) {
                        ProcessRecord proc = (ProcessRecord) this.mLruProcesses.get(i);
                        if (proc.pid == pid) {
                            procs.add(proc);
                        } else if (allPkgs && proc.pkgList != null && proc.pkgList.containsKey(args[start])) {
                            procs.add(proc);
                        } else if (proc.processName.equals(args[start])) {
                            procs.add(proc);
                        }
                    }
                    if (procs.size() <= 0) {
                        return null;
                    }
                    return procs;
                }
            }
            procs = new ArrayList(this.mLruProcesses);
            return procs;
        }
    }

    final void dumpGraphicsHardwareUsage(FileDescriptor fd, PrintWriter pw, String[] args) {
        ArrayList<ProcessRecord> procs = collectProcesses(pw, MY_PID, VALIDATE_TOKENS, args);
        if (procs == null) {
            pw.println("No process found for: " + args[MY_PID]);
            return;
        }
        long uptime = SystemClock.uptimeMillis();
        long realtime = SystemClock.elapsedRealtime();
        pw.println("Applications Graphics Acceleration Info:");
        pw.println("Uptime: " + uptime + " Realtime: " + realtime);
        for (int i = procs.size() - 1; i >= 0; i--) {
            ProcessRecord r = (ProcessRecord) procs.get(i);
            if (r.thread != null) {
                pw.println("\n** Graphics info for pid " + r.pid + " [" + r.processName + "] **");
                pw.flush();
                try {
                    TransferPipe tp = new TransferPipe();
                    r.thread.dumpGfxInfo(tp.getWriteFd().getFileDescriptor(), args);
                    tp.go(fd);
                    tp.kill();
                } catch (IOException e) {
                    pw.println("Failure while dumping the app: " + r);
                    pw.flush();
                } catch (RemoteException e2) {
                    pw.println("Got a RemoteException while dumping the app " + r);
                    pw.flush();
                } catch (Throwable th) {
                    tp.kill();
                }
            }
        }
    }

    final void dumpDbInfo(FileDescriptor fd, PrintWriter pw, String[] args) {
        ArrayList<ProcessRecord> procs = collectProcesses(pw, MY_PID, VALIDATE_TOKENS, args);
        if (procs == null) {
            pw.println("No process found for: " + args[MY_PID]);
            return;
        }
        pw.println("Applications Database Info:");
        for (int i = procs.size() - 1; i >= 0; i--) {
            ProcessRecord r = (ProcessRecord) procs.get(i);
            if (r.thread != null) {
                pw.println("\n** Database info for pid " + r.pid + " [" + r.processName + "] **");
                pw.flush();
                try {
                    TransferPipe tp = new TransferPipe();
                    r.thread.dumpDbInfo(tp.getWriteFd().getFileDescriptor(), args);
                    tp.go(fd);
                    tp.kill();
                } catch (IOException e) {
                    pw.println("Failure while dumping the app: " + r);
                    pw.flush();
                } catch (RemoteException e2) {
                    pw.println("Got a RemoteException while dumping the app " + r);
                    pw.flush();
                } catch (Throwable th) {
                    tp.kill();
                }
            }
        }
    }

    static final void dumpMemItems(PrintWriter pw, String prefix, String tag, ArrayList<MemItem> items, boolean sort, boolean isCompact) {
        if (sort && !isCompact) {
            Collections.sort(items, new Comparator<MemItem>() {
                public int compare(MemItem lhs, MemItem rhs) {
                    if (lhs.pss < rhs.pss) {
                        return ActivityManagerService.SHOW_ERROR_MSG;
                    }
                    if (lhs.pss > rhs.pss) {
                        return -1;
                    }
                    return ActivityManagerService.MY_PID;
                }
            });
        }
        for (int i = MY_PID; i < items.size(); i += SHOW_ERROR_MSG) {
            MemItem mi = (MemItem) items.get(i);
            if (!isCompact) {
                pw.print(prefix);
                Object[] objArr = new Object[SHOW_ERROR_MSG];
                objArr[MY_PID] = Long.valueOf(mi.pss);
                pw.printf("%7d kB: ", objArr);
                pw.println(mi.label);
            } else if (mi.isProc) {
                pw.print("proc,");
                pw.print(tag);
                pw.print(",");
                pw.print(mi.shortLabel);
                pw.print(",");
                pw.print(mi.id);
                pw.print(",");
                pw.print(mi.pss);
                pw.println(mi.hasActivities ? ",a" : ",e");
            } else {
                pw.print(tag);
                pw.print(",");
                pw.print(mi.shortLabel);
                pw.print(",");
                pw.println(mi.pss);
            }
            if (mi.subitems != null) {
                dumpMemItems(pw, prefix + "           ", mi.shortLabel, mi.subitems, SHOW_ACTIVITY_START_TIME, isCompact);
            }
        }
    }

    static final void appendMemBucket(StringBuilder out, long memKB, String label, boolean stackLike) {
        int start = label.lastIndexOf(START_USER_SWITCH_MSG);
        if (start >= 0) {
            start += SHOW_ERROR_MSG;
        } else {
            start = MY_PID;
        }
        int end = label.length();
        for (int i = MY_PID; i < DUMP_MEM_BUCKETS.length; i += SHOW_ERROR_MSG) {
            if (DUMP_MEM_BUCKETS[i] >= memKB) {
                out.append(DUMP_MEM_BUCKETS[i] / 1024);
                out.append(stackLike ? "MB." : "MB ");
                out.append(label, start, end);
                return;
            }
        }
        out.append(memKB / 1024);
        out.append(stackLike ? "MB." : "MB ");
        out.append(label, start, end);
    }

    private final void dumpApplicationMemoryUsageHeader(PrintWriter pw, long uptime, long realtime, boolean isCheckinRequest, boolean isCompact) {
        if (isCheckinRequest || isCompact) {
            pw.print("time,");
            pw.print(uptime);
            pw.print(",");
            pw.println(realtime);
            return;
        }
        pw.println("Applications Memory Usage (kB):");
        pw.println("Uptime: " + uptime + " Realtime: " + realtime);
    }

    private final long[] getKsmInfo() {
        long[] longOut = new long[UPDATE_CONFIGURATION_MSG];
        int[] SINGLE_LONG_FORMAT = new int[SHOW_ERROR_MSG];
        SINGLE_LONG_FORMAT[MY_PID] = 8224;
        long[] longTmp = new long[SHOW_ERROR_MSG];
        Process.readProcFile("/sys/kernel/mm/ksm/pages_shared", SINGLE_LONG_FORMAT, null, longTmp, null);
        longOut[MY_PID] = (longTmp[MY_PID] * 4096) / 1024;
        longTmp[MY_PID] = 0;
        Process.readProcFile("/sys/kernel/mm/ksm/pages_sharing", SINGLE_LONG_FORMAT, null, longTmp, null);
        longOut[SHOW_ERROR_MSG] = (longTmp[MY_PID] * 4096) / 1024;
        longTmp[MY_PID] = 0;
        Process.readProcFile("/sys/kernel/mm/ksm/pages_unshared", SINGLE_LONG_FORMAT, null, longTmp, null);
        longOut[SHOW_NOT_RESPONDING_MSG] = (longTmp[MY_PID] * 4096) / 1024;
        longTmp[MY_PID] = 0;
        Process.readProcFile("/sys/kernel/mm/ksm/pages_volatile", SINGLE_LONG_FORMAT, null, longTmp, null);
        longOut[SHOW_FACTORY_ERROR_MSG] = (longTmp[MY_PID] * 4096) / 1024;
        return longOut;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    final void dumpApplicationMemoryUsage(java.io.FileDescriptor r103, java.io.PrintWriter r104, java.lang.String r105, java.lang.String[] r106, boolean r107, java.io.PrintWriter r108) {
        /*
        r102 = this;
        r70 = 0;
        r18 = 0;
        r19 = 0;
        r87 = 0;
        r13 = 0;
        r76 = 0;
        r94 = 0;
        r91 = 0;
    L_0x000f:
        r0 = r106;
        r6 = r0.length;
        r0 = r91;
        if (r0 >= r6) goto L_0x002b;
    L_0x0016:
        r90 = r106[r91];
        if (r90 == 0) goto L_0x002b;
    L_0x001a:
        r6 = r90.length();
        if (r6 <= 0) goto L_0x002b;
    L_0x0020:
        r6 = 0;
        r0 = r90;
        r6 = r0.charAt(r6);
        r7 = 45;
        if (r6 == r7) goto L_0x00b5;
    L_0x002b:
        r6 = "--checkin";
        r0 = r106;
        r12 = scanArgs(r0, r6);
        r8 = android.os.SystemClock.uptimeMillis();
        r10 = android.os.SystemClock.elapsedRealtime();
        r6 = 1;
        r0 = new long[r6];
        r99 = r0;
        r0 = r102;
        r1 = r104;
        r2 = r91;
        r3 = r94;
        r4 = r106;
        r96 = r0.collectProcesses(r1, r2, r3, r4);
        if (r96 != 0) goto L_0x0246;
    L_0x0050:
        if (r106 == 0) goto L_0x022a;
    L_0x0052:
        r0 = r106;
        r6 = r0.length;
        r0 = r91;
        if (r6 <= r0) goto L_0x022a;
    L_0x0059:
        r6 = r106[r91];
        r7 = 0;
        r6 = r6.charAt(r7);
        r7 = 45;
        if (r6 == r7) goto L_0x022a;
    L_0x0064:
        r82 = new java.util.ArrayList;
        r82.<init>();
        r102.updateCpuStatsNow();
        r72 = -1;
        r6 = r106[r91];	 Catch:{ NumberFormatException -> 0x0a0d }
        r72 = java.lang.Integer.parseInt(r6);	 Catch:{ NumberFormatException -> 0x0a0d }
    L_0x0074:
        r0 = r102;
        r7 = r0.mProcessCpuTracker;
        monitor-enter(r7);
        r0 = r102;
        r6 = r0.mProcessCpuTracker;	 Catch:{ all -> 0x0210 }
        r14 = r6.countStats();	 Catch:{ all -> 0x0210 }
        r73 = 0;
    L_0x0083:
        r0 = r73;
        if (r0 >= r14) goto L_0x0181;
    L_0x0087:
        r0 = r102;
        r6 = r0.mProcessCpuTracker;	 Catch:{ all -> 0x0210 }
        r0 = r73;
        r98 = r6.getStats(r0);	 Catch:{ all -> 0x0210 }
        r0 = r98;
        r6 = r0.pid;	 Catch:{ all -> 0x0210 }
        r0 = r72;
        if (r6 == r0) goto L_0x00ab;
    L_0x0099:
        r0 = r98;
        r6 = r0.baseName;	 Catch:{ all -> 0x0210 }
        if (r6 == 0) goto L_0x00b2;
    L_0x009f:
        r0 = r98;
        r6 = r0.baseName;	 Catch:{ all -> 0x0210 }
        r15 = r106[r91];	 Catch:{ all -> 0x0210 }
        r6 = r6.equals(r15);	 Catch:{ all -> 0x0210 }
        if (r6 == 0) goto L_0x00b2;
    L_0x00ab:
        r0 = r82;
        r1 = r98;
        r0.add(r1);	 Catch:{ all -> 0x0210 }
    L_0x00b2:
        r73 = r73 + 1;
        goto L_0x0083;
    L_0x00b5:
        r91 = r91 + 1;
        r6 = "-a";
        r0 = r90;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x00c9;
    L_0x00c1:
        r70 = 1;
        r18 = 1;
        r19 = 1;
        goto L_0x000f;
    L_0x00c9:
        r6 = "-d";
        r0 = r90;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x00d7;
    L_0x00d3:
        r19 = 1;
        goto L_0x000f;
    L_0x00d7:
        r6 = "-c";
        r0 = r90;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x00e4;
    L_0x00e1:
        r13 = 1;
        goto L_0x000f;
    L_0x00e4:
        r6 = "--oom";
        r0 = r90;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x00f2;
    L_0x00ee:
        r87 = 1;
        goto L_0x000f;
    L_0x00f2:
        r6 = "--local";
        r0 = r90;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x0100;
    L_0x00fc:
        r76 = 1;
        goto L_0x000f;
    L_0x0100:
        r6 = "--package";
        r0 = r90;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x010e;
    L_0x010a:
        r94 = 1;
        goto L_0x000f;
    L_0x010e:
        r6 = "-h";
        r0 = r90;
        r6 = r6.equals(r0);
        if (r6 == 0) goto L_0x015f;
    L_0x0118:
        r6 = "meminfo dump options: [-a] [-d] [-c] [--oom] [process]";
        r0 = r104;
        r0.println(r6);
        r6 = "  -a: include all available information for each process.";
        r0 = r104;
        r0.println(r6);
        r6 = "  -d: include dalvik details when dumping process details.";
        r0 = r104;
        r0.println(r6);
        r6 = "  -c: dump in a compact machine-parseable representation.";
        r0 = r104;
        r0.println(r6);
        r6 = "  --oom: only show processes organized by oom adj.";
        r0 = r104;
        r0.println(r6);
        r6 = "  --local: only collect details locally, don't call process.";
        r0 = r104;
        r0.println(r6);
        r6 = "  --package: interpret process arg as package, dumping all";
        r0 = r104;
        r0.println(r6);
        r6 = "             processes that have loaded that package.";
        r0 = r104;
        r0.println(r6);
        r6 = "If [process] is specified it can be the name or ";
        r0 = r104;
        r0.println(r6);
        r6 = "pid of a specific process to dump.";
        r0 = r104;
        r0.println(r6);
    L_0x015e:
        return;
    L_0x015f:
        r6 = new java.lang.StringBuilder;
        r6.<init>();
        r7 = "Unknown argument: ";
        r6 = r6.append(r7);
        r0 = r90;
        r6 = r6.append(r0);
        r7 = "; use -h for help";
        r6 = r6.append(r7);
        r6 = r6.toString();
        r0 = r104;
        r0.println(r6);
        goto L_0x000f;
    L_0x0181:
        monitor-exit(r7);	 Catch:{ all -> 0x0210 }
        r6 = r82.size();
        if (r6 <= 0) goto L_0x022a;
    L_0x0188:
        r6 = r102;
        r7 = r104;
        r6.dumpApplicationMemoryUsageHeader(r7, r8, r10, r12, r13);
        r16 = 0;
        r6 = r82.size();
        r73 = r6 + -1;
    L_0x0197:
        if (r73 < 0) goto L_0x015e;
    L_0x0199:
        r0 = r82;
        r1 = r73;
        r97 = r0.get(r1);
        r97 = (com.android.internal.os.ProcessCpuTracker.Stats) r97;
        r0 = r97;
        r0 = r0.pid;
        r20 = r0;
        if (r12 != 0) goto L_0x01db;
    L_0x01ab:
        if (r70 == 0) goto L_0x01db;
    L_0x01ad:
        r6 = new java.lang.StringBuilder;
        r6.<init>();
        r7 = "\n** MEMINFO in pid ";
        r6 = r6.append(r7);
        r0 = r20;
        r6 = r6.append(r0);
        r7 = " [";
        r6 = r6.append(r7);
        r0 = r97;
        r7 = r0.baseName;
        r6 = r6.append(r7);
        r7 = "] **";
        r6 = r6.append(r7);
        r6 = r6.toString();
        r0 = r104;
        r0.println(r6);
    L_0x01db:
        if (r16 != 0) goto L_0x01e2;
    L_0x01dd:
        r16 = new android.os.Debug$MemoryInfo;
        r16.<init>();
    L_0x01e2:
        if (r70 != 0) goto L_0x01e8;
    L_0x01e4:
        if (r107 != 0) goto L_0x0213;
    L_0x01e6:
        if (r87 != 0) goto L_0x0213;
    L_0x01e8:
        r0 = r20;
        r1 = r16;
        android.os.Debug.getMemoryInfo(r0, r1);
    L_0x01ef:
        r0 = r97;
        r0 = r0.baseName;
        r21 = r0;
        r22 = 0;
        r24 = 0;
        r26 = 0;
        r28 = 0;
        r30 = 0;
        r32 = 0;
        r15 = r104;
        r17 = r12;
        android.app.ActivityThread.dumpMemInfoTable(r15, r16, r17, r18, r19, r20, r21, r22, r24, r26, r28, r30, r32);
        if (r12 == 0) goto L_0x020d;
    L_0x020a:
        r104.println();
    L_0x020d:
        r73 = r73 + -1;
        goto L_0x0197;
    L_0x0210:
        r6 = move-exception;
        monitor-exit(r7);	 Catch:{ all -> 0x0210 }
        throw r6;
    L_0x0213:
        r6 = 0;
        r0 = r20;
        r1 = r99;
        r6 = android.os.Debug.getPss(r0, r1, r6);
        r6 = (int) r6;
        r0 = r16;
        r0.dalvikPss = r6;
        r6 = 0;
        r6 = r99[r6];
        r6 = (int) r6;
        r0 = r16;
        r0.dalvikPrivateDirty = r6;
        goto L_0x01ef;
    L_0x022a:
        r6 = new java.lang.StringBuilder;
        r6.<init>();
        r7 = "No process found for: ";
        r6 = r6.append(r7);
        r7 = r106[r91];
        r6 = r6.append(r7);
        r6 = r6.toString();
        r0 = r104;
        r0.println(r6);
        goto L_0x015e;
    L_0x0246:
        if (r107 != 0) goto L_0x0257;
    L_0x0248:
        if (r87 != 0) goto L_0x0257;
    L_0x024a:
        r6 = r96.size();
        r7 = 1;
        if (r6 == r7) goto L_0x0255;
    L_0x0251:
        if (r12 != 0) goto L_0x0255;
    L_0x0253:
        if (r94 == 0) goto L_0x0257;
    L_0x0255:
        r70 = 1;
    L_0x0257:
        r6 = r102;
        r7 = r104;
        r6.dumpApplicationMemoryUsageHeader(r7, r8, r10, r12, r13);
        r0 = r106;
        r6 = r0.length;
        r6 = r6 - r91;
        r0 = new java.lang.String[r6];
        r74 = r0;
        r6 = 0;
        r0 = r106;
        r7 = r0.length;
        r7 = r7 - r91;
        r0 = r106;
        r1 = r91;
        r2 = r74;
        java.lang.System.arraycopy(r0, r1, r2, r6, r7);
        r46 = new java.util.ArrayList;
        r46.<init>();
        r95 = new android.util.SparseArray;
        r95.<init>();
        r84 = 0;
        r68 = 0;
        r92 = 0;
        r6 = 17;
        r0 = new long[r6];
        r81 = r0;
        r6 = DUMP_MEM_OOM_LABEL;
        r6 = r6.length;
        r0 = new long[r6];
        r89 = r0;
        r6 = DUMP_MEM_OOM_LABEL;
        r6 = r6.length;
        r0 = new java.util.ArrayList[r6];
        r88 = r0;
        r88 = (java.util.ArrayList[]) r88;
        r100 = 0;
        r66 = 0;
        r16 = 0;
        r6 = r96.size();
        r73 = r6 + -1;
    L_0x02a8:
        if (r73 < 0) goto L_0x0472;
    L_0x02aa:
        r0 = r96;
        r1 = r73;
        r97 = r0.get(r1);
        r97 = (com.android.server.am.ProcessRecord) r97;
        monitor-enter(r102);
        r0 = r97;
        r0 = r0.thread;	 Catch:{ all -> 0x03ec }
        r21 = r0;
        r0 = r97;
        r0 = r0.pid;	 Catch:{ all -> 0x03ec }
        r20 = r0;
        r83 = r97.getSetAdjWithServices();	 Catch:{ all -> 0x03ec }
        r0 = r97;
        r6 = r0.activities;	 Catch:{ all -> 0x03ec }
        r6 = r6.size();	 Catch:{ all -> 0x03ec }
        if (r6 <= 0) goto L_0x03e8;
    L_0x02cf:
        r35 = 1;
    L_0x02d1:
        monitor-exit(r102);	 Catch:{ all -> 0x03ec }
        if (r21 == 0) goto L_0x046b;
    L_0x02d4:
        if (r12 != 0) goto L_0x0306;
    L_0x02d6:
        if (r70 == 0) goto L_0x0306;
    L_0x02d8:
        r6 = new java.lang.StringBuilder;
        r6.<init>();
        r7 = "\n** MEMINFO in pid ";
        r6 = r6.append(r7);
        r0 = r20;
        r6 = r6.append(r0);
        r7 = " [";
        r6 = r6.append(r7);
        r0 = r97;
        r7 = r0.processName;
        r6 = r6.append(r7);
        r7 = "] **";
        r6 = r6.append(r7);
        r6 = r6.toString();
        r0 = r104;
        r0.println(r6);
    L_0x0306:
        if (r16 != 0) goto L_0x030d;
    L_0x0308:
        r16 = new android.os.Debug$MemoryInfo;
        r16.<init>();
    L_0x030d:
        if (r70 != 0) goto L_0x0313;
    L_0x030f:
        if (r107 != 0) goto L_0x03ef;
    L_0x0311:
        if (r87 != 0) goto L_0x03ef;
    L_0x0313:
        r0 = r20;
        r1 = r16;
        android.os.Debug.getMemoryInfo(r0, r1);
    L_0x031a:
        if (r70 == 0) goto L_0x033c;
    L_0x031c:
        if (r76 == 0) goto L_0x0407;
    L_0x031e:
        r0 = r97;
        r0 = r0.processName;
        r21 = r0;
        r22 = 0;
        r24 = 0;
        r26 = 0;
        r28 = 0;
        r30 = 0;
        r32 = 0;
        r15 = r104;
        r17 = r12;
        android.app.ActivityThread.dumpMemInfoTable(r15, r16, r17, r18, r19, r20, r21, r22, r24, r26, r28, r30, r32);
        if (r12 == 0) goto L_0x033c;
    L_0x0339:
        r104.println();
    L_0x033c:
        r6 = r16.getTotalPss();
        r0 = (long) r6;
        r24 = r0;
        r6 = r16.getTotalUss();
        r0 = (long) r6;
        r26 = r0;
        monitor-enter(r102);
        r0 = r97;
        r6 = r0.thread;	 Catch:{ all -> 0x042a }
        if (r6 == 0) goto L_0x036a;
    L_0x0351:
        r6 = r97.getSetAdjWithServices();	 Catch:{ all -> 0x042a }
        r0 = r83;
        if (r0 != r6) goto L_0x036a;
    L_0x0359:
        r0 = r97;
        r0 = r0.baseProcessTracker;	 Catch:{ all -> 0x042a }
        r23 = r0;
        r28 = 1;
        r0 = r97;
        r0 = r0.pkgList;	 Catch:{ all -> 0x042a }
        r29 = r0;
        r23.addPss(r24, r26, r28, r29);	 Catch:{ all -> 0x042a }
    L_0x036a:
        monitor-exit(r102);	 Catch:{ all -> 0x042a }
        if (r12 != 0) goto L_0x046b;
    L_0x036d:
        if (r16 == 0) goto L_0x046b;
    L_0x036f:
        r100 = r100 + r24;
        r29 = new com.android.server.am.ActivityManagerService$MemItem;
        r6 = new java.lang.StringBuilder;
        r6.<init>();
        r0 = r97;
        r7 = r0.processName;
        r6 = r6.append(r7);
        r7 = " (pid ";
        r6 = r6.append(r7);
        r0 = r20;
        r7 = r6.append(r0);
        if (r35 == 0) goto L_0x042d;
    L_0x038e:
        r6 = " / activities)";
    L_0x0390:
        r6 = r7.append(r6);
        r30 = r6.toString();
        r0 = r97;
        r0 = r0.processName;
        r31 = r0;
        r32 = r24;
        r34 = r20;
        r29.<init>(r30, r31, r32, r34, r35);
        r0 = r46;
        r1 = r29;
        r0.add(r1);
        r0 = r95;
        r1 = r20;
        r2 = r29;
        r0.put(r1, r2);
        r0 = r16;
        r6 = r0.nativePss;
        r6 = (long) r6;
        r84 = r84 + r6;
        r0 = r16;
        r6 = r0.dalvikPss;
        r6 = (long) r6;
        r68 = r68 + r6;
        r0 = r16;
        r6 = r0.otherPss;
        r6 = (long) r6;
        r92 = r92 + r6;
        r42 = 0;
    L_0x03cc:
        r6 = 17;
        r0 = r42;
        if (r0 >= r6) goto L_0x0431;
    L_0x03d2:
        r0 = r16;
        r1 = r42;
        r6 = r0.getOtherPss(r1);
        r0 = (long) r6;
        r78 = r0;
        r6 = r81[r42];
        r6 = r6 + r78;
        r81[r42] = r6;
        r92 = r92 - r78;
        r42 = r42 + 1;
        goto L_0x03cc;
    L_0x03e8:
        r35 = 0;
        goto L_0x02d1;
    L_0x03ec:
        r6 = move-exception;
        monitor-exit(r102);	 Catch:{ all -> 0x03ec }
        throw r6;
    L_0x03ef:
        r6 = 0;
        r0 = r20;
        r1 = r99;
        r6 = android.os.Debug.getPss(r0, r1, r6);
        r6 = (int) r6;
        r0 = r16;
        r0.dalvikPss = r6;
        r6 = 0;
        r6 = r99[r6];
        r6 = (int) r6;
        r0 = r16;
        r0.dalvikPrivateDirty = r6;
        goto L_0x031a;
    L_0x0407:
        r104.flush();	 Catch:{ RemoteException -> 0x041b }
        r22 = r103;
        r23 = r16;
        r24 = r12;
        r25 = r18;
        r26 = r19;
        r27 = r74;
        r21.dumpMemInfo(r22, r23, r24, r25, r26, r27);	 Catch:{ RemoteException -> 0x041b }
        goto L_0x033c;
    L_0x041b:
        r71 = move-exception;
        if (r12 != 0) goto L_0x033c;
    L_0x041e:
        r6 = "Got RemoteException!";
        r0 = r104;
        r0.println(r6);
        r104.flush();
        goto L_0x033c;
    L_0x042a:
        r6 = move-exception;
        monitor-exit(r102);	 Catch:{ all -> 0x042a }
        throw r6;
    L_0x042d:
        r6 = ")";
        goto L_0x0390;
    L_0x0431:
        r6 = 9;
        r0 = r83;
        if (r0 < r6) goto L_0x0439;
    L_0x0437:
        r66 = r66 + r24;
    L_0x0439:
        r86 = 0;
    L_0x043b:
        r0 = r89;
        r6 = r0.length;
        r0 = r86;
        if (r0 >= r6) goto L_0x046b;
    L_0x0442:
        r6 = DUMP_MEM_OOM_ADJ;
        r6 = r6[r86];
        r0 = r83;
        if (r0 <= r6) goto L_0x0453;
    L_0x044a:
        r0 = r89;
        r6 = r0.length;
        r6 = r6 + -1;
        r0 = r86;
        if (r0 != r6) goto L_0x046f;
    L_0x0453:
        r6 = r89[r86];
        r6 = r6 + r24;
        r89[r86] = r6;
        r6 = r88[r86];
        if (r6 != 0) goto L_0x0464;
    L_0x045d:
        r6 = new java.util.ArrayList;
        r6.<init>();
        r88[r86] = r6;
    L_0x0464:
        r6 = r88[r86];
        r0 = r29;
        r6.add(r0);
    L_0x046b:
        r73 = r73 + -1;
        goto L_0x02a8;
    L_0x046f:
        r86 = r86 + 1;
        goto L_0x043b;
    L_0x0472:
        r64 = 0;
        if (r12 != 0) goto L_0x015e;
    L_0x0476:
        r6 = r96.size();
        r7 = 1;
        if (r6 <= r7) goto L_0x015e;
    L_0x047d:
        if (r94 != 0) goto L_0x015e;
    L_0x047f:
        r102.updateCpuStatsNow();
        r16 = 0;
        r0 = r102;
        r7 = r0.mProcessCpuTracker;
        monitor-enter(r7);
        r0 = r102;
        r6 = r0.mProcessCpuTracker;	 Catch:{ all -> 0x0574 }
        r14 = r6.countStats();	 Catch:{ all -> 0x0574 }
        r73 = 0;
        r80 = r16;
    L_0x0495:
        r0 = r73;
        if (r0 >= r14) goto L_0x0599;
    L_0x0499:
        r0 = r102;
        r6 = r0.mProcessCpuTracker;	 Catch:{ all -> 0x0a08 }
        r0 = r73;
        r98 = r6.getStats(r0);	 Catch:{ all -> 0x0a08 }
        r0 = r98;
        r0 = r0.vsize;	 Catch:{ all -> 0x0a08 }
        r22 = r0;
        r30 = 0;
        r6 = (r22 > r30 ? 1 : (r22 == r30 ? 0 : -1));
        if (r6 <= 0) goto L_0x0a14;
    L_0x04af:
        r0 = r98;
        r6 = r0.pid;	 Catch:{ all -> 0x0a08 }
        r0 = r95;
        r6 = r0.indexOfKey(r6);	 Catch:{ all -> 0x0a08 }
        if (r6 >= 0) goto L_0x0a14;
    L_0x04bb:
        if (r80 != 0) goto L_0x0a10;
    L_0x04bd:
        r16 = new android.os.Debug$MemoryInfo;	 Catch:{ all -> 0x0a08 }
        r16.<init>();	 Catch:{ all -> 0x0a08 }
    L_0x04c2:
        if (r107 != 0) goto L_0x0556;
    L_0x04c4:
        if (r87 != 0) goto L_0x0556;
    L_0x04c6:
        r0 = r98;
        r6 = r0.pid;	 Catch:{ all -> 0x0574 }
        r0 = r16;
        android.os.Debug.getMemoryInfo(r6, r0);	 Catch:{ all -> 0x0574 }
    L_0x04cf:
        r6 = r16.getTotalPss();	 Catch:{ all -> 0x0574 }
        r0 = (long) r6;	 Catch:{ all -> 0x0574 }
        r24 = r0;
        r100 = r100 + r24;
        r64 = r64 + r24;
        r29 = new com.android.server.am.ActivityManagerService$MemItem;	 Catch:{ all -> 0x0574 }
        r6 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0574 }
        r6.<init>();	 Catch:{ all -> 0x0574 }
        r0 = r98;
        r15 = r0.name;	 Catch:{ all -> 0x0574 }
        r6 = r6.append(r15);	 Catch:{ all -> 0x0574 }
        r15 = " (pid ";
        r6 = r6.append(r15);	 Catch:{ all -> 0x0574 }
        r0 = r98;
        r15 = r0.pid;	 Catch:{ all -> 0x0574 }
        r6 = r6.append(r15);	 Catch:{ all -> 0x0574 }
        r15 = ")";
        r6 = r6.append(r15);	 Catch:{ all -> 0x0574 }
        r38 = r6.toString();	 Catch:{ all -> 0x0574 }
        r0 = r98;
        r0 = r0.name;	 Catch:{ all -> 0x0574 }
        r39 = r0;
        r0 = r98;
        r0 = r0.pid;	 Catch:{ all -> 0x0574 }
        r42 = r0;
        r43 = 0;
        r37 = r29;
        r40 = r24;
        r37.<init>(r38, r39, r40, r42, r43);	 Catch:{ all -> 0x0574 }
        r0 = r46;
        r1 = r29;
        r0.add(r1);	 Catch:{ all -> 0x0574 }
        r0 = r16;
        r6 = r0.nativePss;	 Catch:{ all -> 0x0574 }
        r0 = (long) r6;	 Catch:{ all -> 0x0574 }
        r22 = r0;
        r84 = r84 + r22;
        r0 = r16;
        r6 = r0.dalvikPss;	 Catch:{ all -> 0x0574 }
        r0 = (long) r6;	 Catch:{ all -> 0x0574 }
        r22 = r0;
        r68 = r68 + r22;
        r0 = r16;
        r6 = r0.otherPss;	 Catch:{ all -> 0x0574 }
        r0 = (long) r6;	 Catch:{ all -> 0x0574 }
        r22 = r0;
        r92 = r92 + r22;
        r42 = 0;
    L_0x053a:
        r6 = 17;
        r0 = r42;
        if (r0 >= r6) goto L_0x0577;
    L_0x0540:
        r0 = r16;
        r1 = r42;
        r6 = r0.getOtherPss(r1);	 Catch:{ all -> 0x0574 }
        r0 = (long) r6;	 Catch:{ all -> 0x0574 }
        r78 = r0;
        r22 = r81[r42];	 Catch:{ all -> 0x0574 }
        r22 = r22 + r78;
        r81[r42] = r22;	 Catch:{ all -> 0x0574 }
        r92 = r92 - r78;
        r42 = r42 + 1;
        goto L_0x053a;
    L_0x0556:
        r0 = r98;
        r6 = r0.pid;	 Catch:{ all -> 0x0574 }
        r15 = 0;
        r0 = r99;
        r22 = android.os.Debug.getPss(r6, r0, r15);	 Catch:{ all -> 0x0574 }
        r0 = r22;
        r6 = (int) r0;	 Catch:{ all -> 0x0574 }
        r0 = r16;
        r0.nativePss = r6;	 Catch:{ all -> 0x0574 }
        r6 = 0;
        r22 = r99[r6];	 Catch:{ all -> 0x0574 }
        r0 = r22;
        r6 = (int) r0;	 Catch:{ all -> 0x0574 }
        r0 = r16;
        r0.nativePrivateDirty = r6;	 Catch:{ all -> 0x0574 }
        goto L_0x04cf;
    L_0x0574:
        r6 = move-exception;
    L_0x0575:
        monitor-exit(r7);	 Catch:{ all -> 0x0574 }
        throw r6;
    L_0x0577:
        r6 = 0;
        r22 = r89[r6];	 Catch:{ all -> 0x0574 }
        r22 = r22 + r24;
        r89[r6] = r22;	 Catch:{ all -> 0x0574 }
        r6 = 0;
        r6 = r88[r6];	 Catch:{ all -> 0x0574 }
        if (r6 != 0) goto L_0x058b;
    L_0x0583:
        r6 = 0;
        r15 = new java.util.ArrayList;	 Catch:{ all -> 0x0574 }
        r15.<init>();	 Catch:{ all -> 0x0574 }
        r88[r6] = r15;	 Catch:{ all -> 0x0574 }
    L_0x058b:
        r6 = 0;
        r6 = r88[r6];	 Catch:{ all -> 0x0574 }
        r0 = r29;
        r6.add(r0);	 Catch:{ all -> 0x0574 }
    L_0x0593:
        r73 = r73 + 1;
        r80 = r16;
        goto L_0x0495;
    L_0x0599:
        monitor-exit(r7);	 Catch:{ all -> 0x0a08 }
        r54 = new java.util.ArrayList;
        r54.<init>();
        r37 = new com.android.server.am.ActivityManagerService$MemItem;
        r38 = "Native";
        r39 = "Native";
        r42 = -1;
        r40 = r84;
        r37.<init>(r38, r39, r40, r42);
        r0 = r54;
        r1 = r37;
        r0.add(r1);
        r37 = new com.android.server.am.ActivityManagerService$MemItem;
        r38 = "Dalvik";
        r39 = "Dalvik";
        r42 = -2;
        r40 = r68;
        r37.<init>(r38, r39, r40, r42);
        r0 = r54;
        r1 = r37;
        r0.add(r1);
        r37 = new com.android.server.am.ActivityManagerService$MemItem;
        r38 = "Unknown";
        r39 = "Unknown";
        r42 = -3;
        r40 = r92;
        r37.<init>(r38, r39, r40, r42);
        r0 = r54;
        r1 = r37;
        r0.add(r1);
        r42 = 0;
    L_0x05dd:
        r6 = 17;
        r0 = r42;
        if (r0 >= r6) goto L_0x05fa;
    L_0x05e3:
        r38 = android.os.Debug.MemoryInfo.getOtherLabel(r42);
        r37 = new com.android.server.am.ActivityManagerService$MemItem;
        r40 = r81[r42];
        r39 = r38;
        r37.<init>(r38, r39, r40, r42);
        r0 = r54;
        r1 = r37;
        r0.add(r1);
        r42 = r42 + 1;
        goto L_0x05dd;
    L_0x05fa:
        r50 = new java.util.ArrayList;
        r50.<init>();
        r42 = 0;
    L_0x0601:
        r0 = r89;
        r6 = r0.length;
        r0 = r42;
        if (r0 >= r6) goto L_0x0638;
    L_0x0608:
        r6 = r89[r42];
        r22 = 0;
        r6 = (r6 > r22 ? 1 : (r6 == r22 ? 0 : -1));
        if (r6 == 0) goto L_0x0630;
    L_0x0610:
        if (r13 == 0) goto L_0x0633;
    L_0x0612:
        r6 = DUMP_MEM_OOM_COMPACT_LABEL;
        r38 = r6[r42];
    L_0x0616:
        r36 = new com.android.server.am.ActivityManagerService$MemItem;
        r39 = r89[r42];
        r6 = DUMP_MEM_OOM_ADJ;
        r41 = r6[r42];
        r37 = r38;
        r36.<init>(r37, r38, r39, r41);
        r6 = r88[r42];
        r0 = r36;
        r0.subitems = r6;
        r0 = r50;
        r1 = r36;
        r0.add(r1);
    L_0x0630:
        r42 = r42 + 1;
        goto L_0x0601;
    L_0x0633:
        r6 = DUMP_MEM_OOM_LABEL;
        r38 = r6[r42];
        goto L_0x0616;
    L_0x0638:
        if (r107 != 0) goto L_0x0658;
    L_0x063a:
        if (r87 != 0) goto L_0x0658;
    L_0x063c:
        if (r13 != 0) goto L_0x0658;
    L_0x063e:
        r104.println();
        r6 = "Total PSS by process:";
        r0 = r104;
        r0.println(r6);
        r44 = "  ";
        r45 = "proc";
        r47 = 1;
        r43 = r104;
        r48 = r13;
        dumpMemItems(r43, r44, r45, r46, r47, r48);
        r104.println();
    L_0x0658:
        if (r13 != 0) goto L_0x0661;
    L_0x065a:
        r6 = "Total PSS by OOM adjustment:";
        r0 = r104;
        r0.println(r6);
    L_0x0661:
        r48 = "  ";
        r49 = "oom";
        r51 = 0;
        r47 = r104;
        r52 = r13;
        dumpMemItems(r47, r48, r49, r50, r51, r52);
        if (r107 != 0) goto L_0x068d;
    L_0x0670:
        if (r87 != 0) goto L_0x068d;
    L_0x0672:
        if (r108 == 0) goto L_0x08dc;
    L_0x0674:
        r51 = r108;
    L_0x0676:
        if (r13 != 0) goto L_0x0682;
    L_0x0678:
        r51.println();
        r6 = "Total PSS by category:";
        r0 = r51;
        r0.println(r6);
    L_0x0682:
        r52 = "  ";
        r53 = "cat";
        r55 = 1;
        r56 = r13;
        dumpMemItems(r51, r52, r53, r54, r55, r56);
    L_0x068d:
        if (r13 != 0) goto L_0x0692;
    L_0x068f:
        r104.println();
    L_0x0692:
        r77 = new com.android.internal.util.MemInfoReader;
        r77.<init>();
        r77.readMemInfo();
        r6 = 0;
        r6 = (r64 > r6 ? 1 : (r64 == r6 ? 0 : -1));
        if (r6 <= 0) goto L_0x06bb;
    L_0x06a0:
        monitor-enter(r102);
        r0 = r102;
        r0 = r0.mProcessStats;	 Catch:{ all -> 0x08e0 }
        r55 = r0;
        r56 = r77.getCachedSizeKb();	 Catch:{ all -> 0x08e0 }
        r58 = r77.getFreeSizeKb();	 Catch:{ all -> 0x08e0 }
        r60 = r77.getZramTotalSizeKb();	 Catch:{ all -> 0x08e0 }
        r62 = r77.getKernelUsedSizeKb();	 Catch:{ all -> 0x08e0 }
        r55.addSysMemUsageLocked(r56, r58, r60, r62, r64);	 Catch:{ all -> 0x08e0 }
        monitor-exit(r102);	 Catch:{ all -> 0x08e0 }
    L_0x06bb:
        if (r107 != 0) goto L_0x073a;
    L_0x06bd:
        if (r13 != 0) goto L_0x0907;
    L_0x06bf:
        r6 = "Total RAM: ";
        r0 = r104;
        r0.print(r6);
        r6 = r77.getTotalSizeKb();
        r0 = r104;
        r0.print(r6);
        r6 = " kB (status ";
        r0 = r104;
        r0.print(r6);
        r0 = r102;
        r6 = r0.mLastMemoryLevel;
        switch(r6) {
            case 0: goto L_0x08e3;
            case 1: goto L_0x08ec;
            case 2: goto L_0x08f5;
            case 3: goto L_0x08fe;
            default: goto L_0x06dd;
        };
    L_0x06dd:
        r0 = r102;
        r6 = r0.mLastMemoryLevel;
        r0 = r104;
        r0.print(r6);
        r6 = ")";
        r0 = r104;
        r0.println(r6);
    L_0x06ed:
        r6 = " Free RAM: ";
        r0 = r104;
        r0.print(r6);
        r6 = r77.getCachedSizeKb();
        r6 = r6 + r66;
        r22 = r77.getFreeSizeKb();
        r6 = r6 + r22;
        r0 = r104;
        r0.print(r6);
        r6 = " kB (";
        r0 = r104;
        r0.print(r6);
        r0 = r104;
        r1 = r66;
        r0.print(r1);
        r6 = " cached pss + ";
        r0 = r104;
        r0.print(r6);
        r6 = r77.getCachedSizeKb();
        r0 = r104;
        r0.print(r6);
        r6 = " cached kernel + ";
        r0 = r104;
        r0.print(r6);
        r6 = r77.getFreeSizeKb();
        r0 = r104;
        r0.print(r6);
        r6 = " free)";
        r0 = r104;
        r0.println(r6);
    L_0x073a:
        if (r13 != 0) goto L_0x07a0;
    L_0x073c:
        r6 = " Used RAM: ";
        r0 = r104;
        r0.print(r6);
        r6 = r100 - r66;
        r22 = r77.getKernelUsedSizeKb();
        r6 = r6 + r22;
        r0 = r104;
        r0.print(r6);
        r6 = " kB (";
        r0 = r104;
        r0.print(r6);
        r6 = r100 - r66;
        r0 = r104;
        r0.print(r6);
        r6 = " used pss + ";
        r0 = r104;
        r0.print(r6);
        r6 = r77.getKernelUsedSizeKb();
        r0 = r104;
        r0.print(r6);
        r6 = " kernel)\n";
        r0 = r104;
        r0.print(r6);
        r6 = " Lost RAM: ";
        r0 = r104;
        r0.print(r6);
        r6 = r77.getTotalSizeKb();
        r6 = r6 - r100;
        r22 = r77.getFreeSizeKb();
        r6 = r6 - r22;
        r22 = r77.getCachedSizeKb();
        r6 = r6 - r22;
        r22 = r77.getKernelUsedSizeKb();
        r6 = r6 - r22;
        r0 = r104;
        r0.print(r6);
        r6 = " kB";
        r0 = r104;
        r0.println(r6);
    L_0x07a0:
        if (r107 != 0) goto L_0x0a04;
    L_0x07a2:
        r6 = r77.getZramTotalSizeKb();
        r22 = 0;
        r6 = (r6 > r22 ? 1 : (r6 == r22 ? 0 : -1));
        if (r6 == 0) goto L_0x07eb;
    L_0x07ac:
        if (r13 != 0) goto L_0x093f;
    L_0x07ae:
        r6 = "     ZRAM: ";
        r0 = r104;
        r0.print(r6);
        r6 = r77.getZramTotalSizeKb();
        r0 = r104;
        r0.print(r6);
        r6 = " kB physical used for ";
        r0 = r104;
        r0.print(r6);
        r6 = r77.getSwapTotalSizeKb();
        r22 = r77.getSwapFreeSizeKb();
        r6 = r6 - r22;
        r0 = r104;
        r0.print(r6);
        r6 = " kB in swap (";
        r0 = r104;
        r0.print(r6);
        r6 = r77.getSwapTotalSizeKb();
        r0 = r104;
        r0.print(r6);
        r6 = " kB total swap)";
        r0 = r104;
        r0.println(r6);
    L_0x07eb:
        r75 = r102.getKsmInfo();
        if (r13 != 0) goto L_0x0971;
    L_0x07f1:
        r6 = 1;
        r6 = r75[r6];
        r22 = 0;
        r6 = (r6 > r22 ? 1 : (r6 == r22 ? 0 : -1));
        if (r6 != 0) goto L_0x0815;
    L_0x07fa:
        r6 = 0;
        r6 = r75[r6];
        r22 = 0;
        r6 = (r6 > r22 ? 1 : (r6 == r22 ? 0 : -1));
        if (r6 != 0) goto L_0x0815;
    L_0x0803:
        r6 = 2;
        r6 = r75[r6];
        r22 = 0;
        r6 = (r6 > r22 ? 1 : (r6 == r22 ? 0 : -1));
        if (r6 != 0) goto L_0x0815;
    L_0x080c:
        r6 = 3;
        r6 = r75[r6];
        r22 = 0;
        r6 = (r6 > r22 ? 1 : (r6 == r22 ? 0 : -1));
        if (r6 == 0) goto L_0x085f;
    L_0x0815:
        r6 = "      KSM: ";
        r0 = r104;
        r0.print(r6);
        r6 = 1;
        r6 = r75[r6];
        r0 = r104;
        r0.print(r6);
        r6 = " kB saved from shared ";
        r0 = r104;
        r0.print(r6);
        r6 = 0;
        r6 = r75[r6];
        r0 = r104;
        r0.print(r6);
        r6 = " kB";
        r0 = r104;
        r0.println(r6);
        r6 = "           ";
        r0 = r104;
        r0.print(r6);
        r6 = 2;
        r6 = r75[r6];
        r0 = r104;
        r0.print(r6);
        r6 = " kB unshared; ";
        r0 = r104;
        r0.print(r6);
        r6 = 3;
        r6 = r75[r6];
        r0 = r104;
        r0.print(r6);
        r6 = " kB volatile";
        r0 = r104;
        r0.println(r6);
    L_0x085f:
        r6 = "   Tuning: ";
        r0 = r104;
        r0.print(r6);
        r6 = android.app.ActivityManager.staticGetMemoryClass();
        r0 = r104;
        r0.print(r6);
        r6 = " (large ";
        r0 = r104;
        r0.print(r6);
        r6 = android.app.ActivityManager.staticGetLargeMemoryClass();
        r0 = r104;
        r0.print(r6);
        r6 = "), oom ";
        r0 = r104;
        r0.print(r6);
        r0 = r102;
        r6 = r0.mProcessList;
        r7 = 15;
        r6 = r6.getMemLevel(r7);
        r22 = 1024; // 0x400 float:1.435E-42 double:5.06E-321;
        r6 = r6 / r22;
        r0 = r104;
        r0.print(r6);
        r6 = " kB";
        r0 = r104;
        r0.print(r6);
        r6 = ", restore limit ";
        r0 = r104;
        r0.print(r6);
        r0 = r102;
        r6 = r0.mProcessList;
        r6 = r6.getCachedRestoreThresholdKb();
        r0 = r104;
        r0.print(r6);
        r6 = " kB";
        r0 = r104;
        r0.print(r6);
        r6 = android.app.ActivityManager.isLowRamDeviceStatic();
        if (r6 == 0) goto L_0x08c8;
    L_0x08c1:
        r6 = " (low-ram)";
        r0 = r104;
        r0.print(r6);
    L_0x08c8:
        r6 = android.app.ActivityManager.isHighEndGfx();
        if (r6 == 0) goto L_0x08d5;
    L_0x08ce:
        r6 = " (high-end-gfx)";
        r0 = r104;
        r0.print(r6);
    L_0x08d5:
        r104.println();
        r16 = r80;
        goto L_0x015e;
    L_0x08dc:
        r51 = r104;
        goto L_0x0676;
    L_0x08e0:
        r6 = move-exception;
        monitor-exit(r102);	 Catch:{ all -> 0x08e0 }
        throw r6;
    L_0x08e3:
        r6 = "normal)";
        r0 = r104;
        r0.println(r6);
        goto L_0x06ed;
    L_0x08ec:
        r6 = "moderate)";
        r0 = r104;
        r0.println(r6);
        goto L_0x06ed;
    L_0x08f5:
        r6 = "low)";
        r0 = r104;
        r0.println(r6);
        goto L_0x06ed;
    L_0x08fe:
        r6 = "critical)";
        r0 = r104;
        r0.println(r6);
        goto L_0x06ed;
    L_0x0907:
        r6 = "ram,";
        r0 = r104;
        r0.print(r6);
        r6 = r77.getTotalSizeKb();
        r0 = r104;
        r0.print(r6);
        r6 = ",";
        r0 = r104;
        r0.print(r6);
        r6 = r77.getCachedSizeKb();
        r6 = r6 + r66;
        r22 = r77.getFreeSizeKb();
        r6 = r6 + r22;
        r0 = r104;
        r0.print(r6);
        r6 = ",";
        r0 = r104;
        r0.print(r6);
        r6 = r100 - r66;
        r0 = r104;
        r0.println(r6);
        goto L_0x073a;
    L_0x093f:
        r6 = "zram,";
        r0 = r104;
        r0.print(r6);
        r6 = r77.getZramTotalSizeKb();
        r0 = r104;
        r0.print(r6);
        r6 = ",";
        r0 = r104;
        r0.print(r6);
        r6 = r77.getSwapTotalSizeKb();
        r0 = r104;
        r0.print(r6);
        r6 = ",";
        r0 = r104;
        r0.print(r6);
        r6 = r77.getSwapFreeSizeKb();
        r0 = r104;
        r0.println(r6);
        goto L_0x07eb;
    L_0x0971:
        r6 = "ksm,";
        r0 = r104;
        r0.print(r6);
        r6 = 1;
        r6 = r75[r6];
        r0 = r104;
        r0.print(r6);
        r6 = ",";
        r0 = r104;
        r0.print(r6);
        r6 = 0;
        r6 = r75[r6];
        r0 = r104;
        r0.print(r6);
        r6 = ",";
        r0 = r104;
        r0.print(r6);
        r6 = 2;
        r6 = r75[r6];
        r0 = r104;
        r0.print(r6);
        r6 = ",";
        r0 = r104;
        r0.print(r6);
        r6 = 3;
        r6 = r75[r6];
        r0 = r104;
        r0.println(r6);
        r6 = "tuning,";
        r0 = r104;
        r0.print(r6);
        r6 = android.app.ActivityManager.staticGetMemoryClass();
        r0 = r104;
        r0.print(r6);
        r6 = 44;
        r0 = r104;
        r0.print(r6);
        r6 = android.app.ActivityManager.staticGetLargeMemoryClass();
        r0 = r104;
        r0.print(r6);
        r6 = 44;
        r0 = r104;
        r0.print(r6);
        r0 = r102;
        r6 = r0.mProcessList;
        r7 = 15;
        r6 = r6.getMemLevel(r7);
        r22 = 1024; // 0x400 float:1.435E-42 double:5.06E-321;
        r6 = r6 / r22;
        r0 = r104;
        r0.print(r6);
        r6 = android.app.ActivityManager.isLowRamDeviceStatic();
        if (r6 == 0) goto L_0x09f4;
    L_0x09ed:
        r6 = ",low-ram";
        r0 = r104;
        r0.print(r6);
    L_0x09f4:
        r6 = android.app.ActivityManager.isHighEndGfx();
        if (r6 == 0) goto L_0x0a01;
    L_0x09fa:
        r6 = ",high-end-gfx";
        r0 = r104;
        r0.print(r6);
    L_0x0a01:
        r104.println();
    L_0x0a04:
        r16 = r80;
        goto L_0x015e;
    L_0x0a08:
        r6 = move-exception;
        r16 = r80;
        goto L_0x0575;
    L_0x0a0d:
        r6 = move-exception;
        goto L_0x0074;
    L_0x0a10:
        r16 = r80;
        goto L_0x04c2;
    L_0x0a14:
        r16 = r80;
        goto L_0x0593;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.ActivityManagerService.dumpApplicationMemoryUsage(java.io.FileDescriptor, java.io.PrintWriter, java.lang.String, java.lang.String[], boolean, java.io.PrintWriter):void");
    }

    private void appendBasicMemEntry(StringBuilder sb, int oomAdj, int procState, long pss, long memtrack, String name) {
        sb.append("  ");
        sb.append(ProcessList.makeOomAdjString(oomAdj));
        sb.append(' ');
        sb.append(ProcessList.makeProcStateString(procState));
        sb.append(' ');
        ProcessList.appendRamKb(sb, pss);
        sb.append(" kB: ");
        sb.append(name);
        if (memtrack > 0) {
            sb.append(" (");
            sb.append(memtrack);
            sb.append(" kB memtrack)");
        }
    }

    private void appendMemInfo(StringBuilder sb, ProcessMemInfo mi) {
        appendBasicMemEntry(sb, mi.oomAdj, mi.procState, mi.pss, mi.memtrack, mi.name);
        sb.append(" (pid ");
        sb.append(mi.pid);
        sb.append(") ");
        sb.append(mi.adjType);
        sb.append('\n');
        if (mi.adjReason != null) {
            sb.append("                      ");
            sb.append(mi.adjReason);
            sb.append('\n');
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    void reportMemUsage(java.util.ArrayList<com.android.server.am.ProcessMemInfo> r57) {
        /*
        r56 = this;
        r37 = new android.util.SparseArray;
        r5 = r57.size();
        r0 = r37;
        r0.<init>(r5);
        r36 = 0;
        r28 = r57.size();
    L_0x0011:
        r0 = r36;
        r1 = r28;
        if (r0 >= r1) goto L_0x002b;
    L_0x0017:
        r0 = r57;
        r1 = r36;
        r4 = r0.get(r1);
        r4 = (com.android.server.am.ProcessMemInfo) r4;
        r5 = r4.pid;
        r0 = r37;
        r0.put(r5, r4);
        r36 = r36 + 1;
        goto L_0x0011;
    L_0x002b:
        r56.updateCpuStatsNow();
        r5 = 1;
        r0 = new long[r5];
        r44 = r0;
        r0 = r56;
        r14 = r0.mProcessCpuTracker;
        monitor-enter(r14);
        r0 = r56;
        r5 = r0.mProcessCpuTracker;	 Catch:{ all -> 0x00db }
        r28 = r5.countStats();	 Catch:{ all -> 0x00db }
        r36 = 0;
    L_0x0042:
        r0 = r36;
        r1 = r28;
        if (r0 >= r1) goto L_0x009d;
    L_0x0048:
        r0 = r56;
        r5 = r0.mProcessCpuTracker;	 Catch:{ all -> 0x00db }
        r0 = r36;
        r45 = r5.getStats(r0);	 Catch:{ all -> 0x00db }
        r0 = r45;
        r8 = r0.vsize;	 Catch:{ all -> 0x00db }
        r18 = 0;
        r5 = (r8 > r18 ? 1 : (r8 == r18 ? 0 : -1));
        if (r5 <= 0) goto L_0x009a;
    L_0x005c:
        r0 = r45;
        r5 = r0.pid;	 Catch:{ all -> 0x00db }
        r6 = 0;
        r0 = r44;
        r48 = android.os.Debug.getPss(r5, r6, r0);	 Catch:{ all -> 0x00db }
        r8 = 0;
        r5 = (r48 > r8 ? 1 : (r48 == r8 ? 0 : -1));
        if (r5 <= 0) goto L_0x009a;
    L_0x006d:
        r0 = r45;
        r5 = r0.pid;	 Catch:{ all -> 0x00db }
        r0 = r37;
        r5 = r0.indexOfKey(r5);	 Catch:{ all -> 0x00db }
        if (r5 >= 0) goto L_0x009a;
    L_0x0079:
        r4 = new com.android.server.am.ProcessMemInfo;	 Catch:{ all -> 0x00db }
        r0 = r45;
        r5 = r0.name;	 Catch:{ all -> 0x00db }
        r0 = r45;
        r6 = r0.pid;	 Catch:{ all -> 0x00db }
        r7 = -17;
        r8 = -1;
        r9 = "native";
        r10 = 0;
        r4.<init>(r5, r6, r7, r8, r9, r10);	 Catch:{ all -> 0x00db }
        r0 = r48;
        r4.pss = r0;	 Catch:{ all -> 0x00db }
        r5 = 0;
        r8 = r44[r5];	 Catch:{ all -> 0x00db }
        r4.memtrack = r8;	 Catch:{ all -> 0x00db }
        r0 = r57;
        r0.add(r4);	 Catch:{ all -> 0x00db }
    L_0x009a:
        r36 = r36 + 1;
        goto L_0x0042;
    L_0x009d:
        monitor-exit(r14);	 Catch:{ all -> 0x00db }
        r54 = 0;
        r52 = 0;
        r36 = 0;
        r28 = r57.size();
    L_0x00a8:
        r0 = r36;
        r1 = r28;
        if (r0 >= r1) goto L_0x00de;
    L_0x00ae:
        r0 = r57;
        r1 = r36;
        r4 = r0.get(r1);
        r4 = (com.android.server.am.ProcessMemInfo) r4;
        r8 = r4.pss;
        r14 = 0;
        r5 = (r8 > r14 ? 1 : (r8 == r14 ? 0 : -1));
        if (r5 != 0) goto L_0x00d0;
    L_0x00c0:
        r5 = r4.pid;
        r6 = 0;
        r0 = r44;
        r8 = android.os.Debug.getPss(r5, r6, r0);
        r4.pss = r8;
        r5 = 0;
        r8 = r44[r5];
        r4.memtrack = r8;
    L_0x00d0:
        r8 = r4.pss;
        r54 = r54 + r8;
        r8 = r4.memtrack;
        r52 = r52 + r8;
        r36 = r36 + 1;
        goto L_0x00a8;
    L_0x00db:
        r5 = move-exception;
        monitor-exit(r14);	 Catch:{ all -> 0x00db }
        throw r5;
    L_0x00de:
        r5 = new com.android.server.am.ActivityManagerService$22;
        r0 = r56;
        r5.<init>();
        r0 = r57;
        java.util.Collections.sort(r0, r5);
        r51 = new java.lang.StringBuilder;
        r5 = 128; // 0x80 float:1.794E-43 double:6.32E-322;
        r0 = r51;
        r0.<init>(r5);
        r50 = new java.lang.StringBuilder;
        r5 = 128; // 0x80 float:1.794E-43 double:6.32E-322;
        r0 = r50;
        r0.<init>(r5);
        r5 = "Low on memory -- ";
        r0 = r51;
        r0.append(r5);
        r5 = "total";
        r6 = 0;
        r0 = r51;
        r1 = r54;
        appendMemBucket(r0, r1, r5, r6);
        r5 = "total";
        r6 = 1;
        r0 = r50;
        r1 = r54;
        appendMemBucket(r0, r1, r5, r6);
        r35 = new java.lang.StringBuilder;
        r5 = 1024; // 0x400 float:1.435E-42 double:5.06E-321;
        r0 = r35;
        r0.<init>(r5);
        r7 = new java.lang.StringBuilder;
        r5 = 1024; // 0x400 float:1.435E-42 double:5.06E-321;
        r7.<init>(r5);
        r34 = new java.lang.StringBuilder;
        r5 = 1024; // 0x400 float:1.435E-42 double:5.06E-321;
        r0 = r34;
        r0.<init>(r5);
        r33 = 1;
        r41 = -2147483648; // 0xffffffff80000000 float:-0.0 double:NaN;
        r10 = 0;
        r12 = 0;
        r30 = 0;
        r36 = 0;
        r28 = r57.size();
    L_0x0140:
        r0 = r36;
        r1 = r28;
        if (r0 >= r1) goto L_0x0262;
    L_0x0146:
        r0 = r57;
        r1 = r36;
        r4 = r0.get(r1);
        r4 = (com.android.server.am.ProcessMemInfo) r4;
        r5 = r4.oomAdj;
        r6 = 9;
        if (r5 < r6) goto L_0x015a;
    L_0x0156:
        r8 = r4.pss;
        r30 = r30 + r8;
    L_0x015a:
        r5 = r4.oomAdj;
        r6 = -17;
        if (r5 == r6) goto L_0x021e;
    L_0x0160:
        r5 = r4.oomAdj;
        r6 = 5;
        if (r5 < r6) goto L_0x016f;
    L_0x0165:
        r5 = r4.oomAdj;
        r6 = 6;
        if (r5 == r6) goto L_0x016f;
    L_0x016a:
        r5 = r4.oomAdj;
        r6 = 7;
        if (r5 != r6) goto L_0x021e;
    L_0x016f:
        r5 = r4.oomAdj;
        r0 = r41;
        if (r0 == r5) goto L_0x0208;
    L_0x0175:
        r0 = r4.oomAdj;
        r41 = r0;
        r5 = r4.oomAdj;
        if (r5 > 0) goto L_0x0184;
    L_0x017d:
        r5 = " / ";
        r0 = r51;
        r0.append(r5);
    L_0x0184:
        r5 = r4.oomAdj;
        if (r5 < 0) goto L_0x0200;
    L_0x0188:
        if (r33 == 0) goto L_0x0193;
    L_0x018a:
        r5 = ":";
        r0 = r50;
        r0.append(r5);
        r33 = 0;
    L_0x0193:
        r5 = "\n\t at ";
        r0 = r50;
        r0.append(r5);
    L_0x019a:
        r5 = r4.oomAdj;
        if (r5 > 0) goto L_0x01a8;
    L_0x019e:
        r8 = r4.pss;
        r5 = r4.name;
        r6 = 0;
        r0 = r51;
        appendMemBucket(r0, r8, r5, r6);
    L_0x01a8:
        r8 = r4.pss;
        r5 = r4.name;
        r6 = 1;
        r0 = r50;
        appendMemBucket(r0, r8, r5, r6);
        r5 = r4.oomAdj;
        if (r5 < 0) goto L_0x021e;
    L_0x01b6:
        r5 = r36 + 1;
        r0 = r28;
        if (r5 >= r0) goto L_0x01cc;
    L_0x01bc:
        r5 = r36 + 1;
        r0 = r57;
        r5 = r0.get(r5);
        r5 = (com.android.server.am.ProcessMemInfo) r5;
        r5 = r5.oomAdj;
        r0 = r41;
        if (r5 == r0) goto L_0x021e;
    L_0x01cc:
        r5 = "(";
        r0 = r50;
        r0.append(r5);
        r39 = 0;
    L_0x01d5:
        r5 = DUMP_MEM_OOM_ADJ;
        r5 = r5.length;
        r0 = r39;
        if (r0 >= r5) goto L_0x0217;
    L_0x01dc:
        r5 = DUMP_MEM_OOM_ADJ;
        r5 = r5[r39];
        r6 = r4.oomAdj;
        if (r5 != r6) goto L_0x01fd;
    L_0x01e4:
        r5 = DUMP_MEM_OOM_LABEL;
        r5 = r5[r39];
        r0 = r50;
        r0.append(r5);
        r5 = ":";
        r0 = r50;
        r0.append(r5);
        r5 = DUMP_MEM_OOM_ADJ;
        r5 = r5[r39];
        r0 = r50;
        r0.append(r5);
    L_0x01fd:
        r39 = r39 + 1;
        goto L_0x01d5;
    L_0x0200:
        r5 = "$";
        r0 = r50;
        r0.append(r5);
        goto L_0x019a;
    L_0x0208:
        r5 = " ";
        r0 = r51;
        r0.append(r5);
        r5 = "$";
        r0 = r50;
        r0.append(r5);
        goto L_0x019a;
    L_0x0217:
        r5 = ")";
        r0 = r50;
        r0.append(r5);
    L_0x021e:
        r0 = r56;
        r1 = r35;
        r0.appendMemInfo(r1, r4);
        r5 = r4.oomAdj;
        r6 = -17;
        if (r5 != r6) goto L_0x0243;
    L_0x022b:
        r8 = r4.pss;
        r14 = 512; // 0x200 float:7.175E-43 double:2.53E-321;
        r5 = (r8 > r14 ? 1 : (r8 == r14 ? 0 : -1));
        if (r5 < 0) goto L_0x023c;
    L_0x0233:
        r0 = r56;
        r0.appendMemInfo(r7, r4);
    L_0x0238:
        r36 = r36 + 1;
        goto L_0x0140;
    L_0x023c:
        r8 = r4.pss;
        r10 = r10 + r8;
        r8 = r4.memtrack;
        r12 = r12 + r8;
        goto L_0x0238;
    L_0x0243:
        r8 = 0;
        r5 = (r10 > r8 ? 1 : (r10 == r8 ? 0 : -1));
        if (r5 <= 0) goto L_0x025a;
    L_0x0249:
        r8 = -17;
        r9 = -1;
        r14 = "(Other native)";
        r6 = r56;
        r6.appendBasicMemEntry(r7, r8, r9, r10, r12, r14);
        r5 = 10;
        r7.append(r5);
        r10 = 0;
    L_0x025a:
        r0 = r56;
        r1 = r34;
        r0.appendMemInfo(r1, r4);
        goto L_0x0238;
    L_0x0262:
        r5 = "           ";
        r0 = r34;
        r0.append(r5);
        r0 = r34;
        r1 = r54;
        com.android.server.am.ProcessList.appendRamKb(r0, r1);
        r5 = " kB: TOTAL";
        r0 = r34;
        r0.append(r5);
        r8 = 0;
        r5 = (r52 > r8 ? 1 : (r52 == r8 ? 0 : -1));
        if (r5 <= 0) goto L_0x0292;
    L_0x027d:
        r5 = " (";
        r0 = r34;
        r0.append(r5);
        r0 = r34;
        r1 = r52;
        r0.append(r1);
        r5 = " kB memtrack)";
        r0 = r34;
        r0.append(r5);
    L_0x0292:
        r5 = "\n";
        r0 = r34;
        r0.append(r5);
        r42 = new com.android.internal.util.MemInfoReader;
        r42.<init>();
        r42.readMemInfo();
        r38 = r42.getRawInfo();
        r43 = new java.lang.StringBuilder;
        r5 = 1024; // 0x400 float:1.435E-42 double:5.06E-321;
        r0 = r43;
        r0.<init>(r5);
        android.os.Debug.getMemInfo(r38);
        r5 = "  MemInfo: ";
        r0 = r43;
        r0.append(r5);
        r5 = 5;
        r8 = r38[r5];
        r0 = r43;
        r5 = r0.append(r8);
        r6 = " kB slab, ";
        r5.append(r6);
        r5 = 4;
        r8 = r38[r5];
        r0 = r43;
        r5 = r0.append(r8);
        r6 = " kB shmem, ";
        r5.append(r6);
        r5 = 10;
        r8 = r38[r5];
        r0 = r43;
        r5 = r0.append(r8);
        r6 = " kB vm alloc, ";
        r5.append(r6);
        r5 = 11;
        r8 = r38[r5];
        r0 = r43;
        r5 = r0.append(r8);
        r6 = " kB page tables ";
        r5.append(r6);
        r5 = 12;
        r8 = r38[r5];
        r0 = r43;
        r5 = r0.append(r8);
        r6 = " kB kernel stack\n";
        r5.append(r6);
        r5 = "           ";
        r0 = r43;
        r0.append(r5);
        r5 = 2;
        r8 = r38[r5];
        r0 = r43;
        r5 = r0.append(r8);
        r6 = " kB buffers, ";
        r5.append(r6);
        r5 = 3;
        r8 = r38[r5];
        r0 = r43;
        r5 = r0.append(r8);
        r6 = " kB cached, ";
        r5.append(r6);
        r5 = 9;
        r8 = r38[r5];
        r0 = r43;
        r5 = r0.append(r8);
        r6 = " kB mapped, ";
        r5.append(r6);
        r5 = 1;
        r8 = r38[r5];
        r0 = r43;
        r5 = r0.append(r8);
        r6 = " kB free\n";
        r5.append(r6);
        r5 = 8;
        r8 = r38[r5];
        r14 = 0;
        r5 = (r8 > r14 ? 1 : (r8 == r14 ? 0 : -1));
        if (r5 == 0) goto L_0x0380;
    L_0x034b:
        r5 = "  ZRAM: ";
        r0 = r43;
        r0.append(r5);
        r5 = 8;
        r8 = r38[r5];
        r0 = r43;
        r0.append(r8);
        r5 = " kB RAM, ";
        r0 = r43;
        r0.append(r5);
        r5 = 6;
        r8 = r38[r5];
        r0 = r43;
        r0.append(r8);
        r5 = " kB swap total, ";
        r0 = r43;
        r0.append(r5);
        r5 = 7;
        r8 = r38[r5];
        r0 = r43;
        r0.append(r8);
        r5 = " kB swap free\n";
        r0 = r43;
        r0.append(r5);
    L_0x0380:
        r40 = r56.getKsmInfo();
        r5 = 1;
        r8 = r40[r5];
        r14 = 0;
        r5 = (r8 > r14 ? 1 : (r8 == r14 ? 0 : -1));
        if (r5 != 0) goto L_0x03a8;
    L_0x038d:
        r5 = 0;
        r8 = r40[r5];
        r14 = 0;
        r5 = (r8 > r14 ? 1 : (r8 == r14 ? 0 : -1));
        if (r5 != 0) goto L_0x03a8;
    L_0x0396:
        r5 = 2;
        r8 = r40[r5];
        r14 = 0;
        r5 = (r8 > r14 ? 1 : (r8 == r14 ? 0 : -1));
        if (r5 != 0) goto L_0x03a8;
    L_0x039f:
        r5 = 3;
        r8 = r40[r5];
        r14 = 0;
        r5 = (r8 > r14 ? 1 : (r8 == r14 ? 0 : -1));
        if (r5 == 0) goto L_0x03f2;
    L_0x03a8:
        r5 = "  KSM: ";
        r0 = r43;
        r0.append(r5);
        r5 = 1;
        r8 = r40[r5];
        r0 = r43;
        r0.append(r8);
        r5 = " kB saved from shared ";
        r0 = r43;
        r0.append(r5);
        r5 = 0;
        r8 = r40[r5];
        r0 = r43;
        r0.append(r8);
        r5 = " kB\n";
        r0 = r43;
        r0.append(r5);
        r5 = "       ";
        r0 = r43;
        r0.append(r5);
        r5 = 2;
        r8 = r40[r5];
        r0 = r43;
        r0.append(r8);
        r5 = " kB unshared; ";
        r0 = r43;
        r0.append(r5);
        r5 = 3;
        r8 = r40[r5];
        r0 = r43;
        r0.append(r8);
        r5 = " kB volatile\n";
        r0 = r43;
        r0.append(r5);
    L_0x03f2:
        r5 = "  Free RAM: ";
        r0 = r43;
        r0.append(r5);
        r8 = r42.getCachedSizeKb();
        r8 = r8 + r30;
        r14 = r42.getFreeSizeKb();
        r8 = r8 + r14;
        r0 = r43;
        r0.append(r8);
        r5 = " kB\n";
        r0 = r43;
        r0.append(r5);
        r5 = "  Used RAM: ";
        r0 = r43;
        r0.append(r5);
        r8 = r54 - r30;
        r14 = r42.getKernelUsedSizeKb();
        r8 = r8 + r14;
        r0 = r43;
        r0.append(r8);
        r5 = " kB\n";
        r0 = r43;
        r0.append(r5);
        r5 = "  Lost RAM: ";
        r0 = r43;
        r0.append(r5);
        r8 = r42.getTotalSizeKb();
        r8 = r8 - r54;
        r14 = r42.getFreeSizeKb();
        r8 = r8 - r14;
        r14 = r42.getCachedSizeKb();
        r8 = r8 - r14;
        r14 = r42.getKernelUsedSizeKb();
        r8 = r8 - r14;
        r0 = r43;
        r0.append(r8);
        r5 = " kB\n";
        r0 = r43;
        r0.append(r5);
        r5 = "ActivityManager";
        r6 = "Low on memory:";
        android.util.Slog.i(r5, r6);
        r5 = "ActivityManager";
        r6 = r7.toString();
        android.util.Slog.i(r5, r6);
        r5 = "ActivityManager";
        r6 = r34.toString();
        android.util.Slog.i(r5, r6);
        r5 = "ActivityManager";
        r6 = r43.toString();
        android.util.Slog.i(r5, r6);
        r32 = new java.lang.StringBuilder;
        r5 = 1024; // 0x400 float:1.435E-42 double:5.06E-321;
        r0 = r32;
        r0.<init>(r5);
        r5 = "Low on memory:";
        r0 = r32;
        r0.append(r5);
        r0 = r32;
        r1 = r50;
        r0.append(r1);
        r5 = 10;
        r0 = r32;
        r0.append(r5);
        r0 = r32;
        r1 = r35;
        r0.append(r1);
        r0 = r32;
        r1 = r34;
        r0.append(r1);
        r5 = 10;
        r0 = r32;
        r0.append(r5);
        r0 = r32;
        r1 = r43;
        r0.append(r1);
        r5 = 10;
        r0 = r32;
        r0.append(r5);
        r29 = new java.io.StringWriter;
        r29.<init>();
        monitor-enter(r56);
        r16 = new com.android.internal.util.FastPrintWriter;	 Catch:{ all -> 0x053c }
        r5 = 0;
        r6 = 256; // 0x100 float:3.59E-43 double:1.265E-321;
        r0 = r16;
        r1 = r29;
        r0.<init>(r1, r5, r6);	 Catch:{ all -> 0x053c }
        r5 = 0;
        r0 = new java.lang.String[r5];	 Catch:{ all -> 0x053c }
        r17 = r0;
        r16.println();	 Catch:{ all -> 0x053c }
        r15 = 0;
        r18 = 0;
        r19 = 0;
        r20 = 0;
        r14 = r56;
        r14.dumpProcessesLocked(r15, r16, r17, r18, r19, r20);	 Catch:{ all -> 0x053c }
        r16.println();	 Catch:{ all -> 0x053c }
        r0 = r56;
        r14 = r0.mServices;	 Catch:{ all -> 0x053c }
        r15 = 0;
        r18 = 0;
        r19 = 0;
        r20 = 0;
        r21 = 0;
        r14.dumpServicesLocked(r15, r16, r17, r18, r19, r20, r21);	 Catch:{ all -> 0x053c }
        r16.println();	 Catch:{ all -> 0x053c }
        r15 = 0;
        r18 = 0;
        r19 = 0;
        r20 = 0;
        r21 = 0;
        r14 = r56;
        r14.dumpActivitiesLocked(r15, r16, r17, r18, r19, r20, r21);	 Catch:{ all -> 0x053c }
        r16.flush();	 Catch:{ all -> 0x053c }
        monitor-exit(r56);	 Catch:{ all -> 0x053c }
        r5 = r29.toString();
        r0 = r32;
        r0.append(r5);
        r19 = "lowmem";
        r20 = 0;
        r21 = "system_server";
        r22 = 0;
        r23 = 0;
        r24 = r51.toString();
        r25 = r32.toString();
        r26 = 0;
        r27 = 0;
        r18 = r56;
        r18.addErrorToDropBox(r19, r20, r21, r22, r23, r24, r25, r26, r27);
        monitor-enter(r56);
        r46 = android.os.SystemClock.uptimeMillis();	 Catch:{ all -> 0x053f }
        r0 = r56;
        r8 = r0.mLastMemUsageReportTime;	 Catch:{ all -> 0x053f }
        r5 = (r8 > r46 ? 1 : (r8 == r46 ? 0 : -1));
        if (r5 >= 0) goto L_0x053a;
    L_0x0534:
        r0 = r46;
        r2 = r56;
        r2.mLastMemUsageReportTime = r0;	 Catch:{ all -> 0x053f }
    L_0x053a:
        monitor-exit(r56);	 Catch:{ all -> 0x053f }
        return;
    L_0x053c:
        r5 = move-exception;
        monitor-exit(r56);	 Catch:{ all -> 0x053c }
        throw r5;
    L_0x053f:
        r5 = move-exception;
        monitor-exit(r56);	 Catch:{ all -> 0x053f }
        throw r5;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.ActivityManagerService.reportMemUsage(java.util.ArrayList):void");
    }

    private static boolean scanArgs(String[] args, String value) {
        if (args != null) {
            String[] arr$ = args;
            int len$ = arr$.length;
            for (int i$ = MY_PID; i$ < len$; i$ += SHOW_ERROR_MSG) {
                if (value.equals(arr$[i$])) {
                    return SHOW_ACTIVITY_START_TIME;
                }
            }
        }
        return VALIDATE_TOKENS;
    }

    private final boolean removeDyingProviderLocked(ProcessRecord proc, ContentProviderRecord cpr, boolean always) {
        boolean inLaunching = this.mLaunchingProviders.contains(cpr);
        if (!inLaunching || always) {
            synchronized (cpr) {
                cpr.launchingApp = null;
                cpr.notifyAll();
            }
            this.mProviderMap.removeProviderByClass(cpr.name, UserHandle.getUserId(cpr.uid));
            String[] names = cpr.info.authority.split(";");
            for (int j = MY_PID; j < names.length; j += SHOW_ERROR_MSG) {
                this.mProviderMap.removeProviderByName(names[j], UserHandle.getUserId(cpr.uid));
            }
        }
        for (int i = cpr.connections.size() - 1; i >= 0; i--) {
            ContentProviderConnection conn = (ContentProviderConnection) cpr.connections.get(i);
            if (!conn.waiting || !inLaunching || always) {
                ProcessRecord capp = conn.client;
                conn.dead = SHOW_ACTIVITY_START_TIME;
                if (conn.stableCount > 0) {
                    if (!(capp.persistent || capp.thread == null || capp.pid == 0 || capp.pid == MY_PID)) {
                        capp.kill("depends on provider " + cpr.name.flattenToShortString() + " in dying proc " + (proc != null ? proc.processName : "??"), SHOW_ACTIVITY_START_TIME);
                    }
                } else if (!(capp.thread == null || conn.provider.provider == null)) {
                    try {
                        capp.thread.unstableProviderDied(conn.provider.provider.asBinder());
                    } catch (RemoteException e) {
                    }
                    cpr.connections.remove(i);
                    if (conn.client.conProviders.remove(conn)) {
                        stopAssociationLocked(capp.uid, capp.processName, cpr.uid, cpr.name);
                    }
                }
            }
        }
        if (inLaunching && always) {
            this.mLaunchingProviders.remove(cpr);
        }
        return inLaunching;
    }

    private final boolean cleanUpApplicationRecordLocked(ProcessRecord app, boolean restarting, boolean allowRestart, int index) {
        int i;
        if (index >= 0) {
            removeLruProcessLocked(app);
            ProcessList.remove(app.pid);
        }
        this.mProcessesToGc.remove(app);
        this.mPendingPssProcesses.remove(app);
        if (!(app.crashDialog == null || app.forceCrashReport)) {
            app.crashDialog.dismiss();
            app.crashDialog = null;
        }
        if (app.anrDialog != null) {
            app.anrDialog.dismiss();
            app.anrDialog = null;
        }
        if (app.waitDialog != null) {
            app.waitDialog.dismiss();
            app.waitDialog = null;
        }
        app.crashing = VALIDATE_TOKENS;
        app.notResponding = VALIDATE_TOKENS;
        app.resetPackageList(this.mProcessStats);
        app.unlinkDeathRecipient();
        app.makeInactive(this.mProcessStats);
        app.waitingToKill = null;
        app.forcingToForeground = null;
        updateProcessForegroundLocked(app, VALIDATE_TOKENS, VALIDATE_TOKENS);
        app.foregroundActivities = VALIDATE_TOKENS;
        app.hasShownUi = VALIDATE_TOKENS;
        app.treatLikeActivity = VALIDATE_TOKENS;
        app.hasAboveClient = VALIDATE_TOKENS;
        app.hasClientActivities = VALIDATE_TOKENS;
        this.mServices.killServicesLocked(app, allowRestart);
        boolean restart = VALIDATE_TOKENS;
        for (i = app.pubProviders.size() - 1; i >= 0; i--) {
            ContentProviderRecord cpr = (ContentProviderRecord) app.pubProviders.valueAt(i);
            boolean always = (app.bad || !allowRestart) ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
            if ((removeDyingProviderLocked(app, cpr, always) || always) && cpr.hasConnectionOrHandle()) {
                restart = SHOW_ACTIVITY_START_TIME;
            }
            cpr.provider = null;
            cpr.proc = null;
        }
        app.pubProviders.clear();
        if (checkAppInLaunchingProvidersLocked(app, VALIDATE_TOKENS)) {
            restart = SHOW_ACTIVITY_START_TIME;
        }
        if (!app.conProviders.isEmpty()) {
            for (i = app.conProviders.size() - 1; i >= 0; i--) {
                ContentProviderConnection conn = (ContentProviderConnection) app.conProviders.get(i);
                conn.provider.connections.remove(conn);
                stopAssociationLocked(app.uid, app.processName, conn.provider.uid, conn.provider.name);
            }
            app.conProviders.clear();
        }
        skipCurrentReceiverLocked(app);
        for (i = app.receivers.size() - 1; i >= 0; i--) {
            removeReceiverLocked((ReceiverList) app.receivers.valueAt(i));
        }
        app.receivers.clear();
        if (this.mBackupTarget != null && app.pid == this.mBackupTarget.app.pid) {
            try {
                IBackupManager.Stub.asInterface(ServiceManager.getService("backup")).agentDisconnected(app.info.packageName);
            } catch (RemoteException e) {
            }
        }
        for (i = this.mPendingProcessChanges.size() - 1; i >= 0; i--) {
            ProcessChangeItem item = (ProcessChangeItem) this.mPendingProcessChanges.get(i);
            if (item.pid == app.pid) {
                this.mPendingProcessChanges.remove(i);
                this.mAvailProcessChanges.add(item);
            }
        }
        this.mHandler.obtainMessage(DISPATCH_PROCESS_DIED, app.pid, app.info.uid, null).sendToTarget();
        if (restarting) {
            return VALIDATE_TOKENS;
        }
        if (!app.persistent || app.isolated) {
            this.mProcessNames.remove(app.processName, app.uid);
            this.mIsolatedProcesses.remove(app.uid);
            if (this.mHeavyWeightProcess == app) {
                this.mHandler.sendMessage(this.mHandler.obtainMessage(CANCEL_HEAVY_NOTIFICATION_MSG, this.mHeavyWeightProcess.userId, MY_PID));
                this.mHeavyWeightProcess = null;
            }
        } else if (!app.removed && this.mPersistentStartingProcesses.indexOf(app) < 0) {
            this.mPersistentStartingProcesses.add(app);
            restart = SHOW_ACTIVITY_START_TIME;
        }
        this.mProcessesOnHold.remove(app);
        if (app == this.mHomeProcess) {
            this.mHomeProcess = null;
        }
        if (app == this.mPreviousProcess) {
            this.mPreviousProcess = null;
        }
        if (!restart || app.isolated) {
            if (app.pid > 0 && app.pid != MY_PID) {
                synchronized (this.mPidsSelfLocked) {
                    this.mPidsSelfLocked.remove(app.pid);
                    this.mHandler.removeMessages(PROC_START_TIMEOUT_MSG, app);
                }
                this.mBatteryStatsService.noteProcessFinish(app.processName, app.info.uid);
                if (app.isolated) {
                    this.mBatteryStatsService.removeIsolatedUid(app.uid, app.info.uid);
                }
                app.setPid(MY_PID);
            }
            return VALIDATE_TOKENS;
        }
        if (index < 0) {
            ProcessList.remove(app.pid);
        }
        this.mProcessNames.put(app.processName, app.uid, app);
        startProcessLocked(app, "restart", app.processName);
        return SHOW_ACTIVITY_START_TIME;
    }

    boolean checkAppInLaunchingProvidersLocked(ProcessRecord app, boolean alwaysBad) {
        boolean restart = VALIDATE_TOKENS;
        for (int i = this.mLaunchingProviders.size() - 1; i >= 0; i--) {
            ContentProviderRecord cpr = (ContentProviderRecord) this.mLaunchingProviders.get(i);
            if (cpr.launchingApp == app) {
                if (alwaysBad || app.bad || !cpr.hasConnectionOrHandle()) {
                    removeDyingProviderLocked(app, cpr, SHOW_ACTIVITY_START_TIME);
                } else {
                    restart = SHOW_ACTIVITY_START_TIME;
                }
            }
        }
        return restart;
    }

    public List<RunningServiceInfo> getServices(int maxNum, int flags) {
        List<RunningServiceInfo> runningServiceInfoLocked;
        enforceNotIsolatedCaller("getServices");
        synchronized (this) {
            runningServiceInfoLocked = this.mServices.getRunningServiceInfoLocked(maxNum, flags);
        }
        return runningServiceInfoLocked;
    }

    public PendingIntent getRunningServiceControlPanel(ComponentName name) {
        PendingIntent runningServiceControlPanelLocked;
        enforceNotIsolatedCaller("getRunningServiceControlPanel");
        synchronized (this) {
            runningServiceControlPanelLocked = this.mServices.getRunningServiceControlPanelLocked(name);
        }
        return runningServiceControlPanelLocked;
    }

    public ComponentName startService(IApplicationThread caller, Intent service, String resolvedType, int userId) {
        enforceNotIsolatedCaller("startService");
        if (service == null || service.hasFileDescriptors() != SHOW_ACTIVITY_START_TIME) {
            ComponentName res;
            synchronized (this) {
                int callingPid = Binder.getCallingPid();
                int callingUid = Binder.getCallingUid();
                long origId = Binder.clearCallingIdentity();
                res = this.mServices.startServiceLocked(caller, service, resolvedType, callingPid, callingUid, userId);
                Binder.restoreCallingIdentity(origId);
            }
            return res;
        }
        throw new IllegalArgumentException("File descriptors passed in Intent");
    }

    ComponentName startServiceInPackage(int uid, Intent service, String resolvedType, int userId) {
        ComponentName res;
        synchronized (this) {
            long origId = Binder.clearCallingIdentity();
            res = this.mServices.startServiceLocked(null, service, resolvedType, -1, uid, userId);
            Binder.restoreCallingIdentity(origId);
        }
        return res;
    }

    public int stopService(IApplicationThread caller, Intent service, String resolvedType, int userId) {
        enforceNotIsolatedCaller("stopService");
        if (service == null || service.hasFileDescriptors() != SHOW_ACTIVITY_START_TIME) {
            int stopServiceLocked;
            synchronized (this) {
                stopServiceLocked = this.mServices.stopServiceLocked(caller, service, resolvedType, userId);
            }
            return stopServiceLocked;
        }
        throw new IllegalArgumentException("File descriptors passed in Intent");
    }

    public IBinder peekService(Intent service, String resolvedType) {
        enforceNotIsolatedCaller("peekService");
        if (service == null || service.hasFileDescriptors() != SHOW_ACTIVITY_START_TIME) {
            IBinder peekServiceLocked;
            synchronized (this) {
                peekServiceLocked = this.mServices.peekServiceLocked(service, resolvedType);
            }
            return peekServiceLocked;
        }
        throw new IllegalArgumentException("File descriptors passed in Intent");
    }

    public boolean stopServiceToken(ComponentName className, IBinder token, int startId) {
        boolean stopServiceTokenLocked;
        synchronized (this) {
            stopServiceTokenLocked = this.mServices.stopServiceTokenLocked(className, token, startId);
        }
        return stopServiceTokenLocked;
    }

    public void setServiceForeground(ComponentName className, IBinder token, int id, Notification notification, boolean removeNotification) {
        synchronized (this) {
            this.mServices.setServiceForegroundLocked(className, token, id, notification, removeNotification);
        }
    }

    public int handleIncomingUser(int callingPid, int callingUid, int userId, boolean allowAll, boolean requireFull, String name, String callerPackage) {
        return handleIncomingUser(callingPid, callingUid, userId, allowAll, requireFull ? SHOW_NOT_RESPONDING_MSG : MY_PID, name, callerPackage);
    }

    int unsafeConvertIncomingUser(int userId) {
        return (userId == -2 || userId == -3) ? this.mCurrentUserId : userId;
    }

    int handleIncomingUser(int callingPid, int callingUid, int userId, boolean allowAll, int allowMode, String name, String callerPackage) {
        int callingUserId = UserHandle.getUserId(callingUid);
        if (callingUserId == userId) {
            return userId;
        }
        int targetUserId = unsafeConvertIncomingUser(userId);
        if (!(callingUid == 0 || callingUid == NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY)) {
            boolean allow;
            if (checkComponentPermission("android.permission.INTERACT_ACROSS_USERS_FULL", callingPid, callingUid, -1, SHOW_ACTIVITY_START_TIME) == 0) {
                allow = SHOW_ACTIVITY_START_TIME;
            } else if (allowMode == SHOW_NOT_RESPONDING_MSG) {
                allow = VALIDATE_TOKENS;
            } else if (checkComponentPermission("android.permission.INTERACT_ACROSS_USERS", callingPid, callingUid, -1, SHOW_ACTIVITY_START_TIME) != 0) {
                allow = VALIDATE_TOKENS;
            } else if (allowMode == 0) {
                allow = SHOW_ACTIVITY_START_TIME;
            } else if (allowMode == SHOW_ERROR_MSG) {
                synchronized (this.mUserProfileGroupIdsSelfLocked) {
                    int callingProfile = this.mUserProfileGroupIdsSelfLocked.get(callingUserId, -1);
                    allow = (callingProfile == -1 || callingProfile != this.mUserProfileGroupIdsSelfLocked.get(targetUserId, -1)) ? VALIDATE_TOKENS : SHOW_ACTIVITY_START_TIME;
                }
            } else {
                throw new IllegalArgumentException("Unknown mode: " + allowMode);
            }
            if (!allow) {
                if (userId == -3) {
                    targetUserId = callingUserId;
                } else {
                    StringBuilder builder = new StringBuilder(MAX_PERSISTED_URI_GRANTS);
                    builder.append("Permission Denial: ");
                    builder.append(name);
                    if (callerPackage != null) {
                        builder.append(" from ");
                        builder.append(callerPackage);
                    }
                    builder.append(" asks to run as user ");
                    builder.append(userId);
                    builder.append(" but is calling from user ");
                    builder.append(UserHandle.getUserId(callingUid));
                    builder.append("; this requires ");
                    builder.append("android.permission.INTERACT_ACROSS_USERS_FULL");
                    if (allowMode != SHOW_NOT_RESPONDING_MSG) {
                        builder.append(" or ");
                        builder.append("android.permission.INTERACT_ACROSS_USERS");
                    }
                    String msg = builder.toString();
                    Slog.w(TAG, msg);
                    throw new SecurityException(msg);
                }
            }
        }
        if (!allowAll && targetUserId < 0) {
            throw new IllegalArgumentException("Call does not support special user #" + targetUserId);
        } else if (callingUid != USER_SWITCH_TIMEOUT || targetUserId < 0 || !this.mUserManager.hasUserRestriction("no_debugging_features", targetUserId)) {
            return targetUserId;
        } else {
            throw new SecurityException("Shell does not have permission to access user " + targetUserId + "\n " + Debug.getCallers(SHOW_FACTORY_ERROR_MSG));
        }
    }

    boolean isSingleton(String componentProcessName, ApplicationInfo aInfo, String className, int flags) {
        if (UserHandle.getAppId(aInfo.uid) >= PROC_START_TIMEOUT) {
            if ((flags & 1073741824) == 0) {
                return VALIDATE_TOKENS;
            }
            if (ActivityManager.checkUidPermission("android.permission.INTERACT_ACROSS_USERS", aInfo.uid) == 0) {
                return SHOW_ACTIVITY_START_TIME;
            }
            String msg = "Permission Denial: Component " + new ComponentName(aInfo.packageName, className).flattenToShortString() + " requests FLAG_SINGLE_USER, but app does not hold " + "android.permission.INTERACT_ACROSS_USERS";
            Slog.w(TAG, msg);
            throw new SecurityException(msg);
        } else if ("system".equals(componentProcessName)) {
            return SHOW_ACTIVITY_START_TIME;
        } else {
            if ((flags & 1073741824) == 0) {
                return VALIDATE_TOKENS;
            }
            boolean result = (UserHandle.isSameApp(aInfo.uid, 1001) || (aInfo.flags & 8) != 0) ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
            return result;
        }
    }

    boolean isValidSingletonCall(int callingUid, int componentUid) {
        int componentAppId = UserHandle.getAppId(componentUid);
        return (UserHandle.isSameApp(callingUid, componentUid) || componentAppId == NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY || componentAppId == 1001 || ActivityManager.checkUidPermission("android.permission.INTERACT_ACROSS_USERS_FULL", componentUid) == 0) ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
    }

    public int bindService(IApplicationThread caller, IBinder token, Intent service, String resolvedType, IServiceConnection connection, int flags, int userId) {
        enforceNotIsolatedCaller("bindService");
        if (service == null || service.hasFileDescriptors() != SHOW_ACTIVITY_START_TIME) {
            int bindServiceLocked;
            synchronized (this) {
                bindServiceLocked = this.mServices.bindServiceLocked(caller, token, service, resolvedType, connection, flags, userId);
            }
            return bindServiceLocked;
        }
        throw new IllegalArgumentException("File descriptors passed in Intent");
    }

    public boolean unbindService(IServiceConnection connection) {
        boolean unbindServiceLocked;
        synchronized (this) {
            unbindServiceLocked = this.mServices.unbindServiceLocked(connection);
        }
        return unbindServiceLocked;
    }

    public void publishService(IBinder token, Intent intent, IBinder service) {
        if (intent == null || intent.hasFileDescriptors() != SHOW_ACTIVITY_START_TIME) {
            synchronized (this) {
                if (token instanceof ServiceRecord) {
                    this.mServices.publishServiceLocked((ServiceRecord) token, intent, service);
                } else {
                    throw new IllegalArgumentException("Invalid service token");
                }
            }
            return;
        }
        throw new IllegalArgumentException("File descriptors passed in Intent");
    }

    public void unbindFinished(IBinder token, Intent intent, boolean doRebind) {
        if (intent == null || intent.hasFileDescriptors() != SHOW_ACTIVITY_START_TIME) {
            synchronized (this) {
                this.mServices.unbindFinishedLocked((ServiceRecord) token, intent, doRebind);
            }
            return;
        }
        throw new IllegalArgumentException("File descriptors passed in Intent");
    }

    public void serviceDoneExecuting(IBinder token, int type, int startId, int res) {
        synchronized (this) {
            if (token instanceof ServiceRecord) {
                this.mServices.serviceDoneExecutingLocked((ServiceRecord) token, type, startId, res);
            } else {
                Slog.e(TAG, "serviceDoneExecuting: Invalid service token=" + token);
                throw new IllegalArgumentException("Invalid service token");
            }
        }
    }

    public boolean bindBackupAgent(ApplicationInfo app, int backupMode) {
        enforceCallingPermission("android.permission.CONFIRM_FULL_BACKUP", "bindBackupAgent");
        synchronized (this) {
            Serv ss;
            ComponentName hostingName;
            BatteryStatsImpl stats = this.mBatteryStatsService.getActiveStatistics();
            synchronized (stats) {
                ss = stats.getServiceStatsLocked(app.uid, app.packageName, app.name);
            }
            try {
                AppGlobals.getPackageManager().setPackageStoppedState(app.packageName, VALIDATE_TOKENS, UserHandle.getUserId(app.uid));
            } catch (RemoteException e) {
            } catch (IllegalArgumentException e2) {
                Slog.w(TAG, "Failed trying to unstop package " + app.packageName + ": " + e2);
            }
            BackupRecord r = new BackupRecord(ss, app, backupMode);
            if (backupMode == 0) {
                hostingName = new ComponentName(app.packageName, app.backupAgentName);
            } else {
                hostingName = new ComponentName("android", "FullBackupAgent");
            }
            ProcessRecord proc = startProcessLocked(app.processName, app, VALIDATE_TOKENS, MY_PID, "backup", hostingName, VALIDATE_TOKENS, VALIDATE_TOKENS, VALIDATE_TOKENS);
            if (proc == null) {
                Slog.e(TAG, "Unable to start backup agent process " + r);
                return VALIDATE_TOKENS;
            }
            r.app = proc;
            this.mBackupTarget = r;
            this.mBackupAppName = app.packageName;
            updateOomAdjLocked(proc);
            if (proc.thread != null) {
                try {
                    proc.thread.scheduleCreateBackupAgent(app, compatibilityInfoForPackageLocked(app), backupMode);
                } catch (RemoteException e3) {
                }
            }
            return SHOW_ACTIVITY_START_TIME;
        }
    }

    public void clearPendingBackup() {
        enforceCallingPermission("android.permission.BACKUP", "clearPendingBackup");
        synchronized (this) {
            this.mBackupTarget = null;
            this.mBackupAppName = null;
        }
    }

    public void backupAgentCreated(String agentPackageName, IBinder agent) {
        synchronized (this) {
            if (agentPackageName.equals(this.mBackupAppName)) {
                long oldIdent = Binder.clearCallingIdentity();
                try {
                    IBackupManager.Stub.asInterface(ServiceManager.getService("backup")).agentConnected(agentPackageName, agent);
                } catch (RemoteException e) {
                } catch (Exception e2) {
                    Slog.w(TAG, "Exception trying to deliver BackupAgent binding: ");
                    e2.printStackTrace();
                } finally {
                    Binder.restoreCallingIdentity(oldIdent);
                }
            } else {
                Slog.e(TAG, "Backup agent created for " + agentPackageName + " but not requested!");
            }
        }
    }

    public void unbindBackupAgent(ApplicationInfo appInfo) {
        if (appInfo == null) {
            Slog.w(TAG, "unbind backup agent for null app");
            return;
        }
        synchronized (this) {
            try {
                if (this.mBackupAppName == null) {
                    Slog.w(TAG, "Unbinding backup agent with no active backup");
                    this.mBackupTarget = null;
                    this.mBackupAppName = null;
                    return;
                } else if (this.mBackupAppName.equals(appInfo.packageName)) {
                    ProcessRecord proc = this.mBackupTarget.app;
                    updateOomAdjLocked(proc);
                    if (proc.thread != null) {
                        proc.thread.scheduleDestroyBackupAgent(appInfo, compatibilityInfoForPackageLocked(appInfo));
                    }
                    this.mBackupTarget = null;
                    this.mBackupAppName = null;
                    return;
                } else {
                    Slog.e(TAG, "Unbind of " + appInfo + " but is not the current backup target");
                    this.mBackupTarget = null;
                    this.mBackupAppName = null;
                    return;
                }
            } catch (Exception e) {
                Slog.e(TAG, "Exception when unbinding backup agent:");
                e.printStackTrace();
            } catch (Throwable th) {
                this.mBackupTarget = null;
                this.mBackupAppName = null;
            }
        }
    }

    private final List getStickiesLocked(String action, IntentFilter filter, List cur, int userId) {
        ContentResolver resolver = this.mContext.getContentResolver();
        ArrayMap<String, ArrayList<Intent>> stickies = (ArrayMap) this.mStickyBroadcasts.get(userId);
        if (stickies == null) {
            return cur;
        }
        ArrayList<Intent> list = (ArrayList) stickies.get(action);
        if (list == null) {
            return cur;
        }
        int N = list.size();
        for (int i = MY_PID; i < N; i += SHOW_ERROR_MSG) {
            Intent intent = (Intent) list.get(i);
            if (filter.match(resolver, intent, SHOW_ACTIVITY_START_TIME, TAG) >= 0) {
                if (cur == null) {
                    cur = new ArrayList();
                }
                cur.add(intent);
            }
        }
        return cur;
    }

    boolean isPendingBroadcastProcessLocked(int pid) {
        return (this.mFgBroadcastQueue.isPendingBroadcastProcessLocked(pid) || this.mBgBroadcastQueue.isPendingBroadcastProcessLocked(pid)) ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
    }

    void skipPendingBroadcastLocked(int pid) {
        Slog.w(TAG, "Unattached app died before broadcast acknowledged, skipping");
        BroadcastQueue[] arr$ = this.mBroadcastQueues;
        int len$ = arr$.length;
        for (int i$ = MY_PID; i$ < len$; i$ += SHOW_ERROR_MSG) {
            arr$[i$].skipPendingBroadcastLocked(pid);
        }
    }

    boolean sendPendingBroadcastsLocked(ProcessRecord app) {
        boolean didSomething = VALIDATE_TOKENS;
        BroadcastQueue[] arr$ = this.mBroadcastQueues;
        int len$ = arr$.length;
        for (int i$ = MY_PID; i$ < len$; i$ += SHOW_ERROR_MSG) {
            didSomething |= arr$[i$].sendPendingBroadcastsLocked(app);
        }
        return didSomething;
    }

    public Intent registerReceiver(IApplicationThread caller, String callerPackage, IIntentReceiver receiver, IntentFilter filter, String permission, int userId) {
        Intent sticky;
        enforceNotIsolatedCaller("registerReceiver");
        synchronized (this) {
            ProcessRecord callerApp = null;
            int callingUid;
            int callingPid;
            List allSticky;
            Iterator actions;
            ReceiverList rl;
            BroadcastFilter bf;
            ArrayList receivers;
            int N;
            int i;
            if (caller != null) {
                callerApp = getRecordForAppLocked(caller);
                if (callerApp == null) {
                    throw new SecurityException("Unable to find app for caller " + caller + " (pid=" + Binder.getCallingPid() + ") when registering receiver " + receiver);
                } else if (callerApp.info.uid == NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY || callerApp.pkgList.containsKey(callerPackage) || "android".equals(callerPackage)) {
                    callingUid = callerApp.info.uid;
                    callingPid = callerApp.pid;
                    userId = handleIncomingUser(callingPid, callingUid, userId, (boolean) SHOW_ACTIVITY_START_TIME, (int) SHOW_NOT_RESPONDING_MSG, "registerReceiver", callerPackage);
                    allSticky = null;
                    actions = filter.actionsIterator();
                    if (actions == null) {
                        while (actions.hasNext()) {
                            String action = (String) actions.next();
                            allSticky = getStickiesLocked(action, filter, getStickiesLocked(action, filter, allSticky, -1), UserHandle.getUserId(callingUid));
                        }
                    } else {
                        allSticky = getStickiesLocked(null, filter, getStickiesLocked(null, filter, null, -1), UserHandle.getUserId(callingUid));
                    }
                    sticky = allSticky == null ? (Intent) allSticky.get(MY_PID) : null;
                    if (receiver != null) {
                    } else {
                        rl = (ReceiverList) this.mRegisteredReceivers.get(receiver.asBinder());
                        if (rl == null) {
                            rl = new ReceiverList(this, callerApp, callingPid, callingUid, userId, receiver);
                            if (rl.app == null) {
                                rl.app.receivers.add(rl);
                            } else {
                                try {
                                    receiver.asBinder().linkToDeath(rl, MY_PID);
                                    rl.linkedToDeath = SHOW_ACTIVITY_START_TIME;
                                } catch (RemoteException e) {
                                }
                            }
                            this.mRegisteredReceivers.put(receiver.asBinder(), rl);
                        } else if (rl.uid != callingUid) {
                            throw new IllegalArgumentException("Receiver requested to register for uid " + callingUid + " was previously registered for uid " + rl.uid);
                        } else if (rl.pid != callingPid) {
                            throw new IllegalArgumentException("Receiver requested to register for pid " + callingPid + " was previously registered for pid " + rl.pid);
                        } else if (rl.userId != userId) {
                            throw new IllegalArgumentException("Receiver requested to register for user " + userId + " was previously registered for user " + rl.userId);
                        }
                        bf = new BroadcastFilter(filter, rl, callerPackage, permission, callingUid, userId);
                        rl.add(bf);
                        if (!bf.debugCheck()) {
                            Slog.w(TAG, "==> For Dynamic broadast");
                        }
                        this.mReceiverResolver.addFilter(bf);
                        if (allSticky != null) {
                            receivers = new ArrayList();
                            receivers.add(bf);
                            N = allSticky.size();
                            for (i = MY_PID; i < N; i += SHOW_ERROR_MSG) {
                                Intent intent = (Intent) allSticky.get(i);
                                BroadcastQueue queue = broadcastQueueForIntent(intent);
                                queue.enqueueParallelBroadcastLocked(new BroadcastRecord(queue, intent, null, null, -1, -1, null, null, -1, receivers, null, MY_PID, null, null, VALIDATE_TOKENS, SHOW_ACTIVITY_START_TIME, SHOW_ACTIVITY_START_TIME, -1));
                                queue.scheduleBroadcastsLocked();
                            }
                        }
                    }
                } else {
                    throw new SecurityException("Given caller package " + callerPackage + " is not running in process " + callerApp);
                }
            }
            callerPackage = null;
            callingUid = Binder.getCallingUid();
            callingPid = Binder.getCallingPid();
            userId = handleIncomingUser(callingPid, callingUid, userId, (boolean) SHOW_ACTIVITY_START_TIME, (int) SHOW_NOT_RESPONDING_MSG, "registerReceiver", callerPackage);
            allSticky = null;
            actions = filter.actionsIterator();
            if (actions == null) {
                allSticky = getStickiesLocked(null, filter, getStickiesLocked(null, filter, null, -1), UserHandle.getUserId(callingUid));
            } else {
                while (actions.hasNext()) {
                    String action2 = (String) actions.next();
                    allSticky = getStickiesLocked(action2, filter, getStickiesLocked(action2, filter, allSticky, -1), UserHandle.getUserId(callingUid));
                }
            }
            if (allSticky == null) {
            }
            if (receiver != null) {
                rl = (ReceiverList) this.mRegisteredReceivers.get(receiver.asBinder());
                if (rl == null) {
                    rl = new ReceiverList(this, callerApp, callingPid, callingUid, userId, receiver);
                    if (rl.app == null) {
                        receiver.asBinder().linkToDeath(rl, MY_PID);
                        rl.linkedToDeath = SHOW_ACTIVITY_START_TIME;
                    } else {
                        rl.app.receivers.add(rl);
                    }
                    this.mRegisteredReceivers.put(receiver.asBinder(), rl);
                } else if (rl.uid != callingUid) {
                    throw new IllegalArgumentException("Receiver requested to register for uid " + callingUid + " was previously registered for uid " + rl.uid);
                } else if (rl.pid != callingPid) {
                    throw new IllegalArgumentException("Receiver requested to register for pid " + callingPid + " was previously registered for pid " + rl.pid);
                } else if (rl.userId != userId) {
                    throw new IllegalArgumentException("Receiver requested to register for user " + userId + " was previously registered for user " + rl.userId);
                }
                bf = new BroadcastFilter(filter, rl, callerPackage, permission, callingUid, userId);
                rl.add(bf);
                if (bf.debugCheck()) {
                    Slog.w(TAG, "==> For Dynamic broadast");
                }
                this.mReceiverResolver.addFilter(bf);
                if (allSticky != null) {
                    receivers = new ArrayList();
                    receivers.add(bf);
                    N = allSticky.size();
                    for (i = MY_PID; i < N; i += SHOW_ERROR_MSG) {
                        Intent intent2 = (Intent) allSticky.get(i);
                        BroadcastQueue queue2 = broadcastQueueForIntent(intent2);
                        queue2.enqueueParallelBroadcastLocked(new BroadcastRecord(queue2, intent2, null, null, -1, -1, null, null, -1, receivers, null, MY_PID, null, null, VALIDATE_TOKENS, SHOW_ACTIVITY_START_TIME, SHOW_ACTIVITY_START_TIME, -1));
                        queue2.scheduleBroadcastsLocked();
                    }
                }
            }
        }
        return sticky;
    }

    public void unregisterReceiver(IIntentReceiver receiver) {
        long origId = Binder.clearCallingIdentity();
        boolean doTrim = VALIDATE_TOKENS;
        try {
            synchronized (this) {
                ReceiverList rl = (ReceiverList) this.mRegisteredReceivers.get(receiver.asBinder());
                if (rl != null) {
                    if (rl.curBroadcast != null) {
                        BroadcastRecord r = rl.curBroadcast;
                        if (finishReceiverLocked(receiver.asBinder(), r.resultCode, r.resultData, r.resultExtras, r.resultAbort)) {
                            doTrim = SHOW_ACTIVITY_START_TIME;
                            r.queue.processNextBroadcast(VALIDATE_TOKENS);
                        }
                    }
                    if (rl.app != null) {
                        rl.app.receivers.remove(rl);
                    }
                    removeReceiverLocked(rl);
                    if (rl.linkedToDeath) {
                        rl.linkedToDeath = VALIDATE_TOKENS;
                        rl.receiver.asBinder().unlinkToDeath(rl, MY_PID);
                    }
                }
            }
            if (doTrim) {
                trimApplications();
            } else {
                Binder.restoreCallingIdentity(origId);
            }
        } finally {
            Binder.restoreCallingIdentity(origId);
        }
    }

    void removeReceiverLocked(ReceiverList rl) {
        this.mRegisteredReceivers.remove(rl.receiver.asBinder());
        int N = rl.size();
        for (int i = MY_PID; i < N; i += SHOW_ERROR_MSG) {
            this.mReceiverResolver.removeFilter((IntentFilter) rl.get(i));
        }
    }

    private final void sendPackageBroadcastLocked(int cmd, String[] packages, int userId) {
        for (int i = this.mLruProcesses.size() - 1; i >= 0; i--) {
            ProcessRecord r = (ProcessRecord) this.mLruProcesses.get(i);
            if (r.thread != null && (userId == -1 || r.userId == userId)) {
                try {
                    r.thread.dispatchPackageBroadcast(cmd, packages);
                } catch (RemoteException e) {
                }
            }
        }
    }

    private List<ResolveInfo> collectReceiverComponents(Intent intent, String resolvedType, int callingUid, int[] users) {
        List<ResolveInfo> receivers = null;
        HashSet<ComponentName> singleUserReceivers = null;
        boolean scannedFirstReceivers = VALIDATE_TOKENS;
        int[] arr$ = users;
        int len$ = arr$.length;
        for (int i$ = MY_PID; i$ < len$; i$ += SHOW_ERROR_MSG) {
            int user = arr$[i$];
            if (callingUid != USER_SWITCH_TIMEOUT || !getUserManagerLocked().hasUserRestriction("no_debugging_features", user)) {
                int i;
                List<ResolveInfo> newReceivers = AppGlobals.getPackageManager().queryIntentReceivers(intent, resolvedType, STOCK_PM_FLAGS, user);
                if (!(user == 0 || newReceivers == null)) {
                    i = MY_PID;
                    while (i < newReceivers.size()) {
                        if ((((ResolveInfo) newReceivers.get(i)).activityInfo.flags & 536870912) != 0) {
                            newReceivers.remove(i);
                            i--;
                        }
                        i += SHOW_ERROR_MSG;
                    }
                }
                if (newReceivers != null && newReceivers.size() == 0) {
                    newReceivers = null;
                }
                if (receivers == null) {
                    receivers = newReceivers;
                } else if (newReceivers == null) {
                    continue;
                } else {
                    HashSet<ComponentName> singleUserReceivers2;
                    ResolveInfo ri;
                    ComponentName cn;
                    if (!scannedFirstReceivers) {
                        scannedFirstReceivers = SHOW_ACTIVITY_START_TIME;
                        i = MY_PID;
                        singleUserReceivers2 = singleUserReceivers;
                        while (i < receivers.size()) {
                            ri = (ResolveInfo) receivers.get(i);
                            if ((ri.activityInfo.flags & 1073741824) != 0) {
                                cn = new ComponentName(ri.activityInfo.packageName, ri.activityInfo.name);
                                if (singleUserReceivers2 == null) {
                                    singleUserReceivers = new HashSet();
                                } else {
                                    singleUserReceivers = singleUserReceivers2;
                                }
                                singleUserReceivers.add(cn);
                            } else {
                                singleUserReceivers = singleUserReceivers2;
                            }
                            i += SHOW_ERROR_MSG;
                            singleUserReceivers2 = singleUserReceivers;
                        }
                        singleUserReceivers = singleUserReceivers2;
                    }
                    i = MY_PID;
                    singleUserReceivers2 = singleUserReceivers;
                    while (i < newReceivers.size()) {
                        ri = (ResolveInfo) newReceivers.get(i);
                        if ((ri.activityInfo.flags & 1073741824) != 0) {
                            cn = new ComponentName(ri.activityInfo.packageName, ri.activityInfo.name);
                            if (singleUserReceivers2 == null) {
                                singleUserReceivers = new HashSet();
                            } else {
                                singleUserReceivers = singleUserReceivers2;
                            }
                            try {
                                if (!singleUserReceivers.contains(cn)) {
                                    singleUserReceivers.add(cn);
                                    receivers.add(ri);
                                }
                            } catch (RemoteException e) {
                            }
                        } else {
                            try {
                                receivers.add(ri);
                                singleUserReceivers = singleUserReceivers2;
                            } catch (RemoteException e2) {
                                singleUserReceivers = singleUserReceivers2;
                            }
                        }
                        i += SHOW_ERROR_MSG;
                        singleUserReceivers2 = singleUserReceivers;
                    }
                    singleUserReceivers = singleUserReceivers2;
                }
            }
        }
        return receivers;
    }

    private final int broadcastIntentLocked(ProcessRecord callerApp, String callerPackage, Intent intent, String resolvedType, IIntentReceiver resultTo, int resultCode, String resultData, Bundle map, String requiredPermission, int appOp, boolean ordered, boolean sticky, int callingPid, int callingUid, int userId) {
        Intent intent2 = new Intent(intent);
        intent2.addFlags(16);
        if (!(resultTo == null || ordered)) {
            Slog.w(TAG, "Broadcast " + intent2 + " not ordered but result callback requested!");
        }
        userId = handleIncomingUser(callingPid, callingUid, userId, (boolean) SHOW_ACTIVITY_START_TIME, (int) MY_PID, "broadcast", callerPackage);
        if (userId == -1 || isUserRunningLocked(userId, VALIDATE_TOKENS) || ((callingUid == NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY && (intent2.getFlags() & 33554432) != 0) || "android.intent.action.ACTION_SHUTDOWN".equals(intent2.getAction()))) {
            String msg;
            int i;
            Uri data;
            int[] users;
            BroadcastQueue queue;
            boolean replaced;
            int callingAppId = UserHandle.getAppId(callingUid);
            if (!(callingAppId == NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY || callingAppId == 1001 || callingAppId == USER_SWITCH_TIMEOUT || callingAppId == 1002 || callingAppId == 1027 || callingUid == 0 || (callerApp != null && callerApp.persistent))) {
                try {
                    if (AppGlobals.getPackageManager().isProtectedBroadcast(intent2.getAction())) {
                        msg = "Permission Denial: not allowed to send broadcast " + intent2.getAction() + " from pid=" + callingPid + ", uid=" + callingUid;
                        Slog.w(TAG, msg);
                        throw new SecurityException(msg);
                    } else if ("android.appwidget.action.APPWIDGET_CONFIGURE".equals(intent2.getAction())) {
                        if (callerApp == null) {
                            msg = "Permission Denial: not allowed to send broadcast " + intent2.getAction() + " from unknown caller.";
                            Slog.w(TAG, msg);
                            throw new SecurityException(msg);
                        } else if (intent2.getComponent() == null) {
                            intent2.setPackage(callerApp.info.packageName);
                        } else if (!intent2.getComponent().getPackageName().equals(callerApp.info.packageName)) {
                            msg = "Permission Denial: not allowed to send broadcast " + intent2.getAction() + " to " + intent2.getComponent().getPackageName() + " from " + callerApp.info.packageName;
                            Slog.w(TAG, msg);
                            throw new SecurityException(msg);
                        }
                    }
                } catch (Throwable e) {
                    Slog.w(TAG, "Remote exception", e);
                    return MY_PID;
                }
            }
            String action = intent2.getAction();
            if (action != null) {
                Object obj = -1;
                switch (action.hashCode()) {
                    case -2074848843:
                        if (action.equals("android.intent.action.CLEAR_DNS_CACHE")) {
                            obj = 8;
                            break;
                        }
                        break;
                    case -1749672628:
                        if (action.equals("android.intent.action.UID_REMOVED")) {
                            obj = null;
                            break;
                        }
                        break;
                    case -1403934493:
                        if (action.equals("android.intent.action.EXTERNAL_APPLICATIONS_UNAVAILABLE")) {
                            obj = SHOW_FACTORY_ERROR_MSG;
                            break;
                        }
                        break;
                    case -1338021860:
                        if (action.equals("android.intent.action.EXTERNAL_APPLICATIONS_AVAILABLE")) {
                            obj = UPDATE_CONFIGURATION_MSG;
                            break;
                        }
                        break;
                    case 172491798:
                        if (action.equals("android.intent.action.PACKAGE_CHANGED")) {
                            obj = SHOW_NOT_RESPONDING_MSG;
                            break;
                        }
                        break;
                    case 183904262:
                        if (action.equals("android.intent.action.PROXY_CHANGE")) {
                            obj = 9;
                            break;
                        }
                        break;
                    case 502473491:
                        if (action.equals("android.intent.action.TIMEZONE_CHANGED")) {
                            obj = WAIT_FOR_DEBUGGER_MSG;
                            break;
                        }
                        break;
                    case 505380757:
                        if (action.equals("android.intent.action.TIME_SET")) {
                            obj = 7;
                            break;
                        }
                        break;
                    case 525384130:
                        if (action.equals("android.intent.action.PACKAGE_REMOVED")) {
                            obj = SHOW_ERROR_MSG;
                            break;
                        }
                        break;
                    case 1544582882:
                        if (action.equals("android.intent.action.PACKAGE_ADDED")) {
                            obj = GC_BACKGROUND_PROCESSES_MSG;
                            break;
                        }
                        break;
                }
                String ssp;
                switch (obj) {
                    case MY_PID:
                    case SHOW_ERROR_MSG /*1*/:
                    case SHOW_NOT_RESPONDING_MSG /*2*/:
                    case SHOW_FACTORY_ERROR_MSG /*3*/:
                    case UPDATE_CONFIGURATION_MSG /*4*/:
                        if (checkComponentPermission("android.permission.BROADCAST_PACKAGE_REMOVED", callingPid, callingUid, -1, SHOW_ACTIVITY_START_TIME) == 0) {
                            obj = -1;
                            switch (action.hashCode()) {
                                case -1749672628:
                                    if (action.equals("android.intent.action.UID_REMOVED")) {
                                        obj = null;
                                        break;
                                    }
                                    break;
                                case -1403934493:
                                    if (action.equals("android.intent.action.EXTERNAL_APPLICATIONS_UNAVAILABLE")) {
                                        obj = SHOW_ERROR_MSG;
                                        break;
                                    }
                                    break;
                                case -1338021860:
                                    if (action.equals("android.intent.action.EXTERNAL_APPLICATIONS_AVAILABLE")) {
                                        obj = SHOW_NOT_RESPONDING_MSG;
                                        break;
                                    }
                                    break;
                                case 172491798:
                                    if (action.equals("android.intent.action.PACKAGE_CHANGED")) {
                                        obj = UPDATE_CONFIGURATION_MSG;
                                        break;
                                    }
                                    break;
                                case 525384130:
                                    if (action.equals("android.intent.action.PACKAGE_REMOVED")) {
                                        obj = SHOW_FACTORY_ERROR_MSG;
                                        break;
                                    }
                                    break;
                            }
                            switch (obj) {
                                case MY_PID:
                                    Bundle intentExtras = intent2.getExtras();
                                    int uid = intentExtras != null ? intentExtras.getInt("android.intent.extra.UID") : -1;
                                    if (uid >= 0) {
                                        BatteryStatsImpl bs = this.mBatteryStatsService.getActiveStatistics();
                                        synchronized (bs) {
                                            bs.removeUidStatsLocked(uid);
                                            break;
                                        }
                                        this.mAppOpsService.uidRemoved(uid);
                                        break;
                                    }
                                    break;
                                case SHOW_ERROR_MSG /*1*/:
                                    String[] list = intent2.getStringArrayExtra("android.intent.extra.changed_package_list");
                                    if (list != null && list.length > 0) {
                                        for (i = MY_PID; i < list.length; i += SHOW_ERROR_MSG) {
                                            forceStopPackageLocked(list[i], -1, VALIDATE_TOKENS, SHOW_ACTIVITY_START_TIME, SHOW_ACTIVITY_START_TIME, VALIDATE_TOKENS, VALIDATE_TOKENS, userId, "storage unmount");
                                        }
                                        cleanupRecentTasksLocked(-1);
                                        sendPackageBroadcastLocked(SHOW_ERROR_MSG, list, userId);
                                        break;
                                    }
                                case SHOW_NOT_RESPONDING_MSG /*2*/:
                                    cleanupRecentTasksLocked(-1);
                                    break;
                                case SHOW_FACTORY_ERROR_MSG /*3*/:
                                case UPDATE_CONFIGURATION_MSG /*4*/:
                                    data = intent2.getData();
                                    if (data != null) {
                                        ssp = data.getSchemeSpecificPart();
                                        if (ssp != null) {
                                            boolean removed = "android.intent.action.PACKAGE_REMOVED".equals(action);
                                            boolean fullUninstall = (!removed || intent2.getBooleanExtra("android.intent.extra.REPLACING", VALIDATE_TOKENS)) ? VALIDATE_TOKENS : SHOW_ACTIVITY_START_TIME;
                                            if (!intent2.getBooleanExtra("android.intent.extra.DONT_KILL_APP", VALIDATE_TOKENS)) {
                                                forceStopPackageLocked(ssp, UserHandle.getAppId(intent2.getIntExtra("android.intent.extra.UID", -1)), VALIDATE_TOKENS, SHOW_ACTIVITY_START_TIME, SHOW_ACTIVITY_START_TIME, VALIDATE_TOKENS, fullUninstall, userId, removed ? "pkg removed" : "pkg changed");
                                            }
                                            if (!removed) {
                                                removeTasksByRemovedPackageComponentsLocked(ssp, userId);
                                                if (userId == 0) {
                                                    this.mTaskPersister.addOtherDeviceTasksToRecentsLocked(ssp);
                                                    break;
                                                }
                                            }
                                            String[] strArr = new String[SHOW_ERROR_MSG];
                                            strArr[MY_PID] = ssp;
                                            sendPackageBroadcastLocked(MY_PID, strArr, userId);
                                            if (fullUninstall) {
                                                this.mAppOpsService.packageRemoved(intent2.getIntExtra("android.intent.extra.UID", -1), ssp);
                                                removeUriPermissionsForPackageLocked(ssp, userId, SHOW_ACTIVITY_START_TIME);
                                                removeTasksByPackageNameLocked(ssp, userId);
                                                if (userId == 0) {
                                                    this.mTaskPersister.removeFromPackageCache(ssp);
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                    break;
                                default:
                                    break;
                            }
                        }
                        msg = "Permission Denial: " + intent2.getAction() + " broadcast from " + callerPackage + " (pid=" + callingPid + ", uid=" + callingUid + ")" + " requires " + "android.permission.BROADCAST_PACKAGE_REMOVED";
                        Slog.w(TAG, msg);
                        throw new SecurityException(msg);
                        break;
                    case GC_BACKGROUND_PROCESSES_MSG /*5*/:
                        data = intent2.getData();
                        if (data != null) {
                            ssp = data.getSchemeSpecificPart();
                            if (ssp != null) {
                                boolean replacing = intent2.getBooleanExtra("android.intent.extra.REPLACING", VALIDATE_TOKENS);
                                this.mCompatModePackages.handlePackageAddedLocked(ssp, replacing);
                                if (replacing) {
                                    removeTasksByRemovedPackageComponentsLocked(ssp, userId);
                                }
                                if (userId == 0) {
                                    this.mTaskPersister.addOtherDeviceTasksToRecentsLocked(ssp);
                                    break;
                                }
                            }
                        }
                        break;
                    case WAIT_FOR_DEBUGGER_MSG /*6*/:
                        this.mHandler.sendEmptyMessage(UPDATE_TIME_ZONE);
                        break;
                    case C0569H.FINISHED_STARTING /*7*/:
                        this.mHandler.sendMessage(this.mHandler.obtainMessage(UPDATE_TIME, intent2.getBooleanExtra("android.intent.extra.TIME_PREF_24_HOUR_FORMAT", VALIDATE_TOKENS) ? SHOW_ERROR_MSG : MY_PID, MY_PID));
                        BatteryStatsImpl stats = this.mBatteryStatsService.getActiveStatistics();
                        synchronized (stats) {
                            stats.noteCurrentTimeChangedLocked();
                            break;
                        }
                        break;
                    case C0569H.REPORT_APPLICATION_TOKEN_WINDOWS /*8*/:
                        this.mHandler.sendEmptyMessage(CLEAR_DNS_CACHE_MSG);
                        break;
                    case C0569H.REPORT_APPLICATION_TOKEN_DRAWN /*9*/:
                        this.mHandler.sendMessage(this.mHandler.obtainMessage(UPDATE_HTTP_PROXY_MSG, (ProxyInfo) intent2.getParcelableExtra("android.intent.extra.PROXY_INFO")));
                        break;
                }
            }
            if (sticky) {
                if (checkPermission("android.permission.BROADCAST_STICKY", callingPid, callingUid) != 0) {
                    msg = "Permission Denial: broadcastIntent() requesting a sticky broadcast from pid=" + callingPid + ", uid=" + callingUid + " requires " + "android.permission.BROADCAST_STICKY";
                    Slog.w(TAG, msg);
                    throw new SecurityException(msg);
                } else if (requiredPermission != null) {
                    Slog.w(TAG, "Can't broadcast sticky intent " + intent2 + " and enforce permission " + requiredPermission);
                    return -1;
                } else if (intent2.getComponent() != null) {
                    throw new SecurityException("Sticky broadcasts can't target a specific component");
                } else {
                    ArrayMap<String, ArrayList<Intent>> stickies;
                    ArrayList<Intent> list2;
                    int N;
                    if (userId != -1) {
                        stickies = (ArrayMap) this.mStickyBroadcasts.get(-1);
                        if (stickies != null) {
                            list2 = (ArrayList) stickies.get(intent2.getAction());
                            if (list2 != null) {
                                N = list2.size();
                                for (i = MY_PID; i < N; i += SHOW_ERROR_MSG) {
                                    if (intent2.filterEquals((Intent) list2.get(i))) {
                                        throw new IllegalArgumentException("Sticky broadcast " + intent2 + " for user " + userId + " conflicts with existing global broadcast");
                                    }
                                }
                            }
                        }
                    }
                    stickies = (ArrayMap) this.mStickyBroadcasts.get(userId);
                    if (stickies == null) {
                        stickies = new ArrayMap();
                        this.mStickyBroadcasts.put(userId, stickies);
                    }
                    list2 = (ArrayList) stickies.get(intent2.getAction());
                    if (list2 == null) {
                        list2 = new ArrayList();
                        stickies.put(intent2.getAction(), list2);
                    }
                    N = list2.size();
                    i = MY_PID;
                    while (i < N) {
                        if (intent2.filterEquals((Intent) list2.get(i))) {
                            list2.set(i, new Intent(intent2));
                            if (i >= N) {
                                list2.add(new Intent(intent2));
                            }
                        } else {
                            i += SHOW_ERROR_MSG;
                        }
                    }
                    if (i >= N) {
                        list2.add(new Intent(intent2));
                    }
                }
            }
            if (userId == -1) {
                users = this.mStartedUserArray;
            } else {
                users = new int[SHOW_ERROR_MSG];
                users[MY_PID] = userId;
            }
            List receivers = null;
            List<BroadcastFilter> registeredReceivers = null;
            if ((intent2.getFlags() & 1073741824) == 0) {
                receivers = collectReceiverComponents(intent2, resolvedType, callingUid, users);
            }
            if (intent2.getComponent() == null) {
                if (userId == -1 && callingUid == USER_SWITCH_TIMEOUT) {
                    UserManagerService ums = getUserManagerLocked();
                    for (i = MY_PID; i < users.length; i += SHOW_ERROR_MSG) {
                        if (!ums.hasUserRestriction("no_debugging_features", users[i])) {
                            List<BroadcastFilter> registeredReceiversForUser = this.mReceiverResolver.queryIntent(intent2, resolvedType, VALIDATE_TOKENS, users[i]);
                            if (registeredReceivers == null) {
                                registeredReceivers = registeredReceiversForUser;
                            } else if (registeredReceiversForUser != null) {
                                registeredReceivers.addAll(registeredReceiversForUser);
                            }
                        }
                    }
                } else {
                    registeredReceivers = this.mReceiverResolver.queryIntent(intent2, resolvedType, VALIDATE_TOKENS, userId);
                }
            }
            boolean replacePending = (intent2.getFlags() & 536870912) != 0 ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
            int NR = registeredReceivers != null ? registeredReceivers.size() : MY_PID;
            if (!ordered && NR > 0) {
                queue = broadcastQueueForIntent(intent2);
                BroadcastRecord r = new BroadcastRecord(queue, intent2, callerApp, callerPackage, callingPid, callingUid, resolvedType, requiredPermission, appOp, registeredReceivers, resultTo, resultCode, resultData, map, ordered, sticky, VALIDATE_TOKENS, userId);
                replaced = (replacePending && queue.replaceParallelBroadcastLocked(r)) ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
                if (!replaced) {
                    queue.enqueueParallelBroadcastLocked(r);
                    queue.scheduleBroadcastsLocked();
                }
                registeredReceivers = null;
                NR = MY_PID;
            }
            int ir = MY_PID;
            if (receivers != null) {
                int NT;
                int it;
                String[] skipPackages = null;
                if ("android.intent.action.PACKAGE_ADDED".equals(intent2.getAction()) || "android.intent.action.PACKAGE_RESTARTED".equals(intent2.getAction()) || "android.intent.action.PACKAGE_DATA_CLEARED".equals(intent2.getAction())) {
                    data = intent2.getData();
                    if (data != null) {
                        String pkgName = data.getSchemeSpecificPart();
                        if (pkgName != null) {
                            skipPackages = new String[SHOW_ERROR_MSG];
                            skipPackages[MY_PID] = pkgName;
                        }
                    }
                } else if ("android.intent.action.EXTERNAL_APPLICATIONS_AVAILABLE".equals(intent2.getAction())) {
                    skipPackages = intent2.getStringArrayExtra("android.intent.extra.changed_package_list");
                }
                if (skipPackages != null && skipPackages.length > 0) {
                    String[] arr$ = skipPackages;
                    int len$ = arr$.length;
                    for (int i$ = MY_PID; i$ < len$; i$ += SHOW_ERROR_MSG) {
                        String skipPackage = arr$[i$];
                        if (skipPackage != null) {
                            NT = receivers.size();
                            it = MY_PID;
                            while (it < NT) {
                                if (((ResolveInfo) receivers.get(it)).activityInfo.packageName.equals(skipPackage)) {
                                    receivers.remove(it);
                                    it--;
                                    NT--;
                                }
                                it += SHOW_ERROR_MSG;
                            }
                        }
                    }
                }
                NT = receivers != null ? receivers.size() : MY_PID;
                it = MY_PID;
                ResolveInfo curt = null;
                BroadcastFilter curr = null;
                while (it < NT && ir < NR) {
                    if (curt == null) {
                        curt = (ResolveInfo) receivers.get(it);
                    }
                    if (curr == null) {
                        curr = (BroadcastFilter) registeredReceivers.get(ir);
                    }
                    if (curr.getPriority() >= curt.priority) {
                        receivers.add(it, curr);
                        ir += SHOW_ERROR_MSG;
                        curr = null;
                        it += SHOW_ERROR_MSG;
                        NT += SHOW_ERROR_MSG;
                    } else {
                        it += SHOW_ERROR_MSG;
                        curt = null;
                    }
                }
            }
            while (ir < NR) {
                if (receivers == null) {
                    receivers = new ArrayList();
                }
                receivers.add(registeredReceivers.get(ir));
                ir += SHOW_ERROR_MSG;
            }
            if ((receivers != null && receivers.size() > 0) || resultTo != null) {
                queue = broadcastQueueForIntent(intent2);
                BroadcastRecord broadcastRecord = new BroadcastRecord(queue, intent2, callerApp, callerPackage, callingPid, callingUid, resolvedType, requiredPermission, appOp, receivers, resultTo, resultCode, resultData, map, ordered, sticky, VALIDATE_TOKENS, userId);
                replaced = (replacePending && queue.replaceOrderedBroadcastLocked(broadcastRecord)) ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
                if (!replaced) {
                    queue.enqueueOrderedBroadcastLocked(broadcastRecord);
                    queue.scheduleBroadcastsLocked();
                }
            }
            return MY_PID;
        }
        Slog.w(TAG, "Skipping broadcast of " + intent2 + ": user " + userId + " is stopped");
        return -2;
    }

    final Intent verifyBroadcastLocked(Intent intent) {
        if (intent == null || intent.hasFileDescriptors() != SHOW_ACTIVITY_START_TIME) {
            int flags = intent.getFlags();
            if (!this.mProcessesReady) {
                if ((67108864 & flags) != 0) {
                    Intent intent2 = new Intent(intent);
                    intent2.addFlags(1073741824);
                    intent = intent2;
                } else if ((flags & 1073741824) == 0) {
                    Slog.e(TAG, "Attempt to launch receivers of broadcast intent " + intent + " before boot completion");
                    throw new IllegalStateException("Cannot broadcast before boot completed");
                }
            }
            if ((33554432 & flags) == 0) {
                return intent;
            }
            throw new IllegalArgumentException("Can't use FLAG_RECEIVER_BOOT_UPGRADE here");
        }
        throw new IllegalArgumentException("File descriptors passed in Intent");
    }

    public final int broadcastIntent(IApplicationThread caller, Intent intent, String resolvedType, IIntentReceiver resultTo, int resultCode, String resultData, Bundle map, String requiredPermission, int appOp, boolean serialized, boolean sticky, int userId) {
        int res;
        enforceNotIsolatedCaller("broadcastIntent");
        synchronized (this) {
            intent = verifyBroadcastLocked(intent);
            ProcessRecord callerApp = getRecordForAppLocked(caller);
            int callingPid = Binder.getCallingPid();
            int callingUid = Binder.getCallingUid();
            long origId = Binder.clearCallingIdentity();
            res = broadcastIntentLocked(callerApp, callerApp != null ? callerApp.info.packageName : null, intent, resolvedType, resultTo, resultCode, resultData, map, requiredPermission, appOp, serialized, sticky, callingPid, callingUid, userId);
            Binder.restoreCallingIdentity(origId);
        }
        return res;
    }

    int broadcastIntentInPackage(String packageName, int uid, Intent intent, String resolvedType, IIntentReceiver resultTo, int resultCode, String resultData, Bundle map, String requiredPermission, boolean serialized, boolean sticky, int userId) {
        int res;
        synchronized (this) {
            intent = verifyBroadcastLocked(intent);
            long origId = Binder.clearCallingIdentity();
            res = broadcastIntentLocked(null, packageName, intent, resolvedType, resultTo, resultCode, resultData, map, requiredPermission, -1, serialized, sticky, -1, uid, userId);
            Binder.restoreCallingIdentity(origId);
        }
        return res;
    }

    public final void unbroadcastIntent(IApplicationThread caller, Intent intent, int userId) {
        if (intent == null || intent.hasFileDescriptors() != SHOW_ACTIVITY_START_TIME) {
            userId = handleIncomingUser(Binder.getCallingPid(), Binder.getCallingUid(), userId, (boolean) SHOW_ACTIVITY_START_TIME, (int) MY_PID, "removeStickyBroadcast", null);
            synchronized (this) {
                if (checkCallingPermission("android.permission.BROADCAST_STICKY") != 0) {
                    String msg = "Permission Denial: unbroadcastIntent() from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " requires " + "android.permission.BROADCAST_STICKY";
                    Slog.w(TAG, msg);
                    throw new SecurityException(msg);
                }
                ArrayMap<String, ArrayList<Intent>> stickies = (ArrayMap) this.mStickyBroadcasts.get(userId);
                if (stickies != null) {
                    ArrayList<Intent> list = (ArrayList) stickies.get(intent.getAction());
                    if (list != null) {
                        int N = list.size();
                        for (int i = MY_PID; i < N; i += SHOW_ERROR_MSG) {
                            if (intent.filterEquals((Intent) list.get(i))) {
                                list.remove(i);
                                break;
                            }
                        }
                        if (list.size() <= 0) {
                            stickies.remove(intent.getAction());
                        }
                    }
                    if (stickies.size() <= 0) {
                        this.mStickyBroadcasts.remove(userId);
                    }
                }
            }
            return;
        }
        throw new IllegalArgumentException("File descriptors passed in Intent");
    }

    private final boolean finishReceiverLocked(IBinder receiver, int resultCode, String resultData, Bundle resultExtras, boolean resultAbort) {
        BroadcastRecord r = broadcastRecordForReceiverLocked(receiver);
        if (r != null) {
            return r.queue.finishReceiverLocked(r, resultCode, resultData, resultExtras, resultAbort, VALIDATE_TOKENS);
        }
        Slog.w(TAG, "finishReceiver called but not found on queue");
        return VALIDATE_TOKENS;
    }

    void backgroundServicesFinishedLocked(int userId) {
        BroadcastQueue[] arr$ = this.mBroadcastQueues;
        int len$ = arr$.length;
        for (int i$ = MY_PID; i$ < len$; i$ += SHOW_ERROR_MSG) {
            arr$[i$].backgroundServicesFinishedLocked(userId);
        }
    }

    public void finishReceiver(IBinder who, int resultCode, String resultData, Bundle resultExtras, boolean resultAbort) {
        if (resultExtras == null || !resultExtras.hasFileDescriptors()) {
            long origId = Binder.clearCallingIdentity();
            boolean doNext = VALIDATE_TOKENS;
            try {
                BroadcastRecord r;
                synchronized (this) {
                    r = broadcastRecordForReceiverLocked(who);
                    if (r != null) {
                        doNext = r.queue.finishReceiverLocked(r, resultCode, resultData, resultExtras, resultAbort, SHOW_ACTIVITY_START_TIME);
                    }
                }
                if (doNext) {
                    r.queue.processNextBroadcast(VALIDATE_TOKENS);
                }
                trimApplications();
            } finally {
                Binder.restoreCallingIdentity(origId);
            }
        } else {
            throw new IllegalArgumentException("File descriptors passed in Bundle");
        }
    }

    public boolean startInstrumentation(ComponentName className, String profileFile, int flags, Bundle arguments, IInstrumentationWatcher watcher, IUiAutomationConnection uiAutomationConnection, int userId, String abiOverride) {
        enforceNotIsolatedCaller("startInstrumentation");
        userId = handleIncomingUser(Binder.getCallingPid(), Binder.getCallingUid(), userId, (boolean) VALIDATE_TOKENS, (int) SHOW_NOT_RESPONDING_MSG, "startInstrumentation", null);
        if (arguments == null || !arguments.hasFileDescriptors()) {
            synchronized (this) {
                InstrumentationInfo ii = null;
                ApplicationInfo ai = null;
                try {
                    ii = this.mContext.getPackageManager().getInstrumentationInfo(className, STOCK_PM_FLAGS);
                    ai = AppGlobals.getPackageManager().getApplicationInfo(ii.targetPackage, STOCK_PM_FLAGS, userId);
                } catch (NameNotFoundException e) {
                } catch (RemoteException e2) {
                }
                if (ii == null) {
                    reportStartInstrumentationFailure(watcher, className, "Unable to find instrumentation info for: " + className);
                    return VALIDATE_TOKENS;
                } else if (ai == null) {
                    reportStartInstrumentationFailure(watcher, className, "Unable to find instrumentation target package: " + ii.targetPackage);
                    return VALIDATE_TOKENS;
                } else {
                    int match = this.mContext.getPackageManager().checkSignatures(ii.targetPackage, ii.packageName);
                    if (match >= 0 || match == -1) {
                        long origId = Binder.clearCallingIdentity();
                        forceStopPackageLocked(ii.targetPackage, -1, SHOW_ACTIVITY_START_TIME, VALIDATE_TOKENS, SHOW_ACTIVITY_START_TIME, SHOW_ACTIVITY_START_TIME, VALIDATE_TOKENS, userId, "start instr");
                        ProcessRecord app = addAppLocked(ai, VALIDATE_TOKENS, abiOverride);
                        app.instrumentationClass = className;
                        app.instrumentationInfo = ai;
                        app.instrumentationProfileFile = profileFile;
                        app.instrumentationArguments = arguments;
                        app.instrumentationWatcher = watcher;
                        app.instrumentationUiAutomationConnection = uiAutomationConnection;
                        app.instrumentationResultClass = className;
                        Binder.restoreCallingIdentity(origId);
                        return SHOW_ACTIVITY_START_TIME;
                    }
                    String msg = "Permission Denial: starting instrumentation " + className + " from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingPid() + " not allowed because package " + ii.packageName + " does not have a signature matching the target " + ii.targetPackage;
                    reportStartInstrumentationFailure(watcher, className, msg);
                    throw new SecurityException(msg);
                }
            }
        } else {
            throw new IllegalArgumentException("File descriptors passed in Bundle");
        }
    }

    private void reportStartInstrumentationFailure(IInstrumentationWatcher watcher, ComponentName cn, String report) {
        Slog.w(TAG, report);
        if (watcher != null) {
            try {
                Bundle results = new Bundle();
                results.putString("id", "ActivityManagerService");
                results.putString("Error", report);
                watcher.instrumentationStatus(cn, -1, results);
            } catch (RemoteException e) {
                Slog.w(TAG, e);
            }
        }
    }

    void finishInstrumentationLocked(ProcessRecord app, int resultCode, Bundle results) {
        if (app.instrumentationWatcher != null) {
            try {
                app.instrumentationWatcher.instrumentationFinished(app.instrumentationClass, resultCode, results);
            } catch (RemoteException e) {
            }
        }
        if (app.instrumentationUiAutomationConnection != null) {
            try {
                app.instrumentationUiAutomationConnection.shutdown();
            } catch (RemoteException e2) {
            }
            this.mUserIsMonkey = VALIDATE_TOKENS;
        }
        app.instrumentationWatcher = null;
        app.instrumentationUiAutomationConnection = null;
        app.instrumentationClass = null;
        app.instrumentationInfo = null;
        app.instrumentationProfileFile = null;
        app.instrumentationArguments = null;
        forceStopPackageLocked(app.info.packageName, -1, VALIDATE_TOKENS, VALIDATE_TOKENS, SHOW_ACTIVITY_START_TIME, SHOW_ACTIVITY_START_TIME, VALIDATE_TOKENS, app.userId, "finished inst");
    }

    public void finishInstrumentation(IApplicationThread target, int resultCode, Bundle results) {
        int userId = UserHandle.getCallingUserId();
        if (results == null || !results.hasFileDescriptors()) {
            synchronized (this) {
                ProcessRecord app = getRecordForAppLocked(target);
                if (app == null) {
                    Slog.w(TAG, "finishInstrumentation: no app for " + target);
                    return;
                }
                long origId = Binder.clearCallingIdentity();
                finishInstrumentationLocked(app, resultCode, results);
                Binder.restoreCallingIdentity(origId);
                return;
            }
        }
        throw new IllegalArgumentException("File descriptors passed in Intent");
    }

    public ConfigurationInfo getDeviceConfigurationInfo() {
        ConfigurationInfo config = new ConfigurationInfo();
        synchronized (this) {
            config.reqTouchScreen = this.mConfiguration.touchscreen;
            config.reqKeyboardType = this.mConfiguration.keyboard;
            config.reqNavigation = this.mConfiguration.navigation;
            if (this.mConfiguration.navigation == SHOW_NOT_RESPONDING_MSG || this.mConfiguration.navigation == SHOW_FACTORY_ERROR_MSG) {
                config.reqInputFeatures |= SHOW_NOT_RESPONDING_MSG;
            }
            if (!(this.mConfiguration.keyboard == 0 || this.mConfiguration.keyboard == SHOW_ERROR_MSG)) {
                config.reqInputFeatures |= SHOW_ERROR_MSG;
            }
            config.reqGlEsVersion = this.GL_ES_VERSION;
        }
        return config;
    }

    ActivityStack getFocusedStack() {
        return this.mStackSupervisor.getFocusedStack();
    }

    public Configuration getConfiguration() {
        Configuration ci;
        synchronized (this) {
            ci = new Configuration(this.mConfiguration);
            ci.userSetLocale = VALIDATE_TOKENS;
        }
        return ci;
    }

    public void updatePersistentConfiguration(Configuration values) {
        enforceCallingPermission("android.permission.CHANGE_CONFIGURATION", "updateConfiguration()");
        enforceCallingPermission("android.permission.WRITE_SETTINGS", "updateConfiguration()");
        if (values == null) {
            throw new NullPointerException("Configuration must not be null");
        }
        synchronized (this) {
            long origId = Binder.clearCallingIdentity();
            updateConfigurationLocked(values, null, SHOW_ACTIVITY_START_TIME, VALIDATE_TOKENS);
            Binder.restoreCallingIdentity(origId);
        }
    }

    public void updateConfiguration(Configuration values) {
        enforceCallingPermission("android.permission.CHANGE_CONFIGURATION", "updateConfiguration()");
        synchronized (this) {
            if (values == null) {
                if (this.mWindowManager != null) {
                    values = this.mWindowManager.computeNewConfiguration();
                }
            }
            if (this.mWindowManager != null) {
                this.mProcessList.applyDisplaySize(this.mWindowManager);
            }
            long origId = Binder.clearCallingIdentity();
            if (values != null) {
                System.clearConfiguration(values);
            }
            updateConfigurationLocked(values, null, VALIDATE_TOKENS, VALIDATE_TOKENS);
            Binder.restoreCallingIdentity(origId);
        }
    }

    boolean updateConfigurationLocked(Configuration values, ActivityRecord starting, boolean persistent, boolean initLocale) {
        int changes = MY_PID;
        if (values != null) {
            Configuration configuration = new Configuration(this.mConfiguration);
            changes = configuration.updateFrom(values);
            if (changes != 0) {
                EventLog.writeEvent(EventLogTags.CONFIGURATION_CHANGED, changes);
                if (!(values.locale == null || initLocale)) {
                    saveLocaleLocked(values.locale, !values.locale.equals(this.mConfiguration.locale) ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS, values.userSetLocale);
                }
                this.mConfigurationSeq += SHOW_ERROR_MSG;
                if (this.mConfigurationSeq <= 0) {
                    this.mConfigurationSeq = SHOW_ERROR_MSG;
                }
                configuration.seq = this.mConfigurationSeq;
                this.mConfiguration = configuration;
                Slog.i(TAG, "Config changes=" + Integer.toHexString(changes) + " " + configuration);
                this.mUsageStatsService.reportConfigurationChange(configuration, this.mCurrentUserId);
                configuration = new Configuration(this.mConfiguration);
                this.mShowDialogs = shouldShowDialogs(configuration);
                AttributeCache ac = AttributeCache.instance();
                if (ac != null) {
                    ac.updateConfiguration(configuration);
                }
                this.mSystemThread.applyConfigurationToResources(configuration);
                if (persistent && System.hasInterestingConfigurationChanges(changes)) {
                    Message msg = this.mHandler.obtainMessage(UPDATE_CONFIGURATION_MSG);
                    msg.obj = new Configuration(configuration);
                    this.mHandler.sendMessage(msg);
                }
                for (int i = this.mLruProcesses.size() - 1; i >= 0; i--) {
                    ProcessRecord app = (ProcessRecord) this.mLruProcesses.get(i);
                    try {
                        if (app.thread != null) {
                            app.thread.scheduleConfigurationChanged(configuration);
                        }
                    } catch (Exception e) {
                    }
                }
                Intent intent = new Intent("android.intent.action.CONFIGURATION_CHANGED");
                intent.addFlags(1879048192);
                broadcastIntentLocked(null, null, intent, null, null, MY_PID, null, null, null, -1, VALIDATE_TOKENS, VALIDATE_TOKENS, MY_PID, NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY, -1);
                if ((changes & UPDATE_CONFIGURATION_MSG) != 0) {
                    intent = new Intent("android.intent.action.LOCALE_CHANGED");
                    intent.addFlags(268435456);
                    broadcastIntentLocked(null, null, intent, null, null, MY_PID, null, null, null, -1, VALIDATE_TOKENS, VALIDATE_TOKENS, MY_PID, NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY, -1);
                }
            }
        }
        boolean kept = SHOW_ACTIVITY_START_TIME;
        ActivityStack mainStack = this.mStackSupervisor.getFocusedStack();
        if (mainStack != null) {
            if (changes != 0 && starting == null) {
                starting = mainStack.topRunningActivityLocked(null);
            }
            if (starting != null) {
                kept = mainStack.ensureActivityConfigurationLocked(starting, changes);
                this.mStackSupervisor.ensureActivitiesVisibleLocked(starting, changes);
            }
        }
        if (!(values == null || this.mWindowManager == null)) {
            this.mWindowManager.setNewConfiguration(this.mConfiguration);
        }
        return kept;
    }

    private static final boolean shouldShowDialogs(Configuration config) {
        return (config.keyboard == SHOW_ERROR_MSG && config.touchscreen == SHOW_ERROR_MSG) ? VALIDATE_TOKENS : SHOW_ACTIVITY_START_TIME;
    }

    private void saveLocaleLocked(Locale l, boolean isDiff, boolean isPersist) {
        if (isDiff) {
            SystemProperties.set("user.language", l.getLanguage());
            SystemProperties.set("user.region", l.getCountry());
        }
        if (isPersist) {
            SystemProperties.set("persist.sys.language", l.getLanguage());
            SystemProperties.set("persist.sys.country", l.getCountry());
            SystemProperties.set("persist.sys.localevar", l.getVariant());
            this.mHandler.sendMessage(this.mHandler.obtainMessage(SEND_LOCALE_TO_MOUNT_DAEMON_MSG, l));
        }
    }

    public boolean shouldUpRecreateTask(IBinder token, String destAffinity) {
        synchronized (this) {
            ActivityRecord srec = ActivityRecord.forToken(token);
            if (srec.task == null || srec.task.stack == null) {
                return VALIDATE_TOKENS;
            }
            boolean shouldUpRecreateTaskLocked = srec.task.stack.shouldUpRecreateTaskLocked(srec, destAffinity);
            return shouldUpRecreateTaskLocked;
        }
    }

    public boolean navigateUpTo(IBinder token, Intent destIntent, int resultCode, Intent resultData) {
        boolean navigateUpToLocked;
        synchronized (this) {
            ActivityStack stack = ActivityRecord.getStackLocked(token);
            if (stack != null) {
                navigateUpToLocked = stack.navigateUpToLocked(token, destIntent, resultCode, resultData);
            } else {
                navigateUpToLocked = VALIDATE_TOKENS;
            }
        }
        return navigateUpToLocked;
    }

    public int getLaunchedFromUid(IBinder activityToken) {
        ActivityRecord srec = ActivityRecord.forToken(activityToken);
        if (srec == null) {
            return -1;
        }
        return srec.launchedFromUid;
    }

    public String getLaunchedFromPackage(IBinder activityToken) {
        ActivityRecord srec = ActivityRecord.forToken(activityToken);
        if (srec == null) {
            return null;
        }
        return srec.launchedFromPackage;
    }

    private BroadcastQueue isReceivingBroadcast(ProcessRecord app) {
        BroadcastRecord r = app.curReceiver;
        if (r != null) {
            return r.queue;
        }
        synchronized (this) {
            BroadcastQueue[] arr$ = this.mBroadcastQueues;
            int len$ = arr$.length;
            int i$ = MY_PID;
            while (i$ < len$) {
                BroadcastQueue queue = arr$[i$];
                r = queue.mPendingBroadcast;
                if (r == null || r.curApp != app) {
                    i$ += SHOW_ERROR_MSG;
                } else {
                    return queue;
                }
            }
            return null;
        }
    }

    Association startAssociationLocked(int sourceUid, String sourceProcess, int targetUid, ComponentName targetComponent, String targetProcess) {
        if (!this.mTrackingAssociations) {
            return null;
        }
        ArrayMap<ComponentName, SparseArray<ArrayMap<String, Association>>> components = (ArrayMap) this.mAssociations.get(targetUid);
        if (components == null) {
            components = new ArrayMap();
            this.mAssociations.put(targetUid, components);
        }
        SparseArray<ArrayMap<String, Association>> sourceUids = (SparseArray) components.get(targetComponent);
        if (sourceUids == null) {
            sourceUids = new SparseArray();
            components.put(targetComponent, sourceUids);
        }
        ArrayMap<String, Association> sourceProcesses = (ArrayMap) sourceUids.get(sourceUid);
        if (sourceProcesses == null) {
            sourceProcesses = new ArrayMap();
            sourceUids.put(sourceUid, sourceProcesses);
        }
        Association ass = (Association) sourceProcesses.get(sourceProcess);
        if (ass == null) {
            ass = new Association(sourceUid, sourceProcess, targetUid, targetComponent, targetProcess);
            sourceProcesses.put(sourceProcess, ass);
        }
        ass.mCount += SHOW_ERROR_MSG;
        ass.mNesting += SHOW_ERROR_MSG;
        if (ass.mNesting != SHOW_ERROR_MSG) {
            return ass;
        }
        ass.mStartTime = SystemClock.uptimeMillis();
        return ass;
    }

    void stopAssociationLocked(int sourceUid, String sourceProcess, int targetUid, ComponentName targetComponent) {
        if (this.mTrackingAssociations) {
            ArrayMap<ComponentName, SparseArray<ArrayMap<String, Association>>> components = (ArrayMap) this.mAssociations.get(targetUid);
            if (components != null) {
                SparseArray<ArrayMap<String, Association>> sourceUids = (SparseArray) components.get(targetComponent);
                if (sourceUids != null) {
                    ArrayMap<String, Association> sourceProcesses = (ArrayMap) sourceUids.get(sourceUid);
                    if (sourceProcesses != null) {
                        Association ass = (Association) sourceProcesses.get(sourceProcess);
                        if (ass != null && ass.mNesting > 0) {
                            ass.mNesting--;
                            if (ass.mNesting == 0) {
                                ass.mTime += SystemClock.uptimeMillis() - ass.mStartTime;
                            }
                        }
                    }
                }
            }
        }
    }

    private final int computeOomAdjLocked(ProcessRecord app, int cachedAdj, ProcessRecord TOP_APP, boolean doingAll, long now) {
        if (this.mAdjSeq == app.adjSeq) {
            return app.curRawAdj;
        }
        if (app.thread == null) {
            app.adjSeq = this.mAdjSeq;
            app.curSchedGroup = MY_PID;
            app.curProcState = UPDATE_TIME_ZONE;
            app.curRawAdj = SHOW_FINGERPRINT_ERROR_MSG;
            app.curAdj = SHOW_FINGERPRINT_ERROR_MSG;
            return SHOW_FINGERPRINT_ERROR_MSG;
        }
        app.adjTypeCode = MY_PID;
        app.adjSource = null;
        app.adjTarget = null;
        app.empty = VALIDATE_TOKENS;
        app.cached = VALIDATE_TOKENS;
        int activitiesSize = app.activities.size();
        int j;
        if (app.maxAdj <= 0) {
            app.adjType = "fixed";
            app.adjSeq = this.mAdjSeq;
            app.curRawAdj = app.maxAdj;
            app.foregroundActivities = VALIDATE_TOKENS;
            app.curSchedGroup = -1;
            app.curProcState = MY_PID;
            app.systemNoUi = SHOW_ACTIVITY_START_TIME;
            if (app == TOP_APP) {
                app.systemNoUi = VALIDATE_TOKENS;
            } else if (activitiesSize > 0) {
                for (j = MY_PID; j < activitiesSize; j += SHOW_ERROR_MSG) {
                    if (((ActivityRecord) app.activities.get(j)).visible) {
                        app.systemNoUi = VALIDATE_TOKENS;
                    }
                }
            }
            if (!app.systemNoUi) {
                app.curProcState = SHOW_ERROR_MSG;
            }
            int i = app.maxAdj;
            app.curAdj = i;
            return i;
        }
        int adj;
        int schedGroup;
        int procState;
        ProcessRecord client;
        int clientAdj;
        app.systemNoUi = VALIDATE_TOKENS;
        boolean foregroundActivities = VALIDATE_TOKENS;
        if (app == TOP_APP) {
            adj = MY_PID;
            schedGroup = -1;
            app.adjType = "top-activity";
            foregroundActivities = SHOW_ACTIVITY_START_TIME;
            procState = SHOW_NOT_RESPONDING_MSG;
        } else if (app.instrumentationClass != null) {
            adj = MY_PID;
            schedGroup = -1;
            app.adjType = "instrumentation";
            procState = SHOW_FACTORY_ERROR_MSG;
        } else {
            BroadcastQueue queue = isReceivingBroadcast(app);
            if (queue != null) {
                adj = MY_PID;
                schedGroup = queue == this.mFgBroadcastQueue ? -1 : MY_PID;
                app.adjType = "broadcast";
                procState = 8;
            } else if (app.executingServices.size() > 0) {
                adj = MY_PID;
                schedGroup = app.execServicesFg ? -1 : MY_PID;
                app.adjType = "exec-service";
                procState = 7;
            } else {
                schedGroup = MY_PID;
                adj = cachedAdj;
                procState = UPDATE_TIME_ZONE;
                app.cached = SHOW_ACTIVITY_START_TIME;
                app.empty = SHOW_ACTIVITY_START_TIME;
                app.adjType = "cch-empty";
            }
        }
        if (!foregroundActivities && activitiesSize > 0) {
            for (j = MY_PID; j < activitiesSize; j += SHOW_ERROR_MSG) {
                ActivityRecord r = (ActivityRecord) app.activities.get(j);
                if (r.app != app) {
                    Slog.w(TAG, "Wtf, activity " + r + " in proc activity list not using proc " + app + "?!?");
                } else if (r.visible) {
                    if (adj > SHOW_ERROR_MSG) {
                        adj = SHOW_ERROR_MSG;
                        app.adjType = "visible";
                    }
                    if (procState > SHOW_NOT_RESPONDING_MSG) {
                        procState = SHOW_NOT_RESPONDING_MSG;
                    }
                    schedGroup = -1;
                    app.cached = VALIDATE_TOKENS;
                    app.empty = VALIDATE_TOKENS;
                    foregroundActivities = SHOW_ACTIVITY_START_TIME;
                } else if (r.state == ActivityState.PAUSING || r.state == ActivityState.PAUSED) {
                    if (adj > SHOW_NOT_RESPONDING_MSG) {
                        adj = SHOW_NOT_RESPONDING_MSG;
                        app.adjType = "pausing";
                    }
                    if (procState > SHOW_NOT_RESPONDING_MSG) {
                        procState = SHOW_NOT_RESPONDING_MSG;
                    }
                    schedGroup = -1;
                    app.cached = VALIDATE_TOKENS;
                    app.empty = VALIDATE_TOKENS;
                    foregroundActivities = SHOW_ACTIVITY_START_TIME;
                } else if (r.state == ActivityState.STOPPING) {
                    if (adj > SHOW_NOT_RESPONDING_MSG) {
                        adj = SHOW_NOT_RESPONDING_MSG;
                        app.adjType = "stopping";
                    }
                    if (!r.finishing && procState > 10) {
                        procState = 10;
                    }
                    app.cached = VALIDATE_TOKENS;
                    app.empty = VALIDATE_TOKENS;
                    foregroundActivities = SHOW_ACTIVITY_START_TIME;
                } else if (procState > 11) {
                    procState = 11;
                    app.adjType = "cch-act";
                }
            }
        }
        if (adj > SHOW_NOT_RESPONDING_MSG) {
            if (app.foregroundServices) {
                adj = SHOW_NOT_RESPONDING_MSG;
                procState = SHOW_FACTORY_ERROR_MSG;
                app.cached = VALIDATE_TOKENS;
                app.adjType = "fg-service";
                schedGroup = -1;
            } else if (app.forcingToForeground != null) {
                adj = SHOW_NOT_RESPONDING_MSG;
                procState = SHOW_FACTORY_ERROR_MSG;
                app.cached = VALIDATE_TOKENS;
                app.adjType = "force-fg";
                app.adjSource = app.forcingToForeground;
                schedGroup = -1;
            }
        }
        if (app == this.mHeavyWeightProcess) {
            if (adj > UPDATE_CONFIGURATION_MSG) {
                adj = UPDATE_CONFIGURATION_MSG;
                schedGroup = MY_PID;
                app.cached = VALIDATE_TOKENS;
                app.adjType = "heavy";
            }
            if (procState > WAIT_FOR_DEBUGGER_MSG) {
                procState = WAIT_FOR_DEBUGGER_MSG;
            }
        }
        if (app == this.mHomeProcess) {
            if (adj > WAIT_FOR_DEBUGGER_MSG) {
                adj = WAIT_FOR_DEBUGGER_MSG;
                schedGroup = MY_PID;
                app.cached = VALIDATE_TOKENS;
                app.adjType = "home";
            }
            if (procState > 9) {
                procState = 9;
            }
        }
        if (app == this.mPreviousProcess && app.activities.size() > 0) {
            if (adj > 7) {
                adj = 7;
                schedGroup = MY_PID;
                app.cached = VALIDATE_TOKENS;
                app.adjType = "previous";
            }
            if (procState > 10) {
                procState = 10;
            }
        }
        app.adjSeq = this.mAdjSeq;
        app.curRawAdj = adj;
        app.hasStartedServices = VALIDATE_TOKENS;
        if (this.mBackupTarget != null && app == this.mBackupTarget.app) {
            if (adj > SHOW_FACTORY_ERROR_MSG) {
                adj = SHOW_FACTORY_ERROR_MSG;
                if (procState > UPDATE_CONFIGURATION_MSG) {
                    procState = UPDATE_CONFIGURATION_MSG;
                }
                app.adjType = "backup";
                app.cached = VALIDATE_TOKENS;
            }
            if (procState > GC_BACKGROUND_PROCESSES_MSG) {
                procState = GC_BACKGROUND_PROCESSES_MSG;
            }
        }
        boolean mayBeTop = VALIDATE_TOKENS;
        for (int is = app.services.size() - 1; is >= 0 && (adj > 0 || schedGroup == 0 || procState > SHOW_NOT_RESPONDING_MSG); is--) {
            ServiceRecord s = (ServiceRecord) app.services.valueAt(is);
            if (s.startRequested) {
                app.hasStartedServices = SHOW_ACTIVITY_START_TIME;
                if (procState > 7) {
                    procState = 7;
                }
                if (!app.hasShownUi || app == this.mHomeProcess) {
                    if (now < s.lastActivity + BATTERY_STATS_TIME && adj > GC_BACKGROUND_PROCESSES_MSG) {
                        adj = GC_BACKGROUND_PROCESSES_MSG;
                        app.adjType = "started-services";
                        app.cached = VALIDATE_TOKENS;
                    }
                    if (adj > GC_BACKGROUND_PROCESSES_MSG) {
                        app.adjType = "cch-started-services";
                    }
                } else if (adj > GC_BACKGROUND_PROCESSES_MSG) {
                    app.adjType = "cch-started-ui-services";
                }
            }
            for (int conni = s.connections.size() - 1; conni >= 0 && (adj > 0 || schedGroup == 0 || procState > SHOW_NOT_RESPONDING_MSG); conni--) {
                int i2;
                ArrayList<ConnectionRecord> clist = (ArrayList) s.connections.valueAt(conni);
                for (i2 = MY_PID; i2 < clist.size() && (adj > 0 || schedGroup == 0 || procState > SHOW_NOT_RESPONDING_MSG); i2 += SHOW_ERROR_MSG) {
                    int clientProcState;
                    ConnectionRecord cr = (ConnectionRecord) clist.get(i2);
                    if (cr.binding.client != app) {
                        if ((cr.flags & DISPATCH_PROCESS_DIED) == 0) {
                            client = cr.binding.client;
                            clientAdj = computeOomAdjLocked(client, cachedAdj, TOP_APP, doingAll, now);
                            clientProcState = client.curProcState;
                            if (clientProcState >= 11) {
                                clientProcState = UPDATE_TIME_ZONE;
                            }
                            String str = null;
                            if ((cr.flags & 16) != 0) {
                                if (app.hasShownUi && app != this.mHomeProcess) {
                                    if (adj > clientAdj) {
                                        str = "cch-bound-ui-services";
                                    }
                                    app.cached = VALIDATE_TOKENS;
                                    clientAdj = adj;
                                    clientProcState = procState;
                                } else if (now >= s.lastActivity + BATTERY_STATS_TIME) {
                                    if (adj > clientAdj) {
                                        str = "cch-bound-services";
                                    }
                                    clientAdj = adj;
                                }
                            }
                            if (adj > clientAdj) {
                                if (!app.hasShownUi || app == this.mHomeProcess || clientAdj <= SHOW_NOT_RESPONDING_MSG) {
                                    if ((cr.flags & 72) != 0) {
                                        if (clientAdj >= -11) {
                                            adj = clientAdj;
                                        } else {
                                            adj = -11;
                                        }
                                    } else if ((cr.flags & 1073741824) != 0 && clientAdj < SHOW_NOT_RESPONDING_MSG && adj > SHOW_NOT_RESPONDING_MSG) {
                                        adj = SHOW_NOT_RESPONDING_MSG;
                                    } else if (clientAdj > SHOW_ERROR_MSG) {
                                        adj = clientAdj;
                                    } else if (adj > SHOW_ERROR_MSG) {
                                        adj = SHOW_ERROR_MSG;
                                    }
                                    if (!client.cached) {
                                        app.cached = VALIDATE_TOKENS;
                                    }
                                    str = "service";
                                } else {
                                    str = "cch-bound-ui-services";
                                }
                            }
                            if ((cr.flags & UPDATE_CONFIGURATION_MSG) == 0) {
                                if (client.curSchedGroup == -1) {
                                    schedGroup = -1;
                                }
                                if (clientProcState <= SHOW_NOT_RESPONDING_MSG) {
                                    if (clientProcState == SHOW_NOT_RESPONDING_MSG) {
                                        mayBeTop = SHOW_ACTIVITY_START_TIME;
                                        clientProcState = UPDATE_TIME_ZONE;
                                    } else {
                                        clientProcState = SHOW_FACTORY_ERROR_MSG;
                                    }
                                }
                            } else if (clientProcState < UPDATE_CONFIGURATION_MSG) {
                                clientProcState = UPDATE_CONFIGURATION_MSG;
                            }
                            if (procState > clientProcState) {
                                procState = clientProcState;
                            }
                            if (procState < UPDATE_CONFIGURATION_MSG && (cr.flags & 536870912) != 0) {
                                app.pendingUiClean = SHOW_ACTIVITY_START_TIME;
                            }
                            if (str != null) {
                                app.adjType = str;
                                app.adjTypeCode = SHOW_NOT_RESPONDING_MSG;
                                app.adjSource = cr.binding.client;
                                app.adjSourceProcState = clientProcState;
                                app.adjTarget = s.name;
                            }
                        }
                        if ((cr.flags & 134217728) != 0) {
                            app.treatLikeActivity = SHOW_ACTIVITY_START_TIME;
                        }
                        ActivityRecord a = cr.activity;
                        if ((cr.flags & MAX_PERSISTED_URI_GRANTS) != 0 && a != null && adj > 0 && (a.visible || a.state == ActivityState.RESUMED || a.state == ActivityState.PAUSING)) {
                            adj = MY_PID;
                            if ((cr.flags & UPDATE_CONFIGURATION_MSG) == 0) {
                                schedGroup = -1;
                            }
                            app.cached = VALIDATE_TOKENS;
                            app.adjType = "service";
                            app.adjTypeCode = SHOW_NOT_RESPONDING_MSG;
                            app.adjSource = a;
                            app.adjSourceProcState = procState;
                            app.adjTarget = s.name;
                        }
                    }
                }
            }
        }
        for (int provi = app.pubProviders.size() - 1; provi >= 0 && (adj > 0 || schedGroup == 0 || procState > SHOW_NOT_RESPONDING_MSG); provi--) {
            ContentProviderRecord cpr = (ContentProviderRecord) app.pubProviders.valueAt(provi);
            for (i2 = cpr.connections.size() - 1; i2 >= 0 && (adj > 0 || schedGroup == 0 || procState > SHOW_NOT_RESPONDING_MSG); i2--) {
                client = ((ContentProviderConnection) cpr.connections.get(i2)).client;
                if (client != app) {
                    clientAdj = computeOomAdjLocked(client, cachedAdj, TOP_APP, doingAll, now);
                    clientProcState = client.curProcState;
                    if (clientProcState >= 11) {
                        clientProcState = UPDATE_TIME_ZONE;
                    }
                    if (adj > clientAdj) {
                        if (!app.hasShownUi || app == this.mHomeProcess || clientAdj <= SHOW_NOT_RESPONDING_MSG) {
                            adj = clientAdj > 0 ? clientAdj : MY_PID;
                            app.adjType = "provider";
                        } else {
                            app.adjType = "cch-ui-provider";
                        }
                        app.cached &= client.cached;
                        app.adjTypeCode = SHOW_ERROR_MSG;
                        app.adjSource = client;
                        app.adjSourceProcState = clientProcState;
                        app.adjTarget = cpr.name;
                    }
                    if (clientProcState <= SHOW_NOT_RESPONDING_MSG) {
                        if (clientProcState == SHOW_NOT_RESPONDING_MSG) {
                            mayBeTop = SHOW_ACTIVITY_START_TIME;
                            clientProcState = UPDATE_TIME_ZONE;
                        } else {
                            clientProcState = SHOW_FACTORY_ERROR_MSG;
                        }
                    }
                    if (procState > clientProcState) {
                        procState = clientProcState;
                    }
                    if (client.curSchedGroup == -1) {
                        schedGroup = -1;
                    }
                }
            }
            if (cpr.hasExternalProcessHandles()) {
                if (adj > 0) {
                    adj = MY_PID;
                    schedGroup = -1;
                    app.cached = VALIDATE_TOKENS;
                    app.adjType = "provider";
                    app.adjTarget = cpr.name;
                }
                if (procState > SHOW_FACTORY_ERROR_MSG) {
                    procState = SHOW_FACTORY_ERROR_MSG;
                }
            }
        }
        if (mayBeTop && procState > SHOW_NOT_RESPONDING_MSG) {
            switch (procState) {
                case SHOW_FACTORY_ERROR_MSG /*3*/:
                case UPDATE_CONFIGURATION_MSG /*4*/:
                case C0569H.FINISHED_STARTING /*7*/:
                    procState = SHOW_FACTORY_ERROR_MSG;
                    break;
                default:
                    procState = SHOW_NOT_RESPONDING_MSG;
                    break;
            }
        }
        if (procState >= UPDATE_TIME_ZONE) {
            if (app.hasClientActivities) {
                procState = SERVICE_TIMEOUT_MSG;
                app.adjType = "cch-client-act";
            } else if (app.treatLikeActivity) {
                procState = 11;
                app.adjType = "cch-as-act";
            }
        }
        if (adj == GC_BACKGROUND_PROCESSES_MSG) {
            if (doingAll) {
                app.serviceb = this.mNewNumAServiceProcs > this.mNumServiceProcs / SHOW_FACTORY_ERROR_MSG ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
                this.mNewNumServiceProcs += SHOW_ERROR_MSG;
                if (app.serviceb) {
                    app.serviceHighRam = VALIDATE_TOKENS;
                } else if (this.mLastMemoryLevel <= 0 || app.lastPss < this.mProcessList.getCachedRestoreThresholdKb()) {
                    this.mNewNumAServiceProcs += SHOW_ERROR_MSG;
                } else {
                    app.serviceHighRam = SHOW_ACTIVITY_START_TIME;
                    app.serviceb = SHOW_ACTIVITY_START_TIME;
                }
            }
            if (app.serviceb) {
                adj = 8;
            }
        }
        app.curRawAdj = adj;
        if (adj > app.maxAdj) {
            adj = app.maxAdj;
            if (app.maxAdj <= SHOW_NOT_RESPONDING_MSG) {
                schedGroup = -1;
            }
        }
        app.curAdj = app.modifyRawOomAdj(adj);
        app.curSchedGroup = schedGroup;
        app.curProcState = procState;
        app.foregroundActivities = foregroundActivities;
        return app.curRawAdj;
    }

    void recordPssSample(ProcessRecord proc, int procState, long pss, long uss, long now) {
        proc.lastPssTime = now;
        proc.baseProcessTracker.addPss(pss, uss, SHOW_ACTIVITY_START_TIME, proc.pkgList);
        if (proc.initialIdlePss == 0) {
            proc.initialIdlePss = pss;
        }
        proc.lastPss = pss;
        if (procState >= 9) {
            proc.lastCachedPss = pss;
        }
    }

    void requestPssLocked(ProcessRecord proc, int procState) {
        if (!this.mPendingPssProcesses.contains(proc)) {
            if (this.mPendingPssProcesses.size() == 0) {
                this.mBgHandler.sendEmptyMessage(SHOW_ERROR_MSG);
            }
            proc.pssProcState = procState;
            this.mPendingPssProcesses.add(proc);
        }
    }

    void requestPssAllProcsLocked(long now, boolean always, boolean memLowered) {
        if (!always) {
            int i;
            long j = this.mLastFullPssTime;
            if (memLowered) {
                i = FULL_PSS_LOWERED_INTERVAL;
            } else {
                i = FULL_PSS_MIN_INTERVAL;
            }
            if (now < j + ((long) i)) {
                return;
            }
        }
        this.mLastFullPssTime = now;
        this.mFullPssPending = SHOW_ACTIVITY_START_TIME;
        this.mPendingPssProcesses.ensureCapacity(this.mLruProcesses.size());
        this.mPendingPssProcesses.clear();
        for (int i2 = this.mLruProcesses.size() - 1; i2 >= 0; i2--) {
            ProcessRecord app = (ProcessRecord) this.mLruProcesses.get(i2);
            if (memLowered || now > app.lastStateTime + LocationFudger.FASTEST_INTERVAL_MS) {
                app.pssProcState = app.setProcState;
                app.nextPssTime = ProcessList.computeNextPssTime(app.curProcState, SHOW_ACTIVITY_START_TIME, this.mTestPssMode, isSleeping(), now);
                this.mPendingPssProcesses.add(app);
            }
        }
        this.mBgHandler.sendEmptyMessage(SHOW_ERROR_MSG);
    }

    public void setTestPssMode(boolean enabled) {
        synchronized (this) {
            this.mTestPssMode = enabled;
            if (enabled) {
                requestPssAllProcsLocked(SystemClock.uptimeMillis(), SHOW_ACTIVITY_START_TIME, SHOW_ACTIVITY_START_TIME);
            }
        }
    }

    final void performAppGcLocked(ProcessRecord app) {
        try {
            app.lastRequestedGc = SystemClock.uptimeMillis();
            if (app.thread == null) {
                return;
            }
            if (app.reportLowMemory) {
                app.reportLowMemory = VALIDATE_TOKENS;
                app.thread.scheduleLowMemory();
                return;
            }
            app.thread.processInBackground();
        } catch (Exception e) {
        }
    }

    private final boolean canGcNowLocked() {
        boolean processingBroadcasts = VALIDATE_TOKENS;
        BroadcastQueue[] arr$ = this.mBroadcastQueues;
        int len$ = arr$.length;
        for (int i$ = MY_PID; i$ < len$; i$ += SHOW_ERROR_MSG) {
            BroadcastQueue q = arr$[i$];
            if (q.mParallelBroadcasts.size() != 0 || q.mOrderedBroadcasts.size() != 0) {
                processingBroadcasts = SHOW_ACTIVITY_START_TIME;
            }
        }
        return (processingBroadcasts || !(isSleeping() || this.mStackSupervisor.allResumedActivitiesIdle())) ? VALIDATE_TOKENS : SHOW_ACTIVITY_START_TIME;
    }

    final void performAppGcsLocked() {
        if (this.mProcessesToGc.size() > 0 && canGcNowLocked()) {
            while (this.mProcessesToGc.size() > 0) {
                ProcessRecord proc = (ProcessRecord) this.mProcessesToGc.remove(MY_PID);
                if (proc.curRawAdj <= SHOW_NOT_RESPONDING_MSG) {
                    if (proc.reportLowMemory) {
                    }
                }
                if (proc.lastRequestedGc + 60000 <= SystemClock.uptimeMillis()) {
                    performAppGcLocked(proc);
                    scheduleAppGcsLocked();
                    return;
                }
                addProcessToGcListLocked(proc);
                scheduleAppGcsLocked();
            }
            scheduleAppGcsLocked();
        }
    }

    final void performGcsForAllLocked() {
        ArrayMap<String, SparseArray<ProcessRecord>> map = this.mProcessNames.getMap();
        int mapSize = map.size();
        for (int i = MY_PID; i < mapSize; i += SHOW_ERROR_MSG) {
            SparseArray<ProcessRecord> array = (SparseArray) map.get((String) map.keyAt(i));
            for (int j = MY_PID; j < array.size(); j += SHOW_ERROR_MSG) {
                performAppGcLocked((ProcessRecord) array.valueAt(j));
            }
        }
    }

    final void performAppGcsIfAppropriateLocked() {
        if (canGcNowLocked()) {
            performAppGcsLocked();
        } else {
            scheduleAppGcsLocked();
        }
    }

    final void scheduleAppGcsLocked() {
        this.mHandler.removeMessages(GC_BACKGROUND_PROCESSES_MSG);
        if (this.mProcessesToGc.size() > 0) {
            ProcessRecord proc = (ProcessRecord) this.mProcessesToGc.get(MY_PID);
            Message msg = this.mHandler.obtainMessage(GC_BACKGROUND_PROCESSES_MSG);
            long when = proc.lastRequestedGc + 60000;
            long now = SystemClock.uptimeMillis();
            if (when < now + MONITOR_CPU_MIN_TIME) {
                when = now + MONITOR_CPU_MIN_TIME;
            }
            this.mHandler.sendMessageAtTime(msg, when);
        }
    }

    final void addProcessToGcListLocked(ProcessRecord proc) {
        boolean added = VALIDATE_TOKENS;
        for (int i = this.mProcessesToGc.size() - 1; i >= 0; i--) {
            if (((ProcessRecord) this.mProcessesToGc.get(i)).lastRequestedGc < proc.lastRequestedGc) {
                added = SHOW_ACTIVITY_START_TIME;
                this.mProcessesToGc.add(i + SHOW_ERROR_MSG, proc);
                break;
            }
        }
        if (!added) {
            this.mProcessesToGc.add(MY_PID, proc);
        }
    }

    final void scheduleAppGcLocked(ProcessRecord app) {
        if (app.lastRequestedGc + 60000 <= SystemClock.uptimeMillis() && !this.mProcessesToGc.contains(app)) {
            addProcessToGcListLocked(app);
            scheduleAppGcsLocked();
        }
    }

    final void checkExcessivePowerUsageLocked(boolean doKills) {
        updateCpuStatsNow();
        BatteryStatsImpl stats = this.mBatteryStatsService.getActiveStatistics();
        boolean doWakeKills = doKills;
        boolean doCpuKills = doKills;
        if (this.mLastPowerCheckRealtime == 0) {
            doWakeKills = VALIDATE_TOKENS;
        }
        if (this.mLastPowerCheckUptime == 0) {
            doCpuKills = VALIDATE_TOKENS;
        }
        if (stats.isScreenOn()) {
            doWakeKills = VALIDATE_TOKENS;
        }
        long curRealtime = SystemClock.elapsedRealtime();
        long realtimeSince = curRealtime - this.mLastPowerCheckRealtime;
        long curUptime = SystemClock.uptimeMillis();
        long uptimeSince = curUptime - this.mLastPowerCheckUptime;
        this.mLastPowerCheckRealtime = curRealtime;
        this.mLastPowerCheckUptime = curUptime;
        if (realtimeSince < 300000) {
            doWakeKills = VALIDATE_TOKENS;
        }
        if (uptimeSince < 300000) {
            doCpuKills = VALIDATE_TOKENS;
        }
        int i = this.mLruProcesses.size();
        while (i > 0) {
            i--;
            ProcessRecord app = (ProcessRecord) this.mLruProcesses.get(i);
            if (app.setProcState >= 9) {
                long wtime;
                synchronized (stats) {
                    wtime = stats.getProcessWakeTime(app.info.uid, app.pid, curRealtime);
                }
                long wtimeUsed = wtime - app.lastWakeTime;
                long cputimeUsed = app.curCpuTime - app.lastCpuTime;
                if (doWakeKills && realtimeSince > 0 && (100 * wtimeUsed) / realtimeSince >= 50) {
                    synchronized (stats) {
                        stats.reportExcessiveWakeLocked(app.info.uid, app.processName, realtimeSince, wtimeUsed);
                    }
                    app.kill("excessive wake held " + wtimeUsed + " during " + realtimeSince, SHOW_ACTIVITY_START_TIME);
                    app.baseProcessTracker.reportExcessiveWake(app.pkgList);
                } else if (!doCpuKills || uptimeSince <= 0 || (100 * cputimeUsed) / uptimeSince < 25) {
                    app.lastWakeTime = wtime;
                    app.lastCpuTime = app.curCpuTime;
                } else {
                    synchronized (stats) {
                        stats.reportExcessiveCpuLocked(app.info.uid, app.processName, uptimeSince, cputimeUsed);
                    }
                    app.kill("excessive cpu " + cputimeUsed + " during " + uptimeSince, SHOW_ACTIVITY_START_TIME);
                    app.baseProcessTracker.reportExcessiveCpu(app.pkgList);
                }
            }
        }
    }

    private final boolean applyOomAdjLocked(ProcessRecord app, ProcessRecord TOP_APP, boolean doingAll, long now) {
        boolean success = SHOW_ACTIVITY_START_TIME;
        if (app.curRawAdj != app.setRawAdj) {
            app.setRawAdj = app.curRawAdj;
        }
        int changes = MY_PID;
        if (app.curAdj != app.setAdj) {
            ProcessList.setOomAdj(app.pid, app.info.uid, app.curAdj);
            app.setAdj = app.curAdj;
        }
        if (app.setSchedGroup != app.curSchedGroup) {
            app.setSchedGroup = app.curSchedGroup;
            if (app.waitingToKill == null || app.setSchedGroup != 0) {
                boolean z;
                long oldId = Binder.clearCallingIdentity();
                try {
                    Process.setProcessGroup(app.pid, app.curSchedGroup);
                } catch (Exception e) {
                    Slog.w(TAG, "Failed setting process group of " + app.pid + " to " + app.curSchedGroup);
                    e.printStackTrace();
                } finally {
                    Binder.restoreCallingIdentity(oldId);
                }
                int i = app.pid;
                if (app.curSchedGroup <= 0) {
                    z = SHOW_ACTIVITY_START_TIME;
                } else {
                    z = VALIDATE_TOKENS;
                }
                Process.setSwappiness(i, z);
            } else {
                app.kill(app.waitingToKill, SHOW_ACTIVITY_START_TIME);
                success = VALIDATE_TOKENS;
            }
        }
        if (app.repForegroundActivities != app.foregroundActivities) {
            app.repForegroundActivities = app.foregroundActivities;
            changes = MY_PID | SHOW_ERROR_MSG;
        }
        if (app.repProcState != app.curProcState) {
            app.repProcState = app.curProcState;
            changes |= SHOW_NOT_RESPONDING_MSG;
            if (app.thread != null) {
                try {
                    app.thread.setProcessState(app.repProcState);
                } catch (RemoteException e2) {
                }
            }
        }
        if (app.setProcState < 0 || ProcessList.procStatesDifferForMem(app.curProcState, app.setProcState)) {
            app.lastStateTime = now;
            app.nextPssTime = ProcessList.computeNextPssTime(app.curProcState, SHOW_ACTIVITY_START_TIME, this.mTestPssMode, isSleeping(), now);
        } else if (now > app.nextPssTime || (now > app.lastPssTime + BATTERY_STATS_TIME && now > app.lastStateTime + ProcessList.minTimeFromStateChange(this.mTestPssMode))) {
            requestPssLocked(app, app.setProcState);
            app.nextPssTime = ProcessList.computeNextPssTime(app.curProcState, VALIDATE_TOKENS, this.mTestPssMode, isSleeping(), now);
        }
        if (app.setProcState != app.curProcState) {
            boolean setImportant = app.setProcState < 7 ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
            boolean curImportant = app.curProcState < 7 ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS;
            if (setImportant && !curImportant) {
                BatteryStatsImpl stats = this.mBatteryStatsService.getActiveStatistics();
                synchronized (stats) {
                    app.lastWakeTime = stats.getProcessWakeTime(app.info.uid, app.pid, SystemClock.elapsedRealtime());
                }
                app.lastCpuTime = app.curCpuTime;
            }
            app.setProcState = app.curProcState;
            if (app.setProcState >= 9) {
                app.notCachedSinceIdle = VALIDATE_TOKENS;
            }
            if (doingAll) {
                app.procStateChanged = SHOW_ACTIVITY_START_TIME;
            } else {
                setProcessTrackerStateLocked(app, this.mProcessStats.getMemFactorLocked(), now);
            }
        }
        if (changes != 0) {
            int i2 = this.mPendingProcessChanges.size() - 1;
            ProcessChangeItem item = null;
            while (i2 >= 0) {
                item = (ProcessChangeItem) this.mPendingProcessChanges.get(i2);
                if (item.pid == app.pid) {
                    break;
                }
                i2--;
            }
            if (i2 < 0) {
                int NA = this.mAvailProcessChanges.size();
                if (NA > 0) {
                    item = (ProcessChangeItem) this.mAvailProcessChanges.remove(NA - 1);
                } else {
                    item = new ProcessChangeItem();
                }
                item.changes = MY_PID;
                item.pid = app.pid;
                item.uid = app.info.uid;
                if (this.mPendingProcessChanges.size() == 0) {
                    this.mHandler.obtainMessage(DISPATCH_PROCESSES_CHANGED).sendToTarget();
                }
                this.mPendingProcessChanges.add(item);
            }
            item.changes |= changes;
            item.processState = app.repProcState;
            item.foregroundActivities = app.repForegroundActivities;
        }
        return success;
    }

    private final void setProcessTrackerStateLocked(ProcessRecord proc, int memFactor, long now) {
        if (proc.thread != null) {
            if (proc.baseProcessTracker != null) {
                proc.baseProcessTracker.setState(proc.repProcState, memFactor, now, proc.pkgList);
            }
            if (proc.repProcState >= 0) {
                this.mBatteryStatsService.noteProcessState(proc.processName, proc.info.uid, proc.repProcState);
            }
        }
    }

    private final boolean updateOomAdjLocked(ProcessRecord app, int cachedAdj, ProcessRecord TOP_APP, boolean doingAll, long now) {
        if (app.thread == null) {
            return VALIDATE_TOKENS;
        }
        computeOomAdjLocked(app, cachedAdj, TOP_APP, doingAll, now);
        return applyOomAdjLocked(app, TOP_APP, doingAll, now);
    }

    final void updateProcessForegroundLocked(ProcessRecord proc, boolean isForeground, boolean oomAdj) {
        if (isForeground != proc.foregroundServices) {
            proc.foregroundServices = isForeground;
            ArrayList<ProcessRecord> curProcs = (ArrayList) this.mForegroundPackages.get(proc.info.packageName, proc.info.uid);
            if (isForeground) {
                if (curProcs == null) {
                    curProcs = new ArrayList();
                    this.mForegroundPackages.put(proc.info.packageName, proc.info.uid, curProcs);
                }
                if (!curProcs.contains(proc)) {
                    curProcs.add(proc);
                    this.mBatteryStatsService.noteEvent(32770, proc.info.packageName, proc.info.uid);
                }
            } else if (curProcs != null && curProcs.remove(proc)) {
                this.mBatteryStatsService.noteEvent(16386, proc.info.packageName, proc.info.uid);
                if (curProcs.size() <= 0) {
                    this.mForegroundPackages.remove(proc.info.packageName, proc.info.uid);
                }
            }
            if (oomAdj) {
                updateOomAdjLocked();
            }
        }
    }

    private final ActivityRecord resumedAppLocked() {
        String pkg;
        int uid;
        ActivityRecord act = this.mStackSupervisor.resumedAppLocked();
        if (act != null) {
            pkg = act.packageName;
            uid = act.info.applicationInfo.uid;
        } else {
            pkg = null;
            uid = -1;
        }
        if (uid != this.mCurResumedUid || (pkg != this.mCurResumedPackage && (pkg == null || !pkg.equals(this.mCurResumedPackage)))) {
            if (this.mCurResumedPackage != null) {
                this.mBatteryStatsService.noteEvent(16387, this.mCurResumedPackage, this.mCurResumedUid);
            }
            this.mCurResumedPackage = pkg;
            this.mCurResumedUid = uid;
            if (this.mCurResumedPackage != null) {
                this.mBatteryStatsService.noteEvent(32771, this.mCurResumedPackage, this.mCurResumedUid);
            }
        }
        return act;
    }

    final boolean updateOomAdjLocked(ProcessRecord app) {
        int cachedAdj;
        ActivityRecord TOP_ACT = resumedAppLocked();
        ProcessRecord TOP_APP = TOP_ACT != null ? TOP_ACT.app : null;
        boolean wasCached = app.cached;
        this.mAdjSeq += SHOW_ERROR_MSG;
        if (app.curRawAdj >= 9) {
            cachedAdj = app.curRawAdj;
        } else {
            cachedAdj = 16;
        }
        boolean success = updateOomAdjLocked(app, cachedAdj, TOP_APP, VALIDATE_TOKENS, SystemClock.uptimeMillis());
        if (wasCached != app.cached || app.curRawAdj == 16) {
            updateOomAdjLocked();
        }
        return success;
    }

    final void updateOomAdjLocked() {
        int cachedProcessLimit;
        int emptyProcessLimit;
        int i;
        int memFactor;
        ActivityRecord TOP_ACT = resumedAppLocked();
        ProcessRecord TOP_APP = TOP_ACT != null ? TOP_ACT.app : null;
        long now = SystemClock.uptimeMillis();
        long oldTime = now - BATTERY_STATS_TIME;
        int N = this.mLruProcesses.size();
        this.mAdjSeq += SHOW_ERROR_MSG;
        this.mNewNumServiceProcs = MY_PID;
        this.mNewNumAServiceProcs = MY_PID;
        if (this.mProcessLimit <= 0) {
            cachedProcessLimit = MY_PID;
            emptyProcessLimit = MY_PID;
        } else if (this.mProcessLimit == SHOW_ERROR_MSG) {
            emptyProcessLimit = SHOW_ERROR_MSG;
            cachedProcessLimit = MY_PID;
        } else {
            emptyProcessLimit = ProcessList.computeEmptyProcessLimit(this.mProcessLimit);
            cachedProcessLimit = this.mProcessLimit - emptyProcessLimit;
        }
        int numEmptyProcs = (N - this.mNumNonCachedProcs) - this.mNumCachedHiddenProcs;
        if (numEmptyProcs > cachedProcessLimit) {
            numEmptyProcs = cachedProcessLimit;
        }
        int emptyFactor = numEmptyProcs / SHOW_FACTORY_ERROR_MSG;
        if (emptyFactor < SHOW_ERROR_MSG) {
            emptyFactor = SHOW_ERROR_MSG;
        }
        int cachedFactor = (this.mNumCachedHiddenProcs > 0 ? this.mNumCachedHiddenProcs : SHOW_ERROR_MSG) / SHOW_FACTORY_ERROR_MSG;
        if (cachedFactor < SHOW_ERROR_MSG) {
            cachedFactor = SHOW_ERROR_MSG;
        }
        int stepCached = MY_PID;
        int stepEmpty = MY_PID;
        int numCached = MY_PID;
        int numEmpty = MY_PID;
        int numTrimming = MY_PID;
        this.mNumNonCachedProcs = MY_PID;
        this.mNumCachedHiddenProcs = MY_PID;
        int curCachedAdj = 9;
        int nextCachedAdj = 9 + SHOW_ERROR_MSG;
        int curEmptyAdj = 9;
        int nextEmptyAdj = 9 + SHOW_NOT_RESPONDING_MSG;
        ProcessRecord selectedAppRecord = null;
        long serviceLastActivity = 0;
        int numBServices = MY_PID;
        for (i = N - 1; i >= 0; i--) {
            ProcessRecord app = (ProcessRecord) this.mLruProcesses.get(i);
            if (ProcessList.ENABLE_B_SERVICE_PROPAGATION && app.serviceb) {
                numBServices += SHOW_ERROR_MSG;
                for (int s = app.services.size() - 1; s >= 0; s--) {
                    ServiceRecord sr = (ServiceRecord) app.services.valueAt(s);
                    if (SystemClock.uptimeMillis() - sr.lastActivity >= ((long) ProcessList.MIN_BSERVICE_AGING_TIME)) {
                        if (serviceLastActivity == 0) {
                            serviceLastActivity = sr.lastActivity;
                            selectedAppRecord = app;
                        } else if (sr.lastActivity < serviceLastActivity) {
                            serviceLastActivity = sr.lastActivity;
                            selectedAppRecord = app;
                        }
                    }
                }
            }
            if (!(app.killedByAm || app.thread == null)) {
                app.procStateChanged = VALIDATE_TOKENS;
                computeOomAdjLocked(app, 16, TOP_APP, SHOW_ACTIVITY_START_TIME, now);
                if (app.curAdj >= 16) {
                    switch (app.curProcState) {
                        case C0569H.WINDOW_FREEZE_TIMEOUT /*11*/:
                        case SERVICE_TIMEOUT_MSG /*12*/:
                            app.curRawAdj = curCachedAdj;
                            app.curAdj = app.modifyRawOomAdj(curCachedAdj);
                            if (curCachedAdj != nextCachedAdj) {
                                stepCached += SHOW_ERROR_MSG;
                                if (stepCached >= cachedFactor) {
                                    stepCached = MY_PID;
                                    curCachedAdj = nextCachedAdj;
                                    nextCachedAdj += SHOW_NOT_RESPONDING_MSG;
                                    if (nextCachedAdj > SHOW_FINGERPRINT_ERROR_MSG) {
                                        nextCachedAdj = SHOW_FINGERPRINT_ERROR_MSG;
                                        break;
                                    }
                                }
                            }
                            break;
                        default:
                            app.curRawAdj = curEmptyAdj;
                            app.curAdj = app.modifyRawOomAdj(curEmptyAdj);
                            if (curEmptyAdj != nextEmptyAdj) {
                                stepEmpty += SHOW_ERROR_MSG;
                                if (stepEmpty >= emptyFactor) {
                                    stepEmpty = MY_PID;
                                    curEmptyAdj = nextEmptyAdj;
                                    nextEmptyAdj += SHOW_NOT_RESPONDING_MSG;
                                    if (nextEmptyAdj > SHOW_FINGERPRINT_ERROR_MSG) {
                                        nextEmptyAdj = SHOW_FINGERPRINT_ERROR_MSG;
                                        break;
                                    }
                                }
                            }
                            break;
                    }
                }
                applyOomAdjLocked(app, TOP_APP, SHOW_ACTIVITY_START_TIME, now);
                switch (app.curProcState) {
                    case C0569H.WINDOW_FREEZE_TIMEOUT /*11*/:
                    case SERVICE_TIMEOUT_MSG /*12*/:
                        this.mNumCachedHiddenProcs += SHOW_ERROR_MSG;
                        numCached += SHOW_ERROR_MSG;
                        if (numCached > cachedProcessLimit) {
                            app.kill("cached #" + numCached, SHOW_ACTIVITY_START_TIME);
                            break;
                        }
                        break;
                    case UPDATE_TIME_ZONE /*13*/:
                        if (numEmpty > ProcessList.TRIM_EMPTY_APPS && app.lastActivityTime < oldTime) {
                            app.kill("empty for " + (((BATTERY_STATS_TIME + oldTime) - app.lastActivityTime) / 1000) + "s", SHOW_ACTIVITY_START_TIME);
                            break;
                        }
                        numEmpty += SHOW_ERROR_MSG;
                        if (numEmpty > emptyProcessLimit) {
                            app.kill("empty #" + numEmpty, SHOW_ACTIVITY_START_TIME);
                            break;
                        }
                        break;
                    default:
                        this.mNumNonCachedProcs += SHOW_ERROR_MSG;
                        break;
                }
                if (app.isolated && app.services.size() <= 0) {
                    app.kill("isolated not needed", SHOW_ACTIVITY_START_TIME);
                }
                if (app.curProcState >= 9 && !app.killedByAm) {
                    numTrimming += SHOW_ERROR_MSG;
                }
            }
        }
        if (numBServices > ProcessList.BSERVICE_APP_THRESHOLD && SHOW_ACTIVITY_START_TIME == this.mAllowLowerMemLevel && selectedAppRecord != null) {
            ProcessList.setOomAdj(selectedAppRecord.pid, selectedAppRecord.info.uid, SHOW_FINGERPRINT_ERROR_MSG);
            selectedAppRecord.setAdj = selectedAppRecord.curAdj;
        }
        this.mNumServiceProcs = this.mNewNumServiceProcs;
        int numCachedAndEmpty = numCached + numEmpty;
        if (numCached > ProcessList.TRIM_CACHED_APPS || numEmpty > ProcessList.TRIM_EMPTY_APPS) {
            memFactor = MY_PID;
        } else if (numCachedAndEmpty <= SHOW_FACTORY_ERROR_MSG) {
            memFactor = SHOW_FACTORY_ERROR_MSG;
        } else if (numCachedAndEmpty <= GC_BACKGROUND_PROCESSES_MSG) {
            memFactor = SHOW_NOT_RESPONDING_MSG;
        } else {
            memFactor = SHOW_ERROR_MSG;
        }
        if (memFactor > this.mLastMemoryLevel && (!this.mAllowLowerMemLevel || this.mLruProcesses.size() >= this.mLastNumProcesses)) {
            memFactor = this.mLastMemoryLevel;
        }
        this.mLastMemoryLevel = memFactor;
        this.mLastNumProcesses = this.mLruProcesses.size();
        boolean allChanged = this.mProcessStats.setMemFactorLocked(memFactor, !isSleeping() ? SHOW_ACTIVITY_START_TIME : VALIDATE_TOKENS, now);
        int trackerMemFactor = this.mProcessStats.getMemFactorLocked();
        if (memFactor != 0) {
            int fgTrimLevel;
            if (this.mLowRamStartTime == 0) {
                this.mLowRamStartTime = now;
            }
            int step = MY_PID;
            switch (memFactor) {
                case SHOW_NOT_RESPONDING_MSG /*2*/:
                    fgTrimLevel = 10;
                    break;
                case SHOW_FACTORY_ERROR_MSG /*3*/:
                    fgTrimLevel = SHOW_FINGERPRINT_ERROR_MSG;
                    break;
                default:
                    fgTrimLevel = GC_BACKGROUND_PROCESSES_MSG;
                    break;
            }
            int factor = numTrimming / SHOW_FACTORY_ERROR_MSG;
            int minFactor = SHOW_NOT_RESPONDING_MSG;
            if (this.mHomeProcess != null) {
                minFactor = SHOW_NOT_RESPONDING_MSG + SHOW_ERROR_MSG;
            }
            if (this.mPreviousProcess != null) {
                minFactor += SHOW_ERROR_MSG;
            }
            if (factor < minFactor) {
                factor = minFactor;
            }
            int curLevel = 80;
            for (i = N - 1; i >= 0; i--) {
                app = (ProcessRecord) this.mLruProcesses.get(i);
                if (allChanged || app.procStateChanged) {
                    setProcessTrackerStateLocked(app, trackerMemFactor, now);
                    app.procStateChanged = VALIDATE_TOKENS;
                }
                if (app.curProcState >= 9 && !app.killedByAm) {
                    if (app.trimMemoryLevel < curLevel && app.thread != null) {
                        try {
                            app.thread.scheduleTrimMemory(curLevel);
                        } catch (RemoteException e) {
                        }
                    }
                    app.trimMemoryLevel = curLevel;
                    step += SHOW_ERROR_MSG;
                    if (step >= factor) {
                        step = MY_PID;
                        switch (curLevel) {
                            case 60:
                                curLevel = START_PROFILES_MSG;
                                break;
                            case HdmiCecKeycode.UI_BROADCAST_DIGITAL /*80*/:
                                curLevel = 60;
                                break;
                            default:
                                break;
                        }
                    }
                } else if (app.curProcState == WAIT_FOR_DEBUGGER_MSG) {
                    if (app.trimMemoryLevel < START_PROFILES_MSG && app.thread != null) {
                        try {
                            app.thread.scheduleTrimMemory(START_PROFILES_MSG);
                        } catch (RemoteException e2) {
                        }
                    }
                    app.trimMemoryLevel = START_PROFILES_MSG;
                } else {
                    if ((app.curProcState >= UPDATE_CONFIGURATION_MSG || app.systemNoUi) && app.pendingUiClean) {
                        if (app.trimMemoryLevel < PROC_START_TIMEOUT_MSG && app.thread != null) {
                            try {
                                app.thread.scheduleTrimMemory(PROC_START_TIMEOUT_MSG);
                            } catch (RemoteException e3) {
                            }
                        }
                        app.pendingUiClean = VALIDATE_TOKENS;
                    }
                    if (app.trimMemoryLevel < fgTrimLevel && app.thread != null) {
                        try {
                            app.thread.scheduleTrimMemory(fgTrimLevel);
                        } catch (RemoteException e4) {
                        }
                    }
                    app.trimMemoryLevel = fgTrimLevel;
                }
            }
        } else {
            if (this.mLowRamStartTime != 0) {
                this.mLowRamTimeSinceLastIdle += now - this.mLowRamStartTime;
                this.mLowRamStartTime = 0;
            }
            for (i = N - 1; i >= 0; i--) {
                app = (ProcessRecord) this.mLruProcesses.get(i);
                if (allChanged || app.procStateChanged) {
                    setProcessTrackerStateLocked(app, trackerMemFactor, now);
                    app.procStateChanged = VALIDATE_TOKENS;
                }
                if ((app.curProcState >= UPDATE_CONFIGURATION_MSG || app.systemNoUi) && app.pendingUiClean) {
                    if (app.trimMemoryLevel < PROC_START_TIMEOUT_MSG && app.thread != null) {
                        try {
                            app.thread.scheduleTrimMemory(PROC_START_TIMEOUT_MSG);
                        } catch (RemoteException e5) {
                        }
                    }
                    app.pendingUiClean = VALIDATE_TOKENS;
                }
                app.trimMemoryLevel = MY_PID;
            }
        }
        if (this.mAlwaysFinishActivities) {
            this.mStackSupervisor.scheduleDestroyAllActivities(null, "always-finish");
        }
        if (allChanged) {
            requestPssAllProcsLocked(now, VALIDATE_TOKENS, this.mProcessStats.isMemFactorLowered());
        }
        if (this.mProcessStats.shouldWriteNowLocked(now)) {
            this.mHandler.post(new Runnable() {
                public void run() {
                    synchronized (ActivityManagerService.this) {
                        ActivityManagerService.this.mProcessStats.writeStateAsyncLocked();
                    }
                }
            });
        }
    }

    final void trimApplications() {
        synchronized (this) {
            for (int i = this.mRemovedProcesses.size() - 1; i >= 0; i--) {
                ProcessRecord app = (ProcessRecord) this.mRemovedProcesses.get(i);
                if (app.activities.size() == 0 && app.curReceiver == null && app.services.size() == 0) {
                    Object asBinder;
                    String str = TAG;
                    StringBuilder append = new StringBuilder().append("Exiting empty application process ").append(app.processName).append(" (");
                    if (app.thread != null) {
                        asBinder = app.thread.asBinder();
                    } else {
                        asBinder = null;
                    }
                    Slog.i(str, append.append(asBinder).append(")\n").toString());
                    if (app.pid <= 0 || app.pid == MY_PID) {
                        try {
                            app.thread.scheduleExit();
                        } catch (Exception e) {
                        }
                    } else {
                        app.kill("empty", VALIDATE_TOKENS);
                    }
                    cleanUpApplicationRecordLocked(app, VALIDATE_TOKENS, SHOW_ACTIVITY_START_TIME, -1);
                    this.mRemovedProcesses.remove(i);
                    if (app.persistent) {
                        addAppLocked(app.info, VALIDATE_TOKENS, null);
                    }
                }
            }
            updateOomAdjLocked();
        }
    }

    public void signalPersistentProcesses(int sig) throws RemoteException {
        if (sig != 10) {
            throw new SecurityException("Only SIGNAL_USR1 is allowed");
        }
        synchronized (this) {
            if (checkCallingPermission("android.permission.SIGNAL_PERSISTENT_PROCESSES") != 0) {
                throw new SecurityException("Requires permission android.permission.SIGNAL_PERSISTENT_PROCESSES");
            }
            for (int i = this.mLruProcesses.size() - 1; i >= 0; i--) {
                ProcessRecord r = (ProcessRecord) this.mLruProcesses.get(i);
                if (r.thread != null && r.persistent) {
                    Process.sendSignal(r.pid, sig);
                }
            }
        }
    }

    private void stopProfilerLocked(ProcessRecord proc, int profileType) {
        if (proc == null || proc == this.mProfileProc) {
            proc = this.mProfileProc;
            profileType = this.mProfileType;
            clearProfilerLocked();
        }
        if (proc != null) {
            try {
                proc.thread.profilerControl(VALIDATE_TOKENS, null, profileType);
            } catch (RemoteException e) {
                throw new IllegalStateException("Process disappeared");
            }
        }
    }

    private void clearProfilerLocked() {
        if (this.mProfileFd != null) {
            try {
                this.mProfileFd.close();
            } catch (IOException e) {
            }
        }
        this.mProfileApp = null;
        this.mProfileProc = null;
        this.mProfileFile = null;
        this.mProfileType = MY_PID;
        this.mAutoStopProfiler = VALIDATE_TOKENS;
        this.mSamplingInterval = MY_PID;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public boolean profileControl(java.lang.String r7, int r8, boolean r9, android.app.ProfilerInfo r10, int r11) throws android.os.RemoteException {
        /*
        r6 = this;
        monitor-enter(r6);	 Catch:{ RemoteException -> 0x0014 }
        r3 = "android.permission.SET_ACTIVITY_WATCHER";
        r3 = r6.checkCallingPermission(r3);	 Catch:{ all -> 0x0011 }
        if (r3 == 0) goto L_0x002a;
    L_0x0009:
        r3 = new java.lang.SecurityException;	 Catch:{ all -> 0x0011 }
        r4 = "Requires permission android.permission.SET_ACTIVITY_WATCHER";
        r3.<init>(r4);	 Catch:{ all -> 0x0011 }
        throw r3;	 Catch:{ all -> 0x0011 }
    L_0x0011:
        r3 = move-exception;
        monitor-exit(r6);	 Catch:{ all -> 0x0011 }
        throw r3;	 Catch:{ RemoteException -> 0x0014 }
    L_0x0014:
        r0 = move-exception;
        r3 = new java.lang.IllegalStateException;	 Catch:{ all -> 0x001d }
        r4 = "Process disappeared";
        r3.<init>(r4);	 Catch:{ all -> 0x001d }
        throw r3;	 Catch:{ all -> 0x001d }
    L_0x001d:
        r3 = move-exception;
        if (r10 == 0) goto L_0x0029;
    L_0x0020:
        r4 = r10.profileFd;
        if (r4 == 0) goto L_0x0029;
    L_0x0024:
        r4 = r10.profileFd;	 Catch:{ IOException -> 0x00a9 }
        r4.close();	 Catch:{ IOException -> 0x00a9 }
    L_0x0029:
        throw r3;
    L_0x002a:
        if (r9 == 0) goto L_0x003a;
    L_0x002c:
        if (r10 == 0) goto L_0x0032;
    L_0x002e:
        r3 = r10.profileFd;	 Catch:{ all -> 0x0011 }
        if (r3 != 0) goto L_0x003a;
    L_0x0032:
        r3 = new java.lang.IllegalArgumentException;	 Catch:{ all -> 0x0011 }
        r4 = "null profile info or fd";
        r3.<init>(r4);	 Catch:{ all -> 0x0011 }
        throw r3;	 Catch:{ all -> 0x0011 }
    L_0x003a:
        r2 = 0;
        if (r7 == 0) goto L_0x0043;
    L_0x003d:
        r3 = "profileControl";
        r2 = r6.findProcessLocked(r7, r8, r3);	 Catch:{ all -> 0x0011 }
    L_0x0043:
        if (r9 == 0) goto L_0x0064;
    L_0x0045:
        if (r2 == 0) goto L_0x004b;
    L_0x0047:
        r3 = r2.thread;	 Catch:{ all -> 0x0011 }
        if (r3 != 0) goto L_0x0064;
    L_0x004b:
        r3 = new java.lang.IllegalArgumentException;	 Catch:{ all -> 0x0011 }
        r4 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0011 }
        r4.<init>();	 Catch:{ all -> 0x0011 }
        r5 = "Unknown process: ";
        r4 = r4.append(r5);	 Catch:{ all -> 0x0011 }
        r4 = r4.append(r7);	 Catch:{ all -> 0x0011 }
        r4 = r4.toString();	 Catch:{ all -> 0x0011 }
        r3.<init>(r4);	 Catch:{ all -> 0x0011 }
        throw r3;	 Catch:{ all -> 0x0011 }
    L_0x0064:
        if (r9 == 0) goto L_0x0098;
    L_0x0066:
        r3 = 0;
        r4 = 0;
        r6.stopProfilerLocked(r3, r4);	 Catch:{ all -> 0x0011 }
        r3 = r2.info;	 Catch:{ all -> 0x0011 }
        r4 = r2.processName;	 Catch:{ all -> 0x0011 }
        r6.setProfileApp(r3, r4, r10);	 Catch:{ all -> 0x0011 }
        r6.mProfileProc = r2;	 Catch:{ all -> 0x0011 }
        r6.mProfileType = r11;	 Catch:{ all -> 0x0011 }
        r1 = r10.profileFd;	 Catch:{ all -> 0x0011 }
        r1 = r1.dup();	 Catch:{ IOException -> 0x0095 }
    L_0x007c:
        r10.profileFd = r1;	 Catch:{ all -> 0x0011 }
        r3 = r2.thread;	 Catch:{ all -> 0x0011 }
        r3.profilerControl(r9, r10, r11);	 Catch:{ all -> 0x0011 }
        r1 = 0;
        r3 = 0;
        r6.mProfileFd = r3;	 Catch:{ all -> 0x0011 }
    L_0x0087:
        r3 = 1;
        monitor-exit(r6);	 Catch:{ all -> 0x0011 }
        if (r10 == 0) goto L_0x0094;
    L_0x008b:
        r4 = r10.profileFd;
        if (r4 == 0) goto L_0x0094;
    L_0x008f:
        r4 = r10.profileFd;	 Catch:{ IOException -> 0x00ac }
        r4.close();	 Catch:{ IOException -> 0x00ac }
    L_0x0094:
        return r3;
    L_0x0095:
        r0 = move-exception;
        r1 = 0;
        goto L_0x007c;
    L_0x0098:
        r6.stopProfilerLocked(r2, r11);	 Catch:{ all -> 0x0011 }
        if (r10 == 0) goto L_0x0087;
    L_0x009d:
        r3 = r10.profileFd;	 Catch:{ all -> 0x0011 }
        if (r3 == 0) goto L_0x0087;
    L_0x00a1:
        r3 = r10.profileFd;	 Catch:{ IOException -> 0x00a7 }
        r3.close();	 Catch:{ IOException -> 0x00a7 }
        goto L_0x0087;
    L_0x00a7:
        r3 = move-exception;
        goto L_0x0087;
    L_0x00a9:
        r4 = move-exception;
        goto L_0x0029;
    L_0x00ac:
        r4 = move-exception;
        goto L_0x0094;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.am.ActivityManagerService.profileControl(java.lang.String, int, boolean, android.app.ProfilerInfo, int):boolean");
    }

    private ProcessRecord findProcessLocked(String process, int userId, String callName) {
        userId = handleIncomingUser(Binder.getCallingPid(), Binder.getCallingUid(), userId, (boolean) SHOW_ACTIVITY_START_TIME, (int) SHOW_NOT_RESPONDING_MSG, callName, null);
        ProcessRecord proc = null;
        try {
            int pid = Integer.parseInt(process);
            synchronized (this.mPidsSelfLocked) {
                proc = (ProcessRecord) this.mPidsSelfLocked.get(pid);
            }
        } catch (NumberFormatException e) {
        }
        if (proc != null) {
            return proc;
        }
        SparseArray<ProcessRecord> procs = (SparseArray) this.mProcessNames.getMap().get(process);
        if (procs == null || procs.size() <= 0) {
            return proc;
        }
        proc = (ProcessRecord) procs.valueAt(MY_PID);
        if (userId == -1 || proc.userId == userId) {
            return proc;
        }
        for (int i = SHOW_ERROR_MSG; i < procs.size(); i += SHOW_ERROR_MSG) {
            ProcessRecord thisProc = (ProcessRecord) procs.valueAt(i);
            if (thisProc.userId == userId) {
                return thisProc;
            }
        }
        return proc;
    }

    public boolean dumpHeap(String process, int userId, boolean managed, String path, ParcelFileDescriptor fd) throws RemoteException {
        try {
            synchronized (this) {
                if (checkCallingPermission("android.permission.SET_ACTIVITY_WATCHER") != 0) {
                    throw new SecurityException("Requires permission android.permission.SET_ACTIVITY_WATCHER");
                } else if (fd == null) {
                    throw new IllegalArgumentException("null fd");
                } else {
                    ProcessRecord proc = findProcessLocked(process, userId, "dumpHeap");
                    if (proc == null || proc.thread == null) {
                        throw new IllegalArgumentException("Unknown process: " + process);
                    } else if ("1".equals(SystemProperties.get(SYSTEM_DEBUGGABLE, "0")) || (proc.info.flags & SHOW_NOT_RESPONDING_MSG) != 0) {
                        proc.thread.dumpHeap(managed, path, fd);
                        fd = null;
                    } else {
                        throw new SecurityException("Process not debuggable: " + proc);
                    }
                }
            }
            if (fd != null) {
                try {
                    fd.close();
                } catch (IOException e) {
                }
            }
            return SHOW_ACTIVITY_START_TIME;
        } catch (RemoteException e2) {
            try {
                throw new IllegalStateException("Process disappeared");
            } catch (Throwable th) {
                if (fd != null) {
                    try {
                        fd.close();
                    } catch (IOException e3) {
                    }
                }
            }
        }
    }

    public void monitor() {
        synchronized (this) {
        }
    }

    void onCoreSettingsChange(Bundle settings) {
        for (int i = this.mLruProcesses.size() - 1; i >= 0; i--) {
            ProcessRecord processRecord = (ProcessRecord) this.mLruProcesses.get(i);
            try {
                if (processRecord.thread != null) {
                    processRecord.thread.setCoreSettings(settings);
                }
            } catch (RemoteException e) {
            }
        }
    }

    public boolean startUserInBackground(int userId) {
        return startUser(userId, VALIDATE_TOKENS);
    }

    boolean startUserInForeground(int userId, Dialog dlg) {
        boolean result = startUser(userId, SHOW_ACTIVITY_START_TIME);
        dlg.dismiss();
        return result;
    }

    private void updateCurrentProfileIdsLocked() {
        int i;
        List<UserInfo> profiles = getUserManagerLocked().getProfiles(this.mCurrentUserId, VALIDATE_TOKENS);
        int[] currentProfileIds = new int[profiles.size()];
        for (i = MY_PID; i < currentProfileIds.length; i += SHOW_ERROR_MSG) {
            currentProfileIds[i] = ((UserInfo) profiles.get(i)).id;
        }
        this.mCurrentProfileIds = currentProfileIds;
        synchronized (this.mUserProfileGroupIdsSelfLocked) {
            this.mUserProfileGroupIdsSelfLocked.clear();
            List<UserInfo> users = getUserManagerLocked().getUsers(VALIDATE_TOKENS);
            for (i = MY_PID; i < users.size(); i += SHOW_ERROR_MSG) {
                UserInfo user = (UserInfo) users.get(i);
                if (user.profileGroupId != -1) {
                    this.mUserProfileGroupIdsSelfLocked.put(user.id, user.profileGroupId);
                }
            }
        }
    }

    private Set getProfileIdsLocked(int userId) {
        Set userIds = new HashSet();
        for (UserInfo user : getUserManagerLocked().getProfiles(userId, VALIDATE_TOKENS)) {
            userIds.add(Integer.valueOf(user.id));
        }
        return userIds;
    }

    public boolean switchUser(int userId) {
        enforceShellRestriction("no_debugging_features", userId);
        synchronized (this) {
            UserInfo userInfo = getUserManagerLocked().getUserInfo(userId);
            if (userInfo == null) {
                Slog.w(TAG, "No user info for user #" + userId);
                return VALIDATE_TOKENS;
            } else if (userInfo.isManagedProfile()) {
                Slog.w(TAG, "Cannot switch to User #" + userId + ": not a full user");
                return VALIDATE_TOKENS;
            } else {
                String userName = userInfo.name;
                this.mTargetUserId = userId;
                this.mHandler.removeMessages(START_USER_SWITCH_MSG);
                this.mHandler.sendMessage(this.mHandler.obtainMessage(START_USER_SWITCH_MSG, userId, MY_PID, userName));
                return SHOW_ACTIVITY_START_TIME;
            }
        }
    }

    private void showUserSwitchDialog(int userId, String userName) {
        new UserSwitchingDialog(this, this.mContext, userId, userName, SHOW_ACTIVITY_START_TIME).show();
    }

    private boolean startUser(int userId, boolean foreground) {
        if (checkCallingPermission("android.permission.INTERACT_ACROSS_USERS_FULL") != 0) {
            String msg = "Permission Denial: switchUser() from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " requires " + "android.permission.INTERACT_ACROSS_USERS_FULL";
            Slog.w(TAG, msg);
            throw new SecurityException(msg);
        }
        long ident = Binder.clearCallingIdentity();
        try {
            synchronized (this) {
                int oldUserId = this.mCurrentUserId;
                if (oldUserId == userId) {
                    return SHOW_ACTIVITY_START_TIME;
                }
                this.mStackSupervisor.setLockTaskModeLocked(null, VALIDATE_TOKENS, "startUser");
                UserInfo userInfo = getUserManagerLocked().getUserInfo(userId);
                if (userInfo == null) {
                    Slog.w(TAG, "No user info for user #" + userId);
                    Binder.restoreCallingIdentity(ident);
                    return VALIDATE_TOKENS;
                }
                Intent intent;
                if (foreground) {
                    if (userInfo.isManagedProfile()) {
                        Slog.w(TAG, "Cannot switch to User #" + userId + ": not a full user");
                        Binder.restoreCallingIdentity(ident);
                        return VALIDATE_TOKENS;
                    }
                }
                if (foreground) {
                    this.mWindowManager.startFreezingScreen(17432665, 17432664);
                }
                boolean needStart = VALIDATE_TOKENS;
                if (this.mStartedUsers.get(userId) == null) {
                    this.mStartedUsers.put(userId, new UserStartedState(new UserHandle(userId), VALIDATE_TOKENS));
                    updateStartedUserArrayLocked();
                    needStart = SHOW_ACTIVITY_START_TIME;
                }
                Integer userIdInt = Integer.valueOf(userId);
                this.mUserLru.remove(userIdInt);
                this.mUserLru.add(userIdInt);
                if (foreground) {
                    this.mCurrentUserId = userId;
                    this.mTargetUserId = -10000;
                    updateCurrentProfileIdsLocked();
                    this.mWindowManager.setCurrentUser(userId, this.mCurrentProfileIds);
                    this.mWindowManager.lockNow(null);
                } else {
                    Integer currentUserIdInt = Integer.valueOf(this.mCurrentUserId);
                    updateCurrentProfileIdsLocked();
                    this.mWindowManager.setCurrentProfileIds(this.mCurrentProfileIds);
                    this.mUserLru.remove(currentUserIdInt);
                    this.mUserLru.add(currentUserIdInt);
                }
                UserStartedState uss = (UserStartedState) this.mStartedUsers.get(userId);
                if (uss.mState == SHOW_NOT_RESPONDING_MSG) {
                    uss.mState = SHOW_ERROR_MSG;
                    updateStartedUserArrayLocked();
                    needStart = SHOW_ACTIVITY_START_TIME;
                } else if (uss.mState == SHOW_FACTORY_ERROR_MSG) {
                    uss.mState = MY_PID;
                    updateStartedUserArrayLocked();
                    needStart = SHOW_ACTIVITY_START_TIME;
                }
                if (uss.mState == 0) {
                    this.mHandler.sendMessage(this.mHandler.obtainMessage(SYSTEM_USER_START_MSG, userId, MY_PID));
                }
                if (foreground) {
                    this.mHandler.sendMessage(this.mHandler.obtainMessage(SYSTEM_USER_CURRENT_MSG, userId, oldUserId));
                    this.mHandler.removeMessages(REPORT_USER_SWITCH_MSG);
                    this.mHandler.removeMessages(USER_SWITCH_TIMEOUT_MSG);
                    this.mHandler.sendMessage(this.mHandler.obtainMessage(REPORT_USER_SWITCH_MSG, oldUserId, userId, uss));
                    this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(USER_SWITCH_TIMEOUT_MSG, oldUserId, userId, uss), 2000);
                }
                if (needStart) {
                    intent = new Intent("android.intent.action.USER_STARTED");
                    intent.addFlags(1342177280);
                    intent.putExtra("android.intent.extra.user_handle", userId);
                    broadcastIntentLocked(null, null, intent, null, null, MY_PID, null, null, null, -1, VALIDATE_TOKENS, VALIDATE_TOKENS, MY_PID, NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY, userId);
                }
                if ((userInfo.flags & 16) == 0) {
                    if (userId != 0) {
                        intent = new Intent("android.intent.action.USER_INITIALIZE");
                        intent.addFlags(268435456);
                        AnonymousClass24 anonymousClass24 = new AnonymousClass24(uss, foreground, oldUserId, userId);
                        broadcastIntentLocked(null, null, intent, null, r8, MY_PID, null, null, null, -1, SHOW_ACTIVITY_START_TIME, VALIDATE_TOKENS, MY_PID, NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY, userId);
                        uss.initializing = SHOW_ACTIVITY_START_TIME;
                    } else {
                        getUserManagerLocked().makeInitialized(userInfo.id);
                    }
                }
                if (!foreground) {
                    this.mStackSupervisor.startBackgroundUserLocked(userId, uss);
                } else if (!uss.initializing) {
                    moveUserToForeground(uss, oldUserId, userId);
                }
                if (needStart) {
                    intent = new Intent("android.intent.action.USER_STARTING");
                    intent.addFlags(1073741824);
                    intent.putExtra("android.intent.extra.user_handle", userId);
                    broadcastIntentLocked(null, null, intent, null, new Stub() {
                        public void performReceive(Intent intent, int resultCode, String data, Bundle extras, boolean ordered, boolean sticky, int sendingUser) throws RemoteException {
                        }
                    }, MY_PID, null, null, "android.permission.INTERACT_ACROSS_USERS", -1, SHOW_ACTIVITY_START_TIME, VALIDATE_TOKENS, MY_PID, NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY, -1);
                }
                Binder.restoreCallingIdentity(ident);
                return SHOW_ACTIVITY_START_TIME;
            }
        } finally {
            Binder.restoreCallingIdentity(ident);
        }
    }

    void sendUserSwitchBroadcastsLocked(int oldUserId, int newUserId) {
        List<UserInfo> profiles;
        int count;
        int i;
        long ident = Binder.clearCallingIdentity();
        if (oldUserId >= 0) {
            try {
                profiles = this.mUserManager.getProfiles(oldUserId, VALIDATE_TOKENS);
                count = profiles.size();
                for (i = MY_PID; i < count; i += SHOW_ERROR_MSG) {
                    int profileUserId = ((UserInfo) profiles.get(i)).id;
                    Intent intent = new Intent("android.intent.action.USER_BACKGROUND");
                    intent.addFlags(1342177280);
                    intent.putExtra("android.intent.extra.user_handle", profileUserId);
                    broadcastIntentLocked(null, null, intent, null, null, MY_PID, null, null, null, -1, VALIDATE_TOKENS, VALIDATE_TOKENS, MY_PID, NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY, profileUserId);
                }
            } catch (Throwable th) {
                Binder.restoreCallingIdentity(ident);
            }
        }
        if (newUserId >= 0) {
            profiles = this.mUserManager.getProfiles(newUserId, VALIDATE_TOKENS);
            count = profiles.size();
            for (i = MY_PID; i < count; i += SHOW_ERROR_MSG) {
                profileUserId = ((UserInfo) profiles.get(i)).id;
                intent = new Intent("android.intent.action.USER_FOREGROUND");
                intent.addFlags(1342177280);
                intent.putExtra("android.intent.extra.user_handle", profileUserId);
                broadcastIntentLocked(null, null, intent, null, null, MY_PID, null, null, null, -1, VALIDATE_TOKENS, VALIDATE_TOKENS, MY_PID, NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY, profileUserId);
            }
            intent = new Intent("android.intent.action.USER_SWITCHED");
            intent.addFlags(1342177280);
            intent.putExtra("android.intent.extra.user_handle", newUserId);
            broadcastIntentLocked(null, null, intent, null, null, MY_PID, null, null, "android.permission.MANAGE_USERS", -1, VALIDATE_TOKENS, VALIDATE_TOKENS, MY_PID, NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY, -1);
        }
        Binder.restoreCallingIdentity(ident);
    }

    void dispatchUserSwitch(UserStartedState uss, int oldUserId, int newUserId) {
        int N = this.mUserSwitchObservers.beginBroadcast();
        if (N > 0) {
            IRemoteCallback callback = new AnonymousClass26(N, uss, oldUserId, newUserId);
            synchronized (this) {
                uss.switching = SHOW_ACTIVITY_START_TIME;
                this.mCurUserSwitchCallback = callback;
            }
            for (int i = MY_PID; i < N; i += SHOW_ERROR_MSG) {
                try {
                    ((IUserSwitchObserver) this.mUserSwitchObservers.getBroadcastItem(i)).onUserSwitching(newUserId, callback);
                } catch (RemoteException e) {
                }
            }
        } else {
            synchronized (this) {
                sendContinueUserSwitchLocked(uss, oldUserId, newUserId);
            }
        }
        this.mUserSwitchObservers.finishBroadcast();
    }

    void timeoutUserSwitch(UserStartedState uss, int oldUserId, int newUserId) {
        synchronized (this) {
            Slog.w(TAG, "User switch timeout: from " + oldUserId + " to " + newUserId);
            sendContinueUserSwitchLocked(uss, oldUserId, newUserId);
        }
    }

    void sendContinueUserSwitchLocked(UserStartedState uss, int oldUserId, int newUserId) {
        this.mCurUserSwitchCallback = null;
        this.mHandler.removeMessages(USER_SWITCH_TIMEOUT_MSG);
        this.mHandler.sendMessage(this.mHandler.obtainMessage(CONTINUE_USER_SWITCH_MSG, oldUserId, newUserId, uss));
    }

    void onUserInitialized(UserStartedState uss, boolean foreground, int oldUserId, int newUserId) {
        synchronized (this) {
            if (foreground) {
                moveUserToForeground(uss, oldUserId, newUserId);
            }
        }
        completeSwitchAndInitalize(uss, newUserId, SHOW_ACTIVITY_START_TIME, VALIDATE_TOKENS);
    }

    void moveUserToForeground(UserStartedState uss, int oldUserId, int newUserId) {
        if (this.mStackSupervisor.switchUserLocked(newUserId, uss)) {
            startHomeActivityLocked(newUserId, "moveUserToFroreground");
        } else {
            this.mStackSupervisor.resumeTopActivitiesLocked();
        }
        EventLogTags.writeAmSwitchUser(newUserId);
        getUserManagerLocked().userForeground(newUserId);
        sendUserSwitchBroadcastsLocked(oldUserId, newUserId);
    }

    void continueUserSwitch(UserStartedState uss, int oldUserId, int newUserId) {
        completeSwitchAndInitalize(uss, newUserId, VALIDATE_TOKENS, SHOW_ACTIVITY_START_TIME);
    }

    void completeSwitchAndInitalize(UserStartedState uss, int newUserId, boolean clearInitializing, boolean clearSwitching) {
        boolean unfrozen = VALIDATE_TOKENS;
        synchronized (this) {
            if (clearInitializing) {
                uss.initializing = VALIDATE_TOKENS;
                getUserManagerLocked().makeInitialized(uss.mHandle.getIdentifier());
            }
            if (clearSwitching) {
                uss.switching = VALIDATE_TOKENS;
            }
            if (!(uss.switching || uss.initializing)) {
                this.mWindowManager.stopFreezingScreen();
                unfrozen = SHOW_ACTIVITY_START_TIME;
            }
        }
        if (unfrozen) {
            int N = this.mUserSwitchObservers.beginBroadcast();
            for (int i = MY_PID; i < N; i += SHOW_ERROR_MSG) {
                try {
                    ((IUserSwitchObserver) this.mUserSwitchObservers.getBroadcastItem(i)).onUserSwitchComplete(newUserId);
                } catch (RemoteException e) {
                }
            }
            this.mUserSwitchObservers.finishBroadcast();
        }
        stopGuestUserIfBackground();
    }

    private void stopGuestUserIfBackground() {
        synchronized (this) {
            int num = this.mUserLru.size();
            for (int i = MY_PID; i < num; i += SHOW_ERROR_MSG) {
                Integer oldUserId = (Integer) this.mUserLru.get(i);
                UserStartedState oldUss = (UserStartedState) this.mStartedUsers.get(oldUserId.intValue());
                if (oldUserId.intValue() != 0 && oldUserId.intValue() != this.mCurrentUserId && oldUss.mState != SHOW_NOT_RESPONDING_MSG && oldUss.mState != SHOW_FACTORY_ERROR_MSG && this.mUserManager.getUserInfo(oldUserId.intValue()).isGuest()) {
                    stopUserLocked(oldUserId.intValue(), null);
                    break;
                }
            }
        }
    }

    void scheduleStartProfilesLocked() {
        if (!this.mHandler.hasMessages(START_PROFILES_MSG)) {
            this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(START_PROFILES_MSG), 1000);
        }
    }

    void startProfilesLocked() {
        List<UserInfo> profiles = getUserManagerLocked().getProfiles(this.mCurrentUserId, VALIDATE_TOKENS);
        List<UserInfo> toStart = new ArrayList(profiles.size());
        for (UserInfo user : profiles) {
            if ((user.flags & 16) == 16 && user.id != this.mCurrentUserId) {
                toStart.add(user);
            }
        }
        int n = toStart.size();
        int i = MY_PID;
        while (i < n && i < SHOW_NOT_RESPONDING_MSG) {
            startUserInBackground(((UserInfo) toStart.get(i)).id);
            i += SHOW_ERROR_MSG;
        }
        if (i < n) {
            Slog.w(TAG_MU, "More profiles than MAX_RUNNING_USERS");
        }
    }

    void finishUserBoot(UserStartedState uss) {
        synchronized (this) {
            if (uss.mState == 0 && this.mStartedUsers.get(uss.mHandle.getIdentifier()) == uss) {
                uss.mState = SHOW_ERROR_MSG;
                int userId = uss.mHandle.getIdentifier();
                Intent intent = new Intent("android.intent.action.BOOT_COMPLETED", null);
                intent.putExtra("android.intent.extra.user_handle", userId);
                intent.addFlags(134217728);
                broadcastIntentLocked(null, null, intent, null, null, MY_PID, null, null, "android.permission.RECEIVE_BOOT_COMPLETED", 53, SHOW_ACTIVITY_START_TIME, VALIDATE_TOKENS, MY_PID, NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY, userId);
            }
        }
    }

    void finishUserSwitch(UserStartedState uss) {
        synchronized (this) {
            finishUserBoot(uss);
            startProfilesLocked();
            int num = this.mUserLru.size();
            int i = MY_PID;
            while (num > SHOW_FACTORY_ERROR_MSG && i < this.mUserLru.size()) {
                Integer oldUserId = (Integer) this.mUserLru.get(i);
                UserStartedState oldUss = (UserStartedState) this.mStartedUsers.get(oldUserId.intValue());
                if (oldUss == null) {
                    this.mUserLru.remove(i);
                    num--;
                } else if (oldUss.mState == SHOW_NOT_RESPONDING_MSG || oldUss.mState == SHOW_FACTORY_ERROR_MSG) {
                    num--;
                    i += SHOW_ERROR_MSG;
                } else if (oldUserId.intValue() == 0 || oldUserId.intValue() == this.mCurrentUserId) {
                    i += SHOW_ERROR_MSG;
                } else {
                    stopUserLocked(oldUserId.intValue(), null);
                    num--;
                    i += SHOW_ERROR_MSG;
                }
            }
        }
    }

    public int stopUser(int userId, IStopUserCallback callback) {
        if (checkCallingPermission("android.permission.INTERACT_ACROSS_USERS_FULL") != 0) {
            String msg = "Permission Denial: switchUser() from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " requires " + "android.permission.INTERACT_ACROSS_USERS_FULL";
            Slog.w(TAG, msg);
            throw new SecurityException(msg);
        } else if (userId <= 0) {
            throw new IllegalArgumentException("Can't stop primary user " + userId);
        } else {
            int stopUserLocked;
            enforceShellRestriction("no_debugging_features", userId);
            synchronized (this) {
                stopUserLocked = stopUserLocked(userId, callback);
            }
            return stopUserLocked;
        }
    }

    private int stopUserLocked(int userId, IStopUserCallback callback) {
        if (this.mCurrentUserId == userId && this.mTargetUserId == -10000) {
            return -2;
        }
        UserStartedState uss = (UserStartedState) this.mStartedUsers.get(userId);
        if (uss == null) {
            if (callback != null) {
                this.mHandler.post(new AnonymousClass27(callback, userId));
            }
            return MY_PID;
        }
        if (callback != null) {
            uss.mStopCallbacks.add(callback);
        }
        if (!(uss.mState == SHOW_NOT_RESPONDING_MSG || uss.mState == SHOW_FACTORY_ERROR_MSG)) {
            uss.mState = SHOW_NOT_RESPONDING_MSG;
            updateStartedUserArrayLocked();
            long ident = Binder.clearCallingIdentity();
            try {
                Intent stoppingIntent = new Intent("android.intent.action.USER_STOPPING");
                stoppingIntent.addFlags(1073741824);
                stoppingIntent.putExtra("android.intent.extra.user_handle", userId);
                stoppingIntent.putExtra("android.intent.extra.SHUTDOWN_USERSPACE_ONLY", SHOW_ACTIVITY_START_TIME);
                IIntentReceiver anonymousClass29 = new AnonymousClass29(uss, userId, new Intent("android.intent.action.ACTION_SHUTDOWN"), new AnonymousClass28(uss));
                broadcastIntentLocked(null, null, stoppingIntent, null, stoppingReceiver, MY_PID, null, null, "android.permission.INTERACT_ACROSS_USERS", -1, SHOW_ACTIVITY_START_TIME, VALIDATE_TOKENS, MY_PID, NOTIFY_TASK_STACK_CHANGE_LISTENERS_DELAY, -1);
            } finally {
                Binder.restoreCallingIdentity(ident);
            }
        }
        return MY_PID;
    }

    void finishUserStop(UserStartedState uss) {
        boolean stopped;
        int userId = uss.mHandle.getIdentifier();
        synchronized (this) {
            ArrayList<IStopUserCallback> callbacks = new ArrayList(uss.mStopCallbacks);
            if (this.mStartedUsers.get(userId) != uss) {
                stopped = VALIDATE_TOKENS;
            } else if (uss.mState != SHOW_FACTORY_ERROR_MSG) {
                stopped = VALIDATE_TOKENS;
            } else {
                stopped = SHOW_ACTIVITY_START_TIME;
                this.mStartedUsers.remove(userId);
                this.mUserLru.remove(Integer.valueOf(userId));
                updateStartedUserArrayLocked();
                forceStopUserLocked(userId, "finish user");
            }
            removeRecentTasksForUserLocked(userId);
        }
        for (int i = MY_PID; i < callbacks.size(); i += SHOW_ERROR_MSG) {
            if (stopped) {
                try {
                    ((IStopUserCallback) callbacks.get(i)).userStopped(userId);
                } catch (RemoteException e) {
                }
            } else {
                ((IStopUserCallback) callbacks.get(i)).userStopAborted(userId);
            }
        }
        if (stopped) {
            this.mSystemServiceManager.cleanupUser(userId);
            synchronized (this) {
                this.mStackSupervisor.removeUserLocked(userId);
            }
        }
    }

    public UserInfo getCurrentUser() {
        if (checkCallingPermission("android.permission.INTERACT_ACROSS_USERS") == 0 || checkCallingPermission("android.permission.INTERACT_ACROSS_USERS_FULL") == 0) {
            UserInfo userInfo;
            synchronized (this) {
                userInfo = getUserManagerLocked().getUserInfo(this.mTargetUserId != -10000 ? this.mTargetUserId : this.mCurrentUserId);
            }
            return userInfo;
        }
        String msg = "Permission Denial: getCurrentUser() from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " requires " + "android.permission.INTERACT_ACROSS_USERS";
        Slog.w(TAG, msg);
        throw new SecurityException(msg);
    }

    int getCurrentUserIdLocked() {
        return this.mTargetUserId != -10000 ? this.mTargetUserId : this.mCurrentUserId;
    }

    public boolean isUserRunning(int userId, boolean orStopped) {
        if (checkCallingPermission("android.permission.INTERACT_ACROSS_USERS") != 0) {
            String msg = "Permission Denial: isUserRunning() from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " requires " + "android.permission.INTERACT_ACROSS_USERS";
            Slog.w(TAG, msg);
            throw new SecurityException(msg);
        }
        boolean isUserRunningLocked;
        synchronized (this) {
            isUserRunningLocked = isUserRunningLocked(userId, orStopped);
        }
        return isUserRunningLocked;
    }

    boolean isUserRunningLocked(int userId, boolean orStopped) {
        UserStartedState state = (UserStartedState) this.mStartedUsers.get(userId);
        if (state == null) {
            return VALIDATE_TOKENS;
        }
        if (orStopped) {
            return SHOW_ACTIVITY_START_TIME;
        }
        if (state.mState == SHOW_NOT_RESPONDING_MSG || state.mState == SHOW_FACTORY_ERROR_MSG) {
            return VALIDATE_TOKENS;
        }
        return SHOW_ACTIVITY_START_TIME;
    }

    public int[] getRunningUserIds() {
        if (checkCallingPermission("android.permission.INTERACT_ACROSS_USERS") != 0) {
            String msg = "Permission Denial: isUserRunning() from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " requires " + "android.permission.INTERACT_ACROSS_USERS";
            Slog.w(TAG, msg);
            throw new SecurityException(msg);
        }
        int[] iArr;
        synchronized (this) {
            iArr = this.mStartedUserArray;
        }
        return iArr;
    }

    private void updateStartedUserArrayLocked() {
        int i;
        int num = MY_PID;
        for (i = MY_PID; i < this.mStartedUsers.size(); i += SHOW_ERROR_MSG) {
            UserStartedState uss = (UserStartedState) this.mStartedUsers.valueAt(i);
            if (!(uss.mState == SHOW_NOT_RESPONDING_MSG || uss.mState == SHOW_FACTORY_ERROR_MSG)) {
                num += SHOW_ERROR_MSG;
            }
        }
        this.mStartedUserArray = new int[num];
        num = MY_PID;
        for (i = MY_PID; i < this.mStartedUsers.size(); i += SHOW_ERROR_MSG) {
            uss = (UserStartedState) this.mStartedUsers.valueAt(i);
            if (!(uss.mState == SHOW_NOT_RESPONDING_MSG || uss.mState == SHOW_FACTORY_ERROR_MSG)) {
                this.mStartedUserArray[num] = this.mStartedUsers.keyAt(i);
                num += SHOW_ERROR_MSG;
            }
        }
    }

    public void registerUserSwitchObserver(IUserSwitchObserver observer) {
        if (checkCallingPermission("android.permission.INTERACT_ACROSS_USERS_FULL") != 0) {
            String msg = "Permission Denial: registerUserSwitchObserver() from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " requires " + "android.permission.INTERACT_ACROSS_USERS_FULL";
            Slog.w(TAG, msg);
            throw new SecurityException(msg);
        }
        this.mUserSwitchObservers.register(observer);
    }

    public void unregisterUserSwitchObserver(IUserSwitchObserver observer) {
        this.mUserSwitchObservers.unregister(observer);
    }

    private boolean userExists(int userId) {
        if (userId == 0) {
            return SHOW_ACTIVITY_START_TIME;
        }
        UserManagerService ums = getUserManagerLocked();
        if (ums == null) {
            return VALIDATE_TOKENS;
        }
        if (ums.getUserInfo(userId) == null) {
            return VALIDATE_TOKENS;
        }
        return SHOW_ACTIVITY_START_TIME;
    }

    int[] getUsersLocked() {
        UserManagerService ums = getUserManagerLocked();
        if (ums != null) {
            return ums.getUserIds();
        }
        int[] iArr = new int[SHOW_ERROR_MSG];
        iArr[MY_PID] = MY_PID;
        return iArr;
    }

    UserManagerService getUserManagerLocked() {
        if (this.mUserManager == null) {
            this.mUserManager = (UserManagerService) IUserManager.Stub.asInterface(ServiceManager.getService("user"));
        }
        return this.mUserManager;
    }

    private int applyUserId(int uid, int userId) {
        return UserHandle.getUid(userId, uid);
    }

    ApplicationInfo getAppInfoForUser(ApplicationInfo info, int userId) {
        if (info == null) {
            return null;
        }
        ApplicationInfo newInfo = new ApplicationInfo(info);
        newInfo.uid = applyUserId(info.uid, userId);
        newInfo.dataDir = USER_DATA_DIR + userId + "/" + info.packageName;
        return newInfo;
    }

    ActivityInfo getActivityInfoForUser(ActivityInfo aInfo, int userId) {
        if (aInfo == null || (userId < SHOW_ERROR_MSG && aInfo.applicationInfo.uid < 100000)) {
            return aInfo;
        }
        ActivityInfo info = new ActivityInfo(aInfo);
        info.applicationInfo = getAppInfoForUser(info.applicationInfo, userId);
        return info;
    }
}
