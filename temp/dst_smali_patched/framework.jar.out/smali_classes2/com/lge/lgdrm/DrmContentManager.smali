.class public final Lcom/lge/lgdrm/DrmContentManager;
.super Ljava/lang/Object;
.source "DrmContentManager.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "DrmCntMngr"


# instance fields
.field private contentType:I

.field private filename:Ljava/lang/String;


# direct methods
.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .param p1, "filename"    # Ljava/lang/String;
    .param p2, "contentType"    # I

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/lge/lgdrm/DrmContentManager;->filename:Ljava/lang/String;

    iput p2, p0, Lcom/lge/lgdrm/DrmContentManager;->contentType:I

    return-void
.end method

.method private static native nativeAuthCaller()Z
.end method

.method private native nativeDeleteRights(Ljava/lang/String;)I
.end method

.method private static native nativeIsDRM(Ljava/lang/String;)I
.end method

.method private native nativePostprocessDistributedContent(Ljava/lang/String;)I
.end method

.method private native nativePreprocessDistributeContent(Ljava/lang/String;)I
.end method

.method static newInstance(Ljava/lang/String;)Lcom/lge/lgdrm/DrmContentManager;
    .locals 3
    .param p0, "filename"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/lge/lgdrm/DrmException;
        }
    .end annotation

    .prologue
    if-nez p0, :cond_0

    new-instance v1, Ljava/lang/NullPointerException;

    const-string v2, "Parameter filename is null"

    invoke-direct {v1, v2}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v1

    :cond_0
    invoke-static {p0}, Lcom/lge/lgdrm/DrmContentManager;->nativeIsDRM(Ljava/lang/String;)I

    move-result v0

    .local v0, "contentType":I
    if-nez v0, :cond_1

    new-instance v1, Lcom/lge/lgdrm/DrmException;

    const-string v2, "Not DRM protected content"

    invoke-direct {v1, v2}, Lcom/lge/lgdrm/DrmException;-><init>(Ljava/lang/String;)V

    throw v1

    :cond_1
    new-instance v1, Lcom/lge/lgdrm/DrmContentManager;

    invoke-direct {v1, p0, v0}, Lcom/lge/lgdrm/DrmContentManager;-><init>(Ljava/lang/String;I)V

    return-object v1
.end method


# virtual methods
.method public backupContent(Ljava/lang/String;)I
    .locals 2
    .param p1, "dstFilename"    # Ljava/lang/String;

    .prologue
    const-string v0, "DrmCntMngr"

    const-string v1, "backupContent() : Not supported"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, -0x1

    return v0
.end method

.method public copyContent(Ljava/lang/String;)I
    .locals 1
    .param p1, "dstFilename"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public deleteContent()I
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public deleteRights()I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/SecurityException;
        }
    .end annotation

    .prologue
    invoke-static {}, Lcom/lge/lgdrm/DrmContentManager;->nativeAuthCaller()Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/SecurityException;

    const-string v1, "Need proper permission to access drm"

    invoke-direct {v0, v1}, Ljava/lang/SecurityException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    iget v0, p0, Lcom/lge/lgdrm/DrmContentManager;->contentType:I

    const/16 v1, 0x51

    if-lt v0, v1, :cond_1

    iget v0, p0, Lcom/lge/lgdrm/DrmContentManager;->contentType:I

    const/16 v1, 0x3000

    if-gt v0, v1, :cond_1

    iget-object v0, p0, Lcom/lge/lgdrm/DrmContentManager;->filename:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/lge/lgdrm/DrmContentManager;->nativeDeleteRights(Ljava/lang/String;)I

    move-result v0

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public moveContent(Ljava/lang/String;)I
    .locals 1
    .param p1, "dstFilename"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public postprocessDistributedContent()I
    .locals 2

    .prologue
    iget v0, p0, Lcom/lge/lgdrm/DrmContentManager;->contentType:I

    const/16 v1, 0x3000

    if-eq v0, v1, :cond_0

    const/4 v0, 0x0

    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Lcom/lge/lgdrm/DrmContentManager;->filename:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/lge/lgdrm/DrmContentManager;->nativePostprocessDistributedContent(Ljava/lang/String;)I

    move-result v0

    goto :goto_0
.end method

.method public preprocessDistributeContent()I
    .locals 2

    .prologue
    iget v0, p0, Lcom/lge/lgdrm/DrmContentManager;->contentType:I

    const/16 v1, 0x3000

    if-eq v0, v1, :cond_0

    iget v0, p0, Lcom/lge/lgdrm/DrmContentManager;->contentType:I

    const/high16 v1, 0x100000

    and-int/2addr v0, v1

    if-nez v0, :cond_0

    iget v0, p0, Lcom/lge/lgdrm/DrmContentManager;->contentType:I

    const/high16 v1, 0x800000

    if-ne v0, v1, :cond_1

    :cond_0
    iget-object v0, p0, Lcom/lge/lgdrm/DrmContentManager;->filename:Ljava/lang/String;

    invoke-direct {p0, v0}, Lcom/lge/lgdrm/DrmContentManager;->nativePreprocessDistributeContent(Ljava/lang/String;)I

    move-result v0

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public renameContent(Ljava/lang/String;)I
    .locals 1
    .param p1, "dstFilename"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method public restoreContent(Ljava/lang/String;)I
    .locals 2
    .param p1, "dstFilename"    # Ljava/lang/String;

    .prologue
    const-string v0, "DrmCntMngr"

    const-string v1, "restoreContent() : Not supported"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, -0x1

    return v0
.end method
