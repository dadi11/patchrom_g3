package android.widget;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.animation.ObjectAnimator;
import android.content.Context;
import android.content.res.TypedArray;
import android.database.DataSetObserver;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.os.Handler;
import android.os.SystemClock;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.util.IntProperty;
import android.util.Log;
import android.view.KeyEvent;
import android.view.KeyEvent.DispatcherState;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.MeasureSpec;
import android.view.View.OnAttachStateChangeListener;
import android.view.View.OnTouchListener;
import android.view.ViewConfiguration;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.view.WindowManager;
import android.view.animation.AccelerateDecelerateInterpolator;
import android.view.inputmethod.EditorInfo;
import android.widget.AbsListView.OnScrollListener;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.AdapterView.OnItemSelectedListener;
import android.widget.LinearLayout.LayoutParams;
import android.widget.PopupWindow.OnDismissListener;
import com.android.internal.R;
import com.android.internal.widget.AutoScrollHelper.AbsListViewAutoScroller;

public class ListPopupWindow {
    private static final boolean DEBUG = false;
    private static final int EXPAND_LIST_TIMEOUT = 250;
    public static final int INPUT_METHOD_FROM_FOCUSABLE = 0;
    public static final int INPUT_METHOD_NEEDED = 1;
    public static final int INPUT_METHOD_NOT_NEEDED = 2;
    public static final int MATCH_PARENT = -1;
    public static final int POSITION_PROMPT_ABOVE = 0;
    public static final int POSITION_PROMPT_BELOW = 1;
    private static final String TAG = "ListPopupWindow";
    public static final int WRAP_CONTENT = -2;
    private ListAdapter mAdapter;
    private Context mContext;
    private boolean mDropDownAlwaysVisible;
    private View mDropDownAnchorView;
    private int mDropDownGravity;
    private int mDropDownHeight;
    private int mDropDownHorizontalOffset;
    private DropDownListView mDropDownList;
    private Drawable mDropDownListHighlight;
    private int mDropDownVerticalOffset;
    private boolean mDropDownVerticalOffsetSet;
    private int mDropDownWidth;
    private boolean mForceIgnoreOutsideTouch;
    private Handler mHandler;
    private final ListSelectorHider mHideSelector;
    private OnItemClickListener mItemClickListener;
    private OnItemSelectedListener mItemSelectedListener;
    private int mLayoutDirection;
    int mListItemExpandMaximum;
    private boolean mModal;
    private DataSetObserver mObserver;
    private PopupWindow mPopup;
    private int mPromptPosition;
    private View mPromptView;
    private final ResizePopupRunnable mResizePopupRunnable;
    private final PopupScrollListener mScrollListener;
    private Runnable mShowDropDownRunnable;
    private Rect mTempRect;
    private final PopupTouchInterceptor mTouchInterceptor;

    public static abstract class ForwardingListener implements OnTouchListener, OnAttachStateChangeListener {
        private int mActivePointerId;
        private Runnable mDisallowIntercept;
        private boolean mForwarding;
        private final int mLongPressTimeout;
        private final float mScaledTouchSlop;
        private final View mSrc;
        private final int mTapTimeout;
        private Runnable mTriggerLongPress;
        private boolean mWasLongPress;

        private class DisallowIntercept implements Runnable {
            private DisallowIntercept() {
            }

            public void run() {
                ForwardingListener.this.mSrc.getParent().requestDisallowInterceptTouchEvent(true);
            }
        }

        private class TriggerLongPress implements Runnable {
            private TriggerLongPress() {
            }

            public void run() {
                ForwardingListener.this.onLongPress();
            }
        }

        public abstract ListPopupWindow getPopup();

        public ForwardingListener(View src) {
            this.mSrc = src;
            this.mScaledTouchSlop = (float) ViewConfiguration.get(src.getContext()).getScaledTouchSlop();
            this.mTapTimeout = ViewConfiguration.getTapTimeout();
            this.mLongPressTimeout = (this.mTapTimeout + ViewConfiguration.getLongPressTimeout()) / ListPopupWindow.INPUT_METHOD_NOT_NEEDED;
            src.addOnAttachStateChangeListener(this);
        }

        public boolean onTouch(View v, MotionEvent event) {
            boolean forwarding;
            boolean wasForwarding = this.mForwarding;
            if (!wasForwarding) {
                if (onTouchObserved(event) && onForwardingStarted()) {
                    forwarding = true;
                } else {
                    forwarding = ListPopupWindow.DEBUG;
                }
                if (forwarding) {
                    long now = SystemClock.uptimeMillis();
                    MotionEvent e = MotionEvent.obtain(now, now, 3, 0.0f, 0.0f, ListPopupWindow.POSITION_PROMPT_ABOVE);
                    this.mSrc.onTouchEvent(e);
                    e.recycle();
                }
            } else if (onTouchForwarded(event) || !onForwardingStopped()) {
                forwarding = true;
            } else {
                forwarding = ListPopupWindow.DEBUG;
            }
            this.mForwarding = forwarding;
            if (forwarding || wasForwarding) {
                return true;
            }
            return ListPopupWindow.DEBUG;
        }

        public void onViewAttachedToWindow(View v) {
        }

