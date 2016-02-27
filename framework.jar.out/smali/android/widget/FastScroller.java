package android.widget;

import android.animation.Animator;
import android.animation.Animator.AnimatorListener;
import android.animation.AnimatorListenerAdapter;
import android.animation.AnimatorSet;
import android.animation.AnimatorSet.Builder;
import android.animation.ObjectAnimator;
import android.animation.PropertyValuesHolder;
import android.content.Context;
import android.content.res.ColorStateList;
import android.content.res.TypedArray;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.os.SystemClock;
import android.text.TextUtils;
import android.text.TextUtils.TruncateAt;
import android.util.IntProperty;
import android.util.MathUtils;
import android.util.Property;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.MeasureSpec;
import android.view.ViewConfiguration;
import android.view.ViewGroup.LayoutParams;
import android.view.ViewGroupOverlay;
import android.view.WindowManager;
import android.view.WindowManagerPolicy;
import android.widget.ImageView.ScaleType;
import com.android.internal.R;

class FastScroller {
    private static Property<View, Integer> BOTTOM = null;
    private static final int DURATION_CROSS_FADE = 50;
    private static final int DURATION_FADE_IN = 150;
    private static final int DURATION_FADE_OUT = 300;
    private static final int DURATION_RESIZE = 100;
    private static final long FADE_TIMEOUT = 1500;
    private static Property<View, Integer> LEFT = null;
    private static final int MIN_PAGES = 4;
    private static final int OVERLAY_ABOVE_THUMB = 2;
    private static final int OVERLAY_AT_THUMB = 1;
    private static final int OVERLAY_FLOATING = 0;
    private static final int PREVIEW_LEFT = 0;
    private static final int PREVIEW_RIGHT = 1;
    private static Property<View, Integer> RIGHT = null;
    private static final int STATE_DRAGGING = 2;
    private static final int STATE_NONE = 0;
    private static final int STATE_VISIBLE = 1;
    private static final long TAP_TIMEOUT;
    private static Property<View, Integer> TOP;
    private boolean mAlwaysShow;
    private final Rect mContainerRect;
    private int mCurrentSection;
    private AnimatorSet mDecorAnimation;
    private final Runnable mDeferHide;
    private boolean mEnabled;
    private int mFirstVisibleItem;
    private int mHeaderCount;
    private float mInitialTouchY;
    private boolean mLayoutFromRight;
    private final AbsListView mList;
    private Adapter mListAdapter;
    private boolean mLongList;
    private boolean mMatchDragPosition;
    private final int mMinimumTouchTarget;
    private int mOldChildCount;
    private int mOldItemCount;
    private final ViewGroupOverlay mOverlay;
    private int mOverlayPosition;
    private long mPendingDrag;
    private AnimatorSet mPreviewAnimation;
    private final View mPreviewImage;
    private int mPreviewMinHeight;
    private int mPreviewMinWidth;
    private int mPreviewPadding;
    private final int[] mPreviewResId;
    private final TextView mPrimaryText;
    private int mScaledTouchSlop;
    private int mScrollBarStyle;
    private boolean mScrollCompleted;
    private int mScrollbarPosition;
    private final TextView mSecondaryText;
    private SectionIndexer mSectionIndexer;
    private Object[] mSections;
    private boolean mShowingPreview;
    private boolean mShowingPrimary;
    private int mState;
    private final AnimatorListener mSwitchPrimaryListener;
    private final Rect mTempBounds;
    private final Rect mTempMargins;
    private int mTextAppearance;
    private ColorStateList mTextColor;
    private float mTextSize;
    private Drawable mThumbDrawable;
    private final ImageView mThumbImage;
    private int mThumbMinHeight;
    private int mThumbMinWidth;
    private Drawable mTrackDrawable;
    private final ImageView mTrackImage;
    private boolean mUpdatingLayout;
    private int mWidth;

    /* renamed from: android.widget.FastScroller.1 */
    class C09761 implements Runnable {
        C09761() {
        }

        public void run() {
            FastScroller.this.setState(FastScroller.STATE_NONE);
        }
    }

    /* renamed from: android.widget.FastScroller.2 */
    class C09772 extends AnimatorListenerAdapter {
        C09772() {
        }

        public void onAnimationEnd(Animator animation) {
            FastScroller.this.mShowingPrimary = !FastScroller.this.mShowingPrimary;
        }
    }

    /* renamed from: android.widget.FastScroller.3 */
    static class C09783 extends IntProperty<View> {
        C09783(String x0) {
            super(x0);
        }

        public void setValue(View object, int value) {
            object.setLeft(value);
        }

        public Integer get(View object) {
            return Integer.valueOf(object.getLeft());
        }
    }

    /* renamed from: android.widget.FastScroller.4 */
    static class C09794 extends IntProperty<View> {
        C09794(String x0) {
            super(x0);
        }

        public void setValue(View object, int value) {
            object.setTop(value);
        }

        public Integer get(View object) {
            return Integer.valueOf(object.getTop());
        }
    }

    /* renamed from: android.widget.FastScroller.5 */
    static class C09805 extends IntProperty<View> {
        C09805(String x0) {
            super(x0);
        }

        public void setValue(View object, int value) {
            object.setRight(value);
        }

        public Integer get(View object) {
            return Integer.valueOf(object.getRight());
        }
    }

    /* renamed from: android.widget.FastScroller.6 */
    static class C09816 extends IntProperty<View> {
        C09816(String x0) {
            super(x0);
        }

        public void setValue(View object, int value) {
            object.setBottom(value);
        }

        public Integer get(View object) {
            return Integer.valueOf(object.getBottom());
        }
    }

    static {
        TAP_TIMEOUT = (long) ViewConfiguration.getTapTimeout();
        LEFT = new C09783("left");
        TOP = new C09794("top");
        RIGHT = new C09805("right");
        BOTTOM = new C09816("bottom");
    }

