.class final Landroid/view/ViewRootImpl$TouchFilterImeInputStage;
.super Landroid/view/ViewRootImpl$InputStage;
.source "ViewRootImpl.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/view/ViewRootImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x10
    name = "TouchFilterImeInputStage"
.end annotation


# instance fields
.field final synthetic this$0:Landroid/view/ViewRootImpl;

.field touchFilterImeInputStageHelper:Landroid/view/TouchFilterImeInputStageHelper;


# direct methods
.method public constructor <init>(Landroid/view/ViewRootImpl;Landroid/view/ViewRootImpl$InputStage;)V
    .locals 6
    .param p2, "next"    # Landroid/view/ViewRootImpl$InputStage;

    .prologue
    .line 3910
    iput-object p1, p0, Landroid/view/ViewRootImpl$TouchFilterImeInputStage;->this$0:Landroid/view/ViewRootImpl;

    .line 3911
    invoke-direct {p0, p1, p2}, Landroid/view/ViewRootImpl$InputStage;-><init>(Landroid/view/ViewRootImpl;Landroid/view/ViewRootImpl$InputStage;)V

    .line 3913
    new-instance v0, Landroid/view/TouchFilterImeInputStageHelper;

    iget-object v2, p1, Landroid/view/ViewRootImpl;->mView:Landroid/view/View;

    iget-object v3, p1, Landroid/view/ViewRootImpl;->mInputEventReceiver:Landroid/view/ViewRootImpl$WindowInputEventReceiver;

    iget-object v4, p1, Landroid/view/ViewRootImpl;->savedEventForSplit:Landroid/view/MotionEvent;

    # getter for: Landroid/view/ViewRootImpl;->mUsingTouchEventFilter:Z
    invoke-static {p1}, Landroid/view/ViewRootImpl;->access$1000(Landroid/view/ViewRootImpl;)Z

    move-result v5

    move-object v1, p1

    invoke-direct/range {v0 .. v5}, Landroid/view/TouchFilterImeInputStageHelper;-><init>(Landroid/view/ViewRootImpl;Landroid/view/View;Landroid/view/ViewRootImpl$WindowInputEventReceiver;Landroid/view/MotionEvent;Z)V

    iput-object v0, p0, Landroid/view/ViewRootImpl$TouchFilterImeInputStage;->touchFilterImeInputStageHelper:Landroid/view/TouchFilterImeInputStageHelper;

    .line 3914
    return-void
.end method


# virtual methods
.method protected onProcess(Landroid/view/ViewRootImpl$QueuedInputEvent;)I
    .locals 2
    .param p1, "q"    # Landroid/view/ViewRootImpl$QueuedInputEvent;

    .prologue
    .line 3918
    iget-object v0, p0, Landroid/view/ViewRootImpl$TouchFilterImeInputStage;->touchFilterImeInputStageHelper:Landroid/view/TouchFilterImeInputStageHelper;

    iget-object v1, p1, Landroid/view/ViewRootImpl$QueuedInputEvent;->mEvent:Landroid/view/InputEvent;

    invoke-virtual {v0, v1}, Landroid/view/TouchFilterImeInputStageHelper;->onProcessInner(Landroid/view/InputEvent;)I

    move-result v0

    return v0
.end method
