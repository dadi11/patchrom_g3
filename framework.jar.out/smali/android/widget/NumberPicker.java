package android.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Paint.Align;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.net.ConnectivityManager;
import android.net.ProxyInfo;
import android.os.Bundle;
import android.text.InputFilter;
import android.text.Spanned;
import android.text.TextUtils;
import android.text.method.NumberKeyListener;
import android.util.AttributeSet;
import android.util.SparseArray;
import android.util.TypedValue;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.VelocityTracker;
import android.view.View;
import android.view.View.MeasureSpec;
import android.view.View.OnClickListener;
import android.view.View.OnFocusChangeListener;
import android.view.View.OnLongClickListener;
import android.view.ViewConfiguration;
import android.view.ViewGroup;
import android.view.WindowManager.LayoutParams;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityManager;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.accessibility.AccessibilityNodeProvider;
import android.view.animation.DecelerateInterpolator;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputMethodManager;
import com.android.internal.R;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Locale;
import libcore.icu.LocaleData;

public class NumberPicker extends LinearLayout {
    private static final int DEFAULT_LAYOUT_RESOURCE_ID = 17367173;
    private static final long DEFAULT_LONG_PRESS_UPDATE_INTERVAL = 300;
    private static final char[] DIGIT_CHARACTERS;
    private static final int SELECTOR_ADJUSTMENT_DURATION_MILLIS = 800;
    private static final int SELECTOR_MAX_FLING_VELOCITY_ADJUSTMENT = 8;
    private static final int SELECTOR_MIDDLE_ITEM_INDEX = 1;
    private static final int SELECTOR_WHEEL_ITEM_COUNT = 3;
    private static final int SIZE_UNSPECIFIED = -1;
    private static final int SNAP_SCROLL_DURATION = 300;
    private static final float TOP_AND_BOTTOM_FADING_EDGE_STRENGTH = 0.9f;
    private static final int UNSCALED_DEFAULT_SELECTION_DIVIDERS_DISTANCE = 48;
    private static final int UNSCALED_DEFAULT_SELECTION_DIVIDER_HEIGHT = 2;
    private static final TwoDigitFormatter sTwoDigitFormatter;
    private AccessibilityNodeProviderImpl mAccessibilityNodeProvider;
    private final Scroller mAdjustScroller;
    private BeginSoftInputOnLongPressCommand mBeginSoftInputOnLongPressCommand;
    private int mBottomSelectionDividerBottom;
    private ChangeCurrentByOneFromLongPressCommand mChangeCurrentByOneFromLongPressCommand;
    private final boolean mComputeMaxWidth;
    private int mCurrentScrollOffset;
    private final ImageButton mDecrementButton;
    private boolean mDecrementVirtualButtonPressed;
    private String[] mDisplayedValues;
    private final Scroller mFlingScroller;
    private Formatter mFormatter;
    private final boolean mHasSelectorWheel;
    private boolean mHideWheelUntilFocused;
    private boolean mIgnoreMoveEvents;
    private final ImageButton mIncrementButton;
    private boolean mIncrementVirtualButtonPressed;
    private int mInitialScrollOffset;
    private final EditText mInputText;
    private long mLastDownEventTime;
    private float mLastDownEventY;
    private float mLastDownOrMoveEventY;
    private int mLastHandledDownDpadKeyCode;
    private int mLastHoveredChildVirtualViewId;
    private long mLongPressUpdateInterval;
    private final int mMaxHeight;
    private int mMaxValue;
    private int mMaxWidth;
    private int mMaximumFlingVelocity;
    private final int mMinHeight;
    private int mMinValue;
    private final int mMinWidth;
    private int mMinimumFlingVelocity;
    private OnScrollListener mOnScrollListener;
    private OnValueChangeListener mOnValueChangeListener;
    private boolean mPerformClickOnTap;
    private final PressedStateHelper mPressedStateHelper;
    private int mPreviousScrollerY;
    private int mScrollState;
    private final Drawable mSelectionDivider;
    private final int mSelectionDividerHeight;
    private final int mSelectionDividersDistance;
    private int mSelectorElementHeight;
    private final SparseArray<String> mSelectorIndexToStringCache;
    private final int[] mSelectorIndices;
    private int mSelectorTextGapHeight;
    private final Paint mSelectorWheelPaint;
    private SetSelectionCommand mSetSelectionCommand;
    private final int mSolidColor;
    private final int mTextSize;
    private int mTopSelectionDividerTop;
    private int mTouchSlop;
    private int mValue;
    private VelocityTracker mVelocityTracker;
    private final Drawable mVirtualButtonPressedDrawable;
    private boolean mWrapSelectorWheel;

    public interface OnValueChangeListener {
        void onValueChange(NumberPicker numberPicker, int i, int i2);
    }

    /* renamed from: android.widget.NumberPicker.1 */
    class C10091 implements OnClickListener {
        C10091() {
        }

        public void onClick(View v) {
            NumberPicker.this.hideSoftInput();
            NumberPicker.this.mInputText.clearFocus();
            if (v.getId() == 16909130) {
                NumberPicker.this.changeValueByOne(true);
            } else {
                NumberPicker.this.changeValueByOne(false);
            }
        }
    }

    /* renamed from: android.widget.NumberPicker.2 */
    class C10102 implements OnLongClickListener {
        C10102() {
        }

        public boolean onLongClick(View v) {
            NumberPicker.this.hideSoftInput();
            NumberPicker.this.mInputText.clearFocus();
            if (v.getId() == 16909130) {
                NumberPicker.this.postChangeCurrentByOneFromLongPress(true, 0);
            } else {
                NumberPicker.this.postChangeCurrentByOneFromLongPress(false, 0);
            }
            return true;
        }
    }

    /* renamed from: android.widget.NumberPicker.3 */
    class C10113 implements OnFocusChangeListener {
        C10113() {
        }

        public void onFocusChange(View v, boolean hasFocus) {
            if (hasFocus) {
                NumberPicker.this.mInputText.selectAll();
                return;
            }
            NumberPicker.this.mInputText.setSelection(0, 0);
            NumberPicker.this.validateInputTextView(v);
        }
    }

    class AccessibilityNodeProviderImpl extends AccessibilityNodeProvider {
        private static final int UNDEFINED = Integer.MIN_VALUE;
        private static final int VIRTUAL_VIEW_ID_DECREMENT = 3;
        private static final int VIRTUAL_VIEW_ID_INCREMENT = 1;
        private static final int VIRTUAL_VIEW_ID_INPUT = 2;
        private int mAccessibilityFocusedView;
        private final int[] mTempArray;
        private final Rect mTempRect;

        AccessibilityNodeProviderImpl() {
            this.mTempRect = new Rect();
            this.mTempArray = new int[VIRTUAL_VIEW_ID_INPUT];
            this.mAccessibilityFocusedView = UNDEFINED;
        }

        public AccessibilityNodeInfo createAccessibilityNodeInfo(int virtualViewId) {
            switch (virtualViewId) {
                case NumberPicker.SIZE_UNSPECIFIED /*-1*/:
                    return createAccessibilityNodeInfoForNumberPicker(NumberPicker.this.mScrollX, NumberPicker.this.mScrollY, NumberPicker.this.mScrollX + (NumberPicker.this.mRight - NumberPicker.this.mLeft), NumberPicker.this.mScrollY + (NumberPicker.this.mBottom - NumberPicker.this.mTop));
                case VIRTUAL_VIEW_ID_INCREMENT /*1*/:
                    return createAccessibilityNodeInfoForVirtualButton(VIRTUAL_VIEW_ID_INCREMENT, getVirtualIncrementButtonText(), NumberPicker.this.mScrollX, NumberPicker.this.mBottomSelectionDividerBottom - NumberPicker.this.mSelectionDividerHeight, (NumberPicker.this.mRight - NumberPicker.this.mLeft) + NumberPicker.this.mScrollX, (NumberPicker.this.mBottom - NumberPicker.this.mTop) + NumberPicker.this.mScrollY);
                case VIRTUAL_VIEW_ID_INPUT /*2*/:
                    return createAccessibiltyNodeInfoForInputText(NumberPicker.this.mScrollX, NumberPicker.this.mTopSelectionDividerTop + NumberPicker.this.mSelectionDividerHeight, NumberPicker.this.mScrollX + (NumberPicker.this.mRight - NumberPicker.this.mLeft), NumberPicker.this.mBottomSelectionDividerBottom - NumberPicker.this.mSelectionDividerHeight);
                case VIRTUAL_VIEW_ID_DECREMENT /*3*/:
                    return createAccessibilityNodeInfoForVirtualButton(VIRTUAL_VIEW_ID_DECREMENT, getVirtualDecrementButtonText(), NumberPicker.this.mScrollX, NumberPicker.this.mScrollY, (NumberPicker.this.mRight - NumberPicker.this.mLeft) + NumberPicker.this.mScrollX, NumberPicker.this.mSelectionDividerHeight + NumberPicker.this.mTopSelectionDividerTop);
                default:
                    return super.createAccessibilityNodeInfo(virtualViewId);
            }
        }

        public List<AccessibilityNodeInfo> findAccessibilityNodeInfosByText(String searched, int virtualViewId) {
            if (TextUtils.isEmpty(searched)) {
                return Collections.emptyList();
            }
            String searchedLowerCase = searched.toLowerCase();
            List<AccessibilityNodeInfo> result = new ArrayList();
            switch (virtualViewId) {
                case NumberPicker.SIZE_UNSPECIFIED /*-1*/:
                    findAccessibilityNodeInfosByTextInChild(searchedLowerCase, VIRTUAL_VIEW_ID_DECREMENT, result);
                    findAccessibilityNodeInfosByTextInChild(searchedLowerCase, VIRTUAL_VIEW_ID_INPUT, result);
                    findAccessibilityNodeInfosByTextInChild(searchedLowerCase, VIRTUAL_VIEW_ID_INCREMENT, result);
                    return result;
                case VIRTUAL_VIEW_ID_INCREMENT /*1*/:
                case VIRTUAL_VIEW_ID_INPUT /*2*/:
                case VIRTUAL_VIEW_ID_DECREMENT /*3*/:
                    findAccessibilityNodeInfosByTextInChild(searchedLowerCase, virtualViewId, result);
                    return result;
                default:
                    return super.findAccessibilityNodeInfosByText(searched, virtualViewId);
            }
        }

