.class public Landroid/view/GripSuppressionFilter;
.super Ljava/lang/Object;
.source "GripSuppressionFilter.java"

# interfaces
.implements Landroid/view/IEventFilter;


# instance fields
.field private final GRIP_REGION:I

.field private final MAX_VELOCITY:I

.field private final WIDTH_RATIO:F

.field private act:Landroid/view/IEventFilter$ReturnAct;

.field private gripMask:Ljava/util/BitSet;

.field mContext:Landroid/content/Context;

.field private mRegionInfo:Landroid/view/RegionInfo;

.field private mVelocityTracker:Landroid/view/VelocityTracker;

.field private needToRepeat:Z

.field private reportIdBits:Ljava/util/BitSet;

.field private validXLeft:I

.field private validXRight:I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-object v0, Landroid/view/IEventFilter$ReturnAct;->NONE:Landroid/view/IEventFilter$ReturnAct;

    iput-object v0, p0, Landroid/view/GripSuppressionFilter;->act:Landroid/view/IEventFilter$ReturnAct;

    iput-object p1, p0, Landroid/view/GripSuppressionFilter;->mContext:Landroid/content/Context;

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    sget v1, Lcom/lge/internal/R$integer;->config_grip_region:I

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v0

    iput v0, p0, Landroid/view/GripSuppressionFilter;->GRIP_REGION:I

    const/16 v0, 0x1f4

    iput v0, p0, Landroid/view/GripSuppressionFilter;->MAX_VELOCITY:I

    const/high16 v0, 0x40000000    # 2.0f

    iput v0, p0, Landroid/view/GripSuppressionFilter;->WIDTH_RATIO:F

    new-instance v0, Ljava/util/BitSet;

    invoke-direct {v0}, Ljava/util/BitSet;-><init>()V

    iput-object v0, p0, Landroid/view/GripSuppressionFilter;->reportIdBits:Ljava/util/BitSet;

    new-instance v0, Landroid/view/RegionInfo;

    iget v1, p0, Landroid/view/GripSuppressionFilter;->GRIP_REGION:I

    invoke-direct {v0, v1}, Landroid/view/RegionInfo;-><init>(I)V

    iput-object v0, p0, Landroid/view/GripSuppressionFilter;->mRegionInfo:Landroid/view/RegionInfo;

    invoke-static {}, Landroid/view/VelocityTracker;->obtain()Landroid/view/VelocityTracker;

    move-result-object v0

    iput-object v0, p0, Landroid/view/GripSuppressionFilter;->mVelocityTracker:Landroid/view/VelocityTracker;

    new-instance v0, Ljava/util/BitSet;

    invoke-direct {v0}, Ljava/util/BitSet;-><init>()V

    iput-object v0, p0, Landroid/view/GripSuppressionFilter;->gripMask:Ljava/util/BitSet;

    invoke-virtual {p0}, Landroid/view/GripSuppressionFilter;->init()V

    return-void
.end method


