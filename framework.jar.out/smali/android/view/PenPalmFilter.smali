.class public Landroid/view/PenPalmFilter;
.super Ljava/lang/Object;
.source "PenPalmFilter.java"

# interfaces
.implements Landroid/view/IEventFilter;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/view/PenPalmFilter$PalmRegion;,
        Landroid/view/PenPalmFilter$PenIDFinder;
    }
.end annotation


# instance fields
.field private final EDGE_AREA:I

.field private MAX_PEN_PRESSURE:I

.field private MAX_SAMPLE_COUNT:I

.field private MIN_PEN_COUNT:I

.field private MIN_WIDTH_MINOR:I

.field private Z_AVR_MAX_VALUE:I

.field private Z_AVR_MIN_VALUE:I

.field private act:Landroid/view/IEventFilter$ReturnAct;

.field private largePalm:Z

.field private mContext:Landroid/content/Context;

.field private mPalmRegion:Landroid/view/PenPalmFilter$PalmRegion;

.field private mPenIDFinder:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/view/PenPalmFilter$PenIDFinder;",
            ">;"
        }
    .end annotation
.end field

.field private mRegionInfo:Landroid/view/RegionInfo;

.field private mVelocityTracker:Landroid/view/VelocityTracker;

.field private needToRepeat:Z

.field private reportIdBits:Ljava/util/BitSet;

.field private savedTopID:I

.field private sendCancelPalm:Z

.field private usePalm:Z

.field private usePen:Z

.field private usefinger:Z

.field private validXLeft:I

.field private validXRight:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 169
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    sget-object v0, Landroid/view/IEventFilter$ReturnAct;->NONE:Landroid/view/IEventFilter$ReturnAct;

    iput-object v0, p0, Landroid/view/PenPalmFilter;->act:Landroid/view/IEventFilter$ReturnAct;

    .line 170
    const/16 v0, 0x1e

    iput v0, p0, Landroid/view/PenPalmFilter;->EDGE_AREA:I

    .line 171
    invoke-direct {p0}, Landroid/view/PenPalmFilter;->initPenPalmFilter()V

    .line 172
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 6
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 175
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    sget-object v1, Landroid/view/IEventFilter$ReturnAct;->NONE:Landroid/view/IEventFilter$ReturnAct;

    iput-object v1, p0, Landroid/view/PenPalmFilter;->act:Landroid/view/IEventFilter$ReturnAct;

    .line 176
    iput-object p1, p0, Landroid/view/PenPalmFilter;->mContext:Landroid/content/Context;

    .line 178
    invoke-static {}, Landroid/view/RegionInfo;->getLCDRatio()I

    move-result v1

    const/4 v2, 0x1

    if-lt v1, v2, :cond_0

    iget-object v1, p0, Landroid/view/PenPalmFilter;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v1, v1, Landroid/util/DisplayMetrics;->xdpi:F

    float-to-int v1, v1

    int-to-float v0, v1

    .line 179
    .local v0, "lcdDpi":F
    :goto_0
    float-to-double v2, v0

    const-wide v4, 0x400451eb851eb852L    # 2.54

    div-double/2addr v2, v4

    const-wide v4, 0x3fc999999999999aL    # 0.2

    mul-double/2addr v2, v4

    double-to-int v1, v2

    iput v1, p0, Landroid/view/PenPalmFilter;->EDGE_AREA:I

    .line 180
    invoke-direct {p0}, Landroid/view/PenPalmFilter;->initPenPalmFilter()V

    .line 182
    return-void

    .line 178
    .end local v0    # "lcdDpi":F
    :cond_0
    iget-object v1, p0, Landroid/view/PenPalmFilter;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v1, v1, Landroid/util/DisplayMetrics;->ydpi:F

    float-to-int v1, v1

    int-to-float v0, v1

    goto :goto_0
.end method

.method static synthetic access$000(Landroid/view/PenPalmFilter;)I
    .locals 1
    .param p0, "x0"    # Landroid/view/PenPalmFilter;

    .prologue
    .line 23
    iget v0, p0, Landroid/view/PenPalmFilter;->MAX_SAMPLE_COUNT:I

    return v0
.end method

.method static synthetic access$100(Landroid/view/PenPalmFilter;)I
    .locals 1
    .param p0, "x0"    # Landroid/view/PenPalmFilter;

    .prologue
    .line 23
    iget v0, p0, Landroid/view/PenPalmFilter;->MAX_PEN_PRESSURE:I

    return v0
.end method

