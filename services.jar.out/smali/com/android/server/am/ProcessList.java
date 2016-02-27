package com.android.server.am;

import android.app.ActivityManager;
import android.content.res.Resources;
import android.graphics.Point;
import android.net.LocalSocket;
import android.net.LocalSocketAddress;
import android.net.LocalSocketAddress.Namespace;
import android.os.Build;
import android.os.Process;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.util.Slog;
import com.android.internal.util.MemInfoReader;
import com.android.server.wm.AppTransition;
import com.android.server.wm.WindowManagerService;
import com.android.server.wm.WindowManagerService.C0569H;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.ByteBuffer;

final class ProcessList {
    static final int BACKUP_APP_ADJ = 3;
    static final int BSERVICE_APP_THRESHOLD;
    static final int CACHED_APP_MAX_ADJ = 15;
    static final int CACHED_APP_MIN_ADJ = 9;
    static final int EMPTY_APP_PERCENT;
    static final boolean ENABLE_B_SERVICE_PROPAGATION;
    static final int FOREGROUND_APP_ADJ = 0;
    static final int HEAVY_WEIGHT_APP_ADJ = 4;
    static final int HOME_APP_ADJ = 6;
    static final byte LMK_PROCPRIO = (byte) 1;
    static final byte LMK_PROCREMOVE = (byte) 2;
    static final byte LMK_TARGET = (byte) 0;
    static final int MAX_CACHED_APPS;
    private static final int MAX_EMPTY_APPS;
    static final long MAX_EMPTY_TIME = 1800000;
    static final int MIN_BSERVICE_AGING_TIME;
    static final int MIN_CACHED_APPS = 2;
    static final int MIN_CRASH_INTERVAL = 60000;
    static final int NATIVE_ADJ = -17;
    static final int PAGE_SIZE = 4096;
    static final int PERCEPTIBLE_APP_ADJ = 2;
    static final int PERSISTENT_PROC_ADJ = -12;
    static final int PERSISTENT_SERVICE_ADJ = -11;
    static final int PREVIOUS_APP_ADJ = 7;
    public static final int PROC_MEM_CACHED = 4;
    public static final int PROC_MEM_IMPORTANT = 2;
    public static final int PROC_MEM_PERSISTENT = 0;
    public static final int PROC_MEM_SERVICE = 3;
    public static final int PROC_MEM_TOP = 1;
    public static final int PSS_ALL_INTERVAL = 600000;
    private static final int PSS_FIRST_BACKGROUND_INTERVAL = 20000;
    private static final int PSS_FIRST_CACHED_INTERVAL = 30000;
    private static final int PSS_FIRST_TOP_INTERVAL = 10000;
    public static final int PSS_MAX_INTERVAL = 1800000;
    public static final int PSS_MIN_TIME_FROM_STATE_CHANGE = 15000;
    public static final int PSS_SAFE_TIME_FROM_STATE_CHANGE = 1000;
    private static final int PSS_SAME_CACHED_INTERVAL = 1800000;
    private static final int PSS_SAME_IMPORTANT_INTERVAL = 900000;
    private static final int PSS_SAME_SERVICE_INTERVAL = 1200000;
    private static final int PSS_SHORT_INTERVAL = 120000;
    private static final int PSS_TEST_FIRST_BACKGROUND_INTERVAL = 5000;
    private static final int PSS_TEST_FIRST_TOP_INTERVAL = 3000;
    public static final int PSS_TEST_MIN_TIME_FROM_STATE_CHANGE = 10000;
    private static final int PSS_TEST_SAME_BACKGROUND_INTERVAL = 15000;
    private static final int PSS_TEST_SAME_IMPORTANT_INTERVAL = 10000;
    static final int SERVICE_ADJ = 5;
    static final int SERVICE_B_ADJ = 8;
    static final int SYSTEM_ADJ = -16;
    static final int TRIM_CACHED_APPS;
    static final int TRIM_CACHE_PERCENT;
    static final int TRIM_CRITICAL_THRESHOLD = 3;
    static final int TRIM_EMPTY_APPS;
    static final int TRIM_EMPTY_PERCENT;
    static final long TRIM_ENABLE_MEMORY;
    static final int TRIM_LOW_THRESHOLD = 5;
    static final int UNKNOWN_ADJ = 16;
    static final boolean USE_TRIM_SETTINGS;
    static final int VISIBLE_APP_ADJ = 1;
    private static final long[] sFirstAwakePssTimes;
    private static OutputStream sLmkdOutputStream;
    private static LocalSocket sLmkdSocket;
    private static final int[] sProcStateToProcMem;
    private static final long[] sSameAwakePssTimes;
    private static final long[] sTestFirstAwakePssTimes;
    private static final long[] sTestSameAwakePssTimes;
    private long mCachedRestoreLevel;
    private boolean mHaveDisplaySize;
    private final int[] mOomAdj;
    private final int[] mOomMinFree;
    private final int[] mOomMinFreeHigh;
    private final int[] mOomMinFreeHigh32Bit;
    private final int[] mOomMinFreeLow;
    private final int[] mOomMinFreeLow32Bit;
    private final int[] mOomMinFreeLowRam;
    private final long mTotalMemMb;

