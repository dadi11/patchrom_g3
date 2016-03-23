.class public Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;
.super Lcom/android/internal/telephony/gsm/GsmCallTracker;
.source "GsmCallTrackerEx.java"


# static fields
.field private static final DBG_POLL:Z


# instance fields
.field private mAssistDialPhoneNumberUtils:Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;

.field private mIsEcmTimerCanceled:Z

.field mPendingCallClirMode:I

.field mPendingCallInEcm:Z

.field mPendingCallUusInfo:Lcom/android/internal/telephony/UUSInfo;

.field private mPollTimeout:I

.field private mPollTimeoutCount:I

.field private mPollTimeoutExpired:Z


# direct methods
.method constructor <init>(Lcom/android/internal/telephony/gsm/GSMPhone;)V
    .locals 2
    .param p1, "phone"    # Lcom/android/internal/telephony/gsm/GSMPhone;

    .prologue
    const/4 v1, 0x0

    .line 61
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/gsm/GsmCallTracker;-><init>(Lcom/android/internal/telephony/gsm/GSMPhone;)V

    .line 44
    const/16 v0, 0x1388

    iput v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPollTimeout:I

    .line 45
    iput-boolean v1, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPollTimeoutExpired:Z

    .line 46
    iput v1, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPollTimeoutCount:I

    .line 50
    new-instance v0, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;

    invoke-direct {v0}, Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mAssistDialPhoneNumberUtils:Lcom/lge/telephony/LGAssistDialPhoneNumberUtils;

    .line 54
    iput-boolean v1, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mIsEcmTimerCanceled:Z

    .line 57
    iput-boolean v1, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPendingCallInEcm:Z

    .line 62
    return-void
.end method

.method private handleEcmTimer(I)V
    .locals 3
    .param p1, "action"    # I

    .prologue
    .line 230
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v0, p1}, Lcom/android/internal/telephony/gsm/GSMPhone;->handleTimerInEmergencyCallbackMode(I)V

    .line 231
    packed-switch p1, :pswitch_data_0

    .line 235
    const-string v0, "GsmCallTracker"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "handleEcmTimer, unsupported action "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 237
    :goto_0
    return-void

    .line 232
    :pswitch_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mIsEcmTimerCanceled:Z

    goto :goto_0

    .line 233
    :pswitch_1
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mIsEcmTimerCanceled:Z

    goto :goto_0

    .line 231
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private okUpdateCall(Lcom/android/internal/telephony/gsm/GsmConnection;Lcom/android/internal/telephony/DriverCall;)Z
    .locals 4
    .param p1, "conn"    # Lcom/android/internal/telephony/gsm/GsmConnection;
    .param p2, "dc"    # Lcom/android/internal/telephony/DriverCall;

    .prologue
    .line 299
    const/4 v0, 0x1

    .line 301
    .local v0, "needNotify":Z
    if-eqz p1, :cond_0

    if-nez p2, :cond_1

    .line 302
    :cond_0
    const-string v2, "GsmCallTracker"

    const-string v3, "exceptcallstate --> Call instance is null "

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    move v1, v0

    .line 313
    .end local v0    # "needNotify":Z
    .local v1, "needNotify":I
    :goto_0
    return v1

    .line 306
    .end local v1    # "needNotify":I
    .restart local v0    # "needNotify":Z
    :cond_1
    invoke-virtual {p1}, Lcom/android/internal/telephony/gsm/GsmConnection;->getState()Lcom/android/internal/telephony/Call$State;

    move-result-object v2

    sget-object v3, Lcom/android/internal/telephony/Call$State;->DISCONNECTING:Lcom/android/internal/telephony/Call$State;

    if-eq v2, v3, :cond_2

    invoke-virtual {p1}, Lcom/android/internal/telephony/gsm/GsmConnection;->getState()Lcom/android/internal/telephony/Call$State;

    move-result-object v2

    sget-object v3, Lcom/android/internal/telephony/Call$State;->DISCONNECTED:Lcom/android/internal/telephony/Call$State;

    if-ne v2, v3, :cond_4

    :cond_2
    iget-object v2, p2, Lcom/android/internal/telephony/DriverCall;->state:Lcom/android/internal/telephony/DriverCall$State;

    sget-object v3, Lcom/android/internal/telephony/DriverCall$State;->DIALING:Lcom/android/internal/telephony/DriverCall$State;

    if-eq v2, v3, :cond_3

    iget-object v2, p2, Lcom/android/internal/telephony/DriverCall;->state:Lcom/android/internal/telephony/DriverCall$State;

    sget-object v3, Lcom/android/internal/telephony/DriverCall$State;->INCOMING:Lcom/android/internal/telephony/DriverCall$State;

    if-eq v2, v3, :cond_3

    iget-object v2, p2, Lcom/android/internal/telephony/DriverCall;->state:Lcom/android/internal/telephony/DriverCall$State;

    sget-object v3, Lcom/android/internal/telephony/DriverCall$State;->WAITING:Lcom/android/internal/telephony/DriverCall$State;

    if-ne v2, v3, :cond_4

    .line 309
    :cond_3
    const/4 v0, 0x0

    .line 310
    const-string v2, "GsmCallTracker"

    const-string v3, "exceptcallstate --> It does not need to be updated"

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_4
    move v1, v0

    .line 313
    .restart local v1    # "needNotify":I
    goto :goto_0
