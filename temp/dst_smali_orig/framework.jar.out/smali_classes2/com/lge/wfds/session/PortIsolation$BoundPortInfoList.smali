.class Lcom/lge/wfds/session/PortIsolation$BoundPortInfoList;
.super Ljava/lang/Object;
.source "PortIsolation.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/wfds/session/PortIsolation;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "BoundPortInfoList"
.end annotation


# instance fields
.field private mBoundPortInfoList:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/Integer;",
            "Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;",
            ">;"
        }
    .end annotation
.end field

.field private mPeerIpAddress:Ljava/lang/String;

.field final synthetic this$0:Lcom/lge/wfds/session/PortIsolation;


# direct methods
.method constructor <init>(Lcom/lge/wfds/session/PortIsolation;Ljava/lang/String;IILjava/lang/String;Ljava/lang/Integer;)V
    .locals 1
    .param p2, "peerIpAddress"    # Ljava/lang/String;
    .param p3, "portNumber"    # I
    .param p4, "protocolNum"    # I
    .param p5, "sessionMac"    # Ljava/lang/String;
    .param p6, "sessionId"    # Ljava/lang/Integer;

    .prologue
    iput-object p1, p0, Lcom/lge/wfds/session/PortIsolation$BoundPortInfoList;->this$0:Lcom/lge/wfds/session/PortIsolation;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Lcom/lge/wfds/session/PortIsolation$BoundPortInfoList;->mPeerIpAddress:Ljava/lang/String;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/lge/wfds/session/PortIsolation$BoundPortInfoList;->mBoundPortInfoList:Ljava/util/Map;

    invoke-virtual {p0, p3, p4, p5, p6}, Lcom/lge/wfds/session/PortIsolation$BoundPortInfoList;->addBoundPortInfo(IILjava/lang/String;Ljava/lang/Integer;)V

    return-void
.end method

.method private checkBoundPortInfo(ILcom/lge/wfds/session/PortIsolation$BoundPortInfo;)V
    .locals 2
    .param p1, "portNumber"    # I
    .param p2, "boundPortInfo"    # Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;

    .prologue
    invoke-virtual {p2}, Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;->getSessionSize()I

    move-result v0

    if-lez v0, :cond_0

    iget-object v0, p0, Lcom/lge/wfds/session/PortIsolation$BoundPortInfoList;->mBoundPortInfoList:Ljava/util/Map;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :goto_0
    return-void

    :cond_0
    iget-object v0, p0, Lcom/lge/wfds/session/PortIsolation$BoundPortInfoList;->mBoundPortInfoList:Ljava/util/Map;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0
.end method

.method private getBoundPortInfoList()Ljava/util/Iterator;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Iterator",
            "<",
            "Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;",
            ">;"
        }
    .end annotation

    .prologue
    new-instance v0, Ljava/util/HashMap;

    iget-object v1, p0, Lcom/lge/wfds/session/PortIsolation$BoundPortInfoList;->mBoundPortInfoList:Ljava/util/Map;

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(Ljava/util/Map;)V

    .local v0, "boundPortInfoList":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;>;"
    invoke-interface {v0}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    return-object v1
.end method


# virtual methods
.method addBoundPortInfo(IILjava/lang/String;Ljava/lang/Integer;)V
    .locals 6
    .param p1, "portNumber"    # I
    .param p2, "protocolNum"    # I
    .param p3, "sessionMac"    # Ljava/lang/String;
    .param p4, "sessionId"    # Ljava/lang/Integer;

    .prologue
    new-instance v0, Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;

    iget-object v1, p0, Lcom/lge/wfds/session/PortIsolation$BoundPortInfoList;->this$0:Lcom/lge/wfds/session/PortIsolation;

    move v2, p1

    move v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-direct/range {v0 .. v5}, Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;-><init>(Lcom/lge/wfds/session/PortIsolation;IILjava/lang/String;Ljava/lang/Integer;)V

    invoke-virtual {p0, p1, v0}, Lcom/lge/wfds/session/PortIsolation$BoundPortInfoList;->addBoundPortInfo(ILcom/lge/wfds/session/PortIsolation$BoundPortInfo;)V

    return-void
.end method

.method addBoundPortInfo(ILcom/lge/wfds/session/PortIsolation$BoundPortInfo;)V
    .locals 3
    .param p1, "portNumber"    # I
    .param p2, "boudnPortInfo"    # Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;

    .prologue
    iget-object v1, p0, Lcom/lge/wfds/session/PortIsolation$BoundPortInfoList;->mBoundPortInfoList:Ljava/util/Map;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;

    .local v0, "existBoundPortInfo":Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;
    invoke-virtual {p2, p1}, Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;->setPortNumber(I)V

    if-eqz v0, :cond_0

    invoke-virtual {v0, p2}, Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;->putSession(Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;)Z

    iget-object v1, p0, Lcom/lge/wfds/session/PortIsolation$BoundPortInfoList;->mBoundPortInfoList:Ljava/util/Map;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :goto_0
    return-void

    :cond_0
    iget-object v1, p0, Lcom/lge/wfds/session/PortIsolation$BoundPortInfoList;->mBoundPortInfoList:Ljava/util/Map;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v1, v2, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0
