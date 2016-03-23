.class Lcom/lge/dockservice/DockWindowService$DockView;
.super Landroid/widget/ImageView;
.source "DockWindowService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/dockservice/DockWindowService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "DockView"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/dockservice/DockWindowService$DockView$MyGestureListener;
    }
.end annotation


# instance fields
.field private mAlphaAnimator:Landroid/animation/ValueAnimator;

.field private mClient:Lcom/lge/dockservice/IBaseDockWindow;

.field public mCurrentDockPosX:I

.field public mCurrentDockPosY:I

.field private mDockDirection:I

.field private mDockViewTouchOffsetX:I

.field private mDockViewTouchOffsetY:I

.field private mDownX:I

.field private mDownY:I

.field private mFingerOffsetX:I

.field private mFingerOffsetY:I

.field private final mGestureDetector:Landroid/view/GestureDetector;

.field private mHasTouchDownConfirmed:Z

.field private final mIconSize:[I

.field private mIsInLowProfile:Z

.field private mPackageName:Ljava/lang/String;

.field private mRawDockIcon:Landroid/graphics/Bitmap;

.field private mSlidingAnimator:Lcom/lge/dockservice/TransitionAnimator;

.field private mStartedAsDock:Z

.field private mState:I

.field mX_Landscape:I

.field mX_Portrate:I

.field mY_Landscape:I

.field mY_Portrate:I

.field final synthetic this$0:Lcom/lge/dockservice/DockWindowService;


# direct methods
.method constructor <init>(Lcom/lge/dockservice/DockWindowService;Lcom/lge/dockservice/IBaseDockWindow;Ljava/lang/String;Landroid/graphics/Bitmap;IIZ)V
    .locals 8
    .param p2, "token"    # Lcom/lge/dockservice/IBaseDockWindow;
    .param p3, "packagename"    # Ljava/lang/String;
    .param p4, "dockIcon"    # Landroid/graphics/Bitmap;
    .param p5, "x"    # I
    .param p6, "y"    # I
    .param p7, "initToShow"    # Z

    .prologue
    const/4 v7, 0x1

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v3, -0x1

    iput-object p1, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    invoke-direct {p0, p1}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    iput-object v5, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mPackageName:Ljava/lang/String;

    iput v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDockDirection:I

    iput v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosX:I

    iput v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosY:I

    iput v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mX_Portrate:I

    iput v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mY_Portrate:I

    iput v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mX_Landscape:I

    iput v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mY_Landscape:I

    iput v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mState:I

    iput-object v5, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mSlidingAnimator:Lcom/lge/dockservice/TransitionAnimator;

    iput-object v5, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mAlphaAnimator:Landroid/animation/ValueAnimator;

    iput-boolean v6, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mIsInLowProfile:Z

    iput v6, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mFingerOffsetX:I

    iput v6, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mFingerOffsetY:I

    iput-boolean v6, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mHasTouchDownConfirmed:Z

    iput-boolean v6, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mStartedAsDock:Z

    iput v6, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDockViewTouchOffsetX:I

    iput v6, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDockViewTouchOffsetY:I

    iput v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDownX:I

    iput v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDownY:I

    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v3

    const-string v4, "init DockView"

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v3, Landroid/view/GestureDetector;

    new-instance v4, Lcom/lge/dockservice/DockWindowService$DockView$MyGestureListener;

    invoke-direct {v4, p0, v5}, Lcom/lge/dockservice/DockWindowService$DockView$MyGestureListener;-><init>(Lcom/lge/dockservice/DockWindowService$DockView;Lcom/lge/dockservice/DockWindowService$1;)V

    new-instance v5, Landroid/os/Handler;

    invoke-direct {v5}, Landroid/os/Handler;-><init>()V

    invoke-direct {v3, p1, v4, v5}, Landroid/view/GestureDetector;-><init>(Landroid/content/Context;Landroid/view/GestureDetector$OnGestureListener;Landroid/os/Handler;)V

    iput-object v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mGestureDetector:Landroid/view/GestureDetector;

    iput-object p3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mPackageName:Ljava/lang/String;

    iput-object p2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mClient:Lcom/lge/dockservice/IBaseDockWindow;

    const/4 v3, 0x2

    new-array v3, v3, [I

    iput-object v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mIconSize:[I

    iget-object v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mIconSize:[I

    # getter for: Lcom/lge/dockservice/DockWindowService;->mResources:Landroid/content/res/Resources;
    invoke-static {p1}, Lcom/lge/dockservice/DockWindowService;->access$1900(Lcom/lge/dockservice/DockWindowService;)Landroid/content/res/Resources;

    move-result-object v4

    const v5, 0x7f06000d

    invoke-virtual {v4, v5}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v4

    aput v4, v3, v6

    iget-object v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mIconSize:[I

    # getter for: Lcom/lge/dockservice/DockWindowService;->mResources:Landroid/content/res/Resources;
    invoke-static {p1}, Lcom/lge/dockservice/DockWindowService;->access$1900(Lcom/lge/dockservice/DockWindowService;)Landroid/content/res/Resources;

    move-result-object v4

    const v5, 0x7f06000e

    invoke-virtual {v4, v5}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v4

    aput v4, v3, v7

    iget-object v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mIconSize:[I

    aget v3, v3, v6

    mul-int/lit8 v3, v3, 0x0

    iput v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mFingerOffsetX:I

    iget-object v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mIconSize:[I

    aget v3, v3, v7

    mul-int/lit8 v3, v3, 0x0

    iput v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mFingerOffsetY:I

    iput-object p4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mRawDockIcon:Landroid/graphics/Bitmap;

    invoke-direct {p0, p5, p6}, Lcom/lge/dockservice/DockWindowService$DockView;->setDockImageToWindow(II)V

    new-instance v3, Lcom/lge/dockservice/TransitionAnimator;

    invoke-direct {v3}, Lcom/lge/dockservice/TransitionAnimator;-><init>()V

    iput-object v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mSlidingAnimator:Lcom/lge/dockservice/TransitionAnimator;

    iget-object v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mSlidingAnimator:Lcom/lge/dockservice/TransitionAnimator;

    new-instance v4, Landroid/view/animation/DecelerateInterpolator;

    invoke-direct {v4}, Landroid/view/animation/DecelerateInterpolator;-><init>()V

    invoke-virtual {v3, v4}, Lcom/lge/dockservice/TransitionAnimator;->setInterpolator(Landroid/view/animation/DecelerateInterpolator;)V

    iget-object v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mSlidingAnimator:Lcom/lge/dockservice/TransitionAnimator;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mResources:Landroid/content/res/Resources;
    invoke-static {p1}, Lcom/lge/dockservice/DockWindowService;->access$1900(Lcom/lge/dockservice/DockWindowService;)Landroid/content/res/Resources;

    move-result-object v4

    const v5, 0x7f080007

    invoke-virtual {v4, v5}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v4

    invoke-virtual {v3, v4}, Lcom/lge/dockservice/TransitionAnimator;->setDuration(I)V

    # getter for: Lcom/lge/dockservice/DockWindowService;->mResources:Landroid/content/res/Resources;
    invoke-static {p1}, Lcom/lge/dockservice/DockWindowService;->access$1900(Lcom/lge/dockservice/DockWindowService;)Landroid/content/res/Resources;

    move-result-object v3

    const v4, 0x7f0a0008

    invoke-virtual {v3, v4}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v2

    .local v2, "talkbackName":Ljava/lang/String;
    const/4 v0, 0x0

    .local v0, "appName":Ljava/lang/String;
    :try_start_0
    iget-object v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mClient:Lcom/lge/dockservice/IBaseDockWindow;

    invoke-interface {v3}, Lcom/lge/dockservice/IBaseDockWindow;->getAppName()Ljava/lang/String;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    :goto_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/lge/dockservice/DockWindowService$DockView;->setContentDescription(Ljava/lang/CharSequence;)V

    if-eqz p7, :cond_0

    invoke-direct {p0}, Lcom/lge/dockservice/DockWindowService$DockView;->awake()V

    :goto_1
    return-void

    :catch_0
    move-exception v1

    .local v1, "e":Landroid/os/RemoteException;
    invoke-virtual {v1}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0

    .end local v1    # "e":Landroid/os/RemoteException;
    :cond_0
    invoke-direct {p0}, Lcom/lge/dockservice/DockWindowService$DockView;->sleep()V

    goto :goto_1
.end method

.method static synthetic access$1100(Lcom/lge/dockservice/DockWindowService$DockView;)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/dockservice/DockWindowService$DockView;

    .prologue
    invoke-direct {p0}, Lcom/lge/dockservice/DockWindowService$DockView;->sleep()V

    return-void
.end method

.method static synthetic access$1200(Lcom/lge/dockservice/DockWindowService$DockView;)I
    .locals 1
    .param p0, "x0"    # Lcom/lge/dockservice/DockWindowService$DockView;

    .prologue
    iget v0, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDockDirection:I

    return v0
.end method

.method static synthetic access$1300(Lcom/lge/dockservice/DockWindowService$DockView;II)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/dockservice/DockWindowService$DockView;
    .param p1, "x1"    # I
    .param p2, "x2"    # I

    .prologue
    invoke-direct {p0, p1, p2}, Lcom/lge/dockservice/DockWindowService$DockView;->slideTo(II)V

    return-void
.end method

.method static synthetic access$1400(Lcom/lge/dockservice/DockWindowService$DockView;II)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/dockservice/DockWindowService$DockView;
    .param p1, "x1"    # I
    .param p2, "x2"    # I

    .prologue
    invoke-direct {p0, p1, p2}, Lcom/lge/dockservice/DockWindowService$DockView;->moveTo(II)V

    return-void
.end method

.method static synthetic access$1500(Lcom/lge/dockservice/DockWindowService$DockView;Z)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/dockservice/DockWindowService$DockView;
    .param p1, "x1"    # Z

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/dockservice/DockWindowService$DockView;->attachToWall(Z)V

    return-void
.end method

.method static synthetic access$2100(Lcom/lge/dockservice/DockWindowService$DockView;)Lcom/lge/dockservice/TransitionAnimator;
    .locals 1
    .param p0, "x0"    # Lcom/lge/dockservice/DockWindowService$DockView;

    .prologue
    iget-object v0, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mSlidingAnimator:Lcom/lge/dockservice/TransitionAnimator;

    return-object v0
.end method

.method static synthetic access$300(Lcom/lge/dockservice/DockWindowService$DockView;)Landroid/animation/ValueAnimator;
    .locals 1
    .param p0, "x0"    # Lcom/lge/dockservice/DockWindowService$DockView;

    .prologue
    iget-object v0, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mAlphaAnimator:Landroid/animation/ValueAnimator;

    return-object v0
.end method

.method static synthetic access$500(Lcom/lge/dockservice/DockWindowService$DockView;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/lge/dockservice/DockWindowService$DockView;

    .prologue
    iget-object v0, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mPackageName:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$702(Lcom/lge/dockservice/DockWindowService$DockView;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/lge/dockservice/DockWindowService$DockView;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mHasTouchDownConfirmed:Z

    return p1
.end method

.method static synthetic access$800(Lcom/lge/dockservice/DockWindowService$DockView;)I
    .locals 1
    .param p0, "x0"    # Lcom/lge/dockservice/DockWindowService$DockView;

    .prologue
    iget v0, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mState:I

    return v0
.end method

.method static synthetic access$802(Lcom/lge/dockservice/DockWindowService$DockView;I)I
    .locals 0
    .param p0, "x0"    # Lcom/lge/dockservice/DockWindowService$DockView;
    .param p1, "x1"    # I

    .prologue
    iput p1, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mState:I

    return p1
.end method

.method static synthetic access$900(Lcom/lge/dockservice/DockWindowService$DockView;IIZ)V
    .locals 0
    .param p0, "x0"    # Lcom/lge/dockservice/DockWindowService$DockView;
    .param p1, "x1"    # I
    .param p2, "x2"    # I
    .param p3, "x3"    # Z

    .prologue
    invoke-direct {p0, p1, p2, p3}, Lcom/lge/dockservice/DockWindowService$DockView;->awake(IIZ)V

    return-void
.end method

.method private attachToWall(Z)V
    .locals 6
    .param p1, "realMoving"    # Z

    .prologue
    const/4 v5, 0x0

    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "attachToWall for "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/dockservice/DockWindowService$DockView;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .local v0, "dm":Landroid/util/DisplayMetrics;
    invoke-virtual {p0}, Lcom/lge/dockservice/DockWindowService$DockView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    check-cast v1, Landroid/view/WindowManager$LayoutParams;

    .local v1, "params":Landroid/view/WindowManager$LayoutParams;
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "dock view x = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", y = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, v1, Landroid/view/WindowManager$LayoutParams;->y:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " for "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDockDirection:I

    const/4 v3, 0x3

    if-ne v2, v3, :cond_1

    if-eqz p1, :cond_0

    iget v2, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    iget v3, v1, Landroid/view/WindowManager$LayoutParams;->width:I

    sub-int/2addr v2, v3

    iget v3, v1, Landroid/view/WindowManager$LayoutParams;->y:I

    invoke-direct {p0, v2, v3}, Lcom/lge/dockservice/DockWindowService$DockView;->moveTo(II)V

    :goto_0
    return-void

    :cond_0
    iget v2, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    iget v3, v1, Landroid/view/WindowManager$LayoutParams;->width:I

    sub-int/2addr v2, v3

    iput v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosX:I

    goto :goto_0

    :cond_1
    iget v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDockDirection:I

    const/4 v3, 0x2

    if-ne v2, v3, :cond_3

    if-eqz p1, :cond_2

    iget v2, v1, Landroid/view/WindowManager$LayoutParams;->y:I

    invoke-direct {p0, v5, v2}, Lcom/lge/dockservice/DockWindowService$DockView;->moveTo(II)V

    goto :goto_0

    :cond_2
    iput v5, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosX:I

    goto :goto_0

    :cond_3
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "dock to invalid direction: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDockDirection:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "(this means undock)"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private awake()V
    .locals 3

    .prologue
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v0

    const-string v1, "awake dock"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget v0, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosX:I

    iget v1, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosY:I

    const/4 v2, 0x0

    invoke-direct {p0, v0, v1, v2}, Lcom/lge/dockservice/DockWindowService$DockView;->awake(IIZ)V

    return-void
.end method

.method private awake(IIZ)V
    .locals 7
    .param p1, "x"    # I
    .param p2, "y"    # I
    .param p3, "adjustFingerOffset"    # Z

    .prologue
    const/4 v6, 0x1

    const/4 v5, 0x0

    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "awake dock to ( "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " , "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " ) "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v2, 0x2

    iput v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mState:I

    :try_start_0
    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mClient:Lcom/lge/dockservice/IBaseDockWindow;

    iget v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mState:I

    invoke-interface {v2, v3}, Lcom/lge/dockservice/IBaseDockWindow;->updateDockState(I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mIconSize:[I

    aget v2, v2, v5

    add-int/2addr v2, p1

    iget-object v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mIconSize:[I

    aget v3, v3, v6

    add-int/2addr v3, p2

    invoke-direct {p0, p1, p2, v2, v3}, Lcom/lge/dockservice/DockWindowService$DockView;->isInDockArea(IIII)I

    move-result v2

    iput v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDockDirection:I

    invoke-virtual {p0}, Lcom/lge/dockservice/DockWindowService$DockView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    check-cast v1, Landroid/view/WindowManager$LayoutParams;

    .local v1, "lp":Landroid/view/WindowManager$LayoutParams;
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Dock ( "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mPackageName:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " ) awaken"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const/high16 v2, 0x3f800000    # 1.0f

    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->alpha:F

    iget v2, v1, Landroid/view/WindowManager$LayoutParams;->flags:I

    and-int/lit8 v2, v2, -0x11

    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->flags:I

    if-eqz p3, :cond_0

    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mIconSize:[I

    aget v2, v2, v5

    div-int/lit8 v2, v2, 0x2

    sub-int v2, p1, v2

    iget v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mFingerOffsetX:I

    sub-int p1, v2, v3

    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mIconSize:[I

    aget v2, v2, v6

    sub-int v2, p2, v2

    iget v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mFingerOffsetY:I

    sub-int p2, v2, v3

    :cond_0
    iput p1, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    iput p2, v1, Landroid/view/WindowManager$LayoutParams;->y:I

    iput p1, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosX:I

    iput p2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosY:I

    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mWindowManager:Landroid/view/WindowManager;
    invoke-static {v2}, Lcom/lge/dockservice/DockWindowService;->access$1600(Lcom/lge/dockservice/DockWindowService;)Landroid/view/WindowManager;

    move-result-object v2

    invoke-interface {v2, p0, v1}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    return-void

    .end local v1    # "lp":Landroid/view/WindowManager$LayoutParams;
    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "RemoteException in awake: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Landroid/os/RemoteException;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0
.end method

.method private handleDockBackGround()V
    .locals 1

    .prologue
    invoke-direct {p0}, Lcom/lge/dockservice/DockWindowService$DockView;->isInDockArea()I

    move-result v0

    invoke-direct {p0, v0}, Lcom/lge/dockservice/DockWindowService$DockView;->handleDockBackGround(I)V

    return-void
.end method

.method private handleDockBackGround(I)V
    .locals 2
    .param p1, "dockDirection"    # I

    .prologue
    const/4 v0, 0x2

    if-ne p1, v0, :cond_0

    const/high16 v0, 0x7f020000

    invoke-virtual {p0, v0}, Lcom/lge/dockservice/DockWindowService$DockView;->setBackgroundResource(I)V

    :goto_0
    return-void

    :cond_0
    const/4 v0, 0x3

    if-ne p1, v0, :cond_1

    const v0, 0x7f020001

    invoke-virtual {p0, v0}, Lcom/lge/dockservice/DockWindowService$DockView;->setBackgroundResource(I)V

    goto :goto_0

    :cond_1
    const/4 v0, -0x1

    if-ne p1, v0, :cond_2

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/lge/dockservice/DockWindowService$DockView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    goto :goto_0

    :cond_2
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v0

    const-string v1, "Exceptional case occured in handleDockBackGround."

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private isInDockArea()I
    .locals 6

    .prologue
    iget v0, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosX:I

    iget v1, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosY:I

    iget v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosX:I

    iget-object v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mIconSize:[I

    const/4 v4, 0x0

    aget v3, v3, v4

    add-int/2addr v2, v3

    iget v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosY:I

    iget-object v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mIconSize:[I

    const/4 v5, 0x1

    aget v4, v4, v5

    add-int/2addr v3, v4

    invoke-direct {p0, v0, v1, v2, v3}, Lcom/lge/dockservice/DockWindowService$DockView;->isInDockArea(IIII)I

    move-result v0

    return v0
.end method

.method private isInDockArea(IIII)I
    .locals 5
    .param p1, "left"    # I
    .param p2, "top"    # I
    .param p3, "right"    # I
    .param p4, "bottom"    # I

    .prologue
    const/4 v1, -0x1

    .local v1, "isInDockArea":I
    :try_start_0
    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mClient:Lcom/lge/dockservice/IBaseDockWindow;

    new-instance v3, Landroid/graphics/Rect;

    invoke-direct {v3, p1, p2, p3, p4}, Landroid/graphics/Rect;-><init>(IIII)V

    invoke-interface {v2, v3}, Lcom/lge/dockservice/IBaseDockWindow;->isInDockArea(Landroid/graphics/Rect;)I
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "exception":Landroid/os/RemoteException;
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Exception occured in isInDockArea : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Landroid/os/RemoteException;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private isInSystemArea(I)I
    .locals 5
    .param p1, "currentY"    # I

    .prologue
    const/4 v2, 0x1

    iget-object v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mResources:Landroid/content/res/Resources;
    invoke-static {v3}, Lcom/lge/dockservice/DockWindowService;->access$1900(Lcom/lge/dockservice/DockWindowService;)Landroid/content/res/Resources;

    move-result-object v3

    const v4, 0x7f060009

    invoke-virtual {v3, v4}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v1

    .local v1, "statusBarHeight":I
    new-instance v0, Landroid/util/DisplayMetrics;

    invoke-direct {v0}, Landroid/util/DisplayMetrics;-><init>()V

    .local v0, "displaymetrics":Landroid/util/DisplayMetrics;
    iget-object v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mWindowManager:Landroid/view/WindowManager;
    invoke-static {v3}, Lcom/lge/dockservice/DockWindowService;->access$1600(Lcom/lge/dockservice/DockWindowService;)Landroid/view/WindowManager;

    move-result-object v3

    invoke-interface {v3}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v3

    invoke-virtual {v3, v0}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V

    if-ge p1, v1, :cond_0

    :goto_0
    return v2

    :cond_0
    iget-object v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mIconSize:[I

    aget v2, v3, v2

    add-int/2addr v2, p1

    iget v3, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    if-le v2, v3, :cond_1

    const/4 v2, 0x2

    goto :goto_0

    :cond_1
    const/4 v2, -0x1

    goto :goto_0
.end method

.method private moveTo(II)V
    .locals 5
    .param p1, "x"    # I
    .param p2, "y"    # I

    .prologue
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "move to "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/dockservice/DockWindowService$DockView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager$LayoutParams;

    .local v0, "dockviewlp":Landroid/view/WindowManager$LayoutParams;
    iput p1, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    iput p2, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    :try_start_0
    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mWindowManager:Landroid/view/WindowManager;
    invoke-static {v2}, Lcom/lge/dockservice/DockWindowService;->access$1600(Lcom/lge/dockservice/DockWindowService;)Landroid/view/WindowManager;

    move-result-object v2

    invoke-interface {v2, p0, v0}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    iput p1, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosX:I

    iput p2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosY:I

    return-void

    :catch_0
    move-exception v1

    .local v1, "e":Ljava/lang/Exception;
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v2

    const-string v3, "Move canceled by Exception"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, ""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v1}, Ljava/lang/Exception;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private setDockImageToWindow(II)V
    .locals 8
    .param p1, "touchX"    # I
    .param p2, "touchY"    # I

    .prologue
    const/4 v7, 0x1

    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v3

    const-string v4, "set Dock Image To Window"

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mRawDockIcon:Landroid/graphics/Bitmap;

    iget-object v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mResources:Landroid/content/res/Resources;
    invoke-static {v4}, Lcom/lge/dockservice/DockWindowService;->access$1900(Lcom/lge/dockservice/DockWindowService;)Landroid/content/res/Resources;

    move-result-object v4

    const v5, 0x7f06000f

    invoke-virtual {v4, v5}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v4

    iget-object v5, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mResources:Landroid/content/res/Resources;
    invoke-static {v5}, Lcom/lge/dockservice/DockWindowService;->access$1900(Lcom/lge/dockservice/DockWindowService;)Landroid/content/res/Resources;

    move-result-object v5

    const v6, 0x7f060010

    invoke-virtual {v5, v6}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v5

    invoke-static {v3, v4, v5, v7}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/lge/dockservice/DockWindowService$DockView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    sget-object v3, Landroid/widget/ImageView$ScaleType;->CENTER:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p0, v3}, Lcom/lge/dockservice/DockWindowService$DockView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iput p1, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosX:I

    iput p2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosY:I

    invoke-direct {p0}, Lcom/lge/dockservice/DockWindowService$DockView;->handleDockBackGround()V

    new-instance v1, Landroid/view/WindowManager$LayoutParams;

    invoke-direct {v1}, Landroid/view/WindowManager$LayoutParams;-><init>()V

    .local v1, "lp":Landroid/view/WindowManager$LayoutParams;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "DockView: for "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mPackageName:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/view/WindowManager$LayoutParams;->setTitle(Ljava/lang/CharSequence;)V

    const/16 v3, 0x7d2

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->type:I

    iget-object v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mIconSize:[I

    const/4 v4, 0x0

    aget v3, v3, v4

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->width:I

    iget-object v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mIconSize:[I

    aget v3, v3, v7

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->height:I

    iput p1, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    const/4 v3, 0x0

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->alpha:F

    iget v3, v1, Landroid/view/WindowManager$LayoutParams;->height:I

    div-int/lit8 v3, v3, 0x2

    sub-int v3, p2, v3

    invoke-direct {p0, v3}, Lcom/lge/dockservice/DockWindowService$DockView;->isInSystemArea(I)I

    move-result v2

    .local v2, "mIsInSystemArea":I
    iget-object v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    invoke-virtual {v3}, Lcom/lge/dockservice/DockWindowService;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .local v0, "dm":Landroid/util/DisplayMetrics;
    if-ne v2, v7, :cond_0

    iget-object v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mResources:Landroid/content/res/Resources;
    invoke-static {v3}, Lcom/lge/dockservice/DockWindowService;->access$1900(Lcom/lge/dockservice/DockWindowService;)Landroid/content/res/Resources;

    move-result-object v3

    const v4, 0x7f060009

    invoke-virtual {v3, v4}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v3

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->y:I

    :goto_0
    const/4 v3, -0x3

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->format:I

    const v3, 0x800033

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->gravity:I

    const v3, 0x10108

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->flags:I

    iget v3, v1, Landroid/view/WindowManager$LayoutParams;->flags:I

    const v4, -0x20001

    and-int/2addr v3, v4

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->flags:I

    new-instance v3, Landroid/os/Binder;

    invoke-direct {v3}, Landroid/os/Binder;-><init>()V

    iput-object v3, v1, Landroid/view/WindowManager$LayoutParams;->token:Landroid/os/IBinder;

    iget v3, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    iput v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosX:I

    iget v3, v1, Landroid/view/WindowManager$LayoutParams;->y:I

    iput v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosY:I

    iget-object v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mWindowManager:Landroid/view/WindowManager;
    invoke-static {v3}, Lcom/lge/dockservice/DockWindowService;->access$1600(Lcom/lge/dockservice/DockWindowService;)Landroid/view/WindowManager;

    move-result-object v3

    invoke-interface {v3, p0, v1}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    return-void

    :cond_0
    const/4 v3, 0x2

    if-ne v2, v3, :cond_1

    iget v3, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->y:I

    goto :goto_0

    :cond_1
    iput p2, v1, Landroid/view/WindowManager$LayoutParams;->y:I

    goto :goto_0
.end method

.method private sleep()V
    .locals 5

    .prologue
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v2

    const-string v3, "sleep dock"

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/dockservice/DockWindowService$DockView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    check-cast v1, Landroid/view/WindowManager$LayoutParams;

    .local v1, "lp":Landroid/view/WindowManager$LayoutParams;
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Dock ( "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mPackageName:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " ) go to sleep"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v2, 0x0

    iput v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mState:I

    :try_start_0
    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mClient:Lcom/lge/dockservice/IBaseDockWindow;

    iget v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mState:I

    invoke-interface {v2, v3}, Lcom/lge/dockservice/IBaseDockWindow;->updateDockState(I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    const/4 v2, 0x0

    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->alpha:F

    iget v2, v1, Landroid/view/WindowManager$LayoutParams;->flags:I

    or-int/lit8 v2, v2, 0x10

    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->flags:I

    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mWindowManager:Landroid/view/WindowManager;
    invoke-static {v2}, Lcom/lge/dockservice/DockWindowService;->access$1600(Lcom/lge/dockservice/DockWindowService;)Landroid/view/WindowManager;

    move-result-object v2

    invoke-interface {v2, p0, v1}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "RemoteException in awake: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Landroid/os/RemoteException;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private slideTo(II)V
    .locals 1
    .param p1, "x"    # I
    .param p2, "y"    # I

    .prologue
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Lcom/lge/dockservice/DockWindowService$DockView;->slideTo(IILcom/lge/dockservice/TransitionAnimator$UpdateListener;)V

    return-void
.end method

.method private slideTo(IILcom/lge/dockservice/TransitionAnimator$UpdateListener;)V
    .locals 5
    .param p1, "x"    # I
    .param p2, "y"    # I
    .param p3, "listener"    # Lcom/lge/dockservice/TransitionAnimator$UpdateListener;

    .prologue
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "slideTo ( "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosX:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " , "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosY:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " ) to ("

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

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mSlidingAnimator:Lcom/lge/dockservice/TransitionAnimator;

    invoke-virtual {v2}, Lcom/lge/dockservice/TransitionAnimator;->isStarted()Z

    move-result v2

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mSlidingAnimator:Lcom/lge/dockservice/TransitionAnimator;

    invoke-virtual {v2}, Lcom/lge/dockservice/TransitionAnimator;->isRunning()Z

    move-result v2

    if-eqz v2, :cond_1

    :cond_0
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v2

    const-string v3, "preceding slideTo animation ends"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mSlidingAnimator:Lcom/lge/dockservice/TransitionAnimator;

    invoke-virtual {v2}, Lcom/lge/dockservice/TransitionAnimator;->end()V

    :cond_1
    move-object v0, p3

    .local v0, "animatorListener":Lcom/lge/dockservice/TransitionAnimator$UpdateListener;
    invoke-virtual {p0}, Lcom/lge/dockservice/DockWindowService$DockView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    check-cast v1, Landroid/view/WindowManager$LayoutParams;

    .local v1, "params":Landroid/view/WindowManager$LayoutParams;
    iget v2, v1, Landroid/view/WindowManager$LayoutParams;->x:I

    iput v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosX:I

    iget v2, v1, Landroid/view/WindowManager$LayoutParams;->y:I

    iput v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosY:I

    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mSlidingAnimator:Lcom/lge/dockservice/TransitionAnimator;

    iget v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosX:I

    invoke-virtual {v2, v3, p1}, Lcom/lge/dockservice/TransitionAnimator;->setRangeX(II)V

    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mSlidingAnimator:Lcom/lge/dockservice/TransitionAnimator;

    iget v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosY:I

    invoke-virtual {v2, v3, p2}, Lcom/lge/dockservice/TransitionAnimator;->setRangeY(II)V

    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mSlidingAnimator:Lcom/lge/dockservice/TransitionAnimator;

    new-instance v3, Lcom/lge/dockservice/DockWindowService$DockView$4;

    invoke-direct {v3, p0, v0}, Lcom/lge/dockservice/DockWindowService$DockView$4;-><init>(Lcom/lge/dockservice/DockWindowService$DockView;Lcom/lge/dockservice/TransitionAnimator$UpdateListener;)V

    invoke-virtual {v2, v3}, Lcom/lge/dockservice/TransitionAnimator;->setUpdateListener(Lcom/lge/dockservice/TransitionAnimator$UpdateListener;)V

    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mSlidingAnimator:Lcom/lge/dockservice/TransitionAnimator;

    invoke-virtual {v2}, Lcom/lge/dockservice/TransitionAnimator;->start()V

    return-void
.end method


# virtual methods
.method public applyLowProfile(Z)V
    .locals 11
    .param p1, "isEntering"    # Z

    .prologue
    const/4 v10, 0x2

    const/4 v9, 0x1

    const/4 v8, 0x0

    const/high16 v5, 0x3f800000    # 1.0f

    const/4 v1, 0x0

    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v4

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "applyLowProfile... isEntering : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v4, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-boolean v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mIsInLowProfile:Z

    if-eqz v4, :cond_0

    if-eqz p1, :cond_0

    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v4

    const-string v5, "dock views are already in low profile"

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    iget-boolean v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mIsInLowProfile:Z

    if-nez v4, :cond_1

    if-nez p1, :cond_1

    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v4

    const-string v5, "dock views are already not in low profile"

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_1
    if-eqz p1, :cond_2

    iget-boolean v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mHasTouchDownConfirmed:Z

    if-eqz v4, :cond_2

    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v4

    const-string v6, "entering low profile while dockview is being touched... do like touch cancel"

    invoke-static {v4, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0, v9}, Lcom/lge/dockservice/DockWindowService$DockView;->attachToWall(Z)V

    iput-boolean v8, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mHasTouchDownConfirmed:Z

    :cond_2
    iget v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mState:I

    if-eq v4, v10, :cond_3

    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "ignore applyLowProfile("

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ") when dock view is not in dock state "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_3
    iget-object v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mAlphaAnimator:Landroid/animation/ValueAnimator;

    if-eqz v4, :cond_5

    iget-object v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mAlphaAnimator:Landroid/animation/ValueAnimator;

    invoke-virtual {v4}, Landroid/animation/ValueAnimator;->isStarted()Z

    move-result v4

    if-nez v4, :cond_4

    iget-object v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mAlphaAnimator:Landroid/animation/ValueAnimator;

    invoke-virtual {v4}, Landroid/animation/ValueAnimator;->isRunning()Z

    move-result v4

    if-eqz v4, :cond_5

    :cond_4
    :try_start_0
    iget-object v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mAlphaAnimator:Landroid/animation/ValueAnimator;

    invoke-virtual {v4}, Landroid/animation/ValueAnimator;->cancel()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_1
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v6

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "on anim cancel by "

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    if-eqz p1, :cond_6

    const-string v4, "enter"

    :goto_2
    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v6, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :cond_5
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v6

    if-eqz p1, :cond_7

    const-string v4, "enter"

    :goto_3
    invoke-static {v6, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    move-object v3, p0

    .local v3, "targetView":Landroid/view/View;
    if-eqz p1, :cond_8

    move v2, v5

    .local v2, "startAlpha":F
    :goto_4
    if-eqz p1, :cond_9

    .local v1, "endAlpha":F
    :goto_5
    new-array v4, v10, [F

    aput v2, v4, v8

    aput v1, v4, v9

    invoke-static {v4}, Landroid/animation/ValueAnimator;->ofFloat([F)Landroid/animation/ValueAnimator;

    move-result-object v4

    iput-object v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mAlphaAnimator:Landroid/animation/ValueAnimator;

    iget-object v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mAlphaAnimator:Landroid/animation/ValueAnimator;

    iget-object v5, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mResources:Landroid/content/res/Resources;
    invoke-static {v5}, Lcom/lge/dockservice/DockWindowService;->access$1900(Lcom/lge/dockservice/DockWindowService;)Landroid/content/res/Resources;

    move-result-object v5

    const v6, 0x7f080008

    invoke-virtual {v5, v6}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v5

    int-to-long v6, v5

    invoke-virtual {v4, v6, v7}, Landroid/animation/ValueAnimator;->setDuration(J)Landroid/animation/ValueAnimator;

    iget-object v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mAlphaAnimator:Landroid/animation/ValueAnimator;

    new-instance v5, Landroid/view/animation/LinearInterpolator;

    invoke-direct {v5}, Landroid/view/animation/LinearInterpolator;-><init>()V

    invoke-virtual {v4, v5}, Landroid/animation/ValueAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)V

    iget-object v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mAlphaAnimator:Landroid/animation/ValueAnimator;

    new-instance v5, Lcom/lge/dockservice/DockWindowService$DockView$1;

    invoke-direct {v5, p0, v3}, Lcom/lge/dockservice/DockWindowService$DockView$1;-><init>(Lcom/lge/dockservice/DockWindowService$DockView;Landroid/view/View;)V

    invoke-virtual {v4, v5}, Landroid/animation/ValueAnimator;->addUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    iget-object v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mAlphaAnimator:Landroid/animation/ValueAnimator;

    new-instance v5, Lcom/lge/dockservice/DockWindowService$DockView$2;

    invoke-direct {v5, p0, v3, v1}, Lcom/lge/dockservice/DockWindowService$DockView$2;-><init>(Lcom/lge/dockservice/DockWindowService$DockView;Landroid/view/View;F)V

    invoke-virtual {v4, v5}, Landroid/animation/ValueAnimator;->addListener(Landroid/animation/Animator$AnimatorListener;)V

    iget-object v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mAlphaAnimator:Landroid/animation/ValueAnimator;

    invoke-virtual {v4}, Landroid/animation/ValueAnimator;->start()V

    iput-boolean p1, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mIsInLowProfile:Z

    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "onAnimationStart / mIsInLowProfile : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-boolean v6, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mIsInLowProfile:Z

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .end local v1    # "endAlpha":F
    .end local v2    # "startAlpha":F
    .end local v3    # "targetView":Landroid/view/View;
    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v4

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, ""

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v0}, Ljava/lang/Exception;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v4, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_1

    .end local v0    # "e":Ljava/lang/Exception;
    :cond_6
    const-string v4, "exit"

    goto/16 :goto_2

    :cond_7
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "exit low profile for dockview "

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v7, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mPackageName:Ljava/lang/String;

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    goto/16 :goto_3

    .restart local v3    # "targetView":Landroid/view/View;
    :cond_8
    move v2, v1

    goto/16 :goto_4

    .restart local v2    # "startAlpha":F
    :cond_9
    move v1, v5

    goto/16 :goto_5
.end method

.method public killdock()V
    .locals 4

    .prologue
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "execute killdock for "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mPackageName:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # invokes: Lcom/lge/dockservice/DockWindowService;->removeViewInUiThread(Landroid/view/View;)V
    invoke-static {v1, p0}, Lcom/lge/dockservice/DockWindowService;->access$600(Lcom/lge/dockservice/DockWindowService;Landroid/view/View;)V

    iget-object v1, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mTopDockView:Lcom/lge/dockservice/DockWindowService$DockView;
    invoke-static {v1}, Lcom/lge/dockservice/DockWindowService;->access$1000(Lcom/lge/dockservice/DockWindowService;)Lcom/lge/dockservice/DockWindowService$DockView;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mTopDockView:Lcom/lge/dockservice/DockWindowService$DockView;
    invoke-static {v1}, Lcom/lge/dockservice/DockWindowService;->access$1000(Lcom/lge/dockservice/DockWindowService;)Lcom/lge/dockservice/DockWindowService$DockView;

    move-result-object v1

    if-ne v1, p0, :cond_0

    iget-object v1, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    const/4 v2, 0x0

    # setter for: Lcom/lge/dockservice/DockWindowService;->mTopDockView:Lcom/lge/dockservice/DockWindowService$DockView;
    invoke-static {v1, v2}, Lcom/lge/dockservice/DockWindowService;->access$1002(Lcom/lge/dockservice/DockWindowService;Lcom/lge/dockservice/DockWindowService$DockView;)Lcom/lge/dockservice/DockWindowService$DockView;

    :cond_0
    iget-object v1, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mDockViewList:Ljava/util/Map;
    invoke-static {v1}, Lcom/lge/dockservice/DockWindowService;->access$100(Lcom/lge/dockservice/DockWindowService;)Ljava/util/Map;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mPackageName:Ljava/lang/String;

    invoke-interface {v1, v2}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    const/4 v1, 0x0

    iput v1, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mState:I

    :try_start_0
    iget-object v1, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mClient:Lcom/lge/dockservice/IBaseDockWindow;

    iget v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mState:I

    invoke-interface {v1, v2}, Lcom/lge/dockservice/IBaseDockWindow;->updateDockState(I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "killdock : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Landroid/os/RemoteException;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public moveToTop()V
    .locals 9

    .prologue
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "move "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mPackageName:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " DockView to top"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/dockservice/DockWindowService$DockView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v2

    check-cast v2, Landroid/view/WindowManager$LayoutParams;

    .local v2, "params":Landroid/view/WindowManager$LayoutParams;
    # getter for: Lcom/lge/dockservice/DockWindowService;->sMoveWindowTokenToTopMethodEx:Ljava/lang/reflect/Method;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$2300()Ljava/lang/reflect/Method;

    move-result-object v4

    if-eqz v4, :cond_0

    :try_start_0
    # getter for: Lcom/lge/dockservice/DockWindowService;->sMoveWindowTokenToTopMethodEx:Ljava/lang/reflect/Method;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$2300()Ljava/lang/reflect/Method;

    move-result-object v4

    # getter for: Lcom/lge/dockservice/DockWindowService;->sIWindowManager:Ljava/lang/Object;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$2400()Ljava/lang/Object;

    move-result-object v5

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v7, 0x0

    iget-object v8, v2, Landroid/view/WindowManager$LayoutParams;->token:Landroid/os/IBinder;

    aput-object v8, v6, v7

    invoke-virtual {v4, v5, v6}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v4

    const-string v5, "sMoveWindowTokenToTopMethodEx called!"

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v3, Landroid/view/View;

    invoke-virtual {p0}, Lcom/lge/dockservice/DockWindowService$DockView;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-direct {v3, v4}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .local v3, "v":Landroid/view/View;
    new-instance v1, Landroid/view/WindowManager$LayoutParams;

    invoke-direct {v1}, Landroid/view/WindowManager$LayoutParams;-><init>()V

    .local v1, "p":Landroid/view/WindowManager$LayoutParams;
    invoke-virtual {v1, v2}, Landroid/view/WindowManager$LayoutParams;->copyFrom(Landroid/view/WindowManager$LayoutParams;)I

    const/4 v4, 0x0

    iput v4, v1, Landroid/view/WindowManager$LayoutParams;->width:I

    const/4 v4, 0x0

    iput v4, v1, Landroid/view/WindowManager$LayoutParams;->height:I

    iget-object v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mWindowManager:Landroid/view/WindowManager;
    invoke-static {v4}, Lcom/lge/dockservice/DockWindowService;->access$1600(Lcom/lge/dockservice/DockWindowService;)Landroid/view/WindowManager;

    move-result-object v4

    invoke-interface {v4, v3, v1}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mWindowManager:Landroid/view/WindowManager;
    invoke-static {v4}, Lcom/lge/dockservice/DockWindowService;->access$1600(Lcom/lge/dockservice/DockWindowService;)Landroid/view/WindowManager;

    move-result-object v4

    invoke-interface {v4, v3}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "p":Landroid/view/WindowManager$LayoutParams;
    .end local v3    # "v":Landroid/view/View;
    :goto_0
    iget-object v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # setter for: Lcom/lge/dockservice/DockWindowService;->mTopDockView:Lcom/lge/dockservice/DockWindowService$DockView;
    invoke-static {v4, p0}, Lcom/lge/dockservice/DockWindowService;->access$1002(Lcom/lge/dockservice/DockWindowService;Lcom/lge/dockservice/DockWindowService$DockView;)Lcom/lge/dockservice/DockWindowService$DockView;

    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v4

    const-string v5, "cannot move to top using moveWindowTokenToTopMethod."

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    iget-object v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mWindowManager:Landroid/view/WindowManager;
    invoke-static {v4}, Lcom/lge/dockservice/DockWindowService;->access$1600(Lcom/lge/dockservice/DockWindowService;)Landroid/view/WindowManager;

    move-result-object v4

    invoke-interface {v4, p0}, Landroid/view/WindowManager;->removeViewImmediate(Landroid/view/View;)V

    iget-object v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mWindowManager:Landroid/view/WindowManager;
    invoke-static {v4}, Lcom/lge/dockservice/DockWindowService;->access$1600(Lcom/lge/dockservice/DockWindowService;)Landroid/view/WindowManager;

    move-result-object v4

    invoke-virtual {p0}, Lcom/lge/dockservice/DockWindowService$DockView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v5

    invoke-interface {v4, p0, v5}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_0
.end method

.method protected onAttachedToWindow()V
    .locals 6

    .prologue
    const/4 v5, 0x1

    const/4 v4, -0x1

    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "onAttachedToWindow DockView : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mPackageName:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget v1, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosX:I

    if-ne v1, v4, :cond_0

    iget v1, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosY:I

    if-eq v1, v4, :cond_1

    :cond_0
    invoke-virtual {p0}, Lcom/lge/dockservice/DockWindowService$DockView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager$LayoutParams;

    .local v0, "params":Landroid/view/WindowManager$LayoutParams;
    iget v1, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosX:I

    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mIconSize:[I

    const/4 v3, 0x0

    aget v2, v2, v3

    div-int/lit8 v2, v2, 0x2

    add-int/2addr v1, v2

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object v1, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mWindowManager:Landroid/view/WindowManager;
    invoke-static {v1}, Lcom/lge/dockservice/DockWindowService;->access$1600(Lcom/lge/dockservice/DockWindowService;)Landroid/view/WindowManager;

    move-result-object v1

    invoke-interface {v1, p0, v0}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .end local v0    # "params":Landroid/view/WindowManager$LayoutParams;
    :cond_1
    iget-object v1, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # invokes: Lcom/lge/dockservice/DockWindowService;->updateDockByLocation(Lcom/lge/dockservice/DockWindowService$DockView;Z)V
    invoke-static {v1, p0, v5}, Lcom/lge/dockservice/DockWindowService;->access$2000(Lcom/lge/dockservice/DockWindowService;Lcom/lge/dockservice/DockWindowService$DockView;Z)V

    iget-object v1, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    iput-boolean v5, v1, Lcom/lge/dockservice/DockWindowService;->refreshDockAxis:Z

    invoke-super {p0}, Landroid/widget/ImageView;->onAttachedToWindow()V

    return-void
.end method

.method protected onDetachedFromWindow()V
    .locals 3

    .prologue
    invoke-super {p0}, Landroid/widget/ImageView;->onDetachedFromWindow()V

    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onDetachedFromWindow DockView : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mPackageName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 10
    .param p1, "e"    # Landroid/view/MotionEvent;

    .prologue
    const/4 v9, -0x1

    const/4 v4, 0x0

    const/4 v3, 0x1

    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v5

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "onTouchEvent : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-boolean v5, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mIsInLowProfile:Z

    if-eqz v5, :cond_0

    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "ignore touch event "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " while in low profile"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v3

    :cond_0
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v5

    const/4 v6, 0x2

    if-lt v5, v6, :cond_1

    move v3, v4

    goto :goto_0

    :cond_1
    invoke-virtual {p1, v4}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v5

    if-eqz v5, :cond_2

    invoke-virtual {p1, v3}, Landroid/view/MotionEvent;->setAction(I)V

    :cond_2
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v5

    if-nez v5, :cond_5

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v5

    float-to-int v5, v5

    iput v5, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDownX:I

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v5

    float-to-int v5, v5

    iput v5, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDownY:I

    iget-object v5, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mGestureDetector:Landroid/view/GestureDetector;

    invoke-virtual {v5, p1}, Landroid/view/GestureDetector;->onTouchEvent(Landroid/view/MotionEvent;)Z

    :cond_3
    :goto_1
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v5

    packed-switch v5, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "ACTION_DOWN - "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mPackageName:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " mDockDirection : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDockDirection:I

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iput-boolean v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mHasTouchDownConfirmed:Z

    iget v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDockDirection:I

    if-eq v4, v9, :cond_4

    iput-boolean v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mStartedAsDock:Z

    :cond_4
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v4

    float-to-int v4, v4

    iput v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDockViewTouchOffsetX:I

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v4

    float-to-int v4, v4

    iput v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDockViewTouchOffsetY:I

    invoke-virtual {p0}, Lcom/lge/dockservice/DockWindowService$DockView;->moveToTop()V

    iget-object v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    iput-boolean v3, v4, Lcom/lge/dockservice/DockWindowService;->refreshDockAxis:Z

    goto :goto_0

    :cond_5
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v5

    float-to-int v5, v5

    iget v6, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDownX:I

    sub-int/2addr v5, v6

    invoke-static {v5}, Ljava/lang/Math;->abs(I)I

    move-result v1

    .local v1, "xMove":I
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v5

    float-to-int v5, v5

    iget v6, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDownY:I

    sub-int/2addr v5, v6

    invoke-static {v5}, Ljava/lang/Math;->abs(I)I

    move-result v2

    .local v2, "yMove":I
    iget-object v5, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mResources:Landroid/content/res/Resources;
    invoke-static {v5}, Lcom/lge/dockservice/DockWindowService;->access$1900(Lcom/lge/dockservice/DockWindowService;)Landroid/content/res/Resources;

    move-result-object v5

    const v6, 0x7f060011

    invoke-virtual {v5, v6}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    .local v0, "slop":I
    if-gt v1, v0, :cond_6

    if-le v2, v0, :cond_7

    :cond_6
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v5

    const-string v6, "prevent send touch event to guestureDetector"

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    :cond_7
    iget-object v5, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mGestureDetector:Landroid/view/GestureDetector;

    invoke-virtual {v5, p1}, Landroid/view/GestureDetector;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v5

    if-eqz v5, :cond_3

    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v4

    const-string v5, "mGestureDetector consumed touch event"

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .end local v0    # "slop":I
    .end local v1    # "xMove":I
    .end local v2    # "yMove":I
    :pswitch_1
    iget-boolean v5, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mHasTouchDownConfirmed:Z

    if-nez v5, :cond_8

    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v4

    const-string v5, "ignore touch move without preceding touch down"

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :cond_8
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v5

    float-to-int v5, v5

    iget v6, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDockViewTouchOffsetY:I

    sub-int/2addr v5, v6

    invoke-direct {p0, v5}, Lcom/lge/dockservice/DockWindowService$DockView;->isInSystemArea(I)I

    move-result v5

    if-lez v5, :cond_9

    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v4

    const-string v5, "In system Area. Do not handle move."

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :cond_9
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v5

    float-to-int v5, v5

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v6

    float-to-int v6, v6

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v7

    float-to-int v7, v7

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v8

    float-to-int v8, v8

    invoke-direct {p0, v5, v6, v7, v8}, Lcom/lge/dockservice/DockWindowService$DockView;->isInDockArea(IIII)I

    move-result v5

    iput v5, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDockDirection:I

    iget v5, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDockDirection:I

    invoke-direct {p0, v5}, Lcom/lge/dockservice/DockWindowService$DockView;->handleDockBackGround(I)V

    iget-boolean v5, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mStartedAsDock:Z

    if-eqz v5, :cond_a

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v4

    float-to-int v4, v4

    iget v5, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDockViewTouchOffsetX:I

    sub-int/2addr v4, v5

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v5

    float-to-int v5, v5

    iget v6, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDockViewTouchOffsetY:I

    sub-int/2addr v5, v6

    invoke-direct {p0, v4, v5}, Lcom/lge/dockservice/DockWindowService$DockView;->moveTo(II)V

    goto/16 :goto_0

    :cond_a
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v5

    float-to-int v5, v5

    iget-object v6, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mIconSize:[I

    aget v4, v6, v4

    div-int/lit8 v4, v4, 0x2

    sub-int v4, v5, v4

    iget v5, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mFingerOffsetX:I

    sub-int/2addr v4, v5

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v5

    float-to-int v5, v5

    iget-object v6, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mIconSize:[I

    aget v6, v6, v3

    sub-int/2addr v5, v6

    iget v6, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mFingerOffsetY:I

    sub-int/2addr v5, v6

    invoke-direct {p0, v4, v5}, Lcom/lge/dockservice/DockWindowService$DockView;->moveTo(II)V

    goto/16 :goto_0

    :pswitch_2
    iget-boolean v5, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mHasTouchDownConfirmed:Z

    if-nez v5, :cond_b

    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v4

    const-string v5, "ignore touch up without preceding touch down"

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :cond_b
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v5

    const-string v6, "DockView ACTION_UP"

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v5

    float-to-int v5, v5

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v6

    float-to-int v6, v6

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v7

    float-to-int v7, v7

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v8

    float-to-int v8, v8

    invoke-direct {p0, v5, v6, v7, v8}, Lcom/lge/dockservice/DockWindowService$DockView;->isInDockArea(IIII)I

    move-result v5

    iput v5, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDockDirection:I

    iget v5, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDockDirection:I

    invoke-direct {p0, v5}, Lcom/lge/dockservice/DockWindowService$DockView;->handleDockBackGround(I)V

    iget v5, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mDockDirection:I

    if-ne v5, v9, :cond_c

    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v5

    const-string v6, "Request Undock"

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget v5, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosX:I

    iget v6, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosY:I

    invoke-virtual {p0, v5, v6}, Lcom/lge/dockservice/DockWindowService$DockView;->undock(II)V

    :goto_2
    iput-boolean v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mHasTouchDownConfirmed:Z

    iput-boolean v4, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mStartedAsDock:Z

    goto/16 :goto_0

    :cond_c
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v5

    const-string v6, "Keep dock state"

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0, v4}, Lcom/lge/dockservice/DockWindowService$DockView;->attachToWall(Z)V

    iget-object v5, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # invokes: Lcom/lge/dockservice/DockWindowService;->updateDockByLocation(Lcom/lge/dockservice/DockWindowService$DockView;Z)V
    invoke-static {v5, p0, v3}, Lcom/lge/dockservice/DockWindowService;->access$2000(Lcom/lge/dockservice/DockWindowService;Lcom/lge/dockservice/DockWindowService$DockView;Z)V

    goto :goto_2

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_2
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method public undock(II)V
    .locals 5
    .param p1, "requestedUndockPositionX"    # I
    .param p2, "requestedUndockPositionY"    # I

    .prologue
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "execute undock at "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/dockservice/DockWindowService$DockView;->sleep()V

    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mTopDockView:Lcom/lge/dockservice/DockWindowService$DockView;
    invoke-static {v2}, Lcom/lge/dockservice/DockWindowService;->access$1000(Lcom/lge/dockservice/DockWindowService;)Lcom/lge/dockservice/DockWindowService$DockView;

    move-result-object v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mTopDockView:Lcom/lge/dockservice/DockWindowService$DockView;
    invoke-static {v2}, Lcom/lge/dockservice/DockWindowService;->access$1000(Lcom/lge/dockservice/DockWindowService;)Lcom/lge/dockservice/DockWindowService$DockView;

    move-result-object v2

    if-ne v2, p0, :cond_0

    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    const/4 v3, 0x0

    # setter for: Lcom/lge/dockservice/DockWindowService;->mTopDockView:Lcom/lge/dockservice/DockWindowService$DockView;
    invoke-static {v2, v3}, Lcom/lge/dockservice/DockWindowService;->access$1002(Lcom/lge/dockservice/DockWindowService;Lcom/lge/dockservice/DockWindowService$DockView;)Lcom/lge/dockservice/DockWindowService$DockView;

    :cond_0
    const/4 v2, 0x0

    iput v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mState:I

    :try_start_0
    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mClient:Lcom/lge/dockservice/IBaseDockWindow;

    iget v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mState:I

    invoke-interface {v2, v3}, Lcom/lge/dockservice/IBaseDockWindow;->updateDockState(I)V

    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mClient:Lcom/lge/dockservice/IBaseDockWindow;

    invoke-interface {v2, p1, p2}, Lcom/lge/dockservice/IBaseDockWindow;->onFinishingUndockAt(II)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Landroid/os/RemoteException;
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Exception occured in undock : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Landroid/os/RemoteException;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v2

    const-string v3, "SendBroadCast to force unDock and stop DockWindowService."

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v1, Landroid/content/Intent;

    const-string v2, "com.lge.intent.action.FORCE_UNDOCK"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v1, "intent":Landroid/content/Intent;
    const-string v2, "windowname"

    iget-object v3, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mPackageName:Ljava/lang/String;

    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v2, "posX"

    invoke-virtual {v1, v2, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v2, "posY"

    invoke-virtual {v1, v2, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    invoke-virtual {v2}, Lcom/lge/dockservice/DockWindowService;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    iget-object v2, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    invoke-virtual {v2}, Lcom/lge/dockservice/DockWindowService;->stopSelf()V

    goto :goto_0
.end method

.method public undockBySingleTabUp()V
    .locals 9

    .prologue
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v6

    const-string v7, "undockBySingleTabUp"

    invoke-static {v6, v7}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    .local v0, "clientRect":Landroid/graphics/Rect;
    :try_start_0
    iget-object v6, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mClient:Lcom/lge/dockservice/IBaseDockWindow;

    invoke-interface {v6}, Lcom/lge/dockservice/IBaseDockWindow;->getClientRect()Landroid/graphics/Rect;
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    new-instance v2, Landroid/util/DisplayMetrics;

    invoke-direct {v2}, Landroid/util/DisplayMetrics;-><init>()V

    .local v2, "displaymetrics":Landroid/util/DisplayMetrics;
    iget-object v6, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mWindowManager:Landroid/view/WindowManager;
    invoke-static {v6}, Lcom/lge/dockservice/DockWindowService;->access$1600(Lcom/lge/dockservice/DockWindowService;)Landroid/view/WindowManager;

    move-result-object v6

    invoke-interface {v6}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v6

    invoke-virtual {v6, v2}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V

    iget v5, v2, Landroid/util/DisplayMetrics;->widthPixels:I

    .local v5, "screenwidth":I
    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v1

    .local v1, "clientWidth":I
    sub-int v6, v5, v1

    div-int/lit8 v4, v6, 0x2

    .local v4, "newPosX":I
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v6

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Start slideTo animation ("

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget v8, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosX:I

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " , "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget v8, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosY:I

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ") to ("

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " , "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget v8, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosY:I

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ")"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget v6, p0, Lcom/lge/dockservice/DockWindowService$DockView;->mCurrentDockPosY:I

    new-instance v7, Lcom/lge/dockservice/DockWindowService$DockView$3;

    invoke-direct {v7, p0, v4}, Lcom/lge/dockservice/DockWindowService$DockView$3;-><init>(Lcom/lge/dockservice/DockWindowService$DockView;I)V

    invoke-direct {p0, v4, v6, v7}, Lcom/lge/dockservice/DockWindowService$DockView;->slideTo(IILcom/lge/dockservice/TransitionAnimator$UpdateListener;)V

    .end local v1    # "clientWidth":I
    .end local v2    # "displaymetrics":Landroid/util/DisplayMetrics;
    .end local v4    # "newPosX":I
    .end local v5    # "screenwidth":I
    :goto_0
    return-void

    :catch_0
    move-exception v3

    .local v3, "e":Landroid/os/RemoteException;
    # getter for: Lcom/lge/dockservice/DockWindowService;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/DockWindowService;->access$000()Ljava/lang/String;

    move-result-object v6

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Exception occured in undockBySingTapUp : "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v3}, Landroid/os/RemoteException;->getMessage()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {v3}, Landroid/os/RemoteException;->printStackTrace()V

    goto :goto_0
.end method

.method updateDockIconImage(Landroid/graphics/Bitmap;)V
    .locals 3
    .param p1, "icon"    # Landroid/graphics/Bitmap;

    .prologue
    iget-object v0, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mResources:Landroid/content/res/Resources;
    invoke-static {v0}, Lcom/lge/dockservice/DockWindowService;->access$1900(Lcom/lge/dockservice/DockWindowService;)Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f06000f

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    iget-object v1, p0, Lcom/lge/dockservice/DockWindowService$DockView;->this$0:Lcom/lge/dockservice/DockWindowService;

    # getter for: Lcom/lge/dockservice/DockWindowService;->mResources:Landroid/content/res/Resources;
    invoke-static {v1}, Lcom/lge/dockservice/DockWindowService;->access$1900(Lcom/lge/dockservice/DockWindowService;)Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x7f060010

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v1

    const/4 v2, 0x1

    invoke-static {p1, v0, v1, v2}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/lge/dockservice/DockWindowService$DockView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    return-void
.end method
