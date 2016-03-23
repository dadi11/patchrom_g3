.class public Lcom/lge/upnp/uda/service/NetworkInfo;
.super Lcom/lge/upnp/uda/service/INetworkInfo;
.source "NetworkInfo.java"


# instance fields
.field private mLocalIPAddr:Ljava/lang/String;

.field private mLocalPort:I

.field private mRemoteIPAddr:Ljava/lang/String;

.field private mRemotePort:I

.field private m_ObjId:J


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    invoke-direct {p0}, Lcom/lge/upnp/uda/service/INetworkInfo;-><init>()V

    const-string v0, "0"

    iput-object v0, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->mLocalIPAddr:Ljava/lang/String;

    const-string v0, "0"

    iput-object v0, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->mRemoteIPAddr:Ljava/lang/String;

    iput v1, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->mLocalPort:I

    iput v1, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->mRemotePort:I

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->m_ObjId:J

    return-void
.end method

.method public constructor <init>(J)V
    .locals 5
    .param p1, "ObjId"    # J

    .prologue
    const-wide/16 v2, 0x0

    const/4 v1, 0x0

    invoke-direct {p0}, Lcom/lge/upnp/uda/service/INetworkInfo;-><init>()V

    cmp-long v0, p1, v2

    if-nez v0, :cond_0

    const-string v0, "0"

    iput-object v0, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->mLocalIPAddr:Ljava/lang/String;

    const-string v0, "0"

    iput-object v0, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->mRemoteIPAddr:Ljava/lang/String;

    iput v1, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->mLocalPort:I

    iput v1, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->mRemotePort:I

    iput-wide v2, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->m_ObjId:J

    :goto_0
    return-void

    :cond_0
    iput-wide p1, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->m_ObjId:J

    goto :goto_0
.end method


# virtual methods
.method public getInterfaceName()Ljava/lang/String;
    .locals 4

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->m_ObjId:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNINetworkInfo;->GetInterfaceName(J)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public getLocalIPAddress()Ljava/lang/String;
    .locals 4

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->m_ObjId:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->mLocalIPAddr:Ljava/lang/String;

    :goto_0
    return-object v0

    :cond_0
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNINetworkInfo;->GetLocalIPAddress(J)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public getLocalPort()I
    .locals 4

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->m_ObjId:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    iget v0, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->mLocalPort:I

    :goto_0
    return v0

    :cond_0
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNINetworkInfo;->GetLocalPort(J)I

    move-result v0

    goto :goto_0
.end method

.method public getRemoteIPAddress()Ljava/lang/String;
    .locals 4

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->m_ObjId:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->mRemoteIPAddr:Ljava/lang/String;

    :goto_0
    return-object v0

    :cond_0
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNINetworkInfo;->GetRemoteIPAddress(J)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public getRemoteMACAddress()Ljava/lang/String;
    .locals 4

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->m_ObjId:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNINetworkInfo;->GetRemoteMACAddress(J)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public getRemotePort()I
    .locals 4

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->m_ObjId:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    iget v0, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->mRemotePort:I

    :goto_0
    return v0

    :cond_0
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNINetworkInfo;->GetRemotePort(J)I

    move-result v0

    goto :goto_0
.end method

.method public setLocalIPAddress(Ljava/lang/String;)V
    .locals 0
    .param p1, "localIP"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->mLocalIPAddr:Ljava/lang/String;

    return-void
.end method

.method public setLocalPort(I)V
    .locals 0
    .param p1, "port"    # I

    .prologue
    iput p1, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->mLocalPort:I

    return-void
.end method

.method public setRemoteIPAddress(Ljava/lang/String;)V
    .locals 0
    .param p1, "remoteIP"    # Ljava/lang/String;

    .prologue
    iput-object p1, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->mRemoteIPAddr:Ljava/lang/String;

    return-void
.end method

.method public setRemotePort(I)V
    .locals 0
    .param p1, "port"    # I

    .prologue
    iput p1, p0, Lcom/lge/upnp/uda/service/NetworkInfo;->mRemotePort:I

    return-void
.end method
