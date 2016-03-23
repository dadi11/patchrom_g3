.class public Lcom/lge/gles/GLESAnimator;
.super Ljava/lang/Object;
.source "GLESAnimator.java"


# static fields
.field private static final DEBUG:Z = false

.field private static final TAG:Ljava/lang/String; = "quilt GLESAnimator"


# instance fields
.field private mCallback:Lcom/lge/gles/GLESAnimatorCallback;

.field private mCurrent:Lcom/lge/gles/GLESVector;

.field private mDistance:Lcom/lge/gles/GLESVector;

.field private mDuration:J

.field private mEndOffset:J

.field private mFrom:Lcom/lge/gles/GLESVector;

.field private mFromValue:F

.field private mInterpolator:Landroid/view/animation/Interpolator;

.field private mIsFinished:Z

.field private mIsSetValue:Z

.field private mIsStarted:Z

.field private mStartOffset:J

.field private mStartTick:J

.field private mTo:Lcom/lge/gles/GLESVector;

.field private mToValue:F

.field private mUseVector:Z


# direct methods
.method public constructor <init>(FFLcom/lge/gles/GLESAnimatorCallback;)V
    .locals 8
    .param p1, "from"    # F
    .param p2, "to"    # F
    .param p3, "callBack"    # Lcom/lge/gles/GLESAnimatorCallback;

    .prologue
    const-wide/16 v6, 0x3e8

    const-wide/16 v0, 0x0

    const/4 v5, 0x1

    const/4 v4, 0x0

    const/4 v3, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-boolean v4, p0, Lcom/lge/gles/GLESAnimator;->mIsFinished:Z

    iput-boolean v4, p0, Lcom/lge/gles/GLESAnimator;->mIsStarted:Z

    iput-boolean v5, p0, Lcom/lge/gles/GLESAnimator;->mUseVector:Z

    iput-boolean v4, p0, Lcom/lge/gles/GLESAnimator;->mIsSetValue:Z

    iput-wide v0, p0, Lcom/lge/gles/GLESAnimator;->mStartOffset:J

    iput-wide v6, p0, Lcom/lge/gles/GLESAnimator;->mEndOffset:J

    iput-wide v6, p0, Lcom/lge/gles/GLESAnimator;->mDuration:J

    iput-wide v0, p0, Lcom/lge/gles/GLESAnimator;->mStartTick:J

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/gles/GLESAnimator;->mInterpolator:Landroid/view/animation/Interpolator;

    new-instance v0, Lcom/lge/gles/GLESVector;

    invoke-direct {v0, v3, v3, v3}, Lcom/lge/gles/GLESVector;-><init>(FFF)V

    iput-object v0, p0, Lcom/lge/gles/GLESAnimator;->mCurrent:Lcom/lge/gles/GLESVector;

    new-instance v0, Lcom/lge/gles/GLESVector;

    invoke-direct {v0, v3, v3, v3}, Lcom/lge/gles/GLESVector;-><init>(FFF)V

    iput-object v0, p0, Lcom/lge/gles/GLESAnimator;->mDistance:Lcom/lge/gles/GLESVector;

    iput p1, p0, Lcom/lge/gles/GLESAnimator;->mFromValue:F

    iput p2, p0, Lcom/lge/gles/GLESAnimator;->mToValue:F

    iget-object v0, p0, Lcom/lge/gles/GLESAnimator;->mDistance:Lcom/lge/gles/GLESVector;

    iget v1, p0, Lcom/lge/gles/GLESAnimator;->mToValue:F

    iget v2, p0, Lcom/lge/gles/GLESAnimator;->mFromValue:F

    sub-float/2addr v1, v2

    invoke-virtual {v0, v1, v3, v3}, Lcom/lge/gles/GLESVector;->set(FFF)V

    iput-boolean v5, p0, Lcom/lge/gles/GLESAnimator;->mIsSetValue:Z

    iput-boolean v4, p0, Lcom/lge/gles/GLESAnimator;->mUseVector:Z

    iput-object p3, p0, Lcom/lge/gles/GLESAnimator;->mCallback:Lcom/lge/gles/GLESAnimatorCallback;

    return-void
.end method

