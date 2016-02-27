package com.android.server.notification;

import android.app.AlarmManager;
import android.app.AlarmManager.AlarmClockInfo;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.Uri;
import android.service.notification.Condition;
import android.service.notification.ConditionProviderService;
import android.service.notification.IConditionProvider;
import android.service.notification.ZenModeConfig;
import android.service.notification.ZenModeConfig.DowntimeInfo;
import android.text.format.DateFormat;
import android.util.ArraySet;
import android.util.Log;
import android.util.Slog;
import android.util.TimeUtils;
import com.android.server.notification.NextAlarmTracker.Callback;
import com.android.server.notification.NotificationManagerService.DumpFilter;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Locale;
import java.util.Objects;
import java.util.TimeZone;

public class DowntimeConditionProvider extends ConditionProviderService {
    public static final ComponentName COMPONENT;
    private static final boolean DEBUG;
    private static final String ENTER_ACTION = "DowntimeConditions.enter";
    private static final int ENTER_CODE = 100;
    private static final String EXIT_ACTION = "DowntimeConditions.exit";
    private static final int EXIT_CODE = 101;
    private static final String EXTRA_TIME = "time";
    private static final long HOURS = 3600000;
    private static final long MINUTES = 60000;
    private static final long SECONDS = 1000;
    private static final String TAG = "DowntimeConditions";
    private final DowntimeCalendar mCalendar;
    private boolean mConditionClearing;
    private final ConditionProviders mConditionProviders;
    private ZenModeConfig mConfig;
    private boolean mConnected;
    private final Context mContext;
    private boolean mDowntimed;
    private final FiredAlarms mFiredAlarms;
    private long mLookaheadThreshold;
    private BroadcastReceiver mReceiver;
    private boolean mRequesting;
    private final ArraySet<Uri> mSubscriptions;
    private final NextAlarmTracker mTracker;
    private final Callback mTrackerCallback;
    private final ZenModeHelper.Callback mZenCallback;
    private final ZenModeHelper mZenModeHelper;

