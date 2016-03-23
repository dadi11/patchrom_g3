.class public Landroid/view/TouchEventFilter;
.super Ljava/lang/Object;
.source "TouchEventFilter.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/view/TouchEventFilter$PrintLog;,
        Landroid/view/TouchEventFilter$TouchBitSet;,
        Landroid/view/TouchEventFilter$DoAction;
    }
.end annotation


# static fields
.field private static isPortrait:Z


# instance fields
.field private final DEBUG_LEVEL:I

.field private final MAX_LOOP_COUNT:I

.field private filteringResult:Landroid/view/TouchEventFilter$DoAction;

.field private isPointerIDChanged:Z

.field private loopCount:I

.field private mEventFilter:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Landroid/view/IEventFilter;",
            ">;"
        }
    .end annotation
.end field

.field private mView:Landroid/view/View;

.field private needIdConvert:Z

.field private needToLoop:Z

.field private onlyNewMaskBits:Landroid/view/TouchEventFilter$TouchBitSet;

.field private onlyOldMaskBits:Landroid/view/TouchEventFilter$TouchBitSet;

.field private reportAction:I

.field private reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

.field private savedDownTime:J

.field private savedPointerChangedID:I

.field private savedReportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput-boolean v0, Landroid/view/TouchEventFilter;->isPortrait:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "debug.view.toucheventfilter"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->getInt(Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Landroid/view/TouchEventFilter;->DEBUG_LEVEL:I

    const/16 v0, 0xa

    iput v0, p0, Landroid/view/TouchEventFilter;->MAX_LOOP_COUNT:I

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Landroid/view/TouchEventFilter;->mEventFilter:Ljava/util/ArrayList;

    const/4 v0, 0x0

    iput-object v0, p0, Landroid/view/TouchEventFilter;->mView:Landroid/view/View;

    new-instance v0, Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-direct {v0, p0}, Landroid/view/TouchEventFilter$TouchBitSet;-><init>(Landroid/view/TouchEventFilter;)V

    iput-object v0, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    new-instance v0, Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-direct {v0, p0}, Landroid/view/TouchEventFilter$TouchBitSet;-><init>(Landroid/view/TouchEventFilter;)V

    iput-object v0, p0, Landroid/view/TouchEventFilter;->savedReportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    iput v1, p0, Landroid/view/TouchEventFilter;->reportAction:I

    iput-boolean v1, p0, Landroid/view/TouchEventFilter;->needToLoop:Z

    sget-object v0, Landroid/view/TouchEventFilter$DoAction;->DO_NOTHING:Landroid/view/TouchEventFilter$DoAction;

    iput-object v0, p0, Landroid/view/TouchEventFilter;->filteringResult:Landroid/view/TouchEventFilter$DoAction;

    iput v1, p0, Landroid/view/TouchEventFilter;->loopCount:I

    new-instance v0, Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-direct {v0, p0}, Landroid/view/TouchEventFilter$TouchBitSet;-><init>(Landroid/view/TouchEventFilter;)V

    iput-object v0, p0, Landroid/view/TouchEventFilter;->onlyNewMaskBits:Landroid/view/TouchEventFilter$TouchBitSet;

    new-instance v0, Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-direct {v0, p0}, Landroid/view/TouchEventFilter$TouchBitSet;-><init>(Landroid/view/TouchEventFilter;)V

    iput-object v0, p0, Landroid/view/TouchEventFilter;->onlyOldMaskBits:Landroid/view/TouchEventFilter$TouchBitSet;

    iput-boolean v1, p0, Landroid/view/TouchEventFilter;->isPointerIDChanged:Z

    iput-boolean v1, p0, Landroid/view/TouchEventFilter;->needIdConvert:Z

    const/4 v0, -0x1

    iput v0, p0, Landroid/view/TouchEventFilter;->savedPointerChangedID:I

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Landroid/view/TouchEventFilter;->savedDownTime:J

    invoke-direct {p0}, Landroid/view/TouchEventFilter;->init()V

    return-void
.end method

.method public constructor <init>(Landroid/view/View;)V
    .locals 4
    .param p1, "view"    # Landroid/view/View;

    .prologue
    const/4 v3, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v2, "debug.view.toucheventfilter"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->getInt(Ljava/lang/String;I)I

    move-result v2

    iput v2, p0, Landroid/view/TouchEventFilter;->DEBUG_LEVEL:I

    const/16 v2, 0xa

    iput v2, p0, Landroid/view/TouchEventFilter;->MAX_LOOP_COUNT:I

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    iput-object v2, p0, Landroid/view/TouchEventFilter;->mEventFilter:Ljava/util/ArrayList;

    const/4 v2, 0x0

    iput-object v2, p0, Landroid/view/TouchEventFilter;->mView:Landroid/view/View;

    new-instance v2, Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-direct {v2, p0}, Landroid/view/TouchEventFilter$TouchBitSet;-><init>(Landroid/view/TouchEventFilter;)V

    iput-object v2, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    new-instance v2, Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-direct {v2, p0}, Landroid/view/TouchEventFilter$TouchBitSet;-><init>(Landroid/view/TouchEventFilter;)V

    iput-object v2, p0, Landroid/view/TouchEventFilter;->savedReportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    iput v3, p0, Landroid/view/TouchEventFilter;->reportAction:I

    iput-boolean v3, p0, Landroid/view/TouchEventFilter;->needToLoop:Z

    sget-object v2, Landroid/view/TouchEventFilter$DoAction;->DO_NOTHING:Landroid/view/TouchEventFilter$DoAction;

    iput-object v2, p0, Landroid/view/TouchEventFilter;->filteringResult:Landroid/view/TouchEventFilter$DoAction;

    iput v3, p0, Landroid/view/TouchEventFilter;->loopCount:I

    new-instance v2, Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-direct {v2, p0}, Landroid/view/TouchEventFilter$TouchBitSet;-><init>(Landroid/view/TouchEventFilter;)V

    iput-object v2, p0, Landroid/view/TouchEventFilter;->onlyNewMaskBits:Landroid/view/TouchEventFilter$TouchBitSet;

    new-instance v2, Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-direct {v2, p0}, Landroid/view/TouchEventFilter$TouchBitSet;-><init>(Landroid/view/TouchEventFilter;)V

    iput-object v2, p0, Landroid/view/TouchEventFilter;->onlyOldMaskBits:Landroid/view/TouchEventFilter$TouchBitSet;

    iput-boolean v3, p0, Landroid/view/TouchEventFilter;->isPointerIDChanged:Z

    iput-boolean v3, p0, Landroid/view/TouchEventFilter;->needIdConvert:Z

    const/4 v2, -0x1

    iput v2, p0, Landroid/view/TouchEventFilter;->savedPointerChangedID:I

    const-wide/16 v2, 0x0

    iput-wide v2, p0, Landroid/view/TouchEventFilter;->savedDownTime:J

    iput-object p1, p0, Landroid/view/TouchEventFilter;->mView:Landroid/view/View;

    iget-object v2, p0, Landroid/view/TouchEventFilter;->mView:Landroid/view/View;

    if-eqz v2, :cond_0

    const-string v2, "window"

    invoke-static {v2}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v2

    invoke-static {v2}, Landroid/view/IWindowManager$Stub;->asInterface(Landroid/os/IBinder;)Landroid/view/IWindowManager;

    move-result-object v1

    .local v1, "wm":Landroid/view/IWindowManager;
    if-eqz v1, :cond_0

    :try_start_0
    new-instance v0, Landroid/graphics/Point;

    invoke-direct {v0}, Landroid/graphics/Point;-><init>()V

    .local v0, "myPoint":Landroid/graphics/Point;
    const/4 v2, 0x0

    invoke-interface {v1, v2, v0}, Landroid/view/IWindowManager;->getInitialDisplaySize(ILandroid/graphics/Point;)V

    iget v2, v0, Landroid/graphics/Point;->x:I

    iget v3, v0, Landroid/graphics/Point;->y:I

    invoke-static {v2, v3}, Landroid/view/RegionInfo;->setLCDSize(II)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "myPoint":Landroid/graphics/Point;
    .end local v1    # "wm":Landroid/view/IWindowManager;
    :cond_0
    :goto_0
    invoke-direct {p0}, Landroid/view/TouchEventFilter;->init()V

    return-void

    .restart local v1    # "wm":Landroid/view/IWindowManager;
    :catch_0
    move-exception v2

    goto :goto_0
.end method

.method private checkPointerID(Landroid/view/MotionEvent;)Landroid/view/MotionEvent;
    .locals 8
    .param p1, "event"    # Landroid/view/MotionEvent;

    .prologue
    const/4 v4, 0x1

    const/4 v5, 0x0

    iget-boolean v6, p0, Landroid/view/TouchEventFilter;->needIdConvert:Z

    if-nez v6, :cond_1

    .end local p1    # "event":Landroid/view/MotionEvent;
    :cond_0
    :goto_0
    return-object p1

    .restart local p1    # "event":Landroid/view/MotionEvent;
    :cond_1
    iget-object v6, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v6}, Landroid/view/TouchEventFilter$TouchBitSet;->getMask()I

    move-result v6

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerIdBits()I

    move-result v7

    if-eq v6, v7, :cond_3

    move v3, v4

    .local v3, "isFiltered":Z
    :goto_1
    iget v6, p0, Landroid/view/TouchEventFilter;->reportAction:I

    if-nez v6, :cond_4

    iget-object v6, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v6}, Landroid/view/TouchEventFilter$TouchBitSet;->cardinality()I

    move-result v6

    if-ne v6, v4, :cond_4

    iget-object v6, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v6, v5}, Landroid/view/TouchEventFilter$TouchBitSet;->get(I)Z

    move-result v6

    if-nez v6, :cond_4

    move v2, v4

    .local v2, "isActionDownButIdNotZero":Z
    :goto_2
    if-eqz v3, :cond_2

    if-eqz v2, :cond_2

    iput-boolean v4, p0, Landroid/view/TouchEventFilter;->isPointerIDChanged:Z

    iget-object v4, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    const/16 v6, 0xa

    invoke-virtual {v4, v6}, Landroid/view/TouchEventFilter$TouchBitSet;->previousSetBit(I)I

    move-result v4

    iput v4, p0, Landroid/view/TouchEventFilter;->savedPointerChangedID:I

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getEventTime()J

    move-result-wide v6

    iput-wide v6, p0, Landroid/view/TouchEventFilter;->savedDownTime:J

    :cond_2
    iget-boolean v4, p0, Landroid/view/TouchEventFilter;->isPointerIDChanged:Z

    if-eqz v4, :cond_0

    iget-object v4, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    iget v6, p0, Landroid/view/TouchEventFilter;->savedPointerChangedID:I

    invoke-virtual {v4, v6}, Landroid/view/TouchEventFilter$TouchBitSet;->get(I)Z

    move-result v4

    if-nez v4, :cond_5

    iget-object v4, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v4, v5}, Landroid/view/TouchEventFilter$TouchBitSet;->get(I)Z

    move-result v4

    if-nez v4, :cond_5

    iput-boolean v5, p0, Landroid/view/TouchEventFilter;->isPointerIDChanged:Z

    const/4 v4, -0x1

    iput v4, p0, Landroid/view/TouchEventFilter;->savedPointerChangedID:I

    goto :goto_0

    .end local v2    # "isActionDownButIdNotZero":Z
    .end local v3    # "isFiltered":Z
    :cond_3
    move v3, v5

    goto :goto_1

    .restart local v3    # "isFiltered":Z
    :cond_4
    move v2, v5

    goto :goto_2

    .restart local v2    # "isActionDownButIdNotZero":Z
    :cond_5
    iget-object v4, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v4, v5}, Landroid/view/TouchEventFilter$TouchBitSet;->get(I)Z

    move-result v1

    .local v1, "checkZero":Z
    iget-object v4, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    iget v6, p0, Landroid/view/TouchEventFilter;->savedPointerChangedID:I

    invoke-virtual {v4, v6}, Landroid/view/TouchEventFilter$TouchBitSet;->get(I)Z

    move-result v0

    .local v0, "checkSaved":Z
    if-eqz v1, :cond_6

    iget-object v4, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v4, v5}, Landroid/view/TouchEventFilter$TouchBitSet;->clear(I)V

    iget-object v4, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    iget v6, p0, Landroid/view/TouchEventFilter;->savedPointerChangedID:I

    invoke-virtual {v4, v6}, Landroid/view/TouchEventFilter$TouchBitSet;->set(I)V

    :cond_6
    if-eqz v0, :cond_7

    iget-object v4, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    iget v6, p0, Landroid/view/TouchEventFilter;->savedPointerChangedID:I

    invoke-virtual {v4, v6}, Landroid/view/TouchEventFilter$TouchBitSet;->clear(I)V

    iget-object v4, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v4, v5}, Landroid/view/TouchEventFilter$TouchBitSet;->set(I)V

    :cond_7
    iget v4, p0, Landroid/view/TouchEventFilter;->savedPointerChangedID:I

    iget-wide v6, p0, Landroid/view/TouchEventFilter;->savedDownTime:J

    invoke-direct {p0, p1, v4, v6, v7}, Landroid/view/TouchEventFilter;->makeNewEvent(Landroid/view/MotionEvent;IJ)Landroid/view/MotionEvent;

    move-result-object p1

    goto/16 :goto_0
