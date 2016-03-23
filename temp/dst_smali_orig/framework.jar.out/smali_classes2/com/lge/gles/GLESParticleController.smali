.class public abstract Lcom/lge/gles/GLESParticleController;
.super Ljava/lang/Object;
.source "GLESParticleController.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/gles/GLESParticleController$DummyObject;
    }
.end annotation


# static fields
.field private static final DEBUG:Z = false

.field private static final TAG:Ljava/lang/String; = "quilt GLESParticleController"


# instance fields
.field protected mContext:Landroid/content/Context;

.field private mDisableDepthTest:Z

.field private mDstAlpha:I

.field private mDstColor:I

.field protected mDummyObject:Lcom/lge/gles/GLESParticleController$DummyObject;

.field private mEnableAlphaBlending:Z

.field protected mHeight:F

.field private mIsVisible:Z

.field protected mParticleSetList:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/lge/gles/GLESParticleSet;",
            ">;"
        }
    .end annotation
.end field

.field protected mShader:Lcom/lge/gles/GLESShader;

.field private mSrcAlpha:I

.field private mSrcColor:I

.field protected mWidth:F


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v2, 0x0

    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/lge/gles/GLESParticleController;->mDummyObject:Lcom/lge/gles/GLESParticleController$DummyObject;

    iput-object v0, p0, Lcom/lge/gles/GLESParticleController;->mContext:Landroid/content/Context;

    iput-object v0, p0, Lcom/lge/gles/GLESParticleController;->mShader:Lcom/lge/gles/GLESShader;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/lge/gles/GLESParticleController;->mParticleSetList:Ljava/util/ArrayList;

    iput v2, p0, Lcom/lge/gles/GLESParticleController;->mWidth:F

    iput v2, p0, Lcom/lge/gles/GLESParticleController;->mHeight:F

    iput-boolean v1, p0, Lcom/lge/gles/GLESParticleController;->mIsVisible:Z

    iput-boolean v1, p0, Lcom/lge/gles/GLESParticleController;->mEnableAlphaBlending:Z

    iput-object p1, p0, Lcom/lge/gles/GLESParticleController;->mContext:Landroid/content/Context;

    new-instance v0, Lcom/lge/gles/GLESParticleController$DummyObject;

    invoke-direct {v0, p0, p1, v1, v1}, Lcom/lge/gles/GLESParticleController$DummyObject;-><init>(Lcom/lge/gles/GLESParticleController;Landroid/content/Context;ZZ)V

    iput-object v0, p0, Lcom/lge/gles/GLESParticleController;->mDummyObject:Lcom/lge/gles/GLESParticleController$DummyObject;

    return-void
.end method


