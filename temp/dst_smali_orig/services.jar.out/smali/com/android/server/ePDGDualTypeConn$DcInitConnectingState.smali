.class Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;
.super Lcom/android/internal/util/State;
.source "ePDGDualTypeConn.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/server/ePDGDualTypeConn;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "DcInitConnectingState"
.end annotation


# instance fields
.field isLTEConnected:Z

.field isUNKNOWNConnected:Z

.field isePDGConnected:Z

.field sendingResult:Lcom/android/server/ePDGConnInfo;

.field final synthetic this$0:Lcom/android/server/ePDGDualTypeConn;


# direct methods
.method private constructor <init>(Lcom/android/server/ePDGDualTypeConn;)V
    .locals 2

    .prologue
    const/4 v1, 0x0

    iput-object p1, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-direct {p0}, Lcom/android/internal/util/State;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    iput-boolean v1, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->isLTEConnected:Z

    iput-boolean v1, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->isePDGConnected:Z

    iput-boolean v1, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->isUNKNOWNConnected:Z

    return-void
.end method

.method synthetic constructor <init>(Lcom/android/server/ePDGDualTypeConn;Lcom/android/server/ePDGDualTypeConn$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/android/server/ePDGDualTypeConn;
    .param p2, "x1"    # Lcom/android/server/ePDGDualTypeConn$1;

    .prologue
    invoke-direct {p0, p1}, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;-><init>(Lcom/android/server/ePDGDualTypeConn;)V

    return-void
.end method


# virtual methods
.method public enter()V
    .locals 9

    .prologue
    const/16 v8, 0x138f

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v1, "DcInitConnectingState state enter"

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v1, "16"

    const-string v2, "0"

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v4, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v4, v4, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    invoke-virtual {v3, v4}, Lcom/android/server/ePDGDualTypeConn;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v3

    const-string v4, ""

    const-string v5, ""

    const-string v6, "0"

    const-string v7, "notused"

    invoke-virtual/range {v0 .. v7}, Lcom/android/server/ePDGDualTypeConn;->ePDGSetupDataCall(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v0, v0, Lcom/android/server/ePDGDualTypeConn;->mApn:Ljava/lang/String;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput v8, v0, Lcom/android/server/ePDGDualTypeConn;->mFailReason:I

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput v8, v0, Lcom/android/server/ePDGDualTypeConn;->mLastNetworkReason:I

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtFailwaitingState:Lcom/android/server/ePDGDualTypeConn$DcFailWaitingState;
    invoke-static {v1}, Lcom/android/server/ePDGDualTypeConn;->access$3600(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcFailWaitingState;

    move-result-object v1

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->access$3700(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    :cond_0
    return-void
.end method

.method public exit()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    iput-boolean v1, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->isLTEConnected:Z

    iput-boolean v1, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->isePDGConnected:Z

    iput-boolean v1, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->isUNKNOWNConnected:Z

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v1, "DcInitConnectingState state exit"

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    return-void
.end method

.method public processMessage(Landroid/os/Message;)Z
    .locals 12
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/16 v11, 0x138f

    const/16 v10, 0x63

    const/4 v2, 0x2

    const/4 v7, 0x1

    const/4 v1, 0x0

    iget v0, p1, Landroid/os/Message;->what:I

    sparse-switch v0, :sswitch_data_0

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "DcInitConnectingState nothandled msg.what=0x"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p1, Landroid/os/Message;->what:I

    invoke-static {v2}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    const/4 v9, 0x0

    .local v9, "retVal":Z
    :goto_0
    return v9

    .end local v9    # "retVal":Z
    :sswitch_0
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcInitConnectingState: EVENT_DELAYED_TEMP_COMPLETE"

    invoke-virtual {v0, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput-boolean v1, v0, Lcom/android/server/ePDGDualTypeConn;->isChangingRAT:Z

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-boolean v0, v0, Lcom/android/server/ePDGDualTypeConn;->isWaitingRAT:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput-boolean v1, v0, Lcom/android/server/ePDGDualTypeConn;->isWaitingRAT:Z

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v1, "16"

    const-string v2, "0"

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v4, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v4, v4, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    invoke-virtual {v3, v4}, Lcom/android/server/ePDGDualTypeConn;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v3

    const-string v4, ""

    const-string v5, ""

    const-string v6, "0"

    const-string v7, "notused"

    invoke-virtual/range {v0 .. v7}, Lcom/android/server/ePDGDualTypeConn;->ePDGSetupDataCall(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v0, v0, Lcom/android/server/ePDGDualTypeConn;->mApn:Ljava/lang/String;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput v11, v0, Lcom/android/server/ePDGDualTypeConn;->mFailReason:I

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput v11, v0, Lcom/android/server/ePDGDualTypeConn;->mLastNetworkReason:I

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtFailwaitingState:Lcom/android/server/ePDGDualTypeConn$DcFailWaitingState;
    invoke-static {v1}, Lcom/android/server/ePDGDualTypeConn;->access$3600(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcFailWaitingState;

    move-result-object v1

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->access$3800(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    :cond_0
    const/4 v9, 0x1

    .restart local v9    # "retVal":Z
    goto :goto_0

    .end local v9    # "retVal":Z
    :sswitch_1
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # invokes: Lcom/android/server/ePDGDualTypeConn;->deferMessage(Landroid/os/Message;)V
    invoke-static {v0, p1}, Lcom/android/server/ePDGDualTypeConn;->access$3900(Lcom/android/server/ePDGDualTypeConn;Landroid/os/Message;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v1, "DcInitConnectingState: EVENT_QOS_INFO can not be handled in DcHOConnectingState so defered."

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    const/4 v9, 0x1

    .restart local v9    # "retVal":Z
    goto :goto_0

    .end local v9    # "retVal":Z
    :sswitch_2
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcInitConnectingState Fail , type ="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->what:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "Reason"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const/16 v2, 0x138b

    iput v2, v0, Lcom/android/server/ePDGDualTypeConn;->mFailReason:I

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v2, p1, Landroid/os/Message;->arg1:I

    iput v2, v0, Lcom/android/server/ePDGDualTypeConn;->mLastNetworkReason:I

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v2, v2, Lcom/android/server/ePDGDualTypeConn;->mLastNetworkReason:I

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->currentPref:I

    invoke-virtual {v0, v2, v3}, Lcom/android/server/ePDGDualTypeConn;->checkNreason(II)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-boolean v2, v2, Lcom/android/server/ePDGDualTypeConn;->isWiFi:Z

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->mobileservicestate:I

    iget-object v4, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v4, v4, Lcom/android/server/ePDGDualTypeConn;->mobileRadioTech:I

    invoke-virtual {v0, v2, v3, v4}, Lcom/android/server/ePDGDualTypeConn;->onNetworkupdate(ZII)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v2, v2, Lcom/android/server/ePDGDualTypeConn;->mLastNetworkReason:I

    invoke-virtual {v0, v7, v2}, Lcom/android/server/ePDGDualTypeConn;->notifyePDGCompleted(II)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const/16 v2, 0xa

    invoke-virtual {v0, v2, v1}, Lcom/android/server/ePDGDualTypeConn;->notifyePDGCompleted(II)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtNoNetwork:Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;
    invoke-static {v1}, Lcom/android/server/ePDGDualTypeConn;->access$900(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcNonetworkState;

    move-result-object v1

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->access$4000(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    :goto_1
    const/4 v9, 0x1

    .restart local v9    # "retVal":Z
    goto/16 :goto_0

    .end local v9    # "retVal":Z
    :cond_1
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtFailwaitingState:Lcom/android/server/ePDGDualTypeConn$DcFailWaitingState;
    invoke-static {v1}, Lcom/android/server/ePDGDualTypeConn;->access$3600(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcFailWaitingState;

    move-result-object v1

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->access$4100(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    goto :goto_1

    :sswitch_3
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v1, "LTE connected: !"

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Ljava/lang/String;

    invoke-virtual {v1, v0}, Lcom/android/server/ePDGDualTypeConn;->onPCSChanged(Ljava/lang/String;)V

    const/4 v9, 0x1

    .restart local v9    # "retVal":Z
    goto/16 :goto_0

    .end local v9    # "retVal":Z
    :sswitch_4
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcInitConnectingState, EVENT_UNKNOWN_TECH"

    invoke-virtual {v0, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGDualTypeConn;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->cid:I

    invoke-virtual {v0, v2, v3, v1}, Lcom/android/server/ePDGDualTypeConn;->ePDGDeactivateDataCall(Ljava/lang/String;II)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput v10, v0, Lcom/android/server/ePDGDualTypeConn;->cid:I

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const/16 v2, 0x1391

    iput v2, v0, Lcom/android/server/ePDGDualTypeConn;->mFailReason:I

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput v1, v0, Lcom/android/server/ePDGDualTypeConn;->mLastNetworkReason:I

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtFailwaitingState:Lcom/android/server/ePDGDualTypeConn$DcFailWaitingState;
    invoke-static {v1}, Lcom/android/server/ePDGDualTypeConn;->access$3600(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcFailWaitingState;

    move-result-object v1

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->access$4200(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    :goto_2
    const/4 v9, 0x1

    .restart local v9    # "retVal":Z
    goto/16 :goto_0

    .end local v9    # "retVal":Z
    :cond_2
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v1, "DcInitConnectingState,EVENT_UNKNOWN_TECH is come without connect info"

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iput-boolean v7, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->isUNKNOWNConnected:Z

    goto :goto_2

    :sswitch_5
    iget-object v8, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v8, Landroid/os/AsyncResult;

    .local v8, "ar":Landroid/os/AsyncResult;
    iget-object v0, v8, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v0, Lcom/android/server/ePDGConnInfo;

    iput-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v3, "DcInitConnectingState, [ePDG] Connected Msg from RIL and wait tech ex"

    invoke-virtual {v0, v3}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v0, v0, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    if-ne v0, v7, :cond_3

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    iget-object v3, v3, Lcom/android/server/ePDGConnInfo;->mIpsecAddr:Ljava/lang/String;

    iget-object v4, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    iget-object v4, v4, Lcom/android/server/ePDGConnInfo;->mIface:Ljava/lang/String;

    iget-object v5, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    iget-object v5, v5, Lcom/android/server/ePDGConnInfo;->mIpsecGW:Ljava/lang/String;

    iget-object v6, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    iget-object v6, v6, Lcom/android/server/ePDGConnInfo;->mdnss:Ljava/lang/String;

    invoke-virtual/range {v0 .. v6}, Lcom/android/server/ePDGDualTypeConn;->notifyePDGCompleted(IILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtePDGConnectedState:Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;
    invoke-static {v3}, Lcom/android/server/ePDGDualTypeConn;->access$4300(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;

    move-result-object v3

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v0, v3}, Lcom/android/server/ePDGDualTypeConn;->access$4400(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    :cond_3
    iget-boolean v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->isLTEConnected:Z

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    iget-object v3, v2, Lcom/android/server/ePDGConnInfo;->mIpsecAddr:Ljava/lang/String;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    iget-object v4, v2, Lcom/android/server/ePDGConnInfo;->mIface:Ljava/lang/String;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    iget-object v5, v2, Lcom/android/server/ePDGConnInfo;->mIpsecGW:Ljava/lang/String;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    iget-object v6, v2, Lcom/android/server/ePDGConnInfo;->mdnss:Ljava/lang/String;

    move v2, v7

    invoke-virtual/range {v0 .. v6}, Lcom/android/server/ePDGDualTypeConn;->notifyePDGCompleted(IILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtLTEConnectedState:Lcom/android/server/ePDGDualTypeConn$DcLTEConnectedState;
    invoke-static {v1}, Lcom/android/server/ePDGDualTypeConn;->access$4500(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcLTEConnectedState;

    move-result-object v1

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->access$4600(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    :cond_4
    :goto_3
    const/4 v9, 0x1

    .restart local v9    # "retVal":Z
    goto/16 :goto_0

    .end local v9    # "retVal":Z
    :cond_5
    iget-boolean v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->isePDGConnected:Z

    if-eqz v0, :cond_6

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    if-eqz v0, :cond_6

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    iget-object v3, v3, Lcom/android/server/ePDGConnInfo;->mIpsecAddr:Ljava/lang/String;

    iget-object v4, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    iget-object v4, v4, Lcom/android/server/ePDGConnInfo;->mIface:Ljava/lang/String;

    iget-object v5, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    iget-object v5, v5, Lcom/android/server/ePDGConnInfo;->mIpsecGW:Ljava/lang/String;

    iget-object v6, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    iget-object v6, v6, Lcom/android/server/ePDGConnInfo;->mdnss:Ljava/lang/String;

    invoke-virtual/range {v0 .. v6}, Lcom/android/server/ePDGDualTypeConn;->notifyePDGCompleted(IILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtePDGConnectedState:Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;
    invoke-static {v1}, Lcom/android/server/ePDGDualTypeConn;->access$4300(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;

    move-result-object v1

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->access$4700(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    goto :goto_3

    :cond_6
    iget-boolean v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->isUNKNOWNConnected:Z

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->mFid:I

    invoke-virtual {v2, v3}, Lcom/android/server/ePDGDualTypeConn;->getAPNTypewithFid(I)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v3, v3, Lcom/android/server/ePDGDualTypeConn;->cid:I

    invoke-virtual {v0, v2, v3, v1}, Lcom/android/server/ePDGDualTypeConn;->ePDGDeactivateDataCall(Ljava/lang/String;II)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput v10, v0, Lcom/android/server/ePDGDualTypeConn;->cid:I

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const/16 v2, 0x1391

    iput v2, v0, Lcom/android/server/ePDGDualTypeConn;->mFailReason:I

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput v1, v0, Lcom/android/server/ePDGDualTypeConn;->mLastNetworkReason:I

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtFailwaitingState:Lcom/android/server/ePDGDualTypeConn$DcFailWaitingState;
    invoke-static {v1}, Lcom/android/server/ePDGDualTypeConn;->access$3600(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcFailWaitingState;

    move-result-object v1

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->access$4800(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    goto :goto_3

    .end local v8    # "ar":Landroid/os/AsyncResult;
    :sswitch_6
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcInitConnectingState, EVENT_LTE_CONNECTED"

    invoke-virtual {v0, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    if-eqz v0, :cond_7

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    iget-object v3, v2, Lcom/android/server/ePDGConnInfo;->mIpsecAddr:Ljava/lang/String;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    iget-object v4, v2, Lcom/android/server/ePDGConnInfo;->mIface:Ljava/lang/String;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    iget-object v5, v2, Lcom/android/server/ePDGConnInfo;->mIpsecGW:Ljava/lang/String;

    iget-object v2, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    iget-object v6, v2, Lcom/android/server/ePDGConnInfo;->mdnss:Ljava/lang/String;

    move v2, v7

    invoke-virtual/range {v0 .. v6}, Lcom/android/server/ePDGDualTypeConn;->notifyePDGCompleted(IILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtLTEConnectedState:Lcom/android/server/ePDGDualTypeConn$DcLTEConnectedState;
    invoke-static {v1}, Lcom/android/server/ePDGDualTypeConn;->access$4500(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcLTEConnectedState;

    move-result-object v1

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->access$4900(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    :goto_4
    const/4 v9, 0x1

    .restart local v9    # "retVal":Z
    goto/16 :goto_0

    .end local v9    # "retVal":Z
    :cond_7
    iput-boolean v7, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->isLTEConnected:Z

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v1, "DcInitConnectingState,EVENT_LTE_CONNECTED is come without connect info"

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto :goto_4

    :sswitch_7
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v3, "DcInitConnectingState, EVENT_EPDG_CONNECTED"

    invoke-virtual {v0, v3}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    if-eqz v0, :cond_8

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v3, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    iget-object v3, v3, Lcom/android/server/ePDGConnInfo;->mIpsecAddr:Ljava/lang/String;

    iget-object v4, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    iget-object v4, v4, Lcom/android/server/ePDGConnInfo;->mIface:Ljava/lang/String;

    iget-object v5, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    iget-object v5, v5, Lcom/android/server/ePDGConnInfo;->mIpsecGW:Ljava/lang/String;

    iget-object v6, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->sendingResult:Lcom/android/server/ePDGConnInfo;

    iget-object v6, v6, Lcom/android/server/ePDGConnInfo;->mdnss:Ljava/lang/String;

    invoke-virtual/range {v0 .. v6}, Lcom/android/server/ePDGDualTypeConn;->notifyePDGCompleted(IILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget-object v1, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # getter for: Lcom/android/server/ePDGDualTypeConn;->mDtePDGConnectedState:Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;
    invoke-static {v1}, Lcom/android/server/ePDGDualTypeConn;->access$4300(Lcom/android/server/ePDGDualTypeConn;)Lcom/android/server/ePDGDualTypeConn$DcePDGConnectedState;

    move-result-object v1

    # invokes: Lcom/android/server/ePDGDualTypeConn;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->access$5000(Lcom/android/server/ePDGDualTypeConn;Lcom/android/internal/util/IState;)V

    :goto_5
    const/4 v9, 0x1

    .restart local v9    # "retVal":Z
    goto/16 :goto_0

    .end local v9    # "retVal":Z
    :cond_8
    iput-boolean v7, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->isePDGConnected:Z

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v1, "DcInitConnectingState, EVENT_EPDG_CONNECTED is come without connect info"

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    goto :goto_5

    :sswitch_8
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v2, "DcInitConnectingState,EVENT_USER_DISCONNECT, it will be disconnected after conneted"

    invoke-virtual {v0, v2}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput-boolean v1, v0, Lcom/android/server/ePDGDualTypeConn;->isDCwaiting:Z

    const/4 v9, 0x1

    .restart local v9    # "retVal":Z
    goto/16 :goto_0

    .end local v9    # "retVal":Z
    :sswitch_9
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v1, "DcInitConnectingState: msg.what=EVENT_PDN_PRI_CH, we will do after state changed"

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # invokes: Lcom/android/server/ePDGDualTypeConn;->deferMessage(Landroid/os/Message;)V
    invoke-static {v0, p1}, Lcom/android/server/ePDGDualTypeConn;->access$5100(Lcom/android/server/ePDGDualTypeConn;Landroid/os/Message;)V

    const/4 v9, 0x1

    .restart local v9    # "retVal":Z
    goto/16 :goto_0

    .end local v9    # "retVal":Z
    :sswitch_a
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    const-string v1, "DcInitConnectingState: EVENT_APN_CHANGED, deffer!! "

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # invokes: Lcom/android/server/ePDGDualTypeConn;->deferMessage(Landroid/os/Message;)V
    invoke-static {v0, p1}, Lcom/android/server/ePDGDualTypeConn;->access$5200(Lcom/android/server/ePDGDualTypeConn;Landroid/os/Message;)V

    const/4 v9, 0x1

    .restart local v9    # "retVal":Z
    goto/16 :goto_0

    .end local v9    # "retVal":Z
    :sswitch_b
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DcInitConnectingState: EVENT_WIFI_CONNECT_DETAIL "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v3, p1, Landroid/os/Message;->arg1:I

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/android/server/ePDGDualTypeConn;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v0, v0, Lcom/android/server/ePDGDualTypeConn;->currentPref:I

    if-ne v0, v2, :cond_9

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    # invokes: Lcom/android/server/ePDGDualTypeConn;->deferMessage(Landroid/os/Message;)V
    invoke-static {v0, p1}, Lcom/android/server/ePDGDualTypeConn;->access$5300(Lcom/android/server/ePDGDualTypeConn;Landroid/os/Message;)V

    :goto_6
    const/4 v9, 0x1

    .restart local v9    # "retVal":Z
    goto/16 :goto_0

    .end local v9    # "retVal":Z
    :cond_9
    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iput-boolean v7, v0, Lcom/android/server/ePDGDualTypeConn;->isWiFi:Z

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    iget v1, p1, Landroid/os/Message;->arg1:I

    iput v1, v0, Lcom/android/server/ePDGDualTypeConn;->wifiDetailedState:I

    iget-object v0, p0, Lcom/android/server/ePDGDualTypeConn$DcInitConnectingState;->this$0:Lcom/android/server/ePDGDualTypeConn;

    invoke-virtual {v0}, Lcom/android/server/ePDGDualTypeConn;->checkwifidetailstatus()V

    goto :goto_6

    nop

    :sswitch_data_0
    .sparse-switch
        0x40005 -> :sswitch_5
        0x40006 -> :sswitch_2
        0x40009 -> :sswitch_8
        0x4000e -> :sswitch_3
        0x4000f -> :sswitch_1
        0x40010 -> :sswitch_9
        0x40012 -> :sswitch_6
        0x40013 -> :sswitch_7
        0x4001b -> :sswitch_a
        0x40021 -> :sswitch_0
        0x40022 -> :sswitch_4
        0x40024 -> :sswitch_b
    .end sparse-switch
.end method
