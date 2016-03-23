.class public Lcom/lge/app/floating/FloatingDockWindow;
.super Lcom/lge/dockservice/BaseDockWindow;
.source "FloatingDockWindow.java"


# static fields
.field private static final RES_PACKAGE_NAME:Ljava/lang/String; = "com.lge.app.floating.res"

.field private static final TAG:Ljava/lang/String; = "FloatingDockWindow"


# instance fields
.field public appName:Ljava/lang/String;

.field private final mContext:Landroid/content/Context;

.field private final mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

.field private mFwm:Lcom/lge/app/floating/FloatingWindowManager;

.field private mHandler:Landroid/os/Handler;

.field private mIsTitleHidden:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/lge/app/floating/FloatingWindow;)V
    .locals 6
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "floatingWindow"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    const/4 v3, 0x0

    const/4 v5, 0x0

    invoke-virtual {p2}, Lcom/lge/app/floating/FloatingWindow;->getWindowName()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, p1, v2}, Lcom/lge/dockservice/BaseDockWindow;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    iput-object v3, p0, Lcom/lge/app/floating/FloatingDockWindow;->mHandler:Landroid/os/Handler;

    invoke-static {v3}, Lcom/lge/app/floating/FloatingWindowManager;->getDefault(Landroid/content/Context;)Lcom/lge/app/floating/FloatingWindowManager;

    move-result-object v2

    iput-object v2, p0, Lcom/lge/app/floating/FloatingDockWindow;->mFwm:Lcom/lge/app/floating/FloatingWindowManager;

    iput-boolean v5, p0, Lcom/lge/app/floating/FloatingDockWindow;->mIsTitleHidden:Z

    iput-object p1, p0, Lcom/lge/app/floating/FloatingDockWindow;->mContext:Landroid/content/Context;

    iput-object p2, p0, Lcom/lge/app/floating/FloatingDockWindow;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    new-instance v1, Lcom/lge/app/floating/FloatingDockWindow$1;

    invoke-direct {v1, p0}, Lcom/lge/app/floating/FloatingDockWindow$1;-><init>(Lcom/lge/app/floating/FloatingDockWindow;)V

    .local v1, "touchListener":Landroid/view/View$OnTouchListener;
    iget-object v2, p0, Lcom/lge/app/floating/FloatingDockWindow;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v2}, Lcom/lge/app/floating/FloatingWindow;->getFrameViewInterface()Lcom/lge/app/floating/IFrameView;

    move-result-object v2

    invoke-interface {v2, v1}, Lcom/lge/app/floating/IFrameView;->addListenerToDefaultTouchListener(Landroid/view/View$OnTouchListener;)V

    iget-object v2, p0, Lcom/lge/app/floating/FloatingDockWindow;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v2}, Lcom/lge/app/floating/FloatingWindow;->getTitleViewInterface()Lcom/lge/app/floating/ITitleView;

    move-result-object v2

    invoke-interface {v2, v1}, Lcom/lge/app/floating/ITitleView;->addListenerToDefaultTouchListener(Landroid/view/View$OnTouchListener;)V

    new-instance v2, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v3

    invoke-direct {v2, v3}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v2, p0, Lcom/lge/app/floating/FloatingDockWindow;->mHandler:Landroid/os/Handler;

    iget-object v2, p0, Lcom/lge/app/floating/FloatingDockWindow;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    iget-object v2, v2, Lcom/lge/app/floating/FloatingWindow;->mAppName:Ljava/lang/String;

    iput-object v2, p0, Lcom/lge/app/floating/FloatingDockWindow;->appName:Ljava/lang/String;

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingDockWindow;->getClientRect()Landroid/graphics/Rect;

    move-result-object v0

    .local v0, "r":Landroid/graphics/Rect;
    if-nez v0, :cond_1

    const-string v2, "FloatingDockWindow"

    const-string v3, "Cannot setDockable - Fail to getClientRect == null"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v2

    if-lez v2, :cond_2

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v2

    if-gtz v2, :cond_0

    :cond_2
    const-string v2, "FloatingDockWindow"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "inappropriate client rect="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p2}, Lcom/lge/app/floating/FloatingWindow;->getWindowName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " will not be able to dock"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0, v5}, Lcom/lge/app/floating/FloatingDockWindow;->setDockable(Z)V

    goto :goto_0
