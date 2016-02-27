package android.widget;

import android.C0000R;
import android.content.Context;
import android.content.res.ColorStateList;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Paint.Align;
import android.graphics.Paint.Style;
import android.graphics.Rect;
import android.graphics.Typeface;
import android.os.Bundle;
import android.text.format.DateFormat;
import android.text.format.DateUtils;
import android.text.format.Time;
import android.util.AttributeSet;
import android.util.IntArray;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.AccessibilityDelegate;
import android.view.View.MeasureSpec;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import com.android.internal.widget.ExploreByTouchHelper;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Formatter;
import java.util.Locale;

class SimpleMonthView extends View {
    private static final int DAY_SEPARATOR_WIDTH = 1;
    private static final int DEFAULT_HEIGHT = 32;
    private static final int DEFAULT_NUM_DAYS = 7;
    private static final int DEFAULT_NUM_ROWS = 6;
    private static final int DEFAULT_SELECTED_DAY = -1;
    private static final int DEFAULT_WEEK_START = 1;
    private static final int MAX_NUM_ROWS = 6;
    private static final int MIN_HEIGHT = 10;
    private static final int SELECTED_CIRCLE_ALPHA = 60;
    private final Calendar mCalendar;
    private SimpleDateFormat mDayFormatter;
    private final Calendar mDayLabelCalendar;
    private Paint mDayNumberDisabledPaint;
    private Paint mDayNumberPaint;
    private Paint mDayNumberSelectedPaint;
    private int mDayOfWeekStart;
    private String mDayOfWeekTypeface;
    private final int mDaySelectedCircleSize;
    private int mDisabledTextColor;
    private int mEnabledDayEnd;
    private int mEnabledDayStart;
    private final Formatter mFormatter;
    private boolean mHasToday;
    private boolean mLockAccessibilityDelegate;
    private final int mMiniDayNumberTextSize;
    private int mMonth;
    private Paint mMonthDayLabelPaint;
    private final int mMonthDayLabelTextSize;
    private final int mMonthHeaderSize;
    private final int mMonthLabelTextSize;
    private Paint mMonthTitlePaint;
    private String mMonthTitleTypeface;
    private int mNormalTextColor;
    private int mNumCells;
    private int mNumDays;
    private int mNumRows;
    private OnDayClickListener mOnDayClickListener;
    private int mPadding;
    private int mRowHeight;
    private int mSelectedDay;
    private int mSelectedDayColor;
    private final StringBuilder mStringBuilder;
    private int mToday;
    private final MonthViewTouchHelper mTouchHelper;
    private int mWeekStart;
    private int mWidth;
    private int mYear;

    public interface OnDayClickListener {
        void onDayClick(SimpleMonthView simpleMonthView, Calendar calendar);
    }

    private class MonthViewTouchHelper extends ExploreByTouchHelper {
        private static final String DATE_FORMAT = "dd MMMM yyyy";
        private final Calendar mTempCalendar;
        private final Rect mTempRect;

        public MonthViewTouchHelper(View host) {
            super(host);
            this.mTempRect = new Rect();
            this.mTempCalendar = Calendar.getInstance();
        }

        public void setFocusedVirtualView(int virtualViewId) {
            getAccessibilityNodeProvider(SimpleMonthView.this).performAction(virtualViewId, 64, null);
        }

        public void clearFocusedVirtualView() {
            int focusedVirtualView = getFocusedVirtualView();
            if (focusedVirtualView != RtlSpacingHelper.UNDEFINED) {
                getAccessibilityNodeProvider(SimpleMonthView.this).performAction(focusedVirtualView, AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS, null);
            }
        }

        protected int getVirtualViewAt(float x, float y) {
            int day = SimpleMonthView.this.getDayFromLocation(x, y);
            return day >= 0 ? day : RtlSpacingHelper.UNDEFINED;
        }

        protected void getVisibleVirtualViews(IntArray virtualViewIds) {
            for (int day = SimpleMonthView.DEFAULT_WEEK_START; day <= SimpleMonthView.this.mNumCells; day += SimpleMonthView.DEFAULT_WEEK_START) {
                virtualViewIds.add(day);
            }
        }

        protected void onPopulateEventForVirtualView(int virtualViewId, AccessibilityEvent event) {
            event.setContentDescription(getItemDescription(virtualViewId));
        }

        protected void onPopulateNodeForVirtualView(int virtualViewId, AccessibilityNodeInfo node) {
            getItemBounds(virtualViewId, this.mTempRect);
            node.setContentDescription(getItemDescription(virtualViewId));
            node.setBoundsInParent(this.mTempRect);
            node.addAction(16);
            if (virtualViewId == SimpleMonthView.this.mSelectedDay) {
                node.setSelected(true);
            }
        }