.end method

.method private errorHandlingOfFiltering(I)Landroid/view/TouchEventFilter$DoAction;
    .locals 1
    .param p1, "idBits"    # I

    .prologue
    const/4 v0, 0x3

    invoke-direct {p0, p1, v0}, Landroid/view/TouchEventFilter;->setReportValue(II)V

    invoke-direct {p0}, Landroid/view/TouchEventFilter;->initProperties()V

    sget-object v0, Landroid/view/TouchEventFilter$DoAction;->DO_NOTHING:Landroid/view/TouchEventFilter$DoAction;

    return-object v0
.end method

.method private getAct(Landroid/view/IEventFilter$ReturnAct;Landroid/view/IEventFilter$ReturnAct;)Landroid/view/IEventFilter$ReturnAct;
    .locals 2
    .param p1, "oldAct"    # Landroid/view/IEventFilter$ReturnAct;
    .param p2, "newAct"    # Landroid/view/IEventFilter$ReturnAct;

    .prologue
    invoke-virtual {p2}, Landroid/view/IEventFilter$ReturnAct;->getVal()I

    move-result v0

    invoke-virtual {p1}, Landroid/view/IEventFilter$ReturnAct;->getVal()I

    move-result v1

    if-le v0, v1, :cond_0

    .end local p2    # "newAct":Landroid/view/IEventFilter$ReturnAct;
    :goto_0
    return-object p2

    .restart local p2    # "newAct":Landroid/view/IEventFilter$ReturnAct;
    :cond_0
    move-object p2, p1

    goto :goto_0
