.class Lcom/android/internal/telephony/lgdata/LgDcTracker$1;
.super Landroid/content/BroadcastReceiver;
.source "LgDcTracker.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/lgdata/LgDcTracker;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;


# direct methods
.method constructor <init>(Lcom/android/internal/telephony/lgdata/LgDcTracker;)V
    .locals 0

    .prologue
    .line 144
    iput-object p1, p0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 25
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    .line 148
    invoke-virtual/range {p2 .. p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v3

    .line 149
    .local v3, "action":Ljava/lang/String;
    const-string v21, "[LGE_DATA][LGDCT] "

    new-instance v22, Ljava/lang/StringBuilder;

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuilder;-><init>()V

    const-string v23, "onReceive: action="

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-static/range {v21 .. v22}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 150
    const-string v21, "android.intent.action.SCREEN_ON"

    move-object/from16 v0, v21

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_1

    .line 344
    :cond_0
    :goto_0
    :pswitch_0
    return-void

    .line 153
    :cond_1
    const-string v21, "lge.test.limit_data_usage"

    move-object/from16 v0, v21

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_3

    .line 154
    const-string v21, "[LGE_DATA][LGDCT] "

    const-string v22, "[LGE_DATA] lge.test.limit_data_usage"

    invoke-static/range {v21 .. v22}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 156
    const-string v21, "cause"

    move-object/from16 v0, p2

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getExtra(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v21

    const-string v22, "2"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_2

    .line 157
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v21, v0

    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-static/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$000(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-result-object v21

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->dataMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v21, v0

    sget-object v22, Lcom/android/internal/telephony/DataConnectionManager$FunctionName;->handleSKT_QA:Lcom/android/internal/telephony/DataConnectionManager$FunctionName;

    const-string v23, ""

    const/16 v24, 0x2

    invoke-virtual/range {v21 .. v24}, Lcom/android/internal/telephony/DataConnectionManager;->IntegrationAPI(Lcom/android/internal/telephony/DataConnectionManager$FunctionName;Ljava/lang/String;I)I

    goto :goto_0

    .line 159
    :cond_2
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v21, v0

    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-static/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$000(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-result-object v21

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->dataMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v21, v0

    sget-object v22, Lcom/android/internal/telephony/DataConnectionManager$FunctionName;->handleSKT_QA:Lcom/android/internal/telephony/DataConnectionManager$FunctionName;

    const-string v23, ""

    const/16 v24, 0x5

    invoke-virtual/range {v21 .. v24}, Lcom/android/internal/telephony/DataConnectionManager;->IntegrationAPI(Lcom/android/internal/telephony/DataConnectionManager$FunctionName;Ljava/lang/String;I)I

    goto :goto_0

    .line 164
    :cond_3
    const-string v21, "com.skt.CALL_PROTECTION_STATUS_CHANGED"

    move-object/from16 v0, v21

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_5

    .line 165
    sget-object v21, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_VOICE_PROTECTION_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v21

    const/16 v22, 0x1

    move/from16 v0, v21

    move/from16 v1, v22

    if-ne v0, v1, :cond_0

    .line 166
    const-string v21, "on_off"

    const/16 v22, 0x1

    move-object/from16 v0, p2

    move-object/from16 v1, v21

    move/from16 v2, v22

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v11

    .line 168
    .local v11, "enabled":Z
    const-string v21, "[LGE_DATA][LGDCT] "

    new-instance v22, Ljava/lang/StringBuilder;

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuilder;-><init>()V

    const-string v23, "[LGE_DATA] CALL_PROTECTION_STATUS_CHANGED ::"

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-static/range {v21 .. v22}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 170
    if-nez v11, :cond_4

    .line 171
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v21, v0

    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-static/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$000(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-result-object v21

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->dataMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v21, v0

    sget-object v22, Lcom/android/internal/telephony/DataConnectionManager$FunctionName;->setBlockPacketMenuProcess:Lcom/android/internal/telephony/DataConnectionManager$FunctionName;

    const-string v23, ""

    const/16 v24, 0x0

    invoke-virtual/range {v21 .. v24}, Lcom/android/internal/telephony/DataConnectionManager;->IntegrationAPI(Lcom/android/internal/telephony/DataConnectionManager$FunctionName;Ljava/lang/String;I)I

    .line 173
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v21, v0

    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-static/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$000(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-result-object v21

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->dataMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v21, v0

    const/16 v22, 0x0

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/DataConnectionManager;->functionForPacketDrop(Z)V

    goto/16 :goto_0

    .line 175
    :cond_4
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v21, v0

    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-static/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$000(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-result-object v21

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->dataMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v21, v0

    sget-object v22, Lcom/android/internal/telephony/DataConnectionManager$FunctionName;->setBlockPacketMenuProcess:Lcom/android/internal/telephony/DataConnectionManager$FunctionName;

    const-string v23, ""

    const/16 v24, 0x1

    invoke-virtual/range {v21 .. v24}, Lcom/android/internal/telephony/DataConnectionManager;->IntegrationAPI(Lcom/android/internal/telephony/DataConnectionManager$FunctionName;Ljava/lang/String;I)I

    goto/16 :goto_0

    .line 178
    .end local v11    # "enabled":Z
    :cond_5
    const-string v21, "com.skt.CALL_PROTECTION_MENU_OFF"

    move-object/from16 v0, v21

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_6

    .line 181
    const-string v21, "[LGE_DATA][LGDCT] "

    const-string v22, "[LGE_DATA] com.skt.CALL_PROTECTION_MENU_OFF"

    invoke-static/range {v21 .. v22}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 183
    sget-object v21, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_VOICE_PROTECTION_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v21

    const/16 v22, 0x1

    move/from16 v0, v21

    move/from16 v1, v22

    if-ne v0, v1, :cond_0

    .line 185
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v21, v0

    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-static/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$000(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-result-object v21

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->dataMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v21, v0

    sget-object v22, Lcom/android/internal/telephony/DataConnectionManager$FunctionName;->setAlreadyAppUsedPacket:Lcom/android/internal/telephony/DataConnectionManager$FunctionName;

    const-string v23, ""

    const/16 v24, 0x1

    invoke-virtual/range {v21 .. v24}, Lcom/android/internal/telephony/DataConnectionManager;->IntegrationAPI(Lcom/android/internal/telephony/DataConnectionManager$FunctionName;Ljava/lang/String;I)I

    .line 186
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v21, v0

    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-static/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$000(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-result-object v21

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->dataMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v21, v0

    const/16 v22, 0x0

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/DataConnectionManager;->functionForPacketDrop(Z)V

    goto/16 :goto_0

    .line 188
    :cond_6
    const-string v21, "com.skt.CALL_PROTECTION_MENU_ON"

    move-object/from16 v0, v21

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_7

    .line 191
    const-string v21, "[LGE_DATA][LGDCT] "

    const-string v22, "[LGE_DATA] com.skt.CALL_PROTECTION_MENU_ON"

    invoke-static/range {v21 .. v22}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 193
    sget-object v21, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_VOICE_PROTECTION_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v21

    const/16 v22, 0x1

    move/from16 v0, v21

    move/from16 v1, v22

    if-ne v0, v1, :cond_0

    .line 195
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v21, v0

    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-static/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$000(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-result-object v21

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->dataMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v21, v0

    sget-object v22, Lcom/android/internal/telephony/DataConnectionManager$FunctionName;->setAlreadyAppUsedPacket:Lcom/android/internal/telephony/DataConnectionManager$FunctionName;

    const-string v23, ""

    const/16 v24, 0x0

    invoke-virtual/range {v21 .. v24}, Lcom/android/internal/telephony/DataConnectionManager;->IntegrationAPI(Lcom/android/internal/telephony/DataConnectionManager$FunctionName;Ljava/lang/String;I)I

    goto/16 :goto_0

    .line 200
    :cond_7
    const-string v21, "com.skt.test_intent"

    move-object/from16 v0, v21

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_8

    .line 203
    const-string v21, "[LGE_DATA][LGDCT] "

    const-string v22, "[LGE_DATA] com.skt.test_intent"

    invoke-static/range {v21 .. v22}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 204
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v21, v0

    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-static/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$000(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-result-object v21

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->dataMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v21, v0

    sget-object v22, Lcom/android/internal/telephony/DataConnectionManager$FunctionName;->functionForPacketList:Lcom/android/internal/telephony/DataConnectionManager$FunctionName;

    const-string v23, ""

    const/16 v24, 0x0

    invoke-virtual/range {v21 .. v24}, Lcom/android/internal/telephony/DataConnectionManager;->IntegrationAPI(Lcom/android/internal/telephony/DataConnectionManager$FunctionName;Ljava/lang/String;I)I

    goto/16 :goto_0

    .line 208
    :cond_8
    const-string v21, "com.lge.GprsAttachedIsTrue"

    move-object/from16 v0, v21

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_a

    .line 209
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v21, v0

    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-static/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$000(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-result-object v21

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mApnContexts:Ljava/util/concurrent/ConcurrentHashMap;

    move-object/from16 v21, v0

    if-eqz v21, :cond_0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v21, v0

    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;
    invoke-static/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$100(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/PhoneBase;

    move-result-object v21

    if-eqz v21, :cond_0

    .line 211
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v21, v0

    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-static/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$000(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-result-object v21

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mApnContexts:Ljava/util/concurrent/ConcurrentHashMap;

    move-object/from16 v21, v0

    const-string v22, "default"

    invoke-virtual/range {v21 .. v22}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Lcom/android/internal/telephony/dataconnection/ApnContext;

    .line 213
    .local v9, "defaultContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    const/4 v12, -0x1

    .line 214
    .local v12, "gprsState":I
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v21, v0

    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;
    invoke-static/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$100(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/PhoneBase;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/PhoneBase;->getServiceStateTracker()Lcom/android/internal/telephony/ServiceStateTracker;

    move-result-object v21

    if-eqz v21, :cond_9

    .line 215
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v21, v0

    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;
    invoke-static/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$100(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/PhoneBase;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/PhoneBase;->getServiceStateTracker()Lcom/android/internal/telephony/ServiceStateTracker;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/ServiceStateTracker;->getCurrentDataConnectionState()I

    move-result v12

    .line 219
    :cond_9
    const-string v21, "[LGE_DATA][LGDCT] "

    new-instance v22, Ljava/lang/StringBuilder;

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuilder;-><init>()V

    const-string v23, "[LGE_DATA] com.lge.GprsAttachedIsTrue / default : "

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, " / gprsState : "

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-static/range {v21 .. v22}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 221
    if-eqz v9, :cond_0

    invoke-virtual {v9}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getState()Lcom/android/internal/telephony/DctConstants$State;

    move-result-object v21

    sget-object v22, Lcom/android/internal/telephony/DctConstants$State;->CONNECTED:Lcom/android/internal/telephony/DctConstants$State;

    move-object/from16 v0, v21

    move-object/from16 v1, v22

    if-eq v0, v1, :cond_0

    if-nez v12, :cond_0

    .line 225
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v21, v0

    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-static/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$000(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->onDataConnectionAttached()V

    goto/16 :goto_0

    .line 230
    .end local v9    # "defaultContext":Lcom/android/internal/telephony/dataconnection/ApnContext;
    .end local v12    # "gprsState":I
    :cond_a
    const-string v21, "android.intent.action.ANY_DATA_STATE"

    move-object/from16 v0, v21

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_e

    .line 232
    const-string v21, "apnType"

    move-object/from16 v0, p2

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 233
    .local v7, "apnType":Ljava/lang/String;
    const-class v21, Lcom/android/internal/telephony/PhoneConstants$DataState;

    const-string v22, "state"

    move-object/from16 v0, p2

    move-object/from16 v1, v22

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v22

    invoke-static/range {v21 .. v22}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v20

    check-cast v20, Lcom/android/internal/telephony/PhoneConstants$DataState;

    .line 237
    .local v20, "state":Lcom/android/internal/telephony/PhoneConstants$DataState;
    if-nez v7, :cond_b

    .line 238
    const-string v21, "[LGE_DATA][LGDCT] "

    const-string v22, "[LG_DATA] onReceive() ACTION_ANY_DATA_CONNECTION_STATE_CHANGED apnType is NULL"

    invoke-static/range {v21 .. v22}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 239
    const-string v7, ""

    .line 243
    :cond_b
    const-string v21, "[LGE_DATA][LGDCT] "

    new-instance v22, Ljava/lang/StringBuilder;

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuilder;-><init>()V

    const-string v23, "[LGE_DATA] ACTION_ANY_DATA_CONNECTION_STATE_CHANGED : "

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    move-object/from16 v1, v20

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, "  type "

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-static/range {v21 .. v22}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 245
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v21, v0

    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-static/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$000(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-result-object v21

    move-object/from16 v0, v21

    invoke-virtual {v0, v7}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->apnTypeToId(Ljava/lang/String;)I

    move-result v21

    const/16 v22, -0x1

    move/from16 v0, v21

    move/from16 v1, v22

    if-ne v0, v1, :cond_c

    .line 246
    const-string v21, "[LGE_DATA][LGDCT] "

    new-instance v22, Ljava/lang/StringBuilder;

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuilder;-><init>()V

    const-string v23, "[LGE_DATA] This apnType is invalid apn. apnType == "

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-static/range {v21 .. v22}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 250
    :cond_c
    sget-object v21, Lcom/android/internal/telephony/lgdata/LgDcTracker$2;->$SwitchMap$com$android$internal$telephony$PhoneConstants$DataState:[I

    invoke-virtual/range {v20 .. v20}, Lcom/android/internal/telephony/PhoneConstants$DataState;->ordinal()I

    move-result v22

    aget v21, v21, v22

    packed-switch v21, :pswitch_data_0

    goto/16 :goto_0

    .line 252
    :pswitch_1
    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->setTeardownRequested:[Z
    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$200()[Z

    move-result-object v21

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v22, v0

    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-static/range {v22 .. v22}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$000(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v7}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->apnTypeToId(Ljava/lang/String;)I

    move-result v22

    aget-boolean v21, v21, v22

    if-eqz v21, :cond_0

    .line 253
    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->setTeardownRequested:[Z
    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$200()[Z

    move-result-object v21

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v22, v0

    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-static/range {v22 .. v22}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$000(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v7}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->apnTypeToId(Ljava/lang/String;)I

    move-result v22

    const/16 v23, 0x0

    aput-boolean v23, v21, v22

    goto/16 :goto_0

    .line 262
    :pswitch_2
    sget-object v21, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_TOAST_ON_WIFI_OFF_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v21

    const/16 v22, 0x1

    move/from16 v0, v21

    move/from16 v1, v22

    if-eq v0, v1, :cond_d

    sget-object v21, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_PAYPOPUP_KT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v21

    const/16 v22, 0x1

    move/from16 v0, v21

    move/from16 v1, v22

    if-ne v0, v1, :cond_0

    .line 263
    :cond_d
    const-string v21, "wifi"

    move-object/from16 v0, v21

    invoke-virtual {v7, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_0

    .line 264
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v21, v0

    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-static/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$000(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-result-object v21

    const/16 v22, 0x1

    move/from16 v0, v22

    move-object/from16 v1, v21

    iput-boolean v0, v1, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mIsWifiConnected:Z

    .line 265
    const-string v21, "[LGE_DATA][LGDCT] "

    const-string v22, "[LG_DATA]WIFI IS CONNECTED"

    invoke-static/range {v21 .. v22}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 272
    .end local v7    # "apnType":Ljava/lang/String;
    .end local v20    # "state":Lcom/android/internal/telephony/PhoneConstants$DataState;
    :cond_e
    const-string v21, "android.intent.action.DATA_CONNECTION_FAILED"

    move-object/from16 v0, v21

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_f

    .line 274
    const-string v21, "apnType"

    move-object/from16 v0, p2

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 275
    .restart local v7    # "apnType":Ljava/lang/String;
    const-string v21, "reason"

    move-object/from16 v0, p2

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v19

    .line 276
    .local v19, "reason":Ljava/lang/String;
    const-string v21, "apn"

    move-object/from16 v0, p2

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 277
    .local v6, "apnName":Ljava/lang/String;
    const-string v21, "[LGE_DATA][LGDCT] "

    new-instance v22, Ljava/lang/StringBuilder;

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuilder;-><init>()V

    const-string v23, "[LGE_DATA] ACTION_DATA_CONNECTION_FAILED (type) : "

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-static/range {v21 .. v22}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 278
    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->setTeardownRequested:[Z
    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$200()[Z

    move-result-object v21

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v22, v0

    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-static/range {v22 .. v22}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$000(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v7}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->apnTypeToId(Ljava/lang/String;)I

    move-result v22

    const/16 v23, 0x0

    aput-boolean v23, v21, v22

    .line 281
    const-string v21, "wifi"

    move-object/from16 v0, v21

    invoke-virtual {v7, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_0

    .line 282
    const-string v21, "[LGE_DATA][LGDCT] "

    const-string v22, "handleConnectionFailure: mIsWifiConnected = false"

    invoke-static/range {v21 .. v22}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 283
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v21, v0

    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-static/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$000(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-result-object v21

    const/16 v22, 0x0

    move/from16 v0, v22

    move-object/from16 v1, v21

    iput-boolean v0, v1, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mIsWifiConnected:Z

    goto/16 :goto_0

    .line 288
    .end local v6    # "apnName":Ljava/lang/String;
    .end local v7    # "apnType":Ljava/lang/String;
    .end local v19    # "reason":Ljava/lang/String;
    :cond_f
    const-string v21, "ACTIVATE_SETUP_DATA_CALL"

    move-object/from16 v0, v21

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_10

    .line 289
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v21, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v22, v0

    const v23, 0x42817

    const-string v24, "dataEnabled"

    invoke-virtual/range {v22 .. v24}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->sendMessage(Landroid/os/Message;)Z

    goto/16 :goto_0

    .line 294
    :cond_10
    const-string v21, "lge.test.routetable.add"

    move-object/from16 v0, v21

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_11

    .line 295
    const-string v21, "[LGE_DATA][LGDCT] "

    const-string v22, "[LG_DATA][Test] lge.test.routetable.add"

    invoke-static/range {v21 .. v22}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 296
    const-string v4, "1.2.3.4"

    .line 297
    .local v4, "address1":Ljava/lang/String;
    const/16 v16, 0xb

    .line 298
    .local v16, "networktype_ims1":I
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v21, v0

    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;
    invoke-static/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$100(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/PhoneBase;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v21

    const-string v22, "connectivity"

    invoke-virtual/range {v21 .. v22}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Landroid/net/ConnectivityManager;

    .line 300
    .local v8, "cm":Landroid/net/ConnectivityManager;
    :try_start_0
    invoke-static {v4}, Ljava/net/InetAddress;->getByName(Ljava/lang/String;)Ljava/net/InetAddress;

    move-result-object v13

    .line 301
    .local v13, "iaddress1":Ljava/net/InetAddress;
    move/from16 v0, v16

    invoke-virtual {v8, v0, v13}, Landroid/net/ConnectivityManager;->requestRouteToHostAddress(ILjava/net/InetAddress;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_0

    .line 302
    .end local v13    # "iaddress1":Ljava/net/InetAddress;
    :catch_0
    move-exception v10

    .line 303
    .local v10, "e":Ljava/lang/Exception;
    const-string v21, "[LGE_DATA][LGDCT] "

    const-string v22, "[LG_DATA][Test] lge.test.routetable.add(exception error)"

    invoke-static/range {v21 .. v22}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 306
    .end local v4    # "address1":Ljava/lang/String;
    .end local v8    # "cm":Landroid/net/ConnectivityManager;
    .end local v10    # "e":Ljava/lang/Exception;
    .end local v16    # "networktype_ims1":I
    :cond_11
    const-string v21, "lge.test.routetable.delete"

    move-object/from16 v0, v21

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_12

    .line 307
    const-string v21, "[LGE_DATA][LGDCT] "

    const-string v22, "[LG_DATA][Test] lge.test.routetable.delete"

    invoke-static/range {v21 .. v22}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 308
    const-string v5, "1.2.3.4"

    .line 309
    .local v5, "address2":Ljava/lang/String;
    const/16 v17, 0xb

    .line 310
    .local v17, "networktype_ims2":I
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v21, v0

    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;
    invoke-static/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$100(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/PhoneBase;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v21

    const-string v22, "connectivity"

    invoke-virtual/range {v21 .. v22}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Landroid/net/ConnectivityManager;

    .line 312
    .restart local v8    # "cm":Landroid/net/ConnectivityManager;
    :try_start_1
    invoke-static {v5}, Ljava/net/InetAddress;->getByName(Ljava/lang/String;)Ljava/net/InetAddress;

    move-result-object v14

    .line 313
    .local v14, "iaddress2":Ljava/net/InetAddress;
    move/from16 v0, v17

    invoke-virtual {v8, v0, v14}, Landroid/net/ConnectivityManager;->requestRemRouteToHostAddress(ILjava/net/InetAddress;)Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto/16 :goto_0

    .line 314
    .end local v14    # "iaddress2":Ljava/net/InetAddress;
    :catch_1
    move-exception v10

    .line 315
    .restart local v10    # "e":Ljava/lang/Exception;
    const-string v21, "[LGE_DATA][LGDCT] "

    const-string v22, "[LG_DATA][Test] lge.test.routetable.delete(exception error)"

    invoke-static/range {v21 .. v22}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 321
    .end local v5    # "address2":Ljava/lang/String;
    .end local v8    # "cm":Landroid/net/ConnectivityManager;
    .end local v10    # "e":Ljava/lang/Exception;
    .end local v17    # "networktype_ims2":I
    :cond_12
    const-string v21, "com.lge.callingsetmobile"

    move-object/from16 v0, v21

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_0

    .line 322
    const-string v21, "[LGE_DATA][LGDCT] "

    const-string v22, "CallingSetMobileDataEnabled intent receiver"

    invoke-static/range {v21 .. v22}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 324
    const-string v21, "CallingPackagesName"

    move-object/from16 v0, p2

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v18

    .line 326
    .local v18, "packname":Ljava/lang/String;
    if-nez v18, :cond_13

    .line 328
    const-string v18, ""

    .line 331
    :cond_13
    const-string v21, "enabled"

    const/16 v22, 0x0

    move-object/from16 v0, p2

    move-object/from16 v1, v21

    move/from16 v2, v22

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v21

    invoke-static/range {v21 .. v21}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v11

    .line 332
    .local v11, "enabled":Ljava/lang/Boolean;
    const/4 v15, 0x0

    .line 334
    .local v15, "mobile_enable":I
    invoke-virtual {v11}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v21

    if-eqz v21, :cond_14

    .line 335
    const/4 v15, 0x1

    .line 340
    :goto_1
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/lgdata/LgDcTracker$1;->this$0:Lcom/android/internal/telephony/lgdata/LgDcTracker;

    move-object/from16 v21, v0

    # getter for: Lcom/android/internal/telephony/lgdata/LgDcTracker;->mDct:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
    invoke-static/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDcTracker;->access$000(Lcom/android/internal/telephony/lgdata/LgDcTracker;)Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-result-object v21

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->dataMgr:Lcom/android/internal/telephony/DataConnectionManager;

    move-object/from16 v21, v0

    sget-object v22, Lcom/android/internal/telephony/DataConnectionManager$FunctionName;->callingSetMobileDataEnabled:Lcom/android/internal/telephony/DataConnectionManager$FunctionName;

    move-object/from16 v0, v21

    move-object/from16 v1, v22

    move-object/from16 v2, v18

    invoke-virtual {v0, v1, v2, v15}, Lcom/android/internal/telephony/DataConnectionManager;->IntegrationAPI(Lcom/android/internal/telephony/DataConnectionManager$FunctionName;Ljava/lang/String;I)I

    goto/16 :goto_0

    .line 337
    :cond_14
    const/4 v15, 0x0

    goto :goto_1

    .line 250
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
        :pswitch_0
        :pswitch_2
    .end packed-switch
.end method
