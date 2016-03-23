.class Lcom/android/server/display/RampAnimator;
.super Ljava/lang/Object;
.source "RampAnimator.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/server/display/RampAnimator$Listener;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# instance fields
.field protected mAnimatedValue:F

.field protected mAnimating:Z

.field protected final mAnimationCallback:Ljava/lang/Runnable;

.field protected final mChoreographer:Landroid/view/Choreographer;

.field protected mCurrentValue:I

.field protected mFirstTime:Z

.field protected mLastFrameTimeNanos:J

.field private mListener:Lcom/android/server/display/RampAnimator$Listener;

.field protected final mObject:Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TT;"
        }
    .end annotation
.end field

.field protected final mProperty:Landroid/util/IntProperty;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/IntProperty",
            "<TT;>;"
        }
    .end annotation
.end field

.field protected mRate:I

.field protected mTargetValue:I


# direct methods
.method public constructor <init>(Ljava/lang/Object;Landroid/util/IntProperty;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;",
            "Landroid/util/IntProperty",
            "<TT;>;)V"
        }
    .end annotation

    .prologue
    .local p0, "this":Lcom/android/server/display/RampAnimator;, "Lcom/android/server/display/RampAnimator<TT;>;"
    .local p1, "object":Ljava/lang/Object;, "TT;"
    .local p2, "property":Landroid/util/IntProperty;, "Landroid/util/IntProperty<TT;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/android/server/display/RampAnimator;->mFirstTime:Z

    new-instance v0, Lcom/android/server/display/RampAnimator$1;

    invoke-direct {v0, p0}, Lcom/android/server/display/RampAnimator$1;-><init>(Lcom/android/server/display/RampAnimator;)V

    iput-object v0, p0, Lcom/android/server/display/RampAnimator;->mAnimationCallback:Ljava/lang/Runnable;

    iput-object p1, p0, Lcom/android/server/display/RampAnimator;->mObject:Ljava/lang/Object;

    iput-object p2, p0, Lcom/android/server/display/RampAnimator;->mProperty:Landroid/util/IntProperty;

    invoke-static {}, Landroid/view/Choreographer;->getInstance()Landroid/view/Choreographer;

    move-result-object v0

    iput-object v0, p0, Lcom/android/server/display/RampAnimator;->mChoreographer:Landroid/view/Choreographer;

    return-void
.end method

.method static synthetic access$000(Lcom/android/server/display/RampAnimator;)Lcom/android/server/display/RampAnimator$Listener;
    .locals 1
    .param p0, "x0"    # Lcom/android/server/display/RampAnimator;

    .prologue
    iget-object v0, p0, Lcom/android/server/display/RampAnimator;->mListener:Lcom/android/server/display/RampAnimator$Listener;

    return-object v0
.end method