.end method

.method public static getRawX(Landroid/view/MotionEvent;I)F
    .locals 4
    .param p0, "e"    # Landroid/view/MotionEvent;
    .param p1, "pointerIndex"    # I

    .prologue
    iget-wide v0, p0, Landroid/view/MotionEvent;->mNativePtr:J

    const/4 v2, 0x0

    const/high16 v3, -0x80000000

    invoke-static {v0, v1, v2, p1, v3}, Landroid/view/MotionEvent;->nativeGetRawAxisValue(JIII)F

    move-result v0

    return v0
.end method

.method public static getRawY(Landroid/view/MotionEvent;I)F
    .locals 4
    .param p0, "e"    # Landroid/view/MotionEvent;
    .param p1, "pointerIndex"    # I

    .prologue
    iget-wide v0, p0, Landroid/view/MotionEvent;->mNativePtr:J

    const/4 v2, 0x1

    const/high16 v3, -0x80000000

    invoke-static {v0, v1, v2, p1, v3}, Landroid/view/MotionEvent;->nativeGetRawAxisValue(JIII)F

    move-result v0

    return v0
.end method

.method private init()V
    .locals 1

    .prologue
    iget-object v0, p0, Landroid/view/TouchEventFilter;->mEventFilter:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    invoke-direct {p0}, Landroid/view/TouchEventFilter;->initReportValue()V

    invoke-direct {p0}, Landroid/view/TouchEventFilter;->initProperties()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Landroid/view/TouchEventFilter;->needIdConvert:Z

    return-void
.end method

.method private initAllFilter()V
    .locals 4

    .prologue
    invoke-direct {p0}, Landroid/view/TouchEventFilter;->initReportValue()V

    invoke-direct {p0}, Landroid/view/TouchEventFilter;->initProperties()V

    iget-object v2, p0, Landroid/view/TouchEventFilter;->onlyNewMaskBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v2}, Landroid/view/TouchEventFilter$TouchBitSet;->clear()V

    iget-object v2, p0, Landroid/view/TouchEventFilter;->onlyOldMaskBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v2}, Landroid/view/TouchEventFilter$TouchBitSet;->clear()V

    const/4 v2, 0x0

    iput-boolean v2, p0, Landroid/view/TouchEventFilter;->isPointerIDChanged:Z

    const/4 v2, -0x1

    iput v2, p0, Landroid/view/TouchEventFilter;->savedPointerChangedID:I

    const-wide/16 v2, 0x0

    iput-wide v2, p0, Landroid/view/TouchEventFilter;->savedDownTime:J

    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    iget-object v2, p0, Landroid/view/TouchEventFilter;->mEventFilter:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v1, v2, :cond_0

    iget-object v2, p0, Landroid/view/TouchEventFilter;->mEventFilter:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/IEventFilter;

    .local v0, "eventFilter":Landroid/view/IEventFilter;
    invoke-interface {v0}, Landroid/view/IEventFilter;->init()V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .end local v0    # "eventFilter":Landroid/view/IEventFilter;
    :cond_0
    return-void
.end method

