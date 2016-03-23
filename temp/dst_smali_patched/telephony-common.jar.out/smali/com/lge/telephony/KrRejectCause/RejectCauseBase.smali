.class public abstract Lcom/lge/telephony/KrRejectCause/RejectCauseBase;
.super Ljava/lang/Object;
.source "RejectCauseBase.java"

# interfaces
.implements Lcom/lge/telephony/KrRejectCause/RejectCause;


# static fields
.field protected static final DBG:Z = true

.field private static final DIALOG_TIMEOUT:I = 0x1d4c0

.field protected static final LOG_TAG:Ljava/lang/String; = "RejectCauseBase"

.field private static final MSG_ID_TIMEOUT:I = 0x1

.field static final PROPERTY_GMM_REJECT_CAUSE:Ljava/lang/String; = "ril.gsm.gmm_cause"

.field static final PROPERTY_MM_REJECT_CAUSE:Ljava/lang/String; = "ril.gsm.mm_cause"

.field static final PROPERTY_MM_REJECT_TEMP:Ljava/lang/String; = "ril.gsm.mm_temp"

.field static final REJECTCAUSE_NOTIFICATION_ID:I = 0xc73b

.field static mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;


# instance fields
.field protected camped_mcc:I

.field protected camped_mnc:I

.field protected gmm_rau_attempt_counter:I

.field protected gmm_reject_cause:I

.field protected gprs_attach_attempt_counter:I

.field mDialogOnKeyListener:Landroid/content/DialogInterface$OnKeyListener;

.field private mFailNotification:Landroid/app/Notification;

.field protected mRejectCauseStateListener:Lcom/lge/telephony/KrRejectCause/IRejectCauseStateListener;

.field mTimeoutHandler:Landroid/os/Handler;

.field protected mm_lu_attempt_counter:I

.field protected mm_reject_cause:I

.field protected mm_reject_cause_changed:Z

.field protected ms_op_mode:I

.field private networkDialog:Landroid/app/AlertDialog;

.field protected network_op_mode:I

.field protected pre_srv_status:I

.field protected radio_tech:I

.field protected srv_domain:I

