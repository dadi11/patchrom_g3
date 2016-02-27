package android.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.util.AttributeSet;
import android.view.View;
import android.view.View.MeasureSpec;
import android.view.View.OnClickListener;
import android.view.View.OnFocusChangeListener;
import android.view.WindowManager;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.inputmethod.EditorInfo;
import android.widget.LinearLayout.LayoutParams;
import com.android.internal.R;

public class TabWidget extends LinearLayout implements OnFocusChangeListener {
    private final Rect mBounds;
    private boolean mDrawBottomStrips;
    private int[] mImposedTabWidths;
    private int mImposedTabsHeight;
    private Drawable mLeftStrip;
    private Drawable mRightStrip;
    private int mSelectedTab;
    private OnTabSelectionChanged mSelectionChangedListener;
    private boolean mStripMoved;

    interface OnTabSelectionChanged {
        void onTabSelectionChanged(int i, boolean z);
    }

    private class TabClickListener implements OnClickListener {
        private final int mTabIndex;

        private TabClickListener(int tabIndex) {
            this.mTabIndex = tabIndex;
        }

        public void onClick(View v) {
            TabWidget.this.mSelectionChangedListener.onTabSelectionChanged(this.mTabIndex, true);
        }
    }

    public TabWidget(Context context) {
        this(context, null);
    }

    public TabWidget(Context context, AttributeSet attrs) {
        this(context, attrs, 16842883);
    }

    public TabWidget(Context context, AttributeSet attrs, int defStyleAttr) {
        this(context, attrs, defStyleAttr, 0);
    }

    public TabWidget(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
        this.mSelectedTab = -1;
        this.mDrawBottomStrips = true;
        this.mBounds = new Rect();
        this.mImposedTabsHeight = -1;
        TypedArray a = context.obtainStyledAttributes(attrs, R.styleable.TabWidget, defStyleAttr, defStyleRes);
        setStripEnabled(a.getBoolean(3, true));
        setLeftStripDrawable(a.getDrawable(1));
        setRightStripDrawable(a.getDrawable(2));
        a.recycle();
        initTabWidget();
    }

    protected void onSizeChanged(int w, int h, int oldw, int oldh) {
        this.mStripMoved = true;
        super.onSizeChanged(w, h, oldw, oldh);
    }

    protected int getChildDrawingOrder(int childCount, int i) {
        if (this.mSelectedTab == -1) {
            return i;
        }
        if (i == childCount - 1) {
            return this.mSelectedTab;
        }
        if (i >= this.mSelectedTab) {
            return i + 1;
        }
        return i;
    }

    private void initTabWidget() {
        setChildrenDrawingOrderEnabled(true);
        Context context = this.mContext;
        if (context.getApplicationInfo().targetSdkVersion <= 4) {
            if (this.mLeftStrip == null) {
                this.mLeftStrip = context.getDrawable(17303283);
            }
            if (this.mRightStrip == null) {
                this.mRightStrip = context.getDrawable(17303285);
            }
        } else {
            if (this.mLeftStrip == null) {
                this.mLeftStrip = context.getDrawable(17303282);
            }
            if (this.mRightStrip == null) {
                this.mRightStrip = context.getDrawable(17303284);
            }
        }
        setFocusable(true);
        setOnFocusChangeListener(this);
    }

    void measureChildBeforeLayout(View child, int childIndex, int widthMeasureSpec, int totalWidth, int heightMeasureSpec, int totalHeight) {
        if (!isMeasureWithLargestChildEnabled() && this.mImposedTabsHeight >= 0) {
            widthMeasureSpec = MeasureSpec.makeMeasureSpec(this.mImposedTabWidths[childIndex] + totalWidth, EditorInfo.IME_FLAG_NO_ENTER_ACTION);
            heightMeasureSpec = MeasureSpec.makeMeasureSpec(this.mImposedTabsHeight, EditorInfo.IME_FLAG_NO_ENTER_ACTION);
        }
        super.measureChildBeforeLayout(child, childIndex, widthMeasureSpec, totalWidth, heightMeasureSpec, totalHeight);
    }

