.class Lcom/android/internal/telephony/gsm/GSMPhoneEx$2;
.super Landroid/content/BroadcastReceiver;
.source "GSMPhoneEx.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/internal/telephony/gsm/GSMPhoneEx;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/internal/telephony/gsm/GSMPhoneEx;


# direct methods
.method constructor <init>(Lcom/android/internal/telephony/gsm/GSMPhoneEx;)V
    .locals 0

    .prologue
    .line 373
    iput-object p1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx$2;->this$0:Lcom/android/internal/telephony/gsm/GSMPhoneEx;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    .line 376
    invoke-static {p1, p2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->updateProfile(Landroid/content/Context;Landroid/content/Intent;)V

    .line 377
    const-string v1, "ss"

    invoke-virtual {p2, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 378
    .local v0, "stateExtra":Ljava/lang/String;
    const-string v1, "GSMPhoneEx"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[GSMPhone] mSimStateReceiver - stateExtra: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 379
    const-string v1, "LOADED"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 381
    const-string v1, "GSMPhoneEx"

    const-string v2, "[GSMPhone] mSimStateReceiver - ICC LOADED"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 385
    const-string v1, "persist.sys.cust.lte_config"

    const/4 v2, 0x0

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 386
    # getter for: Lcom/android/internal/telephony/gsm/GSMPhoneEx;->smIsCheckedLTEReady:Z
    invoke-static {}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->access$000()Z

    move-result v1

    if-nez v1, :cond_0

    .line 387
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx$2;->this$0:Lcom/android/internal/telephony/gsm/GSMPhoneEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->checkLteReady()V

    .line 393
    :cond_0
    invoke-static {}, Lcom/android/internal/telephony/GsmAlphabet;->enableCountrySpecificEncodings()V

    .line 397
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx$2;->this$0:Lcom/android/internal/telephony/gsm/GSMPhoneEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->syncClirSetting()V

    .line 407
    :cond_1
    :goto_0
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx$2;->this$0:Lcom/android/internal/telephony/gsm/GSMPhoneEx;

    # getter for: Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mContext:Landroid/content/Context;
    invoke-static {v1}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->access$100(Lcom/android/internal/telephony/gsm/GSMPhoneEx;)Landroid/content/Context;

    move-result-object v1

    const-string v2, "seperate_processing_sms_uicc"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 408
    const-string v1, "ABSENT"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 409
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx$2;->this$0:Lcom/android/internal/telephony/gsm/GSMPhoneEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->emptySIMMessageDB()V

    .line 418
    :cond_2
    :goto_1
    return-void

    .line 400
    :cond_3
    const-string v1, "READY"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 401
    const-string v1, "H3G"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 402
    const-string v1, "GSMPhoneEx"

    const-string v2, "Set permanantAutomode when power on "

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 403
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx$2;->this$0:Lcom/android/internal/telephony/gsm/GSMPhoneEx;

    iget-object v1, v1, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/4 v2, 0x0

    invoke-interface {v1, v2}, Lcom/android/internal/telephony/CommandsInterface;->setNetworkSelectionModeAutomatic(Landroid/os/Message;)V

    goto :goto_0

    .line 410
    :cond_4
    const-string v1, "READY"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 412
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx$2;->this$0:Lcom/android/internal/telephony/gsm/GSMPhoneEx;

    # getter for: Lcom/android/internal/telephony/gsm/GSMPhoneEx;->mContext:Landroid/content/Context;
    invoke-static {v1}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->access$200(Lcom/android/internal/telephony/gsm/GSMPhoneEx;)Landroid/content/Context;

    move-result-object v1

    const-string v2, "uicc_csim"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    .line 413
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GSMPhoneEx$2;->this$0:Lcom/android/internal/telephony/gsm/GSMPhoneEx;

    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/GSMPhoneEx;->emptySIMMessageDB()V

    goto :goto_1
.end method
