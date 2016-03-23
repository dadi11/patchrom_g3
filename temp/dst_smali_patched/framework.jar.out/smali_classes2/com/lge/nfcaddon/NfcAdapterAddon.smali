.class public final Lcom/lge/nfcaddon/NfcAdapterAddon;
.super Ljava/lang/Object;
.source "NfcAdapterAddon.java"

# interfaces
.implements Lcom/lge/nfcaddon/CardEmulationAddon$NfcAddonRecovery;
.implements Lcom/lge/nfcaddon/GsmaNfcController$NfcAddonRecovery;


# static fields
.field public static final ACTION_ADAPTER_STATE_CHANGED:Ljava/lang/String; = "lge.nfc.action.ADAPTER_STATE_CHANGED"

.field public static final ACTION_CONNECTIVITY_EVENT_DETECTED:Ljava/lang/String; = "com.nxp.action.CONNECTIVITY_EVENT_DETECTED"

.field public static final ACTION_NFC_LG_SHARING:Ljava/lang/String; = "com.lge.nfc.action.lg_sharing"

.field public static final ACTION_NFC_START:Ljava/lang/String; = "com.lge.nfc.action.start"

.field public static final ACTION_TRANSACTION_DETECTED:Ljava/lang/String; = "com.nxp.action.TRANSACTION_DETECTED"

.field public static final CALLING_NFCSOUND_DEFAULT:Z = false

.field public static final CARD_EMULATION_DISABLED:I = 0x0

.field public static final CARD_EMULATION_ENABLED:I = 0x1

.field public static final CARD_EMULATION_ERROR:I = -0x1

.field public static final DATA_NFC_CHIP_MAN:I = 0x64

.field public static final DATA_NFC_CHIP_VER:I = 0x65

.field public static final DATA_NFC_DEFAULT_ROUTE:I = 0x68

.field public static final DATA_NFC_FW_VER:I = 0x67

.field public static final DATA_NFC_MW_VER:I = 0x66

.field public static final EXTRA_ADAPTER_CARD_STATE:Ljava/lang/String; = "com.lge.nfcaddon.extra.ADAPTER_CARD_STATE"

.field public static final EXTRA_ADAPTER_DISCOVERY_STATE:Ljava/lang/String; = "com.lge.nfcaddon.extra.ADAPTER_DISCOVERY_STATE"

.field public static final EXTRA_ADAPTER_P2P_STATE:Ljava/lang/String; = "com.lge.nfcaddon.extra.ADAPTER_P2P_STATE"

.field public static final EXTRA_ADAPTER_SYSTEM_STATE:Ljava/lang/String; = "com.lge.nfcaddon.extra.ADAPTER_SYSTEM_STATE"

.field public static final EXTRA_AID:Ljava/lang/String; = "com.nxp.extra.AID"

.field public static final EXTRA_DATA:Ljava/lang/String; = "com.nxp.extra.DATA"

.field public static final EXTRA_PAYLOAD:Ljava/lang/String; = "com.lge.nfc.extra.payload"

.field public static final EXTRA_SOURCE:Ljava/lang/String; = "com.nxp.extra.SOURCE"

.field public static final FLAG_HANDOVER_SERVICE:I = 0x1000

.field public static final HANDOVER_CHECKBOX_DEFAULT:Z = true

.field public static final NFC_CARD_MASKING:I = 0x0

.field public static final NFC_CARD_OFF:I = 0x2

.field public static final NFC_CARD_ON:I = 0x1

.field public static final NFC_COMMON_OFF:I = 0x2

.field public static final NFC_COMMON_ON:I = 0x1

.field public static final NFC_DISCOVERY_MASKING:I = 0x2

.field public static final NFC_DISCOVERY_OFF:I = 0x8

.field public static final NFC_DISCOVERY_ON:I = 0x4

.field public static final NFC_HANDOVER_MODE:I = 0x1

.field public static final NFC_MASKING_STEP:I = 0x2

.field public static final NFC_P2P_MASKING:I = 0x4

.field public static final NFC_P2P_MODE_MASKING:I = 0xc0

.field public static final NFC_P2P_OFF:I = 0x20

.field public static final NFC_P2P_ON:I = 0x10

