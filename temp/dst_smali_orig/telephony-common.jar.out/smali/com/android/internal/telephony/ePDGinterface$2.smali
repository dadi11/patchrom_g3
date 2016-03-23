.class Lcom/android/internal/telephony/ePDGinterface$2;
.super Landroid/os/Handler;
.source "ePDGinterface.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/ePDGinterface;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/internal/telephony/ePDGinterface;


# direct methods
.method constructor <init>(Lcom/android/internal/telephony/ePDGinterface;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/ePDGinterface$2;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 21
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    move-object/from16 v0, p1

    iget v1, v0, Landroid/os/Message;->what:I

    packed-switch v1, :pswitch_data_0

    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/android/internal/telephony/ePDGinterface$2;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[ePDG] UNKNOWN MSG : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move-object/from16 v0, p1

    iget v3, v0, Landroid/os/Message;->what:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    :cond_0
    :goto_0
    return-void

    :pswitch_0
    move-object/from16 v0, p1

    iget-object v0, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    move-object/from16 v19, v0

    check-cast v19, Landroid/os/AsyncResult;

    .local v19, "mAr":Landroid/os/AsyncResult;
    move-object/from16 v0, v19

    iget-object v0, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    move-object/from16 v20, v0

    check-cast v20, Lcom/android/internal/telephony/dataconnection/DataCallResponse;

    .local v20, "mDcr":Lcom/android/internal/telephony/dataconnection/DataCallResponse;
    move-object/from16 v0, v19

    iget-object v12, v0, Landroid/os/AsyncResult;->userObj:Ljava/lang/Object;

    check-cast v12, Ljava/lang/String;

    .local v12, "apntype":Ljava/lang/String;
    if-nez v20, :cond_1

    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/android/internal/telephony/ePDGinterface$2;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[ePDG] ConvertResp DataCallResponse  RIL ERROR !!! : apntype"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/android/internal/telephony/ePDGinterface$2;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    const/4 v2, 0x0

    const/16 v3, 0x64

    const/4 v4, -0x1

    const/4 v5, 0x0

    const-string v6, "none"

    const-string v7, "none"

    const-string v8, "none"

    const-string v9, "none"

    const-string v10, "none"

    const/4 v11, 0x0

    invoke-virtual/range {v1 .. v12}, Lcom/android/internal/telephony/ePDGinterface;->notifyEPDGCallResult(IIIILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)V

    goto :goto_0

    :cond_1
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/android/internal/telephony/ePDGinterface$2;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[ePDG] ConvertResp DataCallResponse in handler : apntype"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/android/internal/telephony/ePDGinterface$2;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    move-object/from16 v0, v20

    invoke-virtual {v1, v0, v12}, Lcom/android/internal/telephony/ePDGinterface;->ConvtRespEPDGSetupDataCall(Lcom/android/internal/telephony/dataconnection/DataCallResponse;Ljava/lang/String;)V

    goto :goto_0

    .end local v12    # "apntype":Ljava/lang/String;
    .end local v19    # "mAr":Landroid/os/AsyncResult;
    .end local v20    # "mDcr":Lcom/android/internal/telephony/dataconnection/DataCallResponse;
    :pswitch_1
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/android/internal/telephony/ePDGinterface$2;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    const-string v2, "[ePDG] RIL_REQUEST_ePDG_DEACTIVATE_DATA_CALL msg in handler response success"

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/android/internal/telephony/ePDGinterface$2;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    iget v1, v1, Lcom/android/internal/telephony/ePDGinterface;->myfeature:I

    const/16 v2, 0xb

    if-ne v1, v2, :cond_0

    move-object/from16 v0, p1

    iget-object v0, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    move-object/from16 v19, v0

    check-cast v19, Landroid/os/AsyncResult;

    .restart local v19    # "mAr":Landroid/os/AsyncResult;
    move-object/from16 v0, v19

    iget-object v12, v0, Landroid/os/AsyncResult;->userObj:Ljava/lang/Object;

    check-cast v12, Ljava/lang/String;

    .restart local v12    # "apntype":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/android/internal/telephony/ePDGinterface$2;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    const/16 v8, 0x3e4

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    const/4 v13, 0x0

    const/4 v14, 0x0

    const/4 v15, 0x0

    const/16 v16, 0x0

    const/16 v17, 0x0

    const/16 v18, 0x0

    invoke-virtual/range {v7 .. v18}, Lcom/android/internal/telephony/ePDGinterface;->notifyEPDGCallResult(IIIILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)V

    goto/16 :goto_0

    .end local v12    # "apntype":Ljava/lang/String;
    .end local v19    # "mAr":Landroid/os/AsyncResult;
    :pswitch_2
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/android/internal/telephony/ePDGinterface$2;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    const-string v2, "[ePDG] EVENT_EPDG_WIFI get rsp from qcril"

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    :pswitch_3
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/android/internal/telephony/ePDGinterface$2;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    const-string v2, "[ePDG] EVENT_QOS_CHANGED"

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_QOS_NOTIFY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v1

    if-eqz v1, :cond_0

    move-object/from16 v0, p1

    iget-object v0, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    move-object/from16 v19, v0

    check-cast v19, Landroid/os/AsyncResult;

    .restart local v19    # "mAr":Landroid/os/AsyncResult;
    if-eqz v19, :cond_0

    move-object/from16 v0, v19

    iget-object v1, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    if-eqz v1, :cond_0

    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/android/internal/telephony/ePDGinterface$2;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    move-object/from16 v0, v19

    # invokes: Lcom/android/internal/telephony/ePDGinterface;->onQoSChanged(Landroid/os/AsyncResult;)V
    invoke-static {v1, v0}, Lcom/android/internal/telephony/ePDGinterface;->access$200(Lcom/android/internal/telephony/ePDGinterface;Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    .end local v19    # "mAr":Landroid/os/AsyncResult;
    :pswitch_4
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/android/internal/telephony/ePDGinterface$2;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    const-string v2, "[ePDG] EVENT_PCSCF_DONE"

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    move-object/from16 v0, p1

    iget-object v0, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    move-object/from16 v19, v0

    check-cast v19, Landroid/os/AsyncResult;

    .restart local v19    # "mAr":Landroid/os/AsyncResult;
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/android/internal/telephony/ePDGinterface$2;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    move-object/from16 v0, v19

    # invokes: Lcom/android/internal/telephony/ePDGinterface;->onGetPcscfAddressCompleted(Landroid/os/AsyncResult;)V
    invoke-static {v1, v0}, Lcom/android/internal/telephony/ePDGinterface;->access$300(Lcom/android/internal/telephony/ePDGinterface;Landroid/os/AsyncResult;)V

    goto/16 :goto_0

    .end local v19    # "mAr":Landroid/os/AsyncResult;
    :pswitch_5
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/android/internal/telephony/ePDGinterface$2;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    const-string v2, "[ePDG] EVENT_PCSCF_CHANGE"

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/ePDGinterface;->log(Ljava/lang/String;)V

    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/android/internal/telephony/ePDGinterface$2;->this$0:Lcom/android/internal/telephony/ePDGinterface;

    # invokes: Lcom/android/internal/telephony/ePDGinterface;->onNotifyPCS()V
    invoke-static {v1}, Lcom/android/internal/telephony/ePDGinterface;->access$400(Lcom/android/internal/telephony/ePDGinterface;)V

    goto/16 :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x1f5
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
    .end packed-switch
.end method
