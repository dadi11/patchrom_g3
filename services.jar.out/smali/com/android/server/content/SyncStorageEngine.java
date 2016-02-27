package com.android.server.content;

import android.accounts.Account;
import android.accounts.AccountAndUser;
import android.content.ComponentName;
import android.content.ContentResolver;
import android.content.Context;
import android.content.ISyncStatusObserver;
import android.content.PeriodicSync;
import android.content.SyncInfo;
import android.content.SyncRequest.Builder;
import android.content.SyncStatusInfo;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteException;
import android.database.sqlite.SQLiteQueryBuilder;
import android.os.Bundle;
import android.os.Environment;
import android.os.Handler;
import android.os.Message;
import android.os.Parcel;
import android.os.Process;
import android.os.RemoteCallbackList;
import android.util.ArrayMap;
import android.util.AtomicFile;
import android.util.Log;
import android.util.Pair;
import android.util.SparseArray;
import android.util.Xml;
import com.android.internal.util.FastXmlSerializer;
import com.android.server.voiceinteraction.DatabaseHelper.SoundModelContract;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.util.TimeZone;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlSerializer;

public class SyncStorageEngine extends Handler {
    private static final int ACCOUNTS_VERSION = 2;
    private static final double DEFAULT_FLEX_PERCENT_SYNC = 0.04d;
    private static final long DEFAULT_MIN_FLEX_ALLOWED_SECS = 5;
    private static final long DEFAULT_POLL_FREQUENCY_SECONDS = 86400;
    public static final String[] EVENTS;
    public static final int EVENT_START = 0;
    public static final int EVENT_STOP = 1;
    public static final int MAX_HISTORY = 100;
    public static final String MESG_CANCELED = "canceled";
    public static final String MESG_SUCCESS = "success";
    static final long MILLIS_IN_4WEEKS = 2419200000L;
    private static final int MSG_WRITE_STATISTICS = 2;
    private static final int MSG_WRITE_STATUS = 1;
    public static final long NOT_IN_BACKOFF_MODE = -1;
    private static final int PENDING_FINISH_TO_WRITE = 4;
    public static final int PENDING_OPERATION_VERSION = 3;
    public static final String[] SOURCES;
    public static final int SOURCE_LOCAL = 1;
    public static final int SOURCE_PERIODIC = 4;
    public static final int SOURCE_POLL = 2;
    public static final int SOURCE_SERVER = 0;
    public static final int SOURCE_SERVICE = 5;
    public static final int SOURCE_USER = 3;
    public static final int STATISTICS_FILE_END = 0;
    public static final int STATISTICS_FILE_ITEM = 101;
    public static final int STATISTICS_FILE_ITEM_OLD = 100;
    public static final int STATUS_FILE_END = 0;
    public static final int STATUS_FILE_ITEM = 100;
    private static final boolean SYNC_ENABLED_DEFAULT = false;
    private static final String TAG = "SyncManager";
    private static final String TAG_FILE = "SyncManagerFile";
    private static final long WRITE_STATISTICS_DELAY = 1800000;
    private static final long WRITE_STATUS_DELAY = 600000;
    private static final String XML_ATTR_AUTHORITYID = "authority_id";
    private static final String XML_ATTR_ENABLED = "enabled";
    private static final String XML_ATTR_EXPEDITED = "expedited";
    private static final String XML_ATTR_LISTEN_FOR_TICKLES = "listen-for-tickles";
    private static final String XML_ATTR_NEXT_AUTHORITY_ID = "nextAuthorityId";
    private static final String XML_ATTR_REASON = "reason";
    private static final String XML_ATTR_SOURCE = "source";
    private static final String XML_ATTR_SYNC_RANDOM_OFFSET = "offsetInSeconds";
    private static final String XML_ATTR_USER = "user";
    private static final String XML_ATTR_VERSION = "version";
    private static final String XML_TAG_LISTEN_FOR_TICKLES = "listenForTickles";
    private static HashMap<String, String> sAuthorityRenames;
    private static volatile SyncStorageEngine sSyncStorageEngine;
    private final AtomicFile mAccountInfoFile;
    private final HashMap<AccountAndUser, AccountInfo> mAccounts;
    private final SparseArray<AuthorityInfo> mAuthorities;
    private final Calendar mCal;
    private final RemoteCallbackList<ISyncStatusObserver> mChangeListeners;
    private final Context mContext;
    private final SparseArray<ArrayList<SyncInfo>> mCurrentSyncs;
    private final DayStats[] mDayStats;
    private boolean mDefaultMasterSyncAutomatically;
    private SparseArray<Boolean> mMasterSyncAutomatically;
    private int mNextAuthorityId;
    private int mNextHistoryId;
    private int mNumPendingFinished;
    private final AtomicFile mPendingFile;
    private final ArrayList<PendingOperation> mPendingOperations;
    private final ArrayMap<ComponentName, SparseArray<AuthorityInfo>> mServices;
    private final AtomicFile mStatisticsFile;
    private final AtomicFile mStatusFile;
    private final ArrayList<SyncHistoryItem> mSyncHistory;
    private int mSyncRandomOffset;
    private OnSyncRequestListener mSyncRequestListener;
    private final SparseArray<SyncStatusInfo> mSyncStatus;
    private int mYear;
    private int mYearInDays;

    interface OnSyncRequestListener {
        void onSyncRequest(EndPoint endPoint, int i, Bundle bundle);
    }

    static class AccountInfo {
        final AccountAndUser accountAndUser;
        final HashMap<String, AuthorityInfo> authorities;

        AccountInfo(AccountAndUser accountAndUser) {
            this.authorities = new HashMap();
            this.accountAndUser = accountAndUser;
        }
    }

    public static class AuthorityInfo {
        long backoffDelay;
        long backoffTime;
        long delayUntil;
        boolean enabled;
        final int ident;
        final ArrayList<PeriodicSync> periodicSyncs;
        int syncable;
        final EndPoint target;

        AuthorityInfo(AuthorityInfo toCopy) {
            this.target = toCopy.target;
            this.ident = toCopy.ident;
            this.enabled = toCopy.enabled;
            this.syncable = toCopy.syncable;
            this.backoffTime = toCopy.backoffTime;
            this.backoffDelay = toCopy.backoffDelay;
            this.delayUntil = toCopy.delayUntil;
            this.periodicSyncs = new ArrayList();
            Iterator i$ = toCopy.periodicSyncs.iterator();
            while (i$.hasNext()) {
                this.periodicSyncs.add(new PeriodicSync((PeriodicSync) i$.next()));
            }
        }

        AuthorityInfo(EndPoint info, int id) {
            this.target = info;
            this.ident = id;
            this.enabled = info.target_provider ? SyncStorageEngine.SYNC_ENABLED_DEFAULT : true;
            if (info.target_service) {
                this.syncable = SyncStorageEngine.SOURCE_LOCAL;
            }
            this.periodicSyncs = new ArrayList();
            defaultInitialisation();
        }

        private void defaultInitialisation() {
            this.syncable = -1;
            this.backoffTime = SyncStorageEngine.NOT_IN_BACKOFF_MODE;
            this.backoffDelay = SyncStorageEngine.NOT_IN_BACKOFF_MODE;
            if (this.target.target_provider) {
                this.periodicSyncs.add(new PeriodicSync(this.target.account, this.target.provider, new Bundle(), SyncStorageEngine.DEFAULT_POLL_FREQUENCY_SECONDS, SyncStorageEngine.calculateDefaultFlexTime(SyncStorageEngine.DEFAULT_POLL_FREQUENCY_SECONDS)));
            }
        }

        public String toString() {
            return this.target + ", enabled=" + this.enabled + ", syncable=" + this.syncable + ", backoff=" + this.backoffTime + ", delay=" + this.delayUntil;
        }
    }

    public static class DayStats {
        public final int day;
        public int failureCount;
        public long failureTime;
        public int successCount;
        public long successTime;

        public DayStats(int day) {
            this.day = day;
        }
    }

    public static class EndPoint {
        public static final EndPoint USER_ALL_PROVIDER_ALL_ACCOUNTS_ALL;
        final Account account;
        final String provider;
        final ComponentName service;
        final boolean target_provider;
        final boolean target_service;
        final int userId;

        static {
            USER_ALL_PROVIDER_ALL_ACCOUNTS_ALL = new EndPoint(null, null, -1);
        }

        public EndPoint(ComponentName service, int userId) {
            this.service = service;
            this.userId = userId;
            this.account = null;
            this.provider = null;
            this.target_service = true;
            this.target_provider = SyncStorageEngine.SYNC_ENABLED_DEFAULT;
        }

        public EndPoint(Account account, String provider, int userId) {
            this.account = account;
            this.provider = provider;
            this.userId = userId;
            this.service = null;
            this.target_service = SyncStorageEngine.SYNC_ENABLED_DEFAULT;
            this.target_provider = true;
        }

        public boolean matchesSpec(EndPoint spec) {
            if (this.userId != spec.userId && this.userId != -1 && spec.userId != -1) {
                return SyncStorageEngine.SYNC_ENABLED_DEFAULT;
            }
            if (this.target_service && spec.target_service) {
                return this.service.equals(spec.service);
            }
            if (!this.target_provider || !spec.target_provider) {
                return SyncStorageEngine.SYNC_ENABLED_DEFAULT;
            }
            boolean accountsMatch;
            if (spec.account == null) {
                accountsMatch = true;
            } else {
                accountsMatch = this.account.equals(spec.account);
            }
            boolean providersMatch;
            if (spec.provider == null) {
                providersMatch = true;
            } else {
                providersMatch = this.provider.equals(spec.provider);
            }
            if (accountsMatch && providersMatch) {
                return true;
            }
            return SyncStorageEngine.SYNC_ENABLED_DEFAULT;
        }

        public String toString() {
            StringBuilder sb = new StringBuilder();
            if (this.target_provider) {
                sb.append(this.account == null ? "ALL ACCS" : this.account.name).append("/").append(this.provider == null ? "ALL PDRS" : this.provider);
            } else if (this.target_service) {
                sb.append(this.service.getPackageName() + "/").append(this.service.getClassName());
            } else {
                sb.append("invalid target");
            }
            sb.append(":u" + this.userId);
            return sb.toString();
        }
    }

    public static class PendingOperation {
        final int authorityId;
        final boolean expedited;
        final Bundle extras;
        byte[] flatExtras;
        final int reason;
        final int syncSource;
        final EndPoint target;

        PendingOperation(AuthorityInfo authority, int reason, int source, Bundle extras, boolean expedited) {
            this.target = authority.target;
            this.syncSource = source;
            this.reason = reason;
            if (extras != null) {
                extras = new Bundle(extras);
            }
            this.extras = extras;
            this.expedited = expedited;
            this.authorityId = authority.ident;
        }

        PendingOperation(PendingOperation other) {
            this.reason = other.reason;
            this.syncSource = other.syncSource;
            this.target = other.target;
            this.extras = other.extras;
            this.authorityId = other.authorityId;
            this.expedited = other.expedited;
        }

        public boolean equals(PendingOperation other) {
            return this.target.matchesSpec(other.target);
        }

        public String toString() {
            return "service=" + this.target.service + " user=" + this.target.userId + " auth=" + this.target + " account=" + this.target.account + " src=" + this.syncSource + " extras=" + this.extras;
        }
    }

    public static class SyncHistoryItem {
        int authorityId;
        long downstreamActivity;
        long elapsedTime;
        int event;
        long eventTime;
        Bundle extras;
        int historyId;
        boolean initialization;
        String mesg;
        int reason;
        int source;
        long upstreamActivity;
    }

    static {
        String[] strArr = new String[SOURCE_POLL];
        strArr[STATUS_FILE_END] = "START";
        strArr[SOURCE_LOCAL] = "STOP";
        EVENTS = strArr;
        SOURCES = new String[]{"SERVER", "LOCAL", "POLL", "USER", "PERIODIC", "SERVICE"};
        sAuthorityRenames = new HashMap();
        sAuthorityRenames.put("contacts", "com.android.contacts");
        sAuthorityRenames.put("calendar", "com.android.calendar");
        sSyncStorageEngine = null;
    }

    private SyncStorageEngine(Context context, File dataDir) {
        this.mAuthorities = new SparseArray();
        this.mAccounts = new HashMap();
        this.mPendingOperations = new ArrayList();
        this.mCurrentSyncs = new SparseArray();
        this.mSyncStatus = new SparseArray();
        this.mSyncHistory = new ArrayList();
        this.mChangeListeners = new RemoteCallbackList();
        this.mServices = new ArrayMap();
        this.mNextAuthorityId = STATUS_FILE_END;
        this.mDayStats = new DayStats[28];
        this.mNumPendingFinished = STATUS_FILE_END;
        this.mNextHistoryId = STATUS_FILE_END;
        this.mMasterSyncAutomatically = new SparseArray();
        this.mContext = context;
        sSyncStorageEngine = this;
        this.mCal = Calendar.getInstance(TimeZone.getTimeZone("GMT+0"));
        this.mDefaultMasterSyncAutomatically = this.mContext.getResources().getBoolean(17956973);
        File syncDir = new File(new File(dataDir, "system"), "sync");
        syncDir.mkdirs();
        maybeDeleteLegacyPendingInfoLocked(syncDir);
        this.mAccountInfoFile = new AtomicFile(new File(syncDir, "accounts.xml"));
        this.mStatusFile = new AtomicFile(new File(syncDir, "status.bin"));
        this.mPendingFile = new AtomicFile(new File(syncDir, "pending.xml"));
        this.mStatisticsFile = new AtomicFile(new File(syncDir, "stats.bin"));
        readAccountInfoLocked();
        readStatusLocked();
        readPendingOperationsLocked();
        readStatisticsLocked();
        readAndDeleteLegacyAccountInfoLocked();
        writeAccountInfoLocked();
        writeStatusLocked();
        writePendingOperationsLocked();
        writeStatisticsLocked();
    }

    public static SyncStorageEngine newTestInstance(Context context) {
        return new SyncStorageEngine(context, context.getFilesDir());
    }

    public static void init(Context context) {
        if (sSyncStorageEngine == null) {
            sSyncStorageEngine = new SyncStorageEngine(context, Environment.getSecureDataDirectory());
        }
    }