.method static synthetic access$200(Landroid/view/PenPalmFilter;)I
    .locals 1
    .param p0, "x0"    # Landroid/view/PenPalmFilter;

    .prologue
    .line 23
    iget v0, p0, Landroid/view/PenPalmFilter;->MIN_WIDTH_MINOR:I

    return v0
.end method

.method static synthetic access$300(Landroid/view/PenPalmFilter;)I
    .locals 1
    .param p0, "x0"    # Landroid/view/PenPalmFilter;

    .prologue
    .line 23
    iget v0, p0, Landroid/view/PenPalmFilter;->Z_AVR_MAX_VALUE:I

    return v0
.end method

.method static synthetic access$400(Landroid/view/PenPalmFilter;)I
    .locals 1
    .param p0, "x0"    # Landroid/view/PenPalmFilter;

    .prologue
    .line 23
    iget v0, p0, Landroid/view/PenPalmFilter;->Z_AVR_MIN_VALUE:I

    return v0
.end method

.method static synthetic access$500(Landroid/view/PenPalmFilter;)I
    .locals 1
    .param p0, "x0"    # Landroid/view/PenPalmFilter;

    .prologue
    .line 23
    iget v0, p0, Landroid/view/PenPalmFilter;->MIN_PEN_COUNT:I

    return v0
.end method

.method static synthetic access$600(Landroid/view/PenPalmFilter;)Landroid/content/Context;
    .locals 1
    .param p0, "x0"    # Landroid/view/PenPalmFilter;

    .prologue
    .line 23
    iget-object v0, p0, Landroid/view/PenPalmFilter;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method private initPenPalmFilter()V
    .locals 4

    .prologue
    const/16 v3, 0x14

    const/16 v2, 0xf

    .line 186
    const/4 v1, 0x1

    iput v1, p0, Landroid/view/PenPalmFilter;->MIN_PEN_COUNT:I

    .line 188
    iput v3, p0, Landroid/view/PenPalmFilter;->MAX_SAMPLE_COUNT:I

    .line 189
    const/16 v1, 0x23

    iput v1, p0, Landroid/view/PenPalmFilter;->MAX_PEN_PRESSURE:I

    .line 190
    iput v2, p0, Landroid/view/PenPalmFilter;->Z_AVR_MIN_VALUE:I

    .line 191
    iput v3, p0, Landroid/view/PenPalmFilter;->Z_AVR_MAX_VALUE:I

    .line 192
    iput v2, p0, Landroid/view/PenPalmFilter;->MIN_WIDTH_MINOR:I

    .line 194
    new-instance v1, Ljava/util/BitSet;

    invoke-direct {v1}, Ljava/util/BitSet;-><init>()V

    iput-object v1, p0, Landroid/view/PenPalmFilter;->reportIdBits:Ljava/util/BitSet;

    .line 195
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Landroid/view/PenPalmFilter;->mPenIDFinder:Ljava/util/ArrayList;

    .line 196
    new-instance v1, Landroid/view/RegionInfo;

    iget v2, p0, Landroid/view/PenPalmFilter;->EDGE_AREA:I

    invoke-direct {v1, v2}, Landroid/view/RegionInfo;-><init>(I)V

    iput-object v1, p0, Landroid/view/PenPalmFilter;->mRegionInfo:Landroid/view/RegionInfo;

    .line 197
    new-instance v1, Landroid/view/PenPalmFilter$PalmRegion;

    invoke-direct {v1, p0}, Landroid/view/PenPalmFilter$PalmRegion;-><init>(Landroid/view/PenPalmFilter;)V

    iput-object v1, p0, Landroid/view/PenPalmFilter;->mPalmRegion:Landroid/view/PenPalmFilter$PalmRegion;

    .line 198
    invoke-static {}, Landroid/view/VelocityTracker;->obtain()Landroid/view/VelocityTracker;

    move-result-object v1

    iput-object v1, p0, Landroid/view/PenPalmFilter;->mVelocityTracker:Landroid/view/VelocityTracker;

    .line 200
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    const/16 v1, 0xa

    if-ge v0, v1, :cond_0

    .line 201
    iget-object v1, p0, Landroid/view/PenPalmFilter;->mPenIDFinder:Ljava/util/ArrayList;

    new-instance v2, Landroid/view/PenPalmFilter$PenIDFinder;

    invoke-direct {v2, p0}, Landroid/view/PenPalmFilter$PenIDFinder;-><init>(Landroid/view/PenPalmFilter;)V

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 200
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 204
    :cond_0
    invoke-virtual {p0}, Landroid/view/PenPalmFilter;->init()V

    .line 205
    return-void