    /* renamed from: com.android.server.notification.DowntimeConditionProvider.1 */
    class C04101 extends BroadcastReceiver {
        C04101() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            long now = System.currentTimeMillis();
            if (DowntimeConditionProvider.ENTER_ACTION.equals(action) || DowntimeConditionProvider.EXIT_ACTION.equals(action)) {
                long schTime = intent.getLongExtra(DowntimeConditionProvider.EXTRA_TIME, 0);
                if (DowntimeConditionProvider.DEBUG) {
                    Slog.d(DowntimeConditionProvider.TAG, String.format("%s scheduled for %s, fired at %s, delta=%s", new Object[]{action, DowntimeConditionProvider.ts(schTime), DowntimeConditionProvider.ts(now), Long.valueOf(now - schTime)}));
                }
                if (DowntimeConditionProvider.ENTER_ACTION.equals(action)) {
                    DowntimeConditionProvider.this.evaluateAutotrigger();
                } else {
                    DowntimeConditionProvider.this.mDowntimed = DowntimeConditionProvider.DEBUG;
                }
                DowntimeConditionProvider.this.mFiredAlarms.clear();
            } else if ("android.intent.action.TIMEZONE_CHANGED".equals(action)) {
                if (DowntimeConditionProvider.DEBUG) {
                    Slog.d(DowntimeConditionProvider.TAG, "timezone changed to " + TimeZone.getDefault());
                }
                DowntimeConditionProvider.this.mCalendar.setTimeZone(TimeZone.getDefault());
                DowntimeConditionProvider.this.mFiredAlarms.clear();
            } else if ("android.intent.action.TIME_SET".equals(action)) {
                if (DowntimeConditionProvider.DEBUG) {
                    Slog.d(DowntimeConditionProvider.TAG, "time changed to " + now);
                }
                DowntimeConditionProvider.this.mFiredAlarms.clear();
            } else if (DowntimeConditionProvider.DEBUG) {
                Slog.d(DowntimeConditionProvider.TAG, action + " fired at " + now);
            }
            DowntimeConditionProvider.this.evaluateSubscriptions();
            DowntimeConditionProvider.this.updateAlarms();
        }
    }

    /* renamed from: com.android.server.notification.DowntimeConditionProvider.2 */
    class C04112 implements Callback {
        C04112() {
        }

        public void onEvaluate(AlarmClockInfo nextAlarm, long wakeupTime, boolean booted) {
            DowntimeConditionProvider.this.onEvaluateNextAlarm(nextAlarm, wakeupTime, booted);
        }
    }

    /* renamed from: com.android.server.notification.DowntimeConditionProvider.3 */
    class C04123 extends ZenModeHelper.Callback {
        C04123() {
        }

        void onZenModeChanged() {
            if (DowntimeConditionProvider.this.mConditionClearing && DowntimeConditionProvider.this.isZenOff()) {
                DowntimeConditionProvider.this.evaluateAutotrigger();
            }
            DowntimeConditionProvider.this.mConditionClearing = DowntimeConditionProvider.DEBUG;
            DowntimeConditionProvider.this.evaluateSubscriptions();
        }
    }

    private class FiredAlarms {
        private final ArraySet<Long> mFiredAlarms;

        private FiredAlarms() {
            this.mFiredAlarms = new ArraySet();
        }

        public String toString() {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < this.mFiredAlarms.size(); i++) {
                if (i > 0) {
                    sb.append(',');
                }
                sb.append(DowntimeConditionProvider.this.mTracker.formatAlarmDebug(((Long) this.mFiredAlarms.valueAt(i)).longValue()));
            }
            return sb.toString();
        }

        public void add(long firedAlarm) {
            this.mFiredAlarms.add(Long.valueOf(firedAlarm));
        }

        public void clear() {
            this.mFiredAlarms.clear();
        }

        public boolean findBefore(long time) {
            for (int i = 0; i < this.mFiredAlarms.size(); i++) {
                if (((Long) this.mFiredAlarms.valueAt(i)).longValue() < time) {
                    return true;
                }
            }
            return DowntimeConditionProvider.DEBUG;
        }
    }

    static {
        DEBUG = Log.isLoggable(TAG, 3);
        COMPONENT = new ComponentName("android", DowntimeConditionProvider.class.getName());
    }

    public DowntimeConditionProvider(ConditionProviders conditionProviders, NextAlarmTracker tracker, ZenModeHelper zenModeHelper) {
        this.mContext = this;
        this.mCalendar = new DowntimeCalendar();
        this.mFiredAlarms = new FiredAlarms();
        this.mSubscriptions = new ArraySet();
        this.mReceiver = new C04101();
        this.mTrackerCallback = new C04112();
        this.mZenCallback = new C04123();
        if (DEBUG) {
            Slog.d(TAG, "new DowntimeConditionProvider()");
        }
        this.mConditionProviders = conditionProviders;
        this.mTracker = tracker;
        this.mZenModeHelper = zenModeHelper;
    }

    public void dump(PrintWriter pw, DumpFilter filter) {
        pw.println("    DowntimeConditionProvider:");
        pw.print("      mConnected=");
        pw.println(this.mConnected);
        pw.print("      mSubscriptions=");
        pw.println(this.mSubscriptions);
        pw.print("      mLookaheadThreshold=");
        pw.print(this.mLookaheadThreshold);
        pw.print(" (");
        TimeUtils.formatDuration(this.mLookaheadThreshold, pw);
        pw.println(")");
        pw.print("      mCalendar=");
        pw.println(this.mCalendar);
        pw.print("      mFiredAlarms=");
        pw.println(this.mFiredAlarms);
        pw.print("      mDowntimed=");
        pw.println(this.mDowntimed);
        pw.print("      mConditionClearing=");
        pw.println(this.mConditionClearing);
        pw.print("      mRequesting=");
        pw.println(this.mRequesting);
    }

    public void attachBase(Context base) {
        attachBaseContext(base);
    }

    public IConditionProvider asInterface() {
        return (IConditionProvider) onBind(null);
    }

    public void onConnected() {
        if (DEBUG) {
            Slog.d(TAG, "onConnected");
        }
        this.mConnected = true;
        this.mLookaheadThreshold = ((long) PropConfig.getInt(this.mContext, "downtime.condition.lookahead", 17694850)) * HOURS;
        IntentFilter filter = new IntentFilter();
        filter.addAction(ENTER_ACTION);
        filter.addAction(EXIT_ACTION);
        filter.addAction("android.intent.action.TIME_SET");
        filter.addAction("android.intent.action.TIMEZONE_CHANGED");
        this.mContext.registerReceiver(this.mReceiver, filter);
        this.mTracker.addCallback(this.mTrackerCallback);
        this.mZenModeHelper.addCallback(this.mZenCallback);
        init();
    }

    public void onDestroy() {
        if (DEBUG) {
            Slog.d(TAG, "onDestroy");
        }
        this.mTracker.removeCallback(this.mTrackerCallback);
        this.mZenModeHelper.removeCallback(this.mZenCallback);
        this.mConnected = DEBUG;
    }

    public void onRequestConditions(int relevance) {
        if (DEBUG) {
            Slog.d(TAG, "onRequestConditions relevance=" + relevance);
        }
        if (this.mConnected) {
            this.mRequesting = (relevance & 1) != 0 ? true : DEBUG;
            evaluateSubscriptions();
        }
    }

    public void onSubscribe(Uri conditionId) {
        if (DEBUG) {
            Slog.d(TAG, "onSubscribe conditionId=" + conditionId);
        }
        DowntimeInfo downtime = ZenModeConfig.tryParseDowntimeConditionId(conditionId);
        if (downtime != null) {
            this.mFiredAlarms.clear();
            this.mSubscriptions.add(conditionId);
            notifyCondition(downtime);
        }
    }

    private boolean shouldShowCondition() {
        long now = System.currentTimeMillis();
        if (DEBUG) {
            boolean z;
            String str = TAG;
            StringBuilder append = new StringBuilder().append("shouldShowCondition now=").append(this.mCalendar.isInDowntime(now)).append(" lookahead=");
            if (this.mCalendar.nextDowntimeStart(now) <= this.mLookaheadThreshold + now) {
                z = true;
            } else {
                z = DEBUG;
            }
            Slog.d(str, append.append(z).toString());
        }
        if (this.mCalendar.isInDowntime(now) || this.mCalendar.nextDowntimeStart(now) <= this.mLookaheadThreshold + now) {
            return true;
        }
        return DEBUG;
    }

    private void notifyCondition(DowntimeInfo downtime) {
        if (this.mConfig == null) {
            notifyCondition(createCondition(downtime, 2));
        } else if (!downtime.equals(this.mConfig.toDowntimeInfo())) {
            notifyCondition(createCondition(downtime, 0));
        } else if (!shouldShowCondition()) {
            notifyCondition(createCondition(downtime, 0));
        } else if (isZenNone() && this.mFiredAlarms.findBefore(System.currentTimeMillis())) {
            notifyCondition(createCondition(downtime, 0));
        } else {
            notifyCondition(createCondition(downtime, 1));
        }
    }

    private boolean isZenNone() {
        return this.mZenModeHelper.getZenMode() == 2 ? true : DEBUG;
    }

    private boolean isZenOff() {
        return this.mZenModeHelper.getZenMode() == 0 ? true : DEBUG;
    }

    private void evaluateSubscriptions() {
        ArraySet<Uri> conditions = this.mSubscriptions;
        if (this.mConfig != null && this.mRequesting && shouldShowCondition()) {
            Uri id = ZenModeConfig.toDowntimeConditionId(this.mConfig.toDowntimeInfo());
            if (!conditions.contains(id)) {
                ArraySet<Uri> conditions2 = new ArraySet(conditions);
                conditions2.add(id);
                conditions = conditions2;
            }
        }
        Iterator i$ = conditions.iterator();
        while (i$.hasNext()) {
            DowntimeInfo downtime = ZenModeConfig.tryParseDowntimeConditionId((Uri) i$.next());
            if (downtime != null) {
                notifyCondition(downtime);
            }
        }
    }

    public void onUnsubscribe(Uri conditionId) {
        boolean current = this.mSubscriptions.contains(conditionId);
        if (DEBUG) {
            Slog.d(TAG, "onUnsubscribe conditionId=" + conditionId + " current=" + current);
        }
        this.mSubscriptions.remove(conditionId);
        this.mFiredAlarms.clear();
    }

    public void setConfig(ZenModeConfig config) {
        if (!Objects.equals(this.mConfig, config)) {
            boolean downtimeChanged;
            if (this.mConfig == null || config == null || !this.mConfig.toDowntimeInfo().equals(config.toDowntimeInfo())) {
                downtimeChanged = true;
            } else {
                downtimeChanged = DEBUG;
            }
            this.mConfig = config;
            if (DEBUG) {
                Slog.d(TAG, "setConfig downtimeChanged=" + downtimeChanged);
            }
            if (this.mConnected && downtimeChanged) {
                this.mDowntimed = DEBUG;
                init();
            }
            if (this.mConfig != null && this.mConfig.exitCondition != null && ZenModeConfig.isValidDowntimeConditionId(this.mConfig.exitCondition.id)) {
                this.mDowntimed = true;
            }
        }
    }

    public void onManualConditionClearing() {
        this.mConditionClearing = true;
    }

    private Condition createCondition(DowntimeInfo downtime, int state) {
        if (downtime == null) {
            return null;
        }
        Uri id = ZenModeConfig.toDowntimeConditionId(downtime);
        String skeleton = DateFormat.is24HourFormat(this.mContext) ? "Hm" : "hma";
        Locale locale = Locale.getDefault();
        String pattern = DateFormat.getBestDateTimePattern(locale, skeleton);
        long now = System.currentTimeMillis();
        long endTime = this.mCalendar.getNextTime(now, downtime.endHour, downtime.endMinute);
        if (isZenNone()) {
            AlarmClockInfo nextAlarm = this.mTracker.getNextAlarm();
            long nextAlarmTime = nextAlarm != null ? nextAlarm.getTriggerTime() : 0;
            if (nextAlarmTime > now && nextAlarmTime < endTime) {
                endTime = nextAlarmTime;
            }
        }
        return new Condition(id, this.mContext.getString(17041055, new Object[]{new SimpleDateFormat(pattern, locale).format(new Date(endTime))}), this.mContext.getString(17041056), new SimpleDateFormat(pattern, locale).format(new Date(endTime)), 0, state, 1);
    }

    private void init() {
        this.mCalendar.setDowntimeInfo(this.mConfig != null ? this.mConfig.toDowntimeInfo() : null);
        evaluateSubscriptions();
        updateAlarms();
        evaluateAutotrigger();
    }

    private void updateAlarms() {
        if (this.mConfig != null) {
            updateAlarm(ENTER_ACTION, ENTER_CODE, this.mConfig.sleepStartHour, this.mConfig.sleepStartMinute);
            updateAlarm(EXIT_ACTION, EXIT_CODE, this.mConfig.sleepEndHour, this.mConfig.sleepEndMinute);
        }
    }

    private void updateAlarm(String action, int requestCode, int hr, int min) {
        AlarmManager alarms = (AlarmManager) this.mContext.getSystemService("alarm");
        long time = this.mCalendar.getNextTime(System.currentTimeMillis(), hr, min);
        PendingIntent pendingIntent = PendingIntent.getBroadcast(this.mContext, requestCode, new Intent(action).addFlags(268435456).putExtra(EXTRA_TIME, time), 134217728);
        alarms.cancel(pendingIntent);
        if (this.mConfig.sleepMode != null) {
            if (DEBUG) {
                Slog.d(TAG, String.format("Scheduling %s for %s, in %s, now=%s", new Object[]{action, ts(time), NextAlarmTracker.formatDuration(time - now), ts(now)}));
            }
            alarms.setExact(0, time, pendingIntent);
        }
    }

    private static String ts(long time) {
        return new Date(time) + " (" + time + ")";
    }

    private void onEvaluateNextAlarm(AlarmClockInfo nextAlarm, long wakeupTime, boolean booted) {
        if (booted) {
            if (DEBUG) {
                Slog.d(TAG, "onEvaluateNextAlarm " + this.mTracker.formatAlarmDebug(nextAlarm));
            }
            if (nextAlarm != null && wakeupTime > 0 && System.currentTimeMillis() > wakeupTime) {
                if (DEBUG) {
                    Slog.d(TAG, "Alarm fired: " + this.mTracker.formatAlarmDebug(wakeupTime));
                }
                this.mFiredAlarms.add(wakeupTime);
            }
            evaluateSubscriptions();
        }
    }

    private void evaluateAutotrigger() {
        String skipReason = null;
        if (this.mConfig == null) {
            skipReason = "no config";
        } else if (this.mDowntimed) {
            skipReason = "already downtimed";
        } else if (this.mZenModeHelper.getZenMode() != 0) {
            skipReason = "already in zen";
        } else if (!this.mCalendar.isInDowntime(System.currentTimeMillis())) {
            skipReason = "not in downtime";
        }
        if (skipReason != null) {
            ZenLog.traceDowntimeAutotrigger("Autotrigger skipped: " + skipReason);
            return;
        }
        int i;
        ZenLog.traceDowntimeAutotrigger("Autotrigger fired");
        ZenModeHelper zenModeHelper = this.mZenModeHelper;
        if (this.mConfig.sleepNone) {
            i = 2;
        } else {
            i = 1;
        }
        zenModeHelper.setZenMode(i, "downtime");
        this.mConditionProviders.setZenModeCondition(createCondition(this.mConfig.toDowntimeInfo(), 1), "downtime");
    }
}