.end method

.method static synthetic access$000(Lcom/lge/app/floating/FloatingDockWindow;)Lcom/lge/app/floating/FloatingWindowManager;
    .locals 1
    .param p0, "x0"    # Lcom/lge/app/floating/FloatingDockWindow;

    .prologue
    iget-object v0, p0, Lcom/lge/app/floating/FloatingDockWindow;->mFwm:Lcom/lge/app/floating/FloatingWindowManager;

    return-object v0
.end method

.method static synthetic access$100(Lcom/lge/app/floating/FloatingDockWindow;)Lcom/lge/app/floating/FloatingWindow;
    .locals 1
    .param p0, "x0"    # Lcom/lge/app/floating/FloatingDockWindow;

    .prologue
    iget-object v0, p0, Lcom/lge/app/floating/FloatingDockWindow;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    return-object v0
.end method


# virtual methods
.method public getAppName()Ljava/lang/String;
    .locals 3

    .prologue
    const-string v0, "FloatingDockWindow"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getAppName : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/app/floating/FloatingDockWindow;->appName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/lge/app/floating/FloatingDockWindow;->appName:Ljava/lang/String;

    return-object v0
.end method

.method public getClientPackageName()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/app/floating/FloatingDockWindow;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getClientPadding()Landroid/graphics/Rect;
    .locals 6

    .prologue
    iget-object v5, p0, Lcom/lge/app/floating/FloatingDockWindow;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v5}, Lcom/lge/app/floating/FloatingWindow;->getFrameViewInterface()Lcom/lge/app/floating/IFrameView;

    move-result-object v5

    invoke-interface {v5}, Lcom/lge/app/floating/IFrameView;->getPadding()Landroid/graphics/Rect;

    move-result-object v0

    .local v0, "frameViewPadding":Landroid/graphics/Rect;
    iget v2, v0, Landroid/graphics/Rect;->left:I

    .local v2, "pLeft":I
    iget v3, v0, Landroid/graphics/Rect;->right:I

    .local v3, "pRight":I
    iget-object v5, p0, Lcom/lge/app/floating/FloatingDockWindow;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v5}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v5

    invoke-virtual {v5}, Landroid/view/View;->getPaddingTop()I

    move-result v4

    .local v4, "pTop":I
    iget v1, v0, Landroid/graphics/Rect;->bottom:I

    .local v1, "pBottom":I
    new-instance v5, Landroid/graphics/Rect;

    invoke-direct {v5, v2, v3, v4, v1}, Landroid/graphics/Rect;-><init>(IIII)V

    return-object v5
.end method

