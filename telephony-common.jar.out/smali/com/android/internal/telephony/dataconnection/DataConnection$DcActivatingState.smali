.class Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;
.super Lcom/android/internal/util/State;
.source "DataConnection.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/dataconnection/DataConnection;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "DcActivatingState"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;


# direct methods
.method private constructor <init>(Lcom/android/internal/telephony/dataconnection/DataConnection;)V
    .locals 0

    .prologue
    .line 2199
    iput-object p1, p0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    invoke-direct {p0}, Lcom/android/internal/util/State;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/android/internal/telephony/dataconnection/DataConnection;Lcom/android/internal/telephony/dataconnection/DataConnection$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/android/internal/telephony/dataconnection/DataConnection;
    .param p2, "x1"    # Lcom/android/internal/telephony/dataconnection/DataConnection$1;

    .prologue
    .line 2199
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;-><init>(Lcom/android/internal/telephony/dataconnection/DataConnection;)V

    return-void
.end method


# virtual methods
.method public processMessage(Landroid/os/Message;)Z
    .locals 16
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 2206
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "DcActivatingState: msg="

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    # invokes: Lcom/android/internal/telephony/dataconnection/DataConnection;->msgToString(Landroid/os/Message;)Ljava/lang/String;
    invoke-static/range {p1 .. p1}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$000(Landroid/os/Message;)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2207
    move-object/from16 v0, p1

    iget v12, v0, Landroid/os/Message;->what:I

    sparse-switch v12, :sswitch_data_0

    .line 2463
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "DcActivatingState not handled msg.what="

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    move-object/from16 v0, p1

    iget v15, v0, Landroid/os/Message;->what:I

    invoke-virtual {v14, v15}, Lcom/android/internal/telephony/dataconnection/DataConnection;->getWhatToString(I)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, " RefCount="

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    iget-object v14, v14, Lcom/android/internal/telephony/dataconnection/DataConnection;->mApnContexts:Ljava/util/List;

    invoke-interface {v14}, Ljava/util/List;->size()I

    move-result v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2466
    const/4 v9, 0x0

    .line 2469
    .local v9, "retVal":Z
    :goto_0
    return v9

    .line 2211
    .end local v9    # "retVal":Z
    :sswitch_0
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    move-object/from16 v0, p1

    # invokes: Lcom/android/internal/telephony/dataconnection/DataConnection;->deferMessage(Landroid/os/Message;)V
    invoke-static {v12, v0}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$5100(Lcom/android/internal/telephony/dataconnection/DataConnection;Landroid/os/Message;)V

    .line 2212
    const/4 v9, 0x1

    .line 2213
    .restart local v9    # "retVal":Z
    goto :goto_0

    .line 2217
    .end local v9    # "retVal":Z
    :sswitch_1
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    const-string v13, "DcActivatingState msg.what=EVENT_QOS_CHANGED"

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2219
    sget-object v12, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_QOS_NOTIFY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v12}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v12

    if-eqz v12, :cond_0

    .line 2221
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    move-object/from16 v0, p1

    # invokes: Lcom/android/internal/telephony/dataconnection/DataConnection;->deferMessage(Landroid/os/Message;)V
    invoke-static {v12, v0}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$5200(Lcom/android/internal/telephony/dataconnection/DataConnection;Landroid/os/Message;)V

    .line 2222
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    const-string v13, "DcActivatingState: EVENT_QOS_CHANGED can not be handled in DcActivatingState so defered."

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2225
    :cond_0
    const/4 v9, 0x1

    .line 2226
    .restart local v9    # "retVal":Z
    goto :goto_0

    .line 2230
    .end local v9    # "retVal":Z
    :sswitch_2
    move-object/from16 v0, p1

    iget-object v2, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v2, Landroid/os/AsyncResult;

    .line 2231
    .local v2, "ar":Landroid/os/AsyncResult;
    iget-object v4, v2, Landroid/os/AsyncResult;->userObj:Ljava/lang/Object;

    check-cast v4, Lcom/android/internal/telephony/dataconnection/DataConnection$ConnectionParams;

    .line 2233
    .local v4, "cp":Lcom/android/internal/telephony/dataconnection/DataConnection$ConnectionParams;
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # invokes: Lcom/android/internal/telephony/dataconnection/DataConnection;->onSetupConnectionCompleted(Landroid/os/AsyncResult;)Lcom/android/internal/telephony/dataconnection/DataCallResponse$SetupResult;
    invoke-static {v12, v2}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$5300(Lcom/android/internal/telephony/dataconnection/DataConnection;Landroid/os/AsyncResult;)Lcom/android/internal/telephony/dataconnection/DataCallResponse$SetupResult;

    move-result-object v8

    .line 2234
    .local v8, "result":Lcom/android/internal/telephony/dataconnection/DataCallResponse$SetupResult;
    sget-object v12, Lcom/android/internal/telephony/dataconnection/DataCallResponse$SetupResult;->ERR_Stale:Lcom/android/internal/telephony/dataconnection/DataCallResponse$SetupResult;

    if-eq v8, v12, :cond_1

    .line 2235
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mConnectionParams:Lcom/android/internal/telephony/dataconnection/DataConnection$ConnectionParams;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$2700(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DataConnection$ConnectionParams;

    move-result-object v12

    if-eq v12, v4, :cond_1

    .line 2236
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "DcActivatingState: WEIRD mConnectionsParams:"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mConnectionParams:Lcom/android/internal/telephony/dataconnection/DataConnection$ConnectionParams;
    invoke-static {v14}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$2700(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DataConnection$ConnectionParams;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, " != cp:"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->loge(Ljava/lang/String;)V

    .line 2242
    :cond_1
    sget-object v12, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DEBUG_ENABLE_PRIVACY_LOG:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v12}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v12

    if-eqz v12, :cond_2

    .line 2243
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "DcActivatingState onSetupConnectionCompleted result="

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, " dc="

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2248
    :cond_2
    sget-object v12, Lcom/android/internal/telephony/dataconnection/DataConnection$1;->$SwitchMap$com$android$internal$telephony$dataconnection$DataCallResponse$SetupResult:[I

    invoke-virtual {v8}, Lcom/android/internal/telephony/dataconnection/DataCallResponse$SetupResult;->ordinal()I

    move-result v13

    aget v12, v12, v13

    packed-switch v12, :pswitch_data_0

    .line 2384
    new-instance v12, Ljava/lang/RuntimeException;

    const-string v13, "Unknown SetupResult, should not happen"

    invoke-direct {v12, v13}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v12

    .line 2251
    :pswitch_0
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    sget-object v13, Lcom/android/internal/telephony/dataconnection/DcFailCause;->NONE:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    # setter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mDcFailCause:Lcom/android/internal/telephony/dataconnection/DcFailCause;
    invoke-static {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$2902(Lcom/android/internal/telephony/dataconnection/DataConnection;Lcom/android/internal/telephony/dataconnection/DcFailCause;)Lcom/android/internal/telephony/dataconnection/DcFailCause;

    .line 2252
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mActiveState:Lcom/android/internal/telephony/dataconnection/DataConnection$DcActiveState;
    invoke-static {v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$5400(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DataConnection$DcActiveState;

    move-result-object v13

    # invokes: Lcom/android/internal/telephony/dataconnection/DataConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$5500(Lcom/android/internal/telephony/dataconnection/DataConnection;Lcom/android/internal/util/IState;)V

    .line 2386
    :goto_1
    const/4 v9, 0x1

    .line 2387
    .restart local v9    # "retVal":Z
    goto/16 :goto_0

    .line 2258
    .end local v9    # "retVal":Z
    :pswitch_1
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mInactiveState:Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$1200(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;

    move-result-object v12

    iget-object v13, v8, Lcom/android/internal/telephony/dataconnection/DataCallResponse$SetupResult;->mFailCause:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    invoke-virtual {v12, v4, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;->setEnterNotificationParams(Lcom/android/internal/telephony/dataconnection/DataConnection$ConnectionParams;Lcom/android/internal/telephony/dataconnection/DcFailCause;)V

    .line 2259
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mInactiveState:Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;
    invoke-static {v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$1200(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;

    move-result-object v13

    # invokes: Lcom/android/internal/telephony/dataconnection/DataConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$5600(Lcom/android/internal/telephony/dataconnection/DataConnection;Lcom/android/internal/util/IState;)V

    goto :goto_1

    .line 2263
    :pswitch_2
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # invokes: Lcom/android/internal/telephony/dataconnection/DataConnection;->tearDownData(Ljava/lang/Object;)V
    invoke-static {v12, v4}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$5700(Lcom/android/internal/telephony/dataconnection/DataConnection;Ljava/lang/Object;)V

    .line 2264
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mDisconnectingErrorCreatingConnection:Lcom/android/internal/telephony/dataconnection/DataConnection$DcDisconnectionErrorCreatingConnection;
    invoke-static {v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$5800(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DataConnection$DcDisconnectionErrorCreatingConnection;

    move-result-object v13

    # invokes: Lcom/android/internal/telephony/dataconnection/DataConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$5900(Lcom/android/internal/telephony/dataconnection/DataConnection;Lcom/android/internal/util/IState;)V

    goto :goto_1

    .line 2268
    :pswitch_3
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "[RIL_RESET]getRetryCount     : "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    iget-object v14, v14, Lcom/android/internal/telephony/dataconnection/DataConnection;->mRetryManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v14}, Lcom/android/internal/telephony/RetryManager;->getRetryCount()I

    move-result v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2269
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "[RIL_RESET]getRetryTimer     : "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    iget-object v14, v14, Lcom/android/internal/telephony/dataconnection/DataConnection;->mRetryManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v14}, Lcom/android/internal/telephony/RetryManager;->getRetryTimer()I

    move-result v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2271
    sget-object v12, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_RIL_RESTART_ON_RILERROR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v12}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v12

    if-eqz v12, :cond_3

    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    iget-object v12, v12, Lcom/android/internal/telephony/dataconnection/DataConnection;->mRetryManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v12}, Lcom/android/internal/telephony/RetryManager;->getRetryCount()I

    move-result v12

    const/4 v13, 0x4

    if-lt v12, v13, :cond_3

    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mPhone:Lcom/android/internal/telephony/PhoneBase;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$100(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/PhoneBase;

    move-result-object v12

    invoke-virtual {v12}, Lcom/android/internal/telephony/PhoneBase;->getServiceState()Landroid/telephony/ServiceState;

    move-result-object v12

    invoke-virtual {v12}, Landroid/telephony/ServiceState;->getRilDataRadioTechnology()I

    move-result v12

    const/16 v13, 0xd

    if-eq v12, v13, :cond_3

    .line 2273
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mPhone:Lcom/android/internal/telephony/PhoneBase;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$100(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/PhoneBase;

    move-result-object v12

    invoke-virtual {v12}, Lcom/android/internal/telephony/PhoneBase;->getForegroundCall()Lcom/android/internal/telephony/Call;

    move-result-object v12

    invoke-virtual {v12}, Lcom/android/internal/telephony/Call;->getState()Lcom/android/internal/telephony/Call$State;

    move-result-object v12

    invoke-virtual {v12}, Lcom/android/internal/telephony/Call$State;->isAlive()Z

    move-result v12

    if-nez v12, :cond_3

    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mPhone:Lcom/android/internal/telephony/PhoneBase;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$100(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/PhoneBase;

    move-result-object v12

    invoke-virtual {v12}, Lcom/android/internal/telephony/PhoneBase;->getBackgroundCall()Lcom/android/internal/telephony/Call;

    move-result-object v12

    invoke-virtual {v12}, Lcom/android/internal/telephony/Call;->getState()Lcom/android/internal/telephony/Call$State;

    move-result-object v12

    invoke-virtual {v12}, Lcom/android/internal/telephony/Call$State;->isAlive()Z

    move-result v12

    if-nez v12, :cond_3

    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mPhone:Lcom/android/internal/telephony/PhoneBase;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$100(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/PhoneBase;

    move-result-object v12

    invoke-virtual {v12}, Lcom/android/internal/telephony/PhoneBase;->getRingingCall()Lcom/android/internal/telephony/Call;

    move-result-object v12

    invoke-virtual {v12}, Lcom/android/internal/telephony/Call;->getState()Lcom/android/internal/telephony/Call$State;

    move-result-object v12

    invoke-virtual {v12}, Lcom/android/internal/telephony/Call$State;->isAlive()Z

    move-result v12

    if-eqz v12, :cond_4

    .line 2286
    :cond_3
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mPhone:Lcom/android/internal/telephony/PhoneBase;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$100(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/PhoneBase;

    move-result-object v12

    iget-object v12, v12, Lcom/android/internal/telephony/PhoneBase;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    const v14, 0x40002

    invoke-virtual {v13, v14, v4}, Lcom/android/internal/telephony/dataconnection/DataConnection;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v13

    invoke-interface {v12, v13}, Lcom/android/internal/telephony/CommandsInterface;->getLastDataCallFailCause(Landroid/os/Message;)V

    goto/16 :goto_1

    .line 2278
    :cond_4
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    const-string v13, "[LGE_DATA]reset radio!!"

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2279
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # invokes: Lcom/android/internal/telephony/dataconnection/DataConnection;->restartRild()V
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$1400(Lcom/android/internal/telephony/dataconnection/DataConnection;)V

    goto/16 :goto_1

    .line 2291
    :pswitch_4
    iget-object v7, v4, Lcom/android/internal/telephony/dataconnection/DataConnection$ConnectionParams;->mOnCompletedMsg:Landroid/os/Message;

    .line 2292
    .local v7, "msgInfo":Landroid/os/Message;
    iget-object v12, v7, Landroid/os/Message;->obj:Ljava/lang/Object;

    instance-of v12, v12, Lcom/android/internal/telephony/dataconnection/ApnContext;

    if-eqz v12, :cond_6

    .line 2293
    iget-object v1, v7, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v1, Lcom/android/internal/telephony/dataconnection/ApnContext;

    .line 2294
    .local v1, "apnContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    sget-object v12, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_RIL_RESTART_ON_RILERROR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v12}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v12

    if-eqz v12, :cond_6

    invoke-virtual {v1}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getApnType()Ljava/lang/String;

    move-result-object v12

    const-string v13, "default"

    invoke-virtual {v12, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v12

    if-eqz v12, :cond_6

    iget-object v12, v8, Lcom/android/internal/telephony/dataconnection/DataCallResponse$SetupResult;->mFailCause:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    sget-object v13, Lcom/android/internal/telephony/dataconnection/DcFailCause;->INTERNAL_REASON:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    if-eq v12, v13, :cond_5

    iget-object v12, v8, Lcom/android/internal/telephony/dataconnection/DataCallResponse$SetupResult;->mFailCause:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    sget-object v13, Lcom/android/internal/telephony/dataconnection/DcFailCause;->PS_NET_DOWN_REASON_CLOSE_IN_PROGRESS:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    if-ne v12, v13, :cond_6

    :cond_5
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mPhone:Lcom/android/internal/telephony/PhoneBase;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$100(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/PhoneBase;

    move-result-object v12

    invoke-virtual {v12}, Lcom/android/internal/telephony/PhoneBase;->getServiceState()Landroid/telephony/ServiceState;

    move-result-object v12

    invoke-virtual {v12}, Landroid/telephony/ServiceState;->getRilDataRadioTechnology()I

    move-result v12

    const/16 v13, 0xd

    if-eq v12, v13, :cond_6

    .line 2299
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "ERR_RilError apn="

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v1}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getApnType()Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2300
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "[RIL_RESET]getRetryCount     : "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    iget-object v14, v14, Lcom/android/internal/telephony/dataconnection/DataConnection;->mRetryManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v14}, Lcom/android/internal/telephony/RetryManager;->getRetryCount()I

    move-result v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2301
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "[RIL_RESET]getRetryTimer     : "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    iget-object v14, v14, Lcom/android/internal/telephony/dataconnection/DataConnection;->mRetryManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v14}, Lcom/android/internal/telephony/RetryManager;->getRetryTimer()I

    move-result v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2303
    sget v12, Lcom/android/internal/telephony/dataconnection/DataConnection;->rilFailCount:I

    add-int/lit8 v12, v12, 0x1

    sput v12, Lcom/android/internal/telephony/dataconnection/DataConnection;->rilFailCount:I

    .line 2304
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "[LGE_DATA]reset count = "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    sget v14, Lcom/android/internal/telephony/dataconnection/DataConnection;->rilFailCount:I

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2305
    sget v12, Lcom/android/internal/telephony/dataconnection/DataConnection;->rilFailCount:I

    const/4 v13, 0x6

    if-lt v12, v13, :cond_6

    .line 2306
    const/4 v12, 0x0

    sput v12, Lcom/android/internal/telephony/dataconnection/DataConnection;->rilFailCount:I

    .line 2308
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mPhone:Lcom/android/internal/telephony/PhoneBase;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$100(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/PhoneBase;

    move-result-object v12

    invoke-virtual {v12}, Lcom/android/internal/telephony/PhoneBase;->getForegroundCall()Lcom/android/internal/telephony/Call;

    move-result-object v12

    invoke-virtual {v12}, Lcom/android/internal/telephony/Call;->getState()Lcom/android/internal/telephony/Call$State;

    move-result-object v12

    invoke-virtual {v12}, Lcom/android/internal/telephony/Call$State;->isAlive()Z

    move-result v12

    if-nez v12, :cond_6

    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mPhone:Lcom/android/internal/telephony/PhoneBase;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$100(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/PhoneBase;

    move-result-object v12

    invoke-virtual {v12}, Lcom/android/internal/telephony/PhoneBase;->getBackgroundCall()Lcom/android/internal/telephony/Call;

    move-result-object v12

    invoke-virtual {v12}, Lcom/android/internal/telephony/Call;->getState()Lcom/android/internal/telephony/Call$State;

    move-result-object v12

    invoke-virtual {v12}, Lcom/android/internal/telephony/Call$State;->isAlive()Z

    move-result v12

    if-nez v12, :cond_6

    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mPhone:Lcom/android/internal/telephony/PhoneBase;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$100(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/PhoneBase;

    move-result-object v12

    invoke-virtual {v12}, Lcom/android/internal/telephony/PhoneBase;->getRingingCall()Lcom/android/internal/telephony/Call;

    move-result-object v12

    invoke-virtual {v12}, Lcom/android/internal/telephony/Call;->getState()Lcom/android/internal/telephony/Call$State;

    move-result-object v12

    invoke-virtual {v12}, Lcom/android/internal/telephony/Call$State;->isAlive()Z

    move-result v12

    if-eqz v12, :cond_a

    .line 2320
    .end local v1    # "apnContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    :cond_6
    sget-object v12, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_RIL_RESTART_ON_RILERROR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v12}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v12

    if-nez v12, :cond_7

    iget-object v12, v8, Lcom/android/internal/telephony/dataconnection/DataCallResponse$SetupResult;->mFailCause:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    sget-object v13, Lcom/android/internal/telephony/dataconnection/DcFailCause;->INTERNAL_REASON:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    if-ne v12, v13, :cond_7

    .line 2321
    sget-object v12, Lcom/android/internal/telephony/dataconnection/DcFailCause;->ERROR_UNSPECIFIED:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    iput-object v12, v8, Lcom/android/internal/telephony/dataconnection/DataCallResponse$SetupResult;->mFailCause:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    .line 2325
    :cond_7
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mDcRetryAlarmController:Lcom/android/internal/telephony/dataconnection/DcRetryAlarmController;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$400(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DcRetryAlarmController;

    move-result-object v12

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    invoke-virtual {v12, v13, v2}, Lcom/android/internal/telephony/dataconnection/DcRetryAlarmController;->getSuggestedRetryTime(Lcom/android/internal/telephony/dataconnection/DataConnection;Landroid/os/AsyncResult;)I

    move-result v5

    .line 2328
    .local v5, "delay":I
    const/4 v6, 0x0

    .line 2329
    .local v6, "isIMS":Z
    iget-object v12, v7, Landroid/os/Message;->obj:Ljava/lang/Object;

    instance-of v12, v12, Lcom/android/internal/telephony/dataconnection/ApnContext;

    if-eqz v12, :cond_8

    .line 2330
    iget-object v1, v7, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v1, Lcom/android/internal/telephony/dataconnection/ApnContext;

    .line 2331
    .restart local v1    # "apnContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    invoke-virtual {v1}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getApnType()Ljava/lang/String;

    move-result-object v12

    if-eqz v12, :cond_8

    .line 2332
    invoke-virtual {v1}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getApnType()Ljava/lang/String;

    move-result-object v12

    const-string v13, "ims"

    invoke-virtual {v12, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v12

    if-eqz v12, :cond_8

    .line 2333
    const/4 v6, 0x1

    .line 2334
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    const-string v13, "ATT IMSDAM this DC is IMS"

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2341
    .end local v1    # "apnContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    :cond_8
    sget-object v12, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DEBUG_ENABLE_PRIVACY_LOG:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v12}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v12

    if-eqz v12, :cond_9

    .line 2342
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "DcActivatingState: ERR_RilError  delay="

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, " isRetryNeeded="

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    iget-object v14, v14, Lcom/android/internal/telephony/dataconnection/DataConnection;->mRetryManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v14}, Lcom/android/internal/telephony/RetryManager;->isRetryNeeded()Z

    move-result v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, " result="

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, " result.isRestartRadioFail="

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    iget-object v14, v8, Lcom/android/internal/telephony/dataconnection/DataCallResponse$SetupResult;->mFailCause:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    invoke-virtual {v14}, Lcom/android/internal/telephony/dataconnection/DcFailCause;->isRestartRadioFail()Z

    move-result v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, " result.isPermanentFail="

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-static {v14}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$500(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-result-object v14

    iget-object v15, v8, Lcom/android/internal/telephony/dataconnection/DataCallResponse$SetupResult;->mFailCause:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    invoke-virtual {v14, v15}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->isPermanentFail(Lcom/android/internal/telephony/dataconnection/DcFailCause;)Z

    move-result v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2353
    :cond_9
    iget-object v12, v8, Lcom/android/internal/telephony/dataconnection/DataCallResponse$SetupResult;->mFailCause:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    invoke-virtual {v12}, Lcom/android/internal/telephony/dataconnection/DcFailCause;->isRestartRadioFail()Z

    move-result v12

    if-eqz v12, :cond_b

    .line 2354
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    const-string v13, "DcActivatingState: ERR_RilError restart radio"

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2355
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$500(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-result-object v12

    invoke-virtual {v12}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->sendRestartRadio()V

    .line 2356
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mInactiveState:Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$1200(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;

    move-result-object v12

    iget-object v13, v8, Lcom/android/internal/telephony/dataconnection/DataCallResponse$SetupResult;->mFailCause:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    invoke-virtual {v12, v4, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;->setEnterNotificationParams(Lcom/android/internal/telephony/dataconnection/DataConnection$ConnectionParams;Lcom/android/internal/telephony/dataconnection/DcFailCause;)V

    .line 2357
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mInactiveState:Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;
    invoke-static {v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$1200(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;

    move-result-object v13

    # invokes: Lcom/android/internal/telephony/dataconnection/DataConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$6000(Lcom/android/internal/telephony/dataconnection/DataConnection;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    .line 2313
    .end local v5    # "delay":I
    .end local v6    # "isIMS":Z
    .restart local v1    # "apnContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    :cond_a
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    const-string v13, "[LGE_DATA]reset radio!!"

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2314
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # invokes: Lcom/android/internal/telephony/dataconnection/DataConnection;->restartRild()V
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$1400(Lcom/android/internal/telephony/dataconnection/DataConnection;)V

    goto/16 :goto_1

    .line 2359
    .end local v1    # "apnContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    .restart local v5    # "delay":I
    .restart local v6    # "isIMS":Z
    :cond_b
    sget-object v12, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_ATT_IMS_DAM:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v12}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v12

    if-eqz v12, :cond_c

    if-eqz v6, :cond_c

    iget-object v12, v8, Lcom/android/internal/telephony/dataconnection/DataCallResponse$SetupResult;->mFailCause:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    invoke-virtual {v12}, Lcom/android/internal/telephony/dataconnection/DcFailCause;->isFailT3402Needed()Z

    move-result v12

    if-eqz v12, :cond_c

    .line 2360
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    const-string v13, "DcActivatingState: ERR_RilError no retry"

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2361
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mInactiveState:Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$1200(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;

    move-result-object v12

    iget-object v13, v8, Lcom/android/internal/telephony/dataconnection/DataCallResponse$SetupResult;->mFailCause:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    invoke-virtual {v12, v4, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;->setEnterNotificationParams(Lcom/android/internal/telephony/dataconnection/DataConnection$ConnectionParams;Lcom/android/internal/telephony/dataconnection/DcFailCause;)V

    .line 2362
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mInactiveState:Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;
    invoke-static {v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$1200(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;

    move-result-object v13

    # invokes: Lcom/android/internal/telephony/dataconnection/DataConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$6100(Lcom/android/internal/telephony/dataconnection/DataConnection;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    .line 2364
    :cond_c
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$500(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-result-object v12

    iget-object v13, v8, Lcom/android/internal/telephony/dataconnection/DataCallResponse$SetupResult;->mFailCause:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->isPermanentFail(Lcom/android/internal/telephony/dataconnection/DcFailCause;)Z

    move-result v12

    if-eqz v12, :cond_d

    .line 2365
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    const-string v13, "DcActivatingState: ERR_RilError perm error"

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2366
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mInactiveState:Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$1200(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;

    move-result-object v12

    iget-object v13, v8, Lcom/android/internal/telephony/dataconnection/DataCallResponse$SetupResult;->mFailCause:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    invoke-virtual {v12, v4, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;->setEnterNotificationParams(Lcom/android/internal/telephony/dataconnection/DataConnection$ConnectionParams;Lcom/android/internal/telephony/dataconnection/DcFailCause;)V

    .line 2367
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mInactiveState:Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;
    invoke-static {v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$1200(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;

    move-result-object v13

    # invokes: Lcom/android/internal/telephony/dataconnection/DataConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$6200(Lcom/android/internal/telephony/dataconnection/DataConnection;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    .line 2368
    :cond_d
    if-ltz v5, :cond_e

    .line 2369
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    const-string v13, "DcActivatingState: ERR_RilError retry"

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2370
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mDcRetryAlarmController:Lcom/android/internal/telephony/dataconnection/DcRetryAlarmController;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$400(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DcRetryAlarmController;

    move-result-object v12

    const v13, 0x4000a

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    iget v14, v14, Lcom/android/internal/telephony/dataconnection/DataConnection;->mTag:I

    invoke-virtual {v12, v13, v14, v5}, Lcom/android/internal/telephony/dataconnection/DcRetryAlarmController;->startRetryAlarm(III)V

    .line 2372
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mRetryingState:Lcom/android/internal/telephony/dataconnection/DataConnection$DcRetryingState;
    invoke-static {v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$6300(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DataConnection$DcRetryingState;

    move-result-object v13

    # invokes: Lcom/android/internal/telephony/dataconnection/DataConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$6400(Lcom/android/internal/telephony/dataconnection/DataConnection;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    .line 2374
    :cond_e
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    const-string v13, "DcActivatingState: ERR_RilError no retry"

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2375
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mInactiveState:Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$1200(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;

    move-result-object v12

    iget-object v13, v8, Lcom/android/internal/telephony/dataconnection/DataCallResponse$SetupResult;->mFailCause:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    invoke-virtual {v12, v4, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;->setEnterNotificationParams(Lcom/android/internal/telephony/dataconnection/DataConnection$ConnectionParams;Lcom/android/internal/telephony/dataconnection/DcFailCause;)V

    .line 2376
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mInactiveState:Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;
    invoke-static {v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$1200(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;

    move-result-object v13

    # invokes: Lcom/android/internal/telephony/dataconnection/DataConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$6500(Lcom/android/internal/telephony/dataconnection/DataConnection;Lcom/android/internal/util/IState;)V

    goto/16 :goto_1

    .line 2380
    .end local v5    # "delay":I
    .end local v6    # "isIMS":Z
    .end local v7    # "msgInfo":Landroid/os/Message;
    :pswitch_5
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "DcActivatingState: stale EVENT_SETUP_DATA_CONNECTION_DONE tag:"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    iget v14, v4, Lcom/android/internal/telephony/dataconnection/DataConnection$ConnectionParams;->mTag:I

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, " != mTag:"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    iget v14, v14, Lcom/android/internal/telephony/dataconnection/DataConnection;->mTag:I

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->loge(Ljava/lang/String;)V

    goto/16 :goto_1

    .line 2390
    .end local v2    # "ar":Landroid/os/AsyncResult;
    .end local v4    # "cp":Lcom/android/internal/telephony/dataconnection/DataConnection$ConnectionParams;
    .end local v8    # "result":Lcom/android/internal/telephony/dataconnection/DataCallResponse$SetupResult;
    :sswitch_3
    move-object/from16 v0, p1

    iget-object v2, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v2, Landroid/os/AsyncResult;

    .line 2391
    .restart local v2    # "ar":Landroid/os/AsyncResult;
    iget-object v4, v2, Landroid/os/AsyncResult;->userObj:Ljava/lang/Object;

    check-cast v4, Lcom/android/internal/telephony/dataconnection/DataConnection$ConnectionParams;

    .line 2392
    .restart local v4    # "cp":Lcom/android/internal/telephony/dataconnection/DataConnection$ConnectionParams;
    iget v12, v4, Lcom/android/internal/telephony/dataconnection/DataConnection$ConnectionParams;->mTag:I

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    iget v13, v13, Lcom/android/internal/telephony/dataconnection/DataConnection;->mTag:I

    if-ne v12, v13, :cond_16

    .line 2393
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mConnectionParams:Lcom/android/internal/telephony/dataconnection/DataConnection$ConnectionParams;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$2700(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DataConnection$ConnectionParams;

    move-result-object v12

    if-eq v12, v4, :cond_f

    .line 2394
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "DcActivatingState: WEIRD mConnectionsParams:"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mConnectionParams:Lcom/android/internal/telephony/dataconnection/DataConnection$ConnectionParams;
    invoke-static {v14}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$2700(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DataConnection$ConnectionParams;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, " != cp:"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->loge(Ljava/lang/String;)V

    .line 2398
    :cond_f
    sget-object v3, Lcom/android/internal/telephony/dataconnection/DcFailCause;->UNKNOWN:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    .line 2400
    .local v3, "cause":Lcom/android/internal/telephony/dataconnection/DcFailCause;
    sget-object v12, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TOOL_MLT_DEBUG_INFO:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v12}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v12

    const/4 v13, 0x1

    if-ne v12, v13, :cond_10

    .line 2401
    const/4 v12, 0x0

    invoke-virtual {v3, v12}, Lcom/android/internal/telephony/dataconnection/DcFailCause;->setRilErrorCode(I)I

    .line 2405
    :cond_10
    iget-object v12, v2, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v12, :cond_12

    .line 2406
    iget-object v12, v2, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v12, [I

    check-cast v12, [I

    const/4 v13, 0x0

    aget v11, v12, v13

    .line 2407
    .local v11, "rilFailCause":I
    invoke-static {v11}, Lcom/android/internal/telephony/dataconnection/DcFailCause;->fromInt(I)Lcom/android/internal/telephony/dataconnection/DcFailCause;

    move-result-object v3

    .line 2408
    sget-object v12, Lcom/android/internal/telephony/dataconnection/DcFailCause;->NONE:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    if-ne v3, v12, :cond_11

    .line 2410
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    const-string v13, "DcActivatingState msg.what=EVENT_GET_LAST_FAIL_DONE BAD: error was NONE, change to UNKNOWN"

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2413
    sget-object v3, Lcom/android/internal/telephony/dataconnection/DcFailCause;->UNKNOWN:Lcom/android/internal/telephony/dataconnection/DcFailCause;

    .line 2416
    :cond_11
    sget-object v12, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TOOL_MLT_DEBUG_INFO:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v12}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v12

    const/4 v13, 0x1

    if-ne v12, v13, :cond_12

    .line 2417
    invoke-virtual {v3, v11}, Lcom/android/internal/telephony/dataconnection/DcFailCause;->setRilErrorCode(I)I

    .line 2421
    .end local v11    # "rilFailCause":I
    :cond_12
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # setter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mDcFailCause:Lcom/android/internal/telephony/dataconnection/DcFailCause;
    invoke-static {v12, v3}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$2902(Lcom/android/internal/telephony/dataconnection/DataConnection;Lcom/android/internal/telephony/dataconnection/DcFailCause;)Lcom/android/internal/telephony/dataconnection/DcFailCause;

    .line 2423
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    iget-object v12, v12, Lcom/android/internal/telephony/dataconnection/DataConnection;->mRetryManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v12}, Lcom/android/internal/telephony/RetryManager;->getRetryTimer()I

    move-result v10

    .line 2425
    .local v10, "retryDelay":I
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "DcActivatingState msg.what=EVENT_GET_LAST_FAIL_DONE cause="

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, " retryDelay="

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, " isRetryNeeded="

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    iget-object v14, v14, Lcom/android/internal/telephony/dataconnection/DataConnection;->mRetryManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v14}, Lcom/android/internal/telephony/RetryManager;->isRetryNeeded()Z

    move-result v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, " dc="

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2431
    invoke-virtual {v3}, Lcom/android/internal/telephony/dataconnection/DcFailCause;->isRestartRadioFail()Z

    move-result v12

    if-eqz v12, :cond_13

    .line 2433
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    const-string v13, "DcActivatingState: EVENT_GET_LAST_FAIL_DONE restart radio"

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2436
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$500(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-result-object v12

    invoke-virtual {v12}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->sendRestartRadio()V

    .line 2437
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mInactiveState:Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$1200(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;

    move-result-object v12

    invoke-virtual {v12, v4, v3}, Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;->setEnterNotificationParams(Lcom/android/internal/telephony/dataconnection/DataConnection$ConnectionParams;Lcom/android/internal/telephony/dataconnection/DcFailCause;)V

    .line 2438
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mInactiveState:Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;
    invoke-static {v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$1200(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;

    move-result-object v13

    # invokes: Lcom/android/internal/telephony/dataconnection/DataConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$6600(Lcom/android/internal/telephony/dataconnection/DataConnection;Lcom/android/internal/util/IState;)V

    .line 2458
    .end local v3    # "cause":Lcom/android/internal/telephony/dataconnection/DcFailCause;
    .end local v10    # "retryDelay":I
    :goto_2
    const/4 v9, 0x1

    .line 2459
    .restart local v9    # "retVal":Z
    goto/16 :goto_0

    .line 2439
    .end local v9    # "retVal":Z
    .restart local v3    # "cause":Lcom/android/internal/telephony/dataconnection/DcFailCause;
    .restart local v10    # "retryDelay":I
    :cond_13
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$500(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-result-object v12

    invoke-virtual {v12, v3}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->isPermanentFail(Lcom/android/internal/telephony/dataconnection/DcFailCause;)Z

    move-result v12

    if-eqz v12, :cond_14

    .line 2440
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    const-string v13, "DcActivatingState: EVENT_GET_LAST_FAIL_DONE perm er"

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2441
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mInactiveState:Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$1200(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;

    move-result-object v12

    invoke-virtual {v12, v4, v3}, Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;->setEnterNotificationParams(Lcom/android/internal/telephony/dataconnection/DataConnection$ConnectionParams;Lcom/android/internal/telephony/dataconnection/DcFailCause;)V

    .line 2442
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mInactiveState:Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;
    invoke-static {v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$1200(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;

    move-result-object v13

    # invokes: Lcom/android/internal/telephony/dataconnection/DataConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$6700(Lcom/android/internal/telephony/dataconnection/DataConnection;Lcom/android/internal/util/IState;)V

    goto :goto_2

    .line 2443
    :cond_14
    if-ltz v10, :cond_15

    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    iget-object v12, v12, Lcom/android/internal/telephony/dataconnection/DataConnection;->mRetryManager:Lcom/android/internal/telephony/RetryManager;

    invoke-virtual {v12}, Lcom/android/internal/telephony/RetryManager;->isRetryNeeded()Z

    move-result v12

    if-eqz v12, :cond_15

    .line 2444
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    const-string v13, "DcActivatingState: EVENT_GET_LAST_FAIL_DONE retry"

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2445
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mDcRetryAlarmController:Lcom/android/internal/telephony/dataconnection/DcRetryAlarmController;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$400(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DcRetryAlarmController;

    move-result-object v12

    const v13, 0x4000a

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    iget v14, v14, Lcom/android/internal/telephony/dataconnection/DataConnection;->mTag:I

    invoke-virtual {v12, v13, v14, v10}, Lcom/android/internal/telephony/dataconnection/DcRetryAlarmController;->startRetryAlarm(III)V

    .line 2447
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mRetryingState:Lcom/android/internal/telephony/dataconnection/DataConnection$DcRetryingState;
    invoke-static {v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$6300(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DataConnection$DcRetryingState;

    move-result-object v13

    # invokes: Lcom/android/internal/telephony/dataconnection/DataConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$6800(Lcom/android/internal/telephony/dataconnection/DataConnection;Lcom/android/internal/util/IState;)V

    goto :goto_2

    .line 2449
    :cond_15
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    const-string v13, "DcActivatingState: EVENT_GET_LAST_FAIL_DONE no retry"

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->log(Ljava/lang/String;)V

    .line 2450
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mInactiveState:Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;
    invoke-static {v12}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$1200(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;

    move-result-object v12

    invoke-virtual {v12, v4, v3}, Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;->setEnterNotificationParams(Lcom/android/internal/telephony/dataconnection/DataConnection$ConnectionParams;Lcom/android/internal/telephony/dataconnection/DcFailCause;)V

    .line 2451
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    # getter for: Lcom/android/internal/telephony/dataconnection/DataConnection;->mInactiveState:Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;
    invoke-static {v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$1200(Lcom/android/internal/telephony/dataconnection/DataConnection;)Lcom/android/internal/telephony/dataconnection/DataConnection$DcInactiveState;

    move-result-object v13

    # invokes: Lcom/android/internal/telephony/dataconnection/DataConnection;->transitionTo(Lcom/android/internal/util/IState;)V
    invoke-static {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->access$6900(Lcom/android/internal/telephony/dataconnection/DataConnection;Lcom/android/internal/util/IState;)V

    goto/16 :goto_2

    .line 2454
    .end local v3    # "cause":Lcom/android/internal/telephony/dataconnection/DcFailCause;
    .end local v10    # "retryDelay":I
    :cond_16
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "DcActivatingState: stale EVENT_GET_LAST_FAIL_DONE tag:"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    iget v14, v4, Lcom/android/internal/telephony/dataconnection/DataConnection$ConnectionParams;->mTag:I

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v13

    const-string v14, " != mTag:"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/internal/telephony/dataconnection/DataConnection$DcActivatingState;->this$0:Lcom/android/internal/telephony/dataconnection/DataConnection;

    iget v14, v14, Lcom/android/internal/telephony/dataconnection/DataConnection;->mTag:I

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Lcom/android/internal/telephony/dataconnection/DataConnection;->loge(Ljava/lang/String;)V

    goto/16 :goto_2

    .line 2207
    nop

    :sswitch_data_0
    .sparse-switch
        0x40000 -> :sswitch_0
        0x40001 -> :sswitch_2
        0x40002 -> :sswitch_3
        0x4000b -> :sswitch_0
        0x4000f -> :sswitch_1
    .end sparse-switch

    .line 2248
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
    .end packed-switch
.end method