        public boolean performAction(int virtualViewId, int action, Bundle arguments) {
            boolean increment = false;
            switch (virtualViewId) {
                case NumberPicker.SIZE_UNSPECIFIED /*-1*/:
                    switch (action) {
                        case AccessibilityNodeInfo.ACTION_ACCESSIBILITY_FOCUS /*64*/:
                            if (this.mAccessibilityFocusedView == virtualViewId) {
                                return false;
                            }
                            this.mAccessibilityFocusedView = virtualViewId;
                            NumberPicker.this.requestAccessibilityFocus();
                            return true;
                        case AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS /*128*/:
                            if (this.mAccessibilityFocusedView != virtualViewId) {
                                return false;
                            }
                            this.mAccessibilityFocusedView = UNDEFINED;
                            NumberPicker.this.clearAccessibilityFocus();
                            return true;
                        case AccessibilityNodeInfo.ACTION_SCROLL_FORWARD /*4096*/:
                            if (!NumberPicker.this.isEnabled()) {
                                return false;
                            }
                            if (!NumberPicker.this.getWrapSelectorWheel() && NumberPicker.this.getValue() >= NumberPicker.this.getMaxValue()) {
                                return false;
                            }
                            NumberPicker.this.changeValueByOne(true);
                            return true;
                        case AccessibilityNodeInfo.ACTION_SCROLL_BACKWARD /*8192*/:
                            if (!NumberPicker.this.isEnabled()) {
                                return false;
                            }
                            if (!NumberPicker.this.getWrapSelectorWheel() && NumberPicker.this.getValue() <= NumberPicker.this.getMinValue()) {
                                return false;
                            }
                            NumberPicker.this.changeValueByOne(false);
                            return true;
                        default:
                            break;
                    }
                case VIRTUAL_VIEW_ID_INCREMENT /*1*/:
                    switch (action) {
                        case RelativeLayout.START_OF /*16*/:
                            if (!NumberPicker.this.isEnabled()) {
                                return false;
                            }
                            NumberPicker.this.changeValueByOne(true);
                            sendAccessibilityEventForVirtualView(virtualViewId, VIRTUAL_VIEW_ID_INCREMENT);
                            return true;
                        case AccessibilityNodeInfo.ACTION_ACCESSIBILITY_FOCUS /*64*/:
                            if (this.mAccessibilityFocusedView == virtualViewId) {
                                return false;
                            }
                            this.mAccessibilityFocusedView = virtualViewId;
                            sendAccessibilityEventForVirtualView(virtualViewId, AccessibilityNodeInfo.ACTION_PASTE);
                            NumberPicker.this.invalidate(0, NumberPicker.this.mBottomSelectionDividerBottom, NumberPicker.this.mRight, NumberPicker.this.mBottom);
                            return true;
                        case AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS /*128*/:
                            if (this.mAccessibilityFocusedView != virtualViewId) {
                                return false;
                            }
                            this.mAccessibilityFocusedView = UNDEFINED;
                            sendAccessibilityEventForVirtualView(virtualViewId, AccessibilityNodeInfo.ACTION_CUT);
                            NumberPicker.this.invalidate(0, NumberPicker.this.mBottomSelectionDividerBottom, NumberPicker.this.mRight, NumberPicker.this.mBottom);
                            return true;
                        default:
                            return false;
                    }
                case VIRTUAL_VIEW_ID_INPUT /*2*/:
                    switch (action) {
                        case VIRTUAL_VIEW_ID_INCREMENT /*1*/:
                            if (!NumberPicker.this.isEnabled() || NumberPicker.this.mInputText.isFocused()) {
                                return false;
                            }
                            return NumberPicker.this.mInputText.requestFocus();
                        case VIRTUAL_VIEW_ID_INPUT /*2*/:
                            if (!NumberPicker.this.isEnabled() || !NumberPicker.this.mInputText.isFocused()) {
                                return false;
                            }
                            NumberPicker.this.mInputText.clearFocus();
                            return true;
                        case RelativeLayout.START_OF /*16*/:
                            if (!NumberPicker.this.isEnabled()) {
                                return false;
                            }
                            NumberPicker.this.performClick();
                            return true;
                        case AccessibilityNodeInfo.ACTION_LONG_CLICK /*32*/:
                            if (!NumberPicker.this.isEnabled()) {
                                return false;
                            }
                            NumberPicker.this.performLongClick();
                            return true;
                        case AccessibilityNodeInfo.ACTION_ACCESSIBILITY_FOCUS /*64*/:
                            if (this.mAccessibilityFocusedView == virtualViewId) {
                                return false;
                            }
                            this.mAccessibilityFocusedView = virtualViewId;
                            sendAccessibilityEventForVirtualView(virtualViewId, AccessibilityNodeInfo.ACTION_PASTE);
                            NumberPicker.this.mInputText.invalidate();
                            return true;
                        case AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS /*128*/:
                            if (this.mAccessibilityFocusedView != virtualViewId) {
                                return false;
                            }
                            this.mAccessibilityFocusedView = UNDEFINED;
                            sendAccessibilityEventForVirtualView(virtualViewId, AccessibilityNodeInfo.ACTION_CUT);
                            NumberPicker.this.mInputText.invalidate();
                            return true;
                        default:
                            return NumberPicker.this.mInputText.performAccessibilityAction(action, arguments);
                    }
                case VIRTUAL_VIEW_ID_DECREMENT /*3*/:
                    switch (action) {
                        case RelativeLayout.START_OF /*16*/:
                            if (!NumberPicker.this.isEnabled()) {
                                return false;
                            }
                            if (virtualViewId == VIRTUAL_VIEW_ID_INCREMENT) {
                                increment = true;
                            }
                            NumberPicker.this.changeValueByOne(increment);
                            sendAccessibilityEventForVirtualView(virtualViewId, VIRTUAL_VIEW_ID_INCREMENT);
                            return true;
                        case AccessibilityNodeInfo.ACTION_ACCESSIBILITY_FOCUS /*64*/:
                            if (this.mAccessibilityFocusedView == virtualViewId) {
                                return false;
                            }
                            this.mAccessibilityFocusedView = virtualViewId;
                            sendAccessibilityEventForVirtualView(virtualViewId, AccessibilityNodeInfo.ACTION_PASTE);
                            NumberPicker.this.invalidate(0, 0, NumberPicker.this.mRight, NumberPicker.this.mTopSelectionDividerTop);
                            return true;
                        case AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS /*128*/:
                            if (this.mAccessibilityFocusedView != virtualViewId) {
                                return false;
                            }
                            this.mAccessibilityFocusedView = UNDEFINED;
                            sendAccessibilityEventForVirtualView(virtualViewId, AccessibilityNodeInfo.ACTION_CUT);
                            NumberPicker.this.invalidate(0, 0, NumberPicker.this.mRight, NumberPicker.this.mTopSelectionDividerTop);
                            return true;
                        default:
                            return false;
                    }
            }
            return super.performAction(virtualViewId, action, arguments);
        }

        public void sendAccessibilityEventForVirtualView(int virtualViewId, int eventType) {
            switch (virtualViewId) {
                case VIRTUAL_VIEW_ID_INCREMENT /*1*/:
                    if (hasVirtualIncrementButton()) {
                        sendAccessibilityEventForVirtualButton(virtualViewId, eventType, getVirtualIncrementButtonText());
                    }
                case VIRTUAL_VIEW_ID_INPUT /*2*/:
                    sendAccessibilityEventForVirtualText(eventType);
                case VIRTUAL_VIEW_ID_DECREMENT /*3*/:
                    if (hasVirtualDecrementButton()) {
                        sendAccessibilityEventForVirtualButton(virtualViewId, eventType, getVirtualDecrementButtonText());
                    }
                default:
            }
        }

        private void sendAccessibilityEventForVirtualText(int eventType) {
            if (AccessibilityManager.getInstance(NumberPicker.this.mContext).isEnabled()) {
                AccessibilityEvent event = AccessibilityEvent.obtain(eventType);
                NumberPicker.this.mInputText.onInitializeAccessibilityEvent(event);
                NumberPicker.this.mInputText.onPopulateAccessibilityEvent(event);
                event.setSource(NumberPicker.this, VIRTUAL_VIEW_ID_INPUT);
                NumberPicker.this.requestSendAccessibilityEvent(NumberPicker.this, event);
            }
        }

        private void sendAccessibilityEventForVirtualButton(int virtualViewId, int eventType, String text) {
            if (AccessibilityManager.getInstance(NumberPicker.this.mContext).isEnabled()) {
                AccessibilityEvent event = AccessibilityEvent.obtain(eventType);
                event.setClassName(Button.class.getName());
                event.setPackageName(NumberPicker.this.mContext.getPackageName());
                event.getText().add(text);
                event.setEnabled(NumberPicker.this.isEnabled());
                event.setSource(NumberPicker.this, virtualViewId);
                NumberPicker.this.requestSendAccessibilityEvent(NumberPicker.this, event);
            }
        }

        private void findAccessibilityNodeInfosByTextInChild(String searchedLowerCase, int virtualViewId, List<AccessibilityNodeInfo> outResult) {
            String text;
            switch (virtualViewId) {
                case VIRTUAL_VIEW_ID_INCREMENT /*1*/:
                    text = getVirtualIncrementButtonText();
                    if (!TextUtils.isEmpty(text) && text.toString().toLowerCase().contains(searchedLowerCase)) {
                        outResult.add(createAccessibilityNodeInfo(VIRTUAL_VIEW_ID_INCREMENT));
                    }
                case VIRTUAL_VIEW_ID_INPUT /*2*/:
                    CharSequence text2 = NumberPicker.this.mInputText.getText();
                    if (TextUtils.isEmpty(text2) || !text2.toString().toLowerCase().contains(searchedLowerCase)) {
                        CharSequence contentDesc = NumberPicker.this.mInputText.getText();
                        if (!TextUtils.isEmpty(contentDesc) && contentDesc.toString().toLowerCase().contains(searchedLowerCase)) {
                            outResult.add(createAccessibilityNodeInfo(VIRTUAL_VIEW_ID_INPUT));
                            return;
                        }
                        return;
                    }
                    outResult.add(createAccessibilityNodeInfo(VIRTUAL_VIEW_ID_INPUT));
                case VIRTUAL_VIEW_ID_DECREMENT /*3*/:
                    text = getVirtualDecrementButtonText();
                    if (!TextUtils.isEmpty(text) && text.toString().toLowerCase().contains(searchedLowerCase)) {
                        outResult.add(createAccessibilityNodeInfo(VIRTUAL_VIEW_ID_DECREMENT));
                    }
                default:
            }
        }

