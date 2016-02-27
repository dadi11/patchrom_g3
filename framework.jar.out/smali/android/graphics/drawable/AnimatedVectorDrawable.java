package android.graphics.drawable;

import android.animation.Animator;
import android.animation.AnimatorInflater;
import android.content.res.ColorStateList;
import android.content.res.Resources;
import android.content.res.Resources.Theme;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.ColorFilter;
import android.graphics.Outline;
import android.graphics.PorterDuff.Mode;
import android.graphics.Rect;
import android.graphics.drawable.Drawable.Callback;
import android.graphics.drawable.Drawable.ConstantState;
import android.util.ArrayMap;
import android.util.AttributeSet;
import android.util.Log;
import android.view.WindowManager.LayoutParams;
import com.android.internal.R;
import java.io.IOException;
import java.util.ArrayList;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;

public class AnimatedVectorDrawable extends Drawable implements Animatable {
    private static final String ANIMATED_VECTOR = "animated-vector";
    private static final boolean DBG_ANIMATION_VECTOR_DRAWABLE = false;
    private static final String LOGTAG;
    private static final String TARGET = "target";
    private AnimatedVectorDrawableState mAnimatedVectorState;
    private final Callback mCallback;
    private boolean mMutated;

    /* renamed from: android.graphics.drawable.AnimatedVectorDrawable.1 */
    class C01841 implements Callback {
        C01841() {
        }

        public void invalidateDrawable(Drawable who) {
            AnimatedVectorDrawable.this.invalidateSelf();
        }

        public void scheduleDrawable(Drawable who, Runnable what, long when) {
            AnimatedVectorDrawable.this.scheduleSelf(what, when);
        }

        public void unscheduleDrawable(Drawable who, Runnable what) {
            AnimatedVectorDrawable.this.unscheduleSelf(what);
        }
    }

    private static class AnimatedVectorDrawableState extends ConstantState {
        ArrayList<Animator> mAnimators;
        int mChangingConfigurations;
        ArrayMap<Animator, String> mTargetNameMap;
        VectorDrawable mVectorDrawable;

        public AnimatedVectorDrawableState(AnimatedVectorDrawableState copy, Callback owner, Resources res) {
            if (copy != null) {
                this.mChangingConfigurations = copy.mChangingConfigurations;
                if (copy.mVectorDrawable != null) {
                    ConstantState cs = copy.mVectorDrawable.getConstantState();
                    if (res != null) {
                        this.mVectorDrawable = (VectorDrawable) cs.newDrawable(res);
                    } else {
                        this.mVectorDrawable = (VectorDrawable) cs.newDrawable();
                    }
                    this.mVectorDrawable = (VectorDrawable) this.mVectorDrawable.mutate();
                    this.mVectorDrawable.setCallback(owner);
                    this.mVectorDrawable.setLayoutDirection(copy.mVectorDrawable.getLayoutDirection());
                    this.mVectorDrawable.setBounds(copy.mVectorDrawable.getBounds());
                    this.mVectorDrawable.setAllowCaching(AnimatedVectorDrawable.DBG_ANIMATION_VECTOR_DRAWABLE);
                }
                if (copy.mAnimators != null) {
                    int numAnimators = copy.mAnimators.size();
                    this.mAnimators = new ArrayList(numAnimators);
                    this.mTargetNameMap = new ArrayMap(numAnimators);
                    for (int i = 0; i < numAnimators; i++) {
                        Animator anim = (Animator) copy.mAnimators.get(i);
                        Animator animClone = anim.clone();
                        String targetName = (String) copy.mTargetNameMap.get(anim);
                        animClone.setTarget(this.mVectorDrawable.getTargetByName(targetName));
                        this.mAnimators.add(animClone);
                        this.mTargetNameMap.put(animClone, targetName);
                    }
                    return;
                }
                return;
            }
            this.mVectorDrawable = new VectorDrawable();
        }

        public boolean canApplyTheme() {
            return ((this.mVectorDrawable == null || !this.mVectorDrawable.canApplyTheme()) && !super.canApplyTheme()) ? AnimatedVectorDrawable.DBG_ANIMATION_VECTOR_DRAWABLE : true;
        }

        public Drawable newDrawable() {
            return new AnimatedVectorDrawable(null, null);
        }

        public Drawable newDrawable(Resources res) {
            return new AnimatedVectorDrawable(res, null);
        }

