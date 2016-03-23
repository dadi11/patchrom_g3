.class public Lcom/android/internal/telephony/cdma/CDMALTEPhoneEx;
.super Lcom/android/internal/telephony/cdma/CDMALTEPhone;
.source "CDMALTEPhoneEx.java"


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;Lcom/android/internal/telephony/PhoneNotifier;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "ci"    # Lcom/android/internal/telephony/CommandsInterface;
    .param p3, "notifier"    # Lcom/android/internal/telephony/PhoneNotifier;

    .prologue
    .line 40
    invoke-direct {p0, p1, p2, p3}, Lcom/android/internal/telephony/cdma/CDMALTEPhone;-><init>(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;Lcom/android/internal/telephony/PhoneNotifier;)V

    .line 41
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;Lcom/android/internal/telephony/PhoneNotifier;I)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "ci"    # Lcom/android/internal/telephony/CommandsInterface;
    .param p3, "notifier"    # Lcom/android/internal/telephony/PhoneNotifier;
    .param p4, "phoneId"    # I

    .prologue
    .line 45
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/android/internal/telephony/cdma/CDMALTEPhone;-><init>(Landroid/content/Context;Lcom/android/internal/telephony/CommandsInterface;Lcom/android/internal/telephony/PhoneNotifier;I)V

    .line 46
    return-void
.end method


# virtual methods
.method public getDeviceSvn()Ljava/lang/String;
    .locals 2

    .prologue
    .line 91
    const-string v0, "US"

    const-string v1, "SPR"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 92
    const-string v0, "ro.lge.swversion"

    const-string v1, "0"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 95
    :goto_0
    return-object v0

    :cond_0
    invoke-super {p0}, Lcom/android/internal/telephony/cdma/CDMALTEPhone;->getDeviceSvn()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method public getSubscriberId()Ljava/lang/String;
    .locals 2

    .prologue
    .line 80
    const-string v0, "US"

    const-string v1, "SPR"

    invoke-static {v0, v1}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isOperatorCountry(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 81
    iget-object v0, p0, Lcom/android/internal/telephony/cdma/CDMALTEPhoneEx;->mSST:Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;

    invoke-virtual {v0}, Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;->getImsi()Ljava/lang/String;

    move-result-object v0

    .line 84
    :goto_0
    return-object v0

    :cond_0
    invoke-super {p0}, Lcom/android/internal/telephony/cdma/CDMALTEPhone;->getSubscriberId()Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method

.method protected init(Landroid/content/Context;Lcom/android/internal/telephony/PhoneNotifier;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "notifier"    # Lcom/android/internal/telephony/PhoneNotifier;

    .prologue
    .line 62
    invoke-super {p0, p1, p2}, Lcom/android/internal/telephony/cdma/CDMALTEPhone;->init(Landroid/content/Context;Lcom/android/internal/telephony/PhoneNotifier;)V

    .line 65
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/internal/telephony/cdma/CDMALTEPhoneEx;->mIsPhoneInEcmExitDelayState:Z

    .line 69
    const-string v0, "vzw_gfit"

    invoke-static {p1, v0}, Lcom/android/internal/telephony/lgeautoprofiling/LgeAutoProfiling;->isSupportedFeature(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 70
    new-instance v0, Lcom/android/internal/telephony/gfit/GfitUtils;

    iget-object v1, p0, Lcom/android/internal/telephony/cdma/CDMALTEPhoneEx;->mSST:Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;

    invoke-direct {v0, v1, p0}, Lcom/android/internal/telephony/gfit/GfitUtils;-><init>(Lcom/android/internal/telephony/ServiceStateTracker;Lcom/android/internal/telephony/PhoneBaseEx;)V

    iput-object v0, p0, Lcom/android/internal/telephony/cdma/CDMALTEPhoneEx;->gfUtils:Lcom/android/internal/telephony/gfit/GfitUtils;

    .line 73
    :cond_0
    return-void
.end method

.method protected initInstance()V
    .locals 2

    .prologue
    .line 50
    new-instance v0, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/cdma/CdmaCallTrackerEx;-><init>(Lcom/android/internal/telephony/cdma/CDMAPhone;)V

    iput-object v0, p0, Lcom/android/internal/telephony/cdma/CDMALTEPhoneEx;->mCT:Lcom/android/internal/telephony/cdma/CdmaCallTracker;

    .line 51
    const-string v0, "CDMAPhoneEx"

    const-string v1, "CDMALTEPhoneEx: constructor: initInstance()"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 52
    return-void
.end method

.method protected initSstIcc()V
    .locals 2

    .prologue
    .line 56
    new-instance v0, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;

    invoke-direct {v0, p0}, Lcom/android/internal/telephony/cdma/CdmaLteServiceStateTrackerEx;-><init>(Lcom/android/internal/telephony/cdma/CDMALTEPhone;)V

    iput-object v0, p0, Lcom/android/internal/telephony/cdma/CDMALTEPhoneEx;->mSST:Lcom/android/internal/telephony/cdma/CdmaServiceStateTracker;

    .line 57
    const-string v0, "CDMAPhoneEx"

    const-string v1, "CDMALTEPhoneEx: constructor : initSstIcc()"

    invoke-static {v0, v1}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 58
    return-void
.end method

.method public updateCurrentCarrierInProvider_CT(Ljava/lang/String;)Z
    .locals 5
    .param p1, "operatorNumeric"    # Ljava/lang/String;

    .prologue
    .line 100
    const-string v3, "CDMALTEPhone: updateCurrentCarrierInProvider_CT called"

    invoke-virtual {p0, v3}, Lcom/android/internal/telephony/cdma/CDMALTEPhoneEx;->log(Ljava/lang/String;)V

    .line 101
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_0

    .line 103
    :try_start_0
    sget-object v3, Landroid/provider/Telephony$Carriers;->CONTENT_URI:Landroid/net/Uri;

    const-string v4, "current"

    invoke-static {v3, v4}, Landroid/net/Uri;->withAppendedPath(Landroid/net/Uri;Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    .line 104
    .local v2, "uri":Landroid/net/Uri;
    new-instance v1, Landroid/content/ContentValues;

    invoke-direct {v1}, Landroid/content/ContentValues;-><init>()V

    .line 105
    .local v1, "map":Landroid/content/ContentValues;
    const-string v3, "numeric"

    invoke-virtual {v1, v3, p1}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 106
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "updateCurrentCarrierInProvider from system: numeric="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/android/internal/telephony/cdma/CDMALTEPhoneEx;->log(Ljava/lang/String;)V

    .line 107
    invoke-virtual {p0}, Lcom/android/internal/telephony/cdma/CDMALTEPhoneEx;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    invoke-virtual {v3, v2, v1}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;
    :try_end_0
    .catch Landroid/database/SQLException; {:try_start_0 .. :try_end_0} :catch_0

    .line 109
    const/4 v3, 0x1

    .line 114
    .end local v1    # "map":Landroid/content/ContentValues;
    .end local v2    # "uri":Landroid/net/Uri;
    :goto_0
    return v3

    .line 110
    :catch_0
    move-exception v0

    .line 111
    .local v0, "e":Landroid/database/SQLException;
    const-string v3, "CDMAPhoneEx"

    const-string v4, "Can\'t store current operator"

    invoke-static {v3, v4, v0}, Landroid/telephony/Rlog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 114
    .end local v0    # "e":Landroid/database/SQLException;
    :cond_0
    const/4 v3, 0x0

    goto :goto_0
.end method