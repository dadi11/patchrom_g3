package android.widget;

import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.view.WindowManager.LayoutParams;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.animation.AlphaAnimation;

public class ZoomControls extends LinearLayout {
    private final ZoomButton mZoomIn;
    private final ZoomButton mZoomOut;

    public ZoomControls(Context context) {
        this(context, null);
    }

    public ZoomControls(Context context, AttributeSet attrs) {
        super(context, attrs);
        setFocusable(false);
        ((LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE)).inflate(17367284, (ViewGroup) this, true);
        this.mZoomIn = (ZoomButton) findViewById(16909277);
        this.mZoomOut = (ZoomButton) findViewById(16909276);
    }

    public void setOnZoomInClickListener(OnClickListener listener) {
        this.mZoomIn.setOnClickListener(listener);
    }

    public void setOnZoomOutClickListener(OnClickListener listener) {
        this.mZoomOut.setOnClickListener(listener);
    }

    public void setZoomSpeed(long speed) {
        this.mZoomIn.setZoomSpeed(speed);
        this.mZoomOut.setZoomSpeed(speed);
    }

    public boolean onTouchEvent(MotionEvent event) {
        return true;
    }

    public void show() {
        fade(0, 0.0f, LayoutParams.BRIGHTNESS_OVERRIDE_FULL);
    }

    public void hide() {
        fade(8, LayoutParams.BRIGHTNESS_OVERRIDE_FULL, 0.0f);
    }

    private void fade(int visibility, float startAlpha, float endAlpha) {
        AlphaAnimation anim = new AlphaAnimation(startAlpha, endAlpha);
        anim.setDuration(500);
        startAnimation(anim);
        setVisibility(visibility);
    }

    public void setIsZoomInEnabled(boolean isEnabled) {
        this.mZoomIn.setEnabled(isEnabled);
    }

    public void setIsZoomOutEnabled(boolean isEnabled) {
        this.mZoomOut.setEnabled(isEnabled);
    }

    public boolean hasFocus() {
        return this.mZoomIn.hasFocus() || this.mZoomOut.hasFocus();
    }

    public void onInitializeAccessibilityEvent(AccessibilityEvent event) {
        super.onInitializeAccessibilityEvent(event);
        event.setClassName(ZoomControls.class.getName());
    }

    public void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo info) {
        super.onInitializeAccessibilityNodeInfo(info);
        info.setClassName(ZoomControls.class.getName());
    }
}
