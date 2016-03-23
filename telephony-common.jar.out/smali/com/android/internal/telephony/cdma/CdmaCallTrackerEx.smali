.class public Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;
.super Lcom/android/internal/telephony/cdma/CdmaCallTracker;
.source "CdmaCallTrackerEx.java"


# static fields
.field private static final ACTION_LGT_OTA_RES_NOTIF_FAIL:Ljava/lang/String; = "com.lge.intent.action.LGT_OTA_RES_NOTIF_FAIL"

.field private static final DBG_POLL:Z


# instance fields
.field mIntentReceiver:Landroid/content/BroadcastReceiver;


# direct methods
.method public constructor <init>(Lcom/android/internal/telephony/cdma/CDMAPhone;)V
    .locals 6
    .param p1, "phone"    # Lcom/android/internal/telephony/cdma/CDMAPhone;

    .prologue
    const/16 v5, 0x1a

    const/4 v4, 0x0

    .line 59
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/cdma/CdmaCallTracker;-><init>(Lcom/android/internal/telephony/cdma/CDMAPhone;)V

    .line 412
    new-instance v1, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx$1;

    invoke-direct {v1, p0}, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx$1;-><init>(Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;)V

    iput-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mIntentReceiver:Landroid/content/BroadcastReceiver;

    .line 62
    const-string v1, "KDDI"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 63
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v2, 0x15

    invoke-interface {v1, p0, v2, v4}, Lcom/android/internal/telephony/CommandsInterface;->registerForT53ReleaseInfoKddi(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 67
    :cond_0
    const-string v1, "KDDI"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 68
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .line 69
    .local v0, "AOCRFilter":Landroid/content/IntentFilter;
    const-string v1, "com.lge.intent.action.AOCR_RECEIVED_KDDI"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 70
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mIntentReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v1, v2, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 71
    const-string v1, "1"

    const-string v2, "ro.debuggable"

    const-string v3, "0"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 72
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v1, p0, v5, v4}, Lcom/android/internal/telephony/CommandsInterface;->registerForSignalInfo(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 77
    .end local v0    # "AOCRFilter":Landroid/content/IntentFilter;
    :cond_1
    const-string v1, "CTC"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 78
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v2, 0x19

    invoke-interface {v1, p0, v2, v4}, Lcom/android/internal/telephony/CommandsInterface;->registerForLineControlInfo(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 79
    const-string v1, "1"

    const-string v2, "ro.debuggable"

    const-string v3, "0"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 80
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v1, p0, v5, v4}, Lcom/android/internal/telephony/CommandsInterface;->registerForSignalInfo(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 84
    :cond_2
    return-void
.end method

.method static synthetic access$000(Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;

    .prologue
    .line 50
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->pollCallsWhenSafe()V

    return-void
.end method

.method private convertPlusToNumber(Ljava/lang/String;)Ljava/lang/String;
    .locals 10
    .param p1, "phoneNumber"    # Ljava/lang/String;

    .prologue
    const/4 v7, 0x2

    const/4 v9, 0x1

    const/4 v8, 0x0

    .line 431
    new-array v2, v7, [Ljava/lang/String;

    const-string v6, "0"

    aput-object v6, v2, v8

    const-string v6, "010"

    aput-object v6, v2, v9

    .line 432
    .local v2, "kddi_prefix_plus":[Ljava/lang/String;
    new-array v3, v7, [Ljava/lang/String;

    const-string v6, "184"

    aput-object v6, v3, v8

    const-string v6, "186"

    aput-object v6, v3, v9

    .line 433
    .local v3, "kddi_prefixs":[Ljava/lang/String;
    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0, p1}, Ljava/lang/StringBuffer;-><init>(Ljava/lang/String;)V

    .line 434
    .local v0, "buffer":Ljava/lang/StringBuffer;
    const-string v5, ""

    .line 437
    .local v5, "prefix":Ljava/lang/String;
    if-eqz p1, :cond_0

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-eqz v6, :cond_1

    :cond_0
    move-object v4, p1

    .line 463
    .end local p1    # "phoneNumber":Ljava/lang/String;
    .local v4, "phoneNumber":Ljava/lang/String;
    :goto_0
    return-object v4

    .line 441
    .end local v4    # "phoneNumber":Ljava/lang/String;
    .restart local p1    # "phoneNumber":Ljava/lang/String;
    :cond_1
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_1
    array-length v6, v3

    if-ge v1, v6, :cond_2

    .line 443
    aget-object v6, v3, v1

    invoke-virtual {p1, v6}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_4

    .line 444
    aget-object v5, v3, v1

    .line 450
    :cond_2
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v6

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v7

    if-ge v6, v7, :cond_3

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v6

    invoke-virtual {p1, v6}, Ljava/lang/String;->charAt(I)C

    move-result v6

    const/16 v7, 0x2b

    if-ne v6, v7, :cond_3

    .line 452
    const-string v6, "+81"

    invoke-virtual {p1, v6}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v6

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v7

    if-ne v6, v7, :cond_5

    .line 453
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v6

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v7

    add-int/lit8 v7, v7, 0x3

    aget-object v8, v2, v8

    invoke-virtual {v0, v6, v7, v8}, Ljava/lang/StringBuffer;->replace(IILjava/lang/String;)Ljava/lang/StringBuffer;

    .line 461
    :cond_3
    :goto_2
    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object p1

    move-object v4, p1

    .line 463
    .end local p1    # "phoneNumber":Ljava/lang/String;
    .restart local v4    # "phoneNumber":Ljava/lang/String;
    goto :goto_0

    .line 441
    .end local v4    # "phoneNumber":Ljava/lang/String;
    .restart local p1    # "phoneNumber":Ljava/lang/String;
    :cond_4
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 457
    :cond_5
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v6

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v7

    add-int/lit8 v7, v7, 0x1

    aget-object v8, v2, v9

    invoke-virtual {v0, v6, v7, v8}, Ljava/lang/StringBuffer;->replace(IILjava/lang/String;)Ljava/lang/StringBuffer;

    goto :goto_2
.end method

.method private handleCdmaReleaseInfoKddi()V
    .locals 3

    .prologue
    .line 386
    const/4 v0, 0x0

    .line 387
    .local v0, "call":Lcom/android/internal/telephony/cdma/CdmaCall;
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mRingingCall:Lcom/android/internal/telephony/cdma/CdmaCall;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/CdmaCall;->isIdle()Z

    move-result v1

    if-nez v1, :cond_3

    .line 388
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mRingingCall:Lcom/android/internal/telephony/cdma/CdmaCall;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/CdmaCall;->getState()Lcom/android/internal/telephony/Call$State;

    move-result-object v1

    sget-object v2, Lcom/android/internal/telephony/Call$State;->INCOMING:Lcom/android/internal/telephony/Call$State;

    if-ne v1, v2, :cond_2

    .line 389
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mRingingCall:Lcom/android/internal/telephony/cdma/CdmaCall;

    .line 400
    :cond_0
    :goto_0
    if-eqz v0, :cond_1

    .line 401
    :try_start_0
    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->hangup(Lcom/android/internal/telephony/cdma/CdmaCall;)V

    .line 404
    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/CdmaCall;->onHangupRemoteKddi()V
    :try_end_0
    .catch Lcom/android/internal/telephony/CallStateException; {:try_start_0 .. :try_end_0} :catch_0

    .line 408
    :cond_1
    :goto_1
    return-void

    .line 390
    :cond_2
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mRingingCall:Lcom/android/internal/telephony/cdma/CdmaCall;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/CdmaCall;->getState()Lcom/android/internal/telephony/Call$State;

    move-result-object v1

    sget-object v2, Lcom/android/internal/telephony/Call$State;->WAITING:Lcom/android/internal/telephony/Call$State;

    if-ne v1, v2, :cond_0

    .line 391
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mForegroundCall:Lcom/android/internal/telephony/cdma/CdmaCall;

    goto :goto_0

    .line 393
    :cond_3
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mForegroundCall:Lcom/android/internal/telephony/cdma/CdmaCall;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/CdmaCall;->isIdle()Z

    move-result v1

    if-nez v1, :cond_4

    .line 394
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mForegroundCall:Lcom/android/internal/telephony/cdma/CdmaCall;

    goto :goto_0

    .line 395
    :cond_4
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mBackgroundCall:Lcom/android/internal/telephony/cdma/CdmaCall;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/CdmaCall;->isIdle()Z

    move-result v1

    if-nez v1, :cond_0

    .line 396
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mBackgroundCall:Lcom/android/internal/telephony/cdma/CdmaCall;

    goto :goto_0

    .line 406
    :catch_0
    move-exception v1

    goto :goto_1
.end method

.method private processDialString(Ljava/lang/String;)Ljava/lang/String;
    .locals 7
    .param p1, "dialString"    # Ljava/lang/String;

    .prologue
    .line 209
    const-string v4, "CdmaCallTracker"

    const-string v5, "processDialString()..."

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 211
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 212
    const-string v4, "CdmaCallTracker"

    const-string v5, "dialString is empty"

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->w(Ljava/lang/String;Ljava/lang/String;)I

    move-object v0, p1

    .line 250
    :cond_0
    :goto_0
    return-object v0

    .line 216
    :cond_1
    move-object v0, p1

    .line 219
    .local v0, "convertDialString":Ljava/lang/String;
    invoke-static {p1}, Landroid/telephony/PhoneNumberUtils;->isVoiceMailNumber(Ljava/lang/String;)Z

    move-result v3

    .line 220
    .local v3, "isVoiceMailCall":Z
    invoke-static {p1}, Lcom/lge/telephony/LGSpecialNumberUtils;->is611DialNumber(Ljava/lang/String;)Z

    move-result v2

    .line 222
    .local v2, "is611number":Z
    if-eqz v3, :cond_2

    .line 223
    invoke-static {p1}, Lcom/lge/telephony/LGSpecialNumberUtils;->convertInternationalVoiceMailNumber(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 225
    const-string v4, "CdmaCallTracker"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "convertInternationalVoiceMailNumber() dialString = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ", convertDialString = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 228
    :cond_2
    if-eqz v2, :cond_3

    .line 229
    invoke-static {p1}, Lcom/lge/telephony/LGSpecialNumberUtils;->convertInternational611Number(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 231
    const-string v4, "CdmaCallTracker"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "convertInternational611Number() dialString = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ", convertDialString = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 237
    :cond_3
    const/4 v4, 0x0

    const-string v5, "support_assisted_dialing"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 239
    :try_start_0
    const-string v4, "CdmaCallTracker"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "dialString matches with + :  "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "+"

    invoke-virtual {p1, v6}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 240
    const-string v4, "CdmaCallTracker"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "CdmaCallTracker Dial() *** before Assisted Dial Number: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 242
    iget-object v4, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v4}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-static {v4}, Lcom/lge/telephony/utils/AssistedDialUtils;->getInstance(Landroid/content/Context;)Lcom/lge/telephony/utils/AssistedDialUtils;

    move-result-object v4

    invoke-virtual {v4, p1}, Lcom/lge/telephony/utils/AssistedDialUtils;->getAssistedDialFinalNumberForCDMA(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 244
    const-string v4, "CdmaCallTracker"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "CdmaCallTracker Dial()  *** after Assisted Dial Number: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/util/regex/PatternSyntaxException; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_0

    .line 245
    :catch_0
    move-exception v1

    .line 246
    .local v1, "e":Ljava/util/regex/PatternSyntaxException;
    const-string v4, "CdmaCallTracker"

    const-string v5, "PatternSyntaxException"

    invoke-static {v4, v5}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0
.end method

.method private removeRoamingCallBackString(Ljava/lang/String;)Ljava/lang/String;
    .locals 8
    .param p1, "phoneNumber"    # Ljava/lang/String;

    .prologue
    .line 469
    const-string v4, "**133*86"

    .line 470
    .local v4, "roamingPrefix":Ljava/lang/String;
    const-string v3, "#"

    .line 471
    .local v3, "roamingPostfix":Ljava/lang/String;
    move-object v2, p1

    .line 473
    .local v2, "removePhoneNumber":Ljava/lang/String;
    if-eqz p1, :cond_0

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6

    if-eqz v6, :cond_1

    :cond_0
    move-object v1, p1

    .line 484
    .end local p1    # "phoneNumber":Ljava/lang/String;
    .local v1, "phoneNumber":Ljava/lang/String;
    :goto_0
    return-object v1

    .line 477
    .end local v1    # "phoneNumber":Ljava/lang/String;
    .restart local p1    # "phoneNumber":Ljava/lang/String;
    :cond_1
    invoke-virtual {p1, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_2

    invoke-virtual {p1, v3}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v6

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v7

    add-int/lit8 v7, v7, -0x1

    if-ne v6, v7, :cond_2

    .line 478
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v5

    .line 479
    .local v5, "startIndex":I
    invoke-virtual {p1, v3}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v0

    .line 480
    .local v0, "endIndex":I
    invoke-virtual {p1, v5, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    .line 482
    .end local v0    # "endIndex":I
    .end local v5    # "startIndex":I
    :cond_2
    move-object p1, v2

    .line 483
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "removeRoamingCallBackString : phoneNumber is "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " removePhoneNumber: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p0, v6}, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->log(Ljava/lang/String;)V

    move-object v1, p1

    .line 484
    .end local p1    # "phoneNumber":Ljava/lang/String;
    .restart local v1    # "phoneNumber":Ljava/lang/String;
    goto :goto_0
.end method


# virtual methods
.method protected actionLgtOtaResNotifFail(I)V
    .locals 3
    .param p1, "causeCode"    # I

    .prologue
    .line 368
    const/16 v2, 0x10

    if-eq v2, p1, :cond_0

    .line 369
    new-instance v1, Landroid/content/Intent;

    const-string v2, "com.lge.intent.action.LGT_OTA_RES_NOTIF_FAIL"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 370
    .local v1, "failIntent":Landroid/content/Intent;
    const/4 v0, 0x0

    .line 371
    .local v0, "ctx":Landroid/content/Context;
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v2}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v0

    .line 373
    if-eqz v0, :cond_0

    .line 374
    sget-object v2, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    .line 377
    .end local v0    # "ctx":Landroid/content/Context;
    .end local v1    # "failIntent":Landroid/content/Intent;
    :cond_0
    return-void
.end method

.method public dialForVolte(Ljava/lang/String;)Z
    .locals 6
    .param p1, "dialString"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x1

    .line 116
    const-string v4, "ril.cdma.inecmmode"

    const-string v5, "false"

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 117
    .local v0, "inEcm":Ljava/lang/String;
    const-string v4, "true"

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    .line 118
    .local v2, "isPhoneInEcmMode":Z
    iget-object v4, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v4}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-static {v4, p1}, Landroid/telephony/PhoneNumberUtils;->isLocalEmergencyNumber(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    .line 121
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

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->log(Ljava/lang/String;)V

    .line 124
    if-eqz v2, :cond_0

    if-eqz v1, :cond_0

    .line 125
    invoke-virtual {p0, v3}, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->handleEcmTimer(I)V

    .line 128
    :cond_0
    iget-object v4, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v4}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v4

    invoke-static {v4, p1}, Landroid/telephony/PhoneNumberUtils;->isLocalEmergencyNumber(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 129
    const-string v4, "isInEmergencyCall set to true on dialForVolte()"

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->log(Ljava/lang/String;)V

    .line 130
    const-string v4, "ril.cdma.emergencyCall"

    const-string v5, "true"

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 136
    :goto_0
    if-eqz v2, :cond_1

    if-eqz v2, :cond_3

    if-eqz v1, :cond_3

    .line 141
    :cond_1
    :goto_1
    return v3

    .line 132
    :cond_2
    const-string v4, "ril.cdma.emergencyCall"

    const-string v5, "false"

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 139
    :cond_3
    iget-object v4, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v4, v3}, Lcom/android/internal/telephony/cdma/CDMAPhone;->setIsE911ForVolte(Z)V

    .line 140
    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v3}, Lcom/android/internal/telephony/cdma/CDMAPhone;->exitEmergencyCallbackMode()V

    .line 141
    const/4 v3, 0x0

    goto :goto_1
.end method

.method public dispose()V
    .locals 3

    .prologue
    .line 88
    const-string v0, "KDDI"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 89
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForT53ReleaseInfoKddi(Landroid/os/Handler;)V

    .line 93
    :cond_0
    const-string v0, "KDDI"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 94
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mIntentReceiver:Landroid/content/BroadcastReceiver;

    if-eqz v0, :cond_1

    .line 95
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mIntentReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 97
    :cond_1
    const-string v0, "1"

    const-string v1, "ro.debuggable"

    const-string v2, "0"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 98
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForSignalInfo(Landroid/os/Handler;)V

    .line 103
    :cond_2
    const-string v0, "CTC"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 104
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForLineControlInfo(Landroid/os/Handler;)V

    .line 105
    const-string v0, "1"

    const-string v1, "ro.debuggable"

    const-string v2, "0"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 106
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForSignalInfo(Landroid/os/Handler;)V

    .line 111
    :cond_3
    invoke-super {p0}, Lcom/android/internal/telephony/cdma/CdmaCallTracker;->dispose()V

    .line 112
    return-void
.end method

.method protected getDialStringForOperator(Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .param p1, "dialString"    # Ljava/lang/String;

    .prologue
    .line 162
    const-string v2, "CTC"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v2}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getServiceState()Landroid/telephony/ServiceState;

    move-result-object v2

    invoke-virtual {v2}, Landroid/telephony/ServiceState;->getRoaming()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 163
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->removeRoamingCallBackString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 168
    :cond_0
    const-string v2, "KDDI"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 169
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->convertPlusToNumber(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 170
    const-string v2, "CdmaCallTracker"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "convertPlusToNumber()... dialString = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 175
    :cond_1
    const-string v2, "VZW"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 176
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->processDialString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 181
    :cond_2
    const/4 v2, 0x0

    const-string v3, "support_smart_dialing"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_5

    .line 182
    if-eqz p1, :cond_5

    .line 184
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    const/16 v3, 0xa

    if-le v2, v3, :cond_3

    const/4 v2, 0x0

    invoke-virtual {p1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v2

    const/16 v3, 0x2b

    if-eq v2, v3, :cond_4

    :cond_3
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v2}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/telephony/utils/AssistedDialUtils;->getInstance(Landroid/content/Context;)Lcom/lge/telephony/utils/AssistedDialUtils;

    invoke-static {p1}, Lcom/lge/telephony/utils/AssistedDialUtils;->isNanpSimplified(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_5

    .line 189
    :cond_4
    invoke-static {p1}, Landroid/telephony/PhoneNumberUtils;->isVoiceMailNumber(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_6

    .line 190
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v2}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/telephony/utils/AssistedDialUtils;->getInstance(Landroid/content/Context;)Lcom/lge/telephony/utils/AssistedDialUtils;

    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v2}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/telephony/utils/AssistedDialUtils;->getAssistedDialCurrentCountry(Landroid/content/Context;)Lcom/lge/telephony/LGReferenceCountry;

    move-result-object v0

    .line 191
    .local v0, "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    if-eqz v0, :cond_5

    .line 192
    invoke-virtual {v0}, Lcom/lge/telephony/LGReferenceCountry;->getNanp()Ljava/lang/String;

    move-result-object v2

    const-string v3, "0"

    invoke-static {v2, v3}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_5

    .line 193
    invoke-virtual {v0}, Lcom/lge/telephony/LGReferenceCountry;->getIddPrefix()Ljava/lang/String;

    move-result-object v1

    .line 194
    .local v1, "current_Idd":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "1"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v3}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getLine1Number()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 204
    .end local v0    # "currentCountry":Lcom/lge/telephony/LGReferenceCountry;
    .end local v1    # "current_Idd":Ljava/lang/String;
    :cond_5
    :goto_0
    return-object p1

    .line 198
    :cond_6
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v2}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/telephony/utils/AssistedDialUtils;->getInstance(Landroid/content/Context;)Lcom/lge/telephony/utils/AssistedDialUtils;

    move-result-object v2

    invoke-virtual {v2, p1}, Lcom/lge/telephony/utils/AssistedDialUtils;->getAssistedDialFinalNumberForCDMA(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    goto :goto_0
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 10
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v9, 0x3

    const/4 v8, 0x1

    .line 298
    iget-object v6, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    iget-boolean v6, v6, Lcom/android/internal/telephony/cdma/CDMAPhone;->mIsTheCurrentActivePhone:Z

    if-nez v6, :cond_1

    .line 299
    const-string v6, "CdmaCallTracker"

    const-string v7, "Ignoring events received on inactive CdmaPhone"

    invoke-static {v6, v7}, Landroid/telephony/Rlog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 364
    :cond_0
    :goto_0
    return-void

    .line 302
    :cond_1
    iget v6, p1, Landroid/os/Message;->what:I

    packed-switch v6, :pswitch_data_0

    .line 362
    :pswitch_0
    invoke-super {p0, p1}, Lcom/android/internal/telephony/cdma/CdmaCallTracker;->handleMessage(Landroid/os/Message;)V

    goto :goto_0

    .line 305
    :pswitch_1
    iget-object v6, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mPendingMO:Lcom/android/internal/telephony/cdma/CdmaConnection;

    if-nez v6, :cond_2

    .line 306
    invoke-direct {p0}, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->handleCdmaReleaseInfoKddi()V

    goto :goto_0

    .line 308
    :cond_2
    new-instance v4, Landroid/os/Message;

    invoke-direct {v4}, Landroid/os/Message;-><init>()V

    .line 309
    .local v4, "newMessage":Landroid/os/Message;
    iget-object v6, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    iput-object v6, v4, Landroid/os/Message;->obj:Ljava/lang/Object;

    .line 310
    iget v6, p1, Landroid/os/Message;->what:I

    iput v6, v4, Landroid/os/Message;->what:I

    .line 311
    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->sendMessage(Landroid/os/Message;)Z

    goto :goto_0

    .line 317
    .end local v4    # "newMessage":Landroid/os/Message;
    :pswitch_2
    iget-object v2, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v2, Landroid/os/AsyncResult;

    .line 318
    .local v2, "ar":Landroid/os/AsyncResult;
    iget-object v6, v2, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v6, :cond_0

    .line 319
    iget-object v6, v2, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v6, Lcom/android/internal/telephony/cdma/CdmaInformationRecords$CdmaLineControlInfoRec;

    move-object v0, v6

    check-cast v0, Lcom/android/internal/telephony/cdma/CdmaInformationRecords$CdmaLineControlInfoRec;

    .line 320
    .local v0, "LineCtrlInfoRec":Lcom/android/internal/telephony/cdma/CdmaInformationRecords$CdmaLineControlInfoRec;
    if-eqz v0, :cond_0

    .line 321
    const-string v6, "CdmaCallTracker"

    const-string v7, "Event EVENT_FWIM_LINECTRL_INFO_RECEIVED Received"

    invoke-static {v6, v7}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 322
    iget-byte v6, v0, Lcom/android/internal/telephony/cdma/CdmaInformationRecords$CdmaLineControlInfoRec;->lineCtrlPolarityIncluded:B

    if-ne v6, v8, :cond_0

    iget-byte v6, v0, Lcom/android/internal/telephony/cdma/CdmaInformationRecords$CdmaLineControlInfoRec;->lineCtrlToggle:B

    if-nez v6, :cond_0

    iget-byte v6, v0, Lcom/android/internal/telephony/cdma/CdmaInformationRecords$CdmaLineControlInfoRec;->lineCtrlReverse:B

    if-nez v6, :cond_0

    iget-byte v6, v0, Lcom/android/internal/telephony/cdma/CdmaInformationRecords$CdmaLineControlInfoRec;->lineCtrlPowerDenial:B

    if-nez v6, :cond_0

    .line 326
    iput-boolean v8, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mIsReceivedLineCtrl:Z

    .line 327
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->pollCallsWhenSafe()V

    goto :goto_0

    .line 333
    .end local v0    # "LineCtrlInfoRec":Lcom/android/internal/telephony/cdma/CdmaInformationRecords$CdmaLineControlInfoRec;
    .end local v2    # "ar":Landroid/os/AsyncResult;
    :pswitch_3
    iget-object v2, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v2, Landroid/os/AsyncResult;

    .line 334
    .restart local v2    # "ar":Landroid/os/AsyncResult;
    iget-object v6, v2, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v6, :cond_0

    .line 335
    const-string v6, "gsm.operator.numeric"

    const-string v7, ""

    invoke-static {v6, v7}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 336
    .local v5, "operatorNumeric":Ljava/lang/String;
    if-eqz v5, :cond_0

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v6

    if-le v6, v9, :cond_0

    .line 337
    const/4 v6, 0x0

    invoke-virtual {v5, v6, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    .line 338
    .local v3, "mcc":Ljava/lang/String;
    iget-object v6, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v6}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getServiceState()Landroid/telephony/ServiceState;

    move-result-object v6

    invoke-virtual {v6}, Landroid/telephony/ServiceState;->getRoaming()Z

    move-result v6

    if-nez v6, :cond_0

    const-string v6, "450"

    invoke-virtual {v3, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_0

    .line 339
    iget-object v6, v2, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v6, Lcom/android/internal/telephony/cdma/CdmaInformationRecords$CdmaSignalInfoRec;

    move-object v1, v6

    check-cast v1, Lcom/android/internal/telephony/cdma/CdmaInformationRecords$CdmaSignalInfoRec;

    .line 340
    .local v1, "SignalInfoRec":Lcom/android/internal/telephony/cdma/CdmaInformationRecords$CdmaSignalInfoRec;
    if-eqz v1, :cond_0

    .line 341
    const-string v6, "CdmaCallTracker"

    const-string v7, "Event EVENT_FWIM_SIGNAL_INFO_RECEIVED Received"

    invoke-static {v6, v7}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 342
    iget v6, v1, Lcom/android/internal/telephony/cdma/CdmaInformationRecords$CdmaSignalInfoRec;->signalType:I

    if-nez v6, :cond_0

    iget v6, v1, Lcom/android/internal/telephony/cdma/CdmaInformationRecords$CdmaSignalInfoRec;->alertPitch:I

    if-nez v6, :cond_0

    iget v6, v1, Lcom/android/internal/telephony/cdma/CdmaInformationRecords$CdmaSignalInfoRec;->signal:I

    const/16 v7, 0x3f

    if-ne v6, v7, :cond_0

    .line 345
    const-string v6, "CTC"

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_3

    .line 346
    iput-boolean v8, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mIsReceivedLineCtrl:Z

    .line 349
    :cond_3
    const-string v6, "KDDI"

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_4

    .line 350
    iput-boolean v8, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mIsReceivedAocr:Z

    .line 353
    :cond_4
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->pollCallsWhenSafe()V

    goto/16 :goto_0

    .line 302
    :pswitch_data_0
    .packed-switch 0x15
        :pswitch_1
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method public hangUpForVolte(Z)Z
    .locals 2
    .param p1, "isE911WithEcbm"    # Z

    .prologue
    .line 146
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "hangUpForVolte() - isE911WithEcbm="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->log(Ljava/lang/String;)V

    .line 149
    iget-boolean v0, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mIsEcmTimerCanceled:Z

    if-eqz v0, :cond_0

    .line 150
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->handleEcmTimer(I)V

    .line 153
    :cond_0
    const-string v0, "isInEmergencyCall set to false on hangUpForVolte()"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->log(Ljava/lang/String;)V

    .line 154
    const-string v0, "ril.cdma.emergencyCall"

    const-string v1, "false"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 156
    const/4 v0, 0x1

    return v0
.end method

.method protected ignoreInvalidThreeWayNumber()Z
    .locals 2

    .prologue
    .line 256
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mPendingMO:Lcom/android/internal/telephony/cdma/CdmaConnection;

    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/CdmaConnection;->getAddress()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mPendingMO:Lcom/android/internal/telephony/cdma/CdmaConnection;

    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/CdmaConnection;->getAddress()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mPendingMO:Lcom/android/internal/telephony/cdma/CdmaConnection;

    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/CdmaConnection;->getAddress()Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0x4e

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-ltz v0, :cond_1

    .line 259
    :cond_0
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mPendingMO:Lcom/android/internal/telephony/cdma/CdmaConnection;

    const/4 v1, 0x7

    iput v1, v0, Lcom/android/internal/telephony/cdma/CdmaConnection;->mCause:I

    .line 261
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "dialThreeWay : DisconnectCause.INVALID_NUMBER mPendingMO="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mPendingMO:Lcom/android/internal/telephony/cdma/CdmaConnection;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->log(Ljava/lang/String;)V

    .line 265
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->pollCallsWhenSafe()V

    .line 266
    const/4 v0, 0x1

    .line 268
    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method protected updatePhoneStateForOperator(Lcom/android/internal/telephony/PhoneConstants$State;)V
    .locals 3
    .param p1, "oldState"    # Lcom/android/internal/telephony/PhoneConstants$State;

    .prologue
    const/4 v2, 0x0

    .line 274
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mState:Lcom/android/internal/telephony/PhoneConstants$State;

    sget-object v1, Lcom/android/internal/telephony/PhoneConstants$State;->IDLE:Lcom/android/internal/telephony/PhoneConstants$State;

    if-eq v0, v1, :cond_0

    sget-object v0, Lcom/android/internal/telephony/PhoneConstants$State;->IDLE:Lcom/android/internal/telephony/PhoneConstants$State;

    if-ne p1, v0, :cond_1

    .line 275
    :cond_0
    iput-boolean v2, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mIsReceivedAocr:Z

    .line 279
    :cond_1
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mState:Lcom/android/internal/telephony/PhoneConstants$State;

    sget-object v1, Lcom/android/internal/telephony/PhoneConstants$State;->IDLE:Lcom/android/internal/telephony/PhoneConstants$State;

    if-eq v0, v1, :cond_2

    sget-object v0, Lcom/android/internal/telephony/PhoneConstants$State;->IDLE:Lcom/android/internal/telephony/PhoneConstants$State;

    if-ne p1, v0, :cond_3

    .line 280
    :cond_2
    iput-boolean v2, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mIsReceivedLineCtrl:Z

    .line 285
    :cond_3
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/CDMAPhone;->isInEcm()Z

    move-result v0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mState:Lcom/android/internal/telephony/PhoneConstants$State;

    sget-object v1, Lcom/android/internal/telephony/PhoneConstants$State;->IDLE:Lcom/android/internal/telephony/PhoneConstants$State;

    if-ne v0, v1, :cond_4

    .line 286
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/CDMAPhone;->isInEcmExitDelay()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 287
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;->mPhone:Lcom/android/internal/telephony/cdma/CDMAPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/CDMAPhone;->exitEmergencyCallbackMode()V

    .line 291
    :cond_4
    return-void
.end method