    public FastScroller(AbsListView listView, int styleResId) {
        boolean z = true;
        this.mTempBounds = new Rect();
        this.mTempMargins = new Rect();
        this.mContainerRect = new Rect();
        this.mPreviewResId = new int[STATE_DRAGGING];
        this.mCurrentSection = -1;
        this.mScrollbarPosition = -1;
        this.mPendingDrag = -1;
        this.mDeferHide = new C09761();
        this.mSwitchPrimaryListener = new C09772();
        this.mList = listView;
        this.mOldItemCount = listView.getCount();
        this.mOldChildCount = listView.getChildCount();
        Context context = listView.getContext();
        this.mScaledTouchSlop = ViewConfiguration.get(context).getScaledTouchSlop();
        this.mScrollBarStyle = listView.getScrollBarStyle();
        this.mScrollCompleted = true;
        this.mState = STATE_VISIBLE;
        if (context.getApplicationInfo().targetSdkVersion < 11) {
            z = false;
        }
        this.mMatchDragPosition = z;
        this.mTrackImage = new ImageView(context);
        this.mTrackImage.setScaleType(ScaleType.FIT_XY);
        this.mThumbImage = new ImageView(context);
        this.mThumbImage.setScaleType(ScaleType.FIT_XY);
        this.mPreviewImage = new View(context);
        this.mPreviewImage.setAlpha(0.0f);
        this.mPrimaryText = createPreviewTextView(context);
        this.mSecondaryText = createPreviewTextView(context);
        this.mMinimumTouchTarget = listView.getResources().getDimensionPixelSize(17105052);
        setStyle(styleResId);
        ViewGroupOverlay overlay = listView.getOverlay();
        this.mOverlay = overlay;
        overlay.add(this.mTrackImage);
        overlay.add(this.mThumbImage);
        overlay.add(this.mPreviewImage);
        overlay.add(this.mPrimaryText);
        overlay.add(this.mSecondaryText);
        getSectionsFromIndexer();
        updateLongList(this.mOldChildCount, this.mOldItemCount);
        setScrollbarPosition(listView.getVerticalScrollbarPosition());
        postAutoHide();
    }

    private void updateAppearance() {
        Context context = this.mList.getContext();
        int width = STATE_NONE;
        this.mTrackImage.setImageDrawable(this.mTrackDrawable);
        if (this.mTrackDrawable != null) {
            width = Math.max(STATE_NONE, this.mTrackDrawable.getIntrinsicWidth());
        }
        this.mThumbImage.setImageDrawable(this.mThumbDrawable);
        this.mThumbImage.setMinimumWidth(this.mThumbMinWidth);
        this.mThumbImage.setMinimumHeight(this.mThumbMinHeight);
        if (this.mThumbDrawable != null) {
            width = Math.max(width, this.mThumbDrawable.getIntrinsicWidth());
        }
        this.mWidth = Math.max(width, this.mThumbMinWidth);
        this.mPreviewImage.setMinimumWidth(this.mPreviewMinWidth);
        this.mPreviewImage.setMinimumHeight(this.mPreviewMinHeight);
        if (this.mTextAppearance != 0) {
            this.mPrimaryText.setTextAppearance(context, this.mTextAppearance);
            this.mSecondaryText.setTextAppearance(context, this.mTextAppearance);
        }
        if (this.mTextColor != null) {
            this.mPrimaryText.setTextColor(this.mTextColor);
            this.mSecondaryText.setTextColor(this.mTextColor);
        }
        if (this.mTextSize > 0.0f) {
            this.mPrimaryText.setTextSize(STATE_NONE, this.mTextSize);
            this.mSecondaryText.setTextSize(STATE_NONE, this.mTextSize);
        }
        int textMinSize = Math.max(STATE_NONE, this.mPreviewMinHeight);
        this.mPrimaryText.setMinimumWidth(textMinSize);
        this.mPrimaryText.setMinimumHeight(textMinSize);
        this.mPrimaryText.setIncludeFontPadding(false);
        this.mSecondaryText.setMinimumWidth(textMinSize);
        this.mSecondaryText.setMinimumHeight(textMinSize);
        this.mSecondaryText.setIncludeFontPadding(false);
        refreshDrawablePressedState();
    }

    public void setStyle(int resId) {
        TypedArray ta = this.mList.getContext().obtainStyledAttributes(null, R.styleable.FastScroll, 16843767, resId);
        int N = ta.getIndexCount();
        for (int i = STATE_NONE; i < N; i += STATE_VISIBLE) {
            int index = ta.getIndex(i);
            switch (index) {
                case STATE_NONE /*0*/:
                    this.mTextAppearance = ta.getResourceId(index, STATE_NONE);
                    break;
                case STATE_VISIBLE /*1*/:
                    this.mTextSize = (float) ta.getDimensionPixelSize(index, STATE_NONE);
                    break;
                case STATE_DRAGGING /*2*/:
                    this.mTextColor = ta.getColorStateList(index);
                    break;
                case SetDrawableParameters.TAG /*3*/:
                    this.mPreviewPadding = ta.getDimensionPixelSize(index, STATE_NONE);
                    break;
                case MIN_PAGES /*4*/:
                    this.mPreviewMinWidth = ta.getDimensionPixelSize(index, STATE_NONE);
                    break;
                case ReflectionActionWithoutParams.TAG /*5*/:
                    this.mPreviewMinHeight = ta.getDimensionPixelSize(index, STATE_NONE);
                    break;
                case SetEmptyView.TAG /*6*/:
                    this.mThumbDrawable = ta.getDrawable(index);
                    break;
                case SpellChecker.AVERAGE_WORD_LENGTH /*7*/:
                    this.mThumbMinWidth = ta.getDimensionPixelSize(index, STATE_NONE);
                    break;
                case SetPendingIntentTemplate.TAG /*8*/:
                    this.mThumbMinHeight = ta.getDimensionPixelSize(index, STATE_NONE);
                    break;
                case SetOnClickFillInIntent.TAG /*9*/:
                    this.mTrackDrawable = ta.getDrawable(index);
                    break;
                case SetRemoteViewsAdapterIntent.TAG /*10*/:
                    this.mPreviewResId[STATE_VISIBLE] = ta.getResourceId(index, STATE_NONE);
                    break;
                case TextViewDrawableAction.TAG /*11*/:
                    this.mPreviewResId[STATE_NONE] = ta.getResourceId(index, STATE_NONE);
                    break;
                case BitmapReflectionAction.TAG /*12*/:
                    this.mOverlayPosition = ta.getInt(index, STATE_NONE);
                    break;
                default:
                    break;
            }
        }
        updateAppearance();
    }

