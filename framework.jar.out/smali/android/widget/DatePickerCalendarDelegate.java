package android.widget;

import android.content.Context;
import android.content.res.ColorStateList;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.net.ProxyInfo;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.text.format.DateFormat;
import android.text.format.DateUtils;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.BaseSavedState;
import android.view.View.OnClickListener;
import android.view.WindowManager.LayoutParams;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.animation.AlphaAnimation;
import android.view.animation.Animation;
import android.widget.DatePicker.OnDateChangedListener;
import android.widget.DayPickerView.OnDaySelectedListener;
import com.android.internal.R;
import com.android.internal.widget.AccessibleDateAnimator;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Locale;

class DatePickerCalendarDelegate extends AbstractDatePickerDelegate implements OnClickListener, DatePickerController {
    private static final int ANIMATION_DURATION = 300;
    private static final int DAY_INDEX = 1;
    private static final int DEFAULT_END_YEAR = 2100;
    private static final int DEFAULT_START_YEAR = 1900;
    private static final int MONTH_AND_DAY_VIEW = 0;
    private static final int MONTH_INDEX = 0;
    private static final int UNINITIALIZED = -1;
    private static final int USE_LOCALE = 0;
    private static final int YEAR_INDEX = 2;
    private static final int YEAR_VIEW = 1;
    private AccessibleDateAnimator mAnimator;
    private Calendar mCurrentDate;
    private int mCurrentView;
    private OnDateChangedListener mDateChangedListener;
    private SimpleDateFormat mDayFormat;
    private TextView mDayOfWeekView;
    private String mDayPickerDescription;
    private DayPickerView mDayPickerView;
    private int mFirstDayOfWeek;
    private TextView mHeaderDayOfMonthTextView;
    private TextView mHeaderMonthTextView;
    private TextView mHeaderYearTextView;
    private boolean mIsEnabled;
    private HashSet<OnDateChangedListener> mListeners;
    private Calendar mMaxDate;
    private Calendar mMinDate;
    private LinearLayout mMonthAndDayLayout;
    private LinearLayout mMonthDayYearLayout;
    private final OnDaySelectedListener mOnDaySelectedListener;
    private String mSelectDay;
    private String mSelectYear;
    private Calendar mTempDate;
    private SimpleDateFormat mYearFormat;
    private String mYearPickerDescription;
    private YearPickerView mYearPickerView;

    /* renamed from: android.widget.DatePickerCalendarDelegate.1 */
    class C09581 implements OnDaySelectedListener {
        C09581() {
        }

        public void onDaySelected(DayPickerView view, Calendar day) {
            DatePickerCalendarDelegate.this.mCurrentDate.setTimeInMillis(day.getTimeInMillis());
            DatePickerCalendarDelegate.this.onDateChanged(true, true);
        }
    }

    private static class SavedState extends BaseSavedState {
        public static final Creator<SavedState> CREATOR;
        private final int mCurrentView;
        private final int mListPosition;
        private final int mListPositionOffset;
        private final long mMaxDate;
        private final long mMinDate;
        private final int mSelectedDay;
        private final int mSelectedMonth;
        private final int mSelectedYear;

        /* renamed from: android.widget.DatePickerCalendarDelegate.SavedState.1 */
        static class C09591 implements Creator<SavedState> {
            C09591() {
            }

            public SavedState createFromParcel(Parcel in) {
                return new SavedState(null);
            }

            public SavedState[] newArray(int size) {
                return new SavedState[size];
            }
        }

        private SavedState(Parcelable superState, int year, int month, int day, long minDate, long maxDate, int currentView, int listPosition, int listPositionOffset) {
            super(superState);
            this.mSelectedYear = year;
            this.mSelectedMonth = month;
            this.mSelectedDay = day;
            this.mMinDate = minDate;
            this.mMaxDate = maxDate;
            this.mCurrentView = currentView;
            this.mListPosition = listPosition;
            this.mListPositionOffset = listPositionOffset;
        }

        private SavedState(Parcel in) {
            super(in);
            this.mSelectedYear = in.readInt();
            this.mSelectedMonth = in.readInt();
            this.mSelectedDay = in.readInt();
            this.mMinDate = in.readLong();
            this.mMaxDate = in.readLong();
            this.mCurrentView = in.readInt();
            this.mListPosition = in.readInt();
            this.mListPositionOffset = in.readInt();
        }

