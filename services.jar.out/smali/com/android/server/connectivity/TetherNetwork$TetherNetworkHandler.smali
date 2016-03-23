.class Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;
.super Landroid/os/Handler;
.source "TetherNetwork.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/server/connectivity/TetherNetwork;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "TetherNetworkHandler"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/server/connectivity/TetherNetwork;


# direct methods
.method public constructor <init>(Lcom/android/server/connectivity/TetherNetwork;Landroid/os/Looper;)V
    .locals 0
    .param p2, "looper"    # Landroid/os/Looper;

    .prologue
    .line 855
    iput-object p1, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    .line 856
    invoke-direct {p0, p2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 857
    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 9
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/16 v8, 0x3f2

    const/4 v2, 0x0

    const/4 v7, 0x1

    const/16 v6, 0x3fe

    const-wide/16 v4, 0x0

    .line 862
    iget v0, p1, Landroid/os/Message;->what:I

    sparse-switch v0, :sswitch_data_0

    .line 1016
    :cond_0
    :goto_0
    return-void

    .line 865
    :sswitch_0
    const-string v0, "TetherNetwork"

    const-string v1, "MSG_START_TETHER_NETWORK start"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 866
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkDataTrans:Lcom/android/server/connectivity/TetherNetworkDataTransition;
    invoke-static {v0}, Lcom/android/server/connectivity/TetherNetwork;->access$200(Lcom/android/server/connectivity/TetherNetwork;)Lcom/android/server/connectivity/TetherNetworkDataTransition;

    move-result-object v0

    if-eqz v0, :cond_b

    .line 869
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkDataTrans:Lcom/android/server/connectivity/TetherNetworkDataTransition;
    invoke-static {v0}, Lcom/android/server/connectivity/TetherNetwork;->access$200(Lcom/android/server/connectivity/TetherNetwork;)Lcom/android/server/connectivity/TetherNetworkDataTransition;

    move-result-object v0

    invoke-virtual {v0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->isMobileDataEnabled()Z

    move-result v0

    if-nez v0, :cond_1

    .line 870
    const-string v0, "TetherNetwork"

    const-string v1, "MSG_START_TETHER_NETWORK isMobileDataEnabled false"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 871
    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkHandler:Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;
    invoke-static {}, Lcom/android/server/connectivity/TetherNetwork;->access$300()Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;

    move-result-object v0

    invoke-virtual {v0, v6, v4, v5}, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->sendEmptyMessageDelayed(IJ)Z

    goto :goto_0

    .line 874
    :cond_1
    const-string v0, "TetherNetwork"

    const-string v1, "MSG_START_TETHER_NETWORK isMobileDataEnabled true"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 878
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # invokes: Lcom/android/server/connectivity/TetherNetwork;->turnOffWifi()V
    invoke-static {v0}, Lcom/android/server/connectivity/TetherNetwork;->access$400(Lcom/android/server/connectivity/TetherNetwork;)V

    .line 880
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkDataTrans:Lcom/android/server/connectivity/TetherNetworkDataTransition;
    invoke-static {v0}, Lcom/android/server/connectivity/TetherNetwork;->access$200(Lcom/android/server/connectivity/TetherNetwork;)Lcom/android/server/connectivity/TetherNetworkDataTransition;

    move-result-object v0

    invoke-virtual {v0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->isLteOrEhrpdNetwork()Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkDataTrans:Lcom/android/server/connectivity/TetherNetworkDataTransition;
    invoke-static {v0}, Lcom/android/server/connectivity/TetherNetwork;->access$200(Lcom/android/server/connectivity/TetherNetwork;)Lcom/android/server/connectivity/TetherNetworkDataTransition;

    move-result-object v0

    invoke-virtual {v0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->isGsmNetwork()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 881
    :cond_2
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    invoke-virtual {v0}, Lcom/android/server/connectivity/TetherNetwork;->isTetherNetworkAvail()Z

    move-result v0

    if-nez v0, :cond_3

    .line 883
    const-string v0, "TetherNetwork"

    const-string v1, "LTE, EHRPD, GSM : MSG_START_TETHER_NETWORK isTetherNetworkAvail false"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 885
    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkHandler:Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;
    invoke-static {}, Lcom/android/server/connectivity/TetherNetwork;->access$300()Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;

    move-result-object v0

    const/16 v1, 0x3fc

    invoke-virtual {v0, v1}, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->removeMessages(I)V

    .line 886
    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkHandler:Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;
    invoke-static {}, Lcom/android/server/connectivity/TetherNetwork;->access$300()Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;

    move-result-object v0

    const/16 v1, 0x3fc

    const-wide/16 v2, 0x1388

    invoke-virtual {v0, v1, v2, v3}, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->sendEmptyMessageDelayed(IJ)Z

    .line 888
    :cond_3
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkDataTrans:Lcom/android/server/connectivity/TetherNetworkDataTransition;
    invoke-static {v0}, Lcom/android/server/connectivity/TetherNetwork;->access$200(Lcom/android/server/connectivity/TetherNetwork;)Lcom/android/server/connectivity/TetherNetworkDataTransition;

    move-result-object v0

    invoke-virtual {v0, v7}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->notifyPhoneTetherStatus(Z)Z

    move-result v0

    if-nez v0, :cond_0

    .line 891
    const-string v0, "TetherNetwork"

    const-string v1, "LTE, EHRPD, GSM : MSG_START_TETHER_NETWORK notifyPhoneTetherStatus error"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 893
    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkHandler:Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;
    invoke-static {}, Lcom/android/server/connectivity/TetherNetwork;->access$300()Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;

    move-result-object v0

    invoke-virtual {v0, v6, v4, v5}, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->sendEmptyMessageDelayed(IJ)Z

    goto/16 :goto_0

    .line 896
    :cond_4
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkDataTrans:Lcom/android/server/connectivity/TetherNetworkDataTransition;
    invoke-static {v0}, Lcom/android/server/connectivity/TetherNetwork;->access$200(Lcom/android/server/connectivity/TetherNetwork;)Lcom/android/server/connectivity/TetherNetworkDataTransition;

    move-result-object v0

    invoke-virtual {v0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->getNetworkTechType()I

    move-result v0

    if-nez v0, :cond_6

    .line 898
    const/16 v0, 0xf

    iget-object v1, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mNumRetryHotspotEnable:I
    invoke-static {v1}, Lcom/android/server/connectivity/TetherNetwork;->access$500(Lcom/android/server/connectivity/TetherNetwork;)I

    move-result v1

    if-ne v0, v1, :cond_5

    .line 899
    const-string v0, "TetherNetwork"

    const-string v1, "MSG_START_TETHER_NETWORK MAX_NUM_RETRY_HOTSPOT_ENABLE reached!"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 900
    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkHandler:Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;
    invoke-static {}, Lcom/android/server/connectivity/TetherNetwork;->access$300()Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;

    move-result-object v0

    invoke-virtual {v0, v6, v4, v5}, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->sendEmptyMessageDelayed(IJ)Z

    .line 901
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # setter for: Lcom/android/server/connectivity/TetherNetwork;->mNumRetryHotspotEnable:I
    invoke-static {v0, v2}, Lcom/android/server/connectivity/TetherNetwork;->access$502(Lcom/android/server/connectivity/TetherNetwork;I)I

    goto/16 :goto_0

    .line 905
    :cond_5
    const-string v0, "TetherNetwork"

    const-string v1, "MSG_START_TETHER_NETWORK RETRY!"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 906
    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkHandler:Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;
    invoke-static {}, Lcom/android/server/connectivity/TetherNetwork;->access$300()Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;

    move-result-object v0

    invoke-virtual {v0, v8}, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->removeMessages(I)V

    .line 907
    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkHandler:Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;
    invoke-static {}, Lcom/android/server/connectivity/TetherNetwork;->access$300()Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;

    move-result-object v0

    const/16 v1, 0x3f3

    invoke-virtual {v0, v1}, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->removeMessages(I)V

    .line 908
    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkHandler:Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;
    invoke-static {}, Lcom/android/server/connectivity/TetherNetwork;->access$300()Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;

    move-result-object v0

    const-wide/16 v2, 0x7d0

    invoke-virtual {v0, v8, v2, v3}, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->sendEmptyMessageDelayed(IJ)Z

    .line 909
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # operator++ for: Lcom/android/server/connectivity/TetherNetwork;->mNumRetryHotspotEnable:I
    invoke-static {v0}, Lcom/android/server/connectivity/TetherNetwork;->access$508(Lcom/android/server/connectivity/TetherNetwork;)I

    goto/16 :goto_0

    .line 912
    :cond_6
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkDataTrans:Lcom/android/server/connectivity/TetherNetworkDataTransition;
    invoke-static {v0}, Lcom/android/server/connectivity/TetherNetwork;->access$200(Lcom/android/server/connectivity/TetherNetwork;)Lcom/android/server/connectivity/TetherNetworkDataTransition;

    move-result-object v0

    invoke-virtual {v0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->connectMobileCheck()Z

    move-result v0

    if-nez v0, :cond_7

    .line 913
    const-string v0, "TetherNetwork"

    const-string v1, "MSG_START_TETHER_NETWORK connectMobileCheck error"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 914
    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkHandler:Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;
    invoke-static {}, Lcom/android/server/connectivity/TetherNetwork;->access$300()Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;

    move-result-object v0

    invoke-virtual {v0, v6, v4, v5}, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->sendEmptyMessageDelayed(IJ)Z

    goto/16 :goto_0

    .line 917
    :cond_7
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkDataTrans:Lcom/android/server/connectivity/TetherNetworkDataTransition;
    invoke-static {v0}, Lcom/android/server/connectivity/TetherNetwork;->access$200(Lcom/android/server/connectivity/TetherNetwork;)Lcom/android/server/connectivity/TetherNetworkDataTransition;

    move-result-object v0

    invoke-virtual {v0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->disconnectMobile()Z

    move-result v0

    if-nez v0, :cond_8

    .line 918
    const-string v0, "TetherNetwork"

    const-string v1, "MSG_START_TETHER_NETWORK disconnectMobile error"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 919
    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkHandler:Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;
    invoke-static {}, Lcom/android/server/connectivity/TetherNetwork;->access$300()Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;

    move-result-object v0

    invoke-virtual {v0, v6, v4, v5}, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->sendEmptyMessageDelayed(IJ)Z

    goto/16 :goto_0

    .line 922
    :cond_8
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkDataTrans:Lcom/android/server/connectivity/TetherNetworkDataTransition;
    invoke-static {v0}, Lcom/android/server/connectivity/TetherNetwork;->access$200(Lcom/android/server/connectivity/TetherNetwork;)Lcom/android/server/connectivity/TetherNetworkDataTransition;

    move-result-object v0

    invoke-virtual {v0, v7}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->notifyPhoneTetherStatus(Z)Z

    move-result v0

    if-nez v0, :cond_9

    .line 924
    const-string v0, "TetherNetwork"

    const-string v1, "MSG_START_TETHER_NETWORK notifyPhoneTetherStatus error"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 925
    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkHandler:Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;
    invoke-static {}, Lcom/android/server/connectivity/TetherNetwork;->access$300()Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;

    move-result-object v0

    invoke-virtual {v0, v6, v4, v5}, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->sendEmptyMessageDelayed(IJ)Z

    goto/16 :goto_0

    .line 928
    :cond_9
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkDataTrans:Lcom/android/server/connectivity/TetherNetworkDataTransition;
    invoke-static {v0}, Lcom/android/server/connectivity/TetherNetwork;->access$200(Lcom/android/server/connectivity/TetherNetwork;)Lcom/android/server/connectivity/TetherNetworkDataTransition;

    move-result-object v0

    invoke-virtual {v0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->connectMobile()Z

    move-result v0

    if-nez v0, :cond_a

    .line 929
    const-string v0, "TetherNetwork"

    const-string v1, "MSG_START_TETHER_NETWORK connectMobile error"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 931
    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkStatus:I
    invoke-static {}, Lcom/android/server/connectivity/TetherNetwork;->access$600()I

    move-result v0

    if-ne v0, v7, :cond_0

    .line 932
    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkHandler:Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;
    invoke-static {}, Lcom/android/server/connectivity/TetherNetwork;->access$300()Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;

    move-result-object v0

    const/16 v1, 0x3fd

    invoke-virtual {v0, v1, v4, v5}, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->sendEmptyMessageDelayed(IJ)Z

    goto/16 :goto_0

    .line 935
    :cond_a
    const-string v0, "TetherNetwork"

    const-string v1, "MSG_START_TETHER_NETWORK TetherNetwork Success"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 941
    :cond_b
    const-string v0, "TetherNetwork"

    const-string v1, "MSG_START_TETHER_NETWORK mTetherNetworkDataTrans error"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 942
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    iget-object v1, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mContext:Landroid/content/Context;
    invoke-static {v1}, Lcom/android/server/connectivity/TetherNetwork;->access$700(Lcom/android/server/connectivity/TetherNetwork;)Landroid/content/Context;

    move-result-object v1

    # invokes: Lcom/android/server/connectivity/TetherNetwork;->removeTetherDevices(Landroid/content/Context;)V
    invoke-static {v0, v1}, Lcom/android/server/connectivity/TetherNetwork;->access$800(Lcom/android/server/connectivity/TetherNetwork;Landroid/content/Context;)V

    goto/16 :goto_0

    .line 948
    :sswitch_1
    const-string v0, "TetherNetwork"

    const-string v1, "MSG_STOP_TETHER_NETWORK start"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 950
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkDataTrans:Lcom/android/server/connectivity/TetherNetworkDataTransition;
    invoke-static {v0}, Lcom/android/server/connectivity/TetherNetwork;->access$200(Lcom/android/server/connectivity/TetherNetwork;)Lcom/android/server/connectivity/TetherNetworkDataTransition;

    move-result-object v0

    if-eqz v0, :cond_11

    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkDataTrans:Lcom/android/server/connectivity/TetherNetworkDataTransition;
    invoke-static {v0}, Lcom/android/server/connectivity/TetherNetwork;->access$200(Lcom/android/server/connectivity/TetherNetwork;)Lcom/android/server/connectivity/TetherNetworkDataTransition;

    move-result-object v0

    invoke-virtual {v0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->getTetherNetworkDataFlagSet()Z

    move-result v0

    if-ne v0, v7, :cond_11

    .line 952
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkDataTrans:Lcom/android/server/connectivity/TetherNetworkDataTransition;
    invoke-static {v0}, Lcom/android/server/connectivity/TetherNetwork;->access$200(Lcom/android/server/connectivity/TetherNetwork;)Lcom/android/server/connectivity/TetherNetworkDataTransition;

    move-result-object v0

    invoke-virtual {v0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->isLteOrEhrpdNetwork()Z

    move-result v0

    if-nez v0, :cond_c

    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkDataTrans:Lcom/android/server/connectivity/TetherNetworkDataTransition;
    invoke-static {v0}, Lcom/android/server/connectivity/TetherNetwork;->access$200(Lcom/android/server/connectivity/TetherNetwork;)Lcom/android/server/connectivity/TetherNetworkDataTransition;

    move-result-object v0

    invoke-virtual {v0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->isGsmNetwork()Z

    move-result v0

    if-eqz v0, :cond_d

    .line 953
    :cond_c
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkDataTrans:Lcom/android/server/connectivity/TetherNetworkDataTransition;
    invoke-static {v0}, Lcom/android/server/connectivity/TetherNetwork;->access$200(Lcom/android/server/connectivity/TetherNetwork;)Lcom/android/server/connectivity/TetherNetworkDataTransition;

    move-result-object v0

    invoke-virtual {v0, v2}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->notifyPhoneTetherStatus(Z)Z

    move-result v0

    if-nez v0, :cond_0

    .line 955
    const-string v0, "TetherNetwork"

    const-string v1, "LTE, EHRPD : MSG_STOP_TETHER_NETWORK notifyPhoneTetherStatus error"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 961
    :cond_d
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkDataTrans:Lcom/android/server/connectivity/TetherNetworkDataTransition;
    invoke-static {v0}, Lcom/android/server/connectivity/TetherNetwork;->access$200(Lcom/android/server/connectivity/TetherNetwork;)Lcom/android/server/connectivity/TetherNetworkDataTransition;

    move-result-object v0

    invoke-virtual {v0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->disconnectMobile()Z

    move-result v0

    if-nez v0, :cond_e

    .line 962
    const-string v0, "TetherNetwork"

    const-string v1, "MSG_STOP_TETHER_NETWORK disconnectMobile error"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 964
    :cond_e
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkDataTrans:Lcom/android/server/connectivity/TetherNetworkDataTransition;
    invoke-static {v0}, Lcom/android/server/connectivity/TetherNetwork;->access$200(Lcom/android/server/connectivity/TetherNetwork;)Lcom/android/server/connectivity/TetherNetworkDataTransition;

    move-result-object v0

    invoke-virtual {v0, v2}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->notifyPhoneTetherStatus(Z)Z

    move-result v0

    if-nez v0, :cond_f

    .line 966
    const-string v0, "TetherNetwork"

    const-string v1, "MSG_STOP_TETHER_NETWORK notifyPhoneTetherStatus error"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 969
    :cond_f
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mTetherNetworkDataTrans:Lcom/android/server/connectivity/TetherNetworkDataTransition;
    invoke-static {v0}, Lcom/android/server/connectivity/TetherNetwork;->access$200(Lcom/android/server/connectivity/TetherNetwork;)Lcom/android/server/connectivity/TetherNetworkDataTransition;

    move-result-object v0

    invoke-virtual {v0}, Lcom/android/server/connectivity/TetherNetworkDataTransition;->connectMobileNoWait()Z

    move-result v0

    if-nez v0, :cond_10

    .line 970
    const-string v0, "TetherNetwork"

    const-string v1, "MSG_STOP_TETHER_NETWORK connectMobileNoWait error"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 972
    :cond_10
    const-string v0, "TetherNetwork"

    const-string v1, "Disconnect Succeeded!"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 976
    :cond_11
    const-string v0, "TetherNetwork"

    const-string v1, "MSG_STOP_TETHER_NETWORK mTetherNetworkDataTrans error"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 983
    :sswitch_2
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    invoke-virtual {v0}, Lcom/android/server/connectivity/TetherNetwork;->SendBroadcastTetheringError()V

    .line 986
    const-string v0, "TetherNetwork"

    const-string v1, "MSG_SHOW_MIP_ERR_DLG show Dialog for Mip Error"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 988
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mContext:Landroid/content/Context;
    invoke-static {v0}, Lcom/android/server/connectivity/TetherNetwork;->access$700(Lcom/android/server/connectivity/TetherNetwork;)Landroid/content/Context;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 990
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    iget-object v1, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mContext:Landroid/content/Context;
    invoke-static {v1}, Lcom/android/server/connectivity/TetherNetwork;->access$700(Lcom/android/server/connectivity/TetherNetwork;)Landroid/content/Context;

    move-result-object v1

    # invokes: Lcom/android/server/connectivity/TetherNetwork;->removeTetherDevices(Landroid/content/Context;)V
    invoke-static {v0, v1}, Lcom/android/server/connectivity/TetherNetwork;->access$800(Lcom/android/server/connectivity/TetherNetwork;Landroid/content/Context;)V

    .line 991
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    iget-object v1, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mContext:Landroid/content/Context;
    invoke-static {v1}, Lcom/android/server/connectivity/TetherNetwork;->access$700(Lcom/android/server/connectivity/TetherNetwork;)Landroid/content/Context;

    move-result-object v1

    # invokes: Lcom/android/server/connectivity/TetherNetwork;->showDialog(Landroid/content/Context;I)V
    invoke-static {v0, v1, v2}, Lcom/android/server/connectivity/TetherNetwork;->access$900(Lcom/android/server/connectivity/TetherNetwork;Landroid/content/Context;I)V

    goto/16 :goto_0

    .line 997
    :sswitch_3
    const-string v0, "TetherNetwork"

    const-string v1, "MSG_SHOW_REJECT_ERR_DLG show Dialog for Network Reject Error"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 999
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mContext:Landroid/content/Context;
    invoke-static {v0}, Lcom/android/server/connectivity/TetherNetwork;->access$700(Lcom/android/server/connectivity/TetherNetwork;)Landroid/content/Context;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 1001
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    iget-object v1, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mContext:Landroid/content/Context;
    invoke-static {v1}, Lcom/android/server/connectivity/TetherNetwork;->access$700(Lcom/android/server/connectivity/TetherNetwork;)Landroid/content/Context;

    move-result-object v1

    # invokes: Lcom/android/server/connectivity/TetherNetwork;->removeTetherDevices(Landroid/content/Context;)V
    invoke-static {v0, v1}, Lcom/android/server/connectivity/TetherNetwork;->access$800(Lcom/android/server/connectivity/TetherNetwork;Landroid/content/Context;)V

    .line 1002
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    iget-object v1, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mContext:Landroid/content/Context;
    invoke-static {v1}, Lcom/android/server/connectivity/TetherNetwork;->access$700(Lcom/android/server/connectivity/TetherNetwork;)Landroid/content/Context;

    move-result-object v1

    # invokes: Lcom/android/server/connectivity/TetherNetwork;->showDialog(Landroid/content/Context;I)V
    invoke-static {v0, v1, v7}, Lcom/android/server/connectivity/TetherNetwork;->access$900(Lcom/android/server/connectivity/TetherNetwork;Landroid/content/Context;I)V

    goto/16 :goto_0

    .line 1007
    :sswitch_4
    const-string v0, "TetherNetwork"

    const-string v1, "MSG_SHOW_NET_ERR_TOAST show Toast for Network Error"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1008
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mContext:Landroid/content/Context;
    invoke-static {v0}, Lcom/android/server/connectivity/TetherNetwork;->access$700(Lcom/android/server/connectivity/TetherNetwork;)Landroid/content/Context;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 1010
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    iget-object v1, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mContext:Landroid/content/Context;
    invoke-static {v1}, Lcom/android/server/connectivity/TetherNetwork;->access$700(Lcom/android/server/connectivity/TetherNetwork;)Landroid/content/Context;

    move-result-object v1

    # invokes: Lcom/android/server/connectivity/TetherNetwork;->removeTetherDevices(Landroid/content/Context;)V
    invoke-static {v0, v1}, Lcom/android/server/connectivity/TetherNetwork;->access$800(Lcom/android/server/connectivity/TetherNetwork;Landroid/content/Context;)V

    .line 1011
    iget-object v0, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    iget-object v1, p0, Lcom/android/server/connectivity/TetherNetwork$TetherNetworkHandler;->this$0:Lcom/android/server/connectivity/TetherNetwork;

    # getter for: Lcom/android/server/connectivity/TetherNetwork;->mContext:Landroid/content/Context;
    invoke-static {v1}, Lcom/android/server/connectivity/TetherNetwork;->access$700(Lcom/android/server/connectivity/TetherNetwork;)Landroid/content/Context;

    move-result-object v1

    const/4 v2, 0x0

    # invokes: Lcom/android/server/connectivity/TetherNetwork;->showToast(Landroid/content/Context;Ljava/lang/String;)V
    invoke-static {v0, v1, v2}, Lcom/android/server/connectivity/TetherNetwork;->access$1000(Lcom/android/server/connectivity/TetherNetwork;Landroid/content/Context;Ljava/lang/String;)V

    goto/16 :goto_0

    .line 862
    :sswitch_data_0
    .sparse-switch
        0x3f2 -> :sswitch_0
        0x3f3 -> :sswitch_1
        0x3fc -> :sswitch_2
        0x3fd -> :sswitch_3
        0x3fe -> :sswitch_4
    .end sparse-switch
.end method