    public void remove() {
        this.mOverlay.remove(this.mTrackImage);
        this.mOverlay.remove(this.mThumbImage);
        this.mOverlay.remove(this.mPreviewImage);
        this.mOverlay.remove(this.mPrimaryText);
        this.mOverlay.remove(this.mSecondaryText);
    }

    public void setEnabled(boolean enabled) {
        if (this.mEnabled != enabled) {
            this.mEnabled = enabled;
            onStateDependencyChanged(true);
        }
    }

    public boolean isEnabled() {
        return this.mEnabled && (this.mLongList || this.mAlwaysShow);
    }

    public void setAlwaysShow(boolean alwaysShow) {
        if (this.mAlwaysShow != alwaysShow) {
            this.mAlwaysShow = alwaysShow;
            onStateDependencyChanged(false);
        }
    }

    public boolean isAlwaysShowEnabled() {
        return this.mAlwaysShow;
    }

    private void onStateDependencyChanged(boolean peekIfEnabled) {
        if (!isEnabled()) {
            stop();
        } else if (isAlwaysShowEnabled()) {
            setState(STATE_VISIBLE);
        } else if (this.mState == STATE_VISIBLE) {
            postAutoHide();
        } else if (peekIfEnabled) {
            setState(STATE_VISIBLE);
            postAutoHide();
        }
        this.mList.resolvePadding();
    }

    public void setScrollBarStyle(int style) {
        if (this.mScrollBarStyle != style) {
            this.mScrollBarStyle = style;
            updateLayout();
        }
    }

    public void stop() {
        setState(STATE_NONE);
    }

    public void setScrollbarPosition(int position) {
        int i = STATE_VISIBLE;
        if (position == 0) {
            position = this.mList.isLayoutRtl() ? STATE_VISIBLE : STATE_DRAGGING;
        }
        if (this.mScrollbarPosition != position) {
            boolean z;
            this.mScrollbarPosition = position;
            if (position != STATE_VISIBLE) {
                z = true;
            } else {
                z = false;
            }
            this.mLayoutFromRight = z;
            int[] iArr = this.mPreviewResId;
            if (!this.mLayoutFromRight) {
                i = STATE_NONE;
            }
            this.mPreviewImage.setBackgroundResource(iArr[i]);
            Drawable background = this.mPreviewImage.getBackground();
            if (background != null) {
                Rect padding = this.mTempBounds;
                background.getPadding(padding);
                padding.offset(this.mPreviewPadding, this.mPreviewPadding);
                this.mPreviewImage.setPadding(padding.left, padding.top, padding.right, padding.bottom);
            }
            updateLayout();
        }
    }

    public int getWidth() {
        return this.mWidth;
    }

    public void onSizeChanged(int w, int h, int oldw, int oldh) {
        updateLayout();
    }

    public void onItemCountChanged(int childCount, int itemCount) {
        if (this.mOldItemCount != itemCount || this.mOldChildCount != childCount) {
            this.mOldItemCount = itemCount;
            this.mOldChildCount = childCount;
            if ((itemCount - childCount > 0) && this.mState != STATE_DRAGGING) {
                setThumbPos(getPosFromItemCount(this.mList.getFirstVisiblePosition(), childCount, itemCount));
            }
            updateLongList(childCount, itemCount);
        }
    }

    private void updateLongList(int childCount, int itemCount) {
        boolean longList;
        if (childCount <= 0 || itemCount / childCount < MIN_PAGES) {
            longList = false;
        } else {
            longList = true;
        }
        if (this.mLongList != longList) {
            this.mLongList = longList;
            onStateDependencyChanged(false);
        }
    }

    private TextView createPreviewTextView(Context context) {
        LayoutParams params = new LayoutParams(-2, -2);
        TextView textView = new TextView(context);
        textView.setLayoutParams(params);
        textView.setSingleLine(true);
        textView.setEllipsize(TruncateAt.MIDDLE);
        textView.setGravity(17);
        textView.setAlpha(0.0f);
        textView.setLayoutDirection(this.mList.getLayoutDirection());
        return textView;
    }

    public void updateLayout() {
        if (!this.mUpdatingLayout) {
            this.mUpdatingLayout = true;
            updateContainerRect();
            layoutThumb();
            layoutTrack();
            Rect bounds = this.mTempBounds;
            measurePreview(this.mPrimaryText, bounds);
            applyLayout(this.mPrimaryText, bounds);
            measurePreview(this.mSecondaryText, bounds);
            applyLayout(this.mSecondaryText, bounds);
            if (this.mPreviewImage != null) {
                bounds.left -= this.mPreviewImage.getPaddingLeft();
                bounds.top -= this.mPreviewImage.getPaddingTop();
                bounds.right += this.mPreviewImage.getPaddingRight();
                bounds.bottom += this.mPreviewImage.getPaddingBottom();
                applyLayout(this.mPreviewImage, bounds);
            }
            this.mUpdatingLayout = false;
        }
    }

    private void applyLayout(View view, Rect bounds) {
        view.layout(bounds.left, bounds.top, bounds.right, bounds.bottom);
        view.setPivotX(this.mLayoutFromRight ? (float) (bounds.right - bounds.left) : 0.0f);
    }

    private void measurePreview(View v, Rect out) {
        Rect margins = this.mTempMargins;
        margins.left = this.mPreviewImage.getPaddingLeft();
        margins.top = this.mPreviewImage.getPaddingTop();
        margins.right = this.mPreviewImage.getPaddingRight();
        margins.bottom = this.mPreviewImage.getPaddingBottom();
        if (this.mOverlayPosition == 0) {
            measureFloating(v, margins, out);
        } else {
            measureViewToSide(v, this.mThumbImage, margins, out);
        }
    }

