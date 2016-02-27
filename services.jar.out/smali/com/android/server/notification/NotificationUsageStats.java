package com.android.server.notification;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteDatabase.CursorFactory;
import android.database.sqlite.SQLiteOpenHelper;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.Looper;
import android.os.Message;
import android.os.SystemClock;
import android.util.Log;
import com.android.server.notification.NotificationManagerService.DumpFilter;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

public class NotificationUsageStats {
    private static final AggregatedStats[] EMPTY_AGGREGATED_STATS;
    private static final boolean ENABLE_AGGREGATED_IN_MEMORY_STATS = false;
    private static final boolean ENABLE_SQLITE_LOG = false;
    private final SQLiteLog mSQLiteLog;
    private final Map<String, AggregatedStats> mStats;

    public static class Aggregate {
        double avg;
        long numSamples;
        double sum2;
        double var;

        public void addSample(long sample) {
            double divisor = 1.0d;
            this.numSamples++;
            double n = (double) this.numSamples;
            double delta = ((double) sample) - this.avg;
            this.avg += (1.0d / n) * delta;
            this.sum2 += (((n - 1.0d) / n) * delta) * delta;
            if (this.numSamples != 1) {
                divisor = n - 1.0d;
            }
            this.var = this.sum2 / divisor;
        }

        public String toString() {
            return "Aggregate{numSamples=" + this.numSamples + ", avg=" + this.avg + ", var=" + this.var + '}';
        }
    }

    private static class AggregatedStats {
        public final Aggregate airtimeCount;
        public final Aggregate airtimeExpandedMs;
        public final Aggregate airtimeMs;
        public final String key;
        public int numClickedByUser;
        public int numDismissedByUser;
        public int numPostedByApp;
        public int numRemovedByApp;
        public int numUpdatedByApp;
        public final Aggregate posttimeMs;
        public final Aggregate posttimeToDismissMs;
        public final Aggregate posttimeToFirstAirtimeMs;
        public final Aggregate posttimeToFirstClickMs;
        public final Aggregate posttimeToFirstVisibleExpansionMs;
        public final Aggregate userExpansionCount;

        public AggregatedStats(String key) {
            this.posttimeMs = new Aggregate();
            this.posttimeToDismissMs = new Aggregate();
            this.posttimeToFirstClickMs = new Aggregate();
            this.airtimeCount = new Aggregate();
            this.airtimeMs = new Aggregate();
            this.posttimeToFirstAirtimeMs = new Aggregate();
            this.userExpansionCount = new Aggregate();
            this.airtimeExpandedMs = new Aggregate();
            this.posttimeToFirstVisibleExpansionMs = new Aggregate();
            this.key = key;
        }

        public void collect(SingleNotificationStats singleNotificationStats) {
            this.posttimeMs.addSample(SystemClock.elapsedRealtime() - singleNotificationStats.posttimeElapsedMs);
            if (singleNotificationStats.posttimeToDismissMs >= 0) {
                this.posttimeToDismissMs.addSample(singleNotificationStats.posttimeToDismissMs);
            }
            if (singleNotificationStats.posttimeToFirstClickMs >= 0) {
                this.posttimeToFirstClickMs.addSample(singleNotificationStats.posttimeToFirstClickMs);
            }
            this.airtimeCount.addSample(singleNotificationStats.airtimeCount);
            if (singleNotificationStats.airtimeMs >= 0) {
                this.airtimeMs.addSample(singleNotificationStats.airtimeMs);
            }
            if (singleNotificationStats.posttimeToFirstAirtimeMs >= 0) {
                this.posttimeToFirstAirtimeMs.addSample(singleNotificationStats.posttimeToFirstAirtimeMs);
            }
            if (singleNotificationStats.posttimeToFirstVisibleExpansionMs >= 0) {
                this.posttimeToFirstVisibleExpansionMs.addSample(singleNotificationStats.posttimeToFirstVisibleExpansionMs);
            }
            this.userExpansionCount.addSample(singleNotificationStats.userExpansionCount);
            if (singleNotificationStats.airtimeExpandedMs >= 0) {
                this.airtimeExpandedMs.addSample(singleNotificationStats.airtimeExpandedMs);
            }
        }

