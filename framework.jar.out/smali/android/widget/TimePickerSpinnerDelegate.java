package android.widget;

import android.content.Context;
import android.content.res.Configuration;
import android.content.res.TypedArray;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.text.format.DateFormat;
import android.text.format.DateUtils;
import android.util.AttributeSet;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.BaseSavedState;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.view.ViewGroup.MarginLayoutParams;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.inputmethod.InputMethodManager;
import android.widget.NumberPicker.OnValueChangeListener;
import android.widget.TimePicker.OnTimeChangedListener;
import com.android.internal.R;
import java.util.Calendar;
import java.util.Locale;
import libcore.icu.LocaleData;

class TimePickerSpinnerDelegate extends AbstractTimePickerDelegate {
    private static final boolean DEFAULT_ENABLED_STATE = true;
    private static final int HOURS_IN_HALF_DAY = 12;
    private final Button mAmPmButton;
    private final NumberPicker mAmPmSpinner;
    private final EditText mAmPmSpinnerInput;
    private final String[] mAmPmStrings;
    private final TextView mDivider;
    private char mHourFormat;
    private final NumberPicker mHourSpinner;
    private final EditText mHourSpinnerInput;
    private boolean mHourWithTwoDigit;
    private boolean mIs24HourView;
    private boolean mIsAm;
    private boolean mIsEnabled;
    private final NumberPicker mMinuteSpinner;
    private final EditText mMinuteSpinnerInput;
    private Calendar mTempCalendar;

    /* renamed from: android.widget.TimePickerSpinnerDelegate.1 */
    class C10791 implements OnValueChangeListener {
        C10791() {
        }

        public void onValueChange(NumberPicker spinner, int oldVal, int newVal) {
            TimePickerSpinnerDelegate.this.updateInputState();
            if (!TimePickerSpinnerDelegate.this.is24HourView() && ((oldVal == 11 && newVal == TimePickerSpinnerDelegate.HOURS_IN_HALF_DAY) || (oldVal == TimePickerSpinnerDelegate.HOURS_IN_HALF_DAY && newVal == 11))) {
                TimePickerSpinnerDelegate.this.mIsAm = !TimePickerSpinnerDelegate.this.mIsAm ? TimePickerSpinnerDelegate.DEFAULT_ENABLED_STATE : false;
                TimePickerSpinnerDelegate.this.updateAmPmControl();
            }
            TimePickerSpinnerDelegate.this.onTimeChanged();
        }
    }

    /* renamed from: android.widget.TimePickerSpinnerDelegate.2 */
    class C10802 implements OnValueChangeListener {
        C10802() {
        }

        public void onValueChange(NumberPicker spinner, int oldVal, int newVal) {
            boolean z = TimePickerSpinnerDelegate.DEFAULT_ENABLED_STATE;
            TimePickerSpinnerDelegate.this.updateInputState();
            int minValue = TimePickerSpinnerDelegate.this.mMinuteSpinner.getMinValue();
            int maxValue = TimePickerSpinnerDelegate.this.mMinuteSpinner.getMaxValue();
            int newHour;
            TimePickerSpinnerDelegate timePickerSpinnerDelegate;
            if (oldVal == maxValue && newVal == minValue) {
                newHour = TimePickerSpinnerDelegate.this.mHourSpinner.getValue() + 1;
                if (!TimePickerSpinnerDelegate.this.is24HourView() && newHour == TimePickerSpinnerDelegate.HOURS_IN_HALF_DAY) {
                    timePickerSpinnerDelegate = TimePickerSpinnerDelegate.this;
                    if (TimePickerSpinnerDelegate.this.mIsAm) {
                        z = false;
                    }
                    timePickerSpinnerDelegate.mIsAm = z;
                    TimePickerSpinnerDelegate.this.updateAmPmControl();
                }
                TimePickerSpinnerDelegate.this.mHourSpinner.setValue(newHour);
            } else if (oldVal == minValue && newVal == maxValue) {
                newHour = TimePickerSpinnerDelegate.this.mHourSpinner.getValue() - 1;
                if (!TimePickerSpinnerDelegate.this.is24HourView() && newHour == 11) {
                    timePickerSpinnerDelegate = TimePickerSpinnerDelegate.this;
                    if (TimePickerSpinnerDelegate.this.mIsAm) {
                        z = false;
                    }
                    timePickerSpinnerDelegate.mIsAm = z;
                    TimePickerSpinnerDelegate.this.updateAmPmControl();
                }
                TimePickerSpinnerDelegate.this.mHourSpinner.setValue(newHour);
            }
            TimePickerSpinnerDelegate.this.onTimeChanged();
        }
    }

