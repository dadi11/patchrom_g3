.class public final Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;
.super Landroid/os/Handler;
.source "KrRoamingEventDispatcher.java"


# static fields
.field private static final CAMPED_MCC:Ljava/lang/String; = "CAMPED_MCC"

.field private static DBG:Z = false

.field protected static final EVENT_NETWORK_MODE_QUERY_DONE:I = 0x3ee

.field protected static final EVENT_NETWORK_MODE_TO_GW_GWL_DONE:I = 0x3ef

.field protected static final EVENT_RADIO_STATE_CHANGED:I = 0x66

.field protected static final EVENT_SET_NT_MODE_TO_WPREF_DONE:I = 0x44d

.field protected static final EVENT_WCDMA_NET_CHANGED:I = 0x64

.field protected static final EVENT_WCDMA_NET_TO_KOREA_CHANGED:I = 0x65

.field private static final LOG_TAG:Ljava/lang/String; = "KrRoamingEventDispatcher"

.field private static final MCC_KR:Ljava/lang/String; = "450"

.field private static final SHAREDPREF_SAVED_CAMPED_MCC:Ljava/lang/String; = "saved_CAMPED_MCC"

.field private static final SHAREDPREF_SAVED_USIM_MCC:Ljava/lang/String; = "saved_usim_mcc"

.field private static final USIM_MCC:Ljava/lang/String; = "usim_mcc"

.field private static roamingEventDispatcher:Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;


# instance fields
.field private mCampedMcc:Ljava/lang/String;

.field private final mCm:Lcom/android/internal/telephony/CommandsInterface;

.field private final mContext:Landroid/content/Context;

.field private mCurCampedMcc:Ljava/lang/String;

.field private mDesiredNwMode:I

.field private mFakeMccChange:Z

.field private mFirstWcdmaNetChanged:Z

.field private mNeedNetwrokModeChange:Z

.field private mOldCampedMcc:Ljava/lang/String;

.field private mPhoneId:I

.field private mSimStateReceiver:Landroid/content/BroadcastReceiver;

.field private mUsimMcc:Ljava/lang/String;

.field private newRadioState:Lcom/android/internal/telephony/CommandsInterface$RadioState;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 64
    const/4 v0, 0x1

    sput-boolean v0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->DBG:Z

    .line 164
    const/4 v0, 0x0

    sput-object v0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->roamingEventDispatcher:Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;

    return-void
.end method

