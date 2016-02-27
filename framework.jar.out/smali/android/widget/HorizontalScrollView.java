package android.widget;

import android.C0000R;
import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Rect;
import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.util.AttributeSet;
import android.util.Log;
import android.view.FocusFinder;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.VelocityTracker;
import android.view.View;
import android.view.View.BaseSavedState;
import android.view.View.MeasureSpec;
import android.view.ViewConfiguration;
import android.view.ViewDebug.ExportedProperty;
import android.view.ViewGroup;
import android.view.ViewGroup.MarginLayoutParams;
import android.view.ViewParent;
import android.view.WindowManager.LayoutParams;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.animation.AnimationUtils;
import android.view.inputmethod.EditorInfo;
import java.util.List;

public class HorizontalScrollView extends FrameLayout {
    private static final int ANIMATED_SCROLL_GAP = 250;
    private static final int INVALID_POINTER = -1;
    private static final float MAX_SCROLL_FACTOR = 0.5f;
    private static final String TAG = "HorizontalScrollView";
    private int mActivePointerId;
    private View mChildToScrollTo;
    private EdgeEffect mEdgeGlowLeft;
    private EdgeEffect mEdgeGlowRight;
    @ExportedProperty(category = "layout")
    private boolean mFillViewport;
    private boolean mIsBeingDragged;
    private boolean mIsLayoutDirty;
    private int mLastMotionX;
    private long mLastScroll;
    private int mMaximumVelocity;
    private int mMinimumVelocity;
    private int mOverflingDistance;
    private int mOverscrollDistance;
    private SavedState mSavedState;
    private OverScroller mScroller;
    private boolean mSmoothScrollingEnabled;
    private final Rect mTempRect;
    private int mTouchSlop;
    private VelocityTracker mVelocityTracker;

    static class SavedState extends BaseSavedState {
        public static final Creator<SavedState> CREATOR;
        public boolean isLayoutRtl;
        public int scrollPosition;

        /* renamed from: android.widget.HorizontalScrollView.SavedState.1 */
        static class C09951 implements Creator<SavedState> {
            C09951() {
            }

            public SavedState createFromParcel(Parcel in) {
                return new SavedState(in);
            }

            public SavedState[] newArray(int size) {
                return new SavedState[size];
            }
        }

        SavedState(Parcelable superState) {
            super(superState);
        }

        public SavedState(Parcel source) {
            super(source);
            this.scrollPosition = source.readInt();
            this.isLayoutRtl = source.readInt() == 0;
        }

        public void writeToParcel(Parcel dest, int flags) {
            super.writeToParcel(dest, flags);
            dest.writeInt(this.scrollPosition);
            dest.writeInt(this.isLayoutRtl ? 1 : 0);
        }

        public String toString() {
            return "HorizontalScrollView.SavedState{" + Integer.toHexString(System.identityHashCode(this)) + " scrollPosition=" + this.scrollPosition + " isLayoutRtl=" + this.isLayoutRtl + "}";
        }

        static {
            CREATOR = new C09951();
        }
    }

    public HorizontalScrollView(Context context) {
        this(context, null);
    }

    public HorizontalScrollView(Context context, AttributeSet attrs) {
        this(context, attrs, 16843603);
    }

    public HorizontalScrollView(Context context, AttributeSet attrs, int defStyleAttr) {
        this(context, attrs, defStyleAttr, 0);
    }

    public HorizontalScrollView(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
        this.mTempRect = new Rect();
        this.mIsLayoutDirty = true;
        this.mChildToScrollTo = null;
        this.mIsBeingDragged = false;
        this.mSmoothScrollingEnabled = true;
        this.mActivePointerId = INVALID_POINTER;
        initScrollView();
        TypedArray a = context.obtainStyledAttributes(attrs, C0000R.styleable.HorizontalScrollView, defStyleAttr, defStyleRes);
        setFillViewport(a.getBoolean(0, false));
        a.recycle();
    }

    protected float getLeftFadingEdgeStrength() {
        if (getChildCount() == 0) {
            return 0.0f;
        }
        int length = getHorizontalFadingEdgeLength();
        if (this.mScrollX < length) {
            return ((float) this.mScrollX) / ((float) length);
        }
        return LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
    }

    protected float getRightFadingEdgeStrength() {
        if (getChildCount() == 0) {
            return 0.0f;
        }
        int length = getHorizontalFadingEdgeLength();
        int span = (getChildAt(0).getRight() - this.mScrollX) - (getWidth() - this.mPaddingRight);
        if (span < length) {
            return ((float) span) / ((float) length);
        }
        return LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
    }

    public int getMaxScrollAmount() {
        return (int) (MAX_SCROLL_FACTOR * ((float) (this.mRight - this.mLeft)));
    }

    private void initScrollView() {
        this.mScroller = new OverScroller(getContext());
        setFocusable(true);
        setDescendantFocusability(AccessibilityNodeInfo.ACTION_EXPAND);
        setWillNotDraw(false);
        ViewConfiguration configuration = ViewConfiguration.get(this.mContext);
        this.mTouchSlop = configuration.getScaledTouchSlop();
        this.mMinimumVelocity = configuration.getScaledMinimumFlingVelocity();
        this.mMaximumVelocity = configuration.getScaledMaximumFlingVelocity();
        this.mOverscrollDistance = configuration.getScaledOverscrollDistance();
        this.mOverflingDistance = configuration.getScaledOverflingDistance();
    }

