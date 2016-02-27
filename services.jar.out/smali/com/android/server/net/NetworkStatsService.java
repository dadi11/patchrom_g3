package com.android.server.net;

import android.app.AlarmManager;
import android.app.IAlarmManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.ApplicationInfo;
import android.net.ConnectivityManager;
import android.net.IConnectivityManager;
import android.net.INetworkManagementEventObserver;
import android.net.INetworkStatsService.Stub;
import android.net.INetworkStatsSession;
import android.net.LinkProperties;
import android.net.NetworkIdentity;
import android.net.NetworkState;
import android.net.NetworkStats;
import android.net.NetworkStats.Entry;
import android.net.NetworkStats.NonMonotonicObserver;
import android.net.NetworkStatsHistory;
import android.net.NetworkTemplate;
import android.os.Binder;
import android.os.DropBoxManager;
import android.os.Environment;
import android.os.Handler;
import android.os.Handler.Callback;
import android.os.HandlerThread;
import android.os.INetworkManagementService;
import android.os.Message;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.RemoteException;
import android.os.SystemClock;
import android.os.UserHandle;
import android.provider.Settings.Global;
import android.telephony.TelephonyManager;
import android.util.ArrayMap;
import android.util.ArraySet;
import android.util.Log;
import android.util.MathUtils;
import android.util.NtpTrustedTime;
import android.util.Slog;
import android.util.SparseIntArray;
import android.util.TrustedTime;
import com.android.internal.util.ArrayUtils;
import com.android.internal.util.FileRotator;
import com.android.internal.util.IndentingPrintWriter;
import com.android.internal.util.Preconditions;
import com.android.server.EventLogTags;
import com.android.server.NetworkManagementService;
import com.android.server.NetworkManagementSocketTagger;
import java.io.File;
import java.io.FileDescriptor;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;

public class NetworkStatsService extends Stub {
    public static final String ACTION_NETWORK_STATS_POLL = "com.android.server.action.NETWORK_STATS_POLL";
    public static final String ACTION_NETWORK_STATS_UPDATED = "com.android.server.action.NETWORK_STATS_UPDATED";
    private static final int FLAG_PERSIST_ALL = 3;
    private static final int FLAG_PERSIST_FORCE = 256;
    private static final int FLAG_PERSIST_NETWORK = 1;
    private static final int FLAG_PERSIST_UID = 2;
    private static final boolean LOGV = false;
    private static final int MSG_PERFORM_POLL = 1;
    private static final int MSG_REGISTER_GLOBAL_ALERT = 3;
    private static final int MSG_UPDATE_IFACES = 2;
    private static final String PREFIX_DEV = "dev";
    private static final String PREFIX_UID = "uid";
    private static final String PREFIX_UID_TAG = "uid_tag";
    private static final String PREFIX_XT = "xt";
    private static final String TAG = "NetworkStats";
    private static final String TAG_NETSTATS_ERROR = "netstats_error";
    private String mActiveIface;
    private final ArrayMap<String, NetworkIdentitySet> mActiveIfaces;
    private SparseIntArray mActiveUidCounterSet;
    private final ArrayMap<String, NetworkIdentitySet> mActiveUidIfaces;
    private final AlarmManager mAlarmManager;
    private INetworkManagementEventObserver mAlertObserver;
    private final File mBaseDir;
    private IConnectivityManager mConnManager;
    private final Context mContext;
    private NetworkStatsRecorder mDevRecorder;
    private long mGlobalAlertBytes;
    private final Handler mHandler;
    private Callback mHandlerCallback;
    private String[] mMobileIfaces;
    private final INetworkManagementService mNetworkManager;
    private final DropBoxNonMonotonicObserver mNonMonotonicObserver;
    private long mPersistThreshold;
    private PendingIntent mPollIntent;
    private BroadcastReceiver mPollReceiver;
    private BroadcastReceiver mRemovedReceiver;
    private final NetworkStatsSettings mSettings;
    private BroadcastReceiver mShutdownReceiver;
    private final Object mStatsLock;
    private final File mSystemDir;
    private boolean mSystemReady;
    private final TelephonyManager mTeleManager;
    private BroadcastReceiver mTetherReceiver;
    private final TrustedTime mTime;
    private NetworkStats mUidOperations;
    private NetworkStatsRecorder mUidRecorder;
    private NetworkStatsRecorder mUidTagRecorder;
    private BroadcastReceiver mUserReceiver;
    private final WakeLock mWakeLock;
    private NetworkStatsRecorder mXtRecorder;
    private NetworkStatsCollection mXtStatsCached;

    /* renamed from: com.android.server.net.NetworkStatsService.1 */
    class C04001 extends INetworkStatsSession.Stub {
        private NetworkStatsCollection mUidComplete;
        private NetworkStatsCollection mUidTagComplete;

        C04001() {
        }

        private NetworkStatsCollection getUidComplete() {
            NetworkStatsCollection networkStatsCollection;
            synchronized (NetworkStatsService.this.mStatsLock) {
                if (this.mUidComplete == null) {
                    this.mUidComplete = NetworkStatsService.this.mUidRecorder.getOrLoadCompleteLocked();
                }
                networkStatsCollection = this.mUidComplete;
            }
            return networkStatsCollection;
        }

