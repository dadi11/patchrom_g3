.class public Lcom/lge/nfcconfig/NfcConfigure;
.super Ljava/lang/Object;
.source "NfcConfigure.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/lge/nfcconfig/NfcConfigure$HCEScenarioList;,
        Lcom/lge/nfcconfig/NfcConfigure$HCEScreenStateList;,
        Lcom/lge/nfcconfig/NfcConfigure$TransactionEventScenarioList;,
        Lcom/lge/nfcconfig/NfcConfigure$HceScenarioList;,
        Lcom/lge/nfcconfig/NfcConfigure$PowerSaveScenarioList;,
        Lcom/lge/nfcconfig/NfcConfigure$PopupScenarioList;,
        Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;,
        Lcom/lge/nfcconfig/NfcConfigure$WirelessChargingList;,
        Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;,
        Lcom/lge/nfcconfig/NfcConfigure$HandoverScenarioList;,
        Lcom/lge/nfcconfig/NfcConfigure$SoundScenarioList;,
        Lcom/lge/nfcconfig/NfcConfigure$SecureElementList;,
        Lcom/lge/nfcconfig/NfcConfigure$IndicatorList;
    }
.end annotation


# static fields
.field private static DBG:Z = false

.field private static INSTANCE:Lcom/lge/nfcconfig/NfcConfigure; = null

.field public static final NFC_HANDOVER_AUTOAPPLAUNCH:Ljava/lang/String; = "HandoverAutoAppLaunch"

.field public static final NFC_HANDOVER_TYPE:Ljava/lang/String; = "HandoverSupportType"

.field public static final NFC_POPUPDIALOG_TYPE:Ljava/lang/String; = "PopupDialogType"

.field public static final NFC_SECUREELEMENT_TYPE:Ljava/lang/String; = "SecureElementType"

.field public static final NFC_VENDOR_TYPE:Ljava/lang/String; = "VendorType"

.field private static final TAG:Ljava/lang/String; = "NfcConfigure"


# instance fields
.field public mAccessControlEnable:Z

.field public mAdvancedHCEEnable:Z

.field public mAidFilterEnable:Z

.field public mCardEnableInPowerOff:Z

.field private mContext:Landroid/content/Context;

.field public mCoverScenarioEnable:Z

.field public mDefaultOnOffType:Ljava/lang/String;

.field public mDisableInPowerOffEnable:Z

.field public mEmptyPopupSupport:Z

.field public mHCEOnHostEnable:Z

.field public mHandoverAutoAppLaunch:Z

.field public mHandoverSupportType:Lcom/lge/nfcconfig/NfcConfigure$HandoverScenarioList;

.field public mHceScenario:Lcom/lge/nfcconfig/NfcConfigure$HceScenarioList;

.field public mHostCardEmulationScenario:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Lcom/lge/nfcconfig/NfcConfigure$HCEScreenStateList;",
            "Lcom/lge/nfcconfig/NfcConfigure$HCEScenarioList;",
            ">;"
        }
    .end annotation
.end field

.field public mIndicatorType:Lcom/lge/nfcconfig/NfcConfigure$IndicatorList;

.field public mLockScreenPollingEnable:Z

.field public mMCC:Ljava/lang/String;

.field public mMTKBluetoothEnable:Z

.field public mMccMncSupport:Z

.field public mNfcEERoutingEnable:Z

.field public mNotifyonlyValidTag:Z

.field public mPermittedSeBroadcastEnable:Z

.field public mPopupDialogType:Lcom/lge/nfcconfig/NfcConfigure$PopupScenarioList;

.field public mPowerSaveType:Lcom/lge/nfcconfig/NfcConfigure$PowerSaveScenarioList;

.field public mRingSoundScenarioType:Lcom/lge/nfcconfig/NfcConfigure$SoundScenarioList;

.field public mSePatchEnabled:Z

.field public mSecureElementType:Lcom/lge/nfcconfig/NfcConfigure$SecureElementList;

.field public mTagLongTimePopupSupport:Z

.field public mTargetCountry:Ljava/lang/String;

.field public mTargetDevice:Ljava/lang/String;

.field private mTargetFlag:Ljava/lang/String;

.field public mTargetOperator:Ljava/lang/String;

.field public mTransactionEventScenario:Lcom/lge/nfcconfig/NfcConfigure$TransactionEventScenarioList;

.field public mVendorStablePatch:Z

.field public mVendorType:Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;

.field public mWCScenarioEnable:Z

.field public mWPSHandoverEnable:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x1

    sput-boolean v0, Lcom/lge/nfcconfig/NfcConfigure;->DBG:Z

    return-void
.end method

