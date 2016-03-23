.class public Lcom/lge/gles/GLESTransform;
.super Ljava/lang/Object;
.source "GLESTransform.java"


# static fields
.field private static final DEBUG:Z = false

.field private static final TAG:Ljava/lang/String; = "quilt GLESTransform"

.field private static sIsAlphaBlending:Z


# instance fields
.field private mMMatrix:[F

.field private mMMatrixHandle:I

.field private mMatrixStack:Ljava/util/Vector;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Vector",
            "<[F>;"
        }
    .end annotation
.end field

.field private mShader:Lcom/lge/gles/GLESShader;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput-boolean v0, Lcom/lge/gles/GLESTransform;->sIsAlphaBlending:Z

    return-void
.end method

.method public constructor <init>(Lcom/lge/gles/GLESShader;)V
    .locals 1
    .param p1, "shader"    # Lcom/lge/gles/GLESShader;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/16 v0, 0x10

    new-array v0, v0, [F

    iput-object v0, p0, Lcom/lge/gles/GLESTransform;->mMMatrix:[F

    const/4 v0, -0x1

    iput v0, p0, Lcom/lge/gles/GLESTransform;->mMMatrixHandle:I

    new-instance v0, Ljava/util/Vector;

    invoke-direct {v0}, Ljava/util/Vector;-><init>()V

    iput-object v0, p0, Lcom/lge/gles/GLESTransform;->mMatrixStack:Ljava/util/Vector;

    iput-object p1, p0, Lcom/lge/gles/GLESTransform;->mShader:Lcom/lge/gles/GLESShader;

    iget-object v0, p0, Lcom/lge/gles/GLESTransform;->mMatrixStack:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->clear()V

    invoke-direct {p0}, Lcom/lge/gles/GLESTransform;->init()V

    return-void
.end method

.method public static disableAlphaBlending()V
    .locals 1

    .prologue
    sget-boolean v0, Lcom/lge/gles/GLESTransform;->sIsAlphaBlending:Z

    if-nez v0, :cond_0

    :goto_0
    return-void

    :cond_0
    const/16 v0, 0xbe2

    invoke-static {v0}, Landroid/opengl/GLES20;->glDisable(I)V

    const/16 v0, 0xb71

    invoke-static {v0}, Landroid/opengl/GLES20;->glEnable(I)V

    const/4 v0, 0x0

    sput-boolean v0, Lcom/lge/gles/GLESTransform;->sIsAlphaBlending:Z

    goto :goto_0
.end method

.method public static enableAlphaBlending(IIIIZ)V
    .locals 2
    .param p0, "srcColor"    # I
    .param p1, "dstColor"    # I
    .param p2, "srcAlpha"    # I
    .param p3, "dstAlpha"    # I
    .param p4, "disableDepthTest"    # Z

    .prologue
    const/4 v1, 0x1

    const/16 v0, 0xbe2

    invoke-static {v0}, Landroid/opengl/GLES20;->glEnable(I)V

    invoke-static {p0, p1, p2, p3}, Landroid/opengl/GLES20;->glBlendFuncSeparate(IIII)V

    if-ne p4, v1, :cond_0

    const/16 v0, 0xb71

    invoke-static {v0}, Landroid/opengl/GLES20;->glDisable(I)V

    :cond_0
    sput-boolean v1, Lcom/lge/gles/GLESTransform;->sIsAlphaBlending:Z

    return-void
.end method

.method public static enableAlphaBlending(Z)V
    .locals 3
    .param p0, "disableDepthTest"    # Z

    .prologue
    const/16 v2, 0x303

    const/4 v1, 0x1

    const/16 v0, 0xbe2

    invoke-static {v0}, Landroid/opengl/GLES20;->glEnable(I)V

    const/16 v0, 0x302

    invoke-static {v0, v2, v1, v2}, Landroid/opengl/GLES20;->glBlendFuncSeparate(IIII)V

    if-ne p0, v1, :cond_0

    const/16 v0, 0xb71

    invoke-static {v0}, Landroid/opengl/GLES20;->glDisable(I)V

    :cond_0
    sput-boolean v1, Lcom/lge/gles/GLESTransform;->sIsAlphaBlending:Z

    return-void
.end method

.method private init()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    iget-object v0, p0, Lcom/lge/gles/GLESTransform;->mShader:Lcom/lge/gles/GLESShader;

    const-string v1, "uMMatrix"

    invoke-virtual {v0, v1}, Lcom/lge/gles/GLESShader;->getUniformLocation(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/lge/gles/GLESTransform;->mMMatrixHandle:I

    iget-object v0, p0, Lcom/lge/gles/GLESTransform;->mMMatrix:[F

    invoke-static {v0, v3}, Landroid/opengl/Matrix;->setIdentityM([FI)V

    iget v0, p0, Lcom/lge/gles/GLESTransform;->mMMatrixHandle:I

    const/4 v1, 0x1

    iget-object v2, p0, Lcom/lge/gles/GLESTransform;->mMMatrix:[F

    invoke-static {v0, v1, v3, v2, v3}, Landroid/opengl/GLES20;->glUniformMatrix4fv(IIZ[FI)V

    return-void
.end method


# virtual methods
.method public destroy()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    iget-object v0, p0, Lcom/lge/gles/GLESTransform;->mMatrixStack:Ljava/util/Vector;

    invoke-virtual {v0}, Ljava/util/Vector;->clear()V

    iput-object v1, p0, Lcom/lge/gles/GLESTransform;->mMatrixStack:Ljava/util/Vector;

    iput-object v1, p0, Lcom/lge/gles/GLESTransform;->mMMatrix:[F

    return-void
.end method

.method public dump(Ljava/lang/String;)V
    .locals 0
    .param p1, "str"    # Ljava/lang/String;

    .prologue
    return-void
.end method

.method public getCurrentMatrix()[F
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/16 v1, 0x10

    new-array v0, v1, [F

    .local v0, "matrix":[F
    iget-object v1, p0, Lcom/lge/gles/GLESTransform;->mMMatrix:[F

    array-length v2, v0

    invoke-static {v1, v3, v0, v3, v2}, Ljava/lang/System;->arraycopy([FI[FII)V

    return-object v0
.end method

.method public getInverseMatrix()[F
    .locals 3

    .prologue
    const/4 v2, 0x0

    const/16 v1, 0x10

    new-array v0, v1, [F

    .local v0, "inverse":[F
    iget-object v1, p0, Lcom/lge/gles/GLESTransform;->mMMatrix:[F

    invoke-static {v0, v2, v1, v2}, Landroid/opengl/Matrix;->invertM([FI[FI)Z

    return-object v0
.end method

.method public getTransformHandle()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESTransform;->mMMatrixHandle:I

    return v0
.end method

.method public pop()V
    .locals 2

    .prologue
    iget-object v1, p0, Lcom/lge/gles/GLESTransform;->mMatrixStack:Ljava/util/Vector;

    invoke-virtual {v1}, Ljava/util/Vector;->size()I

    move-result v1

    add-int/lit8 v0, v1, -0x1

    .local v0, "lastIndex":I
    iget-object v1, p0, Lcom/lge/gles/GLESTransform;->mMatrixStack:Ljava/util/Vector;

    invoke-virtual {v1, v0}, Ljava/util/Vector;->remove(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [F

    iput-object v1, p0, Lcom/lge/gles/GLESTransform;->mMMatrix:[F

    return-void
.end method

.method public push()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/16 v1, 0x10

    new-array v0, v1, [F

    .local v0, "matrix":[F
    iget-object v1, p0, Lcom/lge/gles/GLESTransform;->mMMatrix:[F

    array-length v2, v0

    invoke-static {v1, v3, v0, v3, v2}, Ljava/lang/System;->arraycopy([FI[FII)V

    iget-object v1, p0, Lcom/lge/gles/GLESTransform;->mMatrixStack:Ljava/util/Vector;

    invoke-virtual {v1, v0}, Ljava/util/Vector;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public rotate(FFFF)V
    .locals 6
    .param p1, "angle"    # F
    .param p2, "x"    # F
    .param p3, "y"    # F
    .param p4, "z"    # F

    .prologue
    iget-object v0, p0, Lcom/lge/gles/GLESTransform;->mMMatrix:[F

    const/4 v1, 0x0

    move v2, p1

    move v3, p2

    move v4, p3

    move v5, p4

    invoke-static/range {v0 .. v5}, Landroid/opengl/Matrix;->rotateM([FIFFFF)V

    return-void
.end method

.method public scale(FFF)V
    .locals 2
    .param p1, "x"    # F
    .param p2, "y"    # F
    .param p3, "z"    # F

    .prologue
    iget-object v0, p0, Lcom/lge/gles/GLESTransform;->mMMatrix:[F

    const/4 v1, 0x0

    invoke-static {v0, v1, p1, p2, p3}, Landroid/opengl/Matrix;->scaleM([FIFFF)V

    return-void
.end method

.method public setIdentity()V
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/gles/GLESTransform;->mMMatrix:[F

    const/4 v1, 0x0

    invoke-static {v0, v1}, Landroid/opengl/Matrix;->setIdentityM([FI)V

    return-void
.end method

.method public setMatrix([F)V
    .locals 3
    .param p1, "matrix"    # [F

    .prologue
    const/4 v2, 0x0

    iget-object v0, p0, Lcom/lge/gles/GLESTransform;->mMMatrix:[F

    array-length v1, p1

    invoke-static {p1, v2, v0, v2, v1}, Ljava/lang/System;->arraycopy([FI[FII)V

    return-void
.end method

.method public sync()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    iget-object v0, p0, Lcom/lge/gles/GLESTransform;->mShader:Lcom/lge/gles/GLESShader;

    invoke-virtual {v0}, Lcom/lge/gles/GLESShader;->useProgram()V

    iget v0, p0, Lcom/lge/gles/GLESTransform;->mMMatrixHandle:I

    const/4 v1, 0x1

    iget-object v2, p0, Lcom/lge/gles/GLESTransform;->mMMatrix:[F

    invoke-static {v0, v1, v3, v2, v3}, Landroid/opengl/GLES20;->glUniformMatrix4fv(IIZ[FI)V

    return-void
.end method

.method public translate(FFF)V
    .locals 2
    .param p1, "x"    # F
    .param p2, "y"    # F
    .param p3, "z"    # F

    .prologue
    iget-object v0, p0, Lcom/lge/gles/GLESTransform;->mMMatrix:[F

    const/4 v1, 0x0

    invoke-static {v0, v1, p1, p2, p3}, Landroid/opengl/Matrix;->translateM([FIFFF)V

    return-void
.end method
