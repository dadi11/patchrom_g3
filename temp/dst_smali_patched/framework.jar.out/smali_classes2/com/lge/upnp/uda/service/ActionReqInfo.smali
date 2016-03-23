.class public Lcom/lge/upnp/uda/service/ActionReqInfo;
.super Ljava/lang/Object;
.source "ActionReqInfo.java"


# instance fields
.field private m_ObjId:J


# direct methods
.method public constructor <init>(J)V
    .locals 1
    .param p1, "ObjId"    # J

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-wide p1, p0, Lcom/lge/upnp/uda/service/ActionReqInfo;->m_ObjId:J

    return-void
.end method


# virtual methods
.method public getActionInfo()Lcom/lge/upnp/uda/service/ActionInfo;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/ActionReqInfo;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNIActionReqInfo;->GetActionInfo(J)Lcom/lge/upnp/uda/service/ActionInfo;

    move-result-object v0

    return-object v0
.end method

.method public getDeviceInfo()Lcom/lge/upnp/uda/service/IDeviceInfo;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/ActionReqInfo;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNIActionReqInfo;->GetDeviceInfo(J)Lcom/lge/upnp/uda/service/IDeviceInfo;

    move-result-object v0

    return-object v0
.end method

.method public getServiceInfo()Lcom/lge/upnp/uda/service/IServiceInfo;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/ActionReqInfo;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNIActionReqInfo;->GetServiceInfo(J)Lcom/lge/upnp/uda/service/IServiceInfo;

    move-result-object v0

    return-object v0
.end method

.method public get_ErrorString()Ljava/lang/String;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/ActionReqInfo;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNIActionReqInfo;->get_ErrorString(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public get_SoapErrorCode()I
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/ActionReqInfo;->m_ObjId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNIActionReqInfo;->get_SoapErrorCode(J)I

    move-result v0

    return v0
.end method

.method public set_ErrorString(Ljava/lang/String;)V
    .locals 2
    .param p1, "Error"    # Ljava/lang/String;

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/ActionReqInfo;->m_ObjId:J

    invoke-static {v0, v1, p1}, Lcom/lge/upnp/uda/service/JNIActionReqInfo;->set_ErrorString(JLjava/lang/String;)V

    return-void
.end method

.method public set_SoapErrorCode(I)V
    .locals 2
    .param p1, "SoapErrorCode"    # I

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/ActionReqInfo;->m_ObjId:J

    invoke-static {v0, v1, p1}, Lcom/lge/upnp/uda/service/JNIActionReqInfo;->set_SoapErrorCode(JI)V

    return-void
.end method
