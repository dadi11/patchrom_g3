.class public Lcom/lge/webview/chromium/LGTextDragShadowBuilder;
.super Landroid/view/View$DragShadowBuilder;
.source "LGTextDragShadowBuilder.java"


# static fields
.field private static final DRAG_SHADOW_MAX_TEXT_LENGTH:I = 0x14


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Landroid/view/View$DragShadowBuilder;-><init>()V

    return-void
.end method

.method private constructor <init>(Landroid/view/View;)V
    .locals 0
    .param p1, "view"    # Landroid/view/View;

    .prologue
    invoke-direct {p0, p1}, Landroid/view/View$DragShadowBuilder;-><init>(Landroid/view/View;)V

    return-void
.end method

.method public static fromCharSequence(Landroid/content/Context;Ljava/lang/CharSequence;)Landroid/view/View$DragShadowBuilder;
    .locals 8
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "text"    # Ljava/lang/CharSequence;

    .prologue
    const/16 v7, 0x14

    const/4 v6, -0x2

    const/4 v5, 0x0

    if-nez p1, :cond_0

    new-instance v3, Ljava/lang/IllegalArgumentException;

    const-string v4, "String cannot be null"

    invoke-direct {v3, v4}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v3

    :cond_0
    const v3, 0x10900d7

    const/4 v4, 0x0

    invoke-static {p0, v3, v4}, Landroid/view/View;->inflate(Landroid/content/Context;ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    .local v1, "shadowView":Landroid/widget/TextView;
    if-nez v1, :cond_1

    new-instance v3, Ljava/lang/IllegalArgumentException;

    const-string v4, "Unable to inflate text drag thumbnail"

    invoke-direct {v3, v4}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v3

    :cond_1
    invoke-interface {p1}, Ljava/lang/CharSequence;->length()I

    move-result v3

    if-le v3, v7, :cond_2

    invoke-interface {p1, v5, v7}, Ljava/lang/CharSequence;->subSequence(II)Ljava/lang/CharSequence;

    move-result-object p1

    :cond_2
    new-instance v3, Landroid/view/ViewGroup$LayoutParams;

    invoke-direct {v3, v6, v6}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {v1, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const/high16 v3, -0x1000000

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setTextColor(I)V

    const/16 v3, 0x10

    invoke-virtual {v1, p0, v3}, Landroid/widget/TextView;->setTextAppearance(Landroid/content/Context;I)V

    const/16 v3, 0x11

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setGravity(I)V

    invoke-static {v5, v5}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v2

    .local v2, "size":I
    invoke-virtual {v1, v2, v2}, Landroid/widget/TextView;->measure(II)V

    invoke-virtual {v1}, Landroid/widget/TextView;->getMeasuredWidth()I

    move-result v3

    invoke-virtual {v1}, Landroid/widget/TextView;->getMeasuredHeight()I

    move-result v4

    invoke-virtual {v1, v5, v5, v3, v4}, Landroid/widget/TextView;->layout(IIII)V

    new-instance v0, Lcom/lge/webview/chromium/LGTextDragShadowBuilder;

    invoke-direct {v0, v1}, Lcom/lge/webview/chromium/LGTextDragShadowBuilder;-><init>(Landroid/view/View;)V

    .local v0, "builder":Lcom/lge/webview/chromium/LGTextDragShadowBuilder;
    return-object v0
.end method

.method public static fromTextView(Landroid/content/Context;Landroid/widget/TextView;)Landroid/view/View$DragShadowBuilder;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "textView"    # Landroid/widget/TextView;

    .prologue
    new-instance v0, Lcom/lge/webview/chromium/LGTextDragShadowBuilder;

    invoke-direct {v0, p1}, Lcom/lge/webview/chromium/LGTextDragShadowBuilder;-><init>(Landroid/view/View;)V

    .local v0, "builder":Lcom/lge/webview/chromium/LGTextDragShadowBuilder;
    return-object v0
.end method


# virtual methods
.method public onDrawShadow(Landroid/graphics/Canvas;)V
    .locals 0
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .prologue
    invoke-super {p0, p1}, Landroid/view/View$DragShadowBuilder;->onDrawShadow(Landroid/graphics/Canvas;)V

    return-void
.end method

.method public onProvideShadowMetrics(Landroid/graphics/Point;Landroid/graphics/Point;)V
    .locals 0
    .param p1, "shadowSize"    # Landroid/graphics/Point;
    .param p2, "shadowTouchPoint"    # Landroid/graphics/Point;

    .prologue
    invoke-super {p0, p1, p2}, Landroid/view/View$DragShadowBuilder;->onProvideShadowMetrics(Landroid/graphics/Point;Landroid/graphics/Point;)V

    return-void
.end method