        private NetworkStatsCollection getUidTagComplete() {
            NetworkStatsCollection networkStatsCollection;
            synchronized (NetworkStatsService.this.mStatsLock) {
                if (this.mUidTagComplete == null) {
                    this.mUidTagComplete = NetworkStatsService.this.mUidTagRecorder.getOrLoadCompleteLocked();
                }
                networkStatsCollection = this.mUidTagComplete;
            }
            return networkStatsCollection;
        }

        public NetworkStats getSummaryForNetwork(NetworkTemplate template, long start, long end) {
            return NetworkStatsService.this.internalGetSummaryForNetwork(template, start, end);
        }

        public NetworkStatsHistory getHistoryForNetwork(NetworkTemplate template, int fields) {
            return NetworkStatsService.this.internalGetHistoryForNetwork(template, fields);
        }

        public NetworkStats getSummaryForAllUid(NetworkTemplate template, long start, long end, boolean includeTags) {
            NetworkStats stats = getUidComplete().getSummary(template, start, end);
            if (includeTags) {
                stats.combineAllValues(getUidTagComplete().getSummary(template, start, end));
            }
            return stats;
        }

        public NetworkStatsHistory getHistoryForUid(NetworkTemplate template, int uid, int set, int tag, int fields) {
            if (tag == 0) {
                return getUidComplete().getHistory(template, uid, set, tag, fields);
            }
            return getUidTagComplete().getHistory(template, uid, set, tag, fields);
        }

        public void close() {
            this.mUidComplete = null;
            this.mUidTagComplete = null;
        }
    }

    /* renamed from: com.android.server.net.NetworkStatsService.2 */
    class C04012 extends BroadcastReceiver {
        C04012() {
        }

        public void onReceive(Context context, Intent intent) {
            NetworkStatsService.this.performPoll(NetworkStatsService.MSG_PERFORM_POLL);
        }
    }

    /* renamed from: com.android.server.net.NetworkStatsService.3 */
    class C04023 extends BroadcastReceiver {
        C04023() {
        }

        public void onReceive(Context context, Intent intent) {
            NetworkStatsService.this.performPoll(NetworkStatsService.MSG_REGISTER_GLOBAL_ALERT);
            NetworkStatsService.this.registerGlobalAlert();
        }
    }

    /* renamed from: com.android.server.net.NetworkStatsService.4 */
    class C04034 extends BroadcastReceiver {
        C04034() {
        }

        public void onReceive(Context context, Intent intent) {
            int uid = intent.getIntExtra("android.intent.extra.UID", -1);
            if (uid != -1) {
                synchronized (NetworkStatsService.this.mStatsLock) {
                    NetworkStatsService.this.mWakeLock.acquire();
                    try {
                        NetworkStatsService networkStatsService = NetworkStatsService.this;
                        int[] iArr = new int[NetworkStatsService.MSG_PERFORM_POLL];
                        iArr[0] = uid;
                        networkStatsService.removeUidsLocked(iArr);
                    } finally {
                        NetworkStatsService.this.mWakeLock.release();
                    }
                }
            }
        }
    }

    /* renamed from: com.android.server.net.NetworkStatsService.5 */
    class C04045 extends BroadcastReceiver {
        C04045() {
        }

        public void onReceive(Context context, Intent intent) {
            int userId = intent.getIntExtra("android.intent.extra.user_handle", -1);
            if (userId != -1) {
                synchronized (NetworkStatsService.this.mStatsLock) {
                    NetworkStatsService.this.mWakeLock.acquire();
                    try {
                        NetworkStatsService.this.removeUserLocked(userId);
                    } finally {
                        NetworkStatsService.this.mWakeLock.release();
                    }
                }
            }
        }
    }

    /* renamed from: com.android.server.net.NetworkStatsService.6 */
    class C04056 extends BroadcastReceiver {
        C04056() {
        }

        public void onReceive(Context context, Intent intent) {
            if (!intent.getBooleanExtra("from_quickboot", NetworkStatsService.LOGV)) {
                synchronized (NetworkStatsService.this.mStatsLock) {
                    NetworkStatsService.this.shutdownLocked();
                }
            }
        }
    }

    /* renamed from: com.android.server.net.NetworkStatsService.7 */
    class C04067 extends BaseNetworkObserver {
        C04067() {
        }

        public void limitReached(String limitName, String iface) {
            NetworkStatsService.this.mContext.enforceCallingOrSelfPermission("android.permission.CONNECTIVITY_INTERNAL", NetworkStatsService.TAG);
            if (NetworkManagementService.LIMIT_GLOBAL_ALERT.equals(limitName)) {
                NetworkStatsService.this.mHandler.obtainMessage(NetworkStatsService.MSG_PERFORM_POLL, NetworkStatsService.MSG_PERFORM_POLL, 0).sendToTarget();
                NetworkStatsService.this.mHandler.obtainMessage(NetworkStatsService.MSG_REGISTER_GLOBAL_ALERT).sendToTarget();
            }
        }
    }

    /* renamed from: com.android.server.net.NetworkStatsService.8 */
    class C04078 implements Callback {
        C04078() {
        }

        public boolean handleMessage(Message msg) {
            switch (msg.what) {
                case NetworkStatsService.MSG_PERFORM_POLL /*1*/:
                    NetworkStatsService.this.performPoll(msg.arg1);
                    return true;
                case NetworkStatsService.MSG_UPDATE_IFACES /*2*/:
                    NetworkStatsService.this.updateIfaces();
                    return true;
                case NetworkStatsService.MSG_REGISTER_GLOBAL_ALERT /*3*/:
                    NetworkStatsService.this.registerGlobalAlert();
                    return true;
                default:
                    return NetworkStatsService.LOGV;
            }
        }
    }

