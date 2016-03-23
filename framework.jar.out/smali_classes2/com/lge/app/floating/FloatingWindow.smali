.class public Lcom/lge/app/floating/FloatingWindow;
.super Ljava/lang/Object;
.source "FloatingWindow.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/app/floating/FloatingWindow$SliderAnimation;,
        Lcom/lge/app/floating/FloatingWindow$BounceAnimationListener;,
        Lcom/lge/app/floating/FloatingWindow$RectEvaluator;,
        Lcom/lge/app/floating/FloatingWindow$Tag;,
        Lcom/lge/app/floating/FloatingWindow$MoveOption;,
        Lcom/lge/app/floating/FloatingWindow$ResizeOption;,
        Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;,
        Lcom/lge/app/floating/FloatingWindow$DefaultOnUpdateListener;,
        Lcom/lge/app/floating/FloatingWindow$OnDockListener;,
        Lcom/lge/app/floating/FloatingWindow$OnUpdateListener3;,
        Lcom/lge/app/floating/FloatingWindow$OnUpdateListener2;,
        Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;,
        Lcom/lge/app/floating/FloatingWindow$LayoutParams;
    }
.end annotation


# static fields
.field static final CLIPTRAY_INPUTTYPE:Ljava/lang/String; = "com.lge.systemservice.core.cliptray.INPUTTYPE_CLIPTRAY"

.field static final INIT_CLIPTRAY:I = 0xa

.field private static final TAG:Ljava/lang/String;

.field static mIsShowSoftInputOnFocus:Z

.field static sSavedLocation:Z


# instance fields
.field private frameWindowH:I

.field private frameWindowW:I

.field private frameWindowX:I

.field private frameWindowY:I

.field final mActivity:Lcom/lge/app/floating/FloatableActivity;

.field mAlpha:F

.field private mAlphaSavedForLowProfile:F

.field final mAnimStyleId:I

.field public mAppName:Ljava/lang/String;

.field private mBounceAnimator:Landroid/animation/ValueAnimator;

.field private mDockViewBitmap:Landroid/graphics/Bitmap;

.field mDockWindow:Lcom/lge/app/floating/FloatingDockWindow;

.field private final mFloatingWindowManager:Lcom/lge/app/floating/FloatingWindowManager;

.field private mFrameParamsBeforeHidden:Landroid/view/WindowManager$LayoutParams;

.field private mFrameView:Lcom/lge/app/floating/IFrameView;

.field final mHandler:Landroid/os/Handler;

.field mImeShouldBeReShown:Z

.field final mInputMethodManager:Landroid/view/inputmethod/InputMethodManager;

.field private mIsAttached:Z

.field private mIsHidden:Z

.field mIsImeVisible:Z

.field mIsInLowProfile:Z

.field mIsInOverlayMode:Z

.field private mIsMoving:Z

.field mIsPortrait:Z

.field mIsResizing:Z

.field mIsTitleInSeparateWindow:Z

.field private mLayout:Lcom/lge/app/floating/FloatingWindow$LayoutParams;

.field private mLayoutLimit:Z

.field private mLowProfileAnimator:Landroid/animation/ValueAnimator;

.field mNeedToDockOnStarting:Z

.field mRedirectMoveToDown:Z

.field private final mResources:Landroid/content/res/Resources;

.field final mSavedConfig:Landroid/content/res/Configuration;

.field private mSavedFrameParams:Landroid/view/WindowManager$LayoutParams;

.field mSavedLandscapeX:I

.field mSavedLandscapeY:I

.field mSavedLayoutParams:Lcom/lge/app/floating/FloatingWindow$LayoutParams;

.field mSavedPortraitX:I

.field mSavedPortraitY:I

.field private mSavedTitleParams:Landroid/view/WindowManager$LayoutParams;

.field mSwitchingFull:Z

.field private mTitleParamsBeforeHidden:Landroid/view/WindowManager$LayoutParams;

.field private mTitleView:Lcom/lge/app/floating/ITitleView;

.field mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

.field final mUseSeparateWindow:Z

.field private final mWindowManager:Landroid/view/WindowManager;

.field final mWindowName:Ljava/lang/String;

.field private titleWindowH:I

.field private titleWindowW:I

.field private titleWindowX:I

.field private titleWindowY:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 56
    const-class v0, Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    .line 1112
    const/4 v0, 0x0

    sput-boolean v0, Lcom/lge/app/floating/FloatingWindow;->sSavedLocation:Z

    .line 3397
    const/4 v0, 0x1

    sput-boolean v0, Lcom/lge/app/floating/FloatingWindow;->mIsShowSoftInputOnFocus:Z

    return-void
.end method

.method constructor <init>(Lcom/lge/app/floating/FloatableActivity;Lcom/lge/app/floating/FloatingWindowManager;Ljava/lang/String;Lcom/lge/app/floating/FloatingWindow$LayoutParams;)V
    .locals 6
    .param p1, "activity"    # Lcom/lge/app/floating/FloatableActivity;
    .param p2, "windowManager"    # Lcom/lge/app/floating/FloatingWindowManager;
    .param p3, "windowName"    # Ljava/lang/String;
    .param p4, "params"    # Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    .prologue
    const/4 v1, 0x1

    const/4 v3, 0x0

    const/4 v2, 0x0

    .line 1137
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 58
    iput-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mBounceAnimator:Landroid/animation/ValueAnimator;

    .line 1064
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mHandler:Landroid/os/Handler;

    .line 1067
    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, p0, Lcom/lge/app/floating/FloatingWindow;->mAlpha:F

    .line 1068
    iput-boolean v2, p0, Lcom/lge/app/floating/FloatingWindow;->mIsInOverlayMode:Z

    .line 1069
    iput-boolean v2, p0, Lcom/lge/app/floating/FloatingWindow;->mIsAttached:Z

    .line 1070
    iput-boolean v1, p0, Lcom/lge/app/floating/FloatingWindow;->mIsPortrait:Z

    .line 1071
    iput-boolean v2, p0, Lcom/lge/app/floating/FloatingWindow;->mLayoutLimit:Z

    .line 1072
    iput-boolean v2, p0, Lcom/lge/app/floating/FloatingWindow;->mIsMoving:Z

    .line 1073
    iput-boolean v2, p0, Lcom/lge/app/floating/FloatingWindow;->mIsResizing:Z

    .line 1080
    iput-boolean v2, p0, Lcom/lge/app/floating/FloatingWindow;->mIsTitleInSeparateWindow:Z

    .line 1081
    iput-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mLowProfileAnimator:Landroid/animation/ValueAnimator;

    .line 1082
    iput-boolean v2, p0, Lcom/lge/app/floating/FloatingWindow;->mIsInLowProfile:Z

    .line 1083
    iput-boolean v2, p0, Lcom/lge/app/floating/FloatingWindow;->mIsHidden:Z

    .line 1084
    iget v0, p0, Lcom/lge/app/floating/FloatingWindow;->mAlpha:F

    iput v0, p0, Lcom/lge/app/floating/FloatingWindow;->mAlphaSavedForLowProfile:F

    .line 1087
    iput-boolean v2, p0, Lcom/lge/app/floating/FloatingWindow;->mSwitchingFull:Z

    .line 1100
    new-instance v0, Landroid/content/res/Configuration;

    invoke-direct {v0}, Landroid/content/res/Configuration;-><init>()V

    iput-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedConfig:Landroid/content/res/Configuration;

    .line 1105
    iput-boolean v2, p0, Lcom/lge/app/floating/FloatingWindow;->mIsImeVisible:Z

    .line 1108
    iput v2, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedPortraitX:I

    .line 1109
    iput v2, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedPortraitY:I

    .line 1110
    iput v2, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedLandscapeX:I

    .line 1111
    iput v2, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedLandscapeY:I

    .line 1114
    iput-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mDockWindow:Lcom/lge/app/floating/FloatingDockWindow;

    .line 1115
    iput-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mDockViewBitmap:Landroid/graphics/Bitmap;

    .line 1116
    iput-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mAppName:Ljava/lang/String;

    .line 2409
    iput-boolean v2, p0, Lcom/lge/app/floating/FloatingWindow;->mImeShouldBeReShown:Z

    .line 1138
    invoke-static {p1}, Lcom/lge/app/floating/Res;->getResources(Landroid/content/Context;)Landroid/content/res/Resources;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    .line 1139
    iput-object p2, p0, Lcom/lge/app/floating/FloatingWindow;->mFloatingWindowManager:Lcom/lge/app/floating/FloatingWindowManager;

    .line 1140
    iput-object p1, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    .line 1141
    iput-object p3, p0, Lcom/lge/app/floating/FloatingWindow;->mWindowName:Ljava/lang/String;

    .line 1142
    invoke-virtual {p2}, Lcom/lge/app/floating/FloatingWindowManager;->getRealWindowManager()Landroid/view/WindowManager;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mWindowManager:Landroid/view/WindowManager;

    .line 1143
    const-string v0, "input_method"

    invoke-virtual {p1, v0}, Lcom/lge/app/floating/FloatableActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/inputmethod/InputMethodManager;

    iput-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mInputMethodManager:Landroid/view/inputmethod/InputMethodManager;

    .line 1145
    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v0}, Lcom/lge/app/floating/FloatableActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v3, "Animation.SearchBar"

    const-string v4, "style"

    const-string v5, "android"

    invoke-virtual {v0, v3, v4, v5}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/lge/app/floating/FloatingWindow;->mAnimStyleId:I

    .line 1147
    invoke-virtual {p4}, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->clone()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/lge/app/floating/FloatingWindow;->setLayoutParam(Lcom/lge/app/floating/FloatingWindow$LayoutParams;)V

    .line 1149
    new-instance v0, Lcom/lge/app/floating/FrameView;

    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-direct {v0, v3, p0}, Lcom/lge/app/floating/FrameView;-><init>(Lcom/lge/app/floating/FloatableActivity;Lcom/lge/app/floating/FloatingWindow;)V

    iput-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameView:Lcom/lge/app/floating/IFrameView;

    .line 1150
    new-instance v0, Lcom/lge/app/floating/TitleView;

    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-direct {v0, v3, p0}, Lcom/lge/app/floating/TitleView;-><init>(Lcom/lge/app/floating/FloatableActivity;Lcom/lge/app/floating/FloatingWindow;)V

    iput-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mTitleView:Lcom/lge/app/floating/ITitleView;

    .line 1152
    invoke-virtual {p1}, Lcom/lge/app/floating/FloatableActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->orientation:I

    if-ne v0, v1, :cond_0

    move v0, v1

    :goto_0
    iput-boolean v0, p0, Lcom/lge/app/floating/FloatingWindow;->mIsPortrait:Z

    .line 1153
    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    const v1, 0x7f090002

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v0

    iput-boolean v0, p0, Lcom/lge/app/floating/FloatingWindow;->mUseSeparateWindow:Z

    .line 1155
    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedConfig:Landroid/content/res/Configuration;

    invoke-virtual {p1}, Lcom/lge/app/floating/FloatableActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/res/Configuration;->updateFrom(Landroid/content/res/Configuration;)I

    .line 1156
    return-void

    :cond_0
    move v0, v2

    .line 1152
    goto :goto_0
.end method

.method static synthetic access$000()Ljava/lang/String;
    .locals 1

    .prologue
    .line 55
    sget-object v0, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$100(Lcom/lge/app/floating/FloatingWindow;)Z
    .locals 1
    .param p0, "x0"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    .line 55
    iget-boolean v0, p0, Lcom/lge/app/floating/FloatingWindow;->mIsMoving:Z

    return v0
.end method

.method static synthetic access$102(Lcom/lge/app/floating/FloatingWindow;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/lge/app/floating/FloatingWindow;
    .param p1, "x1"    # Z

    .prologue
    .line 55
    iput-boolean p1, p0, Lcom/lge/app/floating/FloatingWindow;->mIsMoving:Z

    return p1
.end method

.method static synthetic access$200(Lcom/lge/app/floating/FloatingWindow;)I
    .locals 1
    .param p0, "x0"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    .line 55
    iget v0, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowW:I

    return v0
.end method

.method static synthetic access$300(Lcom/lge/app/floating/FloatingWindow;)I
    .locals 1
    .param p0, "x0"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    .line 55
    iget v0, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowH:I

    return v0
.end method

.method static synthetic access$400(Lcom/lge/app/floating/FloatingWindow;)F
    .locals 1
    .param p0, "x0"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    .line 55
    iget v0, p0, Lcom/lge/app/floating/FloatingWindow;->mAlphaSavedForLowProfile:F

    return v0
.end method

.method static synthetic access$500(Lcom/lge/app/floating/FloatingWindow;)Lcom/lge/app/floating/ITitleView;
    .locals 1
    .param p0, "x0"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    .line 55
    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mTitleView:Lcom/lge/app/floating/ITitleView;

    return-object v0
.end method

.method private attachFrameWindow()V
    .locals 9

    .prologue
    const/4 v8, 0x0

    const/high16 v7, 0x1000000

    const/4 v6, 0x3

    const/4 v5, 0x1

    .line 1749
    sget-object v3, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v4, "attachFrameWindow"

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1750
    new-instance v1, Landroid/view/WindowManager$LayoutParams;

    invoke-direct {v1}, Landroid/view/WindowManager$LayoutParams;-><init>()V

    .line 1751
    .local v1, "params":Landroid/view/WindowManager$LayoutParams;
    const/16 v3, 0x7d2

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->type:I

    .line 1752
    const/4 v3, -0x3

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->format:I

    .line 1753
    const v3, 0x800033

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->gravity:I

    .line 1754
    iget v3, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowH:I

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 1755
    iget v3, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowW:I

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 1756
    iget v3, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowX:I

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 1757
    iget v3, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowY:I

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 1758
    iget v3, p0, Lcom/lge/app/floating/FloatingWindow;->mAnimStyleId:I

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->windowAnimations:I

    .line 1759
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Floating:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mWindowName:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/view/WindowManager$LayoutParams;->setTitle(Ljava/lang/CharSequence;)V

    .line 1760
    const/4 v3, 0x2

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->softInputMode:I

    .line 1761
    const v3, 0x40320

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 1777
    invoke-virtual {p0, v1}, Lcom/lge/app/floating/FloatingWindow;->setFocusableState(Landroid/view/WindowManager$LayoutParams;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v1

    .line 1780
    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v3}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v3

    iget v3, v3, Landroid/view/WindowManager$LayoutParams;->flags:I

    and-int/2addr v3, v7

    if-nez v3, :cond_0

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v3

    iget-boolean v3, v3, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->useHardwareAcceleration:Z

    if-eqz v3, :cond_1

    .line 1782
    :cond_0
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v3

    iput-boolean v5, v3, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->useHardwareAcceleration:Z

    .line 1783
    iget v3, v1, Landroid/view/WindowManager$LayoutParams;->flags:I

    or-int/2addr v3, v7

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 1784
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v3

    const/4 v4, 0x0

    invoke-virtual {v3, v4, v8}, Landroid/view/View;->setLayerType(ILandroid/graphics/Paint;)V

    .line 1787
    :cond_1
    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v3}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v3

    iget v3, v3, Landroid/view/WindowManager$LayoutParams;->flags:I

    and-int/lit16 v3, v3, 0x2000

    if-eqz v3, :cond_2

    .line 1788
    iget v3, v1, Landroid/view/WindowManager$LayoutParams;->flags:I

    or-int/lit16 v3, v3, 0x2000

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 1791
    :cond_2
    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v3}, Lcom/lge/app/floating/FloatableActivity;->getWindow()Landroid/view/Window;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v3

    iget v2, v3, Landroid/view/WindowManager$LayoutParams;->softInputMode:I

    .line 1792
    .local v2, "sim":I
    and-int/lit8 v3, v2, 0xf

    if-ne v3, v6, :cond_3

    .line 1793
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v3

    iput-boolean v5, v3, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->dontUseIme:Z

    .line 1794
    iput v6, v1, Landroid/view/WindowManager$LayoutParams;->softInputMode:I

    .line 1796
    :cond_3
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v3

    iget-boolean v3, v3, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->fullScreen:Z

    if-eqz v3, :cond_4

    .line 1798
    iget v3, v1, Landroid/view/WindowManager$LayoutParams;->flags:I

    and-int/lit16 v3, v3, -0x201

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 1799
    iget v3, v1, Landroid/view/WindowManager$LayoutParams;->flags:I

    const/high16 v4, 0x10000

    or-int/2addr v3, v4

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 1801
    iget v3, v1, Landroid/view/WindowManager$LayoutParams;->softInputMode:I

    and-int/lit16 v3, v3, -0xf1

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->softInputMode:I

    .line 1802
    iget v3, v1, Landroid/view/WindowManager$LayoutParams;->softInputMode:I

    or-int/lit8 v3, v3, 0x30

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->softInputMode:I

    .line 1804
    :cond_4
    new-instance v3, Landroid/os/Binder;

    invoke-direct {v3}, Landroid/os/Binder;-><init>()V

    iput-object v3, v1, Landroid/view/WindowManager$LayoutParams;->token:Landroid/os/IBinder;

    .line 1806
    :try_start_0
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getRealWindowManager()Landroid/view/WindowManager;

    move-result-object v3

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v4

    invoke-interface {v3, v4, v1}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    :try_end_0
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1810
    invoke-virtual {p0, v8}, Lcom/lge/app/floating/FloatingWindow;->setTalkbackAppName(Ljava/lang/String;)V

    .line 1811
    return-void

    .line 1807
    :catch_0
    move-exception v0

    .line 1808
    .local v0, "e":Ljava/lang/IllegalStateException;
    throw v0
.end method

.method private attachTitleWindow()V
    .locals 8

    .prologue
    .line 1815
    sget-object v3, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v4, "attachTitleWindow"

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1816
    iget-boolean v3, p0, Lcom/lge/app/floating/FloatingWindow;->mIsTitleInSeparateWindow:Z

    if-nez v3, :cond_0

    .line 1820
    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameView:Lcom/lge/app/floating/IFrameView;

    invoke-interface {v3}, Lcom/lge/app/floating/IFrameView;->removeTitleView()Landroid/view/View;

    .line 1821
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager$LayoutParams;

    .line 1822
    .local v0, "frameParams":Landroid/view/WindowManager$LayoutParams;
    new-instance v2, Landroid/view/WindowManager$LayoutParams;

    invoke-direct {v2}, Landroid/view/WindowManager$LayoutParams;-><init>()V

    .line 1823
    .local v2, "titleParams":Landroid/view/WindowManager$LayoutParams;
    invoke-virtual {v2, v0}, Landroid/view/WindowManager$LayoutParams;->copyFrom(Landroid/view/WindowManager$LayoutParams;)I

    .line 1824
    iget v3, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowH:I

    iput v3, v2, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 1825
    const/high16 v3, 0x3f800000    # 1.0f

    iput v3, v2, Landroid/view/WindowManager$LayoutParams;->alpha:F

    .line 1826
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Floating title:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mWindowName:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/view/WindowManager$LayoutParams;->setTitle(Ljava/lang/CharSequence;)V

    .line 1828
    iget v3, v2, Landroid/view/WindowManager$LayoutParams;->flags:I

    and-int/lit8 v3, v3, -0x11

    iput v3, v2, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 1832
    iget v3, v2, Landroid/view/WindowManager$LayoutParams;->flags:I

    or-int/lit8 v3, v3, 0x8

    iput v3, v2, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 1834
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v3

    iget-boolean v3, v3, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->dontUseIme:Z

    if-eqz v3, :cond_1

    .line 1835
    iget v3, v2, Landroid/view/WindowManager$LayoutParams;->flags:I

    const v4, -0x20001

    and-int/2addr v3, v4

    iput v3, v2, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 1846
    :goto_0
    iget v3, v2, Landroid/view/WindowManager$LayoutParams;->flags:I

    or-int/lit16 v3, v3, 0x200

    iput v3, v2, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 1847
    iget v3, v2, Landroid/view/WindowManager$LayoutParams;->flags:I

    const v4, -0x10001

    and-int/2addr v3, v4

    iput v3, v2, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 1848
    iget v3, p0, Lcom/lge/app/floating/FloatingWindow;->mAnimStyleId:I

    iput v3, v2, Landroid/view/WindowManager$LayoutParams;->windowAnimations:I

    .line 1850
    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameView:Lcom/lge/app/floating/IFrameView;

    invoke-interface {v3}, Lcom/lge/app/floating/IFrameView;->getPadding()Landroid/graphics/Rect;

    move-result-object v1

    .line 1851
    .local v1, "padding":Landroid/graphics/Rect;
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v3

    iget v4, v1, Landroid/graphics/Rect;->left:I

    iget v5, v1, Landroid/graphics/Rect;->top:I

    iget v6, v1, Landroid/graphics/Rect;->right:I

    const/4 v7, 0x0

    invoke-virtual {v3, v4, v5, v6, v7}, Landroid/view/View;->setPadding(IIII)V

    .line 1853
    iget-object v3, v0, Landroid/view/WindowManager$LayoutParams;->token:Landroid/os/IBinder;

    iput-object v3, v2, Landroid/view/WindowManager$LayoutParams;->token:Landroid/os/IBinder;

    .line 1854
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getRealWindowManager()Landroid/view/WindowManager;

    move-result-object v3

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v4

    invoke-interface {v3, v4, v2}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1855
    const/4 v3, 0x1

    iput-boolean v3, p0, Lcom/lge/app/floating/FloatingWindow;->mIsTitleInSeparateWindow:Z

    .line 1858
    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mWindowManager:Landroid/view/WindowManager;

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v4

    invoke-interface {v3, v4}, Landroid/view/WindowManager;->removeViewImmediate(Landroid/view/View;)V

    .line 1859
    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mWindowManager:Landroid/view/WindowManager;

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v4

    invoke-interface {v3, v4, v0}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 1861
    .end local v0    # "frameParams":Landroid/view/WindowManager$LayoutParams;
    .end local v1    # "padding":Landroid/graphics/Rect;
    .end local v2    # "titleParams":Landroid/view/WindowManager$LayoutParams;
    :cond_0
    return-void

    .line 1837
    .restart local v0    # "frameParams":Landroid/view/WindowManager$LayoutParams;
    .restart local v2    # "titleParams":Landroid/view/WindowManager$LayoutParams;
    :cond_1
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v3

    iget-boolean v3, v3, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->overIme:Z

    if-eqz v3, :cond_2

    .line 1838
    sget-object v3, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v4, "titleParams : UseIme && OverIme do not allowed."

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 1841
    :cond_2
    iget v3, v2, Landroid/view/WindowManager$LayoutParams;->flags:I

    const/high16 v4, 0x20000

    or-int/2addr v3, v4

    iput v3, v2, Landroid/view/WindowManager$LayoutParams;->flags:I

    goto :goto_0