        public void dump(PrintWriter pw, String indent) {
            pw.println(toStringWithIndent(indent));
        }

        public String toString() {
            return toStringWithIndent("");
        }

        private String toStringWithIndent(String indent) {
            return indent + "AggregatedStats{\n" + indent + "  key='" + this.key + "',\n" + indent + "  numPostedByApp=" + this.numPostedByApp + ",\n" + indent + "  numUpdatedByApp=" + this.numUpdatedByApp + ",\n" + indent + "  numRemovedByApp=" + this.numRemovedByApp + ",\n" + indent + "  numClickedByUser=" + this.numClickedByUser + ",\n" + indent + "  numDismissedByUser=" + this.numDismissedByUser + ",\n" + indent + "  posttimeMs=" + this.posttimeMs + ",\n" + indent + "  posttimeToDismissMs=" + this.posttimeToDismissMs + ",\n" + indent + "  posttimeToFirstClickMs=" + this.posttimeToFirstClickMs + ",\n" + indent + "  airtimeCount=" + this.airtimeCount + ",\n" + indent + "  airtimeMs=" + this.airtimeMs + ",\n" + indent + "  posttimeToFirstAirtimeMs=" + this.posttimeToFirstAirtimeMs + ",\n" + indent + "  userExpansionCount=" + this.userExpansionCount + ",\n" + indent + "  airtimeExpandedMs=" + this.airtimeExpandedMs + ",\n" + indent + "  posttimeToFVEMs=" + this.posttimeToFirstVisibleExpansionMs + ",\n" + indent + "}";
        }
    }

    private static class SQLiteLog {
        private static final String COL_ACTION_COUNT = "action_count";
        private static final String COL_AIRTIME_EXPANDED_MS = "expansion_airtime_ms";
        private static final String COL_AIRTIME_MS = "airtime_ms";
        private static final String COL_CATEGORY = "category";
        private static final String COL_DEFAULTS = "defaults";
        private static final String COL_EVENT_TIME = "event_time_ms";
        private static final String COL_EVENT_TYPE = "event_type";
        private static final String COL_EVENT_USER_ID = "event_user_id";
        private static final String COL_EXPAND_COUNT = "expansion_count";
        private static final String COL_FIRST_EXPANSIONTIME_MS = "first_expansion_time_ms";
        private static final String COL_FLAGS = "flags";
        private static final String COL_KEY = "key";
        private static final String COL_NOTIFICATION_ID = "nid";
        private static final String COL_PKG = "pkg";
        private static final String COL_POSTTIME_MS = "posttime_ms";
        private static final String COL_PRIORITY = "priority";
        private static final String COL_TAG = "tag";
        private static final String COL_WHEN_MS = "when_ms";
        private static final long DAY_MS = 86400000;
        private static final String DB_NAME = "notification_log.db";
        private static final int DB_VERSION = 4;
        private static final int EVENT_TYPE_CLICK = 2;
        private static final int EVENT_TYPE_DISMISS = 4;
        private static final int EVENT_TYPE_POST = 1;
        private static final int EVENT_TYPE_REMOVE = 3;
        private static final long HORIZON_MS = 604800000;
        private static final int MSG_CLICK = 2;
        private static final int MSG_DISMISS = 4;
        private static final int MSG_POST = 1;
        private static final int MSG_REMOVE = 3;
        private static final long PRUNE_MIN_DELAY_MS = 21600000;
        private static final long PRUNE_MIN_WRITES = 1024;
        private static final String TAB_LOG = "log";
        private static final String TAG = "NotificationSQLiteLog";
        private static long sLastPruneMs;
        private static long sNumWrites;
        private final SQLiteOpenHelper mHelper;
        private final Handler mWriteHandler;

