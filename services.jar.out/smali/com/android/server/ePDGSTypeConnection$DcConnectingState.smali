.class Lcom/android/server/ePDGSTypeConnection$DcConnectingState;
.super Lcom/android/internal/util/State;
.source "ePDGSTypeConnection.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/server/ePDGSTypeConnection;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "DcConnectingState"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/server/ePDGSTypeConnection;


# direct methods
.method private constructor <init>(Lcom/android/server/ePDGSTypeConnection;)V
    .locals 0

    .prologue
    .line 604
    iput-object p1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    invoke-direct {p0}, Lcom/android/internal/util/State;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/android/server/ePDGSTypeConnection;Lcom/android/server/ePDGSTypeConnection$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/android/server/ePDGSTypeConnection;
    .param p2, "x1"    # Lcom/android/server/ePDGSTypeConnection$1;

    .prologue
    .line 604
    invoke-direct {p0, p1}, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;-><init>(Lcom/android/server/ePDGSTypeConnection;)V

    return-void
.end method


# virtual methods
.method public enter()V
    .locals 8

    .prologue
    .line 612
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v1, "DcConnectingState state enter"

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 619
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v0, v0, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 621
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v1, "16"

    const-string v2, "0"

    iget-object v3, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v4, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v4, v4, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    invoke-virtual {v3, v4}, Lcom/android/server/ePDGSTypeConnection;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v3

    const-string v4, ""

    const-string v5, ""

    const-string v6, "0"

    const-string v7, "notused"

    invoke-virtual/range {v0 .. v7}, Lcom/android/server/ePDGSTypeConnection;->ePDGSetupDataCall(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 623
    :cond_0
    return-void
.end method

.method public exit()V
    .locals 2

    .prologue
    .line 629
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v1, "DcConnectingState state exit"

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 632
    return-void
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 10
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v1, 0x0

    .line 638
    iget v0, p1, Landroid/os/Message;->what:I

    packed-switch v0, :pswitch_data_0

    .line 727
    :pswitch_0
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "DcConnectingState nothandled msg.what=0x"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p1, Landroid/os/Message;->what:I

    invoke-static {v2}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 730
    const/4 v8, 0x0

    .line 733
    .local v8, "retVal":Z
    :cond_0
    :goto_0
    return v8

    .line 643
    .end local v8    # "retVal":Z
    :pswitch_1
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcConnectingState : EVENT_BAD_WIFI_STATUS "

    invoke-virtual {v0, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 644
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iput-boolean v1, v0, Lcom/android/server/ePDGSTypeConnection;->isGoodPacket:Z

    .line 645
    const/4 v8, 0x1

    .line 646
    .restart local v8    # "retVal":Z
    goto :goto_0

    .line 650
    .end local v8    # "retVal":Z
    :pswitch_2
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v0, v0, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    if-nez v0, :cond_1

    .line 652
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    invoke-virtual {v0, v1, v1}, Lcom/android/server/ePDGSTypeConnection;->notifyePDGCompleted(II)V

    .line 653
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v1, "DcConnectingState : Connected Msg from RIL "

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 654
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mConnectedState:Lcom/android/server/ePDGSTypeConnection$DcConnectedState;
    invoke-static {v1}, Lcom/android/server/ePDGSTypeConnection;->access$1100(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcConnectedState;

    move-result-object v1

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v0, v1}, Lcom/android/server/ePDGSTypeConnection;->access$3800(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    .line 655
    const/4 v8, 0x1

    .line 656
    .restart local v8    # "retVal":Z
    goto :goto_0

    .line 658
    .end local v8    # "retVal":Z
    :cond_1
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcConnectingState : EVENT_CONNECTED"

    invoke-virtual {v0, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 659
    iget-object v7, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v7, Landroid/os/AsyncResult;

    .line 660
    .local v7, "ar":Landroid/os/AsyncResult;
    iget-object v9, v7, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v9, Lcom/android/server/ePDGConnInfo;

    .line 661
    .local v9, "sendingResult":Lcom/android/server/ePDGConnInfo;
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v3, v9, Lcom/android/server/ePDGConnInfo;->mIpsecAddr:Ljava/lang/String;

    iget-object v4, v9, Lcom/android/server/ePDGConnInfo;->mIface:Ljava/lang/String;

    iget-object v5, v9, Lcom/android/server/ePDGConnInfo;->mIpsecGW:Ljava/lang/String;

    iget-object v6, v9, Lcom/android/server/ePDGConnInfo;->mdnss:Ljava/lang/String;

    move v2, v1

    invoke-virtual/range {v0 .. v6}, Lcom/android/server/ePDGSTypeConnection;->notifyePDGCompleted(IILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 662
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v1, "DcConnectingState : Connected Msg from RIL "

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 663
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mConnectedState:Lcom/android/server/ePDGSTypeConnection$DcConnectedState;
    invoke-static {v1}, Lcom/android/server/ePDGSTypeConnection;->access$1100(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcConnectedState;

    move-result-object v1

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v0, v1}, Lcom/android/server/ePDGSTypeConnection;->access$3900(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    .line 664
    const/4 v8, 0x1

    .line 665
    .restart local v8    # "retVal":Z
    goto :goto_0

    .line 668
    .end local v7    # "ar":Landroid/os/AsyncResult;
    .end local v8    # "retVal":Z
    .end local v9    # "sendingResult":Lcom/android/server/ePDGConnInfo;
    :pswitch_3
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const/16 v2, 0x3e9

    invoke-virtual {v0, v2, v1}, Lcom/android/server/ePDGSTypeConnection;->notifyePDGCompleted(II)V

    .line 669
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const/16 v1, 0x1389

    iput v1, v0, Lcom/android/server/ePDGSTypeConnection;->mFailReason:I

    .line 670
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mFailState:Lcom/android/server/ePDGSTypeConnection$DcFailState;
    invoke-static {v1}, Lcom/android/server/ePDGSTypeConnection;->access$2500(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcFailState;

    move-result-object v1

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v0, v1}, Lcom/android/server/ePDGSTypeConnection;->access$4000(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    .line 671
    const/4 v8, 0x1

    .line 672
    .restart local v8    # "retVal":Z
    goto :goto_0

    .line 676
    .end local v8    # "retVal":Z
    :pswitch_4
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "DcConnectingState : Fail , type ="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p1, Landroid/os/Message;->what:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "Reason"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 677
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v0, v0, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    if-nez v0, :cond_2

    .line 682
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const/16 v1, 0x138d

    iput v1, v0, Lcom/android/server/ePDGSTypeConnection;->mFailReason:I

    .line 688
    :goto_1
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v1, p1, Landroid/os/Message;->arg1:I

    iput v1, v0, Lcom/android/server/ePDGSTypeConnection;->mLastNetworkReason:I

    .line 689
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mFailState:Lcom/android/server/ePDGSTypeConnection$DcFailState;
    invoke-static {v1}, Lcom/android/server/ePDGSTypeConnection;->access$2500(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcFailState;

    move-result-object v1

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v0, v1}, Lcom/android/server/ePDGSTypeConnection;->access$4100(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    .line 690
    const/4 v8, 0x1

    .line 692
    .restart local v8    # "retVal":Z
    goto/16 :goto_0

    .line 686
    .end local v8    # "retVal":Z
    :cond_2
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const/16 v1, 0x138b

    iput v1, v0, Lcom/android/server/ePDGSTypeConnection;->mFailReason:I

    goto :goto_1

    .line 696
    :pswitch_5
    const/4 v8, 0x1

    .line 697
    .restart local v8    # "retVal":Z
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v0, v0, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    if-nez v0, :cond_0

    .line 699
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcConnectingState : send change prefmode to modem -> WWAN"

    invoke-virtual {v0, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 700
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v3, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v3, v3, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGSTypeConnection;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2, v1}, Lcom/android/server/ePDGSTypeConnection;->setePDGsetprefTest(Ljava/lang/String;I)V

    .line 701
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mReadyState:Lcom/android/server/ePDGSTypeConnection$DcReadyState;
    invoke-static {v1}, Lcom/android/server/ePDGSTypeConnection;->access$1300(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcReadyState;

    move-result-object v1

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v0, v1}, Lcom/android/server/ePDGSTypeConnection;->access$4200(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    goto/16 :goto_0

    .line 710
    .end local v8    # "retVal":Z
    :pswitch_6
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcConnectingState : msg.what=EVENT_WIFI_DISCONNECT"

    invoke-virtual {v0, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 711
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iput-boolean v1, v0, Lcom/android/server/ePDGSTypeConnection;->isWiFi:Z

    .line 715
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v0, v0, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    if-nez v0, :cond_3

    .line 717
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const-string v2, "DcConnectingState : Wifi Disconnected so prefmode  -> WWAN"

    invoke-virtual {v0, v2}, Lcom/android/server/ePDGSTypeConnection;->log(Ljava/lang/String;)V

    .line 718
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v2, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v3, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget v3, v3, Lcom/android/server/ePDGSTypeConnection;->mFid:I

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGSTypeConnection;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2, v1}, Lcom/android/server/ePDGSTypeConnection;->setePDGsetprefTest(Ljava/lang/String;I)V

    .line 720
    :cond_3
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    const/4 v1, 0x3

    const/16 v2, 0x138e

    invoke-virtual {v0, v1, v2}, Lcom/android/server/ePDGSTypeConnection;->notifyePDGCompleted(II)V

    .line 721
    iget-object v0, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    iget-object v1, p0, Lcom/android/server/ePDGSTypeConnection$DcConnectingState;->this$0:Lcom/android/server/ePDGSTypeConnection;

    # getter for: Lcom/android/server/ePDGSTypeConnection;->mNonetworkState:Lcom/android/server/ePDGSTypeConnection$DcNonetworkState;
    invoke-static {v1}, Lcom/android/server/ePDGSTypeConnection;->access$900(Lcom/android/server/ePDGSTypeConnection;)Lcom/android/server/ePDGSTypeConnection$DcNonetworkState;

    move-result-object v1

    # invokes: Lcom/android/server/ePDGSTypeConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v0, v1}, Lcom/android/server/ePDGSTypeConnection;->access$4300(Lcom/android/server/ePDGSTypeConnection;Lcom/android/internal/util/IState;)V

    .line 723
    const/4 v8, 0x1

    .line 724
    .restart local v8    # "retVal":Z
    goto/16 :goto_0

    .line 638
    nop

    :pswitch_data_0
    .packed-switch 0x40001
        :pswitch_6
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_2
        :pswitch_4
        :pswitch_3
        :pswitch_0
        :pswitch_5
        :pswitch_0
        :pswitch_1
        :pswitch_4
    .end packed-switch
.end method