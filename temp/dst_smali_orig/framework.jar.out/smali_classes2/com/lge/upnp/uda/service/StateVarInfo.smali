.class public Lcom/lge/upnp/uda/service/StateVarInfo;
.super Lcom/lge/upnp/uda/service/IStateVarInfo;
.source "StateVarInfo.java"


# instance fields
.field private m_objId:J


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    invoke-direct {p0}, Lcom/lge/upnp/uda/service/IStateVarInfo;-><init>()V

    invoke-static {}, Lcom/lge/upnp/uda/service/JNIStateVarInfo;->CreateNativeMethod()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/lge/upnp/uda/service/StateVarInfo;->m_objId:J

    return-void
.end method

.method public constructor <init>(J)V
    .locals 1
    .param p1, "ObjId"    # J

    .prologue
    invoke-direct {p0}, Lcom/lge/upnp/uda/service/IStateVarInfo;-><init>()V

    iput-wide p1, p0, Lcom/lge/upnp/uda/service/StateVarInfo;->m_objId:J

    return-void
.end method


# virtual methods
.method public GetObjectId()J
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/StateVarInfo;->m_objId:J

    return-wide v0
.end method

.method public getAllowedValueList()[Ljava/lang/String;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/StateVarInfo;->m_objId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNIStateVarInfo;->GetAllowedValueList(J)[Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getAllowedValueRange()Lcom/lge/upnp/uda/service/IAllowedValueRange;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/StateVarInfo;->m_objId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNIStateVarInfo;->GetAllowedValueRange(J)Lcom/lge/upnp/uda/service/IAllowedValueRange;

    move-result-object v0

    return-object v0
.end method

.method public getDataType()Ljava/lang/String;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/StateVarInfo;->m_objId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNIStateVarInfo;->GetDataType(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getDefaultValue()Ljava/lang/String;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/StateVarInfo;->m_objId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNIStateVarInfo;->GetDefaultValue(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getSendEvents()Z
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/StateVarInfo;->m_objId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNIStateVarInfo;->GetSendEvents(J)Z

    move-result v0

    return v0
.end method

.method public getStateVariableName()Ljava/lang/String;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/StateVarInfo;->m_objId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNIStateVarInfo;->GetStateVariableName(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getStateVariableValue()Ljava/lang/String;
    .locals 2

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/StateVarInfo;->m_objId:J

    invoke-static {v0, v1}, Lcom/lge/upnp/uda/service/JNIStateVarInfo;->GetStateVariableValue(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public setStateVariableName(Ljava/lang/String;)V
    .locals 2
    .param p1, "strVarName"    # Ljava/lang/String;

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/StateVarInfo;->m_objId:J

    invoke-static {v0, v1, p1}, Lcom/lge/upnp/uda/service/JNIStateVarInfo;->SetStateVariableName(JLjava/lang/String;)V

    return-void
.end method

.method public setStateVariableValue(Ljava/lang/String;)V
    .locals 2
    .param p1, "strVarValue"    # Ljava/lang/String;

    .prologue
    iget-wide v0, p0, Lcom/lge/upnp/uda/service/StateVarInfo;->m_objId:J

    invoke-static {v0, v1, p1}, Lcom/lge/upnp/uda/service/JNIStateVarInfo;->SetStateVariableValue(JLjava/lang/String;)V

    return-void
.end method