# virtual methods
.method public filtering(Landroid/view/MotionEvent;)Z
    .locals 13
    .param p1, "event"    # Landroid/view/MotionEvent;

    .prologue
    const/4 v12, 0x1

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v4

    .local v4, "pointerCount":I
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    .local v0, "action":I
    iget-object v9, p0, Landroid/view/GripSuppressionFilter;->mVelocityTracker:Landroid/view/VelocityTracker;

    invoke-virtual {v9, p1}, Landroid/view/VelocityTracker;->addMovement(Landroid/view/MotionEvent;)V

    iget-object v9, p0, Landroid/view/GripSuppressionFilter;->mVelocityTracker:Landroid/view/VelocityTracker;

    const/16 v10, 0x3e8

    invoke-virtual {v9, v10}, Landroid/view/VelocityTracker;->computeCurrentVelocity(I)V

    iget-object v9, p0, Landroid/view/GripSuppressionFilter;->reportIdBits:Ljava/util/BitSet;

    invoke-virtual {v9}, Ljava/util/BitSet;->clear()V

    const/4 v9, 0x5

    if-eq v0, v9, :cond_0

    if-nez v0, :cond_2

    :cond_0
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionIndex()I

    move-result v3

    .local v3, "index":I
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionIndex()I

    move-result v9

    invoke-virtual {p1, v9}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v2

    .local v2, "id":I
    invoke-static {p1, v3}, Landroid/view/TouchEventFilter;->getRawX(Landroid/view/MotionEvent;I)F

    move-result v9

    float-to-int v8, v9

    .local v8, "x":I
    iget v9, p0, Landroid/view/GripSuppressionFilter;->validXLeft:I

    if-lt v8, v9, :cond_1

    iget v9, p0, Landroid/view/GripSuppressionFilter;->validXRight:I

    if-le v8, v9, :cond_2

    :cond_1
    iget-object v9, p0, Landroid/view/GripSuppressionFilter;->gripMask:Ljava/util/BitSet;

    invoke-virtual {v9, v2}, Ljava/util/BitSet;->set(I)V

    .end local v2    # "id":I
    .end local v3    # "index":I
    .end local v8    # "x":I
    :cond_2
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, v4, :cond_7

    invoke-virtual {p1, v1}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v2

    .restart local v2    # "id":I
    invoke-static {p1, v1}, Landroid/view/TouchEventFilter;->getRawX(Landroid/view/MotionEvent;I)F

    move-result v9

    float-to-int v8, v9

    .restart local v8    # "x":I
    invoke-virtual {p1, v1}, Landroid/view/MotionEvent;->getToolMajor(I)F

    move-result v9

    float-to-int v6, v9

    .local v6, "widthMajor":I
    invoke-virtual {p1, v1}, Landroid/view/MotionEvent;->getToolMinor(I)F

    move-result v9

    float-to-int v7, v9

    .local v7, "widthMinor":I
    iget-object v9, p0, Landroid/view/GripSuppressionFilter;->mVelocityTracker:Landroid/view/VelocityTracker;

    invoke-virtual {v9, v2}, Landroid/view/VelocityTracker;->getXVelocity(I)F

    move-result v9

    float-to-int v9, v9

    invoke-static {v9}, Ljava/lang/Math;->abs(I)I

    move-result v5

    .local v5, "velX":I
    iget-object v9, p0, Landroid/view/GripSuppressionFilter;->gripMask:Ljava/util/BitSet;

    invoke-virtual {v9, v2}, Ljava/util/BitSet;->get(I)Z

    move-result v9

    if-eqz v9, :cond_5

    int-to-float v9, v6

    int-to-float v10, v7

    iget v11, p0, Landroid/view/GripSuppressionFilter;->WIDTH_RATIO:F

    mul-float/2addr v10, v11

    cmpg-float v9, v9, v10

    if-gez v9, :cond_3

    iget v9, p0, Landroid/view/GripSuppressionFilter;->validXLeft:I

    if-lt v8, v9, :cond_3

    iget v9, p0, Landroid/view/GripSuppressionFilter;->validXRight:I

    if-le v8, v9, :cond_4

    :cond_3
    iget v9, p0, Landroid/view/GripSuppressionFilter;->MAX_VELOCITY:I

    if-le v5, v9, :cond_5

    :cond_4
    iget-object v9, p0, Landroid/view/GripSuppressionFilter;->gripMask:Ljava/util/BitSet;

    invoke-virtual {v9, v2}, Ljava/util/BitSet;->clear(I)V

    :cond_5
    iget-object v9, p0, Landroid/view/GripSuppressionFilter;->gripMask:Ljava/util/BitSet;

    invoke-virtual {v9, v2}, Ljava/util/BitSet;->get(I)Z

    move-result v9

    if-nez v9, :cond_6

    iget-object v9, p0, Landroid/view/GripSuppressionFilter;->reportIdBits:Ljava/util/BitSet;

    invoke-virtual {v9, v2}, Ljava/util/BitSet;->set(I)V

    :cond_6
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .end local v2    # "id":I
    .end local v5    # "velX":I
    .end local v6    # "widthMajor":I
    .end local v7    # "widthMinor":I
    .end local v8    # "x":I
    :cond_7
    const/4 v9, 0x6

    if-eq v0, v9, :cond_8

    if-ne v0, v12, :cond_9

    :cond_8
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionIndex()I

    move-result v3

    .restart local v3    # "index":I
    invoke-virtual {p1, v3}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v2

    .restart local v2    # "id":I
    iget-object v9, p0, Landroid/view/GripSuppressionFilter;->gripMask:Ljava/util/BitSet;

    invoke-virtual {v9, v2}, Ljava/util/BitSet;->clear(I)V

    .end local v2    # "id":I
    .end local v3    # "index":I
    :cond_9
    return v12
.end method

.method public getAct()Landroid/view/IEventFilter$ReturnAct;
    .locals 1

    .prologue
    iget-object v0, p0, Landroid/view/GripSuppressionFilter;->act:Landroid/view/IEventFilter$ReturnAct;

    return-object v0
.end method

.method public getReportMask()Ljava/util/BitSet;
    .locals 1

    .prologue
    iget-object v0, p0, Landroid/view/GripSuppressionFilter;->reportIdBits:Ljava/util/BitSet;

    invoke-virtual {v0}, Ljava/util/BitSet;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/BitSet;

    return-object v0
.end method

.method public init()V
    .locals 1

    .prologue
    sget-object v0, Landroid/view/IEventFilter$ReturnAct;->NONE:Landroid/view/IEventFilter$ReturnAct;

    iput-object v0, p0, Landroid/view/GripSuppressionFilter;->act:Landroid/view/IEventFilter$ReturnAct;

    iget-object v0, p0, Landroid/view/GripSuppressionFilter;->reportIdBits:Ljava/util/BitSet;

    invoke-virtual {v0}, Ljava/util/BitSet;->clear()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Landroid/view/GripSuppressionFilter;->needToRepeat:Z

    iget-object v0, p0, Landroid/view/GripSuppressionFilter;->mRegionInfo:Landroid/view/RegionInfo;

    invoke-virtual {v0}, Landroid/view/RegionInfo;->getLeftEdgeRegion()I

    move-result v0

    iput v0, p0, Landroid/view/GripSuppressionFilter;->validXLeft:I

    iget-object v0, p0, Landroid/view/GripSuppressionFilter;->mRegionInfo:Landroid/view/RegionInfo;

    invoke-virtual {v0}, Landroid/view/RegionInfo;->getRightEdgeRegion()I

    move-result v0

    iput v0, p0, Landroid/view/GripSuppressionFilter;->validXRight:I

    iget-object v0, p0, Landroid/view/GripSuppressionFilter;->mVelocityTracker:Landroid/view/VelocityTracker;

    invoke-virtual {v0}, Landroid/view/VelocityTracker;->clear()V

    iget-object v0, p0, Landroid/view/GripSuppressionFilter;->gripMask:Ljava/util/BitSet;

    invoke-virtual {v0}, Ljava/util/BitSet;->clear()V

    return-void
.end method

.method public needToRepeat()Z
    .locals 1

    .prologue
    iget-boolean v0, p0, Landroid/view/GripSuppressionFilter;->needToRepeat:Z

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "GripSuppressionFilter : region["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Landroid/view/GripSuppressionFilter;->mRegionInfo:Landroid/view/RegionInfo;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
