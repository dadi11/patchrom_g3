.class Landroid/view/PenPalmFilter$PenIDFinder;
.super Ljava/lang/Object;
.source "PenPalmFilter.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/view/PenPalmFilter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "PenIDFinder"
.end annotation


# instance fields
.field private cnt:I

.field private dAvr:F

.field private inEdgeRegion:Z

.field private inPalmRegion:Z

.field private pen:Z

.field private result:F

.field final synthetic this$0:Landroid/view/PenPalmFilter;

.field private zAvr:F


# direct methods
.method public constructor <init>(Landroid/view/PenPalmFilter;)V
    .locals 0

    .prologue
    .line 64
    iput-object p1, p0, Landroid/view/PenPalmFilter$PenIDFinder;->this$0:Landroid/view/PenPalmFilter;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 65
    invoke-virtual {p0}, Landroid/view/PenPalmFilter$PenIDFinder;->init()V

    .line 66
    return-void
.end method


# virtual methods
.method public addInfo(IIFFFZ)V
    .locals 10
    .param p1, "velX"    # I
    .param p2, "velY"    # I
    .param p3, "y"    # F
    .param p4, "z"    # F
    .param p5, "w"    # F
    .param p6, "edge"    # Z

    .prologue
    .line 79
    iget v8, p0, Landroid/view/PenPalmFilter$PenIDFinder;->cnt:I

    add-int/lit8 v8, v8, 0x1

    iput v8, p0, Landroid/view/PenPalmFilter$PenIDFinder;->cnt:I

    .line 80
    iget v8, p0, Landroid/view/PenPalmFilter$PenIDFinder;->cnt:I

    iget-object v9, p0, Landroid/view/PenPalmFilter$PenIDFinder;->this$0:Landroid/view/PenPalmFilter;

    # getter for: Landroid/view/PenPalmFilter;->MAX_SAMPLE_COUNT:I
    invoke-static {v9}, Landroid/view/PenPalmFilter;->access$000(Landroid/view/PenPalmFilter;)I

    move-result v9

    if-lt v8, v9, :cond_4

    iget-object v8, p0, Landroid/view/PenPalmFilter$PenIDFinder;->this$0:Landroid/view/PenPalmFilter;

    # getter for: Landroid/view/PenPalmFilter;->MAX_SAMPLE_COUNT:I
    invoke-static {v8}, Landroid/view/PenPalmFilter;->access$000(Landroid/view/PenPalmFilter;)I

    move-result v0

    .line 82
    .local v0, "count":I
    :goto_0
    mul-int v8, p1, p2

    int-to-float v3, v8

    .line 83
    .local v3, "mulVel":F
    div-float v4, v3, p3

    .line 85
    .local v4, "newDAvr":F
    if-lez v0, :cond_0

    .line 86
    iget v8, p0, Landroid/view/PenPalmFilter$PenIDFinder;->zAvr:F

    add-int/lit8 v9, v0, -0x1

    int-to-float v9, v9

    mul-float/2addr v8, v9

    int-to-float v9, v0

    div-float/2addr v8, v9

    int-to-float v9, v0

    div-float v9, p4, v9

    add-float/2addr v8, v9

    iput v8, p0, Landroid/view/PenPalmFilter$PenIDFinder;->zAvr:F

    .line 87
    iget v8, p0, Landroid/view/PenPalmFilter$PenIDFinder;->dAvr:F

    add-int/lit8 v9, v0, -0x1

    int-to-float v9, v9

    mul-float/2addr v8, v9

    int-to-float v9, v0

    div-float/2addr v8, v9

    int-to-float v9, v0

    div-float v9, v4, v9

    add-float/2addr v8, v9

    iput v8, p0, Landroid/view/PenPalmFilter$PenIDFinder;->dAvr:F

    .line 90
    :cond_0
    iget v8, p0, Landroid/view/PenPalmFilter$PenIDFinder;->zAvr:F

    iget-object v9, p0, Landroid/view/PenPalmFilter$PenIDFinder;->this$0:Landroid/view/PenPalmFilter;

    # getter for: Landroid/view/PenPalmFilter;->MAX_PEN_PRESSURE:I
    invoke-static {v9}, Landroid/view/PenPalmFilter;->access$100(Landroid/view/PenPalmFilter;)I

    move-result v9

    int-to-float v9, v9

    cmpl-float v8, v8, v9

    if-gtz v8, :cond_1

    iget-object v8, p0, Landroid/view/PenPalmFilter$PenIDFinder;->this$0:Landroid/view/PenPalmFilter;

    # getter for: Landroid/view/PenPalmFilter;->MIN_WIDTH_MINOR:I
    invoke-static {v8}, Landroid/view/PenPalmFilter;->access$200(Landroid/view/PenPalmFilter;)I

    move-result v8

    int-to-float v8, v8

    cmpl-float v8, p5, v8

    if-lez v8, :cond_2

    .line 91
    :cond_1
    const/4 v8, 0x0

    iput-boolean v8, p0, Landroid/view/PenPalmFilter$PenIDFinder;->pen:Z

    .line 94
    :cond_2
    if-nez p6, :cond_3

    .line 95
    const/4 v8, 0x0

    iput-boolean v8, p0, Landroid/view/PenPalmFilter$PenIDFinder;->inEdgeRegion:Z

    .line 98
    :cond_3
    iget v8, p0, Landroid/view/PenPalmFilter$PenIDFinder;->zAvr:F

    iget-object v9, p0, Landroid/view/PenPalmFilter$PenIDFinder;->this$0:Landroid/view/PenPalmFilter;

    # getter for: Landroid/view/PenPalmFilter;->Z_AVR_MAX_VALUE:I
    invoke-static {v9}, Landroid/view/PenPalmFilter;->access$300(Landroid/view/PenPalmFilter;)I

    move-result v9

    int-to-float v9, v9

    cmpl-float v8, v8, v9

    if-lez v8, :cond_5

    iget v8, p0, Landroid/view/PenPalmFilter$PenIDFinder;->zAvr:F

    iget-object v9, p0, Landroid/view/PenPalmFilter$PenIDFinder;->this$0:Landroid/view/PenPalmFilter;

    # getter for: Landroid/view/PenPalmFilter;->Z_AVR_MAX_VALUE:I
    invoke-static {v9}, Landroid/view/PenPalmFilter;->access$300(Landroid/view/PenPalmFilter;)I

    move-result v9

    int-to-float v9, v9

    sub-float v1, v8, v9

    .line 99
    .local v1, "deltaZ":F
    :goto_1
    mul-float v8, v1, v1

    const/high16 v9, 0x3f800000    # 1.0f

    add-float v7, v8, v9

    .line 100
    .local v7, "zVal":F
    iget-boolean v8, p0, Landroid/view/PenPalmFilter$PenIDFinder;->pen:Z

    if-eqz v8, :cond_7

    const/high16 v6, 0x3f800000    # 1.0f

    .line 101
    .local v6, "penVal":F
    :goto_2
    iget-boolean v8, p0, Landroid/view/PenPalmFilter$PenIDFinder;->inPalmRegion:Z

    if-eqz v8, :cond_8

    const/4 v5, 0x0

    .line 102
    .local v5, "palmVal":F
    :goto_3
    iget-boolean v8, p0, Landroid/view/PenPalmFilter$PenIDFinder;->inEdgeRegion:Z

    if-eqz v8, :cond_9

    const/4 v2, 0x0

    .line 103
    .local v2, "edgeVal":F
    :goto_4
    iget v8, p0, Landroid/view/PenPalmFilter$PenIDFinder;->dAvr:F

    mul-float/2addr v8, v6

    mul-float/2addr v8, v5

    mul-float/2addr v8, v2

    int-to-float v9, v0

    mul-float/2addr v8, v9

    div-float/2addr v8, v7

    mul-float v9, v6, v5

    mul-float/2addr v9, v2

    add-float/2addr v8, v9

    iput v8, p0, Landroid/view/PenPalmFilter$PenIDFinder;->result:F

    .line 104
    return-void

    .line 80
    .end local v0    # "count":I
    .end local v1    # "deltaZ":F
    .end local v2    # "edgeVal":F
    .end local v3    # "mulVel":F
    .end local v4    # "newDAvr":F
    .end local v5    # "palmVal":F
    .end local v6    # "penVal":F
    .end local v7    # "zVal":F
    :cond_4
    iget v0, p0, Landroid/view/PenPalmFilter$PenIDFinder;->cnt:I

    goto/16 :goto_0

    .line 98
    .restart local v0    # "count":I
    .restart local v3    # "mulVel":F
    .restart local v4    # "newDAvr":F
    :cond_5
    iget v8, p0, Landroid/view/PenPalmFilter$PenIDFinder;->zAvr:F

    iget-object v9, p0, Landroid/view/PenPalmFilter$PenIDFinder;->this$0:Landroid/view/PenPalmFilter;

    # getter for: Landroid/view/PenPalmFilter;->Z_AVR_MIN_VALUE:I
    invoke-static {v9}, Landroid/view/PenPalmFilter;->access$400(Landroid/view/PenPalmFilter;)I

    move-result v9

    int-to-float v9, v9

    cmpg-float v8, v8, v9

    if-gez v8, :cond_6

    iget v8, p0, Landroid/view/PenPalmFilter$PenIDFinder;->zAvr:F

    iget-object v9, p0, Landroid/view/PenPalmFilter$PenIDFinder;->this$0:Landroid/view/PenPalmFilter;

    # getter for: Landroid/view/PenPalmFilter;->Z_AVR_MIN_VALUE:I
    invoke-static {v9}, Landroid/view/PenPalmFilter;->access$400(Landroid/view/PenPalmFilter;)I

    move-result v9

    int-to-float v9, v9

    sub-float v1, v8, v9

    goto :goto_1

    :cond_6
    const/4 v1, 0x0

    goto :goto_1

    .line 100
    .restart local v1    # "deltaZ":F
    .restart local v7    # "zVal":F
    :cond_7
    const/4 v6, 0x0

    goto :goto_2

    .line 101
    .restart local v6    # "penVal":F
    :cond_8
    const/high16 v5, 0x3f800000    # 1.0f

    goto :goto_3

    .line 102
    .restart local v5    # "palmVal":F
    :cond_9
    const/high16 v2, 0x3f800000    # 1.0f

    goto :goto_4
