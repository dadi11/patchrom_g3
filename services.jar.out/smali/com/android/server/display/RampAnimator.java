package com.android.server.display;

import android.animation.ValueAnimator;
import android.util.IntProperty;
import android.view.Choreographer;

final class RampAnimator<T> {
    private float mAnimatedValue;
    private boolean mAnimating;
    private final Runnable mAnimationCallback;
    private final Choreographer mChoreographer;
    private int mCurrentValue;
    private boolean mFirstTime;
    private long mLastFrameTimeNanos;
    private Listener mListener;
    private final T mObject;
    private final IntProperty<T> mProperty;
    private int mRate;
    private int mTargetValue;

    public interface Listener {
        void onAnimationEnd();
    }

    /* renamed from: com.android.server.display.RampAnimator.1 */
    class C02191 implements Runnable {
        C02191() {
        }

        public void run() {
            long frameTimeNanos = RampAnimator.this.mChoreographer.getFrameTimeNanos();
            float timeDelta = ((float) (frameTimeNanos - RampAnimator.this.mLastFrameTimeNanos)) * 1.0E-9f;
            RampAnimator.this.mLastFrameTimeNanos = frameTimeNanos;
            float scale = ValueAnimator.getDurationScale();
            if (scale == 0.0f) {
                RampAnimator.this.mAnimatedValue = (float) RampAnimator.this.mTargetValue;
            } else {
                float amount = (((float) RampAnimator.this.mRate) * timeDelta) / scale;
                if (RampAnimator.this.mTargetValue > RampAnimator.this.mCurrentValue) {
                    RampAnimator.this.mAnimatedValue = Math.min(RampAnimator.this.mAnimatedValue + amount, (float) RampAnimator.this.mTargetValue);
                } else {
                    RampAnimator.this.mAnimatedValue = Math.max(RampAnimator.this.mAnimatedValue - amount, (float) RampAnimator.this.mTargetValue);
                }
            }
            int oldCurrentValue = RampAnimator.this.mCurrentValue;
            RampAnimator.this.mCurrentValue = Math.round(RampAnimator.this.mAnimatedValue);
            if (oldCurrentValue != RampAnimator.this.mCurrentValue) {
                RampAnimator.this.mProperty.setValue(RampAnimator.this.mObject, RampAnimator.this.mCurrentValue);
            }
            if (RampAnimator.this.mTargetValue != RampAnimator.this.mCurrentValue) {
                RampAnimator.this.postAnimationCallback();
                return;
            }
            RampAnimator.this.mAnimating = false;
            if (RampAnimator.this.mListener != null) {
                RampAnimator.this.mListener.onAnimationEnd();
            }
        }
    }

    public RampAnimator(T object, IntProperty<T> property) {
        this.mFirstTime = true;
        this.mAnimationCallback = new C02191();
        this.mObject = object;
        this.mProperty = property;
        this.mChoreographer = Choreographer.getInstance();
    }

    public boolean animateTo(int target, int rate) {
        boolean z = false;
        if (!this.mFirstTime && rate > 0) {
            if (!this.mAnimating || rate > this.mRate || ((target <= this.mCurrentValue && this.mCurrentValue <= this.mTargetValue) || (this.mTargetValue <= this.mCurrentValue && this.mCurrentValue <= target))) {
                this.mRate = rate;
            }
            if (this.mTargetValue != target) {
                z = true;
            }
            this.mTargetValue = target;
            if (this.mAnimating || target == this.mCurrentValue) {
                return z;
            }
            this.mAnimating = true;
            this.mAnimatedValue = (float) this.mCurrentValue;
            this.mLastFrameTimeNanos = System.nanoTime();
            postAnimationCallback();
            return z;
        } else if (!this.mFirstTime && target == this.mCurrentValue) {
            return false;
        } else {
            this.mFirstTime = false;
            this.mRate = 0;
            this.mTargetValue = target;
            this.mCurrentValue = target;
            this.mProperty.setValue(this.mObject, target);
            if (this.mAnimating) {
                this.mAnimating = false;
                cancelAnimationCallback();
            }
            if (this.mListener != null) {
                this.mListener.onAnimationEnd();
            }
            return true;
        }
    }

    public boolean isAnimating() {
        return this.mAnimating;
    }

    public void setListener(Listener listener) {
        this.mListener = listener;
    }

    private void postAnimationCallback() {
        this.mChoreographer.postCallback(1, this.mAnimationCallback, null);
    }

    private void cancelAnimationCallback() {
        this.mChoreographer.removeCallbacks(1, this.mAnimationCallback, null);
    }
}
