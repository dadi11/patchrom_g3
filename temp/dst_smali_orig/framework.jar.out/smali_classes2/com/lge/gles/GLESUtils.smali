.class public Lcom/lge/gles/GLESUtils;
.super Ljava/lang/Object;
.source "GLESUtils.java"


# static fields
.field private static final DEBUG:Z = false

.field private static final NUM_OF_FRAME:I = 0x10

.field private static final TAG:Ljava/lang/String; = "quilt GLESUtils"

.field private static sDpiConvertUnit:F

.field private static sFrameCount:I

.field private static sHeightPixels:F

.field private static sStartTick:J

.field private static sTotalTime:J

.field private static sWidthPixels:F


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    const/4 v0, 0x0

    sput v0, Lcom/lge/gles/GLESUtils;->sFrameCount:I

    const-wide/16 v0, -0x1

    sput-wide v0, Lcom/lge/gles/GLESUtils;->sStartTick:J

    const-wide/16 v0, 0x0

    sput-wide v0, Lcom/lge/gles/GLESUtils;->sTotalTime:J

    sput v2, Lcom/lge/gles/GLESUtils;->sDpiConvertUnit:F

    sput v2, Lcom/lge/gles/GLESUtils;->sWidthPixels:F

    sput v2, Lcom/lge/gles/GLESUtils;->sHeightPixels:F

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static checkAndReplaceBitmap(Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;
    .locals 3
    .param p0, "bitmap"    # Landroid/graphics/Bitmap;

    .prologue
    const/16 v2, 0x10

    if-nez p0, :cond_0

    const-string v0, "quilt GLESUtils"

    const-string v1, "checkAndReplaceBitmap() Bitmap is null. Replace with transparent bitmap"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v0, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    const/4 v1, 0x0

    invoke-static {v2, v2, v0, v1}, Lcom/lge/gles/GLESUtils;->makeBitmap(IILandroid/graphics/Bitmap$Config;I)Landroid/graphics/Bitmap;

    move-result-object p0

    :cond_0
    return-object p0
.end method

.method public static checkFPS()V
    .locals 10

    .prologue
    const-wide/16 v8, 0x0

    const/4 v6, 0x0

    const/4 v2, 0x0

    .local v2, "fps":F
    const-wide/16 v0, 0x0

    .local v0, "currentTick":J
    sget-wide v4, Lcom/lge/gles/GLESUtils;->sStartTick:J

    cmp-long v3, v4, v8

    if-gez v3, :cond_1

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v4

    sput-wide v4, Lcom/lge/gles/GLESUtils;->sStartTick:J

    sput v6, Lcom/lge/gles/GLESUtils;->sFrameCount:I

    :cond_0
    :goto_0
    return-void

    :cond_1
    sget v3, Lcom/lge/gles/GLESUtils;->sFrameCount:I

    add-int/lit8 v3, v3, 0x1

    sput v3, Lcom/lge/gles/GLESUtils;->sFrameCount:I

    sget v3, Lcom/lge/gles/GLESUtils;->sFrameCount:I

    const/16 v4, 0x10

    if-lt v3, v4, :cond_0

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v0

    sget-wide v4, Lcom/lge/gles/GLESUtils;->sStartTick:J

    sub-long v4, v0, v4

    sput-wide v4, Lcom/lge/gles/GLESUtils;->sTotalTime:J

    sget v3, Lcom/lge/gles/GLESUtils;->sFrameCount:I

    int-to-float v3, v3

    const v4, 0x4e6e6b28    # 1.0E9f

    mul-float/2addr v3, v4

    sget-wide v4, Lcom/lge/gles/GLESUtils;->sTotalTime:J

    long-to-float v4, v4

    div-float v2, v3, v4

    const-string v3, "quilt GLESUtils"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "checkFPS() fps="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sput v6, Lcom/lge/gles/GLESUtils;->sFrameCount:I

    sput-wide v0, Lcom/lge/gles/GLESUtils;->sStartTick:J

    sput-wide v8, Lcom/lge/gles/GLESUtils;->sTotalTime:J

    goto :goto_0
.end method

.method public static checkFileExists(Ljava/lang/String;)Z
    .locals 4
    .param p0, "path"    # Ljava/lang/String;

    .prologue
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .local v0, "file":Ljava/io/File;
    if-nez v0, :cond_0

    const-string v2, "quilt GLESUtils"

    const-string v3, "checkFileExists() file instance is null"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    :goto_0
    return v1

    :cond_0
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    .local v1, "fileExist":Z
    goto :goto_0
.end method

.method public static clamp(FFF)F
    .locals 1
    .param p0, "min"    # F
    .param p1, "max"    # F
    .param p2, "current"    # F

    .prologue
    cmpg-float v0, p2, p0

    if-gez v0, :cond_0

    move p2, p0

    :cond_0
    cmpl-float v0, p2, p1

    if-lez v0, :cond_1

    move p2, p1

    :cond_1
    return p2
.end method

.method public static convertColorHexToFloat(Ljava/lang/String;)[F
    .locals 9
    .param p0, "hex"    # Ljava/lang/String;

    .prologue
    const/high16 v8, 0x437f0000    # 255.0f

    invoke-static {p0}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v2

    .local v2, "color":I
    invoke-static {v2}, Landroid/graphics/Color;->red(I)I

    move-result v5

    .local v5, "red":I
    invoke-static {v2}, Landroid/graphics/Color;->green(I)I

    move-result v4

    .local v4, "green":I
    invoke-static {v2}, Landroid/graphics/Color;->blue(I)I

    move-result v1

    .local v1, "blue":I
    invoke-static {v2}, Landroid/graphics/Color;->alpha(I)I

    move-result v0

    .local v0, "alpha":I
    const/4 v6, 0x4

    new-array v3, v6, [F

    const/4 v6, 0x0

    int-to-float v7, v5

    div-float/2addr v7, v8

    aput v7, v3, v6

    const/4 v6, 0x1

    int-to-float v7, v4

    div-float/2addr v7, v8

    aput v7, v3, v6

    const/4 v6, 0x2

    int-to-float v7, v1

    div-float/2addr v7, v8

    aput v7, v3, v6

    const/4 v6, 0x3

    int-to-float v7, v0

    div-float/2addr v7, v8

    aput v7, v3, v6

    .local v3, "colorf":[F
    return-object v3
.end method

.method public static convertScreenToSpace(F)F
    .locals 1
    .param p0, "value"    # F

    .prologue
    const/high16 v0, 0x40800000    # 4.0f

    div-float v0, p0, v0

    return v0
.end method

.method public static deleteFile(Ljava/lang/String;)V
    .locals 4
    .param p0, "fileName"    # Ljava/lang/String;

    .prologue
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, p0}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    .local v1, "str":Ljava/lang/String;
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .local v0, "file":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v2

    const/4 v3, 0x1

    if-ne v2, v3, :cond_0

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    :cond_0
    return-void
.end method

.method public static getDataPathName(Landroid/content/Context;)Ljava/lang/StringBuilder;
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-static {}, Landroid/os/Environment;->getDataDirectory()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .local v0, "path":Ljava/lang/StringBuilder;
    sget-char v1, Ljava/io/File;->separatorChar:C

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    const-string v1, "data"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-char v1, Ljava/io/File;->separatorChar:C

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-char v1, Ljava/io/File;->separatorChar:C

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    return-object v0
.end method

.method public static getHeightPixels(Landroid/content/Context;)F
    .locals 3
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    sget v1, Lcom/lge/gles/GLESUtils;->sHeightPixels:F

    const/4 v2, 0x0

    invoke-static {v1, v2}, Ljava/lang/Float;->compare(FF)I

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .local v0, "metrics":Landroid/util/DisplayMetrics;
    iget v1, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    int-to-float v1, v1

    sput v1, Lcom/lge/gles/GLESUtils;->sWidthPixels:F

    iget v1, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    int-to-float v1, v1

    sput v1, Lcom/lge/gles/GLESUtils;->sHeightPixels:F

    .end local v0    # "metrics":Landroid/util/DisplayMetrics;
    :cond_0
    sget v1, Lcom/lge/gles/GLESUtils;->sHeightPixels:F

    return v1
.end method

.method public static getNormal(FFF)F
    .locals 2
    .param p0, "min"    # F
    .param p1, "max"    # F
    .param p2, "current"    # F

    .prologue
    cmpg-float v0, p2, p0

    if-gez v0, :cond_0

    move p2, p0

    :cond_0
    cmpl-float v0, p2, p1

    if-lez v0, :cond_1

    move p2, p1

    :cond_1
    sub-float v0, p2, p0

    sub-float v1, p1, p0

    div-float/2addr v0, v1

    return v0
.end method

.method public static getPixelFromDpi(Landroid/content/Context;F)F
    .locals 3
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "dpiSize"    # F

    .prologue
    sget v1, Lcom/lge/gles/GLESUtils;->sDpiConvertUnit:F

    const/4 v2, 0x0

    invoke-static {v1, v2}, Ljava/lang/Float;->compare(FF)I

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .local v0, "metrics":Landroid/util/DisplayMetrics;
    iget v1, v0, Landroid/util/DisplayMetrics;->densityDpi:I

    int-to-float v1, v1

    const/high16 v2, 0x43200000    # 160.0f

    div-float/2addr v1, v2

    sput v1, Lcom/lge/gles/GLESUtils;->sDpiConvertUnit:F

    .end local v0    # "metrics":Landroid/util/DisplayMetrics;
    :cond_0
    sget v1, Lcom/lge/gles/GLESUtils;->sDpiConvertUnit:F

    mul-float/2addr v1, p1

    return v1
.end method

.method public static getPixelsFromPercentage(FF)F
    .locals 1
    .param p0, "percentage"    # F
    .param p1, "pixelSize"    # F

    .prologue
    const v0, 0x3c23d70a    # 0.01f

    mul-float/2addr v0, p0

    mul-float/2addr v0, p1

    return v0
.end method

.method public static getWidthPixels(Landroid/content/Context;)F
    .locals 3
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    sget v1, Lcom/lge/gles/GLESUtils;->sWidthPixels:F

    const/4 v2, 0x0

    invoke-static {v1, v2}, Ljava/lang/Float;->compare(FF)I

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .local v0, "metrics":Landroid/util/DisplayMetrics;
    iget v1, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    int-to-float v1, v1

    sput v1, Lcom/lge/gles/GLESUtils;->sWidthPixels:F

    iget v1, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    int-to-float v1, v1

    sput v1, Lcom/lge/gles/GLESUtils;->sHeightPixels:F

    .end local v0    # "metrics":Landroid/util/DisplayMetrics;
    :cond_0
    sget v1, Lcom/lge/gles/GLESUtils;->sWidthPixels:F

    return v1
.end method

.method public static makeBitmap(IILandroid/graphics/Bitmap$Config;I)Landroid/graphics/Bitmap;
    .locals 4
    .param p0, "width"    # I
    .param p1, "height"    # I
    .param p2, "config"    # Landroid/graphics/Bitmap$Config;
    .param p3, "color"    # I

    .prologue
    const/4 v3, 0x0

    invoke-static {p0, p1, p2}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v0

    .local v0, "bitmap":Landroid/graphics/Bitmap;
    new-instance v1, Landroid/graphics/Canvas;

    invoke-direct {v1, v0}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    .local v1, "canvas":Landroid/graphics/Canvas;
    invoke-virtual {v1, p3}, Landroid/graphics/Canvas;->drawColor(I)V

    const/4 v2, 0x0

    invoke-virtual {v1, v0, v3, v3, v2}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;FFLandroid/graphics/Paint;)V

    return-object v0
.end method

.method public static makeFloatBuffer([F)Ljava/nio/FloatBuffer;
    .locals 3
    .param p0, "array"    # [F

    .prologue
    array-length v1, p0

    mul-int/lit8 v1, v1, 0x4

    invoke-static {v1}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->asFloatBuffer()Ljava/nio/FloatBuffer;

    move-result-object v0

    .local v0, "buffer":Ljava/nio/FloatBuffer;
    invoke-virtual {v0, p0}, Ljava/nio/FloatBuffer;->put([F)Ljava/nio/FloatBuffer;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/nio/FloatBuffer;->position(I)Ljava/nio/Buffer;

    return-object v0
.end method

.method public static makeLockScreenStringPath(Landroid/content/Context;Ljava/lang/StringBuilder;Ljava/lang/String;)Ljava/lang/String;
    .locals 7
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "path"    # Ljava/lang/StringBuilder;
    .param p2, "fileName"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x0

    .local v3, "info":Landroid/content/pm/PackageInfo;
    const/4 v1, 0x0

    .local v1, "fileExtention":Ljava/lang/String;
    const/4 v2, 0x0

    .local v2, "filePath":Ljava/lang/String;
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v4

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x0

    invoke-virtual {v4, v5, v6}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "_"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, v3, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ".dat"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    :goto_0
    return-object v2

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v4, "quilt GLESUtils"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "makeLockScreenStringPath() Exception e="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static makeShortBuffer([S)Ljava/nio/ShortBuffer;
    .locals 3
    .param p0, "array"    # [S

    .prologue
    array-length v1, p0

    mul-int/lit8 v1, v1, 0x2

    invoke-static {v1}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-static {}, Ljava/nio/ByteOrder;->nativeOrder()Ljava/nio/ByteOrder;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object v1

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->asShortBuffer()Ljava/nio/ShortBuffer;

    move-result-object v0

    .local v0, "buffer":Ljava/nio/ShortBuffer;
    invoke-virtual {v0, p0}, Ljava/nio/ShortBuffer;->put([S)Ljava/nio/ShortBuffer;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/nio/ShortBuffer;->position(I)Ljava/nio/Buffer;

    return-object v0
.end method

.method public static nextPowerOf2(I)I
    .locals 1
    .param p0, "n"    # I

    .prologue
    add-int/lit8 p0, p0, -0x1

    ushr-int/lit8 v0, p0, 0x10

    or-int/2addr p0, v0

    ushr-int/lit8 v0, p0, 0x8

    or-int/2addr p0, v0

    ushr-int/lit8 v0, p0, 0x4

    or-int/2addr p0, v0

    ushr-int/lit8 v0, p0, 0x2

    or-int/2addr p0, v0

    ushr-int/lit8 v0, p0, 0x1

    or-int/2addr p0, v0

    add-int/lit8 v0, p0, 0x1

    return v0
.end method