    public interface NetworkStatsSettings {

        public static class Config {
            public final long bucketDuration;
            public final long deleteAgeMillis;
            public final long rotateAgeMillis;

            public Config(long bucketDuration, long rotateAgeMillis, long deleteAgeMillis) {
                this.bucketDuration = bucketDuration;
                this.rotateAgeMillis = rotateAgeMillis;
                this.deleteAgeMillis = deleteAgeMillis;
            }
        }

        Config getDevConfig();

        long getDevPersistBytes(long j);

        long getGlobalAlertBytes(long j);

        long getPollInterval();

        boolean getSampleEnabled();

        long getTimeCacheMaxAge();

        Config getUidConfig();

        long getUidPersistBytes(long j);

        Config getUidTagConfig();

        long getUidTagPersistBytes(long j);

        Config getXtConfig();

        long getXtPersistBytes(long j);
    }

    private static class DefaultNetworkStatsSettings implements NetworkStatsSettings {
        private final ContentResolver mResolver;

        public DefaultNetworkStatsSettings(Context context) {
            this.mResolver = (ContentResolver) Preconditions.checkNotNull(context.getContentResolver());
        }

        private long getGlobalLong(String name, long def) {
            return Global.getLong(this.mResolver, name, def);
        }

        private boolean getGlobalBoolean(String name, boolean def) {
            int defInt;
            if (def) {
                defInt = NetworkStatsService.MSG_PERFORM_POLL;
            } else {
                defInt = 0;
            }
            return Global.getInt(this.mResolver, name, defInt) != 0 ? true : NetworkStatsService.LOGV;
        }

        public long getPollInterval() {
            return getGlobalLong("netstats_poll_interval", 1800000);
        }

        public long getTimeCacheMaxAge() {
            return getGlobalLong("netstats_time_cache_max_age", 86400000);
        }

        public long getGlobalAlertBytes(long def) {
            return getGlobalLong("netstats_global_alert_bytes", def);
        }

        public boolean getSampleEnabled() {
            return getGlobalBoolean("netstats_sample_enabled", true);
        }

        public Config getDevConfig() {
            return new Config(getGlobalLong("netstats_dev_bucket_duration", 3600000), getGlobalLong("netstats_dev_rotate_age", 1296000000), getGlobalLong("netstats_dev_delete_age", 7776000000L));
        }

        public Config getXtConfig() {
            return getDevConfig();
        }

        public Config getUidConfig() {
            return new Config(getGlobalLong("netstats_uid_bucket_duration", 7200000), getGlobalLong("netstats_uid_rotate_age", 1296000000), getGlobalLong("netstats_uid_delete_age", 7776000000L));
        }

        public Config getUidTagConfig() {
            return new Config(getGlobalLong("netstats_uid_tag_bucket_duration", 7200000), getGlobalLong("netstats_uid_tag_rotate_age", 432000000), getGlobalLong("netstats_uid_tag_delete_age", 1296000000));
        }

        public long getDevPersistBytes(long def) {
            return getGlobalLong("netstats_dev_persist_bytes", def);
        }

        public long getXtPersistBytes(long def) {
            return getDevPersistBytes(def);
        }

        public long getUidPersistBytes(long def) {
            return getGlobalLong("netstats_uid_persist_bytes", def);
        }

        public long getUidTagPersistBytes(long def) {
            return getGlobalLong("netstats_uid_tag_persist_bytes", def);
        }
    }

    private class DropBoxNonMonotonicObserver implements NonMonotonicObserver<String> {
        private DropBoxNonMonotonicObserver() {
        }

        public void foundNonMonotonic(NetworkStats left, int leftIndex, NetworkStats right, int rightIndex, String cookie) {
            Log.w(NetworkStatsService.TAG, "found non-monotonic values; saving to dropbox");
            StringBuilder builder = new StringBuilder();
            builder.append("found non-monotonic " + cookie + " values at left[" + leftIndex + "] - right[" + rightIndex + "]\n");
            builder.append("left=").append(left).append('\n');
            builder.append("right=").append(right).append('\n');
            ((DropBoxManager) NetworkStatsService.this.mContext.getSystemService("dropbox")).addText(NetworkStatsService.TAG_NETSTATS_ERROR, builder.toString());
        }
    }

    public NetworkStatsService(Context context, INetworkManagementService networkManager, IAlarmManager alarmManager) {
        this(context, networkManager, alarmManager, NtpTrustedTime.getInstance(context), getDefaultSystemDir(), new DefaultNetworkStatsSettings(context));
    }

    private static File getDefaultSystemDir() {
        return new File(Environment.getDataDirectory(), "system");
    }

