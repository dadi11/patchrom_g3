package com.android.server;

import android.app.IActivityController;
import android.content.BroadcastReceiver;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Handler;
import android.os.IPowerManager;
import android.os.Looper;
import android.os.RemoteException;
import android.os.ServiceManager;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.util.Slog;
import com.android.server.am.ActivityManagerService;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class Watchdog extends Thread {
    static final long CHECK_INTERVAL = 30000;
    static final int COMPLETED = 0;
    static final boolean DB = false;
    static final long DEFAULT_TIMEOUT = 60000;
    public static final String[] NATIVE_STACKS_OF_INTEREST;
    static final int OVERDUE = 3;
    static final boolean RECORD_KERNEL_THREADS = true;
    static final String TAG = "Watchdog";
    static final int WAITED_HALF = 2;
    static final int WAITING = 1;
    static final boolean localLOGV = false;
    static Watchdog sWatchdog;
    ActivityManagerService mActivity;
    boolean mAllowRestart;
    IActivityController mController;
    final ArrayList<HandlerChecker> mHandlerCheckers;
    final HandlerChecker mMonitorChecker;
    int mPhonePid;
    ContentResolver mResolver;
    SimpleDateFormat mTraceDateFormat;

    public interface Monitor {
        void monitor();
    }

    /* renamed from: com.android.server.Watchdog.1 */
    class C00951 extends Thread {
        final /* synthetic */ File val$newFd;
        final /* synthetic */ String val$subject;

        C00951(String x0, String str, File file) {
            this.val$subject = str;
            this.val$newFd = file;
            super(x0);
        }

        public void run() {
            Watchdog.this.mActivity.addErrorToDropBox("watchdog", null, "system_server", null, null, this.val$subject, null, this.val$newFd, null);
        }
    }

    public final class HandlerChecker implements Runnable {
        private boolean mCompleted;
        private Monitor mCurrentMonitor;
        private final Handler mHandler;
        private final ArrayList<Monitor> mMonitors;
        private final String mName;
        private long mStartTime;
        private final long mWaitMax;

        HandlerChecker(Handler handler, String name, long waitMaxMillis) {
            this.mMonitors = new ArrayList();
            this.mHandler = handler;
            this.mName = name;
            this.mWaitMax = waitMaxMillis;
            this.mCompleted = Watchdog.RECORD_KERNEL_THREADS;
        }

        public void addMonitor(Monitor monitor) {
            this.mMonitors.add(monitor);
        }

        public void scheduleCheckLocked() {
            if (this.mMonitors.size() == 0 && this.mHandler.getLooper().isIdling()) {
                this.mCompleted = Watchdog.RECORD_KERNEL_THREADS;
            } else if (this.mCompleted) {
                this.mCompleted = Watchdog.DB;
                this.mCurrentMonitor = null;
                this.mStartTime = SystemClock.uptimeMillis();
                this.mHandler.postAtFrontOfQueue(this);
            }
        }

        public boolean isOverdueLocked() {
            return (this.mCompleted || SystemClock.uptimeMillis() <= this.mStartTime + this.mWaitMax) ? Watchdog.DB : Watchdog.RECORD_KERNEL_THREADS;
        }

        public int getCompletionStateLocked() {
            if (this.mCompleted) {
                return Watchdog.COMPLETED;
            }
            long latency = SystemClock.uptimeMillis() - this.mStartTime;
            if (latency < this.mWaitMax / 2) {
                return Watchdog.WAITING;
            }
            if (latency < this.mWaitMax) {
                return Watchdog.WAITED_HALF;
            }
            return Watchdog.OVERDUE;
        }

        public Thread getThread() {
            return this.mHandler.getLooper().getThread();
        }

        public String getName() {
            return this.mName;
        }

        public String describeBlockedStateLocked() {
            if (this.mCurrentMonitor == null) {
                return "Blocked in handler on " + this.mName + " (" + getThread().getName() + ")";
            }
            return "Blocked in monitor " + this.mCurrentMonitor.getClass().getName() + " on " + this.mName + " (" + getThread().getName() + ")";
        }

        public void run() {
            int size = this.mMonitors.size();
            for (int i = Watchdog.COMPLETED; i < size; i += Watchdog.WAITING) {
                synchronized (Watchdog.this) {
                    this.mCurrentMonitor = (Monitor) this.mMonitors.get(i);
                }
                this.mCurrentMonitor.monitor();
            }
            synchronized (Watchdog.this) {
                this.mCompleted = Watchdog.RECORD_KERNEL_THREADS;
                this.mCurrentMonitor = null;
            }
        }
    }

    final class RebootRequestReceiver extends BroadcastReceiver {
        RebootRequestReceiver() {
        }

        public void onReceive(Context c, Intent intent) {
            if (intent.getIntExtra("nowait", Watchdog.COMPLETED) != 0) {
                Watchdog.this.rebootSystem("Received ACTION_REBOOT broadcast");
            } else {
                Slog.w(Watchdog.TAG, "Unsupported ACTION_REBOOT broadcast: " + intent);
            }
        }
    }

    private native void native_dumpKernelStacks(String str);

    static {
        String[] strArr = new String[OVERDUE];
        strArr[COMPLETED] = "/system/bin/mediaserver";
        strArr[WAITING] = "/system/bin/sdcard";
        strArr[WAITED_HALF] = "/system/bin/surfaceflinger";
        NATIVE_STACKS_OF_INTEREST = strArr;
    }

    public static Watchdog getInstance() {
        if (sWatchdog == null) {
            sWatchdog = new Watchdog();
        }
        return sWatchdog;
    }

    private Watchdog() {
        super("watchdog");
        this.mHandlerCheckers = new ArrayList();
        this.mAllowRestart = RECORD_KERNEL_THREADS;
        this.mTraceDateFormat = new SimpleDateFormat("dd_MMM_HH_mm_ss.SSS");
        this.mMonitorChecker = new HandlerChecker(FgThread.getHandler(), "foreground thread", DEFAULT_TIMEOUT);
        this.mHandlerCheckers.add(this.mMonitorChecker);
        this.mHandlerCheckers.add(new HandlerChecker(new Handler(Looper.getMainLooper()), "main thread", DEFAULT_TIMEOUT));
        this.mHandlerCheckers.add(new HandlerChecker(UiThread.getHandler(), "ui thread", DEFAULT_TIMEOUT));
        this.mHandlerCheckers.add(new HandlerChecker(IoThread.getHandler(), "i/o thread", DEFAULT_TIMEOUT));
        this.mHandlerCheckers.add(new HandlerChecker(DisplayThread.getHandler(), "display thread", DEFAULT_TIMEOUT));
    }

    public void init(Context context, ActivityManagerService activity) {
        this.mResolver = context.getContentResolver();
        this.mActivity = activity;
        context.registerReceiver(new RebootRequestReceiver(), new IntentFilter("android.intent.action.REBOOT"), "android.permission.REBOOT", null);
    }

    public void processStarted(String name, int pid) {
        synchronized (this) {
            if ("com.android.phone".equals(name)) {
                this.mPhonePid = pid;
            }
        }
    }

    public void setActivityController(IActivityController controller) {
        synchronized (this) {
            this.mController = controller;
        }
    }

    public void setAllowRestart(boolean allowRestart) {
        synchronized (this) {
            this.mAllowRestart = allowRestart;
        }
    }

    public void addMonitor(Monitor monitor) {
        synchronized (this) {
            if (isAlive()) {
                throw new RuntimeException("Monitors can't be added once the Watchdog is running");
            }
            this.mMonitorChecker.addMonitor(monitor);
        }
    }

    public void addThread(Handler thread) {
        addThread(thread, DEFAULT_TIMEOUT);
    }

    public void addThread(Handler thread, long timeoutMillis) {
        synchronized (this) {
            if (isAlive()) {
                throw new RuntimeException("Threads can't be added once the Watchdog is running");
            }
            this.mHandlerCheckers.add(new HandlerChecker(thread, thread.getLooper().getThread().getName(), timeoutMillis));
        }
    }

    void rebootSystem(String reason) {
        Slog.i(TAG, "Rebooting system because: " + reason);
        try {
            ((IPowerManager) ServiceManager.getService("power")).reboot(DB, reason, DB);
        } catch (RemoteException e) {
        }
    }

    private int evaluateCheckerCompletionLocked() {
        int state = COMPLETED;
        for (int i = COMPLETED; i < this.mHandlerCheckers.size(); i += WAITING) {
            state = Math.max(state, ((HandlerChecker) this.mHandlerCheckers.get(i)).getCompletionStateLocked());
        }
        return state;
    }

    private ArrayList<HandlerChecker> getBlockedCheckersLocked() {
        ArrayList<HandlerChecker> checkers = new ArrayList();
        for (int i = COMPLETED; i < this.mHandlerCheckers.size(); i += WAITING) {
            HandlerChecker hc = (HandlerChecker) this.mHandlerCheckers.get(i);
            if (hc.isOverdueLocked()) {
                checkers.add(hc);
            }
        }
        return checkers;
    }

    private String describeCheckersLocked(ArrayList<HandlerChecker> checkers) {
        StringBuilder builder = new StringBuilder(DumpState.DUMP_PROVIDERS);
        for (int i = COMPLETED; i < checkers.size(); i += WAITING) {
            if (builder.length() > 0) {
                builder.append(", ");
            }
            builder.append(((HandlerChecker) checkers.get(i)).describeBlockedStateLocked());
        }
        return builder.toString();
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public void run() {
        /*
        r40 = this;
        r34 = 0;
    L_0x0002:
        r10 = 0;
        monitor-enter(r40);
        r28 = 30000; // 0x7530 float:4.2039E-41 double:1.4822E-319;
        r15 = 0;
    L_0x0007:
        r0 = r40;
        r0 = r0.mHandlerCheckers;	 Catch:{ all -> 0x0060 }
        r35 = r0;
        r35 = r35.size();	 Catch:{ all -> 0x0060 }
        r0 = r35;
        if (r15 >= r0) goto L_0x0029;
    L_0x0015:
        r0 = r40;
        r0 = r0.mHandlerCheckers;	 Catch:{ all -> 0x0060 }
        r35 = r0;
        r0 = r35;
        r14 = r0.get(r15);	 Catch:{ all -> 0x0060 }
        r14 = (com.android.server.Watchdog.HandlerChecker) r14;	 Catch:{ all -> 0x0060 }
        r14.scheduleCheckLocked();	 Catch:{ all -> 0x0060 }
        r15 = r15 + 1;
        goto L_0x0007;
    L_0x0029:
        if (r10 <= 0) goto L_0x002d;
    L_0x002b:
        r10 = r10 + -1;
    L_0x002d:
        r26 = android.os.SystemClock.uptimeMillis();	 Catch:{ all -> 0x0060 }
    L_0x0031:
        r36 = 0;
        r35 = (r28 > r36 ? 1 : (r28 == r36 ? 0 : -1));
        if (r35 <= 0) goto L_0x0063;
    L_0x0037:
        r35 = android.os.Debug.isDebuggerConnected();	 Catch:{ all -> 0x0060 }
        if (r35 == 0) goto L_0x003e;
    L_0x003d:
        r10 = 2;
    L_0x003e:
        r0 = r40;
        r1 = r28;
        r0.wait(r1);	 Catch:{ InterruptedException -> 0x0057 }
    L_0x0045:
        r35 = android.os.Debug.isDebuggerConnected();	 Catch:{ all -> 0x0060 }
        if (r35 == 0) goto L_0x004c;
    L_0x004b:
        r10 = 2;
    L_0x004c:
        r36 = 30000; // 0x7530 float:4.2039E-41 double:1.4822E-319;
        r38 = android.os.SystemClock.uptimeMillis();	 Catch:{ all -> 0x0060 }
        r38 = r38 - r26;
        r28 = r36 - r38;
        goto L_0x0031;
    L_0x0057:
        r12 = move-exception;
        r35 = "Watchdog";
        r0 = r35;
        android.util.Log.wtf(r0, r12);	 Catch:{ all -> 0x0060 }
        goto L_0x0045;
    L_0x0060:
        r35 = move-exception;
        monitor-exit(r40);	 Catch:{ all -> 0x0060 }
        throw r35;
    L_0x0063:
        r33 = r40.evaluateCheckerCompletionLocked();	 Catch:{ all -> 0x0060 }
        if (r33 != 0) goto L_0x006d;
    L_0x0069:
        r34 = 0;
        monitor-exit(r40);	 Catch:{ all -> 0x0060 }
        goto L_0x0002;
    L_0x006d:
        r35 = 1;
        r0 = r33;
        r1 = r35;
        if (r0 != r1) goto L_0x0077;
    L_0x0075:
        monitor-exit(r40);	 Catch:{ all -> 0x0060 }
        goto L_0x0002;
    L_0x0077:
        r35 = 2;
        r0 = r33;
        r1 = r35;
        if (r0 != r1) goto L_0x00af;
    L_0x007f:
        if (r34 != 0) goto L_0x00ac;
    L_0x0081:
        r21 = new java.util.ArrayList;	 Catch:{ all -> 0x0060 }
        r21.<init>();	 Catch:{ all -> 0x0060 }
        r35 = android.os.Process.myPid();	 Catch:{ all -> 0x0060 }
        r35 = java.lang.Integer.valueOf(r35);	 Catch:{ all -> 0x0060 }
        r0 = r21;
        r1 = r35;
        r0.add(r1);	 Catch:{ all -> 0x0060 }
        r35 = 1;
        r36 = 0;
        r37 = 0;
        r38 = NATIVE_STACKS_OF_INTEREST;	 Catch:{ all -> 0x0060 }
        r0 = r35;
        r1 = r21;
        r2 = r36;
        r3 = r37;
        r4 = r38;
        com.android.server.am.ActivityManagerService.dumpStackTraces(r0, r1, r2, r3, r4);	 Catch:{ all -> 0x0060 }
        r34 = 1;
    L_0x00ac:
        monitor-exit(r40);	 Catch:{ all -> 0x0060 }
        goto L_0x0002;
    L_0x00af:
        r8 = r40.getBlockedCheckersLocked();	 Catch:{ all -> 0x0060 }
        r0 = r40;
        r25 = r0.describeCheckersLocked(r8);	 Catch:{ all -> 0x0060 }
        r0 = r40;
        r6 = r0.mAllowRestart;	 Catch:{ all -> 0x0060 }
        monitor-exit(r40);	 Catch:{ all -> 0x0060 }
        r35 = 2802; // 0xaf2 float:3.926E-42 double:1.3844E-320;
        r0 = r35;
        r1 = r25;
        android.util.EventLog.writeEvent(r0, r1);
        r21 = new java.util.ArrayList;
        r21.<init>();
        r35 = android.os.Process.myPid();
        r35 = java.lang.Integer.valueOf(r35);
        r0 = r21;
        r1 = r35;
        r0.add(r1);
        r0 = r40;
        r0 = r0.mPhonePid;
        r35 = r0;
        if (r35 <= 0) goto L_0x00f4;
    L_0x00e3:
        r0 = r40;
        r0 = r0.mPhonePid;
        r35 = r0;
        r35 = java.lang.Integer.valueOf(r35);
        r0 = r21;
        r1 = r35;
        r0.add(r1);
    L_0x00f4:
        if (r34 != 0) goto L_0x01f7;
    L_0x00f6:
        r35 = 1;
    L_0x00f8:
        r36 = 0;
        r37 = 0;
        r38 = NATIVE_STACKS_OF_INTEREST;
        r0 = r35;
        r1 = r21;
        r2 = r36;
        r3 = r37;
        r4 = r38;
        r23 = com.android.server.am.ActivityManagerService.dumpStackTraces(r0, r1, r2, r3, r4);
        r36 = 2000; // 0x7d0 float:2.803E-42 double:9.88E-321;
        android.os.SystemClock.sleep(r36);
        r40.dumpKernelStackTraces();
        r35 = 119; // 0x77 float:1.67E-43 double:5.9E-322;
        r0 = r40;
        r1 = r35;
        r0.doSysRq(r1);
        r35 = 108; // 0x6c float:1.51E-43 double:5.34E-322;
        r0 = r40;
        r1 = r35;
        r0.doSysRq(r1);
        r35 = "dalvik.vm.stack-trace-file";
        r36 = 0;
        r32 = android.os.SystemProperties.get(r35, r36);
        r35 = new java.lang.StringBuilder;
        r35.<init>();
        r36 = "_SystemServer_WDT";
        r35 = r35.append(r36);
        r0 = r40;
        r0 = r0.mTraceDateFormat;
        r36 = r0;
        r37 = new java.util.Date;
        r37.<init>();
        r36 = r36.format(r37);
        r35 = r35.append(r36);
        r30 = r35.toString();
        if (r32 == 0) goto L_0x01ae;
    L_0x0152:
        r35 = r32.length();
        if (r35 == 0) goto L_0x01ae;
    L_0x0158:
        r31 = new java.io.File;
        r31.<init>(r32);
        r35 = ".";
        r0 = r32;
        r1 = r35;
        r18 = r0.lastIndexOf(r1);
        r35 = -1;
        r0 = r35;
        r1 = r18;
        if (r0 == r1) goto L_0x01fb;
    L_0x016f:
        r35 = new java.lang.StringBuilder;
        r35.<init>();
        r36 = 0;
        r0 = r32;
        r1 = r36;
        r2 = r18;
        r36 = r0.substring(r1, r2);
        r35 = r35.append(r36);
        r0 = r35;
        r1 = r30;
        r35 = r0.append(r1);
        r0 = r32;
        r1 = r18;
        r36 = r0.substring(r1);
        r35 = r35.append(r36);
        r20 = r35.toString();
    L_0x019c:
        r35 = new java.io.File;
        r0 = r35;
        r1 = r20;
        r0.<init>(r1);
        r0 = r31;
        r1 = r35;
        r0.renameTo(r1);
        r32 = r20;
    L_0x01ae:
        r19 = new java.io.File;
        r0 = r19;
        r1 = r32;
        r0.<init>(r1);
        r11 = new com.android.server.Watchdog$1;
        r35 = "watchdogWriteToDropbox";
        r0 = r40;
        r1 = r35;
        r2 = r25;
        r3 = r19;
        r11.<init>(r1, r2, r3);
        r11.start();
        r36 = 2000; // 0x7d0 float:2.803E-42 double:9.88E-321;
        r0 = r36;
        r11.join(r0);	 Catch:{ InterruptedException -> 0x02ea }
    L_0x01d0:
        monitor-enter(r40);
        r0 = r40;
        r9 = r0.mController;	 Catch:{ all -> 0x0215 }
        monitor-exit(r40);	 Catch:{ all -> 0x0215 }
        if (r9 == 0) goto L_0x0219;
    L_0x01d8:
        r35 = "Watchdog";
        r36 = "Reporting stuck state to activity controller";
        android.util.Slog.i(r35, r36);
        r35 = "Service dumps disabled due to hung system process.";
        android.os.Binder.setDumpDisabled(r35);	 Catch:{ RemoteException -> 0x0218 }
        r0 = r25;
        r22 = r9.systemNotResponding(r0);	 Catch:{ RemoteException -> 0x0218 }
        if (r22 < 0) goto L_0x0219;
    L_0x01ec:
        r35 = "Watchdog";
        r36 = "Activity controller requested to coninue to wait";
        android.util.Slog.i(r35, r36);	 Catch:{ RemoteException -> 0x0218 }
        r34 = 0;
        goto L_0x0002;
    L_0x01f7:
        r35 = 0;
        goto L_0x00f8;
    L_0x01fb:
        r35 = new java.lang.StringBuilder;
        r35.<init>();
        r0 = r35;
        r1 = r32;
        r35 = r0.append(r1);
        r0 = r35;
        r1 = r30;
        r35 = r0.append(r1);
        r20 = r35.toString();
        goto L_0x019c;
    L_0x0215:
        r35 = move-exception;
        monitor-exit(r40);	 Catch:{ all -> 0x0215 }
        throw r35;
    L_0x0218:
        r35 = move-exception;
    L_0x0219:
        r35 = android.os.Debug.isDebuggerConnected();
        if (r35 == 0) goto L_0x0220;
    L_0x021f:
        r10 = 2;
    L_0x0220:
        r35 = 2;
        r0 = r35;
        if (r10 < r0) goto L_0x0231;
    L_0x0226:
        r35 = "Watchdog";
        r36 = "Debugger connected: Watchdog is *not* killing the system process";
        android.util.Slog.w(r35, r36);
    L_0x022d:
        r34 = 0;
        goto L_0x0002;
    L_0x0231:
        if (r10 <= 0) goto L_0x023b;
    L_0x0233:
        r35 = "Watchdog";
        r36 = "Debugger was connected: Watchdog is *not* killing the system process";
        android.util.Slog.w(r35, r36);
        goto L_0x022d;
    L_0x023b:
        if (r6 != 0) goto L_0x0245;
    L_0x023d:
        r35 = "Watchdog";
        r36 = "Restart not allowed: Watchdog is *not* killing the system process";
        android.util.Slog.w(r35, r36);
        goto L_0x022d;
    L_0x0245:
        r35 = "Watchdog";
        r36 = new java.lang.StringBuilder;
        r36.<init>();
        r37 = "*** WATCHDOG KILLING SYSTEM PROCESS: ";
        r36 = r36.append(r37);
        r0 = r36;
        r1 = r25;
        r36 = r0.append(r1);
        r36 = r36.toString();
        android.util.Slog.w(r35, r36);
        r15 = 0;
    L_0x0262:
        r35 = r8.size();
        r0 = r35;
        if (r15 >= r0) goto L_0x02d5;
    L_0x026a:
        r36 = "Watchdog";
        r37 = new java.lang.StringBuilder;
        r37.<init>();
        r35 = r8.get(r15);
        r35 = (com.android.server.Watchdog.HandlerChecker) r35;
        r35 = r35.getName();
        r0 = r37;
        r1 = r35;
        r35 = r0.append(r1);
        r37 = " stack trace:";
        r0 = r35;
        r1 = r37;
        r35 = r0.append(r1);
        r35 = r35.toString();
        r0 = r36;
        r1 = r35;
        android.util.Slog.w(r0, r1);
        r35 = r8.get(r15);
        r35 = (com.android.server.Watchdog.HandlerChecker) r35;
        r35 = r35.getThread();
        r24 = r35.getStackTrace();
        r7 = r24;
        r0 = r7.length;
        r17 = r0;
        r16 = 0;
    L_0x02ad:
        r0 = r16;
        r1 = r17;
        if (r0 >= r1) goto L_0x02d2;
    L_0x02b3:
        r13 = r7[r16];
        r35 = "Watchdog";
        r36 = new java.lang.StringBuilder;
        r36.<init>();
        r37 = "    at ";
        r36 = r36.append(r37);
        r0 = r36;
        r36 = r0.append(r13);
        r36 = r36.toString();
        android.util.Slog.w(r35, r36);
        r16 = r16 + 1;
        goto L_0x02ad;
    L_0x02d2:
        r15 = r15 + 1;
        goto L_0x0262;
    L_0x02d5:
        r35 = "Watchdog";
        r36 = "*** GOODBYE!";
        android.util.Slog.w(r35, r36);
        r35 = android.os.Process.myPid();
        android.os.Process.killProcess(r35);
        r35 = 10;
        java.lang.System.exit(r35);
        goto L_0x022d;
    L_0x02ea:
        r35 = move-exception;
        goto L_0x01d0;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.android.server.Watchdog.run():void");
    }

    private void doSysRq(char c) {
        try {
            FileWriter sysrq_trigger = new FileWriter("/proc/sysrq-trigger");
            sysrq_trigger.write(c);
            sysrq_trigger.close();
        } catch (IOException e) {
            Slog.w(TAG, "Failed to write to /proc/sysrq-trigger", e);
        }
    }

    private File dumpKernelStackTraces() {
        String tracesPath = SystemProperties.get("dalvik.vm.stack-trace-file", null);
        if (tracesPath == null || tracesPath.length() == 0) {
            return null;
        }
        native_dumpKernelStacks(tracesPath);
        return new File(tracesPath);
    }
}
