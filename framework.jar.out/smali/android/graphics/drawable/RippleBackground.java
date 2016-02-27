package android.graphics.drawable;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.animation.ObjectAnimator;
import android.animation.TimeInterpolator;
import android.graphics.Canvas;
import android.graphics.CanvasProperty;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Rect;
import android.util.MathUtils;
import android.view.HardwareCanvas;
import android.view.RenderNodeAnimator;
import android.view.animation.LinearInterpolator;
import java.util.ArrayList;

class RippleBackground {
    private static final int ENTER_DURATION = 667;
    private static final int ENTER_DURATION_FAST = 100;
    private static final float GLOBAL_SPEED = 1.0f;
    private static final TimeInterpolator LINEAR_INTERPOLATOR;
    private static final float WAVE_OPACITY_DECAY_VELOCITY = 3.0f;
    private static final float WAVE_OUTER_OPACITY_EXIT_VELOCITY_MAX = 4.5f;
    private static final float WAVE_OUTER_OPACITY_EXIT_VELOCITY_MIN = 1.5f;
    private static final float WAVE_OUTER_SIZE_INFLUENCE_MAX = 200.0f;
    private static final float WAVE_OUTER_SIZE_INFLUENCE_MIN = 40.0f;
    private ObjectAnimator mAnimOuterOpacity;
    private final AnimatorListenerAdapter mAnimationListener;
    private final Rect mBounds;
    private boolean mCanUseHardware;
    private int mColor;
    private float mDensity;
    private boolean mHardwareAnimating;
    private boolean mHasMaxRadius;
    private boolean mHasPendingHardwareExit;
    private float mOuterOpacity;
    private float mOuterRadius;
    private float mOuterX;
    private float mOuterY;
    private final RippleDrawable mOwner;
    private int mPendingInflectionDuration;
    private int mPendingInflectionOpacity;
    private int mPendingOpacityDuration;
    private CanvasProperty<Paint> mPropOuterPaint;
    private CanvasProperty<Float> mPropOuterRadius;
    private CanvasProperty<Float> mPropOuterX;
    private CanvasProperty<Float> mPropOuterY;
    private final ArrayList<RenderNodeAnimator> mRunningAnimations;
    private Paint mTempPaint;

    /* renamed from: android.graphics.drawable.RippleBackground.1 */
    class C01951 extends AnimatorListenerAdapter {
        final /* synthetic */ int val$outerDuration;

        C01951(int i) {
            this.val$outerDuration = i;
        }

        public void onAnimationEnd(Animator animation) {
            ObjectAnimator outerFadeOutAnim = ObjectAnimator.ofFloat(RippleBackground.this, "outerOpacity", new float[]{0.0f});
            outerFadeOutAnim.setAutoCancel(true);
            outerFadeOutAnim.setDuration((long) this.val$outerDuration);
            outerFadeOutAnim.setInterpolator(RippleBackground.LINEAR_INTERPOLATOR);
            outerFadeOutAnim.addListener(RippleBackground.this.mAnimationListener);
            RippleBackground.this.mAnimOuterOpacity = outerFadeOutAnim;
            outerFadeOutAnim.start();
        }

        public void onAnimationCancel(Animator animation) {
            animation.removeListener(this);
        }
    }

    /* renamed from: android.graphics.drawable.RippleBackground.2 */
    class C01962 extends AnimatorListenerAdapter {
        C01962() {
        }

        public void onAnimationEnd(Animator animation) {
            RippleBackground.this.mHardwareAnimating = false;
        }
    }

    static {
        LINEAR_INTERPOLATOR = new LinearInterpolator();
    }

    public RippleBackground(RippleDrawable owner, Rect bounds) {
        this.mRunningAnimations = new ArrayList();
        this.mOuterOpacity = 0.0f;
        this.mAnimationListener = new C01962();
        this.mOwner = owner;
        this.mBounds = bounds;
    }

    public void setup(int maxRadius, float density) {
        if (maxRadius != -1) {
            this.mHasMaxRadius = true;
            this.mOuterRadius = (float) maxRadius;
        } else {
            float halfWidth = ((float) this.mBounds.width()) / 2.0f;
            float halfHeight = ((float) this.mBounds.height()) / 2.0f;
            this.mOuterRadius = (float) Math.sqrt((double) ((halfWidth * halfWidth) + (halfHeight * halfHeight)));
        }
        this.mOuterX = 0.0f;
        this.mOuterY = 0.0f;
        this.mDensity = density;
    }

    public void onHotspotBoundsChanged() {
        if (!this.mHasMaxRadius) {
            float halfWidth = ((float) this.mBounds.width()) / 2.0f;
            float halfHeight = ((float) this.mBounds.height()) / 2.0f;
            this.mOuterRadius = (float) Math.sqrt((double) ((halfWidth * halfWidth) + (halfHeight * halfHeight)));
        }
    }