.method public getClientRect()Landroid/graphics/Rect;
    .locals 14

    .prologue
    const/4 v13, 0x2

    const/4 v12, 0x1

    const/4 v11, 0x0

    iget-object v9, p0, Lcom/lge/app/floating/FloatingDockWindow;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v9}, Lcom/lge/app/floating/FloatingWindow;->getFrameView()Landroid/view/View;

    move-result-object v2

    .local v2, "frameView":Landroid/view/View;
    iget-object v9, p0, Lcom/lge/app/floating/FloatingDockWindow;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v9}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v6

    .local v6, "titleView":Landroid/view/View;
    invoke-virtual {v2}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    check-cast v1, Landroid/view/WindowManager$LayoutParams;

    .local v1, "frameParams":Landroid/view/WindowManager$LayoutParams;
    invoke-virtual {v6}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v5

    check-cast v5, Landroid/view/WindowManager$LayoutParams;

    .local v5, "titleParams":Landroid/view/WindowManager$LayoutParams;
    iget v8, v5, Landroid/view/WindowManager$LayoutParams;->width:I

    .local v8, "width":I
    iget v9, v1, Landroid/view/WindowManager$LayoutParams;->height:I

    iget v10, v5, Landroid/view/WindowManager$LayoutParams;->height:I

    add-int v4, v9, v10

    .local v4, "height":I
    new-array v7, v13, [I

    .local v7, "titleViewLocation":[I
    invoke-virtual {v6, v7}, Landroid/view/View;->getLocationOnScreen([I)V

    new-array v3, v13, [I

    .local v3, "frameViewLocation":[I
    invoke-virtual {v2, v3}, Landroid/view/View;->getLocationOnScreen([I)V

    new-instance v0, Landroid/graphics/Rect;

    aget v9, v3, v11

    aget v10, v7, v12

    aget v11, v3, v11

    add-int/2addr v11, v8

    aget v12, v7, v12

    add-int/2addr v12, v4

    invoke-direct {v0, v9, v10, v11, v12}, Landroid/graphics/Rect;-><init>(IIII)V

    .local v0, "clientRect":Landroid/graphics/Rect;
    const-string v9, "FloatingDockWindow"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "getClientRect : ( "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget v11, v0, Landroid/graphics/Rect;->left:I

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, " , "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget v11, v0, Landroid/graphics/Rect;->top:I

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, " , "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget v11, v0, Landroid/graphics/Rect;->right:I

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, " , "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget v11, v0, Landroid/graphics/Rect;->bottom:I

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, " )"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-object v0
.end method

.method public getDockIconBitmap()Landroid/graphics/Bitmap;
    .locals 13

    .prologue
    const/4 v12, 0x0

    const v11, 0x7f060010

    const v9, 0x7f06000f

    const/4 v10, 0x1

    iget-object v7, p0, Lcom/lge/app/floating/FloatingDockWindow;->mContext:Landroid/content/Context;

    invoke-static {v7}, Lcom/lge/app/floating/Res;->getResources(Landroid/content/Context;)Landroid/content/res/Resources;

    move-result-object v6

    .local v6, "res":Landroid/content/res/Resources;
    iget-object v7, p0, Lcom/lge/app/floating/FloatingDockWindow;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v7}, Lcom/lge/app/floating/FloatingWindow;->getDockViewBitmap()Landroid/graphics/Bitmap;

    move-result-object v2

    .local v2, "appIconBitmap":Landroid/graphics/Bitmap;
    if-nez v2, :cond_1

    iget-object v7, p0, Lcom/lge/app/floating/FloatingDockWindow;->mContext:Landroid/content/Context;

    invoke-virtual {v7}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    .local v0, "ai":Landroid/content/pm/ApplicationInfo;
    iget-object v7, p0, Lcom/lge/app/floating/FloatingDockWindow;->mContext:Landroid/content/Context;

    invoke-virtual {v7}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v7

    invoke-virtual {v7, v0}, Landroid/content/pm/PackageManager;->getApplicationIcon(Landroid/content/pm/ApplicationInfo;)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    check-cast v1, Landroid/graphics/drawable/BitmapDrawable;

    .local v1, "appIcon":Landroid/graphics/drawable/BitmapDrawable;
    if-nez v1, :cond_0

    const-string v7, "FloatingDockWindow"

    const-string v8, "generate dummy dock preview"

    invoke-static {v7, v8}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v7, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v9, v11, v7}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v2

    const v7, -0x333301

    invoke-virtual {v2, v7}, Landroid/graphics/Bitmap;->eraseColor(I)V

    .end local v0    # "ai":Landroid/content/pm/ApplicationInfo;
    .end local v1    # "appIcon":Landroid/graphics/drawable/BitmapDrawable;
    :goto_0
    new-instance v5, Landroid/graphics/Paint;

    invoke-direct {v5}, Landroid/graphics/Paint;-><init>()V

    .local v5, "paint":Landroid/graphics/Paint;
    const v7, 0x7f07000a

    invoke-virtual {v6, v7, v10, v10}, Landroid/content/res/Resources;->getFraction(III)F

    move-result v4

    .local v4, "dockPreviewAlpha":F
    const-string v7, "FloatingDockWindow"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "dockPreviewAlpha: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v4}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    const/high16 v7, 0x437f0000    # 255.0f

    mul-float/2addr v7, v4

    float-to-int v7, v7

    invoke-virtual {v5, v7}, Landroid/graphics/Paint;->setAlpha(I)V

    new-instance v3, Landroid/graphics/Canvas;

    invoke-direct {v3}, Landroid/graphics/Canvas;-><init>()V

    .local v3, "canvas":Landroid/graphics/Canvas;
    invoke-virtual {v3, v2, v12, v12, v5}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;FFLandroid/graphics/Paint;)V

    const-string v7, "FloatingDockWindow"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "dock preview: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    return-object v2

    .end local v3    # "canvas":Landroid/graphics/Canvas;
    .end local v4    # "dockPreviewAlpha":F
    .end local v5    # "paint":Landroid/graphics/Paint;
    .restart local v0    # "ai":Landroid/content/pm/ApplicationInfo;
    .restart local v1    # "appIcon":Landroid/graphics/drawable/BitmapDrawable;
    :cond_0
    invoke-virtual {v1}, Landroid/graphics/drawable/BitmapDrawable;->getBitmap()Landroid/graphics/Bitmap;

    move-result-object v7

    invoke-virtual {v6, v9}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v8

    invoke-virtual {v6, v11}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v9

    invoke-static {v7, v8, v9, v10}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    move-result-object v2

    goto :goto_0

    .end local v0    # "ai":Landroid/content/pm/ApplicationInfo;
    .end local v1    # "appIcon":Landroid/graphics/drawable/BitmapDrawable;
    :cond_1
    invoke-virtual {v6, v9}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v7

    invoke-virtual {v6, v11}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v8

    invoke-static {v2, v7, v8, v10}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    move-result-object v2

    goto :goto_0
.end method

.method public handleTouch(Landroid/view/MotionEvent;)V
    .locals 0
    .param p1, "event"    # Landroid/view/MotionEvent;

    .prologue
    invoke-super {p0, p1}, Lcom/lge/dockservice/BaseDockWindow;->handleTouch(Landroid/view/MotionEvent;)V

    return-void
.end method

.method public isCleanView()I
    .locals 7

    .prologue
    const/4 v0, 0x0

    .local v0, "mIsCleanView":I
    iget-object v4, p0, Lcom/lge/app/floating/FloatingDockWindow;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v4}, Lcom/lge/app/floating/FloatingWindow;->getTitleViewInterface()Lcom/lge/app/floating/ITitleView;

    move-result-object v1

    .local v1, "mTitleView":Lcom/lge/app/floating/ITitleView;
    invoke-interface {v1}, Lcom/lge/app/floating/ITitleView;->getLayoutParams()Landroid/view/WindowManager$LayoutParams;

    move-result-object v2

    .local v2, "titleParams":Landroid/view/WindowManager$LayoutParams;
    iget v4, v2, Landroid/view/WindowManager$LayoutParams;->height:I

    invoke-interface {v1}, Lcom/lge/app/floating/ITitleView;->getPaddingBottom()I

    move-result v5

    sub-int/2addr v4, v5

    invoke-interface {v1}, Lcom/lge/app/floating/ITitleView;->getPaddingTop()I

    move-result v5

    sub-int v3, v4, v5

    .local v3, "titleViewHeight":I
    const-string v4, "FloatingDockWindow"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "titleViewHeight : "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v4, p0, Lcom/lge/app/floating/FloatingDockWindow;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v4}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v4

    iget-boolean v4, v4, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->hideTitle:Z

    if-eqz v4, :cond_0

    iget-object v4, p0, Lcom/lge/app/floating/FloatingDockWindow;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v4}, Lcom/lge/app/floating/FloatingWindow;->isInOverlay()Z

    move-result v4

    if-eqz v4, :cond_1

    const/4 v0, 0x0

    :cond_0
    :goto_0
    return v0

    :cond_1
    move v0, v3

    goto :goto_0