.field public static final NUMBER_CALLING_NFCSOUND:I = 0x3

.field public static final NUMBER_HANDOVER_CHECKBOX:I = 0x2

.field public static final NUMBER_HANDOVER_POPUP_VIEW_IN_MONTHLY:I = 0x65

.field public static final NUMBER_POPUP_MONTHLYCHECK:I = 0x4

.field public static final NUMBER_TAG_DEFAULT_CHECKBOX:I = 0x1

.field public static final NUMBER_TAG_POPUP_VIEW_IN_MONTHLY:I = 0x64

.field public static final NUM_NFC_P2P_BIT_SHIFT:I = 0x6

.field public static final POPUP_MONTHLYCHECK_DEFAULT:Z = false

.field public static final PREF_CALLING_NFCSOUND:Ljava/lang/String; = "calling_nfcsound"

.field public static final PREF_POPUP_MONTHLYCHECK:Ljava/lang/String; = "popup_monthlycheck"

.field public static final PREF_TAG_DEFAULT_CHECKBOX:Ljava/lang/String; = "tag_defaultcheckbox"

.field public static final PREF_TAG_HANDOVER_CHECKBOX:Ljava/lang/String; = "handover_checkbox"

.field public static final STATE_CARD_OFF:I = 0xb

.field public static final STATE_CARD_ON:I = 0xd

.field public static final STATE_DISCOVERY_OFF:I = 0x15

.field public static final STATE_DISCOVERY_ON:I = 0x17

.field public static final STATE_OFF:I = 0x29

.field public static final STATE_ON:I = 0x2b

.field public static final STATE_P2P_OFF:I = 0x1f

.field public static final STATE_P2P_ON:I = 0x21

.field public static final STATE_TURNING_CARD_OFF:I = 0xe

.field public static final STATE_TURNING_CARD_ON:I = 0xc

.field public static final STATE_TURNING_DISCOVERY_OFF:I = 0x18

.field public static final STATE_TURNING_DISCOVERY_ON:I = 0x16

.field public static final STATE_TURNING_OFF:I = 0x2c

.field public static final STATE_TURNING_ON:I = 0x2a

.field public static final STATE_TURNING_P2P_OFF:I = 0x22

.field public static final STATE_TURNING_P2P_ON:I = 0x20

.field public static final STATE_TURNING_WC_OFF:I = 0x36

.field public static final STATE_TURNING_WC_ON:I = 0x34

.field public static final STATE_WC_OFF:I = 0x33

.field public static final STATE_WC_ON:I = 0x35

.field static final TAG:Ljava/lang/String; = "NfcAdapterAddon"

.field public static final TAG_DEFAULT_CHECKBOX_DEFAULT:Z = true

.field private static isBinded:Z

.field static mNfcAdapter:Landroid/nfc/NfcAdapter;

.field static sNfcAdapterAddon:Lcom/lge/nfcaddon/NfcAdapterAddon;

.field static sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;


# instance fields
.field private mConfigMap:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput-boolean v0, Lcom/lge/nfcaddon/NfcAdapterAddon;->isBinded:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/lge/nfcaddon/NfcAdapterAddon;->mConfigMap:Ljava/util/HashMap;

    invoke-static {}, Lcom/lge/nfcaddon/NfcAdapterAddon;->getServiceAddonInterface()Lcom/lge/nfcaddon/INfcAdapterAddon;

    move-result-object v0

    sput-object v0, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    sget-object v0, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-nez v0, :cond_0

    const-string v0, "NfcAdapterAddon"

    const-string v1, "Error : Could not get NfcServiceAddon!!!"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    sput-boolean v0, Lcom/lge/nfcaddon/NfcAdapterAddon;->isBinded:Z

    :goto_0
    return-void

    :cond_0
    const/4 v0, 0x1

    sput-boolean v0, Lcom/lge/nfcaddon/NfcAdapterAddon;->isBinded:Z

    goto :goto_0
.end method