    public void setOuterOpacity(float a) {
        this.mOuterOpacity = a;
        invalidateSelf();
    }

    public float getOuterOpacity() {
        return this.mOuterOpacity;
    }

    public boolean draw(Canvas c, Paint p) {
        this.mColor = p.getColor();
        boolean canUseHardware = c.isHardwareAccelerated();
        if (this.mCanUseHardware != canUseHardware && this.mCanUseHardware) {
            cancelHardwareAnimations(true);
        }
        this.mCanUseHardware = canUseHardware;
        if (canUseHardware && (this.mHardwareAnimating || this.mHasPendingHardwareExit)) {
            return drawHardware((HardwareCanvas) c, p);
        }
        return drawSoftware(c, p);
    }

    public boolean shouldDraw() {
        return (this.mCanUseHardware && this.mHardwareAnimating) || (this.mOuterOpacity > 0.0f && this.mOuterRadius > 0.0f);
    }

    private boolean drawHardware(HardwareCanvas c, Paint p) {
        if (this.mHasPendingHardwareExit) {
            cancelHardwareAnimations(false);
            startPendingHardwareExit(c, p);
        }
        c.drawCircle(this.mPropOuterX, this.mPropOuterY, this.mPropOuterRadius, this.mPropOuterPaint);
        return true;
    }

    private boolean drawSoftware(Canvas c, Paint p) {
        int paintAlpha = p.getAlpha();
        int alpha = (int) ((((float) paintAlpha) * this.mOuterOpacity) + 0.5f);
        float radius = this.mOuterRadius;
        if (alpha <= 0 || radius <= 0.0f) {
            return false;
        }
        p.setAlpha(alpha);
        c.drawCircle(this.mOuterX, this.mOuterY, radius, p);
        p.setAlpha(paintAlpha);
        return true;
    }

    public void getBounds(Rect bounds) {
        int outerX = (int) this.mOuterX;
        int outerY = (int) this.mOuterY;
        int r = ((int) this.mOuterRadius) + 1;
        bounds.set(outerX - r, outerY - r, outerX + r, outerY + r);
    }

    public void enter(boolean fast) {
        cancel();
        ObjectAnimator opacity = ObjectAnimator.ofFloat(this, "outerOpacity", new float[]{0.0f, GLOBAL_SPEED});
        opacity.setAutoCancel(true);
        opacity.setDuration(fast ? 100 : 667);
        opacity.setInterpolator(LINEAR_INTERPOLATOR);
        this.mAnimOuterOpacity = opacity;
        opacity.start();
    }

    public void exit() {
        cancel();
        float outerSizeInfluence = MathUtils.constrain((this.mOuterRadius - (WAVE_OUTER_SIZE_INFLUENCE_MIN * this.mDensity)) / (WAVE_OUTER_SIZE_INFLUENCE_MAX * this.mDensity), 0.0f, GLOBAL_SPEED);
        float outerOpacityVelocity = MathUtils.lerp(WAVE_OUTER_OPACITY_EXIT_VELOCITY_MIN, WAVE_OUTER_OPACITY_EXIT_VELOCITY_MAX, outerSizeInfluence);
        int inflectionDuration = Math.max(0, (int) ((((GLOBAL_SPEED - this.mOuterOpacity) * 1000.0f) / (WAVE_OPACITY_DECAY_VELOCITY + outerOpacityVelocity)) + 0.5f));
        int inflectionOpacity = (int) ((((float) Color.alpha(this.mColor)) * (this.mOuterOpacity + (((((float) inflectionDuration) * outerOpacityVelocity) * outerSizeInfluence) / 1000.0f))) + 0.5f);
        if (this.mCanUseHardware) {
            createPendingHardwareExit(333, inflectionDuration, inflectionOpacity);
        } else {
            exitSoftware(333, inflectionDuration, inflectionOpacity);
        }
    }

    private void createPendingHardwareExit(int opacityDuration, int inflectionDuration, int inflectionOpacity) {
        this.mHasPendingHardwareExit = true;
        this.mPendingOpacityDuration = opacityDuration;
        this.mPendingInflectionDuration = inflectionDuration;
        this.mPendingInflectionOpacity = inflectionOpacity;
        invalidateSelf();
    }

