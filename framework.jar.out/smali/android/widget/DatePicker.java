package android.widget;

import android.content.Context;
import android.content.res.Configuration;
import android.content.res.TypedArray;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.text.TextUtils;
import android.text.format.DateUtils;
import android.util.AttributeSet;
import android.util.Log;
import android.util.SparseArray;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.BaseSavedState;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.inputmethod.InputMethodManager;
import android.widget.CalendarView.OnDateChangeListener;
import android.widget.NumberPicker.OnValueChangeListener;
import com.android.internal.R;
import java.text.DateFormat;
import java.text.DateFormatSymbols;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Locale;
import libcore.icu.ICU;

public class DatePicker extends FrameLayout {
    private static final String LOG_TAG;
    private static final int MODE_CALENDAR = 2;
    private static final int MODE_SPINNER = 1;
    private final DatePickerDelegate mDelegate;

    interface DatePickerDelegate {
        boolean dispatchPopulateAccessibilityEvent(AccessibilityEvent accessibilityEvent);

        CalendarView getCalendarView();

        boolean getCalendarViewShown();

        int getDayOfMonth();

        int getFirstDayOfWeek();

        Calendar getMaxDate();

        Calendar getMinDate();

        int getMonth();

        boolean getSpinnersShown();

        int getYear();

        void init(int i, int i2, int i3, OnDateChangedListener onDateChangedListener);

        boolean isEnabled();

        void onConfigurationChanged(Configuration configuration);

        void onInitializeAccessibilityEvent(AccessibilityEvent accessibilityEvent);

        void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo accessibilityNodeInfo);

        void onPopulateAccessibilityEvent(AccessibilityEvent accessibilityEvent);

        void onRestoreInstanceState(Parcelable parcelable);

        Parcelable onSaveInstanceState(Parcelable parcelable);

        void setCalendarViewShown(boolean z);

        void setEnabled(boolean z);

        void setFirstDayOfWeek(int i);

        void setMaxDate(long j);

        void setMinDate(long j);

        void setSpinnersShown(boolean z);

        void setValidationCallback(ValidationCallback validationCallback);