    public NetworkStatsService(Context context, INetworkManagementService networkManager, IAlarmManager alarmManager, TrustedTime time, File systemDir, NetworkStatsSettings settings) {
        this.mStatsLock = new Object();
        this.mActiveIfaces = new ArrayMap();
        this.mActiveUidIfaces = new ArrayMap();
        this.mMobileIfaces = new String[0];
        this.mNonMonotonicObserver = new DropBoxNonMonotonicObserver();
        this.mActiveUidCounterSet = new SparseIntArray();
        this.mUidOperations = new NetworkStats(0, 10);
        this.mPersistThreshold = 2097152;
        this.mTetherReceiver = new C04012();
        this.mPollReceiver = new C04023();
        this.mRemovedReceiver = new C04034();
        this.mUserReceiver = new C04045();
        this.mShutdownReceiver = new C04056();
        this.mAlertObserver = new C04067();
        this.mHandlerCallback = new C04078();
        this.mContext = (Context) Preconditions.checkNotNull(context, "missing Context");
        this.mNetworkManager = (INetworkManagementService) Preconditions.checkNotNull(networkManager, "missing INetworkManagementService");
        this.mTime = (TrustedTime) Preconditions.checkNotNull(time, "missing TrustedTime");
        this.mTeleManager = (TelephonyManager) Preconditions.checkNotNull(TelephonyManager.getDefault(), "missing TelephonyManager");
        this.mSettings = (NetworkStatsSettings) Preconditions.checkNotNull(settings, "missing NetworkStatsSettings");
        this.mAlarmManager = (AlarmManager) context.getSystemService("alarm");
        this.mWakeLock = ((PowerManager) context.getSystemService("power")).newWakeLock(MSG_PERFORM_POLL, TAG);
        HandlerThread thread = new HandlerThread(TAG);
        thread.start();
        this.mHandler = new Handler(thread.getLooper(), this.mHandlerCallback);
        this.mSystemDir = (File) Preconditions.checkNotNull(systemDir);
        this.mBaseDir = new File(systemDir, "netstats");
        this.mBaseDir.mkdirs();
    }

    public void bindConnectivityManager(IConnectivityManager connManager) {
        this.mConnManager = (IConnectivityManager) Preconditions.checkNotNull(connManager, "missing IConnectivityManager");
    }

    public void systemReady() {
        this.mSystemReady = true;
        if (isBandwidthControlEnabled()) {
            this.mDevRecorder = buildRecorder(PREFIX_DEV, this.mSettings.getDevConfig(), LOGV);
            this.mXtRecorder = buildRecorder(PREFIX_XT, this.mSettings.getXtConfig(), LOGV);
            this.mUidRecorder = buildRecorder(PREFIX_UID, this.mSettings.getUidConfig(), LOGV);
            this.mUidTagRecorder = buildRecorder(PREFIX_UID_TAG, this.mSettings.getUidTagConfig(), true);
            updatePersistThresholds();
            synchronized (this.mStatsLock) {
                maybeUpgradeLegacyStatsLocked();
                this.mXtStatsCached = this.mXtRecorder.getOrLoadCompleteLocked();
                bootstrapStatsLocked();
            }
            this.mContext.registerReceiver(this.mTetherReceiver, new IntentFilter("android.net.conn.TETHER_STATE_CHANGED"), null, this.mHandler);
            this.mContext.registerReceiver(this.mPollReceiver, new IntentFilter(ACTION_NETWORK_STATS_POLL), "android.permission.READ_NETWORK_USAGE_HISTORY", this.mHandler);
            this.mContext.registerReceiver(this.mRemovedReceiver, new IntentFilter("android.intent.action.UID_REMOVED"), null, this.mHandler);
            this.mContext.registerReceiver(this.mUserReceiver, new IntentFilter("android.intent.action.USER_REMOVED"), null, this.mHandler);
            this.mContext.registerReceiver(this.mShutdownReceiver, new IntentFilter("android.intent.action.ACTION_SHUTDOWN"));
            try {
                this.mNetworkManager.registerObserver(this.mAlertObserver);
            } catch (RemoteException e) {
            }
            registerPollAlarmLocked();
            registerGlobalAlert();
            return;
        }
        Slog.w(TAG, "bandwidth controls disabled, unable to track stats");
    }

    private NetworkStatsRecorder buildRecorder(String prefix, Config config, boolean includeTags) {
        return new NetworkStatsRecorder(new FileRotator(this.mBaseDir, prefix, config.rotateAgeMillis, config.deleteAgeMillis), this.mNonMonotonicObserver, (DropBoxManager) this.mContext.getSystemService("dropbox"), prefix, config.bucketDuration, includeTags);
    }

    private void shutdownLocked() {
        this.mContext.unregisterReceiver(this.mTetherReceiver);
        this.mContext.unregisterReceiver(this.mPollReceiver);
        this.mContext.unregisterReceiver(this.mRemovedReceiver);
        this.mContext.unregisterReceiver(this.mShutdownReceiver);
        long currentTime = this.mTime.hasCache() ? this.mTime.currentTimeMillis() : System.currentTimeMillis();
        this.mDevRecorder.forcePersistLocked(currentTime);
        this.mXtRecorder.forcePersistLocked(currentTime);
        this.mUidRecorder.forcePersistLocked(currentTime);
        this.mUidTagRecorder.forcePersistLocked(currentTime);
        this.mDevRecorder = null;
        this.mXtRecorder = null;
        this.mUidRecorder = null;
        this.mUidTagRecorder = null;
        this.mXtStatsCached = null;
        this.mSystemReady = LOGV;
    }

