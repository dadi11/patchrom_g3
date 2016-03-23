.class public Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;
.super Ljava/lang/Object;
.source "FloatingWindow.java"

# interfaces
.implements Landroid/view/View$OnTouchListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/app/floating/FloatingWindow;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "DefaultTouchListener"
.end annotation


# instance fields
.field private a:Lcom/lge/app/floating/FloatableActivity;

.field mDownX:I

.field mDownY:I

.field private mEnsureTouchDown:Z

.field protected mHasTouchDownConfirmed:Z

.field private mMoveLisntener:Landroid/view/View$OnTouchListener;

.field private w:Lcom/lge/app/floating/FloatingWindow;


# direct methods
.method public constructor <init>(Lcom/lge/app/floating/FloatableActivity;)V
    .locals 2
    .param p1, "activity"    # Lcom/lge/app/floating/FloatableActivity;

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->a:Lcom/lge/app/floating/FloatableActivity;

    iput-object v0, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    iput-object v0, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->mMoveLisntener:Landroid/view/View$OnTouchListener;

    iput-boolean v1, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->mHasTouchDownConfirmed:Z

    iput-boolean v1, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->mEnsureTouchDown:Z

    iput-object p1, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->a:Lcom/lge/app/floating/FloatableActivity;

    return-void
.end method

.method public constructor <init>(Lcom/lge/app/floating/FloatingWindow;)V
    .locals 2
    .param p1, "window"    # Lcom/lge/app/floating/FloatingWindow;

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->a:Lcom/lge/app/floating/FloatableActivity;

    iput-object v0, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    iput-object v0, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->mMoveLisntener:Landroid/view/View$OnTouchListener;

    iput-boolean v1, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->mHasTouchDownConfirmed:Z

    iput-boolean v1, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->mEnsureTouchDown:Z

    iput-object p1, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    iget-object v0, p1, Lcom/lge/app/floating/FloatingWindow;->mActivity:Lcom/lge/app/floating/FloatableActivity;

    iput-object v0, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->a:Lcom/lge/app/floating/FloatableActivity;

    return-void
.end method


