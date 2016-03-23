.class public Lcom/lge/gles/GLESParticleVertexInfo;
.super Ljava/lang/Object;
.source "GLESParticleVertexInfo.java"


# static fields
.field private static final DEBUG:Z = false

.field private static final TAG:Ljava/lang/String; = "quilt GLESVertexInfo"


# instance fields
.field private mIndexArray:[S

.field private mNumOfTexCoord:I

.field private mNumOfTexCoordElement:I

.field private mNumOfVertex:I

.field private mNumOfVertexElement:I

.field private mTexCoordArray:[F

.field private mTexCoordStride:I

.field private mUseTexCoord:Z

.field private mVertexArray:[F

.field private mVertexStride:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mNumOfVertexElement:I

    iput v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mNumOfVertex:I

    iput v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mVertexStride:I

    iput v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mNumOfTexCoordElement:I

    iput v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mNumOfTexCoord:I

    iput v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mTexCoordStride:I

    iput-boolean v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mUseTexCoord:Z

    return-void
.end method


# virtual methods
.method public createIndexArray(II)[S
    .locals 1
    .param p1, "numOfParticle"    # I
    .param p2, "numOfIndexElement"    # I

    .prologue
    mul-int v0, p1, p2

    new-array v0, v0, [S

    iput-object v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mIndexArray:[S

    iget-object v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mIndexArray:[S

    return-object v0
.end method

.method public createTexCoordArray(III)[F
    .locals 1
    .param p1, "numOfParticle"    # I
    .param p2, "numOfTexCoordElement"    # I
    .param p3, "numOfTexCoord"    # I

    .prologue
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mUseTexCoord:Z

    iput p2, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mNumOfTexCoordElement:I

    iput p3, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mNumOfTexCoord:I

    mul-int v0, p2, p3

    iput v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mTexCoordStride:I

    mul-int v0, p1, p2

    mul-int/2addr v0, p3

    new-array v0, v0, [F

    iput-object v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mTexCoordArray:[F

    iget-object v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mTexCoordArray:[F

    return-object v0
.end method

.method public createVertexArray(III)[F
    .locals 1
    .param p1, "numOfParticle"    # I
    .param p2, "numOfVertexElement"    # I
    .param p3, "numOfVertex"    # I

    .prologue
    iput p2, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mNumOfVertexElement:I

    iput p3, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mNumOfVertex:I

    mul-int v0, p2, p3

    iput v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mVertexStride:I

    mul-int v0, p1, p2

    mul-int/2addr v0, p3

    new-array v0, v0, [F

    iput-object v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mVertexArray:[F

    iget-object v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mVertexArray:[F

    return-object v0
.end method

.method public getIndexArray()[S
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mIndexArray:[S

    return-object v0
.end method

.method public getNumOfTexCoord()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mNumOfTexCoord:I

    return v0
.end method

.method public getNumOfTexCoordElement()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mNumOfTexCoordElement:I

    return v0
.end method

.method public getNumOfVertex()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mNumOfVertex:I

    return v0
.end method

.method public getNumOfVertexElement()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mNumOfVertexElement:I

    return v0
.end method

.method public getTexCoordArray()[F
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mTexCoordArray:[F

    return-object v0
.end method

.method public getTexCoordStride()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mTexCoordStride:I

    return v0
.end method

.method public getUseTexCoord()Z
    .locals 1

    .prologue
    iget-boolean v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mUseTexCoord:Z

    return v0
.end method

.method public getVertexArray()[F
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mVertexArray:[F

    return-object v0
.end method

.method public getVertexStride()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESParticleVertexInfo;->mVertexStride:I

    return v0
.end method