.end method


# virtual methods
.method public filtering(Landroid/view/MotionEvent;)Z
    .locals 28
    .param p1, "event"    # Landroid/view/MotionEvent;

    .prologue
    .line 229
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v20

    .line 230
    .local v20, "pointerCount":I
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v10

    .line 231
    .local v10, "action":I
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getActionIndex()I

    move-result v11

    .line 233
    .local v11, "actionIndex":I
    move-object/from16 v0, p0

    iget-object v7, v0, Landroid/view/PenPalmFilter;->reportIdBits:Ljava/util/BitSet;

    invoke-virtual {v7}, Ljava/util/BitSet;->clear()V

    .line 234
    sget-object v7, Landroid/view/IEventFilter$ReturnAct;->NONE:Landroid/view/IEventFilter$ReturnAct;

    move-object/from16 v0, p0

    iput-object v7, v0, Landroid/view/PenPalmFilter;->act:Landroid/view/IEventFilter$ReturnAct;

    .line 235
    const/4 v7, 0x0

    move-object/from16 v0, p0

    iput-boolean v7, v0, Landroid/view/PenPalmFilter;->needToRepeat:Z

    .line 237
    move-object/from16 v0, p0

    iget-object v7, v0, Landroid/view/PenPalmFilter;->mVelocityTracker:Landroid/view/VelocityTracker;

    move-object/from16 v0, p1

    invoke-virtual {v7, v0}, Landroid/view/VelocityTracker;->addMovement(Landroid/view/MotionEvent;)V

    .line 238
    move-object/from16 v0, p0

    iget-object v7, v0, Landroid/view/PenPalmFilter;->mVelocityTracker:Landroid/view/VelocityTracker;

    const/16 v26, 0x3e8

    move/from16 v0, v26

    invoke-virtual {v7, v0}, Landroid/view/VelocityTracker;->computeCurrentVelocity(I)V

    .line 240
    const/4 v12, 0x0

    .line 241
    .local v12, "hasPen":Z
    const/16 v18, 0x0

    .line 243
    .local v18, "isPalm":Z
    const/4 v13, 0x0

    .local v13, "i":I
    :goto_0
    move/from16 v0, v20

    if-ge v13, v0, :cond_b

    .line 244
    move-object/from16 v0, p1

    invoke-virtual {v0, v13}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v14

    .line 245
    .local v14, "id":I
    move-object/from16 v0, p1

    invoke-virtual {v0, v13}, Landroid/view/MotionEvent;->getX(I)F

    move-result v7

    float-to-int v0, v7

    move/from16 v24, v0

    .line 246
    .local v24, "x":I
    move-object/from16 v0, p1

    invoke-virtual {v0, v13}, Landroid/view/MotionEvent;->getY(I)F

    move-result v6

    .line 247
    .local v6, "y":F
    move-object/from16 v0, p1

    invoke-virtual {v0, v13}, Landroid/view/MotionEvent;->getPressure(I)F

    move-result v25

    .line 248
    .local v25, "z":F
    move-object/from16 v0, p1

    invoke-virtual {v0, v13}, Landroid/view/MotionEvent;->getToolMinor(I)F

    move-result v8

    .line 250
    .local v8, "w":F
    move-object/from16 v0, p0

    iget-object v7, v0, Landroid/view/PenPalmFilter;->mVelocityTracker:Landroid/view/VelocityTracker;

    invoke-virtual {v7, v14}, Landroid/view/VelocityTracker;->getXVelocity(I)F

    move-result v7

    float-to-int v7, v7

    invoke-static {v7}, Ljava/lang/Math;->abs(I)I

    move-result v4

    .line 251
    .local v4, "velX":I
    move-object/from16 v0, p0

    iget-object v7, v0, Landroid/view/PenPalmFilter;->mVelocityTracker:Landroid/view/VelocityTracker;

    invoke-virtual {v7, v14}, Landroid/view/VelocityTracker;->getYVelocity(I)F

    move-result v7

    float-to-int v7, v7

    invoke-static {v7}, Ljava/lang/Math;->abs(I)I

    move-result v5

    .line 252
    .local v5, "velY":I
    move-object/from16 v0, p0

    iget v7, v0, Landroid/view/PenPalmFilter;->validXLeft:I

    move/from16 v0, v24

    if-lt v0, v7, :cond_0

    move-object/from16 v0, p0

    iget v7, v0, Landroid/view/PenPalmFilter;->validXRight:I

    move/from16 v0, v24

    if-le v0, v7, :cond_7

    :cond_0
    const/4 v9, 0x1

    .line 253
    .local v9, "isEdge":Z
    :goto_1
    move-object/from16 v0, p0

    iget-object v7, v0, Landroid/view/PenPalmFilter;->mPenIDFinder:Ljava/util/ArrayList;

    invoke-virtual {v7, v14}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/view/PenPalmFilter$PenIDFinder;

    .line 254
    .local v3, "penFinder":Landroid/view/PenPalmFilter$PenIDFinder;
    if-eqz v10, :cond_1

    const/4 v7, 0x5

    if-ne v10, v7, :cond_8

    :cond_1
    move-object/from16 v0, p0

    iget-object v7, v0, Landroid/view/PenPalmFilter;->mPalmRegion:Landroid/view/PenPalmFilter$PalmRegion;

    float-to-int v0, v6

    move/from16 v26, v0

    move/from16 v0, v24

    move/from16 v1, v26

    invoke-virtual {v7, v0, v1}, Landroid/view/PenPalmFilter$PalmRegion;->checkPalmRegion(II)Z

    move-result v7

    if-eqz v7, :cond_8

    if-ne v11, v13, :cond_8

    const/16 v17, 0x1

    .line 256
    .local v17, "isInPalmRegion":Z
    :goto_2
    if-eqz v10, :cond_2

    const/4 v7, 0x5

    if-ne v10, v7, :cond_9

    :cond_2
    if-eqz v9, :cond_9

    if-ne v11, v13, :cond_9

    const/16 v16, 0x1

    .line 259
    .local v16, "isInEdgeRegion":Z
    :goto_3
    if-eqz v17, :cond_3

    .line 260
    const/4 v7, 0x1

    invoke-virtual {v3, v7}, Landroid/view/PenPalmFilter$PenIDFinder;->setPalmRegion(Z)V

    .line 262
    :cond_3
    if-eqz v16, :cond_4

    .line 263
    const/4 v7, 0x1

    invoke-virtual {v3, v7}, Landroid/view/PenPalmFilter$PenIDFinder;->setEdgeRegion(Z)V

    .line 266
    :cond_4
    const/high16 v7, 0x437f0000    # 255.0f

    mul-float v7, v7, v25

    invoke-virtual/range {v3 .. v9}, Landroid/view/PenPalmFilter$PenIDFinder;->addInfo(IIFFFZ)V

    .line 268
    invoke-virtual {v3}, Landroid/view/PenPalmFilter$PenIDFinder;->isPen()Z

    move-result v7

    if-eqz v7, :cond_5

    .line 269
    const/4 v12, 0x1

    .line 271
    :cond_5
    invoke-virtual {v3}, Landroid/view/PenPalmFilter$PenIDFinder;->isFinger()Z

    move-result v7

    if-eqz v7, :cond_6

    .line 272
    const/high16 v7, 0x3f800000    # 1.0f

    move/from16 v0, v25

    invoke-static {v0, v7}, Ljava/lang/Float;->compare(FF)I

    move-result v7

    if-ltz v7, :cond_a

    const/4 v7, 0x1

    :goto_4
    move-object/from16 v0, p0

    iput-boolean v7, v0, Landroid/view/PenPalmFilter;->largePalm:Z

    .line 273
    move-object/from16 v0, p0

    iget-object v7, v0, Landroid/view/PenPalmFilter;->mPalmRegion:Landroid/view/PenPalmFilter$PalmRegion;

    float-to-int v0, v6

    move/from16 v26, v0

    move-object/from16 v0, p0

    iget-boolean v0, v0, Landroid/view/PenPalmFilter;->largePalm:Z

    move/from16 v27, v0

    move/from16 v0, v24

    move/from16 v1, v26

    move/from16 v2, v27

    invoke-virtual {v7, v14, v0, v1, v2}, Landroid/view/PenPalmFilter$PalmRegion;->assignPalm(IIIZ)V

    .line 275
    move-object/from16 v0, p0

    iget-boolean v7, v0, Landroid/view/PenPalmFilter;->largePalm:Z

    if-eqz v7, :cond_6

    const/4 v7, 0x5

    if-eq v10, v7, :cond_6

    if-eqz v10, :cond_6

    .line 276
    const/16 v18, 0x1

    .line 243
    :cond_6
    add-int/lit8 v13, v13, 0x1

    goto/16 :goto_0

    .line 252
    .end local v3    # "penFinder":Landroid/view/PenPalmFilter$PenIDFinder;
    .end local v9    # "isEdge":Z
    .end local v16    # "isInEdgeRegion":Z
    .end local v17    # "isInPalmRegion":Z
    :cond_7
    const/4 v9, 0x0

    goto/16 :goto_1

    .line 254
    .restart local v3    # "penFinder":Landroid/view/PenPalmFilter$PenIDFinder;
    .restart local v9    # "isEdge":Z
    :cond_8
    const/16 v17, 0x0

    goto :goto_2

    .line 256
    .restart local v17    # "isInPalmRegion":Z
    :cond_9
    const/16 v16, 0x0

    goto :goto_3

    .line 272
    .restart local v16    # "isInEdgeRegion":Z
    :cond_a
    const/4 v7, 0x0

    goto :goto_4

    .line 280
    .end local v3    # "penFinder":Landroid/view/PenPalmFilter$PenIDFinder;
    .end local v4    # "velX":I
    .end local v5    # "velY":I
    .end local v6    # "y":F
    .end local v8    # "w":F
    .end local v9    # "isEdge":Z
    .end local v14    # "id":I
    .end local v16    # "isInEdgeRegion":Z
    .end local v17    # "isInPalmRegion":Z
    .end local v24    # "x":I
    .end local v25    # "z":F
    :cond_b
    if-eqz v18, :cond_d

    .line 281
    const/4 v7, 0x1

    move-object/from16 v0, p0

    iput-boolean v7, v0, Landroid/view/PenPalmFilter;->usePalm:Z

    .line 286
    :goto_5
    const/high16 v21, -0x40800000    # -1.0f

    .line 287
    .local v21, "result":F
    const/16 v23, -0x1

    .line 289
    .local v23, "topID":I
    if-eqz v12, :cond_15

    .line 290
    const/4 v13, 0x0

    :goto_6
    move/from16 v0, v20

    if-ge v13, v0, :cond_e

    .line 291
    move-object/from16 v0, p1

    invoke-virtual {v0, v13}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v14

    .line 294
    .restart local v14    # "id":I
    move-object/from16 v0, p0

    iget-object v7, v0, Landroid/view/PenPalmFilter;->mPenIDFinder:Ljava/util/ArrayList;

    invoke-virtual {v7, v14}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/view/PenPalmFilter$PenIDFinder;

    .line 295
    .restart local v3    # "penFinder":Landroid/view/PenPalmFilter$PenIDFinder;
    invoke-virtual {v3}, Landroid/view/PenPalmFilter$PenIDFinder;->getResult()F

    move-result v19

    .line 297
    .local v19, "newResult":F
    cmpl-float v7, v19, v21

    if-lez v7, :cond_c

    .line 298
    move/from16 v21, v19

    .line 299
    move/from16 v23, v14

    .line 290
    :cond_c
    add-int/lit8 v13, v13, 0x1

    goto :goto_6

    .line 283
    .end local v3    # "penFinder":Landroid/view/PenPalmFilter$PenIDFinder;
    .end local v14    # "id":I
    .end local v19    # "newResult":F
    .end local v21    # "result":F
    .end local v23    # "topID":I
    :cond_d
    const/4 v7, 0x0

    move-object/from16 v0, p0

    iput-boolean v7, v0, Landroid/view/PenPalmFilter;->usePalm:Z

    goto :goto_5

    .line 303
    .restart local v21    # "result":F
    .restart local v23    # "topID":I
    :cond_e
    const/4 v7, -0x1

    move/from16 v0, v23

    if-eq v0, v7, :cond_10

    .line 304
    move-object/from16 v0, p0

    iget-object v7, v0, Landroid/view/PenPalmFilter;->reportIdBits:Ljava/util/BitSet;

    move/from16 v0, v23

    invoke-virtual {v7, v0}, Ljava/util/BitSet;->set(I)V

    .line 305
    move-object/from16 v0, p0

    iget v7, v0, Landroid/view/PenPalmFilter;->savedTopID:I

    const/16 v26, -0x1

    move/from16 v0, v26

    if-ne v7, v0, :cond_14

    const/16 v22, 0x0

    .line 306
    .local v22, "savedTopIDIsPen":Z
    :goto_7
    move-object/from16 v0, p0

    iget v7, v0, Landroid/view/PenPalmFilter;->savedTopID:I

    const/16 v26, -0x1

    move/from16 v0, v26

    if-eq v7, v0, :cond_10

    move-object/from16 v0, p0

    iget v7, v0, Landroid/view/PenPalmFilter;->savedTopID:I

    move/from16 v0, v23

    if-eq v0, v7, :cond_10

    if-nez v22, :cond_10

    move-object/from16 v0, p0

    iget-boolean v7, v0, Landroid/view/PenPalmFilter;->largePalm:Z

    if-nez v7, :cond_10

    .line 307
    sget-object v7, Landroid/view/IEventFilter$ReturnAct;->CANCEL:Landroid/view/IEventFilter$ReturnAct;

    move-object/from16 v0, p0

    iput-object v7, v0, Landroid/view/PenPalmFilter;->act:Landroid/view/IEventFilter$ReturnAct;

    .line 308
    const/4 v7, 0x1

    move-object/from16 v0, p0

    iput-boolean v7, v0, Landroid/view/PenPalmFilter;->needToRepeat:Z

    .line 309
    move-object/from16 v0, p0

    iget-boolean v7, v0, Landroid/view/PenPalmFilter;->usefinger:Z

    if-eqz v7, :cond_f

    .line 310
    sget-object v7, Landroid/view/IEventFilter$ReturnAct;->IGNORE:Landroid/view/IEventFilter$ReturnAct;

    move-object/from16 v0, p0

    iput-object v7, v0, Landroid/view/PenPalmFilter;->act:Landroid/view/IEventFilter$ReturnAct;

    .line 312
    :cond_f
    const/4 v7, 0x1

    move-object/from16 v0, p0

    iput-boolean v7, v0, Landroid/view/PenPalmFilter;->usefinger:Z

    .line 344
    .end local v22    # "savedTopIDIsPen":Z
    :cond_10
    :goto_8
    move/from16 v0, v23

    move-object/from16 v1, p0

    iput v0, v1, Landroid/view/PenPalmFilter;->savedTopID:I

    .line 346
    const/4 v7, 0x6

    if-eq v10, v7, :cond_11

    const/4 v7, 0x1

    if-ne v10, v7, :cond_13

    .line 347
    :cond_11
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getActionIndex()I

    move-result v15

    .line 348
    .local v15, "index":I
    move-object/from16 v0, p1

    invoke-virtual {v0, v15}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v14

    .line 349
    .restart local v14    # "id":I
    move-object/from16 v0, p0

    iget-object v7, v0, Landroid/view/PenPalmFilter;->mPenIDFinder:Ljava/util/ArrayList;

    invoke-virtual {v7, v14}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/view/PenPalmFilter$PenIDFinder;

    .line 351
    .restart local v3    # "penFinder":Landroid/view/PenPalmFilter$PenIDFinder;
    const/4 v7, 0x1

    if-eq v10, v7, :cond_12

    invoke-virtual {v3}, Landroid/view/PenPalmFilter$PenIDFinder;->isPen()Z

    move-result v7

    if-eqz v7, :cond_12

    .line 352
    const/4 v7, 0x1

    move-object/from16 v0, p0

    iput-boolean v7, v0, Landroid/view/PenPalmFilter;->usePen:Z

    .line 354
    :cond_12
    invoke-virtual {v3}, Landroid/view/PenPalmFilter$PenIDFinder;->init()V

    .line 356
    .end local v3    # "penFinder":Landroid/view/PenPalmFilter$PenIDFinder;
    .end local v14    # "id":I
    .end local v15    # "index":I
    :cond_13
    const/4 v7, 0x1

    return v7

    .line 305
    :cond_14
    move-object/from16 v0, p0

    iget-object v7, v0, Landroid/view/PenPalmFilter;->mPenIDFinder:Ljava/util/ArrayList;

    move-object/from16 v0, p0

    iget v0, v0, Landroid/view/PenPalmFilter;->savedTopID:I

    move/from16 v26, v0

    move/from16 v0, v26

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Landroid/view/PenPalmFilter$PenIDFinder;

    invoke-virtual {v7}, Landroid/view/PenPalmFilter$PenIDFinder;->isPen()Z

    move-result v22

    goto :goto_7

    .line 316
    :cond_15
    const/4 v13, 0x0

    :goto_9
    move/from16 v0, v20

    if-ge v13, v0, :cond_1a

    .line 317
    move-object/from16 v0, p1

    invoke-virtual {v0, v13}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v14

    .line 318
    .restart local v14    # "id":I
    move-object/from16 v0, p0

    iget-object v7, v0, Landroid/view/PenPalmFilter;->mPenIDFinder:Ljava/util/ArrayList;

    invoke-virtual {v7, v14}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/view/PenPalmFilter$PenIDFinder;

    .line 319
    .restart local v3    # "penFinder":Landroid/view/PenPalmFilter$PenIDFinder;
    invoke-virtual {v3}, Landroid/view/PenPalmFilter$PenIDFinder;->getCount()I

    move-result v19

    .line 321
    .local v19, "newResult":I
    move/from16 v0, v19

    int-to-float v7, v0

    cmpl-float v7, v7, v21

    if-lez v7, :cond_16

    .line 322
    move/from16 v0, v19

    int-to-float v0, v0

    move/from16 v21, v0

    .line 323
    move/from16 v23, v14

    .line 326
    :cond_16
    move-object/from16 v0, p0

    iget-boolean v7, v0, Landroid/view/PenPalmFilter;->usePen:Z

    if-nez v7, :cond_17

    .line 327
    move-object/from16 v0, p0

    iget-boolean v7, v0, Landroid/view/PenPalmFilter;->usePalm:Z

    if-eqz v7, :cond_18

    move-object/from16 v0, p0

    iget-boolean v7, v0, Landroid/view/PenPalmFilter;->sendCancelPalm:Z

    if-nez v7, :cond_18

    .line 328
    sget-object v7, Landroid/view/IEventFilter$ReturnAct;->CANCEL:Landroid/view/IEventFilter$ReturnAct;

    move-object/from16 v0, p0

    iput-object v7, v0, Landroid/view/PenPalmFilter;->act:Landroid/view/IEventFilter$ReturnAct;

    .line 329
    move-object/from16 v0, p0

    iget-object v7, v0, Landroid/view/PenPalmFilter;->reportIdBits:Ljava/util/BitSet;

    invoke-virtual {v7, v14}, Ljava/util/BitSet;->set(I)V

    .line 330
    const/4 v7, 0x1

    move-object/from16 v0, p0

    iput-boolean v7, v0, Landroid/view/PenPalmFilter;->sendCancelPalm:Z

    .line 316
    :cond_17
    :goto_a
    add-int/lit8 v13, v13, 0x1

    goto :goto_9

    .line 332
    :cond_18
    move-object/from16 v0, p0

    iget-boolean v7, v0, Landroid/view/PenPalmFilter;->usePalm:Z

    if-eqz v7, :cond_19

    move-object/from16 v0, p0

    iget-boolean v7, v0, Landroid/view/PenPalmFilter;->sendCancelPalm:Z

    if-eqz v7, :cond_19

    .line 333
    sget-object v7, Landroid/view/IEventFilter$ReturnAct;->IGNORE:Landroid/view/IEventFilter$ReturnAct;

    move-object/from16 v0, p0

    iput-object v7, v0, Landroid/view/PenPalmFilter;->act:Landroid/view/IEventFilter$ReturnAct;

    .line 335
    :cond_19
    move-object/from16 v0, p0

    iget-object v7, v0, Landroid/view/PenPalmFilter;->reportIdBits:Ljava/util/BitSet;

    invoke-virtual {v7, v14}, Ljava/util/BitSet;->set(I)V

    goto :goto_a

    .line 340
    .end local v3    # "penFinder":Landroid/view/PenPalmFilter$PenIDFinder;
    .end local v14    # "id":I
    .end local v19    # "newResult":I
    :cond_1a
    move-object/from16 v0, p0

    iget-boolean v7, v0, Landroid/view/PenPalmFilter;->usePalm:Z

    if-eqz v7, :cond_10

    const/4 v7, 0x1

    if-eq v10, v7, :cond_1b

    const/4 v7, 0x6

    if-ne v10, v7, :cond_10

    .line 341
    :cond_1b
    const/4 v7, 0x0

    move-object/from16 v0, p0

    iput-boolean v7, v0, Landroid/view/PenPalmFilter;->sendCancelPalm:Z

    goto/16 :goto_8