    private void measureViewToSide(View view, View adjacent, Rect margins, Rect out) {
        int marginLeft;
        int marginTop;
        int marginRight;
        int maxWidth;
        int right;
        int left;
        if (margins == null) {
            marginLeft = STATE_NONE;
            marginTop = STATE_NONE;
            marginRight = STATE_NONE;
        } else {
            marginLeft = margins.left;
            marginTop = margins.top;
            marginRight = margins.right;
        }
        Rect container = this.mContainerRect;
        int containerWidth = container.width();
        if (adjacent == null) {
            maxWidth = containerWidth;
        } else if (this.mLayoutFromRight) {
            maxWidth = adjacent.getLeft();
        } else {
            maxWidth = containerWidth - adjacent.getRight();
        }
        int adjMaxWidth = (maxWidth - marginLeft) - marginRight;
        view.measure(MeasureSpec.makeMeasureSpec(adjMaxWidth, RtlSpacingHelper.UNDEFINED), MeasureSpec.makeMeasureSpec(STATE_NONE, STATE_NONE));
        int width = Math.min(adjMaxWidth, view.getMeasuredWidth());
        if (this.mLayoutFromRight) {
            right = (adjacent == null ? container.right : adjacent.getLeft()) - marginRight;
            left = right - width;
        } else {
            left = (adjacent == null ? container.left : adjacent.getRight()) + marginLeft;
            right = left + width;
        }
        int top = marginTop;
        out.set(left, top, right, top + view.getMeasuredHeight());
    }

    private void measureFloating(View preview, Rect margins, Rect out) {
        int marginLeft;
        int marginTop;
        int marginRight;
        if (margins == null) {
            marginLeft = STATE_NONE;
            marginTop = STATE_NONE;
            marginRight = STATE_NONE;
        } else {
            marginLeft = margins.left;
            marginTop = margins.top;
            marginRight = margins.right;
        }
        Rect container = this.mContainerRect;
        int containerWidth = container.width();
        preview.measure(MeasureSpec.makeMeasureSpec((containerWidth - marginLeft) - marginRight, RtlSpacingHelper.UNDEFINED), MeasureSpec.makeMeasureSpec(STATE_NONE, STATE_NONE));
        int containerHeight = container.height();
        int width = preview.getMeasuredWidth();
        int top = ((containerHeight / 10) + marginTop) + container.top;
        int bottom = top + preview.getMeasuredHeight();
        int left = ((containerWidth - width) / STATE_DRAGGING) + container.left;
        out.set(left, top, left + width, bottom);
    }

    private void updateContainerRect() {
        AbsListView list = this.mList;
        list.resolvePadding();
        Rect container = this.mContainerRect;
        container.left = STATE_NONE;
        container.top = STATE_NONE;
        container.right = list.getWidth();
        container.bottom = list.getHeight();
        int scrollbarStyle = this.mScrollBarStyle;
        if (scrollbarStyle == WindowManagerPolicy.FLAG_INJECTED || scrollbarStyle == 0) {
            container.left += list.getPaddingLeft();
            container.top += list.getPaddingTop();
            container.right -= list.getPaddingRight();
            container.bottom -= list.getPaddingBottom();
            if (scrollbarStyle == WindowManagerPolicy.FLAG_INJECTED) {
                int width = getWidth();
                if (this.mScrollbarPosition == STATE_DRAGGING) {
                    container.right += width;
                } else {
                    container.left -= width;
                }
            }
        }
    }

    private void layoutThumb() {
        Rect bounds = this.mTempBounds;
        measureViewToSide(this.mThumbImage, null, null, bounds);
        applyLayout(this.mThumbImage, bounds);
    }

    private void layoutTrack() {
        int thumbHalfHeight = STATE_NONE;
        View track = this.mTrackImage;
        View thumb = this.mThumbImage;
        Rect container = this.mContainerRect;
        track.measure(MeasureSpec.makeMeasureSpec(container.width(), RtlSpacingHelper.UNDEFINED), MeasureSpec.makeMeasureSpec(STATE_NONE, STATE_NONE));
        int trackWidth = track.getMeasuredWidth();
        if (thumb != null) {
            thumbHalfHeight = thumb.getHeight() / STATE_DRAGGING;
        }
        int left = thumb.getLeft() + ((thumb.getWidth() - trackWidth) / STATE_DRAGGING);
        track.layout(left, container.top + thumbHalfHeight, left + trackWidth, container.bottom - thumbHalfHeight);
    }

    private void setState(int state) {
        this.mList.removeCallbacks(this.mDeferHide);
        if (this.mAlwaysShow && state == 0) {
            state = STATE_VISIBLE;
        }
        if (state != this.mState) {
            switch (state) {
                case STATE_NONE /*0*/:
                    transitionToHidden();
                    break;
                case STATE_VISIBLE /*1*/:
                    transitionToVisible();
                    break;
                case STATE_DRAGGING /*2*/:
                    if (!transitionPreviewLayout(this.mCurrentSection)) {
                        transitionToVisible();
                        break;
                    } else {
                        transitionToDragging();
                        break;
                    }
            }
            this.mState = state;
            refreshDrawablePressedState();
        }
    }

    private void refreshDrawablePressedState() {
        boolean isPressed = this.mState == STATE_DRAGGING;
        this.mThumbImage.setPressed(isPressed);
        this.mTrackImage.setPressed(isPressed);
    }

    private void transitionToHidden() {
        if (this.mDecorAnimation != null) {
            this.mDecorAnimation.cancel();
        }
        Animator fadeOut = groupAnimatorOfFloat(View.ALPHA, 0.0f, this.mThumbImage, this.mTrackImage, this.mPreviewImage, this.mPrimaryText, this.mSecondaryText).setDuration(300);
        float offset = this.mLayoutFromRight ? (float) this.mThumbImage.getWidth() : (float) (-this.mThumbImage.getWidth());
        Property property = View.TRANSLATION_X;
        View[] viewArr = new View[STATE_DRAGGING];
        viewArr[STATE_NONE] = this.mThumbImage;
        viewArr[STATE_VISIBLE] = this.mTrackImage;
        Animator slideOut = groupAnimatorOfFloat(property, offset, viewArr).setDuration(300);
        this.mDecorAnimation = new AnimatorSet();
        AnimatorSet animatorSet = this.mDecorAnimation;
        Animator[] animatorArr = new Animator[STATE_DRAGGING];
        animatorArr[STATE_NONE] = fadeOut;
        animatorArr[STATE_VISIBLE] = slideOut;
        animatorSet.playTogether(animatorArr);
        this.mDecorAnimation.start();
        this.mShowingPreview = false;
    }