.end method

.method public getCount()I
    .locals 1

    .prologue
    .line 107
    iget v0, p0, Landroid/view/PenPalmFilter$PenIDFinder;->cnt:I

    return v0
.end method

.method public getResult()F
    .locals 1

    .prologue
    .line 106
    iget v0, p0, Landroid/view/PenPalmFilter$PenIDFinder;->result:F

    return v0
.end method

.method public init()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    .line 69
    iput v1, p0, Landroid/view/PenPalmFilter$PenIDFinder;->cnt:I

    .line 70
    iput v0, p0, Landroid/view/PenPalmFilter$PenIDFinder;->zAvr:F

    .line 71
    iput v0, p0, Landroid/view/PenPalmFilter$PenIDFinder;->dAvr:F

    .line 72
    iput v0, p0, Landroid/view/PenPalmFilter$PenIDFinder;->result:F

    .line 73
    const/4 v0, 0x1

    iput-boolean v0, p0, Landroid/view/PenPalmFilter$PenIDFinder;->pen:Z

    .line 74
    iput-boolean v1, p0, Landroid/view/PenPalmFilter$PenIDFinder;->inPalmRegion:Z

    .line 75
    iput-boolean v1, p0, Landroid/view/PenPalmFilter$PenIDFinder;->inEdgeRegion:Z

    .line 76
    return-void