        private AccessibilityNodeInfo createAccessibiltyNodeInfoForInputText(int left, int top, int right, int bottom) {
            AccessibilityNodeInfo info = NumberPicker.this.mInputText.createAccessibilityNodeInfo();
            info.setSource(NumberPicker.this, VIRTUAL_VIEW_ID_INPUT);
            if (this.mAccessibilityFocusedView != VIRTUAL_VIEW_ID_INPUT) {
                info.addAction(64);
            }
            if (this.mAccessibilityFocusedView == VIRTUAL_VIEW_ID_INPUT) {
                info.addAction((int) AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS);
            }
            Rect boundsInParent = this.mTempRect;
            boundsInParent.set(left, top, right, bottom);
            info.setVisibleToUser(NumberPicker.this.isVisibleToUser(boundsInParent));
            info.setBoundsInParent(boundsInParent);
            Rect boundsInScreen = boundsInParent;
            int[] locationOnScreen = this.mTempArray;
            NumberPicker.this.getLocationOnScreen(locationOnScreen);
            boundsInScreen.offset(locationOnScreen[0], locationOnScreen[VIRTUAL_VIEW_ID_INCREMENT]);
            info.setBoundsInScreen(boundsInScreen);
            return info;
        }

        private AccessibilityNodeInfo createAccessibilityNodeInfoForVirtualButton(int virtualViewId, String text, int left, int top, int right, int bottom) {
            AccessibilityNodeInfo info = AccessibilityNodeInfo.obtain();
            info.setClassName(Button.class.getName());
            info.setPackageName(NumberPicker.this.mContext.getPackageName());
            info.setSource(NumberPicker.this, virtualViewId);
            info.setParent(NumberPicker.this);
            info.setText(text);
            info.setClickable(true);
            info.setLongClickable(true);
            info.setEnabled(NumberPicker.this.isEnabled());
            Rect boundsInParent = this.mTempRect;
            boundsInParent.set(left, top, right, bottom);
            info.setVisibleToUser(NumberPicker.this.isVisibleToUser(boundsInParent));
            info.setBoundsInParent(boundsInParent);
            Rect boundsInScreen = boundsInParent;
            int[] locationOnScreen = this.mTempArray;
            NumberPicker.this.getLocationOnScreen(locationOnScreen);
            boundsInScreen.offset(locationOnScreen[0], locationOnScreen[VIRTUAL_VIEW_ID_INCREMENT]);
            info.setBoundsInScreen(boundsInScreen);
            if (this.mAccessibilityFocusedView != virtualViewId) {
                info.addAction(64);
            }
            if (this.mAccessibilityFocusedView == virtualViewId) {
                info.addAction((int) AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS);
            }
            if (NumberPicker.this.isEnabled()) {
                info.addAction(16);
            }
            return info;
        }

        private AccessibilityNodeInfo createAccessibilityNodeInfoForNumberPicker(int left, int top, int right, int bottom) {
            AccessibilityNodeInfo info = AccessibilityNodeInfo.obtain();
            info.setClassName(NumberPicker.class.getName());
            info.setPackageName(NumberPicker.this.mContext.getPackageName());
            info.setSource(NumberPicker.this);
            if (hasVirtualDecrementButton()) {
                info.addChild(NumberPicker.this, VIRTUAL_VIEW_ID_DECREMENT);
            }
            info.addChild(NumberPicker.this, VIRTUAL_VIEW_ID_INPUT);
            if (hasVirtualIncrementButton()) {
                info.addChild(NumberPicker.this, VIRTUAL_VIEW_ID_INCREMENT);
            }
            info.setParent((View) NumberPicker.this.getParentForAccessibility());
            info.setEnabled(NumberPicker.this.isEnabled());
            info.setScrollable(true);
            float applicationScale = NumberPicker.this.getContext().getResources().getCompatibilityInfo().applicationScale;
            Rect boundsInParent = this.mTempRect;
            boundsInParent.set(left, top, right, bottom);
            boundsInParent.scale(applicationScale);
            info.setBoundsInParent(boundsInParent);
            info.setVisibleToUser(NumberPicker.this.isVisibleToUser());
            Rect boundsInScreen = boundsInParent;
            int[] locationOnScreen = this.mTempArray;
            NumberPicker.this.getLocationOnScreen(locationOnScreen);
            boundsInScreen.offset(locationOnScreen[0], locationOnScreen[VIRTUAL_VIEW_ID_INCREMENT]);
            boundsInScreen.scale(applicationScale);
            info.setBoundsInScreen(boundsInScreen);
            if (this.mAccessibilityFocusedView != NumberPicker.SIZE_UNSPECIFIED) {
                info.addAction(64);
            }
            if (this.mAccessibilityFocusedView == NumberPicker.SIZE_UNSPECIFIED) {
                info.addAction((int) AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS);
            }
            if (NumberPicker.this.isEnabled()) {
                if (NumberPicker.this.getWrapSelectorWheel() || NumberPicker.this.getValue() < NumberPicker.this.getMaxValue()) {
                    info.addAction((int) AccessibilityNodeInfo.ACTION_SCROLL_FORWARD);
                }
                if (NumberPicker.this.getWrapSelectorWheel() || NumberPicker.this.getValue() > NumberPicker.this.getMinValue()) {
                    info.addAction((int) AccessibilityNodeInfo.ACTION_SCROLL_BACKWARD);
                }
            }
            return info;
        }

        private boolean hasVirtualDecrementButton() {
            return NumberPicker.this.getWrapSelectorWheel() || NumberPicker.this.getValue() > NumberPicker.this.getMinValue();
        }

        private boolean hasVirtualIncrementButton() {
            return NumberPicker.this.getWrapSelectorWheel() || NumberPicker.this.getValue() < NumberPicker.this.getMaxValue();
        }

        private String getVirtualDecrementButtonText() {
            int value = NumberPicker.this.mValue + NumberPicker.SIZE_UNSPECIFIED;
            if (NumberPicker.this.mWrapSelectorWheel) {
                value = NumberPicker.this.getWrappedSelectorIndex(value);
            }
            if (value >= NumberPicker.this.mMinValue) {
                return NumberPicker.this.mDisplayedValues == null ? NumberPicker.this.formatNumber(value) : NumberPicker.this.mDisplayedValues[value - NumberPicker.this.mMinValue];
            } else {
                return null;
            }
        }

        private String getVirtualIncrementButtonText() {
            int value = NumberPicker.this.mValue + VIRTUAL_VIEW_ID_INCREMENT;
            if (NumberPicker.this.mWrapSelectorWheel) {
                value = NumberPicker.this.getWrappedSelectorIndex(value);
            }
            if (value <= NumberPicker.this.mMaxValue) {
                return NumberPicker.this.mDisplayedValues == null ? NumberPicker.this.formatNumber(value) : NumberPicker.this.mDisplayedValues[value - NumberPicker.this.mMinValue];
            } else {
                return null;
            }
        }
    }

    class BeginSoftInputOnLongPressCommand implements Runnable {
        BeginSoftInputOnLongPressCommand() {
        }

        public void run() {
            NumberPicker.this.performLongClick();
        }
    }

    class ChangeCurrentByOneFromLongPressCommand implements Runnable {
        private boolean mIncrement;

        ChangeCurrentByOneFromLongPressCommand() {
        }

        private void setStep(boolean increment) {
            this.mIncrement = increment;
        }

        public void run() {
            NumberPicker.this.changeValueByOne(this.mIncrement);
            NumberPicker.this.postDelayed(this, NumberPicker.this.mLongPressUpdateInterval);
        }
    }

    public static class CustomEditText extends EditText {
        public CustomEditText(Context context, AttributeSet attrs) {
            super(context, attrs);
        }

        public void onEditorAction(int actionCode) {
            super.onEditorAction(actionCode);
            if (actionCode == 6) {
                clearFocus();
            }
        }
    }

    public interface Formatter {
        String format(int i);
    }

    class InputTextFilter extends NumberKeyListener {
        InputTextFilter() {
        }

        public int getInputType() {
            return NumberPicker.SELECTOR_MIDDLE_ITEM_INDEX;
        }

        protected char[] getAcceptedChars() {
            return NumberPicker.DIGIT_CHARACTERS;
        }

        public CharSequence filter(CharSequence source, int start, int end, Spanned dest, int dstart, int dend) {
            CharSequence filtered;
            String result;
            if (NumberPicker.this.mDisplayedValues == null) {
                filtered = super.filter(source, start, end, dest, dstart, dend);
                if (filtered == null) {
                    filtered = source.subSequence(start, end);
                }
                result = String.valueOf(dest.subSequence(0, dstart)) + filtered + dest.subSequence(dend, dest.length());
                if (ProxyInfo.LOCAL_EXCL_LIST.equals(result)) {
                    return result;
                }
                return (NumberPicker.this.getSelectedPos(result) > NumberPicker.this.mMaxValue || result.length() > String.valueOf(NumberPicker.this.mMaxValue).length()) ? ProxyInfo.LOCAL_EXCL_LIST : filtered;
            } else {
                filtered = String.valueOf(source.subSequence(start, end));
                if (TextUtils.isEmpty(filtered)) {
                    return ProxyInfo.LOCAL_EXCL_LIST;
                }
                result = String.valueOf(dest.subSequence(0, dstart)) + filtered + dest.subSequence(dend, dest.length());
                String str = String.valueOf(result).toLowerCase();
                String[] arr$ = NumberPicker.this.mDisplayedValues;
                int len$ = arr$.length;
                for (int i$ = 0; i$ < len$; i$ += NumberPicker.SELECTOR_MIDDLE_ITEM_INDEX) {
                    String val = arr$[i$];
                    if (val.toLowerCase().startsWith(str)) {
                        NumberPicker.this.postSetSelectionCommand(result.length(), val.length());
                        return val.subSequence(dstart, val.length());
                    }
                }
                return ProxyInfo.LOCAL_EXCL_LIST;
            }
        }
    }

    public interface OnScrollListener {
        public static final int SCROLL_STATE_FLING = 2;
        public static final int SCROLL_STATE_IDLE = 0;
        public static final int SCROLL_STATE_TOUCH_SCROLL = 1;

        void onScrollStateChange(NumberPicker numberPicker, int i);
    }

    class PressedStateHelper implements Runnable {
        public static final int BUTTON_DECREMENT = 2;
        public static final int BUTTON_INCREMENT = 1;
        private final int MODE_PRESS;
        private final int MODE_TAPPED;
        private int mManagedButton;
        private int mMode;

