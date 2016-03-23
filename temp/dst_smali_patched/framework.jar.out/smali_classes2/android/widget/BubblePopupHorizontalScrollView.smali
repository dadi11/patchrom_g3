.class public Landroid/widget/BubblePopupHorizontalScrollView;
.super Landroid/widget/HorizontalScrollView;
.source "BubblePopupHorizontalScrollView.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/widget/BubblePopupHorizontalScrollView$ArrowHandler;
    }
.end annotation


# static fields
.field private static final MSG_HIDE:I = 0x2

.field private static final MSG_SHOW:I = 0x1

.field private static final MSG_UPDATE:I = 0x3

.field private static final SCROLL_POS:I = 0x190

.field private static final TAG:Ljava/lang/String; = "BubblePopupHorizontalScrollView"


# instance fields
.field private mContext:Landroid/content/Context;

.field private mFirstDrowArrow:Z

.field private mHandler:Landroid/widget/BubblePopupHorizontalScrollView$ArrowHandler;

.field private mLeftVisible:Z

.field private mLeftVisibleArrowView:Landroid/widget/ImageView;

.field private mOldLeftVisible:Z

.field private mOldRightVisible:Z

.field private mRightVisible:Z

.field private mRightVisibleArrowView:Landroid/widget/ImageView;

.field private mScroller2:Landroid/widget/OverScroller;

.field private mSkipCheckArrow:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .prologue
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Landroid/widget/BubblePopupHorizontalScrollView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyle"    # I

    .prologue
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, p3}, Landroid/widget/HorizontalScrollView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    iput-boolean v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mLeftVisible:Z

    iput-boolean v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mRightVisible:Z

    iput-boolean v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mOldLeftVisible:Z

    iput-boolean v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mOldRightVisible:Z

    iput-boolean v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mFirstDrowArrow:Z

    const/4 v0, 0x1

    iput-boolean v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mSkipCheckArrow:Z

    iput-object p1, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mContext:Landroid/content/Context;

    new-instance v0, Landroid/widget/BubblePopupHorizontalScrollView$ArrowHandler;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Landroid/widget/BubblePopupHorizontalScrollView$ArrowHandler;-><init>(Landroid/widget/BubblePopupHorizontalScrollView;Landroid/widget/BubblePopupHorizontalScrollView$1;)V

    iput-object v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mHandler:Landroid/widget/BubblePopupHorizontalScrollView$ArrowHandler;

    new-instance v0, Landroid/widget/OverScroller;

    invoke-virtual {p0}, Landroid/widget/BubblePopupHorizontalScrollView;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/widget/OverScroller;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mScroller2:Landroid/widget/OverScroller;

    invoke-virtual {p0}, Landroid/widget/BubblePopupHorizontalScrollView;->initScrollPos()V

    return-void
.end method

.method static synthetic access$002(Landroid/widget/BubblePopupHorizontalScrollView;Z)Z
    .locals 0
    .param p0, "x0"    # Landroid/widget/BubblePopupHorizontalScrollView;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mSkipCheckArrow:Z

    return p1
.end method

.method static synthetic access$100(Landroid/widget/BubblePopupHorizontalScrollView;)Landroid/widget/BubblePopupHorizontalScrollView$ArrowHandler;
    .locals 1
    .param p0, "x0"    # Landroid/widget/BubblePopupHorizontalScrollView;

    .prologue
    iget-object v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mHandler:Landroid/widget/BubblePopupHorizontalScrollView$ArrowHandler;

    return-object v0
.end method

.method static synthetic access$200(Landroid/widget/BubblePopupHorizontalScrollView;)Z
    .locals 1
    .param p0, "x0"    # Landroid/widget/BubblePopupHorizontalScrollView;

    .prologue
    iget-boolean v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mOldLeftVisible:Z

    return v0
.end method

.method static synthetic access$202(Landroid/widget/BubblePopupHorizontalScrollView;Z)Z
    .locals 0
    .param p0, "x0"    # Landroid/widget/BubblePopupHorizontalScrollView;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mOldLeftVisible:Z

    return p1
.end method

