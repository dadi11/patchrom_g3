.class public Lcom/android/internal/telephony/cdma/CDMAPhoneEx;
.super Lcom/android/internal/telephony/cdma/CDMAPhone;
.source "CDMAPhoneEx.java"


# static fields
.field private static final BACKUPED_MDN:Ljava/lang/String; = "pref_key_msg_backuped_mdn"

.field protected static final DBG:Z = true

.field static final LOG_TAG:Ljava/lang/String; = "CDMAPhoneEx"

.field protected static final VDBG:Z


# instance fields
.field gfUtils:Lcom/android/internal/telephony/gfit/GfitUtils;

.field private mSimState:Ljava/lang/String;

.field private mSimStateReceiver:Landroid/content/BroadcastReceiver;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;Lcom/android/internal/telephony/PhoneNotifier;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "ci"    # Lcom/android/internal/telephony/CommandsInterface;
    .param p3, "notifier"    # Lcom/android/internal/telephony/PhoneNotifier;

    .prologue
    .line 76
    invoke-direct {p0, p1, p2, p3}, Lcom/android/internal/telephony/cdma/CDMAPhone;-><init>(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;Lcom/android/internal/telephony/PhoneNotifier;)V

    .line 527
    new-instance v0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx$1;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx$1;-><init>(Lcom/android/internal/telephony/cdma/CDMAPhoneEx;)V

    iput-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mSimStateReceiver:Landroid/content/BroadcastReceiver;

    .line 78
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->processRegistering(Landroid/content/Context;)V

    .line 80
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;Lcom/android/internal/telephony/PhoneNotifier;I)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "ci"    # Lcom/android/internal/telephony/CommandsInterface;
    .param p3, "notifier"    # Lcom/android/internal/telephony/PhoneNotifier;
    .param p4, "phoneId"    # I

    .prologue
    .line 84
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/android/internal/telephony/cdma/CDMAPhone;-><init>(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;Lcom/android/internal/telephony/PhoneNotifier;I)V

    .line 527
    new-instance v0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx$1;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx$1;-><init>(Lcom/android/internal/telephony/cdma/CDMAPhoneEx;)V

    iput-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mSimStateReceiver:Landroid/content/BroadcastReceiver;

    .line 86
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->processRegistering(Landroid/content/Context;)V

    .line 88
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;Lcom/android/internal/telephony/PhoneNotifier;Z)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "ci"    # Lcom/android/internal/telephony/CommandsInterface;
    .param p3, "notifier"    # Lcom/android/internal/telephony/PhoneNotifier;
    .param p4, "unitTestMode"    # Z

    .prologue
    .line 92
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/android/internal/telephony/cdma/CDMAPhone;-><init>(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;Lcom/android/internal/telephony/PhoneNotifier;Z)V

    .line 527
    new-instance v0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx$1;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx$1;-><init>(Lcom/android/internal/telephony/cdma/CDMAPhoneEx;)V

    iput-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mSimStateReceiver:Landroid/content/BroadcastReceiver;

    .line 94
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->processRegistering(Landroid/content/Context;)V

    .line 96
    return-void
.end method