# virtual methods
.method public addParticleSet(Lcom/lge/gles/GLESParticleSet;)V
    .locals 1
    .param p1, "particleSet"    # Lcom/lge/gles/GLESParticleSet;

    .prologue
    iget-object v0, p0, Lcom/lge/gles/GLESParticleController;->mParticleSetList:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public create(FF)V
    .locals 4
    .param p1, "width"    # F
    .param p2, "height"    # F

    .prologue
    iget-object v3, p0, Lcom/lge/gles/GLESParticleController;->mParticleSetList:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->clear()V

    invoke-virtual {p0}, Lcom/lge/gles/GLESParticleController;->createParticleSet()V

    const/4 v1, 0x0

    .local v1, "particleSet":Lcom/lge/gles/GLESParticleSet;
    iget-object v3, p0, Lcom/lge/gles/GLESParticleController;->mParticleSetList:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v2

    .local v2, "size":I
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, v2, :cond_0

    iget-object v3, p0, Lcom/lge/gles/GLESParticleController;->mParticleSetList:Ljava/util/ArrayList;

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    .end local v1    # "particleSet":Lcom/lge/gles/GLESParticleSet;
    check-cast v1, Lcom/lge/gles/GLESParticleSet;

    .restart local v1    # "particleSet":Lcom/lge/gles/GLESParticleSet;
    invoke-virtual {v1, p1, p2}, Lcom/lge/gles/GLESParticleSet;->create(FF)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_1
    if-ge v0, v2, :cond_1

    iget-object v3, p0, Lcom/lge/gles/GLESParticleController;->mParticleSetList:Ljava/util/ArrayList;

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    .end local v1    # "particleSet":Lcom/lge/gles/GLESParticleSet;
    check-cast v1, Lcom/lge/gles/GLESParticleSet;

    .restart local v1    # "particleSet":Lcom/lge/gles/GLESParticleSet;
    iget-object v3, p0, Lcom/lge/gles/GLESParticleController;->mShader:Lcom/lge/gles/GLESShader;

    invoke-virtual {v1, v3}, Lcom/lge/gles/GLESParticleSet;->setShader(Lcom/lge/gles/GLESShader;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/lge/gles/GLESParticleController;->getUniformLocations()V

    return-void
.end method

.method protected abstract createParticleSet()V
.end method

.method public drawObject()V
    .locals 9

    .prologue
    const/4 v8, 0x1

    iget-boolean v3, p0, Lcom/lge/gles/GLESParticleController;->mIsVisible:Z

    if-ne v3, v8, :cond_2

    iget-object v3, p0, Lcom/lge/gles/GLESParticleController;->mShader:Lcom/lge/gles/GLESShader;

    invoke-virtual {v3}, Lcom/lge/gles/GLESShader;->useProgram()V

    iget-boolean v3, p0, Lcom/lge/gles/GLESParticleController;->mEnableAlphaBlending:Z

    if-ne v3, v8, :cond_0

    iget v3, p0, Lcom/lge/gles/GLESParticleController;->mSrcColor:I

    iget v4, p0, Lcom/lge/gles/GLESParticleController;->mDstColor:I

    iget v5, p0, Lcom/lge/gles/GLESParticleController;->mSrcAlpha:I

    iget v6, p0, Lcom/lge/gles/GLESParticleController;->mDstAlpha:I

    iget-boolean v7, p0, Lcom/lge/gles/GLESParticleController;->mDisableDepthTest:Z

    invoke-static {v3, v4, v5, v6, v7}, Lcom/lge/gles/GLESTransform;->enableAlphaBlending(IIIIZ)V

    :cond_0
    const/4 v1, 0x0

    .local v1, "particleSet":Lcom/lge/gles/GLESParticleSet;
    iget-object v3, p0, Lcom/lge/gles/GLESParticleController;->mParticleSetList:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v2

    .local v2, "size":I
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, v2, :cond_1

    iget-object v3, p0, Lcom/lge/gles/GLESParticleController;->mParticleSetList:Ljava/util/ArrayList;

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    .end local v1    # "particleSet":Lcom/lge/gles/GLESParticleSet;
    check-cast v1, Lcom/lge/gles/GLESParticleSet;

    .restart local v1    # "particleSet":Lcom/lge/gles/GLESParticleSet;
    invoke-virtual {v1}, Lcom/lge/gles/GLESParticleSet;->update()V

    invoke-virtual {v1}, Lcom/lge/gles/GLESParticleSet;->draw()V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    iget-boolean v3, p0, Lcom/lge/gles/GLESParticleController;->mEnableAlphaBlending:Z

    if-ne v3, v8, :cond_2

    invoke-static {}, Lcom/lge/gles/GLESTransform;->disableAlphaBlending()V

    .end local v0    # "i":I
    .end local v1    # "particleSet":Lcom/lge/gles/GLESParticleSet;
    .end local v2    # "size":I
    :cond_2
    return-void
.end method

.method public enableAlphaBlending(IIIIZ)V
    .locals 1
    .param p1, "srcColor"    # I
    .param p2, "dstColor"    # I
    .param p3, "srcAlpha"    # I
    .param p4, "dstAlpha"    # I
    .param p5, "disableDepthTest"    # Z

    .prologue
    iput p1, p0, Lcom/lge/gles/GLESParticleController;->mSrcColor:I

    iput p3, p0, Lcom/lge/gles/GLESParticleController;->mSrcAlpha:I

    iput p2, p0, Lcom/lge/gles/GLESParticleController;->mDstColor:I

    iput p4, p0, Lcom/lge/gles/GLESParticleController;->mDstAlpha:I

    iput-boolean p5, p0, Lcom/lge/gles/GLESParticleController;->mDisableDepthTest:Z

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/lge/gles/GLESParticleController;->mEnableAlphaBlending:Z

    return-void
.end method

.method public enableAlphaBlending(Z)V
    .locals 2
    .param p1, "disableDepthTest"    # Z

    .prologue
    const/16 v1, 0x303

    const/16 v0, 0x302

    iput v0, p0, Lcom/lge/gles/GLESParticleController;->mSrcColor:I

    iput v0, p0, Lcom/lge/gles/GLESParticleController;->mSrcAlpha:I

    iput v1, p0, Lcom/lge/gles/GLESParticleController;->mDstColor:I

    iput v1, p0, Lcom/lge/gles/GLESParticleController;->mDstAlpha:I

    iput-boolean p1, p0, Lcom/lge/gles/GLESParticleController;->mDisableDepthTest:Z

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/lge/gles/GLESParticleController;->mEnableAlphaBlending:Z

    return-void
.end method

.method protected getParticleSetList()Ljava/util/ArrayList;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList",
            "<",
            "Lcom/lge/gles/GLESParticleSet;",
            ">;"
        }
    .end annotation

    .prologue
    iget-object v0, p0, Lcom/lge/gles/GLESParticleController;->mParticleSetList:Ljava/util/ArrayList;

    if-nez v0, :cond_0

    const-string v0, "quilt GLESParticleController"

    const-string v1, "getParticleSetList() mParticleSetList is null"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    iget-object v0, p0, Lcom/lge/gles/GLESParticleController;->mParticleSetList:Ljava/util/ArrayList;

    return-object v0
