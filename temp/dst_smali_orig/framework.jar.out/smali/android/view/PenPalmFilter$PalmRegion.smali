.class Landroid/view/PenPalmFilter$PalmRegion;
.super Ljava/lang/Object;
.source "PenPalmFilter.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/view/PenPalmFilter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "PalmRegion"
.end annotation


# instance fields
.field private LARGE_PALM_AREA_SIZE:I

.field private PALM_AREA_SIZE:I

.field private rectList:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/graphics/Rect;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic this$0:Landroid/view/PenPalmFilter;


# direct methods
.method public constructor <init>(Landroid/view/PenPalmFilter;)V
    .locals 3

    .prologue
    iput-object p1, p0, Landroid/view/PenPalmFilter$PalmRegion;->this$0:Landroid/view/PenPalmFilter;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Landroid/view/PenPalmFilter$PalmRegion;->rectList:Ljava/util/ArrayList;

    invoke-static {}, Landroid/view/RegionInfo;->getLCDRatio()I

    move-result v1

    const/4 v2, 0x1

    if-lt v1, v2, :cond_0

    # getter for: Landroid/view/PenPalmFilter;->mContext:Landroid/content/Context;
    invoke-static {p1}, Landroid/view/PenPalmFilter;->access$600(Landroid/view/PenPalmFilter;)Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v1, v1, Landroid/util/DisplayMetrics;->xdpi:F

    float-to-int v1, v1

    :goto_0
    iput v1, p0, Landroid/view/PenPalmFilter$PalmRegion;->LARGE_PALM_AREA_SIZE:I

    iget v1, p0, Landroid/view/PenPalmFilter$PalmRegion;->LARGE_PALM_AREA_SIZE:I

    div-int/lit8 v1, v1, 0x2

    iput v1, p0, Landroid/view/PenPalmFilter$PalmRegion;->PALM_AREA_SIZE:I

    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    const/16 v1, 0xa

    if-ge v0, v1, :cond_1

    iget-object v1, p0, Landroid/view/PenPalmFilter$PalmRegion;->rectList:Ljava/util/ArrayList;

    new-instance v2, Landroid/graphics/Rect;

    invoke-direct {v2}, Landroid/graphics/Rect;-><init>()V

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .end local v0    # "i":I
    :cond_0
    # getter for: Landroid/view/PenPalmFilter;->mContext:Landroid/content/Context;
    invoke-static {p1}, Landroid/view/PenPalmFilter;->access$600(Landroid/view/PenPalmFilter;)Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v1, v1, Landroid/util/DisplayMetrics;->ydpi:F

    float-to-int v1, v1

    goto :goto_0

    .restart local v0    # "i":I
    :cond_1
    invoke-virtual {p0}, Landroid/view/PenPalmFilter$PalmRegion;->init()V

    return-void
.end method


# virtual methods
.method public assignPalm(IIIZ)V
    .locals 6
    .param p1, "id"    # I
    .param p2, "x"    # I
    .param p3, "y"    # I
    .param p4, "largePalm"    # Z

    .prologue
    if-eqz p4, :cond_0

    iget v1, p0, Landroid/view/PenPalmFilter$PalmRegion;->LARGE_PALM_AREA_SIZE:I

    .local v1, "rectSize":I
    :goto_0
    iget-object v2, p0, Landroid/view/PenPalmFilter$PalmRegion;->rectList:Ljava/util/ArrayList;

    invoke-virtual {v2, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/graphics/Rect;

    .local v0, "mRect":Landroid/graphics/Rect;
    sub-int v2, p2, v1

    sub-int v3, p3, v1

    add-int v4, p2, v1

    add-int v5, p3, v1

    invoke-virtual {v0, v2, v3, v4, v5}, Landroid/graphics/Rect;->set(IIII)V

    return-void

    .end local v0    # "mRect":Landroid/graphics/Rect;
    .end local v1    # "rectSize":I
    :cond_0
    iget v1, p0, Landroid/view/PenPalmFilter$PalmRegion;->PALM_AREA_SIZE:I

    goto :goto_0
.end method

.method public checkPalmRegion(II)Z
    .locals 3
    .param p1, "x"    # I
    .param p2, "y"    # I

    .prologue
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget-object v2, p0, Landroid/view/PenPalmFilter$PalmRegion;->rectList:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v0, v2, :cond_1

    iget-object v2, p0, Landroid/view/PenPalmFilter$PalmRegion;->rectList:Ljava/util/ArrayList;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/graphics/Rect;

    .local v1, "mRect":Landroid/graphics/Rect;
    invoke-virtual {v1, p1, p2}, Landroid/graphics/Rect;->contains(II)Z

    move-result v2

    if-eqz v2, :cond_0

    const/4 v2, 0x1

    .end local v1    # "mRect":Landroid/graphics/Rect;
    :goto_1
    return v2

    .restart local v1    # "mRect":Landroid/graphics/Rect;
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .end local v1    # "mRect":Landroid/graphics/Rect;
    :cond_1
    const/4 v2, 0x0

    goto :goto_1
.end method

.method public init()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget-object v2, p0, Landroid/view/PenPalmFilter$PalmRegion;->rectList:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v0, v2, :cond_0

    iget-object v2, p0, Landroid/view/PenPalmFilter$PalmRegion;->rectList:Ljava/util/ArrayList;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/graphics/Rect;

    .local v1, "mRect":Landroid/graphics/Rect;
    invoke-virtual {v1, v3, v3, v3, v3}, Landroid/graphics/Rect;->set(IIII)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .end local v1    # "mRect":Landroid/graphics/Rect;
    :cond_0
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 5

    .prologue
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .local v2, "msg":Ljava/lang/StringBuilder;
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget-object v3, p0, Landroid/view/PenPalmFilter$PalmRegion;->rectList:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-ge v0, v3, :cond_1

    iget-object v3, p0, Landroid/view/PenPalmFilter$PalmRegion;->rectList:Ljava/util/ArrayList;

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/graphics/Rect;

    .local v1, "mRect":Landroid/graphics/Rect;
    invoke-virtual {v1}, Landroid/graphics/Rect;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Landroid/graphics/Rect;->toShortString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .end local v1    # "mRect":Landroid/graphics/Rect;
    :cond_1
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    return-object v3
.end method
