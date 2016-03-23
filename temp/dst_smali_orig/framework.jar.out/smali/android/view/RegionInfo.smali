.class Landroid/view/RegionInfo;
.super Ljava/lang/Object;
.source "RegionInfo.java"


# static fields
.field private static isPortrait:Z

.field private static lcdRatio:I

.field private static lcd_x:I

.field private static lcd_y:I


# instance fields
.field private edgeSize:I

.field private validX:I

.field private validY:I


# direct methods
.method constructor <init>(I)V
    .locals 0
    .param p1, "size"    # I

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-virtual {p0, p1}, Landroid/view/RegionInfo;->setEdgeSize(I)V

    return-void
.end method

.method static getLCDRatio()I
    .locals 1

    .prologue
    sget v0, Landroid/view/RegionInfo;->lcdRatio:I

    return v0
.end method

.method static setLCDSize(II)V
    .locals 2
    .param p0, "x"    # I
    .param p1, "y"    # I

    .prologue
    sput p0, Landroid/view/RegionInfo;->lcd_x:I

    sput p1, Landroid/view/RegionInfo;->lcd_y:I

    sget v0, Landroid/view/RegionInfo;->lcd_x:I

    sget v1, Landroid/view/RegionInfo;->lcd_y:I

    div-int/2addr v0, v1

    sput v0, Landroid/view/RegionInfo;->lcdRatio:I

    return-void
.end method

.method static setOrientation(Z)V
    .locals 0
    .param p0, "portrait"    # Z

    .prologue
    sput-boolean p0, Landroid/view/RegionInfo;->isPortrait:Z

    return-void
.end method


# virtual methods
.method getLeftEdgeRegion()I
    .locals 1

    .prologue
    iget v0, p0, Landroid/view/RegionInfo;->edgeSize:I

    return v0
.end method

.method getRightEdgeRegion()I
    .locals 1

    .prologue
    sget-boolean v0, Landroid/view/RegionInfo;->isPortrait:Z

    if-eqz v0, :cond_0

    iget v0, p0, Landroid/view/RegionInfo;->validX:I

    :goto_0
    return v0

    :cond_0
    iget v0, p0, Landroid/view/RegionInfo;->validY:I

    goto :goto_0
.end method

.method setEdgeSize(I)V
    .locals 2
    .param p1, "edge"    # I

    .prologue
    iput p1, p0, Landroid/view/RegionInfo;->edgeSize:I

    sget v0, Landroid/view/RegionInfo;->lcd_x:I

    iget v1, p0, Landroid/view/RegionInfo;->edgeSize:I

    sub-int/2addr v0, v1

    iput v0, p0, Landroid/view/RegionInfo;->validX:I

    sget v0, Landroid/view/RegionInfo;->lcd_y:I

    iget v1, p0, Landroid/view/RegionInfo;->edgeSize:I

    sub-int/2addr v0, v1

    iput v0, p0, Landroid/view/RegionInfo;->validY:I

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "LCD["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Landroid/view/RegionInfo;->lcd_x:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget v1, Landroid/view/RegionInfo;->lcd_y:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "] Edge["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Landroid/view/RegionInfo;->getLeftEdgeRegion()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Landroid/view/RegionInfo;->getRightEdgeRegion()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