.end method

.method public onDockCompleted(I)V
    .locals 8
    .param p1, "dockDirection"    # I

    .prologue
    const-string v5, "FloatingDockWindow"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "onDockCompleted. Direction : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingDockWindow;->getClientRect()Landroid/graphics/Rect;

    move-result-object v3

    .local v3, "r":Landroid/graphics/Rect;
    if-nez v3, :cond_1

    const-string v5, "FloatingDockWindow"

    const-string v6, "Exception in onDockCompleted : getClientRect == null"

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget-object v5, p0, Lcom/lge/app/floating/FloatingDockWindow;->mContext:Landroid/content/Context;

    const-string v6, "window"

    invoke-virtual {v5, v6}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/view/WindowManager;

    .local v2, "mWindowManager":Landroid/view/WindowManager;
    new-instance v1, Landroid/util/DisplayMetrics;

    invoke-direct {v1}, Landroid/util/DisplayMetrics;-><init>()V

    .local v1, "mDisplaymetrics":Landroid/util/DisplayMetrics;
    invoke-interface {v2}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v5

    invoke-virtual {v5, v1}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V

    iget v4, v1, Landroid/util/DisplayMetrics;->widthPixels:I

    .local v4, "screenWidth":I
    invoke-virtual {v3}, Landroid/graphics/Rect;->width()I

    move-result v0

    .local v0, "floatingWindowWidth":I
    const/4 v5, 0x3

    if-ne p1, v5, :cond_2

    iget-object v5, p0, Lcom/lge/app/floating/FloatingDockWindow;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    iget v6, v3, Landroid/graphics/Rect;->top:I

    invoke-virtual {v5, v4, v6}, Lcom/lge/app/floating/FloatingWindow;->moveInner(II)V

    goto :goto_0

    :cond_2
    const/4 v5, 0x2

    if-ne p1, v5, :cond_0

    iget-object v5, p0, Lcom/lge/app/floating/FloatingDockWindow;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    neg-int v6, v0

    iget v7, v3, Landroid/graphics/Rect;->top:I

    invoke-virtual {v5, v6, v7}, Lcom/lge/app/floating/FloatingWindow;->moveInner(II)V

    goto :goto_0
