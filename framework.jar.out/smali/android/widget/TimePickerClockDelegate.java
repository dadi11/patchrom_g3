package android.widget;

import android.content.Context;
import android.content.res.ColorStateList;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.text.format.DateFormat;
import android.text.format.DateUtils;
import android.util.AttributeSet;
import android.util.Log;
import android.util.TypedValue;
import android.view.KeyCharacterMap;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.AccessibilityDelegate;
import android.view.View.BaseSavedState;
import android.view.View.OnClickListener;
import android.view.View.OnFocusChangeListener;
import android.view.View.OnKeyListener;
import android.view.ViewGroup;
import android.view.WindowManager.LayoutParams;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.accessibility.AccessibilityNodeInfo.AccessibilityAction;
import android.widget.RadialTimePickerView.OnValueSelectedListener;
import android.widget.TimePicker.OnTimeChangedListener;
import com.android.internal.R;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.Locale;

class TimePickerClockDelegate extends AbstractTimePickerDelegate implements OnValueSelectedListener {
    static final int AM = 0;
    private static final int AMPM_INDEX = 2;
    private static final boolean DEFAULT_ENABLED_STATE = true;
    private static final int ENABLE_PICKER_INDEX = 3;
    private static final int HOURS_IN_HALF_DAY = 12;
    private static final int HOUR_INDEX = 0;
    private static final int MINUTE_INDEX = 1;
    static final int PM = 1;
    private static final String TAG = "TimePickerClockDelegate";
    private boolean mAllowAutoAdvance;
    private int mAmKeyCode;
    private final CheckedTextView mAmLabel;
    private final View mAmPmLayout;
    private final String mAmText;
    private final OnClickListener mClickListener;
    private String mDeletedKeyFormat;
    private final float mDisabledAlpha;
    private String mDoublePlaceholderText;
    private final OnFocusChangeListener mFocusListener;
    private final View mHeaderView;
    private final TextView mHourView;
    private boolean mInKbMode;
    private int mInitialHourOfDay;
    private int mInitialMinute;
    private boolean mIs24HourView;
    private boolean mIsEnabled;
    private final OnKeyListener mKeyListener;
    private boolean mLastAnnouncedIsHour;
    private CharSequence mLastAnnouncedText;
    private Node mLegalTimesTree;
    private final TextView mMinuteView;
    private char mPlaceholderText;
    private int mPmKeyCode;
    private final CheckedTextView mPmLabel;
    private final String mPmText;
    private final RadialTimePickerView mRadialTimePickerView;
    private String mSelectHours;
    private String mSelectMinutes;
    private final TextView mSeparatorView;
    private Calendar mTempCalendar;
    private ArrayList<Integer> mTypedTimes;

    /* renamed from: android.widget.TimePickerClockDelegate.1 */
    class C10751 implements OnClickListener {
        C10751() {
        }

        public void onClick(View v) {
            switch (v.getId()) {
                case 16909239:
                    TimePickerClockDelegate.this.setCurrentItemShowing(TimePickerClockDelegate.HOUR_INDEX, TimePickerClockDelegate.DEFAULT_ENABLED_STATE, TimePickerClockDelegate.DEFAULT_ENABLED_STATE);
                    break;
                case 16909241:
                    TimePickerClockDelegate.this.setCurrentItemShowing(TimePickerClockDelegate.PM, TimePickerClockDelegate.DEFAULT_ENABLED_STATE, TimePickerClockDelegate.DEFAULT_ENABLED_STATE);
                    break;
                case 16909243:
                    TimePickerClockDelegate.this.setAmOrPm(TimePickerClockDelegate.HOUR_INDEX);
                    break;
                case 16909244:
                    TimePickerClockDelegate.this.setAmOrPm(TimePickerClockDelegate.PM);
                    break;
                default:
                    return;
            }
            TimePickerClockDelegate.this.tryVibrate();
        }
    }

    /* renamed from: android.widget.TimePickerClockDelegate.2 */
    class C10762 implements OnKeyListener {
        C10762() {
        }

        public boolean onKey(View v, int keyCode, KeyEvent event) {
            if (event.getAction() == TimePickerClockDelegate.PM) {
                return TimePickerClockDelegate.this.processKeyUp(keyCode);
            }
            return false;
        }
    }

    /* renamed from: android.widget.TimePickerClockDelegate.3 */
    class C10773 implements OnFocusChangeListener {
        C10773() {
        }

        public void onFocusChange(View v, boolean hasFocus) {
            if (!hasFocus && TimePickerClockDelegate.this.mInKbMode && TimePickerClockDelegate.this.isTypedTimeFullyLegal()) {
                TimePickerClockDelegate.this.finishKbMode();
                if (TimePickerClockDelegate.this.mOnTimeChangedListener != null) {
                    TimePickerClockDelegate.this.mOnTimeChangedListener.onTimeChanged(TimePickerClockDelegate.this.mDelegator, TimePickerClockDelegate.this.mRadialTimePickerView.getCurrentHour(), TimePickerClockDelegate.this.mRadialTimePickerView.getCurrentMinute());
                }
            }
        }
    }

    private static class ClickActionDelegate extends AccessibilityDelegate {
        private final AccessibilityAction mClickAction;

        public ClickActionDelegate(Context context, int resId) {
            this.mClickAction = new AccessibilityAction(16, context.getString(resId));
        }

        public void onInitializeAccessibilityNodeInfo(View host, AccessibilityNodeInfo info) {
            super.onInitializeAccessibilityNodeInfo(host, info);
            info.addAction(this.mClickAction);
        }
    }

    private class Node {
        private ArrayList<Node> mChildren;
        private int[] mLegalKeys;

        public Node(int... legalKeys) {
            this.mLegalKeys = legalKeys;
            this.mChildren = new ArrayList();
        }

        public void addChild(Node child) {
            this.mChildren.add(child);
        }

        public boolean containsKey(int key) {
            for (int i = TimePickerClockDelegate.HOUR_INDEX; i < this.mLegalKeys.length; i += TimePickerClockDelegate.PM) {
                if (this.mLegalKeys[i] == key) {
                    return TimePickerClockDelegate.DEFAULT_ENABLED_STATE;
                }
            }
            return false;
        }

        public Node canReach(int key) {
            if (this.mChildren == null) {
                return null;
            }
            Iterator i$ = this.mChildren.iterator();
            while (i$.hasNext()) {
                Node child = (Node) i$.next();
                if (child.containsKey(key)) {
                    return child;
                }
            }
            return null;
        }
    }

