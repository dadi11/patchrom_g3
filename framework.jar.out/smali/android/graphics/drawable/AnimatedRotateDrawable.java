package android.graphics.drawable;

import android.content.res.ColorStateList;
import android.content.res.Resources;
import android.content.res.Resources.Theme;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.ColorFilter;
import android.graphics.PorterDuff.Mode;
import android.graphics.Rect;
import android.graphics.drawable.Drawable.Callback;
import android.graphics.drawable.Drawable.ConstantState;
import android.os.SystemClock;
import android.util.AttributeSet;
import android.util.TypedValue;
import android.view.KeyEvent;
import android.view.WindowManager.LayoutParams;
import com.android.internal.R;
import java.io.IOException;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;

public class AnimatedRotateDrawable extends Drawable implements Callback, Runnable, Animatable {
    private static final String TAG = "AnimatedRotateDrawable";
    private float mCurrentDegrees;
    private float mIncrement;
    private boolean mMutated;
    private boolean mRunning;
    private AnimatedRotateState mState;

    static final class AnimatedRotateState extends ConstantState {
        private boolean mCanConstantState;
        int mChangingConfigurations;
        private boolean mCheckedConstantState;
        Drawable mDrawable;
        int mFrameDuration;
        int mFramesCount;
        float mPivotX;
        boolean mPivotXRel;
        float mPivotY;
        boolean mPivotYRel;
        int[] mThemeAttrs;

        public AnimatedRotateState(AnimatedRotateState orig, AnimatedRotateDrawable owner, Resources res) {
            this.mPivotXRel = false;
            this.mPivotX = 0.0f;
            this.mPivotYRel = false;
            this.mPivotY = 0.0f;
            this.mFrameDuration = KeyEvent.KEYCODE_NUMPAD_6;
            this.mFramesCount = 12;
            if (orig != null) {
                if (res != null) {
                    this.mDrawable = orig.mDrawable.getConstantState().newDrawable(res);
                } else {
                    this.mDrawable = orig.mDrawable.getConstantState().newDrawable();
                }
                this.mDrawable.setCallback(owner);
                this.mDrawable.setLayoutDirection(orig.mDrawable.getLayoutDirection());
                this.mDrawable.setBounds(orig.mDrawable.getBounds());
                this.mDrawable.setLevel(orig.mDrawable.getLevel());
                this.mThemeAttrs = orig.mThemeAttrs;
                this.mPivotXRel = orig.mPivotXRel;
                this.mPivotX = orig.mPivotX;
                this.mPivotYRel = orig.mPivotYRel;
                this.mPivotY = orig.mPivotY;
                this.mFramesCount = orig.mFramesCount;
                this.mFrameDuration = orig.mFrameDuration;
                this.mCheckedConstantState = true;
                this.mCanConstantState = true;
            }
        }

        public Drawable newDrawable() {
            return new AnimatedRotateDrawable(null, null);
        }

        public Drawable newDrawable(Resources res) {
            return new AnimatedRotateDrawable(res, null);
        }

        public boolean canApplyTheme() {
            return this.mThemeAttrs != null || ((this.mDrawable != null && this.mDrawable.canApplyTheme()) || super.canApplyTheme());
        }

        public int getChangingConfigurations() {
            return this.mChangingConfigurations;
        }

        public boolean canConstantState() {
            if (!this.mCheckedConstantState) {
                this.mCanConstantState = this.mDrawable.getConstantState() != null;
                this.mCheckedConstantState = true;
            }
            return this.mCanConstantState;
        }
    }

    public AnimatedRotateDrawable() {
        this(null, null);
    }

    private AnimatedRotateDrawable(AnimatedRotateState rotateState, Resources res) {
        this.mState = new AnimatedRotateState(rotateState, this, res);
        init();
    }

    private void init() {
        AnimatedRotateState state = this.mState;
        this.mIncrement = 360.0f / ((float) state.mFramesCount);
        Drawable drawable = state.mDrawable;
        if (drawable != null) {
            drawable.setFilterBitmap(true);
            if (drawable instanceof BitmapDrawable) {
                ((BitmapDrawable) drawable).setAntiAlias(true);
            }
        }
    }

    public void draw(Canvas canvas) {
        int saveCount = canvas.save();
        AnimatedRotateState st = this.mState;
        Drawable drawable = st.mDrawable;
        Rect bounds = drawable.getBounds();
        canvas.rotate(this.mCurrentDegrees, ((float) bounds.left) + (st.mPivotXRel ? ((float) (bounds.right - bounds.left)) * st.mPivotX : st.mPivotX), ((float) bounds.top) + (st.mPivotYRel ? ((float) (bounds.bottom - bounds.top)) * st.mPivotY : st.mPivotY));
        drawable.draw(canvas);
        canvas.restoreToCount(saveCount);
    }