# virtual methods
.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 12
    .param p1, "view"    # Landroid/view/View;
    .param p2, "event"    # Landroid/view/MotionEvent;

    .prologue
    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    if-nez v7, :cond_0

    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->a:Lcom/lge/app/floating/FloatableActivity;

    if-eqz v7, :cond_0

    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->a:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v7}, Lcom/lge/app/floating/FloatableActivity;->getFloatingWindow()Lcom/lge/app/floating/FloatingWindow;

    move-result-object v7

    iput-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    :cond_0
    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    if-nez v7, :cond_1

    const/4 v7, 0x0

    :goto_0
    return v7

    :cond_1
    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->a:Lcom/lge/app/floating/FloatableActivity;

    invoke-virtual {v7, p2}, Lcom/lge/app/floating/FloatableActivity;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v7

    if-eqz v7, :cond_2

    const/4 v7, 0x1

    goto :goto_0

    :cond_2
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v7

    const/4 v8, 0x2

    if-lt v7, v8, :cond_3

    const/4 v7, 0x0

    goto :goto_0

    :cond_3
    const/4 v7, 0x0

    invoke-virtual {p2, v7}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v7

    if-eqz v7, :cond_4

    const/4 v7, 0x1

    invoke-virtual {p2, v7}, Landroid/view/MotionEvent;->setAction(I)V

    :cond_4
    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v7}, Lcom/lge/app/floating/FloatingWindow;->getLayoutParam()Lcom/lge/app/floating/FloatingWindow$LayoutParams;

    move-result-object v1

    .local v1, "layout":Lcom/lge/app/floating/FloatingWindow$LayoutParams;
    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->mMoveLisntener:Landroid/view/View$OnTouchListener;

    if-eqz v7, :cond_5

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result v7

    const/4 v8, 0x2

    if-ne v7, v8, :cond_7

    iget-boolean v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->mHasTouchDownConfirmed:Z

    if-eqz v7, :cond_7

    iget-boolean v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->mEnsureTouchDown:Z

    if-nez v7, :cond_7

    invoke-static {p2}, Landroid/view/MotionEvent;->obtainNoHistory(Landroid/view/MotionEvent;)Landroid/view/MotionEvent;

    move-result-object v0

    .local v0, "event2":Landroid/view/MotionEvent;
    const/4 v7, 0x0

    invoke-virtual {v0, v7}, Landroid/view/MotionEvent;->setAction(I)V

    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->mMoveLisntener:Landroid/view/View$OnTouchListener;

    const/4 v8, 0x0

    invoke-interface {v7, v8, v0}, Landroid/view/View$OnTouchListener;->onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z

    const/4 v7, 0x1

    iput-boolean v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->mEnsureTouchDown:Z

    .end local v0    # "event2":Landroid/view/MotionEvent;
    :cond_5
    :goto_1
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result v7

    packed-switch v7, :pswitch_data_0

    :cond_6
    :goto_2
    const/4 v7, 0x0

    goto :goto_0

    :cond_7
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result v7

    const/4 v8, 0x1

    if-eq v7, v8, :cond_8

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result v7

    const/4 v8, 0x1

    if-ne v7, v8, :cond_9

    :cond_8
    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->mMoveLisntener:Landroid/view/View$OnTouchListener;

    const/4 v8, 0x0

    invoke-interface {v7, v8, p2}, Landroid/view/View$OnTouchListener;->onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z

    const/4 v7, 0x0

    iput-boolean v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->mEnsureTouchDown:Z

    goto :goto_1

    :cond_9
    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->mMoveLisntener:Landroid/view/View$OnTouchListener;

    const/4 v8, 0x0

    invoke-interface {v7, v8, p2}, Landroid/view/View$OnTouchListener;->onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z

    goto :goto_1

    :pswitch_0
    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getX()F

    move-result v8

    float-to-int v8, v8

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getY()F

    move-result v9

    float-to-int v9, v9

    invoke-virtual {v7, p1, v8, v9}, Lcom/lge/app/floating/FloatingWindow;->convertViewPositionToWindowPosition(Landroid/view/View;II)[I

    move-result-object v4

    .local v4, "ret":[I
    const/4 v7, 0x0

    aget v7, v4, v7

    iput v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->mDownX:I

    const/4 v7, 0x1

    aget v7, v4, v7

    iput v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->mDownY:I

    const/4 v7, 0x1

    iput-boolean v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->mHasTouchDownConfirmed:Z

    goto :goto_2

    .end local v4    # "ret":[I
    :pswitch_1
    iget-boolean v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->mHasTouchDownConfirmed:Z

    if-nez v7, :cond_a

    # getter for: Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindow;->access$000()Ljava/lang/String;

    move-result-object v7

    const-string v8, "ignore touch move without preceding touch down"

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_2

    :cond_a
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getEventTime()J

    move-result-wide v8

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getDownTime()J

    move-result-wide v10

    sub-long/2addr v8, v10

    const-wide/16 v10, 0x64

    cmp-long v7, v8, v10

    if-ltz v7, :cond_6

    iget v5, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    .local v5, "xMove":I
    iget v6, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    .local v6, "yMove":I
    iget v2, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->moveOption:I

    .local v2, "moveOption":I
    and-int/lit8 v7, v2, 0x1

    if-eqz v7, :cond_b

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawX()F

    move-result v7

    float-to-int v7, v7

    iget v8, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->mDownX:I

    sub-int v5, v7, v8

    :cond_b
    and-int/lit8 v7, v2, 0x2

    if-eqz v7, :cond_c

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getRawY()F

    move-result v7

    float-to-int v7, v7

    iget v8, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->mDownY:I

    sub-int v6, v7, v8

    :cond_c
    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    # getter for: Lcom/lge/app/floating/FloatingWindow;->mIsMoving:Z
    invoke-static {v7}, Lcom/lge/app/floating/FloatingWindow;->access$100(Lcom/lge/app/floating/FloatingWindow;)Z

    move-result v7

    if-nez v7, :cond_e

    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    iget-object v7, v7, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    if-eqz v7, :cond_d

    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    iget-object v7, v7, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    iget-object v8, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    invoke-interface {v7, v8}, Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;->onMoveStarted(Lcom/lge/app/floating/FloatingWindow;)V

    :cond_d
    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    const/4 v8, 0x1

    # setter for: Lcom/lge/app/floating/FloatingWindow;->mIsMoving:Z
    invoke-static {v7, v8}, Lcom/lge/app/floating/FloatingWindow;->access$102(Lcom/lge/app/floating/FloatingWindow;Z)Z

    :cond_e
    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v7, v5, v6}, Lcom/lge/app/floating/FloatingWindow;->moveInner(II)V

    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    iget-object v7, v7, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    if-eqz v7, :cond_6

    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    iget-object v7, v7, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    iget-object v8, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    iget v9, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    iget v10, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    invoke-interface {v7, v8, v9, v10}, Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;->onMoving(Lcom/lge/app/floating/FloatingWindow;II)V

    goto/16 :goto_2

    .end local v2    # "moveOption":I
    .end local v5    # "xMove":I
    .end local v6    # "yMove":I
    :pswitch_2
    iget-boolean v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->mHasTouchDownConfirmed:Z

    if-nez v7, :cond_f

    # getter for: Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindow;->access$000()Ljava/lang/String;

    move-result-object v7

    const-string v8, "ignore touch up/cancel without preceding touch down"

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_2

    :cond_f
    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    iget v8, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    iget v9, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    invoke-virtual {v7, v8, v9}, Lcom/lge/app/floating/FloatingWindow;->calculateCorrectPosition(II)Landroid/graphics/Rect;

    move-result-object v3

    .local v3, "r":Landroid/graphics/Rect;
    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v7, v3}, Lcom/lge/app/floating/FloatingWindow;->bounceFloatingWindow(Landroid/graphics/Rect;)V

    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    const/4 v8, 0x0

    # setter for: Lcom/lge/app/floating/FloatingWindow;->mIsMoving:Z
    invoke-static {v7, v8}, Lcom/lge/app/floating/FloatingWindow;->access$102(Lcom/lge/app/floating/FloatingWindow;Z)Z

    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    iget-object v7, v7, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    if-eqz v7, :cond_10

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result v7

    const/4 v8, 0x1

    if-ne v7, v8, :cond_11

    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    iget-object v7, v7, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    iget-object v8, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    iget v9, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->x:I

    iget v10, v1, Lcom/lge/app/floating/FloatingWindow$LayoutParams;->y:I

    invoke-interface {v7, v8, v9, v10}, Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;->onMoveFinished(Lcom/lge/app/floating/FloatingWindow;II)V

    :cond_10
    :goto_3
    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    invoke-virtual {v7, v1}, Lcom/lge/app/floating/FloatingWindow;->updateLayoutParamsInner(Lcom/lge/app/floating/FloatingWindow$LayoutParams;)V

    const/4 v7, 0x0

    sput-boolean v7, Lcom/lge/app/floating/FloatingWindow;->sSavedLocation:Z

    const/4 v7, 0x0

    iput-boolean v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->mHasTouchDownConfirmed:Z

    goto/16 :goto_2

    :cond_11
    iget-object v7, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    iget-object v7, v7, Lcom/lge/app/floating/FloatingWindow;->mUpdateListener:Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;

    iget-object v8, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->w:Lcom/lge/app/floating/FloatingWindow;

    invoke-interface {v7, v8}, Lcom/lge/app/floating/FloatingWindow$OnUpdateListener;->onMoveCanceled(Lcom/lge/app/floating/FloatingWindow;)V

    goto :goto_3

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_2
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method public setMoveTouchListener(Landroid/view/View$OnTouchListener;)V
    .locals 2
    .param p1, "listener"    # Landroid/view/View$OnTouchListener;

    .prologue
    # getter for: Lcom/lge/app/floating/FloatingWindow;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/app/floating/FloatingWindow;->access$000()Ljava/lang/String;

    move-result-object v0

    const-string v1, "setMoveTouchListener"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iput-object p1, p0, Lcom/lge/app/floating/FloatingWindow$DefaultTouchListener;->mMoveLisntener:Landroid/view/View$OnTouchListener;

    return-void
.end method
