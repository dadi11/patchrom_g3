package android.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Canvas;
import android.graphics.Rect;
import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.os.StrictMode;
import android.os.StrictMode.Span;
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
import com.android.internal.R;
import java.util.List;

public class ScrollView extends FrameLayout {
    static final int ANIMATED_SCROLL_GAP = 250;
    private static final int INVALID_POINTER = -1;
    static final float MAX_SCROLL_FACTOR = 0.5f;
    private static final String TAG = "ScrollView";
    private int mActivePointerId;
    private View mChildToScrollTo;
    private EdgeEffect mEdgeGlowBottom;
    private EdgeEffect mEdgeGlowTop;
    @ExportedProperty(category = "layout")
    private boolean mFillViewport;
    private Span mFlingStrictSpan;
    private boolean mIsBeingDragged;
    private boolean mIsLayoutDirty;
    private int mLastMotionY;
    private long mLastScroll;
    private int mMaximumVelocity;
    private int mMinimumVelocity;
    private int mNestedYOffset;
    private int mOverflingDistance;
    private int mOverscrollDistance;
    private SavedState mSavedState;
    private final int[] mScrollConsumed;
    private final int[] mScrollOffset;
    private Span mScrollStrictSpan;
    private OverScroller mScroller;
    private boolean mSmoothScrollingEnabled;
    private final Rect mTempRect;
    private int mTouchSlop;
    private VelocityTracker mVelocityTracker;

    static class SavedState extends BaseSavedState {
        public static final Creator<SavedState> CREATOR;
        public int scrollPosition;

        /* renamed from: android.widget.ScrollView.SavedState.1 */
        static class C10351 implements Creator<SavedState> {
            C10351() {
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
        }

        public void writeToParcel(Parcel dest, int flags) {
            super.writeToParcel(dest, flags);
            dest.writeInt(this.scrollPosition);
        }

        public String toString() {
            return "HorizontalScrollView.SavedState{" + Integer.toHexString(System.identityHashCode(this)) + " scrollPosition=" + this.scrollPosition + "}";
        }

        static {
            CREATOR = new C10351();
        }
    }

    public ScrollView(Context context) {
        this(context, null);
    }

    public ScrollView(Context context, AttributeSet attrs) {
        this(context, attrs, 16842880);
    }

    public ScrollView(Context context, AttributeSet attrs, int defStyleAttr) {
        this(context, attrs, defStyleAttr, 0);
    }

    public ScrollView(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
        this.mTempRect = new Rect();
        this.mIsLayoutDirty = true;
        this.mChildToScrollTo = null;
        this.mIsBeingDragged = false;
        this.mSmoothScrollingEnabled = true;
        this.mActivePointerId = INVALID_POINTER;
        this.mScrollOffset = new int[2];
        this.mScrollConsumed = new int[2];
        this.mScrollStrictSpan = null;
        this.mFlingStrictSpan = null;
        initScrollView();
        TypedArray a = context.obtainStyledAttributes(attrs, R.styleable.ScrollView, defStyleAttr, defStyleRes);
        setFillViewport(a.getBoolean(0, false));
        a.recycle();
    }

    public boolean shouldDelayChildPressedState() {
        return true;
    }

    protected float getTopFadingEdgeStrength() {
        if (getChildCount() == 0) {
            return 0.0f;
        }
        int length = getVerticalFadingEdgeLength();
        if (this.mScrollY < length) {
            return ((float) this.mScrollY) / ((float) length);
        }
        return LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
    }

    protected float getBottomFadingEdgeStrength() {
        if (getChildCount() == 0) {
            return 0.0f;
        }
        int length = getVerticalFadingEdgeLength();
        int span = (getChildAt(0).getBottom() - this.mScrollY) - (getHeight() - this.mPaddingBottom);
        if (span < length) {
            return ((float) span) / ((float) length);
        }
        return LayoutParams.BRIGHTNESS_OVERRIDE_FULL;
    }

    public int getMaxScrollAmount() {
        return (int) (MAX_SCROLL_FACTOR * ((float) (this.mBottom - this.mTop)));
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
            throw new IllegalStateException("ScrollView can host only one direct child");
        }
        super.addView(child);
    }

    public void addView(View child, int index) {
        if (getChildCount() > 0) {
            throw new IllegalStateException("ScrollView can host only one direct child");
        }
        super.addView(child, index);
    }

    public void addView(View child, ViewGroup.LayoutParams params) {
        if (getChildCount() > 0) {
            throw new IllegalStateException("ScrollView can host only one direct child");
        }
        super.addView(child, params);
    }