    /* renamed from: android.widget.TimePickerSpinnerDelegate.3 */
    class C10813 implements OnClickListener {
        C10813() {
        }

        public void onClick(View button) {
            button.requestFocus();
            TimePickerSpinnerDelegate.this.mIsAm = !TimePickerSpinnerDelegate.this.mIsAm ? TimePickerSpinnerDelegate.DEFAULT_ENABLED_STATE : false;
            TimePickerSpinnerDelegate.this.updateAmPmControl();
            TimePickerSpinnerDelegate.this.onTimeChanged();
        }
    }

    /* renamed from: android.widget.TimePickerSpinnerDelegate.4 */
    class C10824 implements OnValueChangeListener {
        C10824() {
        }

        public void onValueChange(NumberPicker picker, int oldVal, int newVal) {
            TimePickerSpinnerDelegate.this.updateInputState();
            picker.requestFocus();
            TimePickerSpinnerDelegate.this.mIsAm = !TimePickerSpinnerDelegate.this.mIsAm ? TimePickerSpinnerDelegate.DEFAULT_ENABLED_STATE : false;
            TimePickerSpinnerDelegate.this.updateAmPmControl();
            TimePickerSpinnerDelegate.this.onTimeChanged();
        }
    }

    private static class SavedState extends BaseSavedState {
        public static final Creator<SavedState> CREATOR;
        private final int mHour;
        private final int mMinute;

        /* renamed from: android.widget.TimePickerSpinnerDelegate.SavedState.1 */
        static class C10831 implements Creator<SavedState> {
            C10831() {
            }

            public SavedState createFromParcel(Parcel in) {
                return new SavedState(null);
            }

            public SavedState[] newArray(int size) {
                return new SavedState[size];
            }
        }

        private SavedState(Parcelable superState, int hour, int minute) {
            super(superState);
            this.mHour = hour;
            this.mMinute = minute;
        }

        private SavedState(Parcel in) {
            super(in);
            this.mHour = in.readInt();
            this.mMinute = in.readInt();
        }

        public int getHour() {
            return this.mHour;
        }

        public int getMinute() {
            return this.mMinute;
        }

        public void writeToParcel(Parcel dest, int flags) {
            super.writeToParcel(dest, flags);
            dest.writeInt(this.mHour);
            dest.writeInt(this.mMinute);
        }

        static {
            CREATOR = new C10831();
        }
    }