        public int getChangingConfigurations() {
            return this.mChangingConfigurations;
        }
    }

    static {
        LOGTAG = AnimatedVectorDrawable.class.getSimpleName();
    }

    public AnimatedVectorDrawable() {
        this(null, null);
    }

    private AnimatedVectorDrawable(AnimatedVectorDrawableState state, Resources res) {
        this.mCallback = new C01841();
        this.mAnimatedVectorState = new AnimatedVectorDrawableState(state, this.mCallback, res);
    }

    public Drawable mutate() {
        if (!this.mMutated && super.mutate() == this) {
            this.mAnimatedVectorState = new AnimatedVectorDrawableState(this.mAnimatedVectorState, this.mCallback, null);
            this.mMutated = true;
        }
        return this;
    }

    public void clearMutated() {
        super.clearMutated();
        this.mAnimatedVectorState.mVectorDrawable.clearMutated();
        this.mMutated = DBG_ANIMATION_VECTOR_DRAWABLE;
    }

    public ConstantState getConstantState() {
        this.mAnimatedVectorState.mChangingConfigurations = getChangingConfigurations();
        return this.mAnimatedVectorState;
    }

    public int getChangingConfigurations() {
        return super.getChangingConfigurations() | this.mAnimatedVectorState.mChangingConfigurations;
    }

    public void draw(Canvas canvas) {
        this.mAnimatedVectorState.mVectorDrawable.draw(canvas);
        if (isStarted()) {
            invalidateSelf();
        }
    }

    protected void onBoundsChange(Rect bounds) {
        this.mAnimatedVectorState.mVectorDrawable.setBounds(bounds);
    }

    protected boolean onStateChange(int[] state) {
        return this.mAnimatedVectorState.mVectorDrawable.setState(state);
    }

    protected boolean onLevelChange(int level) {
        return this.mAnimatedVectorState.mVectorDrawable.setLevel(level);
    }

    public int getAlpha() {
        return this.mAnimatedVectorState.mVectorDrawable.getAlpha();
    }

    public void setAlpha(int alpha) {
        this.mAnimatedVectorState.mVectorDrawable.setAlpha(alpha);
    }

    public void setColorFilter(ColorFilter colorFilter) {
        this.mAnimatedVectorState.mVectorDrawable.setColorFilter(colorFilter);
    }

    public void setTintList(ColorStateList tint) {
        this.mAnimatedVectorState.mVectorDrawable.setTintList(tint);
    }

    public void setHotspot(float x, float y) {
        this.mAnimatedVectorState.mVectorDrawable.setHotspot(x, y);
    }

    public void setHotspotBounds(int left, int top, int right, int bottom) {
        this.mAnimatedVectorState.mVectorDrawable.setHotspotBounds(left, top, right, bottom);
    }

    public void setTintMode(Mode tintMode) {
        this.mAnimatedVectorState.mVectorDrawable.setTintMode(tintMode);
    }

    public boolean setVisible(boolean visible, boolean restart) {
        this.mAnimatedVectorState.mVectorDrawable.setVisible(visible, restart);
        return super.setVisible(visible, restart);
    }

    public void setLayoutDirection(int layoutDirection) {
        this.mAnimatedVectorState.mVectorDrawable.setLayoutDirection(layoutDirection);
    }

    public boolean isStateful() {
        return this.mAnimatedVectorState.mVectorDrawable.isStateful();
    }

    public int getOpacity() {
        return this.mAnimatedVectorState.mVectorDrawable.getOpacity();
    }

    public int getIntrinsicWidth() {
        return this.mAnimatedVectorState.mVectorDrawable.getIntrinsicWidth();
    }

    public int getIntrinsicHeight() {
        return this.mAnimatedVectorState.mVectorDrawable.getIntrinsicHeight();
    }

    public void getOutline(Outline outline) {
        this.mAnimatedVectorState.mVectorDrawable.getOutline(outline);
    }