.method static synthetic access$300(Landroid/widget/BubblePopupHorizontalScrollView;)V
    .locals 0
    .param p0, "x0"    # Landroid/widget/BubblePopupHorizontalScrollView;

    .prologue
    invoke-direct {p0}, Landroid/widget/BubblePopupHorizontalScrollView;->hideLeftArrow()V

    return-void
.end method

.method static synthetic access$400(Landroid/widget/BubblePopupHorizontalScrollView;)Z
    .locals 1
    .param p0, "x0"    # Landroid/widget/BubblePopupHorizontalScrollView;

    .prologue
    iget-boolean v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mOldRightVisible:Z

    return v0
.end method

.method static synthetic access$402(Landroid/widget/BubblePopupHorizontalScrollView;Z)Z
    .locals 0
    .param p0, "x0"    # Landroid/widget/BubblePopupHorizontalScrollView;
    .param p1, "x1"    # Z

    .prologue
    iput-boolean p1, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mOldRightVisible:Z

    return p1
.end method

.method static synthetic access$500(Landroid/widget/BubblePopupHorizontalScrollView;)V
    .locals 0
    .param p0, "x0"    # Landroid/widget/BubblePopupHorizontalScrollView;

    .prologue
    invoke-direct {p0}, Landroid/widget/BubblePopupHorizontalScrollView;->hideRightArrow()V

    return-void
.end method

.method static synthetic access$600(Landroid/widget/BubblePopupHorizontalScrollView;)Landroid/widget/OverScroller;
    .locals 1
    .param p0, "x0"    # Landroid/widget/BubblePopupHorizontalScrollView;

    .prologue
    iget-object v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mScroller2:Landroid/widget/OverScroller;

    return-object v0
.end method

.method static synthetic access$800(Landroid/widget/BubblePopupHorizontalScrollView;)Landroid/widget/ImageView;
    .locals 1
    .param p0, "x0"    # Landroid/widget/BubblePopupHorizontalScrollView;

    .prologue
    iget-object v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mLeftVisibleArrowView:Landroid/widget/ImageView;

    return-object v0
.end method

.method static synthetic access$900(Landroid/widget/BubblePopupHorizontalScrollView;)Landroid/widget/ImageView;
    .locals 1
    .param p0, "x0"    # Landroid/widget/BubblePopupHorizontalScrollView;

    .prologue
    iget-object v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mRightVisibleArrowView:Landroid/widget/ImageView;

    return-object v0
.end method

.method private getScrollRange()I
    .locals 6

    .prologue
    const/4 v5, 0x0

    const/4 v1, 0x0

    .local v1, "scrollRange":I
    invoke-virtual {p0}, Landroid/widget/BubblePopupHorizontalScrollView;->getChildCount()I

    move-result v2

    if-lez v2, :cond_0

    invoke-virtual {p0, v5}, Landroid/widget/BubblePopupHorizontalScrollView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    .local v0, "child":Landroid/view/View;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/view/View;->getWidth()I

    move-result v2

    invoke-virtual {p0}, Landroid/widget/BubblePopupHorizontalScrollView;->getWidth()I

    move-result v3

    iget v4, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mPaddingLeft:I

    sub-int/2addr v3, v4

    iget v4, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mPaddingRight:I

    sub-int/2addr v3, v4

    sub-int/2addr v2, v3

    invoke-static {v5, v2}, Ljava/lang/Math;->max(II)I

    move-result v1

    .end local v0    # "child":Landroid/view/View;
    :cond_0
    return v1
.end method