        PressedStateHelper() {
            this.MODE_PRESS = BUTTON_INCREMENT;
            this.MODE_TAPPED = BUTTON_DECREMENT;
        }

        public void cancel() {
            this.mMode = 0;
            this.mManagedButton = 0;
            NumberPicker.this.removeCallbacks(this);
            if (NumberPicker.this.mIncrementVirtualButtonPressed) {
                NumberPicker.this.mIncrementVirtualButtonPressed = false;
                NumberPicker.this.invalidate(0, NumberPicker.this.mBottomSelectionDividerBottom, NumberPicker.this.mRight, NumberPicker.this.mBottom);
            }
            NumberPicker.this.mDecrementVirtualButtonPressed = false;
            if (NumberPicker.this.mDecrementVirtualButtonPressed) {
                NumberPicker.this.invalidate(0, 0, NumberPicker.this.mRight, NumberPicker.this.mTopSelectionDividerTop);
            }
        }

        public void buttonPressDelayed(int button) {
            cancel();
            this.mMode = BUTTON_INCREMENT;
            this.mManagedButton = button;
            NumberPicker.this.postDelayed(this, (long) ViewConfiguration.getTapTimeout());
        }

        public void buttonTapped(int button) {
            cancel();
            this.mMode = BUTTON_DECREMENT;
            this.mManagedButton = button;
            NumberPicker.this.post(this);
        }

        public void run() {
            switch (this.mMode) {
                case BUTTON_INCREMENT /*1*/:
                    switch (this.mManagedButton) {
                        case BUTTON_INCREMENT /*1*/:
                            NumberPicker.this.mIncrementVirtualButtonPressed = true;
                            NumberPicker.this.invalidate(0, NumberPicker.this.mBottomSelectionDividerBottom, NumberPicker.this.mRight, NumberPicker.this.mBottom);
                        case BUTTON_DECREMENT /*2*/:
                            NumberPicker.this.mDecrementVirtualButtonPressed = true;
                            NumberPicker.this.invalidate(0, 0, NumberPicker.this.mRight, NumberPicker.this.mTopSelectionDividerTop);
                        default:
                    }
                case BUTTON_DECREMENT /*2*/:
                    switch (this.mManagedButton) {
                        case BUTTON_INCREMENT /*1*/:
                            if (!NumberPicker.this.mIncrementVirtualButtonPressed) {
                                NumberPicker.this.postDelayed(this, (long) ViewConfiguration.getPressedStateDuration());
                            }
                            NumberPicker.access$1380(NumberPicker.this, BUTTON_INCREMENT);
                            NumberPicker.this.invalidate(0, NumberPicker.this.mBottomSelectionDividerBottom, NumberPicker.this.mRight, NumberPicker.this.mBottom);
                        case BUTTON_DECREMENT /*2*/:
                            if (!NumberPicker.this.mDecrementVirtualButtonPressed) {
                                NumberPicker.this.postDelayed(this, (long) ViewConfiguration.getPressedStateDuration());
                            }
                            NumberPicker.access$1780(NumberPicker.this, BUTTON_INCREMENT);
                            NumberPicker.this.invalidate(0, 0, NumberPicker.this.mRight, NumberPicker.this.mTopSelectionDividerTop);
                        default:
                    }
                default:
            }
        }
    }

    class SetSelectionCommand implements Runnable {
        private int mSelectionEnd;
        private int mSelectionStart;

        SetSelectionCommand() {
        }

        public void run() {
            NumberPicker.this.mInputText.setSelection(this.mSelectionStart, this.mSelectionEnd);
        }
    }

    private static class TwoDigitFormatter implements Formatter {
        final Object[] mArgs;
        final StringBuilder mBuilder;
        java.util.Formatter mFmt;
        char mZeroDigit;

        TwoDigitFormatter() {
            this.mBuilder = new StringBuilder();
            this.mArgs = new Object[NumberPicker.SELECTOR_MIDDLE_ITEM_INDEX];
            init(Locale.getDefault());
        }

        private void init(Locale locale) {
            this.mFmt = createFormatter(locale);
            this.mZeroDigit = getZeroDigit(locale);
        }

        public String format(int value) {
            Locale currentLocale = Locale.getDefault();
            if (this.mZeroDigit != getZeroDigit(currentLocale)) {
                init(currentLocale);
            }
            this.mArgs[0] = Integer.valueOf(value);
            this.mBuilder.delete(0, this.mBuilder.length());
            this.mFmt.format("%02d", this.mArgs);
            return this.mFmt.toString();
        }

        private static char getZeroDigit(Locale locale) {
            return LocaleData.get(locale).zeroDigit;
        }

        private java.util.Formatter createFormatter(Locale locale) {
            return new java.util.Formatter(this.mBuilder, locale);
        }
    }

    static /* synthetic */ boolean access$1380(NumberPicker x0, int x1) {
        boolean z = (byte) (x0.mIncrementVirtualButtonPressed ^ x1);
        x0.mIncrementVirtualButtonPressed = z;
        return z;
    }

    static /* synthetic */ boolean access$1780(NumberPicker x0, int x1) {
        boolean z = (byte) (x0.mDecrementVirtualButtonPressed ^ x1);
        x0.mDecrementVirtualButtonPressed = z;
        return z;
    }

    static {
        sTwoDigitFormatter = new TwoDigitFormatter();
        DIGIT_CHARACTERS = new char[]{'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '\u0660', '\u0661', '\u0662', '\u0663', '\u0664', '\u0665', '\u0666', '\u0667', '\u0668', '\u0669', '\u06f0', '\u06f1', '\u06f2', '\u06f3', '\u06f4', '\u06f5', '\u06f6', '\u06f7', '\u06f8', '\u06f9', '\u0966', '\u0967', '\u0968', '\u0969', '\u096a', '\u096b', '\u096c', '\u096d', '\u096e', '\u096f', '\u09e6', '\u09e7', '\u09e8', '\u09e9', '\u09ea', '\u09eb', '\u09ec', '\u09ed', '\u09ee', '\u09ef', '\u0ce6', '\u0ce7', '\u0ce8', '\u0ce9', '\u0cea', '\u0ceb', '\u0cec', '\u0ced', '\u0cee', '\u0cef'};
    }

    public static final Formatter getTwoDigitFormatter() {
        return sTwoDigitFormatter;
    }

    public NumberPicker(Context context) {
        this(context, null);
    }

    public NumberPicker(Context context, AttributeSet attrs) {
        this(context, attrs, 18219031);
    }

    public NumberPicker(Context context, AttributeSet attrs, int defStyleAttr) {
        this(context, attrs, defStyleAttr, 0);
    }

    public NumberPicker(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        int i;
        super(context, attrs, defStyleAttr, defStyleRes);
        this.mLongPressUpdateInterval = DEFAULT_LONG_PRESS_UPDATE_INTERVAL;
        this.mSelectorIndexToStringCache = new SparseArray();
        this.mSelectorIndices = new int[SELECTOR_WHEEL_ITEM_COUNT];
        this.mInitialScrollOffset = RtlSpacingHelper.UNDEFINED;
        this.mScrollState = 0;
        this.mLastHandledDownDpadKeyCode = SIZE_UNSPECIFIED;
        TypedArray attributesArray = context.obtainStyledAttributes(attrs, R.styleable.NumberPicker, defStyleAttr, defStyleRes);
        int layoutResId = attributesArray.getResourceId(SELECTOR_MIDDLE_ITEM_INDEX, DEFAULT_LAYOUT_RESOURCE_ID);
        this.mHasSelectorWheel = layoutResId != DEFAULT_LAYOUT_RESOURCE_ID;
        this.mHideWheelUntilFocused = attributesArray.getBoolean(10, false);
        this.mSolidColor = attributesArray.getColor(0, 0);
        this.mSelectionDivider = attributesArray.getDrawable(UNSCALED_DEFAULT_SELECTION_DIVIDER_HEIGHT);
        this.mSelectionDividerHeight = attributesArray.getDimensionPixelSize(SELECTOR_WHEEL_ITEM_COUNT, (int) TypedValue.applyDimension(SELECTOR_MIDDLE_ITEM_INDEX, 2.0f, getResources().getDisplayMetrics()));
        this.mSelectionDividersDistance = attributesArray.getDimensionPixelSize(4, (int) TypedValue.applyDimension(SELECTOR_MIDDLE_ITEM_INDEX, 48.0f, getResources().getDisplayMetrics()));
        this.mMinHeight = attributesArray.getDimensionPixelSize(5, SIZE_UNSPECIFIED);
        this.mMaxHeight = attributesArray.getDimensionPixelSize(6, SIZE_UNSPECIFIED);
        if (!(this.mMinHeight == SIZE_UNSPECIFIED || this.mMaxHeight == SIZE_UNSPECIFIED)) {
            i = this.mMinHeight;
            int i2 = this.mMaxHeight;
            if (i > r0) {
                throw new IllegalArgumentException("minHeight > maxHeight");
            }
        }
        this.mMinWidth = attributesArray.getDimensionPixelSize(7, SIZE_UNSPECIFIED);
        this.mMaxWidth = attributesArray.getDimensionPixelSize(SELECTOR_MAX_FLING_VELOCITY_ADJUSTMENT, SIZE_UNSPECIFIED);
        if (!(this.mMinWidth == SIZE_UNSPECIFIED || this.mMaxWidth == SIZE_UNSPECIFIED)) {
            i = this.mMinWidth;
            i2 = this.mMaxWidth;
            if (i > r0) {
                throw new IllegalArgumentException("minWidth > maxWidth");
            }
        }
        this.mComputeMaxWidth = this.mMaxWidth == SIZE_UNSPECIFIED;
        this.mVirtualButtonPressedDrawable = attributesArray.getDrawable(9);
        attributesArray.recycle();
        this.mPressedStateHelper = new PressedStateHelper();
        setWillNotDraw(!this.mHasSelectorWheel);
        ((LayoutInflater) getContext().getSystemService(Context.LAYOUT_INFLATER_SERVICE)).inflate(layoutResId, (ViewGroup) this, true);
        OnClickListener onClickListener = new C10091();
        OnLongClickListener onLongClickListener = new C10102();
        if (this.mHasSelectorWheel) {
            this.mIncrementButton = null;
        } else {
            this.mIncrementButton = (ImageButton) findViewById(16909130);
            this.mIncrementButton.setOnClickListener(onClickListener);
            this.mIncrementButton.setOnLongClickListener(onLongClickListener);
        }
        if (this.mHasSelectorWheel) {
            this.mDecrementButton = null;
        } else {
            this.mDecrementButton = (ImageButton) findViewById(16909132);
            this.mDecrementButton.setOnClickListener(onClickListener);
            this.mDecrementButton.setOnLongClickListener(onLongClickListener);
        }
        this.mInputText = (EditText) findViewById(16909131);
        this.mInputText.setOnFocusChangeListener(new C10113());
        EditText editText = this.mInputText;
        InputFilter[] inputFilterArr = new InputFilter[SELECTOR_MIDDLE_ITEM_INDEX];
        inputFilterArr[0] = new InputTextFilter();
        editText.setFilters(inputFilterArr);
        this.mInputText.setRawInputType(UNSCALED_DEFAULT_SELECTION_DIVIDER_HEIGHT);
        this.mInputText.setImeOptions(6);
        ViewConfiguration configuration = ViewConfiguration.get(context);
        this.mTouchSlop = configuration.getScaledTouchSlop();
        this.mMinimumFlingVelocity = configuration.getScaledMinimumFlingVelocity();
        this.mMaximumFlingVelocity = configuration.getScaledMaximumFlingVelocity() / SELECTOR_MAX_FLING_VELOCITY_ADJUSTMENT;
        this.mTextSize = (int) this.mInputText.getTextSize();
        Paint paint = new Paint();
        paint.setAntiAlias(true);
        paint.setTextAlign(Align.CENTER);
        paint.setTextSize((float) this.mTextSize);
        paint.setTypeface(this.mInputText.getTypeface());
        paint.setColor(this.mInputText.getTextColors().getColorForState(ENABLED_STATE_SET, SIZE_UNSPECIFIED));
        this.mSelectorWheelPaint = paint;
        this.mFlingScroller = new Scroller(getContext(), null, true);
        this.mAdjustScroller = new Scroller(getContext(), new DecelerateInterpolator(2.5f));
        updateInputTextView();
        if (getImportantForAccessibility() == 0) {
            setImportantForAccessibility(SELECTOR_MIDDLE_ITEM_INDEX);
        }
    }

    protected void onLayout(boolean changed, int left, int top, int right, int bottom) {
        if (this.mHasSelectorWheel) {
            int msrdWdth = getMeasuredWidth();
            int msrdHght = getMeasuredHeight();
            int inptTxtMsrdWdth = this.mInputText.getMeasuredWidth();
            int inptTxtMsrdHght = this.mInputText.getMeasuredHeight();
            int inptTxtLeft = (msrdWdth - inptTxtMsrdWdth) / UNSCALED_DEFAULT_SELECTION_DIVIDER_HEIGHT;
            int inptTxtTop = (msrdHght - inptTxtMsrdHght) / UNSCALED_DEFAULT_SELECTION_DIVIDER_HEIGHT;
            this.mInputText.layout(inptTxtLeft, inptTxtTop, inptTxtLeft + inptTxtMsrdWdth, inptTxtTop + inptTxtMsrdHght);
            if (changed) {
                initializeSelectorWheel();
                initializeFadingEdges();
                this.mTopSelectionDividerTop = ((getHeight() - this.mSelectionDividersDistance) / UNSCALED_DEFAULT_SELECTION_DIVIDER_HEIGHT) - this.mSelectionDividerHeight;
                this.mBottomSelectionDividerBottom = (this.mTopSelectionDividerTop + (this.mSelectionDividerHeight * UNSCALED_DEFAULT_SELECTION_DIVIDER_HEIGHT)) + this.mSelectionDividersDistance;
                return;
            }
            return;
        }
        super.onLayout(changed, left, top, right, bottom);
    }

    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        if (this.mHasSelectorWheel) {
            super.onMeasure(makeMeasureSpec(widthMeasureSpec, this.mMaxWidth), makeMeasureSpec(heightMeasureSpec, this.mMaxHeight));
            setMeasuredDimension(resolveSizeAndStateRespectingMinSize(this.mMinWidth, getMeasuredWidth(), widthMeasureSpec), resolveSizeAndStateRespectingMinSize(this.mMinHeight, getMeasuredHeight(), heightMeasureSpec));
            return;
        }
        super.onMeasure(widthMeasureSpec, heightMeasureSpec);
    }

