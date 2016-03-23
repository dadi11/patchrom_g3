.class public Lcom/lge/telephony/KDDIPreferredNetwork;
.super Lcom/lge/telephony/LgePreferredNetwork;
.source "KDDIPreferredNetwork.java"


# direct methods
.method public constructor <init>(Lcom/android/internal/telephony/Phone;)V
    .locals 0
    .param p1, "phone"    # Lcom/android/internal/telephony/Phone;

    .prologue
    invoke-direct {p0, p1}, Lcom/lge/telephony/LgePreferredNetwork;-><init>(Lcom/android/internal/telephony/Phone;)V

    return-void
.end method


# virtual methods
.method protected sendResponse(ILjava/lang/Throwable;)V
    .locals 5
    .param p1, "type"    # I
    .param p2, "ex"    # Ljava/lang/Throwable;

    .prologue
    const/4 v2, -0x1

    const/4 v1, 0x0

    iget v3, p0, Lcom/lge/telephony/KDDIPreferredNetwork;->mTypeGet:I

    if-ne p1, v3, :cond_2

    new-instance v0, Landroid/content/Intent;

    const-string v3, "com.lge.intent.action.GetNetWorkMode"

    invoke-direct {v0, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intent":Landroid/content/Intent;
    const-string v3, "networkmode"

    invoke-virtual {p0}, Lcom/lge/telephony/KDDIPreferredNetwork;->getPreferredNetworkMode()I

    move-result v4

    invoke-virtual {v0, v3, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v3, "exception"

    if-nez p2, :cond_1

    :goto_0
    invoke-virtual {v0, v3, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    iget-object v1, p0, Lcom/lge/telephony/KDDIPreferredNetwork;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v1}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    .end local v0    # "intent":Landroid/content/Intent;
    :cond_0
    :goto_1
    return-void

    .restart local v0    # "intent":Landroid/content/Intent;
    :cond_1
    move v1, v2

    goto :goto_0

    .end local v0    # "intent":Landroid/content/Intent;
    :cond_2
    iget v3, p0, Lcom/lge/telephony/KDDIPreferredNetwork;->mTypeSet:I

    if-ne p1, v3, :cond_0

    new-instance v0, Landroid/content/Intent;

    const-string v3, "com.lge.intent.action.SetNetWorkMode"

    invoke-direct {v0, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .restart local v0    # "intent":Landroid/content/Intent;
    const-string v3, "exception"

    if-nez p2, :cond_3

    move v2, v1

    :cond_3
    invoke-virtual {v0, v3, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    iget-object v2, p0, Lcom/lge/telephony/KDDIPreferredNetwork;->mPhone:Lcom/android/internal/telephony/Phone;

    invoke-interface {v2}, Lcom/android/internal/telephony/Phone;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2, v0}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    iput-boolean v1, p0, Lcom/lge/telephony/KDDIPreferredNetwork;->isIntentDuplicate:Z

    goto :goto_1
.end method

.method protected setIntentActionName()V
    .locals 1

    .prologue
    const-string v0, "SetNetworkMode_KDDI_LTE"

    iput-object v0, p0, Lcom/lge/telephony/KDDIPreferredNetwork;->ACTION_PREFERRED_NETWORK_SET:Ljava/lang/String;

    const-string v0, "GetNetworkMode_KDDI_LTE"

    iput-object v0, p0, Lcom/lge/telephony/KDDIPreferredNetwork;->ACTION_PREFERRED_NETWORK_GET:Ljava/lang/String;

    return-void
.end method
