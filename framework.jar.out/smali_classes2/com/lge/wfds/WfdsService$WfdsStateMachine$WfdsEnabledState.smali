.class Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;
.super Lcom/android/internal/util/State;
.source "WfdsService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/wfds/WfdsService$WfdsStateMachine;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "WfdsEnabledState"
.end annotation


# instance fields
.field final synthetic this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;


# direct methods
.method constructor <init>(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V
    .locals 0

    .prologue
    .line 655
    iput-object p1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    invoke-direct {p0}, Lcom/android/internal/util/State;-><init>()V

    return-void
.end method

.method private processProvDiscReq(Lcom/lge/wfds/WfdsDevice;)V
    .locals 7
    .param p1, "dev"    # Lcom/lge/wfds/WfdsDevice;

    .prologue
    .line 956
    if-eqz p1, :cond_3

    .line 957
    iget-object v0, p1, Lcom/lge/wfds/WfdsDevice;->wfdsInfo:Lcom/lge/wfds/WfdsInfo;

    if-eqz v0, :cond_2

    .line 958
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mScanner:Lcom/lge/wfds/WfdsService$Scanner;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsService$Scanner;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 959
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mScanner:Lcom/lge/wfds/WfdsService$Scanner;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsService$Scanner;

    move-result-object v0

    invoke-virtual {v0}, Lcom/lge/wfds/WfdsService$Scanner;->pause()V

    .line 965
    :cond_0
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v6, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    new-instance v0, Lcom/lge/wfds/session/AspSession;

    iget-object v1, p1, Lcom/lge/wfds/WfdsDevice;->deviceAddress:Ljava/lang/String;

    iget-object v2, p1, Lcom/lge/wfds/WfdsDevice;->wfdsInfo:Lcom/lge/wfds/WfdsInfo;

    iget-object v2, v2, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionMac:Ljava/lang/String;

    iget-object v3, p1, Lcom/lge/wfds/WfdsDevice;->wfdsInfo:Lcom/lge/wfds/WfdsInfo;

    iget v3, v3, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionId:I

    iget-object v4, p1, Lcom/lge/wfds/WfdsDevice;->wfdsInfo:Lcom/lge/wfds/WfdsInfo;

    iget v4, v4, Lcom/lge/wfds/WfdsInfo;->mWfdsAdvertiseId:I

    iget-object v5, p1, Lcom/lge/wfds/WfdsDevice;->wfdsInfo:Lcom/lge/wfds/WfdsInfo;

    iget-object v5, v5, Lcom/lge/wfds/WfdsInfo;->mWfdsSessionInfo:Ljava/lang/String;

    invoke-direct/range {v0 .. v5}, Lcom/lge/wfds/session/AspSession;-><init>(Ljava/lang/String;Ljava/lang/String;IILjava/lang/String;)V

    # setter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v6, v0}, Lcom/lge/wfds/WfdsService;->access$5302(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/session/AspSession;)Lcom/lge/wfds/session/AspSession;

    .line 974
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # setter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static {v0, p1}, Lcom/lge/wfds/WfdsService;->access$2802(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/WfdsDevice;)Lcom/lge/wfds/WfdsDevice;

    .line 975
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v0

    if-nez v0, :cond_1

    .line 976
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    new-instance v1, Landroid/net/wifi/p2p/WifiP2pConfigEx;

    invoke-direct {v1}, Landroid/net/wifi/p2p/WifiP2pConfigEx;-><init>()V

    # setter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v0, v1}, Lcom/lge/wfds/WfdsService;->access$2902(Lcom/lge/wfds/WfdsService;Landroid/net/wifi/p2p/WifiP2pConfigEx;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    .line 978
    :cond_1
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v0

    iget-object v1, p1, Lcom/lge/wfds/WfdsDevice;->deviceAddress:Ljava/lang/String;

    iput-object v1, v0, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    .line 980
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsEvent:Lcom/lge/wfds/WfdsEvent;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$4300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsEvent;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/lge/wfds/WfdsEvent;->notifyConnectSessionRequestToService(Lcom/lge/wfds/WfdsDevice;)V

    .line 988
    :goto_0
    return-void

    .line 982
    :cond_2
    const-string v0, "WfdsService"

    const-string v1, "processProvDiscReq : wfdsInfo is NULL"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 985
    :cond_3
    const-string v0, "WfdsService"

    const-string v1, "processProvDiscReq : dev is NULL"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method


# virtual methods
.method public enter()V
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 659
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # setter for: Lcom/lge/wfds/WfdsService;->mPdDeferred:Z
    invoke-static {v0, v1}, Lcom/lge/wfds/WfdsService;->access$3502(Lcom/lge/wfds/WfdsService;Z)Z

    .line 660
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # setter for: Lcom/lge/wfds/WfdsService;->mDisplayPin:I
    invoke-static {v0, v1}, Lcom/lge/wfds/WfdsService;->access$3602(Lcom/lge/wfds/WfdsService;I)I

    .line 661
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->resetWfdsTimer()V
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3700(Lcom/lge/wfds/WfdsService;)V

    .line 662
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mThisDeviceAddress:Ljava/lang/String;
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3800(Lcom/lge/wfds/WfdsService;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    .line 663
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    iget-object v1, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v1, v1, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static {v1}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/wfds/WfdsNative;->getP2pMacAddress()Ljava/lang/String;

    move-result-object v1

    # setter for: Lcom/lge/wfds/WfdsService;->mThisDeviceAddress:Ljava/lang/String;
    invoke-static {v0, v1}, Lcom/lge/wfds/WfdsService;->access$3802(Lcom/lge/wfds/WfdsService;Ljava/lang/String;)Ljava/lang/String;

    .line 665
    :cond_0
    iget-object v0, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # invokes: Lcom/lge/wfds/WfdsService;->selectPreferredScanChannel()V
    invoke-static {v0}, Lcom/lge/wfds/WfdsService;->access$3900(Lcom/lge/wfds/WfdsService;)V

    .line 666
    const-string v0, "WfdsService"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "STATE : WfdsEnabledState - enter: this device mac "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    iget-object v2, v2, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    # getter for: Lcom/lge/wfds/WfdsService;->mThisDeviceAddress:Ljava/lang/String;
    invoke-static {v2}, Lcom/lge/wfds/WfdsService;->access$3800(Lcom/lge/wfds/WfdsService;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 667
    return-void
.end method

.method public exit()V
    .locals 0

    .prologue
    .line 993
    return-void
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 24
    .param p1, "message"    # Landroid/os/Message;

    .prologue
    .line 671
    move-object/from16 v0, p1

    iget v0, v0, Landroid/os/Message;->what:I

    move/from16 v20, v0

    sparse-switch v20, :sswitch_data_0

    .line 950
    const/16 v20, 0x0

    .line 952
    :goto_0
    return v20

    .line 673
    :sswitch_0
    const-string v20, "WfdsService"

    const-string v21, "Received the Event that WfdsMonitor is connected to supplicant"

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 674
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    const/16 v21, 0x1

    # setter for: Lcom/lge/wfds/WfdsService;->mWfdsMonitorConnected:Z
    invoke-static/range {v20 .. v21}, Lcom/lge/wfds/WfdsService;->access$1602(Lcom/lge/wfds/WfdsService;Z)Z

    .line 952
    :cond_0
    :goto_1
    :sswitch_1
    const/16 v20, 0x1

    goto :goto_0

    .line 678
    :sswitch_2
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsMonitorConnected:Z
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$1600(Lcom/lge/wfds/WfdsService;)Z

    move-result v20

    if-eqz v20, :cond_0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # operator++ for: Lcom/lge/wfds/WfdsService;->mSuppDisconnectCount:I
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$1808(Lcom/lge/wfds/WfdsService;)I

    move-result v20

    const/16 v21, 0x5

    move/from16 v0, v20

    move/from16 v1, v21

    if-lt v0, v1, :cond_0

    .line 682
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    const/16 v21, 0x0

    const/16 v22, 0x1

    # invokes: Lcom/lge/wfds/WfdsService;->setWfdsMonitor(ZZ)V
    invoke-static/range {v20 .. v22}, Lcom/lge/wfds/WfdsService;->access$1900(Lcom/lge/wfds/WfdsService;ZZ)V

    .line 683
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    const/16 v21, 0x0

    # setter for: Lcom/lge/wfds/WfdsService;->mWfdsMonitorConnected:Z
    invoke-static/range {v20 .. v21}, Lcom/lge/wfds/WfdsService;->access$1602(Lcom/lge/wfds/WfdsService;Z)Z

    .line 684
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    const/16 v21, 0x0

    # setter for: Lcom/lge/wfds/WfdsService;->mSuppDisconnectCount:I
    invoke-static/range {v20 .. v21}, Lcom/lge/wfds/WfdsService;->access$1802(Lcom/lge/wfds/WfdsService;I)I

    .line 685
    const-string v20, "WfdsService"

    const-string v21, "Received WFDS_SUPPLICANT_TERMINATING Event, so close the sockets related with supplicant"

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 691
    :sswitch_3
    const-string v20, "WfdsService"

    const-string v21, "Do not process WFDS_SCAN_ALWAYS_MODE_CHANGES event in WfdsEnabledState"

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 695
    :sswitch_4
    const-string v20, "WfdsService"

    const-string v21, "WfdsEnabledState: Receive the WFDS_DISABLE message"

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 696
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    const/16 v21, 0x0

    # invokes: Lcom/lge/wfds/WfdsService;->setWfdsMonitor(Z)V
    invoke-static/range {v20 .. v21}, Lcom/lge/wfds/WfdsService;->access$1700(Lcom/lge/wfds/WfdsService;Z)V

    .line 697
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v21, v0

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWfdsDisabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;
    invoke-static/range {v21 .. v21}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$4000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsDisabledState;

    move-result-object v21

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static/range {v20 .. v21}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$4100(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    .line 702
    :sswitch_5
    move-object/from16 v0, p1

    iget-object v9, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v9, Ljava/lang/String;

    .line 703
    .local v9, "eventStr":Ljava/lang/String;
    const-string v20, " "

    move-object/from16 v0, v20

    invoke-virtual {v9, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v19

    .line 705
    .local v19, "token":[Ljava/lang/String;
    move-object/from16 v0, v19

    array-length v0, v0

    move/from16 v20, v0

    const/16 v21, 0x3

    move/from16 v0, v20

    move/from16 v1, v21

    if-lt v0, v1, :cond_0

    .line 706
    const/16 v20, 0x2

    const/16 v21, 0x2

    aget-object v21, v19, v21

    const-string v22, "p2p_dev_addr="

    const-string v23, ""

    invoke-virtual/range {v21 .. v23}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v21

    aput-object v21, v19, v20

    .line 708
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v20

    if-eqz v20, :cond_0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v20

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsDevice;->deviceAddress:Ljava/lang/String;

    move-object/from16 v20, v0

    const/16 v21, 0x2

    aget-object v21, v19, v21

    invoke-virtual/range {v20 .. v21}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v20

    if-eqz v20, :cond_0

    .line 710
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v20

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsDevice;->wfdsInfo:Lcom/lge/wfds/WfdsInfo;

    move-object/from16 v20, v0

    if-nez v20, :cond_1

    .line 711
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v20

    new-instance v21, Lcom/lge/wfds/WfdsInfo;

    invoke-direct/range {v21 .. v21}, Lcom/lge/wfds/WfdsInfo;-><init>()V

    move-object/from16 v0, v21

    move-object/from16 v1, v20

    iput-object v0, v1, Lcom/lge/wfds/WfdsDevice;->wfdsInfo:Lcom/lge/wfds/WfdsInfo;

    .line 713
    :cond_1
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v20

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsDevice;->wfdsInfo:Lcom/lge/wfds/WfdsInfo;

    move-object/from16 v20, v0

    const/16 v21, 0x1

    aget-object v21, v19, v21

    move-object/from16 v0, v21

    move-object/from16 v1, v20

    iput-object v0, v1, Lcom/lge/wfds/WfdsInfo;->mWfdsInterfaceAddress:Ljava/lang/String;

    goto/16 :goto_1

    .line 721
    .end local v9    # "eventStr":Ljava/lang/String;
    .end local v19    # "token":[Ljava/lang/String;
    :sswitch_6
    move-object/from16 v0, p1

    iget-object v7, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v7, Lcom/lge/wfds/WfdsDevice;

    .line 722
    .local v7, "device":Lcom/lge/wfds/WfdsDevice;
    if-eqz v7, :cond_0

    iget-object v0, v7, Lcom/lge/wfds/WfdsDevice;->deviceAddress:Ljava/lang/String;

    move-object/from16 v20, v0

    if-eqz v20, :cond_0

    .line 723
    const-string v20, "WfdsService"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "WFDS device is found ["

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    iget-object v0, v7, Lcom/lge/wfds/WfdsDevice;->deviceAddress:Ljava/lang/String;

    move-object/from16 v22, v0

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, "]"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 724
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsPeerList:Lcom/lge/wfds/WfdsPeerList;
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$1000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsPeerList;

    move-result-object v20

    move-object/from16 v0, v20

    invoke-virtual {v0, v7}, Lcom/lge/wfds/WfdsPeerList;->addPeerDevice(Lcom/lge/wfds/WfdsDevice;)V

    .line 726
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    # invokes: Lcom/lge/wfds/WfdsService;->sendWfdsPeersChangedBroadcast(Lcom/lge/wfds/WfdsDevice;)V
    invoke-static {v0, v7}, Lcom/lge/wfds/WfdsService;->access$4200(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/WfdsDevice;)V

    .line 729
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsEvent:Lcom/lge/wfds/WfdsEvent;
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$4300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsEvent;

    move-result-object v20

    const/16 v21, 0x1

    move-object/from16 v0, v20

    move/from16 v1, v21

    invoke-virtual {v0, v1, v7}, Lcom/lge/wfds/WfdsEvent;->notifySearchResultToService(ILcom/lge/wfds/WfdsDevice;)V

    goto/16 :goto_1

    .line 735
    .end local v7    # "device":Lcom/lge/wfds/WfdsDevice;
    :sswitch_7
    move-object/from16 v0, p1

    iget-object v0, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    move-object/from16 v20, v0

    check-cast v20, Ljava/lang/String;

    if-eqz v20, :cond_0

    .line 736
    move-object/from16 v0, p1

    iget-object v15, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v15, Ljava/lang/String;

    .line 738
    .local v15, "peerAddr":Ljava/lang/String;
    const-string v20, "WfdsService"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "WFDS device is lost ["

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    move-object/from16 v0, v21

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, "]"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 740
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsPeerList:Lcom/lge/wfds/WfdsPeerList;
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$1000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsPeerList;

    move-result-object v20

    move-object/from16 v0, v20

    invoke-virtual {v0, v15}, Lcom/lge/wfds/WfdsPeerList;->getPeerDevice(Ljava/lang/String;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v12

    .line 741
    .local v12, "lostDevice":Lcom/lge/wfds/WfdsDevice;
    if-eqz v12, :cond_0

    .line 742
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsPeerList:Lcom/lge/wfds/WfdsPeerList;
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$1000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsPeerList;

    move-result-object v20

    move-object/from16 v0, v20

    invoke-virtual {v0, v12}, Lcom/lge/wfds/WfdsPeerList;->removePeerDevice(Lcom/lge/wfds/WfdsDevice;)V

    .line 744
    iget-object v11, v12, Lcom/lge/wfds/WfdsDevice;->wfdsInfo:Lcom/lge/wfds/WfdsInfo;

    .line 745
    .local v11, "localDevWfdsInfo":Lcom/lge/wfds/WfdsInfo;
    if-eqz v11, :cond_2

    .line 746
    const/16 v20, 0x2

    move/from16 v0, v20

    iput v0, v11, Lcom/lge/wfds/WfdsInfo;->mWfdsServiceStatus:I

    .line 747
    iput-object v11, v12, Lcom/lge/wfds/WfdsDevice;->wfdsInfo:Lcom/lge/wfds/WfdsInfo;

    .line 748
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsEvent:Lcom/lge/wfds/WfdsEvent;
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$4300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsEvent;

    move-result-object v20

    const/16 v21, 0x1

    move-object/from16 v0, v20

    move/from16 v1, v21

    invoke-virtual {v0, v1, v12}, Lcom/lge/wfds/WfdsEvent;->notifySearchResultToService(ILcom/lge/wfds/WfdsDevice;)V

    .line 750
    :cond_2
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    # invokes: Lcom/lge/wfds/WfdsService;->sendWfdsPeerLostBroadcast(Ljava/lang/String;)V
    invoke-static {v0, v15}, Lcom/lge/wfds/WfdsService;->access$4400(Lcom/lge/wfds/WfdsService;Ljava/lang/String;)V

    goto/16 :goto_1

    .line 756
    .end local v11    # "localDevWfdsInfo":Lcom/lge/wfds/WfdsInfo;
    .end local v12    # "lostDevice":Lcom/lge/wfds/WfdsDevice;
    .end local v15    # "peerAddr":Ljava/lang/String;
    :sswitch_8
    const-string v20, "WfdsService"

    const-string v21, "Receive the ADVERTISE_SERVICE Method"

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 757
    invoke-virtual/range {p1 .. p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v20

    const-class v21, Lcom/lge/wfds/WfdsDiscoveryMethod;

    invoke-virtual/range {v21 .. v21}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v21

    invoke-virtual/range {v20 .. v21}, Landroid/os/Bundle;->setClassLoader(Ljava/lang/ClassLoader;)V

    .line 758
    invoke-virtual/range {p1 .. p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v20

    const/16 v21, 0x0

    invoke-virtual/range {v20 .. v21}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v4

    check-cast v4, Lcom/lge/wfds/WfdsDiscoveryMethod;

    .line 760
    .local v4, "advMethod":Lcom/lge/wfds/WfdsDiscoveryMethod;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    const/16 v21, 0x0

    move-object/from16 v0, v20

    move-object/from16 v1, p1

    move/from16 v2, v21

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->enableAdvertiseService(Landroid/os/Message;Lcom/lge/wfds/WfdsDiscoveryMethod;Z)V
    invoke-static {v0, v1, v4, v2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$4500(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;Lcom/lge/wfds/WfdsDiscoveryMethod;Z)V

    goto/16 :goto_1

    .line 764
    .end local v4    # "advMethod":Lcom/lge/wfds/WfdsDiscoveryMethod;
    :sswitch_9
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, p1

    iget v0, v0, Landroid/os/Message;->arg1:I

    move/from16 v21, v0

    move-object/from16 v0, v20

    move-object/from16 v1, p1

    move/from16 v2, v21

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->cancelAdvertiseService(Landroid/os/Message;I)V
    invoke-static {v0, v1, v2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$4600(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;I)V

    goto/16 :goto_1

    .line 769
    :sswitch_a
    const-string v20, "WfdsService"

    const-string v21, "Receive the SERVICE_STATUS_CHANGE"

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 770
    move-object/from16 v0, p1

    iget v10, v0, Landroid/os/Message;->arg1:I

    .line 771
    .local v10, "id":I
    invoke-virtual/range {p1 .. p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v20

    const-class v21, Lcom/lge/wfds/WfdsDiscoveryMethod;

    invoke-virtual/range {v21 .. v21}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v21

    invoke-virtual/range {v20 .. v21}, Landroid/os/Bundle;->setClassLoader(Ljava/lang/ClassLoader;)V

    .line 772
    invoke-virtual/range {p1 .. p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v20

    const/16 v21, 0x0

    invoke-virtual/range {v20 .. v21}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v13

    check-cast v13, Lcom/lge/wfds/WfdsDiscoveryMethod;

    .line 774
    .local v13, "method":Lcom/lge/wfds/WfdsDiscoveryMethod;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v21, v0

    # invokes: Lcom/lge/wfds/WfdsService;->getScanOnlyChannel()I
    invoke-static/range {v21 .. v21}, Lcom/lge/wfds/WfdsService;->access$2500(Lcom/lge/wfds/WfdsService;)I

    move-result v21

    move-object/from16 v0, v20

    move-object/from16 v1, p1

    move/from16 v2, v21

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->changeServiceStatus(Landroid/os/Message;ILcom/lge/wfds/WfdsDiscoveryMethod;I)V
    invoke-static {v0, v1, v10, v13, v2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$4700(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;ILcom/lge/wfds/WfdsDiscoveryMethod;I)V

    goto/16 :goto_1

    .line 779
    .end local v10    # "id":I
    .end local v13    # "method":Lcom/lge/wfds/WfdsDiscoveryMethod;
    :sswitch_b
    const-string v20, "WfdsService"

    const-string v21, "WfdsEnabledState - Receive the SEEK_SERVICE Method"

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 780
    invoke-virtual/range {p1 .. p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v20

    const-class v21, Lcom/lge/wfds/WfdsDiscoveryMethod;

    invoke-virtual/range {v21 .. v21}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v21

    invoke-virtual/range {v20 .. v21}, Landroid/os/Bundle;->setClassLoader(Ljava/lang/ClassLoader;)V

    .line 781
    invoke-virtual/range {p1 .. p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v20

    const/16 v21, 0x0

    invoke-virtual/range {v20 .. v21}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v17

    check-cast v17, Lcom/lge/wfds/WfdsDiscoveryMethod;

    .line 783
    .local v17, "seekMethod":Lcom/lge/wfds/WfdsDiscoveryMethod;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    const/16 v21, 0x0

    move-object/from16 v0, v20

    move-object/from16 v1, p1

    move-object/from16 v2, v17

    move/from16 v3, v21

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->enableSeekService(Landroid/os/Message;Lcom/lge/wfds/WfdsDiscoveryMethod;Z)V
    invoke-static {v0, v1, v2, v3}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$4800(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;Lcom/lge/wfds/WfdsDiscoveryMethod;Z)V

    goto/16 :goto_1

    .line 787
    .end local v17    # "seekMethod":Lcom/lge/wfds/WfdsDiscoveryMethod;
    :sswitch_c
    const-string v20, "WfdsService"

    const-string v21, "Receive the CANCEL_SEEK_SERVICE"

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 788
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, p1

    iget v0, v0, Landroid/os/Message;->arg1:I

    move/from16 v21, v0

    move-object/from16 v0, v20

    move-object/from16 v1, p1

    move/from16 v2, v21

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->cancelSeekService(Landroid/os/Message;I)V
    invoke-static {v0, v1, v2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$4900(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;I)V

    goto/16 :goto_1

    .line 792
    :sswitch_d
    const-string v20, "WfdsService"

    const-string v21, "Received the CONNECT_SESSION cmd"

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 793
    invoke-virtual/range {p1 .. p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v20

    const-class v21, Lcom/lge/wfds/WfdsPdMethod;

    invoke-virtual/range {v21 .. v21}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v21

    invoke-virtual/range {v20 .. v21}, Landroid/os/Bundle;->setClassLoader(Ljava/lang/ClassLoader;)V

    .line 794
    invoke-virtual/range {p1 .. p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v20

    const/16 v21, 0x0

    invoke-virtual/range {v20 .. v21}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v14

    check-cast v14, Lcom/lge/wfds/WfdsPdMethod;

    .line 795
    .local v14, "pdMethod":Lcom/lge/wfds/WfdsPdMethod;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    const/16 v21, 0x0

    move-object/from16 v0, v20

    move-object/from16 v1, p1

    move/from16 v2, v21

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->connectSession(Landroid/os/Message;Lcom/lge/wfds/WfdsPdMethod;Z)Z
    invoke-static {v0, v1, v14, v2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$5000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;Lcom/lge/wfds/WfdsPdMethod;Z)Z

    move-result v20

    const/16 v21, 0x1

    move/from16 v0, v20

    move/from16 v1, v21

    if-eq v0, v1, :cond_3

    .line 796
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    const v21, 0x900025

    const/16 v22, 0x2

    move-object/from16 v0, v20

    move-object/from16 v1, p1

    move/from16 v2, v21

    move/from16 v3, v22

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;II)V
    invoke-static {v0, v1, v2, v3}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$2000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;II)V

    goto/16 :goto_1

    .line 800
    :cond_3
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v21, v0

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mProvisionState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;
    invoke-static/range {v21 .. v21}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$5100(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionState;

    move-result-object v21

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static/range {v20 .. v21}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$5200(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    .line 804
    .end local v14    # "pdMethod":Lcom/lge/wfds/WfdsPdMethod;
    :sswitch_e
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v21, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mLatestAspSession:Lcom/lge/wfds/session/AspSession;
    invoke-static/range {v21 .. v21}, Lcom/lge/wfds/WfdsService;->access$5300(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/session/AspSession;

    move-result-object v21

    const/16 v22, 0x1

    # invokes: Lcom/lge/wfds/WfdsService;->sendConnectStatus(Lcom/lge/wfds/session/AspSession;I)V
    invoke-static/range {v20 .. v22}, Lcom/lge/wfds/WfdsService;->access$5400(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/session/AspSession;I)V

    goto/16 :goto_1

    .line 808
    :sswitch_f
    move-object/from16 v0, p1

    iget-object v6, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v6, Lcom/lge/wfds/WfdsDevice;

    .line 809
    .local v6, "dev":Lcom/lge/wfds/WfdsDevice;
    move-object/from16 v0, p0

    invoke-direct {v0, v6}, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->processProvDiscReq(Lcom/lge/wfds/WfdsDevice;)V

    goto/16 :goto_1

    .line 813
    .end local v6    # "dev":Lcom/lge/wfds/WfdsDevice;
    :sswitch_10
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v21, v0

    move-object/from16 v0, p1

    iget-object v0, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    move-object/from16 v20, v0

    check-cast v20, Ljava/lang/String;

    move-object/from16 v0, v21

    move-object/from16 v1, v20

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->processProvDiscDefaultPin(Ljava/lang/String;)V
    invoke-static {v0, v1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$5500(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Ljava/lang/String;)V

    .line 814
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mAutonomousGroup:Z
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$5600(Lcom/lge/wfds/WfdsService;)Z

    move-result v20

    if-eqz v20, :cond_4

    .line 815
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # invokes: Lcom/lge/wfds/WfdsService;->setConnectionTimeout()V
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$5700(Lcom/lge/wfds/WfdsService;)V

    .line 816
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v21, v0

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mAutonomousGoState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$AutonomousGoState;
    invoke-static/range {v21 .. v21}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$5800(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$AutonomousGoState;

    move-result-object v21

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static/range {v20 .. v21}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$5900(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    .line 818
    :cond_4
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v21, v0

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mP2pConnectingState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$P2pConnectingState;
    invoke-static/range {v21 .. v21}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$6000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$P2pConnectingState;

    move-result-object v21

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static/range {v20 .. v21}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$6100(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    .line 823
    :sswitch_11
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # invokes: Lcom/lge/wfds/WfdsService;->removeProvisionReceivedTimeout()V
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$6200(Lcom/lge/wfds/WfdsService;)V

    .line 825
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v21, v0

    move-object/from16 v0, p1

    iget-object v0, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    move-object/from16 v20, v0

    check-cast v20, Ljava/lang/String;

    const/16 v22, 0x1

    move-object/from16 v0, v21

    move-object/from16 v1, v20

    move/from16 v2, v22

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->processProvDiscDisplay(Ljava/lang/String;Z)Z
    invoke-static {v0, v1, v2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$6300(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Ljava/lang/String;Z)Z

    move-result v20

    if-eqz v20, :cond_0

    .line 826
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v21, v0

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mP2pConnectingState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$P2pConnectingState;
    invoke-static/range {v21 .. v21}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$6000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$P2pConnectingState;

    move-result-object v21

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static/range {v20 .. v21}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$6400(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    .line 831
    :sswitch_12
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v21, v0

    move-object/from16 v0, p1

    iget-object v0, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    move-object/from16 v20, v0

    check-cast v20, Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-object/from16 v0, v21

    move-object/from16 v1, v20

    # setter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static {v0, v1}, Lcom/lge/wfds/WfdsService;->access$2902(Lcom/lge/wfds/WfdsService;Landroid/net/wifi/p2p/WifiP2pConfigEx;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    .line 832
    const-string v20, "WfdsService"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "Advertiser: DEFER_EVENT: "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v22, v0

    move-object/from16 v0, v22

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static/range {v22 .. v22}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Landroid/net/wifi/p2p/WifiP2pConfigEx;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 833
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v21, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsPeerList:Lcom/lge/wfds/WfdsPeerList;
    invoke-static/range {v21 .. v21}, Lcom/lge/wfds/WfdsService;->access$1000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsPeerList;

    move-result-object v21

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v22, v0

    move-object/from16 v0, v22

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static/range {v22 .. v22}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v22

    move-object/from16 v0, v22

    iget-object v0, v0, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    move-object/from16 v22, v0

    invoke-virtual/range {v21 .. v22}, Lcom/lge/wfds/WfdsPeerList;->getPeerDevice(Ljava/lang/String;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v21

    # setter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static/range {v20 .. v21}, Lcom/lge/wfds/WfdsService;->access$2802(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/WfdsDevice;)Lcom/lge/wfds/WfdsDevice;

    .line 834
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v20

    if-nez v20, :cond_5

    .line 835
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v21, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsPeerList:Lcom/lge/wfds/WfdsPeerList;
    invoke-static/range {v21 .. v21}, Lcom/lge/wfds/WfdsService;->access$1000(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsPeerList;

    move-result-object v21

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v22, v0

    move-object/from16 v0, v22

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static/range {v22 .. v22}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v22

    move-object/from16 v0, v22

    iget-object v0, v0, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    move-object/from16 v22, v0

    invoke-virtual/range {v21 .. v22}, Lcom/lge/wfds/WfdsPeerList;->getP2pPeerDevice(Ljava/lang/String;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v21

    # setter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static/range {v20 .. v21}, Lcom/lge/wfds/WfdsService;->access$2802(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/WfdsDevice;)Lcom/lge/wfds/WfdsDevice;

    .line 838
    :cond_5
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v20

    move-object/from16 v0, v20

    iget-object v0, v0, Landroid/net/wifi/p2p/WifiP2pConfigEx;->wps:Landroid/net/wifi/WpsInfo;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget v0, v0, Landroid/net/wifi/WpsInfo;->setup:I

    move/from16 v20, v0

    const/16 v21, 0x5

    move/from16 v0, v20

    move/from16 v1, v21

    if-ne v0, v1, :cond_6

    .line 839
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsDialog:Lcom/lge/wfds/WfdsDialog;
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$6500(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDialog;

    move-result-object v20

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v21, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static/range {v21 .. v21}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v21

    move-object/from16 v0, v21

    iget-object v0, v0, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    move-object/from16 v21, v0

    invoke-virtual/range {v20 .. v21}, Lcom/lge/wfds/WfdsDialog;->showProvDeferUserInputDialog(Ljava/lang/String;)Z

    move-result v20

    if-eqz v20, :cond_0

    .line 840
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v21, v0

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mProvisionDeferredState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionDeferredState;
    invoke-static/range {v21 .. v21}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$6600(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionDeferredState;

    move-result-object v21

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static/range {v20 .. v21}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$6700(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    .line 842
    :cond_6
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v20

    move-object/from16 v0, v20

    iget-object v0, v0, Landroid/net/wifi/p2p/WifiP2pConfigEx;->wps:Landroid/net/wifi/WpsInfo;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget v0, v0, Landroid/net/wifi/WpsInfo;->setup:I

    move/from16 v20, v0

    const/16 v21, 0x2

    move/from16 v0, v20

    move/from16 v1, v21

    if-ne v0, v1, :cond_0

    .line 843
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsDialog:Lcom/lge/wfds/WfdsDialog;
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$6500(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDialog;

    move-result-object v20

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v21, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static/range {v21 .. v21}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v21

    move-object/from16 v0, v21

    iget-object v0, v0, Landroid/net/wifi/p2p/WifiP2pConfigEx;->deviceAddress:Ljava/lang/String;

    move-object/from16 v21, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v22, v0

    move-object/from16 v0, v22

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerConfigEx:Landroid/net/wifi/p2p/WifiP2pConfigEx;
    invoke-static/range {v22 .. v22}, Lcom/lge/wfds/WfdsService;->access$2900(Lcom/lge/wfds/WfdsService;)Landroid/net/wifi/p2p/WifiP2pConfigEx;

    move-result-object v22

    move-object/from16 v0, v22

    iget-object v0, v0, Landroid/net/wifi/p2p/WifiP2pConfigEx;->wps:Landroid/net/wifi/WpsInfo;

    move-object/from16 v22, v0

    invoke-virtual/range {v20 .. v22}, Lcom/lge/wfds/WfdsDialog;->showProvDiscEnterPinDialog(Ljava/lang/String;Landroid/net/wifi/WpsInfo;)Z

    move-result v20

    if-eqz v20, :cond_0

    .line 845
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v21, v0

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mProvisionDeferredState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionDeferredState;
    invoke-static/range {v21 .. v21}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$6600(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$ProvisionDeferredState;

    move-result-object v21

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static/range {v20 .. v21}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$6800(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    .line 851
    :sswitch_13
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v21, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mPeerDevice:Lcom/lge/wfds/WfdsDevice;
    invoke-static/range {v21 .. v21}, Lcom/lge/wfds/WfdsService;->access$2800(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDevice;

    move-result-object v21

    # invokes: Lcom/lge/wfds/WfdsService;->sendWfdsPersistentResultBroadcast(Lcom/lge/wfds/WfdsDevice;)V
    invoke-static/range {v20 .. v21}, Lcom/lge/wfds/WfdsService;->access$6900(Lcom/lge/wfds/WfdsService;Lcom/lge/wfds/WfdsDevice;)V

    .line 852
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v21, v0

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mP2pConnectingState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$P2pConnectingState;
    invoke-static/range {v21 .. v21}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$6000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$P2pConnectingState;

    move-result-object v21

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static/range {v20 .. v21}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$7000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    .line 856
    :sswitch_14
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    move-object/from16 v1, p1

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->handleProvDiscFailure(Landroid/os/Message;)V
    invoke-static {v0, v1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$7100(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;)V

    goto/16 :goto_1

    .line 860
    :sswitch_15
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v21, v0

    move-object/from16 v0, p1

    iget-object v0, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    move-object/from16 v20, v0

    check-cast v20, Ljava/lang/String;

    move-object/from16 v0, v21

    move-object/from16 v1, v20

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->processPersistentUnknown(Ljava/lang/String;)V
    invoke-static {v0, v1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$7200(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Ljava/lang/String;)V

    goto/16 :goto_1

    .line 864
    :sswitch_16
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->processP2pGroupFormationFailure()V
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$7300(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)V

    goto/16 :goto_1

    .line 873
    :sswitch_17
    move-object/from16 v0, p1

    iget v0, v0, Landroid/os/Message;->arg1:I

    move/from16 v16, v0

    .line 874
    .local v16, "reason":I
    const-string v20, "WfdsService"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "Connection Failed: "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    move-object/from16 v0, v21

    move/from16 v1, v16

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 875
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Lcom/lge/wfds/WfdsNative;->clearPdInformation()Ljava/lang/String;

    move-result-object v15

    .line 876
    .restart local v15    # "peerAddr":Ljava/lang/String;
    if-eqz v15, :cond_7

    .line 877
    const-string v20, "WfdsService"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "Connection failed with "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    move-object/from16 v0, v21

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 881
    :cond_7
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v21, v0

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWfdsEnabledState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;
    invoke-static/range {v21 .. v21}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$3300(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;

    move-result-object v21

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static/range {v20 .. v21}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$7400(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    .line 886
    .end local v15    # "peerAddr":Ljava/lang/String;
    .end local v16    # "reason":I
    :sswitch_18
    const-string v20, "WfdsService"

    const-string v21, "It is not a connection between Wfds devices"

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 887
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v21, v0

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mWifiP2pConnectedState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$WifiP2pConnectedState;
    invoke-static/range {v21 .. v21}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$7500(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$WifiP2pConnectedState;

    move-result-object v21

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static/range {v20 .. v21}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$7600(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    .line 892
    :sswitch_19
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, p1

    iget v0, v0, Landroid/os/Message;->arg1:I

    move/from16 v21, v0

    move-object/from16 v0, v20

    move-object/from16 v1, p1

    move/from16 v2, v21

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->setConnectCapa(Landroid/os/Message;I)V
    invoke-static {v0, v1, v2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$7700(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;I)V

    goto/16 :goto_1

    .line 896
    :sswitch_1a
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    move-object/from16 v1, p1

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->getConnectCapa(Landroid/os/Message;)V
    invoke-static {v0, v1}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$7800(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;)V

    goto/16 :goto_1

    .line 900
    :sswitch_1b
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, p1

    iget v0, v0, Landroid/os/Message;->arg1:I

    move/from16 v21, v0

    move-object/from16 v0, v20

    move-object/from16 v1, p1

    move/from16 v2, v21

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->setConfigMethod(Landroid/os/Message;I)V
    invoke-static {v0, v1, v2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$7900(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;I)V

    goto/16 :goto_1

    .line 904
    :sswitch_1c
    const-string v20, "WfdsService"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "GET_DISPLAY_PIN: "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v22, v0

    move-object/from16 v0, v22

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mDisplayPin:I
    invoke-static/range {v22 .. v22}, Lcom/lge/wfds/WfdsService;->access$3600(Lcom/lge/wfds/WfdsService;)I

    move-result v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 905
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mDisplayPin:I
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$3600(Lcom/lge/wfds/WfdsService;)I

    move-result v20

    if-nez v20, :cond_8

    .line 906
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    const v21, 0x900022

    const v22, 0xbc6146    # 1.7299968E-38f

    move-object/from16 v0, v20

    move-object/from16 v1, p1

    move/from16 v2, v21

    move/from16 v3, v22

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;II)V
    invoke-static {v0, v1, v2, v3}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$2000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;II)V

    .line 910
    :goto_2
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsDialog:Lcom/lge/wfds/WfdsDialog;
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$6500(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsDialog;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Lcom/lge/wfds/WfdsDialog;->dismissShowPinDialog()V

    goto/16 :goto_1

    .line 908
    :cond_8
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    const v21, 0x900022

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v22, v0

    move-object/from16 v0, v22

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v22, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mDisplayPin:I
    invoke-static/range {v22 .. v22}, Lcom/lge/wfds/WfdsService;->access$3600(Lcom/lge/wfds/WfdsService;)I

    move-result v22

    move-object/from16 v0, v20

    move-object/from16 v1, p1

    move/from16 v2, v21

    move/from16 v3, v22

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;II)V
    invoke-static {v0, v1, v2, v3}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$2000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;II)V

    goto :goto_2

    .line 914
    :sswitch_1d
    const-string v20, "WfdsService"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "WfdsEnabledState: CMD_TEST_SET_LISTEN_CHANNEL to "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    move-object/from16 v0, p1

    iget v0, v0, Landroid/os/Message;->arg1:I

    move/from16 v22, v0

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 915
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, p1

    iget v0, v0, Landroid/os/Message;->arg1:I

    move/from16 v21, v0

    move-object/from16 v0, v20

    move-object/from16 v1, p1

    move/from16 v2, v21

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->setListenChannelForTest(Landroid/os/Message;I)V
    invoke-static {v0, v1, v2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$8000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;I)V

    goto/16 :goto_1

    .line 919
    :sswitch_1e
    move-object/from16 v0, p1

    iget v5, v0, Landroid/os/Message;->arg1:I

    .line 920
    .local v5, "channel":I
    invoke-virtual/range {p1 .. p1}, Landroid/os/Message;->getData()Landroid/os/Bundle;

    move-result-object v20

    const-string v21, "ssid"

    invoke-virtual/range {v20 .. v21}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v18

    .line 921
    .local v18, "ssid":Ljava/lang/String;
    const-string v20, "WfdsService"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "CREATE_GROUP: Operating channel "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    move-object/from16 v0, v21

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v21

    const-string v22, ", ssid "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    move-object/from16 v0, v21

    move-object/from16 v1, v18

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 923
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # invokes: Lcom/lge/wfds/WfdsService;->sendWfdsCreatGroupBroadcast()V
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$8100(Lcom/lge/wfds/WfdsService;)V

    .line 925
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v20

    move-object/from16 v0, v20

    move-object/from16 v1, v18

    invoke-virtual {v0, v5, v1}, Lcom/lge/wfds/WfdsNative;->wfdsGroupAdd(ILjava/lang/String;)Z

    move-result v20

    if-eqz v20, :cond_9

    .line 926
    const-string v20, "WfdsService"

    const-string v21, "Autonomous Group is created"

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 927
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    const v21, 0x900020

    move-object/from16 v0, v20

    move-object/from16 v1, p1

    move/from16 v2, v21

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;I)V
    invoke-static {v0, v1, v2}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$2600(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;I)V

    .line 928
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v21, v0

    # getter for: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->mAutonomousGoState:Lcom/lge/wfds/WfdsService$WfdsStateMachine$AutonomousGoState;
    invoke-static/range {v21 .. v21}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$5800(Lcom/lge/wfds/WfdsService$WfdsStateMachine;)Lcom/lge/wfds/WfdsService$WfdsStateMachine$AutonomousGoState;

    move-result-object v21

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static/range {v20 .. v21}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$8200(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    .line 930
    :cond_9
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    const v21, 0x90001f

    const/16 v22, 0x2

    move-object/from16 v0, v20

    move-object/from16 v1, p1

    move/from16 v2, v21

    move/from16 v3, v22

    # invokes: Lcom/lge/wfds/WfdsService$WfdsStateMachine;->replyToMessage(Landroid/os/Message;II)V
    invoke-static {v0, v1, v2, v3}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->access$2000(Lcom/lge/wfds/WfdsService$WfdsStateMachine;Landroid/os/Message;II)V

    goto/16 :goto_1

    .line 936
    .end local v5    # "channel":I
    .end local v18    # "ssid":Ljava/lang/String;
    :sswitch_1f
    const-wide/16 v20, 0x2710

    :try_start_0
    invoke-static/range {v20 .. v21}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 940
    :goto_3
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v20

    const/16 v21, 0x8

    invoke-virtual/range {v20 .. v21}, Lcom/lge/wfds/WfdsNative;->p2pSetChannel(I)Z

    .line 941
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    const v21, 0x90100f

    invoke-virtual/range {v20 .. v21}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->sendMessage(I)V

    goto/16 :goto_1

    .line 937
    :catch_0
    move-exception v8

    .line 938
    .local v8, "e":Ljava/lang/InterruptedException;
    const-string v20, "WfdsService"

    new-instance v21, Ljava/lang/StringBuilder;

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuilder;-><init>()V

    const-string v22, "Interrupted Exception : "

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v21

    move-object/from16 v0, v21

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-static/range {v20 .. v21}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_3

    .line 945
    .end local v8    # "e":Ljava/lang/InterruptedException;
    :sswitch_20
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, v20

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->this$0:Lcom/lge/wfds/WfdsService;

    move-object/from16 v20, v0

    # getter for: Lcom/lge/wfds/WfdsService;->mWfdsNative:Lcom/lge/wfds/WfdsNative;
    invoke-static/range {v20 .. v20}, Lcom/lge/wfds/WfdsService;->access$3200(Lcom/lge/wfds/WfdsService;)Lcom/lge/wfds/WfdsNative;

    move-result-object v20

    const/16 v21, 0x2ee0

    invoke-virtual/range {v20 .. v21}, Lcom/lge/wfds/WfdsNative;->p2pListen(I)Z

    .line 946
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v20, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/lge/wfds/WfdsService$WfdsStateMachine$WfdsEnabledState;->this$1:Lcom/lge/wfds/WfdsService$WfdsStateMachine;

    move-object/from16 v21, v0

    const v22, 0x90100f

    invoke-virtual/range {v21 .. v22}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->obtainMessage(I)Landroid/os/Message;

    move-result-object v21

    const-wide/16 v22, 0x2ee0

    invoke-virtual/range {v20 .. v23}, Lcom/lge/wfds/WfdsService$WfdsStateMachine;->sendMessageDelayed(Landroid/os/Message;J)V

    goto/16 :goto_1

    .line 671
    :sswitch_data_0
    .sparse-switch
        0x900001 -> :sswitch_8
        0x900002 -> :sswitch_a
        0x900003 -> :sswitch_9
        0x900004 -> :sswitch_b
        0x900005 -> :sswitch_d
        0x90000a -> :sswitch_c
        0x900033 -> :sswitch_19
        0x900034 -> :sswitch_1a
        0x900035 -> :sswitch_1b
        0x900036 -> :sswitch_1c
        0x900037 -> :sswitch_1e
        0x900038 -> :sswitch_1d
        0x901001 -> :sswitch_4
        0x901006 -> :sswitch_18
        0x901007 -> :sswitch_17
        0x90100b -> :sswitch_3
        0x90100f -> :sswitch_20
        0x902001 -> :sswitch_0
        0x902002 -> :sswitch_2
        0x902003 -> :sswitch_6
        0x902004 -> :sswitch_f
        0x902005 -> :sswitch_e
        0x902007 -> :sswitch_14
        0x90200a -> :sswitch_10
        0x90200b -> :sswitch_11
        0x90200d -> :sswitch_13
        0x90200e -> :sswitch_15
        0x90200f -> :sswitch_1
        0x902011 -> :sswitch_12
        0x902013 -> :sswitch_16
        0x902014 -> :sswitch_5
        0x902016 -> :sswitch_7
        0x90205a -> :sswitch_1f
    .end sparse-switch
.end method
