.class public Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;
.super Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;
.source "GsmServiceStateTrackerEx.java"


# static fields
.field private static final ACTION_MASTER_CLEAR_NOTIFICATION:Ljava/lang/String; = "android.intent.action.MASTER_CLEAR_NOTIFICATION"

.field static final AUTH_REJECT:I = 0xff

.field protected static final EVENT_CT_NITZ_CHECK:I = 0x3f9

.field static final GPRS_SERVICE_AND_NONGPRS_SERVICE_NOT_ALLOWED:I = 0x8

.field static final GPRS_SERVICE_NOT_ALLOWED:I = 0x7

.field static final GPRS_SERVICE_NOT_ALLOWED_IN_THIS_AREA:I = 0xe

.field static final ILLEGAL_ME:I = 0x6

.field static final ILLEGAL_MS:I = 0x3

.field static final IMSI_UNKNOWN_IN_HLR:I = 0x2

.field static final LA_NOT_ALLOWED:I = 0xc

.field static final NATIONAL_ROAMING_NOT_ALLOWED:I = 0xd

.field static final NETWORK_FAILURE:I = 0x11

.field static final NO_SUITABLE_CELLS_IN_LA:I = 0xf

.field static final PLMN_NOT_ALLOWED:I = 0xb

.field private static mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

.field static networkRejectPopUpDialog:Landroid/app/AlertDialog;

.field private static prevCause:I

.field static prev_mLAC:I

.field static prev_mRAC:I


# instance fields
.field private isMultiTimeZoneArea:Z

.field public mAirplaneMode:Z

.field private mCurMltRadioInfo:Ljava/lang/String;

.field private mKrSST:Lcom/android/internal/telephony/kr/KrServiceStateTracker;

.field private mLAC:I

.field private mLGIntentReceiver:Landroid/content/BroadcastReceiver;

.field protected mLastOperatorNumeric:Ljava/lang/String;

.field public mLimitedServiceState:Z

.field public mNetworkFailure:Z

.field mNetworkRejectPopUpDialogOnKeyListener:Landroid/content/DialogInterface$OnKeyListener;

.field protected mNitzControl:Z

.field protected mNitzWaitingTimeout:I

.field public mPermanentReject:Z

.field private mRAC:I

.field onNetworkRejectPopUpDialogClick:Landroid/content/DialogInterface$OnClickListener;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    const/4 v1, -0x1

    .line 76
    sput-object v2, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->networkRejectPopUpDialog:Landroid/app/AlertDialog;

    .line 77
    const/16 v0, 0x3e7

    sput v0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->prevCause:I

    .line 96
    sput-object v2, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    .line 116
    sput v1, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->prev_mRAC:I

    .line 118
    sput v1, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->prev_mLAC:I

    return-void
.end method

