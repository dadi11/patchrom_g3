.class Lcom/lge/dockservice/TransitionAnimator$2;
.super Ljava/lang/Object;
.source "TransitionAnimator.java"

# interfaces
.implements Landroid/animation/ValueAnimator$AnimatorUpdateListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/lge/dockservice/TransitionAnimator;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/dockservice/TransitionAnimator;


# direct methods
.method constructor <init>(Lcom/lge/dockservice/TransitionAnimator;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/lge/dockservice/TransitionAnimator$2;->this$0:Lcom/lge/dockservice/TransitionAnimator;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationUpdate(Landroid/animation/ValueAnimator;)V
    .locals 6
    .param p1, "animation"    # Landroid/animation/ValueAnimator;

    .prologue
    if-nez p1, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget-object v4, p0, Lcom/lge/dockservice/TransitionAnimator$2;->this$0:Lcom/lge/dockservice/TransitionAnimator;

    # getter for: Lcom/lge/dockservice/TransitionAnimator;->mUpdateListener:Lcom/lge/dockservice/TransitionAnimator$UpdateListener;
    invoke-static {v4}, Lcom/lge/dockservice/TransitionAnimator;->access$000(Lcom/lge/dockservice/TransitionAnimator;)Lcom/lge/dockservice/TransitionAnimator$UpdateListener;

    move-result-object v4

    if-eqz v4, :cond_0

    invoke-virtual {p1}, Landroid/animation/ValueAnimator;->getAnimatedValue()Ljava/lang/Object;

    move-result-object v3

    .local v3, "value":Ljava/lang/Object;
    if-nez v3, :cond_2

    # getter for: Lcom/lge/dockservice/TransitionAnimator;->TAG:Ljava/lang/String;
    invoke-static {}, Lcom/lge/dockservice/TransitionAnimator;->access$100()Ljava/lang/String;

    move-result-object v4

    const-string v5, "Cannot onAnimationUpdate - Fail to getAnimatedValue == null"

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    :cond_2
    check-cast v3, Ljava/lang/Float;

    .end local v3    # "value":Ljava/lang/Object;
    invoke-virtual {v3}, Ljava/lang/Float;->floatValue()F

    move-result v2

    .local v2, "fraction":F
    iget-object v4, p0, Lcom/lge/dockservice/TransitionAnimator$2;->this$0:Lcom/lge/dockservice/TransitionAnimator;

    # getter for: Lcom/lge/dockservice/TransitionAnimator;->mStartX:I
    invoke-static {v4}, Lcom/lge/dockservice/TransitionAnimator;->access$200(Lcom/lge/dockservice/TransitionAnimator;)I

    move-result v0

    .local v0, "currentX":I
    iget-object v4, p0, Lcom/lge/dockservice/TransitionAnimator$2;->this$0:Lcom/lge/dockservice/TransitionAnimator;

    # getter for: Lcom/lge/dockservice/TransitionAnimator;->mStartY:I
    invoke-static {v4}, Lcom/lge/dockservice/TransitionAnimator;->access$300(Lcom/lge/dockservice/TransitionAnimator;)I

    move-result v1

    .local v1, "currentY":I
    iget-object v4, p0, Lcom/lge/dockservice/TransitionAnimator$2;->this$0:Lcom/lge/dockservice/TransitionAnimator;

    # getter for: Lcom/lge/dockservice/TransitionAnimator;->mIsMovingX:Z
    invoke-static {v4}, Lcom/lge/dockservice/TransitionAnimator;->access$400(Lcom/lge/dockservice/TransitionAnimator;)Z

    move-result v4

    if-eqz v4, :cond_3

    iget-object v4, p0, Lcom/lge/dockservice/TransitionAnimator$2;->this$0:Lcom/lge/dockservice/TransitionAnimator;

    # getter for: Lcom/lge/dockservice/TransitionAnimator;->mEndX:I
    invoke-static {v4}, Lcom/lge/dockservice/TransitionAnimator;->access$500(Lcom/lge/dockservice/TransitionAnimator;)I

    move-result v4

    iget-object v5, p0, Lcom/lge/dockservice/TransitionAnimator$2;->this$0:Lcom/lge/dockservice/TransitionAnimator;

    # getter for: Lcom/lge/dockservice/TransitionAnimator;->mStartX:I
    invoke-static {v5}, Lcom/lge/dockservice/TransitionAnimator;->access$200(Lcom/lge/dockservice/TransitionAnimator;)I

    move-result v5

    sub-int/2addr v4, v5

    int-to-float v4, v4

    mul-float/2addr v4, v2

    float-to-int v4, v4

    add-int/2addr v0, v4

    :cond_3
    iget-object v4, p0, Lcom/lge/dockservice/TransitionAnimator$2;->this$0:Lcom/lge/dockservice/TransitionAnimator;

    # getter for: Lcom/lge/dockservice/TransitionAnimator;->mIsMovingY:Z
    invoke-static {v4}, Lcom/lge/dockservice/TransitionAnimator;->access$600(Lcom/lge/dockservice/TransitionAnimator;)Z

    move-result v4

    if-eqz v4, :cond_4

    iget-object v4, p0, Lcom/lge/dockservice/TransitionAnimator$2;->this$0:Lcom/lge/dockservice/TransitionAnimator;

    # getter for: Lcom/lge/dockservice/TransitionAnimator;->mEndY:I
    invoke-static {v4}, Lcom/lge/dockservice/TransitionAnimator;->access$700(Lcom/lge/dockservice/TransitionAnimator;)I

    move-result v4

    iget-object v5, p0, Lcom/lge/dockservice/TransitionAnimator$2;->this$0:Lcom/lge/dockservice/TransitionAnimator;

    # getter for: Lcom/lge/dockservice/TransitionAnimator;->mStartY:I
    invoke-static {v5}, Lcom/lge/dockservice/TransitionAnimator;->access$300(Lcom/lge/dockservice/TransitionAnimator;)I

    move-result v5

    sub-int/2addr v4, v5

    int-to-float v4, v4

    mul-float/2addr v4, v2

    float-to-int v4, v4

    add-int/2addr v1, v4

    :cond_4
    iget-object v4, p0, Lcom/lge/dockservice/TransitionAnimator$2;->this$0:Lcom/lge/dockservice/TransitionAnimator;

    # getter for: Lcom/lge/dockservice/TransitionAnimator;->mUpdateListener:Lcom/lge/dockservice/TransitionAnimator$UpdateListener;
    invoke-static {v4}, Lcom/lge/dockservice/TransitionAnimator;->access$000(Lcom/lge/dockservice/TransitionAnimator;)Lcom/lge/dockservice/TransitionAnimator$UpdateListener;

    move-result-object v4

    invoke-interface {v4, v0, v1}, Lcom/lge/dockservice/TransitionAnimator$UpdateListener;->onAnimationUpdate(II)V

    goto :goto_0
.end method
