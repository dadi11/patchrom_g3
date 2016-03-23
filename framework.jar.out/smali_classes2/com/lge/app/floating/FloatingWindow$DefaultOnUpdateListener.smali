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
    .line 611
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCloseRequested(Lcom/lge/app/floating/FloatingWindow;)Z
    .locals 1
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    .line 673
    const/4 v0, 0x1

    return v0
.end method

.method public onClosing(Lcom/lge/app/floating/FloatingWindow;)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    .line 678
    return-void
.end method

.method public onDockStateChanged(Lcom/lge/app/floating/FloatingWindow;Z)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;
    .param p2, "docked"    # Z

    .prologue
    .line 706
    return-void
.end method

.method public onEnteringLowProfileMode(Lcom/lge/app/floating/FloatingWindow;Z)Z
    .locals 1
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;
    .param p2, "hide"    # Z

    .prologue
    .line 687
    const/4 v0, 0x1

    return v0
.end method

.method public onExitingLowProfileMode(Lcom/lge/app/floating/FloatingWindow;Z)Z
    .locals 1
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;
    .param p2, "hide"    # Z

    .prologue
    .line 693
    const/4 v0, 0x1

    return v0
.end method

.method public onMoveCanceled(Lcom/lge/app/floating/FloatingWindow;)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    .line 655
    return-void
.end method

.method public onMoveFinished(Lcom/lge/app/floating/FloatingWindow;II)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;
    .param p2, "x"    # I
    .param p3, "y"    # I

    .prologue
    .line 651
    return-void
.end method

.method public onMoveStarted(Lcom/lge/app/floating/FloatingWindow;)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    .line 643
    return-void
.end method

.method public onMoveToTop(Lcom/lge/app/floating/FloatingWindow;)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    .line 682
    return-void
.end method

.method public onMoving(Lcom/lge/app/floating/FloatingWindow;II)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;
    .param p2, "x"    # I
    .param p3, "y"    # I

    .prologue
    .line 647
    return-void
.end method

.method public onOverlayStateChanged(Lcom/lge/app/floating/FloatingWindow;Z)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;
    .param p2, "overlay"    # Z

    .prologue
    .line 702
    return-void
.end method

.method public onResizeCanceled(Lcom/lge/app/floating/FloatingWindow;)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    .line 639
    return-void
.end method

.method public onResizeFinished(Lcom/lge/app/floating/FloatingWindow;II)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;
    .param p2, "width"    # I
    .param p3, "height"    # I

    .prologue
    .line 635
    return-void
.end method

.method public onResizeStarted(Lcom/lge/app/floating/FloatingWindow;)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    .line 616
    return-void
.end method

.method public onResizing(Lcom/lge/app/floating/FloatingWindow;II)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;
    .param p2, "width"    # I
    .param p3, "height"    # I

    .prologue
    .line 620
    return-void
.end method

.method public onSwitchFullRequested(Lcom/lge/app/floating/FloatingWindow;)Z
    .locals 1
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    .line 659
    const/4 v0, 0x1

    return v0
.end method

.method public onSwitchingFull(Lcom/lge/app/floating/FloatingWindow;)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    .line 664
    return-void
.end method

.method public onSwitchingFullByApp()V
    .locals 0

    .prologue
    .line 710
    return-void
.end method

.method public onSwitchingMinimized(Lcom/lge/app/floating/FloatingWindow;Z)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;
    .param p2, "minimized"    # Z

    .prologue
    .line 669
    return-void
.end method

.method public onTitleViewTouch(Lcom/lge/app/floating/FloatingWindow;Landroid/view/MotionEvent;)V
    .locals 0
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;
    .param p2, "event"    # Landroid/view/MotionEvent;

    .prologue
    .line 698
    return-void
.end method
