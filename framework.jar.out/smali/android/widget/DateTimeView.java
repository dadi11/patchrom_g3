package android.widget;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.database.ContentObserver;
import android.net.LinkQualityInfo;
import android.net.ProxyInfo;
import android.os.Handler;
import android.provider.Settings.System;
import android.text.format.Time;
import android.util.AttributeSet;
import android.view.RemotableViewMethod;
import android.widget.RemoteViews.RemoteView;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

@RemoteView
public class DateTimeView extends TextView {
    private static final int SHOW_MONTH_DAY_YEAR = 1;
    private static final int SHOW_TIME = 0;
    private static final String TAG = "DateTimeView";
    private static final long TWELVE_HOURS_IN_MINUTES = 720;
    private static final long TWENTY_FOUR_HOURS_IN_MILLIS = 86400000;
    private static final ThreadLocal<ReceiverInfo> sReceiverInfo;
    int mLastDisplay;
    DateFormat mLastFormat;
    Date mTime;
    long mTimeMillis;
    private long mUpdateTimeMillis;

    private static class ReceiverInfo {
        private final ArrayList<DateTimeView> mAttachedViews;
        private final ContentObserver mObserver;
        private final BroadcastReceiver mReceiver;

        /* renamed from: android.widget.DateTimeView.ReceiverInfo.1 */
        class C09611 extends BroadcastReceiver {
            C09611() {
            }

            public void onReceive(Context context, Intent intent) {
                if (!Intent.ACTION_TIME_TICK.equals(intent.getAction()) || System.currentTimeMillis() >= ReceiverInfo.this.getSoonestUpdateTime()) {
                    ReceiverInfo.this.updateAll();
                }
            }
        }

        /* renamed from: android.widget.DateTimeView.ReceiverInfo.2 */
        class C09622 extends ContentObserver {
            C09622(Handler x0) {
                super(x0);
            }

            public void onChange(boolean selfChange) {
                ReceiverInfo.this.updateAll();
            }
        }

        private ReceiverInfo() {
            this.mAttachedViews = new ArrayList();
            this.mReceiver = new C09611();
            this.mObserver = new C09622(new Handler());
        }

        public void addView(DateTimeView v) {
            boolean register = this.mAttachedViews.isEmpty();
            this.mAttachedViews.add(v);
            if (register) {
                register(v.getContext().getApplicationContext());
            }
        }

        public void removeView(DateTimeView v) {
            this.mAttachedViews.remove(v);
            if (this.mAttachedViews.isEmpty()) {
                unregister(v.getContext().getApplicationContext());
            }
        }

        void updateAll() {
            int count = this.mAttachedViews.size();
            for (int i = DateTimeView.SHOW_TIME; i < count; i += DateTimeView.SHOW_MONTH_DAY_YEAR) {
                ((DateTimeView) this.mAttachedViews.get(i)).clearFormatAndUpdate();
            }
        }

        long getSoonestUpdateTime() {
            long result = LinkQualityInfo.UNKNOWN_LONG;
            int count = this.mAttachedViews.size();
            for (int i = DateTimeView.SHOW_TIME; i < count; i += DateTimeView.SHOW_MONTH_DAY_YEAR) {
                long time = ((DateTimeView) this.mAttachedViews.get(i)).mUpdateTimeMillis;
                if (time < result) {
                    result = time;
                }
            }
            return result;
        }

        void register(Context context) {
            IntentFilter filter = new IntentFilter();
            filter.addAction(Intent.ACTION_TIME_TICK);
            filter.addAction(Intent.ACTION_TIME_CHANGED);
            filter.addAction(Intent.ACTION_CONFIGURATION_CHANGED);
            filter.addAction(Intent.ACTION_TIMEZONE_CHANGED);
            context.registerReceiver(this.mReceiver, filter);
            context.getContentResolver().registerContentObserver(System.getUriFor("date_format"), true, this.mObserver);
        }

        void unregister(Context context) {
            context.unregisterReceiver(this.mReceiver);
            context.getContentResolver().unregisterContentObserver(this.mObserver);
        }
    }

