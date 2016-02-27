package com.android.server;

import android.app.ActivityManager;
import android.app.ActivityManagerNative;
import android.app.AlarmManager.AlarmClockInfo;
import android.app.IAlarmManager.Stub;
import android.app.PendingIntent;
import android.app.PendingIntent.CanceledException;
import android.app.PendingIntent.OnFinished;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.Uri;
import android.os.Binder;
import android.os.Handler;
import android.os.IBinder;
import android.os.Message;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.SystemClock;
import android.os.SystemProperties;
import android.os.UserHandle;
import android.os.WorkSource;
import android.provider.Settings.System;
import android.text.TextUtils;
import android.text.format.DateFormat;
import android.util.ArrayMap;
import android.util.Slog;
import android.util.SparseArray;
import android.util.SparseBooleanArray;
import android.util.TimeUtils;
import com.android.internal.util.LocalLog;
import com.android.server.job.controllers.JobStatus;
import com.android.server.wm.WindowManagerService.C0569H;
import java.io.ByteArrayOutputStream;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Locale;
import java.util.TimeZone;

class AlarmManagerService extends SystemService {
    static final int ALARM_EVENT = 1;
    static final String ClockReceiver_TAG = "ClockReceiver";
    static final boolean DEBUG_ALARM_CLOCK = false;
    static final boolean DEBUG_BATCH = false;
    static final boolean DEBUG_VALIDATE = false;
    private static final int ELAPSED_REALTIME_MASK = 8;
    private static final int ELAPSED_REALTIME_WAKEUP_MASK = 4;
    static final int IS_WAKEUP_MASK = 5;
    private static final long LATE_ALARM_THRESHOLD = 10000;
    private static final long MIN_FUTURITY = 5000;
    static final long MIN_FUZZABLE_INTERVAL = 10000;
    private static final long MIN_INTERVAL = 60000;
    private static final Intent NEXT_ALARM_CLOCK_CHANGED_INTENT;
    static final int PRIO_NORMAL = 2;
    static final int PRIO_TICK = 0;
    static final int PRIO_WAKEUP = 1;
    private static final int RTC_MASK = 2;
    private static final int RTC_WAKEUP_MASK = 1;
    static final String TAG = "AlarmManager";
    static final String TIMEZONE_PROPERTY = "persist.sys.timezone";
    static final int TIME_CHANGED_MASK = 65536;
    static final int TYPE_NONWAKEUP_MASK = 1;
    static final boolean WAKEUP_STATS = false;
    static final boolean localLOGV = false;
    static final Intent mBackgroundIntent;
    static final BatchTimeOrder sBatchOrder;
    static final IncreasingTimeOrder sIncreasingTimeOrder;
    final long RECENT_WAKEUP_PERIOD;
    final ArrayList<Batch> mAlarmBatches;
    final Comparator<Alarm> mAlarmDispatchComparator;
    private final ArrayList<Integer> mBlockedUids;
    int mBroadcastRefCount;
    final SparseArray<ArrayMap<String, BroadcastStats>> mBroadcastStats;
    ClockReceiver mClockReceiver;
    int mCurrentSeq;
    PendingIntent mDateChangeSender;
    final AlarmHandler mHandler;
    private final SparseArray<AlarmClockInfo> mHandlerSparseAlarmClockArray;
    ArrayList<InFlight> mInFlight;
    boolean mInteractive;
    InteractiveStateReceiver mInteractiveStateReceiver;
    long mLastAlarmDeliveryTime;
    boolean mLastWakeLockUnimportantForLogging;
    final Object mLock;
    final LocalLog mLog;
    long mMaxDelayTime;
    long mNativeData;
    private final SparseArray<AlarmClockInfo> mNextAlarmClockForUser;
    private boolean mNextAlarmClockMayChange;
    private long mNextNonWakeup;
    long mNextNonWakeupDeliveryTime;
    private long mNextWakeup;
    long mNonInteractiveStartTime;
    long mNonInteractiveTime;
    int mNumDelayedAlarms;
    int mNumTimeChanged;
    ArrayList<Alarm> mPendingNonWakeupAlarms;
    private final SparseBooleanArray mPendingSendNextAlarmClockChangedForUser;
    final HashMap<String, PriorityClass> mPriorities;
    private QuickBootReceiver mQuickBootReceiver;
    final LinkedList<WakeupEvent> mRecentWakeups;
    final ResultReceiver mResultReceiver;
    private final IBinder mService;
    long mStartCurrentDelayTime;
    PendingIntent mTimeTickSender;
    private final SparseArray<AlarmClockInfo> mTmpSparseAlarmClockArray;
    long mTotalDelayTime;
    private final ArrayList<Integer> mTriggeredUids;
    private UninstallReceiver mUninstallReceiver;
    WakeLock mWakeLock;

    /* renamed from: com.android.server.AlarmManagerService.1 */
    class C00001 implements Comparator<Alarm> {
        C00001() {
        }

        public int compare(Alarm lhs, Alarm rhs) {
            if (lhs.priorityClass.priority < rhs.priorityClass.priority) {
                return -1;
            }
            if (lhs.priorityClass.priority > rhs.priorityClass.priority) {
                return AlarmManagerService.TYPE_NONWAKEUP_MASK;
            }
            if (lhs.whenElapsed < rhs.whenElapsed) {
                return -1;
            }
            if (lhs.whenElapsed > rhs.whenElapsed) {
                return AlarmManagerService.TYPE_NONWAKEUP_MASK;
            }
            return AlarmManagerService.PRIO_TICK;
        }
    }

    /* renamed from: com.android.server.AlarmManagerService.2 */
    class C00012 extends Stub {
        C00012() {
        }

        public void set(int type, long triggerAtTime, long windowLength, long interval, PendingIntent operation, WorkSource workSource, AlarmClockInfo alarmClock) {
            if (workSource != null) {
                AlarmManagerService.this.getContext().enforceCallingPermission("android.permission.UPDATE_DEVICE_STATS", "AlarmManager.set");
            }
            AlarmManagerService.this.setImpl(type, triggerAtTime, windowLength, interval, operation, windowLength == 0 ? true : AlarmManagerService.DEBUG_VALIDATE, workSource, alarmClock);
        }

        public boolean setTime(long millis) {
            boolean z = AlarmManagerService.DEBUG_VALIDATE;
            AlarmManagerService.this.getContext().enforceCallingOrSelfPermission("android.permission.SET_TIME", "setTime");
            if (AlarmManagerService.this.mNativeData == 0) {
                Slog.w(AlarmManagerService.TAG, "Not setting time since no alarm driver is available.");
            } else {
                synchronized (AlarmManagerService.this.mLock) {
                    if (AlarmManagerService.this.setKernelTime(AlarmManagerService.this.mNativeData, millis) == 0) {
                        z = true;
                    }
                }
            }
            return z;
        }

        public void setTimeZone(String tz) {
            AlarmManagerService.this.getContext().enforceCallingOrSelfPermission("android.permission.SET_TIME_ZONE", "setTimeZone");
            long oldId = Binder.clearCallingIdentity();
            try {
                AlarmManagerService.this.setTimeZoneImpl(tz);
            } finally {
                Binder.restoreCallingIdentity(oldId);
            }
        }

        public void remove(PendingIntent operation) {
            AlarmManagerService.this.removeImpl(operation);
        }

        public AlarmClockInfo getNextAlarmClock(int userId) {
            return AlarmManagerService.this.getNextAlarmClockImpl(ActivityManager.handleIncomingUser(Binder.getCallingPid(), Binder.getCallingUid(), userId, AlarmManagerService.DEBUG_VALIDATE, AlarmManagerService.DEBUG_VALIDATE, "getNextAlarmClock", null));
        }

        protected void dump(FileDescriptor fd, PrintWriter pw, String[] args) {
            if (AlarmManagerService.this.getContext().checkCallingOrSelfPermission("android.permission.DUMP") != 0) {
                pw.println("Permission Denial: can't dump AlarmManager from from pid=" + Binder.getCallingPid() + ", uid=" + Binder.getCallingUid());
            } else {
                AlarmManagerService.this.dumpImpl(pw);
            }
        }

        public void updateBlockedUids(int uid, boolean isBlocked) {
            if (Binder.getCallingUid() == ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE) {
                synchronized (AlarmManagerService.this.mLock) {
                    if (isBlocked) {
                        AlarmManagerService.this.mBlockedUids.add(new Integer(uid));
                        if (AlarmManagerService.this.checkReleaseWakeLock() && AlarmManagerService.this.mWakeLock.isHeld()) {
                            AlarmManagerService.this.mWakeLock.release();
                        }
                    } else {
                        AlarmManagerService.this.mBlockedUids.clear();
                    }
                }
            }
        }
    }

    /* renamed from: com.android.server.AlarmManagerService.3 */
    class C00023 implements Comparator<FilterStats> {
        C00023() {
        }

        public int compare(FilterStats lhs, FilterStats rhs) {
            if (lhs.aggregateTime < rhs.aggregateTime) {
                return AlarmManagerService.TYPE_NONWAKEUP_MASK;
            }
            if (lhs.aggregateTime > rhs.aggregateTime) {
                return -1;
            }
            return AlarmManagerService.PRIO_TICK;
        }
    }

    private static class Alarm {
        public final AlarmClockInfo alarmClock;
        public int count;
        public long maxWhen;
        public final PendingIntent operation;
        public int pid;
        public PriorityClass priorityClass;
        public long repeatInterval;
        public final String tag;
        public final int type;
        public int uid;
        public final int userId;
        public final boolean wakeup;
        public long when;
        public long whenElapsed;
        public long windowLength;
        public final WorkSource workSource;

        public Alarm(int _type, long _when, long _whenElapsed, long _windowLength, long _maxWhen, long _interval, PendingIntent _op, WorkSource _ws, AlarmClockInfo _info, int _userId) {
            this.type = _type;
            boolean z = (_type == AlarmManagerService.RTC_MASK || _type == 0) ? true : AlarmManagerService.DEBUG_VALIDATE;
            this.wakeup = z;
            this.when = _when;
            this.whenElapsed = _whenElapsed;
            this.windowLength = _windowLength;
            this.maxWhen = _maxWhen;
            this.repeatInterval = _interval;
            this.operation = _op;
            this.tag = makeTag(_op, _type);
            this.workSource = _ws;
            this.alarmClock = _info;
            this.userId = _userId;
            this.uid = Binder.getCallingUid();
            this.pid = Binder.getCallingPid();
        }

        public static String makeTag(PendingIntent pi, int type) {
            String str = (type == AlarmManagerService.RTC_MASK || type == 0) ? "*walarm*:" : "*alarm*:";
            return pi.getTag(str);
        }

        public String toString() {
            StringBuilder sb = new StringBuilder(DumpState.DUMP_PROVIDERS);
            sb.append("Alarm{");
            sb.append(Integer.toHexString(System.identityHashCode(this)));
            sb.append(" type ");
            sb.append(this.type);
            sb.append(" when ");
            sb.append(this.when);
            sb.append(" ");
            sb.append(this.operation.getTargetPackage());
            sb.append('}');
            return sb.toString();
        }