    private void transitionToVisible() {
        if (this.mDecorAnimation != null) {
            this.mDecorAnimation.cancel();
        }
        Property property = View.ALPHA;
        View[] viewArr = new View[STATE_DRAGGING];
        viewArr[STATE_NONE] = this.mThumbImage;
        viewArr[STATE_VISIBLE] = this.mTrackImage;
        Animator fadeIn = groupAnimatorOfFloat(property, WindowManager.LayoutParams.BRIGHTNESS_OVERRIDE_FULL, viewArr).setDuration(150);
        Animator fadeOut = groupAnimatorOfFloat(View.ALPHA, 0.0f, this.mPreviewImage, this.mPrimaryText, this.mSecondaryText).setDuration(300);
        property = View.TRANSLATION_X;
        View[] viewArr2 = new View[STATE_DRAGGING];
        viewArr2[STATE_NONE] = this.mThumbImage;
        viewArr2[STATE_VISIBLE] = this.mTrackImage;
        Animator slideIn = groupAnimatorOfFloat(property, 0.0f, viewArr2).setDuration(150);
        this.mDecorAnimation = new AnimatorSet();
        this.mDecorAnimation.playTogether(new Animator[]{fadeIn, fadeOut, slideIn});
        this.mDecorAnimation.start();
        this.mShowingPreview = false;
    }

    private void transitionToDragging() {
        if (this.mDecorAnimation != null) {
            this.mDecorAnimation.cancel();
        }
        Animator fadeIn = groupAnimatorOfFloat(View.ALPHA, WindowManager.LayoutParams.BRIGHTNESS_OVERRIDE_FULL, this.mThumbImage, this.mTrackImage, this.mPreviewImage).setDuration(150);
        Property property = View.TRANSLATION_X;
        View[] viewArr = new View[STATE_DRAGGING];
        viewArr[STATE_NONE] = this.mThumbImage;
        viewArr[STATE_VISIBLE] = this.mTrackImage;
        Animator slideIn = groupAnimatorOfFloat(property, 0.0f, viewArr).setDuration(150);
        this.mDecorAnimation = new AnimatorSet();
        AnimatorSet animatorSet = this.mDecorAnimation;
        Animator[] animatorArr = new Animator[STATE_DRAGGING];
        animatorArr[STATE_NONE] = fadeIn;
        animatorArr[STATE_VISIBLE] = slideIn;
        animatorSet.playTogether(animatorArr);
        this.mDecorAnimation.start();
        this.mShowingPreview = true;
    }

    private void postAutoHide() {
        this.mList.removeCallbacks(this.mDeferHide);
        this.mList.postDelayed(this.mDeferHide, FADE_TIMEOUT);
    }

    public void onScroll(int firstVisibleItem, int visibleItemCount, int totalItemCount) {
        boolean hasMoreItems = false;
        if (isEnabled()) {
            if (totalItemCount - visibleItemCount > 0) {
                hasMoreItems = true;
            }
            if (hasMoreItems && this.mState != STATE_DRAGGING) {
                setThumbPos(getPosFromItemCount(firstVisibleItem, visibleItemCount, totalItemCount));
            }
            this.mScrollCompleted = true;
            if (this.mFirstVisibleItem != firstVisibleItem) {
                this.mFirstVisibleItem = firstVisibleItem;
                if (this.mState != STATE_DRAGGING) {
                    setState(STATE_VISIBLE);
                    postAutoHide();
                    return;
                }
                return;
            }
            return;
        }
        setState(STATE_NONE);
    }

    private void getSectionsFromIndexer() {
        this.mSectionIndexer = null;
        Adapter adapter = this.mList.getAdapter();
        if (adapter instanceof HeaderViewListAdapter) {
            this.mHeaderCount = ((HeaderViewListAdapter) adapter).getHeadersCount();
            adapter = ((HeaderViewListAdapter) adapter).getWrappedAdapter();
        }
        if (adapter instanceof ExpandableListConnector) {
            ExpandableListAdapter expAdapter = ((ExpandableListConnector) adapter).getAdapter();
            if (expAdapter instanceof SectionIndexer) {
                this.mSectionIndexer = (SectionIndexer) expAdapter;
                this.mListAdapter = adapter;
                this.mSections = this.mSectionIndexer.getSections();
            }
        } else if (adapter instanceof SectionIndexer) {
            this.mListAdapter = adapter;
            this.mSectionIndexer = (SectionIndexer) adapter;
            this.mSections = this.mSectionIndexer.getSections();
        } else {
            this.mListAdapter = adapter;
            this.mSections = null;
        }
    }

    public void onSectionsChanged() {
        this.mListAdapter = null;
    }

