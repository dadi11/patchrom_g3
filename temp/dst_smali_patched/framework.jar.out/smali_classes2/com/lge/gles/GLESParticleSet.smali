.class public abstract Lcom/lge/gles/GLESParticleSet;
.super Ljava/lang/Object;
.source "GLESParticleSet.java"


# static fields
.field private static final DEBUG:Z = false

.field private static final TAG:Ljava/lang/String; = "quilt GLESParticleSet"


# instance fields
.field private mContext:Landroid/content/Context;

.field protected mHeight:F

.field protected mHeightInSpace:F

.field private mMinParticleDuration:J

.field private mMinParticleSize:F

.field private mNumOfParticle:I

.field private mParticleDurationDeviation:J

.field protected mParticleList:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/lge/gles/GLESParticle;",
            ">;"
        }
    .end annotation
.end field

.field private mParticleSizeDeviation:F

.field protected mRandom:Ljava/util/Random;

.field private mShader:Lcom/lge/gles/GLESShader;

.field private mTexture:Lcom/lge/gles/GLESTexture;

.field protected mWidth:F

.field protected mWidthInSpace:F


# direct methods
.method public constructor <init>(Landroid/content/Context;ILcom/lge/gles/GLESTexture;)V
    .locals 6
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "count"    # I
    .param p3, "texture"    # Lcom/lge/gles/GLESTexture;

    .prologue
    const-wide/16 v4, 0x0

    const/4 v2, 0x0

    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/lge/gles/GLESParticleSet;->mParticleList:Ljava/util/ArrayList;

    new-instance v0, Ljava/util/Random;

    invoke-direct {v0}, Ljava/util/Random;-><init>()V

    iput-object v0, p0, Lcom/lge/gles/GLESParticleSet;->mRandom:Ljava/util/Random;

    iput v1, p0, Lcom/lge/gles/GLESParticleSet;->mWidth:F

    iput v1, p0, Lcom/lge/gles/GLESParticleSet;->mHeight:F

    iput v1, p0, Lcom/lge/gles/GLESParticleSet;->mWidthInSpace:F

    iput v1, p0, Lcom/lge/gles/GLESParticleSet;->mHeightInSpace:F

    iput-object v2, p0, Lcom/lge/gles/GLESParticleSet;->mContext:Landroid/content/Context;

    iput-object v2, p0, Lcom/lge/gles/GLESParticleSet;->mTexture:Lcom/lge/gles/GLESTexture;

    iput-object v2, p0, Lcom/lge/gles/GLESParticleSet;->mShader:Lcom/lge/gles/GLESShader;

    const/4 v0, 0x0

    iput v0, p0, Lcom/lge/gles/GLESParticleSet;->mNumOfParticle:I

    iput v1, p0, Lcom/lge/gles/GLESParticleSet;->mMinParticleSize:F

    iput v1, p0, Lcom/lge/gles/GLESParticleSet;->mParticleSizeDeviation:F

    iput-wide v4, p0, Lcom/lge/gles/GLESParticleSet;->mMinParticleDuration:J

    iput-wide v4, p0, Lcom/lge/gles/GLESParticleSet;->mParticleDurationDeviation:J

    iput-object p1, p0, Lcom/lge/gles/GLESParticleSet;->mContext:Landroid/content/Context;

    iput p2, p0, Lcom/lge/gles/GLESParticleSet;->mNumOfParticle:I

    iput-object p3, p0, Lcom/lge/gles/GLESParticleSet;->mTexture:Lcom/lge/gles/GLESTexture;

    return-void
.end method


# virtual methods
.method public addParticle(Lcom/lge/gles/GLESParticle;)V
    .locals 1
    .param p1, "particle"    # Lcom/lge/gles/GLESParticle;

    .prologue
    iget-object v0, p0, Lcom/lge/gles/GLESParticleSet;->mParticleList:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public clear()V
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/gles/GLESParticleSet;->mParticleList:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    return-void
.end method