    private static class SavedState extends BaseSavedState {
        public static final Creator<SavedState> CREATOR;
        private final int mCurrentItemShowing;
        private final int mHour;
        private final boolean mInKbMode;
        private final boolean mIs24HourMode;
        private final int mMinute;
        private final ArrayList<Integer> mTypedTimes;

        /* renamed from: android.widget.TimePickerClockDelegate.SavedState.1 */
        static class C10781 implements Creator<SavedState> {
            C10781() {
            }

            public SavedState createFromParcel(Parcel in) {
                return new SavedState(null);
            }

            public SavedState[] newArray(int size) {
                return new SavedState[size];
            }
        }

        private SavedState(Parcelable superState, int hour, int minute, boolean is24HourMode, boolean isKbMode, ArrayList<Integer> typedTimes, int currentItemShowing) {
            super(superState);
            this.mHour = hour;
            this.mMinute = minute;
            this.mIs24HourMode = is24HourMode;
            this.mInKbMode = isKbMode;
            this.mTypedTimes = typedTimes;
            this.mCurrentItemShowing = currentItemShowing;
        }

        private SavedState(Parcel in) {
            boolean z;
            boolean z2 = TimePickerClockDelegate.DEFAULT_ENABLED_STATE;
            super(in);
            this.mHour = in.readInt();
            this.mMinute = in.readInt();
            if (in.readInt() == TimePickerClockDelegate.PM) {
                z = TimePickerClockDelegate.DEFAULT_ENABLED_STATE;
            } else {
                z = false;
            }
            this.mIs24HourMode = z;
            if (in.readInt() != TimePickerClockDelegate.PM) {
                z2 = false;
            }
            this.mInKbMode = z2;
            this.mTypedTimes = in.readArrayList(getClass().getClassLoader());
            this.mCurrentItemShowing = in.readInt();
        }

        public int getHour() {
            return this.mHour;
        }

        public int getMinute() {
            return this.mMinute;
        }

        public boolean is24HourMode() {
            return this.mIs24HourMode;
        }

        public boolean inKbMode() {
            return this.mInKbMode;
        }

        public ArrayList<Integer> getTypesTimes() {
            return this.mTypedTimes;
        }

        public int getCurrentItemShowing() {
            return this.mCurrentItemShowing;
        }

        public void writeToParcel(Parcel dest, int flags) {
            int i;
            int i2 = TimePickerClockDelegate.PM;
            super.writeToParcel(dest, flags);
            dest.writeInt(this.mHour);
            dest.writeInt(this.mMinute);
            if (this.mIs24HourMode) {
                i = TimePickerClockDelegate.PM;
            } else {
                i = TimePickerClockDelegate.HOUR_INDEX;
            }
            dest.writeInt(i);
            if (!this.mInKbMode) {
                i2 = TimePickerClockDelegate.HOUR_INDEX;
            }
            dest.writeInt(i2);
            dest.writeList(this.mTypedTimes);
            dest.writeInt(this.mCurrentItemShowing);
        }

        static {
            CREATOR = new C10781();
        }
    }

    public TimePickerClockDelegate(TimePicker delegator, Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(delegator, context);
        this.mIsEnabled = DEFAULT_ENABLED_STATE;
        this.mTypedTimes = new ArrayList();
        this.mClickListener = new C10751();
        this.mKeyListener = new C10762();
        this.mFocusListener = new C10773();
        TypedArray a = this.mContext.obtainStyledAttributes(attrs, R.styleable.TimePicker, defStyleAttr, defStyleRes);
        LayoutInflater inflater = (LayoutInflater) this.mContext.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        Resources res = this.mContext.getResources();
        this.mSelectHours = res.getString(17041033);
        this.mSelectMinutes = res.getString(17041034);
        String[] amPmStrings = TimePickerSpinnerDelegate.getAmPmStrings(context);
        this.mAmText = amPmStrings[HOUR_INDEX];
        this.mPmText = amPmStrings[PM];
        View mainView = inflater.inflate(a.getResourceId(9, 17367266), (ViewGroup) delegator);
        this.mHeaderView = mainView.findViewById(16909238);
        this.mHeaderView.setBackground(a.getDrawable(HOUR_INDEX));
        this.mHourView = (TextView) this.mHeaderView.findViewById(16909239);
        this.mHourView.setOnClickListener(this.mClickListener);
        this.mHourView.setAccessibilityDelegate(new ClickActionDelegate(context, 17041033));
        this.mSeparatorView = (TextView) this.mHeaderView.findViewById(16909240);
        this.mMinuteView = (TextView) this.mHeaderView.findViewById(16909241);
        this.mMinuteView.setOnClickListener(this.mClickListener);
        this.mMinuteView.setAccessibilityDelegate(new ClickActionDelegate(context, 17041034));
        int headerTimeTextAppearance = a.getResourceId(PM, HOUR_INDEX);
        if (headerTimeTextAppearance != 0) {
            this.mHourView.setTextAppearance(context, headerTimeTextAppearance);
            this.mSeparatorView.setTextAppearance(context, headerTimeTextAppearance);
            this.mMinuteView.setTextAppearance(context, headerTimeTextAppearance);
        }
        this.mHourView.setMinWidth(computeStableWidth(this.mHourView, 24));
        this.mMinuteView.setMinWidth(computeStableWidth(this.mMinuteView, 60));
        int headerSelectedTextColor = a.getColor(11, res.getColor(17170682));
        this.mHourView.setTextColor(ColorStateList.addFirstIfMissing(this.mHourView.getTextColors(), 16842913, headerSelectedTextColor));
        this.mMinuteView.setTextColor(ColorStateList.addFirstIfMissing(this.mMinuteView.getTextColors(), 16842913, headerSelectedTextColor));
        this.mAmPmLayout = this.mHeaderView.findViewById(16909242);
        this.mAmLabel = (CheckedTextView) this.mAmPmLayout.findViewById(16909243);
        this.mAmLabel.setText(amPmStrings[HOUR_INDEX]);
        this.mAmLabel.setOnClickListener(this.mClickListener);
        this.mPmLabel = (CheckedTextView) this.mAmPmLayout.findViewById(16909244);
        this.mPmLabel.setText(amPmStrings[PM]);
        this.mPmLabel.setOnClickListener(this.mClickListener);
        int headerAmPmTextAppearance = a.getResourceId(AMPM_INDEX, HOUR_INDEX);
        if (headerAmPmTextAppearance != 0) {
            this.mAmLabel.setTextAppearance(context, headerAmPmTextAppearance);
            this.mPmLabel.setTextAppearance(context, headerAmPmTextAppearance);
        }
        a.recycle();
        TypedValue outValue = new TypedValue();
        context.getTheme().resolveAttribute(16842803, outValue, DEFAULT_ENABLED_STATE);
        this.mDisabledAlpha = outValue.getFloat();
        this.mRadialTimePickerView = (RadialTimePickerView) mainView.findViewById(16909246);
        setupListeners();
        this.mAllowAutoAdvance = DEFAULT_ENABLED_STATE;
        this.mDoublePlaceholderText = res.getString(17041042);
        this.mDeletedKeyFormat = res.getString(17041040);
        this.mPlaceholderText = this.mDoublePlaceholderText.charAt(HOUR_INDEX);
        this.mPmKeyCode = -1;
        this.mAmKeyCode = -1;
        generateLegalTimesTree();
        Calendar calendar = Calendar.getInstance(this.mCurrentLocale);
        initialize(calendar.get(11), calendar.get(HOURS_IN_HALF_DAY), false, HOUR_INDEX);
    }

