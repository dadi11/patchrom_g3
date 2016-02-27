package android.widget;

import android.content.Context;
import android.content.res.ColorStateList;
import android.content.res.TypedArray;
import android.text.Spanned;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView.LayoutParams;
import android.widget.SimpleMonthView.OnDayClickListener;
import com.android.internal.R;
import java.util.Calendar;

class SimpleMonthAdapter extends BaseAdapter {
    private ColorStateList mCalendarTextColors;
    private final Context mContext;
    private int mFirstDayOfWeek;
    private final Calendar mMaxDate;
    private final Calendar mMinDate;
    private final OnDayClickListener mOnDayClickListener;
    private OnDaySelectedListener mOnDaySelectedListener;
    private Calendar mSelectedDay;

    public interface OnDaySelectedListener {
        void onDaySelected(SimpleMonthAdapter simpleMonthAdapter, Calendar calendar);
    }

    /* renamed from: android.widget.SimpleMonthAdapter.1 */
    class C10471 implements OnDayClickListener {
        C10471() {
        }

        public void onDayClick(SimpleMonthView view, Calendar day) {
            if (day != null && SimpleMonthAdapter.this.isCalendarInRange(day)) {
                SimpleMonthAdapter.this.setSelectedDay(day);
                if (SimpleMonthAdapter.this.mOnDaySelectedListener != null) {
                    SimpleMonthAdapter.this.mOnDaySelectedListener.onDaySelected(SimpleMonthAdapter.this, day);
                }
            }
        }
    }

    public SimpleMonthAdapter(Context context) {
        this.mMinDate = Calendar.getInstance();
        this.mMaxDate = Calendar.getInstance();
        this.mSelectedDay = Calendar.getInstance();
        this.mCalendarTextColors = ColorStateList.valueOf(Spanned.SPAN_USER);
        this.mOnDayClickListener = new C10471();
        this.mContext = context;
    }

    public void setRange(Calendar min, Calendar max) {
        this.mMinDate.setTimeInMillis(min.getTimeInMillis());
        this.mMaxDate.setTimeInMillis(max.getTimeInMillis());
        notifyDataSetInvalidated();
    }

    public void setFirstDayOfWeek(int firstDayOfWeek) {
        this.mFirstDayOfWeek = firstDayOfWeek;
        notifyDataSetInvalidated();
    }

    public int getFirstDayOfWeek() {
        return this.mFirstDayOfWeek;
    }

    public void setSelectedDay(Calendar day) {
        this.mSelectedDay = day;
        notifyDataSetChanged();
    }

    public void setOnDaySelectedListener(OnDaySelectedListener listener) {
        this.mOnDaySelectedListener = listener;
    }

    void setCalendarTextColor(ColorStateList colors) {
        this.mCalendarTextColors = colors;
    }

    void setCalendarTextAppearance(int resId) {
        TypedArray a = this.mContext.obtainStyledAttributes(resId, R.styleable.TextAppearance);
        ColorStateList textColor = a.getColorStateList(3);
        if (textColor != null) {
            this.mCalendarTextColors = textColor;
        }
        a.recycle();
    }

    public int getCount() {
        return (((this.mMaxDate.get(1) - this.mMinDate.get(1)) * 12) + (this.mMaxDate.get(2) - this.mMinDate.get(2))) + 1;
    }

    public Object getItem(int position) {
        return null;
    }

    public long getItemId(int position) {
        return (long) position;
    }

    public boolean hasStableIds() {
        return true;
    }

    public View getView(int position, View convertView, ViewGroup parent) {
        SimpleMonthView v;
        int selectedDay;
        int enabledDayRangeStart;
        int enabledDayRangeEnd;
        if (convertView != null) {
            v = (SimpleMonthView) convertView;
        } else {
            v = new SimpleMonthView(this.mContext);
            v.setLayoutParams(new LayoutParams(-1, -1));
            v.setClickable(true);
            v.setOnDayClickListener(this.mOnDayClickListener);
            if (this.mCalendarTextColors != null) {
                v.setTextColor(this.mCalendarTextColors);
            }
        }
        int minMonth = this.mMinDate.get(2);
        int minYear = this.mMinDate.get(1);
        int currentMonth = position + minMonth;
        int month = currentMonth % 12;
        int year = (currentMonth / 12) + minYear;
        if (isSelectedDayInMonth(year, month)) {
            selectedDay = this.mSelectedDay.get(5);
        } else {
            selectedDay = -1;
        }
        v.reuse();
        if (minMonth == month && minYear == year) {
            enabledDayRangeStart = this.mMinDate.get(5);
        } else {
            enabledDayRangeStart = 1;
        }
        if (this.mMaxDate.get(2) == month && this.mMaxDate.get(1) == year) {
            enabledDayRangeEnd = this.mMaxDate.get(5);
        } else {
            enabledDayRangeEnd = 31;
        }
        v.setMonthParams(selectedDay, month, year, this.mFirstDayOfWeek, enabledDayRangeStart, enabledDayRangeEnd);
        v.invalidate();
        return v;
    }

    private boolean isSelectedDayInMonth(int year, int month) {
        return this.mSelectedDay.get(1) == year && this.mSelectedDay.get(2) == month;
    }

    private boolean isCalendarInRange(Calendar value) {
        return value.compareTo(this.mMinDate) >= 0 && value.compareTo(this.mMaxDate) <= 0;
    }
}