.method public create(FF)V
    .locals 1
    .param p1, "width"    # F
    .param p2, "height"    # F

    .prologue
    iput p1, p0, Lcom/lge/gles/GLESParticleSet;->mWidth:F

    iput p2, p0, Lcom/lge/gles/GLESParticleSet;->mHeight:F

    invoke-static {p1}, Lcom/lge/gles/GLESUtils;->convertScreenToSpace(F)F

    move-result v0

    iput v0, p0, Lcom/lge/gles/GLESParticleSet;->mWidthInSpace:F

    invoke-static {p2}, Lcom/lge/gles/GLESUtils;->convertScreenToSpace(F)F

    move-result v0

    iput v0, p0, Lcom/lge/gles/GLESParticleSet;->mHeightInSpace:F

    invoke-virtual {p0}, Lcom/lge/gles/GLESParticleSet;->onCreate()V

    return-void
.end method

.method protected disableAlphaBlending()V
    .locals 0

    .prologue
    invoke-static {}, Lcom/lge/gles/GLESTransform;->disableAlphaBlending()V

    return-void
.end method

.method public draw()V
    .locals 1
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "WrongCall"
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/gles/GLESParticleSet;->mShader:Lcom/lge/gles/GLESShader;

    invoke-virtual {v0}, Lcom/lge/gles/GLESShader;->useProgram()V

    invoke-virtual {p0}, Lcom/lge/gles/GLESParticleSet;->onDraw()V

    return-void
.end method

.method protected enableAlphaBlending(IIIIZ)V
    .locals 0
    .param p1, "srcColor"    # I
    .param p2, "dstColor"    # I
    .param p3, "srcAlpha"    # I
    .param p4, "dstAlpha"    # I
    .param p5, "disableDepthTest"    # Z

    .prologue
    invoke-static {p1, p2, p3, p4, p5}, Lcom/lge/gles/GLESTransform;->enableAlphaBlending(IIIIZ)V

    return-void
.end method

.method protected enableAlphaBlending(Z)V
    .locals 0
    .param p1, "disableDepthTest"    # Z

    .prologue
    invoke-static {p1}, Lcom/lge/gles/GLESTransform;->enableAlphaBlending(Z)V

    return-void
.end method

.method public getNumOfParticle()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESParticleSet;->mNumOfParticle:I

    return v0
.end method

.method protected getParticleDuration()J
    .locals 6

    .prologue
    iget-wide v0, p0, Lcom/lge/gles/GLESParticleSet;->mParticleDurationDeviation:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    iget-wide v0, p0, Lcom/lge/gles/GLESParticleSet;->mMinParticleDuration:J

    :goto_0
    return-wide v0

    :cond_0
    iget-wide v0, p0, Lcom/lge/gles/GLESParticleSet;->mMinParticleDuration:J

    iget-object v2, p0, Lcom/lge/gles/GLESParticleSet;->mRandom:Ljava/util/Random;

    iget-wide v4, p0, Lcom/lge/gles/GLESParticleSet;->mParticleDurationDeviation:J

    long-to-int v3, v4

    invoke-virtual {v2, v3}, Ljava/util/Random;->nextInt(I)I

    move-result v2

    int-to-long v2, v2

    add-long/2addr v0, v2

    goto :goto_0
.end method

.method public getParticleList()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/lge/gles/GLESParticle;",
            ">;"
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/gles/GLESParticleSet;->mParticleList:Ljava/util/ArrayList;

    return-object v0
.end method

.method protected getParticleSize()F
    .locals 3

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESParticleSet;->mMinParticleSize:F

    iget-object v1, p0, Lcom/lge/gles/GLESParticleSet;->mRandom:Ljava/util/Random;

    invoke-virtual {v1}, Ljava/util/Random;->nextFloat()F

    move-result v1

    iget v2, p0, Lcom/lge/gles/GLESParticleSet;->mParticleSizeDeviation:F

    mul-float/2addr v1, v2

    add-float/2addr v0, v1

    return v0
