package android.widget;

import android.animation.Animator;
import android.animation.AnimatorSet;
import android.animation.Keyframe;
import android.animation.ObjectAnimator;
import android.animation.PropertyValuesHolder;
import android.animation.ValueAnimator;
import android.animation.ValueAnimator.AnimatorUpdateListener;
import android.content.Context;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Paint.Align;
import android.graphics.Rect;
import android.graphics.Typeface;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.util.AttributeSet;
import android.util.IntArray;
import android.util.Log;
import android.util.MathUtils;
import android.util.TypedValue;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.MeasureSpec;
import android.view.View.OnTouchListener;
import android.view.ViewGroup;
import android.view.WindowManager.LayoutParams;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.accessibility.AccessibilityNodeInfo.AccessibilityAction;
import com.android.internal.R;
import com.android.internal.widget.ExploreByTouchHelper;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Locale;

public class RadialTimePickerView extends View implements OnTouchListener {
    private static final int ALPHA_OPAQUE = 255;
    private static final int ALPHA_SELECTOR = 60;
    private static final int ALPHA_TRANSPARENT = 0;
    private static final int AM = 0;
    private static final int CENTER_RADIUS = 2;
    private static final float COSINE_30_DEGREES;
    private static final boolean DEBUG = false;
    private static final int DEBUG_COLOR = 553582592;
    private static final int DEBUG_STROKE_WIDTH = 2;
    private static final int DEBUG_TEXT_COLOR = 1627324416;
    private static final int DEGREES_FOR_ONE_HOUR = 30;
    private static final int DEGREES_FOR_ONE_MINUTE = 6;
    private static final int HOURS = 0;
    private static final int HOURS_INNER = 2;
    private static final int[] HOURS_NUMBERS;
    private static final int[] HOURS_NUMBERS_24;
    private static final int MINUTES = 1;
    private static final int[] MINUTES_NUMBERS;
    private static final int PM = 1;
    private static final int SELECTOR_CIRCLE = 0;
    private static final int SELECTOR_DOT = 1;
    private static final int SELECTOR_LINE = 2;
    private static final float SINE_30_DEGREES = 0.5f;
    private static final String TAG = "ClockView";
    private static int[] sSnapPrefer30sMap;
    private final IntHolder[] mAlpha;
    private final IntHolder[][] mAlphaSelector;
    private int mAmOrPm;
    private final float[] mAnimationRadiusMultiplier;
    boolean mChangedDuringTouch;
    private final float[] mCircleRadius;
    private final float[] mCircleRadiusMultiplier;
    private final int[] mColor;
    private final int[][] mColorSelector;
    private int mDisabledAlpha;
    private int mHalfwayHypotenusePoint;
    private final String[] mHours12Texts;
    private final ArrayList<Animator> mHoursToMinutesAnims;
    private final String[] mInnerHours24Texts;
    private final float[] mInnerTextGridHeights;
    private final float[] mInnerTextGridWidths;
    private String[] mInnerTextHours;
    private float mInnerTextSize;
    private boolean mInputEnabled;
    private final InvalidateUpdateListener mInvalidateUpdateListener;
    private boolean mIs24HourMode;
    private boolean mIsOnInnerCircle;
    private final int[] mLineLength;
    private OnValueSelectedListener mListener;
    private int mMaxHypotenuseForOuterNumber;
    private int mMinHypotenuseForInnerNumber;
    private final ArrayList<Animator> mMinuteToHoursAnims;
    private final String[] mMinutesTexts;
    private final float[] mNumbersRadiusMultiplier;
    private final String[] mOuterHours24Texts;
    private String[] mOuterTextHours;
    private String[] mOuterTextMinutes;
    private final Paint[] mPaint;
    private final Paint mPaintBackground;
    private final Paint mPaintCenter;
    private final Paint mPaintDebug;
    private final Paint[][] mPaintSelector;
    private final int[] mSelectionDegrees;
    private final int[] mSelectionRadius;
    private final float mSelectionRadiusMultiplier;
    private boolean mShowHours;
    private final float[][] mTextGridHeights;
    private final float[][] mTextGridWidths;
    private final float[] mTextSize;
    private final float[] mTextSizeMultiplier;
    private final RadialPickerTouchHelper mTouchHelper;
    private AnimatorSet mTransition;
    private final float mTransitionEndRadiusMultiplier;
    private final float mTransitionMidRadiusMultiplier;
    private final Typeface mTypeface;
    private int mXCenter;
    private int mYCenter;

    private static class IntHolder {
        private int mValue;

        public IntHolder(int value) {
            this.mValue = value;
        }

        public void setValue(int value) {
            this.mValue = value;
        }

        public int getValue() {
            return this.mValue;
        }
    }

    private class InvalidateUpdateListener implements AnimatorUpdateListener {
        private InvalidateUpdateListener() {
        }

        public void onAnimationUpdate(ValueAnimator animation) {
            RadialTimePickerView.this.invalidate();
        }
    }

    public interface OnValueSelectedListener {
        void onValueSelected(int i, int i2, boolean z);
    }

    private class RadialPickerTouchHelper extends ExploreByTouchHelper {
        private final int MASK_TYPE;
        private final int MASK_VALUE;
        private final int MINUTE_INCREMENT;
        private final int SHIFT_TYPE;
        private final int SHIFT_VALUE;
        private final int TYPE_HOUR;
        private final int TYPE_MINUTE;
        private final Rect mTempRect;

        public RadialPickerTouchHelper() {
            super(RadialTimePickerView.this);
            this.mTempRect = new Rect();
            this.TYPE_HOUR = RadialTimePickerView.SELECTOR_DOT;
            this.TYPE_MINUTE = RadialTimePickerView.SELECTOR_LINE;
            this.SHIFT_TYPE = RadialTimePickerView.SELECTOR_CIRCLE;
            this.MASK_TYPE = 15;
            this.SHIFT_VALUE = 8;
            this.MASK_VALUE = RadialTimePickerView.ALPHA_OPAQUE;
            this.MINUTE_INCREMENT = 5;
        }

        public void onInitializeAccessibilityNodeInfo(View host, AccessibilityNodeInfo info) {
            super.onInitializeAccessibilityNodeInfo(host, info);
            info.addAction(AccessibilityAction.ACTION_SCROLL_FORWARD);
            info.addAction(AccessibilityAction.ACTION_SCROLL_BACKWARD);
        }

        public boolean performAccessibilityAction(View host, int action, Bundle arguments) {
            if (super.performAccessibilityAction(host, action, arguments)) {
                return true;
            }
            switch (action) {
                case AccessibilityNodeInfo.ACTION_SCROLL_FORWARD /*4096*/:
                    adjustPicker(RadialTimePickerView.SELECTOR_DOT);
                    return true;
                case AccessibilityNodeInfo.ACTION_SCROLL_BACKWARD /*8192*/:
                    adjustPicker(-1);
                    return true;
                default:
                    return RadialTimePickerView.DEBUG;
            }
        }

        private void adjustPicker(int step) {
            int stepSize;
            int initialValue;
            int maxValue;
            int minValue;
            if (RadialTimePickerView.this.mShowHours) {
                stepSize = RadialTimePickerView.DEGREES_FOR_ONE_HOUR;
                initialValue = RadialTimePickerView.this.getCurrentHour() % 12;
                if (RadialTimePickerView.this.mIs24HourMode) {
                    maxValue = 23;
                    minValue = RadialTimePickerView.SELECTOR_CIRCLE;
                } else {
                    maxValue = 12;
                    minValue = RadialTimePickerView.SELECTOR_DOT;
                }
            } else {
                stepSize = RadialTimePickerView.DEGREES_FOR_ONE_MINUTE;
                initialValue = RadialTimePickerView.this.getCurrentMinute();
                maxValue = 55;
                minValue = RadialTimePickerView.SELECTOR_CIRCLE;
            }
            int clampedValue = MathUtils.constrain(RadialTimePickerView.snapOnly30s(initialValue * stepSize, step) / stepSize, minValue, maxValue);
            if (RadialTimePickerView.this.mShowHours) {
                RadialTimePickerView.this.setCurrentHour(clampedValue);
            } else {
                RadialTimePickerView.this.setCurrentMinute(clampedValue);
            }
        }