        public void onViewDetachedFromWindow(View v) {
            this.mForwarding = ListPopupWindow.DEBUG;
            this.mActivePointerId = ListPopupWindow.MATCH_PARENT;
            if (this.mDisallowIntercept != null) {
                this.mSrc.removeCallbacks(this.mDisallowIntercept);
            }
        }

        protected boolean onForwardingStarted() {
            ListPopupWindow popup = getPopup();
            if (!(popup == null || popup.isShowing())) {
                popup.show();
            }
            return true;
        }

        protected boolean onForwardingStopped() {
            ListPopupWindow popup = getPopup();
            if (popup != null && popup.isShowing()) {
                popup.dismiss();
            }
            return true;
        }

        private boolean onTouchObserved(MotionEvent srcEvent) {
            View src = this.mSrc;
            if (!src.isEnabled()) {
                return ListPopupWindow.DEBUG;
            }
            switch (srcEvent.getActionMasked()) {
                case ListPopupWindow.POSITION_PROMPT_ABOVE /*0*/:
                    this.mActivePointerId = srcEvent.getPointerId(ListPopupWindow.POSITION_PROMPT_ABOVE);
                    this.mWasLongPress = ListPopupWindow.DEBUG;
                    if (this.mDisallowIntercept == null) {
                        this.mDisallowIntercept = new DisallowIntercept();
                    }
                    src.postDelayed(this.mDisallowIntercept, (long) this.mTapTimeout);
                    if (this.mTriggerLongPress == null) {
                        this.mTriggerLongPress = new TriggerLongPress();
                    }
                    src.postDelayed(this.mTriggerLongPress, (long) this.mLongPressTimeout);
                    return ListPopupWindow.DEBUG;
                case ListPopupWindow.POSITION_PROMPT_BELOW /*1*/:
                case SetDrawableParameters.TAG /*3*/:
                    clearCallbacks();
                    return ListPopupWindow.DEBUG;
                case ListPopupWindow.INPUT_METHOD_NOT_NEEDED /*2*/:
                    int activePointerIndex = srcEvent.findPointerIndex(this.mActivePointerId);
                    if (activePointerIndex < 0 || src.pointInView(srcEvent.getX(activePointerIndex), srcEvent.getY(activePointerIndex), this.mScaledTouchSlop)) {
                        return ListPopupWindow.DEBUG;
                    }
                    clearCallbacks();
                    src.getParent().requestDisallowInterceptTouchEvent(true);
                    return true;
                default:
                    return ListPopupWindow.DEBUG;
            }
        }

        private void clearCallbacks() {
            if (this.mTriggerLongPress != null) {
                this.mSrc.removeCallbacks(this.mTriggerLongPress);
            }
            if (this.mDisallowIntercept != null) {
                this.mSrc.removeCallbacks(this.mDisallowIntercept);
            }
        }

        private void onLongPress() {
            clearCallbacks();
            View src = this.mSrc;
            if (src.isEnabled() && !src.isLongClickable() && onForwardingStarted()) {
                src.getParent().requestDisallowInterceptTouchEvent(true);
                long now = SystemClock.uptimeMillis();
                MotionEvent e = MotionEvent.obtain(now, now, 3, 0.0f, 0.0f, ListPopupWindow.POSITION_PROMPT_ABOVE);
                src.onTouchEvent(e);
                e.recycle();
                this.mForwarding = true;
                this.mWasLongPress = true;
            }
        }

        private boolean onTouchForwarded(MotionEvent srcEvent) {
            boolean z = true;
            View src = this.mSrc;
            ListPopupWindow popup = getPopup();
            if (popup == null || !popup.isShowing()) {
                return ListPopupWindow.DEBUG;
            }
            DropDownListView dst = popup.mDropDownList;
            if (dst == null || !dst.isShown()) {
                return ListPopupWindow.DEBUG;
            }
            MotionEvent dstEvent = MotionEvent.obtainNoHistory(srcEvent);
            src.toGlobalMotionEvent(dstEvent);
            dst.toLocalMotionEvent(dstEvent);
            boolean handled = dst.onForwardedEvent(dstEvent, this.mActivePointerId);
            dstEvent.recycle();
            int action = srcEvent.getActionMasked();
            boolean keepForwarding;
            if (action == ListPopupWindow.POSITION_PROMPT_BELOW || action == 3) {
                keepForwarding = ListPopupWindow.DEBUG;
            } else {
                keepForwarding = true;
            }
            if (!(handled && keepForwarding)) {
                z = ListPopupWindow.DEBUG;
            }
            return z;
        }
    }

    /* renamed from: android.widget.ListPopupWindow.1 */
    class C09961 extends ForwardingListener {
        C09961(View x0) {
            super(x0);
        }

        public ListPopupWindow getPopup() {
            return ListPopupWindow.this;
        }
    }

    /* renamed from: android.widget.ListPopupWindow.2 */
    class C09972 implements Runnable {
        C09972() {
        }

        public void run() {
            View view = ListPopupWindow.this.getAnchorView();
            if (view != null && view.getWindowToken() != null) {
                ListPopupWindow.this.show();
            }
        }
    }