    private void scrollTo(float position) {
        int sectionCount;
        int sectionIndex;
        this.mScrollCompleted = false;
        int count = this.mList.getCount();
        Object[] sections = this.mSections;
        if (sections == null) {
            sectionCount = STATE_NONE;
        } else {
            sectionCount = sections.length;
        }
        ExpandableListView expList;
        if (sections == null || sectionCount <= STATE_VISIBLE) {
            int index = MathUtils.constrain((int) (((float) count) * position), STATE_NONE, count - 1);
            if (this.mList instanceof ExpandableListView) {
                expList = (ExpandableListView) this.mList;
                expList.setSelectionFromTop(expList.getFlatListPosition(ExpandableListView.getPackedPositionForGroup(this.mHeaderCount + index)), STATE_NONE);
            } else {
                if (this.mList instanceof ListView) {
                    ((ListView) this.mList).setSelectionFromTop(this.mHeaderCount + index, STATE_NONE);
                } else {
                    this.mList.setSelection(this.mHeaderCount + index);
                }
            }
            sectionIndex = -1;
        } else {
            int exactSection = MathUtils.constrain((int) (((float) sectionCount) * position), STATE_NONE, sectionCount - 1);
            int targetSection = exactSection;
            int targetIndex = this.mSectionIndexer.getPositionForSection(targetSection);
            sectionIndex = targetSection;
            int nextIndex = count;
            int prevIndex = targetIndex;
            int prevSection = targetSection;
            int nextSection = targetSection + STATE_VISIBLE;
            if (targetSection < sectionCount - 1) {
                nextIndex = this.mSectionIndexer.getPositionForSection(targetSection + STATE_VISIBLE);
            }
            if (nextIndex == targetIndex) {
                while (targetSection > 0) {
                    targetSection--;
                    prevIndex = this.mSectionIndexer.getPositionForSection(targetSection);
                    if (prevIndex == targetIndex) {
                        if (targetSection == 0) {
                            sectionIndex = STATE_NONE;
                            break;
                        }
                    }
                    prevSection = targetSection;
                    sectionIndex = targetSection;
                    break;
                }
            }
            int nextNextSection = nextSection + STATE_VISIBLE;
            while (nextNextSection < sectionCount) {
                if (this.mSectionIndexer.getPositionForSection(nextNextSection) != nextIndex) {
                    break;
                }
                nextNextSection += STATE_VISIBLE;
                nextSection += STATE_VISIBLE;
            }
            float prevPosition = ((float) prevSection) / ((float) sectionCount);
            float nextPosition = ((float) nextSection) / ((float) sectionCount);
            float snapThreshold;
            if (count == 0) {
                snapThreshold = Float.MAX_VALUE;
            } else {
                snapThreshold = 0.125f / ((float) count);
            }
            if (prevSection != exactSection || position - prevPosition >= snapThreshold) {
                targetIndex = prevIndex + ((int) ((((float) (nextIndex - prevIndex)) * (position - prevPosition)) / (nextPosition - prevPosition)));
            } else {
                targetIndex = prevIndex;
            }
            targetIndex = MathUtils.constrain(targetIndex, STATE_NONE, count - 1);
            if (this.mList instanceof ExpandableListView) {
                expList = this.mList;
                expList.setSelectionFromTop(expList.getFlatListPosition(ExpandableListView.getPackedPositionForGroup(this.mHeaderCount + targetIndex)), STATE_NONE);
            } else {
                if (this.mList instanceof ListView) {
                    ((ListView) this.mList).setSelectionFromTop(this.mHeaderCount + targetIndex, STATE_NONE);
                } else {
                    this.mList.setSelection(this.mHeaderCount + targetIndex);
                }
            }
        }
        int i = this.mCurrentSection;
        if (r0 != sectionIndex) {
            this.mCurrentSection = sectionIndex;
            boolean hasPreview = transitionPreviewLayout(sectionIndex);
            if (!this.mShowingPreview && hasPreview) {
                transitionToDragging();
            } else if (this.mShowingPreview && !hasPreview) {
                transitionToVisible();
            }
        }
    }

    private boolean transitionPreviewLayout(int sectionIndex) {
        TextView showing;
        View target;
        Object[] sections = this.mSections;
        String text = null;
        if (sections != null && sectionIndex >= 0 && sectionIndex < sections.length) {
            Object section = sections[sectionIndex];
            if (section != null) {
                text = section.toString();
            }
        }
        Rect bounds = this.mTempBounds;
        View preview = this.mPreviewImage;
        if (this.mShowingPrimary) {
            showing = this.mPrimaryText;
            target = this.mSecondaryText;
        } else {
            showing = this.mSecondaryText;
            target = this.mPrimaryText;
        }
        target.setText((CharSequence) text);
        measurePreview(target, bounds);
        applyLayout(target, bounds);
        if (this.mPreviewAnimation != null) {
            this.mPreviewAnimation.cancel();
        }
        Animator showTarget = animateAlpha(target, WindowManager.LayoutParams.BRIGHTNESS_OVERRIDE_FULL).setDuration(50);
        Animator hideShowing = animateAlpha(showing, 0.0f).setDuration(50);
        hideShowing.addListener(this.mSwitchPrimaryListener);
        bounds.left -= preview.getPaddingLeft();
        bounds.top -= preview.getPaddingTop();
        bounds.right += preview.getPaddingRight();
        bounds.bottom += preview.getPaddingBottom();
        Animator resizePreview = animateBounds(preview, bounds);
        resizePreview.setDuration(100);
        this.mPreviewAnimation = new AnimatorSet();
        Builder builder = this.mPreviewAnimation.play(hideShowing).with(showTarget);
        builder.with(resizePreview);
        int previewWidth = (preview.getWidth() - preview.getPaddingLeft()) - preview.getPaddingRight();
        int targetWidth = target.getWidth();
        if (targetWidth > previewWidth) {
            target.setScaleX(((float) previewWidth) / ((float) targetWidth));
            builder.with(animateScaleX(target, WindowManager.LayoutParams.BRIGHTNESS_OVERRIDE_FULL).setDuration(100));
        } else {
            target.setScaleX(WindowManager.LayoutParams.BRIGHTNESS_OVERRIDE_FULL);
        }
        int showingWidth = showing.getWidth();
        if (showingWidth > targetWidth) {
            builder.with(animateScaleX(showing, ((float) targetWidth) / ((float) showingWidth)).setDuration(100));
        }
        this.mPreviewAnimation.start();
        if (TextUtils.isEmpty(text)) {
            return false;
        }
        return true;
    }

    private void setThumbPos(float position) {
        float previewPos;
        Rect container = this.mContainerRect;
        int top = container.top;
        int bottom = container.bottom;
        View trackImage = this.mTrackImage;
        View thumbImage = this.mThumbImage;
        float min = (float) trackImage.getTop();
        float thumbMiddle = (position * (((float) trackImage.getBottom()) - min)) + min;
        thumbImage.setTranslationY(thumbMiddle - ((float) (thumbImage.getHeight() / STATE_DRAGGING)));
        View previewImage = this.mPreviewImage;
        float previewHalfHeight = ((float) previewImage.getHeight()) / 2.0f;
        switch (this.mOverlayPosition) {
            case STATE_VISIBLE /*1*/:
                previewPos = thumbMiddle;
                break;
            case STATE_DRAGGING /*2*/:
                previewPos = thumbMiddle - previewHalfHeight;
                break;
            default:
                previewPos = 0.0f;
                break;
        }
        float previewTop = MathUtils.constrain(previewPos, ((float) top) + previewHalfHeight, ((float) bottom) - previewHalfHeight) - previewHalfHeight;
        previewImage.setTranslationY(previewTop);
        this.mPrimaryText.setTranslationY(previewTop);
        this.mSecondaryText.setTranslationY(previewTop);
    }