.method public constructor <init>(Lcom/lge/gles/GLESAnimatorCallback;)V
    .locals 8
    .param p1, "callBack"    # Lcom/lge/gles/GLESAnimatorCallback;

    .prologue
    const-wide/16 v6, 0x3e8

    const-wide/16 v4, 0x0

    const/4 v2, 0x0

    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-boolean v2, p0, Lcom/lge/gles/GLESAnimator;->mIsFinished:Z

    iput-boolean v2, p0, Lcom/lge/gles/GLESAnimator;->mIsStarted:Z

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/lge/gles/GLESAnimator;->mUseVector:Z

    iput-boolean v2, p0, Lcom/lge/gles/GLESAnimator;->mIsSetValue:Z

    iput-wide v4, p0, Lcom/lge/gles/GLESAnimator;->mStartOffset:J

    iput-wide v6, p0, Lcom/lge/gles/GLESAnimator;->mEndOffset:J

    iput-wide v6, p0, Lcom/lge/gles/GLESAnimator;->mDuration:J

    iput-wide v4, p0, Lcom/lge/gles/GLESAnimator;->mStartTick:J

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/gles/GLESAnimator;->mInterpolator:Landroid/view/animation/Interpolator;

    new-instance v0, Lcom/lge/gles/GLESVector;

    invoke-direct {v0, v1, v1, v1}, Lcom/lge/gles/GLESVector;-><init>(FFF)V

    iput-object v0, p0, Lcom/lge/gles/GLESAnimator;->mCurrent:Lcom/lge/gles/GLESVector;

    new-instance v0, Lcom/lge/gles/GLESVector;

    invoke-direct {v0, v1, v1, v1}, Lcom/lge/gles/GLESVector;-><init>(FFF)V

    iput-object v0, p0, Lcom/lge/gles/GLESAnimator;->mDistance:Lcom/lge/gles/GLESVector;

    iput-boolean v2, p0, Lcom/lge/gles/GLESAnimator;->mIsSetValue:Z

    iput-object p1, p0, Lcom/lge/gles/GLESAnimator;->mCallback:Lcom/lge/gles/GLESAnimatorCallback;

    return-void
.end method

.method public constructor <init>(Lcom/lge/gles/GLESVector;Lcom/lge/gles/GLESVector;Lcom/lge/gles/GLESAnimatorCallback;)V
    .locals 8
    .param p1, "from"    # Lcom/lge/gles/GLESVector;
    .param p2, "to"    # Lcom/lge/gles/GLESVector;
    .param p3, "callBack"    # Lcom/lge/gles/GLESAnimatorCallback;

    .prologue
    const-wide/16 v6, 0x3e8

    const-wide/16 v2, 0x0

    const/4 v5, 0x1

    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-boolean v0, p0, Lcom/lge/gles/GLESAnimator;->mIsFinished:Z

    iput-boolean v0, p0, Lcom/lge/gles/GLESAnimator;->mIsStarted:Z

    iput-boolean v5, p0, Lcom/lge/gles/GLESAnimator;->mUseVector:Z

    iput-boolean v0, p0, Lcom/lge/gles/GLESAnimator;->mIsSetValue:Z

    iput-wide v2, p0, Lcom/lge/gles/GLESAnimator;->mStartOffset:J

    iput-wide v6, p0, Lcom/lge/gles/GLESAnimator;->mEndOffset:J

    iput-wide v6, p0, Lcom/lge/gles/GLESAnimator;->mDuration:J

    iput-wide v2, p0, Lcom/lge/gles/GLESAnimator;->mStartTick:J

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/gles/GLESAnimator;->mInterpolator:Landroid/view/animation/Interpolator;

    new-instance v0, Lcom/lge/gles/GLESVector;

    invoke-direct {v0, v1, v1, v1}, Lcom/lge/gles/GLESVector;-><init>(FFF)V

    iput-object v0, p0, Lcom/lge/gles/GLESAnimator;->mCurrent:Lcom/lge/gles/GLESVector;

    new-instance v0, Lcom/lge/gles/GLESVector;

    invoke-direct {v0, v1, v1, v1}, Lcom/lge/gles/GLESVector;-><init>(FFF)V

    iput-object v0, p0, Lcom/lge/gles/GLESAnimator;->mDistance:Lcom/lge/gles/GLESVector;

    iput-object p1, p0, Lcom/lge/gles/GLESAnimator;->mFrom:Lcom/lge/gles/GLESVector;

    iput-object p2, p0, Lcom/lge/gles/GLESAnimator;->mTo:Lcom/lge/gles/GLESVector;

    iget-object v0, p0, Lcom/lge/gles/GLESAnimator;->mDistance:Lcom/lge/gles/GLESVector;

    iget-object v1, p0, Lcom/lge/gles/GLESAnimator;->mTo:Lcom/lge/gles/GLESVector;

    iget v1, v1, Lcom/lge/gles/GLESVector;->mX:F

    iget-object v2, p0, Lcom/lge/gles/GLESAnimator;->mFrom:Lcom/lge/gles/GLESVector;

    iget v2, v2, Lcom/lge/gles/GLESVector;->mX:F

    sub-float/2addr v1, v2

    iget-object v2, p0, Lcom/lge/gles/GLESAnimator;->mTo:Lcom/lge/gles/GLESVector;

    iget v2, v2, Lcom/lge/gles/GLESVector;->mY:F

    iget-object v3, p0, Lcom/lge/gles/GLESAnimator;->mFrom:Lcom/lge/gles/GLESVector;

    iget v3, v3, Lcom/lge/gles/GLESVector;->mY:F

    sub-float/2addr v2, v3

    iget-object v3, p0, Lcom/lge/gles/GLESAnimator;->mTo:Lcom/lge/gles/GLESVector;

    iget v3, v3, Lcom/lge/gles/GLESVector;->mZ:F

    iget-object v4, p0, Lcom/lge/gles/GLESAnimator;->mFrom:Lcom/lge/gles/GLESVector;

    iget v4, v4, Lcom/lge/gles/GLESVector;->mZ:F

    sub-float/2addr v3, v4

    invoke-virtual {v0, v1, v2, v3}, Lcom/lge/gles/GLESVector;->set(FFF)V

    iput-boolean v5, p0, Lcom/lge/gles/GLESAnimator;->mIsSetValue:Z

    iput-boolean v5, p0, Lcom/lge/gles/GLESAnimator;->mUseVector:Z

    iput-object p3, p0, Lcom/lge/gles/GLESAnimator;->mCallback:Lcom/lge/gles/GLESAnimatorCallback;

    return-void
