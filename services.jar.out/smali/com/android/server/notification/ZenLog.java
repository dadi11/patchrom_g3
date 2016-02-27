package com.android.server.notification;

import android.content.ComponentName;
import android.net.Uri;
import android.os.Build;
import android.os.RemoteException;
import android.service.notification.Condition;
import android.service.notification.IConditionProvider;
import android.service.notification.ZenModeConfig;
import android.util.Slog;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ZenLog {
    private static final boolean DEBUG;
    private static final SimpleDateFormat FORMAT;
    private static final String[] MSGS;
    private static final int SIZE;
    private static final String TAG = "ZenLog";
    private static final long[] TIMES;
    private static final int[] TYPES;
    private static final int TYPE_ALLOW_DISABLE = 2;
    private static final int TYPE_CONFIG = 11;
    private static final int TYPE_DISABLE_EFFECTS = 13;
    private static final int TYPE_DOWNTIME = 5;
    private static final int TYPE_EXIT_CONDITION = 8;
    private static final int TYPE_INTERCEPTED = 1;
    private static final int TYPE_NOT_INTERCEPTED = 12;
    private static final int TYPE_SET_RINGER_MODE_EXTERNAL = 3;
    private static final int TYPE_SET_RINGER_MODE_INTERNAL = 4;
    private static final int TYPE_SET_ZEN_MODE = 6;
    private static final int TYPE_SUBSCRIBE = 9;
    private static final int TYPE_UNSUBSCRIBE = 10;
    private static final int TYPE_UPDATE_ZEN_MODE = 7;
    private static int sNext;
    private static int sSize;

    static {
        DEBUG = Build.IS_DEBUGGABLE;
        SIZE = Build.IS_DEBUGGABLE ? 100 : 20;
        TIMES = new long[SIZE];
        TYPES = new int[SIZE];
        MSGS = new String[SIZE];
        FORMAT = new SimpleDateFormat("MM-dd HH:mm:ss.SSS");
    }

    public static void traceIntercepted(NotificationRecord record, String reason) {
        if (record == null || !record.isIntercepted()) {
            append(TYPE_INTERCEPTED, record.getKey() + "," + reason);
        }
    }

    public static void traceNotIntercepted(NotificationRecord record, String reason) {
        if (record == null || !record.isUpdate) {
            append(TYPE_NOT_INTERCEPTED, record.getKey() + "," + reason);
        }
    }

    public static void traceSetRingerModeExternal(int ringerModeOld, int ringerModeNew, String caller, int ringerModeInternalIn, int ringerModeInternalOut) {
        append(TYPE_SET_RINGER_MODE_EXTERNAL, caller + ",e:" + ringerModeToString(ringerModeOld) + "->" + ringerModeToString(ringerModeNew) + ",i:" + ringerModeToString(ringerModeInternalIn) + "->" + ringerModeToString(ringerModeInternalOut));
    }

    public static void traceSetRingerModeInternal(int ringerModeOld, int ringerModeNew, String caller, int ringerModeExternalIn, int ringerModeExternalOut) {
        append(TYPE_SET_RINGER_MODE_INTERNAL, caller + ",i:" + ringerModeToString(ringerModeOld) + "->" + ringerModeToString(ringerModeNew) + ",e:" + ringerModeToString(ringerModeExternalIn) + "->" + ringerModeToString(ringerModeExternalOut));
    }

    public static void traceDowntimeAutotrigger(String result) {
        append(TYPE_DOWNTIME, result);
    }

    public static void traceSetZenMode(int zenMode, String reason) {
        append(TYPE_SET_ZEN_MODE, zenModeToString(zenMode) + "," + reason);
    }

    public static void traceUpdateZenMode(int fromMode, int toMode) {
        append(TYPE_UPDATE_ZEN_MODE, zenModeToString(fromMode) + " -> " + zenModeToString(toMode));
    }

    public static void traceExitCondition(Condition c, ComponentName component, String reason) {
        append(TYPE_EXIT_CONDITION, c + "," + componentToString(component) + "," + reason);
    }

    public static void traceSubscribe(Uri uri, IConditionProvider provider, RemoteException e) {
        append(TYPE_SUBSCRIBE, uri + "," + subscribeResult(provider, e));
    }

    public static void traceUnsubscribe(Uri uri, IConditionProvider provider, RemoteException e) {
        append(TYPE_UNSUBSCRIBE, uri + "," + subscribeResult(provider, e));
    }

    public static void traceConfig(ZenModeConfig oldConfig, ZenModeConfig newConfig) {
        append(TYPE_CONFIG, newConfig != null ? newConfig.toString() : null);
    }

    public static void traceDisableEffects(NotificationRecord record, String reason) {
        append(TYPE_DISABLE_EFFECTS, record.getKey() + "," + reason);
    }

    private static String subscribeResult(IConditionProvider provider, RemoteException e) {
        if (provider == null) {
            return "no provider";
        }
        return e != null ? e.getMessage() : "ok";
    }

    private static String typeToString(int type) {
        switch (type) {
            case TYPE_INTERCEPTED /*1*/:
                return "intercepted";
            case TYPE_ALLOW_DISABLE /*2*/:
                return "allow_disable";
            case TYPE_SET_RINGER_MODE_EXTERNAL /*3*/:
                return "set_ringer_mode_external";
            case TYPE_SET_RINGER_MODE_INTERNAL /*4*/:
                return "set_ringer_mode_internal";
            case TYPE_DOWNTIME /*5*/:
                return "downtime";
            case TYPE_SET_ZEN_MODE /*6*/:
                return "set_zen_mode";
            case TYPE_UPDATE_ZEN_MODE /*7*/:
                return "update_zen_mode";
            case TYPE_EXIT_CONDITION /*8*/:
                return "exit_condition";
            case TYPE_SUBSCRIBE /*9*/:
                return "subscribe";
            case TYPE_UNSUBSCRIBE /*10*/:
                return "unsubscribe";
            case TYPE_CONFIG /*11*/:
                return "config";
            case TYPE_NOT_INTERCEPTED /*12*/:
                return "not_intercepted";
            case TYPE_DISABLE_EFFECTS /*13*/:
                return "disable_effects";
            default:
                return "unknown";
        }
    }

    private static String ringerModeToString(int ringerMode) {
        switch (ringerMode) {
            case SIZE:
                return "silent";
            case TYPE_INTERCEPTED /*1*/:
                return "vibrate";
            case TYPE_ALLOW_DISABLE /*2*/:
                return "normal";
            default:
                return "unknown";
        }
    }

    private static String zenModeToString(int zenMode) {
        switch (zenMode) {
            case SIZE:
                return "off";
            case TYPE_INTERCEPTED /*1*/:
                return "important_interruptions";
            case TYPE_ALLOW_DISABLE /*2*/:
                return "no_interruptions";
            default:
                return "unknown";
        }
    }

    private static String componentToString(ComponentName component) {
        return component != null ? component.toShortString() : null;
    }

    private static void append(int type, String msg) {
        synchronized (MSGS) {
            TIMES[sNext] = System.currentTimeMillis();
            TYPES[sNext] = type;
            MSGS[sNext] = msg;
            sNext = (sNext + TYPE_INTERCEPTED) % SIZE;
            if (sSize < SIZE) {
                sSize += TYPE_INTERCEPTED;
            }
        }
        if (DEBUG) {
            Slog.d(TAG, typeToString(type) + ": " + msg);
        }
    }

    public static void dump(PrintWriter pw, String prefix) {
        synchronized (MSGS) {
            int start = ((sNext - sSize) + SIZE) % SIZE;
            for (int i = SIZE; i < sSize; i += TYPE_INTERCEPTED) {
                int j = (start + i) % SIZE;
                pw.print(prefix);
                pw.print(FORMAT.format(new Date(TIMES[j])));
                pw.print(' ');
                pw.print(typeToString(TYPES[j]));
                pw.print(": ");
                pw.println(MSGS[j]);
            }
        }
    }
}
