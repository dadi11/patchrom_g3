.class Lcom/lge/upnp/uda/service/IconInfo;
.super Lcom/lge/upnp/uda/service/IIconInfo;
.source "IconInfo.java"


# instance fields
.field private m_ObjId:J


# direct methods
.method public constructor <init>(J)V
    .locals 1
    .param p1, "ObjId"    # J

    .prologue
    invoke-direct {p0}, Lcom/lge/upnp/uda/service/IIconInfo;-><init>()V

    iput-wide p1, p0, Lcom/lge/upnp/uda/service/IconInfo;->m_ObjId:J

    return-void
.end method


# virtual methods
.method public getDepth()Ljava/lang/String;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/IconInfo;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNIIconInfo;->GetDepth(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getHeight()Ljava/lang/String;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/IconInfo;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNIIconInfo;->GetHeight(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getMimeType()Ljava/lang/String;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/IconInfo;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNIIconInfo;->GetMimeType(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getUrl()Ljava/lang/String;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/IconInfo;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNIIconInfo;->GetUrl(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getWidth()Ljava/lang/String;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/IconInfo;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNIIconInfo;->GetWidth(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
