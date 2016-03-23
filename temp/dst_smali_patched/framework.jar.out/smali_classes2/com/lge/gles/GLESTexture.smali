.class public Lcom/lge/gles/GLESTexture;
.super Ljava/lang/Object;
.source "GLESTexture.java"


# static fields
.field private static final DEBUG:Z = false

.field private static final TAG:Ljava/lang/String; = "quilt GLESTexture"


# instance fields
.field private mFormat:I

.field private mHeight:I

.field private mTextureID:I

.field private mType:I

.field private mWidth:I

.field private mWrapMode:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/16 v0, 0x1908

    iput v0, p0, Lcom/lge/gles/GLESTexture;->mFormat:I

    const/16 v0, 0x1401

    iput v0, p0, Lcom/lge/gles/GLESTexture;->mType:I

    const v0, 0x812f

    iput v0, p0, Lcom/lge/gles/GLESTexture;->mWrapMode:I

    return-void
.end method

.method public constructor <init>(III)V
    .locals 1
    .param p1, "texId"    # I
    .param p2, "width"    # I
    .param p3, "height"    # I

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/16 v0, 0x1908

    iput v0, p0, Lcom/lge/gles/GLESTexture;->mFormat:I

    const/16 v0, 0x1401

    iput v0, p0, Lcom/lge/gles/GLESTexture;->mType:I

    const v0, 0x812f

    iput v0, p0, Lcom/lge/gles/GLESTexture;->mWrapMode:I

    iput p1, p0, Lcom/lge/gles/GLESTexture;->mTextureID:I

    iput p2, p0, Lcom/lge/gles/GLESTexture;->mWidth:I

    iput p3, p0, Lcom/lge/gles/GLESTexture;->mHeight:I

    return-void
.end method

.method public constructor <init>(IILandroid/graphics/Bitmap;)V
    .locals 1
    .param p1, "width"    # I
    .param p2, "height"    # I
    .param p3, "bitmap"    # Landroid/graphics/Bitmap;

    .prologue
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, p3, v0}, Lcom/lge/gles/GLESTexture;-><init>(IILandroid/graphics/Bitmap;Z)V

    return-void
.end method

.method public constructor <init>(IILandroid/graphics/Bitmap;Z)V
    .locals 1
    .param p1, "width"    # I
    .param p2, "height"    # I
    .param p3, "bitmap"    # Landroid/graphics/Bitmap;
    .param p4, "needToRecycle"    # Z

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/16 v0, 0x1908

    iput v0, p0, Lcom/lge/gles/GLESTexture;->mFormat:I

    const/16 v0, 0x1401

    iput v0, p0, Lcom/lge/gles/GLESTexture;->mType:I

    const v0, 0x812f

    iput v0, p0, Lcom/lge/gles/GLESTexture;->mWrapMode:I

    iput p1, p0, Lcom/lge/gles/GLESTexture;->mWidth:I

    iput p2, p0, Lcom/lge/gles/GLESTexture;->mHeight:I

    invoke-direct {p0, p3, p4}, Lcom/lge/gles/GLESTexture;->makeTexture(Landroid/graphics/Bitmap;Z)V

    return-void
.end method

.method public constructor <init>(Landroid/graphics/Bitmap;)V
    .locals 1
    .param p1, "bitmap"    # Landroid/graphics/Bitmap;

    .prologue
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/lge/gles/GLESTexture;-><init>(Landroid/graphics/Bitmap;Z)V

    return-void
.end method

.method public constructor <init>(Landroid/graphics/Bitmap;IZ)V
    .locals 1
    .param p1, "bitmap"    # Landroid/graphics/Bitmap;
    .param p2, "wrapMode"    # I
    .param p3, "needToRecycle"    # Z

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/16 v0, 0x1908

    iput v0, p0, Lcom/lge/gles/GLESTexture;->mFormat:I

    const/16 v0, 0x1401

    iput v0, p0, Lcom/lge/gles/GLESTexture;->mType:I

    const v0, 0x812f

    iput v0, p0, Lcom/lge/gles/GLESTexture;->mWrapMode:I

    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    iput v0, p0, Lcom/lge/gles/GLESTexture;->mWidth:I

    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v0

    iput v0, p0, Lcom/lge/gles/GLESTexture;->mHeight:I

    iput p2, p0, Lcom/lge/gles/GLESTexture;->mWrapMode:I

    invoke-direct {p0, p1, p3}, Lcom/lge/gles/GLESTexture;->makeTexture(Landroid/graphics/Bitmap;Z)V

    return-void