        protected boolean onPerformActionForVirtualView(int virtualViewId, int action, Bundle arguments) {
            switch (action) {
                case RelativeLayout.START_OF /*16*/:
                    SimpleMonthView.this.onDayClick(virtualViewId);
                    return true;
                default:
                    return false;
            }
        }

        private void getItemBounds(int day, Rect rect) {
            int offsetX = SimpleMonthView.this.mPadding;
            int offsetY = SimpleMonthView.this.mMonthHeaderSize;
            int cellHeight = SimpleMonthView.this.mRowHeight;
            int cellWidth = (SimpleMonthView.this.mWidth - (SimpleMonthView.this.mPadding * 2)) / SimpleMonthView.this.mNumDays;
            int index = (day + SimpleMonthView.DEFAULT_SELECTED_DAY) + SimpleMonthView.this.findDayOffset();
            int x = offsetX + ((index % SimpleMonthView.this.mNumDays) * cellWidth);
            int y = offsetY + ((index / SimpleMonthView.this.mNumDays) * cellHeight);
            rect.set(x, y, x + cellWidth, y + cellHeight);
        }

        private CharSequence getItemDescription(int day) {
            this.mTempCalendar.set(SimpleMonthView.this.mYear, SimpleMonthView.this.mMonth, day);
            CharSequence date = DateFormat.format(DATE_FORMAT, this.mTempCalendar.getTimeInMillis());
            if (day != SimpleMonthView.this.mSelectedDay) {
                return date;
            }
            Context context = SimpleMonthView.this.getContext();
            Object[] objArr = new Object[SimpleMonthView.DEFAULT_WEEK_START];
            objArr[0] = date;
            return context.getString(17041039, objArr);
        }
    }

    public SimpleMonthView(Context context) {
        this(context, null);
    }

    public SimpleMonthView(Context context, AttributeSet attrs) {
        this(context, attrs, 16843612);
    }

    public SimpleMonthView(Context context, AttributeSet attrs, int defStyleAttr) {
        this(context, attrs, defStyleAttr, 0);
    }

    public SimpleMonthView(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
        this.mDayFormatter = new SimpleDateFormat("EEEEE", Locale.getDefault());
        this.mPadding = 0;
        this.mRowHeight = DEFAULT_HEIGHT;
        this.mHasToday = false;
        this.mSelectedDay = DEFAULT_SELECTED_DAY;
        this.mToday = DEFAULT_SELECTED_DAY;
        this.mWeekStart = DEFAULT_WEEK_START;
        this.mNumDays = DEFAULT_NUM_DAYS;
        this.mNumCells = this.mNumDays;
        this.mDayOfWeekStart = 0;
        this.mEnabledDayStart = DEFAULT_WEEK_START;
        this.mEnabledDayEnd = 31;
        this.mCalendar = Calendar.getInstance();
        this.mDayLabelCalendar = Calendar.getInstance();
        this.mNumRows = MAX_NUM_ROWS;
        Resources res = context.getResources();
        this.mDayOfWeekTypeface = res.getString(17041045);
        this.mMonthTitleTypeface = res.getString(17041044);
        this.mStringBuilder = new StringBuilder(50);
        this.mFormatter = new Formatter(this.mStringBuilder, Locale.getDefault());
        this.mMiniDayNumberTextSize = res.getDimensionPixelSize(17105036);
        this.mMonthLabelTextSize = res.getDimensionPixelSize(17105037);
        this.mMonthDayLabelTextSize = res.getDimensionPixelSize(17105038);
        this.mMonthHeaderSize = res.getDimensionPixelOffset(17105039);
        this.mDaySelectedCircleSize = res.getDimensionPixelSize(17105040);
        this.mRowHeight = (res.getDimensionPixelOffset(17105041) - this.mMonthHeaderSize) / MAX_NUM_ROWS;
        this.mTouchHelper = new MonthViewTouchHelper(this);
        setAccessibilityDelegate(this.mTouchHelper);
        setImportantForAccessibility(DEFAULT_WEEK_START);
        this.mLockAccessibilityDelegate = true;
        initView();
    }

    protected void onConfigurationChanged(Configuration newConfig) {
        super.onConfigurationChanged(newConfig);
        this.mDayFormatter = new SimpleDateFormat("EEEEE", newConfig.locale);
    }

