package com.android.server.notification;

import android.app.ActivityManager;
import android.app.AlarmManager;
import android.app.AlarmManager.AlarmClockInfo;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Handler;
import android.os.Message;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.os.UserHandle;
import android.text.format.DateFormat;
import android.util.Log;
import android.util.Slog;
import android.util.TimeUtils;
import com.android.server.notification.NotificationManagerService.DumpFilter;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Locale;

public class NextAlarmTracker {
    private static final String ACTION_TRIGGER = "NextAlarmTracker.trigger";
    private static final boolean DEBUG;
    private static final long EARLY = 5000;
    private static final String EXTRA_TRIGGER = "trigger";
    private static final long MINUTES = 60000;
    private static final long NEXT_ALARM_UPDATE_DELAY = 1000;
    private static final int REQUEST_CODE = 100;
    private static final long SECONDS = 1000;
    private static final String TAG = "NextAlarmTracker";
    private static final long WAIT_AFTER_BOOT = 20000;
    private static final long WAIT_AFTER_INIT = 300000;
    private AlarmManager mAlarmManager;
    private long mBootCompleted;
    private final ArrayList<Callback> mCallbacks;
    private final Context mContext;
    private int mCurrentUserId;
    private final C0416H mHandler;
    private long mInit;
    private final BroadcastReceiver mReceiver;
    private boolean mRegistered;
    private long mScheduledAlarmTime;
    private WakeLock mWakeLock;

    public interface Callback {
        void onEvaluate(AlarmClockInfo alarmClockInfo, long j, boolean z);
    }