    public void addView(View child, int index, ViewGroup.LayoutParams params) {
        if (getChildCount() > 0) {
            throw new IllegalStateException("ScrollView can host only one direct child");
        }
        super.addView(child, index, params);
    }

    private boolean canScroll() {
        View child = getChildAt(0);
        if (child == null) {
            return false;
        }
        if (getHeight() < (this.mPaddingTop + child.getHeight()) + this.mPaddingBottom) {
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
        if (this.mFillViewport && MeasureSpec.getMode(heightMeasureSpec) != 0 && getChildCount() > 0) {
            View child = getChildAt(0);
            int height = getMeasuredHeight();
            if (child.getMeasuredHeight() < height) {
                child.measure(ViewGroup.getChildMeasureSpec(widthMeasureSpec, this.mPaddingLeft + this.mPaddingRight, ((FrameLayout.LayoutParams) child.getLayoutParams()).width), MeasureSpec.makeMeasureSpec((height - this.mPaddingTop) - this.mPaddingBottom, EditorInfo.IME_FLAG_NO_ENTER_ACTION));
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
                    case RelativeLayout.ALIGN_END /*19*/:
                        if (!event.isAltPressed()) {
                            handled = arrowScroll(33);
                            break;
                        }
                        handled = fullScroll(33);
                        break;
                    case RelativeLayout.ALIGN_PARENT_START /*20*/:
                        if (!event.isAltPressed()) {
                            handled = arrowScroll(KeyEvent.KEYCODE_MEDIA_RECORD);
                            break;
                        }
                        handled = fullScroll(KeyEvent.KEYCODE_MEDIA_RECORD);
                        break;
                    case KeyEvent.KEYCODE_SPACE /*62*/:
                        pageScroll(event.isShiftPressed() ? 33 : KeyEvent.KEYCODE_MEDIA_RECORD);
                        break;
                }
            }
            return handled;
        } else if (!isFocused() || event.getKeyCode() == 4) {
            return false;
        } else {
            View currentFocused = findFocus();
            if (currentFocused == this) {
                currentFocused = null;
            }
            View nextFocused = FocusFinder.getInstance().findNextFocus(this, currentFocused, KeyEvent.KEYCODE_MEDIA_RECORD);
            if (nextFocused == null || nextFocused == this || !nextFocused.requestFocus(KeyEvent.KEYCODE_MEDIA_RECORD)) {
                return false;
            }
            return true;
        }
    }

