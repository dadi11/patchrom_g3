.class public Lcom/lge/gles/GLESShader;
.super Ljava/lang/Object;
.source "GLESShader.java"


# static fields
.field private static final DEBUG:Z = false

.field private static final TAG:Ljava/lang/String; = "quilt GLESShader"


# instance fields
.field private mColorIndex:I

.field private final mContext:Landroid/content/Context;

.field private mFragmentShaderID:I

.field private mFragmentShaderSource:Ljava/lang/String;

.field private mNormalIndex:I

.field private mProgram:I

.field private final mRes:Landroid/content/res/Resources;

.field private mTexCoordIndex:I

.field private mUseResourceID:Z

.field private mVertexIndex:I

.field private mVertexShaderID:I

.field private mVertexShaderSource:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const-string v0, "q3d"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v1, 0x0

    const/4 v0, -0x1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput v0, p0, Lcom/lge/gles/GLESShader;->mVertexIndex:I

    iput v0, p0, Lcom/lge/gles/GLESShader;->mTexCoordIndex:I

    iput v0, p0, Lcom/lge/gles/GLESShader;->mNormalIndex:I

    iput v0, p0, Lcom/lge/gles/GLESShader;->mColorIndex:I

    iput-object v1, p0, Lcom/lge/gles/GLESShader;->mVertexShaderSource:Ljava/lang/String;

    iput-object v1, p0, Lcom/lge/gles/GLESShader;->mFragmentShaderSource:Ljava/lang/String;

    iput v0, p0, Lcom/lge/gles/GLESShader;->mVertexShaderID:I

    iput v0, p0, Lcom/lge/gles/GLESShader;->mFragmentShaderID:I

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/lge/gles/GLESShader;->mUseResourceID:Z

    iput-object p1, p0, Lcom/lge/gles/GLESShader;->mContext:Landroid/content/Context;

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/gles/GLESShader;->mRes:Landroid/content/res/Resources;

    invoke-static {}, Landroid/opengl/GLES20;->glCreateProgram()I

    move-result v0

    iput v0, p0, Lcom/lge/gles/GLESShader;->mProgram:I

    iget v0, p0, Lcom/lge/gles/GLESShader;->mProgram:I

    if-nez v0, :cond_0

    const-string v0, "quilt GLESShader"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "glCreateProgram() error="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {}, Landroid/opengl/GLES20;->glGetError()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "glCreateProgram() error="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {}, Landroid/opengl/GLES20;->glGetError()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    return-void
.end method