    private boolean moveToFinalScrollerPosition(Scroller scroller) {
        scroller.forceFinished(true);
        int amountToScroll = scroller.getFinalY() - scroller.getCurrY();
        int overshootAdjustment = this.mInitialScrollOffset - ((this.mCurrentScrollOffset + amountToScroll) % this.mSelectorElementHeight);
        if (overshootAdjustment == 0) {
            return false;
        }
        if (Math.abs(overshootAdjustment) > this.mSelectorElementHeight / UNSCALED_DEFAULT_SELECTION_DIVIDER_HEIGHT) {
            if (overshootAdjustment > 0) {
                overshootAdjustment -= this.mSelectorElementHeight;
            } else {
                overshootAdjustment += this.mSelectorElementHeight;
            }
        }
        scrollBy(0, amountToScroll + overshootAdjustment);
        return true;
    }

    public boolean onInterceptTouchEvent(MotionEvent event) {
        if (!this.mHasSelectorWheel || !isEnabled()) {
            return false;
        }
        switch (event.getActionMasked()) {
            case Toast.LENGTH_SHORT /*0*/:
                removeAllCallbacks();
                this.mInputText.setVisibility(4);
                float y = event.getY();
                this.mLastDownEventY = y;
                this.mLastDownOrMoveEventY = y;
                this.mLastDownEventTime = event.getEventTime();
                this.mIgnoreMoveEvents = false;
                this.mPerformClickOnTap = false;
                if (this.mLastDownEventY < ((float) this.mTopSelectionDividerTop)) {
                    if (this.mScrollState == 0) {
                        this.mPressedStateHelper.buttonPressDelayed(UNSCALED_DEFAULT_SELECTION_DIVIDER_HEIGHT);
                    }
                } else if (this.mLastDownEventY > ((float) this.mBottomSelectionDividerBottom) && this.mScrollState == 0) {
                    this.mPressedStateHelper.buttonPressDelayed(SELECTOR_MIDDLE_ITEM_INDEX);
                }
                getParent().requestDisallowInterceptTouchEvent(true);
                if (!this.mFlingScroller.isFinished()) {
                    this.mFlingScroller.forceFinished(true);
                    this.mAdjustScroller.forceFinished(true);
                    onScrollStateChange(0);
                    return true;
                } else if (!this.mAdjustScroller.isFinished()) {
                    this.mFlingScroller.forceFinished(true);
                    this.mAdjustScroller.forceFinished(true);
                    return true;
                } else if (this.mLastDownEventY < ((float) this.mTopSelectionDividerTop)) {
                    hideSoftInput();
                    postChangeCurrentByOneFromLongPress(false, (long) ViewConfiguration.getLongPressTimeout());
                    return true;
                } else if (this.mLastDownEventY > ((float) this.mBottomSelectionDividerBottom)) {
                    hideSoftInput();
                    postChangeCurrentByOneFromLongPress(true, (long) ViewConfiguration.getLongPressTimeout());
                    return true;
                } else {
                    this.mPerformClickOnTap = true;
                    postBeginSoftInputOnLongPressCommand();
                    return true;
                }
            default:
                return false;
        }
    }

    public boolean onTouchEvent(MotionEvent event) {
        if (!isEnabled() || !this.mHasSelectorWheel) {
            return false;
        }
        if (this.mVelocityTracker == null) {
            this.mVelocityTracker = VelocityTracker.obtain();
        }
        this.mVelocityTracker.addMovement(event);
        switch (event.getActionMasked()) {
            case SELECTOR_MIDDLE_ITEM_INDEX /*1*/:
                removeBeginSoftInputCommand();
                removeChangeCurrentByOneFromLongPress();
                this.mPressedStateHelper.cancel();
                VelocityTracker velocityTracker = this.mVelocityTracker;
                velocityTracker.computeCurrentVelocity(LayoutParams.TYPE_APPLICATION_PANEL, (float) this.mMaximumFlingVelocity);
                int initialVelocity = (int) velocityTracker.getYVelocity();
                if (Math.abs(initialVelocity) > this.mMinimumFlingVelocity) {
                    fling(initialVelocity);
                    onScrollStateChange(UNSCALED_DEFAULT_SELECTION_DIVIDER_HEIGHT);
                } else {
                    int eventY = (int) event.getY();
                    long deltaTime = event.getEventTime() - this.mLastDownEventTime;
                    if (((int) Math.abs(((float) eventY) - this.mLastDownEventY)) > this.mTouchSlop || deltaTime >= ((long) ViewConfiguration.getTapTimeout())) {
                        ensureScrollWheelAdjusted();
                    } else if (this.mPerformClickOnTap) {
                        this.mPerformClickOnTap = false;
                        performClick();
                    } else {
                        int selectorIndexOffset = (eventY / this.mSelectorElementHeight) + SIZE_UNSPECIFIED;
                        if (selectorIndexOffset > 0) {
                            changeValueByOne(true);
                            this.mPressedStateHelper.buttonTapped(SELECTOR_MIDDLE_ITEM_INDEX);
                        } else if (selectorIndexOffset < 0) {
                            changeValueByOne(false);
                            this.mPressedStateHelper.buttonTapped(UNSCALED_DEFAULT_SELECTION_DIVIDER_HEIGHT);
                        }
                    }
                    onScrollStateChange(0);
                }
                this.mVelocityTracker.recycle();
                this.mVelocityTracker = null;
                break;
            case UNSCALED_DEFAULT_SELECTION_DIVIDER_HEIGHT /*2*/:
                if (!this.mIgnoreMoveEvents) {
                    float currentMoveY = event.getY();
                    if (this.mScrollState == SELECTOR_MIDDLE_ITEM_INDEX) {
                        scrollBy(0, (int) (currentMoveY - this.mLastDownOrMoveEventY));
                        invalidate();
                    } else if (((int) Math.abs(currentMoveY - this.mLastDownEventY)) > this.mTouchSlop) {
                        removeAllCallbacks();
                        onScrollStateChange(SELECTOR_MIDDLE_ITEM_INDEX);
                    }
                    this.mLastDownOrMoveEventY = currentMoveY;
                    break;
                }
                break;
        }
        return true;
    }

    public boolean dispatchTouchEvent(MotionEvent event) {
        switch (event.getActionMasked()) {
            case SELECTOR_MIDDLE_ITEM_INDEX /*1*/:
            case SELECTOR_WHEEL_ITEM_COUNT /*3*/:
                removeAllCallbacks();
                break;
        }
        return super.dispatchTouchEvent(event);
    }