.end method

.method public getAct()Landroid/view/IEventFilter$ReturnAct;
    .locals 1

    .prologue
    .line 361
    iget-object v0, p0, Landroid/view/PenPalmFilter;->act:Landroid/view/IEventFilter$ReturnAct;

    return-object v0
.end method

.method public getReportMask()Ljava/util/BitSet;
    .locals 1

    .prologue
    .line 366
    iget-object v0, p0, Landroid/view/PenPalmFilter;->reportIdBits:Ljava/util/BitSet;

    invoke-virtual {v0}, Ljava/util/BitSet;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/BitSet;

    return-object v0
.end method

.method public init()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 209
    sget-object v2, Landroid/view/IEventFilter$ReturnAct;->NONE:Landroid/view/IEventFilter$ReturnAct;

    iput-object v2, p0, Landroid/view/PenPalmFilter;->act:Landroid/view/IEventFilter$ReturnAct;

    .line 210
    iget-object v2, p0, Landroid/view/PenPalmFilter;->reportIdBits:Ljava/util/BitSet;

    invoke-virtual {v2}, Ljava/util/BitSet;->clear()V

    .line 211
    iput-boolean v3, p0, Landroid/view/PenPalmFilter;->needToRepeat:Z

    .line 212
    iput-boolean v3, p0, Landroid/view/PenPalmFilter;->usePen:Z

    .line 213
    iput-boolean v3, p0, Landroid/view/PenPalmFilter;->sendCancelPalm:Z

    .line 214
    iput-boolean v3, p0, Landroid/view/PenPalmFilter;->usePalm:Z

    .line 215
    iput-boolean v3, p0, Landroid/view/PenPalmFilter;->usefinger:Z

    .line 216
    const/4 v2, -0x1

    iput v2, p0, Landroid/view/PenPalmFilter;->savedTopID:I

    .line 217
    iget-object v2, p0, Landroid/view/PenPalmFilter;->mRegionInfo:Landroid/view/RegionInfo;

    invoke-virtual {v2}, Landroid/view/RegionInfo;->getLeftEdgeRegion()I

    move-result v2

    iput v2, p0, Landroid/view/PenPalmFilter;->validXLeft:I

    .line 218
    iget-object v2, p0, Landroid/view/PenPalmFilter;->mRegionInfo:Landroid/view/RegionInfo;

    invoke-virtual {v2}, Landroid/view/RegionInfo;->getRightEdgeRegion()I

    move-result v2

    iput v2, p0, Landroid/view/PenPalmFilter;->validXRight:I

    .line 219
    iget-object v2, p0, Landroid/view/PenPalmFilter;->mVelocityTracker:Landroid/view/VelocityTracker;

    invoke-virtual {v2}, Landroid/view/VelocityTracker;->clear()V

    .line 220
    iget-object v2, p0, Landroid/view/PenPalmFilter;->mPalmRegion:Landroid/view/PenPalmFilter$PalmRegion;

    invoke-virtual {v2}, Landroid/view/PenPalmFilter$PalmRegion;->init()V

    .line 221
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    const/16 v2, 0xa

    if-ge v0, v2, :cond_0

    .line 222
    iget-object v2, p0, Landroid/view/PenPalmFilter;->mPenIDFinder:Ljava/util/ArrayList;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/PenPalmFilter$PenIDFinder;

    .line 223
    .local v1, "penFinder":Landroid/view/PenPalmFilter$PenIDFinder;
    invoke-virtual {v1}, Landroid/view/PenPalmFilter$PenIDFinder;->init()V

    .line 221
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 225
    .end local v1    # "penFinder":Landroid/view/PenPalmFilter$PenIDFinder;
    :cond_0
    return-void