.end method

.method protected getParticleSize(F)F
    .locals 6
    .param p1, "factor"    # F

    .prologue
    iget-object v1, p0, Lcom/lge/gles/GLESParticleSet;->mRandom:Ljava/util/Random;

    invoke-virtual {v1}, Ljava/util/Random;->nextFloat()F

    move-result v1

    float-to-double v2, v1

    float-to-double v4, p1

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v2

    double-to-float v0, v2

    .local v0, "random":F
    iget v1, p0, Lcom/lge/gles/GLESParticleSet;->mMinParticleSize:F

    iget v2, p0, Lcom/lge/gles/GLESParticleSet;->mParticleSizeDeviation:F

    mul-float/2addr v2, v0

    add-float/2addr v1, v2

    return v1
.end method

.method public getShader()Lcom/lge/gles/GLESShader;
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/gles/GLESParticleSet;->mShader:Lcom/lge/gles/GLESShader;

    if-nez v0, :cond_0

    const-string v0, "quilt GLESParticleSet"

    const-string v1, "getShader() mShader is null"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    iget-object v0, p0, Lcom/lge/gles/GLESParticleSet;->mShader:Lcom/lge/gles/GLESShader;

    return-object v0
.end method

.method public getSpaceHeight()F
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESParticleSet;->mHeightInSpace:F

    return v0
.end method

.method public getSpaceWidth()F
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESParticleSet;->mWidthInSpace:F

    return v0
.end method

.method public getSurfaceHeight()F
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESParticleSet;->mHeight:F

    return v0
.end method

.method public getSurfaceWidth()F
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESParticleSet;->mWidth:F

    return v0
.end method

.method public getTexture()Lcom/lge/gles/GLESTexture;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/gles/GLESParticleSet;->mTexture:Lcom/lge/gles/GLESTexture;

    return-object v0
.end method

.method public getUniformLocations()V
    .locals 0

    .prologue
    return-void
.end method

.method protected abstract onCreate()V
.end method

.method protected abstract onDraw()V
.end method

.method protected abstract onReset()V
.end method

.method protected abstract onUpdate()V
.end method

.method public reset()V
    .locals 0

    .prologue
    invoke-virtual {p0}, Lcom/lge/gles/GLESParticleSet;->onReset()V

    return-void
.end method

.method public setAlpha(F)V
    .locals 0
    .param p1, "alpha"    # F

    .prologue
    return-void
.end method

.method public setParticleDurationRange(JJ)V
    .locals 3
    .param p1, "min"    # J
    .param p3, "max"    # J

    .prologue
    cmp-long v0, p3, p1

    if-gez v0, :cond_0

    const-string v0, "quilt GLESParticleSet"

    const-string v1, "setParticleDuration() max is smaller than min"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    iput-wide p1, p0, Lcom/lge/gles/GLESParticleSet;->mMinParticleDuration:J

    sub-long v0, p3, p1

    iput-wide v0, p0, Lcom/lge/gles/GLESParticleSet;->mParticleDurationDeviation:J

    goto :goto_0
.end method

.method public setParticleSize(F)V
    .locals 1
    .param p1, "size"    # F

    .prologue
    iget-object v0, p0, Lcom/lge/gles/GLESParticleSet;->mContext:Landroid/content/Context;

    invoke-static {v0, p1}, Lcom/lge/gles/GLESUtils;->getPixelFromDpi(Landroid/content/Context;F)F

    move-result v0

    iput v0, p0, Lcom/lge/gles/GLESParticleSet;->mMinParticleSize:F

    const/4 v0, 0x0

    iput v0, p0, Lcom/lge/gles/GLESParticleSet;->mParticleSizeDeviation:F

    return-void
.end method