        protected int getVirtualViewAt(float x, float y) {
            boolean wasOnInnerCircle = RadialTimePickerView.this.mIsOnInnerCircle;
            int degrees = RadialTimePickerView.this.getDegreesFromXY(x, y);
            boolean isOnInnerCircle = RadialTimePickerView.this.mIsOnInnerCircle;
            RadialTimePickerView.this.mIsOnInnerCircle = wasOnInnerCircle;
            if (degrees == -1) {
                return RtlSpacingHelper.UNDEFINED;
            }
            int snapDegrees = RadialTimePickerView.snapOnly30s(degrees, RadialTimePickerView.SELECTOR_CIRCLE) % 360;
            if (RadialTimePickerView.this.mShowHours) {
                int hour24 = RadialTimePickerView.this.getHourForDegrees(snapDegrees, isOnInnerCircle);
                return makeId(RadialTimePickerView.SELECTOR_DOT, RadialTimePickerView.this.mIs24HourMode ? hour24 : hour24To12(hour24));
            }
            int minute;
            int current = RadialTimePickerView.this.getCurrentMinute();
            int touched = RadialTimePickerView.this.getMinuteForDegrees(degrees);
            int snapped = RadialTimePickerView.this.getMinuteForDegrees(snapDegrees);
            if (Math.abs(current - touched) < Math.abs(snapped - touched)) {
                minute = current;
            } else {
                minute = snapped;
            }
            return makeId(RadialTimePickerView.SELECTOR_LINE, minute);
        }

        protected void getVisibleVirtualViews(IntArray virtualViewIds) {
            int i;
            if (RadialTimePickerView.this.mShowHours) {
                int min;
                if (RadialTimePickerView.this.mIs24HourMode) {
                    min = RadialTimePickerView.SELECTOR_CIRCLE;
                } else {
                    min = RadialTimePickerView.SELECTOR_DOT;
                }
                int max = RadialTimePickerView.this.mIs24HourMode ? 23 : 12;
                for (i = min; i <= max; i += RadialTimePickerView.SELECTOR_DOT) {
                    virtualViewIds.add(makeId(RadialTimePickerView.SELECTOR_DOT, i));
                }
                return;
            }
            int current = RadialTimePickerView.this.getCurrentMinute();
            i = RadialTimePickerView.SELECTOR_CIRCLE;
            while (i < RadialTimePickerView.ALPHA_SELECTOR) {
                virtualViewIds.add(makeId(RadialTimePickerView.SELECTOR_LINE, i));
                if (current > i && current < i + 5) {
                    virtualViewIds.add(makeId(RadialTimePickerView.SELECTOR_LINE, current));
                }
                i += 5;
            }
        }

        protected void onPopulateEventForVirtualView(int virtualViewId, AccessibilityEvent event) {
            event.setClassName(getClass().getName());
            event.setContentDescription(getVirtualViewDescription(getTypeFromId(virtualViewId), getValueFromId(virtualViewId)));
        }

        protected void onPopulateNodeForVirtualView(int virtualViewId, AccessibilityNodeInfo node) {
            node.setClassName(getClass().getName());
            node.addAction(AccessibilityAction.ACTION_CLICK);
            int type = getTypeFromId(virtualViewId);
            int value = getValueFromId(virtualViewId);
            node.setContentDescription(getVirtualViewDescription(type, value));
            getBoundsForVirtualView(virtualViewId, this.mTempRect);
            node.setBoundsInParent(this.mTempRect);
            node.setSelected(isVirtualViewSelected(type, value));
            int nextId = getVirtualViewIdAfter(type, value);
            if (nextId != RtlSpacingHelper.UNDEFINED) {
                node.setTraversalBefore(RadialTimePickerView.this, nextId);
            }
        }

        private int getVirtualViewIdAfter(int type, int value) {
            int nextValue;
            if (type == RadialTimePickerView.SELECTOR_DOT) {
                nextValue = value + RadialTimePickerView.SELECTOR_DOT;
                if (nextValue <= (RadialTimePickerView.this.mIs24HourMode ? 23 : 12)) {
                    return makeId(type, nextValue);
                }
            } else if (type == RadialTimePickerView.SELECTOR_LINE) {
                int current = RadialTimePickerView.this.getCurrentMinute();
                nextValue = (value - (value % 5)) + 5;
                if (value < current && nextValue > current) {
                    return makeId(type, current);
                }
                if (nextValue < RadialTimePickerView.ALPHA_SELECTOR) {
                    return makeId(type, nextValue);
                }
            }
            return RtlSpacingHelper.UNDEFINED;
        }

        protected boolean onPerformActionForVirtualView(int virtualViewId, int action, Bundle arguments) {
            if (action == 16) {
                int type = getTypeFromId(virtualViewId);
                int value = getValueFromId(virtualViewId);
                if (type == RadialTimePickerView.SELECTOR_DOT) {
                    RadialTimePickerView.this.setCurrentHour(RadialTimePickerView.this.mIs24HourMode ? value : hour12To24(value, RadialTimePickerView.this.mAmOrPm));
                    return true;
                } else if (type == RadialTimePickerView.SELECTOR_LINE) {
                    RadialTimePickerView.this.setCurrentMinute(value);
                    return true;
                }
            }
            return RadialTimePickerView.DEBUG;
        }

        private int hour12To24(int hour12, int amOrPm) {
            int hour24 = hour12;
            if (hour12 == 12) {
                if (amOrPm == 0) {
                    return RadialTimePickerView.SELECTOR_CIRCLE;
                }
                return hour24;
            } else if (amOrPm == RadialTimePickerView.SELECTOR_DOT) {
                return hour24 + 12;
            } else {
                return hour24;
            }
        }

        private int hour24To12(int hour24) {
            if (hour24 == 0) {
                return 12;
            }
            if (hour24 > 12) {
                return hour24 - 12;
            }
            return hour24;
        }

        private void getBoundsForVirtualView(int virtualViewId, Rect bounds) {
            float centerRadius;
            float radius;
            float degrees;
            int type = getTypeFromId(virtualViewId);
            int value = getValueFromId(virtualViewId);
            if (type == RadialTimePickerView.SELECTOR_DOT) {
                boolean innerCircle = (!RadialTimePickerView.this.mIs24HourMode || value <= 0 || value > 12) ? RadialTimePickerView.DEBUG : true;
                if (innerCircle) {
                    centerRadius = RadialTimePickerView.this.mCircleRadius[RadialTimePickerView.SELECTOR_LINE] * RadialTimePickerView.this.mNumbersRadiusMultiplier[RadialTimePickerView.SELECTOR_LINE];
                    radius = (float) RadialTimePickerView.this.mSelectionRadius[RadialTimePickerView.SELECTOR_LINE];
                } else {
                    centerRadius = RadialTimePickerView.this.mCircleRadius[RadialTimePickerView.SELECTOR_CIRCLE] * RadialTimePickerView.this.mNumbersRadiusMultiplier[RadialTimePickerView.SELECTOR_CIRCLE];
                    radius = (float) RadialTimePickerView.this.mSelectionRadius[RadialTimePickerView.SELECTOR_CIRCLE];
                }
                degrees = (float) RadialTimePickerView.this.getDegreesForHour(value);
            } else if (type == RadialTimePickerView.SELECTOR_LINE) {
                centerRadius = RadialTimePickerView.this.mCircleRadius[RadialTimePickerView.SELECTOR_DOT] * RadialTimePickerView.this.mNumbersRadiusMultiplier[RadialTimePickerView.SELECTOR_DOT];
                degrees = (float) RadialTimePickerView.this.getDegreesForMinute(value);
                radius = (float) RadialTimePickerView.this.mSelectionRadius[RadialTimePickerView.SELECTOR_DOT];
            } else {
                centerRadius = RadialTimePickerView.COSINE_30_DEGREES;
                degrees = RadialTimePickerView.COSINE_30_DEGREES;
                radius = RadialTimePickerView.COSINE_30_DEGREES;
            }
            double radians = Math.toRadians((double) degrees);
            float xCenter = ((float) RadialTimePickerView.this.mXCenter) + (((float) Math.sin(radians)) * centerRadius);
            float yCenter = ((float) RadialTimePickerView.this.mYCenter) - (((float) Math.cos(radians)) * centerRadius);
            bounds.set((int) (xCenter - radius), (int) (yCenter - radius), (int) (xCenter + radius), (int) (yCenter + radius));
        }

        private CharSequence getVirtualViewDescription(int type, int value) {
            if (type == RadialTimePickerView.SELECTOR_DOT || type == RadialTimePickerView.SELECTOR_LINE) {
                return Integer.toString(value);
            }
            return null;
        }

        private boolean isVirtualViewSelected(int type, int value) {
            boolean z = true;
            if (type == RadialTimePickerView.SELECTOR_DOT) {
                if (RadialTimePickerView.this.getCurrentHour() == value) {
                    return true;
                }
                return RadialTimePickerView.DEBUG;
            } else if (type != RadialTimePickerView.SELECTOR_LINE) {
                return RadialTimePickerView.DEBUG;
            } else {
                if (RadialTimePickerView.this.getCurrentMinute() != value) {
                    z = RadialTimePickerView.DEBUG;
                }
                return z;
            }
        }

        private int makeId(int type, int value) {
            return (type << RadialTimePickerView.SELECTOR_CIRCLE) | (value << 8);
        }

        private int getTypeFromId(int id) {
            return (id >>> RadialTimePickerView.SELECTOR_CIRCLE) & 15;
        }

