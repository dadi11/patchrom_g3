package android.widget;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.StateListDrawable;
import android.os.IBinder;
import android.util.AttributeSet;
import android.view.Gravity;
import android.view.KeyEvent;
import android.view.KeyEvent.DispatcherState;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnTouchListener;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;
import android.view.ViewTreeObserver.OnScrollChangedListener;
import android.view.WindowManager;
import android.view.WindowManager.LayoutParams;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputMethodManager;
import com.android.internal.R;
import java.lang.ref.WeakReference;

public class PopupWindow {
    private static final int[] ABOVE_ANCHOR_STATE_SET;
    private static final int DEFAULT_ANCHORED_GRAVITY = 8388659;
    public static final int INPUT_METHOD_FROM_FOCUSABLE = 0;
    public static final int INPUT_METHOD_NEEDED = 1;
    public static final int INPUT_METHOD_NOT_NEEDED = 2;
    private boolean mAboveAnchor;
    private Drawable mAboveAnchorBackgroundDrawable;
    private boolean mAllowScrollingAnchorParent;
    private WeakReference<View> mAnchor;
    private int mAnchorRelativeX;
    private int mAnchorRelativeY;
    private int mAnchorXoff;
    private int mAnchorYoff;
    private int mAnchoredGravity;
    private int mAnimationStyle;
    private boolean mAttachedInDecor;
    private boolean mAttachedInDecorSet;
    private Drawable mBackground;
    private Drawable mBelowAnchorBackgroundDrawable;
    private boolean mClipToScreen;
    private boolean mClippingEnabled;
    private View mContentView;
    private Context mContext;
    private int[] mDrawingLocation;
    private float mElevation;
    private boolean mFocusable;
    private int mHeight;
    private int mHeightMode;
    private boolean mIgnoreCheekPress;
    private int mInputMethodMode;
    private boolean mIsDropdown;
    private boolean mIsShowing;
    private int mLastHeight;
    private int mLastWidth;
    private boolean mLayoutInScreen;
    private boolean mLayoutInsetDecor;
    private boolean mNotTouchModal;
    private OnDismissListener mOnDismissListener;
    private final OnScrollChangedListener mOnScrollChangedListener;
    private boolean mOutsideTouchable;
    private boolean mOverlapAnchor;
    private int mPopupHeight;
    private View mPopupView;
    private boolean mPopupViewInitialLayoutDirectionInherited;
    private int mPopupWidth;
    private int[] mScreenLocation;
    private int mSoftInputMode;
    private int mSplitTouchEnabled;
    private Rect mTempRect;
    private OnTouchListener mTouchInterceptor;
    private boolean mTouchable;
    private int mWidth;
    private int mWidthMode;
    private int mWindowLayoutType;
    private WindowManager mWindowManager;

    public interface OnDismissListener {
        void onDismiss();
    }

    /* renamed from: android.widget.PopupWindow.1 */
    class C10131 implements OnScrollChangedListener {
        C10131() {
        }

        public void onScrollChanged() {
            View anchor = PopupWindow.this.mAnchor != null ? (View) PopupWindow.this.mAnchor.get() : null;
            if (anchor != null && PopupWindow.this.mPopupView != null) {
                LayoutParams p = (LayoutParams) PopupWindow.this.mPopupView.getLayoutParams();
                PopupWindow.this.updateAboveAnchor(PopupWindow.this.findDropDownPosition(anchor, p, PopupWindow.this.mAnchorXoff, PopupWindow.this.mAnchorYoff, PopupWindow.this.mAnchoredGravity));
                PopupWindow.this.update(p.f95x, p.f96y, -1, -1, true);
            }
        }
    }

    private class PopupViewContainer extends FrameLayout {
        private static final String TAG = "PopupWindow.PopupViewContainer";

        public PopupViewContainer(Context context) {
            super(context);
        }

        protected int[] onCreateDrawableState(int extraSpace) {
            if (!PopupWindow.this.mAboveAnchor) {
                return super.onCreateDrawableState(extraSpace);
            }
            int[] drawableState = super.onCreateDrawableState(extraSpace + PopupWindow.INPUT_METHOD_NEEDED);
            View.mergeDrawableStates(drawableState, PopupWindow.ABOVE_ANCHOR_STATE_SET);
            return drawableState;
        }