        void updateDate(int i, int i2, int i3);
    }

    static abstract class AbstractDatePickerDelegate implements DatePickerDelegate {
        protected Context mContext;
        protected Locale mCurrentLocale;
        protected DatePicker mDelegator;
        protected OnDateChangedListener mOnDateChangedListener;
        protected ValidationCallback mValidationCallback;

        public AbstractDatePickerDelegate(DatePicker delegator, Context context) {
            this.mDelegator = delegator;
            this.mContext = context;
            setCurrentLocale(Locale.getDefault());
        }

        protected void setCurrentLocale(Locale locale) {
            if (!locale.equals(this.mCurrentLocale)) {
                this.mCurrentLocale = locale;
            }
        }

        public void setValidationCallback(ValidationCallback callback) {
            this.mValidationCallback = callback;
        }

        protected void onValidationChanged(boolean valid) {
            if (this.mValidationCallback != null) {
                this.mValidationCallback.onValidationChanged(valid);
            }
        }
    }

    private static class DatePickerSpinnerDelegate extends AbstractDatePickerDelegate {
        private static final String DATE_FORMAT = "MM/dd/yyyy";
        private static final boolean DEFAULT_CALENDAR_VIEW_SHOWN = true;
        private static final boolean DEFAULT_ENABLED_STATE = true;
        private static final int DEFAULT_END_YEAR = 2100;
        private static final boolean DEFAULT_SPINNERS_SHOWN = true;
        private static final int DEFAULT_START_YEAR = 1900;
        private final CalendarView mCalendarView;
        private Calendar mCurrentDate;
        private final DateFormat mDateFormat;
        private final NumberPicker mDaySpinner;
        private final EditText mDaySpinnerInput;
        private boolean mIsEnabled;
        private Calendar mMaxDate;
        private Calendar mMinDate;
        private final NumberPicker mMonthSpinner;
        private final EditText mMonthSpinnerInput;
        private int mNumberOfMonths;
        private String[] mShortMonths;
        private final LinearLayout mSpinners;
        private Calendar mTempDate;
        private final NumberPicker mYearSpinner;
        private final EditText mYearSpinnerInput;

        /* renamed from: android.widget.DatePicker.DatePickerSpinnerDelegate.1 */
        class C09551 implements OnValueChangeListener {
            C09551() {
            }

            public void onValueChange(NumberPicker picker, int oldVal, int newVal) {
                DatePickerSpinnerDelegate.this.updateInputState();
                DatePickerSpinnerDelegate.this.mTempDate.setTimeInMillis(DatePickerSpinnerDelegate.this.mCurrentDate.getTimeInMillis());
                if (picker == DatePickerSpinnerDelegate.this.mDaySpinner) {
                    int maxDayOfMonth = DatePickerSpinnerDelegate.this.mTempDate.getActualMaximum(5);
                    if (oldVal == maxDayOfMonth && newVal == DatePicker.MODE_SPINNER) {
                        DatePickerSpinnerDelegate.this.mTempDate.add(5, DatePicker.MODE_SPINNER);
                    } else if (oldVal == DatePicker.MODE_SPINNER && newVal == maxDayOfMonth) {
                        DatePickerSpinnerDelegate.this.mTempDate.add(5, -1);
                    } else {
                        DatePickerSpinnerDelegate.this.mTempDate.add(5, newVal - oldVal);
                    }
                } else if (picker == DatePickerSpinnerDelegate.this.mMonthSpinner) {
                    if (oldVal == 11 && newVal == 0) {
                        DatePickerSpinnerDelegate.this.mTempDate.add(DatePicker.MODE_CALENDAR, DatePicker.MODE_SPINNER);
                    } else if (oldVal == 0 && newVal == 11) {
                        DatePickerSpinnerDelegate.this.mTempDate.add(DatePicker.MODE_CALENDAR, -1);
                    } else {
                        DatePickerSpinnerDelegate.this.mTempDate.add(DatePicker.MODE_CALENDAR, newVal - oldVal);
                    }
                } else if (picker == DatePickerSpinnerDelegate.this.mYearSpinner) {
                    DatePickerSpinnerDelegate.this.mTempDate.set(DatePicker.MODE_SPINNER, newVal);
                } else {
                    throw new IllegalArgumentException();
                }
                DatePickerSpinnerDelegate.this.setDate(DatePickerSpinnerDelegate.this.mTempDate.get(DatePicker.MODE_SPINNER), DatePickerSpinnerDelegate.this.mTempDate.get(DatePicker.MODE_CALENDAR), DatePickerSpinnerDelegate.this.mTempDate.get(5));
                DatePickerSpinnerDelegate.this.updateSpinners();
                DatePickerSpinnerDelegate.this.updateCalendarView();
                DatePickerSpinnerDelegate.this.notifyDateChanged();
            }
        }

        /* renamed from: android.widget.DatePicker.DatePickerSpinnerDelegate.2 */
        class C09562 implements OnDateChangeListener {
            C09562() {
            }

            public void onSelectedDayChange(CalendarView view, int year, int month, int monthDay) {
                DatePickerSpinnerDelegate.this.setDate(year, month, monthDay);
                DatePickerSpinnerDelegate.this.updateSpinners();
                DatePickerSpinnerDelegate.this.notifyDateChanged();
            }
        }

        DatePickerSpinnerDelegate(DatePicker delegator, Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
            super(delegator, context);
            this.mDateFormat = new SimpleDateFormat(DATE_FORMAT);
            this.mIsEnabled = DEFAULT_SPINNERS_SHOWN;
            this.mDelegator = delegator;
            this.mContext = context;
            setCurrentLocale(Locale.getDefault());
            TypedArray attributesArray = context.obtainStyledAttributes(attrs, R.styleable.DatePicker, defStyleAttr, defStyleRes);
            boolean spinnersShown = attributesArray.getBoolean(6, DEFAULT_SPINNERS_SHOWN);
            boolean calendarViewShown = attributesArray.getBoolean(7, DEFAULT_SPINNERS_SHOWN);
            int startYear = attributesArray.getInt(DatePicker.MODE_SPINNER, DEFAULT_START_YEAR);
            int endYear = attributesArray.getInt(DatePicker.MODE_CALENDAR, DEFAULT_END_YEAR);
            String minDate = attributesArray.getString(4);
            String maxDate = attributesArray.getString(5);
            int layoutResourceId = attributesArray.getResourceId(19, 17367106);
            attributesArray.recycle();
            ((LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE)).inflate(layoutResourceId, this.mDelegator, (boolean) DEFAULT_SPINNERS_SHOWN);
            OnValueChangeListener onChangeListener = new C09551();
            this.mSpinners = (LinearLayout) this.mDelegator.findViewById(16909030);
            this.mCalendarView = (CalendarView) this.mDelegator.findViewById(16909034);
            this.mCalendarView.setOnDateChangeListener(new C09562());
            this.mDaySpinner = (NumberPicker) this.mDelegator.findViewById(16909032);
            this.mDaySpinner.setFormatter(NumberPicker.getTwoDigitFormatter());
            this.mDaySpinner.setOnLongPressUpdateInterval(100);
            this.mDaySpinner.setOnValueChangedListener(onChangeListener);
            this.mDaySpinnerInput = (EditText) this.mDaySpinner.findViewById(16909131);
            this.mMonthSpinner = (NumberPicker) this.mDelegator.findViewById(16909031);
            this.mMonthSpinner.setMinValue(0);
            this.mMonthSpinner.setMaxValue(this.mNumberOfMonths - 1);
            this.mMonthSpinner.setDisplayedValues(this.mShortMonths);
            this.mMonthSpinner.setOnLongPressUpdateInterval(200);
            this.mMonthSpinner.setOnValueChangedListener(onChangeListener);
            this.mMonthSpinnerInput = (EditText) this.mMonthSpinner.findViewById(16909131);
            this.mYearSpinner = (NumberPicker) this.mDelegator.findViewById(16909033);
            this.mYearSpinner.setOnLongPressUpdateInterval(100);
            this.mYearSpinner.setOnValueChangedListener(onChangeListener);
            this.mYearSpinnerInput = (EditText) this.mYearSpinner.findViewById(16909131);
            if (spinnersShown || calendarViewShown) {
                setSpinnersShown(spinnersShown);
                setCalendarViewShown(calendarViewShown);
            } else {
                setSpinnersShown(DEFAULT_SPINNERS_SHOWN);
            }
            this.mTempDate.clear();
            if (TextUtils.isEmpty(minDate)) {
                this.mTempDate.set(startYear, 0, DatePicker.MODE_SPINNER);
            } else {
                if (!parseDate(minDate, this.mTempDate)) {
                    this.mTempDate.set(startYear, 0, DatePicker.MODE_SPINNER);
                }
            }
            setMinDate(this.mTempDate.getTimeInMillis());
            this.mTempDate.clear();
            if (TextUtils.isEmpty(maxDate)) {
                this.mTempDate.set(endYear, 11, 31);
            } else {
                if (!parseDate(maxDate, this.mTempDate)) {
                    this.mTempDate.set(endYear, 11, 31);
                }
            }
            setMaxDate(this.mTempDate.getTimeInMillis());
            this.mCurrentDate.setTimeInMillis(System.currentTimeMillis());
            init(this.mCurrentDate.get(DatePicker.MODE_SPINNER), this.mCurrentDate.get(DatePicker.MODE_CALENDAR), this.mCurrentDate.get(5), null);
            reorderSpinners();
            setContentDescriptions();
            if (this.mDelegator.getImportantForAccessibility() == 0) {
                this.mDelegator.setImportantForAccessibility(DatePicker.MODE_SPINNER);
            }
        }

        public void init(int year, int monthOfYear, int dayOfMonth, OnDateChangedListener onDateChangedListener) {
            setDate(year, monthOfYear, dayOfMonth);
            updateSpinners();
            updateCalendarView();
            this.mOnDateChangedListener = onDateChangedListener;
        }

        public void updateDate(int year, int month, int dayOfMonth) {
            if (isNewDate(year, month, dayOfMonth)) {
                setDate(year, month, dayOfMonth);
                updateSpinners();
                updateCalendarView();
                notifyDateChanged();
            }
        }

        public int getYear() {
            return this.mCurrentDate.get(DatePicker.MODE_SPINNER);
        }

        public int getMonth() {
            return this.mCurrentDate.get(DatePicker.MODE_CALENDAR);
        }

        public int getDayOfMonth() {
            return this.mCurrentDate.get(5);
        }

        public void setFirstDayOfWeek(int firstDayOfWeek) {
            this.mCalendarView.setFirstDayOfWeek(firstDayOfWeek);
        }

        public int getFirstDayOfWeek() {
            return this.mCalendarView.getFirstDayOfWeek();
        }

        public void setMinDate(long minDate) {
            this.mTempDate.setTimeInMillis(minDate);
            if (this.mTempDate.get(DatePicker.MODE_SPINNER) != this.mMinDate.get(DatePicker.MODE_SPINNER) || this.mTempDate.get(6) == this.mMinDate.get(6)) {
                this.mMinDate.setTimeInMillis(minDate);
                this.mCalendarView.setMinDate(minDate);
                if (this.mCurrentDate.before(this.mMinDate)) {
                    this.mCurrentDate.setTimeInMillis(this.mMinDate.getTimeInMillis());
                    updateCalendarView();
                }
                updateSpinners();
            }
        }

        public Calendar getMinDate() {
            Calendar minDate = Calendar.getInstance();
            minDate.setTimeInMillis(this.mCalendarView.getMinDate());
            return minDate;
        }

        public void setMaxDate(long maxDate) {
            this.mTempDate.setTimeInMillis(maxDate);
            if (this.mTempDate.get(DatePicker.MODE_SPINNER) != this.mMaxDate.get(DatePicker.MODE_SPINNER) || this.mTempDate.get(6) == this.mMaxDate.get(6)) {
                this.mMaxDate.setTimeInMillis(maxDate);
                this.mCalendarView.setMaxDate(maxDate);
                if (this.mCurrentDate.after(this.mMaxDate)) {
                    this.mCurrentDate.setTimeInMillis(this.mMaxDate.getTimeInMillis());
                    updateCalendarView();
                }
                updateSpinners();
            }
        }

        public Calendar getMaxDate() {
            Calendar maxDate = Calendar.getInstance();
            maxDate.setTimeInMillis(this.mCalendarView.getMaxDate());
            return maxDate;
        }

        public void setEnabled(boolean enabled) {
            this.mDaySpinner.setEnabled(enabled);
            this.mMonthSpinner.setEnabled(enabled);
            this.mYearSpinner.setEnabled(enabled);
            this.mCalendarView.setEnabled(enabled);
            this.mIsEnabled = enabled;
        }

        public boolean isEnabled() {
            return this.mIsEnabled;
        }

        public CalendarView getCalendarView() {
            return this.mCalendarView;
        }

        public void setCalendarViewShown(boolean shown) {
            this.mCalendarView.setVisibility(shown ? 0 : 8);
        }

        public boolean getCalendarViewShown() {
            return this.mCalendarView.getVisibility() == 0 ? DEFAULT_SPINNERS_SHOWN : false;
        }

        public void setSpinnersShown(boolean shown) {
            this.mSpinners.setVisibility(shown ? 0 : 8);
        }

        public boolean getSpinnersShown() {
            return this.mSpinners.isShown();
        }

        public void onConfigurationChanged(Configuration newConfig) {
            setCurrentLocale(newConfig.locale);
        }

        public Parcelable onSaveInstanceState(Parcelable superState) {
            return new SavedState(getYear(), getMonth(), getDayOfMonth(), null);
        }

        public void onRestoreInstanceState(Parcelable state) {
            SavedState ss = (SavedState) state;
            setDate(ss.mYear, ss.mMonth, ss.mDay);
            updateSpinners();
            updateCalendarView();
        }

        public boolean dispatchPopulateAccessibilityEvent(AccessibilityEvent event) {
            onPopulateAccessibilityEvent(event);
            return DEFAULT_SPINNERS_SHOWN;
        }

        public void onPopulateAccessibilityEvent(AccessibilityEvent event) {
            event.getText().add(DateUtils.formatDateTime(this.mContext, this.mCurrentDate.getTimeInMillis(), 20));
        }

        public void onInitializeAccessibilityEvent(AccessibilityEvent event) {
            event.setClassName(DatePicker.class.getName());
        }

        public void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo info) {
            info.setClassName(DatePicker.class.getName());
        }

        protected void setCurrentLocale(Locale locale) {
            super.setCurrentLocale(locale);
            this.mTempDate = getCalendarForLocale(this.mTempDate, locale);
            this.mMinDate = getCalendarForLocale(this.mMinDate, locale);
            this.mMaxDate = getCalendarForLocale(this.mMaxDate, locale);
            this.mCurrentDate = getCalendarForLocale(this.mCurrentDate, locale);
            this.mNumberOfMonths = this.mTempDate.getActualMaximum(DatePicker.MODE_CALENDAR) + DatePicker.MODE_SPINNER;
            this.mShortMonths = new DateFormatSymbols().getShortMonths();
            if (usingNumericMonths()) {
                this.mShortMonths = new String[this.mNumberOfMonths];
                for (int i = 0; i < this.mNumberOfMonths; i += DatePicker.MODE_SPINNER) {
                    String[] strArr = this.mShortMonths;
                    Object[] objArr = new Object[DatePicker.MODE_SPINNER];
                    objArr[0] = Integer.valueOf(i + DatePicker.MODE_SPINNER);
                    strArr[i] = String.format("%d", objArr);
                }
            }
        }

        private boolean usingNumericMonths() {
            return Character.isDigit(this.mShortMonths[0].charAt(0));
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

        private void reorderSpinners() {
            this.mSpinners.removeAllViews();
            char[] order = ICU.getDateFormatOrder(android.text.format.DateFormat.getBestDateTimePattern(Locale.getDefault(), "yyyyMMMdd"));
            int spinnerCount = order.length;
            for (int i = 0; i < spinnerCount; i += DatePicker.MODE_SPINNER) {
                switch (order[i]) {
                    case KeyEvent.KEYCODE_AT /*77*/:
                        this.mSpinners.addView(this.mMonthSpinner);
                        setImeOptions(this.mMonthSpinner, spinnerCount, i);
                        break;
                    case KeyEvent.KEYCODE_BUTTON_Y /*100*/:
                        this.mSpinners.addView(this.mDaySpinner);
                        setImeOptions(this.mDaySpinner, spinnerCount, i);
                        break;
                    case KeyEvent.KEYCODE_BREAK /*121*/:
                        this.mSpinners.addView(this.mYearSpinner);
                        setImeOptions(this.mYearSpinner, spinnerCount, i);
                        break;
                    default:
                        throw new IllegalArgumentException(Arrays.toString(order));
                }
            }
        }

        private boolean parseDate(String date, Calendar outDate) {
            try {
                outDate.setTime(this.mDateFormat.parse(date));
                return DEFAULT_SPINNERS_SHOWN;
            } catch (ParseException e) {
                Log.w(DatePicker.LOG_TAG, "Date: " + date + " not in format: " + DATE_FORMAT);
                return false;
            }
        }

        private boolean isNewDate(int year, int month, int dayOfMonth) {
            return (this.mCurrentDate.get(DatePicker.MODE_SPINNER) == year && this.mCurrentDate.get(DatePicker.MODE_CALENDAR) == dayOfMonth && this.mCurrentDate.get(5) == month) ? false : DEFAULT_SPINNERS_SHOWN;
        }

        private void setDate(int year, int month, int dayOfMonth) {
            this.mCurrentDate.set(year, month, dayOfMonth);
            if (this.mCurrentDate.before(this.mMinDate)) {
                this.mCurrentDate.setTimeInMillis(this.mMinDate.getTimeInMillis());
            } else if (this.mCurrentDate.after(this.mMaxDate)) {
                this.mCurrentDate.setTimeInMillis(this.mMaxDate.getTimeInMillis());
            }
        }

        private void updateSpinners() {
            if (this.mCurrentDate.equals(this.mMinDate)) {
                this.mDaySpinner.setMinValue(this.mCurrentDate.get(5));
                this.mDaySpinner.setMaxValue(this.mCurrentDate.getActualMaximum(5));
                this.mDaySpinner.setWrapSelectorWheel(false);
                this.mMonthSpinner.setDisplayedValues(null);
                this.mMonthSpinner.setMinValue(this.mCurrentDate.get(DatePicker.MODE_CALENDAR));
                this.mMonthSpinner.setMaxValue(this.mCurrentDate.getActualMaximum(DatePicker.MODE_CALENDAR));
                this.mMonthSpinner.setWrapSelectorWheel(false);
            } else if (this.mCurrentDate.equals(this.mMaxDate)) {
                this.mDaySpinner.setMinValue(this.mCurrentDate.getActualMinimum(5));
                this.mDaySpinner.setMaxValue(this.mCurrentDate.get(5));
                this.mDaySpinner.setWrapSelectorWheel(false);
                this.mMonthSpinner.setDisplayedValues(null);
                this.mMonthSpinner.setMinValue(this.mCurrentDate.getActualMinimum(DatePicker.MODE_CALENDAR));
                this.mMonthSpinner.setMaxValue(this.mCurrentDate.get(DatePicker.MODE_CALENDAR));
                this.mMonthSpinner.setWrapSelectorWheel(false);
            } else {
                this.mDaySpinner.setMinValue(DatePicker.MODE_SPINNER);
                this.mDaySpinner.setMaxValue(this.mCurrentDate.getActualMaximum(5));
                this.mDaySpinner.setWrapSelectorWheel(DEFAULT_SPINNERS_SHOWN);
                this.mMonthSpinner.setDisplayedValues(null);
                this.mMonthSpinner.setMinValue(0);
                this.mMonthSpinner.setMaxValue(11);
                this.mMonthSpinner.setWrapSelectorWheel(DEFAULT_SPINNERS_SHOWN);
            }
            this.mMonthSpinner.setDisplayedValues((String[]) Arrays.copyOfRange(this.mShortMonths, this.mMonthSpinner.getMinValue(), this.mMonthSpinner.getMaxValue() + DatePicker.MODE_SPINNER));
            this.mYearSpinner.setMinValue(this.mMinDate.get(DatePicker.MODE_SPINNER));
            this.mYearSpinner.setMaxValue(this.mMaxDate.get(DatePicker.MODE_SPINNER));
            this.mYearSpinner.setWrapSelectorWheel(false);
            this.mYearSpinner.setValue(this.mCurrentDate.get(DatePicker.MODE_SPINNER));
            this.mMonthSpinner.setValue(this.mCurrentDate.get(DatePicker.MODE_CALENDAR));
            this.mDaySpinner.setValue(this.mCurrentDate.get(5));
            if (usingNumericMonths()) {
                this.mMonthSpinnerInput.setRawInputType(DatePicker.MODE_CALENDAR);
            }
        }

        private void updateCalendarView() {
            this.mCalendarView.setDate(this.mCurrentDate.getTimeInMillis(), false, false);
        }

        private void notifyDateChanged() {
            this.mDelegator.sendAccessibilityEvent(4);
            if (this.mOnDateChangedListener != null) {
                this.mOnDateChangedListener.onDateChanged(this.mDelegator, getYear(), getMonth(), getDayOfMonth());
            }
        }

        private void setImeOptions(NumberPicker spinner, int spinnerCount, int spinnerIndex) {
            int imeOptions;
            if (spinnerIndex < spinnerCount - 1) {
                imeOptions = 5;
            } else {
                imeOptions = 6;
            }
            ((TextView) spinner.findViewById(16909131)).setImeOptions(imeOptions);
        }

        private void setContentDescriptions() {
            trySetContentDescription(this.mDaySpinner, 16909130, 17040795);
            trySetContentDescription(this.mDaySpinner, 16909132, 17040796);
            trySetContentDescription(this.mMonthSpinner, 16909130, 17040793);
            trySetContentDescription(this.mMonthSpinner, 16909132, 17040794);
            trySetContentDescription(this.mYearSpinner, 16909130, 17040797);
            trySetContentDescription(this.mYearSpinner, 16909132, 17040798);
        }

        private void trySetContentDescription(View root, int viewId, int contDescResId) {
            View target = root.findViewById(viewId);
            if (target != null) {
                target.setContentDescription(this.mContext.getString(contDescResId));
            }
        }

        private void updateInputState() {
            InputMethodManager inputMethodManager = InputMethodManager.peekInstance();
            if (inputMethodManager == null) {
                return;
            }
            if (inputMethodManager.isActive(this.mYearSpinnerInput)) {
                this.mYearSpinnerInput.clearFocus();
                inputMethodManager.hideSoftInputFromWindow(this.mDelegator.getWindowToken(), 0);
            } else if (inputMethodManager.isActive(this.mMonthSpinnerInput)) {
                this.mMonthSpinnerInput.clearFocus();
                inputMethodManager.hideSoftInputFromWindow(this.mDelegator.getWindowToken(), 0);
            } else if (inputMethodManager.isActive(this.mDaySpinnerInput)) {
                this.mDaySpinnerInput.clearFocus();
                inputMethodManager.hideSoftInputFromWindow(this.mDelegator.getWindowToken(), 0);
            }
        }
    }

    public interface OnDateChangedListener {
        void onDateChanged(DatePicker datePicker, int i, int i2, int i3);
    }

    private static class SavedState extends BaseSavedState {
        public static final Creator<SavedState> CREATOR;
        private final int mDay;
        private final int mMonth;
        private final int mYear;

        /* renamed from: android.widget.DatePicker.SavedState.1 */
        static class C09571 implements Creator<SavedState> {
            C09571() {
            }

            public SavedState createFromParcel(Parcel in) {
                return new SavedState(null);
            }

            public SavedState[] newArray(int size) {
                return new SavedState[size];
            }
        }

        private SavedState(Parcelable superState, int year, int month, int day) {
            super(superState);
            this.mYear = year;
            this.mMonth = month;
            this.mDay = day;
        }

        private SavedState(Parcel in) {
            super(in);
            this.mYear = in.readInt();
            this.mMonth = in.readInt();
            this.mDay = in.readInt();
        }

        public void writeToParcel(Parcel dest, int flags) {
            super.writeToParcel(dest, flags);
            dest.writeInt(this.mYear);
            dest.writeInt(this.mMonth);
            dest.writeInt(this.mDay);
        }

        static {
            CREATOR = new C09571();
        }
    }

    public interface ValidationCallback {
        void onValidationChanged(boolean z);
    }

    static {
        LOG_TAG = DatePicker.class.getSimpleName();
    }

    public DatePicker(Context context) {
        this(context, null);
    }

    public DatePicker(Context context, AttributeSet attrs) {
        this(context, attrs, 16843612);
    }

    public DatePicker(Context context, AttributeSet attrs, int defStyleAttr) {
        this(context, attrs, defStyleAttr, 0);
    }

    public DatePicker(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
        TypedArray a = context.obtainStyledAttributes(attrs, R.styleable.DatePicker, defStyleAttr, defStyleRes);
        int mode = a.getInt(16, MODE_SPINNER);
        int firstDayOfWeek = a.getInt(3, 0);
        a.recycle();
        switch (mode) {
            case MODE_CALENDAR /*2*/:
                this.mDelegate = createCalendarUIDelegate(context, attrs, defStyleAttr, defStyleRes);
                break;
            default:
                this.mDelegate = createSpinnerUIDelegate(context, attrs, defStyleAttr, defStyleRes);
                break;
        }
        if (firstDayOfWeek != 0) {
            setFirstDayOfWeek(firstDayOfWeek);
        }
    }

    private DatePickerDelegate createSpinnerUIDelegate(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        return new DatePickerSpinnerDelegate(this, context, attrs, defStyleAttr, defStyleRes);
    }

    private DatePickerDelegate createCalendarUIDelegate(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        return new DatePickerCalendarDelegate(this, context, attrs, defStyleAttr, defStyleRes);
    }

    public void init(int year, int monthOfYear, int dayOfMonth, OnDateChangedListener onDateChangedListener) {
        this.mDelegate.init(year, monthOfYear, dayOfMonth, onDateChangedListener);
    }

    public void updateDate(int year, int month, int dayOfMonth) {
        this.mDelegate.updateDate(year, month, dayOfMonth);
    }

    public int getYear() {
        return this.mDelegate.getYear();
    }

    public int getMonth() {
        return this.mDelegate.getMonth();
    }

    public int getDayOfMonth() {
        return this.mDelegate.getDayOfMonth();
    }

    public long getMinDate() {
        return this.mDelegate.getMinDate().getTimeInMillis();
    }

    public void setMinDate(long minDate) {
        this.mDelegate.setMinDate(minDate);
    }

    public long getMaxDate() {
        return this.mDelegate.getMaxDate().getTimeInMillis();
    }

    public void setMaxDate(long maxDate) {
        this.mDelegate.setMaxDate(maxDate);
    }

    public void setValidationCallback(ValidationCallback callback) {
        this.mDelegate.setValidationCallback(callback);
    }

    public void setEnabled(boolean enabled) {
        if (this.mDelegate.isEnabled() != enabled) {
            super.setEnabled(enabled);
            this.mDelegate.setEnabled(enabled);
        }
    }

    public boolean isEnabled() {
        return this.mDelegate.isEnabled();
    }

    public boolean dispatchPopulateAccessibilityEvent(AccessibilityEvent event) {
        return this.mDelegate.dispatchPopulateAccessibilityEvent(event);
    }

    public void onPopulateAccessibilityEvent(AccessibilityEvent event) {
        super.onPopulateAccessibilityEvent(event);
        this.mDelegate.onPopulateAccessibilityEvent(event);
    }

    public void onInitializeAccessibilityEvent(AccessibilityEvent event) {
        super.onInitializeAccessibilityEvent(event);
        this.mDelegate.onInitializeAccessibilityEvent(event);
    }

    public void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo info) {
        super.onInitializeAccessibilityNodeInfo(info);
        this.mDelegate.onInitializeAccessibilityNodeInfo(info);
    }

    protected void onConfigurationChanged(Configuration newConfig) {
        super.onConfigurationChanged(newConfig);
        this.mDelegate.onConfigurationChanged(newConfig);
    }

    public void setFirstDayOfWeek(int firstDayOfWeek) {
        if (firstDayOfWeek < MODE_SPINNER || firstDayOfWeek > 7) {
            throw new IllegalArgumentException("firstDayOfWeek must be between 1 and 7");
        }
        this.mDelegate.setFirstDayOfWeek(firstDayOfWeek);
    }

    public int getFirstDayOfWeek() {
        return this.mDelegate.getFirstDayOfWeek();
    }

    public boolean getCalendarViewShown() {
        return this.mDelegate.getCalendarViewShown();
    }

    public CalendarView getCalendarView() {
        return this.mDelegate.getCalendarView();
    }

    public void setCalendarViewShown(boolean shown) {
        this.mDelegate.setCalendarViewShown(shown);
    }

    public boolean getSpinnersShown() {
        return this.mDelegate.getSpinnersShown();
    }

    public void setSpinnersShown(boolean shown) {
        this.mDelegate.setSpinnersShown(shown);
    }

    protected void dispatchRestoreInstanceState(SparseArray<Parcelable> container) {
        dispatchThawSelfOnly(container);
    }

    protected Parcelable onSaveInstanceState() {
        return this.mDelegate.onSaveInstanceState(super.onSaveInstanceState());
    }

    protected void onRestoreInstanceState(Parcelable state) {
        BaseSavedState ss = (BaseSavedState) state;
        super.onRestoreInstanceState(ss.getSuperState());
        this.mDelegate.onRestoreInstanceState(ss);
    }
}