        private int getValueFromId(int id) {
            return (id >>> 8) & RadialTimePickerView.ALPHA_OPAQUE;
        }
    }

    static {
        COSINE_30_DEGREES = ((float) Math.sqrt(3.0d)) * SINE_30_DEGREES;
        HOURS_NUMBERS = new int[]{12, SELECTOR_DOT, SELECTOR_LINE, 3, 4, 5, DEGREES_FOR_ONE_MINUTE, 7, 8, 9, 10, 11};
        HOURS_NUMBERS_24 = new int[]{SELECTOR_CIRCLE, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23};
        MINUTES_NUMBERS = new int[]{SELECTOR_CIRCLE, 5, 10, 15, 20, 25, DEGREES_FOR_ONE_HOUR, 35, 40, 45, 50, 55};
        sSnapPrefer30sMap = new int[361];
        preparePrefer30sMap();
    }

    private static void preparePrefer30sMap() {
        int snappedOutputDegrees = SELECTOR_CIRCLE;
        int count = SELECTOR_DOT;
        int expectedCount = 8;
        for (int degrees = SELECTOR_CIRCLE; degrees < 361; degrees += SELECTOR_DOT) {
            sSnapPrefer30sMap[degrees] = snappedOutputDegrees;
            if (count == expectedCount) {
                snappedOutputDegrees += DEGREES_FOR_ONE_MINUTE;
                if (snappedOutputDegrees == 360) {
                    expectedCount = 7;
                } else if (snappedOutputDegrees % DEGREES_FOR_ONE_HOUR == 0) {
                    expectedCount = 14;
                } else {
                    expectedCount = 4;
                }
                count = SELECTOR_DOT;
            } else {
                count += SELECTOR_DOT;
            }
        }
    }

    private static int snapPrefer30s(int degrees) {
        if (sSnapPrefer30sMap == null) {
            return -1;
        }
        return sSnapPrefer30sMap[degrees];
    }

    private static int snapOnly30s(int degrees, int forceHigherOrLower) {
        int floor = (degrees / DEGREES_FOR_ONE_HOUR) * DEGREES_FOR_ONE_HOUR;
        int ceiling = floor + DEGREES_FOR_ONE_HOUR;
        if (forceHigherOrLower == SELECTOR_DOT) {
            return ceiling;
        }
        if (forceHigherOrLower == -1) {
            if (degrees == floor) {
                floor -= 30;
            }
            return floor;
        } else if (degrees - floor < ceiling - degrees) {
            return floor;
        } else {
            return ceiling;
        }
    }

    public RadialTimePickerView(Context context) {
        this(context, null);
    }

    public RadialTimePickerView(Context context, AttributeSet attrs) {
        this(context, attrs, 16843933);
    }

    public RadialTimePickerView(Context context, AttributeSet attrs, int defStyleAttr) {
        this(context, attrs, defStyleAttr, SELECTOR_CIRCLE);
    }

    public RadialTimePickerView(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        int i;
        super(context, attrs);
        RadialTimePickerView radialTimePickerView = this;
        this.mInvalidateUpdateListener = new InvalidateUpdateListener();
        this.mHours12Texts = new String[12];
        this.mOuterHours24Texts = new String[12];
        this.mInnerHours24Texts = new String[12];
        this.mMinutesTexts = new String[12];
        this.mPaint = new Paint[SELECTOR_LINE];
        this.mColor = new int[SELECTOR_LINE];
        this.mAlpha = new IntHolder[SELECTOR_LINE];
        this.mPaintCenter = new Paint();
        this.mPaintSelector = (Paint[][]) Array.newInstance(Paint.class, new int[]{SELECTOR_LINE, 3});
        this.mColorSelector = (int[][]) Array.newInstance(Integer.TYPE, new int[]{SELECTOR_LINE, 3});
        this.mAlphaSelector = (IntHolder[][]) Array.newInstance(IntHolder.class, new int[]{SELECTOR_LINE, 3});
        this.mPaintBackground = new Paint();
        this.mPaintDebug = new Paint();
        this.mCircleRadius = new float[3];
        this.mTextSize = new float[SELECTOR_LINE];
        this.mTextGridHeights = (float[][]) Array.newInstance(Float.TYPE, new int[]{SELECTOR_LINE, 7});
        this.mTextGridWidths = (float[][]) Array.newInstance(Float.TYPE, new int[]{SELECTOR_LINE, 7});
        this.mInnerTextGridHeights = new float[7];
        this.mInnerTextGridWidths = new float[7];
        this.mCircleRadiusMultiplier = new float[SELECTOR_LINE];
        this.mNumbersRadiusMultiplier = new float[3];
        this.mTextSizeMultiplier = new float[3];
        this.mAnimationRadiusMultiplier = new float[3];
        this.mLineLength = new int[3];
        this.mSelectionRadius = new int[3];
        this.mSelectionDegrees = new int[3];
        this.mHoursToMinutesAnims = new ArrayList();
        this.mMinuteToHoursAnims = new ArrayList();
        this.mInputEnabled = true;
        this.mChangedDuringTouch = DEBUG;
        TypedValue outValue = new TypedValue();
        context.getTheme().resolveAttribute(16842803, outValue, true);
        this.mDisabledAlpha = (int) ((outValue.getFloat() * 255.0f) + SINE_30_DEGREES);
        Resources res = getResources();
        TypedArray a = this.mContext.obtainStyledAttributes(attrs, R.styleable.TimePicker, defStyleAttr, defStyleRes);
        this.mTypeface = Typeface.create("sans-serif", (int) SELECTOR_CIRCLE);
        for (i = SELECTOR_CIRCLE; i < this.mAlpha.length; i += SELECTOR_DOT) {
            this.mAlpha[i] = new IntHolder(ALPHA_OPAQUE);
        }
        for (i = SELECTOR_CIRCLE; i < this.mAlphaSelector.length; i += SELECTOR_DOT) {
            for (int j = SELECTOR_CIRCLE; j < this.mAlphaSelector[i].length; j += SELECTOR_DOT) {
                this.mAlphaSelector[i][j] = new IntHolder(ALPHA_OPAQUE);
            }
        }
        int numbersTextColor = a.getColor(3, res.getColor(17170679));
        this.mPaint[SELECTOR_CIRCLE] = new Paint();
        this.mPaint[SELECTOR_CIRCLE].setAntiAlias(true);
        this.mPaint[SELECTOR_CIRCLE].setTextAlign(Align.CENTER);
        this.mColor[SELECTOR_CIRCLE] = numbersTextColor;
        this.mPaint[SELECTOR_DOT] = new Paint();
        this.mPaint[SELECTOR_DOT].setAntiAlias(true);
        this.mPaint[SELECTOR_DOT].setTextAlign(Align.CENTER);
        this.mColor[SELECTOR_DOT] = numbersTextColor;
        this.mPaintCenter.setColor(numbersTextColor);
        this.mPaintCenter.setAntiAlias(true);
        this.mPaintCenter.setTextAlign(Align.CENTER);
        this.mPaintSelector[SELECTOR_CIRCLE][SELECTOR_CIRCLE] = new Paint();
        this.mPaintSelector[SELECTOR_CIRCLE][SELECTOR_CIRCLE].setAntiAlias(true);
        this.mColorSelector[SELECTOR_CIRCLE][SELECTOR_CIRCLE] = a.getColor(5, 17170682);
        this.mPaintSelector[SELECTOR_CIRCLE][SELECTOR_DOT] = new Paint();
        this.mPaintSelector[SELECTOR_CIRCLE][SELECTOR_DOT].setAntiAlias(true);
        this.mColorSelector[SELECTOR_CIRCLE][SELECTOR_DOT] = a.getColor(5, 17170682);
        this.mPaintSelector[SELECTOR_CIRCLE][SELECTOR_LINE] = new Paint();
        this.mPaintSelector[SELECTOR_CIRCLE][SELECTOR_LINE].setAntiAlias(true);
        this.mPaintSelector[SELECTOR_CIRCLE][SELECTOR_LINE].setStrokeWidth(2.0f);
        this.mColorSelector[SELECTOR_CIRCLE][SELECTOR_LINE] = a.getColor(5, 17170682);
        this.mPaintSelector[SELECTOR_DOT][SELECTOR_CIRCLE] = new Paint();
        this.mPaintSelector[SELECTOR_DOT][SELECTOR_CIRCLE].setAntiAlias(true);
        this.mColorSelector[SELECTOR_DOT][SELECTOR_CIRCLE] = a.getColor(5, 17170682);
        this.mPaintSelector[SELECTOR_DOT][SELECTOR_DOT] = new Paint();
        this.mPaintSelector[SELECTOR_DOT][SELECTOR_DOT].setAntiAlias(true);
        this.mColorSelector[SELECTOR_DOT][SELECTOR_DOT] = a.getColor(5, 17170682);
        this.mPaintSelector[SELECTOR_DOT][SELECTOR_LINE] = new Paint();
        this.mPaintSelector[SELECTOR_DOT][SELECTOR_LINE].setAntiAlias(true);
        this.mPaintSelector[SELECTOR_DOT][SELECTOR_LINE].setStrokeWidth(2.0f);
        this.mColorSelector[SELECTOR_DOT][SELECTOR_LINE] = a.getColor(5, 17170682);
        this.mPaintBackground.setColor(a.getColor(4, res.getColor(17170683)));
        this.mPaintBackground.setAntiAlias(true);
        this.mShowHours = true;
        this.mIs24HourMode = DEBUG;
        this.mAmOrPm = SELECTOR_CIRCLE;
        this.mTouchHelper = new RadialPickerTouchHelper();
        setAccessibilityDelegate(this.mTouchHelper);
        if (getImportantForAccessibility() == 0) {
            setImportantForAccessibility(SELECTOR_DOT);
        }
        initHoursAndMinutesText();
        initData();
        this.mTransitionMidRadiusMultiplier = Float.parseFloat(res.getString(17039447));
        this.mTransitionEndRadiusMultiplier = Float.parseFloat(res.getString(17039448));
        this.mTextGridHeights[SELECTOR_CIRCLE] = new float[7];
        this.mTextGridHeights[SELECTOR_DOT] = new float[7];
        this.mSelectionRadiusMultiplier = Float.parseFloat(res.getString(17039439));
        a.recycle();
        setOnTouchListener(this);
        setClickable(true);
        Calendar calendar = Calendar.getInstance(Locale.getDefault());
        int currentHour = calendar.get(11);
        int currentMinute = calendar.get(12);
        setCurrentHourInternal(currentHour, DEBUG, DEBUG);
        setCurrentMinuteInternal(currentMinute, DEBUG);
        setHapticFeedbackEnabled(true);
    }