.end method


# virtual methods
.method public cancel()V
    .locals 1

    .prologue
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/lge/gles/GLESAnimator;->mIsFinished:Z

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/gles/GLESAnimator;->mIsStarted:Z

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/gles/GLESAnimator;->mInterpolator:Landroid/view/animation/Interpolator;

    iget-object v0, p0, Lcom/lge/gles/GLESAnimator;->mCallback:Lcom/lge/gles/GLESAnimatorCallback;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/gles/GLESAnimator;->mCallback:Lcom/lge/gles/GLESAnimatorCallback;

    invoke-interface {v0}, Lcom/lge/gles/GLESAnimatorCallback;->onCancel()V

    :cond_0
    return-void
.end method

.method public destroy()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/gles/GLESAnimator;->mInterpolator:Landroid/view/animation/Interpolator;

    return-void
.end method

.method public doAnimation()Z
    .locals 13

    .prologue
    const/4 v12, 0x0

    const/4 v3, 0x0

    const/4 v6, 0x1

    iget-boolean v7, p0, Lcom/lge/gles/GLESAnimator;->mIsStarted:Z

    if-nez v7, :cond_0

    :goto_0
    return v3

    :cond_0
    iget-boolean v7, p0, Lcom/lge/gles/GLESAnimator;->mIsFinished:Z

    if-ne v7, v6, :cond_1

    iget-object v7, p0, Lcom/lge/gles/GLESAnimator;->mCallback:Lcom/lge/gles/GLESAnimatorCallback;

    if-eqz v7, :cond_1

    iget-object v6, p0, Lcom/lge/gles/GLESAnimator;->mCallback:Lcom/lge/gles/GLESAnimatorCallback;

    invoke-interface {v6}, Lcom/lge/gles/GLESAnimatorCallback;->onFinished()V

    iput-boolean v3, p0, Lcom/lge/gles/GLESAnimator;->mIsStarted:Z

    goto :goto_0

    :cond_1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    .local v0, "currentTick":J
    iget-wide v8, p0, Lcom/lge/gles/GLESAnimator;->mStartTick:J

    sub-long v8, v0, v8

    iget-wide v10, p0, Lcom/lge/gles/GLESAnimator;->mStartOffset:J

    cmp-long v3, v8, v10

    if-gez v3, :cond_2

    move v3, v6

    goto :goto_0

    :cond_2
    iget-wide v8, p0, Lcom/lge/gles/GLESAnimator;->mStartTick:J

    iget-wide v10, p0, Lcom/lge/gles/GLESAnimator;->mStartOffset:J

    add-long v4, v8, v10

    .local v4, "startTick":J
    sub-long v8, v0, v4

    long-to-float v3, v8

    iget-wide v8, p0, Lcom/lge/gles/GLESAnimator;->mDuration:J

    long-to-float v7, v8

    div-float v2, v3, v7

    .local v2, "normalizedDuration":F
    const/high16 v3, 0x3f800000    # 1.0f

    cmpl-float v3, v2, v3

    if-ltz v3, :cond_3

    const/high16 v2, 0x3f800000    # 1.0f

    iput-boolean v6, p0, Lcom/lge/gles/GLESAnimator;->mIsFinished:Z

    :cond_3
    iget-object v3, p0, Lcom/lge/gles/GLESAnimator;->mInterpolator:Landroid/view/animation/Interpolator;

    if-nez v3, :cond_4

    new-instance v3, Landroid/view/animation/LinearInterpolator;

    invoke-direct {v3}, Landroid/view/animation/LinearInterpolator;-><init>()V

    iput-object v3, p0, Lcom/lge/gles/GLESAnimator;->mInterpolator:Landroid/view/animation/Interpolator;

    :cond_4
    iget-object v3, p0, Lcom/lge/gles/GLESAnimator;->mInterpolator:Landroid/view/animation/Interpolator;

    invoke-interface {v3, v2}, Landroid/view/animation/Interpolator;->getInterpolation(F)F

    move-result v2

    iget-boolean v3, p0, Lcom/lge/gles/GLESAnimator;->mUseVector:Z

    if-ne v3, v6, :cond_6

    iget-object v3, p0, Lcom/lge/gles/GLESAnimator;->mCurrent:Lcom/lge/gles/GLESVector;

    iget-object v7, p0, Lcom/lge/gles/GLESAnimator;->mFrom:Lcom/lge/gles/GLESVector;

    iget v7, v7, Lcom/lge/gles/GLESVector;->mX:F

    iget-object v8, p0, Lcom/lge/gles/GLESAnimator;->mDistance:Lcom/lge/gles/GLESVector;

    iget v8, v8, Lcom/lge/gles/GLESVector;->mX:F

    mul-float/2addr v8, v2

    add-float/2addr v7, v8

    iput v7, v3, Lcom/lge/gles/GLESVector;->mX:F

    iget-object v3, p0, Lcom/lge/gles/GLESAnimator;->mCurrent:Lcom/lge/gles/GLESVector;

    iget-object v7, p0, Lcom/lge/gles/GLESAnimator;->mFrom:Lcom/lge/gles/GLESVector;

    iget v7, v7, Lcom/lge/gles/GLESVector;->mY:F

    iget-object v8, p0, Lcom/lge/gles/GLESAnimator;->mDistance:Lcom/lge/gles/GLESVector;

    iget v8, v8, Lcom/lge/gles/GLESVector;->mY:F

    mul-float/2addr v8, v2

    add-float/2addr v7, v8

    iput v7, v3, Lcom/lge/gles/GLESVector;->mY:F

    iget-object v3, p0, Lcom/lge/gles/GLESAnimator;->mCurrent:Lcom/lge/gles/GLESVector;

    iget-object v7, p0, Lcom/lge/gles/GLESAnimator;->mFrom:Lcom/lge/gles/GLESVector;

    iget v7, v7, Lcom/lge/gles/GLESVector;->mZ:F

    iget-object v8, p0, Lcom/lge/gles/GLESAnimator;->mDistance:Lcom/lge/gles/GLESVector;

    iget v8, v8, Lcom/lge/gles/GLESVector;->mZ:F

    mul-float/2addr v8, v2

    add-float/2addr v7, v8

    iput v7, v3, Lcom/lge/gles/GLESVector;->mZ:F

    :goto_1
    iget-object v3, p0, Lcom/lge/gles/GLESAnimator;->mCallback:Lcom/lge/gles/GLESAnimatorCallback;

    if-eqz v3, :cond_5

    iget-object v3, p0, Lcom/lge/gles/GLESAnimator;->mCallback:Lcom/lge/gles/GLESAnimatorCallback;

    iget-object v7, p0, Lcom/lge/gles/GLESAnimator;->mCurrent:Lcom/lge/gles/GLESVector;

    invoke-interface {v3, v7}, Lcom/lge/gles/GLESAnimatorCallback;->onAnimation(Lcom/lge/gles/GLESVector;)V

    :cond_5
    move v3, v6

    goto/16 :goto_0

    :cond_6
    iget-object v3, p0, Lcom/lge/gles/GLESAnimator;->mCurrent:Lcom/lge/gles/GLESVector;

    iget v7, p0, Lcom/lge/gles/GLESAnimator;->mFromValue:F

    iget-object v8, p0, Lcom/lge/gles/GLESAnimator;->mDistance:Lcom/lge/gles/GLESVector;

    iget v8, v8, Lcom/lge/gles/GLESVector;->mX:F

    mul-float/2addr v8, v2

    add-float/2addr v7, v8

    iput v7, v3, Lcom/lge/gles/GLESVector;->mX:F

    iget-object v3, p0, Lcom/lge/gles/GLESAnimator;->mCurrent:Lcom/lge/gles/GLESVector;

    iput v12, v3, Lcom/lge/gles/GLESVector;->mY:F

    iget-object v3, p0, Lcom/lge/gles/GLESAnimator;->mCurrent:Lcom/lge/gles/GLESVector;

    iput v12, v3, Lcom/lge/gles/GLESVector;->mZ:F

    goto :goto_1