.end method

.method public isFinger()Z
    .locals 1

    .prologue
    .line 109
    iget-boolean v0, p0, Landroid/view/PenPalmFilter$PenIDFinder;->pen:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isPen()Z
    .locals 2

    .prologue
    .line 108
    iget v0, p0, Landroid/view/PenPalmFilter$PenIDFinder;->cnt:I

    iget-object v1, p0, Landroid/view/PenPalmFilter$PenIDFinder;->this$0:Landroid/view/PenPalmFilter;

    # getter for: Landroid/view/PenPalmFilter;->MIN_PEN_COUNT:I
    invoke-static {v1}, Landroid/view/PenPalmFilter;->access$500(Landroid/view/PenPalmFilter;)I

    move-result v1

    if-lt v0, v1, :cond_0

    iget-boolean v0, p0, Landroid/view/PenPalmFilter$PenIDFinder;->inEdgeRegion:Z

    if-nez v0, :cond_0

    iget-boolean v0, p0, Landroid/view/PenPalmFilter$PenIDFinder;->inPalmRegion:Z

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_1
    iget-boolean v0, p0, Landroid/view/PenPalmFilter$PenIDFinder;->pen:Z

    goto :goto_0
.end method

.method public setEdgeRegion(Z)V
    .locals 0
    .param p1, "isInEdgeRegion"    # Z

    .prologue
    .line 111
    iput-boolean p1, p0, Landroid/view/PenPalmFilter$PenIDFinder;->inEdgeRegion:Z

    return-void
.end method

.method public setPalmRegion(Z)V
    .locals 0
    .param p1, "isInPalmRegion"    # Z

    .prologue
    .line 110
    iput-boolean p1, p0, Landroid/view/PenPalmFilter$PenIDFinder;->inPalmRegion:Z

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 113
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "count["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Landroid/view/PenPalmFilter$PenIDFinder;->cnt:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "] zAvr["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Landroid/view/PenPalmFilter$PenIDFinder;->zAvr:F

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "] dAvr["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Landroid/view/PenPalmFilter$PenIDFinder;->dAvr:F

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "] isPen["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Landroid/view/PenPalmFilter$PenIDFinder;->isPen()Z

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "] result["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Landroid/view/PenPalmFilter$PenIDFinder;->getResult()F

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