    public TimePickerSpinnerDelegate(TimePicker delegator, Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(delegator, context);
        this.mIsEnabled = DEFAULT_ENABLED_STATE;
        TypedArray a = this.mContext.obtainStyledAttributes(attrs, R.styleable.TimePicker, defStyleAttr, defStyleRes);
        int layoutResourceId = a.getResourceId(10, 17367267);
        a.recycle();
        LayoutInflater.from(this.mContext).inflate(layoutResourceId, this.mDelegator, (boolean) DEFAULT_ENABLED_STATE);
        this.mHourSpinner = (NumberPicker) delegator.findViewById(16909248);
        this.mHourSpinner.setOnValueChangedListener(new C10791());
        this.mHourSpinnerInput = (EditText) this.mHourSpinner.findViewById(16909131);
        this.mHourSpinnerInput.setImeOptions(5);
        this.mDivider = (TextView) this.mDelegator.findViewById(16909251);
        if (this.mDivider != null) {
            setDividerText();
        }
        this.mMinuteSpinner = (NumberPicker) this.mDelegator.findViewById(16909249);
        this.mMinuteSpinner.setMinValue(0);
        this.mMinuteSpinner.setMaxValue(59);
        this.mMinuteSpinner.setOnLongPressUpdateInterval(100);
        this.mMinuteSpinner.setFormatter(NumberPicker.getTwoDigitFormatter());
        this.mMinuteSpinner.setOnValueChangedListener(new C10802());
        this.mMinuteSpinnerInput = (EditText) this.mMinuteSpinner.findViewById(16909131);
        this.mMinuteSpinnerInput.setImeOptions(5);
        this.mAmPmStrings = getAmPmStrings(context);
        View amPmView = this.mDelegator.findViewById(16909250);
        if (amPmView instanceof Button) {
            this.mAmPmSpinner = null;
            this.mAmPmSpinnerInput = null;
            this.mAmPmButton = (Button) amPmView;
            this.mAmPmButton.setOnClickListener(new C10813());
        } else {
            this.mAmPmButton = null;
            this.mAmPmSpinner = (NumberPicker) amPmView;
            this.mAmPmSpinner.setMinValue(0);
            this.mAmPmSpinner.setMaxValue(1);
            this.mAmPmSpinner.setDisplayedValues(this.mAmPmStrings);
            this.mAmPmSpinner.setOnValueChangedListener(new C10824());
            this.mAmPmSpinnerInput = (EditText) this.mAmPmSpinner.findViewById(16909131);
            this.mAmPmSpinnerInput.setImeOptions(6);
        }
        if (isAmPmAtStart()) {
            ViewGroup amPmParent = (ViewGroup) delegator.findViewById(16909247);
            amPmParent.removeView(amPmView);
            amPmParent.addView(amPmView, 0);
            MarginLayoutParams lp = (MarginLayoutParams) amPmView.getLayoutParams();
            int startMargin = lp.getMarginStart();
            int endMargin = lp.getMarginEnd();
            if (startMargin != endMargin) {
                lp.setMarginStart(endMargin);
                lp.setMarginEnd(startMargin);
            }
        }
        getHourFormatData();
        updateHourControl();
        updateMinuteControl();
        updateAmPmControl();
        setCurrentHour(Integer.valueOf(this.mTempCalendar.get(11)));
        setCurrentMinute(Integer.valueOf(this.mTempCalendar.get(HOURS_IN_HALF_DAY)));
        if (!isEnabled()) {
            setEnabled(false);
        }
        setContentDescriptions();
        if (this.mDelegator.getImportantForAccessibility() == 0) {
            this.mDelegator.setImportantForAccessibility(1);
        }
    }

    private void getHourFormatData() {
        String bestDateTimePattern = DateFormat.getBestDateTimePattern(this.mCurrentLocale, this.mIs24HourView ? "Hm" : "hm");
        int lengthPattern = bestDateTimePattern.length();
        this.mHourWithTwoDigit = false;
        int i = 0;
        while (i < lengthPattern) {
            char c = bestDateTimePattern.charAt(i);
            if (c == 'H' || c == DateFormat.HOUR || c == 'K' || c == DateFormat.HOUR_OF_DAY) {
                this.mHourFormat = c;
                if (i + 1 < lengthPattern && c == bestDateTimePattern.charAt(i + 1)) {
                    this.mHourWithTwoDigit = DEFAULT_ENABLED_STATE;
                    return;
                }
                return;
            }
            i++;
        }
    }

    private boolean isAmPmAtStart() {
        return DateFormat.getBestDateTimePattern(this.mCurrentLocale, "hm").startsWith("a");
    }

    private void setDividerText() {
        CharSequence separatorText;
        String bestDateTimePattern = DateFormat.getBestDateTimePattern(this.mCurrentLocale, this.mIs24HourView ? "Hm" : "hm");
        int hourIndex = bestDateTimePattern.lastIndexOf(72);
        if (hourIndex == -1) {
            hourIndex = bestDateTimePattern.lastIndexOf(KeyEvent.KEYCODE_BUTTON_L2);
        }
        if (hourIndex == -1) {
            separatorText = ":";
        } else {
            int minuteIndex = bestDateTimePattern.indexOf(KeyEvent.KEYCODE_BUTTON_SELECT, hourIndex + 1);
            if (minuteIndex == -1) {
                separatorText = Character.toString(bestDateTimePattern.charAt(hourIndex + 1));
            } else {
                separatorText = bestDateTimePattern.substring(hourIndex + 1, minuteIndex);
            }
        }
        this.mDivider.setText(separatorText);
    }

    public void setCurrentHour(Integer currentHour) {
        setCurrentHour(currentHour, DEFAULT_ENABLED_STATE);
    }