.end method

.method private processDialString(Ljava/lang/String;)Ljava/lang/String;
    .locals 6
    .param p1, "dialString"    # Ljava/lang/String;

    .prologue
    .line 140
    const-string v3, "GsmCallTracker"

    const-string v4, "processDialString()..."

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 142
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 143
    const-string v3, "GsmCallTracker"

    const-string v4, "dialString is empty"

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->w(Ljava/lang/String;Ljava/lang/String;)I

    move-object v0, p1

    .line 181
    :cond_0
    :goto_0
    return-object v0

    .line 147
    :cond_1
    move-object v0, p1

    .line 150
    .local v0, "convertDialString":Ljava/lang/String;
    invoke-static {p1}, Landroid/telephony/PhoneNumberUtils;->isVoiceMailNumber(Ljava/lang/String;)Z

    move-result v2

    .line 151
    .local v2, "isVoiceMailCall":Z
    invoke-static {p1}, Lcom/lge/telephony/LGSpecialNumberUtils;->is611DialNumber(Ljava/lang/String;)Z

    move-result v1

    .line 154
    .local v1, "is611number":Z
    if-eqz v2, :cond_2

    .line 155
    invoke-static {p1}, Lcom/lge/telephony/LGSpecialNumberUtils;->convertInternationalVoiceMailNumber(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 157
    const-string v3, "GsmCallTracker"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "convertInternationalVoiceMailNumber() dialString = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", convertDialString = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 160
    :cond_2
    if-eqz v1, :cond_3

    .line 161
    invoke-static {p1}, Lcom/lge/telephony/LGSpecialNumberUtils;->convertInternational611Number(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 163
    const-string v3, "GsmCallTracker"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "covertInternational611Number() dialString = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", convertDialString = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 169
    :cond_3
    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v3}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v3

    const-string v4, "support_assisted_dialing"

    invoke-static {v3, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 171
    const-string v3, "GSMCallTracker "

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " ********** Dial() before Assisted Dial Number: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 172
    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v3}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3}, Lcom/lge/telephony/utils/AssistedDialUtils;->getInstance(Landroid/content/Context;)Lcom/lge/telephony/utils/AssistedDialUtils;

    move-result-object v3

    invoke-virtual {v3, p1}, Lcom/lge/telephony/utils/AssistedDialUtils;->getAssistedDialFinalNumberForGSM(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 173
    const-string v3, "GSMCallTracker "

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "******** Dial() after Assisted Dial Number: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 175
    invoke-static {v0, p1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 176
    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v3}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "assist_dial_new_number_check"

    const/4 v5, 0x0

    invoke-static {v3, v4, v5}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    goto/16 :goto_0

    .line 178
    :cond_4
    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v3}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "assist_dial_new_number_check"

    const/4 v5, 0x1

    invoke-static {v3, v4, v5}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    goto/16 :goto_0
.end method

