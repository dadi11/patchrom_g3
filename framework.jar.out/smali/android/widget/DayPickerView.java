package android.widget;

import android.content.Context;
import android.content.res.ColorStateList;
import android.content.res.Configuration;
import android.os.Bundle;
import android.util.Log;
import android.util.MathUtils;
import android.view.View;
import android.view.ViewConfiguration;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.accessibility.AccessibilityNodeInfo.AccessibilityAction;
import android.widget.AbsListView.LayoutParams;
import android.widget.AbsListView.OnScrollListener;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;

class DayPickerView extends ListView implements OnScrollListener {
    private static final int GOTO_SCROLL_DURATION = 250;
    private static final int LIST_TOP_OFFSET = -1;
    private static final int SCROLL_CHANGE_DELAY = 40;
    private static final String TAG = "DayPickerView";
    private final SimpleMonthAdapter mAdapter;
    private int mCurrentMonthDisplayed;
    private int mCurrentScrollState;
    private Calendar mMaxDate;
    private Calendar mMinDate;
    private OnDaySelectedListener mOnDaySelectedListener;
    private boolean mPerformingScroll;
    private int mPreviousScrollState;
    private final android.widget.SimpleMonthAdapter.OnDaySelectedListener mProxyOnDaySelectedListener;
    private final ScrollStateRunnable mScrollStateChangedRunnable;
    private Calendar mSelectedDay;
    private Calendar mTempCalendar;
    private Calendar mTempDay;
    private SimpleDateFormat mYearFormat;

    public interface OnDaySelectedListener {
        void onDaySelected(DayPickerView dayPickerView, Calendar calendar);
    }

    /* renamed from: android.widget.DayPickerView.1 */
    class C09631 implements Runnable {
        final /* synthetic */ int val$position;

        C09631(int i) {
            this.val$position = i;
        }

        public void run() {
            DayPickerView.this.setSelection(this.val$position);
        }
    }

    /* renamed from: android.widget.DayPickerView.2 */
    class C09642 implements android.widget.SimpleMonthAdapter.OnDaySelectedListener {
        C09642() {
        }

        public void onDaySelected(SimpleMonthAdapter adapter, Calendar day) {
            if (DayPickerView.this.mOnDaySelectedListener != null) {
                DayPickerView.this.mOnDaySelectedListener.onDaySelected(DayPickerView.this, day);
            }
        }
    }

    protected class ScrollStateRunnable implements Runnable {
        private int mNewState;
        private View mParent;

        ScrollStateRunnable(View view) {
            this.mParent = view;
        }

        public void doScrollStateChange(AbsListView view, int scrollState) {
            this.mParent.removeCallbacks(this);
            this.mNewState = scrollState;
            this.mParent.postDelayed(this, 40);
        }

        public void run() {
            boolean scroll = true;
            DayPickerView.this.mCurrentScrollState = this.mNewState;
            if (Log.isLoggable(DayPickerView.TAG, 3)) {
                Log.d(DayPickerView.TAG, "new scroll state: " + this.mNewState + " old state: " + DayPickerView.this.mPreviousScrollState);
            }
            if (this.mNewState != 0 || DayPickerView.this.mPreviousScrollState == 0 || DayPickerView.this.mPreviousScrollState == 1) {
                DayPickerView.this.mPreviousScrollState = this.mNewState;
                return;
            }
            DayPickerView.this.mPreviousScrollState = this.mNewState;
            int i = 0;
            View child = DayPickerView.this.getChildAt(0);
            while (child != null && child.getBottom() <= 0) {
                i++;
                child = DayPickerView.this.getChildAt(i);
            }
            if (child != null) {
                int firstPosition = DayPickerView.this.getFirstVisiblePosition();
                int lastPosition = DayPickerView.this.getLastVisiblePosition();
                if (firstPosition == 0 || lastPosition == DayPickerView.this.getCount() + DayPickerView.LIST_TOP_OFFSET) {
                    scroll = false;
                }
                int top = child.getTop();
                int bottom = child.getBottom();
                int midpoint = DayPickerView.this.getHeight() / 2;
                if (scroll && top < DayPickerView.LIST_TOP_OFFSET) {
                    if (bottom > midpoint) {
                        DayPickerView.this.smoothScrollBy(top, DayPickerView.GOTO_SCROLL_DURATION);
                    } else {
                        DayPickerView.this.smoothScrollBy(bottom, DayPickerView.GOTO_SCROLL_DURATION);
                    }
                }
            }
        }
    }