    private void setCurrentHour(Integer currentHour, boolean notifyTimeChanged) {
        if (currentHour != null && currentHour != getCurrentHour()) {
            if (!is24HourView()) {
                if (currentHour.intValue() >= HOURS_IN_HALF_DAY) {
                    this.mIsAm = false;
                    if (currentHour.intValue() > HOURS_IN_HALF_DAY) {
                        currentHour = Integer.valueOf(currentHour.intValue() - 12);
                    }
                } else {
                    this.mIsAm = DEFAULT_ENABLED_STATE;
                    if (currentHour.intValue() == 0) {
                        currentHour = Integer.valueOf(HOURS_IN_HALF_DAY);
                    }
                }
                updateAmPmControl();
            }
            this.mHourSpinner.setValue(currentHour.intValue());
            if (notifyTimeChanged) {
                onTimeChanged();
            }
        }
    }

    public Integer getCurrentHour() {
        int currentHour = this.mHourSpinner.getValue();
        if (is24HourView()) {
            return Integer.valueOf(currentHour);
        }
        if (this.mIsAm) {
            return Integer.valueOf(currentHour % HOURS_IN_HALF_DAY);
        }
        return Integer.valueOf((currentHour % HOURS_IN_HALF_DAY) + HOURS_IN_HALF_DAY);
    }

    public void setCurrentMinute(Integer currentMinute) {
        if (currentMinute != getCurrentMinute()) {
            this.mMinuteSpinner.setValue(currentMinute.intValue());
            onTimeChanged();
        }
    }

    public Integer getCurrentMinute() {
        return Integer.valueOf(this.mMinuteSpinner.getValue());
    }

    public void setIs24HourView(Boolean is24HourView) {
        if (this.mIs24HourView != is24HourView.booleanValue()) {
            int currentHour = getCurrentHour().intValue();
            this.mIs24HourView = is24HourView.booleanValue();
            getHourFormatData();
            updateHourControl();
            setCurrentHour(Integer.valueOf(currentHour), false);
            updateMinuteControl();
            updateAmPmControl();
        }
    }

    public boolean is24HourView() {
        return this.mIs24HourView;
    }

    public void setOnTimeChangedListener(OnTimeChangedListener onTimeChangedListener) {
        this.mOnTimeChangedListener = onTimeChangedListener;
    }

    public void setEnabled(boolean enabled) {
        this.mMinuteSpinner.setEnabled(enabled);
        if (this.mDivider != null) {
            this.mDivider.setEnabled(enabled);
        }
        this.mHourSpinner.setEnabled(enabled);
        if (this.mAmPmSpinner != null) {
            this.mAmPmSpinner.setEnabled(enabled);
        } else {
            this.mAmPmButton.setEnabled(enabled);
        }
        this.mIsEnabled = enabled;
    }

    public boolean isEnabled() {
        return this.mIsEnabled;
    }

    public int getBaseline() {
        return this.mHourSpinner.getBaseline();
    }

    public void onConfigurationChanged(Configuration newConfig) {
        setCurrentLocale(newConfig.locale);
    }

    public Parcelable onSaveInstanceState(Parcelable superState) {
        return new SavedState(getCurrentHour().intValue(), getCurrentMinute().intValue(), null);
    }

    public void onRestoreInstanceState(Parcelable state) {
        SavedState ss = (SavedState) state;
        setCurrentHour(Integer.valueOf(ss.getHour()));
        setCurrentMinute(Integer.valueOf(ss.getMinute()));
    }

    public boolean dispatchPopulateAccessibilityEvent(AccessibilityEvent event) {
        onPopulateAccessibilityEvent(event);
        return DEFAULT_ENABLED_STATE;
    }

    public void onPopulateAccessibilityEvent(AccessibilityEvent event) {
        int flags;
        if (this.mIs24HourView) {
            flags = 1 | AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS;
        } else {
            flags = 1 | 64;
        }
        this.mTempCalendar.set(11, getCurrentHour().intValue());
        this.mTempCalendar.set(HOURS_IN_HALF_DAY, getCurrentMinute().intValue());
        event.getText().add(DateUtils.formatDateTime(this.mContext, this.mTempCalendar.getTimeInMillis(), flags));
    }

    public void onInitializeAccessibilityEvent(AccessibilityEvent event) {
        event.setClassName(TimePicker.class.getName());
    }