    private float getPosFromMotionEvent(float y) {
        View trackImage = this.mTrackImage;
        float min = (float) trackImage.getTop();
        float offset = min;
        float range = ((float) trackImage.getBottom()) - min;
        if (range <= 0.0f) {
            return 0.0f;
        }
        return MathUtils.constrain((y - offset) / range, 0.0f, WindowManager.LayoutParams.BRIGHTNESS_OVERRIDE_FULL);
    }

    private float getPosFromItemCount(int firstVisibleItem, int visibleItemCount, int totalItemCount) {
        SectionIndexer sectionIndexer = this.mSectionIndexer;
        if (sectionIndexer == null || this.mListAdapter == null) {
            getSectionsFromIndexer();
        }
        if (visibleItemCount == 0 || totalItemCount == 0) {
            return 0.0f;
        }
        boolean hasSections;
        if (!(sectionIndexer == null || this.mSections == null)) {
            if (this.mSections.length > 0) {
                hasSections = true;
                if (!hasSections && this.mMatchDragPosition) {
                    firstVisibleItem -= this.mHeaderCount;
                    if (firstVisibleItem < 0) {
                        return 0.0f;
                    }
                    float incrementalPos;
                    int positionsInSection;
                    float posWithinSection;
                    float f;
                    totalItemCount -= this.mHeaderCount;
                    View child = this.mList.getChildAt(STATE_NONE);
                    if (child == null || child.getHeight() == 0) {
                        incrementalPos = 0.0f;
                    } else {
                        incrementalPos = ((float) (this.mList.getPaddingTop() - child.getTop())) / ((float) child.getHeight());
                    }
                    int section = sectionIndexer.getSectionForPosition(firstVisibleItem);
                    int sectionPos = sectionIndexer.getPositionForSection(section);
                    int sectionCount = this.mSections.length;
                    if (section < sectionCount - 1) {
                        int nextSectionPos;
                        if (section + STATE_VISIBLE < sectionCount) {
                            nextSectionPos = sectionIndexer.getPositionForSection(section + STATE_VISIBLE);
                        } else {
                            nextSectionPos = totalItemCount - 1;
                        }
                        positionsInSection = nextSectionPos - sectionPos;
                    } else {
                        positionsInSection = totalItemCount - sectionPos;
                    }
                    if (positionsInSection == 0) {
                        posWithinSection = 0.0f;
                    } else {
                        f = (float) sectionPos;
                        f = (float) positionsInSection;
                        posWithinSection = ((((float) firstVisibleItem) + incrementalPos) - r0) / r0;
                    }
                    f = (float) sectionCount;
                    float result = (((float) section) + posWithinSection) / r0;
                    if (firstVisibleItem <= 0 || firstVisibleItem + visibleItemCount != totalItemCount) {
                        return result;
                    }
                    int maxSize;
                    int currentVisibleSize;
                    View lastChild = this.mList.getChildAt(visibleItemCount - 1);
                    int bottomPadding = this.mList.getPaddingBottom();
                    if (this.mList.getClipToPadding()) {
                        maxSize = lastChild.getHeight();
                        currentVisibleSize = (this.mList.getHeight() - bottomPadding) - lastChild.getTop();
                    } else {
                        maxSize = lastChild.getHeight() + bottomPadding;
                        currentVisibleSize = this.mList.getHeight() - lastChild.getTop();
                    }
                    if (currentVisibleSize <= 0 || maxSize <= 0) {
                        return result;
                    }
                    return result + ((WindowManager.LayoutParams.BRIGHTNESS_OVERRIDE_FULL - result) * (((float) currentVisibleSize) / ((float) maxSize)));
                } else if (visibleItemCount == totalItemCount) {
                    return 0.0f;
                } else {
                    return ((float) firstVisibleItem) / ((float) (totalItemCount - visibleItemCount));
                }
            }
        }
        hasSections = false;
        if (!hasSections) {
        }
        if (visibleItemCount == totalItemCount) {
            return 0.0f;
        }
        return ((float) firstVisibleItem) / ((float) (totalItemCount - visibleItemCount));
    }

    private void cancelFling() {
        MotionEvent cancelFling = MotionEvent.obtain(0, 0, 3, 0.0f, 0.0f, STATE_NONE);
        this.mList.onTouchEvent(cancelFling);
        cancelFling.recycle();
    }

    private void cancelPendingDrag() {
        this.mPendingDrag = -1;
    }

    private void startPendingDrag() {
        this.mPendingDrag = SystemClock.uptimeMillis() + TAP_TIMEOUT;
    }

    private void beginDrag() {
        this.mPendingDrag = -1;
        setState(STATE_DRAGGING);
        if (this.mListAdapter == null && this.mList != null) {
            getSectionsFromIndexer();
        }
        if (this.mList != null) {
            this.mList.requestDisallowInterceptTouchEvent(true);
            this.mList.reportScrollStateChange(STATE_VISIBLE);
        }
        cancelFling();
    }

    public boolean onInterceptTouchEvent(MotionEvent ev) {
        if (!isEnabled()) {
            return false;
        }
        switch (ev.getActionMasked()) {
            case STATE_NONE /*0*/:
                if (!isPointInside(ev.getX(), ev.getY())) {
                    return false;
                }
                if (this.mList.isInScrollingContainer()) {
                    this.mInitialTouchY = ev.getY();
                    startPendingDrag();
                    return false;
                }
                beginDrag();
                return true;
            case STATE_VISIBLE /*1*/:
            case SetDrawableParameters.TAG /*3*/:
                cancelPendingDrag();
                return false;
            case STATE_DRAGGING /*2*/:
                if (!isPointInside(ev.getX(), ev.getY())) {
                    cancelPendingDrag();
                    return false;
                } else if (this.mPendingDrag < 0 || this.mPendingDrag > SystemClock.uptimeMillis()) {
                    return false;
                } else {
                    beginDrag();
                    scrollTo(getPosFromMotionEvent(this.mInitialTouchY));
                    return onTouchEvent(ev);
                }
            default:
                return false;
        }
    }