    /* renamed from: android.widget.ListPopupWindow.3 */
    class C09983 implements OnItemSelectedListener {
        C09983() {
        }

        public void onItemSelected(AdapterView<?> adapterView, View view, int position, long id) {
            if (position != ListPopupWindow.MATCH_PARENT) {
                DropDownListView dropDownList = ListPopupWindow.this.mDropDownList;
                if (dropDownList != null) {
                    dropDownList.mListSelectionHidden = ListPopupWindow.DEBUG;
                }
            }
        }

        public void onNothingSelected(AdapterView<?> adapterView) {
        }
    }

    private static class DropDownListView extends ListView {
        private static final int CLICK_ANIM_ALPHA = 128;
        private static final long CLICK_ANIM_DURATION = 150;
        private static final IntProperty<Drawable> DRAWABLE_ALPHA;
        private Animator mClickAnimation;
        private boolean mDrawsInPressedState;
        private boolean mHijackFocus;
        private boolean mListSelectionHidden;
        private AbsListViewAutoScroller mScrollHelper;

        /* renamed from: android.widget.ListPopupWindow.DropDownListView.1 */
        static class C09991 extends IntProperty<Drawable> {
            C09991(String x0) {
                super(x0);
            }

            public void setValue(Drawable object, int value) {
                object.setAlpha(value);
            }

            public Integer get(Drawable object) {
                return Integer.valueOf(object.getAlpha());
            }
        }

        /* renamed from: android.widget.ListPopupWindow.DropDownListView.2 */
        class C10002 extends AnimatorListenerAdapter {
            final /* synthetic */ View val$child;
            final /* synthetic */ long val$id;
            final /* synthetic */ int val$position;

            C10002(View view, int i, long j) {
                this.val$child = view;
                this.val$position = i;
                this.val$id = j;
            }

            public void onAnimationEnd(Animator animation) {
                DropDownListView.this.performItemClick(this.val$child, this.val$position, this.val$id);
            }
        }

        static {
            DRAWABLE_ALPHA = new C09991("alpha");
        }

        public DropDownListView(Context context, boolean hijackFocus) {
            super(context, null, 16842861);
            this.mHijackFocus = hijackFocus;
            setCacheColorHint(ListPopupWindow.POSITION_PROMPT_ABOVE);
        }

        public boolean onForwardedEvent(MotionEvent event, int activePointerId) {
            boolean handledEvent = true;
            boolean clearPressedItem = ListPopupWindow.DEBUG;
            int actionMasked = event.getActionMasked();
            switch (actionMasked) {
                case ListPopupWindow.POSITION_PROMPT_BELOW /*1*/:
                    handledEvent = ListPopupWindow.DEBUG;
                    break;
                case ListPopupWindow.INPUT_METHOD_NOT_NEEDED /*2*/:
                    break;
                case SetDrawableParameters.TAG /*3*/:
                    handledEvent = ListPopupWindow.DEBUG;
                    break;
            }
            int activeIndex = event.findPointerIndex(activePointerId);
            if (activeIndex < 0) {
                handledEvent = ListPopupWindow.DEBUG;
            } else {
                int x = (int) event.getX(activeIndex);
                int y = (int) event.getY(activeIndex);
                int position = pointToPosition(x, y);
                if (position == ListPopupWindow.MATCH_PARENT) {
                    clearPressedItem = true;
                } else {
                    View child = getChildAt(position - getFirstVisiblePosition());
                    setPressedItem(child, position, (float) x, (float) y);
                    handledEvent = true;
                    if (actionMasked == ListPopupWindow.POSITION_PROMPT_BELOW) {
                        clickPressedItem(child, position);
                    }
                }
            }
            if (!handledEvent || clearPressedItem) {
                clearPressedItem();
            }
            if (handledEvent) {
                if (this.mScrollHelper == null) {
                    this.mScrollHelper = new AbsListViewAutoScroller(this);
                }
                this.mScrollHelper.setEnabled(true);
                this.mScrollHelper.onTouch(this, event);
            } else if (this.mScrollHelper != null) {
                this.mScrollHelper.setEnabled(ListPopupWindow.DEBUG);
            }
            return handledEvent;
        }

        private void clickPressedItem(View child, int position) {
            long id = getItemIdAtPosition(position);
            Animator anim = ObjectAnimator.ofInt(this.mSelector, DRAWABLE_ALPHA, new int[]{EditorInfo.IME_MASK_ACTION, CLICK_ANIM_ALPHA, EditorInfo.IME_MASK_ACTION});
            anim.setDuration(CLICK_ANIM_DURATION);
            anim.setInterpolator(new AccelerateDecelerateInterpolator());
            anim.addListener(new C10002(child, position, id));
            anim.start();
            if (this.mClickAnimation != null) {
                this.mClickAnimation.cancel();
            }
            this.mClickAnimation = anim;
        }

        private void clearPressedItem() {
            this.mDrawsInPressedState = ListPopupWindow.DEBUG;
            setPressed(ListPopupWindow.DEBUG);
            updateSelectorState();
            View motionView = getChildAt(this.mMotionPosition - this.mFirstPosition);
            if (motionView != null) {
                motionView.setPressed(ListPopupWindow.DEBUG);
            }
            if (this.mClickAnimation != null) {
                this.mClickAnimation.cancel();
                this.mClickAnimation = null;
            }
        }

