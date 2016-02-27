package com.android.server.content;

import android.accounts.Account;
import android.accounts.AccountAndUser;
import android.app.ActivityManager;
import android.app.AlarmManager;
import android.app.AppGlobals;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.ContentResolver;
import android.content.Context;
import android.content.ISyncAdapter;
import android.content.ISyncContext;
import android.content.ISyncServiceAdapter;
import android.content.ISyncStatusObserver.Stub;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.PeriodicSync;
import android.content.ServiceConnection;
import android.content.SyncActivityTooManyDeletes;
import android.content.SyncAdapterType;
import android.content.SyncAdaptersCache;
import android.content.SyncInfo;
import android.content.SyncResult;
import android.content.SyncStats;
import android.content.SyncStatusInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.ProviderInfo;
import android.content.pm.RegisteredServicesCache.ServiceInfo;
import android.content.pm.RegisteredServicesCacheListener;
import android.content.pm.ResolveInfo;
import android.content.pm.UserInfo;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.IBinder.DeathRecipient;
import android.os.Looper;
import android.os.Message;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.os.UserHandle;
import android.os.UserManager;
import android.os.WorkSource;
import android.provider.Settings.Global;
import android.text.TextUtils;
import android.text.format.DateUtils;
import android.text.format.Time;
import android.util.EventLog;
import android.util.Log;
import android.util.Pair;
import com.android.internal.annotations.GuardedBy;
import com.android.internal.app.IBatteryStats;
import com.android.internal.os.BackgroundThread;
import com.android.internal.util.IndentingPrintWriter;
import com.android.server.accounts.AccountManagerService;
import com.android.server.content.SyncStorageEngine.AuthorityInfo;
import com.android.server.content.SyncStorageEngine.DayStats;
import com.android.server.content.SyncStorageEngine.EndPoint;
import com.android.server.job.controllers.JobStatus;
import com.android.server.wm.WindowManagerService.C0569H;
import com.google.android.collect.Lists;
import com.google.android.collect.Maps;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;

public class SyncManager {
    private static final String ACTION_SYNC_ALARM = "android.content.syncmanager.SYNC_ALARM";
    private static final long ACTIVE_SYNC_TIMEOUT_MILLIS = 1800000;
    private static final long DEFAULT_MAX_SYNC_RETRY_TIME_IN_SECONDS = 3600;
    private static final int DELAY_RETRY_SYNC_IN_PROGRESS_IN_SECONDS = 10;
    private static final String HANDLE_SYNC_ALARM_WAKE_LOCK = "SyncManagerHandleSyncAlarm";
    private static final AccountAndUser[] INITIAL_ACCOUNTS_ARRAY;
    private static final long INITIAL_SYNC_RETRY_TIME_IN_MS = 30000;
    private static final long LOCAL_SYNC_DELAY;
    private static final int MAX_SIMULTANEOUS_INITIALIZATION_SYNCS;
    private static final int MAX_SIMULTANEOUS_REGULAR_SYNCS;
    private static final long MAX_TIME_PER_SYNC;
    private static final long SYNC_ALARM_TIMEOUT_MAX = 7200000;
    private static final long SYNC_ALARM_TIMEOUT_MIN = 30000;
    private static final String SYNC_LOOP_WAKE_LOCK = "SyncLoopWakeLock";
    private static final long SYNC_NOTIFICATION_DELAY;
    private static final String SYNC_WAKE_LOCK_PREFIX = "*sync*/";
    private static final String TAG = "SyncManager";
    private BroadcastReceiver mAccountsUpdatedReceiver;
    protected final ArrayList<ActiveSyncContext> mActiveSyncContexts;
    private AlarmManager mAlarmService;
    private final IBatteryStats mBatteryStats;
    private volatile boolean mBootCompleted;
    private BroadcastReceiver mBootCompletedReceiver;
    private ConnectivityManager mConnManagerDoNotUseDirectly;
    private BroadcastReceiver mConnectivityIntentReceiver;
    private Context mContext;
    private volatile boolean mDataConnectionIsConnected;
    private volatile WakeLock mHandleAlarmWakeLock;
    private boolean mNeedSyncActiveNotification;
    private final NotificationManager mNotificationMgr;
    private final PowerManager mPowerManager;
    private volatile AccountAndUser[] mRunningAccounts;
    private BroadcastReceiver mShutdownIntentReceiver;
    private BroadcastReceiver mStorageIntentReceiver;
    private volatile boolean mStorageIsLow;
    protected SyncAdaptersCache mSyncAdapters;
    private final PendingIntent mSyncAlarmIntent;
    private final SyncHandler mSyncHandler;
    private volatile WakeLock mSyncManagerWakeLock;
    @GuardedBy("mSyncQueue")
    private final SyncQueue mSyncQueue;
    private int mSyncRandomOffsetMillis;
    private SyncStorageEngine mSyncStorageEngine;
    private BroadcastReceiver mUserIntentReceiver;
    private final UserManager mUserManager;

