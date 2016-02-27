package android.widget;

import android.content.Context;
import android.content.res.Configuration;
import android.content.res.TypedArray;
import android.graphics.drawable.Drawable;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.util.MathUtils;
import android.widget.CalendarView.OnDateChangeListener;
import android.widget.DayPickerView.OnDaySelectedListener;
import com.android.internal.R;
import java.util.Calendar;
import java.util.Locale;
import libcore.icu.LocaleData;

class CalendarViewMaterialDelegate extends AbstractCalendarViewDelegate {
    private final DayPickerView mDayPickerView;
    private OnDateChangeListener mOnDateChangeListener;
    private final OnDaySelectedListener mOnDaySelectedListener;

    /* renamed from: android.widget.CalendarViewMaterialDelegate.1 */
    class C09481 implements OnDaySelectedListener {
        C09481() {
        }

        public void onDaySelected(DayPickerView view, Calendar day) {
            if (CalendarViewMaterialDelegate.this.mOnDateChangeListener != null) {
                CalendarViewMaterialDelegate.this.mOnDateChangeListener.onSelectedDayChange(CalendarViewMaterialDelegate.this.mDelegator, day.get(1), day.get(2), day.get(5));
            }
        }
    }

    public CalendarViewMaterialDelegate(CalendarView delegator, Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(delegator, context);
        this.mOnDaySelectedListener = new C09481();
        TypedArray a = context.obtainStyledAttributes(attrs, R.styleable.CalendarView, defStyleAttr, defStyleRes);
        int firstDayOfWeek = a.getInt(0, LocaleData.get(Locale.getDefault()).firstDayOfWeek.intValue());
        long minDate = parseDateToMillis(a.getString(2), "01/01/1900");
        long maxDate = parseDateToMillis(a.getString(3), "01/01/2100");
        if (maxDate < minDate) {
            throw new IllegalArgumentException("max date cannot be before min date");
        }
        long setDate = MathUtils.constrain(System.currentTimeMillis(), minDate, maxDate);
        int dateTextAppearanceResId = a.getResourceId(12, 16974259);
        a.recycle();
        this.mDayPickerView = new DayPickerView(context);
        this.mDayPickerView.setFirstDayOfWeek(firstDayOfWeek);
        this.mDayPickerView.setCalendarTextAppearance(dateTextAppearanceResId);
        this.mDayPickerView.setMinDate(minDate);
        this.mDayPickerView.setMaxDate(maxDate);
        this.mDayPickerView.setDate(setDate, false, true);
        this.mDayPickerView.setOnDaySelectedListener(this.mOnDaySelectedListener);
        delegator.addView(this.mDayPickerView);
    }

    private long parseDateToMillis(String dateStr, String defaultDateStr) {
        Calendar tempCalendar = Calendar.getInstance();
        if (TextUtils.isEmpty(dateStr) || !parseDate(dateStr, tempCalendar)) {
            parseDate(defaultDateStr, tempCalendar);
        }
        return tempCalendar.getTimeInMillis();
    }

    public void setShownWeekCount(int count) {
    }

    public int getShownWeekCount() {
        return 0;
    }

    public void setSelectedWeekBackgroundColor(int color) {
    }

    public int getSelectedWeekBackgroundColor() {
        return 0;
    }

    public void setFocusedMonthDateColor(int color) {
    }

    public int getFocusedMonthDateColor() {
        return 0;
    }

    public void setUnfocusedMonthDateColor(int color) {
    }

    public int getUnfocusedMonthDateColor() {
        return 0;
    }

    public void setWeekDayTextAppearance(int resourceId) {
    }

    public int getWeekDayTextAppearance() {
        return 0;
    }

    public void setDateTextAppearance(int resourceId) {
    }

    public int getDateTextAppearance() {
        return 0;
    }

    public void setWeekNumberColor(int color) {
    }

    public int getWeekNumberColor() {
        return 0;
    }

    public void setWeekSeparatorLineColor(int color) {
    }

    public int getWeekSeparatorLineColor() {
        return 0;
    }

    public void setSelectedDateVerticalBar(int resourceId) {
    }

    public void setSelectedDateVerticalBar(Drawable drawable) {
    }

    public Drawable getSelectedDateVerticalBar() {
        return null;
    }

    public void setMinDate(long minDate) {
        this.mDayPickerView.setMinDate(minDate);
    }

    public long getMinDate() {
        return this.mDayPickerView.getMinDate();
    }

    public void setMaxDate(long maxDate) {
        this.mDayPickerView.setMaxDate(maxDate);
    }

    public long getMaxDate() {
        return this.mDayPickerView.getMaxDate();
    }

    public void setShowWeekNumber(boolean showWeekNumber) {
    }

    public boolean getShowWeekNumber() {
        return false;
    }

    public void setFirstDayOfWeek(int firstDayOfWeek) {
        this.mDayPickerView.setFirstDayOfWeek(firstDayOfWeek);
    }

    public int getFirstDayOfWeek() {
        return this.mDayPickerView.getFirstDayOfWeek();
    }

    public void setDate(long date) {
        this.mDayPickerView.setDate(date, true, false);
    }

    public void setDate(long date, boolean animate, boolean center) {
        this.mDayPickerView.setDate(date, animate, center);
    }

    public long getDate() {
        return this.mDayPickerView.getDate();
    }

    public void setOnDateChangeListener(OnDateChangeListener listener) {
        this.mOnDateChangeListener = listener;
    }

    public void onConfigurationChanged(Configuration newConfig) {
    }
}
