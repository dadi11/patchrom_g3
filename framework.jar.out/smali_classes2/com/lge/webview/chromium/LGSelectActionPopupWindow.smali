.class public Lcom/lge/webview/chromium/LGSelectActionPopupWindow;
.super Ljava/lang/Object;
.source "LGSelectActionPopupWindow.java"

# interfaces
.implements Lcom/lge/webview/chromium/ILGSelectActionPopupWindow;


# static fields
.field private static final POPUP_TEXT_LAYOUT:I

.field private static final TAG:Ljava/lang/String; = "LGSelectActionPopupWindow"


# instance fields
.field private mActionItems:Ljava/util/Hashtable;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Hashtable",
            "<",
            "Landroid/widget/TextView;",
            "Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;",
            ">;"
        }
    .end annotation
.end field

.field private mClient:Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;

.field private mClientContext:Landroid/content/Context;

.field private mContentView:Landroid/view/ViewGroup;

.field private mIsEditableText:Z

.field private mIsFloatingMode:Z

.field private mPopupWindow:Landroid/widget/PopupWindow;

.field private mPositionX:I

.field private mPositionY:I

.field private mTracks:Landroid/view/ViewGroup;

.field private mVisibleItem:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 48
    sget v0, Lcom/lge/internal/R$layout;->bubble_item:I

    sput v0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->POPUP_TEXT_LAYOUT:I

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;)V
    .locals 9
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "client"    # Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;

    .prologue
    const/4 v8, 0x0

    const/4 v7, 0x1

    const/4 v6, 0x0

    const/4 v5, -0x2

    .line 60
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 46
    iput-object v8, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mActionItems:Ljava/util/Hashtable;

    .line 52
    iput-boolean v6, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mIsEditableText:Z

    .line 53
    iput-boolean v6, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mIsFloatingMode:Z

    .line 54
    iput v6, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mVisibleItem:I

    .line 61
    if-nez p1, :cond_0

    .line 62
    new-instance v2, Ljava/lang/IllegalArgumentException;

    const-string v3, "Context cannot be null"

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 65
    :cond_0
    if-nez p2, :cond_1

    .line 66
    new-instance v2, Ljava/lang/IllegalArgumentException;

    const-string v3, "LGSelectActionPopupClient cannot be null"

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 69
    :cond_1
    iput-object p1, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mClientContext:Landroid/content/Context;

    .line 70
    iput-object p2, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mClient:Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;

    .line 72
    new-instance v2, Landroid/widget/PopupWindow;

    iget-object v3, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mClientContext:Landroid/content/Context;

    const v4, 0x10102c8

    invoke-direct {v2, v3, v8, v4}, Landroid/widget/PopupWindow;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    iput-object v2, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mPopupWindow:Landroid/widget/PopupWindow;

    .line 75
    iget-object v2, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mPopupWindow:Landroid/widget/PopupWindow;

    if-eqz v2, :cond_2

    .line 77
    iget-object v2, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mClient:Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;

    invoke-interface {v2}, Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;->isFloatingMode()Z

    move-result v2

    if-eqz v2, :cond_3

    .line 78
    iget-object v2, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mPopupWindow:Landroid/widget/PopupWindow;

    const/16 v3, 0x7d2

    invoke-virtual {v2, v3}, Landroid/widget/PopupWindow;->setWindowLayoutType(I)V

    .line 79
    iget-object v2, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mPopupWindow:Landroid/widget/PopupWindow;

    invoke-virtual {v2, v6}, Landroid/widget/PopupWindow;->setClippingEnabled(Z)V

    .line 85
    :goto_0
    iget-object v2, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mPopupWindow:Landroid/widget/PopupWindow;

    new-instance v3, Landroid/graphics/drawable/BitmapDrawable;

    invoke-direct {v3}, Landroid/graphics/drawable/BitmapDrawable;-><init>()V

    invoke-virtual {v2, v3}, Landroid/widget/PopupWindow;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 86
    iget-object v2, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mPopupWindow:Landroid/widget/PopupWindow;

    invoke-virtual {v2, v5}, Landroid/widget/PopupWindow;->setWidth(I)V

    .line 87
    iget-object v2, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mPopupWindow:Landroid/widget/PopupWindow;

    invoke-virtual {v2, v5}, Landroid/widget/PopupWindow;->setHeight(I)V

    .line 88
    iget-object v2, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mPopupWindow:Landroid/widget/PopupWindow;

    const v3, 0x1030002

    invoke-virtual {v2, v3}, Landroid/widget/PopupWindow;->setAnimationStyle(I)V

    .line 89
    iget-object v2, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mPopupWindow:Landroid/widget/PopupWindow;

    invoke-virtual {v2, v7}, Landroid/widget/PopupWindow;->setOutsideTouchable(Z)V

    .line 90
    iget-object v2, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mPopupWindow:Landroid/widget/PopupWindow;

    invoke-virtual {v2, v7}, Landroid/widget/PopupWindow;->setTouchable(Z)V

    .line 91
    iget-object v2, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mPopupWindow:Landroid/widget/PopupWindow;

    new-instance v3, Lcom/lge/webview/chromium/LGSelectActionPopupWindow$1;

    invoke-direct {v3, p0}, Lcom/lge/webview/chromium/LGSelectActionPopupWindow$1;-><init>(Lcom/lge/webview/chromium/LGSelectActionPopupWindow;)V

    invoke-virtual {v2, v3}, Landroid/widget/PopupWindow;->setTouchInterceptor(Landroid/view/View$OnTouchListener;)V

    .line 101
    iget-object v2, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mClientContext:Landroid/content/Context;

    const-string v3, "layout_inflater"

    invoke-virtual {v2, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/LayoutInflater;

    .line 103
    .local v0, "inflater":Landroid/view/LayoutInflater;
    sget v2, Lcom/lge/internal/R$layout;->bubble_action:I

    invoke-virtual {v0, v2, v8}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/view/ViewGroup;

    iput-object v2, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    .line 104
    iget-object v2, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    const v3, 0x108071b

    invoke-virtual {v2, v3}, Landroid/view/ViewGroup;->setBackgroundResource(I)V

    .line 105
    new-instance v1, Landroid/view/ViewGroup$LayoutParams;

    invoke-direct {v1, v5, v5}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    .line 107
    .local v1, "wrapContent":Landroid/view/ViewGroup$LayoutParams;
    iget-object v2, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    invoke-virtual {v2, v1}, Landroid/view/ViewGroup;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 108
    iget-object v2, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mPopupWindow:Landroid/widget/PopupWindow;

    iget-object v3, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    invoke-virtual {v2, v3}, Landroid/widget/PopupWindow;->setContentView(Landroid/view/View;)V

    .line 110
    iget-object v2, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    sget v3, Lcom/lge/internal/R$id;->tracks:I

    invoke-virtual {v2, v3}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/view/ViewGroup;

    iput-object v2, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mTracks:Landroid/view/ViewGroup;

    .line 112
    .end local v0    # "inflater":Landroid/view/LayoutInflater;
    .end local v1    # "wrapContent":Landroid/view/ViewGroup$LayoutParams;
    :cond_2
    return-void

    .line 81
    :cond_3
    iget-object v2, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mPopupWindow:Landroid/widget/PopupWindow;

    invoke-virtual {v2, v7}, Landroid/widget/PopupWindow;->setClippingEnabled(Z)V

    goto :goto_0
.end method

.method static synthetic access$000(Lcom/lge/webview/chromium/LGSelectActionPopupWindow;)Ljava/util/Hashtable;
    .locals 1
    .param p0, "x0"    # Lcom/lge/webview/chromium/LGSelectActionPopupWindow;

    .prologue
    .line 38
    iget-object v0, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mActionItems:Ljava/util/Hashtable;

    return-object v0
.end method

.method static synthetic access$100(Lcom/lge/webview/chromium/LGSelectActionPopupWindow;)Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;
    .locals 1
    .param p0, "x0"    # Lcom/lge/webview/chromium/LGSelectActionPopupWindow;

    .prologue
    .line 38
    iget-object v0, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mClient:Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;

    return-object v0
.end method

.method private initSelectActionItem(ILcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;)Landroid/widget/TextView;
    .locals 7
    .param p1, "titleResId"    # I
    .param p2, "selectActionItem"    # Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;

    .prologue
    const/4 v6, -0x2

    .line 131
    if-nez p2, :cond_0

    .line 132
    new-instance v4, Ljava/lang/IllegalArgumentException;

    const-string v5, "LGSelectActionItem cannot be null"

    invoke-direct {v4, v5}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 136
    :cond_0
    iget-object v4, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mClientContext:Landroid/content/Context;

    const-string v5, "layout_inflater"

    invoke-virtual {v4, v5}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/LayoutInflater;

    .line 137
    .local v0, "inflater":Landroid/view/LayoutInflater;
    new-instance v3, Landroid/view/ViewGroup$LayoutParams;

    invoke-direct {v3, v6, v6}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    .line 139
    .local v3, "wrapContent":Landroid/view/ViewGroup$LayoutParams;
    sget v4, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->POPUP_TEXT_LAYOUT:I

    const/4 v5, 0x0

    invoke-virtual {v0, v4, v5}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    .line 140
    .local v1, "textView":Landroid/widget/TextView;
    if-nez v1, :cond_1

    .line 141
    new-instance v4, Ljava/lang/IllegalArgumentException;

    const-string v5, "Unable to inflate POPUP_TEXT_LAYOUT"

    invoke-direct {v4, v5}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 143
    :cond_1
    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 144
    iget-object v4, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mClientContext:Landroid/content/Context;

    invoke-virtual {v4, p1}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v2

    .line 145
    .local v2, "title":Ljava/lang/CharSequence;
    if-nez v2, :cond_2

    .line 146
    const-string v4, "LGSelectActionPopupWindow"

    const-string v5, "Fail to getTitle"

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 147
    const-string v2, "No name"

    .line 149
    :cond_2
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 150
    new-instance v4, Lcom/lge/webview/chromium/LGSelectActionPopupWindow$2;

    invoke-direct {v4, p0}, Lcom/lge/webview/chromium/LGSelectActionPopupWindow$2;-><init>(Lcom/lge/webview/chromium/LGSelectActionPopupWindow;)V

    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 177
    iget-object v4, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mTracks:Landroid/view/ViewGroup;

    invoke-virtual {v4, v1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    .line 178
    return-object v1
.end method

.method private measureContent()V
    .locals 5

    .prologue
    const/high16 v4, -0x80000000

    .line 214
    iget-object v1, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mClientContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .line 215
    .local v0, "displayMetrics":Landroid/util/DisplayMetrics;
    iget-object v1, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    iget v2, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    invoke-static {v2, v4}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v2

    iget v3, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    invoke-static {v3, v4}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v3

    invoke-virtual {v1, v2, v3}, Landroid/view/ViewGroup;->measure(II)V

    .line 220
    return-void
.end method


# virtual methods
.method public addSelectActionItem(ILcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;)V
    .locals 3
    .param p1, "titleResId"    # I
    .param p2, "selectActionItem"    # Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;

    .prologue
    .line 116
    if-nez p2, :cond_0

    .line 117
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "LGSelectActionItem cannot be null"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 120
    :cond_0
    iget-object v1, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mActionItems:Ljava/util/Hashtable;

    if-nez v1, :cond_1

    .line 121
    new-instance v1, Ljava/util/Hashtable;

    invoke-direct {v1}, Ljava/util/Hashtable;-><init>()V

    iput-object v1, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mActionItems:Ljava/util/Hashtable;

    .line 124
    :cond_1
    invoke-direct {p0, p1, p2}, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->initSelectActionItem(ILcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;)Landroid/widget/TextView;

    move-result-object v0

    .line 125
    .local v0, "textView":Landroid/widget/TextView;
    iget-object v1, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mActionItems:Ljava/util/Hashtable;

    if-eqz v1, :cond_2

    if-eqz v0, :cond_2

    .line 126
    iget-object v1, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mActionItems:Ljava/util/Hashtable;

    invoke-virtual {v1, v0, p2}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 128
    :cond_2
    return-void
.end method

.method protected getLocalPosition(Landroid/view/View;)Landroid/graphics/Point;
    .locals 15
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 223
    invoke-direct {p0}, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->measureContent()V

    .line 225
    new-instance v4, Landroid/graphics/Point;

    invoke-direct {v4}, Landroid/graphics/Point;-><init>()V

    .line 227
    .local v4, "point":Landroid/graphics/Point;
    const/4 v6, 0x0

    .line 240
    .local v6, "selection":Landroid/graphics/Rect;
    iget-object v12, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    invoke-virtual {v12}, Landroid/view/ViewGroup;->getMeasuredWidth()I

    move-result v11

    .line 241
    .local v11, "width":I
    iget-object v12, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mContentView:Landroid/view/ViewGroup;

    invoke-virtual {v12}, Landroid/view/ViewGroup;->getMeasuredHeight()I

    move-result v0

    .line 243
    .local v0, "height":I
    const/4 v12, 0x2

    new-array v2, v12, [I

    .line 244
    .local v2, "location":[I
    iget-object v12, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mClient:Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;

    invoke-interface {v12, v2}, Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;->getClientLocationOnScreen([I)V

    .line 245
    iget-object v12, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mClient:Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;

    invoke-interface {v12}, Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;->getClientSelectionRegion()Landroid/graphics/Rect;

    move-result-object v6

    .line 247
    if-nez v6, :cond_0

    .line 248
    new-instance v6, Landroid/graphics/Rect;

    .end local v6    # "selection":Landroid/graphics/Rect;
    invoke-direct {v6}, Landroid/graphics/Rect;-><init>()V

    .line 251
    .restart local v6    # "selection":Landroid/graphics/Rect;
    :cond_0
    iget v12, v6, Landroid/graphics/Rect;->left:I

    const/4 v13, 0x0

    aget v13, v2, v13

    add-int/2addr v12, v13

    iput v12, v6, Landroid/graphics/Rect;->left:I

    .line 252
    iget v12, v6, Landroid/graphics/Rect;->right:I

    const/4 v13, 0x0

    aget v13, v2, v13

    add-int/2addr v12, v13

    iput v12, v6, Landroid/graphics/Rect;->right:I

    .line 253
    iget v12, v6, Landroid/graphics/Rect;->top:I

    const/4 v13, 0x1

    aget v13, v2, v13

    add-int/2addr v12, v13

    iput v12, v6, Landroid/graphics/Rect;->top:I

    .line 254
    iget v12, v6, Landroid/graphics/Rect;->bottom:I

    const/4 v13, 0x1

    aget v13, v2, v13

    add-int/2addr v12, v13

    iput v12, v6, Landroid/graphics/Rect;->bottom:I

    .line 262
    new-instance v5, Landroid/graphics/Rect;

    invoke-direct {v5}, Landroid/graphics/Rect;-><init>()V

    .line 263
    .local v5, "r":Landroid/graphics/Rect;
    iget-object v12, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mClient:Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;

    invoke-interface {v12, v5}, Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;->getClientGlobalVisibleRect(Landroid/graphics/Rect;)Z

    .line 265
    iget-object v12, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mClient:Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;

    invoke-interface {v12}, Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;->isFloatingMode()Z

    move-result v1

    .line 266
    .local v1, "isFloatingMode":Z
    if-eqz v1, :cond_2

    .line 267
    iget v12, v5, Landroid/graphics/Rect;->left:I

    const/4 v13, 0x0

    aget v13, v2, v13

    add-int v8, v12, v13

    .line 268
    .local v8, "webviewLeft":I
    iget v12, v5, Landroid/graphics/Rect;->right:I

    const/4 v13, 0x0

    aget v13, v2, v13

    add-int v9, v12, v13

    .line 269
    .local v9, "webviewRight":I
    iget v12, v5, Landroid/graphics/Rect;->top:I

    const/4 v13, 0x1

    aget v13, v2, v13

    add-int v10, v12, v13

    .line 270
    .local v10, "webviewTop":I
    iget v12, v5, Landroid/graphics/Rect;->bottom:I

    const/4 v13, 0x1

    aget v13, v2, v13

    add-int v7, v12, v13

    .line 278
    .local v7, "webviewBottom":I
    :goto_0
    const/16 v3, 0x96

    .line 281
    .local v3, "offset":I
    iget v12, v6, Landroid/graphics/Rect;->right:I

    if-lt v12, v8, :cond_1

    iget v12, v6, Landroid/graphics/Rect;->left:I

    if-le v12, v9, :cond_3

    .line 282
    :cond_1
    const/4 v4, 0x0

    .line 305
    .end local v4    # "point":Landroid/graphics/Point;
    :goto_1
    return-object v4

    .line 272
    .end local v3    # "offset":I
    .end local v7    # "webviewBottom":I
    .end local v8    # "webviewLeft":I
    .end local v9    # "webviewRight":I
    .end local v10    # "webviewTop":I
    .restart local v4    # "point":Landroid/graphics/Point;
    :cond_2
    iget v8, v5, Landroid/graphics/Rect;->left:I

    .line 273
    .restart local v8    # "webviewLeft":I
    iget v9, v5, Landroid/graphics/Rect;->right:I

    .line 274
    .restart local v9    # "webviewRight":I
    iget v10, v5, Landroid/graphics/Rect;->top:I

    .line 275
    .restart local v10    # "webviewTop":I
    iget v7, v5, Landroid/graphics/Rect;->bottom:I

    .restart local v7    # "webviewBottom":I
    goto :goto_0

    .line 284
    .restart local v3    # "offset":I
    :cond_3
    iget v12, v6, Landroid/graphics/Rect;->right:I

    iget v13, v6, Landroid/graphics/Rect;->right:I

    iget v14, v6, Landroid/graphics/Rect;->left:I

    sub-int/2addr v13, v14

    add-int/2addr v13, v11

    div-int/lit8 v13, v13, 0x2

    sub-int/2addr v12, v13

    iput v12, v4, Landroid/graphics/Point;->x:I

    .line 285
    if-lez v11, :cond_4

    iget v12, v4, Landroid/graphics/Point;->x:I

    if-gez v12, :cond_7

    .line 286
    :cond_4
    const/4 v12, 0x0

    iput v12, v4, Landroid/graphics/Point;->x:I

    .line 294
    :cond_5
    :goto_2
    iget v12, v6, Landroid/graphics/Rect;->bottom:I

    if-lt v12, v10, :cond_6

    iget v12, v6, Landroid/graphics/Rect;->top:I

    if-le v12, v7, :cond_8

    .line 295
    :cond_6
    const/4 v4, 0x0

    goto :goto_1

    .line 287
    :cond_7
    sub-int v12, v9, v11

    iget v13, v4, Landroid/graphics/Point;->x:I

    if-ge v12, v13, :cond_5

    .line 288
    sub-int v12, v9, v11

    iput v12, v4, Landroid/graphics/Point;->x:I

    goto :goto_2

    .line 297
    :cond_8
    iget v12, v6, Landroid/graphics/Rect;->top:I

    sub-int/2addr v12, v10

    sub-int/2addr v12, v3

    if-ge v0, v12, :cond_a

    .line 298
    iget v12, v6, Landroid/graphics/Rect;->top:I

    if-eqz v1, :cond_9

    :cond_9
    sub-int/2addr v12, v0

    sub-int/2addr v12, v3

    iput v12, v4, Landroid/graphics/Point;->y:I

    goto :goto_1

    .line 299
    :cond_a
    iget v12, v6, Landroid/graphics/Rect;->bottom:I

    sub-int v12, v7, v12

    sub-int/2addr v12, v3

    if-ge v0, v12, :cond_b

    .line 300
    iget v12, v6, Landroid/graphics/Rect;->bottom:I

    add-int/2addr v12, v3

    iput v12, v4, Landroid/graphics/Point;->y:I

    goto :goto_1

    .line 302
    :cond_b
    sub-int v12, v7, v10

    sub-int/2addr v12, v0

    div-int/lit8 v12, v12, 0x2

    add-int/2addr v12, v10

    iput v12, v4, Landroid/graphics/Point;->y:I

    goto :goto_1
.end method

.method public hide()V
    .locals 1

    .prologue
    .line 335
    iget-object v0, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mPopupWindow:Landroid/widget/PopupWindow;

    invoke-virtual {v0}, Landroid/widget/PopupWindow;->dismiss()V

    .line 336
    return-void
.end method

.method public isShowing()Z
    .locals 1

    .prologue
    .line 340
    iget-object v0, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mPopupWindow:Landroid/widget/PopupWindow;

    invoke-virtual {v0}, Landroid/widget/PopupWindow;->isShowing()Z

    move-result v0

    return v0
.end method

.method public show(Landroid/view/View;)V
    .locals 5
    .param p1, "v"    # Landroid/view/View;

    .prologue
    const/4 v4, -0x1

    .line 310
    invoke-virtual {p0}, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->updateStatus()V

    .line 312
    iget v1, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mVisibleItem:I

    if-gtz v1, :cond_0

    .line 313
    const-string v1, "TAG"

    const-string v2, "There is no visible Select Action item"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 331
    :goto_0
    return-void

    .line 317
    :cond_0
    invoke-virtual {p0, p1}, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->getLocalPosition(Landroid/view/View;)Landroid/graphics/Point;

    move-result-object v0

    .line 318
    .local v0, "p":Landroid/graphics/Point;
    if-nez v0, :cond_1

    .line 319
    invoke-virtual {p0}, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->hide()V

    goto :goto_0

    .line 322
    :cond_1
    iget v1, v0, Landroid/graphics/Point;->x:I

    iput v1, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mPositionX:I

    .line 323
    iget v1, v0, Landroid/graphics/Point;->y:I

    iput v1, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mPositionY:I

    .line 325
    invoke-virtual {p0}, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->isShowing()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 326
    iget-object v1, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mPopupWindow:Landroid/widget/PopupWindow;

    iget v2, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mPositionX:I

    iget v3, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mPositionY:I

    invoke-virtual {v1, v2, v3, v4, v4}, Landroid/widget/PopupWindow;->update(IIII)V

    goto :goto_0

    .line 329
    :cond_2
    iget-object v1, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mPopupWindow:Landroid/widget/PopupWindow;

    const/16 v2, 0x31

    const/4 v3, 0x0

    iget v4, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mPositionY:I

    invoke-virtual {v1, p1, v2, v3, v4}, Landroid/widget/PopupWindow;->showAtLocation(Landroid/view/View;III)V

    goto :goto_0
.end method

.method public updateStatus()V
    .locals 8

    .prologue
    const/4 v5, 0x0

    .line 185
    iput v5, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mVisibleItem:I

    .line 186
    iget-object v4, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mActionItems:Ljava/util/Hashtable;

    if-nez v4, :cond_1

    .line 211
    :cond_0
    return-void

    .line 190
    :cond_1
    iget-object v4, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mClient:Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;

    if-eqz v4, :cond_2

    .line 191
    iget-object v4, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mClient:Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;

    invoke-interface {v4}, Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;->isFloatingMode()Z

    move-result v4

    iput-boolean v4, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mIsFloatingMode:Z

    .line 192
    iget-object v4, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mClient:Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;

    invoke-interface {v4}, Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionPopupClient;->isEditableText()Z

    move-result v4

    iput-boolean v4, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mIsEditableText:Z

    .line 195
    :cond_2
    iget-object v4, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mActionItems:Ljava/util/Hashtable;

    invoke-virtual {v4}, Ljava/util/Hashtable;->keys()Ljava/util/Enumeration;

    move-result-object v3

    .line 196
    .local v3, "views":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Landroid/widget/TextView;>;"
    :cond_3
    :goto_0
    invoke-interface {v3}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v4

    if-eqz v4, :cond_0

    .line 197
    invoke-interface {v3}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    .line 198
    .local v2, "textView":Landroid/widget/TextView;
    if-eqz v2, :cond_3

    .line 199
    iget-object v4, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mActionItems:Ljava/util/Hashtable;

    invoke-virtual {v4, v2}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;

    .line 200
    .local v1, "item":Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;
    if-eqz v1, :cond_3

    .line 201
    iget-object v4, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mClientContext:Landroid/content/Context;

    iget-boolean v6, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mIsEditableText:Z

    iget-boolean v7, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mIsFloatingMode:Z

    invoke-virtual {v1, v4, v6, v7}, Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;->isVisible(Landroid/content/Context;ZZ)Z

    move-result v0

    .line 202
    .local v0, "isVisible":Z
    if-eqz v0, :cond_4

    .line 203
    iget v4, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mVisibleItem:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/lge/webview/chromium/LGSelectActionPopupWindow;->mVisibleItem:I

    .line 205
    :cond_4
    if-eqz v0, :cond_5

    move v4, v5

    :goto_1
    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setVisibility(I)V

    .line 206
    invoke-virtual {v1}, Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;->isEnabled()Z

    move-result v4

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setEnabled(Z)V

    .line 207
    invoke-virtual {v1}, Lcom/lge/webview/chromium/ILGSelectActionPopupWindow$LGSelectActionItem;->isEnabled()Z

    move-result v4

    const/4 v6, 0x1

    if-ne v4, v6, :cond_6

    const/high16 v4, -0x1000000

    :goto_2
    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_0

    .line 205
    :cond_5
    const/16 v4, 0x8

    goto :goto_1

    .line 207
    :cond_6
    const v4, -0x777778

    goto :goto_2
.end method