    private void maybeUpgradeLegacyStatsLocked() {
        try {
            File file = new File(this.mSystemDir, "netstats.bin");
            if (file.exists()) {
                this.mDevRecorder.importLegacyNetworkLocked(file);
                file.delete();
            }
            file = new File(this.mSystemDir, "netstats_xt.bin");
            if (file.exists()) {
                file.delete();
            }
            file = new File(this.mSystemDir, "netstats_uid.bin");
            if (file.exists()) {
                this.mUidRecorder.importLegacyUidLocked(file);
                this.mUidTagRecorder.importLegacyUidLocked(file);
                file.delete();
            }
        } catch (IOException e) {
            Log.wtf(TAG, "problem during legacy upgrade", e);
        } catch (OutOfMemoryError e2) {
            Log.wtf(TAG, "problem during legacy upgrade", e2);
        }
    }

    private void registerPollAlarmLocked() {
        if (this.mPollIntent != null) {
            this.mAlarmManager.cancel(this.mPollIntent);
        }
        this.mPollIntent = PendingIntent.getBroadcast(this.mContext, 0, new Intent(ACTION_NETWORK_STATS_POLL), 0);
        this.mAlarmManager.setInexactRepeating(MSG_REGISTER_GLOBAL_ALERT, SystemClock.elapsedRealtime(), this.mSettings.getPollInterval(), this.mPollIntent);
    }

    private void registerGlobalAlert() {
        try {
            this.mNetworkManager.setGlobalAlert(this.mGlobalAlertBytes);
        } catch (IllegalStateException e) {
            Slog.w(TAG, "problem registering for global alert: " + e);
        } catch (RemoteException e2) {
        }
    }