    public boolean onInterceptHoverEvent(MotionEvent ev) {
        if (isEnabled()) {
            int actionMasked = ev.getActionMasked();
            if ((actionMasked == 9 || actionMasked == 7) && this.mState == 0 && isPointInside(ev.getX(), ev.getY())) {
                setState(STATE_VISIBLE);
                postAutoHide();
            }
        }
        return false;
    }

    public boolean onTouchEvent(MotionEvent me) {
        if (!isEnabled()) {
            return false;
        }
        float pos;
        switch (me.getActionMasked()) {
            case STATE_VISIBLE /*1*/:
                if (this.mPendingDrag >= 0) {
                    beginDrag();
                    pos = getPosFromMotionEvent(me.getY());
                    setThumbPos(pos);
                    scrollTo(pos);
                }
                if (this.mState != STATE_DRAGGING) {
                    return false;
                }
                if (this.mList != null) {
                    this.mList.requestDisallowInterceptTouchEvent(false);
                    this.mList.reportScrollStateChange(STATE_NONE);
                }
                setState(STATE_VISIBLE);
                postAutoHide();
                return true;
            case STATE_DRAGGING /*2*/:
                if (this.mPendingDrag >= 0 && Math.abs(me.getY() - this.mInitialTouchY) > ((float) this.mScaledTouchSlop)) {
                    beginDrag();
                }
                if (this.mState != STATE_DRAGGING) {
                    return false;
                }
                pos = getPosFromMotionEvent(me.getY());
                setThumbPos(pos);
                if (this.mScrollCompleted) {
                    scrollTo(pos);
                }
                return true;
            case SetDrawableParameters.TAG /*3*/:
                cancelPendingDrag();
                return false;
            default:
                return false;
        }
    }

    private boolean isPointInside(float x, float y) {
        return isPointInsideX(x) && (this.mTrackDrawable != null || isPointInsideY(y));
    }

    private boolean isPointInsideX(float x) {
        float adjust = 0.0f;
        float offset = this.mThumbImage.getTranslationX();
        float right = ((float) this.mThumbImage.getRight()) + offset;
        float targetSizeDiff = ((float) this.mMinimumTouchTarget) - (right - (((float) this.mThumbImage.getLeft()) + offset));
        if (targetSizeDiff > 0.0f) {
            adjust = targetSizeDiff;
        }
        if (this.mLayoutFromRight) {
            if (x >= ((float) this.mThumbImage.getLeft()) - adjust) {
                return true;
            }
            return false;
        } else if (x > ((float) this.mThumbImage.getRight()) + adjust) {
            return false;
        } else {
            return true;
        }
    }

    private boolean isPointInsideY(float y) {
        float adjust = 0.0f;
        float offset = this.mThumbImage.getTranslationY();
        float top = ((float) this.mThumbImage.getTop()) + offset;
        float bottom = ((float) this.mThumbImage.getBottom()) + offset;
        float targetSizeDiff = ((float) this.mMinimumTouchTarget) - (bottom - top);
        if (targetSizeDiff > 0.0f) {
            adjust = targetSizeDiff / 2.0f;
        }
        return y >= top - adjust && y <= bottom + adjust;
    }

    private static Animator groupAnimatorOfFloat(Property<View, Float> property, float value, View... views) {
        AnimatorSet animSet = new AnimatorSet();
        Builder builder = null;
        for (int i = views.length - 1; i >= 0; i--) {
            Object obj = views[i];
            float[] fArr = new float[STATE_VISIBLE];
            fArr[STATE_NONE] = value;
            Animator anim = ObjectAnimator.ofFloat(obj, property, fArr);
            if (builder == null) {
                builder = animSet.play(anim);
            } else {
                builder.with(anim);
            }
        }
        return animSet;
    }

    private static Animator animateScaleX(View v, float target) {
        Property property = View.SCALE_X;
        float[] fArr = new float[STATE_VISIBLE];
        fArr[STATE_NONE] = target;
        return ObjectAnimator.ofFloat(v, property, fArr);
    }

    private static Animator animateAlpha(View v, float alpha) {
        Property property = View.ALPHA;
        float[] fArr = new float[STATE_VISIBLE];
        fArr[STATE_NONE] = alpha;
        return ObjectAnimator.ofFloat(v, property, fArr);
    }

    private static Animator animateBounds(View v, Rect bounds) {
        Property property = LEFT;
        int[] iArr = new int[STATE_VISIBLE];
        iArr[STATE_NONE] = bounds.left;
        PropertyValuesHolder left = PropertyValuesHolder.ofInt(property, iArr);
        property = TOP;
        iArr = new int[STATE_VISIBLE];
        iArr[STATE_NONE] = bounds.top;
        PropertyValuesHolder top = PropertyValuesHolder.ofInt(property, iArr);
        property = RIGHT;
        iArr = new int[STATE_VISIBLE];
        iArr[STATE_NONE] = bounds.right;
        PropertyValuesHolder right = PropertyValuesHolder.ofInt(property, iArr);
        property = BOTTOM;
        iArr = new int[STATE_VISIBLE];
        iArr[STATE_NONE] = bounds.bottom;
        PropertyValuesHolder bottom = PropertyValuesHolder.ofInt(property, iArr);
        PropertyValuesHolder[] propertyValuesHolderArr = new PropertyValuesHolder[MIN_PAGES];
        propertyValuesHolderArr[STATE_NONE] = left;
        propertyValuesHolderArr[STATE_VISIBLE] = top;
        propertyValuesHolderArr[STATE_DRAGGING] = right;
        propertyValuesHolderArr[3] = bottom;
        return ObjectAnimator.ofPropertyValuesHolder(v, propertyValuesHolderArr);
    }
}
