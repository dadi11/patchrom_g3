.class public Lcom/lge/upnp/uda/service/ServiceInfo;
.super Lcom/lge/upnp/uda/service/IServiceInfo;
.source "ServiceInfo.java"


# instance fields
.field private m_ObjId:J


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    invoke-direct {p0}, Lcom/lge/upnp/uda/service/IServiceInfo;-><init>()V

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/lge/upnp/uda/service/ServiceInfo;->m_ObjId:J

    return-void
.end method

.method public constructor <init>(J)V
    .locals 1
    .param p1, "Id"    # J

    .prologue
    invoke-direct {p0}, Lcom/lge/upnp/uda/service/IServiceInfo;-><init>()V

    iput-wide p1, p0, Lcom/lge/upnp/uda/service/ServiceInfo;->m_ObjId:J

    return-void
.end method


# virtual methods
.method public getActionInfoList()[Lcom/lge/upnp/uda/service/IActionInfo;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/ServiceInfo;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNIServiceInfo;->GetActionInfoList(J)[Lcom/lge/upnp/uda/service/IActionInfo;

    move-result-object v0

    return-object v0
.end method

.method public getControlURL()Ljava/lang/String;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/ServiceInfo;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNIServiceInfo;->GetControlURL(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getEventSubURL()Ljava/lang/String;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/ServiceInfo;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNIServiceInfo;->GetEventSubURL(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getObjectId()J
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/ServiceInfo;->m_ObjId:J

    return-wide v0
.end method

.method public getSCPDURL()Ljava/lang/String;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/ServiceInfo;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNIServiceInfo;->GetSCPDURL(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getServiceId()Ljava/lang/String;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/ServiceInfo;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNIServiceInfo;->GetServiceId(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getServiceType()Ljava/lang/String;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/ServiceInfo;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNIServiceInfo;->GetServiceType(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getStateVarInfoList()[Lcom/lge/upnp/uda/service/IStateVarInfo;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/ServiceInfo;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNIServiceInfo;->GetStateVarInfoList(J)[Lcom/lge/upnp/uda/service/IStateVarInfo;

    move-result-object v0

    return-object v0
.end method

.method public getSubScriberCount()I
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/ServiceInfo;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNIServiceInfo;->GetSubScriberCount(J)I

    move-result v0

    return v0
.end method