    void measureHorizontal(int widthMeasureSpec, int heightMeasureSpec) {
        if (MeasureSpec.getMode(widthMeasureSpec) == 0) {
            super.measureHorizontal(widthMeasureSpec, heightMeasureSpec);
            return;
        }
        int unspecifiedWidth = MeasureSpec.makeMeasureSpec(0, 0);
        this.mImposedTabsHeight = -1;
        super.measureHorizontal(unspecifiedWidth, heightMeasureSpec);
        int extraWidth = getMeasuredWidth() - MeasureSpec.getSize(widthMeasureSpec);
        if (extraWidth > 0) {
            int i;
            int count = getChildCount();
            int childCount = 0;
            for (i = 0; i < count; i++) {
                if (getChildAt(i).getVisibility() != 8) {
                    childCount++;
                }
            }
            if (childCount > 0) {
                if (this.mImposedTabWidths == null || this.mImposedTabWidths.length != count) {
                    this.mImposedTabWidths = new int[count];
                }
                for (i = 0; i < count; i++) {
                    View child = getChildAt(i);
                    if (child.getVisibility() != 8) {
                        int childWidth = child.getMeasuredWidth();
                        int newWidth = Math.max(0, childWidth - (extraWidth / childCount));
                        this.mImposedTabWidths[i] = newWidth;
                        extraWidth -= childWidth - newWidth;
                        childCount--;
                        this.mImposedTabsHeight = Math.max(this.mImposedTabsHeight, child.getMeasuredHeight());
                    }
                }
            }
        }
        super.measureHorizontal(widthMeasureSpec, heightMeasureSpec);
    }

    public View getChildTabViewAt(int index) {
        return getChildAt(index);
    }

    public int getTabCount() {
        return getChildCount();
    }

    public void setDividerDrawable(Drawable drawable) {
        super.setDividerDrawable(drawable);
    }

    public void setDividerDrawable(int resId) {
        setDividerDrawable(this.mContext.getDrawable(resId));
    }

    public void setLeftStripDrawable(Drawable drawable) {
        this.mLeftStrip = drawable;
        requestLayout();
        invalidate();
    }

    public void setLeftStripDrawable(int resId) {
        setLeftStripDrawable(this.mContext.getDrawable(resId));
    }

    public void setRightStripDrawable(Drawable drawable) {
        this.mRightStrip = drawable;
        requestLayout();
        invalidate();
    }

    public void setRightStripDrawable(int resId) {
        setRightStripDrawable(this.mContext.getDrawable(resId));
    }

    public void setStripEnabled(boolean stripEnabled) {
        this.mDrawBottomStrips = stripEnabled;
        invalidate();
    }

    public boolean isStripEnabled() {
        return this.mDrawBottomStrips;
    }

    public void childDrawableStateChanged(View child) {
        if (this.mSelectedTab != -1 && getTabCount() > 0 && child == getChildTabViewAt(this.mSelectedTab)) {
            invalidate();
        }
        super.childDrawableStateChanged(child);
    }

    public void dispatchDraw(Canvas canvas) {
        super.dispatchDraw(canvas);
        if (getTabCount() != 0 && this.mDrawBottomStrips) {
            View selectedChild = getChildTabViewAt(this.mSelectedTab);
            Drawable leftStrip = this.mLeftStrip;
            Drawable rightStrip = this.mRightStrip;
            leftStrip.setState(selectedChild.getDrawableState());
            rightStrip.setState(selectedChild.getDrawableState());
            if (this.mStripMoved) {
                Rect bounds = this.mBounds;
                bounds.left = selectedChild.getLeft();
                bounds.right = selectedChild.getRight();
                int myHeight = getHeight();
                leftStrip.setBounds(Math.min(0, bounds.left - leftStrip.getIntrinsicWidth()), myHeight - leftStrip.getIntrinsicHeight(), bounds.left, myHeight);
                rightStrip.setBounds(bounds.right, myHeight - rightStrip.getIntrinsicHeight(), Math.max(getWidth(), bounds.right + rightStrip.getIntrinsicWidth()), myHeight);
                this.mStripMoved = false;
            }
            leftStrip.draw(canvas);
            rightStrip.draw(canvas);
        }
    }