    void setTextColor(ColorStateList colors) {
        Resources res = getContext().getResources();
        this.mNormalTextColor = colors.getColorForState(ENABLED_STATE_SET, res.getColor(17170599));
        this.mMonthTitlePaint.setColor(this.mNormalTextColor);
        this.mMonthDayLabelPaint.setColor(this.mNormalTextColor);
        this.mDisabledTextColor = colors.getColorForState(EMPTY_STATE_SET, res.getColor(17170601));
        this.mDayNumberDisabledPaint.setColor(this.mDisabledTextColor);
        this.mSelectedDayColor = colors.getColorForState(ENABLED_SELECTED_STATE_SET, res.getColor(C0000R.color.holo_blue_light));
        this.mDayNumberSelectedPaint.setColor(this.mSelectedDayColor);
        this.mDayNumberSelectedPaint.setAlpha(SELECTED_CIRCLE_ALPHA);
    }

    public void setAccessibilityDelegate(AccessibilityDelegate delegate) {
        if (!this.mLockAccessibilityDelegate) {
            super.setAccessibilityDelegate(delegate);
        }
    }

    public void setOnDayClickListener(OnDayClickListener listener) {
        this.mOnDayClickListener = listener;
    }

    public boolean dispatchHoverEvent(MotionEvent event) {
        if (this.mTouchHelper.dispatchHoverEvent(event)) {
            return true;
        }
        return super.dispatchHoverEvent(event);
    }

    public boolean onTouchEvent(MotionEvent event) {
        switch (event.getAction()) {
            case DEFAULT_WEEK_START /*1*/:
                int day = getDayFromLocation(event.getX(), event.getY());
                if (day >= 0) {
                    onDayClick(day);
                    break;
                }
                break;
        }
        return true;
    }

    private void initView() {
        this.mMonthTitlePaint = new Paint();
        this.mMonthTitlePaint.setAntiAlias(true);
        this.mMonthTitlePaint.setColor(this.mNormalTextColor);
        this.mMonthTitlePaint.setTextSize((float) this.mMonthLabelTextSize);
        this.mMonthTitlePaint.setTypeface(Typeface.create(this.mMonthTitleTypeface, (int) DEFAULT_WEEK_START));
        this.mMonthTitlePaint.setTextAlign(Align.CENTER);
        this.mMonthTitlePaint.setStyle(Style.FILL);
        this.mMonthTitlePaint.setFakeBoldText(true);
        this.mMonthDayLabelPaint = new Paint();
        this.mMonthDayLabelPaint.setAntiAlias(true);
        this.mMonthDayLabelPaint.setColor(this.mNormalTextColor);
        this.mMonthDayLabelPaint.setTextSize((float) this.mMonthDayLabelTextSize);
        this.mMonthDayLabelPaint.setTypeface(Typeface.create(this.mDayOfWeekTypeface, 0));
        this.mMonthDayLabelPaint.setTextAlign(Align.CENTER);
        this.mMonthDayLabelPaint.setStyle(Style.FILL);
        this.mMonthDayLabelPaint.setFakeBoldText(true);
        this.mDayNumberSelectedPaint = new Paint();
        this.mDayNumberSelectedPaint.setAntiAlias(true);
        this.mDayNumberSelectedPaint.setColor(this.mSelectedDayColor);
        this.mDayNumberSelectedPaint.setAlpha(SELECTED_CIRCLE_ALPHA);
        this.mDayNumberSelectedPaint.setTextAlign(Align.CENTER);
        this.mDayNumberSelectedPaint.setStyle(Style.FILL);
        this.mDayNumberSelectedPaint.setFakeBoldText(true);
        this.mDayNumberPaint = new Paint();
        this.mDayNumberPaint.setAntiAlias(true);
        this.mDayNumberPaint.setTextSize((float) this.mMiniDayNumberTextSize);
        this.mDayNumberPaint.setTextAlign(Align.CENTER);
        this.mDayNumberPaint.setStyle(Style.FILL);
        this.mDayNumberPaint.setFakeBoldText(false);
        this.mDayNumberDisabledPaint = new Paint();
        this.mDayNumberDisabledPaint.setAntiAlias(true);
        this.mDayNumberDisabledPaint.setColor(this.mDisabledTextColor);
        this.mDayNumberDisabledPaint.setTextSize((float) this.mMiniDayNumberTextSize);
        this.mDayNumberDisabledPaint.setTextAlign(Align.CENTER);
        this.mDayNumberDisabledPaint.setStyle(Style.FILL);
        this.mDayNumberDisabledPaint.setFakeBoldText(false);
    }