    public INetworkStatsSession openSession() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.READ_NETWORK_USAGE_HISTORY", TAG);
        assertBandwidthControlEnabled();
        return new C04001();
    }

    private NetworkStats internalGetSummaryForNetwork(NetworkTemplate template, long start, long end) {
        return this.mXtStatsCached.getSummary(template, start, end);
    }

    private NetworkStatsHistory internalGetHistoryForNetwork(NetworkTemplate template, int fields) {
        return this.mXtStatsCached.getHistory(template, -1, -1, 0, fields);
    }

    public long getNetworkTotalBytes(NetworkTemplate template, long start, long end) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.READ_NETWORK_USAGE_HISTORY", TAG);
        assertBandwidthControlEnabled();
        return internalGetSummaryForNetwork(template, start, end).getTotalBytes();
    }

    public NetworkStats getDataLayerSnapshotForUid(int uid) throws RemoteException {
        if (Binder.getCallingUid() != uid) {
            this.mContext.enforceCallingOrSelfPermission("android.permission.ACCESS_NETWORK_STATE", TAG);
        }
        assertBandwidthControlEnabled();
        long token = Binder.clearCallingIdentity();
        try {
            NetworkStats networkLayer = this.mNetworkManager.getNetworkStatsUidDetail(uid);
            networkLayer.spliceOperationsFrom(this.mUidOperations);
            NetworkStats dataLayer = new NetworkStats(networkLayer.getElapsedRealtime(), networkLayer.size());
            Entry entry = null;
            for (int i = 0; i < networkLayer.size(); i += MSG_PERFORM_POLL) {
                entry = networkLayer.getValues(i, entry);
                entry.iface = NetworkStats.IFACE_ALL;
                dataLayer.combineValues(entry);
            }
            return dataLayer;
        } finally {
            Binder.restoreCallingIdentity(token);
        }
    }

    public String[] getMobileIfaces() {
        return this.mMobileIfaces;
    }

    public void incrementOperationCount(int uid, int tag, int operationCount) {
        if (Binder.getCallingUid() != uid) {
            this.mContext.enforceCallingOrSelfPermission("android.permission.MODIFY_NETWORK_ACCOUNTING", TAG);
        }
        if (operationCount < 0) {
            throw new IllegalArgumentException("operation count can only be incremented");
        } else if (tag == 0) {
            throw new IllegalArgumentException("operation count must have specific tag");
        } else {
            synchronized (this.mStatsLock) {
                int set = this.mActiveUidCounterSet.get(uid, 0);
                int i = uid;
                int i2 = tag;
                this.mUidOperations.combineValues(this.mActiveIface, i, set, i2, 0, 0, 0, 0, (long) operationCount);
                i = uid;
                this.mUidOperations.combineValues(this.mActiveIface, i, set, 0, 0, 0, 0, 0, (long) operationCount);
            }
        }
    }

    public void setUidForeground(int uid, boolean uidForeground) {
        int set = 0;
        this.mContext.enforceCallingOrSelfPermission("android.permission.MODIFY_NETWORK_ACCOUNTING", TAG);
        synchronized (this.mStatsLock) {
            if (uidForeground) {
                set = MSG_PERFORM_POLL;
            }
            if (this.mActiveUidCounterSet.get(uid, 0) != set) {
                this.mActiveUidCounterSet.put(uid, set);
                NetworkManagementSocketTagger.setKernelCounterSet(uid, set);
            }
        }
    }

    public void forceUpdateIfaces() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.READ_NETWORK_USAGE_HISTORY", TAG);
        assertBandwidthControlEnabled();
        long token = Binder.clearCallingIdentity();
        try {
            updateIfaces();
        } finally {
            Binder.restoreCallingIdentity(token);
        }
    }

    public void forceUpdate() {
        this.mContext.enforceCallingOrSelfPermission("android.permission.READ_NETWORK_USAGE_HISTORY", TAG);
        assertBandwidthControlEnabled();
        long token = Binder.clearCallingIdentity();
        try {
            performPoll(MSG_REGISTER_GLOBAL_ALERT);
        } finally {
            Binder.restoreCallingIdentity(token);
        }
    }

    public void advisePersistThreshold(long thresholdBytes) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.MODIFY_NETWORK_ACCOUNTING", TAG);
        assertBandwidthControlEnabled();
        this.mPersistThreshold = MathUtils.constrain(thresholdBytes, 131072, 2097152);
        long currentTime = this.mTime.hasCache() ? this.mTime.currentTimeMillis() : System.currentTimeMillis();
        synchronized (this.mStatsLock) {
            if (this.mSystemReady) {
                updatePersistThresholds();
                this.mDevRecorder.maybePersistLocked(currentTime);
                this.mXtRecorder.maybePersistLocked(currentTime);
                this.mUidRecorder.maybePersistLocked(currentTime);
                this.mUidTagRecorder.maybePersistLocked(currentTime);
                registerGlobalAlert();
                return;
            }
        }
    }

    private void updatePersistThresholds() {
        this.mDevRecorder.setPersistThreshold(this.mSettings.getDevPersistBytes(this.mPersistThreshold));
        this.mXtRecorder.setPersistThreshold(this.mSettings.getXtPersistBytes(this.mPersistThreshold));
        this.mUidRecorder.setPersistThreshold(this.mSettings.getUidPersistBytes(this.mPersistThreshold));
        this.mUidTagRecorder.setPersistThreshold(this.mSettings.getUidTagPersistBytes(this.mPersistThreshold));
        this.mGlobalAlertBytes = this.mSettings.getGlobalAlertBytes(this.mPersistThreshold);
    }

    private void updateIfaces() {
        synchronized (this.mStatsLock) {
            this.mWakeLock.acquire();
            try {
                updateIfacesLocked();
                this.mWakeLock.release();
            } catch (Throwable th) {
                this.mWakeLock.release();
            }
        }
    }

    private void updateIfacesLocked() {
        if (this.mSystemReady) {
            performPollLocked(MSG_PERFORM_POLL);
            try {
                NetworkState[] states = this.mConnManager.getAllNetworkState();
                LinkProperties activeLink = this.mConnManager.getActiveLinkProperties();
                this.mActiveIface = activeLink != null ? activeLink.getInterfaceName() : null;
                this.mActiveIfaces.clear();
                this.mActiveUidIfaces.clear();
                ArraySet<String> mobileIfaces = new ArraySet();
                NetworkState[] arr$ = states;
                int len$ = arr$.length;
                for (int i = 0; i < len$; i += MSG_PERFORM_POLL) {
                    NetworkState state = arr$[i];
                    if (state.networkInfo.isConnected()) {
                        boolean isMobile = ConnectivityManager.isNetworkTypeMobile(state.networkInfo.getType());
                        NetworkIdentity ident = NetworkIdentity.buildNetworkIdentity(this.mContext, state);
                        String baseIface = state.linkProperties.getInterfaceName();
                        if (baseIface != null) {
                            findOrCreateNetworkIdentitySet(this.mActiveIfaces, baseIface).add(ident);
                            findOrCreateNetworkIdentitySet(this.mActiveUidIfaces, baseIface).add(ident);
                            if (isMobile) {
                                mobileIfaces.add(baseIface);
                            }
                        }
                        for (LinkProperties stackedLink : state.linkProperties.getStackedLinks()) {
                            String stackedIface = stackedLink.getInterfaceName();
                            if (stackedIface != null) {
                                findOrCreateNetworkIdentitySet(this.mActiveUidIfaces, stackedIface).add(ident);
                                if (isMobile) {
                                    mobileIfaces.add(stackedIface);
                                }
                            }
                        }
                    }
                }
                this.mMobileIfaces = (String[]) mobileIfaces.toArray(new String[mobileIfaces.size()]);
            } catch (RemoteException e) {
            }
        }
    }

    private static <K> NetworkIdentitySet findOrCreateNetworkIdentitySet(ArrayMap<K, NetworkIdentitySet> map, K key) {
        NetworkIdentitySet ident = (NetworkIdentitySet) map.get(key);
        if (ident != null) {
            return ident;
        }
        ident = new NetworkIdentitySet();
        map.put(key, ident);
        return ident;
    }

    private void bootstrapStatsLocked() {
        long currentTime = this.mTime.hasCache() ? this.mTime.currentTimeMillis() : System.currentTimeMillis();
        try {
            NetworkStats uidSnapshot = getNetworkStatsUidDetail();
            NetworkStats xtSnapshot = this.mNetworkManager.getNetworkStatsSummaryXt();
            this.mDevRecorder.recordSnapshotLocked(this.mNetworkManager.getNetworkStatsSummaryDev(), this.mActiveIfaces, currentTime);
            this.mXtRecorder.recordSnapshotLocked(xtSnapshot, this.mActiveIfaces, currentTime);
            this.mUidRecorder.recordSnapshotLocked(uidSnapshot, this.mActiveUidIfaces, currentTime);
            this.mUidTagRecorder.recordSnapshotLocked(uidSnapshot, this.mActiveUidIfaces, currentTime);
        } catch (IllegalStateException e) {
            Slog.w(TAG, "problem reading network stats: " + e);
        } catch (RemoteException e2) {
        }
    }

    private void performPoll(int flags) {
        if (this.mTime.getCacheAge() > this.mSettings.getTimeCacheMaxAge()) {
            this.mTime.forceRefresh();
        }
        synchronized (this.mStatsLock) {
            this.mWakeLock.acquire();
            try {
                performPollLocked(flags);
                this.mWakeLock.release();
            } catch (Throwable th) {
                this.mWakeLock.release();
            }
        }
    }

    private void performPollLocked(int flags) {
        if (this.mSystemReady) {
            long startRealtime = SystemClock.elapsedRealtime();
            boolean persistNetwork = (flags & MSG_PERFORM_POLL) != 0 ? true : LOGV;
            boolean persistUid = (flags & MSG_UPDATE_IFACES) != 0 ? true : LOGV;
            boolean persistForce = (flags & FLAG_PERSIST_FORCE) != 0 ? true : LOGV;
            long currentTime = this.mTime.hasCache() ? this.mTime.currentTimeMillis() : System.currentTimeMillis();
            try {
                NetworkStats uidSnapshot = getNetworkStatsUidDetail();
                NetworkStats xtSnapshot = this.mNetworkManager.getNetworkStatsSummaryXt();
                this.mDevRecorder.recordSnapshotLocked(this.mNetworkManager.getNetworkStatsSummaryDev(), this.mActiveIfaces, currentTime);
                this.mXtRecorder.recordSnapshotLocked(xtSnapshot, this.mActiveIfaces, currentTime);
                this.mUidRecorder.recordSnapshotLocked(uidSnapshot, this.mActiveUidIfaces, currentTime);
                this.mUidTagRecorder.recordSnapshotLocked(uidSnapshot, this.mActiveUidIfaces, currentTime);
                if (persistForce) {
                    this.mDevRecorder.forcePersistLocked(currentTime);
                    this.mXtRecorder.forcePersistLocked(currentTime);
                    this.mUidRecorder.forcePersistLocked(currentTime);
                    this.mUidTagRecorder.forcePersistLocked(currentTime);
                } else {
                    if (persistNetwork) {
                        this.mDevRecorder.maybePersistLocked(currentTime);
                        this.mXtRecorder.maybePersistLocked(currentTime);
                    }
                    if (persistUid) {
                        this.mUidRecorder.maybePersistLocked(currentTime);
                        this.mUidTagRecorder.maybePersistLocked(currentTime);
                    }
                }
                if (this.mSettings.getSampleEnabled()) {
                    performSampleLocked();
                }
                Intent updatedIntent = new Intent(ACTION_NETWORK_STATS_UPDATED);
                updatedIntent.setFlags(1073741824);
                this.mContext.sendBroadcastAsUser(updatedIntent, UserHandle.ALL, "android.permission.READ_NETWORK_USAGE_HISTORY");
            } catch (IllegalStateException e) {
                Log.wtf(TAG, "problem reading network stats", e);
            } catch (RemoteException e2) {
            }
        }
    }

    private void performSampleLocked() {
        long trustedTime = this.mTime.hasCache() ? this.mTime.currentTimeMillis() : -1;
        NetworkTemplate template = NetworkTemplate.buildTemplateMobileWildcard();
        Entry devTotal = this.mDevRecorder.getTotalSinceBootLocked(template);
        Entry xtTotal = this.mXtRecorder.getTotalSinceBootLocked(template);
        Entry uidTotal = this.mUidRecorder.getTotalSinceBootLocked(template);
        EventLogTags.writeNetstatsMobileSample(devTotal.rxBytes, devTotal.rxPackets, devTotal.txBytes, devTotal.txPackets, xtTotal.rxBytes, xtTotal.rxPackets, xtTotal.txBytes, xtTotal.txPackets, uidTotal.rxBytes, uidTotal.rxPackets, uidTotal.txBytes, uidTotal.txPackets, trustedTime);
        template = NetworkTemplate.buildTemplateWifiWildcard();
        devTotal = this.mDevRecorder.getTotalSinceBootLocked(template);
        xtTotal = this.mXtRecorder.getTotalSinceBootLocked(template);
        uidTotal = this.mUidRecorder.getTotalSinceBootLocked(template);
        EventLogTags.writeNetstatsWifiSample(devTotal.rxBytes, devTotal.rxPackets, devTotal.txBytes, devTotal.txPackets, xtTotal.rxBytes, xtTotal.rxPackets, xtTotal.txBytes, xtTotal.txPackets, uidTotal.rxBytes, uidTotal.rxPackets, uidTotal.txBytes, uidTotal.txPackets, trustedTime);
    }

    private void removeUidsLocked(int... uids) {
        performPollLocked(MSG_REGISTER_GLOBAL_ALERT);
        this.mUidRecorder.removeUidsLocked(uids);
        this.mUidTagRecorder.removeUidsLocked(uids);
        int[] arr$ = uids;
        int len$ = arr$.length;
        for (int i$ = 0; i$ < len$; i$ += MSG_PERFORM_POLL) {
            NetworkManagementSocketTagger.resetKernelUidStats(arr$[i$]);
        }
    }

    private void removeUserLocked(int userId) {
        int[] uids = new int[0];
        for (ApplicationInfo app : this.mContext.getPackageManager().getInstalledApplications(8704)) {
            uids = ArrayUtils.appendInt(uids, UserHandle.getUid(userId, app.uid));
        }
        removeUidsLocked(uids);
    }

    protected void dump(FileDescriptor fd, PrintWriter rawWriter, String[] args) {
        this.mContext.enforceCallingOrSelfPermission("android.permission.DUMP", TAG);
        long duration = 86400000;
        HashSet<String> argSet = new HashSet();
        String[] arr$ = args;
        int len$ = arr$.length;
        for (int i$ = 0; i$ < len$; i$ += MSG_PERFORM_POLL) {
            String arg = arr$[i$];
            argSet.add(arg);
            if (arg.startsWith("--duration=")) {
                try {
                    duration = Long.parseLong(arg.substring(11));
                } catch (NumberFormatException e) {
                }
            }
        }
        boolean poll = (argSet.contains("--poll") || argSet.contains("poll")) ? true : LOGV;
        boolean checkin = argSet.contains("--checkin");
        boolean fullHistory = (argSet.contains("--full") || argSet.contains("full")) ? true : LOGV;
        boolean includeUid = (argSet.contains("--uid") || argSet.contains("detail")) ? true : LOGV;
        boolean includeTag = (argSet.contains("--tag") || argSet.contains("detail")) ? true : LOGV;
        IndentingPrintWriter indentingPrintWriter = new IndentingPrintWriter(rawWriter, "  ");
        synchronized (this.mStatsLock) {
            if (poll) {
                performPollLocked(259);
                indentingPrintWriter.println("Forced poll");
                return;
            } else if (checkin) {
                long end = System.currentTimeMillis();
                long start = end - duration;
                indentingPrintWriter.print("v1,");
                indentingPrintWriter.print(start / 1000);
                indentingPrintWriter.print(',');
                indentingPrintWriter.print(end / 1000);
                indentingPrintWriter.println();
                indentingPrintWriter.println(PREFIX_XT);
                this.mXtRecorder.dumpCheckin(rawWriter, start, end);
                if (includeUid) {
                    indentingPrintWriter.println(PREFIX_UID);
                    this.mUidRecorder.dumpCheckin(rawWriter, start, end);
                }
                if (includeTag) {
                    indentingPrintWriter.println("tag");
                    this.mUidTagRecorder.dumpCheckin(rawWriter, start, end);
                }
                return;
            } else {
                int i;
                indentingPrintWriter.println("Active interfaces:");
                indentingPrintWriter.increaseIndent();
                for (i = 0; i < this.mActiveIfaces.size(); i += MSG_PERFORM_POLL) {
                    indentingPrintWriter.printPair("iface", this.mActiveIfaces.keyAt(i));
                    indentingPrintWriter.printPair("ident", this.mActiveIfaces.valueAt(i));
                    indentingPrintWriter.println();
                }
                indentingPrintWriter.decreaseIndent();
                indentingPrintWriter.println("Active UID interfaces:");
                indentingPrintWriter.increaseIndent();
                for (i = 0; i < this.mActiveUidIfaces.size(); i += MSG_PERFORM_POLL) {
                    indentingPrintWriter.printPair("iface", this.mActiveUidIfaces.keyAt(i));
                    indentingPrintWriter.printPair("ident", this.mActiveUidIfaces.valueAt(i));
                    indentingPrintWriter.println();
                }
                indentingPrintWriter.decreaseIndent();
                indentingPrintWriter.println("Dev stats:");
                indentingPrintWriter.increaseIndent();
                this.mDevRecorder.dumpLocked(indentingPrintWriter, fullHistory);
                indentingPrintWriter.decreaseIndent();
                indentingPrintWriter.println("Xt stats:");
                indentingPrintWriter.increaseIndent();
                this.mXtRecorder.dumpLocked(indentingPrintWriter, fullHistory);
                indentingPrintWriter.decreaseIndent();
                if (includeUid) {
                    indentingPrintWriter.println("UID stats:");
                    indentingPrintWriter.increaseIndent();
                    this.mUidRecorder.dumpLocked(indentingPrintWriter, fullHistory);
                    indentingPrintWriter.decreaseIndent();
                }
                if (includeTag) {
                    indentingPrintWriter.println("UID tag stats:");
                    indentingPrintWriter.increaseIndent();
                    this.mUidTagRecorder.dumpLocked(indentingPrintWriter, fullHistory);
                    indentingPrintWriter.decreaseIndent();
                }
                return;
            }
        }
    }

    private NetworkStats getNetworkStatsUidDetail() throws RemoteException {
        NetworkStats uidSnapshot = this.mNetworkManager.getNetworkStatsUidDetail(-1);
        uidSnapshot.combineAllValues(getNetworkStatsTethering());
        uidSnapshot.combineAllValues(this.mUidOperations);
        return uidSnapshot;
    }

    private NetworkStats getNetworkStatsTethering() throws RemoteException {
        try {
            return this.mNetworkManager.getNetworkStatsTethering();
        } catch (IllegalStateException e) {
            Log.wtf(TAG, "problem reading network stats", e);
            return new NetworkStats(0, 10);
        }
    }

    private void assertBandwidthControlEnabled() {
        if (!isBandwidthControlEnabled()) {
            throw new IllegalStateException("Bandwidth module disabled");
        }
    }

    private boolean isBandwidthControlEnabled() {
        boolean isBandwidthControlEnabled;
        long token = Binder.clearCallingIdentity();
        try {
            isBandwidthControlEnabled = this.mNetworkManager.isBandwidthControlEnabled();
        } catch (RemoteException e) {
            isBandwidthControlEnabled = LOGV;
        } finally {
            Binder.restoreCallingIdentity(token);
        }
        return isBandwidthControlEnabled;
    }
}