        public void writeToParcel(Parcel dest, int flags) {
            super.writeToParcel(dest, flags);
            dest.writeInt(this.mSelectedYear);
            dest.writeInt(this.mSelectedMonth);
            dest.writeInt(this.mSelectedDay);
            dest.writeLong(this.mMinDate);
            dest.writeLong(this.mMaxDate);
            dest.writeInt(this.mCurrentView);
            dest.writeInt(this.mListPosition);
            dest.writeInt(this.mListPositionOffset);
        }

        public int getSelectedDay() {
            return this.mSelectedDay;
        }

        public int getSelectedMonth() {
            return this.mSelectedMonth;
        }

        public int getSelectedYear() {
            return this.mSelectedYear;
        }

        public long getMinDate() {
            return this.mMinDate;
        }

        public long getMaxDate() {
            return this.mMaxDate;
        }

        public int getCurrentView() {
            return this.mCurrentView;
        }

        public int getListPosition() {
            return this.mListPosition;
        }

        public int getListPositionOffset() {
            return this.mListPositionOffset;
        }

        static {
            CREATOR = new C09591();
        }
    }

    public DatePickerCalendarDelegate(DatePicker delegator, Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(delegator, context);
        this.mYearFormat = new SimpleDateFormat("y", Locale.getDefault());
        this.mDayFormat = new SimpleDateFormat("d", Locale.getDefault());
        this.mIsEnabled = true;
        this.mCurrentView = UNINITIALIZED;
        this.mFirstDayOfWeek = USE_LOCALE;
        this.mListeners = new HashSet();
        this.mOnDaySelectedListener = new C09581();
        Locale locale = Locale.getDefault();
        this.mMinDate = getCalendarForLocale(this.mMinDate, locale);
        this.mMaxDate = getCalendarForLocale(this.mMaxDate, locale);
        this.mTempDate = getCalendarForLocale(this.mMaxDate, locale);
        this.mCurrentDate = getCalendarForLocale(this.mCurrentDate, locale);
        this.mMinDate.set(DEFAULT_START_YEAR, USE_LOCALE, YEAR_VIEW);
        this.mMaxDate.set(DEFAULT_END_YEAR, 11, 31);
        Resources res = this.mDelegator.getResources();
        TypedArray a = this.mContext.obtainStyledAttributes(attrs, R.styleable.DatePicker, defStyleAttr, defStyleRes);
        View mainView = ((LayoutInflater) this.mContext.getSystemService(Context.LAYOUT_INFLATER_SERVICE)).inflate(a.getResourceId(17, 17367105), null);
        this.mDelegator.addView(mainView);
        this.mDayOfWeekView = (TextView) mainView.findViewById(16909036);
        LinearLayout dateLayout = (LinearLayout) mainView.findViewById(16909035);
        this.mMonthDayYearLayout = (LinearLayout) mainView.findViewById(16909037);
        this.mMonthAndDayLayout = (LinearLayout) mainView.findViewById(16909038);
        this.mMonthAndDayLayout.setOnClickListener(this);
        this.mHeaderMonthTextView = (TextView) mainView.findViewById(16909039);
        this.mHeaderDayOfMonthTextView = (TextView) mainView.findViewById(16909040);
        this.mHeaderYearTextView = (TextView) mainView.findViewById(16909041);
        this.mHeaderYearTextView.setOnClickListener(this);
        int defaultHighlightColor = this.mHeaderYearTextView.getHighlightColor();
        int dayOfWeekTextAppearanceResId = a.getResourceId(9, UNINITIALIZED);
        if (dayOfWeekTextAppearanceResId != UNINITIALIZED) {
            this.mDayOfWeekView.setTextAppearance(context, dayOfWeekTextAppearanceResId);
        }
        this.mDayOfWeekView.setBackground(a.getDrawable(8));
        dateLayout.setBackground(a.getDrawable(USE_LOCALE));
        int headerSelectedTextColor = a.getColor(20, defaultHighlightColor);
        int monthTextAppearanceResId = a.getResourceId(10, UNINITIALIZED);
        if (monthTextAppearanceResId != UNINITIALIZED) {
            this.mHeaderMonthTextView.setTextAppearance(context, monthTextAppearanceResId);
        }
        this.mHeaderMonthTextView.setTextColor(ColorStateList.addFirstIfMissing(this.mHeaderMonthTextView.getTextColors(), 16842913, headerSelectedTextColor));
        int dayOfMonthTextAppearanceResId = a.getResourceId(11, UNINITIALIZED);
        if (dayOfMonthTextAppearanceResId != UNINITIALIZED) {
            this.mHeaderDayOfMonthTextView.setTextAppearance(context, dayOfMonthTextAppearanceResId);
        }
        this.mHeaderDayOfMonthTextView.setTextColor(ColorStateList.addFirstIfMissing(this.mHeaderDayOfMonthTextView.getTextColors(), 16842913, headerSelectedTextColor));
        int yearTextAppearanceResId = a.getResourceId(12, UNINITIALIZED);
        if (yearTextAppearanceResId != UNINITIALIZED) {
            this.mHeaderYearTextView.setTextAppearance(context, yearTextAppearanceResId);
        }
        this.mHeaderYearTextView.setTextColor(ColorStateList.addFirstIfMissing(this.mHeaderYearTextView.getTextColors(), 16842913, headerSelectedTextColor));
        this.mDayPickerView = new DayPickerView(this.mContext);
        this.mDayPickerView.setFirstDayOfWeek(this.mFirstDayOfWeek);
        this.mDayPickerView.setMinDate(this.mMinDate.getTimeInMillis());
        this.mDayPickerView.setMaxDate(this.mMaxDate.getTimeInMillis());
        this.mDayPickerView.setDate(this.mCurrentDate.getTimeInMillis());
        this.mDayPickerView.setOnDaySelectedListener(this.mOnDaySelectedListener);
        this.mYearPickerView = new YearPickerView(this.mContext);
        this.mYearPickerView.init(this);
        this.mYearPickerView.setRange(this.mMinDate, this.mMaxDate);
        int yearSelectedCircleColor = a.getColor(14, defaultHighlightColor);
        this.mYearPickerView.setYearSelectedCircleColor(yearSelectedCircleColor);
        ColorStateList calendarTextColor = a.getColorStateList(15);
        int calendarSelectedTextColor = a.getColor(18, defaultHighlightColor);
        this.mDayPickerView.setCalendarTextColor(ColorStateList.addFirstIfMissing(calendarTextColor, 16842913, calendarSelectedTextColor));
        this.mDayPickerDescription = res.getString(17041035);
        this.mSelectDay = res.getString(17041037);
        this.mYearPickerDescription = res.getString(17041036);
        this.mSelectYear = res.getString(17041038);
        this.mAnimator = (AccessibleDateAnimator) mainView.findViewById(16909042);
        this.mAnimator.addView(this.mDayPickerView);
        this.mAnimator.addView(this.mYearPickerView);
        this.mAnimator.setDateMillis(this.mCurrentDate.getTimeInMillis());
        Animation animation = new AlphaAnimation(0.0f, LayoutParams.BRIGHTNESS_OVERRIDE_FULL);
        animation.setDuration(300);
        this.mAnimator.setInAnimation(animation);
        Animation animation2 = new AlphaAnimation(LayoutParams.BRIGHTNESS_OVERRIDE_FULL, 0.0f);
        animation2.setDuration(300);
        this.mAnimator.setOutAnimation(animation2);
        updateDisplay(false);
        setCurrentView(USE_LOCALE);
    }

