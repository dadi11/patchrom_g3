.class Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;
.super Lcom/android/internal/util/State;
.source "WfdsService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/wfds/WfdsService$WfdsStateMachine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "ProvisionState"
.end annotation


# instance fields
.field final synthetic this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;


# direct methods
.method constructor <init>(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    invoke-direct {p0}, Lcom/android/internal/util/State;-><init>()V

    return-void
.end method


# virtual methods
.method public enter()V
    .locals 7

    .prologue
    const-string v0, "WfdsService"

    const-string v1, "STATE : ProvisionState - enter"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v0

    iget-object v0, v0, Lcom/lge/wfds/WfdsDevice;->wfdsInfo:Lcom/lge/wfds/WfdsInfo;

    if-nez v0, :cond_1

    :cond_0
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWfdsEnabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$3300(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;

    move-result-object v1

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v0, v1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$8600(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    :goto_0
    return-void

    :cond_1
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v0

    iget-object v0, v0, Lcom/lge/wfds/WfdsDevice;->wfdsInfo:Lcom/lge/wfds/WfdsInfo;

    iget v0, v0, Lcom/lge/wfds/WfdsInfo;->mWfdsRequestRole:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_2

    const/4 v6, 0x4

    .local v6, "connectionCapa":I
    :goto_1
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v1, v1, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v2, v2, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v2

    iget-object v2, v2, Lcom/lge/wfds/WfdsDevice;->deviceAddress:Ljava/lang/String;

    iget-object v3, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v3, v3, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v3}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v3

    iget-object v3, v3, Lcom/lge/wfds/WfdsDevice;->wfdsInfo:Lcom/lge/wfds/WfdsInfo;

    iget v3, v3, Lcom/lge/wfds/WfdsInfo;->mWfdsAdvertiseId:I

    iget-object v4, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v4, v4, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v4}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v4

    iget v4, v4, Lcom/lge/wfds/session/AspSession;->session_id:I

    iget-object v5, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v5, v5, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v5}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v5

    iget-object v5, v5, Lcom/lge/wfds/WfdsDevice;->wfdsInfo:Lcom/lge/wfds/WfdsInfo;

    iget-object v5, v5, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionInfo:Ljava/lang/String;

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->requestP2pConnection(Landroid/net/wifi/p2p/WifiP2pConfigEx;Ljava/lang/String;IILjava/lang/String;I)Z
    invoke-static/range {v0 .. v6}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$8700(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/net/wifi/p2p/WifiP2pConfigEx;Ljava/lang/String;IILjava/lang/String;I)Z

    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->setProvisionReceivedTimeout()V
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$8800(Lcom/lge/wfds/WfdsService;)V

    goto :goto_0

    .end local v6    # "connectionCapa":I
    :cond_2
    const/4 v6, 0x1

    .restart local v6    # "connectionCapa":I
    goto :goto_1
.end method