        public void dump(PrintWriter pw, String prefix, long nowRTC, long nowELAPSED, SimpleDateFormat sdf) {
            boolean isRtc = true;
            if (!(this.type == AlarmManagerService.TYPE_NONWAKEUP_MASK || this.type == 0)) {
                isRtc = AlarmManagerService.DEBUG_VALIDATE;
            }
            pw.print(prefix);
            pw.print("tag=");
            pw.println(this.tag);
            pw.print(prefix);
            pw.print("type=");
            pw.print(this.type);
            pw.print(" whenElapsed=");
            TimeUtils.formatDuration(this.whenElapsed, nowELAPSED, pw);
            if (isRtc) {
                pw.print(" when=");
                pw.print(sdf.format(new Date(this.when)));
            } else {
                pw.print(" when=");
                TimeUtils.formatDuration(this.when, nowELAPSED, pw);
            }
            pw.println();
            pw.print(prefix);
            pw.print("window=");
            pw.print(this.windowLength);
            pw.print(" repeatInterval=");
            pw.print(this.repeatInterval);
            pw.print(" count=");
            pw.println(this.count);
            pw.print(prefix);
            pw.print("operation=");
            pw.println(this.operation);
        }
    }

    private class AlarmHandler extends Handler {
        public static final int ALARM_EVENT = 1;
        public static final int DATE_CHANGE_EVENT = 3;
        public static final int MINUTE_CHANGE_EVENT = 2;
        public static final int SEND_NEXT_ALARM_CLOCK_CHANGED = 4;

        public void handleMessage(Message msg) {
            if (msg.what == ALARM_EVENT) {
                ArrayList<Alarm> triggerList = new ArrayList();
                synchronized (AlarmManagerService.this.mLock) {
                    long nowRTC = System.currentTimeMillis();
                    AlarmManagerService.this.triggerAlarmsLocked(triggerList, SystemClock.elapsedRealtime(), nowRTC);
                    AlarmManagerService.this.updateNextAlarmClockLocked();
                }
                for (int i = AlarmManagerService.PRIO_TICK; i < triggerList.size(); i += ALARM_EVENT) {
                    Alarm alarm = (Alarm) triggerList.get(i);
                    try {
                        alarm.operation.send();
                    } catch (CanceledException e) {
                        if (alarm.repeatInterval > 0) {
                            AlarmManagerService.this.removeImpl(alarm.operation);
                        }
                    }
                }
            } else if (msg.what == SEND_NEXT_ALARM_CLOCK_CHANGED) {
                AlarmManagerService.this.sendNextAlarmClockChanged();
            }
        }
    }

