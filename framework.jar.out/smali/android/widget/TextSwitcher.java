package android.widget;

import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import android.view.ViewGroup.LayoutParams;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;

public class TextSwitcher extends ViewSwitcher {
    public TextSwitcher(Context context) {
        super(context);
    }

    public TextSwitcher(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public void addView(View child, int index, LayoutParams params) {
        if (child instanceof TextView) {
            super.addView(child, index, params);
            return;
        }
        throw new IllegalArgumentException("TextSwitcher children must be instances of TextView");
    }

    public void setText(CharSequence text) {
        ((TextView) getNextView()).setText(text);
        showNext();
    }

    public void setCurrentText(CharSequence text) {
        ((TextView) getCurrentView()).setText(text);
    }

    public void onInitializeAccessibilityEvent(AccessibilityEvent event) {
        super.onInitializeAccessibilityEvent(event);
        event.setClassName(TextSwitcher.class.getName());
    }

    public void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo info) {
        super.onInitializeAccessibilityNodeInfo(info);
        info.setClassName(TextSwitcher.class.getName());
    }
}