        public boolean dispatchKeyEvent(KeyEvent event) {
            if (event.getKeyCode() != 4) {
                return super.dispatchKeyEvent(event);
            }
            if (getKeyDispatcherState() == null) {
                return super.dispatchKeyEvent(event);
            }
            DispatcherState state;
            if (event.getAction() == 0 && event.getRepeatCount() == 0) {
                state = getKeyDispatcherState();
                if (state == null) {
                    return true;
                }
                state.startTracking(event, this);
                return true;
            }
            if (event.getAction() == PopupWindow.INPUT_METHOD_NEEDED) {
                state = getKeyDispatcherState();
                if (!(state == null || !state.isTracking(event) || event.isCanceled())) {
                    PopupWindow.this.dismiss();
                    return true;
                }
            }
            return super.dispatchKeyEvent(event);
        }

        public boolean dispatchTouchEvent(MotionEvent ev) {
            if (PopupWindow.this.mTouchInterceptor == null || !PopupWindow.this.mTouchInterceptor.onTouch(this, ev)) {
                return super.dispatchTouchEvent(ev);
            }
            return true;
        }

        public boolean onTouchEvent(MotionEvent event) {
            int x = (int) event.getX();
            int y = (int) event.getY();
            if (event.getAction() == 0 && (x < 0 || x >= getWidth() || y < 0 || y >= getHeight())) {
                PopupWindow.this.dismiss();
                return true;
            } else if (event.getAction() != 4) {
                return super.onTouchEvent(event);
            } else {
                PopupWindow.this.dismiss();
                return true;
            }
        }

        public void sendAccessibilityEvent(int eventType) {
            if (PopupWindow.this.mContentView != null) {
                PopupWindow.this.mContentView.sendAccessibilityEvent(eventType);
            } else {
                super.sendAccessibilityEvent(eventType);
            }
        }
    }

    static {
        int[] iArr = new int[INPUT_METHOD_NEEDED];
        iArr[INPUT_METHOD_FROM_FOCUSABLE] = 16842922;
        ABOVE_ANCHOR_STATE_SET = iArr;
    }

    public PopupWindow(Context context) {
        this(context, null);
    }

    public PopupWindow(Context context, AttributeSet attrs) {
        this(context, attrs, 16842870);
    }

    public PopupWindow(Context context, AttributeSet attrs, int defStyleAttr) {
        this(context, attrs, defStyleAttr, (int) INPUT_METHOD_FROM_FOCUSABLE);
    }

    public PopupWindow(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        this.mInputMethodMode = INPUT_METHOD_FROM_FOCUSABLE;
        this.mSoftInputMode = INPUT_METHOD_NEEDED;
        this.mTouchable = true;
        this.mOutsideTouchable = false;
        this.mClippingEnabled = true;
        this.mSplitTouchEnabled = -1;
        this.mAllowScrollingAnchorParent = true;
        this.mLayoutInsetDecor = false;
        this.mAttachedInDecor = true;
        this.mAttachedInDecorSet = false;
        this.mDrawingLocation = new int[INPUT_METHOD_NOT_NEEDED];
        this.mScreenLocation = new int[INPUT_METHOD_NOT_NEEDED];
        this.mTempRect = new Rect();
        this.mWindowLayoutType = LayoutParams.TYPE_APPLICATION_PANEL;
        this.mIgnoreCheekPress = false;
        this.mAnimationStyle = -1;
        this.mOnScrollChangedListener = new C10131();
        this.mContext = context;
        this.mWindowManager = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
        TypedArray a = context.obtainStyledAttributes(attrs, R.styleable.PopupWindow, defStyleAttr, defStyleRes);
        Drawable bg = a.getDrawable(INPUT_METHOD_FROM_FOCUSABLE);
        this.mElevation = a.getDimension(3, 0.0f);
        this.mOverlapAnchor = a.getBoolean(INPUT_METHOD_NOT_NEEDED, false);
        int animStyle = a.getResourceId(INPUT_METHOD_NEEDED, -1);
        if (animStyle == 16974567) {
            animStyle = -1;
        }
        this.mAnimationStyle = animStyle;
        a.recycle();
        setBackgroundDrawable(bg);
    }

    public PopupWindow() {
        this(null, (int) INPUT_METHOD_FROM_FOCUSABLE, (int) INPUT_METHOD_FROM_FOCUSABLE);
    }

    public PopupWindow(View contentView) {
        this(contentView, (int) INPUT_METHOD_FROM_FOCUSABLE, (int) INPUT_METHOD_FROM_FOCUSABLE);
    }