        private void setPressedItem(View child, int position, float x, float y) {
            this.mDrawsInPressedState = true;
            drawableHotspotChanged(x, y);
            if (!isPressed()) {
                setPressed(true);
            }
            if (this.mDataChanged) {
                layoutChildren();
            }
            View motionView = getChildAt(this.mMotionPosition - this.mFirstPosition);
            if (!(motionView == null || motionView == child || !motionView.isPressed())) {
                motionView.setPressed(ListPopupWindow.DEBUG);
            }
            this.mMotionPosition = position;
            child.drawableHotspotChanged(x - ((float) child.getLeft()), y - ((float) child.getTop()));
            if (!child.isPressed()) {
                child.setPressed(true);
            }
            setSelectedPositionInt(position);
            positionSelectorLikeTouch(position, child, x, y);
            refreshDrawableState();
            if (this.mClickAnimation != null) {
                this.mClickAnimation.cancel();
                this.mClickAnimation = null;
            }
        }

        boolean touchModeDrawsInPressedState() {
            return (this.mDrawsInPressedState || super.touchModeDrawsInPressedState()) ? true : ListPopupWindow.DEBUG;
        }

        View obtainView(int position, boolean[] isScrap) {
            View view = super.obtainView(position, isScrap);
            if (view instanceof TextView) {
                ((TextView) view).setHorizontallyScrolling(true);
            }
            return view;
        }

        public boolean isInTouchMode() {
            return ((this.mHijackFocus && this.mListSelectionHidden) || super.isInTouchMode()) ? true : ListPopupWindow.DEBUG;
        }

        public boolean hasWindowFocus() {
            return (this.mHijackFocus || super.hasWindowFocus()) ? true : ListPopupWindow.DEBUG;
        }

        public boolean isFocused() {
            return (this.mHijackFocus || super.isFocused()) ? true : ListPopupWindow.DEBUG;
        }

        public boolean hasFocus() {
            return (this.mHijackFocus || super.hasFocus()) ? true : ListPopupWindow.DEBUG;
        }
    }

    private class ListSelectorHider implements Runnable {
        private ListSelectorHider() {
        }

        public void run() {
            ListPopupWindow.this.clearListSelection();
        }
    }

    private class PopupDataSetObserver extends DataSetObserver {
        private PopupDataSetObserver() {
        }

        public void onChanged() {
            if (ListPopupWindow.this.isShowing()) {
                ListPopupWindow.this.show();
            }
        }

        public void onInvalidated() {
            ListPopupWindow.this.dismiss();
        }
    }

    private class PopupScrollListener implements OnScrollListener {
        private PopupScrollListener() {
        }

        public void onScroll(AbsListView view, int firstVisibleItem, int visibleItemCount, int totalItemCount) {
        }

        public void onScrollStateChanged(AbsListView view, int scrollState) {
            if (scrollState == ListPopupWindow.POSITION_PROMPT_BELOW && !ListPopupWindow.this.isInputMethodNotNeeded() && ListPopupWindow.this.mPopup.getContentView() != null) {
                ListPopupWindow.this.mHandler.removeCallbacks(ListPopupWindow.this.mResizePopupRunnable);
                ListPopupWindow.this.mResizePopupRunnable.run();
            }
        }
    }

    private class PopupTouchInterceptor implements OnTouchListener {
        private PopupTouchInterceptor() {
        }

        public boolean onTouch(View v, MotionEvent event) {
            int action = event.getAction();
            int x = (int) event.getX();
            int y = (int) event.getY();
            if (action == 0 && ListPopupWindow.this.mPopup != null && ListPopupWindow.this.mPopup.isShowing() && x >= 0 && x < ListPopupWindow.this.mPopup.getWidth() && y >= 0 && y < ListPopupWindow.this.mPopup.getHeight()) {
                ListPopupWindow.this.mHandler.postDelayed(ListPopupWindow.this.mResizePopupRunnable, 250);
            } else if (action == ListPopupWindow.POSITION_PROMPT_BELOW) {
                ListPopupWindow.this.mHandler.removeCallbacks(ListPopupWindow.this.mResizePopupRunnable);
            }
            return ListPopupWindow.DEBUG;
        }
    }

    private class ResizePopupRunnable implements Runnable {
        private ResizePopupRunnable() {
        }

        public void run() {
            if (ListPopupWindow.this.mDropDownList != null && ListPopupWindow.this.mDropDownList.getCount() > ListPopupWindow.this.mDropDownList.getChildCount() && ListPopupWindow.this.mDropDownList.getChildCount() <= ListPopupWindow.this.mListItemExpandMaximum) {
                ListPopupWindow.this.mPopup.setInputMethodMode(ListPopupWindow.INPUT_METHOD_NOT_NEEDED);
                ListPopupWindow.this.show();
            }
        }
    }

    public ListPopupWindow(Context context) {
        this(context, null, 16843519, POSITION_PROMPT_ABOVE);
    }

    public ListPopupWindow(Context context, AttributeSet attrs) {
        this(context, attrs, 16843519, POSITION_PROMPT_ABOVE);
    }

