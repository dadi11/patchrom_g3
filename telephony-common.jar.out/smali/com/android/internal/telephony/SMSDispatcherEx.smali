.class public abstract Lcom/android/internal/telephony/SMSDispatcherEx;
.super Lcom/android/internal/telephony/SMSDispatcher;
.source "SMSDispatcherEx.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/internal/telephony/SMSDispatcherEx$PendingMessage;
    }
.end annotation


# static fields
.field protected static final ADDRESS_TRANSLATION_FAILURE:I = 0x1

.field protected static final DELIVERYPENDINGLISTFORKDDI:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;",
            ">;"
        }
    .end annotation
.end field

.field protected static final DOMAIN_STATUS_CS_IMS:I = 0x2

.field protected static final DOMAIN_STATUS_CS_ONLY:I = 0x0

.field protected static final DOMAIN_STATUS_IMS_ONLY:I = 0x1

.field protected static final EMERGENCY_CALL_STARTS_NOTIFICATION:I = 0x10

.field protected static final EMERGENCY_CALL_STOPS_NOTIFICATION:I = 0x20

.field protected static final EVENT_RETRY_ALERT_TIMEOUT:I = 0x12d

.field protected static final EVENT_SEND_RETRY_CBMI:I = 0x131

.field protected static final EVENT_SEND_RETRY_CONFIRMED_SMS:I = 0x12e

.field protected static final EVENT_SEND_RETRY_WITHPOPUP:I = 0x130

.field protected static final EVENT_STOP_RETRY_SENDING:I = 0x12f

.field protected static final EVENT_VOICE_CALL_STARTED:I = 0x132

.field protected static final GENERAL_PROBLEMS:I = 0x0

.field private static final MAX_SEND_RETRIES:I

.field protected static final MSG_NOT_SENT:I = 0x5

.field protected static final MSG_TOO_LONG_FORNEWORK:I = 0x4

.field protected static final NETWORK_PROBLEMS:I = 0x1

.field protected static final NO_DOMAIN_NOTIFICATION_CHANGE:I = 0xf

.field protected static final NUMBER_OF_CAUSE_CODE:I = 0x33

.field static final SEND_RETRY_DELAY:I

.field protected static final SERVICE_NOT_AVAILABLE:I = 0x2

.field protected static final SERVICE_NOT_SUPPORTED:I = 0x3

.field protected static final SMS_NETWORK_FAILURE:I = 0x3

.field protected static final SMS_NOT_SUPPORTED:I = 0x64

.field protected static final SMS_ORIGINATION_DENIED:I = 0x61

.field private static final SMS_RETRY_POPUP_DISP_TIMEOUT:I = 0x2710

.field static isInProgressWithUserPermit:[Z

.field public static mSubmitIsRoaming:Z

.field public static mSubmitPriority:I

.field protected static sCBNumber:Ljava/lang/String;


# instance fields
.field private causeCodeArray:[J

.field private mCDG2CauseCodesTable:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private mCauseCodesTable:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private mPendingMessagesList:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/android/internal/telephony/SMSDispatcherEx$PendingMessage;",
            ">;"
        }
    .end annotation
.end field

.field private mRetryListener:Landroid/content/DialogInterface$OnClickListener;

.field mSTrackersForRetry:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;",
            ">;"
        }
    .end annotation
.end field

