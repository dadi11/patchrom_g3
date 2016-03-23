.class Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;
.super Landroid/content/BroadcastReceiver;
.source "LgeFDHandlerInterfaceImpl.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;


# direct methods
.method constructor <init>(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;)V
    .locals 0

    .prologue
    .line 189
    iput-object p1, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public declared-synchronized onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 13
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    const/4 v6, 0x1

    const/4 v9, 0x0

    .line 192
    monitor-enter p0

    :try_start_0
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    .line 194
    .local v0, "action":Ljava/lang/String;
    iget-object v10, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "intent received :"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logv(Ljava/lang/String;)V

    .line 196
    const-string v10, "android.intent.action.SCREEN_ON"

    invoke-virtual {v0, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_2

    .line 197
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    const/4 v10, 0x1

    invoke-virtual {v9, v10}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->updateScreenState(Z)V

    .line 199
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->operatorCode:Ljava/lang/String;

    const-string v10, "TMO"

    invoke-virtual {v9, v10}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v9

    if-nez v9, :cond_0

    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->operatorCode:Ljava/lang/String;

    const-string v10, "DTAG"

    invoke-virtual {v9, v10}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v9

    if-eqz v9, :cond_1

    :cond_0
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->countryCode:Ljava/lang/String;

    const-string v10, "US"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-nez v9, :cond_1

    .line 201
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    const/4 v10, 0x0

    iput-boolean v10, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->mIsPreventInTethering:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 335
    :cond_1
    :goto_0
    monitor-exit p0

    return-void

    .line 203
    :cond_2
    :try_start_1
    const-string v10, "android.intent.action.SCREEN_OFF"

    invoke-virtual {v0, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_4

    .line 204
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    const/4 v10, 0x0

    invoke-virtual {v9, v10}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->updateScreenState(Z)V

    .line 206
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->operatorCode:Ljava/lang/String;

    const-string v10, "TMO"

    invoke-virtual {v9, v10}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v9

    if-nez v9, :cond_3

    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->operatorCode:Ljava/lang/String;

    const-string v10, "DTAG"

    invoke-virtual {v9, v10}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v9

    if-eqz v9, :cond_1

    :cond_3
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->countryCode:Ljava/lang/String;

    const-string v10, "US"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-nez v9, :cond_1

    .line 208
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    const/4 v10, 0x1

    iput-boolean v10, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->mIsPreventInTethering:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 192
    .end local v0    # "action":Ljava/lang/String;
    :catchall_0
    move-exception v9

    monitor-exit p0

    throw v9

    .line 210
    .restart local v0    # "action":Ljava/lang/String;
    :cond_4
    :try_start_2
    const-string v10, "com.android.internal.telephony.ACTION_CHECK_NETSTAT"

    invoke-virtual {v0, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_6

    .line 211
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->sWakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v9}, Landroid/os/PowerManager$WakeLock;->isHeld()Z

    move-result v9

    if-eqz v9, :cond_5

    .line 213
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->sWakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v9}, Landroid/os/PowerManager$WakeLock;->release()V

    .line 217
    :cond_5
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->sWakeLock:Landroid/os/PowerManager$WakeLock;

    const-wide/16 v10, 0x7d0

    invoke-virtual {v9, v10, v11}, Landroid/os/PowerManager$WakeLock;->acquire(J)V

    .line 219
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    const v10, 0x18c4b

    invoke-virtual {v9, v10}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->sendMessage(I)V

    goto :goto_0

    .line 220
    :cond_6
    const-string v10, "android.intent.action.SERVICE_STATE"

    invoke-virtual {v0, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_b

    .line 223
    invoke-virtual {p2}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v3

    .line 225
    .local v3, "extras":Landroid/os/Bundle;
    if-nez v3, :cond_7

    .line 226
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->sWakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v9}, Landroid/os/PowerManager$WakeLock;->isHeld()Z

    move-result v9

    if-eqz v9, :cond_1

    .line 227
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->sWakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v9}, Landroid/os/PowerManager$WakeLock;->release()V

    goto/16 :goto_0

    .line 232
    :cond_7
    invoke-static {v3}, Landroid/telephony/ServiceState;->newFromBundle(Landroid/os/Bundle;)Landroid/telephony/ServiceState;

    move-result-object v7

    .line 236
    .local v7, "ss":Landroid/telephony/ServiceState;
    if-eqz v7, :cond_8

    .line 237
    invoke-virtual {v7}, Landroid/telephony/ServiceState;->getRadioTechnology()I

    move-result v9

    # setter for: Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->currentRadioTech:I
    invoke-static {v9}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->access$002(I)I

    .line 238
    # getter for: Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->oldRadioTech:I
    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->access$100()I

    move-result v9

    # getter for: Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->currentRadioTech:I
    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->access$000()I

    move-result v10

    if-ne v9, v10, :cond_a

    .line 239
    const/4 v9, 0x0

    # setter for: Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->isChangedRt:Z
    invoke-static {v9}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->access$202(Z)Z

    .line 245
    :goto_1
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "Service State is changed : "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logi(Ljava/lang/String;)V

    .line 246
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "radioTech changed!! currenRT = "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    # getter for: Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->currentRadioTech:I
    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->access$000()I

    move-result v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, " isChange?? "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    # getter for: Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->isChangedRt:Z
    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->access$200()Z

    move-result v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logi(Ljava/lang/String;)V

    .line 249
    :cond_8
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->sWakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v9}, Landroid/os/PowerManager$WakeLock;->isHeld()Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    move-result v9

    if-eqz v9, :cond_9

    .line 253
    :try_start_3
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->sWakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v9}, Landroid/os/PowerManager$WakeLock;->release()V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 260
    :cond_9
    :goto_2
    :try_start_4
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->sWakeLock:Landroid/os/PowerManager$WakeLock;

    const-wide/16 v10, 0x7d0

    invoke-virtual {v9, v10, v11}, Landroid/os/PowerManager$WakeLock;->acquire(J)V

    .line 262
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    const v10, 0x18c4c

    invoke-virtual {v9, v10}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->sendMessage(I)V

    goto/16 :goto_0

    .line 241
    :cond_a
    # getter for: Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->currentRadioTech:I
    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->access$000()I

    move-result v9

    # setter for: Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->oldRadioTech:I
    invoke-static {v9}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->access$102(I)I

    .line 242
    const/4 v9, 0x1

    # setter for: Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->isChangedRt:Z
    invoke-static {v9}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->access$202(Z)Z

    goto :goto_1

    .line 264
    .end local v3    # "extras":Landroid/os/Bundle;
    .end local v7    # "ss":Landroid/telephony/ServiceState;
    :cond_b
    const-string v10, "com.lge.ACTION_FD_TRIGGER_TIME_VAL_CHANGED"

    invoke-virtual {v0, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_c

    .line 265
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    const-string v10, "intent received : ACTION_FD_TRIGGER_TIME_VAL_CHANGED"

    invoke-virtual {v9, v10}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logv(Ljava/lang/String;)V

    .line 266
    const-string v9, "value"

    const/4 v10, 0x0

    invoke-virtual {p2, v9, v10}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v5

    .line 268
    .local v5, "hasChanged":Z
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iput-boolean v5, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIsFDValueChanged:Z

    goto/16 :goto_0

    .line 273
    .end local v5    # "hasChanged":Z
    :cond_c
    const-string v10, "android.net.conn.TETHER_STATE_CHANGED"

    invoke-virtual {v0, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_e

    .line 274
    const-string v10, "activeArray"

    invoke-virtual {p2, v10}, Landroid/content/Intent;->getStringArrayListExtra(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v1

    .line 276
    .local v1, "active":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    if-eqz v1, :cond_1

    .line 277
    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v10

    if-lez v10, :cond_d

    .line 279
    .local v6, "isTetheringOn":Z
    :goto_3
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-boolean v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIsTetheringOn:Z

    if-eq v9, v6, :cond_1

    .line 280
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iput-boolean v6, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIsTetheringOn:Z

    .line 281
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "New tethering state is "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget-object v11, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-boolean v11, v11, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mIsTetheringOn:Z

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logv(Ljava/lang/String;)V

    goto/16 :goto_0

    .end local v6    # "isTetheringOn":Z
    :cond_d
    move v6, v9

    .line 277
    goto :goto_3

    .line 284
    .end local v1    # "active":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    :cond_e
    const-string v9, "com.fd.go"

    invoke-virtual {v0, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_f

    .line 285
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    const-string v10, "[sehyun] Go Dormant"

    invoke-virtual {v9, v10}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logv(Ljava/lang/String;)V

    .line 286
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    # getter for: Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mDchFachState:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;
    invoke-static {v9}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->access$300(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;)Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;

    move-result-object v9

    # invokes: Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->triggerGoDormant()Z
    invoke-static {v9}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;->access$400(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$DchFachState;)Z

    goto/16 :goto_0

    .line 291
    :cond_f
    const-string v9, "android.intent.action.ACTION_FD_CONFIGURE"

    invoke-virtual {v0, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_12

    .line 292
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    const-string v10, "intent received : ACTION_FD_CONFIGURE"

    invoke-virtual {v9, v10}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logd(Ljava/lang/String;)V

    .line 293
    const-string v9, "reqFuncId"

    const/4 v10, 0x0

    invoke-virtual {p2, v9, v10}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v9

    const/16 v10, 0x12e

    if-ne v9, v10, :cond_11

    .line 294
    const-string v9, "fdparam"

    invoke-virtual {p2, v9}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 295
    .local v4, "fdParam":Ljava/lang/String;
    if-eqz v4, :cond_1

    .line 296
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    const-string v10, "Reset option Flags"

    invoke-virtual {v9, v10}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logi(Ljava/lang/String;)V

    .line 297
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    const/4 v10, 0x0

    iput-boolean v10, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->mIsPreventWhenLcdOn:Z

    .line 298
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    const/4 v10, 0x0

    iput-boolean v10, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->mIsPreventWhenCalling:Z

    .line 299
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    const/4 v10, 0x0

    iput-boolean v10, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->mIsDelayInDialing:Z

    .line 300
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    const/4 v10, 0x0

    iput-boolean v10, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->mIsPreventInTethering:Z

    .line 301
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    const/4 v10, 0x0

    iput-boolean v10, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->mIsFdPaused:Z

    .line 302
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "Change FD parameter : "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logd(Ljava/lang/String;)V

    .line 303
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    invoke-virtual {v9, v4}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->setFDSettingValue(Ljava/lang/String;)V

    .line 304
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-object v9, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mFDConfig:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;

    invoke-virtual {v9}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$FastDormancyConfig;->getIsActive()Z

    move-result v9

    if-nez v9, :cond_10

    .line 305
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    const-string v10, "Fast Dormancy is disabled."

    invoke-virtual {v9, v10}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logi(Ljava/lang/String;)V

    .line 306
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    invoke-virtual {v9}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->dispose()V

    .line 309
    :cond_10
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    invoke-virtual {v9}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->scheduleCheckNetStat()V

    goto/16 :goto_0

    .line 311
    .end local v4    # "fdParam":Ljava/lang/String;
    :cond_11
    const-string v9, "reqFuncId"

    const/4 v10, 0x0

    invoke-virtual {p2, v9, v10}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v9

    const/16 v10, 0x12f

    if-ne v9, v10, :cond_1

    .line 312
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    const-string v10, "dbg"

    const/4 v11, 0x1

    invoke-virtual {p2, v10, v11}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v10

    # setter for: Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->DBG:Z
    invoke-static {v9, v10}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->access$502(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;Z)Z

    .line 313
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    const-string v10, "vdbg"

    const/4 v11, 0x1

    invoke-virtual {p2, v10, v11}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v10

    # setter for: Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->VDBG:Z
    invoke-static {v9, v10}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->access$602(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;Z)Z

    .line 314
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "Change debug message DGB("

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget-object v11, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    # getter for: Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->DBG:Z
    invoke-static {v11}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->access$500(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;)Z

    move-result v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, "), "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, "VDGB("

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget-object v11, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    # getter for: Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->VDBG:Z
    invoke-static {v11}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->access$600(Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;)Z

    move-result v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ")"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logd(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 317
    :cond_12
    const-string v9, "com.lge.intent.action.BIP_EVENT"

    invoke-virtual {v0, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_1

    .line 319
    const-string v9, "param1"

    invoke-virtual {p2, v9}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 320
    .local v2, "cmdType":Ljava/lang/String;
    const-string v9, "param2"

    invoke-virtual {p2, v9}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 321
    .local v8, "status":Ljava/lang/String;
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "intent received ACTION_BIP_EVENT, cmdType: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, " status: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, " mBIPActivState: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget-object v11, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-boolean v11, v11, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mBIPActivState:Z

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logd(Ljava/lang/String;)V

    .line 323
    const-string v9, "OPEN_CH"

    invoke-virtual {v9, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_13

    const-string v9, "success"

    invoke-virtual {v9, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_13

    .line 324
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    const/4 v10, 0x1

    iput-boolean v10, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mBIPActivState:Z

    .line 325
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "BIP opened channel, mBIPActivState: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget-object v11, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-boolean v11, v11, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mBIPActivState:Z

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logd(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 327
    :cond_13
    const-string v9, "CLOSE_CH"

    invoke-virtual {v9, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_14

    const-string v9, "success"

    invoke-virtual {v9, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_14

    .line 328
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    const/4 v10, 0x0

    iput-boolean v10, v9, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mBIPActivState:Z

    .line 329
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "BIP closed channel, mBIPActivState: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget-object v11, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-boolean v11, v11, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mBIPActivState:Z

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logd(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 332
    :cond_14
    iget-object v9, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "BIP sent invalid intent, mBIPActivState: "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    iget-object v11, p0, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl$1;->this$0:Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;

    iget-boolean v11, v11, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->mBIPActivState:Z

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v10}, Lcom/android/internal/telephony/lgdata/LgeFDHandlerInterfaceImpl;->logd(Ljava/lang/String;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto/16 :goto_0

    .line 254
    .end local v2    # "cmdType":Ljava/lang/String;
    .end local v8    # "status":Ljava/lang/String;
    .restart local v3    # "extras":Landroid/os/Bundle;
    .restart local v7    # "ss":Landroid/telephony/ServiceState;
    :catch_0
    move-exception v9

    goto/16 :goto_2
.end method
