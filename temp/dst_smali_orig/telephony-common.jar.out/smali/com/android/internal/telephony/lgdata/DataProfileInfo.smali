.class public final Lcom/android/internal/telephony/lgdata/DataProfileInfo;
.super Lcom/android/internal/telephony/dataconnection/DataProfile;
.source "DataProfileInfo.java"


# static fields
.field private static final LOG_TAG:Ljava/lang/String; = "[LGE_DATA] "

.field private static PDP_TYPE_IPV4:I = 0x0

.field private static PDP_TYPE_IPV4V6:I = 0x0

.field private static PDP_TYPE_IPV6:I = 0x0

.field private static PROFILE_ATT_DEFAULT:I = 0x0

.field private static PROFILE_ATT_EMERGENCY:I = 0x0

.field private static PROFILE_ATT_IMS:I = 0x0

.field private static PROFILE_CMCC_DEFAULT:I = 0x0

.field private static PROFILE_CMCC_IMS:I = 0x0

.field private static PROFILE_DEFAULT:I = 0x0

.field private static PROFILE_DUN:I = 0x0

.field private static PROFILE_EMERGENCY:I = 0x0

.field private static PROFILE_FOTA:I = 0x0

.field private static PROFILE_IMS:I = 0x0

.field private static PROFILE_INITIAL_ATTACH:I = 0x0

.field public static final PROFILE_KDDI_ADMIN:I = 0x2

.field public static final PROFILE_KDDI_DEFAULT:I = 0x1

.field public static final PROFILE_KDDI_DUN:I = 0x4

.field public static final PROFILE_KDDI_IMS:I = 0x3

.field public static final PROFILE_KR_DEFAULT:I = 0x2

.field public static final PROFILE_KR_IMS:I = 0x1

.field public static final PROFILE_KR_INITIAL_ATTACH:I = 0x1

.field public static PROFILE_OPEN_DEFAULT:I = 0x0

.field public static PROFILE_OPEN_IMS:I = 0x0

.field private static PROFILE_SPCS_DEFAULT:I = 0x0

.field private static PROFILE_SPCS_DUN:I = 0x0

.field private static PROFILE_SPCS_FOTA:I = 0x0

.field private static PROFILE_TMUS_DEFAULT:I = 0x0

.field private static PROFILE_TMUS_IMS:I = 0x0

.field private static PROFILE_USC_DEFAULT:I = 0x0

.field private static PROFILE_USC_IMS:I = 0x0

.field private static PROFILE_USC_USCAPP:I = 0x0

.field public static final PROFILE_VZW800:I = 0x5

.field public static final PROFILE_VZWAPP:I = 0x4

.field public static final PROFILE_VZW_ADMIN:I = 0x2

.field public static final PROFILE_VZW_DEFAULT:I = 0x3

.field public static final PROFILE_VZW_EMERGENCY:I = 0x6

.field public static final PROFILE_VZW_IMS:I = 0x1

.field public static final VZW_DATA_PROFILE_ADMIN:I = 0x2

.field public static final VZW_DATA_PROFILE_DEFAULT:I = 0x3

.field public static final VZW_DATA_PROFILE_EMERGENCY:I = 0x6

.field public static final VZW_DATA_PROFILE_IMS:I = 0x1

.field public static final VZW_DATA_PROFILE_VZW800:I = 0x5

.field public static final VZW_DATA_PROFILE_VZWAPP:I = 0x4

.field private static featureSet:I


# instance fields
.field public KT_LTE_IMS_APN:Ljava/lang/String;

.field public SKT_LTE_IMS_APN:Ljava/lang/String;

.field public SKT_LTE_Roaming_APN:Ljava/lang/String;

.field public UPLUS_LTE_IMS_APN:Ljava/lang/String;

.field public ehrpdProfileId:I

.field public emergencyPDN:Z

.field public inactivityTimer:I

.field public pcscfNeeded:Z

.field private roaming:Z