.method private getAdapterCardState(Z)I
    .locals 2
    .param p1, "flag"    # Z

    .prologue
    :try_start_0
    sget-object v1, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-eqz v1, :cond_0

    sget-object v1, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v1}, Lcom/lge/nfcaddon/INfcAdapterAddon;->getNfcCardState()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    if-eqz p1, :cond_0

    const/4 v1, 0x0

    invoke-direct {p0, v1}, Lcom/lge/nfcaddon/NfcAdapterAddon;->getAdapterCardState(Z)I

    move-result v1

    goto :goto_0

    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    const/16 v1, 0xb

    goto :goto_0
.end method

.method private getAdapterDiscoveryState(Z)I
    .locals 2
    .param p1, "flag"    # Z

    .prologue
    :try_start_0
    sget-object v1, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-eqz v1, :cond_0

    sget-object v1, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v1}, Lcom/lge/nfcaddon/INfcAdapterAddon;->getNfcDiscoveryState()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    if-eqz p1, :cond_0

    const/4 v1, 0x0

    invoke-direct {p0, v1}, Lcom/lge/nfcaddon/NfcAdapterAddon;->getAdapterDiscoveryState(Z)I

    move-result v1

    goto :goto_0

    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    const/16 v1, 0x15

    goto :goto_0
.end method

.method private getAdapterP2pState(Z)I
    .locals 2
    .param p1, "flag"    # Z

    .prologue
    :try_start_0
    sget-object v1, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-eqz v1, :cond_0

    sget-object v1, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v1}, Lcom/lge/nfcaddon/INfcAdapterAddon;->getNfcP2pState()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    if-eqz p1, :cond_0

    const/4 v1, 0x0

    invoke-direct {p0, v1}, Lcom/lge/nfcaddon/NfcAdapterAddon;->getAdapterP2pState(Z)I

    move-result v1

    goto :goto_0

    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    const/16 v1, 0x1f

    goto :goto_0
.end method

.method private getAdapterSysState(Z)I
    .locals 2
    .param p1, "flag"    # Z

    .prologue
    :try_start_0
    sget-object v1, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-eqz v1, :cond_0

    sget-object v1, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v1}, Lcom/lge/nfcaddon/INfcAdapterAddon;->getNfcSysState()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    if-eqz p1, :cond_0

    const/4 v1, 0x0

    invoke-direct {p0, v1}, Lcom/lge/nfcaddon/NfcAdapterAddon;->getAdapterSysState(Z)I

    move-result v1

    goto :goto_0

    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    const/16 v1, 0x29

    goto :goto_0
.end method

