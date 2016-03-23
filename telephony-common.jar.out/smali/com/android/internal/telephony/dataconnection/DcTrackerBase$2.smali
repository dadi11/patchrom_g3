.class Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;
.super Landroid/content/BroadcastReceiver;
.source "DcTrackerBase.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/dataconnection/DcTrackerBase;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;


# direct methods
.method constructor <init>(Lcom/android/internal/telephony/dataconnection/DcTrackerBase;)V
    .locals 0

    .prologue
    .line 703
    iput-object p1, p0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 24
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    .line 707
    invoke-virtual/range {p2 .. p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v4

    .line 708
    .local v4, "action":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    new-instance v22, Ljava/lang/StringBuilder;

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuilder;-><init>()V

    const-string v23, "onReceive: action="

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 709
    const-string v21, "android.intent.action.SCREEN_ON"

    move-object/from16 v0, v21

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_2

    .line 710
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const/16 v22, 0x1

    move/from16 v0, v22

    move-object/from16 v1, v21

    iput-boolean v0, v1, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mIsScreenOn:Z

    .line 711
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->stopNetStatPoll()V

    .line 712
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->startNetStatPoll()V

    .line 713
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->restartDataStallAlarm()V

    .line 715
    sget-object v21, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PSRETRY_ON_SCREENON:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v21

    if-eqz v21, :cond_1

    .line 716
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v21, v0

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v21

    const-string v22, "airplane_mode_on"

    const/16 v23, 0x0

    invoke-static/range {v21 .. v23}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v5

    .line 717
    .local v5, "airplaneMode":I
    const/16 v21, 0x1

    move/from16 v0, v21

    if-eq v5, v0, :cond_1

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-boolean v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mIsWifiConnected:Z

    move/from16 v21, v0

    if-nez v21, :cond_1

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v21, v0

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v21

    const-string v22, "mobile_data"

    const/16 v23, 0x1

    invoke-static/range {v21 .. v23}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v21

    const/16 v22, 0x1

    move/from16 v0, v21

    move/from16 v1, v22

    if-ne v0, v1, :cond_1

    .line 719
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mApnContexts:Ljava/util/concurrent/ConcurrentHashMap;

    move-object/from16 v21, v0

    invoke-virtual/range {v21 .. v21}, Ljava/util/concurrent/ConcurrentHashMap;->values()Ljava/util/Collection;

    move-result-object v21

    invoke-interface/range {v21 .. v21}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v11

    .local v11, "i$":Ljava/util/Iterator;
    :cond_0
    invoke-interface {v11}, Ljava/util/Iterator;->hasNext()Z

    move-result v21

    if-eqz v21, :cond_1

    invoke-interface {v11}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/android/internal/telephony/dataconnection/ApnContext;

    .line 721
    .local v6, "apnContexts":Lcom/android/internal/telephony/dataconnection/ApnContext;
    if-eqz v6, :cond_0

    .line 723
    invoke-virtual {v6}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getState()Lcom/android/internal/telephony/DctConstants$State;

    move-result-object v21

    sget-object v22, Lcom/android/internal/telephony/DctConstants$State;->FAILED:Lcom/android/internal/telephony/DctConstants$State;

    move-object/from16 v0, v21

    move-object/from16 v1, v22

    if-ne v0, v1, :cond_0

    invoke-virtual {v6}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getWaitingApnsPermFailCount()I

    move-result v21

    if-eqz v21, :cond_0

    .line 725
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const-string v22, "Send Message : EVENT_PS_RETRY_RESET"

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 726
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v22, v0

    const v23, 0x42803

    invoke-virtual/range {v22 .. v23}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->obtainMessage(I)Landroid/os/Message;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->sendMessage(Landroid/os/Message;)Z

    .line 970
    .end local v5    # "airplaneMode":I
    .end local v6    # "apnContexts":Lcom/android/internal/telephony/dataconnection/ApnContext;
    .end local v11    # "i$":Ljava/util/Iterator;
    :cond_1
    :goto_0
    return-void

    .line 736
    :cond_2
    const-string v21, "android.intent.action.SCREEN_OFF"

    move-object/from16 v0, v21

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_3

    .line 737
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const/16 v22, 0x0

    move/from16 v0, v22

    move-object/from16 v1, v21

    iput-boolean v0, v1, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mIsScreenOn:Z

    .line 738
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->stopNetStatPoll()V

    .line 739
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->startNetStatPoll()V

    .line 740
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->restartDataStallAlarm()V

    goto :goto_0

    .line 741
    :cond_3
    const-string v21, "com.android.internal.telephony.data-reconnect"

    move-object/from16 v0, v21

    invoke-virtual {v4, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v21

    if-eqz v21, :cond_4

    .line 742
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    new-instance v22, Ljava/lang/StringBuilder;

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuilder;-><init>()V

    const-string v23, "Reconnect alarm. Previous state was "

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v23, v0

    move-object/from16 v0, v23

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mState:Lcom/android/internal/telephony/DctConstants$State;

    move-object/from16 v23, v0

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 743
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    move-object/from16 v1, p2

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->onActionIntentReconnectAlarm(Landroid/content/Intent;)V

    goto :goto_0

    .line 744
    :cond_4
    const-string v21, "com.android.internal.telephony.data-restart-trysetup"

    move-object/from16 v0, v21

    invoke-virtual {v4, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v21

    if-eqz v21, :cond_5

    .line 745
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const-string v22, "Restart trySetup alarm"

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 746
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    move-object/from16 v1, p2

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->onActionIntentRestartTrySetupAlarm(Landroid/content/Intent;)V

    goto/16 :goto_0

    .line 747
    :cond_5
    const-string v21, "com.android.internal.telephony.data-stall"

    move-object/from16 v0, v21

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_6

    .line 748
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    move-object/from16 v1, p2

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->onActionIntentDataStallAlarm(Landroid/content/Intent;)V

    goto/16 :goto_0

    .line 749
    :cond_6
    const-string v21, "com.android.internal.telephony.provisioning_apn_alarm"

    move-object/from16 v0, v21

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_7

    .line 750
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    move-object/from16 v1, p2

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->onActionIntentProvisioningApnAlarm(Landroid/content/Intent;)V

    goto/16 :goto_0

    .line 751
    :cond_7
    const-string v21, "android.net.wifi.STATE_CHANGE"

    move-object/from16 v0, v21

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_9

    .line 752
    const-string v21, "networkInfo"

    move-object/from16 v0, p2

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v15

    check-cast v15, Landroid/net/NetworkInfo;

    .line 754
    .local v15, "networkInfo":Landroid/net/NetworkInfo;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v22, v0

    if-eqz v15, :cond_8

    invoke-virtual {v15}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v21

    if-eqz v21, :cond_8

    const/16 v21, 0x1

    :goto_1
    move/from16 v0, v21

    move-object/from16 v1, v22

    iput-boolean v0, v1, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mIsWifiConnected:Z

    .line 755
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    new-instance v22, Ljava/lang/StringBuilder;

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuilder;-><init>()V

    const-string v23, "NETWORK_STATE_CHANGED_ACTION: mIsWifiConnected="

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v23, v0

    move-object/from16 v0, v23

    iget-boolean v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mIsWifiConnected:Z

    move/from16 v23, v0

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 757
    sget-object v21, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_FAIL_ICON_DISPLAY_SPRINT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v21

    if-eqz v21, :cond_1

    .line 758
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-boolean v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mIsWifiConnected:Z

    move/from16 v21, v0

    if-eqz v21, :cond_1

    .line 760
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const-string v22, "com.lge.android.data.DisplayDataErrorIcon: No Display(wifi connected)"

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 761
    new-instance v3, Landroid/content/Intent;

    const-string v21, "com.lge.android.data.DisplayDataErrorIcon"

    move-object/from16 v0, v21

    invoke-direct {v3, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 762
    .local v3, "DisplayDataErrorIcon":Landroid/content/Intent;
    const-string v21, "Display"

    const/16 v22, 0x0

    move-object/from16 v0, v21

    move/from16 v1, v22

    invoke-virtual {v3, v0, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .line 763
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v21, v0

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v21

    move-object/from16 v0, v21

    invoke-virtual {v0, v3}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto/16 :goto_0

    .line 754
    .end local v3    # "DisplayDataErrorIcon":Landroid/content/Intent;
    :cond_8
    const/16 v21, 0x0

    goto :goto_1

    .line 767
    .end local v15    # "networkInfo":Landroid/net/NetworkInfo;
    :cond_9
    const-string v21, "android.net.wifi.WIFI_STATE_CHANGED"

    move-object/from16 v0, v21

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_c

    .line 768
    const-string v21, "wifi_state"

    const/16 v22, 0x4

    move-object/from16 v0, p2

    move-object/from16 v1, v21

    move/from16 v2, v22

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v21

    const/16 v22, 0x3

    move/from16 v0, v21

    move/from16 v1, v22

    if-ne v0, v1, :cond_b

    const/4 v9, 0x1

    .line 771
    .local v9, "enabled":Z
    :goto_2
    if-nez v9, :cond_a

    .line 774
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const/16 v22, 0x0

    move/from16 v0, v22

    move-object/from16 v1, v21

    iput-boolean v0, v1, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mIsWifiConnected:Z

    .line 776
    :cond_a
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    new-instance v22, Ljava/lang/StringBuilder;

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuilder;-><init>()V

    const-string v23, "WIFI_STATE_CHANGED_ACTION: enabled="

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, " mIsWifiConnected="

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v23, v0

    move-object/from16 v0, v23

    iget-boolean v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mIsWifiConnected:Z

    move/from16 v23, v0

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 768
    .end local v9    # "enabled":Z
    :cond_b
    const/4 v9, 0x0

    goto :goto_2

    .line 780
    :cond_c
    const-string v21, "android.intent.action.SIM_TYPE_CHANGED"

    move-object/from16 v0, v21

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_d

    .line 781
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const-string v22, "android.intent.action.SIM_TYPE_CHANGED Intent received"

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 782
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v22, v0

    const v23, 0x42013

    invoke-virtual/range {v22 .. v23}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->obtainMessage(I)Landroid/os/Message;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->sendMessage(Landroid/os/Message;)Z

    goto/16 :goto_0

    .line 786
    :cond_d
    const-string v21, "com.lge.internal.telephony.lge-data-disable-request-timeout"

    move-object/from16 v0, v21

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_e

    .line 787
    const-string v21, "flag"

    const/16 v22, -0x1

    move-object/from16 v0, p2

    move-object/from16 v1, v21

    move/from16 v2, v22

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v10

    .line 788
    .local v10, "flag":I
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    invoke-virtual {v0, v10}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->clearDataDisabledFlag(I)I

    goto/16 :goto_0

    .line 792
    .end local v10    # "flag":I
    :cond_e
    const-string v21, "android.intent.action.IPV6_STATUS"

    move-object/from16 v0, v21

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_11

    .line 793
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const-string v22, "[EHRPD_IPV6] !!!!!!!IPV6_STATUS CHANGE!!!!!!!!!"

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 795
    new-instance v13, Landroid/content/Intent;

    const-string v21, "android.intent.action.IPV6_STATUS_RESULT"

    move-object/from16 v0, v21

    invoke-direct {v13, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 797
    .local v13, "mIntent":Landroid/content/Intent;
    sget-object v21, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TCPIP_IP_V6_BLOCK_CONFIG_ON_EHRPD_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v21

    const/16 v22, 0x1

    move/from16 v0, v21

    move/from16 v1, v22

    if-ne v0, v1, :cond_10

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mAllApnSettings:Ljava/util/ArrayList;

    move-object/from16 v21, v0

    if-eqz v21, :cond_10

    .line 798
    const-string v21, "ipv6_status_result"

    const/16 v22, 0x1

    move-object/from16 v0, v21

    move/from16 v1, v22

    invoke-virtual {v13, v0, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 799
    const-string v21, "ipv6_status_enable"

    const/16 v22, 0x0

    move-object/from16 v0, p2

    move-object/from16 v1, v21

    move/from16 v2, v22

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v12

    .line 800
    .local v12, "isEnable":Z
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    new-instance v22, Ljava/lang/StringBuilder;

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuilder;-><init>()V

    const-string v23, "[EHRPD_IPV6] !!!!!!!IPV6_STATUS CHANGE ==> "

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, "!!!!!!!!!"

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 801
    if-eqz v12, :cond_f

    .line 804
    const-string v21, "ril.current.ehrpdipv6enable"

    const-string v22, "1"

    invoke-static/range {v21 .. v22}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 807
    const-string v21, "ipv6_status_enable"

    const/16 v22, 0x1

    move-object/from16 v0, v21

    move/from16 v1, v22

    invoke-virtual {v13, v0, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 808
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v21, v0

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v21

    move-object/from16 v0, v21

    invoke-virtual {v0, v13}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto/16 :goto_0

    .line 813
    :cond_f
    const-string v21, "ril.current.ehrpdipv6enable"

    const-string v22, "0"

    invoke-static/range {v21 .. v22}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 816
    const-string v21, "ipv6_status_enable"

    const/16 v22, 0x0

    move-object/from16 v0, v21

    move/from16 v1, v22

    invoke-virtual {v13, v0, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 817
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v21, v0

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v21

    move-object/from16 v0, v21

    invoke-virtual {v0, v13}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto/16 :goto_0

    .line 821
    .end local v12    # "isEnable":Z
    :cond_10
    const-string v21, "ipv6_status_result"

    const/16 v22, 0x0

    move-object/from16 v0, v21

    move/from16 v1, v22

    invoke-virtual {v13, v0, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 822
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v21, v0

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v21

    move-object/from16 v0, v21

    invoke-virtual {v0, v13}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    .line 823
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const-string v22, "[EHRPD_IPV6] mAllApns is Null"

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 828
    .end local v13    # "mIntent":Landroid/content/Intent;
    :cond_11
    const-string v21, "android.intent.action.OMADM_DEVICE_LOCK_MSG"

    move-object/from16 v0, v21

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_12

    .line 830
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    new-instance v22, Ljava/lang/StringBuilder;

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuilder;-><init>()V

    const-string v23, "[LG_DATA_SPRINT_OMADM_DATA_BLOCK] : before OMADM_DEVICE_LOCK_MSG, mOmaDmIsLock= "

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v23, v0

    move-object/from16 v0, v23

    iget v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mOmaDmIsLock:I

    move/from16 v23, v0

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 833
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const/16 v22, 0x1

    move/from16 v0, v22

    move-object/from16 v1, v21

    iput v0, v1, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mOmaDmIsLock:I

    .line 834
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const/16 v22, 0x0

    move/from16 v0, v22

    move-object/from16 v1, v21

    iput v0, v1, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mOmaDmIsSession:I

    .line 837
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const-string v22, "[LG_DATA_SPRINT_OMADM_DATA_BLOCK] :call setDataConnection(false);"

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 840
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const/16 v22, 0x0

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->setDataConnection(Z)V

    goto/16 :goto_0

    .line 841
    :cond_12
    const-string v21, "android.intent.action.DEVICE_UNLOCKED_MSG"

    move-object/from16 v0, v21

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_13

    .line 844
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const/16 v22, 0x0

    move/from16 v0, v22

    move-object/from16 v1, v21

    iput v0, v1, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mOmaDmIsLock:I

    .line 847
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const-string v22, "[LG_DATA_SPRINT_OMADM_DATA_BLOCK] :call setDataConnection(true);"

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 849
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const/16 v22, 0x1

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->setDataConnection(Z)V

    goto/16 :goto_0

    .line 851
    :cond_13
    const-string v21, "android.intent.action.REQUEST_START_OMADM_SESSION_MSG"

    move-object/from16 v0, v21

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_17

    .line 852
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v21, v0

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/PhoneBase;->getServiceState()Landroid/telephony/ServiceState;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Landroid/telephony/ServiceState;->getRoaming()Z

    move-result v20

    .line 853
    .local v20, "roaming":Z
    const/4 v7, 0x0

    .line 856
    .local v7, "dmcLockStatus":I
    :try_start_0
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v21, v0

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v21

    const-string v22, "lg_omadm_lwmo_lock_state"

    const/16 v23, 0x0

    invoke-static/range {v21 .. v23}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    move-result v7

    .line 860
    :goto_3
    if-eqz v20, :cond_14

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->getDataOnRoamingEnabled()Z

    move-result v21

    if-eqz v21, :cond_15

    :cond_14
    const/16 v21, 0x1

    move/from16 v0, v21

    if-ne v7, v0, :cond_16

    .line 861
    :cond_15
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const/16 v22, 0x1

    move/from16 v0, v22

    move-object/from16 v1, v21

    iput v0, v1, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mOmaDmIsSession:I

    .line 862
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const/16 v22, 0x1

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->setDataConnection(Z)V

    .line 864
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    new-instance v22, Ljava/lang/StringBuilder;

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuilder;-><init>()V

    const-string v23, "[LG_DATA_SPRINT_OMADM_START] : Receive Message for OMADM Start , roaming or lock status. mOmaDmIsSession : "

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v23, v0

    move-object/from16 v0, v23

    iget v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mOmaDmIsSession:I

    move/from16 v23, v0

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 868
    :cond_16
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    new-instance v22, Ljava/lang/StringBuilder;

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuilder;-><init>()V

    const-string v23, "[LG_DATA_SPRINT_OMADM_START] : Receive Message for OMADM Start , not roaming and not lock. mOmaDmIsSession :"

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v23, v0

    move-object/from16 v0, v23

    iget v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mOmaDmIsSession:I

    move/from16 v23, v0

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 871
    .end local v7    # "dmcLockStatus":I
    .end local v20    # "roaming":Z
    :cond_17
    const-string v21, "android.intent.action.REQUEST_END_OMADM_SESSION_MSG"

    move-object/from16 v0, v21

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_1b

    .line 872
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v21, v0

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/PhoneBase;->getServiceState()Landroid/telephony/ServiceState;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Landroid/telephony/ServiceState;->getRoaming()Z

    move-result v20

    .line 874
    .restart local v20    # "roaming":Z
    const/4 v7, 0x0

    .line 877
    .restart local v7    # "dmcLockStatus":I
    :try_start_1
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v21, v0

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v21

    const-string v22, "lg_omadm_lwmo_lock_state"

    const/16 v23, 0x0

    invoke-static/range {v21 .. v23}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    move-result v7

    .line 881
    :goto_4
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const/16 v22, 0x0

    move/from16 v0, v22

    move-object/from16 v1, v21

    iput v0, v1, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mOmaDmIsSession:I

    .line 882
    if-eqz v20, :cond_18

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->getDataOnRoamingEnabled()Z

    move-result v21

    if-eqz v21, :cond_19

    :cond_18
    const/16 v21, 0x1

    move/from16 v0, v21

    if-ne v7, v0, :cond_1a

    .line 883
    :cond_19
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const/16 v22, 0x0

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->setDataConnection(Z)V

    .line 885
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    new-instance v22, Ljava/lang/StringBuilder;

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuilder;-><init>()V

    const-string v23, "[LG_DATA_SPRINT_OMADM_END] : Receive Message for OMADM Start , roaming or lock status. mOmaDmIsSession : "

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v23, v0

    move-object/from16 v0, v23

    iget v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mOmaDmIsSession:I

    move/from16 v23, v0

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 889
    :cond_1a
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    new-instance v22, Ljava/lang/StringBuilder;

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuilder;-><init>()V

    const-string v23, "[LG_DATA_SPRINT_OMADM_END] : Receive Message for OMADM Start , not roaming and not lock. mOmaDmIsSession : "

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v23, v0

    move-object/from16 v0, v23

    iget v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mOmaDmIsSession:I

    move/from16 v23, v0

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 892
    .end local v7    # "dmcLockStatus":I
    .end local v20    # "roaming":Z
    :cond_1b
    const-string v21, "android.intent.action.REQUEST_FOR_OMADM_DATA_SETUP"

    move-object/from16 v0, v21

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_1c

    .line 893
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const/16 v22, 0x0

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->setDataConnection(Z)V

    .line 894
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const/16 v22, 0x1

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->setDataConnection(Z)V

    goto/16 :goto_0

    .line 895
    :cond_1c
    const-string v21, "android.intent.action.REQUEST_FOR_OMADM_DATA_DISCONNECT"

    move-object/from16 v0, v21

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_1d

    .line 896
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const/16 v22, 0x0

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->setDataConnection(Z)V

    goto/16 :goto_0

    .line 897
    :cond_1d
    const-string v21, "android.intent.action.REQUEST_FOR_OMADM_DATA_CONNECT"

    move-object/from16 v0, v21

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_1e

    .line 898
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const/16 v22, 0x1

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->setDataConnection(Z)V

    goto/16 :goto_0

    .line 902
    :cond_1e
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->ACTION_MOBILE_DATA_ROAMING_STATE_CHANGE_REQUEST:Ljava/lang/String;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_20

    .line 903
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->REQUEST_STATE:Ljava/lang/String;

    move-object/from16 v21, v0

    const/16 v22, 0x0

    move-object/from16 v0, p2

    move-object/from16 v1, v21

    move/from16 v2, v22

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v21

    const/16 v22, 0x1

    move/from16 v0, v21

    move/from16 v1, v22

    if-ne v0, v1, :cond_1f

    const/4 v8, 0x1

    .line 905
    .local v8, "enable":Z
    :goto_5
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    new-instance v22, Ljava/lang/StringBuilder;

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuilder;-><init>()V

    const-string v23, "[DATA_ROAMING_STATE_CHANGE_REQUET] ==> "

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 906
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    invoke-virtual {v0, v8}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->setDataOnRoamingEnabled(Z)V

    .line 907
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->onRoamingOn()V

    goto/16 :goto_0

    .line 903
    .end local v8    # "enable":Z
    :cond_1f
    const/4 v8, 0x0

    goto :goto_5

    .line 911
    :cond_20
    const-string v21, "com.lge.android.intent.action.ACTION_NETWORK_GRPS_STATE_CHANGE"

    move-object/from16 v0, v21

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_22

    .line 912
    sget-object v21, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_CLEAR_CAUSE_FOR_TCL:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v21

    if-eqz v21, :cond_1

    .line 913
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mIccRecords:Ljava/util/concurrent/atomic/AtomicReference;

    move-object/from16 v21, v0

    invoke-virtual/range {v21 .. v21}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v18

    check-cast v18, Lcom/android/internal/telephony/uicc/IccRecords;

    .line 914
    .local v18, "r":Lcom/android/internal/telephony/uicc/IccRecords;
    if-eqz v18, :cond_21

    invoke-virtual/range {v18 .. v18}, Lcom/android/internal/telephony/uicc/IccRecords;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v16

    .line 915
    .local v16, "numeric":Ljava/lang/String;
    :goto_6
    const-string v21, "rac"

    const/16 v22, -0x1

    invoke-static/range {v22 .. v22}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v22

    move-object/from16 v0, p2

    move-object/from16 v1, v21

    move-object/from16 v2, v22

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->getExtra(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v21

    check-cast v21, Ljava/lang/Integer;

    invoke-virtual/range {v21 .. v21}, Ljava/lang/Integer;->intValue()I

    move-result v19

    .line 916
    .local v19, "rac":I
    const/16 v21, -0x1

    move/from16 v0, v19

    move/from16 v1, v21

    if-eq v0, v1, :cond_1

    const-string v21, "334020"

    move-object/from16 v0, v21

    move-object/from16 v1, v16

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_1

    .line 917
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    move/from16 v1, v19

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->retryAfterRAU(I)V

    goto/16 :goto_0

    .line 914
    .end local v16    # "numeric":Ljava/lang/String;
    .end local v19    # "rac":I
    :cond_21
    const-string v16, ""

    goto :goto_6

    .line 924
    .end local v18    # "r":Lcom/android/internal/telephony/uicc/IccRecords;
    :cond_22
    const-string v21, "com.lge.android.LTE_PCO"

    move-object/from16 v0, v21

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v21

    if-eqz v21, :cond_1

    .line 925
    sget-object v21, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_LTE_PCO_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v21

    if-eqz v21, :cond_1

    .line 926
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const-string v22, "[PCO_TEST] com.lge.android.LTE_PCO"

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 928
    const-string v21, "pco_value"

    const/16 v22, 0x0

    move-object/from16 v0, p2

    move-object/from16 v1, v21

    move/from16 v2, v22

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v17

    .line 930
    .local v17, "pcoValue":I
    packed-switch v17, :pswitch_data_0

    .line 963
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const-string v22, "[PCO_TEST] PCO value 6~255::TBD "

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 933
    :pswitch_0
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const-string v22, "[PCO_TEST] PCO value 0::normal "

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 934
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    move-object/from16 v0, v21

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    move-object/from16 v21, v0

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v21

    const-string v22, "notification"

    invoke-virtual/range {v21 .. v22}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Landroid/app/NotificationManager;

    .line 935
    .local v14, "mNotificationManager":Landroid/app/NotificationManager;
    const v21, -0xffff

    move/from16 v0, v21

    invoke-virtual {v14, v0}, Landroid/app/NotificationManager;->cancel(I)V

    goto/16 :goto_0

    .line 939
    .end local v14    # "mNotificationManager":Landroid/app/NotificationManager;
    :pswitch_1
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const-string v22, "[PCO_TEST] PCO value 1::TBD "

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 943
    :pswitch_2
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const-string v22, "[PCO_TEST] PCO value 2::NotificationAlertMsg() "

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 944
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->NotificationAlertMsg()V

    goto/16 :goto_0

    .line 948
    :pswitch_3
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const-string v22, "[PCO_TEST] PCO value 3::redirectionDialog() "

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 949
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->redirectionDialog()V

    goto/16 :goto_0

    .line 953
    :pswitch_4
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const-string v22, "[PCO_TEST] PCO value 4:: Rate Throttling "

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 957
    :pswitch_5
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    const-string v22, "[PCO_TEST] PCO value 5::SelfActivationDialog() "

    invoke-virtual/range {v21 .. v22}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->log(Ljava/lang/String;)V

    .line 958
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/dataconnection/DcTrackerBase$2;->this$0:Lcom/android/internal/telephony/dataconnection/DcTrackerBase;

    move-object/from16 v21, v0

    invoke-virtual/range {v21 .. v21}, Lcom/android/internal/telephony/dataconnection/DcTrackerBase;->SelfActivationDialog()V

    goto/16 :goto_0

    .line 878
    .end local v17    # "pcoValue":I
    .restart local v7    # "dmcLockStatus":I
    .restart local v20    # "roaming":Z
    :catch_0
    move-exception v21

    goto/16 :goto_4

    .line 857
    :catch_1
    move-exception v21

    goto/16 :goto_3

    .line 930
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
    .end packed-switch
.end method