    public void start() {
        if (!this.mRunning) {
            this.mRunning = true;
            nextFrame();
        }
    }

    public void stop() {
        this.mRunning = false;
        unscheduleSelf(this);
    }

    public boolean isRunning() {
        return this.mRunning;
    }

    private void nextFrame() {
        unscheduleSelf(this);
        scheduleSelf(this, SystemClock.uptimeMillis() + ((long) this.mState.mFrameDuration));
    }

    public void run() {
        this.mCurrentDegrees += this.mIncrement;
        if (this.mCurrentDegrees > 360.0f - this.mIncrement) {
            this.mCurrentDegrees = 0.0f;
        }
        invalidateSelf();
        nextFrame();
    }

    public boolean setVisible(boolean visible, boolean restart) {
        this.mState.mDrawable.setVisible(visible, restart);
        boolean changed = super.setVisible(visible, restart);
        if (!visible) {
            unscheduleSelf(this);
        } else if (changed || restart) {
            this.mCurrentDegrees = 0.0f;
            nextFrame();
        }
        return changed;
    }

    public Drawable getDrawable() {
        return this.mState.mDrawable;
    }

    public int getChangingConfigurations() {
        return (super.getChangingConfigurations() | this.mState.mChangingConfigurations) | this.mState.mDrawable.getChangingConfigurations();
    }

    public void setAlpha(int alpha) {
        this.mState.mDrawable.setAlpha(alpha);
    }

    public int getAlpha() {
        return this.mState.mDrawable.getAlpha();
    }

    public void setColorFilter(ColorFilter cf) {
        this.mState.mDrawable.setColorFilter(cf);
    }

    public void setTintList(ColorStateList tint) {
        this.mState.mDrawable.setTintList(tint);
    }

    public void setTintMode(Mode tintMode) {
        this.mState.mDrawable.setTintMode(tintMode);
    }

    public int getOpacity() {
        return this.mState.mDrawable.getOpacity();
    }

    public boolean canApplyTheme() {
        return (this.mState != null && this.mState.canApplyTheme()) || super.canApplyTheme();
    }

    public void invalidateDrawable(Drawable who) {
        Callback callback = getCallback();
        if (callback != null) {
            callback.invalidateDrawable(this);
        }
    }

    public void scheduleDrawable(Drawable who, Runnable what, long when) {
        Callback callback = getCallback();
        if (callback != null) {
            callback.scheduleDrawable(this, what, when);
        }
    }

    public void unscheduleDrawable(Drawable who, Runnable what) {
        Callback callback = getCallback();
        if (callback != null) {
            callback.unscheduleDrawable(this, what);
        }
    }

    public boolean getPadding(Rect padding) {
        return this.mState.mDrawable.getPadding(padding);
    }

    public boolean isStateful() {
        return this.mState.mDrawable.isStateful();
    }

    protected void onBoundsChange(Rect bounds) {
        this.mState.mDrawable.setBounds(bounds.left, bounds.top, bounds.right, bounds.bottom);
    }

    protected boolean onLevelChange(int level) {
        return this.mState.mDrawable.setLevel(level);
    }

    protected boolean onStateChange(int[] state) {
        return this.mState.mDrawable.setState(state);
    }

    public int getIntrinsicWidth() {
        return this.mState.mDrawable.getIntrinsicWidth();
    }

    public int getIntrinsicHeight() {
        return this.mState.mDrawable.getIntrinsicHeight();
    }

    public ConstantState getConstantState() {
        if (!this.mState.canConstantState()) {
            return null;
        }
        this.mState.mChangingConfigurations = getChangingConfigurations();
        return this.mState;
    }

    public void inflate(Resources r, XmlPullParser parser, AttributeSet attrs, Theme theme) throws XmlPullParserException, IOException {
        TypedArray a = Drawable.obtainAttributes(r, theme, attrs, R.styleable.AnimatedRotateDrawable);
        super.inflateWithAttributes(r, parser, a, 0);
        updateStateFromTypedArray(a);
        a.recycle();
        inflateChildElements(r, parser, attrs, theme);
        init();
    }