        /* renamed from: com.android.server.notification.NotificationUsageStats.SQLiteLog.1 */
        class C04341 extends Handler {
            C04341(Looper x0) {
                super(x0);
            }

            public void handleMessage(Message msg) {
                NotificationRecord r = msg.obj;
                long nowMs = System.currentTimeMillis();
                switch (msg.what) {
                    case SQLiteLog.MSG_POST /*1*/:
                        SQLiteLog.this.writeEvent(r.sbn.getPostTime(), SQLiteLog.MSG_POST, r);
                    case SQLiteLog.MSG_CLICK /*2*/:
                        SQLiteLog.this.writeEvent(nowMs, SQLiteLog.MSG_CLICK, r);
                    case SQLiteLog.MSG_REMOVE /*3*/:
                        SQLiteLog.this.writeEvent(nowMs, SQLiteLog.MSG_REMOVE, r);
                    case SQLiteLog.MSG_DISMISS /*4*/:
                        SQLiteLog.this.writeEvent(nowMs, SQLiteLog.MSG_DISMISS, r);
                    default:
                        Log.wtf(SQLiteLog.TAG, "Unknown message type: " + msg.what);
                }
            }
        }

        /* renamed from: com.android.server.notification.NotificationUsageStats.SQLiteLog.2 */
        class C04352 extends SQLiteOpenHelper {
            C04352(Context x0, String x1, CursorFactory x2, int x3) {
                super(x0, x1, x2, x3);
            }

            public void onCreate(SQLiteDatabase db) {
                db.execSQL("CREATE TABLE log (_id INTEGER PRIMARY KEY AUTOINCREMENT,event_user_id INT,event_type INT,event_time_ms INT,key TEXT,pkg TEXT,nid INT,tag TEXT,when_ms INT,defaults INT,flags INT,priority INT,category TEXT,action_count INT,posttime_ms INT,airtime_ms INT,first_expansion_time_ms INT,expansion_airtime_ms INT,expansion_count INT)");
            }

            public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
                if (oldVersion <= SQLiteLog.MSG_REMOVE) {
                    db.execSQL("DROP TABLE IF EXISTS log");
                    onCreate(db);
                }
            }
        }

        public SQLiteLog(Context context) {
            HandlerThread backgroundThread = new HandlerThread("notification-sqlite-log", 10);
            backgroundThread.start();
            this.mWriteHandler = new C04341(backgroundThread.getLooper());
            this.mHelper = new C04352(context, DB_NAME, null, MSG_DISMISS);
        }

        public void logPosted(NotificationRecord notification) {
            this.mWriteHandler.sendMessage(this.mWriteHandler.obtainMessage(MSG_POST, notification));
        }

        public void logClicked(NotificationRecord notification) {
            this.mWriteHandler.sendMessage(this.mWriteHandler.obtainMessage(MSG_CLICK, notification));
        }

        public void logRemoved(NotificationRecord notification) {
            this.mWriteHandler.sendMessage(this.mWriteHandler.obtainMessage(MSG_REMOVE, notification));
        }

        public void logDismissed(NotificationRecord notification) {
            this.mWriteHandler.sendMessage(this.mWriteHandler.obtainMessage(MSG_DISMISS, notification));
        }

        public void printPostFrequencies(PrintWriter pw, String indent, DumpFilter filter) {
            Cursor cursor = this.mHelper.getReadableDatabase().rawQuery("SELECT event_user_id, pkg, CAST(((" + System.currentTimeMillis() + " - " + COL_EVENT_TIME + ") / " + DAY_MS + ") AS int) " + "AS day, " + "COUNT(*) AS cnt " + "FROM " + TAB_LOG + " " + "WHERE " + COL_EVENT_TYPE + "=" + MSG_POST + " " + "GROUP BY " + COL_EVENT_USER_ID + ", day, " + COL_PKG, null);
            try {
                cursor.moveToFirst();
                while (!cursor.isAfterLast()) {
                    int userId = cursor.getInt(0);
                    String pkg = cursor.getString(MSG_POST);
                    if (filter == null || filter.matches(pkg)) {
                        int day = cursor.getInt(MSG_CLICK);
                        pw.println(indent + "post_frequency{user_id=" + userId + ",pkg=" + pkg + ",day=" + day + ",count=" + cursor.getInt(MSG_REMOVE) + "}");
                    }
                    cursor.moveToNext();
                }
            } finally {
                cursor.close();
            }
        }

