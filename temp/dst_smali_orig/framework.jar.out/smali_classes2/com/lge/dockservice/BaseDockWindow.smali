.class public abstract Lcom/lge/dockservice/BaseDockWindow;
.super Lcom/lge/dockservice/IBaseDockWindow$Stub;
.source "BaseDockWindow.java"

# interfaces
.implements Lcom/lge/dockservice/DockableWindow;


# static fields
.field private static final TAG:Ljava/lang/String; = "DockWindow"


# instance fields
.field private final mActivityName:Ljava/lang/String;

.field private final mContext:Landroid/content/Context;

.field private mDisplaymetrics:Landroid/util/DisplayMetrics;

.field private mDockIconBitmap:Landroid/graphics/Bitmap;

.field private mDockState:I

.field private final mDockWindowManager:Lcom/lge/dockservice/DockWindowManager;

.field private mHasTouchDownConfirmed:Z

.field private mIsDockableClient:Z

.field mRequestedDockDirection:I

.field private mTouchOffsetX:I

.field private mTouchOffsetY:I


# direct methods
.method protected constructor <init>(Landroid/content/Context;Ljava/lang/String;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "activityName"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x0

    const/4 v2, 0x0

    invoke-direct {p0}, Lcom/lge/dockservice/IBaseDockWindow$Stub;-><init>()V

    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/lge/dockservice/BaseDockWindow;->mIsDockableClient:Z

    iput-object v3, p0, Lcom/lge/dockservice/BaseDockWindow;->mDisplaymetrics:Landroid/util/DisplayMetrics;

    iput-object v3, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockIconBitmap:Landroid/graphics/Bitmap;

    iput v2, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockState:I

    const/4 v1, -0x1

    iput v1, p0, Lcom/lge/dockservice/BaseDockWindow;->mRequestedDockDirection:I

    iput-boolean v2, p0, Lcom/lge/dockservice/BaseDockWindow;->mHasTouchDownConfirmed:Z

    iput v2, p0, Lcom/lge/dockservice/BaseDockWindow;->mTouchOffsetX:I

    iput v2, p0, Lcom/lge/dockservice/BaseDockWindow;->mTouchOffsetY:I

    const-string v1, "DockWindow"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "create BaseDockWindow for "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    iput-object p1, p0, Lcom/lge/dockservice/BaseDockWindow;->mContext:Landroid/content/Context;

    iput-object p2, p0, Lcom/lge/dockservice/BaseDockWindow;->mActivityName:Ljava/lang/String;

    invoke-static {p1, p0}, Lcom/lge/dockservice/DockWindowManager;->getDefault(Landroid/content/Context;Lcom/lge/dockservice/BaseDockWindow;)Lcom/lge/dockservice/DockWindowManager;

    move-result-object v1

    iput-object v1, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockWindowManager:Lcom/lge/dockservice/DockWindowManager;

    iget-object v1, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockWindowManager:Lcom/lge/dockservice/DockWindowManager;

    invoke-virtual {v1, p0}, Lcom/lge/dockservice/DockWindowManager;->addDockableWindow(Lcom/lge/dockservice/DockableWindow;)V

    iget-object v1, p0, Lcom/lge/dockservice/BaseDockWindow;->mContext:Landroid/content/Context;

    const-string v2, "window"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    .local v0, "mWindowManager":Landroid/view/WindowManager;
    new-instance v1, Landroid/util/DisplayMetrics;

    invoke-direct {v1}, Landroid/util/DisplayMetrics;-><init>()V

    iput-object v1, p0, Lcom/lge/dockservice/BaseDockWindow;->mDisplaymetrics:Landroid/util/DisplayMetrics;

    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/dockservice/BaseDockWindow;->mDisplaymetrics:Landroid/util/DisplayMetrics;

    invoke-virtual {v1, v2}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V

    return-void
.end method

.method public static final findSurfaceView(Landroid/view/View;)Landroid/view/SurfaceView;
    .locals 4
    .param p0, "aView"    # Landroid/view/View;

    .prologue
    const/4 v1, 0x0

    .local v1, "mSurfaceView":Landroid/view/SurfaceView;
    instance-of v3, p0, Landroid/view/SurfaceView;

    if-eqz v3, :cond_0

    check-cast p0, Landroid/view/SurfaceView;

    .end local p0    # "aView":Landroid/view/View;
    :goto_0
    return-object p0

    .restart local p0    # "aView":Landroid/view/View;
    :cond_0
    instance-of v3, p0, Landroid/view/ViewGroup;

    if-eqz v3, :cond_2

    move-object v2, p0

    check-cast v2, Landroid/view/ViewGroup;

    .local v2, "vg":Landroid/view/ViewGroup;
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    invoke-virtual {v2}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v3

    if-ge v0, v3, :cond_2

    invoke-virtual {v2, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    invoke-static {v3}, Lcom/lge/dockservice/BaseDockWindow;->findSurfaceView(Landroid/view/View;)Landroid/view/SurfaceView;

    move-result-object v1

    if-eqz v1, :cond_1

    move-object p0, v1

    goto :goto_0

    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .end local v0    # "i":I
    .end local v2    # "vg":Landroid/view/ViewGroup;
    :cond_2
    const/4 p0, 0x0

    goto :goto_0
.end method

.method private isDockable()Z
    .locals 1

    .prologue
    iget-boolean v0, p0, Lcom/lge/dockservice/BaseDockWindow;->mIsDockableClient:Z

    return v0
.end method


# virtual methods
.method public abstract getClientPackageName()Ljava/lang/String;
.end method

.method public abstract getClientRect()Landroid/graphics/Rect;
.end method

.method public final getDockDirection()I
    .locals 2

    .prologue
    const-string v0, "DockWindow"

    const-string v1, "getDockDirection"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockWindowManager:Lcom/lge/dockservice/DockWindowManager;

    invoke-virtual {v0, p0}, Lcom/lge/dockservice/DockWindowManager;->getDockDirection(Lcom/lge/dockservice/DockableWindow;)I

    move-result v0

    return v0
.end method

.method public abstract getDockIconBitmap()Landroid/graphics/Bitmap;
.end method

.method public getDockState()I
    .locals 3

    .prologue
    const-string v0, "DockWindow"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getDockState : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockState:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget v0, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockState:I

    return v0
.end method

.method public getDockWindowPosition()[I
    .locals 2

    .prologue
    const-string v0, "DockWindow"

    const-string v1, "getDockWindowPosition"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockWindowManager:Lcom/lge/dockservice/DockWindowManager;

    iget-object v1, p0, Lcom/lge/dockservice/BaseDockWindow;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/lge/dockservice/DockWindowManager;->getDockWindowPosition(Ljava/lang/String;)[I

    move-result-object v0

    return-object v0
.end method

.method public handleTouch(Landroid/view/MotionEvent;)V
    .locals 7
    .param p1, "event"    # Landroid/view/MotionEvent;

    .prologue
    const/4 v6, 0x2

    const/4 v3, 0x1

    iget-object v2, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockWindowManager:Lcom/lge/dockservice/DockWindowManager;

    invoke-virtual {v2}, Lcom/lge/dockservice/DockWindowManager;->isDockServiceReady()Z

    move-result v2

    if-nez v2, :cond_1

    const-string v2, "DockWindow"

    const-string v3, "touch event is ignored before dock service becomes ready"

    invoke-static {v2, v3}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-direct {p0}, Lcom/lge/dockservice/BaseDockWindow;->isDockable()Z

    move-result v2

    if-nez v2, :cond_2

    const-string v2, "DockWindow"

    const-string v3, "this client is not dockable (maybe due to wrong client rect)"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_2
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v2

    if-ge v2, v6, :cond_0

    const/4 v2, 0x0

    invoke-virtual {p1, v2}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v2

    if-eqz v2, :cond_3

    invoke-virtual {p1, v3}, Landroid/view/MotionEvent;->setAction(I)V

    :cond_3
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v2

    packed-switch v2, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    iput-boolean v3, p0, Lcom/lge/dockservice/BaseDockWindow;->mHasTouchDownConfirmed:Z

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v2

    float-to-int v2, v2

    iput v2, p0, Lcom/lge/dockservice/BaseDockWindow;->mTouchOffsetX:I

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v2

    float-to-int v2, v2

    iput v2, p0, Lcom/lge/dockservice/BaseDockWindow;->mTouchOffsetY:I

    invoke-virtual {p0}, Lcom/lge/dockservice/BaseDockWindow;->getClientRect()Landroid/graphics/Rect;

    move-result-object v0

    .local v0, "clientRect":Landroid/graphics/Rect;
    if-nez v0, :cond_0

    const-string v2, "DockWindow"

    const-string v3, "Cannot ACTION_DOWN - Fail to getClientRect == null"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0    # "clientRect":Landroid/graphics/Rect;
    :pswitch_1
    iget-boolean v2, p0, Lcom/lge/dockservice/BaseDockWindow;->mHasTouchDownConfirmed:Z

    if-nez v2, :cond_4

    const-string v2, "DockWindow"

    const-string v3, "ignore touch move without preceding touch down"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_4
    iget-object v2, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockWindowManager:Lcom/lge/dockservice/DockWindowManager;

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v3

    float-to-int v3, v3

    iget v4, p0, Lcom/lge/dockservice/BaseDockWindow;->mTouchOffsetX:I

    sub-int/2addr v3, v4

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v4

    float-to-int v4, v4

    iget v5, p0, Lcom/lge/dockservice/BaseDockWindow;->mTouchOffsetY:I

    sub-int/2addr v4, v5

    invoke-virtual {v2, p0, v3, v4}, Lcom/lge/dockservice/DockWindowManager;->isInDockArea(Lcom/lge/dockservice/DockableWindow;II)Z

    move-result v1

    .local v1, "isInDockArea":Z
    const-string v2, "DockWindow"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Check current position is in dock area or not : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    if-nez v1, :cond_5

    invoke-virtual {p0}, Lcom/lge/dockservice/BaseDockWindow;->getDockState()I

    move-result v2

    if-ne v2, v6, :cond_0

    :cond_5
    iget-object v2, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockIconBitmap:Landroid/graphics/Bitmap;

    if-nez v2, :cond_6

    invoke-virtual {p0}, Lcom/lge/dockservice/BaseDockWindow;->getDockIconBitmap()Landroid/graphics/Bitmap;

    move-result-object v2

    iput-object v2, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockIconBitmap:Landroid/graphics/Bitmap;

    :cond_6
    iget-object v2, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockWindowManager:Lcom/lge/dockservice/DockWindowManager;

    iget-object v3, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockIconBitmap:Landroid/graphics/Bitmap;

    invoke-virtual {v2, p1, v3}, Lcom/lge/dockservice/DockWindowManager;->handleDockTouchEvent(Landroid/view/MotionEvent;Landroid/graphics/Bitmap;)V

    goto/16 :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_1
        :pswitch_1
    .end packed-switch
.end method

.method public final isDocked()Z
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockWindowManager:Lcom/lge/dockservice/DockWindowManager;

    invoke-virtual {v0, p0}, Lcom/lge/dockservice/DockWindowManager;->getDockDirection(Lcom/lge/dockservice/DockableWindow;)I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isInDockArea(Landroid/graphics/Rect;)I
    .locals 1
    .param p1, "rect"    # Landroid/graphics/Rect;

    .prologue
    iget-object v0, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockWindowManager:Lcom/lge/dockservice/DockWindowManager;

    invoke-virtual {v0, p1}, Lcom/lge/dockservice/DockWindowManager;->isInDockArea(Landroid/graphics/Rect;)I

    move-result v0

    return v0
.end method

.method public isInDockArea()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockWindowManager:Lcom/lge/dockservice/DockWindowManager;

    invoke-virtual {v0, p0}, Lcom/lge/dockservice/DockWindowManager;->isInDockArea(Lcom/lge/dockservice/DockableWindow;)Z

    move-result v0

    return v0
.end method

.method public onDockCompleted(I)V
    .locals 0
    .param p1, "dockDirection"    # I

    .prologue
    return-void
.end method

.method public onDockStarting(Z)Z
    .locals 1
    .param p1, "byUser"    # Z

    .prologue
    const/4 v0, 0x1

    return v0
.end method

.method public onDockStateChanged(I)V
    .locals 0
    .param p1, "state"    # I

    .prologue
    packed-switch p1, :pswitch_data_0

    :goto_0
    :pswitch_0
    return-void

    :pswitch_1
    invoke-virtual {p0}, Lcom/lge/dockservice/BaseDockWindow;->onEnterDockArea()V

    goto :goto_0

    :pswitch_2
    invoke-virtual {p0}, Lcom/lge/dockservice/BaseDockWindow;->onLeaveDockArea()V

    goto :goto_0

    :pswitch_data_0
    .packed-switch -0x1
        :pswitch_0
        :pswitch_2
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public onEnterDockArea()V
    .locals 2

    .prologue
    const-string v0, "DockWindow"

    const-string v1, "onEnterDockArea"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public onLeaveDockArea()V
    .locals 0

    .prologue
    return-void
.end method

.method public onUndockCompleted()V
    .locals 0

    .prologue
    return-void
.end method

.method public onUndockStarting(Z)Z
    .locals 1
    .param p1, "byUser"    # Z

    .prologue
    const/4 v0, 0x1

    return v0
.end method

.method public requestUndock(Z)V
    .locals 2
    .param p1, "startedAsFloating"    # Z

    .prologue
    const-string v0, "DockWindow"

    const-string v1, "requestUndock"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockWindowManager:Lcom/lge/dockservice/DockWindowManager;

    iget-object v1, p0, Lcom/lge/dockservice/BaseDockWindow;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, p1}, Lcom/lge/dockservice/DockWindowManager;->requestUndock(Ljava/lang/String;Z)V

    return-void
.end method

.method public restoreDockWindow(II)V
    .locals 3
    .param p1, "restoreX"    # I
    .param p2, "restoreY"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockWindowManager:Lcom/lge/dockservice/DockWindowManager;

    iget-object v1, p0, Lcom/lge/dockservice/BaseDockWindow;->mActivityName:Ljava/lang/String;

    const/4 v2, 0x1

    invoke-virtual {v0, v1, p1, p2, v2}, Lcom/lge/dockservice/DockWindowManager;->initDock(Ljava/lang/String;IIZ)V

    return-void
.end method

.method public final setDockable(Z)V
    .locals 3
    .param p1, "isDockable"    # Z

    .prologue
    const-string v0, "DockWindow"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "set client dockable as "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget v0, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockState:I

    if-eqz v0, :cond_0

    if-nez p1, :cond_0

    const-string v0, "DockWindow"

    const-string v1, "cannot set Not dockable while Not in undock state"

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    iput-boolean p1, p0, Lcom/lge/dockservice/BaseDockWindow;->mIsDockableClient:Z

    goto :goto_0
.end method

.method public final terminate()V
    .locals 3

    .prologue
    const-string v0, "DockWindow"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "terminate Dock for "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/dockservice/BaseDockWindow;->mActivityName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockWindowManager:Lcom/lge/dockservice/DockWindowManager;

    iget-object v1, p0, Lcom/lge/dockservice/BaseDockWindow;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/lge/dockservice/DockWindowManager;->terminateDock(Ljava/lang/String;)V

    return-void
.end method

.method public updateDockIcon(Landroid/graphics/Bitmap;)V
    .locals 2
    .param p1, "icon"    # Landroid/graphics/Bitmap;

    .prologue
    iget-object v0, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockWindowManager:Lcom/lge/dockservice/DockWindowManager;

    iget-object v1, p0, Lcom/lge/dockservice/BaseDockWindow;->mActivityName:Ljava/lang/String;

    invoke-virtual {v0, v1, p1}, Lcom/lge/dockservice/DockWindowManager;->updateDockIconImage(Ljava/lang/String;Landroid/graphics/Bitmap;)V

    return-void
.end method

.method public final updateDockState(I)V
    .locals 5
    .param p1, "state"    # I

    .prologue
    const/4 v4, 0x2

    const/4 v3, -0x1

    const/4 v1, 0x0

    .local v1, "oldState":Ljava/lang/String;
    const/4 v0, 0x0

    .local v0, "newState":Ljava/lang/String;
    iget v2, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockState:I

    if-ne v2, v3, :cond_2

    const-string v1, "STATE_INVALID"

    :cond_0
    :goto_0
    if-ne p1, v3, :cond_4

    const-string v0, "STATE_INVALID"

    :cond_1
    :goto_1
    const-string v2, "DockWindow"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "updateDockState : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " to "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iput p1, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockState:I

    invoke-virtual {p0, p1}, Lcom/lge/dockservice/BaseDockWindow;->onDockStateChanged(I)V

    return-void

    :cond_2
    iget v2, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockState:I

    if-nez v2, :cond_3

    const-string v1, "STATE_UNDOCK"

    goto :goto_0

    :cond_3
    iget v2, p0, Lcom/lge/dockservice/BaseDockWindow;->mDockState:I

    if-ne v2, v4, :cond_0

    const-string v1, "STATE_DOCK"

    goto :goto_0

    :cond_4
    if-nez p1, :cond_5

    const-string v0, "STATE_UNDOCK"

    goto :goto_1

    :cond_5
    if-ne p1, v4, :cond_1

    const-string v0, "STATE_DOCK"

    goto :goto_1
.end method
