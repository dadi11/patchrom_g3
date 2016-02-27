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
public class ViewFlipper extends ViewAnimator {
    private static final int DEFAULT_INTERVAL = 3000;
    private static final boolean LOGD = false;
    private static final String TAG = "ViewFlipper";
    private final int FLIP_MSG;
    private boolean mAutoStart;
    private int mFlipInterval;
    private final Handler mHandler;
    private final BroadcastReceiver mReceiver;
    private boolean mRunning;
    private boolean mStarted;
    private boolean mUserPresent;
    private boolean mVisible;

    /* renamed from: android.widget.ViewFlipper.1 */
    class C10991 extends BroadcastReceiver {
        C10991() {
        }

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if (Intent.ACTION_SCREEN_OFF.equals(action)) {
                ViewFlipper.this.mUserPresent = ViewFlipper.LOGD;
                ViewFlipper.this.updateRunning();
            } else if (Intent.ACTION_USER_PRESENT.equals(action)) {
                ViewFlipper.this.mUserPresent = true;
                ViewFlipper.this.updateRunning(ViewFlipper.LOGD);
            }
        }
    }

    /* renamed from: android.widget.ViewFlipper.2 */
    class C11002 extends Handler {
        C11002() {
        }

        public void handleMessage(Message msg) {
            if (msg.what == 1 && ViewFlipper.this.mRunning) {
                ViewFlipper.this.showNext();
                sendMessageDelayed(obtainMessage(1), (long) ViewFlipper.this.mFlipInterval);
            }
        }
    }

    public ViewFlipper(Context context) {
        super(context);
        this.mFlipInterval = DEFAULT_INTERVAL;
        this.mAutoStart = LOGD;
        this.mRunning = LOGD;
        this.mStarted = LOGD;
        this.mVisible = LOGD;
        this.mUserPresent = true;
        this.mReceiver = new C10991();
        this.FLIP_MSG = 1;
        this.mHandler = new C11002();
    }

    public ViewFlipper(Context context, AttributeSet attrs) {
        super(context, attrs);
        this.mFlipInterval = DEFAULT_INTERVAL;
        this.mAutoStart = LOGD;
        this.mRunning = LOGD;
        this.mStarted = LOGD;
        this.mVisible = LOGD;
        this.mUserPresent = true;
        this.mReceiver = new C10991();
        this.FLIP_MSG = 1;
        this.mHandler = new C11002();
        TypedArray a = context.obtainStyledAttributes(attrs, R.styleable.ViewFlipper);
        this.mFlipInterval = a.getInt(0, DEFAULT_INTERVAL);
        this.mAutoStart = a.getBoolean(1, LOGD);
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

    @RemotableViewMethod
    public void setFlipInterval(int milliseconds) {
        this.mFlipInterval = milliseconds;
    }

    public void startFlipping() {
        this.mStarted = true;
        updateRunning();
    }

    public void stopFlipping() {
        this.mStarted = LOGD;
        updateRunning();
    }

    public void onInitializeAccessibilityEvent(AccessibilityEvent event) {
        super.onInitializeAccessibilityEvent(event);
        event.setClassName(ViewFlipper.class.getName());
    }

    public void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo info) {
        super.onInitializeAccessibilityNodeInfo(info);
        info.setClassName(ViewFlipper.class.getName());
    }

    private void updateRunning() {
        updateRunning(true);
    }

    private void updateRunning(boolean flipNow) {
        boolean running = (this.mVisible && this.mStarted && this.mUserPresent) ? true : LOGD;
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
}
