.class Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;
.super Landroid/content/BroadcastReceiver;
.source "PayPopup_Korea.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/lgdata/PayPopup_Korea;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;


# direct methods
.method constructor <init>(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)V
    .locals 0

    .prologue
    iput-object p1, p0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public declared-synchronized onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 18
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    monitor-enter p0

    :try_start_0
    invoke-virtual/range {p2 .. p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v2

    .local v2, "action":Ljava/lang/String;
    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "intent received :"

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v13, "android.net.conn.STARTING_IN_DATA_SETTING_DISABLE"

    invoke-virtual {v2, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_1

    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    const-string v14, "ACTION_STARTING_IN_DATA_SETTING_DISABLE"

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    sget-object v14, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->showToast:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    const/4 v15, 0x3

    invoke-virtual {v13, v14, v15}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->showToastAndDialog(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;I)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_5
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :cond_0
    :goto_0
    monitor-exit p0

    return-void

    :cond_1
    :try_start_2
    const-string v13, "android.net.conn.STARTING_IN_ROAM_SETTING_DISABLE"

    invoke-virtual {v2, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_2

    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    const-string v14, "ACTION_STARTING_IN_ROAM_SETTING_DISABLE"

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :try_start_3
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    sget-object v14, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->showToast:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    const/4 v15, 0x5

    invoke-virtual {v13, v14, v15}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->showToastAndDialog(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;I)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_0

    :catch_0
    move-exception v13

    goto :goto_0

    :cond_2
    :try_start_4
    const-string v13, "android.net.conn.STARTING_IN_DATA_SETTING_DISABLE_3GONLY"

    invoke-virtual {v2, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_3

    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    const-string v14, "ACTION_STARTING_IN_DATA_SETTING_DISABLE_3GONLY"

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    :try_start_5
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    sget-object v14, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->showToast:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    const/4 v15, 0x2

    invoke-virtual {v13, v14, v15}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->showToastAndDialog(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;I)V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_1
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto :goto_0

    :catch_1
    move-exception v13

    goto :goto_0

    :cond_3
    :try_start_6
    const-string v13, "android.net.conn.DATA_DATA_BLOCK_IN_MMS"

    invoke-virtual {v2, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_4

    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    const-string v14, "ACTION_DATA_BLOCK_IN_MMS "

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    :try_start_7
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    sget-object v14, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->showToast:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    const/4 v15, 0x6

    invoke-virtual {v13, v14, v15}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->showToastAndDialog(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;I)V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_2
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    goto :goto_0

    :catch_2
    move-exception v13

    goto :goto_0

    :cond_4
    :try_start_8
    const-string v13, "lge.intent.action.LGE_WIFI_3G_TRANSITION"

    invoke-virtual {v2, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_6

    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    const-string v14, "lge.intent.action.LGE_WIFI_3G_TRANSITION"

    invoke-static {v13, v14}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # getter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;
    invoke-static {v13}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$000(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Lcom/android/internal/telephony/Phone;

    move-result-object v13

    invoke-interface {v13}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v13

    invoke-virtual {v13}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v13

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "mobile_data"

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # getter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;
    invoke-static {v15}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$000(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Lcom/android/internal/telephony/Phone;

    move-result-object v15

    invoke-interface {v15}, Lcom/android/internal/telephony/Phone;->getPhoneId()I

    move-result v15

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    const/4 v15, 0x1

    invoke-static {v13, v14, v15}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v13

    const/4 v14, 0x1

    if-ne v13, v14, :cond_5

    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    const-string v14, "[LGE_DATA] WiFi Off / data enable"

    invoke-static {v13, v14}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    :try_start_9
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    sget-object v14, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->showToast:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    const/16 v15, 0x9

    invoke-virtual {v13, v14, v15}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->showToastAndDialog(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;I)V
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_4
    .catchall {:try_start_9 .. :try_end_9} :catchall_0

    :cond_5
    :goto_1
    :try_start_a
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # getter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;
    invoke-static {v13}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$000(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Lcom/android/internal/telephony/Phone;

    move-result-object v13

    invoke-interface {v13}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v13

    invoke-virtual {v13}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v13

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "mobile_data"

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # getter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;
    invoke-static {v15}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$000(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Lcom/android/internal/telephony/Phone;

    move-result-object v15

    invoke-interface {v15}, Lcom/android/internal/telephony/Phone;->getPhoneId()I

    move-result v15

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    const/4 v15, 0x1

    invoke-static {v13, v14, v15}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v13

    if-nez v13, :cond_0

    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    const-string v14, "[LGE_DATA] WiFi Off / data disable"

    invoke-static {v13, v14}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_0

    :try_start_b
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    sget-object v14, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;->showToast:Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;

    const/16 v15, 0xa

    invoke-virtual {v13, v14, v15}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->showToastAndDialog(Lcom/android/internal/telephony/lgdata/PayPopup_Korea$PayPopupFunction;I)V
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_3
    .catchall {:try_start_b .. :try_end_b} :catchall_0

    goto/16 :goto_0

    :catch_3
    move-exception v13

    goto/16 :goto_0

    :cond_6
    :try_start_c
    const-string v13, "com.lge.intent.action.LGE_CAMPED_MCC_CHANGE"

    invoke-virtual {v2, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_14

    const-string v9, "000"

    .local v9, "new_mcc":Ljava/lang/String;
    const-string v10, "000"

    .local v10, "old_mcc":Ljava/lang/String;
    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    const-string v14, "[LGE_DATA_ROAMING] Got LGTelephonyIntents.ACTION_CAMPED_MCC_CHANGE "

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v13, "newmcc"

    move-object/from16 v0, p2

    invoke-virtual {v0, v13}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    const-string v13, "oldmcc"

    move-object/from16 v0, p2

    invoke-virtual {v0, v13}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    const-string v13, "FakeMccChange"

    const/4 v14, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v13, v14}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v5

    .local v5, "fake_change":Z
    if-nez v10, :cond_7

    const-string v10, "000"

    :cond_7
    if-nez v9, :cond_8

    const-string v9, "000"

    :cond_8
    if-eqz v5, :cond_9

    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    const-string v14, "[LGE_DATA_ROAMING] Got TelephonyIntents.ACTION_CAMPED_FAKE_MCC_CHANGE "

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_0

    goto/16 :goto_0

    .end local v2    # "action":Ljava/lang/String;
    .end local v5    # "fake_change":Z
    .end local v9    # "new_mcc":Ljava/lang/String;
    .end local v10    # "old_mcc":Ljava/lang/String;
    :catchall_0
    move-exception v13

    monitor-exit p0

    throw v13

    .restart local v2    # "action":Ljava/lang/String;
    .restart local v5    # "fake_change":Z
    .restart local v9    # "new_mcc":Ljava/lang/String;
    .restart local v10    # "old_mcc":Ljava/lang/String;
    :cond_9
    :try_start_d
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    iget-object v13, v13, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->featureset:Ljava/lang/String;

    const-string v14, "SKTBASE"

    invoke-static {v13, v14}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v13

    if-eqz v13, :cond_a

    sget-object v13, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_PAYPOPUP_ROAMING_SKT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v13}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v13

    if-nez v13, :cond_a

    const-string v13, "450"

    invoke-virtual {v10, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_a

    const-string v13, "450"

    invoke-virtual {v9, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-nez v13, :cond_a

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # getter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;
    invoke-static {v13}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$000(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Lcom/android/internal/telephony/Phone;

    move-result-object v13

    invoke-interface {v13}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v13

    invoke-virtual {v13}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v13

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "mobile_data"

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # getter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;
    invoke-static {v15}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$000(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Lcom/android/internal/telephony/Phone;

    move-result-object v15

    invoke-interface {v15}, Lcom/android/internal/telephony/Phone;->getPhoneId()I

    move-result v15

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    const/4 v15, 0x0

    invoke-static {v13, v14, v15}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v13

    if-nez v13, :cond_a

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # getter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;
    invoke-static {v13}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$000(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Lcom/android/internal/telephony/Phone;

    move-result-object v13

    invoke-interface {v13}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v13

    invoke-virtual {v13}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v13

    const-string v14, "data_network_user_data_disable_setting"

    const/4 v15, 0x1

    invoke-static {v13, v14, v15}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    const-string v14, "[LGE_DATA] <onDataConnectionAttached()> DATA_NETWORK_USER_DATA_DISABLE_SETTING : 1"

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_a
    const-string v13, "000"

    invoke-virtual {v9, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_b

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # getter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;
    invoke-static {v13}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$000(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Lcom/android/internal/telephony/Phone;

    move-result-object v13

    invoke-interface {v13}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v13

    invoke-virtual {v13}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v13

    const-string v14, "intent_old_mcc"

    invoke-static {v13, v14, v10}, Landroid/provider/Settings$Secure;->putString(Landroid/content/ContentResolver;Ljava/lang/String;Ljava/lang/String;)Z

    :cond_b
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    iget-object v13, v13, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->featureset:Ljava/lang/String;

    const-string v14, "KTBASE"

    invoke-static {v13, v14}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v13

    if-nez v13, :cond_c

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    iget-object v13, v13, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->featureset:Ljava/lang/String;

    const-string v14, "SKTBASE"

    invoke-static {v13, v14}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v13

    if-eqz v13, :cond_d

    sget-object v13, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_PAYPOPUP_ROAMING_SKT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v13}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v13

    if-nez v13, :cond_d

    :cond_c
    const-string v9, "000"

    :cond_d
    const-string v13, "000"

    invoke-virtual {v9, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-nez v13, :cond_13

    const-string v13, "000"

    invoke-virtual {v10, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_e

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # getter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;
    invoke-static {v13}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$000(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Lcom/android/internal/telephony/Phone;

    move-result-object v13

    invoke-interface {v13}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v13

    invoke-virtual {v13}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v13

    const-string v14, "intent_old_mcc"

    invoke-static {v13, v14}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    :cond_e
    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "[LGE_DATA_ROAMING] old_mcc:  "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, ", new_mcc:"

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz v10, :cond_f

    if-nez v9, :cond_10

    :cond_f
    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "old_mcc:  "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, ", new_mcc:"

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :cond_10
    const-string v13, "450"

    invoke-virtual {v10, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_11

    const-string v13, "450"

    invoke-virtual {v9, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-nez v13, :cond_11

    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    const-string v14, "[LGE_DATA_ROAMING] MCC Change Roaming popup OK"

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v13, "net.Is_phone_booted"

    const-string v14, "true"

    invoke-static {v13, v14}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # setter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->global_new_mcc:Ljava/lang/String;
    invoke-static {v13, v9}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$102(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;Ljava/lang/String;)Ljava/lang/String;

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # setter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->global_old_mcc:Ljava/lang/String;
    invoke-static {v13, v10}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$202(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;Ljava/lang/String;)Ljava/lang/String;

    goto/16 :goto_0

    :cond_11
    const-string v13, "450"

    invoke-virtual {v10, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-nez v13, :cond_0

    const-string v13, "450"

    invoke-virtual {v9, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_0

    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    const-string v14, "[LGE_DATA_ROAMING] Domestic popup OK"

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    iget-object v13, v13, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->featureset:Ljava/lang/String;

    const-string v14, "LGTBASE"

    invoke-static {v13, v14}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v13

    if-eqz v13, :cond_12

    const-string v13, "net.Is_phone_booted"

    const-string v14, "true"

    invoke-static {v13, v14}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    :cond_12
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # setter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->global_new_mcc:Ljava/lang/String;
    invoke-static {v13, v9}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$102(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;Ljava/lang/String;)Ljava/lang/String;

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # setter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->global_old_mcc:Ljava/lang/String;
    invoke-static {v13, v10}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$202(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;Ljava/lang/String;)Ljava/lang/String;

    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "[LGE_DATA_ROAMING] roam_to_domestic_popup_need="

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # getter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->roam_to_domestic_popup_need:Z
    invoke-static {v15}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$300(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Z

    move-result v15

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # getter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->roam_to_domestic_popup_need:Z
    invoke-static {v13}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$300(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Z

    move-result v13

    if-eqz v13, :cond_0

    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    const-string v14, "roam_to_domesic : mcc_change"

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    const-string v14, "roam_to_domesic"

    const-string v15, "default"

    const/16 v16, 0x0

    invoke-virtual/range {v13 .. v16}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->startPayPopup(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    const/4 v14, 0x0

    # setter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->roam_to_domestic_popup_need:Z
    invoke-static {v13, v14}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$302(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;Z)Z

    goto/16 :goto_0

    :cond_13
    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    const-string v14, "[LGE_DATA_ROAMING] incorrect intet!!"

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .end local v5    # "fake_change":Z
    .end local v9    # "new_mcc":Ljava/lang/String;
    .end local v10    # "old_mcc":Ljava/lang/String;
    :cond_14
    const-string v13, "android.intent.action.AIRPLANE_MODE"

    invoke-virtual {v2, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_16

    const-string v13, "state"

    const/4 v14, 0x0

    move-object/from16 v0, p2

    invoke-virtual {v0, v13, v14}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v4

    .local v4, "enabled":Z
    if-eqz v4, :cond_15

    const/4 v13, 0x1

    :goto_2
    sput v13, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->airplane_mode:I

    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "[LGE_DATA_ROAMING] Airplane_mode popup airplane: "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    sget v15, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->airplane_mode:I

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    :cond_15
    const/4 v13, 0x0

    goto :goto_2

    .end local v4    # "enabled":Z
    :cond_16
    const-string v13, "com.lge.DataEnabledSettingBootableSKT"

    invoke-virtual {v2, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_17

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    const/16 v15, 0x190

    invoke-virtual {v14, v15}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->obtainMessage(I)Landroid/os/Message;

    move-result-object v14

    const-wide/16 v16, 0x1f4

    move-wide/from16 v0, v16

    invoke-virtual {v13, v14, v0, v1}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->sendMessageDelayed(Landroid/os/Message;J)Z

    goto/16 :goto_0

    :cond_17
    const-string v13, "com.lge.DataNetworkModePayPopupKT"

    invoke-virtual {v2, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_18

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    const/16 v15, 0x191

    invoke-virtual {v14, v15}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->obtainMessage(I)Landroid/os/Message;

    move-result-object v14

    const-wide/16 v16, 0x1f4

    move-wide/from16 v0, v16

    invoke-virtual {v13, v14, v0, v1}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->sendMessageDelayed(Landroid/os/Message;J)Z

    goto/16 :goto_0

    :cond_18
    const-string v13, "com.lge.DataNetworkModePayPopupLGT"

    invoke-virtual {v2, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_19

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    const/16 v15, 0x192

    invoke-virtual {v14, v15}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->obtainMessage(I)Landroid/os/Message;

    move-result-object v14

    const-wide/16 v16, 0x1f4

    move-wide/from16 v0, v16

    invoke-virtual {v13, v14, v0, v1}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->sendMessageDelayed(Landroid/os/Message;J)Z

    goto/16 :goto_0

    :cond_19
    const-string v13, "android.net.conn.CONNECTIVITY_CHANGE_IMMEDIATE"

    invoke-virtual {v2, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-nez v13, :cond_1a

    const-string v13, "android.net.conn.INET_CONDITION_ACTION"

    invoke-virtual {v2, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_23

    :cond_1a
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    iget-object v13, v13, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->featureset:Ljava/lang/String;

    const-string v14, "KTBASE"

    invoke-virtual {v13, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_23

    const-string v13, "networkInfo"

    move-object/from16 v0, p2

    invoke-virtual {v0, v13}, Landroid/content/Intent;->hasExtra(Ljava/lang/String;)Z

    move-result v13

    if-eqz v13, :cond_0

    const-string v13, "networkInfo"

    move-object/from16 v0, p2

    invoke-virtual {v0, v13}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v13

    check-cast v13, Landroid/net/NetworkInfo;

    move-object v0, v13

    check-cast v0, Landroid/net/NetworkInfo;

    move-object v6, v0

    .local v6, "info":Landroid/net/NetworkInfo;
    if-eqz v6, :cond_0

    invoke-virtual {v6}, Landroid/net/NetworkInfo;->getType()I

    move-result v13

    packed-switch v13, :pswitch_data_0

    goto/16 :goto_0

    :pswitch_0
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    invoke-virtual {v6}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v14

    # setter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mMobileEnabled:Z
    invoke-static {v13, v14}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$402(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;Z)Z

    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "TYPE_MOBILE is Connected = "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # getter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mMobileEnabled:Z
    invoke-static {v15}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$400(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Z

    move-result v15

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v3, 0x0

    .local v3, "currentSubType":I
    const/4 v7, 0x0

    .local v7, "isWifiConnected":Z
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # getter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mConnMgr:Landroid/net/ConnectivityManager;
    invoke-static {v13}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$500(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Landroid/net/ConnectivityManager;

    move-result-object v13

    const/4 v14, 0x0

    invoke-virtual {v13, v14}, Landroid/net/ConnectivityManager;->getNetworkInfo(I)Landroid/net/NetworkInfo;

    move-result-object v8

    .local v8, "mobileNetworkInfo":Landroid/net/NetworkInfo;
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # getter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mConnMgr:Landroid/net/ConnectivityManager;
    invoke-static {v13}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$500(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Landroid/net/ConnectivityManager;

    move-result-object v13

    const/4 v14, 0x1

    invoke-virtual {v13, v14}, Landroid/net/ConnectivityManager;->getNetworkInfo(I)Landroid/net/NetworkInfo;

    move-result-object v12

    .local v12, "wifiNetworkInfo":Landroid/net/NetworkInfo;
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # getter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mConnMgr:Landroid/net/ConnectivityManager;
    invoke-static {v13}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$500(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Landroid/net/ConnectivityManager;

    move-result-object v13

    if-eqz v13, :cond_1c

    if-eqz v8, :cond_1b

    invoke-virtual {v8}, Landroid/net/NetworkInfo;->getSubtype()I

    move-result v3

    :cond_1b
    if-eqz v12, :cond_1c

    invoke-virtual {v12}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v7

    :cond_1c
    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "[LGE_DATA] mStatus : "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    iget-boolean v15, v15, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mStatus:Z

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, " subtype : "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, " wifi state : "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v7}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # getter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mMobileEnabled:Z
    invoke-static {v13}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$400(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Z

    move-result v13

    const/4 v14, 0x1

    if-ne v13, v14, :cond_1e

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    iget-object v13, v13, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->featureset:Ljava/lang/String;

    const-string v14, "KTBASE"

    invoke-virtual {v13, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_1e

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    iget-boolean v13, v13, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mStatus:Z

    const/4 v14, 0x1

    if-eq v13, v14, :cond_1e

    const/4 v13, 0x1

    if-eq v3, v13, :cond_1d

    const/4 v13, 0x2

    if-ne v3, v13, :cond_1f

    :cond_1d
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # getter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;
    invoke-static {v13}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$000(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Lcom/android/internal/telephony/Phone;

    move-result-object v13

    invoke-interface {v13}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v13

    sget v14, Lcom/lge/internal/R$string;->gprs_connection_for_kt:I

    invoke-virtual {v13, v14}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v13

    invoke-interface {v13}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v11

    .local v11, "str_value":Ljava/lang/String;
    :goto_3
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # getter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mWifiServiceExt:Lcom/lge/wifi/extension/IWifiServiceExtension;
    invoke-static {v13}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$600(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Lcom/lge/wifi/extension/IWifiServiceExtension;

    move-result-object v13

    invoke-interface {v13}, Lcom/lge/wifi/extension/IWifiServiceExtension;->isShowKTPayPopup()Z

    move-result v13

    const/4 v14, 0x1

    if-ne v13, v14, :cond_1e

    if-nez v7, :cond_1e

    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    const-string v14, "[LGE_DATA] mWifiServiceExt.getShowKTPayPopup() = "

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # getter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;
    invoke-static {v13}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$000(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Lcom/android/internal/telephony/Phone;

    move-result-object v13

    invoke-interface {v13}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v13

    const/4 v14, 0x0

    invoke-static {v13, v11, v14}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v13

    invoke-virtual {v13}, Landroid/widget/Toast;->show()V

    .end local v11    # "str_value":Ljava/lang/String;
    :cond_1e
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # getter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mMobileEnabled:Z
    invoke-static {v14}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$400(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Z

    move-result v14

    iput-boolean v14, v13, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mStatus:Z

    goto/16 :goto_0

    :cond_1f
    const/16 v13, 0xd

    if-ne v3, v13, :cond_20

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # getter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;
    invoke-static {v13}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$000(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Lcom/android/internal/telephony/Phone;

    move-result-object v13

    invoke-interface {v13}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v13

    sget v14, Lcom/lge/internal/R$string;->lte_connection_for_kt:I

    invoke-virtual {v13, v14}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v13

    invoke-interface {v13}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v11

    .restart local v11    # "str_value":Ljava/lang/String;
    goto :goto_3

    .end local v11    # "str_value":Ljava/lang/String;
    :cond_20
    const/16 v13, 0xf

    if-eq v3, v13, :cond_21

    const/16 v13, 0xa

    if-eq v3, v13, :cond_21

    const/16 v13, 0x9

    if-eq v3, v13, :cond_21

    const/16 v13, 0x8

    if-eq v3, v13, :cond_21

    const/4 v13, 0x3

    if-ne v3, v13, :cond_22

    :cond_21
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # getter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mPhone:Lcom/android/internal/telephony/Phone;
    invoke-static {v13}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$000(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Lcom/android/internal/telephony/Phone;

    move-result-object v13

    invoke-interface {v13}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v13

    sget v14, Lcom/lge/internal/R$string;->wcdma_connection_for_kt:I

    invoke-virtual {v13, v14}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v13

    invoke-interface {v13}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v11

    .restart local v11    # "str_value":Ljava/lang/String;
    goto :goto_3

    .end local v11    # "str_value":Ljava/lang/String;
    :cond_22
    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    move-object/from16 v0, p0

    iget-object v14, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    const/16 v15, 0x258

    invoke-virtual {v14, v15}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->obtainMessage(I)Landroid/os/Message;

    move-result-object v14

    const-wide/16 v16, 0x1f4

    move-wide/from16 v0, v16

    invoke-virtual {v13, v14, v0, v1}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->sendMessageDelayed(Landroid/os/Message;J)Z

    goto/16 :goto_0

    .end local v3    # "currentSubType":I
    .end local v6    # "info":Landroid/net/NetworkInfo;
    .end local v7    # "isWifiConnected":Z
    .end local v8    # "mobileNetworkInfo":Landroid/net/NetworkInfo;
    .end local v12    # "wifiNetworkInfo":Landroid/net/NetworkInfo;
    :cond_23
    const-string v13, "com.lge.intent.action.OTA_USIM_REFRESH_TO_RESET"

    invoke-virtual {v2, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_24

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    iget-object v13, v13, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->featureset:Ljava/lang/String;

    const-string v14, "KTBASE"

    invoke-static {v13, v14}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v13

    if-eqz v13, :cond_0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    const/4 v14, 0x1

    # setter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->intent_reset:Z
    invoke-static {v13, v14}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$702(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;Z)Z

    goto/16 :goto_0

    :cond_24
    const-string v13, "android.intent.action.BOOT_COMPLETED"

    invoke-virtual {v2, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    const-string v14, "net.Is_phone_booted"

    const-string v15, "true"

    invoke-static {v14, v15}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    const-string v15, "true"

    invoke-virtual {v14, v15}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v14

    # setter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mbooting_phone:Z
    invoke-static {v13, v14}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$802(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;Z)Z

    const-string v13, "[LGE_DATA][PayPopUp_ko] "

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "[LGE_DATA] ACTION_BOOT_COMPLETED mbooting_phone = "

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    move-object/from16 v0, p0

    iget-object v15, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # getter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mbooting_phone:Z
    invoke-static {v15}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$800(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Z

    move-result v15

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-static {v13, v14}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # getter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mbooting_phone:Z
    invoke-static {v13}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$800(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Z

    move-result v13

    const/4 v14, 0x1

    if-ne v13, v14, :cond_0

    move-object/from16 v0, p0

    iget-object v13, v0, Lcom/android/internal/telephony/lgdata/PayPopup_Korea$1;->this$0:Lcom/android/internal/telephony/lgdata/PayPopup_Korea;

    # getter for: Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->mDct:Lcom/android/internal/telephony/dataconnection/DcTracker;
    invoke-static {v13}, Lcom/android/internal/telephony/lgdata/PayPopup_Korea;->access$900(Lcom/android/internal/telephony/lgdata/PayPopup_Korea;)Lcom/android/internal/telephony/dataconnection/DcTracker;

    move-result-object v13

    const-string v14, "dataAttached"

    invoke-virtual {v13, v14}, Lcom/android/internal/telephony/dataconnection/DcTracker;->lgdata_setupDataOnConnectableApns(Ljava/lang/String;)V
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_0

    goto/16 :goto_0

    :catch_4
    move-exception v13

    goto/16 :goto_1

    :catch_5
    move-exception v13

    goto/16 :goto_0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