.end method

.method private checkWindowSize(II)Z
    .locals 1
    .param p1, "maximum"    # I
    .param p2, "windowSize"    # I

    .prologue
    .line 3072
    if-lt p1, p2, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private createBounceAnimator(Landroid/graphics/Rect;)V
    .locals 6
    .param p1, "end"    # Landroid/graphics/Rect;

    .prologue
    const/4 v5, 0x0

    .line 3140
    new-instance v1, Landroid/graphics/Rect;

    invoke-direct {v1}, Landroid/graphics/Rect;-><init>()V

    .line 3141
    .local v1, "start":Landroid/graphics/Rect;
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v2

    iget v2, v2, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    iput v2, v1, Landroid/graphics/Rect;->left:I

    .line 3142
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v2

    iget v2, v2, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    iput v2, v1, Landroid/graphics/Rect;->top:I

    .line 3143
    iget v2, v1, Landroid/graphics/Rect;->left:I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v3

    iget v3, v3, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    add-int/2addr v2, v3

    iput v2, v1, Landroid/graphics/Rect;->right:I

    .line 3144
    iget v2, v1, Landroid/graphics/Rect;->top:I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v3

    iget v3, v3, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    add-int/2addr v2, v3

    iput v2, v1, Landroid/graphics/Rect;->bottom:I

    .line 3145
    new-instance v2, Lcom/lge/app/floating/FloatingWindow$RectEvaluator;

    invoke-direct {v2, v5}, Lcom/lge/app/floating/FloatingWindow$RectEvaluator;-><init>(Lcom/lge/app/floating/FloatingWindow$1;)V

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object v1, v3, v4

    const/4 v4, 0x1

    aput-object p1, v3, v4

    invoke-static {v2, v3}, Landroid/animation/ValueAnimator;->ofObject(Landroid/animation/TypeEvaluator;[Ljava/lang/Object;)Landroid/animation/ValueAnimator;

    move-result-object v2

    iput-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mBounceAnimator:Landroid/animation/ValueAnimator;

    .line 3147
    new-instance v0, Lcom/lge/app/floating/FloatingWindow$BounceAnimationListener;

    invoke-direct {v0, p0, v5}, Lcom/lge/app/floating/FloatingWindow$BounceAnimationListener;-><init>(Lcom/lge/app/floating/FloatingWindow;Lcom/lge/app/floating/FloatingWindow$1;)V

    .line 3148
    .local v0, "listener":Lcom/lge/app/floating/FloatingWindow$BounceAnimationListener;
    invoke-virtual {v0, v1, p1}, Lcom/lge/app/floating/FloatingWindow$BounceAnimationListener;->checkWhatToUpdate(Landroid/graphics/Rect;Landroid/graphics/Rect;)V

    .line 3149
    iget-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mBounceAnimator:Landroid/animation/ValueAnimator;

    new-instance v3, Landroid/view/animation/DecelerateInterpolator;

    invoke-direct {v3}, Landroid/view/animation/DecelerateInterpolator;-><init>()V

    invoke-virtual {v2, v3}, Landroid/animation/ValueAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)V

    .line 3150
    iget-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mBounceAnimator:Landroid/animation/ValueAnimator;

    invoke-virtual {v2, v0}, Landroid/animation/ValueAnimator;->addUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    .line 3151
    iget-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mBounceAnimator:Landroid/animation/ValueAnimator;

    invoke-virtual {v2, v0}, Landroid/animation/ValueAnimator;->addListener(Landroid/animation/Animator$AnimatorListener;)V

    .line 3152
    return-void
.end method

.method private detachTitleWindow()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 1864
    iget-boolean v0, p0, Lcom/lge/app/floating/FloatingWindow;->mIsTitleInSeparateWindow:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/lge/app/floating/FloatingWindow;->mUseSeparateWindow:Z

    if-nez v0, :cond_0

    .line 1865
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getRealWindowManager()Landroid/view/WindowManager;

    move-result-object v0

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v1

    invoke-interface {v0, v1}, Landroid/view/WindowManager;->removeViewImmediate(Landroid/view/View;)V

    .line 1866
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, v2, v2, v2, v2}, Landroid/view/View;->setPaddingRelative(IIII)V

    .line 1869
    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameView:Lcom/lge/app/floating/IFrameView;

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/lge/app/floating/IFrameView;->setTitleView(Landroid/view/View;)V

    .line 1870
    iput-boolean v2, p0, Lcom/lge/app/floating/FloatingWindow;->mIsTitleInSeparateWindow:Z

    .line 1872
    :cond_0
    return-void
.end method

