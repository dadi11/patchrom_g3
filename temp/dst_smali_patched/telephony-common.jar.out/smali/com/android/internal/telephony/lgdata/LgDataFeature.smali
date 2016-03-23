.class public Lcom/android/internal/telephony/lgdata/LgDataFeature;
.super Ljava/lang/Object;
.source "LgDataFeature.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/internal/telephony/lgdata/LgDataFeature$1;,
        Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;
    }
.end annotation


# static fields
.field public static final ACG:I = 0x20

.field public static final ATANDT:I = 0x4

.field public static final BELL:I = 0xc

.field public static final CLR:I = 0x13

.field public static final CMCC:I = 0x1b

.field public static final CTC:I = 0x1a

.field public static final CUCC:I = 0x1d

.field public static final DCM:I = 0x3

.field public static final DTAG:I = 0x18

.field public static final HKOPEN:I = 0x1e

.field public static final KDDI:I = 0x8

.field public static final KT:I = 0x5

.field public static final LGUPLUS:I = 0x2

.field static final LOG_TAG:Ljava/lang/String; = "LgDataFeature"

.field public static final LPP_FEATURE_TYPE_BOOLEAN:I = 0x0

.field public static final LPP_FEATURE_TYPE_BYTE:I = 0x6

.field public static final LPP_FEATURE_TYPE_CHAR:I = 0x7

.field public static final LPP_FEATURE_TYPE_DOUBLE:I = 0x5

.field public static final LPP_FEATURE_TYPE_FLOAT:I = 0x4

.field public static final LPP_FEATURE_TYPE_INTEGER:I = 0x1

.field public static final LPP_FEATURE_TYPE_LONG:I = 0x3

.field public static final LPP_FEATURE_TYPE_OBJECT:I = -0x1

.field public static final LPP_FEATURE_TYPE_SHORT:I = 0x2

.field public static final LPP_FEATURE_TYPE_STRING:I = 0x8

.field public static final MON:I = 0x11

.field public static final MPCS:I = 0x7

.field public static final MPDN_NOTSUPPORT:I = 0x0

.field public static final OPEN:I = 0xf

.field public static final ORG:I = 0x15

.field public static final RGS:I = 0xd

.field public static final SBM:I = 0x21

.field public static final SHB:I = 0x10

.field public static final SKT:I = 0x6

.field public static final SPCS:I = 0x9

.field private static final TAG_FEATURE:Ljava/lang/String; = "feature"

.field private static final TAG_FEATURE_ATTRIBUTE_LPP_NAME:Ljava/lang/String; = "name"

.field private static final TAG_FEATURE_ATTRIBUTE_LPP_TYPE:Ljava/lang/String; = "type"

.field private static final TAG_FEATURE_ATTRIBUTE_LPP_VALUE:Ljava/lang/String; = "value"

.field private static final TAG_ROOT:Ljava/lang/String; = "lpp"

.field private static final TAG_ROOT_ATTRIBUTE_MODEL:Ljava/lang/String; = "model"

.field private static final TAG_ROOT_ATTRIBUTE_OPERATOR:Ljava/lang/String; = "operator"

.field private static final TAG_ROOT_ATTRIBUTE_VERSION:Ljava/lang/String; = "version"

.field public static final TCL:I = 0x14

.field public static final TLF:I = 0x19

.field public static final TLS:I = 0xe

.field public static final TMUS:I = 0xb

.field public static final TRF_PP:I = 0x17

.field public static final USC:I = 0x1c

.field public static final VDF:I = 0xa

.field public static final VIV:I = 0x12

.field public static final VZW:I = 0x1

.field public static final VZW_LTE_PP:I = 0x1f

.field public static final VZW_PP:I = 0x16

.field private static final XML_FILENAME:Ljava/lang/String; = "lpp_data"

.field public static lgp_data_apn_mismatch_modem_ehrpd_apn_info_num:I

.field private static sFeatureSet:I

.field private static sLgDataFeature:Lcom/android/internal/telephony/lgdata/LgDataFeature;