.end method

.method public onEnterDockArea()V
    .locals 2

    .prologue
    const-string v0, "FloatingDockWindow"

    const-string v1, "onEnterDockArea..  enterLowProfile"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/lge/app/floating/FloatingDockWindow;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v0}, Lcom/lge/app/floating/FloatingWindow;->onDocked()V

    iget-object v0, p0, Lcom/lge/app/floating/FloatingDockWindow;->mHandler:Landroid/os/Handler;

    new-instance v1, Lcom/lge/app/floating/FloatingDockWindow$2;

    invoke-direct {v1, p0}, Lcom/lge/app/floating/FloatingDockWindow$2;-><init>(Lcom/lge/app/floating/FloatingDockWindow;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public onFinishingUndockAt(II)V
    .locals 10
    .param p1, "x"    # I
    .param p2, "y"    # I

    .prologue
    const/4 v6, 0x0

    const-string v5, "FloatingDockWindow"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "onFinishingUndockAt.. "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ", "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v5, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingDockWindow;->getClientRect()Landroid/graphics/Rect;

    move-result-object v4

    .local v4, "r":Landroid/graphics/Rect;
    if-nez v4, :cond_0

    const-string v5, "FloatingDockWindow"

    const-string v6, "Cannot onFinishingUndockAt - Fail to getClientRect == null"

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    const-string v5, "FloatingDockWindow"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "client rect is "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v5, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v5, p0, Lcom/lge/app/floating/FloatingDockWindow;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v5}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParams()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v2

    .local v2, "fParams":Lcom/lge/app/floating/FloatingWindow$LayoutParams;
    if-nez v2, :cond_1

    const-string v5, "FloatingDockWindow"

    const-string v6, "Cannot onFinishingUndockAt - Fail to getLayoutParams() == null"

    invoke-static {v5, v6}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_1
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingDockWindow;->getClientPadding()Landroid/graphics/Rect;

    move-result-object v5

    iget v5, v5, Landroid/graphics/Rect;->left:I

    add-int/2addr p1, v5

    iget-object v5, p0, Lcom/lge/app/floating/FloatingDockWindow;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v5}, Lcom/lge/app/floating/FloatingWindow;->getTitleView()Landroid/view/View;

    move-result-object v5

    invoke-virtual {v5}, Landroid/view/View;->getHeight()I

    move-result v5

    add-int/2addr p2, v5

    const-string v7, "FloatingDockWindow"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "isCleanView() : "

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingDockWindow;->isCleanView()I

    move-result v5

    if-lez v5, :cond_3

    const/4 v5, 0x1

    :goto_1
    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v7, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    iget-boolean v5, p0, Lcom/lge/app/floating/FloatingDockWindow;->mIsTitleHidden:Z

    if-eqz v5, :cond_2

    iget-object v5, p0, Lcom/lge/app/floating/FloatingDockWindow;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v5}, Lcom/lge/app/floating/FloatingWindow;->getTitleViewInterface()Lcom/lge/app/floating/ITitleView;

    move-result-object v3

    .local v3, "mTitleView":Lcom/lge/app/floating/ITitleView;
    invoke-interface {v3}, Lcom/lge/app/floating/ITitleView;->getLayoutParams()Landroid/view/WindowManager$LayoutParams;

    move-result-object v5

    iget v5, v5, Landroid/view/WindowManager$LayoutParams;->height:I

    invoke-interface {v3}, Lcom/lge/app/floating/ITitleView;->getPaddingBottom()I

    move-result v7

    sub-int/2addr v5, v7

    invoke-interface {v3}, Lcom/lge/app/floating/ITitleView;->getPaddingTop()I

    move-result v7

    sub-int/2addr v5, v7

    sub-int/2addr p2, v5

    .end local v3    # "mTitleView":Lcom/lge/app/floating/ITitleView;
    :cond_2
    move v0, p1

    .local v0, "destX":I
    move v1, p2

    .local v1, "destY":I
    iget-object v5, p0, Lcom/lge/app/floating/FloatingDockWindow;->mHandler:Landroid/os/Handler;

    new-instance v7, Lcom/lge/app/floating/FloatingDockWindow$4;

    invoke-direct {v7, p0, v0, v1}, Lcom/lge/app/floating/FloatingDockWindow$4;-><init>(Lcom/lge/app/floating/FloatingDockWindow;II)V

    invoke-virtual {v5, v7}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    iget-object v5, p0, Lcom/lge/app/floating/FloatingDockWindow;->mHandler:Landroid/os/Handler;

    new-instance v7, Lcom/lge/app/floating/FloatingDockWindow$5;

    invoke-direct {v7, p0}, Lcom/lge/app/floating/FloatingDockWindow$5;-><init>(Lcom/lge/app/floating/FloatingDockWindow;)V

    const-wide/16 v8, 0x64

    invoke-virtual {v5, v7, v8, v9}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    iget-object v5, p0, Lcom/lge/app/floating/FloatingDockWindow;->mFloatingWindow:Lcom/lge/app/floating/FloatingWindow;

    sput-boolean v6, Lcom/lge/app/floating/FloatingWindow;->sSavedLocation:Z

    goto/16 :goto_0

    .end local v0    # "destX":I
    .end local v1    # "destY":I
    :cond_3
    move v5, v6

    goto :goto_1