    /* JADX WARNING: inconsistent code. */
    /* Code decompiled incorrectly, please refer to instructions dump. */
    public boolean dispatchKeyEvent(android.view.KeyEvent r6) {
        /*
        r5 = this;
        r4 = 20;
        r2 = 1;
        r0 = r6.getKeyCode();
        switch(r0) {
            case 19: goto L_0x0013;
            case 20: goto L_0x0013;
            case 23: goto L_0x000f;
            case 66: goto L_0x000f;
            default: goto L_0x000a;
        };
    L_0x000a:
        r2 = super.dispatchKeyEvent(r6);
    L_0x000e:
        return r2;
    L_0x000f:
        r5.removeAllCallbacks();
        goto L_0x000a;
    L_0x0013:
        r1 = r5.mHasSelectorWheel;
        if (r1 == 0) goto L_0x000a;
    L_0x0017:
        r1 = r6.getAction();
        switch(r1) {
            case 0: goto L_0x001f;
            case 1: goto L_0x0053;
            default: goto L_0x001e;
        };
    L_0x001e:
        goto L_0x000a;
    L_0x001f:
        r1 = r5.mWrapSelectorWheel;
        if (r1 != 0) goto L_0x002f;
    L_0x0023:
        if (r0 != r4) goto L_0x0046;
    L_0x0025:
        r1 = r5.getValue();
        r3 = r5.getMaxValue();
        if (r1 >= r3) goto L_0x000a;
    L_0x002f:
        r5.requestFocus();
        r5.mLastHandledDownDpadKeyCode = r0;
        r5.removeAllCallbacks();
        r1 = r5.mFlingScroller;
        r1 = r1.isFinished();
        if (r1 == 0) goto L_0x000e;
    L_0x003f:
        if (r0 != r4) goto L_0x0051;
    L_0x0041:
        r1 = r2;
    L_0x0042:
        r5.changeValueByOne(r1);
        goto L_0x000e;
    L_0x0046:
        r1 = r5.getValue();
        r3 = r5.getMinValue();
        if (r1 <= r3) goto L_0x000a;
    L_0x0050:
        goto L_0x002f;
    L_0x0051:
        r1 = 0;
        goto L_0x0042;
    L_0x0053:
        r1 = r5.mLastHandledDownDpadKeyCode;
        if (r1 != r0) goto L_0x000a;
    L_0x0057:
        r1 = -1;
        r5.mLastHandledDownDpadKeyCode = r1;
        goto L_0x000e;
        */
        throw new UnsupportedOperationException("Method not decompiled: android.widget.NumberPicker.dispatchKeyEvent(android.view.KeyEvent):boolean");
    }

    public boolean dispatchTrackballEvent(MotionEvent event) {
        switch (event.getActionMasked()) {
            case SELECTOR_MIDDLE_ITEM_INDEX /*1*/:
            case SELECTOR_WHEEL_ITEM_COUNT /*3*/:
                removeAllCallbacks();
                break;
        }
        return super.dispatchTrackballEvent(event);
    }

    protected boolean dispatchHoverEvent(MotionEvent event) {
        if (!this.mHasSelectorWheel) {
            return super.dispatchHoverEvent(event);
        }
        if (AccessibilityManager.getInstance(this.mContext).isEnabled()) {
            int hoveredVirtualViewId;
            int eventY = (int) event.getY();
            if (eventY < this.mTopSelectionDividerTop) {
                hoveredVirtualViewId = SELECTOR_WHEEL_ITEM_COUNT;
            } else if (eventY > this.mBottomSelectionDividerBottom) {
                hoveredVirtualViewId = SELECTOR_MIDDLE_ITEM_INDEX;
            } else {
                hoveredVirtualViewId = UNSCALED_DEFAULT_SELECTION_DIVIDER_HEIGHT;
            }
            AccessibilityNodeProviderImpl provider = (AccessibilityNodeProviderImpl) getAccessibilityNodeProvider();
            switch (event.getActionMasked()) {
                case SpellChecker.AVERAGE_WORD_LENGTH /*7*/:
                    if (!(this.mLastHoveredChildVirtualViewId == hoveredVirtualViewId || this.mLastHoveredChildVirtualViewId == SIZE_UNSPECIFIED)) {
                        provider.sendAccessibilityEventForVirtualView(this.mLastHoveredChildVirtualViewId, InputMethodManager.CONTROL_START_INITIAL);
                        provider.sendAccessibilityEventForVirtualView(hoveredVirtualViewId, AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS);
                        this.mLastHoveredChildVirtualViewId = hoveredVirtualViewId;
                        provider.performAction(hoveredVirtualViewId, 64, null);
                        break;
                    }
                case SetOnClickFillInIntent.TAG /*9*/:
                    provider.sendAccessibilityEventForVirtualView(hoveredVirtualViewId, AccessibilityNodeInfo.ACTION_CLEAR_ACCESSIBILITY_FOCUS);
                    this.mLastHoveredChildVirtualViewId = hoveredVirtualViewId;
                    provider.performAction(hoveredVirtualViewId, 64, null);
                    break;
                case SetRemoteViewsAdapterIntent.TAG /*10*/:
                    provider.sendAccessibilityEventForVirtualView(hoveredVirtualViewId, InputMethodManager.CONTROL_START_INITIAL);
                    this.mLastHoveredChildVirtualViewId = SIZE_UNSPECIFIED;
                    break;
            }
        }
        return false;
    }

    public void computeScroll() {
        Scroller scroller = this.mFlingScroller;
        if (scroller.isFinished()) {
            scroller = this.mAdjustScroller;
            if (scroller.isFinished()) {
                return;
            }
        }
        scroller.computeScrollOffset();
        int currentScrollerY = scroller.getCurrY();
        if (this.mPreviousScrollerY == 0) {
            this.mPreviousScrollerY = scroller.getStartY();
        }
        scrollBy(0, currentScrollerY - this.mPreviousScrollerY);
        this.mPreviousScrollerY = currentScrollerY;
        if (scroller.isFinished()) {
            onScrollerFinished(scroller);
        } else {
            invalidate();
        }
    }

    public void setEnabled(boolean enabled) {
        super.setEnabled(enabled);
        if (!this.mHasSelectorWheel) {
            this.mIncrementButton.setEnabled(enabled);
        }
        if (!this.mHasSelectorWheel) {
            this.mDecrementButton.setEnabled(enabled);
        }
        this.mInputText.setEnabled(enabled);
    }

    public void scrollBy(int x, int y) {
        int[] selectorIndices = this.mSelectorIndices;
        if (!this.mWrapSelectorWheel && y > 0 && selectorIndices[SELECTOR_MIDDLE_ITEM_INDEX] <= this.mMinValue) {
            this.mCurrentScrollOffset = this.mInitialScrollOffset;
        } else if (this.mWrapSelectorWheel || y >= 0 || selectorIndices[SELECTOR_MIDDLE_ITEM_INDEX] < this.mMaxValue) {
            this.mCurrentScrollOffset += y;
            while (this.mCurrentScrollOffset - this.mInitialScrollOffset > this.mSelectorTextGapHeight) {
                this.mCurrentScrollOffset -= this.mSelectorElementHeight;
                decrementSelectorIndices(selectorIndices);
                setValueInternal(selectorIndices[SELECTOR_MIDDLE_ITEM_INDEX], true);
                if (!this.mWrapSelectorWheel && selectorIndices[SELECTOR_MIDDLE_ITEM_INDEX] <= this.mMinValue) {
                    this.mCurrentScrollOffset = this.mInitialScrollOffset;
                }
            }
            while (this.mCurrentScrollOffset - this.mInitialScrollOffset < (-this.mSelectorTextGapHeight)) {
                this.mCurrentScrollOffset += this.mSelectorElementHeight;
                incrementSelectorIndices(selectorIndices);
                setValueInternal(selectorIndices[SELECTOR_MIDDLE_ITEM_INDEX], true);
                if (!this.mWrapSelectorWheel && selectorIndices[SELECTOR_MIDDLE_ITEM_INDEX] >= this.mMaxValue) {
                    this.mCurrentScrollOffset = this.mInitialScrollOffset;
                }
            }
        } else {
            this.mCurrentScrollOffset = this.mInitialScrollOffset;
        }
    }

    protected int computeVerticalScrollOffset() {
        return this.mCurrentScrollOffset;
    }

    protected int computeVerticalScrollRange() {
        return ((this.mMaxValue - this.mMinValue) + SELECTOR_MIDDLE_ITEM_INDEX) * this.mSelectorElementHeight;
    }

    protected int computeVerticalScrollExtent() {
        return getHeight();
    }

    public int getSolidColor() {
        return this.mSolidColor;
    }

    public void setOnValueChangedListener(OnValueChangeListener onValueChangedListener) {
        this.mOnValueChangeListener = onValueChangedListener;
    }

    public void setOnScrollListener(OnScrollListener onScrollListener) {
        this.mOnScrollListener = onScrollListener;
    }

    public void setFormatter(Formatter formatter) {
        if (formatter != this.mFormatter) {
            this.mFormatter = formatter;
            initializeSelectorWheelIndices();
            updateInputTextView();
        }
    }

    public void setValue(int value) {
        setValueInternal(value, false);
    }

    public boolean performClick() {
        if (!this.mHasSelectorWheel) {
            return super.performClick();
        }
        if (!super.performClick()) {
            showSoftInput();
        }
        return true;
    }

    public boolean performLongClick() {
        if (!this.mHasSelectorWheel) {
            return super.performLongClick();
        }
        if (super.performLongClick()) {
            return true;
        }
        showSoftInput();
        this.mIgnoreMoveEvents = true;
        return true;
    }

    private void showSoftInput() {
        InputMethodManager inputMethodManager = InputMethodManager.peekInstance();
        if (inputMethodManager != null) {
            if (this.mHasSelectorWheel) {
                this.mInputText.setVisibility(0);
            }
            this.mInputText.requestFocus();
            inputMethodManager.showSoftInput(this.mInputText, 0);
        }
    }

    private void hideSoftInput() {
        InputMethodManager inputMethodManager = InputMethodManager.peekInstance();
        if (inputMethodManager != null && inputMethodManager.isActive(this.mInputText)) {
            inputMethodManager.hideSoftInputFromWindow(getWindowToken(), 0);
            if (this.mHasSelectorWheel) {
                this.mInputText.setVisibility(4);
            }
        }
    }

