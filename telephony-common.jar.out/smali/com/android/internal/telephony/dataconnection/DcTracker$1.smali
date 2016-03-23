.class Lcom/android/internal/telephony/dataconnection/DcTracker$1;
.super Landroid/content/BroadcastReceiver;
.source "DcTracker.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/dataconnection/DcTracker;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;


# direct methods
.method constructor <init>(Lcom/android/internal/telephony/dataconnection/DcTracker;)V
    .locals 0

    .prologue
    .line 454
    iput-object p1, p0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 16
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    .line 458
    invoke-virtual/range {p2 .. p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v12

    .line 460
    .local v12, "action":Ljava/lang/String;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "onReceive: action="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/dataconnection/DcTracker;->log(Ljava/lang/String;)V

    .line 463
    const-string v2, "com.lge.android.intent.action.ACTION_EHRPD_TIMER_EXPIRED"

    invoke-virtual {v12, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 465
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, "[IMS_AFW] !!!!!!!! EVENT_EHRPD_TIMER_EXPIRED !!!!!!!!!"

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/dataconnection/DcTracker;->log(Ljava/lang/String;)V

    .line 467
    const/4 v2, 0x0

    # setter for: Lcom/android/internal/telephony/dataconnection/DcTracker;->mImsPdnBlockedInEhrpd:Z
    invoke-static {v2}, Lcom/android/internal/telephony/dataconnection/DcTracker;->access$002(Z)Z

    .line 469
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    # getter for: Lcom/android/internal/telephony/dataconnection/DcTracker;->mEhrpdIntent:Landroid/app/PendingIntent;
    invoke-static {v2}, Lcom/android/internal/telephony/dataconnection/DcTracker;->access$100(Lcom/android/internal/telephony/dataconnection/DcTracker;)Landroid/app/PendingIntent;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 470
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v2, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v2}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v2

    const-string v3, "alarm"

    invoke-virtual {v2, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Landroid/app/AlarmManager;

    .line 471
    .local v13, "am":Landroid/app/AlarmManager;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    # getter for: Lcom/android/internal/telephony/dataconnection/DcTracker;->mEhrpdIntent:Landroid/app/PendingIntent;
    invoke-static {v2}, Lcom/android/internal/telephony/dataconnection/DcTracker;->access$100(Lcom/android/internal/telephony/dataconnection/DcTracker;)Landroid/app/PendingIntent;

    move-result-object v2

    invoke-virtual {v13, v2}, Landroid/app/AlarmManager;->cancel(Landroid/app/PendingIntent;)V

    .line 472
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const/4 v3, 0x0

    # setter for: Lcom/android/internal/telephony/dataconnection/DcTracker;->mEhrpdIntent:Landroid/app/PendingIntent;
    invoke-static {v2, v3}, Lcom/android/internal/telephony/dataconnection/DcTracker;->access$102(Lcom/android/internal/telephony/dataconnection/DcTracker;Landroid/app/PendingIntent;)Landroid/app/PendingIntent;

    .line 475
    .end local v13    # "am":Landroid/app/AlarmManager;
    :cond_0
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v2, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v2}, Lcom/android/internal/telephony/PhoneBase;->getServiceState()Landroid/telephony/ServiceState;

    move-result-object v2

    if-eqz v2, :cond_1

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v2, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v2}, Lcom/android/internal/telephony/PhoneBase;->getServiceState()Landroid/telephony/ServiceState;

    move-result-object v2

    invoke-virtual {v2}, Landroid/telephony/ServiceState;->getRadioTechnology()I

    move-result v2

    const/16 v3, 0xd

    if-ne v2, v3, :cond_1

    .line 477
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, "ehrpdTimerExpired"

    # invokes: Lcom/android/internal/telephony/dataconnection/DcTracker;->setupDataOnConnectableApns(Ljava/lang/String;)V
    invoke-static {v2, v3}, Lcom/android/internal/telephony/dataconnection/DcTracker;->access$200(Lcom/android/internal/telephony/dataconnection/DcTracker;Ljava/lang/String;)V

    .line 669
    :cond_1
    :goto_0
    return-void

    .line 482
    :cond_2
    const-string v2, "com.lge.android.intent.action.ACTION_IMS_POWER_OFF_DELAY_EXPIRED"

    invoke-virtual {v12, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 484
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, "[IMS_AFW] !!!!!!!! IMS_POWER_OFF_DELAY_EXPIRED !!!!!!!!!"

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/dataconnection/DcTracker;->log(Ljava/lang/String;)V

    .line 486
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const/4 v3, 0x0

    # setter for: Lcom/android/internal/telephony/dataconnection/DcTracker;->deregiAlarmState:Z
    invoke-static {v2, v3}, Lcom/android/internal/telephony/dataconnection/DcTracker;->access$302(Lcom/android/internal/telephony/dataconnection/DcTracker;Z)Z

    .line 488
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    # getter for: Lcom/android/internal/telephony/dataconnection/DcTracker;->mImsDeregiDelayIntent:Landroid/app/PendingIntent;
    invoke-static {v2}, Lcom/android/internal/telephony/dataconnection/DcTracker;->access$400(Lcom/android/internal/telephony/dataconnection/DcTracker;)Landroid/app/PendingIntent;

    move-result-object v2

    if-eqz v2, :cond_3

    .line 489
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v2, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v2}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v2

    const-string v3, "alarm"

    invoke-virtual {v2, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Landroid/app/AlarmManager;

    .line 490
    .restart local v13    # "am":Landroid/app/AlarmManager;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    # getter for: Lcom/android/internal/telephony/dataconnection/DcTracker;->mImsDeregiDelayIntent:Landroid/app/PendingIntent;
    invoke-static {v2}, Lcom/android/internal/telephony/dataconnection/DcTracker;->access$400(Lcom/android/internal/telephony/dataconnection/DcTracker;)Landroid/app/PendingIntent;

    move-result-object v2

    invoke-virtual {v13, v2}, Landroid/app/AlarmManager;->cancel(Landroid/app/PendingIntent;)V

    .line 491
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const/4 v3, 0x0

    # setter for: Lcom/android/internal/telephony/dataconnection/DcTracker;->mImsDeregiDelayIntent:Landroid/app/PendingIntent;
    invoke-static {v2, v3}, Lcom/android/internal/telephony/dataconnection/DcTracker;->access$402(Lcom/android/internal/telephony/dataconnection/DcTracker;Landroid/app/PendingIntent;)Landroid/app/PendingIntent;

    .line 494
    .end local v13    # "am":Landroid/app/AlarmManager;
    :cond_3
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    # getter for: Lcom/android/internal/telephony/dataconnection/DcTracker;->waitCleanUpApnContext:Lcom/android/internal/telephony/dataconnection/ApnContext;
    invoke-static {v2}, Lcom/android/internal/telephony/dataconnection/DcTracker;->access$500(Lcom/android/internal/telephony/dataconnection/DcTracker;)Lcom/android/internal/telephony/dataconnection/ApnContext;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 496
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[IMS_AFW] Clean up : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    # getter for: Lcom/android/internal/telephony/dataconnection/DcTracker;->waitCleanUpApnContext:Lcom/android/internal/telephony/dataconnection/ApnContext;
    invoke-static {v4}, Lcom/android/internal/telephony/dataconnection/DcTracker;->access$500(Lcom/android/internal/telephony/dataconnection/DcTracker;)Lcom/android/internal/telephony/dataconnection/ApnContext;

    move-result-object v4

    invoke-virtual {v4}, Lcom/android/internal/telephony/dataconnection/ApnContext;->getApnType()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/dataconnection/DcTracker;->log(Ljava/lang/String;)V

    .line 498
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const/4 v3, 0x1

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    # getter for: Lcom/android/internal/telephony/dataconnection/DcTracker;->waitCleanUpApnContext:Lcom/android/internal/telephony/dataconnection/ApnContext;
    invoke-static {v4}, Lcom/android/internal/telephony/dataconnection/DcTracker;->access$500(Lcom/android/internal/telephony/dataconnection/DcTracker;)Lcom/android/internal/telephony/dataconnection/ApnContext;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Lcom/android/internal/telephony/dataconnection/DcTracker;->cleanUpConnection(ZLcom/android/internal/telephony/dataconnection/ApnContext;)V

    goto/16 :goto_0

    .line 502
    :cond_4
    const-string v2, "com.lge.android.intent.action.ACTION_IMS_BLOCK_EXPIRED"

    invoke-virtual {v12, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_6

    .line 503
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, "IMSDAM time of T3402 expired."

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/dataconnection/DcTracker;->log(Ljava/lang/String;)V

    .line 504
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    # getter for: Lcom/android/internal/telephony/dataconnection/DcTracker;->mIMSBlockintent:Landroid/app/PendingIntent;
    invoke-static {v2}, Lcom/android/internal/telephony/dataconnection/DcTracker;->access$600(Lcom/android/internal/telephony/dataconnection/DcTracker;)Landroid/app/PendingIntent;

    move-result-object v2

    if-eqz v2, :cond_5

    .line 505
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v2, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v2}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v2

    const-string v3, "alarm"

    invoke-virtual {v2, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Landroid/app/AlarmManager;

    .line 506
    .restart local v13    # "am":Landroid/app/AlarmManager;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    # getter for: Lcom/android/internal/telephony/dataconnection/DcTracker;->mIMSBlockintent:Landroid/app/PendingIntent;
    invoke-static {v2}, Lcom/android/internal/telephony/dataconnection/DcTracker;->access$600(Lcom/android/internal/telephony/dataconnection/DcTracker;)Landroid/app/PendingIntent;

    move-result-object v2

    invoke-virtual {v13, v2}, Landroid/app/AlarmManager;->cancel(Landroid/app/PendingIntent;)V

    .line 507
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const/4 v3, 0x0

    # setter for: Lcom/android/internal/telephony/dataconnection/DcTracker;->mIMSBlockintent:Landroid/app/PendingIntent;
    invoke-static {v2, v3}, Lcom/android/internal/telephony/dataconnection/DcTracker;->access$602(Lcom/android/internal/telephony/dataconnection/DcTracker;Landroid/app/PendingIntent;)Landroid/app/PendingIntent;

    .line 509
    .end local v13    # "am":Landroid/app/AlarmManager;
    :cond_5
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const/4 v3, 0x0

    # setter for: Lcom/android/internal/telephony/dataconnection/DcTracker;->ATTIMSblock:Z
    invoke-static {v2, v3}, Lcom/android/internal/telephony/dataconnection/DcTracker;->access$702(Lcom/android/internal/telephony/dataconnection/DcTracker;Z)Z

    .line 510
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v2, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    const-string v3, "dataEnabled"

    const-string v4, "ims"

    invoke-virtual {v2, v3, v4}, Lcom/android/internal/telephony/PhoneBase;->notifyDataConnection(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_0

    .line 514
    :cond_6
    const-string v2, "lge.intent.action.LTE_NETWORK_SUPPORTED_INFO"

    invoke-virtual {v12, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_7

    .line 515
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, "VoPS_Support"

    const/4 v4, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v3, v4}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v3

    invoke-static {v3}, Lcom/lge/lgdata/LGDataPhoneConstants$VolteAndEPDNSupport;->fromInt(I)Lcom/lge/lgdata/LGDataPhoneConstants$VolteAndEPDNSupport;

    move-result-object v3

    iput-object v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mVolteSupport:Lcom/lge/lgdata/LGDataPhoneConstants$VolteAndEPDNSupport;

    .line 516
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, "EPDN_Support"

    const/4 v4, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v3, v4}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v3

    invoke-static {v3}, Lcom/lge/lgdata/LGDataPhoneConstants$VolteAndEPDNSupport;->fromInt(I)Lcom/lge/lgdata/LGDataPhoneConstants$VolteAndEPDNSupport;

    move-result-object v3

    iput-object v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEPDNSupport:Lcom/lge/lgdata/LGDataPhoneConstants$VolteAndEPDNSupport;

    .line 517
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[LG_DATA] mVolteSupport = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v4, v4, Lcom/android/internal/telephony/dataconnection/DcTracker;->mVolteSupport:Lcom/lge/lgdata/LGDataPhoneConstants$VolteAndEPDNSupport;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", mEPDNSupport = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v4, v4, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEPDNSupport:Lcom/lge/lgdata/LGDataPhoneConstants$VolteAndEPDNSupport;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/dataconnection/DcTracker;->log(Ljava/lang/String;)V

    .line 519
    sget-object v2, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_KEEP_EMERGENCY_INFO_ON_PHONE_TYPE_CHANGED_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 520
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v2, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    iget-object v2, v2, Lcom/android/internal/telephony/PhoneBase;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v3, v3, Lcom/android/internal/telephony/dataconnection/DcTracker;->mVolteSupport:Lcom/lge/lgdata/LGDataPhoneConstants$VolteAndEPDNSupport;

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v4, v4, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEPDNSupport:Lcom/lge/lgdata/LGDataPhoneConstants$VolteAndEPDNSupport;

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v5, v5, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEmerAttachSupport:Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v6, v6, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEPDNBarring:Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v7, v7, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEmerCampedCID:Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v8, v8, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEmerCampedTAC:Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    move-object/from16 v0, p0

    iget-object v9, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v9, v9, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEmcFailCause:Lcom/lge/lgdata/LGDataPhoneConstants$EmcFailCause;

    move-object/from16 v0, p0

    iget-object v10, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v10, v10, Lcom/android/internal/telephony/dataconnection/DcTracker;->mLteStateInfo:Lcom/lge/lgdata/LGDataPhoneConstants$LteStateInfo;

    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v11, v11, Lcom/android/internal/telephony/dataconnection/DcTracker;->mLteDetachCause:Lcom/lge/lgdata/LGDataPhoneConstants$LteStateInfo;

    invoke-interface/range {v2 .. v11}, Lcom/android/internal/telephony/CommandsInterface;->updateEmergencyInfo(Lcom/lge/lgdata/LGDataPhoneConstants$VolteAndEPDNSupport;Lcom/lge/lgdata/LGDataPhoneConstants$VolteAndEPDNSupport;Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;Lcom/lge/lgdata/LGDataPhoneConstants$EmcFailCause;Lcom/lge/lgdata/LGDataPhoneConstants$LteStateInfo;Lcom/lge/lgdata/LGDataPhoneConstants$LteStateInfo;)V

    goto/16 :goto_0

    .line 524
    :cond_7
    const-string v2, "lge.intent.action.LTE_NETWORK_SIB_INFO"

    invoke-virtual {v12, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_8

    .line 525
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, "Emer_Attach_Support"

    const/4 v4, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v3, v4}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v3

    invoke-static {v3}, Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;->fromInt(I)Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    move-result-object v3

    iput-object v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEmerAttachSupport:Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    .line 526
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, "EPDN_Barring"

    const/4 v4, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v3, v4}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v3

    invoke-static {v3}, Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;->fromInt(I)Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    move-result-object v3

    iput-object v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEPDNBarring:Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    .line 528
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, "Emer_Camped_CID"

    const/4 v4, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v3, v4}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v3

    invoke-static {v3}, Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;->fromInt(I)Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    move-result-object v3

    iput-object v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEmerCampedCID:Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    .line 529
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, "Emer_Camped_TAC"

    const/4 v4, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v3, v4}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v3

    invoke-static {v3}, Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;->fromInt(I)Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    move-result-object v3

    iput-object v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEmerCampedTAC:Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    .line 531
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[LG_DATA] mEmerAttachSupport = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v4, v4, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEmerAttachSupport:Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", mEPDNBarring = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v4, v4, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEPDNBarring:Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", mEmerCampedCID = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v4, v4, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEmerCampedCID:Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", mEmerCampedTAC = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v4, v4, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEmerCampedTAC:Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/dataconnection/DcTracker;->log(Ljava/lang/String;)V

    .line 533
    sget-object v2, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_KEEP_EMERGENCY_INFO_ON_PHONE_TYPE_CHANGED_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 534
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v2, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    iget-object v2, v2, Lcom/android/internal/telephony/PhoneBase;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v3, v3, Lcom/android/internal/telephony/dataconnection/DcTracker;->mVolteSupport:Lcom/lge/lgdata/LGDataPhoneConstants$VolteAndEPDNSupport;

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v4, v4, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEPDNSupport:Lcom/lge/lgdata/LGDataPhoneConstants$VolteAndEPDNSupport;

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v5, v5, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEmerAttachSupport:Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v6, v6, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEPDNBarring:Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v7, v7, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEmerCampedCID:Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v8, v8, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEmerCampedTAC:Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    move-object/from16 v0, p0

    iget-object v9, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v9, v9, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEmcFailCause:Lcom/lge/lgdata/LGDataPhoneConstants$EmcFailCause;

    move-object/from16 v0, p0

    iget-object v10, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v10, v10, Lcom/android/internal/telephony/dataconnection/DcTracker;->mLteStateInfo:Lcom/lge/lgdata/LGDataPhoneConstants$LteStateInfo;

    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v11, v11, Lcom/android/internal/telephony/dataconnection/DcTracker;->mLteDetachCause:Lcom/lge/lgdata/LGDataPhoneConstants$LteStateInfo;

    invoke-interface/range {v2 .. v11}, Lcom/android/internal/telephony/CommandsInterface;->updateEmergencyInfo(Lcom/lge/lgdata/LGDataPhoneConstants$VolteAndEPDNSupport;Lcom/lge/lgdata/LGDataPhoneConstants$VolteAndEPDNSupport;Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;Lcom/lge/lgdata/LGDataPhoneConstants$EmcFailCause;Lcom/lge/lgdata/LGDataPhoneConstants$LteStateInfo;Lcom/lge/lgdata/LGDataPhoneConstants$LteStateInfo;)V

    goto/16 :goto_0

    .line 538
    :cond_8
    const-string v2, "lge.intent.action.DATA_EMERGENCY_FAILED"

    invoke-virtual {v12, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_9

    .line 539
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, "EMC_FailCause"

    const/4 v4, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v3, v4}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v3

    invoke-static {v3}, Lcom/lge/lgdata/LGDataPhoneConstants$EmcFailCause;->fromInt(I)Lcom/lge/lgdata/LGDataPhoneConstants$EmcFailCause;

    move-result-object v3

    iput-object v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEmcFailCause:Lcom/lge/lgdata/LGDataPhoneConstants$EmcFailCause;

    .line 540
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[LG_DATA] mEmcFailCause = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v4, v4, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEmcFailCause:Lcom/lge/lgdata/LGDataPhoneConstants$EmcFailCause;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/dataconnection/DcTracker;->log(Ljava/lang/String;)V

    .line 542
    sget-object v2, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_KEEP_EMERGENCY_INFO_ON_PHONE_TYPE_CHANGED_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 543
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v2, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    iget-object v2, v2, Lcom/android/internal/telephony/PhoneBase;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v3, v3, Lcom/android/internal/telephony/dataconnection/DcTracker;->mVolteSupport:Lcom/lge/lgdata/LGDataPhoneConstants$VolteAndEPDNSupport;

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v4, v4, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEPDNSupport:Lcom/lge/lgdata/LGDataPhoneConstants$VolteAndEPDNSupport;

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v5, v5, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEmerAttachSupport:Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v6, v6, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEPDNBarring:Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v7, v7, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEmerCampedCID:Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v8, v8, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEmerCampedTAC:Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    move-object/from16 v0, p0

    iget-object v9, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v9, v9, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEmcFailCause:Lcom/lge/lgdata/LGDataPhoneConstants$EmcFailCause;

    move-object/from16 v0, p0

    iget-object v10, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v10, v10, Lcom/android/internal/telephony/dataconnection/DcTracker;->mLteStateInfo:Lcom/lge/lgdata/LGDataPhoneConstants$LteStateInfo;

    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v11, v11, Lcom/android/internal/telephony/dataconnection/DcTracker;->mLteDetachCause:Lcom/lge/lgdata/LGDataPhoneConstants$LteStateInfo;

    invoke-interface/range {v2 .. v11}, Lcom/android/internal/telephony/CommandsInterface;->updateEmergencyInfo(Lcom/lge/lgdata/LGDataPhoneConstants$VolteAndEPDNSupport;Lcom/lge/lgdata/LGDataPhoneConstants$VolteAndEPDNSupport;Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;Lcom/lge/lgdata/LGDataPhoneConstants$EmcFailCause;Lcom/lge/lgdata/LGDataPhoneConstants$LteStateInfo;Lcom/lge/lgdata/LGDataPhoneConstants$LteStateInfo;)V

    goto/16 :goto_0

    .line 547
    :cond_9
    const-string v2, "lge.intent.action.LTE_STATE_INFO"

    invoke-virtual {v12, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_b

    .line 548
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, "LteStateInfo"

    const/4 v4, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v3, v4}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v3

    invoke-static {v3}, Lcom/lge/lgdata/LGDataPhoneConstants$LteStateInfo;->fromInt(I)Lcom/lge/lgdata/LGDataPhoneConstants$LteStateInfo;

    move-result-object v3

    iput-object v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mLteStateInfo:Lcom/lge/lgdata/LGDataPhoneConstants$LteStateInfo;

    .line 549
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, "LteDetachCause"

    const/4 v4, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v3, v4}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v3

    invoke-static {v3}, Lcom/lge/lgdata/LGDataPhoneConstants$LteStateInfo;->fromInt(I)Lcom/lge/lgdata/LGDataPhoneConstants$LteStateInfo;

    move-result-object v3

    iput-object v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mLteDetachCause:Lcom/lge/lgdata/LGDataPhoneConstants$LteStateInfo;

    .line 550
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[LG_DATA] mLteStateInfo = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v4, v4, Lcom/android/internal/telephony/dataconnection/DcTracker;->mLteStateInfo:Lcom/lge/lgdata/LGDataPhoneConstants$LteStateInfo;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", mLteDetachCause = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v4, v4, Lcom/android/internal/telephony/dataconnection/DcTracker;->mLteDetachCause:Lcom/lge/lgdata/LGDataPhoneConstants$LteStateInfo;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/dataconnection/DcTracker;->log(Ljava/lang/String;)V

    .line 552
    sget-object v2, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_KEEP_EMERGENCY_INFO_ON_PHONE_TYPE_CHANGED_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v2

    if-eqz v2, :cond_a

    .line 553
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v2, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    iget-object v2, v2, Lcom/android/internal/telephony/PhoneBase;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v3, v3, Lcom/android/internal/telephony/dataconnection/DcTracker;->mVolteSupport:Lcom/lge/lgdata/LGDataPhoneConstants$VolteAndEPDNSupport;

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v4, v4, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEPDNSupport:Lcom/lge/lgdata/LGDataPhoneConstants$VolteAndEPDNSupport;

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v5, v5, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEmerAttachSupport:Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v6, v6, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEPDNBarring:Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    move-object/from16 v0, p0

    iget-object v7, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v7, v7, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEmerCampedCID:Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v8, v8, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEmerCampedTAC:Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;

    move-object/from16 v0, p0

    iget-object v9, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v9, v9, Lcom/android/internal/telephony/dataconnection/DcTracker;->mEmcFailCause:Lcom/lge/lgdata/LGDataPhoneConstants$EmcFailCause;

    move-object/from16 v0, p0

    iget-object v10, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v10, v10, Lcom/android/internal/telephony/dataconnection/DcTracker;->mLteStateInfo:Lcom/lge/lgdata/LGDataPhoneConstants$LteStateInfo;

    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v11, v11, Lcom/android/internal/telephony/dataconnection/DcTracker;->mLteDetachCause:Lcom/lge/lgdata/LGDataPhoneConstants$LteStateInfo;

    invoke-interface/range {v2 .. v11}, Lcom/android/internal/telephony/CommandsInterface;->updateEmergencyInfo(Lcom/lge/lgdata/LGDataPhoneConstants$VolteAndEPDNSupport;Lcom/lge/lgdata/LGDataPhoneConstants$VolteAndEPDNSupport;Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;Lcom/lge/lgdata/LGDataPhoneConstants$SIBInfoForEPDN;Lcom/lge/lgdata/LGDataPhoneConstants$EmcFailCause;Lcom/lge/lgdata/LGDataPhoneConstants$LteStateInfo;Lcom/lge/lgdata/LGDataPhoneConstants$LteStateInfo;)V

    .line 557
    :cond_a
    sget-object v2, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_REJECT_ODB_REATTACH_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 558
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    invoke-virtual {v2}, Lcom/android/internal/telephony/dataconnection/DcTracker;->reattachForcelyAfterODB()V

    goto/16 :goto_0

    .line 564
    :cond_b
    const-string v2, "android.intent.action.AIRPLANE_MODE"

    invoke-virtual {v12, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_c

    .line 565
    sget-object v2, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_REJECT_ODB_REATTACH_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 566
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-boolean v2, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->isODBreceivedCauseOfDefaultPDN:Z

    const/4 v3, 0x1

    if-ne v2, v3, :cond_1

    .line 567
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const/4 v3, 0x0

    iput-boolean v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->isODBreceivedCauseOfDefaultPDN:Z

    .line 568
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[LGE_DATA] release ODB reject, isODBreceivedCauseOfDefaultPDN = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-boolean v4, v4, Lcom/android/internal/telephony/dataconnection/DcTracker;->isODBreceivedCauseOfDefaultPDN:Z

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/dataconnection/DcTracker;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 575
    :cond_c
    const-string v2, "android.intent.action.ACTION_DELAY_MODE_CHANGE_FOR_IMS"

    invoke-virtual {v12, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_e

    .line 577
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, " !!!!!!!! ACTION_DELAY_MODE_CHANGE_FOR_IMS !!!!!!!!!"

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/dataconnection/DcTracker;->log(Ljava/lang/String;)V

    .line 579
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const/4 v3, 0x0

    iput-boolean v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->modeChangeAlarmState:Z

    .line 581
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v2, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mDelayModeChangeforIms:Landroid/app/PendingIntent;

    if-eqz v2, :cond_d

    .line 582
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v2, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v2}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v2

    const-string v3, "alarm"

    invoke-virtual {v2, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Landroid/app/AlarmManager;

    .line 583
    .restart local v13    # "am":Landroid/app/AlarmManager;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v2, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mDelayModeChangeforIms:Landroid/app/PendingIntent;

    invoke-virtual {v13, v2}, Landroid/app/AlarmManager;->cancel(Landroid/app/PendingIntent;)V

    .line 584
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const/4 v3, 0x0

    iput-object v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mDelayModeChangeforIms:Landroid/app/PendingIntent;

    .line 586
    .end local v13    # "am":Landroid/app/AlarmManager;
    :cond_d
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/dataconnection/DcTracker;->changePreferrredNetworkMode(Z)V

    goto/16 :goto_0

    .line 590
    :cond_e
    const-string v2, "com.lge.phone.action.REQUEST_EMERGENCY_ATTACH"

    invoke-virtual {v12, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_f

    .line 592
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, "[IMS_AFW] Get com.lge.phone.action.REQUEST_EMERGENCY_ATTACH"

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/dataconnection/DcTracker;->log(Ljava/lang/String;)V

    .line 594
    sget-object v2, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_SET_EST_CAUSE_FOR_EMERGENCY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 595
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v2, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    iget-object v2, v2, Lcom/android/internal/telephony/PhoneBase;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const v4, 0x42802

    invoke-virtual {v3, v4}, Lcom/android/internal/telephony/dataconnection/DcTracker;->obtainMessage(I)Landroid/os/Message;

    move-result-object v3

    invoke-interface {v2, v3}, Lcom/android/internal/telephony/CommandsInterface;->setRrcEstCauseForEmergency(Landroid/os/Message;)V

    goto/16 :goto_0

    .line 599
    :cond_f
    const-string v2, "com.kddi.android.cpa_CHANGED"

    invoke-virtual {v12, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_12

    .line 600
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, "cpa_enable"

    const/4 v4, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v3, v4}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v3

    iput-boolean v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->cpa_enable:Z

    .line 601
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, "cpa_dun"

    const/4 v4, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v3, v4}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v3

    iput-boolean v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->cpa_dun:Z

    .line 602
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-boolean v2, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->cpa_enable:Z

    if-eqz v2, :cond_10

    .line 604
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const/4 v3, 0x1

    iput-boolean v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->cpa_send_result:Z

    .line 605
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-boolean v2, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->cpa_dun:Z

    if-eqz v2, :cond_11

    .line 606
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, "cpa_apn"

    move-object/from16 v0, p2

    invoke-virtual {v0, v3}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->cpa_apn:Ljava/lang/String;

    .line 607
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, "cpa_user"

    move-object/from16 v0, p2

    invoke-virtual {v0, v3}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->cpa_user:Ljava/lang/String;

    .line 608
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, "cpa_password"

    move-object/from16 v0, p2

    invoke-virtual {v0, v3}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->cpa_password:Ljava/lang/String;

    .line 609
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, "cpa_authType"

    const/4 v4, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v3, v4}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v3

    iput v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->cpa_authType:I

    .line 611
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, "cpa_dns1"

    move-object/from16 v0, p2

    invoke-virtual {v0, v3}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->cpa_dns1:Ljava/lang/String;

    .line 612
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, "cpa_dns2"

    move-object/from16 v0, p2

    invoke-virtual {v0, v3}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->cpa_dns2:Ljava/lang/String;

    .line 614
    const-string v2, "ril.btdun.dns1"

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v3, v3, Lcom/android/internal/telephony/dataconnection/DcTracker;->cpa_dns1:Ljava/lang/String;

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 615
    const-string v2, "ril.btdun.dns2"

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v3, v3, Lcom/android/internal/telephony/dataconnection/DcTracker;->cpa_dns2:Ljava/lang/String;

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 617
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "ril.btdun.dns1"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v4, v4, Lcom/android/internal/telephony/dataconnection/DcTracker;->cpa_dns1:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " ril.btdun.dns2="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v4, v4, Lcom/android/internal/telephony/dataconnection/DcTracker;->cpa_dns2:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/android/internal/telephony/dataconnection/DcTracker;->log(Ljava/lang/String;)V

    .line 621
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, "cpa_PackageName"

    move-object/from16 v0, p2

    invoke-virtual {v0, v3}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->cpa_PackageName:Ljava/lang/String;

    .line 637
    :cond_10
    :goto_1
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    invoke-virtual {v2}, Lcom/android/internal/telephony/dataconnection/DcTracker;->CPAChanged()V

    goto/16 :goto_0

    .line 626
    :cond_11
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const/4 v3, 0x0

    iput-boolean v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->cpa_send_result:Z

    .line 627
    const-string v2, "ril.btdun.dns1"

    const/4 v3, 0x0

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 628
    const-string v2, "ril.btdun.dns2"

    const/4 v3, 0x0

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 629
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, ""

    iput-object v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->cpa_apn:Ljava/lang/String;

    .line 630
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, ""

    iput-object v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->cpa_user:Ljava/lang/String;

    .line 631
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, ""

    iput-object v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->cpa_password:Ljava/lang/String;

    .line 632
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const/4 v3, 0x0

    iput v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->cpa_authType:I

    .line 633
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-string v3, ""

    iput-object v3, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->cpa_PackageName:Ljava/lang/String;

    goto :goto_1

    .line 639
    :cond_12
    const-string v2, "cpa_onSetupConnectionCompleted"

    invoke-virtual {v12, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_13

    .line 640
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-boolean v2, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->cpa_enable:Z

    if-eqz v2, :cond_1

    .line 643
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    invoke-virtual {v2}, Lcom/android/internal/telephony/dataconnection/DcTracker;->obtainMessage()Landroid/os/Message;

    move-result-object v15

    .line 644
    .local v15, "msg":Landroid/os/Message;
    const/16 v2, 0x400

    iput v2, v15, Landroid/os/Message;->what:I

    .line 645
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    const-wide/16 v4, 0xbb8

    invoke-virtual {v2, v15, v4, v5}, Lcom/android/internal/telephony/dataconnection/DcTracker;->sendMessageDelayed(Landroid/os/Message;J)Z

    goto/16 :goto_0

    .line 648
    .end local v15    # "msg":Landroid/os/Message;
    :cond_13
    const-string v2, "com.kddi.android.cpa_test_btdun_on"

    invoke-virtual {v12, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_14

    .line 650
    new-instance v14, Landroid/content/Intent;

    const-string v2, "com.kddi.android.cpa_CHANGED"

    invoke-direct {v14, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 651
    .local v14, "intent_temp":Landroid/content/Intent;
    const-string v2, "cpa_enable"

    const/4 v3, 0x1

    invoke-virtual {v14, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 652
    const-string v2, "cpa_dun"

    const/4 v3, 0x1

    invoke-virtual {v14, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 653
    const-string v2, "cpa_apn"

    const-string v3, "bt-dun"

    invoke-virtual {v14, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 654
    const-string v2, "cpa_user"

    const-string v3, "song"

    invoke-virtual {v14, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 655
    const-string v2, "cpa_password"

    const-string v3, "babo"

    invoke-virtual {v14, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 656
    const-string v2, "cpa_authType"

    const/4 v3, 0x1

    invoke-virtual {v14, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .line 657
    const-string v2, "cpa_dns1"

    const-string v3, "1.1.1.1"

    invoke-virtual {v14, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 658
    const-string v2, "cpa_dns2"

    const-string v3, "2.2.2.2"

    invoke-virtual {v14, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 659
    const-string v2, "cpa_PackageName"

    const-string v3, "com.android.phone"

    invoke-virtual {v14, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 660
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v2, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v2}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2, v14}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto/16 :goto_0

    .line 662
    .end local v14    # "intent_temp":Landroid/content/Intent;
    :cond_14
    const-string v2, "com.kddi.android.cpa_test_btdun_off"

    invoke-virtual {v12, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 663
    new-instance v14, Landroid/content/Intent;

    const-string v2, "com.kddi.android.cpa_CHANGED"

    invoke-direct {v14, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 664
    .restart local v14    # "intent_temp":Landroid/content/Intent;
    const-string v2, "cpa_enable"

    const/4 v3, 0x0

    invoke-virtual {v14, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 665
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/dataconnection/DcTracker$1;->this$0:Lcom/android/internal/telephony/dataconnection/DcTracker;

    iget-object v2, v2, Lcom/android/internal/telephony/dataconnection/DcTracker;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v2}, Lcom/android/internal/telephony/PhoneBase;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2, v14}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto/16 :goto_0
.end method
