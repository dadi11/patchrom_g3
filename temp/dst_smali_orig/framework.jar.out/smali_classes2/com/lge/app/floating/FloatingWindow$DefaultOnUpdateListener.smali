.class public Lcom/lge/app/floating/FloatingWindow$DefaultOnUpdateListener;
.super Ljava/lang/Object;
.source "FloatingWindow.java"

# interfaces
.implements Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;
.implements Lcom/lge/app/floating/FloatingWindow$OnUpdateListener2;
.implements Lcom/lge/app/floating/FloatingWindow$OnUpdateListener3;
.implements Lcom/lge/app/floating/FloatingWindow$OnDockListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/app/floating/FloatingWindow;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "DefaultOnUpdateListener"
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCloseRequested(Lcom/lge/app/floating/FloatingWindow;)Z
    .locals 1
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    const/4 v0, 0x1

    return v0
.end method

.method public onClosing(Lcom/lge/app/floating/FloatingWindow;)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    return-void
.end method

.method public onDockStateChanged(Lcom/lge/app/floating/FloatingWindow;Z)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;
    .param p2, "docked"    # Z

    .prologue
    return-void
.end method

.method public onEnteringLowProfileMode(Lcom/lge/app/floating/FloatingWindow;Z)Z
    .locals 1
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;
    .param p2, "hide"    # Z

    .prologue
    const/4 v0, 0x1

    return v0
.end method

.method public onExitingLowProfileMode(Lcom/lge/app/floating/FloatingWindow;Z)Z
    .locals 1
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;
    .param p2, "hide"    # Z

    .prologue
    const/4 v0, 0x1

    return v0
.end method

.method public onMoveCanceled(Lcom/lge/app/floating/FloatingWindow;)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    return-void
.end method

.method public onMoveFinished(Lcom/lge/app/floating/FloatingWindow;II)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;
    .param p2, "x"    # I
    .param p3, "y"    # I

    .prologue
    return-void
.end method

.method public onMoveStarted(Lcom/lge/app/floating/FloatingWindow;)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    return-void
.end method

.method public onMoveToTop(Lcom/lge/app/floating/FloatingWindow;)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    return-void
.end method

.method public onMoving(Lcom/lge/app/floating/FloatingWindow;II)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;
    .param p2, "x"    # I
    .param p3, "y"    # I

    .prologue
    return-void
.end method

.method public onOverlayStateChanged(Lcom/lge/app/floating/FloatingWindow;Z)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;
    .param p2, "overlay"    # Z

    .prologue
    return-void
.end method

.method public onResizeCanceled(Lcom/lge/app/floating/FloatingWindow;)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    return-void
.end method

.method public onResizeFinished(Lcom/lge/app/floating/FloatingWindow;II)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;
    .param p2, "width"    # I
    .param p3, "height"    # I

    .prologue
    return-void
.end method

.method public onResizeStarted(Lcom/lge/app/floating/FloatingWindow;)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    return-void
.end method

.method public onResizing(Lcom/lge/app/floating/FloatingWindow;II)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;
    .param p2, "width"    # I
    .param p3, "height"    # I

    .prologue
    return-void
.end method

.method public onSwitchFullRequested(Lcom/lge/app/floating/FloatingWindow;)Z
    .locals 1
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    const/4 v0, 0x1

    return v0
.end method

.method public onSwitchingFull(Lcom/lge/app/floating/FloatingWindow;)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    return-void
.end method

.method public onSwitchingFullByApp()V
    .locals 0

    .prologue
    return-void
.end method

.method public onSwitchingMinimized(Lcom/lge/app/floating/FloatingWindow;Z)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;
    .param p2, "minimized"    # Z

    .prologue
    return-void
.end method

.method public onTitleViewTouch(Lcom/lge/app/floating/FloatingWindow;Landroid/view/MotionEvent;)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;
    .param p2, "event"    # Landroid/view/MotionEvent;

    .prologue
    return-void
.end method