.method private constructor <init>(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;I)V
    .locals 7
    .param p1, "ctx"    # Landroid/content/Context;
    .param p2, "commandsInterface"    # Lcom/android/internal/telephony/CommandsInterface;
    .param p3, "phoneId"    # I

    .prologue
    const/4 v6, 0x0

    const/4 v5, 0x0

    .line 124
    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    .line 72
    const-string v3, ""

    iput-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    .line 73
    const-string v3, ""

    iput-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    .line 88
    const/16 v3, 0x9

    iput v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mDesiredNwMode:I

    .line 89
    iput-boolean v6, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mNeedNetwrokModeChange:Z

    .line 90
    sget-object v3, Lcom/android/internal/telephony/CommandsInterface$RadioState;->RADIO_OFF:Lcom/android/internal/telephony/CommandsInterface$RadioState;

    iput-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->newRadioState:Lcom/android/internal/telephony/CommandsInterface$RadioState;

    .line 100
    const-string v3, ""

    iput-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mUsimMcc:Ljava/lang/String;

    .line 101
    const-string v3, ""

    iput-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    .line 103
    new-instance v3, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher$1;

    invoke-direct {v3, p0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher$1;-><init>(Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;)V

    iput-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mSimStateReceiver:Landroid/content/BroadcastReceiver;

    .line 119
    const/4 v3, 0x1

    iput-boolean v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mFirstWcdmaNetChanged:Z

    .line 120
    iput-boolean v6, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mFakeMccChange:Z

    .line 125
    const-string v3, "KrRoamingEventDispatcher created"

    invoke-static {v3}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 126
    iput-object p1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    .line 127
    iput-object p2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    .line 128
    iput p3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mPhoneId:I

    .line 129
    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    if-eqz v3, :cond_0

    .line 131
    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v4, 0x64

    invoke-interface {v3, p0, v4, v5}, Lcom/android/internal/telephony/CommandsInterface;->registerForWcdmaNetChanged(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 132
    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v4, 0x65

    invoke-interface {v3, p0, v4, v5}, Lcom/android/internal/telephony/CommandsInterface;->registerForWcdmaNetToKoreaChanged(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 134
    const-string v3, "LTE_ROAMING_SKT"

    invoke-static {v5, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 135
    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v4, 0x66

    invoke-interface {v3, p0, v4, v5}, Lcom/android/internal/telephony/CommandsInterface;->registerForRadioStateChanged(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 136
    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v3}, Lcom/android/internal/telephony/CommandsInterface;->getRadioState()Lcom/android/internal/telephony/CommandsInterface$RadioState;

    move-result-object v3

    iput-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->newRadioState:Lcom/android/internal/telephony/CommandsInterface$RadioState;

    .line 145
    :cond_0
    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    const-string v4, "saved_CAMPED_MCC"

    invoke-virtual {v3, v4, v6}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 146
    .local v1, "prefs":Landroid/content/SharedPreferences;
    const-string v3, "CAMPED_MCC"

    const-string v4, ""

    invoke-interface {v1, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 147
    .local v2, "savedMcc":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "SharedPreference(SHAREDPREF_SAVED_CAMPED_MCC) saved mcc = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 148
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_1

    const-string v3, "000"

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 151
    :cond_1
    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    const-string v4, "CAMPED_MCC"

    const-string v5, "450"

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 152
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Init SharedPreference(SHAREDPREF_SAVED_CAMPED_MCC) cammped mcc = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "CAMPED_MCC"

    const-string v5, ""

    invoke-interface {v1, v4, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 157
    :cond_2
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .line 158
    .local v0, "filter":Landroid/content/IntentFilter;
    const-string v3, "android.intent.action.SIM_STATE_CHANGED"

    invoke-virtual {v0, v3}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 159
    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    iget-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mSimStateReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v3, v4, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 162
    return-void
.end method

.method static synthetic access$000(Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;

    .prologue
    .line 55
    invoke-direct {p0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->setUsimMcc()V

    return-void
.end method

.method static synthetic access$100(Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;

    .prologue
    .line 55
    invoke-direct {p0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->calculatetIsroamingPersist()V

    return-void
.end method

.method private broadcastCampedMccChanged(Z)V
    .locals 4
    .param p1, "isCampedMccChanged"    # Z

    .prologue
    .line 556
    if-eqz p1, :cond_2

    .line 557
    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_0

    const-string v2, "450"

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_2

    .line 558
    :cond_0
    const-string v2, "001"

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_2

    .line 559
    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    .line 560
    .local v1, "validOldCampedMcc":Ljava/lang/String;
    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 561
    const-string v1, "450"

    .line 563
    :cond_1
    new-instance v0, Landroid/content/Intent;

    const-string v2, "com.lge.intent.action.LGE_CAMPED_MCC_CHANGE"

    invoke-direct {v0, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 564
    .local v0, "intent":Landroid/content/Intent;
    const-string v2, "newmcc"

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 565
    const-string v2, "oldmcc"

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 567
    const-string v2, "KR"

    const-string v3, "LGU"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 568
    const/4 v2, 0x0

    iput-boolean v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mFakeMccChange:Z

    .line 569
    const-string v2, "FakeMccChange"

    iget-boolean v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mFakeMccChange:Z

    invoke-virtual {v0, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 570
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ACTION_CAMPED_MCC_CHANGE : EXTRA_NEW_MCC = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", EXTRA_OLD_MCC = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", EXTRA_FAKE_MCC_CHANGE = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-boolean v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mFakeMccChange:Z

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 575
    :goto_0
    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    sget-object v3, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v2, v0, v3}, Landroid/content/Context;->sendStickyBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    .line 579
    .end local v0    # "intent":Landroid/content/Intent;
    .end local v1    # "validOldCampedMcc":Ljava/lang/String;
    :cond_2
    return-void

    .line 572
    .restart local v0    # "intent":Landroid/content/Intent;
    .restart local v1    # "validOldCampedMcc":Ljava/lang/String;
    :cond_3
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ACTION_CAMPED_MCC_CHANGE : EXTRA_NEW_MCC = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", EXTRA_OLD_MCC = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private calculatetIsroamingPersist()V
    .locals 2

    .prologue
    .line 386
    invoke-direct {p0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->isUsimRoaming()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 387
    const-string v0, "set PROPERTY_OPERATOR_ISROAMING_PERSIST (persist.radio.isroaming)"

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 388
    const-string v0, "persist.radio.isroaming"

    const-string v1, "true"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 393
    :goto_0
    return-void

    .line 390
    :cond_0
    const-string v0, "reset PROPERTY_OPERATOR_ISROAMING_PERSIST (persist.radio.isroaming)"

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 391
    const-string v0, "persist.radio.isroaming"

    const-string v1, "false"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method private checkAndNWModeChange()V
    .locals 8

    .prologue
    const/4 v7, 0x1

    const/4 v6, -0x1

    .line 317
    const/4 v2, -0x1

    .line 318
    .local v2, "mobile_data":I
    const/4 v0, -0x1

    .line 319
    .local v0, "data_roaming":I
    const/4 v1, -0x1

    .line 321
    .local v1, "lte_roaming":I
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "checkAndNWModeChange:: hasRegistered, mOldCampedMcc = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", mCurCampedMcc = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 323
    const-string v3, "450"

    iget-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    const-string v3, "450"

    iget-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_0

    .line 325
    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "mobile_data"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget v5, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mPhoneId:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4, v6}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v2

    .line 326
    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "data_roaming"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget v5, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mPhoneId:I

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4, v6}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    .line 327
    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "lte_roaming"

    invoke-static {v3, v4, v6}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1

    .line 329
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "mobile_data = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", data_roaming = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", lte_roaming="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 331
    if-ne v2, v7, :cond_1

    if-ne v0, v7, :cond_1

    if-ne v1, v7, :cond_1

    .line 332
    const/16 v3, 0x9

    iput v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mDesiredNwMode:I

    .line 333
    invoke-direct {p0, v6}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->setPreferredNetworkForRoaming(I)V

    .line 339
    :cond_0
    :goto_0
    return-void

    .line 335
    :cond_1
    const/4 v3, 0x0

    iput v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mDesiredNwMode:I

    .line 336
    invoke-direct {p0, v6}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->setPreferredNetworkForRoaming(I)V

    goto :goto_0
.end method

.method public static getInstance(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;I)Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;
    .locals 2
    .param p0, "ctx"    # Landroid/content/Context;
    .param p1, "commandsInterface"    # Lcom/android/internal/telephony/CommandsInterface;
    .param p2, "phoneId"    # I

    .prologue
    .line 171
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "getInstance : roamingEventDispatcher="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->roamingEventDispatcher:Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " ctx="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " commandsInterface="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " phoneId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 176
    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    :cond_0
    const/4 v0, 0x0

    .line 182
    :goto_0
    return-object v0

    .line 178
    :cond_1
    sget-object v0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->roamingEventDispatcher:Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;

    if-nez v0, :cond_2

    .line 179
    new-instance v0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;

    invoke-direct {v0, p0, p1, p2}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;-><init>(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;I)V

    sput-object v0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->roamingEventDispatcher:Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;

    .line 182
    :cond_2
    sget-object v0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->roamingEventDispatcher:Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;

    goto :goto_0
.end method

.method private handleNetworkModeQueryDone(Landroid/os/Message;)V
    .locals 4
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 443
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 444
    .local v0, "ar":Landroid/os/AsyncResult;
    const/4 v1, 0x3

    .line 445
    .local v1, "mPrevNetworkType":I
    iget-object v2, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v2, :cond_0

    .line 446
    iget-object v2, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v2, [I

    check-cast v2, [I

    const/4 v3, 0x0

    aget v1, v2, v3

    .line 448
    :cond_0
    invoke-direct {p0, v1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->setPreferredNetworkForRoaming(I)V

    .line 449
    return-void
.end method

.method private handleNetworkModetoGwGwl(Landroid/os/Message;)V
    .locals 4
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 452
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 453
    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v2, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v2, :cond_1

    .line 454
    iget-object v2, v0, Landroid/os/AsyncResult;->userObj:Ljava/lang/Object;

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v1

    .line 455
    .local v1, "nwMode":I
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "EVENT_NETWORK_MODE_TO_GW_GWL_DONE received nwMod e= "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 456
    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "preferred_network_mode"

    invoke-static {v2, v3, v1}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 457
    const/4 v2, 0x0

    const-string v3, "LTE_ROAMING_SKT"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 458
    const/4 v2, 0x0

    iput-boolean v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mNeedNetwrokModeChange:Z

    .line 463
    .end local v1    # "nwMode":I
    :cond_0
    :goto_0
    return-void

    .line 461
    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "EVENT_NETWORK_MODE_TO_GW_GWL_DONE ERROR ar.exception = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private handleRadioStateChanged(Landroid/os/Message;)V
    .locals 3
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 416
    const/4 v1, 0x0

    const-string v2, "LTE_ROAMING_SKT"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 417
    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->newRadioState:Lcom/android/internal/telephony/CommandsInterface$RadioState;

    .line 418
    .local v0, "oldRadioState":Lcom/android/internal/telephony/CommandsInterface$RadioState;
    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v1}, Lcom/android/internal/telephony/CommandsInterface;->getRadioState()Lcom/android/internal/telephony/CommandsInterface$RadioState;

    move-result-object v1

    iput-object v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->newRadioState:Lcom/android/internal/telephony/CommandsInterface$RadioState;

    .line 419
    sget-object v1, Lcom/android/internal/telephony/CommandsInterface$RadioState;->RADIO_OFF:Lcom/android/internal/telephony/CommandsInterface$RadioState;

    if-ne v0, v1, :cond_2

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->newRadioState:Lcom/android/internal/telephony/CommandsInterface$RadioState;

    sget-object v2, Lcom/android/internal/telephony/CommandsInterface$RadioState;->RADIO_ON:Lcom/android/internal/telephony/CommandsInterface$RadioState;

    if-ne v1, v2, :cond_2

    .line 420
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mNeedNetwrokModeChange:Z

    .line 424
    :cond_0
    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "EVENT_RADIO_STATE_CHANGED mNeedNetworkModeChange = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mNeedNetwrokModeChange:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 426
    .end local v0    # "oldRadioState":Lcom/android/internal/telephony/CommandsInterface$RadioState;
    :cond_1
    return-void

    .line 421
    .restart local v0    # "oldRadioState":Lcom/android/internal/telephony/CommandsInterface$RadioState;
    :cond_2
    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->newRadioState:Lcom/android/internal/telephony/CommandsInterface$RadioState;

    invoke-virtual {v1}, Lcom/android/internal/telephony/CommandsInterface$RadioState;->isOn()Z

    move-result v1

    if-nez v1, :cond_0

    .line 422
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mNeedNetwrokModeChange:Z

    goto :goto_0
.end method

.method private handleSetNetModeToWPrefDone(Landroid/os/Message;)V
    .locals 3
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 430
    const-string v0, "KR"

    const-string v1, "LGU"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 431
    const-string v0, "Network mode change (GWL->GW) completed"

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 432
    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "preferred_network_mode"

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 438
    :cond_0
    return-void
.end method

.method private handleWcdmaNetChanged(Landroid/os/Message;)V
    .locals 8
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v7, 0x0

    const/4 v6, 0x1

    .line 583
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 584
    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v4, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v4, :cond_2

    iget-object v4, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v4, [I

    check-cast v4, [I

    array-length v4, v4

    if-le v4, v6, :cond_2

    .line 585
    iget-object v4, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v4, [I

    check-cast v4, [I

    const/4 v5, 0x0

    aget v2, v4, v5

    .line 586
    .local v2, "mcc":I
    iget-object v4, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v4, [I

    check-cast v4, [I

    aget v3, v4, v6

    .line 587
    .local v3, "rat":I
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "EVENT_WCDMA_NET_CHANGED : mcc = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", rat = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 589
    invoke-static {v2}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    .line 590
    const-string v4, "1"

    iget-object v5, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_0

    const-string v4, "0"

    iget-object v5, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 591
    :cond_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "00"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    .line 594
    :cond_1
    iget-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    invoke-direct {p0, v4}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->saveNetworkInfo(Ljava/lang/String;)Z

    move-result v1

    .line 595
    .local v1, "isCampedMccChanged":Z
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "EVENT_WCDMA_NET_CHANGED : isCampedMccChanged = "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 598
    invoke-direct {p0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->calculatetIsroamingPersist()V

    .line 602
    invoke-direct {p0, v1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->broadcastCampedMccChanged(Z)V

    .line 606
    const-string v4, "KR"

    const-string v5, "LGU"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 607
    invoke-direct {p0, v1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->handleWcdmaNetChangedLGU(Z)V

    .line 630
    .end local v1    # "isCampedMccChanged":Z
    .end local v2    # "mcc":I
    .end local v3    # "rat":I
    :cond_2
    :goto_0
    return-void

    .line 612
    .restart local v1    # "isCampedMccChanged":Z
    .restart local v2    # "mcc":I
    .restart local v3    # "rat":I
    :cond_3
    const-string v4, "KR"

    const-string v5, "SKT"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 613
    invoke-direct {p0, v1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->handleWcdmaNetChangedSKT(Z)V

    goto :goto_0

    .line 616
    :cond_4
    const-string v4, "KR"

    const-string v5, "KT"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 618
    const-string v4, "LTE_ROAMING_KT"

    invoke-static {v7, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 619
    const-string v4, "EVENT_WCDMA_NET_CHANGED : KEY_LTE_ROAMING_KT"

    invoke-static {v4}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 620
    const-string v4, "network_mode_change_in_ril"

    invoke-static {v7, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_5

    .line 621
    const-string v4, "Network Mode Change not supported in framework"

    invoke-static {v4}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 624
    :cond_5
    invoke-direct {p0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->checkAndNWModeChange()V

    goto :goto_0
.end method

.method private handleWcdmaNetChangedLGU(Z)V
    .locals 4
    .param p1, "isCampedMccChanged"    # Z

    .prologue
    const/4 v3, 0x0

    .line 469
    const-string v0, "KR"

    const-string v1, "LGU"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 470
    if-eqz p1, :cond_0

    .line 471
    const-string v0, "450"

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 472
    const-string v0, "lgu_lte_roaming"

    invoke-static {v3, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 473
    const-string v0, "Maintain network mode as GWL to support LTE roaming."

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 486
    :goto_0
    const-string v0, "001"

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 487
    const-string v0, "OEM_RAD_DIALER_POPUP"

    invoke-static {v3, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 489
    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "oem_rad_dialer_popup"

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 490
    const-string v0, "SettingsConstants.Secure.OEM_RAD_DIALER_POPUP set 1 by LGU+ scenario"

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 502
    :cond_0
    return-void

    .line 474
    :cond_1
    const-string v0, "network_mode_change_in_ril"

    invoke-static {v3, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 475
    const-string v0, "Network Mode Change not supported in framework"

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 478
    :cond_2
    const-string v0, "001"

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    const-string v0, "1"

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    const-string v0, "000"

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 479
    :cond_3
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " is invalid MCC, Do NOT change preferred network mode."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 481
    :cond_4
    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    const/4 v1, 0x0

    const/16 v2, 0x44d

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->obtainMessage(I)Landroid/os/Message;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Lcom/android/internal/telephony/CommandsInterface;->setPreferredNetworkType(ILandroid/os/Message;)V

    .line 482
    const-string v0, "Change network mode (GWL->GW) arriving at roaming area."

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private handleWcdmaNetChangedSKT(Z)V
    .locals 8
    .param p1, "isCampedMccChanged"    # Z

    .prologue
    const/4 v7, 0x1

    const/4 v6, 0x0

    const/4 v5, 0x0

    .line 506
    const-string v2, "ril.card_operator"

    const-string v3, ""

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 507
    .local v0, "card_operator":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ril.card_operator: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 508
    const-string v2, "SKT"

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    const-string v2, "TEST"

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 509
    const-string v2, "This is not skt usim, do nothing"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 552
    :cond_0
    :goto_0
    return-void

    .line 511
    :cond_1
    const-string v2, "450"

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "001"

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "000"

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 512
    const-string v2, "LTE_ROAMING_SKT"

    invoke-static {v5, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-boolean v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mNeedNetwrokModeChange:Z

    if-eqz v2, :cond_0

    .line 513
    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "preferred_network_mode"

    const/16 v4, 0x9

    invoke-static {v2, v3, v4}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1

    .line 517
    .local v1, "settingNetworkMode":I
    if-eqz p1, :cond_4

    .line 519
    const-string v2, "OEM_RAD_DIALER_POPUP"

    invoke-static {v5, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 520
    const-string v2, "450"

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 521
    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "oem_rad_dialer_popup"

    invoke-static {v2, v3, v7}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 522
    const-string v2, "SettingsConstants.Secure.OEM_RAD_DIALER_POPUP set 1 by SKT scenario"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 527
    :cond_2
    const-string v2, "network_mode_change_in_ril"

    invoke-static {v5, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 528
    const-string v2, "Network Mode Change not supported in framework"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 531
    :cond_3
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "EVENT_WCDMA_NET_CHANGED : KEY_LTE_ROAMING_SKT mNeedNetwrokModeChange = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-boolean v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mNeedNetwrokModeChange:Z

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 532
    iput v6, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mDesiredNwMode:I

    .line 533
    invoke-direct {p0, v1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->setPreferredNetworkForRoaming(I)V

    goto/16 :goto_0

    .line 536
    :cond_4
    const-string v2, "network_mode_change_in_ril"

    invoke-static {v5, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_5

    .line 537
    const-string v2, "Network Mode Change not supported in framework"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 539
    :cond_5
    if-eq v1, v7, :cond_6

    const/4 v2, 0x2

    if-eq v1, v2, :cond_6

    const/16 v2, 0xb

    if-ne v1, v2, :cond_7

    .line 542
    :cond_6
    iput-boolean v6, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mNeedNetwrokModeChange:Z

    .line 543
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "EVENT_WCDMA_NET_CHANGED : Keep the NW mode for engineer test, settingNetworkMode = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    .line 545
    :cond_7
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "EVENT_WCDMA_NET_CHANGED : KEY_LTE_ROAMING_SKT mNeedNetwrokModeChange = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-boolean v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mNeedNetwrokModeChange:Z

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 546
    iput v6, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mDesiredNwMode:I

    .line 547
    invoke-direct {p0, v1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->setPreferredNetworkForRoaming(I)V

    goto/16 :goto_0
.end method

.method private handleWcdmaNetChangedToKorea(Landroid/os/Message;)V
    .locals 10
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v9, 0x0

    const/4 v7, 0x0

    const/4 v6, 0x1

    .line 633
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 634
    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v5, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v5, :cond_5

    iget-object v5, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v5, [I

    check-cast v5, [I

    array-length v5, v5

    if-le v5, v6, :cond_5

    .line 635
    iget-object v5, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v5, [I

    check-cast v5, [I

    aget v3, v5, v7

    .line 636
    .local v3, "mcc":I
    iget-object v5, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v5, [I

    check-cast v5, [I

    aget v4, v5, v6

    .line 637
    .local v4, "rat":I
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "EVENT_WCDMA_NET_TO_KOREA_CHANGED mcc = "

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v8, ", rat = "

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 639
    invoke-static {v3}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v5

    iput-object v5, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    .line 640
    const-string v5, "1"

    iget-object v8, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    invoke-virtual {v5, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_0

    const-string v5, "0"

    iget-object v8, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    invoke-virtual {v5, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 641
    :cond_0
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "00"

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v8, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    iput-object v5, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    .line 644
    :cond_1
    iget-object v5, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    invoke-direct {p0, v5}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->saveNetworkInfo(Ljava/lang/String;)Z

    move-result v2

    .line 645
    .local v2, "isCampedMccChanged":Z
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "EVENT_WCDMA_NET_TO_KOREA_CHANGED : isCampedMccChanged = "

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 648
    invoke-direct {p0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->calculatetIsroamingPersist()V

    .line 652
    if-eqz v2, :cond_2

    .line 653
    const-string v5, "450"

    iget-object v8, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v5, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_2

    const-string v5, "001"

    iget-object v8, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    invoke-virtual {v5, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_2

    .line 654
    new-instance v1, Landroid/content/Intent;

    const-string v5, "com.lge.intent.action.LGE_CAMPED_MCC_CHANGE"

    invoke-direct {v1, v5}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 655
    .local v1, "intent":Landroid/content/Intent;
    const-string v5, "newmcc"

    iget-object v8, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v1, v5, v8}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 656
    const-string v5, "oldmcc"

    iget-object v8, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    invoke-virtual {v1, v5, v8}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 658
    const-string v5, "KR"

    const-string v8, "LGU"

    invoke-static {v5, v8}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_7

    .line 659
    const-string v5, "999"

    iget-object v8, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    invoke-virtual {v5, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_6

    move v5, v6

    :goto_0
    iput-boolean v5, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mFakeMccChange:Z

    .line 660
    const-string v5, "FakeMccChange"

    iget-boolean v8, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mFakeMccChange:Z

    invoke-virtual {v1, v5, v8}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 661
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "ACTION_CAMPED_MCC_CHANGE : EXTRA_NEW_MCC = "

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v8, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v8, ", EXTRA_OLD_MCC = "

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v8, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v8, ", EXTRA_FAKE_MCC_CHANGE = "

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-boolean v8, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mFakeMccChange:Z

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 666
    :goto_1
    iget-object v5, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    sget-object v8, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v5, v1, v8}, Landroid/content/Context;->sendStickyBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    .line 672
    .end local v1    # "intent":Landroid/content/Intent;
    :cond_2
    if-eqz v2, :cond_3

    const-string v5, "OEM_RAD_DIALER_POPUP"

    invoke-static {v9, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_3

    .line 673
    iget-object v5, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v5}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v5

    const-string v8, "oem_rad_dialer_popup"

    invoke-static {v5, v8, v7}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 674
    const-string v5, "SettingsConstants.Secure.OEM_RAD_DIALER_POPUP set 0 by SKT scenario"

    invoke-static {v5}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 679
    :cond_3
    const-string v5, "LTE_ROAMING_SKT"

    invoke-static {v9, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_4

    .line 680
    iput-boolean v6, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mNeedNetwrokModeChange:Z

    .line 681
    const-string v5, "Set true the mNeedNetwrokModeChange for next roaming"

    invoke-static {v5}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 685
    :cond_4
    const-string v5, "KR"

    const-string v6, "LGU"

    invoke-static {v5, v6}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_8

    .line 693
    .end local v2    # "isCampedMccChanged":Z
    .end local v3    # "mcc":I
    .end local v4    # "rat":I
    :cond_5
    :goto_2
    return-void

    .restart local v1    # "intent":Landroid/content/Intent;
    .restart local v2    # "isCampedMccChanged":Z
    .restart local v3    # "mcc":I
    .restart local v4    # "rat":I
    :cond_6
    move v5, v7

    .line 659
    goto :goto_0

    .line 663
    :cond_7
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "ACTION_CAMPED_MCC_CHANGE : EXTRA_NEW_MCC = "

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v8, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v8, ", EXTRA_OLD_MCC = "

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v8, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    goto :goto_1

    .line 687
    .end local v1    # "intent":Landroid/content/Intent;
    :cond_8
    const-string v5, "KR"

    const-string v6, "SKT"

    invoke-static {v5, v6}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_5

    .line 689
    const-string v5, "KR"

    const-string v6, "KT"

    invoke-static {v5, v6}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_5

    goto :goto_2
.end method

.method private isUsimRoaming()Z
    .locals 6

    .prologue
    const/4 v2, 0x0

    .line 355
    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mUsimMcc:Ljava/lang/String;

    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 356
    const-string v3, "ril.card_operator"

    const-string v4, ""

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 357
    .local v0, "cardOperator":Ljava/lang/String;
    const-string v3, "SKT"

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_0

    const-string v3, "KT"

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_0

    const-string v3, "LGU"

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 358
    :cond_0
    const-string v3, "450"

    iput-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mUsimMcc:Ljava/lang/String;

    .line 359
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "set Usim MCC = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mUsimMcc:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", card_operator = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 368
    .end local v0    # "cardOperator":Ljava/lang/String;
    :cond_1
    :goto_0
    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 369
    const-string v3, "persist.radio.camped_mccmnc"

    const-string v4, ""

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 370
    .local v1, "propCampedMccMnc":Ljava/lang/String;
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_2

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v3

    const/4 v4, 0x5

    if-lt v3, v4, :cond_2

    .line 371
    const/4 v3, 0x3

    invoke-virtual {v1, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    .line 372
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "propCampedMccMnc : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", mCampedMcc : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 376
    .end local v1    # "propCampedMccMnc":Ljava/lang/String;
    :cond_2
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "mUsimMcc : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mUsimMcc:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", mCampedMcc : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 378
    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_3

    const-string v3, "000"

    iget-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    const-string v3, "001"

    iget-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    .line 379
    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mUsimMcc:Ljava/lang/String;

    iget-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    const/4 v2, 0x1

    .line 381
    :cond_3
    return v2

    .line 360
    .restart local v0    # "cardOperator":Ljava/lang/String;
    :cond_4
    const-string v3, "TEST"

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    .line 363
    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    const-string v4, "saved_usim_mcc"

    invoke-virtual {v3, v4, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v3

    const-string v4, "usim_mcc"

    const-string v5, "450"

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mUsimMcc:Ljava/lang/String;

    .line 364
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "saved Usim MCC = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mUsimMcc:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    goto/16 :goto_0
.end method

.method protected static log(Ljava/lang/String;)V
    .locals 1
    .param p0, "s"    # Ljava/lang/String;

    .prologue
    .line 696
    sget-boolean v0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->DBG:Z

    if-eqz v0, :cond_0

    .line 697
    const-string v0, "KrRoamingEventDispatcher"

    invoke-static {v0, p0}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 699
    :cond_0
    return-void
.end method

.method private saveNetworkInfo(Ljava/lang/String;)Z
    .locals 6
    .param p1, "new_mcc"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 271
    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    const-string v4, "saved_CAMPED_MCC"

    invoke-virtual {v3, v4, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 272
    .local v0, "prefs":Landroid/content/SharedPreferences;
    const-string v3, "CAMPED_MCC"

    const-string v4, ""

    invoke-interface {v0, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    .line 273
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "prefs get = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 275
    const-string v3, "000"

    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    .line 277
    iput-object p1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    .line 279
    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_1

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    iget-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 281
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    const-string v4, "CAMPED_MCC"

    iget-object v5, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 282
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "prefs put = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "CAMPED_MCC"

    const-string v5, ""

    invoke-interface {v0, v4, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 284
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "mOldCampedMcc = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", mCurCampedMcc = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 287
    const-string v3, "KR"

    const-string v4, "LGU"

    invoke-static {v3, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 288
    iget-boolean v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mFirstWcdmaNetChanged:Z

    if-eqz v3, :cond_0

    .line 289
    iput-boolean v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mFirstWcdmaNetChanged:Z

    .line 290
    const-string v2, "Generating real mcc change event..."

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 313
    :cond_0
    :goto_0
    return v1

    .line 299
    :cond_1
    const-string v3, "KR"

    const-string v4, "LGU"

    invoke-static {v3, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 300
    iget-boolean v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mFirstWcdmaNetChanged:Z

    if-eqz v3, :cond_2

    .line 301
    iput-boolean v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mFirstWcdmaNetChanged:Z

    .line 302
    const-string v3, "450"

    iget-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    const-string v3, "450"

    iget-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 303
    const-string v2, "999"

    iput-object v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    .line 304
    const-string v2, "Generating fake MCC change event..."

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 312
    :cond_2
    const-string v1, "mOldCampedMcc, mCurCampedMcc is not changed"

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    move v1, v2

    .line 313
    goto :goto_0
.end method

.method private setPreferredNetworkForRoaming(I)V
    .locals 4
    .param p1, "mPrevNetworkMode"    # I

    .prologue
    .line 239
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Current Network Mode : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 240
    const/4 v0, -0x1

    if-ne p1, v0, :cond_1

    .line 241
    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v1, 0x3ee

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/android/internal/telephony/CommandsInterface;->getPreferredNetworkType(Landroid/os/Message;)V

    .line 254
    :cond_0
    :goto_0
    return-void

    .line 243
    :cond_1
    iget v0, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mDesiredNwMode:I

    if-ne p1, v0, :cond_2

    .line 244
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Aleady mDesiredNwMode :: mPrevNetworkMode = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", mDesiredNwMode = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mDesiredNwMode:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 245
    const/4 v0, 0x0

    const-string v1, "LTE_ROAMING_SKT"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 246
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mNeedNetwrokModeChange:Z

    goto :goto_0

    .line 250
    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Change GW/GWL Network Mode : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " -> "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mDesiredNwMode:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 251
    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    iget v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mDesiredNwMode:I

    const/16 v2, 0x3ef

    iget v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mDesiredNwMode:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {p0, v2, v3}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Lcom/android/internal/telephony/CommandsInterface;->setPreferredNetworkType(ILandroid/os/Message;)V

    goto :goto_0
.end method

.method private setUsimMcc()V
    .locals 5

    .prologue
    const/4 v4, 0x3

    const/4 v3, 0x0

    .line 344
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v1

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getSimOperator()Ljava/lang/String;

    move-result-object v0

    .line 345
    .local v0, "temp_Usim_MccMnc":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-le v1, v4, :cond_0

    const-string v1, "000"

    invoke-virtual {v0, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "001"

    invoke-virtual {v0, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 348
    invoke-virtual {v0, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mUsimMcc:Ljava/lang/String;

    .line 349
    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    const-string v2, "saved_usim_mcc"

    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "usim_mcc"

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mUsimMcc:Ljava/lang/String;

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 350
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Usim\'s MCC : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mUsimMcc:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 352
    :cond_0
    return-void
.end method


# virtual methods
.method protected finalize()V
    .locals 2

    .prologue
    .line 398
    const-string v0, "KrRoamingEventDispatcher finalized"

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 400
    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    if-eqz v0, :cond_0

    .line 402
    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForWcdmaNetChanged(Landroid/os/Handler;)V

    .line 403
    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForWcdmaNetToKoreaChanged(Landroid/os/Handler;)V

    .line 405
    const/4 v0, 0x0

    const-string v1, "LTE_ROAMING_SKT"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 406
    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForRadioStateChanged(Landroid/os/Handler;)V

    .line 410
    :cond_0
    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mSimStateReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 413
    return-void
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 2
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 190
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "New Roaming Event Message Received : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p1, Landroid/os/Message;->what:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 192
    iget v0, p1, Landroid/os/Message;->what:I

    sparse-switch v0, :sswitch_data_0

    .line 229
    const-string v0, "KrRoamingEventDispatcher unexpected handleMessage case"

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    .line 233
    :goto_0
    return-void

    .line 194
    :sswitch_0
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->handleRadioStateChanged(Landroid/os/Message;)V

    goto :goto_0

    .line 198
    :sswitch_1
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->handleSetNetModeToWPrefDone(Landroid/os/Message;)V

    goto :goto_0

    .line 204
    :sswitch_2
    const/4 v0, 0x0

    const-string v1, "network_mode_change_in_ril"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 205
    const-string v0, "Network Mode Change not supported in framework"

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 210
    :cond_0
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->handleNetworkModeQueryDone(Landroid/os/Message;)V

    goto :goto_0

    .line 214
    :sswitch_3
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->handleNetworkModetoGwGwl(Landroid/os/Message;)V

    goto :goto_0

    .line 220
    :sswitch_4
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->handleWcdmaNetChanged(Landroid/os/Message;)V

    goto :goto_0

    .line 225
    :sswitch_5
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->handleWcdmaNetChangedToKorea(Landroid/os/Message;)V

    goto :goto_0

    .line 192
    :sswitch_data_0
    .sparse-switch
        0x64 -> :sswitch_4
        0x65 -> :sswitch_5
        0x66 -> :sswitch_0
        0x3ee -> :sswitch_2
        0x3ef -> :sswitch_3
        0x44d -> :sswitch_1
    .end sparse-switch
.end method