# instance fields
.field public MPDNset:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    sput-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sLgDataFeature:Lcom/android/internal/telephony/lgdata/LgDataFeature;

    const/4 v0, 0x0

    sput v0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    const/4 v0, 0x5

    sput v0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->lgp_data_apn_mismatch_modem_ehrpd_apn_info_num:I

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;)V
    .locals 3
    .param p1, "featureset"    # Ljava/lang/String;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    const-string v0, "LgDataFeature"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "LgDataFeature() Constructor: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0, p1}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->setFeatureSet(Ljava/lang/String;)V

    const-string v0, "LgDataFeature"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "LgDataFeature() Constructor Done, "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sLgDataFeature:Lcom/android/internal/telephony/lgdata/LgDataFeature;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method synthetic constructor <init>(Ljava/lang/String;Lcom/android/internal/telephony/lgdata/LgDataFeature$1;)V
    .locals 0
    .param p1, "x0"    # Ljava/lang/String;
    .param p2, "x1"    # Lcom/android/internal/telephony/lgdata/LgDataFeature$1;

    .prologue
    invoke-direct {p0, p1}, Lcom/android/internal/telephony/lgdata/LgDataFeature;-><init>(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$002(Lcom/android/internal/telephony/lgdata/LgDataFeature;)Lcom/android/internal/telephony/lgdata/LgDataFeature;
    .locals 0
    .param p0, "x0"    # Lcom/android/internal/telephony/lgdata/LgDataFeature;

    .prologue
    sput-object p0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sLgDataFeature:Lcom/android/internal/telephony/lgdata/LgDataFeature;

    return-object p0
.end method

.method public static getFeatureSet()I
    .locals 1

    .prologue
    sget v0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    return v0
.end method

.method public static getInstance()Lcom/android/internal/telephony/lgdata/LgDataFeature;
    .locals 3

    .prologue
    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sLgDataFeature:Lcom/android/internal/telephony/lgdata/LgDataFeature;

    if-nez v0, :cond_0

    new-instance v0, Lcom/android/internal/telephony/lgdata/LgDataFeature;

    const-string v1, "ro.afwdata.LGfeatureset"

    const-string v2, "none"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/android/internal/telephony/lgdata/LgDataFeature;-><init>(Ljava/lang/String;)V

    sput-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sLgDataFeature:Lcom/android/internal/telephony/lgdata/LgDataFeature;

    :cond_0
    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sLgDataFeature:Lcom/android/internal/telephony/lgdata/LgDataFeature;

    return-object v0
.end method

.method private setFeatureSet(Ljava/lang/String;)V
    .locals 9
    .param p1, "featureset"    # Ljava/lang/String;

    .prologue
    const/4 v8, 0x6

    const/4 v7, 0x5

    const/4 v6, 0x2

    const/4 v5, 0x0

    const/4 v4, 0x1

    const-string v1, "VZWBASE"

    invoke-static {p1, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_2

    iput v4, p0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    sput v4, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_MODIFY_SPDN_PROCESS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_IMS_BLOCK_IMS_CONNECTION_TRY_FOR_15MIN_WHEN_CONNECT_FAIL:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_AIRPLANEMODE_DETACH:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_IMS_SEND_CONNECTIVITY_ACTION_ON_EVENT_CONFIGURATION_CHANGED_FOR_IPV6:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_IMS_RESET_PERMANENT_FAIL_ON_ROAMING:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_IMS_RETRY_NO_USE_PERMANENTFAIL_ON_AFW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PCSCF_INTERFACE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_AUTOPROFILE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v5}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_USE_DATA_ROAMING:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_SVLTE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_UNUSED_ISONLYSINGLEDCALLOWED:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_RIL_DEACTIVATE_DATA_CALL_PENDING_RECOVERY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_RIL_RESTART_ON_RILERROR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_RESET_DATA_CONNECTION_WHEN_DCTRACKER_DISPOSE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_DISCONNECT_ONLY_CHANGED_APN:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_EMERGENCY_CALL:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_SEND_DATA_ROAM_POPUP_INTENT_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TOOL_DATA_BLOCK_HIDDEN_MENU:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_KEEP_EMERGENCY_INFO_ON_PHONE_TYPE_CHANGED_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_NOTIFY_WHEN_IMS_APN_CHANGED_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_NOT_SEND_APNSYNC_WHEN_SINGLE_RAT_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_VZW_DATA_USAGE_DEFAULT_CONFIG_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_TRYSETUP_ANY_BEARER_FOR_GLOBAL_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TOOL_MODEM_TEST_MODE_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TETHER_STOP_RETRY_NI_NOT_AVAILABLE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATAUSAGE_TRAFFICSTATS_EXTENSIONS_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_SEND_NONE_APN_FOR_APN_SYNC_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_APN2_ENABLE_BACKUP_RESTORE_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_NODE_HANDLER_FOR_FOTA_SDM_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_BACKUP_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_SET_EST_CAUSE_FOR_EMERGENCY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_VZW_APN_RESTORE_TIME_SET_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_CHECK_EXEMPT_TYPE_TO_ADD_ROUTE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_MPDN_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_RECONN_NOT_ALLOWED_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_VZWAPP_CHECK_PERMISSION_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_IMS_DISABLE_ON_LEGACY_CDMA_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_RETRY_CONFIG_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_BLOCK_DATA_CALL_WHEN_ADMIN_PDN_DSIABLED_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_USER_DATA_MENU_CONTROL_ONLY_INTERNETAPN_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_BUGFIX_SETUP_DATACALL_ON_UNKNOWN_TECH:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_IMS_GET_MTU_FROM_NETWORK_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_BLOCK_DATA_WHEN_EMERGENCY_STATE_EXCEPT_EPDN_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_CLEAN_UP_WHEN_EMERGENCY_CALL_EXCEPT_IMS_EMERGENCY_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_NOT_DISCONNECT_IMS_EMERGENCY_WHEN_RECOVERY_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_VZWAPNE_AT_COMMAND_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    :cond_0
    :goto_0
    const-string v1, "persist.lg.data.load_feature"

    invoke-static {v1, v5}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->loadFeatures()V

    :cond_1
    return-void

    :cond_2
    const-string v1, "VZWBASE_PP"

    invoke-static {p1, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_3

    const/16 v1, 0x16

    sput v1, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    goto :goto_0

    :cond_3
    const-string v1, "TRFBASE_PP"

    invoke-static {p1, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_4

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LG_DATA_CDMA_DUMMY_APN:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATA_STALL_DNS_QUERY_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_BLOCK_DATA_CALL_AT_DEFAULT_MEID_ESN:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_UNUSED_ISONLYSINGLEDCALLOWED:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_NO_SIM_CDMA_DATA_CALL_SEND:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_BLOCK_APP_REQUEST_WHEN_USER_DATA_DISABLED:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TOOL_DATA_BLOCK_HIDDEN_MENU:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_VZW_APN_RESTORE_TIME_SET_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_IMS_DISABLE_ON_LEGACY_CDMA_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_SEND_DATA_ROAM_POPUP_INTENT_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_BUGFIX_SETUP_DATACALL_ON_UNKNOWN_TECH:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATAUSAGE_TRAFFICSTATS_EXTENSIONS_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_RETRY_CONFIG_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_VZW_DATA_USAGE_DEFAULT_CONFIG_VZW:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_AIRPLANEMODE_DETACH:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    const/16 v1, 0x17

    sput v1, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    goto :goto_0

    :cond_4
    const-string v1, "ATTBASE"

    invoke-static {p1, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_5

    const/4 v1, 0x4

    iput v1, p0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    sput v1, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TCPIP_KEEP_SOCKET_ON_SUSPEND:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_SMCAUSE_NOTIFY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_QOS_NOTIFY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_DISABLE_PROTOCOL_UI:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_HANDLE_SUPL_WITH_DEFAULT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v5}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_CHECK_EXEMPT_TYPE_TO_ADD_ROUTE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_SENDMMS_ON_DATAROAMINGDISABLED:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_IGNORE_CHECKSUM_OF_APNXML:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_SIGNAL_STRENTH_TYPE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_REMOVE_INTERNET_CAPABILITY_IF_DATA_DISABLED:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_BLOCK_MOBILE_PROVISIONING_ALWAYS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_LG_DATA_RECOVERY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    const-string v2, "persist.lg.data.recovery"

    invoke-static {v2, v4}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DEBUG_ENABLE_PRIVACY_LOG:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    const-string v2, "persist.service.privacy.enable"

    invoke-static {v2, v5}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PSRETRY_AFTER_DETACH_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_ENABLE_CLAT_FOR_DEFAULT_ONLY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_MERGE_SKIP_SAME_TYPE_CHECK:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_KEEP_PREFERAPN:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TETHER_SUPPORT_IPV4_TETHER_WITH_CLAT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TCPIP_DNS_RETRANSMISSION_ATT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_IMS_SET_TO_DEFAULT_HIDDENMENU_ATT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_DATA_USAGE_DEFAULT_CONFIG_ATT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TCPIP_DNS_AVOID_UNEXPECTED_QUERY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_MMS_TYPE_BLOCK_ATT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_ALLOW_HIPRI_ON_PREFERRED_APN_ONLY_ATT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DOMESTIC_INTERNATIONAL_DATAMENU_ATT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_BACKUP:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_SECRECTCODE_ATT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATARECOVERY_HIDDENMENU_ATT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    const-string v1, "true"

    const-string v2, "persist.lg.data.IMSSupport"

    invoke-static {v2, v5}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PCSCF_INTERFACE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_EMERGENCY_CALL:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_ADD_XCAP_TYPE_RGS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGE_DATA_IMS_ISIM_REFRESH_ATT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_IMS_EMERGENCY_APN_SYNC:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_ATT_IMS_DAM:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_ALLOW_XCAPTYPE_ON_DATADISABLED:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_IMS_PCSCF_RESTORATION:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_IMS_DELAY_CLEANUP_FOR_DEREGISTRATION_ATT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_USER_DATA_MENU_CONTROL_ONLY_ATT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    goto/16 :goto_0

    :cond_5
    const-string v1, "TMUSBASE"

    invoke-static {p1, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_6

    const/16 v1, 0xb

    iput v1, p0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    sput v1, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TETHER_IPV6_SUPPORT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TCPIP_KEEP_SOCKET_ON_SUSPEND:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PCSCF_INTERFACE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_IMS_PCSCF_RESTORATION:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_SMCAUSE_NOTIFY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_QOS_NOTIFY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_EMERGENCY_CALL:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_ROAMING_POPUP_TMUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_CIQ_TMUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    const-string v2, "persist.lgiqc.ext"

    invoke-static {v2, v5}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_LG_DATA_RECOVERY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    const-string v2, "persist.lg.data.recovery"

    invoke-static {v2, v4}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_KEEP_USERAPN_AND_PREFERAPN:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_KEEP_PREFERAPN:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_IGNORE_CHECKSUM_OF_APNXML:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATAUSAGE_WARNINGBYTE_TMUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TETHER_REMOVE_WIFI_UPSTREAM_TMUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DEBUG_ENABLE_PRIVACY_LOG_TMUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    const-string v2, "persist.service.privacy.enable"

    invoke-static {v2, v5}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DEBUG_ENABLE_PRIVACY_LOG:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    const-string v2, "persist.service.privacy.enable"

    invoke-static {v2, v5}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_CHECK_EXEMPT_TYPE_TO_ADD_ROUTE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_BLOCK_MOBILE_PROVISIONING_ALWAYS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    goto/16 :goto_0

    :cond_6
    const-string v1, "BELLBASE"

    invoke-static {p1, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_7

    const/16 v1, 0xc

    sput v1, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    goto/16 :goto_0

    :cond_7
    const-string v1, "RGSBASE"

    invoke-static {p1, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_8

    const/16 v1, 0xd

    sput v1, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    goto/16 :goto_0

    :cond_8
    const-string v1, "TLSBASE"

    invoke-static {p1, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_9

    const/16 v1, 0xe

    sput v1, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    goto/16 :goto_0

    :cond_9
    const-string v1, "SKTBASE"

    invoke-static {p1, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_c

    sput v8, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    iput v8, p0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    sput v8, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_RIL_RESTART_ON_RILERROR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_LG_DATA_RECOVERY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    const-string v2, "persist.lg.data.recovery"

    invoke-static {v2, v4}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_MANUALSEARCH:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PSRETRY_NOTAPPLIED_ON_DEFAULT_USERDATADISABLE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v5}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TCPIP_DNS_MPDN:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_CHECK_EXEMPT_TYPE_TO_ADD_ROUTE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_RIL_DEACTIVATE_DATA_CALL_PENDING_RECOVERY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_NOTBROADCAST_BUTAPI_INBOOT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_AIRPLANEMODE_DETACH:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PCSCF_INTERFACE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_BLOCK_MOBILE_PROVISIONING:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_IMS_HIDE_NETWORKINTERFACE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_ENABLE_CLAT_FOR_DEFAULT_ONLY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_SETPOLICYDATAENABLE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_IMS_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_SELECT_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_MAINTAIN_USER_DATA_SETTING:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_BLOCK_PAYPOPUP_AND_TRYSETUP:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_BLOCK_PAYPOPUP_BUT_TRYSETUP:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_CONNECTIVITYSERVICE_NETSEARCH:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_PAYPOPUP_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_PAYPOPUP_ROAMING_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_VOICE_PROTECTION_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_APNSYNC_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_NOTI_USERDATADISABLE_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATAUSAGE_CONFIG_LIMIT_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_CONNECTIVITYSERVICE_ADD_RT_API_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_FAST_CONNECT_DEFAULT_PDN_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v5}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PSRETRY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_LGONESOURCE_FROM_ORIGINAL:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DEBUG_SET_MOBILE_DATA_ENABLED:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PSRETRY_ON_SCREENON:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DISPLAY_IP_MPDN_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_DATA_USAGE_DEFAULT_CONFIG_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_CONNECTIVITYSERVICE_DELETE_UID_LOCK:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    iput v5, p0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PERMANENT_FAIL_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_ENHANCE_ROAMING_CHECK_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_NOTSHOW_PAYPOPUP_BEFORE_BOOTCOMPLETE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_HANDLE_DATA_INTERFACE_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_MMS_APN_MENU_NOT_CONRTOL:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PSRETRY_AFTER_DETACH_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_USIM_MOBILITY_FOR_TETHERING:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_UPDATE_ISAVAILABLE_FOR_MMS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    const-string v1, "true"

    const-string v2, "persist.lg.data.usim_mobility"

    const-string v3, "false"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_a

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_USIM_MOBILITY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_EMERGENCY_CALL:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    :cond_a
    const-string v1, "true"

    const-string v2, "ro.support_mpdn"

    const-string v3, "true"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_b

    iput v8, p0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_MPDN_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    :cond_b
    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_GPRS_REJECTED_SKT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_PAYPOPUP_SKT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_PAYPOPUP_ROAMING_SKT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DORMANT_FD_VOICE_5SEC_DELAY_SKT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_SIGNAL_STRENTH_TYPE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_PAYPOPUP_ROAMING_SKT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_ADD_PDN_RESET_API_SKT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_CONNECTIVITYSERVICE_DUN_TYPE_TIMER_SKT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATAUSAGE_DISABLE_BACKGROUND_SKT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_MODE_CHANGE_NT_MODE_WCDMA_PREF_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATAUSAGE_CONFIG_WARNING_VALUE_SKT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TETHER_SUPPORT_IPV4_TETHER_WITH_CLAT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TETHER_IPV6_SUPPORT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    goto/16 :goto_0

    :cond_c
    const-string v1, "KTBASE"

    invoke-static {p1, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_f

    sput v7, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    iput v7, p0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    sput v7, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_LG_DATA_RECOVERY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    const-string v2, "persist.lg.data.recovery"

    invoke-static {v2, v4}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_RIL_RESTART_ON_RILERROR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_MANUALSEARCH:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PSRETRY_NOTAPPLIED_ON_DEFAULT_USERDATADISABLE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v5}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TCPIP_DNS_MPDN:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_CHECK_EXEMPT_TYPE_TO_ADD_ROUTE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_RIL_DEACTIVATE_DATA_CALL_PENDING_RECOVERY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_NOTBROADCAST_BUTAPI_INBOOT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_AIRPLANEMODE_DETACH:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PCSCF_INTERFACE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_BLOCK_MOBILE_PROVISIONING:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_IMS_HIDE_NETWORKINTERFACE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_ENABLE_CLAT_FOR_DEFAULT_ONLY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_SETPOLICYDATAENABLE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_IMS_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_MAINTAIN_USER_DATA_SETTING:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_BLOCK_PAYPOPUP_AND_TRYSETUP:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_BLOCK_PAYPOPUP_BUT_TRYSETUP:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_CONNECTIVITYSERVICE_NETSEARCH:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_PAYPOPUP_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_PAYPOPUP_ROAMING_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_APNSYNC_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_NOTI_USERDATADISABLE_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATAUSAGE_CONFIG_LIMIT_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_FAST_CONNECT_DEFAULT_PDN_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v5}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PSRETRY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_LGONESOURCE_FROM_ORIGINAL:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DEBUG_SET_MOBILE_DATA_ENABLED:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PSRETRY_ON_SCREENON:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DISPLAY_IP_MPDN_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_CONNECTIVITYSERVICE_DELETE_UID_LOCK:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    iput v5, p0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PERMANENT_FAIL_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_DATA_USAGE_DEFAULT_CONFIG_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_ENHANCE_ROAMING_CHECK_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_NOTSHOW_PAYPOPUP_BEFORE_BOOTCOMPLETE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_HANDLE_DATA_INTERFACE_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_MMS_APN_MENU_NOT_CONRTOL:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PSRETRY_AFTER_DETACH_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_USIM_MOBILITY_FOR_TETHERING:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_UPDATE_ISAVAILABLE_FOR_MMS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    const-string v1, "true"

    const-string v2, "persist.lg.data.usim_mobility"

    const-string v3, "false"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_d

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_USIM_MOBILITY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_EMERGENCY_CALL:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    :cond_d
    const-string v1, "true"

    const-string v2, "ro.support_mpdn"

    const-string v3, "true"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_e

    iput v7, p0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_MPDN_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_SELECT_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    :cond_e
    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_MODE_CHANGE_NT_MODE_WCDMA_PREF_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_MODECHANGE_KT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_LTE_ROAMING_KT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATAUSAGE_CONFIG_WARNING_VALUE_KT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_PAYPOPUP_ROAMING_KT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_PAYPOPUP_KT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_GPRS_REJECTED:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_CONNECTIVITYSERVICE_KAF_KT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_SIGNAL_STRENTH_TYPE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TCPIP_IPV6_SUPPORT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    goto/16 :goto_0

    :cond_f
    const-string v1, "LGTBASE"

    invoke-static {p1, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_12

    sput v6, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    iput v6, p0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    sput v6, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    const/4 v0, 0x0

    .local v0, "isSVLTE":I
    const-string v1, "telephony.lteOnCdmaDevice"

    invoke-static {v1, v5}, Landroid/os/SystemProperties;->getInt(Ljava/lang/String;I)I

    move-result v0

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_BLOCK_CREATE_CDMADATACONNECTIONTRACKER:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_AIRPLANEMODE_DETACH:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_RIL_RESTART_ON_RILERROR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_LG_DATA_RECOVERY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    const-string v2, "persist.lg.data.recovery"

    invoke-static {v2, v4}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_MANUALSEARCH:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_GPRS_REJECTED:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PSRETRY_NOTAPPLIED_ON_DEFAULT_USERDATADISABLE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v5}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TCPIP_DNS_MPDN:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_CHECK_EXEMPT_TYPE_TO_ADD_ROUTE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_RIL_DEACTIVATE_DATA_CALL_PENDING_RECOVERY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_NOTBROADCAST_BUTAPI_INBOOT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PCSCF_INTERFACE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_EMERGENCY_CALL:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_BLOCK_MOBILE_PROVISIONING:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_IMS_HIDE_NETWORKINTERFACE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_ENABLE_CLAT_FOR_DEFAULT_ONLY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_SETPOLICYDATAENABLE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_IMS_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_SELECT_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_MAINTAIN_USER_DATA_SETTING:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_BLOCK_PAYPOPUP_AND_TRYSETUP:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_BLOCK_PAYPOPUP_BUT_TRYSETUP:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_CONNECTIVITYSERVICE_NETSEARCH:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_PAYPOPUP_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_PAYPOPUP_ROAMING_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_APNSYNC_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_NOTI_USERDATADISABLE_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATAUSAGE_CONFIG_LIMIT_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_FAST_CONNECT_DEFAULT_PDN_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v5}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PSRETRY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_LGONESOURCE_FROM_ORIGINAL:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DEBUG_SET_MOBILE_DATA_ENABLED:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PSRETRY_ON_SCREENON:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DISPLAY_IP_MPDN_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_DATA_USAGE_DEFAULT_CONFIG_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_CONNECTIVITYSERVICE_DELETE_UID_LOCK:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    iput v5, p0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PERMANENT_FAIL_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_ENHANCE_ROAMING_CHECK_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_NOTSHOW_PAYPOPUP_BEFORE_BOOTCOMPLETE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_HANDLE_DATA_INTERFACE_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PSRETRY_AFTER_DETACH_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_USIM_MOBILITY_FOR_TETHERING:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_BLOCK_APP_REQUEST_WHEN_USER_DATA_DISABLED:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_UPDATE_ISAVAILABLE_FOR_MMS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    const-string v1, "true"

    const-string v2, "persist.lg.data.usim_mobility"

    const-string v3, "false"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_10

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_USIM_MOBILITY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    :cond_10
    const-string v1, "true"

    const-string v2, "ro.support_mpdn"

    const-string v3, "true"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_11

    iput v6, p0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_MPDN_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_MPDN_UPLUS_INIT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    :cond_11
    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_MODE_CHANGE_NT_MODE_WCDMA_PREF_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_LTE_ROAMING_LGU:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PCSCF_ON_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_LOCK_ORDER_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_TOAST_ON_WIFI_OFF_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_SIGNAL_STRENTH_TYPE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_REJECT_INTENT_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_BLOCK_1XEVDO_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_LOCK_ORDER_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v5}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_CONNECTIVITYSERVICE_HIPRI_TYPE_TIMER_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_SUPPORT_NSWO_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_BACKGROUND_DATA_NOTI_IN_AIRPLANE_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_REJECT_ODB_REATTACH_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_OTA_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TCPIP_SLAAC_IPV6_ALLOCATION_BOOSTER:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_BUGFIX_IPV6_ADDRCONF_KERNEL_CRASH:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TCPIP_IPV6_MTU:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DISCONNECT_DEFAULT_PDN_WITHOUT_DNS_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UNPAID_NOTIFICATION_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_REMOVE_BACKGROUND_RESTRICT_NOTI_ON_ROAMING_NO_SVC_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    if-ne v0, v4, :cond_0

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_LTE_ROAMING_LGU:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v5}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_LOCK_ORDER_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_BLOCK_1XEVDO_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_OTA_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v5}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TCPIP_SLAAC_IPV6_ALLOCATION_BOOSTER:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v5}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_BUGFIX_IPV6_ADDRCONF_KERNEL_CRASH:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v5}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_EMERGENCY_CALL:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v5}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_BLOCK_CREATE_CDMADATACONNECTIONTRACKER:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v5}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DISCONNECT_DEFAULT_PDN_WITHOUT_DNS_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UNPAID_NOTIFICATION_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_REMOVE_BACKGROUND_RESTRICT_NOTI_ON_ROAMING_NO_SVC_UPLUS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    goto/16 :goto_0

    .end local v0    # "isSVLTE":I
    :cond_12
    const-string v1, "DCMBASE"

    invoke-static {p1, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_13

    const/4 v1, 0x3

    sput v1, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    goto/16 :goto_0

    :cond_13
    const-string v1, "MPCSBASE"

    invoke-static {p1, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_14

    const/4 v1, 0x7

    sput v1, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    goto/16 :goto_0

    :cond_14
    const-string v1, "KDDIBASE"

    invoke-static {p1, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_15

    const/16 v1, 0x8

    sput v1, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    goto/16 :goto_0

    :cond_15
    const-string v1, "SPCSBASE"

    invoke-static {p1, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_18

    const/16 v1, 0x9

    iput v1, p0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    sput v1, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_SIGNAL_STRENTH_TYPE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TETHER_IPV6_SUPPORT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_AIRPLANEMODE_DETACH:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_BUGFIX_SETUP_DATACALL_ON_UNKNOWN_TECH:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DEBUG_RIL_CONN_HISTORY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TCPIP_KEEP_SOCKET_ON_SUSPEND:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_RIL_DEACTIVATE_DATA_CALL_PENDING_RECOVERY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_UNUSED_ISONLYSINGLEDCALLOWED:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_BLOCK_MOBILE_PROVISIONING_ALWAYS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_SYNC_ONLY_CHANGED:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_BACKUP:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    const-string v1, "user"

    sget-object v2, Landroid/os/Build;->TYPE:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_16

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DEBUG_ENABLE_PRIVACY_LOG:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    const-string v2, "persist.service.privacy.enable"

    invoke-static {v2, v5}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    :cond_16
    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_UPDATE_ISAVAILABLE_FOR_MMS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_GSM_GLOBAL_PREFERED_APN_SPRINT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_HANDLE_MMS_WITH_DEFAULT_SPRINT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TETHER_SEND_INTENT_ON_DUN_FAILURE_SPRINT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_FAIL_ICON_DISPLAY_SPRINT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_CHECK_PROFILE_DB_EXTENSION_SPRINT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_INACTIVETIEMR_SPRINT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TCPIP_MTU_SET_SYSTEM_PROPERTIES_SPRINT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_BLOCK_DATA_CALL_ON_DEFAULT_MEID_ESN_SPRINT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATAUSAGE_CONFIG_WARNING_VALUE_SPRINT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_OMADM_BLOCK_SETUP_DATA_CALL_SPRINT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_AUTH_MIP_ERROR_NOTIFICATION_FOR_POPUP_SPRINT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_GET_APNLIST_FOR_SLATE_SPRINT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_HIDDENMENU_BLOCK_DUMMY_TYPE_APN_DISPLAYING_SPRINT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_ADD_CDMA_DUMMY_APN_SPRINT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_SYNC_MPDN_SPRINT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_HANDLE_IA_TYPE_SPRINT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_SELECT_TETHERING_PDN_SPRINT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_USE_FIRST_SIM_OPERRATOR_NUMERIC:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_UPDATE_MMS_INFO_FROM_NV:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_HIDDENMENU_APN_RESTORE_TIMER_EXTEND:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    const-string v1, "true"

    const-string v2, "persist.lg.data.non_csim"

    const-string v3, "false"

    invoke-static {v2, v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_17

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_NO_SIM_CDMA_DATA_CALL_SEND:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    :cond_17
    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_OMADM_SPRINT_EXTENSION_TO_CONTROL_DATA_CONNECTION_SPRINT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    goto/16 :goto_0

    :cond_18
    const-string v1, "USCBASE"

    invoke-static {p1, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_19

    const/16 v1, 0x1c

    iput v1, p0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    sput v1, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_MMS_IS_NOT_RETRIEVED_AFTER_VOICECALL_END_WHEN_WIFION:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TCPIP_TCP_WINDOW_SCALING_USC:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_APNSYNC_USC:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    goto/16 :goto_0

    :cond_19
    const-string v1, "SHBBASE"

    invoke-static {p1, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1a

    const/16 v1, 0x10

    sput v1, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    goto/16 :goto_0

    :cond_1a
    const-string v1, "MONBASE"

    invoke-static {p1, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1b

    const/16 v1, 0x11

    sput v1, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    goto/16 :goto_0

    :cond_1b
    const-string v1, "CMCCBASE"

    invoke-static {p1, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1c

    const/16 v1, 0x1b

    sput v1, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_CONNECTIVITYSERVICE_CTTL_CMCC:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TETHER_IPV6_SUPPORT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TCPIP_KEEP_SOCKET_ON_SUSPEND:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_HANDLE_SUPL_WITH_DEFAULT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v5}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_SYNC_NOT_ALLOW_BEFORE_SIM_LOADED:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_SYNC_ONLY_SLOT1:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_LG_DATA_RECOVERY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    const-string v2, "persist.lg.data.recovery"

    invoke-static {v2, v4}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    invoke-virtual {v1, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_BLOCK_MOBILE_PROVISIONING_ALWAYS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    goto/16 :goto_0

    :cond_1c
    const-string v1, "CTCBASE"

    invoke-static {p1, v1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1d

    const/16 v1, 0x1a

    sput v1, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    goto/16 :goto_0

    :cond_1d
    const/16 v1, 0xf

    iput v1, p0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    sput v1, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    invoke-direct {p0}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->setGlobalCommonFeatureSet()V

    sget-object v1, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_XXXX_YYYYY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v1, v5}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    goto/16 :goto_0
.end method

.method private setGlobalCommonFeatureSet()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/4 v2, 0x1

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_MATCH_PROTOCOL_TYPE_OF_IA_WITH_DEFAULT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TETHER_IPV6_SUPPORT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TCPIP_KEEP_SOCKET_ON_SUSPEND:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_ADD_RCS_TYPE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TETHER_BLOCK_GOOGLE_DNS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_REDEFINE_PERMANENT_CAUSE_EU:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_IGNORE_CHECKSUM_OF_APNXML:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_DATA_USAGE_DEFAULT_CONFIG_OPEN:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_KEEP_USERAPN_AND_PREFERAPN:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_CHECK_EXEMPT_TYPE_TO_ADD_ROUTE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TETHER_SUPPORT_IPV4_TETHER_WITH_CLAT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PSRETRY_AFTER_DETACH_KR:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_REDIAL_FOR_NO_CAUSE_CODE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_SMCAUSE_NOTIFY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_QOS_NOTIFY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_PDN_EMERGENCY_CALL:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_IMS_PCSCF_RESTORATION:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_ADD_XCAP_TYPE_RGS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_ALLOW_XCAPTYPE_ON_DATADISABLED:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_IMS_SET_TO_DEFAULT_HIDDENMENU_ATT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PCSCF_INTERFACE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_ENABLE_CLAT_FOR_DEFAULT_ONLY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_REMOVE_INTERNET_CAPABILITY_IF_DATA_DISABLED:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_BLOCK_MOBILE_PROVISIONING:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_UPDATE_ISAVAILABLE_FOR_MMS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_ENHANCED_DUAL_CONNECTIVITY_HANDLING:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v3}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_KEEP_PREFERAPN:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_MERGE_IGNORE_TYPE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_VALIDATE_SUBID:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_LEGACY_FAST_DORMANCY_OFF:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_USER_SELECTION_SCEANARIO_EU:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_NATIONAL_ROAMING:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_SENDMMS_ON_DATAROAMINGDISABLED:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_LG_DATA_RECOVERY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    const-string v1, "persist.lg.data.recovery"

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_ENABLE_DUAL_APN:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_SIM_MSIM_BLOCK_DATA_ENABLED_CHANGE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_NETD_CLATD_RECONFIGURATION:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TETHER_STOP_RETRY_NI_NOT_AVAILABLE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_ALLOW_MULTIPLE_MMS_APN_EXCEPTION_CASE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PCSCF_INTERFACE_FOR_IA_TYPE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    const-string v1, "ro.lge.supportvolte"

    invoke-static {v1, v3}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    const-string v0, "mtk"

    const-string v1, "ro.lge.chip.vendor"

    const-string v2, ""

    invoke-static {v1, v2}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->setGlobalCommonFeatureSetForMTK()V

    :cond_0
    return-void
.end method

.method private setGlobalCommonFeatureSetForMTK()V
    .locals 2

    .prologue
    const/4 v1, 0x1

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_EVN_MODIFICATION_FOR_LAMP_JOIN_FOR_MTK:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_UIAPP_MSIM_NOTIFY_DDS_CHANGED_ON_ATTACHED_MTK:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_START_CLATD_ON_PREFIX_RECEIVED_FOR_MTK:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TETHER_DELIVERY_DNS_AS_USING_RDNSS_OPTION:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_ENV_MODIFICATION_BY_MTK:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0, v1}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->setValue(Z)V

    return-void
.end method

.method private writeFeatureAttribute(Lorg/xmlpull/v1/XmlSerializer;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "serializer"    # Lorg/xmlpull/v1/XmlSerializer;
    .param p2, "name"    # Ljava/lang/String;
    .param p3, "type"    # Ljava/lang/String;
    .param p4, "value"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    if-eqz p2, :cond_0

    const-string v0, "LGP_DATA"

    invoke-virtual {p2, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    :cond_0
    const-string v0, "LgDataFeature"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "writeFeatureAttribute(): Not LPP Data Feature: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void

    :cond_1
    const-string v0, "    "

    invoke-interface {p1, v0}, Lorg/xmlpull/v1/XmlSerializer;->text(Ljava/lang/String;)Lorg/xmlpull/v1/XmlSerializer;

    const-string v0, "feature"

    invoke-interface {p1, v1, v0}, Lorg/xmlpull/v1/XmlSerializer;->startTag(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/XmlSerializer;

    const-string v0, "name"

    invoke-interface {p1, v1, v0, p2}, Lorg/xmlpull/v1/XmlSerializer;->attribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/XmlSerializer;

    const-string v0, "type"

    invoke-interface {p1, v1, v0, p3}, Lorg/xmlpull/v1/XmlSerializer;->attribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/XmlSerializer;

    const-string v0, "value"

    invoke-interface {p1, v1, v0, p4}, Lorg/xmlpull/v1/XmlSerializer;->attribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/XmlSerializer;

    const-string v0, "feature"

    invoke-interface {p1, v1, v0}, Lorg/xmlpull/v1/XmlSerializer;->endTag(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/XmlSerializer;

    const-string v0, "\n"

    invoke-interface {p1, v0}, Lorg/xmlpull/v1/XmlSerializer;->text(Ljava/lang/String;)Lorg/xmlpull/v1/XmlSerializer;

    goto :goto_0
.end method


# virtual methods
.method public deleteFeatureFile()V
    .locals 5

    .prologue
    const/4 v0, 0x0

    .local v0, "XML_FILE_PATH":Ljava/io/File;
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v0

    new-instance v1, Ljava/io/File;

    const-string v3, "lpp_data.xml"

    invoke-direct {v1, v0, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .local v1, "file":Ljava/io/File;
    :try_start_0
    invoke-virtual {v1}, Ljava/io/File;->delete()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    return-void

    :catch_0
    move-exception v2

    .local v2, "ioe":Ljava/lang/Exception;
    const-string v3, "LgDataFeature"

    const-string v4, "deleteFeatureFile(): Error to delte file - lpp_data.xml"

    invoke-static {v3, v4, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method

.method public getAllFeatureNames()[Ljava/lang/String;
    .locals 8

    .prologue
    const-class v7, Lcom/android/internal/telephony/lgdata/LgDataFeature;

    invoke-virtual {v7}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;

    move-result-object v4

    .local v4, "lgFeagureFields":[Ljava/lang/reflect/Field;
    new-instance v6, Ljava/util/ArrayList;

    array-length v7, v4

    add-int/lit8 v7, v7, 0x1

    invoke-direct {v6, v7}, Ljava/util/ArrayList;-><init>(I)V

    .local v6, "ret":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    const/4 v5, 0x0

    .local v5, "name":Ljava/lang/String;
    move-object v0, v4

    .local v0, "arr$":[Ljava/lang/reflect/Field;
    array-length v3, v0

    .local v3, "len$":I
    const/4 v2, 0x0

    .local v2, "i$":I
    :goto_0
    if-ge v2, v3, :cond_1

    aget-object v1, v0, v2

    .local v1, "field":Ljava/lang/reflect/Field;
    invoke-virtual {v1}, Ljava/lang/reflect/Field;->getName()Ljava/lang/String;

    move-result-object v5

    if-eqz v5, :cond_0

    const-string v7, "LGP_DATA"

    invoke-virtual {v5, v7}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_0

    invoke-virtual {v1}, Ljava/lang/reflect/Field;->getName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .end local v1    # "field":Ljava/lang/reflect/Field;
    :cond_1
    const/4 v7, 0x0

    new-array v7, v7, [Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v7

    check-cast v7, [Ljava/lang/String;

    check-cast v7, [Ljava/lang/String;

    return-object v7
.end method

.method public getBooleanFeatureValue(Ljava/lang/String;)Z
    .locals 7
    .param p1, "featureName"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x0

    .local v3, "ret":Z
    :try_start_0
    const-class v4, Lcom/android/internal/telephony/lgdata/LgDataFeature;

    invoke-virtual {v4, p1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    .local v1, "field":Ljava/lang/reflect/Field;
    invoke-virtual {v1}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Class;->isPrimitive()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-virtual {v1}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v4

    sget-object v5, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    invoke-virtual {v4, v5}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-virtual {v1, p0}, Ljava/lang/reflect/Field;->getBoolean(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/NoSuchFieldException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    move-result v3

    .end local v1    # "field":Ljava/lang/reflect/Field;
    :cond_0
    :goto_0
    return v3

    :catch_0
    move-exception v2

    .local v2, "nsfe":Ljava/lang/NoSuchFieldException;
    const-string v4, "LgDataFeature"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "getBooleanFeatureValue(): There is no such field "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v2    # "nsfe":Ljava/lang/NoSuchFieldException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v4, "LgDataFeature"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "getBooleanFeatureValue(): Exception found for "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method

.method public getFeatureValue(Ljava/lang/String;)Ljava/lang/Object;
    .locals 7
    .param p1, "featureName"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x0

    .local v3, "ret":Ljava/lang/Object;
    :try_start_0
    const-class v4, Lcom/android/internal/telephony/lgdata/LgDataFeature;

    invoke-virtual {v4, p1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    .local v1, "field":Ljava/lang/reflect/Field;
    invoke-virtual {v1, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/NoSuchFieldException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v3

    .end local v1    # "field":Ljava/lang/reflect/Field;
    .end local v3    # "ret":Ljava/lang/Object;
    :goto_0
    return-object v3

    .restart local v3    # "ret":Ljava/lang/Object;
    :catch_0
    move-exception v2

    .local v2, "nsfe":Ljava/lang/NoSuchFieldException;
    const-string v4, "LgDataFeature"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "getFeatureValue(): There is no such field "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v2    # "nsfe":Ljava/lang/NoSuchFieldException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v4, "LgDataFeature"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "getFeatureValue(): Exception found for "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method

.method public getIntegerFeatureValue(Ljava/lang/String;)I
    .locals 7
    .param p1, "featureName"    # Ljava/lang/String;

    .prologue
    const/4 v3, -0x1

    .local v3, "ret":I
    :try_start_0
    const-class v4, Lcom/android/internal/telephony/lgdata/LgDataFeature;

    invoke-virtual {v4, p1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    .local v1, "field":Ljava/lang/reflect/Field;
    invoke-virtual {v1}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Class;->isPrimitive()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-virtual {v1}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v4

    sget-object v5, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    invoke-virtual {v4, v5}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-virtual {v1, p0}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I
    :try_end_0
    .catch Ljava/lang/NoSuchFieldException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    move-result v3

    .end local v1    # "field":Ljava/lang/reflect/Field;
    :cond_0
    :goto_0
    return v3

    :catch_0
    move-exception v2

    .local v2, "nsfe":Ljava/lang/NoSuchFieldException;
    const-string v4, "LgDataFeature"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "getIntegerFeatureValue(): There is no such field "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v2    # "nsfe":Ljava/lang/NoSuchFieldException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v4, "LgDataFeature"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "getIntegerFeatureValue(): Exception found for "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method

.method public getStringFeatureValue(Ljava/lang/String;)Ljava/lang/String;
    .locals 8
    .param p1, "featureName"    # Ljava/lang/String;

    .prologue
    const/4 v4, 0x0

    .local v4, "ret":Ljava/lang/String;
    :try_start_0
    const-class v5, Lcom/android/internal/telephony/lgdata/LgDataFeature;

    invoke-virtual {v5, p1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v2

    .local v2, "field":Ljava/lang/reflect/Field;
    invoke-virtual {v2}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Class;->isPrimitive()Z

    move-result v5

    if-nez v5, :cond_0

    invoke-virtual {v2}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v5

    const-class v6, Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    invoke-virtual {v2, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    move-object v0, v5

    check-cast v0, Ljava/lang/String;

    move-object v4, v0
    :try_end_0
    .catch Ljava/lang/NoSuchFieldException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .end local v2    # "field":Ljava/lang/reflect/Field;
    :cond_0
    :goto_0
    return-object v4

    :catch_0
    move-exception v3

    .local v3, "nsfe":Ljava/lang/NoSuchFieldException;
    const-string v5, "LgDataFeature"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "getStringFeatureValue(): There is no such field "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v3    # "nsfe":Ljava/lang/NoSuchFieldException;
    :catch_1
    move-exception v1

    .local v1, "e":Ljava/lang/Exception;
    const-string v5, "LgDataFeature"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "getStringFeatureValue(): Exception found for "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method

.method public getType(Ljava/lang/String;)I
    .locals 6
    .param p1, "featureName"    # Ljava/lang/String;

    .prologue
    :try_start_0
    const-class v3, Lcom/android/internal/telephony/lgdata/LgDataFeature;

    invoke-virtual {v3, p1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    .local v1, "field":Ljava/lang/reflect/Field;
    invoke-virtual {v1}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->isPrimitive()Z

    move-result v3

    if-eqz v3, :cond_7

    invoke-virtual {v1}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v3

    sget-object v4, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    const/4 v3, 0x0

    .end local v1    # "field":Ljava/lang/reflect/Field;
    :goto_0
    return v3

    .restart local v1    # "field":Ljava/lang/reflect/Field;
    :cond_0
    invoke-virtual {v1}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v3

    sget-object v4, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    const/4 v3, 0x1

    goto :goto_0

    :cond_1
    invoke-virtual {v1}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v3

    sget-object v4, Ljava/lang/Short;->TYPE:Ljava/lang/Class;

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    const/4 v3, 0x2

    goto :goto_0

    :cond_2
    invoke-virtual {v1}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v3

    sget-object v4, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    const/4 v3, 0x3

    goto :goto_0

    :cond_3
    invoke-virtual {v1}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v3

    sget-object v4, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    const/4 v3, 0x4

    goto :goto_0

    :cond_4
    invoke-virtual {v1}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v3

    sget-object v4, Ljava/lang/Double;->TYPE:Ljava/lang/Class;

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_5

    const/4 v3, 0x5

    goto :goto_0

    :cond_5
    invoke-virtual {v1}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v3

    sget-object v4, Ljava/lang/Byte;->TYPE:Ljava/lang/Class;

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_6

    const/4 v3, 0x6

    goto :goto_0

    :cond_6
    invoke-virtual {v1}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v3

    sget-object v4, Ljava/lang/Character;->TYPE:Ljava/lang/Class;

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_8

    const/4 v3, 0x7

    goto :goto_0

    :cond_7
    invoke-virtual {v1}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v3

    const-class v4, Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/NoSuchFieldException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    move-result v3

    if-eqz v3, :cond_8

    const/16 v3, 0x8

    goto :goto_0

    .end local v1    # "field":Ljava/lang/reflect/Field;
    :catch_0
    move-exception v2

    .local v2, "nsfe":Ljava/lang/NoSuchFieldException;
    const-string v3, "LgDataFeature"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "getType(): There is no such field "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .end local v2    # "nsfe":Ljava/lang/NoSuchFieldException;
    :cond_8
    :goto_1
    const/4 v3, -0x1

    goto/16 :goto_0

    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v3, "LgDataFeature"

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "getType(): Exception found for "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1
.end method

.method public loadFeatures()V
    .locals 21

    .prologue
    const/4 v3, 0x0

    .local v3, "XML_FILE_PATH":Ljava/io/File;
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v3

    new-instance v6, Ljava/io/File;

    const-string v18, "lpp_data.xml"

    move-object/from16 v0, v18

    invoke-direct {v6, v3, v0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .local v6, "file":Ljava/io/File;
    const/4 v7, 0x0

    .local v7, "fis":Ljava/io/FileInputStream;
    :try_start_0
    new-instance v8, Ljava/io/FileInputStream;

    invoke-virtual {v6}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v18

    move-object/from16 v0, v18

    invoke-direct {v8, v0}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v7    # "fis":Ljava/io/FileInputStream;
    .local v8, "fis":Ljava/io/FileInputStream;
    const-string v18, "LgDataFeature"

    new-instance v19, Ljava/lang/StringBuilder;

    invoke-direct/range {v19 .. v19}, Ljava/lang/StringBuilder;-><init>()V

    const-string v20, "loadFeatures(): Load all features from "

    invoke-virtual/range {v19 .. v20}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    invoke-virtual {v6}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v20

    invoke-virtual/range {v19 .. v20}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    invoke-virtual/range {v19 .. v19}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v19

    invoke-static/range {v18 .. v19}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :try_start_1
    invoke-static {}, Landroid/util/Xml;->newPullParser()Lorg/xmlpull/v1/XmlPullParser;

    move-result-object v15

    .local v15, "parser":Lorg/xmlpull/v1/XmlPullParser;
    const/16 v18, 0x0

    move-object/from16 v0, v18

    invoke-interface {v15, v8, v0}, Lorg/xmlpull/v1/XmlPullParser;->setInput(Ljava/io/InputStream;Ljava/lang/String;)V

    const/16 v16, 0x0

    .local v16, "type":I
    :goto_0
    const/16 v18, 0x1

    move/from16 v0, v16

    move/from16 v1, v18

    if-eq v0, v1, :cond_0

    const/16 v18, 0x2

    move/from16 v0, v16

    move/from16 v1, v18

    if-eq v0, v1, :cond_0

    invoke-interface {v15}, Lorg/xmlpull/v1/XmlPullParser;->next()I
    :try_end_1
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_3
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v16

    goto :goto_0

    .end local v8    # "fis":Ljava/io/FileInputStream;
    .end local v15    # "parser":Lorg/xmlpull/v1/XmlPullParser;
    .end local v16    # "type":I
    .restart local v7    # "fis":Ljava/io/FileInputStream;
    :catch_0
    move-exception v9

    .local v9, "fnfe":Ljava/io/FileNotFoundException;
    const-string v18, "LgDataFeature"

    const-string v19, "loadFeatures(): Error to open file - lpp_data.xml"

    move-object/from16 v0, v18

    move-object/from16 v1, v19

    invoke-static {v0, v1, v9}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .end local v9    # "fnfe":Ljava/io/FileNotFoundException;
    :goto_1
    return-void

    .end local v7    # "fis":Ljava/io/FileInputStream;
    .restart local v8    # "fis":Ljava/io/FileInputStream;
    .restart local v15    # "parser":Lorg/xmlpull/v1/XmlPullParser;
    .restart local v16    # "type":I
    :cond_0
    :try_start_2
    const-string v18, "lpp"

    invoke-interface {v15}, Lorg/xmlpull/v1/XmlPullParser;->getName()Ljava/lang/String;

    move-result-object v19

    invoke-virtual/range {v18 .. v19}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v18

    if-nez v18, :cond_3

    new-instance v18, Lorg/xmlpull/v1/XmlPullParserException;

    const-string v19, "LPP Feature file does not start with lpp tag."

    invoke-direct/range {v18 .. v19}, Lorg/xmlpull/v1/XmlPullParserException;-><init>(Ljava/lang/String;)V

    throw v18
    :try_end_2
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_3
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .end local v15    # "parser":Lorg/xmlpull/v1/XmlPullParser;
    .end local v16    # "type":I
    :catch_1
    move-exception v17

    .local v17, "xppe":Lorg/xmlpull/v1/XmlPullParserException;
    :try_start_3
    const-string v18, "LgDataFeature"

    const-string v19, "loadFeatures(): Error parsing LPP features. "

    move-object/from16 v0, v18

    move-object/from16 v1, v19

    move-object/from16 v2, v17

    invoke-static {v0, v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    if-eqz v8, :cond_1

    :try_start_4
    invoke-virtual {v8}, Ljava/io/FileInputStream;->close()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_6

    .end local v17    # "xppe":Lorg/xmlpull/v1/XmlPullParserException;
    :cond_1
    :goto_2
    move-object v7, v8

    .end local v8    # "fis":Ljava/io/FileInputStream;
    .restart local v7    # "fis":Ljava/io/FileInputStream;
    goto :goto_1

    .end local v7    # "fis":Ljava/io/FileInputStream;
    .restart local v8    # "fis":Ljava/io/FileInputStream;
    .restart local v15    # "parser":Lorg/xmlpull/v1/XmlPullParser;
    .restart local v16    # "type":I
    :cond_2
    const/16 v18, 0x3

    move/from16 v0, v16

    move/from16 v1, v18

    if-eq v0, v1, :cond_3

    const/16 v18, 0x4

    move/from16 v0, v16

    move/from16 v1, v18

    if-ne v0, v1, :cond_4

    :cond_3
    :goto_3
    :try_start_5
    invoke-interface {v15}, Lorg/xmlpull/v1/XmlPullParser;->next()I
    :try_end_5
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_5 .. :try_end_5} :catch_1
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_3
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    move-result v16

    const/16 v18, 0x1

    move/from16 v0, v16

    move/from16 v1, v18

    if-ne v0, v1, :cond_2

    if-eqz v8, :cond_1

    :try_start_6
    invoke-virtual {v8}, Ljava/io/FileInputStream;->close()V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_2

    goto :goto_2

    :catch_2
    move-exception v18

    goto :goto_2

    :cond_4
    :try_start_7
    invoke-interface {v15}, Lorg/xmlpull/v1/XmlPullParser;->getName()Ljava/lang/String;

    move-result-object v14

    .local v14, "nodeName":Ljava/lang/String;
    const-string v18, "feature"

    move-object/from16 v0, v18

    invoke-virtual {v0, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v18

    if-nez v18, :cond_5

    new-instance v18, Lorg/xmlpull/v1/XmlPullParserException;

    const-string v19, "LPP Feature file not well-formed."

    invoke-direct/range {v18 .. v19}, Lorg/xmlpull/v1/XmlPullParserException;-><init>(Ljava/lang/String;)V

    throw v18
    :try_end_7
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_7 .. :try_end_7} :catch_1
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_3
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    .end local v14    # "nodeName":Ljava/lang/String;
    .end local v15    # "parser":Lorg/xmlpull/v1/XmlPullParser;
    .end local v16    # "type":I
    :catch_3
    move-exception v4

    .local v4, "e":Ljava/lang/Exception;
    :try_start_8
    const-string v18, "LgDataFeature"

    const-string v19, "loadFeatures(): Error loading LPP features. "

    move-object/from16 v0, v18

    move-object/from16 v1, v19

    invoke-static {v0, v1, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    if-eqz v8, :cond_1

    :try_start_9
    invoke-virtual {v8}, Ljava/io/FileInputStream;->close()V
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_4

    goto :goto_2

    :catch_4
    move-exception v18

    goto :goto_2

    .end local v4    # "e":Ljava/lang/Exception;
    .restart local v14    # "nodeName":Ljava/lang/String;
    .restart local v15    # "parser":Lorg/xmlpull/v1/XmlPullParser;
    .restart local v16    # "type":I
    :cond_5
    const/16 v18, 0x0

    :try_start_a
    const-string v19, "name"

    move-object/from16 v0, v18

    move-object/from16 v1, v19

    invoke-interface {v15, v0, v1}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    .local v10, "lpp_name":Ljava/lang/String;
    const/16 v18, 0x0

    const-string v19, "type"

    move-object/from16 v0, v18

    move-object/from16 v1, v19

    invoke-interface {v15, v0, v1}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    .local v11, "lpp_type":Ljava/lang/String;
    const/16 v18, 0x0

    const-string v19, "value"

    move-object/from16 v0, v18

    move-object/from16 v1, v19

    invoke-interface {v15, v0, v1}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    .local v12, "lpp_value":Ljava/lang/String;
    const-string v18, "LgDataFeature"

    new-instance v19, Ljava/lang/StringBuilder;

    invoke-direct/range {v19 .. v19}, Ljava/lang/StringBuilder;-><init>()V

    const-string v20, "loadFeatures():  "

    invoke-virtual/range {v19 .. v20}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    move-object/from16 v0, v19

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    const-string v20, "(type:"

    invoke-virtual/range {v19 .. v20}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    move-object/from16 v0, v19

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    const-string v20, ") is "

    invoke-virtual/range {v19 .. v20}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    move-object/from16 v0, v19

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    invoke-virtual/range {v19 .. v19}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v19

    invoke-static/range {v18 .. v19}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    move-object/from16 v0, p0

    invoke-virtual {v0, v10}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getType(Ljava/lang/String;)I

    move-result v5

    .local v5, "feature_type":I
    if-nez v5, :cond_7

    const-string v18, "true"

    move-object/from16 v0, v18

    invoke-virtual {v0, v12}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v18

    move-object/from16 v0, p0

    move/from16 v1, v18

    invoke-virtual {v0, v10, v1}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->setBooleanFeatureValue(Ljava/lang/String;Z)V
    :try_end_a
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_a .. :try_end_a} :catch_1
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_3
    .catchall {:try_start_a .. :try_end_a} :catchall_0

    goto/16 :goto_3

    .end local v5    # "feature_type":I
    .end local v10    # "lpp_name":Ljava/lang/String;
    .end local v11    # "lpp_type":Ljava/lang/String;
    .end local v12    # "lpp_value":Ljava/lang/String;
    .end local v14    # "nodeName":Ljava/lang/String;
    .end local v15    # "parser":Lorg/xmlpull/v1/XmlPullParser;
    .end local v16    # "type":I
    :catchall_0
    move-exception v18

    if-eqz v8, :cond_6

    :try_start_b
    invoke-virtual {v8}, Ljava/io/FileInputStream;->close()V
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_7

    :cond_6
    :goto_4
    throw v18

    .restart local v5    # "feature_type":I
    .restart local v10    # "lpp_name":Ljava/lang/String;
    .restart local v11    # "lpp_type":Ljava/lang/String;
    .restart local v12    # "lpp_value":Ljava/lang/String;
    .restart local v14    # "nodeName":Ljava/lang/String;
    .restart local v15    # "parser":Lorg/xmlpull/v1/XmlPullParser;
    .restart local v16    # "type":I
    :cond_7
    const/16 v18, 0x1

    move/from16 v0, v18

    if-ne v5, v0, :cond_8

    :try_start_c
    invoke-static {v12}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v18

    move-object/from16 v0, p0

    move/from16 v1, v18

    invoke-virtual {v0, v10, v1}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->setIntegerFeatureValue(Ljava/lang/String;I)V
    :try_end_c
    .catch Ljava/lang/NumberFormatException; {:try_start_c .. :try_end_c} :catch_5
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_c .. :try_end_c} :catch_1
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_3
    .catchall {:try_start_c .. :try_end_c} :catchall_0

    goto/16 :goto_3

    :catch_5
    move-exception v13

    .local v13, "nfe":Ljava/lang/NumberFormatException;
    :try_start_d
    const-string v18, "LgDataFeature"

    new-instance v19, Ljava/lang/StringBuilder;

    invoke-direct/range {v19 .. v19}, Ljava/lang/StringBuilder;-><init>()V

    const-string v20, "loadFeatures(): fail to parseInt, "

    invoke-virtual/range {v19 .. v20}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    move-object/from16 v0, v19

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    const-string v20, "(type:"

    invoke-virtual/range {v19 .. v20}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    move-object/from16 v0, v19

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    const-string v20, ") as "

    invoke-virtual/range {v19 .. v20}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    move-object/from16 v0, v19

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    invoke-virtual/range {v19 .. v19}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v19

    invoke-static/range {v18 .. v19}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_3

    .end local v13    # "nfe":Ljava/lang/NumberFormatException;
    :cond_8
    const/16 v18, 0x8

    move/from16 v0, v18

    if-ne v5, v0, :cond_9

    move-object/from16 v0, p0

    invoke-virtual {v0, v10, v12}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->setStringFeatureValue(Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_3

    :cond_9
    const-string v18, "LgDataFeature"

    new-instance v19, Ljava/lang/StringBuilder;

    invoke-direct/range {v19 .. v19}, Ljava/lang/StringBuilder;-><init>()V

    const-string v20, "loadFeatures(): fail to set "

    invoke-virtual/range {v19 .. v20}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    move-object/from16 v0, v19

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    const-string v20, "(type:"

    invoke-virtual/range {v19 .. v20}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    move-object/from16 v0, v19

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    const-string v20, ") as "

    invoke-virtual/range {v19 .. v20}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    move-object/from16 v0, v19

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    invoke-virtual/range {v19 .. v19}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v19

    invoke-static/range {v18 .. v19}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_d
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_d .. :try_end_d} :catch_1
    .catch Ljava/lang/Exception; {:try_start_d .. :try_end_d} :catch_3
    .catchall {:try_start_d .. :try_end_d} :catchall_0

    goto/16 :goto_3

    .end local v5    # "feature_type":I
    .end local v10    # "lpp_name":Ljava/lang/String;
    .end local v11    # "lpp_type":Ljava/lang/String;
    .end local v12    # "lpp_value":Ljava/lang/String;
    .end local v14    # "nodeName":Ljava/lang/String;
    .end local v15    # "parser":Lorg/xmlpull/v1/XmlPullParser;
    .end local v16    # "type":I
    .restart local v17    # "xppe":Lorg/xmlpull/v1/XmlPullParserException;
    :catch_6
    move-exception v18

    goto/16 :goto_2

    .end local v17    # "xppe":Lorg/xmlpull/v1/XmlPullParserException;
    :catch_7
    move-exception v19

    goto/16 :goto_4
.end method

.method public saveFeatures()V
    .locals 22

    .prologue
    const/4 v5, 0x0

    .local v5, "XML_FILE_PATH":Ljava/io/File;
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v5

    new-instance v9, Ljava/io/File;

    const-string v18, "lpp_data.xml"

    move-object/from16 v0, v18

    invoke-direct {v9, v5, v0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .local v9, "file":Ljava/io/File;
    const/4 v11, 0x0

    .local v11, "fos":Ljava/io/FileOutputStream;
    :try_start_0
    new-instance v12, Ljava/io/FileOutputStream;

    invoke-virtual {v9}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v18

    const/16 v19, 0x0

    move-object/from16 v0, v18

    move/from16 v1, v19

    invoke-direct {v12, v0, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/lang/String;Z)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v11    # "fos":Ljava/io/FileOutputStream;
    .local v12, "fos":Ljava/io/FileOutputStream;
    const-string v18, "LgDataFeature"

    new-instance v19, Ljava/lang/StringBuilder;

    invoke-direct/range {v19 .. v19}, Ljava/lang/StringBuilder;-><init>()V

    const-string v20, "saveFeatures(): Save all features to "

    invoke-virtual/range {v19 .. v20}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    invoke-virtual {v9}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v20

    invoke-virtual/range {v19 .. v20}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    invoke-virtual/range {v19 .. v19}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v19

    invoke-static/range {v18 .. v19}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {}, Landroid/util/Xml;->newSerializer()Lorg/xmlpull/v1/XmlSerializer;

    move-result-object v17

    .local v17, "serializer":Lorg/xmlpull/v1/XmlSerializer;
    if-eqz v17, :cond_7

    const/16 v18, 0x0

    :try_start_1
    move-object/from16 v0, v17

    move-object/from16 v1, v18

    invoke-interface {v0, v12, v1}, Lorg/xmlpull/v1/XmlSerializer;->setOutput(Ljava/io/OutputStream;Ljava/lang/String;)V

    const-string v18, "UTF-8"

    const/16 v19, 0x1

    invoke-static/range {v19 .. v19}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v19

    invoke-interface/range {v17 .. v19}, Lorg/xmlpull/v1/XmlSerializer;->startDocument(Ljava/lang/String;Ljava/lang/Boolean;)V

    const-string v18, "\n"

    invoke-interface/range {v17 .. v18}, Lorg/xmlpull/v1/XmlSerializer;->text(Ljava/lang/String;)Lorg/xmlpull/v1/XmlSerializer;

    const/16 v18, 0x0

    const-string v19, "lpp"

    invoke-interface/range {v17 .. v19}, Lorg/xmlpull/v1/XmlSerializer;->startTag(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/XmlSerializer;

    const/16 v18, 0x0

    const-string v19, "model"

    const-string v20, "ro.product.device"

    const-string v21, "NULL"

    invoke-static/range {v20 .. v21}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v20

    invoke-interface/range {v17 .. v20}, Lorg/xmlpull/v1/XmlSerializer;->attribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/XmlSerializer;

    const/16 v18, 0x0

    const-string v19, "operator"

    const-string v20, "ro.afwdata.LGfeatureset"

    const-string v21, "NULL"

    invoke-static/range {v20 .. v21}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v20

    invoke-interface/range {v17 .. v20}, Lorg/xmlpull/v1/XmlSerializer;->attribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/XmlSerializer;

    const/16 v18, 0x0

    const-string v19, "version"

    const-string v20, "ro.lge.swversion"

    const-string v21, "NULL"

    invoke-static/range {v20 .. v21}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v20

    invoke-interface/range {v17 .. v20}, Lorg/xmlpull/v1/XmlSerializer;->attribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/XmlSerializer;

    const-string v18, "\n"

    invoke-interface/range {v17 .. v18}, Lorg/xmlpull/v1/XmlSerializer;->text(Ljava/lang/String;)Lorg/xmlpull/v1/XmlSerializer;

    const-class v18, Lcom/android/internal/telephony/lgdata/LgDataFeature;

    invoke-virtual/range {v18 .. v18}, Ljava/lang/Class;->getFields()[Ljava/lang/reflect/Field;

    move-result-object v15

    .local v15, "lgFeagureFields":[Ljava/lang/reflect/Field;
    move-object v6, v15

    .local v6, "arr$":[Ljava/lang/reflect/Field;
    array-length v14, v6

    .local v14, "len$":I
    const/4 v13, 0x0

    .local v13, "i$":I
    :goto_0
    if-ge v13, v14, :cond_6

    aget-object v8, v6, v13

    .local v8, "field":Ljava/lang/reflect/Field;
    invoke-virtual {v8}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Ljava/lang/Class;->isPrimitive()Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result v18

    if-eqz v18, :cond_3

    :try_start_2
    invoke-virtual {v8}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v18

    sget-object v19, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    invoke-virtual/range {v18 .. v19}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v18

    if-eqz v18, :cond_1

    invoke-virtual {v8}, Ljava/lang/reflect/Field;->getName()Ljava/lang/String;

    move-result-object v18

    const-string v19, "boolean"

    new-instance v20, Ljava/lang/StringBuilder;

    invoke-direct/range {v20 .. v20}, Ljava/lang/StringBuilder;-><init>()V

    const-string v21, ""

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    move-object/from16 v0, p0

    invoke-virtual {v8, v0}, Ljava/lang/reflect/Field;->getBoolean(Ljava/lang/Object;)Z

    move-result v21

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v20

    move-object/from16 v0, p0

    move-object/from16 v1, v17

    move-object/from16 v2, v18

    move-object/from16 v3, v19

    move-object/from16 v4, v20

    invoke-direct {v0, v1, v2, v3, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->writeFeatureAttribute(Lorg/xmlpull/v1/XmlSerializer;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :cond_0
    :goto_1
    add-int/lit8 v13, v13, 0x1

    goto :goto_0

    .end local v6    # "arr$":[Ljava/lang/reflect/Field;
    .end local v8    # "field":Ljava/lang/reflect/Field;
    .end local v12    # "fos":Ljava/io/FileOutputStream;
    .end local v13    # "i$":I
    .end local v14    # "len$":I
    .end local v15    # "lgFeagureFields":[Ljava/lang/reflect/Field;
    .end local v17    # "serializer":Lorg/xmlpull/v1/XmlSerializer;
    .restart local v11    # "fos":Ljava/io/FileOutputStream;
    :catch_0
    move-exception v10

    .local v10, "fnfe":Ljava/io/FileNotFoundException;
    const-string v18, "LgDataFeature"

    const-string v19, "saveFeatures(): Error to open file - lpp_data.xml"

    move-object/from16 v0, v18

    move-object/from16 v1, v19

    invoke-static {v0, v1, v10}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .end local v10    # "fnfe":Ljava/io/FileNotFoundException;
    :goto_2
    return-void

    .end local v11    # "fos":Ljava/io/FileOutputStream;
    .restart local v6    # "arr$":[Ljava/lang/reflect/Field;
    .restart local v8    # "field":Ljava/lang/reflect/Field;
    .restart local v12    # "fos":Ljava/io/FileOutputStream;
    .restart local v13    # "i$":I
    .restart local v14    # "len$":I
    .restart local v15    # "lgFeagureFields":[Ljava/lang/reflect/Field;
    .restart local v17    # "serializer":Lorg/xmlpull/v1/XmlSerializer;
    :cond_1
    :try_start_3
    invoke-virtual {v8}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v18

    sget-object v19, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    invoke-virtual/range {v18 .. v19}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v18

    if-eqz v18, :cond_0

    invoke-virtual {v8}, Ljava/lang/reflect/Field;->getName()Ljava/lang/String;

    move-result-object v18

    const-string v19, "int"

    new-instance v20, Ljava/lang/StringBuilder;

    invoke-direct/range {v20 .. v20}, Ljava/lang/StringBuilder;-><init>()V

    const-string v21, ""

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    move-object/from16 v0, p0

    invoke-virtual {v8, v0}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result v21

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v20

    move-object/from16 v0, p0

    move-object/from16 v1, v17

    move-object/from16 v2, v18

    move-object/from16 v3, v19

    move-object/from16 v4, v20

    invoke-direct {v0, v1, v2, v3, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->writeFeatureAttribute(Lorg/xmlpull/v1/XmlSerializer;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_1

    :catch_1
    move-exception v7

    .local v7, "e":Ljava/lang/Exception;
    :try_start_4
    invoke-virtual {v7}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_2
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto :goto_1

    .end local v6    # "arr$":[Ljava/lang/reflect/Field;
    .end local v7    # "e":Ljava/lang/Exception;
    .end local v8    # "field":Ljava/lang/reflect/Field;
    .end local v13    # "i$":I
    .end local v14    # "len$":I
    .end local v15    # "lgFeagureFields":[Ljava/lang/reflect/Field;
    :catch_2
    move-exception v7

    .restart local v7    # "e":Ljava/lang/Exception;
    :try_start_5
    invoke-virtual {v7}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    if-eqz v12, :cond_2

    :try_start_6
    invoke-virtual {v12}, Ljava/io/FileOutputStream;->close()V
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_5

    .end local v7    # "e":Ljava/lang/Exception;
    :cond_2
    :goto_3
    move-object v11, v12

    .end local v12    # "fos":Ljava/io/FileOutputStream;
    .restart local v11    # "fos":Ljava/io/FileOutputStream;
    goto :goto_2

    .end local v11    # "fos":Ljava/io/FileOutputStream;
    .restart local v6    # "arr$":[Ljava/lang/reflect/Field;
    .restart local v8    # "field":Ljava/lang/reflect/Field;
    .restart local v12    # "fos":Ljava/io/FileOutputStream;
    .restart local v13    # "i$":I
    .restart local v14    # "len$":I
    .restart local v15    # "lgFeagureFields":[Ljava/lang/reflect/Field;
    :cond_3
    :try_start_7
    invoke-virtual {v8}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v18

    const-class v19, Ljava/lang/String;

    invoke-virtual/range {v18 .. v19}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v18

    if-eqz v18, :cond_5

    invoke-virtual {v8}, Ljava/lang/reflect/Field;->getName()Ljava/lang/String;

    move-result-object v18

    const-string v19, "string"

    new-instance v20, Ljava/lang/StringBuilder;

    invoke-direct/range {v20 .. v20}, Ljava/lang/StringBuilder;-><init>()V

    const-string v21, ""

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    move-object/from16 v0, p0

    invoke-virtual {v8, v0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v21

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v20

    move-object/from16 v0, p0

    move-object/from16 v1, v17

    move-object/from16 v2, v18

    move-object/from16 v3, v19

    move-object/from16 v4, v20

    invoke-direct {v0, v1, v2, v3, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->writeFeatureAttribute(Lorg/xmlpull/v1/XmlSerializer;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_3
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    goto/16 :goto_1

    :catch_3
    move-exception v7

    .restart local v7    # "e":Ljava/lang/Exception;
    :try_start_8
    invoke-virtual {v7}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_2
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    goto/16 :goto_1

    .end local v6    # "arr$":[Ljava/lang/reflect/Field;
    .end local v7    # "e":Ljava/lang/Exception;
    .end local v8    # "field":Ljava/lang/reflect/Field;
    .end local v13    # "i$":I
    .end local v14    # "len$":I
    .end local v15    # "lgFeagureFields":[Ljava/lang/reflect/Field;
    :catchall_0
    move-exception v18

    if-eqz v12, :cond_4

    :try_start_9
    invoke-virtual {v12}, Ljava/io/FileOutputStream;->close()V
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_6

    :cond_4
    :goto_4
    throw v18

    .restart local v6    # "arr$":[Ljava/lang/reflect/Field;
    .restart local v8    # "field":Ljava/lang/reflect/Field;
    .restart local v13    # "i$":I
    .restart local v14    # "len$":I
    .restart local v15    # "lgFeagureFields":[Ljava/lang/reflect/Field;
    :cond_5
    :try_start_a
    move-object/from16 v0, p0

    invoke-virtual {v8, v0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v16

    .local v16, "obj":Ljava/lang/Object;
    invoke-virtual {v8}, Ljava/lang/reflect/Field;->getName()Ljava/lang/String;

    move-result-object v18

    const-string v19, "object"

    new-instance v20, Ljava/lang/StringBuilder;

    invoke-direct/range {v20 .. v20}, Ljava/lang/StringBuilder;-><init>()V

    const-string v21, ""

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    move-object/from16 v0, p0

    invoke-virtual {v8, v0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v21

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v20

    move-object/from16 v0, p0

    move-object/from16 v1, v17

    move-object/from16 v2, v18

    move-object/from16 v3, v19

    move-object/from16 v4, v20

    invoke-direct {v0, v1, v2, v3, v4}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->writeFeatureAttribute(Lorg/xmlpull/v1/XmlSerializer;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_a
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_3
    .catchall {:try_start_a .. :try_end_a} :catchall_0

    goto/16 :goto_1

    .end local v8    # "field":Ljava/lang/reflect/Field;
    .end local v16    # "obj":Ljava/lang/Object;
    :cond_6
    const/16 v18, 0x0

    :try_start_b
    const-string v19, "lpp"

    invoke-interface/range {v17 .. v19}, Lorg/xmlpull/v1/XmlSerializer;->endTag(Ljava/lang/String;Ljava/lang/String;)Lorg/xmlpull/v1/XmlSerializer;

    invoke-interface/range {v17 .. v17}, Lorg/xmlpull/v1/XmlSerializer;->endDocument()V

    const-string v18, "\n"

    invoke-interface/range {v17 .. v18}, Lorg/xmlpull/v1/XmlSerializer;->text(Ljava/lang/String;)Lorg/xmlpull/v1/XmlSerializer;
    :try_end_b
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_2
    .catchall {:try_start_b .. :try_end_b} :catchall_0

    .end local v6    # "arr$":[Ljava/lang/reflect/Field;
    .end local v13    # "i$":I
    .end local v14    # "len$":I
    .end local v15    # "lgFeagureFields":[Ljava/lang/reflect/Field;
    :goto_5
    if-eqz v12, :cond_2

    :try_start_c
    invoke-virtual {v12}, Ljava/io/FileOutputStream;->close()V
    :try_end_c
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_4

    goto/16 :goto_3

    :catch_4
    move-exception v18

    goto/16 :goto_3

    :cond_7
    :try_start_d
    const-string v18, "LgDataFeature"

    const-string v19, "saveFeatures() XmlSerializer is null"

    invoke-static/range {v18 .. v19}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_d
    .catch Ljava/lang/Exception; {:try_start_d .. :try_end_d} :catch_2
    .catchall {:try_start_d .. :try_end_d} :catchall_0

    goto :goto_5

    .restart local v7    # "e":Ljava/lang/Exception;
    :catch_5
    move-exception v18

    goto/16 :goto_3

    .end local v7    # "e":Ljava/lang/Exception;
    :catch_6
    move-exception v19

    goto :goto_4
.end method

.method public setBooleanFeatureValue(Ljava/lang/String;Z)V
    .locals 9
    .param p1, "featureName"    # Ljava/lang/String;
    .param p2, "value"    # Z

    .prologue
    :try_start_0
    const-class v6, Lcom/android/internal/telephony/lgdata/LgDataFeature;

    invoke-virtual {v6, p1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    .local v1, "field":Ljava/lang/reflect/Field;
    invoke-virtual {v1}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Class;->isPrimitive()Z

    move-result v6

    if-eqz v6, :cond_0

    invoke-virtual {v1}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v6

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    invoke-virtual {v6, v7}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_0

    invoke-virtual {v1, p0}, Ljava/lang/reflect/Field;->getBoolean(Ljava/lang/Object;)Z

    move-result v5

    .local v5, "old":Z
    invoke-virtual {v1, p0, p2}, Ljava/lang/reflect/Field;->setBoolean(Ljava/lang/Object;Z)V

    const-string v6, "LgDataFeature"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "setBooleanFeatureValue(): "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " is changed from "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " to "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NoSuchFieldException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_3

    .end local v1    # "field":Ljava/lang/reflect/Field;
    .end local v5    # "old":Z
    :cond_0
    :goto_0
    return-void

    :catch_0
    move-exception v4

    .local v4, "nsfe":Ljava/lang/NoSuchFieldException;
    const-string v6, "LgDataFeature"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "setBooleanFeatureValue(): There is no such field "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v4    # "nsfe":Ljava/lang/NoSuchFieldException;
    :catch_1
    move-exception v2

    .local v2, "iae":Ljava/lang/IllegalArgumentException;
    const-string v6, "LgDataFeature"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "setBooleanFeatureValue(): Illegal value is assigned for "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ", value : "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v2    # "iae":Ljava/lang/IllegalArgumentException;
    :catch_2
    move-exception v3

    .local v3, "ipe":Ljava/lang/IllegalAccessException;
    const-string v6, "LgDataFeature"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "setBooleanFeatureValue(): "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " is not accessible"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v3    # "ipe":Ljava/lang/IllegalAccessException;
    :catch_3
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v6, "LgDataFeature"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "setBooleanFeatureValue(): Exception found for "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method

.method public setFeatureValue(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 9
    .param p1, "featureName"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;

    .prologue
    :try_start_0
    const-class v6, Lcom/android/internal/telephony/lgdata/LgDataFeature;

    invoke-virtual {v6, p1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    .local v1, "field":Ljava/lang/reflect/Field;
    invoke-virtual {v1, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    .local v5, "old":Ljava/lang/Object;
    invoke-virtual {v1, p0, p2}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    const-string v6, "LgDataFeature"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "setFeatureValue(): "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " is changed from "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " to "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NoSuchFieldException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_3

    .end local v1    # "field":Ljava/lang/reflect/Field;
    .end local v5    # "old":Ljava/lang/Object;
    :goto_0
    return-void

    :catch_0
    move-exception v4

    .local v4, "nsfe":Ljava/lang/NoSuchFieldException;
    const-string v6, "LgDataFeature"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "setFeatureValue(): There is no such field "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v4    # "nsfe":Ljava/lang/NoSuchFieldException;
    :catch_1
    move-exception v2

    .local v2, "iae":Ljava/lang/IllegalArgumentException;
    const-string v6, "LgDataFeature"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "setFeatureValue(): Illegal value is assigned for "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ", value : "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v2    # "iae":Ljava/lang/IllegalArgumentException;
    :catch_2
    move-exception v3

    .local v3, "ipe":Ljava/lang/IllegalAccessException;
    const-string v6, "LgDataFeature"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "setFeatureValue(): "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " is not accessible"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v3    # "ipe":Ljava/lang/IllegalAccessException;
    :catch_3
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v6, "LgDataFeature"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "setFeatureValue(): Exception found for "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method

.method public setIntegerFeatureValue(Ljava/lang/String;I)V
    .locals 9
    .param p1, "featureName"    # Ljava/lang/String;
    .param p2, "value"    # I

    .prologue
    :try_start_0
    const-class v6, Lcom/android/internal/telephony/lgdata/LgDataFeature;

    invoke-virtual {v6, p1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    .local v1, "field":Ljava/lang/reflect/Field;
    invoke-virtual {v1}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Class;->isPrimitive()Z

    move-result v6

    if-eqz v6, :cond_0

    invoke-virtual {v1}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v6

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    invoke-virtual {v6, v7}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_0

    invoke-virtual {v1, p0}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result v5

    .local v5, "old":I
    invoke-virtual {v1, p0, p2}, Ljava/lang/reflect/Field;->setInt(Ljava/lang/Object;I)V

    const-string v6, "LgDataFeature"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "setIntegerFeatureValue(): "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " is changed from "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " to "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NoSuchFieldException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_3

    .end local v1    # "field":Ljava/lang/reflect/Field;
    .end local v5    # "old":I
    :cond_0
    :goto_0
    return-void

    :catch_0
    move-exception v4

    .local v4, "nsfe":Ljava/lang/NoSuchFieldException;
    const-string v6, "LgDataFeature"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "setIntegerFeatureValue(): There is no such field "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v4    # "nsfe":Ljava/lang/NoSuchFieldException;
    :catch_1
    move-exception v2

    .local v2, "iae":Ljava/lang/IllegalArgumentException;
    const-string v6, "LgDataFeature"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "setIntegerFeatureValue(): Illegal value is assigned for "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ", value : "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v2    # "iae":Ljava/lang/IllegalArgumentException;
    :catch_2
    move-exception v3

    .local v3, "ipe":Ljava/lang/IllegalAccessException;
    const-string v6, "LgDataFeature"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "setIntegerFeatureValue(): "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " is not accessible"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v3    # "ipe":Ljava/lang/IllegalAccessException;
    :catch_3
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v6, "LgDataFeature"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "setIntegerFeatureValue(): Exception found for "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method

.method public setStringFeatureValue(Ljava/lang/String;Ljava/lang/String;)V
    .locals 9
    .param p1, "featureName"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .prologue
    :try_start_0
    const-class v6, Lcom/android/internal/telephony/lgdata/LgDataFeature;

    invoke-virtual {v6, p1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    .local v1, "field":Ljava/lang/reflect/Field;
    invoke-virtual {v1}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Class;->isPrimitive()Z

    move-result v6

    if-nez v6, :cond_0

    invoke-virtual {v1}, Ljava/lang/reflect/Field;->getType()Ljava/lang/Class;

    move-result-object v6

    const-class v7, Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_0

    invoke-virtual {v1, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    .local v5, "old":Ljava/lang/String;
    invoke-virtual {v1, p0, p2}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    const-string v6, "LgDataFeature"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "setStringFeatureValue(): "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " is changed from "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " to "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NoSuchFieldException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_3

    .end local v1    # "field":Ljava/lang/reflect/Field;
    .end local v5    # "old":Ljava/lang/String;
    :cond_0
    :goto_0
    return-void

    :catch_0
    move-exception v4

    .local v4, "nsfe":Ljava/lang/NoSuchFieldException;
    const-string v6, "LgDataFeature"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "setStringFeatureValue(): There is no such field "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, v4}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v4    # "nsfe":Ljava/lang/NoSuchFieldException;
    :catch_1
    move-exception v2

    .local v2, "iae":Ljava/lang/IllegalArgumentException;
    const-string v6, "LgDataFeature"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "setStringFeatureValue(): Illegal value is assigned for "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ", value : "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .end local v2    # "iae":Ljava/lang/IllegalArgumentException;
    :catch_2
    move-exception v3

    .local v3, "ipe":Ljava/lang/IllegalAccessException;
    const-string v6, "LgDataFeature"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "setStringFeatureValue(): "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, " is not accessible"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v3    # "ipe":Ljava/lang/IllegalAccessException;
    :catch_3
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    const-string v6, "LgDataFeature"

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "setStringFeatureValue(): Exception found for "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v6, v7, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method

.method public test()V
    .locals 8

    .prologue
    const-string v5, "LGP_DATA_TETHER_BLOCK_GOOGLE_DNS"

    invoke-virtual {p0, v5}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getBooleanFeatureValue(Ljava/lang/String;)Z

    const-string v5, "LgDataFeature"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "LPP_TEST: 1. LGP_DATA_TETHER_BLOCK_GOOGLE_DNS is: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    sget-object v7, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TETHER_BLOCK_GOOGLE_DNS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v7}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->saveFeatures()V

    const-string v5, "LGP_DATA_TETHER_BLOCK_GOOGLE_DNS"

    const/4 v6, 0x1

    invoke-virtual {p0, v5, v6}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->setBooleanFeatureValue(Ljava/lang/String;Z)V

    const-string v5, "LgDataFeature"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "LPP_TEST: 2. LGP_DATA_TETHER_BLOCK_GOOGLE_DNS is: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    sget-object v7, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TETHER_BLOCK_GOOGLE_DNS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v7}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->loadFeatures()V

    const-string v5, "LgDataFeature"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "LPP_TEST: 3. LGP_DATA_TETHER_BLOCK_GOOGLE_DNS is: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    sget-object v7, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_TETHER_BLOCK_GOOGLE_DNS:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v7}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getAllFeatureNames()[Ljava/lang/String;

    move-result-object v1

    .local v1, "features":[Ljava/lang/String;
    move-object v0, v1

    .local v0, "arr$":[Ljava/lang/String;
    array-length v3, v0

    .local v3, "len$":I
    const/4 v2, 0x0

    .local v2, "i$":I
    :goto_0
    if-ge v2, v3, :cond_0

    aget-object v4, v0, v2

    .local v4, "s":Ljava/lang/String;
    const-string v5, "LgDataFeature"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "LPP_TEST: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " found"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .end local v4    # "s":Ljava/lang/String;
    :cond_0
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .local v0, "sb":Ljava/lang/StringBuilder;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " FeatureSet Type: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget v2, Lcom/android/internal/telephony/lgdata/LgDataFeature;->sFeatureSet:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method