.method private radioLogForMLT(Landroid/os/Message;)V
    .locals 7
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v3, 0x0

    .line 425
    const-string v5, "ro.debuggable"

    const-string v6, "0"

    invoke-static {v5, v6}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v6, "1"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    const/4 v3, 0x1

    .line 426
    .local v3, "isDebugMode":Z
    :cond_0
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 428
    .local v0, "ar":Landroid/os/AsyncResult;
    const/4 v4, 0x0

    .line 430
    .local v4, "mltRadioInfo":Ljava/lang/String;
    if-eqz v0, :cond_2

    iget-object v5, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    if-eqz v5, :cond_2

    .line 432
    :try_start_0
    iget-object v5, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v5, [Ljava/lang/String;

    check-cast v5, [Ljava/lang/String;

    const/4 v6, 0x0

    aget-object v4, v5, v6
    :try_end_0
    .catch Ljava/lang/ClassCastException; {:try_start_0 .. :try_end_0} :catch_0

    .line 442
    :goto_0
    const-string v5, "LOGRadioInfo : broadcast"

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->log(Ljava/lang/String;)V

    .line 444
    if-eqz v3, :cond_1

    .line 445
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "LOGRadioInfo : logRadioInfo     "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->log(Ljava/lang/String;)V

    .line 448
    :cond_1
    new-instance v2, Landroid/content/Intent;

    const-string v5, "com.lge.intent.action.LOG_RADIO_INFO"

    invoke-direct {v2, v5}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 449
    .local v2, "intent":Landroid/content/Intent;
    const/high16 v5, 0x20000000

    invoke-virtual {v2, v5}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 450
    const-string v5, "exceptionType"

    const/16 v6, 0x10

    invoke-virtual {v2, v5, v6}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .line 451
    const-string v5, "ModemLogData"

    invoke-virtual {v2, v5, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 452
    iget-object v5, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v5}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v5

    invoke-virtual {v5, v2}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    .line 453
    .end local v2    # "intent":Landroid/content/Intent;
    :goto_1
    return-void

    .line 433
    :catch_0
    move-exception v1

    .line 434
    .local v1, "ex":Ljava/lang/ClassCastException;
    goto :goto_1

    .line 437
    .end local v1    # "ex":Ljava/lang/ClassCastException;
    :cond_2
    const-string v5, "LOGRadioInfo : ar or ar.result = null"

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0
.end method


# virtual methods
.method protected cancelEcmTimerForEmergencyCall(ZZ)V
    .locals 2
    .param p1, "isPhoneInEcmMode"    # Z
    .param p2, "isEmergencyCall"    # Z

    .prologue
    .line 188
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "support_emergency_callback_mode_for_gsm"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 189
    if-eqz p1, :cond_0

    if-eqz p2, :cond_0

    .line 190
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->handleEcmTimer(I)V

    .line 193
    :cond_0
    return-void
.end method

.method public dialForVolte(Ljava/lang/String;)Z
    .locals 6
    .param p1, "dialString"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x1

    .line 70
    const-string v4, "ril.cdma.inecmmode"

    const-string v5, "false"

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 71
    .local v0, "inEcm":Ljava/lang/String;
    const-string v4, "true"

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    .line 72
    .local v2, "isPhoneInEcmMode":Z
    iget-object v4, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v4}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-static {v4, p1}, Landroid/telephony/PhoneNumberUtils;->isLocalEmergencyNumber(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    .line 75
    .local v1, "isEmergencyCall":Z
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "dialForVolte() - inEcm="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", isEmergencyCall="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->log(Ljava/lang/String;)V

    .line 78
    if-eqz v2, :cond_0

    if-eqz v1, :cond_0

    .line 79
    invoke-direct {p0, v3}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->handleEcmTimer(I)V

    .line 82
    :cond_0
    iget-object v4, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v4}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-static {v4, p1}, Landroid/telephony/PhoneNumberUtils;->isLocalEmergencyNumber(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 83
    const-string v4, "isInEmergencyCall set to true on dialForVolte()"

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->log(Ljava/lang/String;)V

    .line 84
    const-string v4, "ril.cdma.emergencyCall"

    const-string v5, "true"

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 90
    :goto_0
    if-eqz v2, :cond_1

    if-eqz v2, :cond_3

    if-eqz v1, :cond_3

    .line 95
    :cond_1
    :goto_1
    return v3

    .line 86
    :cond_2
    const-string v4, "ril.cdma.emergencyCall"

    const-string v5, "false"

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 93
    :cond_3
    iget-object v4, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v4, v3}, Lcom/android/internal/telephony/gsm/GSMPhone;->setIsE911ForVolte(Z)V

    .line 94
    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v3}, Lcom/android/internal/telephony/gsm/GSMPhone;->exitEmergencyCallbackMode()V

    .line 95
    const/4 v3, 0x0

    goto :goto_1