    public void setCurrentTab(int index) {
        if (index >= 0 && index < getTabCount() && index != this.mSelectedTab) {
            if (this.mSelectedTab != -1) {
                getChildTabViewAt(this.mSelectedTab).setSelected(false);
            }
            this.mSelectedTab = index;
            getChildTabViewAt(this.mSelectedTab).setSelected(true);
            this.mStripMoved = true;
            if (isShown()) {
                sendAccessibilityEvent(4);
            }
        }
    }

    public boolean dispatchPopulateAccessibilityEvent(AccessibilityEvent event) {
        onPopulateAccessibilityEvent(event);
        if (this.mSelectedTab != -1) {
            View tabView = getChildTabViewAt(this.mSelectedTab);
            if (tabView != null && tabView.getVisibility() == 0) {
                return tabView.dispatchPopulateAccessibilityEvent(event);
            }
        }
        return false;
    }

    public void onInitializeAccessibilityEvent(AccessibilityEvent event) {
        super.onInitializeAccessibilityEvent(event);
        event.setClassName(TabWidget.class.getName());
        event.setItemCount(getTabCount());
        event.setCurrentItemIndex(this.mSelectedTab);
    }

    public void sendAccessibilityEventUnchecked(AccessibilityEvent event) {
        if (event.getEventType() == 8 && isFocused()) {
            event.recycle();
        } else {
            super.sendAccessibilityEventUnchecked(event);
        }
    }

    public void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo info) {
        super.onInitializeAccessibilityNodeInfo(info);
        info.setClassName(TabWidget.class.getName());
    }

    public void focusCurrentTab(int index) {
        int oldTab = this.mSelectedTab;
        setCurrentTab(index);
        if (oldTab != index) {
            getChildTabViewAt(index).requestFocus();
        }
    }

    public void setEnabled(boolean enabled) {
        super.setEnabled(enabled);
        int count = getTabCount();
        for (int i = 0; i < count; i++) {
            getChildTabViewAt(i).setEnabled(enabled);
        }
    }

    public void addView(View child) {
        if (child.getLayoutParams() == null) {
            LayoutParams lp = new LayoutParams(0, -1, WindowManager.LayoutParams.BRIGHTNESS_OVERRIDE_FULL);
            lp.setMargins(0, 0, 0, 0);
            child.setLayoutParams(lp);
        }
        child.setFocusable(true);
        child.setClickable(true);
        super.addView(child);
        child.setOnClickListener(new TabClickListener(getTabCount() - 1, null));
        child.setOnFocusChangeListener(this);
    }

    public void removeAllViews() {
        super.removeAllViews();
        this.mSelectedTab = -1;
    }

    void setTabSelectionListener(OnTabSelectionChanged listener) {
        this.mSelectionChangedListener = listener;
    }

    public void onFocusChange(View v, boolean hasFocus) {
        if (v == this && hasFocus && getTabCount() > 0 && this.mSelectedTab != -1) {
            getChildTabViewAt(this.mSelectedTab).requestFocus();
        } else if (hasFocus) {
            int numTabs = getTabCount();
            for (int i = 0; i < numTabs; i++) {
                if (getChildTabViewAt(i) == v) {
                    setCurrentTab(i);
                    this.mSelectionChangedListener.onTabSelectionChanged(i, false);
                    if (isShown()) {
                        sendAccessibilityEvent(8);
                        return;
                    }
                    return;
                }
            }
        }
    }
}