.end method

.method public getCurrentValue()Lcom/lge/gles/GLESVector;
    .locals 12

    .prologue
    const/4 v3, 0x0

    const/4 v11, 0x0

    const/4 v10, 0x1

    iget-boolean v6, p0, Lcom/lge/gles/GLESAnimator;->mIsFinished:Z

    if-ne v6, v10, :cond_1

    :cond_0
    :goto_0
    return-object v3

    :cond_1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    .local v0, "currentTick":J
    iget-wide v6, p0, Lcom/lge/gles/GLESAnimator;->mStartTick:J

    sub-long v6, v0, v6

    iget-wide v8, p0, Lcom/lge/gles/GLESAnimator;->mStartOffset:J

    cmp-long v6, v6, v8

    if-ltz v6, :cond_0

    iget-wide v6, p0, Lcom/lge/gles/GLESAnimator;->mStartTick:J

    iget-wide v8, p0, Lcom/lge/gles/GLESAnimator;->mStartOffset:J

    add-long v4, v6, v8

    .local v4, "startTick":J
    sub-long v6, v0, v4

    long-to-float v3, v6

    iget-wide v6, p0, Lcom/lge/gles/GLESAnimator;->mDuration:J

    long-to-float v6, v6

    div-float v2, v3, v6

    .local v2, "normalizedDuration":F
    const/high16 v3, 0x3f800000    # 1.0f

    cmpl-float v3, v2, v3

    if-ltz v3, :cond_2

    const/high16 v2, 0x3f800000    # 1.0f

    iput-boolean v10, p0, Lcom/lge/gles/GLESAnimator;->mIsFinished:Z

    :cond_2
    iget-object v3, p0, Lcom/lge/gles/GLESAnimator;->mInterpolator:Landroid/view/animation/Interpolator;

    if-nez v3, :cond_3

    new-instance v3, Landroid/view/animation/LinearInterpolator;

    invoke-direct {v3}, Landroid/view/animation/LinearInterpolator;-><init>()V

    iput-object v3, p0, Lcom/lge/gles/GLESAnimator;->mInterpolator:Landroid/view/animation/Interpolator;

    :cond_3
    iget-object v3, p0, Lcom/lge/gles/GLESAnimator;->mInterpolator:Landroid/view/animation/Interpolator;

    invoke-interface {v3, v2}, Landroid/view/animation/Interpolator;->getInterpolation(F)F

    move-result v2

    iget-boolean v3, p0, Lcom/lge/gles/GLESAnimator;->mUseVector:Z

    if-ne v3, v10, :cond_4

    iget-object v3, p0, Lcom/lge/gles/GLESAnimator;->mCurrent:Lcom/lge/gles/GLESVector;

    iget-object v6, p0, Lcom/lge/gles/GLESAnimator;->mFrom:Lcom/lge/gles/GLESVector;

    iget v6, v6, Lcom/lge/gles/GLESVector;->mX:F

    iget-object v7, p0, Lcom/lge/gles/GLESAnimator;->mDistance:Lcom/lge/gles/GLESVector;

    iget v7, v7, Lcom/lge/gles/GLESVector;->mX:F

    mul-float/2addr v7, v2

    add-float/2addr v6, v7

    iput v6, v3, Lcom/lge/gles/GLESVector;->mX:F

    iget-object v3, p0, Lcom/lge/gles/GLESAnimator;->mCurrent:Lcom/lge/gles/GLESVector;

    iget-object v6, p0, Lcom/lge/gles/GLESAnimator;->mFrom:Lcom/lge/gles/GLESVector;

    iget v6, v6, Lcom/lge/gles/GLESVector;->mY:F

    iget-object v7, p0, Lcom/lge/gles/GLESAnimator;->mDistance:Lcom/lge/gles/GLESVector;

    iget v7, v7, Lcom/lge/gles/GLESVector;->mY:F

    mul-float/2addr v7, v2

    add-float/2addr v6, v7

    iput v6, v3, Lcom/lge/gles/GLESVector;->mY:F

    iget-object v3, p0, Lcom/lge/gles/GLESAnimator;->mCurrent:Lcom/lge/gles/GLESVector;

    iget-object v6, p0, Lcom/lge/gles/GLESAnimator;->mFrom:Lcom/lge/gles/GLESVector;

    iget v6, v6, Lcom/lge/gles/GLESVector;->mZ:F

    iget-object v7, p0, Lcom/lge/gles/GLESAnimator;->mDistance:Lcom/lge/gles/GLESVector;

    iget v7, v7, Lcom/lge/gles/GLESVector;->mZ:F

    mul-float/2addr v7, v2

    add-float/2addr v6, v7

    iput v6, v3, Lcom/lge/gles/GLESVector;->mZ:F

    :goto_1
    iget-object v3, p0, Lcom/lge/gles/GLESAnimator;->mCurrent:Lcom/lge/gles/GLESVector;

    goto :goto_0

    :cond_4
    iget-object v3, p0, Lcom/lge/gles/GLESAnimator;->mCurrent:Lcom/lge/gles/GLESVector;

    iget v6, p0, Lcom/lge/gles/GLESAnimator;->mFromValue:F

    iget-object v7, p0, Lcom/lge/gles/GLESAnimator;->mDistance:Lcom/lge/gles/GLESVector;

    iget v7, v7, Lcom/lge/gles/GLESVector;->mX:F

    mul-float/2addr v7, v2

    add-float/2addr v6, v7

    iput v6, v3, Lcom/lge/gles/GLESVector;->mX:F

    iget-object v3, p0, Lcom/lge/gles/GLESAnimator;->mCurrent:Lcom/lge/gles/GLESVector;

    iput v11, v3, Lcom/lge/gles/GLESVector;->mY:F

    iget-object v3, p0, Lcom/lge/gles/GLESAnimator;->mCurrent:Lcom/lge/gles/GLESVector;

    iput v11, v3, Lcom/lge/gles/GLESVector;->mZ:F

    goto :goto_1
