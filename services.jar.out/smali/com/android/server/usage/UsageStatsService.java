package com.android.server.usage;

import android.app.AppOpsManager;
import android.app.usage.ConfigurationStats;
import android.app.usage.IUsageStatsManager.Stub;
import android.app.usage.UsageEvents;
import android.app.usage.UsageEvents.Event;
import android.app.usage.UsageStats;
import android.app.usage.UsageStatsManagerInternal;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.ParceledListSlice;
import android.content.pm.UserInfo;
import android.content.res.Configuration;
import android.os.Binder;
import android.os.Environment;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.os.RemoteException;
import android.os.SystemClock;
import android.os.UserHandle;
import android.os.UserManager;
import android.util.ArraySet;
import android.util.Slog;
import android.util.SparseArray;
import com.android.internal.os.BackgroundThread;
import com.android.internal.util.IndentingPrintWriter;
import com.android.server.SystemService;
import java.io.File;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;

public class UsageStatsService extends SystemService implements StatsUpdatedListener {
    static final boolean DEBUG = false;
    private static final long FLUSH_INTERVAL = 1200000;
    static final int MSG_FLUSH_TO_DISK = 1;
    static final int MSG_REMOVE_USER = 2;
    static final int MSG_REPORT_EVENT = 0;
    static final String TAG = "UsageStatsService";
    private static final long TEN_SECONDS = 10000;
    private static final long TIME_CHANGE_THRESHOLD_MILLIS = 2000;
    private static final long TWENTY_MINUTES = 1200000;
    AppOpsManager mAppOps;
    Handler mHandler;
    private final Object mLock;
    long mRealTimeSnapshot;
    long mSystemTimeSnapshot;
    private File mUsageStatsDir;
    UserManager mUserManager;
    private final SparseArray<UserUsageStatsService> mUserState;

    private class BinderService extends Stub {
        private BinderService() {
        }

        private boolean hasPermission(String callingPackage) {
            int callingUid = Binder.getCallingUid();
            if (callingUid == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
                return true;
            }
            int mode = UsageStatsService.this.mAppOps.checkOp(43, callingUid, callingPackage);
            if (mode == 3) {
                if (UsageStatsService.this.getContext().checkCallingPermission("android.permission.PACKAGE_USAGE_STATS") != 0) {
                    return UsageStatsService.DEBUG;
                }
                return true;
            } else if (mode != 0) {
                return UsageStatsService.DEBUG;
            } else {
                return true;
            }
        }