    static {
        MIN_BSERVICE_AGING_TIME = SystemProperties.getInt("ro.sys.fw.bservice_age", PSS_TEST_FIRST_BACKGROUND_INTERVAL);
        BSERVICE_APP_THRESHOLD = SystemProperties.getInt("ro.sys.fw.bservice_limit", TRIM_LOW_THRESHOLD);
        ENABLE_B_SERVICE_PROPAGATION = SystemProperties.getBoolean("ro.sys.fw.bservice_enable", USE_TRIM_SETTINGS);
        MAX_CACHED_APPS = SystemProperties.getInt("ro.sys.fw.bg_apps_limit", 32);
        USE_TRIM_SETTINGS = SystemProperties.getBoolean("ro.sys.fw.use_trim_settings", true);
        EMPTY_APP_PERCENT = SystemProperties.getInt("ro.sys.fw.empty_app_percent", 50);
        TRIM_EMPTY_PERCENT = SystemProperties.getInt("ro.sys.fw.trim_empty_percent", 100);
        TRIM_CACHE_PERCENT = SystemProperties.getInt("ro.sys.fw.trim_cache_percent", 100);
        TRIM_ENABLE_MEMORY = SystemProperties.getLong("ro.sys.fw.trim_enable_memory", 1073741824);
        MAX_EMPTY_APPS = computeEmptyProcessLimit(MAX_CACHED_APPS);
        TRIM_EMPTY_APPS = computeTrimEmptyApps();
        TRIM_CACHED_APPS = computeTrimCachedApps();
        sProcStateToProcMem = new int[]{TRIM_EMPTY_PERCENT, TRIM_EMPTY_PERCENT, VISIBLE_APP_ADJ, PROC_MEM_IMPORTANT, PROC_MEM_IMPORTANT, PROC_MEM_IMPORTANT, PROC_MEM_IMPORTANT, TRIM_CRITICAL_THRESHOLD, PROC_MEM_CACHED, PROC_MEM_CACHED, PROC_MEM_CACHED, PROC_MEM_CACHED, PROC_MEM_CACHED, PROC_MEM_CACHED};
        sFirstAwakePssTimes = new long[]{120000, 120000, 10000, 20000, 20000, 20000, 20000, 20000, 30000, 30000, 30000, 30000, 30000, 30000};
        sSameAwakePssTimes = new long[]{900000, 900000, 120000, 900000, 900000, 900000, 900000, 1200000, 1200000, MAX_EMPTY_TIME, MAX_EMPTY_TIME, MAX_EMPTY_TIME, MAX_EMPTY_TIME, MAX_EMPTY_TIME};
        sTestFirstAwakePssTimes = new long[]{3000, 3000, 3000, 5000, 5000, 5000, 5000, 5000, 5000, 5000, 5000, 5000, 5000, 5000};
        sTestSameAwakePssTimes = new long[]{15000, 15000, 10000, 10000, 10000, 10000, 10000, 15000, 15000, 15000, 15000, 15000, 15000, 15000};
    }