.method private constructor <init>(Landroid/content/Context;)V
    .locals 10
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    const/4 v7, 0x1

    const/4 v6, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-object v8, Lcom/lge/nfcconfig/NfcConfigure$IndicatorList;->two_toggleN:Lcom/lge/nfcconfig/NfcConfigure$IndicatorList;

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mIndicatorType:Lcom/lge/nfcconfig/NfcConfigure$IndicatorList;

    sget-object v8, Lcom/lge/nfcconfig/NfcConfigure$SecureElementList;->uicc:Lcom/lge/nfcconfig/NfcConfigure$SecureElementList;

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mSecureElementType:Lcom/lge/nfcconfig/NfcConfigure$SecureElementList;

    sget-object v8, Lcom/lge/nfcconfig/NfcConfigure$SoundScenarioList;->INITVALUE:Lcom/lge/nfcconfig/NfcConfigure$SoundScenarioList;

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mRingSoundScenarioType:Lcom/lge/nfcconfig/NfcConfigure$SoundScenarioList;

    sget-object v8, Lcom/lge/nfcconfig/NfcConfigure$HandoverScenarioList;->googlenative:Lcom/lge/nfcconfig/NfcConfigure$HandoverScenarioList;

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mHandoverSupportType:Lcom/lge/nfcconfig/NfcConfigure$HandoverScenarioList;

    sget-object v8, Lcom/lge/nfcconfig/NfcConfigure$PopupScenarioList;->gsma:Lcom/lge/nfcconfig/NfcConfigure$PopupScenarioList;

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mPopupDialogType:Lcom/lge/nfcconfig/NfcConfigure$PopupScenarioList;

    sget-object v8, Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;->INITVALUE:Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mVendorType:Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;

    sget-object v8, Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;->oncardrwp2p:Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;

    invoke-virtual {v8}, Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;->name()Ljava/lang/String;

    move-result-object v8

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mDefaultOnOffType:Ljava/lang/String;

    iput-boolean v7, p0, Lcom/lge/nfcconfig/NfcConfigure;->mAccessControlEnable:Z

    sget-object v8, Lcom/lge/nfcconfig/NfcConfigure$PowerSaveScenarioList;->INITVALUE:Lcom/lge/nfcconfig/NfcConfigure$PowerSaveScenarioList;

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mPowerSaveType:Lcom/lge/nfcconfig/NfcConfigure$PowerSaveScenarioList;

    iput-boolean v6, p0, Lcom/lge/nfcconfig/NfcConfigure;->mNfcEERoutingEnable:Z

    iput-boolean v6, p0, Lcom/lge/nfcconfig/NfcConfigure;->mDisableInPowerOffEnable:Z

    iput-boolean v7, p0, Lcom/lge/nfcconfig/NfcConfigure;->mCardEnableInPowerOff:Z

    iput-boolean v6, p0, Lcom/lge/nfcconfig/NfcConfigure;->mMTKBluetoothEnable:Z

    iput-boolean v6, p0, Lcom/lge/nfcconfig/NfcConfigure;->mHandoverAutoAppLaunch:Z

    iput-boolean v6, p0, Lcom/lge/nfcconfig/NfcConfigure;->mWPSHandoverEnable:Z

    iput-boolean v6, p0, Lcom/lge/nfcconfig/NfcConfigure;->mWCScenarioEnable:Z

    iput-boolean v7, p0, Lcom/lge/nfcconfig/NfcConfigure;->mPermittedSeBroadcastEnable:Z

    iput-boolean v7, p0, Lcom/lge/nfcconfig/NfcConfigure;->mVendorStablePatch:Z

    iput-boolean v6, p0, Lcom/lge/nfcconfig/NfcConfigure;->mSePatchEnabled:Z

    iput-boolean v6, p0, Lcom/lge/nfcconfig/NfcConfigure;->mCoverScenarioEnable:Z

    iput-boolean v7, p0, Lcom/lge/nfcconfig/NfcConfigure;->mEmptyPopupSupport:Z

    iput-boolean v6, p0, Lcom/lge/nfcconfig/NfcConfigure;->mLockScreenPollingEnable:Z

    iput-boolean v7, p0, Lcom/lge/nfcconfig/NfcConfigure;->mNotifyonlyValidTag:Z

    iput-boolean v6, p0, Lcom/lge/nfcconfig/NfcConfigure;->mTagLongTimePopupSupport:Z

    iput-boolean v6, p0, Lcom/lge/nfcconfig/NfcConfigure;->mMccMncSupport:Z

    iput-boolean v6, p0, Lcom/lge/nfcconfig/NfcConfigure;->mAdvancedHCEEnable:Z

    iput-boolean v6, p0, Lcom/lge/nfcconfig/NfcConfigure;->mHCEOnHostEnable:Z

    iput-boolean v6, p0, Lcom/lge/nfcconfig/NfcConfigure;->mAidFilterEnable:Z

    sget-object v8, Lcom/lge/nfcconfig/NfcConfigure$HceScenarioList;->v1:Lcom/lge/nfcconfig/NfcConfigure$HceScenarioList;

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mHceScenario:Lcom/lge/nfcconfig/NfcConfigure$HceScenarioList;

    sget-object v8, Lcom/lge/nfcconfig/NfcConfigure$TransactionEventScenarioList;->unicast:Lcom/lge/nfcconfig/NfcConfigure$TransactionEventScenarioList;

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mTransactionEventScenario:Lcom/lge/nfcconfig/NfcConfigure$TransactionEventScenarioList;

    new-instance v8, Ljava/util/HashMap;

    invoke-direct {v8}, Ljava/util/HashMap;-><init>()V

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mHostCardEmulationScenario:Ljava/util/Map;

    const-string v8, "ro.build.target_operator"

    invoke-static {v8}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mTargetOperator:Ljava/lang/String;

    const-string v8, "ro.build.target_country"

    invoke-static {v8}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mTargetCountry:Ljava/lang/String;

    const-string v8, "ro.product.device"

    invoke-static {v8}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mTargetDevice:Ljava/lang/String;

    const-string v8, ""

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mTargetFlag:Ljava/lang/String;

    iput-object p1, p0, Lcom/lge/nfcconfig/NfcConfigure;->mContext:Landroid/content/Context;

    sput-object p0, Lcom/lge/nfcconfig/NfcConfigure;->INSTANCE:Lcom/lge/nfcconfig/NfcConfigure;

    sget-object v8, Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;->INITVALUE:Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mVendorType:Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;

    invoke-static {}, Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;->values()[Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;

    move-result-object v0

    .local v0, "arr$":[Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;
    array-length v2, v0

    .local v2, "len$":I
    const/4 v1, 0x0

    .local v1, "i$":I
    :goto_0
    if-ge v1, v2, :cond_1

    aget-object v3, v0, v1

    .local v3, "list":Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;
    const-string v8, "lge.nfc.vendor"

    invoke-static {v8}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .local v5, "vendorType":Ljava/lang/String;
    if-eqz v5, :cond_0

    invoke-virtual {v3}, Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v5, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_0

    iput-object v3, p0, Lcom/lge/nfcconfig/NfcConfigure;->mVendorType:Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .end local v3    # "list":Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;
    .end local v5    # "vendorType":Ljava/lang/String;
    :cond_1
    const-string v8, "ril.temp.countrycodeforoneimage"

    invoke-static {v8}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mMCC:Ljava/lang/String;

    iget-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mMCC:Ljava/lang/String;

    const-string v9, ""

    invoke-virtual {v8, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_2

    const-string v8, "persist.sys.iccid-mcc"

    invoke-static {v8}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mMCC:Ljava/lang/String;

    :cond_2
    iget-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mTargetOperator:Ljava/lang/String;

    if-eqz v8, :cond_3

    iget-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mTargetCountry:Ljava/lang/String;

    if-nez v8, :cond_4

    :cond_3
    const-string v6, "NfcConfigure"

    const-string v7, "Invalid Target Operator and Country"

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_1
    return-void

    :cond_4
    iget-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mContext:Landroid/content/Context;

    invoke-virtual {v8}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v8

    sget v9, Lcom/lge/internal/R$bool;->config_using_lollipop_cover:I

    invoke-virtual {v8, v9}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v8

    if-nez v8, :cond_5

    iget-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mContext:Landroid/content/Context;

    invoke-virtual {v8}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v8

    sget v9, Lcom/lge/internal/R$bool;->config_using_window_cover:I

    invoke-virtual {v8, v9}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v8

    if-nez v8, :cond_5

    iget-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mContext:Landroid/content/Context;

    invoke-virtual {v8}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v8

    sget v9, Lcom/lge/internal/R$bool;->config_using_circle_cover:I

    invoke-virtual {v8, v9}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v8

    if-eqz v8, :cond_6

    :cond_5
    move v6, v7

    :cond_6
    iput-boolean v6, p0, Lcom/lge/nfcconfig/NfcConfigure;->mCoverScenarioEnable:Z

    new-instance v4, Lcom/lge/nfcconfig/NfcConfigParser;

    iget-object v6, p0, Lcom/lge/nfcconfig/NfcConfigure;->mTargetOperator:Ljava/lang/String;

    iget-object v7, p0, Lcom/lge/nfcconfig/NfcConfigure;->mTargetCountry:Ljava/lang/String;

    iget-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mTargetDevice:Ljava/lang/String;

    invoke-direct {v4, v6, v7, v8}, Lcom/lge/nfcconfig/NfcConfigParser;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .local v4, "mConfigParser":Lcom/lge/nfcconfig/NfcConfigParser;
    invoke-direct {p0}, Lcom/lge/nfcconfig/NfcConfigure;->setDefaultConfig()V

    invoke-virtual {p0}, Lcom/lge/nfcconfig/NfcConfigure;->printDefaultConfig()V

    goto :goto_1
.end method

.method public static IsNfcConfigureValue(Ljava/lang/String;Ljava/lang/Object;)Z
    .locals 2
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "value"    # Ljava/lang/Object;

    .prologue
    invoke-static {}, Lcom/lge/nfcaddon/NfcAdapterAddon;->getNfcAdapterAddon()Lcom/lge/nfcaddon/NfcAdapterAddon;

    move-result-object v0

    .local v0, "adapterAddon":Lcom/lge/nfcaddon/NfcAdapterAddon;
    if-eqz v0, :cond_0

    if-eqz p0, :cond_0

    if-nez p1, :cond_1

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1

    :cond_1
    invoke-virtual {v0, p0, p1}, Lcom/lge/nfcaddon/NfcAdapterAddon;->getNfcConfigureMap(Ljava/lang/String;Ljava/lang/Object;)Z

    move-result v1

    goto :goto_0
.end method

.method private static getDefaultType(Ljava/lang/String;)Ljava/lang/String;
    .locals 6
    .param p0, "mccmnc"    # Ljava/lang/String;

    .prologue
    const/4 v5, 0x3

    const-string v1, "XXX"

    .local v1, "mcc":Ljava/lang/String;
    const-string v2, "XX"

    .local v2, "mnc":Ljava/lang/String;
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    const/4 v4, 0x5

    if-lt v3, v4, :cond_1

    const/4 v3, 0x0

    invoke-virtual {p0, v3, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    const-string v3, "NfcConfigure"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "mcc : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " / mnc : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {v1, v2}, Lcom/lge/nfcconfig/NfcConfigGpriListParser;->searchPRI(Ljava/lang/String;Ljava/lang/String;)Lcom/lge/nfcconfig/NfcConfigGpriListParser$GpriConfig;

    move-result-object v0

    .local v0, "config":Lcom/lge/nfcconfig/NfcConfigGpriListParser$GpriConfig;
    if-eqz v0, :cond_2

    iget-object v3, v0, Lcom/lge/nfcconfig/NfcConfigGpriListParser$GpriConfig;->nfc_default:Ljava/lang/String;

    if-eqz v3, :cond_2

    iget-object v3, v0, Lcom/lge/nfcconfig/NfcConfigGpriListParser$GpriConfig;->nfc_default:Ljava/lang/String;

    const-string v4, "yes"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    sget-object v3, Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;->oncardrwp2p:Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;

    invoke-virtual {v3}, Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;->name()Ljava/lang/String;

    move-result-object v3

    .end local v0    # "config":Lcom/lge/nfcconfig/NfcConfigGpriListParser$GpriConfig;
    :goto_0
    return-object v3

    .restart local v0    # "config":Lcom/lge/nfcconfig/NfcConfigGpriListParser$GpriConfig;
    :cond_0
    sget-object v3, Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;->offp2p:Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;

    invoke-virtual {v3}, Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;->name()Ljava/lang/String;

    move-result-object v3

    goto :goto_0

    .end local v0    # "config":Lcom/lge/nfcconfig/NfcConfigGpriListParser$GpriConfig;
    :cond_1
    const-string v3, "NfcConfigure"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "numeric is invalid, numeric : "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_2
    sget-object v3, Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;->oncardrwp2p:Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;

    invoke-virtual {v3}, Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;->name()Ljava/lang/String;

    move-result-object v3

    goto :goto_0
.end method

.method public static getInstance()Lcom/lge/nfcconfig/NfcConfigure;
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/nfcconfig/NfcConfigure;->INSTANCE:Lcom/lge/nfcconfig/NfcConfigure;

    return-object v0
.end method

.method public static getInstance(Landroid/content/Context;)Lcom/lge/nfcconfig/NfcConfigure;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    sget-object v0, Lcom/lge/nfcconfig/NfcConfigure;->INSTANCE:Lcom/lge/nfcconfig/NfcConfigure;

    if-nez v0, :cond_0

    if-eqz p0, :cond_0

    new-instance v0, Lcom/lge/nfcconfig/NfcConfigure;

    invoke-direct {v0, p0}, Lcom/lge/nfcconfig/NfcConfigure;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/lge/nfcconfig/NfcConfigure;->INSTANCE:Lcom/lge/nfcconfig/NfcConfigure;

    :cond_0
    sget-object v0, Lcom/lge/nfcconfig/NfcConfigure;->INSTANCE:Lcom/lge/nfcconfig/NfcConfigure;

    return-object v0
.end method

.method public static getNfcConfigureValue(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p0, "key"    # Ljava/lang/String;

    .prologue
    invoke-static {}, Lcom/lge/nfcaddon/NfcAdapterAddon;->getNfcAdapterAddon()Lcom/lge/nfcaddon/NfcAdapterAddon;

    move-result-object v0

    .local v0, "adapterAddon":Lcom/lge/nfcaddon/NfcAdapterAddon;
    if-eqz v0, :cond_0

    if-nez p0, :cond_1

    :cond_0
    const-string v1, ""

    :goto_0
    return-object v1

    :cond_1
    invoke-virtual {v0, p0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->getNfcConfigureMap(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_0
.end method

.method private isBroadcom()Z
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/nfcconfig/NfcConfigure;->mVendorType:Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;

    sget-object v1, Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;->brcm:Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private isInside()Z
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/nfcconfig/NfcConfigure;->mVendorType:Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;

    sget-object v1, Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;->inside:Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private isNxp()Z
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/nfcconfig/NfcConfigure;->mVendorType:Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;

    sget-object v1, Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;->nxp:Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private isSony()Z
    .locals 2

    .prologue
    iget-object v0, p0, Lcom/lge/nfcconfig/NfcConfigure;->mVendorType:Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;

    sget-object v1, Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;->sony:Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private setDefaultConfig()V
    .locals 14

    .prologue
    const/4 v11, 0x0

    const/4 v10, 0x1

    iget-object v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mTargetOperator:Ljava/lang/String;

    iget-object v12, p0, Lcom/lge/nfcconfig/NfcConfigure;->mTargetCountry:Ljava/lang/String;

    iget-object v13, p0, Lcom/lge/nfcconfig/NfcConfigure;->mTargetDevice:Ljava/lang/String;

    invoke-static {v9, v12, v13}, Lcom/lge/nfcconfig/NfcConfigListParser;->searchConfig(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/lge/nfcconfig/NfcConfigListParser$Config;

    move-result-object v1

    .local v1, "config":Lcom/lge/nfcconfig/NfcConfigListParser$Config;
    if-nez v1, :cond_0

    :goto_0
    return-void

    :cond_0
    sget-object v9, Lcom/lge/nfcconfig/NfcConfigure$IndicatorList;->INITVALUE:Lcom/lge/nfcconfig/NfcConfigure$IndicatorList;

    iput-object v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mIndicatorType:Lcom/lge/nfcconfig/NfcConfigure$IndicatorList;

    invoke-static {}, Lcom/lge/nfcconfig/NfcConfigure$IndicatorList;->values()[Lcom/lge/nfcconfig/NfcConfigure$IndicatorList;

    move-result-object v0

    .local v0, "arr$":[Lcom/lge/nfcconfig/NfcConfigure$IndicatorList;
    array-length v7, v0

    .local v7, "len$":I
    const/4 v5, 0x0

    .local v5, "i$":I
    :goto_1
    if-ge v5, v7, :cond_2

    aget-object v8, v0, v5

    .local v8, "list":Lcom/lge/nfcconfig/NfcConfigure$IndicatorList;
    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mIndicatorType:Ljava/lang/String;

    invoke-virtual {v8}, Lcom/lge/nfcconfig/NfcConfigure$IndicatorList;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v9, v12}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_1

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mIndicatorType:Lcom/lge/nfcconfig/NfcConfigure$IndicatorList;

    :cond_1
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    .end local v8    # "list":Lcom/lge/nfcconfig/NfcConfigure$IndicatorList;
    :cond_2
    sget-object v9, Lcom/lge/nfcconfig/NfcConfigure$SoundScenarioList;->INITVALUE:Lcom/lge/nfcconfig/NfcConfigure$SoundScenarioList;

    iput-object v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mRingSoundScenarioType:Lcom/lge/nfcconfig/NfcConfigure$SoundScenarioList;

    invoke-static {}, Lcom/lge/nfcconfig/NfcConfigure$SoundScenarioList;->values()[Lcom/lge/nfcconfig/NfcConfigure$SoundScenarioList;

    move-result-object v0

    .local v0, "arr$":[Lcom/lge/nfcconfig/NfcConfigure$SoundScenarioList;
    array-length v7, v0

    const/4 v5, 0x0

    :goto_2
    if-ge v5, v7, :cond_4

    aget-object v8, v0, v5

    .local v8, "list":Lcom/lge/nfcconfig/NfcConfigure$SoundScenarioList;
    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mRingSoundScenarioType:Ljava/lang/String;

    invoke-virtual {v8}, Lcom/lge/nfcconfig/NfcConfigure$SoundScenarioList;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v9, v12}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_3

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mRingSoundScenarioType:Lcom/lge/nfcconfig/NfcConfigure$SoundScenarioList;

    :cond_3
    add-int/lit8 v5, v5, 0x1

    goto :goto_2

    .end local v8    # "list":Lcom/lge/nfcconfig/NfcConfigure$SoundScenarioList;
    :cond_4
    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mWCScenarioEnable:Ljava/lang/String;

    sget-object v12, Lcom/lge/nfcconfig/NfcConfigure$WirelessChargingList;->update:Lcom/lge/nfcconfig/NfcConfigure$WirelessChargingList;

    invoke-virtual {v12}, Lcom/lge/nfcconfig/NfcConfigure$WirelessChargingList;->name()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v9, v12}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_6

    move v9, v10

    :goto_3
    iput-boolean v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mWCScenarioEnable:Z

    sget-object v9, Lcom/lge/nfcconfig/NfcConfigure$SecureElementList;->INITVALUE:Lcom/lge/nfcconfig/NfcConfigure$SecureElementList;

    iput-object v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mSecureElementType:Lcom/lge/nfcconfig/NfcConfigure$SecureElementList;

    invoke-static {}, Lcom/lge/nfcconfig/NfcConfigure$SecureElementList;->values()[Lcom/lge/nfcconfig/NfcConfigure$SecureElementList;

    move-result-object v0

    .local v0, "arr$":[Lcom/lge/nfcconfig/NfcConfigure$SecureElementList;
    array-length v7, v0

    const/4 v5, 0x0

    :goto_4
    if-ge v5, v7, :cond_7

    aget-object v8, v0, v5

    .local v8, "list":Lcom/lge/nfcconfig/NfcConfigure$SecureElementList;
    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mSecureElementType:Ljava/lang/String;

    invoke-virtual {v8}, Lcom/lge/nfcconfig/NfcConfigure$SecureElementList;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v9, v12}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_5

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mSecureElementType:Lcom/lge/nfcconfig/NfcConfigure$SecureElementList;

    :cond_5
    add-int/lit8 v5, v5, 0x1

    goto :goto_4

    .end local v8    # "list":Lcom/lge/nfcconfig/NfcConfigure$SecureElementList;
    .local v0, "arr$":[Lcom/lge/nfcconfig/NfcConfigure$SoundScenarioList;
    :cond_6
    move v9, v11

    goto :goto_3

    .local v0, "arr$":[Lcom/lge/nfcconfig/NfcConfigure$SecureElementList;
    :cond_7
    sget-object v9, Lcom/lge/nfcconfig/NfcConfigure$HandoverScenarioList;->INITVALUE:Lcom/lge/nfcconfig/NfcConfigure$HandoverScenarioList;

    iput-object v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mHandoverSupportType:Lcom/lge/nfcconfig/NfcConfigure$HandoverScenarioList;

    invoke-static {}, Lcom/lge/nfcconfig/NfcConfigure$HandoverScenarioList;->values()[Lcom/lge/nfcconfig/NfcConfigure$HandoverScenarioList;

    move-result-object v0

    .local v0, "arr$":[Lcom/lge/nfcconfig/NfcConfigure$HandoverScenarioList;
    array-length v7, v0

    const/4 v5, 0x0

    :goto_5
    if-ge v5, v7, :cond_9

    aget-object v8, v0, v5

    .local v8, "list":Lcom/lge/nfcconfig/NfcConfigure$HandoverScenarioList;
    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mHandoverSupportType:Ljava/lang/String;

    invoke-virtual {v8}, Lcom/lge/nfcconfig/NfcConfigure$HandoverScenarioList;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v9, v12}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v9

    if-ltz v9, :cond_8

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mHandoverSupportType:Lcom/lge/nfcconfig/NfcConfigure$HandoverScenarioList;

    :cond_8
    add-int/lit8 v5, v5, 0x1

    goto :goto_5

    .end local v8    # "list":Lcom/lge/nfcconfig/NfcConfigure$HandoverScenarioList;
    :cond_9
    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mHandoverSupportType:Ljava/lang/String;

    const-string v12, "mtkbt"

    invoke-virtual {v9, v12}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v9

    if-ltz v9, :cond_d

    move v9, v10

    :goto_6
    iput-boolean v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mMTKBluetoothEnable:Z

    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mHandoverSupportType:Ljava/lang/String;

    const-string v12, "autoapplaunch"

    invoke-virtual {v9, v12}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v9

    if-ltz v9, :cond_e

    move v9, v10

    :goto_7
    iput-boolean v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mHandoverAutoAppLaunch:Z

    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mHandoverSupportType:Ljava/lang/String;

    const-string v12, "WPSHandover"

    invoke-virtual {v9, v12}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v9

    if-ltz v9, :cond_a

    move v11, v10

    :cond_a
    iput-boolean v11, p0, Lcom/lge/nfcconfig/NfcConfigure;->mWPSHandoverEnable:Z

    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mMccMncSupport:Ljava/lang/String;

    const-string v11, "true"

    invoke-virtual {v9, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    iput-boolean v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mMccMncSupport:Z

    sget-object v9, Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;->INITVALUE:Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;

    invoke-virtual {v9}, Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;->name()Ljava/lang/String;

    move-result-object v2

    .local v2, "defaultonoff":Ljava/lang/String;
    :try_start_0
    iget-object v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mContext:Landroid/content/Context;

    invoke-virtual {v9}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v9

    sget v11, Lcom/lge/internal/R$string;->config_nfc_defaultonoff:I

    invoke-virtual {v9, v11}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    :goto_8
    sget-object v9, Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;->INITVALUE:Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;

    invoke-virtual {v9}, Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;->name()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v2, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-nez v9, :cond_f

    iput-object v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mDefaultOnOffType:Ljava/lang/String;

    :goto_9
    iget-object v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mDefaultOnOffType:Ljava/lang/String;

    sget-object v11, Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;->open:Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;

    invoke-virtual {v11}, Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;->name()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v9, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_b

    iget-object v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mDefaultOnOffType:Ljava/lang/String;

    iput-object v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mTargetFlag:Ljava/lang/String;

    invoke-direct {p0}, Lcom/lge/nfcconfig/NfcConfigure;->setOpenarrayPowerStatus()Ljava/lang/String;

    move-result-object v9

    iput-object v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mDefaultOnOffType:Ljava/lang/String;

    :cond_b
    sget-object v9, Lcom/lge/nfcconfig/NfcConfigure$PopupScenarioList;->INITVALUE:Lcom/lge/nfcconfig/NfcConfigure$PopupScenarioList;

    iput-object v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mPopupDialogType:Lcom/lge/nfcconfig/NfcConfigure$PopupScenarioList;

    invoke-static {}, Lcom/lge/nfcconfig/NfcConfigure$PopupScenarioList;->values()[Lcom/lge/nfcconfig/NfcConfigure$PopupScenarioList;

    move-result-object v0

    .local v0, "arr$":[Lcom/lge/nfcconfig/NfcConfigure$PopupScenarioList;
    array-length v7, v0

    const/4 v5, 0x0

    :goto_a
    if-ge v5, v7, :cond_10

    aget-object v8, v0, v5

    .local v8, "list":Lcom/lge/nfcconfig/NfcConfigure$PopupScenarioList;
    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mPopupDialogType:Ljava/lang/String;

    invoke-virtual {v8}, Lcom/lge/nfcconfig/NfcConfigure$PopupScenarioList;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v9, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_c

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mPopupDialogType:Lcom/lge/nfcconfig/NfcConfigure$PopupScenarioList;

    :cond_c
    add-int/lit8 v5, v5, 0x1

    goto :goto_a

    .end local v2    # "defaultonoff":Ljava/lang/String;
    .end local v8    # "list":Lcom/lge/nfcconfig/NfcConfigure$PopupScenarioList;
    .local v0, "arr$":[Lcom/lge/nfcconfig/NfcConfigure$HandoverScenarioList;
    :cond_d
    move v9, v11

    goto :goto_6

    :cond_e
    move v9, v11

    goto :goto_7

    .restart local v2    # "defaultonoff":Ljava/lang/String;
    :cond_f
    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mDefaultOnOffType:Ljava/lang/String;

    iput-object v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mDefaultOnOffType:Ljava/lang/String;

    goto :goto_9

    .local v0, "arr$":[Lcom/lge/nfcconfig/NfcConfigure$PopupScenarioList;
    :cond_10
    sget-object v9, Lcom/lge/nfcconfig/NfcConfigure$PowerSaveScenarioList;->INITVALUE:Lcom/lge/nfcconfig/NfcConfigure$PowerSaveScenarioList;

    iput-object v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mPowerSaveType:Lcom/lge/nfcconfig/NfcConfigure$PowerSaveScenarioList;

    invoke-static {}, Lcom/lge/nfcconfig/NfcConfigure$PowerSaveScenarioList;->values()[Lcom/lge/nfcconfig/NfcConfigure$PowerSaveScenarioList;

    move-result-object v0

    .local v0, "arr$":[Lcom/lge/nfcconfig/NfcConfigure$PowerSaveScenarioList;
    array-length v7, v0

    const/4 v5, 0x0

    :goto_b
    if-ge v5, v7, :cond_12

    aget-object v8, v0, v5

    .local v8, "list":Lcom/lge/nfcconfig/NfcConfigure$PowerSaveScenarioList;
    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mPowerSaveType:Ljava/lang/String;

    invoke-virtual {v8}, Lcom/lge/nfcconfig/NfcConfigure$PowerSaveScenarioList;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v9, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_11

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mPowerSaveType:Lcom/lge/nfcconfig/NfcConfigure$PowerSaveScenarioList;

    :cond_11
    add-int/lit8 v5, v5, 0x1

    goto :goto_b

    .end local v8    # "list":Lcom/lge/nfcconfig/NfcConfigure$PowerSaveScenarioList;
    :cond_12
    sget-object v9, Lcom/lge/nfcconfig/NfcConfigure$HceScenarioList;->v1:Lcom/lge/nfcconfig/NfcConfigure$HceScenarioList;

    iput-object v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mHceScenario:Lcom/lge/nfcconfig/NfcConfigure$HceScenarioList;

    invoke-static {}, Lcom/lge/nfcconfig/NfcConfigure$HceScenarioList;->values()[Lcom/lge/nfcconfig/NfcConfigure$HceScenarioList;

    move-result-object v0

    .local v0, "arr$":[Lcom/lge/nfcconfig/NfcConfigure$HceScenarioList;
    array-length v7, v0

    const/4 v5, 0x0

    :goto_c
    if-ge v5, v7, :cond_14

    aget-object v8, v0, v5

    .local v8, "list":Lcom/lge/nfcconfig/NfcConfigure$HceScenarioList;
    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mHceScenario:Ljava/lang/String;

    invoke-virtual {v8}, Lcom/lge/nfcconfig/NfcConfigure$HceScenarioList;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v9, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_13

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mHceScenario:Lcom/lge/nfcconfig/NfcConfigure$HceScenarioList;

    :cond_13
    add-int/lit8 v5, v5, 0x1

    goto :goto_c

    .end local v8    # "list":Lcom/lge/nfcconfig/NfcConfigure$HceScenarioList;
    :cond_14
    sget-object v9, Lcom/lge/nfcconfig/NfcConfigure$TransactionEventScenarioList;->INITVALUE:Lcom/lge/nfcconfig/NfcConfigure$TransactionEventScenarioList;

    iput-object v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mTransactionEventScenario:Lcom/lge/nfcconfig/NfcConfigure$TransactionEventScenarioList;

    invoke-static {}, Lcom/lge/nfcconfig/NfcConfigure$TransactionEventScenarioList;->values()[Lcom/lge/nfcconfig/NfcConfigure$TransactionEventScenarioList;

    move-result-object v0

    .local v0, "arr$":[Lcom/lge/nfcconfig/NfcConfigure$TransactionEventScenarioList;
    array-length v7, v0

    const/4 v5, 0x0

    :goto_d
    if-ge v5, v7, :cond_16

    aget-object v8, v0, v5

    .local v8, "list":Lcom/lge/nfcconfig/NfcConfigure$TransactionEventScenarioList;
    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mTransactionEventScenario:Ljava/lang/String;

    invoke-virtual {v8}, Lcom/lge/nfcconfig/NfcConfigure$TransactionEventScenarioList;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v9, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_15

    iput-object v8, p0, Lcom/lge/nfcconfig/NfcConfigure;->mTransactionEventScenario:Lcom/lge/nfcconfig/NfcConfigure$TransactionEventScenarioList;

    :cond_15
    add-int/lit8 v5, v5, 0x1

    goto :goto_d

    .end local v8    # "list":Lcom/lge/nfcconfig/NfcConfigure$TransactionEventScenarioList;
    :cond_16
    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mHostCardEmulationScenario:Ljava/lang/String;

    const-string v11, ","

    invoke-virtual {v9, v11}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v3

    .local v3, "hceScenarioArray":[Ljava/lang/String;
    if-eqz v3, :cond_1a

    array-length v9, v3

    invoke-static {}, Lcom/lge/nfcconfig/NfcConfigure$HCEScreenStateList;->length()I

    move-result v11

    if-ne v9, v11, :cond_1a

    const/4 v4, 0x0

    .end local v0    # "arr$":[Lcom/lge/nfcconfig/NfcConfigure$TransactionEventScenarioList;
    .local v4, "i":I
    :goto_e
    invoke-static {}, Lcom/lge/nfcconfig/NfcConfigure$HCEScreenStateList;->length()I

    move-result v9

    if-ge v4, v9, :cond_1c

    const/4 v6, 0x0

    .local v6, "isParsing":Z
    invoke-static {}, Lcom/lge/nfcconfig/NfcConfigure$HCEScenarioList;->values()[Lcom/lge/nfcconfig/NfcConfigure$HCEScenarioList;

    move-result-object v0

    .local v0, "arr$":[Lcom/lge/nfcconfig/NfcConfigure$HCEScenarioList;
    array-length v7, v0

    const/4 v5, 0x0

    :goto_f
    if-ge v5, v7, :cond_17

    aget-object v8, v0, v5

    .local v8, "list":Lcom/lge/nfcconfig/NfcConfigure$HCEScenarioList;
    aget-object v9, v3, v4

    invoke-virtual {v9}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8}, Lcom/lge/nfcconfig/NfcConfigure$HCEScenarioList;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v9, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_19

    iget-object v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mHostCardEmulationScenario:Ljava/util/Map;

    invoke-static {v4}, Lcom/lge/nfcconfig/NfcConfigure$HCEScreenStateList;->getListValue(I)Lcom/lge/nfcconfig/NfcConfigure$HCEScreenStateList;

    move-result-object v11

    invoke-interface {v9, v11, v8}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const/4 v6, 0x1

    .end local v8    # "list":Lcom/lge/nfcconfig/NfcConfigure$HCEScenarioList;
    :cond_17
    if-nez v6, :cond_18

    iget-object v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mHostCardEmulationScenario:Ljava/util/Map;

    invoke-static {v4}, Lcom/lge/nfcconfig/NfcConfigure$HCEScreenStateList;->getListValue(I)Lcom/lge/nfcconfig/NfcConfigure$HCEScreenStateList;

    move-result-object v11

    sget-object v12, Lcom/lge/nfcconfig/NfcConfigure$HCEScenarioList;->config:Lcom/lge/nfcconfig/NfcConfigure$HCEScenarioList;

    invoke-interface {v9, v11, v12}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v9, "NfcConfigure"

    const-string v11, "Invalid NFC HCE Scenario name"

    invoke-static {v9, v11}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const-string v9, "ro.build.type"

    invoke-static {v9}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    const-string v11, "user"

    invoke-virtual {v9, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-nez v9, :cond_18

    iget-object v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mContext:Landroid/content/Context;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "Invalid NFC HCE Scenario name : "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    aget-object v12, v3, v4

    invoke-virtual {v12}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, " - default setting (config)"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v9, v11, v10}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v9

    invoke-virtual {v9}, Landroid/widget/Toast;->show()V

    :cond_18
    add-int/lit8 v4, v4, 0x1

    goto :goto_e

    .restart local v8    # "list":Lcom/lge/nfcconfig/NfcConfigure$HCEScenarioList;
    :cond_19
    add-int/lit8 v5, v5, 0x1

    goto :goto_f

    .end local v4    # "i":I
    .end local v6    # "isParsing":Z
    .end local v8    # "list":Lcom/lge/nfcconfig/NfcConfigure$HCEScenarioList;
    .local v0, "arr$":[Lcom/lge/nfcconfig/NfcConfigure$TransactionEventScenarioList;
    :cond_1a
    const/4 v4, 0x0

    .restart local v4    # "i":I
    :goto_10
    invoke-static {}, Lcom/lge/nfcconfig/NfcConfigure$HCEScreenStateList;->length()I

    move-result v9

    if-ge v4, v9, :cond_1c

    iget-object v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mHostCardEmulationScenario:Ljava/util/Map;

    invoke-static {v4}, Lcom/lge/nfcconfig/NfcConfigure$HCEScreenStateList;->getListValue(I)Lcom/lge/nfcconfig/NfcConfigure$HCEScreenStateList;

    move-result-object v11

    sget-object v12, Lcom/lge/nfcconfig/NfcConfigure$HCEScenarioList;->config:Lcom/lge/nfcconfig/NfcConfigure$HCEScenarioList;

    invoke-interface {v9, v11, v12}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v9, "NfcConfigure"

    const-string v11, "Invalid NFC HCE Scenario List"

    invoke-static {v9, v11}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const-string v9, "ro.build.type"

    invoke-static {v9}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    const-string v11, "user"

    invoke-virtual {v9, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-nez v9, :cond_1b

    iget-object v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mContext:Landroid/content/Context;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "Invalid NFC HCE Scenario List : "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    iget-object v12, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mHostCardEmulationScenario:Ljava/lang/String;

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v9, v11, v10}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v9

    invoke-virtual {v9}, Landroid/widget/Toast;->show()V

    :cond_1b
    add-int/lit8 v4, v4, 0x1

    goto :goto_10

    .end local v0    # "arr$":[Lcom/lge/nfcconfig/NfcConfigure$TransactionEventScenarioList;
    :cond_1c
    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mAccessControlEnable:Ljava/lang/String;

    const-string v10, "true"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    iput-boolean v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mAccessControlEnable:Z

    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mNfcEERoutingEnable:Ljava/lang/String;

    const-string v10, "true"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    iput-boolean v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mNfcEERoutingEnable:Z

    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mDisableInPowerOffEnable:Ljava/lang/String;

    const-string v10, "true"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    iput-boolean v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mDisableInPowerOffEnable:Z

    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mCardEnableInPowerOff:Ljava/lang/String;

    const-string v10, "true"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    iput-boolean v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mCardEnableInPowerOff:Z

    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mVendorStablePatch:Ljava/lang/String;

    const-string v10, "true"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    iput-boolean v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mVendorStablePatch:Z

    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mPermittedSeBroadcastEnable:Ljava/lang/String;

    const-string v10, "true"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    iput-boolean v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mPermittedSeBroadcastEnable:Z

    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mEmptyPopupSupport:Ljava/lang/String;

    const-string v10, "true"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    iput-boolean v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mEmptyPopupSupport:Z

    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mLockScreenPollingEnable:Ljava/lang/String;

    const-string v10, "true"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    iput-boolean v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mLockScreenPollingEnable:Z

    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mNotifyonlyValidTag:Ljava/lang/String;

    const-string v10, "true"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    iput-boolean v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mNotifyonlyValidTag:Z

    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mSePatchEnabled:Ljava/lang/String;

    const-string v10, "true"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    iput-boolean v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mSePatchEnabled:Z

    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mTagLongTimePopupSupport:Ljava/lang/String;

    const-string v10, "true"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    iput-boolean v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mTagLongTimePopupSupport:Z

    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mAdvancedHCEEnable:Ljava/lang/String;

    const-string v10, "true"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    iput-boolean v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mAdvancedHCEEnable:Z

    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mHCEOnHostEnable:Ljava/lang/String;

    const-string v10, "true"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    iput-boolean v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mHCEOnHostEnable:Z

    iget-object v9, v1, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mAidFilterEnable:Ljava/lang/String;

    const-string v10, "true"

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    iput-boolean v9, p0, Lcom/lge/nfcconfig/NfcConfigure;->mAidFilterEnable:Z

    goto/16 :goto_0

    .end local v3    # "hceScenarioArray":[Ljava/lang/String;
    .end local v4    # "i":I
    .local v0, "arr$":[Lcom/lge/nfcconfig/NfcConfigure$HandoverScenarioList;
    :catch_0
    move-exception v9

    goto/16 :goto_8
.end method

.method private setOpenarrayPowerStatus()Ljava/lang/String;
    .locals 5

    .prologue
    sget-object v2, Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;->offp2p:Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;

    invoke-virtual {v2}, Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;->name()Ljava/lang/String;

    move-result-object v0

    .local v0, "defaulttype":Ljava/lang/String;
    iget-boolean v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mMccMncSupport:Z

    if-eqz v2, :cond_3

    const-string v2, "gsm.sim.state"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .local v1, "prop":Ljava/lang/String;
    if-eqz v1, :cond_0

    const-string v2, "NfcConfigure"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "TelephonyProperties.PROPERTY_SIM_STATE : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v2, "READY"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    const-string v2, "gsm.sim.operator.numeric"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigure;->getDefaultType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .end local v1    # "prop":Ljava/lang/String;
    :cond_0
    :goto_0
    const-string v2, "NfcConfigure"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "setOpenarrayPowerStatus defaulttype : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-object v0

    .restart local v1    # "prop":Ljava/lang/String;
    :cond_1
    const-string v2, "ABSENT"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    const-string v2, "persist.sys.first-mccmnc"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigure;->getDefaultType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_2
    const-string v2, "UNKNOWN"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    const-string v2, ""

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigure;->getDefaultType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .end local v1    # "prop":Ljava/lang/String;
    :cond_3
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lcom/lge/nfcconfig/NfcConfigure;->mMCC:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "XX"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigure;->getDefaultType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0
.end method


# virtual methods
.method public printDefaultConfig()V
    .locals 4

    .prologue
    const-string v0, "ro.build.type"

    invoke-static {v0}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "user"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "NfcConfigure"

    const-string v1, "====================== LGE NFC Configure START ============================="

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    const-string v1, " Feature Name : Current Value(config_xxx.xml) / Default Value(config.xml)"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    const-string v1, "===================================================================="

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "mTargetOperator : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mTargetOperator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "mTargetCountry : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mTargetCountry:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "mTargetDevice : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mTargetDevice:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "persist.sys.iccid-mcc : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mMCC:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "lge.nfc.vendor : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "lge.nfc.vendor"

    invoke-static {v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "/ VendorType : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mVendorType:Lcom/lge/nfcconfig/NfcConfigure$ChipSetList;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "SecureElementType : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mSecureElementType:Lcom/lge/nfcconfig/NfcConfigure$SecureElementList;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "SecureElementType"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "DefaultOnOffType : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mDefaultOnOffType:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "DefaultOnOffType"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "HandoverSupportType : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mHandoverSupportType:Lcom/lge/nfcconfig/NfcConfigure$HandoverScenarioList;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "HandoverSupportType"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "MTKSupport : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mMTKBluetoothEnable:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", HandoverAutoAppLaunch : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mHandoverAutoAppLaunch:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", WPSHandoverEnable : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mWPSHandoverEnable:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "AccessControlEnable : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mAccessControlEnable:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "AccessControlEnable"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "IndicatorType : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mIndicatorType:Lcom/lge/nfcconfig/NfcConfigure$IndicatorList;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "IndicatorType"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "RingSoundScenarioType : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mRingSoundScenarioType:Lcom/lge/nfcconfig/NfcConfigure$SoundScenarioList;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "RingSoundScenarioType"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "PowerSaveType : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mPowerSaveType:Lcom/lge/nfcconfig/NfcConfigure$PowerSaveScenarioList;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "PowerSaveType"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "NfcEERoutingEnable : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mNfcEERoutingEnable:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "NfcEERoutingEnable"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "DisableInPowerOffEnable : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mDisableInPowerOffEnable:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "DisableInPowerOffEnable"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "CardEnableInPowerOff : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mCardEnableInPowerOff:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "CardEnableInPowerOff"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "PopupDialogType : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mPopupDialogType:Lcom/lge/nfcconfig/NfcConfigure$PopupScenarioList;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "PopupDialogType"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "WCScenarioEnable : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mWCScenarioEnable:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "WCScenarioEnable"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "PermittedSeBroadcastEnable : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mPermittedSeBroadcastEnable:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "PermittedSeBroadcastEnable"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "VendorStablePatch : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mVendorStablePatch:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "VendorStablePatch"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "SePatchEnabled : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mSePatchEnabled:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "SePatchEnabled"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "EmptyPopupSupport : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mEmptyPopupSupport:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "EmptyPopupSupport"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "LockScreenPollingEnable : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mLockScreenPollingEnable:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "LockScreenPollingEnable"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "NotifyonlyValidTag : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mNotifyonlyValidTag:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "NotifyonlyValidTag"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "TagLongTimePopupSupport : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mTagLongTimePopupSupport:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "TagLongTimePopupSupport"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "MccMncSupport : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mMccMncSupport:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "MccMncSupport"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "AdvancedHCEEnable : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mAdvancedHCEEnable:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "AdvancedHCEEnable"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "HCEonHostEnable : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mHCEOnHostEnable:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "HCEOnHostEnable"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "AidFilterEnable : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mAidFilterEnable:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "AidFilterEnable"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "HceScenario : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mHceScenario:Lcom/lge/nfcconfig/NfcConfigure$HceScenarioList;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "HceScenario"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "TransactionEventScenario : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mTransactionEventScenario:Lcom/lge/nfcconfig/NfcConfigure$TransactionEventScenarioList;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "TransactionEventScenario"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "HostCardEmulationScenario : screen_unlocked - "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mHostCardEmulationScenario:Ljava/util/Map;

    sget-object v3, Lcom/lge/nfcconfig/NfcConfigure$HCEScreenStateList;->screen_unlocked:Lcom/lge/nfcconfig/NfcConfigure$HCEScreenStateList;

    invoke-interface {v2, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " / "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "HostCardEmulationScenario"

    invoke-static {v2}, Lcom/lge/nfcconfig/NfcConfigListParser;->getDefaultConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "--------------------------------------------screen_locked - "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mHostCardEmulationScenario:Ljava/util/Map;

    sget-object v3, Lcom/lge/nfcconfig/NfcConfigure$HCEScreenStateList;->screen_locked:Lcom/lge/nfcconfig/NfcConfigure$HCEScreenStateList;

    invoke-interface {v2, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "--------------------------------------------screen_off - "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mHostCardEmulationScenario:Ljava/util/Map;

    sget-object v3, Lcom/lge/nfcconfig/NfcConfigure$HCEScreenStateList;->screen_off:Lcom/lge/nfcconfig/NfcConfigure$HCEScreenStateList;

    invoke-interface {v2, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "--------------------------------------------power_off - "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mHostCardEmulationScenario:Ljava/util/Map;

    sget-object v3, Lcom/lge/nfcconfig/NfcConfigure$HCEScreenStateList;->power_off:Lcom/lge/nfcconfig/NfcConfigure$HCEScreenStateList;

    invoke-interface {v2, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "NfcConfigure"

    const-string v1, "====================== LGE NFC Configure END ============================="

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    return-void
.end method

.method public resetOpenarrayPowerStatus()Ljava/lang/String;
    .locals 3

    .prologue
    iget-object v0, p0, Lcom/lge/nfcconfig/NfcConfigure;->mTargetFlag:Ljava/lang/String;

    sget-object v1, Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;->open:Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;

    invoke-virtual {v1}, Lcom/lge/nfcconfig/NfcConfigure$DefaultOnOffList;->name()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/lge/nfcconfig/NfcConfigure;->setOpenarrayPowerStatus()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigure;->mDefaultOnOffType:Ljava/lang/String;

    :cond_0
    const-string v0, "NfcConfigure"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "DefaultOnOffType : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/lge/nfcconfig/NfcConfigure;->mDefaultOnOffType:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/lge/nfcconfig/NfcConfigure;->mDefaultOnOffType:Ljava/lang/String;

    return-object v0
.end method
