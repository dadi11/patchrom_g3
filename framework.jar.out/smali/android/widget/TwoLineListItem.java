package android.widget;

import android.C0000R;
import android.content.Context;
import android.util.AttributeSet;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import com.android.internal.R;

@Deprecated
public class TwoLineListItem extends RelativeLayout {
    private TextView mText1;
    private TextView mText2;

    public TwoLineListItem(Context context) {
        this(context, null, 0);
    }

    public TwoLineListItem(Context context, AttributeSet attrs) {
        this(context, attrs, 0);
    }

    public TwoLineListItem(Context context, AttributeSet attrs, int defStyleAttr) {
        this(context, attrs, defStyleAttr, 0);
    }

    public TwoLineListItem(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
        context.obtainStyledAttributes(attrs, R.styleable.TwoLineListItem, defStyleAttr, defStyleRes).recycle();
    }

    protected void onFinishInflate() {
        super.onFinishInflate();
        this.mText1 = (TextView) findViewById(C0000R.id.text1);
        this.mText2 = (TextView) findViewById(C0000R.id.text2);
    }

    public TextView getText1() {
        return this.mText1;
    }

    public TextView getText2() {
        return this.mText2;
    }

    public void onInitializeAccessibilityEvent(AccessibilityEvent event) {
        super.onInitializeAccessibilityEvent(event);
        event.setClassName(TwoLineListItem.class.getName());
    }

    public void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo info) {
        super.onInitializeAccessibilityNodeInfo(info);
        info.setClassName(TwoLineListItem.class.getName());
    }
}