.method private static findEditTextRecursively(Landroid/view/View;)V
    .locals 7
    .param p0, "aView"    # Landroid/view/View;

    .prologue
    .line 3400
    sget-boolean v4, Lcom/lge/app/floating/FloatingWindow;->mIsShowSoftInputOnFocus:Z

    if-nez v4, :cond_1

    .line 3422
    :cond_0
    :goto_0
    return-void

    .line 3403
    :cond_1
    instance-of v4, p0, Landroid/widget/EditText;

    if-eqz v4, :cond_2

    .line 3405
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    const-string v5, "getShowSoftInputOnFocus"

    const/4 v6, 0x0

    new-array v6, v6, [Ljava/lang/Class;

    invoke-virtual {v4, v5, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 3407
    .local v1, "getShowSoftInputOnFocus":Ljava/lang/reflect/Method;
    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-virtual {v1, p0, v4}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Boolean;

    invoke-virtual {v4}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v4

    sput-boolean v4, Lcom/lge/app/floating/FloatingWindow;->mIsShowSoftInputOnFocus:Z

    .line 3409
    sget-object v4, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "mIsShowSoftInputOnFocus : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    sget-boolean v6, Lcom/lge/app/floating/FloatingWindow;->mIsShowSoftInputOnFocus:Z

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 3411
    .end local v1    # "getShowSoftInputOnFocus":Ljava/lang/reflect/Method;
    :catch_0
    move-exception v0

    .line 3412
    .local v0, "e":Ljava/lang/Exception;
    sget-object v4, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "getShowSoftInputOnFocus() - reflection fail, "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 3416
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_2
    instance-of v4, p0, Landroid/view/ViewGroup;

    if-eqz v4, :cond_0

    move-object v3, p0

    .line 3417
    check-cast v3, Landroid/view/ViewGroup;

    .line 3418
    .local v3, "vg":Landroid/view/ViewGroup;
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_1
    invoke-virtual {v3}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v4

    if-ge v2, v4, :cond_0

    .line 3419
    invoke-virtual {v3, v2}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v4

    invoke-static {v4}, Lcom/lge/app/floating/FloatingWindow;->findEditTextRecursively(Landroid/view/View;)V

    .line 3418
    add-int/lit8 v2, v2, 0x1

    goto :goto_1
.end method

.method private repositionFloatingWindow()V
    .locals 19

    .prologue
    .line 1163
    sget-object v17, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v18, "repositionFloatingWindow"

    invoke-static/range {v17 .. v18}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1165
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    move-object/from16 v17, v0

    invoke-virtual/range {v17 .. v17}, Lcom/lge/app/floating/FloatableActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v17

    invoke-virtual/range {v17 .. v17}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v17

    move-object/from16 v0, v17

    iget v0, v0, Landroid/content/res/Configuration;->orientation:I

    move/from16 v17, v0

    const/16 v18, 0x1

    move/from16 v0, v17

    move/from16 v1, v18

    if-ne v0, v1, :cond_3

    const/16 v17, 0x1

    :goto_0
    move/from16 v0, v17

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/lge/app/floating/FloatingWindow;->mIsPortrait:Z

    .line 1168
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v17

    move-object/from16 v0, p0

    move-object/from16 v1, v17

    invoke-virtual {v0, v1}, Lcom/lge/app/floating/FloatingWindow;->calculateFloatingWindowSize(Lcom/lge/app/floating/FloatingWindow$LayoutParams;)[I

    move-result-object v7

    .line 1169
    .local v7, "floatingWindowSize":[I
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v17

    const/16 v18, 0x0

    aget v18, v7, v18

    move/from16 v0, v18

    move-object/from16 v1, v17

    iput v0, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    .line 1170
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v17

    const/16 v18, 0x1

    aget v18, v7, v18

    move/from16 v0, v18

    move-object/from16 v1, v17

    iput v0, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    .line 1173
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v17

    move-object/from16 v0, v17

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    move/from16 v17, v0

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v18

    move-object/from16 v0, v18

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    move/from16 v18, v0

    div-int/lit8 v18, v18, 0x2

    move/from16 v0, v18

    int-to-float v0, v0

    move/from16 v18, v0

    invoke-static/range {v18 .. v18}, Ljava/lang/Math;->round(F)I

    move-result v18

    add-int v12, v17, v18

    .line 1175
    .local v12, "middleX":I
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v17

    move-object/from16 v0, v17

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    move/from16 v17, v0

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v18

    move-object/from16 v0, v18

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    move/from16 v18, v0

    div-int/lit8 v18, v18, 0x2

    move/from16 v0, v18

    int-to-float v0, v0

    move/from16 v18, v0

    invoke-static/range {v18 .. v18}, Ljava/lang/Math;->round(F)I

    move-result v18

    add-int v13, v17, v18

    .line 1178
    .local v13, "middleY":I
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    move-object/from16 v17, v0

    invoke-virtual/range {v17 .. v17}, Lcom/lge/app/floating/FloatableActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v17

    invoke-virtual/range {v17 .. v17}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v6

    .line 1186
    .local v6, "display":Landroid/util/DisplayMetrics;
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v17

    move-object/from16 v0, v17

    iget v14, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    .line 1187
    .local v14, "newX":I
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v17

    move-object/from16 v0, v17

    iget v15, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    .line 1193
    .local v15, "newY":I
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v17

    move-object/from16 v0, v17

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    move/from16 v17, v0

    move/from16 v0, v17

    int-to-float v0, v0

    move/from16 v17, v0

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v18

    move-object/from16 v0, v18

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->bounceMarginLeft:F

    move/from16 v18, v0

    mul-float v17, v17, v18

    invoke-static/range {v17 .. v17}, Ljava/lang/Math;->round(F)I

    move-result v3

    .line 1195
    .local v3, "bounceLeft":I
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v17

    move-object/from16 v0, v17

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    move/from16 v17, v0

    move/from16 v0, v17

    int-to-float v0, v0

    move/from16 v17, v0

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v18

    move-object/from16 v0, v18

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->bounceMarginRight:F

    move/from16 v18, v0

    mul-float v17, v17, v18

    invoke-static/range {v17 .. v17}, Ljava/lang/Math;->round(F)I

    move-result v4

    .line 1197
    .local v4, "bounceRight":I
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v17

    move-object/from16 v0, v17

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    move/from16 v17, v0

    move/from16 v0, v17

    int-to-float v0, v0

    move/from16 v17, v0

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v18

    move-object/from16 v0, v18

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->bounceMarginTop:F

    move/from16 v18, v0

    mul-float v17, v17, v18

    invoke-static/range {v17 .. v17}, Ljava/lang/Math;->round(F)I

    move-result v5

    .line 1199
    .local v5, "bounceTop":I
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v17

    move-object/from16 v0, v17

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    move/from16 v17, v0

    move/from16 v0, v17

    int-to-float v0, v0

    move/from16 v17, v0

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v18

    move-object/from16 v0, v18

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->bounceMarginBottom:F

    move/from16 v18, v0

    mul-float v17, v17, v18

    invoke-static/range {v17 .. v17}, Ljava/lang/Math;->round(F)I

    move-result v2

    .line 1205
    .local v2, "bounceBottom":I
    rsub-int/lit8 v17, v3, 0x0

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v18

    move-object/from16 v0, v18

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    move/from16 v18, v0

    div-int/lit8 v18, v18, 0x2

    move/from16 v0, v18

    int-to-float v0, v0

    move/from16 v18, v0

    invoke-static/range {v18 .. v18}, Ljava/lang/Math;->round(F)I

    move-result v18

    add-int v9, v17, v18

    .line 1207
    .local v9, "mBounceLeft":I
    iget v0, v6, Landroid/util/DisplayMetrics;->widthPixels:I

    move/from16 v17, v0

    add-int v17, v17, v4

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v18

    move-object/from16 v0, v18

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    move/from16 v18, v0

    div-int/lit8 v18, v18, 0x2

    move/from16 v0, v18

    int-to-float v0, v0

    move/from16 v18, v0

    invoke-static/range {v18 .. v18}, Ljava/lang/Math;->round(F)I

    move-result v18

    sub-int v10, v17, v18

    .line 1209
    .local v10, "mBounceRight":I
    rsub-int/lit8 v17, v5, 0x0

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v18

    move-object/from16 v0, v18

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    move/from16 v18, v0

    div-int/lit8 v18, v18, 0x2

    move/from16 v0, v18

    int-to-float v0, v0

    move/from16 v18, v0

    invoke-static/range {v18 .. v18}, Ljava/lang/Math;->round(F)I

    move-result v18

    add-int v11, v17, v18

    .line 1211
    .local v11, "mBounceTop":I
    iget v0, v6, Landroid/util/DisplayMetrics;->heightPixels:I

    move/from16 v17, v0

    add-int v17, v17, v2

    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v18

    move-object/from16 v0, v18

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    move/from16 v18, v0

    div-int/lit8 v18, v18, 0x2

    move/from16 v0, v18

    int-to-float v0, v0

    move/from16 v18, v0

    invoke-static/range {v18 .. v18}, Ljava/lang/Math;->round(F)I

    move-result v18

    sub-int v8, v17, v18

    .line 1216
    .local v8, "mBounceBottom":I
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v17

    move-object/from16 v0, v17

    iget-boolean v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->hideTitle:Z

    move/from16 v17, v0

    if-nez v17, :cond_0

    .line 1217
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    move-object/from16 v17, v0

    const v18, 0x7f060009

    invoke-virtual/range {v17 .. v18}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v17

    add-int v11, v11, v17

    .line 1224
    :cond_0
    if-lt v12, v9, :cond_1

    if-gt v12, v10, :cond_1

    if-lt v13, v11, :cond_1

    if-le v13, v8, :cond_2

    .line 1226
    :cond_1
    move-object/from16 v0, p0

    invoke-virtual {v0, v14, v15}, Lcom/lge/app/floating/FloatingWindow;->calculateCorrectPosition(II)Landroid/graphics/Rect;

    move-result-object v16

    .line 1227
    .local v16, "tmp":Landroid/graphics/Rect;
    move-object/from16 v0, v16

    iget v14, v0, Landroid/graphics/Rect;->left:I

    .line 1228
    move-object/from16 v0, v16

    iget v15, v0, Landroid/graphics/Rect;->top:I

    .line 1230
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v17

    move-object/from16 v0, v17

    iput v14, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    .line 1231
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v17

    move-object/from16 v0, v17

    iput v15, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    .line 1236
    .end local v16    # "tmp":Landroid/graphics/Rect;
    :cond_2
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->bounceFloatingWindow()V

    .line 1238
    invoke-virtual/range {p0 .. p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v17

    move-object/from16 v0, p0

    move-object/from16 v1, v17

    invoke-virtual {v0, v1}, Lcom/lge/app/floating/FloatingWindow;->updateLayoutParamsInner(Lcom/lge/app/floating/FloatingWindow$LayoutParams;)V

    .line 1242
    return-void

    .line 1165
    .end local v2    # "bounceBottom":I
    .end local v3    # "bounceLeft":I
    .end local v4    # "bounceRight":I
    .end local v5    # "bounceTop":I
    .end local v6    # "display":Landroid/util/DisplayMetrics;
    .end local v7    # "floatingWindowSize":[I
    .end local v8    # "mBounceBottom":I
    .end local v9    # "mBounceLeft":I
    .end local v10    # "mBounceRight":I
    .end local v11    # "mBounceTop":I
    .end local v12    # "middleX":I
    .end local v13    # "middleY":I
    .end local v14    # "newX":I
    .end local v15    # "newY":I
    :cond_3
    const/16 v17, 0x0

    goto/16 :goto_0
.end method

.method private runExtraService(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 4
    .param p1, "serviceName"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;

    .prologue
    .line 3429
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    .line 3430
    .local v0, "intent":Landroid/content/Intent;
    new-instance v1, Landroid/content/ComponentName;

    const-string v2, "com.lge.app.floating.res"

    const-class v3, Lcom/lge/dockservice/DockWindowService;

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v2, v3}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    .line 3432
    sget-object v1, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "request DockWindowService to do "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " with "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 3434
    instance-of v1, p2, Ljava/lang/Boolean;

    if-eqz v1, :cond_1

    .line 3435
    check-cast p2, Ljava/lang/Boolean;

    .end local p2    # "value":Ljava/lang/Object;
    invoke-virtual {v0, p1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    .line 3441
    :cond_0
    :goto_0
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v1, v0}, Lcom/lge/app/floating/FloatableActivity;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    .line 3442
    return-void

    .line 3436
    .restart local p2    # "value":Ljava/lang/Object;
    :cond_1
    instance-of v1, p2, Ljava/lang/Integer;

    if-eqz v1, :cond_2

    .line 3437
    check-cast p2, Ljava/lang/Integer;

    .end local p2    # "value":Ljava/lang/Object;
    invoke-virtual {v0, p1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    goto :goto_0

    .line 3438
    .restart local p2    # "value":Ljava/lang/Object;
    :cond_2
    instance-of v1, p2, Ljava/lang/Float;

    if-eqz v1, :cond_0

    .line 3439
    check-cast p2, Ljava/lang/Float;

    .end local p2    # "value":Ljava/lang/Object;
    invoke-virtual {v0, p1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    goto :goto_0
.end method

.method private setOpacity(FZ)V
    .locals 2
    .param p1, "alpha"    # F
    .param p2, "updateViewLayout"    # Z

    .prologue
    .line 2246
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->isAttached()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 2247
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager$LayoutParams;

    .line 2249
    .local v0, "params":Landroid/view/WindowManager$LayoutParams;
    iput p1, v0, Landroid/view/WindowManager$LayoutParams;->alpha:F

    .line 2250
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v1

    invoke-static {v1, p1}, Lcom/lge/app/floating/FloatingWindow;->setSurfaceViewAlphaRecursively(Landroid/view/View;F)V

    .line 2251
    if-eqz p2, :cond_0

    .line 2252
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {p0, v1, v0}, Lcom/lge/app/floating/FloatingWindow;->updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    .line 2253
    iput p1, p0, Lcom/lge/app/floating/FloatingWindow;->mAlpha:F

    .line 2254
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mTitleView:Lcom/lge/app/floating/ITitleView;

    invoke-interface {v1}, Lcom/lge/app/floating/ITitleView;->update()V

    .line 2257
    .end local v0    # "params":Landroid/view/WindowManager$LayoutParams;
    :cond_0
    return-void
.end method

.method private setOverlay(ZZ)V
    .locals 5
    .param p1, "enable"    # Z
    .param p2, "updateViewLayout"    # Z

    .prologue
    const/4 v4, 0x0

    .line 2154
    iget-boolean v1, p0, Lcom/lge/app/floating/FloatingWindow;->mIsInOverlayMode:Z

    if-ne v1, p1, :cond_0

    .line 2155
    sget-object v1, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "overlay mode is already "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 2157
    :cond_0
    sget-object v1, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "set overlay = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 2158
    iput-boolean p1, p0, Lcom/lge/app/floating/FloatingWindow;->mIsInOverlayMode:Z

    .line 2159
    iget-boolean v1, p0, Lcom/lge/app/floating/FloatingWindow;->mIsAttached:Z

    if-nez v1, :cond_1

    .line 2207
    :goto_0
    return-void

    .line 2162
    :cond_1
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    instance-of v1, v1, Lcom/lge/app/floating/FloatingWindow$OnUpdateListener2;

    if-eqz v1, :cond_2

    .line 2164
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    check-cast v1, Lcom/lge/app/floating/FloatingWindow$OnUpdateListener2;

    invoke-interface {v1, p0, p1}, Lcom/lge/app/floating/FloatingWindow$OnUpdateListener2;->onOverlayStateChanged(Lcom/lge/app/floating/FloatingWindow;Z)V

    .line 2167
    :cond_2
    if-eqz p1, :cond_5

    .line 2170
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager$LayoutParams;

    .line 2172
    .local v0, "params":Landroid/view/WindowManager$LayoutParams;
    iget v1, v0, Landroid/view/WindowManager$LayoutParams;->flags:I

    or-int/lit8 v1, v1, 0x10

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 2173
    invoke-virtual {p0, v0}, Lcom/lge/app/floating/FloatingWindow;->setNotFocusableState(Landroid/view/WindowManager$LayoutParams;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    .line 2175
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameView:Lcom/lge/app/floating/IFrameView;

    invoke-interface {v1, v4}, Lcom/lge/app/floating/IFrameView;->setAsFocusable(Z)V

    .line 2176
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {p0, v1, v0}, Lcom/lge/app/floating/FloatingWindow;->updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    .line 2178
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->isWindowDocked()Z

    move-result v1

    if-nez v1, :cond_3

    .line 2179
    invoke-direct {p0}, Lcom/lge/app/floating/FloatingWindow;->attachTitleWindow()V

    .line 2181
    :cond_3
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->looseFocus()V

    .line 2184
    iget-boolean v1, p0, Lcom/lge/app/floating/FloatingWindow;->mIsImeVisible:Z

    if-eqz v1, :cond_4

    .line 2185
    sget-object v1, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v2, "hide IME in overlay mode"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 2186
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->hideIme()V

    .line 2187
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mInputMethodManager:Landroid/view/inputmethod/InputMethodManager;

    invoke-static {v1}, Lcom/lge/app/floating/FloatingFunctionReflect;->finishInputLocked(Landroid/view/inputmethod/InputMethodManager;)V

    .line 2188
    iput-boolean v4, p0, Lcom/lge/app/floating/FloatingWindow;->mIsImeVisible:Z

    .line 2206
    :cond_4
    :goto_1
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mLayout:Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    invoke-virtual {p0, v1}, Lcom/lge/app/floating/FloatingWindow;->updateLayoutParamsInner(Lcom/lge/app/floating/FloatingWindow$LayoutParams;)V

    goto :goto_0

    .line 2191
    .end local v0    # "params":Landroid/view/WindowManager$LayoutParams;
    :cond_5
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->isWindowDocked()Z

    move-result v1

    if-nez v1, :cond_6

    .line 2192
    invoke-direct {p0}, Lcom/lge/app/floating/FloatingWindow;->detachTitleWindow()V

    .line 2195
    :cond_6
    const/high16 v1, 0x3f800000    # 1.0f

    invoke-direct {p0, v1, p2}, Lcom/lge/app/floating/FloatingWindow;->setOpacity(FZ)V

    .line 2198
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager$LayoutParams;

    .line 2199
    .restart local v0    # "params":Landroid/view/WindowManager$LayoutParams;
    iget v1, v0, Landroid/view/WindowManager$LayoutParams;->flags:I

    and-int/lit8 v1, v1, -0x11

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 2200
    invoke-virtual {p0, v0}, Lcom/lge/app/floating/FloatingWindow;->setFocusableState(Landroid/view/WindowManager$LayoutParams;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    .line 2201
    if-eqz p2, :cond_7

    .line 2202
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {p0, v1, v0}, Lcom/lge/app/floating/FloatingWindow;->updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    .line 2204
    :cond_7
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->gainFocus()V

    goto :goto_1
.end method

.method private static setSurfaceViewAlphaRecursively(Landroid/view/View;F)V
    .locals 7
    .param p0, "aView"    # Landroid/view/View;
    .param p1, "alpha"    # F

    .prologue
    .line 3366
    invoke-virtual {p0}, Landroid/view/View;->getVisibility()I

    move-result v4

    if-eqz v4, :cond_1

    .line 3390
    :cond_0
    :goto_0
    return-void

    .line 3370
    :cond_1
    instance-of v4, p0, Landroid/view/SurfaceView;

    if-eqz v4, :cond_2

    .line 3372
    :try_start_0
    invoke-static {p0}, Lcom/lge/app/floating/FloatingFunctionReflect;->getSurfaceLayoutParams(Landroid/view/View;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v2

    .line 3374
    .local v2, "params":Landroid/view/WindowManager$LayoutParams;
    if-eqz v2, :cond_0

    .line 3375
    iput p1, v2, Landroid/view/WindowManager$LayoutParams;->alpha:F

    .line 3376
    const/4 v4, 0x1

    const/4 v5, 0x1

    invoke-static {p0, v4, v5}, Lcom/lge/app/floating/FloatingFunctionReflect;->updateWindow(Landroid/view/View;ZZ)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 3378
    .end local v2    # "params":Landroid/view/WindowManager$LayoutParams;
    :catch_0
    move-exception v0

    .line 3379
    .local v0, "e":Ljava/lang/Exception;
    sget-object v4, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "cannot set alpha for view: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 3384
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_2
    instance-of v4, p0, Landroid/view/ViewGroup;

    if-eqz v4, :cond_0

    move-object v3, p0

    .line 3385
    check-cast v3, Landroid/view/ViewGroup;

    .line 3386
    .local v3, "vg":Landroid/view/ViewGroup;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_1
    invoke-virtual {v3}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v4

    if-ge v1, v4, :cond_0

    .line 3387
    invoke-virtual {v3, v1}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v4

    invoke-static {v4, p1}, Lcom/lge/app/floating/FloatingWindow;->setSurfaceViewAlphaRecursively(Landroid/view/View;F)V

    .line 3386
    add-int/lit8 v1, v1, 0x1

    goto :goto_1
.end method

.method private static setSurfaceViewBackgroundAsTransparentRecursively(Landroid/view/View;)V
    .locals 3
    .param p0, "aView"    # Landroid/view/View;

    .prologue
    .line 3340
    invoke-virtual {p0}, Landroid/view/View;->getVisibility()I

    move-result v2

    if-eqz v2, :cond_1

    .line 3356
    :cond_0
    :goto_0
    return-void

    .line 3344
    :cond_1
    instance-of v2, p0, Landroid/view/SurfaceView;

    if-eqz v2, :cond_2

    .line 3345
    const/4 v2, 0x0

    invoke-virtual {p0, v2}, Landroid/view/View;->setBackgroundColor(I)V

    goto :goto_0

    .line 3349
    :cond_2
    instance-of v2, p0, Landroid/view/ViewGroup;

    if-eqz v2, :cond_0

    move-object v1, p0

    .line 3350
    check-cast v1, Landroid/view/ViewGroup;

    .line 3351
    .local v1, "vg":Landroid/view/ViewGroup;
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    invoke-virtual {v1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v2

    if-ge v0, v2, :cond_0

    .line 3352
    invoke-virtual {v1, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/app/floating/FloatingWindow;->setSurfaceViewBackgroundAsTransparentRecursively(Landroid/view/View;)V

    .line 3351
    add-int/lit8 v0, v0, 0x1

    goto :goto_1
.end method

.method private updateLayoutParamsInner(Lcom/lge/app/floating/FloatingWindow$LayoutParams;Z)V
    .locals 11
    .param p1, "params"    # Lcom/lge/app/floating/FloatingWindow$LayoutParams;
    .param p2, "preferSavedRegion"    # Z

    .prologue
    const v10, 0x7f060009

    const v9, 0x7f060002

    .line 1409
    sget-object v6, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "updateLayoutParamsInner to "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1412
    iget v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow;->mTitleView:Lcom/lge/app/floating/ITitleView;

    invoke-interface {v7}, Lcom/lge/app/floating/ITitleView;->getMinimumWidth()I

    move-result v7

    if-ge v6, v7, :cond_0

    .line 1413
    iget v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    if-eqz v6, :cond_0

    iget v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    if-eqz v6, :cond_0

    .line 1414
    iget v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    int-to-float v6, v6

    iget v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    int-to-float v7, v7

    div-float v4, v6, v7

    .line 1415
    .local v4, "ratio":F
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mTitleView:Lcom/lge/app/floating/ITitleView;

    invoke-interface {v6}, Lcom/lge/app/floating/ITitleView;->getMinimumWidth()I

    move-result v6

    iput v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    .line 1416
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mTitleView:Lcom/lge/app/floating/ITitleView;

    invoke-interface {v6}, Lcom/lge/app/floating/ITitleView;->getMinimumWidth()I

    move-result v6

    int-to-float v6, v6

    mul-float/2addr v6, v4

    float-to-int v6, v6

    iput v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    .line 1423
    .end local v4    # "ratio":F
    :cond_0
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v6

    iget v6, v6, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    iget v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    if-ne v6, v7, :cond_1

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v6

    iget v6, v6, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    iget v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    if-ne v6, v7, :cond_1

    .line 1424
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v6

    iget v6, v6, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    iget v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    if-eq v6, v7, :cond_1

    .line 1425
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v6}, Lcom/lge/app/floating/FloatableActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v6

    invoke-virtual {v6}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    .line 1428
    .local v1, "display":Landroid/util/DisplayMetrics;
    iget v6, v1, Landroid/util/DisplayMetrics;->widthPixels:I

    iget v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    sub-int/2addr v6, v7

    div-int/lit8 v6, v6, 0x2

    int-to-float v6, v6

    invoke-static {v6}, Ljava/lang/Math;->round(F)I

    move-result v6

    iput v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    .line 1430
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    invoke-virtual {v6, v10}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v6

    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    invoke-virtual {v7, v9}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v7

    add-int v0, v6, v7

    .line 1434
    .local v0, "defaultY":I
    iput v0, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    .line 1440
    .end local v0    # "defaultY":I
    .end local v1    # "display":Landroid/util/DisplayMetrics;
    :cond_1
    if-eqz p2, :cond_2

    .line 1441
    sget-object v6, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v7, "use preferSavedRegion info"

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1442
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v6}, Lcom/lge/app/floating/FloatableActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v6

    invoke-virtual {v6}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    .line 1444
    .restart local v1    # "display":Landroid/util/DisplayMetrics;
    iget v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    iget v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    div-int/lit8 v7, v7, 0x2

    add-int/2addr v6, v7

    int-to-float v6, v6

    iget v7, v1, Landroid/util/DisplayMetrics;->widthPixels:I

    int-to-float v7, v7

    div-float v2, v6, v7

    .line 1446
    .local v2, "hRatio":F
    iget v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    iget v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    div-int/lit8 v7, v7, 0x2

    add-int/2addr v6, v7

    int-to-float v6, v6

    iget v7, v1, Landroid/util/DisplayMetrics;->heightPixels:I

    int-to-float v7, v7

    div-float v5, v6, v7

    .line 1448
    .local v5, "vRatio":F
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    const-string v7, "com.lge.app.floating.pref"

    const/4 v8, 0x0

    invoke-virtual {v6, v7, v8}, Lcom/lge/app/floating/FloatableActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v3

    .line 1450
    .local v3, "prefs":Landroid/content/SharedPreferences;
    const-string v6, "floating_w"

    iget v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    invoke-interface {v3, v6, v7}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v6

    iput v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    .line 1451
    const-string v6, "floating_h"

    iget v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    invoke-interface {v3, v6, v7}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v6

    iput v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    .line 1452
    const-string v6, "floating_hor_ratio"

    invoke-interface {v3, v6, v2}, Landroid/content/SharedPreferences;->getFloat(Ljava/lang/String;F)F

    move-result v6

    iget v7, v1, Landroid/util/DisplayMetrics;->widthPixels:I

    int-to-float v7, v7

    mul-float/2addr v6, v7

    invoke-static {v6}, Ljava/lang/Math;->round(F)I

    move-result v6

    iget v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    div-int/lit8 v7, v7, 0x2

    sub-int/2addr v6, v7

    iput v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    .line 1455
    const-string v6, "floating_ver_ratio"

    invoke-interface {v3, v6, v5}, Landroid/content/SharedPreferences;->getFloat(Ljava/lang/String;F)F

    move-result v6

    iget v7, v1, Landroid/util/DisplayMetrics;->heightPixels:I

    int-to-float v7, v7

    mul-float/2addr v6, v7

    invoke-static {v6}, Ljava/lang/Math;->round(F)I

    move-result v6

    iget v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    div-int/lit8 v7, v7, 0x2

    sub-int/2addr v6, v7

    iput v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    .line 1461
    .end local v1    # "display":Landroid/util/DisplayMetrics;
    .end local v2    # "hRatio":F
    .end local v3    # "prefs":Landroid/content/SharedPreferences;
    .end local v5    # "vRatio":F
    :cond_2
    iget-boolean v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->hideTitle:Z

    if-nez v6, :cond_3

    iget-boolean v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->hideTitle:Z

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v7

    iget-boolean v7, v7, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->hideTitle:Z

    if-eq v6, v7, :cond_3

    .line 1463
    iget v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    invoke-virtual {v7, v10}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v7

    iget-object v8, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    invoke-virtual {v8, v9}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v8

    add-int/2addr v7, v8

    if-ge v6, v7, :cond_3

    .line 1467
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    invoke-virtual {v6, v10}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v6

    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    invoke-virtual {v7, v9}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v7

    add-int/2addr v6, v7

    iput v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    .line 1474
    :cond_3
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v6

    if-eq v6, p1, :cond_4

    .line 1475
    invoke-virtual {p1}, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->clone()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v6

    invoke-virtual {p0, v6}, Lcom/lge/app/floating/FloatingWindow;->setLayoutParam(Lcom/lge/app/floating/FloatingWindow$LayoutParams;)V

    .line 1479
    :cond_4
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->updateRealPositionAndSize()V

    .line 1483
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mTitleView:Lcom/lge/app/floating/ITitleView;

    invoke-interface {v6}, Lcom/lge/app/floating/ITitleView;->update()V

    .line 1485
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameView:Lcom/lge/app/floating/IFrameView;

    invoke-interface {v6}, Lcom/lge/app/floating/IFrameView;->update()V

    .line 1487
    iget v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    iget v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    invoke-virtual {p0, v6, v7}, Lcom/lge/app/floating/FloatingWindow;->moveInner(II)V

    .line 1488
    iget v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    iget v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    invoke-virtual {p0, v6, v7}, Lcom/lge/app/floating/FloatingWindow;->setSize(II)V

    .line 1490
    sget-object v6, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "actual LayoutParams: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1491
    return-void
.end method


# virtual methods
.method attach()V
    .locals 12

    .prologue
    const/4 v11, -0x1

    const/high16 v9, 0x3f800000    # 1.0f

    .line 1618
    invoke-direct {p0}, Lcom/lge/app/floating/FloatingWindow;->attachFrameWindow()V

    .line 1620
    iget-boolean v7, p0, Lcom/lge/app/floating/FloatingWindow;->mUseSeparateWindow:Z

    if-eqz v7, :cond_0

    .line 1621
    invoke-direct {p0}, Lcom/lge/app/floating/FloatingWindow;->attachTitleWindow()V

    .line 1625
    :cond_0
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v7

    const v8, 0x7f0c0006

    invoke-virtual {v7, v8}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v7

    const/16 v8, 0x8

    invoke-virtual {v7, v8}, Landroid/view/View;->setVisibility(I)V

    .line 1629
    const/4 v7, 0x1

    invoke-virtual {p0, v7}, Lcom/lge/app/floating/FloatingWindow;->setAttached(Z)V

    .line 1632
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v7

    invoke-virtual {p0, v7}, Lcom/lge/app/floating/FloatingWindow;->updateLayoutParamsInner(Lcom/lge/app/floating/FloatingWindow$LayoutParams;)V

    .line 1636
    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow;->mFloatingWindowManager:Lcom/lge/app/floating/FloatingWindowManager;

    invoke-virtual {v7, p0}, Lcom/lge/app/floating/FloatingWindowManager;->notifyNewTopWindow(Lcom/lge/app/floating/FloatingWindow;)V

    .line 1638
    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v7}, Lcom/lge/app/floating/FloatableActivity;->getIntent()Landroid/content/Intent;

    move-result-object v7

    const-string v8, "com.lge.app.floating.opacity"

    invoke-virtual {v7, v8, v9}, Landroid/content/Intent;->getFloatExtra(Ljava/lang/String;F)F

    move-result v6

    .line 1644
    .local v6, "opacity":F
    cmpg-float v7, v6, v9

    if-gez v7, :cond_1

    .line 1645
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->looseFocus()V

    .line 1652
    :cond_1
    invoke-direct {p0}, Lcom/lge/app/floating/FloatingWindow;->repositionFloatingWindow()V

    .line 1656
    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v7}, Lcom/lge/app/floating/FloatableActivity;->getIntent()Landroid/content/Intent;

    move-result-object v4

    .line 1657
    .local v4, "intent":Landroid/content/Intent;
    if-eqz v4, :cond_2

    .line 1658
    const-string v7, "com.lge.floating.NEED_TO_DOCK"

    const/4 v8, 0x0

    invoke-virtual {v4, v7, v8}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v7

    iput-boolean v7, p0, Lcom/lge/app/floating/FloatingWindow;->mNeedToDockOnStarting:Z

    .line 1660
    const-string v7, "com.lge.floating.NEED_TO_DOCK"

    invoke-virtual {v4, v7}, Landroid/content/Intent;->removeExtra(Ljava/lang/String;)V

    .line 1661
    const-string v7, "com.lge.floating.DOCK_DIRECTION"

    invoke-virtual {v4, v7}, Landroid/content/Intent;->removeExtra(Ljava/lang/String;)V

    .line 1665
    :cond_2
    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v7, p0}, Lcom/lge/app/floating/FloatableActivity;->handleAttachToFloatingWindow(Lcom/lge/app/floating/FloatingWindow;)V

    .line 1668
    const/4 v3, -0x1

    .line 1669
    .local v3, "dockServiceEnabledFlagId":I
    const/4 v5, 0x1

    .line 1670
    .local v5, "isDockServiceEnabled":Z
    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    const-string v8, "dock_service_enabled"

    const-string v9, "bool"

    const-string v10, "com.lge.internal"

    invoke-virtual {v7, v8, v9, v10}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    .line 1672
    if-lez v3, :cond_3

    .line 1673
    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    invoke-virtual {v7, v3}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v5

    .line 1675
    :cond_3
    if-eqz v5, :cond_4

    .line 1676
    sget-object v7, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v8, "dock service is available"

    invoke-static {v7, v8}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1677
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->initFloatingDockWindow()V

    .line 1678
    sget-object v7, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "mDockWindow = "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget-object v9, p0, Lcom/lge/app/floating/FloatingWindow;->mDockWindow:Lcom/lge/app/floating/FloatingDockWindow;

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1679
    iget-boolean v7, p0, Lcom/lge/app/floating/FloatingWindow;->mNeedToDockOnStarting:Z

    if-eqz v7, :cond_4

    .line 1680
    new-instance v0, Landroid/graphics/Point;

    invoke-direct {v0}, Landroid/graphics/Point;-><init>()V

    .line 1681
    .local v0, "dockPoint":Landroid/graphics/Point;
    const-string v7, "com.lge.floating.DOCK_POSX"

    invoke-virtual {v4, v7, v11}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v1

    .line 1682
    .local v1, "dockPosX":I
    const-string v7, "com.lge.floating.DOCK_POSY"

    invoke-virtual {v4, v7, v11}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v2

    .line 1683
    .local v2, "dockPosY":I
    const-string v7, "com.lge.floating.DOCK_POSX"

    invoke-virtual {v4, v7}, Landroid/content/Intent;->removeExtra(Ljava/lang/String;)V

    .line 1684
    const-string v7, "com.lge.floating.DOCK_POSY"

    invoke-virtual {v4, v7}, Landroid/content/Intent;->removeExtra(Ljava/lang/String;)V

    .line 1685
    iput v1, v0, Landroid/graphics/Point;->x:I

    .line 1686
    iput v2, v0, Landroid/graphics/Point;->y:I

    .line 1688
    sget-object v7, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "restoreDockWindow to pos ( "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget v9, v0, Landroid/graphics/Point;->x:I

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " , "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    iget v9, v0, Landroid/graphics/Point;->y:I

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " )"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1689
    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow;->mDockWindow:Lcom/lge/app/floating/FloatingDockWindow;

    iget v8, v0, Landroid/graphics/Point;->x:I

    iget v9, v0, Landroid/graphics/Point;->y:I

    invoke-virtual {v7, v8, v9}, Lcom/lge/app/floating/FloatingDockWindow;->restoreDockWindow(II)V

    .line 1692
    .end local v0    # "dockPoint":Landroid/graphics/Point;
    .end local v1    # "dockPosX":I
    .end local v2    # "dockPosY":I
    :cond_4
    return-void
.end method

.method bounceFloatingWindow()V
    .locals 3

    .prologue
    .line 3238
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v1

    iget v1, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v2

    iget v2, v2, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    invoke-virtual {p0, v1, v2}, Lcom/lge/app/floating/FloatingWindow;->calculateCorrectPosition(II)Landroid/graphics/Rect;

    move-result-object v0

    .line 3240
    .local v0, "r":Landroid/graphics/Rect;
    invoke-virtual {p0, v0}, Lcom/lge/app/floating/FloatingWindow;->bounceFloatingWindow(Landroid/graphics/Rect;)V

    .line 3241
    return-void
.end method

.method bounceFloatingWindow(Landroid/graphics/Rect;)V
    .locals 1
    .param p1, "r"    # Landroid/graphics/Rect;

    .prologue
    .line 3244
    invoke-virtual {p0, p1}, Lcom/lge/app/floating/FloatingWindow;->isInCorrectPositionAndSize(Landroid/graphics/Rect;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 3245
    invoke-direct {p0, p1}, Lcom/lge/app/floating/FloatingWindow;->createBounceAnimator(Landroid/graphics/Rect;)V

    .line 3246
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getBounceAnimator()Landroid/animation/ValueAnimator;

    move-result-object v0

    invoke-virtual {v0}, Landroid/animation/ValueAnimator;->start()V

    .line 3248
    :cond_0
    return-void
.end method

.method calculateCorrectPosition(II)Landroid/graphics/Rect;
    .locals 15
    .param p1, "x"    # I
    .param p2, "y"    # I

    .prologue
    .line 3019
    iget-object v12, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v12}, Lcom/lge/app/floating/FloatableActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v12

    invoke-virtual {v12}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v6

    .line 3021
    .local v6, "dm":Landroid/util/DisplayMetrics;
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v12

    iget v1, v12, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    .line 3022
    .local v1, "correctWidth":I
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v12

    iget v0, v12, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    .line 3024
    .local v0, "correctHeight":I
    const/4 v10, 0x0

    .line 3025
    .local v10, "minY":I
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v12

    iget-boolean v12, v12, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->hideTitle:Z

    if-eqz v12, :cond_0

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->isInOverlay()Z

    move-result v12

    if-nez v12, :cond_0

    .line 3026
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v12

    iget v12, v12, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->bounceMarginTop:F

    int-to-float v13, v0

    mul-float/2addr v12, v13

    invoke-static {v12}, Ljava/lang/Math;->round(F)I

    move-result v12

    rsub-int/lit8 v10, v12, 0x0

    .line 3039
    :goto_0
    iget v12, v6, Landroid/util/DisplayMetrics;->heightPixels:I

    const/high16 v13, 0x3f800000    # 1.0f

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v14

    iget v14, v14, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->bounceMarginBottom:F

    sub-float/2addr v13, v14

    int-to-float v14, v0

    mul-float/2addr v13, v14

    invoke-static {v13}, Ljava/lang/Math;->round(F)I

    move-result v13

    sub-int v8, v12, v13

    .line 3042
    .local v8, "maxY":I
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v12

    iget v12, v12, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->bounceMarginLeft:F

    int-to-float v13, v1

    mul-float/2addr v12, v13

    invoke-static {v12}, Ljava/lang/Math;->round(F)I

    move-result v12

    rsub-int/lit8 v9, v12, 0x0

    .line 3044
    .local v9, "minX":I
    iget v12, v6, Landroid/util/DisplayMetrics;->widthPixels:I

    const/high16 v13, 0x3f800000    # 1.0f

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v14

    iget v14, v14, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->bounceMarginRight:F

    sub-float/2addr v13, v14

    int-to-float v14, v1

    mul-float/2addr v13, v14

    invoke-static {v13}, Ljava/lang/Math;->round(F)I

    move-result v13

    sub-int v7, v12, v13

    .line 3048
    .local v7, "maxX":I
    move/from16 v4, p1

    .line 3049
    .local v4, "currentX":I
    move/from16 v5, p2

    .line 3051
    .local v5, "currentY":I
    if-le v4, v7, :cond_1

    move v2, v7

    .line 3053
    .local v2, "correctX":I
    :goto_1
    if-le v5, v8, :cond_3

    move v3, v8

    .line 3056
    .local v3, "correctY":I
    :goto_2
    new-instance v11, Landroid/graphics/Rect;

    invoke-direct {v11}, Landroid/graphics/Rect;-><init>()V

    .line 3057
    .local v11, "rect":Landroid/graphics/Rect;
    iput v2, v11, Landroid/graphics/Rect;->left:I

    .line 3058
    iput v3, v11, Landroid/graphics/Rect;->top:I

    .line 3059
    add-int v12, v2, v1

    iput v12, v11, Landroid/graphics/Rect;->right:I

    .line 3060
    add-int v12, v3, v0

    iput v12, v11, Landroid/graphics/Rect;->bottom:I

    .line 3061
    return-object v11

    .line 3033
    .end local v2    # "correctX":I
    .end local v3    # "correctY":I
    .end local v4    # "currentX":I
    .end local v5    # "currentY":I
    .end local v7    # "maxX":I
    .end local v8    # "maxY":I
    .end local v9    # "minX":I
    .end local v11    # "rect":Landroid/graphics/Rect;
    :cond_0
    iget-object v12, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    const v13, 0x7f060009

    invoke-virtual {v12, v13}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v12

    iget-object v13, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    const v14, 0x7f060002

    invoke-virtual {v13, v14}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v13

    add-int v10, v12, v13

    goto :goto_0

    .line 3051
    .restart local v4    # "currentX":I
    .restart local v5    # "currentY":I
    .restart local v7    # "maxX":I
    .restart local v8    # "maxY":I
    .restart local v9    # "minX":I
    :cond_1
    if-ge v4, v9, :cond_2

    move v2, v9

    goto :goto_1

    :cond_2
    move v2, v4

    goto :goto_1

    .line 3053
    .restart local v2    # "correctX":I
    :cond_3
    if-ge v5, v10, :cond_4

    move v3, v10

    goto :goto_2

    :cond_4
    move v3, v5

    goto :goto_2
.end method

.method calculateFloatingWindowLocationY(I)I
    .locals 6
    .param p1, "currentY"    # I

    .prologue
    const v5, 0x7f060009

    const v4, 0x7f060002

    .line 3118
    move v0, p1

    .line 3123
    .local v0, "floatingWindowY":I
    iget-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    invoke-virtual {v2, v4}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v2

    sub-int v2, v0, v2

    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    invoke-virtual {v3, v5}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v3

    if-le v2, v3, :cond_1

    const/4 v1, 0x1

    .line 3127
    .local v1, "isInScreen":Z
    :goto_0
    if-nez v1, :cond_0

    .line 3130
    iget-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    invoke-virtual {v2, v5}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v2

    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    invoke-virtual {v3, v4}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v3

    add-int v0, v2, v3

    .line 3135
    :cond_0
    return v0

    .line 3123
    .end local v1    # "isInScreen":Z
    :cond_1
    const/4 v1, 0x0

    goto :goto_0
.end method

.method calculateFloatingWindowSize(Lcom/lge/app/floating/FloatingWindow$LayoutParams;)[I
    .locals 14
    .param p1, "mLayout"    # Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    .prologue
    const v13, 0x7f060009

    const v12, 0x7f060002

    const/4 v11, 0x7

    const/4 v10, 0x1

    const/4 v9, 0x0

    .line 3076
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v6}, Lcom/lge/app/floating/FloatableActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v6

    invoke-virtual {v6}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v4

    .line 3078
    .local v4, "display":Landroid/util/DisplayMetrics;
    const/4 v6, 0x2

    new-array v5, v6, [I

    iget v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    aput v6, v5, v9

    iget v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    aput v6, v5, v10

    .line 3079
    .local v5, "floatingWindowSize":[I
    const/4 v2, 0x0

    .line 3080
    .local v2, "diffHeight":I
    const/4 v3, 0x0

    .line 3082
    .local v3, "diffWidth":I
    iget v6, v4, Landroid/util/DisplayMetrics;->widthPixels:I

    iget v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    invoke-direct {p0, v6, v7}, Lcom/lge/app/floating/FloatingWindow;->checkWindowSize(II)Z

    move-result v1

    .line 3083
    .local v1, "checkWidth":Z
    iget v6, v4, Landroid/util/DisplayMetrics;->heightPixels:I

    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    invoke-virtual {v7, v13}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v7

    sub-int/2addr v6, v7

    iget v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    iget-object v8, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    invoke-virtual {v8, v12}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v8

    add-int/2addr v7, v8

    invoke-direct {p0, v6, v7}, Lcom/lge/app/floating/FloatingWindow;->checkWindowSize(II)Z

    move-result v0

    .line 3088
    .local v0, "checkHeight":Z
    if-nez v0, :cond_2

    .line 3092
    iget v6, v4, Landroid/util/DisplayMetrics;->heightPixels:I

    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    invoke-virtual {v7, v13}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v7

    sub-int/2addr v6, v7

    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    invoke-virtual {v7, v12}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v7

    sub-int/2addr v6, v7

    aput v6, v5, v10

    .line 3096
    iget v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    aget v7, v5, v10

    sub-int v2, v6, v7

    .line 3098
    iget v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->resizeOption:I

    if-eq v6, v11, :cond_0

    iget v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->resizeOption:I

    if-nez v6, :cond_1

    .line 3100
    :cond_0
    iget v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    mul-int/2addr v6, v2

    iget v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    div-int v3, v6, v7

    .line 3101
    iget v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    sub-int/2addr v6, v3

    aput v6, v5, v9

    .line 3114
    :cond_1
    :goto_0
    return-object v5

    .line 3103
    :cond_2
    if-nez v1, :cond_1

    .line 3104
    iget v6, v4, Landroid/util/DisplayMetrics;->widthPixels:I

    aput v6, v5, v9

    .line 3105
    iget v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    aget v7, v5, v9

    sub-int v3, v6, v7

    .line 3107
    iget v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->resizeOption:I

    if-eq v6, v11, :cond_3

    iget v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->resizeOption:I

    if-nez v6, :cond_1

    .line 3109
    :cond_3
    iget v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    mul-int/2addr v6, v3

    iget v7, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    div-int v2, v6, v7

    .line 3110
    iget v6, p1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    sub-int/2addr v6, v2

    aput v6, v5, v10

    goto :goto_0
.end method

.method calculateLocationRatio(III)I
    .locals 2
    .param p1, "height"    # I
    .param p2, "width"    # I
    .param p3, "point"    # I

    .prologue
    .line 3066
    mul-int v1, p2, p3

    div-int v0, v1, p1

    .line 3067
    .local v0, "res":I
    if-lt v0, p2, :cond_0

    .end local p2    # "width":I
    :goto_0
    return p2

    .restart local p2    # "width":I
    :cond_0
    move p2, v0

    goto :goto_0
.end method

.method public close()V
    .locals 1

    .prologue
    .line 2073
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/lge/app/floating/FloatingWindow;->close(Z)V

    .line 2074
    return-void
.end method

.method public close(Z)V
    .locals 3
    .param p1, "isReturningToFullscreen"    # Z

    .prologue
    .line 2085
    sget-object v0, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "close floating window :  ( "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " ) : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mWindowName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 2087
    invoke-virtual {p0, p1}, Lcom/lge/app/floating/FloatingWindow;->closeInner(Z)V

    .line 2088
    return-void
.end method

.method closeInner()V
    .locals 1

    .prologue
    .line 2092
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/lge/app/floating/FloatingWindow;->closeInner(Z)V

    .line 2093
    return-void
.end method

.method closeInner(Z)V
    .locals 5
    .param p1, "isReturningToFullscreen"    # Z

    .prologue
    const/4 v4, 0x0

    .line 2097
    sget-object v1, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "closeInner floating window :  ( "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " ) : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mWindowName:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 2099
    sput-boolean v4, Lcom/lge/app/floating/FloatingWindow;->sSavedLocation:Z

    .line 2100
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->isAttached()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 2103
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->looseFocus()V

    .line 2106
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getRealWindowManager()Landroid/view/WindowManager;

    move-result-object v1

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v2

    invoke-interface {v1, v2}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V

    .line 2107
    iget-boolean v1, p0, Lcom/lge/app/floating/FloatingWindow;->mIsTitleInSeparateWindow:Z

    if-eqz v1, :cond_0

    .line 2108
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager$LayoutParams;

    .line 2110
    .local v0, "titleParams":Landroid/view/WindowManager$LayoutParams;
    iget v1, p0, Lcom/lge/app/floating/FloatingWindow;->mAnimStyleId:I

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->windowAnimations:I

    .line 2111
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {p0, v1, v0}, Lcom/lge/app/floating/FloatingWindow;->updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    .line 2112
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getRealWindowManager()Landroid/view/WindowManager;

    move-result-object v1

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v2

    invoke-interface {v1, v2}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V

    .line 2118
    .end local v0    # "titleParams":Landroid/view/WindowManager$LayoutParams;
    :cond_0
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameView:Lcom/lge/app/floating/IFrameView;

    invoke-interface {v1}, Lcom/lge/app/floating/IFrameView;->resetResizeFrame()Z

    .line 2122
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->isInOverlay()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 2123
    sget-object v1, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v2, "exit overlay mode"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2124
    invoke-direct {p0, v4, v4}, Lcom/lge/app/floating/FloatingWindow;->setOverlay(ZZ)V

    .line 2126
    :cond_1
    invoke-virtual {p0, v4}, Lcom/lge/app/floating/FloatingWindow;->setAttached(Z)V

    .line 2129
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v1, p0, p1}, Lcom/lge/app/floating/FloatableActivity;->handleDetachFromFloatingWindow(Lcom/lge/app/floating/FloatingWindow;Z)V

    .line 2132
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    if-eqz v1, :cond_2

    .line 2133
    if-eqz p1, :cond_4

    .line 2134
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    invoke-interface {v1, p0}, Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;->onSwitchingFull(Lcom/lge/app/floating/FloatingWindow;)V

    .line 2141
    :cond_2
    :goto_0
    sget-object v1, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "close : isReturningToFullscreen = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2143
    if-nez p1, :cond_3

    iget-boolean v1, p0, Lcom/lge/app/floating/FloatingWindow;->mSwitchingFull:Z

    if-eqz v1, :cond_5

    .line 2144
    :cond_3
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mFloatingWindowManager:Lcom/lge/app/floating/FloatingWindowManager;

    const-string v2, "fullmode"

    invoke-virtual {v1, p0, v2}, Lcom/lge/app/floating/FloatingWindowManager;->removeFloatingWindow(Lcom/lge/app/floating/FloatingWindow;Ljava/lang/String;)V

    .line 2150
    :goto_1
    iput-boolean v4, p0, Lcom/lge/app/floating/FloatingWindow;->mSwitchingFull:Z

    .line 2151
    return-void

    .line 2136
    :cond_4
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    invoke-interface {v1, p0}, Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;->onClosing(Lcom/lge/app/floating/FloatingWindow;)V

    goto :goto_0

    .line 2147
    :cond_5
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mFloatingWindowManager:Lcom/lge/app/floating/FloatingWindowManager;

    const-string v2, "close"

    invoke-virtual {v1, p0, v2}, Lcom/lge/app/floating/FloatingWindowManager;->removeFloatingWindow(Lcom/lge/app/floating/FloatingWindow;Ljava/lang/String;)V

    goto :goto_1
.end method

.method configurationChangeForActivity(Landroid/content/res/Configuration;)V
    .locals 1
    .param p1, "newConfig"    # Landroid/content/res/Configuration;

    .prologue
    .line 3425
    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v0, p1}, Lcom/lge/app/floating/FloatableActivity;->restartIfNecessary(Landroid/content/res/Configuration;)V

    .line 3426
    return-void
.end method

.method configurationChangeforWindow(Landroid/content/res/Configuration;)V
    .locals 5
    .param p1, "newConfig"    # Landroid/content/res/Configuration;

    .prologue
    const/4 v2, 0x0

    .line 2950
    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v3, p1}, Lcom/lge/app/floating/FloatableActivity;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    .line 2951
    iget v3, p1, Landroid/content/res/Configuration;->fontScale:F

    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedConfig:Landroid/content/res/Configuration;

    iget v4, v4, Landroid/content/res/Configuration;->fontScale:F

    sub-float/2addr v3, v4

    invoke-static {v3}, Ljava/lang/Math;->abs(F)F

    move-result v3

    const/4 v4, 0x0

    cmpl-float v3, v3, v4

    if-lez v3, :cond_3

    const/4 v0, 0x1

    .line 2953
    .local v0, "fontScaleChanged":Z
    :goto_0
    if-nez v0, :cond_0

    iget-object v3, p1, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedConfig:Landroid/content/res/Configuration;

    iget-object v4, v4, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    invoke-virtual {v3, v4}, Ljava/util/Locale;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 2955
    :cond_0
    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v3, p1}, Lcom/lge/app/floating/FloatableActivity;->setViewForConfigChanged(Landroid/content/res/Configuration;)V

    .line 2957
    if-eqz v0, :cond_1

    .line 2958
    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mTitleView:Lcom/lge/app/floating/ITitleView;

    invoke-interface {v3}, Lcom/lge/app/floating/ITitleView;->getTitleText()Landroid/widget/TextView;

    move-result-object v3

    invoke-virtual {v3}, Landroid/widget/TextView;->getTextSize()F

    move-result v3

    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedConfig:Landroid/content/res/Configuration;

    iget v4, v4, Landroid/content/res/Configuration;->fontScale:F

    div-float/2addr v3, v4

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    int-to-float v3, v3

    iget v4, p1, Landroid/content/res/Configuration;->fontScale:F

    mul-float/2addr v3, v4

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v1

    .line 2961
    .local v1, "size":I
    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mTitleView:Lcom/lge/app/floating/ITitleView;

    invoke-interface {v3}, Lcom/lge/app/floating/ITitleView;->getTitleText()Landroid/widget/TextView;

    move-result-object v3

    int-to-float v4, v1

    invoke-virtual {v3, v2, v4}, Landroid/widget/TextView;->setTextSize(IF)V

    .line 2965
    .end local v1    # "size":I
    :cond_1
    iget-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedConfig:Landroid/content/res/Configuration;

    iget v2, v2, Landroid/content/res/Configuration;->orientation:I

    iget v3, p1, Landroid/content/res/Configuration;->orientation:I

    if-eq v2, v3, :cond_2

    .line 2967
    iget-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameView:Lcom/lge/app/floating/IFrameView;

    invoke-interface {v2, p1}, Lcom/lge/app/floating/IFrameView;->doOnConfigurationChanged(Landroid/content/res/Configuration;)V

    .line 2969
    :cond_2
    iget-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedConfig:Landroid/content/res/Configuration;

    invoke-virtual {v2, p1}, Landroid/content/res/Configuration;->updateFrom(Landroid/content/res/Configuration;)I

    .line 2970
    return-void

    .end local v0    # "fontScaleChanged":Z
    :cond_3
    move v0, v2

    .line 2951
    goto :goto_0
.end method

.method convertViewPositionToWindowPosition(Landroid/view/View;II)[I
    .locals 9
    .param p1, "v"    # Landroid/view/View;
    .param p2, "x"    # I
    .param p3, "y"    # I

    .prologue
    const/4 v8, 0x2

    const/4 v5, 0x0

    const/4 v6, 0x1

    .line 1587
    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameView:Lcom/lge/app/floating/IFrameView;

    invoke-interface {v7}, Lcom/lge/app/floating/IFrameView;->getPadding()Landroid/graphics/Rect;

    move-result-object v1

    .line 1588
    .local v1, "padding":Landroid/graphics/Rect;
    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow;->mTitleView:Lcom/lge/app/floating/ITitleView;

    invoke-interface {v7}, Lcom/lge/app/floating/ITitleView;->measureAndGetHeight()I

    move-result v3

    .line 1589
    .local v3, "titleHeight":I
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v7

    iget-boolean v7, v7, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->useOverlappingTitle:Z

    if-nez v7, :cond_0

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->titleShouldBeHidden()Z

    move-result v7

    if-eqz v7, :cond_2

    :cond_0
    move v0, v6

    .line 1592
    .local v0, "canIgnoreTitleHeight":Z
    :goto_0
    new-array v2, v8, [I

    .line 1593
    .local v2, "positionInWindow":[I
    new-array v4, v8, [I

    .line 1594
    .local v4, "viewLocation":[I
    invoke-virtual {p1, v4}, Landroid/view/View;->getLocationInWindow([I)V

    .line 1596
    aget v7, v4, v5

    add-int/2addr v7, p2

    iget v8, v1, Landroid/graphics/Rect;->left:I

    sub-int/2addr v7, v8

    aput v7, v2, v5

    .line 1597
    aget v5, v4, v6

    add-int/2addr v5, p3

    iget v7, v1, Landroid/graphics/Rect;->top:I

    sub-int/2addr v5, v7

    aput v5, v2, v6

    .line 1599
    iget-boolean v5, p0, Lcom/lge/app/floating/FloatingWindow;->mUseSeparateWindow:Z

    if-eqz v5, :cond_3

    .line 1600
    invoke-virtual {p1}, Landroid/view/View;->getWindowToken()Landroid/os/IBinder;

    move-result-object v5

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v7

    invoke-virtual {v7}, Landroid/view/View;->getWindowToken()Landroid/os/IBinder;

    move-result-object v7

    if-ne v5, v7, :cond_1

    .line 1601
    if-nez v0, :cond_1

    .line 1602
    aget v5, v2, v6

    sub-int/2addr v5, v3

    aput v5, v2, v6

    .line 1611
    :cond_1
    :goto_1
    return-object v2

    .end local v0    # "canIgnoreTitleHeight":Z
    .end local v2    # "positionInWindow":[I
    .end local v4    # "viewLocation":[I
    :cond_2
    move v0, v5

    .line 1589
    goto :goto_0

    .line 1606
    .restart local v0    # "canIgnoreTitleHeight":Z
    .restart local v2    # "positionInWindow":[I
    .restart local v4    # "viewLocation":[I
    :cond_3
    if-nez v0, :cond_1

    .line 1607
    aget v5, v2, v6

    sub-int/2addr v5, v3

    aput v5, v2, v6

    goto :goto_1
.end method

.method public enterLowProfile(Z)V
    .locals 9
    .param p1, "hide"    # Z

    .prologue
    const/4 v4, 0x0

    const/4 v5, 0x1

    .line 2664
    iget-boolean v6, p0, Lcom/lge/app/floating/FloatingWindow;->mIsInLowProfile:Z

    if-eqz v6, :cond_0

    iget-boolean v6, p0, Lcom/lge/app/floating/FloatingWindow;->mIsHidden:Z

    if-nez v6, :cond_0

    if-nez p1, :cond_0

    .line 2665
    sget-object v4, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v5, "Current state is already in LowProfile(false). Do not enterLowProfile."

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 2798
    :goto_0
    return-void

    .line 2668
    :cond_0
    iget-boolean v6, p0, Lcom/lge/app/floating/FloatingWindow;->mIsInLowProfile:Z

    if-eqz v6, :cond_1

    iget-boolean v6, p0, Lcom/lge/app/floating/FloatingWindow;->mIsHidden:Z

    if-eqz v6, :cond_1

    if-eqz p1, :cond_1

    .line 2669
    sget-object v4, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v5, "Current state is already in LowProfile(true). Do not enterLowProfile."

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 2673
    :cond_1
    sget-object v6, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "enter low profile. hide="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 2674
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mLowProfileAnimator:Landroid/animation/ValueAnimator;

    if-eqz v6, :cond_2

    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mLowProfileAnimator:Landroid/animation/ValueAnimator;

    invoke-virtual {v6}, Landroid/animation/ValueAnimator;->isStarted()Z

    move-result v6

    if-eqz v6, :cond_2

    .line 2676
    sget-object v6, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v7, "enterLowProfile cancels started mLowProfileAnimator"

    invoke-static {v6, v7}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 2678
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mLowProfileAnimator:Landroid/animation/ValueAnimator;

    invoke-virtual {v6}, Landroid/animation/ValueAnimator;->cancel()V

    .line 2687
    :cond_2
    iget-boolean v6, p0, Lcom/lge/app/floating/FloatingWindow;->mIsResizing:Z

    if-eqz v6, :cond_4

    .line 2688
    sget-object v6, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v7, "cancel resizing when entering low profile"

    invoke-static {v6, v7}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 2689
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameView:Lcom/lge/app/floating/IFrameView;

    invoke-interface {v6}, Lcom/lge/app/floating/IFrameView;->updateResizeHandle()V

    .line 2694
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameView:Lcom/lge/app/floating/IFrameView;

    invoke-interface {v6}, Lcom/lge/app/floating/IFrameView;->resetResizeFrame()Z

    .line 2695
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    if-eqz v6, :cond_3

    .line 2696
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    invoke-interface {v6, p0}, Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;->onResizeCanceled(Lcom/lge/app/floating/FloatingWindow;)V

    .line 2698
    :cond_3
    iput-boolean v4, p0, Lcom/lge/app/floating/FloatingWindow;->mIsResizing:Z

    .line 2699
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v6

    invoke-virtual {p0, v6}, Lcom/lge/app/floating/FloatingWindow;->updateLayoutParamsInner(Lcom/lge/app/floating/FloatingWindow$LayoutParams;)V

    .line 2701
    :cond_4
    const/4 v2, 0x0

    .line 2703
    .local v2, "proceed":Z
    :try_start_0
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    if-eqz v6, :cond_5

    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    invoke-interface {v6, p0, p1}, Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;->onEnteringLowProfileMode(Lcom/lge/app/floating/FloatingWindow;Z)Z
    :try_end_0
    .catch Ljava/lang/AbstractMethodError; {:try_start_0 .. :try_end_0} :catch_0

    move-result v6

    if-eqz v6, :cond_6

    :cond_5
    move v2, v5

    .line 2708
    :goto_1
    if-nez v2, :cond_7

    .line 2709
    sget-object v4, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v5, "application wants to stop proceeding enterLowProfile"

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :cond_6
    move v2, v4

    .line 2703
    goto :goto_1

    .line 2705
    :catch_0
    move-exception v0

    .line 2706
    .local v0, "e":Ljava/lang/AbstractMethodError;
    sget-object v6, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v7, "AbstractMethodError!"

    invoke-static {v6, v7}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 2714
    .end local v0    # "e":Ljava/lang/AbstractMethodError;
    :cond_7
    iget-boolean v6, p0, Lcom/lge/app/floating/FloatingWindow;->mIsInLowProfile:Z

    if-nez v6, :cond_8

    .line 2715
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getOpacity()F

    move-result v6

    iput v6, p0, Lcom/lge/app/floating/FloatingWindow;->mAlphaSavedForLowProfile:F

    .line 2718
    :cond_8
    iput-boolean v5, p0, Lcom/lge/app/floating/FloatingWindow;->mIsInLowProfile:Z

    .line 2719
    iput-boolean p1, p0, Lcom/lge/app/floating/FloatingWindow;->mIsHidden:Z

    .line 2721
    if-nez p1, :cond_b

    .line 2722
    invoke-virtual {p0, v5}, Lcom/lge/app/floating/FloatingWindow;->setOverlay(Z)V

    .line 2723
    iget-boolean v6, p0, Lcom/lge/app/floating/FloatingWindow;->mIsTitleInSeparateWindow:Z

    if-eqz v6, :cond_9

    .line 2724
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v6

    invoke-virtual {v6}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v3

    check-cast v3, Landroid/view/WindowManager$LayoutParams;

    .line 2726
    .local v3, "titleParams":Landroid/view/WindowManager$LayoutParams;
    iget v6, v3, Landroid/view/WindowManager$LayoutParams;->flags:I

    and-int/lit8 v6, v6, -0x11

    iput v6, v3, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 2727
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v6

    invoke-virtual {p0, v6, v3}, Lcom/lge/app/floating/FloatingWindow;->updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    .line 2729
    .end local v3    # "titleParams":Landroid/view/WindowManager$LayoutParams;
    :cond_9
    const/4 v6, 0x2

    new-array v6, v6, [F

    iget v7, p0, Lcom/lge/app/floating/FloatingWindow;->mAlphaSavedForLowProfile:F

    aput v7, v6, v4

    const v4, 0x3dcccccd    # 0.1f

    aput v4, v6, v5

    invoke-static {v6}, Landroid/animation/ValueAnimator;->ofFloat([F)Landroid/animation/ValueAnimator;

    move-result-object v4

    iput-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mLowProfileAnimator:Landroid/animation/ValueAnimator;

    .line 2732
    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mLowProfileAnimator:Landroid/animation/ValueAnimator;

    const-wide/16 v6, 0x3e8

    invoke-virtual {v4, v6, v7}, Landroid/animation/ValueAnimator;->setDuration(J)Landroid/animation/ValueAnimator;

    .line 2734
    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mLowProfileAnimator:Landroid/animation/ValueAnimator;

    new-instance v5, Lcom/lge/app/floating/FloatingWindow$3;

    invoke-direct {v5, p0}, Lcom/lge/app/floating/FloatingWindow$3;-><init>(Lcom/lge/app/floating/FloatingWindow;)V

    invoke-virtual {v4, v5}, Landroid/animation/ValueAnimator;->addListener(Landroid/animation/Animator$AnimatorListener;)V

    .line 2747
    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mLowProfileAnimator:Landroid/animation/ValueAnimator;

    new-instance v5, Lcom/lge/app/floating/FloatingWindow$4;

    invoke-direct {v5, p0}, Lcom/lge/app/floating/FloatingWindow$4;-><init>(Lcom/lge/app/floating/FloatingWindow;)V

    invoke-virtual {v4, v5}, Landroid/animation/ValueAnimator;->addUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    .line 2762
    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mLowProfileAnimator:Landroid/animation/ValueAnimator;

    invoke-virtual {v4}, Landroid/animation/ValueAnimator;->start()V

    .line 2764
    iget-boolean v4, p0, Lcom/lge/app/floating/FloatingWindow;->mIsHidden:Z

    if-eqz v4, :cond_a

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->isAttached()Z

    move-result v4

    if-eqz v4, :cond_a

    iget-boolean v4, p0, Lcom/lge/app/floating/FloatingWindow;->mIsTitleInSeparateWindow:Z

    if-eqz v4, :cond_a

    .line 2765
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v4

    iget-object v5, p0, Lcom/lge/app/floating/FloatingWindow;->mTitleParamsBeforeHidden:Landroid/view/WindowManager$LayoutParams;

    invoke-virtual {p0, v4, v5}, Lcom/lge/app/floating/FloatingWindow;->updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    .line 2795
    :cond_a
    :goto_2
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->looseFocus()V

    goto/16 :goto_0

    .line 2770
    :cond_b
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->isAttached()Z

    move-result v6

    if-eqz v6, :cond_a

    .line 2771
    invoke-virtual {p0, v5}, Lcom/lge/app/floating/FloatingWindow;->setOverlay(Z)V

    .line 2772
    const/4 v5, 0x0

    invoke-virtual {p0, v5}, Lcom/lge/app/floating/FloatingWindow;->setOpacity(F)V

    .line 2773
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v5

    invoke-virtual {v5}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    check-cast v1, Landroid/view/WindowManager$LayoutParams;

    .line 2775
    .local v1, "params":Landroid/view/WindowManager$LayoutParams;
    new-instance v5, Landroid/view/WindowManager$LayoutParams;

    invoke-direct {v5}, Landroid/view/WindowManager$LayoutParams;-><init>()V

    iput-object v5, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameParamsBeforeHidden:Landroid/view/WindowManager$LayoutParams;

    .line 2776
    iget-object v5, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameParamsBeforeHidden:Landroid/view/WindowManager$LayoutParams;

    invoke-virtual {v5, v1}, Landroid/view/WindowManager$LayoutParams;->copyFrom(Landroid/view/WindowManager$LayoutParams;)I

    .line 2777
    iget v5, v1, Landroid/view/WindowManager$LayoutParams;->flags:I

    or-int/lit8 v5, v5, 0x10

    iput v5, v1, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 2778
    invoke-virtual {p0, v1}, Lcom/lge/app/floating/FloatingWindow;->setNotFocusableState(Landroid/view/WindowManager$LayoutParams;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v1

    .line 2780
    iget-object v5, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameView:Lcom/lge/app/floating/IFrameView;

    invoke-interface {v5, v4}, Lcom/lge/app/floating/IFrameView;->setAsFocusable(Z)V

    .line 2782
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v4

    invoke-virtual {p0, v4, v1}, Lcom/lge/app/floating/FloatingWindow;->updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    .line 2784
    iget-boolean v4, p0, Lcom/lge/app/floating/FloatingWindow;->mIsTitleInSeparateWindow:Z

    if-eqz v4, :cond_a

    .line 2785
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v4

    invoke-virtual {v4}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v3

    check-cast v3, Landroid/view/WindowManager$LayoutParams;

    .line 2787
    .restart local v3    # "titleParams":Landroid/view/WindowManager$LayoutParams;
    new-instance v4, Landroid/view/WindowManager$LayoutParams;

    invoke-direct {v4}, Landroid/view/WindowManager$LayoutParams;-><init>()V

    iput-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mTitleParamsBeforeHidden:Landroid/view/WindowManager$LayoutParams;

    .line 2788
    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mTitleParamsBeforeHidden:Landroid/view/WindowManager$LayoutParams;

    invoke-virtual {v4, v3}, Landroid/view/WindowManager$LayoutParams;->copyFrom(Landroid/view/WindowManager$LayoutParams;)I

    .line 2790
    iget v4, v3, Landroid/view/WindowManager$LayoutParams;->flags:I

    or-int/lit8 v4, v4, 0x10

    iput v4, v3, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 2791
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v4

    invoke-virtual {p0, v4, v3}, Lcom/lge/app/floating/FloatingWindow;->updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    goto :goto_2
.end method

.method public exitLowProfile()V
    .locals 8

    .prologue
    const/4 v3, 0x1

    const/high16 v7, 0x3f800000    # 1.0f

    const/4 v2, 0x0

    .line 2806
    iget-boolean v4, p0, Lcom/lge/app/floating/FloatingWindow;->mIsInLowProfile:Z

    if-eqz v4, :cond_2

    .line 2807
    sget-object v4, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "exit from low profile. mIsHidden="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-boolean v6, p0, Lcom/lge/app/floating/FloatingWindow;->mIsHidden:Z

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 2809
    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mLowProfileAnimator:Landroid/animation/ValueAnimator;

    if-eqz v4, :cond_0

    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mLowProfileAnimator:Landroid/animation/ValueAnimator;

    invoke-virtual {v4}, Landroid/animation/ValueAnimator;->isStarted()Z

    move-result v4

    if-eqz v4, :cond_0

    .line 2811
    sget-object v4, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v5, "exitLowProfile cancels started mLowProfileAnimator"

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 2812
    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mLowProfileAnimator:Landroid/animation/ValueAnimator;

    invoke-virtual {v4}, Landroid/animation/ValueAnimator;->cancel()V

    .line 2821
    :cond_0
    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    if-eqz v4, :cond_1

    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    iget-boolean v5, p0, Lcom/lge/app/floating/FloatingWindow;->mIsHidden:Z

    invoke-interface {v4, p0, v5}, Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;->onExitingLowProfileMode(Lcom/lge/app/floating/FloatingWindow;Z)Z

    move-result v4

    if-eqz v4, :cond_3

    :cond_1
    move v0, v3

    .line 2823
    .local v0, "proceed":Z
    :goto_0
    if-nez v0, :cond_4

    .line 2893
    .end local v0    # "proceed":Z
    :cond_2
    :goto_1
    return-void

    :cond_3
    move v0, v2

    .line 2821
    goto :goto_0

    .line 2826
    .restart local v0    # "proceed":Z
    :cond_4
    iget-boolean v4, p0, Lcom/lge/app/floating/FloatingWindow;->mIsHidden:Z

    if-nez v4, :cond_6

    .line 2827
    const/4 v4, 0x2

    new-array v4, v4, [F

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getOpacity()F

    move-result v5

    aput v5, v4, v2

    iget v5, p0, Lcom/lge/app/floating/FloatingWindow;->mAlphaSavedForLowProfile:F

    aput v5, v4, v3

    invoke-static {v4}, Landroid/animation/ValueAnimator;->ofFloat([F)Landroid/animation/ValueAnimator;

    move-result-object v3

    iput-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mLowProfileAnimator:Landroid/animation/ValueAnimator;

    .line 2830
    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mLowProfileAnimator:Landroid/animation/ValueAnimator;

    const-wide/16 v4, 0x3e8

    invoke-virtual {v3, v4, v5}, Landroid/animation/ValueAnimator;->setDuration(J)Landroid/animation/ValueAnimator;

    .line 2831
    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mLowProfileAnimator:Landroid/animation/ValueAnimator;

    new-instance v4, Lcom/lge/app/floating/FloatingWindow$5;

    invoke-direct {v4, p0}, Lcom/lge/app/floating/FloatingWindow$5;-><init>(Lcom/lge/app/floating/FloatingWindow;)V

    invoke-virtual {v3, v4}, Landroid/animation/ValueAnimator;->addListener(Landroid/animation/Animator$AnimatorListener;)V

    .line 2842
    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mLowProfileAnimator:Landroid/animation/ValueAnimator;

    new-instance v4, Lcom/lge/app/floating/FloatingWindow$6;

    invoke-direct {v4, p0}, Lcom/lge/app/floating/FloatingWindow$6;-><init>(Lcom/lge/app/floating/FloatingWindow;)V

    invoke-virtual {v3, v4}, Landroid/animation/ValueAnimator;->addUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    .line 2857
    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mLowProfileAnimator:Landroid/animation/ValueAnimator;

    invoke-virtual {v3}, Landroid/animation/ValueAnimator;->start()V

    .line 2881
    :goto_2
    iget-boolean v3, p0, Lcom/lge/app/floating/FloatingWindow;->mIsTitleInSeparateWindow:Z

    if-eqz v3, :cond_5

    .line 2882
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    check-cast v1, Landroid/view/WindowManager$LayoutParams;

    .line 2884
    .local v1, "titleParams":Landroid/view/WindowManager$LayoutParams;
    iget v3, v1, Landroid/view/WindowManager$LayoutParams;->flags:I

    and-int/lit8 v3, v3, -0x11

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 2885
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v3

    invoke-virtual {p0, v3, v1}, Lcom/lge/app/floating/FloatingWindow;->updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    .line 2887
    .end local v1    # "titleParams":Landroid/view/WindowManager$LayoutParams;
    :cond_5
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/lge/app/floating/FloatingWindow;->updateLayoutParamsInner(Lcom/lge/app/floating/FloatingWindow$LayoutParams;)V

    .line 2888
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->looseFocus()V

    .line 2889
    iput-boolean v2, p0, Lcom/lge/app/floating/FloatingWindow;->mIsHidden:Z

    .line 2890
    iput-boolean v2, p0, Lcom/lge/app/floating/FloatingWindow;->mIsInLowProfile:Z

    goto :goto_1

    .line 2859
    :cond_6
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->isAttached()Z

    move-result v3

    if-eqz v3, :cond_7

    .line 2860
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v3

    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameParamsBeforeHidden:Landroid/view/WindowManager$LayoutParams;

    invoke-virtual {p0, v3, v4}, Lcom/lge/app/floating/FloatingWindow;->updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    .line 2862
    iget-boolean v3, p0, Lcom/lge/app/floating/FloatingWindow;->mIsTitleInSeparateWindow:Z

    if-eqz v3, :cond_7

    .line 2863
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v3

    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mTitleParamsBeforeHidden:Landroid/view/WindowManager$LayoutParams;

    invoke-virtual {p0, v3, v4}, Lcom/lge/app/floating/FloatingWindow;->updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    .line 2866
    :cond_7
    iget v3, p0, Lcom/lge/app/floating/FloatingWindow;->mAlphaSavedForLowProfile:F

    cmpl-float v3, v3, v7

    if-ltz v3, :cond_8

    .line 2867
    sget-object v3, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v4, "hidden to opaque"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2868
    invoke-virtual {p0, v2}, Lcom/lge/app/floating/FloatingWindow;->setOverlay(Z)V

    .line 2869
    invoke-virtual {p0, v7}, Lcom/lge/app/floating/FloatingWindow;->setOpacity(F)V

    .line 2872
    iget-object v3, p0, Lcom/lge/app/floating/FloatingWindow;->mTitleView:Lcom/lge/app/floating/ITitleView;

    invoke-interface {v3, v2, v2}, Lcom/lge/app/floating/ITitleView;->activateOpacitySlider(ZZ)V

    goto :goto_2

    .line 2874
    :cond_8
    sget-object v3, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "hidden to mAlphaSavedForLowProfile = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget v5, p0, Lcom/lge/app/floating/FloatingWindow;->mAlphaSavedForLowProfile:F

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2876
    iget v3, p0, Lcom/lge/app/floating/FloatingWindow;->mAlphaSavedForLowProfile:F

    invoke-virtual {p0, v3}, Lcom/lge/app/floating/FloatingWindow;->setOpacity(F)V

    goto :goto_2
.end method

.method public findViewWithTag(Ljava/lang/Object;)Landroid/view/View;
    .locals 2
    .param p1, "tag"    # Ljava/lang/Object;

    .prologue
    .line 1341
    if-eqz p1, :cond_1

    const-string v1, "tag_seekbar"

    invoke-virtual {p1, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 1342
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mTitleView:Lcom/lge/app/floating/ITitleView;

    invoke-interface {v1}, Lcom/lge/app/floating/ITitleView;->getOpacitySlider()Landroid/widget/SeekBar;

    move-result-object v0

    .line 1351
    :cond_0
    :goto_0
    return-object v0

    .line 1347
    :cond_1
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    .line 1348
    .local v0, "v":Landroid/view/View;
    if-nez v0, :cond_0

    .line 1351
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    goto :goto_0
.end method

.method gainFocus()V
    .locals 4

    .prologue
    const/4 v3, 0x1

    .line 2336
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->isAttached()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 2337
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager$LayoutParams;

    .line 2340
    .local v0, "params":Landroid/view/WindowManager$LayoutParams;
    iget v1, v0, Landroid/view/WindowManager$LayoutParams;->flags:I

    and-int/lit8 v1, v1, 0x8

    if-eqz v1, :cond_0

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->isInOverlay()Z

    move-result v1

    if-nez v1, :cond_0

    .line 2342
    sget-object v1, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v2, "gaining focus"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 2343
    invoke-virtual {p0, v0}, Lcom/lge/app/floating/FloatingWindow;->setFocusableState(Landroid/view/WindowManager$LayoutParams;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    .line 2345
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameView:Lcom/lge/app/floating/IFrameView;

    invoke-interface {v1, v3}, Lcom/lge/app/floating/IFrameView;->setAsFocusable(Z)V

    .line 2346
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {p0, v1, v0}, Lcom/lge/app/floating/FloatingWindow;->updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    .line 2350
    :cond_0
    invoke-virtual {p0, v3}, Lcom/lge/app/floating/FloatingWindow;->updateTitleBackground(Z)V

    .line 2352
    .end local v0    # "params":Landroid/view/WindowManager$LayoutParams;
    :cond_1
    return-void
.end method

.method getActivity()Lcom/lge/app/floating/FloatableActivity;
    .locals 1

    .prologue
    .line 1247
    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    return-object v0
.end method

.method getBounceAnimator()Landroid/animation/ValueAnimator;
    .locals 3

    .prologue
    .line 3155
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mBounceAnimator:Landroid/animation/ValueAnimator;

    if-nez v1, :cond_0

    .line 3156
    sget-object v1, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v2, "(mBounceAnimator == null) : create Bounce Animator"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 3157
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v1

    iget v1, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v2

    iget v2, v2, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    invoke-virtual {p0, v1, v2}, Lcom/lge/app/floating/FloatingWindow;->calculateCorrectPosition(II)Landroid/graphics/Rect;

    move-result-object v0

    .line 3159
    .local v0, "r":Landroid/graphics/Rect;
    invoke-direct {p0, v0}, Lcom/lge/app/floating/FloatingWindow;->createBounceAnimator(Landroid/graphics/Rect;)V

    .line 3161
    .end local v0    # "r":Landroid/graphics/Rect;
    :cond_0
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mBounceAnimator:Landroid/animation/ValueAnimator;

    return-object v1
.end method

.method public getContentView()Landroid/view/View;
    .locals 1

    .prologue
    .line 1525
    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameView:Lcom/lge/app/floating/IFrameView;

    invoke-interface {v0}, Lcom/lge/app/floating/IFrameView;->getContentView()Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method getDockDirection()I
    .locals 1

    .prologue
    .line 3328
    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mDockWindow:Lcom/lge/app/floating/FloatingDockWindow;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mDockWindow:Lcom/lge/app/floating/FloatingDockWindow;

    invoke-virtual {v0}, Lcom/lge/app/floating/FloatingDockWindow;->getDockDirection()I

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public getDockState()I
    .locals 4

    .prologue
    .line 3319
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mDockWindow:Lcom/lge/app/floating/FloatingDockWindow;

    if-nez v1, :cond_0

    .line 3320
    sget-object v1, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v2, "mDockWindow == null"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 3322
    :cond_0
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mDockWindow:Lcom/lge/app/floating/FloatingDockWindow;

    invoke-virtual {v1}, Lcom/lge/app/floating/FloatingDockWindow;->getDockState()I

    move-result v0

    .line 3323
    .local v0, "state":I
    sget-object v1, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getDockState : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 3324
    return v0
.end method

.method getDockViewBitmap()Landroid/graphics/Bitmap;
    .locals 1

    .prologue
    .line 2946
    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mDockViewBitmap:Landroid/graphics/Bitmap;

    return-object v0
.end method

.method public getDockWindow()Lcom/lge/app/floating/FloatingDockWindow;
    .locals 1

    .prologue
    .line 1316
    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mDockWindow:Lcom/lge/app/floating/FloatingDockWindow;

    return-object v0
.end method

.method public getFloatingFrameView()Landroid/view/View;
    .locals 1

    .prologue
    .line 1308
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public getFloatingTitleView()Landroid/view/View;
    .locals 1

    .prologue
    .line 1297
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public getFrameView()Landroid/view/View;
    .locals 1

    .prologue
    .line 1287
    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameView:Lcom/lge/app/floating/IFrameView;

    invoke-interface {v0}, Lcom/lge/app/floating/IFrameView;->getRealView()Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public getFrameViewInterface()Lcom/lge/app/floating/IFrameView;
    .locals 1

    .prologue
    .line 1276
    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameView:Lcom/lge/app/floating/IFrameView;

    return-object v0
.end method

.method getFrameWindowH()I
    .locals 1

    .prologue
    .line 3486
    iget v0, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowH:I

    return v0
.end method

.method getFrameWindowW()I
    .locals 1

    .prologue
    .line 3482
    iget v0, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowW:I

    return v0
.end method

.method getFrameWindowX()I
    .locals 1

    .prologue
    .line 3474
    iget v0, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowX:I

    return v0
.end method

.method getFrameWindowY()I
    .locals 1

    .prologue
    .line 3478
    iget v0, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowY:I

    return v0
.end method

.method getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;
    .locals 1

    .prologue
    .line 3460
    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mLayout:Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    return-object v0
.end method

.method public getLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;
    .locals 2

    .prologue
    .line 1366
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->clone()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v0

    .line 1369
    .local v0, "lp":Lcom/lge/app/floating/FloatingWindow$LayoutParams;
    if-eqz v0, :cond_0

    .line 1372
    .end local v0    # "lp":Lcom/lge/app/floating/FloatingWindow$LayoutParams;
    :goto_0
    return-object v0

    .restart local v0    # "lp":Lcom/lge/app/floating/FloatingWindow$LayoutParams;
    :cond_0
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v0

    goto :goto_0
.end method

.method public getOpacity()F
    .locals 2

    .prologue
    .line 2265
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->isAttached()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 2266
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager$LayoutParams;

    .line 2268
    .local v0, "params":Landroid/view/WindowManager$LayoutParams;
    iget v1, v0, Landroid/view/WindowManager$LayoutParams;->alpha:F

    .line 2270
    .end local v0    # "params":Landroid/view/WindowManager$LayoutParams;
    :goto_0
    return v1

    :cond_0
    const/high16 v1, 0x3f800000    # 1.0f

    goto :goto_0
.end method

.method public getRealWindowManager()Landroid/view/WindowManager;
    .locals 1

    .prologue
    .line 3506
    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mWindowManager:Landroid/view/WindowManager;

    return-object v0
.end method

.method public getTitleView()Landroid/view/View;
    .locals 1

    .prologue
    .line 1267
    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mTitleView:Lcom/lge/app/floating/ITitleView;

    invoke-interface {v0}, Lcom/lge/app/floating/ITitleView;->getRealView()Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public getTitleViewInterface()Lcom/lge/app/floating/ITitleView;
    .locals 1

    .prologue
    .line 1256
    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mTitleView:Lcom/lge/app/floating/ITitleView;

    return-object v0
.end method

.method getTitleWindowH()I
    .locals 1

    .prologue
    .line 3502
    iget v0, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowH:I

    return v0
.end method

.method getTitleWindowW()I
    .locals 1

    .prologue
    .line 3498
    iget v0, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowW:I

    return v0
.end method

.method getTitleWindowX()I
    .locals 1

    .prologue
    .line 3490
    iget v0, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowX:I

    return v0
.end method

.method getTitleWindowY()I
    .locals 1

    .prologue
    .line 3494
    iget v0, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowY:I

    return v0
.end method

.method public getUserOpacity()F
    .locals 1

    .prologue
    .line 2282
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->isInLowProfile()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 2283
    iget v0, p0, Lcom/lge/app/floating/FloatingWindow;->mAlphaSavedForLowProfile:F

    .line 2285
    :goto_0
    return v0

    :cond_0
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getOpacity()F

    move-result v0

    goto :goto_0
.end method

.method public getWindowName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 1326
    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mWindowName:Ljava/lang/String;

    return-object v0
.end method

.method handleImeVisibilityChanged(Z)V
    .locals 6
    .param p1, "visible"    # Z

    .prologue
    const/4 v5, 0x0

    const/4 v4, 0x1

    .line 2413
    sget-object v1, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "handleImeVisibilityChanged : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 2414
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->isWindowDocked()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 2415
    sget-object v1, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string/jumbo v2, "window is docked, so do not perform handleImeVisibilityChanged"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2469
    :goto_0
    return-void

    .line 2422
    :cond_0
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager$LayoutParams;

    .line 2424
    .local v0, "params":Landroid/view/WindowManager$LayoutParams;
    if-eqz v0, :cond_1

    iget v1, v0, Landroid/view/WindowManager$LayoutParams;->flags:I

    and-int/lit8 v1, v1, 0x8

    if-eqz v1, :cond_1

    if-eqz p1, :cond_1

    .line 2427
    sget-object v1, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v2, "Window is not focusable... Do not handleImeVisibilityChanged to visible."

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 2433
    :cond_1
    if-nez p1, :cond_3

    .line 2434
    iget-boolean v1, p0, Lcom/lge/app/floating/FloatingWindow;->mImeShouldBeReShown:Z

    if-eqz v1, :cond_2

    .line 2442
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mHandler:Landroid/os/Handler;

    new-instance v2, Lcom/lge/app/floating/FloatingWindow$2;

    invoke-direct {v2, p0}, Lcom/lge/app/floating/FloatingWindow$2;-><init>(Lcom/lge/app/floating/FloatingWindow;)V

    const-wide/16 v4, 0x32

    invoke-virtual {v1, v2, v4, v5}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_0

    .line 2453
    :cond_2
    invoke-virtual {p0, v5, v4}, Lcom/lge/app/floating/FloatingWindow;->setLayoutLimit(ZZ)V

    .line 2454
    iput-boolean v5, p0, Lcom/lge/app/floating/FloatingWindow;->mIsImeVisible:Z

    goto :goto_0

    .line 2460
    :cond_3
    iput-boolean v4, p0, Lcom/lge/app/floating/FloatingWindow;->mIsImeVisible:Z

    .line 2463
    iget-boolean v1, p0, Lcom/lge/app/floating/FloatingWindow;->mImeShouldBeReShown:Z

    if-eqz v1, :cond_4

    .line 2464
    iput-boolean v5, p0, Lcom/lge/app/floating/FloatingWindow;->mImeShouldBeReShown:Z

    .line 2466
    :cond_4
    invoke-virtual {p0, v4, v4}, Lcom/lge/app/floating/FloatingWindow;->setLayoutLimit(ZZ)V

    goto :goto_0
.end method

.method hideIme()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 2994
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v0

    if-nez v0, :cond_1

    .line 3003
    :cond_0
    :goto_0
    return-void

    .line 2997
    :cond_1
    sget-object v0, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "hideIme - dontUseIme : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v2

    iget-boolean v2, v2, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->dontUseIme:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 2998
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v0

    iget-boolean v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->dontUseIme:Z

    if-nez v0, :cond_0

    .line 2999
    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mInputMethodManager:Landroid/view/inputmethod/InputMethodManager;

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getWindowToken()Landroid/os/IBinder;

    move-result-object v1

    invoke-virtual {v0, v1, v3}, Landroid/view/inputmethod/InputMethodManager;->hideSoftInputFromWindow(Landroid/os/IBinder;I)Z

    .line 3001
    iput-boolean v3, p0, Lcom/lge/app/floating/FloatingWindow;->mIsImeVisible:Z

    goto :goto_0
.end method

.method initFloatingDockWindow()V
    .locals 3

    .prologue
    .line 1695
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v1}, Lcom/lge/app/floating/FloatableActivity;->getFloatingWindowManager()Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/app/floating/FloatingWindowManager;->getServiceContext()Landroid/content/Context;

    move-result-object v0

    .line 1696
    .local v0, "c":Landroid/content/Context;
    if-nez v0, :cond_0

    .line 1697
    sget-object v1, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v2, "can\'t find service context, use application context instead"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1699
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v1}, Lcom/lge/app/floating/FloatableActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 1701
    :cond_0
    new-instance v1, Lcom/lge/app/floating/FloatingDockWindow;

    invoke-direct {v1, v0, p0}, Lcom/lge/app/floating/FloatingDockWindow;-><init>(Landroid/content/Context;Lcom/lge/app/floating/FloatingWindow;)V

    iput-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mDockWindow:Lcom/lge/app/floating/FloatingDockWindow;

    .line 1702
    return-void
.end method

.method isAttached()Z
    .locals 1

    .prologue
    .line 3452
    iget-boolean v0, p0, Lcom/lge/app/floating/FloatingWindow;->mIsAttached:Z

    return v0
.end method

.method isInCorrectPositionAndSize(Landroid/graphics/Rect;)Z
    .locals 2
    .param p1, "rect"    # Landroid/graphics/Rect;

    .prologue
    .line 3013
    iget v0, p1, Landroid/graphics/Rect;->top:I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v1

    iget v1, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    if-ne v0, v1, :cond_0

    invoke-virtual {p1}, Landroid/graphics/Rect;->height()I

    move-result v0

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v1

    iget v1, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isInLowProfile()Z
    .locals 1

    .prologue
    .line 2901
    iget-boolean v0, p0, Lcom/lge/app/floating/FloatingWindow;->mIsInLowProfile:Z

    return v0
.end method

.method public isInOverlay()Z
    .locals 1

    .prologue
    .line 2228
    iget-boolean v0, p0, Lcom/lge/app/floating/FloatingWindow;->mIsInOverlayMode:Z

    return v0
.end method

.method isPortrait()Z
    .locals 1

    .prologue
    .line 2404
    iget-boolean v0, p0, Lcom/lge/app/floating/FloatingWindow;->mIsPortrait:Z

    return v0
.end method

.method public isWindowDocked()Z
    .locals 4

    .prologue
    .line 3300
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mDockWindow:Lcom/lge/app/floating/FloatingDockWindow;

    if-nez v1, :cond_0

    .line 3301
    sget-object v1, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v2, "mDockWindow == null"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 3304
    :cond_0
    iget-boolean v1, p0, Lcom/lge/app/floating/FloatingWindow;->mNeedToDockOnStarting:Z

    if-nez v1, :cond_1

    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mDockWindow:Lcom/lge/app/floating/FloatingDockWindow;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mDockWindow:Lcom/lge/app/floating/FloatingDockWindow;

    invoke-virtual {v1}, Lcom/lge/app/floating/FloatingDockWindow;->getDockState()I

    move-result v1

    const/4 v2, 0x2

    if-ne v1, v2, :cond_2

    :cond_1
    const/4 v0, 0x1

    .line 3305
    .local v0, "isDocked":Z
    :goto_0
    sget-object v1, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "isWindowDocked (using current state) : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 3306
    return v0

    .line 3304
    .end local v0    # "isDocked":Z
    :cond_2
    const/4 v0, 0x0

    goto :goto_0
.end method

.method looseFocus()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    .line 2293
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->isAttached()Z

    move-result v2

    if-eqz v2, :cond_4

    .line 2294
    sget-object v2, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v3, "loosing focus"

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 2296
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager$LayoutParams;

    .line 2298
    .local v0, "params":Landroid/view/WindowManager$LayoutParams;
    iget v2, v0, Landroid/view/WindowManager$LayoutParams;->flags:I

    and-int/lit8 v2, v2, 0x8

    if-nez v2, :cond_0

    .line 2299
    sget-object v2, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v3, "become not focusable"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2300
    invoke-virtual {p0, v0}, Lcom/lge/app/floating/FloatingWindow;->setNotFocusableState(Landroid/view/WindowManager$LayoutParams;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    .line 2302
    iget-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameView:Lcom/lge/app/floating/IFrameView;

    invoke-interface {v2, v5}, Lcom/lge/app/floating/IFrameView;->setAsFocusable(Z)V

    .line 2304
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v2

    invoke-virtual {p0, v2, v0}, Lcom/lge/app/floating/FloatingWindow;->updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    .line 2307
    :cond_0
    iget-boolean v2, p0, Lcom/lge/app/floating/FloatingWindow;->mIsImeVisible:Z

    if-eqz v2, :cond_1

    .line 2308
    sget-object v2, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v3, "hideSoftInputFromWindow in loosing focus"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2309
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->hideIme()V

    .line 2310
    iget-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mInputMethodManager:Landroid/view/inputmethod/InputMethodManager;

    invoke-static {v2}, Lcom/lge/app/floating/FloatingFunctionReflect;->finishInputLocked(Landroid/view/inputmethod/InputMethodManager;)V

    .line 2311
    iput-boolean v5, p0, Lcom/lge/app/floating/FloatingWindow;->mIsImeVisible:Z

    .line 2314
    :cond_1
    iget-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameView:Lcom/lge/app/floating/IFrameView;

    invoke-interface {v2}, Lcom/lge/app/floating/IFrameView;->findFocus()Landroid/view/View;

    move-result-object v1

    .line 2315
    .local v1, "view":Landroid/view/View;
    iget-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mInputMethodManager:Landroid/view/inputmethod/InputMethodManager;

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mInputMethodManager:Landroid/view/inputmethod/InputMethodManager;

    invoke-virtual {v2, v1}, Landroid/view/inputmethod/InputMethodManager;->isActive(Landroid/view/View;)Z

    move-result v2

    if-eqz v2, :cond_2

    instance-of v2, v1, Landroid/widget/EditText;

    if-eqz v2, :cond_2

    .line 2318
    sget-object v2, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "clearComposingText: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object v2, v1

    .line 2319
    check-cast v2, Landroid/widget/EditText;

    invoke-virtual {v2}, Landroid/widget/EditText;->clearComposingText()V

    .line 2321
    :cond_2
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v2

    iget-boolean v2, v2, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->dontUseIme:Z

    if-eqz v2, :cond_3

    instance-of v2, v1, Landroid/widget/EditText;

    if-eqz v2, :cond_3

    .line 2322
    sget-object v2, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "clearFocus: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 2323
    invoke-virtual {v1}, Landroid/view/View;->clearFocus()V

    .line 2326
    :cond_3
    invoke-virtual {p0, v5}, Lcom/lge/app/floating/FloatingWindow;->updateTitleBackground(Z)V

    .line 2328
    .end local v0    # "params":Landroid/view/WindowManager$LayoutParams;
    .end local v1    # "view":Landroid/view/View;
    :cond_4
    return-void
.end method

.method public move(II)V
    .locals 3
    .param p1, "x"    # I
    .param p2, "y"    # I

    .prologue
    .line 1919
    sget-object v0, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "moving to ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ") is requested by app"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1920
    invoke-virtual {p0, p1, p2}, Lcom/lge/app/floating/FloatingWindow;->moveInner(II)V

    .line 1921
    return-void
.end method

.method moveInner(II)V
    .locals 7
    .param p1, "x"    # I
    .param p2, "y"    # I

    .prologue
    const/4 v6, 0x0

    const/4 v5, 0x0

    .line 1924
    sget-object v2, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "moveInner to ("

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ") is requested"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1925
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v2

    iput p1, v2, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    .line 1926
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v2

    iput p2, v2, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    .line 1927
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->updateRealPositionAndSize()V

    .line 1928
    iput-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedFrameParams:Landroid/view/WindowManager$LayoutParams;

    .line 1930
    iput-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedTitleParams:Landroid/view/WindowManager$LayoutParams;

    .line 1931
    iput-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedLayoutParams:Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    .line 1932
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->isAttached()Z

    move-result v2

    if-eqz v2, :cond_3

    .line 1936
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v2

    iget-boolean v2, v2, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->dontUseIme:Z

    if-eqz v2, :cond_6

    .line 1937
    invoke-virtual {p0, v5, v5}, Lcom/lge/app/floating/FloatingWindow;->setLayoutLimit(ZZ)V

    .line 1943
    :goto_0
    iget-boolean v2, p0, Lcom/lge/app/floating/FloatingWindow;->mIsTitleInSeparateWindow:Z

    if-eqz v2, :cond_1

    .line 1944
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    check-cast v1, Landroid/view/WindowManager$LayoutParams;

    .line 1946
    .local v1, "titleParams":Landroid/view/WindowManager$LayoutParams;
    iget v2, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    iget v3, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowX:I

    if-ne v2, v3, :cond_0

    iget v2, v1, Landroid/view/WindowManager$LayoutParams;->y:I

    iget v3, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowY:I

    if-eq v2, v3, :cond_1

    .line 1948
    :cond_0
    iget v2, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowX:I

    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 1949
    iget v2, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowY:I

    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 1950
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v2

    invoke-virtual {p0, v2, v1}, Lcom/lge/app/floating/FloatingWindow;->updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    .line 1953
    .end local v1    # "titleParams":Landroid/view/WindowManager$LayoutParams;
    :cond_1
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager$LayoutParams;

    .line 1955
    .local v0, "params":Landroid/view/WindowManager$LayoutParams;
    iget v2, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    iget v3, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowX:I

    if-ne v2, v3, :cond_2

    iget v2, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    iget v3, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowY:I

    if-eq v2, v3, :cond_3

    .line 1956
    :cond_2
    iget v2, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowX:I

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 1957
    iget v2, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowY:I

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 1958
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v2

    invoke-virtual {p0, v2, v0}, Lcom/lge/app/floating/FloatingWindow;->updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    .line 1961
    .end local v0    # "params":Landroid/view/WindowManager$LayoutParams;
    :cond_3
    iget-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mTitleParamsBeforeHidden:Landroid/view/WindowManager$LayoutParams;

    if-eqz v2, :cond_4

    .line 1962
    iget-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mTitleParamsBeforeHidden:Landroid/view/WindowManager$LayoutParams;

    iget v3, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowX:I

    iput v3, v2, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 1963
    iget-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mTitleParamsBeforeHidden:Landroid/view/WindowManager$LayoutParams;

    iget v3, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowY:I

    iput v3, v2, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 1965
    :cond_4
    iget-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameParamsBeforeHidden:Landroid/view/WindowManager$LayoutParams;

    if-eqz v2, :cond_5

    .line 1966
    iget-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameParamsBeforeHidden:Landroid/view/WindowManager$LayoutParams;

    iget v3, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowX:I

    iput v3, v2, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 1967
    iget-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameParamsBeforeHidden:Landroid/view/WindowManager$LayoutParams;

    iget v3, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowY:I

    iput v3, v2, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 1969
    :cond_5
    return-void

    .line 1940
    :cond_6
    const/4 v2, 0x1

    invoke-virtual {p0, v5, v2}, Lcom/lge/app/floating/FloatingWindow;->setLayoutLimit(ZZ)V

    goto :goto_0
.end method

.method moveToTop()V
    .locals 7

    .prologue
    const/4 v6, 0x0

    .line 2359
    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mFloatingWindowManager:Lcom/lge/app/floating/FloatingWindowManager;

    invoke-virtual {v4, p0}, Lcom/lge/app/floating/FloatingWindowManager;->isTopWindow(Lcom/lge/app/floating/FloatingWindow;)Z

    move-result v4

    if-nez v4, :cond_1

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->isAttached()Z

    move-result v4

    if-eqz v4, :cond_1

    .line 2360
    sget-object v4, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v5, "move to top"

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 2362
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v4

    invoke-virtual {v4}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    check-cast v1, Landroid/view/WindowManager$LayoutParams;

    .line 2365
    .local v1, "params":Landroid/view/WindowManager$LayoutParams;
    iget-object v4, v1, Landroid/view/WindowManager$LayoutParams;->token:Landroid/os/IBinder;

    invoke-static {v4}, Lcom/lge/app/floating/FloatingFunctionReflect;->moveWindowTokenToTopEx(Landroid/os/IBinder;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 2366
    sget-object v4, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v5, "sMoveWindowTokenToTopMethodEx called!"

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 2369
    new-instance v3, Landroid/view/View;

    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-direct {v3, v4}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 2370
    .local v3, "v":Landroid/view/View;
    new-instance v0, Landroid/view/WindowManager$LayoutParams;

    invoke-direct {v0}, Landroid/view/WindowManager$LayoutParams;-><init>()V

    .line 2371
    .local v0, "p":Landroid/view/WindowManager$LayoutParams;
    invoke-virtual {v0, v1}, Landroid/view/WindowManager$LayoutParams;->copyFrom(Landroid/view/WindowManager$LayoutParams;)I

    .line 2372
    iput v6, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 2373
    iput v6, v0, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 2374
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getRealWindowManager()Landroid/view/WindowManager;

    move-result-object v4

    invoke-interface {v4, v3, v0}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 2375
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getRealWindowManager()Landroid/view/WindowManager;

    move-result-object v4

    invoke-interface {v4, v3}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V

    .line 2395
    .end local v0    # "p":Landroid/view/WindowManager$LayoutParams;
    .end local v3    # "v":Landroid/view/View;
    :cond_0
    :goto_0
    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mFloatingWindowManager:Lcom/lge/app/floating/FloatingWindowManager;

    invoke-virtual {v4, p0}, Lcom/lge/app/floating/FloatingWindowManager;->notifyNewTopWindow(Lcom/lge/app/floating/FloatingWindow;)V

    .line 2397
    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    if-eqz v4, :cond_1

    .line 2398
    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    invoke-interface {v4, p0}, Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;->onMoveToTop(Lcom/lge/app/floating/FloatingWindow;)V

    .line 2401
    .end local v1    # "params":Landroid/view/WindowManager$LayoutParams;
    :cond_1
    return-void

    .line 2380
    .restart local v1    # "params":Landroid/view/WindowManager$LayoutParams;
    :cond_2
    sget-object v4, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v5, "no Match"

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 2381
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getRealWindowManager()Landroid/view/WindowManager;

    move-result-object v4

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v5

    invoke-interface {v4, v5}, Landroid/view/WindowManager;->removeViewImmediate(Landroid/view/View;)V

    .line 2382
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getRealWindowManager()Landroid/view/WindowManager;

    move-result-object v4

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v5

    invoke-interface {v4, v5, v1}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 2384
    iget-boolean v4, p0, Lcom/lge/app/floating/FloatingWindow;->mIsTitleInSeparateWindow:Z

    if-eqz v4, :cond_0

    .line 2385
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v4

    invoke-virtual {v4}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v2

    check-cast v2, Landroid/view/WindowManager$LayoutParams;

    .line 2387
    .local v2, "titleParams":Landroid/view/WindowManager$LayoutParams;
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getRealWindowManager()Landroid/view/WindowManager;

    move-result-object v4

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v5

    invoke-interface {v4, v5}, Landroid/view/WindowManager;->removeViewImmediate(Landroid/view/View;)V

    .line 2388
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getRealWindowManager()Landroid/view/WindowManager;

    move-result-object v4

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v5

    invoke-interface {v4, v5, v2}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_0
.end method

.method onAttachedToWindowFrameView()V
    .locals 1

    .prologue
    .line 1877
    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mFloatingWindowManager:Lcom/lge/app/floating/FloatingWindowManager;

    invoke-virtual {v0}, Lcom/lge/app/floating/FloatingWindowManager;->removeDummyWindow()V

    .line 1879
    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mFloatingWindowManager:Lcom/lge/app/floating/FloatingWindowManager;

    invoke-virtual {v0}, Lcom/lge/app/floating/FloatingWindowManager;->handleLowProfileConf()V

    .line 1880
    return-void
.end method

.method onDocked()V
    .locals 2

    .prologue
    .line 3310
    sget-object v0, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v1, "onDocked"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 3311
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/app/floating/FloatingWindow;->mNeedToDockOnStarting:Z

    .line 3312
    return-void
.end method

.method public releaseDock(Ljava/lang/String;)V
    .locals 1
    .param p1, "activityName"    # Ljava/lang/String;

    .prologue
    .line 2909
    const/4 v0, 0x1

    invoke-virtual {p0, p1, v0}, Lcom/lge/app/floating/FloatingWindow;->releaseDockInner(Ljava/lang/String;Z)V

    .line 2910
    return-void
.end method

.method releaseDockInner(Ljava/lang/String;Z)V
    .locals 3
    .param p1, "activityName"    # Ljava/lang/String;
    .param p2, "startedAsFloating"    # Z

    .prologue
    .line 2913
    sget-object v0, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "releaseDock : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " startedAsFloating : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 2914
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->isWindowDocked()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 2915
    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mDockWindow:Lcom/lge/app/floating/FloatingDockWindow;

    invoke-virtual {v0, p2}, Lcom/lge/app/floating/FloatingDockWindow;->requestUndock(Z)V

    .line 2930
    :cond_0
    return-void
.end method

.method requestFocusAndShowKeyboard(Landroid/view/View;)V
    .locals 5
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 3251
    if-eqz p1, :cond_0

    instance-of v2, p1, Landroid/widget/TextView;

    if-eqz v2, :cond_0

    invoke-virtual {p1}, Landroid/view/View;->isEnabled()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v2

    iget-boolean v2, v2, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->dontUseIme:Z

    if-nez v2, :cond_0

    iget-boolean v2, p0, Lcom/lge/app/floating/FloatingWindow;->mIsInOverlayMode:Z

    if-eqz v2, :cond_1

    .line 3292
    :cond_0
    :goto_0
    return-void

    .line 3255
    :cond_1
    sget-object v2, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "requestFocusAndShowKeyboard. v="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 3256
    invoke-virtual {p1}, Landroid/view/View;->invalidate()V

    .line 3257
    invoke-virtual {p1}, Landroid/view/View;->isFocused()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 3258
    sget-object v2, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v3, "show soft input by request"

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 3259
    iget-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mHandler:Landroid/os/Handler;

    new-instance v3, Lcom/lge/app/floating/FloatingWindow$7;

    invoke-direct {v3, p0, p1}, Lcom/lge/app/floating/FloatingWindow$7;-><init>(Lcom/lge/app/floating/FloatingWindow;Landroid/view/View;)V

    invoke-virtual {v2, v3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_0

    .line 3267
    :cond_2
    invoke-virtual {p1}, Landroid/view/View;->getOnFocusChangeListener()Landroid/view/View$OnFocusChangeListener;

    move-result-object v0

    .line 3269
    .local v0, "oldListener":Landroid/view/View$OnFocusChangeListener;
    new-instance v2, Lcom/lge/app/floating/FloatingWindow$8;

    invoke-direct {v2, p0, v0}, Lcom/lge/app/floating/FloatingWindow$8;-><init>(Lcom/lge/app/floating/FloatingWindow;Landroid/view/View$OnFocusChangeListener;)V

    invoke-virtual {p1, v2}, Landroid/view/View;->setOnFocusChangeListener(Landroid/view/View$OnFocusChangeListener;)V

    .line 3287
    invoke-virtual {p1}, Landroid/view/View;->requestFocus()Z

    move-result v1

    .line 3288
    .local v1, "requestFocusResult":Z
    if-nez v1, :cond_0

    .line 3289
    invoke-virtual {p1, v0}, Landroid/view/View;->setOnFocusChangeListener(Landroid/view/View$OnFocusChangeListener;)V

    goto :goto_0
.end method

.method public resize(II)V
    .locals 2
    .param p1, "wDiff"    # I
    .param p2, "hDiff"    # I

    .prologue
    .line 1996
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v0

    iget v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    add-int/2addr v0, p1

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v1

    iget v1, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    add-int/2addr v1, p2

    invoke-virtual {p0, v0, v1}, Lcom/lge/app/floating/FloatingWindow;->setSize(II)V

    .line 1997
    return-void
.end method

.method runVibrate()V
    .locals 3

    .prologue
    .line 3445
    sget-object v1, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v2, "Run vibrate"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 3446
    iget-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    const v2, 0x7f080009

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v0

    .line 3448
    .local v0, "vibrateTime":I
    const-string v1, "com.lge.app.floating.ExtraService.VIBRATE"

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-direct {p0, v1, v2}, Lcom/lge/app/floating/FloatingWindow;->runExtraService(Ljava/lang/String;Ljava/lang/Object;)V

    .line 3449
    return-void
.end method

.method setAttached(Z)V
    .locals 0
    .param p1, "mIsAttached"    # Z

    .prologue
    .line 3456
    iput-boolean p1, p0, Lcom/lge/app/floating/FloatingWindow;->mIsAttached:Z

    .line 3457
    return-void
.end method

.method public setContentView(Landroid/view/View;)V
    .locals 1
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 1508
    if-eqz p1, :cond_0

    .line 1509
    invoke-static {p1}, Lcom/lge/app/floating/FloatingWindow;->setSurfaceViewBackgroundAsTransparentRecursively(Landroid/view/View;)V

    .line 1512
    :cond_0
    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameView:Lcom/lge/app/floating/IFrameView;

    invoke-interface {v0, p1}, Lcom/lge/app/floating/IFrameView;->setContentView(Landroid/view/View;)V

    .line 1513
    iget v0, p0, Lcom/lge/app/floating/FloatingWindow;->mAlpha:F

    invoke-virtual {p0, v0}, Lcom/lge/app/floating/FloatingWindow;->setOpacity(F)V

    .line 1514
    return-void
.end method

.method public setDockViewBitmap(Landroid/graphics/Bitmap;)V
    .locals 2
    .param p1, "dockViewBitmap"    # Landroid/graphics/Bitmap;

    .prologue
    .line 2937
    if-nez p1, :cond_0

    .line 2938
    sget-object v0, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v1, "can\'t set null bitmap for dockview"

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 2943
    :goto_0
    return-void

    .line 2941
    :cond_0
    sget-object v0, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v1, "set custom bitmap for dockview"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 2942
    iput-object p1, p0, Lcom/lge/app/floating/FloatingWindow;->mDockViewBitmap:Landroid/graphics/Bitmap;

    goto :goto_0
.end method

.method setFocusableState(Landroid/view/WindowManager$LayoutParams;)Landroid/view/WindowManager$LayoutParams;
    .locals 2
    .param p1, "params"    # Landroid/view/WindowManager$LayoutParams;

    .prologue
    .line 1709
    iget v0, p1, Landroid/view/WindowManager$LayoutParams;->flags:I

    and-int/lit8 v0, v0, -0x9

    iput v0, p1, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 1715
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v0

    iget-boolean v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->dontUseIme:Z

    if-eqz v0, :cond_0

    .line 1716
    iget v0, p1, Landroid/view/WindowManager$LayoutParams;->flags:I

    const/high16 v1, 0x20000

    or-int/2addr v0, v1

    iput v0, p1, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 1724
    :goto_0
    return-object p1

    .line 1718
    :cond_0
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v0

    iget-boolean v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->overIme:Z

    if-eqz v0, :cond_1

    .line 1719
    sget-object v0, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v1, "UseIme && OverIme do not allowed."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 1721
    :cond_1
    iget v0, p1, Landroid/view/WindowManager$LayoutParams;->flags:I

    const v1, -0x20001

    and-int/2addr v0, v1

    iput v0, p1, Landroid/view/WindowManager$LayoutParams;->flags:I

    goto :goto_0
.end method

.method public setLayoutLimit(Z)V
    .locals 1
    .param p1, "limit"    # Z

    .prologue
    .line 2477
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/lge/app/floating/FloatingWindow;->setLayoutLimit(ZZ)V

    .line 2478
    return-void
.end method

.method public setLayoutLimit(ZZ)V
    .locals 9
    .param p1, "limit"    # Z
    .param p2, "requiresIme"    # Z

    .prologue
    .line 2496
    iget-boolean v6, p0, Lcom/lge/app/floating/FloatingWindow;->mLayoutLimit:Z

    if-ne v6, p1, :cond_1

    .line 2642
    :cond_0
    :goto_0
    return-void

    .line 2499
    :cond_1
    sget-object v6, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "set layout limit="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ", requiresIme="

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 2501
    iput-boolean p1, p0, Lcom/lge/app/floating/FloatingWindow;->mLayoutLimit:Z

    .line 2503
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->isAttached()Z

    move-result v6

    if-eqz v6, :cond_0

    .line 2504
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v6

    invoke-virtual {v6}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v3

    check-cast v3, Landroid/view/WindowManager$LayoutParams;

    .line 2506
    .local v3, "params":Landroid/view/WindowManager$LayoutParams;
    if-eqz p1, :cond_7

    .line 2508
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v6

    invoke-virtual {v6}, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->clone()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v6

    iput-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedLayoutParams:Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    .line 2509
    new-instance v6, Landroid/view/WindowManager$LayoutParams;

    invoke-direct {v6}, Landroid/view/WindowManager$LayoutParams;-><init>()V

    iput-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedFrameParams:Landroid/view/WindowManager$LayoutParams;

    .line 2510
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedFrameParams:Landroid/view/WindowManager$LayoutParams;

    invoke-virtual {v6, v3}, Landroid/view/WindowManager$LayoutParams;->copyFrom(Landroid/view/WindowManager$LayoutParams;)I

    .line 2513
    iget v6, v3, Landroid/view/WindowManager$LayoutParams;->flags:I

    and-int/lit16 v6, v6, -0x201

    iput v6, v3, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 2516
    if-eqz p2, :cond_2

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v6

    iget-boolean v6, v6, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->dontUseIme:Z

    if-nez v6, :cond_2

    .line 2517
    invoke-virtual {p0, v3}, Lcom/lge/app/floating/FloatingWindow;->setFocusableState(Landroid/view/WindowManager$LayoutParams;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v3

    .line 2519
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameView:Lcom/lge/app/floating/IFrameView;

    const/4 v7, 0x1

    invoke-interface {v6, v7}, Lcom/lge/app/floating/IFrameView;->setAsFocusable(Z)V

    .line 2521
    :cond_2
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    invoke-virtual {v6}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v6

    iget v6, v6, Landroid/content/res/Configuration;->orientation:I

    const/4 v7, 0x1

    if-ne v6, v7, :cond_5

    .line 2523
    iget v6, v3, Landroid/view/WindowManager$LayoutParams;->flags:I

    const/high16 v7, 0x10000

    or-int/2addr v6, v7

    iput v6, v3, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 2524
    iget v6, v3, Landroid/view/WindowManager$LayoutParams;->softInputMode:I

    and-int/lit16 v6, v6, -0xf1

    iput v6, v3, Landroid/view/WindowManager$LayoutParams;->softInputMode:I

    .line 2525
    iget v6, v3, Landroid/view/WindowManager$LayoutParams;->softInputMode:I

    or-int/lit8 v6, v6, 0x10

    iput v6, v3, Landroid/view/WindowManager$LayoutParams;->softInputMode:I

    .line 2541
    :goto_1
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v6}, Lcom/lge/app/floating/FloatableActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v6

    invoke-virtual {v6}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .line 2544
    .local v0, "dm":Landroid/util/DisplayMetrics;
    iget v6, v3, Landroid/view/WindowManager$LayoutParams;->y:I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v7

    invoke-virtual {v7}, Landroid/view/View;->getHeight()I

    move-result v7

    add-int v2, v6, v7

    .line 2545
    .local v2, "mFrameViewBottom":I
    iget v6, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    if-ge v6, v2, :cond_3

    .line 2546
    iget v6, v3, Landroid/view/WindowManager$LayoutParams;->height:I

    iget v7, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    sub-int v7, v2, v7

    sub-int/2addr v6, v7

    iput v6, v3, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 2549
    :cond_3
    iget v6, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow;->mLayout:Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    iget v7, v7, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    sub-int/2addr v6, v7

    div-int/lit8 v6, v6, 0x2

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameViewInterface()Lcom/lge/app/floating/IFrameView;

    move-result-object v7

    invoke-interface {v7}, Lcom/lge/app/floating/IFrameView;->getPadding()Landroid/graphics/Rect;

    move-result-object v7

    iget v7, v7, Landroid/graphics/Rect;->left:I

    sub-int/2addr v6, v7

    iput v6, v3, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 2553
    iget-boolean v6, p0, Lcom/lge/app/floating/FloatingWindow;->mIsTitleInSeparateWindow:Z

    if-eqz v6, :cond_4

    .line 2554
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v6

    invoke-virtual {v6}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v5

    check-cast v5, Landroid/view/WindowManager$LayoutParams;

    .line 2557
    .local v5, "titleParams":Landroid/view/WindowManager$LayoutParams;
    new-instance v6, Landroid/view/WindowManager$LayoutParams;

    invoke-direct {v6}, Landroid/view/WindowManager$LayoutParams;-><init>()V

    iput-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedTitleParams:Landroid/view/WindowManager$LayoutParams;

    .line 2558
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedTitleParams:Landroid/view/WindowManager$LayoutParams;

    invoke-virtual {v6, v5}, Landroid/view/WindowManager$LayoutParams;->copyFrom(Landroid/view/WindowManager$LayoutParams;)I

    .line 2560
    iget v6, v5, Landroid/view/WindowManager$LayoutParams;->flags:I

    and-int/lit16 v6, v6, -0x201

    iput v6, v5, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 2563
    iget v6, v3, Landroid/view/WindowManager$LayoutParams;->x:I

    iput v6, v5, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 2566
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    invoke-virtual {v6}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v6

    iget v6, v6, Landroid/content/res/Configuration;->orientation:I

    const/4 v7, 0x1

    if-ne v6, v7, :cond_6

    .line 2567
    iget v6, v5, Landroid/view/WindowManager$LayoutParams;->flags:I

    const v7, -0x10001

    and-int/2addr v6, v7

    iput v6, v5, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 2572
    :goto_2
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v6

    invoke-virtual {p0, v6, v5}, Lcom/lge/app/floating/FloatingWindow;->updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    .line 2639
    .end local v0    # "dm":Landroid/util/DisplayMetrics;
    .end local v2    # "mFrameViewBottom":I
    .end local v5    # "titleParams":Landroid/view/WindowManager$LayoutParams;
    :cond_4
    :goto_3
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v6

    invoke-virtual {p0, v6, v3}, Lcom/lge/app/floating/FloatingWindow;->updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    .line 2640
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v6

    invoke-virtual {v6}, Landroid/view/View;->invalidate()V

    goto/16 :goto_0

    .line 2534
    :cond_5
    iget v6, v3, Landroid/view/WindowManager$LayoutParams;->softInputMode:I

    and-int/lit16 v6, v6, -0xf1

    iput v6, v3, Landroid/view/WindowManager$LayoutParams;->softInputMode:I

    .line 2535
    iget v6, v3, Landroid/view/WindowManager$LayoutParams;->softInputMode:I

    or-int/lit8 v6, v6, 0x10

    iput v6, v3, Landroid/view/WindowManager$LayoutParams;->softInputMode:I

    .line 2536
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    const v7, 0x7f060009

    invoke-virtual {v6, v7}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v6

    iget v7, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowY:I

    iget v8, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowY:I

    sub-int/2addr v7, v8

    add-int/2addr v6, v7

    iput v6, v3, Landroid/view/WindowManager$LayoutParams;->y:I

    goto/16 :goto_1

    .line 2569
    .restart local v0    # "dm":Landroid/util/DisplayMetrics;
    .restart local v2    # "mFrameViewBottom":I
    .restart local v5    # "titleParams":Landroid/view/WindowManager$LayoutParams;
    :cond_6
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    const v7, 0x7f060009

    invoke-virtual {v6, v7}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v6

    iput v6, v5, Landroid/view/WindowManager$LayoutParams;->y:I

    goto :goto_2

    .line 2576
    .end local v0    # "dm":Landroid/util/DisplayMetrics;
    .end local v2    # "mFrameViewBottom":I
    .end local v5    # "titleParams":Landroid/view/WindowManager$LayoutParams;
    :cond_7
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedLayoutParams:Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    if-eqz v6, :cond_b

    .line 2577
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedLayoutParams:Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    invoke-virtual {p0, v6}, Lcom/lge/app/floating/FloatingWindow;->setLayoutParam(Lcom/lge/app/floating/FloatingWindow$LayoutParams;)V

    .line 2578
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->updateRealPositionAndSize()V

    .line 2579
    iget v6, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowX:I

    iput v6, v3, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 2580
    iget v6, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowY:I

    iput v6, v3, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 2581
    iget v6, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowW:I

    iput v6, v3, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 2582
    iget v6, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowH:I

    iput v6, v3, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 2591
    :goto_4
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v6

    iget-boolean v6, v6, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->fullScreen:Z

    if-nez v6, :cond_8

    .line 2592
    iget v6, v3, Landroid/view/WindowManager$LayoutParams;->flags:I

    or-int/lit16 v6, v6, 0x200

    iput v6, v3, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 2593
    iget v6, v3, Landroid/view/WindowManager$LayoutParams;->flags:I

    const v7, -0x10001

    and-int/2addr v6, v7

    iput v6, v3, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 2595
    :cond_8
    const v6, 0x800033

    iput v6, v3, Landroid/view/WindowManager$LayoutParams;->gravity:I

    .line 2598
    if-nez p2, :cond_9

    .line 2599
    sget-object v6, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v7, "ime is no longer needed"

    invoke-static {v6, v7}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 2600
    invoke-virtual {p0, v3}, Lcom/lge/app/floating/FloatingWindow;->setNotFocusableState(Landroid/view/WindowManager$LayoutParams;)Landroid/view/WindowManager$LayoutParams;

    move-result-object v3

    .line 2602
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameView:Lcom/lge/app/floating/IFrameView;

    const/4 v7, 0x0

    invoke-interface {v6, v7}, Lcom/lge/app/floating/IFrameView;->setAsFocusable(Z)V

    .line 2603
    iget-boolean v6, p0, Lcom/lge/app/floating/FloatingWindow;->mIsImeVisible:Z

    if-eqz v6, :cond_9

    .line 2604
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->hideIme()V

    .line 2605
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mInputMethodManager:Landroid/view/inputmethod/InputMethodManager;

    invoke-static {v6}, Lcom/lge/app/floating/FloatingFunctionReflect;->finishInputLocked(Landroid/view/inputmethod/InputMethodManager;)V

    .line 2607
    const/4 v6, 0x0

    iput-boolean v6, p0, Lcom/lge/app/floating/FloatingWindow;->mIsImeVisible:Z

    .line 2614
    :cond_9
    iget-boolean v6, p0, Lcom/lge/app/floating/FloatingWindow;->mIsTitleInSeparateWindow:Z

    if-eqz v6, :cond_a

    .line 2615
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v6

    invoke-virtual {v6}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v5

    check-cast v5, Landroid/view/WindowManager$LayoutParams;

    .line 2618
    .restart local v5    # "titleParams":Landroid/view/WindowManager$LayoutParams;
    iget-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedLayoutParams:Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    if-eqz v6, :cond_c

    .line 2619
    iget v6, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowX:I

    iput v6, v5, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 2620
    iget v6, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowY:I

    iput v6, v5, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 2621
    iget v6, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowW:I

    iput v6, v5, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 2622
    iget v6, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowH:I

    iput v6, v5, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 2631
    :goto_5
    iget v6, v5, Landroid/view/WindowManager$LayoutParams;->flags:I

    or-int/lit16 v6, v6, 0x200

    iput v6, v5, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 2632
    iget v6, v5, Landroid/view/WindowManager$LayoutParams;->flags:I

    const v7, -0x10001

    and-int/2addr v6, v7

    iput v6, v5, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 2633
    const v6, 0x800033

    iput v6, v5, Landroid/view/WindowManager$LayoutParams;->gravity:I

    .line 2635
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v6

    invoke-virtual {p0, v6, v5}, Lcom/lge/app/floating/FloatingWindow;->updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    .line 2637
    .end local v5    # "titleParams":Landroid/view/WindowManager$LayoutParams;
    :cond_a
    const/4 v6, 0x0

    iput-object v6, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedLayoutParams:Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    goto/16 :goto_3

    .line 2586
    :cond_b
    const/4 v6, 0x2

    new-array v1, v6, [I

    .line 2587
    .local v1, "frameLocation":[I
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v6

    invoke-virtual {v6, v1}, Landroid/view/View;->getLocationOnScreen([I)V

    .line 2588
    const/4 v6, 0x0

    aget v6, v1, v6

    iput v6, v3, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 2589
    const/4 v6, 0x1

    aget v6, v1, v6

    iput v6, v3, Landroid/view/WindowManager$LayoutParams;->y:I

    goto/16 :goto_4

    .line 2626
    .end local v1    # "frameLocation":[I
    .restart local v5    # "titleParams":Landroid/view/WindowManager$LayoutParams;
    :cond_c
    const/4 v6, 0x2

    new-array v4, v6, [I

    .line 2627
    .local v4, "titleLocation":[I
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v6

    invoke-virtual {v6, v4}, Landroid/view/View;->getLocationOnScreen([I)V

    .line 2628
    const/4 v6, 0x0

    aget v6, v4, v6

    iput v6, v5, Landroid/view/WindowManager$LayoutParams;->x:I

    .line 2629
    const/4 v6, 0x1

    aget v6, v4, v6

    iput v6, v5, Landroid/view/WindowManager$LayoutParams;->y:I

    goto :goto_5
.end method

.method setLayoutParam(Lcom/lge/app/floating/FloatingWindow$LayoutParams;)V
    .locals 0
    .param p1, "mLayout"    # Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    .prologue
    .line 3464
    iput-object p1, p0, Lcom/lge/app/floating/FloatingWindow;->mLayout:Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    .line 3465
    return-void
.end method

.method setNotFocusableState(Landroid/view/WindowManager$LayoutParams;)Landroid/view/WindowManager$LayoutParams;
    .locals 4
    .param p1, "params"    # Landroid/view/WindowManager$LayoutParams;

    .prologue
    .line 1729
    const-string v0, ""

    .line 1730
    .local v0, "desc":Ljava/lang/String;
    iget v1, p1, Landroid/view/WindowManager$LayoutParams;->flags:I

    or-int/lit8 v1, v1, 0x8

    iput v1, p1, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 1731
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " NOT_FOCUSABLE"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1732
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v1

    iget-boolean v1, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->dontUseIme:Z

    if-eqz v1, :cond_0

    .line 1733
    iget v1, p1, Landroid/view/WindowManager$LayoutParams;->flags:I

    const v2, -0x20001

    and-int/2addr v1, v2

    iput v1, p1, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 1734
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " !ALT_FOCUSABLE_IM"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1743
    :goto_0
    sget-object v1, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "setNotFocusableState : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1744
    return-object p1

    .line 1736
    :cond_0
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v1

    iget-boolean v1, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->overIme:Z

    if-eqz v1, :cond_1

    .line 1737
    sget-object v1, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v2, "UseIme && OverIme do not allowed."

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 1739
    :cond_1
    iget v1, p1, Landroid/view/WindowManager$LayoutParams;->flags:I

    const/high16 v2, 0x20000

    or-int/2addr v1, v2

    iput v1, p1, Landroid/view/WindowManager$LayoutParams;->flags:I

    .line 1740
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " ALT_FOCUSABLE_IM"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public setOnUpdateListener(Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;)V
    .locals 0
    .param p1, "listener"    # Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    .prologue
    .line 2652
    iput-object p1, p0, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    .line 2653
    return-void
.end method

.method public setOpacity(F)V
    .locals 1
    .param p1, "alpha"    # F

    .prologue
    .line 2242
    const/4 v0, 0x1

    invoke-direct {p0, p1, v0}, Lcom/lge/app/floating/FloatingWindow;->setOpacity(FZ)V

    .line 2243
    return-void
.end method

.method public setOverlay(Z)V
    .locals 1
    .param p1, "enable"    # Z

    .prologue
    .line 2219
    const/4 v0, 0x1

    invoke-direct {p0, p1, v0}, Lcom/lge/app/floating/FloatingWindow;->setOverlay(ZZ)V

    .line 2220
    return-void
.end method

.method public setSize(II)V
    .locals 6
    .param p1, "width"    # I
    .param p2, "height"    # I

    .prologue
    const/4 v5, 0x0

    .line 2009
    sget-object v2, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "set size to ("

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ")"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 2019
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v2

    iput p1, v2, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    .line 2020
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v2

    iput p2, v2, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    .line 2021
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->updateRealPositionAndSize()V

    .line 2022
    iput-object v5, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedFrameParams:Landroid/view/WindowManager$LayoutParams;

    .line 2024
    iput-object v5, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedTitleParams:Landroid/view/WindowManager$LayoutParams;

    .line 2025
    iput-object v5, p0, Lcom/lge/app/floating/FloatingWindow;->mSavedLayoutParams:Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    .line 2026
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->isAttached()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 2027
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager$LayoutParams;

    .line 2030
    .local v0, "params":Landroid/view/WindowManager$LayoutParams;
    iget v2, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    iget v3, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowW:I

    if-ne v2, v3, :cond_0

    iget v2, v0, Landroid/view/WindowManager$LayoutParams;->height:I

    iget v3, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowH:I

    if-eq v2, v3, :cond_1

    .line 2031
    :cond_0
    iget v2, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowW:I

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 2032
    iget v2, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowH:I

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 2033
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v2

    invoke-virtual {p0, v2, v0}, Lcom/lge/app/floating/FloatingWindow;->updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    .line 2036
    :cond_1
    iget-boolean v2, p0, Lcom/lge/app/floating/FloatingWindow;->mIsTitleInSeparateWindow:Z

    if-eqz v2, :cond_2

    .line 2037
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v2

    iget-boolean v2, v2, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->useDoubleTapMinimize:Z

    if-eqz v2, :cond_3

    .line 2038
    new-instance v2, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v3

    invoke-direct {v2, v3}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v3, Lcom/lge/app/floating/FloatingWindow$1;

    invoke-direct {v3, p0}, Lcom/lge/app/floating/FloatingWindow$1;-><init>(Lcom/lge/app/floating/FloatingWindow;)V

    invoke-virtual {v2, v3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 2064
    .end local v0    # "params":Landroid/view/WindowManager$LayoutParams;
    :cond_2
    :goto_0
    return-void

    .line 2053
    .restart local v0    # "params":Landroid/view/WindowManager$LayoutParams;
    :cond_3
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    check-cast v1, Landroid/view/WindowManager$LayoutParams;

    .line 2055
    .local v1, "titleParams":Landroid/view/WindowManager$LayoutParams;
    iget v2, v1, Landroid/view/WindowManager$LayoutParams;->width:I

    iget v3, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowW:I

    if-ne v2, v3, :cond_4

    iget v2, v1, Landroid/view/WindowManager$LayoutParams;->height:I

    iget v3, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowH:I

    if-eq v2, v3, :cond_2

    .line 2057
    :cond_4
    iget v2, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowW:I

    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->width:I

    .line 2058
    iget v2, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowH:I

    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 2059
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v2

    invoke-virtual {p0, v2, v1}, Lcom/lge/app/floating/FloatingWindow;->updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    goto :goto_0
.end method

.method public setTalkbackAppName(Ljava/lang/String;)V
    .locals 7
    .param p1, "customAppName"    # Ljava/lang/String;

    .prologue
    .line 1884
    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    const v5, 0x7f0a0008

    invoke-virtual {v4, v5}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v3

    .line 1885
    .local v3, "talkbackName":Ljava/lang/String;
    if-eqz v3, :cond_0

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v4

    if-nez v4, :cond_1

    .line 1908
    :cond_0
    :goto_0
    return-void

    .line 1889
    :cond_1
    if-eqz p1, :cond_2

    .line 1890
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 1892
    sget-object v4, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "talkback Custom App name : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1893
    iput-object p1, p0, Lcom/lge/app/floating/FloatingWindow;->mAppName:Ljava/lang/String;

    goto :goto_0

    .line 1895
    :cond_2
    const-string v1, ""

    .line 1897
    .local v1, "appName":Ljava/lang/String;
    :try_start_0
    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v4}, Lcom/lge/app/floating/FloatableActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v4

    iget-object v5, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v5}, Lcom/lge/app/floating/FloatableActivity;->getPackageName()Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x0

    invoke-virtual {v4, v5, v6}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    .line 1899
    .local v0, "ai":Landroid/content/pm/ApplicationInfo;
    iget-object v4, p0, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v4}, Lcom/lge/app/floating/FloatableActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v4

    invoke-virtual {v4, v0}, Landroid/content/pm/PackageManager;->getApplicationLabel(Landroid/content/pm/ApplicationInfo;)Ljava/lang/CharSequence;

    move-result-object v4

    invoke-interface {v4}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 1904
    .end local v0    # "ai":Landroid/content/pm/ApplicationInfo;
    :goto_1
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 1905
    sget-object v4, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "talkback Package App name : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1906
    iput-object v1, p0, Lcom/lge/app/floating/FloatingWindow;->mAppName:Ljava/lang/String;

    goto/16 :goto_0

    .line 1901
    :catch_0
    move-exception v2

    .line 1902
    .local v2, "e":Ljava/lang/Exception;
    sget-object v4, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method titleShouldBeHidden()Z
    .locals 1

    .prologue
    .line 1536
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v0

    iget-boolean v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->hideTitle:Z

    if-eqz v0, :cond_2

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->isInOverlay()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v0

    iget-boolean v0, v0, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->fullScreen:Z

    if-eqz v0, :cond_2

    :cond_0
    iget-boolean v0, p0, Lcom/lge/app/floating/FloatingWindow;->mIsMoving:Z

    if-nez v0, :cond_2

    iget-boolean v0, p0, Lcom/lge/app/floating/FloatingWindow;->mIsResizing:Z

    if-nez v0, :cond_2

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/lge/app/floating/FloatingWindow;->mTitleView:Lcom/lge/app/floating/ITitleView;

    invoke-interface {v0}, Lcom/lge/app/floating/ITitleView;->isSliderOnTracking()Z

    move-result v0

    if-nez v0, :cond_2

    :cond_1
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_2
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public updateLayoutParams(Lcom/lge/app/floating/FloatingWindow$LayoutParams;)V
    .locals 1
    .param p1, "params"    # Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    .prologue
    .line 1385
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/lge/app/floating/FloatingWindow;->updateLayoutParams(Lcom/lge/app/floating/FloatingWindow$LayoutParams;Z)V

    .line 1386
    return-void
.end method

.method public updateLayoutParams(Lcom/lge/app/floating/FloatingWindow$LayoutParams;Z)V
    .locals 3
    .param p1, "params"    # Lcom/lge/app/floating/FloatingWindow$LayoutParams;
    .param p2, "preferSavedRegion"    # Z

    .prologue
    .line 1403
    sget-object v0, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "updateLayoutParams to "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1404
    invoke-direct {p0, p1, p2}, Lcom/lge/app/floating/FloatingWindow;->updateLayoutParamsInner(Lcom/lge/app/floating/FloatingWindow$LayoutParams;Z)V

    .line 1405
    return-void
.end method

.method updateLayoutParamsInner(Lcom/lge/app/floating/FloatingWindow$LayoutParams;)V
    .locals 1
    .param p1, "params"    # Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    .prologue
    .line 1494
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/lge/app/floating/FloatingWindow;->updateLayoutParamsInner(Lcom/lge/app/floating/FloatingWindow$LayoutParams;Z)V

    .line 1495
    return-void
.end method

.method updateRealPositionAndSize()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    const/4 v4, -0x1

    .line 1544
    iget-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mFrameView:Lcom/lge/app/floating/IFrameView;

    invoke-interface {v2}, Lcom/lge/app/floating/IFrameView;->getPadding()Landroid/graphics/Rect;

    move-result-object v0

    .line 1545
    .local v0, "padding":Landroid/graphics/Rect;
    iget-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mTitleView:Lcom/lge/app/floating/ITitleView;

    invoke-interface {v2}, Lcom/lge/app/floating/ITitleView;->measureAndGetHeight()I

    move-result v1

    .line 1547
    .local v1, "titleHeight":I
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v2

    if-nez v2, :cond_1

    .line 1548
    sget-object v2, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v3, "Cannot updateRealPositionAndSize - mLayout == null"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1583
    :cond_0
    :goto_0
    return-void

    .line 1551
    :cond_1
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v2

    iget v2, v2, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    iget v3, v0, Landroid/graphics/Rect;->left:I

    sub-int/2addr v2, v3

    iput v2, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowX:I

    iput v2, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowX:I

    .line 1552
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v2

    iget v2, v2, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->width:I

    iget v3, v0, Landroid/graphics/Rect;->left:I

    add-int/2addr v2, v3

    iget v3, v0, Landroid/graphics/Rect;->right:I

    add-int/2addr v2, v3

    iput v2, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowW:I

    iput v2, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowW:I

    .line 1553
    iget v2, v0, Landroid/graphics/Rect;->top:I

    add-int/2addr v2, v1

    iput v2, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowH:I

    .line 1556
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->titleShouldBeHidden()Z

    move-result v2

    if-nez v2, :cond_2

    iget-boolean v2, p0, Lcom/lge/app/floating/FloatingWindow;->mUseSeparateWindow:Z

    if-nez v2, :cond_2

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v2

    iget-boolean v2, v2, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->useOverlappingTitle:Z

    if-eqz v2, :cond_3

    .line 1558
    :cond_2
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v2

    iget v2, v2, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    iget v3, v0, Landroid/graphics/Rect;->top:I

    sub-int/2addr v2, v3

    iput v2, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowY:I

    .line 1559
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v2

    iget v2, v2, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    iget v3, v0, Landroid/graphics/Rect;->top:I

    add-int/2addr v2, v3

    iget v3, v0, Landroid/graphics/Rect;->bottom:I

    add-int/2addr v2, v3

    iput v2, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowH:I

    .line 1568
    :goto_1
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v2

    iget-boolean v2, v2, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->useOverlappingTitle:Z

    if-eqz v2, :cond_4

    .line 1569
    iget v2, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowY:I

    iput v2, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowY:I

    .line 1577
    :goto_2
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v2

    iget-boolean v2, v2, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->fullScreen:Z

    if-eqz v2, :cond_0

    .line 1578
    iput v5, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowX:I

    .line 1579
    iput v5, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowY:I

    .line 1580
    iput v4, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowW:I

    .line 1581
    iput v4, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowH:I

    goto :goto_0

    .line 1562
    :cond_3
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v2

    iget v2, v2, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    sub-int/2addr v2, v1

    iget v3, v0, Landroid/graphics/Rect;->top:I

    sub-int/2addr v2, v3

    iput v2, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowY:I

    .line 1563
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v2

    iget v2, v2, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->height:I

    add-int/2addr v2, v1

    iget v3, v0, Landroid/graphics/Rect;->top:I

    add-int/2addr v2, v3

    iget v3, v0, Landroid/graphics/Rect;->bottom:I

    add-int/2addr v2, v3

    iput v2, p0, Lcom/lge/app/floating/FloatingWindow;->frameWindowH:I

    goto :goto_1

    .line 1571
    :cond_4
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v2

    iget v2, v2, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    sub-int/2addr v2, v1

    iget v3, v0, Landroid/graphics/Rect;->top:I

    sub-int/2addr v2, v3

    iput v2, p0, Lcom/lge/app/floating/FloatingWindow;->titleWindowY:I

    goto :goto_2
.end method

.method updateTitleBackground(Z)V
    .locals 4
    .param p1, "focused"    # Z

    .prologue
    .line 2973
    const-string v2, "tag_title_layout"

    invoke-virtual {p0, v2}, Lcom/lge/app/floating/FloatingWindow;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/RelativeLayout;

    .line 2976
    .local v1, "rl":Landroid/widget/RelativeLayout;
    if-nez v1, :cond_0

    .line 2977
    sget-object v2, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    const-string v3, "Cannot updateTitleBackground - Fail to findViewWithTag"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 2987
    :goto_0
    return-void

    .line 2980
    :cond_0
    invoke-virtual {v1}, Landroid/widget/RelativeLayout;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 2981
    .local v0, "d":Landroid/graphics/drawable/Drawable;
    if-eqz v0, :cond_1

    .line 2982
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->isInOverlay()Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mResources:Landroid/content/res/Resources;

    const v3, 0x7f080003

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v2

    :goto_1
    invoke-virtual {v0, v2}, Landroid/graphics/drawable/Drawable;->setAlpha(I)V

    .line 2984
    iget-object v2, p0, Lcom/lge/app/floating/FloatingWindow;->mTitleView:Lcom/lge/app/floating/ITitleView;

    invoke-interface {v2}, Lcom/lge/app/floating/ITitleView;->updateDividers()V

    .line 2986
    :cond_1
    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/widget/RelativeLayout;->setSelected(Z)V

    goto :goto_0

    .line 2982
    :cond_2
    const/16 v2, 0xff

    goto :goto_1
.end method

.method updateViewLayoutInSafety(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V
    .locals 4
    .param p1, "view"    # Landroid/view/View;
    .param p2, "params"    # Landroid/view/WindowManager$LayoutParams;

    .prologue
    .line 1972
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getRealWindowManager()Landroid/view/WindowManager;

    move-result-object v1

    if-nez v1, :cond_0

    .line 1973
    sget-object v1, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Exception in updateViewLayoutInSafety - mWindowManager : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getRealWindowManager()Landroid/view/WindowManager;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1984
    :goto_0
    return-void

    .line 1979
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingWindow;->getRealWindowManager()Landroid/view/WindowManager;

    move-result-object v1

    invoke-interface {v1, p1, p2}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1980
    :catch_0
    move-exception v0

    .line 1981
    .local v0, "e":Ljava/lang/Exception;
    sget-object v1, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Exception in updateViewLayout - view : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 1982
    sget-object v1, Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method