    public void addView(View child) {
        if (getChildCount() > 0) {
            throw new IllegalStateException("HorizontalScrollView can host only one direct child");
        }
        super.addView(child);
    }

    public void addView(View child, int index) {
        if (getChildCount() > 0) {
            throw new IllegalStateException("HorizontalScrollView can host only one direct child");
        }
        super.addView(child, index);
    }

    public void addView(View child, ViewGroup.LayoutParams params) {
        if (getChildCount() > 0) {
            throw new IllegalStateException("HorizontalScrollView can host only one direct child");
        }
        super.addView(child, params);
    }

    public void addView(View child, int index, ViewGroup.LayoutParams params) {
        if (getChildCount() > 0) {
            throw new IllegalStateException("HorizontalScrollView can host only one direct child");
        }
        super.addView(child, index, params);
    }

    private boolean canScroll() {
        View child = getChildAt(0);
        if (child == null) {
            return false;
        }
        if (getWidth() < (this.mPaddingLeft + child.getWidth()) + this.mPaddingRight) {
            return true;
        }
        return false;
    }

    public boolean isFillViewport() {
        return this.mFillViewport;
    }

    public void setFillViewport(boolean fillViewport) {
        if (fillViewport != this.mFillViewport) {
            this.mFillViewport = fillViewport;
            requestLayout();
        }
    }

    public boolean isSmoothScrollingEnabled() {
        return this.mSmoothScrollingEnabled;
    }