    public PopupWindow(int width, int height) {
        this(null, width, height);
    }

    public PopupWindow(View contentView, int width, int height) {
        this(contentView, width, height, false);
    }

    public PopupWindow(View contentView, int width, int height, boolean focusable) {
        this.mInputMethodMode = INPUT_METHOD_FROM_FOCUSABLE;
        this.mSoftInputMode = INPUT_METHOD_NEEDED;
        this.mTouchable = true;
        this.mOutsideTouchable = false;
        this.mClippingEnabled = true;
        this.mSplitTouchEnabled = -1;
        this.mAllowScrollingAnchorParent = true;
        this.mLayoutInsetDecor = false;
        this.mAttachedInDecor = true;
        this.mAttachedInDecorSet = false;
        this.mDrawingLocation = new int[INPUT_METHOD_NOT_NEEDED];
        this.mScreenLocation = new int[INPUT_METHOD_NOT_NEEDED];
        this.mTempRect = new Rect();
        this.mWindowLayoutType = LayoutParams.TYPE_APPLICATION_PANEL;
        this.mIgnoreCheekPress = false;
        this.mAnimationStyle = -1;
        this.mOnScrollChangedListener = new C10131();
        if (contentView != null) {
            this.mContext = contentView.getContext();
            this.mWindowManager = (WindowManager) this.mContext.getSystemService(Context.WINDOW_SERVICE);
        }
        setContentView(contentView);
        setWidth(width);
        setHeight(height);
        setFocusable(focusable);
    }

    public Drawable getBackground() {
        return this.mBackground;
    }

    public void setBackgroundDrawable(Drawable background) {
        this.mBackground = background;
        if (this.mBackground instanceof StateListDrawable) {
            StateListDrawable stateList = this.mBackground;
            int aboveAnchorStateIndex = stateList.getStateDrawableIndex(ABOVE_ANCHOR_STATE_SET);
            int count = stateList.getStateCount();
            int belowAnchorStateIndex = -1;
            for (int i = INPUT_METHOD_FROM_FOCUSABLE; i < count; i += INPUT_METHOD_NEEDED) {
                if (i != aboveAnchorStateIndex) {
                    belowAnchorStateIndex = i;
                    break;
                }
            }
            if (aboveAnchorStateIndex == -1 || belowAnchorStateIndex == -1) {
                this.mBelowAnchorBackgroundDrawable = null;
                this.mAboveAnchorBackgroundDrawable = null;
                return;
            }
            this.mAboveAnchorBackgroundDrawable = stateList.getStateDrawable(aboveAnchorStateIndex);
            this.mBelowAnchorBackgroundDrawable = stateList.getStateDrawable(belowAnchorStateIndex);
        }
    }

    public float getElevation() {
        return this.mElevation;
    }

    public void setElevation(float elevation) {
        this.mElevation = elevation;
    }

    public int getAnimationStyle() {
        return this.mAnimationStyle;
    }

    public void setIgnoreCheekPress() {
        this.mIgnoreCheekPress = true;
    }

    public void setAnimationStyle(int animationStyle) {
        this.mAnimationStyle = animationStyle;
    }

    public View getContentView() {
        return this.mContentView;
    }

    public void setContentView(View contentView) {
        if (!isShowing()) {
            this.mContentView = contentView;
            if (this.mContext == null && this.mContentView != null) {
                this.mContext = this.mContentView.getContext();
            }
            if (this.mWindowManager == null && this.mContentView != null) {
                this.mWindowManager = (WindowManager) this.mContext.getSystemService(Context.WINDOW_SERVICE);
            }
            if (this.mContext != null && !this.mAttachedInDecorSet) {
                setAttachedInDecor(this.mContext.getApplicationInfo().targetSdkVersion >= 22);
            }
        }
    }

    public void setTouchInterceptor(OnTouchListener l) {
        this.mTouchInterceptor = l;
    }

    public boolean isFocusable() {
        return this.mFocusable;
    }

    public void setFocusable(boolean focusable) {
        this.mFocusable = focusable;
    }

    public int getInputMethodMode() {
        return this.mInputMethodMode;
    }

    public void setInputMethodMode(int mode) {
        this.mInputMethodMode = mode;
    }

    public void setSoftInputMode(int mode) {
        this.mSoftInputMode = mode;
    }

    public int getSoftInputMode() {
        return this.mSoftInputMode;
    }

    public boolean isTouchable() {
        return this.mTouchable;
    }