    private void startPendingHardwareExit(HardwareCanvas c, Paint p) {
        RenderNodeAnimator outerOpacityAnim;
        this.mHasPendingHardwareExit = false;
        int opacityDuration = this.mPendingOpacityDuration;
        int inflectionDuration = this.mPendingInflectionDuration;
        int inflectionOpacity = this.mPendingInflectionOpacity;
        Paint outerPaint = getTempPaint(p);
        outerPaint.setAlpha((int) ((((float) outerPaint.getAlpha()) * this.mOuterOpacity) + 0.5f));
        this.mPropOuterPaint = CanvasProperty.createPaint(outerPaint);
        this.mPropOuterRadius = CanvasProperty.createFloat(this.mOuterRadius);
        this.mPropOuterX = CanvasProperty.createFloat(this.mOuterX);
        this.mPropOuterY = CanvasProperty.createFloat(this.mOuterY);
        if (inflectionDuration > 0) {
            outerOpacityAnim = new RenderNodeAnimator(this.mPropOuterPaint, 1, (float) inflectionOpacity);
            outerOpacityAnim.setDuration((long) inflectionDuration);
            outerOpacityAnim.setInterpolator(LINEAR_INTERPOLATOR);
            int outerDuration = opacityDuration - inflectionDuration;
            if (outerDuration > 0) {
                RenderNodeAnimator outerFadeOutAnim = new RenderNodeAnimator(this.mPropOuterPaint, 1, 0.0f);
                outerFadeOutAnim.setDuration((long) outerDuration);
                outerFadeOutAnim.setInterpolator(LINEAR_INTERPOLATOR);
                outerFadeOutAnim.setStartDelay((long) inflectionDuration);
                outerFadeOutAnim.setStartValue((float) inflectionOpacity);
                outerFadeOutAnim.addListener(this.mAnimationListener);
                outerFadeOutAnim.setTarget((Canvas) c);
                outerFadeOutAnim.start();
                this.mRunningAnimations.add(outerFadeOutAnim);
            } else {
                outerOpacityAnim.addListener(this.mAnimationListener);
            }
        } else {
            outerOpacityAnim = new RenderNodeAnimator(this.mPropOuterPaint, 1, 0.0f);
            outerOpacityAnim.setInterpolator(LINEAR_INTERPOLATOR);
            outerOpacityAnim.setDuration((long) opacityDuration);
            outerOpacityAnim.addListener(this.mAnimationListener);
        }
        outerOpacityAnim.setTarget((Canvas) c);
        outerOpacityAnim.start();
        this.mRunningAnimations.add(outerOpacityAnim);
        this.mHardwareAnimating = true;
        this.mOuterOpacity = 0.0f;
    }

    public void jump() {
        endSoftwareAnimations();
        cancelHardwareAnimations(true);
    }

    private void endSoftwareAnimations() {
        if (this.mAnimOuterOpacity != null) {
            this.mAnimOuterOpacity.end();
            this.mAnimOuterOpacity = null;
        }
    }

    private Paint getTempPaint(Paint original) {
        if (this.mTempPaint == null) {
            this.mTempPaint = new Paint();
        }
        this.mTempPaint.set(original);
        return this.mTempPaint;
    }

    private void exitSoftware(int opacityDuration, int inflectionDuration, int inflectionOpacity) {
        ObjectAnimator outerOpacityAnim;
        if (inflectionDuration > 0) {
            outerOpacityAnim = ObjectAnimator.ofFloat(this, "outerOpacity", new float[]{((float) inflectionOpacity) / 255.0f});
            outerOpacityAnim.setAutoCancel(true);
            outerOpacityAnim.setDuration((long) inflectionDuration);
            outerOpacityAnim.setInterpolator(LINEAR_INTERPOLATOR);
            int outerDuration = opacityDuration - inflectionDuration;
            if (outerDuration > 0) {
                outerOpacityAnim.addListener(new C01951(outerDuration));
            } else {
                outerOpacityAnim.addListener(this.mAnimationListener);
            }
        } else {
            outerOpacityAnim = ObjectAnimator.ofFloat(this, "outerOpacity", new float[]{0.0f});
            outerOpacityAnim.setAutoCancel(true);
            outerOpacityAnim.setDuration((long) opacityDuration);
            outerOpacityAnim.addListener(this.mAnimationListener);
        }
        this.mAnimOuterOpacity = outerOpacityAnim;
        outerOpacityAnim.start();
    }

    public void cancel() {
        cancelSoftwareAnimations();
        cancelHardwareAnimations(false);
    }

    private void cancelSoftwareAnimations() {
        if (this.mAnimOuterOpacity != null) {
            this.mAnimOuterOpacity.cancel();
            this.mAnimOuterOpacity = null;
        }
    }

    private void cancelHardwareAnimations(boolean jumpToEnd) {
        ArrayList<RenderNodeAnimator> runningAnimations = this.mRunningAnimations;
        int N = runningAnimations.size();
        for (int i = 0; i < N; i++) {
            if (jumpToEnd) {
                ((RenderNodeAnimator) runningAnimations.get(i)).end();
            } else {
                ((RenderNodeAnimator) runningAnimations.get(i)).cancel();
            }
        }
        runningAnimations.clear();
        if (this.mHasPendingHardwareExit) {
            this.mHasPendingHardwareExit = false;
            if (jumpToEnd) {
                this.mOuterOpacity = 0.0f;
            }
        }
        this.mHardwareAnimating = false;
    }

    private void invalidateSelf() {
        this.mOwner.invalidateSelf();
    }
}