.end method

.method getBoundPortInfoSize()I
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/session/PortIsolation$BoundPortInfoList;->mBoundPortInfoList:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->size()I

    move-result v0

    return v0
.end method

.method getPeerIpAddress()Ljava/lang/String;
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/session/PortIsolation$BoundPortInfoList;->mPeerIpAddress:Ljava/lang/String;

    return-object v0
.end method

.method removeAllBoundPortInfo()V
    .locals 3

    .prologue
    invoke-direct {p0}, Lcom/lge/wfds/session/PortIsolation$BoundPortInfoList;->getBoundPortInfoList()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "boundPortList":Ljava/util/Iterator;, "Ljava/util/Iterator<Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;>;"
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;

    .local v0, "boundPortInfo":Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;
    invoke-virtual {v0}, Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;->removeAllSession()V

    invoke-virtual {v0}, Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;->getPortNumber()I

    move-result v2

    invoke-direct {p0, v2, v0}, Lcom/lge/wfds/session/PortIsolation$BoundPortInfoList;->checkBoundPortInfo(ILcom/lge/wfds/session/PortIsolation$BoundPortInfo;)V

    goto :goto_0

    .end local v0    # "boundPortInfo":Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;
    :cond_0
    iget-object v2, p0, Lcom/lge/wfds/session/PortIsolation$BoundPortInfoList;->mBoundPortInfoList:Ljava/util/Map;

    invoke-interface {v2}, Ljava/util/Map;->clear()V

    return-void
.end method

.method removeBoundPortInfo(IILjava/lang/String;Ljava/lang/Integer;)V
    .locals 6
    .param p1, "portNumber"    # I
    .param p2, "protocolNum"    # I
    .param p3, "sessionMac"    # Ljava/lang/String;
    .param p4, "sessionId"    # Ljava/lang/Integer;

    .prologue
    new-instance v0, Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;

    iget-object v1, p0, Lcom/lge/wfds/session/PortIsolation$BoundPortInfoList;->this$0:Lcom/lge/wfds/session/PortIsolation;

    move v2, p1

    move v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-direct/range {v0 .. v5}, Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;-><init>(Lcom/lge/wfds/session/PortIsolation;IILjava/lang/String;Ljava/lang/Integer;)V

    invoke-virtual {p0, p1, v0}, Lcom/lge/wfds/session/PortIsolation$BoundPortInfoList;->removeBoundPortInfo(ILcom/lge/wfds/session/PortIsolation$BoundPortInfo;)V

    return-void
.end method

.method removeBoundPortInfo(ILcom/lge/wfds/session/PortIsolation$BoundPortInfo;)V
    .locals 3
    .param p1, "portNumber"    # I
    .param p2, "boudnPortInfo"    # Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;

    .prologue
    iget-object v1, p0, Lcom/lge/wfds/session/PortIsolation$BoundPortInfoList;->mBoundPortInfoList:Ljava/util/Map;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;

    .local v0, "existBoundPortInfo":Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;
    if-eqz v0, :cond_0

    invoke-virtual {p2, p1}, Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;->setPortNumber(I)V

    invoke-virtual {v0, p2}, Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;->removeSession(Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;)V

    invoke-direct {p0, p1, v0}, Lcom/lge/wfds/session/PortIsolation$BoundPortInfoList;->checkBoundPortInfo(ILcom/lge/wfds/session/PortIsolation$BoundPortInfo;)V

    :cond_0
    return-void
.end method

.method removeBoundPortInfo(Ljava/lang/String;Ljava/lang/Integer;)V
    .locals 4
    .param p1, "sessionMac"    # Ljava/lang/String;
    .param p2, "sessionId"    # Ljava/lang/Integer;

    .prologue
    invoke-direct {p0}, Lcom/lge/wfds/session/PortIsolation$BoundPortInfoList;->getBoundPortInfoList()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "boundPortList":Ljava/util/Iterator;, "Ljava/util/Iterator<Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;>;"
    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;

    .local v0, "boundPortInfo":Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;
    invoke-virtual {v0}, Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;->getPortNumber()I

    move-result v2

    const/16 v3, 0x1c43

    if-eq v2, v3, :cond_0

    invoke-virtual {v0, p1, p2}, Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;->removeSession(Ljava/lang/String;Ljava/lang/Integer;)Z

    move-result v2

    const/4 v3, 0x1

    if-ne v2, v3, :cond_0

    invoke-virtual {v0}, Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;->getPortNumber()I

    move-result v2

    invoke-direct {p0, v2, v0}, Lcom/lge/wfds/session/PortIsolation$BoundPortInfoList;->checkBoundPortInfo(ILcom/lge/wfds/session/PortIsolation$BoundPortInfo;)V

    goto :goto_0

    .end local v0    # "boundPortInfo":Lcom/lge/wfds/session/PortIsolation$BoundPortInfo;
    :cond_1
    return-void
.end method