    public void inflate(Resources res, XmlPullParser parser, AttributeSet attrs, Theme theme) throws XmlPullParserException, IOException {
        int eventType = parser.getEventType();
        float pathErrorScale = LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
        while (eventType != 1) {
            if (eventType == 2) {
                String tagName = parser.getName();
                TypedArray a;
                if (ANIMATED_VECTOR.equals(tagName)) {
                    a = Drawable.obtainAttributes(res, theme, attrs, R.styleable.AnimatedVectorDrawable);
                    int drawableRes = a.getResourceId(0, 0);
                    if (drawableRes != 0) {
                        VectorDrawable vectorDrawable = (VectorDrawable) res.getDrawable(drawableRes, theme).mutate();
                        vectorDrawable.setAllowCaching(DBG_ANIMATION_VECTOR_DRAWABLE);
                        vectorDrawable.setCallback(this.mCallback);
                        pathErrorScale = vectorDrawable.getPixelSize();
                        if (this.mAnimatedVectorState.mVectorDrawable != null) {
                            this.mAnimatedVectorState.mVectorDrawable.setCallback(null);
                        }
                        this.mAnimatedVectorState.mVectorDrawable = vectorDrawable;
                    }
                    a.recycle();
                } else if (TARGET.equals(tagName)) {
                    a = Drawable.obtainAttributes(res, theme, attrs, R.styleable.AnimatedVectorDrawableTarget);
                    String target = a.getString(0);
                    int id = a.getResourceId(1, 0);
                    if (id != 0) {
                        setupAnimatorsForTarget(target, AnimatorInflater.loadAnimator(res, theme, id, pathErrorScale));
                    }
                    a.recycle();
                }
            }
            eventType = parser.next();
        }
    }

    public boolean canApplyTheme() {
        return ((this.mAnimatedVectorState == null || !this.mAnimatedVectorState.canApplyTheme()) && !super.canApplyTheme()) ? DBG_ANIMATION_VECTOR_DRAWABLE : true;
    }

    public void applyTheme(Theme t) {
        super.applyTheme(t);
        VectorDrawable vectorDrawable = this.mAnimatedVectorState.mVectorDrawable;
        if (vectorDrawable != null && vectorDrawable.canApplyTheme()) {
            vectorDrawable.applyTheme(t);
        }
    }

    private void setupAnimatorsForTarget(String name, Animator animator) {
        animator.setTarget(this.mAnimatedVectorState.mVectorDrawable.getTargetByName(name));
        if (this.mAnimatedVectorState.mAnimators == null) {
            this.mAnimatedVectorState.mAnimators = new ArrayList();
            this.mAnimatedVectorState.mTargetNameMap = new ArrayMap();
        }
        this.mAnimatedVectorState.mAnimators.add(animator);
        this.mAnimatedVectorState.mTargetNameMap.put(animator, name);
    }

    public boolean isRunning() {
        ArrayList<Animator> animators = this.mAnimatedVectorState.mAnimators;
        int size = animators.size();
        for (int i = 0; i < size; i++) {
            if (((Animator) animators.get(i)).isRunning()) {
                return true;
            }
        }
        return DBG_ANIMATION_VECTOR_DRAWABLE;
    }

    private boolean isStarted() {
        ArrayList<Animator> animators = this.mAnimatedVectorState.mAnimators;
        int size = animators.size();
        for (int i = 0; i < size; i++) {
            if (((Animator) animators.get(i)).isStarted()) {
                return true;
            }
        }
        return DBG_ANIMATION_VECTOR_DRAWABLE;
    }

    public void start() {
        if (!isStarted()) {
            ArrayList<Animator> animators = this.mAnimatedVectorState.mAnimators;
            int size = animators.size();
            for (int i = 0; i < size; i++) {
                ((Animator) animators.get(i)).start();
            }
            invalidateSelf();
        }
    }

    public void stop() {
        ArrayList<Animator> animators = this.mAnimatedVectorState.mAnimators;
        int size = animators.size();
        for (int i = 0; i < size; i++) {
            ((Animator) animators.get(i)).end();
        }
    }

    public void reverse() {
        if (canReverse()) {
            ArrayList<Animator> animators = this.mAnimatedVectorState.mAnimators;
            int size = animators.size();
            for (int i = 0; i < size; i++) {
                ((Animator) animators.get(i)).reverse();
            }
            return;
        }
        Log.w(LOGTAG, "AnimatedVectorDrawable can't reverse()");
    }

    public boolean canReverse() {
        ArrayList<Animator> animators = this.mAnimatedVectorState.mAnimators;
        int size = animators.size();
        for (int i = 0; i < size; i++) {
            if (!((Animator) animators.get(i)).canReverse()) {
                return DBG_ANIMATION_VECTOR_DRAWABLE;
            }
        }
        return true;
    }
}