    public void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo info) {
        info.setClassName(TimePicker.class.getName());
    }

    private void updateInputState() {
        InputMethodManager inputMethodManager = InputMethodManager.peekInstance();
        if (inputMethodManager == null) {
            return;
        }
        if (inputMethodManager.isActive(this.mHourSpinnerInput)) {
            this.mHourSpinnerInput.clearFocus();
            inputMethodManager.hideSoftInputFromWindow(this.mDelegator.getWindowToken(), 0);
        } else if (inputMethodManager.isActive(this.mMinuteSpinnerInput)) {
            this.mMinuteSpinnerInput.clearFocus();
            inputMethodManager.hideSoftInputFromWindow(this.mDelegator.getWindowToken(), 0);
        } else if (inputMethodManager.isActive(this.mAmPmSpinnerInput)) {
            this.mAmPmSpinnerInput.clearFocus();
            inputMethodManager.hideSoftInputFromWindow(this.mDelegator.getWindowToken(), 0);
        }
    }

    private void updateAmPmControl() {
        if (!is24HourView()) {
            int index = this.mIsAm ? 0 : 1;
            if (this.mAmPmSpinner != null) {
                this.mAmPmSpinner.setValue(index);
                this.mAmPmSpinner.setVisibility(0);
            } else {
                this.mAmPmButton.setText(this.mAmPmStrings[index]);
                this.mAmPmButton.setVisibility(0);
            }
        } else if (this.mAmPmSpinner != null) {
            this.mAmPmSpinner.setVisibility(8);
        } else {
            this.mAmPmButton.setVisibility(8);
        }
        this.mDelegator.sendAccessibilityEvent(4);
    }

    public void setCurrentLocale(Locale locale) {
        super.setCurrentLocale(locale);
        this.mTempCalendar = Calendar.getInstance(locale);
    }

    private void onTimeChanged() {
        this.mDelegator.sendAccessibilityEvent(4);
        if (this.mOnTimeChangedListener != null) {
            this.mOnTimeChangedListener.onTimeChanged(this.mDelegator, getCurrentHour().intValue(), getCurrentMinute().intValue());
        }
    }

    private void updateHourControl() {
        if (is24HourView()) {
            if (this.mHourFormat == DateFormat.HOUR_OF_DAY) {
                this.mHourSpinner.setMinValue(1);
                this.mHourSpinner.setMaxValue(24);
            } else {
                this.mHourSpinner.setMinValue(0);
                this.mHourSpinner.setMaxValue(23);
            }
        } else if (this.mHourFormat == 'K') {
            this.mHourSpinner.setMinValue(0);
            this.mHourSpinner.setMaxValue(11);
        } else {
            this.mHourSpinner.setMinValue(1);
            this.mHourSpinner.setMaxValue(HOURS_IN_HALF_DAY);
        }
        this.mHourSpinner.setFormatter(this.mHourWithTwoDigit ? NumberPicker.getTwoDigitFormatter() : null);
    }

    private void updateMinuteControl() {
        if (is24HourView()) {
            this.mMinuteSpinnerInput.setImeOptions(6);
        } else {
            this.mMinuteSpinnerInput.setImeOptions(5);
        }
    }

    private void setContentDescriptions() {
        trySetContentDescription(this.mMinuteSpinner, 16909130, 17040787);
        trySetContentDescription(this.mMinuteSpinner, 16909132, 17040788);
        trySetContentDescription(this.mHourSpinner, 16909130, 17040789);
        trySetContentDescription(this.mHourSpinner, 16909132, 17040790);
        if (this.mAmPmSpinner != null) {
            trySetContentDescription(this.mAmPmSpinner, 16909130, 17040791);
            trySetContentDescription(this.mAmPmSpinner, 16909132, 17040792);
        }
    }

    private void trySetContentDescription(View root, int viewId, int contDescResId) {
        View target = root.findViewById(viewId);
        if (target != null) {
            target.setContentDescription(this.mContext.getString(contDescResId));
        }
    }

    public static String[] getAmPmStrings(Context context) {
        String[] result = new String[2];
        LocaleData d = LocaleData.get(context.getResources().getConfiguration().locale);
        result[0] = d.amPm[0].length() > 2 ? d.narrowAm : d.amPm[0];
        result[1] = d.amPm[1].length() > 2 ? d.narrowPm : d.amPm[1];
        return result;
    }
}
