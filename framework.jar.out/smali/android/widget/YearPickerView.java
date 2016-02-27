package android.widget;

import android.content.Context;
import android.content.res.Resources;
import android.util.AttributeSet;
import android.view.View;
import android.view.ViewGroup;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.widget.AbsListView.LayoutParams;
import android.widget.AdapterView.OnItemClickListener;
import java.util.Calendar;

class YearPickerView extends ListView implements OnItemClickListener, OnDateChangedListener {
    private final YearAdapter mAdapter;
    private final int mChildSize;
    private DatePickerController mController;
    private final Calendar mMaxDate;
    private final Calendar mMinDate;
    private int mSelectedPosition;
    private final int mViewSize;
    private int mYearSelectedCircleColor;

    /* renamed from: android.widget.YearPickerView.1 */
    class C11011 implements Runnable {
        final /* synthetic */ int val$offset;
        final /* synthetic */ int val$position;

        C11011(int i, int i2) {
            this.val$position = i;
            this.val$offset = i2;
        }

        public void run() {
            YearPickerView.this.setSelectionFromTop(this.val$position, this.val$offset);
            YearPickerView.this.requestLayout();
        }
    }

    private class YearAdapter extends ArrayAdapter<Integer> {
        int mItemTextAppearanceResId;

        public YearAdapter(Context context, int resource) {
            super(context, resource);
        }

        public View getView(int position, View convertView, ViewGroup parent) {
            boolean selected = true;
            TextViewWithCircularIndicator v = (TextViewWithCircularIndicator) super.getView(position, convertView, parent);
            v.setTextAppearance(getContext(), this.mItemTextAppearanceResId);
            v.requestLayout();
            if (YearPickerView.this.mController.getSelectedDay().get(1) != ((Integer) getItem(position)).intValue()) {
                selected = false;
            }
            v.setDrawIndicator(selected);
            if (selected) {
                v.setCircleColor(YearPickerView.this.mYearSelectedCircleColor);
            }
            return v;
        }

        public void setItemTextAppearance(int resId) {
            this.mItemTextAppearanceResId = resId;
        }
    }

    public YearPickerView(Context context) {
        this(context, null);
    }

    public YearPickerView(Context context, AttributeSet attrs) {
        this(context, attrs, 16842868);
    }

    public YearPickerView(Context context, AttributeSet attrs, int defStyleAttr) {
        this(context, attrs, defStyleAttr, 0);
    }

    public YearPickerView(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
        this.mMinDate = Calendar.getInstance();
        this.mMaxDate = Calendar.getInstance();
        this.mSelectedPosition = -1;
        setLayoutParams(new LayoutParams(-1, -2));
        Resources res = context.getResources();
        this.mViewSize = res.getDimensionPixelOffset(17105041);
        this.mChildSize = res.getDimensionPixelOffset(17105043);
        setVerticalFadingEdgeEnabled(true);
        setFadingEdgeLength(this.mChildSize / 3);
        setPadding(0, res.getDimensionPixelSize(17105042), 0, 0);
        setOnItemClickListener(this);
        setDividerHeight(0);
        this.mAdapter = new YearAdapter(getContext(), 17367281);
        setAdapter(this.mAdapter);
    }

    public void setRange(Calendar min, Calendar max) {
        this.mMinDate.setTimeInMillis(min.getTimeInMillis());
        this.mMaxDate.setTimeInMillis(max.getTimeInMillis());
        updateAdapterData();
    }

    public void init(DatePickerController controller) {
        this.mController = controller;
        this.mController.registerOnDateChangedListener(this);
        updateAdapterData();
        onDateChanged();
    }

    public void setYearSelectedCircleColor(int color) {
        if (color != this.mYearSelectedCircleColor) {
            this.mYearSelectedCircleColor = color;
        }
        requestLayout();
    }

    public int getYearSelectedCircleColor() {
        return this.mYearSelectedCircleColor;
    }

    private void updateAdapterData() {
        this.mAdapter.clear();
        int maxYear = this.mMaxDate.get(1);
        for (int year = this.mMinDate.get(1); year <= maxYear; year++) {
            this.mAdapter.add(Integer.valueOf(year));
        }
    }

    public void onItemClick(AdapterView<?> adapterView, View view, int position, long id) {
        this.mController.tryVibrate();
        if (position != this.mSelectedPosition) {
            this.mSelectedPosition = position;
            this.mAdapter.notifyDataSetChanged();
        }
        this.mController.onYearSelected(((Integer) this.mAdapter.getItem(position)).intValue());
    }

    void setItemTextAppearance(int resId) {
        this.mAdapter.setItemTextAppearance(resId);
    }

    public void postSetSelectionCentered(int position) {
        postSetSelectionFromTop(position, (this.mViewSize / 2) - (this.mChildSize / 2));
    }

    public void postSetSelectionFromTop(int position, int offset) {
        post(new C11011(position, offset));
    }

    public int getFirstPositionOffset() {
        View firstChild = getChildAt(0);
        if (firstChild == null) {
            return 0;
        }
        return firstChild.getTop();
    }

    public void onDateChanged() {
        updateAdapterData();
        this.mAdapter.notifyDataSetChanged();
        postSetSelectionCentered(this.mController.getSelectedDay().get(1) - this.mMinDate.get(1));
    }

    public void onInitializeAccessibilityEvent(AccessibilityEvent event) {
        super.onInitializeAccessibilityEvent(event);
        if (event.getEventType() == AccessibilityNodeInfo.ACTION_SCROLL_FORWARD) {
            event.setFromIndex(0);
            event.setToIndex(0);
        }
    }
}
