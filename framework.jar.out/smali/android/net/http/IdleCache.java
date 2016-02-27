package android.net.http;

import android.os.SystemClock;
import org.apache.http.HttpHost;

class IdleCache {
    private static final int CHECK_INTERVAL = 2000;
    private static final int EMPTY_CHECK_MAX = 5;
    private static final int IDLE_CACHE_MAX = 8;
    private static final int TIMEOUT = 6000;
    private int mCached;
    private int mCount;
    private Entry[] mEntries;
    private int mReused;
    private IdleReaper mThread;

    class Entry {
        Connection mConnection;
        HttpHost mHost;
        long mTimeout;

        Entry() {
        }
    }

    private class IdleReaper extends Thread {
        private IdleReaper() {
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void run() {
            /*
            r6 = this;
            r0 = 0;
            r1 = "IdleReaper";
            r6.setName(r1);
            r1 = 10;
            android.os.Process.setThreadPriority(r1);
            r2 = android.net.http.IdleCache.this;
            monitor-enter(r2);
        L_0x000e:
            r1 = 5;
            if (r0 >= r1) goto L_0x002d;
        L_0x0011:
            r1 = android.net.http.IdleCache.this;	 Catch:{ InterruptedException -> 0x0035 }
            r4 = 2000; // 0x7d0 float:2.803E-42 double:9.88E-321;
            r1.wait(r4);	 Catch:{ InterruptedException -> 0x0035 }
        L_0x0018:
            r1 = android.net.http.IdleCache.this;	 Catch:{ all -> 0x002a }
            r1 = r1.mCount;	 Catch:{ all -> 0x002a }
            if (r1 != 0) goto L_0x0023;
        L_0x0020:
            r0 = r0 + 1;
            goto L_0x000e;
        L_0x0023:
            r0 = 0;
            r1 = android.net.http.IdleCache.this;	 Catch:{ all -> 0x002a }
            r1.clearIdle();	 Catch:{ all -> 0x002a }
            goto L_0x000e;
        L_0x002a:
            r1 = move-exception;
            monitor-exit(r2);	 Catch:{ all -> 0x002a }
            throw r1;
        L_0x002d:
            r1 = android.net.http.IdleCache.this;	 Catch:{ all -> 0x002a }
            r3 = 0;
            r1.mThread = r3;	 Catch:{ all -> 0x002a }
            monitor-exit(r2);	 Catch:{ all -> 0x002a }
            return;
        L_0x0035:
            r1 = move-exception;
            goto L_0x0018;
            */
            throw new UnsupportedOperationException("Method not decompiled: android.net.http.IdleCache.IdleReaper.run():void");
        }
    }

    IdleCache() {
        this.mEntries = new Entry[IDLE_CACHE_MAX];
        this.mCount = 0;
        this.mThread = null;
        this.mCached = 0;
        this.mReused = 0;
        for (int i = 0; i < IDLE_CACHE_MAX; i++) {
            this.mEntries[i] = new Entry();
        }
    }

    synchronized boolean cacheConnection(HttpHost host, Connection connection) {
        boolean ret;
        ret = false;
        if (this.mCount < IDLE_CACHE_MAX) {
            long time = SystemClock.uptimeMillis();
            int i = 0;
            while (i < IDLE_CACHE_MAX) {
                Entry entry = this.mEntries[i];
                if (entry.mHost == null) {
                    entry.mHost = host;
                    entry.mConnection = connection;
                    entry.mTimeout = 6000 + time;
                    this.mCount++;
                    ret = true;
                    if (this.mThread == null) {
                        this.mThread = new IdleReaper();
                        this.mThread.start();
                    }
                } else {
                    i++;
                }
            }
        }
        return ret;
    }

    synchronized Connection getConnection(HttpHost host) {
        Connection ret;
        ret = null;
        if (this.mCount > 0) {
            for (int i = 0; i < IDLE_CACHE_MAX; i++) {
                Entry entry = this.mEntries[i];
                HttpHost eHost = entry.mHost;
                if (eHost != null && eHost.equals(host)) {
                    ret = entry.mConnection;
                    entry.mHost = null;
                    entry.mConnection = null;
                    this.mCount--;
                    break;
                }
            }
        }
        return ret;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    synchronized void clear() {
        /*
        r3 = this;
        monitor-enter(r3);
        r1 = 0;
    L_0x0002:
        r2 = r3.mCount;	 Catch:{ all -> 0x0028 }
        if (r2 <= 0) goto L_0x0026;
    L_0x0006:
        r2 = 8;
        if (r1 >= r2) goto L_0x0026;
    L_0x000a:
        r2 = r3.mEntries;	 Catch:{ all -> 0x0028 }
        r0 = r2[r1];	 Catch:{ all -> 0x0028 }
        r2 = r0.mHost;	 Catch:{ all -> 0x0028 }
        if (r2 == 0) goto L_0x0023;
    L_0x0012:
        r2 = 0;
        r0.mHost = r2;	 Catch:{ all -> 0x0028 }
        r2 = r0.mConnection;	 Catch:{ all -> 0x0028 }
        r2.closeConnection();	 Catch:{ all -> 0x0028 }
        r2 = 0;
        r0.mConnection = r2;	 Catch:{ all -> 0x0028 }
        r2 = r3.mCount;	 Catch:{ all -> 0x0028 }
        r2 = r2 + -1;
        r3.mCount = r2;	 Catch:{ all -> 0x0028 }
    L_0x0023:
        r1 = r1 + 1;
        goto L_0x0002;
    L_0x0026:
        monitor-exit(r3);
        return;
    L_0x0028:
        r2 = move-exception;
        monitor-exit(r3);
        throw r2;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.net.http.IdleCache.clear():void");
    }

    private synchronized void clearIdle() {
        if (this.mCount > 0) {
            long time = SystemClock.uptimeMillis();
            for (int i = 0; i < IDLE_CACHE_MAX; i++) {
                Entry entry = this.mEntries[i];
                if (entry.mHost != null && time > entry.mTimeout) {
                    entry.mHost = null;
                    entry.mConnection.closeConnection();
                    entry.mConnection = null;
                    this.mCount--;
                }
            }
        }
    }
}