    public DayPickerView(Context context) {
        super(context);
        this.mAdapter = new SimpleMonthAdapter(getContext());
        this.mScrollStateChangedRunnable = new ScrollStateRunnable(this);
        this.mYearFormat = new SimpleDateFormat("yyyy", Locale.getDefault());
        this.mSelectedDay = Calendar.getInstance();
        this.mTempDay = Calendar.getInstance();
        this.mMinDate = Calendar.getInstance();
        this.mMaxDate = Calendar.getInstance();
        this.mPreviousScrollState = 0;
        this.mCurrentScrollState = 0;
        this.mProxyOnDaySelectedListener = new C09642();
        setAdapter(this.mAdapter);
        setLayoutParams(new LayoutParams((int) LIST_TOP_OFFSET, (int) LIST_TOP_OFFSET));
        setDrawSelectorOnTop(false);
        setUpListView();
        goTo(this.mSelectedDay.getTimeInMillis(), false, false, true);
        this.mAdapter.setOnDaySelectedListener(this.mProxyOnDaySelectedListener);
    }

    public void setDate(long timeInMillis) {
        setDate(timeInMillis, false, true);
    }

    public void setDate(long timeInMillis, boolean animate, boolean forceScroll) {
        goTo(timeInMillis, animate, true, forceScroll);
    }

    public long getDate() {
        return this.mSelectedDay.getTimeInMillis();
    }

    public void setFirstDayOfWeek(int firstDayOfWeek) {
        this.mAdapter.setFirstDayOfWeek(firstDayOfWeek);
    }

    public int getFirstDayOfWeek() {
        return this.mAdapter.getFirstDayOfWeek();
    }

    public void setMinDate(long timeInMillis) {
        this.mMinDate.setTimeInMillis(timeInMillis);
        onRangeChanged();
    }

    public long getMinDate() {
        return this.mMinDate.getTimeInMillis();
    }

    public void setMaxDate(long timeInMillis) {
        this.mMaxDate.setTimeInMillis(timeInMillis);
        onRangeChanged();
    }

    public long getMaxDate() {
        return this.mMaxDate.getTimeInMillis();
    }

    public void onRangeChanged() {
        this.mAdapter.setRange(this.mMinDate, this.mMaxDate);
        goTo(this.mSelectedDay.getTimeInMillis(), false, false, true);
    }

    public void setOnDaySelectedListener(OnDaySelectedListener listener) {
        this.mOnDaySelectedListener = listener;
    }

    private void setUpListView() {
        setCacheColorHint(0);
        setDivider(null);
        setItemsCanFocus(true);
        setFastScrollEnabled(false);
        setVerticalScrollBarEnabled(false);
        setOnScrollListener(this);
        setFadingEdgeLength(0);
        setFriction(ViewConfiguration.getScrollFriction());
    }

    private int getDiffMonths(Calendar start, Calendar end) {
        return (end.get(2) - start.get(2)) + ((end.get(1) - start.get(1)) * 12);
    }

    private int getPositionFromDay(long timeInMillis) {
        return MathUtils.constrain(getDiffMonths(this.mMinDate, getTempCalendarForTime(timeInMillis)), 0, getDiffMonths(this.mMinDate, this.mMaxDate));
    }

