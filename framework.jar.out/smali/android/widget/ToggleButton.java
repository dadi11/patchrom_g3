package android.widget;

import android.C0000R;
import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.LayerDrawable;
import android.util.AttributeSet;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import com.android.internal.R;

public class ToggleButton extends CompoundButton {
    private static final int NO_ALPHA = 255;
    private float mDisabledAlpha;
    private Drawable mIndicatorDrawable;
    private CharSequence mTextOff;
    private CharSequence mTextOn;

    public ToggleButton(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
        TypedArray a = context.obtainStyledAttributes(attrs, R.styleable.ToggleButton, defStyleAttr, defStyleRes);
        this.mTextOn = a.getText(1);
        this.mTextOff = a.getText(2);
        this.mDisabledAlpha = a.getFloat(0, 0.5f);
        syncTextState();
        a.recycle();
    }

    public ToggleButton(Context context, AttributeSet attrs, int defStyleAttr) {
        this(context, attrs, defStyleAttr, 0);
    }

    public ToggleButton(Context context, AttributeSet attrs) {
        this(context, attrs, 16842827);
    }

    public ToggleButton(Context context) {
        this(context, null);
    }

    public void setChecked(boolean checked) {
        super.setChecked(checked);
        syncTextState();
    }

    private void syncTextState() {
        boolean checked = isChecked();
        if (checked && this.mTextOn != null) {
            setText(this.mTextOn);
        } else if (!checked && this.mTextOff != null) {
            setText(this.mTextOff);
        }
    }

    public CharSequence getTextOn() {
        return this.mTextOn;
    }

    public void setTextOn(CharSequence textOn) {
        this.mTextOn = textOn;
    }

    public CharSequence getTextOff() {
        return this.mTextOff;
    }

    public void setTextOff(CharSequence textOff) {
        this.mTextOff = textOff;
    }

    protected void onFinishInflate() {
        super.onFinishInflate();
        updateReferenceToIndicatorDrawable(getBackground());
    }

    public void setBackgroundDrawable(Drawable d) {
        super.setBackgroundDrawable(d);
        updateReferenceToIndicatorDrawable(d);
    }

    private void updateReferenceToIndicatorDrawable(Drawable backgroundDrawable) {
        if (backgroundDrawable instanceof LayerDrawable) {
            this.mIndicatorDrawable = ((LayerDrawable) backgroundDrawable).findDrawableByLayerId(C0000R.id.toggle);
        } else {
            this.mIndicatorDrawable = null;
        }
    }

    protected void drawableStateChanged() {
        super.drawableStateChanged();
        if (this.mIndicatorDrawable != null) {
            this.mIndicatorDrawable.setAlpha(isEnabled() ? NO_ALPHA : (int) (255.0f * this.mDisabledAlpha));
        }
    }

    public void onInitializeAccessibilityEvent(AccessibilityEvent event) {
        super.onInitializeAccessibilityEvent(event);
        event.setClassName(ToggleButton.class.getName());
    }

    public void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo info) {
        super.onInitializeAccessibilityNodeInfo(info);
        info.setClassName(ToggleButton.class.getName());
    }
}