.method private initProperties()V
    .locals 4

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    sget-object v0, Landroid/view/TouchEventFilter$DoAction;->DO_NOTHING:Landroid/view/TouchEventFilter$DoAction;

    invoke-direct {p0, v1, v0, v1, v1}, Landroid/view/TouchEventFilter;->setProperties(ZLandroid/view/TouchEventFilter$DoAction;ZI)V

    iget-object v0, p0, Landroid/view/TouchEventFilter;->mView:Landroid/view/View;

    if-eqz v0, :cond_1

    iget-object v0, p0, Landroid/view/TouchEventFilter;->mView:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->orientation:I

    const/4 v3, 0x2

    if-ne v0, v3, :cond_2

    move v0, v1

    :goto_0
    sput-boolean v0, Landroid/view/TouchEventFilter;->isPortrait:Z

    invoke-static {}, Landroid/view/RegionInfo;->getLCDRatio()I

    move-result v0

    if-lt v0, v2, :cond_0

    sget-boolean v0, Landroid/view/TouchEventFilter;->isPortrait:Z

    if-nez v0, :cond_3

    :goto_1
    sput-boolean v2, Landroid/view/TouchEventFilter;->isPortrait:Z

    :cond_0
    sget-boolean v0, Landroid/view/TouchEventFilter;->isPortrait:Z

    invoke-static {v0}, Landroid/view/RegionInfo;->setOrientation(Z)V

    :cond_1
    return-void

    :cond_2
    move v0, v2

    goto :goto_0

    :cond_3
    move v2, v1

    goto :goto_1
.end method

.method private initReportValue()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    iget-object v0, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v0}, Landroid/view/TouchEventFilter$TouchBitSet;->clear()V

    iget-object v0, p0, Landroid/view/TouchEventFilter;->savedReportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v0}, Landroid/view/TouchEventFilter$TouchBitSet;->clear()V

    invoke-direct {p0, v1, v1}, Landroid/view/TouchEventFilter;->setReportValue(II)V

    return-void
.end method

