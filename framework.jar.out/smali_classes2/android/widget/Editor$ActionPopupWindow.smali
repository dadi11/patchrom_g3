.class Landroid/widget/Editor$ActionPopupWindow;
.super Landroid/widget/Editor$PinnedPopupWindow;
.source "Editor.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/widget/Editor;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "ActionPopupWindow"
.end annotation


# instance fields
.field private POPUP_TEXT_LAYOUT:I

.field private isTextLinkInstalled:Z

.field private mBubblePopupLeftArrow:Landroid/widget/ImageView;

.field private mBubblePopupRightArrow:Landroid/widget/ImageView;

.field private mBubblePopupScrollView:Landroid/widget/BubblePopupHorizontalScrollView;

.field private mCliptrayTextView:Landroid/widget/TextView;

.field private mCopyTextView:Landroid/widget/TextView;

.field private mCutTextView:Landroid/widget/TextView;

.field private mPasteTextView:Landroid/widget/TextView;

.field private mReplaceTextView:Landroid/widget/TextView;

.field private mSelectAllTextView:Landroid/widget/TextView;

.field private mTextLinkView:Landroid/widget/TextView;

.field final synthetic this$0:Landroid/widget/Editor;


# direct methods
.method private constructor <init>(Landroid/widget/Editor;)V
    .locals 1

    .prologue
    .line 3267
    iput-object p1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    invoke-direct {p0, p1}, Landroid/widget/Editor$PinnedPopupWindow;-><init>(Landroid/widget/Editor;)V

    .line 3268
    const v0, 0x10900d8

    iput v0, p0, Landroid/widget/Editor$ActionPopupWindow;->POPUP_TEXT_LAYOUT:I

    .line 3284
    const/4 v0, 0x0

    iput-boolean v0, p0, Landroid/widget/Editor$ActionPopupWindow;->isTextLinkInstalled:Z

    return-void
.end method

.method synthetic constructor <init>(Landroid/widget/Editor;Landroid/widget/Editor$1;)V
    .locals 0
    .param p1, "x0"    # Landroid/widget/Editor;
    .param p2, "x1"    # Landroid/widget/Editor$1;

    .prologue
    .line 3267
    invoke-direct {p0, p1}, Landroid/widget/Editor$ActionPopupWindow;-><init>(Landroid/widget/Editor;)V

    return-void
.end method

.method private getPositionYAboveHandle(II)I
    .locals 7
    .param p1, "offset"    # I
    .param p2, "parentPosition"    # I

    .prologue
    .line 3592
    iget-object v6, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v6}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v6

    invoke-virtual {v6}, Landroid/widget/TextView;->getLayout()Landroid/text/Layout;

    move-result-object v1

    .line 3593
    .local v1, "layout":Landroid/text/Layout;
    invoke-virtual {v1, p1}, Landroid/text/Layout;->getLineForOffset(I)I

    move-result v2

    .line 3594
    .local v2, "line":I
    invoke-virtual {p0, v2}, Landroid/widget/Editor$ActionPopupWindow;->getVerticalLocalPosition(I)I

    move-result v5

    .line 3595
    .local v5, "positionY":I
    iget-object v6, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v6}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v6

    invoke-virtual {v6}, Landroid/widget/TextView;->viewportToContentVerticalOffset()I

    move-result v6

    add-int/2addr v5, v6

    .line 3596
    add-int/2addr v5, p2

    .line 3599
    invoke-virtual {v1, v2}, Landroid/text/Layout;->getLineTop(I)I

    move-result v4

    .line 3600
    .local v4, "lineTop":I
    invoke-virtual {v1, v2}, Landroid/text/Layout;->getLineBottom(I)I

    move-result v3

    .line 3601
    .local v3, "lineBottom":I
    iget-object v6, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    invoke-virtual {v6}, Landroid/view/ViewGroup;->getMeasuredHeight()I

    move-result v6

    add-int v0, v5, v6

    .line 3602
    .local v0, "contentBottom":I
    if-lt v5, v4, :cond_0

    if-le v5, v3, :cond_1

    :cond_0
    if-lt v0, v4, :cond_2

    if-gt v0, v3, :cond_2

    .line 3604
    :cond_1
    const/4 v5, -0x1

    .line 3606
    .end local v5    # "positionY":I
    :cond_2
    return v5
.end method

.method private getPositionYBelowHandle(II)I
    .locals 5
    .param p1, "offset"    # I
    .param p2, "parentPosition"    # I

    .prologue
    .line 3612
    iget-object v3, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v3}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v3

    invoke-virtual {v3}, Landroid/widget/TextView;->getLayout()Landroid/text/Layout;

    move-result-object v3

    invoke-virtual {v3, p1}, Landroid/text/Layout;->getLineForOffset(I)I

    move-result v1

    .line 3613
    .local v1, "line":I
    iget-object v3, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v3}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v3

    invoke-virtual {v3}, Landroid/widget/TextView;->getLayout()Landroid/text/Layout;

    move-result-object v3

    invoke-virtual {v3, v1}, Landroid/text/Layout;->getLineBottom(I)I

    move-result v2

    .line 3614
    .local v2, "positionY":I
    iget-object v3, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v3}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v3

    invoke-virtual {v3}, Landroid/widget/TextView;->viewportToContentVerticalOffset()I

    move-result v3

    add-int/2addr v2, v3

    .line 3615
    add-int/2addr v2, p2

    .line 3616
    iget-object v3, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v3}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v3

    invoke-virtual {v3}, Landroid/widget/TextView;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    iget-object v4, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v4}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v4

    iget v4, v4, Landroid/widget/TextView;->mTextSelectHandleRes:I

    invoke-virtual {v3, v4}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 3617
    .local v0, "handle":Landroid/graphics/drawable/Drawable;
    if-eqz v0, :cond_0

    .line 3618
    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v3

    add-int/2addr v2, v3

    .line 3619
    :cond_0
    return v2
.end method