    private int computeStableWidth(TextView v, int maxNumber) {
        int maxWidth = HOUR_INDEX;
        for (int i = HOUR_INDEX; i < maxNumber; i += PM) {
            Object[] objArr = new Object[PM];
            objArr[HOUR_INDEX] = Integer.valueOf(i);
            v.setText(String.format("%02d", objArr));
            v.measure(HOUR_INDEX, HOUR_INDEX);
            int width = v.getMeasuredWidth();
            if (width > maxWidth) {
                maxWidth = width;
            }
        }
        return maxWidth;
    }

    private void initialize(int hourOfDay, int minute, boolean is24HourView, int index) {
        this.mInitialHourOfDay = hourOfDay;
        this.mInitialMinute = minute;
        this.mIs24HourView = is24HourView;
        this.mInKbMode = false;
        updateUI(index);
    }

    private void setupListeners() {
        this.mHeaderView.setOnKeyListener(this.mKeyListener);
        this.mHeaderView.setOnFocusChangeListener(this.mFocusListener);
        this.mHeaderView.setFocusable(DEFAULT_ENABLED_STATE);
        this.mRadialTimePickerView.setOnValueSelectedListener(this);
    }

    private void updateUI(int index) {
        updateRadialPicker(index);
        updateHeaderAmPm();
        updateHeaderHour(this.mInitialHourOfDay, false);
        updateHeaderSeparator();
        updateHeaderMinute(this.mInitialMinute, false);
        this.mDelegator.invalidate();
    }

    private void updateRadialPicker(int index) {
        this.mRadialTimePickerView.initialize(this.mInitialHourOfDay, this.mInitialMinute, this.mIs24HourView);
        setCurrentItemShowing(index, false, DEFAULT_ENABLED_STATE);
    }

    private void updateHeaderAmPm() {
        int i = HOUR_INDEX;
        if (this.mIs24HourView) {
            this.mAmPmLayout.setVisibility(8);
            return;
        }
        ViewGroup parent = (ViewGroup) this.mAmPmLayout.getParent();
        int targetIndex = DateFormat.getBestDateTimePattern(this.mCurrentLocale, "hm").startsWith("a") ? HOUR_INDEX : parent.getChildCount() - 1;
        if (targetIndex != parent.indexOfChild(this.mAmPmLayout)) {
            parent.removeView(this.mAmPmLayout);
            parent.addView(this.mAmPmLayout, targetIndex);
        }
        if (this.mInitialHourOfDay >= HOURS_IN_HALF_DAY) {
            i = PM;
        }
        updateAmPmLabelStates(i);
    }

    public void setCurrentHour(Integer currentHour) {
        int i = PM;
        if (this.mInitialHourOfDay != currentHour.intValue()) {
            this.mInitialHourOfDay = currentHour.intValue();
            updateHeaderHour(currentHour.intValue(), DEFAULT_ENABLED_STATE);
            updateHeaderAmPm();
            this.mRadialTimePickerView.setCurrentHour(currentHour.intValue());
            RadialTimePickerView radialTimePickerView = this.mRadialTimePickerView;
            if (this.mInitialHourOfDay < HOURS_IN_HALF_DAY) {
                i = HOUR_INDEX;
            }
            radialTimePickerView.setAmOrPm(i);
            this.mDelegator.invalidate();
            onTimeChanged();
        }
    }

    public Integer getCurrentHour() {
        int currentHour = this.mRadialTimePickerView.getCurrentHour();
        if (this.mIs24HourView) {
            return Integer.valueOf(currentHour);
        }
        switch (this.mRadialTimePickerView.getAmOrPm()) {
            case PM /*1*/:
                return Integer.valueOf((currentHour % HOURS_IN_HALF_DAY) + HOURS_IN_HALF_DAY);
            default:
                return Integer.valueOf(currentHour % HOURS_IN_HALF_DAY);
        }
    }

    public void setCurrentMinute(Integer currentMinute) {
        if (this.mInitialMinute != currentMinute.intValue()) {
            this.mInitialMinute = currentMinute.intValue();
            updateHeaderMinute(currentMinute.intValue(), DEFAULT_ENABLED_STATE);
            this.mRadialTimePickerView.setCurrentMinute(currentMinute.intValue());
            this.mDelegator.invalidate();
            onTimeChanged();
        }
    }

    public Integer getCurrentMinute() {
        return Integer.valueOf(this.mRadialTimePickerView.getCurrentMinute());
    }

    public void setIs24HourView(Boolean is24HourView) {
        if (is24HourView.booleanValue() != this.mIs24HourView) {
            this.mIs24HourView = is24HourView.booleanValue();
            generateLegalTimesTree();
            int hour = this.mRadialTimePickerView.getCurrentHour();
            this.mInitialHourOfDay = hour;
            updateHeaderHour(hour, false);
            updateHeaderAmPm();
            updateRadialPicker(this.mRadialTimePickerView.getCurrentItemShowing());
            this.mDelegator.invalidate();
        }
    }

    public boolean is24HourView() {
        return this.mIs24HourView;
    }

