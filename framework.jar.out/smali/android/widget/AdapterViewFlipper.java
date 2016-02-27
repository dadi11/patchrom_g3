package android.widget;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.res.TypedArray;
import android.os.Handler;
import android.os.Message;
import android.os.Process;
import android.util.AttributeSet;
import android.view.RemotableViewMethod;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.widget.RemoteViews.RemoteView;
import com.android.internal.R;

@RemoteView
public class AdapterViewFlipper extends AdapterViewAnimator {
    private static final int DEFAULT_INTERVAL = 10000;
    private static final boolean LOGD = false;
    private static final String TAG = "ViewFlipper";
    private final int FLIP_MSG;
    private boolean mAdvancedByHost;
    private boolean mAutoStart;
    private int mFlipInterval;
    private final Handler mHandler;
    private final BroadcastReceiver mReceiver;
    private boolean mRunning;
    private boolean mStarted;
    private boolean mUserPresent;
    private boolean mVisible;

    /* renamed from: android.widget.AdapterViewFlipper.1 */
    class C09391 extends BroadcastReceiver {
        C09391() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if (Intent.ACTION_SCREEN_OFF.equals(action)) {
                AdapterViewFlipper.this.mUserPresent = AdapterViewFlipper.LOGD;
                AdapterViewFlipper.this.updateRunning();
            } else if (Intent.ACTION_USER_PRESENT.equals(action)) {
                AdapterViewFlipper.this.mUserPresent = true;
                AdapterViewFlipper.this.updateRunning(AdapterViewFlipper.LOGD);
            }
        }
    }

    /* renamed from: android.widget.AdapterViewFlipper.2 */
    class C09402 extends Handler {
        C09402() {
        }

        public void handleMessage(Message msg) {
            if (msg.what == 1 && AdapterViewFlipper.this.mRunning) {
                AdapterViewFlipper.this.showNext();
            }
        }
    }

    public AdapterViewFlipper(Context context) {
        super(context);
        this.mFlipInterval = DEFAULT_INTERVAL;
        this.mAutoStart = LOGD;
        this.mRunning = LOGD;
        this.mStarted = LOGD;
        this.mVisible = LOGD;
        this.mUserPresent = true;
        this.mAdvancedByHost = LOGD;
        this.mReceiver = new C09391();
        this.FLIP_MSG = 1;
        this.mHandler = new C09402();
    }

    public AdapterViewFlipper(Context context, AttributeSet attrs) {
        this(context, attrs, 0);
    }

    public AdapterViewFlipper(Context context, AttributeSet attrs, int defStyleAttr) {
        this(context, attrs, defStyleAttr, 0);
    }

    public AdapterViewFlipper(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
        this.mFlipInterval = DEFAULT_INTERVAL;
        this.mAutoStart = LOGD;
        this.mRunning = LOGD;
        this.mStarted = LOGD;
        this.mVisible = LOGD;
        this.mUserPresent = true;
        this.mAdvancedByHost = LOGD;
        this.mReceiver = new C09391();
        this.FLIP_MSG = 1;
        this.mHandler = new C09402();
        TypedArray a = context.obtainStyledAttributes(attrs, R.styleable.AdapterViewFlipper, defStyleAttr, defStyleRes);
        this.mFlipInterval = a.getInt(0, DEFAULT_INTERVAL);
        this.mAutoStart = a.getBoolean(1, LOGD);
        this.mLoopViews = true;
        a.recycle();
    }

    protected void onAttachedToWindow() {
        super.onAttachedToWindow();
        IntentFilter filter = new IntentFilter();
        filter.addAction(Intent.ACTION_SCREEN_OFF);
        filter.addAction(Intent.ACTION_USER_PRESENT);
        getContext().registerReceiverAsUser(this.mReceiver, Process.myUserHandle(), filter, null, this.mHandler);
        if (this.mAutoStart) {
            startFlipping();
        }
    }

    protected void onDetachedFromWindow() {
        super.onDetachedFromWindow();
        this.mVisible = LOGD;
        getContext().unregisterReceiver(this.mReceiver);
        updateRunning();
    }

    protected void onWindowVisibilityChanged(int visibility) {
        boolean z;
        super.onWindowVisibilityChanged(visibility);
        if (visibility == 0) {
            z = true;
        } else {
            z = LOGD;
        }
        this.mVisible = z;
        updateRunning(LOGD);
    }

    public void setAdapter(Adapter adapter) {
        super.setAdapter(adapter);
        updateRunning();
    }

    public int getFlipInterval() {
        return this.mFlipInterval;
    }

    public void setFlipInterval(int flipInterval) {
        this.mFlipInterval = flipInterval;
    }

    public void startFlipping() {
        this.mStarted = true;
        updateRunning();
    }

    public void stopFlipping() {
        this.mStarted = LOGD;
        updateRunning();
    }

    @RemotableViewMethod
    public void showNext() {
        if (this.mRunning) {
            this.mHandler.removeMessages(1);
            this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(1), (long) this.mFlipInterval);
        }
        super.showNext();
    }

    @RemotableViewMethod
    public void showPrevious() {
        if (this.mRunning) {
            this.mHandler.removeMessages(1);
            this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(1), (long) this.mFlipInterval);
        }
        super.showPrevious();
    }

    private void updateRunning() {
        updateRunning(true);
    }

    private void updateRunning(boolean flipNow) {
        boolean running = (!this.mAdvancedByHost && this.mVisible && this.mStarted && this.mUserPresent && this.mAdapter != null) ? true : LOGD;
        if (running != this.mRunning) {
            if (running) {
                showOnly(this.mWhichChild, flipNow);
                this.mHandler.sendMessageDelayed(this.mHandler.obtainMessage(1), (long) this.mFlipInterval);
            } else {
                this.mHandler.removeMessages(1);
            }
            this.mRunning = running;
        }
    }

    public boolean isFlipping() {
        return this.mStarted;
    }

    public void setAutoStart(boolean autoStart) {
        this.mAutoStart = autoStart;
    }

    public boolean isAutoStart() {
        return this.mAutoStart;
    }

    public void fyiWillBeAdvancedByHostKThx() {
        this.mAdvancedByHost = true;
        updateRunning(LOGD);
    }

    public void onInitializeAccessibilityEvent(AccessibilityEvent event) {
        super.onInitializeAccessibilityEvent(event);
        event.setClassName(AdapterViewFlipper.class.getName());
    }

    public void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo info) {
        super.onInitializeAccessibilityNodeInfo(info);
        info.setClassName(AdapterViewFlipper.class.getName());
    }
}