.method private makeNewEvent(Landroid/view/MotionEvent;IJ)Landroid/view/MotionEvent;
    .locals 25
    .param p1, "event"    # Landroid/view/MotionEvent;
    .param p2, "id"    # I
    .param p3, "dTime"    # J

    .prologue
    move-wide/from16 v4, p3

    .local v4, "downTime":J
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getEventTime()J

    move-result-wide v6

    .local v6, "eventTime":J
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v8

    .local v8, "action":I
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v9

    .local v9, "pointerCount":I
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getMetaState()I

    move-result v12

    .local v12, "metaState":I
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getButtonState()I

    move-result v13

    .local v13, "buttonState":I
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getXPrecision()F

    move-result v14

    .local v14, "xPrecision":F
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getYPrecision()F

    move-result v15

    .local v15, "yPrecision":F
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getDeviceId()I

    move-result v16

    .local v16, "deviceId":I
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getEdgeFlags()I

    move-result v17

    .local v17, "edgeFlags":I
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getSource()I

    move-result v18

    .local v18, "source":I
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getFlags()I

    move-result v19

    .local v19, "flags":I
    invoke-static {v9}, Landroid/view/MotionEvent$PointerCoords;->createArray(I)[Landroid/view/MotionEvent$PointerCoords;

    move-result-object v11

    .local v11, "mPointerCoords":[Landroid/view/MotionEvent$PointerCoords;
    invoke-static {v9}, Landroid/view/MotionEvent$PointerProperties;->createArray(I)[Landroid/view/MotionEvent$PointerProperties;

    move-result-object v10

    .local v10, "mPointerProperties":[Landroid/view/MotionEvent$PointerProperties;
    const/16 v20, 0x0

    .local v20, "i":I
    :goto_0
    move/from16 v0, v20

    if-ge v0, v9, :cond_2

    move-object/from16 v0, p1

    move/from16 v1, v20

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v21

    .local v21, "pointerId":I
    aget-object v22, v10, v20

    move-object/from16 v0, p1

    move/from16 v1, v20

    move-object/from16 v2, v22

    invoke-virtual {v0, v1, v2}, Landroid/view/MotionEvent;->getPointerProperties(ILandroid/view/MotionEvent$PointerProperties;)V

    aget-object v22, v11, v20

    move-object/from16 v0, p1

    move/from16 v1, v20

    move-object/from16 v2, v22

    invoke-virtual {v0, v1, v2}, Landroid/view/MotionEvent;->getPointerCoords(ILandroid/view/MotionEvent$PointerCoords;)V

    if-nez v21, :cond_0

    aget-object v22, v10, v20

    move/from16 v0, p2

    move-object/from16 v1, v22

    iput v0, v1, Landroid/view/MotionEvent$PointerProperties;->id:I

    :goto_1
    add-int/lit8 v20, v20, 0x1

    goto :goto_0

    :cond_0
    move/from16 v0, v21

    move/from16 v1, p2

    if-ne v0, v1, :cond_1

    aget-object v22, v10, v20

    const/16 v23, 0x0

    move/from16 v0, v23

    move-object/from16 v1, v22

    iput v0, v1, Landroid/view/MotionEvent$PointerProperties;->id:I

    goto :goto_1

    :cond_1
    aget-object v22, v10, v20

    move/from16 v0, v21

    move-object/from16 v1, v22

    iput v0, v1, Landroid/view/MotionEvent$PointerProperties;->id:I

    goto :goto_1

    .end local v21    # "pointerId":I
    :cond_2
    invoke-static/range {v4 .. v19}, Landroid/view/MotionEvent;->obtain(JJII[Landroid/view/MotionEvent$PointerProperties;[Landroid/view/MotionEvent$PointerCoords;IIFFIIII)Landroid/view/MotionEvent;

    move-result-object v22

    return-object v22
.end method

.method private setProperties(ZLandroid/view/TouchEventFilter$DoAction;ZI)V
    .locals 0
    .param p1, "repeat"    # Z
    .param p2, "result"    # Landroid/view/TouchEventFilter$DoAction;
    .param p3, "portrait"    # Z
    .param p4, "count"    # I

    .prologue
    iput-boolean p1, p0, Landroid/view/TouchEventFilter;->needToLoop:Z

    iput-object p2, p0, Landroid/view/TouchEventFilter;->filteringResult:Landroid/view/TouchEventFilter$DoAction;

    sput-boolean p3, Landroid/view/TouchEventFilter;->isPortrait:Z

    iput p4, p0, Landroid/view/TouchEventFilter;->loopCount:I

    return-void
.end method

.method private setReportValue(Landroid/view/MotionEvent;Landroid/view/IEventFilter$ReturnAct;Z)Landroid/view/TouchEventFilter$DoAction;
    .locals 11
    .param p1, "event"    # Landroid/view/MotionEvent;
    .param p2, "act"    # Landroid/view/IEventFilter$ReturnAct;
    .param p3, "needToRepeat"    # Z

    .prologue
    const/16 v10, 0xa

    const/4 v7, 0x1

    const/4 v8, 0x0

    sget-object v6, Landroid/view/IEventFilter$ReturnAct;->CANCEL:Landroid/view/IEventFilter$ReturnAct;

    if-ne p2, v6, :cond_4

    const/4 v6, 0x3

    iput v6, p0, Landroid/view/TouchEventFilter;->reportAction:I

    :cond_0
    :goto_0
    iget-object v6, p0, Landroid/view/TouchEventFilter;->savedReportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    iget-object v9, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v6, v9}, Landroid/view/TouchEventFilter$TouchBitSet;->copy(Landroid/view/TouchEventFilter$TouchBitSet;)V

    iget v6, p0, Landroid/view/TouchEventFilter;->reportAction:I

    and-int/lit16 v6, v6, 0xff

    if-ne v6, v7, :cond_b

    iget-object v6, p0, Landroid/view/TouchEventFilter;->savedReportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v6}, Landroid/view/TouchEventFilter$TouchBitSet;->clear()V

    :cond_1
    :goto_1
    iget-object v6, p0, Landroid/view/TouchEventFilter;->onlyOldMaskBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v6}, Landroid/view/TouchEventFilter$TouchBitSet;->isEmpty()Z

    move-result v6

    if-eqz v6, :cond_2

    iget-object v6, p0, Landroid/view/TouchEventFilter;->onlyNewMaskBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v6}, Landroid/view/TouchEventFilter$TouchBitSet;->isEmpty()Z

    move-result v6

    if-nez v6, :cond_c

    :cond_2
    move v5, v7

    .local v5, "shouldLoop":Z
    :goto_2
    if-nez v5, :cond_3

    if-eqz p3, :cond_d

    :cond_3
    iget v6, p0, Landroid/view/TouchEventFilter;->loopCount:I

    if-ge v6, v10, :cond_d

    iput-boolean v7, p0, Landroid/view/TouchEventFilter;->needToLoop:Z

    iget v6, p0, Landroid/view/TouchEventFilter;->loopCount:I

    add-int/lit8 v6, v6, 0x1

    iput v6, p0, Landroid/view/TouchEventFilter;->loopCount:I

    :goto_3
    iget v6, p0, Landroid/view/TouchEventFilter;->loopCount:I

    if-lt v6, v10, :cond_e

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerIdBits()I

    move-result v6

    invoke-direct {p0, v6}, Landroid/view/TouchEventFilter;->errorHandlingOfFiltering(I)Landroid/view/TouchEventFilter$DoAction;

    move-result-object v6

    .end local v5    # "shouldLoop":Z
    :goto_4
    return-object v6

    :cond_4
    sget-object v6, Landroid/view/IEventFilter$ReturnAct;->IGNORE:Landroid/view/IEventFilter$ReturnAct;

    if-ne p2, v6, :cond_5

    iget-object v6, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v6}, Landroid/view/TouchEventFilter$TouchBitSet;->clear()V

    goto :goto_0

    :cond_5
    iget-object v6, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v6}, Landroid/view/TouchEventFilter$TouchBitSet;->getMask()I

    move-result v3

    .local v3, "newIdMask":I
    iget-object v6, p0, Landroid/view/TouchEventFilter;->savedReportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v6}, Landroid/view/TouchEventFilter$TouchBitSet;->getMask()I

    move-result v4

    .local v4, "oldIdMask":I
    and-int v0, v3, v4

    .local v0, "andMask":I
    iget-object v6, p0, Landroid/view/TouchEventFilter;->onlyNewMaskBits:Landroid/view/TouchEventFilter$TouchBitSet;

    xor-int/lit8 v9, v0, -0x1

    and-int/2addr v9, v3

    invoke-virtual {v6, v9}, Landroid/view/TouchEventFilter$TouchBitSet;->setMask(I)V

    iget-object v6, p0, Landroid/view/TouchEventFilter;->onlyOldMaskBits:Landroid/view/TouchEventFilter$TouchBitSet;

    xor-int/lit8 v9, v0, -0x1

    and-int/2addr v9, v4

    invoke-virtual {v6, v9}, Landroid/view/TouchEventFilter$TouchBitSet;->setMask(I)V

    iget-object v6, p0, Landroid/view/TouchEventFilter;->onlyOldMaskBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v6}, Landroid/view/TouchEventFilter$TouchBitSet;->isEmpty()Z

    move-result v6

    if-nez v6, :cond_8

    iget-object v6, p0, Landroid/view/TouchEventFilter;->onlyOldMaskBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v6, v8}, Landroid/view/TouchEventFilter$TouchBitSet;->nextSetBit(I)I

    move-result v1

    .local v1, "id":I
    iget-object v6, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    iget-object v9, p0, Landroid/view/TouchEventFilter;->onlyOldMaskBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v6, v9}, Landroid/view/TouchEventFilter$TouchBitSet;->and(Ljava/util/BitSet;)V

    iget-object v6, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    iget-object v9, p0, Landroid/view/TouchEventFilter;->onlyOldMaskBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v6, v9}, Landroid/view/TouchEventFilter$TouchBitSet;->or(Ljava/util/BitSet;)V

    iget-object v6, p0, Landroid/view/TouchEventFilter;->onlyOldMaskBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v6, v1}, Landroid/view/TouchEventFilter$TouchBitSet;->clear(I)V

    invoke-virtual {p1, v1}, Landroid/view/MotionEvent;->findPointerIndex(I)I

    move-result v2

    .local v2, "index":I
    if-gez v2, :cond_6

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerIdBits()I

    move-result v6

    invoke-direct {p0, v6}, Landroid/view/TouchEventFilter;->errorHandlingOfFiltering(I)Landroid/view/TouchEventFilter$DoAction;

    move-result-object v6

    goto :goto_4

    :cond_6
    iget-object v6, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v6}, Landroid/view/TouchEventFilter$TouchBitSet;->cardinality()I

    move-result v6

    if-ne v6, v7, :cond_7

    move v6, v7

    :goto_5
    iput v6, p0, Landroid/view/TouchEventFilter;->reportAction:I

    goto/16 :goto_0

    :cond_7
    shl-int/lit8 v6, v2, 0x8

    or-int/lit8 v6, v6, 0x6

    goto :goto_5

    .end local v1    # "id":I
    .end local v2    # "index":I
    :cond_8
    iget-object v6, p0, Landroid/view/TouchEventFilter;->onlyNewMaskBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v6}, Landroid/view/TouchEventFilter$TouchBitSet;->isEmpty()Z

    move-result v6

    if-nez v6, :cond_0

    iget-object v6, p0, Landroid/view/TouchEventFilter;->onlyNewMaskBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v6, v8}, Landroid/view/TouchEventFilter$TouchBitSet;->nextSetBit(I)I

    move-result v1

    .restart local v1    # "id":I
    iget-object v6, p0, Landroid/view/TouchEventFilter;->onlyNewMaskBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v6, v1}, Landroid/view/TouchEventFilter$TouchBitSet;->clear(I)V

    iget-object v6, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    iget-object v9, p0, Landroid/view/TouchEventFilter;->onlyNewMaskBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v6, v9}, Landroid/view/TouchEventFilter$TouchBitSet;->xor(Ljava/util/BitSet;)V

    invoke-virtual {p1, v1}, Landroid/view/MotionEvent;->findPointerIndex(I)I

    move-result v2

    .restart local v2    # "index":I
    if-gez v2, :cond_9

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerIdBits()I

    move-result v6

    invoke-direct {p0, v6}, Landroid/view/TouchEventFilter;->errorHandlingOfFiltering(I)Landroid/view/TouchEventFilter$DoAction;

    move-result-object v6

    goto/16 :goto_4

    :cond_9
    iget-object v6, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v6}, Landroid/view/TouchEventFilter$TouchBitSet;->cardinality()I

    move-result v6

    if-ne v6, v7, :cond_a

    move v6, v8

    :goto_6
    iput v6, p0, Landroid/view/TouchEventFilter;->reportAction:I

    goto/16 :goto_0

    :cond_a
    shl-int/lit8 v6, v2, 0x8

    or-int/lit8 v6, v6, 0x5

    goto :goto_6

    .end local v0    # "andMask":I
    .end local v1    # "id":I
    .end local v2    # "index":I
    .end local v3    # "newIdMask":I
    .end local v4    # "oldIdMask":I
    :cond_b
    iget v6, p0, Landroid/view/TouchEventFilter;->reportAction:I

    and-int/lit16 v6, v6, 0xff

    const/4 v9, 0x6

    if-ne v6, v9, :cond_1

    iget v6, p0, Landroid/view/TouchEventFilter;->reportAction:I

    const v9, 0xff00

    and-int/2addr v6, v9

    shr-int/lit8 v2, v6, 0x8

    .restart local v2    # "index":I
    iget-object v6, p0, Landroid/view/TouchEventFilter;->savedReportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {p1, v2}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v9

    invoke-virtual {v6, v9}, Landroid/view/TouchEventFilter$TouchBitSet;->clear(I)V

    goto/16 :goto_1

    .end local v2    # "index":I
    :cond_c
    move v5, v8

    goto/16 :goto_2

    .restart local v5    # "shouldLoop":Z
    :cond_d
    iput-boolean v8, p0, Landroid/view/TouchEventFilter;->needToLoop:Z

    iput v8, p0, Landroid/view/TouchEventFilter;->loopCount:I

    goto/16 :goto_3

    :cond_e
    iget-object v6, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v6}, Landroid/view/TouchEventFilter$TouchBitSet;->isEmpty()Z

    move-result v6

    if-eqz v6, :cond_f

    sget-object v6, Landroid/view/TouchEventFilter$DoAction;->DO_IGNORE:Landroid/view/TouchEventFilter$DoAction;

    goto/16 :goto_4

    :cond_f
    iget-object v6, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v6}, Landroid/view/TouchEventFilter$TouchBitSet;->getMask()I

    move-result v6

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerIdBits()I

    move-result v7

    if-ne v6, v7, :cond_10

    iget-boolean v6, p0, Landroid/view/TouchEventFilter;->needToLoop:Z

    if-eqz v6, :cond_11

    :cond_10
    sget-object v6, Landroid/view/TouchEventFilter$DoAction;->DO_SPLIT:Landroid/view/TouchEventFilter$DoAction;

    goto/16 :goto_4

    :cond_11
    sget-object v6, Landroid/view/TouchEventFilter$DoAction;->DO_NOTHING:Landroid/view/TouchEventFilter$DoAction;

    goto/16 :goto_4