.end method

.method public isFinished()Z
    .locals 1

    .prologue
    iget-boolean v0, p0, Lcom/lge/gles/GLESAnimator;->mIsFinished:Z

    return v0
.end method

.method public setDuration(JJ)V
    .locals 3
    .param p1, "start"    # J
    .param p3, "end"    # J

    .prologue
    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-gez v0, :cond_0

    const-string v0, "quilt GLESAnimator"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "setDuration() start="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " is invalid"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    iput-wide p1, p0, Lcom/lge/gles/GLESAnimator;->mStartOffset:J

    iput-wide p3, p0, Lcom/lge/gles/GLESAnimator;->mEndOffset:J

    sub-long v0, p3, p1

    iput-wide v0, p0, Lcom/lge/gles/GLESAnimator;->mDuration:J

    goto :goto_0
.end method

.method public setInterpolator(Landroid/view/animation/Interpolator;)V
    .locals 0
    .param p1, "intepolator"    # Landroid/view/animation/Interpolator;

    .prologue
    iput-object p1, p0, Lcom/lge/gles/GLESAnimator;->mInterpolator:Landroid/view/animation/Interpolator;

    return-void
.end method

.method public start()V
    .locals 2

    .prologue
    iget-boolean v0, p0, Lcom/lge/gles/GLESAnimator;->mIsSetValue:Z

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "quilt GLESAnimatorstart() should use start(from, to)"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/gles/GLESAnimator;->mIsFinished:Z

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/lge/gles/GLESAnimator;->mIsStarted:Z

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/lge/gles/GLESAnimator;->mStartTick:J

    return-void
