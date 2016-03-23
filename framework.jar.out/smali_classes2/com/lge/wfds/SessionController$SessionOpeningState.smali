.class Lcom/lge/wfds/SessionController$SessionOpeningState;
.super Lcom/android/internal/util/State;
.source "SessionController.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/wfds/SessionController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "SessionOpeningState"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/lge/wfds/SessionController;


# direct methods
.method constructor <init>(Lcom/lge/wfds/SessionController;)V
    .locals 0

    .prologue
    .line 668
    iput-object p1, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    invoke-direct {p0}, Lcom/android/internal/util/State;-><init>()V

    return-void
.end method


# virtual methods
.method public enter()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 671
    iget-object v1, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mRequestedSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v1}, Lcom/lge/wfds/SessionController;->access$300(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/session/AspSession;

    move-result-object v1

    if-nez v1, :cond_0

    .line 672
    const-string v1, "WfdsSession:Controller"

    const-string v2, "STATE : SessionOpeningState - enter - Error !! Peer Device is null"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 698
    :goto_0
    return-void

    .line 676
    :cond_0
    const-string v1, "WfdsSession:Controller"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "STATE : SessionOpeningState - enter - Peer Device Address : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mRequestedSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v3}, Lcom/lge/wfds/SessionController;->access$300(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/session/AspSession;

    move-result-object v3

    iget-object v3, v3, Lcom/lge/wfds/session/AspSession;->service_mac:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 678
    iget-object v1, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # invokes: Lcom/lge/wfds/SessionController;->stopSessionReadyTimeouts()V
    invoke-static {v1}, Lcom/lge/wfds/SessionController;->access$400(Lcom/lge/wfds/SessionController;)V

    .line 680
    iget-object v1, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # invokes: Lcom/lge/wfds/SessionController;->setP2pPowerSave(Z)V
    invoke-static {v1, v4}, Lcom/lge/wfds/SessionController;->access$4700(Lcom/lge/wfds/SessionController;Z)V

    .line 682
    iget-object v1, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mWifiMulticastLock:Landroid/net/wifi/WifiManager$MulticastLock;
    invoke-static {v1}, Lcom/lge/wfds/SessionController;->access$4800(Lcom/lge/wfds/SessionController;)Landroid/net/wifi/WifiManager$MulticastLock;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/wifi/WifiManager$MulticastLock;->isHeld()Z

    move-result v1

    if-nez v1, :cond_1

    .line 683
    const-string v1, "WfdsSession:Controller"

    const-string v2, "SessionOpeningState - enter : WifiMulticastLock acquire"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 684
    iget-object v1, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mWifiMulticastLock:Landroid/net/wifi/WifiManager$MulticastLock;
    invoke-static {v1}, Lcom/lge/wfds/SessionController;->access$4800(Lcom/lge/wfds/SessionController;)Landroid/net/wifi/WifiManager$MulticastLock;

    move-result-object v1

    invoke-virtual {v1}, Landroid/net/wifi/WifiManager$MulticastLock;->acquire()V

    .line 687
    :cond_1
    iget-object v1, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mPortIsolation:Lcom/lge/wfds/session/PortIsolation;
    invoke-static {v1}, Lcom/lge/wfds/SessionController;->access$600(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/session/PortIsolation;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mRequestedSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v2}, Lcom/lge/wfds/SessionController;->access$300(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/session/AspSession;

    move-result-object v2

    iget-object v2, v2, Lcom/lge/wfds/session/AspSession;->session_mac:Ljava/lang/String;

    iget-object v3, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mRequestedSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v3}, Lcom/lge/wfds/SessionController;->access$300(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/session/AspSession;

    move-result-object v3

    iget v3, v3, Lcom/lge/wfds/session/AspSession;->session_id:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lcom/lge/wfds/session/PortIsolation;->enable(Ljava/lang/String;Ljava/lang/Integer;)Z

    .line 689
    iget-object v1, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mSessionList:Lcom/lge/wfds/session/AspSessionList;
    invoke-static {v1}, Lcom/lge/wfds/SessionController;->access$700(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/session/AspSessionList;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mRequestedSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v2}, Lcom/lge/wfds/SessionController;->access$300(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/session/AspSession;

    move-result-object v2

    iget-object v2, v2, Lcom/lge/wfds/session/AspSession;->session_mac:Ljava/lang/String;

    iget-object v3, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mRequestedSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v3}, Lcom/lge/wfds/SessionController;->access$300(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/session/AspSession;

    move-result-object v3

    iget v3, v3, Lcom/lge/wfds/session/AspSession;->session_id:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lcom/lge/wfds/session/AspSessionList;->getSession(Ljava/lang/String;Ljava/lang/Integer;)Lcom/lge/wfds/session/AspSession;

    move-result-object v0

    .line 690
    .local v0, "session":Lcom/lge/wfds/session/AspSession;
    if-eqz v0, :cond_2

    .line 691
    const-string v1, "WfdsSession:Controller"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Enter SessionOpeningState - Peer Device IP : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v0, Lcom/lge/wfds/session/AspSession;->ip_address:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 692
    iget-object v1, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mUdpDataManager:Lcom/lge/wfds/session/UdpDataManager;
    invoke-static {v1}, Lcom/lge/wfds/SessionController;->access$900(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/session/UdpDataManager;

    move-result-object v1

    iget-object v2, v0, Lcom/lge/wfds/session/AspSession;->ip_address:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/lge/wfds/session/UdpDataManager;->initUdpDataSender(Ljava/lang/String;)V

    .line 693
    iget-object v1, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mUdpDataManager:Lcom/lge/wfds/session/UdpDataManager;
    invoke-static {v1}, Lcom/lge/wfds/SessionController;->access$900(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/session/UdpDataManager;

    move-result-object v1

    invoke-virtual {v1}, Lcom/lge/wfds/session/UdpDataManager;->startReceiver()V

    .line 695
    :cond_2
    iget-object v1, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # setter for: Lcom/lge/wfds/SessionController;->bVersionReceived:Z
    invoke-static {v1, v4}, Lcom/lge/wfds/SessionController;->access$4902(Lcom/lge/wfds/SessionController;Z)Z

    .line 696
    iget-object v1, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # setter for: Lcom/lge/wfds/SessionController;->bVersionSent:Z
    invoke-static {v1, v4}, Lcom/lge/wfds/SessionController;->access$5002(Lcom/lge/wfds/SessionController;Z)Z

    .line 697
    iget-object v1, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    const v2, 0x901034

    invoke-virtual {v1, v2}, Lcom/lge/wfds/SessionController;->sendMessage(I)V

    goto/16 :goto_0
.end method

.method public exit()V
    .locals 4

    .prologue
    .line 757
    const-string v0, "WfdsSession:Controller"

    const-string v1, "STATE : SessionOpeningState - exit"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 759
    iget-object v0, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    const/4 v1, 0x1

    # invokes: Lcom/lge/wfds/SessionController;->setP2pPowerSave(Z)V
    invoke-static {v0, v1}, Lcom/lge/wfds/SessionController;->access$4700(Lcom/lge/wfds/SessionController;Z)V

    .line 761
    iget-object v0, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mWifiMulticastLock:Landroid/net/wifi/WifiManager$MulticastLock;
    invoke-static {v0}, Lcom/lge/wfds/SessionController;->access$4800(Lcom/lge/wfds/SessionController;)Landroid/net/wifi/WifiManager$MulticastLock;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/wifi/WifiManager$MulticastLock;->isHeld()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 762
    const-string v0, "WfdsSession:Controller"

    const-string v1, "SessionOpeningState - exit : WifiMulticastLock release"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 763
    iget-object v0, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mWifiMulticastLock:Landroid/net/wifi/WifiManager$MulticastLock;
    invoke-static {v0}, Lcom/lge/wfds/SessionController;->access$4800(Lcom/lge/wfds/SessionController;)Landroid/net/wifi/WifiManager$MulticastLock;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/wifi/WifiManager$MulticastLock;->release()V

    .line 766
    :cond_0
    iget-object v0, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    iget-object v1, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    const-string v2, "com.lge.wfds.session.OPEN_FAILED_TIMEOUT"

    const/16 v3, 0x2710

    # invokes: Lcom/lge/wfds/SessionController;->startTimeout(Ljava/lang/String;I)Landroid/app/PendingIntent;
    invoke-static {v1, v2, v3}, Lcom/lge/wfds/SessionController;->access$1400(Lcom/lge/wfds/SessionController;Ljava/lang/String;I)Landroid/app/PendingIntent;

    move-result-object v1

    # setter for: Lcom/lge/wfds/SessionController;->mSessionOpenFailedTimeoutIntent:Landroid/app/PendingIntent;
    invoke-static {v0, v1}, Lcom/lge/wfds/SessionController;->access$5102(Lcom/lge/wfds/SessionController;Landroid/app/PendingIntent;)Landroid/app/PendingIntent;

    .line 768
    return-void
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 5
    .param p1, "message"    # Landroid/os/Message;

    .prologue
    const v4, 0x901035

    const/4 v1, 0x1

    .line 702
    const/4 v0, 0x0

    .line 704
    .local v0, "session":Lcom/lge/wfds/session/AspSession;
    iget v2, p1, Landroid/os/Message;->what:I

    sparse-switch v2, :sswitch_data_0

    .line 750
    const/4 v1, 0x0

    .line 752
    :goto_0
    return v1

    .line 707
    :sswitch_0
    const-string v2, "WfdsSession:Controller"

    const-string v3, "EVT_REQUEST_OPEN_SESSION"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 708
    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mWfdsStateMachine:Lcom/android/internal/util/StateMachine;
    invoke-static {v2}, Lcom/lge/wfds/SessionController;->access$1200(Lcom/lge/wfds/SessionController;)Lcom/android/internal/util/StateMachine;

    move-result-object v2

    const v3, 0x901015

    iget-object v4, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    invoke-virtual {v2, v3, v4}, Lcom/android/internal/util/StateMachine;->sendMessage(ILjava/lang/Object;)V

    goto :goto_0

    .line 712
    :sswitch_1
    const-string v2, "WfdsSession:Controller"

    const-string v3, "VERSION"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 713
    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mSessionList:Lcom/lge/wfds/session/AspSessionList;
    invoke-static {v2}, Lcom/lge/wfds/SessionController;->access$700(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/session/AspSessionList;

    move-result-object v2

    iget-object v3, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mRequestedSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v3}, Lcom/lge/wfds/SessionController;->access$300(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/session/AspSession;

    move-result-object v3

    iget-object v3, v3, Lcom/lge/wfds/session/AspSession;->session_mac:Ljava/lang/String;

    iget-object v4, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->mRequestedSession:Lcom/lge/wfds/session/AspSession;
    invoke-static {v4}, Lcom/lge/wfds/SessionController;->access$300(Lcom/lge/wfds/SessionController;)Lcom/lge/wfds/session/AspSession;

    move-result-object v4

    iget v4, v4, Lcom/lge/wfds/session/AspSession;->session_id:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lcom/lge/wfds/session/AspSessionList;->getSession(Ljava/lang/String;Ljava/lang/Integer;)Lcom/lge/wfds/session/AspSession;

    move-result-object v0

    .line 714
    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    const/4 v3, 0x5

    # invokes: Lcom/lge/wfds/SessionController;->startAspSessionRequest(ILcom/lge/wfds/session/AspSession;)Z
    invoke-static {v2, v3, v0}, Lcom/lge/wfds/SessionController;->access$1800(Lcom/lge/wfds/SessionController;ILcom/lge/wfds/session/AspSession;)Z

    goto :goto_0

    .line 719
    :sswitch_2
    const-string v2, "WfdsSession:Controller"

    const-string v3, "VERSION_RECEIVED"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 720
    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # setter for: Lcom/lge/wfds/SessionController;->bVersionReceived:Z
    invoke-static {v2, v1}, Lcom/lge/wfds/SessionController;->access$4902(Lcom/lge/wfds/SessionController;Z)Z

    .line 722
    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->bVersionReceived:Z
    invoke-static {v2}, Lcom/lge/wfds/SessionController;->access$4900(Lcom/lge/wfds/SessionController;)Z

    move-result v2

    if-ne v2, v1, :cond_0

    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->bVersionSent:Z
    invoke-static {v2}, Lcom/lge/wfds/SessionController;->access$5000(Lcom/lge/wfds/SessionController;)Z

    move-result v2

    if-ne v2, v1, :cond_0

    .line 723
    const-string v2, "WfdsSession:Controller"

    const-string v3, "VERSION exchange is completed"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 724
    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    invoke-virtual {v2, v4}, Lcom/lge/wfds/SessionController;->sendMessage(I)V

    goto :goto_0

    .line 726
    :cond_0
    const-string v2, "WfdsSession:Controller"

    const-string v3, "VERSION exchange is not completed"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 731
    :sswitch_3
    const-string v2, "WfdsSession:Controller"

    const-string v3, "ACK_VERSION_RECEIVED"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 732
    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # invokes: Lcom/lge/wfds/SessionController;->stopAspSessionRequest()V
    invoke-static {v2}, Lcom/lge/wfds/SessionController;->access$200(Lcom/lge/wfds/SessionController;)V

    .line 734
    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # setter for: Lcom/lge/wfds/SessionController;->bVersionSent:Z
    invoke-static {v2, v1}, Lcom/lge/wfds/SessionController;->access$5002(Lcom/lge/wfds/SessionController;Z)Z

    .line 735
    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->bVersionReceived:Z
    invoke-static {v2}, Lcom/lge/wfds/SessionController;->access$4900(Lcom/lge/wfds/SessionController;)Z

    move-result v2

    if-ne v2, v1, :cond_1

    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # getter for: Lcom/lge/wfds/SessionController;->bVersionSent:Z
    invoke-static {v2}, Lcom/lge/wfds/SessionController;->access$5000(Lcom/lge/wfds/SessionController;)Z

    move-result v2

    if-ne v2, v1, :cond_1

    .line 736
    const-string v2, "WfdsSession:Controller"

    const-string v3, "VERSION exchange is completed"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 737
    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    invoke-virtual {v2, v4}, Lcom/lge/wfds/SessionController;->sendMessage(I)V

    goto/16 :goto_0

    .line 739
    :cond_1
    const-string v2, "WfdsSession:Controller"

    const-string v3, "VERSION exchange is not completed"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 744
    :sswitch_4
    const-string v2, "WfdsSession:Controller"

    const-string v3, "VERSION_EXCHANGED"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 746
    iget-object v2, p0, Lcom/lge/wfds/SessionController$SessionOpeningState;->this$0:Lcom/lge/wfds/SessionController;

    # invokes: Lcom/lge/wfds/SessionController;->sendRequestSession()V
    invoke-static {v2}, Lcom/lge/wfds/SessionController;->access$1700(Lcom/lge/wfds/SessionController;)V

    goto/16 :goto_0

    .line 704
    nop

    :sswitch_data_0
    .sparse-switch
        0x901034 -> :sswitch_1
        0x901035 -> :sswitch_4
        0x901047 -> :sswitch_0
        0x90105c -> :sswitch_2
        0x901064 -> :sswitch_3
    .end sparse-switch
.end method