    private Calendar getCalendarForLocale(Calendar oldCalendar, Locale locale) {
        if (oldCalendar == null) {
            return Calendar.getInstance(locale);
        }
        long currentTimeMillis = oldCalendar.getTimeInMillis();
        Calendar newCalendar = Calendar.getInstance(locale);
        newCalendar.setTimeInMillis(currentTimeMillis);
        return newCalendar;
    }

    private int[] getMonthDayYearIndexes(String pattern) {
        int[] result = new int[3];
        String filteredPattern = pattern.replaceAll("'.*?'", ProxyInfo.LOCAL_EXCL_LIST);
        int dayIndex = filteredPattern.indexOf(100);
        int monthMIndex = filteredPattern.indexOf("M");
        int monthIndex = monthMIndex != UNINITIALIZED ? monthMIndex : filteredPattern.indexOf("L");
        if (filteredPattern.indexOf("y") < monthIndex) {
            result[YEAR_INDEX] = USE_LOCALE;
            if (monthIndex < dayIndex) {
                result[USE_LOCALE] = YEAR_VIEW;
                result[YEAR_VIEW] = YEAR_INDEX;
            } else {
                result[USE_LOCALE] = YEAR_INDEX;
                result[YEAR_VIEW] = YEAR_VIEW;
            }
        } else {
            result[YEAR_INDEX] = YEAR_INDEX;
            if (monthIndex < dayIndex) {
                result[USE_LOCALE] = USE_LOCALE;
                result[YEAR_VIEW] = YEAR_VIEW;
            } else {
                result[USE_LOCALE] = YEAR_VIEW;
                result[YEAR_VIEW] = USE_LOCALE;
            }
        }
        return result;
    }