.end method

.method public onLeaveDockArea()V
    .locals 2

    .prologue
    const-string v0, "FloatingDockWindow"

    const-string v1, "onLeaveDockArea.. exitLowProfile"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public onUndockCompleted()V
    .locals 2

    .prologue
    const-string v0, "FloatingDockWindow"

    const-string v1, "onUndockCompleted"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-super {p0}, Lcom/lge/dockservice/BaseDockWindow;->onUndockCompleted()V

    iget-object v0, p0, Lcom/lge/app/floating/FloatingDockWindow;->mHandler:Landroid/os/Handler;

    new-instance v1, Lcom/lge/app/floating/FloatingDockWindow$3;

    invoke-direct {v1, p0}, Lcom/lge/app/floating/FloatingDockWindow$3;-><init>(Lcom/lge/app/floating/FloatingDockWindow;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public updateDockIcon()V
    .locals 1

    .prologue
    invoke-virtual {p0}, Lcom/lge/app/floating/FloatingDockWindow;->getDockIconBitmap()Landroid/graphics/Bitmap;

    move-result-object v0

    .local v0, "newIcon":Landroid/graphics/Bitmap;
    invoke-virtual {p0, v0}, Lcom/lge/app/floating/FloatingDockWindow;->updateDockIcon(Landroid/graphics/Bitmap;)V

    return-void
.end method