.field public triggerEsmInfoRequest:Z


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/4 v3, 0x3

    const/4 v2, 0x2

    const/4 v1, 0x1

    const/4 v0, 0x0

    sput v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PDP_TYPE_IPV4:I

    sput v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PDP_TYPE_IPV6:I

    sput v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PDP_TYPE_IPV4V6:I

    sput v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    sput v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_IMS:I

    sput v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_DEFAULT:I

    sput v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_FOTA:I

    const/4 v0, 0x4

    sput v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_DUN:I

    const/4 v0, 0x6

    sput v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_EMERGENCY:I

    sput v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_DEFAULT:I

    sput v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_FOTA:I

    sput v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_DUN:I

    sput v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_TMUS_DEFAULT:I

    sput v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_TMUS_IMS:I

    sput v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_ATT_DEFAULT:I

    sput v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_ATT_IMS:I

    sput v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_ATT_EMERGENCY:I

    sput v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_USC_DEFAULT:I

    sput v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_USC_IMS:I

    sput v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_USC_USCAPP:I

    sput v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_CMCC_DEFAULT:I

    sput v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_CMCC_IMS:I

    sput v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_OPEN_DEFAULT:I

    sput v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_OPEN_IMS:I

    return-void
.end method

.method public constructor <init>()V
    .locals 12

    .prologue
    const/4 v1, 0x1

    const/4 v4, 0x0

    const-string v2, ""

    const-string v3, ""

    const-string v5, ""

    const-string v6, ""

    move-object v0, p0

    move v7, v1

    move v8, v4

    move v9, v4

    move v10, v4

    move v11, v1

    invoke-direct/range {v0 .. v11}, Lcom/android/internal/telephony/dataconnection/DataProfile;-><init>(ILjava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;IIIIZ)V

    const-string v0, "lte-roaming.sktelecom.com"

    iput-object v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->SKT_LTE_Roaming_APN:Ljava/lang/String;

    const-string v0, "ims"

    iput-object v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->SKT_LTE_IMS_APN:Ljava/lang/String;

    const-string v0, "ims.ktfwing.com"

    iput-object v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->KT_LTE_IMS_APN:Ljava/lang/String;

    const-string v0, "imsv6.lguplus.co.kr"

    iput-object v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->UPLUS_LTE_IMS_APN:Ljava/lang/String;

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getInstance()Lcom/android/internal/telephony/lgdata/LgDataFeature;

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getFeatureSet()I

    move-result v0

    sput v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    return-void
.end method

.method public constructor <init>(ILjava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;ZZZIZZIII)V
    .locals 13
    .param p1, "profileId"    # I
    .param p2, "apn"    # Ljava/lang/String;
    .param p3, "protocol"    # Ljava/lang/String;
    .param p4, "authType"    # I
    .param p5, "user"    # Ljava/lang/String;
    .param p6, "password"    # Ljava/lang/String;
    .param p7, "pcscfNeeded"    # Z
    .param p8, "esmInfo"    # Z
    .param p9, "emergencyPDN"    # Z
    .param p10, "inactivityTimer"    # I
    .param p11, "enabled"    # Z
    .param p12, "roaming"    # Z
    .param p13, "maxConns"    # I
    .param p14, "maxConnsTime"    # I
    .param p15, "waitTime"    # I

    .prologue
    const/4 v8, 0x1

    move-object v1, p0

    move v2, p1

    move-object v3, p2

    move-object/from16 v4, p3

    move/from16 v5, p4

    move-object/from16 v6, p5

    move-object/from16 v7, p6

    move/from16 v9, p14

    move/from16 v10, p13

    move/from16 v11, p15

    move/from16 v12, p11

    invoke-direct/range {v1 .. v12}, Lcom/android/internal/telephony/dataconnection/DataProfile;-><init>(ILjava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;IIIIZ)V

    const-string v1, "lte-roaming.sktelecom.com"

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->SKT_LTE_Roaming_APN:Ljava/lang/String;

    const-string v1, "ims"

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->SKT_LTE_IMS_APN:Ljava/lang/String;

    const-string v1, "ims.ktfwing.com"

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->KT_LTE_IMS_APN:Ljava/lang/String;

    const-string v1, "imsv6.lguplus.co.kr"

    iput-object v1, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->UPLUS_LTE_IMS_APN:Ljava/lang/String;

    move/from16 v0, p12

    iput-boolean v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->roaming:Z

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getInstance()Lcom/android/internal/telephony/lgdata/LgDataFeature;

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getFeatureSet()I

    move-result v1

    sput v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->needEhrpdProfileUpdate()Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x0

    :goto_0
    iput v1, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->type:I

    move/from16 v0, p7

    iput-boolean v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->pcscfNeeded:Z

    move/from16 v0, p8

    iput-boolean v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->triggerEsmInfoRequest:Z

    move/from16 v0, p9

    iput-boolean v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->emergencyPDN:Z

    move/from16 v0, p10

    iput v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->inactivityTimer:I

    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->getEhrpdProfileID()I

    move-result v1

    iput v1, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->ehrpdProfileId:I

    return-void

    :cond_0
    const/4 v1, 0x1

    goto :goto_0