.method private hideLeftArrow()V
    .locals 4

    .prologue
    new-instance v0, Landroid/widget/BubblePopupHorizontalScrollView$1;

    invoke-direct {v0, p0}, Landroid/widget/BubblePopupHorizontalScrollView$1;-><init>(Landroid/widget/BubblePopupHorizontalScrollView;)V

    .local v0, "arrowListener":Landroid/view/animation/Animation$AnimationListener;
    :try_start_0
    iget-object v2, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mLeftVisibleArrowView:Landroid/widget/ImageView;

    sget v3, Lcom/lge/internal/R$anim;->bubble_popup_arrow_fade_out:I

    invoke-direct {p0, v3, v0}, Landroid/widget/BubblePopupHorizontalScrollView;->loadAnim(ILandroid/view/animation/Animation$AnimationListener;)Landroid/view/animation/Animation;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v1

    .local v1, "e":Ljava/lang/Exception;
    const-string v2, "BubblePopupHorizontalScrollView"

    const-string v3, "Can\'t start animation. Because Fail to load it."

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private hideRightArrow()V
    .locals 4

    .prologue
    new-instance v0, Landroid/widget/BubblePopupHorizontalScrollView$3;

    invoke-direct {v0, p0}, Landroid/widget/BubblePopupHorizontalScrollView$3;-><init>(Landroid/widget/BubblePopupHorizontalScrollView;)V

    .local v0, "arrowListener":Landroid/view/animation/Animation$AnimationListener;
    :try_start_0
    iget-object v2, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mRightVisibleArrowView:Landroid/widget/ImageView;

    sget v3, Lcom/lge/internal/R$anim;->bubble_popup_arrow_fade_out:I

    invoke-direct {p0, v3, v0}, Landroid/widget/BubblePopupHorizontalScrollView;->loadAnim(ILandroid/view/animation/Animation$AnimationListener;)Landroid/view/animation/Animation;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v1

    .local v1, "e":Ljava/lang/Exception;
    const-string v2, "BubblePopupHorizontalScrollView"

    const-string v3, "Can\'t start animation. Because Fail to load it."

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private loadAnim(ILandroid/view/animation/Animation$AnimationListener;)Landroid/view/animation/Animation;
    .locals 2
    .param p1, "id"    # I
    .param p2, "listener"    # Landroid/view/animation/Animation$AnimationListener;

    .prologue
    iget-object v1, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mContext:Landroid/content/Context;

    invoke-static {v1, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v0

    .local v0, "anim":Landroid/view/animation/Animation;
    if-eqz p2, :cond_0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p2}, Landroid/view/animation/Animation;->setAnimationListener(Landroid/view/animation/Animation$AnimationListener;)V

    :cond_0
    return-object v0
.end method

.method private showLeftArrow()V
    .locals 4

    .prologue
    new-instance v0, Landroid/widget/BubblePopupHorizontalScrollView$2;

    invoke-direct {v0, p0}, Landroid/widget/BubblePopupHorizontalScrollView$2;-><init>(Landroid/widget/BubblePopupHorizontalScrollView;)V

    .local v0, "arrowListener":Landroid/view/animation/Animation$AnimationListener;
    :try_start_0
    iget-object v2, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mLeftVisibleArrowView:Landroid/widget/ImageView;

    sget v3, Lcom/lge/internal/R$anim;->bubble_popup_arrow_fade_in:I

    invoke-direct {p0, v3, v0}, Landroid/widget/BubblePopupHorizontalScrollView;->loadAnim(ILandroid/view/animation/Animation$AnimationListener;)Landroid/view/animation/Animation;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v1

    .local v1, "e":Ljava/lang/Exception;
    const-string v2, "BubblePopupHorizontalScrollView"

    const-string v3, "Can\'t start animation. Because Fail to load it."

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private showRightArrow()V
    .locals 4

    .prologue
    new-instance v0, Landroid/widget/BubblePopupHorizontalScrollView$4;

    invoke-direct {v0, p0}, Landroid/widget/BubblePopupHorizontalScrollView$4;-><init>(Landroid/widget/BubblePopupHorizontalScrollView;)V

    .local v0, "arrowListener":Landroid/view/animation/Animation$AnimationListener;
    :try_start_0
    iget-object v2, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mRightVisibleArrowView:Landroid/widget/ImageView;

    sget v3, Lcom/lge/internal/R$anim;->bubble_popup_arrow_fade_in:I

    invoke-direct {p0, v3, v0}, Landroid/widget/BubblePopupHorizontalScrollView;->loadAnim(ILandroid/view/animation/Animation$AnimationListener;)Landroid/view/animation/Animation;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v1

    .local v1, "e":Ljava/lang/Exception;
    const-string v2, "BubblePopupHorizontalScrollView"

    const-string v3, "Can\'t start animation. Because Fail to load it."

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .locals 1
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .prologue
    iget-boolean v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mSkipCheckArrow:Z

    if-nez v0, :cond_0

    invoke-virtual {p0}, Landroid/widget/BubblePopupHorizontalScrollView;->drawArrow()V

    :cond_0
    invoke-super {p0, p1}, Landroid/widget/HorizontalScrollView;->draw(Landroid/graphics/Canvas;)V

    return-void
