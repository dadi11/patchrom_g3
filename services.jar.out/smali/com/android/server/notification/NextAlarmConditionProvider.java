package com.android.server.notification;

import android.app.AlarmManager.AlarmClockInfo;
import android.content.ComponentName;
import android.content.Context;
import android.net.Uri;
import android.net.Uri.Builder;
import android.service.notification.Condition;
import android.service.notification.ConditionProviderService;
import android.service.notification.IConditionProvider;
import android.text.TextUtils;
import android.util.ArraySet;
import android.util.Log;
import android.util.Slog;
import android.util.TimeUtils;
import com.android.server.notification.NextAlarmTracker.Callback;
import com.android.server.notification.NotificationManagerService.DumpFilter;
import java.io.PrintWriter;
import java.util.Iterator;

public class NextAlarmConditionProvider extends ConditionProviderService {
    private static final long BAD_CONDITION = -1;
    public static final ComponentName COMPONENT;
    private static final boolean DEBUG;
    private static final long HOURS = 3600000;
    private static final long MINUTES = 60000;
    private static final long SECONDS = 1000;
    private static final String TAG = "NextAlarmConditions";
    private boolean mConnected;
    private final Context mContext;
    private long mLookaheadThreshold;
    private boolean mRequesting;
    private final ArraySet<Uri> mSubscriptions;
    private final NextAlarmTracker mTracker;
    private final Callback mTrackerCallback;

    /* renamed from: com.android.server.notification.NextAlarmConditionProvider.1 */
    class C04141 implements Callback {
        C04141() {
        }

        public void onEvaluate(AlarmClockInfo nextAlarm, long wakeupTime, boolean booted) {
            NextAlarmConditionProvider.this.onEvaluate(nextAlarm, wakeupTime, booted);
        }
    }

    static {
        DEBUG = Log.isLoggable(TAG, 3);
        COMPONENT = new ComponentName("android", NextAlarmConditionProvider.class.getName());
    }

    public NextAlarmConditionProvider(NextAlarmTracker tracker) {
        this.mContext = this;
        this.mSubscriptions = new ArraySet();
        this.mTrackerCallback = new C04141();
        if (DEBUG) {
            Slog.d(TAG, "new NextAlarmConditionProvider()");
        }
        this.mTracker = tracker;
    }

    public void dump(PrintWriter pw, DumpFilter filter) {
        pw.println("    NextAlarmConditionProvider:");
        pw.print("      mConnected=");
        pw.println(this.mConnected);
        pw.print("      mLookaheadThreshold=");
        pw.print(this.mLookaheadThreshold);
        pw.print(" (");
        TimeUtils.formatDuration(this.mLookaheadThreshold, pw);
        pw.println(")");
        pw.print("      mSubscriptions=");
        pw.println(this.mSubscriptions);
        pw.print("      mRequesting=");
        pw.println(this.mRequesting);
    }

    public void onConnected() {
        if (DEBUG) {
            Slog.d(TAG, "onConnected");
        }
        this.mLookaheadThreshold = ((long) PropConfig.getInt(this.mContext, "nextalarm.condition.lookahead", 17694849)) * HOURS;
        this.mConnected = true;
        this.mTracker.addCallback(this.mTrackerCallback);
    }

    public void onDestroy() {
        super.onDestroy();
        if (DEBUG) {
            Slog.d(TAG, "onDestroy");
        }
        this.mTracker.removeCallback(this.mTrackerCallback);
        this.mConnected = DEBUG;
    }

    public void onRequestConditions(int relevance) {
        if (DEBUG) {
            Slog.d(TAG, "onRequestConditions relevance=" + relevance);
        }
        if (this.mConnected) {
            this.mRequesting = (relevance & 1) != 0 ? true : DEBUG;
            this.mTracker.evaluate();
        }
    }

    public void onSubscribe(Uri conditionId) {
        if (DEBUG) {
            Slog.d(TAG, "onSubscribe " + conditionId);
        }
        if (tryParseNextAlarmCondition(conditionId) == BAD_CONDITION) {
            notifyCondition(conditionId, null, 0, "badCondition");
            return;
        }
        this.mSubscriptions.add(conditionId);
        this.mTracker.evaluate();
    }

