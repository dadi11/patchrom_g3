package android.telephony;

import android.util.Log;

public final class Rlog {
    private Rlog() {
    }

    public static int m19v(String tag, String msg) {
        return Log.println_native(1, 2, tag, msg);
    }

    public static int m20v(String tag, String msg, Throwable tr) {
        return Log.println_native(1, 2, tag, msg + '\n' + Log.getStackTraceString(tr));
    }

    public static int m13d(String tag, String msg) {
        return Log.println_native(1, 3, tag, msg);
    }

    public static int m14d(String tag, String msg, Throwable tr) {
        return Log.println_native(1, 3, tag, msg + '\n' + Log.getStackTraceString(tr));
    }

    public static int m17i(String tag, String msg) {
        return Log.println_native(1, 4, tag, msg);
    }

    public static int m18i(String tag, String msg, Throwable tr) {
        return Log.println_native(1, 4, tag, msg + '\n' + Log.getStackTraceString(tr));
    }

    public static int m21w(String tag, String msg) {
        return Log.println_native(1, 5, tag, msg);
    }

    public static int m22w(String tag, String msg, Throwable tr) {
        return Log.println_native(1, 5, tag, msg + '\n' + Log.getStackTraceString(tr));
    }

    public static int m23w(String tag, Throwable tr) {
        return Log.println_native(1, 5, tag, Log.getStackTraceString(tr));
    }

    public static int m15e(String tag, String msg) {
        return Log.println_native(1, 6, tag, msg);
    }

    public static int m16e(String tag, String msg, Throwable tr) {
        return Log.println_native(1, 6, tag, msg + '\n' + Log.getStackTraceString(tr));
    }

    public static int println(int priority, String tag, String msg) {
        return Log.println_native(1, priority, tag, msg);
    }

    public static boolean isLoggable(String tag, int level) {
        return Log.isLoggable(tag, level);
    }
}