.method private cancelAnimationCallback()V
    .locals 4

    .prologue
    .local p0, "this":Lcom/android/server/display/RampAnimator;, "Lcom/android/server/display/RampAnimator<TT;>;"
    iget-object v0, p0, Lcom/android/server/display/RampAnimator;->mChoreographer:Landroid/view/Choreographer;

    const/4 v1, 0x1

    iget-object v2, p0, Lcom/android/server/display/RampAnimator;->mAnimationCallback:Ljava/lang/Runnable;

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, v3}, Landroid/view/Choreographer;->removeCallbacks(ILjava/lang/Runnable;Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public animateTo(II)Z
    .locals 4
    .param p1, "target"    # I
    .param p2, "rate"    # I

    .prologue
    .local p0, "this":Lcom/android/server/display/RampAnimator;, "Lcom/android/server/display/RampAnimator<TT;>;"
    const/4 v1, 0x1

    const/4 v0, 0x0

    iget-boolean v2, p0, Lcom/android/server/display/RampAnimator;->mFirstTime:Z

    if-nez v2, :cond_0

    if-gtz p2, :cond_5

    :cond_0
    iget-boolean v2, p0, Lcom/android/server/display/RampAnimator;->mFirstTime:Z

    if-nez v2, :cond_1

    iget v2, p0, Lcom/android/server/display/RampAnimator;->mCurrentValue:I

    if-eq p1, v2, :cond_4

    :cond_1
    iput-boolean v0, p0, Lcom/android/server/display/RampAnimator;->mFirstTime:Z

    iput v0, p0, Lcom/android/server/display/RampAnimator;->mRate:I

    iput p1, p0, Lcom/android/server/display/RampAnimator;->mTargetValue:I

    iput p1, p0, Lcom/android/server/display/RampAnimator;->mCurrentValue:I

    iget-object v2, p0, Lcom/android/server/display/RampAnimator;->mProperty:Landroid/util/IntProperty;

    iget-object v3, p0, Lcom/android/server/display/RampAnimator;->mObject:Ljava/lang/Object;

    invoke-virtual {v2, v3, p1}, Landroid/util/IntProperty;->setValue(Ljava/lang/Object;I)V

    iget-boolean v2, p0, Lcom/android/server/display/RampAnimator;->mAnimating:Z

    if-eqz v2, :cond_2

    iput-boolean v0, p0, Lcom/android/server/display/RampAnimator;->mAnimating:Z

    invoke-direct {p0}, Lcom/android/server/display/RampAnimator;->cancelAnimationCallback()V

    :cond_2
    iget-object v2, p0, Lcom/android/server/display/RampAnimator;->mListener:Lcom/android/server/display/RampAnimator$Listener;

    if-eqz v2, :cond_3

    iget-object v2, p0, Lcom/android/server/display/RampAnimator;->mListener:Lcom/android/server/display/RampAnimator$Listener;

    invoke-interface {v2}, Lcom/android/server/display/RampAnimator$Listener;->onAnimationEnd()V

    :cond_3
    move v0, v1

    :cond_4
    :goto_0
    return v0

    :cond_5
    iget-boolean v2, p0, Lcom/android/server/display/RampAnimator;->mAnimating:Z

    if-eqz v2, :cond_7

    iget v2, p0, Lcom/android/server/display/RampAnimator;->mRate:I

    if-gt p2, v2, :cond_7

    iget v2, p0, Lcom/android/server/display/RampAnimator;->mCurrentValue:I

    if-gt p1, v2, :cond_6

    iget v2, p0, Lcom/android/server/display/RampAnimator;->mCurrentValue:I

    iget v3, p0, Lcom/android/server/display/RampAnimator;->mTargetValue:I

    if-le v2, v3, :cond_7

    :cond_6
    iget v2, p0, Lcom/android/server/display/RampAnimator;->mTargetValue:I

    iget v3, p0, Lcom/android/server/display/RampAnimator;->mCurrentValue:I

    if-gt v2, v3, :cond_8

    iget v2, p0, Lcom/android/server/display/RampAnimator;->mCurrentValue:I

    if-gt v2, p1, :cond_8

    :cond_7
    iput p2, p0, Lcom/android/server/display/RampAnimator;->mRate:I

    :cond_8
    iget v2, p0, Lcom/android/server/display/RampAnimator;->mTargetValue:I

    if-eq v2, p1, :cond_9

    move v0, v1

    .local v0, "changed":Z
    :cond_9
    iput p1, p0, Lcom/android/server/display/RampAnimator;->mTargetValue:I

    iget-boolean v2, p0, Lcom/android/server/display/RampAnimator;->mAnimating:Z

    if-nez v2, :cond_4

    iget v2, p0, Lcom/android/server/display/RampAnimator;->mCurrentValue:I

    if-eq p1, v2, :cond_4

    iput-boolean v1, p0, Lcom/android/server/display/RampAnimator;->mAnimating:Z

    iget v1, p0, Lcom/android/server/display/RampAnimator;->mCurrentValue:I

    int-to-float v1, v1

    iput v1, p0, Lcom/android/server/display/RampAnimator;->mAnimatedValue:F

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v2

    iput-wide v2, p0, Lcom/android/server/display/RampAnimator;->mLastFrameTimeNanos:J

    invoke-virtual {p0}, Lcom/android/server/display/RampAnimator;->postAnimationCallback()V

    goto :goto_0
.end method

.method public isAnimating()Z
    .locals 1

    .prologue
    .local p0, "this":Lcom/android/server/display/RampAnimator;, "Lcom/android/server/display/RampAnimator<TT;>;"
    iget-boolean v0, p0, Lcom/android/server/display/RampAnimator;->mAnimating:Z

    return v0
.end method

.method protected postAnimationCallback()V
    .locals 4

    .prologue
    .local p0, "this":Lcom/android/server/display/RampAnimator;, "Lcom/android/server/display/RampAnimator<TT;>;"
    iget-object v0, p0, Lcom/android/server/display/RampAnimator;->mChoreographer:Landroid/view/Choreographer;

    const/4 v1, 0x1

    iget-object v2, p0, Lcom/android/server/display/RampAnimator;->mAnimationCallback:Ljava/lang/Runnable;

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, v3}, Landroid/view/Choreographer;->postCallback(ILjava/lang/Runnable;Ljava/lang/Object;)V

    return-void
.end method

.method public setListener(Lcom/android/server/display/RampAnimator$Listener;)V
    .locals 0
    .param p1, "listener"    # Lcom/android/server/display/RampAnimator$Listener;

    .prologue
    .local p0, "this":Lcom/android/server/display/RampAnimator;, "Lcom/android/server/display/RampAnimator<TT;>;"
    iput-object p1, p0, Lcom/android/server/display/RampAnimator;->mListener:Lcom/android/server/display/RampAnimator$Listener;

    return-void
.end method