.end method

.method protected getShader()Lcom/lge/gles/GLESShader;
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/gles/GLESParticleController;->mShader:Lcom/lge/gles/GLESShader;

    if-nez v0, :cond_0

    const-string v0, "quilt GLESParticleController"

    const-string v1, "getShader() mShader is null"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    iget-object v0, p0, Lcom/lge/gles/GLESParticleController;->mShader:Lcom/lge/gles/GLESShader;

    return-object v0
.end method

.method public getUniformLocations()V
    .locals 4

    .prologue
    const/4 v1, 0x0

    .local v1, "particleSet":Lcom/lge/gles/GLESParticleSet;
    iget-object v3, p0, Lcom/lge/gles/GLESParticleController;->mParticleSetList:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v2

    .local v2, "size":I
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, v2, :cond_0

    iget-object v3, p0, Lcom/lge/gles/GLESParticleController;->mParticleSetList:Ljava/util/ArrayList;

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    .end local v1    # "particleSet":Lcom/lge/gles/GLESParticleSet;
    check-cast v1, Lcom/lge/gles/GLESParticleSet;

    .restart local v1    # "particleSet":Lcom/lge/gles/GLESParticleSet;
    invoke-virtual {v1}, Lcom/lge/gles/GLESParticleSet;->getUniformLocations()V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method public hide()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/gles/GLESParticleController;->mIsVisible:Z

    return-void
.end method