    /* renamed from: com.android.server.content.SyncManager.1 */
    class C01771 extends BroadcastReceiver {
        C01771() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if ("android.intent.action.DEVICE_STORAGE_LOW".equals(action)) {
                if (Log.isLoggable(SyncManager.TAG, 2)) {
                    Log.v(SyncManager.TAG, "Internal storage is low.");
                }
                SyncManager.this.mStorageIsLow = true;
                SyncManager.this.cancelActiveSync(EndPoint.USER_ALL_PROVIDER_ALL_ACCOUNTS_ALL, null);
            } else if ("android.intent.action.DEVICE_STORAGE_OK".equals(action)) {
                if (Log.isLoggable(SyncManager.TAG, 2)) {
                    Log.v(SyncManager.TAG, "Internal storage is ok.");
                }
                SyncManager.this.mStorageIsLow = false;
                SyncManager.this.sendCheckAlarmsMessage();
            }
        }
    }

    /* renamed from: com.android.server.content.SyncManager.2 */
    class C01782 extends BroadcastReceiver {
        C01782() {
        }

        public void onReceive(Context context, Intent intent) {
            if (!intent.getBooleanExtra("from_quickboot", false)) {
                SyncManager.this.mSyncHandler.onBootCompleted();
            }
        }
    }

    /* renamed from: com.android.server.content.SyncManager.3 */
    class C01793 extends BroadcastReceiver {
        C01793() {
        }

        public void onReceive(Context context, Intent intent) {
            SyncManager.this.updateRunningAccounts();
            SyncManager.this.scheduleSync(null, -1, -2, null, null, SyncManager.SYNC_NOTIFICATION_DELAY, SyncManager.SYNC_NOTIFICATION_DELAY, false);
        }
    }

    /* renamed from: com.android.server.content.SyncManager.4 */
    class C01804 extends BroadcastReceiver {
        C01804() {
        }

        public void onReceive(Context context, Intent intent) {
            boolean wasConnected = SyncManager.this.mDataConnectionIsConnected;
            SyncManager.this.mDataConnectionIsConnected = SyncManager.this.readDataConnectionState();
            if (SyncManager.this.mDataConnectionIsConnected) {
                if (!wasConnected) {
                    if (Log.isLoggable(SyncManager.TAG, 2)) {
                        Log.v(SyncManager.TAG, "Reconnection detected: clearing all backoffs");
                    }
                    synchronized (SyncManager.this.mSyncQueue) {
                        SyncManager.this.mSyncStorageEngine.clearAllBackoffsLocked(SyncManager.this.mSyncQueue);
                    }
                }
                SyncManager.this.sendCheckAlarmsMessage();
            }
        }
    }

    /* renamed from: com.android.server.content.SyncManager.5 */
    class C01815 extends BroadcastReceiver {
        C01815() {
        }

        public void onReceive(Context context, Intent intent) {
            if (!intent.getBooleanExtra("from_quickboot", false)) {
                Log.w(SyncManager.TAG, "Writing sync state before shutdown...");
                SyncManager.this.getSyncStorageEngine().writeAllState();
            }
        }
    }

    /* renamed from: com.android.server.content.SyncManager.6 */
    class C01826 extends BroadcastReceiver {
        C01826() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            int userId = intent.getIntExtra("android.intent.extra.user_handle", -10000);
            if (userId != -10000) {
                if ("android.intent.action.USER_REMOVED".equals(action)) {
                    SyncManager.this.onUserRemoved(userId);
                } else if ("android.intent.action.USER_STARTING".equals(action)) {
                    SyncManager.this.onUserStarting(userId);
                } else if ("android.intent.action.USER_STOPPING".equals(action)) {
                    SyncManager.this.onUserStopping(userId);
                }
            }
        }
    }

    /* renamed from: com.android.server.content.SyncManager.7 */
    class C01837 implements OnSyncRequestListener {
        C01837() {
        }

        public void onSyncRequest(EndPoint info, int reason, Bundle extras) {
            if (info.target_provider) {
                SyncManager.this.scheduleSync(info.account, info.userId, reason, info.provider, extras, SyncManager.SYNC_NOTIFICATION_DELAY, SyncManager.SYNC_NOTIFICATION_DELAY, false);
            } else if (info.target_service) {
                SyncManager.this.scheduleSync(info.service, info.userId, reason, extras, SyncManager.SYNC_NOTIFICATION_DELAY, SyncManager.SYNC_NOTIFICATION_DELAY);
            }
        }
    }

    /* renamed from: com.android.server.content.SyncManager.8 */
    class C01848 implements RegisteredServicesCacheListener<SyncAdapterType> {
        C01848() {
        }

        public void onServiceChanged(SyncAdapterType type, int userId, boolean removed) {
            if (!removed) {
                SyncManager.this.scheduleSync(null, -1, -3, type.authority, null, SyncManager.SYNC_NOTIFICATION_DELAY, SyncManager.SYNC_NOTIFICATION_DELAY, false);
            }
        }
    }

    /* renamed from: com.android.server.content.SyncManager.9 */
    class C01859 extends Stub {
        C01859() {
        }

        public void onStatusChanged(int which) {
            SyncManager.this.sendCheckAlarmsMessage();
        }
    }

    private static class AccountSyncStats {
        long elapsedTime;
        String name;
        int times;

        private AccountSyncStats(String name) {
            this.name = name;
        }
    }

    class ActiveSyncContext extends ISyncContext.Stub implements ServiceConnection, DeathRecipient {
        boolean mBound;
        String mEventName;
        final long mHistoryRowId;
        boolean mIsLinkedToDeath;
        final long mStartTime;
        ISyncAdapter mSyncAdapter;
        final int mSyncAdapterUid;
        SyncInfo mSyncInfo;
        final SyncOperation mSyncOperation;
        ISyncServiceAdapter mSyncServiceAdapter;
        final WakeLock mSyncWakeLock;
        long mTimeoutStartTime;

        public ActiveSyncContext(SyncOperation syncOperation, long historyRowId, int syncAdapterUid) {
            this.mIsLinkedToDeath = false;
            this.mSyncAdapterUid = syncAdapterUid;
            this.mSyncOperation = syncOperation;
            this.mHistoryRowId = historyRowId;
            this.mSyncAdapter = null;
            this.mSyncServiceAdapter = null;
            this.mStartTime = SystemClock.elapsedRealtime();
            this.mTimeoutStartTime = this.mStartTime;
            this.mSyncWakeLock = SyncManager.this.mSyncHandler.getSyncWakeLock(this.mSyncOperation);
            this.mSyncWakeLock.setWorkSource(new WorkSource(syncAdapterUid));
            this.mSyncWakeLock.acquire();
        }

        public void sendHeartbeat() {
        }

        public void onFinished(SyncResult result) {
            if (Log.isLoggable(SyncManager.TAG, 2)) {
                Log.v(SyncManager.TAG, "onFinished: " + this);
            }
            SyncManager.this.sendSyncFinishedOrCanceledMessage(this, result);
        }

        public void toString(StringBuilder sb) {
            sb.append("startTime ").append(this.mStartTime).append(", mTimeoutStartTime ").append(this.mTimeoutStartTime).append(", mHistoryRowId ").append(this.mHistoryRowId).append(", syncOperation ").append(this.mSyncOperation);
        }

        public void onServiceConnected(ComponentName name, IBinder service) {
            Message msg = SyncManager.this.mSyncHandler.obtainMessage();
            msg.what = 4;
            msg.obj = new ServiceConnectionData(this, service);
            SyncManager.this.mSyncHandler.sendMessage(msg);
        }

        public void onServiceDisconnected(ComponentName name) {
            Message msg = SyncManager.this.mSyncHandler.obtainMessage();
            msg.what = 5;
            msg.obj = new ServiceConnectionData(this, null);
            SyncManager.this.mSyncHandler.sendMessage(msg);
        }

        boolean bindToSyncAdapter(ComponentName serviceComponent, int userId) {
            if (Log.isLoggable(SyncManager.TAG, 2)) {
                Log.d(SyncManager.TAG, "bindToSyncAdapter: " + serviceComponent + ", connection " + this);
            }
            Intent intent = new Intent();
            intent.setAction("android.content.SyncAdapter");
            intent.setComponent(serviceComponent);
            intent.putExtra("android.intent.extra.client_label", 17040724);
            intent.putExtra("android.intent.extra.client_intent", PendingIntent.getActivityAsUser(SyncManager.this.mContext, SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS, new Intent("android.settings.SYNC_SETTINGS"), SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS, null, new UserHandle(userId)));
            this.mBound = true;
            boolean bindResult = SyncManager.this.mContext.bindServiceAsUser(intent, this, 21, new UserHandle(this.mSyncOperation.target.userId));
            if (bindResult) {
                try {
                    this.mEventName = this.mSyncOperation.wakeLockName();
                    SyncManager.this.mBatteryStats.noteSyncStart(this.mEventName, this.mSyncAdapterUid);
                } catch (RemoteException e) {
                }
            } else {
                this.mBound = false;
            }
            return bindResult;
        }

        protected void close() {
            if (Log.isLoggable(SyncManager.TAG, 2)) {
                Log.d(SyncManager.TAG, "unBindFromSyncAdapter: connection " + this);
            }
            if (this.mBound) {
                this.mBound = false;
                SyncManager.this.mContext.unbindService(this);
                try {
                    SyncManager.this.mBatteryStats.noteSyncFinish(this.mEventName, this.mSyncAdapterUid);
                } catch (RemoteException e) {
                }
            }
            this.mSyncWakeLock.release();
            this.mSyncWakeLock.setWorkSource(null);
        }

        public String toString() {
            StringBuilder sb = new StringBuilder();
            toString(sb);
            return sb.toString();
        }

        public void binderDied() {
            SyncManager.this.sendSyncFinishedOrCanceledMessage(this, null);
        }
    }

    private static class AuthoritySyncStats {
        Map<String, AccountSyncStats> accountMap;
        long elapsedTime;
        String name;
        int times;

        private AuthoritySyncStats(String name) {
            this.accountMap = Maps.newHashMap();
            this.name = name;
        }
    }

    static class PrintTable {
        private final int mCols;
        private ArrayList<Object[]> mTable;

        PrintTable(int cols) {
            this.mTable = Lists.newArrayList();
            this.mCols = cols;
        }

        void set(int row, int col, Object... values) {
            if (values.length + col > this.mCols) {
                throw new IndexOutOfBoundsException("Table only has " + this.mCols + " columns. can't set " + values.length + " at column " + col);
            }
            for (int i = this.mTable.size(); i <= row; i++) {
                Object[] list = new Object[this.mCols];
                this.mTable.add(list);
                for (int j = SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS; j < this.mCols; j++) {
                    list[j] = "";
                }
            }
            System.arraycopy(values, SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS, this.mTable.get(row), col, values.length);
        }

        void writeTo(PrintWriter out) {
            int i;
            String[] formats = new String[this.mCols];
            int totalLength = SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS;
            for (int col = SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS; col < this.mCols; col++) {
                int maxLength = SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS;
                Iterator i$ = this.mTable.iterator();
                while (i$.hasNext()) {
                    int length = ((Object[]) i$.next())[col].toString().length();
                    if (length > maxLength) {
                        maxLength = length;
                    }
                }
                totalLength += maxLength;
                formats[col] = String.format("%%-%ds", new Object[]{Integer.valueOf(maxLength)});
            }
            formats[this.mCols - 1] = "%s";
            printRow(out, formats, (Object[]) this.mTable.get(SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS));
            totalLength += (this.mCols - 1) * 2;
            for (i = SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS; i < totalLength; i++) {
                out.print("-");
            }
            out.println();
            int mTableSize = this.mTable.size();
            for (i = 1; i < mTableSize; i++) {
                printRow(out, formats, (Object[]) this.mTable.get(i));
            }
        }

        private void printRow(PrintWriter out, String[] formats, Object[] row) {
            int rowLength = row.length;
            for (int j = SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS; j < rowLength; j++) {
                out.printf(String.format(formats[j], new Object[]{row[j].toString()}), new Object[SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS]);
                out.print("  ");
            }
            out.println();
        }

        public int getNumRows() {
            return this.mTable.size();
        }
    }

    class ServiceConnectionData {
        public final ActiveSyncContext activeSyncContext;
        public final IBinder adapter;

        ServiceConnectionData(ActiveSyncContext activeSyncContext, IBinder adapter) {
            this.activeSyncContext = activeSyncContext;
            this.adapter = adapter;
        }
    }

    class SyncAlarmIntentReceiver extends BroadcastReceiver {
        SyncAlarmIntentReceiver() {
        }

        public void onReceive(Context context, Intent intent) {
            SyncManager.this.mHandleAlarmWakeLock.acquire();
            SyncManager.this.sendSyncAlarmMessage();
        }
    }

    class SyncHandler extends Handler {
        private static final int MESSAGE_CANCEL = 6;
        private static final int MESSAGE_CHECK_ALARMS = 3;
        private static final int MESSAGE_SERVICE_CONNECTED = 4;
        private static final int MESSAGE_SERVICE_DISCONNECTED = 5;
        private static final int MESSAGE_SYNC_ALARM = 2;
        private static final int MESSAGE_SYNC_EXPIRED = 7;
        private static final int MESSAGE_SYNC_FINISHED = 1;
        private Long mAlarmScheduleTime;
        private List<Message> mBootQueue;
        public final SyncNotificationInfo mSyncNotificationInfo;
        public final SyncTimeTracker mSyncTimeTracker;
        private final HashMap<String, WakeLock> mWakeLocks;

        class SyncNotificationInfo {
            public boolean isActive;
            public Long startTime;

            SyncNotificationInfo() {
                this.isActive = false;
                this.startTime = null;
            }

            public void toString(StringBuilder sb) {
                sb.append("isActive ").append(this.isActive).append(", startTime ").append(this.startTime);
            }

            public String toString() {
                StringBuilder sb = new StringBuilder();
                toString(sb);
                return sb.toString();
            }
        }

        public void onBootCompleted() {
            if (Log.isLoggable(SyncManager.TAG, MESSAGE_SYNC_ALARM)) {
                Log.v(SyncManager.TAG, "Boot completed, clearing boot queue.");
            }
            SyncManager.this.doDatabaseCleanup();
            synchronized (this) {
                for (Message message : this.mBootQueue) {
                    sendMessage(message);
                }
                this.mBootQueue = null;
                SyncManager.this.mBootCompleted = true;
            }
        }

        private WakeLock getSyncWakeLock(SyncOperation operation) {
            String wakeLockKey = operation.wakeLockName();
            WakeLock wakeLock = (WakeLock) this.mWakeLocks.get(wakeLockKey);
            if (wakeLock != null) {
                return wakeLock;
            }
            wakeLock = SyncManager.this.mPowerManager.newWakeLock(MESSAGE_SYNC_FINISHED, SyncManager.SYNC_WAKE_LOCK_PREFIX + wakeLockKey);
            wakeLock.setReferenceCounted(false);
            this.mWakeLocks.put(wakeLockKey, wakeLock);
            return wakeLock;
        }

        private boolean tryEnqueueMessageUntilReadyToRun(Message msg) {
            boolean z;
            synchronized (this) {
                if (SyncManager.this.mBootCompleted) {
                    z = false;
                } else {
                    this.mBootQueue.add(Message.obtain(msg));
                    z = true;
                }
            }
            return z;
        }

        public SyncHandler(Looper looper) {
            super(looper);
            this.mSyncNotificationInfo = new SyncNotificationInfo();
            this.mAlarmScheduleTime = null;
            this.mSyncTimeTracker = new SyncTimeTracker(null);
            this.mWakeLocks = Maps.newHashMap();
            this.mBootQueue = new ArrayList();
        }

        public void handleMessage(Message msg) {
            if (!tryEnqueueMessageUntilReadyToRun(msg)) {
                long earliestFuturePollTime = JobStatus.NO_LATEST_RUNTIME;
                long nextPendingSyncTime = JobStatus.NO_LATEST_RUNTIME;
                try {
                    SyncManager.this.mDataConnectionIsConnected = SyncManager.this.readDataConnectionState();
                    SyncManager.this.mSyncManagerWakeLock.acquire();
                    earliestFuturePollTime = scheduleReadyPeriodicSyncs();
                    switch (msg.what) {
                        case MESSAGE_SYNC_FINISHED /*1*/:
                            if (Log.isLoggable(SyncManager.TAG, MESSAGE_SYNC_ALARM)) {
                                Log.v(SyncManager.TAG, "handleSyncHandlerMessage: MESSAGE_SYNC_FINISHED");
                            }
                            SyncHandlerMessagePayload payload = msg.obj;
                            if (!SyncManager.this.isSyncStillActive(payload.activeSyncContext)) {
                                Log.d(SyncManager.TAG, "handleSyncHandlerMessage: dropping since the sync is no longer active: " + payload.activeSyncContext);
                                break;
                            }
                            runSyncFinishedOrCanceledLocked(payload.syncResult, payload.activeSyncContext);
                            nextPendingSyncTime = maybeStartNextSyncLocked();
                            break;
                        case MESSAGE_SYNC_ALARM /*2*/:
                            if (Log.isLoggable(SyncManager.TAG, MESSAGE_SYNC_ALARM)) {
                                Log.v(SyncManager.TAG, "handleSyncHandlerMessage: MESSAGE_SYNC_ALARM");
                            }
                            this.mAlarmScheduleTime = null;
                            nextPendingSyncTime = maybeStartNextSyncLocked();
                            SyncManager.this.mHandleAlarmWakeLock.release();
                            break;
                        case MESSAGE_CHECK_ALARMS /*3*/:
                            if (Log.isLoggable(SyncManager.TAG, MESSAGE_SYNC_ALARM)) {
                                Log.v(SyncManager.TAG, "handleSyncHandlerMessage: MESSAGE_CHECK_ALARMS");
                            }
                            nextPendingSyncTime = maybeStartNextSyncLocked();
                            break;
                        case MESSAGE_SERVICE_CONNECTED /*4*/:
                            ServiceConnectionData msgData = msg.obj;
                            if (Log.isLoggable(SyncManager.TAG, MESSAGE_SYNC_ALARM)) {
                                Log.d(SyncManager.TAG, "handleSyncHandlerMessage: MESSAGE_SERVICE_CONNECTED: " + msgData.activeSyncContext);
                            }
                            if (SyncManager.this.isSyncStillActive(msgData.activeSyncContext)) {
                                runBoundToAdapter(msgData.activeSyncContext, msgData.adapter);
                                break;
                            }
                            break;
                        case MESSAGE_SERVICE_DISCONNECTED /*5*/:
                            ActiveSyncContext currentSyncContext = ((ServiceConnectionData) msg.obj).activeSyncContext;
                            if (Log.isLoggable(SyncManager.TAG, MESSAGE_SYNC_ALARM)) {
                                Log.d(SyncManager.TAG, "handleSyncHandlerMessage: MESSAGE_SERVICE_DISCONNECTED: " + currentSyncContext);
                            }
                            if (SyncManager.this.isSyncStillActive(currentSyncContext)) {
                                try {
                                    if (currentSyncContext.mSyncAdapter != null) {
                                        currentSyncContext.mSyncAdapter.cancelSync(currentSyncContext);
                                    } else if (currentSyncContext.mSyncServiceAdapter != null) {
                                        currentSyncContext.mSyncServiceAdapter.cancelSync(currentSyncContext);
                                    }
                                } catch (RemoteException e) {
                                }
                                SyncResult syncResult = new SyncResult();
                                SyncStats syncStats = syncResult.stats;
                                syncStats.numIoExceptions++;
                                runSyncFinishedOrCanceledLocked(syncResult, currentSyncContext);
                                nextPendingSyncTime = maybeStartNextSyncLocked();
                                break;
                            }
                            break;
                        case MESSAGE_CANCEL /*6*/:
                            EndPoint payload2 = msg.obj;
                            Bundle extras = msg.peekData();
                            if (Log.isLoggable(SyncManager.TAG, MESSAGE_CHECK_ALARMS)) {
                                Log.d(SyncManager.TAG, "handleSyncHandlerMessage: MESSAGE_SERVICE_CANCEL: " + payload2 + " bundle: " + extras);
                            }
                            cancelActiveSyncLocked(payload2, extras);
                            nextPendingSyncTime = maybeStartNextSyncLocked();
                            break;
                        case MESSAGE_SYNC_EXPIRED /*7*/:
                            ActiveSyncContext expiredContext = msg.obj;
                            if (Log.isLoggable(SyncManager.TAG, MESSAGE_CHECK_ALARMS)) {
                                Log.d(SyncManager.TAG, "handleSyncHandlerMessage: MESSAGE_SYNC_EXPIRED: expiring " + expiredContext);
                            }
                            SyncManager.this.cancelActiveSync(expiredContext.mSyncOperation.target, expiredContext.mSyncOperation.extras);
                            nextPendingSyncTime = maybeStartNextSyncLocked();
                            break;
                    }
                    manageSyncNotificationLocked();
                    manageSyncAlarmLocked(earliestFuturePollTime, nextPendingSyncTime);
                    this.mSyncTimeTracker.update();
                    SyncManager.this.mSyncManagerWakeLock.release();
                } catch (Throwable th) {
                    manageSyncNotificationLocked();
                    manageSyncAlarmLocked(earliestFuturePollTime, nextPendingSyncTime);
                    this.mSyncTimeTracker.update();
                    SyncManager.this.mSyncManagerWakeLock.release();
                }
            }
        }

        private boolean isDispatchable(EndPoint target) {
            boolean isLoggable = Log.isLoggable(SyncManager.TAG, MESSAGE_SYNC_ALARM);
            if (target.target_provider) {
                if (!SyncManager.this.containsAccountAndUser(SyncManager.this.mRunningAccounts, target.account, target.userId)) {
                    return false;
                }
                if (SyncManager.this.mSyncStorageEngine.getMasterSyncAutomatically(target.userId) && SyncManager.this.mSyncStorageEngine.getSyncAutomatically(target.account, target.userId, target.provider)) {
                    if (SyncManager.this.getIsSyncable(target.account, target.userId, target.provider) == 0) {
                        if (!isLoggable) {
                            return false;
                        }
                        Log.v(SyncManager.TAG, "    Not scheduling periodic operation: isSyncable == 0.");
                        return false;
                    }
                } else if (!isLoggable) {
                    return false;
                } else {
                    Log.v(SyncManager.TAG, "    Not scheduling periodic operation: sync turned off.");
                    return false;
                }
            } else if (target.target_service && SyncManager.this.mSyncStorageEngine.getIsTargetServiceActive(target.service, target.userId)) {
                if (!isLoggable) {
                    return false;
                }
                Log.v(SyncManager.TAG, "   Not scheduling periodic operation: isEnabled == 0.");
                return false;
            }
            return true;
        }

        private long scheduleReadyPeriodicSyncs() {
            boolean isLoggable = Log.isLoggable(SyncManager.TAG, MESSAGE_SYNC_ALARM);
            if (isLoggable) {
                Log.v(SyncManager.TAG, "scheduleReadyPeriodicSyncs");
            }
            long earliestFuturePollTime = JobStatus.NO_LATEST_RUNTIME;
            long nowAbsolute = System.currentTimeMillis();
            long shiftedNowAbsolute = SyncManager.SYNC_NOTIFICATION_DELAY < nowAbsolute - ((long) SyncManager.this.mSyncRandomOffsetMillis) ? nowAbsolute - ((long) SyncManager.this.mSyncRandomOffsetMillis) : SyncManager.SYNC_NOTIFICATION_DELAY;
            Iterator i$ = SyncManager.this.mSyncStorageEngine.getCopyOfAllAuthoritiesWithSyncStatus().iterator();
            while (i$.hasNext()) {
                Pair<AuthorityInfo, SyncStatusInfo> info = (Pair) i$.next();
                AuthorityInfo authorityInfo = info.first;
                SyncStatusInfo status = info.second;
                if (TextUtils.isEmpty(authorityInfo.target.provider)) {
                    Log.e(SyncManager.TAG, "Got an empty provider string. Skipping: " + authorityInfo.target.provider);
                } else {
                    if (isDispatchable(authorityInfo.target)) {
                        int N = authorityInfo.periodicSyncs.size();
                        for (int i = SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS; i < N; i += MESSAGE_SYNC_FINISHED) {
                            PeriodicSync sync = (PeriodicSync) authorityInfo.periodicSyncs.get(i);
                            Bundle extras = sync.extras;
                            Long periodInMillis = Long.valueOf(sync.period * 1000);
                            Long flexInMillis = Long.valueOf(sync.flexTime * 1000);
                            if (periodInMillis.longValue() > SyncManager.SYNC_NOTIFICATION_DELAY) {
                                long nextPollTimeAbsolute;
                                long lastPollTimeAbsolute = status.getPeriodicSyncTime(i);
                                long shiftedLastPollTimeAbsolute = SyncManager.SYNC_NOTIFICATION_DELAY < lastPollTimeAbsolute - ((long) SyncManager.this.mSyncRandomOffsetMillis) ? lastPollTimeAbsolute - ((long) SyncManager.this.mSyncRandomOffsetMillis) : SyncManager.SYNC_NOTIFICATION_DELAY;
                                long remainingMillis = periodInMillis.longValue() - (shiftedNowAbsolute % periodInMillis.longValue());
                                long timeSinceLastRunMillis = nowAbsolute - lastPollTimeAbsolute;
                                boolean runEarly = remainingMillis <= flexInMillis.longValue() && timeSinceLastRunMillis > periodInMillis.longValue() - flexInMillis.longValue();
                                if (isLoggable) {
                                    Log.v(SyncManager.TAG, "sync: " + i + " for " + authorityInfo.target + "." + " period: " + periodInMillis + " flex: " + flexInMillis + " remaining: " + remainingMillis + " time_since_last: " + timeSinceLastRunMillis + " last poll absol: " + lastPollTimeAbsolute + " last poll shifed: " + shiftedLastPollTimeAbsolute + " shifted now: " + shiftedNowAbsolute + " run_early: " + runEarly);
                                }
                                if (remainingMillis == periodInMillis.longValue() || lastPollTimeAbsolute > nowAbsolute || timeSinceLastRunMillis >= periodInMillis.longValue() || runEarly) {
                                    EndPoint target = authorityInfo.target;
                                    Pair<Long, Long> backoff = SyncManager.this.mSyncStorageEngine.getBackoff(target);
                                    SyncManager.this.mSyncStorageEngine.setPeriodicSyncTime(authorityInfo.ident, (PeriodicSync) authorityInfo.periodicSyncs.get(i), nowAbsolute);
                                    if (target.target_provider) {
                                        ServiceInfo<SyncAdapterType> syncAdapterInfo = SyncManager.this.mSyncAdapters.getServiceInfo(SyncAdapterType.newKey(target.provider, target.account.type), target.userId);
                                        if (syncAdapterInfo != null) {
                                            long longValue;
                                            SyncManager syncManager = SyncManager.this;
                                            Account account = target.account;
                                            int i2 = target.userId;
                                            String str = target.provider;
                                            if (backoff != null) {
                                                longValue = ((Long) backoff.first).longValue();
                                            } else {
                                                longValue = SyncManager.SYNC_NOTIFICATION_DELAY;
                                            }
                                            syncManager.scheduleSyncOperation(new SyncOperation(account, i2, -4, MESSAGE_SERVICE_CONNECTED, str, extras, SyncManager.SYNC_NOTIFICATION_DELAY, SyncManager.SYNC_NOTIFICATION_DELAY, longValue, SyncManager.this.mSyncStorageEngine.getDelayUntilTime(target), ((SyncAdapterType) syncAdapterInfo.type).allowParallelSyncs()));
                                        }
                                    } else if (target.target_service) {
                                        SyncManager.this.scheduleSyncOperation(new SyncOperation(target.service, target.userId, -4, (int) MESSAGE_SERVICE_CONNECTED, extras, (long) SyncManager.SYNC_NOTIFICATION_DELAY, (long) SyncManager.SYNC_NOTIFICATION_DELAY, backoff != null ? ((Long) backoff.first).longValue() : SyncManager.SYNC_NOTIFICATION_DELAY, SyncManager.this.mSyncStorageEngine.getDelayUntilTime(target)));
                                    }
                                }
                                if (runEarly) {
                                    nextPollTimeAbsolute = (periodInMillis.longValue() + nowAbsolute) + remainingMillis;
                                } else {
                                    nextPollTimeAbsolute = nowAbsolute + remainingMillis;
                                }
                                if (nextPollTimeAbsolute < earliestFuturePollTime) {
                                    earliestFuturePollTime = nextPollTimeAbsolute;
                                }
                            }
                        }
                    }
                }
            }
            if (earliestFuturePollTime == JobStatus.NO_LATEST_RUNTIME) {
                return JobStatus.NO_LATEST_RUNTIME;
            }
            return (earliestFuturePollTime < nowAbsolute ? SyncManager.SYNC_NOTIFICATION_DELAY : earliestFuturePollTime - nowAbsolute) + SystemClock.elapsedRealtime();
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        private long maybeStartNextSyncLocked() {
            /*
            r36 = this;
            r30 = "SyncManager";
            r31 = 2;
            r13 = android.util.Log.isLoggable(r30, r31);
            if (r13 == 0) goto L_0x0011;
        L_0x000a:
            r30 = "SyncManager";
            r31 = "maybeStartNextSync";
            android.util.Log.v(r30, r31);
        L_0x0011:
            r0 = r36;
            r0 = com.android.server.content.SyncManager.this;
            r30 = r0;
            r30 = r30.mDataConnectionIsConnected;
            if (r30 != 0) goto L_0x002c;
        L_0x001d:
            if (r13 == 0) goto L_0x0026;
        L_0x001f:
            r30 = "SyncManager";
            r31 = "maybeStartNextSync: no data connection, skipping";
            android.util.Log.v(r30, r31);
        L_0x0026:
            r16 = 9223372036854775807; // 0x7fffffffffffffff float:NaN double:NaN;
        L_0x002b:
            return r16;
        L_0x002c:
            r0 = r36;
            r0 = com.android.server.content.SyncManager.this;
            r30 = r0;
            r30 = r30.mStorageIsLow;
            if (r30 == 0) goto L_0x0047;
        L_0x0038:
            if (r13 == 0) goto L_0x0041;
        L_0x003a:
            r30 = "SyncManager";
            r31 = "maybeStartNextSync: memory low, skipping";
            android.util.Log.v(r30, r31);
        L_0x0041:
            r16 = 9223372036854775807; // 0x7fffffffffffffff float:NaN double:NaN;
            goto L_0x002b;
        L_0x0047:
            r0 = r36;
            r0 = com.android.server.content.SyncManager.this;
            r30 = r0;
            r30 = r30.mRunningAccounts;
            r31 = com.android.server.content.SyncManager.INITIAL_ACCOUNTS_ARRAY;
            r0 = r30;
            r1 = r31;
            if (r0 != r1) goto L_0x006a;
        L_0x005b:
            if (r13 == 0) goto L_0x0064;
        L_0x005d:
            r30 = "SyncManager";
            r31 = "maybeStartNextSync: accounts not known, skipping";
            android.util.Log.v(r30, r31);
        L_0x0064:
            r16 = 9223372036854775807; // 0x7fffffffffffffff float:NaN double:NaN;
            goto L_0x002b;
        L_0x006a:
            r18 = android.os.SystemClock.elapsedRealtime();
            r16 = 9223372036854775807; // 0x7fffffffffffffff float:NaN double:NaN;
            r24 = new java.util.ArrayList;
            r24.<init>();
            r0 = r36;
            r0 = com.android.server.content.SyncManager.this;
            r30 = r0;
            r31 = r30.mSyncQueue;
            monitor-enter(r31);
            if (r13 == 0) goto L_0x00b3;
        L_0x0085:
            r30 = "SyncManager";
            r32 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0168 }
            r32.<init>();	 Catch:{ all -> 0x0168 }
            r33 = "build the operation array, syncQueue size is ";
            r32 = r32.append(r33);	 Catch:{ all -> 0x0168 }
            r0 = r36;
            r0 = com.android.server.content.SyncManager.this;	 Catch:{ all -> 0x0168 }
            r33 = r0;
            r33 = r33.mSyncQueue;	 Catch:{ all -> 0x0168 }
            r33 = r33.getOperations();	 Catch:{ all -> 0x0168 }
            r33 = r33.size();	 Catch:{ all -> 0x0168 }
            r32 = r32.append(r33);	 Catch:{ all -> 0x0168 }
            r32 = r32.toString();	 Catch:{ all -> 0x0168 }
            r0 = r30;
            r1 = r32;
            android.util.Log.v(r0, r1);	 Catch:{ all -> 0x0168 }
        L_0x00b3:
            r0 = r36;
            r0 = com.android.server.content.SyncManager.this;	 Catch:{ all -> 0x0168 }
            r30 = r0;
            r30 = r30.mSyncQueue;	 Catch:{ all -> 0x0168 }
            r30 = r30.getOperations();	 Catch:{ all -> 0x0168 }
            r23 = r30.iterator();	 Catch:{ all -> 0x0168 }
            r0 = r36;
            r0 = com.android.server.content.SyncManager.this;	 Catch:{ all -> 0x0168 }
            r30 = r0;
            r30 = r30.mContext;	 Catch:{ all -> 0x0168 }
            r32 = "activity";
            r0 = r30;
            r1 = r32;
            r7 = r0.getSystemService(r1);	 Catch:{ all -> 0x0168 }
            r7 = (android.app.ActivityManager) r7;	 Catch:{ all -> 0x0168 }
            r25 = com.google.android.collect.Sets.newHashSet();	 Catch:{ all -> 0x0168 }
        L_0x00df:
            r30 = r23.hasNext();	 Catch:{ all -> 0x0168 }
            if (r30 == 0) goto L_0x0208;
        L_0x00e5:
            r22 = r23.next();	 Catch:{ all -> 0x0168 }
            r22 = (com.android.server.content.SyncOperation) r22;	 Catch:{ all -> 0x0168 }
            r0 = r22;
            r0 = r0.target;	 Catch:{ all -> 0x0168 }
            r30 = r0;
            r0 = r30;
            r0 = r0.userId;	 Catch:{ all -> 0x0168 }
            r30 = r0;
            r0 = r30;
            r30 = r7.isUserRunning(r0);	 Catch:{ all -> 0x0168 }
            if (r30 != 0) goto L_0x016b;
        L_0x00ff:
            r0 = r36;
            r0 = com.android.server.content.SyncManager.this;	 Catch:{ all -> 0x0168 }
            r30 = r0;
            r30 = r30.mUserManager;	 Catch:{ all -> 0x0168 }
            r0 = r22;
            r0 = r0.target;	 Catch:{ all -> 0x0168 }
            r32 = r0;
            r0 = r32;
            r0 = r0.userId;	 Catch:{ all -> 0x0168 }
            r32 = r0;
            r0 = r30;
            r1 = r32;
            r29 = r0.getUserInfo(r1);	 Catch:{ all -> 0x0168 }
            if (r29 != 0) goto L_0x0136;
        L_0x011f:
            r0 = r22;
            r0 = r0.target;	 Catch:{ all -> 0x0168 }
            r30 = r0;
            r0 = r30;
            r0 = r0.userId;	 Catch:{ all -> 0x0168 }
            r30 = r0;
            r30 = java.lang.Integer.valueOf(r30);	 Catch:{ all -> 0x0168 }
            r0 = r25;
            r1 = r30;
            r0.add(r1);	 Catch:{ all -> 0x0168 }
        L_0x0136:
            if (r13 == 0) goto L_0x00df;
        L_0x0138:
            r30 = "SyncManager";
            r32 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0168 }
            r32.<init>();	 Catch:{ all -> 0x0168 }
            r33 = "    Dropping all sync operations for + ";
            r32 = r32.append(r33);	 Catch:{ all -> 0x0168 }
            r0 = r22;
            r0 = r0.target;	 Catch:{ all -> 0x0168 }
            r33 = r0;
            r0 = r33;
            r0 = r0.userId;	 Catch:{ all -> 0x0168 }
            r33 = r0;
            r32 = r32.append(r33);	 Catch:{ all -> 0x0168 }
            r33 = ": user not running.";
            r32 = r32.append(r33);	 Catch:{ all -> 0x0168 }
            r32 = r32.toString();	 Catch:{ all -> 0x0168 }
            r0 = r30;
            r1 = r32;
            android.util.Log.v(r0, r1);	 Catch:{ all -> 0x0168 }
            goto L_0x00df;
        L_0x0168:
            r30 = move-exception;
            monitor-exit(r31);	 Catch:{ all -> 0x0168 }
            throw r30;
        L_0x016b:
            r0 = r36;
            r1 = r22;
            r30 = r0.isOperationValidLocked(r1);	 Catch:{ all -> 0x0168 }
            if (r30 != 0) goto L_0x0191;
        L_0x0175:
            r23.remove();	 Catch:{ all -> 0x0168 }
            r0 = r36;
            r0 = com.android.server.content.SyncManager.this;	 Catch:{ all -> 0x0168 }
            r30 = r0;
            r30 = r30.mSyncStorageEngine;	 Catch:{ all -> 0x0168 }
            r0 = r22;
            r0 = r0.pendingOperation;	 Catch:{ all -> 0x0168 }
            r32 = r0;
            r0 = r30;
            r1 = r32;
            r0.deleteFromPending(r1);	 Catch:{ all -> 0x0168 }
            goto L_0x00df;
        L_0x0191:
            r0 = r22;
            r0 = r0.effectiveRunTime;	 Catch:{ all -> 0x0168 }
            r32 = r0;
            r0 = r22;
            r0 = r0.flexTime;	 Catch:{ all -> 0x0168 }
            r34 = r0;
            r32 = r32 - r34;
            r30 = (r32 > r18 ? 1 : (r32 == r18 ? 0 : -1));
            if (r30 <= 0) goto L_0x01ff;
        L_0x01a3:
            r0 = r22;
            r0 = r0.effectiveRunTime;	 Catch:{ all -> 0x0168 }
            r32 = r0;
            r30 = (r16 > r32 ? 1 : (r16 == r32 ? 0 : -1));
            if (r30 <= 0) goto L_0x01b3;
        L_0x01ad:
            r0 = r22;
            r0 = r0.effectiveRunTime;	 Catch:{ all -> 0x0168 }
            r16 = r0;
        L_0x01b3:
            if (r13 == 0) goto L_0x00df;
        L_0x01b5:
            r30 = "SyncManager";
            r32 = new java.lang.StringBuilder;	 Catch:{ all -> 0x0168 }
            r32.<init>();	 Catch:{ all -> 0x0168 }
            r33 = "    Not running sync operation: Sync too far in future.effective: ";
            r32 = r32.append(r33);	 Catch:{ all -> 0x0168 }
            r0 = r22;
            r0 = r0.effectiveRunTime;	 Catch:{ all -> 0x0168 }
            r34 = r0;
            r0 = r32;
            r1 = r34;
            r32 = r0.append(r1);	 Catch:{ all -> 0x0168 }
            r33 = " flex: ";
            r32 = r32.append(r33);	 Catch:{ all -> 0x0168 }
            r0 = r22;
            r0 = r0.flexTime;	 Catch:{ all -> 0x0168 }
            r34 = r0;
            r0 = r32;
            r1 = r34;
            r32 = r0.append(r1);	 Catch:{ all -> 0x0168 }
            r33 = " now: ";
            r32 = r32.append(r33);	 Catch:{ all -> 0x0168 }
            r0 = r32;
            r1 = r18;
            r32 = r0.append(r1);	 Catch:{ all -> 0x0168 }
            r32 = r32.toString();	 Catch:{ all -> 0x0168 }
            r0 = r30;
            r1 = r32;
            android.util.Log.v(r0, r1);	 Catch:{ all -> 0x0168 }
            goto L_0x00df;
        L_0x01ff:
            r0 = r24;
            r1 = r22;
            r0.add(r1);	 Catch:{ all -> 0x0168 }
            goto L_0x00df;
        L_0x0208:
            r12 = r25.iterator();	 Catch:{ all -> 0x0168 }
        L_0x020c:
            r30 = r12.hasNext();	 Catch:{ all -> 0x0168 }
            if (r30 == 0) goto L_0x0242;
        L_0x0212:
            r28 = r12.next();	 Catch:{ all -> 0x0168 }
            r28 = (java.lang.Integer) r28;	 Catch:{ all -> 0x0168 }
            r0 = r36;
            r0 = com.android.server.content.SyncManager.this;	 Catch:{ all -> 0x0168 }
            r30 = r0;
            r30 = r30.mUserManager;	 Catch:{ all -> 0x0168 }
            r32 = r28.intValue();	 Catch:{ all -> 0x0168 }
            r0 = r30;
            r1 = r32;
            r30 = r0.getUserInfo(r1);	 Catch:{ all -> 0x0168 }
            if (r30 != 0) goto L_0x020c;
        L_0x0230:
            r0 = r36;
            r0 = com.android.server.content.SyncManager.this;	 Catch:{ all -> 0x0168 }
            r30 = r0;
            r32 = r28.intValue();	 Catch:{ all -> 0x0168 }
            r0 = r30;
            r1 = r32;
            r0.onUserRemoved(r1);	 Catch:{ all -> 0x0168 }
            goto L_0x020c;
        L_0x0242:
            monitor-exit(r31);	 Catch:{ all -> 0x0168 }
            if (r13 == 0) goto L_0x0261;
        L_0x0245:
            r30 = "SyncManager";
            r31 = new java.lang.StringBuilder;
            r31.<init>();
            r32 = "sort the candidate operations, size ";
            r31 = r31.append(r32);
            r32 = r24.size();
            r31 = r31.append(r32);
            r31 = r31.toString();
            android.util.Log.v(r30, r31);
        L_0x0261:
            java.util.Collections.sort(r24);
            if (r13 == 0) goto L_0x026d;
        L_0x0266:
            r30 = "SyncManager";
            r31 = "dispatch all ready sync operations";
            android.util.Log.v(r30, r31);
        L_0x026d:
            r11 = 0;
            r4 = r24.size();
        L_0x0272:
            if (r11 >= r4) goto L_0x002b;
        L_0x0274:
            r0 = r24;
            r8 = r0.get(r11);
            r8 = (com.android.server.content.SyncOperation) r8;
            r9 = r8.isInitialization();
            r15 = 0;
            r20 = 0;
            r10 = 0;
            r14 = 0;
            r27 = 0;
            r21 = 0;
            r0 = r36;
            r0 = com.android.server.content.SyncManager.this;
            r30 = r0;
            r0 = r30;
            r0 = r0.mActiveSyncContexts;
            r30 = r0;
            r12 = r30.iterator();
        L_0x0299:
            r30 = r12.hasNext();
            if (r30 == 0) goto L_0x02ea;
        L_0x029f:
            r6 = r12.next();
            r6 = (com.android.server.content.SyncManager.ActiveSyncContext) r6;
            r5 = r6.mSyncOperation;
            r30 = r5.isInitialization();
            if (r30 == 0) goto L_0x02b7;
        L_0x02ad:
            r15 = r15 + 1;
        L_0x02af:
            r30 = r5.isConflict(r8);
            if (r30 == 0) goto L_0x02d2;
        L_0x02b5:
            r10 = r6;
            goto L_0x0299;
        L_0x02b7:
            r20 = r20 + 1;
            r30 = r5.isExpedited();
            if (r30 != 0) goto L_0x02af;
        L_0x02bf:
            if (r21 == 0) goto L_0x02cf;
        L_0x02c1:
            r0 = r21;
            r0 = r0.mStartTime;
            r30 = r0;
            r0 = r6.mStartTime;
            r32 = r0;
            r30 = (r30 > r32 ? 1 : (r30 == r32 ? 0 : -1));
            if (r30 <= 0) goto L_0x02af;
        L_0x02cf:
            r21 = r6;
            goto L_0x02af;
        L_0x02d2:
            r30 = r5.isInitialization();
            r0 = r30;
            if (r9 != r0) goto L_0x0299;
        L_0x02da:
            r0 = r6.mStartTime;
            r30 = r0;
            r32 = com.android.server.content.SyncManager.MAX_TIME_PER_SYNC;
            r30 = r30 + r32;
            r30 = (r30 > r18 ? 1 : (r30 == r18 ? 0 : -1));
            if (r30 >= 0) goto L_0x0299;
        L_0x02e8:
            r14 = r6;
            goto L_0x0299;
        L_0x02ea:
            if (r13 == 0) goto L_0x0396;
        L_0x02ec:
            r30 = "SyncManager";
            r31 = new java.lang.StringBuilder;
            r31.<init>();
            r32 = "candidate ";
            r31 = r31.append(r32);
            r32 = r11 + 1;
            r31 = r31.append(r32);
            r32 = " of ";
            r31 = r31.append(r32);
            r0 = r31;
            r31 = r0.append(r4);
            r32 = ": ";
            r31 = r31.append(r32);
            r0 = r31;
            r31 = r0.append(r8);
            r31 = r31.toString();
            android.util.Log.v(r30, r31);
            r30 = "SyncManager";
            r31 = new java.lang.StringBuilder;
            r31.<init>();
            r32 = "  numActiveInit=";
            r31 = r31.append(r32);
            r0 = r31;
            r31 = r0.append(r15);
            r32 = ", numActiveRegular=";
            r31 = r31.append(r32);
            r0 = r31;
            r1 = r20;
            r31 = r0.append(r1);
            r31 = r31.toString();
            android.util.Log.v(r30, r31);
            r30 = "SyncManager";
            r31 = new java.lang.StringBuilder;
            r31.<init>();
            r32 = "  longRunning: ";
            r31 = r31.append(r32);
            r0 = r31;
            r31 = r0.append(r14);
            r31 = r31.toString();
            android.util.Log.v(r30, r31);
            r30 = "SyncManager";
            r31 = new java.lang.StringBuilder;
            r31.<init>();
            r32 = "  conflict: ";
            r31 = r31.append(r32);
            r0 = r31;
            r31 = r0.append(r10);
            r31 = r31.toString();
            android.util.Log.v(r30, r31);
            r30 = "SyncManager";
            r31 = new java.lang.StringBuilder;
            r31.<init>();
            r32 = "  oldestNonExpeditedRegular: ";
            r31 = r31.append(r32);
            r0 = r31;
            r1 = r21;
            r31 = r0.append(r1);
            r31 = r31.toString();
            android.util.Log.v(r30, r31);
        L_0x0396:
            if (r9 == 0) goto L_0x0421;
        L_0x0398:
            r30 = com.android.server.content.SyncManager.MAX_SIMULTANEOUS_INITIALIZATION_SYNCS;
            r0 = r30;
            if (r15 >= r0) goto L_0x041e;
        L_0x03a0:
            r26 = 1;
        L_0x03a2:
            if (r10 == 0) goto L_0x0477;
        L_0x03a4:
            if (r9 == 0) goto L_0x0433;
        L_0x03a6:
            r0 = r10.mSyncOperation;
            r30 = r0;
            r30 = r30.isInitialization();
            if (r30 != 0) goto L_0x0433;
        L_0x03b0:
            r30 = com.android.server.content.SyncManager.MAX_SIMULTANEOUS_INITIALIZATION_SYNCS;
            r0 = r30;
            if (r15 >= r0) goto L_0x0433;
        L_0x03b8:
            r27 = r10;
            r30 = "SyncManager";
            r31 = 2;
            r30 = android.util.Log.isLoggable(r30, r31);
            if (r30 == 0) goto L_0x03de;
        L_0x03c4:
            r30 = "SyncManager";
            r31 = new java.lang.StringBuilder;
            r31.<init>();
            r32 = "canceling and rescheduling sync since an initialization takes higher priority, ";
            r31 = r31.append(r32);
            r0 = r31;
            r31 = r0.append(r10);
            r31 = r31.toString();
            android.util.Log.v(r30, r31);
        L_0x03de:
            if (r27 == 0) goto L_0x03fa;
        L_0x03e0:
            r30 = 0;
            r0 = r36;
            r1 = r30;
            r2 = r27;
            r0.runSyncFinishedOrCanceledLocked(r1, r2);
            r0 = r36;
            r0 = com.android.server.content.SyncManager.this;
            r30 = r0;
            r0 = r27;
            r0 = r0.mSyncOperation;
            r31 = r0;
            r30.scheduleSyncOperation(r31);
        L_0x03fa:
            r0 = r36;
            r0 = com.android.server.content.SyncManager.this;
            r30 = r0;
            r31 = r30.mSyncQueue;
            monitor-enter(r31);
            r0 = r36;
            r0 = com.android.server.content.SyncManager.this;	 Catch:{ all -> 0x04e3 }
            r30 = r0;
            r30 = r30.mSyncQueue;	 Catch:{ all -> 0x04e3 }
            r0 = r30;
            r0.remove(r8);	 Catch:{ all -> 0x04e3 }
            monitor-exit(r31);	 Catch:{ all -> 0x04e3 }
            r0 = r36;
            r0.dispatchSyncOperation(r8);
        L_0x041a:
            r11 = r11 + 1;
            goto L_0x0272;
        L_0x041e:
            r26 = 0;
            goto L_0x03a2;
        L_0x0421:
            r30 = com.android.server.content.SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS;
            r0 = r20;
            r1 = r30;
            if (r0 >= r1) goto L_0x042f;
        L_0x042b:
            r26 = 1;
            goto L_0x03a2;
        L_0x042f:
            r26 = 0;
            goto L_0x03a2;
        L_0x0433:
            r30 = r8.isExpedited();
            if (r30 == 0) goto L_0x041a;
        L_0x0439:
            r0 = r10.mSyncOperation;
            r30 = r0;
            r30 = r30.isExpedited();
            if (r30 != 0) goto L_0x041a;
        L_0x0443:
            r0 = r10.mSyncOperation;
            r30 = r0;
            r30 = r30.isInitialization();
            r0 = r30;
            if (r9 != r0) goto L_0x041a;
        L_0x044f:
            r27 = r10;
            r30 = "SyncManager";
            r31 = 2;
            r30 = android.util.Log.isLoggable(r30, r31);
            if (r30 == 0) goto L_0x03de;
        L_0x045b:
            r30 = "SyncManager";
            r31 = new java.lang.StringBuilder;
            r31.<init>();
            r32 = "canceling and rescheduling sync since an expedited takes higher priority, ";
            r31 = r31.append(r32);
            r0 = r31;
            r31 = r0.append(r10);
            r31 = r31.toString();
            android.util.Log.v(r30, r31);
            goto L_0x03de;
        L_0x0477:
            if (r26 != 0) goto L_0x03de;
        L_0x0479:
            r30 = r8.isExpedited();
            if (r30 == 0) goto L_0x04ad;
        L_0x047f:
            if (r21 == 0) goto L_0x04ad;
        L_0x0481:
            if (r9 != 0) goto L_0x04ad;
        L_0x0483:
            r27 = r21;
            r30 = "SyncManager";
            r31 = 2;
            r30 = android.util.Log.isLoggable(r30, r31);
            if (r30 == 0) goto L_0x03de;
        L_0x048f:
            r30 = "SyncManager";
            r31 = new java.lang.StringBuilder;
            r31.<init>();
            r32 = "canceling and rescheduling sync since an expedited is ready to run, ";
            r31 = r31.append(r32);
            r0 = r31;
            r1 = r21;
            r31 = r0.append(r1);
            r31 = r31.toString();
            android.util.Log.v(r30, r31);
            goto L_0x03de;
        L_0x04ad:
            if (r14 == 0) goto L_0x041a;
        L_0x04af:
            r0 = r14.mSyncOperation;
            r30 = r0;
            r30 = r30.isInitialization();
            r0 = r30;
            if (r9 != r0) goto L_0x041a;
        L_0x04bb:
            r27 = r14;
            r30 = "SyncManager";
            r31 = 2;
            r30 = android.util.Log.isLoggable(r30, r31);
            if (r30 == 0) goto L_0x03de;
        L_0x04c7:
            r30 = "SyncManager";
            r31 = new java.lang.StringBuilder;
            r31.<init>();
            r32 = "canceling and rescheduling sync since it ran roo long, ";
            r31 = r31.append(r32);
            r0 = r31;
            r31 = r0.append(r14);
            r31 = r31.toString();
            android.util.Log.v(r30, r31);
            goto L_0x03de;
        L_0x04e3:
            r30 = move-exception;
            monitor-exit(r31);	 Catch:{ all -> 0x04e3 }
            throw r30;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.content.SyncManager.SyncHandler.maybeStartNextSyncLocked():long");
        }

        private boolean isOperationValidLocked(SyncOperation op) {
            int state;
            int targetUid;
            boolean isLoggable = Log.isLoggable(SyncManager.TAG, MESSAGE_SYNC_ALARM);
            EndPoint target = op.target;
            boolean syncEnabled = SyncManager.this.mSyncStorageEngine.getMasterSyncAutomatically(target.userId);
            if (target.target_provider) {
                if (SyncManager.this.containsAccountAndUser(SyncManager.this.mRunningAccounts, target.account, target.userId)) {
                    state = SyncManager.this.getIsSyncable(target.account, target.userId, target.provider);
                    if (state == 0) {
                        if (isLoggable) {
                            Log.v(SyncManager.TAG, "    Dropping sync operation: isSyncable == 0.");
                        }
                        return false;
                    }
                    syncEnabled = syncEnabled && SyncManager.this.mSyncStorageEngine.getSyncAutomatically(target.account, target.userId, target.provider);
                    ServiceInfo<SyncAdapterType> syncAdapterInfo = SyncManager.this.mSyncAdapters.getServiceInfo(SyncAdapterType.newKey(target.provider, target.account.type), target.userId);
                    if (syncAdapterInfo != null) {
                        targetUid = syncAdapterInfo.uid;
                    } else {
                        if (isLoggable) {
                            Log.v(SyncManager.TAG, "    Dropping sync operation: No sync adapter registeredfor: " + target);
                        }
                        return false;
                    }
                }
                if (isLoggable) {
                    Log.v(SyncManager.TAG, "    Dropping sync operation: account doesn't exist.");
                }
                return false;
            } else if (target.target_service) {
                state = SyncManager.this.mSyncStorageEngine.getIsTargetServiceActive(target.service, target.userId) ? MESSAGE_SYNC_FINISHED : SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS;
                if (state == 0) {
                    if (isLoggable) {
                        Log.v(SyncManager.TAG, "    Dropping sync operation: isActive == 0.");
                    }
                    return false;
                }
                try {
                    targetUid = SyncManager.this.mContext.getPackageManager().getServiceInfo(target.service, SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS).applicationInfo.uid;
                } catch (NameNotFoundException e) {
                    if (isLoggable) {
                        Log.v(SyncManager.TAG, "    Dropping sync operation: No service registered for: " + target.service);
                    }
                    return false;
                }
            } else {
                Log.e(SyncManager.TAG, "Unknown target for Sync Op: " + target);
                return false;
            }
            boolean ignoreSystemConfiguration = op.extras.getBoolean("ignore_settings", false) || state < 0;
            if (syncEnabled || ignoreSystemConfiguration) {
                NetworkInfo networkInfo = SyncManager.this.getConnectivityManager().getActiveNetworkInfoForUid(targetUid);
                boolean uidNetworkConnected = networkInfo != null && networkInfo.isConnected();
                if (!uidNetworkConnected && !ignoreSystemConfiguration) {
                    if (isLoggable) {
                        Log.v(SyncManager.TAG, "    Dropping sync operation: disallowed by settings/network.");
                    }
                    return false;
                } else if (!op.isNotAllowedOnMetered() || !SyncManager.this.getConnectivityManager().isActiveNetworkMetered() || ignoreSystemConfiguration) {
                    return true;
                } else {
                    if (isLoggable) {
                        Log.v(SyncManager.TAG, "    Dropping sync operation: not allowed on metered network.");
                    }
                    return false;
                }
            }
            if (isLoggable) {
                Log.v(SyncManager.TAG, "    Dropping sync operation: disallowed by settings/network.");
            }
            return false;
        }

        private boolean dispatchSyncOperation(SyncOperation op) {
            int targetUid;
            ComponentName targetComponent;
            if (Log.isLoggable(SyncManager.TAG, MESSAGE_SYNC_ALARM)) {
                Log.v(SyncManager.TAG, "dispatchSyncOperation: we are going to sync " + op);
                Log.v(SyncManager.TAG, "num active syncs: " + SyncManager.this.mActiveSyncContexts.size());
                Iterator i$ = SyncManager.this.mActiveSyncContexts.iterator();
                while (i$.hasNext()) {
                    Log.v(SyncManager.TAG, ((ActiveSyncContext) i$.next()).toString());
                }
            }
            EndPoint info = op.target;
            if (info.target_provider) {
                SyncAdapterType syncAdapterType = SyncAdapterType.newKey(info.provider, info.account.type);
                ServiceInfo<SyncAdapterType> syncAdapterInfo = SyncManager.this.mSyncAdapters.getServiceInfo(syncAdapterType, info.userId);
                if (syncAdapterInfo == null) {
                    Log.d(SyncManager.TAG, "can't find a sync adapter for " + syncAdapterType + ", removing settings for it");
                    SyncManager.this.mSyncStorageEngine.removeAuthority(info);
                    return false;
                }
                targetUid = syncAdapterInfo.uid;
                targetComponent = syncAdapterInfo.componentName;
            } else {
                try {
                    targetUid = SyncManager.this.mContext.getPackageManager().getServiceInfo(info.service, SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS).applicationInfo.uid;
                    targetComponent = info.service;
                } catch (NameNotFoundException e) {
                    Log.d(SyncManager.TAG, "Can't find a service for " + info.service + ", removing settings for it");
                    SyncManager.this.mSyncStorageEngine.removeAuthority(info);
                    return false;
                }
            }
            ActiveSyncContext activeSyncContext = new ActiveSyncContext(op, insertStartSyncEvent(op), targetUid);
            activeSyncContext.mSyncInfo = SyncManager.this.mSyncStorageEngine.addActiveSync(activeSyncContext);
            SyncManager.this.mActiveSyncContexts.add(activeSyncContext);
            if (!(activeSyncContext.mSyncOperation.isInitialization() || activeSyncContext.mSyncOperation.isExpedited() || activeSyncContext.mSyncOperation.isManual() || activeSyncContext.mSyncOperation.isIgnoreSettings())) {
                SyncManager.this.postSyncExpiryMessage(activeSyncContext);
            }
            if (Log.isLoggable(SyncManager.TAG, MESSAGE_SYNC_ALARM)) {
                Log.v(SyncManager.TAG, "dispatchSyncOperation: starting " + activeSyncContext);
            }
            if (activeSyncContext.bindToSyncAdapter(targetComponent, info.userId)) {
                return true;
            }
            Log.e(SyncManager.TAG, "Bind attempt failed - target: " + targetComponent);
            closeActiveSyncContext(activeSyncContext);
            return false;
        }

        private void runBoundToAdapter(ActiveSyncContext activeSyncContext, IBinder syncAdapter) {
            SyncOperation syncOperation = activeSyncContext.mSyncOperation;
            try {
                activeSyncContext.mIsLinkedToDeath = true;
                syncAdapter.linkToDeath(activeSyncContext, SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS);
                if (syncOperation.target.target_provider) {
                    activeSyncContext.mSyncAdapter = ISyncAdapter.Stub.asInterface(syncAdapter);
                    activeSyncContext.mSyncAdapter.startSync(activeSyncContext, syncOperation.target.provider, syncOperation.target.account, syncOperation.extras);
                } else if (syncOperation.target.target_service) {
                    activeSyncContext.mSyncServiceAdapter = ISyncServiceAdapter.Stub.asInterface(syncAdapter);
                    activeSyncContext.mSyncServiceAdapter.startSync(activeSyncContext, syncOperation.extras);
                }
            } catch (RemoteException remoteExc) {
                Log.d(SyncManager.TAG, "maybeStartNextSync: caught a RemoteException, rescheduling", remoteExc);
                closeActiveSyncContext(activeSyncContext);
                SyncManager.this.increaseBackoffSetting(syncOperation);
                SyncManager.this.scheduleSyncOperation(new SyncOperation(syncOperation, SyncManager.SYNC_NOTIFICATION_DELAY));
            } catch (RuntimeException exc) {
                closeActiveSyncContext(activeSyncContext);
                Log.e(SyncManager.TAG, "Caught RuntimeException while starting the sync " + syncOperation, exc);
            }
        }

        private void cancelActiveSyncLocked(EndPoint info, Bundle extras) {
            Iterator i$ = new ArrayList(SyncManager.this.mActiveSyncContexts).iterator();
            while (i$.hasNext()) {
                ActiveSyncContext activeSyncContext = (ActiveSyncContext) i$.next();
                if (activeSyncContext != null && activeSyncContext.mSyncOperation.target.matchesSpec(info)) {
                    if (extras == null || SyncManager.syncExtrasEquals(activeSyncContext.mSyncOperation.extras, extras, false)) {
                        runSyncFinishedOrCanceledLocked(null, activeSyncContext);
                    }
                }
            }
        }

        private void runSyncFinishedOrCanceledLocked(SyncResult syncResult, ActiveSyncContext activeSyncContext) {
            String historyMessage;
            int downstreamActivity;
            int upstreamActivity;
            boolean isLoggable = Log.isLoggable(SyncManager.TAG, MESSAGE_SYNC_ALARM);
            SyncOperation syncOperation = activeSyncContext.mSyncOperation;
            EndPoint info = syncOperation.target;
            if (activeSyncContext.mIsLinkedToDeath) {
                if (info.target_provider) {
                    activeSyncContext.mSyncAdapter.asBinder().unlinkToDeath(activeSyncContext, SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS);
                } else {
                    activeSyncContext.mSyncServiceAdapter.asBinder().unlinkToDeath(activeSyncContext, SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS);
                }
                activeSyncContext.mIsLinkedToDeath = false;
            }
            closeActiveSyncContext(activeSyncContext);
            long elapsedTime = SystemClock.elapsedRealtime() - activeSyncContext.mStartTime;
            if (syncResult != null) {
                if (isLoggable) {
                    Log.v(SyncManager.TAG, "runSyncFinishedOrCanceled [finished]: " + syncOperation + ", result " + syncResult);
                }
                if (syncResult.hasError()) {
                    Log.d(SyncManager.TAG, "failed sync operation " + syncOperation + ", " + syncResult);
                    SyncManager.this.increaseBackoffSetting(syncOperation);
                    SyncManager.this.maybeRescheduleSync(syncResult, syncOperation);
                    historyMessage = ContentResolver.syncErrorToString(syncResultToErrorNumber(syncResult));
                    downstreamActivity = SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS;
                    upstreamActivity = SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS;
                } else {
                    historyMessage = SyncStorageEngine.MESG_SUCCESS;
                    downstreamActivity = SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS;
                    upstreamActivity = SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS;
                    SyncManager.this.clearBackoffSetting(syncOperation);
                }
                SyncManager.this.setDelayUntilTime(syncOperation, syncResult.delayUntil);
            } else {
                if (isLoggable) {
                    Log.v(SyncManager.TAG, "runSyncFinishedOrCanceled [canceled]: " + syncOperation);
                }
                if (activeSyncContext.mSyncAdapter != null) {
                    try {
                        activeSyncContext.mSyncAdapter.cancelSync(activeSyncContext);
                    } catch (RemoteException e) {
                    }
                } else if (activeSyncContext.mSyncServiceAdapter != null) {
                    try {
                        activeSyncContext.mSyncServiceAdapter.cancelSync(activeSyncContext);
                    } catch (RemoteException e2) {
                    }
                }
                historyMessage = SyncStorageEngine.MESG_CANCELED;
                downstreamActivity = SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS;
                upstreamActivity = SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS;
            }
            stopSyncEvent(activeSyncContext.mHistoryRowId, syncOperation, historyMessage, upstreamActivity, downstreamActivity, elapsedTime);
            if (info.target_provider) {
                if (syncResult == null || !syncResult.tooManyDeletions) {
                    SyncManager.this.mNotificationMgr.cancelAsUser(null, info.account.hashCode() ^ info.provider.hashCode(), new UserHandle(info.userId));
                } else {
                    installHandleTooManyDeletesNotification(info.account, info.provider, syncResult.stats.numDeletes, info.userId);
                }
                if (syncResult != null && syncResult.fullSyncRequested) {
                    SyncManager.this.scheduleSyncOperation(new SyncOperation(info.account, info.userId, syncOperation.reason, syncOperation.syncSource, info.provider, new Bundle(), SyncManager.SYNC_NOTIFICATION_DELAY, SyncManager.SYNC_NOTIFICATION_DELAY, syncOperation.backoff, syncOperation.delayUntil, syncOperation.allowParallelSyncs));
                }
            } else if (syncResult != null && syncResult.fullSyncRequested) {
                SyncManager.this.scheduleSyncOperation(new SyncOperation(info.service, info.userId, syncOperation.reason, syncOperation.syncSource, new Bundle(), (long) SyncManager.SYNC_NOTIFICATION_DELAY, (long) SyncManager.SYNC_NOTIFICATION_DELAY, syncOperation.backoff, syncOperation.delayUntil));
            }
        }

        private void closeActiveSyncContext(ActiveSyncContext activeSyncContext) {
            activeSyncContext.close();
            SyncManager.this.mActiveSyncContexts.remove(activeSyncContext);
            SyncManager.this.mSyncStorageEngine.removeActiveSync(activeSyncContext.mSyncInfo, activeSyncContext.mSyncOperation.target.userId);
            SyncManager.this.removeSyncExpiryMessage(activeSyncContext);
        }

        private int syncResultToErrorNumber(SyncResult syncResult) {
            if (syncResult.syncAlreadyInProgress) {
                return MESSAGE_SYNC_FINISHED;
            }
            if (syncResult.stats.numAuthExceptions > SyncManager.SYNC_NOTIFICATION_DELAY) {
                return MESSAGE_SYNC_ALARM;
            }
            if (syncResult.stats.numIoExceptions > SyncManager.SYNC_NOTIFICATION_DELAY) {
                return MESSAGE_CHECK_ALARMS;
            }
            if (syncResult.stats.numParseExceptions > SyncManager.SYNC_NOTIFICATION_DELAY) {
                return MESSAGE_SERVICE_CONNECTED;
            }
            if (syncResult.stats.numConflictDetectedExceptions > SyncManager.SYNC_NOTIFICATION_DELAY) {
                return MESSAGE_SERVICE_DISCONNECTED;
            }
            if (syncResult.tooManyDeletions) {
                return MESSAGE_CANCEL;
            }
            if (syncResult.tooManyRetries) {
                return MESSAGE_SYNC_EXPIRED;
            }
            if (syncResult.databaseError) {
                return 8;
            }
            throw new IllegalStateException("we are not in an error state, " + syncResult);
        }

        private void manageSyncNotificationLocked() {
            boolean shouldCancel;
            int i;
            if (!SyncManager.this.mActiveSyncContexts.isEmpty()) {
                long now = SystemClock.elapsedRealtime();
                if (this.mSyncNotificationInfo.startTime == null) {
                    this.mSyncNotificationInfo.startTime = Long.valueOf(now);
                }
                if (!this.mSyncNotificationInfo.isActive) {
                    boolean timeToShowNotification;
                    shouldCancel = false;
                    if (now > this.mSyncNotificationInfo.startTime.longValue() + SyncManager.SYNC_NOTIFICATION_DELAY) {
                        timeToShowNotification = true;
                    } else {
                        timeToShowNotification = false;
                    }
                    if (!timeToShowNotification) {
                        i = SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS;
                        Iterator i$ = SyncManager.this.mActiveSyncContexts.iterator();
                        while (i$.hasNext()) {
                            if (((ActiveSyncContext) i$.next()).mSyncOperation.extras.getBoolean("force", false)) {
                                i = MESSAGE_SYNC_FINISHED;
                                break;
                            }
                        }
                    }
                    i = MESSAGE_SYNC_FINISHED;
                } else {
                    shouldCancel = false;
                    i = SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS;
                }
            } else {
                this.mSyncNotificationInfo.startTime = null;
                shouldCancel = this.mSyncNotificationInfo.isActive;
                i = SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS;
            }
            if (shouldCancel && i == 0) {
                SyncManager.this.mNeedSyncActiveNotification = false;
                sendSyncStateIntent();
                this.mSyncNotificationInfo.isActive = false;
            }
            if (i != 0) {
                SyncManager.this.mNeedSyncActiveNotification = true;
                sendSyncStateIntent();
                this.mSyncNotificationInfo.isActive = true;
            }
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        private void manageSyncAlarmLocked(long r28, long r30) {
            /*
            r27 = this;
            r0 = r27;
            r0 = com.android.server.content.SyncManager.this;
            r20 = r0;
            r20 = r20.mDataConnectionIsConnected;
            if (r20 != 0) goto L_0x000d;
        L_0x000c:
            return;
        L_0x000d:
            r0 = r27;
            r0 = com.android.server.content.SyncManager.this;
            r20 = r0;
            r20 = r20.mStorageIsLow;
            if (r20 != 0) goto L_0x000c;
        L_0x0019:
            r0 = r27;
            r0 = com.android.server.content.SyncManager.this;
            r20 = r0;
            r20 = r20.mSyncHandler;
            r0 = r20;
            r0 = r0.mSyncNotificationInfo;
            r20 = r0;
            r0 = r20;
            r0 = r0.isActive;
            r20 = r0;
            if (r20 != 0) goto L_0x00be;
        L_0x0031:
            r0 = r27;
            r0 = com.android.server.content.SyncManager.this;
            r20 = r0;
            r20 = r20.mSyncHandler;
            r0 = r20;
            r0 = r0.mSyncNotificationInfo;
            r20 = r0;
            r0 = r20;
            r0 = r0.startTime;
            r20 = r0;
            if (r20 == 0) goto L_0x00be;
        L_0x0049:
            r0 = r27;
            r0 = com.android.server.content.SyncManager.this;
            r20 = r0;
            r20 = r20.mSyncHandler;
            r0 = r20;
            r0 = r0.mSyncNotificationInfo;
            r20 = r0;
            r0 = r20;
            r0 = r0.startTime;
            r20 = r0;
            r20 = r20.longValue();
            r22 = com.android.server.content.SyncManager.SYNC_NOTIFICATION_DELAY;
            r14 = r20 + r22;
        L_0x0069:
            r10 = 9223372036854775807; // 0x7fffffffffffffff float:NaN double:NaN;
            r0 = r27;
            r0 = com.android.server.content.SyncManager.this;
            r20 = r0;
            r0 = r20;
            r0 = r0.mActiveSyncContexts;
            r20 = r0;
            r12 = r20.iterator();
        L_0x007e:
            r20 = r12.hasNext();
            if (r20 == 0) goto L_0x00c4;
        L_0x0084:
            r5 = r12.next();
            r5 = (com.android.server.content.SyncManager.ActiveSyncContext) r5;
            r0 = r5.mTimeoutStartTime;
            r20 = r0;
            r22 = com.android.server.content.SyncManager.MAX_TIME_PER_SYNC;
            r8 = r20 + r22;
            r20 = "SyncManager";
            r21 = 2;
            r20 = android.util.Log.isLoggable(r20, r21);
            if (r20 == 0) goto L_0x00b8;
        L_0x009e:
            r20 = "SyncManager";
            r21 = new java.lang.StringBuilder;
            r21.<init>();
            r22 = "manageSyncAlarm: active sync, mTimeoutStartTime + MAX is ";
            r21 = r21.append(r22);
            r0 = r21;
            r21 = r0.append(r8);
            r21 = r21.toString();
            android.util.Log.v(r20, r21);
        L_0x00b8:
            r20 = (r10 > r8 ? 1 : (r10 == r8 ? 0 : -1));
            if (r20 <= 0) goto L_0x007e;
        L_0x00bc:
            r10 = r8;
            goto L_0x007e;
        L_0x00be:
            r14 = 9223372036854775807; // 0x7fffffffffffffff float:NaN double:NaN;
            goto L_0x0069;
        L_0x00c4:
            r20 = "SyncManager";
            r21 = 2;
            r20 = android.util.Log.isLoggable(r20, r21);
            if (r20 == 0) goto L_0x00e8;
        L_0x00ce:
            r20 = "SyncManager";
            r21 = new java.lang.StringBuilder;
            r21.<init>();
            r22 = "manageSyncAlarm: notificationTime is ";
            r21 = r21.append(r22);
            r0 = r21;
            r21 = r0.append(r14);
            r21 = r21.toString();
            android.util.Log.v(r20, r21);
        L_0x00e8:
            r20 = "SyncManager";
            r21 = 2;
            r20 = android.util.Log.isLoggable(r20, r21);
            if (r20 == 0) goto L_0x010c;
        L_0x00f2:
            r20 = "SyncManager";
            r21 = new java.lang.StringBuilder;
            r21.<init>();
            r22 = "manageSyncAlarm: earliestTimeoutTime is ";
            r21 = r21.append(r22);
            r0 = r21;
            r21 = r0.append(r10);
            r21 = r21.toString();
            android.util.Log.v(r20, r21);
        L_0x010c:
            r20 = "SyncManager";
            r21 = 2;
            r20 = android.util.Log.isLoggable(r20, r21);
            if (r20 == 0) goto L_0x0132;
        L_0x0116:
            r20 = "SyncManager";
            r21 = new java.lang.StringBuilder;
            r21.<init>();
            r22 = "manageSyncAlarm: nextPeriodicEventElapsedTime is ";
            r21 = r21.append(r22);
            r0 = r21;
            r1 = r28;
            r21 = r0.append(r1);
            r21 = r21.toString();
            android.util.Log.v(r20, r21);
        L_0x0132:
            r20 = "SyncManager";
            r21 = 2;
            r20 = android.util.Log.isLoggable(r20, r21);
            if (r20 == 0) goto L_0x0158;
        L_0x013c:
            r20 = "SyncManager";
            r21 = new java.lang.StringBuilder;
            r21.<init>();
            r22 = "manageSyncAlarm: nextPendingEventElapsedTime is ";
            r21 = r21.append(r22);
            r0 = r21;
            r1 = r30;
            r21 = r0.append(r1);
            r21 = r21.toString();
            android.util.Log.v(r20, r21);
        L_0x0158:
            r6 = java.lang.Math.min(r14, r10);
            r0 = r28;
            r6 = java.lang.Math.min(r6, r0);
            r0 = r30;
            r6 = java.lang.Math.min(r6, r0);
            r16 = android.os.SystemClock.elapsedRealtime();
            r20 = 30000; // 0x7530 float:4.2039E-41 double:1.4822E-319;
            r20 = r20 + r16;
            r20 = (r6 > r20 ? 1 : (r6 == r20 ? 0 : -1));
            if (r20 >= 0) goto L_0x0261;
        L_0x0174:
            r20 = "SyncManager";
            r21 = 2;
            r20 = android.util.Log.isLoggable(r20, r21);
            if (r20 == 0) goto L_0x01a6;
        L_0x017e:
            r20 = "SyncManager";
            r21 = new java.lang.StringBuilder;
            r21.<init>();
            r22 = "manageSyncAlarm: the alarmTime is too small, ";
            r21 = r21.append(r22);
            r0 = r21;
            r21 = r0.append(r6);
            r22 = ", setting to ";
            r21 = r21.append(r22);
            r22 = 30000; // 0x7530 float:4.2039E-41 double:1.4822E-319;
            r22 = r22 + r16;
            r21 = r21.append(r22);
            r21 = r21.toString();
            android.util.Log.v(r20, r21);
        L_0x01a6:
            r20 = 30000; // 0x7530 float:4.2039E-41 double:1.4822E-319;
            r6 = r16 + r20;
        L_0x01aa:
            r19 = 0;
            r18 = 0;
            r0 = r27;
            r0 = r0.mAlarmScheduleTime;
            r20 = r0;
            if (r20 == 0) goto L_0x02a3;
        L_0x01b6:
            r0 = r27;
            r0 = r0.mAlarmScheduleTime;
            r20 = r0;
            r20 = r20.longValue();
            r20 = (r16 > r20 ? 1 : (r16 == r20 ? 0 : -1));
            if (r20 >= 0) goto L_0x02a3;
        L_0x01c4:
            r4 = 1;
        L_0x01c5:
            r20 = 9223372036854775807; // 0x7fffffffffffffff float:NaN double:NaN;
            r20 = (r6 > r20 ? 1 : (r6 == r20 ? 0 : -1));
            if (r20 == 0) goto L_0x02a6;
        L_0x01ce:
            r13 = 1;
        L_0x01cf:
            if (r13 == 0) goto L_0x02a9;
        L_0x01d1:
            if (r4 == 0) goto L_0x01e1;
        L_0x01d3:
            r0 = r27;
            r0 = r0.mAlarmScheduleTime;
            r20 = r0;
            r20 = r20.longValue();
            r20 = (r6 > r20 ? 1 : (r6 == r20 ? 0 : -1));
            if (r20 == 0) goto L_0x01e3;
        L_0x01e1:
            r19 = 1;
        L_0x01e3:
            r0 = r27;
            r0 = com.android.server.content.SyncManager.this;
            r20 = r0;
            r20.ensureAlarmService();
            if (r19 == 0) goto L_0x02ad;
        L_0x01ee:
            r20 = "SyncManager";
            r21 = 2;
            r20 = android.util.Log.isLoggable(r20, r21);
            if (r20 == 0) goto L_0x0236;
        L_0x01f8:
            r20 = "SyncManager";
            r21 = new java.lang.StringBuilder;
            r21.<init>();
            r22 = "requesting that the alarm manager wake us up at elapsed time ";
            r21 = r21.append(r22);
            r0 = r21;
            r21 = r0.append(r6);
            r22 = ", now is ";
            r21 = r21.append(r22);
            r0 = r21;
            r1 = r16;
            r21 = r0.append(r1);
            r22 = ", ";
            r21 = r21.append(r22);
            r22 = r6 - r16;
            r24 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;
            r22 = r22 / r24;
            r21 = r21.append(r22);
            r22 = " secs from now";
            r21 = r21.append(r22);
            r21 = r21.toString();
            android.util.Log.v(r20, r21);
        L_0x0236:
            r20 = java.lang.Long.valueOf(r6);
            r0 = r20;
            r1 = r27;
            r1.mAlarmScheduleTime = r0;
            r0 = r27;
            r0 = com.android.server.content.SyncManager.this;
            r20 = r0;
            r20 = r20.mAlarmService;
            r21 = 2;
            r0 = r27;
            r0 = com.android.server.content.SyncManager.this;
            r22 = r0;
            r22 = r22.mSyncAlarmIntent;
            r0 = r20;
            r1 = r21;
            r2 = r22;
            r0.setExact(r1, r6, r2);
            goto L_0x000c;
        L_0x0261:
            r20 = 7200000; // 0x6ddd00 float:1.0089349E-38 double:3.5572727E-317;
            r20 = r20 + r16;
            r20 = (r6 > r20 ? 1 : (r6 == r20 ? 0 : -1));
            if (r20 <= 0) goto L_0x01aa;
        L_0x026a:
            r20 = "SyncManager";
            r21 = 2;
            r20 = android.util.Log.isLoggable(r20, r21);
            if (r20 == 0) goto L_0x029c;
        L_0x0274:
            r20 = "SyncManager";
            r21 = new java.lang.StringBuilder;
            r21.<init>();
            r22 = "manageSyncAlarm: the alarmTime is too large, ";
            r21 = r21.append(r22);
            r0 = r21;
            r21 = r0.append(r6);
            r22 = ", setting to ";
            r21 = r21.append(r22);
            r22 = 30000; // 0x7530 float:4.2039E-41 double:1.4822E-319;
            r22 = r22 + r16;
            r21 = r21.append(r22);
            r21 = r21.toString();
            android.util.Log.v(r20, r21);
        L_0x029c:
            r20 = 7200000; // 0x6ddd00 float:1.0089349E-38 double:3.5572727E-317;
            r6 = r16 + r20;
            goto L_0x01aa;
        L_0x02a3:
            r4 = 0;
            goto L_0x01c5;
        L_0x02a6:
            r13 = 0;
            goto L_0x01cf;
        L_0x02a9:
            r18 = r4;
            goto L_0x01e3;
        L_0x02ad:
            if (r18 == 0) goto L_0x000c;
        L_0x02af:
            r20 = 0;
            r0 = r20;
            r1 = r27;
            r1.mAlarmScheduleTime = r0;
            r0 = r27;
            r0 = com.android.server.content.SyncManager.this;
            r20 = r0;
            r20 = r20.mAlarmService;
            r0 = r27;
            r0 = com.android.server.content.SyncManager.this;
            r21 = r0;
            r21 = r21.mSyncAlarmIntent;
            r20.cancel(r21);
            goto L_0x000c;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.content.SyncManager.SyncHandler.manageSyncAlarmLocked(long, long):void");
        }

        private void sendSyncStateIntent() {
            Intent syncStateIntent = new Intent("android.intent.action.SYNC_STATE_CHANGED");
            syncStateIntent.addFlags(67108864);
            syncStateIntent.putExtra("active", SyncManager.this.mNeedSyncActiveNotification);
            syncStateIntent.putExtra("failing", false);
            SyncManager.this.mContext.sendBroadcastAsUser(syncStateIntent, UserHandle.OWNER);
        }

        private void installHandleTooManyDeletesNotification(Account account, String authority, long numDeletes, int userId) {
            if (SyncManager.this.mNotificationMgr != null) {
                ProviderInfo providerInfo = SyncManager.this.mContext.getPackageManager().resolveContentProvider(authority, SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS);
                if (providerInfo != null) {
                    CharSequence authorityName = providerInfo.loadLabel(SyncManager.this.mContext.getPackageManager());
                    Intent clickIntent = new Intent(SyncManager.this.mContext, SyncActivityTooManyDeletes.class);
                    clickIntent.putExtra("account", account);
                    clickIntent.putExtra("authority", authority);
                    clickIntent.putExtra("provider", authorityName.toString());
                    clickIntent.putExtra("numDeletes", numDeletes);
                    if (isActivityAvailable(clickIntent)) {
                        UserHandle user = new UserHandle(userId);
                        PendingIntent pendingIntent = PendingIntent.getActivityAsUser(SyncManager.this.mContext, SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS, clickIntent, 268435456, null, user);
                        CharSequence tooManyDeletesDescFormat = SyncManager.this.mContext.getResources().getText(17039595);
                        Context contextForUser = SyncManager.this.getContextForUser(user);
                        Notification notification = new Notification(17303120, SyncManager.this.mContext.getString(17039593), System.currentTimeMillis());
                        notification.color = contextForUser.getResources().getColor(17170521);
                        CharSequence string = contextForUser.getString(17039594);
                        String charSequence = tooManyDeletesDescFormat.toString();
                        Object[] objArr = new Object[MESSAGE_SYNC_FINISHED];
                        objArr[SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS] = authorityName;
                        notification.setLatestEventInfo(contextForUser, string, String.format(charSequence, objArr), pendingIntent);
                        notification.flags |= MESSAGE_SYNC_ALARM;
                        SyncManager.this.mNotificationMgr.notifyAsUser(null, account.hashCode() ^ authority.hashCode(), notification, user);
                        return;
                    }
                    Log.w(SyncManager.TAG, "No activity found to handle too many deletes.");
                }
            }
        }

        private boolean isActivityAvailable(Intent intent) {
            List<ResolveInfo> list = SyncManager.this.mContext.getPackageManager().queryIntentActivities(intent, SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS);
            int listSize = list.size();
            for (int i = SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS; i < listSize; i += MESSAGE_SYNC_FINISHED) {
                if ((((ResolveInfo) list.get(i)).activityInfo.applicationInfo.flags & MESSAGE_SYNC_FINISHED) != 0) {
                    return true;
                }
            }
            return false;
        }

        public long insertStartSyncEvent(SyncOperation syncOperation) {
            long now = System.currentTimeMillis();
            EventLog.writeEvent(2720, syncOperation.toEventLog(SyncManager.MAX_SIMULTANEOUS_REGULAR_SYNCS));
            return SyncManager.this.mSyncStorageEngine.insertStartSyncEvent(syncOperation, now);
        }

        public void stopSyncEvent(long rowId, SyncOperation syncOperation, String resultMessage, int upstreamActivity, int downstreamActivity, long elapsedTime) {
            EventLog.writeEvent(2720, syncOperation.toEventLog(MESSAGE_SYNC_FINISHED));
            SyncManager.this.mSyncStorageEngine.stopSyncEvent(rowId, elapsedTime, resultMessage, (long) downstreamActivity, (long) upstreamActivity);
        }
    }

    class SyncHandlerMessagePayload {
        public final ActiveSyncContext activeSyncContext;
        public final SyncResult syncResult;

        SyncHandlerMessagePayload(ActiveSyncContext syncContext, SyncResult syncResult) {
            this.activeSyncContext = syncContext;
            this.syncResult = syncResult;
        }
    }

    private class SyncTimeTracker {
        boolean mLastWasSyncing;
        private long mTimeSpentSyncing;
        long mWhenSyncStarted;

        private SyncTimeTracker() {
            this.mLastWasSyncing = false;
            this.mWhenSyncStarted = SyncManager.SYNC_NOTIFICATION_DELAY;
        }

        public synchronized void update() {
            boolean isSyncInProgress = !SyncManager.this.mActiveSyncContexts.isEmpty();
            if (isSyncInProgress != this.mLastWasSyncing) {
                long now = SystemClock.elapsedRealtime();
                if (isSyncInProgress) {
                    this.mWhenSyncStarted = now;
                } else {
                    this.mTimeSpentSyncing += now - this.mWhenSyncStarted;
                }
                this.mLastWasSyncing = isSyncInProgress;
            }
        }

        public synchronized long timeSpentSyncing() {
            long elapsedRealtime;
            if (this.mLastWasSyncing) {
                elapsedRealtime = this.mTimeSpentSyncing + (SystemClock.elapsedRealtime() - this.mWhenSyncStarted);
            } else {
                elapsedRealtime = this.mTimeSpentSyncing;
            }
            return elapsedRealtime;
        }
    }

    static {
        boolean isLargeRAM;
        int defaultMaxInitSyncs;
        int defaultMaxRegularSyncs = 2;
        if (ActivityManager.isLowRamDeviceStatic()) {
            isLargeRAM = false;
        } else {
            isLargeRAM = true;
        }
        if (isLargeRAM) {
            defaultMaxInitSyncs = 5;
        } else {
            defaultMaxInitSyncs = 2;
        }
        if (!isLargeRAM) {
            defaultMaxRegularSyncs = 1;
        }
        MAX_SIMULTANEOUS_INITIALIZATION_SYNCS = SystemProperties.getInt("sync.max_init_syncs", defaultMaxInitSyncs);
        MAX_SIMULTANEOUS_REGULAR_SYNCS = SystemProperties.getInt("sync.max_regular_syncs", defaultMaxRegularSyncs);
        LOCAL_SYNC_DELAY = SystemProperties.getLong("sync.local_sync_delay", SYNC_ALARM_TIMEOUT_MIN);
        MAX_TIME_PER_SYNC = SystemProperties.getLong("sync.max_time_per_sync", 300000);
        SYNC_NOTIFICATION_DELAY = SystemProperties.getLong("sync.notification_delay", SYNC_ALARM_TIMEOUT_MIN);
        INITIAL_ACCOUNTS_ARRAY = new AccountAndUser[MAX_SIMULTANEOUS_REGULAR_SYNCS];
    }

    private List<UserInfo> getAllUsers() {
        return this.mUserManager.getUsers();
    }

    private boolean containsAccountAndUser(AccountAndUser[] accounts, Account account, int userId) {
        int i = MAX_SIMULTANEOUS_REGULAR_SYNCS;
        while (i < accounts.length) {
            if (accounts[i].userId == userId && accounts[i].account.equals(account)) {
                return true;
            }
            i++;
        }
        return false;
    }

    public void updateRunningAccounts() {
        this.mRunningAccounts = AccountManagerService.getSingleton().getRunningAccounts();
        if (this.mBootCompleted) {
            doDatabaseCleanup();
        }
        AccountAndUser[] accounts = this.mRunningAccounts;
        Iterator i$ = this.mActiveSyncContexts.iterator();
        while (i$.hasNext()) {
            ActiveSyncContext currentSyncContext = (ActiveSyncContext) i$.next();
            if (!containsAccountAndUser(accounts, currentSyncContext.mSyncOperation.target.account, currentSyncContext.mSyncOperation.target.userId)) {
                Log.d(TAG, "canceling sync since the account is no longer running");
                sendSyncFinishedOrCanceledMessage(currentSyncContext, null);
            }
        }
        sendCheckAlarmsMessage();
    }

    private void doDatabaseCleanup() {
        for (UserInfo user : this.mUserManager.getUsers(true)) {
            if (!user.partial) {
                this.mSyncStorageEngine.doDatabaseCleanup(AccountManagerService.getSingleton().getAccounts(user.id), user.id);
            }
        }
    }

    private boolean readDataConnectionState() {
        NetworkInfo networkInfo = getConnectivityManager().getActiveNetworkInfo();
        return networkInfo != null && networkInfo.isConnected();
    }

    private ConnectivityManager getConnectivityManager() {
        ConnectivityManager connectivityManager;
        synchronized (this) {
            if (this.mConnManagerDoNotUseDirectly == null) {
                this.mConnManagerDoNotUseDirectly = (ConnectivityManager) this.mContext.getSystemService("connectivity");
            }
            connectivityManager = this.mConnManagerDoNotUseDirectly;
        }
        return connectivityManager;
    }

    public SyncManager(Context context, boolean factoryTest) {
        IntentFilter intentFilter;
        this.mRunningAccounts = INITIAL_ACCOUNTS_ARRAY;
        this.mDataConnectionIsConnected = false;
        this.mStorageIsLow = false;
        this.mAlarmService = null;
        this.mActiveSyncContexts = Lists.newArrayList();
        this.mNeedSyncActiveNotification = false;
        this.mStorageIntentReceiver = new C01771();
        this.mBootCompletedReceiver = new C01782();
        this.mAccountsUpdatedReceiver = new C01793();
        this.mConnectivityIntentReceiver = new C01804();
        this.mShutdownIntentReceiver = new C01815();
        this.mUserIntentReceiver = new C01826();
        this.mBootCompleted = false;
        this.mContext = context;
        SyncStorageEngine.init(context);
        this.mSyncStorageEngine = SyncStorageEngine.getSingleton();
        this.mSyncStorageEngine.setOnSyncRequestListener(new C01837());
        this.mSyncAdapters = new SyncAdaptersCache(this.mContext);
        this.mSyncQueue = new SyncQueue(this.mContext.getPackageManager(), this.mSyncStorageEngine, this.mSyncAdapters);
        this.mSyncHandler = new SyncHandler(BackgroundThread.get().getLooper());
        this.mSyncAdapters.setListener(new C01848(), this.mSyncHandler);
        this.mSyncAlarmIntent = PendingIntent.getBroadcast(this.mContext, MAX_SIMULTANEOUS_REGULAR_SYNCS, new Intent(ACTION_SYNC_ALARM), MAX_SIMULTANEOUS_REGULAR_SYNCS);
        context.registerReceiver(this.mConnectivityIntentReceiver, new IntentFilter("android.net.conn.CONNECTIVITY_CHANGE"));
        if (!factoryTest) {
            intentFilter = new IntentFilter("android.intent.action.BOOT_COMPLETED");
            intentFilter.setPriority(ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE);
            context.registerReceiver(this.mBootCompletedReceiver, intentFilter);
        }
        intentFilter = new IntentFilter("android.intent.action.DEVICE_STORAGE_LOW");
        intentFilter.addAction("android.intent.action.DEVICE_STORAGE_OK");
        context.registerReceiver(this.mStorageIntentReceiver, intentFilter);
        intentFilter = new IntentFilter("android.intent.action.ACTION_SHUTDOWN");
        intentFilter.setPriority(100);
        context.registerReceiver(this.mShutdownIntentReceiver, intentFilter);
        intentFilter = new IntentFilter();
        intentFilter.addAction("android.intent.action.USER_REMOVED");
        intentFilter.addAction("android.intent.action.USER_STARTING");
        intentFilter.addAction("android.intent.action.USER_STOPPING");
        this.mContext.registerReceiverAsUser(this.mUserIntentReceiver, UserHandle.ALL, intentFilter, null, null);
        if (factoryTest) {
            this.mNotificationMgr = null;
        } else {
            this.mNotificationMgr = (NotificationManager) context.getSystemService("notification");
            context.registerReceiver(new SyncAlarmIntentReceiver(), new IntentFilter(ACTION_SYNC_ALARM));
        }
        this.mPowerManager = (PowerManager) context.getSystemService("power");
        this.mUserManager = (UserManager) this.mContext.getSystemService("user");
        this.mBatteryStats = IBatteryStats.Stub.asInterface(ServiceManager.getService("batterystats"));
        this.mHandleAlarmWakeLock = this.mPowerManager.newWakeLock(1, HANDLE_SYNC_ALARM_WAKE_LOCK);
        this.mHandleAlarmWakeLock.setReferenceCounted(false);
        this.mSyncManagerWakeLock = this.mPowerManager.newWakeLock(1, SYNC_LOOP_WAKE_LOCK);
        this.mSyncManagerWakeLock.setReferenceCounted(false);
        this.mSyncStorageEngine.addStatusChangeListener(1, new C01859());
        if (!factoryTest) {
            this.mContext.registerReceiverAsUser(this.mAccountsUpdatedReceiver, UserHandle.ALL, new IntentFilter("android.accounts.LOGIN_ACCOUNTS_CHANGED"), null, null);
        }
        this.mSyncRandomOffsetMillis = this.mSyncStorageEngine.getSyncRandomOffset() * ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE;
    }

    private long jitterize(long minValue, long maxValue) {
        Random random = new Random(SystemClock.elapsedRealtime());
        long spread = maxValue - minValue;
        if (spread <= 2147483647L) {
            return ((long) random.nextInt((int) spread)) + minValue;
        }
        throw new IllegalArgumentException("the difference between the maxValue and the minValue must be less than 2147483647");
    }

    public SyncStorageEngine getSyncStorageEngine() {
        return this.mSyncStorageEngine;
    }

    public int getIsSyncable(Account account, int userId, String providerName) {
        int isSyncable = this.mSyncStorageEngine.getIsSyncable(account, userId, providerName);
        UserInfo userInfo = UserManager.get(this.mContext).getUserInfo(userId);
        if (userInfo == null || !userInfo.isRestricted()) {
            return isSyncable;
        }
        ServiceInfo<SyncAdapterType> syncAdapterInfo = this.mSyncAdapters.getServiceInfo(SyncAdapterType.newKey(providerName, account.type), userId);
        if (syncAdapterInfo == null) {
            return isSyncable;
        }
        try {
            PackageInfo pInfo = AppGlobals.getPackageManager().getPackageInfo(syncAdapterInfo.componentName.getPackageName(), MAX_SIMULTANEOUS_REGULAR_SYNCS, userId);
            if (pInfo == null) {
                return isSyncable;
            }
            if (pInfo.restrictedAccountType == null || !pInfo.restrictedAccountType.equals(account.type)) {
                return MAX_SIMULTANEOUS_REGULAR_SYNCS;
            }
            return isSyncable;
        } catch (RemoteException e) {
            return isSyncable;
        }
    }

    private void ensureAlarmService() {
        if (this.mAlarmService == null) {
            this.mAlarmService = (AlarmManager) this.mContext.getSystemService("alarm");
        }
    }

    public void scheduleSync(ComponentName cname, int userId, int uid, Bundle extras, long beforeRunTimeMillis, long runtimeMillis) {
        boolean isLoggable = Log.isLoggable(TAG, 2);
        if (isLoggable) {
            Log.d(TAG, "one off sync for: " + cname + " " + extras.toString());
        }
        if (Boolean.valueOf(extras.getBoolean("expedited", false)).booleanValue()) {
            runtimeMillis = -1;
        }
        boolean ignoreSettings = extras.getBoolean("ignore_settings", false);
        boolean isEnabled = this.mSyncStorageEngine.getIsTargetServiceActive(cname, userId);
        boolean syncAllowed = ignoreSettings || this.mSyncStorageEngine.getMasterSyncAutomatically(userId);
        if (syncAllowed) {
            if (isEnabled) {
                EndPoint endPoint = new EndPoint(cname, userId);
                Pair<Long, Long> backoff = this.mSyncStorageEngine.getBackoff(endPoint);
                long delayUntil = this.mSyncStorageEngine.getDelayUntilTime(endPoint);
                long backoffTime = backoff != null ? ((Long) backoff.first).longValue() : SYNC_NOTIFICATION_DELAY;
                if (isLoggable) {
                    Log.v(TAG, "schedule Sync:, delay until " + delayUntil + ", run by " + runtimeMillis + ", flex " + beforeRunTimeMillis + ", source " + 5 + ", sync service " + cname + ", extras " + extras);
                }
                scheduleSyncOperation(new SyncOperation(cname, userId, uid, 5, extras, runtimeMillis, beforeRunTimeMillis, backoffTime, delayUntil));
            } else if (isLoggable) {
                Log.d(TAG, "scheduleSync: " + cname + " is not enabled, dropping request");
            }
        } else if (isLoggable) {
            Log.d(TAG, "scheduleSync: sync of " + cname + " not allowed, dropping request.");
        }
    }

    public void scheduleSync(Account requestedAccount, int userId, int reason, String requestedAuthority, Bundle extras, long beforeRuntimeMillis, long runtimeMillis, boolean onlyThoseWithUnkownSyncableState) {
        AccountAndUser[] accounts;
        int source;
        boolean isLoggable = Log.isLoggable(TAG, 2);
        if (extras == null) {
            extras = new Bundle();
        }
        if (isLoggable) {
            Log.d(TAG, "one-time sync for: " + requestedAccount + " " + extras.toString() + " " + requestedAuthority);
        }
        if (Boolean.valueOf(extras.getBoolean("expedited", false)).booleanValue()) {
            runtimeMillis = -1;
        }
        if (requestedAccount == null || userId == -1) {
            accounts = this.mRunningAccounts;
            if (accounts.length == 0) {
                if (isLoggable) {
                    Log.v(TAG, "scheduleSync: no accounts configured, dropping");
                    return;
                }
                return;
            }
        }
        accounts = new AccountAndUser[]{new AccountAndUser(requestedAccount, userId)};
        boolean uploadOnly = extras.getBoolean("upload", false);
        boolean manualSync = extras.getBoolean("force", false);
        if (manualSync) {
            extras.putBoolean("ignore_backoff", true);
            extras.putBoolean("ignore_settings", true);
        }
        boolean ignoreSettings = extras.getBoolean("ignore_settings", false);
        if (uploadOnly) {
            source = 1;
        } else if (manualSync) {
            source = 3;
        } else if (requestedAuthority == null) {
            source = 2;
        } else {
            source = MAX_SIMULTANEOUS_REGULAR_SYNCS;
        }
        AccountAndUser[] arr$ = accounts;
        int len$ = arr$.length;
        for (int i = MAX_SIMULTANEOUS_REGULAR_SYNCS; i < len$; i++) {
            AccountAndUser account = arr$[i];
            HashSet<String> syncableAuthorities = new HashSet();
            for (ServiceInfo<SyncAdapterType> serviceInfo : this.mSyncAdapters.getAllServices(account.userId)) {
                syncableAuthorities.add(((SyncAdapterType) serviceInfo.type).authority);
            }
            if (requestedAuthority != null) {
                boolean hasSyncAdapter = syncableAuthorities.contains(requestedAuthority);
                syncableAuthorities.clear();
                if (hasSyncAdapter) {
                    syncableAuthorities.add(requestedAuthority);
                }
            }
            Iterator i$ = syncableAuthorities.iterator();
            while (i$.hasNext()) {
                String authority = (String) i$.next();
                int isSyncable = getIsSyncable(account.account, account.userId, authority);
                if (isSyncable != 0) {
                    ServiceInfo<SyncAdapterType> syncAdapterInfo = this.mSyncAdapters.getServiceInfo(SyncAdapterType.newKey(authority, account.account.type), account.userId);
                    if (syncAdapterInfo != null) {
                        boolean allowParallelSyncs = ((SyncAdapterType) syncAdapterInfo.type).allowParallelSyncs();
                        boolean isAlwaysSyncable = ((SyncAdapterType) syncAdapterInfo.type).isAlwaysSyncable();
                        if (isSyncable < 0 && isAlwaysSyncable) {
                            this.mSyncStorageEngine.setIsSyncable(account.account, account.userId, authority, 1);
                            isSyncable = 1;
                        }
                        if ((!onlyThoseWithUnkownSyncableState || isSyncable < 0) && (((SyncAdapterType) syncAdapterInfo.type).supportsUploading() || !uploadOnly)) {
                            boolean syncAllowed = isSyncable < 0 || ignoreSettings || (this.mSyncStorageEngine.getMasterSyncAutomatically(account.userId) && this.mSyncStorageEngine.getSyncAutomatically(account.account, account.userId, authority));
                            if (syncAllowed) {
                                EndPoint endPoint = new EndPoint(account.account, authority, account.userId);
                                Pair<Long, Long> backoff = this.mSyncStorageEngine.getBackoff(endPoint);
                                long delayUntil = this.mSyncStorageEngine.getDelayUntilTime(endPoint);
                                long backoffTime = backoff != null ? ((Long) backoff.first).longValue() : SYNC_NOTIFICATION_DELAY;
                                if (isSyncable < 0) {
                                    Bundle newExtras = new Bundle();
                                    newExtras.putBoolean("initialize", true);
                                    if (isLoggable) {
                                        Log.v(TAG, "schedule initialisation Sync:, delay until " + delayUntil + ", run by " + MAX_SIMULTANEOUS_REGULAR_SYNCS + ", flex " + MAX_SIMULTANEOUS_REGULAR_SYNCS + ", source " + source + ", account " + account + ", authority " + authority + ", extras " + newExtras);
                                    }
                                    scheduleSyncOperation(new SyncOperation(account.account, account.userId, reason, source, authority, newExtras, SYNC_NOTIFICATION_DELAY, SYNC_NOTIFICATION_DELAY, backoffTime, delayUntil, allowParallelSyncs));
                                }
                                if (!onlyThoseWithUnkownSyncableState) {
                                    if (isLoggable) {
                                        Log.v(TAG, "scheduleSync: delay until " + delayUntil + " run by " + runtimeMillis + " flex " + beforeRuntimeMillis + ", source " + source + ", account " + account + ", authority " + authority + ", extras " + extras);
                                    }
                                    scheduleSyncOperation(new SyncOperation(account.account, account.userId, reason, source, authority, extras, runtimeMillis, beforeRuntimeMillis, backoffTime, delayUntil, allowParallelSyncs));
                                }
                            } else if (isLoggable) {
                                Log.d(TAG, "scheduleSync: sync of " + account + ", " + authority + " is not allowed, dropping request");
                            }
                        }
                    }
                }
            }
        }
    }

    public void scheduleLocalSync(Account account, int userId, int reason, String authority) {
        Bundle extras = new Bundle();
        extras.putBoolean("upload", true);
        scheduleSync(account, userId, reason, authority, extras, LOCAL_SYNC_DELAY, 2 * LOCAL_SYNC_DELAY, false);
    }

    public SyncAdapterType[] getSyncAdapterTypes(int userId) {
        Collection<ServiceInfo<SyncAdapterType>> serviceInfos = this.mSyncAdapters.getAllServices(userId);
        SyncAdapterType[] types = new SyncAdapterType[serviceInfos.size()];
        int i = MAX_SIMULTANEOUS_REGULAR_SYNCS;
        for (ServiceInfo<SyncAdapterType> serviceInfo : serviceInfos) {
            types[i] = (SyncAdapterType) serviceInfo.type;
            i++;
        }
        return types;
    }

    private void sendSyncAlarmMessage() {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "sending MESSAGE_SYNC_ALARM");
        }
        this.mSyncHandler.sendEmptyMessage(2);
    }

    private void sendCheckAlarmsMessage() {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "sending MESSAGE_CHECK_ALARMS");
        }
        this.mSyncHandler.removeMessages(3);
        this.mSyncHandler.sendEmptyMessage(3);
    }

    private void sendSyncFinishedOrCanceledMessage(ActiveSyncContext syncContext, SyncResult syncResult) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "sending MESSAGE_SYNC_FINISHED");
        }
        Message msg = this.mSyncHandler.obtainMessage();
        msg.what = 1;
        msg.obj = new SyncHandlerMessagePayload(syncContext, syncResult);
        this.mSyncHandler.sendMessage(msg);
    }

    private void sendCancelSyncsMessage(EndPoint info, Bundle extras) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "sending MESSAGE_CANCEL");
        }
        Message msg = this.mSyncHandler.obtainMessage();
        msg.what = 6;
        msg.setData(extras);
        msg.obj = info;
        this.mSyncHandler.sendMessage(msg);
    }

    private void postSyncExpiryMessage(ActiveSyncContext activeSyncContext) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "posting MESSAGE_SYNC_EXPIRED in 1800s");
        }
        Message msg = this.mSyncHandler.obtainMessage();
        msg.what = 7;
        msg.obj = activeSyncContext;
        this.mSyncHandler.sendMessageDelayed(msg, ACTIVE_SYNC_TIMEOUT_MILLIS);
    }

    private void removeSyncExpiryMessage(ActiveSyncContext activeSyncContext) {
        if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "removing all MESSAGE_SYNC_EXPIRED for " + activeSyncContext.toString());
        }
        this.mSyncHandler.removeMessages(7, activeSyncContext);
    }

    private void clearBackoffSetting(SyncOperation op) {
        this.mSyncStorageEngine.setBackoff(op.target, -1, -1);
        synchronized (this.mSyncQueue) {
            this.mSyncQueue.onBackoffChanged(op.target, SYNC_NOTIFICATION_DELAY);
        }
    }

    private void increaseBackoffSetting(SyncOperation op) {
        long now = SystemClock.elapsedRealtime();
        Pair<Long, Long> previousSettings = this.mSyncStorageEngine.getBackoff(op.target);
        long newDelayInMs = -1;
        if (previousSettings != null) {
            if (now >= ((Long) previousSettings.first).longValue()) {
                newDelayInMs = ((Long) previousSettings.second).longValue() * 2;
            } else if (Log.isLoggable(TAG, 2)) {
                Log.v(TAG, "Still in backoff, do not increase it. Remaining: " + ((((Long) previousSettings.first).longValue() - now) / 1000) + " seconds.");
                return;
            } else {
                return;
            }
        }
        if (newDelayInMs <= SYNC_NOTIFICATION_DELAY) {
            newDelayInMs = jitterize(SYNC_ALARM_TIMEOUT_MIN, 33000);
        }
        long maxSyncRetryTimeInSeconds = Global.getLong(this.mContext.getContentResolver(), "sync_max_retry_delay_in_seconds", DEFAULT_MAX_SYNC_RETRY_TIME_IN_SECONDS);
        if (newDelayInMs > 1000 * maxSyncRetryTimeInSeconds) {
            newDelayInMs = maxSyncRetryTimeInSeconds * 1000;
        }
        long backoff = now + newDelayInMs;
        this.mSyncStorageEngine.setBackoff(op.target, backoff, newDelayInMs);
        op.backoff = backoff;
        op.updateEffectiveRunTime();
        synchronized (this.mSyncQueue) {
            this.mSyncQueue.onBackoffChanged(op.target, backoff);
        }
    }

    private void setDelayUntilTime(SyncOperation op, long delayUntilSeconds) {
        long newDelayUntilTime;
        long delayUntil = delayUntilSeconds * 1000;
        long absoluteNow = System.currentTimeMillis();
        if (delayUntil > absoluteNow) {
            newDelayUntilTime = SystemClock.elapsedRealtime() + (delayUntil - absoluteNow);
        } else {
            newDelayUntilTime = SYNC_NOTIFICATION_DELAY;
        }
        this.mSyncStorageEngine.setDelayUntilTime(op.target, newDelayUntilTime);
        synchronized (this.mSyncQueue) {
            this.mSyncQueue.onDelayUntilTimeChanged(op.target, newDelayUntilTime);
        }
    }

    public void cancelActiveSync(EndPoint info, Bundle extras) {
        sendCancelSyncsMessage(info, extras);
    }

    public void scheduleSyncOperation(SyncOperation syncOperation) {
        synchronized (this.mSyncQueue) {
            boolean queueChanged = this.mSyncQueue.add(syncOperation);
        }
        if (queueChanged) {
            if (Log.isLoggable(TAG, 2)) {
                Log.v(TAG, "scheduleSyncOperation: enqueued " + syncOperation);
            }
            sendCheckAlarmsMessage();
        } else if (Log.isLoggable(TAG, 2)) {
            Log.v(TAG, "scheduleSyncOperation: dropping duplicate sync operation " + syncOperation);
        }
    }

    public void clearScheduledSyncOperations(EndPoint info) {
        synchronized (this.mSyncQueue) {
            this.mSyncQueue.remove(info, null);
        }
        this.mSyncStorageEngine.setBackoff(info, -1, -1);
    }

    public void cancelScheduledSyncOperation(EndPoint info, Bundle extras) {
        synchronized (this.mSyncQueue) {
            this.mSyncQueue.remove(info, extras);
        }
        if (!this.mSyncStorageEngine.isSyncPending(info)) {
            this.mSyncStorageEngine.setBackoff(info, -1, -1);
        }
    }

    void maybeRescheduleSync(SyncResult syncResult, SyncOperation operation) {
        boolean isLoggable = Log.isLoggable(TAG, 3);
        if (isLoggable) {
            Log.d(TAG, "encountered error(s) during the sync: " + syncResult + ", " + operation);
        }
        SyncOperation operation2 = new SyncOperation(operation, SYNC_NOTIFICATION_DELAY);
        if (operation2.extras.getBoolean("ignore_backoff", false)) {
            operation2.extras.remove("ignore_backoff");
        }
        if (operation2.extras.getBoolean("do_not_retry", false)) {
            if (isLoggable) {
                Log.d(TAG, "not retrying sync operation because SYNC_EXTRAS_DO_NOT_RETRY was specified " + operation2);
            }
        } else if (operation2.extras.getBoolean("upload", false) && !syncResult.syncAlreadyInProgress) {
            operation2.extras.remove("upload");
            if (isLoggable) {
                Log.d(TAG, "retrying sync operation as a two-way sync because an upload-only sync encountered an error: " + operation2);
            }
            scheduleSyncOperation(operation2);
        } else if (syncResult.tooManyRetries) {
            if (isLoggable) {
                Log.d(TAG, "not retrying sync operation because it retried too many times: " + operation2);
            }
        } else if (syncResult.madeSomeProgress()) {
            if (isLoggable) {
                Log.d(TAG, "retrying sync operation because even though it had an error it achieved some success");
            }
            scheduleSyncOperation(operation2);
        } else if (syncResult.syncAlreadyInProgress) {
            if (isLoggable) {
                Log.d(TAG, "retrying sync operation that failed because there was already a sync in progress: " + operation2);
            }
            scheduleSyncOperation(new SyncOperation(operation2, 10000));
        } else if (syncResult.hasSoftError()) {
            if (isLoggable) {
                Log.d(TAG, "retrying sync operation because it encountered a soft error: " + operation2);
            }
            scheduleSyncOperation(operation2);
        } else {
            Log.d(TAG, "not retrying sync operation because the error is a hard error: " + operation2);
        }
    }

    private void onUserStarting(int userId) {
        AccountManagerService.getSingleton().validateAccounts(userId);
        this.mSyncAdapters.invalidateCache(userId);
        updateRunningAccounts();
        synchronized (this.mSyncQueue) {
            this.mSyncQueue.addPendingOperations(userId);
        }
        Account[] arr$ = AccountManagerService.getSingleton().getAccounts(userId);
        int len$ = arr$.length;
        for (int i$ = MAX_SIMULTANEOUS_REGULAR_SYNCS; i$ < len$; i$++) {
            scheduleSync(arr$[i$], userId, -8, null, null, SYNC_NOTIFICATION_DELAY, SYNC_NOTIFICATION_DELAY, true);
        }
        sendCheckAlarmsMessage();
    }

    private void onUserStopping(int userId) {
        updateRunningAccounts();
        cancelActiveSync(new EndPoint(null, null, userId), null);
    }

    private void onUserRemoved(int userId) {
        updateRunningAccounts();
        this.mSyncStorageEngine.doDatabaseCleanup(new Account[MAX_SIMULTANEOUS_REGULAR_SYNCS], userId);
        synchronized (this.mSyncQueue) {
            this.mSyncQueue.removeUserLocked(userId);
        }
    }

    protected void dump(FileDescriptor fd, PrintWriter pw) {
        IndentingPrintWriter ipw = new IndentingPrintWriter(pw, "  ");
        dumpSyncState(ipw);
        dumpSyncHistory(ipw);
        dumpSyncAdapters(ipw);
    }

    static String formatTime(long time) {
        Time tobj = new Time();
        tobj.set(time);
        return tobj.format("%Y-%m-%d %H:%M:%S");
    }

    protected void dumpSyncState(PrintWriter pw) {
        pw.print("data connected: ");
        pw.println(this.mDataConnectionIsConnected);
        pw.print("auto sync: ");
        List<UserInfo> users = getAllUsers();
        if (users != null) {
            for (UserInfo user : users) {
                pw.print("u" + user.id + "=" + this.mSyncStorageEngine.getMasterSyncAutomatically(user.id) + " ");
            }
            pw.println();
        }
        pw.print("memory low: ");
        pw.println(this.mStorageIsLow);
        AccountAndUser[] accounts = AccountManagerService.getSingleton().getAllAccounts();
        pw.print("accounts: ");
        if (accounts != INITIAL_ACCOUNTS_ARRAY) {
            pw.println(accounts.length);
        } else {
            pw.println("not known yet");
        }
        long now = SystemClock.elapsedRealtime();
        pw.print("now: ");
        pw.print(now);
        pw.println(" (" + formatTime(System.currentTimeMillis()) + ")");
        pw.print("offset: ");
        pw.print(DateUtils.formatElapsedTime((long) (this.mSyncRandomOffsetMillis / ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE)));
        pw.println(" (HH:MM:SS)");
        pw.print("uptime: ");
        pw.print(DateUtils.formatElapsedTime(now / 1000));
        pw.println(" (HH:MM:SS)");
        pw.print("time spent syncing: ");
        pw.print(DateUtils.formatElapsedTime(this.mSyncHandler.mSyncTimeTracker.timeSpentSyncing() / 1000));
        pw.print(" (HH:MM:SS), sync ");
        pw.print(this.mSyncHandler.mSyncTimeTracker.mLastWasSyncing ? "" : "not ");
        pw.println("in progress");
        if (this.mSyncHandler.mAlarmScheduleTime != null) {
            pw.print("next alarm time: ");
            pw.print(this.mSyncHandler.mAlarmScheduleTime);
            pw.print(" (");
            pw.print(DateUtils.formatElapsedTime((this.mSyncHandler.mAlarmScheduleTime.longValue() - now) / 1000));
            pw.println(" (HH:MM:SS) from now)");
        } else {
            pw.println("no alarm is scheduled (there had better not be any pending syncs)");
        }
        pw.print("notification info: ");
        StringBuilder sb = new StringBuilder();
        this.mSyncHandler.mSyncNotificationInfo.toString(sb);
        pw.println(sb.toString());
        pw.println();
        pw.println("Active Syncs: " + this.mActiveSyncContexts.size());
        PackageManager pm = this.mContext.getPackageManager();
        Iterator i$ = this.mActiveSyncContexts.iterator();
        while (i$.hasNext()) {
            ActiveSyncContext activeSyncContext = (ActiveSyncContext) i$.next();
            long durationInSeconds = (now - activeSyncContext.mStartTime) / 1000;
            pw.print("  ");
            pw.print(DateUtils.formatElapsedTime(durationInSeconds));
            pw.print(" - ");
            pw.print(activeSyncContext.mSyncOperation.dump(pm, false));
            pw.println();
        }
        synchronized (this.mSyncQueue) {
            sb.setLength(MAX_SIMULTANEOUS_REGULAR_SYNCS);
            this.mSyncQueue.dump(sb);
            getSyncStorageEngine().dumpPendingOperations(sb);
        }
        pw.println();
        pw.print(sb.toString());
        pw.println();
        pw.println("Sync Status");
        AccountAndUser[] arr$ = accounts;
        int len$ = arr$.length;
        for (int i = MAX_SIMULTANEOUS_REGULAR_SYNCS; i < len$; i++) {
            AccountAndUser account = arr$[i];
            r35 = new Object[3];
            r35[MAX_SIMULTANEOUS_REGULAR_SYNCS] = account.account.name;
            r35[1] = Integer.valueOf(account.userId);
            r35[2] = account.account.type;
            pw.printf("Account %s u%d %s\n", r35);
            pw.println("=======================================================================");
            PrintTable printTable = new PrintTable(13);
            printTable.set(MAX_SIMULTANEOUS_REGULAR_SYNCS, MAX_SIMULTANEOUS_REGULAR_SYNCS, "Authority", "Syncable", "Enabled", "Delay", "Loc", "Poll", "Per", "Serv", "User", "Tot", "Time", "Last Sync", "Periodic");
            List<ServiceInfo<SyncAdapterType>> sorted = Lists.newArrayList();
            sorted.addAll(this.mSyncAdapters.getAllServices(account.userId));
            Collections.sort(sorted, new Comparator<ServiceInfo<SyncAdapterType>>() {
                public int compare(ServiceInfo<SyncAdapterType> lhs, ServiceInfo<SyncAdapterType> rhs) {
                    return ((SyncAdapterType) lhs.type).authority.compareTo(((SyncAdapterType) rhs.type).authority);
                }
            });
            for (ServiceInfo<SyncAdapterType> syncAdapterType : sorted) {
                if (((SyncAdapterType) syncAdapterType.type).accountType.equals(account.account.type)) {
                    Object[] objArr;
                    int row1;
                    int row = printTable.getNumRows();
                    Pair<AuthorityInfo, SyncStatusInfo> syncAuthoritySyncStatus = this.mSyncStorageEngine.getCopyOfAuthorityWithSyncStatus(new EndPoint(account.account, ((SyncAdapterType) syncAdapterType.type).authority, account.userId));
                    AuthorityInfo settings = syncAuthoritySyncStatus.first;
                    SyncStatusInfo status = syncAuthoritySyncStatus.second;
                    String authority = settings.target.provider;
                    if (authority.length() > 50) {
                        authority = authority.substring(authority.length() - 50);
                    }
                    r35 = new Object[3];
                    r35[1] = Integer.valueOf(settings.syncable);
                    r35[2] = Boolean.valueOf(settings.enabled);
                    printTable.set(row, MAX_SIMULTANEOUS_REGULAR_SYNCS, r35);
                    r35 = new Object[7];
                    r35[MAX_SIMULTANEOUS_REGULAR_SYNCS] = Integer.valueOf(status.numSourceLocal);
                    r35[1] = Integer.valueOf(status.numSourcePoll);
                    r35[2] = Integer.valueOf(status.numSourcePeriodic);
                    r35[3] = Integer.valueOf(status.numSourceServer);
                    r35[4] = Integer.valueOf(status.numSourceUser);
                    r35[5] = Integer.valueOf(status.numSyncs);
                    r35[6] = DateUtils.formatElapsedTime(status.totalElapsedTime / 1000);
                    printTable.set(row, 4, r35);
                    int i2 = MAX_SIMULTANEOUS_REGULAR_SYNCS;
                    while (true) {
                        if (i2 >= settings.periodicSyncs.size()) {
                            break;
                        }
                        PeriodicSync sync = (PeriodicSync) settings.periodicSyncs.get(i2);
                        objArr = new Object[2];
                        objArr[MAX_SIMULTANEOUS_REGULAR_SYNCS] = Long.valueOf(sync.period);
                        objArr[1] = Long.valueOf(sync.flexTime);
                        String period = String.format("[p:%d s, f: %d s]", objArr);
                        String extras = sync.extras.size() > 0 ? sync.extras.toString() : "Bundle[]";
                        String next = "Next sync: " + formatTime(status.getPeriodicSyncTime(i2) + (sync.period * 1000));
                        int i3 = (i2 * 2) + row;
                        String[] strArr = new Object[1];
                        strArr[MAX_SIMULTANEOUS_REGULAR_SYNCS] = period + " " + extras;
                        printTable.set(i3, 12, strArr);
                        printTable.set(((i2 * 2) + row) + 1, 12, next);
                        i2++;
                    }
                    int i4 = row;
                    if (settings.delayUntil > now) {
                        row1 = i4 + 1;
                        r35 = new Object[1];
                        r35[MAX_SIMULTANEOUS_REGULAR_SYNCS] = "D: " + ((settings.delayUntil - now) / 1000);
                        printTable.set(i4, 12, r35);
                        if (settings.backoffTime > now) {
                            i4 = row1 + 1;
                            r35 = new Object[1];
                            r35[MAX_SIMULTANEOUS_REGULAR_SYNCS] = "B: " + ((settings.backoffTime - now) / 1000);
                            printTable.set(row1, 12, r35);
                            row1 = i4 + 1;
                            Long[] lArr = new Object[1];
                            lArr[MAX_SIMULTANEOUS_REGULAR_SYNCS] = Long.valueOf(settings.backoffDelay / 1000);
                            printTable.set(i4, 12, lArr);
                        }
                        i4 = row1;
                    }
                    if (status.lastSuccessTime != SYNC_NOTIFICATION_DELAY) {
                        row1 = i4 + 1;
                        r35 = new Object[1];
                        r35[MAX_SIMULTANEOUS_REGULAR_SYNCS] = SyncStorageEngine.SOURCES[status.lastSuccessSource] + " " + "SUCCESS";
                        printTable.set(i4, 11, r35);
                        i4 = row1 + 1;
                        r35 = new Object[1];
                        r35[MAX_SIMULTANEOUS_REGULAR_SYNCS] = formatTime(status.lastSuccessTime);
                        printTable.set(row1, 11, r35);
                    }
                    if (status.lastFailureTime != SYNC_NOTIFICATION_DELAY) {
                        row1 = i4 + 1;
                        r35 = new Object[1];
                        r35[MAX_SIMULTANEOUS_REGULAR_SYNCS] = SyncStorageEngine.SOURCES[status.lastFailureSource] + " " + "FAILURE";
                        printTable.set(i4, 11, r35);
                        i4 = row1 + 1;
                        r35 = new Object[1];
                        r35[MAX_SIMULTANEOUS_REGULAR_SYNCS] = formatTime(status.lastFailureTime);
                        printTable.set(row1, 11, r35);
                        row1 = i4 + 1;
                        objArr = new Object[1];
                        objArr[MAX_SIMULTANEOUS_REGULAR_SYNCS] = status.lastFailureMesg;
                        printTable.set(i4, 11, objArr);
                        i4 = row1;
                    }
                }
            }
            printTable.writeTo(pw);
        }
    }

    private String getLastFailureMessage(int code) {
        switch (code) {
            case MyHandler.MESSAGE_COMPUTE_CHANGED_WINDOWS /*1*/:
                return "sync already in progress";
            case C0569H.REPORT_FOCUS_CHANGE /*2*/:
                return "authentication error";
            case C0569H.REPORT_LOSING_FOCUS /*3*/:
                return "I/O error";
            case C0569H.DO_TRAVERSAL /*4*/:
                return "parse error";
            case C0569H.ADD_STARTING /*5*/:
                return "conflict error";
            case C0569H.REMOVE_STARTING /*6*/:
                return "too many deletions error";
            case C0569H.FINISHED_STARTING /*7*/:
                return "too many retries error";
            case C0569H.REPORT_APPLICATION_TOKEN_WINDOWS /*8*/:
                return "internal error";
            default:
                return "unknown";
        }
    }

    private void dumpTimeSec(PrintWriter pw, long time) {
        pw.print(time / 1000);
        pw.print('.');
        pw.print((time / 100) % 10);
        pw.print('s');
    }

    private void dumpDayStatistic(PrintWriter pw, DayStats ds) {
        pw.print("Success (");
        pw.print(ds.successCount);
        if (ds.successCount > 0) {
            pw.print(" for ");
            dumpTimeSec(pw, ds.successTime);
            pw.print(" avg=");
            dumpTimeSec(pw, ds.successTime / ((long) ds.successCount));
        }
        pw.print(") Failure (");
        pw.print(ds.failureCount);
        if (ds.failureCount > 0) {
            pw.print(" for ");
            dumpTimeSec(pw, ds.failureTime);
            pw.print(" avg=");
            dumpTimeSec(pw, ds.failureTime / ((long) ds.failureCount));
        }
        pw.println(")");
    }

    protected void dumpSyncHistory(PrintWriter pw) {
        dumpRecentHistory(pw);
        dumpDayStatistics(pw);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void dumpRecentHistory(java.io.PrintWriter r59) {
        /*
        r58 = this;
        r0 = r58;
        r0 = r0.mSyncStorageEngine;
        r49 = r0;
        r28 = r49.getSyncHistory();
        if (r28 == 0) goto L_0x087f;
    L_0x000c:
        r49 = r28.size();
        if (r49 <= 0) goto L_0x087f;
    L_0x0012:
        r11 = com.google.android.collect.Maps.newHashMap();
        r50 = 0;
        r52 = 0;
        r4 = r28.size();
        r34 = 0;
        r33 = 0;
        r25 = r28.iterator();
    L_0x0026:
        r49 = r25.hasNext();
        if (r49 == 0) goto L_0x01aa;
    L_0x002c:
        r27 = r25.next();
        r27 = (com.android.server.content.SyncStorageEngine.SyncHistoryItem) r27;
        r0 = r58;
        r0 = r0.mSyncStorageEngine;
        r49 = r0;
        r0 = r27;
        r0 = r0.authorityId;
        r54 = r0;
        r0 = r49;
        r1 = r54;
        r10 = r0.getAuthority(r1);
        if (r10 == 0) goto L_0x01a4;
    L_0x0048:
        r0 = r10.target;
        r49 = r0;
        r0 = r49;
        r0 = r0.target_provider;
        r49 = r0;
        if (r49 == 0) goto L_0x0133;
    L_0x0054:
        r0 = r10.target;
        r49 = r0;
        r0 = r49;
        r12 = r0.provider;
        r49 = new java.lang.StringBuilder;
        r49.<init>();
        r0 = r10.target;
        r54 = r0;
        r0 = r54;
        r0 = r0.account;
        r54 = r0;
        r0 = r54;
        r0 = r0.name;
        r54 = r0;
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r54 = "/";
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r0 = r10.target;
        r54 = r0;
        r0 = r54;
        r0 = r0.account;
        r54 = r0;
        r0 = r54;
        r0 = r0.type;
        r54 = r0;
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r54 = " u";
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r0 = r10.target;
        r54 = r0;
        r0 = r54;
        r0 = r0.userId;
        r54 = r0;
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r6 = r49.toString();
    L_0x00bb:
        r32 = r12.length();
        r0 = r32;
        r1 = r34;
        if (r0 <= r1) goto L_0x00c7;
    L_0x00c5:
        r34 = r32;
    L_0x00c7:
        r32 = r6.length();
        r0 = r32;
        r1 = r33;
        if (r0 <= r1) goto L_0x00d3;
    L_0x00d1:
        r33 = r32;
    L_0x00d3:
        r0 = r27;
        r0 = r0.elapsedTime;
        r18 = r0;
        r50 = r50 + r18;
        r54 = 1;
        r52 = r52 + r54;
        r13 = r11.get(r12);
        r13 = (com.android.server.content.SyncManager.AuthoritySyncStats) r13;
        if (r13 != 0) goto L_0x00f3;
    L_0x00e7:
        r13 = new com.android.server.content.SyncManager$AuthoritySyncStats;
        r49 = 0;
        r0 = r49;
        r13.<init>(r0);
        r11.put(r12, r13);
    L_0x00f3:
        r0 = r13.elapsedTime;
        r54 = r0;
        r54 = r54 + r18;
        r0 = r54;
        r13.elapsedTime = r0;
        r0 = r13.times;
        r49 = r0;
        r49 = r49 + 1;
        r0 = r49;
        r13.times = r0;
        r7 = r13.accountMap;
        r8 = r7.get(r6);
        r8 = (com.android.server.content.SyncManager.AccountSyncStats) r8;
        if (r8 != 0) goto L_0x011d;
    L_0x0111:
        r8 = new com.android.server.content.SyncManager$AccountSyncStats;
        r49 = 0;
        r0 = r49;
        r8.<init>(r0);
        r7.put(r6, r8);
    L_0x011d:
        r0 = r8.elapsedTime;
        r54 = r0;
        r54 = r54 + r18;
        r0 = r54;
        r8.elapsedTime = r0;
        r0 = r8.times;
        r49 = r0;
        r49 = r49 + 1;
        r0 = r49;
        r8.times = r0;
        goto L_0x0026;
    L_0x0133:
        r0 = r10.target;
        r49 = r0;
        r0 = r49;
        r0 = r0.target_service;
        r49 = r0;
        if (r49 == 0) goto L_0x019e;
    L_0x013f:
        r49 = new java.lang.StringBuilder;
        r49.<init>();
        r0 = r10.target;
        r54 = r0;
        r0 = r54;
        r0 = r0.service;
        r54 = r0;
        r54 = r54.getPackageName();
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r54 = "/";
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r0 = r10.target;
        r54 = r0;
        r0 = r54;
        r0 = r0.service;
        r54 = r0;
        r54 = r54.getClassName();
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r54 = " u";
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r0 = r10.target;
        r54 = r0;
        r0 = r54;
        r0 = r0.userId;
        r54 = r0;
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r12 = r49.toString();
        r6 = "no account";
        goto L_0x00bb;
    L_0x019e:
        r12 = "Unknown";
        r6 = "Unknown";
        goto L_0x00bb;
    L_0x01a4:
        r12 = "Unknown";
        r6 = "Unknown";
        goto L_0x00bb;
    L_0x01aa:
        r54 = 0;
        r49 = (r50 > r54 ? 1 : (r50 == r54 ? 0 : -1));
        if (r49 <= 0) goto L_0x03a6;
    L_0x01b0:
        r59.println();
        r49 = "Detailed Statistics (Recent history):  %d (# of times) %ds (sync time)\n";
        r54 = 2;
        r0 = r54;
        r0 = new java.lang.Object[r0];
        r54 = r0;
        r55 = 0;
        r56 = java.lang.Long.valueOf(r52);
        r54[r55] = r56;
        r55 = 1;
        r56 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;
        r56 = r50 / r56;
        r56 = java.lang.Long.valueOf(r56);
        r54[r55] = r56;
        r0 = r59;
        r1 = r49;
        r2 = r54;
        r0.printf(r1, r2);
        r43 = new java.util.ArrayList;
        r49 = r11.values();
        r0 = r43;
        r1 = r49;
        r0.<init>(r1);
        r49 = new com.android.server.content.SyncManager$11;
        r0 = r49;
        r1 = r58;
        r0.<init>();
        r0 = r43;
        r1 = r49;
        java.util.Collections.sort(r0, r1);
        r49 = r33 + 3;
        r0 = r34;
        r1 = r49;
        r35 = java.lang.Math.max(r0, r1);
        r49 = r35 + 4;
        r49 = r49 + 2;
        r49 = r49 + 10;
        r37 = r49 + 11;
        r0 = r37;
        r14 = new char[r0];
        r49 = 45;
        r0 = r49;
        java.util.Arrays.fill(r14, r0);
        r39 = new java.lang.String;
        r0 = r39;
        r0.<init>(r14);
        r49 = "  %%-%ds: %%-9s  %%-11s\n";
        r54 = 1;
        r0 = r54;
        r0 = new java.lang.Object[r0];
        r54 = r0;
        r55 = 0;
        r56 = r35 + 2;
        r56 = java.lang.Integer.valueOf(r56);
        r54[r55] = r56;
        r0 = r49;
        r1 = r54;
        r9 = java.lang.String.format(r0, r1);
        r49 = "    %%-%ds:   %%-9s  %%-11s\n";
        r54 = 1;
        r0 = r54;
        r0 = new java.lang.Object[r0];
        r54 = r0;
        r55 = 0;
        r56 = java.lang.Integer.valueOf(r35);
        r54[r55] = r56;
        r0 = r49;
        r1 = r54;
        r5 = java.lang.String.format(r0, r1);
        r0 = r59;
        r1 = r39;
        r0.println(r1);
        r25 = r43.iterator();
    L_0x025c:
        r49 = r25.hasNext();
        if (r49 == 0) goto L_0x03a6;
    L_0x0262:
        r13 = r25.next();
        r13 = (com.android.server.content.SyncManager.AuthoritySyncStats) r13;
        r0 = r13.name;
        r36 = r0;
        r0 = r13.elapsedTime;
        r18 = r0;
        r0 = r13.times;
        r47 = r0;
        r49 = "%ds/%d%%";
        r54 = 2;
        r0 = r54;
        r0 = new java.lang.Object[r0];
        r54 = r0;
        r55 = 0;
        r56 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;
        r56 = r18 / r56;
        r56 = java.lang.Long.valueOf(r56);
        r54[r55] = r56;
        r55 = 1;
        r56 = 100;
        r56 = r56 * r18;
        r56 = r56 / r50;
        r56 = java.lang.Long.valueOf(r56);
        r54[r55] = r56;
        r0 = r49;
        r1 = r54;
        r46 = java.lang.String.format(r0, r1);
        r49 = "%d/%d%%";
        r54 = 2;
        r0 = r54;
        r0 = new java.lang.Object[r0];
        r54 = r0;
        r55 = 0;
        r56 = java.lang.Integer.valueOf(r47);
        r54[r55] = r56;
        r55 = 1;
        r56 = r47 * 100;
        r0 = r56;
        r0 = (long) r0;
        r56 = r0;
        r56 = r56 / r52;
        r56 = java.lang.Long.valueOf(r56);
        r54[r55] = r56;
        r0 = r49;
        r1 = r54;
        r48 = java.lang.String.format(r0, r1);
        r49 = 3;
        r0 = r49;
        r0 = new java.lang.Object[r0];
        r49 = r0;
        r54 = 0;
        r49[r54] = r36;
        r54 = 1;
        r49[r54] = r48;
        r54 = 2;
        r49[r54] = r46;
        r0 = r59;
        r1 = r49;
        r0.printf(r9, r1);
        r42 = new java.util.ArrayList;
        r0 = r13.accountMap;
        r49 = r0;
        r49 = r49.values();
        r0 = r42;
        r1 = r49;
        r0.<init>(r1);
        r49 = new com.android.server.content.SyncManager$12;
        r0 = r49;
        r1 = r58;
        r0.<init>();
        r0 = r42;
        r1 = r49;
        java.util.Collections.sort(r0, r1);
        r26 = r42.iterator();
    L_0x030b:
        r49 = r26.hasNext();
        if (r49 == 0) goto L_0x039d;
    L_0x0311:
        r44 = r26.next();
        r44 = (com.android.server.content.SyncManager.AccountSyncStats) r44;
        r0 = r44;
        r0 = r0.elapsedTime;
        r18 = r0;
        r0 = r44;
        r0 = r0.times;
        r47 = r0;
        r49 = "%ds/%d%%";
        r54 = 2;
        r0 = r54;
        r0 = new java.lang.Object[r0];
        r54 = r0;
        r55 = 0;
        r56 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;
        r56 = r18 / r56;
        r56 = java.lang.Long.valueOf(r56);
        r54[r55] = r56;
        r55 = 1;
        r56 = 100;
        r56 = r56 * r18;
        r56 = r56 / r50;
        r56 = java.lang.Long.valueOf(r56);
        r54[r55] = r56;
        r0 = r49;
        r1 = r54;
        r46 = java.lang.String.format(r0, r1);
        r49 = "%d/%d%%";
        r54 = 2;
        r0 = r54;
        r0 = new java.lang.Object[r0];
        r54 = r0;
        r55 = 0;
        r56 = java.lang.Integer.valueOf(r47);
        r54[r55] = r56;
        r55 = 1;
        r56 = r47 * 100;
        r0 = r56;
        r0 = (long) r0;
        r56 = r0;
        r56 = r56 / r52;
        r56 = java.lang.Long.valueOf(r56);
        r54[r55] = r56;
        r0 = r49;
        r1 = r54;
        r48 = java.lang.String.format(r0, r1);
        r49 = 3;
        r0 = r49;
        r0 = new java.lang.Object[r0];
        r49 = r0;
        r54 = 0;
        r0 = r44;
        r0 = r0.name;
        r55 = r0;
        r49[r54] = r55;
        r54 = 1;
        r49[r54] = r48;
        r54 = 2;
        r49[r54] = r46;
        r0 = r59;
        r1 = r49;
        r0.printf(r5, r1);
        goto L_0x030b;
    L_0x039d:
        r0 = r59;
        r1 = r39;
        r0.println(r1);
        goto L_0x025c;
    L_0x03a6:
        r59.println();
        r49 = "Recent Sync History";
        r0 = r59;
        r1 = r49;
        r0.println(r1);
        r49 = new java.lang.StringBuilder;
        r49.<init>();
        r54 = "  %-";
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r0 = r49;
        r1 = r33;
        r49 = r0.append(r1);
        r54 = "s  %-";
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r0 = r49;
        r1 = r34;
        r49 = r0.append(r1);
        r54 = "s %s\n";
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r23 = r49.toString();
        r31 = com.google.android.collect.Maps.newHashMap();
        r0 = r58;
        r0 = r0.mContext;
        r49 = r0;
        r38 = r49.getPackageManager();
        r24 = 0;
    L_0x03f9:
        r0 = r24;
        if (r0 >= r4) goto L_0x06ee;
    L_0x03fd:
        r0 = r28;
        r1 = r24;
        r27 = r0.get(r1);
        r27 = (com.android.server.content.SyncStorageEngine.SyncHistoryItem) r27;
        r0 = r58;
        r0 = r0.mSyncStorageEngine;
        r49 = r0;
        r0 = r27;
        r0 = r0.authorityId;
        r54 = r0;
        r0 = r49;
        r1 = r54;
        r10 = r0.getAuthority(r1);
        if (r10 == 0) goto L_0x0664;
    L_0x041d:
        r0 = r10.target;
        r49 = r0;
        r0 = r49;
        r0 = r0.target_provider;
        r49 = r0;
        if (r49 == 0) goto L_0x05f3;
    L_0x0429:
        r0 = r10.target;
        r49 = r0;
        r0 = r49;
        r12 = r0.provider;
        r49 = new java.lang.StringBuilder;
        r49.<init>();
        r0 = r10.target;
        r54 = r0;
        r0 = r54;
        r0 = r0.account;
        r54 = r0;
        r0 = r54;
        r0 = r0.name;
        r54 = r0;
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r54 = "/";
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r0 = r10.target;
        r54 = r0;
        r0 = r54;
        r0 = r0.account;
        r54 = r0;
        r0 = r54;
        r0 = r0.type;
        r54 = r0;
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r54 = " u";
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r0 = r10.target;
        r54 = r0;
        r0 = r54;
        r0 = r0.userId;
        r54 = r0;
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r6 = r49.toString();
    L_0x0490:
        r0 = r27;
        r0 = r0.elapsedTime;
        r18 = r0;
        r45 = new android.text.format.Time;
        r45.<init>();
        r0 = r27;
        r0 = r0.eventTime;
        r20 = r0;
        r0 = r45;
        r1 = r20;
        r0.set(r1);
        r49 = new java.lang.StringBuilder;
        r49.<init>();
        r0 = r49;
        r49 = r0.append(r12);
        r54 = "/";
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r0 = r49;
        r49 = r0.append(r6);
        r29 = r49.toString();
        r0 = r31;
        r1 = r29;
        r30 = r0.get(r1);
        r30 = (java.lang.Long) r30;
        if (r30 != 0) goto L_0x066a;
    L_0x04d3:
        r15 = "";
    L_0x04d5:
        r49 = java.lang.Long.valueOf(r20);
        r0 = r31;
        r1 = r29;
        r2 = r49;
        r0.put(r1, r2);
        r49 = "  #%-3d: %s %8s  %5.1fs  %8s";
        r54 = 5;
        r0 = r54;
        r0 = new java.lang.Object[r0];
        r54 = r0;
        r55 = 0;
        r56 = r24 + 1;
        r56 = java.lang.Integer.valueOf(r56);
        r54[r55] = r56;
        r55 = 1;
        r56 = formatTime(r20);
        r54[r55] = r56;
        r55 = 2;
        r56 = com.android.server.content.SyncStorageEngine.SOURCES;
        r0 = r27;
        r0 = r0.source;
        r57 = r0;
        r56 = r56[r57];
        r54[r55] = r56;
        r55 = 3;
        r0 = r18;
        r0 = (float) r0;
        r56 = r0;
        r57 = 1148846080; // 0x447a0000 float:1000.0 double:5.676053805E-315;
        r56 = r56 / r57;
        r56 = java.lang.Float.valueOf(r56);
        r54[r55] = r56;
        r55 = 4;
        r54[r55] = r15;
        r0 = r59;
        r1 = r49;
        r2 = r54;
        r0.printf(r1, r2);
        r49 = 3;
        r0 = r49;
        r0 = new java.lang.Object[r0];
        r49 = r0;
        r54 = 0;
        r49[r54] = r6;
        r54 = 1;
        r49[r54] = r12;
        r54 = 2;
        r0 = r27;
        r0 = r0.reason;
        r55 = r0;
        r0 = r38;
        r1 = r55;
        r55 = com.android.server.content.SyncOperation.reasonToString(r0, r1);
        r49[r54] = r55;
        r0 = r59;
        r1 = r23;
        r2 = r49;
        r0.printf(r1, r2);
        r0 = r27;
        r0 = r0.event;
        r49 = r0;
        r54 = 1;
        r0 = r49;
        r1 = r54;
        if (r0 != r1) goto L_0x057b;
    L_0x0563:
        r0 = r27;
        r0 = r0.upstreamActivity;
        r54 = r0;
        r56 = 0;
        r49 = (r54 > r56 ? 1 : (r54 == r56 ? 0 : -1));
        if (r49 != 0) goto L_0x057b;
    L_0x056f:
        r0 = r27;
        r0 = r0.downstreamActivity;
        r54 = r0;
        r56 = 0;
        r49 = (r54 > r56 ? 1 : (r54 == r56 ? 0 : -1));
        if (r49 == 0) goto L_0x05b8;
    L_0x057b:
        r49 = "    event=%d upstreamActivity=%d downstreamActivity=%d\n";
        r54 = 3;
        r0 = r54;
        r0 = new java.lang.Object[r0];
        r54 = r0;
        r55 = 0;
        r0 = r27;
        r0 = r0.event;
        r56 = r0;
        r56 = java.lang.Integer.valueOf(r56);
        r54[r55] = r56;
        r55 = 1;
        r0 = r27;
        r0 = r0.upstreamActivity;
        r56 = r0;
        r56 = java.lang.Long.valueOf(r56);
        r54[r55] = r56;
        r55 = 2;
        r0 = r27;
        r0 = r0.downstreamActivity;
        r56 = r0;
        r56 = java.lang.Long.valueOf(r56);
        r54[r55] = r56;
        r0 = r59;
        r1 = r49;
        r2 = r54;
        r0.printf(r1, r2);
    L_0x05b8:
        r0 = r27;
        r0 = r0.mesg;
        r49 = r0;
        if (r49 == 0) goto L_0x05ef;
    L_0x05c0:
        r49 = "success";
        r0 = r27;
        r0 = r0.mesg;
        r54 = r0;
        r0 = r49;
        r1 = r54;
        r49 = r0.equals(r1);
        if (r49 != 0) goto L_0x05ef;
    L_0x05d2:
        r49 = "    mesg=%s\n";
        r54 = 1;
        r0 = r54;
        r0 = new java.lang.Object[r0];
        r54 = r0;
        r55 = 0;
        r0 = r27;
        r0 = r0.mesg;
        r56 = r0;
        r54[r55] = r56;
        r0 = r59;
        r1 = r49;
        r2 = r54;
        r0.printf(r1, r2);
    L_0x05ef:
        r24 = r24 + 1;
        goto L_0x03f9;
    L_0x05f3:
        r0 = r10.target;
        r49 = r0;
        r0 = r49;
        r0 = r0.target_service;
        r49 = r0;
        if (r49 == 0) goto L_0x065e;
    L_0x05ff:
        r49 = new java.lang.StringBuilder;
        r49.<init>();
        r0 = r10.target;
        r54 = r0;
        r0 = r54;
        r0 = r0.service;
        r54 = r0;
        r54 = r54.getPackageName();
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r54 = "/";
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r0 = r10.target;
        r54 = r0;
        r0 = r54;
        r0 = r0.service;
        r54 = r0;
        r54 = r54.getClassName();
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r54 = " u";
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r0 = r10.target;
        r54 = r0;
        r0 = r54;
        r0 = r0.userId;
        r54 = r0;
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r12 = r49.toString();
        r6 = "none";
        goto L_0x0490;
    L_0x065e:
        r12 = "Unknown";
        r6 = "Unknown";
        goto L_0x0490;
    L_0x0664:
        r12 = "Unknown";
        r6 = "Unknown";
        goto L_0x0490;
    L_0x066a:
        r54 = r30.longValue();
        r54 = r54 - r20;
        r56 = 1000; // 0x3e8 float:1.401E-42 double:4.94E-321;
        r16 = r54 / r56;
        r54 = 60;
        r49 = (r16 > r54 ? 1 : (r16 == r54 ? 0 : -1));
        if (r49 >= 0) goto L_0x0680;
    L_0x067a:
        r15 = java.lang.String.valueOf(r16);
        goto L_0x04d5;
    L_0x0680:
        r54 = 3600; // 0xe10 float:5.045E-42 double:1.7786E-320;
        r49 = (r16 > r54 ? 1 : (r16 == r54 ? 0 : -1));
        if (r49 >= 0) goto L_0x06b2;
    L_0x0686:
        r49 = "%02d:%02d";
        r54 = 2;
        r0 = r54;
        r0 = new java.lang.Object[r0];
        r54 = r0;
        r55 = 0;
        r56 = 60;
        r56 = r16 / r56;
        r56 = java.lang.Long.valueOf(r56);
        r54[r55] = r56;
        r55 = 1;
        r56 = 60;
        r56 = r16 % r56;
        r56 = java.lang.Long.valueOf(r56);
        r54[r55] = r56;
        r0 = r49;
        r1 = r54;
        r15 = java.lang.String.format(r0, r1);
        goto L_0x04d5;
    L_0x06b2:
        r54 = 3600; // 0xe10 float:5.045E-42 double:1.7786E-320;
        r40 = r16 % r54;
        r49 = "%02d:%02d:%02d";
        r54 = 3;
        r0 = r54;
        r0 = new java.lang.Object[r0];
        r54 = r0;
        r55 = 0;
        r56 = 3600; // 0xe10 float:5.045E-42 double:1.7786E-320;
        r56 = r16 / r56;
        r56 = java.lang.Long.valueOf(r56);
        r54[r55] = r56;
        r55 = 1;
        r56 = 60;
        r56 = r40 / r56;
        r56 = java.lang.Long.valueOf(r56);
        r54[r55] = r56;
        r55 = 2;
        r56 = 60;
        r56 = r40 % r56;
        r56 = java.lang.Long.valueOf(r56);
        r54[r55] = r56;
        r0 = r49;
        r1 = r54;
        r15 = java.lang.String.format(r0, r1);
        goto L_0x04d5;
    L_0x06ee:
        r59.println();
        r49 = "Recent Sync History Extras";
        r0 = r59;
        r1 = r49;
        r0.println(r1);
        r24 = 0;
    L_0x06fc:
        r0 = r24;
        if (r0 >= r4) goto L_0x087f;
    L_0x0700:
        r0 = r28;
        r1 = r24;
        r27 = r0.get(r1);
        r27 = (com.android.server.content.SyncStorageEngine.SyncHistoryItem) r27;
        r0 = r27;
        r0 = r0.extras;
        r22 = r0;
        if (r22 == 0) goto L_0x0718;
    L_0x0712:
        r49 = r22.size();
        if (r49 != 0) goto L_0x071b;
    L_0x0718:
        r24 = r24 + 1;
        goto L_0x06fc;
    L_0x071b:
        r0 = r58;
        r0 = r0.mSyncStorageEngine;
        r49 = r0;
        r0 = r27;
        r0 = r0.authorityId;
        r54 = r0;
        r0 = r49;
        r1 = r54;
        r10 = r0.getAuthority(r1);
        if (r10 == 0) goto L_0x0879;
    L_0x0731:
        r0 = r10.target;
        r49 = r0;
        r0 = r49;
        r0 = r0.target_provider;
        r49 = r0;
        if (r49 == 0) goto L_0x0808;
    L_0x073d:
        r0 = r10.target;
        r49 = r0;
        r0 = r49;
        r12 = r0.provider;
        r49 = new java.lang.StringBuilder;
        r49.<init>();
        r0 = r10.target;
        r54 = r0;
        r0 = r54;
        r0 = r0.account;
        r54 = r0;
        r0 = r54;
        r0 = r0.name;
        r54 = r0;
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r54 = "/";
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r0 = r10.target;
        r54 = r0;
        r0 = r54;
        r0 = r0.account;
        r54 = r0;
        r0 = r54;
        r0 = r0.type;
        r54 = r0;
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r54 = " u";
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r0 = r10.target;
        r54 = r0;
        r0 = r54;
        r0 = r0.userId;
        r54 = r0;
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r6 = r49.toString();
    L_0x07a4:
        r45 = new android.text.format.Time;
        r45.<init>();
        r0 = r27;
        r0 = r0.eventTime;
        r20 = r0;
        r0 = r45;
        r1 = r20;
        r0.set(r1);
        r49 = "  #%-3d: %s %8s ";
        r54 = 3;
        r0 = r54;
        r0 = new java.lang.Object[r0];
        r54 = r0;
        r55 = 0;
        r56 = r24 + 1;
        r56 = java.lang.Integer.valueOf(r56);
        r54[r55] = r56;
        r55 = 1;
        r56 = formatTime(r20);
        r54[r55] = r56;
        r55 = 2;
        r56 = com.android.server.content.SyncStorageEngine.SOURCES;
        r0 = r27;
        r0 = r0.source;
        r57 = r0;
        r56 = r56[r57];
        r54[r55] = r56;
        r0 = r59;
        r1 = r49;
        r2 = r54;
        r0.printf(r1, r2);
        r49 = 3;
        r0 = r49;
        r0 = new java.lang.Object[r0];
        r49 = r0;
        r54 = 0;
        r49[r54] = r6;
        r54 = 1;
        r49[r54] = r12;
        r54 = 2;
        r49[r54] = r22;
        r0 = r59;
        r1 = r23;
        r2 = r49;
        r0.printf(r1, r2);
        goto L_0x0718;
    L_0x0808:
        r0 = r10.target;
        r49 = r0;
        r0 = r49;
        r0 = r0.target_service;
        r49 = r0;
        if (r49 == 0) goto L_0x0873;
    L_0x0814:
        r49 = new java.lang.StringBuilder;
        r49.<init>();
        r0 = r10.target;
        r54 = r0;
        r0 = r54;
        r0 = r0.service;
        r54 = r0;
        r54 = r54.getPackageName();
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r54 = "/";
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r0 = r10.target;
        r54 = r0;
        r0 = r54;
        r0 = r0.service;
        r54 = r0;
        r54 = r54.getClassName();
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r54 = " u";
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r0 = r10.target;
        r54 = r0;
        r0 = r54;
        r0 = r0.userId;
        r54 = r0;
        r0 = r49;
        r1 = r54;
        r49 = r0.append(r1);
        r12 = r49.toString();
        r6 = "none";
        goto L_0x07a4;
    L_0x0873:
        r12 = "Unknown";
        r6 = "Unknown";
        goto L_0x07a4;
    L_0x0879:
        r12 = "Unknown";
        r6 = "Unknown";
        goto L_0x07a4;
    L_0x087f:
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.content.SyncManager.dumpRecentHistory(java.io.PrintWriter):void");
    }

    private void dumpDayStatistics(PrintWriter pw) {
        DayStats[] dses = this.mSyncStorageEngine.getDayStatistics();
        if (dses != null && dses[MAX_SIMULTANEOUS_REGULAR_SYNCS] != null) {
            DayStats ds;
            pw.println();
            pw.println("Sync Statistics");
            pw.print("  Today:  ");
            dumpDayStatistic(pw, dses[MAX_SIMULTANEOUS_REGULAR_SYNCS]);
            int today = dses[MAX_SIMULTANEOUS_REGULAR_SYNCS].day;
            int i = 1;
            while (i <= 6 && i < dses.length) {
                ds = dses[i];
                if (ds != null) {
                    int delta = today - ds.day;
                    if (delta > 6) {
                        break;
                    }
                    pw.print("  Day-");
                    pw.print(delta);
                    pw.print(":  ");
                    dumpDayStatistic(pw, ds);
                    i++;
                } else {
                    break;
                }
            }
            int weekDay = today;
            while (i < dses.length) {
                DayStats aggr = null;
                weekDay -= 7;
                while (i < dses.length) {
                    ds = dses[i];
                    if (ds != null) {
                        if (weekDay - ds.day > 6) {
                            break;
                        }
                        i++;
                        if (aggr == null) {
                            aggr = new DayStats(weekDay);
                        }
                        aggr.successCount += ds.successCount;
                        aggr.successTime += ds.successTime;
                        aggr.failureCount += ds.failureCount;
                        aggr.failureTime += ds.failureTime;
                    } else {
                        i = dses.length;
                        break;
                    }
                }
                if (aggr != null) {
                    pw.print("  Week-");
                    pw.print((today - weekDay) / 7);
                    pw.print(": ");
                    dumpDayStatistic(pw, aggr);
                }
            }
        }
    }

    private void dumpSyncAdapters(IndentingPrintWriter pw) {
        pw.println();
        List<UserInfo> users = getAllUsers();
        if (users != null) {
            for (UserInfo user : users) {
                pw.println("Sync adapters for " + user + ":");
                pw.increaseIndent();
                for (ServiceInfo<?> info : this.mSyncAdapters.getAllServices(user.id)) {
                    pw.println(info);
                }
                pw.decreaseIndent();
                pw.println();
            }
        }
    }

    private boolean isSyncStillActive(ActiveSyncContext activeSyncContext) {
        Iterator i$ = this.mActiveSyncContexts.iterator();
        while (i$.hasNext()) {
            if (((ActiveSyncContext) i$.next()) == activeSyncContext) {
                return true;
            }
        }
        return false;
    }

    public static boolean syncExtrasEquals(Bundle b1, Bundle b2, boolean includeSyncSettings) {
        if (b1 == b2) {
            return true;
        }
        if (includeSyncSettings && b1.size() != b2.size()) {
            return false;
        }
        Bundle bigger;
        Bundle smaller;
        if (b1.size() > b2.size()) {
            bigger = b1;
        } else {
            bigger = b2;
        }
        if (b1.size() > b2.size()) {
            smaller = b2;
        } else {
            smaller = b1;
        }
        for (String key : bigger.keySet()) {
            if (includeSyncSettings || !isSyncSetting(key)) {
                if (!smaller.containsKey(key)) {
                    return false;
                }
                if (!bigger.get(key).equals(smaller.get(key))) {
                    return false;
                }
            }
        }
        return true;
    }

    private static boolean isSyncSetting(String key) {
        if (key.equals("expedited") || key.equals("ignore_settings") || key.equals("ignore_backoff") || key.equals("do_not_retry") || key.equals("force") || key.equals("upload") || key.equals("deletions_override") || key.equals("discard_deletions") || key.equals("expected_upload") || key.equals("expected_download") || key.equals("sync_priority") || key.equals("allow_metered") || key.equals("initialize")) {
            return true;
        }
        return false;
    }

    private Context getContextForUser(UserHandle user) {
        try {
            return this.mContext.createPackageContextAsUser(this.mContext.getPackageName(), MAX_SIMULTANEOUS_REGULAR_SYNCS, user);
        } catch (NameNotFoundException e) {
            return this.mContext;
        }
    }
}
