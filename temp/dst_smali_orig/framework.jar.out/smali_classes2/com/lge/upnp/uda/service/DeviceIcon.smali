.class public Lcom/lge/upnp/uda/service/DeviceIcon;
.super Ljava/lang/Object;
.source "DeviceIcon.java"


# instance fields
.field private mDepth:I

.field private mHeight:I

.field private mMimeType:Ljava/lang/String;

.field private mUrl:Ljava/lang/String;

.field private mWidth:I


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getDepth()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/upnp/uda/service/DeviceIcon;->mDepth:I

    return v0
.end method

.method public getHeight()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/upnp/uda/service/DeviceIcon;->mHeight:I

    return v0
.end method

.method public getMimeType()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/upnp/uda/service/DeviceIcon;->mMimeType:Ljava/lang/String;

    return-object v0
.end method

.method public getUrl()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/upnp/uda/service/DeviceIcon;->mUrl:Ljava/lang/String;

    return-object v0
.end method

.method public getWidth()I
    .locals 1

    .prologue
    iget v0, p0, Lcom/lge/upnp/uda/service/DeviceIcon;->mWidth:I

    return v0
.end method

.method public setDepth(I)V
    .locals 0
    .param p1, "depth"    # I

    .prologue
    iput p1, p0, Lcom/lge/upnp/uda/service/DeviceIcon;->mDepth:I

    return-void
.end method

.method public setDepth(Ljava/lang/String;)V
    .locals 2
    .param p1, "depth"    # Ljava/lang/String;

    .prologue
    :try_start_0
    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    iput v1, p0, Lcom/lge/upnp/uda/service/DeviceIcon;->mDepth:I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "nfe":Ljava/lang/NumberFormatException;
    const/4 v1, 0x0

    iput v1, p0, Lcom/lge/upnp/uda/service/DeviceIcon;->mDepth:I

    goto :goto_0
.end method

.method public setHeight(I)V
    .locals 0
    .param p1, "height"    # I

    .prologue
    iput p1, p0, Lcom/lge/upnp/uda/service/DeviceIcon;->mHeight:I

    return-void
.end method

.method public setHeight(Ljava/lang/String;)V
    .locals 2
    .param p1, "height"    # Ljava/lang/String;

    .prologue
    :try_start_0
    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    iput v1, p0, Lcom/lge/upnp/uda/service/DeviceIcon;->mHeight:I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "nfe":Ljava/lang/NumberFormatException;
    const/4 v1, 0x0

    iput v1, p0, Lcom/lge/upnp/uda/service/DeviceIcon;->mHeight:I

    goto :goto_0
.end method

.method public setMimeType(Ljava/lang/String;)V
    .locals 0
    .param p1, "mimeType"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/upnp/uda/service/DeviceIcon;->mMimeType:Ljava/lang/String;

    return-void
.end method

.method public setUrl(Ljava/lang/String;)V
    .locals 0
    .param p1, "url"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/upnp/uda/service/DeviceIcon;->mUrl:Ljava/lang/String;

    return-void
.end method

.method public setWidth(I)V
    .locals 0
    .param p1, "width"    # I

    .prologue
    iput p1, p0, Lcom/lge/upnp/uda/service/DeviceIcon;->mWidth:I

    return-void
.end method

.method public setWidth(Ljava/lang/String;)V
    .locals 2
    .param p1, "width"    # Ljava/lang/String;

    .prologue
    :try_start_0
    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    iput v1, p0, Lcom/lge/upnp/uda/service/DeviceIcon;->mWidth:I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "nfe":Ljava/lang/NumberFormatException;
    const/4 v1, 0x0

    iput v1, p0, Lcom/lge/upnp/uda/service/DeviceIcon;->mWidth:I

    goto :goto_0
.end method