    public ListPopupWindow(Context context, AttributeSet attrs, int defStyleAttr) {
        this(context, attrs, defStyleAttr, POSITION_PROMPT_ABOVE);
    }

    public ListPopupWindow(Context context, AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        this.mDropDownHeight = WRAP_CONTENT;
        this.mDropDownWidth = WRAP_CONTENT;
        this.mDropDownGravity = POSITION_PROMPT_ABOVE;
        this.mDropDownAlwaysVisible = DEBUG;
        this.mForceIgnoreOutsideTouch = DEBUG;
        this.mListItemExpandMaximum = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
        this.mPromptPosition = POSITION_PROMPT_ABOVE;
        this.mResizePopupRunnable = new ResizePopupRunnable();
        this.mTouchInterceptor = new PopupTouchInterceptor();
        this.mScrollListener = new PopupScrollListener();
        this.mHideSelector = new ListSelectorHider();
        this.mHandler = new Handler();
        this.mTempRect = new Rect();
        this.mContext = context;
        TypedArray a = context.obtainStyledAttributes(attrs, R.styleable.ListPopupWindow, defStyleAttr, defStyleRes);
        this.mDropDownHorizontalOffset = a.getDimensionPixelOffset(POSITION_PROMPT_ABOVE, POSITION_PROMPT_ABOVE);
        this.mDropDownVerticalOffset = a.getDimensionPixelOffset(POSITION_PROMPT_BELOW, POSITION_PROMPT_ABOVE);
        if (this.mDropDownVerticalOffset != 0) {
            this.mDropDownVerticalOffsetSet = true;
        }
        a.recycle();
        this.mPopup = new PopupWindow(context, attrs, defStyleAttr, defStyleRes);
        this.mPopup.setInputMethodMode(POSITION_PROMPT_BELOW);
        this.mLayoutDirection = TextUtils.getLayoutDirectionFromLocale(this.mContext.getResources().getConfiguration().locale);
    }

    public void setAdapter(ListAdapter adapter) {
        if (this.mObserver == null) {
            this.mObserver = new PopupDataSetObserver();
        } else if (this.mAdapter != null) {
            this.mAdapter.unregisterDataSetObserver(this.mObserver);
        }
        this.mAdapter = adapter;
        if (this.mAdapter != null) {
            adapter.registerDataSetObserver(this.mObserver);
        }
        if (this.mDropDownList != null) {
            this.mDropDownList.setAdapter(this.mAdapter);
        }
    }

    public void setPromptPosition(int position) {
        this.mPromptPosition = position;
    }

    public int getPromptPosition() {
        return this.mPromptPosition;
    }

    public void setModal(boolean modal) {
        this.mModal = modal;
        this.mPopup.setFocusable(modal);
    }

    public boolean isModal() {
        return this.mModal;
    }

    public void setForceIgnoreOutsideTouch(boolean forceIgnoreOutsideTouch) {
        this.mForceIgnoreOutsideTouch = forceIgnoreOutsideTouch;
    }

    public void setDropDownAlwaysVisible(boolean dropDownAlwaysVisible) {
        this.mDropDownAlwaysVisible = dropDownAlwaysVisible;
    }

    public boolean isDropDownAlwaysVisible() {
        return this.mDropDownAlwaysVisible;
    }

    public void setSoftInputMode(int mode) {
        this.mPopup.setSoftInputMode(mode);
    }

    public int getSoftInputMode() {
        return this.mPopup.getSoftInputMode();
    }

    public void setListSelector(Drawable selector) {
        this.mDropDownListHighlight = selector;
    }

    public Drawable getBackground() {
        return this.mPopup.getBackground();
    }

    public void setBackgroundDrawable(Drawable d) {
        this.mPopup.setBackgroundDrawable(d);
    }

    public void setAnimationStyle(int animationStyle) {
        this.mPopup.setAnimationStyle(animationStyle);
    }

    public int getAnimationStyle() {
        return this.mPopup.getAnimationStyle();
    }

    public View getAnchorView() {
        return this.mDropDownAnchorView;
    }

    public void setAnchorView(View anchor) {
        this.mDropDownAnchorView = anchor;
    }

    public int getHorizontalOffset() {
        return this.mDropDownHorizontalOffset;
    }

    public void setHorizontalOffset(int offset) {
        this.mDropDownHorizontalOffset = offset;
    }

    public int getVerticalOffset() {
        if (this.mDropDownVerticalOffsetSet) {
            return this.mDropDownVerticalOffset;
        }
        return POSITION_PROMPT_ABOVE;
    }

    public void setVerticalOffset(int offset) {
        this.mDropDownVerticalOffset = offset;
        this.mDropDownVerticalOffsetSet = true;
    }

    public void setDropDownGravity(int gravity) {
        this.mDropDownGravity = gravity;
    }

    public int getWidth() {
        return this.mDropDownWidth;
    }

    public void setWidth(int width) {
        this.mDropDownWidth = width;
    }

    public void setContentWidth(int width) {
        Drawable popupBackground = this.mPopup.getBackground();
        if (popupBackground != null) {
            popupBackground.getPadding(this.mTempRect);
            this.mDropDownWidth = (this.mTempRect.left + this.mTempRect.right) + width;
            return;
        }
        setWidth(width);
    }

