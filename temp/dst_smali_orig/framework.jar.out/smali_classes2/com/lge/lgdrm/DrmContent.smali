.class public final Lcom/lge/lgdrm/DrmContent;
.super Ljava/lang/Object;
.source "DrmContent.java"


# static fields
.field private static FLIconStatus:I


# instance fields
.field protected agentType:I

.field protected autoRightState:Z

.field private contentInfoMap:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private contentSize:J

.field protected contentType:I

.field protected filename:Ljava/lang/String;

.field protected index:I

.field private mediaType:I

.field private metadata:Lcom/lge/lgdrm/DrmContentMetaData;

.field protected permisson:I

.field protected previewContent:I

.field protected rightState:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, -0x1

    sput v0, Lcom/lge/lgdrm/DrmContent;->FLIconStatus:I

    return-void
.end method

.method private constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, -0x4

    iput v0, p0, Lcom/lge/lgdrm/DrmContent;->rightState:I

    iput-boolean v1, p0, Lcom/lge/lgdrm/DrmContent;->autoRightState:Z

    iput v1, p0, Lcom/lge/lgdrm/DrmContent;->permisson:I

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/lge/lgdrm/DrmContent;->contentInfoMap:Ljava/util/HashMap;

    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/lge/lgdrm/DrmContent;->contentSize:J

    return-void
.end method

.method protected constructor <init>(Ljava/lang/String;II)V
    .locals 2
    .param p1, "filename"    # Ljava/lang/String;
    .param p2, "index"    # I
    .param p3, "contentType"    # I

    .prologue
    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, -0x4

    iput v0, p0, Lcom/lge/lgdrm/DrmContent;->rightState:I

    iput-boolean v1, p0, Lcom/lge/lgdrm/DrmContent;->autoRightState:Z

    iput v1, p0, Lcom/lge/lgdrm/DrmContent;->permisson:I

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/lge/lgdrm/DrmContent;->contentInfoMap:Ljava/util/HashMap;

    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/lge/lgdrm/DrmContent;->contentSize:J

    iput-object p1, p0, Lcom/lge/lgdrm/DrmContent;->filename:Ljava/lang/String;

    iput p2, p0, Lcom/lge/lgdrm/DrmContent;->index:I

    iput p3, p0, Lcom/lge/lgdrm/DrmContent;->contentType:I

    if-nez p3, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    const/16 v0, 0x1800

    if-ne p3, v0, :cond_2

    const/16 v0, 0x9

    iput v0, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    goto :goto_0

    :cond_2
    const/16 v0, 0x501

    if-ne p3, v0, :cond_3

    const/16 v0, 0xa

    iput v0, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    goto :goto_0

    :cond_3
    const/16 v0, 0x10

    if-le p3, v0, :cond_4

    const/16 v0, 0x1000

    if-ge p3, v0, :cond_4

    const/4 v0, 0x1

    iput v0, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    goto :goto_0

    :cond_4
    const/16 v0, 0x3000

    if-ne p3, v0, :cond_5

    const/4 v0, 0x2

    iput v0, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    goto :goto_0

    :cond_5
    const/high16 v0, 0x10000

    and-int/2addr v0, p3

    if-eqz v0, :cond_6

    const/4 v0, 0x5

    iput v0, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    goto :goto_0

    :cond_6
    const/high16 v0, 0x80000

    if-ne p3, v0, :cond_7

    const/4 v0, 0x6

    iput v0, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    goto :goto_0

    :cond_7
    const/high16 v0, 0x100000

    and-int/2addr v0, p3

    if-nez v0, :cond_8

    const/high16 v0, 0x800000

    if-ne p3, v0, :cond_0

    :cond_8
    const/4 v0, 0x7

    iput v0, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    goto :goto_0
.end method