        public ParceledListSlice<UsageStats> queryUsageStats(int bucketType, long beginTime, long endTime, String callingPackage) {
            if (!hasPermission(callingPackage)) {
                return null;
            }
            int userId = UserHandle.getCallingUserId();
            long token = Binder.clearCallingIdentity();
            try {
                List<UsageStats> results = UsageStatsService.this.queryUsageStats(userId, bucketType, beginTime, endTime);
                if (results != null) {
                    ParceledListSlice<UsageStats> parceledListSlice = new ParceledListSlice(results);
                    return parceledListSlice;
                }
                Binder.restoreCallingIdentity(token);
                return null;
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public ParceledListSlice<ConfigurationStats> queryConfigurationStats(int bucketType, long beginTime, long endTime, String callingPackage) throws RemoteException {
            if (!hasPermission(callingPackage)) {
                return null;
            }
            int userId = UserHandle.getCallingUserId();
            long token = Binder.clearCallingIdentity();
            try {
                List<ConfigurationStats> results = UsageStatsService.this.queryConfigurationStats(userId, bucketType, beginTime, endTime);
                if (results != null) {
                    ParceledListSlice<ConfigurationStats> parceledListSlice = new ParceledListSlice(results);
                    return parceledListSlice;
                }
                Binder.restoreCallingIdentity(token);
                return null;
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        public UsageEvents queryEvents(long beginTime, long endTime, String callingPackage) {
            if (!hasPermission(callingPackage)) {
                return null;
            }
            int userId = UserHandle.getCallingUserId();
            long token = Binder.clearCallingIdentity();
            try {
                UsageEvents queryEvents = UsageStatsService.this.queryEvents(userId, beginTime, endTime);
                return queryEvents;
            } finally {
                Binder.restoreCallingIdentity(token);
            }
        }

        protected void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
            if (UsageStatsService.this.getContext().checkCallingOrSelfPermission("android.permission.DUMP") != 0) {
                pw.println("Permission Denial: can't dump UsageStats from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid() + " without permission " + "android.permission.DUMP");
            } else {
                UsageStatsService.this.dump(args, pw);
            }
        }
    }

    /* renamed from: com.android.server.usage.UsageStatsService.H */
    class C0541H extends Handler {
        public C0541H(Looper looper) {
            super(looper);
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case UsageStatsService.MSG_REPORT_EVENT /*0*/:
                    UsageStatsService.this.reportEvent((Event) msg.obj, msg.arg1);
                case UsageStatsService.MSG_FLUSH_TO_DISK /*1*/:
                    UsageStatsService.this.flushToDisk();
                case UsageStatsService.MSG_REMOVE_USER /*2*/:
                    UsageStatsService.this.removeUser(msg.arg1);
                default:
                    super.handleMessage(msg);
            }
        }
    }

    private class LocalService extends UsageStatsManagerInternal {
        private LocalService() {
        }

        public void reportEvent(ComponentName component, int userId, int eventType) {
            if (component == null) {
                Slog.w(UsageStatsService.TAG, "Event reported without a component name");
                return;
            }
            Event event = new Event();
            event.mPackage = component.getPackageName();
            event.mClass = component.getClassName();
            event.mTimeStamp = SystemClock.elapsedRealtime();
            event.mEventType = eventType;
            UsageStatsService.this.mHandler.obtainMessage(UsageStatsService.MSG_REPORT_EVENT, userId, UsageStatsService.MSG_REPORT_EVENT, event).sendToTarget();
        }

        public void reportConfigurationChange(Configuration config, int userId) {
            if (config == null) {
                Slog.w(UsageStatsService.TAG, "Configuration event reported with a null config");
                return;
            }
            Event event = new Event();
            event.mPackage = "android";
            event.mTimeStamp = SystemClock.elapsedRealtime();
            event.mEventType = 5;
            event.mConfiguration = new Configuration(config);
            UsageStatsService.this.mHandler.obtainMessage(UsageStatsService.MSG_REPORT_EVENT, userId, UsageStatsService.MSG_REPORT_EVENT, event).sendToTarget();
        }

        public void prepareShutdown() {
            UsageStatsService.this.shutdown();
        }
    }

    private class UserRemovedReceiver extends BroadcastReceiver {
        private UserRemovedReceiver() {
        }

        public void onReceive(Context context, Intent intent) {
            if (intent != null && intent.getAction().equals("android.intent.action.USER_REMOVED")) {
                int userId = intent.getIntExtra("android.intent.extra.user_handle", -1);
                if (userId >= 0) {
                    UsageStatsService.this.mHandler.obtainMessage(UsageStatsService.MSG_REMOVE_USER, userId, UsageStatsService.MSG_REPORT_EVENT).sendToTarget();
                }
            }
        }
    }

    public UsageStatsService(Context context) {
        super(context);
        this.mLock = new Object();
        this.mUserState = new SparseArray();
    }

    public void onStart() {
        this.mAppOps = (AppOpsManager) getContext().getSystemService("appops");
        this.mUserManager = (UserManager) getContext().getSystemService("user");
        this.mHandler = new C0541H(BackgroundThread.get().getLooper());
        this.mUsageStatsDir = new File(new File(Environment.getDataDirectory(), "system"), "usagestats");
        this.mUsageStatsDir.mkdirs();
        if (this.mUsageStatsDir.exists()) {
            getContext().registerReceiver(new UserRemovedReceiver(), new IntentFilter("android.intent.action.USER_REMOVED"));
            synchronized (this.mLock) {
                cleanUpRemovedUsersLocked();
            }
            this.mRealTimeSnapshot = SystemClock.elapsedRealtime();
            this.mSystemTimeSnapshot = System.currentTimeMillis();
            publishLocalService(UsageStatsManagerInternal.class, new LocalService());
            publishBinderService("usagestats", new BinderService());
            return;
        }
        throw new IllegalStateException("Usage stats directory does not exist: " + this.mUsageStatsDir.getAbsolutePath());
    }

    public void onStatsUpdated() {
        this.mHandler.sendEmptyMessageDelayed(MSG_FLUSH_TO_DISK, TWENTY_MINUTES);
    }

    private void cleanUpRemovedUsersLocked() {
        List<UserInfo> users = this.mUserManager.getUsers(true);
        if (users == null || users.size() == 0) {
            throw new IllegalStateException("There can't be no users");
        }
        ArraySet<String> toDelete = new ArraySet();
        String[] fileNames = this.mUsageStatsDir.list();
        if (fileNames != null) {
            int i;
            toDelete.addAll(Arrays.asList(fileNames));
            int userCount = users.size();
            for (i = MSG_REPORT_EVENT; i < userCount; i += MSG_FLUSH_TO_DISK) {
                toDelete.remove(Integer.toString(((UserInfo) users.get(i)).id));
            }
            int deleteCount = toDelete.size();
            for (i = MSG_REPORT_EVENT; i < deleteCount; i += MSG_FLUSH_TO_DISK) {
                deleteRecursively(new File(this.mUsageStatsDir, (String) toDelete.valueAt(i)));
            }
        }
    }

    private static void deleteRecursively(File f) {
        File[] files = f.listFiles();
        if (files != null) {
            File[] arr$ = files;
            int len$ = arr$.length;
            for (int i$ = MSG_REPORT_EVENT; i$ < len$; i$ += MSG_FLUSH_TO_DISK) {
                deleteRecursively(arr$[i$]);
            }
        }
        if (!f.delete()) {
            Slog.e(TAG, "Failed to delete " + f);
        }
    }

    private UserUsageStatsService getUserDataAndInitializeIfNeededLocked(int userId, long currentTimeMillis) {
        UserUsageStatsService service = (UserUsageStatsService) this.mUserState.get(userId);
        if (service != null) {
            return service;
        }
        service = new UserUsageStatsService(getContext(), userId, new File(this.mUsageStatsDir, Integer.toString(userId)), this);
        service.init(currentTimeMillis);
        this.mUserState.put(userId, service);
        return service;
    }

    private long checkAndGetTimeLocked() {
        long actualSystemTime = System.currentTimeMillis();
        long actualRealtime = SystemClock.elapsedRealtime();
        long expectedSystemTime = (actualRealtime - this.mRealTimeSnapshot) + this.mSystemTimeSnapshot;
        if (Math.abs(actualSystemTime - expectedSystemTime) > TIME_CHANGE_THRESHOLD_MILLIS) {
            int userCount = this.mUserState.size();
            for (int i = MSG_REPORT_EVENT; i < userCount; i += MSG_FLUSH_TO_DISK) {
                ((UserUsageStatsService) this.mUserState.valueAt(i)).onTimeChanged(expectedSystemTime, actualSystemTime);
            }
            this.mRealTimeSnapshot = actualRealtime;
            this.mSystemTimeSnapshot = actualSystemTime;
        }
        return actualSystemTime;
    }

    private void convertToSystemTimeLocked(Event event) {
        event.mTimeStamp = Math.max(0, event.mTimeStamp - this.mRealTimeSnapshot) + this.mSystemTimeSnapshot;
    }

    void shutdown() {
        synchronized (this.mLock) {
            this.mHandler.removeMessages(MSG_REPORT_EVENT);
            flushToDiskLocked();
        }
    }

    void reportEvent(Event event, int userId) {
        synchronized (this.mLock) {
            long timeNow = checkAndGetTimeLocked();
            convertToSystemTimeLocked(event);
            getUserDataAndInitializeIfNeededLocked(userId, timeNow).reportEvent(event);
        }
    }

    void flushToDisk() {
        synchronized (this.mLock) {
            flushToDiskLocked();
        }
    }

    void removeUser(int userId) {
        synchronized (this.mLock) {
            Slog.i(TAG, "Removing user " + userId + " and all data.");
            this.mUserState.remove(userId);
            cleanUpRemovedUsersLocked();
        }
    }

    List<UsageStats> queryUsageStats(int userId, int bucketType, long beginTime, long endTime) {
        List<UsageStats> queryUsageStats;
        synchronized (this.mLock) {
            long timeNow = checkAndGetTimeLocked();
            if (validRange(timeNow, beginTime, endTime)) {
                queryUsageStats = getUserDataAndInitializeIfNeededLocked(userId, timeNow).queryUsageStats(bucketType, beginTime, endTime);
            } else {
                queryUsageStats = null;
            }
        }
        return queryUsageStats;
    }

    List<ConfigurationStats> queryConfigurationStats(int userId, int bucketType, long beginTime, long endTime) {
        List<ConfigurationStats> queryConfigurationStats;
        synchronized (this.mLock) {
            long timeNow = checkAndGetTimeLocked();
            if (validRange(timeNow, beginTime, endTime)) {
                queryConfigurationStats = getUserDataAndInitializeIfNeededLocked(userId, timeNow).queryConfigurationStats(bucketType, beginTime, endTime);
            } else {
                queryConfigurationStats = null;
            }
        }
        return queryConfigurationStats;
    }

    UsageEvents queryEvents(int userId, long beginTime, long endTime) {
        UsageEvents queryEvents;
        synchronized (this.mLock) {
            long timeNow = checkAndGetTimeLocked();
            if (validRange(timeNow, beginTime, endTime)) {
                queryEvents = getUserDataAndInitializeIfNeededLocked(userId, timeNow).queryEvents(beginTime, endTime);
            } else {
                queryEvents = null;
            }
        }
        return queryEvents;
    }

    private static boolean validRange(long currentTime, long beginTime, long endTime) {
        return (beginTime > currentTime || beginTime >= endTime) ? DEBUG : true;
    }

    private void flushToDiskLocked() {
        int userCount = this.mUserState.size();
        for (int i = MSG_REPORT_EVENT; i < userCount; i += MSG_FLUSH_TO_DISK) {
            ((UserUsageStatsService) this.mUserState.valueAt(i)).persistActiveStats();
        }
        this.mHandler.removeMessages(MSG_FLUSH_TO_DISK);
    }

    void dump(String[] args, PrintWriter pw) {
        synchronized (this.mLock) {
            IndentingPrintWriter idpw = new IndentingPrintWriter(pw, "  ");
            ArraySet<String> argSet = new ArraySet();
            argSet.addAll(Arrays.asList(args));
            int userCount = this.mUserState.size();
            for (int i = MSG_REPORT_EVENT; i < userCount; i += MSG_FLUSH_TO_DISK) {
                idpw.printPair("user", Integer.valueOf(this.mUserState.keyAt(i)));
                idpw.println();
                idpw.increaseIndent();
                if (argSet.contains("--checkin")) {
                    ((UserUsageStatsService) this.mUserState.valueAt(i)).checkin(idpw);
                } else {
                    ((UserUsageStatsService) this.mUserState.valueAt(i)).dump(idpw);
                }
                idpw.decreaseIndent();
            }
        }
    }
}