.method private compileAndLink()Z
    .locals 6

    .prologue
    const v5, 0x8b31

    const v4, 0x8b30

    const/4 v2, 0x1

    const/4 v1, 0x0

    const/4 v0, 0x0

    .local v0, "res":Z
    iget-boolean v3, p0, Lcom/lge/gles/GLESShader;->mUseResourceID:Z

    if-ne v3, v2, :cond_3

    iget v3, p0, Lcom/lge/gles/GLESShader;->mVertexShaderID:I

    invoke-direct {p0, v5, v3}, Lcom/lge/gles/GLESShader;->setShaderFromResource(II)Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    iget v3, p0, Lcom/lge/gles/GLESShader;->mFragmentShaderID:I

    invoke-direct {p0, v4, v3}, Lcom/lge/gles/GLESShader;->setShaderFromResource(II)Z

    move-result v0

    if-eqz v0, :cond_0

    :cond_2
    invoke-direct {p0}, Lcom/lge/gles/GLESShader;->linkProgram()Z

    move-result v0

    if-eqz v0, :cond_0

    move v1, v2

    goto :goto_0

    :cond_3
    iget-object v3, p0, Lcom/lge/gles/GLESShader;->mVertexShaderSource:Ljava/lang/String;

    invoke-direct {p0, v5, v3}, Lcom/lge/gles/GLESShader;->setShaderFromString(ILjava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v3, p0, Lcom/lge/gles/GLESShader;->mFragmentShaderSource:Ljava/lang/String;

    invoke-direct {p0, v4, v3}, Lcom/lge/gles/GLESShader;->setShaderFromString(ILjava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    goto :goto_0
.end method

.method private getShaderCompileLog(II)Ljava/lang/String;
    .locals 4
    .param p1, "shader"    # I
    .param p2, "shaderType"    # I

    .prologue
    const/4 v0, 0x0

    .local v0, "log":Ljava/lang/String;
    const-string v1, "quilt GLESShader"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Could not compile shader "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ":"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0, p1}, Lcom/lge/gles/GLESShader;->nGetShaderCompileLog(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private getShaderFromReosurce(I)Ljava/lang/String;
    .locals 12
    .param p1, "resourceID"    # I

    .prologue
    const/4 v5, 0x0

    .local v5, "shader":Ljava/lang/String;
    iget-object v9, p0, Lcom/lge/gles/GLESShader;->mRes:Landroid/content/res/Resources;

    invoke-virtual {v9, p1}, Landroid/content/res/Resources;->openRawResource(I)Ljava/io/InputStream;

    move-result-object v4

    .local v4, "is":Ljava/io/InputStream;
    const/16 v9, 0x400

    :try_start_0
    new-array v7, v9, [B

    .local v7, "str":[B
    const/4 v8, 0x0

    .local v8, "strLength":I
    :goto_0
    array-length v9, v7

    sub-int v1, v9, v8

    .local v1, "bytesLeft":I
    if-nez v1, :cond_0

    array-length v9, v7

    mul-int/lit8 v9, v9, 0x2

    new-array v0, v9, [B

    .local v0, "buf2":[B
    const/4 v9, 0x0

    const/4 v10, 0x0

    array-length v11, v7

    invoke-static {v7, v9, v0, v10, v11}, Ljava/lang/System;->arraycopy([BI[BII)V

    move-object v7, v0

    array-length v9, v7

    sub-int v1, v9, v8

    .end local v0    # "buf2":[B
    :cond_0
    invoke-virtual {v4, v7, v8, v1}, Ljava/io/InputStream;->read([BII)I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v2

    .local v2, "bytesRead":I
    if-gtz v2, :cond_1

    :try_start_1
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    :try_start_2
    new-instance v6, Ljava/lang/String;

    const/4 v9, 0x0

    const-string v10, "UTF-8"

    invoke-direct {v6, v7, v9, v8, v10}, Ljava/lang/String;-><init>([BIILjava/lang/String;)V
    :try_end_2
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_2 .. :try_end_2} :catch_1

    .end local v5    # "shader":Ljava/lang/String;
    .local v6, "shader":Ljava/lang/String;
    move-object v5, v6

    .end local v6    # "shader":Ljava/lang/String;
    .restart local v5    # "shader":Ljava/lang/String;
    :goto_1
    return-object v5

    :cond_1
    add-int/2addr v8, v2

    goto :goto_0

    .end local v1    # "bytesLeft":I
    .end local v2    # "bytesRead":I
    .end local v7    # "str":[B
    .end local v8    # "strLength":I
    :catchall_0
    move-exception v9

    :try_start_3
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V

    throw v9
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0

    :catch_0
    move-exception v3

    .local v3, "e":Ljava/io/IOException;
    new-instance v9, Landroid/content/res/Resources$NotFoundException;

    invoke-direct {v9}, Landroid/content/res/Resources$NotFoundException;-><init>()V

    throw v9

    .end local v3    # "e":Ljava/io/IOException;
    .restart local v1    # "bytesLeft":I
    .restart local v2    # "bytesRead":I
    .restart local v7    # "str":[B
    .restart local v8    # "strLength":I
    :catch_1
    move-exception v3

    .local v3, "e":Ljava/io/UnsupportedEncodingException;
    const-string v9, "Renderscript shader creation"

    const-string v10, "Could not decode shader string"

    invoke-static {v9, v10}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method private linkProgram()Z
    .locals 5

    .prologue
    const/4 v4, 0x1

    const/4 v3, 0x0

    iget v1, p0, Lcom/lge/gles/GLESShader;->mProgram:I

    invoke-static {v1}, Landroid/opengl/GLES20;->glLinkProgram(I)V

    new-array v0, v4, [I

    .local v0, "linkStatus":[I
    iget v1, p0, Lcom/lge/gles/GLESShader;->mProgram:I

    const v2, 0x8b82

    invoke-static {v1, v2, v0, v3}, Landroid/opengl/GLES20;->glGetProgramiv(II[II)V

    aget v1, v0, v3

    if-eq v1, v4, :cond_0

    const-string v1, "quilt GLESShader"

    const-string v2, "Could not link program: "

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const-string v1, "quilt GLESShader"

    iget v2, p0, Lcom/lge/gles/GLESShader;->mProgram:I

    invoke-static {v2}, Landroid/opengl/GLES20;->glGetProgramInfoLog(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    iget v1, p0, Lcom/lge/gles/GLESShader;->mProgram:I

    invoke-static {v1}, Landroid/opengl/GLES20;->glDeleteProgram(I)V

    iput v3, p0, Lcom/lge/gles/GLESShader;->mProgram:I

    new-instance v1, Ljava/lang/RuntimeException;

    const-string v2, "glLinkProgram() Error"

    invoke-direct {v1, v2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v1

    :cond_0
    iget v1, p0, Lcom/lge/gles/GLESShader;->mProgram:I

    invoke-static {v1}, Landroid/opengl/GLES20;->glUseProgram(I)V

    return v4
.end method

.method private native nGetShaderCompileLog(I)Ljava/lang/String;
.end method

.method private native nLoadProgramBinary(IILjava/lang/String;)I
.end method

.method private native nRetrieveProgramBinary(ILjava/lang/String;)I
.end method

.method private setShaderFromResource(II)Z
    .locals 7
    .param p1, "shaderType"    # I
    .param p2, "resourceID"    # I

    .prologue
    const/4 v6, 0x1

    const/4 v5, 0x0

    invoke-static {p1}, Landroid/opengl/GLES20;->glCreateShader(I)I

    move-result v2

    .local v2, "shader":I
    if-eqz v2, :cond_0

    invoke-direct {p0, p2}, Lcom/lge/gles/GLESShader;->getShaderFromReosurce(I)Ljava/lang/String;

    move-result-object v3

    .local v3, "source":Ljava/lang/String;
    invoke-static {v2, v3}, Landroid/opengl/GLES20;->glShaderSource(ILjava/lang/String;)V

    invoke-static {v2}, Landroid/opengl/GLES20;->glCompileShader(I)V

    new-array v0, v6, [I

    .local v0, "compiled":[I
    const v4, 0x8b81

    invoke-static {v2, v4, v0, v5}, Landroid/opengl/GLES20;->glGetShaderiv(II[II)V

    aget v4, v0, v5

    if-nez v4, :cond_0

    const-string v4, "quilt GLESShader"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Could not compile shader "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ":"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0, v2, p1}, Lcom/lge/gles/GLESShader;->getShaderCompileLog(II)Ljava/lang/String;

    move-result-object v1

    .local v1, "log":Ljava/lang/String;
    const-string v4, "quilt GLESShader"

    invoke-static {v4, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {v2}, Landroid/opengl/GLES20;->glDeleteShader(I)V

    const/4 v2, 0x0

    new-instance v4, Ljava/lang/RuntimeException;

    const-string v5, "glShaderSource() Error"

    invoke-direct {v4, v5}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v4

    .end local v0    # "compiled":[I
    .end local v1    # "log":Ljava/lang/String;
    .end local v3    # "source":Ljava/lang/String;
    :cond_0
    iget v4, p0, Lcom/lge/gles/GLESShader;->mProgram:I

    invoke-static {v4, v2}, Landroid/opengl/GLES20;->glAttachShader(II)V

    return v6
.end method

.method private setShaderFromString(ILjava/lang/String;)Z
    .locals 5
    .param p1, "shaderType"    # I
    .param p2, "source"    # Ljava/lang/String;

    .prologue
    const/4 v4, 0x1

    const/4 v3, 0x0

    invoke-static {p1}, Landroid/opengl/GLES20;->glCreateShader(I)I

    move-result v1

    .local v1, "shader":I
    if-eqz v1, :cond_0

    invoke-static {v1, p2}, Landroid/opengl/GLES20;->glShaderSource(ILjava/lang/String;)V

    invoke-static {v1}, Landroid/opengl/GLES20;->glCompileShader(I)V

    new-array v0, v4, [I

    .local v0, "compiled":[I
    const v2, 0x8b81

    invoke-static {v1, v2, v0, v3}, Landroid/opengl/GLES20;->glGetShaderiv(II[II)V

    aget v2, v0, v3

    if-nez v2, :cond_0

    const-string v2, "quilt GLESShader"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Could not compile shader "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ":"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const-string v2, "quilt GLESShader"

    invoke-static {v1}, Landroid/opengl/GLES20;->glGetShaderInfoLog(I)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {v1}, Landroid/opengl/GLES20;->glDeleteShader(I)V

    const/4 v1, 0x0

    new-instance v2, Ljava/lang/RuntimeException;

    const-string v3, "glCompileShader() Error"

    invoke-direct {v2, v3}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v2

    .end local v0    # "compiled":[I
    :cond_0
    iget v2, p0, Lcom/lge/gles/GLESShader;->mProgram:I

    invoke-static {v2, v1}, Landroid/opengl/GLES20;->glAttachShader(II)V

    return v4
.end method


# virtual methods
.method public getAttribLocation(Ljava/lang/String;)I
    .locals 2
    .param p1, "attribName"    # Ljava/lang/String;

    .prologue
    const/4 v0, -0x1

    .local v0, "index":I
    iget v1, p0, Lcom/lge/gles/GLESShader;->mProgram:I

    invoke-static {v1, p1}, Landroid/opengl/GLES20;->glGetAttribLocation(ILjava/lang/String;)I

    move-result v0

    return v0
.end method

.method public getColorAttribIndex()I
    .locals 2

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESShader;->mColorIndex:I

    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    const-string v0, "quilt GLESShader"

    const-string v1, "getColorAttribIndex() mColorIndex is not set"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    iget v0, p0, Lcom/lge/gles/GLESShader;->mColorIndex:I

    return v0
.end method

.method public getNormalAttribIndex()I
    .locals 2

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESShader;->mNormalIndex:I

    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    const-string v0, "quilt GLESShader"

    const-string v1, "getNormalAttribIndex() mNormalIndex is not set"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    iget v0, p0, Lcom/lge/gles/GLESShader;->mNormalIndex:I

    return v0
.end method

.method public getProgram()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESShader;->mProgram:I

    return v0
.end method

.method public getTexCoordAttribIndex()I
    .locals 2

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESShader;->mTexCoordIndex:I

    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    const-string v0, "quilt GLESShader"

    const-string v1, "getTexCoordAttribIndex() mTexCoordIndex is not set"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    iget v0, p0, Lcom/lge/gles/GLESShader;->mTexCoordIndex:I

    return v0
.end method

.method public getUniformLocation(Ljava/lang/String;)I
    .locals 2
    .param p1, "uniforomName"    # Ljava/lang/String;

    .prologue
    const/4 v0, -0x1

    .local v0, "index":I
    iget v1, p0, Lcom/lge/gles/GLESShader;->mProgram:I

    invoke-static {v1, p1}, Landroid/opengl/GLES20;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v0

    return v0
.end method

.method public getVertexAttribIndex()I
    .locals 2

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESShader;->mVertexIndex:I

    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    const-string v0, "quilt GLESShader"

    const-string v1, "getVertexAttribIndex() mVertexIndex is not set"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    iget v0, p0, Lcom/lge/gles/GLESShader;->mVertexIndex:I

    return v0
.end method

.method public load()Z
    .locals 1

    .prologue
    invoke-direct {p0}, Lcom/lge/gles/GLESShader;->compileAndLink()Z

    move-result v0

    return v0
.end method

.method public load(Ljava/lang/String;)Z
    .locals 7
    .param p1, "fileName"    # Ljava/lang/String;

    .prologue
    const/4 v6, 0x1

    const/4 v2, 0x0

    .local v2, "res":Z
    const/4 v1, 0x1

    .local v1, "needToCompile":Z
    sget-boolean v3, Lcom/lge/gles/GLESConfig;->sUseBinary:Z

    if-nez v3, :cond_0

    invoke-direct {p0}, Lcom/lge/gles/GLESShader;->compileAndLink()Z

    move-result v3

    :goto_0
    return v3

    :cond_0
    if-eqz p1, :cond_1

    invoke-static {p1}, Lcom/lge/gles/GLESUtils;->checkFileExists(Ljava/lang/String;)Z

    move-result v3

    if-ne v3, v6, :cond_1

    const/4 v3, -0x1

    invoke-virtual {p0, p1, v3}, Lcom/lge/gles/GLESShader;->loadProgramBinary(Ljava/lang/String;I)I

    move-result v0

    .local v0, "errorNumber":I
    if-nez v0, :cond_3

    const-string v3, "quilt GLESShader"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Link Error file="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " Compile again"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .end local v0    # "errorNumber":I
    :cond_1
    :goto_1
    if-ne v1, v6, :cond_2

    invoke-direct {p0}, Lcom/lge/gles/GLESShader;->compileAndLink()Z

    move-result v2

    invoke-static {p1}, Lcom/lge/gles/GLESUtils;->deleteFile(Ljava/lang/String;)V

    invoke-virtual {p0, p1}, Lcom/lge/gles/GLESShader;->retrieveProgramBinary(Ljava/lang/String;)V

    :cond_2
    move v3, v2

    goto :goto_0

    .restart local v0    # "errorNumber":I
    :cond_3
    const/4 v1, 0x0

    goto :goto_1
.end method

.method public loadProgramBinary(Ljava/lang/String;I)I
    .locals 1
    .param p1, "fileName"    # Ljava/lang/String;
    .param p2, "binaryFormat"    # I

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESShader;->mProgram:I

    invoke-direct {p0, v0, p2, p1}, Lcom/lge/gles/GLESShader;->nLoadProgramBinary(IILjava/lang/String;)I

    move-result v0

    return v0
.end method

.method public retrieveProgramBinary(Ljava/lang/String;)V
    .locals 2
    .param p1, "fileName"    # Ljava/lang/String;

    .prologue
    iget v1, p0, Lcom/lge/gles/GLESShader;->mProgram:I

    invoke-direct {p0, v1, p1}, Lcom/lge/gles/GLESShader;->nRetrieveProgramBinary(ILjava/lang/String;)I

    move-result v0

    .local v0, "binaryFormat":I
    return-void
.end method

.method public setColorAttribIndex(Ljava/lang/String;)V
    .locals 1
    .param p1, "colorAttribName"    # Ljava/lang/String;

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESShader;->mProgram:I

    invoke-static {v0, p1}, Landroid/opengl/GLES20;->glGetAttribLocation(ILjava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/lge/gles/GLESShader;->mColorIndex:I

    return-void
.end method

.method public setNormalAttribIndex(Ljava/lang/String;)V
    .locals 1
    .param p1, "normalAttribName"    # Ljava/lang/String;

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESShader;->mProgram:I

    invoke-static {v0, p1}, Landroid/opengl/GLES20;->glGetAttribLocation(ILjava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/lge/gles/GLESShader;->mNormalIndex:I

    return-void
.end method

.method public setShadersFromResource(II)Z
    .locals 1
    .param p1, "vertexShaderID"    # I
    .param p2, "fragmentShaderID"    # I

    .prologue
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/lge/gles/GLESShader;->mUseResourceID:Z

    iput p1, p0, Lcom/lge/gles/GLESShader;->mVertexShaderID:I

    iput p2, p0, Lcom/lge/gles/GLESShader;->mFragmentShaderID:I

    return v0
.end method

.method public setShadersFromString(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1
    .param p1, "vertexShader"    # Ljava/lang/String;
    .param p2, "fragmentShader"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/lge/gles/GLESShader;->mUseResourceID:Z

    iput-object p1, p0, Lcom/lge/gles/GLESShader;->mVertexShaderSource:Ljava/lang/String;

    iput-object p2, p0, Lcom/lge/gles/GLESShader;->mFragmentShaderSource:Ljava/lang/String;

    const/4 v0, 0x1

    return v0
.end method

.method public setTexCoordAttribIndex(Ljava/lang/String;)V
    .locals 1
    .param p1, "texCoordAttribName"    # Ljava/lang/String;

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESShader;->mProgram:I

    invoke-static {v0, p1}, Landroid/opengl/GLES20;->glGetAttribLocation(ILjava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/lge/gles/GLESShader;->mTexCoordIndex:I

    return-void
.end method

.method public setVertexAttribIndex(Ljava/lang/String;)V
    .locals 1
    .param p1, "vertexAttribName"    # Ljava/lang/String;

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESShader;->mProgram:I

    invoke-static {v0, p1}, Landroid/opengl/GLES20;->glGetAttribLocation(ILjava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/lge/gles/GLESShader;->mVertexIndex:I

    return-void
.end method

.method public useProgram()V
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/gles/GLESShader;->mProgram:I

    invoke-static {v0}, Landroid/opengl/GLES20;->glUseProgram(I)V

    return-void
.end method