.field protected mSyncronousSending:Z


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .prologue
    const/4 v4, 0x3

    const/4 v3, 0x1

    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 187
    const-string v0, "doNotUse_AP_retry"

    invoke-static {v1, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-ne v0, v3, :cond_0

    .line 188
    sput v2, Lcom/android/internal/telephony/SMSDispatcherEx;->MAX_SEND_RETRIES:I

    .line 210
    :goto_0
    const-string v0, "vzw_sms_retry_scheme"

    invoke-static {v1, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-ne v0, v3, :cond_2

    .line 211
    const/16 v0, 0x7530

    sput v0, Lcom/android/internal/telephony/SMSDispatcherEx;->SEND_RETRY_DELAY:I

    .line 219
    :goto_1
    sput v2, Lcom/android/internal/telephony/SMSDispatcherEx;->mSubmitPriority:I

    .line 223
    sput-boolean v2, Lcom/android/internal/telephony/SMSDispatcherEx;->mSubmitIsRoaming:Z

    .line 227
    const/4 v0, 0x5

    new-array v0, v0, [Z

    sput-object v0, Lcom/android/internal/telephony/SMSDispatcherEx;->isInProgressWithUserPermit:[Z

    .line 256
    sput-object v1, Lcom/android/internal/telephony/SMSDispatcherEx;->sCBNumber:Ljava/lang/String;

    .line 658
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/android/internal/telephony/SMSDispatcherEx;->DELIVERYPENDINGLISTFORKDDI:Ljava/util/ArrayList;

    return-void

    .line 190
    :cond_0
    const-string v0, "vzw_sms_retry_scheme"

    invoke-static {v1, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-ne v0, v3, :cond_1

    .line 199
    sput v4, Lcom/android/internal/telephony/SMSDispatcherEx;->MAX_SEND_RETRIES:I

    goto :goto_0

    .line 202
    :cond_1
    sput v4, Lcom/android/internal/telephony/SMSDispatcherEx;->MAX_SEND_RETRIES:I

    goto :goto_0

    .line 213
    :cond_2
    const/16 v0, 0x7d0

    sput v0, Lcom/android/internal/telephony/SMSDispatcherEx;->SEND_RETRY_DELAY:I

    goto :goto_1
.end method

.method protected constructor <init>(Lcom/android/internal/telephony/PhoneBase;Lcom/android/internal/telephony/SmsUsageMonitor;Lcom/android/internal/telephony/ImsSMSDispatcher;)V
    .locals 3
    .param p1, "phone"    # Lcom/android/internal/telephony/PhoneBase;
    .param p2, "usageMonitor"    # Lcom/android/internal/telephony/SmsUsageMonitor;
    .param p3, "imsSMSDispatcher"    # Lcom/android/internal/telephony/ImsSMSDispatcher;

    .prologue
    const/4 v2, 0x1

    .line 270
    invoke-direct {p0, p1, p2, p3}, Lcom/android/internal/telephony/SMSDispatcher;-><init>(Lcom/android/internal/telephony/PhoneBase;Lcom/android/internal/telephony/SmsUsageMonitor;Lcom/android/internal/telephony/ImsSMSDispatcher;)V

    .line 147
    const/16 v0, 0x33

    new-array v0, v0, [J

    fill-array-data v0, :array_0

    iput-object v0, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->causeCodeArray:[J

    .line 180
    new-instance v0, Ljava/util/ArrayList;

    sget v1, Lcom/android/internal/telephony/SMSDispatcherEx;->MO_MSG_QUEUE_LIMIT:I

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mSTrackersForRetry:Ljava/util/ArrayList;

    .line 432
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mCauseCodesTable:Ljava/util/HashMap;

    .line 445
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mCDG2CauseCodesTable:Ljava/util/HashMap;

    .line 1371
    new-instance v0, Lcom/android/internal/telephony/SMSDispatcherEx$1;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/SMSDispatcherEx$1;-><init>(Lcom/android/internal/telephony/SMSDispatcherEx;)V

    iput-object v0, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mRetryListener:Landroid/content/DialogInterface$OnClickListener;

    .line 272
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPendingMessagesList:Ljava/util/ArrayList;

    .line 273
    iget-object v0, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const-string v1, "sms_gcf_config"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-ne v0, v2, :cond_2

    .line 274
    const-string v0, "SMSDispatcher(), Creator KEY_SMS_GCF_CONFIG is Defined -> AsyncronousSending"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 275
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mSyncronousSending:Z

    .line 285
    :goto_0
    iget-object v0, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const-string v1, "cdma_cause_code_display"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-ne v0, v2, :cond_0

    .line 286
    invoke-direct {p0}, Lcom/android/internal/telephony/SMSDispatcherEx;->initializeCauseCodesHashMap()V

    .line 290
    :cond_0
    iget-object v0, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const-string v1, "cdma_sms_cdg2"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-ne v0, v2, :cond_1

    .line 291
    invoke-direct {p0}, Lcom/android/internal/telephony/SMSDispatcherEx;->initializeCDG2CauseCodesHashMap()V

    .line 295
    :cond_1
    return-void

    .line 277
    :cond_2
    const-string v0, "SMSDispatcher(), Creator KEY_SMS_GCF_CONFIG is NOT Defined -> SyncronousSending"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 278
    const-string v0, "persist.radio.sms_sync_sending"

    invoke-static {v0, v2}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    iput-boolean v0, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mSyncronousSending:Z

    goto :goto_0

    .line 147
    nop

    :array_0
    .array-data 8
        0x0
        0x1
        0x2
        0x3
        0x4
        0x5
        0x6
        0x1f
        0x20
        0x21
        0x22
        0x23
        0x24
        0x25
        0x26
        0x27
        0x28
        0x2f
        0x30
        0x3f
        0x40
        0x41
        0x42
        0x43
        0x5f
        0x60
        0x61
        0x62
        0x63
        0x64
        0x65
        0x66
        0x67
        0x68
        0x69
        0x6a
        0x6b
        0x6c
        0xff
        0x8000
        0x8001
        0x8002
        0x8003
        0x8004
        0x8005
        0x8006
        0x8007
        0x8008
        0x8009
        0x800a
        0x800b
    .end array-data
.end method

.method private cdmaCauseCodeDisplayFunc(I)V
    .locals 13
    .param p1, "errorCode"    # I

    .prologue
    .line 663
    int-to-long v2, p1

    .line 665
    .local v2, "causeCode":J
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "cdmaCauseCodeDisplayFunc(), [SMS.MO.ERROR] causeCode : "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 667
    const/4 v6, 0x0

    .line 668
    .local v6, "displayCauseCode":I
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v9

    .line 669
    .local v9, "rsrc":Landroid/content/res/Resources;
    const-string v8, ""

    .line 670
    .local v8, "failReasonStr":Ljava/lang/String;
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "("

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    sget v11, Lcom/lge/internal/R$string;->STR_res_CAUSECODE_NORMAL:I

    invoke-virtual {v9, v11}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, " : "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-static {v2, v3}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ")"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 671
    .local v5, "causeCodeStr":Ljava/lang/String;
    sget v10, Lcom/lge/internal/R$array;->STR_res_SMSCAUSECODE_NORMAL:I

    invoke-virtual {v9, v10}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object v4

    .line 673
    .local v4, "causeCodeItems":[Ljava/lang/String;
    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/SMSDispatcherEx;->getDisplayOfCauseCode(J)I

    move-result v6

    .line 676
    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/SMSDispatcherEx;->informTranslateCauseCode(J)I

    move-result v10

    const/16 v11, 0x33

    if-eq v10, v11, :cond_0

    .line 677
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "[SMS.MO.ERROR] CAUSECODE, Cause Code : "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, "("

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-direct {p0, v2, v3}, Lcom/android/internal/telephony/SMSDispatcherEx;->informTranslateCauseCode(J)I

    move-result v11

    aget-object v11, v4, v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ")"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 681
    :cond_0
    :try_start_0
    iget-object v10, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mCauseCodesTable:Ljava/util/HashMap;

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v10

    move-object v0, v10

    check-cast v0, Ljava/lang/String;

    move-object v8, v0

    .line 682
    iget-object v10, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, "\n"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    const/4 v12, 0x1

    invoke-static {v10, v11, v12}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v10

    invoke-virtual {v10}, Landroid/widget/Toast;->show()V
    :try_end_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_0

    .line 686
    :goto_0
    return-void

    .line 683
    :catch_0
    move-exception v7

    .line 684
    .local v7, "e":Ljava/lang/NullPointerException;
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "cdmaCauseCodeDisplayFunc(), [SMS.MO.ERROR] Invalid display CauseCode : "

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-static {v10}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    goto :goto_0
.end method

.method private getDisplayOfCauseCode(J)I
    .locals 7
    .param p1, "causeCode"    # J

    .prologue
    .line 689
    const/16 v1, 0x33

    .line 690
    .local v1, "displayIndex":I
    const/4 v0, 0x0

    .local v0, "arrayIndex":I
    :goto_0
    const/16 v3, 0x33

    if-ge v0, v3, :cond_5

    .line 691
    iget-object v3, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->causeCodeArray:[J

    aget-wide v4, v3, v0

    cmp-long v3, p1, v4

    if-nez v3, :cond_4

    .line 692
    if-ltz v0, :cond_0

    const/4 v3, 0x7

    if-gt v0, v3, :cond_0

    .line 693
    const/4 v1, 0x1

    :goto_1
    move v2, v1

    .line 706
    .end local v1    # "displayIndex":I
    .local v2, "displayIndex":I
    :goto_2
    return v2

    .line 694
    .end local v2    # "displayIndex":I
    .restart local v1    # "displayIndex":I
    :cond_0
    const/16 v3, 0x1a

    if-ne v0, v3, :cond_1

    .line 695
    const/4 v1, 0x2

    goto :goto_1

    .line 696
    :cond_1
    const/16 v3, 0x1d

    if-ne v0, v3, :cond_2

    .line 697
    const/4 v1, 0x3

    goto :goto_1

    .line 698
    :cond_2
    const/16 v3, 0x23

    if-ne v0, v3, :cond_3

    .line 699
    const/4 v1, 0x4

    goto :goto_1

    .line 701
    :cond_3
    const/4 v1, 0x0

    goto :goto_1

    .line 690
    :cond_4
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_5
    move v2, v1

    .line 706
    .end local v1    # "displayIndex":I
    .restart local v2    # "displayIndex":I
    goto :goto_2
.end method

.method public static getSmsIsRoaming()Z
    .locals 2

    .prologue
    .line 1504
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "SMSDispatcherEx : getSmsIsRoaming(), get value = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-boolean v1, Lcom/android/internal/telephony/SMSDispatcherEx;->mSubmitIsRoaming:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1505
    sget-boolean v0, Lcom/android/internal/telephony/SMSDispatcherEx;->mSubmitIsRoaming:Z

    return v0
.end method

.method private handleSendFailForCDG2(Landroid/os/AsyncResult;Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;)V
    .locals 10
    .param p1, "ar"    # Landroid/os/AsyncResult;
    .param p2, "tracker"    # Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    .prologue
    const/4 v9, 0x1

    .line 1696
    const/4 v3, 0x0

    .line 1698
    .local v3, "errorCode":I
    iget-object v6, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    if-eqz v6, :cond_0

    .line 1699
    iget-object v6, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v6, Lcom/android/internal/telephony/SmsResponse;

    iget v3, v6, Lcom/android/internal/telephony/SmsResponse;->mErrorCode:I

    .line 1702
    :cond_0
    const/4 v2, 0x1

    .line 1704
    .local v2, "error":I
    iget-object v6, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    check-cast v6, Lcom/android/internal/telephony/CommandException;

    check-cast v6, Lcom/android/internal/telephony/CommandException;

    invoke-virtual {v6}, Lcom/android/internal/telephony/CommandException;->getCommandError()Lcom/android/internal/telephony/CommandException$Error;

    move-result-object v6

    sget-object v7, Lcom/android/internal/telephony/CommandException$Error;->FDN_CHECK_FAILURE:Lcom/android/internal/telephony/CommandException$Error;

    if-ne v6, v7, :cond_1

    .line 1705
    const/4 v2, 0x6

    .line 1709
    :cond_1
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "handleSendComplete(), [SMS.MO.CDG2] SMSDispatcher2"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const-string v8, "cdma_sms_cdg2"

    invoke-static {v7, v8}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1710
    move v0, v3

    .line 1711
    .local v0, "causeCode":I
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v5

    .line 1712
    .local v5, "r":Landroid/content/res/Resources;
    const-string v4, ""

    .line 1713
    .local v4, "failReasonStr":Ljava/lang/String;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    sget v7, Lcom/lge/internal/R$string;->STR_res_CAUSECODE_NORMAL:I

    invoke-virtual {v5, v7}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " : "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-static {v0}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1715
    .local v1, "causeCodeStr":Ljava/lang/String;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "handleSendComplete(), [SMS.MO.CDG2] causeCode => "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1717
    sparse-switch v0, :sswitch_data_0

    .line 1737
    :goto_0
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "handleSendComplete(), [SMS.MO.CDG2]  CDG final error"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1739
    iget-object v6, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    invoke-virtual {p2, v6, v2, v3}, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->onFailed(Landroid/content/Context;II)V

    .line 1742
    iget-boolean v6, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mSyncronousSending:Z

    if-eqz v6, :cond_2

    .line 1743
    invoke-virtual {p0}, Lcom/android/internal/telephony/SMSDispatcherEx;->processNextPendingMessage()V

    .line 1746
    :cond_2
    return-void

    .line 1719
    :sswitch_0
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    sget v7, Lcom/lge/internal/R$string;->sp_unknown_destination_address_SHORT:I

    invoke-virtual {v5, v7}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "\n"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 1721
    iget-object v6, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, v9}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v6

    invoke-virtual {v6}, Landroid/widget/Toast;->show()V

    goto :goto_0

    .line 1724
    :sswitch_1
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    sget v7, Lcom/lge/internal/R$string;->sp_ms_originated_sms_denied_SHORT:I

    invoke-virtual {v5, v7}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "\n"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 1726
    iget-object v6, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, v9}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v6

    invoke-virtual {v6}, Landroid/widget/Toast;->show()V

    goto/16 :goto_0

    .line 1729
    :sswitch_2
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    sget v7, Lcom/lge/internal/R$string;->STR_res_SERVICENOTSUPPORTED_NORMAL:I

    invoke-virtual {v5, v7}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "\n"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 1731
    iget-object v6, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, v9}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v6

    invoke-virtual {v6}, Landroid/widget/Toast;->show()V

    goto/16 :goto_0

    .line 1717
    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_0
        0x61 -> :sswitch_1
        0x64 -> :sswitch_2
    .end sparse-switch
.end method

.method private handleSendSmsForSendRawPdu(Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;)V
    .locals 4
    .param p1, "tracker"    # Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    .prologue
    .line 1122
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneBase;->getServiceState()Landroid/telephony/ServiceState;

    move-result-object v1

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getState()I

    move-result v0

    .line 1127
    .local v0, "ss":I
    const/4 v1, 0x1

    invoke-virtual {p0}, Lcom/android/internal/telephony/SMSDispatcherEx;->checkNotInService()Z

    move-result v2

    if-ne v1, v2, :cond_0

    .line 1131
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/android/internal/telephony/SMSDispatcherEx;->getNotInServiceError(I)I

    move-result v2

    const/4 v3, 0x0

    invoke-virtual {p1, v1, v2, v3}, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->onFailed(Landroid/content/Context;II)V

    .line 1143
    :goto_0
    return-void

    .line 1135
    :cond_0
    iget-boolean v1, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mSyncronousSending:Z

    if-eqz v1, :cond_1

    .line 1136
    new-instance v1, Lcom/android/internal/telephony/SMSDispatcherEx$PendingMessage;

    invoke-direct {v1, p1}, Lcom/android/internal/telephony/SMSDispatcherEx$PendingMessage;-><init>(Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;)V

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/SMSDispatcherEx;->enqueueMessageForSending(Lcom/android/internal/telephony/SMSDispatcherEx$PendingMessage;)V

    goto :goto_0

    .line 1140
    :cond_1
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendSms(Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;)V

    goto :goto_0
.end method

.method private handleUserPermitForSendRawPdu(Lcom/android/internal/telephony/SmsHeader;Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;)V
    .locals 3
    .param p1, "smsHeader"    # Lcom/android/internal/telephony/SmsHeader;
    .param p2, "tracker"    # Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    .prologue
    const/4 v2, 0x4

    .line 1147
    iget-object v0, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const-string v1, "modify_check_confirm_popup_concat_message_mo"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1148
    invoke-virtual {p0, p1, p2}, Lcom/android/internal/telephony/SMSDispatcherEx;->inProgressConcatMoWithoutUserPermit(Lcom/android/internal/telephony/SmsHeader;Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1149
    invoke-virtual {p0, p1, p2, v2}, Lcom/android/internal/telephony/SMSDispatcherEx;->processUserPermitConsideringConcat(Lcom/android/internal/telephony/SmsHeader;Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;I)V

    .line 1155
    :cond_0
    :goto_0
    return-void

    .line 1153
    :cond_1
    invoke-virtual {p0, v2, p2}, Lcom/android/internal/telephony/SMSDispatcherEx;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendMessage(Landroid/os/Message;)Z

    goto :goto_0
.end method

.method private informTranslateCauseCode(J)I
    .locals 5
    .param p1, "causeCode"    # J

    .prologue
    const/16 v1, 0x33

    .line 710
    const/4 v0, 0x0

    .local v0, "arrayIndex":I
    :goto_0
    if-ge v0, v1, :cond_1

    .line 711
    iget-object v2, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->causeCodeArray:[J

    aget-wide v2, v2, v0

    cmp-long v2, p1, v2

    if-nez v2, :cond_0

    .line 715
    .end local v0    # "arrayIndex":I
    :goto_1
    return v0

    .line 710
    .restart local v0    # "arrayIndex":I
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    move v0, v1

    .line 715
    goto :goto_1
.end method

.method private initializeCDG2CauseCodesHashMap()V
    .locals 4

    .prologue
    .line 447
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    .line 448
    .local v0, "rsrc":Landroid/content/res/Resources;
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mCDG2CauseCodesTable:Ljava/util/HashMap;

    const/4 v2, 0x1

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    sget v3, Lcom/lge/internal/R$string;->sp_unknown_destination_address_SHORT:I

    invoke-virtual {v0, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 449
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mCDG2CauseCodesTable:Ljava/util/HashMap;

    const/16 v2, 0x61

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    sget v3, Lcom/lge/internal/R$string;->sp_ms_originated_sms_denied_SHORT:I

    invoke-virtual {v0, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 450
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mCDG2CauseCodesTable:Ljava/util/HashMap;

    const/16 v2, 0x64

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    sget v3, Lcom/lge/internal/R$string;->STR_res_SERVICENOTSUPPORTED_NORMAL:I

    invoke-virtual {v0, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 451
    return-void
.end method

.method private initializeCauseCodesHashMap()V
    .locals 4

    .prologue
    .line 434
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    .line 435
    .local v0, "rsrc":Landroid/content/res/Resources;
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mCauseCodesTable:Ljava/util/HashMap;

    const/4 v2, 0x0

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    sget v3, Lcom/lge/internal/R$string;->STR_res_GENERALPROBLEMS_NORMAL:I

    invoke-virtual {v0, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 436
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mCauseCodesTable:Ljava/util/HashMap;

    const/4 v2, 0x1

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    sget v3, Lcom/lge/internal/R$string;->STR_res_NETWORKPROBLEMS_NORMAL:I

    invoke-virtual {v0, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 437
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mCauseCodesTable:Ljava/util/HashMap;

    const/4 v2, 0x2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    sget v3, Lcom/lge/internal/R$string;->STR_res_SERVICENOTAVAILABLE_NORMAL:I

    invoke-virtual {v0, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 438
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mCauseCodesTable:Ljava/util/HashMap;

    const/4 v2, 0x3

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    sget v3, Lcom/lge/internal/R$string;->STR_res_SERVICENOTSUPPORTED_NORMAL:I

    invoke-virtual {v0, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 439
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mCauseCodesTable:Ljava/util/HashMap;

    const/4 v2, 0x4

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    sget v3, Lcom/lge/internal/R$string;->STR_res_MSGTOOLONGFORNEWORK_NORMAL:I

    invoke-virtual {v0, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 440
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mCauseCodesTable:Ljava/util/HashMap;

    const/4 v2, 0x5

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    sget v3, Lcom/lge/internal/R$string;->STR_res_MSGNOTSENT_NORMAL:I

    invoke-virtual {v0, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 441
    return-void
.end method

.method private isAvailableNetworkForDCN()Z
    .locals 3

    .prologue
    .line 1594
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mTelephonyManager:Landroid/telephony/TelephonyManager;

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getVoiceNetworkType()I

    move-result v0

    .line 1595
    .local v0, "curVoiceNetwork":I
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "isAvailableNetworkForDCN, curVoiceNetwork: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1596
    const/4 v1, 0x4

    if-eq v0, v1, :cond_0

    const/4 v1, 0x5

    if-eq v0, v1, :cond_0

    const/4 v1, 0x6

    if-eq v0, v1, :cond_0

    const/4 v1, 0x7

    if-eq v0, v1, :cond_0

    const/16 v1, 0xc

    if-ne v0, v1, :cond_1

    .line 1601
    :cond_0
    const/4 v1, 0x1

    .line 1603
    :goto_0
    return v1

    :cond_1
    const/4 v1, 0x0

    goto :goto_0
.end method

.method private isDestinationFreeShortCode(Ljava/lang/String;)Z
    .locals 8
    .param p1, "destAddr"    # Ljava/lang/String;

    .prologue
    const/4 v7, 0x3

    const/4 v6, 0x2

    const/4 v4, 0x1

    .line 1666
    iget-object v5, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPremiumSmsRule:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v5}, Ljava/util/concurrent/atomic/AtomicInteger;->get()I

    move-result v1

    .line 1667
    .local v1, "rule":I
    const/4 v3, 0x0

    .line 1669
    .local v3, "smsCategory":I
    if-eq v1, v4, :cond_0

    if-ne v1, v7, :cond_3

    .line 1670
    :cond_0
    iget-object v5, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mTelephonyManager:Landroid/telephony/TelephonyManager;

    invoke-virtual {v5}, Landroid/telephony/TelephonyManager;->getSimCountryIso()Ljava/lang/String;

    move-result-object v2

    .line 1671
    .local v2, "simCountryIso":Ljava/lang/String;
    if-eqz v2, :cond_1

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v5

    if-eq v5, v6, :cond_2

    .line 1672
    :cond_1
    const-string v5, "Can\'t get SIM country Iso: trying network country Iso"

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .line 1673
    iget-object v5, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mTelephonyManager:Landroid/telephony/TelephonyManager;

    invoke-virtual {v5}, Landroid/telephony/TelephonyManager;->getNetworkCountryIso()Ljava/lang/String;

    move-result-object v2

    .line 1675
    :cond_2
    iget-object v5, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mUsageMonitor:Lcom/android/internal/telephony/SmsUsageMonitor;

    invoke-virtual {v5, p1, v2}, Lcom/android/internal/telephony/SmsUsageMonitor;->checkDestination(Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    .line 1677
    .end local v2    # "simCountryIso":Ljava/lang/String;
    :cond_3
    if-eq v1, v6, :cond_4

    if-ne v1, v7, :cond_7

    .line 1678
    :cond_4
    iget-object v5, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mTelephonyManager:Landroid/telephony/TelephonyManager;

    invoke-virtual {v5}, Landroid/telephony/TelephonyManager;->getNetworkCountryIso()Ljava/lang/String;

    move-result-object v0

    .line 1679
    .local v0, "networkCountryIso":Ljava/lang/String;
    if-eqz v0, :cond_5

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v5

    if-eq v5, v6, :cond_6

    .line 1680
    :cond_5
    const-string v5, "Can\'t get Network country Iso: trying SIM country Iso"

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .line 1681
    iget-object v5, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mTelephonyManager:Landroid/telephony/TelephonyManager;

    invoke-virtual {v5}, Landroid/telephony/TelephonyManager;->getSimCountryIso()Ljava/lang/String;

    move-result-object v0

    .line 1683
    :cond_6
    iget-object v5, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mUsageMonitor:Lcom/android/internal/telephony/SmsUsageMonitor;

    invoke-virtual {v5, p1, v0}, Lcom/android/internal/telephony/SmsUsageMonitor;->checkDestination(Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    invoke-static {v3, v5}, Lcom/android/internal/telephony/SmsUsageMonitor;->mergeShortCodeCategories(II)I

    move-result v3

    .line 1686
    .end local v0    # "networkCountryIso":Ljava/lang/String;
    :cond_7
    if-ne v3, v4, :cond_8

    .line 1687
    const-string v5, "It is a FREE short code"

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1690
    :goto_0
    return v4

    :cond_8
    const/4 v4, 0x0

    goto :goto_0
.end method

.method private routeRetrySendingForVzw(Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;)V
    .locals 4
    .param p1, "tracker"    # Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    .prologue
    const/4 v3, 0x3

    .line 629
    invoke-virtual {p1}, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->isMultipart()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 630
    const-string v1, "handleSendComplete(), Send ReTry : This is Multipart Message"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 631
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "handleSendComplete(), Send EVENT_SEND_RETRY mImsRetry: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p1, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mImsRetry:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 633
    iget v1, p1, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mRetryCount:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p1, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mRetryCount:I

    .line 634
    invoke-virtual {p0, v3, p1}, Lcom/android/internal/telephony/SMSDispatcherEx;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    .line 635
    .local v0, "retryMsg":Landroid/os/Message;
    sget v1, Lcom/android/internal/telephony/SMSDispatcherEx;->SEND_RETRY_DELAY:I

    int-to-long v2, v1

    invoke-virtual {p0, v0, v2, v3}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendMessageDelayed(Landroid/os/Message;J)Z

    .line 636
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "handleSendComplete(), Send EVENT_SEND_RETRY mRetryCount: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p1, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mRetryCount:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 654
    :goto_0
    return-void

    .line 638
    .end local v0    # "retryMsg":Landroid/os/Message;
    :cond_0
    const-string v1, "handleSendComplete(), Send ReTry : This is Single part Message"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 639
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "handleSendComplete(), Send EVENT_SEND_RETRY mImsRetry: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p1, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mImsRetry:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 640
    iget v1, p1, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mImsRetry:I

    if-lez v1, :cond_1

    .line 641
    const-string v1, "handleSendComplete(), First send attempt was SMS over IMS"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 643
    iget v1, p1, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mRetryCount:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p1, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mRetryCount:I

    .line 644
    invoke-virtual {p0, v3, p1}, Lcom/android/internal/telephony/SMSDispatcherEx;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    .line 645
    .restart local v0    # "retryMsg":Landroid/os/Message;
    sget v1, Lcom/android/internal/telephony/SMSDispatcherEx;->SEND_RETRY_DELAY:I

    int-to-long v2, v1

    invoke-virtual {p0, v0, v2, v3}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendMessageDelayed(Landroid/os/Message;J)Z

    .line 646
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "handleSendComplete(), Send EVENT_SEND_RETRY mRetryCount: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p1, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mRetryCount:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    goto :goto_0

    .line 648
    .end local v0    # "retryMsg":Landroid/os/Message;
    :cond_1
    const-string v1, "handleSendComplete(), First send attempt was SMS over 1xRTT"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 649
    const-string v1, "handleSendComplete(), Retry Popup will be occurred"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 650
    const/16 v1, 0x130

    invoke-virtual {p0, v1, p1}, Lcom/android/internal/telephony/SMSDispatcherEx;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    .line 651
    .restart local v0    # "retryMsg":Landroid/os/Message;
    const-wide/16 v2, 0x64

    invoke-virtual {p0, v0, v2, v3}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendMessageDelayed(Landroid/os/Message;J)Z

    goto :goto_0
.end method

.method private sendE911StartDAN()V
    .locals 5

    .prologue
    const/4 v4, 0x1

    .line 303
    iget-object v2, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const-string v3, "sms_dan_send"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-ne v4, v2, :cond_0

    .line 304
    const-string v2, "[sms.mo.dan] handleMessage(), receive EVENT_VOICE_CALL_STARTED"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 305
    const-string v2, "ril.cdma.emergencyCall"

    const-string v3, "false"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 306
    .local v0, "inEcm":Ljava/lang/String;
    const-string v2, "persist.radio.starte911call"

    const-string v3, "false"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 307
    .local v1, "isStartE911":Ljava/lang/String;
    invoke-static {}, Lcom/android/internal/telephony/CallManager;->getInstance()Lcom/android/internal/telephony/CallManager;

    move-result-object v2

    invoke-virtual {v2}, Lcom/android/internal/telephony/CallManager;->getActiveFgCallState()Lcom/android/internal/telephony/Call$State;

    move-result-object v2

    sget-object v3, Lcom/android/internal/telephony/Call$State;->ACTIVE:Lcom/android/internal/telephony/Call$State;

    if-ne v2, v3, :cond_0

    const-string v2, "true"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    const-string v2, "false"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 308
    const-string v2, "persist.radio.starte911call"

    const-string v3, "true"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 316
    iget-object v2, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v2}, Lcom/android/internal/telephony/PhoneBase;->isUiccInserted()Z

    move-result v2

    if-ne v2, v4, :cond_1

    .line 317
    const-string v2, "[sms.mo.dan] UICC card is inserted into device"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 318
    const-string v2, "[sms.mo.dan] The UE is required to send the 911 Start Notification"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 319
    const-string v2, "[sms.mo.dan] UE Enters Emergency Mode -> UE Sends 911 Start DAN"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 320
    iget-object v2, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const/16 v3, 0x10

    invoke-virtual {p0, v2, v3}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendDomainNotiMessage(Landroid/content/Context;I)V

    .line 327
    .end local v0    # "inEcm":Ljava/lang/String;
    .end local v1    # "isStartE911":Ljava/lang/String;
    :cond_0
    :goto_0
    return-void

    .line 322
    .restart local v0    # "inEcm":Ljava/lang/String;
    .restart local v1    # "isStartE911":Ljava/lang/String;
    :cond_1
    const-string v2, "[sms.mo.dan] UICC card is Not inserted into device"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 323
    const-string v2, "[sms.mo.dan] The UE is not required to send the 911 Start Notification"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    goto :goto_0
.end method

.method private setRetryCountForVzw(Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;I)V
    .locals 2
    .param p1, "tracker"    # Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;
    .param p2, "ss"    # I

    .prologue
    .line 600
    iget v0, p1, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mImsRetry:I

    if-lez v0, :cond_0

    if-nez p2, :cond_0

    .line 609
    sget v0, Lcom/android/internal/telephony/SMSDispatcherEx;->MAX_SEND_RETRIES:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p1, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mRetryCount:I

    .line 610
    const-string v0, "handleSendComplete(), First attempt was over IMS, Current 1x is In service"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 611
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "handleSendComplete: Once 1x retry automatically:  isIms()="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/android/internal/telephony/SMSDispatcherEx;->isIms()Z

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mRetryCount="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p1, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mRetryCount:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mImsRetry="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p1, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mImsRetry:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " mMessageRef="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p1, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mMessageRef:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " SS= "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v1}, Lcom/android/internal/telephony/PhoneBase;->getServiceState()Landroid/telephony/ServiceState;

    move-result-object v1

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getState()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 618
    :cond_0
    return-void
.end method


# virtual methods
.method checkAvailableToSend(Landroid/app/PendingIntent;)Z
    .locals 5
    .param p1, "sentIntent"    # Landroid/app/PendingIntent;

    .prologue
    const/4 v1, 0x1

    .line 1454
    iget-object v2, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const-string v3, "sms_over_ims_in_lte_single_mode"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-ne v1, v2, :cond_1

    .line 1455
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "checkAvailableToSend(), usim = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "ril.card_operator"

    const-string v4, ""

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " roaming = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v3

    invoke-virtual {v3}, Landroid/telephony/TelephonyManager;->isNetworkRoaming()Z

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " servicestate = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v3}, Lcom/android/internal/telephony/PhoneBase;->getServiceState()Landroid/telephony/ServiceState;

    move-result-object v3

    invoke-virtual {v3}, Landroid/telephony/ServiceState;->getState()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " ims = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p0}, Lcom/android/internal/telephony/SMSDispatcherEx;->isIms()Z

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " mccRoaming = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "persist.radio.isroaming"

    const-string v4, "false"

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1460
    const-string v2, "ril.card_operator"

    const-string v3, ""

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "LGU"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v2

    invoke-virtual {v2}, Landroid/telephony/TelephonyManager;->isNetworkRoaming()Z

    move-result v2

    if-nez v2, :cond_1

    const-string v2, "false"

    const-string v3, "persist.radio.isroaming"

    const-string v4, "false"

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 1463
    invoke-virtual {p0}, Lcom/android/internal/telephony/SMSDispatcherEx;->isIms()Z

    move-result v2

    if-nez v2, :cond_1

    .line 1464
    if-eqz p1, :cond_0

    .line 1466
    const/4 v1, 0x1

    :try_start_0
    invoke-virtual {p1, v1}, Landroid/app/PendingIntent;->send(I)V
    :try_end_0
    .catch Landroid/app/PendingIntent$CanceledException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1471
    :cond_0
    :goto_0
    const/4 v1, 0x0

    .line 1475
    :cond_1
    return v1

    .line 1467
    :catch_0
    move-exception v0

    .line 1468
    .local v0, "ex":Landroid/app/PendingIntent$CanceledException;
    const-string v1, "checkAvailableToSend(), failed to send error result"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0
.end method

.method public checkNotInService()Z
    .locals 6

    .prologue
    const/4 v5, 0x1

    .line 1616
    const/4 v1, 0x0

    .line 1617
    .local v1, "notInService":Z
    iget-object v3, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v3}, Lcom/android/internal/telephony/PhoneBase;->getServiceState()Landroid/telephony/ServiceState;

    move-result-object v3

    invoke-virtual {v3}, Landroid/telephony/ServiceState;->getState()I

    move-result v2

    .line 1619
    .local v2, "ss":I
    iget-object v3, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const-string v4, "support_sms_over_ps"

    invoke-static {v3, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    if-ne v5, v3, :cond_2

    .line 1620
    iget-object v3, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v3}, Lcom/android/internal/telephony/PhoneBase;->getServiceState()Landroid/telephony/ServiceState;

    move-result-object v3

    invoke-virtual {v3}, Landroid/telephony/ServiceState;->getDataRegState()I

    move-result v0

    .line 1621
    .local v0, "data_ss":I
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "checkNotInService(), service state : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " data service state : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1623
    iget-object v3, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v3}, Lcom/android/internal/telephony/PhoneBase;->getPhoneType()I

    move-result v3

    if-ne v5, v3, :cond_1

    .line 1624
    invoke-virtual {p0}, Lcom/android/internal/telephony/SMSDispatcherEx;->isIms()Z

    move-result v3

    if-nez v3, :cond_0

    if-eqz v2, :cond_0

    if-eqz v0, :cond_0

    .line 1625
    const/4 v1, 0x1

    .line 1648
    .end local v0    # "data_ss":I
    :cond_0
    :goto_0
    return v1

    .line 1629
    .restart local v0    # "data_ss":I
    :cond_1
    invoke-virtual {p0}, Lcom/android/internal/telephony/SMSDispatcherEx;->isIms()Z

    move-result v3

    if-nez v3, :cond_0

    if-eqz v2, :cond_0

    .line 1630
    const/4 v1, 0x1

    goto :goto_0

    .line 1634
    .end local v0    # "data_ss":I
    :cond_2
    iget-object v3, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const-string v4, "mo_sms_with_1xcsfb"

    invoke-static {v3, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 1635
    iget-object v3, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v3}, Lcom/android/internal/telephony/PhoneBase;->getServiceState()Landroid/telephony/ServiceState;

    move-result-object v3

    invoke-virtual {v3}, Landroid/telephony/ServiceState;->getDataRegState()I

    move-result v0

    .line 1636
    .restart local v0    # "data_ss":I
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "checkNotInService(), service state : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", data service state : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1639
    invoke-virtual {p0}, Lcom/android/internal/telephony/SMSDispatcherEx;->isIms()Z

    move-result v3

    if-nez v3, :cond_0

    if-eqz v2, :cond_0

    if-eqz v0, :cond_0

    .line 1640
    const/4 v1, 0x1

    goto :goto_0

    .line 1644
    .end local v0    # "data_ss":I
    :cond_3
    invoke-virtual {p0}, Lcom/android/internal/telephony/SMSDispatcherEx;->isIms()Z

    move-result v3

    if-nez v3, :cond_0

    if-eqz v2, :cond_0

    .line 1645
    const/4 v1, 0x1

    goto :goto_0
.end method

.method protected dequeueFailedPendingMessage(I)V
    .locals 6
    .param p1, "serviceState"    # I

    .prologue
    .line 1435
    iget-object v3, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPendingMessagesList:Ljava/util/ArrayList;

    monitor-enter v3

    .line 1436
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    :try_start_0
    iget-object v2, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPendingMessagesList:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v0, v2, :cond_0

    .line 1437
    iget-object v2, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPendingMessagesList:Ljava/util/ArrayList;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/internal/telephony/SMSDispatcherEx$PendingMessage;

    iget-object v1, v2, Lcom/android/internal/telephony/SMSDispatcherEx$PendingMessage;->tracker:Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    .line 1438
    .local v1, "mTracker":Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;
    iget-object v2, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    invoke-static {p1}, Lcom/android/internal/telephony/SMSDispatcherEx;->getNotInServiceError(I)I

    move-result v4

    const/4 v5, 0x0

    invoke-virtual {v1, v2, v4, v5}, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->onFailed(Landroid/content/Context;II)V

    .line 1436
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1440
    .end local v1    # "mTracker":Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;
    :cond_0
    :goto_1
    iget-object v2, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPendingMessagesList:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-lez v2, :cond_1

    .line 1441
    iget-object v2, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPendingMessagesList:Ljava/util/ArrayList;

    iget-object v4, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPendingMessagesList:Ljava/util/ArrayList;

    invoke-virtual {v2, v4}, Ljava/util/ArrayList;->removeAll(Ljava/util/Collection;)Z

    .line 1442
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "dequeueFailedPendingMessage(), Removed Failed message from pending queue. "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v4, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPendingMessagesList:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, " left"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    goto :goto_1

    .line 1444
    :catchall_0
    move-exception v2

    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v2

    :cond_1
    :try_start_1
    monitor-exit v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 1445
    return-void
.end method

.method protected enableAutoDCDisconnect(I)V
    .locals 0
    .param p1, "timeOut"    # I

    .prologue
    .line 1393
    return-void
.end method

.method enqueueMessageForSending(Lcom/android/internal/telephony/SMSDispatcherEx$PendingMessage;)V
    .locals 3
    .param p1, "message"    # Lcom/android/internal/telephony/SMSDispatcherEx$PendingMessage;

    .prologue
    .line 1420
    iget-boolean v0, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mSyncronousSending:Z

    if-nez v0, :cond_0

    .line 1432
    :goto_0
    return-void

    .line 1423
    :cond_0
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPendingMessagesList:Ljava/util/ArrayList;

    monitor-enter v1

    .line 1424
    :try_start_0
    iget-object v0, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPendingMessagesList:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 1425
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "enqueueMessageForSending(), Added message to the pending queue. Queue size is "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v2, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPendingMessagesList:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1428
    iget-object v0, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPendingMessagesList:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_1

    .line 1429
    iget-object v0, p1, Lcom/android/internal/telephony/SMSDispatcherEx$PendingMessage;->tracker:Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendSms(Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;)V

    .line 1431
    :cond_1
    monitor-exit v1

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public getLine1Number()Ljava/lang/String;
    .locals 1

    .prologue
    .line 1388
    iget-object v0, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v0}, Lcom/android/internal/telephony/PhoneBase;->getLine1Number()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected getSmsTrackerMap(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;Lcom/android/internal/telephony/SmsHeader;)Ljava/util/HashMap;
    .locals 3
    .param p1, "destAddr"    # Ljava/lang/String;
    .param p2, "scAddr"    # Ljava/lang/String;
    .param p3, "text"    # Ljava/lang/String;
    .param p4, "pdu"    # Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    .param p5, "smsHeader"    # Lcom/android/internal/telephony/SmsHeader;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;",
            "Lcom/android/internal/telephony/SmsHeader;",
            ")",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    .prologue
    .line 1351
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 1352
    .local v0, "map":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/Object;>;"
    const-string v1, "destAddr"

    invoke-virtual {v0, v1, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1353
    const-string v1, "scAddr"

    invoke-virtual {v0, v1, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1354
    const-string v1, "text"

    invoke-virtual {v0, v1, p3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1355
    const-string v1, "smsc"

    iget-object v2, p4, Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;->encodedScAddress:[B

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1356
    const-string v1, "pdu"

    iget-object v2, p4, Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;->encodedMessage:[B

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1357
    const-string v1, "smsHeader"

    invoke-virtual {v0, v1, p5}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1358
    return-object v0
.end method

.method protected getSmsTrackerMap(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;Z)Ljava/util/HashMap;
    .locals 3
    .param p1, "destAddr"    # Ljava/lang/String;
    .param p2, "scAddr"    # Ljava/lang/String;
    .param p3, "text"    # Ljava/lang/String;
    .param p4, "pdu"    # Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;
    .param p5, "isMultiPart"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;",
            "Z)",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    .prologue
    .line 1335
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 1336
    .local v0, "map":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/Object;>;"
    const-string v1, "destAddr"

    invoke-virtual {v0, v1, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1337
    const-string v1, "scAddr"

    invoke-virtual {v0, v1, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1338
    const-string v1, "text"

    invoke-virtual {v0, v1, p3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1339
    const-string v1, "smsc"

    iget-object v2, p4, Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;->encodedScAddress:[B

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1340
    const-string v1, "pdu"

    iget-object v2, p4, Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;->encodedMessage:[B

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1341
    const-string v1, "parts"

    invoke-static {p5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1342
    return-object v0
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 10
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/16 v9, 0x12d

    const/4 v8, 0x2

    const/4 v7, 0x0

    .line 337
    iget v5, p1, Landroid/os/Message;->what:I

    packed-switch v5, :pswitch_data_0

    .line 416
    invoke-super {p0, p1}, Lcom/android/internal/telephony/SMSDispatcher;->handleMessage(Landroid/os/Message;)V

    .line 418
    :cond_0
    :goto_0
    return-void

    .line 340
    :pswitch_0
    const-string v5, "handleMessage(), EVENT_SEND_RETRY_WITHPOPUP Received!!"

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 341
    iget-object v5, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v5, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    check-cast v5, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/SMSDispatcherEx;->handleRetryByOption(Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;)V

    goto :goto_0

    .line 347
    :pswitch_1
    const-string v5, "handleMessage(), EVENT_RETRY_ALERT_TIMEOUT Received!!"

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 348
    iget-object v5, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v5, Landroid/app/AlertDialog;

    check-cast v5, Landroid/app/AlertDialog;

    invoke-virtual {v5}, Landroid/app/AlertDialog;->dismiss()V

    .line 349
    iput-object v7, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    .line 350
    iget-object v5, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mSTrackersForRetry:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_1

    .line 351
    iget-object v5, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mSTrackersForRetry:Ljava/util/ArrayList;

    const/4 v6, 0x0

    invoke-virtual {v5, v6}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    .line 352
    .local v4, "tracker":Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;
    sget v5, Lcom/android/internal/telephony/SMSDispatcherEx;->MAX_SEND_RETRIES:I

    iput v5, v4, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mRetryCount:I

    .line 354
    new-instance v0, Landroid/os/AsyncResult;

    invoke-direct {v0, v4, v7, v7}, Landroid/os/AsyncResult;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Throwable;)V

    .line 355
    .local v0, "asyncres":Landroid/os/AsyncResult;
    new-instance v1, Lcom/android/internal/telephony/CommandException;

    sget-object v5, Lcom/android/internal/telephony/CommandException$Error;->SMS_FAIL_RETRY:Lcom/android/internal/telephony/CommandException$Error;

    invoke-direct {v1, v5}, Lcom/android/internal/telephony/CommandException;-><init>(Lcom/android/internal/telephony/CommandException$Error;)V

    .line 356
    .local v1, "commandExcep":Lcom/android/internal/telephony/CommandException;
    iput-object v1, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    .line 360
    invoke-virtual {p0, v8, v0}, Lcom/android/internal/telephony/SMSDispatcherEx;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendMessage(Landroid/os/Message;)Z

    .line 362
    const-string v5, "handleMessage(), [SMS.MO.RETRY] Case EVENT_RETRY_ALERT_TIMEOUT, ok!!"

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    goto :goto_0

    .line 365
    .end local v0    # "asyncres":Landroid/os/AsyncResult;
    .end local v1    # "commandExcep":Lcom/android/internal/telephony/CommandException;
    .end local v4    # "tracker":Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;
    :cond_1
    const-string v5, "handleMessage(), [SMS.MO.RETRY] Case EVENT_RETRY_ALERT_TIMEOUT, mSTrackersForRetry empty!!"

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0

    .line 370
    :pswitch_2
    const-string v5, "handleMessage(), EVENT_SEND_RETRY_CONFIRMED_SMS Received!!"

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 371
    iget-object v5, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mSTrackersForRetry:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_0

    .line 372
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "handleMessage(), [SMS.MO.RETRY] mSTrackersForRetry.size()=["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mSTrackersForRetry:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "] "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 373
    iget-object v5, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mSTrackersForRetry:Ljava/util/ArrayList;

    iget-object v6, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mSTrackersForRetry:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    move-result v6

    add-int/lit8 v6, v6, -0x1

    invoke-virtual {v5, v6}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    .line 374
    .local v3, "sTracker":Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;
    iget v5, v3, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mRetryCount:I

    add-int/lit8 v5, v5, 0x1

    iput v5, v3, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mRetryCount:I

    .line 375
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "handleMessage(), [SMS.MO.RETRY] sTracker.mRetryCount=["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, v3, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mRetryCount:I

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "] "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 376
    invoke-virtual {p0, v3}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendRetrySms(Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;)V

    .line 377
    iget-object v5, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    invoke-virtual {p0, v9, v5}, Lcom/android/internal/telephony/SMSDispatcherEx;->removeMessages(ILjava/lang/Object;)V

    goto/16 :goto_0

    .line 382
    .end local v3    # "sTracker":Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;
    :pswitch_3
    const-string v5, "handleMessage(), EVENT_STOP_RETRY_SENDING Received!!"

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 384
    iget-object v5, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mSTrackersForRetry:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_0

    .line 385
    const-string v5, "handleMessage(), Case EVENT_STOP_RETRY_SENDING called..."

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 386
    iget-object v5, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mSTrackersForRetry:Ljava/util/ArrayList;

    iget-object v6, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mSTrackersForRetry:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    move-result v6

    add-int/lit8 v6, v6, -0x1

    invoke-virtual {v5, v6}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    .line 387
    .restart local v3    # "sTracker":Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;
    sget v5, Lcom/android/internal/telephony/SMSDispatcherEx;->MAX_SEND_RETRIES:I

    iput v5, v3, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mRetryCount:I

    .line 389
    new-instance v0, Landroid/os/AsyncResult;

    invoke-direct {v0, v3, v7, v7}, Landroid/os/AsyncResult;-><init>(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Throwable;)V

    .line 390
    .restart local v0    # "asyncres":Landroid/os/AsyncResult;
    new-instance v1, Lcom/android/internal/telephony/CommandException;

    sget-object v5, Lcom/android/internal/telephony/CommandException$Error;->SMS_FAIL_RETRY:Lcom/android/internal/telephony/CommandException$Error;

    invoke-direct {v1, v5}, Lcom/android/internal/telephony/CommandException;-><init>(Lcom/android/internal/telephony/CommandException$Error;)V

    .line 391
    .restart local v1    # "commandExcep":Lcom/android/internal/telephony/CommandException;
    iput-object v1, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    .line 395
    invoke-virtual {p0, v8, v0}, Lcom/android/internal/telephony/SMSDispatcherEx;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendMessage(Landroid/os/Message;)Z

    .line 396
    iget-object v5, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    invoke-virtual {p0, v9, v5}, Lcom/android/internal/telephony/SMSDispatcherEx;->removeMessages(ILjava/lang/Object;)V

    goto/16 :goto_0

    .line 403
    .end local v0    # "asyncres":Landroid/os/AsyncResult;
    .end local v1    # "commandExcep":Lcom/android/internal/telephony/CommandException;
    .end local v3    # "sTracker":Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;
    :pswitch_4
    const-string v5, "handleMessage(), receive EVENT_SEND_RETRY_CBMI"

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 404
    new-instance v2, Landroid/content/Intent;

    const-string v5, "android.intent.action.ENABLE_CBMI"

    invoke-direct {v2, v5}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 405
    .local v2, "intent":Landroid/content/Intent;
    iget-object v5, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const-string v6, "android.permission.RECEIVE_SMS"

    invoke-virtual {v5, v2, v6}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;Ljava/lang/String;)V

    goto/16 :goto_0

    .line 411
    .end local v2    # "intent":Landroid/content/Intent;
    :pswitch_5
    invoke-direct {p0}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendE911StartDAN()V

    goto/16 :goto_0

    .line 337
    nop

    :pswitch_data_0
    .packed-switch 0x12d
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_0
        :pswitch_4
        :pswitch_5
    .end packed-switch
.end method

.method protected handleMessageEventSendConfirmedSms(Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;)V
    .locals 1
    .param p1, "tracker"    # Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    .prologue
    .line 423
    iget-boolean v0, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mSyncronousSending:Z

    if-eqz v0, :cond_0

    .line 424
    new-instance v0, Lcom/android/internal/telephony/SMSDispatcherEx$PendingMessage;

    invoke-direct {v0, p1}, Lcom/android/internal/telephony/SMSDispatcherEx$PendingMessage;-><init>(Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;)V

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/SMSDispatcherEx;->enqueueMessageForSending(Lcom/android/internal/telephony/SMSDispatcherEx$PendingMessage;)V

    .line 428
    :goto_0
    return-void

    .line 426
    :cond_0
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendSms(Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;)V

    goto :goto_0
.end method

.method protected handleRetryByOption(Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;)V
    .locals 8
    .param p1, "tracker"    # Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    .prologue
    const/16 v6, 0x12f

    .line 1276
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "handleRetryByOption(), [SMS.MO.RETRY] retry popup mSTrackersForRetry.size()=["

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mSTrackersForRetry:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "] "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1279
    iget-object v4, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v4}, Lcom/android/internal/telephony/PhoneBase;->getServiceState()Landroid/telephony/ServiceState;

    move-result-object v4

    invoke-virtual {v4}, Landroid/telephony/ServiceState;->getState()I

    move-result v3

    .line 1280
    .local v3, "ss":I
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "handleRetryByOption(), Service State = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1281
    if-eqz v3, :cond_0

    .line 1282
    const-string v4, "handleRetryByOption(), Service state is not in service, So not show retry popup to user"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1283
    invoke-virtual {p0, v6}, Lcom/android/internal/telephony/SMSDispatcherEx;->obtainMessage(I)Landroid/os/Message;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendMessage(Landroid/os/Message;)Z

    .line 1325
    :goto_0
    return-void

    .line 1288
    :cond_0
    if-eqz p1, :cond_1

    iget-object v4, p1, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mDestAddress:Ljava/lang/String;

    if-eqz v4, :cond_1

    .line 1289
    const-string v4, "persist.gsm.sms.dcnaddress"

    const-string v5, "4437501000"

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 1290
    .local v1, "propertyDcnAddress":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "handleRetryByOption(), tracker.mDestAddress = ["

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p1, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mDestAddress:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "] "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1291
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "handleRetryByOption(), propertyDcnAddress = ["

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "] "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1292
    iget-object v4, p1, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mDestAddress:Ljava/lang/String;

    invoke-virtual {v4, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 1293
    const-string v4, "handleRetryByOption(), This is DCN sending, So not show retry popup to user"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1294
    invoke-virtual {p0, v6}, Lcom/android/internal/telephony/SMSDispatcherEx;->obtainMessage(I)Landroid/os/Message;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendMessage(Landroid/os/Message;)Z

    goto :goto_0

    .line 1300
    .end local v1    # "propertyDcnAddress":Ljava/lang/String;
    :cond_1
    iget-object v4, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mSTrackersForRetry:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    sget v5, Lcom/android/internal/telephony/SMSDispatcherEx;->MO_MSG_QUEUE_LIMIT:I

    if-lt v4, v5, :cond_2

    .line 1301
    invoke-virtual {p0, v6}, Lcom/android/internal/telephony/SMSDispatcherEx;->obtainMessage(I)Landroid/os/Message;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendMessage(Landroid/os/Message;)Z

    goto :goto_0

    .line 1304
    :cond_2
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v2

    .line 1306
    .local v2, "r":Landroid/content/res/Resources;
    new-instance v4, Landroid/app/AlertDialog$Builder;

    iget-object v5, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    sget v6, Lcom/lge/internal/R$style;->Theme_LGE_White_Dialog_Alert:I

    invoke-direct {v4, v5, v6}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;I)V

    sget v5, Lcom/lge/internal/R$string;->sp_retry_title_NORMAL:I

    invoke-virtual {v2, v5}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v4

    sget v5, Lcom/lge/internal/R$string;->sp_sms_vzw_retry_msg_NORMAL:I

    invoke-virtual {v2, v5}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v4

    sget v5, Lcom/lge/internal/R$string;->sp_sms_vzw_retry_yes_NORMAL:I

    invoke-virtual {v2, v5}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v5

    iget-object v6, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mRetryListener:Landroid/content/DialogInterface$OnClickListener;

    invoke-virtual {v4, v5, v6}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v4

    sget v5, Lcom/lge/internal/R$string;->sp_sms_vzw_retry_no_NORMAL:I

    invoke-virtual {v2, v5}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v5

    iget-object v6, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mRetryListener:Landroid/content/DialogInterface$OnClickListener;

    invoke-virtual {v4, v5, v6}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v4

    invoke-virtual {v4}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    .line 1317
    .local v0, "d":Landroid/app/AlertDialog;
    invoke-virtual {v0}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v4

    const/16 v5, 0x7d3

    invoke-virtual {v4, v5}, Landroid/view/Window;->setType(I)V

    .line 1318
    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    .line 1320
    iget-object v4, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mSTrackersForRetry:Ljava/util/ArrayList;

    invoke-virtual {v4, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 1321
    const-string v4, "handleRetryByOption(), [SMS.MO.RETRY] handleRetryByOption: mSTrackersForRetry add..."

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1323
    const/16 v4, 0x12d

    invoke-virtual {p0, v4, v0}, Lcom/android/internal/telephony/SMSDispatcherEx;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v4

    const-wide/16 v6, 0x2710

    invoke-virtual {p0, v4, v6, v7}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendMessageDelayed(Landroid/os/Message;J)Z

    goto/16 :goto_0
.end method

.method protected handleSendComplete(Landroid/os/AsyncResult;)V
    .locals 9
    .param p1, "ar"    # Landroid/os/AsyncResult;

    .prologue
    const/4 v8, 0x1

    .line 465
    iget-object v5, p1, Landroid/os/AsyncResult;->userObj:Ljava/lang/Object;

    check-cast v5, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    .line 466
    .local v5, "tracker":Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;
    iget-object v3, v5, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mSentIntent:Landroid/app/PendingIntent;

    .line 469
    .local v3, "sentIntent":Landroid/app/PendingIntent;
    if-nez v5, :cond_0

    .line 470
    const-string v6, "handleSendComplete(), SmsTracker was null, Return"

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 596
    :goto_0
    return-void

    .line 475
    :cond_0
    iget-object v6, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    if-eqz v6, :cond_2

    .line 476
    iget-object v6, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v6, Lcom/android/internal/telephony/SmsResponse;

    iget v6, v6, Lcom/android/internal/telephony/SmsResponse;->mMessageRef:I

    iput v6, v5, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mMessageRef:I

    .line 481
    :goto_1
    iget-object v6, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v6, :cond_4

    .line 482
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "handleSendComplete(), SMS send complete. Broadcasting intent: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 484
    iget-object v6, v5, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mDeliveryIntent:Landroid/app/PendingIntent;

    if-eqz v6, :cond_1

    .line 486
    const/4 v6, 0x0

    const-string v7, "kddi_receive_status_report_iwk"

    invoke-static {v6, v7}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v6

    if-ne v6, v8, :cond_3

    .line 487
    sget-object v6, Lcom/android/internal/telephony/SMSDispatcherEx;->DELIVERYPENDINGLISTFORKDDI:Ljava/util/ArrayList;

    invoke-virtual {v6, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 488
    const-string v6, "handleSendComplete(),[KDDI] handleSendComplete()- tracker.mDeliveryIntent!=null)"

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 496
    :cond_1
    :goto_2
    iget-object v6, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    invoke-virtual {v5, v6}, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->onSent(Landroid/content/Context;)V

    .line 499
    invoke-virtual {p0}, Lcom/android/internal/telephony/SMSDispatcherEx;->processNextPendingMessage()V

    goto :goto_0

    .line 478
    :cond_2
    const-string v6, "handleSendComplete(), SmsResponse was null"

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    goto :goto_1

    .line 491
    :cond_3
    iget-object v6, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->deliveryPendingList:Ljava/util/ArrayList;

    invoke-virtual {v6, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_2

    .line 502
    :cond_4
    const-string v6, "handleSendComplete, SMS send failed"

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 504
    iget-object v6, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v6}, Lcom/android/internal/telephony/PhoneBase;->getServiceState()Landroid/telephony/ServiceState;

    move-result-object v6

    invoke-virtual {v6}, Landroid/telephony/ServiceState;->getState()I

    move-result v4

    .line 507
    .local v4, "ss":I
    iget-object v6, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const-string v7, "cdma_sms_cdg2"

    invoke-static {v6, v7}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v6

    if-ne v6, v8, :cond_5

    .line 508
    invoke-direct {p0, p1, v5}, Lcom/android/internal/telephony/SMSDispatcherEx;->handleSendFailForCDG2(Landroid/os/AsyncResult;Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;)V

    goto :goto_0

    .line 513
    :cond_5
    iget v6, v5, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mImsRetry:I

    if-lez v6, :cond_6

    if-eqz v4, :cond_6

    .line 517
    sget v6, Lcom/android/internal/telephony/SMSDispatcherEx;->MAX_SEND_RETRIES:I

    iput v6, v5, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mRetryCount:I

    .line 519
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "handleSendComplete: Skipping retry:  isIms()="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {p0}, Lcom/android/internal/telephony/SMSDispatcherEx;->isIms()Z

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " mRetryCount="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v7, v5, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mRetryCount:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " mImsRetry="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v7, v5, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mImsRetry:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " mMessageRef="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v7, v5, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mMessageRef:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " SS= "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPhone:Lcom/android/internal/telephony/PhoneBase;

    invoke-virtual {v7}, Lcom/android/internal/telephony/PhoneBase;->getServiceState()Landroid/telephony/ServiceState;

    move-result-object v7

    invoke-virtual {v7}, Landroid/telephony/ServiceState;->getState()I

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 528
    :cond_6
    iget-object v6, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const-string v7, "vzw_sms_retry_scheme"

    invoke-static {v6, v7}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v6

    if-ne v6, v8, :cond_7

    .line 529
    invoke-direct {p0, v5, v4}, Lcom/android/internal/telephony/SMSDispatcherEx;->setRetryCountForVzw(Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;I)V

    .line 535
    :cond_7
    invoke-virtual {p0}, Lcom/android/internal/telephony/SMSDispatcherEx;->checkNotInService()Z

    move-result v6

    if-ne v8, v6, :cond_9

    .line 538
    iget-boolean v6, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mSyncronousSending:Z

    if-eqz v6, :cond_8

    .line 539
    const-string v6, "handleSendComplete(), due to Not In Service, send failed intent and dequeueFailedPendingMessage"

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 540
    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/SMSDispatcherEx;->dequeueFailedPendingMessage(I)V

    goto/16 :goto_0

    .line 542
    :cond_8
    iget-object v6, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    invoke-static {v4}, Lcom/android/internal/telephony/SMSDispatcherEx;->getNotInServiceError(I)I

    move-result v7

    const/4 v8, 0x0

    invoke-virtual {v5, v6, v7, v8}, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->onFailed(Landroid/content/Context;II)V

    goto/16 :goto_0

    .line 546
    :cond_9
    iget-object v6, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    check-cast v6, Lcom/android/internal/telephony/CommandException;

    check-cast v6, Lcom/android/internal/telephony/CommandException;

    invoke-virtual {v6}, Lcom/android/internal/telephony/CommandException;->getCommandError()Lcom/android/internal/telephony/CommandException$Error;

    move-result-object v6

    sget-object v7, Lcom/android/internal/telephony/CommandException$Error;->SMS_FAIL_RETRY:Lcom/android/internal/telephony/CommandException$Error;

    if-ne v6, v7, :cond_b

    iget v6, v5, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mRetryCount:I

    sget v7, Lcom/android/internal/telephony/SMSDispatcherEx;->MAX_SEND_RETRIES:I

    if-ge v6, v7, :cond_b

    .line 558
    iget-object v6, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const-string v7, "vzw_sms_retry_scheme"

    invoke-static {v6, v7}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_a

    .line 559
    invoke-direct {p0, v5}, Lcom/android/internal/telephony/SMSDispatcherEx;->routeRetrySendingForVzw(Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;)V

    goto/16 :goto_0

    .line 561
    :cond_a
    iget v6, v5, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mRetryCount:I

    add-int/lit8 v6, v6, 0x1

    iput v6, v5, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mRetryCount:I

    .line 562
    const/4 v6, 0x3

    invoke-virtual {p0, v6, v5}, Lcom/android/internal/telephony/SMSDispatcherEx;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v2

    .line 563
    .local v2, "retryMsg":Landroid/os/Message;
    sget v6, Lcom/android/internal/telephony/SMSDispatcherEx;->SEND_RETRY_DELAY:I

    int-to-long v6, v6

    invoke-virtual {p0, v2, v6, v7}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendMessageDelayed(Landroid/os/Message;J)Z

    goto/16 :goto_0

    .line 567
    .end local v2    # "retryMsg":Landroid/os/Message;
    :cond_b
    const/4 v1, 0x0

    .line 569
    .local v1, "errorCode":I
    iget-object v6, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    if-eqz v6, :cond_c

    .line 570
    iget-object v6, p1, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v6, Lcom/android/internal/telephony/SmsResponse;

    iget v1, v6, Lcom/android/internal/telephony/SmsResponse;->mErrorCode:I

    .line 573
    iget-object v6, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const-string v7, "cdma_cause_code_display"

    invoke-static {v6, v7}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v6

    if-ne v6, v8, :cond_c

    .line 574
    invoke-direct {p0, v1}, Lcom/android/internal/telephony/SMSDispatcherEx;->cdmaCauseCodeDisplayFunc(I)V

    .line 579
    :cond_c
    const/4 v0, 0x1

    .line 581
    .local v0, "error":I
    const-string v6, "handleSendComplete(), SMS send failed RESULT_ERROR_GENERIC_FAILURE"

    invoke-static {v6}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 583
    iget-object v6, p1, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    check-cast v6, Lcom/android/internal/telephony/CommandException;

    check-cast v6, Lcom/android/internal/telephony/CommandException;

    invoke-virtual {v6}, Lcom/android/internal/telephony/CommandException;->getCommandError()Lcom/android/internal/telephony/CommandException$Error;

    move-result-object v6

    sget-object v7, Lcom/android/internal/telephony/CommandException$Error;->FDN_CHECK_FAILURE:Lcom/android/internal/telephony/CommandException$Error;

    if-ne v6, v7, :cond_d

    .line 585
    const/4 v0, 0x6

    .line 589
    :cond_d
    iget-object v6, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    invoke-virtual {v5, v6, v0, v1}, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->onFailed(Landroid/content/Context;II)V

    .line 592
    invoke-virtual {p0}, Lcom/android/internal/telephony/SMSDispatcherEx;->processNextPendingMessage()V

    goto/16 :goto_0
.end method

.method inProgressConcatMoWithoutUserPermit(Lcom/android/internal/telephony/SmsHeader;Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;)Z
    .locals 4
    .param p1, "incomingConcat"    # Lcom/android/internal/telephony/SmsHeader;
    .param p2, "tracker"    # Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    .prologue
    const/4 v2, 0x1

    .line 1100
    if-eqz p1, :cond_2

    .line 1101
    iget-object v1, p1, Lcom/android/internal/telephony/SmsHeader;->concatRef:Lcom/android/internal/telephony/SmsHeader$ConcatRef;

    iget v1, v1, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->refNumber:I

    rem-int/lit8 v0, v1, 0x5

    .line 1102
    .local v0, "currentConcatIndex":I
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Current Concat Index = "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1103
    sget-object v1, Lcom/android/internal/telephony/SMSDispatcherEx;->isInProgressWithUserPermit:[Z

    aget-boolean v1, v1, v0

    if-nez v1, :cond_1

    iget-object v1, p1, Lcom/android/internal/telephony/SmsHeader;->concatRef:Lcom/android/internal/telephony/SmsHeader$ConcatRef;

    iget v1, v1, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->seqNumber:I

    if-le v1, v2, :cond_1

    .line 1105
    const-string v1, "Case 1: in Progress concat MO without user permit"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1107
    const v3, 0xc3d0

    iget-object v1, p2, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mAppInfo:Landroid/content/pm/PackageInfo;

    iget-object v1, v1, Landroid/content/pm/PackageInfo;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    if-nez v1, :cond_0

    const/4 v1, -0x1

    :goto_0
    invoke-static {v3, v1}, Landroid/util/EventLog;->writeEvent(II)I

    .line 1110
    const/4 v1, 0x5

    invoke-virtual {p0, v1, p2}, Lcom/android/internal/telephony/SMSDispatcherEx;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendMessage(Landroid/os/Message;)Z

    move v1, v2

    .line 1116
    .end local v0    # "currentConcatIndex":I
    :goto_1
    return v1

    .line 1107
    .restart local v0    # "currentConcatIndex":I
    :cond_0
    iget-object v1, p2, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mAppInfo:Landroid/content/pm/PackageInfo;

    iget-object v1, v1, Landroid/content/pm/PackageInfo;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    iget v1, v1, Landroid/content/pm/ApplicationInfo;->uid:I

    goto :goto_0

    .line 1114
    :cond_1
    sget-object v1, Lcom/android/internal/telephony/SMSDispatcherEx;->isInProgressWithUserPermit:[Z

    aput-boolean v2, v1, v0

    .line 1116
    .end local v0    # "currentConcatIndex":I
    :cond_2
    const/4 v1, 0x0

    goto :goto_1
.end method

.method protected initCallBackNumber()V
    .locals 1

    .prologue
    .line 259
    const/4 v0, 0x0

    sput-object v0, Lcom/android/internal/telephony/SMSDispatcherEx;->sCBNumber:Ljava/lang/String;

    .line 260
    return-void
.end method

.method protected isDTAGsMobileBoxProApp()Z
    .locals 8

    .prologue
    const/4 v7, 0x0

    .line 1751
    const/4 v4, 0x0

    .line 1752
    .local v4, "retVal":Z
    iget-object v5, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    invoke-virtual {v5}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v3

    .line 1753
    .local v3, "pm":Landroid/content/pm/PackageManager;
    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v5

    invoke-virtual {v3, v5}, Landroid/content/pm/PackageManager;->getPackagesForUid(I)[Ljava/lang/String;

    move-result-object v2

    .line 1756
    .local v2, "packageNames":[Ljava/lang/String;
    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v5

    const/16 v6, 0x3e8

    if-ne v5, v6, :cond_0

    .line 1757
    invoke-virtual {p0}, Lcom/android/internal/telephony/SMSDispatcherEx;->getPackageNameByCallingPid()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v2, v7

    .line 1762
    :cond_0
    const/4 v0, 0x0

    .line 1763
    .local v0, "appInfo":Landroid/content/pm/PackageInfo;
    if-eqz v2, :cond_1

    array-length v5, v2

    if-lez v5, :cond_1

    .line 1766
    const/4 v5, 0x0

    :try_start_0
    aget-object v5, v2, v5

    const/16 v6, 0x40

    invoke-virtual {v3, v5, v6}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 1773
    :cond_1
    :goto_0
    const-string v5, "de.telekom.mds.mbp"

    iget-object v6, v0, Landroid/content/pm/PackageInfo;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    iget-object v6, v6, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_2

    .line 1775
    const/4 v4, 0x1

    .line 1777
    :cond_2
    return v4

    .line 1767
    :catch_0
    move-exception v1

    .line 1769
    .local v1, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    const-string v5, "isDTAGsMobileBoxApp, Can\'t get calling app package info"

    invoke-static {v5}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0
.end method

.method protected isDTAGsMobileBoxProServer(Ljava/lang/String;)Z
    .locals 6
    .param p1, "destinationAddress"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x0

    .line 1782
    iget-object v4, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mTelephonyManager:Landroid/telephony/TelephonyManager;

    invoke-virtual {v4}, Landroid/telephony/TelephonyManager;->getSimOperator()Ljava/lang/String;

    move-result-object v1

    .line 1783
    .local v1, "mccmnc":Ljava/lang/String;
    const/4 v4, 0x4

    new-array v2, v4, [Ljava/lang/String;

    const-string v4, "3011"

    aput-object v4, v2, v3

    const/4 v4, 0x1

    const-string v5, "73240"

    aput-object v5, v2, v4

    const/4 v4, 0x2

    const-string v5, "81214"

    aput-object v5, v2, v4

    const/4 v4, 0x3

    const-string v5, "81215"

    aput-object v5, v2, v4

    .line 1785
    .local v2, "mobileBoxProServers":[Ljava/lang/String;
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    array-length v4, v2

    if-ge v0, v4, :cond_0

    .line 1786
    aget-object v4, v2, v0

    invoke-virtual {v4, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 1787
    const-string v3, "26201"

    invoke-virtual {v3, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    .line 1791
    :cond_0
    return v3

    .line 1785
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method processNextPendingMessage()V
    .locals 4

    .prologue
    .line 1398
    iget-boolean v1, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mSyncronousSending:Z

    if-nez v1, :cond_0

    .line 1417
    :goto_0
    return-void

    .line 1401
    :cond_0
    iget-object v2, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPendingMessagesList:Ljava/util/ArrayList;

    monitor-enter v2

    .line 1403
    :try_start_0
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPendingMessagesList:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-lez v1, :cond_2

    .line 1404
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPendingMessagesList:Ljava/util/ArrayList;

    const/4 v3, 0x0

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 1405
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "processNextPendingMessage(), Removed message from pending queue. "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v3, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPendingMessagesList:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, " left"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1411
    :goto_1
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPendingMessagesList:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-lez v1, :cond_1

    .line 1412
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mPendingMessagesList:Ljava/util/ArrayList;

    const/4 v3, 0x0

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/internal/telephony/SMSDispatcherEx$PendingMessage;

    .line 1414
    .local v0, "message":Lcom/android/internal/telephony/SMSDispatcherEx$PendingMessage;
    iget-object v1, v0, Lcom/android/internal/telephony/SMSDispatcherEx$PendingMessage;->tracker:Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendSms(Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;)V

    .line 1416
    .end local v0    # "message":Lcom/android/internal/telephony/SMSDispatcherEx$PendingMessage;
    :cond_1
    monitor-exit v2

    goto :goto_0

    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1

    .line 1407
    :cond_2
    :try_start_1
    const-string v1, "processNextPendingMessage(), Pending messages list consistency failure detected!"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1
.end method

.method protected processUserPermitConsideringConcat(Lcom/android/internal/telephony/SmsHeader;Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;I)V
    .locals 4
    .param p1, "incomingConcat"    # Lcom/android/internal/telephony/SmsHeader;
    .param p2, "tracker"    # Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;
    .param p3, "checkDestEvent"    # I

    .prologue
    .line 1040
    if-eqz p1, :cond_2

    .line 1041
    iget-object v2, p1, Lcom/android/internal/telephony/SmsHeader;->concatRef:Lcom/android/internal/telephony/SmsHeader$ConcatRef;

    iget v2, v2, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->refNumber:I

    rem-int/lit8 v0, v2, 0x5

    .line 1042
    .local v0, "currentConcatIndex":I
    sget-object v2, Lcom/android/internal/telephony/SMSDispatcherEx;->mTrackerForConcat:[[Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    aget-object v2, v2, v0

    if-nez v2, :cond_0

    .line 1043
    sget-object v2, Lcom/android/internal/telephony/SMSDispatcherEx;->mTrackerForConcat:[[Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    iget-object v3, p1, Lcom/android/internal/telephony/SmsHeader;->concatRef:Lcom/android/internal/telephony/SmsHeader$ConcatRef;

    iget v3, v3, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->msgCount:I

    new-array v3, v3, [Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    aput-object v3, v2, v0

    .line 1046
    :cond_0
    sget-object v2, Lcom/android/internal/telephony/SMSDispatcherEx;->mTrackerForConcat:[[Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    aget-object v2, v2, v0

    iget-object v3, p1, Lcom/android/internal/telephony/SmsHeader;->concatRef:Lcom/android/internal/telephony/SmsHeader$ConcatRef;

    iget v3, v3, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->seqNumber:I

    add-int/lit8 v3, v3, -0x1

    aget-object v2, v2, v3

    if-eqz v2, :cond_1

    .line 1047
    const-string v2, " MAX_CONCAT_TRACKER_ARRAY_NUM overflow"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1049
    if-eqz p2, :cond_5

    :try_start_0
    iget-object v2, p2, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mSentIntent:Landroid/app/PendingIntent;

    if-eqz v2, :cond_5

    .line 1050
    iget-object v2, p2, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mSentIntent:Landroid/app/PendingIntent;

    const/4 v3, 0x5

    invoke-virtual {v2, v3}, Landroid/app/PendingIntent;->send(I)V
    :try_end_0
    .catch Landroid/app/PendingIntent$CanceledException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1059
    :cond_1
    :goto_0
    sget-object v2, Lcom/android/internal/telephony/SMSDispatcherEx;->mTrackerForConcat:[[Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    aget-object v2, v2, v0

    iget-object v3, p1, Lcom/android/internal/telephony/SmsHeader;->concatRef:Lcom/android/internal/telephony/SmsHeader$ConcatRef;

    iget v3, v3, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->seqNumber:I

    add-int/lit8 v3, v3, -0x1

    aput-object p2, v2, v3

    .line 1062
    .end local v0    # "currentConcatIndex":I
    :cond_2
    if-eqz p1, :cond_3

    iget-object v2, p1, Lcom/android/internal/telephony/SmsHeader;->concatRef:Lcom/android/internal/telephony/SmsHeader$ConcatRef;

    iget v2, v2, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->seqNumber:I

    iget-object v3, p1, Lcom/android/internal/telephony/SmsHeader;->concatRef:Lcom/android/internal/telephony/SmsHeader$ConcatRef;

    iget v3, v3, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->msgCount:I

    if-ne v2, v3, :cond_4

    .line 1063
    :cond_3
    const-string v2, "Case 2: process user permit considering non concat or concat"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1064
    invoke-virtual {p0, p3, p2}, Lcom/android/internal/telephony/SMSDispatcherEx;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendMessage(Landroid/os/Message;)Z

    .line 1066
    :cond_4
    :goto_1
    return-void

    .line 1052
    .restart local v0    # "currentConcatIndex":I
    :cond_5
    :try_start_1
    const-string v2, "processUserPermitConsideringConcat, tracker is null or mSentIntent is null"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I
    :try_end_1
    .catch Landroid/app/PendingIntent$CanceledException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    .line 1055
    :catch_0
    move-exception v1

    .line 1056
    .local v1, "ex":Landroid/app/PendingIntent$CanceledException;
    const-string v2, "processUserPermitConsideringConcat, failed to send back RESULT_ERROR_LIMIT_EXCEEDED"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_0
.end method

.method public retryCBMIEnable()V
    .locals 4

    .prologue
    .line 1481
    const-string v1, "SMSDispatcherEx - retryCBMIEnable()"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1482
    const/16 v1, 0x131

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/SMSDispatcherEx;->obtainMessage(I)Landroid/os/Message;

    move-result-object v0

    .line 1483
    .local v0, "retryMsg":Landroid/os/Message;
    const-wide/16 v2, 0x3e8

    invoke-virtual {p0, v0, v2, v3}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendMessageDelayed(Landroid/os/Message;J)Z

    .line 1484
    return-void
.end method

.method protected sendDomainNotiMessage(Landroid/content/Context;I)V
    .locals 28
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "domainStatus"    # I

    .prologue
    .line 1512
    invoke-direct/range {p0 .. p0}, Lcom/android/internal/telephony/SMSDispatcherEx;->isAvailableNetworkForDCN()Z

    move-result v4

    if-nez v4, :cond_0

    .line 1513
    const-string v4, "[sms.mo.dan] Current network is not available for sending DCN"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1514
    const-string v4, "[sms.mo.dan] Quit sending Domain Change Notification"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1585
    :goto_0
    return-void

    .line 1517
    :cond_0
    const/4 v4, 0x0

    new-instance v8, Landroid/content/Intent;

    const-string v9, "com.lge.kddi.intent.action.DAN_SENT"

    invoke-direct {v8, v9}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const/4 v9, 0x0

    move-object/from16 v0, p1

    invoke-static {v0, v4, v8, v9}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v6

    .line 1518
    .local v6, "sentIntent":Landroid/app/PendingIntent;
    const/4 v4, 0x0

    new-instance v8, Landroid/content/Intent;

    const-string v9, "com.lge.kddi.intent.action.DAN_DELIVERED"

    invoke-direct {v8, v9}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const/4 v9, 0x0

    move-object/from16 v0, p1

    invoke-static {v0, v4, v8, v9}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v7

    .line 1521
    .local v7, "deliveryIntent":Landroid/app/PendingIntent;
    const-string v4, "persist.gsm.sms.dcnaddress"

    const-string v8, "4437501000"

    invoke-static {v4, v8}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v20

    .line 1523
    .local v20, "propertyDcnAddress":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[sms.mo.dan] propertyDcnAddress : "

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move-object/from16 v0, v20

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1525
    if-nez v20, :cond_1

    .line 1526
    const-string v4, "[sms.mo.dan] DAN NOT SEND because propertyDcnAddress is null"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    goto :goto_0

    .line 1528
    :cond_1
    const-string v4, ""

    move-object/from16 v0, v20

    if-eq v0, v4, :cond_2

    invoke-virtual/range {v20 .. v20}, Ljava/lang/String;->length()I

    move-result v4

    const/4 v8, 0x5

    if-ge v4, v8, :cond_3

    .line 1529
    :cond_2
    const-string v4, "[sms.mo.dan] DAN NOT SEND because propertyDcnAddress is empty or less than length 5"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    goto :goto_0

    .line 1532
    :cond_3
    const-string v4, "[sms.mo.dan] DAN SEND because propertyDcnAddress is correct"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1534
    move-object/from16 v13, v20

    .line 1535
    .local v13, "destAddr":Ljava/lang/String;
    move-object/from16 v21, v20

    .line 1538
    .local v21, "scAddr":Ljava/lang/String;
    const/16 v18, 0x0

    .line 1539
    .local v18, "msgType":I
    const/16 v17, 0x0

    .line 1540
    .local v17, "msgId":I
    const/16 v16, 0x8

    .line 1541
    .local v16, "length":I
    move/from16 v22, p2

    .line 1542
    .local v22, "status":I
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v8

    const-wide/16 v26, 0x3e8

    div-long v8, v8, v26

    long-to-int v0, v8

    move/from16 v23, v0

    .line 1543
    .local v23, "timeStamp":I
    const/4 v12, 0x0

    .line 1545
    .local v12, "data":[B
    const-string v4, "[sms.mo.dan] SMSDispatcher.java sendDomainNotiMessage"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1548
    :try_start_0
    new-instance v11, Ljava/io/ByteArrayOutputStream;

    const/16 v4, 0x40

    invoke-direct {v11, v4}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 1549
    .local v11, "baos":Ljava/io/ByteArrayOutputStream;
    new-instance v14, Ljava/io/DataOutputStream;

    invoke-direct {v14, v11}, Ljava/io/DataOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 1550
    .local v14, "dos":Ljava/io/DataOutputStream;
    move/from16 v0, v18

    invoke-virtual {v14, v0}, Ljava/io/DataOutputStream;->writeByte(I)V

    .line 1551
    move/from16 v0, v17

    invoke-virtual {v14, v0}, Ljava/io/DataOutputStream;->writeByte(I)V

    .line 1552
    move/from16 v0, v16

    invoke-virtual {v14, v0}, Ljava/io/DataOutputStream;->writeByte(I)V

    .line 1553
    move/from16 v0, v22

    invoke-virtual {v14, v0}, Ljava/io/DataOutputStream;->writeByte(I)V

    .line 1554
    move/from16 v0, v23

    invoke-virtual {v14, v0}, Ljava/io/DataOutputStream;->writeInt(I)V

    .line 1555
    invoke-virtual {v14}, Ljava/io/DataOutputStream;->close()V

    .line 1556
    invoke-virtual {v11}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v12

    .line 1557
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[sms.mo.dan] Message Type: "

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v18

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v8, " Message ID: "

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v17

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v8, " Message Length : "

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v16

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v8, " Status : "

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v22

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v8, " Time Stamp : "

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    move/from16 v0, v23

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1566
    .end local v11    # "baos":Ljava/io/ByteArrayOutputStream;
    .end local v14    # "dos":Ljava/io/DataOutputStream;
    :goto_1
    if-eqz v12, :cond_4

    .line 1567
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[sms.mo.dan] UserData(payload) : "

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-static {v12}, Lcom/android/internal/util/HexDump;->toHexString([B)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1573
    :goto_2
    const/4 v4, 0x1

    const/4 v8, 0x0

    move-object/from16 v0, v21

    invoke-static {v0, v13, v12, v4, v8}, Lcom/android/internal/telephony/cdma/LGCdmaSmsMessage;->getDomainNotiPdu(Ljava/lang/String;Ljava/lang/String;[BZLcom/android/internal/telephony/SmsHeader;)Lcom/android/internal/telephony/cdma/SmsMessage$SubmitPdu;

    move-result-object v19

    .line 1575
    .local v19, "pdu":Lcom/android/internal/telephony/cdma/SmsMessage$SubmitPdu;
    if-eqz v19, :cond_5

    .line 1576
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[sms.mo.dan] Submit pdu Data : "

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual/range {v19 .. v19}, Lcom/android/internal/telephony/cdma/SmsMessage$SubmitPdu;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1577
    invoke-static {v12}, Lcom/android/internal/util/HexDump;->toHexString([B)Ljava/lang/String;

    move-result-object v4

    move-object/from16 v0, p0

    move-object/from16 v1, v21

    move-object/from16 v2, v19

    invoke-virtual {v0, v13, v1, v4, v2}, Lcom/android/internal/telephony/SMSDispatcherEx;->getSmsTrackerMap(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/android/internal/telephony/SmsMessageBase$SubmitPduBase;)Ljava/util/HashMap;

    move-result-object v5

    .line 1578
    .local v5, "map":Ljava/util/HashMap;
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/SMSDispatcherEx;->getFormat()Ljava/lang/String;

    move-result-object v8

    const/4 v9, 0x0

    const/4 v10, 0x0

    move-object/from16 v4, p0

    invoke-virtual/range {v4 .. v10}, Lcom/android/internal/telephony/SMSDispatcherEx;->getSmsTracker(Ljava/util/HashMap;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Ljava/lang/String;Landroid/net/Uri;Z)Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    move-result-object v24

    .line 1580
    .local v24, "tracker":Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;
    move-object/from16 v0, p0

    move-object/from16 v1, v24

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendRawPdu(Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;)V

    goto/16 :goto_0

    .line 1562
    .end local v5    # "map":Ljava/util/HashMap;
    .end local v19    # "pdu":Lcom/android/internal/telephony/cdma/SmsMessage$SubmitPdu;
    .end local v24    # "tracker":Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;
    :catch_0
    move-exception v15

    .line 1563
    .local v15, "ex":Ljava/io/IOException;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[sms.mo.dan] Creating Notification Data failed: "

    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_1

    .line 1569
    .end local v15    # "ex":Ljava/io/IOException;
    :cond_4
    const-string v4, "[sms.mo.dan] UserData(payload) is null"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto :goto_2

    .line 1582
    .restart local v19    # "pdu":Lcom/android/internal/telephony/cdma/SmsMessage$SubmitPdu;
    :cond_5
    const-string v4, "[sms.mo.dan] Submit pdu Data is null"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    goto/16 :goto_0
.end method

.method protected sendEmailoverMultipartText(Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/lang/String;)V
    .locals 20
    .param p1, "destAddr"    # Ljava/lang/String;
    .param p2, "scAddr"    # Ljava/lang/String;
    .param p6, "callingPkg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/ArrayList",
            "<",
            "Landroid/app/PendingIntent;",
            ">;",
            "Ljava/util/ArrayList",
            "<",
            "Landroid/app/PendingIntent;",
            ">;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .line 928
    .local p3, "parts":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    .local p4, "sentIntents":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/app/PendingIntent;>;"
    .local p5, "deliveryIntents":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/app/PendingIntent;>;"
    const/4 v13, 0x0

    .line 929
    .local v13, "messageUri":Landroid/net/Uri;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    move-object/from16 v0, p6

    invoke-static {v0, v2}, Lcom/android/internal/telephony/SmsApplication;->shouldWriteMessageForPackage(Ljava/lang/String;Landroid/content/Context;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 930
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/SMSDispatcherEx;->getSubId()J

    move-result-wide v4

    move-object/from16 v0, p0

    move-object/from16 v1, p3

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/SMSDispatcherEx;->getMultipartMessageText(Ljava/util/ArrayList;)Ljava/lang/String;

    move-result-object v7

    if-eqz p5, :cond_3

    invoke-virtual/range {p5 .. p5}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-lez v2, :cond_3

    const/4 v8, 0x1

    :goto_0
    move-object/from16 v3, p0

    move-object/from16 v6, p1

    move-object/from16 v9, p6

    invoke-virtual/range {v3 .. v9}, Lcom/android/internal/telephony/SMSDispatcherEx;->writeOutboxMessage(JLjava/lang/String;Ljava/lang/String;ZLjava/lang/String;)Landroid/net/Uri;

    move-result-object v13

    .line 937
    :cond_0
    invoke-static {}, Lcom/android/internal/telephony/SMSDispatcherEx;->getNextConcatenatedRef()I

    move-result v2

    and-int/lit16 v0, v2, 0xff

    move/from16 v19, v0

    .line 938
    .local v19, "refNumber":I
    invoke-virtual/range {p3 .. p3}, Ljava/util/ArrayList;->size()I

    move-result v18

    .line 939
    .local v18, "msgCount":I
    const/4 v7, 0x0

    .line 941
    .local v7, "encoding":I
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "sendEmailoverMultipartText(), msgCount = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v0, v18

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 943
    move/from16 v0, v18

    new-array v0, v0, [Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-object/from16 v16, v0

    .line 945
    .local v16, "encodingForParts":[Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    const/16 v17, 0x0

    .local v17, "i":I
    :goto_1
    move/from16 v0, v17

    move/from16 v1, v18

    if-ge v0, v1, :cond_4

    .line 946
    move-object/from16 v0, p3

    move/from16 v1, v17

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    const/4 v3, 0x0

    move-object/from16 v0, p0

    invoke-virtual {v0, v2, v3}, Lcom/android/internal/telephony/SMSDispatcherEx;->calculateLength(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v15

    .line 947
    .local v15, "details":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "sendEmailoverMultipartText(), i = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    move/from16 v0, v17

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "details = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v15}, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 949
    iget v2, v15, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    if-eq v7, v2, :cond_2

    if-eqz v7, :cond_1

    const/4 v2, 0x1

    if-ne v7, v2, :cond_2

    .line 952
    :cond_1
    iget v7, v15, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    .line 955
    :cond_2
    aput-object v15, v16, v17

    .line 945
    add-int/lit8 v17, v17, 0x1

    goto :goto_1

    .line 930
    .end local v7    # "encoding":I
    .end local v15    # "details":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .end local v16    # "encodingForParts":[Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .end local v17    # "i":I
    .end local v18    # "msgCount":I
    .end local v19    # "refNumber":I
    :cond_3
    const/4 v8, 0x0

    goto/16 :goto_0

    .line 959
    .restart local v7    # "encoding":I
    .restart local v16    # "encodingForParts":[Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .restart local v17    # "i":I
    .restart local v18    # "msgCount":I
    .restart local v19    # "refNumber":I
    :cond_4
    new-instance v11, Ljava/util/concurrent/atomic/AtomicInteger;

    move/from16 v0, v18

    invoke-direct {v11, v0}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>(I)V

    .line 960
    .local v11, "unsentPartCount":Ljava/util/concurrent/atomic/AtomicInteger;
    new-instance v12, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v2, 0x0

    invoke-direct {v12, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    .line 962
    .local v12, "anyPartFailed":Ljava/util/concurrent/atomic/AtomicBoolean;
    const/16 v17, 0x0

    :goto_2
    move/from16 v0, v17

    move/from16 v1, v18

    if-ge v0, v1, :cond_a

    .line 963
    new-instance v14, Lcom/android/internal/telephony/SmsHeader$ConcatRef;

    invoke-direct {v14}, Lcom/android/internal/telephony/SmsHeader$ConcatRef;-><init>()V

    .line 964
    .local v14, "concatRef":Lcom/android/internal/telephony/SmsHeader$ConcatRef;
    move/from16 v0, v19

    iput v0, v14, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->refNumber:I

    .line 965
    add-int/lit8 v2, v17, 0x1

    iput v2, v14, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->seqNumber:I

    .line 966
    move/from16 v0, v18

    iput v0, v14, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->msgCount:I

    .line 973
    const/4 v2, 0x1

    iput-boolean v2, v14, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->isEightBits:Z

    .line 974
    new-instance v6, Lcom/android/internal/telephony/SmsHeader;

    invoke-direct {v6}, Lcom/android/internal/telephony/SmsHeader;-><init>()V

    .line 975
    .local v6, "smsHeader":Lcom/android/internal/telephony/SmsHeader;
    iput-object v14, v6, Lcom/android/internal/telephony/SmsHeader;->concatRef:Lcom/android/internal/telephony/SmsHeader$ConcatRef;

    .line 978
    const/4 v2, 0x1

    if-ne v7, v2, :cond_5

    .line 979
    aget-object v2, v16, v17

    iget v2, v2, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->languageTable:I

    iput v2, v6, Lcom/android/internal/telephony/SmsHeader;->languageTable:I

    .line 980
    aget-object v2, v16, v17

    iget v2, v2, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->languageShiftTable:I

    iput v2, v6, Lcom/android/internal/telephony/SmsHeader;->languageShiftTable:I

    .line 984
    :cond_5
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const-string v3, "send_2_segment_sms_via_sms_not_ems"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    const/4 v3, 0x1

    if-ne v2, v3, :cond_6

    .line 985
    const/4 v6, 0x0

    .line 989
    :cond_6
    const/4 v8, 0x0

    .line 990
    .local v8, "sentIntent":Landroid/app/PendingIntent;
    if-eqz p4, :cond_7

    invoke-virtual/range {p4 .. p4}, Ljava/util/ArrayList;->size()I

    move-result v2

    move/from16 v0, v17

    if-le v2, v0, :cond_7

    .line 991
    move-object/from16 v0, p4

    move/from16 v1, v17

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    .end local v8    # "sentIntent":Landroid/app/PendingIntent;
    check-cast v8, Landroid/app/PendingIntent;

    .line 994
    .restart local v8    # "sentIntent":Landroid/app/PendingIntent;
    :cond_7
    const/4 v9, 0x0

    .line 995
    .local v9, "deliveryIntent":Landroid/app/PendingIntent;
    if-eqz p5, :cond_8

    invoke-virtual/range {p5 .. p5}, Ljava/util/ArrayList;->size()I

    move-result v2

    move/from16 v0, v17

    if-le v2, v0, :cond_8

    .line 996
    move-object/from16 v0, p5

    move/from16 v1, v17

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v9

    .end local v9    # "deliveryIntent":Landroid/app/PendingIntent;
    check-cast v9, Landroid/app/PendingIntent;

    .line 999
    .restart local v9    # "deliveryIntent":Landroid/app/PendingIntent;
    :cond_8
    move-object/from16 v0, p3

    move/from16 v1, v17

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    add-int/lit8 v2, v18, -0x1

    move/from16 v0, v17

    if-ne v0, v2, :cond_9

    const/4 v10, 0x1

    :goto_3
    move-object/from16 v2, p0

    move-object/from16 v3, p1

    move-object/from16 v4, p2

    invoke-virtual/range {v2 .. v13}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendNewSubmitPduforEmailoverSms(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/android/internal/telephony/SmsHeader;ILandroid/app/PendingIntent;Landroid/app/PendingIntent;ZLjava/util/concurrent/atomic/AtomicInteger;Ljava/util/concurrent/atomic/AtomicBoolean;Landroid/net/Uri;)V

    .line 962
    add-int/lit8 v17, v17, 0x1

    goto/16 :goto_2

    .line 999
    :cond_9
    const/4 v10, 0x0

    goto :goto_3

    .line 1003
    .end local v6    # "smsHeader":Lcom/android/internal/telephony/SmsHeader;
    .end local v8    # "sentIntent":Landroid/app/PendingIntent;
    .end local v9    # "deliveryIntent":Landroid/app/PendingIntent;
    .end local v14    # "concatRef":Lcom/android/internal/telephony/SmsHeader$ConcatRef;
    :cond_a
    return-void
.end method

.method protected abstract sendEmailoverText(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Ljava/lang/String;)V
.end method

.method protected sendMultipartText(Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;Landroid/net/Uri;Ljava/lang/String;IZI)V
    .locals 28
    .param p1, "destAddr"    # Ljava/lang/String;
    .param p2, "scAddr"    # Ljava/lang/String;
    .param p6, "messageUri"    # Landroid/net/Uri;
    .param p7, "callingPkg"    # Ljava/lang/String;
    .param p8, "priority"    # I
    .param p9, "isExpectMore"    # Z
    .param p10, "validityPeriod"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/ArrayList",
            "<",
            "Landroid/app/PendingIntent;",
            ">;",
            "Ljava/util/ArrayList",
            "<",
            "Landroid/app/PendingIntent;",
            ">;",
            "Landroid/net/Uri;",
            "Ljava/lang/String;",
            "IZI)V"
        }
    .end annotation

    .prologue
    .line 780
    .local p3, "parts":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    .local p4, "sentIntents":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/app/PendingIntent;>;"
    .local p5, "deliveryIntents":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/app/PendingIntent;>;"
    const/16 v21, 0x0

    .line 783
    .local v21, "doNotWriteMessage":Z
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const-string v5, "allow_sending_MBP_directed_sms"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 784
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/SMSDispatcherEx;->isDTAGsMobileBoxProApp()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-virtual/range {p0 .. p1}, Lcom/android/internal/telephony/SMSDispatcherEx;->isDTAGsMobileBoxProServer(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 785
    const-string v4, "MobilBoxPro message should not be saved"

    invoke-static {v4}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 786
    const/16 v21, 0x1

    .line 791
    :cond_0
    if-nez p6, :cond_5

    .line 792
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    move-object/from16 v0, p7

    invoke-static {v0, v4}, Lcom/android/internal/telephony/SmsApplication;->shouldWriteMessageForPackage(Ljava/lang/String;Landroid/content/Context;)Z

    move-result v4

    if-eqz v4, :cond_1

    if-nez v21, :cond_1

    .line 793
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/SMSDispatcherEx;->getSubId()J

    move-result-wide v6

    move-object/from16 v0, p0

    move-object/from16 v1, p3

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/SMSDispatcherEx;->getMultipartMessageText(Ljava/util/ArrayList;)Ljava/lang/String;

    move-result-object v9

    if-eqz p5, :cond_4

    invoke-virtual/range {p5 .. p5}, Ljava/util/ArrayList;->size()I

    move-result v4

    if-lez v4, :cond_4

    const/4 v10, 0x1

    :goto_0
    move-object/from16 v5, p0

    move-object/from16 v8, p1

    move-object/from16 v11, p7

    invoke-virtual/range {v5 .. v11}, Lcom/android/internal/telephony/SMSDispatcherEx;->writeOutboxMessage(JLjava/lang/String;Ljava/lang/String;ZLjava/lang/String;)Landroid/net/Uri;

    move-result-object p6

    .line 803
    :cond_1
    :goto_1
    invoke-static {}, Lcom/android/internal/telephony/SMSDispatcherEx;->getNextConcatenatedRef()I

    move-result v4

    and-int/lit16 v0, v4, 0xff

    move/from16 v27, v0

    .line 804
    .local v27, "refNumber":I
    invoke-virtual/range {p3 .. p3}, Ljava/util/ArrayList;->size()I

    move-result v26

    .line 805
    .local v26, "msgCount":I
    const/4 v9, 0x0

    .line 808
    .local v9, "encoding":I
    const-string v4, "persist.gsm.sms.forcegsm7"

    const-string v5, "1"

    invoke-static {v4, v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v23

    .line 809
    .local v23, "encodingType":Ljava/lang/String;
    const-string v4, "0"

    move-object/from16 v0, v23

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v25

    .line 812
    .local v25, "isConvertToGsmAlphabet":Z
    move/from16 v0, v26

    new-array v0, v0, [Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-object/from16 v22, v0

    .line 813
    .local v22, "encodingForParts":[Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    const/16 v24, 0x0

    .local v24, "i":I
    :goto_2
    move/from16 v0, v24

    move/from16 v1, v26

    if-ge v0, v1, :cond_8

    .line 818
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const-string v5, "KREncodingScheme"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    const/4 v5, 0x1

    if-ne v4, v5, :cond_6

    .line 819
    move-object/from16 v0, p3

    move/from16 v1, v24

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/CharSequence;

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-static {v4, v5, v6}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->calculateLength(Ljava/lang/CharSequence;ZZ)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v20

    .line 832
    .local v20, "details":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :goto_3
    move-object/from16 v0, v20

    iget v4, v0, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    if-eq v9, v4, :cond_3

    if-eqz v9, :cond_2

    const/4 v4, 0x1

    if-ne v9, v4, :cond_3

    .line 835
    :cond_2
    move-object/from16 v0, v20

    iget v9, v0, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->codeUnitSize:I

    .line 837
    :cond_3
    aput-object v20, v22, v24

    .line 813
    add-int/lit8 v24, v24, 0x1

    goto :goto_2

    .line 793
    .end local v9    # "encoding":I
    .end local v20    # "details":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .end local v22    # "encodingForParts":[Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .end local v23    # "encodingType":Ljava/lang/String;
    .end local v24    # "i":I
    .end local v25    # "isConvertToGsmAlphabet":Z
    .end local v26    # "msgCount":I
    .end local v27    # "refNumber":I
    :cond_4
    const/4 v10, 0x0

    goto :goto_0

    .line 801
    :cond_5
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/SMSDispatcherEx;->getSubId()J

    move-result-wide v4

    move-object/from16 v0, p0

    move-object/from16 v1, p6

    move-object/from16 v2, p7

    invoke-virtual {v0, v4, v5, v1, v2}, Lcom/android/internal/telephony/SMSDispatcherEx;->moveToOutbox(JLandroid/net/Uri;Ljava/lang/String;)V

    goto :goto_1

    .line 822
    .restart local v9    # "encoding":I
    .restart local v22    # "encodingForParts":[Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    .restart local v23    # "encodingType":Ljava/lang/String;
    .restart local v24    # "i":I
    .restart local v25    # "isConvertToGsmAlphabet":Z
    .restart local v26    # "msgCount":I
    .restart local v27    # "refNumber":I
    :cond_6
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const-string v5, "send_2_segment_sms_via_sms_not_ems"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    const/4 v5, 0x1

    if-ne v4, v5, :cond_7

    .line 823
    move-object/from16 v0, p3

    move/from16 v1, v24

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/CharSequence;

    const/4 v5, 0x0

    move-object/from16 v0, p0

    invoke-virtual {v0, v4, v5}, Lcom/android/internal/telephony/SMSDispatcherEx;->calculateLength(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v20

    .restart local v20    # "details":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    goto :goto_3

    .line 826
    .end local v20    # "details":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :cond_7
    move-object/from16 v0, p3

    move/from16 v1, v24

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/CharSequence;

    move-object/from16 v0, p0

    move/from16 v1, v25

    invoke-virtual {v0, v4, v1}, Lcom/android/internal/telephony/SMSDispatcherEx;->calculateLength(Ljava/lang/CharSequence;Z)Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;

    move-result-object v20

    .restart local v20    # "details":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    goto :goto_3

    .line 841
    .end local v20    # "details":Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;
    :cond_8
    new-instance v16, Ljava/util/concurrent/atomic/AtomicInteger;

    move-object/from16 v0, v16

    move/from16 v1, v26

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>(I)V

    .line 842
    .local v16, "unsentPartCount":Ljava/util/concurrent/atomic/AtomicInteger;
    new-instance v17, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v4, 0x0

    move-object/from16 v0, v17

    invoke-direct {v0, v4}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    .line 844
    .local v17, "anyPartFailed":Ljava/util/concurrent/atomic/AtomicBoolean;
    const/16 v24, 0x0

    :goto_4
    move/from16 v0, v24

    move/from16 v1, v26

    if-ge v0, v1, :cond_16

    .line 845
    new-instance v19, Lcom/android/internal/telephony/SmsHeader$ConcatRef;

    invoke-direct/range {v19 .. v19}, Lcom/android/internal/telephony/SmsHeader$ConcatRef;-><init>()V

    .line 846
    .local v19, "concatRef":Lcom/android/internal/telephony/SmsHeader$ConcatRef;
    move/from16 v0, v27

    move-object/from16 v1, v19

    iput v0, v1, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->refNumber:I

    .line 847
    add-int/lit8 v4, v24, 0x1

    move-object/from16 v0, v19

    iput v4, v0, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->seqNumber:I

    .line 848
    move/from16 v0, v26

    move-object/from16 v1, v19

    iput v0, v1, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->msgCount:I

    .line 855
    const/4 v4, 0x1

    move-object/from16 v0, v19

    iput-boolean v4, v0, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->isEightBits:Z

    .line 856
    new-instance v8, Lcom/android/internal/telephony/SmsHeader;

    invoke-direct {v8}, Lcom/android/internal/telephony/SmsHeader;-><init>()V

    .line 857
    .local v8, "smsHeader":Lcom/android/internal/telephony/SmsHeader;
    move-object/from16 v0, v19

    iput-object v0, v8, Lcom/android/internal/telephony/SmsHeader;->concatRef:Lcom/android/internal/telephony/SmsHeader$ConcatRef;

    .line 860
    const/4 v4, 0x1

    if-ne v9, v4, :cond_9

    .line 861
    aget-object v4, v22, v24

    iget v4, v4, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->languageTable:I

    iput v4, v8, Lcom/android/internal/telephony/SmsHeader;->languageTable:I

    .line 862
    aget-object v4, v22, v24

    iget v4, v4, Lcom/android/internal/telephony/GsmAlphabet$TextEncodingDetails;->languageShiftTable:I

    iput v4, v8, Lcom/android/internal/telephony/SmsHeader;->languageShiftTable:I

    .line 866
    :cond_9
    if-nez v24, :cond_a

    .line 867
    move-object/from16 v0, p0

    invoke-virtual {v0, v8}, Lcom/android/internal/telephony/SMSDispatcherEx;->setReplyAddress(Lcom/android/internal/telephony/SmsHeader;)V

    .line 872
    :cond_a
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const-string v5, "send_2_segment_sms_via_sms_not_ems"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    const/4 v5, 0x1

    if-ne v4, v5, :cond_b

    .line 873
    const/4 v8, 0x0

    .line 877
    :cond_b
    const/4 v10, 0x0

    .line 878
    .local v10, "sentIntent":Landroid/app/PendingIntent;
    if-eqz p4, :cond_c

    invoke-virtual/range {p4 .. p4}, Ljava/util/ArrayList;->size()I

    move-result v4

    move/from16 v0, v24

    if-le v4, v0, :cond_c

    .line 879
    move-object/from16 v0, p4

    move/from16 v1, v24

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v10

    .end local v10    # "sentIntent":Landroid/app/PendingIntent;
    check-cast v10, Landroid/app/PendingIntent;

    .line 882
    .restart local v10    # "sentIntent":Landroid/app/PendingIntent;
    :cond_c
    const/4 v11, 0x0

    .line 883
    .local v11, "deliveryIntent":Landroid/app/PendingIntent;
    if-eqz p5, :cond_d

    invoke-virtual/range {p5 .. p5}, Ljava/util/ArrayList;->size()I

    move-result v4

    move/from16 v0, v24

    if-le v4, v0, :cond_d

    .line 884
    move-object/from16 v0, p5

    move/from16 v1, v24

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v11

    .end local v11    # "deliveryIntent":Landroid/app/PendingIntent;
    check-cast v11, Landroid/app/PendingIntent;

    .line 888
    .restart local v11    # "deliveryIntent":Landroid/app/PendingIntent;
    :cond_d
    sget v4, Lcom/android/internal/telephony/SMSDispatcherEx;->vp:I

    if-lez v4, :cond_e

    .line 890
    sget v4, Lcom/android/internal/telephony/SMSDispatcherEx;->vp:I

    invoke-static {v4}, Landroid/telephony/SmsMessage;->setValidityPeriod(I)V

    .line 901
    :cond_e
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const-string v5, "vzw_sms_retry_scheme"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    const/4 v5, 0x1

    if-ne v4, v5, :cond_14

    .line 902
    if-eqz v26, :cond_f

    const/4 v4, 0x1

    move/from16 v0, v26

    if-ne v0, v4, :cond_12

    .line 903
    :cond_f
    move-object/from16 v0, p3

    move/from16 v1, v24

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    add-int/lit8 v4, v26, -0x1

    move/from16 v0, v24

    if-ne v0, v4, :cond_11

    const/4 v12, 0x1

    :goto_5
    sget-object v13, Lcom/android/internal/telephony/SMSDispatcherEx;->sCBNumber:Ljava/lang/String;

    const/4 v14, 0x0

    move-object/from16 v4, p0

    move-object/from16 v5, p1

    move-object/from16 v6, p2

    invoke-virtual/range {v4 .. v14}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendNewSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/android/internal/telephony/SmsHeader;ILandroid/app/PendingIntent;Landroid/app/PendingIntent;ZLjava/lang/String;Z)V

    .line 917
    :cond_10
    :goto_6
    invoke-virtual/range {p0 .. p0}, Lcom/android/internal/telephony/SMSDispatcherEx;->initCallBackNumber()V

    .line 844
    add-int/lit8 v24, v24, 0x1

    goto/16 :goto_4

    .line 903
    :cond_11
    const/4 v12, 0x0

    goto :goto_5

    .line 905
    :cond_12
    const/4 v4, 0x1

    move/from16 v0, v26

    if-le v0, v4, :cond_10

    .line 906
    move-object/from16 v0, p3

    move/from16 v1, v24

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    add-int/lit8 v4, v26, -0x1

    move/from16 v0, v24

    if-ne v0, v4, :cond_13

    const/4 v12, 0x1

    :goto_7
    sget-object v13, Lcom/android/internal/telephony/SMSDispatcherEx;->sCBNumber:Ljava/lang/String;

    const/4 v14, 0x1

    move-object/from16 v4, p0

    move-object/from16 v5, p1

    move-object/from16 v6, p2

    invoke-virtual/range {v4 .. v14}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendNewSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/android/internal/telephony/SmsHeader;ILandroid/app/PendingIntent;Landroid/app/PendingIntent;ZLjava/lang/String;Z)V

    goto :goto_6

    :cond_13
    const/4 v12, 0x0

    goto :goto_7

    .line 910
    :cond_14
    move-object/from16 v0, p3

    move/from16 v1, v24

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    add-int/lit8 v4, v26, -0x1

    move/from16 v0, v24

    if-ne v0, v4, :cond_15

    const/4 v12, 0x1

    :goto_8
    move-object/from16 v4, p0

    move-object/from16 v5, p1

    move-object/from16 v6, p2

    move/from16 v13, p8

    move/from16 v14, p9

    move/from16 v15, p10

    move-object/from16 v18, p6

    invoke-virtual/range {v4 .. v18}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendNewSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/android/internal/telephony/SmsHeader;ILandroid/app/PendingIntent;Landroid/app/PendingIntent;ZIZILjava/util/concurrent/atomic/AtomicInteger;Ljava/util/concurrent/atomic/AtomicBoolean;Landroid/net/Uri;)V

    goto :goto_6

    :cond_15
    const/4 v12, 0x0

    goto :goto_8

    .line 920
    .end local v8    # "smsHeader":Lcom/android/internal/telephony/SmsHeader;
    .end local v10    # "sentIntent":Landroid/app/PendingIntent;
    .end local v11    # "deliveryIntent":Landroid/app/PendingIntent;
    .end local v19    # "concatRef":Lcom/android/internal/telephony/SmsHeader$ConcatRef;
    :cond_16
    return-void
.end method

.method protected sendMultipartText(Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/lang/String;)V
    .locals 11
    .param p1, "destAddr"    # Ljava/lang/String;
    .param p2, "scAddr"    # Ljava/lang/String;
    .param p6, "callingPkg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/ArrayList",
            "<",
            "Landroid/app/PendingIntent;",
            ">;",
            "Ljava/util/ArrayList",
            "<",
            "Landroid/app/PendingIntent;",
            ">;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .line 771
    .local p3, "parts":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    .local p4, "sentIntents":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/app/PendingIntent;>;"
    .local p5, "deliveryIntents":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/app/PendingIntent;>;"
    const/4 v6, 0x0

    const/4 v8, -0x1

    const/4 v9, 0x0

    const/4 v10, -0x1

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object/from16 v5, p5

    move-object/from16 v7, p6

    invoke-virtual/range {v0 .. v10}, Lcom/android/internal/telephony/SMSDispatcherEx;->sendMultipartText(Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;Landroid/net/Uri;Ljava/lang/String;IZI)V

    .line 772
    return-void
.end method

.method protected sendMultipartTextLge(Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljava/lang/String;Ljava/lang/String;IIIZ)V
    .locals 0
    .param p1, "destAddr"    # Ljava/lang/String;
    .param p2, "scAddr"    # Ljava/lang/String;
    .param p6, "callingPkg"    # Ljava/lang/String;
    .param p7, "replyAddr"    # Ljava/lang/String;
    .param p8, "confirmRead"    # I
    .param p9, "replyOption"    # I
    .param p10, "protocolId"    # I
    .param p11, "isExpectMore"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/ArrayList",
            "<",
            "Landroid/app/PendingIntent;",
            ">;",
            "Ljava/util/ArrayList",
            "<",
            "Landroid/app/PendingIntent;",
            ">;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "IIIZ)V"
        }
    .end annotation

    .prologue
    .line 1034
    .local p3, "parts":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    .local p4, "sentIntents":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/app/PendingIntent;>;"
    .local p5, "deliveryIntents":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/app/PendingIntent;>;"
    return-void
.end method

.method protected abstract sendNewSubmitPdu(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/android/internal/telephony/SmsHeader;ILandroid/app/PendingIntent;Landroid/app/PendingIntent;ZLjava/lang/String;Z)V
.end method

.method protected abstract sendNewSubmitPduforEmailoverSms(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/android/internal/telephony/SmsHeader;ILandroid/app/PendingIntent;Landroid/app/PendingIntent;ZLjava/util/concurrent/atomic/AtomicInteger;Ljava/util/concurrent/atomic/AtomicBoolean;Landroid/net/Uri;)V
.end method

.method protected sendRawPdu(Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;)V
    .locals 12
    .param p1, "tracker"    # Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;

    .prologue
    const/4 v11, 0x1

    const/4 v10, 0x0

    .line 1194
    iget-object v2, p1, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mData:Ljava/util/HashMap;

    .line 1195
    .local v2, "map":Ljava/util/HashMap;
    const-string v8, "pdu"

    invoke-virtual {v2, v8}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, [B

    move-object v4, v8

    check-cast v4, [B

    .line 1198
    .local v4, "pdu":[B
    const/4 v7, 0x0

    .line 1199
    .local v7, "smsHeader":Lcom/android/internal/telephony/SmsHeader;
    iget-object v8, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const-string v9, "modify_check_confirm_popup_concat_message_mo"

    invoke-static {v8, v9}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_0

    .line 1200
    const-string v8, "smsHeader"

    invoke-virtual {v2, v8}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    .end local v7    # "smsHeader":Lcom/android/internal/telephony/SmsHeader;
    check-cast v7, Lcom/android/internal/telephony/SmsHeader;

    .line 1204
    .restart local v7    # "smsHeader":Lcom/android/internal/telephony/SmsHeader;
    :cond_0
    iget-object v6, p1, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->mSentIntent:Landroid/app/PendingIntent;

    .line 1205
    .local v6, "sentIntent":Landroid/app/PendingIntent;
    iget-boolean v8, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mSmsSendDisabled:Z

    if-eqz v8, :cond_2

    .line 1208
    const-string v8, "sendRawPdu, Device does not support sending sms."

    invoke-static {v8}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .line 1209
    iget-object v8, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const/4 v9, 0x4

    invoke-virtual {p1, v8, v9, v10}, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->onFailed(Landroid/content/Context;II)V

    .line 1272
    :cond_1
    :goto_0
    return-void

    .line 1213
    :cond_2
    if-nez v4, :cond_3

    .line 1216
    const-string v8, "sendRawPdu, Empty PDU"

    invoke-static {v8}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .line 1217
    iget-object v8, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const/4 v9, 0x3

    invoke-virtual {p1, v8, v9, v10}, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->onFailed(Landroid/content/Context;II)V

    goto :goto_0

    .line 1222
    :cond_3
    iget-object v8, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    invoke-virtual {v8}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v5

    .line 1223
    .local v5, "pm":Landroid/content/pm/PackageManager;
    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v8

    invoke-virtual {v5, v8}, Landroid/content/pm/PackageManager;->getPackagesForUid(I)[Ljava/lang/String;

    move-result-object v3

    .line 1225
    .local v3, "packageNames":[Ljava/lang/String;
    if-eqz v3, :cond_4

    array-length v8, v3

    if-nez v8, :cond_5

    .line 1227
    :cond_4
    const-string v8, "sendRawPdu, Can\'t get calling app package name: refusing to send SMS"

    invoke-static {v8}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .line 1230
    iget-object v8, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    invoke-virtual {p1, v8, v11, v10}, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->onFailed(Landroid/content/Context;II)V

    goto :goto_0

    .line 1238
    :cond_5
    const/4 v8, 0x0

    :try_start_0
    aget-object v8, v3, v8

    const/16 v9, 0x40

    invoke-virtual {v5, v8, v9}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 1248
    .local v0, "appInfo":Landroid/content/pm/PackageInfo;
    invoke-virtual {p0, v6}, Lcom/android/internal/telephony/SMSDispatcherEx;->checkAvailableToSend(Landroid/app/PendingIntent;)Z

    move-result v8

    if-eqz v8, :cond_1

    .line 1256
    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/SMSDispatcherEx;->checkDestination(Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;)Z

    move-result v8

    if-eqz v8, :cond_1

    .line 1258
    iget-object v8, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mUsageMonitor:Lcom/android/internal/telephony/SmsUsageMonitor;

    iget-object v9, v0, Landroid/content/pm/PackageInfo;->packageName:Ljava/lang/String;

    invoke-virtual {v8, v9, v11}, Lcom/android/internal/telephony/SmsUsageMonitor;->check(Ljava/lang/String;I)Z

    move-result v8

    if-nez v8, :cond_6

    .line 1259
    invoke-direct {p0, v7, p1}, Lcom/android/internal/telephony/SMSDispatcherEx;->handleUserPermitForSendRawPdu(Lcom/android/internal/telephony/SmsHeader;Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;)V

    goto :goto_0

    .line 1239
    .end local v0    # "appInfo":Landroid/content/pm/PackageInfo;
    :catch_0
    move-exception v1

    .line 1240
    .local v1, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    const-string v8, "sendRawPdu, Can\'t get calling app package info: refusing to send SMS"

    invoke-static {v8}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->e(Ljava/lang/String;)I

    .line 1243
    iget-object v8, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    invoke-virtual {p1, v8, v11, v10}, Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;->onFailed(Landroid/content/Context;II)V

    goto :goto_0

    .line 1264
    .end local v1    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    .restart local v0    # "appInfo":Landroid/content/pm/PackageInfo;
    :cond_6
    if-eqz v7, :cond_7

    .line 1265
    sget-object v8, Lcom/android/internal/telephony/SMSDispatcherEx;->isInProgressWithUserPermit:[Z

    iget-object v9, v7, Lcom/android/internal/telephony/SmsHeader;->concatRef:Lcom/android/internal/telephony/SmsHeader$ConcatRef;

    iget v9, v9, Lcom/android/internal/telephony/SmsHeader$ConcatRef;->refNumber:I

    rem-int/lit8 v9, v9, 0x5

    aput-boolean v10, v8, v9

    .line 1270
    :cond_7
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/SMSDispatcherEx;->handleSendSmsForSendRawPdu(Lcom/android/internal/telephony/SMSDispatcher$SmsTracker;)V

    goto :goto_0
.end method

.method protected sendTextLge(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/app/PendingIntent;Landroid/app/PendingIntent;Ljava/lang/String;Ljava/lang/String;IIIZ)V
    .locals 0
    .param p1, "destAddr"    # Ljava/lang/String;
    .param p2, "scAddr"    # Ljava/lang/String;
    .param p3, "text"    # Ljava/lang/String;
    .param p4, "sentIntent"    # Landroid/app/PendingIntent;
    .param p5, "deliveryIntent"    # Landroid/app/PendingIntent;
    .param p6, "callingPkg"    # Ljava/lang/String;
    .param p7, "replyAddr"    # Ljava/lang/String;
    .param p8, "confirmRead"    # I
    .param p9, "replyOption"    # I
    .param p10, "protocolId"    # I
    .param p11, "isExpectMore"    # Z

    .prologue
    .line 1029
    return-void
.end method

.method protected setMultipartTextValidityPeriod(I)V
    .locals 0
    .param p1, "validityperiod"    # I

    .prologue
    .line 1094
    sput p1, Lcom/android/internal/telephony/SMSDispatcherEx;->vp:I

    .line 1095
    return-void
.end method

.method protected setReplyAddress(Lcom/android/internal/telephony/SmsHeader;)V
    .locals 7
    .param p1, "smsHeader"    # Lcom/android/internal/telephony/SmsHeader;

    .prologue
    const/4 v3, 0x1

    .line 721
    iget-object v4, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const-string v5, "replyAddress"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-ne v4, v3, :cond_1

    invoke-static {}, Lcom/android/internal/telephony/gsm/LGGsmSmsMessage;->isReleaseOperator()Z

    move-result v4

    if-ne v4, v3, :cond_1

    .line 723
    invoke-virtual {p0}, Lcom/android/internal/telephony/SMSDispatcherEx;->getLine1Number()Ljava/lang/String;

    move-result-object v2

    .line 724
    .local v2, "replyAddr":Ljava/lang/String;
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_1

    .line 726
    invoke-static {v2}, Lcom/lge/telephony/LGPhoneNumberUtils;->KRsmsnetworkPortionToCalledPartyBCD(Ljava/lang/String;)[B

    move-result-object v0

    .line 727
    .local v0, "daBytes":[B
    new-instance v1, Lcom/android/internal/telephony/SmsHeader$ReplyAddress;

    invoke-direct {v1}, Lcom/android/internal/telephony/SmsHeader$ReplyAddress;-><init>()V

    .line 728
    .local v1, "replayaddress":Lcom/android/internal/telephony/SmsHeader$ReplyAddress;
    if-eqz v0, :cond_0

    .line 730
    iput-object v0, v1, Lcom/android/internal/telephony/SmsHeader$ReplyAddress;->replyData:[B

    .line 731
    array-length v4, v0

    add-int/lit8 v4, v4, -0x1

    mul-int/lit8 v4, v4, 0x2

    array-length v5, v0

    add-int/lit8 v5, v5, -0x1

    aget-byte v5, v0, v5

    and-int/lit16 v5, v5, 0xf0

    const/16 v6, 0xf0

    if-ne v5, v6, :cond_2

    :goto_0
    sub-int v3, v4, v3

    iput v3, v1, Lcom/android/internal/telephony/SmsHeader$ReplyAddress;->addressLength:I

    .line 736
    :cond_0
    iput-object v1, p1, Lcom/android/internal/telephony/SmsHeader;->replyAddress:Lcom/android/internal/telephony/SmsHeader$ReplyAddress;

    .line 739
    .end local v0    # "daBytes":[B
    .end local v1    # "replayaddress":Lcom/android/internal/telephony/SmsHeader$ReplyAddress;
    .end local v2    # "replyAddr":Ljava/lang/String;
    :cond_1
    return-void

    .line 731
    .restart local v0    # "daBytes":[B
    .restart local v1    # "replayaddress":Lcom/android/internal/telephony/SmsHeader$ReplyAddress;
    .restart local v2    # "replyAddr":Ljava/lang/String;
    :cond_2
    const/4 v3, 0x0

    goto :goto_0
.end method

.method public setSmsIsRoaming(Z)V
    .locals 2
    .param p1, "isRoaming"    # Z

    .prologue
    .line 1494
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "SMSDispatcherEx : setSmsIsRoaming(), isRoaming = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->d(Ljava/lang/String;)I

    .line 1495
    sput-boolean p1, Lcom/android/internal/telephony/SMSDispatcherEx;->mSubmitIsRoaming:Z

    .line 1496
    return-void
.end method

.method public setSmsPriority(I)V
    .locals 0
    .param p1, "priority"    # I

    .prologue
    .line 1366
    sput p1, Lcom/android/internal/telephony/SMSDispatcherEx;->mSubmitPriority:I

    .line 1367
    return-void
.end method

.method public smsReceptionBlockingforNIAPPolicy(Ljava/lang/String;)V
    .locals 2
    .param p1, "isOnOff"    # Ljava/lang/String;

    .prologue
    .line 1654
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[SmsDispatcher] smsReceptionBlockingforNIAPPolicy(), isOnOff = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LGSmsLog;->v(Ljava/lang/String;)I

    .line 1655
    return-void
.end method

.method protected writeOutboxMessage(JLjava/lang/String;Ljava/lang/String;ZLjava/lang/String;)Landroid/net/Uri;
    .locals 5
    .param p1, "subId"    # J
    .param p3, "address"    # Ljava/lang/String;
    .param p4, "text"    # Ljava/lang/String;
    .param p5, "requireDeliveryReport"    # Z
    .param p6, "creator"    # Ljava/lang/String;

    .prologue
    const/4 v0, 0x0

    const/4 v3, 0x1

    .line 1801
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const-string v2, "should_write_messages_for_vzw"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-ne v3, v1, :cond_1

    .line 1802
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    invoke-static {v1, p6, p3}, Lcom/android/internal/telephony/LGVerizonBranded;->shouldWriteMessageForVZW(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 1813
    :cond_0
    :goto_0
    return-object v0

    .line 1808
    :cond_1
    iget-object v1, p0, Lcom/android/internal/telephony/SMSDispatcherEx;->mContext:Landroid/content/Context;

    const-string v2, "do_not_save_sms_to_isis_short_code"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-ne v3, v1, :cond_2

    .line 1809
    invoke-direct {p0, p3}, Lcom/android/internal/telephony/SMSDispatcherEx;->isDestinationFreeShortCode(Ljava/lang/String;)Z

    move-result v1

    if-eq v3, v1, :cond_0

    .line 1813
    :cond_2
    invoke-super/range {p0 .. p6}, Lcom/android/internal/telephony/SMSDispatcher;->writeOutboxMessage(JLjava/lang/String;Ljava/lang/String;ZLjava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    goto :goto_0
.end method