    public void setTouchable(boolean touchable) {
        this.mTouchable = touchable;
    }

    public boolean isOutsideTouchable() {
        return this.mOutsideTouchable;
    }

    public void setOutsideTouchable(boolean touchable) {
        this.mOutsideTouchable = touchable;
    }

    public boolean isClippingEnabled() {
        return this.mClippingEnabled;
    }

    public void setClippingEnabled(boolean enabled) {
        this.mClippingEnabled = enabled;
    }

    public void setClipToScreenEnabled(boolean enabled) {
        this.mClipToScreen = enabled;
        setClippingEnabled(!enabled);
    }

    void setAllowScrollingAnchorParent(boolean enabled) {
        this.mAllowScrollingAnchorParent = enabled;
    }

    public boolean isSplitTouchEnabled() {
        if (this.mSplitTouchEnabled >= 0 || this.mContext == null) {
            if (this.mSplitTouchEnabled != INPUT_METHOD_NEEDED) {
                return false;
            }
            return true;
        } else if (this.mContext.getApplicationInfo().targetSdkVersion >= 11) {
            return true;
        } else {
            return false;
        }
    }

    public void setSplitTouchEnabled(boolean enabled) {
        this.mSplitTouchEnabled = enabled ? INPUT_METHOD_NEEDED : INPUT_METHOD_FROM_FOCUSABLE;
    }

    public boolean isLayoutInScreenEnabled() {
        return this.mLayoutInScreen;
    }

    public void setLayoutInScreenEnabled(boolean enabled) {
        this.mLayoutInScreen = enabled;
    }

    public boolean isAttachedInDecor() {
        return this.mAttachedInDecor;
    }

    public void setAttachedInDecor(boolean enabled) {
        this.mAttachedInDecor = enabled;
        this.mAttachedInDecorSet = true;
    }

    public void setLayoutInsetDecor(boolean enabled) {
        this.mLayoutInsetDecor = enabled;
    }

    public void setWindowLayoutType(int layoutType) {
        this.mWindowLayoutType = layoutType;
    }

    public int getWindowLayoutType() {
        return this.mWindowLayoutType;
    }

    public void setTouchModal(boolean touchModal) {
        this.mNotTouchModal = !touchModal;
    }

    public void setWindowLayoutMode(int widthSpec, int heightSpec) {
        this.mWidthMode = widthSpec;
        this.mHeightMode = heightSpec;
    }

    public int getHeight() {
        return this.mHeight;
    }

    public void setHeight(int height) {
        this.mHeight = height;
    }

    public int getWidth() {
        return this.mWidth;
    }

    public void setWidth(int width) {
        this.mWidth = width;
    }

    public boolean isShowing() {
        return this.mIsShowing;
    }

    public void showAtLocation(View parent, int gravity, int x, int y) {
        showAtLocation(parent.getWindowToken(), gravity, x, y);
    }

    public void showAtLocation(IBinder token, int gravity, int x, int y) {
        if (!isShowing() && this.mContentView != null) {
            int i;
            unregisterForScrollChanged();
            this.mIsShowing = true;
            this.mIsDropdown = false;
            LayoutParams p = createPopupLayout(token);
            p.windowAnimations = computeAnimationResource();
            preparePopup(p);
            if (gravity == 0) {
                gravity = DEFAULT_ANCHORED_GRAVITY;
            }
            p.gravity = gravity;
            p.f95x = x;
            p.f96y = y;
            if (this.mHeightMode < 0) {
                i = this.mHeightMode;
                this.mLastHeight = i;
                p.height = i;
            }
            if (this.mWidthMode < 0) {
                i = this.mWidthMode;
                this.mLastWidth = i;
                p.width = i;
            }
            invokePopup(p);
        }
    }

    public void showAsDropDown(View anchor) {
        showAsDropDown(anchor, INPUT_METHOD_FROM_FOCUSABLE, INPUT_METHOD_FROM_FOCUSABLE);
    }

    public void showAsDropDown(View anchor, int xoff, int yoff) {
        showAsDropDown(anchor, xoff, yoff, DEFAULT_ANCHORED_GRAVITY);
    }