    public void applyTheme(Theme t) {
        super.applyTheme(t);
        AnimatedRotateState state = this.mState;
        if (state != null) {
            if (state.mThemeAttrs != null) {
                TypedArray a = t.resolveAttributes(state.mThemeAttrs, R.styleable.AnimatedRotateDrawable);
                try {
                    updateStateFromTypedArray(a);
                    verifyRequiredAttributes(a);
                    a.recycle();
                } catch (XmlPullParserException e) {
                    throw new RuntimeException(e);
                } catch (Throwable th) {
                    a.recycle();
                }
            }
            if (state.mDrawable != null && state.mDrawable.canApplyTheme()) {
                state.mDrawable.applyTheme(t);
            }
            init();
        }
    }

    private void updateStateFromTypedArray(TypedArray a) {
        boolean z = false;
        AnimatedRotateState state = this.mState;
        state.mChangingConfigurations |= a.getChangingConfigurations();
        state.mThemeAttrs = a.extractThemeAttrs();
        if (a.hasValue(2)) {
            TypedValue tv;
            boolean z2;
            tv = a.peekValue(2);
            if (tv.type == 6) {
                z2 = true;
            } else {
                z2 = false;
            }
            state.mPivotXRel = z2;
            state.mPivotX = state.mPivotXRel ? tv.getFraction(LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_FULL) : tv.getFloat();
        }
        if (a.hasValue(3)) {
            tv = a.peekValue(3);
            if (tv.type == 6) {
                z = true;
            }
            state.mPivotYRel = z;
            state.mPivotY = state.mPivotYRel ? tv.getFraction(LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_FULL) : tv.getFloat();
        }
        setFramesCount(a.getInt(5, state.mFramesCount));
        setFramesDuration(a.getInt(4, state.mFrameDuration));
        Drawable dr = a.getDrawable(1);
        if (dr != null) {
            state.mDrawable = dr;
            dr.setCallback(this);
        }
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void inflateChildElements(android.content.res.Resources r8, org.xmlpull.v1.XmlPullParser r9, android.util.AttributeSet r10, android.content.res.Resources.Theme r11) throws org.xmlpull.v1.XmlPullParserException, java.io.IOException {
        /*
        r7 = this;
        r2 = r7.mState;
        r0 = 0;
        r1 = r9.getDepth();
    L_0x0007:
        r3 = r9.next();
        r4 = 1;
        if (r3 == r4) goto L_0x003d;
    L_0x000e:
        r4 = 3;
        if (r3 != r4) goto L_0x0017;
    L_0x0011:
        r4 = r9.getDepth();
        if (r4 <= r1) goto L_0x003d;
    L_0x0017:
        r4 = 2;
        if (r3 != r4) goto L_0x0007;
    L_0x001a:
        r0 = android.graphics.drawable.Drawable.createFromXmlInner(r8, r9, r10, r11);
        if (r0 != 0) goto L_0x0007;
    L_0x0020:
        r4 = "AnimatedRotateDrawable";
        r5 = new java.lang.StringBuilder;
        r5.<init>();
        r6 = "Bad element under <animated-rotate>: ";
        r5 = r5.append(r6);
        r6 = r9.getName();
        r5 = r5.append(r6);
        r5 = r5.toString();
        android.util.Log.w(r4, r5);
        goto L_0x0007;
    L_0x003d:
        if (r0 == 0) goto L_0x0044;
    L_0x003f:
        r2.mDrawable = r0;
        r0.setCallback(r7);
    L_0x0044:
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.graphics.drawable.AnimatedRotateDrawable.inflateChildElements(android.content.res.Resources, org.xmlpull.v1.XmlPullParser, android.util.AttributeSet, android.content.res.Resources$Theme):void");
    }

    private void verifyRequiredAttributes(TypedArray a) throws XmlPullParserException {
        if (this.mState.mDrawable != null) {
            return;
        }
        if (this.mState.mThemeAttrs == null || this.mState.mThemeAttrs[1] == 0) {
            throw new XmlPullParserException(a.getPositionDescription() + ": <animated-rotate> tag requires a 'drawable' attribute or " + "child tag defining a drawable");
        }
    }

    public void setFramesCount(int framesCount) {
        this.mState.mFramesCount = framesCount;
        this.mIncrement = 360.0f / ((float) this.mState.mFramesCount);
    }

    public void setFramesDuration(int framesDuration) {
        this.mState.mFrameDuration = framesDuration;
    }

    public Drawable mutate() {
        if (!this.mMutated && super.mutate() == this) {
            this.mState.mDrawable.mutate();
            this.mMutated = true;
        }
        return this;
    }

    public void clearMutated() {
        super.clearMutated();
        this.mState.mDrawable.clearMutated();
        this.mMutated = false;
    }
}