    private Calendar getTempCalendarForTime(long timeInMillis) {
        if (this.mTempCalendar == null) {
            this.mTempCalendar = Calendar.getInstance();
        }
        this.mTempCalendar.setTimeInMillis(timeInMillis);
        return this.mTempCalendar;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private boolean goTo(long r10, boolean r12, boolean r13, boolean r14) {
        /*
        r9 = this;
        if (r13 == 0) goto L_0x0007;
    L_0x0002:
        r6 = r9.mSelectedDay;
        r6.setTimeInMillis(r10);
    L_0x0007:
        r6 = r9.mTempDay;
        r6.setTimeInMillis(r10);
        r3 = r9.getPositionFromDay(r10);
        r1 = 0;
        r5 = 0;
    L_0x0012:
        r2 = r1 + 1;
        r0 = r9.getChildAt(r1);
        if (r0 != 0) goto L_0x003f;
    L_0x001a:
        if (r0 == 0) goto L_0x0047;
    L_0x001c:
        r4 = r9.getPositionForView(r0);
    L_0x0020:
        if (r13 == 0) goto L_0x0029;
    L_0x0022:
        r6 = r9.mAdapter;
        r7 = r9.mSelectedDay;
        r6.setSelectedDay(r7);
    L_0x0029:
        if (r3 != r4) goto L_0x002d;
    L_0x002b:
        if (r14 == 0) goto L_0x004e;
    L_0x002d:
        r6 = r9.mTempDay;
        r9.setMonthDisplayed(r6);
        r6 = 2;
        r9.mPreviousScrollState = r6;
        if (r12 == 0) goto L_0x0049;
    L_0x0037:
        r6 = -1;
        r7 = 250; // 0xfa float:3.5E-43 double:1.235E-321;
        r9.smoothScrollToPositionFromTop(r3, r6, r7);
        r6 = 1;
    L_0x003e:
        return r6;
    L_0x003f:
        r5 = r0.getTop();
        if (r5 >= 0) goto L_0x001a;
    L_0x0045:
        r1 = r2;
        goto L_0x0012;
    L_0x0047:
        r4 = 0;
        goto L_0x0020;
    L_0x0049:
        r9.postSetSelection(r3);
    L_0x004c:
        r6 = 0;
        goto L_0x003e;
    L_0x004e:
        if (r13 == 0) goto L_0x004c;
    L_0x0050:
        r6 = r9.mSelectedDay;
        r9.setMonthDisplayed(r6);
        goto L_0x004c;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.widget.DayPickerView.goTo(long, boolean, boolean, boolean):boolean");
    }

    public void postSetSelection(int position) {
        clearFocus();
        post(new C09631(position));
        onScrollStateChanged(this, 0);
    }

    public void onScroll(AbsListView view, int firstVisibleItem, int visibleItemCount, int totalItemCount) {
        if (((SimpleMonthView) view.getChildAt(0)) != null) {
            this.mPreviousScrollState = this.mCurrentScrollState;
        }
    }

    protected void setMonthDisplayed(Calendar date) {
        if (this.mCurrentMonthDisplayed != date.get(2)) {
            this.mCurrentMonthDisplayed = date.get(2);
            invalidateViews();
        }
    }

    public void onScrollStateChanged(AbsListView view, int scrollState) {
        this.mScrollStateChangedRunnable.doScrollStateChange(view, scrollState);
    }

    void setCalendarTextColor(ColorStateList colors) {
        this.mAdapter.setCalendarTextColor(colors);
    }

    void setCalendarTextAppearance(int resId) {
        this.mAdapter.setCalendarTextAppearance(resId);
    }

    public int getMostVisiblePosition() {
        int firstPosition = getFirstVisiblePosition();
        int height = getHeight();
        int maxDisplayedHeight = 0;
        int mostVisibleIndex = 0;
        int i = 0;
        int bottom = 0;
        while (bottom < height) {
            View child = getChildAt(i);
            if (child == null) {
                break;
            }
            bottom = child.getBottom();
            int displayedHeight = Math.min(bottom, height) - Math.max(0, child.getTop());
            if (displayedHeight > maxDisplayedHeight) {
                mostVisibleIndex = i;
                maxDisplayedHeight = displayedHeight;
            }
            i++;
        }
        return firstPosition + mostVisibleIndex;
    }

    private Calendar findAccessibilityFocus() {
        int childCount = getChildCount();
        for (int i = 0; i < childCount; i++) {
            View child = getChildAt(i);
            if (child instanceof SimpleMonthView) {
                Calendar focus = ((SimpleMonthView) child).getAccessibilityFocus();
                if (focus != null) {
                    return focus;
                }
            }
        }
        return null;
    }

    private boolean restoreAccessibilityFocus(Calendar day) {
        if (day == null) {
            return false;
        }
        int childCount = getChildCount();
        for (int i = 0; i < childCount; i++) {
            View child = getChildAt(i);
            if ((child instanceof SimpleMonthView) && ((SimpleMonthView) child).restoreAccessibilityFocus(day)) {
                return true;
            }
        }
        return false;
    }

    protected void layoutChildren() {
        Calendar focusedDay = findAccessibilityFocus();
        super.layoutChildren();
        if (this.mPerformingScroll) {
            this.mPerformingScroll = false;
        } else {
            restoreAccessibilityFocus(focusedDay);
        }
    }

    protected void onConfigurationChanged(Configuration newConfig) {
        this.mYearFormat = new SimpleDateFormat("yyyy", Locale.getDefault());
    }

    public void onInitializeAccessibilityEvent(AccessibilityEvent event) {
        super.onInitializeAccessibilityEvent(event);
        event.setItemCount(LIST_TOP_OFFSET);
    }

    private String getMonthAndYearString(Calendar day) {
        StringBuilder sbuf = new StringBuilder();
        sbuf.append(day.getDisplayName(2, 2, Locale.getDefault()));
        sbuf.append(" ");
        sbuf.append(this.mYearFormat.format(day.getTime()));
        return sbuf.toString();
    }

    public void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo info) {
        super.onInitializeAccessibilityNodeInfo(info);
        info.addAction(AccessibilityAction.ACTION_SCROLL_FORWARD);
        info.addAction(AccessibilityAction.ACTION_SCROLL_BACKWARD);
    }

    public boolean performAccessibilityAction(int action, Bundle arguments) {
        if (action != AccessibilityNodeInfo.ACTION_SCROLL_FORWARD && action != AccessibilityNodeInfo.ACTION_SCROLL_BACKWARD) {
            return super.performAccessibilityAction(action, arguments);
        }
        int firstVisiblePosition = getFirstVisiblePosition();
        int month = firstVisiblePosition % 12;
        int year = (firstVisiblePosition / 12) + this.mMinDate.get(1);
        Calendar day = Calendar.getInstance();
        day.set(year, month, 1);
        if (action == AccessibilityNodeInfo.ACTION_SCROLL_FORWARD) {
            day.add(2, 1);
            if (day.get(2) == 12) {
                day.set(2, 0);
                day.add(1, 1);
            }
        } else if (action == AccessibilityNodeInfo.ACTION_SCROLL_BACKWARD) {
            View firstVisibleView = getChildAt(0);
            if (firstVisibleView != null && firstVisibleView.getTop() >= LIST_TOP_OFFSET) {
                day.add(2, LIST_TOP_OFFSET);
                if (day.get(2) == LIST_TOP_OFFSET) {
                    day.set(2, 11);
                    day.add(1, LIST_TOP_OFFSET);
                }
            }
        }
        announceForAccessibility(getMonthAndYearString(day));
        goTo(day.getTimeInMillis(), true, false, true);
        this.mPerformingScroll = true;
        return true;
    }
}