.end method

.method protected dialNormalCallInEcmMode(ZZILcom/android/internal/telephony/UUSInfo;)Z
    .locals 4
    .param p1, "isPhoneInEcmMode"    # Z
    .param p2, "isEmergencyCall"    # Z
    .param p3, "clirMode"    # I
    .param p4, "uusInfo"    # Lcom/android/internal/telephony/UUSInfo;

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 211
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v2}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v2

    const-string v3, "support_emergency_callback_mode_for_gsm"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 212
    if-eqz p1, :cond_0

    if-eqz p1, :cond_1

    if-eqz p2, :cond_1

    :cond_0
    move v0, v1

    .line 223
    :goto_0
    return v0

    .line 215
    :cond_1
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/GSMPhone;->exitEmergencyCallbackMode()V

    .line 216
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    const/16 v2, 0xe

    const/4 v3, 0x0

    invoke-virtual {v1, p0, v2, v3}, Lcom/android/internal/telephony/gsm/GSMPhone;->setOnEcbModeExitResponse(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 217
    iput p3, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPendingCallClirMode:I

    .line 218
    iput-object p4, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPendingCallUusInfo:Lcom/android/internal/telephony/UUSInfo;

    .line 219
    iput-boolean v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPendingCallInEcm:Z

    goto :goto_0

    :cond_2
    move v0, v1

    .line 223
    goto :goto_0
.end method

.method public dispose()V
    .locals 0

    .prologue
    .line 65
    invoke-super {p0}, Lcom/android/internal/telephony/gsm/GsmCallTracker;->dispose()V

    .line 66
    return-void
.end method

.method protected getDialStringForOperator(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "dialString"    # Ljava/lang/String;

    .prologue
    .line 117
    const-string v0, "VZW"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 118
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->processDialString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 123
    :cond_0
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "support_smart_dialing"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 124
    if-eqz p1, :cond_1

    .line 125
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/telephony/utils/AssistedDialUtils;->getInstance(Landroid/content/Context;)Lcom/lge/telephony/utils/AssistedDialUtils;

    invoke-static {p1}, Lcom/lge/telephony/utils/AssistedDialUtils;->isNanpSimplified(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 126
    invoke-static {p1}, Landroid/telephony/PhoneNumberUtils;->isVoiceMailNumber(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 127
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "+1"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/GSMPhone;->getLine1Number()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 135
    :cond_1
    :goto_0
    return-object p1

    .line 129
    :cond_2
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/lge/telephony/utils/AssistedDialUtils;->getInstance(Landroid/content/Context;)Lcom/lge/telephony/utils/AssistedDialUtils;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/lge/telephony/utils/AssistedDialUtils;->getAssistedDialFinalNumberForGSM(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    goto :goto_0
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 6
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v2, 0x1

    const/4 v5, 0x0

    .line 338
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    iget-boolean v0, v0, Lcom/android/internal/telephony/gsm/GSMPhone;->mIsTheCurrentActivePhone:Z

    if-nez v0, :cond_0

    .line 339
    const-string v0, "GsmCallTracker"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Received message "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p1, Landroid/os/Message;->what:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "] while being destroyed. Ignoring."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 386
    :goto_0
    return-void

    .line 343
    :cond_0
    iget v0, p1, Landroid/os/Message;->what:I

    sparse-switch v0, :sswitch_data_0

    .line 384
    invoke-super {p0, p1}, Lcom/android/internal/telephony/gsm/GsmCallTracker;->handleMessage(Landroid/os/Message;)V

    goto :goto_0

    .line 347
    :sswitch_0
    iget-boolean v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPendingCallInEcm:Z

    if-eqz v0, :cond_1

    .line 350
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPendingMO:Lcom/android/internal/telephony/gsm/GsmConnection;

    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/GsmConnection;->getAddress()Ljava/lang/String;

    move-result-object v1

    iget v2, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPendingCallClirMode:I

    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPendingCallUusInfo:Lcom/android/internal/telephony/UUSInfo;

    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->obtainCompleteMessage()Landroid/os/Message;

    move-result-object v4

    invoke-interface {v0, v1, v2, v3, v4}, Lcom/android/internal/telephony/CommandsInterface;->dial(Ljava/lang/String;ILcom/android/internal/telephony/UUSInfo;Landroid/os/Message;)V

    .line 351
    iput-boolean v5, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPendingCallInEcm:Z

    .line 353
    :cond_1
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v0, p0}, Lcom/android/internal/telephony/gsm/GSMPhone;->unsetOnEcbModeExitResponse(Landroid/os/Handler;)V

    goto :goto_0

    .line 359
    :sswitch_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "EVENT_POLL_DIAL_HANGUP_DONE: mPollTimeoutCount="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPollTimeoutCount:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", fgCall.getState()="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mForegroundCall:Lcom/android/internal/telephony/gsm/GsmCall;

    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/GsmCall;->getState()Lcom/android/internal/telephony/Call$State;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", mPendingOperations="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPendingOperations:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->log(Ljava/lang/String;)V

    .line 361
    iget v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPollTimeoutCount:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPollTimeoutCount:I

    .line 362
    iget v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPollTimeoutCount:I

    const/4 v1, 0x6

    if-ge v0, v1, :cond_2

    .line 363
    const/16 v0, 0x18

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    iget v1, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPollTimeout:I

    int-to-long v2, v1

    invoke-virtual {p0, v0, v2, v3}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->sendMessageDelayed(Landroid/os/Message;J)Z

    goto :goto_0

    .line 367
    :cond_2
    iput-boolean v2, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPollTimeoutExpired:Z

    .line 368
    iput v5, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPendingOperations:I

    .line 369
    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    iput-object v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mLastRelevantPoll:Landroid/os/Message;

    .line 370
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mLastRelevantPoll:Landroid/os/Message;

    invoke-interface {v0, v1}, Lcom/android/internal/telephony/CommandsInterface;->getCurrentCalls(Landroid/os/Message;)V

    .line 371
    iput v5, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPollTimeoutCount:I

    goto/16 :goto_0

    .line 378
    :sswitch_2
    const-string v0, "EVENT_LOG_RADIO_INFO_RECEIVED"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->log(Ljava/lang/String;)V

    .line 379
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->radioLogForMLT(Landroid/os/Message;)V

    goto/16 :goto_0

    .line 343
    :sswitch_data_0
    .sparse-switch
        0xe -> :sswitch_0
        0x18 -> :sswitch_1
        0x1b -> :sswitch_2
    .end sparse-switch
.end method

.method protected handleSrvccConn(ILcom/android/internal/telephony/DriverCall;)V
    .locals 2
    .param p1, "i"    # I
    .param p2, "dc"    # Lcom/android/internal/telephony/DriverCall;

    .prologue
    .line 280
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "support_srvcc"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->supportSRVCC(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 281
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mConnections:[Lcom/android/internal/telephony/gsm/GsmConnection;

    aget-object v0, v0, p1

    invoke-virtual {v0}, Lcom/android/internal/telephony/gsm/GsmConnection;->initSrvccHandover()V

    .line 282
    iget-boolean v0, p2, Lcom/android/internal/telephony/DriverCall;->isSrvccConfConn:Z

    if-eqz v0, :cond_0

    .line 283
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mConnections:[Lcom/android/internal/telephony/gsm/GsmConnection;

    aget-object v0, v0, p1

    const/4 v1, 0x1

    iput-boolean v1, v0, Lcom/android/internal/telephony/gsm/GsmConnection;->mIsSrvccConfConn:Z

    .line 284
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mConnections:[Lcom/android/internal/telephony/gsm/GsmConnection;

    aget-object v0, v0, p1

    invoke-static {v0}, Lcom/android/internal/telephony/LGSrvccManager;->setConfConn(Lcom/android/internal/telephony/Connection;)V

    .line 287
    :cond_0
    return-void
.end method

.method public hangUpForVolte(Z)Z
    .locals 2
    .param p1, "isE911WithEcbm"    # Z

    .prologue
    .line 100
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "hangUpForVolte() - isE911WithEcbm="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->log(Ljava/lang/String;)V

    .line 103
    iget-boolean v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mIsEcmTimerCanceled:Z

    if-eqz v0, :cond_0

    .line 104
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->handleEcmTimer(I)V

    .line 107
    :cond_0
    const-string v0, "isInEmergencyCall set to false on hangUpForVolte()"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->log(Ljava/lang/String;)V

    .line 108
    const-string v0, "ril.cdma.emergencyCall"

    const-string v1, "false"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 110
    const/4 v0, 0x1

    return v0
.end method

.method protected initPendingCallInEcm()V
    .locals 1

    .prologue
    .line 205
    iget-boolean v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPendingCallInEcm:Z

    if-eqz v0, :cond_0

    .line 206
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPendingCallInEcm:Z

    .line 208
    :cond_0
    return-void
.end method

.method protected pollCallsWhenCallTimeoutLGU(Landroid/os/Message;)V
    .locals 2
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 405
    iget v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPendingOperations:I

    if-lez v0, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPendingMO:Lcom/android/internal/telephony/gsm/GsmConnection;

    if-eqz v0, :cond_0

    iget v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPollTimeoutCount:I

    if-lez v0, :cond_0

    .line 406
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "msg.what="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p1, Landroid/os/Message;->what:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", mForegroundCall.getState()"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mForegroundCall:Lcom/android/internal/telephony/gsm/GsmCall;

    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/GsmCall;->getState()Lcom/android/internal/telephony/Call$State;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", mPendingOperations"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPendingOperations:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", mPollTimeoutCount="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPollTimeoutCount:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->log(Ljava/lang/String;)V

    .line 409
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    iput-object v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mLastRelevantPoll:Landroid/os/Message;

    .line 410
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mLastRelevantPoll:Landroid/os/Message;

    invoke-interface {v0, v1}, Lcom/android/internal/telephony/CommandsInterface;->getCurrentCalls(Landroid/os/Message;)V

    .line 413
    :cond_0
    return-void
.end method

.method protected restartEcmTimer()V
    .locals 2

    .prologue
    .line 196
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "support_emergency_callback_mode_for_gsm"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 198
    iget-boolean v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mIsEcmTimerCanceled:Z

    if-eqz v0, :cond_0

    .line 199
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->handleEcmTimer(I)V

    .line 202
    :cond_0
    return-void
.end method

.method protected sendIntentWhenStkCcModifiedNumber(Landroid/os/AsyncResult;)V
    .locals 4
    .param p1, "ar"    # Landroid/os/AsyncResult;

    .prologue
    .line 390
    iget-object v0, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    .line 392
    .local v0, "e":Ljava/lang/Throwable;
    if-eqz v0, :cond_0

    instance-of v2, v0, Lcom/android/internal/telephony/CommandException;

    if-eqz v2, :cond_0

    check-cast v0, Lcom/android/internal/telephony/CommandException;

    .end local v0    # "e":Ljava/lang/Throwable;
    invoke-virtual {v0}, Lcom/android/internal/telephony/CommandException;->getCommandError()Lcom/android/internal/telephony/CommandException$Error;

    move-result-object v2

    sget-object v3, Lcom/android/internal/telephony/CommandException$Error;->DIAL_MODIFIED_TO_DIAL:Lcom/android/internal/telephony/CommandException$Error;

    if-ne v2, v3, :cond_0

    .line 394
    const-string v2, "GsmCallTracker"

    const-string v3, "VOICE_STK_CC_MODIFIED - send broadcast"

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 396
    new-instance v1, Landroid/content/Intent;

    const-string v2, "com.lge.android.intent.action.voice_stk_cc_modified"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 397
    .local v1, "intent":Landroid/content/Intent;
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v2}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v2

    sget-object v3, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v2, v1, v3}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    .line 399
    .end local v1    # "intent":Landroid/content/Intent;
    :cond_0
    return-void
.end method

.method protected sendRadioLogForMLT()V
    .locals 3

    .prologue
    .line 418
    const/4 v0, 0x0

    const-string v1, "SUPPORT_LOG_RF_INFO"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 419
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    const v1, 0xc0002

    const/16 v2, 0x1b

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->obtainMessage(I)Landroid/os/Message;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/android/internal/telephony/gsm/GSMPhone;->getModemStringItem(ILandroid/os/Message;)V

    .line 421
    :cond_0
    return-void
.end method

.method protected startOpDonePoll()V
    .locals 5

    .prologue
    const/16 v2, 0x18

    const/4 v4, 0x0

    .line 242
    const-string v0, "KR"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 243
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "startOpDonePoll mPollTimeout="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPollTimeout:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", mPollTimeoutExpired="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPollTimeoutExpired:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->log(Ljava/lang/String;)V

    .line 244
    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->removeMessages(I)V

    .line 245
    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    iget v1, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPollTimeout:I

    int-to-long v2, v1

    invoke-virtual {p0, v0, v2, v3}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->sendMessageDelayed(Landroid/os/Message;J)Z

    .line 246
    iput-boolean v4, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPollTimeoutExpired:Z

    .line 247
    iput v4, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPollTimeoutCount:I

    .line 249
    :cond_0
    return-void
.end method

.method protected stopOpDonePoll()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 251
    const-string v0, "KR"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 252
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "stopOpDonePoll mPollTimeout="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPollTimeout:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", mPollTimeoutExpired="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPollTimeoutExpired:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->log(Ljava/lang/String;)V

    .line 253
    const/16 v0, 0x18

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->removeMessages(I)V

    .line 254
    iput-boolean v2, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPollTimeoutExpired:Z

    .line 255
    iput v2, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPollTimeoutCount:I

    .line 257
    :cond_0
    return-void
.end method

.method protected timeOutLGU(ILcom/android/internal/telephony/gsm/GsmConnection;)Z
    .locals 4
    .param p1, "i"    # I
    .param p2, "conn"    # Lcom/android/internal/telephony/gsm/GsmConnection;

    .prologue
    const/16 v3, 0xd

    const/4 v0, 0x0

    .line 319
    iget-boolean v1, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPollTimeoutExpired:Z

    if-eqz v1, :cond_0

    .line 321
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "mPollTimeoutExpired is trigger "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPollTimeoutExpired:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->log(Ljava/lang/String;)V

    .line 322
    iput v3, p2, Lcom/android/internal/telephony/gsm/GsmConnection;->mCause:I

    .line 323
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mDroppedDuringPoll:Ljava/util/ArrayList;

    invoke-virtual {v1, p1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 324
    invoke-virtual {p2, v3}, Lcom/android/internal/telephony/gsm/GsmConnection;->onDisconnect(I)Z

    .line 325
    iput-boolean v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPollTimeoutExpired:Z

    .line 326
    const/4 v0, 0x1

    .line 328
    :cond_0
    return v0
.end method

.method protected updatePhoneStateForOperator()V
    .locals 2

    .prologue
    .line 262
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/gsm/GSMPhone;->isInEcm()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mState:Lcom/android/internal/telephony/PhoneConstants$State;

    sget-object v1, Lcom/android/internal/telephony/PhoneConstants$State;->IDLE:Lcom/android/internal/telephony/PhoneConstants$State;

    if-ne v0, v1, :cond_0

    .line 263
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/gsm/GSMPhone;->isInEcmExitDelay()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 264
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/gsm/GSMPhone;->exitEmergencyCallbackMode()V

    .line 270
    :cond_0
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->mState:Lcom/android/internal/telephony/PhoneConstants$State;

    sget-object v1, Lcom/android/internal/telephony/PhoneConstants$State;->IDLE:Lcom/android/internal/telephony/PhoneConstants$State;

    if-ne v0, v1, :cond_1

    .line 272
    const-string v0, "isInEmergencyCall set to false updatePhoneState "

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GsmCallTrackerEx;->log(Ljava/lang/String;)V

    .line 273
    const-string v0, "ril.cdma.emergencyCall"

    const-string v1, "false"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 276
    :cond_1
    return-void
.end method