.method private constructor <init>(Ljava/lang/String;IILjava/lang/String;Ljava/lang/String;I)V
    .locals 4
    .param p1, "filename"    # Ljava/lang/String;
    .param p2, "index"    # I
    .param p3, "contentType"    # I
    .param p4, "mimeType"    # Ljava/lang/String;
    .param p5, "extension"    # Ljava/lang/String;
    .param p6, "mediaType"    # I

    .prologue
    const/4 v3, 0x2

    const/4 v2, 0x1

    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, -0x4

    iput v0, p0, Lcom/lge/lgdrm/DrmContent;->rightState:I

    iput-boolean v1, p0, Lcom/lge/lgdrm/DrmContent;->autoRightState:Z

    iput v1, p0, Lcom/lge/lgdrm/DrmContent;->permisson:I

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/lge/lgdrm/DrmContent;->contentInfoMap:Ljava/util/HashMap;

    const-wide/16 v0, -0x1

    iput-wide v0, p0, Lcom/lge/lgdrm/DrmContent;->contentSize:J

    iput-object p1, p0, Lcom/lge/lgdrm/DrmContent;->filename:Ljava/lang/String;

    iput p2, p0, Lcom/lge/lgdrm/DrmContent;->index:I

    iput p3, p0, Lcom/lge/lgdrm/DrmContent;->contentType:I

    iget-object v0, p0, Lcom/lge/lgdrm/DrmContent;->contentInfoMap:Ljava/util/HashMap;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1, p4}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/lge/lgdrm/DrmContent;->contentInfoMap:Ljava/util/HashMap;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1, p5}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iput p6, p0, Lcom/lge/lgdrm/DrmContent;->mediaType:I

    const/16 v0, 0x1800

    if-ne p3, v0, :cond_1

    const/16 v0, 0x9

    iput v0, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    :cond_0
    :goto_0
    return-void

    :cond_1
    const/16 v0, 0x501

    if-ne p3, v0, :cond_2

    const/16 v0, 0xa

    iput v0, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    goto :goto_0

    :cond_2
    const/16 v0, 0x10

    if-le p3, v0, :cond_3

    const/16 v0, 0x1000

    if-ge p3, v0, :cond_3

    iput v2, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    goto :goto_0

    :cond_3
    const/16 v0, 0x3000

    if-ne p3, v0, :cond_4

    iput v3, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    goto :goto_0

    :cond_4
    const/high16 v0, 0x10000

    and-int/2addr v0, p3

    if-eqz v0, :cond_5

    const/4 v0, 0x5

    iput v0, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    goto :goto_0

    :cond_5
    const/high16 v0, 0x80000

    if-ne p3, v0, :cond_6

    const/4 v0, 0x6

    iput v0, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    goto :goto_0

    :cond_6
    const/high16 v0, 0x100000

    and-int/2addr v0, p3

    if-nez v0, :cond_7

    const/high16 v0, 0x800000

    if-ne p3, v0, :cond_0

    :cond_7
    const/4 v0, 0x7

    iput v0, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    goto :goto_0
.end method

.method public static getContentInfo(Ljava/lang/String;I)Ljava/lang/String;
    .locals 2
    .param p0, "filename"    # Ljava/lang/String;
    .param p1, "type"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NullPointerException;,
            Ljava/lang/IllegalArgumentException;,
            Lcom/lge/lgdrm/DrmException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    sget-boolean v0, Lcom/lge/lgdrm/Drm;->LGDRM:Z

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    if-nez p0, :cond_1

    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "Parameter filename is null"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_1
    const/4 v0, 0x1

    if-lt p1, v0, :cond_2

    const/4 v0, 0x6

    if-le p1, v0, :cond_3

    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Invalid type"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_3
    invoke-static {p0}, Lcom/lge/lgdrm/DrmContent;->nativeIsDRM(Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_4

    new-instance v0, Lcom/lge/lgdrm/DrmException;

    const-string v1, "Not DRM protected content"

    invoke-direct {v0, v1}, Lcom/lge/lgdrm/DrmException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_4
    invoke-static {p1, p0, v1, v1}, Lcom/lge/lgdrm/DrmContent;->nativeGetContentInfo(ILjava/lang/String;II)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public static getContentType(Ljava/lang/String;)I
    .locals 2
    .param p0, "filename"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NullPointerException;,
            Lcom/lge/lgdrm/DrmException;
        }
    .end annotation

    .prologue
    const/4 v0, 0x0

    sget-boolean v1, Lcom/lge/lgdrm/Drm;->LGDRM:Z

    if-nez v1, :cond_0

    :goto_0
    return v0

    :cond_0
    if-nez p0, :cond_1

    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "Parameter filename is null"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_1
    invoke-static {p0}, Lcom/lge/lgdrm/DrmContent;->nativeIsDRM(Ljava/lang/String;)I

    move-result v1

    if-nez v1, :cond_2

    new-instance v0, Lcom/lge/lgdrm/DrmException;

    const-string v1, "Not DRM protected content"

    invoke-direct {v0, v1}, Lcom/lge/lgdrm/DrmException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_2
    invoke-static {p0, v0, v0}, Lcom/lge/lgdrm/DrmContent;->nativeGetContentType(Ljava/lang/String;II)I

    move-result v0

    goto :goto_0