    public int getHeight() {
        return this.mDropDownHeight;
    }

    public void setHeight(int height) {
        this.mDropDownHeight = height;
    }

    public void setOnItemClickListener(OnItemClickListener clickListener) {
        this.mItemClickListener = clickListener;
    }

    public void setOnItemSelectedListener(OnItemSelectedListener selectedListener) {
        this.mItemSelectedListener = selectedListener;
    }

    public void setPromptView(View prompt) {
        boolean showing = isShowing();
        if (showing) {
            removePromptView();
        }
        this.mPromptView = prompt;
        if (showing) {
            show();
        }
    }

    public void postShow() {
        this.mHandler.post(this.mShowDropDownRunnable);
    }

    public void show() {
        boolean z = true;
        int height = buildDropDown();
        int widthSpec = POSITION_PROMPT_ABOVE;
        int heightSpec = POSITION_PROMPT_ABOVE;
        boolean noInputMethod = isInputMethodNotNeeded();
        this.mPopup.setAllowScrollingAnchorParent(!noInputMethod ? true : DEBUG);
        if (this.mPopup.isShowing()) {
            if (this.mDropDownWidth == MATCH_PARENT) {
                widthSpec = MATCH_PARENT;
            } else if (this.mDropDownWidth == WRAP_CONTENT) {
                widthSpec = getAnchorView().getWidth();
            } else {
                widthSpec = this.mDropDownWidth;
            }
            if (this.mDropDownHeight == MATCH_PARENT) {
                if (noInputMethod) {
                    heightSpec = height;
                } else {
                    heightSpec = MATCH_PARENT;
                }
                if (noInputMethod) {
                    int i;
                    PopupWindow popupWindow = this.mPopup;
                    if (this.mDropDownWidth == MATCH_PARENT) {
                        i = MATCH_PARENT;
                    } else {
                        i = POSITION_PROMPT_ABOVE;
                    }
                    popupWindow.setWindowLayoutMode(i, POSITION_PROMPT_ABOVE);
                } else {
                    this.mPopup.setWindowLayoutMode(this.mDropDownWidth == MATCH_PARENT ? MATCH_PARENT : POSITION_PROMPT_ABOVE, MATCH_PARENT);
                }
            } else if (this.mDropDownHeight == WRAP_CONTENT) {
                heightSpec = height;
            } else {
                heightSpec = this.mDropDownHeight;
            }
            PopupWindow popupWindow2 = this.mPopup;
            if (this.mForceIgnoreOutsideTouch || this.mDropDownAlwaysVisible) {
                z = DEBUG;
            }
            popupWindow2.setOutsideTouchable(z);
            this.mPopup.update(getAnchorView(), this.mDropDownHorizontalOffset, this.mDropDownVerticalOffset, widthSpec, heightSpec);
            return;
        }
        if (this.mDropDownWidth == MATCH_PARENT) {
            widthSpec = MATCH_PARENT;
        } else if (this.mDropDownWidth == WRAP_CONTENT) {
            this.mPopup.setWidth(getAnchorView().getWidth());
        } else {
            this.mPopup.setWidth(this.mDropDownWidth);
        }
        if (this.mDropDownHeight == MATCH_PARENT) {
            heightSpec = MATCH_PARENT;
        } else if (this.mDropDownHeight == WRAP_CONTENT) {
            this.mPopup.setHeight(height);
        } else {
            this.mPopup.setHeight(this.mDropDownHeight);
        }
        this.mPopup.setWindowLayoutMode(widthSpec, heightSpec);
        this.mPopup.setClipToScreenEnabled(true);
        popupWindow2 = this.mPopup;
        if (this.mForceIgnoreOutsideTouch || this.mDropDownAlwaysVisible) {
            z = DEBUG;
        }
        popupWindow2.setOutsideTouchable(z);
        this.mPopup.setTouchInterceptor(this.mTouchInterceptor);
        this.mPopup.showAsDropDown(getAnchorView(), this.mDropDownHorizontalOffset, this.mDropDownVerticalOffset, this.mDropDownGravity);
        this.mDropDownList.setSelection(MATCH_PARENT);
        if (!this.mModal || this.mDropDownList.isInTouchMode()) {
            clearListSelection();
        }
        if (!this.mModal) {
            this.mHandler.post(this.mHideSelector);
        }
    }

    public void dismiss() {
        this.mPopup.dismiss();
        removePromptView();
        this.mPopup.setContentView(null);
        this.mDropDownList = null;
        this.mHandler.removeCallbacks(this.mResizePopupRunnable);
    }

    public void setOnDismissListener(OnDismissListener listener) {
        this.mPopup.setOnDismissListener(listener);
    }

    private void removePromptView() {
        if (this.mPromptView != null) {
            ViewParent parent = this.mPromptView.getParent();
            if (parent instanceof ViewGroup) {
                ((ViewGroup) parent).removeView(this.mPromptView);
            }
        }
    }

    public void setInputMethodMode(int mode) {
        this.mPopup.setInputMethodMode(mode);
    }

    public int getInputMethodMode() {
        return this.mPopup.getInputMethodMode();
    }

