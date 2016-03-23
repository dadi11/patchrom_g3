.class public Lcom/lge/gles/GLESProjection;
.super Ljava/lang/Object;
.source "GLESProjection.java"


# static fields
.field private static final DEBUG:Z = false

.field private static final DEFAULT_PROJ_SCALE:F = 4.0f

.field private static final PROJECTION_FAR:F = 128.0f

.field private static final PROJECTION_NEAR:F = 4.0f

.field private static final TAG:Ljava/lang/String; = "quilt GLESProjection"


# instance fields
.field private mHeight:I

.field private mPMatrix:[F

.field private mPMatrixHandle:I

.field private mProjectScale:F

.field private mProjectionType:Lcom/lge/gles/GLESConfig$ProjectionType;

.field private mShader:Lcom/lge/gles/GLESShader;

.field private mVMatrix:[F

.field private mVMatrixHandle:I

.field private mWidth:I


# direct methods
.method public constructor <init>(Lcom/lge/gles/GLESShader;Lcom/lge/gles/GLESConfig$ProjectionType;II)V
    .locals 6
    .param p1, "shader"    # Lcom/lge/gles/GLESShader;
    .param p2, "projectionType"    # Lcom/lge/gles/GLESConfig$ProjectionType;
    .param p3, "width"    # I
    .param p4, "height"    # I

    .prologue
    const/high16 v5, 0x40800000    # 4.0f

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v3, p3

    move v4, p4

    invoke-direct/range {v0 .. v5}, Lcom/lge/gles/GLESProjection;-><init>(Lcom/lge/gles/GLESShader;Lcom/lge/gles/GLESConfig$ProjectionType;IIF)V

    return-void
.end method

.method public constructor <init>(Lcom/lge/gles/GLESShader;Lcom/lge/gles/GLESConfig$ProjectionType;IIF)V
    .locals 2
    .param p1, "shader"    # Lcom/lge/gles/GLESShader;
    .param p2, "projectionType"    # Lcom/lge/gles/GLESConfig$ProjectionType;
    .param p3, "width"    # I
    .param p4, "height"    # I
    .param p5, "projScale"    # F

    .prologue
    const/16 v1, 0x10

    const/4 v0, -0x1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput v0, p0, Lcom/lge/gles/GLESProjection;->mPMatrixHandle:I

    iput v0, p0, Lcom/lge/gles/GLESProjection;->mVMatrixHandle:I

    new-array v0, v1, [F

    iput-object v0, p0, Lcom/lge/gles/GLESProjection;->mPMatrix:[F

    new-array v0, v1, [F

    iput-object v0, p0, Lcom/lge/gles/GLESProjection;->mVMatrix:[F

    iput-object p1, p0, Lcom/lge/gles/GLESProjection;->mShader:Lcom/lge/gles/GLESShader;

    iput-object p2, p0, Lcom/lge/gles/GLESProjection;->mProjectionType:Lcom/lge/gles/GLESConfig$ProjectionType;

    iput p3, p0, Lcom/lge/gles/GLESProjection;->mWidth:I

    iput p4, p0, Lcom/lge/gles/GLESProjection;->mHeight:I

    iput p5, p0, Lcom/lge/gles/GLESProjection;->mProjectScale:F

    invoke-direct {p0}, Lcom/lge/gles/GLESProjection;->buildProjection()V

    return-void
.end method

.method private buildProjection()V
    .locals 11

    .prologue
    const/4 v10, 0x0

    const/4 v9, 0x1

    const/high16 v7, 0x3f000000    # 0.5f

    const/4 v1, 0x0

    iget-object v0, p0, Lcom/lge/gles/GLESProjection;->mShader:Lcom/lge/gles/GLESShader;

    invoke-virtual {v0}, Lcom/lge/gles/GLESShader;->useProgram()V

    iget-object v0, p0, Lcom/lge/gles/GLESProjection;->mShader:Lcom/lge/gles/GLESShader;

    const-string v6, "uPMatrix"

    invoke-virtual {v0, v6}, Lcom/lge/gles/GLESShader;->getUniformLocation(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/lge/gles/GLESProjection;->mPMatrixHandle:I

    iget-object v0, p0, Lcom/lge/gles/GLESProjection;->mShader:Lcom/lge/gles/GLESShader;

    const-string v6, "uVMatrix"

    invoke-virtual {v0, v6}, Lcom/lge/gles/GLESShader;->getUniformLocation(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/lge/gles/GLESProjection;->mVMatrixHandle:I

    iget-object v0, p0, Lcom/lge/gles/GLESProjection;->mProjectionType:Lcom/lge/gles/GLESConfig$ProjectionType;

    sget-object v6, Lcom/lge/gles/GLESConfig$ProjectionType;->ORTHO:Lcom/lge/gles/GLESConfig$ProjectionType;

    if-ne v0, v6, :cond_0

    iget v0, p0, Lcom/lge/gles/GLESProjection;->mWidth:I

    int-to-float v0, v0

    mul-float/2addr v0, v7

    invoke-static {v0}, Lcom/lge/gles/GLESUtils;->convertScreenToSpace(F)F

    move-result v3

    .local v3, "right":F
    neg-float v2, v3

    .local v2, "left":F
    iget v0, p0, Lcom/lge/gles/GLESProjection;->mHeight:I

    int-to-float v0, v0

    mul-float/2addr v0, v7

    invoke-static {v0}, Lcom/lge/gles/GLESUtils;->convertScreenToSpace(F)F

    move-result v5

    .local v5, "top":F
    neg-float v4, v5

    .local v4, "bottom":F
    iget-object v0, p0, Lcom/lge/gles/GLESProjection;->mPMatrix:[F

    const/high16 v6, -0x3d380000    # -100.0f

    const/high16 v7, 0x42c80000    # 100.0f

    invoke-static/range {v0 .. v7}, Landroid/opengl/Matrix;->orthoM([FIFFFFFF)V

    iget v0, p0, Lcom/lge/gles/GLESProjection;->mPMatrixHandle:I

    iget-object v6, p0, Lcom/lge/gles/GLESProjection;->mPMatrix:[F

    invoke-static {v0, v9, v1, v6, v1}, Landroid/opengl/GLES20;->glUniformMatrix4fv(IIZ[FI)V

    iget-object v0, p0, Lcom/lge/gles/GLESProjection;->mVMatrix:[F

    invoke-static {v0, v1}, Landroid/opengl/Matrix;->setIdentityM([FI)V

    iget v0, p0, Lcom/lge/gles/GLESProjection;->mVMatrixHandle:I

    iget-object v6, p0, Lcom/lge/gles/GLESProjection;->mVMatrix:[F

    invoke-static {v0, v9, v1, v6, v1}, Landroid/opengl/GLES20;->glUniformMatrix4fv(IIZ[FI)V

    :goto_0
    return-void

    .end local v2    # "left":F
    .end local v3    # "right":F
    .end local v4    # "bottom":F
    .end local v5    # "top":F
    :cond_0
    iget-object v0, p0, Lcom/lge/gles/GLESProjection;->mProjectionType:Lcom/lge/gles/GLESConfig$ProjectionType;

    sget-object v6, Lcom/lge/gles/GLESConfig$ProjectionType;->FRUSTUM:Lcom/lge/gles/GLESConfig$ProjectionType;

    if-ne v0, v6, :cond_1

    iget v0, p0, Lcom/lge/gles/GLESProjection;->mWidth:I

    int-to-float v0, v0

    mul-float/2addr v0, v7

    iget v6, p0, Lcom/lge/gles/GLESProjection;->mProjectScale:F

    div-float/2addr v0, v6

    invoke-static {v0}, Lcom/lge/gles/GLESUtils;->convertScreenToSpace(F)F

    move-result v3

    .restart local v3    # "right":F
    neg-float v2, v3

    .restart local v2    # "left":F
    iget v0, p0, Lcom/lge/gles/GLESProjection;->mHeight:I

    int-to-float v0, v0

    mul-float/2addr v0, v7

    iget v6, p0, Lcom/lge/gles/GLESProjection;->mProjectScale:F

    div-float/2addr v0, v6

    invoke-static {v0}, Lcom/lge/gles/GLESUtils;->convertScreenToSpace(F)F

    move-result v5

    .restart local v5    # "top":F
    neg-float v4, v5

    .restart local v4    # "bottom":F
    iget-object v0, p0, Lcom/lge/gles/GLESProjection;->mPMatrix:[F

    const/high16 v6, 0x40800000    # 4.0f

    iget v7, p0, Lcom/lge/gles/GLESProjection;->mProjectScale:F

    const/high16 v8, 0x41000000    # 8.0f

    mul-float/2addr v7, v8

    invoke-static/range {v0 .. v7}, Landroid/opengl/Matrix;->frustumM([FIFFFFFF)V

    iget v0, p0, Lcom/lge/gles/GLESProjection;->mPMatrixHandle:I

    iget-object v6, p0, Lcom/lge/gles/GLESProjection;->mPMatrix:[F

    invoke-static {v0, v9, v1, v6, v1}, Landroid/opengl/GLES20;->glUniformMatrix4fv(IIZ[FI)V

    iget-object v0, p0, Lcom/lge/gles/GLESProjection;->mVMatrix:[F

    invoke-static {v0, v1}, Landroid/opengl/Matrix;->setIdentityM([FI)V

    iget-object v0, p0, Lcom/lge/gles/GLESProjection;->mVMatrix:[F

    const/high16 v6, -0x3f800000    # -4.0f

    iget v7, p0, Lcom/lge/gles/GLESProjection;->mProjectScale:F

    mul-float/2addr v6, v7

    invoke-static {v0, v1, v10, v10, v6}, Landroid/opengl/Matrix;->translateM([FIFFF)V

    iget v0, p0, Lcom/lge/gles/GLESProjection;->mVMatrixHandle:I

    iget-object v6, p0, Lcom/lge/gles/GLESProjection;->mVMatrix:[F

    invoke-static {v0, v9, v1, v6, v1}, Landroid/opengl/GLES20;->glUniformMatrix4fv(IIZ[FI)V

    goto :goto_0

    .end local v2    # "left":F
    .end local v3    # "right":F
    .end local v4    # "bottom":F
    .end local v5    # "top":F
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "buildProjection() invalid projection type"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public destroy()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/gles/GLESProjection;->mPMatrix:[F

    iput-object v0, p0, Lcom/lge/gles/GLESProjection;->mVMatrix:[F

    return-void
.end method

.method public dump(Ljava/lang/String;)V
    .locals 0
    .param p1, "str"    # Ljava/lang/String;

    .prologue
    return-void
.end method

.method public getProjectionMatrix()[F
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/16 v1, 0x10

    new-array v0, v1, [F

    .local v0, "matrix":[F
    iget-object v1, p0, Lcom/lge/gles/GLESProjection;->mPMatrix:[F

    array-length v2, v0

    invoke-static {v1, v3, v0, v3, v2}, Ljava/lang/System;->arraycopy([FI[FII)V

    return-object v0
.end method

.method public getProjectionScale()F
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESProjection;->mProjectScale:F

    return v0
.end method

.method public getProjectionType()Lcom/lge/gles/GLESConfig$ProjectionType;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/gles/GLESProjection;->mProjectionType:Lcom/lge/gles/GLESConfig$ProjectionType;

    return-object v0
.end method

.method public getViewMatrix()[F
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/16 v1, 0x10

    new-array v0, v1, [F

    .local v0, "matrix":[F
    iget-object v1, p0, Lcom/lge/gles/GLESProjection;->mVMatrix:[F

    array-length v2, v0

    invoke-static {v1, v3, v0, v3, v2}, Ljava/lang/System;->arraycopy([FI[FII)V

    return-object v0
.end method

.method public setFrustum(Lcom/lge/gles/GLESConfig$ProjectionType;FFFFFF)V
    .locals 8
    .param p1, "projType"    # Lcom/lge/gles/GLESConfig$ProjectionType;
    .param p2, "left"    # F
    .param p3, "right"    # F
    .param p4, "bottom"    # F
    .param p5, "top"    # F
    .param p6, "near"    # F
    .param p7, "far"    # F

    .prologue
    const/4 v1, 0x0

    iget-object v0, p0, Lcom/lge/gles/GLESProjection;->mPMatrix:[F

    invoke-static {v0, v1}, Landroid/opengl/Matrix;->setIdentityM([FI)V

    sget-object v0, Lcom/lge/gles/GLESConfig$ProjectionType;->FRUSTUM:Lcom/lge/gles/GLESConfig$ProjectionType;

    if-ne p1, v0, :cond_0

    iget-object v0, p0, Lcom/lge/gles/GLESProjection;->mPMatrix:[F

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    move v6, p6

    move v7, p7

    invoke-static/range {v0 .. v7}, Landroid/opengl/Matrix;->frustumM([FIFFFFFF)V

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/lge/gles/GLESProjection;->mPMatrix:[F

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    move v6, p6

    move v7, p7

    invoke-static/range {v0 .. v7}, Landroid/opengl/Matrix;->orthoM([FIFFFFFF)V

    goto :goto_0
.end method

.method public setProjectionMatrix(Lcom/lge/gles/GLESConfig$ProjectionType;FFFFFF)V
    .locals 8
    .param p1, "projType"    # Lcom/lge/gles/GLESConfig$ProjectionType;
    .param p2, "left"    # F
    .param p3, "right"    # F
    .param p4, "bottom"    # F
    .param p5, "top"    # F
    .param p6, "near"    # F
    .param p7, "far"    # F

    .prologue
    const/4 v1, 0x0

    sget-object v0, Lcom/lge/gles/GLESConfig$ProjectionType;->FRUSTUM:Lcom/lge/gles/GLESConfig$ProjectionType;

    if-ne p1, v0, :cond_0

    iget-object v0, p0, Lcom/lge/gles/GLESProjection;->mPMatrix:[F

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    move v6, p6

    move v7, p7

    invoke-static/range {v0 .. v7}, Landroid/opengl/Matrix;->frustumM([FIFFFFFF)V

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/lge/gles/GLESProjection;->mPMatrix:[F

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    move v6, p6

    move v7, p7

    invoke-static/range {v0 .. v7}, Landroid/opengl/Matrix;->orthoM([FIFFFFFF)V

    goto :goto_0
.end method

.method public setProjectionMatrix([F)V
    .locals 3
    .param p1, "matrix"    # [F

    .prologue
    const/4 v2, 0x0

    iget-object v0, p0, Lcom/lge/gles/GLESProjection;->mPMatrix:[F

    array-length v1, p1

    invoke-static {p1, v2, v0, v2, v1}, Ljava/lang/System;->arraycopy([FI[FII)V

    return-void
.end method

.method public setViewMatrix(FFF)V
    .locals 2
    .param p1, "x"    # F
    .param p2, "y"    # F
    .param p3, "z"    # F

    .prologue
    const/4 v1, 0x0

    iget-object v0, p0, Lcom/lge/gles/GLESProjection;->mVMatrix:[F

    invoke-static {v0, v1}, Landroid/opengl/Matrix;->setIdentityM([FI)V

    iget-object v0, p0, Lcom/lge/gles/GLESProjection;->mVMatrix:[F

    invoke-static {v0, v1, p1, p2, p3}, Landroid/opengl/Matrix;->translateM([FIFFF)V

    return-void
.end method

.method public setViewMatrix([F)V
    .locals 3
    .param p1, "matrix"    # [F

    .prologue
    const/4 v2, 0x0

    iget-object v0, p0, Lcom/lge/gles/GLESProjection;->mVMatrix:[F

    array-length v1, p1

    invoke-static {p1, v2, v0, v2, v1}, Ljava/lang/System;->arraycopy([FI[FII)V

    return-void
.end method

.method public sync()V
    .locals 4

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    iget-object v0, p0, Lcom/lge/gles/GLESProjection;->mShader:Lcom/lge/gles/GLESShader;

    invoke-virtual {v0}, Lcom/lge/gles/GLESShader;->useProgram()V

    iget v0, p0, Lcom/lge/gles/GLESProjection;->mPMatrixHandle:I

    iget-object v1, p0, Lcom/lge/gles/GLESProjection;->mPMatrix:[F

    invoke-static {v0, v3, v2, v1, v2}, Landroid/opengl/GLES20;->glUniformMatrix4fv(IIZ[FI)V

    iget v0, p0, Lcom/lge/gles/GLESProjection;->mVMatrixHandle:I

    iget-object v1, p0, Lcom/lge/gles/GLESProjection;->mVMatrix:[F

    invoke-static {v0, v3, v2, v1, v2}, Landroid/opengl/GLES20;->glUniformMatrix4fv(IIZ[FI)V

    return-void
.end method