    public void onUnsubscribe(Uri conditionId) {
        if (DEBUG) {
            Slog.d(TAG, "onUnsubscribe " + conditionId);
        }
        this.mSubscriptions.remove(conditionId);
    }

    public void attachBase(Context base) {
        attachBaseContext(base);
    }

    public IConditionProvider asInterface() {
        return (IConditionProvider) onBind(null);
    }

    private boolean isWithinLookaheadThreshold(AlarmClockInfo alarm) {
        if (alarm == null) {
            return DEBUG;
        }
        long delta = NextAlarmTracker.getEarlyTriggerTime(alarm) - System.currentTimeMillis();
        if (delta <= 0) {
            return DEBUG;
        }
        if (this.mLookaheadThreshold <= 0 || delta < this.mLookaheadThreshold) {
            return true;
        }
        return DEBUG;
    }

    private void notifyCondition(Uri id, AlarmClockInfo alarm, int state, String reason) {
        String formattedAlarm = alarm == null ? "" : this.mTracker.formatAlarm(alarm);
        if (DEBUG) {
            Slog.d(TAG, "notifyCondition " + Condition.stateToString(state) + " alarm=" + formattedAlarm + " reason=" + reason);
        }
        notifyCondition(new Condition(id, this.mContext.getString(17041060, new Object[]{formattedAlarm}), this.mContext.getString(17041061), formattedAlarm, 0, state, 1));
    }

    private Uri newConditionId(AlarmClockInfo nextAlarm) {
        return new Builder().scheme("condition").authority("android").appendPath("next_alarm").appendPath(Integer.toString(this.mTracker.getCurrentUserId())).appendPath(Long.toString(nextAlarm.getTriggerTime())).build();
    }

    private long tryParseNextAlarmCondition(Uri conditionId) {
        return (conditionId != null && conditionId.getScheme().equals("condition") && conditionId.getAuthority().equals("android") && conditionId.getPathSegments().size() == 3 && ((String) conditionId.getPathSegments().get(0)).equals("next_alarm") && ((String) conditionId.getPathSegments().get(1)).equals(Integer.toString(this.mTracker.getCurrentUserId()))) ? tryParseLong((String) conditionId.getPathSegments().get(2), BAD_CONDITION) : BAD_CONDITION;
    }

    private static long tryParseLong(String value, long defValue) {
        if (!TextUtils.isEmpty(value)) {
            try {
                defValue = Long.valueOf(value).longValue();
            } catch (NumberFormatException e) {
            }
        }
        return defValue;
    }

    private void onEvaluate(AlarmClockInfo nextAlarm, long wakeupTime, boolean booted) {
        boolean withinThreshold = isWithinLookaheadThreshold(nextAlarm);
        long nextAlarmTime = nextAlarm != null ? nextAlarm.getTriggerTime() : 0;
        if (DEBUG) {
            Slog.d(TAG, "onEvaluate mSubscriptions=" + this.mSubscriptions + " nextAlarmTime=" + this.mTracker.formatAlarmDebug(nextAlarmTime) + " nextAlarmWakeup=" + this.mTracker.formatAlarmDebug(wakeupTime) + " withinThreshold=" + withinThreshold + " booted=" + booted);
        }
        ArraySet<Uri> conditions = this.mSubscriptions;
        if (this.mRequesting && nextAlarm != null && withinThreshold) {
            Uri id = newConditionId(nextAlarm);
            if (!conditions.contains(id)) {
                ArraySet<Uri> conditions2 = new ArraySet(conditions);
                conditions2.add(id);
                conditions = conditions2;
            }
        }
        Iterator i$ = conditions.iterator();
        while (i$.hasNext()) {
            Uri conditionId = (Uri) i$.next();
            long time = tryParseNextAlarmCondition(conditionId);
            if (time == BAD_CONDITION) {
                notifyCondition(conditionId, nextAlarm, 0, "badCondition");
            } else if (booted) {
                if (time != nextAlarmTime) {
                    notifyCondition(conditionId, nextAlarm, 0, "changed");
                } else if (withinThreshold) {
                    notifyCondition(conditionId, nextAlarm, 1, "within");
                } else {
                    notifyCondition(conditionId, nextAlarm, 0, "!within");
                }
            } else if (this.mSubscriptions.contains(conditionId)) {
                notifyCondition(conditionId, nextAlarm, 2, "!booted");
            }
        }
    }
}