    public void setSmoothScrollingEnabled(boolean smoothScrollingEnabled) {
        this.mSmoothScrollingEnabled = smoothScrollingEnabled;
    }

    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        super.onMeasure(widthMeasureSpec, heightMeasureSpec);
        if (this.mFillViewport && MeasureSpec.getMode(widthMeasureSpec) != 0 && getChildCount() > 0) {
            View child = getChildAt(0);
            int width = getMeasuredWidth();
            if (child.getMeasuredWidth() < width) {
                child.measure(MeasureSpec.makeMeasureSpec((width - this.mPaddingLeft) - this.mPaddingRight, EditorInfo.IME_FLAG_NO_ENTER_ACTION), ViewGroup.getChildMeasureSpec(heightMeasureSpec, this.mPaddingTop + this.mPaddingBottom, ((FrameLayout.LayoutParams) child.getLayoutParams()).height));
            }
        }
    }

    public boolean dispatchKeyEvent(KeyEvent event) {
        return super.dispatchKeyEvent(event) || executeKeyEvent(event);
    }

    public boolean executeKeyEvent(KeyEvent event) {
        this.mTempRect.setEmpty();
        if (canScroll()) {
            boolean handled = false;
            if (event.getAction() == 0) {
                switch (event.getKeyCode()) {
                    case RelativeLayout.ALIGN_PARENT_END /*21*/:
                        if (!event.isAltPressed()) {
                            handled = arrowScroll(17);
                            break;
                        }
                        handled = fullScroll(17);
                        break;
                    case MotionEvent.AXIS_GAS /*22*/:
                        if (!event.isAltPressed()) {
                            handled = arrowScroll(66);
                            break;
                        }
                        handled = fullScroll(66);
                        break;
                    case KeyEvent.KEYCODE_SPACE /*62*/:
                        pageScroll(event.isShiftPressed() ? 17 : 66);
                        break;
                }
            }
            return handled;
        } else if (!isFocused()) {
            return false;
        } else {
            View currentFocused = findFocus();
            if (currentFocused == this) {
                currentFocused = null;
            }
            View nextFocused = FocusFinder.getInstance().findNextFocus(this, currentFocused, 66);
            if (nextFocused == null || nextFocused == this || !nextFocused.requestFocus(66)) {
                return false;
            }
            return true;
        }
    }

    private boolean inChild(int x, int y) {
        if (getChildCount() <= 0) {
            return false;
        }
        int scrollX = this.mScrollX;
        View child = getChildAt(0);
        if (y < child.getTop() || y >= child.getBottom() || x < child.getLeft() - scrollX || x >= child.getRight() - scrollX) {
            return false;
        }
        return true;
    }

    private void initOrResetVelocityTracker() {
        if (this.mVelocityTracker == null) {
            this.mVelocityTracker = VelocityTracker.obtain();
        } else {
            this.mVelocityTracker.clear();
        }
    }

    private void initVelocityTrackerIfNotExists() {
        if (this.mVelocityTracker == null) {
            this.mVelocityTracker = VelocityTracker.obtain();
        }
    }

    private void recycleVelocityTracker() {
        if (this.mVelocityTracker != null) {
            this.mVelocityTracker.recycle();
            this.mVelocityTracker = null;
        }
    }

    public void requestDisallowInterceptTouchEvent(boolean disallowIntercept) {
        if (disallowIntercept) {
            recycleVelocityTracker();
        }
        super.requestDisallowInterceptTouchEvent(disallowIntercept);
    }

    public boolean onInterceptTouchEvent(MotionEvent ev) {
        boolean z = false;
        int action = ev.getAction();
        if (action == 2 && this.mIsBeingDragged) {
            return true;
        }
        int x;
        switch (action & EditorInfo.IME_MASK_ACTION) {
            case Toast.LENGTH_SHORT /*0*/:
                x = (int) ev.getX();
                if (!inChild(x, (int) ev.getY())) {
                    this.mIsBeingDragged = false;
                    recycleVelocityTracker();
                    break;
                }
                this.mLastMotionX = x;
                this.mActivePointerId = ev.getPointerId(0);
                initOrResetVelocityTracker();
                this.mVelocityTracker.addMovement(ev);
                if (!this.mScroller.isFinished()) {
                    z = true;
                }
                this.mIsBeingDragged = z;
                break;
            case Toast.LENGTH_LONG /*1*/:
            case SetDrawableParameters.TAG /*3*/:
                this.mIsBeingDragged = false;
                this.mActivePointerId = INVALID_POINTER;
                if (this.mScroller.springBack(this.mScrollX, this.mScrollY, 0, getScrollRange(), 0, 0)) {
                    postInvalidateOnAnimation();
                    break;
                }
                break;
            case Action.MERGE_IGNORE /*2*/:
                int activePointerId = this.mActivePointerId;
                if (activePointerId != INVALID_POINTER) {
                    int pointerIndex = ev.findPointerIndex(activePointerId);
                    if (pointerIndex != INVALID_POINTER) {
                        x = (int) ev.getX(pointerIndex);
                        if (Math.abs(x - this.mLastMotionX) > this.mTouchSlop) {
                            this.mIsBeingDragged = true;
                            this.mLastMotionX = x;
                            initVelocityTrackerIfNotExists();
                            this.mVelocityTracker.addMovement(ev);
                            if (this.mParent != null) {
                                this.mParent.requestDisallowInterceptTouchEvent(true);
                                break;
                            }
                        }
                    }
                    Log.e(TAG, "Invalid pointerId=" + activePointerId + " in onInterceptTouchEvent");
                    break;
                }
                break;
            case ReflectionActionWithoutParams.TAG /*5*/:
                int index = ev.getActionIndex();
                this.mLastMotionX = (int) ev.getX(index);
                this.mActivePointerId = ev.getPointerId(index);
                break;
            case SetEmptyView.TAG /*6*/:
                onSecondaryPointerUp(ev);
                this.mLastMotionX = (int) ev.getX(ev.findPointerIndex(this.mActivePointerId));
                break;
        }
        return this.mIsBeingDragged;
    }

    public boolean onTouchEvent(MotionEvent ev) {
        initVelocityTrackerIfNotExists();
        this.mVelocityTracker.addMovement(ev);
        ViewParent parent;
        switch (ev.getAction() & EditorInfo.IME_MASK_ACTION) {
            case Toast.LENGTH_SHORT /*0*/:
                if (getChildCount() != 0) {
                    boolean z = !this.mScroller.isFinished();
                    this.mIsBeingDragged = z;
                    if (z) {
                        parent = getParent();
                        if (parent != null) {
                            parent.requestDisallowInterceptTouchEvent(true);
                        }
                    }
                    if (!this.mScroller.isFinished()) {
                        this.mScroller.abortAnimation();
                    }
                    this.mLastMotionX = (int) ev.getX();
                    this.mActivePointerId = ev.getPointerId(0);
                    break;
                }
                return false;
            case Toast.LENGTH_LONG /*1*/:
                if (this.mIsBeingDragged) {
                    VelocityTracker velocityTracker = this.mVelocityTracker;
                    velocityTracker.computeCurrentVelocity(LayoutParams.TYPE_APPLICATION_PANEL, (float) this.mMaximumVelocity);
                    int initialVelocity = (int) velocityTracker.getXVelocity(this.mActivePointerId);
                    if (getChildCount() > 0) {
                        if (Math.abs(initialVelocity) > this.mMinimumVelocity) {
                            fling(-initialVelocity);
                        } else if (this.mScroller.springBack(this.mScrollX, this.mScrollY, 0, getScrollRange(), 0, 0)) {
                            postInvalidateOnAnimation();
                        }
                    }
                    this.mActivePointerId = INVALID_POINTER;
                    this.mIsBeingDragged = false;
                    recycleVelocityTracker();
                    if (this.mEdgeGlowLeft != null) {
                        this.mEdgeGlowLeft.onRelease();
                        this.mEdgeGlowRight.onRelease();
                        break;
                    }
                }
                break;
            case Action.MERGE_IGNORE /*2*/:
                int activePointerIndex = ev.findPointerIndex(this.mActivePointerId);
                if (activePointerIndex != INVALID_POINTER) {
                    int x = (int) ev.getX(activePointerIndex);
                    int deltaX = this.mLastMotionX - x;
                    if (!this.mIsBeingDragged && Math.abs(deltaX) > this.mTouchSlop) {
                        parent = getParent();
                        if (parent != null) {
                            parent.requestDisallowInterceptTouchEvent(true);
                        }
                        this.mIsBeingDragged = true;
                        deltaX = deltaX > 0 ? deltaX - this.mTouchSlop : deltaX + this.mTouchSlop;
                    }
                    if (this.mIsBeingDragged) {
                        this.mLastMotionX = x;
                        int oldX = this.mScrollX;
                        int oldY = this.mScrollY;
                        int range = getScrollRange();
                        int overscrollMode = getOverScrollMode();
                        boolean canOverscroll = overscrollMode == 0 || (overscrollMode == 1 && range > 0);
                        if (overScrollBy(deltaX, 0, this.mScrollX, 0, range, 0, this.mOverscrollDistance, 0, true)) {
                            this.mVelocityTracker.clear();
                        }
                        if (canOverscroll) {
                            int pulledToX = oldX + deltaX;
                            if (pulledToX < 0) {
                                this.mEdgeGlowLeft.onPull(((float) deltaX) / ((float) getWidth()), LayoutParams.BRIGHTNESS_OVERRIDE_FULL - (ev.getY(activePointerIndex) / ((float) getHeight())));
                                if (!this.mEdgeGlowRight.isFinished()) {
                                    this.mEdgeGlowRight.onRelease();
                                }
                            } else if (pulledToX > range) {
                                this.mEdgeGlowRight.onPull(((float) deltaX) / ((float) getWidth()), ev.getY(activePointerIndex) / ((float) getHeight()));
                                if (!this.mEdgeGlowLeft.isFinished()) {
                                    this.mEdgeGlowLeft.onRelease();
                                }
                            }
                            if (!(this.mEdgeGlowLeft == null || (this.mEdgeGlowLeft.isFinished() && this.mEdgeGlowRight.isFinished()))) {
                                postInvalidateOnAnimation();
                                break;
                            }
                        }
                    }
                }
                Log.e(TAG, "Invalid pointerId=" + this.mActivePointerId + " in onTouchEvent");
                break;
                break;
            case SetDrawableParameters.TAG /*3*/:
                if (this.mIsBeingDragged && getChildCount() > 0) {
                    if (this.mScroller.springBack(this.mScrollX, this.mScrollY, 0, getScrollRange(), 0, 0)) {
                        postInvalidateOnAnimation();
                    }
                    this.mActivePointerId = INVALID_POINTER;
                    this.mIsBeingDragged = false;
                    recycleVelocityTracker();
                    if (this.mEdgeGlowLeft != null) {
                        this.mEdgeGlowLeft.onRelease();
                        this.mEdgeGlowRight.onRelease();
                        break;
                    }
                }
                break;
            case SetEmptyView.TAG /*6*/:
                onSecondaryPointerUp(ev);
                break;
        }
        return true;
    }

    private void onSecondaryPointerUp(MotionEvent ev) {
        int pointerIndex = (ev.getAction() & MotionEvent.ACTION_POINTER_INDEX_MASK) >> 8;
        if (ev.getPointerId(pointerIndex) == this.mActivePointerId) {
            int newPointerIndex = pointerIndex == 0 ? 1 : 0;
            this.mLastMotionX = (int) ev.getX(newPointerIndex);
            this.mActivePointerId = ev.getPointerId(newPointerIndex);
            if (this.mVelocityTracker != null) {
                this.mVelocityTracker.clear();
            }
        }
    }

    public boolean onGenericMotionEvent(MotionEvent event) {
        if ((event.getSource() & 2) != 0) {
            switch (event.getAction()) {
                case SetPendingIntentTemplate.TAG /*8*/:
                    if (!this.mIsBeingDragged) {
                        float hscroll;
                        if ((event.getMetaState() & 1) != 0) {
                            hscroll = -event.getAxisValue(9);
                        } else {
                            hscroll = event.getAxisValue(10);
                        }
                        if (hscroll != 0.0f) {
                            int delta = (int) (getHorizontalScrollFactor() * hscroll);
                            int range = getScrollRange();
                            int oldScrollX = this.mScrollX;
                            int newScrollX = oldScrollX + delta;
                            if (newScrollX < 0) {
                                newScrollX = 0;
                            } else if (newScrollX > range) {
                                newScrollX = range;
                            }
                            if (newScrollX != oldScrollX) {
                                super.scrollTo(newScrollX, this.mScrollY);
                                return true;
                            }
                        }
                    }
                    break;
            }
        }
        return super.onGenericMotionEvent(event);
    }

    public boolean shouldDelayChildPressedState() {
        return true;
    }

    protected void onOverScrolled(int scrollX, int scrollY, boolean clampedX, boolean clampedY) {
        if (this.mScroller.isFinished()) {
            super.scrollTo(scrollX, scrollY);
        } else {
            int oldX = this.mScrollX;
            int oldY = this.mScrollY;
            this.mScrollX = scrollX;
            this.mScrollY = scrollY;
            invalidateParentIfNeeded();
            onScrollChanged(this.mScrollX, this.mScrollY, oldX, oldY);
            if (clampedX) {
                this.mScroller.springBack(this.mScrollX, this.mScrollY, 0, getScrollRange(), 0, 0);
            }
        }
        awakenScrollBars();
    }

    public boolean performAccessibilityAction(int action, Bundle arguments) {
        if (super.performAccessibilityAction(action, arguments)) {
            return true;
        }
        int targetScrollX;
        switch (action) {
            case AccessibilityNodeInfo.ACTION_SCROLL_FORWARD /*4096*/:
                if (!isEnabled()) {
                    return false;
                }
                targetScrollX = Math.min(this.mScrollX + ((getWidth() - this.mPaddingLeft) - this.mPaddingRight), getScrollRange());
                if (targetScrollX == this.mScrollX) {
                    return false;
                }
                smoothScrollTo(targetScrollX, 0);
                return true;
            case AccessibilityNodeInfo.ACTION_SCROLL_BACKWARD /*8192*/:
                if (!isEnabled()) {
                    return false;
                }
                targetScrollX = Math.max(0, this.mScrollX - ((getWidth() - this.mPaddingLeft) - this.mPaddingRight));
                if (targetScrollX == this.mScrollX) {
                    return false;
                }
                smoothScrollTo(targetScrollX, 0);
                return true;
            default:
                return false;
        }
    }

    public void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo info) {
        super.onInitializeAccessibilityNodeInfo(info);
        info.setClassName(HorizontalScrollView.class.getName());
        int scrollRange = getScrollRange();
        if (scrollRange > 0) {
            info.setScrollable(true);
            if (isEnabled() && this.mScrollX > 0) {
                info.addAction((int) AccessibilityNodeInfo.ACTION_SCROLL_BACKWARD);
            }
            if (isEnabled() && this.mScrollX < scrollRange) {
                info.addAction((int) AccessibilityNodeInfo.ACTION_SCROLL_FORWARD);
            }
        }
    }

    public void onInitializeAccessibilityEvent(AccessibilityEvent event) {
        super.onInitializeAccessibilityEvent(event);
        event.setClassName(HorizontalScrollView.class.getName());
        event.setScrollable(getScrollRange() > 0);
        event.setScrollX(this.mScrollX);
        event.setScrollY(this.mScrollY);
        event.setMaxScrollX(getScrollRange());
        event.setMaxScrollY(this.mScrollY);
    }

    private int getScrollRange() {
        if (getChildCount() > 0) {
            return Math.max(0, getChildAt(0).getWidth() - ((getWidth() - this.mPaddingLeft) - this.mPaddingRight));
        }
        return 0;
    }

    private View findFocusableViewInMyBounds(boolean leftFocus, int left, View preferredFocusable) {
        int fadingEdgeLength = getHorizontalFadingEdgeLength() / 2;
        int leftWithoutFadingEdge = left + fadingEdgeLength;
        int rightWithoutFadingEdge = (getWidth() + left) - fadingEdgeLength;
        return (preferredFocusable == null || preferredFocusable.getLeft() >= rightWithoutFadingEdge || preferredFocusable.getRight() <= leftWithoutFadingEdge) ? findFocusableViewInBounds(leftFocus, leftWithoutFadingEdge, rightWithoutFadingEdge) : preferredFocusable;
    }

    private View findFocusableViewInBounds(boolean leftFocus, int left, int right) {
        List<View> focusables = getFocusables(2);
        View focusCandidate = null;
        boolean foundFullyContainedFocusable = false;
        int count = focusables.size();
        for (int i = 0; i < count; i++) {
            View view = (View) focusables.get(i);
            int viewLeft = view.getLeft();
            int viewRight = view.getRight();
            if (left < viewRight && viewLeft < right) {
                boolean viewIsFullyContained = left < viewLeft && viewRight < right;
                if (focusCandidate == null) {
                    focusCandidate = view;
                    foundFullyContainedFocusable = viewIsFullyContained;
                } else {
                    boolean viewIsCloserToBoundary = (leftFocus && viewLeft < focusCandidate.getLeft()) || (!leftFocus && viewRight > focusCandidate.getRight());
                    if (foundFullyContainedFocusable) {
                        if (viewIsFullyContained && viewIsCloserToBoundary) {
                            focusCandidate = view;
                        }
                    } else if (viewIsFullyContained) {
                        focusCandidate = view;
                        foundFullyContainedFocusable = true;
                    } else if (viewIsCloserToBoundary) {
                        focusCandidate = view;
                    }
                }
            }
        }
        return focusCandidate;
    }

    public boolean pageScroll(int direction) {
        boolean right;
        if (direction == 66) {
            right = true;
        } else {
            right = false;
        }
        int width = getWidth();
        if (right) {
            this.mTempRect.left = getScrollX() + width;
            if (getChildCount() > 0) {
                View view = getChildAt(0);
                if (this.mTempRect.left + width > view.getRight()) {
                    this.mTempRect.left = view.getRight() - width;
                }
            }
        } else {
            this.mTempRect.left = getScrollX() - width;
            if (this.mTempRect.left < 0) {
                this.mTempRect.left = 0;
            }
        }
        this.mTempRect.right = this.mTempRect.left + width;
        return scrollAndFocus(direction, this.mTempRect.left, this.mTempRect.right);
    }

    public boolean fullScroll(int direction) {
        boolean right;
        if (direction == 66) {
            right = true;
        } else {
            right = false;
        }
        int width = getWidth();
        this.mTempRect.left = 0;
        this.mTempRect.right = width;
        if (right && getChildCount() > 0) {
            View view = getChildAt(0);
            this.mTempRect.right = view.getRight();
            this.mTempRect.left = this.mTempRect.right - width;
        }
        return scrollAndFocus(direction, this.mTempRect.left, this.mTempRect.right);
    }

    private boolean scrollAndFocus(int direction, int left, int right) {
        boolean handled = true;
        int width = getWidth();
        int containerLeft = getScrollX();
        int containerRight = containerLeft + width;
        boolean goLeft = direction == 17;
        View newFocused = findFocusableViewInBounds(goLeft, left, right);
        if (newFocused == null) {
            newFocused = this;
        }
        if (left < containerLeft || right > containerRight) {
            doScrollX(goLeft ? left - containerLeft : right - containerRight);
        } else {
            handled = false;
        }
        if (newFocused != findFocus()) {
            newFocused.requestFocus(direction);
        }
        return handled;
    }

    public boolean arrowScroll(int direction) {
        View currentFocused = findFocus();
        if (currentFocused == this) {
            currentFocused = null;
        }
        View nextFocused = FocusFinder.getInstance().findNextFocus(this, currentFocused, direction);
        int maxJump = getMaxScrollAmount();
        if (nextFocused == null || !isWithinDeltaOfScreen(nextFocused, maxJump)) {
            int scrollDelta = maxJump;
            if (direction == 17 && getScrollX() < scrollDelta) {
                scrollDelta = getScrollX();
            } else if (direction == 66 && getChildCount() > 0) {
                int daRight = getChildAt(0).getRight();
                int screenRight = getScrollX() + getWidth();
                if (daRight - screenRight < maxJump) {
                    scrollDelta = daRight - screenRight;
                }
            }
            if (scrollDelta == 0) {
                return false;
            }
            int i;
            if (direction == 66) {
                i = scrollDelta;
            } else {
                i = -scrollDelta;
            }
            doScrollX(i);
        } else {
            nextFocused.getDrawingRect(this.mTempRect);
            offsetDescendantRectToMyCoords(nextFocused, this.mTempRect);
            doScrollX(computeScrollDeltaToGetChildRectOnScreen(this.mTempRect));
            nextFocused.requestFocus(direction);
        }
        if (currentFocused != null && currentFocused.isFocused() && isOffScreen(currentFocused)) {
            int descendantFocusability = getDescendantFocusability();
            setDescendantFocusability(AccessibilityNodeInfo.ACTION_SET_SELECTION);
            requestFocus();
            setDescendantFocusability(descendantFocusability);
        }
        return true;
    }

    private boolean isOffScreen(View descendant) {
        return !isWithinDeltaOfScreen(descendant, 0);
    }

    private boolean isWithinDeltaOfScreen(View descendant, int delta) {
        descendant.getDrawingRect(this.mTempRect);
        offsetDescendantRectToMyCoords(descendant, this.mTempRect);
        return this.mTempRect.right + delta >= getScrollX() && this.mTempRect.left - delta <= getScrollX() + getWidth();
    }

    private void doScrollX(int delta) {
        if (delta == 0) {
            return;
        }
        if (this.mSmoothScrollingEnabled) {
            smoothScrollBy(delta, 0);
        } else {
            scrollBy(delta, 0);
        }
    }

    public final void smoothScrollBy(int dx, int dy) {
        if (getChildCount() != 0) {
            if (AnimationUtils.currentAnimationTimeMillis() - this.mLastScroll > 250) {
                int maxX = Math.max(0, getChildAt(0).getWidth() - ((getWidth() - this.mPaddingRight) - this.mPaddingLeft));
                int scrollX = this.mScrollX;
                this.mScroller.startScroll(scrollX, this.mScrollY, Math.max(0, Math.min(scrollX + dx, maxX)) - scrollX, 0);
                postInvalidateOnAnimation();
            } else {
                if (!this.mScroller.isFinished()) {
                    this.mScroller.abortAnimation();
                }
                scrollBy(dx, dy);
            }
            this.mLastScroll = AnimationUtils.currentAnimationTimeMillis();
        }
    }

    public final void smoothScrollTo(int x, int y) {
        smoothScrollBy(x - this.mScrollX, y - this.mScrollY);
    }

    protected int computeHorizontalScrollRange() {
        int contentWidth = (getWidth() - this.mPaddingLeft) - this.mPaddingRight;
        if (getChildCount() == 0) {
            return contentWidth;
        }
        int scrollRange = getChildAt(0).getRight();
        int scrollX = this.mScrollX;
        int overscrollRight = Math.max(0, scrollRange - contentWidth);
        if (scrollX < 0) {
            scrollRange -= scrollX;
        } else if (scrollX > overscrollRight) {
            scrollRange += scrollX - overscrollRight;
        }
        return scrollRange;
    }

    protected int computeHorizontalScrollOffset() {
        return Math.max(0, super.computeHorizontalScrollOffset());
    }

    protected void measureChild(View child, int parentWidthMeasureSpec, int parentHeightMeasureSpec) {
        child.measure(MeasureSpec.makeMeasureSpec(0, 0), ViewGroup.getChildMeasureSpec(parentHeightMeasureSpec, this.mPaddingTop + this.mPaddingBottom, child.getLayoutParams().height));
    }

    protected void measureChildWithMargins(View child, int parentWidthMeasureSpec, int widthUsed, int parentHeightMeasureSpec, int heightUsed) {
        MarginLayoutParams lp = (MarginLayoutParams) child.getLayoutParams();
        child.measure(MeasureSpec.makeMeasureSpec(lp.leftMargin + lp.rightMargin, 0), ViewGroup.getChildMeasureSpec(parentHeightMeasureSpec, (((this.mPaddingTop + this.mPaddingBottom) + lp.topMargin) + lp.bottomMargin) + heightUsed, lp.height));
    }

    public void computeScroll() {
        boolean canOverscroll = true;
        if (this.mScroller.computeScrollOffset()) {
            int oldX = this.mScrollX;
            int oldY = this.mScrollY;
            int x = this.mScroller.getCurrX();
            int y = this.mScroller.getCurrY();
            if (!(oldX == x && oldY == y)) {
                int range = getScrollRange();
                int overscrollMode = getOverScrollMode();
                if (overscrollMode != 0 && (overscrollMode != 1 || range <= 0)) {
                    canOverscroll = false;
                }
                overScrollBy(x - oldX, y - oldY, oldX, oldY, range, 0, this.mOverflingDistance, 0, false);
                onScrollChanged(this.mScrollX, this.mScrollY, oldX, oldY);
                if (canOverscroll) {
                    if (x < 0 && oldX >= 0) {
                        this.mEdgeGlowLeft.onAbsorb((int) this.mScroller.getCurrVelocity());
                    } else if (x > range && oldX <= range) {
                        this.mEdgeGlowRight.onAbsorb((int) this.mScroller.getCurrVelocity());
                    }
                }
            }
            if (!awakenScrollBars()) {
                postInvalidateOnAnimation();
            }
        }
    }

    private void scrollToChild(View child) {
        child.getDrawingRect(this.mTempRect);
        offsetDescendantRectToMyCoords(child, this.mTempRect);
        int scrollDelta = computeScrollDeltaToGetChildRectOnScreen(this.mTempRect);
        if (scrollDelta != 0) {
            scrollBy(scrollDelta, 0);
        }
    }

    private boolean scrollToChildRect(Rect rect, boolean immediate) {
        boolean scroll;
        int delta = computeScrollDeltaToGetChildRectOnScreen(rect);
        if (delta != 0) {
            scroll = true;
        } else {
            scroll = false;
        }
        if (scroll) {
            if (immediate) {
                scrollBy(delta, 0);
            } else {
                smoothScrollBy(delta, 0);
            }
        }
        return scroll;
    }

    protected int computeScrollDeltaToGetChildRectOnScreen(Rect rect) {
        if (getChildCount() == 0) {
            return 0;
        }
        int width = getWidth();
        int screenLeft = getScrollX();
        int screenRight = screenLeft + width;
        int fadingEdge = getHorizontalFadingEdgeLength();
        if (rect.left > 0) {
            screenLeft += fadingEdge;
        }
        if (rect.right < getChildAt(0).getWidth()) {
            screenRight -= fadingEdge;
        }
        int scrollXDelta;
        if (rect.right > screenRight && rect.left > screenLeft) {
            if (rect.width() > width) {
                scrollXDelta = 0 + (rect.left - screenLeft);
            } else {
                scrollXDelta = 0 + (rect.right - screenRight);
            }
            return Math.min(scrollXDelta, getChildAt(0).getRight() - screenRight);
        } else if (rect.left >= screenLeft || rect.right >= screenRight) {
            return 0;
        } else {
            if (rect.width() > width) {
                scrollXDelta = 0 - (screenRight - rect.right);
            } else {
                scrollXDelta = 0 - (screenLeft - rect.left);
            }
            return Math.max(scrollXDelta, -getScrollX());
        }
    }

    public void requestChildFocus(View child, View focused) {
        if (this.mIsLayoutDirty) {
            this.mChildToScrollTo = focused;
        } else {
            scrollToChild(focused);
        }
        super.requestChildFocus(child, focused);
    }

    protected boolean onRequestFocusInDescendants(int direction, Rect previouslyFocusedRect) {
        if (direction == 2) {
            direction = 66;
        } else if (direction == 1) {
            direction = 17;
        }
        View nextFocus = previouslyFocusedRect == null ? FocusFinder.getInstance().findNextFocus(this, null, direction) : FocusFinder.getInstance().findNextFocusFromRect(this, previouslyFocusedRect, direction);
        if (nextFocus == null || isOffScreen(nextFocus)) {
            return false;
        }
        return nextFocus.requestFocus(direction, previouslyFocusedRect);
    }

    public boolean requestChildRectangleOnScreen(View child, Rect rectangle, boolean immediate) {
        rectangle.offset(child.getLeft() - child.getScrollX(), child.getTop() - child.getScrollY());
        return scrollToChildRect(rectangle, immediate);
    }

    public void requestLayout() {
        this.mIsLayoutDirty = true;
        super.requestLayout();
    }

    protected void onLayout(boolean changed, int l, int t, int r, int b) {
        int childWidth = 0;
        int childMargins = 0;
        if (getChildCount() > 0) {
            childWidth = getChildAt(0).getMeasuredWidth();
            FrameLayout.LayoutParams childParams = (FrameLayout.LayoutParams) getChildAt(0).getLayoutParams();
            childMargins = childParams.leftMargin + childParams.rightMargin;
        }
        layoutChildren(l, t, r, b, childWidth > (((r - l) - getPaddingLeftWithForeground()) - getPaddingRightWithForeground()) - childMargins);
        this.mIsLayoutDirty = false;
        if (this.mChildToScrollTo != null && isViewDescendantOf(this.mChildToScrollTo, this)) {
            scrollToChild(this.mChildToScrollTo);
        }
        this.mChildToScrollTo = null;
        if (!isLaidOut()) {
            int scrollRange = Math.max(0, childWidth - (((r - l) - this.mPaddingLeft) - this.mPaddingRight));
            if (this.mSavedState != null) {
                if (isLayoutRtl() == this.mSavedState.isLayoutRtl) {
                    this.mScrollX = this.mSavedState.scrollPosition;
                } else {
                    this.mScrollX = scrollRange - this.mSavedState.scrollPosition;
                }
                this.mSavedState = null;
            } else if (isLayoutRtl()) {
                this.mScrollX = scrollRange - this.mScrollX;
            }
            if (this.mScrollX > scrollRange) {
                this.mScrollX = scrollRange;
            } else if (this.mScrollX < 0) {
                this.mScrollX = 0;
            }
        }
        scrollTo(this.mScrollX, this.mScrollY);
    }

    protected void onSizeChanged(int w, int h, int oldw, int oldh) {
        super.onSizeChanged(w, h, oldw, oldh);
        View currentFocused = findFocus();
        if (currentFocused != null && this != currentFocused && isWithinDeltaOfScreen(currentFocused, this.mRight - this.mLeft)) {
            currentFocused.getDrawingRect(this.mTempRect);
            offsetDescendantRectToMyCoords(currentFocused, this.mTempRect);
            doScrollX(computeScrollDeltaToGetChildRectOnScreen(this.mTempRect));
        }
    }

    private static boolean isViewDescendantOf(View child, View parent) {
        if (child == parent) {
            return true;
        }
        ViewParent theParent = child.getParent();
        if ((theParent instanceof ViewGroup) && isViewDescendantOf((View) theParent, parent)) {
            return true;
        }
        return false;
    }

    public void fling(int velocityX) {
        if (getChildCount() > 0) {
            int width = (getWidth() - this.mPaddingRight) - this.mPaddingLeft;
            this.mScroller.fling(this.mScrollX, this.mScrollY, velocityX, 0, 0, Math.max(0, getChildAt(0).getWidth() - width), 0, 0, width / 2, 0);
            boolean movingRight = velocityX > 0;
            View currentFocused = findFocus();
            View newFocused = findFocusableViewInMyBounds(movingRight, this.mScroller.getFinalX(), currentFocused);
            if (newFocused == null) {
                newFocused = this;
            }
            if (newFocused != currentFocused) {
                newFocused.requestFocus(movingRight ? 66 : 17);
            }
            postInvalidateOnAnimation();
        }
    }

    public void scrollTo(int x, int y) {
        if (getChildCount() > 0) {
            View child = getChildAt(0);
            x = clamp(x, (getWidth() - this.mPaddingRight) - this.mPaddingLeft, child.getWidth());
            y = clamp(y, (getHeight() - this.mPaddingBottom) - this.mPaddingTop, child.getHeight());
            if (x != this.mScrollX || y != this.mScrollY) {
                super.scrollTo(x, y);
            }
        }
    }

    public void setOverScrollMode(int mode) {
        if (mode == 2) {
            this.mEdgeGlowLeft = null;
            this.mEdgeGlowRight = null;
        } else if (this.mEdgeGlowLeft == null) {
            Context context = getContext();
            this.mEdgeGlowLeft = new EdgeEffect(context);
            this.mEdgeGlowRight = new EdgeEffect(context);
        }
        super.setOverScrollMode(mode);
    }

    public void draw(Canvas canvas) {
        super.draw(canvas);
        if (this.mEdgeGlowLeft != null) {
            int restoreCount;
            int height;
            int scrollX = this.mScrollX;
            if (!this.mEdgeGlowLeft.isFinished()) {
                restoreCount = canvas.save();
                height = (getHeight() - this.mPaddingTop) - this.mPaddingBottom;
                canvas.rotate(270.0f);
                canvas.translate((float) ((-height) + this.mPaddingTop), (float) Math.min(0, scrollX));
                this.mEdgeGlowLeft.setSize(height, getWidth());
                if (this.mEdgeGlowLeft.draw(canvas)) {
                    postInvalidateOnAnimation();
                }
                canvas.restoreToCount(restoreCount);
            }
            if (!this.mEdgeGlowRight.isFinished()) {
                restoreCount = canvas.save();
                int width = getWidth();
                height = (getHeight() - this.mPaddingTop) - this.mPaddingBottom;
                canvas.rotate(90.0f);
                canvas.translate((float) (-this.mPaddingTop), (float) (-(Math.max(getScrollRange(), scrollX) + width)));
                this.mEdgeGlowRight.setSize(height, width);
                if (this.mEdgeGlowRight.draw(canvas)) {
                    postInvalidateOnAnimation();
                }
                canvas.restoreToCount(restoreCount);
            }
        }
    }

    private static int clamp(int n, int my, int child) {
        if (my >= child || n < 0) {
            return 0;
        }
        if (my + n > child) {
            return child - my;
        }
        return n;
    }

    protected void onRestoreInstanceState(Parcelable state) {
        if (this.mContext.getApplicationInfo().targetSdkVersion <= 18) {
            super.onRestoreInstanceState(state);
            return;
        }
        SavedState ss = (SavedState) state;
        super.onRestoreInstanceState(ss.getSuperState());
        this.mSavedState = ss;
        requestLayout();
    }

    protected Parcelable onSaveInstanceState() {
        if (this.mContext.getApplicationInfo().targetSdkVersion <= 18) {
            return super.onSaveInstanceState();
        }
        Parcelable ss = new SavedState(super.onSaveInstanceState());
        ss.scrollPosition = this.mScrollX;
        ss.isLayoutRtl = isLayoutRtl();
        return ss;
    }
}