.method public static declared-synchronized getNfcAdapterAddon()Lcom/lge/nfcaddon/NfcAdapterAddon;
    .locals 3

    .prologue
    const-class v1, Lcom/lge/nfcaddon/NfcAdapterAddon;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/lge/nfcaddon/NfcAdapterAddon;->sNfcAdapterAddon:Lcom/lge/nfcaddon/NfcAdapterAddon;

    if-eqz v0, :cond_0

    sget-boolean v0, Lcom/lge/nfcaddon/NfcAdapterAddon;->isBinded:Z

    if-nez v0, :cond_1

    :cond_0
    new-instance v0, Lcom/lge/nfcaddon/NfcAdapterAddon;

    invoke-direct {v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;-><init>()V

    sput-object v0, Lcom/lge/nfcaddon/NfcAdapterAddon;->sNfcAdapterAddon:Lcom/lge/nfcaddon/NfcAdapterAddon;

    :cond_1
    sget-object v0, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-eqz v0, :cond_2

    sget-object v0, Lcom/lge/nfcaddon/NfcAdapterAddon;->sNfcAdapterAddon:Lcom/lge/nfcaddon/NfcAdapterAddon;

    if-nez v0, :cond_3

    :cond_2
    const-string v0, "NfcAdapterAddon"

    const-string v2, "Error : Could not create NFC Addon Service Interface or Adapter!"

    invoke-static {v0, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v0, 0x0

    :goto_0
    monitor-exit v1

    return-object v0

    :cond_3
    :try_start_1
    sget-object v0, Lcom/lge/nfcaddon/NfcAdapterAddon;->sNfcAdapterAddon:Lcom/lge/nfcaddon/NfcAdapterAddon;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private static getServiceAddonInterface()Lcom/lge/nfcaddon/INfcAdapterAddon;
    .locals 3

    .prologue
    const-string v1, "nfcaddon"

    invoke-static {v1}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v0

    .local v0, "binder":Landroid/os/IBinder;
    if-nez v0, :cond_0

    const-string v1, "NfcAdapterAddon"

    const-string v2, "nfcaddon binder null!!"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    sput-boolean v1, Lcom/lge/nfcaddon/NfcAdapterAddon;->isBinded:Z

    const/4 v1, 0x0

    :goto_0
    return-object v1

    :cond_0
    invoke-static {v0}, Lcom/lge/nfcaddon/INfcAdapterAddon$Stub;->asInterface(Landroid/os/IBinder;)Lcom/lge/nfcaddon/INfcAdapterAddon;

    move-result-object v1

    goto :goto_0
.end method


# virtual methods
.method public attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V
    .locals 3
    .param p1, "e"    # Ljava/lang/Exception;

    .prologue
    const-string v1, "NfcAdapterAddon"

    const-string v2, "NFC Addon service dead - attempting to recover"

    invoke-static {v1, v2, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    invoke-static {}, Lcom/lge/nfcaddon/NfcAdapterAddon;->getServiceAddonInterface()Lcom/lge/nfcaddon/INfcAdapterAddon;

    move-result-object v0

    .local v0, "serviceAddon":Lcom/lge/nfcaddon/INfcAdapterAddon;
    if-nez v0, :cond_0

    const-string v1, "NfcAdapterAddon"

    const-string v2, "could not retrieve NFC Addon service during service recovery"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_0
    sput-object v0, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    goto :goto_0
.end method

.method public checkFPRICRC()Z
    .locals 5

    .prologue
    const/4 v2, 0x1

    const/4 v3, 0x0

    :try_start_0
    const-string v4, "DefaultOnOffType"

    invoke-virtual {p0, v4}, Lcom/lge/nfcaddon/NfcAdapterAddon;->getNfcConfigureMap(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "defaultOnOffValue":Ljava/lang/String;
    if-nez v0, :cond_1

    .end local v0    # "defaultOnOffValue":Ljava/lang/String;
    :cond_0
    :goto_0
    return v3

    .restart local v0    # "defaultOnOffValue":Ljava/lang/String;
    :cond_1
    const-string v4, "off"

    invoke-virtual {v0, v4}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v4

    if-ltz v4, :cond_3

    invoke-virtual {p0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->isNfcSystemEnabled()Z

    move-result v4

    if-nez v4, :cond_2

    invoke-virtual {p0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->isNfcCardModeEnabled()Z

    move-result v4

    if-nez v4, :cond_2

    invoke-virtual {p0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->isNfcRwModeEnabled()Z

    move-result v4

    if-nez v4, :cond_2

    invoke-virtual {p0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->isNfcP2pModeEnabled()Z

    move-result v4

    if-nez v4, :cond_2

    :goto_1
    move v3, v2

    goto :goto_0

    :cond_2
    move v2, v3

    goto :goto_1

    :cond_3
    invoke-virtual {p0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->isNfcSystemEnabled()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-virtual {p0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->isNfcCardModeEnabled()Z

    move-result v4

    if-nez v4, :cond_4

    const-string v4, "card"

    invoke-virtual {v0, v4}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v4

    if-gez v4, :cond_0

    :cond_4
    invoke-virtual {p0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->isNfcRwModeEnabled()Z

    move-result v4

    if-nez v4, :cond_5

    const-string v4, "rw"

    invoke-virtual {v0, v4}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v4

    if-gez v4, :cond_0

    :cond_5
    invoke-virtual {p0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->isNfcP2pModeEnabled()Z

    move-result v4

    if-nez v4, :cond_6

    const-string v4, "p2p"

    invoke-virtual {v0, v4}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v4

    if-gez v4, :cond_0

    :cond_6
    move v3, v2

    goto :goto_0

    .end local v0    # "defaultOnOffValue":Ljava/lang/String;
    :catch_0
    move-exception v1

    .local v1, "e":Ljava/lang/Exception;
    goto :goto_0
.end method

.method public deinitNfcSystem()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    :try_start_0
    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-eqz v2, :cond_0

    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v2}, Lcom/lge/nfcaddon/INfcAdapterAddon;->deinitNfcSystem()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :cond_0
    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    goto :goto_0
.end method

.method public disableNfcCard()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    :try_start_0
    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-eqz v2, :cond_0

    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v2}, Lcom/lge/nfcaddon/INfcAdapterAddon;->disableNfcCard()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :cond_0
    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    goto :goto_0
.end method

.method public disableNfcDiscovery()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    :try_start_0
    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-eqz v2, :cond_0

    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v2}, Lcom/lge/nfcaddon/INfcAdapterAddon;->disableNfcDiscovery()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :cond_0
    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    goto :goto_0
.end method

.method public disableNfcP2p()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    :try_start_0
    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-eqz v2, :cond_0

    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v2}, Lcom/lge/nfcaddon/INfcAdapterAddon;->disableNfcP2p()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :cond_0
    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    goto :goto_0
.end method

.method public enableNfcCard()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    :try_start_0
    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-eqz v2, :cond_0

    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v2}, Lcom/lge/nfcaddon/INfcAdapterAddon;->enableNfcCard()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :cond_0
    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    goto :goto_0
.end method

.method public enableNfcDiscovery()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    :try_start_0
    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-eqz v2, :cond_0

    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v2}, Lcom/lge/nfcaddon/INfcAdapterAddon;->enableNfcDiscovery()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :cond_0
    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    goto :goto_0
.end method

.method public enableNfcP2p()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    :try_start_0
    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-eqz v2, :cond_0

    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v2}, Lcom/lge/nfcaddon/INfcAdapterAddon;->enableNfcP2p()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :cond_0
    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    goto :goto_0
.end method

.method public getAdapterCardState()I
    .locals 1

    .prologue
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->getAdapterCardState(Z)I

    move-result v0

    return v0
.end method

.method public getAdapterDiscoveryState()I
    .locals 1

    .prologue
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->getAdapterDiscoveryState(Z)I

    move-result v0

    return v0
.end method

.method public getAdapterP2pState()I
    .locals 1

    .prologue
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->getAdapterP2pState(Z)I

    move-result v0

    return v0
.end method

.method public getAdapterSysState()I
    .locals 1

    .prologue
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->getAdapterSysState(Z)I

    move-result v0

    return v0
.end method

.method public getCardEmulationAddonService()Lcom/lge/nfcaddon/CardEmulationAddon;
    .locals 4

    .prologue
    :try_start_0
    new-instance v1, Lcom/lge/nfcaddon/CardEmulationAddon;

    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v2}, Lcom/lge/nfcaddon/INfcAdapterAddon;->getCardEmulationInterface()Lcom/lge/nfcaddon/ICardEmulationAddon;

    move-result-object v2

    sget-object v3, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v3}, Lcom/lge/nfcaddon/INfcAdapterAddon;->getGsmaNfcControllerInterface()Lcom/lge/nfcaddon/IGsmaNfcController;

    move-result-object v3

    invoke-direct {v1, v2, v3, p0}, Lcom/lge/nfcaddon/CardEmulationAddon;-><init>(Lcom/lge/nfcaddon/ICardEmulationAddon;Lcom/lge/nfcaddon/IGsmaNfcController;Lcom/lge/nfcaddon/CardEmulationAddon$NfcAddonRecovery;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "NfcAdapterAddon"

    const-string v2, "getCardEmulationAddonService failed"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getCardEmulationAddonServiceInterface()Lcom/lge/nfcaddon/ICardEmulationAddon;
    .locals 4

    .prologue
    const/4 v1, 0x0

    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-nez v2, :cond_0

    :goto_0
    return-object v1

    :cond_0
    :try_start_0
    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v2}, Lcom/lge/nfcaddon/INfcAdapterAddon;->getCardEmulationInterface()Lcom/lge/nfcaddon/ICardEmulationAddon;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v2, "NfcAdapterAddon"

    const-string v3, "getCardEmulationAddonServiceInterface failed"

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method

.method public getGsmaNfcControllerService()Lcom/lge/nfcaddon/GsmaNfcController;
    .locals 3

    .prologue
    :try_start_0
    new-instance v1, Lcom/lge/nfcaddon/GsmaNfcController;

    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v2}, Lcom/lge/nfcaddon/INfcAdapterAddon;->getGsmaNfcControllerInterface()Lcom/lge/nfcaddon/IGsmaNfcController;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/lge/nfcaddon/GsmaNfcController;-><init>(Lcom/lge/nfcaddon/IGsmaNfcController;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "NfcAdapterAddon"

    const-string v2, "getGsmaNfcControllerService failed"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getGsmaNfcControllerService(Landroid/content/Context;)Lcom/lge/nfcaddon/GsmaNfcController;
    .locals 3
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    :try_start_0
    new-instance v1, Lcom/lge/nfcaddon/GsmaNfcController;

    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v2}, Lcom/lge/nfcaddon/INfcAdapterAddon;->getGsmaNfcControllerInterface()Lcom/lge/nfcaddon/IGsmaNfcController;

    move-result-object v2

    invoke-direct {v1, p1, v2, p0}, Lcom/lge/nfcaddon/GsmaNfcController;-><init>(Landroid/content/Context;Lcom/lge/nfcaddon/IGsmaNfcController;Lcom/lge/nfcaddon/GsmaNfcController$NfcAddonRecovery;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-object v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "NfcAdapterAddon"

    const-string v2, "getGsmaNfcControllerService failed"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getGsmaNfcControllerServiceInterface()Lcom/lge/nfcaddon/IGsmaNfcController;
    .locals 4

    .prologue
    const/4 v1, 0x0

    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-nez v2, :cond_0

    :goto_0
    return-object v1

    :cond_0
    :try_start_0
    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v2}, Lcom/lge/nfcaddon/INfcAdapterAddon;->getGsmaNfcControllerInterface()Lcom/lge/nfcaddon/IGsmaNfcController;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v2, "NfcAdapterAddon"

    const-string v3, "getGsmaNfcControllerServiceInterface failed"

    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method

.method public getNfcAddonPreference(I)Z
    .locals 4
    .param p1, "prefnumber"    # I

    .prologue
    const/4 v1, 0x0

    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-nez v2, :cond_0

    const-string v2, "NfcAdapterAddon"

    const-string v3, "Error : NFC Addon Interface is NULL!"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v1

    :cond_0
    :try_start_0
    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v2, p1}, Lcom/lge/nfcaddon/INfcAdapterAddon;->getNfcAddonPreference(I)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    goto :goto_0
.end method

.method public getNfcConfigureMap(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p1, "key"    # Ljava/lang/String;

    .prologue
    iget-object v2, p0, Lcom/lge/nfcaddon/NfcAdapterAddon;->mConfigMap:Ljava/util/HashMap;

    if-nez v2, :cond_0

    if-nez p1, :cond_0

    const-string v2, ""

    :goto_0
    return-object v2

    :cond_0
    iget-object v2, p0, Lcom/lge/nfcaddon/NfcAdapterAddon;->mConfigMap:Ljava/util/HashMap;

    invoke-virtual {v2, p1}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/lge/nfcaddon/NfcAdapterAddon;->mConfigMap:Ljava/util/HashMap;

    invoke-virtual {v2, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    goto :goto_0

    :cond_1
    :try_start_0
    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v2, p1}, Lcom/lge/nfcaddon/INfcAdapterAddon;->getNfcConfigureValue(Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .local v1, "retvalue":Ljava/lang/String;
    if-nez v1, :cond_2

    const-string v2, ""

    goto :goto_0

    .end local v1    # "retvalue":Ljava/lang/String;
    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    const-string v2, ""

    goto :goto_0

    .end local v0    # "e":Ljava/lang/Exception;
    .restart local v1    # "retvalue":Ljava/lang/String;
    :cond_2
    iget-object v2, p0, Lcom/lge/nfcaddon/NfcAdapterAddon;->mConfigMap:Ljava/util/HashMap;

    invoke-virtual {v2, p1, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-object v2, v1

    goto :goto_0
.end method

.method public getNfcConfigureMap(Ljava/lang/String;Ljava/lang/Object;)Z
    .locals 3
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;

    .prologue
    const/4 v2, 0x0

    if-nez p1, :cond_1

    if-nez p2, :cond_1

    :cond_0
    :goto_0
    return v2

    :cond_1
    invoke-virtual {p2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    .local v1, "valueString":Ljava/lang/String;
    invoke-virtual {p0, p1}, Lcom/lge/nfcaddon/NfcAdapterAddon;->getNfcConfigureMap(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "comparevalue":Ljava/lang/String;
    if-eqz v0, :cond_0

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    goto :goto_0
.end method

.method public getNfcInfo(I)Ljava/lang/String;
    .locals 4
    .param p1, "command"    # I

    .prologue
    const/4 v1, 0x0

    const-string v2, "NfcAdapterAddon"

    const-string v3, "getNfcInfo"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-nez v2, :cond_0

    const-string v2, "NfcAdapterAddon"

    const-string v3, "Error : NFC Addon Interface is NULL!"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-object v1

    :cond_0
    :try_start_0
    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v2, p1}, Lcom/lge/nfcaddon/INfcAdapterAddon;->getNfcInfo(I)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    goto :goto_0
.end method

.method public getServiceAddon()V
    .locals 1

    .prologue
    sget-object v0, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-nez v0, :cond_0

    invoke-static {}, Lcom/lge/nfcaddon/NfcAdapterAddon;->getServiceAddonInterface()Lcom/lge/nfcaddon/INfcAdapterAddon;

    move-result-object v0

    sput-object v0, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    :cond_0
    return-void
.end method

.method public initNfcSystem()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    :try_start_0
    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-eqz v2, :cond_0

    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v2}, Lcom/lge/nfcaddon/INfcAdapterAddon;->initNfcSystem()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :cond_0
    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    goto :goto_0
.end method

.method public isNfcCardModeEnabled()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    :try_start_0
    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-eqz v2, :cond_0

    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v2}, Lcom/lge/nfcaddon/INfcAdapterAddon;->isNfcCardModeEnabled()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :cond_0
    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    goto :goto_0
.end method

.method public isNfcP2pModeEnabled()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    :try_start_0
    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-eqz v2, :cond_0

    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v2}, Lcom/lge/nfcaddon/INfcAdapterAddon;->isNfcP2pModeEnabled()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :cond_0
    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    goto :goto_0
.end method

.method public isNfcRwModeEnabled()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    :try_start_0
    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-eqz v2, :cond_0

    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v2}, Lcom/lge/nfcaddon/INfcAdapterAddon;->isNfcRwModeEnabled()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :cond_0
    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    goto :goto_0
.end method

.method public isNfcSystemEnabled()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    :try_start_0
    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-eqz v2, :cond_0

    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v2}, Lcom/lge/nfcaddon/INfcAdapterAddon;->isNfcSystemEnabled()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :cond_0
    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    goto :goto_0