    public static boolean allowTrim() {
        return Process.getTotalMemory() < TRIM_ENABLE_MEMORY ? true : USE_TRIM_SETTINGS;
    }

    public static int computeTrimEmptyApps() {
        if (USE_TRIM_SETTINGS && allowTrim()) {
            return (MAX_EMPTY_APPS * TRIM_EMPTY_PERCENT) / 100;
        }
        return MAX_EMPTY_APPS / PROC_MEM_IMPORTANT;
    }

    public static int computeTrimCachedApps() {
        if (USE_TRIM_SETTINGS && allowTrim()) {
            return (MAX_CACHED_APPS * TRIM_CACHE_PERCENT) / 100;
        }
        return (MAX_CACHED_APPS - MAX_EMPTY_APPS) / TRIM_CRITICAL_THRESHOLD;
    }

    ProcessList() {
        this.mOomAdj = new int[]{TRIM_EMPTY_PERCENT, VISIBLE_APP_ADJ, PROC_MEM_IMPORTANT, TRIM_CRITICAL_THRESHOLD, CACHED_APP_MIN_ADJ, CACHED_APP_MAX_ADJ};
        this.mOomMinFreeLow32Bit = new int[]{DumpState.DUMP_INSTALLS, 12288, 16384, 24576, 28672, 32768};
        this.mOomMinFreeHigh32Bit = new int[]{49152, 61440, 73728, 86016, 98304, 122880};
        this.mOomMinFreeLow = new int[]{12288, 18432, 24576, 36864, 43008, 49152};
        this.mOomMinFreeHigh = new int[]{73728, 92160, 110592, 129024, 147456, 184320};
        this.mOomMinFree = new int[this.mOomAdj.length];
        this.mOomMinFreeLowRam = new int[]{12288, 20478, 32766, 40962, 49152, 57342};
        MemInfoReader minfo = new MemInfoReader();
        minfo.readMemInfo();
        this.mTotalMemMb = minfo.getTotalSize() / 1048576;
        updateOomLevels(TRIM_EMPTY_PERCENT, TRIM_EMPTY_PERCENT, USE_TRIM_SETTINGS);
    }

    void applyDisplaySize(WindowManagerService wm) {
        if (!this.mHaveDisplaySize) {
            Point p = new Point();
            wm.getBaseDisplaySize(TRIM_EMPTY_PERCENT, p);
            if (p.x != 0 && p.y != 0) {
                updateOomLevels(p.x, p.y, true);
                this.mHaveDisplaySize = true;
            }
        }
    }