.end method

.method private setReportValue(II)V
    .locals 1
    .param p1, "mask"    # I
    .param p2, "action"    # I

    .prologue
    iget-object v0, p0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v0, p1}, Landroid/view/TouchEventFilter$TouchBitSet;->setMask(I)V

    iget-object v0, p0, Landroid/view/TouchEventFilter;->savedReportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v0, p1}, Landroid/view/TouchEventFilter$TouchBitSet;->setMask(I)V

    iput p2, p0, Landroid/view/TouchEventFilter;->reportAction:I

    return-void
.end method


# virtual methods
.method public addTouchEventFilter(Landroid/view/IEventFilter;)V
    .locals 1
    .param p1, "filter"    # Landroid/view/IEventFilter;

    .prologue
    iget-object v0, p0, Landroid/view/TouchEventFilter;->mEventFilter:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget v0, p0, Landroid/view/TouchEventFilter;->DEBUG_LEVEL:I

    invoke-static {v0, p1}, Landroid/view/TouchEventFilter$PrintLog;->filterStatus(ILandroid/view/IEventFilter;)V

    return-void
.end method

.method public convertId(Z)V
    .locals 0
    .param p1, "needConvert"    # Z

    .prologue
    iput-boolean p1, p0, Landroid/view/TouchEventFilter;->needIdConvert:Z

    return-void
.end method

