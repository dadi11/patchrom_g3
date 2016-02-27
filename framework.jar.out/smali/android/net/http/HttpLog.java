package android.net.http;

import android.os.SystemClock;
import android.util.Log;

class HttpLog {
    private static final boolean DEBUG = false;
    private static final String LOGTAG = "http";
    static final boolean LOGV = false;

    HttpLog() {
    }

    static void m1v(String logMe) {
        Log.v(LOGTAG, SystemClock.uptimeMillis() + " " + Thread.currentThread().getName() + " " + logMe);
    }

    static void m0e(String logMe) {
        Log.e(LOGTAG, logMe);
    }
}