.end method

.method public constructor <init>(Lcom/android/internal/telephony/dataconnection/ApnSetting;Z)V
    .locals 13
    .param p1, "dp"    # Lcom/android/internal/telephony/dataconnection/ApnSetting;
    .param p2, "roaming"    # Z

    .prologue
    const/4 v12, 0x0

    const/4 v7, 0x1

    iget v1, p1, Lcom/android/internal/telephony/dataconnection/ApnSetting;->profileId:I

    iget-object v2, p1, Lcom/android/internal/telephony/dataconnection/ApnSetting;->apn:Ljava/lang/String;

    if-eqz p2, :cond_5

    iget-object v3, p1, Lcom/android/internal/telephony/dataconnection/ApnSetting;->roamingProtocol:Ljava/lang/String;

    :goto_0
    iget v0, p1, Lcom/android/internal/telephony/dataconnection/ApnSetting;->authType:I

    const/4 v4, -0x1

    if-ne v0, v4, :cond_6

    move v4, v12

    :goto_1
    iget-object v5, p1, Lcom/android/internal/telephony/dataconnection/ApnSetting;->user:Ljava/lang/String;

    iget-object v6, p1, Lcom/android/internal/telephony/dataconnection/ApnSetting;->password:Ljava/lang/String;

    iget v8, p1, Lcom/android/internal/telephony/dataconnection/ApnSetting;->maxConnsTime:I

    iget v9, p1, Lcom/android/internal/telephony/dataconnection/ApnSetting;->maxConns:I

    iget v10, p1, Lcom/android/internal/telephony/dataconnection/ApnSetting;->waitTime:I

    iget-boolean v11, p1, Lcom/android/internal/telephony/dataconnection/ApnSetting;->carrierEnabled:Z

    move-object v0, p0

    invoke-direct/range {v0 .. v11}, Lcom/android/internal/telephony/dataconnection/DataProfile;-><init>(ILjava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;IIIIZ)V

    const-string v0, "lte-roaming.sktelecom.com"

    iput-object v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->SKT_LTE_Roaming_APN:Ljava/lang/String;

    const-string v0, "ims"

    iput-object v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->SKT_LTE_IMS_APN:Ljava/lang/String;

    const-string v0, "ims.ktfwing.com"

    iput-object v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->KT_LTE_IMS_APN:Ljava/lang/String;

    const-string v0, "imsv6.lguplus.co.kr"

    iput-object v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->UPLUS_LTE_IMS_APN:Ljava/lang/String;

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getInstance()Lcom/android/internal/telephony/lgdata/LgDataFeature;

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getFeatureSet()I

    move-result v0

    sput v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    iput-boolean p2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->roaming:Z

    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->needEhrpdProfileUpdate()Z

    move-result v0

    if-eqz v0, :cond_7

    move v0, v12

    :goto_2
    iput v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->type:I

    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->needPcscfAddrRequest()Z

    move-result v0

    iput-boolean v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->pcscfNeeded:Z

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PCSCF_INTERFACE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->pcscfNeeded:Z

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->apn:Ljava/lang/String;

    const-string v1, "ims"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->apn:Ljava/lang/String;

    const-string v1, "IMS"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    iput-boolean v7, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->pcscfNeeded:Z

    :cond_1
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->needTriggerEsmInfoRequest()Z

    move-result v0

    iput-boolean v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->triggerEsmInfoRequest:Z

    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_EMERGENCY:I

    if-eq v0, v1, :cond_2

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    const/4 v1, 0x4

    if-ne v0, v1, :cond_3

    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_ATT_EMERGENCY:I

    if-ne v0, v1, :cond_3

    :cond_2
    move v12, v7

    :cond_3
    iput-boolean v12, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->emergencyPDN:Z

    invoke-virtual {p0, p1}, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->getInactivityTimer(Lcom/android/internal/telephony/dataconnection/ApnSetting;)I

    move-result v0

    iput v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->inactivityTimer:I

    sget-object v0, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_APN_INACTIVETIEMR_SPRINT:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v0}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v0

    if-eqz v0, :cond_4

    iget v0, p1, Lcom/android/internal/telephony/dataconnection/ApnSetting;->inactivityTimer:I

    iput v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->inactivityTimer:I

    :cond_4
    invoke-virtual {p0}, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->getEhrpdProfileID()I

    move-result v0

    iput v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->ehrpdProfileId:I

    return-void

    :cond_5
    iget-object v3, p1, Lcom/android/internal/telephony/dataconnection/ApnSetting;->protocol:Ljava/lang/String;

    goto/16 :goto_0

    :cond_6
    iget v4, p1, Lcom/android/internal/telephony/dataconnection/ApnSetting;->authType:I

    goto/16 :goto_1

    :cond_7
    move v0, v7

    goto :goto_2