.end method

.method public isWirelessChargingModeOn()Z
    .locals 3

    .prologue
    const-string v1, "NfcAdapterAddon"

    const-string v2, "isWirelessChargingModeOn"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :try_start_0
    sget-object v1, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v1}, Lcom/lge/nfcaddon/INfcAdapterAddon;->isWirelessChargingModeOn()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public registerLGSharingResponseCallback(Ljava/lang/String;Lcom/lge/nfcaddon/ILGSharingMessageCallback;)Z
    .locals 2
    .param p1, "type"    # Ljava/lang/String;
    .param p2, "callback"    # Lcom/lge/nfcaddon/ILGSharingMessageCallback;

    .prologue
    :try_start_0
    sget-object v1, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v1, p1, p2}, Lcom/lge/nfcaddon/INfcAdapterAddon;->registerLGSharingResponseCallback(Ljava/lang/String;Lcom/lge/nfcaddon/ILGSharingMessageCallback;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public sendNfcTestCommand(I[B)Z
    .locals 4
    .param p1, "command"    # I
    .param p2, "response"    # [B

    .prologue
    const/4 v1, 0x0

    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-nez v2, :cond_0

    const-string v2, "NfcAdapterAddon"

    const-string v3, "Error : NFC Addon Interface is NULL!"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v1

    :cond_0
    :try_start_0
    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v2, p1, p2}, Lcom/lge/nfcaddon/INfcAdapterAddon;->sendNfcTestCommand(I[B)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    goto :goto_0
.end method

.method public setForceEnableMode(I)Z
    .locals 5
    .param p1, "mode"    # I

    .prologue
    const/4 v1, 0x0

    const-string v2, "NfcAdapterAddon"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "setForceEnableMode : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-nez v2, :cond_0

    const-string v2, "NfcAdapterAddon"

    const-string v3, "Error : NFC Addon Interface is NULL!"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v1

    :cond_0
    :try_start_0
    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v2, p1}, Lcom/lge/nfcaddon/INfcAdapterAddon;->setForceEnableMode(I)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    goto :goto_0
.end method

.method public setForceEnableMode(Z)Z
    .locals 5
    .param p1, "isEnabled"    # Z

    .prologue
    const/4 v1, 0x0

    const-string v2, "NfcAdapterAddon"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "setForceEnableMode : "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-nez v2, :cond_0

    const-string v2, "NfcAdapterAddon"

    const-string v3, "Error : NFC Addon Interface is NULL!"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v1

    :cond_0
    if-eqz p1, :cond_1

    :try_start_0
    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    const/16 v3, 0x2b

    invoke-interface {v2, v3}, Lcom/lge/nfcaddon/INfcAdapterAddon;->setForceEnableMode(I)Z

    move-result v1

    goto :goto_0

    :cond_1
    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    const/16 v3, 0x29

    invoke-interface {v2, v3}, Lcom/lge/nfcaddon/INfcAdapterAddon;->setForceEnableMode(I)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    goto :goto_0
.end method

.method public setLGSharingMode(Ljava/lang/String;[B)Z
    .locals 2
    .param p1, "type"    # Ljava/lang/String;
    .param p2, "payload"    # [B

    .prologue
    :try_start_0
    sget-object v1, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v1, p1, p2}, Lcom/lge/nfcaddon/INfcAdapterAddon;->setLGSharingMode(Ljava/lang/String;[B)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setNfcAddonPreference(IZ)Z
    .locals 4
    .param p1, "prefnumber"    # I
    .param p2, "prefvalue"    # Z

    .prologue
    const/4 v1, 0x0

    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-nez v2, :cond_0

    const-string v2, "NfcAdapterAddon"

    const-string v3, "Error : NFC Addon Interface is NULL!"

    invoke-static {v2, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return v1

    :cond_0
    :try_start_0
    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v2, p1, p2}, Lcom/lge/nfcaddon/INfcAdapterAddon;->setNfcAddonPreference(IZ)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    goto :goto_0

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    goto :goto_0
.end method

.method public setNfcPowerStatus(I)Z
    .locals 4
    .param p1, "status"    # I

    .prologue
    const-string v1, "NfcAdapterAddon"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "setNfcPowerStatus : "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :try_start_0
    sget-object v1, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v1, p1}, Lcom/lge/nfcaddon/INfcAdapterAddon;->setNfcPowerStatus(I)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    const/4 v1, 0x0

    goto :goto_0
.end method

.method public setPresentUid(I)V
    .locals 3
    .param p1, "id"    # I

    .prologue
    const-string v1, "NfcAdapterAddon"

    const-string v2, "setPresentUid"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :try_start_0
    sget-object v1, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v1, p1}, Lcom/lge/nfcaddon/INfcAdapterAddon;->setPresentUid(I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    goto :goto_0
.end method

.method public updateP2pState()Z
    .locals 3

    .prologue
    const/4 v1, 0x0

    :try_start_0
    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    if-eqz v2, :cond_0

    sget-object v2, Lcom/lge/nfcaddon/NfcAdapterAddon;->sServiceAddon:Lcom/lge/nfcaddon/INfcAdapterAddon;

    invoke-interface {v2}, Lcom/lge/nfcaddon/INfcAdapterAddon;->updateP2pState()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    :cond_0
    :goto_0
    return v1

    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {p0, v0}, Lcom/lge/nfcaddon/NfcAdapterAddon;->attemptDeadServiceAddonRecovery(Ljava/lang/Exception;)V

    goto :goto_0
.end method