    private void updateOomLevels(int displayWidth, int displayHeight, boolean write) {
        float scale;
        float scaleMem = ((float) (this.mTotalMemMb - 350)) / 350.0f;
        float scaleDisp = (((float) (displayWidth * displayHeight)) - ((float) 384000)) / ((float) 640000);
        if (scaleMem > scaleDisp) {
            scale = scaleMem;
        } else {
            scale = scaleDisp;
        }
        if (scale < 0.0f) {
            scale = 0.0f;
        } else if (scale > 1.0f) {
            scale = 1.0f;
        }
        int minfree_adj = Resources.getSystem().getInteger(17694729);
        int minfree_abs = Resources.getSystem().getInteger(17694728);
        boolean is64bit = Build.SUPPORTED_64_BIT_ABIS.length > 0 ? true : USE_TRIM_SETTINGS;
        if (is64bit) {
            this.mOomMinFreeHigh[PROC_MEM_CACHED] = 225000;
            this.mOomMinFreeHigh[TRIM_LOW_THRESHOLD] = 325000;
        }
        int i = TRIM_EMPTY_PERCENT;
        while (true) {
            int length = this.mOomAdj.length;
            if (i >= r0) {
                break;
            }
            int low;
            if (is64bit) {
                Slog.i("XXXXXX", "choosing minFree values for 64 Bit");
                low = this.mOomMinFreeLow[i];
                this.mOomMinFree[i] = (int) (((float) low) + (((float) (this.mOomMinFreeHigh[i] - low)) * scale));
            } else if (ActivityManager.isLowRamDeviceStatic()) {
                Slog.i("XXXXXX", "choosing minFree values for lowram");
                this.mOomMinFree[i] = this.mOomMinFreeLowRam[i];
            } else {
                Slog.i("XXXXXX", "choosing minFree values for 32 Bit");
                low = this.mOomMinFreeLow32Bit[i];
                this.mOomMinFree[i] = (int) (((float) low) + (((float) (this.mOomMinFreeHigh32Bit[i] - low)) * scale));
            }
            i += VISIBLE_APP_ADJ;
        }
        if (minfree_abs >= 0) {
            i = TRIM_EMPTY_PERCENT;
            while (true) {
                length = this.mOomAdj.length;
                if (i >= r0) {
                    break;
                }
                this.mOomMinFree[i] = (int) ((((float) minfree_abs) * ((float) this.mOomMinFree[i])) / ((float) this.mOomMinFree[this.mOomAdj.length - 1]));
                i += VISIBLE_APP_ADJ;
            }
        }
        if (minfree_adj != 0) {
            i = TRIM_EMPTY_PERCENT;
            while (true) {
                length = this.mOomAdj.length;
                if (i >= r0) {
                    break;
                }
                int[] iArr = this.mOomMinFree;
                iArr[i] = iArr[i] + ((int) ((((float) minfree_adj) * ((float) this.mOomMinFree[i])) / ((float) this.mOomMinFree[this.mOomAdj.length - 1])));
                if (this.mOomMinFree[i] < 0) {
                    this.mOomMinFree[i] = TRIM_EMPTY_PERCENT;
                }
                i += VISIBLE_APP_ADJ;
            }
        }
        this.mCachedRestoreLevel = (getMemLevel(CACHED_APP_MAX_ADJ) / 1024) / 3;
        int reserve = (((displayWidth * displayHeight) * PROC_MEM_CACHED) * TRIM_CRITICAL_THRESHOLD) / DumpState.DUMP_PREFERRED_XML;
        int reserve_adj = Resources.getSystem().getInteger(17694731);
        int reserve_abs = Resources.getSystem().getInteger(17694730);
        if (reserve_abs >= 0) {
            reserve = reserve_abs;
        }
        if (reserve_adj != 0) {
            reserve += reserve_adj;
            if (reserve < 0) {
                reserve = TRIM_EMPTY_PERCENT;
            }
        }
        if (write) {
            ByteBuffer buf = ByteBuffer.allocate(((this.mOomAdj.length * PROC_MEM_IMPORTANT) + VISIBLE_APP_ADJ) * PROC_MEM_CACHED);
            buf.putInt(TRIM_EMPTY_PERCENT);
            i = TRIM_EMPTY_PERCENT;
            while (true) {
                length = this.mOomAdj.length;
                if (i < r0) {
                    buf.putInt((this.mOomMinFree[i] * DumpState.DUMP_PREFERRED_XML) / PAGE_SIZE);
                    buf.putInt(this.mOomAdj[i]);
                    i += VISIBLE_APP_ADJ;
                } else {
                    writeLmkd(buf);
                    SystemProperties.set("sys.sysctl.extra_free_kbytes", Integer.toString(reserve));
                    return;
                }
            }
        }
    }

    public static int computeEmptyProcessLimit(int totalProcessLimit) {
        if (USE_TRIM_SETTINGS && allowTrim()) {
            return (EMPTY_APP_PERCENT * totalProcessLimit) / 100;
        }
        return totalProcessLimit / PROC_MEM_IMPORTANT;
    }

