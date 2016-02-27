package android.widget;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.drawable.Drawable;
import android.hardware.SensorManager;
import android.os.Handler;
import android.os.Process;
import android.text.format.DateUtils;
import android.text.format.Time;
import android.util.AttributeSet;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.MeasureSpec;
import android.view.WindowManager.LayoutParams;
import android.widget.RemoteViews.RemoteView;
import com.android.internal.R;
import java.util.TimeZone;

@RemoteView
public class AnalogClock extends View {
    private boolean mAttached;
    private Time mCalendar;
    private boolean mChanged;
    private Drawable mDial;
    private int mDialHeight;
    private int mDialWidth;
    private final Handler mHandler;
    private float mHour;
    private Drawable mHourHand;
    private final BroadcastReceiver mIntentReceiver;
    private Drawable mMinuteHand;
    private float mMinutes;

    /* renamed from: android.widget.AnalogClock.1 */
    class C09411 extends BroadcastReceiver {
        C09411() {
        }

        public void onReceive(Context context, Intent intent) {
            if (intent.getAction().equals(Intent.ACTION_TIMEZONE_CHANGED)) {
                AnalogClock.this.mCalendar = new Time(TimeZone.getTimeZone(intent.getStringExtra("time-zone")).getID());
            }
            AnalogClock.this.onTimeChanged();
            AnalogClock.this.invalidate();
        }
    }

    public AnalogClock(Context context) {
        this(context, null);
    }

    public AnalogClock(Context context, AttributeSet attrs) {
        this(context, attrs, 0);
    }

    public AnalogClock(Context context, AttributeSet attrs, int defStyleAttr) {
        this(context, attrs, defStyleAttr, 0);
    }

    public AnalogClock(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
        this.mHandler = new Handler();
        this.mIntentReceiver = new C09411();
        Resources r = context.getResources();
        TypedArray a = context.obtainStyledAttributes(attrs, R.styleable.AnalogClock, defStyleAttr, defStyleRes);
        this.mDial = a.getDrawable(0);
        if (this.mDial == null) {
            this.mDial = context.getDrawable(17302141);
        }
        this.mHourHand = a.getDrawable(1);
        if (this.mHourHand == null) {
            this.mHourHand = context.getDrawable(17302142);
        }
        this.mMinuteHand = a.getDrawable(2);
        if (this.mMinuteHand == null) {
            this.mMinuteHand = context.getDrawable(17302143);
        }
        this.mCalendar = new Time();
        this.mDialWidth = this.mDial.getIntrinsicWidth();
        this.mDialHeight = this.mDial.getIntrinsicHeight();
    }

    protected void onAttachedToWindow() {
        super.onAttachedToWindow();
        if (!this.mAttached) {
            this.mAttached = true;
            IntentFilter filter = new IntentFilter();
            filter.addAction(Intent.ACTION_TIME_TICK);
            filter.addAction(Intent.ACTION_TIME_CHANGED);
            filter.addAction(Intent.ACTION_TIMEZONE_CHANGED);
            getContext().registerReceiverAsUser(this.mIntentReceiver, Process.myUserHandle(), filter, null, this.mHandler);
        }
        this.mCalendar = new Time();
        onTimeChanged();
    }

    protected void onDetachedFromWindow() {
        super.onDetachedFromWindow();
        if (this.mAttached) {
            getContext().unregisterReceiver(this.mIntentReceiver);
            this.mAttached = false;
        }
    }

    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        int widthMode = MeasureSpec.getMode(widthMeasureSpec);
        int widthSize = MeasureSpec.getSize(widthMeasureSpec);
        int heightMode = MeasureSpec.getMode(heightMeasureSpec);
        int heightSize = MeasureSpec.getSize(heightMeasureSpec);
        float hScale = LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
        float vScale = LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
        if (widthMode != 0 && widthSize < this.mDialWidth) {
            hScale = ((float) widthSize) / ((float) this.mDialWidth);
        }
        if (heightMode != 0 && heightSize < this.mDialHeight) {
            vScale = ((float) heightSize) / ((float) this.mDialHeight);
        }
        float scale = Math.min(hScale, vScale);
        setMeasuredDimension(View.resolveSizeAndState((int) (((float) this.mDialWidth) * scale), widthMeasureSpec, 0), View.resolveSizeAndState((int) (((float) this.mDialHeight) * scale), heightMeasureSpec, 0));
    }

    protected void onSizeChanged(int w, int h, int oldw, int oldh) {
        super.onSizeChanged(w, h, oldw, oldh);
        this.mChanged = true;
    }

    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        boolean changed = this.mChanged;
        if (changed) {
            this.mChanged = false;
        }
        int availableWidth = this.mRight - this.mLeft;
        int availableHeight = this.mBottom - this.mTop;
        int x = availableWidth / 2;
        int y = availableHeight / 2;
        Drawable dial = this.mDial;
        int w = dial.getIntrinsicWidth();
        int h = dial.getIntrinsicHeight();
        boolean scaled = false;
        if (availableWidth < w || availableHeight < h) {
            scaled = true;
            float scale = Math.min(((float) availableWidth) / ((float) w), ((float) availableHeight) / ((float) h));
            canvas.save();
            canvas.scale(scale, scale, (float) x, (float) y);
        }
        if (changed) {
            dial.setBounds(x - (w / 2), y - (h / 2), (w / 2) + x, (h / 2) + y);
        }
        dial.draw(canvas);
        canvas.save();
        canvas.rotate((this.mHour / 12.0f) * 360.0f, (float) x, (float) y);
        Drawable hourHand = this.mHourHand;
        if (changed) {
            w = hourHand.getIntrinsicWidth();
            h = hourHand.getIntrinsicHeight();
            hourHand.setBounds(x - (w / 2), y - (h / 2), (w / 2) + x, (h / 2) + y);
        }
        hourHand.draw(canvas);
        canvas.restore();
        canvas.save();
        canvas.rotate((this.mMinutes / SensorManager.MAGNETIC_FIELD_EARTH_MAX) * 360.0f, (float) x, (float) y);
        Drawable minuteHand = this.mMinuteHand;
        if (changed) {
            w = minuteHand.getIntrinsicWidth();
            h = minuteHand.getIntrinsicHeight();
            minuteHand.setBounds(x - (w / 2), y - (h / 2), (w / 2) + x, (h / 2) + y);
        }
        minuteHand.draw(canvas);
        canvas.restore();
        if (scaled) {
            canvas.restore();
        }
    }

    private void onTimeChanged() {
        this.mCalendar.setToNow();
        int hour = this.mCalendar.hour;
        this.mMinutes = ((float) this.mCalendar.minute) + (((float) this.mCalendar.second) / SensorManager.MAGNETIC_FIELD_EARTH_MAX);
        this.mHour = ((float) hour) + (this.mMinutes / SensorManager.MAGNETIC_FIELD_EARTH_MAX);
        this.mChanged = true;
        updateContentDescription(this.mCalendar);
    }

    private void updateContentDescription(Time time) {
        setContentDescription(DateUtils.formatDateTime(this.mContext, time.toMillis(false), KeyEvent.KEYCODE_MEDIA_EJECT));
    }
}
