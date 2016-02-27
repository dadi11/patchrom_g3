package android.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.os.Handler;
import android.os.Message;
import android.os.SystemClock;
import android.text.format.DateUtils;
import android.util.AttributeSet;
import android.util.Log;
import android.view.RemotableViewMethod;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.widget.RemoteViews.RemoteView;
import com.android.internal.R;
import java.util.Formatter;
import java.util.IllegalFormatException;
import java.util.Locale;

@RemoteView
public class Chronometer extends TextView {
    private static final String TAG = "Chronometer";
    private static final int TICK_WHAT = 2;
    private long mBase;
    private String mFormat;
    private StringBuilder mFormatBuilder;
    private Formatter mFormatter;
    private Object[] mFormatterArgs;
    private Locale mFormatterLocale;
    private Handler mHandler;
    private boolean mLogged;
    private OnChronometerTickListener mOnChronometerTickListener;
    private StringBuilder mRecycle;
    private boolean mRunning;
    private boolean mStarted;
    private boolean mVisible;

    /* renamed from: android.widget.Chronometer.1 */
    class C09491 extends Handler {
        C09491() {
        }

        public void handleMessage(Message m) {
            if (Chronometer.this.mRunning) {
                Chronometer.this.updateText(SystemClock.elapsedRealtime());
                Chronometer.this.dispatchChronometerTick();
                sendMessageDelayed(Message.obtain((Handler) this, (int) Chronometer.TICK_WHAT), 1000);
            }
        }
    }

    public interface OnChronometerTickListener {
        void onChronometerTick(Chronometer chronometer);
    }

    public Chronometer(Context context) {
        this(context, null, 0);
    }

    public Chronometer(Context context, AttributeSet attrs) {
        this(context, attrs, 0);
    }

    public Chronometer(Context context, AttributeSet attrs, int defStyleAttr) {
        this(context, attrs, defStyleAttr, 0);
    }

    public Chronometer(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
        this.mFormatterArgs = new Object[1];
        this.mRecycle = new StringBuilder(8);
        this.mHandler = new C09491();
        TypedArray a = context.obtainStyledAttributes(attrs, R.styleable.Chronometer, defStyleAttr, defStyleRes);
        setFormat(a.getString(0));
        a.recycle();
        init();
    }

    private void init() {
        this.mBase = SystemClock.elapsedRealtime();
        updateText(this.mBase);
    }

    @RemotableViewMethod
    public void setBase(long base) {
        this.mBase = base;
        dispatchChronometerTick();
        updateText(SystemClock.elapsedRealtime());
    }

    public long getBase() {
        return this.mBase;
    }

    @RemotableViewMethod
    public void setFormat(String format) {
        this.mFormat = format;
        if (format != null && this.mFormatBuilder == null) {
            this.mFormatBuilder = new StringBuilder(format.length() * TICK_WHAT);
        }
    }

    public String getFormat() {
        return this.mFormat;
    }

    public void setOnChronometerTickListener(OnChronometerTickListener listener) {
        this.mOnChronometerTickListener = listener;
    }

    public OnChronometerTickListener getOnChronometerTickListener() {
        return this.mOnChronometerTickListener;
    }

    public void start() {
        this.mStarted = true;
        updateRunning();
    }

    public void stop() {
        this.mStarted = false;
        updateRunning();
    }

    @RemotableViewMethod
    public void setStarted(boolean started) {
        this.mStarted = started;
        updateRunning();
    }

    protected void onDetachedFromWindow() {
        super.onDetachedFromWindow();
        this.mVisible = false;
        updateRunning();
    }

    protected void onWindowVisibilityChanged(int visibility) {
        super.onWindowVisibilityChanged(visibility);
        this.mVisible = visibility == 0;
        updateRunning();
    }

    private synchronized void updateText(long now) {
        String text = DateUtils.formatElapsedTime(this.mRecycle, (now - this.mBase) / 1000);
        if (this.mFormat != null) {
            Locale loc = Locale.getDefault();
            if (this.mFormatter == null || !loc.equals(this.mFormatterLocale)) {
                this.mFormatterLocale = loc;
                this.mFormatter = new Formatter(this.mFormatBuilder, loc);
            }
            this.mFormatBuilder.setLength(0);
            this.mFormatterArgs[0] = text;
            try {
                this.mFormatter.format(this.mFormat, this.mFormatterArgs);
                text = this.mFormatBuilder.toString();
            } catch (IllegalFormatException e) {
                if (!this.mLogged) {
                    Log.w(TAG, "Illegal format string: " + this.mFormat);
                    this.mLogged = true;
                }
            }
        }
        setText((CharSequence) text);
    }

    private void updateRunning() {
        boolean running = this.mVisible && this.mStarted;
        if (running != this.mRunning) {
            if (running) {
                updateText(SystemClock.elapsedRealtime());
                dispatchChronometerTick();
                this.mHandler.sendMessageDelayed(Message.obtain(this.mHandler, (int) TICK_WHAT), 1000);
            } else {
                this.mHandler.removeMessages(TICK_WHAT);
            }
            this.mRunning = running;
        }
    }

    void dispatchChronometerTick() {
        if (this.mOnChronometerTickListener != null) {
            this.mOnChronometerTickListener.onChronometerTick(this);
        }
    }

    public void onInitializeAccessibilityEvent(AccessibilityEvent event) {
        super.onInitializeAccessibilityEvent(event);
        event.setClassName(Chronometer.class.getName());
    }

    public void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo info) {
        super.onInitializeAccessibilityNodeInfo(info);
        info.setClassName(Chronometer.class.getName());
    }
}
