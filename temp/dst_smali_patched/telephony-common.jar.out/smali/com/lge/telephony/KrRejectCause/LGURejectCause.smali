.class public Lcom/lge/telephony/KrRejectCause/LGURejectCause;
.super Lcom/lge/telephony/KrRejectCause/RejectCauseBase;
.source "LGURejectCause.java"


# static fields
.field static final DBG:Z = true

.field static final LOG_TAG:Ljava/lang/String; = "LGURejectCause"


# instance fields
.field private mStatusId:I


# direct methods
.method public constructor <init>(Lcom/android/internal/telephony/gsm/GSMPhone;)V
    .locals 1
    .param p1, "phone"    # Lcom/android/internal/telephony/gsm/GSMPhone;

    .prologue
    invoke-direct {p0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mStatusId:I

    sput-object p1, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    return-void
.end method

.method private initializeCheckTempRejectWait()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    invoke-super {p0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->initialize()V

    const-string v0, "gsm.rc_2_rs_3_5.exist"

    const-string v1, "false"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "ril.gsm.reject_cause"

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    iput v2, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mStatusId:I

    return-void
.end method

.method private setMMTempRejected(Z)V
    .locals 2
    .param p1, "isTempRejected"    # Z

    .prologue
    if-eqz p1, :cond_0

    const-string v0, "ril.gsm.mm_temp"

    const-string v1, "true"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_0
    const-string v0, "ril.gsm.mm_temp"

    const-string v1, "false"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method private showRejectNotiLGU()V
    .locals 3

    .prologue
    invoke-virtual {p0}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->isUsimRoaming()Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mRejectCauseStateListener:Lcom/lge/telephony/KrRejectCause/IRejectCauseStateListener;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mRejectCauseStateListener:Lcom/lge/telephony/KrRejectCause/IRejectCauseStateListener;

    iget v1, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mm_reject_cause:I

    iget v2, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->gmm_reject_cause:I

    invoke-interface {v0, v1, v2}, Lcom/lge/telephony/KrRejectCause/IRejectCauseStateListener;->notifyRejectCauseChanged(II)V

    goto :goto_0
.end method


# virtual methods
.method protected checkGsmServiceStatus()I
    .locals 3

    .prologue
    const/4 v0, 0x0

    .local v0, "statusId":I
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "checkGsmServiceStatus() mm_reject_cause:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mm_reject_cause:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", gmm_reject_cause:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->gmm_reject_cause:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->log(Ljava/lang/String;)V

    iget v1, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mm_reject_cause:I

    if-lez v1, :cond_0

    const-string v1, "ril.gsm.mm_cause"

    iget v2, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mm_reject_cause:I

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    iget v1, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->gmm_reject_cause:I

    if-lez v1, :cond_1

    const-string v1, "ril.gsm.gmm_cause"

    iget v2, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->gmm_reject_cause:I

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    :cond_1
    iget-boolean v1, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mm_reject_cause_changed:Z

    if-nez v1, :cond_3

    iget v1, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->gmm_reject_cause:I

    if-lez v1, :cond_3

    iget v0, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->gmm_reject_cause:I

    :cond_2
    :goto_0
    return v0

    :cond_3
    iget v1, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mm_reject_cause:I

    if-lez v1, :cond_2

    iget v0, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mm_reject_cause:I

    goto :goto_0
.end method

.method public clearRejectCause(II)Z
    .locals 5
    .param p1, "clear_mm"    # I
    .param p2, "clear_gmm"    # I

    .prologue
    const/4 v4, 0x0

    const/4 v3, 0x1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[LGE] clearRejectCause() clear_mm = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", clear_gmm = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->log(Ljava/lang/String;)V

    if-ne p1, v3, :cond_1

    if-ne p2, v3, :cond_1

    iput v4, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mm_reject_cause:I

    iput v4, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->gmm_reject_cause:I

    const-string v1, "ril.gsm.mm_cause"

    const-string v2, "0"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "ril.gsm.gmm_cause"

    const-string v2, "0"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->processRejectCause()V

    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[LGE] clearRejectCause() mm = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mm_reject_cause:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", gmm = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->gmm_reject_cause:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->log(Ljava/lang/String;)V

    iget v1, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mm_reject_cause:I

    if-nez v1, :cond_0

    iget v1, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->gmm_reject_cause:I

    if-nez v1, :cond_0

    sget-object v1, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "notification"

    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    .local v0, "notificationManager":Landroid/app/NotificationManager;
    const v1, 0xc73b

    invoke-virtual {v0, v1}, Landroid/app/NotificationManager;->cancel(I)V

    .end local v0    # "notificationManager":Landroid/app/NotificationManager;
    :cond_0
    return v3

    :cond_1
    if-ne p1, v3, :cond_4

    iput v4, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mm_reject_cause:I

    iput-boolean v4, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mm_reject_cause_changed:Z

    const-string v1, "ril.gsm.mm_cause"

    const-string v2, "0"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    iget v1, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->gmm_reject_cause:I

    if-nez v1, :cond_2

    const-string v1, "ril.gsm.gmm_cause"

    const-string v2, "0"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->processRejectCause()V

    goto :goto_0

    :cond_2
    iget v1, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mm_reject_cause:I

    iget v2, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->gmm_reject_cause:I

    invoke-virtual {p0, v1, v2}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->isTempRejectAndNeedWait(II)Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-direct {p0}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->initializeCheckTempRejectWait()V

    goto :goto_0

    :cond_3
    invoke-virtual {p0}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->processRejectCause()V

    goto :goto_0

    :cond_4
    if-ne p2, v3, :cond_7

    iput v4, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->gmm_reject_cause:I

    iput-boolean v3, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mm_reject_cause_changed:Z

    const-string v1, "ril.gsm.gmm_cause"

    const-string v2, "0"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    iget v1, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mm_reject_cause:I

    if-nez v1, :cond_5

    const-string v1, "ril.gsm.mm_cause"

    const-string v2, "0"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->processRejectCause()V

    goto/16 :goto_0

    :cond_5
    iget v1, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mm_reject_cause:I

    iget v2, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->gmm_reject_cause:I

    invoke-virtual {p0, v1, v2}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->isTempRejectAndNeedWait(II)Z

    move-result v1

    if-eqz v1, :cond_6

    invoke-direct {p0}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->initializeCheckTempRejectWait()V

    goto/16 :goto_0

    :cond_6
    invoke-virtual {p0}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->processRejectCause()V

    goto/16 :goto_0

    :cond_7
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[LGE] clearRejectCause() Error clear_mm = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", clear_gmm = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->log(Ljava/lang/String;)V

    goto/16 :goto_0
.end method

.method protected clearStatusId()V
    .locals 0

    .prologue
    return-void
.end method

.method protected getStatusIdFromRejectCause(II)I
    .locals 1
    .param p1, "cause"    # I
    .param p2, "statusId"    # I

    .prologue
    if-nez p2, :cond_0

    if-nez p1, :cond_1

    :cond_0
    move v0, p2

    .end local p2    # "statusId":I
    .local v0, "statusId":I
    :goto_0
    return v0

    .end local v0    # "statusId":I
    .restart local p2    # "statusId":I
    :cond_1
    if-lez p1, :cond_2

    move p2, p1

    :cond_2
    move v0, p2

    .end local p2    # "statusId":I
    .restart local v0    # "statusId":I
    goto :goto_0
.end method

.method public initialize()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    invoke-super {p0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->initialize()V

    const-string v0, "gsm.rc_2_rs_3_5.exist"

    const-string v1, "false"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "ril.gsm.reject_cause"

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "ril.gsm.mm_cause"

    const-string v1, "0"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "ril.gsm.gmm_cause"

    const-string v1, "0"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct {p0, v2}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->setMMTempRejected(Z)V

    iput v2, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mStatusId:I

    return-void
.end method

.method protected log(Ljava/lang/String;)V
    .locals 1
    .param p1, "s"    # Ljava/lang/String;

    .prologue
    const-string v0, "LGURejectCause"

    invoke-static {v0, p1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method protected processRejectCause()V
    .locals 3

    .prologue
    const-string v1, "processRejectCause"

    invoke-virtual {p0, v1}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->log(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->checkGsmServiceStatus()I

    move-result v0

    .local v0, "statusId":I
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "previous statusId "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mStatusId:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " current statusId = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->log(Ljava/lang/String;)V

    iget v1, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mStatusId:I

    if-eq v1, v0, :cond_2

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->initialize()V

    :cond_0
    iput v0, p0, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->mStatusId:I

    const-string v1, "ril.gsm.reject_cause"

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->processStatuId(I)V

    :cond_1
    :goto_0
    return-void

    :cond_2
    if-lez v0, :cond_1

    invoke-virtual {p0}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->isRejectDialogActive()Z

    move-result v1

    if-nez v1, :cond_1

    invoke-virtual {p0, v0}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->processStatuId(I)V

    goto :goto_0
.end method

.method protected processStatuId(I)V
    .locals 4
    .param p1, "statusId"    # I

    .prologue
    const/4 v0, 0x0

    .local v0, "msg":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "processStatuId : statusId :"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->log(Ljava/lang/String;)V

    const-string v1, "LGU"

    const-string v2, "ril.card_operator"

    const-string v3, ""

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "no"

    const-string v2, "ril.card_provisioned"

    const-string v3, ""

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    :goto_0
    return-void

    :cond_0
    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-virtual {p0, v0, v1, v2}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->showDialog(Ljava/lang/String;ZZ)V

    goto :goto_0
.end method

.method protected showDialog(Ljava/lang/String;ZZ)V
    .locals 3
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "canShow"    # Z
    .param p3, "enTimeout"    # Z

    .prologue
    invoke-static {}, Lcom/android/internal/telephony/TelephonyUtils;->isFactoryMode()Z

    move-result v1

    if-eqz v1, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    const-string v1, "ril.card_operator"

    const-string v2, ""

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "operator":Ljava/lang/String;
    const-string v1, "LGU"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-direct {p0}, Lcom/lge/telephony/KrRejectCause/LGURejectCause;->showRejectNotiLGU()V

    goto :goto_0
.end method