.method static synthetic access$000(Lcom/android/internal/telephony/cdma/CDMAPhoneEx;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/cdma/CDMAPhoneEx;

    .prologue
    .line 57
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mSimState:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$002(Lcom/android/internal/telephony/cdma/CDMAPhoneEx;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/cdma/CDMAPhoneEx;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    .line 57
    iput-object p1, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mSimState:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$100(Lcom/android/internal/telephony/cdma/CDMAPhoneEx;)Landroid/content/Context;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/cdma/CDMAPhoneEx;

    .prologue
    .line 57
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method static synthetic access$200(Lcom/android/internal/telephony/cdma/CDMAPhoneEx;)Landroid/content/Context;
    .locals 1
    .param p0, "x0"    # Lcom/android/internal/telephony/cdma/CDMAPhoneEx;

    .prologue
    .line 57
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method private getBackupedPhoneNumber()Ljava/lang/String;
    .locals 4

    .prologue
    .line 561
    const/4 v0, 0x0

    .line 562
    .local v0, "number":Ljava/lang/String;
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 563
    .local v1, "sp":Landroid/content/SharedPreferences;
    const-string v2, "pref_key_msg_backuped_mdn"

    const/4 v3, 0x0

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 564
    return-object v0
.end method

.method private processRegistering(Landroid/content/Context;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v3, 0x0

    .line 141
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mSimStateReceiver:Landroid/content/BroadcastReceiver;

    new-instance v1, Landroid/content/IntentFilter;

    const-string v2, "android.intent.action.SIM_STATE_CHANGED"

    invoke-direct {v1, v2}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, v0, v1, v3, v3}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;Ljava/lang/String;Landroid/os/Handler;)Landroid/content/Intent;

    .line 144
    invoke-static {}, Landroid/telephony/TelephonyManager;->getDefault()Landroid/telephony/TelephonyManager;

    move-result-object v0

    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->isMultiSimEnabled()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 145
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mSimStateReceiver:Landroid/content/BroadcastReceiver;

    new-instance v1, Landroid/content/IntentFilter;

    const-string v2, "android.intent.action.ACTION_DEFAULT_SUBSCRIPTION_CHANGED"

    invoke-direct {v1, v2}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, v0, v1, v3, v3}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;Ljava/lang/String;Landroid/os/Handler;)Landroid/content/Intent;

    .line 149
    :cond_0
    const/4 v0, 0x2

    invoke-static {p1, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->init(Landroid/content/Context;I)V

    .line 154
    const/16 v0, 0x3a

    invoke-virtual {p0, p0, v0, v3}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->registerForSubscriptionInfoReady(Landroid/os/Handler;ILjava/lang/Object;)V

    .line 157
    return-void
.end method

.method private setBackupedPhoneNumber(Ljava/lang/String;)V
    .locals 3
    .param p1, "number"    # Ljava/lang/String;

    .prologue
    .line 569
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 570
    .local v1, "sp":Landroid/content/SharedPreferences;
    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 571
    .local v0, "editor":Landroid/content/SharedPreferences$Editor;
    const-string v2, "pref_key_msg_backuped_mdn"

    invoke-interface {v0, v2, p1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 572
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 573
    return-void
.end method


# virtual methods
.method protected CheckCarrierEri(Landroid/content/Context;)Z
    .locals 3
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v2, 0x1

    .line 126
    const/4 v0, 0x0

    const-string v1, "vzw_eri"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 127
    new-instance v0, Lcom/android/internal/telephony/cdma/EriManagerEx;

    invoke-direct {v0, p0, p1, v2}, Lcom/android/internal/telephony/cdma/EriManagerEx;-><init>(Lcom/android/internal/telephony/PhoneBase;Landroid/content/Context;I)V

    iput-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mEriManager:Lcom/android/internal/telephony/cdma/EriManager;

    .line 132
    :goto_0
    return v2

    .line 130
    :cond_0
    new-instance v0, Lcom/android/internal/telephony/cdma/EriManagerEx;

    const/4 v1, 0x0

    invoke-direct {v0, p0, p1, v1}, Lcom/android/internal/telephony/cdma/EriManagerEx;-><init>(Lcom/android/internal/telephony/PhoneBase;Landroid/content/Context;I)V

    iput-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mEriManager:Lcom/android/internal/telephony/cdma/EriManager;

    goto :goto_0
.end method

.method public PlayVZWERISound()V
    .locals 2

    .prologue
    .line 462
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mSST:Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;

    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->getAlertId()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;->PlayVZWERISoundforMTCall(I)V

    .line 463
    return-void
.end method

.method public StopVZWERISound()V
    .locals 1

    .prologue
    .line 467
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mSST:Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;

    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;->StopVZWERISound()V

    .line 468
    return-void
.end method

.method public dispose()V
    .locals 2

    .prologue
    .line 180
    invoke-super {p0}, Lcom/android/internal/telephony/cdma/CDMAPhone;->dispose()V

    .line 182
    const/4 v0, 0x0

    const-string v1, "vzw_gfit"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 183
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->gfUtils:Lcom/android/internal/telephony/gfit/GfitUtils;

    invoke-virtual {v0}, Lcom/android/internal/telephony/gfit/GfitUtils;->dispose()V

    .line 188
    :cond_0
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mContext:Landroid/content/Context;

    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mSimStateReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 191
    return-void
.end method

.method public exitEmergencyCallbackMode()V
    .locals 3

    .prologue
    .line 330
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->getState()Lcom/android/internal/telephony/PhoneConstants$State;

    move-result-object v1

    sget-object v2, Lcom/android/internal/telephony/PhoneConstants$State;->IDLE:Lcom/android/internal/telephony/PhoneConstants$State;

    if-eq v1, v2, :cond_0

    .line 331
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mIsPhoneInEcmExitDelayState:Z

    .line 349
    :goto_0
    return-void

    .line 337
    :cond_0
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->getContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "SUPPORT_E911_FOR_VOLTE"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 338
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->getIsE911ForVolte()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 340
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.lge.intent.action.ACTION_ECBM_EXIT_FOR_VOLTE"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 341
    .local v0, "intent":Landroid/content/Intent;
    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mContext:Landroid/content/Context;

    sget-object v2, Landroid/os/UserHandle;->ALL:Landroid/os/UserHandle;

    invoke-virtual {v1, v0, v2}, Landroid/content/Context;->sendBroadcastAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V

    .line 342
    const-string v1, "CDMAPhoneEx"

    const-string v2, "exitEmergencyCallbackMode - ACTION_ECBM_EXIT_FOR_VOLTE"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 348
    .end local v0    # "intent":Landroid/content/Intent;
    :cond_1
    invoke-super {p0}, Lcom/android/internal/telephony/cdma/CDMAPhone;->exitEmergencyCallbackMode()V

    goto :goto_0
.end method

.method public getAlertId()I
    .locals 3

    .prologue
    .line 493
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->getServiceState()Landroid/telephony/ServiceState;

    move-result-object v2

    invoke-virtual {v2}, Landroid/telephony/ServiceState;->getCdmaRoamingIndicator()I

    move-result v1

    .line 494
    .local v1, "roamInd":I
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->getServiceState()Landroid/telephony/ServiceState;

    move-result-object v2

    invoke-virtual {v2}, Landroid/telephony/ServiceState;->getCdmaDefaultRoamingIndicator()I

    move-result v0

    .line 495
    .local v0, "defRoamInd":I
    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mEriManager:Lcom/android/internal/telephony/cdma/EriManager;

    invoke-virtual {v2, v1, v0}, Lcom/android/internal/telephony/cdma/EriManager;->getAlertId(II)I

    move-result v2

    return v2
.end method

.method public getCdmaEriHomeSystems()Ljava/lang/String;
    .locals 1

    .prologue
    .line 488
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mEriManager:Lcom/android/internal/telephony/cdma/EriManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/EriManager;->getCdmaEriHomeSystems()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getCdmaLteEhrpdForced()Ljava/lang/String;
    .locals 1

    .prologue
    .line 579
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mSST:Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;

    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;->getLteEhrpdForced()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getDeviceId()Ljava/lang/String;
    .locals 3

    .prologue
    .line 271
    const-string v1, "VZW"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "LRA"

    invoke-static {v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 272
    :cond_0
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->getImei()Ljava/lang/String;

    move-result-object v0

    .line 273
    .local v0, "mDeviceId":Ljava/lang/String;
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    const/16 v2, 0xf

    if-ne v1, v2, :cond_2

    const-string v1, "^0*$"

    invoke-virtual {v0, v1}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    .line 274
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->getContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "support_vzw_Los_upgrade"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 275
    const-string v1, "CDMAPhoneEx"

    const-string v2, "getDeviceId(): returns IMEI(14) in CDMA-LTE Phone"

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 276
    const/4 v1, 0x0

    const/16 v2, 0xe

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 283
    .end local v0    # "mDeviceId":Ljava/lang/String;
    :cond_1
    :goto_0
    return-object v0

    :cond_2
    invoke-super {p0}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getDeviceId()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public getDeviceSvn()Ljava/lang/String;
    .locals 2

    .prologue
    .line 290
    const-string v0, "US"

    const-string v1, "SPR"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 291
    const-string v0, "ro.lge.swversion"

    const-string v1, "0"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 294
    :goto_0
    return-object v0

    :cond_0
    invoke-super {p0}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getDeviceSvn()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public getEriFileVersion()I
    .locals 1

    .prologue
    .line 515
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mEriManager:Lcom/android/internal/telephony/cdma/EriManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/EriManager;->getEriFileVersion()I

    move-result v0

    return v0
.end method

.method public getEriManager()Lcom/android/internal/telephony/cdma/EriManager;
    .locals 1

    .prologue
    .line 519
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mEriManager:Lcom/android/internal/telephony/cdma/EriManager;

    if-eqz v0, :cond_0

    .line 520
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mEriManager:Lcom/android/internal/telephony/cdma/EriManager;

    .line 522
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getHDRRoamingIndicator()I
    .locals 1

    .prologue
    .line 585
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mSST:Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;

    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;->getHDRRoamingIndicator()I

    move-result v0

    return v0
.end method

.method public getLine1Number()Ljava/lang/String;
    .locals 4

    .prologue
    .line 224
    const-string v3, "VZW"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 225
    const/4 v0, 0x0

    .line 227
    .local v0, "mdnNumber":Ljava/lang/String;
    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mSST:Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;

    invoke-virtual {v3}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;->getMdnNumber()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/lge/telephony/LGSpecialNumberUtils;->getValidMdnForVZW(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 245
    .end local v0    # "mdnNumber":Ljava/lang/String;
    :goto_0
    return-object v0

    .line 234
    :cond_0
    const-string v3, "CTC"

    invoke-static {v3}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 235
    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mIccRecords:Ljava/util/concurrent/atomic/AtomicReference;

    invoke-virtual {v3}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/android/internal/telephony/uicc/IccRecords;

    .line 236
    .local v2, "r":Lcom/android/internal/telephony/uicc/IccRecords;
    if-eqz v2, :cond_2

    .line 237
    invoke-virtual {v2}, Lcom/android/internal/telephony/uicc/IccRecords;->getOperatorNumeric()Ljava/lang/String;

    move-result-object v1

    .line 238
    .local v1, "operatorNumeric":Ljava/lang/String;
    const-string v3, "46011"

    invoke-virtual {v3, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1

    const-string v3, "46003"

    invoke-virtual {v3, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1

    const-string v3, "20404"

    invoke-virtual {v3, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 239
    :cond_1
    const/4 v0, 0x0

    goto :goto_0

    .line 245
    .end local v1    # "operatorNumeric":Ljava/lang/String;
    .end local v2    # "r":Lcom/android/internal/telephony/uicc/IccRecords;
    :cond_2
    invoke-super {p0}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getLine1Number()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public getServiceState()Landroid/telephony/ServiceState;
    .locals 1

    .prologue
    .line 196
    const-string v0, "CTC"

    invoke-static {v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperator(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 197
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mSST:Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;

    if-eqz v0, :cond_0

    .line 198
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mSST:Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;

    iget-object v0, v0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;->mSS:Landroid/telephony/ServiceState;

    .line 204
    :goto_0
    return-object v0

    .line 200
    :cond_0
    new-instance v0, Landroid/telephony/ServiceState;

    invoke-direct {v0}, Landroid/telephony/ServiceState;-><init>()V

    goto :goto_0

    .line 204
    :cond_1
    invoke-super {p0}, Lcom/android/internal/telephony/cdma/CDMAPhone;->getServiceState()Landroid/telephony/ServiceState;

    move-result-object v0

    goto :goto_0
.end method

.method public getVoiceMailNumber()Ljava/lang/String;
    .locals 5

    .prologue
    .line 299
    const/4 v0, 0x0

    .line 300
    .local v0, "number":Ljava/lang/String;
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 313
    .local v1, "sp":Landroid/content/SharedPreferences;
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->getPhoneId()I

    move-result v2

    .line 315
    .local v2, "subId":I
    const/4 v3, 0x0

    const-string v4, "show_Mdn_For_VMS"

    invoke-static {v3, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 316
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "vm_number_key_cdma"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->getPhoneId()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->getLine1Number()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v1, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 324
    :cond_0
    :goto_0
    return-object v0

    .line 318
    :cond_1
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getVMS(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v0

    .line 319
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 320
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "vm_number_key_cdma"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->getPhoneId()I

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const-string v4, "*86"

    invoke-interface {v1, v3, v4}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method protected handleEnterEmergencyCallbackMode(J)V
    .locals 3
    .param p1, "delayInMillis"    # J

    .prologue
    .line 473
    iget-boolean v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mIsPhoneInEcmState:Z

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 474
    const-string v0, "CDMAPhoneEx"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "handleEnterEmergencyCallbackMode, delayInMillis= "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 476
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mExitEcmRunnable:Ljava/lang/Runnable;

    invoke-virtual {p0, v0, p1, p2}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 477
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mWakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v0}, Landroid/os/PowerManager$WakeLock;->acquire()V

    .line 479
    :cond_0
    return-void
.end method

.method public handleMessage(Landroid/os/Message;)V
    .locals 10
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const/4 v9, 0x0

    .line 385
    iget-boolean v6, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mIsTheCurrentActivePhone:Z

    if-nez v6, :cond_1

    .line 386
    const-string v6, "CDMAPhoneEx"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Received message "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "["

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget v8, p1, Landroid/os/Message;->what:I

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "] while being destroyed. Ignoring."

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 458
    :cond_0
    :goto_0
    return-void

    .line 390
    :cond_1
    iget v6, p1, Landroid/os/Message;->what:I

    sparse-switch v6, :sswitch_data_0

    .line 455
    invoke-super {p0, p1}, Lcom/android/internal/telephony/cdma/CDMAPhone;->handleMessage(Landroid/os/Message;)V

    goto :goto_0

    .line 393
    :sswitch_0
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->getContext()Landroid/content/Context;

    move-result-object v6

    invoke-static {v6}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v4

    .line 394
    .local v4, "sharedPreferences":Landroid/content/SharedPreferences;
    invoke-direct {p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->getBackupedPhoneNumber()Ljava/lang/String;

    move-result-object v1

    .line 395
    .local v1, "backupedMdn":Ljava/lang/String;
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->getLine1Number()Ljava/lang/String;

    move-result-object v2

    .line 396
    .local v2, "currentMdn":Ljava/lang/String;
    const-string v6, "vm_number_key_cdma"

    invoke-interface {v4, v6, v9}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 398
    .local v5, "vmNumber":Ljava/lang/String;
    const-string v6, "ro.build.type"

    invoke-static {v6, v9}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    const-string v7, "userdebug"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_2

    .line 399
    const-string v6, "CDMAPhoneEx"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[BEGIN] currentMdn = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ", backupedMdn = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ", vmNumber = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 402
    :cond_2
    if-eqz v2, :cond_4

    .line 403
    if-nez v1, :cond_5

    .line 405
    const-string v6, "change_mdn_sync_vms"

    invoke-static {v9, v6}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_3

    .line 406
    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->storeVoiceMailNumber(Ljava/lang/String;)V

    .line 421
    :cond_3
    :goto_1
    invoke-direct {p0, v2}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->setBackupedPhoneNumber(Ljava/lang/String;)V

    .line 424
    :cond_4
    invoke-direct {p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->getBackupedPhoneNumber()Ljava/lang/String;

    move-result-object v1

    .line 425
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->getLine1Number()Ljava/lang/String;

    move-result-object v2

    .line 426
    const-string v6, "vm_number_key_cdma"

    invoke-interface {v4, v6, v9}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 428
    const-string v6, "ro.build.type"

    invoke-static {v6, v9}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    const-string v7, "userdebug"

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_0

    .line 429
    const-string v6, "CDMAPhoneEx"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "[END] currentMdn = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ", backupedMdn = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ", vmNumber = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 410
    :cond_5
    invoke-virtual {v2, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-nez v6, :cond_3

    .line 412
    const-string v6, "change_mdn_sync_vms"

    invoke-static {v9, v6}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_6

    .line 413
    invoke-interface {v4}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v6

    const-string v7, "vm_number_key_cdma"

    invoke-interface {v6, v7, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v6

    invoke-interface {v6}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 414
    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->storeVoiceMailNumber(Ljava/lang/String;)V

    .line 417
    :cond_6
    new-instance v3, Landroid/content/Intent;

    const-string v6, "android.intent.action.CHANGE_CALLBACK_NUM_TO_MDN"

    invoke-direct {v3, v6}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 418
    .local v3, "intent":Landroid/content/Intent;
    iget-object v6, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mContext:Landroid/content/Context;

    invoke-virtual {v6, v3}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    goto :goto_1

    .line 435
    .end local v1    # "backupedMdn":Ljava/lang/String;
    .end local v2    # "currentMdn":Ljava/lang/String;
    .end local v3    # "intent":Landroid/content/Intent;
    .end local v4    # "sharedPreferences":Landroid/content/SharedPreferences;
    .end local v5    # "vmNumber":Ljava/lang/String;
    :sswitch_1
    iget-object v0, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v0, Landroid/os/AsyncResult;

    .line 436
    .local v0, "ar":Landroid/os/AsyncResult;
    iget-object v6, v0, Landroid/os/AsyncResult;->exception:Ljava/lang/Throwable;

    if-eqz v6, :cond_7

    .line 437
    const-string v6, "CDMAPhoneEx"

    const-string v7, "EVENT_SET_ERI_VERSION : FAIL"

    invoke-static {v6, v7}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 439
    :cond_7
    const-string v6, "CDMAPhoneEx"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "EVENT_SET_ERI_VERSION: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-object v8, v0, Landroid/os/AsyncResult;->result:Ljava/lang/Object;

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_0

    .line 447
    .end local v0    # "ar":Landroid/os/AsyncResult;
    :sswitch_2
    const-string v6, "CDMAPhoneEx"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "EVENT_RETRY_GET_DEVICE_IDENTITY : retryNum = "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget v8, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->retryNum:I

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 448
    iget v6, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->retryNum:I

    add-int/lit8 v6, v6, 0x1

    iput v6, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->retryNum:I

    .line 449
    iget-object v6, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    const/16 v7, 0x15

    invoke-virtual {p0, v7}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->obtainMessage(I)Landroid/os/Message;

    move-result-object v7

    invoke-interface {v6, v7}, Lcom/android/internal/telephony/CommandsInterface;->getDeviceIdentity(Landroid/os/Message;)V

    goto/16 :goto_0

    .line 390
    :sswitch_data_0
    .sparse-switch
        0x3a -> :sswitch_0
        0x416 -> :sswitch_1
        0x420 -> :sswitch_2
    .end sparse-switch
.end method

.method protected init(Landroid/content/Context;Lcom/android/internal/telephony/PhoneNotifier;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "notifier"    # Lcom/android/internal/telephony/PhoneNotifier;

    .prologue
    .line 110
    invoke-super {p0, p1, p2}, Lcom/android/internal/telephony/cdma/CDMAPhone;->init(Landroid/content/Context;Lcom/android/internal/telephony/PhoneNotifier;)V

    .line 113
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mIsPhoneInEcmExitDelayState:Z

    .line 117
    const-string v0, "vzw_gfit"

    invoke-static {p1, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 118
    new-instance v0, Lcom/android/internal/telephony/gfit/GfitUtils;

    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mSST:Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;

    invoke-direct {v0, v1, p0}, Lcom/android/internal/telephony/gfit/GfitUtils;-><init>(Lcom/android/internal/telephony/ServiceStateTracker;Lcom/android/internal/telephony/PhoneBaseEx;)V

    iput-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->gfUtils:Lcom/android/internal/telephony/gfit/GfitUtils;

    .line 121
    :cond_0
    return-void
.end method

.method protected initInstance()V
    .locals 1

    .prologue
    .line 100
    new-instance v0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;-><init>(Lcom/android/internal/telephony/cdma/CDMAPhone;)V

    iput-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mCT:Lcom/android/internal/telephony/cdma/CdmaCallTracker;

    .line 101
    return-void
.end method

.method protected initSstIcc()V
    .locals 1

    .prologue
    .line 105
    new-instance v0, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTrackerEx;-><init>(Lcom/android/internal/telephony/cdma/CDMAPhone;)V

    iput-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mSST:Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;

    .line 106
    return-void
.end method

.method public isSystemInPrl()Z
    .locals 1

    .prologue
    .line 251
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mSST:Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;

    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;->isSystemInPrl()Z

    move-result v0

    return v0
.end method

.method public isUiccInserted()Z
    .locals 4

    .prologue
    .line 256
    const/4 v0, 0x1

    .line 257
    .local v0, "mIsUiccInserted":Z
    const-string v1, "CDMAPhoneEx"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "isUiccInserted(), mSimState = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mSimState:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 258
    const-string v1, "ABSENT"

    iget-object v2, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mSimState:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 259
    const/4 v0, 0x0

    .line 263
    :goto_0
    const-string v1, "CDMAPhoneEx"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "isUiccInserted(), mIsUiccInserted = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 264
    return v0

    .line 261
    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public removeReferences()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 212
    invoke-super {p0}, Lcom/android/internal/telephony/cdma/CDMAPhone;->removeReferences()V

    .line 215
    const-string v0, "vzw_gfit"

    invoke-static {v1, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 216
    iput-object v1, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->gfUtils:Lcom/android/internal/telephony/gfit/GfitUtils;

    .line 219
    :cond_0
    return-void
.end method

.method public resetVoiceMessageCount()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    .line 358
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->getSubscriberId()Ljava/lang/String;

    move-result-object v1

    .line 360
    .local v1, "imsi":Ljava/lang/String;
    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->setVoiceMessageCount(I)V

    .line 362
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Reset Voice Mail Count = 0 for imsi = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " for mVmCountKey = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "vm_count_key"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " vmId = "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "vm_id_key"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " in preferences."

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->log(Ljava/lang/String;)V

    .line 368
    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mContext:Landroid/content/Context;

    invoke-static {v3}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v2

    .line 369
    .local v2, "sp":Landroid/content/SharedPreferences;
    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 370
    .local v0, "editor":Landroid/content/SharedPreferences$Editor;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "vm_count_key"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v0, v3, v5}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 372
    iget-object v3, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mContext:Landroid/content/Context;

    const-string v4, "cdma_urgent_vmwi"

    invoke-static {v3, v4}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 373
    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->setVoiceMessageUrgent(Z)V

    .line 374
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "vm_priority_key"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v0, v3, v5}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    .line 377
    :cond_0
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 378
    return-void
.end method

.method public setCdmaEriVersion()V
    .locals 3

    .prologue
    .line 502
    const/4 v0, 0x0

    const-string v1, "vzw_eri"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 503
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mEriManager:Lcom/android/internal/telephony/cdma/EriManager;

    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/EriManager;->isEriFileLoaded()Z

    move-result v0

    if-nez v0, :cond_0

    .line 504
    const-string v0, "CDMAPhoneEx"

    const-string v1, "Eri file load start!!"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 505
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->prepareEri()V

    .line 507
    :cond_0
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mCi:Lcom/android/internal/telephony/CommandsInterface;

    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->mEriManager:Lcom/android/internal/telephony/cdma/EriManager;

    invoke-virtual {v1}, Lcom/android/internal/telephony/cdma/EriManager;->getEriFileVersion()I

    move-result v1

    const/16 v2, 0x416

    invoke-virtual {p0, v2}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->obtainMessage(I)Landroid/os/Message;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Lcom/android/internal/telephony/CommandsInterface;->setCdmaEriVersion(ILandroid/os/Message;)V

    .line 509
    :cond_1
    return-void
.end method

.method protected setOperatorAlpha(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "alphaStr"    # Ljava/lang/String;

    .prologue
    .line 163
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 164
    const-string v1, "ro_cdma_operator_alpha"

    invoke-static {p1, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->getFeatureInfo(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 166
    .local v0, "newOperatorAlpha":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 167
    move-object p2, v0

    .line 168
    const-string v1, "ro.cdma.home.operator.alpha"

    invoke-virtual {p0, v1, p2}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->setSystemProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 175
    .end local v0    # "newOperatorAlpha":Ljava/lang/String;
    :cond_0
    :goto_0
    return-object p2

    .line 169
    .restart local v0    # "newOperatorAlpha":Ljava/lang/String;
    :cond_1
    const-string v1, "US"

    const-string v2, "USC"

    invoke-static {v1, v2}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 170
    const-string p2, "U.S. Cellular"

    .line 171
    const-string v1, "ro.cdma.home.operator.alpha"

    invoke-virtual {p0, v1, p2}, Lcom/android/internal/telephony/cdma/CDMAPhoneEx;->setSystemProperty(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method