    private class AlarmThread extends Thread {
        public AlarmThread() {
            super(AlarmManagerService.TAG);
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void run() {
            /*
            r18 = this;
            r3 = new java.util.ArrayList;
            r3.<init>();
        L_0x0005:
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;
            r0 = r18;
            r11 = com.android.server.AlarmManagerService.this;
            r14 = r11.mNativeData;
            r10 = r2.waitForAlarm(r14);
            r3.clear();
            r2 = 65536; // 0x10000 float:9.18355E-41 double:3.2379E-319;
            r2 = r2 & r10;
            if (r2 == 0) goto L_0x0063;
        L_0x001b:
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;
            r0 = r18;
            r11 = com.android.server.AlarmManagerService.this;
            r11 = r11.mTimeTickSender;
            r2.removeImpl(r11);
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;
            r2.rebatchAllAlarms();
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;
            r2 = r2.mClockReceiver;
            r2.scheduleTimeTickEvent();
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;
            r11 = r2.mLock;
            monitor-enter(r11);
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x00ea }
            r14 = r2.mNumTimeChanged;	 Catch:{ all -> 0x00ea }
            r14 = r14 + 1;
            r2.mNumTimeChanged = r14;	 Catch:{ all -> 0x00ea }
            monitor-exit(r11);	 Catch:{ all -> 0x00ea }
            r9 = new android.content.Intent;
            r2 = "android.intent.action.TIME_SET";
            r9.<init>(r2);
            r2 = 872415232; // 0x34000000 float:1.1920929E-7 double:4.31030395E-315;
            r9.addFlags(r2);
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;
            r2 = r2.getContext();
            r11 = android.os.UserHandle.ALL;
            r2.sendBroadcastAsUser(r9, r11);
        L_0x0063:
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;
            r11 = r2.mLock;
            monitor-enter(r11);
            r6 = java.lang.System.currentTimeMillis();	 Catch:{ all -> 0x00e7 }
            r4 = android.os.SystemClock.elapsedRealtime();	 Catch:{ all -> 0x00e7 }
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x00e7 }
            r8 = r2.triggerAlarmsLocked(r3, r4, r6);	 Catch:{ all -> 0x00e7 }
            r2 = "sys.quickboot.enable";
            r14 = 0;
            r2 = android.os.SystemProperties.getInt(r2, r14);	 Catch:{ all -> 0x00e7 }
            r14 = 1;
            if (r2 != r14) goto L_0x008b;
        L_0x0084:
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x00e7 }
            r2.filtQuickBootAlarms(r3);	 Catch:{ all -> 0x00e7 }
        L_0x008b:
            if (r8 != 0) goto L_0x00ed;
        L_0x008d:
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x00e7 }
            r2 = r2.checkAllowNonWakeupDelayLocked(r4);	 Catch:{ all -> 0x00e7 }
            if (r2 == 0) goto L_0x00ed;
        L_0x0097:
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x00e7 }
            r2 = r2.mPendingNonWakeupAlarms;	 Catch:{ all -> 0x00e7 }
            r2 = r2.size();	 Catch:{ all -> 0x00e7 }
            if (r2 != 0) goto L_0x00c0;
        L_0x00a3:
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x00e7 }
            r2.mStartCurrentDelayTime = r4;	 Catch:{ all -> 0x00e7 }
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x00e7 }
            r0 = r18;
            r14 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x00e7 }
            r14 = r14.currentNonWakeupFuzzLocked(r4);	 Catch:{ all -> 0x00e7 }
            r16 = 3;
            r14 = r14 * r16;
            r16 = 2;
            r14 = r14 / r16;
            r14 = r14 + r4;
            r2.mNextNonWakeupDeliveryTime = r14;	 Catch:{ all -> 0x00e7 }
        L_0x00c0:
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x00e7 }
            r2 = r2.mPendingNonWakeupAlarms;	 Catch:{ all -> 0x00e7 }
            r2.addAll(r3);	 Catch:{ all -> 0x00e7 }
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x00e7 }
            r14 = r2.mNumDelayedAlarms;	 Catch:{ all -> 0x00e7 }
            r15 = r3.size();	 Catch:{ all -> 0x00e7 }
            r14 = r14 + r15;
            r2.mNumDelayedAlarms = r14;	 Catch:{ all -> 0x00e7 }
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x00e7 }
            r2.rescheduleKernelAlarmsLocked();	 Catch:{ all -> 0x00e7 }
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x00e7 }
            r2.updateNextAlarmClockLocked();	 Catch:{ all -> 0x00e7 }
        L_0x00e4:
            monitor-exit(r11);	 Catch:{ all -> 0x00e7 }
            goto L_0x0005;
        L_0x00e7:
            r2 = move-exception;
            monitor-exit(r11);	 Catch:{ all -> 0x00e7 }
            throw r2;
        L_0x00ea:
            r2 = move-exception;
            monitor-exit(r11);	 Catch:{ all -> 0x00ea }
            throw r2;
        L_0x00ed:
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x00e7 }
            r2.rescheduleKernelAlarmsLocked();	 Catch:{ all -> 0x00e7 }
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x00e7 }
            r2.updateNextAlarmClockLocked();	 Catch:{ all -> 0x00e7 }
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x00e7 }
            r2 = r2.mPendingNonWakeupAlarms;	 Catch:{ all -> 0x00e7 }
            r2 = r2.size();	 Catch:{ all -> 0x00e7 }
            if (r2 <= 0) goto L_0x0150;
        L_0x0107:
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x00e7 }
            r0 = r18;
            r14 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x00e7 }
            r14 = r14.mPendingNonWakeupAlarms;	 Catch:{ all -> 0x00e7 }
            r2.calculateDeliveryPriorities(r14);	 Catch:{ all -> 0x00e7 }
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x00e7 }
            r2 = r2.mPendingNonWakeupAlarms;	 Catch:{ all -> 0x00e7 }
            r3.addAll(r2);	 Catch:{ all -> 0x00e7 }
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x00e7 }
            r2 = r2.mAlarmDispatchComparator;	 Catch:{ all -> 0x00e7 }
            java.util.Collections.sort(r3, r2);	 Catch:{ all -> 0x00e7 }
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x00e7 }
            r14 = r2.mStartCurrentDelayTime;	 Catch:{ all -> 0x00e7 }
            r12 = r4 - r14;
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x00e7 }
            r14 = r2.mTotalDelayTime;	 Catch:{ all -> 0x00e7 }
            r14 = r14 + r12;
            r2.mTotalDelayTime = r14;	 Catch:{ all -> 0x00e7 }
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x00e7 }
            r14 = r2.mMaxDelayTime;	 Catch:{ all -> 0x00e7 }
            r2 = (r14 > r12 ? 1 : (r14 == r12 ? 0 : -1));
            if (r2 >= 0) goto L_0x0147;
        L_0x0141:
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x00e7 }
            r2.mMaxDelayTime = r12;	 Catch:{ all -> 0x00e7 }
        L_0x0147:
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x00e7 }
            r2 = r2.mPendingNonWakeupAlarms;	 Catch:{ all -> 0x00e7 }
            r2.clear();	 Catch:{ all -> 0x00e7 }
        L_0x0150:
            r0 = r18;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x00e7 }
            r2.deliverAlarmsLocked(r3, r4);	 Catch:{ all -> 0x00e7 }
            goto L_0x00e4;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.AlarmManagerService.AlarmThread.run():void");
        }
    }

    final class Batch {
        final ArrayList<Alarm> alarms;
        long end;
        boolean standalone;
        long start;

        Batch() {
            this.alarms = new ArrayList();
            this.start = 0;
            this.end = JobStatus.NO_LATEST_RUNTIME;
        }

        Batch(Alarm seed) {
            this.alarms = new ArrayList();
            this.start = seed.whenElapsed;
            this.end = seed.maxWhen;
            this.alarms.add(seed);
        }

        int size() {
            return this.alarms.size();
        }

        Alarm get(int index) {
            return (Alarm) this.alarms.get(index);
        }

        boolean canHold(long whenElapsed, long maxWhen) {
            return (this.end < whenElapsed || this.start > maxWhen) ? AlarmManagerService.DEBUG_VALIDATE : true;
        }

        boolean add(Alarm alarm) {
            boolean newStart = AlarmManagerService.DEBUG_VALIDATE;
            int index = Collections.binarySearch(this.alarms, alarm, AlarmManagerService.sIncreasingTimeOrder);
            if (index < 0) {
                index = (0 - index) - 1;
            }
            this.alarms.add(index, alarm);
            if (alarm.whenElapsed > this.start) {
                this.start = alarm.whenElapsed;
                newStart = true;
            }
            if (alarm.maxWhen < this.end) {
                this.end = alarm.maxWhen;
            }
            return newStart;
        }

        boolean remove(PendingIntent operation) {
            boolean didRemove = AlarmManagerService.DEBUG_VALIDATE;
            long newStart = 0;
            long newEnd = JobStatus.NO_LATEST_RUNTIME;
            int i = AlarmManagerService.PRIO_TICK;
            while (i < this.alarms.size()) {
                Alarm alarm = (Alarm) this.alarms.get(i);
                if (alarm.operation.equals(operation)) {
                    this.alarms.remove(i);
                    didRemove = true;
                    if (alarm.alarmClock != null) {
                        AlarmManagerService.this.mNextAlarmClockMayChange = true;
                    }
                } else {
                    if (alarm.whenElapsed > newStart) {
                        newStart = alarm.whenElapsed;
                    }
                    if (alarm.maxWhen < newEnd) {
                        newEnd = alarm.maxWhen;
                    }
                    i += AlarmManagerService.TYPE_NONWAKEUP_MASK;
                }
            }
            if (didRemove) {
                this.start = newStart;
                this.end = newEnd;
            }
            return didRemove;
        }

        boolean remove(String packageName) {
            boolean didRemove = AlarmManagerService.DEBUG_VALIDATE;
            long newStart = 0;
            long newEnd = JobStatus.NO_LATEST_RUNTIME;
            int i = AlarmManagerService.PRIO_TICK;
            while (i < this.alarms.size()) {
                Alarm alarm = (Alarm) this.alarms.get(i);
                if (alarm.operation.getTargetPackage().equals(packageName)) {
                    this.alarms.remove(i);
                    didRemove = true;
                    if (alarm.alarmClock != null) {
                        AlarmManagerService.this.mNextAlarmClockMayChange = true;
                    }
                } else {
                    if (alarm.whenElapsed > newStart) {
                        newStart = alarm.whenElapsed;
                    }
                    if (alarm.maxWhen < newEnd) {
                        newEnd = alarm.maxWhen;
                    }
                    i += AlarmManagerService.TYPE_NONWAKEUP_MASK;
                }
            }
            if (didRemove) {
                this.start = newStart;
                this.end = newEnd;
            }
            return didRemove;
        }

        boolean remove(int userHandle) {
            boolean didRemove = AlarmManagerService.DEBUG_VALIDATE;
            long newStart = 0;
            long newEnd = JobStatus.NO_LATEST_RUNTIME;
            int i = AlarmManagerService.PRIO_TICK;
            while (i < this.alarms.size()) {
                Alarm alarm = (Alarm) this.alarms.get(i);
                if (UserHandle.getUserId(alarm.operation.getCreatorUid()) == userHandle) {
                    this.alarms.remove(i);
                    didRemove = true;
                    if (alarm.alarmClock != null) {
                        AlarmManagerService.this.mNextAlarmClockMayChange = true;
                    }
                } else {
                    if (alarm.whenElapsed > newStart) {
                        newStart = alarm.whenElapsed;
                    }
                    if (alarm.maxWhen < newEnd) {
                        newEnd = alarm.maxWhen;
                    }
                    i += AlarmManagerService.TYPE_NONWAKEUP_MASK;
                }
            }
            if (didRemove) {
                this.start = newStart;
                this.end = newEnd;
            }
            return didRemove;
        }

        boolean hasPackage(String packageName) {
            int N = this.alarms.size();
            for (int i = AlarmManagerService.PRIO_TICK; i < N; i += AlarmManagerService.TYPE_NONWAKEUP_MASK) {
                if (((Alarm) this.alarms.get(i)).operation.getTargetPackage().equals(packageName)) {
                    return true;
                }
            }
            return AlarmManagerService.DEBUG_VALIDATE;
        }

        boolean hasWakeups() {
            int N = this.alarms.size();
            for (int i = AlarmManagerService.PRIO_TICK; i < N; i += AlarmManagerService.TYPE_NONWAKEUP_MASK) {
                if ((((Alarm) this.alarms.get(i)).type & AlarmManagerService.TYPE_NONWAKEUP_MASK) == 0) {
                    return true;
                }
            }
            return AlarmManagerService.DEBUG_VALIDATE;
        }

        public String toString() {
            StringBuilder b = new StringBuilder(40);
            b.append("Batch{");
            b.append(Integer.toHexString(hashCode()));
            b.append(" num=");
            b.append(size());
            b.append(" start=");
            b.append(this.start);
            b.append(" end=");
            b.append(this.end);
            if (this.standalone) {
                b.append(" STANDALONE");
            }
            b.append('}');
            return b.toString();
        }
    }

    static class BatchTimeOrder implements Comparator<Batch> {
        BatchTimeOrder() {
        }

        public int compare(Batch b1, Batch b2) {
            long when1 = b1.start;
            long when2 = b2.start;
            if (when1 > when2) {
                return AlarmManagerService.TYPE_NONWAKEUP_MASK;
            }
            if (when1 < when2) {
                return -1;
            }
            return AlarmManagerService.PRIO_TICK;
        }
    }

    static final class BroadcastStats {
        long aggregateTime;
        int count;
        final ArrayMap<String, FilterStats> filterStats;
        final String mPackageName;
        final int mUid;
        int nesting;
        int numWakeup;
        long startTime;

        BroadcastStats(int uid, String packageName) {
            this.filterStats = new ArrayMap();
            this.mUid = uid;
            this.mPackageName = packageName;
        }
    }

    class ClockReceiver extends BroadcastReceiver {
        public ClockReceiver() {
            IntentFilter filter = new IntentFilter();
            filter.addAction("android.intent.action.TIME_TICK");
            filter.addAction("android.intent.action.TIME_SET");
            filter.addAction("android.intent.action.DATE_CHANGED");
            AlarmManagerService.this.getContext().registerReceiver(this, filter);
        }

        public void onReceive(Context context, Intent intent) {
            if (intent.getAction().equals("android.intent.action.TIME_TICK")) {
                scheduleTimeTickEvent();
            } else if (intent.getAction().equals("android.intent.action.TIME_SET")) {
                scheduleDateChangedEvent();
            } else if (intent.getAction().equals("android.intent.action.DATE_CHANGED")) {
                AlarmManagerService.this.setKernelTimezone(AlarmManagerService.this.mNativeData, -(TimeZone.getTimeZone(SystemProperties.get(AlarmManagerService.TIMEZONE_PROPERTY)).getOffset(System.currentTimeMillis()) / 60000));
                scheduleDateChangedEvent();
            }
        }

        public void scheduleTimeTickEvent() {
            long currentTime = System.currentTimeMillis();
            AlarmManagerService.this.setImpl(3, SystemClock.elapsedRealtime() + ((AlarmManagerService.MIN_INTERVAL * ((currentTime / AlarmManagerService.MIN_INTERVAL) + 1)) - currentTime), 0, 0, AlarmManagerService.this.mTimeTickSender, true, null, null);
        }

        public void scheduleDateChangedEvent() {
            Calendar calendar = Calendar.getInstance();
            calendar.setTimeInMillis(System.currentTimeMillis());
            calendar.set(11, AlarmManagerService.PRIO_TICK);
            calendar.set(12, AlarmManagerService.PRIO_TICK);
            calendar.set(13, AlarmManagerService.PRIO_TICK);
            calendar.set(14, AlarmManagerService.PRIO_TICK);
            calendar.add(AlarmManagerService.IS_WAKEUP_MASK, AlarmManagerService.TYPE_NONWAKEUP_MASK);
            AlarmManagerService.this.setImpl(AlarmManagerService.TYPE_NONWAKEUP_MASK, calendar.getTimeInMillis(), 0, 0, AlarmManagerService.this.mDateChangeSender, true, null, null);
        }
    }

    static final class FilterStats {
        long aggregateTime;
        int count;
        final BroadcastStats mBroadcastStats;
        final String mTag;
        int nesting;
        int numWakeup;
        long startTime;

        FilterStats(BroadcastStats broadcastStats, String tag) {
            this.mBroadcastStats = broadcastStats;
            this.mTag = tag;
        }
    }

    static final class InFlight extends Intent {
        final int mAlarmType;
        final BroadcastStats mBroadcastStats;
        final FilterStats mFilterStats;
        final PendingIntent mPendingIntent;
        final String mTag;
        final int mUid;
        final WorkSource mWorkSource;

        InFlight(AlarmManagerService service, PendingIntent pendingIntent, WorkSource workSource, int alarmType, String tag, int uid) {
            this.mPendingIntent = pendingIntent;
            this.mWorkSource = workSource;
            this.mTag = tag;
            this.mBroadcastStats = service.getStatsLocked(pendingIntent);
            FilterStats fs = (FilterStats) this.mBroadcastStats.filterStats.get(this.mTag);
            if (fs == null) {
                fs = new FilterStats(this.mBroadcastStats, this.mTag);
                this.mBroadcastStats.filterStats.put(this.mTag, fs);
            }
            this.mFilterStats = fs;
            this.mAlarmType = alarmType;
            this.mUid = uid;
        }
    }

    public static class IncreasingTimeOrder implements Comparator<Alarm> {
        public int compare(Alarm a1, Alarm a2) {
            long when1 = a1.whenElapsed;
            long when2 = a2.whenElapsed;
            if (when1 > when2) {
                return AlarmManagerService.TYPE_NONWAKEUP_MASK;
            }
            if (when1 < when2) {
                return -1;
            }
            return AlarmManagerService.PRIO_TICK;
        }
    }

    class InteractiveStateReceiver extends BroadcastReceiver {
        public InteractiveStateReceiver() {
            IntentFilter filter = new IntentFilter();
            filter.addAction("android.intent.action.SCREEN_OFF");
            filter.addAction("android.intent.action.SCREEN_ON");
            filter.setPriority(ProcessList.PSS_SAFE_TIME_FROM_STATE_CHANGE);
            AlarmManagerService.this.getContext().registerReceiver(this, filter);
        }

        public void onReceive(Context context, Intent intent) {
            synchronized (AlarmManagerService.this.mLock) {
                AlarmManagerService.this.interactiveStateChangedLocked("android.intent.action.SCREEN_ON".equals(intent.getAction()));
            }
        }
    }

    class PriorityClass {
        int priority;
        int seq;

        PriorityClass() {
            this.seq = AlarmManagerService.this.mCurrentSeq - 1;
            this.priority = AlarmManagerService.RTC_MASK;
        }
    }

    private class QuickBootReceiver extends BroadcastReceiver {
        static final String ACTION_APP_KILL = "org.codeaurora.quickboot.appkilled";

        public QuickBootReceiver() {
            IntentFilter filter = new IntentFilter();
            filter.addAction(ACTION_APP_KILL);
            AlarmManagerService.this.getContext().registerReceiver(this, filter, "android.permission.DEVICE_POWER", null);
        }

        public void onReceive(Context context, Intent intent) {
            if (ACTION_APP_KILL.equals(intent.getAction())) {
                String[] pkgList = intent.getStringArrayExtra("android.intent.extra.PACKAGES");
                if (pkgList != null && pkgList.length > 0) {
                    String[] arr$ = pkgList;
                    int len$ = arr$.length;
                    for (int i$ = AlarmManagerService.PRIO_TICK; i$ < len$; i$ += AlarmManagerService.TYPE_NONWAKEUP_MASK) {
                        String pkg = arr$[i$];
                        AlarmManagerService.this.removeLocked(pkg);
                        for (int i = AlarmManagerService.this.mBroadcastStats.size() - 1; i >= 0; i--) {
                            ArrayMap<String, BroadcastStats> uidStats = (ArrayMap) AlarmManagerService.this.mBroadcastStats.valueAt(i);
                            if (uidStats.remove(pkg) != null && uidStats.size() <= 0) {
                                AlarmManagerService.this.mBroadcastStats.removeAt(i);
                            }
                        }
                    }
                }
            }
        }
    }

    class ResultReceiver implements OnFinished {
        ResultReceiver() {
        }

        /* JADX WARNING: inconsistent code. */
        /* Code decompiled incorrectly, please refer to instructions dump. */
        public void onSendFinished(android.app.PendingIntent r18, android.content.Intent r19, int r20, java.lang.String r21, android.os.Bundle r22) {
            /*
            r17 = this;
            r0 = r17;
            r2 = com.android.server.AlarmManagerService.this;
            r0 = r2.mLock;
            r16 = r0;
            monitor-enter(r16);
            r13 = 0;
            r12 = 0;
            r10 = 0;
        L_0x000c:
            r0 = r17;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x017a }
            r2 = r2.mInFlight;	 Catch:{ all -> 0x017a }
            r2 = r2.size();	 Catch:{ all -> 0x017a }
            if (r10 >= r2) goto L_0x0046;
        L_0x0018:
            r0 = r17;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x017a }
            r2 = r2.mInFlight;	 Catch:{ all -> 0x017a }
            r2 = r2.get(r10);	 Catch:{ all -> 0x017a }
            r2 = (com.android.server.AlarmManagerService.InFlight) r2;	 Catch:{ all -> 0x017a }
            r2 = r2.mPendingIntent;	 Catch:{ all -> 0x017a }
            r0 = r18;
            if (r2 != r0) goto L_0x014a;
        L_0x002a:
            r0 = r17;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x017a }
            r2 = r2.mInFlight;	 Catch:{ all -> 0x017a }
            r2 = r2.get(r10);	 Catch:{ all -> 0x017a }
            r2 = (com.android.server.AlarmManagerService.InFlight) r2;	 Catch:{ all -> 0x017a }
            r13 = r2.mUid;	 Catch:{ all -> 0x017a }
            r0 = r17;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x017a }
            r2 = r2.mInFlight;	 Catch:{ all -> 0x017a }
            r2 = r2.remove(r10);	 Catch:{ all -> 0x017a }
            r0 = r2;
            r0 = (com.android.server.AlarmManagerService.InFlight) r0;	 Catch:{ all -> 0x017a }
            r12 = r0;
        L_0x0046:
            if (r12 == 0) goto L_0x014e;
        L_0x0048:
            r14 = android.os.SystemClock.elapsedRealtime();	 Catch:{ all -> 0x017a }
            r8 = r12.mBroadcastStats;	 Catch:{ all -> 0x017a }
            r2 = r8.nesting;	 Catch:{ all -> 0x017a }
            r2 = r2 + -1;
            r8.nesting = r2;	 Catch:{ all -> 0x017a }
            r2 = r8.nesting;	 Catch:{ all -> 0x017a }
            if (r2 > 0) goto L_0x0064;
        L_0x0058:
            r2 = 0;
            r8.nesting = r2;	 Catch:{ all -> 0x017a }
            r2 = r8.aggregateTime;	 Catch:{ all -> 0x017a }
            r4 = r8.startTime;	 Catch:{ all -> 0x017a }
            r4 = r14 - r4;
            r2 = r2 + r4;
            r8.aggregateTime = r2;	 Catch:{ all -> 0x017a }
        L_0x0064:
            r9 = r12.mFilterStats;	 Catch:{ all -> 0x017a }
            r2 = r9.nesting;	 Catch:{ all -> 0x017a }
            r2 = r2 + -1;
            r9.nesting = r2;	 Catch:{ all -> 0x017a }
            r2 = r9.nesting;	 Catch:{ all -> 0x017a }
            if (r2 > 0) goto L_0x007c;
        L_0x0070:
            r2 = 0;
            r9.nesting = r2;	 Catch:{ all -> 0x017a }
            r2 = r9.aggregateTime;	 Catch:{ all -> 0x017a }
            r4 = r9.startTime;	 Catch:{ all -> 0x017a }
            r4 = r14 - r4;
            r2 = r2 + r4;
            r9.aggregateTime = r2;	 Catch:{ all -> 0x017a }
        L_0x007c:
            r0 = r17;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x017a }
            r3 = r2.mBroadcastRefCount;	 Catch:{ all -> 0x017a }
            r3 = r3 + -1;
            r2.mBroadcastRefCount = r3;	 Catch:{ all -> 0x017a }
            r0 = r17;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x017a }
            r2 = r2.mTriggeredUids;	 Catch:{ all -> 0x017a }
            r3 = new java.lang.Integer;	 Catch:{ all -> 0x017a }
            r3.<init>(r13);	 Catch:{ all -> 0x017a }
            r2.remove(r3);	 Catch:{ all -> 0x017a }
            r0 = r17;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x017a }
            r2 = r2.checkReleaseWakeLock();	 Catch:{ all -> 0x017a }
            if (r2 == 0) goto L_0x00b5;
        L_0x00a0:
            r0 = r17;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x017a }
            r2 = r2.mWakeLock;	 Catch:{ all -> 0x017a }
            r2 = r2.isHeld();	 Catch:{ all -> 0x017a }
            if (r2 == 0) goto L_0x00b5;
        L_0x00ac:
            r0 = r17;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x017a }
            r2 = r2.mWakeLock;	 Catch:{ all -> 0x017a }
            r2.release();	 Catch:{ all -> 0x017a }
        L_0x00b5:
            r0 = r17;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x017a }
            r2 = r2.mBroadcastRefCount;	 Catch:{ all -> 0x017a }
            if (r2 != 0) goto L_0x0188;
        L_0x00bd:
            r0 = r17;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x017a }
            r2 = r2.mWakeLock;	 Catch:{ all -> 0x017a }
            r2 = r2.isHeld();	 Catch:{ all -> 0x017a }
            if (r2 == 0) goto L_0x00d2;
        L_0x00c9:
            r0 = r17;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x017a }
            r2 = r2.mWakeLock;	 Catch:{ all -> 0x017a }
            r2.release();	 Catch:{ all -> 0x017a }
        L_0x00d2:
            r0 = r17;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x017a }
            r2 = r2.mInFlight;	 Catch:{ all -> 0x017a }
            r2 = r2.size();	 Catch:{ all -> 0x017a }
            if (r2 <= 0) goto L_0x0186;
        L_0x00de:
            r0 = r17;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x017a }
            r2 = r2.mLog;	 Catch:{ all -> 0x017a }
            r3 = new java.lang.StringBuilder;	 Catch:{ all -> 0x017a }
            r3.<init>();	 Catch:{ all -> 0x017a }
            r4 = "Finished all broadcasts with ";
            r3 = r3.append(r4);	 Catch:{ all -> 0x017a }
            r0 = r17;
            r4 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x017a }
            r4 = r4.mInFlight;	 Catch:{ all -> 0x017a }
            r4 = r4.size();	 Catch:{ all -> 0x017a }
            r3 = r3.append(r4);	 Catch:{ all -> 0x017a }
            r4 = " remaining inflights";
            r3 = r3.append(r4);	 Catch:{ all -> 0x017a }
            r3 = r3.toString();	 Catch:{ all -> 0x017a }
            r2.w(r3);	 Catch:{ all -> 0x017a }
            r10 = 0;
        L_0x010b:
            r0 = r17;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x017a }
            r2 = r2.mInFlight;	 Catch:{ all -> 0x017a }
            r2 = r2.size();	 Catch:{ all -> 0x017a }
            if (r10 >= r2) goto L_0x017d;
        L_0x0117:
            r0 = r17;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x017a }
            r2 = r2.mLog;	 Catch:{ all -> 0x017a }
            r3 = new java.lang.StringBuilder;	 Catch:{ all -> 0x017a }
            r3.<init>();	 Catch:{ all -> 0x017a }
            r4 = "  Remaining #";
            r3 = r3.append(r4);	 Catch:{ all -> 0x017a }
            r3 = r3.append(r10);	 Catch:{ all -> 0x017a }
            r4 = ": ";
            r3 = r3.append(r4);	 Catch:{ all -> 0x017a }
            r0 = r17;
            r4 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x017a }
            r4 = r4.mInFlight;	 Catch:{ all -> 0x017a }
            r4 = r4.get(r10);	 Catch:{ all -> 0x017a }
            r3 = r3.append(r4);	 Catch:{ all -> 0x017a }
            r3 = r3.toString();	 Catch:{ all -> 0x017a }
            r2.w(r3);	 Catch:{ all -> 0x017a }
            r10 = r10 + 1;
            goto L_0x010b;
        L_0x014a:
            r10 = r10 + 1;
            goto L_0x000c;
        L_0x014e:
            r0 = r17;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x017a }
            r2 = r2.mLog;	 Catch:{ all -> 0x017a }
            r3 = new java.lang.StringBuilder;	 Catch:{ all -> 0x017a }
            r3.<init>();	 Catch:{ all -> 0x017a }
            r4 = "No in-flight alarm for ";
            r3 = r3.append(r4);	 Catch:{ all -> 0x017a }
            r0 = r18;
            r3 = r3.append(r0);	 Catch:{ all -> 0x017a }
            r4 = " ";
            r3 = r3.append(r4);	 Catch:{ all -> 0x017a }
            r0 = r19;
            r3 = r3.append(r0);	 Catch:{ all -> 0x017a }
            r3 = r3.toString();	 Catch:{ all -> 0x017a }
            r2.w(r3);	 Catch:{ all -> 0x017a }
            goto L_0x007c;
        L_0x017a:
            r2 = move-exception;
            monitor-exit(r16);	 Catch:{ all -> 0x017a }
            throw r2;
        L_0x017d:
            r0 = r17;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x017a }
            r2 = r2.mInFlight;	 Catch:{ all -> 0x017a }
            r2.clear();	 Catch:{ all -> 0x017a }
        L_0x0186:
            monitor-exit(r16);	 Catch:{ all -> 0x017a }
            return;
        L_0x0188:
            r0 = r17;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x017a }
            r2 = r2.mInFlight;	 Catch:{ all -> 0x017a }
            r2 = r2.size();	 Catch:{ all -> 0x017a }
            if (r2 <= 0) goto L_0x01b2;
        L_0x0194:
            r0 = r17;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x017a }
            r2 = r2.mInFlight;	 Catch:{ all -> 0x017a }
            r3 = 0;
            r11 = r2.get(r3);	 Catch:{ all -> 0x017a }
            r11 = (com.android.server.AlarmManagerService.InFlight) r11;	 Catch:{ all -> 0x017a }
            r0 = r17;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x017a }
            r3 = r11.mPendingIntent;	 Catch:{ all -> 0x017a }
            r4 = r11.mWorkSource;	 Catch:{ all -> 0x017a }
            r5 = r11.mAlarmType;	 Catch:{ all -> 0x017a }
            r6 = r11.mTag;	 Catch:{ all -> 0x017a }
            r7 = 0;
            r2.setWakelockWorkSource(r3, r4, r5, r6, r7);	 Catch:{ all -> 0x017a }
            goto L_0x0186;
        L_0x01b2:
            r0 = r17;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x017a }
            r2 = r2.mLog;	 Catch:{ all -> 0x017a }
            r3 = "Alarm wakelock still held but sent queue empty";
            r2.w(r3);	 Catch:{ all -> 0x017a }
            r0 = r17;
            r2 = com.android.server.AlarmManagerService.this;	 Catch:{ all -> 0x017a }
            r2 = r2.mWakeLock;	 Catch:{ all -> 0x017a }
            r3 = 0;
            r2.setWorkSource(r3);	 Catch:{ all -> 0x017a }
            goto L_0x0186;
            */
            throw new UnsupportedOperationException("Method not decompiled: com.android.server.AlarmManagerService.ResultReceiver.onSendFinished(android.app.PendingIntent, android.content.Intent, int, java.lang.String, android.os.Bundle):void");
        }
    }

    class UninstallReceiver extends BroadcastReceiver {
        public UninstallReceiver() {
            IntentFilter filter = new IntentFilter();
            filter.addAction("android.intent.action.PACKAGE_REMOVED");
            filter.addAction("android.intent.action.PACKAGE_RESTARTED");
            filter.addAction("android.intent.action.QUERY_PACKAGE_RESTART");
            filter.addDataScheme("package");
            AlarmManagerService.this.getContext().registerReceiver(this, filter);
            IntentFilter sdFilter = new IntentFilter();
            sdFilter.addAction("android.intent.action.EXTERNAL_APPLICATIONS_UNAVAILABLE");
            sdFilter.addAction("android.intent.action.USER_STOPPED");
            AlarmManagerService.this.getContext().registerReceiver(this, sdFilter);
        }

        public void onReceive(Context context, Intent intent) {
            synchronized (AlarmManagerService.this.mLock) {
                String action = intent.getAction();
                String[] pkgList = null;
                String[] arr$;
                int len$;
                int i$;
                if ("android.intent.action.QUERY_PACKAGE_RESTART".equals(action)) {
                    arr$ = intent.getStringArrayExtra("android.intent.extra.PACKAGES");
                    len$ = arr$.length;
                    for (i$ = AlarmManagerService.PRIO_TICK; i$ < len$; i$ += AlarmManagerService.TYPE_NONWAKEUP_MASK) {
                        if (AlarmManagerService.this.lookForPackageLocked(arr$[i$])) {
                            setResultCode(-1);
                            return;
                        }
                    }
                    return;
                }
                String pkg;
                if ("android.intent.action.EXTERNAL_APPLICATIONS_UNAVAILABLE".equals(action)) {
                    pkgList = intent.getStringArrayExtra("android.intent.extra.changed_package_list");
                } else if ("android.intent.action.USER_STOPPED".equals(action)) {
                    int userHandle = intent.getIntExtra("android.intent.extra.user_handle", -1);
                    if (userHandle >= 0) {
                        AlarmManagerService.this.removeUserLocked(userHandle);
                    }
                } else {
                    if ("android.intent.action.PACKAGE_REMOVED".equals(action)) {
                        if (intent.getBooleanExtra("android.intent.extra.REPLACING", AlarmManagerService.DEBUG_VALIDATE)) {
                            return;
                        }
                    }
                    Uri data = intent.getData();
                    if (data != null) {
                        pkg = data.getSchemeSpecificPart();
                        if (pkg != null) {
                            pkgList = new String[AlarmManagerService.TYPE_NONWAKEUP_MASK];
                            pkgList[AlarmManagerService.PRIO_TICK] = pkg;
                        }
                    }
                }
                if (pkgList != null && pkgList.length > 0) {
                    arr$ = pkgList;
                    len$ = arr$.length;
                    for (i$ = AlarmManagerService.PRIO_TICK; i$ < len$; i$ += AlarmManagerService.TYPE_NONWAKEUP_MASK) {
                        pkg = arr$[i$];
                        AlarmManagerService.this.removeLocked(pkg);
                        AlarmManagerService.this.mPriorities.remove(pkg);
                        for (int i = AlarmManagerService.this.mBroadcastStats.size() - 1; i >= 0; i--) {
                            ArrayMap<String, BroadcastStats> uidStats = (ArrayMap) AlarmManagerService.this.mBroadcastStats.valueAt(i);
                            if (uidStats.remove(pkg) != null && uidStats.size() <= 0) {
                                AlarmManagerService.this.mBroadcastStats.removeAt(i);
                            }
                        }
                    }
                }
            }
        }
    }

    class WakeupEvent {
        public String action;
        public int uid;
        public long when;

        public WakeupEvent(long theTime, int theUid, String theAction) {
            this.when = theTime;
            this.uid = theUid;
            this.action = theAction;
        }
    }

    private native void close(long j);

    private native long init();

    private native void set(long j, int i, long j2, long j3);

    private native int setKernelTime(long j, long j2);

    private native int setKernelTimezone(long j, int i);

    private native int waitForAlarm(long j);

    static {
        mBackgroundIntent = new Intent().addFlags(ELAPSED_REALTIME_WAKEUP_MASK);
        sIncreasingTimeOrder = new IncreasingTimeOrder();
        NEXT_ALARM_CLOCK_CHANGED_INTENT = new Intent("android.app.action.NEXT_ALARM_CLOCK_CHANGED");
        sBatchOrder = new BatchTimeOrder();
    }

    void calculateDeliveryPriorities(ArrayList<Alarm> alarms) {
        int N = alarms.size();
        for (int i = PRIO_TICK; i < N; i += TYPE_NONWAKEUP_MASK) {
            int alarmPrio;
            Alarm a = (Alarm) alarms.get(i);
            if ("android.intent.action.TIME_TICK".equals(a.operation.getIntent().getAction())) {
                alarmPrio = PRIO_TICK;
            } else if (a.wakeup) {
                alarmPrio = TYPE_NONWAKEUP_MASK;
            } else {
                alarmPrio = RTC_MASK;
            }
            PriorityClass priorityClass = a.priorityClass;
            if (priorityClass == null) {
                priorityClass = (PriorityClass) this.mPriorities.get(a.operation.getCreatorPackage());
            }
            if (priorityClass == null) {
                priorityClass = new PriorityClass();
                a.priorityClass = priorityClass;
                this.mPriorities.put(a.operation.getCreatorPackage(), priorityClass);
            }
            a.priorityClass = priorityClass;
            if (priorityClass.seq != this.mCurrentSeq) {
                priorityClass.priority = alarmPrio;
                priorityClass.seq = this.mCurrentSeq;
            } else if (alarmPrio < priorityClass.priority) {
                priorityClass.priority = alarmPrio;
            }
        }
    }

    public AlarmManagerService(Context context) {
        super(context);
        this.mLog = new LocalLog(TAG);
        this.mLock = new Object();
        this.mTriggeredUids = new ArrayList();
        this.mBlockedUids = new ArrayList();
        this.mBroadcastRefCount = PRIO_TICK;
        this.mPendingNonWakeupAlarms = new ArrayList();
        this.mInFlight = new ArrayList();
        this.mHandler = new AlarmHandler();
        this.mResultReceiver = new ResultReceiver();
        this.mInteractive = true;
        this.mNextAlarmClockForUser = new SparseArray();
        this.mTmpSparseAlarmClockArray = new SparseArray();
        this.mPendingSendNextAlarmClockChangedForUser = new SparseBooleanArray();
        this.mHandlerSparseAlarmClockArray = new SparseArray();
        this.mPriorities = new HashMap();
        this.mCurrentSeq = PRIO_TICK;
        this.mRecentWakeups = new LinkedList();
        this.RECENT_WAKEUP_PERIOD = 86400000;
        this.mAlarmDispatchComparator = new C00001();
        this.mAlarmBatches = new ArrayList();
        this.mBroadcastStats = new SparseArray();
        this.mNumDelayedAlarms = PRIO_TICK;
        this.mTotalDelayTime = 0;
        this.mMaxDelayTime = 0;
        this.mService = new C00012();
    }

    static long convertToElapsed(long when, int type) {
        boolean isRtc = true;
        if (!(type == TYPE_NONWAKEUP_MASK || type == 0)) {
            isRtc = DEBUG_VALIDATE;
        }
        if (isRtc) {
            return when - (System.currentTimeMillis() - SystemClock.elapsedRealtime());
        }
        return when;
    }

    static long maxTriggerTime(long now, long triggerAtTime, long interval) {
        long futurity;
        if (interval == 0) {
            futurity = triggerAtTime - now;
        } else {
            futurity = interval;
        }
        if (futurity < MIN_FUZZABLE_INTERVAL) {
            futurity = 0;
        }
        return ((long) (0.75d * ((double) futurity))) + triggerAtTime;
    }

    static boolean addBatchLocked(ArrayList<Batch> list, Batch newBatch) {
        int index = Collections.binarySearch(list, newBatch, sBatchOrder);
        if (index < 0) {
            index = (0 - index) - 1;
        }
        list.add(index, newBatch);
        return index == 0 ? true : DEBUG_VALIDATE;
    }

    int attemptCoalesceLocked(long whenElapsed, long maxWhen) {
        int N = this.mAlarmBatches.size();
        for (int i = PRIO_TICK; i < N; i += TYPE_NONWAKEUP_MASK) {
            Batch b = (Batch) this.mAlarmBatches.get(i);
            if (!b.standalone && b.canHold(whenElapsed, maxWhen)) {
                return i;
            }
        }
        return -1;
    }

    void rebatchAllAlarms() {
        synchronized (this.mLock) {
            rebatchAllAlarmsLocked(true);
        }
    }

    void rebatchAllAlarmsLocked(boolean doValidate) {
        ArrayList<Batch> oldSet = (ArrayList) this.mAlarmBatches.clone();
        this.mAlarmBatches.clear();
        long nowElapsed = SystemClock.elapsedRealtime();
        int oldBatches = oldSet.size();
        for (int batchNum = PRIO_TICK; batchNum < oldBatches; batchNum += TYPE_NONWAKEUP_MASK) {
            Batch batch = (Batch) oldSet.get(batchNum);
            int N = batch.size();
            for (int i = PRIO_TICK; i < N; i += TYPE_NONWAKEUP_MASK) {
                long maxElapsed;
                Alarm a = batch.get(i);
                long whenElapsed = convertToElapsed(a.when, a.type);
                if (a.whenElapsed == a.maxWhen) {
                    maxElapsed = whenElapsed;
                } else if (a.windowLength > 0) {
                    maxElapsed = whenElapsed + a.windowLength;
                } else {
                    maxElapsed = maxTriggerTime(nowElapsed, whenElapsed, a.repeatInterval);
                }
                long j = whenElapsed;
                boolean z = doValidate;
                setImplLocked(a.type, a.when, j, a.windowLength, maxElapsed, a.repeatInterval, a.operation, batch.standalone, z, a.workSource, a.alarmClock, a.userId);
            }
        }
    }

    public void onStart() {
        this.mNativeData = init();
        this.mNextNonWakeup = 0;
        this.mNextWakeup = 0;
        setTimeZoneImpl(SystemProperties.get(TIMEZONE_PROPERTY));
        this.mWakeLock = ((PowerManager) getContext().getSystemService("power")).newWakeLock(TYPE_NONWAKEUP_MASK, "*alarm*");
        this.mTimeTickSender = PendingIntent.getBroadcastAsUser(getContext(), PRIO_TICK, new Intent("android.intent.action.TIME_TICK").addFlags(1342177280), PRIO_TICK, UserHandle.ALL);
        Intent intent = new Intent("android.intent.action.DATE_CHANGED");
        intent.addFlags(536870912);
        this.mDateChangeSender = PendingIntent.getBroadcastAsUser(getContext(), PRIO_TICK, intent, 67108864, UserHandle.ALL);
        this.mClockReceiver = new ClockReceiver();
        this.mClockReceiver.scheduleTimeTickEvent();
        this.mClockReceiver.scheduleDateChangedEvent();
        this.mInteractiveStateReceiver = new InteractiveStateReceiver();
        this.mUninstallReceiver = new UninstallReceiver();
        this.mQuickBootReceiver = new QuickBootReceiver();
        if (this.mNativeData != 0) {
            new AlarmThread().start();
        } else {
            Slog.w(TAG, "Failed to open alarm driver. Falling back to a handler.");
        }
        publishBinderService("alarm", this.mService);
    }

    protected void finalize() throws Throwable {
        try {
            close(this.mNativeData);
        } finally {
            super.finalize();
        }
    }

    void setTimeZoneImpl(String tz) {
        if (!TextUtils.isEmpty(tz)) {
            TimeZone zone = TimeZone.getTimeZone(tz);
            boolean timeZoneWasChanged = DEBUG_VALIDATE;
            synchronized (this) {
                String current = SystemProperties.get(TIMEZONE_PROPERTY);
                if (current == null || !current.equals(zone.getID())) {
                    timeZoneWasChanged = true;
                    SystemProperties.set(TIMEZONE_PROPERTY, zone.getID());
                }
                setKernelTimezone(this.mNativeData, -(zone.getOffset(System.currentTimeMillis()) / 60000));
            }
            TimeZone.setDefault(null);
            if (timeZoneWasChanged) {
                Intent intent = new Intent("android.intent.action.TIMEZONE_CHANGED");
                intent.addFlags(536870912);
                intent.putExtra("time-zone", zone.getID());
                getContext().sendBroadcastAsUser(intent, UserHandle.ALL);
            }
        }
    }

    void removeImpl(PendingIntent operation) {
        if (operation != null) {
            synchronized (this.mLock) {
                removeLocked(operation);
            }
        }
    }

    void setImpl(int type, long triggerAtTime, long windowLength, long interval, PendingIntent operation, boolean isStandalone, WorkSource workSource, AlarmClockInfo alarmClock) {
        if (operation == null) {
            Slog.w(TAG, "set/setRepeating ignored because there is no intent");
            return;
        }
        if (windowLength > 43200000) {
            Slog.w(TAG, "Window length " + windowLength + "ms suspiciously long; limiting to 1 hour");
            windowLength = 3600000;
        }
        if (interval > 0 && interval < MIN_INTERVAL) {
            Slog.w(TAG, "Suspiciously short interval " + interval + " millis; expanding to " + 60 + " seconds");
            interval = MIN_INTERVAL;
        }
        if (type < 0 || type > 3) {
            throw new IllegalArgumentException("Invalid alarm type " + type);
        }
        long triggerElapsed;
        long maxElapsed;
        if (triggerAtTime < 0) {
            long what = (long) Binder.getCallingPid();
            Slog.w(TAG, "Invalid alarm trigger time! " + triggerAtTime + " from uid=" + ((long) Binder.getCallingUid()) + " pid=" + what);
            triggerAtTime = 0;
        }
        long nowElapsed = SystemClock.elapsedRealtime();
        long nominalTrigger = convertToElapsed(triggerAtTime, type);
        long minTrigger = nowElapsed + MIN_FUTURITY;
        if (nominalTrigger > minTrigger) {
            triggerElapsed = nominalTrigger;
        } else {
            triggerElapsed = minTrigger;
        }
        if (windowLength == 0) {
            maxElapsed = triggerElapsed;
        } else if (windowLength < 0) {
            maxElapsed = maxTriggerTime(nowElapsed, triggerElapsed, interval);
        } else {
            maxElapsed = triggerElapsed + windowLength;
        }
        int userId = UserHandle.getCallingUserId();
        synchronized (this.mLock) {
            setImplLocked(type, triggerAtTime, triggerElapsed, windowLength, maxElapsed, interval, operation, isStandalone, true, workSource, alarmClock, userId);
        }
    }

    private void setImplLocked(int type, long when, long whenElapsed, long windowLength, long maxWhen, long interval, PendingIntent operation, boolean isStandalone, boolean doValidate, WorkSource workSource, AlarmClockInfo alarmClock, int userId) {
        Alarm a = new Alarm(type, when, whenElapsed, windowLength, maxWhen, interval, operation, workSource, alarmClock, userId);
        removeLocked(operation);
        int whichBatch = isStandalone ? -1 : attemptCoalesceLocked(whenElapsed, maxWhen);
        if (whichBatch < 0) {
            Batch batch = new Batch(a);
            batch.standalone = isStandalone;
            addBatchLocked(this.mAlarmBatches, batch);
        } else {
            Batch batch2 = (Batch) this.mAlarmBatches.get(whichBatch);
            if (batch2.add(a)) {
                this.mAlarmBatches.remove(whichBatch);
                addBatchLocked(this.mAlarmBatches, batch2);
            }
        }
        if (alarmClock != null) {
            this.mNextAlarmClockMayChange = true;
            updateNextAlarmClockLocked();
        }
        rescheduleKernelAlarmsLocked();
    }

    void dumpImpl(PrintWriter pw) {
        synchronized (this.mLock) {
            int iu;
            int i;
            pw.println("Current Alarm Manager state:");
            long nowRTC = System.currentTimeMillis();
            long nowELAPSED = SystemClock.elapsedRealtime();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            pw.print("nowRTC=");
            pw.print(nowRTC);
            pw.print("=");
            pw.print(sdf.format(new Date(nowRTC)));
            pw.print(" nowELAPSED=");
            TimeUtils.formatDuration(nowELAPSED, pw);
            pw.println();
            if (!this.mInteractive) {
                pw.print("Time since non-interactive: ");
                TimeUtils.formatDuration(nowELAPSED - this.mNonInteractiveStartTime, pw);
                pw.println();
                pw.print("Max wakeup delay: ");
                TimeUtils.formatDuration(currentNonWakeupFuzzLocked(nowELAPSED), pw);
                pw.println();
                pw.print("Time since last dispatch: ");
                TimeUtils.formatDuration(nowELAPSED - this.mLastAlarmDeliveryTime, pw);
                pw.println();
                pw.print("Next non-wakeup delivery time: ");
                TimeUtils.formatDuration(nowELAPSED - this.mNextNonWakeupDeliveryTime, pw);
                pw.println();
            }
            long nextWakeupRTC = this.mNextWakeup + (nowRTC - nowELAPSED);
            long nextNonWakeupRTC = this.mNextNonWakeup + (nowRTC - nowELAPSED);
            pw.print("Next non-wakeup alarm: ");
            TimeUtils.formatDuration(this.mNextNonWakeup, nowELAPSED, pw);
            pw.print(" = ");
            pw.println(sdf.format(new Date(nextNonWakeupRTC)));
            pw.print("Next wakeup: ");
            TimeUtils.formatDuration(this.mNextWakeup, nowELAPSED, pw);
            pw.print(" = ");
            pw.println(sdf.format(new Date(nextWakeupRTC)));
            pw.print("Num time change events: ");
            pw.println(this.mNumTimeChanged);
            if (this.mAlarmBatches.size() > 0) {
                pw.println();
                pw.print("Pending alarm batches: ");
                pw.println(this.mAlarmBatches.size());
                Iterator i$ = this.mAlarmBatches.iterator();
                while (i$.hasNext()) {
                    Batch b = (Batch) i$.next();
                    pw.print(b);
                    pw.println(':');
                    dumpAlarmList(pw, b.alarms, "  ", nowELAPSED, nowRTC, sdf);
                }
            }
            pw.println();
            pw.print("Past-due non-wakeup alarms: ");
            if (this.mPendingNonWakeupAlarms.size() > 0) {
                pw.println(this.mPendingNonWakeupAlarms.size());
                dumpAlarmList(pw, this.mPendingNonWakeupAlarms, "  ", nowELAPSED, nowRTC, sdf);
            } else {
                pw.println("(none)");
            }
            pw.print("  Number of delayed alarms: ");
            pw.print(this.mNumDelayedAlarms);
            pw.print(", total delay time: ");
            TimeUtils.formatDuration(this.mTotalDelayTime, pw);
            pw.println();
            pw.print("  Max delay time: ");
            TimeUtils.formatDuration(this.mMaxDelayTime, pw);
            pw.print(", max non-interactive time: ");
            TimeUtils.formatDuration(this.mNonInteractiveTime, pw);
            pw.println();
            pw.println();
            pw.print("  Broadcast ref count: ");
            pw.println(this.mBroadcastRefCount);
            pw.println();
            if (this.mLog.dump(pw, "  Recent problems", "    ")) {
                pw.println();
            }
            Object topFilters = new FilterStats[10];
            Comparator<FilterStats> comparator = new C00023();
            int len = PRIO_TICK;
            for (iu = PRIO_TICK; iu < this.mBroadcastStats.size(); iu += TYPE_NONWAKEUP_MASK) {
                int ip;
                ArrayMap<String, BroadcastStats> uidStats = (ArrayMap) this.mBroadcastStats.valueAt(iu);
                for (ip = PRIO_TICK; ip < uidStats.size(); ip += TYPE_NONWAKEUP_MASK) {
                    int is;
                    BroadcastStats bs = (BroadcastStats) uidStats.valueAt(ip);
                    for (is = PRIO_TICK; is < bs.filterStats.size(); is += TYPE_NONWAKEUP_MASK) {
                        FilterStats fs = (FilterStats) bs.filterStats.valueAt(is);
                        int pos = len > 0 ? Arrays.binarySearch(topFilters, PRIO_TICK, len, fs, comparator) : PRIO_TICK;
                        if (pos < 0) {
                            pos = (-pos) - 1;
                        }
                        if (pos < topFilters.length) {
                            int copylen = (topFilters.length - pos) - 1;
                            if (copylen > 0) {
                                System.arraycopy(topFilters, pos, topFilters, pos + TYPE_NONWAKEUP_MASK, copylen);
                            }
                            topFilters[pos] = fs;
                            if (len < topFilters.length) {
                                len += TYPE_NONWAKEUP_MASK;
                            }
                        }
                    }
                }
            }
            if (len > 0) {
                pw.println("  Top Alarms:");
                for (i = PRIO_TICK; i < len; i += TYPE_NONWAKEUP_MASK) {
                    fs = topFilters[i];
                    pw.print("    ");
                    if (fs.nesting > 0) {
                        pw.print("*ACTIVE* ");
                    }
                    TimeUtils.formatDuration(fs.aggregateTime, pw);
                    pw.print(" running, ");
                    pw.print(fs.numWakeup);
                    pw.print(" wakeups, ");
                    pw.print(fs.count);
                    pw.print(" alarms: ");
                    UserHandle.formatUid(pw, fs.mBroadcastStats.mUid);
                    pw.print(":");
                    pw.print(fs.mBroadcastStats.mPackageName);
                    pw.println();
                    pw.print("      ");
                    pw.print(fs.mTag);
                    pw.println();
                }
            }
            pw.println(" ");
            pw.println("  Alarm Stats:");
            ArrayList<FilterStats> tmpFilters = new ArrayList();
            for (iu = PRIO_TICK; iu < this.mBroadcastStats.size(); iu += TYPE_NONWAKEUP_MASK) {
                uidStats = (ArrayMap) this.mBroadcastStats.valueAt(iu);
                for (ip = PRIO_TICK; ip < uidStats.size(); ip += TYPE_NONWAKEUP_MASK) {
                    bs = (BroadcastStats) uidStats.valueAt(ip);
                    pw.print("  ");
                    if (bs.nesting > 0) {
                        pw.print("*ACTIVE* ");
                    }
                    UserHandle.formatUid(pw, bs.mUid);
                    pw.print(":");
                    pw.print(bs.mPackageName);
                    pw.print(" ");
                    TimeUtils.formatDuration(bs.aggregateTime, pw);
                    pw.print(" running, ");
                    pw.print(bs.numWakeup);
                    pw.println(" wakeups:");
                    tmpFilters.clear();
                    for (is = PRIO_TICK; is < bs.filterStats.size(); is += TYPE_NONWAKEUP_MASK) {
                        tmpFilters.add(bs.filterStats.valueAt(is));
                    }
                    Collections.sort(tmpFilters, comparator);
                    for (i = PRIO_TICK; i < tmpFilters.size(); i += TYPE_NONWAKEUP_MASK) {
                        fs = (FilterStats) tmpFilters.get(i);
                        pw.print("    ");
                        if (fs.nesting > 0) {
                            pw.print("*ACTIVE* ");
                        }
                        TimeUtils.formatDuration(fs.aggregateTime, pw);
                        pw.print(" ");
                        pw.print(fs.numWakeup);
                        pw.print(" wakes ");
                        pw.print(fs.count);
                        pw.print(" alarms: ");
                        pw.print(fs.mTag);
                        pw.println();
                    }
                }
            }
        }
    }

    private void logBatchesLocked(SimpleDateFormat sdf) {
        ByteArrayOutputStream bs = new ByteArrayOutputStream(DumpState.DUMP_KEYSETS);
        PrintWriter pw = new PrintWriter(bs);
        long nowRTC = System.currentTimeMillis();
        long nowELAPSED = SystemClock.elapsedRealtime();
        int NZ = this.mAlarmBatches.size();
        for (int iz = PRIO_TICK; iz < NZ; iz += TYPE_NONWAKEUP_MASK) {
            Batch bz = (Batch) this.mAlarmBatches.get(iz);
            pw.append("Batch ");
            pw.print(iz);
            pw.append(": ");
            pw.println(bz);
            dumpAlarmList(pw, bz.alarms, "  ", nowELAPSED, nowRTC, sdf);
            pw.flush();
            Slog.v(TAG, bs.toString());
            bs.reset();
        }
    }

    private boolean validateConsistencyLocked() {
        return true;
    }

    private Batch findFirstWakeupBatchLocked() {
        int N = this.mAlarmBatches.size();
        for (int i = PRIO_TICK; i < N; i += TYPE_NONWAKEUP_MASK) {
            Batch b = (Batch) this.mAlarmBatches.get(i);
            if (b.hasWakeups()) {
                return b;
            }
        }
        return null;
    }

    private AlarmClockInfo getNextAlarmClockImpl(int userId) {
        AlarmClockInfo alarmClockInfo;
        synchronized (this.mLock) {
            alarmClockInfo = (AlarmClockInfo) this.mNextAlarmClockForUser.get(userId);
        }
        return alarmClockInfo;
    }

    private void updateNextAlarmClockLocked() {
        if (this.mNextAlarmClockMayChange) {
            int i;
            int userId;
            this.mNextAlarmClockMayChange = DEBUG_VALIDATE;
            SparseArray<AlarmClockInfo> nextForUser = this.mTmpSparseAlarmClockArray;
            nextForUser.clear();
            int N = this.mAlarmBatches.size();
            for (i = PRIO_TICK; i < N; i += TYPE_NONWAKEUP_MASK) {
                ArrayList<Alarm> alarms = ((Batch) this.mAlarmBatches.get(i)).alarms;
                int M = alarms.size();
                for (int j = PRIO_TICK; j < M; j += TYPE_NONWAKEUP_MASK) {
                    Alarm a = (Alarm) alarms.get(j);
                    if (a.alarmClock != null) {
                        userId = a.userId;
                        if (nextForUser.get(userId) == null) {
                            nextForUser.put(userId, a.alarmClock);
                        }
                    }
                }
            }
            int NN = nextForUser.size();
            for (i = PRIO_TICK; i < NN; i += TYPE_NONWAKEUP_MASK) {
                AlarmClockInfo newAlarm = (AlarmClockInfo) nextForUser.valueAt(i);
                userId = nextForUser.keyAt(i);
                if (!newAlarm.equals((AlarmClockInfo) this.mNextAlarmClockForUser.get(userId))) {
                    updateNextAlarmInfoForUserLocked(userId, newAlarm);
                }
            }
            for (i = this.mNextAlarmClockForUser.size() - 1; i >= 0; i--) {
                userId = this.mNextAlarmClockForUser.keyAt(i);
                if (nextForUser.get(userId) == null) {
                    updateNextAlarmInfoForUserLocked(userId, null);
                }
            }
        }
    }

    private void updateNextAlarmInfoForUserLocked(int userId, AlarmClockInfo alarmClock) {
        if (alarmClock != null) {
            this.mNextAlarmClockForUser.put(userId, alarmClock);
        } else {
            this.mNextAlarmClockForUser.remove(userId);
        }
        this.mPendingSendNextAlarmClockChangedForUser.put(userId, true);
        this.mHandler.removeMessages(ELAPSED_REALTIME_WAKEUP_MASK);
        this.mHandler.sendEmptyMessage(ELAPSED_REALTIME_WAKEUP_MASK);
    }

    private void sendNextAlarmClockChanged() {
        int N;
        int i;
        SparseArray<AlarmClockInfo> pendingUsers = this.mHandlerSparseAlarmClockArray;
        pendingUsers.clear();
        synchronized (this.mLock) {
            N = this.mPendingSendNextAlarmClockChangedForUser.size();
            for (i = PRIO_TICK; i < N; i += TYPE_NONWAKEUP_MASK) {
                int userId = this.mPendingSendNextAlarmClockChangedForUser.keyAt(i);
                pendingUsers.append(userId, this.mNextAlarmClockForUser.get(userId));
            }
            this.mPendingSendNextAlarmClockChangedForUser.clear();
        }
        N = pendingUsers.size();
        for (i = PRIO_TICK; i < N; i += TYPE_NONWAKEUP_MASK) {
            userId = pendingUsers.keyAt(i);
            System.putStringForUser(getContext().getContentResolver(), "next_alarm_formatted", formatNextAlarm(getContext(), (AlarmClockInfo) pendingUsers.valueAt(i), userId), userId);
            getContext().sendBroadcastAsUser(NEXT_ALARM_CLOCK_CHANGED_INTENT, new UserHandle(userId));
        }
    }

    private static String formatNextAlarm(Context context, AlarmClockInfo info, int userId) {
        return info == null ? "" : DateFormat.format(DateFormat.getBestDateTimePattern(Locale.getDefault(), DateFormat.is24HourFormat(context, userId) ? "EHm" : "Ehma"), info.getTriggerTime()).toString();
    }

    void rescheduleKernelAlarmsLocked() {
        long nextNonWakeup = 0;
        if (this.mAlarmBatches.size() > 0) {
            Batch firstWakeup = findFirstWakeupBatchLocked();
            Batch firstBatch = (Batch) this.mAlarmBatches.get(PRIO_TICK);
            if (firstWakeup != null) {
                this.mNextWakeup = firstWakeup.start;
                setLocked(RTC_MASK, firstWakeup.start);
            }
            if (firstBatch != firstWakeup) {
                nextNonWakeup = firstBatch.start;
            }
        }
        if (this.mPendingNonWakeupAlarms.size() > 0 && (nextNonWakeup == 0 || this.mNextNonWakeupDeliveryTime < nextNonWakeup)) {
            nextNonWakeup = this.mNextNonWakeupDeliveryTime;
        }
        if (nextNonWakeup != 0) {
            this.mNextNonWakeup = nextNonWakeup;
            setLocked(3, nextNonWakeup);
        }
    }

    boolean checkReleaseWakeLock() {
        if (this.mTriggeredUids.size() == 0 || this.mBlockedUids.size() == 0) {
            return DEBUG_VALIDATE;
        }
        for (int i = PRIO_TICK; i < this.mTriggeredUids.size(); i += TYPE_NONWAKEUP_MASK) {
            if (!this.mBlockedUids.contains(Integer.valueOf(((Integer) this.mTriggeredUids.get(i)).intValue()))) {
                return DEBUG_VALIDATE;
            }
        }
        return true;
    }

    private void removeLocked(PendingIntent operation) {
        boolean didRemove = DEBUG_VALIDATE;
        for (int i = this.mAlarmBatches.size() - 1; i >= 0; i--) {
            Batch b = (Batch) this.mAlarmBatches.get(i);
            didRemove |= b.remove(operation);
            if (b.size() == 0) {
                this.mAlarmBatches.remove(i);
            }
        }
        if (didRemove) {
            rebatchAllAlarmsLocked(true);
            rescheduleKernelAlarmsLocked();
            updateNextAlarmClockLocked();
        }
    }

    void removeLocked(String packageName) {
        boolean didRemove = DEBUG_VALIDATE;
        for (int i = this.mAlarmBatches.size() - 1; i >= 0; i--) {
            Batch b = (Batch) this.mAlarmBatches.get(i);
            didRemove |= b.remove(packageName);
            if (b.size() == 0) {
                this.mAlarmBatches.remove(i);
            }
        }
        if (didRemove) {
            rebatchAllAlarmsLocked(true);
            rescheduleKernelAlarmsLocked();
            updateNextAlarmClockLocked();
        }
    }

    void removeUserLocked(int userHandle) {
        boolean didRemove = DEBUG_VALIDATE;
        for (int i = this.mAlarmBatches.size() - 1; i >= 0; i--) {
            Batch b = (Batch) this.mAlarmBatches.get(i);
            didRemove |= b.remove(userHandle);
            if (b.size() == 0) {
                this.mAlarmBatches.remove(i);
            }
        }
        if (didRemove) {
            rebatchAllAlarmsLocked(true);
            rescheduleKernelAlarmsLocked();
            updateNextAlarmClockLocked();
        }
    }

    void interactiveStateChangedLocked(boolean interactive) {
        if (this.mInteractive != interactive) {
            this.mInteractive = interactive;
            long nowELAPSED = SystemClock.elapsedRealtime();
            if (interactive) {
                if (this.mPendingNonWakeupAlarms.size() > 0) {
                    long thisDelayTime = nowELAPSED - this.mStartCurrentDelayTime;
                    this.mTotalDelayTime += thisDelayTime;
                    if (this.mMaxDelayTime < thisDelayTime) {
                        this.mMaxDelayTime = thisDelayTime;
                    }
                    deliverAlarmsLocked(this.mPendingNonWakeupAlarms, nowELAPSED);
                    this.mPendingNonWakeupAlarms.clear();
                }
                if (this.mNonInteractiveStartTime > 0) {
                    long dur = nowELAPSED - this.mNonInteractiveStartTime;
                    if (dur > this.mNonInteractiveTime) {
                        this.mNonInteractiveTime = dur;
                        return;
                    }
                    return;
                }
                return;
            }
            this.mNonInteractiveStartTime = nowELAPSED;
        }
    }

    boolean lookForPackageLocked(String packageName) {
        for (int i = PRIO_TICK; i < this.mAlarmBatches.size(); i += TYPE_NONWAKEUP_MASK) {
            if (((Batch) this.mAlarmBatches.get(i)).hasPackage(packageName)) {
                return true;
            }
        }
        return DEBUG_VALIDATE;
    }

    private void setLocked(int type, long when) {
        if (this.mNativeData != 0) {
            long alarmSeconds;
            long alarmNanoseconds;
            if (when < 0) {
                alarmSeconds = 0;
                alarmNanoseconds = 0;
            } else {
                alarmSeconds = when / 1000;
                alarmNanoseconds = ((when % 1000) * 1000) * 1000;
            }
            set(this.mNativeData, type, alarmSeconds, alarmNanoseconds);
            return;
        }
        Message msg = Message.obtain();
        msg.what = TYPE_NONWAKEUP_MASK;
        this.mHandler.removeMessages(TYPE_NONWAKEUP_MASK);
        this.mHandler.sendMessageAtTime(msg, when);
    }

    private static final void dumpAlarmList(PrintWriter pw, ArrayList<Alarm> list, String prefix, String label, long nowRTC, long nowELAPSED, SimpleDateFormat sdf) {
        for (int i = list.size() - 1; i >= 0; i--) {
            Alarm a = (Alarm) list.get(i);
            pw.print(prefix);
            pw.print(label);
            pw.print(" #");
            pw.print(i);
            pw.print(": ");
            pw.println(a);
            a.dump(pw, prefix + "  ", nowRTC, nowELAPSED, sdf);
        }
    }

    private static final String labelForType(int type) {
        switch (type) {
            case PRIO_TICK /*0*/:
                return "RTC_WAKEUP";
            case TYPE_NONWAKEUP_MASK /*1*/:
                return "RTC";
            case RTC_MASK /*2*/:
                return "ELAPSED_WAKEUP";
            case C0569H.REPORT_LOSING_FOCUS /*3*/:
                return "ELAPSED";
            default:
                return "--unknown--";
        }
    }

    private static final void dumpAlarmList(PrintWriter pw, ArrayList<Alarm> list, String prefix, long nowELAPSED, long nowRTC, SimpleDateFormat sdf) {
        for (int i = list.size() - 1; i >= 0; i--) {
            Alarm a = (Alarm) list.get(i);
            String label = labelForType(a.type);
            pw.print(prefix);
            pw.print(label);
            pw.print(" #");
            pw.print(i);
            pw.print(": ");
            pw.println(a);
            a.dump(pw, prefix + "  ", nowRTC, nowELAPSED, sdf);
        }
    }

    boolean triggerAlarmsLocked(ArrayList<Alarm> triggerList, long nowELAPSED, long nowRTC) {
        boolean hasWakeup = DEBUG_VALIDATE;
        while (this.mAlarmBatches.size() > 0) {
            Batch batch = (Batch) this.mAlarmBatches.get(PRIO_TICK);
            if (batch.start > nowELAPSED) {
                break;
            }
            this.mAlarmBatches.remove(PRIO_TICK);
            int N = batch.size();
            for (int i = PRIO_TICK; i < N; i += TYPE_NONWAKEUP_MASK) {
                Alarm alarm = batch.get(i);
                alarm.count = TYPE_NONWAKEUP_MASK;
                triggerList.add(alarm);
                if (alarm.repeatInterval > 0) {
                    alarm.count = (int) (((long) alarm.count) + ((nowELAPSED - alarm.whenElapsed) / alarm.repeatInterval));
                    long delta = ((long) alarm.count) * alarm.repeatInterval;
                    long nextElapsed = alarm.whenElapsed + delta;
                    int i2 = alarm.type;
                    long j = nowELAPSED;
                    int i3 = i2;
                    long j2 = nextElapsed;
                    setImplLocked(i3, alarm.when + delta, j2, alarm.windowLength, maxTriggerTime(j, nextElapsed, alarm.repeatInterval), alarm.repeatInterval, alarm.operation, batch.standalone, true, alarm.workSource, alarm.alarmClock, alarm.userId);
                }
                if (alarm.wakeup) {
                    hasWakeup = true;
                }
                if (alarm.alarmClock != null) {
                    this.mNextAlarmClockMayChange = true;
                }
            }
        }
        this.mCurrentSeq += TYPE_NONWAKEUP_MASK;
        calculateDeliveryPriorities(triggerList);
        Collections.sort(triggerList, this.mAlarmDispatchComparator);
        return hasWakeup;
    }

    void recordWakeupAlarms(ArrayList<Batch> batches, long nowELAPSED, long nowRTC) {
        int numBatches = batches.size();
        int nextBatch = PRIO_TICK;
        while (nextBatch < numBatches) {
            Batch b = (Batch) batches.get(nextBatch);
            if (b.start <= nowELAPSED) {
                int numAlarms = b.alarms.size();
                for (int nextAlarm = PRIO_TICK; nextAlarm < numAlarms; nextAlarm += TYPE_NONWAKEUP_MASK) {
                    Alarm a = (Alarm) b.alarms.get(nextAlarm);
                    this.mRecentWakeups.add(new WakeupEvent(nowRTC, a.operation.getCreatorUid(), a.operation.getIntent().getAction()));
                }
                nextBatch += TYPE_NONWAKEUP_MASK;
            } else {
                return;
            }
        }
    }

    long currentNonWakeupFuzzLocked(long nowELAPSED) {
        long timeSinceOn = nowELAPSED - this.mNonInteractiveStartTime;
        if (timeSinceOn < 300000) {
            return 120000;
        }
        if (timeSinceOn < 1800000) {
            return 900000;
        }
        return 3600000;
    }

    boolean checkAllowNonWakeupDelayLocked(long nowELAPSED) {
        if (this.mInteractive || this.mLastAlarmDeliveryTime <= 0) {
            return DEBUG_VALIDATE;
        }
        if ((this.mPendingNonWakeupAlarms.size() <= 0 || this.mNextNonWakeupDeliveryTime >= nowELAPSED) && nowELAPSED - this.mLastAlarmDeliveryTime <= currentNonWakeupFuzzLocked(nowELAPSED)) {
            return true;
        }
        return DEBUG_VALIDATE;
    }

    void deliverAlarmsLocked(ArrayList<Alarm> triggerList, long nowELAPSED) {
        this.mLastAlarmDeliveryTime = nowELAPSED;
        int i = PRIO_TICK;
        while (i < triggerList.size()) {
            Alarm alarm = (Alarm) triggerList.get(i);
            try {
                alarm.operation.send(getContext(), PRIO_TICK, mBackgroundIntent.putExtra("android.intent.extra.ALARM_COUNT", alarm.count), this.mResultReceiver, this.mHandler);
                if (this.mBroadcastRefCount == 0 || !this.mWakeLock.isHeld()) {
                    setWakelockWorkSource(alarm.operation, alarm.workSource, alarm.type, alarm.tag, true);
                    this.mWakeLock.acquire();
                }
                InFlight inflight = new InFlight(this, alarm.operation, alarm.workSource, alarm.type, alarm.tag, alarm.uid);
                this.mInFlight.add(inflight);
                this.mBroadcastRefCount += TYPE_NONWAKEUP_MASK;
                this.mTriggeredUids.add(new Integer(alarm.uid));
                BroadcastStats bs = inflight.mBroadcastStats;
                bs.count += TYPE_NONWAKEUP_MASK;
                if (bs.nesting == 0) {
                    bs.nesting = TYPE_NONWAKEUP_MASK;
                    bs.startTime = nowELAPSED;
                } else {
                    bs.nesting += TYPE_NONWAKEUP_MASK;
                }
                FilterStats fs = inflight.mFilterStats;
                fs.count += TYPE_NONWAKEUP_MASK;
                if (fs.nesting == 0) {
                    fs.nesting = TYPE_NONWAKEUP_MASK;
                    fs.startTime = nowELAPSED;
                } else {
                    fs.nesting += TYPE_NONWAKEUP_MASK;
                }
                if (alarm.type == RTC_MASK || alarm.type == 0) {
                    bs.numWakeup += TYPE_NONWAKEUP_MASK;
                    fs.numWakeup += TYPE_NONWAKEUP_MASK;
                    if (alarm.workSource == null || alarm.workSource.size() <= 0) {
                        ActivityManagerNative.noteWakeupAlarm(alarm.operation, -1, null);
                        i += TYPE_NONWAKEUP_MASK;
                    } else {
                        for (int wi = PRIO_TICK; wi < alarm.workSource.size(); wi += TYPE_NONWAKEUP_MASK) {
                            ActivityManagerNative.noteWakeupAlarm(alarm.operation, alarm.workSource.get(wi), alarm.workSource.getName(wi));
                        }
                        i += TYPE_NONWAKEUP_MASK;
                    }
                } else {
                    i += TYPE_NONWAKEUP_MASK;
                }
            } catch (CanceledException e) {
                if (alarm.repeatInterval > 0) {
                    removeImpl(alarm.operation);
                }
            } catch (RuntimeException e2) {
                Slog.w(TAG, "Failure sending alarm.", e2);
            }
        }
    }

    private void filtQuickBootAlarms(ArrayList<Alarm> triggerList) {
        ArrayList<String> whiteList = new ArrayList();
        whiteList.add("android");
        whiteList.add("com.android.deskclock");
        for (int i = triggerList.size() - 1; i >= 0; i--) {
            Alarm alarm = (Alarm) triggerList.get(i);
            if (!whiteList.contains(alarm.operation.getTargetPackage())) {
                triggerList.remove(i);
                Slog.v(TAG, "ignore -> " + alarm.operation.getTargetPackage());
            }
        }
    }

    void setWakelockWorkSource(PendingIntent pi, WorkSource ws, int type, String tag, boolean first) {
        try {
            boolean unimportant = pi == this.mTimeTickSender ? true : DEBUG_VALIDATE;
            this.mWakeLock.setUnimportantForLogging(unimportant);
            if (first || this.mLastWakeLockUnimportantForLogging) {
                this.mWakeLock.setHistoryTag(tag);
            } else {
                this.mWakeLock.setHistoryTag(null);
            }
            this.mLastWakeLockUnimportantForLogging = unimportant;
            if (ws != null) {
                this.mWakeLock.setWorkSource(ws);
                return;
            }
            int uid = ActivityManagerNative.getDefault().getUidForIntentSender(pi.getTarget());
            if (uid >= 0) {
                this.mWakeLock.setWorkSource(new WorkSource(uid));
            } else {
                this.mWakeLock.setWorkSource(null);
            }
        } catch (Exception e) {
        }
    }

    private final BroadcastStats getStatsLocked(PendingIntent pi) {
        String pkg = pi.getCreatorPackage();
        int uid = pi.getCreatorUid();
        ArrayMap<String, BroadcastStats> uidStats = (ArrayMap) this.mBroadcastStats.get(uid);
        if (uidStats == null) {
            uidStats = new ArrayMap();
            this.mBroadcastStats.put(uid, uidStats);
        }
        BroadcastStats bs = (BroadcastStats) uidStats.get(pkg);
        if (bs != null) {
            return bs;
        }
        bs = new BroadcastStats(uid, pkg);
        uidStats.put(pkg, bs);
        return bs;
    }
}