    private static String buildOomTag(String prefix, String space, int val, int base) {
        if (val != base) {
            return prefix + "+" + Integer.toString(val - base);
        }
        if (space == null) {
            return prefix;
        }
        return prefix + "  ";
    }

    public static String makeOomAdjString(int setAdj) {
        if (setAdj >= CACHED_APP_MIN_ADJ) {
            return buildOomTag("cch", "  ", setAdj, CACHED_APP_MIN_ADJ);
        }
        if (setAdj >= SERVICE_B_ADJ) {
            return buildOomTag("svcb ", null, setAdj, SERVICE_B_ADJ);
        }
        if (setAdj >= PREVIOUS_APP_ADJ) {
            return buildOomTag("prev ", null, setAdj, PREVIOUS_APP_ADJ);
        }
        if (setAdj >= HOME_APP_ADJ) {
            return buildOomTag("home ", null, setAdj, HOME_APP_ADJ);
        }
        if (setAdj >= TRIM_LOW_THRESHOLD) {
            return buildOomTag("svc  ", null, setAdj, TRIM_LOW_THRESHOLD);
        }
        if (setAdj >= PROC_MEM_CACHED) {
            return buildOomTag("hvy  ", null, setAdj, PROC_MEM_CACHED);
        }
        if (setAdj >= TRIM_CRITICAL_THRESHOLD) {
            return buildOomTag("bkup ", null, setAdj, TRIM_CRITICAL_THRESHOLD);
        }
        if (setAdj >= PROC_MEM_IMPORTANT) {
            return buildOomTag("prcp ", null, setAdj, PROC_MEM_IMPORTANT);
        }
        if (setAdj >= VISIBLE_APP_ADJ) {
            return buildOomTag("vis  ", null, setAdj, VISIBLE_APP_ADJ);
        }
        if (setAdj >= 0) {
            return buildOomTag("fore ", null, setAdj, TRIM_EMPTY_PERCENT);
        }
        if (setAdj >= PERSISTENT_SERVICE_ADJ) {
            return buildOomTag("psvc ", null, setAdj, PERSISTENT_SERVICE_ADJ);
        }
        if (setAdj >= PERSISTENT_PROC_ADJ) {
            return buildOomTag("pers ", null, setAdj, PERSISTENT_PROC_ADJ);
        }
        if (setAdj >= SYSTEM_ADJ) {
            return buildOomTag("sys  ", null, setAdj, SYSTEM_ADJ);
        }
        if (setAdj >= NATIVE_ADJ) {
            return buildOomTag("ntv  ", null, setAdj, NATIVE_ADJ);
        }
        return Integer.toString(setAdj);
    }

    public static String makeProcStateString(int curProcState) {
        switch (curProcState) {
            case AppTransition.TRANSIT_UNSET /*-1*/:
                return "N ";
            case TRIM_EMPTY_PERCENT:
                return "P ";
            case VISIBLE_APP_ADJ /*1*/:
                return "PU";
            case PROC_MEM_IMPORTANT /*2*/:
                return "T ";
            case TRIM_CRITICAL_THRESHOLD /*3*/:
                return "IF";
            case PROC_MEM_CACHED /*4*/:
                return "IB";
            case TRIM_LOW_THRESHOLD /*5*/:
                return "BU";
            case HOME_APP_ADJ /*6*/:
                return "HW";
            case PREVIOUS_APP_ADJ /*7*/:
                return "S ";
            case SERVICE_B_ADJ /*8*/:
                return "R ";
            case CACHED_APP_MIN_ADJ /*9*/:
                return "HO";
            case AppTransition.TRANSIT_TASK_TO_FRONT /*10*/:
                return "LA";
            case C0569H.WINDOW_FREEZE_TIMEOUT /*11*/:
                return "CA";
            case AppTransition.TRANSIT_WALLPAPER_CLOSE /*12*/:
                return "Ca";
            case C0569H.APP_TRANSITION_TIMEOUT /*13*/:
                return "CE";
            default:
                return "??";
        }
    }