.method public exit()V
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPdDeferred:Z
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3500(Lcom/lge/wfds/WfdsService;)Z

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    const/4 v1, 0x0

    # setter for: Lcom/lge/wfds/WfdsService;->mPdDeferred:Z
    invoke-static {v0, v1}, Lcom/lge/wfds/WfdsService;->access$3502(Lcom/lge/wfds/WfdsService;Z)Z

    :cond_0
    return-void
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 13
    .param p1, "message"    # Landroid/os/Message;

    .prologue
    const v11, 0x900021

    const/4 v12, 0x2

    const/4 v10, 0x5

    const/4 v8, 0x0

    const/4 v9, 0x1

    iget v7, p1, Landroid/os/Message;->what:I

    sparse-switch v7, :sswitch_data_0

    move v7, v8

    :goto_0
    return v7

    :sswitch_0
    const-string v7, "WfdsService"

    const-string v8, "The connection request is ignored from WifiP2pService"

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v8, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWfdsEnabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;
    invoke-static {v8}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$3300(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;

    move-result-object v8

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v7, v8}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$8900(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    :cond_0
    :goto_1
    :sswitch_1
    move v7, v9

    goto :goto_0

    :sswitch_2
    const-string v7, "WfdsService"

    const-string v8, "Received the WFDS Provision Discovery Request from peer"

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    :sswitch_3
    iget-object v4, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v4, Ljava/lang/String;

    .local v4, "eventStr":Ljava/lang/String;
    if-eqz v4, :cond_0

    new-instance v6, Landroid/net/wifi/p2p/WifiP2pProvDiscEventEx;

    invoke-direct {v6, v4}, Landroid/net/wifi/p2p/WifiP2pProvDiscEventEx;-><init>(Ljava/lang/String;)V

    .local v6, "provDisc":Landroid/net/wifi/p2p/WifiP2pProvDiscEventEx;
    iget-object v1, v6, Landroid/net/wifi/p2p/WifiP2pProvDiscEventEx;->device:Landroid/net/wifi/p2p/WifiP2pDevice;

    .local v1, "device":Landroid/net/wifi/p2p/WifiP2pDevice;
    const-string v7, "WfdsService"

    const-string v8, "Received the WFDS Provision Discovery Response from peer"

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v7, v1, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceAddress:Ljava/lang/String;

    iget-object v8, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v8, v8, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v8}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v8

    iget-object v8, v8, Lcom/lge/wfds/WfdsDevice;->deviceAddress:Ljava/lang/String;

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_0

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->sendWfdsProvisionDiscoveryChangedBroadcast(Ljava/lang/String;)V
    invoke-static {v7, v4}, Lcom/lge/wfds/WfdsService;->access$9000(Lcom/lge/wfds/WfdsService;Ljava/lang/String;)V

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v8, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mP2pConnectingState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$P2pConnectingState;
    invoke-static {v8}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$6000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$P2pConnectingState;

    move-result-object v8

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v7, v8}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$9100(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    goto :goto_1

    .end local v1    # "device":Landroid/net/wifi/p2p/WifiP2pDevice;
    .end local v4    # "eventStr":Ljava/lang/String;
    .end local v6    # "provDisc":Landroid/net/wifi/p2p/WifiP2pProvDiscEventEx;
    :sswitch_4
    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->removeProvisionReceivedTimeout()V
    invoke-static {v7}, Lcom/lge/wfds/WfdsService;->access$6200(Lcom/lge/wfds/WfdsService;)V

    iget-object v8, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v7, Ljava/lang/String;

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->processProvDiscDefaultPin(Ljava/lang/String;)V
    invoke-static {v8, v7}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$5500(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Ljava/lang/String;)V

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mAutonomousGroup:Z
    invoke-static {v7}, Lcom/lge/wfds/WfdsService;->access$5600(Lcom/lge/wfds/WfdsService;)Z

    move-result v7

    if-eqz v7, :cond_1

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->setConnectionTimeout()V
    invoke-static {v7}, Lcom/lge/wfds/WfdsService;->access$5700(Lcom/lge/wfds/WfdsService;)V

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v8, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mAutonomousGoState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$AutonomousGoState;
    invoke-static {v8}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$5800(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$AutonomousGoState;

    move-result-object v8

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v7, v8}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$9200(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    goto :goto_1

    :cond_1
    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v8, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mP2pConnectingState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$P2pConnectingState;
    invoke-static {v8}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$6000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$P2pConnectingState;

    move-result-object v8

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v7, v8}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$9300(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    goto :goto_1

    :sswitch_5
    iget-object v4, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v4, Ljava/lang/String;

    .restart local v4    # "eventStr":Ljava/lang/String;
    new-instance v6, Landroid/net/wifi/p2p/WifiP2pProvDiscEventEx;

    invoke-direct {v6, v4}, Landroid/net/wifi/p2p/WifiP2pProvDiscEventEx;-><init>(Ljava/lang/String;)V

    .restart local v6    # "provDisc":Landroid/net/wifi/p2p/WifiP2pProvDiscEventEx;
    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->removeProvisionReceivedTimeout()V
    invoke-static {v7}, Lcom/lge/wfds/WfdsService;->access$6200(Lcom/lge/wfds/WfdsService;)V

    const-string v7, "WfdsService"

    const-string v8, "Process the WFDS_PROV_DISC_KEYPAD_EVENT"

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v7}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v7

    if-eqz v7, :cond_0

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v7}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v7

    iget-object v7, v7, Landroid/net/wifi/p2p/WifiP2pConfigEx;->wps:Landroid/net/wifi/WpsInfo;

    iget v7, v7, Landroid/net/wifi/WpsInfo;->setup:I

    if-ne v7, v12, :cond_0

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v7}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v7

    iget-object v7, v7, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    iget-object v8, v6, Landroid/net/wifi/p2p/WifiP2pProvDiscEventEx;->device:Landroid/net/wifi/p2p/WifiP2pDevice;

    iget-object v8, v8, Landroid/net/wifi/p2p/WifiP2pDevice;->deviceAddress:Ljava/lang/String;

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_0

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsDialog:Lcom/lge/wfds/WfdsDialog;
    invoke-static {v7}, Lcom/lge/wfds/WfdsService;->access$6500(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDialog;

    move-result-object v7

    iget-object v8, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v8, v8, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v8}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v8

    iget-object v8, v8, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    iget-object v10, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v10, v10, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v10}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v10

    iget-object v10, v10, Landroid/net/wifi/p2p/WifiP2pConfigEx;->wps:Landroid/net/wifi/WpsInfo;

    invoke-virtual {v7, v8, v10}, Lcom/lge/wfds/WfdsDialog;->showProvDiscEnterPinDialog(Ljava/lang/String;Landroid/net/wifi/WpsInfo;)Z

    move-result v7

    if-eqz v7, :cond_0

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # setter for: Lcom/lge/wfds/WfdsService;->mKeypadEventString:Ljava/lang/String;
    invoke-static {v7, v4}, Lcom/lge/wfds/WfdsService;->access$9402(Lcom/lge/wfds/WfdsService;Ljava/lang/String;)Ljava/lang/String;

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v7}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v7

    const/16 v8, 0x2ee0

    invoke-virtual {v7, v8}, Lcom/lge/wfds/WfdsNative;->p2pListen(I)Z

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v8, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mProvisionDeferredState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionDeferredState;
    invoke-static {v8}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$6600(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionDeferredState;

    move-result-object v8

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v7, v8}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$9500(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    .end local v4    # "eventStr":Ljava/lang/String;
    .end local v6    # "provDisc":Landroid/net/wifi/p2p/WifiP2pProvDiscEventEx;
    :sswitch_6
    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->removeProvisionDeferredTimeout()V
    invoke-static {v7}, Lcom/lge/wfds/WfdsService;->access$9600(Lcom/lge/wfds/WfdsService;)V

    iget-object v10, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v7, Ljava/lang/String;

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->processProvDiscDisplay(Ljava/lang/String;Z)Z
    invoke-static {v10, v7, v8}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$6300(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Ljava/lang/String;Z)Z

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v8, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mP2pConnectingState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$P2pConnectingState;
    invoke-static {v8}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$6000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$P2pConnectingState;

    move-result-object v8

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v7, v8}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$9700(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    :sswitch_7
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/net/wifi/p2p/WifiP2pConfigEx;

    .local v0, "config":Landroid/net/wifi/p2p/WifiP2pConfigEx;
    const-string v7, "WfdsService"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "Seeker: DEFER_EVENT: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v0}, Landroid/net/wifi/p2p/WifiP2pConfigEx;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v7, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v0, :cond_0

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v7}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v7

    if-eqz v7, :cond_0

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v7}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v7

    iget-object v7, v7, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    iget-object v10, v0, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    invoke-virtual {v7, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_0

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # setter for: Lcom/lge/wfds/WfdsService;->mPdDeferred:Z
    invoke-static {v7, v9}, Lcom/lge/wfds/WfdsService;->access$3502(Lcom/lge/wfds/WfdsService;Z)Z

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->removeProvisionReceivedTimeout()V
    invoke-static {v7}, Lcom/lge/wfds/WfdsService;->access$6200(Lcom/lge/wfds/WfdsService;)V

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->setProvisionDeferredTimeout()V
    invoke-static {v7}, Lcom/lge/wfds/WfdsService;->access$9800(Lcom/lge/wfds/WfdsService;)V

    iget-object v7, v0, Landroid/net/wifi/p2p/WifiP2pConfigEx;->wps:Landroid/net/wifi/WpsInfo;

    iget v7, v7, Landroid/net/wifi/WpsInfo;->setup:I

    if-ne v7, v9, :cond_2

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v7}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v7

    iget-object v7, v7, Landroid/net/wifi/p2p/WifiP2pConfigEx;->wps:Landroid/net/wifi/WpsInfo;

    iput v9, v7, Landroid/net/wifi/WpsInfo;->setup:I

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v7}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v7

    iget-object v7, v7, Landroid/net/wifi/p2p/WifiP2pConfigEx;->wps:Landroid/net/wifi/WpsInfo;

    iget-object v10, v0, Landroid/net/wifi/p2p/WifiP2pConfigEx;->pin:Ljava/lang/String;

    iput-object v10, v7, Landroid/net/wifi/WpsInfo;->pin:Ljava/lang/String;

    :try_start_0
    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    iget-object v10, v0, Landroid/net/wifi/p2p/WifiP2pConfigEx;->pin:Ljava/lang/String;

    invoke-static {v10}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v10

    # setter for: Lcom/lge/wfds/WfdsService;->mDisplayPin:I
    invoke-static {v7, v10}, Lcom/lge/wfds/WfdsService;->access$3602(Lcom/lge/wfds/WfdsService;I)I

    const-string v7, "WfdsService"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "Display Pin Number: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget-object v11, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v11, v11, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mDisplayPin:I
    invoke-static {v11}, Lcom/lge/wfds/WfdsService;->access$3600(Lcom/lge/wfds/WfdsService;)I

    move-result v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v7, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_2
    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsDialog:Lcom/lge/wfds/WfdsDialog;
    invoke-static {v7}, Lcom/lge/wfds/WfdsService;->access$6500(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDialog;

    move-result-object v7

    iget-object v8, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v8, v8, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v8}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v8

    iget-object v8, v8, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    iget-object v10, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v10, v10, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v10}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v10

    iget-object v10, v10, Landroid/net/wifi/p2p/WifiP2pConfigEx;->wps:Landroid/net/wifi/WpsInfo;

    iget-object v10, v10, Landroid/net/wifi/WpsInfo;->pin:Ljava/lang/String;

    invoke-virtual {v7, v8, v10}, Lcom/lge/wfds/WfdsDialog;->showProvDiscShowPinDialog(Ljava/lang/String;Ljava/lang/String;)Z

    goto/16 :goto_1

    :catch_0
    move-exception v3

    .local v3, "e":Ljava/lang/NumberFormatException;
    const-string v7, "WfdsService"

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "NumberFormatException: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v7, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # setter for: Lcom/lge/wfds/WfdsService;->mDisplayPin:I
    invoke-static {v7, v8}, Lcom/lge/wfds/WfdsService;->access$3602(Lcom/lge/wfds/WfdsService;I)I

    goto :goto_2

    .end local v3    # "e":Ljava/lang/NumberFormatException;
    :cond_2
    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    iget-object v8, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v8, v8, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v8}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v8

    # invokes: Lcom/lge/wfds/WfdsService;->sendConnectStatus(Lcom/lge/wfds/session/AspSession;I)V
    invoke-static {v7, v8, v12}, Lcom/lge/wfds/WfdsService;->access$5400(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/session/AspSession;I)V

    goto/16 :goto_1

    .end local v0    # "config":Landroid/net/wifi/p2p/WifiP2pConfigEx;
    :sswitch_8
    iget-object v2, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v2, Ljava/lang/String;

    .local v2, "deviceAddr":Ljava/lang/String;
    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v7}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v7

    if-nez v7, :cond_3

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    new-instance v8, Landroid/net/wifi/p2p/WifiP2pConfigEx;

    invoke-direct {v8}, Landroid/net/wifi/p2p/WifiP2pConfigEx;-><init>()V

    # setter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v7, v8}, Lcom/lge/wfds/WfdsService;->access$2902(Lcom/lge/wfds/WfdsService;Landroid/net/wifi/p2p/WifiP2pConfigEx;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v7}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v7

    iput-object v2, v7, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    :cond_3
    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPdDeferred:Z
    invoke-static {v7}, Lcom/lge/wfds/WfdsService;->access$3500(Lcom/lge/wfds/WfdsService;)Z

    move-result v7

    if-ne v7, v9, :cond_4

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->removeProvisionDeferredTimeout()V
    invoke-static {v7}, Lcom/lge/wfds/WfdsService;->access$9600(Lcom/lge/wfds/WfdsService;)V

    :goto_3
    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    iget-object v8, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v8, v8, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v8}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v8

    # invokes: Lcom/lge/wfds/WfdsService;->sendWfdsPersistentResultBroadcast(Lcom/lge/wfds/WfdsDevice;)V
    invoke-static {v7, v8}, Lcom/lge/wfds/WfdsService;->access$6900(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/WfdsDevice;)V

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v8, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mP2pConnectingState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$P2pConnectingState;
    invoke-static {v8}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$6000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$P2pConnectingState;

    move-result-object v8

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v7, v8}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$9900(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    :cond_4
    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->removeProvisionReceivedTimeout()V
    invoke-static {v7}, Lcom/lge/wfds/WfdsService;->access$6200(Lcom/lge/wfds/WfdsService;)V

    goto :goto_3

    .end local v2    # "deviceAddr":Ljava/lang/String;
    :sswitch_9
    const-string v7, "WfdsService"

    const-string v8, "WFDS_PD_DEFERRED/RECEIVED_TIMEOUT"

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->handleProvDiscTimeout()V
    invoke-static {v7}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$10000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v8, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWfdsEnabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;
    invoke-static {v8}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$3300(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;

    move-result-object v8

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v7, v8}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$10100(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    :sswitch_a
    iget-object v5, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v5, Ljava/lang/String;

    .local v5, "peerAddr":Ljava/lang/String;
    const-string v7, "WfdsService"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Received WFDS_PROV_DISC_ACCEPT_EVENT: "

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v7, v8}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->removeProvisionDeferredTimeout()V
    invoke-static {v7}, Lcom/lge/wfds/WfdsService;->access$9600(Lcom/lge/wfds/WfdsService;)V

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v7, v7, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    iget-object v8, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v8, v8, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v8}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v8

    const/4 v10, 0x3

    # invokes: Lcom/lge/wfds/WfdsService;->sendConnectStatus(Lcom/lge/wfds/session/AspSession;I)V
    invoke-static {v7, v8, v10}, Lcom/lge/wfds/WfdsService;->access$5400(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/session/AspSession;I)V

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->dismissAllDialog()V
    invoke-static {v7}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$10200(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V

    goto/16 :goto_1

    .end local v5    # "peerAddr":Ljava/lang/String;
    :sswitch_b
    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->handleProvDiscFailure(Landroid/os/Message;)V
    invoke-static {v7, p1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$7100(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;)V

    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v8, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWfdsEnabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;
    invoke-static {v8}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$3300(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;

    move-result-object v8

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v7, v8}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$10300(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    :sswitch_c
    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;II)V
    invoke-static {v7, p1, v11, v10}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$2000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;II)V

    goto/16 :goto_1

    :sswitch_d
    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;II)V
    invoke-static {v7, p1, v11, v10}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$2000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;II)V

    goto/16 :goto_1

    :sswitch_e
    iget-object v7, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    const v8, 0x900025

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;II)V
    invoke-static {v7, p1, v8, v10}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$2000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;II)V

    goto/16 :goto_1

    :sswitch_data_0
    .sparse-switch
        0x900001 -> :sswitch_c
        0x900004 -> :sswitch_d
        0x900005 -> :sswitch_e
        0x901007 -> :sswitch_0
        0x901008 -> :sswitch_9
        0x901009 -> :sswitch_9
        0x902006 -> :sswitch_a
        0x902007 -> :sswitch_b
        0x902008 -> :sswitch_2
        0x902009 -> :sswitch_3
        0x90200a -> :sswitch_4
        0x90200b -> :sswitch_6
        0x90200c -> :sswitch_5
        0x90200d -> :sswitch_8
        0x90200f -> :sswitch_1
        0x902011 -> :sswitch_7
    .end sparse-switch
.end method