.method public constructor <init>(Lcom/android/internal/telephony/gsm/GSMPhone;)V
    .locals 10
    .param p1, "phone"    # Lcom/android/internal/telephony/gsm/GSMPhone;

    .prologue
    const/4 v7, 0x1

    const/4 v4, -0x1

    const-wide/16 v8, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    .line 198
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;-><init>(Lcom/android/internal/telephony/gsm/GSMPhone;)V

    .line 97
    iput-boolean v6, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->isMultiTimeZoneArea:Z

    .line 102
    const/16 v3, 0x3a98

    iput v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNitzWaitingTimeout:I

    .line 103
    iput-boolean v6, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNitzControl:Z

    .line 104
    const-string v3, ""

    iput-object v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLastOperatorNumeric:Ljava/lang/String;

    .line 111
    iput-object v5, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mKrSST:Lcom/android/internal/telephony/kr/KrServiceStateTracker;

    .line 115
    iput v4, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mRAC:I

    .line 117
    iput v4, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLAC:I

    .line 122
    iput-boolean v6, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mAirplaneMode:Z

    .line 126
    iput-boolean v6, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPermanentReject:Z

    .line 130
    iput-boolean v6, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLimitedServiceState:Z

    .line 131
    iput-boolean v6, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNetworkFailure:Z

    .line 138
    iput-object v5, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mCurMltRadioInfo:Ljava/lang/String;

    .line 142
    new-instance v3, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx$1;

    invoke-direct {v3, p0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx$1;-><init>(Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;)V

    iput-object v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLGIntentReceiver:Landroid/content/BroadcastReceiver;

    .line 1396
    new-instance v3, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx$5;

    invoke-direct {v3, p0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx$5;-><init>(Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;)V

    iput-object v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->onNetworkRejectPopUpDialogClick:Landroid/content/DialogInterface$OnClickListener;

    .line 1407
    new-instance v3, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx$6;

    invoke-direct {v3, p0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx$6;-><init>(Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;)V

    iput-object v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNetworkRejectPopUpDialogOnKeyListener:Landroid/content/DialogInterface$OnKeyListener;

    .line 201
    new-instance v1, Landroid/content/IntentFilter;

    invoke-direct {v1}, Landroid/content/IntentFilter;-><init>()V

    .line 203
    .local v1, "filter":Landroid/content/IntentFilter;
    const-string v3, "android.intent.action.MASTER_CLEAR_NOTIFICATION"

    invoke-virtual {v1, v3}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 206
    const-string v3, "com.lge.android.intent.action.SPN_UPDATE_REQUEST"

    invoke-virtual {v1, v3}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 209
    const-string v3, "android.intent.action.AIRPLANE_MODE"

    invoke-virtual {v1, v3}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 212
    invoke-virtual {p1}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLGIntentReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v3, v4, v1}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 215
    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v4, 0x8ff

    invoke-interface {v3, p0, v4, v5}, Lcom/android/internal/telephony/CommandsInterface;->registerLGERACInd(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 220
    const-string v3, "CTC"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_4

    const-string v3, "MANAGED_TIME_SETTING"

    invoke-static {v5, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_4

    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v3}, Lcom/android/internal/telephony/gsm/GSMPhone;->getPhoneId()I

    move-result v3

    if-eqz v3, :cond_4

    .line 223
    const-string v3, "CTC : use mTimeZoneMonitor the first subscription, because of phone switching"

    invoke-virtual {p0, v3}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 240
    :cond_0
    :goto_0
    const-string v3, "KR"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 241
    new-instance v3, Lcom/android/internal/telephony/kr/KrServiceStateTracker;

    iget-object v4, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    sget-object v5, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    invoke-direct {v3, v4, p0, v5}, Lcom/android/internal/telephony/kr/KrServiceStateTracker;-><init>(Lcom/android/internal/telephony/gsm/GSMPhone;Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;Lcom/android/internal/telephony/LgeTimeZoneMonitor;)V

    iput-object v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mKrSST:Lcom/android/internal/telephony/kr/KrServiceStateTracker;

    .line 246
    :cond_1
    invoke-static {}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->getSavedNeedFixZone()Z

    move-result v3

    iput-boolean v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNeedFixZoneAfterNitz:Z

    .line 247
    iget-boolean v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNeedFixZoneAfterNitz:Z

    if-eqz v3, :cond_2

    .line 248
    invoke-static {}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->getSavedZoneOffset()I

    move-result v3

    iput v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mZoneOffset:I

    .line 249
    invoke-static {}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->getSavedZoneDst()Z

    move-result v3

    iput-boolean v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mZoneDst:Z

    .line 250
    invoke-static {}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->getSavedZoneTime()J

    move-result-wide v4

    iput-wide v4, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mZoneTime:J

    .line 251
    invoke-static {}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->getSavedTime()J

    move-result-wide v4

    iput-wide v4, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSavedTime:J

    .line 252
    invoke-static {}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->getSavedAtTime()J

    move-result-wide v4

    iput-wide v4, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSavedAtTime:J

    .line 253
    const-string v3, "TimeZone correction was delayed by Phone Switching!"

    invoke-virtual {p0, v3}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 256
    invoke-static {v6}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->setSavedNeedFixZone(Z)V

    .line 257
    invoke-static {v6}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->setSavedZoneOffset(I)V

    .line 258
    invoke-static {v6}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->setSavedZoneDst(Z)V

    .line 259
    invoke-static {v8, v9}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->setSavedZoneTime(J)V

    .line 260
    invoke-static {v8, v9}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->setSavedTime(J)V

    .line 261
    invoke-static {v8, v9}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->setSavedAtTime(J)V

    .line 266
    :cond_2
    const-string v3, "CTC"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 267
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v3

    invoke-virtual {v3}, Landroid/telephony/TelephonyManager;->getPhoneCount()I

    move-result v3

    if-ne v3, v7, :cond_6

    .line 268
    invoke-direct {p0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->StartTimeZoneMonitor()V

    .line 286
    :cond_3
    :goto_1
    return-void

    .line 227
    :cond_4
    const-string v3, "MANAGED_TIME_SETTING"

    invoke-static {v5, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 228
    sget-object v3, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    if-nez v3, :cond_5

    .line 229
    invoke-static {}, Lcom/android/internal/telephony/LgeTimeZoneMonitor;->getDefault()Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    move-result-object v3

    sput-object v3, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    .line 232
    :cond_5
    sget-object v3, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    if-eqz v3, :cond_0

    .line 233
    sget-object v3, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    invoke-virtual {p0, v3, v7, v5}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->registerForNetworkAttached(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 234
    sget-object v3, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    invoke-virtual {v3, p0}, Lcom/android/internal/telephony/LgeTimeZoneMonitor;->setServiceStateTracker(Lcom/android/internal/telephony/ServiceStateTracker;)V

    goto/16 :goto_0

    .line 270
    :cond_6
    const/4 v2, 0x0

    .line 271
    .local v2, "iActivePhoneId":I
    invoke-static {}, Landroid/telephony/SubscriptionManager;->getActiveSubInfoList()Ljava/util/List;

    move-result-object v0

    .line 272
    .local v0, "activeSubList":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/SubInfoRecord;>;"
    if-eqz v0, :cond_7

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v3

    if-nez v3, :cond_8

    .line 273
    :cond_7
    const-string v3, "CTC : not use TimeZoneMonitor, because there is no active phone at create phone"

    invoke-virtual {p0, v3}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_1

    .line 275
    :cond_8
    invoke-interface {v0, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/telephony/SubInfoRecord;

    iget-wide v4, v3, Landroid/telephony/SubInfoRecord;->subId:J

    long-to-int v3, v4

    int-to-long v4, v3

    invoke-static {v4, v5}, Landroid/telephony/SubscriptionManager;->getPhoneId(J)I

    move-result v2

    .line 276
    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v3}, Lcom/android/internal/telephony/gsm/GSMPhone;->getPhoneId()I

    move-result v3

    if-ne v2, v3, :cond_9

    .line 277
    const-string v3, "CTC : iActiveSub == mSubscription at create phone"

    invoke-virtual {p0, v3}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 278
    invoke-direct {p0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->StartTimeZoneMonitor()V

    goto :goto_1

    .line 280
    :cond_9
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "CTC : the first active phone\'s PhoneId is "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_1
.end method

.method private StartTimeZoneMonitor()V
    .locals 1

    .prologue
    .line 730
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNitzControl:Z

    .line 731
    const-string v0, "CTC : StartTimeZoneMonitor"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 732
    return-void
.end method

.method private StopTimeZoneMonitor()V
    .locals 2

    .prologue
    const/16 v1, 0x3f9

    .line 735
    iget-boolean v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNitzControl:Z

    if-eqz v0, :cond_0

    .line 736
    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->hasMessages(I)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 737
    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->removeMessages(I)V

    .line 740
    :cond_0
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNitzControl:Z

    .line 741
    const-string v0, "CTC : StopTimeZoneMonitor"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 742
    return-void
.end method

.method static synthetic access$000(Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    .line 74
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->setAndBroadcastNetworkSetTimeZone(Ljava/lang/String;)V

    return-void
.end method

.method private checkInternationalRoamingForATT()Z
    .locals 15

    .prologue
    const/4 v14, 0x2

    const/4 v13, 0x5

    const/4 v12, 0x3

    const/4 v9, 0x1

    const/4 v8, 0x0

    .line 1092
    const/4 v10, 0x7

    new-array v7, v10, [Ljava/lang/String;

    const-string v10, "310"

    aput-object v10, v7, v8

    const-string v10, "311"

    aput-object v10, v7, v9

    const-string v10, "312"

    aput-object v10, v7, v14

    const-string v10, "313"

    aput-object v10, v7, v12

    const/4 v10, 0x4

    const-string v11, "314"

    aput-object v11, v7, v10

    const-string v10, "315"

    aput-object v10, v7, v13

    const/4 v10, 0x6

    const-string v11, "316"

    aput-object v11, v7, v10

    .line 1093
    .local v7, "usaMccforATT":[Ljava/lang/String;
    new-array v2, v13, [Ljava/lang/String;

    const-string v10, "310110"

    aput-object v10, v2, v8

    const-string v10, "310140"

    aput-object v10, v2, v9

    const-string v10, "310400"

    aput-object v10, v2, v14

    const-string v10, "310470"

    aput-object v10, v2, v12

    const/4 v10, 0x4

    const-string v11, "311170"

    aput-object v11, v2, v10

    .line 1094
    .local v2, "international_plmn":[Ljava/lang/String;
    iget-object v10, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v10}, Landroid/telephony/ServiceState;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v6

    .line 1096
    .local v6, "operatorNumeric":Ljava/lang/String;
    if-eqz v6, :cond_0

    invoke-static {v6}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v10

    if-eqz v10, :cond_1

    .line 1128
    :cond_0
    :goto_0
    return v8

    .line 1100
    :cond_1
    invoke-virtual {v6, v8, v12}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    .line 1102
    .local v4, "mccforAtt":Ljava/lang/String;
    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v10

    if-eq v10, v13, :cond_2

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v10

    const/4 v11, 0x6

    if-eq v10, v11, :cond_2

    .line 1104
    const-string v9, "checkInternationalRoamingForATT(). PLMN length error "

    invoke-virtual {p0, v9}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 1110
    :cond_2
    move-object v0, v2

    .local v0, "arr$":[Ljava/lang/String;
    array-length v3, v0

    .local v3, "len$":I
    const/4 v1, 0x0

    .local v1, "i$":I
    :goto_1
    if-ge v1, v3, :cond_4

    aget-object v5, v0, v1

    .line 1111
    .local v5, "numeric":Ljava/lang/String;
    invoke-virtual {v6, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_3

    .line 1113
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "checkInternationalRoamingForATT(). operatorNumeric "

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p0, v8}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    move v8, v9

    .line 1115
    goto :goto_0

    .line 1110
    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 1119
    .end local v5    # "numeric":Ljava/lang/String;
    :cond_4
    move-object v0, v7

    array-length v3, v0

    const/4 v1, 0x0

    :goto_2
    if-ge v1, v3, :cond_6

    aget-object v5, v0, v1

    .line 1120
    .restart local v5    # "numeric":Ljava/lang/String;
    invoke-virtual {v4, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_5

    .line 1122
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "checkInternationalRoamingForATT(). mccforAtt "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {p0, v9}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 1119
    :cond_5
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .end local v5    # "numeric":Ljava/lang/String;
    :cond_6
    move v8, v9

    .line 1128
    goto :goto_0
.end method

.method private checkRejectCause(I)Z
    .locals 1
    .param p1, "curCause"    # I

    .prologue
    .line 1347
    sget v0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->prevCause:I

    if-eq v0, p1, :cond_0

    .line 1348
    sput p1, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->prevCause:I

    .line 1349
    const/4 v0, 0x1

    .line 1352
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private createNetworkRejectPopUpDialog(I)V
    .locals 5
    .param p1, "rejectCode"    # I

    .prologue
    .line 1361
    const-string v2, "US"

    const-string v3, "ATT"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "US"

    const-string v3, "AIO"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    const/4 v2, 0x0

    const-string v3, "trf_based_att"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 1364
    :cond_0
    const-string v2, "ro.factorytest"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1365
    .local v0, "FACTORY_PROPERTY":Ljava/lang/String;
    if-eqz v0, :cond_2

    .line 1366
    const-string v2, "2"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 1367
    const-string v2, "Don\'t display the Reject Pop Up in AAT mode"

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 1394
    .end local v0    # "FACTORY_PROPERTY":Ljava/lang/String;
    :cond_1
    :goto_0
    return-void

    .line 1374
    :cond_2
    new-instance v1, Landroid/app/AlertDialog$Builder;

    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v2}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 1376
    .local v1, "builder":Landroid/app/AlertDialog$Builder;
    const-string v2, "GsmSST"

    const-string v3, "Show Network Reject PopUp Dialog"

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1378
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->rejectErrorMessage(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v3

    sget v4, Lcom/lge/internal/R$string;->dlg_ok:I

    invoke-virtual {v3, v4}, Landroid/content/res/Resources;->getText(I)Ljava/lang/CharSequence;

    move-result-object v3

    invoke-interface {v3}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->onNetworkRejectPopUpDialogClick:Landroid/content/DialogInterface$OnClickListener;

    invoke-virtual {v2, v3, v4}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 1381
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->checkRejectCause(I)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 1382
    sget-object v2, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->networkRejectPopUpDialog:Landroid/app/AlertDialog;

    if-eqz v2, :cond_3

    sget-object v2, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->networkRejectPopUpDialog:Landroid/app/AlertDialog;

    invoke-virtual {v2}, Landroid/app/AlertDialog;->isShowing()Z

    move-result v2

    if-eqz v2, :cond_3

    .line 1383
    sget-object v2, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->networkRejectPopUpDialog:Landroid/app/AlertDialog;

    invoke-virtual {v2}, Landroid/app/AlertDialog;->dismiss()V

    .line 1385
    :cond_3
    invoke-virtual {v1}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v2

    sput-object v2, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->networkRejectPopUpDialog:Landroid/app/AlertDialog;

    .line 1386
    sget-object v2, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->networkRejectPopUpDialog:Landroid/app/AlertDialog;

    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNetworkRejectPopUpDialogOnKeyListener:Landroid/content/DialogInterface$OnKeyListener;

    invoke-virtual {v2, v3}, Landroid/app/AlertDialog;->setOnKeyListener(Landroid/content/DialogInterface$OnKeyListener;)V

    .line 1387
    sget-object v2, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->networkRejectPopUpDialog:Landroid/app/AlertDialog;

    invoke-virtual {v2}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v2

    const/16 v3, 0x7d3

    invoke-virtual {v2, v3}, Landroid/view/Window;->setType(I)V

    .line 1388
    sget-object v2, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->networkRejectPopUpDialog:Landroid/app/AlertDialog;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/app/AlertDialog;->setCanceledOnTouchOutside(Z)V

    .line 1389
    sget-object v2, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->networkRejectPopUpDialog:Landroid/app/AlertDialog;

    invoke-virtual {v2}, Landroid/app/AlertDialog;->show()V

    goto :goto_0
.end method

.method private enhanceNetworkUsability(I)V
    .locals 3
    .param p1, "rejCode"    # I

    .prologue
    const/4 v2, 0x1

    .line 1253
    const-string v0, "EU"

    const-string v1, "OPEN"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1254
    const/4 v0, 0x2

    if-eq p1, v0, :cond_0

    const/4 v0, 0x3

    if-eq p1, v0, :cond_0

    const/4 v0, 0x6

    if-eq p1, v0, :cond_0

    const/16 v0, 0x8

    if-eq p1, v0, :cond_0

    const/16 v0, 0xff

    if-ne p1, v0, :cond_1

    .line 1259
    :cond_0
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->createNetworkRejectPopUpDialog(I)V

    .line 1263
    :cond_1
    const-string v0, "US"

    const-string v1, "ATT"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    const-string v0, "US"

    const-string v1, "AIO"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    const/4 v0, 0x0

    const-string v1, "trf_based_att"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 1266
    :cond_2
    sparse-switch p1, :sswitch_data_0

    .line 1292
    :cond_3
    :goto_0
    return-void

    .line 1271
    :sswitch_0
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->createNetworkRejectPopUpDialog(I)V

    goto :goto_0

    .line 1278
    :sswitch_1
    iput-boolean v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLimitedServiceState:Z

    .line 1279
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->updateSpnDisplay()V

    goto :goto_0

    .line 1284
    :sswitch_2
    iput-boolean v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNetworkFailure:Z

    .line 1285
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->updateSpnDisplay()V

    goto :goto_0

    .line 1266
    :sswitch_data_0
    .sparse-switch
        0x2 -> :sswitch_0
        0x3 -> :sswitch_0
        0x6 -> :sswitch_0
        0xb -> :sswitch_1
        0xc -> :sswitch_1
        0xd -> :sswitch_1
        0xf -> :sswitch_1
        0x11 -> :sswitch_2
        0xff -> :sswitch_0
    .end sparse-switch
.end method

.method private getAutoTimeZone()Z
    .locals 4

    .prologue
    const/4 v1, 0x1

    .line 670
    :try_start_0
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v2}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "auto_time_zone"

    invoke-static {v2, v3}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/provider/Settings$SettingNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v2

    if-lez v2, :cond_0

    .line 673
    :goto_0
    return v1

    .line 670
    :cond_0
    const/4 v1, 0x0

    goto :goto_0

    .line 672
    :catch_0
    move-exception v0

    .line 673
    .local v0, "snfe":Landroid/provider/Settings$SettingNotFoundException;
    goto :goto_0
.end method

.method private radioLogForMLT(Landroid/os/Message;)V
    .locals 9
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v7, 0x1

    const/4 v3, 0x0

    .line 1464
    const-string v6, "ro.debuggable"

    const-string v8, "0"

    invoke-static {v6, v8}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    const-string v8, "1"

    invoke-virtual {v6, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_0

    move v3, v7

    .line 1465
    .local v3, "isDebugMode":Z
    :cond_0
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 1467
    .local v0, "ar":Landroid/os/AsyncResult;
    const/4 v4, 0x0

    .line 1468
    .local v4, "mltRadioInfo":Ljava/lang/String;
    const/4 v5, 0x0

    .line 1470
    .local v5, "mltSendIntent":Z
    if-eqz v0, :cond_4

    iget-object v6, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    if-eqz v6, :cond_4

    .line 1472
    :try_start_0
    iget-object v6, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v6, [Ljava/lang/String;

    check-cast v6, [Ljava/lang/String;

    const/4 v8, 0x0

    aget-object v4, v6, v8
    :try_end_0
    .catch Ljava/lang/ClassCastException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1473
    const/4 v5, 0x1

    .line 1482
    :goto_0
    iget-object v6, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mCurMltRadioInfo:Ljava/lang/String;

    if-eqz v6, :cond_1

    if-eqz v4, :cond_1

    iget-object v6, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mCurMltRadioInfo:Ljava/lang/String;

    invoke-virtual {v6, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_1

    .line 1483
    const-string v6, "LOGRadioInfo : logRadioInfo is equal to mCurlogRadioInfo"

    invoke-virtual {p0, v6}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 1484
    const/4 v5, 0x0

    .line 1489
    :cond_1
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "LOGRadioInfo : broadcast "

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p0, v6}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 1491
    if-eqz v3, :cond_2

    .line 1492
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "LOGRadioInfo : mCurlogRadioInfo "

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v8, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mCurMltRadioInfo:Ljava/lang/String;

    invoke-virtual {v6, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p0, v6}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 1495
    :cond_2
    if-ne v5, v7, :cond_3

    .line 1496
    iput-object v4, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mCurMltRadioInfo:Ljava/lang/String;

    .line 1498
    new-instance v2, Landroid/content/Intent;

    const-string v6, "com.lge.intent.action.LOG_RADIO_INFO"

    invoke-direct {v2, v6}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1499
    .local v2, "intent":Landroid/content/Intent;
    const/high16 v6, 0x20000000

    invoke-virtual {v2, v6}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 1500
    const-string v6, "exceptionType"

    const/16 v7, 0xf

    invoke-virtual {v2, v6, v7}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .line 1501
    const-string v6, "ModemLogData"

    iget-object v7, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mCurMltRadioInfo:Ljava/lang/String;

    invoke-virtual {v2, v6, v7}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 1502
    iget-object v6, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v6}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v6

    invoke-virtual {v6, v2}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    .line 1505
    .end local v2    # "intent":Landroid/content/Intent;
    :cond_3
    :goto_1
    return-void

    .line 1474
    :catch_0
    move-exception v1

    .line 1475
    .local v1, "ex":Ljava/lang/ClassCastException;
    goto :goto_1

    .line 1478
    .end local v1    # "ex":Ljava/lang/ClassCastException;
    :cond_4
    const-string v6, "LOGRadioInfo : ar or ar.result = null"

    invoke-virtual {p0, v6}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private rejectErrorMessage(I)Ljava/lang/String;
    .locals 3
    .param p1, "rejectCode"    # I

    .prologue
    .line 1294
    const/4 v0, 0x0

    .line 1296
    .local v0, "message":Ljava/lang/String;
    const-string v1, "US"

    const-string v2, "ATT"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "US"

    const-string v2, "AIO"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const/4 v1, 0x0

    const-string v2, "trf_based_att"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 1299
    :cond_0
    sparse-switch p1, :sswitch_data_0

    .line 1344
    :goto_0
    return-object v0

    .line 1301
    :sswitch_0
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v1

    sget v2, Lcom/lge/internal/R$string;->imsi_unknown_hlr:I

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getText(I)Ljava/lang/CharSequence;

    move-result-object v1

    invoke-interface {v1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1302
    goto :goto_0

    .line 1304
    :sswitch_1
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v1

    sget v2, Lcom/lge/internal/R$string;->illegal_ms:I

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getText(I)Ljava/lang/CharSequence;

    move-result-object v1

    invoke-interface {v1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1305
    goto :goto_0

    .line 1307
    :sswitch_2
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v1

    sget v2, Lcom/lge/internal/R$string;->illegal_me:I

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getText(I)Ljava/lang/CharSequence;

    move-result-object v1

    invoke-interface {v1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1308
    goto :goto_0

    .line 1310
    :sswitch_3
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v1

    sget v2, Lcom/lge/internal/R$string;->authentication_reject:I

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getText(I)Ljava/lang/CharSequence;

    move-result-object v1

    invoke-interface {v1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1311
    goto :goto_0

    .line 1318
    :cond_1
    sparse-switch p1, :sswitch_data_1

    goto :goto_0

    .line 1320
    :sswitch_4
    const-string v0, "IMSI_UNKNOWN_IN_HLR"

    .line 1321
    goto :goto_0

    .line 1323
    :sswitch_5
    const-string v0, "ILLEGAL_MS"

    .line 1324
    goto :goto_0

    .line 1326
    :sswitch_6
    const-string v0, "ILLEGAL_ME"

    .line 1327
    goto :goto_0

    .line 1329
    :sswitch_7
    const-string v0, "GPRS_SERVICE_NOT_ALLOWED"

    .line 1330
    goto :goto_0

    .line 1332
    :sswitch_8
    const-string v0, "GPRS_SERVICE_AND_NONGPRS_SERVICE_NOT_ALLOWED"

    .line 1333
    goto :goto_0

    .line 1335
    :sswitch_9
    const-string v0, "GPRS_SERVICE_NOT_ALLOWED_IN_THIS_AREA"

    .line 1336
    goto :goto_0

    .line 1338
    :sswitch_a
    const-string v0, "AUTH_REJECT"

    goto :goto_0

    .line 1299
    nop

    :sswitch_data_0
    .sparse-switch
        0x2 -> :sswitch_0
        0x3 -> :sswitch_1
        0x6 -> :sswitch_2
        0xff -> :sswitch_3
    .end sparse-switch

    .line 1318
    :sswitch_data_1
    .sparse-switch
        0x2 -> :sswitch_4
        0x3 -> :sswitch_5
        0x6 -> :sswitch_6
        0x7 -> :sswitch_7
        0x8 -> :sswitch_8
        0xe -> :sswitch_9
        0xff -> :sswitch_a
    .end sparse-switch
.end method

.method private sendMultiTimezoneIntentCTC()V
    .locals 4

    .prologue
    .line 860
    iget-boolean v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNitzControl:Z

    if-nez v2, :cond_0

    .line 861
    const-string v2, "CTC : mNitzControl false, do not send multi time zone intent"

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 874
    :goto_0
    return-void

    .line 864
    :cond_0
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v2}, Landroid/telephony/ServiceState;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v1

    .line 865
    .local v1, "operatorNumeric":Ljava/lang/String;
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_1

    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLastOperatorNumeric:Ljava/lang/String;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_1

    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLastOperatorNumeric:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 867
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "CTC : already sent multi time zone intent operatorNumeric="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 870
    :cond_1
    iput-object v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLastOperatorNumeric:Ljava/lang/String;

    .line 871
    new-instance v0, Landroid/content/Intent;

    const-string v2, "com.lge.intent.action.MULTI_TIMEZONE_CT"

    invoke-direct {v0, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 872
    .local v0, "intent":Landroid/content/Intent;
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v2}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v2

    sget-object v3, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v2, v0, v3}, Landroid/content/Context;->sendStickyBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    .line 873
    const-string v2, "CTC : send multi time zone intent"

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private sendNitzIntent(Z)V
    .locals 8
    .param p1, "bSetTime"    # Z

    .prologue
    const/4 v7, 0x0

    .line 768
    iget-object v5, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v5}, Landroid/telephony/ServiceState;->getVoiceRegState()I

    move-result v5

    if-nez v5, :cond_0

    invoke-direct {p0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->getAutoTimeZone()Z

    move-result v5

    if-nez v5, :cond_2

    .line 769
    :cond_0
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "CTC : not send intent, mSS.getVoiceRegState()="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v6}, Landroid/telephony/ServiceState;->getVoiceRegState()I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " getAutoTimeZone()="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-direct {p0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->getAutoTimeZone()Z

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 794
    :cond_1
    :goto_0
    return-void

    .line 772
    :cond_2
    iget-object v5, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v5}, Landroid/telephony/ServiceState;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v2

    .line 773
    .local v2, "operatorNumeric":Ljava/lang/String;
    if-eqz v2, :cond_1

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v5

    const/4 v6, 0x4

    if-le v5, v6, :cond_1

    .line 774
    const/4 v5, 0x3

    invoke-virtual {v2, v7, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    .line 775
    .local v1, "mcc":Ljava/lang/String;
    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v5

    invoke-static {v5}, Lcom/android/internal/telephony/MccTable;->countryCodeForMcc(I)Ljava/lang/String;

    move-result-object v0

    .line 776
    .local v0, "iso":Ljava/lang/String;
    invoke-static {v0}, Landroid/util/TimeUtils;->getTimeZonesWithUniqueOffsets(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v3

    .line 777
    .local v3, "uniqueZones":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/util/TimeZone;>;"
    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v5

    const/4 v6, 0x1

    if-ne v5, v6, :cond_4

    .line 778
    invoke-virtual {v3, v7}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/util/TimeZone;

    .line 779
    .local v4, "zone":Ljava/util/TimeZone;
    invoke-virtual {v4}, Ljava/util/TimeZone;->getID()Ljava/lang/String;

    move-result-object v5

    if-eqz v5, :cond_1

    .line 780
    if-eqz p1, :cond_3

    .line 781
    invoke-virtual {v4}, Ljava/util/TimeZone;->getID()Ljava/lang/String;

    move-result-object v5

    invoke-direct {p0, v5}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->setAndBroadcastNetworkSetTimeZone(Ljava/lang/String;)V

    .line 783
    :cond_3
    iget-boolean v5, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNitzControl:Z

    if-eqz v5, :cond_1

    .line 784
    invoke-virtual {v4}, Ljava/util/TimeZone;->getID()Ljava/lang/String;

    move-result-object v5

    invoke-direct {p0, v5}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->sendSingleTimezoneIntentCTC(Ljava/lang/String;)V

    goto :goto_0

    .line 788
    .end local v4    # "zone":Ljava/util/TimeZone;
    :cond_4
    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v5

    const/4 v6, 0x2

    if-le v5, v6, :cond_1

    .line 789
    iget-boolean v5, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNitzControl:Z

    if-eqz v5, :cond_1

    .line 790
    invoke-direct {p0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->sendMultiTimezoneIntentCTC()V

    goto :goto_0
.end method

.method private sendSingleTimezoneIntentCTC(Ljava/lang/String;)V
    .locals 10
    .param p1, "zoneId"    # Ljava/lang/String;

    .prologue
    const/4 v7, 0x4

    const/4 v6, 0x3

    const/4 v9, 0x0

    .line 797
    iget-boolean v5, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNitzControl:Z

    if-nez v5, :cond_1

    .line 798
    const-string v5, "CTC : mNitzControl false, do not send single time zone intent"

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 857
    :cond_0
    :goto_0
    return-void

    .line 801
    :cond_1
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_2

    .line 802
    const-string v5, "CTC : zoneId is empty, do not send single time zone intent"

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 805
    :cond_2
    iget-object v5, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v5}, Landroid/telephony/ServiceState;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v3

    .line 806
    .local v3, "operatorNumeric":Ljava/lang/String;
    const-string v2, ""

    .line 807
    .local v2, "mcc":Ljava/lang/String;
    const-string v1, ""

    .line 808
    .local v1, "lastmcc":Ljava/lang/String;
    if-eqz v3, :cond_3

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v5

    if-le v5, v7, :cond_3

    .line 809
    invoke-virtual {v3, v9, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    .line 811
    :cond_3
    iget-object v5, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLastOperatorNumeric:Ljava/lang/String;

    if-eqz v5, :cond_4

    iget-object v5, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLastOperatorNumeric:Ljava/lang/String;

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v5

    if-le v5, v7, :cond_4

    .line 812
    iget-object v5, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLastOperatorNumeric:Ljava/lang/String;

    invoke-virtual {v5, v9, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    .line 814
    :cond_4
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_5

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_5

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_5

    .line 816
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "CTC : already sent single time zone intent mcc="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 819
    :cond_5
    const-string v5, "Asia/Shanghai"

    invoke-virtual {p1, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_6

    .line 820
    const-string v5, "CTC : zoneID is Asia/Shanghai"

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 823
    :cond_6
    iput-object v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLastOperatorNumeric:Ljava/lang/String;

    .line 824
    move-object v4, p1

    .line 826
    .local v4, "settingZoneId":Ljava/lang/String;
    new-instance v5, Landroid/app/AlertDialog$Builder;

    iget-object v6, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v6}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v6

    sget v7, Lcom/lge/internal/R$style;->Theme_LGE_White_Dialog_Alert:I

    invoke-direct {v5, v6, v7}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;I)V

    sget v6, Lcom/lge/internal/R$string;->sp_time_display_mode:I

    invoke-virtual {v5, v6}, Landroid/app/AlertDialog$Builder;->setTitle(I)Landroid/app/AlertDialog$Builder;

    move-result-object v5

    sget v6, Lcom/lge/internal/R$array;->time_display_mode:I

    const/4 v7, -0x1

    new-instance v8, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx$4;

    invoke-direct {v8, p0, v4}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx$4;-><init>(Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;Ljava/lang/String;)V

    invoke-virtual {v5, v6, v7, v8}, Landroid/app/AlertDialog$Builder;->setSingleChoiceItems(IILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v5

    sget v6, Lcom/lge/internal/R$string;->cancel:I

    new-instance v7, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx$3;

    invoke-direct {v7, p0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx$3;-><init>(Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;)V

    invoke-virtual {v5, v6, v7}, Landroid/app/AlertDialog$Builder;->setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v5

    invoke-virtual {v5}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    .line 851
    .local v0, "guideLocalTimeSettingDialog":Landroid/app/AlertDialog;
    if-eqz v0, :cond_0

    .line 852
    const-string v5, "CTC : Show popup to lead to be automatic time setting enabled"

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 853
    invoke-virtual {v0, v9}, Landroid/app/AlertDialog;->setCancelable(Z)V

    .line 854
    invoke-virtual {v0}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v5

    const/16 v6, 0x7d3

    invoke-virtual {v5, v6}, Landroid/view/Window;->setType(I)V

    .line 855
    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    goto/16 :goto_0
.end method

.method private setAndBroadcastNetworkSetTimeZone(Ljava/lang/String;)V
    .locals 4
    .param p1, "zoneId"    # Ljava/lang/String;

    .prologue
    .line 679
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "setAndBroadcastNetworkSetTimeZone: setTimeZone="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 681
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v2}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v2

    const-string v3, "alarm"

    invoke-virtual {v2, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/AlarmManager;

    .line 683
    .local v0, "alarm":Landroid/app/AlarmManager;
    invoke-virtual {v0, p1}, Landroid/app/AlarmManager;->setTimeZone(Ljava/lang/String;)V

    .line 684
    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.intent.action.NETWORK_SET_TIMEZONE"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 685
    .local v1, "intent":Landroid/content/Intent;
    const/high16 v2, 0x20000000

    invoke-virtual {v1, v2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 686
    const-string v2, "time-zone"

    invoke-virtual {v1, v2, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 687
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v2}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v2

    sget-object v3, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v2, v1, v3}, Landroid/content/Context;->sendStickyBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    .line 689
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "setAndBroadcastNetworkSetTimeZone: call alarm.setTimeZone and broadcast zoneId="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 692
    return-void
.end method

.method private setNetwork_GPRS_State_Change()V
    .locals 3

    .prologue
    .line 1043
    iget v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mRAC:I

    if-eqz v1, :cond_0

    iget v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mRAC:I

    const/16 v2, 0xff

    if-eq v1, v2, :cond_0

    iget v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLAC:I

    if-eqz v1, :cond_0

    iget v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLAC:I

    const v2, 0xffff

    if-eq v1, v2, :cond_0

    .line 1044
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.lge.android.intent.action.ACTION_NETWORK_GRPS_STATE_CHANGE"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 1045
    .local v0, "intent":Landroid/content/Intent;
    const/high16 v1, 0x20000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 1047
    const-string v1, "rac"

    iget v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mRAC:I

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .line 1048
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/Context;->sendStickyBroadcast(Landroid/content/Intent;)V

    .line 1049
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Send intent with GPRS state change rac =  "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mRAC:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " lac = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLAC:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 1054
    .end local v0    # "intent":Landroid/content/Intent;
    :goto_0
    return-void

    .line 1052
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "No need to send intent rac = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mRAC:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " lac = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLAC:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private useDataRegStateForLTESingleMode()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 899
    const-string v0, "lgu_lte_single_device"

    invoke-static {v1, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "support_usim_compatibility"

    invoke-static {v1, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 901
    :cond_0
    const-string v0, "45006"

    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 902
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getDataRegState()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/telephony/ServiceState;->setVoiceRegState(I)V

    .line 905
    :cond_1
    return-void
.end method


# virtual methods
.method protected changeDisplayRuleforESAME(Lcom/android/internal/telephony/uicc/IccRecords;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Boolean;Ljava/lang/Boolean;)[Z
    .locals 9
    .param p1, "iccRecords"    # Lcom/android/internal/telephony/uicc/IccRecords;
    .param p2, "plmn"    # Ljava/lang/String;
    .param p3, "spn"    # Ljava/lang/String;
    .param p4, "showSpn"    # Ljava/lang/Boolean;
    .param p5, "showPlmn"    # Ljava/lang/Boolean;

    .prologue
    const/4 v8, 0x7

    const/4 v7, 0x0

    const/4 v6, 0x1

    .line 1571
    const/4 v4, 0x2

    new-array v0, v4, [Z

    invoke-virtual {p4}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v4

    aput-boolean v4, v0, v7

    invoke-virtual {p5}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v4

    aput-boolean v4, v0, v6

    .line 1572
    .local v0, "displayrule":[Z
    const/4 v2, 0x0

    .line 1573
    .local v2, "sim_imsi":Ljava/lang/String;
    const/4 v1, 0x0

    .line 1574
    .local v1, "oper_imsi":Ljava/lang/String;
    iget-object v4, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v4}, Lcom/android/internal/telephony/gsm/GSMPhone;->getSubscriberId()Ljava/lang/String;

    move-result-object v3

    .line 1575
    .local v3, "subscriberId":Ljava/lang/String;
    if-eqz p1, :cond_0

    .line 1576
    invoke-virtual {p1}, Lcom/android/internal/telephony/uicc/IccRecords;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v2

    .line 1578
    :cond_0
    iget-object v4, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v4}, Landroid/telephony/ServiceState;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v1

    .line 1579
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[changeDisplayRuleforESAME] sim_imsi: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " oper_imsi: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " regioncode: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    sget-object v5, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->regioncode:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " spn: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " plmn: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " showSpn: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " showPlmn: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " SubscriberId: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 1581
    if-nez v2, :cond_1

    if-nez v1, :cond_1

    .line 1604
    :goto_0
    return-object v0

    .line 1585
    :cond_1
    if-eqz v3, :cond_5

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    const/4 v5, 0x6

    if-le v4, v5, :cond_5

    if-eqz v1, :cond_5

    const-string v4, "5200019"

    invoke-virtual {v3, v7, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_2

    const-string v4, "5200020"

    invoke-virtual {v3, v7, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_5

    :cond_2
    const-string v4, "52099"

    invoke-virtual {v1, v4}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v4

    if-nez v4, :cond_5

    .line 1587
    aput-boolean v6, v0, v7

    .line 1588
    aput-boolean v6, v0, v6

    .line 1597
    :cond_3
    :goto_1
    if-eqz p2, :cond_4

    if-eqz p3, :cond_4

    iget-object v4, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v4}, Landroid/telephony/ServiceState;->getRoaming()Z

    move-result v4

    if-nez v4, :cond_4

    .line 1598
    invoke-virtual {p2, p3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 1599
    aput-boolean v7, v0, v7

    .line 1600
    aput-boolean v6, v0, v6

    .line 1603
    :cond_4
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[changeDisplayRuleforESAME] showSpn: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    aget-boolean v5, v0, v7

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " showPlmn: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    aget-boolean v5, v0, v6

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 1590
    :cond_5
    if-eqz v2, :cond_3

    if-eqz v1, :cond_3

    const-string v4, "60400"

    invoke-virtual {v2, v4}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v4

    if-nez v4, :cond_3

    if-eqz p2, :cond_3

    if-eqz p3, :cond_3

    iget-object v4, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v4}, Landroid/telephony/ServiceState;->getRoaming()Z

    move-result v4

    if-nez v4, :cond_3

    .line 1592
    invoke-virtual {p4}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v4

    if-ne v4, v6, :cond_3

    invoke-virtual {p5}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v4

    if-ne v4, v6, :cond_3

    invoke-virtual {p3, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 1593
    aput-boolean v7, v0, v6

    goto :goto_1
.end method

.method protected changeSPNnameforESAME(Lcom/android/internal/telephony/uicc/IccRecords;Ljava/lang/String;)Ljava/lang/String;
    .locals 9
    .param p1, "iccRecords"    # Lcom/android/internal/telephony/uicc/IccRecords;
    .param p2, "Spn"    # Ljava/lang/String;

    .prologue
    const/4 v8, 0x7

    const/4 v7, 0x6

    const/4 v6, 0x0

    .line 1511
    const/4 v2, 0x0

    .line 1512
    .local v2, "sim_imsi":Ljava/lang/String;
    const/4 v0, 0x0

    .line 1513
    .local v0, "mcc":Ljava/lang/String;
    const/4 v1, 0x0

    .line 1514
    .local v1, "mcc_sim":I
    iget-object v4, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v4}, Lcom/android/internal/telephony/gsm/GSMPhone;->getSubscriberId()Ljava/lang/String;

    move-result-object v3

    .line 1515
    .local v3, "subscriberId":Ljava/lang/String;
    if-eqz p1, :cond_0

    .line 1516
    invoke-virtual {p1}, Lcom/android/internal/telephony/uicc/IccRecords;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v2

    .line 1518
    :cond_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[changeSPNnameforESAME] GsmServiceStateTrackerEx sim_imsi: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " SPN name: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 1519
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[changeSPNnameforESAME] GsmServiceStateTrackerEx SubscriberId: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 1520
    if-nez p2, :cond_2

    .line 1566
    .end local p2    # "Spn":Ljava/lang/String;
    :cond_1
    :goto_0
    return-object p2

    .line 1523
    .restart local p2    # "Spn":Ljava/lang/String;
    :cond_2
    if-eqz v2, :cond_1

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v4

    const/4 v5, 0x4

    if-le v4, v5, :cond_1

    .line 1524
    const/4 v4, 0x3

    invoke-virtual {v2, v6, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 1525
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    .line 1530
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[changeSPNnameforESAME] GsmServiceStateTrackerEx mcc_sim: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 1531
    if-lez v1, :cond_1

    .line 1533
    sparse-switch v1, :sswitch_data_0

    goto :goto_0

    .line 1537
    :sswitch_0
    const-string v4, "Airtel"

    invoke-virtual {p2, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 1538
    const-string p2, "airtel"

    goto :goto_0

    .line 1540
    :cond_3
    const-string v4, "Vodafone"

    invoke-virtual {p2, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 1541
    const-string p2, "Vodafone IN"

    goto :goto_0

    .line 1543
    :cond_4
    const-string v4, "HUTCH"

    invoke-virtual {p2, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 1544
    const-string p2, "Vodafone IN"

    goto :goto_0

    .line 1548
    :sswitch_1
    if-eqz v3, :cond_5

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    if-le v4, v7, :cond_5

    const-string v4, "5200019"

    invoke-virtual {v3, v6, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_5

    .line 1549
    const-string p2, "my"

    goto :goto_0

    .line 1551
    :cond_5
    if-eqz v3, :cond_1

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    if-le v4, v7, :cond_1

    const-string v4, "5200020"

    invoke-virtual {v3, v6, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 1552
    const-string p2, "TRUE-H"

    goto :goto_0

    .line 1556
    :sswitch_2
    if-eqz v2, :cond_1

    const-string v4, "60400"

    invoke-virtual {v2, v4}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v4

    if-nez v4, :cond_1

    .line 1557
    const-string v4, "Pro"

    invoke-virtual {v4, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_1

    const-string v4, "Perso"

    invoke-virtual {v4, p2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_1

    .line 1558
    const-string p2, "Meditel"

    goto/16 :goto_0

    .line 1533
    :sswitch_data_0
    .sparse-switch
        0x194 -> :sswitch_0
        0x195 -> :sswitch_0
        0x208 -> :sswitch_1
        0x25c -> :sswitch_2
    .end sparse-switch
.end method

.method protected changeSpnPlmnName(Ljava/lang/String;)Ljava/lang/String;
    .locals 25
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    .line 519
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    move-object/from16 v23, v0

    invoke-virtual/range {v23 .. v23}, Landroid/telephony/ServiceState;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v15

    .line 520
    .local v15, "operator":Ljava/lang/String;
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v23

    invoke-virtual/range {v23 .. v23}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v6

    .line 521
    .local v6, "currentLanguage":Ljava/lang/String;
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v23

    invoke-virtual/range {v23 .. v23}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v7

    .line 522
    .local v7, "currentcountry":Ljava/lang/String;
    const/16 v23, 0x4

    move/from16 v0, v23

    new-array v5, v0, [C

    fill-array-data v5, :array_0

    .line 523
    .local v5, "chunghwaTrad_chars":[C
    const/16 v23, 0x4

    move/from16 v0, v23

    new-array v3, v0, [C

    fill-array-data v3, :array_1

    .line 524
    .local v3, "chunghwaSimp_chars":[C
    new-instance v4, Ljava/lang/String;

    invoke-direct {v4, v5}, Ljava/lang/String;-><init>([C)V

    .line 525
    .local v4, "chunghwaTrad":Ljava/lang/String;
    new-instance v2, Ljava/lang/String;

    invoke-direct {v2, v3}, Ljava/lang/String;-><init>([C)V

    .line 526
    .local v2, "chunghwaSimp":Ljava/lang/String;
    const/16 v23, 0x5

    move/from16 v0, v23

    new-array v0, v0, [C

    move-object/from16 v22, v0

    fill-array-data v22, :array_2

    .line 527
    .local v22, "twmTrad_chars":[C
    new-instance v21, Ljava/lang/String;

    invoke-direct/range {v21 .. v22}, Ljava/lang/String;-><init>([C)V

    .line 528
    .local v21, "twmTrad":Ljava/lang/String;
    new-instance v20, Ljava/lang/String;

    move-object/from16 v0, v20

    move-object/from16 v1, v22

    invoke-direct {v0, v1}, Ljava/lang/String;-><init>([C)V

    .line 529
    .local v20, "twmSimp":Ljava/lang/String;
    const/16 v23, 0x4

    move/from16 v0, v23

    new-array v0, v0, [C

    move-object/from16 v19, v0

    fill-array-data v19, :array_3

    .line 530
    .local v19, "tstarTrad_chars":[C
    const/16 v23, 0x4

    move/from16 v0, v23

    new-array v0, v0, [C

    move-object/from16 v17, v0

    fill-array-data v17, :array_4

    .line 531
    .local v17, "tstarSimp_chars":[C
    new-instance v18, Ljava/lang/String;

    invoke-direct/range {v18 .. v19}, Ljava/lang/String;-><init>([C)V

    .line 532
    .local v18, "tstarTrad":Ljava/lang/String;
    new-instance v16, Ljava/lang/String;

    invoke-direct/range {v16 .. v17}, Ljava/lang/String;-><init>([C)V

    .line 533
    .local v16, "tstarSimp":Ljava/lang/String;
    const/16 v23, 0x4

    move/from16 v0, v23

    new-array v11, v0, [C

    fill-array-data v11, :array_5

    .line 534
    .local v11, "fetTrad_chars":[C
    const/16 v23, 0x4

    move/from16 v0, v23

    new-array v9, v0, [C

    fill-array-data v9, :array_6

    .line 535
    .local v9, "fetSimp_chars":[C
    new-instance v10, Ljava/lang/String;

    invoke-direct {v10, v11}, Ljava/lang/String;-><init>([C)V

    .line 536
    .local v10, "fetTrad":Ljava/lang/String;
    new-instance v8, Ljava/lang/String;

    invoke-direct {v8, v9}, Ljava/lang/String;-><init>([C)V

    .line 538
    .local v8, "fetSimp":Ljava/lang/String;
    if-nez p1, :cond_0

    const/4 v12, 0x0

    .line 663
    :goto_0
    return-object v12

    .line 539
    :cond_0
    new-instance v23, Ljava/lang/StringBuilder;

    invoke-direct/range {v23 .. v23}, Ljava/lang/StringBuilder;-><init>()V

    const-string v24, "currentLanguage: "

    invoke-virtual/range {v23 .. v24}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v23

    move-object/from16 v0, v23

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v23

    const-string v24, " currentcountry:"

    invoke-virtual/range {v23 .. v24}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v23

    move-object/from16 v0, v23

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v23

    const-string v24, "operator:"

    invoke-virtual/range {v23 .. v24}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v23

    move-object/from16 v0, v23

    invoke-virtual {v0, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v23

    const-string v24, "name:"

    invoke-virtual/range {v23 .. v24}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v23

    move-object/from16 v0, v23

    move-object/from16 v1, p1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v23

    invoke-virtual/range {v23 .. v23}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v23

    move-object/from16 v0, p0

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 540
    const-string v23, "HK"

    invoke-static/range {v23 .. v23}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_1

    const-string v23, "TW"

    invoke-static/range {v23 .. v23}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_1

    const-string v23, "CN"

    invoke-static/range {v23 .. v23}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_2f

    .line 541
    :cond_1
    if-nez p1, :cond_2

    const/4 v12, 0x0

    goto :goto_0

    .line 542
    :cond_2
    move-object/from16 v13, p1

    .line 543
    .local v13, "new_name":Ljava/lang/String;
    if-eqz v6, :cond_2e

    if-eqz v7, :cond_2e

    .line 544
    const-string v23, "FAR EASTONE"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_3

    const-string v23, "FarEasTone"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_3

    const-string v23, "FarEasTon"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_3

    const-string v23, "FET"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_3

    const-string v23, "KG TELECOM"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_3

    const-string v23, "KGT-ONLINE"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_3

    const-string v23, "KGT Online"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_3

    const-string v23, "KGT-ONLIN"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_5

    .line 552
    :cond_3
    const-string v13, "Far EasTone"

    .line 595
    :cond_4
    :goto_1
    const-string v23, "zh"

    move-object/from16 v0, v23

    invoke-virtual {v6, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v23

    if-eqz v23, :cond_1d

    const-string v23, "TW"

    move-object/from16 v0, v23

    invoke-virtual {v7, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v23

    if-eqz v23, :cond_1d

    .line 596
    const-string v23, "Chunghwa"

    move-object/from16 v0, v23

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_18

    move-object v12, v4

    .line 597
    goto/16 :goto_0

    .line 553
    :cond_5
    const-string v23, "CHUNGHWA"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_6

    const-string v23, "Chunghw"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_6

    const-string v23, "Chunghwa Telecom"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_6

    const-string v23, "Chungwa"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_6

    move-object/from16 v0, p1

    invoke-virtual {v0, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_7

    .line 558
    :cond_6
    const-string v13, "Chunghwa"

    goto :goto_1

    .line 559
    :cond_7
    const-string v23, "TWN GSM"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_8

    const-string v23, "TW MOBILE"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_8

    const-string v23, "TWN MOBITAI "

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_8

    const-string v23, "TWN TransAsia Telecom GSM"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_8

    const-string v23, "TW Mobil"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_8

    const-string v23, "TWM"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_8

    const-string v23, "TransAsia"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_8

    const-string v23, "Mobitai"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_8

    const-string v23, "Taiwan Mobile Co. Ltd"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_8

    const-string v23, "Taiwan Mobile"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_9

    .line 569
    :cond_8
    const-string v13, "TW Mobile"

    goto/16 :goto_1

    .line 570
    :cond_9
    if-eqz v15, :cond_a

    const-string v23, "46689"

    move-object/from16 v0, v23

    invoke-virtual {v15, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v23

    if-nez v23, :cond_b

    :cond_a
    const-string v23, "VIBO"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_c

    .line 572
    :cond_b
    const-string v13, "T Star"

    goto/16 :goto_1

    .line 573
    :cond_c
    const-string v23, "NEW WORLD"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_d

    const-string v23, "NEW WORL"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_e

    .line 574
    :cond_d
    const-string v13, "CSL"

    goto/16 :goto_1

    .line 575
    :cond_e
    const-string v23, "PEOPLES"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_f

    const-string v23, "China Mobile HK"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_f

    const-string v23, "CMHK"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_10

    .line 578
    :cond_f
    const-string v13, "China Mobile HK"

    goto/16 :goto_1

    .line 579
    :cond_10
    const-string v23, "SUNDAY"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_11

    const-string v23, "PCCW 2G"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_11

    const-string v23, "PCCW 3G"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_11

    const-string v23, "PCCW"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_12

    .line 583
    :cond_11
    const-string v13, "PCCW-HKT"

    goto/16 :goto_1

    .line 584
    :cond_12
    const-string v23, "3-DUALBAND-"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_13

    const-string v23, "3 (2G)"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_14

    .line 586
    :cond_13
    const-string v13, "3(2G)"

    goto/16 :goto_1

    .line 587
    :cond_14
    const-string v23, "SmarTone"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_15

    .line 588
    const-string v13, "SmarToneVodafone"

    goto/16 :goto_1

    .line 589
    :cond_15
    const-string v23, "STARHUB"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_16

    .line 590
    const-string v13, "StarHub"

    goto/16 :goto_1

    .line 591
    :cond_16
    const-string v23, "TELKOMSE"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_17

    const-string v23, "T-SEL"

    move-object/from16 v0, p1

    move-object/from16 v1, v23

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_4

    .line 593
    :cond_17
    const-string v13, "TELKOMSEL"

    goto/16 :goto_1

    .line 598
    :cond_18
    const-string v23, "TW Mobile"

    move-object/from16 v0, v23

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_19

    move-object/from16 v12, v21

    .line 599
    goto/16 :goto_0

    .line 600
    :cond_19
    const-string v23, "T Star"

    move-object/from16 v0, v23

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_1a

    move-object/from16 v12, v18

    .line 601
    goto/16 :goto_0

    .line 602
    :cond_1a
    const-string v23, "Far EasTone"

    move-object/from16 v0, v23

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_1b

    move-object v12, v10

    .line 603
    goto/16 :goto_0

    .line 604
    :cond_1b
    const-string v23, "China Mobile HK"

    move-object/from16 v0, v23

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_1c

    const-string v23, "CMCC Peoples"

    move-object/from16 v0, v23

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_1d

    .line 605
    :cond_1c
    const/16 v23, 0x6

    move/from16 v0, v23

    new-array v14, v0, [C

    fill-array-data v14, :array_7

    .line 606
    .local v14, "new_name_chars":[C
    new-instance v12, Ljava/lang/String;

    invoke-direct {v12, v14}, Ljava/lang/String;-><init>([C)V

    .line 607
    .local v12, "new_language_name":Ljava/lang/String;
    goto/16 :goto_0

    .line 610
    .end local v12    # "new_language_name":Ljava/lang/String;
    .end local v14    # "new_name_chars":[C
    :cond_1d
    const-string v23, "zh"

    move-object/from16 v0, v23

    invoke-virtual {v6, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v23

    if-eqz v23, :cond_21

    const-string v23, "HK"

    move-object/from16 v0, v23

    invoke-virtual {v7, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v23

    if-eqz v23, :cond_21

    .line 611
    const-string v23, "China Mobile HK"

    move-object/from16 v0, v23

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_1e

    const-string v23, "CMCC Peoples"

    move-object/from16 v0, v23

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_1f

    .line 612
    :cond_1e
    const/16 v23, 0x6

    move/from16 v0, v23

    new-array v14, v0, [C

    fill-array-data v14, :array_8

    .line 613
    .restart local v14    # "new_name_chars":[C
    new-instance v12, Ljava/lang/String;

    invoke-direct {v12, v14}, Ljava/lang/String;-><init>([C)V

    .line 614
    .restart local v12    # "new_language_name":Ljava/lang/String;
    goto/16 :goto_0

    .line 615
    .end local v12    # "new_language_name":Ljava/lang/String;
    .end local v14    # "new_name_chars":[C
    :cond_1f
    const-string v23, "CTM"

    move-object/from16 v0, v23

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_20

    .line 616
    const/16 v23, 0x4

    move/from16 v0, v23

    new-array v14, v0, [C

    fill-array-data v14, :array_9

    .line 617
    .restart local v14    # "new_name_chars":[C
    new-instance v12, Ljava/lang/String;

    invoke-direct {v12, v14}, Ljava/lang/String;-><init>([C)V

    .line 618
    .restart local v12    # "new_language_name":Ljava/lang/String;
    goto/16 :goto_0

    .line 619
    .end local v12    # "new_language_name":Ljava/lang/String;
    .end local v14    # "new_name_chars":[C
    :cond_20
    const-string v23, "T Star"

    move-object/from16 v0, v23

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_21

    move-object/from16 v12, v18

    .line 620
    goto/16 :goto_0

    .line 623
    :cond_21
    const-string v23, "zh"

    move-object/from16 v0, v23

    invoke-virtual {v6, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v23

    if-eqz v23, :cond_2e

    const-string v23, "CN"

    move-object/from16 v0, v23

    invoke-virtual {v7, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v23

    if-eqz v23, :cond_2e

    .line 624
    const-string v23, "China Mobile HK"

    move-object/from16 v0, v23

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_22

    const-string v23, "CMCC Peoples"

    move-object/from16 v0, v23

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_23

    .line 625
    :cond_22
    const/16 v23, 0x6

    move/from16 v0, v23

    new-array v14, v0, [C

    fill-array-data v14, :array_a

    .line 626
    .restart local v14    # "new_name_chars":[C
    new-instance v12, Ljava/lang/String;

    invoke-direct {v12, v14}, Ljava/lang/String;-><init>([C)V

    .line 627
    .restart local v12    # "new_language_name":Ljava/lang/String;
    goto/16 :goto_0

    .line 628
    .end local v12    # "new_language_name":Ljava/lang/String;
    .end local v14    # "new_name_chars":[C
    :cond_23
    const-string v23, "CTM"

    move-object/from16 v0, v23

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_24

    .line 629
    const/16 v23, 0x4

    move/from16 v0, v23

    new-array v14, v0, [C

    fill-array-data v14, :array_b

    .line 630
    .restart local v14    # "new_name_chars":[C
    new-instance v12, Ljava/lang/String;

    invoke-direct {v12, v14}, Ljava/lang/String;-><init>([C)V

    .line 631
    .restart local v12    # "new_language_name":Ljava/lang/String;
    goto/16 :goto_0

    .line 632
    .end local v12    # "new_language_name":Ljava/lang/String;
    .end local v14    # "new_name_chars":[C
    :cond_24
    const-string v23, "CMCC"

    move-object/from16 v0, v23

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_25

    const-string v23, "China Mobile"

    move-object/from16 v0, v23

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_26

    .line 633
    :cond_25
    const/16 v23, 0x4

    move/from16 v0, v23

    new-array v14, v0, [C

    fill-array-data v14, :array_c

    .line 634
    .restart local v14    # "new_name_chars":[C
    new-instance v12, Ljava/lang/String;

    invoke-direct {v12, v14}, Ljava/lang/String;-><init>([C)V

    .line 635
    .restart local v12    # "new_language_name":Ljava/lang/String;
    goto/16 :goto_0

    .line 636
    .end local v12    # "new_language_name":Ljava/lang/String;
    .end local v14    # "new_name_chars":[C
    :cond_26
    const-string v23, "China Mobile 3G"

    move-object/from16 v0, v23

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_27

    .line 637
    const/16 v23, 0x4

    move/from16 v0, v23

    new-array v14, v0, [C

    fill-array-data v14, :array_d

    .line 638
    .restart local v14    # "new_name_chars":[C
    new-instance v23, Ljava/lang/StringBuilder;

    invoke-direct/range {v23 .. v23}, Ljava/lang/StringBuilder;-><init>()V

    new-instance v24, Ljava/lang/String;

    move-object/from16 v0, v24

    invoke-direct {v0, v14}, Ljava/lang/String;-><init>([C)V

    invoke-virtual/range {v23 .. v24}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v23

    const-string v24, "3G"

    invoke-virtual/range {v23 .. v24}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v23

    invoke-virtual/range {v23 .. v23}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    .line 639
    .restart local v12    # "new_language_name":Ljava/lang/String;
    goto/16 :goto_0

    .line 640
    .end local v12    # "new_language_name":Ljava/lang/String;
    .end local v14    # "new_name_chars":[C
    :cond_27
    const-string v23, "China Mobile 4G"

    move-object/from16 v0, v23

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_28

    .line 641
    const/16 v23, 0x4

    move/from16 v0, v23

    new-array v14, v0, [C

    fill-array-data v14, :array_e

    .line 642
    .restart local v14    # "new_name_chars":[C
    new-instance v23, Ljava/lang/StringBuilder;

    invoke-direct/range {v23 .. v23}, Ljava/lang/StringBuilder;-><init>()V

    new-instance v24, Ljava/lang/String;

    move-object/from16 v0, v24

    invoke-direct {v0, v14}, Ljava/lang/String;-><init>([C)V

    invoke-virtual/range {v23 .. v24}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v23

    const-string v24, "4G"

    invoke-virtual/range {v23 .. v24}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v23

    invoke-virtual/range {v23 .. v23}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    .line 643
    .restart local v12    # "new_language_name":Ljava/lang/String;
    goto/16 :goto_0

    .line 644
    .end local v12    # "new_language_name":Ljava/lang/String;
    .end local v14    # "new_name_chars":[C
    :cond_28
    const-string v23, "CHN-CUGSM"

    move-object/from16 v0, v23

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_29

    const-string v23, "China Unicom"

    move-object/from16 v0, v23

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-nez v23, :cond_29

    const-string v23, "CHN-UNICOM"

    move-object/from16 v0, v23

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_2a

    .line 647
    :cond_29
    const/16 v23, 0x4

    move/from16 v0, v23

    new-array v14, v0, [C

    fill-array-data v14, :array_f

    .line 648
    .restart local v14    # "new_name_chars":[C
    new-instance v12, Ljava/lang/String;

    invoke-direct {v12, v14}, Ljava/lang/String;-><init>([C)V

    .line 649
    .restart local v12    # "new_language_name":Ljava/lang/String;
    goto/16 :goto_0

    .line 650
    .end local v12    # "new_language_name":Ljava/lang/String;
    .end local v14    # "new_name_chars":[C
    :cond_2a
    const-string v23, "Far EasTone"

    move-object/from16 v0, v23

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_2b

    move-object v12, v8

    .line 651
    goto/16 :goto_0

    .line 652
    :cond_2b
    const-string v23, "T Star"

    move-object/from16 v0, v23

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_2c

    move-object/from16 v12, v16

    .line 653
    goto/16 :goto_0

    .line 654
    :cond_2c
    const-string v23, "Chunghwa"

    move-object/from16 v0, v23

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_2d

    move-object v12, v2

    .line 655
    goto/16 :goto_0

    .line 656
    :cond_2d
    const-string v23, "TW Mobile"

    move-object/from16 v0, v23

    invoke-virtual {v13, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v23

    if-eqz v23, :cond_2e

    move-object/from16 v12, v20

    .line 657
    goto/16 :goto_0

    :cond_2e
    move-object v12, v13

    .line 661
    goto/16 :goto_0

    .end local v13    # "new_name":Ljava/lang/String;
    :cond_2f
    move-object/from16 v12, p1

    .line 663
    goto/16 :goto_0

    .line 522
    nop

    :array_0
    .array-data 2
        0x4e2ds
        -0x7c11s
        -0x6905s
        0x4fe1s
    .end array-data

    .line 523
    :array_1
    .array-data 2
        0x4e2ds
        0x534es
        0x7535s
        0x4fe1s
    .end array-data

    .line 526
    :array_2
    .array-data 2
        0x53f0s
        0x6e7es
        0x5927s
        0x54e5s
        0x5927s
    .end array-data

    .line 529
    nop

    :array_3
    .array-data 2
        0x53f0s
        0x7063s
        0x4e4bs
        0x661fs
    .end array-data

    .line 530
    :array_4
    .array-data 2
        0x53f0s
        0x6e7es
        0x4e4bs
        0x661fs
    .end array-data

    .line 533
    :array_5
    .array-data 2
        -0x6fa0s
        0x50b3s
        -0x6905s
        0x4fe1s
    .end array-data

    .line 534
    :array_6
    .array-data 2
        -0x7024s
        0x4f20s
        0x7535s
        0x4fe1s
    .end array-data

    .line 605
    :array_7
    .array-data 2
        0x4e2ds
        0x570bs
        0x79fbs
        0x52d5s
        -0x6667s
        0x6e2fs
    .end array-data

    .line 612
    :array_8
    .array-data 2
        0x4e2ds
        0x570bs
        0x79fbs
        0x52d5s
        -0x6667s
        0x6e2fs
    .end array-data

    .line 616
    :array_9
    .array-data 2
        0x6fb3s
        -0x6a80s
        -0x6905s
        -0x75f6s
    .end array-data

    .line 625
    :array_a
    .array-data 2
        0x4e2ds
        0x56fds
        0x79fbs
        0x52a8s
        -0x6667s
        0x6e2fs
    .end array-data

    .line 629
    :array_b
    .array-data 2
        0x6fb3s
        -0x6a18s
        0x7535s
        -0x7451s
    .end array-data

    .line 633
    :array_c
    .array-data 2
        0x4e2ds
        0x56fds
        0x79fbs
        0x52a8s
    .end array-data

    .line 637
    :array_d
    .array-data 2
        0x4e2ds
        0x56fds
        0x79fbs
        0x52a8s
    .end array-data

    .line 641
    :array_e
    .array-data 2
        0x4e2ds
        0x56fds
        0x79fbs
        0x52a8s
    .end array-data

    .line 647
    :array_f
    .array-data 2
        0x4e2ds
        0x56fds
        -0x7facs
        -0x6fe6s
    .end array-data
.end method

.method protected checkCtcNitz()V
    .locals 3

    .prologue
    const/16 v2, 0x3f9

    .line 695
    const-string v0, "CTC"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNitzControl:Z

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    .line 696
    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->hasMessages(I)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 697
    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->removeMessages(I)V

    .line 699
    :cond_0
    iget v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNitzWaitingTimeout:I

    int-to-long v0, v0

    invoke-virtual {p0, v2, v0, v1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->sendEmptyMessageDelayed(IJ)Z

    .line 701
    :cond_1
    return-void
.end method

.method protected checkHplmnTMUS(Ljava/lang/String;)Z
    .locals 7
    .param p1, "simNumeric"    # Ljava/lang/String;

    .prologue
    .line 1149
    iget-object v5, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v5}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v5

    iget-object v6, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v6}, Lcom/android/internal/telephony/gsm/GSMPhone;->getPhoneId()I

    move-result v6

    invoke-static {v5, v6}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getHomeNetworks(Landroid/content/Context;I)[Ljava/lang/String;

    move-result-object v1

    .line 1151
    .local v1, "homeNetworks":[Ljava/lang/String;
    if-eqz p1, :cond_1

    if-eqz v1, :cond_1

    .line 1152
    move-object v0, v1

    .local v0, "arr$":[Ljava/lang/String;
    array-length v3, v0

    .local v3, "len$":I
    const/4 v2, 0x0

    .local v2, "i$":I
    :goto_0
    if-ge v2, v3, :cond_1

    aget-object v4, v0, v2

    .line 1153
    .local v4, "numeric":Ljava/lang/String;
    invoke-virtual {p1, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 1154
    const/4 v5, 0x1

    .line 1158
    .end local v0    # "arr$":[Ljava/lang/String;
    .end local v2    # "i$":I
    .end local v3    # "len$":I
    .end local v4    # "numeric":Ljava/lang/String;
    :goto_1
    return v5

    .line 1152
    .restart local v0    # "arr$":[Ljava/lang/String;
    .restart local v2    # "i$":I
    .restart local v3    # "len$":I
    .restart local v4    # "numeric":Ljava/lang/String;
    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 1158
    .end local v0    # "arr$":[Ljava/lang/String;
    .end local v2    # "i$":I
    .end local v3    # "len$":I
    .end local v4    # "numeric":Ljava/lang/String;
    :cond_1
    const/4 v5, 0x0

    goto :goto_1
.end method

.method protected checkIndiaThaiRoaming(Ljava/lang/String;Z)Z
    .locals 9
    .param p1, "operatorNumeric"    # Ljava/lang/String;
    .param p2, "roaming"    # Z

    .prologue
    const/4 v3, 0x0

    const/4 v8, 0x3

    .line 1624
    const-string v4, "gsm.sim.operator.numeric"

    iget-object v5, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v5}, Lcom/android/internal/telephony/gsm/GSMPhone;->getPhoneId()I

    move-result v5

    int-to-long v6, v5

    const-string v5, ""

    invoke-static {v4, v6, v7, v5}, Landroid/telephony/TelephonyManager;->getTelephonyProperty(Ljava/lang/String;JLjava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 1625
    .local v2, "simNumeric":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[checkIndiaThaiRoaming] simNumeric: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 1626
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[checkIndiaThaiRoaming] operatorNumeric: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 1627
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[checkIndiaThaiRoaming] roaming: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 1629
    invoke-virtual {v2, v3, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p1, v3, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    .line 1630
    .local v0, "equalsMcc":Z
    invoke-virtual {v2, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p1, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    .line 1631
    .local v1, "equalsMnc":Z
    if-eqz p2, :cond_0

    if-eqz v0, :cond_0

    if-eqz v1, :cond_0

    const/4 v3, 0x1

    :cond_0
    return v3
.end method

.method protected checkInvalidUsimForGSM(I)V
    .locals 3
    .param p1, "rejCode"    # I

    .prologue
    .line 1065
    const/4 v0, 0x2

    if-eq p1, v0, :cond_0

    const/4 v0, 0x3

    if-eq p1, v0, :cond_0

    const/4 v0, 0x6

    if-ne p1, v0, :cond_2

    .line 1066
    :cond_0
    sget-object v0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->regioncode:Ljava/lang/String;

    const-string v1, "SCA"

    invoke-virtual {v0, v1}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "US"

    const-string v1, "TMO"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "US"

    const-string v1, "MPCS"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "CA"

    const-string v1, "RGS"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 1069
    :cond_1
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPermanentReject:Z

    .line 1070
    const-string v0, "[GsmServiceStateTrackerEX]"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "rejCode : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " mPermanentReject : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPermanentReject:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1071
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->updateSpnDisplay()V

    .line 1074
    :cond_2
    return-void
.end method

.method protected checkNationalRoaming(Ljava/lang/String;)Z
    .locals 7
    .param p1, "operatorNumeric"    # Ljava/lang/String;

    .prologue
    .line 1134
    iget-object v5, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v5}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v5

    iget-object v6, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v6}, Lcom/android/internal/telephony/gsm/GSMPhone;->getPhoneId()I

    move-result v6

    invoke-static {v5, v6}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getHomeNetworks(Landroid/content/Context;I)[Ljava/lang/String;

    move-result-object v1

    .line 1136
    .local v1, "homeNetworks":[Ljava/lang/String;
    if-eqz p1, :cond_1

    if-eqz v1, :cond_1

    .line 1137
    move-object v0, v1

    .local v0, "arr$":[Ljava/lang/String;
    array-length v3, v0

    .local v3, "len$":I
    const/4 v2, 0x0

    .local v2, "i$":I
    :goto_0
    if-ge v2, v3, :cond_1

    aget-object v4, v0, v2

    .line 1138
    .local v4, "numeric":Ljava/lang/String;
    invoke-virtual {p1, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 1139
    const/4 v5, 0x1

    .line 1143
    .end local v0    # "arr$":[Ljava/lang/String;
    .end local v2    # "i$":I
    .end local v3    # "len$":I
    .end local v4    # "numeric":Ljava/lang/String;
    :goto_1
    return v5

    .line 1137
    .restart local v0    # "arr$":[Ljava/lang/String;
    .restart local v2    # "i$":I
    .restart local v3    # "len$":I
    .restart local v4    # "numeric":Ljava/lang/String;
    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 1143
    .end local v0    # "arr$":[Ljava/lang/String;
    .end local v2    # "i$":I
    .end local v3    # "len$":I
    .end local v4    # "numeric":Ljava/lang/String;
    :cond_1
    const/4 v5, 0x0

    goto :goto_1
.end method

.method protected checkNotRoamingCountryTMUS(Ljava/lang/String;)Z
    .locals 7
    .param p1, "mccCheckforTMUS"    # Ljava/lang/String;

    .prologue
    .line 1175
    iget-object v5, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v5}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v5

    iget-object v6, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v6}, Lcom/android/internal/telephony/gsm/GSMPhone;->getPhoneId()I

    move-result v6

    invoke-static {v5, v6}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getNotRoamingCountry(Landroid/content/Context;I)[Ljava/lang/String;

    move-result-object v3

    .line 1177
    .local v3, "notRoamingCountry":[Ljava/lang/String;
    if-eqz p1, :cond_1

    if-eqz v3, :cond_1

    .line 1178
    move-object v0, v3

    .local v0, "arr$":[Ljava/lang/String;
    array-length v2, v0

    .local v2, "len$":I
    const/4 v1, 0x0

    .local v1, "i$":I
    :goto_0
    if-ge v1, v2, :cond_1

    aget-object v4, v0, v1

    .line 1179
    .local v4, "numeric":Ljava/lang/String;
    invoke-virtual {p1, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 1180
    const/4 v5, 0x1

    .line 1184
    .end local v0    # "arr$":[Ljava/lang/String;
    .end local v1    # "i$":I
    .end local v2    # "len$":I
    .end local v4    # "numeric":Ljava/lang/String;
    :goto_1
    return v5

    .line 1178
    .restart local v0    # "arr$":[Ljava/lang/String;
    .restart local v1    # "i$":I
    .restart local v2    # "len$":I
    .restart local v4    # "numeric":Ljava/lang/String;
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1184
    .end local v0    # "arr$":[Ljava/lang/String;
    .end local v1    # "i$":I
    .end local v2    # "len$":I
    .end local v4    # "numeric":Ljava/lang/String;
    :cond_1
    const/4 v5, 0x0

    goto :goto_1
.end method

.method protected checkNotiStateChanged()Z
    .locals 4

    .prologue
    .line 939
    const/4 v0, 0x0

    .line 940
    .local v0, "hasNotiStateChnaged":Z
    const-string v1, "KR"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 941
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mKrSST:Lcom/android/internal/telephony/kr/KrServiceStateTracker;

    if-eqz v1, :cond_0

    .line 942
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mKrSST:Lcom/android/internal/telephony/kr/KrServiceStateTracker;

    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1, v2, v3}, Lcom/android/internal/telephony/kr/KrServiceStateTracker;->checkNotiStateChanged(Landroid/telephony/ServiceState;Landroid/telephony/ServiceState;)Z

    .line 945
    :cond_0
    return v0
.end method

.method protected checkRadioStateForMLT(I)V
    .locals 4
    .param p1, "code"    # I

    .prologue
    const v3, 0xc0001

    const/16 v2, 0x3fb

    .line 1428
    const/4 v0, 0x0

    const-string v1, "SUPPORT_LOG_RF_INFO"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1460
    :goto_0
    return-void

    .line 1432
    :cond_0
    packed-switch p1, :pswitch_data_0

    .line 1457
    :pswitch_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "LOGRadioInfo checkRadioState : unexpected service state "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 1438
    :pswitch_1
    const-string v0, "LOGRadioInfo : Send Radio state data (Emergency Service)"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 1439
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    invoke-virtual {v0, v3, v1}, Lcom/android/internal/telephony/gsm/GSMPhone;->getModemStringItem(ILandroid/os/Message;)V

    goto :goto_0

    .line 1444
    :pswitch_2
    const-string v0, "LOGRadioInfo : Send Radio state data (Out of Service)"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 1445
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    invoke-virtual {v0, v3, v1}, Lcom/android/internal/telephony/gsm/GSMPhone;->getModemStringItem(ILandroid/os/Message;)V

    goto :goto_0

    .line 1449
    :pswitch_3
    const-string v0, "LOGRadioInfo : In Service"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 1453
    :pswitch_4
    const-string v0, "LOGRadioInfo : In Service(Roaming)"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 1432
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_2
        :pswitch_4
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_1
        :pswitch_0
        :pswitch_1
        :pswitch_1
        :pswitch_1
    .end packed-switch
.end method

.method protected checkRoamingNetworkTMUS(Ljava/lang/String;)Z
    .locals 7
    .param p1, "operatorNumeric"    # Ljava/lang/String;

    .prologue
    .line 1162
    iget-object v5, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v5}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v5

    iget-object v6, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v6}, Lcom/android/internal/telephony/gsm/GSMPhone;->getPhoneId()I

    move-result v6

    invoke-static {v5, v6}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getRoamingNetworks(Landroid/content/Context;I)[Ljava/lang/String;

    move-result-object v4

    .line 1164
    .local v4, "roamingNetworks":[Ljava/lang/String;
    if-eqz p1, :cond_1

    if-eqz v4, :cond_1

    .line 1165
    move-object v0, v4

    .local v0, "arr$":[Ljava/lang/String;
    array-length v2, v0

    .local v2, "len$":I
    const/4 v1, 0x0

    .local v1, "i$":I
    :goto_0
    if-ge v1, v2, :cond_1

    aget-object v3, v0, v1

    .line 1166
    .local v3, "numeric":Ljava/lang/String;
    invoke-virtual {p1, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 1167
    const/4 v5, 0x1

    .line 1171
    .end local v0    # "arr$":[Ljava/lang/String;
    .end local v1    # "i$":I
    .end local v2    # "len$":I
    .end local v3    # "numeric":Ljava/lang/String;
    :goto_1
    return v5

    .line 1165
    .restart local v0    # "arr$":[Ljava/lang/String;
    .restart local v1    # "i$":I
    .restart local v2    # "len$":I
    .restart local v3    # "numeric":Ljava/lang/String;
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1171
    .end local v0    # "arr$":[Ljava/lang/String;
    .end local v1    # "i$":I
    .end local v2    # "len$":I
    .end local v3    # "numeric":Ljava/lang/String;
    :cond_1
    const/4 v5, 0x0

    goto :goto_1
.end method

.method protected checkZoneAndMultiTimeZoneArea(Ljava/util/TimeZone;)Ljava/util/TimeZone;
    .locals 3
    .param p1, "zone"    # Ljava/util/TimeZone;

    .prologue
    .line 883
    move-object v0, p1

    .line 884
    .local v0, "newZone":Ljava/util/TimeZone;
    const/4 v1, 0x0

    const-string v2, "MAUNAL_TIMEZONE_SETTING_POPUP"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 886
    iget-boolean v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNeedFixZoneAfterNitz:Z

    if-nez v1, :cond_0

    iget-boolean v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->isMultiTimeZoneArea:Z

    if-eqz v1, :cond_0

    .line 888
    const-string v1, "NITZ not received in multi-time zone area!! zone will be selected thru timezone setting popup"

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 889
    const/4 v0, 0x0

    .line 890
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->isMultiTimeZoneArea:Z

    .line 893
    :cond_0
    return-object v0
.end method

.method public dispose()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 290
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterLGERACInd(Landroid/os/Handler;)V

    .line 294
    const-string v0, "KR"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 295
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mKrSST:Lcom/android/internal/telephony/kr/KrServiceStateTracker;

    if-eqz v0, :cond_0

    .line 296
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mKrSST:Lcom/android/internal/telephony/kr/KrServiceStateTracker;

    invoke-virtual {v0}, Lcom/android/internal/telephony/kr/KrServiceStateTracker;->dispose()V

    .line 297
    iput-object v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mKrSST:Lcom/android/internal/telephony/kr/KrServiceStateTracker;

    .line 303
    :cond_0
    const-string v0, "MANAGED_TIME_SETTING"

    invoke-static {v1, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 304
    sget-object v0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    if-eqz v0, :cond_1

    .line 305
    sget-object v0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    invoke-virtual {v0}, Lcom/android/internal/telephony/LgeTimeZoneMonitor;->unsetServiceStateTracker()V

    .line 311
    :cond_1
    iget-boolean v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNeedFixZoneAfterNitz:Z

    if-eqz v0, :cond_2

    .line 312
    iget-boolean v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNeedFixZoneAfterNitz:Z

    invoke-static {v0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->setSavedNeedFixZone(Z)V

    .line 313
    iget v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mZoneOffset:I

    invoke-static {v0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->setSavedZoneOffset(I)V

    .line 314
    iget-boolean v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mZoneDst:Z

    invoke-static {v0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->setSavedZoneDst(Z)V

    .line 315
    iget-wide v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mZoneTime:J

    invoke-static {v0, v1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->setSavedZoneTime(J)V

    .line 316
    iget-wide v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSavedTime:J

    invoke-static {v0, v1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->setSavedTime(J)V

    .line 317
    iget-wide v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSavedAtTime:J

    invoke-static {v0, v1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->setSavedAtTime(J)V

    .line 318
    const-string v0, "TimeZone correction is needed after Phone Switching!"

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 323
    :cond_2
    const/16 v0, 0x3ea

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->setNotification(I)V

    .line 324
    const/16 v0, 0x3ec

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->setNotification(I)V

    .line 328
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->removeMessageCtNitzCheck(Z)V

    .line 331
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v0}, Lcom/android/internal/telephony/gsm/GSMPhone;->getContext()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLGIntentReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 334
    invoke-super {p0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;->dispose()V

    .line 335
    return-void
.end method

.method protected getIsSCAConsideredOperatorNonRoaming(I)Z
    .locals 6
    .param p1, "displayCondition"    # I

    .prologue
    .line 1637
    const/4 v2, 0x0

    .line 1639
    .local v2, "result":Z
    const-string v4, "SCA"

    const-string v5, "ro.build.target_region"

    invoke-static {v5}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 1640
    iget-object v4, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v4}, Landroid/telephony/ServiceState;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v1

    .line 1641
    .local v1, "operatorNumeric":Ljava/lang/String;
    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->checkNationalRoaming(Ljava/lang/String;)Z

    move-result v0

    .line 1642
    .local v0, "isOperatorConsideredNonRoaming":Z
    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mIccRecords:Lcom/android/internal/telephony/uicc/IccRecords;

    check-cast v3, Lcom/android/internal/telephony/uicc/SIMRecords;

    .line 1643
    .local v3, "simrecord":Lcom/android/internal/telephony/uicc/SIMRecords;
    if-eqz v3, :cond_0

    const/4 v4, 0x3

    if-ne p1, v4, :cond_0

    if-eqz v0, :cond_0

    invoke-virtual {v3}, Lcom/android/internal/telephony/uicc/SIMRecords;->getSpnDisplayCondition()I

    move-result v4

    if-nez v4, :cond_0

    .line 1645
    const/4 v2, 0x1

    .line 1648
    .end local v0    # "isOperatorConsideredNonRoaming":Z
    .end local v1    # "operatorNumeric":Ljava/lang/String;
    .end local v3    # "simrecord":Lcom/android/internal/telephony/uicc/SIMRecords;
    :cond_0
    return v2
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 5
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v4, 0x0

    const/4 v3, -0x1

    .line 342
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    iget-boolean v1, v1, Lcom/android/internal/telephony/gsm/GSMPhone;->mIsTheCurrentActivePhone:Z

    if-nez v1, :cond_3

    .line 343
    const-string v1, "GsmSST"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Received message "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget v3, p1, Landroid/os/Message;->what:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "] while being destroyed. Ignoring."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 346
    const/4 v1, 0x0

    const-string v2, "MANAGED_TIME_SETTING"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 347
    if-eqz p1, :cond_1

    iget v1, p1, Landroid/os/Message;->what:I

    const/16 v2, 0xb

    if-ne v1, v2, :cond_1

    .line 348
    const-string v1, "NITZ received while disposing CDMAPhone!!"

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 350
    sget-object v1, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    if-nez v1, :cond_0

    .line 351
    invoke-static {}, Lcom/android/internal/telephony/LgeTimeZoneMonitor;->getDefault()Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    move-result-object v1

    sput-object v1, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    .line 354
    :cond_0
    sget-object v1, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    if-eqz v1, :cond_1

    .line 355
    const-string v1, "Save NITZ info. to restore it after phone-switching"

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 356
    iget-object v1, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v1, Landroid/os/AsyncResult;

    invoke-static {v1}, Lcom/android/internal/telephony/LgeTimeZoneMonitor;->setLostNitzInfo(Landroid/os/AsyncResult;)V

    .line 362
    :cond_1
    iget v1, p1, Landroid/os/Message;->what:I

    const/16 v2, 0x2b

    if-ne v1, v2, :cond_2

    .line 363
    invoke-super {p0, p1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;->handleMessage(Landroid/os/Message;)V

    .line 424
    :cond_2
    :goto_0
    return-void

    .line 369
    :cond_3
    iget v1, p1, Landroid/os/Message;->what:I

    sparse-switch v1, :sswitch_data_0

    .line 421
    invoke-super {p0, p1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;->handleMessage(Landroid/os/Message;)V

    goto :goto_0

    .line 372
    :sswitch_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "CTC : NITZ is not received even waiting for "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNitzWaitingTimeout:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " msec."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 373
    invoke-direct {p0, v4}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->sendNitzIntent(Z)V

    goto :goto_0

    .line 379
    :sswitch_1
    invoke-direct {p0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->setNetwork_GPRS_State_Change()V

    goto :goto_0

    .line 383
    :sswitch_2
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 384
    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v1, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v1, :cond_2

    .line 386
    iget-object v1, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v1, [I

    check-cast v1, [I

    aget v1, v1, v4

    iput v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLAC:I

    .line 387
    iget-object v1, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v1, [I

    check-cast v1, [I

    const/4 v2, 0x1

    aget v1, v1, v2

    iput v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mRAC:I

    .line 389
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Send EVENT_RAC_UPDATE_IND updated LAC =    "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLAC:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " RAC = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mRAC:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 391
    iget v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLAC:I

    if-nez v1, :cond_5

    iget v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mRAC:I

    if-nez v1, :cond_5

    .line 392
    sget v1, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->prev_mLAC:I

    if-ne v1, v3, :cond_4

    sget v1, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->prev_mRAC:I

    if-ne v1, v3, :cond_4

    .line 393
    const-string v1, "LTE attach reject, do not reset LAC/RAC"

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 395
    :cond_4
    iget v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLAC:I

    sput v1, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->prev_mLAC:I

    .line 396
    iget v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mRAC:I

    sput v1, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->prev_mRAC:I

    .line 397
    const-string v1, "Reset LAC/RAC because of lte reject 29/33"

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 400
    :cond_5
    sget v1, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->prev_mLAC:I

    if-ne v1, v3, :cond_6

    sget v1, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->prev_mRAC:I

    if-ne v1, v3, :cond_6

    .line 401
    iget v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLAC:I

    sput v1, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->prev_mLAC:I

    .line 402
    iget v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mRAC:I

    sput v1, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->prev_mRAC:I

    .line 403
    const-string v1, "Set first LAC/RAC value, do not send intent to DCTracker"

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 405
    :cond_6
    const-string v1, "TCL"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    sget v1, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->prev_mRAC:I

    iget v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mRAC:I

    if-ne v1, v2, :cond_7

    sget v1, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->prev_mLAC:I

    iget v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLAC:I

    if-eq v1, v2, :cond_2

    .line 406
    :cond_7
    iget v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLAC:I

    sput v1, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->prev_mLAC:I

    .line 407
    iget v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mRAC:I

    sput v1, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->prev_mRAC:I

    .line 408
    const/16 v1, 0x8fe

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    const-wide/16 v2, 0x1388

    invoke-virtual {p0, v1, v2, v3}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->sendMessageDelayed(Landroid/os/Message;J)Z

    goto/16 :goto_0

    .line 416
    .end local v0    # "ar":Landroid/os/AsyncResult;
    :sswitch_3
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->radioLogForMLT(Landroid/os/Message;)V

    goto/16 :goto_0

    .line 369
    nop

    :sswitch_data_0
    .sparse-switch
        0x3f9 -> :sswitch_0
        0x3fb -> :sswitch_3
        0x8fe -> :sswitch_1
        0x8ff -> :sswitch_2
    .end sparse-switch
.end method

.method handleRejectCause(Ljava/lang/String;I)Z
    .locals 5
    .param p1, "stateForRejCode"    # Ljava/lang/String;
    .param p2, "regState"    # I

    .prologue
    .line 1216
    const/4 v1, 0x0

    .line 1217
    .local v1, "result":Z
    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    .line 1219
    .local v0, "rejCode":I
    const/16 v2, 0x11

    if-ne v0, v2, :cond_0

    const/16 v2, 0xd

    if-ne p2, v2, :cond_0

    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v2}, Landroid/telephony/ServiceState;->getState()I

    move-result v2

    if-nez v2, :cond_0

    const/4 v1, 0x1

    .line 1220
    :goto_0
    const-string v2, "GsmSST"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "rejCodeIgnore = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1223
    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->checkInvalidUsimForGSM(I)V

    .line 1226
    invoke-direct {p0, v0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->enhanceNetworkUsability(I)V

    .line 1228
    return v1

    .line 1219
    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method protected isAirplaneMode()Z
    .locals 1

    .prologue
    .line 1059
    iget-boolean v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mAirplaneMode:Z

    return v0
.end method

.method public isEmergencyOnly()Z
    .locals 1

    .prologue
    .line 1421
    iget-boolean v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mEmergencyOnly:Z

    return v0
.end method

.method protected isIndiaThaiSIM()Z
    .locals 7

    .prologue
    const/4 v6, 0x3

    const/4 v1, 0x0

    .line 1611
    const-string v2, "gsm.sim.operator.numeric"

    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v3}, Lcom/android/internal/telephony/gsm/GSMPhone;->getPhoneId()I

    move-result v3

    int-to-long v4, v3

    const-string v3, ""

    invoke-static {v2, v4, v5, v3}, Landroid/telephony/TelephonyManager;->getTelephonyProperty(Ljava/lang/String;JLjava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1612
    .local v0, "simNumeric":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[isIndiaThiaSIM] simNumeric: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 1613
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    const/4 v3, 0x5

    if-lt v2, v3, :cond_1

    .line 1614
    const-string v2, "520"

    invoke-virtual {v0, v1, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "404"

    invoke-virtual {v0, v1, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "405"

    invoke-virtual {v0, v1, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 1616
    :cond_0
    const-string v1, "[isIndiaThiaSIM] return true"

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 1617
    const/4 v1, 0x1

    .line 1620
    :cond_1
    return v1
.end method

.method protected isInvalidUSIM()Z
    .locals 1

    .prologue
    .line 1077
    iget-boolean v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPermanentReject:Z

    return v0
.end method

.method protected isLimitedStateATT()Z
    .locals 1

    .prologue
    .line 1083
    iget-boolean v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLimitedServiceState:Z

    return v0
.end method

.method public isManualSelectionAvailable()Z
    .locals 2

    .prologue
    .line 928
    const/4 v0, 0x0

    const-string v1, "KR_REJECT_CAUSE"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 929
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mKrSST:Lcom/android/internal/telephony/kr/KrServiceStateTracker;

    if-eqz v0, :cond_0

    .line 930
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mKrSST:Lcom/android/internal/telephony/kr/KrServiceStateTracker;

    invoke-virtual {v0}, Lcom/android/internal/telephony/kr/KrServiceStateTracker;->isManualSelectionAvailable()Z

    move-result v0

    .line 933
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method

.method protected isNetworkFailureATT()Z
    .locals 1

    .prologue
    .line 1086
    iget-boolean v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNetworkFailure:Z

    return v0
.end method

.method protected notifyRoaming()V
    .locals 7

    .prologue
    const/4 v6, 0x0

    const/4 v5, 0x5

    .line 1193
    const-string v1, "gsm.sim.operator.numeric"

    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v2}, Lcom/android/internal/telephony/gsm/GSMPhone;->getSubId()J

    move-result-wide v2

    const-string v4, ""

    invoke-static {v1, v2, v3, v4}, Landroid/telephony/TelephonyManager;->getTelephonyProperty(Ljava/lang/String;JLjava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 1195
    .local v0, "simNumeric":Ljava/lang/String;
    const-string v1, "H3G"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    const-string v1, "OPEN"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "EU"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    :cond_0
    const-string v1, "P4P"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 1196
    :cond_1
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lt v1, v5, :cond_3

    const-string v1, "21902"

    invoke-virtual {v0, v6, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    const-string v1, "26006"

    invoke-virtual {v0, v6, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    const-string v1, "22299"

    invoke-virtual {v0, v6, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    const-string v1, "23205"

    invoke-virtual {v0, v6, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    const-string v1, "23210"

    invoke-virtual {v0, v6, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    const-string v1, "23420"

    invoke-virtual {v0, v6, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    const-string v1, "24002"

    invoke-virtual {v0, v6, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    const-string v1, "24004"

    invoke-virtual {v0, v6, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    const-string v1, "45403"

    invoke-virtual {v0, v6, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 1200
    :cond_2
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getRoaming()Z

    move-result v1

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getRoaming()Z

    move-result v1

    if-eqz v1, :cond_3

    .line 1202
    const-string v1, "GsmSST"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[Roaming] [baeksm] the Roaming status is not changed - ss.opwerator :"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v3}, Landroid/telephony/ServiceState;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " newss.operator : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v3}, Landroid/telephony/ServiceState;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1203
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v2}, Landroid/telephony/ServiceState;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    .line 1205
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mRoamingOnRegistrants:Landroid/os/RegistrantList;

    invoke-virtual {v1}, Landroid/os/RegistrantList;->notifyRegistrants()V

    .line 1206
    const-string v1, " [Roaming] Send noti to data"

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 1207
    const-string v1, "GsmSST"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "[Roaming] the Roaming status is not changed - ss.opwerator :"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v3}, Landroid/telephony/ServiceState;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " newss.operator : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-virtual {v3}, Landroid/telephony/ServiceState;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1212
    :cond_3
    return-void
.end method

.method protected postProcessEventNetworkStateChanged()V
    .locals 1

    .prologue
    .line 956
    const-string v0, "KR"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 957
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mKrSST:Lcom/android/internal/telephony/kr/KrServiceStateTracker;

    if-eqz v0, :cond_0

    .line 958
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mKrSST:Lcom/android/internal/telephony/kr/KrServiceStateTracker;

    invoke-virtual {v0}, Lcom/android/internal/telephony/kr/KrServiceStateTracker;->postProcessEventNetworkStateChanged()V

    .line 962
    :cond_0
    return-void
.end method

.method protected postProcessEventPollStateGprs(III)V
    .locals 1
    .param p1, "regState"    # I
    .param p2, "dataRegState"    # I
    .param p3, "type"    # I

    .prologue
    .line 996
    const-string v0, "KR"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 997
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mKrSST:Lcom/android/internal/telephony/kr/KrServiceStateTracker;

    if-eqz v0, :cond_0

    .line 998
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mKrSST:Lcom/android/internal/telephony/kr/KrServiceStateTracker;

    invoke-virtual {v0, p1, p2, p3}, Lcom/android/internal/telephony/kr/KrServiceStateTracker;->postProcessEventPollStateGprs(III)V

    .line 1002
    :cond_0
    return-void
.end method

.method protected postProcessEventPollStateRegistration(II)V
    .locals 1
    .param p1, "regState"    # I
    .param p2, "type"    # I

    .prologue
    .line 984
    const-string v0, "KR"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x3

    if-ne p1, v0, :cond_0

    .line 985
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mEmergencyOnly:Z

    .line 988
    :cond_0
    return-void
.end method

.method protected postProcessPollStateDone(ZZZ)V
    .locals 7
    .param p1, "hasChanged"    # Z
    .param p2, "hasGprsAttached"    # Z
    .param p3, "hasNotiStateChnaged"    # Z

    .prologue
    .line 1026
    const-string v0, "KR"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1027
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mKrSST:Lcom/android/internal/telephony/kr/KrServiceStateTracker;

    if-eqz v0, :cond_0

    .line 1028
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mKrSST:Lcom/android/internal/telephony/kr/KrServiceStateTracker;

    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getVoiceRegState()I

    move-result v4

    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getDataRegState()I

    move-result v5

    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getRilDataRadioTechnology()I

    move-result v6

    move v1, p1

    move v2, p2

    move v3, p3

    invoke-virtual/range {v0 .. v6}, Lcom/android/internal/telephony/kr/KrServiceStateTracker;->postProcessPollStateDone(ZZZIII)V

    .line 1033
    :cond_0
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->checkMissingPhoneForLGU()V

    .line 1037
    :cond_1
    return-void
.end method

.method protected preProcessEventNitzTime(Ljava/lang/String;J)V
    .locals 2
    .param p1, "nitzString"    # Ljava/lang/String;
    .param p2, "nitzReceiveTime"    # J

    .prologue
    .line 970
    const/4 v0, 0x0

    const-string v1, "MANAGED_TIME_SETTING"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 971
    sget-object v0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    if-eqz v0, :cond_0

    .line 972
    sget-object v0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mTimeZoneMonitor:Lcom/android/internal/telephony/LgeTimeZoneMonitor;

    invoke-virtual {v0}, Lcom/android/internal/telephony/LgeTimeZoneMonitor;->receivedNitz()V

    .line 976
    :cond_0
    return-void
.end method

.method protected preProcessPollStateDone()V
    .locals 1

    .prologue
    .line 1010
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->queryInfoForIms()V

    .line 1014
    const-string v0, "KR"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1018
    :cond_0
    return-void
.end method

.method protected regCodeToServiceState(I)I
    .locals 3
    .param p1, "code"    # I

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 429
    const-string v2, "VZW"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "LRA"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "SPR"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "KDDI"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "CTC"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "KR"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 430
    :cond_0
    invoke-super {p0, p1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;->regCodeToServiceState(I)I

    move-result v0

    .line 455
    :goto_0
    :pswitch_0
    return v0

    .line 433
    :cond_1
    packed-switch p1, :pswitch_data_0

    .line 454
    :pswitch_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "regCodeToServiceState: unexpected service state "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->loge(Ljava/lang/String;)V

    goto :goto_0

    .line 444
    :pswitch_2
    const/4 v0, 0x2

    goto :goto_0

    :pswitch_3
    move v0, v1

    .line 447
    goto :goto_0

    :pswitch_4
    move v0, v1

    .line 451
    goto :goto_0

    .line 433
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_3
        :pswitch_0
        :pswitch_2
        :pswitch_0
        :pswitch_4
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_2
        :pswitch_1
        :pswitch_2
        :pswitch_2
        :pswitch_2
    .end packed-switch
.end method

.method protected removeMessageCtNitzCheck(Z)V
    .locals 3
    .param p1, "bFromNitz"    # Z

    .prologue
    const/16 v2, 0x3f9

    .line 704
    const-string v0, "CTC"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 705
    if-eqz p1, :cond_0

    .line 706
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    if-eqz v0, :cond_0

    .line 707
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0}, Landroid/telephony/ServiceState;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLastOperatorNumeric:Ljava/lang/String;

    .line 708
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "CTC : rx nitz in "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLastOperatorNumeric:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 711
    :cond_0
    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->hasMessages(I)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 712
    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->removeMessages(I)V

    .line 716
    :cond_1
    return-void
.end method

.method protected revertToNitzTimeZoneForCTC(Z)Z
    .locals 4
    .param p1, "bNitzUpdatedTime"    # Z

    .prologue
    const/16 v3, 0x3f9

    const/4 v0, 0x1

    .line 719
    const-string v1, "CTC"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 720
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "CTC : bNitzUpdatedTime="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " hasMessages(EVENT_CT_NITZ_CHECK)="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0, v3}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->hasMessages(I)Z

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 721
    if-nez p1, :cond_0

    invoke-virtual {p0, v3}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->hasMessages(I)Z

    move-result v1

    if-nez v1, :cond_0

    .line 722
    invoke-direct {p0, v0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->sendNitzIntent(Z)V

    .line 726
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method protected reviseNullOperatorNumericByCampedMccMnc(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p1, "operatorNumeric"    # Ljava/lang/String;

    .prologue
    .line 913
    const-string v1, "KR"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 914
    const-string v1, "persist.radio.camped_mccmnc"

    const-string v2, ""

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 915
    .local v0, "propCampedMccMnc":Ljava/lang/String;
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getVoiceRegState()I

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v1}, Landroid/telephony/ServiceState;->getDataRegState()I

    move-result v1

    if-nez v1, :cond_1

    :cond_0
    if-nez p1, :cond_1

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    const/4 v2, 0x3

    if-le v1, v2, :cond_1

    .line 918
    const-string v1, "operator numeric is revised by camped mcc/mnc property"

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 919
    move-object p1, v0

    .line 922
    .end local v0    # "propCampedMccMnc":Ljava/lang/String;
    :cond_1
    return-object p1
.end method

.method setAdditionalServiceState([Ljava/lang/String;)V
    .locals 4
    .param p1, "states"    # [Ljava/lang/String;

    .prologue
    const/16 v3, 0xb

    .line 1231
    array-length v0, p1

    const/16 v1, 0xc

    if-lt v0, v1, :cond_3

    aget-object v0, p1, v3

    if-eqz v0, :cond_3

    .line 1233
    const-string v0, "US"

    const-string v1, "TMO"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "US"

    const-string v1, "MPCS"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1234
    :cond_0
    const-string v0, "GsmSST"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[LGE_DEBUG] Check 64QAM : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    aget-object v2, p1, v3

    invoke-static {v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1236
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLGServiceState:Lcom/lge/telephony/LGServiceState;

    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-static {v0}, Lcom/lge/telephony/LGServiceState;->getDefault(Landroid/telephony/ServiceState;)Lcom/lge/telephony/LGServiceState;

    move-result-object v0

    aget-object v1, p1, v3

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/lge/telephony/LGServiceState;->setCheck64QAM(I)V

    .line 1240
    :cond_1
    const-string v0, "EU"

    const-string v1, "VDF"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    const-string v0, "COM"

    const-string v1, "VDF"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    const-string v0, "EU"

    const-string v1, "ORG"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 1243
    :cond_2
    const-string v0, "GsmSST"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[sspark] RAT Dual Carrier : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    aget-object v2, p1, v3

    invoke-static {v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 1245
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mLGServiceState:Lcom/lge/telephony/LGServiceState;

    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mNewSS:Landroid/telephony/ServiceState;

    invoke-static {v0}, Lcom/lge/telephony/LGServiceState;->getDefault(Landroid/telephony/ServiceState;)Lcom/lge/telephony/LGServiceState;

    move-result-object v0

    aget-object v1, p1, v3

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/lge/telephony/LGServiceState;->setRATDualCarrier(I)V

    .line 1249
    :cond_3
    return-void
.end method

.method protected setMultiTimeZoneArea()V
    .locals 1

    .prologue
    .line 879
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->isMultiTimeZoneArea:Z

    .line 880
    return-void
.end method

.method protected setTimeZoneMonitor()V
    .locals 4

    .prologue
    .line 745
    const-string v2, "CTC"

    invoke-static {v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 765
    :cond_0
    :goto_0
    return-void

    .line 748
    :cond_1
    const/4 v2, 0x0

    const-string v3, "MANAGED_TIME_SETTING"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 751
    const/4 v1, 0x0

    .line 752
    .local v1, "iActivePhoneId":I
    invoke-static {}, Landroid/telephony/SubscriptionManager;->getActiveSubInfoList()Ljava/util/List;

    move-result-object v0

    .line 753
    .local v0, "activeSubList":Ljava/util/List;, "Ljava/util/List<Landroid/telephony/SubInfoRecord;>;"
    if-eqz v0, :cond_2

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    if-nez v2, :cond_3

    .line 754
    :cond_2
    const-string v2, "CTC : not use TimeZoneMonitor, because there is no active phone"

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 755
    invoke-direct {p0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->StopTimeZoneMonitor()V

    goto :goto_0

    .line 758
    :cond_3
    const/4 v2, 0x0

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/telephony/SubInfoRecord;

    iget-wide v2, v2, Landroid/telephony/SubInfoRecord;->subId:J

    long-to-int v2, v2

    int-to-long v2, v2

    invoke-static {v2, v3}, Landroid/telephony/SubscriptionManager;->getPhoneId(J)I

    move-result v1

    .line 759
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "CTC : the first active phone\'s PhoneId is "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 760
    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v2}, Lcom/android/internal/telephony/gsm/GSMPhone;->getPhoneId()I

    move-result v2

    if-ne v2, v1, :cond_4

    .line 761
    invoke-direct {p0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->StartTimeZoneMonitor()V

    goto :goto_0

    .line 763
    :cond_4
    invoke-direct {p0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->StopTimeZoneMonitor()V

    goto :goto_0
.end method

.method protected updatePlmnforKDDI(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "plmn"    # Ljava/lang/String;

    .prologue
    .line 506
    const-string v0, "KDDI"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 507
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0}, Landroid/telephony/ServiceState;->getOperatorAlphaShort()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 508
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0}, Landroid/telephony/ServiceState;->getOperatorAlphaShort()Ljava/lang/String;

    move-result-object p1

    .line 511
    :cond_0
    return-object p1
.end method

.method protected updatePlmnforVZW(Lcom/android/internal/telephony/uicc/IccRecords;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "iccRecords"    # Lcom/android/internal/telephony/uicc/IccRecords;
    .param p2, "plmn"    # Ljava/lang/String;

    .prologue
    .line 492
    const-string v0, "VZW"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    if-nez p1, :cond_0

    .line 493
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mSS:Landroid/telephony/ServiceState;

    invoke-virtual {v0}, Landroid/telephony/ServiceState;->getVoiceRegState()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0}, Lcom/android/internal/telephony/CommandsInterface;->getRadioState()Lcom/android/internal/telephony/CommandsInterface$RadioState;

    move-result-object v0

    invoke-virtual {v0}, Lcom/android/internal/telephony/CommandsInterface$RadioState;->isOn()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 494
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x1040377

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getText(I)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p2

    .line 496
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "updateSpnDisplay: Sim = No sim, ServiceState = OUT_OF_SERVICE, RadioState = On, set plmn=\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->log(Ljava/lang/String;)V

    .line 500
    :cond_0
    return-object p2
.end method

.method protected updateSpnDisplay()V
    .locals 1

    .prologue
    .line 463
    const-string v0, "KR"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isCountry(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 464
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mKrSST:Lcom/android/internal/telephony/kr/KrServiceStateTracker;

    if-eqz v0, :cond_0

    .line 465
    iget-object v0, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mKrSST:Lcom/android/internal/telephony/kr/KrServiceStateTracker;

    invoke-virtual {v0}, Lcom/android/internal/telephony/kr/KrServiceStateTracker;->updateSpnDisplay()V

    .line 472
    :cond_0
    :goto_0
    return-void

    .line 471
    :cond_1
    invoke-super {p0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTracker;->updateSpnDisplay()V

    goto :goto_0
.end method

.method protected updateSpnDisplayAfterDelayTime()V
    .locals 4

    .prologue
    .line 476
    iget-object v1, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v1}, Lcom/android/internal/telephony/gsm/GSMPhone;->getPhoneId()I

    move-result v1

    if-nez v1, :cond_0

    .line 477
    invoke-virtual {p0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->updateSpnDisplay()V

    .line 487
    :goto_0
    return-void

    .line 479
    :cond_0
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    .line 480
    .local v0, "handler":Landroid/os/Handler;
    new-instance v1, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx$2;

    invoke-direct {v1, p0}, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx$2;-><init>(Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;)V

    iget-object v2, p0, Lcom/android/internal/telephony/gsm/GsmServiceStateTrackerEx;->mPhone:Lcom/android/internal/telephony/gsm/GSMPhone;

    invoke-virtual {v2}, Lcom/android/internal/telephony/gsm/GSMPhone;->getPhoneId()I

    move-result v2

    mul-int/lit16 v2, v2, 0x3e8

    int-to-long v2, v2

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    goto :goto_0
.end method