.end method

.method public constructor <init>(Landroid/graphics/Bitmap;Z)V
    .locals 1
    .param p1, "bitmap"    # Landroid/graphics/Bitmap;
    .param p2, "needToRecycle"    # Z

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/16 v0, 0x1908

    iput v0, p0, Lcom/lge/gles/GLESTexture;->mFormat:I

    const/16 v0, 0x1401

    iput v0, p0, Lcom/lge/gles/GLESTexture;->mType:I

    const v0, 0x812f

    iput v0, p0, Lcom/lge/gles/GLESTexture;->mWrapMode:I

    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    iput v0, p0, Lcom/lge/gles/GLESTexture;->mWidth:I

    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v0

    iput v0, p0, Lcom/lge/gles/GLESTexture;->mHeight:I

    invoke-direct {p0, p1, p2}, Lcom/lge/gles/GLESTexture;->makeTexture(Landroid/graphics/Bitmap;Z)V

    return-void
.end method

.method private makeTexture(Landroid/graphics/Bitmap;Z)V
    .locals 7
    .param p1, "bitmap"    # Landroid/graphics/Bitmap;
    .param p2, "needToRecycle"    # Z

    .prologue
    const v6, 0x46180400    # 9729.0f

    const/4 v5, 0x1

    const/4 v4, 0x0

    const/16 v3, 0xde1

    if-nez p1, :cond_1

    const-string v1, "quilt GLESTexture"

    const-string v2, "makeTexture() bitmap is null"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v1

    iput v1, p0, Lcom/lge/gles/GLESTexture;->mWidth:I

    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v1

    iput v1, p0, Lcom/lge/gles/GLESTexture;->mHeight:I

    new-array v0, v5, [I

    .local v0, "textureIds":[I
    invoke-static {v5, v0, v4}, Landroid/opengl/GLES20;->glGenTextures(I[II)V

    aget v1, v0, v4

    iput v1, p0, Lcom/lge/gles/GLESTexture;->mTextureID:I

    iget v1, p0, Lcom/lge/gles/GLESTexture;->mTextureID:I

    invoke-static {v3, v1}, Landroid/opengl/GLES20;->glBindTexture(II)V

    invoke-static {v3, v4, p1, v4}, Landroid/opengl/GLUtils;->texImage2D(IILandroid/graphics/Bitmap;I)V

    const/16 v1, 0x2802

    iget v2, p0, Lcom/lge/gles/GLESTexture;->mWrapMode:I

    invoke-static {v3, v1, v2}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    const/16 v1, 0x2803

    iget v2, p0, Lcom/lge/gles/GLESTexture;->mWrapMode:I

    invoke-static {v3, v1, v2}, Landroid/opengl/GLES20;->glTexParameteri(III)V

    const/16 v1, 0x2801

    invoke-static {v3, v1, v6}, Landroid/opengl/GLES20;->glTexParameterf(IIF)V

    const/16 v1, 0x2800

    invoke-static {v3, v1, v6}, Landroid/opengl/GLES20;->glTexParameterf(IIF)V

    invoke-static {v3, v4}, Landroid/opengl/GLES20;->glBindTexture(II)V

    if-ne p2, v5, :cond_0

    invoke-virtual {p1}, Landroid/graphics/Bitmap;->recycle()V

    goto :goto_0
.end method


# virtual methods
.method public changeTexture(Landroid/graphics/Bitmap;Z)V
    .locals 7
    .param p1, "bitmap"    # Landroid/graphics/Bitmap;
    .param p2, "needToRecycle"    # Z

    .prologue
    const/16 v6, 0xde1

    const/4 v5, 0x1

    const/4 v4, 0x0

    if-nez p1, :cond_1

    const-string v3, "quilt GLESTexture"

    const-string v4, "changeTexture() bitmap is null"

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-static {v6, v4}, Landroid/opengl/GLES20;->glBindTexture(II)V

    iget v3, p0, Lcom/lge/gles/GLESTexture;->mTextureID:I

    invoke-static {v3}, Landroid/opengl/GLES20;->glIsTexture(I)Z

    move-result v3

    if-ne v3, v5, :cond_3

    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v3

    int-to-float v2, v3

    .local v2, "width":F
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v3

    int-to-float v0, v3

    .local v0, "height":F
    iget v3, p0, Lcom/lge/gles/GLESTexture;->mWidth:I

    int-to-float v3, v3

    invoke-static {v2, v3}, Ljava/lang/Float;->compare(FF)I

    move-result v3

    if-nez v3, :cond_2

    iget v3, p0, Lcom/lge/gles/GLESTexture;->mHeight:I

    int-to-float v3, v3

    invoke-static {v0, v3}, Ljava/lang/Float;->compare(FF)I

    move-result v3

    if-nez v3, :cond_2

    iget v3, p0, Lcom/lge/gles/GLESTexture;->mTextureID:I

    invoke-static {v6, v3}, Landroid/opengl/GLES20;->glBindTexture(II)V

    invoke-static {v6, v4, v4, v4, p1}, Landroid/opengl/GLUtils;->texSubImage2D(IIIILandroid/graphics/Bitmap;)V

    invoke-static {v6, v4}, Landroid/opengl/GLES20;->glBindTexture(II)V

    if-ne p2, v5, :cond_0

    invoke-virtual {p1}, Landroid/graphics/Bitmap;->recycle()V

    goto :goto_0

    :cond_2
    new-array v1, v5, [I

    .local v1, "textures":[I
    iget v3, p0, Lcom/lge/gles/GLESTexture;->mTextureID:I

    aput v3, v1, v4

    invoke-static {v5, v1, v4}, Landroid/opengl/GLES20;->glDeleteTextures(I[II)V

    invoke-direct {p0, p1, p2}, Lcom/lge/gles/GLESTexture;->makeTexture(Landroid/graphics/Bitmap;Z)V

    goto :goto_0

    .end local v0    # "height":F
    .end local v1    # "textures":[I
    .end local v2    # "width":F
    :cond_3
    invoke-direct {p0, p1, p2}, Lcom/lge/gles/GLESTexture;->makeTexture(Landroid/graphics/Bitmap;Z)V

    goto :goto_0
.end method

.method public destroy()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/4 v2, 0x1

    iget v1, p0, Lcom/lge/gles/GLESTexture;->mTextureID:I

    invoke-static {v1}, Landroid/opengl/GLES20;->glIsTexture(I)Z

    move-result v1

    if-ne v1, v2, :cond_0

    new-array v0, v2, [I

    .local v0, "textures":[I
    iget v1, p0, Lcom/lge/gles/GLESTexture;->mTextureID:I

    aput v1, v0, v3

    invoke-static {v2, v0, v3}, Landroid/opengl/GLES20;->glDeleteTextures(I[II)V

    .end local v0    # "textures":[I
    :cond_0
    return-void
.end method

.method public getHeight()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESTexture;->mHeight:I

    return v0
.end method

.method public getTextureID()I
    .locals 2

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESTexture;->mTextureID:I

    invoke-static {v0}, Landroid/opengl/GLES20;->glIsTexture(I)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "quilt GLESTexture"

    const-string v1, "mTextureID is invalid"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, -0x1

    :goto_0
    return v0

    :cond_0
    iget v0, p0, Lcom/lge/gles/GLESTexture;->mTextureID:I

    goto :goto_0
.end method

.method public getWidth()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESTexture;->mWidth:I

    return v0
.end method

.method public makeSubTexture(IIZLandroid/graphics/Bitmap;)V
    .locals 3
    .param p1, "xOffset"    # I
    .param p2, "yOffset"    # I
    .param p3, "needToRecyle"    # Z
    .param p4, "bitmap"    # Landroid/graphics/Bitmap;

    .prologue
    const/4 v2, 0x0

    const/16 v1, 0xde1

    if-nez p4, :cond_1

    const-string v0, "quilt GLESTexture"

    const-string v1, "makeSubTexture() bitmap is null"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget v0, p0, Lcom/lge/gles/GLESTexture;->mTextureID:I

    invoke-static {v1, v0}, Landroid/opengl/GLES20;->glBindTexture(II)V

    invoke-static {v1, v2, p1, p2, p4}, Landroid/opengl/GLUtils;->texSubImage2D(IIIILandroid/graphics/Bitmap;)V

    invoke-static {v1, v2}, Landroid/opengl/GLES20;->glBindTexture(II)V

    const/4 v0, 0x1

    if-ne p3, v0, :cond_0

    invoke-virtual {p4}, Landroid/graphics/Bitmap;->recycle()V

    goto :goto_0
.end method