    private void tryComputeMaxWidth() {
        if (this.mComputeMaxWidth) {
            int maxTextWidth = 0;
            int i;
            if (this.mDisplayedValues == null) {
                float maxDigitWidth = 0.0f;
                for (i = 0; i <= 9; i += SELECTOR_MIDDLE_ITEM_INDEX) {
                    float digitWidth = this.mSelectorWheelPaint.measureText(formatNumberWithLocale(i));
                    if (digitWidth > maxDigitWidth) {
                        maxDigitWidth = digitWidth;
                    }
                }
                int numberOfDigits = 0;
                for (int current = this.mMaxValue; current > 0; current /= 10) {
                    numberOfDigits += SELECTOR_MIDDLE_ITEM_INDEX;
                }
                maxTextWidth = (int) (((float) numberOfDigits) * maxDigitWidth);
            } else {
                int valueCount = this.mDisplayedValues.length;
                for (i = 0; i < valueCount; i += SELECTOR_MIDDLE_ITEM_INDEX) {
                    float textWidth = this.mSelectorWheelPaint.measureText(this.mDisplayedValues[i]);
                    if (textWidth > ((float) maxTextWidth)) {
                        maxTextWidth = (int) textWidth;
                    }
                }
            }
            maxTextWidth += this.mInputText.getPaddingLeft() + this.mInputText.getPaddingRight();
            if (this.mMaxWidth != maxTextWidth) {
                if (maxTextWidth > this.mMinWidth) {
                    this.mMaxWidth = maxTextWidth;
                } else {
                    this.mMaxWidth = this.mMinWidth;
                }
                invalidate();
            }
        }
    }

    public boolean getWrapSelectorWheel() {
        return this.mWrapSelectorWheel;
    }

    public void setWrapSelectorWheel(boolean wrapSelectorWheel) {
        boolean wrappingAllowed = this.mMaxValue - this.mMinValue >= this.mSelectorIndices.length;
        if ((!wrapSelectorWheel || wrappingAllowed) && wrapSelectorWheel != this.mWrapSelectorWheel) {
            this.mWrapSelectorWheel = wrapSelectorWheel;
        }
    }

    public void setOnLongPressUpdateInterval(long intervalMillis) {
        this.mLongPressUpdateInterval = intervalMillis;
    }

    public int getValue() {
        return this.mValue;
    }

    public int getMinValue() {
        return this.mMinValue;
    }

    public void setMinValue(int minValue) {
        if (this.mMinValue != minValue) {
            if (minValue < 0) {
                throw new IllegalArgumentException("minValue must be >= 0");
            }
            this.mMinValue = minValue;
            if (this.mMinValue > this.mValue) {
                this.mValue = this.mMinValue;
            }
            setWrapSelectorWheel(this.mMaxValue - this.mMinValue > this.mSelectorIndices.length);
            initializeSelectorWheelIndices();
            updateInputTextView();
            tryComputeMaxWidth();
            invalidate();
        }
    }

    public int getMaxValue() {
        return this.mMaxValue;
    }

    public void setMaxValue(int maxValue) {
        if (this.mMaxValue != maxValue) {
            if (maxValue < 0) {
                throw new IllegalArgumentException("maxValue must be >= 0");
            }
            this.mMaxValue = maxValue;
            if (this.mMaxValue < this.mValue) {
                this.mValue = this.mMaxValue;
            }
            setWrapSelectorWheel(this.mMaxValue - this.mMinValue > this.mSelectorIndices.length);
            initializeSelectorWheelIndices();
            updateInputTextView();
            tryComputeMaxWidth();
            invalidate();
        }
    }

    public String[] getDisplayedValues() {
        return this.mDisplayedValues;
    }

    public void setDisplayedValues(String[] displayedValues) {
        if (this.mDisplayedValues != displayedValues) {
            this.mDisplayedValues = displayedValues;
            if (this.mDisplayedValues != null) {
                this.mInputText.setRawInputType(ConnectivityManager.CALLBACK_PRECHECK);
            } else {
                this.mInputText.setRawInputType(UNSCALED_DEFAULT_SELECTION_DIVIDER_HEIGHT);
            }
            updateInputTextView();
            initializeSelectorWheelIndices();
            tryComputeMaxWidth();
        }
    }

    protected float getTopFadingEdgeStrength() {
        return TOP_AND_BOTTOM_FADING_EDGE_STRENGTH;
    }

    protected float getBottomFadingEdgeStrength() {
        return TOP_AND_BOTTOM_FADING_EDGE_STRENGTH;
    }

    protected void onDetachedFromWindow() {
        super.onDetachedFromWindow();
        removeAllCallbacks();
    }

    protected void onDraw(Canvas canvas) {
        if (this.mHasSelectorWheel) {
            boolean showSelectorWheel = this.mHideWheelUntilFocused ? hasFocus() : true;
            float x = (float) ((this.mRight - this.mLeft) / UNSCALED_DEFAULT_SELECTION_DIVIDER_HEIGHT);
            float y = (float) this.mCurrentScrollOffset;
            if (showSelectorWheel && this.mVirtualButtonPressedDrawable != null && this.mScrollState == 0) {
                if (this.mDecrementVirtualButtonPressed) {
                    this.mVirtualButtonPressedDrawable.setState(PRESSED_STATE_SET);
                    this.mVirtualButtonPressedDrawable.setBounds(0, 0, this.mRight, this.mTopSelectionDividerTop);
                    this.mVirtualButtonPressedDrawable.draw(canvas);
                }
                if (this.mIncrementVirtualButtonPressed) {
                    this.mVirtualButtonPressedDrawable.setState(PRESSED_STATE_SET);
                    this.mVirtualButtonPressedDrawable.setBounds(0, this.mBottomSelectionDividerBottom, this.mRight, this.mBottom);
                    this.mVirtualButtonPressedDrawable.draw(canvas);
                }
            }
            int[] selectorIndices = this.mSelectorIndices;
            int i = 0;
            while (i < selectorIndices.length) {
                String scrollSelectorValue = (String) this.mSelectorIndexToStringCache.get(selectorIndices[i]);
                if ((showSelectorWheel && i != SELECTOR_MIDDLE_ITEM_INDEX) || (i == SELECTOR_MIDDLE_ITEM_INDEX && this.mInputText.getVisibility() != 0)) {
                    canvas.drawText(scrollSelectorValue, x, y, this.mSelectorWheelPaint);
                }
                y += (float) this.mSelectorElementHeight;
                i += SELECTOR_MIDDLE_ITEM_INDEX;
            }
            if (showSelectorWheel && this.mSelectionDivider != null) {
                int topOfTopDivider = this.mTopSelectionDividerTop;
                this.mSelectionDivider.setBounds(0, topOfTopDivider, this.mRight, topOfTopDivider + this.mSelectionDividerHeight);
                this.mSelectionDivider.draw(canvas);
                int bottomOfBottomDivider = this.mBottomSelectionDividerBottom;
                this.mSelectionDivider.setBounds(0, bottomOfBottomDivider - this.mSelectionDividerHeight, this.mRight, bottomOfBottomDivider);
                this.mSelectionDivider.draw(canvas);
                return;
            }
            return;
        }
        super.onDraw(canvas);
    }

    public void onInitializeAccessibilityEvent(AccessibilityEvent event) {
        super.onInitializeAccessibilityEvent(event);
        event.setClassName(NumberPicker.class.getName());
        event.setScrollable(true);
        event.setScrollY((this.mMinValue + this.mValue) * this.mSelectorElementHeight);
        event.setMaxScrollY((this.mMaxValue - this.mMinValue) * this.mSelectorElementHeight);
    }

    public AccessibilityNodeProvider getAccessibilityNodeProvider() {
        if (!this.mHasSelectorWheel) {
            return super.getAccessibilityNodeProvider();
        }
        if (this.mAccessibilityNodeProvider == null) {
            this.mAccessibilityNodeProvider = new AccessibilityNodeProviderImpl();
        }
        return this.mAccessibilityNodeProvider;
    }

    private int makeMeasureSpec(int measureSpec, int maxSize) {
        if (maxSize == SIZE_UNSPECIFIED) {
            return measureSpec;
        }
        int size = MeasureSpec.getSize(measureSpec);
        int mode = MeasureSpec.getMode(measureSpec);
        switch (mode) {
            case RtlSpacingHelper.UNDEFINED /*-2147483648*/:
                return MeasureSpec.makeMeasureSpec(Math.min(size, maxSize), EditorInfo.IME_FLAG_NO_ENTER_ACTION);
            case Toast.LENGTH_SHORT /*0*/:
                return MeasureSpec.makeMeasureSpec(maxSize, EditorInfo.IME_FLAG_NO_ENTER_ACTION);
            case EditorInfo.IME_FLAG_NO_ENTER_ACTION /*1073741824*/:
                return measureSpec;
            default:
                throw new IllegalArgumentException("Unknown measure mode: " + mode);
        }
    }

    private int resolveSizeAndStateRespectingMinSize(int minSize, int measuredSize, int measureSpec) {
        if (minSize != SIZE_UNSPECIFIED) {
            return View.resolveSizeAndState(Math.max(minSize, measuredSize), measureSpec, 0);
        }
        return measuredSize;
    }

    private void initializeSelectorWheelIndices() {
        this.mSelectorIndexToStringCache.clear();
        int[] selectorIndices = this.mSelectorIndices;
        int current = getValue();
        for (int i = 0; i < this.mSelectorIndices.length; i += SELECTOR_MIDDLE_ITEM_INDEX) {
            int selectorIndex = current + (i + SIZE_UNSPECIFIED);
            if (this.mWrapSelectorWheel) {
                selectorIndex = getWrappedSelectorIndex(selectorIndex);
            }
            selectorIndices[i] = selectorIndex;
            ensureCachedScrollSelectorValue(selectorIndices[i]);
        }
    }

    private void setValueInternal(int current, boolean notifyChange) {
        if (this.mValue != current) {
            if (this.mWrapSelectorWheel) {
                current = getWrappedSelectorIndex(current);
            } else {
                current = Math.min(Math.max(current, this.mMinValue), this.mMaxValue);
            }
            int previous = this.mValue;
            this.mValue = current;
            updateInputTextView();
            if (notifyChange) {
                notifyChange(previous, current);
            }
            initializeSelectorWheelIndices();
            invalidate();
        }
    }

