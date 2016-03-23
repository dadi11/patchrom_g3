.class public final Lcom/lge/systemservice/core/EmotionalLedManager;
.super Lcom/lge/systemservice/core/LEDManager;
.source "EmotionalLedManager.java"


# annotations
.annotation runtime Ljava/lang/Deprecated;
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Lcom/lge/systemservice/core/LEDManager;-><init>()V

    return-void
.end method


# virtual methods
.method public clearAllLeds()V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .prologue
    invoke-super {p0}, Lcom/lge/systemservice/core/LEDManager;->clearAllPatterns()I

    return-void
.end method

.method public restart()V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .prologue
    invoke-super {p0}, Lcom/lge/systemservice/core/LEDManager;->restartPatterns()I

    return-void
.end method

.method public setBrightness(I)V
    .locals 1
    .param p1, "brightness"    # I
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .prologue
    const/4 v0, 0x0

    invoke-super {p0, p1, v0}, Lcom/lge/systemservice/core/LEDManager;->setBrightnessLed(II)I

    return-void
.end method

.method public start(Ljava/lang/String;ILcom/lge/systemservice/core/LGLedRecord;)V
    .locals 0
    .param p1, "pkgName"    # Ljava/lang/String;
    .param p2, "id"    # I
    .param p3, "record"    # Lcom/lge/systemservice/core/LGLedRecord;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .prologue
    invoke-super {p0, p1, p2, p3}, Lcom/lge/systemservice/core/LEDManager;->startPattern(Ljava/lang/String;ILcom/lge/systemservice/core/LGLedRecord;)I

    return-void
.end method

.method public stop(Ljava/lang/String;I)V
    .locals 0
    .param p1, "pkgName"    # Ljava/lang/String;
    .param p2, "id"    # I
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .prologue
    invoke-super {p0, p1, p2}, Lcom/lge/systemservice/core/LEDManager;->stopPattern(Ljava/lang/String;I)I

    return-void
.end method

.method public update(Ljava/lang/String;ILcom/lge/systemservice/core/LGLedRecord;)V
    .locals 0
    .param p1, "pkgName"    # Ljava/lang/String;
    .param p2, "id"    # I
    .param p3, "record"    # Lcom/lge/systemservice/core/LGLedRecord;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .prologue
    invoke-super {p0, p1, p2, p3}, Lcom/lge/systemservice/core/LEDManager;->updatePattern(Ljava/lang/String;ILcom/lge/systemservice/core/LGLedRecord;)I

    return-void
.end method

.method public updateLightList(IIIIIILjava/lang/String;)V
    .locals 0
    .param p1, "action"    # I
    .param p2, "recordId"    # I
    .param p3, "exceptional"    # I
    .param p4, "ledARGB"    # I
    .param p5, "ledOnMS"    # I
    .param p6, "ledOffMS"    # I
    .param p7, "pkg"    # Ljava/lang/String;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .prologue
    invoke-super/range {p0 .. p7}, Lcom/lge/systemservice/core/LEDManager;->updatePatternList(IIIIIILjava/lang/String;)I

    return-void
.end method