    public void setSelection(int position) {
        DropDownListView list = this.mDropDownList;
        if (isShowing() && list != null) {
            list.mListSelectionHidden = DEBUG;
            list.setSelection(position);
            if (list.getChoiceMode() != 0) {
                list.setItemChecked(position, true);
            }
        }
    }

    public void clearListSelection() {
        DropDownListView list = this.mDropDownList;
        if (list != null) {
            list.mListSelectionHidden = true;
            list.hideSelector();
            list.requestLayout();
        }
    }

    public boolean isShowing() {
        return this.mPopup.isShowing();
    }

    public boolean isInputMethodNotNeeded() {
        return this.mPopup.getInputMethodMode() == INPUT_METHOD_NOT_NEEDED ? true : DEBUG;
    }

    public boolean performItemClick(int position) {
        if (!isShowing()) {
            return DEBUG;
        }
        if (this.mItemClickListener != null) {
            DropDownListView list = this.mDropDownList;
            int i = position;
            this.mItemClickListener.onItemClick(list, list.getChildAt(position - list.getFirstVisiblePosition()), i, list.getAdapter().getItemId(position));
        }
        return true;
    }

    public Object getSelectedItem() {
        if (isShowing()) {
            return this.mDropDownList.getSelectedItem();
        }
        return null;
    }

    public int getSelectedItemPosition() {
        if (isShowing()) {
            return this.mDropDownList.getSelectedItemPosition();
        }
        return MATCH_PARENT;
    }

    public long getSelectedItemId() {
        if (isShowing()) {
            return this.mDropDownList.getSelectedItemId();
        }
        return Long.MIN_VALUE;
    }

    public View getSelectedView() {
        if (isShowing()) {
            return this.mDropDownList.getSelectedView();
        }
        return null;
    }

    public ListView getListView() {
        return this.mDropDownList;
    }