    public void setOnTimeChangedListener(OnTimeChangedListener callback) {
        this.mOnTimeChangedListener = callback;
    }

    public void setEnabled(boolean enabled) {
        this.mHourView.setEnabled(enabled);
        this.mMinuteView.setEnabled(enabled);
        this.mAmLabel.setEnabled(enabled);
        this.mPmLabel.setEnabled(enabled);
        this.mRadialTimePickerView.setEnabled(enabled);
        this.mIsEnabled = enabled;
    }

    public boolean isEnabled() {
        return this.mIsEnabled;
    }

    public int getBaseline() {
        return -1;
    }

    public void onConfigurationChanged(Configuration newConfig) {
        updateUI(this.mRadialTimePickerView.getCurrentItemShowing());
    }

    public Parcelable onSaveInstanceState(Parcelable superState) {
        return new SavedState(getCurrentHour().intValue(), getCurrentMinute().intValue(), is24HourView(), inKbMode(), getTypedTimes(), getCurrentItemShowing(), null);
    }

    public void onRestoreInstanceState(Parcelable state) {
        SavedState ss = (SavedState) state;
        setInKbMode(ss.inKbMode());
        setTypedTimes(ss.getTypesTimes());
        initialize(ss.getHour(), ss.getMinute(), ss.is24HourMode(), ss.getCurrentItemShowing());
        this.mRadialTimePickerView.invalidate();
        if (this.mInKbMode) {
            tryStartingKbMode(-1);
            this.mHourView.invalidate();
        }
    }

    public void setCurrentLocale(Locale locale) {
        super.setCurrentLocale(locale);
        this.mTempCalendar = Calendar.getInstance(locale);
    }

    public boolean dispatchPopulateAccessibilityEvent(AccessibilityEvent event) {
        onPopulateAccessibilityEvent(event);
        return DEFAULT_ENABLED_STATE;
    }