    public static void appendRamKb(StringBuilder sb, long ramKb) {
        int j = TRIM_EMPTY_PERCENT;
        int fact = 10;
        while (j < HOME_APP_ADJ) {
            if (ramKb < ((long) fact)) {
                sb.append(' ');
            }
            j += VISIBLE_APP_ADJ;
            fact *= 10;
        }
        sb.append(ramKb);
    }

    public static boolean procStatesDifferForMem(int procState1, int procState2) {
        return sProcStateToProcMem[procState1] != sProcStateToProcMem[procState2] ? true : USE_TRIM_SETTINGS;
    }

    public static long minTimeFromStateChange(boolean test) {
        return test ? 10000 : 15000;
    }

    public static long computeNextPssTime(int procState, boolean first, boolean test, boolean sleeping, long now) {
        long[] table = test ? first ? sTestFirstAwakePssTimes : sTestSameAwakePssTimes : first ? sFirstAwakePssTimes : sSameAwakePssTimes;
        if (procState >= 0 && procState < table.length) {
            return table[procState] + now;
        }
        Slog.w("ActivityManager", "Invalid Process State within computeNextPssTime");
        return 15000 + now;
    }

    long getMemLevel(int adjustment) {
        for (int i = TRIM_EMPTY_PERCENT; i < this.mOomAdj.length; i += VISIBLE_APP_ADJ) {
            if (adjustment <= this.mOomAdj[i]) {
                return (long) (this.mOomMinFree[i] * DumpState.DUMP_PREFERRED_XML);
            }
        }
        return (long) (this.mOomMinFree[this.mOomAdj.length - 1] * DumpState.DUMP_PREFERRED_XML);
    }

    long getCachedRestoreThresholdKb() {
        return this.mCachedRestoreLevel;
    }

    public static final void setOomAdj(int pid, int uid, int amt) {
        if (amt != UNKNOWN_ADJ) {
            long start = SystemClock.elapsedRealtime();
            ByteBuffer buf = ByteBuffer.allocate(UNKNOWN_ADJ);
            buf.putInt(VISIBLE_APP_ADJ);
            buf.putInt(pid);
            buf.putInt(uid);
            buf.putInt(amt);
            writeLmkd(buf);
            long now = SystemClock.elapsedRealtime();
            if (now - start > 250) {
                Slog.w("ActivityManager", "SLOW OOM ADJ: " + (now - start) + "ms for pid " + pid + " = " + amt);
            }
        }
    }

    public static final void remove(int pid) {
        ByteBuffer buf = ByteBuffer.allocate(SERVICE_B_ADJ);
        buf.putInt(PROC_MEM_IMPORTANT);
        buf.putInt(pid);
        writeLmkd(buf);
    }

    private static boolean openLmkdSocket() {
        try {
            sLmkdSocket = new LocalSocket(TRIM_CRITICAL_THRESHOLD);
            sLmkdSocket.connect(new LocalSocketAddress("lmkd", Namespace.RESERVED));
            sLmkdOutputStream = sLmkdSocket.getOutputStream();
            return true;
        } catch (IOException e) {
            Slog.w("ActivityManager", "lowmemorykiller daemon socket open failed");
            sLmkdSocket = null;
            return USE_TRIM_SETTINGS;
        }
    }

    private static void writeLmkd(ByteBuffer buf) {
        int i = TRIM_EMPTY_PERCENT;
        while (i < TRIM_CRITICAL_THRESHOLD) {
            if (sLmkdSocket != null || openLmkdSocket()) {
                try {
                    sLmkdOutputStream.write(buf.array(), TRIM_EMPTY_PERCENT, buf.position());
                    return;
                } catch (IOException e) {
                    Slog.w("ActivityManager", "Error writing to lowmemorykiller socket");
                    try {
                        sLmkdSocket.close();
                    } catch (IOException e2) {
                    }
                    sLmkdSocket = null;
                }
            } else {
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e3) {
                }
                i += VISIBLE_APP_ADJ;
            }
        }
    }
}