.method public setParticleSizeRange(FF)V
    .locals 2
    .param p1, "min"    # F
    .param p2, "max"    # F

    .prologue
    cmpg-float v0, p2, p1

    if-gez v0, :cond_0

    const-string v0, "quilt GLESParticleSet"

    const-string v1, "setSizeRange() max is smaller than min"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/lge/gles/GLESParticleSet;->mContext:Landroid/content/Context;

    invoke-static {v0, p1}, Lcom/lge/gles/GLESUtils;->getPixelFromDpi(Landroid/content/Context;F)F

    move-result p1

    iget-object v0, p0, Lcom/lge/gles/GLESParticleSet;->mContext:Landroid/content/Context;

    invoke-static {v0, p2}, Lcom/lge/gles/GLESUtils;->getPixelFromDpi(Landroid/content/Context;F)F

    move-result p2

    iput p1, p0, Lcom/lge/gles/GLESParticleSet;->mMinParticleSize:F

    sub-float v0, p2, p1

    iput v0, p0, Lcom/lge/gles/GLESParticleSet;->mParticleSizeDeviation:F

    goto :goto_0
.end method

.method public setParticleSizeRangeByPercentageOfBitmap(FF)V
    .locals 3
    .param p1, "min"    # F
    .param p2, "max"    # F

    .prologue
    const v2, 0x3c23d70a    # 0.01f

    cmpg-float v0, p2, p1

    if-gez v0, :cond_0

    const-string v0, "quilt GLESParticleSet"

    const-string v1, "setParticleSizeRangeByPercentageOfBitmap() max is smaller than min"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/lge/gles/GLESParticleSet;->mTexture:Lcom/lge/gles/GLESTexture;

    invoke-virtual {v0}, Lcom/lge/gles/GLESTexture;->getWidth()I

    move-result v0

    int-to-float v0, v0

    mul-float v1, p1, v2

    mul-float p1, v0, v1

    iget-object v0, p0, Lcom/lge/gles/GLESParticleSet;->mTexture:Lcom/lge/gles/GLESTexture;

    invoke-virtual {v0}, Lcom/lge/gles/GLESTexture;->getWidth()I

    move-result v0

    int-to-float v0, v0

    mul-float v1, p2, v2

    mul-float p2, v0, v1

    iput p1, p0, Lcom/lge/gles/GLESParticleSet;->mMinParticleSize:F

    sub-float v0, p2, p1

    iput v0, p0, Lcom/lge/gles/GLESParticleSet;->mParticleSizeDeviation:F

    goto :goto_0
.end method

.method public setPercentageOfSize(F)V
    .locals 0
    .param p1, "percentageOfSize"    # F

    .prologue
    return-void
.end method

.method public setPosition(FF)V
    .locals 0
    .param p1, "x"    # F
    .param p2, "y"    # F

    .prologue
    return-void
.end method

.method public setRadius(F)V
    .locals 0
    .param p1, "radius"    # F

    .prologue
    return-void
.end method

.method public setShader(Lcom/lge/gles/GLESShader;)V
    .locals 0
    .param p1, "shader"    # Lcom/lge/gles/GLESShader;

    .prologue
    iput-object p1, p0, Lcom/lge/gles/GLESParticleSet;->mShader:Lcom/lge/gles/GLESShader;

    return-void
.end method

.method public setupSpace(FF)V
    .locals 0
    .param p1, "width"    # F
    .param p2, "height"    # F

    .prologue
    iput p1, p0, Lcom/lge/gles/GLESParticleSet;->mWidth:F

    iput p2, p0, Lcom/lge/gles/GLESParticleSet;->mHeight:F

    return-void
.end method

.method public update()V
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/gles/GLESParticleSet;->mShader:Lcom/lge/gles/GLESShader;

    invoke-virtual {v0}, Lcom/lge/gles/GLESShader;->useProgram()V

    invoke-virtual {p0}, Lcom/lge/gles/GLESParticleSet;->onUpdate()V

    return-void
.end method
