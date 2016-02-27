package com.android.internal.policy.impl;

import android.animation.ArgbEvaluator;
import android.animation.ValueAnimator;
import android.animation.ValueAnimator.AnimatorUpdateListener;
import android.app.ActivityManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.drawable.ColorDrawable;
import android.os.Handler;
import android.os.Message;
import android.provider.Settings.Secure;
import android.util.DisplayMetrics;
import android.util.Slog;
import android.util.SparseBooleanArray;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.view.WindowManager.LayoutParams;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.view.animation.DecelerateInterpolator;
import android.widget.Button;
import android.widget.FrameLayout;

public class ImmersiveModeConfirmation {
    private static final String CONFIRMED = "confirmed";
    private static final boolean DEBUG = false;
    private static final boolean DEBUG_SHOW_EVERY_TIME = false;
    private static final String TAG = "ImmersiveModeConfirmation";
    private ClingWindowView mClingWindow;
    private final Runnable mConfirm;
    private boolean mConfirmed;
    private final Context mContext;
    private int mCurrentUserId;
    private final C0020H mHandler;
    private final long mPanicThresholdMs;
    private long mPanicTime;
    private final long mShowDelayMs;
    private final SparseBooleanArray mUserPanicResets;
    private WindowManager mWindowManager;

    /* renamed from: com.android.internal.policy.impl.ImmersiveModeConfirmation.1 */
    class C00151 implements Runnable {
        C00151() {
        }

        public void run() {
            if (!ImmersiveModeConfirmation.this.mConfirmed) {
                ImmersiveModeConfirmation.this.mConfirmed = true;
                ImmersiveModeConfirmation.this.saveSetting();
            }
            ImmersiveModeConfirmation.this.handleHide();
        }
    }

    private class ClingWindowView extends FrameLayout {
        private static final int BGCOLOR = Integer.MIN_VALUE;
        private static final int OFFSET_DP = 48;
        private ViewGroup mClingLayout;
        private final ColorDrawable mColor;
        private ValueAnimator mColorAnim;
        private final Runnable mConfirm;
        private BroadcastReceiver mReceiver;
        private Runnable mUpdateLayoutRunnable;

        /* renamed from: com.android.internal.policy.impl.ImmersiveModeConfirmation.ClingWindowView.1 */
        class C00161 implements Runnable {
            C00161() {
            }

            public void run() {
                if (ClingWindowView.this.mClingLayout != null && ClingWindowView.this.mClingLayout.getParent() != null) {
                    ClingWindowView.this.mClingLayout.setLayoutParams(ImmersiveModeConfirmation.this.getBubbleLayoutParams());
                }
            }
        }

        /* renamed from: com.android.internal.policy.impl.ImmersiveModeConfirmation.ClingWindowView.2 */
        class C00172 extends BroadcastReceiver {
            C00172() {
            }

            public void onReceive(Context context, Intent intent) {
                if (intent.getAction().equals("android.intent.action.CONFIGURATION_CHANGED")) {
                    ClingWindowView.this.post(ClingWindowView.this.mUpdateLayoutRunnable);
                }
            }
        }

        /* renamed from: com.android.internal.policy.impl.ImmersiveModeConfirmation.ClingWindowView.3 */
        class C00183 implements OnClickListener {
            C00183() {
            }

            public void onClick(View v) {
                ClingWindowView.this.mConfirm.run();
            }
        }

        /* renamed from: com.android.internal.policy.impl.ImmersiveModeConfirmation.ClingWindowView.4 */
        class C00194 implements AnimatorUpdateListener {
            C00194() {
            }

            public void onAnimationUpdate(ValueAnimator animation) {
                ClingWindowView.this.mColor.setColor(((Integer) animation.getAnimatedValue()).intValue());
            }
        }

        public ClingWindowView(Context context, Runnable confirm) {
            super(context);
            this.mColor = new ColorDrawable(0);
            this.mUpdateLayoutRunnable = new C00161();
            this.mReceiver = new C00172();
            this.mConfirm = confirm;
            setClickable(true);
            setBackground(this.mColor);
        }

        public void onAttachedToWindow() {
            super.onAttachedToWindow();
            DisplayMetrics metrics = new DisplayMetrics();
            ImmersiveModeConfirmation.this.mWindowManager.getDefaultDisplay().getMetrics(metrics);
            float density = metrics.density;
            this.mClingLayout = (ViewGroup) View.inflate(getContext(), 17367130, null);
            Button ok = (Button) this.mClingLayout.findViewById(16909069);
            ok.setOnClickListener(new C00183());
            addView(this.mClingLayout, ImmersiveModeConfirmation.this.getBubbleLayoutParams());
            if (ActivityManager.isHighEndGfx()) {
                View bubble = this.mClingLayout.findViewById(16908392);
                bubble.setAlpha(0.0f);
                bubble.setTranslationY(-48.0f * density);
                bubble.animate().alpha(1.0f).translationY(0.0f).setDuration(300).setInterpolator(new DecelerateInterpolator()).start();
                ok.setAlpha(0.0f);
                ok.setTranslationY(-48.0f * density);
                ok.animate().alpha(1.0f).translationY(0.0f).setDuration(300).setStartDelay(200).setInterpolator(new DecelerateInterpolator()).start();
                this.mColorAnim = ValueAnimator.ofObject(new ArgbEvaluator(), new Object[]{Integer.valueOf(0), Integer.valueOf(BGCOLOR)});
                this.mColorAnim.addUpdateListener(new C00194());
                this.mColorAnim.setDuration(1000);
                this.mColorAnim.start();
            } else {
                this.mColor.setColor(BGCOLOR);
            }
            this.mContext.registerReceiver(this.mReceiver, new IntentFilter("android.intent.action.CONFIGURATION_CHANGED"));
        }

