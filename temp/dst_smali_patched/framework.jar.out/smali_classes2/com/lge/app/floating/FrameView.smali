.class Lcom/lge/app/floating/FrameView;
.super Lcom/lge/app/floating/QslideView;
.source "FrameView.java"

# interfaces
.implements Lcom/lge/app/floating/IFrameView;
.implements Landroid/view/View$OnTouchListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/app/floating/FrameView$ImeMonitor;,
        Lcom/lge/app/floating/FrameView$MyGestureListener;
    }
.end annotation


# instance fields
.field private mActionModeBarParent:Landroid/view/ViewGroup;

.field private mActionMoveCount:I

.field mAttachedWhen:J

.field private mContent:Landroid/view/View;

.field private final mContentParent:Landroid/view/ViewGroup;

.field private mDefaultTouchListener:Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;

.field mDispathchFrameViewActionDown:Z

.field private final mDisplay:Landroid/util/DisplayMetrics;

.field private mDownX:F

.field private mDownY:F

.field private final mGestureDetector:Landroid/view/GestureDetector;

.field private mHeightDown:I

.field private final mInflater:Landroid/view/LayoutInflater;

.field mIsFocusable:Z

.field mIsTouchInTitleView:Z

.field private final mPadding:Landroid/graphics/Rect;

.field private mReceiveBackKeyEvent:Z

.field private mReceiveMenuKeyEvent:Z

.field private mResizeAnimator:Landroid/animation/ObjectAnimator;

.field private mResizeFrame:Lcom/lge/app/floating/ResizeFrame;

.field private final mResizeHandle:Landroid/view/View;

.field private final mResources:Landroid/content/res/Resources;

.field private mSavedContentPadding:Landroid/graphics/Rect;

.field private mWidthDown:I

.field private moveEnabled:Z


# direct methods
.method constructor <init>(Lcom/lge/app/floating/FloatableActivity;Lcom/lge/app/floating/FloatingWindow;)V
    .locals 4
    .param p1, "activity"    # Lcom/lge/app/floating/FloatableActivity;
    .param p2, "window"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    const/4 v3, 0x0

    const/4 v2, 0x0

    invoke-direct {p0, p1, p2}, Lcom/lge/app/floating/QslideView;-><init>(Landroid/content/Context;Lcom/lge/app/floating/FloatingWindow;)V

    iput-boolean v2, p0, Lcom/lge/app/floating/FrameView;->mIsFocusable:Z

    new-instance v0, Landroid/util/DisplayMetrics;

    invoke-direct {v0}, Landroid/util/DisplayMetrics;-><init>()V

    iput-object v0, p0, Lcom/lge/app/floating/FrameView;->mDisplay:Landroid/util/DisplayMetrics;

    iput-boolean v2, p0, Lcom/lge/app/floating/FrameView;->mReceiveMenuKeyEvent:Z

    iput-boolean v2, p0, Lcom/lge/app/floating/FrameView;->mReceiveBackKeyEvent:Z

    iput-boolean v2, p0, Lcom/lge/app/floating/FrameView;->moveEnabled:Z

    iput-boolean v2, p0, Lcom/lge/app/floating/FrameView;->mDispathchFrameViewActionDown:Z

    iput-boolean v2, p0, Lcom/lge/app/floating/FrameView;->mIsTouchInTitleView:Z

    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/lge/app/floating/FrameView;->mAttachedWhen:J

    iput-object v3, p0, Lcom/lge/app/floating/FrameView;->mActionModeBarParent:Landroid/view/ViewGroup;

    iput-object p1, p0, Lcom/lge/app/floating/FrameView;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-static {p1}, Lcom/lge/app/floating/Res;->getResources(Landroid/content/Context;)Landroid/content/res/Resources;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/app/floating/FrameView;->mResources:Landroid/content/res/Resources;

    invoke-static {p1}, Lcom/lge/app/floating/Res;->getResPackageContext(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/app/floating/FrameView;->mInflater:Landroid/view/LayoutInflater;

    iget-object v0, p0, Lcom/lge/app/floating/FrameView;->mInflater:Landroid/view/LayoutInflater;

    const v1, 0x7f030001

    invoke-virtual {v0, v1, p0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    const v0, 0x7f0c0004

    invoke-virtual {p0, v0}, Lcom/lge/app/floating/FrameView;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    iput-object v0, p0, Lcom/lge/app/floating/FrameView;->mContentParent:Landroid/view/ViewGroup;

    iget-object v0, p0, Lcom/lge/app/floating/FrameView;->mDisplay:Landroid/util/DisplayMetrics;

    iget-object v1, p0, Lcom/lge/app/floating/FrameView;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v1}, Lcom/lge/app/floating/FloatableActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v1, v1, Landroid/util/DisplayMetrics;->widthPixels:I

    iput v1, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    iget-object v0, p0, Lcom/lge/app/floating/FrameView;->mDisplay:Landroid/util/DisplayMetrics;

    iget-object v1, p0, Lcom/lge/app/floating/FrameView;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v1}, Lcom/lge/app/floating/FloatableActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v1, v1, Landroid/util/DisplayMetrics;->heightPixels:I

    iput v1, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    const v0, 0x7f0c0005

    invoke-virtual {p0, v0}, Lcom/lge/app/floating/FrameView;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/app/floating/FrameView;->mResizeHandle:Landroid/view/View;

    iget-object v0, p0, Lcom/lge/app/floating/FrameView;->mResizeHandle:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setLayoutDirection(I)V

    iget-object v0, p0, Lcom/lge/app/floating/FrameView;->mResizeHandle:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    iget-object v0, p0, Lcom/lge/app/floating/FrameView;->mResizeHandle:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setFocusable(Z)V

    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    iput-object v0, p0, Lcom/lge/app/floating/FrameView;->mPadding:Landroid/graphics/Rect;

    new-instance v0, Landroid/view/GestureDetector;

    iget-object v1, p0, Lcom/lge/app/floating/FrameView;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    new-instance v2, Lcom/lge/app/floating/FrameView$MyGestureListener;

    invoke-direct {v2, p0, v3}, Lcom/lge/app/floating/FrameView$MyGestureListener;-><init>(Lcom/lge/app/floating/FrameView;Lcom/lge/app/floating/FrameView$1;)V

    invoke-direct {v0, v1, v2}, Landroid/view/GestureDetector;-><init>(Landroid/content/Context;Landroid/view/GestureDetector$OnGestureListener;)V

    iput-object v0, p0, Lcom/lge/app/floating/FrameView;->mGestureDetector:Landroid/view/GestureDetector;

    const v0, 0x7f0c0002

    invoke-virtual {p0, v0}, Lcom/lge/app/floating/FrameView;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/app/floating/FrameView;->mPadding:Landroid/graphics/Rect;

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/Drawable;->getPadding(Landroid/graphics/Rect;)Z

    new-instance v0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;

    iget-object v1, p0, Lcom/lge/app/floating/FrameView;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-direct {v0, v1}, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;-><init>(Lcom/lge/app/floating/FloatableActivity;)V

    iput-object v0, p0, Lcom/lge/app/floating/FrameView;->mDefaultTouchListener:Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;

    iget-object v0, p0, Lcom/lge/app/floating/FrameView;->mDefaultTouchListener:Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;

    invoke-virtual {p0, v0}, Lcom/lge/app/floating/FrameView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/lge/app/floating/FrameView;->setFitsSystemWindows(Z)V

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object v0

    new-instance v1, Lcom/lge/app/floating/FrameView$ImeMonitor;

    invoke-direct {v1, p0, v3}, Lcom/lge/app/floating/FrameView$ImeMonitor;-><init>(Lcom/lge/app/floating/FrameView;Lcom/lge/app/floating/FrameView$1;)V

    invoke-virtual {v0, v1}, Landroid/view/ViewTreeObserver;->addOnGlobalFocusChangeListener(Landroid/view/ViewTreeObserver$OnGlobalFocusChangeListener;)V

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->update()V

    return-void
.end method

.method static synthetic access$200(Lcom/lge/app/floating/FrameView;)Landroid/view/View;
    .locals 1
    .param p0, "x0"    # Lcom/lge/app/floating/FrameView;

    .prologue
    iget-object v0, p0, Lcom/lge/app/floating/FrameView;->mResizeHandle:Landroid/view/View;

    return-object v0
.end method

.method private adjustSoftInputOnConfigurationChange(Landroid/content/res/Configuration;)V
    .locals 2
    .param p1, "newConfig"    # Landroid/content/res/Configuration;

    .prologue
    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v0

    iget-object v0, v0, Lcom/lge/app/floating/FloatingWindow;->mSavedConfig:Landroid/content/res/Configuration;

    iget v0, v0, Landroid/content/res/Configuration;->orientation:I

    iget v1, p1, Landroid/content/res/Configuration;->orientation:I

    if-ne v0, v1, :cond_0

    :goto_0
    return-void

    :cond_0
    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/app/floating/FloatingWindow;->hideIme()V

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v0

    const/4 v1, 0x1

    iput-boolean v1, v0, Lcom/lge/app/floating/FloatingWindow;->mImeShouldBeReShown:Z

    goto :goto_0
.end method

