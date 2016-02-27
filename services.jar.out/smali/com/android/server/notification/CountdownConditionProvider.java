package com.android.server.notification;

import android.app.AlarmManager;
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
import android.text.format.DateUtils;
import android.util.Log;
import android.util.Slog;
import com.android.server.notification.NotificationManagerService.DumpFilter;
import java.io.PrintWriter;
import java.util.Date;

public class CountdownConditionProvider extends ConditionProviderService {
    private static final String ACTION;
    public static final ComponentName COMPONENT;
    private static final boolean DEBUG;
    private static final String EXTRA_CONDITION_ID = "condition_id";
    private static final int REQUEST_CODE = 100;
    private static final String TAG = "CountdownConditions";
    private boolean mConnected;
    private final Context mContext;
    private final Receiver mReceiver;
    private long mTime;

    private final class Receiver extends BroadcastReceiver {
        private Receiver() {
        }

        public void onReceive(Context context, Intent intent) {
            if (CountdownConditionProvider.ACTION.equals(intent.getAction())) {
                Uri conditionId = (Uri) intent.getParcelableExtra(CountdownConditionProvider.EXTRA_CONDITION_ID);
                long time = ZenModeConfig.tryParseCountdownConditionId(conditionId);
                if (CountdownConditionProvider.DEBUG) {
                    Slog.d(CountdownConditionProvider.TAG, "Countdown condition fired: " + conditionId);
                }
                if (time > 0) {
                    CountdownConditionProvider.this.notifyCondition(CountdownConditionProvider.newCondition(time, 0));
                }
            }
        }
    }

    static {
        DEBUG = Log.isLoggable(TAG, 3);
        COMPONENT = new ComponentName("android", CountdownConditionProvider.class.getName());
        ACTION = CountdownConditionProvider.class.getName();
    }

    public CountdownConditionProvider() {
        this.mContext = this;
        this.mReceiver = new Receiver();
        if (DEBUG) {
            Slog.d(TAG, "new CountdownConditionProvider()");
        }
    }

    public void dump(PrintWriter pw, DumpFilter filter) {
        pw.println("    CountdownConditionProvider:");
        pw.print("      mConnected=");
        pw.println(this.mConnected);
        pw.print("      mTime=");
        pw.println(this.mTime);
    }

    public void onConnected() {
        if (DEBUG) {
            Slog.d(TAG, "onConnected");
        }
        this.mContext.registerReceiver(this.mReceiver, new IntentFilter(ACTION));
        this.mConnected = true;
    }

    public void onDestroy() {
        super.onDestroy();
        if (DEBUG) {
            Slog.d(TAG, "onDestroy");
        }
        if (this.mConnected) {
            this.mContext.unregisterReceiver(this.mReceiver);
        }
        this.mConnected = DEBUG;
    }

    public void onRequestConditions(int relevance) {
    }

    public void onSubscribe(Uri conditionId) {
        if (DEBUG) {
            Slog.d(TAG, "onSubscribe " + conditionId);
        }
        this.mTime = ZenModeConfig.tryParseCountdownConditionId(conditionId);
        AlarmManager alarms = (AlarmManager) this.mContext.getSystemService("alarm");
        PendingIntent pendingIntent = PendingIntent.getBroadcast(this.mContext, REQUEST_CODE, new Intent(ACTION).putExtra(EXTRA_CONDITION_ID, conditionId).setFlags(1073741824), 134217728);
        alarms.cancel(pendingIntent);
        if (this.mTime > 0) {
            long now = System.currentTimeMillis();
            CharSequence span = DateUtils.getRelativeTimeSpanString(this.mTime, now, 60000);
            if (this.mTime <= now) {
                notifyCondition(newCondition(this.mTime, 0));
            } else {
                alarms.setExact(0, this.mTime, pendingIntent);
            }
            if (DEBUG) {
                String str = TAG;
                String str2 = "%s %s for %s, %s in the future (%s), now=%s";
                Object[] objArr = new Object[6];
                objArr[0] = this.mTime <= now ? "Not scheduling" : "Scheduling";
                objArr[1] = ACTION;
                objArr[2] = ts(this.mTime);
                objArr[3] = Long.valueOf(this.mTime - now);
                objArr[4] = span;
                objArr[5] = ts(now);
                Slog.d(str, String.format(str2, objArr));
            }
        }
    }

    public void onUnsubscribe(Uri conditionId) {
    }

    private static final Condition newCondition(long time, int state) {
        return new Condition(ZenModeConfig.toCountdownConditionId(time), "", "", "", 0, state, 1);
    }

    public static String tryParseDescription(Uri conditionUri) {
        long time = ZenModeConfig.tryParseCountdownConditionId(conditionUri);
        if (time == 0) {
            return null;
        }
        CharSequence span = DateUtils.getRelativeTimeSpanString(time, System.currentTimeMillis(), 60000);
        return String.format("Scheduled for %s, %s in the future (%s), now=%s", new Object[]{ts(time), Long.valueOf(time - now), span, ts(now)});
    }

    private static String ts(long time) {
        return new Date(time) + " (" + time + ")";
    }

    public void attachBase(Context base) {
        attachBaseContext(base);
    }

    public IConditionProvider asInterface() {
        return (IConditionProvider) onBind(null);
    }
}