# virtual methods
.method protected clipVertically(I)I
    .locals 9
    .param p1, "positionY"    # I

    .prologue
    .line 3551
    sget-boolean v7, Lcom/lge/config/ConfigBuildFlags;->CAPP_BUBBLE_POPUP:Z

    if-nez v7, :cond_1

    if-gez p1, :cond_1

    .line 3552
    invoke-virtual {p0}, Landroid/widget/Editor$ActionPopupWindow;->getTextOffset()I

    move-result v4

    .line 3553
    .local v4, "offset":I
    iget-object v7, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v7}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v7

    invoke-virtual {v7}, Landroid/widget/TextView;->getLayout()Landroid/text/Layout;

    move-result-object v2

    .line 3554
    .local v2, "layout":Landroid/text/Layout;
    invoke-virtual {v2, v4}, Landroid/text/Layout;->getLineForOffset(I)I

    move-result v3

    .line 3555
    .local v3, "line":I
    invoke-virtual {v2, v3}, Landroid/text/Layout;->getLineBottom(I)I

    move-result v7

    invoke-virtual {v2, v3}, Landroid/text/Layout;->getLineTop(I)I

    move-result v8

    sub-int/2addr v7, v8

    add-int/2addr p1, v7

    .line 3556
    iget-object v7, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    invoke-virtual {v7}, Landroid/view/ViewGroup;->getMeasuredHeight()I

    move-result v7

    add-int/2addr p1, v7

    .line 3559
    iget-object v7, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v7}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v7

    invoke-virtual {v7}, Landroid/widget/TextView;->getContext()Landroid/content/Context;

    move-result-object v7

    iget-object v8, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v8}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v8

    iget v8, v8, Landroid/widget/TextView;->mTextSelectHandleRes:I

    invoke-virtual {v7, v8}, Landroid/content/Context;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    .line 3561
    .local v1, "handle":Landroid/graphics/drawable/Drawable;
    invoke-virtual {v1}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v7

    add-int/2addr p1, v7

    .line 3587
    .end local v1    # "handle":Landroid/graphics/drawable/Drawable;
    .end local v2    # "layout":Landroid/text/Layout;
    .end local v3    # "line":I
    .end local v4    # "offset":I
    :cond_0
    :goto_0
    return p1

    .line 3562
    :cond_1
    sget-boolean v7, Lcom/lge/config/ConfigBuildFlags;->CAPP_BUBBLE_POPUP:Z

    if-eqz v7, :cond_0

    .line 3563
    move v5, p1

    .line 3564
    .local v5, "parentPosition":I
    const/4 v6, 0x0

    .line 3565
    .local v6, "positionY_temp":I
    iget-object v7, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    iget-object v8, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v8}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v8

    invoke-virtual {v8}, Landroid/widget/TextView;->getSelectionStart()I

    move-result v8

    # invokes: Landroid/widget/Editor;->isOffsetVisible(I)Z
    invoke-static {v7, v8}, Landroid/widget/Editor;->access$1700(Landroid/widget/Editor;I)Z

    move-result v7

    if-eqz v7, :cond_3

    iget-object v7, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    iget-object v8, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v8}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v8

    invoke-virtual {v8}, Landroid/widget/TextView;->getSelectionEnd()I

    move-result v8

    # invokes: Landroid/widget/Editor;->isOffsetVisible(I)Z
    invoke-static {v7, v8}, Landroid/widget/Editor;->access$1700(Landroid/widget/Editor;I)Z

    move-result v7

    if-eqz v7, :cond_3

    .line 3566
    iget-object v7, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v7}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v7

    invoke-virtual {v7}, Landroid/widget/TextView;->getSelectionStart()I

    move-result v7

    invoke-direct {p0, v7, v5}, Landroid/widget/Editor$ActionPopupWindow;->getPositionYAboveHandle(II)I

    move-result v6

    .line 3567
    if-gez v6, :cond_2

    .line 3568
    iget-object v7, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v7}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v7

    invoke-virtual {v7}, Landroid/widget/TextView;->getSelectionEnd()I

    move-result v7

    invoke-direct {p0, v7, v5}, Landroid/widget/Editor$ActionPopupWindow;->getPositionYBelowHandle(II)I

    move-result v6

    .line 3584
    :cond_2
    :goto_1
    move p1, v6

    goto :goto_0

    .line 3570
    :cond_3
    iget-object v7, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    iget-object v8, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v8}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v8

    invoke-virtual {v8}, Landroid/widget/TextView;->getSelectionStart()I

    move-result v8

    # invokes: Landroid/widget/Editor;->isOffsetVisible(I)Z
    invoke-static {v7, v8}, Landroid/widget/Editor;->access$1700(Landroid/widget/Editor;I)Z

    move-result v7

    if-eqz v7, :cond_4

    .line 3571
    iget-object v7, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v7}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v7

    invoke-virtual {v7}, Landroid/widget/TextView;->getSelectionStart()I

    move-result v7

    invoke-direct {p0, v7, v5}, Landroid/widget/Editor$ActionPopupWindow;->getPositionYAboveHandle(II)I

    move-result v6

    .line 3572
    if-gez v6, :cond_2

    .line 3573
    iget-object v7, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v7}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v7

    invoke-virtual {v7}, Landroid/widget/TextView;->getSelectionStart()I

    move-result v7

    invoke-direct {p0, v7, v5}, Landroid/widget/Editor$ActionPopupWindow;->getPositionYBelowHandle(II)I

    move-result v6

    goto :goto_1

    .line 3575
    :cond_4
    iget-object v7, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    iget-object v8, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v8}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v8

    invoke-virtual {v8}, Landroid/widget/TextView;->getSelectionEnd()I

    move-result v8

    # invokes: Landroid/widget/Editor;->isOffsetVisible(I)Z
    invoke-static {v7, v8}, Landroid/widget/Editor;->access$1700(Landroid/widget/Editor;I)Z

    move-result v7

    if-eqz v7, :cond_5

    .line 3576
    iget-object v7, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v7}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v7

    invoke-virtual {v7}, Landroid/widget/TextView;->getSelectionEnd()I

    move-result v7

    invoke-direct {p0, v7, v5}, Landroid/widget/Editor$ActionPopupWindow;->getPositionYBelowHandle(II)I

    move-result v6

    .line 3578
    iget-object v7, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v7}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v7

    invoke-virtual {v7}, Landroid/widget/TextView;->getContext()Landroid/content/Context;

    move-result-object v7

    invoke-virtual {v7}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    invoke-virtual {v7}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .line 3579
    .local v0, "displayMetrics":Landroid/util/DisplayMetrics;
    iget v7, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    iget-object v8, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    invoke-virtual {v8}, Landroid/view/ViewGroup;->getMeasuredHeight()I

    move-result v8

    sub-int/2addr v7, v8

    if-le v6, v7, :cond_2

    .line 3580
    iget-object v7, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v7}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v7

    invoke-virtual {v7}, Landroid/widget/TextView;->getSelectionEnd()I

    move-result v7

    invoke-direct {p0, v7, v5}, Landroid/widget/Editor$ActionPopupWindow;->getPositionYAboveHandle(II)I

    move-result v6

    goto :goto_1

    .line 3582
    .end local v0    # "displayMetrics":Landroid/util/DisplayMetrics;
    :cond_5
    iget-object v7, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v7}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v7

    invoke-virtual {v7}, Landroid/widget/TextView;->getSelectionStart()I

    move-result v7

    invoke-direct {p0, v7, v5}, Landroid/widget/Editor$ActionPopupWindow;->getPositionYBelowHandle(II)I

    move-result v6

    goto/16 :goto_1
.end method

.method protected createPopupWindow()V
    .locals 4

    .prologue
    .line 3290
    new-instance v0, Landroid/widget/PopupWindow;

    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v1}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/TextView;->getContext()Landroid/content/Context;

    move-result-object v1

    const/4 v2, 0x0

    const v3, 0x10102c8

    invoke-direct {v0, v1, v2, v3}, Landroid/widget/PopupWindow;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    iput-object v0, p0, Landroid/widget/Editor$ActionPopupWindow;->mPopupWindow:Landroid/widget/PopupWindow;

    .line 3292
    iget-object v0, p0, Landroid/widget/Editor$ActionPopupWindow;->mPopupWindow:Landroid/widget/PopupWindow;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/PopupWindow;->setClippingEnabled(Z)V

    .line 3293
    sget-boolean v0, Lcom/lge/config/ConfigBuildFlags;->CAPP_BUBBLE_POPUP:Z

    if-eqz v0, :cond_0

    .line 3295
    iget-object v0, p0, Landroid/widget/Editor$ActionPopupWindow;->mPopupWindow:Landroid/widget/PopupWindow;

    const v1, 0x1030002

    invoke-virtual {v0, v1}, Landroid/widget/PopupWindow;->setAnimationStyle(I)V

    .line 3297
    :cond_0
    return-void
