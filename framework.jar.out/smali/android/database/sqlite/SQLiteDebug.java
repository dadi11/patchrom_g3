package android.database.sqlite;

import android.os.Build;
import android.os.SystemProperties;
import android.os.Trace;
import android.util.Log;
import android.util.Printer;
import java.util.ArrayList;

public final class SQLiteDebug {
    public static final boolean DEBUG_LOG_SLOW_QUERIES;
    public static final boolean DEBUG_SQL_LOG;
    public static final boolean DEBUG_SQL_STATEMENTS;
    public static final boolean DEBUG_SQL_TIME;

    public static class DbStats {
        public String cache;
        public String dbName;
        public long dbSize;
        public int lookaside;
        public long pageSize;

        public DbStats(String dbName, long pageCount, long pageSize, int lookaside, int hits, int misses, int cachesize) {
            this.dbName = dbName;
            this.pageSize = pageSize / Trace.TRACE_TAG_CAMERA;
            this.dbSize = (pageCount * pageSize) / Trace.TRACE_TAG_CAMERA;
            this.lookaside = lookaside;
            this.cache = hits + "/" + misses + "/" + cachesize;
        }
    }

    public static class PagerStats {
        public ArrayList<DbStats> dbStats;
        public int largestMemAlloc;
        public int memoryUsed;
        public int pageCacheOverflow;
    }

    private static native void nativeGetPagerStats(PagerStats pagerStats);

    static {
        DEBUG_SQL_LOG = Log.isLoggable("SQLiteLog", 2);
        DEBUG_SQL_STATEMENTS = Log.isLoggable("SQLiteStatements", 2);
        DEBUG_SQL_TIME = Log.isLoggable("SQLiteTime", 2);
        DEBUG_LOG_SLOW_QUERIES = Build.IS_DEBUGGABLE;
    }

    private SQLiteDebug() {
    }

    public static final boolean shouldLogSlowQuery(long elapsedTimeMillis) {
        int slowQueryMillis = SystemProperties.getInt("db.log.slow_query_threshold", -1);
        return slowQueryMillis >= 0 && elapsedTimeMillis >= ((long) slowQueryMillis);
    }

    public static PagerStats getDatabaseInfo() {
        PagerStats stats = new PagerStats();
        nativeGetPagerStats(stats);
        stats.dbStats = SQLiteDatabase.getDbStats();
        return stats;
    }

    public static void dump(Printer printer, String[] args) {
        boolean verbose = false;
        for (String arg : args) {
            if (arg.equals("-v")) {
                verbose = true;
            }
        }
        SQLiteDatabase.dumpAll(printer, verbose);
    }
}