    private boolean inChild(int x, int y) {
        if (getChildCount() <= 0) {
            return false;
        }
        int scrollY = this.mScrollY;
        View child = getChildAt(0);
        if (y < child.getTop() - scrollY || y >= child.getBottom() - scrollY || x < child.getLeft() || x >= child.getRight()) {
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
        if (getScrollY() == 0 && !canScrollVertically(1)) {
            return false;
        }
        int y;
        switch (action & EditorInfo.IME_MASK_ACTION) {
            case Toast.LENGTH_SHORT /*0*/:
                y = (int) ev.getY();
                if (!inChild((int) ev.getX(), y)) {
                    this.mIsBeingDragged = false;
                    recycleVelocityTracker();
                    break;
                }
                this.mLastMotionY = y;
                this.mActivePointerId = ev.getPointerId(0);
                initOrResetVelocityTracker();
                this.mVelocityTracker.addMovement(ev);
                if (!this.mScroller.isFinished()) {
                    z = true;
                }
                this.mIsBeingDragged = z;
                if (this.mIsBeingDragged && this.mScrollStrictSpan == null) {
                    this.mScrollStrictSpan = StrictMode.enterCriticalSpan("ScrollView-scroll");
                }
                startNestedScroll(2);
                break;
            case Toast.LENGTH_LONG /*1*/:
            case SetDrawableParameters.TAG /*3*/:
                this.mIsBeingDragged = false;
                this.mActivePointerId = INVALID_POINTER;
                recycleVelocityTracker();
                if (this.mScroller.springBack(this.mScrollX, this.mScrollY, 0, 0, 0, getScrollRange())) {
                    postInvalidateOnAnimation();
                }
                stopNestedScroll();
                break;
            case Action.MERGE_IGNORE /*2*/:
                int activePointerId = this.mActivePointerId;
                if (activePointerId != INVALID_POINTER) {
                    int pointerIndex = ev.findPointerIndex(activePointerId);
                    if (pointerIndex != INVALID_POINTER) {
                        y = (int) ev.getY(pointerIndex);
                        if (Math.abs(y - this.mLastMotionY) > this.mTouchSlop && (getNestedScrollAxes() & 2) == 0) {
                            this.mIsBeingDragged = true;
                            this.mLastMotionY = y;
                            initVelocityTrackerIfNotExists();
                            this.mVelocityTracker.addMovement(ev);
                            this.mNestedYOffset = 0;
                            if (this.mScrollStrictSpan == null) {
                                this.mScrollStrictSpan = StrictMode.enterCriticalSpan("ScrollView-scroll");
                            }
                            ViewParent parent = getParent();
                            if (parent != null) {
                                parent.requestDisallowInterceptTouchEvent(true);
                                break;
                            }
                        }
                    }
                    Log.e(TAG, "Invalid pointerId=" + activePointerId + " in onInterceptTouchEvent");
                    break;
                }
                break;
            case SetEmptyView.TAG /*6*/:
                onSecondaryPointerUp(ev);
                break;
        }
        return this.mIsBeingDragged;
    }

    public boolean onTouchEvent(MotionEvent ev) {
        initVelocityTrackerIfNotExists();
        MotionEvent vtev = MotionEvent.obtain(ev);
        int actionMasked = ev.getActionMasked();
        if (actionMasked == 0) {
            this.mNestedYOffset = 0;
        }
        vtev.offsetLocation(0.0f, (float) this.mNestedYOffset);
        ViewParent parent;
        switch (actionMasked) {
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
                        if (this.mFlingStrictSpan != null) {
                            this.mFlingStrictSpan.finish();
                            this.mFlingStrictSpan = null;
                        }
                    }
                    this.mLastMotionY = (int) ev.getY();
                    this.mActivePointerId = ev.getPointerId(0);
                    startNestedScroll(2);
                    break;
                }
                return false;
            case Toast.LENGTH_LONG /*1*/:
                if (this.mIsBeingDragged) {
                    VelocityTracker velocityTracker = this.mVelocityTracker;
                    velocityTracker.computeCurrentVelocity(LayoutParams.TYPE_APPLICATION_PANEL, (float) this.mMaximumVelocity);
                    int initialVelocity = (int) velocityTracker.getYVelocity(this.mActivePointerId);
                    if (Math.abs(initialVelocity) > this.mMinimumVelocity) {
                        flingWithNestedDispatch(-initialVelocity);
                    } else {
                        if (this.mScroller.springBack(this.mScrollX, this.mScrollY, 0, 0, 0, getScrollRange())) {
                            postInvalidateOnAnimation();
                        }
                    }
                    this.mActivePointerId = INVALID_POINTER;
                    endDrag();
                    break;
                }
                break;
            case Action.MERGE_IGNORE /*2*/:
                int activePointerIndex = ev.findPointerIndex(this.mActivePointerId);
                if (activePointerIndex != INVALID_POINTER) {
                    int y = (int) ev.getY(activePointerIndex);
                    int deltaY = this.mLastMotionY - y;
                    if (dispatchNestedPreScroll(0, deltaY, this.mScrollConsumed, this.mScrollOffset)) {
                        deltaY -= this.mScrollConsumed[1];
                        vtev.offsetLocation(0.0f, (float) this.mScrollOffset[1]);
                        this.mNestedYOffset += this.mScrollOffset[1];
                    }
                    if (!this.mIsBeingDragged && Math.abs(deltaY) > this.mTouchSlop) {
                        parent = getParent();
                        if (parent != null) {
                            parent.requestDisallowInterceptTouchEvent(true);
                        }
                        this.mIsBeingDragged = true;
                        if (deltaY > 0) {
                            deltaY -= this.mTouchSlop;
                        } else {
                            deltaY += this.mTouchSlop;
                        }
                    }
                    if (this.mIsBeingDragged) {
                        this.mLastMotionY = y - this.mScrollOffset[1];
                        int oldY = this.mScrollY;
                        int range = getScrollRange();
                        int overscrollMode = getOverScrollMode();
                        boolean canOverscroll = overscrollMode == 0 || (overscrollMode == 1 && range > 0);
                        if (overScrollBy(0, deltaY, 0, this.mScrollY, 0, range, 0, this.mOverscrollDistance, true) && !hasNestedScrollingParent()) {
                            this.mVelocityTracker.clear();
                        }
                        int scrolledDeltaY = this.mScrollY - oldY;
                        if (!dispatchNestedScroll(0, scrolledDeltaY, 0, deltaY - scrolledDeltaY, this.mScrollOffset)) {
                            if (canOverscroll) {
                                int pulledToY = oldY + deltaY;
                                if (pulledToY < 0) {
                                    this.mEdgeGlowTop.onPull(((float) deltaY) / ((float) getHeight()), ev.getX(activePointerIndex) / ((float) getWidth()));
                                    if (!this.mEdgeGlowBottom.isFinished()) {
                                        this.mEdgeGlowBottom.onRelease();
                                    }
                                } else if (pulledToY > range) {
                                    this.mEdgeGlowBottom.onPull(((float) deltaY) / ((float) getHeight()), LayoutParams.BRIGHTNESS_OVERRIDE_FULL - (ev.getX(activePointerIndex) / ((float) getWidth())));
                                    if (!this.mEdgeGlowTop.isFinished()) {
                                        this.mEdgeGlowTop.onRelease();
                                    }
                                }
                                if (!(this.mEdgeGlowTop == null || (this.mEdgeGlowTop.isFinished() && this.mEdgeGlowBottom.isFinished()))) {
                                    postInvalidateOnAnimation();
                                    break;
                                }
                            }
                        }
                        this.mLastMotionY -= this.mScrollOffset[1];
                        vtev.offsetLocation(0.0f, (float) this.mScrollOffset[1]);
                        this.mNestedYOffset += this.mScrollOffset[1];
                        break;
                    }
                }
                Log.e(TAG, "Invalid pointerId=" + this.mActivePointerId + " in onTouchEvent");
                break;
                break;
            case SetDrawableParameters.TAG /*3*/:
                if (this.mIsBeingDragged && getChildCount() > 0) {
                    if (this.mScroller.springBack(this.mScrollX, this.mScrollY, 0, 0, 0, getScrollRange())) {
                        postInvalidateOnAnimation();
                    }
                    this.mActivePointerId = INVALID_POINTER;
                    endDrag();
                    break;
                }
            case ReflectionActionWithoutParams.TAG /*5*/:
                int index = ev.getActionIndex();
                this.mLastMotionY = (int) ev.getY(index);
                this.mActivePointerId = ev.getPointerId(index);
                break;
            case SetEmptyView.TAG /*6*/:
                onSecondaryPointerUp(ev);
                this.mLastMotionY = (int) ev.getY(ev.findPointerIndex(this.mActivePointerId));
                break;
        }
        if (this.mVelocityTracker != null) {
            this.mVelocityTracker.addMovement(vtev);
        }
        vtev.recycle();
        return true;
    }

    private void onSecondaryPointerUp(MotionEvent ev) {
        int pointerIndex = (ev.getAction() & MotionEvent.ACTION_POINTER_INDEX_MASK) >> 8;
        if (ev.getPointerId(pointerIndex) == this.mActivePointerId) {
            int newPointerIndex = pointerIndex == 0 ? 1 : 0;
            this.mLastMotionY = (int) ev.getY(newPointerIndex);
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
                        float vscroll = event.getAxisValue(9);
                        if (vscroll != 0.0f) {
                            int delta = (int) (getVerticalScrollFactor() * vscroll);
                            int range = getScrollRange();
                            int oldScrollY = this.mScrollY;
                            int newScrollY = oldScrollY - delta;
                            if (newScrollY < 0) {
                                newScrollY = 0;
                            } else if (newScrollY > range) {
                                newScrollY = range;
                            }
                            if (newScrollY != oldScrollY) {
                                super.scrollTo(this.mScrollX, newScrollY);
                                return true;
                            }
                        }
                    }
                    break;
            }
        }
        return super.onGenericMotionEvent(event);
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
            if (clampedY) {
                this.mScroller.springBack(this.mScrollX, this.mScrollY, 0, 0, 0, getScrollRange());
            }
        }
        awakenScrollBars();
    }

    public boolean performAccessibilityAction(int action, Bundle arguments) {
        if (super.performAccessibilityAction(action, arguments)) {
            return true;
        }
        if (!isEnabled()) {
            return false;
        }
        int targetScrollY;
        switch (action) {
            case AccessibilityNodeInfo.ACTION_SCROLL_FORWARD /*4096*/:
                targetScrollY = Math.min(this.mScrollY + ((getHeight() - this.mPaddingBottom) - this.mPaddingTop), getScrollRange());
                if (targetScrollY == this.mScrollY) {
                    return false;
                }
                smoothScrollTo(0, targetScrollY);
                return true;
            case AccessibilityNodeInfo.ACTION_SCROLL_BACKWARD /*8192*/:
                targetScrollY = Math.max(this.mScrollY - ((getHeight() - this.mPaddingBottom) - this.mPaddingTop), 0);
                if (targetScrollY == this.mScrollY) {
                    return false;
                }
                smoothScrollTo(0, targetScrollY);
                return true;
            default:
                return false;
        }
    }

    public void onInitializeAccessibilityNodeInfo(AccessibilityNodeInfo info) {
        super.onInitializeAccessibilityNodeInfo(info);
        info.setClassName(ScrollView.class.getName());
        if (isEnabled()) {
            int scrollRange = getScrollRange();
            if (scrollRange > 0) {
                info.setScrollable(true);
                if (this.mScrollY > 0) {
                    info.addAction((int) AccessibilityNodeInfo.ACTION_SCROLL_BACKWARD);
                }
                if (this.mScrollY < scrollRange) {
                    info.addAction((int) AccessibilityNodeInfo.ACTION_SCROLL_FORWARD);
                }
            }
        }
    }

    public void onInitializeAccessibilityEvent(AccessibilityEvent event) {
        super.onInitializeAccessibilityEvent(event);
        event.setClassName(ScrollView.class.getName());
        event.setScrollable(getScrollRange() > 0);
        event.setScrollX(this.mScrollX);
        event.setScrollY(this.mScrollY);
        event.setMaxScrollX(this.mScrollX);
        event.setMaxScrollY(getScrollRange());
    }

    private int getScrollRange() {
        if (getChildCount() > 0) {
            return Math.max(0, getChildAt(0).getHeight() - ((getHeight() - this.mPaddingBottom) - this.mPaddingTop));
        }
        return 0;
    }

    private View findFocusableViewInBounds(boolean topFocus, int top, int bottom) {
        List<View> focusables = getFocusables(2);
        View focusCandidate = null;
        boolean foundFullyContainedFocusable = false;
        int count = focusables.size();
        for (int i = 0; i < count; i++) {
            View view = (View) focusables.get(i);
            int viewTop = view.getTop();
            int viewBottom = view.getBottom();
            if (top < viewBottom && viewTop < bottom) {
                boolean viewIsFullyContained = top < viewTop && viewBottom < bottom;
                if (focusCandidate == null) {
                    focusCandidate = view;
                    foundFullyContainedFocusable = viewIsFullyContained;
                } else {
                    boolean viewIsCloserToBoundary = (topFocus && viewTop < focusCandidate.getTop()) || (!topFocus && viewBottom > focusCandidate.getBottom());
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
        boolean down;
        if (direction == KeyEvent.KEYCODE_MEDIA_RECORD) {
            down = true;
        } else {
            down = false;
        }
        int height = getHeight();
        if (down) {
            this.mTempRect.top = getScrollY() + height;
            int count = getChildCount();
            if (count > 0) {
                View view = getChildAt(count + INVALID_POINTER);
                if (this.mTempRect.top + height > view.getBottom()) {
                    this.mTempRect.top = view.getBottom() - height;
                }
            }
        } else {
            this.mTempRect.top = getScrollY() - height;
            if (this.mTempRect.top < 0) {
                this.mTempRect.top = 0;
            }
        }
        this.mTempRect.bottom = this.mTempRect.top + height;
        return scrollAndFocus(direction, this.mTempRect.top, this.mTempRect.bottom);
    }

    public boolean fullScroll(int direction) {
        boolean down;
        if (direction == KeyEvent.KEYCODE_MEDIA_RECORD) {
            down = true;
        } else {
            down = false;
        }
        int height = getHeight();
        this.mTempRect.top = 0;
        this.mTempRect.bottom = height;
        if (down) {
            int count = getChildCount();
            if (count > 0) {
                View view = getChildAt(count + INVALID_POINTER);
                this.mTempRect.bottom = view.getBottom() + this.mPaddingBottom;
                this.mTempRect.top = this.mTempRect.bottom - height;
            }
        }
        return scrollAndFocus(direction, this.mTempRect.top, this.mTempRect.bottom);
    }

    private boolean scrollAndFocus(int direction, int top, int bottom) {
        boolean handled = true;
        int height = getHeight();
        int containerTop = getScrollY();
        int containerBottom = containerTop + height;
        boolean up = direction == 33;
        View newFocused = findFocusableViewInBounds(up, top, bottom);
        if (newFocused == null) {
            newFocused = this;
        }
        if (top < containerTop || bottom > containerBottom) {
            doScrollY(up ? top - containerTop : bottom - containerBottom);
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
        if (nextFocused == null || !isWithinDeltaOfScreen(nextFocused, maxJump, getHeight())) {
            int scrollDelta = maxJump;
            if (direction == 33 && getScrollY() < scrollDelta) {
                scrollDelta = getScrollY();
            } else if (direction == KeyEvent.KEYCODE_MEDIA_RECORD && getChildCount() > 0) {
                int daBottom = getChildAt(0).getBottom();
                int screenBottom = (getScrollY() + getHeight()) - this.mPaddingBottom;
                if (daBottom - screenBottom < maxJump) {
                    scrollDelta = daBottom - screenBottom;
                }
            }
            if (scrollDelta == 0) {
                return false;
            }
            int i;
            if (direction == KeyEvent.KEYCODE_MEDIA_RECORD) {
                i = scrollDelta;
            } else {
                i = -scrollDelta;
            }
            doScrollY(i);
        } else {
            nextFocused.getDrawingRect(this.mTempRect);
            offsetDescendantRectToMyCoords(nextFocused, this.mTempRect);
            doScrollY(computeScrollDeltaToGetChildRectOnScreen(this.mTempRect));
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
        return !isWithinDeltaOfScreen(descendant, 0, getHeight());
    }

    private boolean isWithinDeltaOfScreen(View descendant, int delta, int height) {
        descendant.getDrawingRect(this.mTempRect);
        offsetDescendantRectToMyCoords(descendant, this.mTempRect);
        return this.mTempRect.bottom + delta >= getScrollY() && this.mTempRect.top - delta <= getScrollY() + height;
    }

    private void doScrollY(int delta) {
        if (delta == 0) {
            return;
        }
        if (this.mSmoothScrollingEnabled) {
            smoothScrollBy(0, delta);
        } else {
            scrollBy(0, delta);
        }
    }

    public final void smoothScrollBy(int dx, int dy) {
        if (getChildCount() != 0) {
            if (AnimationUtils.currentAnimationTimeMillis() - this.mLastScroll > 250) {
                int maxY = Math.max(0, getChildAt(0).getHeight() - ((getHeight() - this.mPaddingBottom) - this.mPaddingTop));
                int scrollY = this.mScrollY;
                this.mScroller.startScroll(this.mScrollX, scrollY, 0, Math.max(0, Math.min(scrollY + dy, maxY)) - scrollY);
                postInvalidateOnAnimation();
            } else {
                if (!this.mScroller.isFinished()) {
                    this.mScroller.abortAnimation();
                    if (this.mFlingStrictSpan != null) {
                        this.mFlingStrictSpan.finish();
                        this.mFlingStrictSpan = null;
                    }
                }
                scrollBy(dx, dy);
            }
            this.mLastScroll = AnimationUtils.currentAnimationTimeMillis();
        }
    }

    public final void smoothScrollTo(int x, int y) {
        smoothScrollBy(x - this.mScrollX, y - this.mScrollY);
    }

    protected int computeVerticalScrollRange() {
        int contentHeight = (getHeight() - this.mPaddingBottom) - this.mPaddingTop;
        if (getChildCount() == 0) {
            return contentHeight;
        }
        int scrollRange = getChildAt(0).getBottom();
        int scrollY = this.mScrollY;
        int overscrollBottom = Math.max(0, scrollRange - contentHeight);
        if (scrollY < 0) {
            scrollRange -= scrollY;
        } else if (scrollY > overscrollBottom) {
            scrollRange += scrollY - overscrollBottom;
        }
        return scrollRange;
    }

    protected int computeVerticalScrollOffset() {
        return Math.max(0, super.computeVerticalScrollOffset());
    }

    protected void measureChild(View child, int parentWidthMeasureSpec, int parentHeightMeasureSpec) {
        child.measure(ViewGroup.getChildMeasureSpec(parentWidthMeasureSpec, this.mPaddingLeft + this.mPaddingRight, child.getLayoutParams().width), MeasureSpec.makeMeasureSpec(0, 0));
    }

    protected void measureChildWithMargins(View child, int parentWidthMeasureSpec, int widthUsed, int parentHeightMeasureSpec, int heightUsed) {
        MarginLayoutParams lp = (MarginLayoutParams) child.getLayoutParams();
        child.measure(ViewGroup.getChildMeasureSpec(parentWidthMeasureSpec, (((this.mPaddingLeft + this.mPaddingRight) + lp.leftMargin) + lp.rightMargin) + widthUsed, lp.width), MeasureSpec.makeMeasureSpec(lp.topMargin + lp.bottomMargin, 0));
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
                overScrollBy(x - oldX, y - oldY, oldX, oldY, 0, range, 0, this.mOverflingDistance, false);
                onScrollChanged(this.mScrollX, this.mScrollY, oldX, oldY);
                if (canOverscroll) {
                    if (y < 0 && oldY >= 0) {
                        this.mEdgeGlowTop.onAbsorb((int) this.mScroller.getCurrVelocity());
                    } else if (y > range && oldY <= range) {
                        this.mEdgeGlowBottom.onAbsorb((int) this.mScroller.getCurrVelocity());
                    }
                }
            }
            if (!awakenScrollBars()) {
                postInvalidateOnAnimation();
            }
        } else if (this.mFlingStrictSpan != null) {
            this.mFlingStrictSpan.finish();
            this.mFlingStrictSpan = null;
        }
    }

    private void scrollToChild(View child) {
        child.getDrawingRect(this.mTempRect);
        offsetDescendantRectToMyCoords(child, this.mTempRect);
        int scrollDelta = computeScrollDeltaToGetChildRectOnScreen(this.mTempRect);
        if (scrollDelta != 0) {
            scrollBy(0, scrollDelta);
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
                scrollBy(0, delta);
            } else {
                smoothScrollBy(0, delta);
            }
        }
        return scroll;
    }

    protected int computeScrollDeltaToGetChildRectOnScreen(Rect rect) {
        if (getChildCount() == 0) {
            return 0;
        }
        int height = getHeight();
        int screenTop = getScrollY();
        int screenBottom = screenTop + height;
        int fadingEdge = getVerticalFadingEdgeLength();
        if (rect.top > 0) {
            screenTop += fadingEdge;
        }
        if (rect.bottom < getChildAt(0).getHeight()) {
            screenBottom -= fadingEdge;
        }
        int scrollYDelta;
        if (rect.bottom > screenBottom && rect.top > screenTop) {
            if (rect.height() > height) {
                scrollYDelta = 0 + (rect.top - screenTop);
            } else {
                scrollYDelta = 0 + (rect.bottom - screenBottom);
            }
            return Math.min(scrollYDelta, getChildAt(0).getBottom() - screenBottom);
        } else if (rect.top >= screenTop || rect.bottom >= screenBottom) {
            return 0;
        } else {
            if (rect.height() > height) {
                scrollYDelta = 0 - (screenBottom - rect.bottom);
            } else {
                scrollYDelta = 0 - (screenTop - rect.top);
            }
            return Math.max(scrollYDelta, -getScrollY());
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
            direction = KeyEvent.KEYCODE_MEDIA_RECORD;
        } else if (direction == 1) {
            direction = 33;
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

    protected void onDetachedFromWindow() {
        super.onDetachedFromWindow();
        if (this.mScrollStrictSpan != null) {
            this.mScrollStrictSpan.finish();
            this.mScrollStrictSpan = null;
        }
        if (this.mFlingStrictSpan != null) {
            this.mFlingStrictSpan.finish();
            this.mFlingStrictSpan = null;
        }
    }

    protected void onLayout(boolean changed, int l, int t, int r, int b) {
        super.onLayout(changed, l, t, r, b);
        this.mIsLayoutDirty = false;
        if (this.mChildToScrollTo != null && isViewDescendantOf(this.mChildToScrollTo, this)) {
            scrollToChild(this.mChildToScrollTo);
        }
        this.mChildToScrollTo = null;
        if (!isLaidOut()) {
            if (this.mSavedState != null) {
                this.mScrollY = this.mSavedState.scrollPosition;
                this.mSavedState = null;
            }
            int scrollRange = Math.max(0, (getChildCount() > 0 ? getChildAt(0).getMeasuredHeight() : 0) - (((b - t) - this.mPaddingBottom) - this.mPaddingTop));
            if (this.mScrollY > scrollRange) {
                this.mScrollY = scrollRange;
            } else if (this.mScrollY < 0) {
                this.mScrollY = 0;
            }
        }
        scrollTo(this.mScrollX, this.mScrollY);
    }

    protected void onSizeChanged(int w, int h, int oldw, int oldh) {
        super.onSizeChanged(w, h, oldw, oldh);
        View currentFocused = findFocus();
        if (currentFocused != null && this != currentFocused && isWithinDeltaOfScreen(currentFocused, 0, oldh)) {
            currentFocused.getDrawingRect(this.mTempRect);
            offsetDescendantRectToMyCoords(currentFocused, this.mTempRect);
            doScrollY(computeScrollDeltaToGetChildRectOnScreen(this.mTempRect));
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

    public void fling(int velocityY) {
        if (getChildCount() > 0) {
            int height = (getHeight() - this.mPaddingBottom) - this.mPaddingTop;
            int i = velocityY;
            int i2 = 0;
            int i3 = 0;
            int i4 = 0;
            int i5 = 0;
            this.mScroller.fling(this.mScrollX, this.mScrollY, 0, i, i2, i3, i4, Math.max(0, getChildAt(0).getHeight() - height), i5, height / 2);
            if (this.mFlingStrictSpan == null) {
                this.mFlingStrictSpan = StrictMode.enterCriticalSpan("ScrollView-fling");
            }
            postInvalidateOnAnimation();
        }
    }

    private void flingWithNestedDispatch(int velocityY) {
        boolean canFling = (this.mScrollY > 0 || velocityY > 0) && (this.mScrollY < getScrollRange() || velocityY < 0);
        if (!dispatchNestedPreFling(0.0f, (float) velocityY)) {
            dispatchNestedFling(0.0f, (float) velocityY, canFling);
            if (canFling) {
                fling(velocityY);
            }
        }
    }

    private void endDrag() {
        this.mIsBeingDragged = false;
        recycleVelocityTracker();
        if (this.mEdgeGlowTop != null) {
            this.mEdgeGlowTop.onRelease();
            this.mEdgeGlowBottom.onRelease();
        }
        if (this.mScrollStrictSpan != null) {
            this.mScrollStrictSpan.finish();
            this.mScrollStrictSpan = null;
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
            this.mEdgeGlowTop = null;
            this.mEdgeGlowBottom = null;
        } else if (this.mEdgeGlowTop == null) {
            Context context = getContext();
            this.mEdgeGlowTop = new EdgeEffect(context);
            this.mEdgeGlowBottom = new EdgeEffect(context);
        }
        super.setOverScrollMode(mode);
    }

    public boolean onStartNestedScroll(View child, View target, int nestedScrollAxes) {
        return (nestedScrollAxes & 2) != 0;
    }

    public void onNestedScrollAccepted(View child, View target, int axes) {
        super.onNestedScrollAccepted(child, target, axes);
        startNestedScroll(2);
    }

    public void onStopNestedScroll(View target) {
        super.onStopNestedScroll(target);
    }

    public void onNestedScroll(View target, int dxConsumed, int dyConsumed, int dxUnconsumed, int dyUnconsumed) {
        int oldScrollY = this.mScrollY;
        scrollBy(0, dyUnconsumed);
        int myConsumed = this.mScrollY - oldScrollY;
        dispatchNestedScroll(0, myConsumed, 0, dyUnconsumed - myConsumed, null);
    }

    public boolean onNestedFling(View target, float velocityX, float velocityY, boolean consumed) {
        if (consumed) {
            return false;
        }
        flingWithNestedDispatch((int) velocityY);
        return true;
    }

    public void draw(Canvas canvas) {
        super.draw(canvas);
        if (this.mEdgeGlowTop != null) {
            int restoreCount;
            int width;
            int scrollY = this.mScrollY;
            if (!this.mEdgeGlowTop.isFinished()) {
                restoreCount = canvas.save();
                width = (getWidth() - this.mPaddingLeft) - this.mPaddingRight;
                canvas.translate((float) this.mPaddingLeft, (float) Math.min(0, scrollY));
                this.mEdgeGlowTop.setSize(width, getHeight());
                if (this.mEdgeGlowTop.draw(canvas)) {
                    postInvalidateOnAnimation();
                }
                canvas.restoreToCount(restoreCount);
            }
            if (!this.mEdgeGlowBottom.isFinished()) {
                restoreCount = canvas.save();
                width = (getWidth() - this.mPaddingLeft) - this.mPaddingRight;
                int height = getHeight();
                canvas.translate((float) ((-width) + this.mPaddingLeft), (float) (Math.max(getScrollRange(), scrollY) + height));
                canvas.rotate(180.0f, (float) width, 0.0f);
                this.mEdgeGlowBottom.setSize(width, height);
                if (this.mEdgeGlowBottom.draw(canvas)) {
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
        ss.scrollPosition = this.mScrollY;
        return ss;
    }
}