.end method

.method public drawArrow()V
    .locals 4

    .prologue
    const/4 v2, 0x0

    const/4 v3, 0x1

    invoke-direct {p0}, Landroid/widget/BubblePopupHorizontalScrollView;->getScrollRange()I

    move-result v0

    .local v0, "scrollRange":I
    if-eqz v0, :cond_0

    if-ne v0, v3, :cond_3

    :cond_0
    iput-boolean v2, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mLeftVisible:Z

    iput-boolean v2, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mRightVisible:Z

    :goto_0
    iget-boolean v1, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mOldLeftVisible:Z

    iget-boolean v2, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mLeftVisible:Z

    if-eq v1, v2, :cond_1

    iget-boolean v1, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mLeftVisible:Z

    if-ne v1, v3, :cond_6

    invoke-direct {p0}, Landroid/widget/BubblePopupHorizontalScrollView;->showLeftArrow()V

    :goto_1
    iget-boolean v1, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mLeftVisible:Z

    iput-boolean v1, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mOldLeftVisible:Z

    :cond_1
    iget-boolean v1, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mOldRightVisible:Z

    iget-boolean v2, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mRightVisible:Z

    if-eq v1, v2, :cond_2

    iget-boolean v1, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mRightVisible:Z

    if-ne v1, v3, :cond_7

    invoke-direct {p0}, Landroid/widget/BubblePopupHorizontalScrollView;->showRightArrow()V

    :goto_2
    iget-boolean v1, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mRightVisible:Z

    iput-boolean v1, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mOldRightVisible:Z

    :cond_2
    return-void

    :cond_3
    iget v1, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mScrollX:I

    if-nez v1, :cond_4

    iput-boolean v2, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mLeftVisible:Z

    iput-boolean v3, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mRightVisible:Z

    goto :goto_0

    :cond_4
    iget v1, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mScrollX:I

    if-ne v1, v0, :cond_5

    iput-boolean v3, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mLeftVisible:Z

    iput-boolean v2, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mRightVisible:Z

    goto :goto_0

    :cond_5
    iput-boolean v3, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mLeftVisible:Z

    iput-boolean v3, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mRightVisible:Z

    goto :goto_0

    :cond_6
    invoke-direct {p0}, Landroid/widget/BubblePopupHorizontalScrollView;->hideLeftArrow()V

    goto :goto_1

    :cond_7
    invoke-direct {p0}, Landroid/widget/BubblePopupHorizontalScrollView;->hideRightArrow()V

    goto :goto_2
.end method

.method public enableDrawArrow()V
    .locals 4

    .prologue
    const/4 v1, 0x1

    iget-object v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mHandler:Landroid/widget/BubblePopupHorizontalScrollView$ArrowHandler;

    invoke-virtual {v0, v1}, Landroid/widget/BubblePopupHorizontalScrollView$ArrowHandler;->removeMessages(I)V

    iget-object v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mHandler:Landroid/widget/BubblePopupHorizontalScrollView$ArrowHandler;

    const-wide/16 v2, 0x64

    invoke-virtual {v0, v1, v2, v3}, Landroid/widget/BubblePopupHorizontalScrollView$ArrowHandler;->sendEmptyMessageDelayed(IJ)Z

    return-void
.end method

.method public hideArrow()V
    .locals 4

    .prologue
    const/4 v3, 0x4

    const/4 v2, 0x1

    const/4 v1, 0x0

    iget-object v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mLeftVisibleArrowView:Landroid/widget/ImageView;

    invoke-virtual {v0, v3}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mRightVisibleArrowView:Landroid/widget/ImageView;

    invoke-virtual {v0, v3}, Landroid/widget/ImageView;->setVisibility(I)V

    iput-boolean v1, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mRightVisible:Z

    iput-boolean v1, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mOldRightVisible:Z

    iput-boolean v1, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mLeftVisible:Z

    iput-boolean v1, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mOldLeftVisible:Z

    iput-boolean v2, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mSkipCheckArrow:Z

    iget-object v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mHandler:Landroid/widget/BubblePopupHorizontalScrollView$ArrowHandler;

    invoke-virtual {v0, v2}, Landroid/widget/BubblePopupHorizontalScrollView$ArrowHandler;->removeMessages(I)V

    return-void