.end method

.method public static isForwardlockIconVisible()Z
    .locals 4

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    sget-boolean v2, Lcom/lge/lgdrm/Drm;->LGDRM:Z

    if-nez v2, :cond_0

    :goto_0
    return v1

    :cond_0
    sget v2, Lcom/lge/lgdrm/DrmContent;->FLIconStatus:I

    const/4 v3, -0x1

    if-ne v2, v3, :cond_1

    invoke-static {}, Lcom/lge/lgdrm/DrmContent;->nativeIsForwardlockIconVisible()Z

    move-result v2

    if-eqz v2, :cond_2

    sput v0, Lcom/lge/lgdrm/DrmContent;->FLIconStatus:I

    :cond_1
    :goto_1
    sget v2, Lcom/lge/lgdrm/DrmContent;->FLIconStatus:I

    if-ne v2, v0, :cond_3

    :goto_2
    move v1, v0

    goto :goto_0

    :cond_2
    sput v1, Lcom/lge/lgdrm/DrmContent;->FLIconStatus:I

    goto :goto_1

    :cond_3
    move v0, v1

    goto :goto_2
.end method

.method private native nativeCheckPreviewContent(Ljava/lang/String;I)Z
.end method

.method private static native nativeGetContentInfo(ILjava/lang/String;II)Ljava/lang/String;
.end method

.method private native nativeGetContentSize(Ljava/lang/String;II)J
.end method

.method private static native nativeGetContentType(Ljava/lang/String;II)I
.end method

.method private native nativeGetMetaData(Lcom/lge/lgdrm/DrmContentMetaData;Ljava/lang/String;II)I
.end method

.method private static native nativeIsDRM(Ljava/lang/String;)I
.end method

.method private static native nativeIsForwardlockIconVisible()Z
.end method