    public void onPopulateAccessibilityEvent(AccessibilityEvent event) {
        int flags;
        if (this.mIs24HourView) {
            flags = PM | AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS;
        } else {
            flags = PM | 64;
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

    private void setInKbMode(boolean inKbMode) {
        this.mInKbMode = inKbMode;
    }

    private boolean inKbMode() {
        return this.mInKbMode;
    }

    private void setTypedTimes(ArrayList<Integer> typeTimes) {
        this.mTypedTimes = typeTimes;
    }

    private ArrayList<Integer> getTypedTimes() {
        return this.mTypedTimes;
    }

    private int getCurrentItemShowing() {
        return this.mRadialTimePickerView.getCurrentItemShowing();
    }

    private void onTimeChanged() {
        this.mDelegator.sendAccessibilityEvent(4);
        if (this.mOnTimeChangedListener != null) {
            this.mOnTimeChangedListener.onTimeChanged(this.mDelegator, getCurrentHour().intValue(), getCurrentMinute().intValue());
        }
    }

    private void tryVibrate() {
        this.mDelegator.performHapticFeedback(4);
    }

    private void updateAmPmLabelStates(int amOrPm) {
        boolean isAm;
        boolean isPm;
        float f = LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
        if (amOrPm == 0) {
            isAm = DEFAULT_ENABLED_STATE;
        } else {
            isAm = false;
        }
        this.mAmLabel.setChecked(isAm);
        this.mAmLabel.setAlpha(isAm ? LayoutParams.BRIGHTNESS_OVERRIDE_FULL : this.mDisabledAlpha);
        if (amOrPm == PM) {
            isPm = DEFAULT_ENABLED_STATE;
        } else {
            isPm = false;
        }
        this.mPmLabel.setChecked(isPm);
        CheckedTextView checkedTextView = this.mPmLabel;
        if (!isPm) {
            f = this.mDisabledAlpha;
        }
        checkedTextView.setAlpha(f);
    }

    public void onValueSelected(int pickerIndex, int newValue, boolean autoAdvance) {
        switch (pickerIndex) {
            case HOUR_INDEX /*0*/:
                if (!this.mAllowAutoAdvance || !autoAdvance) {
                    updateHeaderHour(newValue, DEFAULT_ENABLED_STATE);
                    break;
                }
                updateHeaderHour(newValue, false);
                setCurrentItemShowing(PM, DEFAULT_ENABLED_STATE, false);
                this.mDelegator.announceForAccessibility(newValue + ". " + this.mSelectMinutes);
                break;
                break;
            case PM /*1*/:
                updateHeaderMinute(newValue, DEFAULT_ENABLED_STATE);
                break;
            case AMPM_INDEX /*2*/:
                updateAmPmLabelStates(newValue);
                break;
            case ENABLE_PICKER_INDEX /*3*/:
                if (!isTypedTimeFullyLegal()) {
                    this.mTypedTimes.clear();
                }
                finishKbMode();
                break;
        }
        if (this.mOnTimeChangedListener != null) {
            this.mOnTimeChangedListener.onTimeChanged(this.mDelegator, getCurrentHour().intValue(), getCurrentMinute().intValue());
        }
    }

    private void updateHeaderHour(int value, boolean announce) {
        String format;
        Object[] objArr;
        CharSequence text;
        String bestDateTimePattern = DateFormat.getBestDateTimePattern(this.mCurrentLocale, this.mIs24HourView ? "Hm" : "hm");
        int lengthPattern = bestDateTimePattern.length();
        boolean hourWithTwoDigit = false;
        char hourFormat = '\u0000';
        int i = HOUR_INDEX;
        while (i < lengthPattern) {
            char c = bestDateTimePattern.charAt(i);
            if (c == 'H' || c == DateFormat.HOUR || c == 'K' || c == DateFormat.HOUR_OF_DAY) {
                hourFormat = c;
                if (i + PM < lengthPattern && c == bestDateTimePattern.charAt(i + PM)) {
                    hourWithTwoDigit = DEFAULT_ENABLED_STATE;
                }
                if (hourWithTwoDigit) {
                    format = "%d";
                } else {
                    format = "%02d";
                }
                if (this.mIs24HourView) {
                    value = modulo12(value, hourFormat != 'K' ? DEFAULT_ENABLED_STATE : false);
                } else if (hourFormat == DateFormat.HOUR_OF_DAY && value == 0) {
                    value = 24;
                }
                objArr = new Object[PM];
                objArr[HOUR_INDEX] = Integer.valueOf(value);
                text = String.format(format, objArr);
                this.mHourView.setText(text);
                if (announce) {
                    tryAnnounceForAccessibility(text, DEFAULT_ENABLED_STATE);
                }
            }
            i += PM;
        }
        if (hourWithTwoDigit) {
            format = "%d";
        } else {
            format = "%02d";
        }
        if (this.mIs24HourView) {
            if (hourFormat != 'K') {
            }
            value = modulo12(value, hourFormat != 'K' ? DEFAULT_ENABLED_STATE : false);
        } else {
            value = 24;
        }
        objArr = new Object[PM];
        objArr[HOUR_INDEX] = Integer.valueOf(value);
        text = String.format(format, objArr);
        this.mHourView.setText(text);
        if (announce) {
            tryAnnounceForAccessibility(text, DEFAULT_ENABLED_STATE);
        }
    }

    private void tryAnnounceForAccessibility(CharSequence text, boolean isHour) {
        if (this.mLastAnnouncedIsHour != isHour || !text.equals(this.mLastAnnouncedText)) {
            this.mDelegator.announceForAccessibility(text);
            this.mLastAnnouncedText = text;
            this.mLastAnnouncedIsHour = isHour;
        }
    }

    private static int modulo12(int n, boolean startWithZero) {
        int value = n % HOURS_IN_HALF_DAY;
        if (value != 0 || startWithZero) {
            return value;
        }
        return HOURS_IN_HALF_DAY;
    }

    private void updateHeaderSeparator() {
        CharSequence separatorText;
        String bestDateTimePattern = DateFormat.getBestDateTimePattern(this.mCurrentLocale, this.mIs24HourView ? "Hm" : "hm");
        int hIndex = lastIndexOfAny(bestDateTimePattern, new char[]{'H', DateFormat.HOUR, 'K', DateFormat.HOUR_OF_DAY});
        if (hIndex == -1) {
            separatorText = ":";
        } else {
            separatorText = Character.toString(bestDateTimePattern.charAt(hIndex + PM));
        }
        this.mSeparatorView.setText(separatorText);
    }

    private static int lastIndexOfAny(String str, char[] any) {
        int lengthAny = any.length;
        if (lengthAny > 0) {
            for (int i = str.length() - 1; i >= 0; i--) {
                char c = str.charAt(i);
                for (int j = HOUR_INDEX; j < lengthAny; j += PM) {
                    if (c == any[j]) {
                        return i;
                    }
                }
            }
        }
        return -1;
    }

    private void updateHeaderMinute(int value, boolean announceForAccessibility) {
        if (value == 60) {
            value = HOUR_INDEX;
        }
        Object[] objArr = new Object[PM];
        objArr[HOUR_INDEX] = Integer.valueOf(value);
        CharSequence text = String.format(this.mCurrentLocale, "%02d", objArr);
        this.mMinuteView.setText(text);
        if (announceForAccessibility) {
            tryAnnounceForAccessibility(text, false);
        }
    }

    private void setCurrentItemShowing(int index, boolean animateCircle, boolean announce) {
        boolean z;
        boolean z2 = DEFAULT_ENABLED_STATE;
        this.mRadialTimePickerView.setCurrentItemShowing(index, animateCircle);
        if (index == 0) {
            if (announce) {
                this.mDelegator.announceForAccessibility(this.mSelectHours);
            }
        } else if (announce) {
            this.mDelegator.announceForAccessibility(this.mSelectMinutes);
        }
        TextView textView = this.mHourView;
        if (index == 0) {
            z = DEFAULT_ENABLED_STATE;
        } else {
            z = false;
        }
        textView.setSelected(z);
        TextView textView2 = this.mMinuteView;
        if (index != PM) {
            z2 = false;
        }
        textView2.setSelected(z2);
    }

    private void setAmOrPm(int amOrPm) {
        updateAmPmLabelStates(amOrPm);
        this.mRadialTimePickerView.setAmOrPm(amOrPm);
    }

    private boolean processKeyUp(int keyCode) {
        if (keyCode == 67) {
            if (this.mInKbMode && !this.mTypedTimes.isEmpty()) {
                String deletedKeyStr;
                int deleted = deleteLastTypedKey();
                if (deleted == getAmOrPmKeyCode(HOUR_INDEX)) {
                    deletedKeyStr = this.mAmText;
                } else if (deleted == getAmOrPmKeyCode(PM)) {
                    deletedKeyStr = this.mPmText;
                } else {
                    Object[] objArr = new Object[PM];
                    objArr[HOUR_INDEX] = Integer.valueOf(getValFromKeyCode(deleted));
                    deletedKeyStr = String.format("%d", objArr);
                }
                TimePicker timePicker = this.mDelegator;
                String str = this.mDeletedKeyFormat;
                Object[] objArr2 = new Object[PM];
                objArr2[HOUR_INDEX] = deletedKeyStr;
                timePicker.announceForAccessibility(String.format(str, objArr2));
                updateDisplay(DEFAULT_ENABLED_STATE);
            }
        } else if (keyCode == 7 || keyCode == 8 || keyCode == 9 || keyCode == 10 || keyCode == 11 || keyCode == HOURS_IN_HALF_DAY || keyCode == 13 || keyCode == 14 || keyCode == 15 || keyCode == 16 || (!this.mIs24HourView && (keyCode == getAmOrPmKeyCode(HOUR_INDEX) || keyCode == getAmOrPmKeyCode(PM)))) {
            if (this.mInKbMode) {
                if (!addKeyIfLegal(keyCode)) {
                    return DEFAULT_ENABLED_STATE;
                }
                updateDisplay(false);
                return DEFAULT_ENABLED_STATE;
            } else if (this.mRadialTimePickerView == null) {
                Log.e(TAG, "Unable to initiate keyboard mode, TimePicker was null.");
                return DEFAULT_ENABLED_STATE;
            } else {
                this.mTypedTimes.clear();
                tryStartingKbMode(keyCode);
                return DEFAULT_ENABLED_STATE;
            }
        }
        return false;
    }

    private void tryStartingKbMode(int keyCode) {
        if (keyCode == -1 || addKeyIfLegal(keyCode)) {
            this.mInKbMode = DEFAULT_ENABLED_STATE;
            onValidationChanged(false);
            updateDisplay(false);
            this.mRadialTimePickerView.setInputEnabled(false);
        }
    }

    private boolean addKeyIfLegal(int keyCode) {
        if (this.mIs24HourView && this.mTypedTimes.size() == 4) {
            return false;
        }
        if (!this.mIs24HourView && isTypedTimeFullyLegal()) {
            return false;
        }
        this.mTypedTimes.add(Integer.valueOf(keyCode));
        if (isTypedTimeLegalSoFar()) {
            int val = getValFromKeyCode(keyCode);
            TimePicker timePicker = this.mDelegator;
            Object[] objArr = new Object[PM];
            objArr[HOUR_INDEX] = Integer.valueOf(val);
            timePicker.announceForAccessibility(String.format("%d", objArr));
            if (isTypedTimeFullyLegal()) {
                if (!this.mIs24HourView && this.mTypedTimes.size() <= ENABLE_PICKER_INDEX) {
                    this.mTypedTimes.add(this.mTypedTimes.size() - 1, Integer.valueOf(7));
                    this.mTypedTimes.add(this.mTypedTimes.size() - 1, Integer.valueOf(7));
                }
                onValidationChanged(DEFAULT_ENABLED_STATE);
            }
            return DEFAULT_ENABLED_STATE;
        }
        deleteLastTypedKey();
        return false;
    }

    private boolean isTypedTimeLegalSoFar() {
        Node node = this.mLegalTimesTree;
        Iterator i$ = this.mTypedTimes.iterator();
        while (i$.hasNext()) {
            node = node.canReach(((Integer) i$.next()).intValue());
            if (node == null) {
                return false;
            }
        }
        return DEFAULT_ENABLED_STATE;
    }

    private boolean isTypedTimeFullyLegal() {
        boolean z = false;
        if (this.mIs24HourView) {
            int[] values = getEnteredTime(null);
            if (values[HOUR_INDEX] < 0 || values[PM] < 0 || values[PM] >= 60) {
                return false;
            }
            return DEFAULT_ENABLED_STATE;
        }
        if (this.mTypedTimes.contains(Integer.valueOf(getAmOrPmKeyCode(HOUR_INDEX))) || this.mTypedTimes.contains(Integer.valueOf(getAmOrPmKeyCode(PM)))) {
            z = PM;
        }
        return z;
    }

    private int deleteLastTypedKey() {
        int deleted = ((Integer) this.mTypedTimes.remove(this.mTypedTimes.size() - 1)).intValue();
        if (!isTypedTimeFullyLegal()) {
            onValidationChanged(false);
        }
        return deleted;
    }

    private void finishKbMode() {
        this.mInKbMode = false;
        if (!this.mTypedTimes.isEmpty()) {
            int[] values = getEnteredTime(null);
            this.mRadialTimePickerView.setCurrentHour(values[HOUR_INDEX]);
            this.mRadialTimePickerView.setCurrentMinute(values[PM]);
            if (!this.mIs24HourView) {
                this.mRadialTimePickerView.setAmOrPm(values[AMPM_INDEX]);
            }
            this.mTypedTimes.clear();
        }
        updateDisplay(false);
        this.mRadialTimePickerView.setInputEnabled(DEFAULT_ENABLED_STATE);
    }

    private void updateDisplay(boolean allowEmptyDisplay) {
        if (allowEmptyDisplay || !this.mTypedTimes.isEmpty()) {
            CharSequence hourStr;
            Object[] objArr;
            CharSequence minuteStr;
            boolean[] enteredZeros = new boolean[]{false, false};
            int[] values = getEnteredTime(enteredZeros);
            String hourFormat = enteredZeros[HOUR_INDEX] ? "%02d" : "%2d";
            String minuteFormat = enteredZeros[PM] ? "%02d" : "%2d";
            if (values[HOUR_INDEX] == -1) {
                hourStr = this.mDoublePlaceholderText;
            } else {
                objArr = new Object[PM];
                objArr[HOUR_INDEX] = Integer.valueOf(values[HOUR_INDEX]);
                hourStr = String.format(hourFormat, objArr).replace(' ', this.mPlaceholderText);
            }
            if (values[PM] == -1) {
                minuteStr = this.mDoublePlaceholderText;
            } else {
                objArr = new Object[PM];
                objArr[HOUR_INDEX] = Integer.valueOf(values[PM]);
                minuteStr = String.format(minuteFormat, objArr).replace(' ', this.mPlaceholderText);
            }
            this.mHourView.setText(hourStr);
            this.mHourView.setSelected(false);
            this.mMinuteView.setText(minuteStr);
            this.mMinuteView.setSelected(false);
            if (!this.mIs24HourView) {
                updateAmPmLabelStates(values[AMPM_INDEX]);
                return;
            }
            return;
        }
        int hour = this.mRadialTimePickerView.getCurrentHour();
        int minute = this.mRadialTimePickerView.getCurrentMinute();
        updateHeaderHour(hour, false);
        updateHeaderMinute(minute, false);
        if (!this.mIs24HourView) {
            updateAmPmLabelStates(hour < HOURS_IN_HALF_DAY ? HOUR_INDEX : PM);
        }
        setCurrentItemShowing(this.mRadialTimePickerView.getCurrentItemShowing(), DEFAULT_ENABLED_STATE, DEFAULT_ENABLED_STATE);
        onValidationChanged(DEFAULT_ENABLED_STATE);
    }

    private int getValFromKeyCode(int keyCode) {
        switch (keyCode) {
            case SpellChecker.AVERAGE_WORD_LENGTH /*7*/:
                return HOUR_INDEX;
            case SetPendingIntentTemplate.TAG /*8*/:
                return PM;
            case SetOnClickFillInIntent.TAG /*9*/:
                return AMPM_INDEX;
            case SetRemoteViewsAdapterIntent.TAG /*10*/:
                return ENABLE_PICKER_INDEX;
            case TextViewDrawableAction.TAG /*11*/:
                return 4;
            case HOURS_IN_HALF_DAY /*12*/:
                return 5;
            case TextViewSizeAction.TAG /*13*/:
                return 6;
            case ViewPaddingAction.TAG /*14*/:
                return 7;
            case SetRemoteViewsAdapterList.TAG /*15*/:
                return 8;
            case RelativeLayout.START_OF /*16*/:
                return 9;
            default:
                return -1;
        }
    }

    private int[] getEnteredTime(boolean[] enteredZeros) {
        int amOrPm = -1;
        int startIndex = PM;
        if (!this.mIs24HourView && isTypedTimeFullyLegal()) {
            int keyCode = ((Integer) this.mTypedTimes.get(this.mTypedTimes.size() - 1)).intValue();
            if (keyCode == getAmOrPmKeyCode(HOUR_INDEX)) {
                amOrPm = HOUR_INDEX;
            } else if (keyCode == getAmOrPmKeyCode(PM)) {
                amOrPm = PM;
            }
            startIndex = AMPM_INDEX;
        }
        int minute = -1;
        int hour = -1;
        for (int i = startIndex; i <= this.mTypedTimes.size(); i += PM) {
            int val = getValFromKeyCode(((Integer) this.mTypedTimes.get(this.mTypedTimes.size() - i)).intValue());
            if (i == startIndex) {
                minute = val;
            } else if (i == startIndex + PM) {
                minute += val * 10;
                if (enteredZeros != null && val == 0) {
                    enteredZeros[PM] = DEFAULT_ENABLED_STATE;
                }
            } else if (i == startIndex + AMPM_INDEX) {
                hour = val;
            } else if (i == startIndex + ENABLE_PICKER_INDEX) {
                hour += val * 10;
                if (enteredZeros != null && val == 0) {
                    enteredZeros[HOUR_INDEX] = DEFAULT_ENABLED_STATE;
                }
            }
        }
        int[] iArr = new int[ENABLE_PICKER_INDEX];
        iArr[HOUR_INDEX] = hour;
        iArr[PM] = minute;
        iArr[AMPM_INDEX] = amOrPm;
        return iArr;
    }

    private int getAmOrPmKeyCode(int amOrPm) {
        if (this.mAmKeyCode == -1 || this.mPmKeyCode == -1) {
            KeyCharacterMap kcm = KeyCharacterMap.load(-1);
            CharSequence amText = this.mAmText.toLowerCase(this.mCurrentLocale);
            CharSequence pmText = this.mPmText.toLowerCase(this.mCurrentLocale);
            int N = Math.min(amText.length(), pmText.length());
            int i = HOUR_INDEX;
            while (i < N) {
                char amChar = amText.charAt(i);
                char pmChar = pmText.charAt(i);
                if (amChar != pmChar) {
                    char[] cArr = new char[AMPM_INDEX];
                    cArr[HOUR_INDEX] = amChar;
                    cArr[PM] = pmChar;
                    KeyEvent[] events = kcm.getEvents(cArr);
                    if (events == null || events.length != 4) {
                        Log.e(TAG, "Unable to find keycodes for AM and PM.");
                    } else {
                        this.mAmKeyCode = events[HOUR_INDEX].getKeyCode();
                        this.mPmKeyCode = events[AMPM_INDEX].getKeyCode();
                    }
                } else {
                    i += PM;
                }
            }
        }
        if (amOrPm == 0) {
            return this.mAmKeyCode;
        }
        if (amOrPm == PM) {
            return this.mPmKeyCode;
        }
        return -1;
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    private void generateLegalTimesTree() {
        /*
        r23 = this;
        r6 = 7;
        r7 = 8;
        r8 = 9;
        r9 = 10;
        r10 = 11;
        r11 = 12;
        r12 = 13;
        r13 = 14;
        r14 = 15;
        r15 = 16;
        r20 = new android.widget.TimePickerClockDelegate$Node;
        r21 = 0;
        r0 = r21;
        r0 = new int[r0];
        r21 = r0;
        r0 = r20;
        r1 = r23;
        r2 = r21;
        r0.<init>(r2);
        r0 = r20;
        r1 = r23;
        r1.mLegalTimesTree = r0;
        r0 = r23;
        r0 = r0.mIs24HourView;
        r20 = r0;
        if (r20 == 0) goto L_0x016a;
    L_0x0034:
        r16 = new android.widget.TimePickerClockDelegate$Node;
        r20 = 6;
        r0 = r20;
        r0 = new int[r0];
        r20 = r0;
        r20 = {7, 8, 9, 10, 11, 12};
        r0 = r16;
        r1 = r23;
        r2 = r20;
        r0.<init>(r2);
        r17 = new android.widget.TimePickerClockDelegate$Node;
        r20 = 10;
        r0 = r20;
        r0 = new int[r0];
        r20 = r0;
        r20 = {7, 8, 9, 10, 11, 12, 13, 14, 15, 16};
        r0 = r17;
        r1 = r23;
        r2 = r20;
        r0.<init>(r2);
        r16.addChild(r17);
        r4 = new android.widget.TimePickerClockDelegate$Node;
        r20 = 2;
        r0 = r20;
        r0 = new int[r0];
        r20 = r0;
        r20 = {7, 8};
        r0 = r23;
        r1 = r20;
        r4.<init>(r1);
        r0 = r23;
        r0 = r0.mLegalTimesTree;
        r20 = r0;
        r0 = r20;
        r0.addChild(r4);
        r18 = new android.widget.TimePickerClockDelegate$Node;
        r20 = 6;
        r0 = r20;
        r0 = new int[r0];
        r20 = r0;
        r20 = {7, 8, 9, 10, 11, 12};
        r0 = r18;
        r1 = r23;
        r2 = r20;
        r0.<init>(r2);
        r0 = r18;
        r4.addChild(r0);
        r0 = r18;
        r1 = r16;
        r0.addChild(r1);
        r19 = new android.widget.TimePickerClockDelegate$Node;
        r20 = 4;
        r0 = r20;
        r0 = new int[r0];
        r20 = r0;
        r20 = {13, 14, 15, 16};
        r0 = r19;
        r1 = r23;
        r2 = r20;
        r0.<init>(r2);
        r18.addChild(r19);
        r18 = new android.widget.TimePickerClockDelegate$Node;
        r20 = 4;
        r0 = r20;
        r0 = new int[r0];
        r20 = r0;
        r20 = {13, 14, 15, 16};
        r0 = r18;
        r1 = r23;
        r2 = r20;
        r0.<init>(r2);
        r0 = r18;
        r4.addChild(r0);
        r0 = r18;
        r1 = r16;
        r0.addChild(r1);
        r4 = new android.widget.TimePickerClockDelegate$Node;
        r20 = 1;
        r0 = r20;
        r0 = new int[r0];
        r20 = r0;
        r21 = 0;
        r22 = 9;
        r20[r21] = r22;
        r0 = r23;
        r1 = r20;
        r4.<init>(r1);
        r0 = r23;
        r0 = r0.mLegalTimesTree;
        r20 = r0;
        r0 = r20;
        r0.addChild(r4);
        r18 = new android.widget.TimePickerClockDelegate$Node;
        r20 = 4;
        r0 = r20;
        r0 = new int[r0];
        r20 = r0;
        r20 = {7, 8, 9, 10};
        r0 = r18;
        r1 = r23;
        r2 = r20;
        r0.<init>(r2);
        r0 = r18;
        r4.addChild(r0);
        r0 = r18;
        r1 = r16;
        r0.addChild(r1);
        r18 = new android.widget.TimePickerClockDelegate$Node;
        r20 = 2;
        r0 = r20;
        r0 = new int[r0];
        r20 = r0;
        r20 = {11, 12};
        r0 = r18;
        r1 = r23;
        r2 = r20;
        r0.<init>(r2);
        r0 = r18;
        r4.addChild(r0);
        r0 = r18;
        r1 = r17;
        r0.addChild(r1);
        r4 = new android.widget.TimePickerClockDelegate$Node;
        r20 = 7;
        r0 = r20;
        r0 = new int[r0];
        r20 = r0;
        r20 = {10, 11, 12, 13, 14, 15, 16};
        r0 = r23;
        r1 = r20;
        r4.<init>(r1);
        r0 = r23;
        r0 = r0.mLegalTimesTree;
        r20 = r0;
        r0 = r20;
        r0.addChild(r4);
        r0 = r16;
        r4.addChild(r0);
    L_0x0169:
        return;
    L_0x016a:
        r3 = new android.widget.TimePickerClockDelegate$Node;
        r20 = 2;
        r0 = r20;
        r0 = new int[r0];
        r20 = r0;
        r21 = 0;
        r22 = 0;
        r0 = r23;
        r1 = r22;
        r22 = r0.getAmOrPmKeyCode(r1);
        r20[r21] = r22;
        r21 = 1;
        r22 = 1;
        r0 = r23;
        r1 = r22;
        r22 = r0.getAmOrPmKeyCode(r1);
        r20[r21] = r22;
        r0 = r23;
        r1 = r20;
        r3.<init>(r1);
        r4 = new android.widget.TimePickerClockDelegate$Node;
        r20 = 1;
        r0 = r20;
        r0 = new int[r0];
        r20 = r0;
        r21 = 0;
        r22 = 8;
        r20[r21] = r22;
        r0 = r23;
        r1 = r20;
        r4.<init>(r1);
        r0 = r23;
        r0 = r0.mLegalTimesTree;
        r20 = r0;
        r0 = r20;
        r0.addChild(r4);
        r4.addChild(r3);
        r18 = new android.widget.TimePickerClockDelegate$Node;
        r20 = 3;
        r0 = r20;
        r0 = new int[r0];
        r20 = r0;
        r20 = {7, 8, 9};
        r0 = r18;
        r1 = r23;
        r2 = r20;
        r0.<init>(r2);
        r0 = r18;
        r4.addChild(r0);
        r0 = r18;
        r0.addChild(r3);
        r19 = new android.widget.TimePickerClockDelegate$Node;
        r20 = 6;
        r0 = r20;
        r0 = new int[r0];
        r20 = r0;
        r20 = {7, 8, 9, 10, 11, 12};
        r0 = r19;
        r1 = r23;
        r2 = r20;
        r0.<init>(r2);
        r18.addChild(r19);
        r0 = r19;
        r0.addChild(r3);
        r5 = new android.widget.TimePickerClockDelegate$Node;
        r20 = 10;
        r0 = r20;
        r0 = new int[r0];
        r20 = r0;
        r20 = {7, 8, 9, 10, 11, 12, 13, 14, 15, 16};
        r0 = r23;
        r1 = r20;
        r5.<init>(r1);
        r0 = r19;
        r0.addChild(r5);
        r5.addChild(r3);
        r19 = new android.widget.TimePickerClockDelegate$Node;
        r20 = 4;
        r0 = r20;
        r0 = new int[r0];
        r20 = r0;
        r20 = {13, 14, 15, 16};
        r0 = r19;
        r1 = r23;
        r2 = r20;
        r0.<init>(r2);
        r18.addChild(r19);
        r0 = r19;
        r0.addChild(r3);
        r18 = new android.widget.TimePickerClockDelegate$Node;
        r20 = 3;
        r0 = r20;
        r0 = new int[r0];
        r20 = r0;
        r20 = {10, 11, 12};
        r0 = r18;
        r1 = r23;
        r2 = r20;
        r0.<init>(r2);
        r0 = r18;
        r4.addChild(r0);
        r19 = new android.widget.TimePickerClockDelegate$Node;
        r20 = 10;
        r0 = r20;
        r0 = new int[r0];
        r20 = r0;
        r20 = {7, 8, 9, 10, 11, 12, 13, 14, 15, 16};
        r0 = r19;
        r1 = r23;
        r2 = r20;
        r0.<init>(r2);
        r18.addChild(r19);
        r0 = r19;
        r0.addChild(r3);
        r4 = new android.widget.TimePickerClockDelegate$Node;
        r20 = 8;
        r0 = r20;
        r0 = new int[r0];
        r20 = r0;
        r20 = {9, 10, 11, 12, 13, 14, 15, 16};
        r0 = r23;
        r1 = r20;
        r4.<init>(r1);
        r0 = r23;
        r0 = r0.mLegalTimesTree;
        r20 = r0;
        r0 = r20;
        r0.addChild(r4);
        r4.addChild(r3);
        r18 = new android.widget.TimePickerClockDelegate$Node;
        r20 = 6;
        r0 = r20;
        r0 = new int[r0];
        r20 = r0;
        r20 = {7, 8, 9, 10, 11, 12};
        r0 = r18;
        r1 = r23;
        r2 = r20;
        r0.<init>(r2);
        r0 = r18;
        r4.addChild(r0);
        r19 = new android.widget.TimePickerClockDelegate$Node;
        r20 = 10;
        r0 = r20;
        r0 = new int[r0];
        r20 = r0;
        r20 = {7, 8, 9, 10, 11, 12, 13, 14, 15, 16};
        r0 = r19;
        r1 = r23;
        r2 = r20;
        r0.<init>(r2);
        r18.addChild(r19);
        r0 = r19;
        r0.addChild(r3);
        goto L_0x0169;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.widget.TimePickerClockDelegate.generateLegalTimesTree():void");
    }
}