.end method

.method protected getTextOffset()I
    .locals 2

    .prologue
    .line 3541
    iget-object v0, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v0}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/TextView;->getSelectionStart()I

    move-result v0

    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v1}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/TextView;->getSelectionEnd()I

    move-result v1

    add-int/2addr v0, v1

    div-int/lit8 v0, v0, 0x2

    return v0
.end method

.method protected getVerticalLocalPosition(I)I
    .locals 2
    .param p1, "line"    # I

    .prologue
    .line 3546
    iget-object v0, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v0}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/TextView;->getLayout()Landroid/text/Layout;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/text/Layout;->getLineTop(I)I

    move-result v0

    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    invoke-virtual {v1}, Landroid/view/ViewGroup;->getMeasuredHeight()I

    move-result v1

    sub-int/2addr v0, v1

    return v0
.end method

.method protected initContentView()V
    .locals 14

    .prologue
    const v13, 0x108071b

    const/4 v11, -0x2

    const/4 v12, 0x0

    .line 3301
    sget-boolean v9, Lcom/lge/config/ConfigBuildFlags;->CAPP_BUBBLE_POPUP:Z

    if-nez v9, :cond_0

    .line 3302
    new-instance v2, Landroid/widget/LinearLayout;

    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v9}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v9

    invoke-virtual {v9}, Landroid/widget/TextView;->getContext()Landroid/content/Context;

    move-result-object v9

    invoke-direct {v2, v9}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 3303
    .local v2, "linearLayout":Landroid/widget/LinearLayout;
    const/4 v9, 0x0

    invoke-virtual {v2, v9}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 3304
    iput-object v2, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    .line 3305
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    invoke-virtual {v9, v13}, Landroid/view/ViewGroup;->setBackgroundResource(I)V

    .line 3309
    .end local v2    # "linearLayout":Landroid/widget/LinearLayout;
    :cond_0
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v9}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v9

    invoke-virtual {v9}, Landroid/widget/TextView;->getContext()Landroid/content/Context;

    move-result-object v9

    const-string v10, "layout_inflater"

    invoke-virtual {v9, v10}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/LayoutInflater;

    .line 3312
    .local v1, "inflater":Landroid/view/LayoutInflater;
    new-instance v8, Landroid/view/ViewGroup$LayoutParams;

    invoke-direct {v8, v11, v11}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    .line 3315
    .local v8, "wrapContent":Landroid/view/ViewGroup$LayoutParams;
    const/4 v5, 0x0

    .line 3316
    .local v5, "parentContentView":Landroid/view/ViewGroup;
    sget-boolean v9, Lcom/lge/config/ConfigBuildFlags;->CAPP_BUBBLE_POPUP:Z

    if-eqz v9, :cond_3

    .line 3318
    sget v9, Lcom/lge/internal/R$layout;->bubble_item:I

    iput v9, p0, Landroid/widget/Editor$ActionPopupWindow;->POPUP_TEXT_LAYOUT:I

    .line 3319
    sget v9, Lcom/lge/internal/R$layout;->bubble_action_custom:I

    invoke-virtual {v1, v9, v12}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v5

    .end local v5    # "parentContentView":Landroid/view/ViewGroup;
    check-cast v5, Landroid/view/ViewGroup;

    .line 3320
    .restart local v5    # "parentContentView":Landroid/view/ViewGroup;
    invoke-virtual {v5, v13}, Landroid/view/ViewGroup;->setBackgroundResource(I)V

    .line 3322
    sget v9, Lcom/lge/internal/R$id;->bubble_popup_tracks:I

    invoke-virtual {v5, v9}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v9

    check-cast v9, Landroid/view/ViewGroup;

    iput-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    .line 3323
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    if-nez v9, :cond_2

    .line 3324
    iput-object v5, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    .line 3416
    :cond_1
    :goto_0
    return-void

    .line 3328
    :cond_2
    sget v9, Lcom/lge/internal/R$id;->bubble_popup_arrow_left:I

    invoke-virtual {v5, v9}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v9

    check-cast v9, Landroid/widget/ImageView;

    iput-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mBubblePopupLeftArrow:Landroid/widget/ImageView;

    .line 3329
    sget v9, Lcom/lge/internal/R$id;->bubble_popup_arrow_right:I

    invoke-virtual {v5, v9}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v9

    check-cast v9, Landroid/widget/ImageView;

    iput-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mBubblePopupRightArrow:Landroid/widget/ImageView;

    .line 3330
    sget v9, Lcom/lge/internal/R$id;->bubble_popup_scroll:I

    invoke-virtual {v5, v9}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v9

    check-cast v9, Landroid/widget/BubblePopupHorizontalScrollView;

    iput-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mBubblePopupScrollView:Landroid/widget/BubblePopupHorizontalScrollView;

    .line 3331
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mBubblePopupScrollView:Landroid/widget/BubblePopupHorizontalScrollView;

    iget-object v10, p0, Landroid/widget/Editor$ActionPopupWindow;->mBubblePopupLeftArrow:Landroid/widget/ImageView;

    iget-object v11, p0, Landroid/widget/Editor$ActionPopupWindow;->mBubblePopupRightArrow:Landroid/widget/ImageView;

    invoke-virtual {v9, v10, v11}, Landroid/widget/BubblePopupHorizontalScrollView;->registerImageView(Landroid/widget/ImageView;Landroid/widget/ImageView;)V

    .line 3334
    iget v9, p0, Landroid/widget/Editor$ActionPopupWindow;->POPUP_TEXT_LAYOUT:I

    invoke-virtual {v1, v9, v12}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v9

    check-cast v9, Landroid/widget/TextView;

    iput-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mSelectAllTextView:Landroid/widget/TextView;

    .line 3335
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mSelectAllTextView:Landroid/widget/TextView;

    invoke-virtual {v9, v8}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 3336
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    iget-object v10, p0, Landroid/widget/Editor$ActionPopupWindow;->mSelectAllTextView:Landroid/widget/TextView;

    invoke-virtual {v9, v10}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    .line 3337
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mSelectAllTextView:Landroid/widget/TextView;

    const v10, 0x104000d

    invoke-virtual {v9, v10}, Landroid/widget/TextView;->setText(I)V

    .line 3338
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mSelectAllTextView:Landroid/widget/TextView;

    invoke-virtual {v9, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 3340
    iget v9, p0, Landroid/widget/Editor$ActionPopupWindow;->POPUP_TEXT_LAYOUT:I

    invoke-virtual {v1, v9, v12}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v9

    check-cast v9, Landroid/widget/TextView;

    iput-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mCutTextView:Landroid/widget/TextView;

    .line 3341
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mCutTextView:Landroid/widget/TextView;

    invoke-virtual {v9, v8}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 3342
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    iget-object v10, p0, Landroid/widget/Editor$ActionPopupWindow;->mCutTextView:Landroid/widget/TextView;

    invoke-virtual {v9, v10}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    .line 3343
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mCutTextView:Landroid/widget/TextView;

    const v10, 0x1040003

    invoke-virtual {v9, v10}, Landroid/widget/TextView;->setText(I)V

    .line 3344
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mCutTextView:Landroid/widget/TextView;

    invoke-virtual {v9, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 3346
    iget v9, p0, Landroid/widget/Editor$ActionPopupWindow;->POPUP_TEXT_LAYOUT:I

    invoke-virtual {v1, v9, v12}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v9

    check-cast v9, Landroid/widget/TextView;

    iput-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mCopyTextView:Landroid/widget/TextView;

    .line 3347
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mCopyTextView:Landroid/widget/TextView;

    invoke-virtual {v9, v8}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 3348
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    iget-object v10, p0, Landroid/widget/Editor$ActionPopupWindow;->mCopyTextView:Landroid/widget/TextView;

    invoke-virtual {v9, v10}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    .line 3349
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mCopyTextView:Landroid/widget/TextView;

    const v10, 0x1040001

    invoke-virtual {v9, v10}, Landroid/widget/TextView;->setText(I)V

    .line 3350
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mCopyTextView:Landroid/widget/TextView;

    invoke-virtual {v9, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 3353
    :cond_3
    iget v9, p0, Landroid/widget/Editor$ActionPopupWindow;->POPUP_TEXT_LAYOUT:I

    invoke-virtual {v1, v9, v12}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v9

    check-cast v9, Landroid/widget/TextView;

    iput-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mPasteTextView:Landroid/widget/TextView;

    .line 3354
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mPasteTextView:Landroid/widget/TextView;

    invoke-virtual {v9, v8}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 3355
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    iget-object v10, p0, Landroid/widget/Editor$ActionPopupWindow;->mPasteTextView:Landroid/widget/TextView;

    invoke-virtual {v9, v10}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    .line 3356
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mPasteTextView:Landroid/widget/TextView;

    const v10, 0x104000b

    invoke-virtual {v9, v10}, Landroid/widget/TextView;->setText(I)V

    .line 3357
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mPasteTextView:Landroid/widget/TextView;

    invoke-virtual {v9, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 3359
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->cliptrayUtils:Landroid/widget/CliptrayUtils;
    invoke-static {v9}, Landroid/widget/Editor;->access$2700(Landroid/widget/Editor;)Landroid/widget/CliptrayUtils;

    move-result-object v9

    iget-object v10, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    invoke-virtual {v9, v1, v8, v10, p0}, Landroid/widget/CliptrayUtils;->initCliptrayPopupWindow(Landroid/view/LayoutInflater;Landroid/view/ViewGroup$LayoutParams;Landroid/view/ViewGroup;Landroid/view/View$OnClickListener;)V

    .line 3361
    sget-boolean v9, Lcom/lge/config/ConfigBuildFlags;->CAPP_BUBBLE_POPUP:Z

    if-nez v9, :cond_4

    .line 3362
    iget v9, p0, Landroid/widget/Editor$ActionPopupWindow;->POPUP_TEXT_LAYOUT:I

    invoke-virtual {v1, v9, v12}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v9

    check-cast v9, Landroid/widget/TextView;

    iput-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mReplaceTextView:Landroid/widget/TextView;

    .line 3363
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mReplaceTextView:Landroid/widget/TextView;

    invoke-virtual {v9, v8}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 3364
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    iget-object v10, p0, Landroid/widget/Editor$ActionPopupWindow;->mReplaceTextView:Landroid/widget/TextView;

    invoke-virtual {v9, v10}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    .line 3365
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mReplaceTextView:Landroid/widget/TextView;

    const v10, 0x104045e

    invoke-virtual {v9, v10}, Landroid/widget/TextView;->setText(I)V

    .line 3366
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mReplaceTextView:Landroid/widget/TextView;

    invoke-virtual {v9, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 3377
    :cond_4
    sget-boolean v9, Lcom/lge/config/ConfigBuildFlags;->CAPP_BUBBLE_POPUP:Z

    if-eqz v9, :cond_1

    .line 3380
    iget v9, p0, Landroid/widget/Editor$ActionPopupWindow;->POPUP_TEXT_LAYOUT:I

    invoke-virtual {v1, v9, v12}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v9

    check-cast v9, Landroid/widget/TextView;

    iput-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mTextLinkView:Landroid/widget/TextView;

    .line 3381
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mTextLinkView:Landroid/widget/TextView;

    invoke-virtual {v9, v8}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 3382
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    iget-object v10, p0, Landroid/widget/Editor$ActionPopupWindow;->mTextLinkView:Landroid/widget/TextView;

    invoke-virtual {v9, v10}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    .line 3383
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mTextLinkView:Landroid/widget/TextView;

    sget v10, Lcom/lge/internal/R$string;->Text_Link:I

    invoke-virtual {v9, v10}, Landroid/widget/TextView;->setText(I)V

    .line 3384
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mTextLinkView:Landroid/widget/TextView;

    invoke-virtual {v9, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 3386
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    iget-object v9, v9, Landroid/widget/Editor;->mCustomMode:Landroid/view/ActionMode;

    if-eqz v9, :cond_6

    .line 3387
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    iget-object v9, v9, Landroid/widget/Editor;->mCustomMode:Landroid/view/ActionMode;

    invoke-virtual {v9}, Landroid/view/ActionMode;->getMenu()Landroid/view/Menu;

    move-result-object v3

    .line 3388
    .local v3, "m":Landroid/view/Menu;
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    invoke-interface {v3}, Landroid/view/Menu;->size()I

    move-result v9

    if-ge v0, v9, :cond_6

    .line 3389
    invoke-interface {v3, v0}, Landroid/view/Menu;->getItem(I)Landroid/view/MenuItem;

    move-result-object v4

    .line 3390
    .local v4, "mi":Landroid/view/MenuItem;
    invoke-interface {v4}, Landroid/view/MenuItem;->getTitle()Ljava/lang/CharSequence;

    move-result-object v6

    .line 3391
    .local v6, "text":Ljava/lang/CharSequence;
    iget v9, p0, Landroid/widget/Editor$ActionPopupWindow;->POPUP_TEXT_LAYOUT:I

    invoke-virtual {v1, v9, v12}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v7

    check-cast v7, Landroid/widget/TextView;

    .line 3392
    .local v7, "tv":Landroid/widget/TextView;
    if-eqz v7, :cond_5

    invoke-interface {v4}, Landroid/view/MenuItem;->isVisible()Z

    move-result v9

    if-eqz v9, :cond_5

    .line 3393
    invoke-virtual {v7, v6}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 3394
    invoke-virtual {v7, v4}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    .line 3395
    invoke-virtual {v7, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 3396
    invoke-virtual {v7, v8}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 3397
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    invoke-virtual {v9, v7}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    .line 3388
    :cond_5
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 3402
    .end local v0    # "i":I
    .end local v3    # "m":Landroid/view/Menu;
    .end local v4    # "mi":Landroid/view/MenuItem;
    .end local v6    # "text":Ljava/lang/CharSequence;
    .end local v7    # "tv":Landroid/widget/TextView;
    :cond_6
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    iget-object v9, v9, Landroid/widget/Editor;->mSelectionActionModeMenu:Landroid/view/Menu;

    if-eqz v9, :cond_b

    .line 3404
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    iget-object v9, v9, Landroid/widget/Editor;->mSelectionActionModeMenu:Landroid/view/Menu;

    const v10, 0x102001f

    invoke-interface {v9, v10}, Landroid/view/Menu;->findItem(I)Landroid/view/MenuItem;

    move-result-object v9

    if-nez v9, :cond_7

    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    iget-object v10, p0, Landroid/widget/Editor$ActionPopupWindow;->mSelectAllTextView:Landroid/widget/TextView;

    invoke-virtual {v9, v10}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    .line 3405
    :cond_7
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    iget-object v9, v9, Landroid/widget/Editor;->mSelectionActionModeMenu:Landroid/view/Menu;

    const v10, 0x1020020

    invoke-interface {v9, v10}, Landroid/view/Menu;->findItem(I)Landroid/view/MenuItem;

    move-result-object v9

    if-nez v9, :cond_8

    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    iget-object v10, p0, Landroid/widget/Editor$ActionPopupWindow;->mCutTextView:Landroid/widget/TextView;

    invoke-virtual {v9, v10}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    .line 3406
    :cond_8
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    iget-object v9, v9, Landroid/widget/Editor;->mSelectionActionModeMenu:Landroid/view/Menu;

    const v10, 0x1020021

    invoke-interface {v9, v10}, Landroid/view/Menu;->findItem(I)Landroid/view/MenuItem;

    move-result-object v9

    if-nez v9, :cond_9

    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    iget-object v10, p0, Landroid/widget/Editor$ActionPopupWindow;->mCopyTextView:Landroid/widget/TextView;

    invoke-virtual {v9, v10}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    .line 3407
    :cond_9
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    iget-object v9, v9, Landroid/widget/Editor;->mSelectionActionModeMenu:Landroid/view/Menu;

    const v10, 0x1020022

    invoke-interface {v9, v10}, Landroid/view/Menu;->findItem(I)Landroid/view/MenuItem;

    move-result-object v9

    if-nez v9, :cond_a

    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    iget-object v10, p0, Landroid/widget/Editor$ActionPopupWindow;->mPasteTextView:Landroid/widget/TextView;

    invoke-virtual {v9, v10}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    .line 3410
    :cond_a
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    iput-object v12, v9, Landroid/widget/Editor;->mSelectionActionModeMenu:Landroid/view/Menu;

    .line 3413
    :cond_b
    iput-object v5, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    .line 3414
    iget-object v9, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    const/4 v10, 0x1

    invoke-virtual {v9, v10, v12}, Landroid/view/ViewGroup;->setLayerType(ILandroid/graphics/Paint;)V

    goto/16 :goto_0
.end method

.method protected measureContent()V
    .locals 7

    .prologue
    const/high16 v6, -0x80000000

    .line 3625
    sget-boolean v5, Lcom/lge/config/ConfigBuildFlags;->CAPP_BUBBLE_POPUP:Z

    if-nez v5, :cond_0

    .line 3626
    invoke-super {p0}, Landroid/widget/Editor$PinnedPopupWindow;->measureContent()V

    .line 3656
    :goto_0
    return-void

    .line 3630
    :cond_0
    iget-object v5, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v5}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v5

    invoke-virtual {v5}, Landroid/widget/TextView;->getContext()Landroid/content/Context;

    move-result-object v5

    invoke-virtual {v5}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    invoke-virtual {v5}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .line 3631
    .local v0, "displayMetrics":Landroid/util/DisplayMetrics;
    iget v5, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    invoke-static {v5, v6}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v1

    .line 3633
    .local v1, "horizontalMeasure":I
    iget v5, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    invoke-static {v5, v6}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v3

    .line 3635
    .local v3, "verticalMeasure":I
    const/4 v4, 0x0

    .line 3637
    .local v4, "width":I
    iget-object v5, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    invoke-virtual {v5}, Landroid/view/ViewGroup;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v5

    const/4 v6, -0x2

    iput v6, v5, Landroid/view/ViewGroup$LayoutParams;->width:I

    .line 3638
    iget-object v5, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    invoke-virtual {v5, v1, v3}, Landroid/view/ViewGroup;->measure(II)V

    .line 3639
    iget-object v5, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    invoke-virtual {v5}, Landroid/view/ViewGroup;->getMeasuredWidth()I

    move-result v5

    invoke-static {v4, v5}, Ljava/lang/Math;->max(II)I

    move-result v4

    .line 3643
    iget-object v5, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    const/high16 v6, 0x40000000    # 2.0f

    invoke-static {v4, v6}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v6

    invoke-virtual {v5, v6, v3}, Landroid/view/ViewGroup;->measure(II)V

    .line 3647
    iget-object v5, p0, Landroid/widget/Editor$ActionPopupWindow;->mPopupWindow:Landroid/widget/PopupWindow;

    invoke-virtual {v5}, Landroid/widget/PopupWindow;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v2

    .line 3648
    .local v2, "popupBackground":Landroid/graphics/drawable/Drawable;
    if-eqz v2, :cond_2

    .line 3649
    iget-object v5, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTempRect:Landroid/graphics/Rect;
    invoke-static {v5}, Landroid/widget/Editor;->access$2500(Landroid/widget/Editor;)Landroid/graphics/Rect;

    move-result-object v5

    if-nez v5, :cond_1

    iget-object v5, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    new-instance v6, Landroid/graphics/Rect;

    invoke-direct {v6}, Landroid/graphics/Rect;-><init>()V

    # setter for: Landroid/widget/Editor;->mTempRect:Landroid/graphics/Rect;
    invoke-static {v5, v6}, Landroid/widget/Editor;->access$2502(Landroid/widget/Editor;Landroid/graphics/Rect;)Landroid/graphics/Rect;

    .line 3650
    :cond_1
    iget-object v5, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTempRect:Landroid/graphics/Rect;
    invoke-static {v5}, Landroid/widget/Editor;->access$2500(Landroid/widget/Editor;)Landroid/graphics/Rect;

    move-result-object v5

    invoke-virtual {v2, v5}, Landroid/graphics/drawable/Drawable;->getPadding(Landroid/graphics/Rect;)Z

    .line 3651
    iget-object v5, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTempRect:Landroid/graphics/Rect;
    invoke-static {v5}, Landroid/widget/Editor;->access$2500(Landroid/widget/Editor;)Landroid/graphics/Rect;

    move-result-object v5

    iget v5, v5, Landroid/graphics/Rect;->left:I

    iget-object v6, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTempRect:Landroid/graphics/Rect;
    invoke-static {v6}, Landroid/widget/Editor;->access$2500(Landroid/widget/Editor;)Landroid/graphics/Rect;

    move-result-object v6

    iget v6, v6, Landroid/graphics/Rect;->right:I

    add-int/2addr v5, v6

    add-int/2addr v4, v5

    .line 3654
    :cond_2
    iget-object v5, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    invoke-virtual {v5}, Landroid/view/ViewGroup;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v5

    iput v4, v5, Landroid/view/ViewGroup$LayoutParams;->width:I

    .line 3655
    iget-object v5, p0, Landroid/widget/Editor$ActionPopupWindow;->mPopupWindow:Landroid/widget/PopupWindow;

    invoke-virtual {v5, v4}, Landroid/widget/PopupWindow;->setWidth(I)V

    goto/16 :goto_0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 4
    .param p1, "view"    # Landroid/view/View;

    .prologue
    const/4 v3, 0x0

    .line 3491
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->mPasteTextView:Landroid/widget/TextView;

    if-ne p1, v1, :cond_3

    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v1}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/TextView;->canPaste()Z

    move-result v1

    if-eqz v1, :cond_3

    .line 3492
    sget-boolean v1, Lcom/lge/config/ConfigBuildFlags;->CAPP_BUBBLE_POPUP:Z

    if-eqz v1, :cond_0

    .line 3493
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    invoke-virtual {v1, v3}, Landroid/widget/Editor;->setShowingBubblePopup(Z)V

    .line 3495
    :cond_0
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->cliptrayUtils:Landroid/widget/CliptrayUtils;
    invoke-static {v1}, Landroid/widget/Editor;->access$2700(Landroid/widget/Editor;)Landroid/widget/CliptrayUtils;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/CliptrayUtils;->notifyPaste()V

    .line 3496
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v1}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v1

    const v2, 0x1020022

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->onTextContextMenuItem(I)Z

    .line 3497
    invoke-virtual {p0}, Landroid/widget/Editor$ActionPopupWindow;->hide()V

    .line 3505
    :cond_1
    :goto_0
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->cliptrayUtils:Landroid/widget/CliptrayUtils;
    invoke-static {v1}, Landroid/widget/Editor;->access$2700(Landroid/widget/Editor;)Landroid/widget/CliptrayUtils;

    move-result-object v1

    iget-object v2, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    iget-boolean v2, v2, Landroid/widget/Editor;->mShowSoftInputOnFocus:Z

    invoke-virtual {v1, p1, v2}, Landroid/widget/CliptrayUtils;->showCliptrayfromPopupWindow(Landroid/view/View;Z)V

    .line 3506
    sget-boolean v1, Lcom/lge/config/ConfigBuildFlags;->CAPP_BUBBLE_POPUP:Z

    if-eqz v1, :cond_2

    .line 3507
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->mCopyTextView:Landroid/widget/TextView;

    if-ne p1, v1, :cond_5

    .line 3508
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    invoke-virtual {v1, v3}, Landroid/widget/Editor;->setShowingBubblePopup(Z)V

    .line 3509
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v1}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v1

    const v2, 0x1020021

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->onTextContextMenuItem(I)Z

    .line 3510
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # invokes: Landroid/widget/Editor;->hideCursorControllers()V
    invoke-static {v1}, Landroid/widget/Editor;->access$3200(Landroid/widget/Editor;)V

    .line 3511
    invoke-virtual {p0}, Landroid/widget/Editor$ActionPopupWindow;->hide()V

    .line 3512
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v1}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v1

    check-cast v1, Landroid/text/Spannable;

    iget-object v2, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v2}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v2

    invoke-virtual {v2}, Landroid/widget/TextView;->getSelectionEnd()I

    move-result v2

    invoke-static {v1, v2}, Landroid/text/Selection;->setSelection(Landroid/text/Spannable;I)V

    .line 3537
    :cond_2
    :goto_1
    return-void

    .line 3498
    :cond_3
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->mReplaceTextView:Landroid/widget/TextView;

    if-ne p1, v1, :cond_1

    .line 3499
    sget-boolean v1, Lcom/lge/config/ConfigBuildFlags;->CAPP_BUBBLE_POPUP:Z

    if-eqz v1, :cond_4

    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    invoke-virtual {v1, v3}, Landroid/widget/Editor;->setShowingBubblePopup(Z)V

    .line 3500
    :cond_4
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v1}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/TextView;->getSelectionStart()I

    move-result v1

    iget-object v2, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v2}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v2

    invoke-virtual {v2}, Landroid/widget/TextView;->getSelectionEnd()I

    move-result v2

    add-int/2addr v1, v2

    div-int/lit8 v0, v1, 0x2

    .line 3501
    .local v0, "middle":I
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    invoke-virtual {v1}, Landroid/widget/Editor;->stopSelectionActionMode()V

    .line 3502
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v1}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v1

    check-cast v1, Landroid/text/Spannable;

    invoke-static {v1, v0}, Landroid/text/Selection;->setSelection(Landroid/text/Spannable;I)V

    .line 3503
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    invoke-virtual {v1}, Landroid/widget/Editor;->showSuggestions()V

    goto/16 :goto_0

    .line 3513
    .end local v0    # "middle":I
    :cond_5
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->mCutTextView:Landroid/widget/TextView;

    if-ne p1, v1, :cond_6

    .line 3514
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    invoke-virtual {v1, v3}, Landroid/widget/Editor;->setShowingBubblePopup(Z)V

    .line 3515
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v1}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v1

    const v2, 0x1020020

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->onTextContextMenuItem(I)Z

    .line 3516
    invoke-virtual {p0}, Landroid/widget/Editor$ActionPopupWindow;->hide()V

    goto :goto_1

    .line 3517
    :cond_6
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->mSelectAllTextView:Landroid/widget/TextView;

    if-ne p1, v1, :cond_7

    .line 3518
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/widget/Editor;->setShowingBubblePopup(Z)V

    .line 3519
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v1}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v1

    const v2, 0x102001f

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->onTextContextMenuItem(I)Z

    .line 3521
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->mSelectAllTextView:Landroid/widget/TextView;

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setEnabled(Z)V

    .line 3522
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->mSelectAllTextView:Landroid/widget/TextView;

    const v2, -0x777778

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 3524
    invoke-super {p0}, Landroid/widget/Editor$PinnedPopupWindow;->show()V

    goto :goto_1

    .line 3525
    :cond_7
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    iget-object v1, v1, Landroid/widget/Editor;->mCustomMode:Landroid/view/ActionMode;

    if-eqz v1, :cond_8

    if-eqz p1, :cond_8

    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v1

    if-eqz v1, :cond_8

    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v1

    instance-of v1, v1, Landroid/view/MenuItem;

    if-eqz v1, :cond_8

    .line 3526
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    iget-object v1, v1, Landroid/widget/Editor;->mCustomSelectionActionModeCallback:Landroid/view/ActionMode$Callback;

    if-eqz v1, :cond_2

    .line 3527
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    iget-object v2, v1, Landroid/widget/Editor;->mCustomSelectionActionModeCallback:Landroid/view/ActionMode$Callback;

    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    iget-object v3, v1, Landroid/widget/Editor;->mCustomMode:Landroid/view/ActionMode;

    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/MenuItem;

    invoke-interface {v2, v3, v1}, Landroid/view/ActionMode$Callback;->onActionItemClicked(Landroid/view/ActionMode;Landroid/view/MenuItem;)Z

    goto/16 :goto_1

    .line 3530
    :cond_8
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->mTextLinkView:Landroid/widget/TextView;

    if-ne p1, v1, :cond_2

    .line 3531
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    invoke-virtual {v1, v3}, Landroid/widget/Editor;->setShowingBubblePopup(Z)V

    .line 3532
    iget-object v1, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v1}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v1

    sget v2, Landroid/widget/TextView;->ID_TEXTLINK:I

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->onTextContextMenuItem(I)Z

    .line 3533
    invoke-virtual {p0}, Landroid/widget/Editor$ActionPopupWindow;->hide()V

    goto/16 :goto_1