.end method

.method public start(FF)V
    .locals 5
    .param p1, "from"    # F
    .param p2, "to"    # F

    .prologue
    const/4 v4, 0x0

    const/4 v3, 0x0

    iput-boolean v4, p0, Lcom/lge/gles/GLESAnimator;->mUseVector:Z

    iput p1, p0, Lcom/lge/gles/GLESAnimator;->mFromValue:F

    iput p2, p0, Lcom/lge/gles/GLESAnimator;->mToValue:F

    iget-object v0, p0, Lcom/lge/gles/GLESAnimator;->mDistance:Lcom/lge/gles/GLESVector;

    iget v1, p0, Lcom/lge/gles/GLESAnimator;->mToValue:F

    iget v2, p0, Lcom/lge/gles/GLESAnimator;->mFromValue:F

    sub-float/2addr v1, v2

    invoke-virtual {v0, v1, v3, v3}, Lcom/lge/gles/GLESVector;->set(FFF)V

    iput-boolean v4, p0, Lcom/lge/gles/GLESAnimator;->mIsFinished:Z

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/lge/gles/GLESAnimator;->mIsStarted:Z

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/lge/gles/GLESAnimator;->mStartTick:J

    return-void
.end method

.method public start(Lcom/lge/gles/GLESVector;Lcom/lge/gles/GLESVector;)V
    .locals 6
    .param p1, "from"    # Lcom/lge/gles/GLESVector;
    .param p2, "to"    # Lcom/lge/gles/GLESVector;

    .prologue
    const/4 v5, 0x1

    iput-boolean v5, p0, Lcom/lge/gles/GLESAnimator;->mUseVector:Z

    iput-object p1, p0, Lcom/lge/gles/GLESAnimator;->mFrom:Lcom/lge/gles/GLESVector;

    iput-object p2, p0, Lcom/lge/gles/GLESAnimator;->mTo:Lcom/lge/gles/GLESVector;

    iget-object v0, p0, Lcom/lge/gles/GLESAnimator;->mDistance:Lcom/lge/gles/GLESVector;

    iget-object v1, p0, Lcom/lge/gles/GLESAnimator;->mTo:Lcom/lge/gles/GLESVector;

    iget v1, v1, Lcom/lge/gles/GLESVector;->mX:F

    iget-object v2, p0, Lcom/lge/gles/GLESAnimator;->mFrom:Lcom/lge/gles/GLESVector;

    iget v2, v2, Lcom/lge/gles/GLESVector;->mX:F

    sub-float/2addr v1, v2

    iget-object v2, p0, Lcom/lge/gles/GLESAnimator;->mTo:Lcom/lge/gles/GLESVector;

    iget v2, v2, Lcom/lge/gles/GLESVector;->mY:F

    iget-object v3, p0, Lcom/lge/gles/GLESAnimator;->mFrom:Lcom/lge/gles/GLESVector;

    iget v3, v3, Lcom/lge/gles/GLESVector;->mY:F

    sub-float/2addr v2, v3

    iget-object v3, p0, Lcom/lge/gles/GLESAnimator;->mTo:Lcom/lge/gles/GLESVector;

    iget v3, v3, Lcom/lge/gles/GLESVector;->mZ:F

    iget-object v4, p0, Lcom/lge/gles/GLESAnimator;->mFrom:Lcom/lge/gles/GLESVector;

    iget v4, v4, Lcom/lge/gles/GLESVector;->mZ:F

    sub-float/2addr v3, v4

    invoke-virtual {v0, v1, v2, v3}, Lcom/lge/gles/GLESVector;->set(FFF)V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/gles/GLESAnimator;->mIsFinished:Z

    iput-boolean v5, p0, Lcom/lge/gles/GLESAnimator;->mIsStarted:Z

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/lge/gles/GLESAnimator;->mStartTick:J

    return-void
.end method
