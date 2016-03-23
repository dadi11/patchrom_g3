.class Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;
.super Lcom/android/internal/util/State;
.source "WfdsService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/wfds/WfdsService$WfdsStateMachine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "GroupExistedState"
.end annotation


# instance fields
.field final synthetic this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;


# direct methods
.method constructor <init>(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    invoke-direct {p0}, Lcom/android/internal/util/State;-><init>()V

    return-void
.end method

.method private procPeerConnComp()Z
    .locals 6

    .prologue
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v3, v3, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v3

    if-eqz v3, :cond_0

    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v3, v3, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v3

    if-eqz v3, :cond_0

    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v3, v3, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v3

    invoke-virtual {v3}, Landroid/net/wifi/p2p/WifiP2pGroup;->isGroupOwner()Z

    move-result v3

    if-eqz v3, :cond_0

    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v3, v3, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v3

    invoke-virtual {v3}, Landroid/net/wifi/p2p/WifiP2pGroup;->isClientListEmpty()Z

    move-result v3

    if-eqz v3, :cond_1

    :cond_0
    const-string v3, "WfdsService"

    const-string v4, "Invaild parameter"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v3, 0x0

    :goto_0
    return v3

    :cond_1
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v3, v3, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v3

    invoke-virtual {v3}, Landroid/net/wifi/p2p/WifiP2pGroup;->getClientList()Ljava/util/Collection;

    move-result-object v2

    .local v2, "mClient":Ljava/util/Collection;, "Ljava/util/Collection<Landroid/net/wifi/p2p/WifiP2pDevice;>;"
    if-eqz v2, :cond_3

    invoke-interface {v2}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .local v1, "i$":Ljava/util/Iterator;
    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/p2p/WifiP2pDevice;

    .local v0, "client":Landroid/net/wifi/p2p/WifiP2pDevice;
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v3, v3, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v3

    if-nez v3, :cond_2

    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v3, v3, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    new-instance v4, Landroid/net/wifi/p2p/WifiP2pConfigEx;

    invoke-direct {v4}, Landroid/net/wifi/p2p/WifiP2pConfigEx;-><init>()V

    # setter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v3, v4}, Lcom/lge/wfds/WfdsService;->access$2902(Lcom/lge/wfds/WfdsService;Landroid/net/wifi/p2p/WifiP2pConfigEx;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    :cond_2
    const-string v3, "WfdsService"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Client Address: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, v0, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceAddress:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v3, v3, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v3

    iget-object v4, v0, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceAddress:Ljava/lang/String;

    iput-object v4, v3, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    goto :goto_1

    .end local v0    # "client":Landroid/net/wifi/p2p/WifiP2pDevice;
    .end local v1    # "i$":Ljava/util/Iterator;
    :cond_3
    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v3, v3, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v3

    if-eqz v3, :cond_4

    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v3, v3, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v3

    if-nez v3, :cond_4

    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v3, v3, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    iget-object v4, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v4, v4, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsPeerList:Lcom/lge/wfds/WfdsPeerList;
    invoke-static {v4}, Lcom/lge/wfds/WfdsService;->access$1000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsPeerList;

    move-result-object v4

    iget-object v5, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v5, v5, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v5}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v5

    iget-object v5, v5, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    invoke-virtual {v4, v5}, Lcom/lge/wfds/WfdsPeerList;->getPeerDevice(Ljava/lang/String;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v4

    # setter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v3, v4}, Lcom/lge/wfds/WfdsService;->access$2802(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/WfdsDevice;)Lcom/lge/wfds/WfdsDevice;

    :cond_4
    const/4 v3, 0x1

    goto/16 :goto_0
.end method


# virtual methods
.method public enter()V
    .locals 2

    .prologue
    const-string v0, "WfdsService"

    const-string v1, "STATE: GroupExistedState, entered"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public exit()V
    .locals 0

    .prologue
    return-void
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 14
    .param p1, "message"    # Landroid/os/Message;

    .prologue
    iget v9, p1, Landroid/os/Message;->what:I

    sparse-switch v9, :sswitch_data_0

    const/4 v9, 0x0

    :goto_0
    return v9

    :sswitch_0
    const-string v9, "WfdsService"

    const-string v10, "GroupExistedState: ADVERTISE_SERVICE"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v9

    const-class v10, Lcom/lge/wfds/WfdsDiscoveryMethod;

    invoke-virtual {v10}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v10

    invoke-virtual {v9, v10}, Landroid/os/Bundle;->setClassLoader(Ljava/lang/ClassLoader;)V

    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v9

    const/4 v10, 0x0

    invoke-virtual {v9, v10}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/lge/wfds/WfdsDiscoveryMethod;

    .local v0, "advMethod":Lcom/lge/wfds/WfdsDiscoveryMethod;
    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    const/4 v10, 0x1

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->enableAdvertiseService(Landroid/os/Message;Lcom/lge/wfds/WfdsDiscoveryMethod;Z)V
    invoke-static {v9, p1, v0, v10}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$4500(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;Lcom/lge/wfds/WfdsDiscoveryMethod;Z)V

    .end local v0    # "advMethod":Lcom/lge/wfds/WfdsDiscoveryMethod;
    :cond_0
    :goto_1
    const/4 v9, 0x1

    goto :goto_0

    :sswitch_1
    const-string v9, "WfdsService"

    const-string v10, "GroupExistedState: SEEK_SERVICE"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v9

    const-class v10, Lcom/lge/wfds/WfdsDiscoveryMethod;

    invoke-virtual {v10}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v10

    invoke-virtual {v9, v10}, Landroid/os/Bundle;->setClassLoader(Ljava/lang/ClassLoader;)V

    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v9

    const/4 v10, 0x0

    invoke-virtual {v9, v10}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v6

    check-cast v6, Lcom/lge/wfds/WfdsDiscoveryMethod;

    .local v6, "seekMethod":Lcom/lge/wfds/WfdsDiscoveryMethod;
    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    const/4 v10, 0x1

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->enableSeekService(Landroid/os/Message;Lcom/lge/wfds/WfdsDiscoveryMethod;Z)V
    invoke-static {v9, p1, v6, v10}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$4800(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;Lcom/lge/wfds/WfdsDiscoveryMethod;Z)V

    goto :goto_1

    .end local v6    # "seekMethod":Lcom/lge/wfds/WfdsDiscoveryMethod;
    :sswitch_2
    const-string v9, "WfdsService"

    const-string v10, "GroupExistedState: CONNECT_SESSION"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v9

    const-class v10, Lcom/lge/wfds/WfdsDiscoveryMethod;

    invoke-virtual {v10}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v10

    invoke-virtual {v9, v10}, Landroid/os/Bundle;->setClassLoader(Ljava/lang/ClassLoader;)V

    invoke-virtual {p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v9

    const/4 v10, 0x0

    invoke-virtual {v9, v10}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v5

    check-cast v5, Lcom/lge/wfds/WfdsPdMethod;

    .local v5, "pdMethod":Lcom/lge/wfds/WfdsPdMethod;
    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    const/4 v10, 0x1

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->connectSession(Landroid/os/Message;Lcom/lge/wfds/WfdsPdMethod;Z)Z
    invoke-static {v9, p1, v5, v10}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$5000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;Lcom/lge/wfds/WfdsPdMethod;Z)Z

    move-result v9

    const/4 v10, 0x1

    if-eq v9, v10, :cond_0

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    const v10, 0x900025

    const/4 v11, 0x2

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;II)V
    invoke-static {v9, p1, v10, v11}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$2000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;II)V

    goto :goto_1

    .end local v5    # "pdMethod":Lcom/lge/wfds/WfdsPdMethod;
    :sswitch_3
    const-string v9, "WfdsService"

    const-string v10, "GroupExistedState: DISCONNECT_SESSION"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->removeGroup()V
    invoke-static {v9}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$8500(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V

    goto :goto_1

    :sswitch_4
    const-string v9, "WfdsService"

    const-string v10, "GroupExistedState: WFDS_PROV_DISC_DEF_PIN_EVENT"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->processProvDiscDefaultPinWithinGroup()V
    invoke-static {v9}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$12100(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v10, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mConnectingWithinGroupState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ConnectingWithinGroupState;
    invoke-static {v10}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$12200(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$ConnectingWithinGroupState;

    move-result-object v10

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v9, v10}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$12300(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    goto :goto_1

    :sswitch_5
    const-string v9, "WfdsService"

    const-string v10, "GroupExistedState: WFDS_PROV_DISC_DEFER_EVENT"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v9}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v9

    iget-object v9, v9, Lcom/lge/wfds/session/AspSession;->session_mac:Ljava/lang/String;

    iget-object v10, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v10, v10, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mThisDeviceAddress:Ljava/lang/String;
    invoke-static {v10}, Lcom/lge/wfds/WfdsService;->access$3800(Lcom/lge/wfds/WfdsService;)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_1

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->removeProvisionReceivedTimeout()V
    invoke-static {v9}, Lcom/lge/wfds/WfdsService;->access$6200(Lcom/lge/wfds/WfdsService;)V

    :goto_2
    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    const/4 v10, 0x1

    # setter for: Lcom/lge/wfds/WfdsService;->mPdDeferred:Z
    invoke-static {v9, v10}, Lcom/lge/wfds/WfdsService;->access$3502(Lcom/lge/wfds/WfdsService;Z)Z

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->setProvisionDeferredTimeout()V
    invoke-static {v9}, Lcom/lge/wfds/WfdsService;->access$9800(Lcom/lge/wfds/WfdsService;)V

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v10, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mConnectingWithinGroupState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ConnectingWithinGroupState;
    invoke-static {v10}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$12200(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$ConnectingWithinGroupState;

    move-result-object v10

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v9, v10}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$12400(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    :cond_1
    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v10, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    iget-object v9, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v9, Landroid/net/wifi/p2p/WifiP2pConfigEx;

    # setter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v10, v9}, Lcom/lge/wfds/WfdsService;->access$2902(Lcom/lge/wfds/WfdsService;Landroid/net/wifi/p2p/WifiP2pConfigEx;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    iget-object v10, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v10, v10, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsPeerList:Lcom/lge/wfds/WfdsPeerList;
    invoke-static {v10}, Lcom/lge/wfds/WfdsService;->access$1000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsPeerList;

    move-result-object v10

    iget-object v11, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v11, v11, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v11}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v11

    iget-object v11, v11, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    invoke-virtual {v10, v11}, Lcom/lge/wfds/WfdsPeerList;->getPeerDevice(Ljava/lang/String;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v10

    # setter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v9, v10}, Lcom/lge/wfds/WfdsService;->access$2802(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/WfdsDevice;)Lcom/lge/wfds/WfdsDevice;

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v9}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v9

    if-nez v9, :cond_2

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    iget-object v10, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v10, v10, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsPeerList:Lcom/lge/wfds/WfdsPeerList;
    invoke-static {v10}, Lcom/lge/wfds/WfdsService;->access$1000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsPeerList;

    move-result-object v10

    iget-object v11, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v11, v11, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v11}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v11

    iget-object v11, v11, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    invoke-virtual {v10, v11}, Lcom/lge/wfds/WfdsPeerList;->getP2pPeerDevice(Ljava/lang/String;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v10

    # setter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v9, v10}, Lcom/lge/wfds/WfdsService;->access$2802(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/WfdsDevice;)Lcom/lge/wfds/WfdsDevice;

    :cond_2
    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsDialog:Lcom/lge/wfds/WfdsDialog;
    invoke-static {v9}, Lcom/lge/wfds/WfdsService;->access$6500(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDialog;

    move-result-object v9

    iget-object v10, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v10, v10, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v10}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v10

    iget-object v10, v10, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    invoke-virtual {v9, v10}, Lcom/lge/wfds/WfdsDialog;->showProvDeferUserInputDialog(Ljava/lang/String;)Z

    goto :goto_2

    :sswitch_6
    const-string v9, "WfdsService"

    const-string v10, "GroupExistedState: WFDS_PROV_DISC_PERSISTENT_EVENT"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->setConnectionTimeout()V
    invoke-static {v9}, Lcom/lge/wfds/WfdsService;->access$5700(Lcom/lge/wfds/WfdsService;)V

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v10, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mConnectingWithinGroupState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ConnectingWithinGroupState;
    invoke-static {v10}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$12200(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$ConnectingWithinGroupState;

    move-result-object v10

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v9, v10}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$12500(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    :sswitch_7
    const-string v9, "WfdsService"

    const-string v10, "GroupExistedState: WFDS_PROV_DISC_FAIL_EVENT"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->handleProvDiscFailure(Landroid/os/Message;)V
    invoke-static {v9, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$7100(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;)V

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mSessionController:Lcom/lge/wfds/SessionController;
    invoke-static {v9}, Lcom/lge/wfds/WfdsService;->access$300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/SessionController;

    move-result-object v9

    invoke-virtual {v9}, Lcom/lge/wfds/SessionController;->hasOpenedSession()Z

    move-result v9

    if-nez v9, :cond_0

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mAutonomousGroup:Z
    invoke-static {v9}, Lcom/lge/wfds/WfdsService;->access$5600(Lcom/lge/wfds/WfdsService;)Z

    move-result v9

    if-eqz v9, :cond_0

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    const/4 v10, 0x1

    # setter for: Lcom/lge/wfds/WfdsService;->mRemoveAutonomousGroup:Z
    invoke-static {v9, v10}, Lcom/lge/wfds/WfdsService;->access$12602(Lcom/lge/wfds/WfdsService;Z)Z

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    const v10, 0x90100d

    invoke-virtual {v9, v10}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->sendMessage(I)V

    goto/16 :goto_1

    :sswitch_8
    const-string v9, "WfdsService"

    const-string v10, "GroupExistedState: WFDS_P2P_GROUP_REMOVED_EVENT"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v3, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v3, Landroid/net/wifi/p2p/WifiP2pGroup;

    .local v3, "group":Landroid/net/wifi/p2p/WifiP2pGroup;
    const-string v4, ""

    .local v4, "groupOwnerdeviceAddress":Ljava/lang/String;
    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v9}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v9

    if-eqz v9, :cond_3

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v9}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v9

    invoke-virtual {v9}, Landroid/net/wifi/p2p/WifiP2pGroup;->getOwner()Landroid/net/wifi/p2p/WifiP2pDevice;

    move-result-object v9

    iget-object v4, v9, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceAddress:Ljava/lang/String;

    :cond_3
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v9

    if-lez v9, :cond_6

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mSessionController:Lcom/lge/wfds/SessionController;
    invoke-static {v9}, Lcom/lge/wfds/WfdsService;->access$300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/SessionController;

    move-result-object v9

    invoke-virtual {v9}, Lcom/lge/wfds/SessionController;->getSessionList()Ljava/util/Iterator;

    move-result-object v8

    .local v8, "sessionIterator":Ljava/util/Iterator;, "Ljava/util/Iterator<Lcom/lge/wfds/session/AspSession;>;"
    :cond_4
    :goto_3
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_6

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/lge/wfds/session/AspSession;

    .local v7, "session":Lcom/lge/wfds/session/AspSession;
    if-eqz v7, :cond_4

    invoke-virtual {v3}, Landroid/net/wifi/p2p/WifiP2pGroup;->isGroupOwner()Z

    move-result v9

    if-nez v9, :cond_5

    iget-object v9, v7, Lcom/lge/wfds/session/AspSession;->service_mac:Ljava/lang/String;

    invoke-virtual {v9, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_4

    const-string v9, "WfdsService"

    const-string v10, "DISCONNECTED: Report to each service"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    const/16 v10, 0x8

    # invokes: Lcom/lge/wfds/WfdsService;->sendConnectStatus(Lcom/lge/wfds/session/AspSession;I)V
    invoke-static {v9, v7, v10}, Lcom/lge/wfds/WfdsService;->access$5400(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/session/AspSession;I)V

    goto :goto_3

    :cond_5
    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    const/16 v10, 0x8

    # invokes: Lcom/lge/wfds/WfdsService;->sendConnectStatus(Lcom/lge/wfds/session/AspSession;I)V
    invoke-static {v9, v7, v10}, Lcom/lge/wfds/WfdsService;->access$5400(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/session/AspSession;I)V

    goto :goto_3

    .end local v7    # "session":Lcom/lge/wfds/session/AspSession;
    .end local v8    # "sessionIterator":Ljava/util/Iterator;, "Ljava/util/Iterator<Lcom/lge/wfds/session/AspSession;>;"
    :cond_6
    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mSessionController:Lcom/lge/wfds/SessionController;
    invoke-static {v9}, Lcom/lge/wfds/WfdsService;->access$300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/SessionController;

    move-result-object v9

    const v10, 0x901048

    invoke-virtual {v9, v10}, Lcom/lge/wfds/SessionController;->sendMessage(I)V

    const-wide/16 v10, 0x12c

    :try_start_0
    invoke-static {v10, v11}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_4
    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v10, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWfdsEnabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;
    invoke-static {v10}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$3300(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;

    move-result-object v10

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v9, v10}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$12700(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    :catch_0
    move-exception v2

    .local v2, "e":Ljava/lang/InterruptedException;
    const-string v9, "WfdsService"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "Interrupted Exception : "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_4

    .end local v2    # "e":Ljava/lang/InterruptedException;
    .end local v3    # "group":Landroid/net/wifi/p2p/WifiP2pGroup;
    .end local v4    # "groupOwnerdeviceAddress":Ljava/lang/String;
    :sswitch_9
    const-string v9, "WfdsService"

    const-string v10, "GroupExistedState: WFDS_P2P_DISCONNECTED_EVENT"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v9}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v9

    if-eqz v9, :cond_0

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v9}, Lcom/lge/wfds/WfdsService;->access$200(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pGroup;

    move-result-object v9

    invoke-virtual {v9}, Landroid/net/wifi/p2p/WifiP2pGroup;->isGroupOwner()Z

    move-result v9

    if-eqz v9, :cond_0

    iget-object v1, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v1, Ljava/lang/String;

    .local v1, "deviceAddr":Ljava/lang/String;
    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mSessionController:Lcom/lge/wfds/SessionController;
    invoke-static {v9}, Lcom/lge/wfds/WfdsService;->access$300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/SessionController;

    move-result-object v9

    invoke-virtual {v9, v1}, Lcom/lge/wfds/SessionController;->getSession(Ljava/lang/String;)Ljava/util/Iterator;

    move-result-object v8

    .restart local v8    # "sessionIterator":Ljava/util/Iterator;, "Ljava/util/Iterator<Lcom/lge/wfds/session/AspSession;>;"
    :cond_7
    :goto_5
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_8

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/lge/wfds/session/AspSession;

    .restart local v7    # "session":Lcom/lge/wfds/session/AspSession;
    iget-object v9, v7, Lcom/lge/wfds/session/AspSession;->service_mac:Ljava/lang/String;

    invoke-virtual {v9, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_7

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    const/16 v10, 0x8

    # invokes: Lcom/lge/wfds/WfdsService;->sendConnectStatus(Lcom/lge/wfds/session/AspSession;I)V
    invoke-static {v9, v7, v10}, Lcom/lge/wfds/WfdsService;->access$5400(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/session/AspSession;I)V

    goto :goto_5

    .end local v7    # "session":Lcom/lge/wfds/session/AspSession;
    :cond_8
    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mSessionController:Lcom/lge/wfds/SessionController;
    invoke-static {v9}, Lcom/lge/wfds/WfdsService;->access$300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/SessionController;

    move-result-object v9

    const v10, 0x901049

    invoke-virtual {v9, v10, v1}, Lcom/lge/wfds/SessionController;->sendMessage(ILjava/lang/Object;)V

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    const v10, 0x90100e

    const-wide/16 v12, 0x64

    invoke-virtual {v9, v10, v1, v12, v13}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->sendMessageDelayed(ILjava/lang/Object;J)V

    goto/16 :goto_1

    .end local v1    # "deviceAddr":Ljava/lang/String;
    .end local v8    # "sessionIterator":Ljava/util/Iterator;, "Ljava/util/Iterator<Lcom/lge/wfds/session/AspSession;>;"
    :sswitch_a
    const-string v9, "WfdsService"

    const-string v10, "GroupExistedState: WFDS_PEER_CONNECT_COMPLETED"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0}, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->procPeerConnComp()Z

    move-result v9

    if-eqz v9, :cond_0

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v10, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mIpObtainingState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$IpObtainingState;
    invoke-static {v10}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$11500(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$IpObtainingState;

    move-result-object v10

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v9, v10}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$12800(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    :sswitch_b
    const-string v9, "WfdsService"

    const-string v10, "GroupExistedState: WFDS_CONNECTION_TIMEOUT"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v9}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v9

    if-eqz v9, :cond_9

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v9}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v9

    iget-object v9, v9, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    if-eqz v9, :cond_9

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    iget-object v10, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v10, v10, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v10}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v10

    const/4 v11, 0x7

    # invokes: Lcom/lge/wfds/WfdsService;->sendConnectStatus(Lcom/lge/wfds/session/AspSession;I)V
    invoke-static {v9, v10, v11}, Lcom/lge/wfds/WfdsService;->access$5400(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/session/AspSession;I)V

    :cond_9
    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v9}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v9

    invoke-virtual {v9}, Lcom/lge/wfds/WfdsNative;->clearPdInformation()Ljava/lang/String;

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->cancelConnect()V
    invoke-static {v9}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$11800(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    const v10, 0x901016

    invoke-virtual {v9, v10}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->sendMessage(I)V

    goto/16 :goto_1

    :sswitch_c
    const-string v9, "WfdsService"

    const-string v10, "GroupExistedState: WFDS_PD_DEFERRED(RECEIVED)_TIMEOUT"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->handleProvDiscTimeout()V
    invoke-static {v9}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$10000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mSessionController:Lcom/lge/wfds/SessionController;
    invoke-static {v9}, Lcom/lge/wfds/WfdsService;->access$300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/SessionController;

    move-result-object v9

    invoke-virtual {v9}, Lcom/lge/wfds/SessionController;->hasOpenedSession()Z

    move-result v9

    if-nez v9, :cond_0

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mAutonomousGroup:Z
    invoke-static {v9}, Lcom/lge/wfds/WfdsService;->access$5600(Lcom/lge/wfds/WfdsService;)Z

    move-result v9

    if-eqz v9, :cond_0

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v9, v9, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    const/4 v10, 0x1

    # setter for: Lcom/lge/wfds/WfdsService;->mRemoveAutonomousGroup:Z
    invoke-static {v9, v10}, Lcom/lge/wfds/WfdsService;->access$12602(Lcom/lge/wfds/WfdsService;Z)Z

    iget-object v9, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$GroupExistedState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    const v10, 0x90100d

    invoke-virtual {v9, v10}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->sendMessage(I)V

    goto/16 :goto_1

    :sswitch_data_0
    .sparse-switch
        0x900001 -> :sswitch_0
        0x900004 -> :sswitch_1
        0x900005 -> :sswitch_2
        0x90000e -> :sswitch_3
        0x901006 -> :sswitch_a
        0x901008 -> :sswitch_c
        0x901009 -> :sswitch_c
        0x90100a -> :sswitch_b
        0x902007 -> :sswitch_7
        0x90200a -> :sswitch_4
        0x90200d -> :sswitch_6
        0x902011 -> :sswitch_5
        0x902012 -> :sswitch_8
        0x902015 -> :sswitch_9
    .end sparse-switch
.end method