        private void writeEvent(long eventTimeMs, int eventType, NotificationRecord r) {
            ContentValues cv = new ContentValues();
            cv.put(COL_EVENT_USER_ID, Integer.valueOf(r.sbn.getUser().getIdentifier()));
            cv.put(COL_EVENT_TIME, Long.valueOf(eventTimeMs));
            cv.put(COL_EVENT_TYPE, Integer.valueOf(eventType));
            putNotificationIdentifiers(r, cv);
            if (eventType == MSG_POST) {
                putNotificationDetails(r, cv);
            } else {
                putPosttimeVisibility(r, cv);
            }
            SQLiteDatabase db = this.mHelper.getWritableDatabase();
            if (db.insert(TAB_LOG, null, cv) < 0) {
                Log.wtf(TAG, "Error while trying to insert values: " + cv);
            }
            sNumWrites++;
            pruneIfNecessary(db);
        }

        private void pruneIfNecessary(SQLiteDatabase db) {
            long nowMs = System.currentTimeMillis();
            if (sNumWrites > PRUNE_MIN_WRITES || nowMs - sLastPruneMs > PRUNE_MIN_DELAY_MS) {
                sNumWrites = 0;
                sLastPruneMs = nowMs;
                String[] strArr = new String[MSG_POST];
                strArr[0] = String.valueOf(nowMs - HORIZON_MS);
                Log.d(TAG, "Pruned event entries: " + db.delete(TAB_LOG, "event_time_ms < ?", strArr));
            }
        }

        private static void putNotificationIdentifiers(NotificationRecord r, ContentValues outCv) {
            outCv.put(COL_KEY, r.sbn.getKey());
            outCv.put(COL_PKG, r.sbn.getPackageName());
        }

        private static void putNotificationDetails(NotificationRecord r, ContentValues outCv) {
            outCv.put(COL_NOTIFICATION_ID, Integer.valueOf(r.sbn.getId()));
            if (r.sbn.getTag() != null) {
                outCv.put(COL_TAG, r.sbn.getTag());
            }
            outCv.put(COL_WHEN_MS, Long.valueOf(r.sbn.getPostTime()));
            outCv.put(COL_FLAGS, Integer.valueOf(r.getNotification().flags));
            outCv.put(COL_PRIORITY, Integer.valueOf(r.getNotification().priority));
            if (r.getNotification().category != null) {
                outCv.put(COL_CATEGORY, r.getNotification().category);
            }
            outCv.put(COL_ACTION_COUNT, Integer.valueOf(r.getNotification().actions != null ? r.getNotification().actions.length : 0));
        }

        private static void putPosttimeVisibility(NotificationRecord r, ContentValues outCv) {
            outCv.put(COL_POSTTIME_MS, Long.valueOf(r.stats.getCurrentPosttimeMs()));
            outCv.put(COL_AIRTIME_MS, Long.valueOf(r.stats.getCurrentAirtimeMs()));
            outCv.put(COL_EXPAND_COUNT, Long.valueOf(r.stats.userExpansionCount));
            outCv.put(COL_AIRTIME_EXPANDED_MS, Long.valueOf(r.stats.getCurrentAirtimeExpandedMs()));
            outCv.put(COL_FIRST_EXPANSIONTIME_MS, Long.valueOf(r.stats.posttimeToFirstVisibleExpansionMs));
        }