.field protected srv_status:I


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->ms_op_mode:I

    const/4 v0, 0x3

    iput v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->network_op_mode:I

    iput v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mm_reject_cause:I

    iput v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->gmm_reject_cause:I

    iput v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mm_lu_attempt_counter:I

    iput v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->gprs_attach_attempt_counter:I

    iput v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->gmm_rau_attempt_counter:I

    iput v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->camped_mcc:I

    iput v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->camped_mnc:I

    iput v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->pre_srv_status:I

    iput v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->srv_status:I

    iput-boolean v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mm_reject_cause_changed:Z

    const/16 v0, 0xc

    iput v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->radio_tech:I

    new-instance v0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase$8;

    invoke-direct {v0, p0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase$8;-><init>(Lcom/lge/telephony/KrRejectCause/RejectCauseBase;)V

    iput-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mTimeoutHandler:Landroid/os/Handler;

    new-instance v0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase$9;

    invoke-direct {v0, p0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase$9;-><init>(Lcom/lge/telephony/KrRejectCause/RejectCauseBase;)V

    iput-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mDialogOnKeyListener:Landroid/content/DialogInterface$OnKeyListener;

    return-void
.end method

.method private QweryModeToString(I)Ljava/lang/String;
    .locals 1
    .param p1, "QueryMode"    # I

    .prologue
    packed-switch p1, :pswitch_data_0

    const-string v0, "ERROR"

    :goto_0
    return-object v0

    :pswitch_0
    const-string v0, "EXCEPTION"

    goto :goto_0

    :pswitch_1
    const-string v0, "NEED_PROCESSING"

    goto :goto_0

    :pswitch_2
    const-string v0, "NEED_WAITING"

    goto :goto_0

    :pswitch_3
    const-string v0, "NEED_QWERY"

    goto :goto_0

    :pswitch_data_0
    .packed-switch -0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method static synthetic access$000(Lcom/lge/telephony/KrRejectCause/RejectCauseBase;)Landroid/app/AlertDialog;
    .locals 1
    .param p0, "x0"    # Lcom/lge/telephony/KrRejectCause/RejectCauseBase;

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->networkDialog:Landroid/app/AlertDialog;

    return-object v0
.end method

.method private getRejectValueFromUnsol([I)I
    .locals 8
    .param p1, "ints"    # [I

    .prologue
    const/4 v7, 0x6

    const/4 v6, 0x5

    const/4 v3, 0x1

    const/4 v2, 0x0

    const/4 v0, -0x1

    .local v0, "modemInfoQueryMode":I
    const-string v4, "KR"

    const-string v5, "LGU"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    array-length v4, p1

    if-ne v4, v7, :cond_0

    aget v4, p1, v6

    const/16 v5, 0x9

    if-ne v4, v5, :cond_0

    const/4 v2, -0x1

    :goto_0
    return v2

    :cond_0
    const-string v4, "KR"

    const-string v5, "LGU"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_5

    aget v4, p1, v2

    if-eqz v4, :cond_2

    aget v1, p1, v2

    .local v1, "new_mm_reject_cause":I
    :goto_1
    iget v4, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mm_reject_cause:I

    if-ne v4, v1, :cond_3

    :goto_2
    iput-boolean v2, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mm_reject_cause_changed:Z

    iput v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mm_reject_cause:I

    aget v2, p1, v3

    if-eqz v2, :cond_4

    aget v2, p1, v3

    :goto_3
    iput v2, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->gmm_reject_cause:I

    .end local v1    # "new_mm_reject_cause":I
    :goto_4
    const/4 v2, 0x2

    aget v2, p1, v2

    iput v2, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mm_lu_attempt_counter:I

    const/4 v2, 0x3

    aget v2, p1, v2

    iput v2, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->gprs_attach_attempt_counter:I

    const/4 v2, 0x4

    aget v2, p1, v2

    iput v2, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->gmm_rau_attempt_counter:I

    array-length v2, p1

    if-ne v2, v7, :cond_1

    aget v2, p1, v6

    iput v2, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->radio_tech:I

    :cond_1
    iget v2, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mm_reject_cause:I

    iget v3, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->gmm_reject_cause:I

    invoke-virtual {p0, v2, v3}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->isTempRejectAndNeedWait(II)Z

    move-result v2

    if-eqz v2, :cond_6

    const/4 v0, 0x1

    :goto_5
    move v2, v0

    goto :goto_0

    :cond_2
    iget v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mm_reject_cause:I

    goto :goto_1

    .restart local v1    # "new_mm_reject_cause":I
    :cond_3
    move v2, v3

    goto :goto_2

    :cond_4
    iget v2, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->gmm_reject_cause:I

    goto :goto_3

    .end local v1    # "new_mm_reject_cause":I
    :cond_5
    aget v2, p1, v2

    iput v2, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mm_reject_cause:I

    aget v2, p1, v3

    iput v2, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->gmm_reject_cause:I

    goto :goto_4

    :cond_6
    const-string v2, "KR"

    const-string v3, "LGU"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_7

    const/4 v0, 0x2

    goto :goto_5

    :cond_7
    const/4 v0, 0x0

    goto :goto_5
.end method

.method private processTempRejectImmediatelyLGU()V
    .locals 4

    .prologue
    const/4 v3, 0x1

    const-string v1, "KR"

    const-string v2, "LGU"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    iget v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mm_lu_attempt_counter:I

    if-lt v1, v3, :cond_0

    iget v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mm_reject_cause:I

    if-eqz v1, :cond_0

    const-string v1, "ril.gsm.mm_cause"

    iget v2, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mm_reject_cause:I

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    iget v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->gprs_attach_attempt_counter:I

    if-ge v1, v3, :cond_1

    iget v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->gmm_rau_attempt_counter:I

    if-lt v1, v3, :cond_2

    :cond_1
    iget v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->gmm_reject_cause:I

    if-eqz v1, :cond_2

    const-string v1, "ril.gsm.gmm_cause"

    iget v2, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->gmm_reject_cause:I

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    :cond_2
    const-string v1, "ril.gsm.mm_temp"

    const-string v2, "true"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.lge.intent.action.temp_reject"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "reject_changed_temp_to_normal"

    const-string v2, "false"

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "temp reject received"

    invoke-virtual {p0, v1}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->log(Ljava/lang/String;)V

    sget-object v1, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v1

    sget-object v2, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v1, v0, v2}, Landroid/content/Context;->sendStickyBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    .end local v0    # "intent":Landroid/content/Intent;
    :cond_3
    return-void
.end method


# virtual methods
.method public bManualSelectionAvailable()Z
    .locals 1

    .prologue
    const/4 v0, 0x1

    return v0
.end method

.method protected abstract checkGsmServiceStatus()I
.end method

.method public clearRejectCause(II)Z
    .locals 2
    .param p1, "clear_mm"    # I
    .param p2, "clear_gmm"    # I

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[LGE] clearRejectCause() clear_mm = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", clear_gmm = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->log(Ljava/lang/String;)V

    const/4 v0, 0x0

    return v0
.end method

.method protected abstract clearStatusId()V
.end method

.method protected dumpState()Ljava/lang/String;
    .locals 3

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "ms_op_mode="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->ms_op_mode:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "network_op_mode="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->network_op_mode:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "mm_reject="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mm_reject_cause:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "gmm_reject="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->gmm_reject_cause:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "camped_mcc="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->camped_mcc:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "camped_mnc="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->camped_mnc:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "srv_status="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->srv_status:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "srv_domain="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->srv_domain:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "UsimOperator="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "ril.card_operator"

    const-string v2, ""

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ","

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "UsimProvisoned="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "ril.card_provisioned"

    const-string v2, ""

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected abstract getStatusIdFromRejectCause(II)I
.end method

.method public handleServiceStatusResult(Landroid/os/AsyncResult;)I
    .locals 4
    .param p1, "ar"    # Landroid/os/AsyncResult;

    .prologue
    const/4 v2, 0x1

    const/4 v1, -0x1

    iget-object v3, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-eqz v3, :cond_1

    const-string v2, "handleServiceStatusResult() exception..."

    invoke-virtual {p0, v2}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->log(Ljava/lang/String;)V

    move v0, v1

    :cond_0
    :goto_0
    return v0

    :cond_1
    invoke-virtual {p0, p1}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->updateValuesFromNewtork(Landroid/os/AsyncResult;)I

    move-result v0

    .local v0, "modemInfoQueryMode":I
    invoke-direct {p0, v0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->QweryModeToString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->log(Ljava/lang/String;)V

    if-eq v0, v1, :cond_0

    if-eq v0, v2, :cond_0

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    invoke-virtual {p0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->dumpState()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->log(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->processRejectCause()V

    const-string v1, "KR"

    const-string v3, "SKT"

    invoke-static {v1, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    const-string v1, "KR"

    const-string v3, "KT"

    invoke-static {v1, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    :cond_2
    iget v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->srv_status:I

    iput v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->pre_srv_status:I

    :cond_3
    move v0, v2

    goto :goto_0
.end method

.method public initialize()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    const-string v0, "initialize"

    invoke-virtual {p0, v0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->log(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->postDismissDialog()V

    iput v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mm_lu_attempt_counter:I

    iput v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->gprs_attach_attempt_counter:I

    iput v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->gmm_rau_attempt_counter:I

    return-void
.end method

.method protected isRejectDialogActive()Z
    .locals 1

    .prologue
    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->networkDialog:Landroid/app/AlertDialog;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->networkDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method protected isTempRejectAndNeedWait(II)Z
    .locals 6
    .param p1, "mm_cause"    # I
    .param p2, "gmm_cause"    # I

    .prologue
    const/4 v5, 0x5

    const/4 v2, 0x0

    const/4 v1, 0x0

    .local v1, "tempReject":Z
    sparse-switch p1, :sswitch_data_0

    :goto_0
    sparse-switch p2, :sswitch_data_1

    :goto_1
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "isTempRejectPreprocess():: tempReject="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", mm="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", gmm="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", mm_c="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mm_lu_attempt_counter:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", grps_c="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->gprs_attach_attempt_counter:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", gmm_c="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget v4, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->gmm_rau_attempt_counter:I

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->log(Ljava/lang/String;)V

    if-nez v1, :cond_1

    :cond_0
    :goto_2
    return v2

    :sswitch_0
    const/4 v1, 0x1

    goto :goto_0

    :sswitch_1
    const/4 v1, 0x1

    goto :goto_1

    :cond_1
    iget v3, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mm_lu_attempt_counter:I

    const/4 v4, 0x4

    if-ge v3, v4, :cond_2

    iget v3, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->gprs_attach_attempt_counter:I

    if-ge v3, v5, :cond_2

    iget v3, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->gmm_rau_attempt_counter:I

    if-lt v3, v5, :cond_3

    :cond_2
    const-string v3, "KR"

    const-string v4, "LGU"

    invoke-static {v3, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    const-string v3, "ril.gsm.mm_temp"

    const-string v4, "false"

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v0, Landroid/content/Intent;

    const-string v3, "com.lge.intent.action.temp_reject"

    invoke-direct {v0, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intent":Landroid/content/Intent;
    const-string v3, "reject_changed_temp_to_normal"

    const-string v4, "true"

    invoke-virtual {v0, v3, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v3, "temp reject changed to normal"

    invoke-virtual {p0, v3}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->log(Ljava/lang/String;)V

    sget-object v3, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v3}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v3

    sget-object v4, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v3, v0, v4}, Landroid/content/Context;->sendStickyBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    goto :goto_2

    .end local v0    # "intent":Landroid/content/Intent;
    :cond_3
    invoke-direct {p0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->processTempRejectImmediatelyLGU()V

    const/4 v2, 0x1

    goto :goto_2

    :sswitch_data_0
    .sparse-switch
        0x10 -> :sswitch_0
        0x11 -> :sswitch_0
        0x16 -> :sswitch_0
    .end sparse-switch

    :sswitch_data_1
    .sparse-switch
        0x10 -> :sswitch_1
        0x11 -> :sswitch_1
        0x16 -> :sswitch_1
    .end sparse-switch
.end method

.method protected isUsimRoaming()Z
    .locals 2

    .prologue
    const-string v0, "true"

    const-string v1, "persist.radio.isroaming"

    invoke-static {v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method protected abstract log(Ljava/lang/String;)V
.end method

.method protected postDismissDialog()V
    .locals 2

    .prologue
    const-string v0, "************** postDismissDialog()*********************"

    invoke-virtual {p0, v0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->networkDialog:Landroid/app/AlertDialog;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->networkDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->dismiss()V

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mTimeoutHandler:Landroid/os/Handler;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeMessages(I)V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->networkDialog:Landroid/app/AlertDialog;

    const-string v0, "************** networkDialog.dismiss()*********************"

    invoke-virtual {p0, v0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->log(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method protected abstract processRejectCause()V
.end method

.method protected abstract processStatuId(I)V
.end method

.method public setRejectCauseStateListener(Lcom/lge/telephony/KrRejectCause/IRejectCauseStateListener;)V
    .locals 0
    .param p1, "listener"    # Lcom/lge/telephony/KrRejectCause/IRejectCauseStateListener;

    .prologue
    iput-object p1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mRejectCauseStateListener:Lcom/lge/telephony/KrRejectCause/IRejectCauseStateListener;

    return-void
.end method

.method protected showDialog(Ljava/lang/String;ZZ)V
    .locals 11
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "canShow"    # Z
    .param p3, "enTimeout"    # Z

    .prologue
    invoke-static {}, Lcom/android/internal/telephony/TelephonyUtils;->isFactoryMode()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    if-eqz p2, :cond_0

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "gsm.lge.ota_is_running"

    const-string v1, "false"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "true"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    const-string v0, "KR"

    const-string v1, "SKT"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "KR"

    const-string v1, "KT"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "showDialog() msg="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->networkDialog:Landroid/app/AlertDialog;

    if-eqz v0, :cond_3

    invoke-virtual {p0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->postDismissDialog()V

    :cond_3
    new-instance v0, Landroid/app/AlertDialog$Builder;

    sget-object v1, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v1

    const/4 v3, 0x3

    invoke-direct {v0, v1, v3}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;I)V

    invoke-virtual {v0, p1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setCancelable(Z)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "telephony_dialog_ok_button"

    invoke-static {v1}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    new-instance v3, Lcom/lge/telephony/KrRejectCause/RejectCauseBase$1;

    invoke-direct {v3, p0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase$1;-><init>(Lcom/lge/telephony/KrRejectCause/RejectCauseBase;)V

    invoke-virtual {v0, v1, v3}, Landroid/app/AlertDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->networkDialog:Landroid/app/AlertDialog;

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->networkDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/16 v1, 0x7d3

    invoke-virtual {v0, v1}, Landroid/view/Window;->setType(I)V

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->networkDialog:Landroid/app/AlertDialog;

    new-instance v1, Lcom/lge/telephony/KrRejectCause/RejectCauseBase$2;

    invoke-direct {v1, p0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase$2;-><init>(Lcom/lge/telephony/KrRejectCause/RejectCauseBase;)V

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)V

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->networkDialog:Landroid/app/AlertDialog;

    new-instance v1, Lcom/lge/telephony/KrRejectCause/RejectCauseBase$3;

    invoke-direct {v1, p0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase$3;-><init>(Lcom/lge/telephony/KrRejectCause/RejectCauseBase;)V

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->networkDialog:Landroid/app/AlertDialog;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog;->setCanceledOnTouchOutside(Z)V

    const-string v0, "KR"

    const-string v1, "SKT"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    invoke-virtual {p0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->isUsimRoaming()Z

    move-result v0

    if-eqz v0, :cond_4

    new-instance v2, Landroid/content/Intent;

    const-string v0, "android.intent.action.MAIN"

    invoke-direct {v2, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v2, "networkSettingIntent":Landroid/content/Intent;
    const-string v0, "com.android.phone"

    const-string v1, "com.android.phone.NetworkSetting"

    invoke-virtual {v2, v0, v1}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const/high16 v0, 0x10000000

    invoke-virtual {v2, v0}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    new-instance v0, Landroid/app/Notification;

    invoke-direct {v0}, Landroid/app/Notification;-><init>()V

    iput-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mFailNotification:Landroid/app/Notification;

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mFailNotification:Landroid/app/Notification;

    const-wide/16 v4, 0x0

    iput-wide v4, v0, Landroid/app/Notification;->when:J

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mFailNotification:Landroid/app/Notification;

    const/16 v1, 0x20

    iput v1, v0, Landroid/app/Notification;->flags:I

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mFailNotification:Landroid/app/Notification;

    const v1, 0x108008a

    iput v1, v0, Landroid/app/Notification;->icon:I

    iget-object v7, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mFailNotification:Landroid/app/Notification;

    sget-object v0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v8

    const-string v0, "SKT_ROAMING_FAIL_NOTIFICATION_TITLE"

    invoke-static {v0}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    const-string v0, "SKT_ROAMING_FAIL_NOTIFICATION_CONTENT"

    invoke-static {v0}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    sget-object v0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v0

    const/4 v1, 0x0

    const/high16 v3, 0x10000000

    const/4 v4, 0x0

    sget-object v5, Landroid/os/UserHandle;->CURRENT:Landroid/os/UserHandle;

    invoke-static/range {v0 .. v5}, Landroid/app/PendingIntent;->getActivityAsUser(Landroid/content/Context;ILandroid/content/Intent;ILandroid/os/Bundle;Landroid/os/UserHandle;)Landroid/app/PendingIntent;

    move-result-object v0

    invoke-virtual {v7, v8, v9, v10, v0}, Landroid/app/Notification;->setLatestEventInfo(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Landroid/app/PendingIntent;)V

    sget-object v0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "notification"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/app/NotificationManager;

    .local v6, "notificationManager":Landroid/app/NotificationManager;
    const/4 v0, 0x0

    const-string v1, "noti_for_all_user"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_5

    const/4 v0, 0x0

    const v1, 0xc73b

    iget-object v3, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mFailNotification:Landroid/app/Notification;

    sget-object v4, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v6, v0, v1, v3, v4}, Landroid/app/NotificationManager;->notifyAsUser(Ljava/lang/String;ILandroid/app/Notification;Landroid/os/UserHandle;)V

    .end local v2    # "networkSettingIntent":Landroid/content/Intent;
    .end local v6    # "notificationManager":Landroid/app/NotificationManager;
    :cond_4
    :goto_1
    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->networkDialog:Landroid/app/AlertDialog;

    invoke-static {v0}, Lcom/android/internal/telephony/LGTelephonyUtils;->makePublic(Landroid/app/Dialog;)V

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->networkDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    const-string v0, "networkDialog show"

    invoke-virtual {p0, v0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->log(Ljava/lang/String;)V

    if-eqz p3, :cond_0

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mTimeoutHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mTimeoutHandler:Landroid/os/Handler;

    const/4 v3, 0x1

    invoke-virtual {v1, v3}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    const-wide/32 v4, 0x1d4c0

    invoke-virtual {v0, v1, v4, v5}, Landroid/os/Handler;->sendMessageDelayed(Landroid/os/Message;J)Z

    goto/16 :goto_0

    .restart local v2    # "networkSettingIntent":Landroid/content/Intent;
    .restart local v6    # "notificationManager":Landroid/app/NotificationManager;
    :cond_5
    const v0, 0xc73b

    iget-object v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mFailNotification:Landroid/app/Notification;

    invoke-virtual {v6, v0, v1}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    goto :goto_1
.end method

.method protected showLocationFailDialogSKT(Ljava/lang/String;ZZ)V
    .locals 4
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "canShow"    # Z
    .param p3, "enTimeout"    # Z

    .prologue
    const/4 v3, 0x1

    invoke-static {}, Lcom/android/internal/telephony/TelephonyUtils;->isFactoryMode()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    :goto_0
    return-void

    :cond_1
    if-eqz p2, :cond_0

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "gsm.lge.ota_is_running"

    const-string v1, "false"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "true"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    const-string v0, "KR"

    const-string v1, "SKT"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "KR"

    const-string v1, "KT"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "showDialog() msg="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->networkDialog:Landroid/app/AlertDialog;

    if-eqz v0, :cond_3

    invoke-virtual {p0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->postDismissDialog()V

    :cond_3
    new-instance v0, Landroid/app/AlertDialog$Builder;

    sget-object v1, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v1

    const/4 v2, 0x3

    invoke-direct {v0, v1, v2}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;I)V

    invoke-virtual {v0, p1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0, v3}, Landroid/app/AlertDialog$Builder;->setCancelable(Z)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "telephony_dialog_cancel_button"

    invoke-static {v1}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/lge/telephony/KrRejectCause/RejectCauseBase$5;

    invoke-direct {v2, p0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase$5;-><init>(Lcom/lge/telephony/KrRejectCause/RejectCauseBase;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "telephony_dialog_ok_button"

    invoke-static {v1}, Lcom/android/internal/telephony/TelephonyUtils;->getTelephonyString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/lge/telephony/KrRejectCause/RejectCauseBase$4;

    invoke-direct {v2, p0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase$4;-><init>(Lcom/lge/telephony/KrRejectCause/RejectCauseBase;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->networkDialog:Landroid/app/AlertDialog;

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->networkDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/16 v1, 0x7d3

    invoke-virtual {v0, v1}, Landroid/view/Window;->setType(I)V

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->networkDialog:Landroid/app/AlertDialog;

    new-instance v1, Lcom/lge/telephony/KrRejectCause/RejectCauseBase$6;

    invoke-direct {v1, p0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase$6;-><init>(Lcom/lge/telephony/KrRejectCause/RejectCauseBase;)V

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)V

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->networkDialog:Landroid/app/AlertDialog;

    new-instance v1, Lcom/lge/telephony/KrRejectCause/RejectCauseBase$7;

    invoke-direct {v1, p0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase$7;-><init>(Lcom/lge/telephony/KrRejectCause/RejectCauseBase;)V

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->networkDialog:Landroid/app/AlertDialog;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog;->setCanceledOnTouchOutside(Z)V

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->networkDialog:Landroid/app/AlertDialog;

    invoke-static {v0}, Lcom/android/internal/telephony/LGTelephonyUtils;->makePublic(Landroid/app/Dialog;)V

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->networkDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    const-string v0, "networkDialog show"

    invoke-virtual {p0, v0}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->log(Ljava/lang/String;)V

    if-eqz p3, :cond_0

    iget-object v0, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mTimeoutHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mTimeoutHandler:Landroid/os/Handler;

    invoke-virtual {v1, v3}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    const-wide/32 v2, 0x1d4c0

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->sendMessageDelayed(Landroid/os/Message;J)Z

    goto/16 :goto_0
.end method

.method protected showRejectNotiLGU(Ljava/lang/String;)V
    .locals 0
    .param p1, "msg"    # Ljava/lang/String;

    .prologue
    return-void
.end method

.method protected updateValuesFromNewtork(Landroid/os/AsyncResult;)I
    .locals 12
    .param p1, "ar"    # Landroid/os/AsyncResult;

    .prologue
    const/16 v11, 0xa

    const/4 v10, 0x2

    const/16 v9, 0x9

    const/4 v7, 0x1

    const/4 v6, 0x0

    iget-object v5, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v5, [I

    move-object v1, v5

    check-cast v1, [I

    .local v1, "ints":[I
    const/4 v2, 0x0

    .local v2, "mnc_includes_pcs_digit":I
    const/4 v3, -0x1

    .local v3, "modemInfoQueryMode":I
    array-length v5, v1

    if-eq v5, v9, :cond_0

    array-length v5, v1

    if-eq v5, v11, :cond_0

    array-length v5, v1

    const/16 v8, 0xb

    if-ne v5, v8, :cond_b

    :cond_0
    aget v5, v1, v6

    iput v5, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->ms_op_mode:I

    aget v5, v1, v7

    iput v5, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->network_op_mode:I

    iget v5, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mm_reject_cause:I

    aget v8, v1, v10

    if-ne v5, v8, :cond_8

    move v5, v6

    :goto_0
    iput-boolean v5, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mm_reject_cause_changed:Z

    aget v5, v1, v10

    iput v5, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mm_reject_cause:I

    const/4 v5, 0x3

    aget v5, v1, v5

    iput v5, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->gmm_reject_cause:I

    const/4 v5, 0x4

    aget v5, v1, v5

    iput v5, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->camped_mcc:I

    const/4 v5, 0x5

    aget v2, v1, v5

    const/4 v5, 0x6

    aget v5, v1, v5

    iput v5, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->camped_mnc:I

    const/4 v5, 0x7

    aget v5, v1, v5

    iput v5, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->srv_status:I

    array-length v5, v1

    if-ne v5, v9, :cond_1

    const/16 v5, 0x8

    aget v5, v1, v5

    iput v5, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->srv_domain:I

    :cond_1
    array-length v5, v1

    if-ne v5, v11, :cond_2

    const/16 v5, 0x8

    aget v5, v1, v5

    iput v5, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->srv_domain:I

    aget v5, v1, v9

    iput v5, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->radio_tech:I

    :cond_2
    array-length v5, v1

    const/16 v8, 0xb

    if-ne v5, v8, :cond_5

    iget v5, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mm_reject_cause:I

    const/16 v8, 0xff

    if-ne v5, v8, :cond_3

    iput v6, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mm_reject_cause:I

    :cond_3
    iget v5, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->gmm_reject_cause:I

    const/16 v8, 0xff

    if-ne v5, v8, :cond_4

    iput v6, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->gmm_reject_cause:I

    :cond_4
    aget v5, v1, v9

    iput v5, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->srv_domain:I

    aget v5, v1, v11

    iput v5, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->radio_tech:I

    :cond_5
    const-string v5, "persist.radio.camped_mccmnc"

    const-string v8, "false"

    invoke-static {v5, v8}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .local v4, "prop_mccmnc":Ljava/lang/String;
    const-string v0, ""

    .local v0, "camped_mccmnc":Ljava/lang/String;
    iget v5, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->camped_mcc:I

    if-lez v5, :cond_6

    iget v5, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->camped_mcc:I

    const/16 v8, 0x3e7

    if-gt v5, v8, :cond_6

    iget v5, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->camped_mnc:I

    if-lez v5, :cond_6

    iget v5, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->camped_mnc:I

    const/16 v8, 0x3e7

    if-le v5, v8, :cond_9

    :cond_6
    const-string v5, "not valid camped mcc/mnc"

    invoke-virtual {p0, v5}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->log(Ljava/lang/String;)V

    :goto_1
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_7

    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_7

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_7

    const-string v5, "persist.radio.camped_mccmnc"

    invoke-static {v5, v0}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "PROPERTY_CAMPED_MCCMNC set: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->log(Ljava/lang/String;)V

    :cond_7
    const/4 v3, 0x0

    .end local v0    # "camped_mccmnc":Ljava/lang/String;
    .end local v4    # "prop_mccmnc":Ljava/lang/String;
    :goto_2
    return v3

    :cond_8
    move v5, v7

    goto/16 :goto_0

    .restart local v0    # "camped_mccmnc":Ljava/lang/String;
    .restart local v4    # "prop_mccmnc":Ljava/lang/String;
    :cond_9
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v8, Ljava/util/Locale;->US:Ljava/util/Locale;

    const-string v9, "%03d"

    new-array v10, v7, [Ljava/lang/Object;

    iget v11, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->camped_mcc:I

    invoke-static {v11}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    aput-object v11, v10, v6

    invoke-static {v8, v9, v10}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    sget-object v9, Ljava/util/Locale;->US:Ljava/util/Locale;

    if-nez v2, :cond_a

    const-string v5, "%02d"

    :goto_3
    new-array v7, v7, [Ljava/lang/Object;

    iget v10, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->camped_mnc:I

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    aput-object v10, v7, v6

    invoke-static {v9, v5, v7}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    :cond_a
    const-string v5, "%03d"

    goto :goto_3

    .end local v0    # "camped_mccmnc":Ljava/lang/String;
    .end local v4    # "prop_mccmnc":Ljava/lang/String;
    :cond_b
    array-length v5, v1

    if-ne v5, v10, :cond_c

    aget v5, v1, v6

    iput v5, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->mm_reject_cause:I

    aget v5, v1, v7

    iput v5, p0, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->gmm_reject_cause:I

    const/4 v3, 0x0

    const-string v5, "It may be not working!!!"

    invoke-virtual {p0, v5}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->log(Ljava/lang/String;)V

    goto :goto_2

    :cond_c
    array-length v5, v1

    const/4 v6, 0x5

    if-eq v5, v6, :cond_d

    array-length v5, v1

    const/4 v6, 0x6

    if-ne v5, v6, :cond_e

    :cond_d
    invoke-direct {p0, v1}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->getRejectValueFromUnsol([I)I

    move-result v3

    goto :goto_2

    :cond_e
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[LGE] updateValuesFromNewtork() error ints.length = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    array-length v6, v1

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/lge/telephony/KrRejectCause/RejectCauseBase;->log(Ljava/lang/String;)V

    const/4 v3, -0x1

    goto :goto_2
.end method