    void setListItemExpandMax(int max) {
        this.mListItemExpandMaximum = max;
    }

    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (isShowing() && keyCode != 62 && (this.mDropDownList.getSelectedItemPosition() >= 0 || !KeyEvent.isConfirmKey(keyCode))) {
            boolean below;
            int curIndex = this.mDropDownList.getSelectedItemPosition();
            if (this.mPopup.isAboveAnchor()) {
                below = DEBUG;
            } else {
                below = true;
            }
            ListAdapter adapter = this.mAdapter;
            int firstItem = ActivityChooserViewAdapter.MAX_ACTIVITY_COUNT_UNLIMITED;
            int lastItem = RtlSpacingHelper.UNDEFINED;
            if (adapter != null) {
                boolean allEnabled = adapter.areAllItemsEnabled();
                firstItem = allEnabled ? POSITION_PROMPT_ABOVE : this.mDropDownList.lookForSelectablePosition(POSITION_PROMPT_ABOVE, true);
                if (allEnabled) {
                    lastItem = adapter.getCount() + MATCH_PARENT;
                } else {
                    lastItem = this.mDropDownList.lookForSelectablePosition(adapter.getCount() + MATCH_PARENT, DEBUG);
                }
            }
            if (!(below && keyCode == 19 && curIndex <= firstItem) && (below || keyCode != 20 || curIndex < lastItem)) {
                this.mDropDownList.mListSelectionHidden = DEBUG;
                if (this.mDropDownList.onKeyDown(keyCode, event)) {
                    this.mPopup.setInputMethodMode(INPUT_METHOD_NOT_NEEDED);
                    this.mDropDownList.requestFocusFromTouch();
                    show();
                    switch (keyCode) {
                        case RelativeLayout.ALIGN_END /*19*/:
                        case RelativeLayout.ALIGN_PARENT_START /*20*/:
                        case MotionEvent.AXIS_BRAKE /*23*/:
                        case KeyEvent.KEYCODE_ENTER /*66*/:
                            return true;
                    }
                } else if (below && keyCode == 20) {
                    if (curIndex == lastItem) {
                        return true;
                    }
                } else if (!below && keyCode == 19 && curIndex == firstItem) {
                    return true;
                }
            }
            clearListSelection();
            this.mPopup.setInputMethodMode(POSITION_PROMPT_BELOW);
            show();
            return true;
        }
        return DEBUG;
    }

    public boolean onKeyUp(int keyCode, KeyEvent event) {
        if (!isShowing() || this.mDropDownList.getSelectedItemPosition() < 0) {
            return DEBUG;
        }
        boolean consumed = this.mDropDownList.onKeyUp(keyCode, event);
        if (!consumed || !KeyEvent.isConfirmKey(keyCode)) {
            return consumed;
        }
        dismiss();
        return consumed;
    }

    public boolean onKeyPreIme(int keyCode, KeyEvent event) {
        if (keyCode == 4 && isShowing()) {
            View anchorView = this.mDropDownAnchorView;
            DispatcherState state;
            if (event.getAction() == 0 && event.getRepeatCount() == 0) {
                state = anchorView.getKeyDispatcherState();
                if (state == null) {
                    return true;
                }
                state.startTracking(event, this);
                return true;
            } else if (event.getAction() == POSITION_PROMPT_BELOW) {
                state = anchorView.getKeyDispatcherState();
                if (state != null) {
                    state.handleUpEvent(event);
                }
                if (event.isTracking() && !event.isCanceled()) {
                    dismiss();
                    return true;
                }
            }
        }
        return DEBUG;
    }

    public OnTouchListener createDragToOpenListener(View src) {
        return new C09961(src);
    }

    private int buildDropDown() {
        int otherHeights = POSITION_PROMPT_ABOVE;
        ViewGroup dropDownView;
        LayoutParams hintParams;
        if (this.mDropDownList == null) {
            Context context = this.mContext;
            this.mShowDropDownRunnable = new C09972();
            this.mDropDownList = new DropDownListView(context, !this.mModal ? true : DEBUG);
            if (this.mDropDownListHighlight != null) {
                this.mDropDownList.setSelector(this.mDropDownListHighlight);
            }
            this.mDropDownList.setAdapter(this.mAdapter);
            this.mDropDownList.setOnItemClickListener(this.mItemClickListener);
            this.mDropDownList.setFocusable(true);
            this.mDropDownList.setFocusableInTouchMode(true);
            this.mDropDownList.setOnItemSelectedListener(new C09983());
            this.mDropDownList.setOnScrollListener(this.mScrollListener);
            if (this.mItemSelectedListener != null) {
                this.mDropDownList.setOnItemSelectedListener(this.mItemSelectedListener);
            }
            dropDownView = this.mDropDownList;
            View hintView = this.mPromptView;
            if (hintView != null) {
                ViewGroup hintContainer = new LinearLayout(context);
                hintContainer.setOrientation(POSITION_PROMPT_BELOW);
                hintParams = new LayoutParams(MATCH_PARENT, POSITION_PROMPT_ABOVE, WindowManager.LayoutParams.BRIGHTNESS_OVERRIDE_FULL);
                switch (this.mPromptPosition) {
                    case POSITION_PROMPT_ABOVE /*0*/:
                        hintContainer.addView(hintView);
                        hintContainer.addView((View) dropDownView, (ViewGroup.LayoutParams) hintParams);
                        break;
                    case POSITION_PROMPT_BELOW /*1*/:
                        hintContainer.addView((View) dropDownView, (ViewGroup.LayoutParams) hintParams);
                        hintContainer.addView(hintView);
                        break;
                    default:
                        Log.e(TAG, "Invalid hint position " + this.mPromptPosition);
                        break;
                }
                hintView.measure(MeasureSpec.makeMeasureSpec(this.mDropDownWidth, RtlSpacingHelper.UNDEFINED), POSITION_PROMPT_ABOVE);
                hintParams = (LayoutParams) hintView.getLayoutParams();
                otherHeights = (hintView.getMeasuredHeight() + hintParams.topMargin) + hintParams.bottomMargin;
                dropDownView = hintContainer;
            }
            this.mPopup.setContentView(dropDownView);
        } else {
            dropDownView = (ViewGroup) this.mPopup.getContentView();
            View view = this.mPromptView;
            if (view != null) {
                hintParams = (LayoutParams) view.getLayoutParams();
                otherHeights = (view.getMeasuredHeight() + hintParams.topMargin) + hintParams.bottomMargin;
            }
        }
        int padding = POSITION_PROMPT_ABOVE;
        Drawable background = this.mPopup.getBackground();
        if (background != null) {
            background.getPadding(this.mTempRect);
            padding = this.mTempRect.top + this.mTempRect.bottom;
            if (!this.mDropDownVerticalOffsetSet) {
                this.mDropDownVerticalOffset = -this.mTempRect.top;
            }
        } else {
            this.mTempRect.setEmpty();
        }
        int maxHeight = this.mPopup.getMaxAvailableHeight(getAnchorView(), this.mDropDownVerticalOffset, this.mPopup.getInputMethodMode() == INPUT_METHOD_NOT_NEEDED ? true : DEBUG);
        if (this.mDropDownAlwaysVisible || this.mDropDownHeight == MATCH_PARENT) {
            return maxHeight + padding;
        }
        int childWidthSpec;
        switch (this.mDropDownWidth) {
            case WRAP_CONTENT /*-2*/:
                childWidthSpec = MeasureSpec.makeMeasureSpec(this.mContext.getResources().getDisplayMetrics().widthPixels - (this.mTempRect.left + this.mTempRect.right), RtlSpacingHelper.UNDEFINED);
                break;
            case MATCH_PARENT /*-1*/:
                childWidthSpec = MeasureSpec.makeMeasureSpec(this.mContext.getResources().getDisplayMetrics().widthPixels - (this.mTempRect.left + this.mTempRect.right), EditorInfo.IME_FLAG_NO_ENTER_ACTION);
                break;
            default:
                childWidthSpec = MeasureSpec.makeMeasureSpec(this.mDropDownWidth, EditorInfo.IME_FLAG_NO_ENTER_ACTION);
                break;
        }
        int listContent = this.mDropDownList.measureHeightOfChildren(childWidthSpec, POSITION_PROMPT_ABOVE, MATCH_PARENT, maxHeight - otherHeights, MATCH_PARENT);
        if (listContent > 0) {
            otherHeights += padding;
        }
        return listContent + otherHeights;
    }
}