    public void showAsDropDown(View anchor, int xoff, int yoff, int gravity) {
        if (!isShowing() && this.mContentView != null) {
            int i;
            registerForScrollChanged(anchor, xoff, yoff, gravity);
            this.mIsShowing = true;
            this.mIsDropdown = true;
            LayoutParams p = createPopupLayout(anchor.getWindowToken());
            preparePopup(p);
            updateAboveAnchor(findDropDownPosition(anchor, p, xoff, yoff, gravity));
            if (this.mHeightMode < 0) {
                i = this.mHeightMode;
                this.mLastHeight = i;
                p.height = i;
            }
            if (this.mWidthMode < 0) {
                i = this.mWidthMode;
                this.mLastWidth = i;
                p.width = i;
            }
            p.windowAnimations = computeAnimationResource();
            invokePopup(p);
        }
    }

    private void updateAboveAnchor(boolean aboveAnchor) {
        if (aboveAnchor != this.mAboveAnchor) {
            this.mAboveAnchor = aboveAnchor;
            if (this.mBackground == null) {
                return;
            }
            if (this.mAboveAnchorBackgroundDrawable == null) {
                this.mPopupView.refreshDrawableState();
            } else if (this.mAboveAnchor) {
                this.mPopupView.setBackground(this.mAboveAnchorBackgroundDrawable);
            } else {
                this.mPopupView.setBackground(this.mBelowAnchorBackgroundDrawable);
            }
        }
    }

    public boolean isAboveAnchor() {
        return this.mAboveAnchor;
    }

    private void preparePopup(LayoutParams p) {
        if (this.mContentView == null || this.mContext == null || this.mWindowManager == null) {
            throw new IllegalStateException("You must specify a valid content view by calling setContentView() before attempting to show the popup.");
        }
        if (this.mBackground != null) {
            ViewGroup.LayoutParams layoutParams = this.mContentView.getLayoutParams();
            int height = -1;
            if (layoutParams != null && layoutParams.height == -2) {
                height = -2;
            }
            PopupViewContainer popupViewContainer = new PopupViewContainer(this.mContext);
            FrameLayout.LayoutParams listParams = new FrameLayout.LayoutParams(-1, height);
            popupViewContainer.setBackground(this.mBackground);
            popupViewContainer.addView(this.mContentView, (ViewGroup.LayoutParams) listParams);
            this.mPopupView = popupViewContainer;
        } else {
            this.mPopupView = this.mContentView;
        }
        this.mPopupView.setElevation(this.mElevation);
        this.mPopupViewInitialLayoutDirectionInherited = this.mPopupView.getRawLayoutDirection() == INPUT_METHOD_NOT_NEEDED;
        this.mPopupWidth = p.width;
        this.mPopupHeight = p.height;
    }

    private void invokePopup(LayoutParams p) {
        if (this.mContext != null) {
            p.packageName = this.mContext.getPackageName();
        }
        this.mPopupView.setFitsSystemWindows(this.mLayoutInsetDecor);
        setLayoutDirectionFromAnchor();
        this.mWindowManager.addView(this.mPopupView, p);
    }

    private void setLayoutDirectionFromAnchor() {
        if (this.mAnchor != null) {
            View anchor = (View) this.mAnchor.get();
            if (anchor != null && this.mPopupViewInitialLayoutDirectionInherited) {
                this.mPopupView.setLayoutDirection(anchor.getLayoutDirection());
            }
        }
    }

    private LayoutParams createPopupLayout(IBinder token) {
        LayoutParams p = new LayoutParams();
        p.gravity = DEFAULT_ANCHORED_GRAVITY;
        int i = this.mWidth;
        this.mLastWidth = i;
        p.width = i;
        i = this.mHeight;
        this.mLastHeight = i;
        p.height = i;
        if (this.mBackground != null) {
            p.format = this.mBackground.getOpacity();
        } else {
            p.format = -3;
        }
        p.flags = computeFlags(p.flags);
        p.type = this.mWindowLayoutType;
        p.token = token;
        p.softInputMode = this.mSoftInputMode;
        p.setTitle("PopupWindow:" + Integer.toHexString(hashCode()));
        return p;
    }