.method public filtering(Landroid/view/MotionEvent;)Landroid/view/MotionEvent;
    .locals 25
    .param p1, "event"    # Landroid/view/MotionEvent;

    .prologue
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v22

    .local v22, "start":J
    move-object/from16 v0, p0

    iget v4, v0, Landroid/view/TouchEventFilter;->DEBUG_LEVEL:I

    const-string v5, "<OLD> "

    const/4 v6, 0x0

    move-object/from16 v0, p1

    invoke-static {v4, v5, v0, v6}, Landroid/view/TouchEventFilter$PrintLog;->event(ILjava/lang/String;Landroid/view/MotionEvent;Z)V

    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v20

    .local v20, "oldAction":I
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v21

    .local v21, "oldActionMasked":I
    sget-object v13, Landroid/view/IEventFilter$ReturnAct;->NONE:Landroid/view/IEventFilter$ReturnAct;

    .local v13, "act":Landroid/view/IEventFilter$ReturnAct;
    const/16 v18, 0x0

    .local v18, "needToRepeat":Z
    if-nez v21, :cond_0

    move-object/from16 v0, p0

    iget v4, v0, Landroid/view/TouchEventFilter;->loopCount:I

    if-nez v4, :cond_0

    invoke-direct/range {p0 .. p0}, Landroid/view/TouchEventFilter;->initAllFilter()V

    :cond_0
    move-object/from16 v0, p0

    iget-object v4, v0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getPointerIdBits()I

    move-result v5

    invoke-virtual {v4, v5}, Landroid/view/TouchEventFilter$TouchBitSet;->setMask(I)V

    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v4

    move-object/from16 v0, p0

    iput v4, v0, Landroid/view/TouchEventFilter;->reportAction:I

    const/16 v17, 0x0

    .local v17, "i":I
    :goto_0
    move-object/from16 v0, p0

    iget-object v4, v0, Landroid/view/TouchEventFilter;->mEventFilter:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    move/from16 v0, v17

    if-ge v0, v4, :cond_2

    move-object/from16 v0, p0

    iget-object v4, v0, Landroid/view/TouchEventFilter;->mEventFilter:Ljava/util/ArrayList;

    move/from16 v0, v17

    invoke-virtual {v4, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v16

    check-cast v16, Landroid/view/IEventFilter;

    .local v16, "eventFilter":Landroid/view/IEventFilter;
    move-object/from16 v0, v16

    move-object/from16 v1, p1

    invoke-interface {v0, v1}, Landroid/view/IEventFilter;->filtering(Landroid/view/MotionEvent;)Z

    move-result v4

    if-nez v4, :cond_1

    :goto_1
    add-int/lit8 v17, v17, 0x1

    goto :goto_0

    :cond_1
    move-object/from16 v0, p0

    iget-object v4, v0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-interface/range {v16 .. v16}, Landroid/view/IEventFilter;->getReportMask()Ljava/util/BitSet;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/view/TouchEventFilter$TouchBitSet;->and(Ljava/util/BitSet;)V

    invoke-interface/range {v16 .. v16}, Landroid/view/IEventFilter;->getAct()Landroid/view/IEventFilter$ReturnAct;

    move-result-object v4

    move-object/from16 v0, p0

    invoke-direct {v0, v13, v4}, Landroid/view/TouchEventFilter;->getAct(Landroid/view/IEventFilter$ReturnAct;Landroid/view/IEventFilter$ReturnAct;)Landroid/view/IEventFilter$ReturnAct;

    move-result-object v13

    invoke-interface/range {v16 .. v16}, Landroid/view/IEventFilter;->needToRepeat()Z

    move-result v4

    or-int v18, v18, v4

    move-object/from16 v0, p0

    iget v4, v0, Landroid/view/TouchEventFilter;->DEBUG_LEVEL:I

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v5}, Landroid/view/TouchEventFilter$TouchBitSet;->getMask()I

    move-result v5

    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getPointerIdBits()I

    move-result v6

    move-object/from16 v0, v16

    invoke-static {v4, v0, v5, v6, v13}, Landroid/view/TouchEventFilter$PrintLog;->filtering(ILandroid/view/IEventFilter;IILandroid/view/IEventFilter$ReturnAct;)V

    goto :goto_1

    .end local v16    # "eventFilter":Landroid/view/IEventFilter;
    :cond_2
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move/from16 v2, v18

    invoke-direct {v0, v1, v13, v2}, Landroid/view/TouchEventFilter;->setReportValue(Landroid/view/MotionEvent;Landroid/view/IEventFilter$ReturnAct;Z)Landroid/view/TouchEventFilter$DoAction;

    move-result-object v4

    move-object/from16 v0, p0

    iput-object v4, v0, Landroid/view/TouchEventFilter;->filteringResult:Landroid/view/TouchEventFilter$DoAction;

    move-object/from16 v0, p0

    iget v4, v0, Landroid/view/TouchEventFilter;->reportAction:I

    move-object/from16 v0, p1

    invoke-virtual {v0, v4}, Landroid/view/MotionEvent;->setAction(I)V

    move-object/from16 v19, p1

    .local v19, "newEvent":Landroid/view/MotionEvent;
    move-object/from16 v0, p0

    iget-object v4, v0, Landroid/view/TouchEventFilter;->filteringResult:Landroid/view/TouchEventFilter$DoAction;

    sget-object v5, Landroid/view/TouchEventFilter$DoAction;->DO_IGNORE:Landroid/view/TouchEventFilter$DoAction;

    if-ne v4, v5, :cond_7

    const/16 v19, 0x0

    :cond_3
    :goto_2
    if-eqz v19, :cond_4

    invoke-virtual/range {v19 .. v19}, Landroid/view/MotionEvent;->getAction()I

    move-result v4

    const/4 v5, 0x2

    if-eq v4, v5, :cond_4

    invoke-virtual/range {v19 .. v19}, Landroid/view/MotionEvent;->getHistorySize()I

    move-result v4

    if-lez v4, :cond_4

    invoke-static/range {v19 .. v19}, Landroid/view/MotionEvent;->obtainNoHistory(Landroid/view/MotionEvent;)Landroid/view/MotionEvent;

    move-result-object v19

    :cond_4
    move-object/from16 v0, p0

    iget-boolean v4, v0, Landroid/view/TouchEventFilter;->needToLoop:Z

    if-eqz v4, :cond_5

    move-object/from16 v0, p1

    move/from16 v1, v20

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->setAction(I)V

    :cond_5
    move-object/from16 v0, p0

    iget v4, v0, Landroid/view/TouchEventFilter;->DEBUG_LEVEL:I

    move-object/from16 v0, p0

    iget-object v5, v0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    move-object/from16 v0, p0

    iget-object v6, v0, Landroid/view/TouchEventFilter;->savedReportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    move-object/from16 v0, p0

    iget v7, v0, Landroid/view/TouchEventFilter;->reportAction:I

    invoke-static {v4, v5, v6, v7}, Landroid/view/TouchEventFilter$PrintLog;->reportValue(ILandroid/view/TouchEventFilter$TouchBitSet;Landroid/view/TouchEventFilter$TouchBitSet;I)V

    move-object/from16 v0, p0

    iget v4, v0, Landroid/view/TouchEventFilter;->DEBUG_LEVEL:I

    move-object/from16 v0, p0

    iget-boolean v5, v0, Landroid/view/TouchEventFilter;->needToLoop:Z

    move-object/from16 v0, p0

    iget-object v6, v0, Landroid/view/TouchEventFilter;->filteringResult:Landroid/view/TouchEventFilter$DoAction;

    sget-boolean v7, Landroid/view/TouchEventFilter;->isPortrait:Z

    move-object/from16 v0, p0

    iget v8, v0, Landroid/view/TouchEventFilter;->loopCount:I

    move-object/from16 v0, p0

    iget-object v9, v0, Landroid/view/TouchEventFilter;->onlyOldMaskBits:Landroid/view/TouchEventFilter$TouchBitSet;

    move-object/from16 v0, p0

    iget-object v10, v0, Landroid/view/TouchEventFilter;->onlyNewMaskBits:Landroid/view/TouchEventFilter$TouchBitSet;

    move-object/from16 v0, p0

    iget-boolean v11, v0, Landroid/view/TouchEventFilter;->isPointerIDChanged:Z

    move-object/from16 v0, p0

    iget v12, v0, Landroid/view/TouchEventFilter;->savedPointerChangedID:I

    invoke-static/range {v4 .. v12}, Landroid/view/TouchEventFilter$PrintLog;->properties(IZLandroid/view/TouchEventFilter$DoAction;ZILandroid/view/TouchEventFilter$TouchBitSet;Landroid/view/TouchEventFilter$TouchBitSet;ZI)V

    move-object/from16 v0, p0

    iget v5, v0, Landroid/view/TouchEventFilter;->DEBUG_LEVEL:I

    const-string v6, "<NEW> "

    move-object/from16 v0, p0

    iget-object v4, v0, Landroid/view/TouchEventFilter;->filteringResult:Landroid/view/TouchEventFilter$DoAction;

    sget-object v7, Landroid/view/TouchEventFilter$DoAction;->DO_IGNORE:Landroid/view/TouchEventFilter$DoAction;

    if-ne v4, v7, :cond_9

    const/4 v4, 0x1

    :goto_3
    move-object/from16 v0, v19

    invoke-static {v5, v6, v0, v4}, Landroid/view/TouchEventFilter$PrintLog;->event(ILjava/lang/String;Landroid/view/MotionEvent;Z)V

    const/4 v4, 0x1

    move/from16 v0, v21

    if-ne v0, v4, :cond_6

    move-object/from16 v0, p0

    iget-object v4, v0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v4}, Landroid/view/TouchEventFilter$TouchBitSet;->isEmpty()Z

    move-result v4

    if-eqz v4, :cond_6

    invoke-direct/range {p0 .. p0}, Landroid/view/TouchEventFilter;->initAllFilter()V

    :cond_6
    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v14

    .local v14, "end":J
    move-object/from16 v0, p0

    iget v4, v0, Landroid/view/TouchEventFilter;->DEBUG_LEVEL:I

    move-wide/from16 v0, v22

    invoke-static {v4, v0, v1, v14, v15}, Landroid/view/TouchEventFilter$PrintLog;->checkTime(IJJ)V

    return-object v19

    .end local v14    # "end":J
    :cond_7
    move-object/from16 v0, p0

    iget-object v4, v0, Landroid/view/TouchEventFilter;->filteringResult:Landroid/view/TouchEventFilter$DoAction;

    sget-object v5, Landroid/view/TouchEventFilter$DoAction;->DO_SPLIT:Landroid/view/TouchEventFilter$DoAction;

    if-ne v4, v5, :cond_8

    invoke-direct/range {p0 .. p1}, Landroid/view/TouchEventFilter;->checkPointerID(Landroid/view/MotionEvent;)Landroid/view/MotionEvent;

    move-result-object v24

    .local v24, "tmpEvent":Landroid/view/MotionEvent;
    move-object/from16 v0, p0

    iget-object v4, v0, Landroid/view/TouchEventFilter;->reportIDBits:Landroid/view/TouchEventFilter$TouchBitSet;

    invoke-virtual {v4}, Landroid/view/TouchEventFilter$TouchBitSet;->getMask()I

    move-result v4

    move-object/from16 v0, v24

    invoke-virtual {v0, v4}, Landroid/view/MotionEvent;->split(I)Landroid/view/MotionEvent;

    move-result-object v19

    invoke-virtual/range {v24 .. v24}, Landroid/view/MotionEvent;->getSequenceNumber()I

    move-result v4

    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getSequenceNumber()I

    move-result v5

    if-eq v4, v5, :cond_3

    invoke-virtual/range {v24 .. v24}, Landroid/view/MotionEvent;->recycle()V

    goto/16 :goto_2

    .end local v24    # "tmpEvent":Landroid/view/MotionEvent;
    :cond_8
    invoke-direct/range {p0 .. p1}, Landroid/view/TouchEventFilter;->checkPointerID(Landroid/view/MotionEvent;)Landroid/view/MotionEvent;

    move-result-object v19

    goto/16 :goto_2

    :cond_9
    const/4 v4, 0x0

    goto :goto_3
.end method

.method public needToSendAdditionalEvent()Z
    .locals 1

    .prologue
    iget-boolean v0, p0, Landroid/view/TouchEventFilter;->needToLoop:Z

    return v0
.end method