    private void changeValueByOne(boolean increment) {
        if (this.mHasSelectorWheel) {
            this.mInputText.setVisibility(4);
            if (!moveToFinalScrollerPosition(this.mFlingScroller)) {
                moveToFinalScrollerPosition(this.mAdjustScroller);
            }
            this.mPreviousScrollerY = 0;
            if (increment) {
                this.mFlingScroller.startScroll(0, 0, 0, -this.mSelectorElementHeight, SNAP_SCROLL_DURATION);
            } else {
                this.mFlingScroller.startScroll(0, 0, 0, this.mSelectorElementHeight, SNAP_SCROLL_DURATION);
            }
            invalidate();
        } else if (increment) {
            setValueInternal(this.mValue + SELECTOR_MIDDLE_ITEM_INDEX, true);
        } else {
            setValueInternal(this.mValue + SIZE_UNSPECIFIED, true);
        }
    }

    private void initializeSelectorWheel() {
        initializeSelectorWheelIndices();
        int[] selectorIndices = this.mSelectorIndices;
        this.mSelectorTextGapHeight = (int) ((((float) ((this.mBottom - this.mTop) - (selectorIndices.length * this.mTextSize))) / ((float) selectorIndices.length)) + 0.5f);
        this.mSelectorElementHeight = this.mTextSize + this.mSelectorTextGapHeight;
        this.mInitialScrollOffset = (this.mInputText.getBaseline() + this.mInputText.getTop()) - (this.mSelectorElementHeight * SELECTOR_MIDDLE_ITEM_INDEX);
        this.mCurrentScrollOffset = this.mInitialScrollOffset;
        updateInputTextView();
    }

    private void initializeFadingEdges() {
        setVerticalFadingEdgeEnabled(true);
        setFadingEdgeLength(((this.mBottom - this.mTop) - this.mTextSize) / UNSCALED_DEFAULT_SELECTION_DIVIDER_HEIGHT);
    }

    private void onScrollerFinished(Scroller scroller) {
        if (scroller == this.mFlingScroller) {
            if (!ensureScrollWheelAdjusted()) {
                updateInputTextView();
            }
            onScrollStateChange(0);
        } else if (this.mScrollState != SELECTOR_MIDDLE_ITEM_INDEX) {
            updateInputTextView();
        }
    }

    private void onScrollStateChange(int scrollState) {
        if (this.mScrollState != scrollState) {
            this.mScrollState = scrollState;
            if (this.mOnScrollListener != null) {
                this.mOnScrollListener.onScrollStateChange(this, scrollState);
            }
        }
    }

    private void fling(int velocityY) {
        this.mPreviousScrollerY = 0;
        if (velocityY > 0) {
            this.mFlingScroller.fling(0, 0, 0, velocityY, 0, 0, 0, ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED);
        } else {
            this.mFlingScroller.fling(0, ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED, 0, velocityY, 0, 0, 0, ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED);
        }
        invalidate();
    }

    private int getWrappedSelectorIndex(int selectorIndex) {
        if (selectorIndex > this.mMaxValue) {
            return (this.mMinValue + ((selectorIndex - this.mMaxValue) % (this.mMaxValue - this.mMinValue))) + SIZE_UNSPECIFIED;
        }
        if (selectorIndex < this.mMinValue) {
            return (this.mMaxValue - ((this.mMinValue - selectorIndex) % (this.mMaxValue - this.mMinValue))) + SELECTOR_MIDDLE_ITEM_INDEX;
        }
        return selectorIndex;
    }

    private void incrementSelectorIndices(int[] selectorIndices) {
        for (int i = 0; i < selectorIndices.length + SIZE_UNSPECIFIED; i += SELECTOR_MIDDLE_ITEM_INDEX) {
            selectorIndices[i] = selectorIndices[i + SELECTOR_MIDDLE_ITEM_INDEX];
        }
        int nextScrollSelectorIndex = selectorIndices[selectorIndices.length - 2] + SELECTOR_MIDDLE_ITEM_INDEX;
        if (this.mWrapSelectorWheel && nextScrollSelectorIndex > this.mMaxValue) {
            nextScrollSelectorIndex = this.mMinValue;
        }
        selectorIndices[selectorIndices.length + SIZE_UNSPECIFIED] = nextScrollSelectorIndex;
        ensureCachedScrollSelectorValue(nextScrollSelectorIndex);
    }

    private void decrementSelectorIndices(int[] selectorIndices) {
        for (int i = selectorIndices.length + SIZE_UNSPECIFIED; i > 0; i += SIZE_UNSPECIFIED) {
            selectorIndices[i] = selectorIndices[i + SIZE_UNSPECIFIED];
        }
        int nextScrollSelectorIndex = selectorIndices[SELECTOR_MIDDLE_ITEM_INDEX] + SIZE_UNSPECIFIED;
        if (this.mWrapSelectorWheel && nextScrollSelectorIndex < this.mMinValue) {
            nextScrollSelectorIndex = this.mMaxValue;
        }
        selectorIndices[0] = nextScrollSelectorIndex;
        ensureCachedScrollSelectorValue(nextScrollSelectorIndex);
    }

    private void ensureCachedScrollSelectorValue(int selectorIndex) {
        SparseArray<String> cache = this.mSelectorIndexToStringCache;
        if (((String) cache.get(selectorIndex)) == null) {
            String scrollSelectorValue;
            if (selectorIndex < this.mMinValue || selectorIndex > this.mMaxValue) {
                scrollSelectorValue = ProxyInfo.LOCAL_EXCL_LIST;
            } else if (this.mDisplayedValues != null) {
                scrollSelectorValue = this.mDisplayedValues[selectorIndex - this.mMinValue];
            } else {
                scrollSelectorValue = formatNumber(selectorIndex);
            }
            cache.put(selectorIndex, scrollSelectorValue);
        }
    }

    private String formatNumber(int value) {
        return this.mFormatter != null ? this.mFormatter.format(value) : formatNumberWithLocale(value);
    }

    private void validateInputTextView(View v) {
        String str = String.valueOf(((TextView) v).getText());
        if (TextUtils.isEmpty(str)) {
            updateInputTextView();
        } else {
            setValueInternal(getSelectedPos(str.toString()), true);
        }
    }

    private boolean updateInputTextView() {
        String text = this.mDisplayedValues == null ? formatNumber(this.mValue) : this.mDisplayedValues[this.mValue - this.mMinValue];
        if (TextUtils.isEmpty(text) || text.equals(this.mInputText.getText().toString())) {
            return false;
        }
        this.mInputText.setText((CharSequence) text);
        return true;
    }

    private void notifyChange(int previous, int current) {
        if (this.mOnValueChangeListener != null) {
            this.mOnValueChangeListener.onValueChange(this, previous, this.mValue);
        }
    }

    private void postChangeCurrentByOneFromLongPress(boolean increment, long delayMillis) {
        if (this.mChangeCurrentByOneFromLongPressCommand == null) {
            this.mChangeCurrentByOneFromLongPressCommand = new ChangeCurrentByOneFromLongPressCommand();
        } else {
            removeCallbacks(this.mChangeCurrentByOneFromLongPressCommand);
        }
        this.mChangeCurrentByOneFromLongPressCommand.setStep(increment);
        postDelayed(this.mChangeCurrentByOneFromLongPressCommand, delayMillis);
    }

    private void removeChangeCurrentByOneFromLongPress() {
        if (this.mChangeCurrentByOneFromLongPressCommand != null) {
            removeCallbacks(this.mChangeCurrentByOneFromLongPressCommand);
        }
    }

    private void postBeginSoftInputOnLongPressCommand() {
        if (this.mBeginSoftInputOnLongPressCommand == null) {
            this.mBeginSoftInputOnLongPressCommand = new BeginSoftInputOnLongPressCommand();
        } else {
            removeCallbacks(this.mBeginSoftInputOnLongPressCommand);
        }
        postDelayed(this.mBeginSoftInputOnLongPressCommand, (long) ViewConfiguration.getLongPressTimeout());
    }

    private void removeBeginSoftInputCommand() {
        if (this.mBeginSoftInputOnLongPressCommand != null) {
            removeCallbacks(this.mBeginSoftInputOnLongPressCommand);
        }
    }

    private void removeAllCallbacks() {
        if (this.mChangeCurrentByOneFromLongPressCommand != null) {
            removeCallbacks(this.mChangeCurrentByOneFromLongPressCommand);
        }
        if (this.mSetSelectionCommand != null) {
            removeCallbacks(this.mSetSelectionCommand);
        }
        if (this.mBeginSoftInputOnLongPressCommand != null) {
            removeCallbacks(this.mBeginSoftInputOnLongPressCommand);
        }
        this.mPressedStateHelper.cancel();
    }

    private int getSelectedPos(String value) {
        if (this.mDisplayedValues == null) {
            try {
                return Integer.parseInt(value);
            } catch (NumberFormatException e) {
                return this.mMinValue;
            }
        }
        for (int i = 0; i < this.mDisplayedValues.length; i += SELECTOR_MIDDLE_ITEM_INDEX) {
            value = value.toLowerCase();
            if (this.mDisplayedValues[i].toLowerCase().startsWith(value)) {
                return this.mMinValue + i;
            }
        }
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e2) {
            return this.mMinValue;
        }
    }

    private void postSetSelectionCommand(int selectionStart, int selectionEnd) {
        if (this.mSetSelectionCommand == null) {
            this.mSetSelectionCommand = new SetSelectionCommand();
        } else {
            removeCallbacks(this.mSetSelectionCommand);
        }
        this.mSetSelectionCommand.mSelectionStart = selectionStart;
        this.mSetSelectionCommand.mSelectionEnd = selectionEnd;
        post(this.mSetSelectionCommand);
    }

    private boolean ensureScrollWheelAdjusted() {
        int deltaY = this.mInitialScrollOffset - this.mCurrentScrollOffset;
        if (deltaY == 0) {
            return false;
        }
        this.mPreviousScrollerY = 0;
        if (Math.abs(deltaY) > this.mSelectorElementHeight / UNSCALED_DEFAULT_SELECTION_DIVIDER_HEIGHT) {
            deltaY += deltaY > 0 ? -this.mSelectorElementHeight : this.mSelectorElementHeight;
        }
        this.mAdjustScroller.startScroll(0, 0, 0, deltaY, SELECTOR_ADJUSTMENT_DURATION_MILLIS);
        invalidate();
        return true;
    }

    private static String formatNumberWithLocale(int value) {
        Object[] objArr = new Object[SELECTOR_MIDDLE_ITEM_INDEX];
        objArr[0] = Integer.valueOf(value);
        return String.format(Locale.getDefault(), "%d", objArr);
    }
}