.method public reset()V
    .locals 4

    .prologue
    const/4 v1, 0x0

    .local v1, "particleSet":Lcom/lge/gles/GLESParticleSet;
    iget-object v3, p0, Lcom/lge/gles/GLESParticleController;->mParticleSetList:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v2

    .local v2, "size":I
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, v2, :cond_0

    iget-object v3, p0, Lcom/lge/gles/GLESParticleController;->mParticleSetList:Ljava/util/ArrayList;

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    .end local v1    # "particleSet":Lcom/lge/gles/GLESParticleSet;
    check-cast v1, Lcom/lge/gles/GLESParticleSet;

    .restart local v1    # "particleSet":Lcom/lge/gles/GLESParticleSet;
    invoke-virtual {v1}, Lcom/lge/gles/GLESParticleSet;->reset()V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method public setAlpha(F)V
    .locals 4
    .param p1, "alpha"    # F

    .prologue
    const/4 v1, 0x0

    .local v1, "particleSet":Lcom/lge/gles/GLESParticleSet;
    iget-object v3, p0, Lcom/lge/gles/GLESParticleController;->mParticleSetList:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v2

    .local v2, "size":I
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, v2, :cond_0

    iget-object v3, p0, Lcom/lge/gles/GLESParticleController;->mParticleSetList:Ljava/util/ArrayList;

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    .end local v1    # "particleSet":Lcom/lge/gles/GLESParticleSet;
    check-cast v1, Lcom/lge/gles/GLESParticleSet;

    .restart local v1    # "particleSet":Lcom/lge/gles/GLESParticleSet;
    invoke-virtual {v1, p1}, Lcom/lge/gles/GLESParticleSet;->setAlpha(F)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method public setPercentageOfSize(F)V
    .locals 4
    .param p1, "percentageOfSize"    # F

    .prologue
    const/4 v1, 0x0

    .local v1, "particleSet":Lcom/lge/gles/GLESParticleSet;
    iget-object v3, p0, Lcom/lge/gles/GLESParticleController;->mParticleSetList:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v2

    .local v2, "size":I
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, v2, :cond_0

    iget-object v3, p0, Lcom/lge/gles/GLESParticleController;->mParticleSetList:Ljava/util/ArrayList;

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    .end local v1    # "particleSet":Lcom/lge/gles/GLESParticleSet;
    check-cast v1, Lcom/lge/gles/GLESParticleSet;

    .restart local v1    # "particleSet":Lcom/lge/gles/GLESParticleSet;
    invoke-virtual {v1, p1}, Lcom/lge/gles/GLESParticleSet;->setPercentageOfSize(F)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method public setPosition(FF)V
    .locals 4
    .param p1, "x"    # F
    .param p2, "y"    # F

    .prologue
    const/4 v1, 0x0

    .local v1, "particleSet":Lcom/lge/gles/GLESParticleSet;
    iget-object v3, p0, Lcom/lge/gles/GLESParticleController;->mParticleSetList:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v2

    .local v2, "size":I
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, v2, :cond_0

    iget-object v3, p0, Lcom/lge/gles/GLESParticleController;->mParticleSetList:Ljava/util/ArrayList;

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    .end local v1    # "particleSet":Lcom/lge/gles/GLESParticleSet;
    check-cast v1, Lcom/lge/gles/GLESParticleSet;

    .restart local v1    # "particleSet":Lcom/lge/gles/GLESParticleSet;
    invoke-virtual {v1, p1, p2}, Lcom/lge/gles/GLESParticleSet;->setPosition(FF)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method public setRadius(F)V
    .locals 4
    .param p1, "radius"    # F

    .prologue
    const/4 v1, 0x0

    .local v1, "particleSet":Lcom/lge/gles/GLESParticleSet;
    iget-object v3, p0, Lcom/lge/gles/GLESParticleController;->mParticleSetList:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v2

    .local v2, "size":I
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, v2, :cond_0

    iget-object v3, p0, Lcom/lge/gles/GLESParticleController;->mParticleSetList:Ljava/util/ArrayList;

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    .end local v1    # "particleSet":Lcom/lge/gles/GLESParticleSet;
    check-cast v1, Lcom/lge/gles/GLESParticleSet;

    .restart local v1    # "particleSet":Lcom/lge/gles/GLESParticleSet;
    invoke-virtual {v1, p1}, Lcom/lge/gles/GLESParticleSet;->setRadius(F)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method public setShader(Lcom/lge/gles/GLESShader;)V
    .locals 1
    .param p1, "shader"    # Lcom/lge/gles/GLESShader;

    .prologue
    iput-object p1, p0, Lcom/lge/gles/GLESParticleController;->mShader:Lcom/lge/gles/GLESShader;

    iget-object v0, p0, Lcom/lge/gles/GLESParticleController;->mShader:Lcom/lge/gles/GLESShader;

    invoke-virtual {v0}, Lcom/lge/gles/GLESShader;->useProgram()V

    iget-object v0, p0, Lcom/lge/gles/GLESParticleController;->mDummyObject:Lcom/lge/gles/GLESParticleController$DummyObject;

    invoke-virtual {v0, p1}, Lcom/lge/gles/GLESParticleController$DummyObject;->setShader(Lcom/lge/gles/GLESShader;)V

    return-void