    protected void onDraw(Canvas canvas) {
        drawMonthTitle(canvas);
        drawWeekDayLabels(canvas);
        drawDays(canvas);
    }

    private static boolean isValidDayOfWeek(int day) {
        return day >= DEFAULT_WEEK_START && day <= DEFAULT_NUM_DAYS;
    }

    private static boolean isValidMonth(int month) {
        return month >= 0 && month <= 11;
    }

    void setMonthParams(int selectedDay, int month, int year, int weekStart, int enabledDayStart, int enabledDayEnd) {
        if (this.mRowHeight < MIN_HEIGHT) {
            this.mRowHeight = MIN_HEIGHT;
        }
        this.mSelectedDay = selectedDay;
        if (isValidMonth(month)) {
            this.mMonth = month;
        }
        this.mYear = year;
        Time today = new Time(Time.getCurrentTimezone());
        today.setToNow();
        this.mHasToday = false;
        this.mToday = DEFAULT_SELECTED_DAY;
        this.mCalendar.set(2, this.mMonth);
        this.mCalendar.set(DEFAULT_WEEK_START, this.mYear);
        this.mCalendar.set(5, DEFAULT_WEEK_START);
        this.mDayOfWeekStart = this.mCalendar.get(DEFAULT_NUM_DAYS);
        if (isValidDayOfWeek(weekStart)) {
            this.mWeekStart = weekStart;
        } else {
            this.mWeekStart = this.mCalendar.getFirstDayOfWeek();
        }
        if (enabledDayStart > 0 && enabledDayEnd < DEFAULT_HEIGHT) {
            this.mEnabledDayStart = enabledDayStart;
        }
        if (enabledDayEnd > 0 && enabledDayEnd < DEFAULT_HEIGHT && enabledDayEnd >= enabledDayStart) {
            this.mEnabledDayEnd = enabledDayEnd;
        }
        this.mNumCells = getDaysInMonth(this.mMonth, this.mYear);
        for (int i = 0; i < this.mNumCells; i += DEFAULT_WEEK_START) {
            int day = i + DEFAULT_WEEK_START;
            if (sameDay(day, today)) {
                this.mHasToday = true;
                this.mToday = day;
            }
        }
        this.mNumRows = calculateNumRows();
        this.mTouchHelper.invalidateRoot();
    }

    private static int getDaysInMonth(int month, int year) {
        switch (month) {
            case Toast.LENGTH_SHORT /*0*/:
            case Action.MERGE_IGNORE /*2*/:
            case ViewGroupAction.TAG /*4*/:
            case MAX_NUM_ROWS /*6*/:
            case DEFAULT_NUM_DAYS /*7*/:
            case SetOnClickFillInIntent.TAG /*9*/:
            case TextViewDrawableAction.TAG /*11*/:
                return 31;
            case DEFAULT_WEEK_START /*1*/:
                return year % 4 == 0 ? 29 : 28;
            case SetDrawableParameters.TAG /*3*/:
            case ReflectionActionWithoutParams.TAG /*5*/:
            case SetPendingIntentTemplate.TAG /*8*/:
            case MIN_HEIGHT /*10*/:
                return 30;
            default:
                throw new IllegalArgumentException("Invalid Month");
        }
    }

    public void reuse() {
        this.mNumRows = MAX_NUM_ROWS;
        requestLayout();
    }

    private int calculateNumRows() {
        int offset = findDayOffset();
        return ((this.mNumCells + offset) % this.mNumDays > 0 ? DEFAULT_WEEK_START : 0) + ((this.mNumCells + offset) / this.mNumDays);
    }