        public void dump(PrintWriter pw, String indent, DumpFilter filter) {
            printPostFrequencies(pw, indent, filter);
        }
    }

    public static class SingleNotificationStats {
        public long airtimeCount;
        public long airtimeExpandedMs;
        public long airtimeMs;
        public long currentAirtimeExpandedStartElapsedMs;
        public long currentAirtimeStartElapsedMs;
        private boolean isExpanded;
        private boolean isVisible;
        public long posttimeElapsedMs;
        public long posttimeToDismissMs;
        public long posttimeToFirstAirtimeMs;
        public long posttimeToFirstClickMs;
        public long posttimeToFirstVisibleExpansionMs;
        public long userExpansionCount;

        public SingleNotificationStats() {
            this.isVisible = false;
            this.isExpanded = false;
            this.posttimeElapsedMs = -1;
            this.posttimeToFirstClickMs = -1;
            this.posttimeToDismissMs = -1;
            this.airtimeCount = 0;
            this.posttimeToFirstAirtimeMs = -1;
            this.currentAirtimeStartElapsedMs = -1;
            this.airtimeMs = 0;
            this.posttimeToFirstVisibleExpansionMs = -1;
            this.currentAirtimeExpandedStartElapsedMs = -1;
            this.airtimeExpandedMs = 0;
            this.userExpansionCount = 0;
        }

        public long getCurrentPosttimeMs() {
            if (this.posttimeElapsedMs < 0) {
                return 0;
            }
            return SystemClock.elapsedRealtime() - this.posttimeElapsedMs;
        }

        public long getCurrentAirtimeMs() {
            long result = this.airtimeMs;
            if (this.currentAirtimeStartElapsedMs >= 0) {
                return result + (SystemClock.elapsedRealtime() - this.currentAirtimeStartElapsedMs);
            }
            return result;
        }

        public long getCurrentAirtimeExpandedMs() {
            long result = this.airtimeExpandedMs;
            if (this.currentAirtimeExpandedStartElapsedMs >= 0) {
                return result + (SystemClock.elapsedRealtime() - this.currentAirtimeExpandedStartElapsedMs);
            }
            return result;
        }

        public void onClick() {
            if (this.posttimeToFirstClickMs < 0) {
                this.posttimeToFirstClickMs = SystemClock.elapsedRealtime() - this.posttimeElapsedMs;
            }
        }

        public void onDismiss() {
            if (this.posttimeToDismissMs < 0) {
                this.posttimeToDismissMs = SystemClock.elapsedRealtime() - this.posttimeElapsedMs;
            }
            finish();
        }

        public void onCancel() {
            finish();
        }

        public void onRemoved() {
            finish();
        }

        public void onVisibilityChanged(boolean visible) {
            long elapsedNowMs = SystemClock.elapsedRealtime();
            boolean wasVisible = this.isVisible;
            this.isVisible = visible;
            if (visible) {
                if (this.currentAirtimeStartElapsedMs < 0) {
                    this.airtimeCount++;
                    this.currentAirtimeStartElapsedMs = elapsedNowMs;
                }
                if (this.posttimeToFirstAirtimeMs < 0) {
                    this.posttimeToFirstAirtimeMs = elapsedNowMs - this.posttimeElapsedMs;
                }
            } else if (this.currentAirtimeStartElapsedMs >= 0) {
                this.airtimeMs += elapsedNowMs - this.currentAirtimeStartElapsedMs;
                this.currentAirtimeStartElapsedMs = -1;
            }
            if (wasVisible != this.isVisible) {
                updateVisiblyExpandedStats();
            }
        }

        public void onExpansionChanged(boolean userAction, boolean expanded) {
            this.isExpanded = expanded;
            if (this.isExpanded && userAction) {
                this.userExpansionCount++;
            }
            updateVisiblyExpandedStats();
        }

        private void updateVisiblyExpandedStats() {
            long elapsedNowMs = SystemClock.elapsedRealtime();
            if (this.isExpanded && this.isVisible) {
                if (this.currentAirtimeExpandedStartElapsedMs < 0) {
                    this.currentAirtimeExpandedStartElapsedMs = elapsedNowMs;
                }
                if (this.posttimeToFirstVisibleExpansionMs < 0) {
                    this.posttimeToFirstVisibleExpansionMs = elapsedNowMs - this.posttimeElapsedMs;
                }
            } else if (this.currentAirtimeExpandedStartElapsedMs >= 0) {
                this.airtimeExpandedMs += elapsedNowMs - this.currentAirtimeExpandedStartElapsedMs;
                this.currentAirtimeExpandedStartElapsedMs = -1;
            }
        }

        public void finish() {
            onVisibilityChanged(false);
        }

        public String toString() {
            return "SingleNotificationStats{posttimeElapsedMs=" + this.posttimeElapsedMs + ", posttimeToFirstClickMs=" + this.posttimeToFirstClickMs + ", posttimeToDismissMs=" + this.posttimeToDismissMs + ", airtimeCount=" + this.airtimeCount + ", airtimeMs=" + this.airtimeMs + ", currentAirtimeStartElapsedMs=" + this.currentAirtimeStartElapsedMs + ", airtimeExpandedMs=" + this.airtimeExpandedMs + ", posttimeToFirstVisibleExpansionMs=" + this.posttimeToFirstVisibleExpansionMs + ", currentAirtimeExpandedSEMs=" + this.currentAirtimeExpandedStartElapsedMs + '}';
        }
    }

    static {
        EMPTY_AGGREGATED_STATS = new AggregatedStats[0];
    }

    public NotificationUsageStats(Context context) {
        this.mStats = new HashMap();
        this.mSQLiteLog = null;
    }

    public synchronized void registerPostedByApp(NotificationRecord notification) {
        notification.stats = new SingleNotificationStats();
        notification.stats.posttimeElapsedMs = SystemClock.elapsedRealtime();
        for (AggregatedStats stats : getAggregatedStatsLocked(notification)) {
            stats.numPostedByApp++;
        }
    }

    public void registerUpdatedByApp(NotificationRecord notification, NotificationRecord old) {
        notification.stats = old.stats;
        for (AggregatedStats stats : getAggregatedStatsLocked(notification)) {
            stats.numUpdatedByApp++;
        }
    }

    public synchronized void registerRemovedByApp(NotificationRecord notification) {
        notification.stats.onRemoved();
        for (AggregatedStats stats : getAggregatedStatsLocked(notification)) {
            stats.numRemovedByApp++;
            stats.collect(notification.stats);
        }
    }

    public synchronized void registerDismissedByUser(NotificationRecord notification) {
        notification.stats.onDismiss();
        for (AggregatedStats stats : getAggregatedStatsLocked(notification)) {
            stats.numDismissedByUser++;
            stats.collect(notification.stats);
        }
    }

    public synchronized void registerClickedByUser(NotificationRecord notification) {
        notification.stats.onClick();
        for (AggregatedStats stats : getAggregatedStatsLocked(notification)) {
            stats.numClickedByUser++;
        }
    }

    public synchronized void registerCancelDueToClick(NotificationRecord notification) {
        notification.stats.onCancel();
        for (AggregatedStats stats : getAggregatedStatsLocked(notification)) {
            stats.collect(notification.stats);
        }
    }

    public synchronized void registerCancelUnknown(NotificationRecord notification) {
        notification.stats.onCancel();
        for (AggregatedStats stats : getAggregatedStatsLocked(notification)) {
            stats.collect(notification.stats);
        }
    }

    private AggregatedStats[] getAggregatedStatsLocked(NotificationRecord record) {
        return EMPTY_AGGREGATED_STATS;
    }

    private AggregatedStats getOrCreateAggregatedStatsLocked(String key) {
        AggregatedStats result = (AggregatedStats) this.mStats.get(key);
        if (result != null) {
            return result;
        }
        result = new AggregatedStats(key);
        this.mStats.put(key, result);
        return result;
    }

    public synchronized void dump(PrintWriter pw, String indent, DumpFilter filter) {
    }
}