.end method

.method public show()V
    .locals 15

    .prologue
    .line 3420
    iget-object v13, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v13}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v13

    invoke-virtual {v13}, Landroid/widget/TextView;->canPaste()Z

    move-result v4

    .line 3421
    .local v4, "canPaste":Z
    iget-object v13, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v13}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v13

    invoke-virtual {v13}, Landroid/widget/TextView;->isSuggestionsEnabled()Z

    move-result v13

    if-eqz v13, :cond_b

    iget-object v13, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # invokes: Landroid/widget/Editor;->isCursorInsideSuggestionSpan()Z
    invoke-static {v13}, Landroid/widget/Editor;->access$2800(Landroid/widget/Editor;)Z

    move-result v13

    if-eqz v13, :cond_b

    const/4 v6, 0x1

    .line 3422
    .local v6, "canSuggest":Z
    :goto_0
    iget-object v13, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # invokes: Landroid/widget/Editor;->hasPasswordTransformationMethod()Z
    invoke-static {v13}, Landroid/widget/Editor;->access$2900(Landroid/widget/Editor;)Z

    move-result v9

    .line 3423
    .local v9, "isPassword":Z
    iget-object v14, p0, Landroid/widget/Editor$ActionPopupWindow;->mPasteTextView:Landroid/widget/TextView;

    if-eqz v4, :cond_c

    const/4 v13, 0x0

    :goto_1
    invoke-virtual {v14, v13}, Landroid/widget/TextView;->setVisibility(I)V

    .line 3425
    iget-object v13, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->cliptrayUtils:Landroid/widget/CliptrayUtils;
    invoke-static {v13}, Landroid/widget/Editor;->access$2700(Landroid/widget/Editor;)Landroid/widget/CliptrayUtils;

    move-result-object v13

    iget-object v14, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # invokes: Landroid/widget/Editor;->isLockscreen()Z
    invoke-static {v14}, Landroid/widget/Editor;->access$3000(Landroid/widget/Editor;)Z

    move-result v14

    invoke-virtual {v13, v4, v9, v14}, Landroid/widget/CliptrayUtils;->showCliptrayPopupWindow(ZZZ)V

    .line 3427
    iget-object v13, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v13}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v13

    invoke-virtual {v13}, Landroid/widget/TextView;->getContext()Landroid/content/Context;

    move-result-object v7

    .line 3428
    .local v7, "cnxt":Landroid/content/Context;
    iget-object v13, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v13}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v13

    invoke-virtual {v13}, Landroid/widget/TextView;->canCut()Z

    move-result v3

    .line 3429
    .local v3, "canCut":Z
    iget-object v13, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v13}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v13

    invoke-virtual {v13}, Landroid/widget/TextView;->canCopy()Z

    move-result v2

    .line 3430
    .local v2, "canCopy":Z
    if-nez v3, :cond_0

    if-nez v2, :cond_0

    if-eqz v9, :cond_d

    iget-object v13, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v13}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v13

    invoke-virtual {v13}, Landroid/widget/TextView;->hasSelection()Z

    move-result v13

    if-eqz v13, :cond_d

    :cond_0
    const/4 v5, 0x1

    .line 3431
    .local v5, "canSelectText":Z
    :goto_2
    move v1, v4

    .line 3432
    .local v1, "canClipTray":Z
    iget-object v13, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v13}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v13

    invoke-virtual {v13}, Landroid/widget/TextView;->getSelectionStart()I

    move-result v13

    if-nez v13, :cond_1

    iget-object v13, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v13}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v13

    invoke-virtual {v13}, Landroid/widget/TextView;->getSelectionEnd()I

    move-result v13

    iget-object v14, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v14}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v14

    invoke-virtual {v14}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v14

    invoke-interface {v14}, Ljava/lang/CharSequence;->length()I

    move-result v14

    if-eq v13, v14, :cond_2

    :cond_1
    iget-object v13, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v13}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v13

    invoke-virtual {v13}, Landroid/widget/TextView;->getSelectionEnd()I

    move-result v13

    if-nez v13, :cond_e

    iget-object v13, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v13}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v13

    invoke-virtual {v13}, Landroid/widget/TextView;->getSelectionStart()I

    move-result v13

    iget-object v14, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v14}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    move-result-object v14

    invoke-virtual {v14}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v14

    invoke-interface {v14}, Ljava/lang/CharSequence;->length()I

    move-result v14

    if-ne v13, v14, :cond_e

    :cond_2
    const/4 v8, 0x1

    .line 3437
    .local v8, "isEntireTextSelected":Z
    :goto_3
    sget-boolean v13, Lcom/lge/config/ConfigBuildFlags;->CAPP_BUBBLE_POPUP:Z

    if-eqz v13, :cond_8

    .line 3439
    iget-object v13, p0, Landroid/widget/Editor$ActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    sget v14, Lcom/lge/internal/R$id;->scroll:I

    invoke-virtual {v13, v14}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v11

    check-cast v11, Landroid/widget/HorizontalScrollView;

    .line 3440
    .local v11, "scrollView":Landroid/widget/HorizontalScrollView;
    if-eqz v11, :cond_3

    iget-object v13, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # getter for: Landroid/widget/Editor;->mTextView:Landroid/widget/TextView;
    invoke-static {v13}, Landroid/widget/Editor;->access$800(Landroid/widget/Editor;)Landroid/widget/TextView;

    const/16 v13, 0x11

    invoke-virtual {v11, v13}, Landroid/widget/HorizontalScrollView;->fullScroll(I)Z

    .line 3442
    :cond_3
    iget-object v14, p0, Landroid/widget/Editor$ActionPopupWindow;->mSelectAllTextView:Landroid/widget/TextView;

    if-eqz v5, :cond_f

    const/4 v13, 0x0

    :goto_4
    invoke-virtual {v14, v13}, Landroid/widget/TextView;->setVisibility(I)V

    .line 3443
    iget-object v14, p0, Landroid/widget/Editor$ActionPopupWindow;->mCutTextView:Landroid/widget/TextView;

    if-eqz v3, :cond_10

    const/4 v13, 0x0

    :goto_5
    invoke-virtual {v14, v13}, Landroid/widget/TextView;->setVisibility(I)V

    .line 3444
    iget-object v14, p0, Landroid/widget/Editor$ActionPopupWindow;->mCopyTextView:Landroid/widget/TextView;

    if-eqz v2, :cond_11

    const/4 v13, 0x0

    :goto_6
    invoke-virtual {v14, v13}, Landroid/widget/TextView;->setVisibility(I)V

    .line 3445
    if-eqz v5, :cond_4

    .line 3446
    iget-object v14, p0, Landroid/widget/Editor$ActionPopupWindow;->mSelectAllTextView:Landroid/widget/TextView;

    if-nez v8, :cond_12

    const/4 v13, 0x1

    :goto_7
    invoke-virtual {v14, v13}, Landroid/widget/TextView;->setEnabled(Z)V

    .line 3447
    iget-object v14, p0, Landroid/widget/Editor$ActionPopupWindow;->mSelectAllTextView:Landroid/widget/TextView;

    if-eqz v8, :cond_13

    const v13, -0x777778

    :goto_8
    invoke-virtual {v14, v13}, Landroid/widget/TextView;->setTextColor(I)V

    .line 3450
    :cond_4
    new-instance v12, Landroid/content/Intent;

    const-string v13, "com.lge.smarttext.action.SEND"

    invoke-direct {v12, v13}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 3451
    .local v12, "smartTextIntent":Landroid/content/Intent;
    const-string v13, "text/plain"

    invoke-virtual {v12, v13}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 3452
    if-eqz v7, :cond_6

    .line 3453
    invoke-virtual {v7}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v10

    .line 3454
    .local v10, "pm":Landroid/content/pm/PackageManager;
    const/high16 v13, 0x10000

    invoke-virtual {v10, v12, v13}, Landroid/content/pm/PackageManager;->queryIntentActivities(Landroid/content/Intent;I)Ljava/util/List;

    move-result-object v0

    .line 3455
    .local v0, "activities":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ResolveInfo;>;"
    if-eqz v0, :cond_5

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v13

    if-gtz v13, :cond_14

    .line 3456
    :cond_5
    const/4 v13, 0x0

    iput-boolean v13, p0, Landroid/widget/Editor$ActionPopupWindow;->isTextLinkInstalled:Z

    .line 3461
    .end local v0    # "activities":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ResolveInfo;>;"
    .end local v10    # "pm":Landroid/content/pm/PackageManager;
    :cond_6
    :goto_9
    iget-object v13, p0, Landroid/widget/Editor$ActionPopupWindow;->this$0:Landroid/widget/Editor;

    # invokes: Landroid/widget/Editor;->isFloatingWindow()Z
    invoke-static {v13}, Landroid/widget/Editor;->access$3100(Landroid/widget/Editor;)Z

    move-result v13

    if-nez v13, :cond_15

    iget-boolean v13, p0, Landroid/widget/Editor$ActionPopupWindow;->isTextLinkInstalled:Z

    if-eqz v13, :cond_15

    if-nez v3, :cond_7

    if-eqz v2, :cond_15

    .line 3462
    :cond_7
    iget-object v13, p0, Landroid/widget/Editor$ActionPopupWindow;->mTextLinkView:Landroid/widget/TextView;

    const/4 v14, 0x0

    invoke-virtual {v13, v14}, Landroid/widget/TextView;->setVisibility(I)V

    .line 3469
    .end local v11    # "scrollView":Landroid/widget/HorizontalScrollView;
    .end local v12    # "smartTextIntent":Landroid/content/Intent;
    :cond_8
    :goto_a
    iget-object v14, p0, Landroid/widget/Editor$ActionPopupWindow;->mPasteTextView:Landroid/widget/TextView;

    if-eqz v4, :cond_16

    const/4 v13, 0x0

    :goto_b
    invoke-virtual {v14, v13}, Landroid/widget/TextView;->setVisibility(I)V

    .line 3471
    sget-boolean v13, Lcom/lge/config/ConfigBuildFlags;->CAPP_CLIPTRAY:Z

    if-eqz v13, :cond_9

    .line 3475
    iget-object v13, p0, Landroid/widget/Editor$ActionPopupWindow;->mCliptrayTextView:Landroid/widget/TextView;

    if-eqz v13, :cond_9

    .line 3476
    iget-object v14, p0, Landroid/widget/Editor$ActionPopupWindow;->mCliptrayTextView:Landroid/widget/TextView;

    if-eqz v1, :cond_17

    const/4 v13, 0x0

    :goto_c
    invoke-virtual {v14, v13}, Landroid/widget/TextView;->setVisibility(I)V

    .line 3479
    :cond_9
    sget-boolean v13, Lcom/lge/config/ConfigBuildFlags;->CAPP_BUBBLE_POPUP:Z

    if-nez v13, :cond_19

    .line 3480
    iget-object v14, p0, Landroid/widget/Editor$ActionPopupWindow;->mReplaceTextView:Landroid/widget/TextView;

    if-eqz v6, :cond_18

    const/4 v13, 0x0

    :goto_d
    invoke-virtual {v14, v13}, Landroid/widget/TextView;->setVisibility(I)V

    .line 3481
    if-nez v4, :cond_1a

    if-nez v6, :cond_1a

    .line 3487
    :cond_a
    :goto_e
    return-void

    .line 3421
    .end local v1    # "canClipTray":Z
    .end local v2    # "canCopy":Z
    .end local v3    # "canCut":Z
    .end local v5    # "canSelectText":Z
    .end local v6    # "canSuggest":Z
    .end local v7    # "cnxt":Landroid/content/Context;
    .end local v8    # "isEntireTextSelected":Z
    .end local v9    # "isPassword":Z
    :cond_b
    const/4 v6, 0x0

    goto/16 :goto_0

    .line 3423
    .restart local v6    # "canSuggest":Z
    .restart local v9    # "isPassword":Z
    :cond_c
    const/16 v13, 0x8

    goto/16 :goto_1

    .line 3430
    .restart local v2    # "canCopy":Z
    .restart local v3    # "canCut":Z
    .restart local v7    # "cnxt":Landroid/content/Context;
    :cond_d
    const/4 v5, 0x0

    goto/16 :goto_2

    .line 3432
    .restart local v1    # "canClipTray":Z
    .restart local v5    # "canSelectText":Z
    :cond_e
    const/4 v8, 0x0

    goto/16 :goto_3

    .line 3442
    .restart local v8    # "isEntireTextSelected":Z
    .restart local v11    # "scrollView":Landroid/widget/HorizontalScrollView;
    :cond_f
    const/16 v13, 0x8

    goto/16 :goto_4

    .line 3443
    :cond_10
    const/16 v13, 0x8

    goto/16 :goto_5

    .line 3444
    :cond_11
    const/16 v13, 0x8

    goto/16 :goto_6

    .line 3446
    :cond_12
    const/4 v13, 0x0

    goto/16 :goto_7

    .line 3447
    :cond_13
    const/high16 v13, -0x1000000

    goto/16 :goto_8

    .line 3458
    .restart local v0    # "activities":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ResolveInfo;>;"
    .restart local v10    # "pm":Landroid/content/pm/PackageManager;
    .restart local v12    # "smartTextIntent":Landroid/content/Intent;
    :cond_14
    const/4 v13, 0x1

    iput-boolean v13, p0, Landroid/widget/Editor$ActionPopupWindow;->isTextLinkInstalled:Z

    goto :goto_9

    .line 3463
    .end local v0    # "activities":Ljava/util/List;, "Ljava/util/List<Landroid/content/pm/ResolveInfo;>;"
    .end local v10    # "pm":Landroid/content/pm/PackageManager;
    :cond_15
    iget-object v13, p0, Landroid/widget/Editor$ActionPopupWindow;->mTextLinkView:Landroid/widget/TextView;

    if-eqz v13, :cond_8

    .line 3464
    iget-object v13, p0, Landroid/widget/Editor$ActionPopupWindow;->mTextLinkView:Landroid/widget/TextView;

    const/16 v14, 0x8

    invoke-virtual {v13, v14}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_a

    .line 3469
    .end local v11    # "scrollView":Landroid/widget/HorizontalScrollView;
    .end local v12    # "smartTextIntent":Landroid/content/Intent;
    :cond_16
    const/16 v13, 0x8

    goto :goto_b

    .line 3476
    :cond_17
    const/16 v13, 0x8

    goto :goto_c

    .line 3480
    :cond_18
    const/16 v13, 0x8

    goto :goto_d

    .line 3483
    :cond_19
    if-nez v4, :cond_1a

    if-eqz v5, :cond_a

    .line 3486
    :cond_1a
    invoke-super {p0}, Landroid/widget/Editor$PinnedPopupWindow;->show()V

    goto :goto_e
.end method