.end method

.method public setupSpace(Lcom/lge/gles/GLESConfig$ProjectionType;II)V
    .locals 1
    .param p1, "projectionType"    # Lcom/lge/gles/GLESConfig$ProjectionType;
    .param p2, "width"    # I
    .param p3, "height"    # I

    .prologue
    int-to-float v0, p2

    iput v0, p0, Lcom/lge/gles/GLESParticleController;->mWidth:F

    int-to-float v0, p3

    iput v0, p0, Lcom/lge/gles/GLESParticleController;->mHeight:F

    iget-object v0, p0, Lcom/lge/gles/GLESParticleController;->mDummyObject:Lcom/lge/gles/GLESParticleController$DummyObject;

    invoke-virtual {v0, p1, p2, p3}, Lcom/lge/gles/GLESParticleController$DummyObject;->setupSpace(Lcom/lge/gles/GLESConfig$ProjectionType;II)V

    return-void
.end method

.method public setupSpace(Lcom/lge/gles/GLESConfig$ProjectionType;IIF)V
    .locals 1
    .param p1, "projectionType"    # Lcom/lge/gles/GLESConfig$ProjectionType;
    .param p2, "width"    # I
    .param p3, "height"    # I
    .param p4, "projectionScale"    # F

    .prologue
    int-to-float v0, p2

    iput v0, p0, Lcom/lge/gles/GLESParticleController;->mWidth:F

    int-to-float v0, p3

    iput v0, p0, Lcom/lge/gles/GLESParticleController;->mHeight:F

    iget-object v0, p0, Lcom/lge/gles/GLESParticleController;->mDummyObject:Lcom/lge/gles/GLESParticleController$DummyObject;

    invoke-virtual {v0, p1, p2, p3, p4}, Lcom/lge/gles/GLESParticleController$DummyObject;->setupSpace(Lcom/lge/gles/GLESConfig$ProjectionType;IIF)V

    return-void
.end method

.method public setupSpace(Lcom/lge/gles/GLESProjection;II)V
    .locals 1
    .param p1, "projection"    # Lcom/lge/gles/GLESProjection;
    .param p2, "width"    # I
    .param p3, "height"    # I

    .prologue
    int-to-float v0, p2

    iput v0, p0, Lcom/lge/gles/GLESParticleController;->mWidth:F

    int-to-float v0, p3

    iput v0, p0, Lcom/lge/gles/GLESParticleController;->mHeight:F

    iget-object v0, p0, Lcom/lge/gles/GLESParticleController;->mDummyObject:Lcom/lge/gles/GLESParticleController$DummyObject;

    invoke-virtual {v0, p1, p2, p3}, Lcom/lge/gles/GLESParticleController$DummyObject;->setupSpace(Lcom/lge/gles/GLESProjection;II)V

    return-void
.end method

.method public show()V
    .locals 1

    .prologue
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/lge/gles/GLESParticleController;->mIsVisible:Z

    return-void
.end method

.method public syncAll()V
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/gles/GLESParticleController;->mDummyObject:Lcom/lge/gles/GLESParticleController$DummyObject;

    invoke-virtual {v0}, Lcom/lge/gles/GLESParticleController$DummyObject;->syncAll()V

    return-void
.end method