    private int computeFlags(int curFlags) {
        curFlags &= -8815129;
        if (this.mIgnoreCheekPress) {
            curFlags |= AccessibilityNodeInfo.ACTION_PASTE;
        }
        if (!this.mFocusable) {
            curFlags |= 8;
            if (this.mInputMethodMode == INPUT_METHOD_NEEDED) {
                curFlags |= AccessibilityNodeInfo.ACTION_SET_SELECTION;
            }
        } else if (this.mInputMethodMode == INPUT_METHOD_NOT_NEEDED) {
            curFlags |= AccessibilityNodeInfo.ACTION_SET_SELECTION;
        }
        if (!this.mTouchable) {
            curFlags |= 16;
        }
        if (this.mOutsideTouchable) {
            curFlags |= AccessibilityNodeInfo.ACTION_EXPAND;
        }
        if (!this.mClippingEnabled) {
            curFlags |= AccessibilityNodeInfo.ACTION_PREVIOUS_AT_MOVEMENT_GRANULARITY;
        }
        if (isSplitTouchEnabled()) {
            curFlags |= LayoutParams.FLAG_SPLIT_TOUCH;
        }
        if (this.mLayoutInScreen) {
            curFlags |= InputMethodManager.CONTROL_START_INITIAL;
        }
        if (this.mLayoutInsetDecor) {
            curFlags |= AccessibilityNodeInfo.ACTION_CUT;
        }
        if (this.mNotTouchModal) {
            curFlags |= 32;
        }
        if (this.mAttachedInDecor) {
            return curFlags | EditorInfo.IME_FLAG_NO_ENTER_ACTION;
        }
        return curFlags;
    }

    private int computeAnimationResource() {
        if (this.mAnimationStyle != -1) {
            return this.mAnimationStyle;
        }
        if (this.mIsDropdown) {
            return this.mAboveAnchor ? 16974559 : 16974558;
        } else {
            return INPUT_METHOD_FROM_FOCUSABLE;
        }
    }

    private boolean findDropDownPosition(View anchor, LayoutParams p, int xoff, int yoff, int gravity) {
        int anchorHeight = anchor.getHeight();
        int anchorWidth = anchor.getWidth();
        if (this.mOverlapAnchor) {
            yoff -= anchorHeight;
        }
        anchor.getLocationInWindow(this.mDrawingLocation);
        p.f95x = this.mDrawingLocation[INPUT_METHOD_FROM_FOCUSABLE] + xoff;
        p.f96y = (this.mDrawingLocation[INPUT_METHOD_NEEDED] + anchorHeight) + yoff;
        int hgrav = Gravity.getAbsoluteGravity(gravity, anchor.getLayoutDirection()) & 7;
        if (hgrav == 5) {
            p.f95x -= this.mPopupWidth - anchorWidth;
        }
        boolean onTop = false;
        p.gravity = 51;
        anchor.getLocationOnScreen(this.mScreenLocation);
        Rect displayFrame = new Rect();
        anchor.getWindowVisibleDisplayFrame(displayFrame);
        int screenY = (this.mScreenLocation[INPUT_METHOD_NEEDED] + anchorHeight) + yoff;
        View root = anchor.getRootView();
        if (this.mPopupHeight + screenY > displayFrame.bottom || (p.f95x + this.mPopupWidth) - root.getWidth() > 0) {
            if (this.mAllowScrollingAnchorParent) {
                int scrollX = anchor.getScrollX();
                int scrollY = anchor.getScrollY();
                anchor.requestRectangleOnScreen(new Rect(scrollX, scrollY, (this.mPopupWidth + scrollX) + xoff, ((this.mPopupHeight + scrollY) + anchorHeight) + yoff), true);
            }
            anchor.getLocationInWindow(this.mDrawingLocation);
            p.f95x = this.mDrawingLocation[INPUT_METHOD_FROM_FOCUSABLE] + xoff;
            p.f96y = (this.mDrawingLocation[INPUT_METHOD_NEEDED] + anchorHeight) + yoff;
            if (hgrav == 5) {
                p.f95x -= this.mPopupWidth - anchorWidth;
            }
            anchor.getLocationOnScreen(this.mScreenLocation);
            onTop = ((displayFrame.bottom - this.mScreenLocation[INPUT_METHOD_NEEDED]) - anchorHeight) - yoff < (this.mScreenLocation[INPUT_METHOD_NEEDED] - yoff) - displayFrame.top;
            if (onTop) {
                p.gravity = 83;
                p.f96y = (root.getHeight() - this.mDrawingLocation[INPUT_METHOD_NEEDED]) + yoff;
            } else {
                p.f96y = (this.mDrawingLocation[INPUT_METHOD_NEEDED] + anchorHeight) + yoff;
            }
        }
        if (this.mClipToScreen) {
            int displayFrameWidth = displayFrame.right - displayFrame.left;
            int right = p.f95x + p.width;
            if (right > displayFrameWidth) {
                p.f95x -= right - displayFrameWidth;
            }
            if (p.f95x < displayFrame.left) {
                p.f95x = displayFrame.left;
                p.width = Math.min(p.width, displayFrameWidth);
            }
            if (onTop) {
                int popupTop = (this.mScreenLocation[INPUT_METHOD_NEEDED] + yoff) - this.mPopupHeight;
                if (popupTop < 0) {
                    p.f96y += popupTop;
                }
            } else {
                p.f96y = Math.max(p.f96y, displayFrame.top);
            }
        }
        p.gravity |= EditorInfo.IME_FLAG_NO_EXTRACT_UI;
        this.mAnchorRelativeX = (this.mDrawingLocation[INPUT_METHOD_FROM_FOCUSABLE] - p.f95x) + (anchorHeight / INPUT_METHOD_NOT_NEEDED);
        this.mAnchorRelativeY = (this.mDrawingLocation[INPUT_METHOD_NEEDED] - p.f96y) + (anchorWidth / INPUT_METHOD_NOT_NEEDED);
        return onTop;
    }