    private void updateDisplay(boolean announce) {
        if (this.mDayOfWeekView != null) {
            this.mDayOfWeekView.setText(this.mCurrentDate.getDisplayName(7, YEAR_INDEX, Locale.getDefault()));
        }
        int[] viewIndices = getMonthDayYearIndexes(DateFormat.getBestDateTimePattern(this.mCurrentLocale, "yMMMd"));
        this.mMonthDayYearLayout.removeAllViews();
        if (viewIndices[YEAR_INDEX] == 0) {
            this.mMonthDayYearLayout.addView(this.mHeaderYearTextView);
            this.mMonthDayYearLayout.addView(this.mMonthAndDayLayout);
        } else {
            this.mMonthDayYearLayout.addView(this.mMonthAndDayLayout);
            this.mMonthDayYearLayout.addView(this.mHeaderYearTextView);
        }
        this.mMonthAndDayLayout.removeAllViews();
        if (viewIndices[USE_LOCALE] > viewIndices[YEAR_VIEW]) {
            this.mMonthAndDayLayout.addView(this.mHeaderDayOfMonthTextView);
            this.mMonthAndDayLayout.addView(this.mHeaderMonthTextView);
        } else {
            this.mMonthAndDayLayout.addView(this.mHeaderMonthTextView);
            this.mMonthAndDayLayout.addView(this.mHeaderDayOfMonthTextView);
        }
        this.mHeaderMonthTextView.setText(this.mCurrentDate.getDisplayName(YEAR_INDEX, YEAR_VIEW, Locale.getDefault()).toUpperCase(Locale.getDefault()));
        this.mHeaderDayOfMonthTextView.setText(this.mDayFormat.format(this.mCurrentDate.getTime()));
        this.mHeaderYearTextView.setText(this.mYearFormat.format(this.mCurrentDate.getTime()));
        long millis = this.mCurrentDate.getTimeInMillis();
        this.mAnimator.setDateMillis(millis);
        this.mMonthAndDayLayout.setContentDescription(DateUtils.formatDateTime(this.mContext, millis, 24));
        if (announce) {
            this.mAnimator.announceForAccessibility(DateUtils.formatDateTime(this.mContext, millis, 20));
        }
    }

    private void setCurrentView(int viewIndex) {
        long millis = this.mCurrentDate.getTimeInMillis();
        switch (viewIndex) {
            case USE_LOCALE /*0*/:
                this.mDayPickerView.setDate(getSelectedDay().getTimeInMillis());
                if (this.mCurrentView != viewIndex) {
                    this.mMonthAndDayLayout.setSelected(true);
                    this.mHeaderYearTextView.setSelected(false);
                    this.mAnimator.setDisplayedChild(USE_LOCALE);
                    this.mCurrentView = viewIndex;
                }
                this.mAnimator.setContentDescription(this.mDayPickerDescription + ": " + DateUtils.formatDateTime(this.mContext, millis, 16));
                this.mAnimator.announceForAccessibility(this.mSelectDay);
            case YEAR_VIEW /*1*/:
                this.mYearPickerView.onDateChanged();
                if (this.mCurrentView != viewIndex) {
                    this.mMonthAndDayLayout.setSelected(false);
                    this.mHeaderYearTextView.setSelected(true);
                    this.mAnimator.setDisplayedChild(YEAR_VIEW);
                    this.mCurrentView = viewIndex;
                }
                this.mAnimator.setContentDescription(this.mYearPickerDescription + ": " + this.mYearFormat.format(Long.valueOf(millis)));
                this.mAnimator.announceForAccessibility(this.mSelectYear);
            default:
        }
    }