.end method

.method public needToRepeat()Z
    .locals 1

    .prologue
    .line 371
    iget-boolean v0, p0, Landroid/view/PenPalmFilter;->needToRepeat:Z

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 5

    .prologue
    .line 376
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 377
    .local v1, "msg":Ljava/lang/StringBuilder;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "PenPalmFilter usePen["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-boolean v4, p0, Landroid/view/PenPalmFilter;->usePen:Z

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "] valid"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Landroid/view/PenPalmFilter;->mRegionInfo:Landroid/view/RegionInfo;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 378
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    const/16 v3, 0xa

    if-ge v0, v3, :cond_1

    .line 379
    iget-object v3, p0, Landroid/view/PenPalmFilter;->mPenIDFinder:Ljava/util/ArrayList;

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/view/PenPalmFilter$PenIDFinder;

    .line 380
    .local v2, "penFinder":Landroid/view/PenPalmFilter$PenIDFinder;
    invoke-virtual {v2}, Landroid/view/PenPalmFilter$PenIDFinder;->getCount()I

    move-result v3

    if-lez v3, :cond_0

    .line 381
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, " ["

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "] "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 378
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 384
    .end local v2    # "penFinder":Landroid/view/PenPalmFilter$PenIDFinder;
    :cond_1
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "  Rect - "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Landroid/view/PenPalmFilter;->mPalmRegion:Landroid/view/PenPalmFilter$PalmRegion;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 385
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    return-object v3
.end method