    public int getMaxAvailableHeight(View anchor) {
        return getMaxAvailableHeight(anchor, INPUT_METHOD_FROM_FOCUSABLE);
    }

    public int getMaxAvailableHeight(View anchor, int yOffset) {
        return getMaxAvailableHeight(anchor, yOffset, false);
    }

    public int getMaxAvailableHeight(View anchor, int yOffset, boolean ignoreBottomDecorations) {
        Rect displayFrame = new Rect();
        anchor.getWindowVisibleDisplayFrame(displayFrame);
        int[] anchorPos = this.mDrawingLocation;
        anchor.getLocationOnScreen(anchorPos);
        int bottomEdge = displayFrame.bottom;
        if (ignoreBottomDecorations) {
            bottomEdge = anchor.getContext().getResources().getDisplayMetrics().heightPixels;
        }
        int returnedHeight = Math.max((bottomEdge - (anchorPos[INPUT_METHOD_NEEDED] + anchor.getHeight())) - yOffset, (anchorPos[INPUT_METHOD_NEEDED] - displayFrame.top) + yOffset);
        if (this.mBackground == null) {
            return returnedHeight;
        }
        this.mBackground.getPadding(this.mTempRect);
        return returnedHeight - (this.mTempRect.top + this.mTempRect.bottom);
    }

    public void dismiss() {
        if (isShowing() && this.mPopupView != null) {
            this.mIsShowing = false;
            unregisterForScrollChanged();
            try {
                this.mWindowManager.removeViewImmediate(this.mPopupView);
                if (this.mPopupView != this.mContentView && (this.mPopupView instanceof ViewGroup)) {
                    ((ViewGroup) this.mPopupView).removeView(this.mContentView);
                }
                this.mPopupView = null;
                if (this.mOnDismissListener != null) {
                    this.mOnDismissListener.onDismiss();
                }
            } catch (Throwable th) {
                Throwable th2 = th;
                if (this.mPopupView != this.mContentView && (this.mPopupView instanceof ViewGroup)) {
                    ((ViewGroup) this.mPopupView).removeView(this.mContentView);
                }
                this.mPopupView = null;
                if (this.mOnDismissListener != null) {
                    this.mOnDismissListener.onDismiss();
                }
            }
        }
    }

    public void setOnDismissListener(OnDismissListener onDismissListener) {
        this.mOnDismissListener = onDismissListener;
    }

    public void update() {
        if (isShowing() && this.mContentView != null) {
            LayoutParams p = (LayoutParams) this.mPopupView.getLayoutParams();
            boolean update = false;
            int newAnim = computeAnimationResource();
            if (newAnim != p.windowAnimations) {
                p.windowAnimations = newAnim;
                update = true;
            }
            int newFlags = computeFlags(p.flags);
            if (newFlags != p.flags) {
                p.flags = newFlags;
                update = true;
            }
            if (update) {
                setLayoutDirectionFromAnchor();
                this.mWindowManager.updateViewLayout(this.mPopupView, p);
            }
        }
    }

    public void update(int width, int height) {
        LayoutParams p = (LayoutParams) this.mPopupView.getLayoutParams();
        update(p.f95x, p.f96y, width, height, false);
    }

    public void update(int x, int y, int width, int height) {
        update(x, y, width, height, false);
    }