    public void init(int year, int monthOfYear, int dayOfMonth, OnDateChangedListener callBack) {
        this.mCurrentDate.set(YEAR_VIEW, year);
        this.mCurrentDate.set(YEAR_INDEX, monthOfYear);
        this.mCurrentDate.set(5, dayOfMonth);
        this.mDateChangedListener = callBack;
        onDateChanged(false, false);
    }

    public void updateDate(int year, int month, int dayOfMonth) {
        this.mCurrentDate.set(YEAR_VIEW, year);
        this.mCurrentDate.set(YEAR_INDEX, month);
        this.mCurrentDate.set(5, dayOfMonth);
        onDateChanged(false, true);
    }

    private void onDateChanged(boolean fromUser, boolean callbackToClient) {
        if (callbackToClient && this.mDateChangedListener != null) {
            this.mDateChangedListener.onDateChanged(this.mDelegator, this.mCurrentDate.get(YEAR_VIEW), this.mCurrentDate.get(YEAR_INDEX), this.mCurrentDate.get(5));
        }
        Iterator i$ = this.mListeners.iterator();
        while (i$.hasNext()) {
            ((OnDateChangedListener) i$.next()).onDateChanged();
        }
        this.mDayPickerView.setDate(getSelectedDay().getTimeInMillis());
        updateDisplay(fromUser);
        if (fromUser) {
            tryVibrate();
        }
    }

    public int getYear() {
        return this.mCurrentDate.get(YEAR_VIEW);
    }

    public int getMonth() {
        return this.mCurrentDate.get(YEAR_INDEX);
    }

    public int getDayOfMonth() {
        return this.mCurrentDate.get(5);
    }

    public void setMinDate(long minDate) {
        this.mTempDate.setTimeInMillis(minDate);
        if (this.mTempDate.get(YEAR_VIEW) != this.mMinDate.get(YEAR_VIEW) || this.mTempDate.get(6) == this.mMinDate.get(6)) {
            if (this.mCurrentDate.before(this.mTempDate)) {
                this.mCurrentDate.setTimeInMillis(minDate);
                onDateChanged(false, true);
            }
            this.mMinDate.setTimeInMillis(minDate);
            this.mDayPickerView.setMinDate(minDate);
            this.mYearPickerView.setRange(this.mMinDate, this.mMaxDate);
        }
    }

    public Calendar getMinDate() {
        return this.mMinDate;
    }

    public void setMaxDate(long maxDate) {
        this.mTempDate.setTimeInMillis(maxDate);
        if (this.mTempDate.get(YEAR_VIEW) != this.mMaxDate.get(YEAR_VIEW) || this.mTempDate.get(6) == this.mMaxDate.get(6)) {
            if (this.mCurrentDate.after(this.mTempDate)) {
                this.mCurrentDate.setTimeInMillis(maxDate);
                onDateChanged(false, true);
            }
            this.mMaxDate.setTimeInMillis(maxDate);
            this.mDayPickerView.setMaxDate(maxDate);
            this.mYearPickerView.setRange(this.mMinDate, this.mMaxDate);
        }
    }

    public Calendar getMaxDate() {
        return this.mMaxDate;
    }

    public void setFirstDayOfWeek(int firstDayOfWeek) {
        this.mFirstDayOfWeek = firstDayOfWeek;
        this.mDayPickerView.setFirstDayOfWeek(firstDayOfWeek);
    }

    public int getFirstDayOfWeek() {
        if (this.mFirstDayOfWeek != 0) {
            return this.mFirstDayOfWeek;
        }
        return this.mCurrentDate.getFirstDayOfWeek();
    }

    public void setEnabled(boolean enabled) {
        this.mMonthAndDayLayout.setEnabled(enabled);
        this.mHeaderYearTextView.setEnabled(enabled);
        this.mAnimator.setEnabled(enabled);
        this.mIsEnabled = enabled;
    }

    public boolean isEnabled() {
        return this.mIsEnabled;
    }

    public CalendarView getCalendarView() {
        throw new UnsupportedOperationException("CalendarView does not exists for the new DatePicker");
    }

    public void setCalendarViewShown(boolean shown) {
    }

    public boolean getCalendarViewShown() {
        return false;
    }

    public void setSpinnersShown(boolean shown) {
    }

    public boolean getSpinnersShown() {
        return false;
    }

    public void onConfigurationChanged(Configuration newConfig) {
        this.mYearFormat = new SimpleDateFormat("y", newConfig.locale);
        this.mDayFormat = new SimpleDateFormat("d", newConfig.locale);
    }