    /* renamed from: com.android.server.notification.NextAlarmTracker.1 */
    class C04151 extends BroadcastReceiver {
        C04151() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if (NextAlarmTracker.DEBUG) {
                Slog.d(NextAlarmTracker.TAG, "onReceive " + action);
            }
            long delay = 0;
            if (action.equals("android.app.action.NEXT_ALARM_CLOCK_CHANGED")) {
                delay = NextAlarmTracker.SECONDS;
                if (NextAlarmTracker.DEBUG) {
                    Slog.d(NextAlarmTracker.TAG, String.format("  next alarm for user %s: %s", new Object[]{Integer.valueOf(NextAlarmTracker.this.mCurrentUserId), NextAlarmTracker.this.formatAlarmDebug(NextAlarmTracker.this.mAlarmManager.getNextAlarmClock(NextAlarmTracker.this.mCurrentUserId))}));
                }
            } else if (action.equals("android.intent.action.BOOT_COMPLETED")) {
                NextAlarmTracker.this.mBootCompleted = System.currentTimeMillis();
            }
            NextAlarmTracker.this.mHandler.postEvaluate(delay);
            NextAlarmTracker.this.mWakeLock.acquire(NextAlarmTracker.EARLY + delay);
        }
    }

    /* renamed from: com.android.server.notification.NextAlarmTracker.H */
    private class C0416H extends Handler {
        private static final int MSG_EVALUATE = 1;

        private C0416H() {
        }

        public void postEvaluate(long delay) {
            removeMessages(MSG_EVALUATE);
            sendEmptyMessageDelayed(MSG_EVALUATE, delay);
        }

        public void handleMessage(Message msg) {
            if (msg.what == MSG_EVALUATE) {
                NextAlarmTracker.this.handleEvaluate();
            }
        }
    }

    static {
        DEBUG = Log.isLoggable(TAG, 3);
    }

    public NextAlarmTracker(Context context) {
        this.mHandler = new C0416H();
        this.mCallbacks = new ArrayList();
        this.mReceiver = new C04151();
        this.mContext = context;
    }

    public void dump(PrintWriter pw, DumpFilter filter) {
        pw.println("    NextAlarmTracker:");
        pw.print("      len(mCallbacks)=");
        pw.println(this.mCallbacks.size());
        pw.print("      mRegistered=");
        pw.println(this.mRegistered);
        pw.print("      mInit=");
        pw.println(this.mInit);
        pw.print("      mBootCompleted=");
        pw.println(this.mBootCompleted);
        pw.print("      mCurrentUserId=");
        pw.println(this.mCurrentUserId);
        pw.print("      mScheduledAlarmTime=");
        pw.println(formatAlarmDebug(this.mScheduledAlarmTime));
        pw.print("      mWakeLock=");
        pw.println(this.mWakeLock);
    }

    public void addCallback(Callback callback) {
        this.mCallbacks.add(callback);
    }

    public void removeCallback(Callback callback) {
        this.mCallbacks.remove(callback);
    }

    public int getCurrentUserId() {
        return this.mCurrentUserId;
    }

    public AlarmClockInfo getNextAlarm() {
        return this.mAlarmManager.getNextAlarmClock(this.mCurrentUserId);
    }

    public void onUserSwitched() {
        reset();
    }

    public void init() {
        this.mAlarmManager = (AlarmManager) this.mContext.getSystemService("alarm");
        this.mWakeLock = ((PowerManager) this.mContext.getSystemService("power")).newWakeLock(1, TAG);
        this.mInit = System.currentTimeMillis();
        reset();
    }

    public void reset() {
        if (this.mRegistered) {
            this.mContext.unregisterReceiver(this.mReceiver);
        }
        this.mCurrentUserId = ActivityManager.getCurrentUser();
        IntentFilter filter = new IntentFilter();
        filter.addAction("android.app.action.NEXT_ALARM_CLOCK_CHANGED");
        filter.addAction(ACTION_TRIGGER);
        filter.addAction("android.intent.action.TIME_SET");
        filter.addAction("android.intent.action.TIMEZONE_CHANGED");
        filter.addAction("android.intent.action.BOOT_COMPLETED");
        this.mContext.registerReceiverAsUser(this.mReceiver, new UserHandle(this.mCurrentUserId), filter, null, null);
        this.mRegistered = true;
        evaluate();
    }

    public void destroy() {
        if (this.mRegistered) {
            this.mContext.unregisterReceiver(this.mReceiver);
            this.mRegistered = DEBUG;
        }
    }

    public void evaluate() {
        this.mHandler.postEvaluate(0);
    }

    private void fireEvaluate(AlarmClockInfo nextAlarm, long wakeupTime, boolean booted) {
        Iterator i$ = this.mCallbacks.iterator();
        while (i$.hasNext()) {
            ((Callback) i$.next()).onEvaluate(nextAlarm, wakeupTime, booted);
        }
    }

    private void handleEvaluate() {
        AlarmClockInfo nextAlarm = this.mAlarmManager.getNextAlarmClock(this.mCurrentUserId);
        long triggerTime = getEarlyTriggerTime(nextAlarm);
        long now = System.currentTimeMillis();
        boolean alarmUpcoming = triggerTime > now ? true : DEBUG;
        boolean booted = isDoneWaitingAfterBoot(now);
        if (DEBUG) {
            Slog.d(TAG, "handleEvaluate nextAlarm=" + formatAlarmDebug(triggerTime) + " alarmUpcoming=" + alarmUpcoming + " booted=" + booted);
        }
        fireEvaluate(nextAlarm, triggerTime, booted);
        if (!booted) {
            if (this.mBootCompleted > 0) {
                now = this.mBootCompleted;
            }
            rescheduleAlarm(now + WAIT_AFTER_BOOT);
        } else if (alarmUpcoming) {
            rescheduleAlarm(triggerTime);
        }
    }

    public static long getEarlyTriggerTime(AlarmClockInfo alarm) {
        return alarm != null ? alarm.getTriggerTime() - EARLY : 0;
    }

    private boolean isDoneWaitingAfterBoot(long time) {
        if (this.mBootCompleted > 0) {
            if (time - this.mBootCompleted > WAIT_AFTER_BOOT) {
                return true;
            }
            return DEBUG;
        } else if (this.mInit <= 0 || time - this.mInit > WAIT_AFTER_INIT) {
            return true;
        } else {
            return DEBUG;
        }
    }

    public static String formatDuration(long millis) {
        StringBuilder sb = new StringBuilder();
        TimeUtils.formatDuration(millis, sb);
        return sb.toString();
    }

    public String formatAlarm(AlarmClockInfo alarm) {
        return alarm != null ? formatAlarm(alarm.getTriggerTime()) : null;
    }

    private String formatAlarm(long time) {
        return formatAlarm(time, "Hm", "hma");
    }

    private String formatAlarm(long time, String skeleton24, String skeleton12) {
        String skeleton;
        if (DateFormat.is24HourFormat(this.mContext)) {
            skeleton = skeleton24;
        } else {
            skeleton = skeleton12;
        }
        return DateFormat.format(DateFormat.getBestDateTimePattern(Locale.getDefault(), skeleton), time).toString();
    }

    public String formatAlarmDebug(AlarmClockInfo alarm) {
        return formatAlarmDebug(alarm != null ? alarm.getTriggerTime() : 0);
    }

    public String formatAlarmDebug(long time) {
        if (time <= 0) {
            return Long.toString(time);
        }
        return String.format("%s (%s)", new Object[]{Long.valueOf(time), formatAlarm(time, "Hms", "hmsa")});
    }

    private void rescheduleAlarm(long time) {
        if (DEBUG) {
            Slog.d(TAG, "rescheduleAlarm " + time);
        }
        AlarmManager alarms = (AlarmManager) this.mContext.getSystemService("alarm");
        PendingIntent pendingIntent = PendingIntent.getBroadcast(this.mContext, REQUEST_CODE, new Intent(ACTION_TRIGGER).addFlags(268435456).putExtra(EXTRA_TRIGGER, time), 134217728);
        alarms.cancel(pendingIntent);
        this.mScheduledAlarmTime = time;
        if (time > 0) {
            if (DEBUG) {
                Slog.d(TAG, String.format("Scheduling alarm for %s (in %s)", new Object[]{formatAlarmDebug(time), formatDuration(time - System.currentTimeMillis())}));
            }
            alarms.setExact(0, time, pendingIntent);
        }
    }
}