.method private setBasicInfo(IILjava/lang/String;Ljava/lang/String;I)V
    .locals 4
    .param p1, "index"    # I
    .param p2, "contentType"    # I
    .param p3, "mimeType"    # Ljava/lang/String;
    .param p4, "extension"    # Ljava/lang/String;
    .param p5, "mediaType"    # I

    .prologue
    const/4 v3, 0x2

    const/4 v2, 0x1

    iput p1, p0, Lcom/lge/lgdrm/DrmContent;->index:I

    iput p2, p0, Lcom/lge/lgdrm/DrmContent;->contentType:I

    iget-object v0, p0, Lcom/lge/lgdrm/DrmContent;->contentInfoMap:Ljava/util/HashMap;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1, p3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/lge/lgdrm/DrmContent;->contentInfoMap:Ljava/util/HashMap;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1, p4}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iput p5, p0, Lcom/lge/lgdrm/DrmContent;->mediaType:I

    const/16 v0, 0x1800

    if-ne p2, v0, :cond_1

    const/16 v0, 0x9

    iput v0, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    :cond_0
    :goto_0
    return-void

    :cond_1
    const/16 v0, 0x501

    if-ne p2, v0, :cond_2

    const/16 v0, 0xa

    iput v0, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    goto :goto_0

    :cond_2
    const/16 v0, 0x10

    if-le p2, v0, :cond_3

    const/16 v0, 0x1000

    if-ge p2, v0, :cond_3

    iput v2, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    goto :goto_0

    :cond_3
    const/16 v0, 0x3000

    if-ne p2, v0, :cond_4

    iput v3, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    goto :goto_0

    :cond_4
    const/high16 v0, 0x10000

    and-int/2addr v0, p2

    if-eqz v0, :cond_5

    const/4 v0, 0x5

    iput v0, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    goto :goto_0

    :cond_5
    const/high16 v0, 0x80000

    if-ne p2, v0, :cond_6

    const/4 v0, 0x6

    iput v0, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    goto :goto_0

    :cond_6
    const/high16 v0, 0x100000

    and-int/2addr v0, p2

    if-nez v0, :cond_7

    const/high16 v0, 0x800000

    if-ne p2, v0, :cond_0

    :cond_7
    const/4 v0, 0x7

    iput v0, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    goto :goto_0
.end method

.method private setBasicInfo(Ljava/lang/String;Ljava/lang/String;I)V
    .locals 2
    .param p1, "mimeType"    # Ljava/lang/String;
    .param p2, "extension"    # Ljava/lang/String;
    .param p3, "mediaType"    # I

    .prologue
    iget-object v0, p0, Lcom/lge/lgdrm/DrmContent;->contentInfoMap:Ljava/util/HashMap;

    const/4 v1, 0x1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/lge/lgdrm/DrmContent;->contentInfoMap:Ljava/util/HashMap;

    const/4 v1, 0x2

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iput p3, p0, Lcom/lge/lgdrm/DrmContent;->mediaType:I

    return-void
.end method


# virtual methods
.method public checkPreviewContent()Z
    .locals 2

    .prologue
    iget v0, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/lge/lgdrm/DrmContent;->filename:Ljava/lang/String;

    iget v1, p0, Lcom/lge/lgdrm/DrmContent;->index:I

    invoke-direct {p0, v0, v1}, Lcom/lge/lgdrm/DrmContent;->nativeCheckPreviewContent(Ljava/lang/String;I)Z

    move-result v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getContentInfo(I)Ljava/lang/String;
    .locals 7
    .param p1, "type"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .prologue
    const/16 v6, 0x9

    const/4 v5, 0x6

    const/4 v1, 0x0

    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v0, 0x0

    .local v0, "value":Ljava/lang/String;
    if-lt p1, v3, :cond_0

    if-le p1, v5, :cond_1

    :cond_0
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "Invalid type"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    :cond_1
    if-eq p1, v3, :cond_2

    if-ne p1, v4, :cond_4

    :cond_2
    iget-object v1, p0, Lcom/lge/lgdrm/DrmContent;->contentInfoMap:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    :cond_3
    :goto_0
    return-object v1

    :cond_4
    iget v2, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    if-eq v2, v3, :cond_5

    iget v2, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    if-eq v2, v4, :cond_5

    iget v2, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    if-eq v2, v6, :cond_5

    iget v2, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    const/16 v3, 0xa

    if-ne v2, v3, :cond_3

    :cond_5
    const/4 v2, 0x3

    if-eq p1, v2, :cond_6

    const/4 v2, 0x4

    if-ne p1, v2, :cond_8

    :cond_6
    iget-object v1, p0, Lcom/lge/lgdrm/DrmContent;->contentInfoMap:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "value":Ljava/lang/String;
    check-cast v0, Ljava/lang/String;

    .restart local v0    # "value":Ljava/lang/String;
    if-eqz v0, :cond_7

    move-object v1, v0

    goto :goto_0

    :cond_7
    iget-object v1, p0, Lcom/lge/lgdrm/DrmContent;->filename:Ljava/lang/String;

    iget v2, p0, Lcom/lge/lgdrm/DrmContent;->index:I

    iget v3, p0, Lcom/lge/lgdrm/DrmContent;->previewContent:I

    invoke-static {p1, v1, v2, v3}, Lcom/lge/lgdrm/DrmContent;->nativeGetContentInfo(ILjava/lang/String;II)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/lgdrm/DrmContent;->contentInfoMap:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-object v1, v0

    goto :goto_0

    :cond_8
    iget v2, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    if-eq v2, v4, :cond_9

    iget v2, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    if-ne v2, v6, :cond_3

    :cond_9
    const/4 v2, 0x5

    if-eq p1, v2, :cond_a

    if-ne p1, v5, :cond_3

    :cond_a
    iget-object v1, p0, Lcom/lge/lgdrm/DrmContent;->contentInfoMap:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .end local v0    # "value":Ljava/lang/String;
    check-cast v0, Ljava/lang/String;

    .restart local v0    # "value":Ljava/lang/String;
    if-eqz v0, :cond_b

    move-object v1, v0

    goto :goto_0

    :cond_b
    iget-object v1, p0, Lcom/lge/lgdrm/DrmContent;->filename:Ljava/lang/String;

    iget v2, p0, Lcom/lge/lgdrm/DrmContent;->index:I

    iget v3, p0, Lcom/lge/lgdrm/DrmContent;->previewContent:I

    invoke-static {p1, v1, v2, v3}, Lcom/lge/lgdrm/DrmContent;->nativeGetContentInfo(ILjava/lang/String;II)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/lgdrm/DrmContent;->contentInfoMap:Ljava/util/HashMap;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-object v1, v0

    goto :goto_0
