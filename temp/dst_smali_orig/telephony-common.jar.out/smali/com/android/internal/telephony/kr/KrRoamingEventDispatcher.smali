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
    const/4 v0, 0x1

    sput-boolean v0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->DBG:Z

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

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    const-string v3, ""

    iput-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    const-string v3, ""

    iput-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    const/16 v3, 0x9

    iput v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mDesiredNwMode:I

    iput-boolean v6, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mNeedNetwrokModeChange:Z

    sget-object v3, Lcom/android/internal/telephony/CommandsInterface$RadioState;->RADIO_OFF:Lcom/android/internal/telephony/CommandsInterface$RadioState;

    iput-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->newRadioState:Lcom/android/internal/telephony/CommandsInterface$RadioState;

    const-string v3, ""

    iput-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mUsimMcc:Ljava/lang/String;

    const-string v3, ""

    iput-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    new-instance v3, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher$1;

    invoke-direct {v3, p0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher$1;-><init>(Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;)V

    iput-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mSimStateReceiver:Landroid/content/BroadcastReceiver;

    const/4 v3, 0x1

    iput-boolean v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mFirstWcdmaNetChanged:Z

    iput-boolean v6, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mFakeMccChange:Z

    const-string v3, "KrRoamingEventDispatcher created"

    invoke-static {v3}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    iput-object p1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    iput-object p2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    iput p3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mPhoneId:I

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    if-eqz v3, :cond_0

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v4, 0x64

    invoke-interface {v3, p0, v4, v5}, Lcom/android/internal/telephony/CommandsInterface;->registerForWcdmaNetChanged(Landroid/os/Handler;ILjava/lang/Object;)V

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v4, 0x65

    invoke-interface {v3, p0, v4, v5}, Lcom/android/internal/telephony/CommandsInterface;->registerForWcdmaNetToKoreaChanged(Landroid/os/Handler;ILjava/lang/Object;)V

    const-string v3, "LTE_ROAMING_SKT"

    invoke-static {v5, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v4, 0x66

    invoke-interface {v3, p0, v4, v5}, Lcom/android/internal/telephony/CommandsInterface;->registerForRadioStateChanged(Landroid/os/Handler;ILjava/lang/Object;)V

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v3}, Lcom/android/internal/telephony/CommandsInterface;->getRadioState()Lcom/android/internal/telephony/CommandsInterface$RadioState;

    move-result-object v3

    iput-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->newRadioState:Lcom/android/internal/telephony/CommandsInterface$RadioState;

    :cond_0
    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    const-string v4, "saved_CAMPED_MCC"

    invoke-virtual {v3, v4, v6}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    .local v1, "prefs":Landroid/content/SharedPreferences;
    const-string v3, "CAMPED_MCC"

    const-string v4, ""

    invoke-interface {v1, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

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

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_1

    const-string v3, "000"

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    :cond_1
    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    const-string v4, "CAMPED_MCC"

    const-string v5, "450"

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->commit()Z

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

    :cond_2
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    .local v0, "filter":Landroid/content/IntentFilter;
    const-string v3, "android.intent.action.SIM_STATE_CHANGED"

    invoke-virtual {v0, v3}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    iget-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mSimStateReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v3, v4, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    return-void
.end method

.method static synthetic access$000(Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;

    .prologue
    invoke-direct {p0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->setUsimMcc()V

    return-void
.end method

.method static synthetic access$100(Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;)V
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;

    .prologue
    invoke-direct {p0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->calculatetIsroamingPersist()V

    return-void
.end method

.method private broadcastCampedMccChanged(Z)V
    .locals 4
    .param p1, "isCampedMccChanged"    # Z

    .prologue
    if-eqz p1, :cond_2

    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_0

    const-string v2, "450"

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_2

    :cond_0
    const-string v2, "001"

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_2

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    .local v1, "validOldCampedMcc":Ljava/lang/String;
    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1

    const-string v1, "450"

    :cond_1
    new-instance v0, Landroid/content/Intent;

    const-string v2, "com.lge.intent.action.LGE_CAMPED_MCC_CHANGE"

    invoke-direct {v0, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v0, "intent":Landroid/content/Intent;
    const-string v2, "newmcc"

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v2, "oldmcc"

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v2, "KR"

    const-string v3, "LGU"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    const/4 v2, 0x0

    iput-boolean v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mFakeMccChange:Z

    const-string v2, "FakeMccChange"

    iget-boolean v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mFakeMccChange:Z

    invoke-virtual {v0, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

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

    :goto_0
    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    sget-object v3, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v2, v0, v3}, Landroid/content/Context;->sendStickyBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    .end local v0    # "intent":Landroid/content/Intent;
    .end local v1    # "validOldCampedMcc":Ljava/lang/String;
    :cond_2
    return-void

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
    invoke-direct {p0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->isUsimRoaming()Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "set PROPERTY_OPERATOR_ISROAMING_PERSIST (persist.radio.isroaming)"

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    const-string v0, "persist.radio.isroaming"

    const-string v1, "true"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_0
    const-string v0, "reset PROPERTY_OPERATOR_ISROAMING_PERSIST (persist.radio.isroaming)"

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

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

    const/4 v2, -0x1

    .local v2, "mobile_data":I
    const/4 v0, -0x1

    .local v0, "data_roaming":I
    const/4 v1, -0x1

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

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "lte_roaming"

    invoke-static {v3, v4, v6}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1

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

    if-ne v2, v7, :cond_1

    if-ne v0, v7, :cond_1

    if-ne v1, v7, :cond_1

    const/16 v3, 0x9

    iput v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mDesiredNwMode:I

    invoke-direct {p0, v6}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->setPreferredNetworkForRoaming(I)V

    :cond_0
    :goto_0
    return-void

    :cond_1
    const/4 v3, 0x0

    iput v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mDesiredNwMode:I

    invoke-direct {p0, v6}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->setPreferredNetworkForRoaming(I)V

    goto :goto_0
.end method

.method public static getInstance(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;I)Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;
    .locals 2
    .param p0, "ctx"    # Landroid/content/Context;
    .param p1, "commandsInterface"    # Lcom/android/internal/telephony/CommandsInterface;
    .param p2, "phoneId"    # I

    .prologue
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

    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_1
    sget-object v0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->roamingEventDispatcher:Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;

    if-nez v0, :cond_2

    new-instance v0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;

    invoke-direct {v0, p0, p1, p2}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;-><init>(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;I)V

    sput-object v0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->roamingEventDispatcher:Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;

    :cond_2
    sget-object v0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->roamingEventDispatcher:Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;

    goto :goto_0
.end method

.method private handleNetworkModeQueryDone(Landroid/os/Message;)V
    .locals 4
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .local v0, "ar":Landroid/os/AsyncResult;
    const/4 v1, 0x3

    .local v1, "mPrevNetworkType":I
    iget-object v2, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v2, :cond_0

    iget-object v2, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v2, [I

    check-cast v2, [I

    const/4 v3, 0x0

    aget v1, v2, v3

    :cond_0
    invoke-direct {p0, v1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->setPreferredNetworkForRoaming(I)V

    return-void
.end method

.method private handleNetworkModetoGwGwl(Landroid/os/Message;)V
    .locals 4
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v2, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v2, :cond_1

    iget-object v2, v0, Landroid/os/AsyncResult;->userObj:Ljava/lang/Object;

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v1

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

    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "preferred_network_mode"

    invoke-static {v2, v3, v1}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    const/4 v2, 0x0

    const-string v3, "LTE_ROAMING_SKT"

    invoke-static {v2, v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    const/4 v2, 0x0

    iput-boolean v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mNeedNetwrokModeChange:Z

    .end local v1    # "nwMode":I
    :cond_0
    :goto_0
    return-void

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
    const/4 v1, 0x0

    const-string v2, "LTE_ROAMING_SKT"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->newRadioState:Lcom/android/internal/telephony/CommandsInterface$RadioState;

    .local v0, "oldRadioState":Lcom/android/internal/telephony/CommandsInterface$RadioState;
    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v1}, Lcom/android/internal/telephony/CommandsInterface;->getRadioState()Lcom/android/internal/telephony/CommandsInterface$RadioState;

    move-result-object v1

    iput-object v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->newRadioState:Lcom/android/internal/telephony/CommandsInterface$RadioState;

    sget-object v1, Lcom/android/internal/telephony/CommandsInterface$RadioState;->RADIO_OFF:Lcom/android/internal/telephony/CommandsInterface$RadioState;

    if-ne v0, v1, :cond_2

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->newRadioState:Lcom/android/internal/telephony/CommandsInterface$RadioState;

    sget-object v2, Lcom/android/internal/telephony/CommandsInterface$RadioState;->RADIO_ON:Lcom/android/internal/telephony/CommandsInterface$RadioState;

    if-ne v1, v2, :cond_2

    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mNeedNetwrokModeChange:Z

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

    .end local v0    # "oldRadioState":Lcom/android/internal/telephony/CommandsInterface$RadioState;
    :cond_1
    return-void

    .restart local v0    # "oldRadioState":Lcom/android/internal/telephony/CommandsInterface$RadioState;
    :cond_2
    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->newRadioState:Lcom/android/internal/telephony/CommandsInterface$RadioState;

    invoke-virtual {v1}, Lcom/android/internal/telephony/CommandsInterface$RadioState;->isOn()Z

    move-result v1

    if-nez v1, :cond_0

    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mNeedNetwrokModeChange:Z

    goto :goto_0
.end method

.method private handleSetNetModeToWPrefDone(Landroid/os/Message;)V
    .locals 3
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const-string v0, "KR"

    const-string v1, "LGU"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "Network mode change (GWL->GW) completed"

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "preferred_network_mode"

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    :cond_0
    return-void
.end method

.method private handleWcdmaNetChanged(Landroid/os/Message;)V
    .locals 8
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v7, 0x0

    const/4 v6, 0x1

    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v4, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v4, :cond_2

    iget-object v4, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v4, [I

    check-cast v4, [I

    array-length v4, v4

    if-le v4, v6, :cond_2

    iget-object v4, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v4, [I

    check-cast v4, [I

    const/4 v5, 0x0

    aget v2, v4, v5

    .local v2, "mcc":I
    iget-object v4, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v4, [I

    check-cast v4, [I

    aget v3, v4, v6

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

    invoke-static {v2}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

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

    :cond_1
    iget-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    invoke-direct {p0, v4}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->saveNetworkInfo(Ljava/lang/String;)Z

    move-result v1

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

    invoke-direct {p0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->calculatetIsroamingPersist()V

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->broadcastCampedMccChanged(Z)V

    const-string v4, "KR"

    const-string v5, "LGU"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_3

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->handleWcdmaNetChangedLGU(Z)V

    .end local v1    # "isCampedMccChanged":Z
    .end local v2    # "mcc":I
    .end local v3    # "rat":I
    :cond_2
    :goto_0
    return-void

    .restart local v1    # "isCampedMccChanged":Z
    .restart local v2    # "mcc":I
    .restart local v3    # "rat":I
    :cond_3
    const-string v4, "KR"

    const-string v5, "SKT"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_4

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->handleWcdmaNetChangedSKT(Z)V

    goto :goto_0

    :cond_4
    const-string v4, "KR"

    const-string v5, "KT"

    invoke-static {v4, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_2

    const-string v4, "LTE_ROAMING_KT"

    invoke-static {v7, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_2

    const-string v4, "EVENT_WCDMA_NET_CHANGED : KEY_LTE_ROAMING_KT"

    invoke-static {v4}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    const-string v4, "network_mode_change_in_ril"

    invoke-static {v7, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_5

    const-string v4, "Network Mode Change not supported in framework"

    invoke-static {v4}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    goto :goto_0

    :cond_5
    invoke-direct {p0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->checkAndNWModeChange()V

    goto :goto_0
.end method

.method private handleWcdmaNetChangedLGU(Z)V
    .locals 4
    .param p1, "isCampedMccChanged"    # Z

    .prologue
    const/4 v3, 0x0

    const-string v0, "KR"

    const-string v1, "LGU"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    if-eqz p1, :cond_0

    const-string v0, "450"

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "lgu_lte_roaming"

    invoke-static {v3, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "Maintain network mode as GWL to support LTE roaming."

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    :goto_0
    const-string v0, "001"

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "OEM_RAD_DIALER_POPUP"

    invoke-static {v3, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "oem_rad_dialer_popup"

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    const-string v0, "SettingsConstants.Secure.OEM_RAD_DIALER_POPUP set 1 by LGU+ scenario"

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    :cond_0
    return-void

    :cond_1
    const-string v0, "network_mode_change_in_ril"

    invoke-static {v3, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    const-string v0, "Network Mode Change not supported in framework"

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    goto :goto_0

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

    :cond_4
    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    const/4 v1, 0x0

    const/16 v2, 0x44d

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->obtainMessage(I)Landroid/os/Message;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Lcom/android/internal/telephony/CommandsInterface;->setPreferredNetworkType(ILandroid/os/Message;)V

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

    const-string v2, "ril.card_operator"

    const-string v3, ""

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

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

    const-string v2, "SKT"

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    const-string v2, "TEST"

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    const-string v2, "This is not skt usim, do nothing"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    :cond_0
    :goto_0
    return-void

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

    const-string v2, "LTE_ROAMING_SKT"

    invoke-static {v5, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-boolean v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mNeedNetwrokModeChange:Z

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "preferred_network_mode"

    const/16 v4, 0x9

    invoke-static {v2, v3, v4}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1

    .local v1, "settingNetworkMode":I
    if-eqz p1, :cond_4

    const-string v2, "OEM_RAD_DIALER_POPUP"

    invoke-static {v5, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    const-string v2, "450"

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "oem_rad_dialer_popup"

    invoke-static {v2, v3, v7}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    const-string v2, "SettingsConstants.Secure.OEM_RAD_DIALER_POPUP set 1 by SKT scenario"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    :cond_2
    const-string v2, "network_mode_change_in_ril"

    invoke-static {v5, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    const-string v2, "Network Mode Change not supported in framework"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    goto :goto_0

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

    iput v6, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mDesiredNwMode:I

    invoke-direct {p0, v1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->setPreferredNetworkForRoaming(I)V

    goto/16 :goto_0

    :cond_4
    const-string v2, "network_mode_change_in_ril"

    invoke-static {v5, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_5

    const-string v2, "Network Mode Change not supported in framework"

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    goto/16 :goto_0

    :cond_5
    if-eq v1, v7, :cond_6

    const/4 v2, 0x2

    if-eq v1, v2, :cond_6

    const/16 v2, 0xb

    if-ne v1, v2, :cond_7

    :cond_6
    iput-boolean v6, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mNeedNetwrokModeChange:Z

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

    iput v6, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mDesiredNwMode:I

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

    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v5, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-nez v5, :cond_5

    iget-object v5, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v5, [I

    check-cast v5, [I

    array-length v5, v5

    if-le v5, v6, :cond_5

    iget-object v5, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v5, [I

    check-cast v5, [I

    aget v3, v5, v7

    .local v3, "mcc":I
    iget-object v5, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    check-cast v5, [I

    check-cast v5, [I

    aget v4, v5, v6

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

    invoke-static {v3}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v5

    iput-object v5, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

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

    :cond_1
    iget-object v5, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    invoke-direct {p0, v5}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->saveNetworkInfo(Ljava/lang/String;)Z

    move-result v2

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

    invoke-direct {p0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->calculatetIsroamingPersist()V

    if-eqz v2, :cond_2

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

    new-instance v1, Landroid/content/Intent;

    const-string v5, "com.lge.intent.action.LGE_CAMPED_MCC_CHANGE"

    invoke-direct {v1, v5}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .local v1, "intent":Landroid/content/Intent;
    const-string v5, "newmcc"

    iget-object v8, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-virtual {v1, v5, v8}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v5, "oldmcc"

    iget-object v8, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    invoke-virtual {v1, v5, v8}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v5, "KR"

    const-string v8, "LGU"

    invoke-static {v5, v8}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_7

    const-string v5, "999"

    iget-object v8, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    invoke-virtual {v5, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_6

    move v5, v6

    :goto_0
    iput-boolean v5, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mFakeMccChange:Z

    const-string v5, "FakeMccChange"

    iget-boolean v8, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mFakeMccChange:Z

    invoke-virtual {v1, v5, v8}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

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

    :goto_1
    iget-object v5, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    sget-object v8, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v5, v1, v8}, Landroid/content/Context;->sendStickyBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    .end local v1    # "intent":Landroid/content/Intent;
    :cond_2
    if-eqz v2, :cond_3

    const-string v5, "OEM_RAD_DIALER_POPUP"

    invoke-static {v9, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_3

    iget-object v5, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v5}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v5

    const-string v8, "oem_rad_dialer_popup"

    invoke-static {v5, v8, v7}, Landroid/provider/Settings$Secure;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    const-string v5, "SettingsConstants.Secure.OEM_RAD_DIALER_POPUP set 0 by SKT scenario"

    invoke-static {v5}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    :cond_3
    const-string v5, "LTE_ROAMING_SKT"

    invoke-static {v9, v5}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_4

    iput-boolean v6, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mNeedNetwrokModeChange:Z

    const-string v5, "Set true the mNeedNetwrokModeChange for next roaming"

    invoke-static {v5}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    :cond_4
    const-string v5, "KR"

    const-string v6, "LGU"

    invoke-static {v5, v6}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_8

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

    goto :goto_0

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

    .end local v1    # "intent":Landroid/content/Intent;
    :cond_8
    const-string v5, "KR"

    const-string v6, "SKT"

    invoke-static {v5, v6}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_5

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

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mUsimMcc:Ljava/lang/String;

    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_1

    const-string v3, "ril.card_operator"

    const-string v4, ""

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

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

    :cond_0
    const-string v3, "450"

    iput-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mUsimMcc:Ljava/lang/String;

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

    .end local v0    # "cardOperator":Ljava/lang/String;
    :cond_1
    :goto_0
    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_2

    const-string v3, "persist.radio.camped_mccmnc"

    const-string v4, ""

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .local v1, "propCampedMccMnc":Ljava/lang/String;
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_2

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v3

    const/4 v4, 0x5

    if-lt v3, v4, :cond_2

    const/4 v3, 0x3

    invoke-virtual {v1, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

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

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mUsimMcc:Ljava/lang/String;

    iget-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCampedMcc:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    const/4 v2, 0x1

    :cond_3
    return v2

    .restart local v0    # "cardOperator":Ljava/lang/String;
    :cond_4
    const-string v3, "TEST"

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    const-string v4, "saved_usim_mcc"

    invoke-virtual {v3, v4, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v3

    const-string v4, "usim_mcc"

    const-string v5, "450"

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mUsimMcc:Ljava/lang/String;

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
    sget-boolean v0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->DBG:Z

    if-eqz v0, :cond_0

    const-string v0, "KrRoamingEventDispatcher"

    invoke-static {v0, p0}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    return-void
.end method

.method private saveNetworkInfo(Ljava/lang/String;)Z
    .locals 6
    .param p1, "new_mcc"    # Ljava/lang/String;

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    const-string v4, "saved_CAMPED_MCC"

    invoke-virtual {v3, v4, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .local v0, "prefs":Landroid/content/SharedPreferences;
    const-string v3, "CAMPED_MCC"

    const-string v4, ""

    invoke-interface {v0, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

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

    const-string v3, "000"

    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    iput-object p1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_1

    iget-object v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    iget-object v4, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    const-string v4, "CAMPED_MCC"

    iget-object v5, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCurCampedMcc:Ljava/lang/String;

    invoke-interface {v3, v4, v5}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->commit()Z

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

    const-string v3, "KR"

    const-string v4, "LGU"

    invoke-static {v3, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    iget-boolean v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mFirstWcdmaNetChanged:Z

    if-eqz v3, :cond_0

    iput-boolean v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mFirstWcdmaNetChanged:Z

    const-string v2, "Generating real mcc change event..."

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    :cond_0
    :goto_0
    return v1

    :cond_1
    const-string v3, "KR"

    const-string v4, "LGU"

    invoke-static {v3, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    iget-boolean v3, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mFirstWcdmaNetChanged:Z

    if-eqz v3, :cond_2

    iput-boolean v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mFirstWcdmaNetChanged:Z

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

    const-string v2, "999"

    iput-object v2, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mOldCampedMcc:Ljava/lang/String;

    const-string v2, "Generating fake MCC change event..."

    invoke-static {v2}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    const-string v1, "mOldCampedMcc, mCurCampedMcc is not changed"

    invoke-static {v1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    move v1, v2

    goto :goto_0
.end method

.method private setPreferredNetworkForRoaming(I)V
    .locals 4
    .param p1, "mPrevNetworkMode"    # I

    .prologue
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

    const/4 v0, -0x1

    if-ne p1, v0, :cond_1

    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v1, 0x3ee

    invoke-virtual {p0, v1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/android/internal/telephony/CommandsInterface;->getPreferredNetworkType(Landroid/os/Message;)V

    :cond_0
    :goto_0
    return-void

    :cond_1
    iget v0, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mDesiredNwMode:I

    if-ne p1, v0, :cond_2

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

    const/4 v0, 0x0

    const-string v1, "LTE_ROAMING_SKT"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mNeedNetwrokModeChange:Z

    goto :goto_0

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

    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v1

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getSimOperator()Ljava/lang/String;

    move-result-object v0

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

    invoke-virtual {v0, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mUsimMcc:Ljava/lang/String;

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

    :cond_0
    return-void
.end method


# virtual methods
.method protected finalize()V
    .locals 2

    .prologue
    const-string v0, "KrRoamingEventDispatcher finalized"

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForWcdmaNetChanged(Landroid/os/Handler;)V

    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForWcdmaNetToKoreaChanged(Landroid/os/Handler;)V

    const/4 v0, 0x0

    const-string v1, "LTE_ROAMING_SKT"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mCm:Lcom/android/internal/telephony/CommandsInterface;

    invoke-interface {v0, p0}, Lcom/android/internal/telephony/CommandsInterface;->unregisterForRadioStateChanged(Landroid/os/Handler;)V

    :cond_0
    iget-object v0, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->mSimStateReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    return-void
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 2
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
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

    iget v0, p1, Landroid/os/Message;->what:I

    sparse-switch v0, :sswitch_data_0

    const-string v0, "KrRoamingEventDispatcher unexpected handleMessage case"

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    :goto_0
    return-void

    :sswitch_0
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->handleRadioStateChanged(Landroid/os/Message;)V

    goto :goto_0

    :sswitch_1
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->handleSetNetModeToWPrefDone(Landroid/os/Message;)V

    goto :goto_0

    :sswitch_2
    const/4 v0, 0x0

    const-string v1, "network_mode_change_in_ril"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "Network Mode Change not supported in framework"

    invoke-static {v0}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->log(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->handleNetworkModeQueryDone(Landroid/os/Message;)V

    goto :goto_0

    :sswitch_3
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->handleNetworkModetoGwGwl(Landroid/os/Message;)V

    goto :goto_0

    :sswitch_4
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->handleWcdmaNetChanged(Landroid/os/Message;)V

    goto :goto_0

    :sswitch_5
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/kr/KrRoamingEventDispatcher;->handleWcdmaNetChangedToKorea(Landroid/os/Message;)V

    goto :goto_0

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