    public static SyncStorageEngine getSingleton() {
        if (sSyncStorageEngine != null) {
            return sSyncStorageEngine;
        }
        throw new IllegalStateException("not initialized");
    }

    protected void setOnSyncRequestListener(OnSyncRequestListener listener) {
        if (this.mSyncRequestListener == null) {
            this.mSyncRequestListener = listener;
        }
    }

    public void handleMessage(Message msg) {
        if (msg.what == SOURCE_LOCAL) {
            synchronized (this.mAuthorities) {
                writeStatusLocked();
            }
        } else if (msg.what == SOURCE_POLL) {
            synchronized (this.mAuthorities) {
                writeStatisticsLocked();
            }
        }
    }

    public int getSyncRandomOffset() {
        return this.mSyncRandomOffset;
    }

    public void addStatusChangeListener(int mask, ISyncStatusObserver callback) {
        synchronized (this.mAuthorities) {
            this.mChangeListeners.register(callback, Integer.valueOf(mask));
        }
    }

    public void removeStatusChangeListener(ISyncStatusObserver callback) {
        synchronized (this.mAuthorities) {
            this.mChangeListeners.unregister(callback);
        }
    }

    public static long calculateDefaultFlexTime(long syncTimeSeconds) {
        if (syncTimeSeconds < DEFAULT_MIN_FLEX_ALLOWED_SECS) {
            return 0;
        }
        if (syncTimeSeconds < DEFAULT_POLL_FREQUENCY_SECONDS) {
            return (long) (((double) syncTimeSeconds) * DEFAULT_FLEX_PERCENT_SYNC);
        }
        return 3456;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void reportChange(int r8) {
        /*
        r7 = this;
        r2 = 0;
        r5 = r7.mAuthorities;
        monitor-enter(r5);
        r4 = r7.mChangeListeners;	 Catch:{ all -> 0x0077 }
        r0 = r4.beginBroadcast();	 Catch:{ all -> 0x0077 }
        r3 = r2;
    L_0x000b:
        if (r0 <= 0) goto L_0x0030;
    L_0x000d:
        r0 = r0 + -1;
        r4 = r7.mChangeListeners;	 Catch:{ all -> 0x007b }
        r1 = r4.getBroadcastCookie(r0);	 Catch:{ all -> 0x007b }
        r1 = (java.lang.Integer) r1;	 Catch:{ all -> 0x007b }
        r4 = r1.intValue();	 Catch:{ all -> 0x007b }
        r4 = r4 & r8;
        if (r4 == 0) goto L_0x000b;
    L_0x001e:
        if (r3 != 0) goto L_0x007e;
    L_0x0020:
        r2 = new java.util.ArrayList;	 Catch:{ all -> 0x007b }
        r2.<init>(r0);	 Catch:{ all -> 0x007b }
    L_0x0025:
        r4 = r7.mChangeListeners;	 Catch:{ all -> 0x0077 }
        r4 = r4.getBroadcastItem(r0);	 Catch:{ all -> 0x0077 }
        r2.add(r4);	 Catch:{ all -> 0x0077 }
        r3 = r2;
        goto L_0x000b;
    L_0x0030:
        r4 = r7.mChangeListeners;	 Catch:{ all -> 0x007b }
        r4.finishBroadcast();	 Catch:{ all -> 0x007b }
        monitor-exit(r5);	 Catch:{ all -> 0x007b }
        r4 = "SyncManager";
        r5 = 2;
        r4 = android.util.Log.isLoggable(r4, r5);
        if (r4 == 0) goto L_0x0061;
    L_0x003f:
        r4 = "SyncManager";
        r5 = new java.lang.StringBuilder;
        r5.<init>();
        r6 = "reportChange ";
        r5 = r5.append(r6);
        r5 = r5.append(r8);
        r6 = " to: ";
        r5 = r5.append(r6);
        r5 = r5.append(r3);
        r5 = r5.toString();
        android.util.Log.v(r4, r5);
    L_0x0061:
        if (r3 == 0) goto L_0x007a;
    L_0x0063:
        r0 = r3.size();
    L_0x0067:
        if (r0 <= 0) goto L_0x007a;
    L_0x0069:
        r0 = r0 + -1;
        r4 = r3.get(r0);	 Catch:{ RemoteException -> 0x0075 }
        r4 = (android.content.ISyncStatusObserver) r4;	 Catch:{ RemoteException -> 0x0075 }
        r4.onStatusChanged(r8);	 Catch:{ RemoteException -> 0x0075 }
        goto L_0x0067;
    L_0x0075:
        r4 = move-exception;
        goto L_0x0067;
    L_0x0077:
        r4 = move-exception;
    L_0x0078:
        monitor-exit(r5);	 Catch:{ all -> 0x0077 }
        throw r4;
    L_0x007a:
        return;
    L_0x007b:
        r4 = move-exception;
        r2 = r3;
        goto L_0x0078;
    L_0x007e:
        r2 = r3;
        goto L_0x0025;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.content.SyncStorageEngine.reportChange(int):void");
    }

    public boolean getSyncAutomatically(Account account, int userId, String providerName) {
        boolean z = true;
        synchronized (this.mAuthorities) {
            if (account != null) {
                AuthorityInfo authority = getAuthorityLocked(new EndPoint(account, providerName, userId), "getSyncAutomatically");
                if (authority == null || !authority.enabled) {
                    z = SYNC_ENABLED_DEFAULT;
                }
                return z;
            }
            int i = this.mAuthorities.size();
            while (i > 0) {
                i--;
                AuthorityInfo authorityInfo = (AuthorityInfo) this.mAuthorities.valueAt(i);
                if (authorityInfo.target.matchesSpec(new EndPoint(account, providerName, userId)) && authorityInfo.enabled) {
                    return true;
                }
            }
            return SYNC_ENABLED_DEFAULT;
        }
    }

    public void setSyncAutomatically(Account account, int userId, String providerName, boolean sync) {
        if (Log.isLoggable(TAG, SOURCE_POLL)) {
            Log.d(TAG, "setSyncAutomatically:  provider " + providerName + ", user " + userId + " -> " + sync);
        }
        synchronized (this.mAuthorities) {
            AuthorityInfo authority = getOrCreateAuthorityLocked(new EndPoint(account, providerName, userId), -1, SYNC_ENABLED_DEFAULT);
            if (authority.enabled == sync) {
                if (Log.isLoggable(TAG, SOURCE_POLL)) {
                    Log.d(TAG, "setSyncAutomatically: already set to " + sync + ", doing nothing");
                }
                return;
            }
            authority.enabled = sync;
            writeAccountInfoLocked();
            if (sync) {
                requestSync(account, userId, -6, providerName, new Bundle());
            }
            reportChange(SOURCE_LOCAL);
        }
    }

    public int getIsSyncable(Account account, int userId, String providerName) {
        int i = -1;
        synchronized (this.mAuthorities) {
            if (account != null) {
                AuthorityInfo authority = getAuthorityLocked(new EndPoint(account, providerName, userId), "get authority syncable");
                if (authority == null) {
                } else {
                    i = authority.syncable;
                }
            } else {
                int i2 = this.mAuthorities.size();
                while (i2 > 0) {
                    i2--;
                    AuthorityInfo authorityInfo = (AuthorityInfo) this.mAuthorities.valueAt(i2);
                    if (authorityInfo.target != null && authorityInfo.target.provider.equals(providerName)) {
                        i = authorityInfo.syncable;
                        break;
                    }
                }
            }
        }
        return i;
    }

    public void setIsSyncable(Account account, int userId, String providerName, int syncable) {
        setSyncableStateForEndPoint(new EndPoint(account, providerName, userId), syncable);
    }

    public boolean getIsTargetServiceActive(ComponentName cname, int userId) {
        boolean z = SYNC_ENABLED_DEFAULT;
        synchronized (this.mAuthorities) {
            if (cname != null) {
                AuthorityInfo authority = getAuthorityLocked(new EndPoint(cname, userId), "get service active");
                if (authority == null) {
                } else {
                    if (authority.syncable == SOURCE_LOCAL) {
                        z = true;
                    }
                }
            }
        }
        return z;
    }

    public void setIsTargetServiceActive(ComponentName cname, int userId, boolean active) {
        setSyncableStateForEndPoint(new EndPoint(cname, userId), active ? SOURCE_LOCAL : STATUS_FILE_END);
    }

    private void setSyncableStateForEndPoint(EndPoint target, int syncable) {
        synchronized (this.mAuthorities) {
            AuthorityInfo aInfo = getOrCreateAuthorityLocked(target, -1, SYNC_ENABLED_DEFAULT);
            if (syncable > SOURCE_LOCAL) {
                syncable = SOURCE_LOCAL;
            } else if (syncable < -1) {
                syncable = -1;
            }
            if (Log.isLoggable(TAG, SOURCE_POLL)) {
                Log.d(TAG, "setIsSyncable: " + aInfo.toString() + " -> " + syncable);
            }
            if (aInfo.syncable == syncable) {
                if (Log.isLoggable(TAG, SOURCE_POLL)) {
                    Log.d(TAG, "setIsSyncable: already set to " + syncable + ", doing nothing");
                }
                return;
            }
            aInfo.syncable = syncable;
            writeAccountInfoLocked();
            if (syncable > 0) {
                requestSync(aInfo, -5, new Bundle());
            }
            reportChange(SOURCE_LOCAL);
        }
    }

    public Pair<Long, Long> getBackoff(EndPoint info) {
        Pair<Long, Long> create;
        synchronized (this.mAuthorities) {
            AuthorityInfo authority = getAuthorityLocked(info, "getBackoff");
            if (authority != null) {
                create = Pair.create(Long.valueOf(authority.backoffTime), Long.valueOf(authority.backoffDelay));
            } else {
                create = null;
            }
        }
        return create;
    }

    public void setBackoff(EndPoint info, long nextSyncTime, long nextDelay) {
        boolean changed;
        if (Log.isLoggable(TAG, SOURCE_POLL)) {
            Log.v(TAG, "setBackoff: " + info + " -> nextSyncTime " + nextSyncTime + ", nextDelay " + nextDelay);
        }
        synchronized (this.mAuthorities) {
            if (info.target_provider && (info.account == null || info.provider == null)) {
                changed = setBackoffLocked(info.account, info.userId, info.provider, nextSyncTime, nextDelay);
            } else {
                AuthorityInfo authorityInfo = getOrCreateAuthorityLocked(info, -1, true);
                if (authorityInfo.backoffTime == nextSyncTime && authorityInfo.backoffDelay == nextDelay) {
                    changed = SYNC_ENABLED_DEFAULT;
                } else {
                    authorityInfo.backoffTime = nextSyncTime;
                    authorityInfo.backoffDelay = nextDelay;
                    changed = true;
                }
            }
        }
        if (changed) {
            reportChange(SOURCE_LOCAL);
        }
    }

    private boolean setBackoffLocked(Account account, int userId, String providerName, long nextSyncTime, long nextDelay) {
        boolean changed = SYNC_ENABLED_DEFAULT;
        for (AccountInfo accountInfo : this.mAccounts.values()) {
            if (account == null || account.equals(accountInfo.accountAndUser.account) || userId == accountInfo.accountAndUser.userId) {
                for (AuthorityInfo authorityInfo : accountInfo.authorities.values()) {
                    if ((providerName == null || providerName.equals(authorityInfo.target.provider)) && !(authorityInfo.backoffTime == nextSyncTime && authorityInfo.backoffDelay == nextDelay)) {
                        authorityInfo.backoffTime = nextSyncTime;
                        authorityInfo.backoffDelay = nextDelay;
                        changed = true;
                    }
                }
            }
        }
        return changed;
    }

    public void clearAllBackoffsLocked(SyncQueue syncQueue) {
        boolean changed = SYNC_ENABLED_DEFAULT;
        synchronized (this.mAuthorities) {
            for (AccountInfo accountInfo : this.mAccounts.values()) {
                for (AuthorityInfo authorityInfo : accountInfo.authorities.values()) {
                    AuthorityInfo authorityInfo2;
                    if (authorityInfo2.backoffTime != NOT_IN_BACKOFF_MODE || authorityInfo2.backoffDelay != NOT_IN_BACKOFF_MODE) {
                        if (Log.isLoggable(TAG, SOURCE_POLL)) {
                            Log.v(TAG, "clearAllBackoffsLocked: authority:" + authorityInfo2.target + " account:" + accountInfo.accountAndUser.account.name + " user:" + accountInfo.accountAndUser.userId + " backoffTime was: " + authorityInfo2.backoffTime + " backoffDelay was: " + authorityInfo2.backoffDelay);
                        }
                        authorityInfo2.backoffTime = NOT_IN_BACKOFF_MODE;
                        authorityInfo2.backoffDelay = NOT_IN_BACKOFF_MODE;
                        changed = true;
                    }
                }
            }
            for (ComponentName service : this.mServices.keySet()) {
                SparseArray<AuthorityInfo> aInfos = (SparseArray) this.mServices.get(service);
                for (int i = STATUS_FILE_END; i < aInfos.size(); i += SOURCE_LOCAL) {
                    authorityInfo2 = (AuthorityInfo) aInfos.valueAt(i);
                    if (authorityInfo2.backoffTime != NOT_IN_BACKOFF_MODE || authorityInfo2.backoffDelay != NOT_IN_BACKOFF_MODE) {
                        authorityInfo2.backoffTime = NOT_IN_BACKOFF_MODE;
                        authorityInfo2.backoffDelay = NOT_IN_BACKOFF_MODE;
                    }
                }
                syncQueue.clearBackoffs();
            }
        }
        if (changed) {
            reportChange(SOURCE_LOCAL);
        }
    }

    public long getDelayUntilTime(EndPoint info) {
        long j;
        synchronized (this.mAuthorities) {
            AuthorityInfo authority = getAuthorityLocked(info, "getDelayUntil");
            if (authority == null) {
                j = 0;
            } else {
                j = authority.delayUntil;
            }
        }
        return j;
    }

    public void setDelayUntilTime(EndPoint info, long delayUntil) {
        if (Log.isLoggable(TAG, SOURCE_POLL)) {
            Log.v(TAG, "setDelayUntil: " + info + " -> delayUntil " + delayUntil);
        }
        synchronized (this.mAuthorities) {
            AuthorityInfo authority = getOrCreateAuthorityLocked(info, -1, true);
            if (authority.delayUntil == delayUntil) {
                return;
            }
            authority.delayUntil = delayUntil;
            reportChange(SOURCE_LOCAL);
        }
    }

    public void updateOrAddPeriodicSync(EndPoint info, long period, long flextime, Bundle extras) {
        if (Log.isLoggable(TAG, SOURCE_POLL)) {
            Log.v(TAG, "addPeriodicSync: " + info + " -> period " + period + ", flex " + flextime + ", extras " + extras.toString());
        }
        synchronized (this.mAuthorities) {
            if (period <= 0) {
                Log.e(TAG, "period < 0, should never happen in updateOrAddPeriodicSync");
            }
            if (extras == null) {
                Log.e(TAG, "null extras, should never happen in updateOrAddPeriodicSync:");
            }
            try {
                if (info.target_provider) {
                    PeriodicSync toUpdate = new PeriodicSync(info.account, info.provider, extras, period, flextime);
                    AuthorityInfo authority = getOrCreateAuthorityLocked(info, -1, SYNC_ENABLED_DEFAULT);
                    boolean alreadyPresent = SYNC_ENABLED_DEFAULT;
                    int i = STATUS_FILE_END;
                    int N = authority.periodicSyncs.size();
                    while (i < N) {
                        PeriodicSync syncInfo = (PeriodicSync) authority.periodicSyncs.get(i);
                        if (!SyncManager.syncExtrasEquals(syncInfo.extras, extras, true)) {
                            i += SOURCE_LOCAL;
                        } else if (period == syncInfo.period && flextime == syncInfo.flexTime) {
                            return;
                        } else {
                            authority.periodicSyncs.set(i, toUpdate);
                            alreadyPresent = true;
                            if (!alreadyPresent) {
                                authority.periodicSyncs.add(toUpdate);
                                getOrCreateSyncStatusLocked(authority.ident).setPeriodicSyncTime(authority.periodicSyncs.size() - 1, System.currentTimeMillis());
                            }
                            writeAccountInfoLocked();
                            writeStatusLocked();
                            reportChange(SOURCE_LOCAL);
                            return;
                        }
                    }
                    if (alreadyPresent) {
                        authority.periodicSyncs.add(toUpdate);
                        getOrCreateSyncStatusLocked(authority.ident).setPeriodicSyncTime(authority.periodicSyncs.size() - 1, System.currentTimeMillis());
                    }
                    writeAccountInfoLocked();
                    writeStatusLocked();
                    reportChange(SOURCE_LOCAL);
                    return;
                }
                writeAccountInfoLocked();
                writeStatusLocked();
            } finally {
                writeAccountInfoLocked();
                writeStatusLocked();
            }
        }
    }

    public void removePeriodicSync(EndPoint info, Bundle extras) {
        synchronized (this.mAuthorities) {
            try {
                AuthorityInfo authority = getOrCreateAuthorityLocked(info, -1, SYNC_ENABLED_DEFAULT);
                SyncStatusInfo status = (SyncStatusInfo) this.mSyncStatus.get(authority.ident);
                boolean changed = SYNC_ENABLED_DEFAULT;
                Iterator<PeriodicSync> iterator = authority.periodicSyncs.iterator();
                int i = STATUS_FILE_END;
                while (iterator.hasNext()) {
                    if (SyncManager.syncExtrasEquals(((PeriodicSync) iterator.next()).extras, extras, true)) {
                        iterator.remove();
                        changed = true;
                        if (status != null) {
                            status.removePeriodicSyncTime(i);
                        } else {
                            Log.e(TAG, "Tried removing sync status on remove periodic sync but did not find it.");
                        }
                    } else {
                        i += SOURCE_LOCAL;
                    }
                }
                if (changed) {
                    writeAccountInfoLocked();
                    writeStatusLocked();
                    reportChange(SOURCE_LOCAL);
                    return;
                }
                writeAccountInfoLocked();
                writeStatusLocked();
            } catch (Throwable th) {
                writeAccountInfoLocked();
                writeStatusLocked();
            }
        }
    }

    public List<PeriodicSync> getPeriodicSyncs(EndPoint info) {
        ArrayList<PeriodicSync> syncs;
        synchronized (this.mAuthorities) {
            AuthorityInfo authorityInfo = getAuthorityLocked(info, "getPeriodicSyncs");
            syncs = new ArrayList();
            if (authorityInfo != null) {
                Iterator i$ = authorityInfo.periodicSyncs.iterator();
                while (i$.hasNext()) {
                    syncs.add(new PeriodicSync((PeriodicSync) i$.next()));
                }
            }
        }
        return syncs;
    }

    public void setMasterSyncAutomatically(boolean flag, int userId) {
        synchronized (this.mAuthorities) {
            Boolean auto = (Boolean) this.mMasterSyncAutomatically.get(userId);
            if (auto == null || !auto.equals(Boolean.valueOf(flag))) {
                this.mMasterSyncAutomatically.put(userId, Boolean.valueOf(flag));
                writeAccountInfoLocked();
                if (flag) {
                    requestSync(null, userId, -7, null, new Bundle());
                }
                reportChange(SOURCE_LOCAL);
                this.mContext.sendBroadcast(ContentResolver.ACTION_SYNC_CONN_STATUS_CHANGED);
                return;
            }
        }
    }

    public boolean getMasterSyncAutomatically(int userId) {
        boolean booleanValue;
        synchronized (this.mAuthorities) {
            Boolean auto = (Boolean) this.mMasterSyncAutomatically.get(userId);
            booleanValue = auto == null ? this.mDefaultMasterSyncAutomatically : auto.booleanValue();
        }
        return booleanValue;
    }

    public AuthorityInfo getAuthority(int authorityId) {
        AuthorityInfo authorityInfo;
        synchronized (this.mAuthorities) {
            authorityInfo = (AuthorityInfo) this.mAuthorities.get(authorityId);
        }
        return authorityInfo;
    }

    public boolean isSyncActive(EndPoint info) {
        synchronized (this.mAuthorities) {
            for (SyncInfo syncInfo : getCurrentSyncs(info.userId)) {
                AuthorityInfo ainfo = getAuthority(syncInfo.authorityId);
                if (ainfo != null && ainfo.target.matchesSpec(info)) {
                    return true;
                }
            }
            return SYNC_ENABLED_DEFAULT;
        }
    }

    public PendingOperation insertIntoPending(SyncOperation op) {
        PendingOperation pendingOperation;
        synchronized (this.mAuthorities) {
            if (Log.isLoggable(TAG, SOURCE_POLL)) {
                Log.v(TAG, "insertIntoPending: authority=" + op.target + " extras=" + op.extras);
            }
            AuthorityInfo authority = getOrCreateAuthorityLocked(op.target, -1, true);
            if (authority == null) {
                pendingOperation = null;
            } else {
                pendingOperation = new PendingOperation(authority, op.reason, op.syncSource, op.extras, op.isExpedited());
                this.mPendingOperations.add(pendingOperation);
                appendPendingOperationLocked(pendingOperation);
                getOrCreateSyncStatusLocked(authority.ident).pending = true;
                reportChange(SOURCE_POLL);
            }
        }
        return pendingOperation;
    }

    public boolean deleteFromPending(PendingOperation op) {
        boolean res = SYNC_ENABLED_DEFAULT;
        synchronized (this.mAuthorities) {
            if (Log.isLoggable(TAG, SOURCE_POLL)) {
                Log.v(TAG, "deleteFromPending: account=" + op.toString());
            }
            if (this.mPendingOperations.remove(op)) {
                if (this.mPendingOperations.size() == 0 || this.mNumPendingFinished >= SOURCE_PERIODIC) {
                    writePendingOperationsLocked();
                    this.mNumPendingFinished = STATUS_FILE_END;
                } else {
                    this.mNumPendingFinished += SOURCE_LOCAL;
                }
                AuthorityInfo authority = getAuthorityLocked(op.target, "deleteFromPending");
                if (authority != null) {
                    if (Log.isLoggable(TAG, SOURCE_POLL)) {
                        Log.v(TAG, "removing - " + authority.toString());
                    }
                    int N = this.mPendingOperations.size();
                    boolean morePending = SYNC_ENABLED_DEFAULT;
                    for (int i = STATUS_FILE_END; i < N; i += SOURCE_LOCAL) {
                        if (((PendingOperation) this.mPendingOperations.get(i)).equals(op)) {
                            morePending = true;
                            break;
                        }
                    }
                    if (!morePending) {
                        if (Log.isLoggable(TAG, SOURCE_POLL)) {
                            Log.v(TAG, "no more pending!");
                        }
                        getOrCreateSyncStatusLocked(authority.ident).pending = SYNC_ENABLED_DEFAULT;
                    }
                }
                res = true;
            }
        }
        reportChange(SOURCE_POLL);
        return res;
    }

    public ArrayList<PendingOperation> getPendingOperations() {
        ArrayList<PendingOperation> arrayList;
        synchronized (this.mAuthorities) {
            arrayList = new ArrayList(this.mPendingOperations);
        }
        return arrayList;
    }

    public int getPendingOperationCount() {
        int size;
        synchronized (this.mAuthorities) {
            size = this.mPendingOperations.size();
        }
        return size;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void doDatabaseCleanup(android.accounts.Account[] r13, int r14) {
        /*
        r12 = this;
        r9 = r12.mAuthorities;
        monitor-enter(r9);
        r8 = "SyncManager";
        r10 = 2;
        r8 = android.util.Log.isLoggable(r8, r10);	 Catch:{ all -> 0x007d }
        if (r8 == 0) goto L_0x0013;
    L_0x000c:
        r8 = "SyncManager";
        r10 = "Updating for new accounts...";
        android.util.Log.v(r8, r10);	 Catch:{ all -> 0x007d }
    L_0x0013:
        r7 = new android.util.SparseArray;	 Catch:{ all -> 0x007d }
        r7.<init>();	 Catch:{ all -> 0x007d }
        r8 = r12.mAccounts;	 Catch:{ all -> 0x007d }
        r8 = r8.values();	 Catch:{ all -> 0x007d }
        r1 = r8.iterator();	 Catch:{ all -> 0x007d }
    L_0x0022:
        r8 = r1.hasNext();	 Catch:{ all -> 0x007d }
        if (r8 == 0) goto L_0x0084;
    L_0x0028:
        r0 = r1.next();	 Catch:{ all -> 0x007d }
        r0 = (com.android.server.content.SyncStorageEngine.AccountInfo) r0;	 Catch:{ all -> 0x007d }
        r8 = r0.accountAndUser;	 Catch:{ all -> 0x007d }
        r8 = r8.account;	 Catch:{ all -> 0x007d }
        r8 = com.android.internal.util.ArrayUtils.contains(r13, r8);	 Catch:{ all -> 0x007d }
        if (r8 != 0) goto L_0x0022;
    L_0x0038:
        r8 = r0.accountAndUser;	 Catch:{ all -> 0x007d }
        r8 = r8.userId;	 Catch:{ all -> 0x007d }
        if (r8 != r14) goto L_0x0022;
    L_0x003e:
        r8 = "SyncManager";
        r10 = 2;
        r8 = android.util.Log.isLoggable(r8, r10);	 Catch:{ all -> 0x007d }
        if (r8 == 0) goto L_0x0061;
    L_0x0047:
        r8 = "SyncManager";
        r10 = new java.lang.StringBuilder;	 Catch:{ all -> 0x007d }
        r10.<init>();	 Catch:{ all -> 0x007d }
        r11 = "Account removed: ";
        r10 = r10.append(r11);	 Catch:{ all -> 0x007d }
        r11 = r0.accountAndUser;	 Catch:{ all -> 0x007d }
        r10 = r10.append(r11);	 Catch:{ all -> 0x007d }
        r10 = r10.toString();	 Catch:{ all -> 0x007d }
        android.util.Log.v(r8, r10);	 Catch:{ all -> 0x007d }
    L_0x0061:
        r8 = r0.authorities;	 Catch:{ all -> 0x007d }
        r8 = r8.values();	 Catch:{ all -> 0x007d }
        r4 = r8.iterator();	 Catch:{ all -> 0x007d }
    L_0x006b:
        r8 = r4.hasNext();	 Catch:{ all -> 0x007d }
        if (r8 == 0) goto L_0x0080;
    L_0x0071:
        r2 = r4.next();	 Catch:{ all -> 0x007d }
        r2 = (com.android.server.content.SyncStorageEngine.AuthorityInfo) r2;	 Catch:{ all -> 0x007d }
        r8 = r2.ident;	 Catch:{ all -> 0x007d }
        r7.put(r8, r2);	 Catch:{ all -> 0x007d }
        goto L_0x006b;
    L_0x007d:
        r8 = move-exception;
        monitor-exit(r9);	 Catch:{ all -> 0x007d }
        throw r8;
    L_0x0080:
        r1.remove();	 Catch:{ all -> 0x007d }
        goto L_0x0022;
    L_0x0084:
        r3 = r7.size();	 Catch:{ all -> 0x007d }
        if (r3 <= 0) goto L_0x00dd;
    L_0x008a:
        if (r3 <= 0) goto L_0x00d1;
    L_0x008c:
        r3 = r3 + -1;
        r5 = r7.keyAt(r3);	 Catch:{ all -> 0x007d }
        r8 = r12.mAuthorities;	 Catch:{ all -> 0x007d }
        r8.remove(r5);	 Catch:{ all -> 0x007d }
        r8 = r12.mSyncStatus;	 Catch:{ all -> 0x007d }
        r6 = r8.size();	 Catch:{ all -> 0x007d }
    L_0x009d:
        if (r6 <= 0) goto L_0x00b5;
    L_0x009f:
        r6 = r6 + -1;
        r8 = r12.mSyncStatus;	 Catch:{ all -> 0x007d }
        r8 = r8.keyAt(r6);	 Catch:{ all -> 0x007d }
        if (r8 != r5) goto L_0x009d;
    L_0x00a9:
        r8 = r12.mSyncStatus;	 Catch:{ all -> 0x007d }
        r10 = r12.mSyncStatus;	 Catch:{ all -> 0x007d }
        r10 = r10.keyAt(r6);	 Catch:{ all -> 0x007d }
        r8.remove(r10);	 Catch:{ all -> 0x007d }
        goto L_0x009d;
    L_0x00b5:
        r8 = r12.mSyncHistory;	 Catch:{ all -> 0x007d }
        r6 = r8.size();	 Catch:{ all -> 0x007d }
    L_0x00bb:
        if (r6 <= 0) goto L_0x008a;
    L_0x00bd:
        r6 = r6 + -1;
        r8 = r12.mSyncHistory;	 Catch:{ all -> 0x007d }
        r8 = r8.get(r6);	 Catch:{ all -> 0x007d }
        r8 = (com.android.server.content.SyncStorageEngine.SyncHistoryItem) r8;	 Catch:{ all -> 0x007d }
        r8 = r8.authorityId;	 Catch:{ all -> 0x007d }
        if (r8 != r5) goto L_0x00bb;
    L_0x00cb:
        r8 = r12.mSyncHistory;	 Catch:{ all -> 0x007d }
        r8.remove(r6);	 Catch:{ all -> 0x007d }
        goto L_0x00bb;
    L_0x00d1:
        r12.writeAccountInfoLocked();	 Catch:{ all -> 0x007d }
        r12.writeStatusLocked();	 Catch:{ all -> 0x007d }
        r12.writePendingOperationsLocked();	 Catch:{ all -> 0x007d }
        r12.writeStatisticsLocked();	 Catch:{ all -> 0x007d }
    L_0x00dd:
        monitor-exit(r9);	 Catch:{ all -> 0x007d }
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.content.SyncStorageEngine.doDatabaseCleanup(android.accounts.Account[], int):void");
    }

    public SyncInfo addActiveSync(ActiveSyncContext activeSyncContext) {
        SyncInfo syncInfo;
        synchronized (this.mAuthorities) {
            if (Log.isLoggable(TAG, SOURCE_POLL)) {
                Log.v(TAG, "setActiveSync: account= auth=" + activeSyncContext.mSyncOperation.target + " src=" + activeSyncContext.mSyncOperation.syncSource + " extras=" + activeSyncContext.mSyncOperation.extras);
            }
            AuthorityInfo authorityInfo = getOrCreateAuthorityLocked(activeSyncContext.mSyncOperation.target, -1, true);
            syncInfo = new SyncInfo(authorityInfo.ident, authorityInfo.target.account, authorityInfo.target.provider, activeSyncContext.mStartTime);
            getCurrentSyncs(authorityInfo.target.userId).add(syncInfo);
        }
        reportActiveChange();
        return syncInfo;
    }

    public void removeActiveSync(SyncInfo syncInfo, int userId) {
        synchronized (this.mAuthorities) {
            if (Log.isLoggable(TAG, SOURCE_POLL)) {
                Log.v(TAG, "removeActiveSync: account=" + syncInfo.account + " user=" + userId + " auth=" + syncInfo.authority);
            }
            getCurrentSyncs(userId).remove(syncInfo);
        }
        reportActiveChange();
    }

    public void reportActiveChange() {
        reportChange(SOURCE_PERIODIC);
    }

    public long insertStartSyncEvent(SyncOperation op, long now) {
        long j;
        synchronized (this.mAuthorities) {
            if (Log.isLoggable(TAG, SOURCE_POLL)) {
                Log.v(TAG, "insertStartSyncEvent: " + op);
            }
            AuthorityInfo authority = getAuthorityLocked(op.target, "insertStartSyncEvent");
            if (authority == null) {
                j = NOT_IN_BACKOFF_MODE;
            } else {
                SyncHistoryItem item = new SyncHistoryItem();
                item.initialization = op.isInitialization();
                item.authorityId = authority.ident;
                int i = this.mNextHistoryId;
                this.mNextHistoryId = i + SOURCE_LOCAL;
                item.historyId = i;
                if (this.mNextHistoryId < 0) {
                    this.mNextHistoryId = STATUS_FILE_END;
                }
                item.eventTime = now;
                item.source = op.syncSource;
                item.reason = op.reason;
                item.extras = op.extras;
                item.event = STATUS_FILE_END;
                this.mSyncHistory.add(STATUS_FILE_END, item);
                while (this.mSyncHistory.size() > STATUS_FILE_ITEM) {
                    this.mSyncHistory.remove(this.mSyncHistory.size() - 1);
                }
                j = (long) item.historyId;
                if (Log.isLoggable(TAG, SOURCE_POLL)) {
                    Log.v(TAG, "returning historyId " + j);
                }
                reportChange(8);
            }
        }
        return j;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void stopSyncEvent(long r20, long r22, java.lang.String r24, long r25, long r27) {
        /*
        r19 = this;
        r0 = r19;
        r12 = r0.mAuthorities;
        monitor-enter(r12);
        r11 = "SyncManager";
        r13 = 2;
        r11 = android.util.Log.isLoggable(r11, r13);	 Catch:{ all -> 0x010e }
        if (r11 == 0) goto L_0x0028;
    L_0x000e:
        r11 = "SyncManager";
        r13 = new java.lang.StringBuilder;	 Catch:{ all -> 0x010e }
        r13.<init>();	 Catch:{ all -> 0x010e }
        r14 = "stopSyncEvent: historyId=";
        r13 = r13.append(r14);	 Catch:{ all -> 0x010e }
        r0 = r20;
        r13 = r13.append(r0);	 Catch:{ all -> 0x010e }
        r13 = r13.toString();	 Catch:{ all -> 0x010e }
        android.util.Log.v(r11, r13);	 Catch:{ all -> 0x010e }
    L_0x0028:
        r5 = 0;
        r0 = r19;
        r11 = r0.mSyncHistory;	 Catch:{ all -> 0x010e }
        r4 = r11.size();	 Catch:{ all -> 0x010e }
    L_0x0031:
        if (r4 <= 0) goto L_0x0046;
    L_0x0033:
        r4 = r4 + -1;
        r0 = r19;
        r11 = r0.mSyncHistory;	 Catch:{ all -> 0x010e }
        r5 = r11.get(r4);	 Catch:{ all -> 0x010e }
        r5 = (com.android.server.content.SyncStorageEngine.SyncHistoryItem) r5;	 Catch:{ all -> 0x010e }
        r11 = r5.historyId;	 Catch:{ all -> 0x010e }
        r14 = (long) r11;	 Catch:{ all -> 0x010e }
        r11 = (r14 > r20 ? 1 : (r14 == r20 ? 0 : -1));
        if (r11 != 0) goto L_0x0064;
    L_0x0046:
        if (r5 != 0) goto L_0x0066;
    L_0x0048:
        r11 = "SyncManager";
        r13 = new java.lang.StringBuilder;	 Catch:{ all -> 0x010e }
        r13.<init>();	 Catch:{ all -> 0x010e }
        r14 = "stopSyncEvent: no history for id ";
        r13 = r13.append(r14);	 Catch:{ all -> 0x010e }
        r0 = r20;
        r13 = r13.append(r0);	 Catch:{ all -> 0x010e }
        r13 = r13.toString();	 Catch:{ all -> 0x010e }
        android.util.Log.w(r11, r13);	 Catch:{ all -> 0x010e }
        monitor-exit(r12);	 Catch:{ all -> 0x010e }
    L_0x0063:
        return;
    L_0x0064:
        r5 = 0;
        goto L_0x0031;
    L_0x0066:
        r0 = r22;
        r5.elapsedTime = r0;	 Catch:{ all -> 0x010e }
        r11 = 1;
        r5.event = r11;	 Catch:{ all -> 0x010e }
        r0 = r24;
        r5.mesg = r0;	 Catch:{ all -> 0x010e }
        r0 = r25;
        r5.downstreamActivity = r0;	 Catch:{ all -> 0x010e }
        r0 = r27;
        r5.upstreamActivity = r0;	 Catch:{ all -> 0x010e }
        r11 = r5.authorityId;	 Catch:{ all -> 0x010e }
        r0 = r19;
        r8 = r0.getOrCreateSyncStatusLocked(r11);	 Catch:{ all -> 0x010e }
        r11 = r8.numSyncs;	 Catch:{ all -> 0x010e }
        r11 = r11 + 1;
        r8.numSyncs = r11;	 Catch:{ all -> 0x010e }
        r14 = r8.totalElapsedTime;	 Catch:{ all -> 0x010e }
        r14 = r14 + r22;
        r8.totalElapsedTime = r14;	 Catch:{ all -> 0x010e }
        r11 = r5.source;	 Catch:{ all -> 0x010e }
        switch(r11) {
            case 0: goto L_0x0121;
            case 1: goto L_0x0107;
            case 2: goto L_0x0111;
            case 3: goto L_0x0119;
            case 4: goto L_0x0129;
            default: goto L_0x0092;
        };	 Catch:{ all -> 0x010e }
    L_0x0092:
        r9 = 0;
        r2 = r19.getCurrentDayLocked();	 Catch:{ all -> 0x010e }
        r0 = r19;
        r11 = r0.mDayStats;	 Catch:{ all -> 0x010e }
        r13 = 0;
        r11 = r11[r13];	 Catch:{ all -> 0x010e }
        if (r11 != 0) goto L_0x0131;
    L_0x00a0:
        r0 = r19;
        r11 = r0.mDayStats;	 Catch:{ all -> 0x010e }
        r13 = 0;
        r14 = new com.android.server.content.SyncStorageEngine$DayStats;	 Catch:{ all -> 0x010e }
        r14.<init>(r2);	 Catch:{ all -> 0x010e }
        r11[r13] = r14;	 Catch:{ all -> 0x010e }
    L_0x00ac:
        r0 = r19;
        r11 = r0.mDayStats;	 Catch:{ all -> 0x010e }
        r13 = 0;
        r3 = r11[r13];	 Catch:{ all -> 0x010e }
        r14 = r5.eventTime;	 Catch:{ all -> 0x010e }
        r6 = r14 + r22;
        r10 = 0;
        r11 = "success";
        r0 = r24;
        r11 = r11.equals(r0);	 Catch:{ all -> 0x010e }
        if (r11 == 0) goto L_0x0172;
    L_0x00c2:
        r14 = r8.lastSuccessTime;	 Catch:{ all -> 0x010e }
        r16 = 0;
        r11 = (r14 > r16 ? 1 : (r14 == r16 ? 0 : -1));
        if (r11 == 0) goto L_0x00d2;
    L_0x00ca:
        r14 = r8.lastFailureTime;	 Catch:{ all -> 0x010e }
        r16 = 0;
        r11 = (r14 > r16 ? 1 : (r14 == r16 ? 0 : -1));
        if (r11 == 0) goto L_0x00d3;
    L_0x00d2:
        r10 = 1;
    L_0x00d3:
        r8.lastSuccessTime = r6;	 Catch:{ all -> 0x010e }
        r11 = r5.source;	 Catch:{ all -> 0x010e }
        r8.lastSuccessSource = r11;	 Catch:{ all -> 0x010e }
        r14 = 0;
        r8.lastFailureTime = r14;	 Catch:{ all -> 0x010e }
        r11 = -1;
        r8.lastFailureSource = r11;	 Catch:{ all -> 0x010e }
        r11 = 0;
        r8.lastFailureMesg = r11;	 Catch:{ all -> 0x010e }
        r14 = 0;
        r8.initialFailureTime = r14;	 Catch:{ all -> 0x010e }
        r11 = r3.successCount;	 Catch:{ all -> 0x010e }
        r11 = r11 + 1;
        r3.successCount = r11;	 Catch:{ all -> 0x010e }
        r14 = r3.successTime;	 Catch:{ all -> 0x010e }
        r14 = r14 + r22;
        r3.successTime = r14;	 Catch:{ all -> 0x010e }
    L_0x00f3:
        if (r10 == 0) goto L_0x01a7;
    L_0x00f5:
        r19.writeStatusLocked();	 Catch:{ all -> 0x010e }
    L_0x00f8:
        if (r9 == 0) goto L_0x01c1;
    L_0x00fa:
        r19.writeStatisticsLocked();	 Catch:{ all -> 0x010e }
    L_0x00fd:
        monitor-exit(r12);	 Catch:{ all -> 0x010e }
        r11 = 8;
        r0 = r19;
        r0.reportChange(r11);
        goto L_0x0063;
    L_0x0107:
        r11 = r8.numSourceLocal;	 Catch:{ all -> 0x010e }
        r11 = r11 + 1;
        r8.numSourceLocal = r11;	 Catch:{ all -> 0x010e }
        goto L_0x0092;
    L_0x010e:
        r11 = move-exception;
        monitor-exit(r12);	 Catch:{ all -> 0x010e }
        throw r11;
    L_0x0111:
        r11 = r8.numSourcePoll;	 Catch:{ all -> 0x010e }
        r11 = r11 + 1;
        r8.numSourcePoll = r11;	 Catch:{ all -> 0x010e }
        goto L_0x0092;
    L_0x0119:
        r11 = r8.numSourceUser;	 Catch:{ all -> 0x010e }
        r11 = r11 + 1;
        r8.numSourceUser = r11;	 Catch:{ all -> 0x010e }
        goto L_0x0092;
    L_0x0121:
        r11 = r8.numSourceServer;	 Catch:{ all -> 0x010e }
        r11 = r11 + 1;
        r8.numSourceServer = r11;	 Catch:{ all -> 0x010e }
        goto L_0x0092;
    L_0x0129:
        r11 = r8.numSourcePeriodic;	 Catch:{ all -> 0x010e }
        r11 = r11 + 1;
        r8.numSourcePeriodic = r11;	 Catch:{ all -> 0x010e }
        goto L_0x0092;
    L_0x0131:
        r0 = r19;
        r11 = r0.mDayStats;	 Catch:{ all -> 0x010e }
        r13 = 0;
        r11 = r11[r13];	 Catch:{ all -> 0x010e }
        r11 = r11.day;	 Catch:{ all -> 0x010e }
        if (r2 == r11) goto L_0x0167;
    L_0x013c:
        r0 = r19;
        r11 = r0.mDayStats;	 Catch:{ all -> 0x010e }
        r13 = 0;
        r0 = r19;
        r14 = r0.mDayStats;	 Catch:{ all -> 0x010e }
        r15 = 1;
        r0 = r19;
        r0 = r0.mDayStats;	 Catch:{ all -> 0x010e }
        r16 = r0;
        r0 = r16;
        r0 = r0.length;	 Catch:{ all -> 0x010e }
        r16 = r0;
        r16 = r16 + -1;
        r0 = r16;
        java.lang.System.arraycopy(r11, r13, r14, r15, r0);	 Catch:{ all -> 0x010e }
        r0 = r19;
        r11 = r0.mDayStats;	 Catch:{ all -> 0x010e }
        r13 = 0;
        r14 = new com.android.server.content.SyncStorageEngine$DayStats;	 Catch:{ all -> 0x010e }
        r14.<init>(r2);	 Catch:{ all -> 0x010e }
        r11[r13] = r14;	 Catch:{ all -> 0x010e }
        r9 = 1;
        goto L_0x00ac;
    L_0x0167:
        r0 = r19;
        r11 = r0.mDayStats;	 Catch:{ all -> 0x010e }
        r13 = 0;
        r11 = r11[r13];	 Catch:{ all -> 0x010e }
        if (r11 != 0) goto L_0x00ac;
    L_0x0170:
        goto L_0x00ac;
    L_0x0172:
        r11 = "canceled";
        r0 = r24;
        r11 = r11.equals(r0);	 Catch:{ all -> 0x010e }
        if (r11 != 0) goto L_0x00f3;
    L_0x017c:
        r14 = r8.lastFailureTime;	 Catch:{ all -> 0x010e }
        r16 = 0;
        r11 = (r14 > r16 ? 1 : (r14 == r16 ? 0 : -1));
        if (r11 != 0) goto L_0x0185;
    L_0x0184:
        r10 = 1;
    L_0x0185:
        r8.lastFailureTime = r6;	 Catch:{ all -> 0x010e }
        r11 = r5.source;	 Catch:{ all -> 0x010e }
        r8.lastFailureSource = r11;	 Catch:{ all -> 0x010e }
        r0 = r24;
        r8.lastFailureMesg = r0;	 Catch:{ all -> 0x010e }
        r14 = r8.initialFailureTime;	 Catch:{ all -> 0x010e }
        r16 = 0;
        r11 = (r14 > r16 ? 1 : (r14 == r16 ? 0 : -1));
        if (r11 != 0) goto L_0x0199;
    L_0x0197:
        r8.initialFailureTime = r6;	 Catch:{ all -> 0x010e }
    L_0x0199:
        r11 = r3.failureCount;	 Catch:{ all -> 0x010e }
        r11 = r11 + 1;
        r3.failureCount = r11;	 Catch:{ all -> 0x010e }
        r14 = r3.failureTime;	 Catch:{ all -> 0x010e }
        r14 = r14 + r22;
        r3.failureTime = r14;	 Catch:{ all -> 0x010e }
        goto L_0x00f3;
    L_0x01a7:
        r11 = 1;
        r0 = r19;
        r11 = r0.hasMessages(r11);	 Catch:{ all -> 0x010e }
        if (r11 != 0) goto L_0x00f8;
    L_0x01b0:
        r11 = 1;
        r0 = r19;
        r11 = r0.obtainMessage(r11);	 Catch:{ all -> 0x010e }
        r14 = 600000; // 0x927c0 float:8.40779E-40 double:2.964394E-318;
        r0 = r19;
        r0.sendMessageDelayed(r11, r14);	 Catch:{ all -> 0x010e }
        goto L_0x00f8;
    L_0x01c1:
        r11 = 2;
        r0 = r19;
        r11 = r0.hasMessages(r11);	 Catch:{ all -> 0x010e }
        if (r11 != 0) goto L_0x00fd;
    L_0x01ca:
        r11 = 2;
        r0 = r19;
        r11 = r0.obtainMessage(r11);	 Catch:{ all -> 0x010e }
        r14 = 1800000; // 0x1b7740 float:2.522337E-39 double:8.89318E-318;
        r0 = r19;
        r0.sendMessageDelayed(r11, r14);	 Catch:{ all -> 0x010e }
        goto L_0x00fd;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.content.SyncStorageEngine.stopSyncEvent(long, long, java.lang.String, long, long):void");
    }

    private List<SyncInfo> getCurrentSyncs(int userId) {
        List<SyncInfo> currentSyncsLocked;
        synchronized (this.mAuthorities) {
            currentSyncsLocked = getCurrentSyncsLocked(userId);
        }
        return currentSyncsLocked;
    }

    public List<SyncInfo> getCurrentSyncsCopy(int userId) {
        List<SyncInfo> syncsCopy;
        synchronized (this.mAuthorities) {
            List<SyncInfo> syncs = getCurrentSyncsLocked(userId);
            syncsCopy = new ArrayList();
            for (SyncInfo sync : syncs) {
                syncsCopy.add(new SyncInfo(sync));
            }
        }
        return syncsCopy;
    }

    private List<SyncInfo> getCurrentSyncsLocked(int userId) {
        ArrayList<SyncInfo> syncs = (ArrayList) this.mCurrentSyncs.get(userId);
        if (syncs != null) {
            return syncs;
        }
        syncs = new ArrayList();
        this.mCurrentSyncs.put(userId, syncs);
        return syncs;
    }

    public ArrayList<SyncStatusInfo> getSyncStatus() {
        ArrayList<SyncStatusInfo> ops;
        synchronized (this.mAuthorities) {
            int N = this.mSyncStatus.size();
            ops = new ArrayList(N);
            for (int i = STATUS_FILE_END; i < N; i += SOURCE_LOCAL) {
                ops.add(this.mSyncStatus.valueAt(i));
            }
        }
        return ops;
    }

    public Pair<AuthorityInfo, SyncStatusInfo> getCopyOfAuthorityWithSyncStatus(EndPoint info) {
        Pair<AuthorityInfo, SyncStatusInfo> createCopyPairOfAuthorityWithSyncStatusLocked;
        synchronized (this.mAuthorities) {
            createCopyPairOfAuthorityWithSyncStatusLocked = createCopyPairOfAuthorityWithSyncStatusLocked(getOrCreateAuthorityLocked(info, -1, true));
        }
        return createCopyPairOfAuthorityWithSyncStatusLocked;
    }

    public ArrayList<Pair<AuthorityInfo, SyncStatusInfo>> getCopyOfAllAuthoritiesWithSyncStatus() {
        ArrayList<Pair<AuthorityInfo, SyncStatusInfo>> infos;
        synchronized (this.mAuthorities) {
            infos = new ArrayList(this.mAuthorities.size());
            for (int i = STATUS_FILE_END; i < this.mAuthorities.size(); i += SOURCE_LOCAL) {
                infos.add(createCopyPairOfAuthorityWithSyncStatusLocked((AuthorityInfo) this.mAuthorities.valueAt(i)));
            }
        }
        return infos;
    }

    public SyncStatusInfo getStatusByAuthority(EndPoint info) {
        if (info.target_provider && (info.account == null || info.provider == null)) {
            return null;
        }
        if (info.target_service && info.service == null) {
            return null;
        }
        synchronized (this.mAuthorities) {
            int N = this.mSyncStatus.size();
            int i = STATUS_FILE_END;
            while (i < N) {
                SyncStatusInfo cur = (SyncStatusInfo) this.mSyncStatus.valueAt(i);
                AuthorityInfo ainfo = (AuthorityInfo) this.mAuthorities.get(cur.authorityId);
                if (ainfo == null || !ainfo.target.matchesSpec(info)) {
                    i += SOURCE_LOCAL;
                } else {
                    return cur;
                }
            }
            return null;
        }
    }

    public boolean isSyncPending(EndPoint info) {
        boolean z;
        synchronized (this.mAuthorities) {
            int N = this.mSyncStatus.size();
            for (int i = STATUS_FILE_END; i < N; i += SOURCE_LOCAL) {
                SyncStatusInfo cur = (SyncStatusInfo) this.mSyncStatus.valueAt(i);
                AuthorityInfo ainfo = (AuthorityInfo) this.mAuthorities.get(cur.authorityId);
                if (ainfo != null && ainfo.target.matchesSpec(info) && cur.pending) {
                    z = true;
                    break;
                }
            }
            z = SYNC_ENABLED_DEFAULT;
        }
        return z;
    }

    public ArrayList<SyncHistoryItem> getSyncHistory() {
        ArrayList<SyncHistoryItem> items;
        synchronized (this.mAuthorities) {
            int N = this.mSyncHistory.size();
            items = new ArrayList(N);
            for (int i = STATUS_FILE_END; i < N; i += SOURCE_LOCAL) {
                items.add(this.mSyncHistory.get(i));
            }
        }
        return items;
    }

    public DayStats[] getDayStatistics() {
        DayStats[] ds;
        synchronized (this.mAuthorities) {
            ds = new DayStats[this.mDayStats.length];
            System.arraycopy(this.mDayStats, STATUS_FILE_END, ds, STATUS_FILE_END, ds.length);
        }
        return ds;
    }

    private Pair<AuthorityInfo, SyncStatusInfo> createCopyPairOfAuthorityWithSyncStatusLocked(AuthorityInfo authorityInfo) {
        return Pair.create(new AuthorityInfo(authorityInfo), new SyncStatusInfo(getOrCreateSyncStatusLocked(authorityInfo.ident)));
    }

    private int getCurrentDayLocked() {
        this.mCal.setTimeInMillis(System.currentTimeMillis());
        int dayOfYear = this.mCal.get(6);
        if (this.mYear != this.mCal.get(SOURCE_LOCAL)) {
            this.mYear = this.mCal.get(SOURCE_LOCAL);
            this.mCal.clear();
            this.mCal.set(SOURCE_LOCAL, this.mYear);
            this.mYearInDays = (int) (this.mCal.getTimeInMillis() / 86400000);
        }
        return this.mYearInDays + dayOfYear;
    }

    private AuthorityInfo getAuthorityLocked(EndPoint info, String tag) {
        AuthorityInfo authority;
        if (info.target_service) {
            SparseArray<AuthorityInfo> aInfo = (SparseArray) this.mServices.get(info.service);
            authority = null;
            if (aInfo != null) {
                authority = (AuthorityInfo) aInfo.get(info.userId);
            }
            if (authority != null) {
                return authority;
            }
            if (tag != null && Log.isLoggable(TAG, SOURCE_POLL)) {
                Log.v(TAG, tag + " No authority info found for " + info.service + " for" + " user " + info.userId);
            }
            return null;
        } else if (info.target_provider) {
            AccountAndUser au = new AccountAndUser(info.account, info.userId);
            AccountInfo accountInfo = (AccountInfo) this.mAccounts.get(au);
            if (accountInfo == null) {
                if (tag != null && Log.isLoggable(TAG, SOURCE_POLL)) {
                    Log.v(TAG, tag + ": unknown account " + au);
                }
                return null;
            }
            authority = (AuthorityInfo) accountInfo.authorities.get(info.provider);
            if (authority != null) {
                return authority;
            }
            if (tag != null && Log.isLoggable(TAG, SOURCE_POLL)) {
                Log.v(TAG, tag + ": unknown provider " + info.provider);
            }
            return null;
        } else {
            Log.e(TAG, tag + " Authority : " + info + ", invalid target");
            return null;
        }
    }

    private AuthorityInfo getOrCreateAuthorityLocked(EndPoint info, int ident, boolean doWrite) {
        AuthorityInfo authority;
        if (info.target_service) {
            SparseArray<AuthorityInfo> aInfo = (SparseArray) this.mServices.get(info.service);
            if (aInfo == null) {
                aInfo = new SparseArray();
                this.mServices.put(info.service, aInfo);
            }
            authority = (AuthorityInfo) aInfo.get(info.userId);
            if (authority != null) {
                return authority;
            }
            authority = createAuthorityLocked(info, ident, doWrite);
            aInfo.put(info.userId, authority);
            return authority;
        } else if (!info.target_provider) {
            return null;
        } else {
            AccountAndUser au = new AccountAndUser(info.account, info.userId);
            AccountInfo account = (AccountInfo) this.mAccounts.get(au);
            if (account == null) {
                account = new AccountInfo(au);
                this.mAccounts.put(au, account);
            }
            authority = (AuthorityInfo) account.authorities.get(info.provider);
            if (authority != null) {
                return authority;
            }
            authority = createAuthorityLocked(info, ident, doWrite);
            account.authorities.put(info.provider, authority);
            return authority;
        }
    }

    private AuthorityInfo createAuthorityLocked(EndPoint info, int ident, boolean doWrite) {
        if (ident < 0) {
            ident = this.mNextAuthorityId;
            this.mNextAuthorityId += SOURCE_LOCAL;
            doWrite = true;
        }
        if (Log.isLoggable(TAG, SOURCE_POLL)) {
            Log.v(TAG, "created a new AuthorityInfo for " + info);
        }
        AuthorityInfo authority = new AuthorityInfo(info, ident);
        this.mAuthorities.put(ident, authority);
        if (doWrite) {
            writeAccountInfoLocked();
        }
        return authority;
    }

    public void removeAuthority(EndPoint info) {
        synchronized (this.mAuthorities) {
            if (info.target_provider) {
                removeAuthorityLocked(info.account, info.userId, info.provider, true);
            } else {
                SparseArray<AuthorityInfo> aInfos = (SparseArray) this.mServices.get(info.service);
                if (aInfos != null) {
                    AuthorityInfo authorityInfo = (AuthorityInfo) aInfos.get(info.userId);
                    if (authorityInfo != null) {
                        this.mAuthorities.remove(authorityInfo.ident);
                        aInfos.delete(info.userId);
                        writeAccountInfoLocked();
                    }
                }
            }
        }
    }

    private void removeAuthorityLocked(Account account, int userId, String authorityName, boolean doWrite) {
        AccountInfo accountInfo = (AccountInfo) this.mAccounts.get(new AccountAndUser(account, userId));
        if (accountInfo != null) {
            AuthorityInfo authorityInfo = (AuthorityInfo) accountInfo.authorities.remove(authorityName);
            if (authorityInfo != null) {
                this.mAuthorities.remove(authorityInfo.ident);
                if (doWrite) {
                    writeAccountInfoLocked();
                }
            }
        }
    }

    public void setPeriodicSyncTime(int authorityId, PeriodicSync targetPeriodicSync, long when) {
        boolean found = SYNC_ENABLED_DEFAULT;
        synchronized (this.mAuthorities) {
            AuthorityInfo authorityInfo = (AuthorityInfo) this.mAuthorities.get(authorityId);
            for (int i = STATUS_FILE_END; i < authorityInfo.periodicSyncs.size(); i += SOURCE_LOCAL) {
                if (targetPeriodicSync.equals((PeriodicSync) authorityInfo.periodicSyncs.get(i))) {
                    ((SyncStatusInfo) this.mSyncStatus.get(authorityId)).setPeriodicSyncTime(i, when);
                    found = true;
                    break;
                }
            }
        }
        if (!found) {
            Log.w(TAG, "Ignoring setPeriodicSyncTime request for a sync that does not exist. Authority: " + authorityInfo.target);
        }
    }

    private SyncStatusInfo getOrCreateSyncStatusLocked(int authorityId) {
        SyncStatusInfo status = (SyncStatusInfo) this.mSyncStatus.get(authorityId);
        if (status != null) {
            return status;
        }
        status = new SyncStatusInfo(authorityId);
        this.mSyncStatus.put(authorityId, status);
        return status;
    }

    public void writeAllState() {
        synchronized (this.mAuthorities) {
            if (this.mNumPendingFinished > 0) {
                writePendingOperationsLocked();
            }
            writeStatusLocked();
            writeStatisticsLocked();
        }
    }

    public void clearAndReadState() {
        synchronized (this.mAuthorities) {
            this.mAuthorities.clear();
            this.mAccounts.clear();
            this.mServices.clear();
            this.mPendingOperations.clear();
            this.mSyncStatus.clear();
            this.mSyncHistory.clear();
            readAccountInfoLocked();
            readStatusLocked();
            readPendingOperationsLocked();
            readStatisticsLocked();
            readAndDeleteLegacyAccountInfoLocked();
            writeAccountInfoLocked();
            writeStatusLocked();
            writePendingOperationsLocked();
            writeStatisticsLocked();
        }
    }

    private void readAccountInfoLocked() {
        int highestAuthorityId = -1;
        FileInputStream fis = null;
        try {
            fis = this.mAccountInfoFile.openRead();
            if (Log.isLoggable(TAG_FILE, SOURCE_POLL)) {
                Log.v(TAG_FILE, "Reading " + this.mAccountInfoFile.getBaseFile());
            }
            XmlPullParser parser = Xml.newPullParser();
            parser.setInput(fis, StandardCharsets.UTF_8.name());
            int eventType = parser.getEventType();
            while (eventType != SOURCE_POLL && eventType != SOURCE_LOCAL) {
                eventType = parser.next();
            }
            if (eventType == SOURCE_LOCAL) {
                Log.i(TAG, "No initial accounts");
                this.mNextAuthorityId = Math.max(STATUS_FILE_END, this.mNextAuthorityId);
                if (fis != null) {
                    try {
                        fis.close();
                        return;
                    } catch (IOException e) {
                        return;
                    }
                }
                return;
            }
            if ("accounts".equals(parser.getName())) {
                int version;
                String listen = parser.getAttributeValue(null, XML_ATTR_LISTEN_FOR_TICKLES);
                String versionString = parser.getAttributeValue(null, XML_ATTR_VERSION);
                if (versionString == null) {
                    version = STATUS_FILE_END;
                } else {
                    try {
                        version = Integer.parseInt(versionString);
                    } catch (NumberFormatException e2) {
                        version = STATUS_FILE_END;
                    }
                }
                String nextIdString = parser.getAttributeValue(null, XML_ATTR_NEXT_AUTHORITY_ID);
                try {
                    this.mNextAuthorityId = Math.max(this.mNextAuthorityId, nextIdString == null ? STATUS_FILE_END : Integer.parseInt(nextIdString));
                } catch (NumberFormatException e3) {
                }
                String offsetString = parser.getAttributeValue(null, XML_ATTR_SYNC_RANDOM_OFFSET);
                try {
                    this.mSyncRandomOffset = offsetString == null ? STATUS_FILE_END : Integer.parseInt(offsetString);
                } catch (NumberFormatException e4) {
                    this.mSyncRandomOffset = STATUS_FILE_END;
                }
                if (this.mSyncRandomOffset == 0) {
                    this.mSyncRandomOffset = new Random(System.currentTimeMillis()).nextInt(86400);
                }
                SparseArray sparseArray = this.mMasterSyncAutomatically;
                boolean z = (listen == null || Boolean.parseBoolean(listen)) ? true : SYNC_ENABLED_DEFAULT;
                sparseArray.put(STATUS_FILE_END, Boolean.valueOf(z));
                eventType = parser.next();
                AuthorityInfo authority = null;
                PeriodicSync periodicSync = null;
                do {
                    if (eventType == SOURCE_POLL) {
                        String tagName = parser.getName();
                        if (parser.getDepth() == SOURCE_POLL) {
                            if ("authority".equals(tagName)) {
                                authority = parseAuthority(parser, version);
                                periodicSync = null;
                                int i = authority.ident;
                                if (r0 > highestAuthorityId) {
                                    highestAuthorityId = authority.ident;
                                }
                            } else {
                                if (XML_TAG_LISTEN_FOR_TICKLES.equals(tagName)) {
                                    parseListenForTickles(parser);
                                }
                            }
                        } else if (parser.getDepth() == SOURCE_USER) {
                            if ("periodicSync".equals(tagName) && authority != null) {
                                periodicSync = parsePeriodicSync(parser, authority);
                            }
                        } else if (parser.getDepth() == SOURCE_PERIODIC && periodicSync != null) {
                            if ("extra".equals(tagName)) {
                                parseExtra(parser, periodicSync.extras);
                            }
                        }
                    }
                    eventType = parser.next();
                } while (eventType != SOURCE_LOCAL);
            }
            this.mNextAuthorityId = Math.max(highestAuthorityId + SOURCE_LOCAL, this.mNextAuthorityId);
            if (fis != null) {
                try {
                    fis.close();
                } catch (IOException e5) {
                }
            }
            maybeMigrateSettingsForRenamedAuthorities();
        } catch (XmlPullParserException e6) {
            Log.w(TAG, "Error reading accounts", e6);
            this.mNextAuthorityId = Math.max(highestAuthorityId + SOURCE_LOCAL, this.mNextAuthorityId);
            if (fis != null) {
                try {
                    fis.close();
                } catch (IOException e7) {
                }
            }
        } catch (IOException e8) {
            if (fis == null) {
                Log.i(TAG, "No initial accounts");
            } else {
                Log.w(TAG, "Error reading accounts", e8);
            }
            this.mNextAuthorityId = Math.max(highestAuthorityId + SOURCE_LOCAL, this.mNextAuthorityId);
            if (fis != null) {
                try {
                    fis.close();
                } catch (IOException e9) {
                }
            }
        } catch (Throwable th) {
            this.mNextAuthorityId = Math.max(highestAuthorityId + SOURCE_LOCAL, this.mNextAuthorityId);
            if (fis != null) {
                try {
                    fis.close();
                } catch (IOException e10) {
                }
            }
        }
    }

    private void maybeDeleteLegacyPendingInfoLocked(File syncDir) {
        File file = new File(syncDir, "pending.bin");
        if (file.exists()) {
            file.delete();
        }
    }

    private boolean maybeMigrateSettingsForRenamedAuthorities() {
        boolean writeNeeded = SYNC_ENABLED_DEFAULT;
        ArrayList<AuthorityInfo> authoritiesToRemove = new ArrayList();
        int N = this.mAuthorities.size();
        for (int i = STATUS_FILE_END; i < N; i += SOURCE_LOCAL) {
            AuthorityInfo authority = (AuthorityInfo) this.mAuthorities.valueAt(i);
            if (!authority.target.target_service) {
                String newAuthorityName = (String) sAuthorityRenames.get(authority.target.provider);
                if (newAuthorityName != null) {
                    authoritiesToRemove.add(authority);
                    if (authority.enabled) {
                        EndPoint newInfo = new EndPoint(authority.target.account, newAuthorityName, authority.target.userId);
                        if (getAuthorityLocked(newInfo, "cleanup") == null) {
                            getOrCreateAuthorityLocked(newInfo, -1, SYNC_ENABLED_DEFAULT).enabled = true;
                            writeNeeded = true;
                        }
                    }
                }
            }
        }
        Iterator i$ = authoritiesToRemove.iterator();
        while (i$.hasNext()) {
            AuthorityInfo authorityInfo = (AuthorityInfo) i$.next();
            removeAuthorityLocked(authorityInfo.target.account, authorityInfo.target.userId, authorityInfo.target.provider, SYNC_ENABLED_DEFAULT);
            writeNeeded = true;
        }
        return writeNeeded;
    }

    private void parseListenForTickles(XmlPullParser parser) {
        String user = parser.getAttributeValue(null, XML_ATTR_USER);
        int userId = STATUS_FILE_END;
        try {
            userId = Integer.parseInt(user);
        } catch (NumberFormatException e) {
            Log.e(TAG, "error parsing the user for listen-for-tickles", e);
        } catch (NullPointerException e2) {
            Log.e(TAG, "the user in listen-for-tickles is null", e2);
        }
        String enabled = parser.getAttributeValue(null, XML_ATTR_ENABLED);
        boolean listen = (enabled == null || Boolean.parseBoolean(enabled)) ? true : SYNC_ENABLED_DEFAULT;
        this.mMasterSyncAutomatically.put(userId, Boolean.valueOf(listen));
    }

    private AuthorityInfo parseAuthority(XmlPullParser parser, int version) {
        AuthorityInfo authority = null;
        int id = -1;
        try {
            id = Integer.parseInt(parser.getAttributeValue(null, "id"));
        } catch (NumberFormatException e) {
            Log.e(TAG, "error parsing the id of the authority", e);
        } catch (NullPointerException e2) {
            Log.e(TAG, "the id of the authority is null", e2);
        }
        if (id >= 0) {
            String authorityName = parser.getAttributeValue(null, "authority");
            String enabled = parser.getAttributeValue(null, XML_ATTR_ENABLED);
            String syncable = parser.getAttributeValue(null, "syncable");
            String accountName = parser.getAttributeValue(null, "account");
            String accountType = parser.getAttributeValue(null, SoundModelContract.KEY_TYPE);
            String user = parser.getAttributeValue(null, XML_ATTR_USER);
            String packageName = parser.getAttributeValue(null, "package");
            String className = parser.getAttributeValue(null, "class");
            int userId = user == null ? STATUS_FILE_END : Integer.parseInt(user);
            if (accountType == null && packageName == null) {
                accountType = "com.google";
                syncable = "unknown";
            }
            authority = (AuthorityInfo) this.mAuthorities.get(id);
            if (Log.isLoggable(TAG_FILE, SOURCE_POLL)) {
                Log.v(TAG_FILE, "Adding authority: account=" + accountName + " accountType=" + accountType + " auth=" + authorityName + " package=" + packageName + " class=" + className + " user=" + userId + " enabled=" + enabled + " syncable=" + syncable);
            }
            if (authority == null) {
                EndPoint info;
                if (Log.isLoggable(TAG_FILE, SOURCE_POLL)) {
                    Log.v(TAG_FILE, "Creating authority entry");
                }
                if (accountName == null || authorityName == null) {
                    info = new EndPoint(new ComponentName(packageName, className), userId);
                } else {
                    info = new EndPoint(new Account(accountName, accountType), authorityName, userId);
                }
                authority = getOrCreateAuthorityLocked(info, id, SYNC_ENABLED_DEFAULT);
                if (version > 0) {
                    authority.periodicSyncs.clear();
                }
            }
            if (authority != null) {
                boolean z = (enabled == null || Boolean.parseBoolean(enabled)) ? true : SYNC_ENABLED_DEFAULT;
                authority.enabled = z;
                if ("unknown".equals(syncable)) {
                    authority.syncable = -1;
                } else {
                    int i = (syncable == null || Boolean.parseBoolean(syncable)) ? SOURCE_LOCAL : STATUS_FILE_END;
                    authority.syncable = i;
                }
            } else {
                Log.w(TAG, "Failure adding authority: account=" + accountName + " auth=" + authorityName + " enabled=" + enabled + " syncable=" + syncable);
            }
        }
        return authority;
    }

    private PeriodicSync parsePeriodicSync(XmlPullParser parser, AuthorityInfo authorityInfo) {
        long flextime;
        Bundle extras = new Bundle();
        String periodValue = parser.getAttributeValue(null, "period");
        String flexValue = parser.getAttributeValue(null, "flex");
        try {
            long period = Long.parseLong(periodValue);
            try {
                flextime = Long.parseLong(flexValue);
            } catch (NumberFormatException e) {
                flextime = calculateDefaultFlexTime(period);
                Log.e(TAG, "Error formatting value parsed for periodic sync flex: " + flexValue + ", using default: " + flextime);
            } catch (NullPointerException e2) {
                flextime = calculateDefaultFlexTime(period);
                Log.d(TAG, "No flex time specified for this sync, using a default. period: " + period + " flex: " + flextime);
            }
            if (authorityInfo.target.target_provider) {
                PeriodicSync periodicSync = new PeriodicSync(authorityInfo.target.account, authorityInfo.target.provider, extras, period, flextime);
                authorityInfo.periodicSyncs.add(periodicSync);
                return periodicSync;
            }
            Log.e(TAG, "Unknown target.");
            return null;
        } catch (NumberFormatException e3) {
            Log.e(TAG, "error parsing the period of a periodic sync", e3);
            return null;
        } catch (NullPointerException e4) {
            Log.e(TAG, "the period of a periodic sync is null", e4);
            return null;
        }
    }

    private void parseExtra(XmlPullParser parser, Bundle extras) {
        String name = parser.getAttributeValue(null, "name");
        String type = parser.getAttributeValue(null, SoundModelContract.KEY_TYPE);
        String value1 = parser.getAttributeValue(null, "value1");
        String value2 = parser.getAttributeValue(null, "value2");
        try {
            if ("long".equals(type)) {
                extras.putLong(name, Long.parseLong(value1));
            } else if ("integer".equals(type)) {
                extras.putInt(name, Integer.parseInt(value1));
            } else if ("double".equals(type)) {
                extras.putDouble(name, Double.parseDouble(value1));
            } else if ("float".equals(type)) {
                extras.putFloat(name, Float.parseFloat(value1));
            } else if ("boolean".equals(type)) {
                extras.putBoolean(name, Boolean.parseBoolean(value1));
            } else if ("string".equals(type)) {
                extras.putString(name, value1);
            } else if ("account".equals(type)) {
                extras.putParcelable(name, new Account(value1, value2));
            }
        } catch (NumberFormatException e) {
            Log.e(TAG, "error parsing bundle value", e);
        } catch (NullPointerException e2) {
            Log.e(TAG, "error parsing bundle value", e2);
        }
    }

    private void writeAccountInfoLocked() {
        if (Log.isLoggable(TAG_FILE, SOURCE_POLL)) {
            Log.v(TAG_FILE, "Writing new " + this.mAccountInfoFile.getBaseFile());
        }
        FileOutputStream fos = null;
        try {
            fos = this.mAccountInfoFile.startWrite();
            XmlSerializer out = new FastXmlSerializer();
            out.setOutput(fos, StandardCharsets.UTF_8.name());
            out.startDocument(null, Boolean.valueOf(true));
            out.setFeature("http://xmlpull.org/v1/doc/features.html#indent-output", true);
            out.startTag(null, "accounts");
            out.attribute(null, XML_ATTR_VERSION, Integer.toString(SOURCE_POLL));
            out.attribute(null, XML_ATTR_NEXT_AUTHORITY_ID, Integer.toString(this.mNextAuthorityId));
            out.attribute(null, XML_ATTR_SYNC_RANDOM_OFFSET, Integer.toString(this.mSyncRandomOffset));
            int M = this.mMasterSyncAutomatically.size();
            for (int m = STATUS_FILE_END; m < M; m += SOURCE_LOCAL) {
                int userId = this.mMasterSyncAutomatically.keyAt(m);
                Boolean listen = (Boolean) this.mMasterSyncAutomatically.valueAt(m);
                out.startTag(null, XML_TAG_LISTEN_FOR_TICKLES);
                out.attribute(null, XML_ATTR_USER, Integer.toString(userId));
                out.attribute(null, XML_ATTR_ENABLED, Boolean.toString(listen.booleanValue()));
                out.endTag(null, XML_TAG_LISTEN_FOR_TICKLES);
            }
            int N = this.mAuthorities.size();
            for (int i = STATUS_FILE_END; i < N; i += SOURCE_LOCAL) {
                AuthorityInfo authority = (AuthorityInfo) this.mAuthorities.valueAt(i);
                EndPoint info = authority.target;
                out.startTag(null, "authority");
                out.attribute(null, "id", Integer.toString(authority.ident));
                out.attribute(null, XML_ATTR_USER, Integer.toString(info.userId));
                out.attribute(null, XML_ATTR_ENABLED, Boolean.toString(authority.enabled));
                if (info.service == null) {
                    out.attribute(null, "account", info.account.name);
                    out.attribute(null, SoundModelContract.KEY_TYPE, info.account.type);
                    out.attribute(null, "authority", info.provider);
                } else {
                    out.attribute(null, "package", info.service.getPackageName());
                    out.attribute(null, "class", info.service.getClassName());
                }
                if (authority.syncable < 0) {
                    out.attribute(null, "syncable", "unknown");
                } else {
                    out.attribute(null, "syncable", Boolean.toString(authority.syncable != 0 ? true : SYNC_ENABLED_DEFAULT));
                }
                Iterator i$ = authority.periodicSyncs.iterator();
                while (i$.hasNext()) {
                    PeriodicSync periodicSync = (PeriodicSync) i$.next();
                    out.startTag(null, "periodicSync");
                    out.attribute(null, "period", Long.toString(periodicSync.period));
                    out.attribute(null, "flex", Long.toString(periodicSync.flexTime));
                    extrasToXml(out, periodicSync.extras);
                    out.endTag(null, "periodicSync");
                }
                out.endTag(null, "authority");
            }
            out.endTag(null, "accounts");
            out.endDocument();
            this.mAccountInfoFile.finishWrite(fos);
        } catch (IOException e1) {
            Log.w(TAG, "Error writing accounts", e1);
            if (fos != null) {
                this.mAccountInfoFile.failWrite(fos);
            }
        }
    }

    static int getIntColumn(Cursor c, String name) {
        return c.getInt(c.getColumnIndex(name));
    }

    static long getLongColumn(Cursor c, String name) {
        return c.getLong(c.getColumnIndex(name));
    }

    private void readAndDeleteLegacyAccountInfoLocked() {
        File file = this.mContext.getDatabasePath("syncmanager.db");
        if (file.exists()) {
            String path = file.getPath();
            SQLiteDatabase db = null;
            try {
                db = SQLiteDatabase.openDatabase(path, null, SOURCE_LOCAL);
            } catch (SQLiteException e) {
            }
            if (db != null) {
                AuthorityInfo authority;
                int i;
                boolean z;
                boolean hasType = db.getVersion() >= 11 ? true : SYNC_ENABLED_DEFAULT;
                if (Log.isLoggable(TAG_FILE, SOURCE_POLL)) {
                    Log.v(TAG_FILE, "Reading legacy sync accounts db");
                }
                SQLiteQueryBuilder qb = new SQLiteQueryBuilder();
                qb.setTables("stats, status");
                HashMap<String, String> map = new HashMap();
                map.put("_id", "status._id as _id");
                map.put("account", "stats.account as account");
                if (hasType) {
                    map.put("account_type", "stats.account_type as account_type");
                }
                map.put("authority", "stats.authority as authority");
                map.put("totalElapsedTime", "totalElapsedTime");
                map.put("numSyncs", "numSyncs");
                map.put("numSourceLocal", "numSourceLocal");
                map.put("numSourcePoll", "numSourcePoll");
                map.put("numSourceServer", "numSourceServer");
                map.put("numSourceUser", "numSourceUser");
                map.put("lastSuccessSource", "lastSuccessSource");
                map.put("lastSuccessTime", "lastSuccessTime");
                map.put("lastFailureSource", "lastFailureSource");
                map.put("lastFailureTime", "lastFailureTime");
                map.put("lastFailureMesg", "lastFailureMesg");
                map.put("pending", "pending");
                qb.setProjectionMap(map);
                qb.appendWhere("stats._id = status.stats_id");
                Cursor c = qb.query(db, null, null, null, null, null, null);
                while (c.moveToNext()) {
                    String accountName = c.getString(c.getColumnIndex("account"));
                    String accountType = hasType ? c.getString(c.getColumnIndex("account_type")) : null;
                    if (accountType == null) {
                        accountType = "com.google";
                    }
                    authority = getOrCreateAuthorityLocked(new EndPoint(new Account(accountName, accountType), c.getString(c.getColumnIndex("authority")), STATUS_FILE_END), -1, SYNC_ENABLED_DEFAULT);
                    if (authority != null) {
                        i = this.mSyncStatus.size();
                        boolean found = SYNC_ENABLED_DEFAULT;
                        SyncStatusInfo st = null;
                        while (i > 0) {
                            i--;
                            st = (SyncStatusInfo) this.mSyncStatus.valueAt(i);
                            if (st.authorityId == authority.ident) {
                                found = true;
                                break;
                            }
                        }
                        if (!found) {
                            SyncStatusInfo syncStatusInfo = new SyncStatusInfo(authority.ident);
                            this.mSyncStatus.put(authority.ident, syncStatusInfo);
                        }
                        st.totalElapsedTime = getLongColumn(c, "totalElapsedTime");
                        st.numSyncs = getIntColumn(c, "numSyncs");
                        st.numSourceLocal = getIntColumn(c, "numSourceLocal");
                        st.numSourcePoll = getIntColumn(c, "numSourcePoll");
                        st.numSourceServer = getIntColumn(c, "numSourceServer");
                        st.numSourceUser = getIntColumn(c, "numSourceUser");
                        st.numSourcePeriodic = STATUS_FILE_END;
                        st.lastSuccessSource = getIntColumn(c, "lastSuccessSource");
                        st.lastSuccessTime = getLongColumn(c, "lastSuccessTime");
                        st.lastFailureSource = getIntColumn(c, "lastFailureSource");
                        st.lastFailureTime = getLongColumn(c, "lastFailureTime");
                        st.lastFailureMesg = c.getString(c.getColumnIndex("lastFailureMesg"));
                        if (getIntColumn(c, "pending") != 0) {
                            z = true;
                        } else {
                            z = SYNC_ENABLED_DEFAULT;
                        }
                        st.pending = z;
                    }
                }
                c.close();
                qb = new SQLiteQueryBuilder();
                qb.setTables("settings");
                c = qb.query(db, null, null, null, null, null, null);
                while (c.moveToNext()) {
                    String name = c.getString(c.getColumnIndex("name"));
                    String value = c.getString(c.getColumnIndex("value"));
                    if (name != null) {
                        if (name.equals("listen_for_tickles")) {
                            z = (value == null || Boolean.parseBoolean(value)) ? true : SYNC_ENABLED_DEFAULT;
                            setMasterSyncAutomatically(z, STATUS_FILE_END);
                        } else {
                            if (name.startsWith("sync_provider_")) {
                                String provider = name.substring("sync_provider_".length(), name.length());
                                i = this.mAuthorities.size();
                                while (i > 0) {
                                    i--;
                                    authority = (AuthorityInfo) this.mAuthorities.valueAt(i);
                                    if (authority.target.provider.equals(provider)) {
                                        z = (value == null || Boolean.parseBoolean(value)) ? true : SYNC_ENABLED_DEFAULT;
                                        authority.enabled = z;
                                        authority.syncable = SOURCE_LOCAL;
                                    }
                                }
                            }
                        }
                    }
                }
                c.close();
                db.close();
                new File(path).delete();
            }
        }
    }

    private void readStatusLocked() {
        if (Log.isLoggable(TAG_FILE, SOURCE_POLL)) {
            Log.v(TAG_FILE, "Reading " + this.mStatusFile.getBaseFile());
        }
        try {
            byte[] data = this.mStatusFile.readFully();
            Parcel in = Parcel.obtain();
            in.unmarshall(data, STATUS_FILE_END, data.length);
            in.setDataPosition(STATUS_FILE_END);
            while (true) {
                int token = in.readInt();
                if (token == 0) {
                    return;
                }
                if (token == STATUS_FILE_ITEM) {
                    SyncStatusInfo status = new SyncStatusInfo(in);
                    if (this.mAuthorities.indexOfKey(status.authorityId) >= 0) {
                        status.pending = SYNC_ENABLED_DEFAULT;
                        if (Log.isLoggable(TAG_FILE, SOURCE_POLL)) {
                            Log.v(TAG_FILE, "Adding status for id " + status.authorityId);
                        }
                        this.mSyncStatus.put(status.authorityId, status);
                    }
                } else {
                    Log.w(TAG, "Unknown status token: " + token);
                    return;
                }
            }
        } catch (IOException e) {
            Log.i(TAG, "No initial status");
        }
    }

    private void writeStatusLocked() {
        if (Log.isLoggable(TAG_FILE, SOURCE_POLL)) {
            Log.v(TAG_FILE, "Writing new " + this.mStatusFile.getBaseFile());
        }
        removeMessages(SOURCE_LOCAL);
        try {
            FileOutputStream fos = this.mStatusFile.startWrite();
            Parcel out = Parcel.obtain();
            int N = this.mSyncStatus.size();
            for (int i = STATUS_FILE_END; i < N; i += SOURCE_LOCAL) {
                SyncStatusInfo status = (SyncStatusInfo) this.mSyncStatus.valueAt(i);
                out.writeInt(STATUS_FILE_ITEM);
                status.writeToParcel(out, STATUS_FILE_END);
            }
            out.writeInt(STATUS_FILE_END);
            fos.write(out.marshall());
            out.recycle();
            this.mStatusFile.finishWrite(fos);
        } catch (IOException e1) {
            Log.w(TAG, "Error writing status", e1);
            if (STATUS_FILE_END != null) {
                this.mStatusFile.failWrite(null);
            }
        }
    }

    private void readPendingOperationsLocked() {
        NumberFormatException e;
        FileInputStream fis = null;
        if (this.mPendingFile.getBaseFile().exists()) {
            try {
                fis = this.mPendingFile.openRead();
                if (Log.isLoggable(TAG_FILE, SOURCE_POLL)) {
                    Log.v(TAG_FILE, "Reading " + this.mPendingFile.getBaseFile());
                }
                XmlPullParser parser = Xml.newPullParser();
                parser.setInput(fis, StandardCharsets.UTF_8.name());
                int eventType = parser.getEventType();
                while (eventType != SOURCE_POLL && eventType != SOURCE_LOCAL) {
                    eventType = parser.next();
                }
                if (eventType != SOURCE_LOCAL) {
                    do {
                        PendingOperation pop;
                        if (eventType == SOURCE_POLL) {
                            try {
                                String tagName = parser.getName();
                                if (parser.getDepth() == SOURCE_LOCAL && "op".equals(tagName)) {
                                    String versionString = parser.getAttributeValue(null, XML_ATTR_VERSION);
                                    if (versionString == null || Integer.parseInt(versionString) != SOURCE_USER) {
                                        Log.w(TAG, "Unknown pending operation version " + versionString);
                                        throw new IOException("Unknown version.");
                                    }
                                    int authorityId = Integer.valueOf(parser.getAttributeValue(null, XML_ATTR_AUTHORITYID)).intValue();
                                    boolean expedited = Boolean.valueOf(parser.getAttributeValue(null, XML_ATTR_EXPEDITED)).booleanValue();
                                    int syncSource = Integer.valueOf(parser.getAttributeValue(null, XML_ATTR_SOURCE)).intValue();
                                    int reason = Integer.valueOf(parser.getAttributeValue(null, XML_ATTR_REASON)).intValue();
                                    AuthorityInfo authority = (AuthorityInfo) this.mAuthorities.get(authorityId);
                                    if (Log.isLoggable(TAG_FILE, SOURCE_POLL)) {
                                        Log.v(TAG_FILE, authorityId + " " + expedited + " " + syncSource + " " + reason);
                                    }
                                    if (authority != null) {
                                        pop = new PendingOperation(authority, reason, syncSource, new Bundle(), expedited);
                                        try {
                                            pop.flatExtras = null;
                                            this.mPendingOperations.add(pop);
                                            if (Log.isLoggable(TAG_FILE, SOURCE_POLL)) {
                                                EndPoint endPoint = pop.target;
                                                int i = pop.syncSource;
                                                i = pop.reason;
                                                Log.v(TAG_FILE, "Adding pending op: " + r0 + " src=" + r0 + " reason=" + r0 + " expedited=" + pop.expedited);
                                            }
                                        } catch (NumberFormatException e2) {
                                            e = e2;
                                            Log.d(TAG, "Invalid data in xml file.", e);
                                            eventType = parser.next();
                                            if (eventType == SOURCE_LOCAL) {
                                                if (fis == null) {
                                                    try {
                                                        fis.close();
                                                    } catch (IOException e3) {
                                                        return;
                                                    }
                                                }
                                            }
                                        }
                                    } else if (Log.isLoggable(TAG_FILE, SOURCE_POLL)) {
                                        Log.v(TAG_FILE, "No authority found for " + authorityId + ", skipping");
                                    }
                                    eventType = parser.next();
                                } else if (parser.getDepth() == SOURCE_POLL && STATUS_FILE_END != null && "extra".equals(tagName)) {
                                    parseExtra(parser, STATUS_FILE_END.extras);
                                }
                            } catch (NumberFormatException e4) {
                                e = e4;
                                pop = null;
                                Log.d(TAG, "Invalid data in xml file.", e);
                                eventType = parser.next();
                                if (eventType == SOURCE_LOCAL) {
                                    if (fis == null) {
                                        fis.close();
                                    }
                                }
                            }
                        }
                        pop = null;
                        eventType = parser.next();
                    } while (eventType == SOURCE_LOCAL);
                    if (fis == null) {
                        fis.close();
                    }
                } else if (fis != null) {
                    try {
                        fis.close();
                    } catch (IOException e5) {
                    }
                }
            } catch (IOException e6) {
                Log.w(TAG_FILE, "Error reading pending data.", e6);
                if (fis != null) {
                    try {
                        fis.close();
                    } catch (IOException e7) {
                    }
                }
            } catch (XmlPullParserException e8) {
                if (Log.isLoggable(TAG_FILE, SOURCE_POLL)) {
                    Log.w(TAG_FILE, "Error parsing pending ops xml.", e8);
                }
                if (fis != null) {
                    try {
                        fis.close();
                    } catch (IOException e9) {
                    }
                }
            } catch (Throwable th) {
                if (fis != null) {
                    try {
                        fis.close();
                    } catch (IOException e10) {
                    }
                }
            }
        } else if (Log.isLoggable(TAG_FILE, SOURCE_POLL)) {
            Log.v(TAG_FILE, "No pending operation file.");
        }
    }

    private static byte[] flattenBundle(Bundle bundle) {
        byte[] flatData = null;
        Parcel parcel = Parcel.obtain();
        try {
            bundle.writeToParcel(parcel, STATUS_FILE_END);
            flatData = parcel.marshall();
            return flatData;
        } finally {
            parcel.recycle();
        }
    }

    private static Bundle unflattenBundle(byte[] flatData) {
        Bundle bundle;
        Parcel parcel = Parcel.obtain();
        try {
            parcel.unmarshall(flatData, STATUS_FILE_END, flatData.length);
            parcel.setDataPosition(STATUS_FILE_END);
            bundle = parcel.readBundle();
        } catch (RuntimeException e) {
            bundle = new Bundle();
        } finally {
            parcel.recycle();
        }
        return bundle;
    }

    private void writePendingOperationsLocked() {
        int N = this.mPendingOperations.size();
        if (N == 0) {
            try {
                if (Log.isLoggable(TAG_FILE, SOURCE_POLL)) {
                    Log.v(TAG, "Truncating " + this.mPendingFile.getBaseFile());
                }
                this.mPendingFile.truncate();
                return;
            } catch (IOException e1) {
                Log.w(TAG, "Error writing pending operations", e1);
                if (STATUS_FILE_END != null) {
                    this.mPendingFile.failWrite(null);
                    return;
                }
                return;
            }
        }
        if (Log.isLoggable(TAG_FILE, SOURCE_POLL)) {
            Log.v(TAG, "Writing new " + this.mPendingFile.getBaseFile());
        }
        FileOutputStream fos = this.mPendingFile.startWrite();
        XmlSerializer out = new FastXmlSerializer();
        out.setOutput(fos, StandardCharsets.UTF_8.name());
        for (int i = STATUS_FILE_END; i < N; i += SOURCE_LOCAL) {
            writePendingOperationLocked((PendingOperation) this.mPendingOperations.get(i), out);
        }
        out.endDocument();
        this.mPendingFile.finishWrite(fos);
    }

    private void writePendingOperationLocked(PendingOperation pop, XmlSerializer out) throws IOException {
        out.startTag(null, "op");
        out.attribute(null, XML_ATTR_VERSION, Integer.toString(SOURCE_USER));
        out.attribute(null, XML_ATTR_AUTHORITYID, Integer.toString(pop.authorityId));
        out.attribute(null, XML_ATTR_SOURCE, Integer.toString(pop.syncSource));
        out.attribute(null, XML_ATTR_EXPEDITED, Boolean.toString(pop.expedited));
        out.attribute(null, XML_ATTR_REASON, Integer.toString(pop.reason));
        extrasToXml(out, pop.extras);
        out.endTag(null, "op");
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void appendPendingOperationLocked(com.android.server.content.SyncStorageEngine.PendingOperation r9) {
        /*
        r8 = this;
        r7 = 2;
        r4 = "SyncManagerFile";
        r4 = android.util.Log.isLoggable(r4, r7);
        if (r4 == 0) goto L_0x0027;
    L_0x0009:
        r4 = "SyncManager";
        r5 = new java.lang.StringBuilder;
        r5.<init>();
        r6 = "Appending to ";
        r5 = r5.append(r6);
        r6 = r8.mPendingFile;
        r6 = r6.getBaseFile();
        r5 = r5.append(r6);
        r5 = r5.toString();
        android.util.Log.v(r4, r5);
    L_0x0027:
        r2 = 0;
        r4 = r8.mPendingFile;	 Catch:{ IOException -> 0x004b }
        r2 = r4.openAppend();	 Catch:{ IOException -> 0x004b }
        r3 = new com.android.internal.util.FastXmlSerializer;	 Catch:{ IOException -> 0x005f }
        r3.<init>();	 Catch:{ IOException -> 0x005f }
        r4 = java.nio.charset.StandardCharsets.UTF_8;	 Catch:{ IOException -> 0x005f }
        r4 = r4.name();	 Catch:{ IOException -> 0x005f }
        r3.setOutput(r2, r4);	 Catch:{ IOException -> 0x005f }
        r8.writePendingOperationLocked(r9, r3);	 Catch:{ IOException -> 0x005f }
        r3.endDocument();	 Catch:{ IOException -> 0x005f }
        r4 = r8.mPendingFile;	 Catch:{ IOException -> 0x005f }
        r4.finishWrite(r2);	 Catch:{ IOException -> 0x005f }
        r2.close();	 Catch:{ IOException -> 0x0077 }
    L_0x004a:
        return;
    L_0x004b:
        r0 = move-exception;
        r4 = "SyncManagerFile";
        r4 = android.util.Log.isLoggable(r4, r7);
        if (r4 == 0) goto L_0x005b;
    L_0x0054:
        r4 = "SyncManager";
        r5 = "Failed append; writing full file";
        android.util.Log.v(r4, r5);
    L_0x005b:
        r8.writePendingOperationsLocked();
        goto L_0x004a;
    L_0x005f:
        r1 = move-exception;
        r4 = "SyncManager";
        r5 = "Error writing appending operation";
        android.util.Log.w(r4, r5, r1);	 Catch:{ all -> 0x0072 }
        r4 = r8.mPendingFile;	 Catch:{ all -> 0x0072 }
        r4.failWrite(r2);	 Catch:{ all -> 0x0072 }
        r2.close();	 Catch:{ IOException -> 0x0070 }
        goto L_0x004a;
    L_0x0070:
        r4 = move-exception;
        goto L_0x004a;
    L_0x0072:
        r4 = move-exception;
        r2.close();	 Catch:{ IOException -> 0x0079 }
    L_0x0076:
        throw r4;
    L_0x0077:
        r4 = move-exception;
        goto L_0x004a;
    L_0x0079:
        r5 = move-exception;
        goto L_0x0076;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.content.SyncStorageEngine.appendPendingOperationLocked(com.android.server.content.SyncStorageEngine$PendingOperation):void");
    }

    private void extrasToXml(XmlSerializer out, Bundle extras) throws IOException {
        for (String key : extras.keySet()) {
            out.startTag(null, "extra");
            out.attribute(null, "name", key);
            Object value = extras.get(key);
            if (value instanceof Long) {
                out.attribute(null, SoundModelContract.KEY_TYPE, "long");
                out.attribute(null, "value1", value.toString());
            } else if (value instanceof Integer) {
                out.attribute(null, SoundModelContract.KEY_TYPE, "integer");
                out.attribute(null, "value1", value.toString());
            } else if (value instanceof Boolean) {
                out.attribute(null, SoundModelContract.KEY_TYPE, "boolean");
                out.attribute(null, "value1", value.toString());
            } else if (value instanceof Float) {
                out.attribute(null, SoundModelContract.KEY_TYPE, "float");
                out.attribute(null, "value1", value.toString());
            } else if (value instanceof Double) {
                out.attribute(null, SoundModelContract.KEY_TYPE, "double");
                out.attribute(null, "value1", value.toString());
            } else if (value instanceof String) {
                out.attribute(null, SoundModelContract.KEY_TYPE, "string");
                out.attribute(null, "value1", value.toString());
            } else if (value instanceof Account) {
                out.attribute(null, SoundModelContract.KEY_TYPE, "account");
                out.attribute(null, "value1", ((Account) value).name);
                out.attribute(null, "value2", ((Account) value).type);
            }
            out.endTag(null, "extra");
        }
    }

    private void requestSync(AuthorityInfo authorityInfo, int reason, Bundle extras) {
        if (Process.myUid() != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE || this.mSyncRequestListener == null) {
            Builder req = new Builder().syncOnce().setExtras(extras);
            if (authorityInfo.target.target_provider) {
                req.setSyncAdapter(authorityInfo.target.account, authorityInfo.target.provider);
                ContentResolver.requestSync(req.build());
                return;
            } else if (Log.isLoggable(TAG, SOURCE_USER)) {
                Log.d(TAG, "Unknown target, skipping sync request.");
                return;
            } else {
                return;
            }
        }
        this.mSyncRequestListener.onSyncRequest(authorityInfo.target, reason, extras);
    }

    private void requestSync(Account account, int userId, int reason, String authority, Bundle extras) {
        if (Process.myUid() != ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE || this.mSyncRequestListener == null) {
            ContentResolver.requestSync(account, authority, extras);
        } else {
            this.mSyncRequestListener.onSyncRequest(new EndPoint(account, authority, userId), reason, extras);
        }
    }

    private void readStatisticsLocked() {
        try {
            byte[] data = this.mStatisticsFile.readFully();
            Parcel in = Parcel.obtain();
            in.unmarshall(data, STATUS_FILE_END, data.length);
            in.setDataPosition(STATUS_FILE_END);
            int index = STATUS_FILE_END;
            while (true) {
                int token = in.readInt();
                if (token == 0) {
                    return;
                }
                if (token == STATISTICS_FILE_ITEM || token == STATUS_FILE_ITEM) {
                    int day = in.readInt();
                    if (token == STATUS_FILE_ITEM) {
                        day = (day - 2009) + 14245;
                    }
                    DayStats ds = new DayStats(day);
                    ds.successCount = in.readInt();
                    ds.successTime = in.readLong();
                    ds.failureCount = in.readInt();
                    ds.failureTime = in.readLong();
                    if (index < this.mDayStats.length) {
                        this.mDayStats[index] = ds;
                        index += SOURCE_LOCAL;
                    }
                } else {
                    Log.w(TAG, "Unknown stats token: " + token);
                    return;
                }
            }
        } catch (IOException e) {
            Log.i(TAG, "No initial statistics");
        }
    }

    private void writeStatisticsLocked() {
        if (Log.isLoggable(TAG_FILE, SOURCE_POLL)) {
            Log.v(TAG, "Writing new " + this.mStatisticsFile.getBaseFile());
        }
        removeMessages(SOURCE_POLL);
        try {
            FileOutputStream fos = this.mStatisticsFile.startWrite();
            Parcel out = Parcel.obtain();
            int N = this.mDayStats.length;
            for (int i = STATUS_FILE_END; i < N; i += SOURCE_LOCAL) {
                DayStats ds = this.mDayStats[i];
                if (ds == null) {
                    break;
                }
                out.writeInt(STATISTICS_FILE_ITEM);
                out.writeInt(ds.day);
                out.writeInt(ds.successCount);
                out.writeLong(ds.successTime);
                out.writeInt(ds.failureCount);
                out.writeLong(ds.failureTime);
            }
            out.writeInt(STATUS_FILE_END);
            fos.write(out.marshall());
            out.recycle();
            this.mStatisticsFile.finishWrite(fos);
        } catch (IOException e1) {
            Log.w(TAG, "Error writing stats", e1);
            if (STATUS_FILE_END != null) {
                this.mStatisticsFile.failWrite(null);
            }
        }
    }

    public void dumpPendingOperations(StringBuilder sb) {
        sb.append("Pending Ops: ").append(this.mPendingOperations.size()).append(" operation(s)\n");
        Iterator i$ = this.mPendingOperations.iterator();
        while (i$.hasNext()) {
            PendingOperation pop = (PendingOperation) i$.next();
            sb.append("(info: " + pop.target.toString()).append(", extras: " + pop.extras).append(")\n");
        }
    }
}