    public Parcelable onSaveInstanceState(Parcelable superState) {
        int year = this.mCurrentDate.get(YEAR_VIEW);
        int month = this.mCurrentDate.get(YEAR_INDEX);
        int day = this.mCurrentDate.get(5);
        int listPosition = UNINITIALIZED;
        int listPositionOffset = UNINITIALIZED;
        if (this.mCurrentView == 0) {
            listPosition = this.mDayPickerView.getMostVisiblePosition();
        } else if (this.mCurrentView == YEAR_VIEW) {
            listPosition = this.mYearPickerView.getFirstVisiblePosition();
            listPositionOffset = this.mYearPickerView.getFirstPositionOffset();
        }
        return new SavedState(year, month, day, this.mMinDate.getTimeInMillis(), this.mMaxDate.getTimeInMillis(), this.mCurrentView, listPosition, listPositionOffset, null);
    }

    public void onRestoreInstanceState(Parcelable state) {
        SavedState ss = (SavedState) state;
        this.mCurrentDate.set(ss.getSelectedYear(), ss.getSelectedMonth(), ss.getSelectedDay());
        this.mCurrentView = ss.getCurrentView();
        this.mMinDate.setTimeInMillis(ss.getMinDate());
        this.mMaxDate.setTimeInMillis(ss.getMaxDate());
        updateDisplay(false);
        setCurrentView(this.mCurrentView);
        int listPosition = ss.getListPosition();
        if (listPosition == UNINITIALIZED) {
            return;
        }
        if (this.mCurrentView == 0) {
            this.mDayPickerView.postSetSelection(listPosition);
        } else if (this.mCurrentView == YEAR_VIEW) {
            this.mYearPickerView.postSetSelectionFromTop(listPosition, ss.getListPositionOffset());
        }
    }

    public boolean dispatchPopulateAccessibilityEvent(AccessibilityEvent event) {
        onPopulateAccessibilityEvent(event);
        return true;
    }

    public void onPopulateAccessibilityEvent(AccessibilityEvent event) {
        event.getText().add(this.mCurrentDate.getTime().toString());
    }

    public void onInitializeAccessibilityEvent(AccessibilityEvent event) {
        event.setClassName(DatePicker.class.getName());
    }

    public void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo info) {
        info.setClassName(DatePicker.class.getName());
    }

    public void onYearSelected(int year) {
        adjustDayInMonthIfNeeded(this.mCurrentDate.get(YEAR_INDEX), year);
        this.mCurrentDate.set(YEAR_VIEW, year);
        onDateChanged(true, true);
        setCurrentView(USE_LOCALE);
    }

    private void adjustDayInMonthIfNeeded(int month, int year) {
        int day = this.mCurrentDate.get(5);
        int daysInMonth = getDaysInMonth(month, year);
        if (day > daysInMonth) {
            this.mCurrentDate.set(5, daysInMonth);
        }
    }

    public static int getDaysInMonth(int month, int year) {
        switch (month) {
            case USE_LOCALE /*0*/:
            case YEAR_INDEX /*2*/:
            case ViewGroupAction.TAG /*4*/:
            case SetEmptyView.TAG /*6*/:
            case SpellChecker.AVERAGE_WORD_LENGTH /*7*/:
            case SetOnClickFillInIntent.TAG /*9*/:
            case TextViewDrawableAction.TAG /*11*/:
                return 31;
            case YEAR_VIEW /*1*/:
                return year % 4 == 0 ? 29 : 28;
            case SetDrawableParameters.TAG /*3*/:
            case ReflectionActionWithoutParams.TAG /*5*/:
            case SetPendingIntentTemplate.TAG /*8*/:
            case SetRemoteViewsAdapterIntent.TAG /*10*/:
                return 30;
            default:
                throw new IllegalArgumentException("Invalid Month");
        }
    }

    public void registerOnDateChangedListener(OnDateChangedListener listener) {
        this.mListeners.add(listener);
    }

    public Calendar getSelectedDay() {
        return this.mCurrentDate;
    }

    public void tryVibrate() {
        this.mDelegator.performHapticFeedback(5);
    }

    public void onClick(View v) {
        tryVibrate();
        if (v.getId() == 16909041) {
            setCurrentView(YEAR_VIEW);
        } else if (v.getId() == 16909038) {
            setCurrentView(USE_LOCALE);
        }
    }
}
