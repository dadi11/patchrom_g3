.class public Lcom/lge/nfcconfig/NfcConfigListParser$Config;
.super Ljava/lang/Object;
.source "NfcConfigListParser.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lge/nfcconfig/NfcConfigListParser;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Config"
.end annotation


# instance fields
.field mAccessControlEnable:Ljava/lang/String;

.field mAdvancedHCEEnable:Ljava/lang/String;

.field mAidFilterEnable:Ljava/lang/String;

.field mCardEnableInPowerOff:Ljava/lang/String;

.field mCountry:Ljava/lang/String;

.field mDefaultOnOffType:Ljava/lang/String;

.field mDevice:Ljava/lang/String;

.field mDisableInPowerOffEnable:Ljava/lang/String;

.field mEmptyPopupSupport:Ljava/lang/String;

.field mHCEOnHostEnable:Ljava/lang/String;

.field mHandoverSupportType:Ljava/lang/String;

.field mHceScenario:Ljava/lang/String;

.field mHostCardEmulationScenario:Ljava/lang/String;

.field mIndicatorType:Ljava/lang/String;

.field mLockScreenPollingEnable:Ljava/lang/String;

.field mMccMncSupport:Ljava/lang/String;

.field mNfcEERoutingEnable:Ljava/lang/String;

.field mNotifyonlyValidTag:Ljava/lang/String;

.field mOperator:Ljava/lang/String;

.field mPermittedSeBroadcastEnable:Ljava/lang/String;

.field mPopupDialogType:Ljava/lang/String;

.field mPowerSaveType:Ljava/lang/String;

.field mRingSoundScenarioType:Ljava/lang/String;

.field mSePatchEnabled:Ljava/lang/String;

.field mSecureElementType:Ljava/lang/String;

.field mTagLongTimePopupSupport:Ljava/lang/String;

.field mTransactionEventScenario:Ljava/lang/String;

.field mVendorStablePatch:Ljava/lang/String;

.field mWCScenarioEnable:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "two_toggleN"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mIndicatorType:Ljava/lang/String;

    const-string v0, "INITVALUE"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mRingSoundScenarioType:Ljava/lang/String;

    const-string v0, "INITVALUE"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mWCScenarioEnable:Ljava/lang/String;

    const-string v0, "uicc"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mSecureElementType:Ljava/lang/String;

    const-string v0, "googlenative"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mHandoverSupportType:Ljava/lang/String;

    const-string v0, "oncardrwp2p"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mDefaultOnOffType:Ljava/lang/String;

    const-string v0, "gsma"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mPopupDialogType:Ljava/lang/String;

    const-string v0, "true"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mAccessControlEnable:Ljava/lang/String;

    const-string v0, "INITVALUE"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mPowerSaveType:Ljava/lang/String;

    const-string v0, "false"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mNfcEERoutingEnable:Ljava/lang/String;

    const-string v0, "false"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mDisableInPowerOffEnable:Ljava/lang/String;

    const-string v0, "true"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mCardEnableInPowerOff:Ljava/lang/String;

    const-string v0, "true"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mVendorStablePatch:Ljava/lang/String;

    const-string v0, "true"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mPermittedSeBroadcastEnable:Ljava/lang/String;

    const-string v0, "true"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mEmptyPopupSupport:Ljava/lang/String;

    const-string v0, "false"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mLockScreenPollingEnable:Ljava/lang/String;

    const-string v0, "true"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mNotifyonlyValidTag:Ljava/lang/String;

    const-string v0, "false"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mSePatchEnabled:Ljava/lang/String;

    const-string v0, "false"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mTagLongTimePopupSupport:Ljava/lang/String;

    const-string v0, "false"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mMccMncSupport:Ljava/lang/String;

    const-string v0, "false"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mAdvancedHCEEnable:Ljava/lang/String;

    const-string v0, "false"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mHCEOnHostEnable:Ljava/lang/String;

    const-string v0, "false"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mAidFilterEnable:Ljava/lang/String;

    const-string v0, "v1"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mHceScenario:Ljava/lang/String;

    const-string v0, "INITVALUE"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mTransactionEventScenario:Ljava/lang/String;

    const-string v0, "config, config, config, config"

    iput-object v0, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mHostCardEmulationScenario:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "operator : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mOperator:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "country : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mCountry:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "device : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mDevice:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "IndicatorType : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mIndicatorType:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "RingSoundScenarioType : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mRingSoundScenarioType:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "WCScenarioEnable : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mWCScenarioEnable:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "SecureElementType : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mSecureElementType:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "HandoverSupportType : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mHandoverSupportType:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "DefaultOnOffType : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mDefaultOnOffType:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "PopupDialogType : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mPopupDialogType:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "AccessControlEnable : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mAccessControlEnable:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "PowerSaveType : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mPowerSaveType:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "NfcEERoutingEnable : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mNfcEERoutingEnable:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "DisableInPowerOffEnable : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mDisableInPowerOffEnable:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "CardEnableInPowerOff : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mCardEnableInPowerOff:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "VendorStablePatch : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mVendorStablePatch:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "PermittedSeBroadcastEnable : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mPermittedSeBroadcastEnable:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "EmptyPopupSupport : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mEmptyPopupSupport:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "LockScreenPollingEnable : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mLockScreenPollingEnable:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "NotifyonlyValidTag : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mNotifyonlyValidTag:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "SePatchEnabled : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mSePatchEnabled:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "TagLongTimePopupSupport : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mTagLongTimePopupSupport:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "MccMncSupport : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mMccMncSupport:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "AdvancedHCEEnable : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mAdvancedHCEEnable:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "HCEOnHostEnable : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mHCEOnHostEnable:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "AidFilterEnable : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mAidFilterEnable:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "HceScenario : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mHceScenario:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "HostCardEmulationScenario : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/lge/nfcconfig/NfcConfigListParser$Config;->mHostCardEmulationScenario:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
