.class Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;
.super Lcom/android/internal/util/State;
.source "ePDGDualTypeConn.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/server/ePDGDualTypeConn;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "DcePDGConnectedState"
.end annotation


# instance fields
.field public mTimecount:I

.field final synthetic this$0:Lcom/android/server/ePDGDualTypeConn;


# direct methods
.method private constructor <init>(Lcom/android/server/ePDGDualTypeConn;)V
    .locals 1

    .prologue
    .line 1836
    iput-object p1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-direct {p0}, Lcom/android/internal/util/State;-><init>()V

    .line 1839
    const/4 v0, 0x0

    iput v0, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->mTimecount:I

    return-void
.end method

.method synthetic constructor <init>(Lcom/android/server/ePDGDualTypeConn;Lcom/android/server/ePDGDualTypeConn$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p2, "x1"    # Lcom/android/server/ePDGDualTypeConn$1;

    .prologue
    .line 1836
    invoke-direct {p0, p1}, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;-><init>(Lcom/android/server/ePDGDualTypeConn;)V

    return-void
.end method


# virtual methods
.method public enter()V
    .locals 4

    .prologue
    .line 1844
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v1, "DcePDGConnectedState : enter"

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 1850
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const v2, 0x4001f

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    const-wide/16 v2, 0xbb8

    invoke-virtual {v0, v1, v2, v3}, Lcom/android/server/ePDGDualTypeConn;->sendMessageDelayed(Landroid/os/Message;J)V

    .line 1852
    return-void
.end method

.method public exit()V
    .locals 2

    .prologue
    .line 1858
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v1, "DcePDGConnectedState : exit"

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 1861
    const/4 v0, 0x0

    iput v0, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->mTimecount:I

    .line 1862
    return-void
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 10
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const-wide/16 v8, 0xbb8

    const v7, 0x4001f

    const/4 v4, 0x1

    const/16 v6, 0x63

    const/4 v5, 0x0

    .line 1869
    iget v1, p1, Landroid/os/Message;->what:I

    packed-switch v1, :pswitch_data_0

    .line 2113
    :pswitch_0
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcePDGConnectedState nothandled msg.what=0x"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->what:I

    invoke-static {v3}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 2116
    const/4 v0, 0x0

    .line 2119
    .local v0, "retVal":Z
    :goto_0
    return v0

    .line 1873
    .end local v0    # "retVal":Z
    :pswitch_1
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcePDGConnectedState : : EVENT_CALLSTATUS_CH "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 1874
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v2, p1, Landroid/os/Message;->arg1:I

    iput v2, v1, Lcom/android/server/ePDGDualTypeConn;->CallState:I

    .line 1876
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v1, v1, Lcom/android/server/ePDGDualTypeConn;->CallState:I

    if-nez v1, :cond_0

    .line 1878
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-boolean v2, v2, Lcom/android/server/ePDGDualTypeConn;->isWiFi:Z

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->mobileservicestate:I

    iget-object v4, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v4, v4, Lcom/android/server/ePDGDualTypeConn;->mobileRadioTech:I

    invoke-virtual {v1, v2, v3, v4}, Lcom/android/server/ePDGDualTypeConn;->onNetworkupdate(ZII)Z

    move-result v1

    if-nez v1, :cond_0

    .line 1880
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGDualTypeConn;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->cid:I

    invoke-virtual {v1, v2, v3, v5}, Lcom/android/server/ePDGDualTypeConn;->ePDGDeactivateDataCall(Ljava/lang/String;II)V

    .line 1881
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput v6, v1, Lcom/android/server/ePDGDualTypeConn;->cid:I

    .line 1882
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcePDGConnectedState 2G/3G with celluar prefer, so deactivate and prefer change "

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 1883
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    .line 1884
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtDisconnectingState:Lcom/android/server/ePDGDualTypeConn$DcDisconnectingState;
    invoke-static {v2}, Lcom/android/server/ePDGDualTypeConn;->access$5400(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcDisconnectingState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->access$6200(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    .line 1887
    :cond_0
    const/4 v0, 0x1

    .line 1888
    .restart local v0    # "retVal":Z
    goto :goto_0

    .line 1893
    .end local v0    # "retVal":Z
    :pswitch_2
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-boolean v2, v2, Lcom/android/server/ePDGDualTypeConn;->isWiFi:Z

    iget v3, p1, Landroid/os/Message;->arg1:I

    iget v4, p1, Landroid/os/Message;->arg2:I

    invoke-virtual {v1, v2, v3, v4}, Lcom/android/server/ePDGDualTypeConn;->onNetworkupdate(ZII)Z

    move-result v1

    if-nez v1, :cond_2

    .line 1895
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcePDGConnectedState : NETWORK is not available "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " tech"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->arg2:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 1897
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v1, v1, Lcom/android/server/ePDGDualTypeConn;->CallState:I

    if-nez v1, :cond_1

    .line 1899
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGDualTypeConn;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->cid:I

    invoke-virtual {v1, v2, v3, v5}, Lcom/android/server/ePDGDualTypeConn;->ePDGDeactivateDataCall(Ljava/lang/String;II)V

    .line 1900
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput v6, v1, Lcom/android/server/ePDGDualTypeConn;->cid:I

    .line 1901
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcePDGConnectedState 2G/3G with celluar prefer, so deactivate and prefer change "

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 1902
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    .line 1903
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtDisconnectingState:Lcom/android/server/ePDGDualTypeConn$DcDisconnectingState;
    invoke-static {v2}, Lcom/android/server/ePDGDualTypeConn;->access$5400(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcDisconnectingState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->access$6300(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    .line 1911
    :cond_1
    :goto_1
    const/4 v0, 0x1

    .line 1913
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 1908
    .end local v0    # "retVal":Z
    :cond_2
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcePDGConnectedState : NETWORK is still available wifi  "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-boolean v3, v3, Lcom/android/server/ePDGDualTypeConn;->isWiFi:Z

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " service "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " tech"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->arg2:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 1909
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    goto :goto_1

    .line 1917
    :pswitch_3
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, " DcePDGConnectedState : Connected msg.what=EVENT_QOS_INFO"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 1918
    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v1, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v1, Ljava/lang/String;

    invoke-virtual {v2, v1}, Lcom/android/server/ePDGDualTypeConn;->onQoSChanged(Ljava/lang/String;)V

    .line 1919
    const/4 v0, 0x1

    .line 1920
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 1923
    .end local v0    # "retVal":Z
    :pswitch_4
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcePDGConnectedState ePDG connected: !"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 1924
    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v1, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v1, Ljava/lang/String;

    invoke-virtual {v2, v1}, Lcom/android/server/ePDGDualTypeConn;->onPCSChanged(Ljava/lang/String;)V

    .line 1925
    const/4 v0, 0x1

    .line 1926
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 1931
    .end local v0    # "retVal":Z
    :pswitch_5
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput v6, v1, Lcom/android/server/ePDGDualTypeConn;->cid:I

    .line 1932
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const/4 v2, 0x3

    iget v3, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v1, v2, v3}, Lcom/android/server/ePDGDualTypeConn;->notifyePDGCompleted(II)V

    .line 1933
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcePDGConnectedState : EVENT_DISCONNECTED!"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 1934
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->changeSigLevel()V

    .line 1936
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-boolean v2, v2, Lcom/android/server/ePDGDualTypeConn;->isWiFi:Z

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->mobileservicestate:I

    iget-object v4, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v4, v4, Lcom/android/server/ePDGDualTypeConn;->mobileRadioTech:I

    invoke-virtual {v1, v2, v3, v4}, Lcom/android/server/ePDGDualTypeConn;->onNetworkupdate(ZII)Z

    move-result v1

    if-nez v1, :cond_3

    .line 1938
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    .line 1939
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtNoNetwork:Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;
    invoke-static {v2}, Lcom/android/server/ePDGDualTypeConn;->access$900(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->access$6400(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    .line 1947
    :goto_2
    const/4 v0, 0x1

    .line 1949
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 1943
    .end local v0    # "retVal":Z
    :cond_3
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    .line 1944
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtReadyState:Lcom/android/server/ePDGDualTypeConn$DcReadyState;
    invoke-static {v2}, Lcom/android/server/ePDGDualTypeConn;->access$1100(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcReadyState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->access$6500(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    goto :goto_2

    .line 1955
    :pswitch_6
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcePDGConnectedState : EVENT_USER_DISCONNECT"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 1957
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput-boolean v5, v1, Lcom/android/server/ePDGDualTypeConn;->isDCwaiting:Z

    .line 1958
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGDualTypeConn;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->cid:I

    invoke-virtual {v1, v2, v3, v5}, Lcom/android/server/ePDGDualTypeConn;->ePDGDeactivateDataCall(Ljava/lang/String;II)V

    .line 1959
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput v6, v1, Lcom/android/server/ePDGDualTypeConn;->cid:I

    .line 1960
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtDisconnectingState:Lcom/android/server/ePDGDualTypeConn$DcDisconnectingState;
    invoke-static {v2}, Lcom/android/server/ePDGDualTypeConn;->access$5400(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcDisconnectingState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->access$6600(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    .line 1961
    const/4 v0, 0x1

    .line 1963
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 1967
    .end local v0    # "retVal":Z
    :pswitch_7
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcePDGConnectedState: msg.what=EVENT_WIFI_DISCONNECT"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 1968
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput-boolean v5, v1, Lcom/android/server/ePDGDualTypeConn;->isWiFi:Z

    .line 1969
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v1, v1, Lcom/android/server/ePDGDualTypeConn;->mMyFixedinfo:Lcom/android/server/ePDGFixedInfo;

    invoke-virtual {v1}, Lcom/android/server/ePDGFixedInfo;->resetePDGBlock()V

    .line 1972
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-boolean v2, v2, Lcom/android/server/ePDGDualTypeConn;->isWiFi:Z

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->mobileservicestate:I

    iget-object v4, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v4, v4, Lcom/android/server/ePDGDualTypeConn;->mobileRadioTech:I

    invoke-virtual {v1, v2, v3, v4}, Lcom/android/server/ePDGDualTypeConn;->onNetworkupdate(ZII)Z

    move-result v1

    if-nez v1, :cond_4

    .line 1974
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGDualTypeConn;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->cid:I

    invoke-virtual {v1, v2, v3, v5}, Lcom/android/server/ePDGDualTypeConn;->ePDGDeactivateDataCall(Ljava/lang/String;II)V

    .line 1975
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput v6, v1, Lcom/android/server/ePDGDualTypeConn;->cid:I

    .line 1976
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcePDGConnectedState : EVENT_WIFI_DISCONNECT and LTE is not available. so deactivate and prefer change "

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 1977
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    .line 1978
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtDisconnectingState:Lcom/android/server/ePDGDualTypeConn$DcDisconnectingState;
    invoke-static {v2}, Lcom/android/server/ePDGDualTypeConn;->access$5400(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcDisconnectingState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->access$6700(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    .line 1985
    :goto_3
    const/4 v0, 0x1

    .line 1986
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 1982
    .end local v0    # "retVal":Z
    :cond_4
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    .line 1983
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcePDGConnectedState : EVENT_WIFI_DISCONNECT and LTE is available. so wait EVENT_LTE_CONNECTED "

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto :goto_3

    .line 1989
    :pswitch_8
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcePDGConnectedState : and ePDG connected again !! what happen"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 1990
    const/4 v0, 0x1

    .line 1991
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 1994
    .end local v0    # "retVal":Z
    :pswitch_9
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcePDGConnectedState : msg.what=EVENT_LTE_CONNECTED"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 1995
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const/4 v2, 0x6

    invoke-virtual {v1, v2, v5}, Lcom/android/server/ePDGDualTypeConn;->notifyePDGCompleted(II)V

    .line 1996
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->changeSigLevel()V

    .line 1997
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtLTEConnectedState:Lcom/android/server/ePDGDualTypeConn$DcLTEConnectedState;
    invoke-static {v2}, Lcom/android/server/ePDGDualTypeConn;->access$4500(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcLTEConnectedState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->access$6800(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    .line 1998
    const/4 v0, 0x1

    .line 2000
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 2003
    .end local v0    # "retVal":Z
    :pswitch_a
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcePDGConnectedState : and handover fail we staill remain ePDG!!"

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 2004
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const/16 v2, 0x138d

    invoke-virtual {v1, v2, v5}, Lcom/android/server/ePDGDualTypeConn;->notifyePDGCompleted(II)V

    .line 2005
    const/4 v0, 0x1

    .line 2006
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 2009
    .end local v0    # "retVal":Z
    :pswitch_b
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcePDGConnectedState : EVENT_WFCSETTING_CH "

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 2010
    iget v1, p1, Landroid/os/Message;->arg1:I

    if-eq v1, v4, :cond_5

    .line 2011
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput-boolean v5, v1, Lcom/android/server/ePDGDualTypeConn;->WFCSettings:Z

    .line 2015
    :goto_4
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v1, v1, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    if-ne v1, v4, :cond_6

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-boolean v1, v1, Lcom/android/server/ePDGDualTypeConn;->WFCSettings:Z

    if-nez v1, :cond_6

    .line 2017
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGDualTypeConn;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->cid:I

    invoke-virtual {v1, v2, v3, v5}, Lcom/android/server/ePDGDualTypeConn;->ePDGDeactivateDataCall(Ljava/lang/String;II)V

    .line 2018
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput v6, v1, Lcom/android/server/ePDGDualTypeConn;->cid:I

    .line 2019
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->changeSigLevel()V

    .line 2020
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtDisconnectingState:Lcom/android/server/ePDGDualTypeConn$DcDisconnectingState;
    invoke-static {v2}, Lcom/android/server/ePDGDualTypeConn;->access$5400(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcDisconnectingState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->access$6900(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    .line 2021
    const/4 v0, 0x1

    .line 2037
    :goto_5
    const/4 v0, 0x1

    .line 2038
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 2013
    .end local v0    # "retVal":Z
    :cond_5
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput-boolean v4, v1, Lcom/android/server/ePDGDualTypeConn;->WFCSettings:Z

    goto :goto_4

    .line 2024
    :cond_6
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v1, v1, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    if-nez v1, :cond_7

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-boolean v1, v1, Lcom/android/server/ePDGDualTypeConn;->WFCSettings:Z

    if-nez v1, :cond_7

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v1, v1, Lcom/android/server/ePDGDualTypeConn;->mobileRadioTech:I

    const/16 v2, 0xe

    if-eq v1, v2, :cond_7

    .line 2026
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGDualTypeConn;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->cid:I

    invoke-virtual {v1, v2, v3, v5}, Lcom/android/server/ePDGDualTypeConn;->ePDGDeactivateDataCall(Ljava/lang/String;II)V

    .line 2027
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput v6, v1, Lcom/android/server/ePDGDualTypeConn;->cid:I

    .line 2028
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    .line 2029
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->changeSigLevel()V

    .line 2030
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtDisconnectingState:Lcom/android/server/ePDGDualTypeConn$DcDisconnectingState;
    invoke-static {v2}, Lcom/android/server/ePDGDualTypeConn;->access$5400(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcDisconnectingState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->access$7000(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    .line 2031
    const/4 v0, 0x1

    .restart local v0    # "retVal":Z
    goto :goto_5

    .line 2035
    .end local v0    # "retVal":Z
    :cond_7
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    goto :goto_5

    .line 2041
    :pswitch_c
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcePDGConnectedState: EVENT_APN_CHANGED,!! "

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 2042
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->onDisconnectTrigger()V

    .line 2043
    const/4 v0, 0x1

    .line 2044
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 2048
    .end local v0    # "retVal":Z
    :pswitch_d
    iget v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->mTimecount:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->mTimecount:I

    .line 2049
    iget v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->mTimecount:I

    rem-int/lit8 v1, v1, 0xa

    if-ne v1, v4, :cond_8

    .line 2051
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcePDGConnectedState!!! : EVENT_EPDG_TIME "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->mTimecount:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 2054
    :cond_8
    iget v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->mTimecount:I

    const/4 v2, 0x2

    if-ge v1, v2, :cond_9

    .line 2056
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    .line 2057
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v2, v7}, Lcom/android/server/ePDGDualTypeConn;->obtainMessage(I)Landroid/os/Message;

    move-result-object v2

    invoke-virtual {v1, v2, v8, v9}, Lcom/android/server/ePDGDualTypeConn;->sendMessageDelayed(Landroid/os/Message;J)V

    .line 2058
    const/4 v0, 0x1

    .line 2059
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 2062
    .end local v0    # "retVal":Z
    :cond_9
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v2, v7}, Lcom/android/server/ePDGDualTypeConn;->obtainMessage(I)Landroid/os/Message;

    move-result-object v2

    invoke-virtual {v1, v2, v8, v9}, Lcom/android/server/ePDGDualTypeConn;->sendMessageDelayed(Landroid/os/Message;J)V

    .line 2064
    const/4 v0, 0x1

    .line 2065
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 2068
    .end local v0    # "retVal":Z
    :pswitch_e
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcePDGConnectedState: EVENT_WIFI_CONNECT_DETAIL,!! "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 2069
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput-boolean v4, v1, Lcom/android/server/ePDGDualTypeConn;->isWiFi:Z

    .line 2070
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v2, p1, Landroid/os/Message;->arg1:I

    iput v2, v1, Lcom/android/server/ePDGDualTypeConn;->wifiDetailedState:I

    .line 2071
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->checkwifidetailstatus()V

    .line 2073
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->checkohterRATandDiscon()Z

    move-result v1

    if-eqz v1, :cond_a

    .line 2075
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcePDGConnectedState :Sig is Low and no LTE area so drop the PDN "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->mTimecount:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 2076
    const/4 v0, 0x1

    .line 2077
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 2080
    .end local v0    # "retVal":Z
    :cond_a
    iget v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->mTimecount:I

    if-le v1, v4, :cond_b

    .line 2082
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->determinePrefer()V

    .line 2088
    :goto_6
    const/4 v0, 0x1

    .line 2089
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 2086
    .end local v0    # "retVal":Z
    :cond_b
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcePDGConnectedState :we wait more mTimecount= "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->mTimecount:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto :goto_6

    .line 2093
    :pswitch_f
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcePDGConnectedState: EVENT_APN_CHANGED detail=,!! "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->what:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    .line 2094
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput-boolean v5, v1, Lcom/android/server/ePDGDualTypeConn;->isWaitingDereig:Z

    .line 2095
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGDualTypeConn;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->cid:I

    invoke-virtual {v1, v2, v3, v5}, Lcom/android/server/ePDGDualTypeConn;->ePDGDeactivateDataCall(Ljava/lang/String;II)V

    .line 2096
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput v6, v1, Lcom/android/server/ePDGDualTypeConn;->cid:I

    .line 2097
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v1}, Lcom/android/server/ePDGDualTypeConn;->changeSigLevel()V

    .line 2098
    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtDisconnectingState:Lcom/android/server/ePDGDualTypeConn$DcDisconnectingState;
    invoke-static {v2}, Lcom/android/server/ePDGDualTypeConn;->access$5400(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcDisconnectingState;

    move-result-object v2

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v1, v2}, Lcom/android/server/ePDGDualTypeConn;->access$7100(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    .line 2099
    const/4 v0, 0x1

    .line 2100
    .restart local v0    # "retVal":Z
    goto/16 :goto_0

    .line 1869
    nop

    :pswitch_data_0
    .packed-switch 0x40001
        :pswitch_7
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_5
        :pswitch_0
        :pswitch_0
        :pswitch_6
        :pswitch_0
        :pswitch_0
        :pswitch_a
        :pswitch_0
        :pswitch_4
        :pswitch_3
        :pswitch_0
        :pswitch_2
        :pswitch_9
        :pswitch_8
        :pswitch_0
        :pswitch_1
        :pswitch_b
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_c
        :pswitch_f
        :pswitch_f
        :pswitch_0
        :pswitch_d
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_e
    .end packed-switch
.end method
