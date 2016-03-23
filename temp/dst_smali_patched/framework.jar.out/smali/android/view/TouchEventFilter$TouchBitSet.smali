.class Landroid/view/TouchEventFilter$TouchBitSet;
.super Ljava/util/BitSet;
.source "TouchEventFilter.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/view/TouchEventFilter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "TouchBitSet"
.end annotation


# instance fields
.field final synthetic this$0:Landroid/view/TouchEventFilter;


# direct methods
.method public constructor <init>(Landroid/view/TouchEventFilter;)V
    .locals 0

    .prologue
    iput-object p1, p0, Landroid/view/TouchEventFilter$TouchBitSet;->this$0:Landroid/view/TouchEventFilter;

    invoke-direct {p0}, Ljava/util/BitSet;-><init>()V

    return-void
.end method

.method public constructor <init>(Landroid/view/TouchEventFilter;I)V
    .locals 0
    .param p2, "mask"    # I

    .prologue
    iput-object p1, p0, Landroid/view/TouchEventFilter$TouchBitSet;->this$0:Landroid/view/TouchEventFilter;

    invoke-direct {p0}, Ljava/util/BitSet;-><init>()V

    invoke-virtual {p0, p2}, Landroid/view/TouchEventFilter$TouchBitSet;->setMask(I)V

    return-void
.end method


# virtual methods
.method public copy(Landroid/view/TouchEventFilter$TouchBitSet;)V
    .locals 1
    .param p1, "other"    # Landroid/view/TouchEventFilter$TouchBitSet;

    .prologue
    invoke-virtual {p1}, Landroid/view/TouchEventFilter$TouchBitSet;->getMask()I

    move-result v0

    invoke-virtual {p0, v0}, Landroid/view/TouchEventFilter$TouchBitSet;->setMask(I)V

    return-void
.end method

.method public getMask()I
    .locals 3

    .prologue
    const/4 v1, 0x0

    .local v1, "mask":I
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    const/16 v2, 0xa

    if-ge v0, v2, :cond_1

    invoke-virtual {p0, v0}, Landroid/view/TouchEventFilter$TouchBitSet;->get(I)Z

    move-result v2

    if-eqz v2, :cond_0

    const/4 v2, 0x1

    shl-int/2addr v2, v0

    or-int/2addr v1, v2

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    return v1
.end method

.method public setMask(I)V
    .locals 2
    .param p1, "mask"    # I

    .prologue
    invoke-virtual {p0}, Landroid/view/TouchEventFilter$TouchBitSet;->clear()V

    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    const/16 v1, 0xa

    if-ge v0, v1, :cond_1

    const/4 v1, 0x1

    shl-int/2addr v1, v0

    and-int/2addr v1, p1

    if-eqz v1, :cond_0

    invoke-virtual {p0, v0}, Landroid/view/TouchEventFilter$TouchBitSet;->set(I)V

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    return-void
.end method