.end method

.method public getContentSize()J
    .locals 4

    .prologue
    iget-wide v0, p0, Lcom/lge/lgdrm/DrmContent;->contentSize:J

    const-wide/16 v2, -0x1

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    iget-wide v0, p0, Lcom/lge/lgdrm/DrmContent;->contentSize:J

    :goto_0
    return-wide v0

    :cond_0
    iget-object v0, p0, Lcom/lge/lgdrm/DrmContent;->filename:Ljava/lang/String;

    iget v1, p0, Lcom/lge/lgdrm/DrmContent;->index:I

    iget v2, p0, Lcom/lge/lgdrm/DrmContent;->previewContent:I

    invoke-direct {p0, v0, v1, v2}, Lcom/lge/lgdrm/DrmContent;->nativeGetContentSize(Ljava/lang/String;II)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/lge/lgdrm/DrmContent;->contentSize:J

    iget-wide v0, p0, Lcom/lge/lgdrm/DrmContent;->contentSize:J

    goto :goto_0
.end method

.method public getContentType()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/lgdrm/DrmContent;->mediaType:I

    return v0
.end method

.method public getDrmContentType()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/lgdrm/DrmContent;->contentType:I

    return v0
.end method

.method public getMetaData()Lcom/lge/lgdrm/DrmContentMetaData;
    .locals 5

    .prologue
    const/4 v1, 0x0

    iget v2, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    const/4 v3, 0x1

    if-eq v2, v3, :cond_1

    iget v2, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    const/4 v3, 0x2

    if-eq v2, v3, :cond_1

    iget v2, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    const/16 v3, 0x9

    if-eq v2, v3, :cond_1

    iget v2, p0, Lcom/lge/lgdrm/DrmContent;->agentType:I

    const/16 v3, 0xa

    if-eq v2, v3, :cond_1

    move-object v0, v1

    :cond_0
    :goto_0
    return-object v0

    :cond_1
    iget-object v2, p0, Lcom/lge/lgdrm/DrmContent;->metadata:Lcom/lge/lgdrm/DrmContentMetaData;

    if-eqz v2, :cond_2

    iget-object v0, p0, Lcom/lge/lgdrm/DrmContent;->metadata:Lcom/lge/lgdrm/DrmContentMetaData;

    goto :goto_0

    :cond_2
    new-instance v0, Lcom/lge/lgdrm/DrmContentMetaData;

    invoke-direct {v0}, Lcom/lge/lgdrm/DrmContentMetaData;-><init>()V

    .local v0, "meta":Lcom/lge/lgdrm/DrmContentMetaData;
    iget-object v2, p0, Lcom/lge/lgdrm/DrmContent;->filename:Ljava/lang/String;

    iget v3, p0, Lcom/lge/lgdrm/DrmContent;->index:I

    iget v4, p0, Lcom/lge/lgdrm/DrmContent;->previewContent:I

    invoke-direct {p0, v0, v2, v3, v4}, Lcom/lge/lgdrm/DrmContent;->nativeGetMetaData(Lcom/lge/lgdrm/DrmContentMetaData;Ljava/lang/String;II)I

    move-result v2

    if-eqz v2, :cond_3

    move-object v0, v1

    goto :goto_0

    :cond_3
    const/16 v1, 0xf

    invoke-virtual {p0, v1}, Lcom/lge/lgdrm/DrmContent;->isActionSupported(I)Z

    move-result v1

    if-nez v1, :cond_0

    iput-object v0, p0, Lcom/lge/lgdrm/DrmContent;->metadata:Lcom/lge/lgdrm/DrmContentMetaData;

    goto :goto_0