.method private checkImeWillBeClosed(Landroid/view/MotionEvent;)Z
    .locals 2
    .param p1, "event"    # Landroid/view/MotionEvent;

    .prologue
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    const/4 v1, 0x4

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private setOverlappingTitle(Z)V
    .locals 7
    .param p1, "enable"    # Z

    .prologue
    const v6, 0x7f0c0004

    const v5, 0x7f0c0003

    const/16 v4, 0xa

    const/4 v3, 0x3

    const/4 v2, 0x0

    invoke-virtual {p0, v6}, Lcom/lge/app/floating/FrameView;->findViewById(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/widget/RelativeLayout$LayoutParams;

    .local v0, "params":Landroid/widget/RelativeLayout$LayoutParams;
    if-nez v0, :cond_0

    sget-object v1, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    const-string v2, "Cannot setOverlappingTitle - Fail to findViewById"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    if-eqz p1, :cond_1

    invoke-virtual {v0, v3, v2}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(II)V

    const/4 v1, -0x1

    invoke-virtual {v0, v4, v1}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(II)V

    :goto_1
    invoke-virtual {p0, v6}, Lcom/lge/app/floating/FrameView;->findViewById(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {p0, v5}, Lcom/lge/app/floating/FrameView;->findViewById(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->bringToFront()V

    goto :goto_0

    :cond_1
    invoke-virtual {v0, v3, v5}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(II)V

    invoke-virtual {v0, v4, v2}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(II)V

    goto :goto_1
.end method


# virtual methods
.method public addListenerToDefaultTouchListener(Landroid/view/View$OnTouchListener;)V
    .locals 2
    .param p1, "listener"    # Landroid/view/View$OnTouchListener;

    .prologue
    sget-object v0, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    const-string v1, "addListenerToDefaultTouchListener for FrameView"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/lge/app/floating/FrameView;->mDefaultTouchListener:Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;

    invoke-virtual {v0, p1}, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->setMoveTouchListener(Landroid/view/View$OnTouchListener;)V

    return-void
.end method

.method checkPointInsideTitleView(Lcom/lge/app/floating/FrameView;FF)Z
    .locals 6
    .param p1, "view"    # Lcom/lge/app/floating/FrameView;
    .param p2, "x"    # F
    .param p3, "y"    # F

    .prologue
    const/4 v4, 0x2

    const/4 v2, 0x1

    const/4 v3, 0x0

    new-array v0, v4, [I

    .local v0, "frameViewLocation":[I
    new-array v1, v4, [I

    .local v1, "titleViewLocation":[I
    invoke-virtual {p1, v0}, Lcom/lge/app/floating/FrameView;->getLocationOnScreen([I)V

    aget v4, v0, v3

    aput v4, v1, v3

    aget v4, v0, v2

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v5

    invoke-virtual {v5}, Lcom/lge/app/floating/FloatingWindow;->getTitleWindowH()I

    move-result v5

    sub-int/2addr v4, v5

    aput v4, v1, v2

    aget v4, v1, v3

    int-to-float v4, v4

    cmpl-float v4, p2, v4

    if-ltz v4, :cond_0

    aget v4, v1, v3

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v5

    invoke-virtual {v5}, Lcom/lge/app/floating/FloatingWindow;->getTitleWindowW()I

    move-result v5

    add-int/2addr v4, v5

    int-to-float v4, v4

    cmpg-float v4, p2, v4

    if-gtz v4, :cond_0

    aget v4, v1, v2

    int-to-float v4, v4

    cmpl-float v4, p3, v4

    if-ltz v4, :cond_0

    aget v4, v1, v2

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v5

    invoke-virtual {v5}, Lcom/lge/app/floating/FloatingWindow;->getTitleWindowH()I

    move-result v5

    add-int/2addr v4, v5

    int-to-float v4, v4

    cmpg-float v4, p3, v4

    if-gtz v4, :cond_0

    :goto_0
    return v2

    :cond_0
    move v2, v3

    goto :goto_0
.end method

.method public dispatchKeyEvent(Landroid/view/KeyEvent;)Z
    .locals 3
    .param p1, "event"    # Landroid/view/KeyEvent;

    .prologue
    const/4 v0, 0x0

    invoke-virtual {p1}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result v1

    const/4 v2, 0x3

    if-ne v1, v2, :cond_0

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/app/floating/FloatingWindow;->looseFocus()V

    :goto_0
    return v0

    :cond_0
    invoke-virtual {p1}, Landroid/view/KeyEvent;->getAction()I

    move-result v1

    if-nez v1, :cond_1

    invoke-virtual {p1}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result v1

    const/16 v2, 0x52

    if-ne v1, v2, :cond_1

    sget-object v1, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    const-string v2, "Get event ACTION_DOWN - KEYCODE_MENU"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/lge/app/floating/FloatingWindow;->setLayoutLimit(Z)V

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/app/floating/FloatingWindow;->looseFocus()V

    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/lge/app/floating/FrameView;->mReceiveMenuKeyEvent:Z

    goto :goto_0

    :cond_1
    invoke-super {p0, p1}, Lcom/lge/app/floating/QslideView;->dispatchKeyEvent(Landroid/view/KeyEvent;)Z

    move-result v0

    goto :goto_0
.end method

.method public dispatchKeyEventPreIme(Landroid/view/KeyEvent;)Z
    .locals 4
    .param p1, "event"    # Landroid/view/KeyEvent;

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    invoke-virtual {p1}, Landroid/view/KeyEvent;->getAction()I

    move-result v0

    if-ne v0, v3, :cond_0

    invoke-virtual {p1}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result v0

    const/4 v1, 0x4

    if-ne v0, v1, :cond_0

    sget-object v0, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    const-string v1, "dispatchKeyEventPreIme"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v0, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    const-string v1, "Get event ACTION_UP - KEYCODE_BACK"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v0

    iget-boolean v0, v0, Lcom/lge/app/floating/FloatingWindow;->mIsImeVisible:Z

    if-nez v0, :cond_1

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v0

    invoke-virtual {v0, v2}, Lcom/lge/app/floating/FloatingWindow;->setLayoutLimit(Z)V

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/app/floating/FloatingWindow;->looseFocus()V

    iput-boolean v3, p0, Lcom/lge/app/floating/FrameView;->mReceiveBackKeyEvent:Z

    :goto_0
    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v0

    iput-boolean v2, v0, Lcom/lge/app/floating/FloatingWindow;->mIsImeVisible:Z

    :cond_0
    invoke-super {p0, p1}, Lcom/lge/app/floating/QslideView;->dispatchKeyEventPreIme(Landroid/view/KeyEvent;)Z

    move-result v0

    return v0

    :cond_1
    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v0

    invoke-virtual {v0, v2}, Lcom/lge/app/floating/FloatingWindow;->setLayoutLimit(Z)V

    iput-boolean v2, p0, Lcom/lge/app/floating/FrameView;->mReceiveBackKeyEvent:Z

    goto :goto_0
.end method

.method public dispatchTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 10
    .param p1, "event"    # Landroid/view/MotionEvent;

    .prologue
    const/4 v9, 0x4

    const/4 v5, 0x1

    const/4 v4, 0x0

    sget-object v6, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "dispatch at frame. "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-object v8, p0, Lcom/lge/app/floating/FrameView;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v8}, Lcom/lge/app/floating/FloatableActivity;->getPackageName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {p1}, Landroid/view/MotionEvent;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v6

    if-ne v6, v9, :cond_0

    sget-object v6, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    const-string v7, "dispatchTouchEvent ACTION_OUTSIDE"

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    check-cast v1, Landroid/view/WindowManager$LayoutParams;

    .local v1, "params":Landroid/view/WindowManager$LayoutParams;
    iget v6, v1, Landroid/view/WindowManager$LayoutParams;->flags:I

    and-int/lit8 v6, v6, 0x8

    if-eqz v6, :cond_1

    .end local v1    # "params":Landroid/view/WindowManager$LayoutParams;
    :goto_0
    return v4

    :cond_0
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v6

    if-nez v6, :cond_1

    sget-object v6, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    const-string v7, "dispatchTouchEvent ACTION_DOWN - moveToTop"

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v6

    invoke-virtual {v6}, Lcom/lge/app/floating/FloatingWindow;->moveToTop()V

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v6

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v7

    invoke-virtual {p0, p0, v6, v7}, Lcom/lge/app/floating/FrameView;->checkPointInsideTitleView(Lcom/lge/app/floating/FrameView;FF)Z

    move-result v6

    iput-boolean v6, p0, Lcom/lge/app/floating/FrameView;->mIsTouchInTitleView:Z

    :cond_1
    iget-boolean v6, p0, Lcom/lge/app/floating/FrameView;->mIsTouchInTitleView:Z

    if-eqz v6, :cond_2

    invoke-super {p0, p1}, Lcom/lge/app/floating/QslideView;->dispatchTouchEvent(Landroid/view/MotionEvent;)Z

    goto :goto_0

    :cond_2
    iget-object v6, p0, Lcom/lge/app/floating/FrameView;->mGestureDetector:Landroid/view/GestureDetector;

    invoke-virtual {v6, p1}, Landroid/view/GestureDetector;->onTouchEvent(Landroid/view/MotionEvent;)Z

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v6

    iget-boolean v6, v6, Lcom/lge/app/floating/FloatingWindow;->mIsImeVisible:Z

    if-eqz v6, :cond_3

    invoke-direct {p0, p1}, Lcom/lge/app/floating/FrameView;->checkImeWillBeClosed(Landroid/view/MotionEvent;)Z

    move-result v6

    if-eqz v6, :cond_6

    sget-object v6, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    const-string v7, "user has touched outside of the window and keyboard will be dismissed."

    invoke-static {v6, v7}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v6

    invoke-virtual {v6, v4}, Lcom/lge/app/floating/FloatingWindow;->setLayoutLimit(Z)V

    :cond_3
    :goto_1
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v6

    if-nez v6, :cond_8

    const/4 v0, 0x0

    .local v0, "isResizeHandleTouched":Z
    const/4 v6, 0x2

    new-array v2, v6, [I

    .local v2, "resizeHandleLocation":[I
    iget-object v6, p0, Lcom/lge/app/floating/FrameView;->mResizeHandle:Landroid/view/View;

    if-nez v6, :cond_7

    :cond_4
    :goto_2
    if-nez v0, :cond_5

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v4

    invoke-virtual {v4}, Lcom/lge/app/floating/FloatingWindow;->moveToTop()V

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v4

    invoke-virtual {v4}, Lcom/lge/app/floating/FloatingWindow;->gainFocus()V

    .end local v0    # "isResizeHandleTouched":Z
    .end local v2    # "resizeHandleLocation":[I
    :cond_5
    :goto_3
    invoke-super {p0, p1}, Lcom/lge/app/floating/QslideView;->dispatchTouchEvent(Landroid/view/MotionEvent;)Z

    move v4, v5

    goto :goto_0

    :cond_6
    sget-object v6, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    const-string v7, "user has touched inside of the window and keyboard will remain."

    invoke-static {v6, v7}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .restart local v0    # "isResizeHandleTouched":Z
    .restart local v2    # "resizeHandleLocation":[I
    :cond_7
    iget-object v6, p0, Lcom/lge/app/floating/FrameView;->mResizeHandle:Landroid/view/View;

    invoke-virtual {v6, v2}, Landroid/view/View;->getLocationOnScreen([I)V

    new-instance v3, Landroid/graphics/Rect;

    aget v6, v2, v4

    aget v7, v2, v5

    aget v4, v2, v4

    iget-object v8, p0, Lcom/lge/app/floating/FrameView;->mResizeHandle:Landroid/view/View;

    invoke-virtual {v8}, Landroid/view/View;->getWidth()I

    move-result v8

    add-int/2addr v4, v8

    aget v8, v2, v5

    iget-object v9, p0, Lcom/lge/app/floating/FrameView;->mResizeHandle:Landroid/view/View;

    invoke-virtual {v9}, Landroid/view/View;->getHeight()I

    move-result v9

    add-int/2addr v8, v9

    invoke-direct {v3, v6, v7, v4, v8}, Landroid/graphics/Rect;-><init>(IIII)V

    .local v3, "resizeHandleRect":Landroid/graphics/Rect;
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v4

    float-to-int v4, v4

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v6

    float-to-int v6, v6

    invoke-virtual {v3, v4, v6}, Landroid/graphics/Rect;->contains(II)Z

    move-result v4

    if-eqz v4, :cond_4

    const/4 v0, 0x1

    goto :goto_2

    .end local v0    # "isResizeHandleTouched":Z
    .end local v2    # "resizeHandleLocation":[I
    .end local v3    # "resizeHandleRect":Landroid/graphics/Rect;
    :cond_8
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v4

    if-ne v4, v9, :cond_5

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v4

    invoke-virtual {v4}, Lcom/lge/app/floating/FloatingWindow;->looseFocus()V

    goto :goto_3
.end method

.method public doOnConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 0
    .param p1, "config"    # Landroid/content/res/Configuration;

    .prologue
    invoke-virtual {p0, p1}, Lcom/lge/app/floating/FrameView;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    return-void
.end method

.method public findFocus()Landroid/view/View;
    .locals 3

    .prologue
    invoke-super {p0}, Lcom/lge/app/floating/QslideView;->findFocus()Landroid/view/View;

    move-result-object v0

    .local v0, "focusedView":Landroid/view/View;
    sget-object v1, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    const-string v2, "4.1.2"

    invoke-virtual {v1, v2}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v1

    if-gtz v1, :cond_0

    if-eqz v0, :cond_0

    instance-of v1, v0, Landroid/widget/TextView;

    if-nez v1, :cond_0

    instance-of v1, v0, Landroid/webkit/WebView;

    if-nez v1, :cond_0

    const/4 v0, 0x0

    .end local v0    # "focusedView":Landroid/view/View;
    :cond_0
    return-object v0
.end method

.method protected fitSystemWindows(Landroid/graphics/Rect;)Z
    .locals 28
    .param p1, "insets"    # Landroid/graphics/Rect;

    .prologue
    sget-object v24, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    const-string v26, "fitSystemWindows insets="

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, v25

    move-object/from16 v1, p1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v13, Landroid/graphics/Rect;

    move-object/from16 v0, p1

    iget v0, v0, Landroid/graphics/Rect;->left:I

    move/from16 v24, v0

    move-object/from16 v0, p1

    iget v0, v0, Landroid/graphics/Rect;->top:I

    move/from16 v25, v0

    move-object/from16 v0, p1

    iget v0, v0, Landroid/graphics/Rect;->right:I

    move/from16 v26, v0

    move-object/from16 v0, p1

    iget v0, v0, Landroid/graphics/Rect;->bottom:I

    move/from16 v27, v0

    move/from16 v0, v24

    move/from16 v1, v25

    move/from16 v2, v26

    move/from16 v3, v27

    invoke-direct {v13, v0, v1, v2, v3}, Landroid/graphics/Rect;-><init>(IIII)V

    .local v13, "receiveRect":Landroid/graphics/Rect;
    invoke-super/range {p0 .. p1}, Lcom/lge/app/floating/QslideView;->fitSystemWindows(Landroid/graphics/Rect;)Z

    move-result v14

    .local v14, "result":Z
    iget v0, v13, Landroid/graphics/Rect;->bottom:I

    move/from16 v24, v0

    move-object/from16 v0, p1

    iget v0, v0, Landroid/graphics/Rect;->bottom:I

    move/from16 v25, v0

    move/from16 v0, v24

    move/from16 v1, v25

    if-eq v0, v1, :cond_0

    sget-object v24, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    const-string v26, "fitSystemWindows bottom changed : "

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, p1

    iget v0, v0, Landroid/graphics/Rect;->bottom:I

    move/from16 v26, v0

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget v0, v13, Landroid/graphics/Rect;->bottom:I

    move/from16 v24, v0

    move/from16 v0, v24

    move-object/from16 v1, p1

    iput v0, v1, Landroid/graphics/Rect;->bottom:I

    :cond_0
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FrameView;->mResources:Landroid/content/res/Resources;

    move-object/from16 v24, v0

    invoke-virtual/range {v24 .. v24}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v24

    move-object/from16 v0, v24

    iget v0, v0, Landroid/content/res/Configuration;->orientation:I

    move/from16 v24, v0

    const/16 v25, 0x1

    move/from16 v0, v24

    move/from16 v1, v25

    if-eq v0, v1, :cond_2

    :cond_1
    :goto_0
    return v14

    :cond_2
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v24

    move-object/from16 v0, v24

    iget-boolean v0, v0, Lcom/lge/app/floating/FloatingWindow;->mIsImeVisible:Z

    move/from16 v24, v0

    if-nez v24, :cond_3

    sget-object v24, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    const-string v26, "fitSystemWindows mIsImeVisible : "

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v26

    move-object/from16 v0, v26

    iget-boolean v0, v0, Lcom/lge/app/floating/FloatingWindow;->mIsImeVisible:Z

    move/from16 v26, v0

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_3
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v24

    move-object/from16 v0, v24

    iget-boolean v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->dontUseIme:Z

    move/from16 v24, v0

    if-eqz v24, :cond_4

    sget-object v24, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    const-string v25, "getWindowLayoutParams().dontUseIme"

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_4
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v24

    move-object/from16 v0, v24

    iget-boolean v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->fullScreen:Z

    move/from16 v24, v0

    if-eqz v24, :cond_5

    sget-object v24, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    const-string v25, "cannot happen."

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_5
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v24

    move-object/from16 v0, v24

    iget-object v0, v0, Lcom/lge/app/floating/FloatingWindow;->mInputMethodManager:Landroid/view/inputmethod/InputMethodManager;

    move-object/from16 v24, v0

    invoke-virtual/range {v24 .. v24}, Landroid/view/inputmethod/InputMethodManager;->getCurrentInputMethodSubtype()Landroid/view/inputmethod/InputMethodSubtype;

    move-result-object v17

    .local v17, "subType":Landroid/view/inputmethod/InputMethodSubtype;
    if-eqz v17, :cond_6

    invoke-virtual/range {v17 .. v17}, Landroid/view/inputmethod/InputMethodSubtype;->getMode()Ljava/lang/String;

    move-result-object v21

    .local v21, "type":Ljava/lang/String;
    const-string v24, "voice"

    move-object/from16 v0, v21

    move-object/from16 v1, v24

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v24

    if-eqz v24, :cond_6

    sget-object v24, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    move-object/from16 v0, v24

    move-object/from16 v1, v21

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .end local v21    # "type":Ljava/lang/String;
    :cond_6
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->isWindowAttached()Z

    move-result v24

    if-eqz v24, :cond_1

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FrameView;->mResources:Landroid/content/res/Resources;

    move-object/from16 v24, v0

    invoke-virtual/range {v24 .. v24}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v24

    move-object/from16 v0, v24

    iget v15, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    .local v15, "screenHeight":I
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FrameView;->mResources:Landroid/content/res/Resources;

    move-object/from16 v24, v0

    const v25, 0x7f060009

    invoke-virtual/range {v24 .. v25}, Landroid/content/res/Resources;->getDimensionPixelOffset(I)I

    move-result v16

    .local v16, "statusBarHeight":I
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v24

    invoke-virtual/range {v24 .. v24}, Lcom/lge/app/floating/FloatingWindow;->getFrameWindowY()I

    move-result v24

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Lcom/lge/app/floating/FloatingWindow;->getFrameWindowH()I

    move-result v25

    add-int v22, v24, v25

    .local v22, "windowBottom":I
    move-object/from16 v0, p1

    iget v0, v0, Landroid/graphics/Rect;->bottom:I

    move/from16 v24, v0

    const/16 v25, 0x0

    invoke-static/range {v24 .. v25}, Ljava/lang/Math;->max(II)I

    move-result v8

    .local v8, "overlapWithIME":I
    sub-int v24, v22, v15

    const/16 v25, 0x0

    invoke-static/range {v24 .. v25}, Ljava/lang/Math;->max(II)I

    move-result v9

    .local v9, "overlapWithScreenBottom":I
    add-int v20, v8, v9

    .local v20, "totalOffsetY":I
    sget-object v24, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    const-string v26, "fitSystemWindows windowBottom="

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, v25

    move/from16 v1, v22

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    const-string v26, " overlapIME="

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, v25

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    const-string v26, " overlapScreenBottom="

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, v25

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v24

    invoke-virtual/range {v24 .. v24}, Lcom/lge/app/floating/FloatingWindow;->getTitleWindowY()I

    move-result v24

    sub-int v23, v24, v20

    .local v23, "windowTop":I
    sub-int v24, v16, v23

    const/16 v25, 0x0

    invoke-static/range {v24 .. v25}, Ljava/lang/Math;->max(II)I

    move-result v10

    .local v10, "overlapWithStatusBar":I
    move/from16 v19, v10

    .local v19, "totalOffsetH":I
    sget-object v24, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    const-string v26, "fitSystemWindows windowTop="

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, v25

    move/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    const-string v26, " overlapStatusBar="

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, v25

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v24

    move-object/from16 v0, v24

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    move/from16 v24, v0

    sub-int v24, v24, v20

    add-int v7, v24, v19

    .local v7, "newY":I
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v24

    move-object/from16 v0, v24

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    move/from16 v24, v0

    sub-int v6, v24, v19

    .local v6, "newH":I
    sget-object v24, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    new-instance v25, Ljava/lang/StringBuilder;

    invoke-direct/range {v25 .. v25}, Ljava/lang/StringBuilder;-><init>()V

    const-string v26, "fitSystemWindows offsetY="

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, v25

    move/from16 v1, v20

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    const-string v26, " offsetH="

    invoke-virtual/range {v25 .. v26}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v25

    move-object/from16 v0, v25

    move/from16 v1, v19

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v25

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v24

    move-object/from16 v0, v24

    iput v7, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v24

    invoke-virtual/range {v24 .. v24}, Lcom/lge/app/floating/FloatingWindow;->getTitleWindowY()I

    move-result v24

    if-gtz v24, :cond_7

    sget-object v24, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    const-string v25, "fitSystemWindows getWindow().getTitleWindowY() <= 0"

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :cond_7
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v24

    move-object/from16 v0, v24

    iput v6, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getPadding()Landroid/graphics/Rect;

    move-result-object v11

    .local v11, "padding":Landroid/graphics/Rect;
    const/16 v24, 0x2

    move/from16 v0, v24

    new-array v5, v0, [I

    .local v5, "frameLocation":[I
    move-object/from16 v0, p0

    invoke-virtual {v0, v5}, Lcom/lge/app/floating/FrameView;->getLocationOnScreen([I)V

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v24

    const/16 v25, 0x0

    aget v25, v5, v25

    iget v0, v11, Landroid/graphics/Rect;->left:I

    move/from16 v26, v0

    add-int v25, v25, v26

    move/from16 v0, v25

    move-object/from16 v1, v24

    iput v0, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v24

    invoke-virtual/range {v24 .. v24}, Lcom/lge/app/floating/FloatingWindow;->updateRealPositionAndSize()V

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v12

    check-cast v12, Landroid/view/WindowManager$LayoutParams;

    .local v12, "params":Landroid/view/WindowManager$LayoutParams;
    const/16 v24, 0x0

    const/16 v25, 0x0

    const/16 v26, 0x0

    const/16 v27, 0x0

    move-object/from16 v0, p0

    move/from16 v1, v24

    move/from16 v2, v25

    move/from16 v3, v26

    move/from16 v4, v27

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/lge/app/floating/FrameView;->setPaddingRelative(IIII)V

    iget v0, v12, Landroid/view/WindowManager$LayoutParams;->y:I

    move/from16 v24, v0

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Lcom/lge/app/floating/FloatingWindow;->getFrameWindowY()I

    move-result v25

    move/from16 v0, v24

    move/from16 v1, v25

    if-ne v0, v1, :cond_8

    iget v0, v12, Landroid/view/WindowManager$LayoutParams;->height:I

    move/from16 v24, v0

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Lcom/lge/app/floating/FloatingWindow;->getFrameWindowH()I

    move-result v25

    move/from16 v0, v24

    move/from16 v1, v25

    if-eq v0, v1, :cond_9

    :cond_8
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v24

    invoke-virtual/range {v24 .. v24}, Lcom/lge/app/floating/FloatingWindow;->getFrameWindowY()I

    move-result v24

    move/from16 v0, v24

    iput v0, v12, Landroid/view/WindowManager$LayoutParams;->y:I

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v24

    invoke-virtual/range {v24 .. v24}, Lcom/lge/app/floating/FloatingWindow;->getFrameWindowH()I

    move-result v24

    move/from16 v0, v24

    iput v0, v12, Landroid/view/WindowManager$LayoutParams;->height:I

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v24

    move-object/from16 v0, v24

    move-object/from16 v1, p0

    invoke-virtual {v0, v1, v12}, Lcom/lge/app/floating/FloatingWindow;->updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    sget-object v24, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    const-string v25, "fitSystemWindows update frame view"

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :cond_9
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v24

    move-object/from16 v0, v24

    iget-boolean v0, v0, Lcom/lge/app/floating/FloatingWindow;->mIsTitleInSeparateWindow:Z

    move/from16 v24, v0

    if-eqz v24, :cond_a

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v24

    invoke-virtual/range {v24 .. v24}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v24

    invoke-virtual/range {v24 .. v24}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v18

    check-cast v18, Landroid/view/WindowManager$LayoutParams;

    .local v18, "titleParams":Landroid/view/WindowManager$LayoutParams;
    move-object/from16 v0, v18

    iget v0, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    move/from16 v24, v0

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Lcom/lge/app/floating/FloatingWindow;->getTitleWindowY()I

    move-result v25

    move/from16 v0, v24

    move/from16 v1, v25

    if-eq v0, v1, :cond_a

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v24

    invoke-virtual/range {v24 .. v24}, Lcom/lge/app/floating/FloatingWindow;->getTitleWindowY()I

    move-result v24

    move/from16 v0, v24

    move-object/from16 v1, v18

    iput v0, v1, Landroid/view/WindowManager$LayoutParams;->y:I

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v24

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v25

    invoke-virtual/range {v25 .. v25}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v25

    move-object/from16 v0, v24

    move-object/from16 v1, v25

    move-object/from16 v2, v18

    invoke-virtual {v0, v1, v2}, Lcom/lge/app/floating/FloatingWindow;->updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    sget-object v24, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    const-string v25, "fitSystemWindows update title view"

    invoke-static/range {v24 .. v25}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .end local v18    # "titleParams":Landroid/view/WindowManager$LayoutParams;
    :cond_a
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->invalidate()V

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v24

    invoke-virtual/range {v24 .. v24}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v24

    invoke-virtual/range {v24 .. v24}, Landroid/view/View;->invalidate()V

    goto/16 :goto_0
.end method

.method public getAttachedTime()J
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/app/floating/FrameView;->mAttachedWhen:J

    return-wide v0
.end method

.method public getContentView()Landroid/view/View;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/app/floating/FrameView;->mContent:Landroid/view/View;

    return-object v0
.end method

.method public getPadding()Landroid/graphics/Rect;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/app/floating/FrameView;->mPadding:Landroid/graphics/Rect;

    return-object v0
.end method

.method public getRealView()Landroid/view/View;
    .locals 0

    .prologue
    return-object p0
.end method

.method public getResizeHandleVisibility()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/app/floating/FrameView;->mResizeHandle:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    return v0
.end method

.method public onAttachedToWindow()V
    .locals 2

    .prologue
    sget-object v0, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    const-string v1, "onAttachedToWindow"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-super {p0}, Lcom/lge/app/floating/QslideView;->onAttachedToWindow()V

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/app/floating/FloatingWindow;->onAttachedToWindowFrameView()V

    iget-object v0, p0, Lcom/lge/app/floating/FrameView;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v0}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    const-string v1, "Qwindow"

    invoke-virtual {v0, v1}, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V

    const/16 v0, 0x20

    invoke-virtual {p0, v0}, Lcom/lge/app/floating/FrameView;->sendAccessibilityEvent(I)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/lge/app/floating/FrameView;->mAttachedWhen:J

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/app/floating/FloatingWindow;->onAttachedToWindowFrameView()V

    return-void
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 23
    .param p1, "newConfig"    # Landroid/content/res/Configuration;

    .prologue
    invoke-super/range {p0 .. p1}, Lcom/lge/app/floating/QslideView;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Lcom/lge/app/floating/FloatingWindow;->getBounceAnimator()Landroid/animation/ValueAnimator;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Landroid/animation/ValueAnimator;->isRunning()Z

    move-result v18

    if-eqz v18, :cond_0

    sget-object v18, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    const-string v19, "configuration changed : cancel bounceAnimator"

    invoke-static/range {v18 .. v19}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Lcom/lge/app/floating/FloatingWindow;->getBounceAnimator()Landroid/animation/ValueAnimator;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Landroid/animation/ValueAnimator;->cancel()V

    :cond_0
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->isWindowAttached()Z

    move-result v18

    if-eqz v18, :cond_2

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->findFocus()Landroid/view/View;

    move-result-object v17

    .local v17, "view":Landroid/view/View;
    if-eqz v17, :cond_1

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v18

    move-object/from16 v0, v18

    iget-boolean v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->dontUseIme:Z

    move/from16 v18, v0

    if-eqz v18, :cond_1

    move-object/from16 v0, v17

    instance-of v0, v0, Landroid/widget/EditText;

    move/from16 v18, v0

    if-eqz v18, :cond_1

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v13

    check-cast v13, Landroid/view/WindowManager$LayoutParams;

    .local v13, "params":Landroid/view/WindowManager$LayoutParams;
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    move-object/from16 v0, v18

    move-object/from16 v1, p0

    invoke-virtual {v0, v1, v13}, Lcom/lge/app/floating/FloatingWindow;->updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    .end local v13    # "params":Landroid/view/WindowManager$LayoutParams;
    :cond_1
    move-object/from16 v0, v17

    instance-of v0, v0, Landroid/widget/EditText;

    move/from16 v18, v0

    if-eqz v18, :cond_2

    invoke-direct/range {p0 .. p1}, Lcom/lge/app/floating/FrameView;->adjustSoftInputOnConfigurationChange(Landroid/content/res/Configuration;)V

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    move-object/from16 v0, v18

    iget-object v0, v0, Lcom/lge/app/floating/FloatingWindow;->mSavedConfig:Landroid/content/res/Configuration;

    move-object/from16 v18, v0

    move-object/from16 v0, v18

    iget v0, v0, Landroid/content/res/Configuration;->orientation:I

    move/from16 v18, v0

    move-object/from16 v0, p1

    iget v0, v0, Landroid/content/res/Configuration;->orientation:I

    move/from16 v19, v0

    move/from16 v0, v18

    move/from16 v1, v19

    if-eq v0, v1, :cond_2

    new-instance v8, Landroid/content/Intent;

    const-string v18, "com.lge.systemservice.core.cliptray.INPUTTYPE_CLIPTRAY"

    move-object/from16 v0, v18

    invoke-direct {v8, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v8, "intent":Landroid/content/Intent;
    const-string v18, "Inputtype"

    const/16 v19, 0xa

    move-object/from16 v0, v18

    move/from16 v1, v19

    invoke-virtual {v8, v0, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    :try_start_0
    invoke-static {}, Lcom/lge/app/floating/Res;->getResPackageContext()Landroid/content/Context;

    move-result-object v18

    move-object/from16 v0, v18

    invoke-virtual {v0, v8}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v8    # "intent":Landroid/content/Intent;
    .end local v17    # "view":Landroid/view/View;
    :cond_2
    :goto_0
    move-object/from16 v0, p1

    iget v0, v0, Landroid/content/res/Configuration;->orientation:I

    move/from16 v18, v0

    const/16 v19, 0x1

    move/from16 v0, v18

    move/from16 v1, v19

    if-ne v0, v1, :cond_9

    const/4 v9, 0x1

    .local v9, "isPortrait":Z
    :goto_1
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FrameView;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    move-object/from16 v18, v0

    invoke-virtual/range {v18 .. v18}, Lcom/lge/app/floating/FloatableActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v4

    .local v4, "display":Landroid/util/DisplayMetrics;
    const/4 v10, 0x0

    .local v10, "newX":I
    const/4 v11, 0x0

    .local v11, "newY":I
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Lcom/lge/app/floating/FloatingWindow;->isPortrait()Z

    move-result v18

    move/from16 v0, v18

    if-eq v9, v0, :cond_8

    sget-object v18, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    const-string v19, "onConfigurationChanged"

    invoke-static/range {v18 .. v19}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v18, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    new-instance v19, Ljava/lang/StringBuilder;

    invoke-direct/range {v19 .. v19}, Ljava/lang/StringBuilder;-><init>()V

    const-string v20, "getWindowLayoutParams="

    invoke-virtual/range {v19 .. v20}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->toString()Ljava/lang/String;

    move-result-object v20

    invoke-virtual/range {v19 .. v20}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    invoke-virtual/range {v19 .. v19}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v19

    invoke-static/range {v18 .. v19}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v19

    invoke-virtual/range {v18 .. v19}, Lcom/lge/app/floating/FloatingWindow;->calculateFloatingWindowSize(Lcom/lge/app/floating/FloatingWindow$LayoutParams;)[I

    move-result-object v6

    .local v6, "floatingWindowSize":[I
    const/16 v18, 0x0

    aget v18, v6, v18

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v19

    move-object/from16 v0, v19

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    move/from16 v19, v0

    move/from16 v0, v18

    move/from16 v1, v19

    if-ne v0, v1, :cond_3

    const/16 v18, 0x1

    aget v18, v6, v18

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v19

    move-object/from16 v0, v19

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    move/from16 v19, v0

    move/from16 v0, v18

    move/from16 v1, v19

    if-eq v0, v1, :cond_4

    :cond_3
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    move-object/from16 v0, v18

    iget-object v0, v0, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    move-object/from16 v18, v0

    if-eqz v18, :cond_4

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    move-object/from16 v0, v18

    iget-object v0, v0, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    move-object/from16 v18, v0

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v19

    const/16 v20, 0x0

    aget v20, v6, v20

    const/16 v21, 0x1

    aget v21, v6, v21

    invoke-interface/range {v18 .. v21}, Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;->onResizeFinished(Lcom/lge/app/floating/FloatingWindow;II)V

    :cond_4
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    move-object/from16 v0, v18

    iget-boolean v0, v0, Lcom/lge/app/floating/FloatingWindow;->mIsImeVisible:Z

    move/from16 v18, v0

    if-eqz v18, :cond_5

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getPadding()Landroid/graphics/Rect;

    move-result-object v12

    .local v12, "padding":Landroid/graphics/Rect;
    const/16 v18, 0x2

    move/from16 v0, v18

    new-array v7, v0, [I

    .local v7, "frameLocation":[I
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v18

    move-object/from16 v0, v18

    invoke-virtual {v0, v7}, Landroid/view/View;->getLocationOnScreen([I)V

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v18

    const/16 v19, 0x0

    aget v19, v7, v19

    iget v0, v12, Landroid/graphics/Rect;->left:I

    move/from16 v20, v0

    add-int v19, v19, v20

    move/from16 v0, v19

    move-object/from16 v1, v18

    iput v0, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v18

    const/16 v19, 0x1

    aget v19, v7, v19

    iget v0, v12, Landroid/graphics/Rect;->top:I

    move/from16 v20, v0

    add-int v19, v19, v20

    move/from16 v0, v19

    move-object/from16 v1, v18

    iput v0, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    .end local v7    # "frameLocation":[I
    .end local v12    # "padding":Landroid/graphics/Rect;
    :cond_5
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FrameView;->mDisplay:Landroid/util/DisplayMetrics;

    move-object/from16 v19, v0

    move-object/from16 v0, v19

    iget v0, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    move/from16 v19, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FrameView;->mDisplay:Landroid/util/DisplayMetrics;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget v0, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    move/from16 v20, v0

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v21

    move-object/from16 v0, v21

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    move/from16 v21, v0

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v22

    move-object/from16 v0, v22

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    move/from16 v22, v0

    div-int/lit8 v22, v22, 0x2

    add-int v21, v21, v22

    invoke-virtual/range {v18 .. v21}, Lcom/lge/app/floating/FloatingWindow;->calculateLocationRatio(III)I

    move-result v10

    const/16 v18, 0x0

    aget v18, v6, v18

    div-int/lit8 v18, v18, 0x2

    sub-int v10, v10, v18

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FrameView;->mDisplay:Landroid/util/DisplayMetrics;

    move-object/from16 v19, v0

    move-object/from16 v0, v19

    iget v0, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    move/from16 v19, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FrameView;->mDisplay:Landroid/util/DisplayMetrics;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget v0, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    move/from16 v20, v0

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v21

    move-object/from16 v0, v21

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    move/from16 v21, v0

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v22

    move-object/from16 v0, v22

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    move/from16 v22, v0

    div-int/lit8 v22, v22, 0x2

    add-int v21, v21, v22

    invoke-virtual/range {v18 .. v21}, Lcom/lge/app/floating/FloatingWindow;->calculateLocationRatio(III)I

    move-result v11

    const/16 v18, 0x1

    aget v18, v6, v18

    div-int/lit8 v18, v18, 0x2

    sub-int v11, v11, v18

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    move-object/from16 v0, v18

    invoke-virtual {v0, v11}, Lcom/lge/app/floating/FloatingWindow;->calculateFloatingWindowLocationY(I)I

    move-result v11

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    move-object/from16 v0, v18

    invoke-virtual {v0, v10, v11}, Lcom/lge/app/floating/FloatingWindow;->calculateCorrectPosition(II)Landroid/graphics/Rect;

    move-result-object v15

    .local v15, "rect":Landroid/graphics/Rect;
    iget v10, v15, Landroid/graphics/Rect;->left:I

    iget v11, v15, Landroid/graphics/Rect;->top:I

    if-nez v9, :cond_a

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v19

    move-object/from16 v0, v19

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    move/from16 v19, v0

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v20

    move-object/from16 v0, v20

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    move/from16 v20, v0

    div-int/lit8 v20, v20, 0x2

    add-int v19, v19, v20

    move/from16 v0, v19

    move-object/from16 v1, v18

    iput v0, v1, Lcom/lge/app/floating/FloatingWindow;->mSavedPortraitX:I

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v19

    move-object/from16 v0, v19

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    move/from16 v19, v0

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v20

    move-object/from16 v0, v20

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    move/from16 v20, v0

    div-int/lit8 v20, v20, 0x2

    add-int v19, v19, v20

    move/from16 v0, v19

    move-object/from16 v1, v18

    iput v0, v1, Lcom/lge/app/floating/FloatingWindow;->mSavedPortraitY:I

    :goto_2
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    sget-boolean v18, Lcom/lge/app/floating/FloatingWindow;->sSavedLocation:Z

    if-eqz v18, :cond_c

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    move-object/from16 v0, v18

    iget-boolean v0, v0, Lcom/lge/app/floating/FloatingWindow;->mIsImeVisible:Z

    move/from16 v18, v0

    if-nez v18, :cond_c

    if-eqz v9, :cond_b

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v18

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v19

    move-object/from16 v0, v19

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow;->mSavedPortraitX:I

    move/from16 v19, v0

    const/16 v20, 0x0

    aget v20, v6, v20

    div-int/lit8 v20, v20, 0x2

    sub-int v19, v19, v20

    move/from16 v0, v19

    move-object/from16 v1, v18

    iput v0, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v18

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v19

    move-object/from16 v0, v19

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow;->mSavedPortraitY:I

    move/from16 v19, v0

    const/16 v20, 0x1

    aget v20, v6, v20

    div-int/lit8 v20, v20, 0x2

    sub-int v19, v19, v20

    move/from16 v0, v19

    move-object/from16 v1, v18

    iput v0, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    :goto_3
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v18

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v19

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v20

    move-object/from16 v0, v20

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    move/from16 v20, v0

    invoke-virtual/range {v19 .. v20}, Lcom/lge/app/floating/FloatingWindow;->calculateFloatingWindowLocationY(I)I

    move-result v19

    move/from16 v0, v19

    move-object/from16 v1, v18

    iput v0, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v19

    move-object/from16 v0, v19

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    move/from16 v19, v0

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v20

    move-object/from16 v0, v20

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    move/from16 v20, v0

    invoke-virtual/range {v18 .. v20}, Lcom/lge/app/floating/FloatingWindow;->calculateCorrectPosition(II)Landroid/graphics/Rect;

    move-result-object v14

    .local v14, "r":Landroid/graphics/Rect;
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v18

    iget v0, v14, Landroid/graphics/Rect;->left:I

    move/from16 v19, v0

    move/from16 v0, v19

    move-object/from16 v1, v18

    iput v0, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v18

    iget v0, v14, Landroid/graphics/Rect;->top:I

    move/from16 v19, v0

    move/from16 v0, v19

    move-object/from16 v1, v18

    iput v0, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    .end local v14    # "r":Landroid/graphics/Rect;
    :goto_4
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v18

    const/16 v19, 0x0

    aget v19, v6, v19

    move/from16 v0, v19

    move-object/from16 v1, v18

    iput v0, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v18

    const/16 v19, 0x1

    aget v19, v6, v19

    move/from16 v0, v19

    move-object/from16 v1, v18

    iput v0, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Lcom/lge/app/floating/FloatingWindow;->getTitleViewInterface()Lcom/lge/app/floating/ITitleView;

    move-result-object v18

    invoke-interface/range {v18 .. v18}, Lcom/lge/app/floating/ITitleView;->getMinimumWidth()I

    move-result v18

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v19

    move-object/from16 v0, v19

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    move/from16 v19, v0

    move/from16 v0, v18

    move/from16 v1, v19

    if-le v0, v1, :cond_6

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Lcom/lge/app/floating/FloatingWindow;->getTitleViewInterface()Lcom/lge/app/floating/ITitleView;

    move-result-object v18

    invoke-interface/range {v18 .. v18}, Lcom/lge/app/floating/ITitleView;->getMinimumWidth()I

    move-result v18

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v19

    move-object/from16 v0, v19

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    move/from16 v19, v0

    sub-int v3, v18, v19

    .local v3, "diff":I
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Lcom/lge/app/floating/FloatingWindow;->getTitleViewInterface()Lcom/lge/app/floating/ITitleView;

    move-result-object v18

    invoke-interface/range {v18 .. v18}, Lcom/lge/app/floating/ITitleView;->getOpacitySlider()Landroid/widget/SeekBar;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Landroid/widget/SeekBar;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v16

    .local v16, "sliderParams":Landroid/view/ViewGroup$LayoutParams;
    move-object/from16 v0, v16

    iget v0, v0, Landroid/view/ViewGroup$LayoutParams;->width:I

    move/from16 v18, v0

    sub-int v18, v18, v3

    move/from16 v0, v18

    move-object/from16 v1, v16

    iput v0, v1, Landroid/view/ViewGroup$LayoutParams;->width:I

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Lcom/lge/app/floating/FloatingWindow;->getTitleViewInterface()Lcom/lge/app/floating/ITitleView;

    move-result-object v18

    invoke-interface/range {v18 .. v18}, Lcom/lge/app/floating/ITitleView;->getOpacitySlider()Landroid/widget/SeekBar;

    move-result-object v18

    move-object/from16 v0, v18

    move-object/from16 v1, v16

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .end local v3    # "diff":I
    .end local v16    # "sliderParams":Landroid/view/ViewGroup$LayoutParams;
    :cond_6
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    const/16 v19, 0x0

    move-object/from16 v0, v19

    move-object/from16 v1, v18

    iput-object v0, v1, Lcom/lge/app/floating/FloatingWindow;->mSavedLayoutParams:Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    sget-object v18, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    new-instance v19, Ljava/lang/StringBuilder;

    invoke-direct/range {v19 .. v19}, Ljava/lang/StringBuilder;-><init>()V

    const-string v20, "getWindowLayoutParams="

    invoke-virtual/range {v19 .. v20}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->toString()Ljava/lang/String;

    move-result-object v20

    invoke-virtual/range {v19 .. v20}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    invoke-virtual/range {v19 .. v19}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v19

    invoke-static/range {v18 .. v19}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v19

    invoke-virtual/range {v18 .. v19}, Lcom/lge/app/floating/FloatingWindow;->updateLayoutParamsInner(Lcom/lge/app/floating/FloatingWindow$LayoutParams;)V

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    const/16 v18, 0x1

    sput-boolean v18, Lcom/lge/app/floating/FloatingWindow;->sSavedLocation:Z

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->resetResizeFrame()Z

    move-result v18

    if-eqz v18, :cond_7

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->updateResizeHandle()V

    :cond_7
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FrameView;->mDisplay:Landroid/util/DisplayMetrics;

    move-object/from16 v18, v0

    iget v0, v4, Landroid/util/DisplayMetrics;->widthPixels:I

    move/from16 v19, v0

    move/from16 v0, v19

    move-object/from16 v1, v18

    iput v0, v1, Landroid/util/DisplayMetrics;->widthPixels:I

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FrameView;->mDisplay:Landroid/util/DisplayMetrics;

    move-object/from16 v18, v0

    iget v0, v4, Landroid/util/DisplayMetrics;->heightPixels:I

    move/from16 v19, v0

    move/from16 v0, v19

    move-object/from16 v1, v18

    iput v0, v1, Landroid/util/DisplayMetrics;->heightPixels:I

    .end local v6    # "floatingWindowSize":[I
    .end local v15    # "rect":Landroid/graphics/Rect;
    :cond_8
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v19

    move-object/from16 v0, p1

    iget v0, v0, Landroid/content/res/Configuration;->orientation:I

    move/from16 v18, v0

    const/16 v20, 0x1

    move/from16 v0, v18

    move/from16 v1, v20

    if-ne v0, v1, :cond_e

    const/16 v18, 0x1

    :goto_5
    move/from16 v0, v18

    move-object/from16 v1, v19

    iput-boolean v0, v1, Lcom/lge/app/floating/FloatingWindow;->mIsPortrait:Z

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Lcom/lge/app/floating/FloatingWindow;->bounceFloatingWindow()V

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v19

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v18

    check-cast v18, Landroid/view/WindowManager$LayoutParams;

    move-object/from16 v0, v19

    move-object/from16 v1, p0

    move-object/from16 v2, v18

    invoke-virtual {v0, v1, v2}, Lcom/lge/app/floating/FloatingWindow;->updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v19

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v20

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v18

    check-cast v18, Landroid/view/WindowManager$LayoutParams;

    move-object/from16 v0, v19

    move-object/from16 v1, v20

    move-object/from16 v2, v18

    invoke-virtual {v0, v1, v2}, Lcom/lge/app/floating/FloatingWindow;->updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->postInvalidate()V

    return-void

    .end local v4    # "display":Landroid/util/DisplayMetrics;
    .end local v9    # "isPortrait":Z
    .end local v10    # "newX":I
    .end local v11    # "newY":I
    .restart local v8    # "intent":Landroid/content/Intent;
    .restart local v17    # "view":Landroid/view/View;
    :catch_0
    move-exception v5

    .local v5, "e":Ljava/lang/Exception;
    sget-object v18, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    new-instance v19, Ljava/lang/StringBuilder;

    invoke-direct/range {v19 .. v19}, Ljava/lang/StringBuilder;-><init>()V

    const-string v20, "Exception occured in send Broadcast CLIPTRAY_INPUTTYPE : "

    invoke-virtual/range {v19 .. v20}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    invoke-virtual {v5}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v20

    invoke-virtual/range {v19 .. v20}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    invoke-virtual/range {v19 .. v19}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v19

    invoke-static/range {v18 .. v19}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .end local v5    # "e":Ljava/lang/Exception;
    .end local v8    # "intent":Landroid/content/Intent;
    .end local v17    # "view":Landroid/view/View;
    :cond_9
    const/4 v9, 0x0

    goto/16 :goto_1

    .restart local v4    # "display":Landroid/util/DisplayMetrics;
    .restart local v6    # "floatingWindowSize":[I
    .restart local v9    # "isPortrait":Z
    .restart local v10    # "newX":I
    .restart local v11    # "newY":I
    .restart local v15    # "rect":Landroid/graphics/Rect;
    :cond_a
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v19

    move-object/from16 v0, v19

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    move/from16 v19, v0

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v20

    move-object/from16 v0, v20

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    move/from16 v20, v0

    div-int/lit8 v20, v20, 0x2

    add-int v19, v19, v20

    move/from16 v0, v19

    move-object/from16 v1, v18

    iput v0, v1, Lcom/lge/app/floating/FloatingWindow;->mSavedLandscapeX:I

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v19

    move-object/from16 v0, v19

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    move/from16 v19, v0

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v20

    move-object/from16 v0, v20

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    move/from16 v20, v0

    div-int/lit8 v20, v20, 0x2

    add-int v19, v19, v20

    move/from16 v0, v19

    move-object/from16 v1, v18

    iput v0, v1, Lcom/lge/app/floating/FloatingWindow;->mSavedLandscapeY:I

    goto/16 :goto_2

    :cond_b
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v18

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v19

    move-object/from16 v0, v19

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow;->mSavedLandscapeX:I

    move/from16 v19, v0

    const/16 v20, 0x0

    aget v20, v6, v20

    div-int/lit8 v20, v20, 0x2

    sub-int v19, v19, v20

    move/from16 v0, v19

    move-object/from16 v1, v18

    iput v0, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v18

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v19

    move-object/from16 v0, v19

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow;->mSavedLandscapeY:I

    move/from16 v19, v0

    const/16 v20, 0x1

    aget v20, v6, v20

    div-int/lit8 v20, v20, 0x2

    sub-int v19, v19, v20

    move/from16 v0, v19

    move-object/from16 v1, v18

    iput v0, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    goto/16 :goto_3

    :cond_c
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v18

    move-object/from16 v0, v18

    iput v10, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v18

    move-object/from16 v0, v18

    iget-boolean v0, v0, Lcom/lge/app/floating/FloatingWindow;->mIsImeVisible:Z

    move/from16 v18, v0

    if-eqz v18, :cond_d

    if-eqz v9, :cond_d

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v18

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FrameView;->mResources:Landroid/content/res/Resources;

    move-object/from16 v19, v0

    const v20, 0x7f060001

    invoke-virtual/range {v19 .. v20}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v19

    move/from16 v0, v19

    move-object/from16 v1, v18

    iput v0, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    goto/16 :goto_4

    :cond_d
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v18

    move-object/from16 v0, v18

    iput v11, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    goto/16 :goto_4

    .end local v6    # "floatingWindowSize":[I
    .end local v15    # "rect":Landroid/graphics/Rect;
    :cond_e
    const/16 v18, 0x0

    goto/16 :goto_5
.end method

.method public onCreateInputConnection(Landroid/view/inputmethod/EditorInfo;)Landroid/view/inputmethod/InputConnection;
    .locals 1
    .param p1, "outAttrs"    # Landroid/view/inputmethod/EditorInfo;

    .prologue
    const/high16 v0, 0x12000000

    iput v0, p1, Landroid/view/inputmethod/EditorInfo;->imeOptions:I

    invoke-super {p0, p1}, Lcom/lge/app/floating/QslideView;->onCreateInputConnection(Landroid/view/inputmethod/EditorInfo;)Landroid/view/inputmethod/InputConnection;

    move-result-object v0

    return-object v0
.end method

.method protected onDetachedFromWindow()V
    .locals 6

    .prologue
    iget-object v4, p0, Lcom/lge/app/floating/FrameView;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v4}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v4

    invoke-virtual {v4}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/view/ViewGroup;

    .local v2, "decorView":Landroid/view/ViewGroup;
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    invoke-virtual {v2}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v4

    if-ge v3, v4, :cond_0

    invoke-virtual {v2, v3}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    .local v0, "child":Landroid/view/View;
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    .local v1, "childName":Ljava/lang/String;
    if-nez v1, :cond_1

    sget-object v4, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    const-string v5, "Cannot onDetachedFromWindow - Fail to getSimpleName"

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .end local v0    # "child":Landroid/view/View;
    .end local v1    # "childName":Ljava/lang/String;
    :cond_0
    :goto_1
    return-void

    .restart local v0    # "child":Landroid/view/View;
    .restart local v1    # "childName":Ljava/lang/String;
    :cond_1
    const-string v4, "ActionBarContextView"

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    invoke-virtual {v2, v0}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    iget-object v4, p0, Lcom/lge/app/floating/FrameView;->mActionModeBarParent:Landroid/view/ViewGroup;

    if-eqz v4, :cond_0

    iget-object v4, p0, Lcom/lge/app/floating/FrameView;->mActionModeBarParent:Landroid/view/ViewGroup;

    invoke-virtual {v4, v0}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    goto :goto_1

    .end local v1    # "childName":Ljava/lang/String;
    :cond_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_0
.end method

.method public onInitializeAccessibilityEvent(Landroid/view/accessibility/AccessibilityEvent;)V
    .locals 3
    .param p1, "event"    # Landroid/view/accessibility/AccessibilityEvent;

    .prologue
    invoke-super {p0, p1}, Lcom/lge/app/floating/QslideView;->onInitializeAccessibilityEvent(Landroid/view/accessibility/AccessibilityEvent;)V

    sget-object v0, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "on populate accessibility event. event="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Landroid/view/accessibility/AccessibilityEvent;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public onInterceptTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 11
    .param p1, "event"    # Landroid/view/MotionEvent;

    .prologue
    const/4 v10, 0x2

    const/4 v7, 0x0

    const/4 v6, 0x1

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v8

    if-nez v8, :cond_2

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v8

    iput v8, p0, Lcom/lge/app/floating/FrameView;->mDownX:F

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v8

    iput v8, p0, Lcom/lge/app/floating/FrameView;->mDownY:F

    new-array v0, v10, [I

    .local v0, "frameViewLocation":[I
    new-instance v1, Landroid/graphics/Rect;

    invoke-direct {v1}, Landroid/graphics/Rect;-><init>()V

    .local v1, "moveEnabledLocation":Landroid/graphics/Rect;
    iget-object v8, p0, Lcom/lge/app/floating/FrameView;->mResources:Landroid/content/res/Resources;

    const v9, 0x7f060006

    invoke-virtual {v8, v9}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v8

    int-to-float v8, v8

    invoke-static {v8}, Ljava/lang/Math;->round(F)I

    move-result v2

    .local v2, "moving_area_height":I
    invoke-virtual {p0, v0}, Lcom/lge/app/floating/FrameView;->getLocationOnScreen([I)V

    aget v8, v0, v7

    iput v8, v1, Landroid/graphics/Rect;->left:I

    aget v8, v0, v6

    iput v8, v1, Landroid/graphics/Rect;->top:I

    aget v8, v0, v7

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWidth()I

    move-result v9

    add-int/2addr v8, v9

    iput v8, v1, Landroid/graphics/Rect;->right:I

    aget v8, v0, v6

    add-int/2addr v8, v2

    iput v8, v1, Landroid/graphics/Rect;->bottom:I

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v8

    float-to-int v8, v8

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v9

    float-to-int v9, v9

    invoke-virtual {v1, v8, v9}, Landroid/graphics/Rect;->contains(II)Z

    move-result v8

    if-eqz v8, :cond_1

    iput-boolean v6, p0, Lcom/lge/app/floating/FrameView;->moveEnabled:Z

    .end local v0    # "frameViewLocation":[I
    .end local v1    # "moveEnabledLocation":Landroid/graphics/Rect;
    .end local v2    # "moving_area_height":I
    :cond_0
    :goto_0
    return v6

    .restart local v0    # "frameViewLocation":[I
    .restart local v1    # "moveEnabledLocation":Landroid/graphics/Rect;
    .restart local v2    # "moving_area_height":I
    :cond_1
    iput-boolean v7, p0, Lcom/lge/app/floating/FrameView;->moveEnabled:Z

    .end local v0    # "frameViewLocation":[I
    .end local v1    # "moveEnabledLocation":Landroid/graphics/Rect;
    .end local v2    # "moving_area_height":I
    :cond_2
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v8

    if-ne v8, v10, :cond_5

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v8

    iget v9, p0, Lcom/lge/app/floating/FrameView;->mDownX:F

    sub-float/2addr v8, v9

    invoke-static {v8}, Ljava/lang/Math;->abs(F)F

    move-result v8

    float-to-int v4, v8

    .local v4, "xMove":I
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v8

    iget v9, p0, Lcom/lge/app/floating/FrameView;->mDownY:F

    sub-float/2addr v8, v9

    invoke-static {v8}, Ljava/lang/Math;->abs(F)F

    move-result v8

    float-to-int v5, v8

    .local v5, "yMove":I
    iget-object v8, p0, Lcom/lge/app/floating/FrameView;->mResources:Landroid/content/res/Resources;

    const v9, 0x7f060005

    invoke-virtual {v8, v9}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v3

    .local v3, "slop":I
    if-gt v4, v3, :cond_3

    if-le v5, v3, :cond_4

    :cond_3
    iget-boolean v8, p0, Lcom/lge/app/floating/FrameView;->moveEnabled:Z

    if-nez v8, :cond_0

    .end local v3    # "slop":I
    .end local v4    # "xMove":I
    .end local v5    # "yMove":I
    :cond_4
    move v6, v7

    goto :goto_0

    :cond_5
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v8

    if-eq v8, v6, :cond_6

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v8

    const/4 v9, 0x3

    if-ne v8, v9, :cond_4

    :cond_6
    iget-boolean v8, p0, Lcom/lge/app/floating/FrameView;->moveEnabled:Z

    if-eqz v8, :cond_4

    iput-boolean v7, p0, Lcom/lge/app/floating/FrameView;->moveEnabled:Z

    goto :goto_0
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 1
    .param p1, "keyCode"    # I
    .param p2, "event"    # Landroid/view/KeyEvent;

    .prologue
    iget-object v0, p0, Lcom/lge/app/floating/FrameView;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v0, p1, p2}, Lcom/lge/app/floating/FloatableActivity;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result v0

    return v0
.end method

.method public onKeyLongPress(ILandroid/view/KeyEvent;)Z
    .locals 1
    .param p1, "keyCode"    # I
    .param p2, "event"    # Landroid/view/KeyEvent;

    .prologue
    iget-object v0, p0, Lcom/lge/app/floating/FrameView;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v0, p1, p2}, Lcom/lge/app/floating/FloatableActivity;->onKeyLongPress(ILandroid/view/KeyEvent;)Z

    move-result v0

    return v0
.end method

.method public onKeyMultiple(IILandroid/view/KeyEvent;)Z
    .locals 1
    .param p1, "keyCode"    # I
    .param p2, "count"    # I
    .param p3, "event"    # Landroid/view/KeyEvent;

    .prologue
    iget-object v0, p0, Lcom/lge/app/floating/FrameView;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v0, p1, p2, p3}, Lcom/lge/app/floating/FloatableActivity;->onKeyMultiple(IILandroid/view/KeyEvent;)Z

    move-result v0

    return v0
.end method

.method public onKeyUp(ILandroid/view/KeyEvent;)Z
    .locals 1
    .param p1, "keyCode"    # I
    .param p2, "event"    # Landroid/view/KeyEvent;

    .prologue
    iget-object v0, p0, Lcom/lge/app/floating/FrameView;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v0, p1, p2}, Lcom/lge/app/floating/FloatableActivity;->onKeyUp(ILandroid/view/KeyEvent;)Z

    move-result v0

    return v0
.end method

.method protected onLayout(ZIIII)V
    .locals 3
    .param p1, "changed"    # Z
    .param p2, "l"    # I
    .param p3, "t"    # I
    .param p4, "r"    # I
    .param p5, "b"    # I

    .prologue
    invoke-super/range {p0 .. p5}, Lcom/lge/app/floating/QslideView;->onLayout(ZIIII)V

    if-eqz p1, :cond_0

    sget-object v0, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "FrameView onLayout changed : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    return-void
.end method

.method public onRequestSendAccessibilityEvent(Landroid/view/View;Landroid/view/accessibility/AccessibilityEvent;)Z
    .locals 4
    .param p1, "child"    # Landroid/view/View;
    .param p2, "event"    # Landroid/view/accessibility/AccessibilityEvent;

    .prologue
    sget-object v0, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "on request send accessibility. child="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Landroid/view/View;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " event="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p2}, Landroid/view/accessibility/AccessibilityEvent;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-wide v0, p0, Lcom/lge/app/floating/FrameView;->mAttachedWhen:J

    const-wide/16 v2, 0x3e8

    add-long/2addr v0, v2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    invoke-super {p0, p1, p2}, Lcom/lge/app/floating/QslideView;->onRequestSendAccessibilityEvent(Landroid/view/View;Landroid/view/accessibility/AccessibilityEvent;)Z

    move-result v0

    goto :goto_0
.end method

.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 8
    .param p1, "v"    # Landroid/view/View;
    .param p2, "event"    # Landroid/view/MotionEvent;

    .prologue
    const/4 v6, 0x4

    const/4 v7, 0x3

    const/4 v2, 0x1

    const/4 v1, 0x0

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v3

    invoke-virtual {v3}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/View;->getVisibility()I

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->resetResizeFrame()Z

    :goto_0
    return v1

    :cond_0
    iget-object v3, p0, Lcom/lge/app/floating/FrameView;->mResizeHandle:Landroid/view/View;

    if-ne p1, v3, :cond_c

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result v3

    if-nez v3, :cond_3

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v3

    iget v3, v3, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->resizeOption:I

    and-int/lit8 v3, v3, 0x7

    const/4 v4, 0x7

    if-ne v3, v4, :cond_1

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v3

    iget-boolean v3, v3, Lcom/lge/app/floating/FloatingWindow;->mIsImeVisible:Z

    if-eqz v3, :cond_1

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v3

    iget-boolean v3, v3, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->dontUseIme:Z

    if-nez v3, :cond_1

    sget-object v3, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    const-string v4, "Resize Option is PROPORTIONAL. Do not show & resize."

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v3

    invoke-virtual {v3, v1, v1}, Lcom/lge/app/floating/FloatingWindow;->setLayoutLimit(ZZ)V

    move v1, v2

    goto :goto_0

    :cond_1
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawX()F

    move-result v1

    float-to-int v1, v1

    iput v1, p0, Lcom/lge/app/floating/FrameView;->mWidthDown:I

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawY()F

    move-result v1

    float-to-int v1, v1

    iput v1, p0, Lcom/lge/app/floating/FrameView;->mHeightDown:I

    new-instance v1, Lcom/lge/app/floating/ResizeFrame;

    iget-object v3, p0, Lcom/lge/app/floating/FrameView;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    iget-object v4, p0, Lcom/lge/app/floating/FrameView;->mInflater:Landroid/view/LayoutInflater;

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v5

    invoke-direct {v1, v3, v4, v5}, Lcom/lge/app/floating/ResizeFrame;-><init>(Lcom/lge/app/floating/FloatableActivity;Landroid/view/LayoutInflater;Lcom/lge/app/floating/FloatingWindow;)V

    iput-object v1, p0, Lcom/lge/app/floating/FrameView;->mResizeFrame:Lcom/lge/app/floating/ResizeFrame;

    iget-object v1, p0, Lcom/lge/app/floating/FrameView;->mResizeHandle:Landroid/view/View;

    invoke-virtual {v1, v6}, Landroid/view/View;->setVisibility(I)V

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v1

    iget-object v1, v1, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    if-eqz v1, :cond_2

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v1

    iget-object v1, v1, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v3

    invoke-interface {v1, v3}, Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;->onResizeStarted(Lcom/lge/app/floating/FloatingWindow;)V

    :cond_2
    :goto_1
    move v1, v2

    goto :goto_0

    :cond_3
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result v3

    const/4 v4, 0x2

    if-ne v3, v4, :cond_7

    iget-object v3, p0, Lcom/lge/app/floating/FrameView;->mResizeFrame:Lcom/lge/app/floating/ResizeFrame;

    if-eqz v3, :cond_6

    iget-object v3, p0, Lcom/lge/app/floating/FrameView;->mResizeHandle:Landroid/view/View;

    invoke-virtual {v3}, Landroid/view/View;->getVisibility()I

    move-result v3

    if-nez v3, :cond_4

    iget-object v3, p0, Lcom/lge/app/floating/FrameView;->mResizeHandle:Landroid/view/View;

    invoke-virtual {v3, v6}, Landroid/view/View;->setVisibility(I)V

    :cond_4
    iget v3, p0, Lcom/lge/app/floating/FrameView;->mActionMoveCount:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/lge/app/floating/FrameView;->mActionMoveCount:I

    if-nez v3, :cond_5

    iget-object v3, p0, Lcom/lge/app/floating/FrameView;->mResizeFrame:Lcom/lge/app/floating/ResizeFrame;

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v4

    iget v4, v4, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawX()F

    move-result v5

    float-to-int v5, v5

    add-int/2addr v4, v5

    iget v5, p0, Lcom/lge/app/floating/FrameView;->mWidthDown:I

    sub-int/2addr v4, v5

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v5

    iget v5, v5, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawY()F

    move-result v6

    float-to-int v6, v6

    add-int/2addr v5, v6

    iget v6, p0, Lcom/lge/app/floating/FrameView;->mHeightDown:I

    sub-int/2addr v5, v6

    invoke-virtual {v3, v4, v5}, Lcom/lge/app/floating/ResizeFrame;->setSize(II)V

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v3

    iget-object v3, v3, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    if-eqz v3, :cond_5

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v3

    iget-object v3, v3, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v4

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v5

    iget v5, v5, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v6

    iget v6, v6, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    invoke-interface {v3, v4, v5, v6}, Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;->onResizing(Lcom/lge/app/floating/FloatingWindow;II)V

    :cond_5
    iget v3, p0, Lcom/lge/app/floating/FrameView;->mActionMoveCount:I

    if-ne v3, v7, :cond_6

    iput v1, p0, Lcom/lge/app/floating/FrameView;->mActionMoveCount:I

    :cond_6
    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v1

    iput-boolean v2, v1, Lcom/lge/app/floating/FloatingWindow;->mIsResizing:Z

    goto :goto_1

    :cond_7
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result v3

    if-ne v3, v2, :cond_a

    iget-object v3, p0, Lcom/lge/app/floating/FrameView;->mResizeFrame:Lcom/lge/app/floating/ResizeFrame;

    if-eqz v3, :cond_9

    iget-object v3, p0, Lcom/lge/app/floating/FrameView;->mResizeFrame:Lcom/lge/app/floating/ResizeFrame;

    invoke-virtual {v3}, Lcom/lge/app/floating/ResizeFrame;->getRefinedSize()Landroid/graphics/Point;

    move-result-object v0

    .local v0, "newSize":Landroid/graphics/Point;
    if-eqz v0, :cond_8

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v3

    iget v4, v0, Landroid/graphics/Point;->x:I

    iget v5, v0, Landroid/graphics/Point;->y:I

    invoke-virtual {v3, v4, v5}, Lcom/lge/app/floating/FloatingWindow;->setSize(II)V

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v3

    iget-object v3, v3, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    if-eqz v3, :cond_8

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v3

    iget-object v3, v3, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v4

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v5

    iget v5, v5, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v6

    iget v6, v6, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    invoke-interface {v3, v4, v5, v6}, Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;->onResizeFinished(Lcom/lge/app/floating/FloatingWindow;II)V

    :cond_8
    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->resetResizeFrame()Z

    .end local v0    # "newSize":Landroid/graphics/Point;
    :cond_9
    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v3

    iput-boolean v1, v3, Lcom/lge/app/floating/FloatingWindow;->mIsResizing:Z

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v1

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/lge/app/floating/FloatingWindow;->updateLayoutParamsInner(Lcom/lge/app/floating/FloatingWindow$LayoutParams;)V

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->updateResizeHandle()V

    goto/16 :goto_1

    :cond_a
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result v3

    if-ne v3, v7, :cond_2

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->updateResizeHandle()V

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->resetResizeFrame()Z

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v3

    iget-object v3, v3, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    if-eqz v3, :cond_b

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v3

    iget-object v3, v3, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v4

    invoke-interface {v3, v4}, Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;->onResizeCanceled(Lcom/lge/app/floating/FloatingWindow;)V

    :cond_b
    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v3

    iput-boolean v1, v3, Lcom/lge/app/floating/FloatingWindow;->mIsResizing:Z

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v1

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/lge/app/floating/FloatingWindow;->updateLayoutParamsInner(Lcom/lge/app/floating/FloatingWindow$LayoutParams;)V

    goto/16 :goto_1

    :cond_c
    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1, p2}, Landroid/view/View;->dispatchTouchEvent(Landroid/view/MotionEvent;)Z

    goto/16 :goto_1
.end method

.method public onWindowFocusChanged(Z)V
    .locals 8
    .param p1, "hasWindowFocus"    # Z

    .prologue
    const v7, 0x7f0c0004

    const v6, 0x7f0c0003

    const/4 v5, 0x0

    invoke-super {p0, p1}, Lcom/lge/app/floating/QslideView;->onWindowFocusChanged(Z)V

    sget-object v2, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/lge/app/floating/FrameView;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v4}, Lcom/lge/app/floating/FloatableActivity;->getPackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "]"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "onWindowFocusChanged : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-boolean v2, p0, Lcom/lge/app/floating/FrameView;->mReceiveMenuKeyEvent:Z

    if-eqz v2, :cond_2

    sget-object v2, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    const-string v3, "injectKeyEvent : KEYCODE_MENU"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v0, Lcom/lge/systemservice/core/LGContext;

    iget-object v2, p0, Lcom/lge/app/floating/FrameView;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-direct {v0, v2}, Lcom/lge/systemservice/core/LGContext;-><init>(Landroid/content/Context;)V

    .local v0, "lgContext":Lcom/lge/systemservice/core/LGContext;
    const-string v2, "osservice"

    invoke-virtual {v0, v2}, Lcom/lge/systemservice/core/LGContext;->getLGSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/lge/systemservice/core/OsManager;

    .local v1, "osManager":Lcom/lge/systemservice/core/OsManager;
    if-eqz v1, :cond_1

    const/16 v2, 0x52

    invoke-virtual {v1, v2}, Lcom/lge/systemservice/core/OsManager;->injectKeyEvent(I)V

    iput-boolean v5, p0, Lcom/lge/app/floating/FrameView;->mReceiveMenuKeyEvent:Z

    .end local v0    # "lgContext":Lcom/lge/systemservice/core/LGContext;
    .end local v1    # "osManager":Lcom/lge/systemservice/core/OsManager;
    :cond_0
    :goto_0
    if-nez p1, :cond_4

    sget-object v2, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "onWindowFocusChanged hasWindowFocus: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0, v6}, Lcom/lge/app/floating/FrameView;->findViewById(I)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/View;->postInvalidate()V

    invoke-virtual {p0, v7}, Lcom/lge/app/floating/FrameView;->findViewById(I)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/View;->postInvalidate()V

    :goto_1
    return-void

    .restart local v0    # "lgContext":Lcom/lge/systemservice/core/LGContext;
    .restart local v1    # "osManager":Lcom/lge/systemservice/core/OsManager;
    :cond_1
    sget-object v2, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    const-string v3, "Fail to get osManager"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "lgContext":Lcom/lge/systemservice/core/LGContext;
    .end local v1    # "osManager":Lcom/lge/systemservice/core/OsManager;
    :cond_2
    iget-boolean v2, p0, Lcom/lge/app/floating/FrameView;->mReceiveBackKeyEvent:Z

    if-eqz v2, :cond_0

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v2

    iget-boolean v2, v2, Lcom/lge/app/floating/FloatingWindow;->mIsInLowProfile:Z

    if-nez v2, :cond_0

    sget-object v2, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    const-string v3, "injectKeyEvent : KEYCODE_BACK"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v0, Lcom/lge/systemservice/core/LGContext;

    iget-object v2, p0, Lcom/lge/app/floating/FrameView;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-direct {v0, v2}, Lcom/lge/systemservice/core/LGContext;-><init>(Landroid/content/Context;)V

    .restart local v0    # "lgContext":Lcom/lge/systemservice/core/LGContext;
    const-string v2, "osservice"

    invoke-virtual {v0, v2}, Lcom/lge/systemservice/core/LGContext;->getLGSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/lge/systemservice/core/OsManager;

    .restart local v1    # "osManager":Lcom/lge/systemservice/core/OsManager;
    if-eqz v1, :cond_3

    const/4 v2, 0x4

    invoke-virtual {v1, v2}, Lcom/lge/systemservice/core/OsManager;->injectKeyEvent(I)V

    iput-boolean v5, p0, Lcom/lge/app/floating/FrameView;->mReceiveBackKeyEvent:Z

    goto :goto_0

    :cond_3
    sget-object v2, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    const-string v3, "Fail to get osManager"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "lgContext":Lcom/lge/systemservice/core/LGContext;
    .end local v1    # "osManager":Lcom/lge/systemservice/core/OsManager;
    :cond_4
    invoke-virtual {p0, v6}, Lcom/lge/app/floating/FrameView;->findViewById(I)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/View;->postInvalidate()V

    invoke-virtual {p0, v7}, Lcom/lge/app/floating/FrameView;->findViewById(I)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/View;->postInvalidate()V

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v2

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->findFocus()Landroid/view/View;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/lge/app/floating/FloatingWindow;->requestFocusAndShowKeyboard(Landroid/view/View;)V

    goto :goto_1
.end method

.method public removeTitleView()Landroid/view/View;
    .locals 4

    .prologue
    const/4 v3, 0x0

    const v2, 0x7f0c0003

    invoke-virtual {p0, v2}, Lcom/lge/app/floating/FrameView;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/view/ViewGroup;

    .local v1, "vg":Landroid/view/ViewGroup;
    invoke-virtual {v1, v3}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/lge/app/floating/TitleView;

    .local v0, "tv":Lcom/lge/app/floating/TitleView;
    if-eqz v0, :cond_0

    invoke-virtual {v1, v3}, Landroid/view/ViewGroup;->removeViewAt(I)V

    :cond_0
    return-object v0
.end method

.method public resetResizeFrame()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/app/floating/FrameView;->mResizeFrame:Lcom/lge/app/floating/ResizeFrame;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/app/floating/FrameView;->mResizeFrame:Lcom/lge/app/floating/ResizeFrame;

    invoke-virtual {v0}, Lcom/lge/app/floating/ResizeFrame;->dismiss()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/app/floating/FrameView;->mResizeFrame:Lcom/lge/app/floating/ResizeFrame;

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public setAsFocusable(Z)V
    .locals 0
    .param p1, "getFocus"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/lge/app/floating/FrameView;->mIsFocusable:Z

    return-void
.end method

.method public setContentView(Landroid/view/View;)V
    .locals 5
    .param p1, "v"    # Landroid/view/View;

    .prologue
    iget-object v0, p0, Lcom/lge/app/floating/FrameView;->mContent:Landroid/view/View;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/app/floating/FrameView;->mContentParent:Landroid/view/ViewGroup;

    iget-object v1, p0, Lcom/lge/app/floating/FrameView;->mContent:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    iget-object v0, p0, Lcom/lge/app/floating/FrameView;->mSavedContentPadding:Landroid/graphics/Rect;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/app/floating/FrameView;->mContent:Landroid/view/View;

    iget-object v1, p0, Lcom/lge/app/floating/FrameView;->mSavedContentPadding:Landroid/graphics/Rect;

    iget v1, v1, Landroid/graphics/Rect;->left:I

    iget-object v2, p0, Lcom/lge/app/floating/FrameView;->mSavedContentPadding:Landroid/graphics/Rect;

    iget v2, v2, Landroid/graphics/Rect;->top:I

    iget-object v3, p0, Lcom/lge/app/floating/FrameView;->mSavedContentPadding:Landroid/graphics/Rect;

    iget v3, v3, Landroid/graphics/Rect;->right:I

    iget-object v4, p0, Lcom/lge/app/floating/FrameView;->mSavedContentPadding:Landroid/graphics/Rect;

    iget v4, v4, Landroid/graphics/Rect;->bottom:I

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/view/View;->setPaddingRelative(IIII)V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/app/floating/FrameView;->mSavedContentPadding:Landroid/graphics/Rect;

    :cond_0
    if-eqz p1, :cond_1

    iget-object v0, p0, Lcom/lge/app/floating/FrameView;->mContentParent:Landroid/view/ViewGroup;

    invoke-virtual {v0, p1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    iget-object v0, p0, Lcom/lge/app/floating/FrameView;->mResizeHandle:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->bringToFront()V

    iput-object p1, p0, Lcom/lge/app/floating/FrameView;->mContent:Landroid/view/View;

    :cond_1
    return-void
.end method

.method public setTitleView(Landroid/view/View;)V
    .locals 4
    .param p1, "tv"    # Landroid/view/View;

    .prologue
    const v1, 0x7f0c0003

    invoke-virtual {p0, v1}, Lcom/lge/app/floating/FrameView;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    .local v0, "vg":Landroid/view/ViewGroup;
    new-instance v1, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v2, -0x1

    const/4 v3, -0x2

    invoke-direct {v1, v2, v3}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {p1, v1}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {v0, p1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    return-void
.end method

.method public startActionModeForChild(Landroid/view/View;Landroid/view/ActionMode$Callback;)Landroid/view/ActionMode;
    .locals 7
    .param p1, "originalView"    # Landroid/view/View;
    .param p2, "callback"    # Landroid/view/ActionMode$Callback;

    .prologue
    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->isWindowAttached()Z

    move-result v3

    if-eqz v3, :cond_1

    iget-object v3, p0, Lcom/lge/app/floating/FrameView;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v3}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/view/ViewGroup;

    .local v1, "decorView":Landroid/view/ViewGroup;
    if-eqz v1, :cond_1

    iget-object v3, p0, Lcom/lge/app/floating/FrameView;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v3}, Lcom/lge/app/floating/FloatableActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    const-string v4, "action_mode_bar_stub"

    const-string v5, "id"

    const-string v6, "android"

    invoke-virtual {v3, v4, v5, v6}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .local v2, "idActionModeBar":I
    invoke-virtual {p0, v2}, Lcom/lge/app/floating/FrameView;->findViewById(I)Landroid/view/View;

    move-result-object v0

    .local v0, "actionModeBar":Landroid/view/View;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v3

    if-eqz v3, :cond_0

    invoke-virtual {v0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v3

    check-cast v3, Landroid/view/ViewGroup;

    iput-object v3, p0, Lcom/lge/app/floating/FrameView;->mActionModeBarParent:Landroid/view/ViewGroup;

    iget-object v3, p0, Lcom/lge/app/floating/FrameView;->mActionModeBarParent:Landroid/view/ViewGroup;

    invoke-virtual {v3, v0}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    invoke-virtual {v1, v0}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    :cond_0
    invoke-virtual {v1, p1, p2}, Landroid/view/ViewGroup;->startActionModeForChild(Landroid/view/View;Landroid/view/ActionMode$Callback;)Landroid/view/ActionMode;

    move-result-object v3

    .end local v0    # "actionModeBar":Landroid/view/View;
    .end local v1    # "decorView":Landroid/view/ViewGroup;
    .end local v2    # "idActionModeBar":I
    :goto_0
    return-object v3

    :cond_1
    invoke-super {p0, p1, p2}, Lcom/lge/app/floating/QslideView;->startActionModeForChild(Landroid/view/View;Landroid/view/ActionMode$Callback;)Landroid/view/ActionMode;

    move-result-object v3

    goto :goto_0
.end method

.method public update()V
    .locals 6

    .prologue
    const v5, 0x7f0c0003

    const/16 v2, 0x8

    const/4 v3, 0x0

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->isWindowAttached()Z

    move-result v1

    if-nez v1, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v1

    iget-boolean v1, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->useOverlappingTitle:Z

    invoke-direct {p0, v1}, Lcom/lge/app/floating/FrameView;->setOverlappingTitle(Z)V

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->updateResizeHandle()V

    invoke-virtual {p0, v5}, Lcom/lge/app/floating/FrameView;->findViewById(I)Landroid/view/View;

    move-result-object v4

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/app/floating/FloatingWindow;->titleShouldBeHidden()Z

    move-result v1

    if-eqz v1, :cond_3

    move v1, v2

    :goto_1
    invoke-virtual {v4, v1}, Landroid/view/View;->setVisibility(I)V

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v1

    iget-boolean v1, v1, Lcom/lge/app/floating/FloatingWindow;->mUseSeparateWindow:Z

    if-eqz v1, :cond_2

    invoke-virtual {p0, v5}, Lcom/lge/app/floating/FrameView;->findViewById(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    :cond_2
    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v1

    iget-boolean v1, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->fullScreen:Z

    if-eqz v1, :cond_0

    invoke-virtual {p0, v3}, Lcom/lge/app/floating/FrameView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    .local v0, "child":Landroid/view/View;
    if-eqz v0, :cond_4

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    invoke-virtual {v0, v3, v3, v3, v3}, Landroid/view/View;->setPaddingRelative(IIII)V

    goto :goto_0

    .end local v0    # "child":Landroid/view/View;
    :cond_3
    move v1, v3

    goto :goto_1

    .restart local v0    # "child":Landroid/view/View;
    :cond_4
    sget-object v1, Lcom/lge/app/floating/FrameView;->TAG:Ljava/lang/String;

    const-string v2, "this.getChildAt(0) == null"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public updateResizeHandle()V
    .locals 6

    .prologue
    const/4 v5, 0x2

    const/4 v3, 0x0

    iget-object v4, p0, Lcom/lge/app/floating/FrameView;->mResizeHandle:Landroid/view/View;

    invoke-virtual {v4}, Landroid/view/View;->getVisibility()I

    move-result v2

    .local v2, "oldVis":I
    iget-object v4, p0, Lcom/lge/app/floating/FrameView;->mResizeAnimator:Landroid/animation/ObjectAnimator;

    if-eqz v4, :cond_4

    iget-object v4, p0, Lcom/lge/app/floating/FrameView;->mResizeAnimator:Landroid/animation/ObjectAnimator;

    invoke-virtual {v4}, Landroid/animation/ObjectAnimator;->isStarted()Z

    move-result v4

    if-nez v4, :cond_0

    iget-object v4, p0, Lcom/lge/app/floating/FrameView;->mResizeAnimator:Landroid/animation/ObjectAnimator;

    invoke-virtual {v4}, Landroid/animation/ObjectAnimator;->isRunning()Z

    move-result v4

    if-eqz v4, :cond_4

    :cond_0
    const/4 v0, 0x1

    .local v0, "animRunning":Z
    :goto_0
    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindowLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v4

    iget v4, v4, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->resizeOption:I

    and-int/lit8 v4, v4, 0x3

    if-eqz v4, :cond_6

    invoke-virtual {p0}, Lcom/lge/app/floating/FrameView;->getWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v4

    iget-boolean v4, v4, Lcom/lge/app/floating/FloatingWindow;->mIsInOverlayMode:Z

    if-eqz v4, :cond_5

    const/16 v1, 0x8

    .local v1, "newVis":I
    :goto_1
    if-ne v2, v1, :cond_1

    if-eqz v0, :cond_3

    :cond_1
    if-eqz v0, :cond_2

    iget-object v3, p0, Lcom/lge/app/floating/FrameView;->mResizeAnimator:Landroid/animation/ObjectAnimator;

    invoke-virtual {v3}, Landroid/animation/ObjectAnimator;->cancel()V

    :cond_2
    if-nez v1, :cond_7

    iget-object v3, p0, Lcom/lge/app/floating/FrameView;->mResizeHandle:Landroid/view/View;

    invoke-virtual {v3, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v3, p0, Lcom/lge/app/floating/FrameView;->mResizeHandle:Landroid/view/View;

    const-string v4, "alpha"

    new-array v5, v5, [F

    fill-array-data v5, :array_0

    invoke-static {v3, v4, v5}, Landroid/animation/ObjectAnimator;->ofFloat(Ljava/lang/Object;Ljava/lang/String;[F)Landroid/animation/ObjectAnimator;

    move-result-object v3

    iput-object v3, p0, Lcom/lge/app/floating/FrameView;->mResizeAnimator:Landroid/animation/ObjectAnimator;

    iget-object v3, p0, Lcom/lge/app/floating/FrameView;->mResizeAnimator:Landroid/animation/ObjectAnimator;

    new-instance v4, Landroid/view/animation/DecelerateInterpolator;

    invoke-direct {v4}, Landroid/view/animation/DecelerateInterpolator;-><init>()V

    invoke-virtual {v3, v4}, Landroid/animation/ObjectAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)V

    :goto_2
    iget-object v3, p0, Lcom/lge/app/floating/FrameView;->mResizeAnimator:Landroid/animation/ObjectAnimator;

    new-instance v4, Lcom/lge/app/floating/FrameView$1;

    invoke-direct {v4, p0, v1}, Lcom/lge/app/floating/FrameView$1;-><init>(Lcom/lge/app/floating/FrameView;I)V

    invoke-virtual {v3, v4}, Landroid/animation/ObjectAnimator;->addListener(Landroid/animation/Animator$AnimatorListener;)V

    iget-object v3, p0, Lcom/lge/app/floating/FrameView;->mResizeAnimator:Landroid/animation/ObjectAnimator;

    iget-object v4, p0, Lcom/lge/app/floating/FrameView;->mResources:Landroid/content/res/Resources;

    const v5, 0x10e0002

    invoke-virtual {v4, v5}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v4

    int-to-long v4, v4

    invoke-virtual {v3, v4, v5}, Landroid/animation/ObjectAnimator;->setDuration(J)Landroid/animation/ObjectAnimator;

    iget-object v3, p0, Lcom/lge/app/floating/FrameView;->mResizeAnimator:Landroid/animation/ObjectAnimator;

    invoke-virtual {v3}, Landroid/animation/ObjectAnimator;->start()V

    :cond_3
    return-void

    .end local v0    # "animRunning":Z
    .end local v1    # "newVis":I
    :cond_4
    move v0, v3

    goto :goto_0

    .restart local v0    # "animRunning":Z
    :cond_5
    move v1, v3

    goto :goto_1

    :cond_6
    const/16 v1, 0x8

    .restart local v1    # "newVis":I
    goto :goto_1

    :cond_7
    iget-object v3, p0, Lcom/lge/app/floating/FrameView;->mResizeHandle:Landroid/view/View;

    const-string v4, "alpha"

    new-array v5, v5, [F

    fill-array-data v5, :array_1

    invoke-static {v3, v4, v5}, Landroid/animation/ObjectAnimator;->ofFloat(Ljava/lang/Object;Ljava/lang/String;[F)Landroid/animation/ObjectAnimator;

    move-result-object v3

    iput-object v3, p0, Lcom/lge/app/floating/FrameView;->mResizeAnimator:Landroid/animation/ObjectAnimator;

    iget-object v3, p0, Lcom/lge/app/floating/FrameView;->mResizeAnimator:Landroid/animation/ObjectAnimator;

    new-instance v4, Landroid/view/animation/AccelerateInterpolator;

    invoke-direct {v4}, Landroid/view/animation/AccelerateInterpolator;-><init>()V

    invoke-virtual {v3, v4}, Landroid/animation/ObjectAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)V

    goto :goto_2

    :array_0
    .array-data 4
        0x0
        0x3f800000    # 1.0f
    .end array-data

    :array_1
    .array-data 4
        0x3f800000    # 1.0f
        0x0
    .end array-data
.end method
