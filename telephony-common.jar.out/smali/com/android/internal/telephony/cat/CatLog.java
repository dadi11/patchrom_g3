package com.android.internal.telephony.cat;

import android.telephony.Rlog;

public abstract class CatLog {
    static final boolean DEBUG = true;

    public static void m0d(Object caller, String msg) {
        String className = caller.getClass().getName();
        Rlog.d("CAT", className.substring(className.lastIndexOf(46) + 1) + ": " + msg);
    }

    public static void m1d(String caller, String msg) {
        Rlog.d("CAT", caller + ": " + msg);
    }

    public static void m2e(Object caller, String msg) {
        String className = caller.getClass().getName();
        Rlog.e("CAT", className.substring(className.lastIndexOf(46) + 1) + ": " + msg);
    }

    public static void m3e(String caller, String msg) {
        Rlog.e("CAT", caller + ": " + msg);
    }
}