    public void update(int x, int y, int width, int height, boolean force) {
        if (width != -1) {
            this.mLastWidth = width;
            setWidth(width);
        }
        if (height != -1) {
            this.mLastHeight = height;
            setHeight(height);
        }
        if (isShowing() && this.mContentView != null) {
            LayoutParams p = (LayoutParams) this.mPopupView.getLayoutParams();
            boolean update = force;
            int finalWidth = this.mWidthMode < 0 ? this.mWidthMode : this.mLastWidth;
            if (!(width == -1 || p.width == finalWidth)) {
                this.mLastWidth = finalWidth;
                p.width = finalWidth;
                update = true;
            }
            int finalHeight = this.mHeightMode < 0 ? this.mHeightMode : this.mLastHeight;
            if (!(height == -1 || p.height == finalHeight)) {
                this.mLastHeight = finalHeight;
                p.height = finalHeight;
                update = true;
            }
            if (p.f95x != x) {
                p.f95x = x;
                update = true;
            }
            if (p.f96y != y) {
                p.f96y = y;
                update = true;
            }
            int newAnim = computeAnimationResource();
            if (newAnim != p.windowAnimations) {
                p.windowAnimations = newAnim;
                update = true;
            }
            int newFlags = computeFlags(p.flags);
            if (newFlags != p.flags) {
                p.flags = newFlags;
                update = true;
            }
            if (update) {
                setLayoutDirectionFromAnchor();
                this.mWindowManager.updateViewLayout(this.mPopupView, p);
            }
        }
    }

    public void update(View anchor, int width, int height) {
        update(anchor, false, INPUT_METHOD_FROM_FOCUSABLE, INPUT_METHOD_FROM_FOCUSABLE, true, width, height, this.mAnchoredGravity);
    }

    public void update(View anchor, int xoff, int yoff, int width, int height) {
        update(anchor, true, xoff, yoff, true, width, height, this.mAnchoredGravity);
    }

    private void update(View anchor, boolean updateLocation, int xoff, int yoff, boolean updateDimension, int width, int height, int gravity) {
        if (isShowing() && this.mContentView != null) {
            boolean z;
            WeakReference<View> oldAnchor = this.mAnchor;
            boolean needsUpdate = updateLocation && !(this.mAnchorXoff == xoff && this.mAnchorYoff == yoff);
            if (oldAnchor == null || oldAnchor.get() != anchor || (needsUpdate && !this.mIsDropdown)) {
                registerForScrollChanged(anchor, xoff, yoff, gravity);
            } else if (needsUpdate) {
                this.mAnchorXoff = xoff;
                this.mAnchorYoff = yoff;
                this.mAnchoredGravity = gravity;
            }
            LayoutParams p = (LayoutParams) this.mPopupView.getLayoutParams();
            if (updateDimension) {
                if (width == -1) {
                    width = this.mPopupWidth;
                } else {
                    this.mPopupWidth = width;
                }
                if (height == -1) {
                    height = this.mPopupHeight;
                } else {
                    this.mPopupHeight = height;
                }
            }
            int x = p.f95x;
            int y = p.f96y;
            if (updateLocation) {
                updateAboveAnchor(findDropDownPosition(anchor, p, xoff, yoff, gravity));
            } else {
                updateAboveAnchor(findDropDownPosition(anchor, p, this.mAnchorXoff, this.mAnchorYoff, this.mAnchoredGravity));
            }
            int i = p.f95x;
            int i2 = p.f96y;
            if (x == p.f95x && y == p.f96y) {
                z = false;
            } else {
                z = true;
            }
            update(i, i2, width, height, z);
        }
    }

    private void unregisterForScrollChanged() {
        WeakReference<View> anchorRef = this.mAnchor;
        View anchor = null;
        if (anchorRef != null) {
            anchor = (View) anchorRef.get();
        }
        if (anchor != null) {
            anchor.getViewTreeObserver().removeOnScrollChangedListener(this.mOnScrollChangedListener);
        }
        this.mAnchor = null;
    }

    private void registerForScrollChanged(View anchor, int xoff, int yoff, int gravity) {
        unregisterForScrollChanged();
        this.mAnchor = new WeakReference(anchor);
        ViewTreeObserver vto = anchor.getViewTreeObserver();
        if (vto != null) {
            vto.addOnScrollChangedListener(this.mOnScrollChangedListener);
        }
        this.mAnchorXoff = xoff;
        this.mAnchorYoff = yoff;
        this.mAnchoredGravity = gravity;
    }
}