    private boolean sameDay(int day, Time today) {
        return this.mYear == today.year && this.mMonth == today.month && day == today.monthDay;
    }

    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        setMeasuredDimension(MeasureSpec.getSize(widthMeasureSpec), (this.mRowHeight * this.mNumRows) + this.mMonthHeaderSize);
    }

    protected void onSizeChanged(int w, int h, int oldw, int oldh) {
        this.mWidth = w;
        this.mTouchHelper.invalidateRoot();
    }

    private String getMonthAndYearString() {
        this.mStringBuilder.setLength(0);
        long millis = this.mCalendar.getTimeInMillis();
        return DateUtils.formatDateRange(getContext(), this.mFormatter, millis, millis, 52, Time.getCurrentTimezone()).toString();
    }

    private void drawMonthTitle(Canvas canvas) {
        canvas.drawText(getMonthAndYearString(), ((float) (this.mWidth + (this.mPadding * 2))) / 2.0f, ((float) (this.mMonthHeaderSize - this.mMonthDayLabelTextSize)) / 2.0f, this.mMonthTitlePaint);
    }

    private void drawWeekDayLabels(Canvas canvas) {
        int y = this.mMonthHeaderSize - (this.mMonthDayLabelTextSize / 2);
        int dayWidthHalf = (this.mWidth - (this.mPadding * 2)) / (this.mNumDays * 2);
        for (int i = 0; i < this.mNumDays; i += DEFAULT_WEEK_START) {
            this.mDayLabelCalendar.set(DEFAULT_NUM_DAYS, (this.mWeekStart + i) % this.mNumDays);
            canvas.drawText(this.mDayFormatter.format(this.mDayLabelCalendar.getTime()), (float) ((((i * 2) + DEFAULT_WEEK_START) * dayWidthHalf) + this.mPadding), (float) y, this.mMonthDayLabelPaint);
        }
    }

    private void drawDays(Canvas canvas) {
        int y = (((this.mRowHeight + this.mMiniDayNumberTextSize) / 2) + DEFAULT_SELECTED_DAY) + this.mMonthHeaderSize;
        int dayWidthHalf = (this.mWidth - (this.mPadding * 2)) / (this.mNumDays * 2);
        int j = findDayOffset();
        int day = DEFAULT_WEEK_START;
        while (day <= this.mNumCells) {
            int x = (((j * 2) + DEFAULT_WEEK_START) * dayWidthHalf) + this.mPadding;
            if (this.mSelectedDay == day) {
                canvas.drawCircle((float) x, (float) (y - (this.mMiniDayNumberTextSize / 3)), (float) this.mDaySelectedCircleSize, this.mDayNumberSelectedPaint);
            }
            if (this.mHasToday && this.mToday == day) {
                this.mDayNumberPaint.setColor(this.mSelectedDayColor);
            } else {
                this.mDayNumberPaint.setColor(this.mNormalTextColor);
            }
            Paint paint = (day < this.mEnabledDayStart || day > this.mEnabledDayEnd) ? this.mDayNumberDisabledPaint : this.mDayNumberPaint;
            Object[] objArr = new Object[DEFAULT_WEEK_START];
            objArr[0] = Integer.valueOf(day);
            canvas.drawText(String.format("%d", objArr), (float) x, (float) y, paint);
            j += DEFAULT_WEEK_START;
            if (j == this.mNumDays) {
                j = 0;
                y += this.mRowHeight;
            }
            day += DEFAULT_WEEK_START;
        }
    }

    private int findDayOffset() {
        return (this.mDayOfWeekStart < this.mWeekStart ? this.mDayOfWeekStart + this.mNumDays : this.mDayOfWeekStart) - this.mWeekStart;
    }

    private int getDayFromLocation(float x, float y) {
        int dayStart = this.mPadding;
        if (x < ((float) dayStart) || x > ((float) (this.mWidth - this.mPadding))) {
            return DEFAULT_SELECTED_DAY;
        }
        int day = ((((int) (((x - ((float) dayStart)) * ((float) this.mNumDays)) / ((float) ((this.mWidth - dayStart) - this.mPadding)))) - findDayOffset()) + DEFAULT_WEEK_START) + (this.mNumDays * (((int) (y - ((float) this.mMonthHeaderSize))) / this.mRowHeight));
        if (day < DEFAULT_WEEK_START || day > this.mNumCells) {
            return DEFAULT_SELECTED_DAY;
        }
        return day;
    }

    private void onDayClick(int day) {
        if (this.mOnDayClickListener != null) {
            Calendar date = Calendar.getInstance();
            date.set(this.mYear, this.mMonth, day);
            this.mOnDayClickListener.onDayClick(this, date);
        }
        this.mTouchHelper.sendEventForVirtualView(day, DEFAULT_WEEK_START);
    }

    Calendar getAccessibilityFocus() {
        int day = this.mTouchHelper.getFocusedVirtualView();
        if (day < 0) {
            return null;
        }
        Calendar date = Calendar.getInstance();
        date.set(this.mYear, this.mMonth, day);
        return date;
    }

    public void clearAccessibilityFocus() {
        this.mTouchHelper.clearFocusedVirtualView();
    }

    boolean restoreAccessibilityFocus(Calendar day) {
        if (day.get(DEFAULT_WEEK_START) != this.mYear || day.get(2) != this.mMonth || day.get(5) > this.mNumCells) {
            return false;
        }
        this.mTouchHelper.setFocusedVirtualView(day.get(5));
        return true;
    }
}