.end method

.method public isActionSupported(I)Z
    .locals 2
    .param p1, "action"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .prologue
    const/16 v0, 0xf

    if-eq p1, v0, :cond_0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Invalid action"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method protected isIdentical(Lcom/lge/lgdrm/DrmContent;)Z
    .locals 3
    .param p1, "content"    # Lcom/lge/lgdrm/DrmContent;

    .prologue
    const/4 v0, 0x0

    if-nez p1, :cond_1

    :cond_0
    :goto_0
    return v0

    :cond_1
    iget-object v1, p1, Lcom/lge/lgdrm/DrmContent;->filename:Ljava/lang/String;

    iget-object v2, p0, Lcom/lge/lgdrm/DrmContent;->filename:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v1

    if-nez v1, :cond_0

    iget v1, p1, Lcom/lge/lgdrm/DrmContent;->index:I

    iget v2, p0, Lcom/lge/lgdrm/DrmContent;->index:I

    if-ne v1, v2, :cond_0

    const/4 v0, 0x1

    goto :goto_0
.end method

.method protected isSibling(Lcom/lge/lgdrm/DrmContent;)Z
    .locals 3
    .param p1, "content"    # Lcom/lge/lgdrm/DrmContent;

    .prologue
    const/4 v0, 0x0

    if-nez p1, :cond_1

    :cond_0
    :goto_0
    return v0

    :cond_1
    iget-object v1, p1, Lcom/lge/lgdrm/DrmContent;->filename:Ljava/lang/String;

    iget-object v2, p0, Lcom/lge/lgdrm/DrmContent;->filename:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v1

    if-nez v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0
.end method

.method public resetMetaData()I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/UnsupportedOperationException;
        }
    .end annotation

    .prologue
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "Meta dat editing is not permitted"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public selectPreviewContent(Z)V
    .locals 1
    .param p1, "reset"    # Z

    .prologue
    if-eqz p1, :cond_0

    const/4 v0, 0x0

    iput v0, p0, Lcom/lge/lgdrm/DrmContent;->previewContent:I

    :goto_0
    return-void

    :cond_0
    const/4 v0, 0x1

    iput v0, p0, Lcom/lge/lgdrm/DrmContent;->previewContent:I

    goto :goto_0
.end method

.method public setMetaData(Lcom/lge/lgdrm/DrmContentMetaData;)I
    .locals 2
    .param p1, "metaData"    # Lcom/lge/lgdrm/DrmContentMetaData;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NullPointerException;,
            Ljava/lang/UnsupportedOperationException;
        }
    .end annotation

    .prologue
    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "Parameter metaData is null"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "Meta dat editing is not permitted"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