    static {
        sReceiverInfo = new ThreadLocal();
    }

    public DateTimeView(Context context) {
        super(context);
        this.mLastDisplay = -1;
    }

    public DateTimeView(Context context, AttributeSet attrs) {
        super(context, attrs);
        this.mLastDisplay = -1;
    }

    protected void onAttachedToWindow() {
        super.onAttachedToWindow();
        ReceiverInfo ri = (ReceiverInfo) sReceiverInfo.get();
        if (ri == null) {
            ri = new ReceiverInfo();
            sReceiverInfo.set(ri);
        }
        ri.addView(this);
    }

    protected void onDetachedFromWindow() {
        super.onDetachedFromWindow();
        ReceiverInfo ri = (ReceiverInfo) sReceiverInfo.get();
        if (ri != null) {
            ri.removeView(this);
        }
    }

    @RemotableViewMethod
    public void setTime(long time) {
        Time t = new Time();
        t.set(time);
        t.second = SHOW_TIME;
        this.mTimeMillis = t.toMillis(false);
        this.mTime = new Date(t.year - 1900, t.month, t.monthDay, t.hour, t.minute, SHOW_TIME);
        update();
    }

    void update() {
        if (this.mTime != null) {
            int display;
            DateFormat format;
            long start = System.nanoTime();
            Date time = this.mTime;
            Time t = new Time();
            t.set(this.mTimeMillis);
            t.second = SHOW_TIME;
            t.hour -= 12;
            long twelveHoursBefore = t.toMillis(false);
            t.hour += 12;
            long twelveHoursAfter = t.toMillis(false);
            t.hour = SHOW_TIME;
            t.minute = SHOW_TIME;
            long midnightBefore = t.toMillis(false);
            t.monthDay += SHOW_MONTH_DAY_YEAR;
            long midnightAfter = t.toMillis(false);
            t.set(System.currentTimeMillis());
            t.second = SHOW_TIME;
            long nowMillis = t.normalize(false);
            if ((nowMillis < midnightBefore || nowMillis >= midnightAfter) && (nowMillis < twelveHoursBefore || nowMillis >= twelveHoursAfter)) {
                display = SHOW_MONTH_DAY_YEAR;
            } else {
                display = SHOW_TIME;
            }
            int i = this.mLastDisplay;
            if (display != r0 || this.mLastFormat == null) {
                switch (display) {
                    case SHOW_TIME /*0*/:
                        format = getTimeFormat();
                        break;
                    case SHOW_MONTH_DAY_YEAR /*1*/:
                        format = getDateFormat();
                        break;
                    default:
                        throw new RuntimeException("unknown display value: " + display);
                }
                this.mLastFormat = format;
            } else {
                format = this.mLastFormat;
            }
            setText((CharSequence) format.format(this.mTime));
            if (display == 0) {
                if (twelveHoursAfter <= midnightAfter) {
                    twelveHoursAfter = midnightAfter;
                }
                this.mUpdateTimeMillis = twelveHoursAfter;
            } else {
                if (this.mTimeMillis < nowMillis) {
                    this.mUpdateTimeMillis = 0;
                } else {
                    if (twelveHoursBefore >= midnightBefore) {
                        twelveHoursBefore = midnightBefore;
                    }
                    this.mUpdateTimeMillis = twelveHoursBefore;
                }
            }
            long finish = System.nanoTime();
        }
    }

    private DateFormat getTimeFormat() {
        return android.text.format.DateFormat.getTimeFormat(getContext());
    }

    private DateFormat getDateFormat() {
        String format = System.getString(getContext().getContentResolver(), "date_format");
        if (format == null || ProxyInfo.LOCAL_EXCL_LIST.equals(format)) {
            return DateFormat.getDateInstance(3);
        }
        try {
            return new SimpleDateFormat(format);
        } catch (IllegalArgumentException e) {
            return DateFormat.getDateInstance(3);
        }
    }

    void clearFormatAndUpdate() {
        this.mLastFormat = null;
        update();
    }
}