.end method

.method public initScrollPos()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    invoke-virtual {p0, v0, v0}, Landroid/widget/BubblePopupHorizontalScrollView;->scrollTo(II)V

    return-void
.end method

.method public moveScroll()V
    .locals 10

    .prologue
    const/4 v2, 0x0

    const/16 v3, -0x834

    .local v3, "velocityX":I
    iget-object v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mScroller2:Landroid/widget/OverScroller;

    const/16 v1, 0x190

    invoke-direct {p0}, Landroid/widget/BubblePopupHorizontalScrollView;->getScrollRange()I

    move-result v6

    move v4, v2

    move v5, v2

    move v7, v2

    move v8, v2

    invoke-virtual/range {v0 .. v8}, Landroid/widget/OverScroller;->fling(IIIIIIII)V

    iget-object v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mHandler:Landroid/widget/BubblePopupHorizontalScrollView$ArrowHandler;

    const/4 v1, 0x3

    invoke-virtual {v0, v1}, Landroid/widget/BubblePopupHorizontalScrollView$ArrowHandler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v9

    .local v9, "msg":Landroid/os/Message;
    iget-object v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mHandler:Landroid/widget/BubblePopupHorizontalScrollView$ArrowHandler;

    invoke-virtual {v0, v9}, Landroid/widget/BubblePopupHorizontalScrollView$ArrowHandler;->sendMessage(Landroid/os/Message;)Z

    const-string v0, "BubblePopupHorizontalScrollView"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "moveScroll() : velocityX = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method protected onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 0
    .param p1, "newConfig"    # Landroid/content/res/Configuration;

    .prologue
    invoke-virtual {p0}, Landroid/widget/BubblePopupHorizontalScrollView;->enableDrawArrow()V

    return-void
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 1
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .prologue
    invoke-super {p0, p1}, Landroid/widget/HorizontalScrollView;->onDraw(Landroid/graphics/Canvas;)V

    iget-boolean v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mFirstDrowArrow:Z

    if-nez v0, :cond_0

    invoke-virtual {p0}, Landroid/widget/BubblePopupHorizontalScrollView;->enableDrawArrow()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mFirstDrowArrow:Z

    :cond_0
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 4
    .param p1, "event"    # Landroid/view/MotionEvent;

    .prologue
    const/4 v1, 0x2

    const/4 v0, 0x0

    iput-boolean v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mSkipCheckArrow:Z

    iget-object v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mHandler:Landroid/widget/BubblePopupHorizontalScrollView$ArrowHandler;

    invoke-virtual {v0, v1}, Landroid/widget/BubblePopupHorizontalScrollView$ArrowHandler;->removeMessages(I)V

    iget-object v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mHandler:Landroid/widget/BubblePopupHorizontalScrollView$ArrowHandler;

    const-wide/16 v2, 0x708

    invoke-virtual {v0, v1, v2, v3}, Landroid/widget/BubblePopupHorizontalScrollView$ArrowHandler;->sendEmptyMessageDelayed(IJ)Z

    iget-object v0, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mScroller2:Landroid/widget/OverScroller;

    invoke-virtual {v0}, Landroid/widget/OverScroller;->abortAnimation()V

    invoke-super {p0, p1}, Landroid/widget/HorizontalScrollView;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v0

    return v0
.end method

.method public registerImageView(Landroid/widget/ImageView;Landroid/widget/ImageView;)V
    .locals 0
    .param p1, "leftArrowView"    # Landroid/widget/ImageView;
    .param p2, "rightArrowView"    # Landroid/widget/ImageView;

    .prologue
    iput-object p1, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mLeftVisibleArrowView:Landroid/widget/ImageView;

    iput-object p2, p0, Landroid/widget/BubblePopupHorizontalScrollView;->mRightVisibleArrowView:Landroid/widget/ImageView;

    return-void
.end method