    public void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        int measuredWidth = MeasureSpec.getSize(widthMeasureSpec);
        int widthMode = MeasureSpec.getMode(widthMeasureSpec);
        int measuredHeight = MeasureSpec.getSize(heightMeasureSpec);
        int heightMode = MeasureSpec.getMode(heightMeasureSpec);
        int minDimension = Math.min(measuredWidth, measuredHeight);
        super.onMeasure(MeasureSpec.makeMeasureSpec(minDimension, widthMode), MeasureSpec.makeMeasureSpec(minDimension, heightMode));
    }

    public void initialize(int hour, int minute, boolean is24HourMode) {
        if (this.mIs24HourMode != is24HourMode) {
            this.mIs24HourMode = is24HourMode;
            initData();
        }
        setCurrentHourInternal(hour, DEBUG, DEBUG);
        setCurrentMinuteInternal(minute, DEBUG);
    }

    public void setCurrentItemShowing(int item, boolean animate) {
        switch (item) {
            case SELECTOR_CIRCLE /*0*/:
                showHours(animate);
            case SELECTOR_DOT /*1*/:
                showMinutes(animate);
            default:
                Log.e(TAG, "ClockView does not support showing item " + item);
        }
    }

    public int getCurrentItemShowing() {
        return this.mShowHours ? SELECTOR_CIRCLE : SELECTOR_DOT;
    }

    public void setOnValueSelectedListener(OnValueSelectedListener listener) {
        this.mListener = listener;
    }

    public void setCurrentHour(int hour) {
        setCurrentHourInternal(hour, true, DEBUG);
    }

    private void setCurrentHourInternal(int hour, boolean callback, boolean autoAdvance) {
        int amOrPm;
        boolean isOnInnerCircle;
        int degrees = (hour % 12) * DEGREES_FOR_ONE_HOUR;
        this.mSelectionDegrees[SELECTOR_CIRCLE] = degrees;
        this.mSelectionDegrees[SELECTOR_LINE] = degrees;
        if (hour == 0 || hour % 24 < 12) {
            amOrPm = SELECTOR_CIRCLE;
        } else {
            amOrPm = SELECTOR_DOT;
        }
        if (!this.mIs24HourMode || hour < SELECTOR_DOT || hour > 12) {
            isOnInnerCircle = DEBUG;
        } else {
            isOnInnerCircle = true;
        }
        if (!(this.mAmOrPm == amOrPm && this.mIsOnInnerCircle == isOnInnerCircle)) {
            this.mAmOrPm = amOrPm;
            this.mIsOnInnerCircle = isOnInnerCircle;
            initData();
            updateLayoutData();
            this.mTouchHelper.invalidateRoot();
        }
        invalidate();
        if (callback && this.mListener != null) {
            this.mListener.onValueSelected(SELECTOR_CIRCLE, hour, autoAdvance);
        }
    }

    public int getCurrentHour() {
        return getHourForDegrees(this.mSelectionDegrees[this.mIsOnInnerCircle ? SELECTOR_LINE : SELECTOR_CIRCLE], this.mIsOnInnerCircle);
    }

    private int getHourForDegrees(int degrees, boolean innerCircle) {
        int hour = (degrees / DEGREES_FOR_ONE_HOUR) % 12;
        if (this.mIs24HourMode) {
            if (innerCircle && hour == 0) {
                return 12;
            }
            if (innerCircle || hour == 0) {
                return hour;
            }
            return hour + 12;
        } else if (this.mAmOrPm == SELECTOR_DOT) {
            return hour + 12;
        } else {
            return hour;
        }
    }

    private int getDegreesForHour(int hour) {
        if (this.mIs24HourMode) {
            if (hour >= 12) {
                hour -= 12;
            }
        } else if (hour == 12) {
            hour = SELECTOR_CIRCLE;
        }
        return hour * DEGREES_FOR_ONE_HOUR;
    }

    public void setCurrentMinute(int minute) {
        setCurrentMinuteInternal(minute, true);
    }

    private void setCurrentMinuteInternal(int minute, boolean callback) {
        this.mSelectionDegrees[SELECTOR_DOT] = (minute % ALPHA_SELECTOR) * DEGREES_FOR_ONE_MINUTE;
        invalidate();
        if (callback && this.mListener != null) {
            this.mListener.onValueSelected(SELECTOR_DOT, minute, DEBUG);
        }
    }

    public int getCurrentMinute() {
        return getMinuteForDegrees(this.mSelectionDegrees[SELECTOR_DOT]);
    }

    private int getMinuteForDegrees(int degrees) {
        return degrees / DEGREES_FOR_ONE_MINUTE;
    }

    private int getDegreesForMinute(int minute) {
        return minute * DEGREES_FOR_ONE_MINUTE;
    }

    public void setAmOrPm(int val) {
        this.mAmOrPm = val % SELECTOR_LINE;
        invalidate();
        this.mTouchHelper.invalidateRoot();
    }

    public int getAmOrPm() {
        return this.mAmOrPm;
    }

    public void showHours(boolean animate) {
        if (!this.mShowHours) {
            this.mShowHours = true;
            if (animate) {
                startMinutesToHoursAnimation();
            }
            initData();
            updateLayoutData();
            invalidate();
        }
    }

    public void showMinutes(boolean animate) {
        if (this.mShowHours) {
            this.mShowHours = DEBUG;
            if (animate) {
                startHoursToMinutesAnimation();
            }
            initData();
            updateLayoutData();
            invalidate();
        }
    }

    private void initHoursAndMinutesText() {
        for (int i = SELECTOR_CIRCLE; i < 12; i += SELECTOR_DOT) {
            String[] strArr = this.mHours12Texts;
            Object[] objArr = new Object[SELECTOR_DOT];
            objArr[SELECTOR_CIRCLE] = Integer.valueOf(HOURS_NUMBERS[i]);
            strArr[i] = String.format("%d", objArr);
            strArr = this.mOuterHours24Texts;
            objArr = new Object[SELECTOR_DOT];
            objArr[SELECTOR_CIRCLE] = Integer.valueOf(HOURS_NUMBERS_24[i]);
            strArr[i] = String.format("%02d", objArr);
            strArr = this.mInnerHours24Texts;
            objArr = new Object[SELECTOR_DOT];
            objArr[SELECTOR_CIRCLE] = Integer.valueOf(HOURS_NUMBERS[i]);
            strArr[i] = String.format("%d", objArr);
            strArr = this.mMinutesTexts;
            objArr = new Object[SELECTOR_DOT];
            objArr[SELECTOR_CIRCLE] = Integer.valueOf(MINUTES_NUMBERS[i]);
            strArr[i] = String.format("%02d", objArr);
        }
    }

    private void initData() {
        int i;
        int i2 = ALPHA_OPAQUE;
        int i3 = SELECTOR_CIRCLE;
        if (this.mIs24HourMode) {
            this.mOuterTextHours = this.mOuterHours24Texts;
            this.mInnerTextHours = this.mInnerHours24Texts;
        } else {
            this.mOuterTextHours = this.mHours12Texts;
            this.mInnerTextHours = null;
        }
        this.mOuterTextMinutes = this.mMinutesTexts;
        Resources res = getResources();
        if (!this.mShowHours) {
            this.mCircleRadiusMultiplier[SELECTOR_DOT] = Float.parseFloat(res.getString(17039437));
            this.mNumbersRadiusMultiplier[SELECTOR_DOT] = Float.parseFloat(res.getString(17039441));
            this.mTextSizeMultiplier[SELECTOR_DOT] = Float.parseFloat(res.getString(17039444));
        } else if (this.mIs24HourMode) {
            this.mCircleRadiusMultiplier[SELECTOR_CIRCLE] = Float.parseFloat(res.getString(17039438));
            this.mNumbersRadiusMultiplier[SELECTOR_CIRCLE] = Float.parseFloat(res.getString(17039443));
            this.mTextSizeMultiplier[SELECTOR_CIRCLE] = Float.parseFloat(res.getString(17039446));
            this.mNumbersRadiusMultiplier[SELECTOR_LINE] = Float.parseFloat(res.getString(17039442));
            this.mTextSizeMultiplier[SELECTOR_LINE] = Float.parseFloat(res.getString(17039445));
        } else {
            this.mCircleRadiusMultiplier[SELECTOR_CIRCLE] = Float.parseFloat(res.getString(17039437));
            this.mNumbersRadiusMultiplier[SELECTOR_CIRCLE] = Float.parseFloat(res.getString(17039441));
            this.mTextSizeMultiplier[SELECTOR_CIRCLE] = Float.parseFloat(res.getString(17039444));
        }
        this.mAnimationRadiusMultiplier[SELECTOR_CIRCLE] = LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
        this.mAnimationRadiusMultiplier[SELECTOR_LINE] = LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
        this.mAnimationRadiusMultiplier[SELECTOR_DOT] = LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
        IntHolder intHolder = this.mAlpha[SELECTOR_CIRCLE];
        if (this.mShowHours) {
            i = ALPHA_OPAQUE;
        } else {
            i = SELECTOR_CIRCLE;
        }
        intHolder.setValue(i);
        intHolder = this.mAlpha[SELECTOR_DOT];
        if (this.mShowHours) {
            i = SELECTOR_CIRCLE;
        } else {
            i = ALPHA_OPAQUE;
        }
        intHolder.setValue(i);
        intHolder = this.mAlphaSelector[SELECTOR_CIRCLE][SELECTOR_CIRCLE];
        if (this.mShowHours) {
            i = ALPHA_SELECTOR;
        } else {
            i = SELECTOR_CIRCLE;
        }
        intHolder.setValue(i);
        intHolder = this.mAlphaSelector[SELECTOR_CIRCLE][SELECTOR_DOT];
        if (this.mShowHours) {
            i = ALPHA_OPAQUE;
        } else {
            i = SELECTOR_CIRCLE;
        }
        intHolder.setValue(i);
        intHolder = this.mAlphaSelector[SELECTOR_CIRCLE][SELECTOR_LINE];
        if (this.mShowHours) {
            i = ALPHA_SELECTOR;
        } else {
            i = SELECTOR_CIRCLE;
        }
        intHolder.setValue(i);
        intHolder = this.mAlphaSelector[SELECTOR_DOT][SELECTOR_CIRCLE];
        if (this.mShowHours) {
            i = SELECTOR_CIRCLE;
        } else {
            i = ALPHA_SELECTOR;
        }
        intHolder.setValue(i);
        IntHolder intHolder2 = this.mAlphaSelector[SELECTOR_DOT][SELECTOR_DOT];
        if (this.mShowHours) {
            i2 = SELECTOR_CIRCLE;
        }
        intHolder2.setValue(i2);
        intHolder2 = this.mAlphaSelector[SELECTOR_DOT][SELECTOR_LINE];
        if (!this.mShowHours) {
            i3 = ALPHA_SELECTOR;
        }
        intHolder2.setValue(i3);
    }

    protected void onLayout(boolean changed, int left, int top, int right, int bottom) {
        updateLayoutData();
    }

    private void updateLayoutData() {
        this.mXCenter = getWidth() / SELECTOR_LINE;
        this.mYCenter = getHeight() / SELECTOR_LINE;
        int min = Math.min(this.mXCenter, this.mYCenter);
        this.mCircleRadius[SELECTOR_CIRCLE] = ((float) min) * this.mCircleRadiusMultiplier[SELECTOR_CIRCLE];
        this.mCircleRadius[SELECTOR_LINE] = ((float) min) * this.mCircleRadiusMultiplier[SELECTOR_CIRCLE];
        this.mCircleRadius[SELECTOR_DOT] = ((float) min) * this.mCircleRadiusMultiplier[SELECTOR_DOT];
        this.mMinHypotenuseForInnerNumber = ((int) (this.mCircleRadius[SELECTOR_CIRCLE] * this.mNumbersRadiusMultiplier[SELECTOR_LINE])) - this.mSelectionRadius[SELECTOR_CIRCLE];
        this.mMaxHypotenuseForOuterNumber = ((int) (this.mCircleRadius[SELECTOR_CIRCLE] * this.mNumbersRadiusMultiplier[SELECTOR_CIRCLE])) + this.mSelectionRadius[SELECTOR_CIRCLE];
        this.mHalfwayHypotenusePoint = (int) (this.mCircleRadius[SELECTOR_CIRCLE] * ((this.mNumbersRadiusMultiplier[SELECTOR_CIRCLE] + this.mNumbersRadiusMultiplier[SELECTOR_LINE]) / 2.0f));
        this.mTextSize[SELECTOR_CIRCLE] = this.mCircleRadius[SELECTOR_CIRCLE] * this.mTextSizeMultiplier[SELECTOR_CIRCLE];
        this.mTextSize[SELECTOR_DOT] = this.mCircleRadius[SELECTOR_DOT] * this.mTextSizeMultiplier[SELECTOR_DOT];
        if (this.mIs24HourMode) {
            this.mInnerTextSize = this.mCircleRadius[SELECTOR_CIRCLE] * this.mTextSizeMultiplier[SELECTOR_LINE];
        }
        calculateGridSizesHours();
        calculateGridSizesMinutes();
        this.mSelectionRadius[SELECTOR_CIRCLE] = (int) (this.mCircleRadius[SELECTOR_CIRCLE] * this.mSelectionRadiusMultiplier);
        this.mSelectionRadius[SELECTOR_LINE] = this.mSelectionRadius[SELECTOR_CIRCLE];
        this.mSelectionRadius[SELECTOR_DOT] = (int) (this.mCircleRadius[SELECTOR_DOT] * this.mSelectionRadiusMultiplier);
        this.mTouchHelper.invalidateRoot();
    }

    public void onDraw(Canvas canvas) {
        if (this.mInputEnabled) {
            canvas.save();
        } else {
            canvas.saveLayerAlpha(COSINE_30_DEGREES, COSINE_30_DEGREES, (float) getWidth(), (float) getHeight(), this.mDisabledAlpha);
        }
        calculateGridSizesHours();
        calculateGridSizesMinutes();
        drawCircleBackground(canvas);
        drawSelector(canvas);
        drawTextElements(canvas, this.mTextSize[SELECTOR_CIRCLE], this.mTypeface, this.mOuterTextHours, this.mTextGridWidths[SELECTOR_CIRCLE], this.mTextGridHeights[SELECTOR_CIRCLE], this.mPaint[SELECTOR_CIRCLE], this.mColor[SELECTOR_CIRCLE], this.mAlpha[SELECTOR_CIRCLE].getValue());
        if (this.mIs24HourMode && this.mInnerTextHours != null) {
            drawTextElements(canvas, this.mInnerTextSize, this.mTypeface, this.mInnerTextHours, this.mInnerTextGridWidths, this.mInnerTextGridHeights, this.mPaint[SELECTOR_CIRCLE], this.mColor[SELECTOR_CIRCLE], this.mAlpha[SELECTOR_CIRCLE].getValue());
        }
        drawTextElements(canvas, this.mTextSize[SELECTOR_DOT], this.mTypeface, this.mOuterTextMinutes, this.mTextGridWidths[SELECTOR_DOT], this.mTextGridHeights[SELECTOR_DOT], this.mPaint[SELECTOR_DOT], this.mColor[SELECTOR_DOT], this.mAlpha[SELECTOR_DOT].getValue());
        drawCenter(canvas);
        canvas.restore();
    }

    private void drawCircleBackground(Canvas canvas) {
        canvas.drawCircle((float) this.mXCenter, (float) this.mYCenter, this.mCircleRadius[SELECTOR_CIRCLE], this.mPaintBackground);
    }

    private void drawCenter(Canvas canvas) {
        canvas.drawCircle((float) this.mXCenter, (float) this.mYCenter, 2.0f, this.mPaintCenter);
    }

    private void drawSelector(Canvas canvas) {
        drawSelector(canvas, this.mIsOnInnerCircle ? SELECTOR_LINE : SELECTOR_CIRCLE);
        drawSelector(canvas, SELECTOR_DOT);
    }

    private int getMultipliedAlpha(int argb, int alpha) {
        return (int) ((((double) Color.alpha(argb)) * (((double) alpha) / 255.0d)) + 0.5d);
    }

    private void drawSelector(Canvas canvas, int index) {
        this.mLineLength[index] = (int) ((this.mCircleRadius[index] * this.mNumbersRadiusMultiplier[index]) * this.mAnimationRadiusMultiplier[index]);
        double selectionRadians = Math.toRadians((double) this.mSelectionDegrees[index]);
        int pointX = this.mXCenter + ((int) (((double) this.mLineLength[index]) * Math.sin(selectionRadians)));
        int pointY = this.mYCenter - ((int) (((double) this.mLineLength[index]) * Math.cos(selectionRadians)));
        int color = this.mColorSelector[index % SELECTOR_LINE][SELECTOR_CIRCLE];
        int alpha = this.mAlphaSelector[index % SELECTOR_LINE][SELECTOR_CIRCLE].getValue();
        Paint paint = this.mPaintSelector[index % SELECTOR_LINE][SELECTOR_CIRCLE];
        paint.setColor(color);
        paint.setAlpha(getMultipliedAlpha(color, alpha));
        canvas.drawCircle((float) pointX, (float) pointY, (float) this.mSelectionRadius[index], paint);
        if (this.mSelectionDegrees[index] % DEGREES_FOR_ONE_HOUR != 0) {
            color = this.mColorSelector[index % SELECTOR_LINE][SELECTOR_DOT];
            alpha = this.mAlphaSelector[index % SELECTOR_LINE][SELECTOR_DOT].getValue();
            paint = this.mPaintSelector[index % SELECTOR_LINE][SELECTOR_DOT];
            paint.setColor(color);
            paint.setAlpha(getMultipliedAlpha(color, alpha));
            canvas.drawCircle((float) pointX, (float) pointY, (float) ((this.mSelectionRadius[index] * SELECTOR_LINE) / 7), paint);
        } else {
            int lineLength = this.mLineLength[index] - this.mSelectionRadius[index];
            pointX = this.mXCenter + ((int) (((double) lineLength) * Math.sin(selectionRadians)));
            pointY = this.mYCenter - ((int) (((double) lineLength) * Math.cos(selectionRadians)));
        }
        color = this.mColorSelector[index % SELECTOR_LINE][SELECTOR_LINE];
        alpha = this.mAlphaSelector[index % SELECTOR_LINE][SELECTOR_LINE].getValue();
        paint = this.mPaintSelector[index % SELECTOR_LINE][SELECTOR_LINE];
        paint.setColor(color);
        paint.setAlpha(getMultipliedAlpha(color, alpha));
        canvas.drawLine((float) this.mXCenter, (float) this.mYCenter, (float) pointX, (float) pointY, paint);
    }

    private void drawDebug(Canvas canvas) {
        float outerRadius = this.mCircleRadius[SELECTOR_CIRCLE] * this.mNumbersRadiusMultiplier[SELECTOR_CIRCLE];
        canvas.drawCircle((float) this.mXCenter, (float) this.mYCenter, outerRadius, this.mPaintDebug);
        float f = (float) this.mXCenter;
        float f2 = (float) this.mYCenter;
        canvas.drawCircle(f, f2, this.mCircleRadius[SELECTOR_CIRCLE] * this.mNumbersRadiusMultiplier[SELECTOR_LINE], this.mPaintDebug);
        canvas.drawCircle((float) this.mXCenter, (float) this.mYCenter, this.mCircleRadius[SELECTOR_CIRCLE], this.mPaintDebug);
        canvas.drawRect(((float) this.mXCenter) - outerRadius, ((float) this.mYCenter) - outerRadius, ((float) this.mXCenter) + outerRadius, ((float) this.mYCenter) + outerRadius, this.mPaintDebug);
        canvas.drawRect(((float) this.mXCenter) - this.mCircleRadius[SELECTOR_CIRCLE], ((float) this.mYCenter) - this.mCircleRadius[SELECTOR_CIRCLE], ((float) this.mXCenter) + this.mCircleRadius[SELECTOR_CIRCLE], ((float) this.mYCenter) + this.mCircleRadius[SELECTOR_CIRCLE], this.mPaintDebug);
        canvas.drawRect(COSINE_30_DEGREES, COSINE_30_DEGREES, (float) getWidth(), (float) getHeight(), this.mPaintDebug);
        Object[] objArr = new Object[SELECTOR_LINE];
        objArr[SELECTOR_CIRCLE] = Integer.valueOf(getCurrentHour());
        objArr[SELECTOR_DOT] = Integer.valueOf(getCurrentMinute());
        String selected = String.format("%02d:%02d", objArr);
        ViewGroup.LayoutParams layoutParams = new ViewGroup.LayoutParams(-2, -2);
        TextView textView = new TextView(getContext());
        textView.setLayoutParams(layoutParams);
        textView.setText((CharSequence) selected);
        textView.measure(SELECTOR_CIRCLE, SELECTOR_CIRCLE);
        Paint paint = textView.getPaint();
        paint.setColor(DEBUG_TEXT_COLOR);
        canvas.drawText(selected, (float) (this.mXCenter - (textView.getMeasuredWidth() / SELECTOR_LINE)), ((float) this.mYCenter) + (1.5f * (paint.descent() - paint.ascent())), paint);
    }

    private void calculateGridSizesHours() {
        calculateGridSizes(this.mPaint[SELECTOR_CIRCLE], (this.mCircleRadius[SELECTOR_CIRCLE] * this.mNumbersRadiusMultiplier[SELECTOR_CIRCLE]) * this.mAnimationRadiusMultiplier[SELECTOR_CIRCLE], (float) this.mXCenter, (float) this.mYCenter, this.mTextSize[SELECTOR_CIRCLE], this.mTextGridHeights[SELECTOR_CIRCLE], this.mTextGridWidths[SELECTOR_CIRCLE]);
        if (this.mIs24HourMode) {
            calculateGridSizes(this.mPaint[SELECTOR_CIRCLE], (this.mCircleRadius[SELECTOR_LINE] * this.mNumbersRadiusMultiplier[SELECTOR_LINE]) * this.mAnimationRadiusMultiplier[SELECTOR_LINE], (float) this.mXCenter, (float) this.mYCenter, this.mInnerTextSize, this.mInnerTextGridHeights, this.mInnerTextGridWidths);
        }
    }

    private void calculateGridSizesMinutes() {
        calculateGridSizes(this.mPaint[SELECTOR_DOT], (this.mCircleRadius[SELECTOR_DOT] * this.mNumbersRadiusMultiplier[SELECTOR_DOT]) * this.mAnimationRadiusMultiplier[SELECTOR_DOT], (float) this.mXCenter, (float) this.mYCenter, this.mTextSize[SELECTOR_DOT], this.mTextGridHeights[SELECTOR_DOT], this.mTextGridWidths[SELECTOR_DOT]);
    }

    private static void calculateGridSizes(Paint paint, float numbersRadius, float xCenter, float yCenter, float textSize, float[] textGridHeights, float[] textGridWidths) {
        float offset1 = numbersRadius;
        float offset2 = numbersRadius * COSINE_30_DEGREES;
        float offset3 = numbersRadius * SINE_30_DEGREES;
        paint.setTextSize(textSize);
        yCenter -= (paint.descent() + paint.ascent()) / 2.0f;
        textGridHeights[SELECTOR_CIRCLE] = yCenter - offset1;
        textGridWidths[SELECTOR_CIRCLE] = xCenter - offset1;
        textGridHeights[SELECTOR_DOT] = yCenter - offset2;
        textGridWidths[SELECTOR_DOT] = xCenter - offset2;
        textGridHeights[SELECTOR_LINE] = yCenter - offset3;
        textGridWidths[SELECTOR_LINE] = xCenter - offset3;
        textGridHeights[3] = yCenter;
        textGridWidths[3] = xCenter;
        textGridHeights[4] = yCenter + offset3;
        textGridWidths[4] = xCenter + offset3;
        textGridHeights[5] = yCenter + offset2;
        textGridWidths[5] = xCenter + offset2;
        textGridHeights[DEGREES_FOR_ONE_MINUTE] = yCenter + offset1;
        textGridWidths[DEGREES_FOR_ONE_MINUTE] = xCenter + offset1;
    }

    private void drawTextElements(Canvas canvas, float textSize, Typeface typeface, String[] texts, float[] textGridWidths, float[] textGridHeights, Paint paint, int color, int alpha) {
        paint.setTextSize(textSize);
        paint.setTypeface(typeface);
        paint.setColor(color);
        paint.setAlpha(getMultipliedAlpha(color, alpha));
        canvas.drawText(texts[SELECTOR_CIRCLE], textGridWidths[3], textGridHeights[SELECTOR_CIRCLE], paint);
        canvas.drawText(texts[SELECTOR_DOT], textGridWidths[4], textGridHeights[SELECTOR_DOT], paint);
        canvas.drawText(texts[SELECTOR_LINE], textGridWidths[5], textGridHeights[SELECTOR_LINE], paint);
        canvas.drawText(texts[3], textGridWidths[DEGREES_FOR_ONE_MINUTE], textGridHeights[3], paint);
        canvas.drawText(texts[4], textGridWidths[5], textGridHeights[4], paint);
        canvas.drawText(texts[5], textGridWidths[4], textGridHeights[5], paint);
        canvas.drawText(texts[DEGREES_FOR_ONE_MINUTE], textGridWidths[3], textGridHeights[DEGREES_FOR_ONE_MINUTE], paint);
        canvas.drawText(texts[7], textGridWidths[SELECTOR_LINE], textGridHeights[5], paint);
        canvas.drawText(texts[8], textGridWidths[SELECTOR_DOT], textGridHeights[4], paint);
        canvas.drawText(texts[9], textGridWidths[SELECTOR_CIRCLE], textGridHeights[3], paint);
        canvas.drawText(texts[10], textGridWidths[SELECTOR_DOT], textGridHeights[SELECTOR_LINE], paint);
        canvas.drawText(texts[11], textGridWidths[SELECTOR_LINE], textGridHeights[SELECTOR_DOT], paint);
    }

    private void setAnimationRadiusMultiplierHours(float animationRadiusMultiplier) {
        this.mAnimationRadiusMultiplier[SELECTOR_CIRCLE] = animationRadiusMultiplier;
        this.mAnimationRadiusMultiplier[SELECTOR_LINE] = animationRadiusMultiplier;
    }

    private void setAnimationRadiusMultiplierMinutes(float animationRadiusMultiplier) {
        this.mAnimationRadiusMultiplier[SELECTOR_DOT] = animationRadiusMultiplier;
    }

    private static ObjectAnimator getRadiusDisappearAnimator(Object target, String radiusPropertyName, InvalidateUpdateListener updateListener, float midRadiusMultiplier, float endRadiusMultiplier) {
        Keyframe kf0 = Keyframe.ofFloat(COSINE_30_DEGREES, LayoutParams.BRIGHTNESS_OVERRIDE_FULL);
        Keyframe kf1 = Keyframe.ofFloat(0.2f, midRadiusMultiplier);
        Keyframe kf2 = Keyframe.ofFloat(LayoutParams.BRIGHTNESS_OVERRIDE_FULL, endRadiusMultiplier);
        PropertyValuesHolder radiusDisappear = PropertyValuesHolder.ofKeyframe(radiusPropertyName, new Keyframe[]{kf0, kf1, kf2});
        PropertyValuesHolder[] propertyValuesHolderArr = new PropertyValuesHolder[SELECTOR_DOT];
        propertyValuesHolderArr[SELECTOR_CIRCLE] = radiusDisappear;
        ObjectAnimator animator = ObjectAnimator.ofPropertyValuesHolder(target, propertyValuesHolderArr).setDuration((long) AccessibilityEvent.MAX_TEXT_LENGTH);
        animator.addUpdateListener(updateListener);
        return animator;
    }

    private static ObjectAnimator getRadiusReappearAnimator(Object target, String radiusPropertyName, InvalidateUpdateListener updateListener, float midRadiusMultiplier, float endRadiusMultiplier) {
        int totalDuration = (int) (((float) 500) * (LayoutParams.BRIGHTNESS_OVERRIDE_FULL + SensorManager.LIGHT_FULLMOON));
        float delayPoint = (((float) 500) * SensorManager.LIGHT_FULLMOON) / ((float) totalDuration);
        float midwayPoint = LayoutParams.BRIGHTNESS_OVERRIDE_FULL - ((LayoutParams.BRIGHTNESS_OVERRIDE_FULL - delayPoint) * 0.2f);
        Keyframe kf0 = Keyframe.ofFloat(COSINE_30_DEGREES, endRadiusMultiplier);
        Keyframe kf1 = Keyframe.ofFloat(delayPoint, endRadiusMultiplier);
        Keyframe kf2 = Keyframe.ofFloat(midwayPoint, midRadiusMultiplier);
        Keyframe kf3 = Keyframe.ofFloat(LayoutParams.BRIGHTNESS_OVERRIDE_FULL, LayoutParams.BRIGHTNESS_OVERRIDE_FULL);
        PropertyValuesHolder radiusReappear = PropertyValuesHolder.ofKeyframe(radiusPropertyName, new Keyframe[]{kf0, kf1, kf2, kf3});
        PropertyValuesHolder[] propertyValuesHolderArr = new PropertyValuesHolder[SELECTOR_DOT];
        propertyValuesHolderArr[SELECTOR_CIRCLE] = radiusReappear;
        ObjectAnimator animator = ObjectAnimator.ofPropertyValuesHolder(target, propertyValuesHolderArr).setDuration((long) totalDuration);
        animator.addUpdateListener(updateListener);
        return animator;
    }

    private static ObjectAnimator getFadeOutAnimator(IntHolder target, int startAlpha, int endAlpha, InvalidateUpdateListener updateListener) {
        int[] iArr = new int[SELECTOR_LINE];
        iArr[SELECTOR_CIRCLE] = startAlpha;
        iArr[SELECTOR_DOT] = endAlpha;
        ObjectAnimator animator = ObjectAnimator.ofInt(target, "value", iArr);
        animator.setDuration((long) AccessibilityEvent.MAX_TEXT_LENGTH);
        animator.addUpdateListener(updateListener);
        return animator;
    }

    private static ObjectAnimator getFadeInAnimator(IntHolder target, int startAlpha, int endAlpha, InvalidateUpdateListener updateListener) {
        int totalDuration = (int) (((float) 500) * (LayoutParams.BRIGHTNESS_OVERRIDE_FULL + SensorManager.LIGHT_FULLMOON));
        float delayPoint = (((float) 500) * SensorManager.LIGHT_FULLMOON) / ((float) totalDuration);
        Keyframe kf0 = Keyframe.ofInt(COSINE_30_DEGREES, startAlpha);
        Keyframe kf1 = Keyframe.ofInt(delayPoint, startAlpha);
        Keyframe kf2 = Keyframe.ofInt(LayoutParams.BRIGHTNESS_OVERRIDE_FULL, endAlpha);
        PropertyValuesHolder[] propertyValuesHolderArr = new PropertyValuesHolder[SELECTOR_DOT];
        propertyValuesHolderArr[SELECTOR_CIRCLE] = PropertyValuesHolder.ofKeyframe("value", new Keyframe[]{kf0, kf1, kf2});
        ObjectAnimator animator = ObjectAnimator.ofPropertyValuesHolder(target, propertyValuesHolderArr).setDuration((long) totalDuration);
        animator.addUpdateListener(updateListener);
        return animator;
    }

    private void startHoursToMinutesAnimation() {
        if (this.mHoursToMinutesAnims.size() == 0) {
            this.mHoursToMinutesAnims.add(getRadiusDisappearAnimator(this, "animationRadiusMultiplierHours", this.mInvalidateUpdateListener, this.mTransitionMidRadiusMultiplier, this.mTransitionEndRadiusMultiplier));
            this.mHoursToMinutesAnims.add(getFadeOutAnimator(this.mAlpha[SELECTOR_CIRCLE], ALPHA_OPAQUE, SELECTOR_CIRCLE, this.mInvalidateUpdateListener));
            this.mHoursToMinutesAnims.add(getFadeOutAnimator(this.mAlphaSelector[SELECTOR_CIRCLE][SELECTOR_CIRCLE], ALPHA_SELECTOR, SELECTOR_CIRCLE, this.mInvalidateUpdateListener));
            this.mHoursToMinutesAnims.add(getFadeOutAnimator(this.mAlphaSelector[SELECTOR_CIRCLE][SELECTOR_DOT], ALPHA_OPAQUE, SELECTOR_CIRCLE, this.mInvalidateUpdateListener));
            this.mHoursToMinutesAnims.add(getFadeOutAnimator(this.mAlphaSelector[SELECTOR_CIRCLE][SELECTOR_LINE], ALPHA_SELECTOR, SELECTOR_CIRCLE, this.mInvalidateUpdateListener));
            this.mHoursToMinutesAnims.add(getRadiusReappearAnimator(this, "animationRadiusMultiplierMinutes", this.mInvalidateUpdateListener, this.mTransitionMidRadiusMultiplier, this.mTransitionEndRadiusMultiplier));
            this.mHoursToMinutesAnims.add(getFadeInAnimator(this.mAlpha[SELECTOR_DOT], SELECTOR_CIRCLE, ALPHA_OPAQUE, this.mInvalidateUpdateListener));
            this.mHoursToMinutesAnims.add(getFadeInAnimator(this.mAlphaSelector[SELECTOR_DOT][SELECTOR_CIRCLE], SELECTOR_CIRCLE, ALPHA_SELECTOR, this.mInvalidateUpdateListener));
            this.mHoursToMinutesAnims.add(getFadeInAnimator(this.mAlphaSelector[SELECTOR_DOT][SELECTOR_DOT], SELECTOR_CIRCLE, ALPHA_OPAQUE, this.mInvalidateUpdateListener));
            this.mHoursToMinutesAnims.add(getFadeInAnimator(this.mAlphaSelector[SELECTOR_DOT][SELECTOR_LINE], SELECTOR_CIRCLE, ALPHA_SELECTOR, this.mInvalidateUpdateListener));
        }
        if (this.mTransition != null && this.mTransition.isRunning()) {
            this.mTransition.end();
        }
        this.mTransition = new AnimatorSet();
        this.mTransition.playTogether(this.mHoursToMinutesAnims);
        this.mTransition.start();
    }

    private void startMinutesToHoursAnimation() {
        if (this.mMinuteToHoursAnims.size() == 0) {
            this.mMinuteToHoursAnims.add(getRadiusDisappearAnimator(this, "animationRadiusMultiplierMinutes", this.mInvalidateUpdateListener, this.mTransitionMidRadiusMultiplier, this.mTransitionEndRadiusMultiplier));
            this.mMinuteToHoursAnims.add(getFadeOutAnimator(this.mAlpha[SELECTOR_DOT], ALPHA_OPAQUE, SELECTOR_CIRCLE, this.mInvalidateUpdateListener));
            this.mMinuteToHoursAnims.add(getFadeOutAnimator(this.mAlphaSelector[SELECTOR_DOT][SELECTOR_CIRCLE], ALPHA_SELECTOR, SELECTOR_CIRCLE, this.mInvalidateUpdateListener));
            this.mMinuteToHoursAnims.add(getFadeOutAnimator(this.mAlphaSelector[SELECTOR_DOT][SELECTOR_DOT], ALPHA_OPAQUE, SELECTOR_CIRCLE, this.mInvalidateUpdateListener));
            this.mMinuteToHoursAnims.add(getFadeOutAnimator(this.mAlphaSelector[SELECTOR_DOT][SELECTOR_LINE], ALPHA_SELECTOR, SELECTOR_CIRCLE, this.mInvalidateUpdateListener));
            this.mMinuteToHoursAnims.add(getRadiusReappearAnimator(this, "animationRadiusMultiplierHours", this.mInvalidateUpdateListener, this.mTransitionMidRadiusMultiplier, this.mTransitionEndRadiusMultiplier));
            this.mMinuteToHoursAnims.add(getFadeInAnimator(this.mAlpha[SELECTOR_CIRCLE], SELECTOR_CIRCLE, ALPHA_OPAQUE, this.mInvalidateUpdateListener));
            this.mMinuteToHoursAnims.add(getFadeInAnimator(this.mAlphaSelector[SELECTOR_CIRCLE][SELECTOR_CIRCLE], SELECTOR_CIRCLE, ALPHA_SELECTOR, this.mInvalidateUpdateListener));
            this.mMinuteToHoursAnims.add(getFadeInAnimator(this.mAlphaSelector[SELECTOR_CIRCLE][SELECTOR_DOT], SELECTOR_CIRCLE, ALPHA_OPAQUE, this.mInvalidateUpdateListener));
            this.mMinuteToHoursAnims.add(getFadeInAnimator(this.mAlphaSelector[SELECTOR_CIRCLE][SELECTOR_LINE], SELECTOR_CIRCLE, ALPHA_SELECTOR, this.mInvalidateUpdateListener));
        }
        if (this.mTransition != null && this.mTransition.isRunning()) {
            this.mTransition.end();
        }
        this.mTransition = new AnimatorSet();
        this.mTransition.playTogether(this.mMinuteToHoursAnims);
        this.mTransition.start();
    }

    private int getDegreesFromXY(float x, float y) {
        double hypotenuse = Math.sqrt((double) (((y - ((float) this.mYCenter)) * (y - ((float) this.mYCenter))) + ((x - ((float) this.mXCenter)) * (x - ((float) this.mXCenter)))));
        if (hypotenuse > ((double) this.mCircleRadius[SELECTOR_CIRCLE])) {
            return -1;
        }
        if (!this.mIs24HourMode || !this.mShowHours) {
            int index = this.mShowHours ? SELECTOR_CIRCLE : SELECTOR_DOT;
            if (((int) Math.abs(hypotenuse - ((double) (this.mCircleRadius[index] * this.mNumbersRadiusMultiplier[index])))) > ((int) (this.mCircleRadius[index] * (LayoutParams.BRIGHTNESS_OVERRIDE_FULL - this.mNumbersRadiusMultiplier[index])))) {
                return -1;
            }
        } else if (hypotenuse >= ((double) this.mMinHypotenuseForInnerNumber) && hypotenuse <= ((double) this.mHalfwayHypotenusePoint)) {
            this.mIsOnInnerCircle = true;
        } else if (hypotenuse > ((double) this.mMaxHypotenuseForOuterNumber) || hypotenuse < ((double) this.mHalfwayHypotenusePoint)) {
            return -1;
        } else {
            this.mIsOnInnerCircle = DEBUG;
        }
        int degrees = (int) (Math.toDegrees(Math.asin(((double) Math.abs(y - ((float) this.mYCenter))) / hypotenuse)) + 0.5d);
        boolean rightSide = x > ((float) this.mXCenter) ? true : DEBUG;
        boolean topSide = y < ((float) this.mYCenter) ? true : DEBUG;
        if (rightSide) {
            if (topSide) {
                return 90 - degrees;
            }
            return degrees + 90;
        } else if (topSide) {
            return degrees + 270;
        } else {
            return 270 - degrees;
        }
    }

    public boolean onTouch(View v, MotionEvent event) {
        if (this.mInputEnabled) {
            int action = event.getActionMasked();
            if (action == SELECTOR_LINE || action == SELECTOR_DOT || action == 0) {
                boolean forceSelection = DEBUG;
                boolean autoAdvance = DEBUG;
                if (action == 0) {
                    this.mChangedDuringTouch = DEBUG;
                } else if (action == SELECTOR_DOT) {
                    autoAdvance = true;
                    if (!this.mChangedDuringTouch) {
                        forceSelection = true;
                    }
                }
                this.mChangedDuringTouch |= handleTouchInput(event.getX(), event.getY(), forceSelection, autoAdvance);
            }
        }
        return true;
    }

    private boolean handleTouchInput(float x, float y, boolean forceSelection, boolean autoAdvance) {
        boolean wasOnInnerCircle = this.mIsOnInnerCircle;
        int degrees = getDegreesFromXY(x, y);
        if (degrees == -1) {
            return DEBUG;
        }
        boolean valueChanged;
        int type;
        int newValue;
        int[] selectionDegrees = this.mSelectionDegrees;
        int snapDegrees;
        if (this.mShowHours) {
            snapDegrees = snapOnly30s(degrees, SELECTOR_CIRCLE) % 360;
            if (selectionDegrees[SELECTOR_CIRCLE] == snapDegrees && selectionDegrees[SELECTOR_LINE] == snapDegrees && wasOnInnerCircle == this.mIsOnInnerCircle) {
                valueChanged = DEBUG;
            } else {
                valueChanged = true;
            }
            selectionDegrees[SELECTOR_CIRCLE] = snapDegrees;
            selectionDegrees[SELECTOR_LINE] = snapDegrees;
            type = SELECTOR_CIRCLE;
            newValue = getCurrentHour();
        } else {
            snapDegrees = snapPrefer30s(degrees) % 360;
            if (selectionDegrees[SELECTOR_DOT] != snapDegrees) {
                valueChanged = true;
            } else {
                valueChanged = DEBUG;
            }
            selectionDegrees[SELECTOR_DOT] = snapDegrees;
            type = SELECTOR_DOT;
            newValue = getCurrentMinute();
        }
        if (!valueChanged && !forceSelection && !autoAdvance) {
            return DEBUG;
        }
        if (this.mListener != null) {
            this.mListener.onValueSelected(type, newValue, autoAdvance);
        }
        if (valueChanged || forceSelection) {
            performHapticFeedback(4);
            invalidate();
        }
        return true;
    }

    public boolean dispatchHoverEvent(MotionEvent event) {
        if (this.mTouchHelper.dispatchHoverEvent(event)) {
            return true;
        }
        return super.dispatchHoverEvent(event);
    }

    public void setInputEnabled(boolean inputEnabled) {
        this.mInputEnabled = inputEnabled;
        invalidate();
    }
}