.end method

.method public static getModemProfileID(I[Ljava/lang/String;)I
    .locals 8
    .param p0, "featureSet"    # I
    .param p1, "types"    # [Ljava/lang/String;

    .prologue
    const/4 v1, 0x2

    const/4 v2, 0x4

    const/4 v0, 0x3

    const/4 v4, 0x1

    const/4 v3, -0x1

    if-eqz p1, :cond_0

    array-length v5, p1

    if-eqz v5, :cond_0

    const-string v5, "*"

    invoke-static {p1, v5}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_0

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getInstance()Lcom/android/internal/telephony/lgdata/LgDataFeature;

    move-result-object v5

    iget v5, v5, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    if-nez v5, :cond_3

    :cond_0
    if-ne p0, v4, :cond_2

    :cond_1
    :goto_0
    return v0

    :cond_2
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    goto :goto_0

    :cond_3
    const-string v5, "DataProfileInfo"

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "["

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "] <<< "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " >>>"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/telephony/Rlog;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-ne p0, v4, :cond_9

    const-string v4, "default"

    invoke-static {p1, v4}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_1

    const-string v0, "ims"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_IMS:I

    goto :goto_0

    :cond_4
    const-string v0, "admin"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    move v0, v1

    goto :goto_0

    :cond_5
    const-string v0, "vzwapp"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    move v0, v2

    goto :goto_0

    :cond_6
    const-string v0, "vzw800"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_7

    const/4 v0, 0x5

    goto :goto_0

    :cond_7
    const-string v0, "emergency"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_8

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_EMERGENCY:I

    goto :goto_0

    :cond_8
    move v0, v3

    goto :goto_0

    :cond_9
    const/16 v5, 0x9

    if-ne p0, v5, :cond_e

    const-string v0, "ia"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_a

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    goto :goto_0

    :cond_a
    const-string v0, "default"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_b

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_DEFAULT:I

    goto/16 :goto_0

    :cond_b
    const-string v0, "fota"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_c

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_FOTA:I

    goto/16 :goto_0

    :cond_c
    const-string v0, "dun"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_d

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_DUN:I

    goto/16 :goto_0

    :cond_d
    move v0, v3

    goto/16 :goto_0

    :cond_e
    const/16 v5, 0xb

    if-ne p0, v5, :cond_12

    const-string v0, "ia"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_f

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    goto/16 :goto_0

    :cond_f
    const-string v0, "default"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_10

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_TMUS_DEFAULT:I

    goto/16 :goto_0

    :cond_10
    const-string v0, "ims"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_11

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_TMUS_IMS:I

    goto/16 :goto_0

    :cond_11
    move v0, v3

    goto/16 :goto_0

    :cond_12
    const/16 v5, 0x8

    if-ne p0, v5, :cond_17

    const-string v5, "default"

    invoke-static {p1, v5}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_13

    const-string v5, "*"

    invoke-static {p1, v5}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_14

    :cond_13
    move v0, v4

    goto/16 :goto_0

    :cond_14
    const-string v4, "admin"

    invoke-static {p1, v4}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_15

    move v0, v1

    goto/16 :goto_0

    :cond_15
    const-string v1, "ims"

    invoke-static {p1, v1}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    const-string v0, "dun"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_16

    move v0, v2

    goto/16 :goto_0

    :cond_16
    move v0, v3

    goto/16 :goto_0

    :cond_17
    if-ne p0, v2, :cond_1c

    const-string v0, "ia"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_18

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    goto/16 :goto_0

    :cond_18
    const-string v0, "default"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_19

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_ATT_DEFAULT:I

    goto/16 :goto_0

    :cond_19
    const-string v0, "ims"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1a

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_ATT_IMS:I

    goto/16 :goto_0

    :cond_1a
    const-string v0, "emergency"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1b

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_ATT_EMERGENCY:I

    goto/16 :goto_0

    :cond_1b
    move v0, v3

    goto/16 :goto_0

    :cond_1c
    const/16 v0, 0x1c

    if-ne p0, v0, :cond_22

    const-string v0, "ia"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1d

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    goto/16 :goto_0

    :cond_1d
    const-string v0, "default"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1e

    const-string v0, "*"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1f

    :cond_1e
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_USC_DEFAULT:I

    goto/16 :goto_0

    :cond_1f
    const-string v0, "ims"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_20

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_USC_IMS:I

    goto/16 :goto_0

    :cond_20
    const-string v0, "usccapp"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_21

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_USC_USCAPP:I

    goto/16 :goto_0

    :cond_21
    move v0, v3

    goto/16 :goto_0

    :cond_22
    const/16 v0, 0x1b

    if-ne p0, v0, :cond_26

    const-string v0, "ia"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_23

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    goto/16 :goto_0

    :cond_23
    const-string v0, "default"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_24

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_CMCC_DEFAULT:I

    goto/16 :goto_0

    :cond_24
    const-string v0, "ims"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_25

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_CMCC_IMS:I

    goto/16 :goto_0

    :cond_25
    move v0, v3

    goto/16 :goto_0

    :cond_26
    const/16 v0, 0x1a

    if-ne p0, v0, :cond_29

    const-string v0, "ia"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_27

    const-string v0, "default"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_27

    const-string v0, "*"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_28

    :cond_27
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    goto/16 :goto_0

    :cond_28
    move v0, v3

    goto/16 :goto_0

    :cond_29
    const/16 v0, 0xf

    if-ne p0, v0, :cond_2e

    const-string v0, "ia"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2a

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    goto/16 :goto_0

    :cond_2a
    const-string v0, "default"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2b

    const-string v0, "*"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2c

    :cond_2b
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_OPEN_DEFAULT:I

    goto/16 :goto_0

    :cond_2c
    const-string v0, "ims"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2d

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_OPEN_IMS:I

    goto/16 :goto_0

    :cond_2d
    move v0, v3

    goto/16 :goto_0

    :cond_2e
    const-string v0, "ia"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2f

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    goto/16 :goto_0

    :cond_2f
    const-string v0, "ims"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_30

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_IMS:I

    goto/16 :goto_0

    :cond_30
    const-string v0, "default"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_33

    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getInstance()Lcom/android/internal/telephony/lgdata/LgDataFeature;

    move-result-object v0

    iget v0, v0, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    if-eqz v0, :cond_31

    const/16 v0, 0x8

    if-ne p0, v0, :cond_32

    :cond_31
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    goto/16 :goto_0

    :cond_32
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_DEFAULT:I

    goto/16 :goto_0

    :cond_33
    const-string v0, "fota"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_34

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_FOTA:I

    goto/16 :goto_0

    :cond_34
    const-string v0, "emergency"

    invoke-static {p1, v0}, Lcom/android/internal/util/ArrayUtils;->contains([Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_35

    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_EMERGENCY:I

    goto/16 :goto_0

    :cond_35
    sget v0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    goto/16 :goto_0
.end method

.method public static toParcel(Landroid/os/Parcel;[Lcom/android/internal/telephony/lgdata/DataProfileInfo;)Landroid/os/Parcel;
    .locals 4
    .param p0, "pc"    # Landroid/os/Parcel;
    .param p1, "dps"    # [Lcom/android/internal/telephony/lgdata/DataProfileInfo;

    .prologue
    const/4 v2, 0x1

    const/4 v3, 0x0

    if-nez p0, :cond_1

    const/4 p0, 0x0

    .end local p0    # "pc":Landroid/os/Parcel;
    :cond_0
    return-object p0

    .restart local p0    # "pc":Landroid/os/Parcel;
    :cond_1
    array-length v1, p1

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    array-length v1, p1

    if-ge v0, v1, :cond_0

    aget-object v1, p1, v0

    iget v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    aget-object v1, p1, v0

    iget-object v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->apn:Ljava/lang/String;

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    aget-object v1, p1, v0

    iget-object v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->protocol:Ljava/lang/String;

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    aget-object v1, p1, v0

    iget v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->authType:I

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    aget-object v1, p1, v0

    iget-object v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->user:Ljava/lang/String;

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    aget-object v1, p1, v0

    iget-object v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->password:Ljava/lang/String;

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    aget-object v1, p1, v0

    iget v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->type:I

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    aget-object v1, p1, v0

    iget v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->maxConnsTime:I

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    aget-object v1, p1, v0

    iget v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->maxConns:I

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    aget-object v1, p1, v0

    iget v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->waitTime:I

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    aget-object v1, p1, v0

    iget-boolean v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->enabled:Z

    if-eqz v1, :cond_2

    move v1, v2

    :goto_1
    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    aget-object v1, p1, v0

    iget-boolean v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->pcscfNeeded:Z

    if-eqz v1, :cond_3

    move v1, v2

    :goto_2
    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    aget-object v1, p1, v0

    iget-boolean v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->triggerEsmInfoRequest:Z

    if-eqz v1, :cond_4

    move v1, v2

    :goto_3
    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    aget-object v1, p1, v0

    iget-boolean v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->emergencyPDN:Z

    if-eqz v1, :cond_5

    move v1, v2

    :goto_4
    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    aget-object v1, p1, v0

    iget v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->inactivityTimer:I

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    aget-object v1, p1, v0

    iget v1, v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->ehrpdProfileId:I

    invoke-virtual {p0, v1}, Landroid/os/Parcel;->writeInt(I)V

    add-int/lit8 v0, v0, 0x1

    goto/16 :goto_0

    :cond_2
    move v1, v3

    goto :goto_1

    :cond_3
    move v1, v3

    goto :goto_2

    :cond_4
    move v1, v3

    goto :goto_3

    :cond_5
    move v1, v3

    goto :goto_4
.end method


# virtual methods
.method public getEhrpdProfileID()I
    .locals 7

    .prologue
    const/4 v6, 0x2

    const/4 v5, 0x1

    const/16 v1, 0x68

    const/16 v2, 0x67

    const/16 v0, 0x66

    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    if-ne v3, v5, :cond_5

    iget v3, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v4, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_IMS:I

    if-ne v3, v4, :cond_1

    :cond_0
    :goto_0
    return v0

    :cond_1
    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    if-ne v0, v6, :cond_2

    move v0, v1

    goto :goto_0

    :cond_2
    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_3

    move v0, v2

    goto :goto_0

    :cond_3
    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    const/4 v1, 0x4

    if-ne v0, v1, :cond_4

    const/16 v0, 0x65

    goto :goto_0

    :cond_4
    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    const/4 v1, 0x5

    if-ne v0, v1, :cond_f

    const/16 v0, 0x69

    goto :goto_0

    :cond_5
    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    const/16 v4, 0x9

    if-ne v3, v4, :cond_c

    const-string v3, "ro.product.board"

    invoke-static {v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "msm8994"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_a

    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    if-ne v0, v1, :cond_6

    const/16 v0, 0xa

    goto :goto_0

    :cond_6
    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_DEFAULT:I

    if-ne v0, v1, :cond_7

    const/16 v0, 0xa

    goto :goto_0

    :cond_7
    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_FOTA:I

    if-ne v0, v1, :cond_8

    const/16 v0, 0xb

    goto :goto_0

    :cond_8
    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_DUN:I

    if-ne v0, v1, :cond_9

    const/16 v0, 0xc

    goto :goto_0

    :cond_9
    const/16 v0, 0x9

    goto :goto_0

    :cond_a
    iget v3, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v4, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    if-eq v3, v4, :cond_0

    iget v3, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v4, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_DEFAULT:I

    if-eq v3, v4, :cond_0

    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_FOTA:I

    if-ne v0, v3, :cond_b

    move v0, v2

    goto :goto_0

    :cond_b
    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_DUN:I

    if-ne v0, v2, :cond_f

    move v0, v1

    goto :goto_0

    :cond_c
    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    const/16 v4, 0x8

    if-ne v3, v4, :cond_f

    iget v3, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    if-eq v3, v5, :cond_0

    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    if-ne v0, v6, :cond_d

    move v0, v1

    goto/16 :goto_0

    :cond_d
    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_e

    move v0, v2

    goto/16 :goto_0

    :cond_e
    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    const/4 v1, 0x4

    if-ne v0, v1, :cond_f

    const/16 v0, 0x65

    goto/16 :goto_0

    :cond_f
    iget v0, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    add-int/lit8 v0, v0, 0x64

    goto/16 :goto_0
.end method

.method public getInactivityTimer(Lcom/android/internal/telephony/dataconnection/ApnSetting;)I
    .locals 3
    .param p1, "profile"    # Lcom/android/internal/telephony/dataconnection/ApnSetting;

    .prologue
    const/4 v0, 0x0

    .local v0, "inactivityTimer":I
    sget v1, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    packed-switch v1, :pswitch_data_0

    :goto_0
    :pswitch_0
    return v0

    :pswitch_1
    const/16 v0, 0x59f

    goto :goto_0

    :pswitch_2
    const/16 v0, 0xd98

    goto :goto_0

    :pswitch_3
    iget v1, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_SPCS_FOTA:I

    if-ne v1, v2, :cond_0

    const/16 v0, 0xf

    goto :goto_0

    :cond_0
    iget v0, p1, Lcom/android/internal/telephony/dataconnection/ApnSetting;->inactivityTimer:I

    goto :goto_0

    :pswitch_4
    iget v1, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    const/4 v2, 0x3

    if-ne v1, v2, :cond_1

    const/4 v0, 0x0

    goto :goto_0

    :cond_1
    const/16 v0, 0x3c

    goto :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_2
        :pswitch_4
        :pswitch_3
    .end packed-switch
.end method

.method public needEhrpdProfileUpdate()Z
    .locals 4

    .prologue
    const/4 v0, 0x0

    const/4 v1, 0x1

    sget v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    if-ne v2, v1, :cond_2

    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_EMERGENCY:I

    if-ne v2, v3, :cond_1

    :cond_0
    :goto_0
    return v0

    :cond_1
    move v0, v1

    goto :goto_0

    :cond_2
    sget v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    const/16 v3, 0x9

    if-eq v2, v3, :cond_3

    sget v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    const/16 v3, 0x8

    if-eq v2, v3, :cond_3

    sget v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    const/16 v3, 0x1a

    if-ne v2, v3, :cond_0

    :cond_3
    move v0, v1

    goto :goto_0
.end method

.method public needPcscfAddrRequest()Z
    .locals 5

    .prologue
    const/16 v4, 0x8

    const/4 v1, 0x1

    const/4 v0, 0x0

    sget v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    const/16 v3, 0x9

    if-ne v2, v3, :cond_1

    :cond_0
    :goto_0
    return v0

    :cond_1
    sget v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    const/16 v3, 0xb

    if-ne v2, v3, :cond_3

    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_TMUS_IMS:I

    if-eq v2, v3, :cond_2

    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_EMERGENCY:I

    if-ne v2, v3, :cond_0

    :cond_2
    move v0, v1

    goto :goto_0

    :cond_3
    sget v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    const/4 v3, 0x4

    if-ne v2, v3, :cond_5

    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_ATT_IMS:I

    if-eq v2, v3, :cond_4

    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_ATT_EMERGENCY:I

    if-eq v2, v3, :cond_4

    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->apn:Ljava/lang/String;

    const-string v3, "ims"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_4

    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->apn:Ljava/lang/String;

    const-string v3, "IMS"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    :cond_4
    move v0, v1

    goto :goto_0

    :cond_5
    sget v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    if-ne v2, v4, :cond_6

    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    const/4 v3, 0x3

    if-ne v2, v3, :cond_0

    move v0, v1

    goto :goto_0

    :cond_6
    sget v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    const/16 v3, 0x1b

    if-ne v2, v3, :cond_8

    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_CMCC_IMS:I

    if-eq v2, v3, :cond_7

    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_EMERGENCY:I

    if-ne v2, v3, :cond_0

    :cond_7
    move v0, v1

    goto :goto_0

    :cond_8
    sget v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    const/16 v3, 0xf

    if-ne v2, v3, :cond_c

    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_OPEN_IMS:I

    if-eq v2, v3, :cond_9

    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_EMERGENCY:I

    if-ne v2, v3, :cond_a

    :cond_9
    move v0, v1

    goto :goto_0

    :cond_a
    sget-object v2, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_PCSCF_INTERFACE_FOR_IA_TYPE:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v2}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v2

    if-eqz v2, :cond_0

    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_INITIAL_ATTACH:I

    if-ne v2, v3, :cond_0

    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->apn:Ljava/lang/String;

    if-eqz v2, :cond_b

    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->apn:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_0

    :cond_b
    move v0, v1

    goto/16 :goto_0

    :cond_c
    invoke-static {}, Lcom/android/internal/telephony/lgdata/LgDataFeature;->getInstance()Lcom/android/internal/telephony/lgdata/LgDataFeature;

    move-result-object v2

    iget v2, v2, Lcom/android/internal/telephony/lgdata/LgDataFeature;->MPDNset:I

    if-lez v2, :cond_0

    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_EMERGENCY:I

    if-eq v2, v3, :cond_d

    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_IMS:I

    if-eq v2, v3, :cond_d

    sget v2, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    if-ne v2, v4, :cond_0

    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_DEFAULT:I

    if-ne v2, v3, :cond_0

    :cond_d
    move v0, v1

    goto/16 :goto_0
.end method

.method public needTriggerEsmInfoRequest()Z
    .locals 6

    .prologue
    const/4 v1, 0x0

    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    const/16 v4, 0xb

    if-ne v3, v4, :cond_1

    iget v3, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    sget v4, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->PROFILE_TMUS_DEFAULT:I

    if-ne v3, v4, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    sget-object v3, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->LGP_DATA_DATACONNECTION_USIM_MOBILITY:Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;

    invoke-virtual {v3}, Lcom/android/internal/telephony/lgdata/LgDataFeature$DataFeature;->getValue()Z

    move-result v3

    if-eqz v3, :cond_8

    const/4 v2, 0x0

    .local v2, "triggerEsmInfoRequestForMobility":I
    const-string v3, "ril.card_operator"

    const-string v4, ""

    invoke-static {v3, v4}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .local v0, "networkOperator":Ljava/lang/String;
    const/4 v1, 0x0

    .local v1, "retval":Z
    const-string v3, "[LGE_DATA] "

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[USIM Mobility] needTriggerEsmInfoRequest(), networkOperator["

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "], apn["

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->apn:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "], roaming["

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-boolean v5, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->roaming:Z

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "]"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v3, "SKT"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    iget-object v3, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->apn:Ljava/lang/String;

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->SKT_LTE_IMS_APN:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    iget-object v3, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->apn:Ljava/lang/String;

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->SKT_LTE_Roaming_APN:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    :cond_2
    const-string v3, "[LGE_DATA] "

    const-string v4, "[USIM Mobility] [Domestic region]"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto :goto_0

    :cond_3
    const-string v3, "[LGE_DATA] "

    const-string v4, "[USIM Mobility] Other cases, return true"

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x1

    goto :goto_0

    :cond_4
    const-string v3, "KT"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_6

    iget-object v3, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->apn:Ljava/lang/String;

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->KT_LTE_IMS_APN:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_5

    iget-boolean v3, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->roaming:Z

    if-nez v3, :cond_5

    const-string v3, "[LGE_DATA] "

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[USIM Mobility] "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " Operator, EsmInfoRequest returns false in domestic network with default APN."

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto/16 :goto_0

    :cond_5
    const-string v3, "[LGE_DATA] "

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[USIM Mobility] "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " Operator, EsmInfoRequest returns true in other cases."

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x1

    goto/16 :goto_0

    :cond_6
    const-string v3, "LGU"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    iget-object v3, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->apn:Ljava/lang/String;

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->UPLUS_LTE_IMS_APN:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_7

    iget-boolean v3, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->roaming:Z

    if-nez v3, :cond_7

    const-string v3, "[LGE_DATA] "

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[USIM Mobility] "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " Operator, EsmInfoRequest returns false in domestic network with default APN."

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x0

    goto/16 :goto_0

    :cond_7
    const-string v3, "[LGE_DATA] "

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[USIM Mobility] "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " Operator, EsmInfoRequest returns true in other cases."

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v1, 0x1

    goto/16 :goto_0

    .end local v0    # "networkOperator":Ljava/lang/String;
    .end local v1    # "retval":Z
    .end local v2    # "triggerEsmInfoRequestForMobility":I
    :cond_8
    sget v3, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->featureSet:I

    const/4 v4, 0x6

    if-ne v3, v4, :cond_9

    iget-object v3, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->apn:Ljava/lang/String;

    iget-object v4, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->SKT_LTE_Roaming_APN:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_9

    iget-boolean v3, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->roaming:Z

    if-nez v3, :cond_0

    :cond_9
    const/4 v1, 0x1

    goto/16 :goto_0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .prologue
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string v1, "[DataProfileInfo] "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->profileId:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->apn:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->protocol:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->authType:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->user:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->password:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->type:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->enabled:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->maxConns:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->maxConnsTime:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->waitTime:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->pcscfNeeded:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->triggerEsmInfoRequest:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-boolean v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->emergencyPDN:Z

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->inactivityTimer:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/android/internal/telephony/lgdata/DataProfileInfo;->ehrpdProfileId:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method