        public void onDetachedFromWindow() {
            this.mContext.unregisterReceiver(this.mReceiver);
        }

        public boolean onTouchEvent(MotionEvent motion) {
            return true;
        }
    }

    /* renamed from: com.android.internal.policy.impl.ImmersiveModeConfirmation.H */
    private final class C0020H extends Handler {
        private static final int HIDE = 2;
        private static final int PANIC = 3;
        private static final int SHOW = 1;

        private C0020H() {
        }

        public void handleMessage(Message msg) {
            switch (msg.what) {
                case SHOW /*1*/:
                    ImmersiveModeConfirmation.this.handleShow();
                case HIDE /*2*/:
                    ImmersiveModeConfirmation.this.handleHide();
                case PANIC /*3*/:
                    ImmersiveModeConfirmation.this.handlePanic();
                default:
            }
        }
    }

    public ImmersiveModeConfirmation(Context context) {
        this.mUserPanicResets = new SparseBooleanArray();
        this.mConfirm = new C00151();
        this.mContext = context;
        this.mHandler = new C0020H();
        this.mShowDelayMs = getNavBarExitDuration() * 3;
        this.mPanicThresholdMs = (long) context.getResources().getInteger(17694844);
        this.mWindowManager = (WindowManager) this.mContext.getSystemService("window");
    }

    private long getNavBarExitDuration() {
        Animation exit = AnimationUtils.loadAnimation(this.mContext, 17432599);
        return exit != null ? exit.getDuration() : 0;
    }

    public void loadSetting(int currentUserId) {
        this.mConfirmed = DEBUG_SHOW_EVERY_TIME;
        this.mCurrentUserId = currentUserId;
        String value = null;
        try {
            value = Secure.getStringForUser(this.mContext.getContentResolver(), "immersive_mode_confirmations", -2);
            this.mConfirmed = CONFIRMED.equals(value);
        } catch (Throwable t) {
            Slog.w(TAG, "Error loading confirmations, value=" + value, t);
        }
    }

    private void saveSetting() {
        try {
            Secure.putStringForUser(this.mContext.getContentResolver(), "immersive_mode_confirmations", this.mConfirmed ? CONFIRMED : null, -2);
        } catch (Throwable t) {
            Slog.w(TAG, "Error saving confirmations, mConfirmed=" + this.mConfirmed, t);
        }
    }

    public void immersiveModeChanged(String pkg, boolean isImmersiveMode, boolean userSetupComplete) {
        this.mHandler.removeMessages(1);
        if (!isImmersiveMode) {
            this.mHandler.sendEmptyMessage(2);
        } else if (!PolicyControl.disableImmersiveConfirmation(pkg) && !this.mConfirmed && userSetupComplete) {
            this.mHandler.sendEmptyMessageDelayed(1, this.mShowDelayMs);
        }
    }

    public boolean onPowerKeyDown(boolean isScreenOn, long time, boolean inImmersiveMode) {
        if (!isScreenOn && time - this.mPanicTime < this.mPanicThresholdMs) {
            this.mHandler.sendEmptyMessage(3);
            if (this.mClingWindow == null) {
                return true;
            }
            return DEBUG_SHOW_EVERY_TIME;
        } else if (isScreenOn && inImmersiveMode) {
            this.mPanicTime = time;
            return DEBUG_SHOW_EVERY_TIME;
        } else {
            this.mPanicTime = 0;
            return DEBUG_SHOW_EVERY_TIME;
        }
    }

    public void confirmCurrentPrompt() {
        if (this.mClingWindow != null) {
            this.mHandler.post(this.mConfirm);
        }
    }

    private void handlePanic() {
        if (!this.mUserPanicResets.get(this.mCurrentUserId, DEBUG_SHOW_EVERY_TIME)) {
            this.mUserPanicResets.put(this.mCurrentUserId, true);
            this.mConfirmed = DEBUG_SHOW_EVERY_TIME;
            saveSetting();
        }
    }

    private void handleHide() {
        if (this.mClingWindow != null) {
            this.mWindowManager.removeView(this.mClingWindow);
            this.mClingWindow = null;
        }
    }

    public LayoutParams getClingWindowLayoutParams() {
        LayoutParams lp = new LayoutParams(-1, -1, 2005, 16777480, -3);
        lp.privateFlags |= 16;
        lp.setTitle(TAG);
        lp.windowAnimations = 16974566;
        lp.gravity = 119;
        return lp;
    }

    public FrameLayout.LayoutParams getBubbleLayoutParams() {
        return new FrameLayout.LayoutParams(this.mContext.getResources().getDimensionPixelSize(17105053), -2, 49);
    }

    private void handleShow() {
        this.mClingWindow = new ClingWindowView(this.mContext, this.mConfirm);
        this.mClingWindow.setSystemUiVisibility(768);
        this.mWindowManager.addView(this.mClingWindow, getClingWindowLayoutParams());
    }
}
