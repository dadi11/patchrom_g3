.class Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;
.super Lcom/android/internal/util/State;
.source "WfdsService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/wfds/WfdsService$WfdsStateMachine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "WfdsDisabledState"
.end annotation


# instance fields
.field final synthetic this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;


# direct methods
.method constructor <init>(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V
    .locals 0

    .prologue
    .line 605
    iput-object p1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    invoke-direct {p0}, Lcom/android/internal/util/State;-><init>()V

    return-void
.end method


# virtual methods
.method public enter()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 608
    const-string v0, "WfdsService"

    const-string v1, "STATE : WfdsDisabledState - enter"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 609
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # setter for: Lcom/lge/wfds/WfdsService;->mGroupInfo:Landroid/net/wifi/p2p/WifiP2pGroup;
    invoke-static {v0, v2}, Lcom/lge/wfds/WfdsService;->access$202(Lcom/lge/wfds/WfdsService;Landroid/net/wifi/p2p/WifiP2pGroup;)Landroid/net/wifi/p2p/WifiP2pGroup;

    .line 610
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # setter for: Lcom/lge/wfds/WfdsService;->mP2pInfo:Landroid/net/wifi/p2p/WifiP2pInfo;
    invoke-static {v0, v2}, Lcom/lge/wfds/WfdsService;->access$002(Lcom/lge/wfds/WfdsService;Landroid/net/wifi/p2p/WifiP2pInfo;)Landroid/net/wifi/p2p/WifiP2pInfo;

    .line 611
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # setter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v0, v2}, Lcom/lge/wfds/WfdsService;->access$2802(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/WfdsDevice;)Lcom/lge/wfds/WfdsDevice;

    .line 612
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # setter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v0, v2}, Lcom/lge/wfds/WfdsService;->access$2902(Lcom/lge/wfds/WfdsService;Landroid/net/wifi/p2p/WifiP2pConfigEx;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    .line 613
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    const/4 v1, 0x0

    # setter for: Lcom/lge/wfds/WfdsService;->mSuppDisconnectCount:I
    invoke-static {v0, v1}, Lcom/lge/wfds/WfdsService;->access$1802(Lcom/lge/wfds/WfdsService;I)I

    .line 614
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mScanner:Lcom/lge/wfds/WfdsService$Scanner;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsService$Scanner;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 615
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mScanner:Lcom/lge/wfds/WfdsService$Scanner;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsService$Scanner;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/wfds/WfdsService$Scanner;->pause()V

    .line 617
    :cond_0
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsDiscoveryStore:Lcom/lge/wfds/WfdsDiscoveryStore;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3100(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDiscoveryStore;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/wfds/WfdsDiscoveryStore;->clearDiscoveryMap()V

    .line 618
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mSessionController:Lcom/lge/wfds/SessionController;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/SessionController;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 619
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mSessionController:Lcom/lge/wfds/SessionController;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/SessionController;

    move-result-object v0

    const v1, 0x90104b

    invoke-virtual {v0, v1}, Lcom/lge/wfds/SessionController;->sendMessage(I)V

    .line 621
    :cond_1
    return-void
.end method

.method public exit()V
    .locals 0

    .prologue
    .line 652
    return-void
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 3
    .param p1, "message"    # Landroid/os/Message;

    .prologue
    const/4 v0, 0x1

    .line 625
    iget v1, p1, Landroid/os/Message;->what:I

    sparse-switch v1, :sswitch_data_0

    .line 645
    const/4 v0, 0x0

    .line 647
    :cond_0
    :goto_0
    return v0

    .line 627
    :sswitch_0
    const-string v1, "WfdsService"

    const-string v2, "Receive the WFDS_ENABLE Method"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 628
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v1, v1, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->setWfdsMonitor(Z)V
    invoke-static {v1, v0}, Lcom/lge/wfds/WfdsService;->access$1700(Lcom/lge/wfds/WfdsService;Z)V

    goto :goto_0

    .line 632
    :sswitch_1
    const-string v1, "WfdsService"

    const-string v2, "Connected to the supplicant for wfds"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 633
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v1, v1, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWifiP2pEnabled:Z
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$900(Lcom/lge/wfds/WfdsService;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 634
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v1, v1, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/lge/wfds/WfdsNative;->setWfdsEnabled(Z)Z

    .line 635
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v1, v1, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # setter for: Lcom/lge/wfds/WfdsService;->mWfdsMonitorConnected:Z
    invoke-static {v1, v0}, Lcom/lge/wfds/WfdsService;->access$1602(Lcom/lge/wfds/WfdsService;Z)Z

    .line 636
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWfdsEnabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$3300(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;

    move-result-object v2

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$3400(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    goto :goto_0

    .line 641
    :sswitch_2
    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v1, v1, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v2, v2, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsMonitor:Lcom/lge/wfds/WfdsMonitor;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$1500(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsMonitor;

    move-result-object v2

    invoke-virtual {v2}, Lcom/lge/wfds/WfdsMonitor;->getScanAlwaysAvailable()Z

    move-result v2

    # invokes: Lcom/lge/wfds/WfdsService;->setWfdsMonitor(Z)V
    invoke-static {v1, v2}, Lcom/lge/wfds/WfdsService;->access$1700(Lcom/lge/wfds/WfdsService;Z)V

    goto :goto_0

    .line 625
    :sswitch_data_0
    .sparse-switch
        0x901002 -> :sswitch_0
        0x90100b -> :sswitch_2
        0x902001 -> :sswitch_1
    .end sparse-switch
.end method
